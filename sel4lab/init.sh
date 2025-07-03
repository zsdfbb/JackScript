#!/bin/bash

LAB_DIR=${HOME}/Develop/seL4Lab

function prepare_env() { 
    mkdir -P $LAB_DIR
    cd $LAB_DIR

    git clone https://github.com/seL4/seL4-CAmkES-L4v-dockerfiles.git
    cd seL4-CAmkES-L4v-dockerfiles
    make build_user_camkes 
}


function init_repo() {
    mkdir -P $LAB_DIR
    cd $LAB_DIR
    repo init -u https://github.com/seL4/seL4test-manifest.git
    repo sync
}

prepare_env
init_repo