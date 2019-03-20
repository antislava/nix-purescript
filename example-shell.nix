# with import <nixpkgs> { overlays = (import ./.).overlays.all ;};
with import <nixpkgs> { overlays = [ (import ./.).overlays.combined ] ;};
let withBashCompletion = [
  purs-bin
  zephyr-bin
  spago-bin
  pscpkg-bin
];
in
runCommand "ps-test-shell" {
  buildInputs = withBashCompletion ++ [
    pscpkg2nix
    purp

    nodejs-10_x
    # nodePackages_10_x.webpack
    # nodePackages_10_x.webpack-cli
  ];
  # TODO: Possible to automate sourcing bash completions somehow?
  # https://github.com/NixOS/nixpkgs/issues/44434#issuecomment-410624170
  # ls $HOME/.nix-profile/etc/bash_completion.d
  shellHook = ''
    echo "React basic starter shell"
    echo See https://github.com/justinwoo/spacchetti-react-basic-starter
    '' + (
      builtins.concatStringsSep "\n" (
        map (p:
        ''
          for e in ${p}/etc/bash_completion.d/*
          do
            echo $e
            source $e
          done
        '') withBashCompletion
      ));
} ""

