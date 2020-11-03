#!/bin/bash

#/**
# * blackfire
# * php performance test profiler
# *
# * @category dev
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

    echo_info 'wget -q -O - https://packagecloud.io/gpg.key | sudo apt-key add -'
    wget -q -O - https://packagecloud.io/gpg.key | sudo apt-key add -

    echo_info 'echo "deb http://packages.blackfire.io/debian any main" | sudo tee /etc/apt/sources.list.d/blackfire.list'
    echo "deb http://packages.blackfire.io/debian any main" | sudo tee /etc/apt/sources.list.d/blackfire.list

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

echo_info 'sudo apt-get install --assume-yes blackfire-agent'
sudo apt-get install --assume-yes blackfire-agent

echo_info 'sudo apt-get install --assume-yes blackfire-php'
sudo apt-get install --assume-yes blackfire-php

echo_info 'sudo blackfire-agent -register'
sudo blackfire-agent -register

echo_info 'blackfire-agent -d'
blackfire-agent -d
