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
# * phpstorm
# * PHP IDE
# *
# * @category ide
# * @link     https://www.jetbrains.com/fr-fr/phpstorm/nextversion/
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

DEFAULT_VERSION=233.11799.55
VALID_VERSIONS=(233.11799.55 233.11799.172)

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
        h) echo_label 12 'description'; echo_primary 'Install PHPStorm EAP'
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

FILENAME="PhpStorm-${VERSION}.tar.gz"
URL="https://download-cdn.jetbrains.com/webide/PhpStorm-${VERSION}.tar.gz"

#--------------------------------------------------

alert_primary "Install PHPStorm EAP v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info "wget \"${URL}\""
wget "${URL}"

# extract archive
echo_info "tar xvzf \"${FILENAME}\""
tar xvzf "${FILENAME}"

# Get folder name eg: PhpStorm-213.7172.28
FOLDER_NAME="$(basename "$(find . -maxdepth 1 -type d -name 'PhpStorm-*')")"

if [ -z "${FOLDER_NAME}" ]; then
    echo_error "folder not found";
    exit 1
fi

# Get install directory eg: ~/.local/share/JetBrains/Toolbox/apps/PhpStorm/ch-0/213.7172.28/
INSTALL_DIRECTORY=~/.local/share/JetBrains/Toolbox/apps/PhpStorm/ch-0/$(echo "${FOLDER_NAME}" | cut -d '-' -f2)

# create parent folder
echo_info "mkdir -p \"$(dirname "${INSTALL_DIRECTORY}")\""
mkdir -p "$(dirname "${INSTALL_DIRECTORY}")"

# move folder
echo_info "mv -fv \"${FOLDER_NAME}\" \"${INSTALL_DIRECTORY}\""
mv -fv "${FOLDER_NAME}" "${INSTALL_DIRECTORY}"

echo_info "rm -f \"${FILENAME}\""
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

echo_info "sudo ln -s ${INSTALL_DIRECTORY}/bin/phpstorm.sh /usr/bin/phpstorm"
sudo ln -s "${INSTALL_DIRECTORY}/bin/phpstorm.sh" "/usr/bin/phpstorm"

