{ rvkSrc
, pkgs
}:

pkgs.stdenv.mkDerivation {
  name = "rvk";
  requiredSystemFeatures = [ "ubuntu" ];
  src = rvkSrc;

  buildInputs = with pkgs; [ maven flex openjdk8 gcc ];

  configurePhase = ''
    export HOME="$NIX_BUILD_TOP"
  '';

  buildPhase = ''
    mvn -Dmaven.repo.local=$HOME/.m2 package
  '';

  installPhase = ''
    mkdir $out
    cp -pr k-distribution/target/release/k/* $out
  '';
}
