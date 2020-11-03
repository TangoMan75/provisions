#!/bin/bash

#/**
# * station
# *
# * @category communication
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'wget'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info 'wget -q -O Station.AppImage https://dl.getstation.com/download/linux_64?filetype=AppImage'
wget -q -O Station.AppImage https://dl.getstation.com/download/linux_64?filetype=AppImage

echo_info 'wget -q -O station.png https://canny.io/images/f9b8b266856274af68fba3aff52cf75f.png'
wget -q -O station.png https://canny.io/images/f9b8b266856274af68fba3aff52cf75f.png

echo_info 'mkdir ~/.station'
mkdir ~/.station

echo_info 'mv -fv Station.AppImage ~/.station'
mv -fv Station.AppImage ~/.station

echo_info 'mv -fv station.png ~/.station'
mv -fv station.png ~/.station

echo_info 'chmod a+x ~/.station/Station.AppImage'
chmod a+x ~/.station/Station.AppImage

# create desktop shortcut
cat > ~/Desktop/Station.desktop<<EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=/home/${USER}/.station/station.png
Exec=/home/${USER}/.station/Station.AppImage
Name=Station
Comment=Station
EOF
