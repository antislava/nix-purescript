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
  ];
  # TODO: Possible to define sourcing bash completions step in respective overlay definitions instead?
  # https://github.com/NixOS/nixpkgs/issues/44434#issuecomment-410624170
  # ls $HOME/.nix-profile/etc/bash_completion.d
  shellHook = ''
    echo "Purescript tools shell"
    echo "Loading bash completions:"
    '' + (
      builtins.concatStringsSep "\n" (
        map (p:
        ''
          for e in ${p}/etc/bash_completion.d/*
          do
            echo `basename $e`
            source $e
          done
        '') withBashCompletion
      ));
} ""
