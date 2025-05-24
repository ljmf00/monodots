{ config, lib, pkgs, inputs, ... }:
let
  mkGenericDefault = lib.mkOverride 1100;
in with lib;
{
  services.kubo = {
    enable = false;
    enableGC = true;
    localDiscovery = true;
    settings = {
      Addresses.Gateway = [
        "/ip4/127.0.0.1/tcp/8080"
        "/ip6/::1/tcp/8080"
      ];
      Addresses.API = [
        "/ip4/127.0.0.1/tcp/5001"
        "/ip6/::1/tcp/5001"
      ];
      AutoNAT.ServiceMode = "enabled";
      Discovery.MDNS.Enabled = true;
    };
  };
}
