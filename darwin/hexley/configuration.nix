{ pkgs, lib, ... }:
{
  nix.settings.substituters = [ "https://cache.nixos.org/" ];
  nix.settings.trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  nix.settings.trusted-users = [ "@admin" "toby"];
  nix.configureBuildUsers = true;

  # Enable experimental nix command and flakes
  nix.package = pkgs.nixUnstable;
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

  environment.systemPackages = with pkgs; [ kitty ];

  programs.nix-index.enable = true;

  system.defaults.dock.orientation = "left";
  system.defaults.dock.wvous-tl-corner = 2; # Mission Control
  system.defaults.dock.wvous-tr-corner = 12; # Notifications
  system.defaults.dock.wvous-bl-corner = 11; # Launchpad
  system.defaults.dock.wvous-br-corner = 4; # Desktop
  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadRightClick = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;
  system.defaults.finder.FXPreferredViewStyle = "clmv";
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.ShowStatusBar = true;

  security.pam.enableSudoTouchIdAuth = true;

  homebrew = {
    enable = true;
    brews = [
      "azure-cli"
      "bash"
      "gnu-sed"
      "gnu-tar"
      "kubectl"
      "libomp"
    ];
    casks = [
      "emacs"
      "firefox"
      "google-chrome"
      "karabiner-elements"
    ];
  };
}
