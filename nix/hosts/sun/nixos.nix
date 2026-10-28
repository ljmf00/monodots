{ config, lib, pkgs, inputs, ...}:
  with lib;
{
  imports = [
    ./../../modules/nixos/hardware/cpu/amd-zen4.nix
    ./../../modules/nixos/hardware/gpu/nvidia.nix
    ./../../modules/nixos/hardware/gpu/amd.nix

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

  nixpkgs.config = {
    cudaSupport = true;
    cudaCapabilities = [ "8.9" ];
    cudaForwardCompat = false;
  };

  boot.supportedFilesystems = [ "btrfs" ];

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

  boot.kernelModules = [
    # Wifi drivers for RTL8852BE
    "rtw88" "rtw89"
  ];

  # Sets a high amount of GTT size for LLM usage.
  boot.extraModprobeConfig = ''
    # Specified as 4KiB pages: 120 GB GTT.
    options ttm pages_limit=31457280

    # Specified as 4KiB pages: 60 GB pre-allocated.
    options ttm page_pool_size=15728640

    # `amdgpu gttsize' is deprecated and should not be used.
    # options amdgpu gttsize=120000
  '';

  services.ollama = {
    loadModels = [ "qwen3-coder:30b" ];
  };

  hardware.nvidia = {
    # PRIME offloading benefits from this when not used
    powerManagement.finegrained = true;

    prime = {
      offload = {
        enable = true;

        # provides `nvidia-offload`
        enableOffloadCmd = true;
      };

      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:12:0:0";
    };
  };
}
