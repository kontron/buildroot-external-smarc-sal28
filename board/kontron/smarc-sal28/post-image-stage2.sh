#!/bin/sh

TMPDIR=$(mktemp -d)
cp ${BINARIES_DIR}/spi-flash-updater.scr ${TMPDIR}/boot.scr
cp ${BINARIES_DIR}/spi-flash.img ${TMPDIR}/
${HOST_DIR}/bin/zip -j ${BINARIES_DIR}/spi-flash-updater.zip ${TMPDIR}/*
rm -rf ${TMPDIR}
