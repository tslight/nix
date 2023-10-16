{ pkgs, lib, ... }: {
  imports = [../configuration.nix];
  homebrew = {
    enable = true;
    brews = [
      "azure-cli"
      "kubectl"
      "libomp"
      "msodbcsql"
      "mssql-tools"
      "terraform"
    ];
    extraConfig = ''
      module Utils
        ENV['HOMEBREW_ACCEPT_EULA']='y'
      end
      brew "mssql-tools"
    '';
    casks = [ "miniconda" "1password" "1password-cli" ];
    taps = [ "microsoft/mssql-release" {
      name = "microsoft/mssql-release";
      clone_target = "https://github.com/Microsoft/homebrew-mssql-release";
    }];
  };
}
