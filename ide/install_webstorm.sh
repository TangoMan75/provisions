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
# * webstorm
# * Python IDE
# *
# * @category ide
# * @link     https://www.jetbrains.com/webstorm/features
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v snap)" ]; then
    echo_error "\"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'"
    exit 1
fi

echo_info 'sudo snap install webstorm --classic'
sudo snap install webstorm --classic

echo_info "$(readlink /snap/webstorm/current)"

# create desktop shortcut
cat > ~/Desktop/webstorm_webstorm.desktop<<EOF
[Desktop Entry]
X-SnapInstanceName=webstorm
Version=1.0
Type=Application
Name=WebStorm
Icon=/snap/webstorm/current/bin/webstorm.png
Exec=env BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/webstorm_webstorm.desktop /snap/bin/webstorm %f
Comment=The smartest JavaScript IDE
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-webstorm
EOF

