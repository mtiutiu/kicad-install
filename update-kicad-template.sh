#!/bin/bash

DIR=$(dirname "$(readlink -f "$0")")
source $DIR/conf.sh

echo "Update Kicad Template"

TEMPLATE=$KICAD_DATA_DIR/template/kicad.pro

sudo crudini --del $TEMPLATE eeschema/libraries

cd $KICAD_LIBRARY_DIR

i=1
library_list=""
while read -rd $'\0' lib; do
	section_key="LibName$i"
	section_value=${lib%.*}
	echo "found default lib ($i): $section_value"
	library_list+=$"$section_key=$section_value\n"
	((i++))
done < <( find * -iname "*.lib" -print0  )

# debug
#echo -e $library_list
sudo crudini --merge $TEMPLATE eeschema/libraries < <( echo -e $library_list )
