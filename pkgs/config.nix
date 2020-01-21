{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        ansible
        azure-cli
        chez
        chromium
        clojure
        docker
        docker-compose
        emacs
        exa
        firefox
        gitFull
        go
        mpv
        nix-bash-completions
        powershell
        terraform
        youtube-dl
      ];
    };
  };
}
