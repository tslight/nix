{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/25.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      hosts = [ "enigma" "genesis" "cardiel" "sahaja" ];
    in {
      nixosConfigurations = nixpkgs.lib.genAttrs hosts
        (name: nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./${name}/hardware-configuration.nix
            ./laptop.nix
          ];
        });
    };
}
