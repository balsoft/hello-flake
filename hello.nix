{ stdenv, ghc, version ? "unknown" }:
stdenv.mkDerivation {
  name = "my-hello";
  nativeBuildInputs = [ ghc ];
  src = ./hello.hs;
  VERSION = version;
  buildCommand = ''
    mkdir -p $out/bin
    ghc $src -o $out/bin/hello
  '';
}
