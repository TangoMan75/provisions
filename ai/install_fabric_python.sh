#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * fabric
# *
# * @category ai
# * @link     https://github.com/danielmiessler/fabric
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v unzip)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires unzip, try: 'sudo apt-get install -y unzip'\n"
    exit 1
fi

if [ ! -x "$(command -v pipx)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires pipx, try: 'sudo apt-get install -y pipx'\n"
    exit 1
fi

# --------------------------------------------------

PROJECT=fabric
AUTHOR=danielmiessler
REPOSITORY=${AUTHOR}/${PROJECT}
MAIN_BRANCH=main

# --------------------------------------------------

REMOTE_FILE="${MAIN_BRANCH}.zip"
# create temp folder
TEMP="$(mktemp -d)"
ARCHIVE="${TEMP}/${REMOTE_FILE}"
DESTINATION=~/.fabric

# --------------------------------------------------

# Download source
URL=https://github.com/${REPOSITORY}/archive/refs/heads/${REMOTE_FILE}

# --------------------------------------------------

alert_primary "Install ${PROJECT}"

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
#             ## : Removes the shortest pattern that matches the entire string from the end of the value
#              * : Matches zero or more characters
#              . : Matches a literal dot (.)
if [ "${ARCHIVE##*.}" = 'gz' ]; then
    # extract source with tar
    # -C, --directory [DIR] : destination directory
    # -x, --extract
    # -v, --verbose
    # -z, --gzip, --gunzip --ungzip
    # -f, --file [ARCHIVE]
    echo_info "tar -C \"${TEMP}\" -xzf \"${ARCHIVE}\"\n"
    tar -C "${TEMP}" -xzf "${ARCHIVE}"

elif [ "${ARCHIVE##*.}" = 'zip' ]; then
    # extract source with unzip
    echo_info "unzip \"${ARCHIVE}\" -d \"${TEMP}\"\n"
    unzip "${ARCHIVE}" -d "${TEMP}"
fi

# --------------------------------------------------

# move extacted folder to destination
EXTRACTION_FOLDER="${TEMP}/${PROJECT}-${MAIN_BRANCH}"
echo_info "cp -rfT \"${EXTRACTION_FOLDER}\" \"${DESTINATION}\"\n"
cp -rfT "${EXTRACTION_FOLDER}" "${DESTINATION}"

# --------------------------------------------------

echo_info "pipx install \"${DESTINATION}\"\n"
pipx install "${DESTINATION}"

