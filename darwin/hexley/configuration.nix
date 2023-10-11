{ pkgs, lib, ... }: {
  imports = [../configuration.nix];
  homebrew = {
    enable = true;
    brews = ["azure-cli" "libomp" "msodbcsql" "mssql-tools" ];
    casks = [ "miniconda" ];
    taps = [ "microsoft/mssql-release" {
      name = "microsoft/mssql-release";
      clone_target = "https://github.com/Microsoft/homebrew-mssql-release";
    }];
  };
}
