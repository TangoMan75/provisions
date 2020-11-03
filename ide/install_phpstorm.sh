#!/bin/bash

#/**
# * phpstorm
# * PHP IDE
# *
# * @category ide
# * @link     https://www.jetbrains.com/phpstorm/features
# * @note     You will need php installed on local machine in order to use debugger
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo snap install phpstorm --classic'
sudo snap install phpstorm --classic

# if snap showing "snap-confine has elevated permissions and is not confined but should be. Refusing to continue to avoid permission escalation attacks"
# sudo snap refresh core --beta

# config phpstorm
# https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit"
echo_info 'sudo bash -c '"'"'echo "fs.inotify.max_user_watches = 524288">/etc/sysctl.d/idea.conf'"'"''
sudo bash -c 'echo "fs.inotify.max_user_watches = 524288">/etc/sysctl.d/idea.conf'

echo_info 'sudo sysctl -p --system'
sudo sysctl -p --system

echo_info `readlink /snap/phpstorm/current`

# create desktop shortcut
cat > ~/Desktop/phpstorm_phpstorm.desktop<<EOF
[Desktop Entry]
X-SnapInstanceName=phpstorm
Version=1.0
Type=Application
Name=PhpStorm
Icon=/snap/phpstorm/current/bin/phpstorm.png
Exec=env BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/phpstorm_phpstorm.desktop /snap/bin/phpstorm %f
Comment=Lightning-smart PHP IDE
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-phpstorm
EOF

