#!/bin/sh

$HOST_DIR/bin/mkimage -A arm64 -T script -C none -n "boot script" -d ${BR2_EXTERNAL_SMARC_SAL28_PATH}/board/kontron/smarc-sal28/spi-flash-updater.cmd ${BINARIES_DIR}/spi-flash-updater.scr
