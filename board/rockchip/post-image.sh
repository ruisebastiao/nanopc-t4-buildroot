#!/bin/sh

BOARD_DIR="$(dirname $0)"

echo "Coping board files"

cp ${BOARD_DIR}/boot.img ${BINARIES_DIR}/

echo "Preparing files to fuse dir"

# setup the image creation software
cp ${BOARD_DIR}/parameter.txt ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
cp ${BOARD_DIR}/boot.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
ln -sf ${BINARIES_DIR}/rootfs.ext2 ${BINARIES_DIR}/sd-fuse-rk3399/buildroot/rootfs.img

echo "Creating SD Card image"

# create the sdcard image
cd ${BINARIES_DIR}/sd-fuse-rk3399

./mk-sd-image.sh buildroot

echo "Creating EFlasher SD Card image"

./mk-emmc-image.sh buildroot

#echo "Creating Firmware image (OTA)"

# echo "Creating the params.bin file"
# PARAMS_NAME=${BINARIES_DIR}/params.bin
# cp $UBOOT_BUILD_DIR/common/env_common.o /tmp
# ${HOST_DIR}/usr/bin/aarch64-linux-objcopy -O binary --only-section=.rodata.default_environment /tmp/env_common.o
# tr '\0' '\n' < /tmp/env_common.o | grep '=' > ${BINARIES_DIR}/default_envs.txt
# rm /tmp/env_common.o
# sed -i -e 's/bootcmd=run .*/bootcmd=run mmcboot/g' ${BINARIES_DIR}/default_envs.txt
# ${UBOOT_BUILD_DIR}/tools/mkenvimage -s 16384 -o $PARAMS_NAME ${BINARIES_DIR}/default_envs.txt

#wget https://raw.githubusercontent.com/rockchip-linux/device-custom/master/rk3399/parameter-buildroot.txt -O ${BINARIES_DIR}/parameter.txt

# BOARD_DIR="$(dirname $BOARD_DIR)/board"

#echo BOARD_DIR $BOARD_DIR
#cp ${BOARD_DIR}/idbloader.img ${BINARIES_DIR}/
#cp ${BOARD_DIR}/param4sd.txt ${BINARIES_DIR}/
return
