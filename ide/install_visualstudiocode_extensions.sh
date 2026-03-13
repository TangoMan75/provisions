#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
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

#--------------------------------------------------

_alert_primary 'Install Visual Studio Code Extensions'

if [ ! -x "$(command -v code)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires vscode to install, try: 'sudo snap install code --classic'\n"
    exit 1
fi

#--------------------------------------------------
# TangoMan75
# https://marketplace.visualstudio.com/publishers/TangoMan75
#--------------------------------------------------

# https://marketplace.visualstudio.com/items?itemName=TangoMan75.command-cycle
_echo_info 'code --install-extension TangoMan75.command-cycle\n\n'
code --install-extension TangoMan75.command-cycle

#--------------------------------------------------
# AI
#--------------------------------------------------

# https://marketplace.visualstudio.com/items?itemName=sst-dev.opencode
_echo_info 'code --install-extension sst-dev.opencode\n\n'
code --install-extension sst-dev.opencode

# # https://marketplace.visualstudio.com/items?itemName=Google.geminicodeassist
# _echo_info 'code --install-extension Google.geminicodeassist\n\n'
# code --install-extension Google.geminicodeassist

# https://marketplace.visualstudio.com/items?itemName=Google.gemini-cli-vscode-ide-companion
_echo_info 'code --install-extension Google.gemini-cli-vscode-ide-companion\n\n'
code --install-extension Google.gemini-cli-vscode-ide-companion

# # https://marketplace.visualstudio.com/items?itemName=GitHub.copilot
# _echo_info 'code --install-extension GitHub.copilot\n\n'
# code --install-extension GitHub.copilot

#--------------------------------------------------
# Browser Live
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=ms-vsliveshare.vsliveshare
# _echo_info 'code --install-extension ms-vsliveshare.vsliveshare\n\n'
# code --install-extension ms-vsliveshare.vsliveshare

# https://marketplace.visualstudio.com/items?itemName=ms-vscode.live-server
_echo_info 'code --install-extension ms-vscode.live-server\n'
code --install-extension ms-vscode.live-server

#--------------------------------------------------
# Database
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=ms-ossdata.vscode-postgresql
# _echo_info 'code --install-extension ms-ossdata.vscode-postgresql\n\n'
# code --install-extension ms-ossdata.vscode-postgresql

# https://marketplace.visualstudio.com/items?itemName=lea21st.vscode-sql-formatter
_echo_info 'code --install-extension lea21st.vscode-sql-formatter\n'
code --install-extension lea21st.vscode-sql-formatter

# https://marketplace.visualstudio.com/items?itemName=AykutSarac.jsoncrack-vscode
_echo_info 'code --install-extension AykutSarac.jsoncrack-vscode\n'
code --install-extension AykutSarac.jsoncrack-vscode

#--------------------------------------------------
# Docker
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker
# _echo_info 'code --install-extension ms-azuretools.vscode-docker\n\n'
# code --install-extension ms-azuretools.vscode-docker

# # https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers
# _echo_info 'code --install-extension ms-vscode-remote.remote-containers\n\n'
# code --install-extension ms-vscode-remote.remote-containers

#--------------------------------------------------
# Git
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens
# _echo_info 'code --install-extension eamodio.gitlens\n\n'
# code --install-extension eamodio.gitlens

# # https://marketplace.visualstudio.com/items?itemName=waderyan.gitblame
# _echo_info 'code --install-extension waderyan.gitblame\n\n'
# code --install-extension waderyan.gitblame

# # https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner
# _echo_info 'code --install-extension formulahendry.code-runner\n\n'
# code --install-extension formulahendry.code-runner

#--------------------------------------------------
# Makefile
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=ms-vscode.makefile-tools
# _echo_info 'code --install-extension ms-vscode.makefile-tools\n\n'
# code --install-extension ms-vscode.makefile-tools

#--------------------------------------------------
# Markdown
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint
# _echo_info 'code --install-extension DavidAnson.vscode-markdownlint\n\n'
# code --install-extension DavidAnson.vscode-markdownlint

# # https://marketplace.visualstudio.com/items?itemName=zhyong10.markdown-html
# _echo_info 'code --install-extension zhyong10.markdown-html\n\n'
# code --install-extension zhyong10.markdown-html

# # https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid
# _echo_info 'code --install-extension bierner.markdown-mermaid\n\n'
# code --install-extension bierner.markdown-mermaid

# # https://marketplace.visualstudio.com/items?itemName=bpruitt-goddard.mermaid-markdown-syntax-highlighting
# _echo_info 'code --install-extension bpruitt-goddard.mermaid-markdown-syntax-highlighting\n\n'
# code --install-extension bpruitt-goddard.mermaid-markdown-syntax-highlighting

# # https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint
# _echo_info 'code --install-extension DavidAnson.vscode-markdownlint\n\n'
# code --install-extension DavidAnson.vscode-markdownlint

# # https://marketplace.visualstudio.com/items?itemName=eliostruyf.vscode-front-matter
# _echo_info 'code --install-extension eliostruyf.vscode-front-matter\n\n'
# code --install-extension eliostruyf.vscode-front-matter

#--------------------------------------------------
# Obsidian
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=GeoffreyOlsonJr.obsidian-navigation
# _echo_info 'code --install-extension GeoffreyOlsonJr.obsidian-navigation\n\n'
# code --install-extension GeoffreyOlsonJr.obsidian-navigation

# # https://marketplace.visualstudio.com/items?itemName=khuongduy354.obsidian-visualizer
# _echo_info 'code --install-extension khuongduy354.obsidian-visualizer\n\n'
# code --install-extension khuongduy354.obsidian-visualizer

# # https://marketplace.visualstudio.com/items?itemName=willasm.obsidian-md-vsc
# _echo_info 'code --install-extension willasm.obsidian-md-vsc\n\n'
# code --install-extension willasm.obsidian-md-vsc

#--------------------------------------------------
# PHP
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=junstyle.php-cs-fixer
# _echo_info 'code --install-extension junstyle.php-cs-fixer\n\n'
# code --install-extension junstyle.php-cs-fixer

# # https://marketplace.visualstudio.com/items?itemName=kokororin.vscode-phpfmt
# _echo_info 'code --install-extension kokororin.vscode-phpfmt\n\n'
# code --install-extension kokororin.vscode-phpfmt

# # https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense
# _echo_info 'code --install-extension christian-kohler.path-intellisense\n\n'
# code --install-extension christian-kohler.path-intellisense

# # https://marketplace.visualstudio.com/items?itemName=zobo.php-intellisense
# _echo_info 'code --install-extension zobo.php-intellisense\n\n'
# code --install-extension zobo.php-intellisense

# # https://marketplace.visualstudio.com/items?itemName=rifi2k.format-html-in-php
# _echo_info 'code --install-extension rifi2k.format-html-in-php\n\n'
# code --install-extension rifi2k.format-html-in-php

# # https://marketplace.visualstudio.com/items?itemName=valeryanm.vscode-phpsab
# _echo_info 'code --install-extension valeryanm.vscode-phpsab\n\n'
# code --install-extension valeryanm.vscode-phpsab

# # https://marketplace.visualstudio.com/items?itemName=nivin-studio.phalcon-goto-view
# _echo_info 'code --install-extension nivin-studio.phalcon-goto-view\n\n'
# code --install-extension nivin-studio.phalcon-goto-view

# https://marketplace.visualstudio.com/items?itemName=neilbrayfield.php-docblocker
_echo_info 'code --install-extension neilbrayfield.php-docblocker\n'
code --install-extension neilbrayfield.php-docblocker

# https://marketplace.visualstudio.com/items?itemName=muath-ye.composer-Intelephense
_echo_info 'code --install-extension muath-ye.composer-Intelephense\n'
code --install-extension muath-ye.composer-Intelephense

# https://marketplace.visualstudio.com/items?itemName=marabesi.php-import-checker
_echo_info 'code --install-extension marabesi.php-import-checker\n'
code --install-extension marabesi.php-import-checker

# https://marketplace.visualstudio.com/items?itemName=MehediDracula.php-constructor
_echo_info 'code --install-extension MehediDracula.php-constructor\n'
code --install-extension MehediDracula.php-constructor

# https://marketplace.visualstudio.com/items?itemName=MehediDracula.php-namespace-resolver
_echo_info 'code --install-extension MehediDracula.php-namespace-resolver\n'
code --install-extension MehediDracula.php-namespace-resolver

# https://marketplace.visualstudio.com/items?itemName=bmewburn.vscode-intelephense-client
_echo_info 'code --install-extension bmewburn.vscode-intelephense-client\n'
code --install-extension bmewburn.vscode-intelephense-client

# https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug
_echo_info 'code --install-extension xdebug.php-debug\n'
code --install-extension xdebug.php-debug

# https://marketplace.visualstudio.com/items?itemName=xdebug.php-pack
_echo_info 'code --install-extension xdebug.php-pack\n'
code --install-extension xdebug.php-pack

#--------------------------------------------------
# Spellchecker
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker
# _echo_info 'code --install-extension streetsidesoftware.code-spell-checker\n\n'
# code --install-extension streetsidesoftware.code-spell-checker

# # https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker-french
# _echo_info 'code --install-extension streetsidesoftware.code-spell-checker-french\n\n'
# code --install-extension streetsidesoftware.code-spell-checker-french

#--------------------------------------------------
# Symfony
#--------------------------------------------------

# https://marketplace.visualstudio.com/items?itemName=TheNouillet.symfony-vscode
_echo_info 'code --install-extension TheNouillet.symfony-vscode\n'
code --install-extension TheNouillet.symfony-vscode

# https://marketplace.visualstudio.com/items?itemName=mblode.twig-language-2
_echo_info 'code --install-extension mblode.twig-language-2\n'
code --install-extension mblode.twig-language-2

#--------------------------------------------------
# Text Utils
#--------------------------------------------------

# https://marketplace.visualstudio.com/items?itemName=ctf0.blank-line-organizer
_echo_info 'code --install-extension ctf0.blank-line-organizer\n'
code --install-extension ctf0.blank-line-organizer

# https://marketplace.visualstudio.com/items?itemName=wmaurer.change-case
_echo_info 'code --install-extension wmaurer.change-case\n'
code --install-extension wmaurer.change-case

# # https://marketplace.visualstudio.com/items?itemName=ZaikinDenis.vscode-enumerator
# _echo_info 'code --install-extension ZaikinDenis.vscode-enumerator\n\n'
# code --install-extension ZaikinDenis.vscode-enumerator

# https://marketplace.visualstudio.com/items?itemName=jkjustjoshing.vscode-text-pastry
_echo_info 'code --install-extension jkjustjoshing.vscode-text-pastry\n'
code --install-extension jkjustjoshing.vscode-text-pastry

#--------------------------------------------------
# Utils
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode
# _echo_info 'code --install-extension esbenp.prettier-vscode\n\n'
# code --install-extension esbenp.prettier-vscode

#--------------------------------------------------
# Vue
#--------------------------------------------------

# # https://marketplace.visualstudio.com/items?itemName=Vue.volar
# _echo_info 'code --install-extension Vue.volar\n\n'
# code --install-extension Vue.volar

