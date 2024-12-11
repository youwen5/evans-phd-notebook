# Evan's PhD Notebook

Hello Evan nothing to see here...

```bash
# reproducibly compile documents in hermetic Nix build environment

# nix with flakes and nix-command enabled
# (use flag --extra-experimental-features "flakes nix-command" to temporarily enable)
nix build github:youwen5/evans-phd-notebook

# produces symlink result in working directory
zathura result/thesis.pdf
zathura result/slides.pdf
zathura result/notes.pdf
```

---

This is a repository where I keep the TeX source notes about math I'm studying
in connection to my PhD thesis. By definition, everything here is stuff I'm
learning for the first time. The content is therefore likely to be riddled with
errors, inaccuracies, and is generally in a really rough state. There are more
holes than Swiss cheese.

## What are the relevant files?

- `notes/` contains some scattered notes on things that I did in the first few years of study
- `thesis/` contains the thesis itself
- `slides/` contains slides from talks I gave about the thesis
- `nix/` contains Nix support files to reproducibly compile the documents

Compiled PDF's will be uploaded starting around 2025 or so.
(I'm pausing the PDF uploading for the home stretch while I tidy things up.
Build them yourself if you really want to see them.)

## What field of math is this?

Number theory, specifically automorphic forms and representations.

## Who's your advisor?

[Wei Zhang][wei]. Who by the way is the nicest advisor ever.

[wei]: https://en.wikipedia.org/wiki/Wei_Zhang_(mathematician)

## Can you give me a research project to work on?

No.
