#!/bin/bash

# https://v2raya.org/en/docs/prologue/installation/debian/
#
CMD=$1
if [ CMD = "install" ]; then
  wget https://github.com/v2rayA/v2rayA/releases/download/v2.2.6.7/installer_debian_x64_2.2.6.7.debian
  sudo apt install ./installer_debian_x64_2.2.6.7.deb

  sudo systemctl start v2raya.service
  sudo systemctl enable v2raya.service
fi

if [ $CMD = "data" ]; then
  wget https://github.com/v2fly/v2ray-core/releases/download/v5.37.0/v2ray-linux-64.zip
  mkdir v2ray_tmp
  unzip v2ray-linux-64.zip ./v2ray_tmp
  suco cp ./v2ray_tmp/v2ray /use/bin

  cd /etc/v2raya/
  wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
  wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
fi
