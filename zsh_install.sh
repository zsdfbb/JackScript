#!/bin/bash

# 安装并配置zsh
function zsh_install() {
    echo "Configure zsh"

    if ! [ -d $HOME/.oh-my-zsh ]; then
        git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
    fi

    if [ -e $HOME/.zshrc ]; then
        cp $HOME/.zshrc $HOME/.zshrc.orig
    fi
    cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
    chsh -s $(which zsh)

    echo "source $HOME/.profile" >> $HOME/.zshrc
    sed -i 's/ZSH_THEME=\".*\"/ZSH_THEME=\"crcandy\"/g' $HOME/.zshrc

    cat ./zshrc >> ${HOME}/.zshrc

    echo "Configure zsh OK!" 
    echo "NOTICE: Please log out from your user session and log back in to see this change"
}

zsh_install
