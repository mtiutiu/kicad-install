#!/bin/bash
DIR=$(dirname "$(readlink -f "$0")")
source $DIR/conf.sh

out_file=~/.config/kicad/fp-lib-table

exec > >(tee -i $out_file.new)


# (lib (name aktos)(type KiCad)(uri "$(KISYSMOD)aktos/aktos.pretty")(options "")(descr ""))
echo "(fp_lib_table"
cd $KICAD_MODULES_DIR
find * -name "*.pretty" -print0 | while read -d $'\0' file
do
    FOOTPRINT_NAME=$(echo $file | sed -e 's/\//_/g')
    FOOTPRINT_NAME=${FOOTPRINT_NAME%.*}
    FOOTPRINT_PATH='${KISYSMOD}/'$file
    #echo "PRETTY FOLDER: $FOOTPRINT_PATH name: $FOOTPRINT_NAME"
    echo "    (lib (name $FOOTPRINT_NAME)(type KiCad)(uri $FOOTPRINT_PATH)(options \"\")(descr \"\"))"
done
echo ")"


DATE=$(date +"%Y%d%m")

mv $out_file $out_file.bak.$DATE
mv $out_file.new $out_file

