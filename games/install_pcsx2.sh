#!/bin/bash

#/**
# * pcsx2
# * playstation 2 emulator
# *
# * @category games
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# echo_info 'sudo apt-get install --assume-yes libcg:i386'
# sudo apt-get install --assume-yes libcg:i386

# echo_info 'sudo apt-get install --assume-yes libwxgtk2:i386'
# sudo apt-get install --assume-yes libwxgtk2:i386

if [ "${#}" -gt 1 ]; then
    echo_error "too many arguments (${#})"
    echo_label 'usage'; echo_primary "`basename ${0}` -n (no update) -h (help)"
    exit 1
fi

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
    echo_info 'sudo add-apt-repository -y ppa:gregory-hainaut/pcsx2.official.ppa'
    sudo add-apt-repository -y ppa:gregory-hainaut/pcsx2.official.ppa

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

# install pcsx2
echo_info 'sudo apt-get install --assume-yes pcsx2:i386'
sudo apt-get install --assume-yes pcsx2:i386
