#!/bin/bash

usage() {
    echo "Usage: $0 [OPTION]..."
    echo
    echo "Options:"
    echo "  -a, --arch x86    指定架构"
    echo "  -h, --help        显示此帮助信息"
    exit 0
}

ARCH="aarch64"

while getopts "a:h" opt; do
    case $opt in
        a) ARCH="$OPTARG" ;;
        h) usage ;;
        :) echo "错误: 选项 '-$OPTARG' 需要参数" >&2; usage ;;
        ?) echo "错误: 未知选项 '-$OPTARG'" >&2; usage ;;
    esac
done

if [ $ARCH = "x86" ]; then
    rm -rf ./seL4test/build-x86/
    mkdir -p ./seL4test/build-x86/
    cd ./seL4test/build-x86/
    ../init-build.sh -DPLATFORM=x86_64 -DSIMULATION=TRUE -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
    ninja
fi

if [ $ARCH = "aarch64" ]; then
    rm -rf ./seL4test/build_aarch64/
    mkdir -p ./seL4test/build_aarch64/
    cd ./seL4test/build_aarch64/
    ../init-build.sh -DPLATFORM=qemu-arm-virt -DSIMULATION=TRUE -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
    ninja
    # sed -i 's#/host/#/home/zs/Develop/SeL4/#g' compile_commands.json
fi
