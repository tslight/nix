{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixpkgs }: {
    nixosConfigurations = {
      enigma = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./enigma/hardware-configuration.nix
          ./laptop.nix
        ];
      };
      genesis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./genesis/hardware-configuration.nix
          ./laptop.nix
        ];
      };
    };
  };
}
