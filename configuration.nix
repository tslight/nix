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
  boot.initrd.luks.devices."luks-4da17729-a689-4796-bf9d-5df51c3e5934".device = "/dev/disk/by-uuid/4da17729-a689-4796-bf9d-5df51c3e5934";

  networking.hostName = "enigma";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Enable networking
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

  console.keyMap = "uk";
  console.font = "Lat2-Terminus16";

  services.upower = {
    enable = true;
    criticalPowerAction = "PowerOff";
    percentageAction = 10;
    percentageCritical = 15;
    percentageLow = 20;
  };
  services.udev.extraHwdb = ''
  evdev:input:b0011v0001p0001*
    KEYBOARD_KEY_01=capslock
    KEYBOARD_KEY_3a=esc
    KEYBOARD_KEY_b8=leftctrl
    KEYBOARD_KEY_38=leftctrl
    KEYBOARD_KEY_b7=leftalt
    KEYBOARD_KEY_db=leftalt
    KEYBOARD_KEY_9d=leftmeta
    KEYBOARD_KEY_1d=leftmeta
  '';
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

  # Don't forget to set a password with ‘passwd’.
  users.users.tobe = {
    isNormalUser = true;
    description = "~Not Toe Bee";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  # autologin on tty1
  systemd.services."getty@tty1" = {
    overrideStrategy = "asDropin";
    serviceConfig.ExecStart = [
      "" "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${config.services.getty.loginProgram} --autologin tobe --noclear --keep-baud %I 115200,38400,9600 $TERM"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  programs.niri.enable = true;
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
    htop
    inxi
    jq
    kitty
    librewolf
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
