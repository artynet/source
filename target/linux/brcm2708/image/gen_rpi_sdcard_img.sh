#!/usr/bin/env bash

set -x 
[ $# -eq 7 ] || {
    echo "SYNTAX: $0 <file> <bootfs image> <rootfs image> <bootfs size> <rootfs size> <extra-rootfs image> <extra-rootfs size>"
    exit 1
}

OUTPUT="$1"
BOOTFS="$2"
ROOTFS="$3"
BOOTFSSIZE="$4"
ROOTFSSIZE="$5"
EXTROOTFS="$6"
EXTROOTFSSIZE="$7"

head=4
sect=63

set `ptgen -o $OUTPUT -h $head -s $sect -l 4096 -t c -p ${BOOTFSSIZE}M -t 83 -p ${ROOTFSSIZE}M -t 83 -p ${EXTROOTFSSIZE}M`

BOOTOFFSET="$(($1 / 512))"
BOOTSIZE="$(($2 / 512))"
ROOTFSOFFSET="$(($3 / 512))"
ROOTFSSIZE="$(($4 / 512))"
EXTROOTFSOFFSET="$(($5 / 512))"
EXTROOTFSSIZE="$(($6 / 512))"

dd bs=512 if="$BOOTFS" of="$OUTPUT" seek="$BOOTOFFSET" conv=notrunc
dd bs=512 if="$ROOTFS" of="$OUTPUT" seek="$ROOTFSOFFSET" conv=notrunc
dd bs=512 if="$EXTROOTFS" of="$OUTPUT" seek="$EXTROOTFSOFFSET" conv=notrunc



