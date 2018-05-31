{ nixpkgs ? <nixpkgs>
, declInput ? {}
}:
let pkgs = import nixpkgs {};

    mkGitSrc = { repo, branch ? "refs/heads/master" }: {
      type = "git";
      value = repo + " " + branch;
      emailresponsible = false;
    };

    mkJob = { name, description, ieleBranch }: {
      inherit name;
      value = {
        description = "IELE - ${description}";
        nixexprinput = "ieleSrc";
        nixexprpath = "jobsets/release.nix";

        inputs = {
          ieleSrc = mkGitSrc {
            repo = "https://github.com/krisajenkins/iele-semantics.git";
            branch = ieleBranch;
          };

          secp256k1Src = mkGitSrc {
            repo = "https://github.com/bitcoin-core/secp256k1";
          };

          rvkSrc = mkGitSrc {
            repo = "https://github.com/runtimeverification/k";
          };

          ethereumTestsSrc = mkGitSrc {
            repo = "https://github.com/ethereum/tests";
            branch = "refs/heads/develop";
          };

          blockchainKPluginSrc = mkGitSrc {
	          repo = "https://github.com/runtimeverification/blockchain-k-plugin";
          };

          tangleSrc = mkGitSrc {
	          repo = "https://github.com/ehildenb/pandoc-tangle";
          };

          nixpkgs = mkGitSrc {
            repo = "https://github.com/NixOS/nixpkgs.git";
            branch = "06c576b0525da85f2de86b3c13bb796d6a0c20f6";
          };
        };
        enabled = 1;
        hidden = false;
        checkinterval = 300;
        schedulingshares = 100;
        emailoverride = "";
        enableemail = false;
        keepnr = 3;
      };
    };

    jobsetDefinition = pkgs.lib.listToAttrs (
      [
        (mkJob {
          name = "master";
          description = "Master";
          ieleBranch = "refs/heads/nixify";
        })
      ]
    );
in {
  jobsets = pkgs.runCommand "spec.json" {} ''
    cat <<EOF
    ${builtins.toXML declInput}
    EOF

    cat > $out <<EOF
    ${builtins.toJSON jobsetDefinition}
    EOF
  '';
}
