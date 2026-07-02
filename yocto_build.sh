#!/bin/bash

ensure_unique_line() {
    local file="$1"
    local line="$2"
    local tmp

    tmp=$(mktemp)
    awk -v target="$line" '
        $0 == target { seen = 1; next }
        { print }
        END { print target }
    ' "$file" > "$tmp"
    mv "$tmp" "$file"
}

# On HWD6 
export TOP_FOLDER="$(pwd)"
# export PATH="$(pwd)/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:/opt/python/3.8.2/bin:$(pwd)/u-boot-socfpga/scripts/dtc:$PATH"
# export ARCH=arm64
# export CROSS_COMPILE=aarch64-none-linux-gnu-
# export PYTHONHOME=/opt/python/3.8.2
# export PYTHONPATH=/opt/python/3.8.2

# On WSL
# export PATH="$(pwd)/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:/usr/lib/python3.14:$(pwd)/u-boot-socfpga/scripts/dtc:$PATH"
export PATH="$(pwd)/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:$(pwd)/u-boot-socfpga/scripts/dtc:$PATH"
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-

cd yocto
source poky/oe-init-build-env ./build 
ensure_unique_line conf/bblayers.conf 'BBLAYERS += " ${TOPDIR}/../meta-intel-fpga "'
ensure_unique_line conf/bblayers.conf 'BBLAYERS += " ${TOPDIR}/../meta-openembedded/meta-oe "'
ensure_unique_line conf/local.conf 'MACHINE = "agilex5"'
ensure_unique_line conf/local.conf 'KERNEL_PROVIDER="linux-socfpga-lts"'
ensure_unique_line conf/site.conf 'IMAGE_FSTYPES:append = " cpio cpio.gz cpio.gz.u-boot ext3 jffs2 tar.gz multiubi"'
bitbake core-image-minimal


