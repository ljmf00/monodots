{
  description = "devtty63's dotfiles nix flake";

  inputs = {
    # packages
    nixpkgs.url              = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-nixos.url        = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url       = "github:nixos/nixpkgs/release-23.05";
    nixpkgs-staging-next.url = "github:NixOS/nixpkgs/staging-next";

    # secrets manager
    agenix.url = "github:ryantm/agenix";

    # community packages
    nur.url = "github:nix-community/nur";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # nixos community patches for wayland
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # operating system facilities
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # user configurations
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Be able to run external binaries
    nix-alien.url = "github:thiagokokada/nix-alien";

    # flake utilities
    flake-utils.url = "github:numtide/flake-utils";

    # compatibility layer
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, ... }@inputs:
    let
      # default values/parameters
      defaultSystem   = "x86_64-linux";
      defaultHostname = "generic";
      defaultUsername = "luis";

      # system parameters
      system = if builtins ? currentSystem
        then builtins.currentSystem
        else defaultSystem;
      hostname = let host = builtins.getEnv "HOSTNAME";
        in if builtins.stringLength host != 0 then host else defaultHostname;
      username = let user = builtins.getEnv "USER";
        in if builtins.stringLength user != 0 then user else defaultUsername;

      # alias to system-specific packages

      pkgs       = import inputs.nixpkgs { inherit system; };
      nixosPkgs  = import inputs.nixpkgs-nixos { inherit system; };
      stablePkgs = import inputs.nixpkgs-stable { inherit system; };
      nextPkgs   = import inputs.nixpkgs-staging-next { inherit system; };
      nativePkgs = import inputs.nixpkgs {
        overlays = [
          (self: super: {
            stdenv = super.impureUseNativeOptimizations super.stdenv;
          })
        ];
      };

      # =======================================================================

      mkSystem = pkgs: system: hostname: username:
        pkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs stablePkgs nextPkgs nativePkgs; };

          modules = [
            {
              networking.hostName = "${hostname}";

              nixpkgs.overlays = [
                (import ./nix/hosts/${hostname}/overlays.nix)
              ];
            }
            ./nix/modules
            ./nix/modules/nixos.nix
            ./nix/hosts/${hostname}
            ./nix/hosts/${hostname}/nixos.nix


            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = false;
                extraSpecialArgs = { inherit inputs stablePkgs nextPkgs; };

                users.${username} = {config, pkgs, ... }:
                {
                  imports = [
                    ./nix/modules
                    ./nix/modules/home.nix
                    ./nix/hosts/${hostname}
                    ./nix/hosts/${hostname}/home.nix
                  ];
                };
              };
            }
          ];
        };

    in {
      packages."x86_64-linux"."installer-iso" = (inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [ ./nix/installer ];
      }).config.formats.iso.config.system.build.isoImage;

      packages."x86_64-linux"."kernel" = (inputs.nixpkgs.lib.nixosSystem { system = "x86_64-linux"; modules = [ ./nix/kernel ]; }).pkgs.linuxPackages_custom.kernel;
      packages."aarch64-linux"."kernel" = (inputs.nixpkgs.lib.nixosSystem { system = "aarch64-linux"; modules = [ ./nix/kernel ]; }).pkgs.linuxPackages_custom.kernel;

      overlays.default = import ./nix/overlays.nix;
      nixosConfigurations.default = mkSystem inputs.nixpkgs-nixos "${defaultSystem}" "${defaultHostname}" "${defaultUsername}";

      nixosConfigurations.thinker = mkSystem inputs.nixpkgs-nixos "x86_64-linux" "thinker" "luis";
      nixosConfigurations.sun = mkSystem inputs.nixpkgs-nixos "x86_64-linux" "sun" "luis";

      homeConfigurations."${defaultUsername}" = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };

        modules = [
          { nixpkgs.overlays = [ (import ./nix/hosts/${defaultHostname}/overlays.nix) ]; }
          ./nix/modules
          ./nix/modules/home.nix
          ./nix/hosts/${defaultHostname}
          ./nix/hosts/${defaultHostname}/home.nix
        ];
      };
    };
}
