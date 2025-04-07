#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Visual Studio Code Extensions
##
## @category ide
## @link     https://code.visualstudio.com/download

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Visual Studio Code Extensions'

if [ ! -x "$(command -v code)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires vscode to install, try: 'sudo snap install code --classic'\n"
    exit 1
fi

#--------------------------------------------------
# PHP
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=junstyle.php-cs-fixer
# echo_info 'code --install-extension junstyle.php-cs-fixer\n'
# code --install-extension junstyle.php-cs-fixer

# # https://marketplace.visualstudio.com/items?itemName=kokororin.vscode-phpfmt
# echo_info 'code --install-extension kokororin.vscode-phpfmt\n'
# code --install-extension kokororin.vscode-phpfmt

# # https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense
# echo_info 'code --install-extension christian-kohler.path-intellisense\n'
# code --install-extension christian-kohler.path-intellisense

# # https://marketplace.visualstudio.com/items?itemName=zobo.php-intellisense
# echo_info 'code --install-extension zobo.php-intellisense\n'
# code --install-extension zobo.php-intellisense

# # https://marketplace.visualstudio.com/items?itemName=rifi2k.format-html-in-php
# echo_info 'code --install-extension rifi2k.format-html-in-php\n'
# code --install-extension rifi2k.format-html-in-php

# # https://marketplace.visualstudio.com/items?itemName=valeryanm.vscode-phpsab
# echo_info 'code --install-extension valeryanm.vscode-phpsab\n'
# code --install-extension valeryanm.vscode-phpsab

# # https://marketplace.visualstudio.com/items?itemName=nivin-studio.phalcon-goto-view
# echo_info 'code --install-extension nivin-studio.phalcon-goto-view\n'
# code --install-extension nivin-studio.phalcon-goto-view

# https://marketplace.visualstudio.com/items?itemName=neilbrayfield.php-docblocker
echo_info 'code --install-extension neilbrayfield.php-docblocker'
code --install-extension neilbrayfield.php-docblocker

# https://marketplace.visualstudio.com/items?itemName=muath-ye.composer-Intelephense
echo_info 'code --install-extension muath-ye.composer-Intelephense'
code --install-extension muath-ye.composer-Intelephense

# https://marketplace.visualstudio.com/items?itemName=marabesi.php-import-checker
echo_info 'code --install-extension marabesi.php-import-checker'
code --install-extension marabesi.php-import-checker

# https://marketplace.visualstudio.com/items?itemName=MehediDracula.php-constructor
echo_info 'code --install-extension MehediDracula.php-constructor'
code --install-extension MehediDracula.php-constructor

# https://marketplace.visualstudio.com/items?itemName=MehediDracula.php-namespace-resolver
echo_info 'code --install-extension MehediDracula.php-namespace-resolver'
code --install-extension MehediDracula.php-namespace-resolver

# https://marketplace.visualstudio.com/items?itemName=bmewburn.vscode-intelephense-client
echo_info 'code --install-extension bmewburn.vscode-intelephense-client'
code --install-extension bmewburn.vscode-intelephense-client

# https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug
echo_info 'code --install-extension xdebug.php-debug'
code --install-extension xdebug.php-debug

# https://marketplace.visualstudio.com/items?itemName=xdebug.php-pack
echo_info 'code --install-extension xdebug.php-pack'
code --install-extension xdebug.php-pack



#--------------------------------------------------
# Markdown
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid
# echo_info 'code --install-extension bierner.markdown-mermaid\n'
# code --install-extension bierner.markdown-mermaid

# # https://marketplace.visualstudio.com/items?itemName=bpruitt-goddard.mermaid-markdown-syntax-highlighting
# echo_info 'code --install-extension bpruitt-goddard.mermaid-markdown-syntax-highlighting\n'
# code --install-extension bpruitt-goddard.mermaid-markdown-syntax-highlighting

#--------------------------------------------------
# Obsidian
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=GeoffreyOlsonJr.obsidian-navigation
# echo_info 'code --install-extension GeoffreyOlsonJr.obsidian-navigation\n'
# code --install-extension GeoffreyOlsonJr.obsidian-navigation

# # https://marketplace.visualstudio.com/items?itemName=khuongduy354.obsidian-visualizer
# echo_info 'code --install-extension khuongduy354.obsidian-visualizer\n'
# code --install-extension khuongduy354.obsidian-visualizer

# # https://marketplace.visualstudio.com/items?itemName=willasm.obsidian-md-vsc
# echo_info 'code --install-extension willasm.obsidian-md-vsc\n'
# code --install-extension willasm.obsidian-md-vsc

#--------------------------------------------------
# Makefile
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=ms-vscode.makefile-tools
# echo_info 'code --install-extension ms-vscode.makefile-tools\n'
# code --install-extension ms-vscode.makefile-tools

#--------------------------------------------------
# AI
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=GitHub.copilot
# echo_info 'code --install-extension GitHub.copilot\n'
# code --install-extension GitHub.copilot

#--------------------------------------------------
# Git
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens
# echo_info 'code --install-extension eamodio.gitlens\n'
# code --install-extension eamodio.gitlens

# # https://marketplace.visualstudio.com/items?itemName=waderyan.gitblame
# echo_info 'code --install-extension waderyan.gitblame\n'
# code --install-extension waderyan.gitblame

# # https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner
# echo_info 'code --install-extension formulahendry.code-runner\n'
# code --install-extension formulahendry.code-runner

#--------------------------------------------------
# Browser Live
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=ms-vsliveshare.vsliveshare
# echo_info 'code --install-extension ms-vsliveshare.vsliveshare\n'
# code --install-extension ms-vsliveshare.vsliveshare

# https://marketplace.visualstudio.com/items?itemName=ms-vscode.live-server
echo_info 'code --install-extension ms-vscode.live-server'
code --install-extension ms-vscode.live-server

#--------------------------------------------------
# Database
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=ms-ossdata.vscode-postgresql
# echo_info 'code --install-extension ms-ossdata.vscode-postgresql\n'
# code --install-extension ms-ossdata.vscode-postgresql

# https://marketplace.visualstudio.com/items?itemName=lea21st.vscode-sql-formatter
echo_info 'code --install-extension lea21st.vscode-sql-formatter'
code --install-extension lea21st.vscode-sql-formatter

# https://marketplace.visualstudio.com/items?itemName=AykutSarac.jsoncrack-vscode
echo_info 'code --install-extension AykutSarac.jsoncrack-vscode'
code --install-extension AykutSarac.jsoncrack-vscode

#--------------------------------------------------
# Utils
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode
# echo_info 'code --install-extension esbenp.prettier-vscode\n'
# code --install-extension esbenp.prettier-vscode

#--------------------------------------------------
# Text Utils
#--------------------------------------------------

# https://marketplace.visualstudio.com/items?itemName=ctf0.blank-line-organizer
echo_info 'code --install-extension ctf0.blank-line-organizer'
code --install-extension ctf0.blank-line-organizer

# https://marketplace.visualstudio.com/items?itemName=wmaurer.change-case
echo_info 'code --install-extension wmaurer.change-case'
code --install-extension wmaurer.change-case

# # https://marketplace.visualstudio.com/items?itemName=ZaikinDenis.vscode-enumerator
# echo_info 'code --install-extension ZaikinDenis.vscode-enumerator\n'
# code --install-extension ZaikinDenis.vscode-enumerator

# https://marketplace.visualstudio.com/items?itemName=jkjustjoshing.vscode-text-pastry
echo_info 'code --install-extension jkjustjoshing.vscode-text-pastry'
code --install-extension jkjustjoshing.vscode-text-pastry

#--------------------------------------------------
# Docker
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker
# echo_info 'code --install-extension ms-azuretools.vscode-docker\n'
# code --install-extension ms-azuretools.vscode-docker

# # https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers
# echo_info 'code --install-extension ms-vscode-remote.remote-containers\n'
# code --install-extension ms-vscode-remote.remote-containers

#--------------------------------------------------
# Spellchecker
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker
# echo_info 'code --install-extension streetsidesoftware.code-spell-checker\n'
# code --install-extension streetsidesoftware.code-spell-checker

# # https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker-french
# echo_info 'code --install-extension streetsidesoftware.code-spell-checker-french\n'
# code --install-extension streetsidesoftware.code-spell-checker-french

