{ config, lib, pkgs, inputs, ... }:
  with lib;
let
  # Helper utility for launching Steam games from Sunshine. This works around
  # issue where Sunshine's security wrapper prevents Steam from launching.
  # Examples:
  #   steam-run-url steam://rungameid/1086940  # Start Baldur's Gate 3
  #   steam-run-url steam://open/bigpicture    # Start Steam in Big Picture mode
  steam-run-url = pkgs.writeShellApplication {
    name = "steam-run-url";
    text = ''
      echo "$1" > "/run/user/$(id --user)/steam-run-url.fifo"
    '';
    runtimeInputs = [
      pkgs.coreutils # For `id` command
    ];
  };
in {
  programs.steam = {
    enable = true;
  };

  systemd.user.services.sunshine = {
    description = "Self-hosted game stream host for Moonlight";
    path = [steam-run-url]; # Allow running `steam-run-url` from Sunshine without knowing the script's
    wantedBy = ["graphical.target"];
    partOf = ["graphical.target"];
    wants = ["graphical.target"];
    after = ["graphical.target"];

    serviceConfig = {
      ExecStop = "${pkgs.procps}/bin/pkill -SIGTERM -f sunshine";
      ExecStopPost = "${pkgs.procps}/bin/pkill -SIGKILL -f sunshine";
      KillSignal = "SIGTERM";
      Restart = "on-failure";
      TimeoutStopSec = "10s";
      KillMode = "mixed";
      type = "simple";
    };
  };

  systemd.user.services.steam-run-url-service = {
    enable = true;
    description = "Listen and starts steam games by id";
    wantedBy = ["default.target"];
    partOf = ["default.target"];
    wants = ["default.target"];
    after = ["default.target"];
    serviceConfig.Restart = "on-failure";
    script = toString (pkgs.writers.writePython3 "steam-run-url-service" {} ''
      import os
      from pathlib import Path
      import subprocess

      pipe_path = Path(f'/run/user/{os.getuid()}/steam-run-url.fifo')
      try:
          pipe_path.parent.mkdir(parents=True, exist_ok=True)
          pipe_path.unlink(missing_ok=True)
          os.mkfifo(pipe_path, 0o600)
          steam_env = os.environ.copy()
          steam_env["QT_QPA_PLATFORM"] = "wayland"
          steam_env["DISPLAY"] = ":0"
          while True:
              with pipe_path.open(encoding='utf-8') as pipe:
                  subprocess.Popen(['steam', pipe.read().strip()], env=steam_env)
      finally:
          pipe_path.unlink(missing_ok=True)
    '');
    path = [
      pkgs.gamemode
      pkgs.steam
    ];
  };

  nixpkgs.config.cudaSupport = true;

  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
    applications = {
      env = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };
      # apps = [
      #   {
      #     name = "Steam Big Picture";
      #     image-path = "steam.png";
      #     prep-cmd = [
      #       {
      #         undo = "steam-run-url steam://close/bigpicture";
      #       }
      #     ];
      #     detached = [ "steam-run-url steam://close/bigpicture" ];
      #     auto-detach = "true";
      #     wait-all = "true";
      #     exit-timeout = "5";
      #   }
      # ];
    };
  };

  # security.wrappers.sunshine = {
  #   owner = "root";
  #   group = "root";
  #   capabilities = "cap_sys_admin+p";
  #   source = "${pkgs.sunshine}/bin/sunshine";
  # };

  # services.avahi.publish.enable = true;
  # services.avahi.publish.userServices = true;

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    steam-run-url

    steamcmd
    steam-run

    (heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
      ];
    })
    lutris
  ];
    
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
  ];
}
