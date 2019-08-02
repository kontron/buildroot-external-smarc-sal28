#!/bin/sh

# replace %INSTALLVERSION%" with real U-Boot Version
UBOOT_VERSION=$(strings ${BINARIES_DIR}/u-boot-with-spl.bin | grep -E "^U-Boot [0-9]{4}")
sed -e "s/%INSTALLVERSION%/${UBOOT_VERSION}/g" ${BR2_EXTERNAL_SMARC_SAL28_PATH}/board/kontron/smarc-sal28/spi-flash-updater.cmd > ${BINARIES_DIR}/spi-flash-updater.cmd

$HOST_DIR/bin/mkimage -A arm64 -T script -C none -n "boot script" -d ${BINARIES_DIR}/spi-flash-updater.cmd ${BINARIES_DIR}/spi-flash-updater.scr
