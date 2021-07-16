#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * recipe pwd required
# *
# * independant recipe: will require user interaction
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./update.sh
./upgrade.sh

# network
./network/install_x11vnc.sh

# system
./system/install_zsh.sh

./fonts/install_fonts-powerline.sh

./themes/install_ohmyzsh.sh

./themes/install_tangoman-theme.sh

./system/install_bash_aliases.sh

./system/config_zsh.sh

./clean.sh

