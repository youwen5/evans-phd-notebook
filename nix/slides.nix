{
  stdenvNoCC,
  evan-dotfiles,
  texliveFull,
  fetchFromGitHub,
  fetchzip,
}:
let
  # nix doesn't allow usage of any globally installed fonts for reproducibility, so we bring our own
  noto-cjk-sc = stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "noto-fonts-cjk-serif-sc";
    version = "2.003";

    src = fetchFromGitHub {
      owner = "notofonts";
      repo = "noto-cjk";
      rev = "Serif${finalAttrs.version}";
      hash = "sha256-W3KFoLFdbYu1JJvRCpeeHHwpo/EYKWf6tJxKzShFbwU=";
      sparseCheckout = [ "Serif/OTF/SimplifiedChinese" ];
    };

    installPhase = ''
      install -m444 -Dt $out/share/fonts/opentype/noto-cjk Serif/OTF/SimplifiedChinese/*.otf
    '';
  });

  source-hans-sans-tw = stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "source-han-sans-tw";
    version = "2.004";

    src = fetchzip {
      url = "https://github.com/adobe-fonts/source-han-sans/releases/download/${finalAttrs.version}R/SourceHanSansTW.zip";
      hash = "sha256-1q69px9Je+cQzXPR5wJzNYTEfdOhPpeHhAwflKfu56w=";
      stripRoot = false;
    };

    installPhase = ''
      install -m444 -Dt $out/share/fonts/opentype/source-hans SubsetOTF/TW/*.otf
    '';
  });
in
stdenvNoCC.mkDerivation {
  pname = "slides";
  version = "unstable";

  src = ../slides;

  nativeBuildInputs = [
    texliveFull
  ];

  configurePhase = ''
    # create home dir in nix build environment
    export HOME="$(mktemp -d)"
    # lualatex needs to know where to get fonts
    export OSFONTDIR=$HOME/.local/share/fonts

    # provide style files
    cp ${evan-dotfiles}/texmf/tex/latex/evan/evan.sty .
    cp ${evan-dotfiles}/texmf/tex/latex/beamer/malyasia/* .

    # "install" fonts to LuaLaTeX can find them
    mkdir -p $HOME/.local/share/fonts
    cp -r ${noto-cjk-sc}/share/fonts/opentype/noto-cjk $HOME/.local/share/fonts
    cp -r ${source-hans-sans-tw}/share/fonts/opentype/source-hans $HOME/.local/share/fonts
  '';

  buildPhase = ''
    latexmk -lualatex slides.tex
  '';

  installPhase = ''
    mkdir -p $out
    install slides.pdf $out/slides.pdf
  '';
}
