{
  description = "LLVM Compiler with 3CPS fixes";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      pkgsFor = system: nixpkgs.legacyPackages.${system};
      forEachSystem = f: lib.genAttrs systems (system: f system);
    in
    {
      packages = forEachSystem (system: {
        llvm = (pkgsFor system).callPackage ./llvm.nix { };
      });
      devShells = forEachSystem (system: {
        default = (pkgsFor system).mkShell {
          inputsFrom = [ self.packages.${system}.llvm ];
        };
      });
      formatter = forEachSystem (system: (pkgsFor system).nixfmt-tree);
    };
}
