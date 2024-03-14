#!/bin/bash

function cond_install() {
    mkdir -p ${HOME}/Develop/tools
    cd ${HOME}/Develop/tools
    if ! [ -e Miniconda3-latest-Linux-x86_64.sh ]; then
        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    fi

    chmod +x Miniconda3-latest-Linux-x86_64.sh
    ./Miniconda3-latest-Linux-x86_64.sh -p ${HOME}/Develop/tools/miniconda
    cd -
}

function conda_conf() {
    echo "Start conda config"

    echo "" >>${HOME}/.profile
    echo "# Miniconda3 PATH" >>${HOME}/.profile
    echo "export PATH=${HOME}/Develop/tools/miniconda/bin:\${PATH}" >>${HOME}/.profile
    cat ${HOME}/.profile

    echo "Notice: Please source ~/.profile"
    echo "End conda config"
}

CMD=$1
if [ $CMD = "install" ]; then
    cond_install
fi

if [ $CMD = "conf" ]; then
    conda_conf
fi
