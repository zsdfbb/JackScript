#!/bin/bash

function spider_install() {
    mkdir -p ${HOME}/Develop/tools
    cd ${HOME}/Develop/tools

    # 安装 phantomjs
    if ! [ -e phantomjs-2.1.1-linux-x86_64.tar.bz2 ]; then
        wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
        tar xf phantomjs-2.1.1-linux-x86_64.tar.bz2
        mv phantomjs-2.1.1-linux-x86_64 phantomjs
    fi
    cd -

    # 安装 selenium
    pip install selenium

}

function spider_conf() {
    echo "" >> ${HOME}/.profile
    echo "# Spider PATH" >> ${HOME}/.profile
    echo "export PATH=${HOME}/Develop/tools/phantomjs/bin:\${PATH}" >> ${HOME}/.profile
    cat ${HOME}/.profile
    source ${HOME}/.profile
}

CMD=$1
if [ $CMD = "conf" ]; then
    spider_conf
fi

if [ $CMD = "install" ]; then
    spider_conf
fi