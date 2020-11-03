#!/bin/bash

#/**
# * google-cloud-sdk
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'curl'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires curl, try: 'sudo apt-get install -y curl'"
    exit 1
fi

OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE='false';;
        h) echo_label 'description'; echo_primary 'Install php'
            echo_label 'usage'; echo_primary "`basename ${0}` -n (no update) -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

if [ "${UPDATE}" != 'false' ]; then
    echo_info "echo \"deb http://packages.cloud.google.com/apt `lsb_release -cs` main\" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list"
    echo "deb http://packages.cloud.google.com/apt `lsb_release -cs` main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

    echo_info "curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -"
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

echo_info 'sudo apt-get install --assume-yes google-cloud-sdk'
sudo apt-get install --assume-yes google-cloud-sdk
