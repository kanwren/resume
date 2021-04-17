{ pkgs }:

pkgs.texlive.combine {
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
}
