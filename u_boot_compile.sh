#!/bin/bash
set -euo pipefail

unset PYTHONHOME PYTHONPATH PYTHONPLATLIBDIR PYTHONSTARTUP PYTHONUSERBASE

export TOP_FOLDER=`pwd`
export PATH=`pwd`/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:/opt/python/3.8.2/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
export PYTHONHOME=/opt/python/3.8.2
export PYTHONPATH=/opt/python/3.8.2

# rm -rf u-boot-socfpga 
# git clone -b QPDS24.2_REL_AGILEX5_GSRD_PR https://github.com/ArrowElectronics/u-boot-socfpga u-boot-socfpga 
cd u-boot-socfpga
make clean && make mrproper 
make socfpga_agilex5_axe5_eagle_defconfig
# use custom configuration file to merge with the default configuration obtained in .config file. 
./scripts/kconfig/merge_config.sh -O . -m .config config-fragment
ln -sf ../arm-trusted-firmware/build/agilex5/release/bl31.bin 
make -j 64
