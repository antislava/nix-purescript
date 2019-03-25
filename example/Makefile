############################################################################
#
# This Makefile is our entry point into the example purescript project.
# We use it to:
#
# * get into development environments for working on our PS packages
#
# * installing depndencies
#
# * generating docs and tags
#
############################################################################


EXAMPLE = .
EX_DHALL = $(EXAMPLE)/dhall
EX_NIXPKGS = $(EXAMPLE)/nixpkgs

$(info $(shell mkdir -p $(EX_NIXPKGS) $(EX_DHALL)))

help:
	cat Makefile


# NIX SHELLS

.PHONY : shell-dev
shell :
	nix-shell $(EXAMPLE)/shell.nix


# Updating environment dependencies

$(EX_DHALL)/github.json :
	env owner=antislava repo=nix-dhall ./common/github-prefetch.sh $< > $@

$(EX_NIXPKGS)/github.json :
	env owner=NixOS repo=nixpkgs ./common/github-prefetch.sh $< > $@


# SPAGO COMMANDS

.PHONY : build-all
	build-all : init patch-spago install

.PHONY : init
init :
	spago init # spago.dhall packages.dhall

.PHONY : patch-spago
patch :
	patch spago.dhall spago.dhall.patch

.PHONY : install
install :
	spago install

.PHONY : run
run :
	spago run

.PHONY : test
test :
	spago test --main Test.Main

.PHONY : repl
repl :
	spago repl

.PHONY : repl-browser
repl-browser :
	@echo "open http://localhost:3200 in a browser"
	@echo "run PSCI.Main.main() in browser console"
	spago repl -- --port 3200

.PHONY : bundle
bundle :
	spago bundle # index.js

.PHONY : bundle-run
bundle-run :
	node .

.PHONY : docs
docs :
	spago docs

tags-vim :
	# purs docs "src/**/*.purs" ".psc-package/*/*/*/src/**/*.purs" --format ctags > $@
	purs docs "src/**/*.purs" ".spago/*/*/src/**/*.purs" --format ctags > $@
