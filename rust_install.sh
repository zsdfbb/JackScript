#!/bin/bash

function rust_install() {
    echo "Start configure Rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    echo "End configure Rust"
}

rust_install
