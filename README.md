## Description

Re-interpreted fork of [justinwoo/easy-purescript-nix: Easy PureScript (and other tools) with Nix](https://github.com/justinwoo/easy-purescript-nix) exporting nix overlays for PureScript related tools, for, where available, binary releases.

## Using

Include generated overlays in your project `nixpkgs`. Run `nix-shell ./test-shell.nix` for an example.

## Generating and updating

Use Makefile to easily generate and update github identifiers of the relevant dependencies.

## Notes

`purp` and `psc-packages2nix` are very minimalistic cabal-less (i.e. `ghc` only) haskell scripts with no dependencies except `base`.

Bash-completions generated manually. They could benefit from using `optparse-applicative` at least.

* [Options.Applicative.BashCompletion](https://hackage.haskell.org/package/optparse-applicative-0.14.3.0/docs/Options-Applicative-BashCompletion.html)
* [Bash Completion · pcapriotti/optparse-applicative Wiki](https://github.com/pcapriotti/optparse-applicative/wiki/Bash-Completion)


## Issues

### Bash completion doesn't work (in nix shell at least).

Need to manually source completion file (from nix store)
