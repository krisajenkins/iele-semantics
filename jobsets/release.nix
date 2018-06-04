{ nixpkgs ? <nixpkgs>
, secp256k1Src
, ieleSrc
, rvkSrc
, ethereumTestsSrc
, blockchainKPluginSrc
, tangleSrc
}:
with import nixpkgs {};
rec {
  secp256k1 = callPackage ./secp256k1.nix {
    inherit secp256k1Src;
  };
  rvk = callPackage ./rvk.nix {
    inherit rvkSrc;
  };
  ocaml_4_03_k = callPackage ./ocaml.nix {
    inherit rvk;
  };
  iele = callPackage ./iele.nix {
    inherit ieleSrc;
    inherit secp256k1;
  };
}
