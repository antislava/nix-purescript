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
  # TODO: Possible to automate sourcing bash completions somehow?
  # https://github.com/NixOS/nixpkgs/issues/44434#issuecomment-410624170
  # ls $HOME/.nix-profile/etc/bash_completion.d
  shellHook = ''
    echo "Purescript tools shell"

    echo ${spago-bin.out}

    echo "Loading bash completions for:"
    for p in
      purs spago zephyr psc-package
    do
      echo $p
      source <($p --bash-completion-script `which $p`)
    done
    '';
} ""

