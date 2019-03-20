## TO-DO

* Pin `nixpkgs` used in `shell.nix` and `./dhall/default.nix`
* Using `super` set to `fetchFromGitHub` in `./dhall/default.nix` causes infinite recursion. Why?! (_Normally_, `super.fetchFromGitHub`  is used in overlays, e.g. see [](https://github.com/jwiegley/nix-config))
