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

if [ $CMD = "pack" ]; then
  set -euo pipefail

  # 源路径（你的本地配置目录和插件目录）
  NVIM_CONFIG="${HOME}/.config/nvim"
  NVIM_LAZY="${HOME}/.local/share/nvim/lazy"

  # 输出文件名
  OUTPUT="nvim_lazy_bundle.tar.gz"

  # 确保 lazy-lock.json 存在（记录插件版本）
  if [[ ! -f "${NVIM_CONFIG}/lazy-lock.json" ]]; then
    echo "lazy-lock.json 不存在，请先在 nvim 里执行 :Lazy sync"
    exit 1
  fi

  # 打包配置和插件
  echo "正在打包 Neovim 配置和插件..."
  tar -czf "${OUTPUT}" \
    -C "${HOME}/.config" nvim \
    -C "${HOME}/.local/share/nvim" lazy

  echo "打包完成: ${OUTPUT}"
fi
