{
  stdenvNoCC,
  evan-dotfiles,
  texliveFull,
}:
stdenvNoCC.mkDerivation {
  pname = "notes";
  version = "unstable";

  src = ../.;

  nativeBuildInputs = [
    texliveFull
  ];

  configurePhase = ''
    cp ${evan-dotfiles}/texmf/tex/latex/evan/evan.sty .
  '';

  buildPhase = ''
    latexmk -pdf main.tex
  '';

  installPhase = ''
    mkdir -p $out
    latexmk -pdf main.tex
    install main.pdf $out/notes.pdf
  '';
}
