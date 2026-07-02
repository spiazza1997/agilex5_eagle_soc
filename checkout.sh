#!/bin/bash
export TOP_FOLDER=`pwd`
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-

wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz --no-check-certificate
tar xf gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
rm -f gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz

# Temporarily pulling from external repos until we decide how much of this we should own internally 
# Could make an L3H repo and keep it synced with outside stuff 
git config --global http.sslVerify false

# FPGA Golden HW Reference 
git clone -b QPDS24.2.0.40_REL_GHRD https://github.com/ArrowElectronics/ghrd-socfpga ghrd-socfpga

# ARM Trusted Firmware Bootloader 
git clone -b QPDS24.2_REL_AGILEX5_GSRD_PR https://github.com/ArrowElectronics/arm-trusted-firmware arm-trusted-firmware

# U-Boot Linux Bootloader 
git clone -b QPDS24.2_REL_AGILEX5_GSRD_PR https://github.com/ArrowElectronics/u-boot-socfpga u-boot-socfpga

# Linux kernel 
# For some reason, Altera guide says to pull and build this tag, but Yocto is trying to build the socfpga-6.1.68-lts branch in the same guide
# git clone -b QPDS24.2_REL_AGILEX5_GSRD_PR --depth=1 https://github.com/ArrowElectronics/linux-socfpga linux-socfpga 
git clone -b socfpga-6.1.68-lts --depth=1 https://github.com/altera-fpga/linux-socfpga.git linux-socfpga-branch
# git clone -b socfpga-6.1.68-lts --depth=1 https://github.com/ArrowElectronics/linux-socfpga linux-socfpga-branch

# Yocto (for embedded version of Linux)
git clone -b nanbield --depth=1 https://git.yoctoproject.org/poky ./yocto/poky
git clone -b QPDS24.1_REL_AGILEX5_GSRD_PR --depth=1 https://git.yoctoproject.org/meta-intel-fpga ./yocto/meta-intel-fpga
git clone -b nanbield --depth=1 https://github.com/openembedded/meta-openembedded ./yocto/meta-openembedded

git config --global http.sslVerify true
