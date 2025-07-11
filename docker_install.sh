#!/bin/bash

function docker_install() {
    # 删除旧版
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
        sudo apt-get remove $pkg; 
    done
    sudo rm -rf /etc/apt/keyrings/docker.gpg

    VERSION_CODENAME=""
    grep  "Linux Mint" /etc/os-release
    if [ $? == 0 ]; then
      # you are in linuxmint
      VERSION_CODENAME="$(. /etc/os-release && echo "$UBUNTU_CODENAME")"
    else
      VERSION_CODENAME="$(. /etc/os-release && echo "$VERSION_CODENAME")"
    fi
    echo $VERSION_CODENAME

    # 安装docker
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    # curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
        "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
        "$VERSION_CODENAME" stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

function docker_accelerate() {
    # docker accelerate 加速器
    sudo touch /etc/docker/daemon.json
    sudo chmod 666 /etc/docker/daemon.json
    cat>/etc/docker/daemon.json<<EOF
    {
        "registry-mirrors": [
        "https://mirror.ccs.tencentyun.com"
        ]
    }
EOF
    sudo chmod 644 /etc/docker/daemon.json

    # 将用户添加到docker
    sudo gpasswd -a $USER docker
    newgrp docker
    docker version
}

CMD=$1
if [ $CMD = "install" ]; then
    # wsl的准备工作
    sudo update-alternatives --config iptables

    docker_install

    # wsl的启动docker和测试
    sudo service docker start
    sudo service docker status
    sudo docker run hello-world
fi

if [ $CMD = "acc" ]; then
    docker_accelerate
fi
