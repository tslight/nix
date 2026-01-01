{ pkgs, configRev ? null, system, ... }:
let user = "anon"; in
{
  imports = [
    (import ./system.nix { user = user; })
    ../common/emacs.nix
  ];

  nix.enable = false;

  system.primaryUser = user;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.allowUnfree = true;

  programs.emacs.package = pkgs.emacs-macport;

  environment.systemPackages = with pkgs; [
    bash
    coreutils
    curl
    dua # ncdu with dua i
    fd # find
    fzf
    jq
    ripgrep # grep
    tokei # linecount
    wget
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = configRev;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = system;

  security.pam.services.sudo_local.touchIdAuth = true;
}
