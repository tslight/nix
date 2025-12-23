{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
      configuration = import ./config.nix {
        inherit pkgs system;
        configurationRevision = self.rev or self.dirtyRev or null;
      };
    in
      {
        darwinConfigurations."hexley" = nix-darwin.lib.darwinSystem {
          modules = [ configuration ];
        };
      };
}
