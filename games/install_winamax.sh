#!/bin/bash

#/**
# * winmax
# * french online poker game
# *
# * @category games
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'wget'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

if [ `is_installed 'wine'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires wine, try: 'sudo apt-get install -y wine'"
    exit 1
fi

echo_primary 'please check wine version is >= 1.6.2'
echo_info 'wine --version'
wine --version

echo_primary 'please check wine is Windows 10 mode (optional)'
echo_info 'winecfg'
winecfg

echo_info 'wget https://dl.winamax.fr/client/windows/installer/wamInstall.exe'
wget https://dl.winamax.fr/client/windows/installer/wamInstall.exe

echo_info 'wine wamInstall.exe'
wine wamInstall.exe

echo_info 'rm -f wamInstall.exe'
rm -f wamInstall.exe

