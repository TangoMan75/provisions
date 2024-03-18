#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * watched
# *
# * @category multimedia
# * @link     https://www.watched.com
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info 'mkdir ~/.watched'
mkdir ~/.watched

echo_info 'wget -qO ~/.watched/Watched.AppImage https://www.watched.com/desktop/get/linux'
wget -qO ~/.watched/Watched.AppImage https://www.watched.com/desktop/get/linux

echo_info 'chmod a+x ~/.watched/Watched.AppImage'
chmod a+x ~/.watched/Watched.AppImage

echo_info 'cp -fv watched.png ~/.watched'
cp -fv watched.png ~/.watched

# create desktop shortcut
cat > "$(xdg-user-dir DESKTOP)"/Watched.desktop<<EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=/home/${USER}/.watched/watched.png
Exec=/home/${USER}/.watched/Watched.AppImage
Name=Watched
Comment=Watched
EOF
