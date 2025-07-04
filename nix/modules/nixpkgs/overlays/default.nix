{ config, pkgs, lib, inputs, ...}:
  with lib;
{
  imports = [
    ./musl.nix
    ./wayland.nix
    ./nur.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      OVMF = prev.OVMF.override {
        secureBoot = true;
        tpmSupport = true;
      };

      librewolf = (prev.librewolf.override {
        nativeMessagingHosts = [ final.gnome-browser-connector ];
      });
      librewolf-unwrapped = (prev.librewolf-unwrapped.override { pipewireSupport = true;});
    })
  ];
}
