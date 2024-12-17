#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * Visual Studio Code Extensions
# *
# * @category ide
# * @link     https://code.visualstudio.com/download
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Visual Studio Code Extensions'

if [ ! -x "$(command -v code)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires vscode to install, try: 'sudo snap install code --classic'\n"
    exit 1
fi

echo_info 'code --install-extension bmewburn.vscode-intelephense-client\n'
code --install-extension bmewburn.vscode-intelephense-client

# echo_info 'code --install-extension christian-kohler.path-intellisense\n'
# code --install-extension christian-kohler.path-intellisense

echo_info 'code --install-extension eamodio.gitlens\n'
code --install-extension eamodio.gitlens

# echo_info 'code --install-extension esbenp.prettier-vscode\n'
# code --install-extension esbenp.prettier-vscode

# echo_info 'code --install-extension fbclol.volt-phalcon-language\n'
# code --install-extension fbclol.volt-phalcon-language

# echo_info 'code --install-extension formulahendry.code-runner\n'
# code --install-extension formulahendry.code-runner

# echo_info 'code --install-extension junstyle.php-cs-fixer\n'
# code --install-extension junstyle.php-cs-fixer

# echo_info 'code --install-extension kokororin.vscode-phpfmt\n'
# code --install-extension kokororin.vscode-phpfmt

echo_info 'code --install-extension lea21st.vscode-sql-formatter\n'
code --install-extension lea21st.vscode-sql-formatter

echo_info 'code --install-extension marabesi.php-import-checker\n'
code --install-extension marabesi.php-import-checker

echo_info 'code --install-extension MehediDracula.php-constructor\n'
code --install-extension MehediDracula.php-constructor

echo_info 'code --install-extension MehediDracula.php-namespace-resolver\n'
code --install-extension MehediDracula.php-namespace-resolver

# echo_info 'code --install-extension ms-azuretools.vscode-docker\n'
# code --install-extension ms-azuretools.vscode-docker

echo_info 'code --install-extension ms-ossdata.vscode-postgresql\n'
code --install-extension ms-ossdata.vscode-postgresql

# echo_info 'code --install-extension ms-vscode-remote.remote-containers\n'
# code --install-extension ms-vscode-remote.remote-containers

echo_info 'code --install-extension ms-vscode.makefile-tools\n'
code --install-extension ms-vscode.makefile-tools

# echo_info 'code --install-extension ms-vsliveshare.vsliveshare\n'
# code --install-extension ms-vsliveshare.vsliveshare

echo_info 'code --install-extension muath-ye.composer-Intelephense\n'
code --install-extension muath-ye.composer-Intelephense

echo_info 'code --install-extension neilbrayfield.php-docblocker\n'
code --install-extension neilbrayfield.php-docblocker

# echo_info 'code --install-extension nivin-studio.phalcon-goto-view\n'
# code --install-extension nivin-studio.phalcon-goto-view

# echo_info 'code --install-extension rifi2k.format-html-in-php\n'
# code --install-extension rifi2k.format-html-in-php

echo_info 'code --install-extension sourcegraph.cody-ai\n'
code --install-extension sourcegraph.cody-ai

echo_info 'code --install-extension streetsidesoftware.code-spell-checker\n'
code --install-extension streetsidesoftware.code-spell-checker

# echo_info 'code --install-extension streetsidesoftware.code-spell-checker-french\n'
# code --install-extension streetsidesoftware.code-spell-checker-french

# echo_info 'code --install-extension valeryanm.vscode-phpsab\n'
# code --install-extension valeryanm.vscode-phpsab

echo_info 'code --install-extension waderyan.gitblame\n'
code --install-extension waderyan.gitblame

echo_info 'code --install-extension xdebug.php-debug\n'
code --install-extension xdebug.php-debug

echo_info 'code --install-extension xdebug.php-pack\n'
code --install-extension xdebug.php-pack

# echo_info 'code --install-extension zobo.php-intellisense\n'
# code --install-extension zobo.php-intellisense

