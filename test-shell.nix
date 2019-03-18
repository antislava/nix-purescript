# with import <nixpkgs> { overlays = (import ./.).overlays.all ;};
with import <nixpkgs> { overlays = [ (import ./.).overlays.combined ] ;};
runCommand "ps-test-shell" {
  buildInputs = [
    purs-bin
    zephyr-bin
    spago-bin
    pscpkg-bin
    pscpkg2nix
    purp
  ];
  shellHook = ''
    echo "Purescript tools shell"
    '';
} ""

