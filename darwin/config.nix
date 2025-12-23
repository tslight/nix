{ pkgs, configRev ? null, system, ... }:
let
  emacsVterm = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (epkgs: [
    epkgs.vterm
  ]);
  user = "anon";
in
{
  imports = [
    (import ./system.nix { user = user; })
  ];

  nix.enable = false;

  system.primaryUser = user;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    emacsVterm
    librewolf
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
