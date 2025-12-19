{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/25.11";
  };

  outputs = { self, nixpkgs }: {
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
      cardiel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./cardiel/hardware-configuration.nix
          ./laptop.nix
       ];
      };
    };
};
}
