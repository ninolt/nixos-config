{
  description = "Flake for my small Linux laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      # Referencing our download of nixpkgs for home-manager
      inputs.nixpkgs.follows = "nixpkgs";
    };

	agenix = {
      url = "github:ryantm/agenix";
      # Agenix's now references to our download of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
      # Disable darwin deps (dedicated to MacOS)
      inputs.darwin.follows = "";
    };

    swayfx = {
      url = "github:WillPower3309/swayfx";
      # Referencing our download of nixpkgs for swayfx
      inputs.nixpkgs.follows = "nixpkgs";
    };

	spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      # Referencing our download of nixpkgs for spicetify-nix
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    extraSpecialArgs = { inherit system; inherit inputs; };
    specialArgs = { inherit system; inherit inputs; };
  in
  {
    nixosConfigurations.nixos = lib.nixosSystem {
      inherit specialArgs;

      modules = [
        ./configuration.nix

		inputs.agenix.nixosModules.default

        home-manager.nixosModules.home-manager {
          home-manager = {
            inherit extraSpecialArgs;
            useGlobalPkgs = true;
            useUserPackages = true;
            users.nino = import ./home/home.nix;
          };
        }
      ];
    };
  };
}
