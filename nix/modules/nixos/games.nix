{ config, lib, pkgs, inputs, ... }:
  with lib;
{
  programs.steam = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    steamcmd
    steam-run
  ];
    
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
  ];
}
