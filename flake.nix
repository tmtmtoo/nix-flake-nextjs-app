{
  description = "nix-flake-nodejs-app";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pnpm2nix = {
      url = "github:wrvsrx/pnpm2nix-nzbr/adapt-to-v9";
      #url = "github:nzbr/pnpm2nix-nzbr";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, pnpm2nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        corepack = pkgs.stdenv.mkDerivation {
          name = "corepack";
          buildInputs = [ pkgs.nodejs ];
          phases = [ "installPhase" ];
          installPhase = ''
            mkdir -p $out/bin
            corepack enable --install-directory=$out/bin
          '';
        };
        app = pnpm2nix.packages."${system}".mkPnpmPackage {
          src = ./.;
          installInPlace = true;
          script = "build";
          installPhase = ''
            mv ./dist $out
          '';
        };
      in
      {
        packages.default = app;
        packages.docker = pkgs.dockerTools.buildImage {
          name = "nix-flake-nextjs-app";
          tag = "latest";

          config = {
            Cmd = [ "${pkgs.nodejs}/bin/node" "${app}/packages/next-app/server.js" ];
            ExposedPorts = {
              "3000/tcp" = { };
            };
          };
        };
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs
            pkgs.docker-client
            corepack
          ];
        };
        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
