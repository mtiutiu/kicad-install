#!/bin/bash 

DIR=$(dirname "$(readlink -f "$0")")

source $DIR/conf.sh
DATE=$(date +"%Y%d%m")
cd $BUILD_DIR
sudo cpack \
    -D CPACK_SYSTEM_NAME="kicad-$DATE-$(uname -m)" \
    -D CPACK_PACKAGE_NAME="kicad" \
    -D CPACK_PACKAGE_VERSION="$DATE" \
    -D CPACK_PACKAGE_VERSION_MAJOR="$DATE" \
    -D CPACK_PACKAGE_VERSION_MINOR="0" \
    -D CPACK_PACKAGE_VERSION_PATCH="0"

