#!/bin/bash
path=../tina-sdk-d1
make -j8 ARCH=riscv  CROSS_COMPILE=${path}/lichee/brandy-2.0/tools/toolchain/riscv64-glibc-gcc-thead_20200702/bin/riscv64-unknown-linux-gnu-  \
&& ./rvboards_img/mkbootimg  --kernel  arch/riscv/boot//Image --board  d1-nezha --base  0x40200000 --kernel_offset  0x0 -o  ./rvboards_img/rvboards_boot.img
