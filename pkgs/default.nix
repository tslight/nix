{ pkgs ? import <nixpkgs> {} }:
# default.nix
let
  # pkgs = import (import <nixpkgs>) {};

  # bashrc = …;
  # git = …;
  # tmux = …;
  # vim = …;

  myPkgs = [
    # Customized packages
    # bashrc
    # git
    # tmux
    # vim

    # Sourced directly from Nixpkgs
    # pkgs.curl
    # pkgs.htop
    pkgs.nix
    pkgs.pass
    # pkgs.tree
    # pkgs.xclip
  ];

in myPkgs
