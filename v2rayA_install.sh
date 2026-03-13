#!/bin/bash

# https://v2raya.org/en/docs/prologue/installation/debian/
#
CMD=$1

if [ $CMD = "install" ]; then
  if [ ! -f "installer_debian_x64_2.2.6.7.deb" ]; then
    wget https://gh-proxy.org/https://github.com/v2rayA/v2rayA/releases/download/v2.2.6.7/installer_debian_x64_2.2.6.7.deb
  else
    echo "installer_debian_x64_2.2.6.7.deb 已存在，跳过下载"
  fi

  sudo apt install ./installer_debian_x64_2.2.6.7.deb

  sudo systemctl start v2raya.service
  sudo systemctl enable v2raya.service
fi

if [ $CMD = "prepare" ]; then
  if [ ! -f "v2ray-linux-64.zip" ]; then
    wget "https://gh-proxy.org/https://github.com/v2fly/v2ray-core/releases/download/v5.37.0/v2ray-linux-64.zip"
    mkdir -p v2ray_tmp
    unzip v2ray-linux-64.zip -d ./v2ray_tmp/
    sudo cp ./v2ray_tmp/v2ray /usr/bin
    sudo chmod 777 /etc/v2raya
    sudo chmod 777 /etc/v2raya/config.json
    sudo echo "{\"v2ray_path\": \"/usr/bin/v2ray\"}" > /etc/v2raya/config.json
  else
    echo "v2ray-linux-64.zip 已存在，跳过下载"
  fi

  sudo mkdir -p /usr/local/share/v2ray
  if [ ! -f "/usr/local/share/v2ray/geoip.dat" ]; then
    sudo wget -P /usr/local/share/v2ray "https://gh-proxy.org/https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
  else
    echo "geoip.dat 已存在，跳过下载"
  fi

  if [ ! -f "/usr/local/share/v2ray/geosite.dat" ]; then
    sudo wget -P /usr/local/share/v2ray "https://gh-proxy.org/https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
  else
    echo "geosite.dat 已存在，跳过下载"
  fi
fi
