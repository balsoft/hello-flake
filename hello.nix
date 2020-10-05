{ stdenv, ghc }:
stdenv.mkDerivation {
  name = "my-hello";
  nativeBuildInputs = [ ghc ];
  src = ./hello.hs;
  buildCommand = ''
    mkdir -p $out/bin
    ghc $src -o $out/bin/hello
  '';
}
