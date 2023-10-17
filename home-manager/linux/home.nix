{ inputs, lib, config, pkgs, ...}: {
  imports = [ ../home.nix ];

  home = {
    username = "toby";
    homeDirectory = "/home/toby";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion  =  "23.05";
}
