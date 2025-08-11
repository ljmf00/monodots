{ config, pkgs, lib, inputs, ...}:
let
  noSpecifiedDM =
    (builtins.length (builtins.filter (e: (builtins.match "^graphical-dm-.*" e) != null) config.sanix.features)) == 0;
in with lib;
{
  config = mkIf (
    (noSpecifiedDM) ||
    (builtins.elem "graphical-dm-gdm" config.sanix.features)
  ) {
    # Enable GDM
    services.displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
