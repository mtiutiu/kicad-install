#!/bin/bash
DIR=$(dirname "$(readlink -f "$0")")

if false; then 
	./kicad/scripts/library-repos-install.sh  --install-prerequisites
	./kicad/scripts/library-repos-install.sh  --install-or-update
	cp $DIR/kicad-library/template/fp-lib-table.for-pretty \
	    ~/.config/kicad/fp-lib-table

	echo "export KISYSMOD=~/kicad_sources/library-repos" | sudo tee /etc/profile.d/kicad.sh
fi


source conf.sh

# *.pretty, *.kicad_pcb should go to this directory
KICAD_MODULES_DIR="$KICAD_DATA_DIR/modules"

# *.lib, *.dcm should go to this directory
KICAD_LIBRARY_DIR="$KICAD_DATA_DIR/library"

sudo mkdir -p $KICAD_LIBRARY_DIR $KICAD_MODULES_DIR

# install default kicad-libraries 
echo "Installing default kicad libraries"
sudo cp $DIR/kicad-library/library/*.{lib,dcm} $KICAD_LIBRARY_DIR

TEMPLATE=$KICAD_DATA_DIR/template/kicad.pro 

sudo crudini --del $TEMPLATE eeschema/libraries

i=1
tmp=""
for lib in $DIR/kicad-library/library/*.lib ; do
	section_key="LibName$i"
	section_value=$(basename "${lib%.*}")
	echo "found default lib ($i): $section_value"
	tmp+=$"$section_key=$section_value\n"
	((i++))
done
sudo crudini --merge $TEMPLATE eeschema/libraries < <( echo -e $tmp )

# install custom and additional libraries (both pcbnew and eeschema libs)

copy_pcbnew_libs () {
	for i in `find $1 -iname "*.pretty"`; do
	  NAME=$(basename $i)
	  PARENT_NAME=$(basename $(dirname $i))
	  TARGET="$KICAD_MODULES_DIR/$PARENT_NAME/$NAME"
	  echo "found pcbnew lib: $i, ($NAME) (($PARENT_NAME))"
	  mkdir -p "$KICAD_MODULES_DIR/$PARENT_NAME"
	  cp -a "$i" "$(dirname $TARGET)"
	  chmod 755 $TARGET -R
	done
}


copy_eeschema_libs () {
	for i in `find $1 -iname "*.lib" -o -iname "*.dcm"`; do
	  NAME=$(basename $i)
	  PARENT_NAME=$(basename $(dirname $i))
	  TARGET="$KICAD_LIBRARY_DIR/$PARENT_NAME/$NAME"
	  echo "found eeschema lib: $i, ($NAME)"
	  mkdir -p "$KICAD_LIBRARY_DIR/$PARENT_NAME"
	  #cp -a "$i" "$(dirname $TARGET)"
	  chmod 755 $TARGET -R
	done
}


