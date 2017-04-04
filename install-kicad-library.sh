#!/bin/bash
DIR=$(dirname "$(readlink -f "$0")")
source $DIR/conf.sh

sudo mkdir -p $KICAD_LIBRARY_DIR $KICAD_MODULES_DIR

detect_pretty_repos()
{
    # Check for the correct option to enable extended regular expressions in
    # sed. This is '-r' for GNU sed and '-E' for (older) BSD-like sed, as on
    # Mac OSX.
    if [ $(echo | sed -r '' &>/dev/null; echo $?) -eq 0 ]; then
        SED_EREGEXP="-r"
    elif [ $(echo | sed -E '' &>/dev/null; echo $?) -eq 0 ]; then
        SED_EREGEXP="-E"
    else
        echo "Your sed command does not support extended regular expressions. Cannot continue."
        exit 1
    fi

    # Use github API to list repos for org KiCad, then subset the JSON reply for only
    # *.pretty repos in the "full_name" variable.
    PRETTY_REPOS=`curl -s "https://api.github.com/orgs/KiCad/repos?per_page=99&page=1" \
        "https://api.github.com/orgs/KiCad/repos?per_page=99&page=2" 2> /dev/null \
        | sed $SED_EREGEXP 's:.+ "full_name".*"KiCad/(.+\.pretty)",:\1:p;d'`

    #echo "PRETTY_REPOS:$PRETTY_REPOS"

    PRETTY_REPOS=`echo $PRETTY_REPOS | tr " " "\n" | sort`

    #echo "PRETTY_REPOS sorted:$PRETTY_REPOS"
}


checkout_or_update_libraries()
{
    cd $KICAD_MODULES_DIR

    echo "Detecting pretty repos..."
    detect_pretty_repos


    for repo in $PRETTY_REPOS; do
        # echo "repo:$repo"

        if [ ! -e "$KICAD_MODULES_DIR/$repo" ]; then

            # Preserve the directory extension as ".pretty".
            # That way those repos can serve as pretty libraries directly if need be.

            echo "installing $KICAD_MODULES_DIR/$repo"
            sudo git clone "https://github.com/KiCad/$repo" "$KICAD_MODULES_DIR/$repo"
        else
            echo "updating $KICAD_MODULES_DIR/$repo"
            cd "$KICAD_MODULES_DIR/$repo"
            sudo git pull
        fi
    done
}

# install default kicad-libraries
echo "Installing default kicad libraries (eeschema)"
sudo cp $DIR/kicad-library/library/*.{lib,dcm} $KICAD_LIBRARY_DIR


# install default kicad footprints
echo "Installing default kicad footprints"
checkout_or_update_libraries
echo "------------------ WARNING --------------------------"
echo "DO NOT FORGET UPDATING Kicad Template"
echo "DO NOT FORGET UPDATING ~/.config/kicad/fp-lib-table"
echo "-----------------------------------------------------"
