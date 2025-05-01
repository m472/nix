{
  description = "Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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

    openconnect-sso = {
      url = "github:m472/openconnect-sso";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, touchpadctl, rose-pine-hyprcursor, nixvim
    , openconnect-sso, ... }:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          (_final: _prev: {
            touchpadctl = touchpadctl.outputs.packages.${system}.default;
            rose-pine-hyprcursor =
              rose-pine-hyprcursor.packages.${system}.default;
            inherit (openconnect-sso.outputs.packages.${system})
              openconnect-sso;
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
                extraSpecialArgs = { inherit nixvim; };
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
                extraSpecialArgs = { inherit nixvim; };
                users.matz = import ./hosts/desktop/home.nix;
              };
            }
          ];
        };
      };
    };
}
