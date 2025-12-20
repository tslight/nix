{
  description = "Home Manager configuration of anon";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # can go when nvim 0.12
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # can go when nvim 0.12
      overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
      # Auto-discover all .nix files in modules/
      moduleFiles =
        builtins.filter
          (f: builtins.match ".*\\.nix$" f != null)
          (builtins.attrNames (builtins.readDir ./modules));

      modules = map (f: ./modules/${f}) moduleFiles;
    in
      {
        homeConfigurations."anon" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ { nixpkgs.overlays = overlays; } ] ++ modules;
        };
      };
}
