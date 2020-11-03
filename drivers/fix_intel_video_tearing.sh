#!/bin/bash

#/**
# * intel fix video tearing
# *
# * @deprecated
# * @category   drivers
# * @license    MIT
# * @author     "Matthias Morin" <mat@tangoman.io>
# * @link       https://askubuntu.com/questions/1066722/intel-screen-tearing-ubuntu-18-04
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

echo_info 'sudo mkdir -p /etc/X11/xorg.conf.d'
sudo mkdir -p /etc/X11/xorg.conf.d

cat > /etc/X11/xorg.conf.d/20-intel.conf <<EOL
Section "Device"
   Identifier  "Intel Graphics"
   Driver      "intel"
   Option      "TearFree"    "true"
EndSection
EOL
