#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## signal-cli
##
## signal-cli is a commandline interface for the Signal messenger.
## This script installs the GraalVM native build, which is a single
## self-contained binary that does not require a Java Runtime
## Environment. It supports registering, verifying, sending and
## receiving messages, and provides a daemon mode with JSON-RPC and
## D-Bus interfaces intended for server-side notification scripts.
##
## ```
## # register a phone number
## signal-cli -a +33612345678 register
##
## # verify the code received by SMS
## signal-cli -a +33612345678 verify 123-456
##
## # send a message
## signal-cli -a +33612345678 send -m "Hello" +33687654321
## ```
##
## @category cli
## @link     https://github.com/AsamK/signal-cli
## @link     https://github.com/AsamK/signal-cli/wiki
## @link     https://github.com/AsamK/signal-cli/wiki/Binary-distributions
## @link     https://github.com/AsamK/signal-cli#install-system-wide-on-linux--graalvm-native-build-

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

if ! command -v tar &> /dev/null; then
    _echo_danger "error: \"$(basename "${0}")\" requires tar, try: 'sudo apt-get install -y tar'\n"
    exit 1
fi

#--------------------------------------------------

APP_NAME=signal-cli
AUTHOR=AsamK
REPOSITORY="${AUTHOR}/${APP_NAME}"
BINARY="${APP_NAME}"
DESTINATION=/usr/local/bin

#--------------------------------------------------

# Get the latest version
VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=0.14.6
fi

#--------------------------------------------------

# GraalVM native build: single static binary, no Java required
# https://github.com/AsamK/signal-cli#install-system-wide-on-linux--graalvm-native-build-
REMOTE_FILE="${APP_NAME}-${VERSION}-Linux-native.tar.gz"
ARCHIVE="${REMOTE_FILE}"
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${VERSION} (native build)"

#--------------------------------------------------

# Create temporary directory
TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning "Downloading ${APP_NAME} from ${URL}\n"

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    _echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${ARCHIVE}\"\n"
    curl -Lf "${URL}" -o "${TEMP_DIR}/${ARCHIVE}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${ARCHIVE}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${ARCHIVE}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${ARCHIVE}" ] || head -n 1 "${TEMP_DIR}/${ARCHIVE}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found. Please check the URL and try again.\n"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Ensure destination directory exists\n"

_echo_info "sudo mkdir -p \"${DESTINATION}\"\n"
sudo mkdir -p "${DESTINATION}"

#--------------------------------------------------

_echo_warning "Extract \"${ARCHIVE}\" to \"${DESTINATION}\"\n"

# extract with tar
# -x, --extract
# -f, --file [ARCHIVE]
# -C, --directory [DIR] : destination directory
# The native build extracts as a single self-contained static binary
# named "signal-cli" (no /bin/ subdirectory, unlike the JVM build).
_echo_info "sudo tar -xf \"${TEMP_DIR}/${ARCHIVE}\" -C \"${DESTINATION}\"\n"
sudo tar -xf "${TEMP_DIR}/${ARCHIVE}" -C "${DESTINATION}"

#--------------------------------------------------

_echo_warning "Setting executable permissions for ${BINARY}\n"

_echo_info "sudo chmod uga+x \"${DESTINATION}/${BINARY}\"\n"
sudo chmod uga+x "${DESTINATION}/${BINARY}"

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_warning "Verify install\n"

_echo_info "${BINARY} --version\n"
${BINARY} --version

