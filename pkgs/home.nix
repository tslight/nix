# https://rycee.gitlab.io/home-manager/options.html
{ pkgs, ... }: {
  imports = [
    ./home/bash.nix
    ./home/browsers.nix
    ./home/emacs.nix
    ./home/git.nix
    ./home/gtk.nix
    ./home/readline.nix
    ./home/tmux.nix
    ./home/xsession.nix
  ];

  # https://github.com/rycee/home-manager/issues/432
  home.extraOutputsToInstall = [ "man" ];
  programs.man.enable = false;
}
