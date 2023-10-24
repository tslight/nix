{ inputs, lib, config, pkgs, ...}: {
  imports = [ ./home.nix ];
  home.sessionVariables = {
    DEVPATH = "$HOME/oe-developers";
    CONF_ENV = "test";
  };
}
