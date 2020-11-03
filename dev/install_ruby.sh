#!/bin/bash

#/**
# * ruby
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# default settings
UPDATE='true'
VERSION=latest

OPTIND=0
while getopts :nv:h OPTION; do
    case "${OPTION}" in
        n) UPDATE='false';;
        v) VERSION="${OPTARG}";;
        h) echo_label 'description'; echo_primary 'Install php'
            echo_label 'usage'; echo_primary "${0} -v [version] -n (no update) -h (help)"
            exit 0;;
        :) echo_error "\"${OPTARG}\" requires value"
            exit 1;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

# check valid version
for VALID_VERSION in '2.4.9' '2.5.1' '2.5.7' '2.6.5' '2.7.0' 'dev' 'latest'; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL='true'
    fi
done

if [ "${INSTALL}" != 'true' ]; then
    echo_error "Cannot install \"php${VERSION}\", invalid version"

    exit 1
fi

if [ "${UPDATE}" != 'false' ]; then
    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

if [ "${VERSION}" = 'latest' ]; then
    echo_info 'sudo apt-get install --assume-yes ruby-full'
    sudo apt-get install --assume-yes ruby-full

    exit 0
fi

if [ "${VERSION}" = 'dev' ]; then
    echo_info 'sudo apt-get install --assume-yes ruby ruby-dev'
    sudo apt-get install --assume-yes ruby ruby-dev

    exit 0
fi

if [ ! -x "$(command -v rvm)" ]; then
    echo_error 'ruby requires rvm to install'
    exit 1
fi

echo_info "rvm install ruby-${VERSION}"
rvm install ruby-${VERSION}

