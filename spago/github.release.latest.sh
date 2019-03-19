#!/usr/bin/env bash

# Quick and dirty filtering solution
curl -L https://api.github.com/repos/spacchetti/spago/releases/latest \
  > github.release.latest.original.json && \
jq -r -f `dirname "$0"`/../common/clean.jq ./github.release.latest.original.json
