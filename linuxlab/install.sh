#!/bin/bash

# BASE_DIR 是仓的linuxlab目录
BASE_DIR=$(pwd)

if [ "$1" = "" ];then
	LAB_DIR=${HOME}/Develop/LinuxLab
	mkdir -p $LAB_DIR
fi

#=================
# 安装依赖
#=================
sudo apt install qemu-system-aarch64 qemu-user \
	qemu-user-static gcc-aarch64-linux-gnu \
	binutils-aarch64-linux-gnu binutils-aarch64-linux-gnu-dbg \
	build-essential libncurses5-dev git bison flex \
	libssl-dev gdb gdb-multiarch cpio

#=================
# 准备目录
#=================
mkdir -p $LAB_DIR/busybox $LAB_DIR/busybox/build $LAB_DIR/busybox/install
cp $BASE_DIR/busybox_build.sh $LAB_DIR/busybox/build.sh
git clone --depth=1 https://github.com/mirror/busybox.git -b 1_36_stable $LAB_DIR/busybox/src

mkdir -p $LAB_DIR/linux $LAB_DIR/linux/build
cp $BASE_DIR/linux_build.sh $LAB_DIR/linux/build.sh
git clone --depth=1 https://github.com/torvalds/linux.git $LAB_DIR/linux/src

mkdir -p $LAB_DIR/buildroot $LAB_DIR/buildroot/build
cp $BASE_DIR/buildroot_build.sh $LAB_DIR/buildroot/build.sh
git clone --depth=1 https://github.com/buildroot/buildroot.git $LAB_DIR/buildroot/src

git clone --depth=1 https://github.com/google/syzkaller.git $LAB_DIR/syzkaller
cp $BASE_DIR/build_syzkaller.sh $LAB_DIR/build_syzkaller.sh

#=================
# 准备 rootfs
#=================
cp $BASE_DIR/mkroot.sh $LAB_DIR/

#=================
# 准备 qemu run
#=================
cp $BASE_DIR/qemu.run $LAB_DIR/
cp $BASE_DIR/qemu_syzkaller.run $LAB_DIR/

#=================
# 准备 syzkaller workspace
#=================
mkdir -p $LAB_DIR/syzkaller_workspace
cp $BASE_DIR/syzkaller.conf $LAB_DIR/syzkaller_workspace/

