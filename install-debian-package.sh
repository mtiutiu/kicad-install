#!/bin/bash 

DIR=$(dirname "$(readlink -f "$0")")

source $DIR/conf.sh
cd $BUILD_DIR
sudo checkinstall -D make install
