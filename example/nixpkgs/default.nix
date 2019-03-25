{ pkgs ? import <nixpkgs> {} }:
# Note that we depend on a <nixpkgs> in our NIX_PATH. This nixpkgs is only used to access the `fetchFromGitHub` function.
with builtins;
import (pkgs.fetchFromGitHub (fromJSON (readFile ./github.json)))
