#!/bin/bash

#/**
# * webstorm
# * Python IDE
# *
# * @category ide
# * @link     https://www.jetbrains.com/webstorm/features
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo snap install webstorm --classic'
sudo snap install webstorm --classic

echo_info `readlink /snap/webstorm/current`

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

