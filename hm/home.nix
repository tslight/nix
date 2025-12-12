{ config, pkgs, ... }:

{
  home.username = "anon";
  home.homeDirectory = "/home/anon";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.bat # cat
    pkgs.bottom # top
    pkgs.curl
    pkgs.dua # ncdu with dua i
    pkgs.dust # du
    pkgs.fd # find
    pkgs.jq
    pkgs.lsd # ls
    pkgs.lazygit
    pkgs.ripgrep # grep
    pkgs.tokei # linecount
    pkgs.wget
    pkgs.yazi # ranger
  ];

  home.file = {
    ".config/niri/config.kdl".source = dotfiles/niri.kdl;
    ".config/fuzzel/fuzzel.ini".source = dotfiles/fuzzel.ini;
  };

  home.sessionPath = [ "$HOME/bin" "$HOME/.local/bin" ];
  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = 1;
    EDITOR = "nvim";
    PAGER = "less";
    BLOCK_SIZE = "human-readable";
  };
  home.shellAliases = {
    cp = "cp -i";
    d = "docker";
    df = "df -h";
    du = "du -h";
    e = "emacs -nw";
    ec = "emacsclient -c -a '' -nw";
    g = "git";
    grep = "grep --color=always";
    h = "history";
    j = "jobs -l";
    k = "kubectl";
    lc = "tokei";
    l = "lsd";
    la = "lsd -a";
    ll = "lsd -l";
    lla = "lsd -la";
    lt = "lsd --tree";
    lg = "lazygit";
    m = "make";
    mkdir = "mkdir -p";
    mv = "mv -i";
    p = "pwd";
    pg = "pgrep -ail";
    ping4 = "ping -c 4";
    pingg = "ping -c 4 google.com";
    rm = "rm -i";
    se = "sudoedit";
    t = "tmux attach";
    tree = "lsd --tree";
    up = "uptime";
    vi = "nvim";
  };

  programs.bash = {
    enable = true;
    historyControl = [
      "erasedups"
      "ignoredups"
      "ignorespace"
    ];
    historyFileSize = 100000;
    historySize = 100000;
    shellOptions = [
      "autocd"
      "cdspell"
      "checkjobs"
      "checkwinsize"
      "cmdhist"
      "dirspell"
      "dotglob"
      "extglob"
      "globstar"
      "histappend"
      "nocaseglob"
    ];
  };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name  = "Toby Slight";
      user.email = "tslight@pm.me";
      alias = {
        a = "add";
        c = "commit -m";
        d = "diff";
        l = "log --graph --decorate --pretty=oneline --abbrev-commit";
        s = "status";
        f = "pull";
        p = "push";
      };
    };
    ignores = [
      ".DS_Store"
      ".localized"
      "desktop.ini"
      "*.swp"
      "*~"
      "#*#"
      "#*"
      "TAGS"
      "tags"
    ];
  };

  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+Tab" = "next_tab";
      "kitty_mod+Tab" = "previous_tab";
      "ctrl+Escape" = "goto_tab -1";
      "ctrl+equal" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
      "ctrl+0" = "change_font_size all 0";
      "cmd+c" = "copy_to_clipboard";
      "cmd+v" = "paste_from_clipboard";
    };
    settings = {
      font_size = 12;
      scrollback_lines = 10000;
      copy_on_select = "yes";
      strip_trailing_spaces = "smart";
      hide_window_decorations = "yes";
      clipboard_control = "write-clipboard write-primary no-append";
      macos_option_as_alt = "yes";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.readline.enable = true;
  programs.readline.bindings = {
    "\\en" = "history-search-forward";
    "\\ep" =  "history-search-backward";
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };
      # package.disabled = true;
    };
  };

  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    historyLimit = 100000;
    mouse = true;
    newSession = true;
    extraConfig = ''
  set -g message-style bg=default,fg=brightgreen
  set -g mode-style bg=default,fg=brightgreen
  set -g status-style bg=default,fg=brightgreen
  set -g window-status-style bold
  set -g window-status-current-style underscore,fg=brightyellow
  bind e neww -n fm yazi
  bind t neww -n top btm
