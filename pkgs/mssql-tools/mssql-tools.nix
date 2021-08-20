# https://reflexivereflection.com/posts/2015-02-28-deb-installation-nixos.html
let nixpkgs = import <nixpkgs> {};
    stdenv = nixpkgs.stdenv;
in rec {
  mssql-tools = stdenv.mkDerivation {
    name = "mssql-tools";
    builder = ./builder.sh;
    dpkg = nixpkgs.dpkg;
    src = nixpkgs.fetchurl {
      url = "https://packages.microsoft.com/ubuntu/16.04/prod/pool/main/m/mssql-tools/mssql-tools_17.4.1.1-1_amd64.deb";
      sha256 = "e0c57ee043939f56fe873376cc6df6c51f27f99df65eb679bda0708c5e7f3b48";
    };
  };
}
