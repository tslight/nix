{ pkgs, ... }:
{
  imports = [ ./desktop.nix ];

  programs.emacs.package = pkgs.emacs-gtk;
}