'';
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    cdpath = [
      "$HOME"
      "$HOME/src"
      "$cdpath"
    ];
    completionInit = ''
      autoload -Uz compinit && compinit -u
      autoload -Uz bashcompinit && bashcompinit
      autoload -Uz colors && colors
      autoload -Uz history-search-end
      '';
    defaultKeymap = "emacs";
    dirHashes = {
      src = "$HOME/src";
    };
    dotDir = config.xdg.configHome + "/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    history.expireDuplicatesFirst = true;
    history.extended = true;
    history.ignoreDups = true;
    history.ignorePatterns = [ "ls *" "rm *" ];
    history.ignoreSpace = true;
    history.path = "$ZDOTDIR/history";
    history.save = 100000;
    history.share = true;
    history.size = 100000;
    historySubstringSearch.enable = true;
    historySubstringSearch.searchDownKey = ["^[[B"];
    historySubstringSearch.searchUpKey = ["^[[A"];
  };

  programs.librewolf = {
    enable = true;
    policies = {
      Cookies = {
        Allow = [
          "https://ebay.co.uk"
          "https://chatgpt.com"
          "https://youtube.com"
          "https://mail.proton.me"
          "https://amazon.co.uk"
          "https://reddit.com"
        ];
        Behaviour = "reject-tracker-and-partition-foreign";
        BehaviorPrivateBrowsing = "reject";
      };
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DNSOverHTTPS = {
        Enabled = true;
        Fallback = true;
      };
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        SuspectedFingerprinting = true;
        Category = "strict";
      };
      HttpsOnlyMode = "enabled";
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      ExtensionSettings = { # about:support
        "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          default_area = "menupanel";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          default_area = "menupanel";
        };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
      };
      SearchEngines = {
        Default = "DDG Lite";
        Add = [
          {
            Alias = "@aw";
            Description = "Arch Linux Wiki";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "Arch Wiki";
            URLTemplate = "https://wiki.archlinux.org/index.php?search={searchTerms}";
          }
          {
            Alias = "@dl";
            Description = "Duck Duck Go Lite";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "DDG Lite";
            URLTemplate = "https://start.duckduckgo.com/lite/?q={searchTerms}";
          }
          {
            Alias = "@ff";
            Description = "Frog Find Retro Computers";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "Frog Find";
            URLTemplate = "https://frogfind.com/?q={searchTerms}";
          }
          {
            Alias = "@n";
            Description = "Search in MyNixOS";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "My NixOS Site";
            URLTemplate = "https://mynixos.com/search?q={searchTerms}";
          }
          {
            Alias = "@np";
            Description = "Search in NixOS Packages";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "NixOS Packages";
            URLTemplate = "https://search.nixos.org/packages?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
          }
          {
            Alias = "@no";
            Description = "Search in NixOS Options";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "NixOS Options";
            URLTemplate = "https://search.nixos.org/options?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
          }
          {
            Alias = "@yt";
            Description = "YouTube Search";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "YouTube";
            URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
          }
        ];
        Remove = [
          "Google"
          "Bing"
        ];
        SearchSuggestEnabled = true;
      };
      ShowHomeButton = true;
    };
    settings = {
      "browser.ctrlTab.sortByRecentlyUsed" = true;
      "browser.safebrowsing.downloads.remote.block_dangerous" = true;
      "browser.safebrowsing.downloads.remote.block_dangerous_host" = true;
      "browser.safebrowsing.malware.enabled" = true;
      "browser.safebrowsing.phishing.enabled" = true;
      "browser.startup.blankWindow" = true;
      "browser.theme.dark-private-windows" = true;
      "cookiebanners.service.mode" = 2; # Block cookie banners
      "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
      "dom.security.https_only_mode_ever_enabled" = true;
      "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      "privacy.donottrackheader.enabled" = true;
      "privacy.fingerprintingProtection" = true;
      "privacy.resistFingerprinting" = true;
      "privacy.resistFingerprinting.letterboxing" = true;
      "privacy.sanitize.sanitizeOnShutdown" = false; # override librewolf default
      "privacy.trackingprotection.allow_list.convenience.enabled" = false;
      "privacy.trackingprotection.emailtracking.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.fingerprinting.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "sidebar.verticalTabs" = true; # doesn't currently work :-(
      "webgl.disabled" = true;
    };
  };
  programs.qutebrowser = {
    enable = true;
  };
}
