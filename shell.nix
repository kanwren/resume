{ pkgs ? import <nixpkgs> {}
}:

let tex-env = import ./tex.nix { inherit pkgs; };
in pkgs.mkShell {
  buildInputs = [ tex-env ];
}
