{ config, lib, pkgs, inputs, ... }:
  with lib;
{
  programs.steam = {
    enable = true;
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${pkgs.sunshine}/bin/sunshine";
  };

  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;

  environment.systemPackages = with pkgs; [
    steamcmd
    steam-run
  ];
    
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
  ];
}
