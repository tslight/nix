{
  description = "Nix Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = {self, nixpkgs, home-manager, nixos-hardware, ...} @ inputs: let
    inherit (self) outputs;
  in {
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      cardiel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [./nixos/cardiel/configuration.nix];
      };
      nightwolf = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [./nixos/nightwolf/configuration.nix];
      };
      terence = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
          ./nixos/terence/configuration.nix
        ];
      };
      enigma = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/enigma/configuration.nix
        ];
      };
      martin = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [./nixos/martin/configuration.nix];
      };
      hexley = nixpkgs.lib.nixosSystem {
        system = "aarch64-darwin";
        specialArgs = {inherit inputs outputs;};
        modules = [./nixos/Tobys-MacBook-Pro.local/configuration.nix];
      };
    };

    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "toby@cardiel" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [ ./home-manager/home.nix ];
      };
      "toby@nightwolf" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [ ./home-manager/home.nix ];
      };
      "toby@terence" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [ ./home-manager/home.nix ];
      };
      "toby@enigma" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [ ./home-manager/home.nix ];
      };
      "toby@martin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [ ./home-manager/home.nix ];
      };
      "toby@hexley" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}
