#!/bin/bash

#/**
# * Install Vagrant
# * 
# * Vagrant 2.1.2 is compatible with VirtualBox versions 4.0, 4.1, 4.2, 4.3, 5.0, 5.1 and 5.2
# * Vagrant 2.2.6 is compatible with above VirtualBox versions and version 6.0
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'wget'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

VERSION=2.2.10

OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) echo_label 'description'; echo_primary 'Install vagrant'
            echo_label 'usage'; echo_primary "${0} -v [version] -h (help)"
            exit 0;;
        :) echo_error "\"${OPTARG}\" requires value"
            exit 1;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

# check valid version
for VALID_VERSION in 2.1.2 2.2.6 2.2.10; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL='true'
    fi
done

if [ "${INSTALL}" != 'true' ]; then
    echo_error "Cannot install \"vagrant${VERSION}\", invalid version"
    exit 1
fi

if [ ! -x "$(command -v vagrant)" ]; then
    echo_info "wget https://releases.hashicorp.com/vagrant/${VERSION}/vagrant_${VERSION}_x86_64.deb"
    wget https://releases.hashicorp.com/vagrant/${VERSION}/vagrant_${VERSION}_x86_64.deb

    echo_info "sudo dpkg -i vagrant_${VERSION}_x86_64.deb"
    sudo dpkg -i vagrant_${VERSION}_x86_64.deb

    echo_info "rm vagrant_${VERSION}_x86_64.deb"
    rm vagrant_${VERSION}_x86_64.deb
else
    echo_warning 'vagrant already installed'
fi
