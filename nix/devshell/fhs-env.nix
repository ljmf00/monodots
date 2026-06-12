{ pkgs }:

let
  targetPkgs = with pkgs; [
    clang
    clang-tools
    gnumake
    cmake
    pkg-config
    bash
    coreutils
    findutils
    gnused
    gnugrep
    gawk
  ];

in
pkgs.buildFHSEnv {
  name = "monodots-dev-fhs";
  targetPkgs = _: targetPkgs;
  runScript = "bash";
  meta = with pkgs.lib; {
    description = "FHS development environment with clang and build tools";
    platforms = platforms.linux ++ platforms.darwin;
  };
}
