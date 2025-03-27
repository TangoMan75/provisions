#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## lazydocker
##
## @link     https://github.com/jesseduffield/lazydocker
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
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

# --------------------------------------------------

PROJECT=lazydocker
AUTHOR=jesseduffield
REPOSITORY=${AUTHOR}/${PROJECT}
# MAIN_BRANCH=main
BINARY="${PROJECT}"

# --------------------------------------------------

DEFAULT_VERSION=0.23.3
# VERSION="${DEFAULT_VERSION}"
VERSION=$(get_latest_release ${REPOSITORY})
if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi

# --------------------------------------------------

# REMOTE_FILE="${MAIN_BRANCH}.tar.gz"
# REMOTE_FILE="${MAIN_BRANCH}.zip"
REMOTE_FILE="${PROJECT}_${VERSION}_$(uname -s)_$(uname -m).tar.gz"
# REMOTE_FILE="${VERSION}.tar.gz"
# REMOTE_FILE="${VERSION}.zip"
ARCHIVE="$(mktemp -d)/${REMOTE_FILE}"
DESTINATION=/usr/bin

# --------------------------------------------------

# # Download source
# URL=https://github.com/${REPOSITORY}/archive/refs/heads/${REMOTE_FILE}
# URL=https://github.com/${REPOSITORY}/archive/refs/tags/${REMOTE_FILE}

# Download release
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

# --------------------------------------------------

alert_primary "Install ${PROJECT} v${VERSION}"

# --------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    echo_info "curl -L \"${URL}\" -o \"${ARCHIVE}\"\n"
    curl -L "${URL}" -o "${ARCHIVE}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    echo_info "wget -nv \"${URL}\" -O \"${ARCHIVE}\"\n"
    wget -nv "${URL}" -O "${ARCHIVE}"
fi

# --------------------------------------------------

# create destination folder
if [ ! -d "${DESTINATION}" ]; then
    echo_info "mkdir -p \"${DESTINATION}\"\n"
    mkdir -p "${DESTINATION}"
fi

# --------------------------------------------------

# ${ARCHIVE##*.} : This is a parameter expansion expression
# ${ARCHIVE##*.} : This is a parameter expansion expression
#             ## : Removes the shortest pattern that matches the entire string from the end of the value
#              * : Matches zero or more characters
#              . : Matches a literal dot (.)
if [ "${ARCHIVE##*.}" = 'gz' ]; then
    # extract binary from archive to destination
    echo_info "sudo tar -C ${DESTINATION} -xvzf \"${ARCHIVE}\" \"${BINARY}\"\n"
    sudo tar -C ${DESTINATION} -xvzf "${ARCHIVE}" "${BINARY}"

elif [ "${ARCHIVE##*.}" = 'zip' ]; then
    # extract binary from archive to ${DESTINATION}
    echo_info "unzip \"${ARCHIVE}\" -d \"${TEMP}\"\n"
    unzip "${ARCHIVE}" -d "${TEMP}"

    EXTRACTION_FOLDER="${TEMP}/${PROJECT}-${MAIN_BRANCH}"

    echo_info "sudo cp -f \"${EXTRACTION_FOLDER}/${BINARY}\" \"${DESTINATION}\"\n"
    sudo cp -f "${EXTRACTION_FOLDER}/${BINARY}" "${DESTINATION}"
fi

# --------------------------------------------------

# set executable permissions
echo_info "sudo chmod uga+x \"${DESTINATION}/${BINARY}\"\n"
sudo chmod uga+x "${DESTINATION}/${BINARY}"

# update system
echo_info 'sync\n'
sync

