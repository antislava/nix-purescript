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

## Notes

`purp` and `psc-packages2nix` are very minimalistic cabal-less (i.e. `ghc` only) haskell scripts with no dependencies except `base`.

Bash-completions generated manually. They could benefit from using `optparse-applicative` at least.

* [Options.Applicative.BashCompletion](https://hackage.haskell.org/package/optparse-applicative-0.14.3.0/docs/Options-Applicative-BashCompletion.html)
* [Bash Completion · pcapriotti/optparse-applicative Wiki](https://github.com/pcapriotti/optparse-applicative/wiki/Bash-Completion)


## TO DO

### Full response from github API contain volatile fields

For example, `download_count` is (obviously!) updated all the time. Whatever is stored in git needs to be cleaned of such fields, e.g. with `jq`.

### Bash completion doesn't work (in nix shell at least).

Need to manually source completion file (from nix store)
