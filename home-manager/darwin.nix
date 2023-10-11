{ inputs, lib, config, pkgs, ...}: {
  imports = [ ./home.nix ];
  home = { username = "toby"; homeDirectory = "/Users/toby"; };
  xdg.configFile."/karabiner/karabiner.json".source = "karabiner.json";
  home.stateVersion = "23.05";
}
