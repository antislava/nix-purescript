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

    nodejs-10_x
    # nodePackages_10_x.webpack
    # nodePackages_10_x.webpack-cli
  ];
  shellHook = ''
    echo "React basic starter shell"
    echo See https://github.com/justinwoo/spacchetti-react-basic-starter
    '';
} ""

