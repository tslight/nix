{ user }:
{
  system.defaults = {
    CustomUserPreferences = {
      NSGlobalDomain = {
        # Add a context menu item for showing the Web Inspector in web views
        WebKitDeveloperExtras = true;
      };
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = false;
      };
    };
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    controlcenter.BatteryShowPercentage = true;
    dock.autohide = true;
    dock.launchanim = false;
    dock.mineffect = null;
    dock.minimize-to-application = true;
    dock.mru-spaces = false;
    dock.orientation = "left";
    dock.persistent-apps = [];
    dock.persistent-others = [
      { folder = { path = "/Users/${user}"; showas = "list"; }; }
      { folder = { path = "/Users/${user}/Downloads"; showas = "grid"; }; }
    ];
    dock.tilesize = 42;
    dock.wvous-bl-corner = 11; # Launchpad
    dock.wvous-br-corner = 4; # Desktop
    dock.wvous-tl-corner = 2; # Mission Control
    dock.wvous-tr-corner = 12; # Notifications
    finder.AppleShowAllExtensions = true;
    finder.CreateDesktop = false; # get rid of desktop items
    finder.FXPreferredViewStyle = "clmv";
    finder.QuitMenuItem = true;
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
    loginwindow.LoginwindowText = "A mind forever voyaging through strange seas of thought...";
    menuExtraClock.ShowDate = 0; # 0 = When space allows 1 = Always 2 = Never.
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 60;
    trackpad.Clicking = true;
    trackpad.TrackpadRightClick = true;
    trackpad.TrackpadThreeFingerDrag = true;
    WindowManager.StandardHideWidgets = true;
    WindowManager.StageManagerHideWidgets = true;
  };
}
