#!/bin/bash

#/**
# * multisystem
# * create bootable usb drives
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

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
    if [ `is_installed 'wget'` == 'false' ]; then
        echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
        exit 1
    fi

    echo_info 'sudo apt-add-repository 'deb http://liveusb.info/multisystem/depot all main''
    sudo apt-add-repository 'deb http://liveusb.info/multisystem/depot all main'

    echo_info 'wget -q http://liveusb.info/multisystem/depot/multisystem.asc -O- | sudo apt-key add -'
    wget -q http://liveusb.info/multisystem/depot/multisystem.asc -O- | sudo apt-key add -

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

echo_info 'sudo apt-get install --assume-yes multisystem'
sudo apt-get install --assume-yes multisystem
