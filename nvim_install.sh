#!/bin/bash

set -e

CMD=$1

if [ $CMD = "install" ]; then
  mkdir -p ~/OpenSrc
  pushd ~/OpenSrc/

  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  sudo rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

  echo "export PATH="$PATH:/opt/nvim-linux-x86_64/bin"" >>~/.profile
fi

if [ $CMD = "conf" ]; then
  # nvim_conf
  git clone https://github.com/zsdfbb/JackLazyNvim.git ~/.config/nvim

  mkdir -p ~/OpenSrc
  pushd ~/OpenSrc/
  if [ ! -d nerd-fonts ]; then
    mkdir -p ~/OpenSrc/nerd-fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.tar.xz -O ~/OpenSrc/nerd-fonts/FiraCode.tar.xz
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.tar.xz -O ~/OpenSrc/nerd-fonts/SourceCodePro.tar.xz
    tar -xf ~/OpenSrc/nerd-fonts/FiraCode.tar.xz -C ~/OpenSrc/nerd-fonts
    tar -xf ~/OpenSrc/nerd-fonts/SourceCodePro.tar.xz -C ~/OpenSrc/nerd-fonts

    mkdir -p ~/.local/share/fonts/NerdFonts
    cp ~/OpenSrc/nerd-fonts/*.ttf ~/.local/share/fonts/NerdFonts/
    fc-cache -fv
    echo "Notice: Modify Terminal fonts to Nerd-Fonts"
  fi
fi
