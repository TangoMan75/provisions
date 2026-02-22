#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## kiro-cli
##
## @link https://cli.kiro.dev/
## @category ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# Function to add a directory to PATH if not already present and if the shell config file exists
add_to_path() {
    local _path_to_add="$1"
    local _shell_config_file="${HOME}/.bashrc"
    local _export_statement="export PATH=\"${_path_to_add}:\$PATH\""

    if [[ ":$PATH:" != *":${_path_to_add}:"* ]]; then
        _echo_info "Checking PATH for '${_path_to_add}'...\n"
        if [ -f "${_shell_config_file}" ]; then
            if ! grep -qF "${_export_statement}" "${_shell_config_file}"; then
                _echo_info "Appending '${_export_statement}' to '${_shell_config_file}'\n"
                echo -e "\n# Added by TangoMan Provisions for ${_path_to_add}" >> "${_shell_config_file}"
                echo "${_export_statement}" >> "${_shell_config_file}"
                _echo_info "Please restart your shell or run 'source ${_shell_config_file}' to apply changes.\n"
            else
                _echo_info "'${_path_to_add}' is already configured in '${_shell_config_file}'.\n"
            fi
        else
            _echo_danger "Warning: '${_shell_config_file}' not found. Please add '${_export_statement}' to your shell configuration manually.\n"
        fi
    else
        _echo_info "'${_path_to_add}' is already in your current session's PATH.\n"
    fi
}

#--------------------------------------------------

if [ ! -x "$(command -v curl)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires curl\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install kiro-cli"

#--------------------------------------------------

_echo_info "curl -fsSL https://cli.kiro.dev/install | bash\n"
curl -fsSL https://cli.kiro.dev/install | bash

#--------------------------------------------------

# Add ~/.local/bin to PATH
add_to_path "$HOME/.local/bin"

#--------------------------------------------------

_echo_info "sync\n"
sync
