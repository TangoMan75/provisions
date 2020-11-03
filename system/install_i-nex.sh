#!/bin/bash

#/**
# * i-nex
# * processor information
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

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
    echo_info 'sudo add-apt-repository -y ppa:i-nex-development-team/daily'
    sudo add-apt-repository -y ppa:i-nex-development-team/daily

    echo_info 'sudo add-apt-repository -y ppa:gambas-team/gambas3'
    sudo add-apt-repository -y ppa:gambas-team/gambas3

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

echo_info 'sudo apt install -y i-nex'
sudo apt install -y i-nex
