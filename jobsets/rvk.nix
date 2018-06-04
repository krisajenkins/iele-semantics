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

  outputs = [ "bin" "lib" "include" "documentation" ];

  buildPhase = ''
    mvn -Dmaven.repo.local=$HOME/.m2 package
  '';

  installPhase = ''
    cd k-distribution/target/release/k
    mkdir $bin $lib $include $documentation
    cp -pr bin $bin
    cp -pr lib $lib
    cp -pr include $include
    cp -pr documentation $documentation
  ';
}
