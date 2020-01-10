{ config, pkgs, ... }: {
  # Don't forget to set a password with ‘passwd’.
  # users.defaultUserShell = pkgs.zsh;
  users.users = {
    toby = {
      isNormalUser = true;
      description = "Toby Slight";
      extraGroups = [
        "docker"
        "networkmanager"
        "systemd-journal"
        "wheel" # Enable ‘sudo’ for the user.
        "wireshark"
      ];
      shell = pkgs.zsh;
    };
  };
}
