{
  description = "A Naive Nix Flake Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hardware.url = "github:nixos/nixos-hardware";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs"; # ...
  };

  outputs = {self, nixpkgs, home-manager, nixos-hardware, darwin, ...} @ inputs:
    let
      inherit (self) outputs;
      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      stateVersion = "23.05";
      # https://github.com/wimpysworld/nix-config
      libx = import ./default.nix {inherit inputs outputs stateVersion;};
    in {
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        cardiel = libx.mkHost { hostname = "cardiel"; };
        nightwolf = libx.mkHost { hostname = "nightwolf"; };
        terence = libx.mkHost {
          hostname = "terence";
          modules = [nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1];
        };
        enigma = libx.mkHost { hostname = "enigma"; };
        porridge = libx.mkHost { hostname = "porridge"; };
        martin = libx.mkHost { hostname = "porridge"; platform = "aarch64-linux"; };
      };

      # Available through 'nix build .#darwinConfigurations.$(HOST).system --extra-experimental-features "nix-command flakes"`
      # ./result/sw/bin/darwin-rebuild switch --flake .
      darwinConfigurations = {
        hexley = darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
          modules = [ ./darwin/hexley/configuration.nix ]; # will be important Available
        };
      };

      # later through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "toby@cardiel" = libx.mkHome { os = "linux"; type = "desktop"; };
        "toby@nightwolf" = libx.mkHome { os = "linux"; type = "desktop"; };
        "toby@terence" = libx.mkHome { os = "linux"; type = "desktop"; };
        "toby@enigma" = libx.mkHome { os = "linux"; type = "desktop"; };
        "toby@porridge" = libx.mkHome { os = "linux"; type = "desktop"; };
        "toby@martin" = libx.mkHome { os = "linux"; type = "desktop"; platform = "aarch64-linux"; };
        "toby@hexley" = libx.mkHome { os = "darwin"; type = "home"; };
      };
    };
}
