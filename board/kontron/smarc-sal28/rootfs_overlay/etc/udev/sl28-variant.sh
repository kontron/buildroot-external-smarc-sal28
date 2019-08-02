#!/bin/sh
echo $(( $(devmem 0x1e00160 32) & 0xf ))
exit 0
