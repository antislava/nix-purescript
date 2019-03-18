self: pkgs:
let
  release = import ./release.nix;
  prefetched = builtins.fromJSON (builtins.readFile ./github.release.latest.prefetched.json);
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
  patchelf = libPath :
    if pkgs.stdenv.isDarwin
      then ""
      else
        ''
          chmod u+w $PURS
          patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $PURS
          chmod u-w $PURS
        '';
in {
  purs-bin = pkgs.stdenv.mkDerivation rec {
    name = "purs-bin";
    version = release.data.tag_name;
    src =
      if pkgs.stdenv.isDarwin
      then pkgs.fetchurl prefetched.macos_tar_gz
      else pkgs.fetchurl prefetched.linux64_tar_gz
      ;
    buildInputs = [ self.zlib
                    self.gmp
                    self.ncurses5];
    libPath = pkgs.lib.makeLibraryPath buildInputs;
    dontStrip = true;
    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/etc/bash_completion.d/
      PURS=$out/bin/purs
      install -D -m555 -T purs $PURS
      ${patchelf libPath}
      $PURS --bash-completion-script $PURS > $out/etc/bash_completion.d/purs-completion.bash
    '';
  };
}
