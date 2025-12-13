{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixpkgs }: {
    nixosConfigurations = {
      enigma = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager {
            home-manager.useUserPackages = true;
            home-manager.users.anon = {
              imports = [
                ./home/default.nix
              ];
            };
          }
          ./enigma/hardware-configuration.nix
          ./laptop.nix
        ];
      };
      genesis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager {
            home-manager.useUserPackages = true;
            home-manager.users.anon = {
              imports = [
                ./home/default.nix
              ];
            };
          }
          ./genesis/hardware-configuration.nix
          ./laptop.nix
        ];
      };
    };
  };
}
