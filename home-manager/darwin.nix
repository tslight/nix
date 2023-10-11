{ inputs, lib, config, pkgs, ...}: {
  imports = [ ./home.nix ];
  home = {
    username = "toby";
    homeDirectory = "/Users/toby";
  };
  home.stateVersion = "23.05";
}
