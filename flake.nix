{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    foundry.url = "github:shazow/foundry.nix";
  };

  outputs = { self, nixpkgs, utils, foundry }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ foundry.overlay ];
        };
      in {

        devShell = with pkgs; mkShell {
          buildInputs = [
            solc
            foundry-bin # From the foundry overlay
          ];

          shellHook = ''
            export PS1="\e[1;33m\][dev]\e[1;34m\] \w $ \e[0m\]"

            [[ -f .env ]] && source .env
          '';
        };

      });
}
