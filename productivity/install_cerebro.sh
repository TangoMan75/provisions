#!/bin/bash

#/**
# * cerebro
# *
# * @category productivity
# * @link     https://cerebroapp.com
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'wget'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

# echo_info 'wget -qO cerebro.AppImage https://github.com/KELiON/cerebro/releases/download/v0.3.1/cerebro-0.3.1-x86_64.AppImage'
# wget -qO cerebro.AppImage https://github.com/KELiON/cerebro/releases/download/v0.3.1/cerebro-0.3.1-x86_64.AppImage

echo_info 'wget -qO cerebro.AppImage https://github.com/KELiON/cerebro/releases/download/v0.3.2/cerebro-0.3.2-x86_64.AppImage'
wget -qO cerebro.AppImage https://github.com/KELiON/cerebro/releases/download/v0.3.2/cerebro-0.3.2-x86_64.AppImage

echo_info 'mkdir ~/.cerebro'
mkdir ~/.cerebro

echo_info 'mv -fv cerebro.AppImage ~/.cerebro'
mv -fv cerebro.AppImage ~/.cerebro

echo_info 'chmod a+x ~/.cerebro/cerebro.AppImage'
chmod a+x ~/.cerebro/cerebro.AppImage
