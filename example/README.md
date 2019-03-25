## Example shell for `spago`-based workflow

### Overview and important notes

`spago` README.md is provides an excellent guide to using the tool together with other PS/JS ecosystem tools.
* [spacchetti/spago: PureScript package manager and build tool powered by Dhall and package-sets](https://github.com/spacchetti/spago#package-management)

It is important to note that `spago` is replacing the combination of  `pulp`, `psc-package`, `purp` together with bower, but it does not do the final packaging (into the corresponding html-js combo), not does it provides commands for serving the result. There are several alternative tools for this stage, but `parcel-bundle` (`ParcelJS`) is proffered at the time of writing.

* [spacchetti/spago: PureScript package manager and build tool powered by Dhall and package-sets](https://github.com/spacchetti/spago#so-if-i-use-spago-make-module-this-thing-will-compile-all-my-js-deps-in-the-file)


### Example projects

* [Trivial console-only unicorns example (in spago README.md)](https://github.com/spacchetti/spago#quickstart)
* [f-f/purescript-react-basic-todomvc: TodoMVC with purescript-react-basic](https://github.com/f-f/purescript-react-basic-todomvc)
* [affresco - production example](https://github.com/KSF-Media/affresco)


## Using this example

### Updating dependencies

```sh
make nixpkgs/github.json
make dhall/github.json
```

See `spago` documentation at [spago/README.md at master · spacchetti/spago](https://github.com/spacchetti/spago/blob/master/README.md)

### Building the trivial example

```sh
spago init
# Creates default versions of:
# src/
# test/
# packages.dhall
# spago.dhall


# Append psci-support package to spago.dhall
patch spago.dhall spago.dhall.patch
# where
cat ./spago.dhall.patch
```

```diff
8c8
<     [ "effect", "console" ]
---
>     [ "effect", "console", "psci-support" ]
```

```sh
spago install
# Creates .spago/

spago build
# creates output/

# RUN
spago run

# TEST
spago test --main Test.Main

# REPL
spago repl
# or
# spago repl -- --port 3200

# BUNDLE
spago bundle
node .

# DOCS
spago docs

# TAGS
purs docs "src/**/*.purs" ".spago/*/*/src/**/*.purs" --format ctags > tags
```

