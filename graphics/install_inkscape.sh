#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * inkscape
# * vector graphics
# *
# * @category graphics
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo add-apt-repository --yes ppa:inkscape.dev/stable1'
sudo add-apt-repository --yes ppa:inkscape.dev/stable1

echo_info 'sudo apt-get update'
sudo apt-get update

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

