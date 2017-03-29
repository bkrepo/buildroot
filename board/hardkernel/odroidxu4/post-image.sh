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

# Download firmwares
wget https://github.com/hardkernel/u-boot/raw/odroidxu3-v2012.07/sd_fuse/hardkernel/bl1.bin.hardkernel -O ${BINARIES_DIR}/bl1.bin
wget https://github.com/hardkernel/u-boot/raw/odroidxu3-v2012.07/sd_fuse/hardkernel/bl2.bin.hardkernel -O ${BINARIES_DIR}/bl2.bin
wget https://github.com/hardkernel/u-boot/raw/odroidxu3-v2012.07/sd_fuse/hardkernel/tzsw.bin.hardkernel -O ${BINARIES_DIR}/tzsw.bin

# Write u-boot and firmwares to image file
dd if=${BINARIES_DIR}/bl1.bin of=${BINARIES_DIR}/sdcard.img seek=1 conv=fsync,notrunc
dd if=${BINARIES_DIR}/bl2.bin of=${BINARIES_DIR}/sdcard.img seek=31 conv=fsync,notrunc
dd if=${BINARIES_DIR}/u-boot.bin of=${BINARIES_DIR}/sdcard.img seek=63 conv=fsync,notrunc
dd if=${BINARIES_DIR}/tzsw.bin of=${BINARIES_DIR}/sdcard.img seek=719 conv=fsync,notrunc
# Clean U-boot environment area
dd if=/dev/zero of=${BINARIES_DIR}/sdcard.img seek=1231 count=32 bs=512 conv=fsync,notrunc
