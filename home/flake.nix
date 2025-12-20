{
  description = "Home Manager configuration of anon";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
    in
      {
        homeConfigurations."anon" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ { nixpkgs.overlays = overlays; } ./default.nix ];
        };
      };
}
