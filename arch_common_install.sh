#!/bin/bash

echo "Start install common software"

sudo pacman -S tmux vim fzf git git-lfs \
    ripgrep curl wget tree unzip gcc make \
    shfmt man

echo "Common software is installed"
