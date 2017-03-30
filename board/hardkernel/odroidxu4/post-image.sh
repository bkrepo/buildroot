#!/bin/sh

BOARD_DIR="$(dirname $0)"
GENIMAGE_CFG="${BOARD_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

cp ${BOARD_DIR}/boot.ini ${BINARIES_DIR}/

rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

# Write u-boot and firmwares to image file
dd if=${BINARIES_DIR}/odroid-firmware/bl1.bin of=${BINARIES_DIR}/sdcard.img seek=1 conv=fsync,notrunc
dd if=${BINARIES_DIR}/odroid-firmware/bl2.bin of=${BINARIES_DIR}/sdcard.img seek=31 conv=fsync,notrunc
dd if=${BINARIES_DIR}/u-boot.bin of=${BINARIES_DIR}/sdcard.img seek=63 conv=fsync,notrunc
dd if=${BINARIES_DIR}/odroid-firmware/tzsw.bin of=${BINARIES_DIR}/sdcard.img seek=719 conv=fsync,notrunc

# Clean U-boot environment area
dd if=/dev/zero of=${BINARIES_DIR}/sdcard.img seek=1231 count=32 bs=512 conv=fsync,notrunc
