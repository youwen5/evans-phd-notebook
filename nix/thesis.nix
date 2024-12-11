{
  stdenvNoCC,
  texliveFull,
}:
stdenvNoCC.mkDerivation {
  pname = "thesis";
  version = "unstable";

  src = ../thesis;

  nativeBuildInputs = [
    texliveFull
  ];

  buildPhase = ''
    latexmk -pdf thesis.tex
  '';

  installPhase = ''
    mkdir -p $out
    install thesis.pdf $out/thesis.pdf
  '';
}
