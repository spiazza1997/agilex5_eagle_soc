export TOP_FOLDER=`pwd`
cd $TOP_FOLDER/ghrd-socfpga/axe5_eagle_ghrd/output_files/
# Make the SOF file for the FPGA
quartus_pfg -c axe5_eagle_top.sof  axe5_eagle_top_hps.sof -o hps_path=../../../u-boot-socfpga/spl/u-boot-spl-dtb.hex

# Make the JIC file for NVM
quartus_pfg -c axe5_eagle_top.sof axe5_eagle_top_hps.jic -o device=MT25QU02G -o flash_loader=A5ED065BB32AE5SR0 -o hps_path=../../../u-boot-socfpga/spl/u-boot-spl-dtb.hex -o mode=ASX4