#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## hermes-agent
##
## The agent that grows with you - Hermes Agent by Nous Research
##
## @category ai
## @link     https://hermes-agent.nousresearch.com
## @link     https://github.com/NousResearch/hermes-agent

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=hermes-agent
HERMES_HOME="${HOME}/.hermes"

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "rm -rf \"${HERMES_HOME}\"\n"
rm -rf "${HERMES_HOME}"

_echo_info "rm -f \"${HOME}/.local/bin/hermes\"\n"
rm -f "${HOME}/.local/bin/hermes"

_echo_info "rm -f \"${HOME}/.local/bin/node\"\n"
rm -f "${HOME}/.local/bin/node"

_echo_info "rm -f \"${HOME}/.local/bin/npm\"\n"
rm -f "${HOME}/.local/bin/npm"

_echo_info "rm -f \"${HOME}/.local/bin/npx\"\n"
rm -f "${HOME}/.local/bin/npx"

_echo_info "sudo rm -rf \"/usr/local/lib/hermes-agent\"\n"
sudo rm -rf "/usr/local/lib/hermes-agent"

_echo_info "sudo rm -f \"/usr/local/bin/hermes\"\n"
sudo rm -f "/usr/local/bin/hermes"

_echo_info "sudo rm -rf \"/usr/local/share/uv/python\"\n"
sudo rm -rf "/usr/local/share/uv/python"

_echo_info "sudo rm -rf \"/usr/local/share/uv/bin\"\n"
sudo rm -rf "/usr/local/share/uv/bin"

#--------------------------------------------------

_echo_warning "You may also want to remove ~/.hermes-backup-* directories manually if any exist.\n"
