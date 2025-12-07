{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # https://wiki.nixos.org/wiki/Storage_optimization
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };
  # free up to 1GiB whenever there is less than 100MiB left
  nix.extraOptions = ''
  min-free = ${toString (100 * 1024 * 1024)}
  max-free = ${toString (1024 * 1024 * 1024)}
'';
  nix.optimise.automatic = true; # reduce disk usage of /nix
  nix.optimise.dates = [ "03:00" ]; # optimisation schedule

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  # Internationalisation properties.
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
    font = "ter-v20b";
    packages = with pkgs; [ terminus_font ];
    keyMap = "uk";
  };

  services.journald.extraConfig = "SystemMaxUse=200M";
  # You may need to run this in order to make trim work on encrypted partitions
  # sudo cryptsetup --allow-discards --persistent refresh luks-b1f65770-0746-40ad-a557-cdd31604771f
  services.fstrim.enable = true;
  services.locate.enable = true;
  services.openssh.enable = true;
  security.rtkit.enable = true;

  # Don't forget to set a password with ‘passwd’.
  users.users.anon = {
    isNormalUser = true;
    description = "Friend of Bill";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  programs.nano.enable = false; # vomit

  environment.systemPackages = with pkgs; [ git tmux ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
