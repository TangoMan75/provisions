#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * config phpstorm
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

CONFIG_DIR="${CURDIR}/../config"

#--------------------------------------------------

DEFAULT_VERSION=2023.3
VALID_VERSIONS=(2016.1 2016.2 2016.3 2017.1 2017.2 2017.3 2018.1 2018.2 2018.3 2019.1 2019.2 2019.3 2020.1 2020.2 2020.3 2021.1 2021.2 2021.3 2022.1 2022.2 2022.3 2023.1 2023.2 2023.3)

#--------------------------------------------------

if [ "$#" -gt 2 ]; then
    echo_error "too many arguments (${#})"
    echo_label 3 'usage'; echo_primary "$(basename "${0}") -v [version] -h (help)"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) echo_label 12 'description'; echo_primary 'Install php'
            echo_label 12 'usage'; echo_primary "${0} -v [version] -h (help)"
            exit 0;;
        :) echo_error "\"${OPTARG}\" requires value"
            exit 1;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi
# check valid version
INSTALL=false
for VALID_VERSION in "${VALID_VERSIONS[@]}"; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL=true
    fi
done
if [ "${INSTALL}" != true ]; then
    echo_error "\"$(basename "${0}")\" invalid version \"${VERSION}\""
    exit 1
fi

#--------------------------------------------------

alert_secondary "Config PHPStorm${VERSION}"

echo_info 'mkdir ~/.config/JetBrains'
mkdir ~/.config/JetBrains

# remove previous config
echo_info "rm -rf ~/.config/JetBrains/PhpStorm*"
rm -rf ~/.config/JetBrains/PhpStorm*

# config phpstorm
echo_info "cp -Rfv \"${CONFIG_DIR}/home/.config/JetBrains/PhpStorm/\" ~/.config/JetBrains/PhpStorm${VERSION}"
cp -Rfv "${CONFIG_DIR}/home/.config/JetBrains/PhpStorm/" ~/.config/JetBrains/PhpStorm${VERSION}

#--------------------------------------------------

# config phpstorm
# https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit"
echo_info "sudo bash -c 'echo \"fs.inotify.max_user_watches = 524288\" > /etc/sysctl.d/idea.conf'"
sudo bash -c 'echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/idea.conf'

echo_info 'sudo sysctl -p --system'
sudo sysctl -p --system

#--------------------------------------------------

