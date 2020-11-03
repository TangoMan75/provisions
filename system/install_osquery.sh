#!/bin/bash

#/**
# * osquery
# * Multi-platform system information with SQL queries
# *
# * @category system
# * @link     https://osquery.io
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
    echo_info 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B'
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B

    echo_info "sudo add-apt-repository 'deb [arch=amd64] https://pkg.osquery.io/deb deb main'"
    sudo add-apt-repository 'deb [arch=amd64] https://pkg.osquery.io/deb deb main'

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

echo_info 'sudo apt install -y osquery'
sudo apt install -y osquery

