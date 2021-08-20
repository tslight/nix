{
  gtk.gtk2.extraConfig = ''
      gtk-key-theme-name = "Emacs"
    '';

  gtk.gtk3.extraConfig = ''
      [Settings]
      gtk-key-theme-name = Emacs
    '';
}
