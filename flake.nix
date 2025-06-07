{
  description = "Flake for my small Linux laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # Referencing our download of nixpkgs for home-manager
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swayfx = {
      url = "github:WillPower3309/swayfx";
      # Referencing our download of nixpkgs for home-manager
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
