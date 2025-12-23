{ lib, pkgs, ... }:
let
  # 1. Define your customized dwl package
  myCustomDwlPackage = (pkgs.dwl.override {
    configH = ../config/dwl/config.h;
  }).overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [
      # ../movestack.patch # Using the direct path for the patch
    ];
    # Add any necessary buildInputs if your config.h or patches require them
    # For a bar, you might need fcft for font rendering.
    buildInputs = oldAttrs.buildInputs or [] ++ [ pkgs.libdrm pkgs.fcft ];
  });

  # 2. Create a wrapper script that launches dwl with dwlb as the status bar
  dwlWithDwlbWrapper = pkgs.writeScriptBin "dwl-with-dwlb" ''
#!/usr/bin/env bash
exec ${lib.getExe myCustomDwlPackage} -s "${pkgs.dwlb}/bin/dwlb -font \"JetBrainsMono Nerd Font:size=13\"" "$@"
'';
in
{
  programs = {
    dwl = {
      enable = true;
      # Tell the dwl module to use our wrapper script as the dwl executable
      package = dwlWithDwlbWrapper;
    };
    foot = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=13";
          pad = "0x0";
        };
        mouse = {
          hide-when-typing = "yes";
        };
        colors = {
          background = "000000";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [ wmenu ];
  # Needed for glyph support in foot
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
    mouse.naturalScrolling = true; # Optional, for mice
  };
}
