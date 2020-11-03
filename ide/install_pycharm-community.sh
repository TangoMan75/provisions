#!/bin/bash

#/**
# * pycharm-community
# * Python IDE
# *
# * @category ide
# * @link     https://www.jetbrains.com/pycharm/features
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo snap install pycharm-community --classic'
sudo snap install pycharm-community --classic

echo_info `readlink /snap/pycharm-community/current`

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

