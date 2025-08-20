#!/bin/bash

elf=$1
readelf -S $elf | grep .text | grep -oe '\bf[0-9a-fA-F]\{15\}\b'
