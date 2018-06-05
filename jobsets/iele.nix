{ stdenv
, autoconf
, automake
, libtool
, maven
, stack
, perl
, flex
, git
, gcc
, opam
, ocaml
, pandoc
, ieleSrc
, unzip
, z3
, mpfr
, gmp
, curl
, rsync
, which
, ncurses
, pkgconfig
, python2
, zlib
, openjdk8
}:

stdenv.mkDerivation {
  name = "iele";
  requiredSystemFeatures = [ "ubuntu" ];
  src = ieleSrc;

  buildInputs = [ autoconf automake libtool maven stack perl flex git gcc opam ocaml pandoc curl rsync unzip which pkgconfig zlib ncurses z3 mpfr gmp openjdk8 python2 ];

  patches = [ ./iele-spaces.patch ];

  configurePhase = ''
    export HOME=$NIX_BUILD_TOP
    export LD_LIBRARY_PATH=${gmp.out}/lib:$LD_LIBRARY_PATH
    make deps
    eval $(opam config env)
  '';

  installPhase = ''
    make install
    mkdir $out
    cp -pr $HOME/.local/bin $out/
  '';
}
