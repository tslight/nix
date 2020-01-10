{ config, pkgs, ... }: {
  services = {
    openssh.enable = true;
    printing.enable = true;
    tlp.enable = true;
  };
}
