#!/bin/bash

CMD=$1

if [ $CMD = "install" ]; then
    sudo snap install nvim --classic
fi

if [ $CMD = "conf" ]; then
    # nvim_conf

    # https://spacevim.org/cn/
    curl -sLf https://spacevim.org/cn/install.sh | bash

    rm -rf ${HOME}/.SpaceVim.d/init.toml
    ln -s ${HOME}/Develop/myscript/spacevim/init.toml ${HOME}//.SpaceVim.d/init.toml
fi
