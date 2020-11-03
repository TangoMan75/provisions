#!/bin/bash

#/**
# * nvidia
# * https://www.nvidia.com/object/unix.html
# *
# * @category drivers
# * @link     https://github.com/stockmind/dell-xps-9560-ubuntu-respin/issues/8#issuecomment-389292575
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

OPTIND=0
while getopts :cnh OPTION; do
    case "${OPTION}" in
        c) PURGE='true';;
        n) UPDATE='false';;
        h) echo_label 'description'; echo_primary "${0}"
            echo_label 'usage'; echo_primary "${0} -p (purge previous drivers) -n (no update) -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

if [ "${UPDATE}" != 'false' ]; then
    # add the nvidia graphic card ppa
    echo_info 'sudo add-apt-repository ppa:graphics-drivers'
    sudo add-apt-repository ppa:graphics-drivers

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

if [ "${PURGE}" = 'true' ]; then
    # clean system of previous nvidia drivers
    echo_info 'sudo apt-get purge nvidia*'
    sudo apt-get purge nvidia*
fi

# echo_info 'sudo apt-get install --assume-yes nvidia-435'
# sudo apt-get install --assume-yes nvidia-435

# echo_info 'sudo apt-get install --assume-yes nvidia-430'
# sudo apt-get install --assume-yes nvidia-430

echo_info 'sudo apt-get install --assume-yes nvidia-390'
sudo apt-get install --assume-yes nvidia-390

# check installation
echo_info 'lsmod | grep nvidia'
lsmod | grep nvidia
