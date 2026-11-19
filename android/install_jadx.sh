#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## jadx
##
## Dex to Java decompiler: decodes AndroidManifest.xml, resources.arsc
## and Dalvik bytecode to Java source from the command line.
##
## The REA-pinned headless JADX MCP bridge is installed separately with
## install_jadx-headless-mcp.sh.
##
## ```
## # decompile an APK into ./out
## jadx -d out application.apk
##
## # decode resources and AndroidManifest.xml only
## jadx -s -d out application.apk
## ```
##
## @category android
## @link     https://github.com/skylot/jadx
## @link     https://github.com/skylot/jadx/releases/latest

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl unzip)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME=jadx
AUTHOR=skylot
REPOSITORY="${AUTHOR}/${APP_NAME}"
INSTALL_DIR="${HOME}/.local/share/${APP_NAME}"
DESTINATION="${HOME}/.local/bin"

#--------------------------------------------------

VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=1.5.7
fi

#--------------------------------------------------

REMOTE_FILE="${APP_NAME}-${VERSION}.zip"
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${VERSION}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

_echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
curl -Lf "${URL}" -o "${TEMP_DIR}/${REMOTE_FILE}"

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${REMOTE_FILE}" ] || head -n 1 "${TEMP_DIR}/${REMOTE_FILE}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found. Please check the version and URL.\n"
    _echo_info "Requested version: ${VERSION}\n"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Extract \"${REMOTE_FILE}\"\n"

_echo_info "unzip -q \"${TEMP_DIR}/${REMOTE_FILE}\" -d \"${TEMP_DIR}/${APP_NAME}\"\n"
unzip -q "${TEMP_DIR}/${REMOTE_FILE}" -d "${TEMP_DIR}/${APP_NAME}"

# Make sure the expected launcher is present before replacing any previous install
if [ ! -f "${TEMP_DIR}/${APP_NAME}/bin/${APP_NAME}" ]; then
    _echo_danger "error: Archive does not contain \"bin/${APP_NAME}\".\n"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

#--------------------------------------------------

if [ -d "${INSTALL_DIR}" ]; then
    _echo_warning "Replacing existing installation in \"${INSTALL_DIR}\"\n"

    _echo_info "rm -rf \"${INSTALL_DIR}\"\n"
    rm -rf "${INSTALL_DIR}"
fi

if [ ! -d "${INSTALL_DIR%/*}" ]; then
    _echo_warning 'Create install folder\n'

    _echo_info "mkdir -p \"${INSTALL_DIR%/*}\"\n"
    mkdir -p "${INSTALL_DIR%/*}"
fi

_echo_warning "Move ${APP_NAME} to \"${INSTALL_DIR}\"\n"

_echo_info "mv \"${TEMP_DIR}/${APP_NAME}\" \"${INSTALL_DIR}\"\n"
mv "${TEMP_DIR}/${APP_NAME}" "${INSTALL_DIR}"

#--------------------------------------------------

if [ ! -d "${DESTINATION}" ]; then
    _echo_warning 'Create destination folder\n'

    _echo_info "mkdir -p \"${DESTINATION}\"\n"
    mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

_echo_warning "Link ${APP_NAME} launcher to \"${DESTINATION}\"\n"

_echo_info "ln -sf \"${INSTALL_DIR}/bin/${APP_NAME}\" \"${DESTINATION}/${APP_NAME}\"\n"
ln -sf "${INSTALL_DIR}/bin/${APP_NAME}" "${DESTINATION}/${APP_NAME}"

#--------------------------------------------------

_echo_warning "Setting executable permissions for ${APP_NAME}\n"

_echo_info "chmod uga+x \"${INSTALL_DIR}/bin/${APP_NAME}\"\n"
chmod uga+x "${INSTALL_DIR}/bin/${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_warning "Checking ${APP_NAME} installation\n"

_echo_info "\"${DESTINATION}/${APP_NAME}\" --version\n"
if ! "${DESTINATION}/${APP_NAME}" --version; then
    _echo_danger "error: \"${APP_NAME}\" installation check failed.\n"
    exit 1
fi

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
