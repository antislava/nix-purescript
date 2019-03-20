self: pkgs:
let
  release = import ../common/release.nix ./github.release.latest.clean.json;
  prefetched = builtins.fromJSON (builtins.readFile ./github.release.latest.prefetched.json);
  patchelf = import ../common/patchelf.nix pkgs;
in {
  spago-bin = pkgs.stdenv.mkDerivation rec {
    name = "spago-bin";
    version = release.data.tag_name;
    src =
      if pkgs.stdenv.isDarwin
      then pkgs.fetchurl prefetched.osx_tar_gz
      else pkgs.fetchurl prefetched.linux_tar_gz
      ;
    buildInputs = [ self.zlib
                    self.gmp
                    self.ncurses5
                    self.stdenv.cc.cc.lib
                  ];
    libPath = pkgs.lib.makeLibraryPath buildInputs;
    dontStrip = true;
    unpackPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/etc/bash_completion.d/
      tar xf $src -C $out/bin
      EXE=$out/bin/spago
      ${patchelf libPath}
      $EXE --bash-completion-script $EXE > $out/etc/bash_completion.d/spago-completion.bash
    '';
    dontInstall = true;
  };
}
