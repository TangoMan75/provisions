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
## by rea-agents for APK analysis.
##
## This removes only the pinned MCP bridge JAR from
## ~/.local/share/rea/android. The rest of the REA data directory is left
## untouched. jadx itself is removed by remove_jadx.sh.
##
## @category android
## @link     https://github.com/1013503897/jadx-headless-mcp/releases/tag/v0.7.1
## @link     https://github.com/morluto/rea/blob/main/docs/guides/android/android-analysis.md

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PROJECT=jadx-headless-mcp
APP_NAME="${PROJECT}"
VERSION=0.7.1
REMOTE_FILE="${APP_NAME}-${VERSION}-all.jar"
INSTALL_DIR="${HOME}/.local/share/rea/android"
JAR="${INSTALL_DIR}/${REMOTE_FILE}"

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

if [ -f "${JAR}" ]; then
    _echo_warning "Remove ${APP_NAME} JAR\n"

    _echo_info "rm -f \"${JAR}\"\n"
    rm -f "${JAR}"
else
    _echo_warning "\"${JAR}\" not found, nothing to remove\n"
fi

#--------------------------------------------------

# The installer only asks the user to export this variable; it never edits
# shell profiles itself, so report it instead of rewriting user files.
if [ "${REA_JADX_MCP_JAR}" = "${JAR}" ]; then
    _echo_warning "REA_JADX_MCP_JAR still points to the removed JAR in this shell\n"
fi

_echo_info "If you exported REA_JADX_MCP_JAR in a shell profile or service unit, remove that line.\n"
_echo_info "Verify the bridge is gone with: rea doctor --provider jadx --json\n"
