#!/bin/sh

SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR" || exit 1

cmake -S llvm -B build -G "Ninja" --log-level=VERBOSE \
    -DLLVM_VERSION_SUFFIX="-3cps" \
    -DLLVM_INSTALL_UTILS=true \
    -DLLVM_TARGETS_TO_BUILD="X86;AArch64" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$SCRIPT_DIR/build-install"
cmake --build build --target install
