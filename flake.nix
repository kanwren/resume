{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.resume = import ./default.nix { inherit pkgs; };
      defaultPackage = self.packages.${system}.resume;

      devShell = import ./shell.nix { inherit pkgs; };
    }
  );
}
