#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## opencode
##
## ```
## # global configuration
## s ~/.local/share/opencode
##
## # v1 login
## opencode console login
##
## # v2 login
## opencode auth login opencode
## ```
##
## @category ai
## @link     https://opencode.ai/docs/ecosystem#plugins
## @link     https://github.com/anomalyco/opencode
## @link     https://opencode.ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PROJECT=opencode

#--------------------------------------------------

_alert_primary "Install ${PROJECT}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -Lf https://opencode.ai/v2/install | bash\n"
    curl -Lf https://opencode.ai/v2/install | bash

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- https://opencode.ai/v2/install | bash\n"
    wget -qO- https://opencode.ai/v2/install | bash

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

# Symlink opencode bin directory to /usr/bin
_echo_info "sudo ln -sfn \"${HOME}/.opencode/bin/opencode\" /usr/bin/opencode\n"
sudo ln -sfn "${HOME}/.opencode/bin/opencode" /usr/bin/opencode

#--------------------------------------------------

# Add opencode bin directory to PATH in ~/.bashrc if not already present
# shellcheck disable=SC2016
if [ -f "${HOME}/.bashrc" ] && ! grep -qF "export PATH=${HOME}/.opencode/bin:\$PATH" "${HOME}/.bashrc"; then
    # shellcheck disable=SC2016
    _echo_info "echo 'export PATH=${HOME}/.opencode/bin:\$PATH' >> ~/.bashrc\n"
    # shellcheck disable=SC2016
    echo "export PATH=${HOME}/.opencode/bin:\$PATH" >> "${HOME}/.bashrc"
fi

#--------------------------------------------------

# Add opencode bin directory to PATH in ~/.zshrc if not already present
# shellcheck disable=SC2016
if [ -f "${HOME}/.zshrc" ] && ! grep -qF "export PATH=${HOME}/.opencode/bin:\$PATH" "${HOME}/.zshrc"; then
    # shellcheck disable=SC2016
    _echo_info "echo 'export PATH=${HOME}/.opencode/bin:\$PATH' >> ~/.zshrc\n"
    # shellcheck disable=SC2016
    echo "export PATH=${HOME}/.opencode/bin:\$PATH" >> "${HOME}/.zshrc"
fi
