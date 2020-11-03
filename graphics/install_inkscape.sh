#!/bin/bash

#/**
# * inkscape
# * vector graphics
# *
# * @category graphics
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE='false';;
        h) echo_label 'description'; echo_primary "`basename ${0}`"
            echo_label 'usage'; echo_primary "`basename ${0}` -n (no update) -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

if [ "${UPDATE}" != 'false' ]; then
    echo_info 'sudo add-apt-repository -y ppa:inkscape.dev/stable1'
    sudo add-apt-repository -y ppa:inkscape.dev/stable1

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

echo_info 'sudo apt-get install --assume-yes inkscape'
sudo apt-get install --assume-yes inkscape

# create desktop shortcut
cat > ~/Desktop/inkscape.desktop<<EOF
[Desktop Entry]
Version=1.0
Name=Inkscape
Comment=Create and edit Scalable Vector Graphics images
Type=Application
Categories=Graphics;VectorGraphics;GTK;
Exec=inkscape %F
Terminal=false
StartupNotify=true
Icon=inkscape
EOF

