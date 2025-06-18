#!/bin/bash

echo "Start install common software"

sudo apt update
sudo apt install tmux vim fzf fd-find git git-lfs \
    ripgrep curl wget tree unzip gcc make python3-venv python3-pip \
    shfmt net-tools cpio bear

# configuration ubuntu server network
# sudo ifconfig enp0s8 192.168.56.110 netmask 255.255.255.0

echo "Common software is installed"
