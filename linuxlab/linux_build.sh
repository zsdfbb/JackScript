#!/bin/bash

#! /bin/bash

WORK_DIR=${PWD}
SRC=$WORK_DIR/src
BUILD=$WORK_DIR/build

export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-

if [ ! -d $BUILD ];then 
    mkdir ./build
fi

if [ $1 = "config" ]; then
    cd $BUILD
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=./ defconfig -f $SRC/Makefile
fi

if [ $1 = "build" ]; then
    cd $BUILD
    make -j16 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
fi

if [ $1 = "clean" ]; then
    cd $BUILD
    make clean
fi