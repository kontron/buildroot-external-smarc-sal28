#!/bin/sh

# This script has be called after genimage.

cp ${BR2_EXTERNAL_SMARC_SAL28_PATH}/board/kontron/smarc-sal28/spi-flash-updater.cmd ${BINARIES_DIR}/spi-flash-updater.cmd

# replace %INSTALLVERSION%" with real U-Boot Version
UBOOT_VERSION=$(strings ${BINARIES_DIR}/u-boot-with-spl.bin | grep -E "^U-Boot [0-9]{4}")
sed --in-place -e "s/%INSTALLVERSION%/${UBOOT_VERSION}/g" ${BINARIES_DIR}/spi-flash-updater.cmd

# replace %SHA1CHECKSUM%" with value from sha1sum of spi-flash.img
SHA1CHECKSUM=$(sha1sum ${BINARIES_DIR}/spi-flash.img | awk '{print $1}')
sed --in-place -e "s/%SHA1CHECKSUM%/${SHA1CHECKSUM}/g" ${BINARIES_DIR}/spi-flash-updater.cmd

${HOST_DIR}/bin/mkimage -A arm64 -T script -C none -n "boot script" -d ${BINARIES_DIR}/spi-flash-updater.cmd ${BINARIES_DIR}/spi-flash-updater.scr


# create spi-flash-updater.img
BOARD_DIR="$(dirname $0)"
GENIMAGE_CFG="${BOARD_DIR}/genimage-updater.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
rm -rf "${GENIMAGE_TMP}"

genimage \
    --rootpath "${TARGET_DIR}" \
    --tmppath "${GENIMAGE_TMP}" \
    --inputpath "${BINARIES_DIR}" \
    --outputpath "${BINARIES_DIR}" \
    --config "${GENIMAGE_CFG}"

# create spi-flash-updater.zip
TMPDIR=$(mktemp -d)
cp ${BINARIES_DIR}/spi-flash-updater.scr ${TMPDIR}/boot.scr
cp ${BINARIES_DIR}/spi-flash.img ${TMPDIR}/
${HOST_DIR}/bin/zip -j ${BINARIES_DIR}/spi-flash-updater.zip ${TMPDIR}/*
rm -rf ${TMPDIR}
