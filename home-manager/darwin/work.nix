{ inputs, lib, config, pkgs, ...}: {
  imports = [ ./home.nix ];
  home.sessionPath = [
    "/opt/homebrew/Caskroom/miniconda/base/bin" # aarch64 brew
    "/usr/local/homebrew/Caskroom/miniconda/base/bin" # amd64 brew
  ];
  home.sessionVariables = {
    DEVPATH = "$HOME/oe-developers";
    CONF_ENV = "test";
  };
}
