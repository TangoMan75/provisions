#!/bin/bash

#/**
# * winetricks
# * allows dotnet installation
# *
# * install dotnet40: `winetricks dotnet40`
# * wine virtual drive can be found here:
# * `~/.wine/drive_c`
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes winetricks'
sudo apt-get install --assume-yes winetricks

echo_info 'winetricks dotnet40'
winetricks dotnet40

