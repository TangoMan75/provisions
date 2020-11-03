#!/bin/bash

#/**
# * dropbox
# * personal cloud
# *
# * @category productivity
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

#echo_info 'sudo apt-get install --assume-yes python-gpgme'
#sudo apt-get install --assume-yes python-gpgme

# check system uses gnome
GNOME='false'
RELEASE=`lsb_release -cs`
for CODENAME in bionic cosmic disco eoan focal kali
do
    if [ "${RELEASE}" = "${CODENAME}" ]; then
        GNOME='true'
    fi
done

if [ "${GNOME}" = 'true' ]; then
    echo_info 'sudo apt-get install --assume-yes nautilus-dropbox'
    sudo apt-get install --assume-yes nautilus-dropbox
else
    echo_info 'sudo apt-get install --assume-yes thunar-dropbox-plugin'
    sudo apt-get install --assume-yes thunar-dropbox-plugin
fi

# create desktop shortcut
cat > ~/Desktop/dropbox.desktop<<EOF
[Desktop Entry]
Name=Dropbox
GenericName=File Synchronizer
Comment=Sync your files across computers and to the web
Exec=dropbox start -i
Terminal=false
Type=Application
Icon=dropbox
Categories=Network;FileTransfer;
StartupNotify=false
EOF
