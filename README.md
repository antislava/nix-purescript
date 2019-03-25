## Description

Re-interpretation fork of [justinwoo/easy-purescript-nix: Easy PureScript (and other tools) with Nix](https://github.com/justinwoo/easy-purescript-nix) exporting nix overlays for PureScript related tools, for, where available, binary releases.

The purpose is to facilitate the workflow and improve reproducibility of the build environment.

## Using

One way to use this tool is to add this repo as git sub-module into a relevant directory, e.g.

```
git submodule add https://github.com/antislava/nix-purescript nix
```

This method allows maximum flexibility in terms of fixing dependency versions and adding other dependencies and overlays, as well as re-using provided shell.nix (as an initial template).

The alternative is to import the nix overlays in own projects' nix definitions. See `nix-shell ./example/shell.nix` for an example.

## Generating and updating dependencies

Use Makefile to easily fetch the latest release asset data using GitHub API, and generate (or update) nix scripts for relevant dependencies.

The auxiliary tools used directly or indirectly by the Makefile are included in a nix-shell environment:

```sh
nix-shell ./make-shell.nix
```

To update all the (github) assets:

```sh
make */github.release.latest.prefetched.json -B
make */github.json -B
```

To test the updated packages, enter the test environment:

```
nix-shell ./test-shell.nix

purs --version
zephyr --version
spago version
psc-package --version

purp

psc-package2nix # will report error
```

## Related PS projects and sources (infrastructure, installation, `nix`- and `dhall-ification`,...)

### Components
* [purescript/package-sets: PureScript packages for Psc-Package and Spago](https://github.com/purescript/package-sets)
* [purescript-contrib/pulp: A build tool for PureScript projects](https://github.com/purescript-contrib/pulp)

### Guides, scripts, templates,...
* [justinwoo/purescript-resources: This is a repository for a docs site on how to figure things out in PureScript as recommended by me.](https://github.com/justinwoo/purescript-resources)
* [Installation — PureScript-Resources documentation](https://purescript-resources.readthedocs.io/en/latest/installation.html)
* [nixpkgs/default.nix at a6fa300cf7192b61234436dd199f3678b648a096 · NixOS/nixpkgs](https://github.com/NixOS/nixpkgs/blob/a6fa300cf7192b61234436dd199f3678b648a096/pkgs/development/compilers/purescript/psc-package/default.nix)
* [srdqty/purescript-project-template](https://github.com/srdqty/purescript-project-template)
* [tmountain/purescript-reproducible: A short guide detailing how to bootstrap PureScript.](https://github.com/tmountain/purescript-reproducible)

### MISC
* [JordanMartinez/purescript-jordans-reference: Repo for documenting my learnings of Purescript](https://github.com/JordanMartinez/purescript-jordans-reference)
* [Learning From the Feynman Technique – Taking Note – Medium](https://medium.com/taking-note/learning-from-the-feynman-technique-5373014ad230)


## Notes and observations

`purp` and `psc-packages2nix` are very minimalistic cabal-less (i.e. `ghc` only) haskell scripts with no dependencies except `base`.

Bash-completions generated manually. They could benefit from using `optparse-applicative` at least.

* [Options.Applicative.BashCompletion](https://hackage.haskell.org/package/optparse-applicative-0.14.3.0/docs/Options-Applicative-BashCompletion.html)
* [Bash Completion · pcapriotti/optparse-applicative Wiki](https://github.com/pcapriotti/optparse-applicative/wiki/Bash-Completion)

