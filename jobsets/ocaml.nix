{ rvk
, pkgs
}:

pkgs.stdenv.mkDerivation {
  name = "ocaml-4.03.0+k";
  requiredSystemFeatures = [ "ubuntu" ];
  src = null;

  buildInputs = with pkgs; [ ocaml_4_03 ];

  configurePhase = ''
    export HOME="$NIX_BUILD_TOP"
  '';

  buildPhase = ''
    opam repository add k $rvk/lib/opam
    opam update
    opam switch 4.03.0+k
  '';

  installPhase = ''
    ls
  '';
}
