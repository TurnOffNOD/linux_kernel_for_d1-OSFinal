#!/bin/bash
path=/opt/huge_softs/Xuantie-900-gcc-elf-newlib-x86_64-V2.4.0
make -j8 ARCH=riscv  CROSS_COMPILE=${path}/bin/riscv64-unknown-linux-gnu-  \
&& ./rvboards_img/mkbootimg  --kernel  arch/riscv/boot//Image --board  d1-nezha --base  0x40200000 --kernel_offset  0x0 -o  ./rvboards_img/rvboards_boot.img
