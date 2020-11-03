#!/bin/bash

#/**
# * obs studio
# * Free and open source software for video recording and live streaming
# *
# * @category multimedia
# * @link     https://obsproject.com/wiki/install-instructions#linux
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE='false';;
        h) echo_label 'description'; echo_primary "`basename ${0}`"
            echo_label 'usage'; echo_primary "`basename ${0}` -n (no update) -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

if [ "${UPDATE}" != 'false' ]; then
    echo_info 'sudo add-apt-repository -y ppa:obsproject/obs-studio'
    sudo add-apt-repository -y ppa:obsproject/obs-studio

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

echo_info 'sudo apt-get install --assume-yes ffmpeg'
sudo apt-get install --assume-yes ffmpeg

echo_info 'sudo apt-get install --assume-yes obs-studio'
sudo apt-get install --assume-yes obs-studio

# create desktop shortcut
cat > ~/Desktop/obs-studio.desktop<<EOF
[Desktop Entry]
Version=1.0
Name=OBS Studio
GenericName=Streaming/Recording Software
Comment=Free and Open Source Streaming/Recording Software
Exec=obs
Icon=com.obsproject.Studio
Terminal=false
Type=Application
Categories=AudioVideo;Recorder;
StartupNotify=true
StartupWMClass=obs
EOF

