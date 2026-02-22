#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## phpstorm
## PHP IDE
##
## Check your fallback licence version here : https://account.jetbrains.com/licenses
##
## @category ide
## @link     https://sales.jetbrains.com/hc/en-gb/articles/207240845-What-is-a-perpetual-fallback-license
## @link     https://www.jetbrains.com/phpstorm/download/other.html
## @link     https://account.jetbrains.com/licenses
## @note     You will need php installed on local machine in order to use debugger

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

DEFAULT_VERSION=2023.3.8
VALID_VERSIONS=(2016.3.4 2017.3.7 2018.3.6 2019.3.4 2020.3.3 2021.3.3 2022.3.3 2023.1.6 2023.2.6 2023.3.8 2024.1.7 2024.2.4 2024.3)

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
        h) _echo_success 'description:' 2 14; _echo_primary 'Install PHPStorm\n'
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

FILENAME="PhpStorm-${VERSION}.tar.gz"
URL="https://download.jetbrains.com/webide/${FILENAME}"

#--------------------------------------------------

_alert_primary "Install PHPStorm v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n" 2
    exit 1
fi

_echo_info "wget \"${URL}\"\n"
wget "${URL}"

# extract archive
_echo_info "tar xvzf \"${FILENAME}\"\n"
tar xvzf "${FILENAME}"

# Get folder name eg: PhpStorm-213.7172.28
FOLDER_NAME="$(basename "$(find . -maxdepth 1 -type d -name 'PhpStorm-*')")"

if [ -z "${FOLDER_NAME}" ]; then
    _echo_danger "error: folder not found\n" 2
    exit 1
fi

# Get install directory eg: ~/.local/share/JetBrains/Toolbox/apps/PhpStorm/ch-0/213.7172.28/
INSTALL_DIRECTORY=~/.local/share/JetBrains/Toolbox/apps/PhpStorm/ch-0/$(echo "${FOLDER_NAME}" | cut -d '-' -f2)

# create parent folder
_echo_info "mkdir -p \"$(dirname "${INSTALL_DIRECTORY}")\"\n"
mkdir -p "$(dirname "${INSTALL_DIRECTORY}")"

# move folder
_echo_info "mv -fv \"${FOLDER_NAME}\" \"${INSTALL_DIRECTORY}\"\n"
mv -fv "${FOLDER_NAME}" "${INSTALL_DIRECTORY}"

_echo_info "rm -f \"${FILENAME}\"\n"
rm -f "${FILENAME}"

#--------------------------------------------------

# create desktop shortcut
cat > "$(xdg-user-dir DESKTOP)"/phpstorm_phpstorm.desktop<<EOF
[Desktop Entry]
Name=PHPStorm ${VERSION}
Icon=${INSTALL_DIRECTORY}/bin/phpstorm.png
StartupWMClass=jetbrains-phpstorm
Comment=A smart IDE for PHP and Web
Exec="${INSTALL_DIRECTORY}/bin/phpstorm.sh" %u
Version=1.0
Type=Application
Categories=Development;IDE;
Terminal=false
StartupNotify=true
EOF

#--------------------------------------------------

_echo_info "sudo ln -s ${INSTALL_DIRECTORY}/bin/phpstorm.sh /usr/bin/phpstorm\n"
sudo ln -s "${INSTALL_DIRECTORY}/bin/phpstorm.sh" "/usr/bin/phpstorm"

