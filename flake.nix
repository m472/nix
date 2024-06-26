{
  description = "Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    touchpadctl.url = "github:m472/touchpadctl";
  };

  outputs = { nixpkgs, home-manager, touchpadctl, ... }:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          (_final: _prev: {
            touchpadctl = touchpadctl.outputs.packages.${system}.default;
          })
        ];
      };

    in {
      nixosConfigurations = {
        nixos-macbook = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./hosts/macbook/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                backupFileExtension = "backup";
                useGlobalPkgs = true;
                useUserPackages = true;
                users.matz = import ./hosts/macbook/home.nix;
              };
            }
          ];
        };
        nixos-desktop = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./hosts/desktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                backupFileExtension = "backup";
                useGlobalPkgs = true;
                useUserPackages = true;
                users.matz = import ./hosts/desktop/home.nix;
              };
            }
          ];
        };
      };
    };
}
