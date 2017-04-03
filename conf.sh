#!/bin/bash 

DIR=$(dirname "$(readlink -f "$0")")
ROOT=$DIR/kicad
BUILD_DIR=$ROOT/build/release
KICAD_INSTALL_PREFIX=/usr
KICAD_DATA_DIR=$KICAD_INSTALL_PREFIX/share/kicad
