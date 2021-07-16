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
# * pycharm-community
# * Python IDE
# *
# * @category ide
# * @link     https://www.jetbrains.com/pycharm/features
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install pycharm-community'

if [ ! -x "$(command -v snap)" ]; then
    echo_error "\"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'"
    exit 1
fi

echo_info 'sudo snap install pycharm-community --classic'
sudo snap install pycharm-community --classic

echo_info "$(readlink /snap/pycharm-community/current)"

# create desktop shortcut
cat > ~/Desktop/pycharm-community_pycharm-community.desktop<<EOF
[Desktop Entry]
X-SnapInstanceName=pycharm-community
Version=1.0
Type=Application
Name=PyCharm Community Edition
Icon=/snap/pycharm-community/current/bin/pycharm.png
Exec=env BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/pycharm-community_pycharm-community.desktop /snap/bin/pycharm-community %f
Comment=Python IDE for Professional Developers
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-pycharm-ce
EOF

