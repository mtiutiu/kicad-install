#!/bin/bash
DIR=$(dirname "$(readlink -f "$0")")
source $DIR/conf.sh

# create necessary folders if not exist
sudo mkdir -p $KICAD_LIBRARY_DIR $KICAD_MODULES_DIR

# install custom and additional libraries (both pcbnew and eeschema libs)
copy_pcbnew_libs () {
    LIBDIR=$1
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
echo "copying eeschema libraries into $KICAD_LIBRARY_DIR"
for lib in $DIR/aktos-kicad-lib/*; do
    copy_eeschema_libs "$lib"
done

echo "copying pcbnew modules into $KICAD_MODULES_DIR"
for lib in $DIR/aktos-kicad-lib/*; do
    copy_pcbnew_libs "$lib"
done

echo "------------------ WARNING --------------------------"
echo "DO NOT FORGET UPDATING ~/.config/kicad/fp-lib-table"
echo "-----------------------------------------------------"
