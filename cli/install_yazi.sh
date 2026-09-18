#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## yazi
##
## A blazing-fast terminal file manager, written in Rust
##
## Yazi can be optionally extended with other command-line tools to enable additional features.
## 
## - nerd-fonts (recommended)
## - ffmpeg (for video thumbnails)
## - 7-Zip (for archive extraction and preview, requires non-standalone version)
## - jq (for JSON preview)
## - poppler (for PDF preview)
## - fd (for file searching)
## - rg (for file content searching)
## - fzf (for quick file subtree navigation, >= 0.53.0)
## - zoxide (for historical directories navigation, requires fzf)
## - resvg (for SVG preview)
## - ImageMagick (for Font, HEIC, and JPEG XL preview, >= 7.1.1)
## - xclip / wl-clipboard / xsel (for Linux clipboard support)
##
## @category cli
## @link     https://yazi-rs.github.io
## @link     https://github.com/sxyazi/yazi

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl tar unzip)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME="yazi"
AUTHOR=sxyazi
REPOSITORY="${AUTHOR}/${APP_NAME}"
DESTINATION="/usr/bin"

#--------------------------------------------------

VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=26.8.15
fi

#--------------------------------------------------

# Map uname to yazi's target triples
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
case "${OS}" in
    linux)
        case "$(uname -m)" in
            x86_64) TARGET=x86_64-unknown-linux-gnu ;;
            aarch64|arm64) TARGET=aarch64-unknown-linux-gnu ;;
            armv7l|armv6l) TARGET=arm-unknown-linux-gnueabihf ;;
            *) _echo_danger "error: Unsupported architecture \"$(uname -m)\".\n"; exit 1 ;;
        esac
        ;;
    darwin)
        case "$(uname -m)" in
            x86_64) TARGET=x86_64-apple-darwin ;;
            arm64|aarch64) TARGET=aarch64-apple-darwin ;;
            *) _echo_danger "error: Unsupported architecture \"$(uname -m)\".\n"; exit 1 ;;
        esac
        ;;
    *)
        _echo_danger "error: Unsupported operating system \"${OS}\".\n"
        exit 1
        ;;
esac

# yazi release assets are named yazi-<target>.zip (no version)
REMOTE_FILE="${APP_NAME}-${TARGET}.zip"
ARCHIVE="${REMOTE_FILE}"
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${VERSION}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    curl -Lf "${URL}" -o "${TEMP_DIR}/${REMOTE_FILE}"
elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${REMOTE_FILE}"
else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${REMOTE_FILE}" ] || head -n 1 "${TEMP_DIR}/${REMOTE_FILE}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found. Please check the architecture and URL.\n"
    _echo_info "Supported architectures: x86_64, aarch64\n"
    _echo_info "Your architecture: ${TARGET}\n"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Extract \"${ARCHIVE}\"\n"

_echo_info "unzip \"${TEMP_DIR}/${ARCHIVE}\" -d \"${TEMP_DIR}\"\n"
unzip "${TEMP_DIR}/${ARCHIVE}" -d "${TEMP_DIR}"

#--------------------------------------------------

if [ ! -d "${DESTINATION}" ]; then
    _echo_warning 'Create destination folder\n'

    _echo_info "mkdir -p \"${DESTINATION}\"\n"
    mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

# The yazi archive nests binaries inside a target-named subdirectory
EXTRACT_DIR="${TEMP_DIR}/${APP_NAME}-${TARGET}"

_echo_warning "Move binaries to \"${DESTINATION}\"\n"

for BIN in yazi ya; do
    if [ -f "${EXTRACT_DIR}/${BIN}" ]; then
        _echo_info "sudo mv \"${EXTRACT_DIR}/${BIN}\" \"${DESTINATION}\"\n"
        sudo mv "${EXTRACT_DIR}/${BIN}" "${DESTINATION}"

        _echo_info "chmod uga+x \"${DESTINATION}/${BIN}\"\n"
        chmod uga+x "${DESTINATION}/${BIN}"
    fi
done

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"
