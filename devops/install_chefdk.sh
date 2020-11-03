#!/bin/bash

#/**
# * chefdk
# * architecture as a code development kit
# *
# * @category devops
# * @link     https://downloads.chef.io/chefdk
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

VERSION=3.8.14

UBUNTU=''
DARWIN=''

RELEASE="`lsb_release -cs 2>/dev/null`"
for CODENAME in precise trusty xenial bionic cosmic disco eoan focal
do
    if [ "${RELEASE}" = "${CODENAME}" ]; then
        UBUNTU="`lsb_release -ds`"
    fi
done

if [ -z "${UBUNTU}" ]; then
    if [ -n "$(echo `sw_vers -productVersion` 2>/dev/null|grep '10.12')" ]; then
        DARWIN='10.12'

    elif [ -n "$(echo `sw_vers -productVersion` 2>/dev/null|grep '10.13')" ]; then
        DARWIN='10.13'

    elif [ -n "$(echo `sw_vers -productVersion` 2>/dev/null|grep '10.14')" ]; then
        DARWIN='10.14'

    else
        echo_error 'unsupported system, try installing manually: https://downloads.chef.io/chefdk'
        exit 1
    fi
fi

if [ -n "${UBUNTU}" ]; then

    if [ `is_installed 'wget'` == 'false' ]; then
        echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
        exit 1
    fi

    echo_info 'wget https://packages.chef.io/files/stable/chefdk/${VERSION}/ubuntu/${UBUNTU}/chefdk_${VERSION}-1_amd64.deb'
    wget https://packages.chef.io/files/stable/chefdk/${VERSION}/ubuntu/${UBUNTU}/chefdk_${VERSION}-1_amd64.deb

    echo_info "sudo dpkg -i chefdk_${VERSION}-1_amd64.deb"
    sudo dpkg -i chefdk_${VERSION}-1_amd64.deb

    echo_info "rm chefdk_${VERSION}-1_amd64.deb"
    rm chefdk_${VERSION}-1_amd64.deb
fi

if [ -n "${DARWIN}" ]; then

    if [ `is_installed 'curl'` == 'false' ]; then
        echo_error "\"`basename ${0}`\" requires curl, try: 'sudo apt-get install -y curl'"
        exit 1
    fi

    echo_info 'curl https://packages.chef.io/files/stable/chefdk/${VERSION}/mac_os_x/${DARWIN}/chefdk-${VERSION}-1.dmg --output chefdk-${VERSION}-1.dmg'
    curl https://packages.chef.io/files/stable/chefdk/${VERSION}/mac_os_x/${DARWIN}/chefdk-${VERSION}-1.dmg --output chefdk-${VERSION}-1.dmg

    echo_info "sudo dpkg -i chefdk_${VERSION}-1.dmg"
    sudo dpkg -i chefdk_${VERSION}-1.dmg

    echo_info "rm chefdk_${VERSION}-1.dmg"
    rm chefdk_${VERSION}-1.dmg
fi
