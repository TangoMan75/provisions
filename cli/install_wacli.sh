#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## wacli
##
## WhatsApp CLI: sync, search, send.
##
## wacli is a scriptable WhatsApp client built on whatsmeow. It pairs as
## a linked WhatsApp Web device via QR, mirrors your messages into a
## local SQLite store with FTS5 search, and exposes offline search,
## sending, replies, contact/chat/group management and history backfill
## from the command line. Every command supports --json for scripting
## and --events for an NDJSON lifecycle stream.
##
## ```
## # 1. Pair (shows QR), then bootstrap sync
## wacli auth
##
## # 2. Keep syncing in the background (no QR; needs prior auth)
## wacli sync --follow
##
## # 3. Search the local store
## wacli messages search "meeting"
##
## # 4. Send
## wacli send text --to 1234567890 --message "hello"
## wacli send file --to mom --file ./pic.jpg --caption "hi"
##
## # 5. Diagnostics
## wacli doctor
## ```
##
## @category cli
## @link     https://github.com/openclaw/wacli
## @link     https://wacli.sh

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl tar unzip wget)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME=wacli
AUTHOR=openclaw
REPOSITORY="${AUTHOR}/${APP_NAME}"
BINARY="${APP_NAME}"
DESTINATION="${HOME}/.local/bin"

#--------------------------------------------------

# Get the latest version
VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=0.13.0
fi

#--------------------------------------------------

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m | sed 's/x86_64/amd64/; s/aarch64/arm64/')

# wacli release assets follow the pattern:
#   wacli_${VERSION}_${OS}_${ARCH}.tar.gz  (linux, darwin)
#   wacli_${VERSION}_windows_amd64.zip     (windows)
case "${OS}" in
    windows*)
        REMOTE_FILE="${APP_NAME}_${VERSION}_${OS}_${ARCH}.zip"
        ;;
    *)
        REMOTE_FILE="${APP_NAME}_${VERSION}_${OS}_${ARCH}.tar.gz"
        ;;
esac
ARCHIVE="${REMOTE_FILE}"
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${VERSION}"

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
    rm -rf "${TEMP_DIR}"
    exit 1
fi

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${ARCHIVE}" ] || head -n 1 "${TEMP_DIR}/${ARCHIVE}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found. Please check the architecture and URL.\n"
    _echo_info "Supported architectures: amd64, arm64\n"
    _echo_info "Your architecture: ${ARCH}\n"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Extract \"${ARCHIVE}\"\n"

# Extract file based on its extension
#
# ${ARCHIVE##*.} : This is a parameter expansion expression
#             ## : Removes the shortest pattern that matches the entire string from the end of the value
#              * : Matches zero or more characters
#              . : Matches a literal dot (.)
case "${ARCHIVE##*.}" in
    gz)
        # extract with tar
        # -x, --extract
        # -v, --verbose
        # -z, --gzip, --gunzip --ungzip
        # -f, --file [ARCHIVE]
        # -C, --directory [DIR] : destination directory
        _echo_info "tar -xvzf \"${TEMP_DIR}/${ARCHIVE}\" -C \"${TEMP_DIR}\"\n"
        tar -xvzf "${TEMP_DIR}/${ARCHIVE}" -C "${TEMP_DIR}"
        ;;
    zip)
        _echo_info "unzip \"${TEMP_DIR}/${ARCHIVE}\" -d \"${TEMP_DIR}\"\n"
        unzip "${TEMP_DIR}/${ARCHIVE}" -d "${TEMP_DIR}"
        ;;
    *)
        _echo_danger "error: Unsupported archive format \"${ARCHIVE##*.}\".\n"
        rm -rf "${TEMP_DIR}"
        exit 1
        ;;
esac

#--------------------------------------------------

if [ ! -d "${DESTINATION}" ]; then
    _echo_warning 'Create destination folder\n'

    _echo_info "mkdir -p \"${DESTINATION}\"\n"
    mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

_echo_warning "Move binary to \"${DESTINATION}\"\n"

_echo_info "mv \"${TEMP_DIR}/${BINARY}\" \"${DESTINATION}\"\n"
mv "${TEMP_DIR}/${BINARY}" "${DESTINATION}"

#--------------------------------------------------

_echo_warning "Setting executable permissions for ${BINARY}\n"

_echo_info "chmod uga+x \"${DESTINATION}/${BINARY}\"\n"
chmod uga+x "${DESTINATION}/${BINARY}"

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_warning "Verify install\n"

_echo_info "${BINARY} version\n"
"${DESTINATION}/${BINARY}" version

#--------------------------------------------------

# Check PATH and provide instructions
if ! echo "${PATH}" | grep -q "${DESTINATION}"; then
    _echo_warning "${DESTINATION} is not in your PATH\n"
    _echo_info "To use ${APP_NAME} from anywhere, add the following to your shell profile:\n\n"
    _echo_warning "  export PATH=\"\$PATH:${DESTINATION}\"\n\n"
    _echo_info 'For bash, add it to ~/.bashrc or ~/.bash_profile\n'
    _echo_info 'For zsh, add it to ~/.zshrc\n'
    _echo_info "For fish, run: fish_add_path ${DESTINATION}\n"
fi

#--------------------------------------------------

_echo_warning "Next steps\n"
_echo_info "Run \"${APP_NAME} auth\" to pair as a linked WhatsApp Web device (QR code will be displayed).\n"
_echo_info "Run \"${APP_NAME} sync --follow\" to start mirroring messages into the local SQLite store.\n"
_echo_info "Default store directory: ~/.local/state/wacli (Linux) or ~/.wacli (macOS / Windows).\n"
