#! /bin/bash

# 配置
WORK_DIR=/home/shuai/LinuxLab/busybox
SRC=$WORK_DIR/src
BUILD=$WORK_DIR/build
INSTALL=$WORK_DIR/install

# 执行
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-

if [ ! -d $BUILD ];then 
    mkdir ./build
fi

if [ ! -d $INSTALL ];then 
    mkdir ./install
fi

if [ $1 = "config" ]; then
    cd $BUILD
    make KBUILD_SRC=$SRC -f $SRC/Makefile defconfig
    make menuconfig
fi

if [ $1 = "build" ]; then
    cd $BUILD
    make -j16 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
fi

if [ $1 = "install" ]; then
    cd $BUILD
    make -j16 CONFIG_PREFIX=${INSTALL} install
fi

if [ $1 = "clean" ]; then
    cd $BUILD
    make clean
fi