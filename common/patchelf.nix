pkgs: libPath :
  let dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
  in if pkgs.stdenv.isDarwin
    then ""
    else
    ''
      chmod u+w $EXE
      patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $EXE
      chmod u-w $EXE
    ''
