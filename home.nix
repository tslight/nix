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
    programs.emacs = {
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

    programs.firefox = {
      extensions = [
        "https-everywhere"
        "last-pass"
        "privacy-badger"
        "ublock-origin"
        "vim-vixen"
      ];
    };

    programs.git = {
      enable = true;
      userName  = "Toby Slight";
      userEmail = "tslight@pm.me";
    };
  };
}
