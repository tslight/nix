{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; rec {
    # https://github.com/nix-community/NUR/#installation
    # https://gitlab.com/rycee/nur-expressions
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
    # myEmacs = import ./emacs.nix {};
    myPythonPackages = pkgs.buildEnv {
      name = "my-python-packages";
      paths = import ./python-packages.nix pkgs;
    };
    myPkgs = import ./pkgs.nix {};
    # myPackages = pkgs.buildEnv {
    #   name = "my-packages";
    #   paths = import ./packages.nix pkgs;
    # };
  };
}
