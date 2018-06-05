{ rvkSrc
, pkgs
}:

pkgs.stdenv.mkDerivation {
  name = "ocaml-4.03.0-k";
  requiredSystemFeatures = [ "ubuntu" ];
  src = rvkSrc;

  buildInputs = with pkgs; [ maven flex openjdk8 gcc ocaml_4_03 opam rsync curl unzip git m4 ];

  buildPhase = ''
    export HOME="$NIX_BUILD_TOP"
    export NIX_CFLAGS_COMPILE="-Wno-error=unused-result $NIX_CFLAGS_COMPILE"
    mvn -Dmaven.repo.local=$HOME/.m2 package

    mkdir $out
    opam init --root $out
    source $out/opam-init/init.sh

    opam repository add k k-distribution/target/release/k/lib/opam
    opam switch 4.03.0+k
  '';

  installPhase = ''
    ls $out
    set
  '';
}
