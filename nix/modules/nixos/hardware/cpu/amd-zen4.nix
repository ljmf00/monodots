{ config, lib, pkgs, inputs, ... }:
let
  mkGenericDefault = lib.mkOverride 1100;
in with lib;
{
  imports = [
    ./amd-pstate.nix
    ./amd-kvm.nix
  ];

  nix.settings.system-features = [ "gccarch-znver4" "gccarch-x86-64-v4" ];

  # nixpkgs.localSystem = {
  #   gcc.arch = "znver4";
  #   gcc.tune = "znver4";
  # };
}
