{ inputs, lib, config, pkgs, ...}: {
  imports = [ ./home.nix ];
  home = { username = "toby"; homeDirectory = "/Users/toby"; };
  home.file.karabiner = {
    enable = true;
    source = ./karabiner.json;
    target = ".config/karabiner/karabiner.json";
  };
  home.stateVersion = "23.05";
}
