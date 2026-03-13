#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config phpstorm
##
## @category ide

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

CONFIG_DIR="${CURDIR}/../config"

#--------------------------------------------------

DEFAULT_VERSION=2024.3
VALID_VERSIONS=(2016.3 2017.3 2018.3 2019.3 2020.3 2021.3 2022.3 2023.3 2024.1 2024.2 2024.3)

#--------------------------------------------------

if [ "$#" -gt 2 ]; then
    _echo_danger "error: too many arguments (${#})\n" 2
    _echo_success 'usage:' 2 7; _echo_primary "$(basename "${0}") -v [version] -h (help)\n"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) _echo_success 'description:' 2 14; _echo_primary 'Install php\n'
            _echo_success 'usage:' 2 14; _echo_primary "${0} -v [version] -h (help)\n"
            exit 0;;
        :) _echo_danger "error: \"${OPTARG}\" requires value\n" 2
            exit 1;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n" 2
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
    _echo_danger "error: \"$(basename "${0}")\" invalid version \"${VERSION}\"\n" 2
    exit 1
fi

#--------------------------------------------------

_alert_secondary "Config PHPStorm${VERSION}"

_echo_info 'mkdir -p ~/.config/JetBrains\n'
mkdir -p ~/.config/JetBrains

# remove previous config
_echo_info "rm -rf ~/.config/JetBrains/PhpStorm*\n"
rm -rf ~/.config/JetBrains/PhpStorm*

# config phpstorm
_echo_info "cp -Rfv \"${CONFIG_DIR}/home/.config/JetBrains/PhpStorm/\" \"${HOME}/.config/JetBrains/PhpStorm${VERSION}\"\n"
cp -Rfv "${CONFIG_DIR}/home/.config/JetBrains/PhpStorm/" "${HOME}/.config/JetBrains/PhpStorm${VERSION}"

#--------------------------------------------------

# config phpstorm
# https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit"
_echo_info "sudo bash -c 'echo \"fs.inotify.max_user_watches = 524288\" > /etc/sysctl.d/idea.conf'\n"
sudo bash -c 'echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/idea.conf'

_echo_info 'sudo sysctl -p --system\n'
sudo sysctl -p --system

#--------------------------------------------------

