{ pkgs ? import <nixpkgs> {}
}:

pkgs.stdenv.mkDerivation {
  name = "resume";
  src = ./src;

  nativeBuildInputs = [ pkgs.gnumake ];
  buildInputs =
    let tex-env = import ./tex.nix { inherit pkgs; };
    in [ tex-env ];

  buildPhase = "make";
  installPhase = ''
    mkdir -p "$out"
    make install
  '';
}
