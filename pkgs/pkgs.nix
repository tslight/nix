{ pkgs ? import <nixpkgs> {} }:
let
  myPkgs = [
    pkgs.alttab
    pkgs.ansible
    pkgs.azure-cli
    pkgs.bat
    pkgs.brave # https://github.com/brave/brave-browser/issues/1986
    pkgs.broot
    # pkgs.chromium
    pkgs.docker
    pkgs.docker-compose
    pkgs.emacs
    pkgs.exa
    pkgs.fast-cli
    # pkgs.firefox
    pkgs.glibcLocales
    # pkgs.go
    pkgs.home-manager
    pkgs.mitscheme # choose between this and chez
    pkgs.nix
    pkgs.nix-bash-completions
    pkgs.nix-prefetch-scripts
    pkgs.nix-zsh-completions
    pkgs.nixops
    pkgs.nixpkgs-lint
    # pkgs.powershell
    pkgs.ranger
    pkgs.terraform
    pkgs.tmux
    pkgs.youtube-dl
  ];
in myPkgs
