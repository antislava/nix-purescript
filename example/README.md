## Example shell for following `spago` instructions

To update the development shell dependencies

```sh
make nixpkgs/github.json
make dhall/github.json
```

See `spago` documentation at [spago/README.md at master · spacchetti/spago](https://github.com/spacchetti/spago/blob/master/README.md)

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
purs docs "src/**/*.purs" ".psc-package/*/*/*/src/**/*.purs" --format ctags > 
```

