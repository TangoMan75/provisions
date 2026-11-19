#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## jadx-headless-mcp
##
## REA-pinned headless JADX MCP bridge (jadx-headless-mcp 0.7.1) required
## by rea-agents for APK analysis. REA does not download or install this
## JAR itself. This script does not install jadx, see install_jadx.sh.
##
## ```
## # install the bridge, then point REA at it
## export REA_JADX_MCP_JAR="$HOME/.local/share/rea/android/jadx-headless-mcp-0.7.1-all.jar"
## rea doctor --provider jadx --json
## ```
##
## @category android
## @link     https://github.com/1013503897/jadx-headless-mcp/releases/tag/v0.7.1
## @link     https://github.com/morluto/rea/blob/main/docs/guides/android/android-analysis.md

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# Verify a file against a SHA-256 digest
verify_sha256() {
    local expected="${1}"
    local path="${2}"

    if command -v sha256sum &> /dev/null; then
        printf '%s  %s\n' "${expected}" "${path}" | sha256sum -c -
    elif command -v shasum &> /dev/null; then
        printf '%s  %s\n' "${expected}" "${path}" | shasum -a 256 -c -
    else
        _echo_danger "error: \"$(basename "${0}")\" requires sha256sum or shasum\n"
        return 1
    fi
}

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

# REA runs its metadata bridge in source-file mode, so a full JDK is required
if ! command -v java &> /dev/null; then
    _echo_danger "error: \"$(basename "${0}")\" requires a full JDK 17+, try: 'sudo apt-get install -y openjdk-21-jdk-headless'\n"
    exit 1
fi

JAVA_VERSION=$(java -version 2>&1 | awk -F'[".]' '/version/ { print ($2 == 1 ? $3 : $2); exit }')
if [ -z "${JAVA_VERSION}" ] || [ "${JAVA_VERSION}" -lt 17 ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires java 17 or later, found \"${JAVA_VERSION}\"\n"
    _echo_info "try: 'sudo apt-get install -y openjdk-21-jdk-headless'\n"
    exit 1
fi

if ! java --list-modules 2> /dev/null | grep -q '^jdk.compiler@'; then
    _echo_danger "error: \"$(basename "${0}")\" requires a full JDK with jdk.compiler (a JRE is not enough)\n"
    _echo_info "try: 'sudo apt-get install -y openjdk-21-jdk-headless'\n"
    exit 1
fi

#--------------------------------------------------

PROJECT=jadx-headless-mcp
AUTHOR=1013503897
REPOSITORY="${AUTHOR}/${PROJECT}"
APP_NAME="${PROJECT}"
VERSION=0.7.1
REMOTE_FILE="${APP_NAME}-${VERSION}-all.jar"
INSTALL_DIR="${HOME}/.local/share/rea/android"
JAR="${INSTALL_DIR}/${REMOTE_FILE}"
SHA256=6e5eacf500b64292bfb73c49797c1958f6ee44646e43e868039ae7feb573ff75

#--------------------------------------------------

URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${VERSION}"

#--------------------------------------------------

if [ -f "${JAR}" ] && verify_sha256 "${SHA256}" "${JAR}" &> /dev/null; then
    _echo_warning "${APP_NAME} already installed and verified: \"${JAR}\"\n"
else
    if [ -f "${JAR}" ]; then
        _echo_warning "Existing ${APP_NAME} does not match the pinned digest, replacing it\n"
    fi

    if [ ! -d "${INSTALL_DIR}" ]; then
        _echo_warning 'Create install folder\n'

        _echo_info "mkdir -p \"${INSTALL_DIR}\"\n"
        mkdir -p "${INSTALL_DIR}"
    fi

    TEMP_DIR=$(mktemp -d)
    _echo_warning "Created temporary directory: ${TEMP_DIR}\n"

    #--------------------------------------------------

    _echo_warning "Downloading ${APP_NAME} to temporary directory\n"

    _echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    curl -Lf "${URL}" -o "${TEMP_DIR}/${REMOTE_FILE}"

    # Check if the downloaded file is valid (not empty and not an HTML error page)
    if [ ! -s "${TEMP_DIR}/${REMOTE_FILE}" ] || head -n 1 "${TEMP_DIR}/${REMOTE_FILE}" | grep -q "<!DOCTYPE html>"; then
        _echo_danger "error: Downloaded ${APP_NAME} is invalid or not found.\n"
        _echo_info "Requested version: ${VERSION}\n"
        rm -rf "${TEMP_DIR}"
        exit 1
    fi

    #--------------------------------------------------

    _echo_warning "Verifying ${APP_NAME} checksum\n"

    _echo_info "verify_sha256 \"${SHA256}\" \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    if ! verify_sha256 "${SHA256}" "${TEMP_DIR}/${REMOTE_FILE}"; then
        _echo_danger "error: ${APP_NAME} checksum verification failed.\n"
        rm -rf "${TEMP_DIR}"
        exit 1
    fi

    #--------------------------------------------------

    _echo_warning "Move ${APP_NAME} to \"${INSTALL_DIR}\"\n"

    _echo_info "mv -f \"${TEMP_DIR}/${REMOTE_FILE}\" \"${JAR}\"\n"
    mv -f "${TEMP_DIR}/${REMOTE_FILE}" "${JAR}"

    _echo_info "chmod 644 \"${JAR}\"\n"
    chmod 644 "${JAR}"

    _echo_info "rm -rf \"${TEMP_DIR}\"\n"
    rm -rf "${TEMP_DIR}"

    # Verify the installed copy, in case moving crossed filesystems
    if ! verify_sha256 "${SHA256}" "${JAR}" &> /dev/null; then
        _echo_danger "error: Installed ${APP_NAME} checksum verification failed.\n"
        rm -f "${JAR}"
        exit 1
    fi
fi

#--------------------------------------------------

_echo_warning "${APP_NAME} installed at \"${JAR}\"\n"
_echo_info "Export REA_JADX_MCP_JAR in the environment that launches rea:\n\n"
_echo_warning "  export REA_JADX_MCP_JAR=\"${JAR}\"\n\n"
_echo_info "REA requires a full JDK 17+; set JAVA_HOME to select one explicitly.\n"
_echo_info 'Verify with: rea doctor --provider jadx --json\n'
