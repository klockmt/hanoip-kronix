#!/bin/bash
set -e
export ARCH=arm64
export SUBARCH=arm64
export PATH=$HOME/antman/bin:$PATH
export CC=clang
export CROSS_COMPILE=aarch64-linux-gnu-
export CROSS_COMPILE_ARM32=arm-linux-gnueabi-
export CLANG_TRIPLE=aarch64-linux-gnu-
export KCFLAGS="-Wno-error -Wno-designated-init -Wno-address"

echo "Using $(clang --version | head -n1)"

if [ ! -f .config ]; then
  make vendor/hanoip_defconfig
fi

make -j$(nproc --all) Image
ls -lh arch/arm64/boot/Image
