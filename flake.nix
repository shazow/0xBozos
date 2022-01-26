{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    foundry.url = "git+https://github.com/shazow/nixfiles?dir=flakes/foundry";
  };

  outputs = { self, nixpkgs, utils, foundry }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {

        devShell = with pkgs; mkShell {
          buildInputs = [
            solc
            foundry.defaultPackage.${system}
          ];

          shellHook = ''
            export PS1="\e[1;33m\][dev]\e[1;34m\] \w $ \e[0m\]"
          '';
        };

      });
}
