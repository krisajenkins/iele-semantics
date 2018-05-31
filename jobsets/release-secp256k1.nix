with (import <nixpkgs> {});
let secp256k1SrcSpec = builtins.fromJSON (builtins.readFile ./secp256k1-src.json);
in callPackage ./secp256k1.nix {
  secp256k1Src = fetchgit {
    inherit (secp256k1SrcSpec) url sha256;
  };
}
