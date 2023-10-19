{ inputs, outputs, stateVersion, ... }: {
  # Helper function for generating host configs
  mkHost = { hostname, platform ? "x86_64-linux", modules ? [] }:
    inputs.nixpkgs.lib.nixosSystem {
      system = "${platform}";
      specialArgs = { inherit inputs outputs stateVersion; };
      modules = modules ++ [./nixos/${hostname}/configuration.nix];
    };

  # Helper function for generating home-manager configs
  mkHome = { os, type, platform ? "x86_64-linux" }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = { inherit inputs outputs stateVersion; };
      modules = [ ./home-manager/${os}/${type}.nix ];
    };
}
