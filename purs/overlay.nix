self: pkgs:
let
  release = import ../common/release.nix ./github.release.latest.clean.json;
  prefetched = builtins.fromJSON (builtins.readFile ./github.release.latest.prefetched.json);
  patchelf = import ../common/patchelf.nix pkgs;
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
                    self.ncurses5
                  ];
    libPath = pkgs.lib.makeLibraryPath buildInputs;
    dontStrip = true;
    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/etc/bash_completion.d
      # mkdir -p $out/share/bash-completion/completions
      EXE=$out/bin/purs
      install -D -m555 -T purs $EXE
      ${patchelf libPath}
      $EXE --bash-completion-script $EXE > $out/etc/bash_completion.d/purs-completion.bash
    '';
    # TODO: Bash completion not working (need to run the script in shell)
    # Bash completion is usually installed in postInstall but...
    # postInstall is apparently ignored here:
    postInstall = ''
      false
    '';
  };
}
