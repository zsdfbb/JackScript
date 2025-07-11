#!/bin/bash

set -e
LAB_DIR=${HOME}/Develop/seL4Lab

function prepare_env() {
  mkdir -p $LAB_DIR
  cd $LAB_DIR

  if [ ! -d seL4-CAmkES-L4v-dockerfiles ]; then
    git clone https://github.com/seL4/seL4-CAmkES-L4v-dockerfiles.git
  fi
  cd seL4-CAmkES-L4v-dockerfiles
  make build_user_camkes
}

function init_repo() {
  mkdir -p $LAB_DIR/seL4test
  cd $LAB_DIR/seL4test
  repo init -u https://github.com/seL4/seL4test-manifest.git
  repo sync
}

function fix_code() {
  cd $LAB_DIR/seL4test/kernel/

  # 如果 $LAB_DIR/seL4test/kernel/config.cmake 中不包含 CMAKE_EXPORT_COMPILE_COMMANDS
  # 执行下面的命令：
  if grep -q "CMAKE_EXPORT_COMPILE_COMMANDS ON" config.cmake; then
    echo "config.cmake 中已经包含 CMAKE_EXPORT_COMPILE_COMMANDS"
    return
  fi
  echo "set(CMAKE_EXPORT_COMPILE_COMMANDS ON)" >>config.cmake
}

function prepare_tutorial() {
  mkdir -p $LAB_DIR/sel4-tutorials-manifest
  cd $LAB_DIR/sel4-tutorials-manifest
  repo init -u https://github.com/seL4/sel4-tutorials-manifest
  repo sync
}

CMD=$1
if [ $CMD = "all" ]; then
  prepare_env
  init_repo
  fix_code
fi

if [ $CMD = "init_repo" ]; then
  init_repo
  fix_code
  prepare_tutorial
  cp build.sh $LAB_DIR/
  cp run.sh $LAB_DIR/
fi
