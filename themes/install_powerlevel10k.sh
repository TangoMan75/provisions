#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Install powerlevel10k
##
## powerlevel10k theme for oh-my-zsh terminal
##
## Open Terminal → Preferences and click on the selected profile under Profiles.
## Check Custom font under Text Appearance and select MesloLGS Nerd Font
##
## ```
## p10k configure
## ```
##
## @category themes
## @license  MIT
## @link     https://github.com/romkatv/powerlevel10k
## @link     https://www.linuxfordevices.com/tutorials/linux/make-arch-terminal-awesome

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

THEME_NAME=powerlevel10k\\/powerlevel10k
CONFIG_DIR="${CURDIR}/../config"

#--------------------------------------------------

# check zsh installed
if [ ! -x "$(command -v zsh)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires zsh, try: 'sudo apt-get install -y zsh'\n"
    exit 1
fi

# check oh-my-zsh installed
if [ ! -d ~/.oh-my-zsh ]; then
    echo_danger 'error: oh-my-zsh not installed'
    exit 1
fi

# check .zshrc present
if [ ! -f ~/.zshrc ]; then
    echo_danger 'error: .zshrc file not found'
    exit 1
fi

#--------------------------------------------------

alert_primary 'Install powerlevel10k'

#--------------------------------------------------

echo_info "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \"${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k\"\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo_info "sed -i -E s/ZSH_THEME=\".+\"/ZSH_THEME=\"${THEME_NAME}\"/g ~/.zshrc\n"
sed -i -E s/ZSH_THEME=\".+\"/ZSH_THEME=\"${THEME_NAME}\"/g ~/.zshrc

#--------------------------------------------------

# config p10k
echo_info "cp -fv \"${CONFIG_DIR}/home/.p10k.zsh\" ~\n"
cp -fv "${CONFIG_DIR}/home/.p10k.zsh" ~

#--------------------------------------------------

# remove previous config if any
echo_info "sed -i '/# To customize prompt, run \`p10k configure\` or edit ~\/.p10k.zsh./d' ~/.zshrc\n"
# shellcheck disable=SC2016
sed -i '/# To customize prompt, run `p10k configure` or edit ~\/.p10k.zsh./d' ~/.zshrc

echo_info "sed -i '/[[ ! -f ~\/.p10k.zsh ]] || source ~\/.p10k.zsh/d' ~/.zshrc\n"
# shellcheck disable=SC2016
sed -i '/[[ ! -f ~\/.p10k.zsh ]] || source ~\/.p10k.zsh/d' ~/.zshrc

# append config to "~/.zshrc"
# shellcheck disable=SC2016
echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' >> ~/.zshrc
# shellcheck disable=SC2016
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

#--------------------------------------------------

echo_success "${THEME_NAME} theme set successfully"
echo_info 'You may need to restart your session\n'
