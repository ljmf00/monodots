{ config, lib, pkgs, inputs, ... }:
  with lib;
{
  boot.binfmt.emulatedSystems = [
    "wasm32-wasip1"
    "wasm64-wasip1"

    "armv7l-linux"
    "aarch64-linux"

    "riscv32-linux"
    "riscv64-linux"
  ];
}
