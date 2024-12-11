{
  thesis,
  slides,
  notes,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "phd-notebook";
  version = "unstable";

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    install ${thesis}/thesis.pdf $out/thesis.pdf
    install ${slides}/slides.pdf $out/slides.pdf
    install ${notes}/notes.pdf $out/notes.pdf
  '';
}
