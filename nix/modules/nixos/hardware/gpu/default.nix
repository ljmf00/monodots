{ config, lib, pkgs, inputs, ... }:
let
  mkGenericDefault = lib.mkOverride 1100;
in with lib;
{
  services.xserver.videoDrivers = mkGenericDefault [ "modesetting" "vesa" ];

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
      libva-utils
      vaapiVdpau
      vdpauinfo
      egl-wayland
      wgpu-utils
      libglvnd
      mesa
      libGL
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [ 
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
      libva-utils
      vdpauinfo
      egl-wayland
      wgpu-utils
      libglvnd
      mesa
      libGL
    ];
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.full

    libva-utils
    glxinfo

    vulkan-tools
    vulkan-validation-layers
  ];
}
