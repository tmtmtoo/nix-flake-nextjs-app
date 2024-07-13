{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
    name = "nix-flake-nodejs-app";

    src = pkgs.nix-gitignore.gitignoreSource [] ./.;

    corepack = pkgs.stdenv.mkDerivation {
        name = "corepack";
        buildInputs = [ pkgs.nodejs ];
        phases = [ "installPhase" ];
        installPhase = ''
            mkdir -p $out/bin
            corepack enable --install-directory=$out/bin
        '';
    };

    buildInputs = [
        pkgs.nodejs
        corepack
    ];

    buildPhase = ''
        pnpm install --frozen-lockfile
        pnpm build
    '';

    installPhase = ''
        mv ./dist $out
    '';
}
