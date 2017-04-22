#!/bin/bash
DIR=$(dirname "$(readlink -f "$0")")
. $DIR/conf.sh
. $DIR/common.sh

# create necessary folders if not exist
sudo mkdir -p $KICAD_LIBRARY_DIR $KICAD_MODULES_DIR

SRC_DIR=aktos-kicad-lib

echo "copying eeschema libraries into $KICAD_LIBRARY_DIR"
for lib in $DIR/$SRC_DIR/*; do
    copy_eeschema_libs "$lib"
done

echo "copying pcbnew modules into $KICAD_MODULES_DIR"
for lib in $DIR/$SRC_DIR/*; do
    copy_pcbnew_libs "$lib"
done

echo "copying 3d packages to $KICAD_3DMOD_DIR"
sudo mkdir -p $KICAD_3DMOD_DIR
for lib in $DIR/$SRC_DIR/*; do
    copy_packages3d "$lib"
done

install_lib_warning