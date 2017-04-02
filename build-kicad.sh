#!/bin/bash 

DIR=$(dirname "$(readlink -f "$0")")
source $DIR/conf.sh

if [[ ! -d $ROOT ]]; then 
    echo "run ./prepare.sh first"
    exit
fi

sudo apt-get install libwxgtk3.0-0v5 libglew-dev libcairo2-dev libbz2-dev \
                     doxygen libssl-dev \
                     libboost-dev libboost-thread-dev libboost-context-dev \
                     libboost-filesystem-dev libboost-iostreams-dev \
                     libboost-locale-dev libboost-program-options-dev \
                     libboost-test-dev \
                     swig python-wxgtk3.0* 


cd $ROOT

git clean -f -d
git pull origin master

mkdir -p $BUILD_DIR
cd $BUILD_DIR

cmake \
  -DCMAKE_PREFIX_PATH=/usr/local \
  -DCMAKE_INSTALL_PREFIX=/usr/local \
  -DDEFAULT_INSTALL_PATH=/usr/local \
  -DCMAKE_BUILD_TYPE=Release \
  -DKICAD_SCRIPTING=ON \
  -DKICAD_SCRIPTING_MODULES=ON \
  -DKICAD_SCRIPTING_WXPYTHON=ON \
  -H"../../" \
  -B"$BUILD_DIR"

make -j 4
