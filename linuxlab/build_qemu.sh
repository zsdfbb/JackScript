#!/bin/bash

git clone https://github.com/qemu/qemu.git
cd qemu
mkdir build
cd build
../configure --prefix=$(pwd) --target-list=aarch64-softmmu --enable-slirp
ninja -j16
ninja install
