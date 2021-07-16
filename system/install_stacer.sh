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
# * stacer
# * system optimizer and monitor
# *
# * @category system
# * @link     https://github.com/oguzhaninan/Stacer
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install stacer'

echo_info 'sudo apt-get install --assume-yes stacer'
sudo apt-get install --assume-yes stacer

# create desktop shortcut
cat > ~/Desktop/stacer.desktop<<EOF
[Desktop Entry]
Name=Stacer
Exec=stacer
Comment=Linux System Optimizer and Monitoring
Icon=stacer
Type=Application
Terminal=false
Encoding=UTF-8
Categories=Utility;
EOF
