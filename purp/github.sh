env owner=justinwoo repo=purp uribase=https://github.com \
  sh -c 'nix-prefetch-git $uribase/$owner/$repo --rev $rev'
