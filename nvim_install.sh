#!/bin/bash

function apt_install() {
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim
    sudo apt-get install python-dev python-pip python3-dev python3-pip
    # sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    # sudo update-alternatives --config vi
    # sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    # sudo update-alternatives --config vim
    # sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    # sudo update-alternatives --config editor
}

function nvim_install() {
    if ! [ -e ${HOME}/Develop/tools/nvim-linux64/bin ]; then
        mkdir -p ${HOME}/Develop/tools
        cd ${HOME}/Develop/tools
        wget https://ghproxy.net/https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
        tar xf nvim-linux64.tar.gz
        cd -
    fi

    echo "" >> ${HOME}/.profile
    echo "# Neovim PATH" >> ${HOME}/.profile
    echo "export PATH=${HOME}/Develop/tools/nvim-linux64/bin:\${PATH}" >> ${HOME}/.profile
    cat ${HOME}/.profile
    source ${HOME}/.profile
}

function nvim_uninstall() {
    rm -rf ${HOME}/Develop/tools/nvim-linux64
    rm -rf ${HOME}/Develop/tools/nvim-linux64.tar.gz
    
    echo "NOTICE: Please delete neovim PATH fro ~/.profile"
}


CMD=$1

if [ $CMD = "nvim_install" ]; then
    nvim_install
fi

if [ $CMD = "nvim_uninstall" ]; then
   nvim_uninstall 
fi

if [ $CMD = "apt_install" ]; then
    apt_install
fi

if [ $CMD = "conf" ]; then
    # nvim_conf

    # https://spacevim.org/cn/
    curl -sLf https://spacevim.org/cn/install.sh | bash

    rm -rf ${HOME}/.SpaceVim.d/init.toml
    ln -s ${HOME}/Develop/myscript/spacevim/init.toml ${HOME}//.SpaceVim.d/init.toml
fi
