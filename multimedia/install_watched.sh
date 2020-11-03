#!/bin/bash

#/**
# * watched
# *
# * @category multimedia
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'wget'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info 'wget -q -O Watched.AppImage https://www.watched.com/desktop/get/linux'
wget -q -O Watched.AppImage https://www.watched.com/desktop/get/linux

echo_info 'mkdir ~/.watched'
mkdir ~/.watched

echo_info 'mv -fv Watched.AppImage ~/.watched'
mv -fv Watched.AppImage ~/.watched

echo_info 'chmod a+x ~/.watched/Watched.AppImage'
chmod a+x ~/.watched/Watched.AppImage

echo_info 'cp -fv watched.png ~/.watched'
cp -fv watched.png ~/.watched

# create desktop shortcut
cat > ~/Desktop/Watched.desktop<<EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=/home/${USER}/.watched/watched.png
Exec=/home/${USER}/.watched/Watched.AppImage
Name=Watched
Comment=Watched
EOF
