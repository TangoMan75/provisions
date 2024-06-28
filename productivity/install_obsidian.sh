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
# * obsidian
# *
# * A knowledge base that works on local Markdown files.
# *
# * @category productivity
# * @link     https://obsidian.md
# * @link     https://obsidian.md/plugins
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

VERSION=0.12.19

alert_primary "Install Obsidian v${VERSION}"

echo_info 'mkdir ~/.obsidian'
mkdir ~/.obsidian

echo_info "wget -qO ~/.obsidian/Obsidian.AppImage https://github.com/obsidianmd/obsidian-releases/releases/download/v${VERSION}/Obsidian-${VERSION}.AppImage"
wget -qO ~/.obsidian/Obsidian.AppImage https://github.com/obsidianmd/obsidian-releases/releases/download/v${VERSION}/Obsidian-${VERSION}.AppImage

echo_info 'chmod a+x ~/.obsidian/Obsidian.AppImage'
chmod a+x ~/.obsidian/Obsidian.AppImage

echo_info 'cp -fv obsidian.png ~/.obsidian'
cp -fv obsidian.png ~/.obsidian

# create desktop shortcut
cat > "$(xdg-user-dir DESKTOP)"/Obsidian.desktop<<EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=/home/${USER}/.obsidian/obsidian.png
Exec=/home/${USER}/.obsidian/Obsidian.AppImage
Name=Obsidian
Comment=Obsidian
EOF
