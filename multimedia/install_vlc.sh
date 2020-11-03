#!/bin/bash

#/**
# * vlc
# * multimedia player
# *
# * @category multimedia
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes vlc'
sudo apt-get install --assume-yes vlc

# create desktop shortcut
cat > ~/Desktop/vlc.desktop<<EOF
[Desktop Entry]
Version=1.0
Name=VLC media player
GenericName=Media player
Comment=Read, capture, broadcast your multimedia streams
Exec=/usr/bin/vlc --started-from-file %U
Icon=vlc
Terminal=false
Type=Application
Categories=AudioVideo;Player;Recorder;
Keywords=Player;Capture;DVD;Audio;Video;Server;Broadcast;
EOF
