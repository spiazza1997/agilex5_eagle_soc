#!/bin/bash
set -euo pipefail

export TOP_FOLDER=`pwd`
export PATH=`pwd`/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:/opt/python/3.8.2/bin:`pwd`/u-boot-socfpga/scripts/dtc:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
export PYTHONHOME=/opt/python/3.8.2
export PYTHONPATH=/opt/python/3.8.2

# I am disabling the GCC plugins until HWD6 has the mpc.h library installed. Effect according to Codex:
# In this tree, removing GCC plugins mainly removes two hardening features that are currently enabled in your kernel config: STRUCTLEAK and RANDSTRUCT (linux-socfpga/.config:10646, linux-
#   socfpga/.config:10673).

#   - GCC_PLUGIN_STRUCTLEAK / ...BYREF_ALL: the kernel stops auto-zeroing stack variables that are passed by reference (linux-socfpga/security/Kconfig.hardening:94). Effect: weaker protection against
#     uninitialized stack data leaks and some uninitialized-memory bugs. Tradeoff: slightly less stack usage and less compile/runtime overhead.
#   - GCC_PLUGIN_RANDSTRUCT: sensitive kernel structures stop having randomized member layouts (linux-socfpga/security/Kconfig.hardening:311, linux-socfpga/security/Kconfig.hardening:371). Effect: weaker
#     resistance to kernel exploitation, especially attacks that depend on predictable structure layout. Tradeoff: easier debugging/forensics, predictable layouts for external tooling, and a small
#     performance/memory improvement.

#   Practical impact:

#   - It should not break normal kernel functionality by itself. The kernel can still build and boot.
#   - It does reduce security hardening.
#   - In your specific config, disabling CONFIG_GCC_PLUGINS globally is mostly equivalent to turning off those two protections, because no other GCC plugins are enabled (linux-socfpga/.config:826).

cd linux-socfpga 
make socfpga_agilex5_axe5_eagle_defconfig 
#make -j 64 Image && make arrow/socfpga_agilex5_axe5_eagle.dtb 
scripts/config --disable GCC_PLUGINS --enable INIT_STACK_NONE --enable RANDSTRUCT_NONE
make olddefconfig
make -j64 Image
make arrow/socfpga_agilex5_axe5_eagle.dtb

cd $TOP_FOLDER
rm -rf kernel_itb && mkdir kernel_itb && cd kernel_itb
wget https://raw.githubusercontent.com/ArrowElectronics/refdes-agilex5/QPDS24.2_REL_AGILEX5_GSRD_PR/scripts/fit_kernel_agilex5.its
cp $TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/arrow/socfpga_agilex5_axe5_eagle.dtb socfpga_agilex5_axe5_eagle.dtb
cp $TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image Image
$TOP_FOLDER/u-boot-socfpga/tools/mkimage -f fit_kernel_agilex5.its kernel.itb