{ pkgs, ... }:
{
  imports = [ ./desktop.nix ];

  programs.emacs.package = pkgs.emacs-pgtk;

  programs.foot = {
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

  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    fuzzel
    swayidle
    swaylock
    waybar
    wlsunset
  ];
}
