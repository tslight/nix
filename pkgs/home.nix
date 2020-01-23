# https://rycee.gitlab.io/home-manager/options.html
{ pkgs, ... }: {
  imports = [
    ./programs/programs.nix
    ./programs/bash.nix
    ./programs/browsers.nix
    ./programs/emacs.nix
  ];

  # https://github.com/rycee/home-manager/issues/432
  home = {
    extraOutputsToInstall = [ "man" ];
  };

  gtk.gtk2.extraConfig = ''
      gtk-key-theme-name = "Emacs"
    '';

  gtk.gtk3.extraConfig = ''
      [Settings]
      gtk-key-theme-name = Emacs
    '';

  xsession = {
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };
}
