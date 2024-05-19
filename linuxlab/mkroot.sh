#!/bin/bash

# 配置
IMAGE_FILE=rootfs_ext4.img
BUSYBOX_DIR=./busybox

# 执行
if [ -e $IMAGE_FILE ];then
    rm $IMAGE_FILE
fi

dd if=/dev/zero of=$IMAGE_FILE bs=1M count=256 oflag=direct
mkfs.ext4 $IMAGE_FILE

mkdir rootfs
sudo mount $IMAGE_FILE rootfs/
sudo cp -raf $BUSYBOX_DIR/install/* rootfs/

cd rootfs
sudo mkdir -p proc sys tmp root var mnt dev
sudo mknod dev/tty1 c 4 1
sudo mknod dev/tty2 c 4 2
sudo mknod dev/tty3 c 4 3
sudo mknod dev/tty4 c 4 4
sudo mknod dev/console c 5 1
sudo mknod dev/null c 1 3
sudo cp -r ../$BUSYBOX_DIR/src/examples/bootfloppy/etc/ .

cd ..
sudo umount rootfs
rmdir rootfs