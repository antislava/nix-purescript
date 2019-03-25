## Description

Re-interpretation fork of [justinwoo/easy-purescript-nix: Easy PureScript (and other tools) with Nix](https://github.com/justinwoo/easy-purescript-nix) exporting nix overlays for PureScript related tools, for, where available, binary releases.

## Using

Include generated overlays in your project `nixpkgs`. Run `nix-shell ./test-shell.nix` for an example.

## Generating and updating

Use Makefile to easily fetch the latest release asset data using GitHub API, and generate (or update) nix scripts for relevant dependencies.

Dependencies are included in a nix-shell environment:

```sh
nix-shell ./make-shell.nix
```

To update all the (github) assets:

```sh
make */github.release.latest.prefetched.json -B
make */github.json -B
```

To test the updated packages, enter test environment:

```
nix-shell ./test-shell.nix

purs --version
zephyr --version
spago version
psc-package --version

purp

psc-package2nix # will report error
```

## Related (infrastructure, installation, `nix`- and `dhall-ification`,...)

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

## Notes

`purp` and `psc-packages2nix` are very minimalistic cabal-less (i.e. `ghc` only) haskell scripts with no dependencies except `base`.

Bash-completions generated manually. They could benefit from using `optparse-applicative` at least.

* [Options.Applicative.BashCompletion](https://hackage.haskell.org/package/optparse-applicative-0.14.3.0/docs/Options-Applicative-BashCompletion.html)
* [Bash Completion · pcapriotti/optparse-applicative Wiki](https://github.com/pcapriotti/optparse-applicative/wiki/Bash-Completion)


## TO DO

### ~~Full response from github API contain volatile fields (solved?)~~

For example, `download_count` is (obviously!) updated all the time. Solved.

### ~~Makefile repetitive, fetch shell scripts follow the same pattern~~
Solved

### ~~Bash completion doesn't work (in nix shell at least)~~

~~Need to manually source completion file (from nix store)~~

Added bash completion script sourcing in test-shell.nix

