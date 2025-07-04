{ config, pkgs, lib, inputs, ...}:
  with lib;
{
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  virtualisation.podman = {
    enable = true;
  };

  environment.systemPackages = [ pkgs.distrobox ];
}
