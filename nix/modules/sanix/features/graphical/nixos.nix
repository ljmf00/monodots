{ config, pkgs, lib, inputs, ...}:
  with lib;
{
  imports = [
    ./dm/nixos.nix

    ./gnome/nixos.nix
    ./hyprland/nixos.nix
  ];

  config = mkIf (
    (builtins.elem "graphical" config.sanix.features) ||
    (builtins.any (e: (builtins.match "^graphical-.*" e) != null) config.sanix.features)
  ) {
    services.libinput = {
      enable = true;

      # disabling mouse acceleration
      mouse = {
        accelProfile = "flat";
      };

      # disabling touchpad acceleration
      touchpad = {
        accelProfile = "flat";
        tapping = true;
      };
    };

    # Enable the X11 windowing system.
    services.xserver = {
      enable = true;

      xkb = {
        layout = "us";
      };
      libinput = {

      };
    };

    # fix issue with crash on login attempts
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    # Enable interfacing X11 with Wayland
    programs.xwayland.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
      MOZ_USE_XINPUT2 = "1";
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_DBUS_REMOTE = "1";
    };

    # Enable QT framework
    qt.enable = true;
    qt.style = "adwaita-dark";

    # Enable XDG icons
    xdg.icons.enable = true;

    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
        ];
      };
    };
  };
}
