#!/bin/bash

cd syzkaller/
CC=aarch64-linux-gnu-g++
make TARGETARCH=arm64
