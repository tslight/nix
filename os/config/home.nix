# https://rycee.gitlab.io/home-manager/options.html

{ config, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "dff5f07952e61da708dc8b348ea677414e992215";
    ref = "release-19.09";
  };
in
{
  imports = [
    "${home-manager}/nixos"
  ];

  home-manager.users.toby = {
    gtk.gtk2.extraConfig = ''
      gtk-key-theme-name = "Emacs"
    '';

    gtk.gtk3.extraConfig = ''
      [Settings]
      gtk-key-theme-name = Emacs
    '';

    # home.file = {
    #   ".emacs.d" = {
    #     source = builtins.fetchGit {
    #       url = "https://gitlab.com/tspub/etc/emacs";
    #       rev = "80bd9f7fbbd43c6130ea74b1f6c419b40ca2a6cf";
    #       ref = "master";
    #     };
    #     recursive = true;
    #   };
    # };

    programs = {
      emacs = {
        enable = true;
        extraPackages = epkgs: [
          epkgs.ace-window
          epkgs.ansible
          epkgs.ansible-doc
          epkgs.async
          epkgs.avy
          epkgs.change-inner
          epkgs.cider
          epkgs.clojure-mode
          epkgs.clojure-snippets
          epkgs.company
          epkgs.company-go
          epkgs.company-terraform
          epkgs.counsel
          epkgs.counsel-projectile
          epkgs.diminish
          epkgs.docker
          epkgs.dockerfile-mode
          epkgs.dot-mode
          epkgs.emmet-mode
          epkgs.exec-path-from-shell
          epkgs.expand-region
          epkgs.flx
          epkgs.flycheck
          epkgs.git-timemachine
          epkgs.gitlab-ci-mode
          epkgs.go-mode
          epkgs.hungry-delete
          epkgs.ibuffer-vc
          epkgs.iedit
          epkgs.ivy
          epkgs.jedi
          epkgs.js2-mode
          epkgs.js2-refactor
          epkgs.json-mode
          epkgs.json-navigator
          epkgs.magit
          epkgs.markdown-mode
          epkgs.nix-mode
          epkgs.nodejs-repl
          epkgs.org-journal
          epkgs.paredit
          epkgs.powershell
          epkgs.projectile
          epkgs.py-autopep8
          epkgs.python-mode
          epkgs.restclient
          epkgs.slime
          epkgs.slime-company
          epkgs.smex
          epkgs.ssh-agency
          epkgs.systemd
          epkgs.terraform-mode
          epkgs.undo-tree
          epkgs.use-package
          epkgs.web-mode
          epkgs.wgrep
          epkgs.which-key
          epkgs.yaml-mode
          epkgs.yasnippet
          epkgs.yasnippet-snippets
        ];
      };

      firefox = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          https-everywhere
          privacy-badger
          ublock-origin
          vim-vixen
        ];
      };

      git = {
        enable = true;
        userName  = "Toby Slight";
        userEmail = "tslight@pm.me";
        aliases = {
          a = "add";
          aa = "add -A";
          ba = "branch -a";
          bd = "branch -d";
          b = "branch";
          c = "commit";
          ca = "commit -a";
          cl = "clone";
          cm = "commit -m";
          co = "checkout";
          l = "log --graph --decorate --pretty=oneline --abbrev-commit";
          m = "merge";
          P = "pull";
          p = "push";
          pa = "push --all -u";
          pm = "push origin master";
          po = "push origin";
          rb = "rebase";
          rv = "revert";
          r = "remote";
          s = "status";
          ua = "remote set-url --add --push origin";
          ud = "remote set-url --delete --push origin";
        };
        ignores = [
          "*~"
          "*.swp"
        ];
        extraConfig = {
          core = {
            autocrlf = false;
            whitespace = "trailing-space,space-before-tab";
          };
        };
      };
    };
  };
}
