#!/bin/bash 

DIR=$(dirname "$(readlink -f "$0")")

source $DIR/conf.sh
DATE=$(date +"%Y%d%m")
cd $BUILD_DIR

PACKAGE_NAME="kicad-$DATE-$(uname -m)"

echo "Creating $PACKAGE_NAME"

START_TIME=$SECONDS
sudo cpack \
    -D DESTDIR=KICAD_INSTALL_PREFIX \
    -D CPACK_PACKAGE_FILE_NAME="$PACKAGE_NAME" \
    -D CPACK_PACKAGE_NAME="kicad" \
    -D CPACK_PACKAGE_VERSION="$DATE" \
    -D CPACK_PACKAGE_VERSION_MAJOR="$DATE" \
    -D CPACK_PACKAGE_VERSION_MINOR="0" \
    -D CPACK_PACKAGE_VERSION_PATCH="0"

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo 
echo "(process took $ELAPSED_TIME seconds...)"
echo 
echo "You can install generated package by issuing the following command: "
echo
echo "    sudo dpkg -i $BUILD_DIR/$PACKAGE_NAME.deb"
echo
