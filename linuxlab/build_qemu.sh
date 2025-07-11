#!/bin/bash

sudo apt-get install libglib2.0-dev

# v10.0.2
git clone --branch v10.0.2 --depth=1  https://github.com/qemu/qemu.git
cd qemu
mkdir build
cd build
../configure --prefix=$(pwd) --target-list=aarch64-softmmu --enable-slirp
ninja -j16
ninja install
