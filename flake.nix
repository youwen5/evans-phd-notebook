{
  description = "Compile Evan Chen's PhD notebook reproducibly";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # compiling Evan's documents require the `evan.sty` TeX style file
    # <https://github.com/vEnhance/dotfiles/blob/main/texmf/tex/latex/evan/evan.sty>
    # we leverage flake.lock to track the dotfiles repository, and obtain a version locked `evan.sty`
    # run `nix flake update evan-dotfiles` to update to the latest revision of evan.sty
    evan-dotfiles = {
      url = "github:vEnhance/dotfiles";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, evan-dotfiles, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "i686-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          inherit (pkgs) callPackage;
        in
        rec {
          # default derivation compiles notes,thesis, and slides together
          default = callPackage ./nix { inherit notes slides thesis; };

          notes = callPackage ./nix/notes.nix { inherit evan-dotfiles; };
          thesis = callPackage ./nix/thesis.nix { };
          slides = callPackage ./nix/slides.nix { inherit evan-dotfiles; };
        }
      );
    };
}
