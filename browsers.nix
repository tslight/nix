{ pkgs, ... }:

{
  # https://discourse.nixos.org/t/librewolf-138-programs-firefox-policies-is-still-broken/64225
  environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";
  programs.firefox = { # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
    enable = true;
    package = pkgs.librewolf;
    policies = { # https://mozilla.github.io/policy-templates/
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
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          installation_mode = "force_installed";
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
    preferences = { # about:config
      "browser.ctrlTab.sortByRecentlyUsed" = true;
      "browser.engagement.ctrlTab.has-used" = true;
      "browser.engagement.sidebar-button.has-used" = true;
      "browser.safebrowsing.downloads.remote.block_dangerous" = true;
      "browser.safebrowsing.downloads.remote.block_dangerous_host" = true;
      "browser.safebrowsing.malware.enabled" = true;
      "browser.safebrowsing.phishing.enabled" = true;
      "browser.toolbarbuttons.introduced.sidebar-button" = true;
      "browser.theme.dark-private-windows" = true;
      "cookiebanners.service.mode" = 2; # Block cookie banners
      "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
      "dom.security.https_only_mode_ever_enabled" = true;
      "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      "privacy.annotate_channels.strict_list.enabled" = true;
      "privacy.bounceTrackingProtection.hasMigratedUserActivationData" = true;
      "privacy.bounceTrackingProtection.mode" = 1;
      "privacy.clearOnShutdown.cache" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "privacy.clearOnShutdown.formdata" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.sessions" = false;
      "privacy.clearOnShutdown.siteSettings" = false;
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
      "privacy.clearOnShutdown_v2.cache" = false;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
      "privacy.clearOnShutdown_v2.formdata" = false;
      "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
      "privacy.clearOnShutdown_v2.siteSettings" = false;
      "privacy.donottrackheader.enabled" = true;
      "privacy.fingerprintingProtection" = true;
      "privacy.globalprivacycontrol.was_ever_enabled" = true;
      "privacy.resistFingerprinting" = true;
      "privacy.trackingprotection.allow_list.convenience.enabled" = false;
      "privacy.trackingprotection.emailtracking.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.fingerprinting.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "sidebar.new-sidebar.has-used" = true;
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
      "webgl.disabled" = false;
    };
  };

  programs.chromium = {
    enable = true;
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # bitwarden
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # privacy badger
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
    ];
    extraOpts = {
      "AdvancedProtectionAllowed" = true;
      "BlockThirdPartyCookies" = true;
      "BrowserSignin" = 0;
      "BrowserThemeColor" = "#000000";
      "DnsOverHttpsMode" = "automatic";
      "HttpsOnlyMode" = "allowed";
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "en-GB"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    chromium # for some bizarre reason needs to be here too
  ];
}
