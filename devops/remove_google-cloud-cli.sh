#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove google-cloud-cli
##
## Google Cloud CLI (gcloud) — command-line tool to create and manage Google Cloud resources, installed from the official Google apt repository with a dedicated keyring.
##
## @category devops
## @link     https://docs.gcloud.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=google-cloud-cli

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get remove --assume-yes \"${APP_NAME}\"\n"
sudo apt-get remove --assume-yes "${APP_NAME}"

#--------------------------------------------------

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

#--------------------------------------------------

# remove sources list files
_echo_info 'sudo rm -f /etc/apt/sources.list.d/google-cloud-sdk.list\n'
sudo rm -f /etc/apt/sources.list.d/google-cloud-sdk.list

#--------------------------------------------------

# remove gpg keyring
_echo_info 'sudo rm -f /usr/share/keyrings/cloud.google.gpg\n'
sudo rm -f /usr/share/keyrings/cloud.google.gpg

#--------------------------------------------------

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

# remove config and cache directories
_echo_warning "Remove config and cache directories\n"

_echo_info "rm -rf \"${HOME}/.config/gcloud\"\n"
rm -rf "${HOME}/.config/gcloud"

_echo_info "rm -rf \"${HOME}/.cache/gcloud\"\n"
rm -rf "${HOME}/.cache/gcloud"

#--------------------------------------------------

# TODO: remove user gcloud state files if present (e.g. path.bash.inc sourced from shell rc files, gsutil credential cache)
