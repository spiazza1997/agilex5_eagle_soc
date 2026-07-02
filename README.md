# agilex5_eagle_soc
Full build flow for Altera SoC. Includes FPGA image, ARM trusted firmware, Uboot, Linux kernel, and Yocto filesystem.

# WSL Configuration

WSL version:

C:\>wsl --version
WSL version: 2.7.8.0
Kernel version: 6.18.33.1-1
WSLg version: 1.0.73.2
MSRDC version: 1.2.6676
Direct3D version: 1.611.1-81528511
DXCore version: 10.0.26100.1-240331-1435.ge-release
Windows version: 10.0.26100.8457

Ubuntu distro install:

u151916@USROC8SDL018612:~$ uname -r
6.18.33.1-microsoft-standard-WSL2
u151916@USROC8SDL018612:~$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.5 LTS
Release:        22.04
Codename:       jammy

# Repo Configuration

Follows this guide:
https://github.com/ArrowElectronics/Agilex-5/wiki/Command-Line-Linux-24.2

Yocto local.config file comes from:
/home/u151916/agilex5_0/yocto/build/conf/local.conf

FPGA IP files come from:
/home/u151916/agilex5_0/ghrd-socfpga/axe5_eagle_ghrd/ip/hps_system/hps_system_emif_hps_ph2_1.ip
Line 2634 needs to change to your location.

/home/u151916/agilex5_0/ghrd-socfpga/axe5_eagle_ghrd/ip/emif_subsystem/emif_subsystem_emif_ph2_0.ip
Line 2659 needs to change to your location.

# Misc Notes

https://csconfluence.l3harris.com/spaces/FPGA/pages/844947685/Altera+SoC
