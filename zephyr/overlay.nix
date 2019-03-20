self: pkgs:
let
  release = import ../common/release.nix ./github.release.latest.clean.json;
  prefetched = builtins.fromJSON (builtins.readFile ./github.release.latest.prefetched.json);
  patchelf = import ../common/patchelf.nix pkgs;
in {
  zephyr-bin = pkgs.stdenv.mkDerivation rec {
    name = "zephyr-bin";
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
      EXE=$out/bin/zephyr
      install -D -m555 -T zephyr $EXE
      ${patchelf libPath}
      $EXE --bash-completion-script $EXE > $out/etc/bash_completion.d/zephyr-completion.bash
    '';
  };
}
