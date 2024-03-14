#!/bin/bash

echo "Start install common software"

sudo apt update
sudo apt install tmux vim fzf fd-find git git-lfs \
    ripgrep curl wget tree unzip gcc make python3-venv python3-pip \
    shfmt 

echo "Common software is installed"
