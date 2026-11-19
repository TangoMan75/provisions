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
## This removes the release unpacked by install_jadx.sh from
## ~/.local/share/jadx and the ~/.local/bin/jadx launcher. The REA-pinned
## headless JADX MCP bridge installed by install_jadx-headless-mcp.sh is
## intentionally left untouched.
##
## @category android
## @link     https://github.com/skylot/jadx
## @link     https://github.com/skylot/jadx/releases/latest

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=jadx
INSTALL_DIR="${HOME}/.local/share/${APP_NAME}"
DESTINATION="${HOME}/.local/bin"
BINARY="${APP_NAME}"

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_warning "Remove ${BINARY} launcher symlink\n"

if [ -L "${DESTINATION}/${BINARY}" ]; then
    if [ "$(readlink "${DESTINATION}/${BINARY}")" = "${INSTALL_DIR}/bin/${BINARY}" ]; then
        _echo_info "rm -f \"${DESTINATION}/${BINARY}\"\n"
        rm -f "${DESTINATION}/${BINARY}"
    else
        _echo_warning "\"${DESTINATION}/${BINARY}\" points elsewhere, leaving it untouched\n"
    fi
else
    _echo_warning "\"${DESTINATION}/${BINARY}\" not found, nothing to remove\n"
fi

#--------------------------------------------------

if [ -d "${INSTALL_DIR}" ]; then
    _echo_warning "Remove installation folder \"${INSTALL_DIR}\"\n"

    _echo_info "rm -rf \"${INSTALL_DIR}\"\n"
    rm -rf "${INSTALL_DIR}"
else
    _echo_warning "\"${INSTALL_DIR}\" not found, nothing to remove\n"
fi

#--------------------------------------------------

_echo_warning "${APP_NAME} removed\n"
