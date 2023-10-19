{ inputs, lib, config, pkgs, ...}: {
  imports = [ ../desktop.nix ];
  home = { username = "toby"; homeDirectory = "/Users/toby"; };
  home.file.karabiner = {
    enable = true;
    source = ../assets/karabiner.json;
    target = ".config/karabiner/karabiner.json";
  };
}
