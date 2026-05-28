{ config, pkgs, lib, inputs, ...}:
  with lib;
{
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  virtualisation.podman = {
    enable = true;
  };

  environment.systemPackages = [ pkgs.distrobox ];

  # add support for emulating aarch64 containers for docker buildx support
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
