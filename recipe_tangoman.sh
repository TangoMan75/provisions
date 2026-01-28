#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## recipe tangoman
##
## @license MIT
## @author  "Matthias Morin" <mat@tangoman.io>

./recipe_essentials.sh

./recipe_dev_essentials.sh -n

./recipe_dev_php.sh -n

./recipe_dev_javascript.sh -n

./recipe_dev_bash.sh -n

## Create desktop shortcuts

./recipe_desktop_shortcuts.sh

## Communication

# ferdium: communication tool
./communication/install_ferdium.sh

## productivity

./productivity/install_dropbox.sh

## Oh my zsh

./recipe_oh-my-zsh.sh -n
