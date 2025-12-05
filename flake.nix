{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/25.11";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      enigma = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./enigma/hardware-configuration.nix
          ./configuration.nix
          ./browsers.nix
        ];
      };
      genesis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./genesis/hardware-configuration.nix
          ./configuration.nix
          ./browsers.nix
        ];
      };
    };
  };
}
