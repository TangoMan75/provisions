#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## theHarvester
##
## OSINT tool to gather names, emails, IPs, subdomains, and URLs to help determine a domain's external threat landscape.
##
## ```
## cd ~/.theHarvester && python3 theHarvester.py -d kali.org -l 500 -b google
## ```
##
## @category security
## @link     https://github.com/laramies/theHarvester
## @link     https://tools.kali.org/information-gathering/theharvester
## @link     https://github.com/laramies/theHarvester/wiki/Installation

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v unzip)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires unzip, try: 'sudo apt-get install -y unzip'\n"
    exit 1
fi

#--------------------------------------------------

PROJECT=theHarvester
AUTHOR=laramies
REPOSITORY=${AUTHOR}/${PROJECT}
MAIN_BRANCH=master

#--------------------------------------------------

# create temp directory
TEMP=$(mktemp -d)
ARCHIVE="${TEMP}/${PROJECT}-${MAIN_BRANCH}.zip"
# destination folder
DESTINATION=~/.${PROJECT}

#--------------------------------------------------

# Download source
URL=https://github.com/${REPOSITORY}/archive/refs/heads/${MAIN_BRANCH}.zip

#--------------------------------------------------

_alert_primary "Install ${PROJECT}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    _echo_info "curl -L \"${URL}\" -o \"${ARCHIVE}\"\n"
    curl -L "${URL}" -o "${ARCHIVE}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -nv \"${URL}\" -O \"${ARCHIVE}\"\n"
    wget -nv "${URL}" -O "${ARCHIVE}"
fi

#--------------------------------------------------

# create destination folder
if [ ! -d "${DESTINATION}" ]; then
    _echo_info "mkdir -p \"${DESTINATION}\"\n"
    mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

# extract binary from archive
_echo_info "unzip \"${ARCHIVE}\" -d \"${TEMP}/temp\"\n"
unzip "${ARCHIVE}" -d "${TEMP}/temp"

_echo_info "cp -a \"${TEMP}/temp/${PROJECT}-${MAIN_BRANCH}/.\" \"${DESTINATION}\"\n"
cp -a "${TEMP}/temp/${PROJECT}-${MAIN_BRANCH}/." "${DESTINATION}"

#--------------------------------------------------

# clean up
_echo_info "rm -rf \"${TEMP}\"\n"
rm -rf "${TEMP}"

#--------------------------------------------------

_echo_info 'python3 -m venv .venv\n'
python3 -m venv .venv

_echo_info 'source .venv/bin/activate\n'
# shellcheck source=/dev/null
source .venv/bin/activate

#--------------------------------------------------

_echo_info 'python3 -m pip install -r requirements.txt\n'
python3 -m pip install -r requirements.txt

