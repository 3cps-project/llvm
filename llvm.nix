{
  lib,
  nix-gitignore,
  stdenv,
  cmake,
  ninja,
  python3,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "3cps-llvm";
  version = "22";

  src = lib.fileset.toSource {
    root = ./.;
    fileset = ./.;
  };
  sourceRoot = "${finalAttrs.src.name}/llvm";

  nativeBuildInputs = [
    cmake
    ninja
    python3
  ];

  cmakeBuildType = "Release";
  cmakeFlags = [
    (lib.cmakeFeature "LLVM_VERSION_SUFFIX" "-3cps")
    (lib.cmakeBool "LLVM_INSTALL_UTILS" true)
    (lib.cmakeBool "LLVM_BUILD_TESTS" false)
    (lib.cmakeFeature "LLVM_TARGETS_TO_BUILD" "X86;AArch64")
  ];

  meta = {
    homepage = "https://llvm.org/";
    description = "LLVM 22 with patches for 3CPS";
    license = [
      lib.licenses.asl20
      lib.licenses.ncsa
      lib.licenses.llvm-exception
    ];
  };
})
