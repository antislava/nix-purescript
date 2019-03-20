self: pkgs:
let
  release = import ../common/release.nix ./github.release.latest.clean.json;
  prefetched = builtins.fromJSON (builtins.readFile ./github.release.latest.prefetched.json);
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
  patchelf = import ../common/patchelf.nix pkgs;
in {
  pscpkg-bin = pkgs.stdenv.mkDerivation rec {
    name = "pscpkg-bin";
    version = release.data.tag_name;
    src =
      if pkgs.stdenv.isDarwin
      then pkgs.fetchurl prefetched.macos_tar_gz
      else pkgs.fetchurl prefetched.linux64_tar_gz
      ;
    buildInputs = [ self.zlib
                    self.gmp
                    self.ncurses5
                  ];
    libPath = pkgs.lib.makeLibraryPath buildInputs;
    dontStrip = true;
    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/etc/bash_completion.d/
      EXE=$out/bin/psc-package
      install -D -m555 -T psc-package $EXE
      ${patchelf libPath}
      $EXE --bash-completion-script $EXE > $out/etc/bash_completion.d/pscpkg-completion.bash
    '';
  };
}
