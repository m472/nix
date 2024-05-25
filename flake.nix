{
  description = "Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      #url = "github:m472/home-manager";
      url = "/home/matz/devel/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    touchpadctl.url = "github:m472/touchpadctl";
  };

  outputs = { self, nixpkgs, home-manager, touchpadctl, ... }:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          (final: prev: {
            touchpadctl = touchpadctl.outputs.packages.${system}.default;
          })
        ];
      };
    in {
      nixosConfigurations = {
        nixos-macbook = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.matz = import ./home.nix;
            }
          ];
        };
      };
    };
}
