/*
This is a nix expression to build Emacs and some Emacs packages I like
from source on any distribution where Nix is installed. This will install
all the dependencies from the nixpkgs repository and build the binary files
without interfering with the host distribution.

To build the project, type the following from the current directory:

$ nix-build emacs.nix

To run the newly compiled executable:

$ ./result/bin/emacs
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
  ace-window
  ansible
  ansible-doc
  async
  avy
  change-inner
  cider
  clojure-mode
  clojure-snippets
  company
  company-go
  company-terraform
  counsel
  counsel-projectile
  diminish
  docker
  dockerfile-mode
  dot-mode
  emmet-mode
  exec-path-from-shell
  expand-region
  flx
  flycheck
  git-timemachine
  gitlab-ci-mode
  go-mode
  hungry-delete
  ibuffer-vc
  iedit
  ivy
  jedi
  js2-mode
  js2-refactor
  json-mode
  json-navigator
  magit
  markdown-mode
  nix-mode
  nodejs-repl
  org-journal
  paredit
  powershell
  projectile
  py-autopep8
  python-mode
  restclient
  slime
  slime-company
  smex
  ssh-agency
  systemd
  terraform-mode
  # undo-tree
  undo-fu
  # undo-fu-session
  undohist
  use-package
  web-mode
  wgrep
  which-key
  yaml-mode
  yasnippet
  yasnippet-snippets
]) ++ (with epkgs.elpaPackages; [
  undo-tree
]))
