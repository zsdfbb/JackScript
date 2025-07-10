#!/bin/bash

set -e

CMD=$1

if [ $CMD = "install" ]; then
  sudo snap install nvim --classic

  mkdir -p ~/OpenSrc
  pushd ~/OpenSrc/
  git clone https://github.com/ryanoasis/nerd-fonts.git --depth=1
  pushd ~/OpenSrc/nerd-fonts
  chmod +x ./install.sh
  ./install.sh
  echo "Notice: Modify Terminal fonts to Nerd-Fonts"
fi

if [ $CMD = "conf" ]; then
  # nvim_conf
  git clone https://github.com/zsdfbb/JackLazyNvim.git ~/.config/nvim
fi
