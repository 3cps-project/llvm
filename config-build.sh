#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
cmake -S llvm -B build -G "Ninja" --log-level=VERBOSE \
  -DLLVM_ENABLE_PROJECTS="clang" \
  -DCMAKE_INSTALL_PREFIX="$SCRIPT_DIR/dist" \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DLLVM_USE_LINKER=mold \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DLLVM_TARGETS_TO_BUILD=Native \
  -DLLVM_DISTRIBUTION_COMPONENTS="llvm-as;llvm-dis;llvm-link;opt;llc;clang" \
  -DLLVM_PARALLEL_LINK_JOBS=2

