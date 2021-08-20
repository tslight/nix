{ config, pkgs, ... }: {
  networking = {
    hostName = "probook";
    networkmanager.enable = true;
    useDHCP = false;
  };
}
