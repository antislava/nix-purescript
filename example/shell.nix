# with import <nixpkgs> { overlays = (import ./.).overlays.all ;};
with import ./nixpkgs {} {
  config.allowBroken = true;
  overlays = [
  (import ./..).overlays.combined
  # (self: pkgs: import ./dhall {inherit pkgs;}) this causes infinite rec-n
  (import ./dhall {})
] ;};
let withBashCompletion = [
  # Dhall & Co
  dhall-bin
  dhall-json-bin
  dhall-text-bin
  dhall-bash-bin
  # PS & Co
  purs-bin
  zephyr-bin
  spago-bin
  pscpkg-bin
];
in
runCommand "ps-example-shell" {
  buildInputs = withBashCompletion ++ [
    pscpkg2nix
    purp

    yarn
    # https://github.com/dsifford/yarn-completion # Need this?
    yarn2nix
    npm2nix

    nodejs-10_x
    nodePackages_10_x.parcel-bundler
    nodePackages_10_x.pulp
    # nodePackages_10_x.webpack
    # nodePackages_10_x.webpack-cli
  ];
  # TODO: Possible to define sourcing bash completions step in respective overlay definitions instead?
  # https://github.com/NixOS/nixpkgs/issues/44434#issuecomment-410624170
  # ls $HOME/.nix-profile/etc/bash_completion.d
  shellHook = ''
    echo "Simple PS dev starter shell"
    echo See https://github.com/justinwoo/spacchetti-react-basic-starter
    echo "Loading bash completions for:"
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
