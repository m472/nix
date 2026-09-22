{
  description = "Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    };

    touchpadctl = {
      url = "github:m472/touchpadctl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      touchpadctl,
      rose-pine-hyprcursor,
      nixvim,
      nixos-hardware,
      ...
    }@inputs:

    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          (_final: _prev: {
            touchpadctl = touchpadctl.outputs.packages.${system}.default;
            rose-pine-hyprcursor = rose-pine-hyprcursor.packages.${system}.default;
          })
        ];
      };

      systemConfig =
        {
          hostName,
          extraModules ? [ ],
        }:
        let
          shortHost = lib.strings.removePrefix "nixos-" hostName;
        in
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit
              inputs
              hostName
              ;
          };
          modules = [
            ./hosts/${shortHost}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                backupFileExtension = "backup";
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit nixvim; };
                users.matz = import ./hosts/${shortHost}/home.nix;
              };
            }
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        nixos-macbook = systemConfig {
          hostName = "nixos-macbook";
          extraModules = [
            nixos-hardware.nixosModules.apple-t2
          ];
        };
        nixos-desktop = systemConfig { hostName = "nixos-desktop"; };
        nixos-work = systemConfig { hostName = "nixos-work"; };
      };
    };
}
