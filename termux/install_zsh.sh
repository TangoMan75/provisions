#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## zsh
##
## Install Zsh and Oh My Zsh on Termux, set Zsh as the default shell and enable
## the zsh-autosuggestions and zsh-syntax-highlighting plugins.
##
## Zsh, git and curl are installed with "pkg", then the official Oh My Zsh
## installer runs unattended. Both plugins are cloned into the Oh My Zsh custom
## directory and added to the "plugins" array in "~/.zshrc".
##
## ```
## # usage
## ./termux/install_zsh.sh
## ```
##
## @category termux
## @link     https://github.com/ohmyzsh/ohmyzsh
## @link     https://ohmyz.sh/#install
## @link     https://github.com/zsh-users/zsh-autosuggestions
## @link     https://github.com/zsh-users/zsh-syntax-highlighting
## @link     https://wiki.termux.com/wiki/Zsh

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=zsh
AUTHOR=ohmyzsh
REPOSITORY=${AUTHOR}/ohmyzsh
INSTALL_URL="https://raw.githubusercontent.com/${REPOSITORY}/master/tools/install.sh"

ZSH_DIR="${HOME}/.oh-my-zsh"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-${ZSH_DIR}/custom}"
RC_FILE="${HOME}/.zshrc"

PLUGIN_REPOSITORIES=(
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-syntax-highlighting
)

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

# This script is meant for Termux only
if [ "${OSTYPE}" != 'linux-android' ] && [ "${OSTYPE}" != 'linux-androideabi' ]; then
    _echo_danger "error: \"$(basename "${0}")\" must be run inside Termux\n"
    exit 1
fi

if ! command -v pkg &> /dev/null; then
    _echo_danger "error: \"$(basename "${0}")\" requires pkg\n"
    exit 1
fi

#--------------------------------------------------

_echo_warning 'Update package lists\n'

_echo_info 'pkg update -y\n'
pkg update -y

#--------------------------------------------------

_echo_warning 'Install Zsh, git and curl\n'

_echo_info 'pkg install -y zsh git curl\n'
pkg install -y zsh git curl

#--------------------------------------------------

REQUIRED_COMMANDS=(curl git zsh)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'pkg install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

_echo_warning 'Set Zsh as default shell\n'

if [ "$(basename "${SHELL:-}")" = 'zsh' ]; then
    _echo_warning 'Zsh is already the default shell\n'
else
    _echo_info 'chsh -s zsh\n'

    if chsh -s zsh; then
        _echo_success 'Default shell changed to Zsh\n'
    else
        _echo_warning 'chsh failed, adding "exec zsh" to ~/.bashrc instead\n'

        if ! grep -q '^exec zsh$' "${HOME}/.bashrc" 2>/dev/null; then
            _echo_info "echo 'exec zsh' >> \"${HOME}/.bashrc\"\n"
            echo 'exec zsh' >> "${HOME}/.bashrc"
        fi
    fi
fi

#--------------------------------------------------

_echo_warning 'Install Oh My Zsh\n'

if [ -d "${ZSH_DIR}" ]; then
    _echo_warning "Oh My Zsh is already installed in \"${ZSH_DIR}\", skipping\n"
else
    TEMP_DIR=$(mktemp -d)
    _echo_info "Created temporary directory: \"${TEMP_DIR}\"\n"

    INSTALLER="${TEMP_DIR}/install.sh"

    _echo_info "curl -fsSL \"${INSTALL_URL}\" -o \"${INSTALLER}\"\n"
    curl -fsSL "${INSTALL_URL}" -o "${INSTALLER}"

    # Make sure the installer was downloaded and is not an error page
    if [ ! -s "${INSTALLER}" ] || head -n 1 "${INSTALLER}" | grep -q '<!DOCTYPE html>'; then
        _echo_danger 'error: Downloaded installer is invalid or not found.\n'
        rm -rf "${TEMP_DIR}"
        exit 1
    fi

    # --unattended skips both chsh and zsh, the shell is changed above and
    # Zsh starts only when the user asks for it
    _echo_info "sh \"${INSTALLER}\" --unattended\n"

    if ! sh "${INSTALLER}" --unattended; then
        _echo_danger 'error: Oh My Zsh installation failed\n'
        rm -rf "${TEMP_DIR}"
        exit 1
    fi

    _echo_info "rm -rf \"${TEMP_DIR}\"\n"
    rm -rf "${TEMP_DIR}"
fi

#--------------------------------------------------

_echo_warning 'Install Zsh plugins\n'

_echo_info "mkdir -p \"${ZSH_CUSTOM_DIR}/plugins\"\n"
mkdir -p "${ZSH_CUSTOM_DIR}/plugins"

for PLUGIN_REPOSITORY in "${PLUGIN_REPOSITORIES[@]}"; do
    PLUGIN_NAME=$(basename "${PLUGIN_REPOSITORY}")
    PLUGIN_DIR="${ZSH_CUSTOM_DIR}/plugins/${PLUGIN_NAME}"

    if [ -d "${PLUGIN_DIR}" ]; then
        _echo_warning "Plugin \"${PLUGIN_NAME}\" is already installed, skipping\n"
        continue
    fi

    _echo_info "git clone --depth 1 \"https://github.com/${PLUGIN_REPOSITORY}\" \"${PLUGIN_DIR}\"\n"
    git clone --depth 1 "https://github.com/${PLUGIN_REPOSITORY}" "${PLUGIN_DIR}"
done

#--------------------------------------------------

_echo_warning 'Enable plugins in .zshrc\n'

if [ ! -f "${RC_FILE}" ]; then
    _echo_danger "error: \"${RC_FILE}\" not found, Oh My Zsh installation failed\n"
    exit 1
fi

MISSING_PLUGINS=()

for PLUGIN_REPOSITORY in "${PLUGIN_REPOSITORIES[@]}"; do
    PLUGIN_NAME=$(basename "${PLUGIN_REPOSITORY}")

    if ! grep -q "${PLUGIN_NAME}" "${RC_FILE}"; then
        MISSING_PLUGINS+=("${PLUGIN_NAME}")
    fi
done

if [ "${#MISSING_PLUGINS[@]}" -eq 0 ]; then
    _echo_warning 'Zsh plugins are already enabled\n'
else
    PLUGIN_LIST="${MISSING_PLUGINS[*]}"

    # Add the missing plugins to the "plugins" array, whether it is declared
    # on a single line or across several lines
    if grep -qE '^[[:space:]]*plugins=\(' "${RC_FILE}"; then
        _echo_info "sed -i 's/^\\([[:space:]]*plugins=(\\)/\\1${PLUGIN_LIST} /' \"${RC_FILE}\"\n"
        sed -i "s/^\([[:space:]]*plugins=(\)/\1${PLUGIN_LIST} /" "${RC_FILE}"
    else
        _echo_info "inserting 'plugins=(${PLUGIN_LIST})' at the top of \"${RC_FILE}\"\n"

        {
            echo "plugins=(${PLUGIN_LIST})"
            cat "${RC_FILE}"
        } > "${RC_FILE}.tmp"

        mv "${RC_FILE}.tmp" "${RC_FILE}"
    fi
fi

#--------------------------------------------------

_echo_success 'Zsh and Oh My Zsh installed successfully\n'
_echo_info 'Restart Termux or run "exec zsh" to start using Zsh\n'
