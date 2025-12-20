{
  description = "NixOS System Configuration";
  inputs = { nixpkgs.url = "nixpkgs/25.11"; };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      # Get all *.nix files in ./os/laptops
      files = builtins.attrNames
        (nixpkgs.lib.filterAttrs (_: type: type == "regular")
          (builtins.readDir ./os/laptops));
      # Strip the .nix suffix to be passed in as hostname
      hosts = map (f: nixpkgs.lib.removeSuffix ".nix" f) files;
    in {
      nixosConfigurations = nixpkgs.lib.genAttrs hosts
        (host: nixpkgs.lib.nixosSystem {
          specialArgs = { inherit host system; };
          modules = [ ./os/laptops/${host}.nix ];
        });
    };
}
