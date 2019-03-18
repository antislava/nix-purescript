{ pkgs ? import <nixpkgs> {} }:
with builtins;
import (pkgs.fetchFromGitHub (fromJSON (readFile ./github.json))) { inherit pkgs; }
