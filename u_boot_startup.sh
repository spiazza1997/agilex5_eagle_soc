#!/bin/bash
set -euo pipefail

unset PYTHONHOME PYTHONPATH PYTHONPLATLIBDIR PYTHONSTARTUP PYTHONUSERBASE

export TOP_FOLDER=`pwd`
export PATH=`pwd`/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:/opt/python/3.8.2/bin:`pwd`/u-boot-socfpga/scripts/dtc:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
export PYTHONHOME=/opt/python/3.8.2
export PYTHONPATH=/opt/python/3.8.2

rm -rf uboot-script && mkdir uboot-script && cd uboot-script
wget https://raw.githubusercontent.com/ArrowElectronics/refdes-agilex5/QPDS24.2_REL_AGILEX5_GSRD_PR/scripts/uboot.txt
wget https://raw.githubusercontent.com/ArrowElectronics/refdes-agilex5/QPDS24.2_REL_AGILEX5_GSRD_PR/scripts/uboot_script.its
$TOP_FOLDER/u-boot-socfpga/tools/mkimage -f uboot_script.its boot.scr.uimg