# Motorola SM6150 (Hanoip) Kernel with KernelSU Next

Custom kernel for Motorola Moto G60 (hanoip) based on SM6150, with manual KernelSU Next integration.

**Device:** Moto G60 (hanoip) | **SoC:** SM6150 | **Kernel:** 4.14.356 (non-GKI) | **Slot:** A/B

## Base Source

This kernel is based on the v15 branch from cool585:
https://github.com/cool585/android_kernel_motorola_sm6150

All upstream changes from his v15 history were kept as base:
https://github.com/cool585/android_kernel_motorola_sm6150/commits/v15/

Huge thanks to cool585 for maintaining the SM6150 tree for hanoip.

## Features vs Upstream

- KernelSU Next v3.3.0-legacy integrated via manual hooks
    - Hooks in: fs/exec.c, fs/open.c, fs/read_write.c, fs/stat.c, kernel/reboot.c
    - Extra patches: fs/internal.h, fs/namespace.c, include/linux/seccomp.h, security/selinux/*, drivers/Kconfig, drivers/Makefile
- Modern Clang compatibility - Fixed TRACE_INCLUDE_PATH for LLVM 17+ toolchains
- Defconfig updated - vendor/hanoip_defconfig with CONFIG_KSU=y, CONFIG_HID_QVR=n
- Tested - 42MB Image flashed via FKM, AnyKernel3 with IS_SLOT_DEVICE=1

## Building

Requirements:
- Modern Clang toolchain 17+ (Neutron-Clang will be used for next SukiSU Ultra builds)
- GCC aarch64-linux-gnu-
- bc bison flex libelf openssl

Build:
    export PATH=/path/to/clang/bin:$PATH
    export CC=clang
    export CROSS_COMPILE=aarch64-linux-gnu-
    export CROSS_COMPILE_ARM32=arm-linux-gnueabi-
    export CLANG_TRIPLE=aarch64-linux-gnu-
    export KCFLAGS="-Wno-error -Wno-designated-init -Wno-address"
    make vendor/hanoip_defconfig
    make -j$(nproc) Image

## Flashing

1. Copy arch/arm64/boot/Image to AnyKernel3 folder
2. Set in anykernel.sh: device.name1=hanoip, IS_SLOT_DEVICE=1
3. Zip and flash via TWRP/OrangeFox

## Credits

- cool585 - Base kernel source SM6150 v15
- KernelSU Next - KernelSU-Next/KernelSU-Next
- AnyKernel3 - osm0sis/AnyKernel3

## License

GPL-2.0
