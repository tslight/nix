{ inputs, outputs, stateVersion, ... }: {
  # Helper function for generating host configs
  mkHost = { hostname, platform ? "x86_64-linux", modules ? [] }:
    inputs.nixpkgs.lib.nixosSystem {
      system = "${platform}";
      specialArgs = { inherit hostname inputs outputs stateVersion; };
      modules = modules ++ [
        # https://www.reddit.com/r/NixOS/comments/y1xo2u/how_to_create_an_iso_with_my_config_files/
        (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
        ./nixos/${hostname}/configuration.nix
      ];
    };

  # Helper function for generating home-manager configs
  mkHome = { os, type, platform ? "x86_64-linux" }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = { inherit inputs outputs stateVersion; };
      modules = [ ./home-manager/${os}/${type}.nix ];
    };
}
