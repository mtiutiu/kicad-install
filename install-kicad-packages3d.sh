#!/bin/bash
DIR=$(dirname "$(readlink -f "$0")")
source $DIR/conf.sh

KICAD_PACKAGES_3D=$DIR/kicad-packages3d
cd $KICAD_PACKAGES_3D
echo "Updating packages3d"
git pull
echo "Copying 3D drawings to default location"
sudo mkdir -p $KICAD_3DMOD_DIR
sudo rsync -avP ./*.3dshapes $KICAD_3DMOD_DIR
