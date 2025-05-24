{ config, lib, pkgs, inputs, ...}:
  with lib;
{
  imports = [
    ./../../modules/nixos/hardware/cpu/amd-zen4.nix
    ./../../modules/nixos/hardware/gpu/nvidia.nix

    ./../../modules/nixos/hardware/efi/nonesp.nix

    # ./../../modules/nixos/hardware/boot/luks.nix
    # ./../../modules/nixos/hardware/boot/btrfs.nix
    # ./../../modules/nixos/hardware/boot/swap.nix

    ./../../modules/nixos/hardware/io/ssd-nvme.nix
    ./../../modules/nixos/hardware/virtualization.nix

    ./../../modules/nixos/unfree.nix

    ./../../profiles/nixos/pc.nix
    ./../../profiles/nixos/personal.nix

    ./../../profiles/sanix/pc.nix
  ];

  nix.settings.system-features = [ "nixos-test" "benchmark" "big-parallel" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/43e72ab1-b5cd-44ac-902f-6d8206a0f99f";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-ca9329a6-a8b2-484c-a2c7-d32bcdde3fae".device = "/dev/disk/by-uuid/ca9329a6-a8b2-484c-a2c7-d32bcdde3fae";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EAF6-1A62";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  
  swapDevices = [ ];

  boot.kernelModules = [ "rtw89" ];
}
