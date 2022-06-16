{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      tex-env = pkgs.texlive.combine {
        inherit (pkgs.texlive)
          scheme-small

          titlesec
          preprint
          marvosym
          enumitem
          sourcesanspro
          ly1
          cm-super

          latexmk;
      };
    in
    {
      packages.resume = pkgs.stdenv.mkDerivation {
        name = "resume";
        src = ./.;

        nativeBuildInputs = [ pkgs.gnumake ];
        buildInputs = [ tex-env ];

        buildPhase = "make";
        installPhase = ''
          mkdir -p "$out"
          make install
        '';
      };
      defaultPackage = self.packages.${system}.resume;

      devShell = pkgs.mkShell {
        buildInputs = [ tex-env ];
      };
    }
  );
}
