#! /bin/bash

BUILD=./src/

if [ $1 = "config" ]; then
    cd $BUILD
    make menuconfig
fi

if [ $1 = "build" ]; then
    cd $BUILD
    make
fi