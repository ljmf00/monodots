{ config, lib, pkgs, inputs, ... }:
  with lib;
{
  nix = {
    channel.enable = true;

    settings.auto-optimise-store = true;
    settings.experimental-features = [
      "nix-command" "flakes"
    ];
    settings.keep-outputs = true;
    settings.keep-derivations = true;
    settings.download-buffer-size = 67108864 * 2;

    optimise.automatic = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8"
  ];
  # nixpkgs.config.replaceStdenv = ({ pkgs }: pkgs.fastStdenv);
}
