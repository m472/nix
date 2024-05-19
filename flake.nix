{
  description = "Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
    in {
      nixosConfigurations = {
        macbookAir = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system; };
          modules = [
            ./configuration.nix
          ];
        };
      };

      homeConfiguration."matz" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        
        modules = [ ./home.nix ];
      };
    };
}
