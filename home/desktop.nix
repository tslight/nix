{ config, pkgs, ... }:

{
  imports = [ ./home.nix ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = [
    pkgs.aspell
    pkgs.aspellDicts.en
    pkgs.aspellDicts.en-science
    pkgs.aspellDicts.en-computers
    pkgs.brightnessctl
    pkgs.emacs-pgtk
    pkgs.fuzzel
    pkgs.imagemagick
    pkgs.kitty
    pkgs.playerctl
    pkgs.swaylock
    pkgs.swayidle
    pkgs.waybar
    pkgs.wlsunset
  ];

  home.file = {
    ".config/emacs/init.el".source = dotfiles/init.el;
    ".config/fuzzel/fuzzel.ini".source = dotfiles/fuzzel.ini;
    ".config/niri/config.kdl".source = dotfiles/niri.kdl;
    ".config/waybar/config.jsonc".source = dotfiles/waybar/config.jsonc;
    ".config/waybar/style.css".source = dotfiles/waybar/style.css;
    ".config/waybar/power_menu.xml".source = dotfiles/waybar/power_menu.xml;
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
    settings = {
      "tabs.position" = "left";
      "tabs.show" = "never";
    };
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://wiki.nixos.org/index.php?search={}";
      g = "https://www.google.com/search?hl=en&amp;q={}";
    };
  };
}
