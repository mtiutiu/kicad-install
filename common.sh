#!/bin/bash

. conf.sh

copy_pcbnew_libs () {
    LIBDIR=$1
    if [ ! -d $LIBDIR ]; then
        echo "Skipping $LIBDIR as it is not a directory..."
        sleep 1
        return 1
    fi
    LIBNAME=$(basename $LIBDIR)
    TARGET="$KICAD_MODULES_DIR/$LIBNAME"
    sudo rm -rf $TARGET
	sudo mkdir -p $TARGET
    while read -rd $'\0' i; do
	  FOOTPRINT_NAME=$(basename $i)
	  echo "in $LIBNAME, found pcbnew lib: $FOOTPRINT_NAME"
	  sudo cp -a "$i" $TARGET
    done < <( find $LIBDIR -type d -iname "*.pretty" -print0 )
	sudo chmod 755 $TARGET -R
}

copy_eeschema_libs () {
    LIBDIR=$1
    if [ ! -d $LIBDIR ]; then
        echo "Skipping $LIBDIR as it is not a directory..."
        sleep 1
        return 1
    fi
    LIBNAME=$(basename $LIBDIR)
    TARGET="$KICAD_LIBRARY_DIR/$LIBNAME"
    echo "Looking into $LIBDIR"
    sudo rm -rf $TARGET
	sudo mkdir -p $TARGET
	while read -rd $'\0' i; do
      LIBRARY_NAME=$(basename $i)
	  echo "in $LIBNAME, found eeschema lib: $LIBRARY_NAME"
	  sudo cp "$i" $TARGET
    done < <( find $LIBDIR \( -iname "*.lib" -o -iname "*.dcm" \) -print0 )
	sudo chmod 755 $TARGET -R
}

copy_packages3d () {
    LIBDIR=$1
    if [ ! -d $LIBDIR ]; then
        echo "Skipping $LIBDIR as it is not a directory..."
        sleep 1
        return 1
    fi
    LIBNAME=$(basename $LIBDIR)
    sudo mkdir -p $KICAD_3DMOD_DIR/$LIBNAME
    echo "Copying 3D drawings under $LIBNAME to $KICAD_3DMOD_DIR/$LIBNAME"
    sleep 3
    sudo rsync -avP --delete --include="*.3dshapes" --exclude="*" $LIBDIR/ $KICAD_3DMOD_DIR/$LIBNAME
}

install_lib_warning () {
    echo
    echo "------------------ WARNING --------------------------"
    echo "Do not forget to run:"
    echo "    ./update-fplib-table.sh"
    echo "    ./update-kicad-template.sh"
    echo "-----------------------------------------------------"
    echo
}