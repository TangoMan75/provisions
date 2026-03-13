#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install pandoc
##
## convert html to pdf
##
## ```
## pandoc index.html --to pdf --output index.pdf
##
## # --standalone : Produce  output  with  an appropriate header and footer
## pandoc README.md --from gfm --to html --standalone --output index.html
##
## pandoc README.md --to pdf --output readme.pdf
## ```
##
## Some supported formats :
##
## - commonmark (CommonMark Markdown)
## - commonmark_x (CommonMark Markdown with extensions)
## - csv (CSV table)
## - tsv (TSV table)
## - docx (Word docx)
## - gfm (GitHub-Flavored Markdown), or the deprecated and less accurate markdown_github; use markdown_github only if you need extensions not supported in gfm.
## - html (HTML)
## - ipynb (Jupyter notebook)
## - jira (Jira/Confluence wiki markup)
## - json (JSON version of native AST)
## - latex (LaTeX)
## - markdown_mmd (MultiMarkdown)
## - markdown_phpextra (PHP Markdown Extra)
## - markdown_strict (original unextended Markdown)
## - odt (ODT)
## - pdf (PDF)
## - rtf (Rich Text Format)
##
## @category productivity

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install Pandoc'

_echo_info 'sudo apt-get install --assume-yes pandoc\n'
sudo apt-get install --assume-yes pandoc

_echo_info 'sudo apt-get install --assume-yes texlive-latex-recommended\n'
sudo apt-get install --assume-yes texlive-latex-recommended

