let
  purs       = import ./purs/overlay.nix;
  pscpkg     = import ./pscpkg/overlay.nix;
  spago      = import ./spago/overlay.nix;
  zephyr     = import ./zephyr/overlay.nix;
  pscpkg2nix = import ./pscpkg2nix/overlay.nix;
  purp       = import ./purp/overlay.nix;

  all = [ purs pscpkg spago zephyr pscpkg2nix purp ];
in
{
  overlays = {
    inherit all purs zephyr spago pscpkg pscpkg2nix purp;
    combined = self: super: with super.lib;
      (fold composeExtensions (_: _: {}) all) self super;
  };
}
