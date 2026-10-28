{ config, lib, pkgs, inputs, ... }:
let
  mkGenericDefault = lib.mkOverride 1100;
in with lib;
{
  imports = [
    ./.
  ];

  # boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "amdgpu" ];

  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];

  nixpkgs.config.rocmSupport = true;
  hardware.amdgpu.opencl.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" "radeon" ];

  hardware.graphics.extraPackages = with pkgs; (
      if pkgs ? rocmPackages.clr
      then with pkgs.rocmPackages; [ clr clr.icd ]
      else with pkgs; [ rocm-opencl-icd rocm-opencl-runtime ]
    );

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true; # Replaced 'driSupport32Bit'
}
