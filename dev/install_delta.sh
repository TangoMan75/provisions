#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## delta
##
## A syntax-highlighting pager for git, diff, and grep output
##
## @category dev
## @link     https://github.com/dandavison/delta

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

APP_NAME="delta"
AUTHOR=dandavison
REPOSITORY=${AUTHOR}/${APP_NAME}
BINARY="${APP_NAME}"
DESTINATION="/usr/bin"

#--------------------------------------------------

VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=0.19.2
fi

#--------------------------------------------------

# Map uname to delta's target triples
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
case "${OS}" in
    darwin)
        case "$(uname -m)" in
            x86_64) TARGET=x86_64-apple-darwin ;;
            arm64|aarch64) TARGET=aarch64-apple-darwin ;;
        esac
        ;;
    linux)
        case "$(uname -m)" in
            x86_64) TARGET=x86_64-unknown-linux-gnu ;;
            aarch64) TARGET=aarch64-unknown-linux-gnu ;;
            armv7l|armv6l) TARGET=arm-unknown-linux-gnueabihf ;;
        esac
        ;;
esac

REMOTE_FILE="${APP_NAME}-${VERSION}-${TARGET}.tar.gz"
ARCHIVE="${REMOTE_FILE}"
URL="https://github.com/${REPOSITORY}/releases/download/${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${VERSION}"

#--------------------------------------------------

if ! command -v tar &> /dev/null; then
    _echo_danger "error: \"$(basename "${0}")\" requires tar, try: 'sudo apt-get install -y tar'\n"
    exit 1
fi

#--------------------------------------------------

if [ -z "${TARGET}" ]; then
    _echo_danger "error: Unsupported architecture or OS.\n"
    exit 1
fi

#--------------------------------------------------

# Create temporary directory
TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning "Downloading ${APP_NAME} from ${URL}\n"

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    _echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    curl -Lf "${URL}" -o "${TEMP_DIR}/${REMOTE_FILE}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${REMOTE_FILE}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

_echo_warning "Extract \"${ARCHIVE}\"\n"

_echo_info "tar -xzf \"${TEMP_DIR}/${ARCHIVE}\" -C \"${TEMP_DIR}\" --strip-components=1\n"
tar -xzf "${TEMP_DIR}/${ARCHIVE}" -C "${TEMP_DIR}" --strip-components=1

#--------------------------------------------------

if [ ! -d "${DESTINATION}" ]; then
    _echo_warning 'Create destination folder\n'

    _echo_info "mkdir -p \"${DESTINATION}\"\n"
    mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

_echo_warning "Move binary to \"${DESTINATION}\"\n"

_echo_info "sudo mv \"${TEMP_DIR}/${BINARY}\" \"${DESTINATION}\"\n"
sudo mv "${TEMP_DIR}/${BINARY}" "${DESTINATION}"

#--------------------------------------------------

_echo_warning "Setting executable permissions for ${BINARY}\n"

_echo_info "chmod uga+x \"${DESTINATION}/${BINARY}\"\n"
chmod uga+x "${DESTINATION}/${BINARY}"

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_warning 'Config git delta\n'

_echo_info 'git config --global core.pager delta\n'
git config --global core.pager delta

_echo_info 'git config --global interactive.diffFilter "delta --color-only"\n'
git config --global interactive.diffFilter "delta --color-only"

_echo_info 'git config --global delta.navigate true\n'
git config --global delta.navigate true

_echo_info 'git config --global delta.dark true\n'
git config --global delta.dark true  # or `delta.light true`, or omit for auto-detection

_echo_info 'git config --global merge.conflictStyle zdiff3\n'
git config --global merge.conflictStyle zdiff3
