# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  console = {
    earlySetup = true;
    font = "ter-v16b";
    packages = with pkgs; [ terminus_font ];
    keyMap = "uk";
  };

  services.upower = {
    enable = true;
    criticalPowerAction = "PowerOff";
    percentageAction = 10;
    percentageCritical = 15;
    percentageLow = 20;
  };

  # You may need to run this in order to make trim work on encrypted partitions
  # sudo cryptsetup --allow-discards --persistent refresh luks-b1f65770-0746-40ad-a557-cdd31604771f
  services.fstrim.enable = true;
  services.locate.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "niri-session";
        user = "tobe";
      };
      # By adding default_session it ensures you can still access the tty
      # terminal if you logout of your windows manager otherwise you would just
      # relaunch into it.
      default_session = {
        command = ''
        ${pkgs.tuigreet}/bin/tuigreet \
          --greeting "Welcome To NixOS" \
          --asterisks \
          --remember \
          --remember-session \
          --remember-user-session \
          --time \
          --cmd niri-session
        '';
        user = "greeter"; # DO NOT CHANGE THIS USER
      };
    };
  };

  # Don't forget to set a password with ‘passwd’.
  users.users.tobe = {
    isNormalUser = true;
    description = "~Not Toe Bee";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  programs.niri.enable = true;

  # https://discourse.nixos.org/t/librewolf-138-programs-firefox-policies-is-still-broken/64225
  environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";
  programs.firefox = { # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
    enable = true;
    package = pkgs.librewolf;
    policies = { # https://mozilla.github.io/policy-templates/
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
        Add = [
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
        ];
      };
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
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.sessions" = false;
      "privacy.clearOnShutdown.siteSettings" = false;
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
      "privacy.clearOnShutdown_v2.cache" = false;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
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

  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.en-science
    aspellDicts.en-computers
    brightnessctl
    chromium
    emacs-pgtk
    fastfetch
    fuzzel
    gcc
    git
    gnumake
    gptfdisk
    htop
    inxi
    jq
    kitty
    ncdu
    neovim
    playerctl
    swaylock
    swayidle
    tmux
    waybar
    wlsunset
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
