#!/bin/bash

#/**
# * wine
# * windows emulator
# *
# * configure wine
# * `winecfg`
# *
# * wine virtual drive can be found here:
# * `~/.wine/drive_c`
# *
# * @category system
# * @note     this is the recommended version for ubuntu
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

# enable 32-bit architecture
echo_info 'sudo dpkg --add-architecture i386'
sudo dpkg --add-architecture i386

if [ "${UPDATE}" != 'false' ]; then
    if [ -z "`lsb_release -cs 2>/dev/null`" ]; then
        echo_error 'wrong system'
        exit 1
    fi

    if [ `is_installed 'wget'` == 'false' ]; then
        echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
        exit 1
    fi

    echo_info 'wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -'
    wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -

    echo_info "sudo apt-add-repository \"deb https://dl.winehq.org/wine-builds/ubuntu/ `lsb_release -cs` main\""
    sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ `lsb_release -cs` main"

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

# winehq requires aptitude to install for some reason
echo_info 'sudo apt-get install --assume-yes aptitude'
sudo apt-get install --assume-yes aptitude

# echo_info 'sudo apt-get --assume-yes install --install-recommends winehq-stable'
# sudo apt-get --assume-yes install --install-recommends winehq-stable

echo_info 'sudo aptitude install -y winehq-stable'
sudo aptitude install -y winehq-stable

