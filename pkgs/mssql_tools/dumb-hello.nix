let nixpkgs = import <nixpkgs> {};
    stdenv = nixpkgs.stdenv;
in rec {
  dumb-hello = stdenv.mkDerivation {
    name = "dumb-hello";
    builder = ./builder.sh;
    dpkg = nixpkgs.dpkg;
    src = nixpkgs.fetchurl {
      url = "http://ftp.us.debian.org/debian/pool/main/h/hello-traditional/hello-traditional_2.9-2_amd64.deb";
      sha256 = "bb5962e344ab26d59e55abecc654b2e34729bbc7a6d3a7913440cf5eb8a8c9ae";
    };
  };
}
