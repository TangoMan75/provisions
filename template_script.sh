#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## template
##
## @link     https://github.com/TangoMan75/template
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v tar)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires tar, try: 'sudo apt-get install -y tar'\n"
    exit 1
fi

if [ ! -x "$(command -v unzip)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires unzip, try: 'sudo apt-get install -y unzip'\n"
    exit 1
fi

#--------------------------------------------------

PROJECT=template
AUTHOR=TangoMan75
REPOSITORY=${AUTHOR}/${PROJECT}
# MAIN_BRANCH=main
APP_NAME="${PROJECT}"
DESKTOP=${APP_NAME}.desktop

#--------------------------------------------------

DEFAULT_VERSION=0.1.0
# VERSION="${DEFAULT_VERSION}"
VERSION=$(get_latest_release ${REPOSITORY})
if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi

#--------------------------------------------------

# REMOTE_FILE="${MAIN_BRANCH}.tar.gz"
# REMOTE_FILE="${MAIN_BRANCH}.zip"
REMOTE_FILE="${PROJECT}_${VERSION}_$(uname -s)_$(uname -m).tar.gz"
# REMOTE_FILE="${VERSION}.tar.gz"
# REMOTE_FILE="${VERSION}.zip"
ARCHIVE="$(mktemp -d)/${REMOTE_FILE}"
DESTINATION=/usr/bin
#create temp directory
TEMP="$(mktemp -d)"

#--------------------------------------------------

# # Download source
# URL=https://github.com/${REPOSITORY}/archive/refs/heads/${REMOTE_FILE}
# URL=https://github.com/${REPOSITORY}/archive/refs/tags/${REMOTE_FILE}

# Download release
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

alert_primary "Install ${PROJECT} v${VERSION}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    echo_info "curl -L \"${URL}\" -o \"${ARCHIVE}\"\n"
    curl -L "${URL}" -o "${ARCHIVE}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    echo_info "wget -nv \"${URL}\" -O \"${ARCHIVE}\"\n"
    wget -nv "${URL}" -O "${ARCHIVE}"
fi

#--------------------------------------------------

# create destination folder
if [ ! -d "${DESTINATION}" ]; then
    echo_info "mkdir -p \"${DESTINATION}\"\n"
    mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

# ${ARCHIVE##*.} : This is a parameter expansion expression
#             ## : Removes the shortest pattern that matches the entire string from the end of the value
#              * : Matches zero or more characters
#              . : Matches a literal dot (.)
if [ "${ARCHIVE##*.}" = 'gz' ]; then
    # extract with tar
    # -C, --directory [DIR] : destination directory
    # -x, --extract
    # -v, --verbose
    # -z, --gzip, --gunzip --ungzip
    # -f, --file [ARCHIVE]
    echo_info "sudo tar -C ${DESTINATION} -xvzf \"${ARCHIVE}\" \"${APP_NAME}\"\n"
    sudo tar -C ${DESTINATION} -xvzf "${ARCHIVE}" "${APP_NAME}"

elif [ "${ARCHIVE##*.}" = 'zip' ]; then
    # extract binary from archive to ${DESTINATION}
    echo_info "unzip \"${ARCHIVE}\" -d \"${TEMP}\"\n"
    unzip "${ARCHIVE}" -d "${TEMP}"

    EXTRACTION_FOLDER="${TEMP}/${PROJECT}-${MAIN_BRANCH}"

    echo_info "sudo cp -f \"${EXTRACTION_FOLDER}/${APP_NAME}\" \"${DESTINATION}\"\n"
    sudo cp -f "${EXTRACTION_FOLDER}/${APP_NAME}" "${DESTINATION}"
fi

#--------------------------------------------------

# create shortcut on desktop
echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

#--------------------------------------------------

# create shortcut on desktop for snap app
echo_info "cp -p \"/var/lib/snapd/desktop/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/var/lib/snapd/desktop/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

#--------------------------------------------------

# create shortcut on desktop for flatpak app
echo_info "cp -p \"/var/lib/flatpak/app/${APP_NAME}/current/active/export/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/var/lib/flatpak/app/${APP_NAME}/current/active/export/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

#--------------------------------------------------

# set executable permissions
echo_info "sudo chmod uga+x \"${DESTINATION}/${APP_NAME}\"\n"
sudo chmod uga+x "${DESTINATION}/${APP_NAME}"

# update system
echo_info 'sync\n'
sync

