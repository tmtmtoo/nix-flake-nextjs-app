{ mkPnpmPackage }:

mkPnpmPackage {
  src = ./.;

  installInPlace = true;

  script = "build";

  installPhase = ''
    mv ./dist $out
  '';
}
