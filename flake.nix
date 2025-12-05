{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/25.11";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      # This should correspond to the hostname of the machine
      enigma = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./enigma/hardware-configuration.nix
        ];
      };
      genesis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./genesis/hardware-configuration.nix
        ];
      };
    };
  };
}
