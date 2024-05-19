#!/bin/bash

# BASE_DIR 是仓的linuxlab目录
BASE_DIR=$(pwd)

LAB_DIR=${HOME}/Develop/LinuxLab
mkdir -p $LAB_DIR

#=================
# 安装依赖
#=================
sudo apt install qemu-system-aarch64 qemu-user \
	qemu-user-static gcc-aarch64-linux-gnu \
	binutils-aarch64-linux-gnu binutils-aarch64-linux-gnu-dbg \
	build-essential libncurses5-dev git bison flex \
	libssl-dev gdb gdb-multiarch

#=================
# 准备目录
#=================
mkdir -p $LAB_DIR/busybox \
	$LAB_DIR/busybox/build \
	$LAB_DIR/busybox/src \
	$LAB_DIR/busybox/install
cp $BASE_DIR/busybox_build.sh $LAB_DIR/busybox/build.sh

mkdir -p $LAB_DIR/linux \
	$LAB_DIR/linux/build \
	$LAB_DIR/linux/src \
	$LAB_DIR/linux/install
cp $BASE_DIR/linux_build.sh $LAB_DIR/busybox/build.sh

#=================
# 准备 rootfs
#=================
cp $BASE_DIR/mkroot.sh $LAB_DIR/

#=================
# 准备 qemu run
#=================
cp $BASE_DIR/qemu.run $LAB_DIR/