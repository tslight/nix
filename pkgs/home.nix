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
    sessionVariables = {
      BLOCK_SIZE = "human-readable";
      EDITOR = "emacsclient -c -nw";
      ALTERNATE_EDITOR = "";
      GCC_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
      PAGER = "bat";
      GTK_THEME = "Emacs";
      GOPATH = "$HOME/go";
      ANSIBLE = "$HOME/src/tspub/devops/ansible";
      DEVPATH = "$HOME/src/oe-developers";
      DEVOPS = "$HOME/src/oe-developers/be/devops";
      PATH = "$HOME/conda/bin:$HOME/.local/bin:$DEVOPS/bin:$HOME/bin:$PATH";
      XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
    };
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
