{
  outputs = { self, nixpkgs }: {
    packages = builtins.mapAttrs
      (system: pkgs: { hello = pkgs.callPackage ./hello.nix { }; })
      nixpkgs.legacyPackages;

    defaultPackage =
      builtins.mapAttrs (_: packages: packages.hello) self.packages;

    defaultApp = builtins.mapAttrs (system: package: {
      type = "app";
      program = "${package}/bin/hello";
    }) self.defaultPackage;

    checks = builtins.mapAttrs (system: pkgs: {
      helloOutputCorrect = pkgs.runCommand "hello-output-correct" { } ''
        HELLO_OUTPUT="$(${self.packages.${system}.hello}/bin/hello)"
        echo "Hello output is: $HELLO_OUTPUT"
        EXPECTED="Hello, world!"
        echo "Expected: $EXPECTED"
        [[ "$HELLO_OUTPUT" == "$EXPECTED" ]] && touch $out
      '';
    }) nixpkgs.legacyPackages;

    overlays.hello = final: prev: {
      hello = final.callPackage ./hello.nix { };
    };

    overlay = self.overlays.hello;

    nixosModules.hello = import ./module.nix;
  };
}
