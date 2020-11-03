#!/bin/bash

#/**
# * thunderbird
# *
# * @category communication
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes thunderbird'
sudo apt-get install --assume-yes thunderbird

# create desktop shortcut
cat > ~/Desktop/thunderbird.desktop<<EOF
[Desktop Entry]
Name=Thunderbird Mail
Comment=Send and receive mail with Thunderbird
GenericName=Mail Client
Keywords=Email;E-mail;Newsgroup;Feed;RSS
Exec=thunderbird %u
Terminal=false
Type=Application
Icon=thunderbird
Categories=Application;Network;Email;
StartupNotify=true
EOF
