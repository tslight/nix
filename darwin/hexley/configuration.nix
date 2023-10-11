{ pkgs, lib, ... }:
{
  nix.settings.substituters = [ "https://cache.nixos.org/" ];
  nix.settings.trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  nix.settings.trusted-users = [ "@admin" "toby"];
  nix.configureBuildUsers = true;

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    kitty
  ];

  programs.nix-index.enable = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.userKeyMapping = [{
    HIDKeyboardModifierMappingDst = 30064771113;
    HIDKeyboardModifierMappingSrc = 30064771129;
  }];
  system.defaults.dock.orientation = "left";

  security.pam.enableSudoTouchIdAuth = true;

  homebrew = {
    enable = true;
    casks = [
      "emacs"
      "firefox"
      "google-chrome"
      "karabiner-elements"
    ];
  };
}
