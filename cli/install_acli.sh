#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## acli
##
## Atlassian CLI — a single command-line tool to script and automate
## work across Atlassian Cloud products (Jira, Confluence, Bitbucket,
## Compass, Statuspage, Trello...) from a terminal or CI pipeline.
##
## ```
## # Authenticate against your Atlassian Cloud site
## acli auth login
##
## # List Jira projects
## acli jira project list
## ```
##
## @category cli
## @link     https://developer.atlassian.com/cloud/acli/guides/install-linux/
## @link     https://developer.atlassian.com/cloud/acli/guides/introduction/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v gpg)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gnupg, try: 'sudo apt-get install -y gnupg'\n"
    exit 1
fi

#--------------------------------------------------

KEYRING_URL="https://acli.atlassian.com/gpg/public-key.asc"
KEYRING="acli-archive-keyring.gpg"
SOURCES_LIST="/etc/apt/sources.list.d/acli.list"
REPO_URL="https://acli.atlassian.com/linux/deb"
DIST="stable"
COMPONENT="main"

#--------------------------------------------------

_alert_primary "Install acli"

#--------------------------------------------------

_echo_warning 'Install APT keyring directory\n'

_echo_info "sudo mkdir -p -m 755 /etc/apt/keyrings\n"
sudo mkdir -p -m 755 /etc/apt/keyrings

#--------------------------------------------------

_echo_warning 'Download and install Atlassian signing key\n'

_echo_info "wget -nv -O- \"${KEYRING_URL}\" | sudo gpg --dearmor -o \"/etc/apt/keyrings/${KEYRING}\"\n"
wget -nv -O- "${KEYRING_URL}" | sudo gpg --dearmor -o "/etc/apt/keyrings/${KEYRING}"

_echo_info "sudo chmod go+r \"/etc/apt/keyrings/${KEYRING}\"\n"
sudo chmod go+r "/etc/apt/keyrings/${KEYRING}"

#--------------------------------------------------

_echo_warning 'Register Atlassian APT repository\n'

_echo_info "echo \"deb [arch=\$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/${KEYRING}] ${REPO_URL} ${DIST} ${COMPONENT}\" | sudo tee \"${SOURCES_LIST}\" > /dev/null\n"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/${KEYRING}] ${REPO_URL} ${DIST} ${COMPONENT}" | sudo tee "${SOURCES_LIST}" > /dev/null

#--------------------------------------------------

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

_echo_info 'sudo apt-get install --assume-yes acli\n'
sudo apt-get install --assume-yes acli
