#!/bin/sh

BOARD_DIR="$(dirname $0)"
MKIMAGE=$HOST_DIR/bin/mkimage
OBJCOPY=$HOST_DIR/bin/objcopy

if [ -e $BINARIES_DIR/rcw.bin ]; then
	objcopy -I binary -O binary --gap-fill 0xff --pad-to 0x10000 \
		$BINARIES_DIR/rcw.bin $BINARIES_DIR/rcw_pad.bin
fi

if [ -e $BINARIES_DIR/u-boot.bin ]; then
	objcopy -I binary -O binary --gap-fill 0xff --pad-to 0xf0000 \
		$BINARIES_DIR/u-boot.bin $BINARIES_DIR/u-boot_pad.bin
fi

if [ -e $BINARIES_DIR/ls1028a-dp-fw.bin ]; then
	objcopy -I binary -O binary --gap-fill 0xff --pad-to 0x40000 \
		$BINARIES_DIR/ls1028a-dp-fw.bin $BINARIES_DIR/ls1028a-dp-fw_pad.bin
fi

if [ -e $BINARIES_DIR/ppa.itb ]; then
	objcopy -I binary -O binary --gap-fill 0xff --pad-to 0xb0000 \
		$BINARIES_DIR/ppa.itb $BINARIES_DIR/ppa_pad.itb
fi

if [ -e $BINARIES_DIR/rcw_pad.bin -a \
     -e $BINARIES_DIR/u-boot_pad.bin -a \
     -e $BINARIES_DIR/ls1028a-dp-fw_pad.bin -a \
     -e $BINARIES_DIR/ppa_pad.itb ]; then
	cat $BINARIES_DIR/rcw_pad.bin \
		$BINARIES_DIR/u-boot_pad.bin \
		$BINARIES_DIR/ls1028a-dp-fw_pad.bin \
		$BINARIES_DIR/ppa_pad.itb \
		 > $BINARIES_DIR/flash.bin
fi

#if [ -e $BINARIES_DIR/ppfe-firmware.bin ]; then
#	objcopy -I binary -O binary --gap-fill 0xff --pad-to 0x20000 \
#		$BINARIES_DIR/ppfe-firmware.bin $BINARIES_DIR/ppfe-firmware_pad.bin
#fi
#
#if [ -e $BINARIES_DIR/rcw_pad.bin -a \
#     -e $BINARIES_DIR/u-boot_pad.bin -a \
#     -e $BINARIES_DIR/ppfe-firmware_pad.bin ]; then
#	cat $BINARIES_DIR/rcw_pad.bin \
#		$BINARIES_DIR/u-boot_pad.bin \
#		$BINARIES_DIR/ppfe-firmware_pad.bin \
#		 > $BINARIES_DIR/flash.bin
#fi
