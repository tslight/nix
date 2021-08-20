/*

This is a nix expression to build Emacs and some Emacs packages I like from
source on any distribution where Nix is installed. This will install all the
dependencies from the nixpkgs repository and build the binary files without
interfering with the host distribution.

To build the project, type the following from the current directory:

$ nix-build emacs.nix

To run the newly compiled executable:

$ ./result/bin/emacs

Querying Emacs packages:

nix-env -f "<nixpkgs>" -qaP -A emacsPackages.elpaPackages
nix-env -f "<nixpkgs>" -qaP -A emacsPackages.melpaPackages
nix-env -f "<nixpkgs>" -qaP -A emacsPackages.melpaStablePackages
nix-env -f "<nixpkgs>" -qaP -A emacsPackages.orgPackages

*/
{ pkgs ? import <nixpkgs> {} }:

let
  myEmacs = (pkgs.emacs.override {
    # Setting both of these to false, falls back to lucid toolkit
    # withGTK3 = false;
    # withGTK2 = false;
  }).overrideAttrs (attrs: {
    # I don't want emacs.desktop file because I only use
    # emacsclient.
    postInstall = (attrs.postInstall or "") + ''
      # rm $out/share/applications/emacs.desktop
      # echo "Hello Emacs!!"
    '';
  });
  emacsWithPackages = (pkgs.emacsPackagesGen myEmacs).emacsWithPackages;
in
emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
  # use-package
]) ++ (with epkgs.elpaPackages; [
  # undo-tree
]))
