{ inputs, lib, config, pkgs, ...}: {
  imports = [ ../home.nix ];

  home = {
    username = "toby";
    homeDirectory = "/home/toby";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
