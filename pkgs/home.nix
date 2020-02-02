# https://rycee.gitlab.io/home-manager/options.html
{ pkgs, ... }:{
  # https://github.com/rycee/home-manager/issues/432
  home.extraOutputsToInstall = [ "man" ];
  programs.man.enable = false;

  programs.chromium = {
    enable = true;
    extensions = [
      "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
      "hdokiejnpimakedhajhdlcegeplioahd" # lastpass
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # privacy badger
      "gfbliohnnapiefjpjlpjnehglfpaknnc" # surfing keys
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
    ];
  };

  # https://gitlab.com/rycee/nur-expressions
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      https-everywhere
      privacy-badger
      ublock-origin
      vim-vixen
    ];
  };
}
