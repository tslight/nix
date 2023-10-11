{ inputs, lib, config, pkgs, ...}: {
  imports = [ ./home.nix ];
  home = {
    username = "toby";
    homeDirectory = "/Users/toby";
  };
  home.packages = [ pkgs.emacs29 ];
  home.stateVersion = "23.05";
}
