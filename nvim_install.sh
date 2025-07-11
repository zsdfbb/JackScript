#!/bin/bash

set -e

CMD=$1

if [ $CMD = "install" ]; then
  mkdir -p ~/OpenSrc
  pushd ~/OpenSrc/

  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  sudo rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

  echo "export PATH="$PATH:/opt/nvim-linux-x86_64/bin"" >> ~/.profile

  if [ ! -d nerd-fonts ]; then
    git clone https://github.com/ryanoasis/nerd-fonts.git --depth=1
    pushd ~/OpenSrc/nerd-fonts
    chmod +x ./install.sh
    ./install.sh
    echo "Notice: Modify Terminal fonts to Nerd-Fonts"
  fi
fi

if [ $CMD = "conf" ]; then
  # nvim_conf
  git clone https://github.com/zsdfbb/JackLazyNvim.git ~/.config/nvim
fi
