{ inputs, lib, config, pkgs, ...}: {
  imports = [ ./home.nix ];
  home = { username = "toby"; homeDirectory = "/Users/toby"; };
  home.file.karabiner = {
    enable = true;
    source = ./assets/karabiner.json;
    target = ".config/karabiner/karabiner.json";
  };
  home.file.iterm = {
    enable = true;
    source = ./assets/iterm.json;
    target = ".config/iterm2/profiles.json";
  };
  home.stateVersion = "23.05";
}
