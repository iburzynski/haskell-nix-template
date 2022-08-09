{
  # Top level attributes: `description`, `inputs`, `outputs`

  # a one-line description shown by `nix flake metadata`
  description = "PKGNAME";

  # `inputs` contains other flakes this flake depends on
  # These are fetched by Nix and passed as arguments to the `outputs` function
  inputs = {
      haskellNix.url = "github:input-output-hk/haskell.nix";
      # Depends on whichever version of nixpkgs haskell.nix is using
      nixpkgs.follows = "haskellNix/nixpkgs-unstable";
      flake-utils.url = "github:numtide/flake-utils";
    };

  # `outputs` is a function that produces an attribute set
  # the `self` argument refers to *this* flake
  outputs = { self, nixpkgs, flake-utils, haskellNix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ haskellNix.overlay
          # Anonymous curried function - <arg>: <arg>: <function body>
          (self: _: {
            # Overlays are functions accepting two arguments:
            #   * `self` (final package set)
            #   * `super` (original package set)
            # This overlay will add our project to `pkgs`
            myProject =
              self.haskell-nix.project' {
                # Call `project'` function from `haskell-nix` pkg with the following arguments:
                src = ./.;
                compiler-nix-name = "ghc8107";
                # Configure the development shell used by `nix develop .`
                shell = {
                  tools = {
                    # Haskell shell tools go here
                    cabal = "latest";
                    ghcid = "latest";
                    haskell-language-server = "latest";
                    hlint = "latest";
                    };
                  };
                };
            })
          ];
        pkgs = import nixpkgs {
          # `inherit` is used in attribute sets or `let` bindings to inherit variables from the parent scope
          # equivalent to `system = system`, `overlays = overlays`, etc.
          inherit system overlays;
          # equivalent to `config = haskellNix.config`
          inherit (haskellNix) config;
          };
        flake = pkgs.myProject.flake { };
      in
      flake // {
        # // merges left & right attribute sets, with right set taking precedence

        # Default package built by `nix build` if no argument is provided
        defaultPackage = flake.packages."PKGNAME:exe:PKGNAME-exe";
      });
}
