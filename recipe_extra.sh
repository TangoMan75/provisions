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
# * recipe extra
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./update.sh

./graphics/install_flameshot.sh
./graphics/install_gimp.sh
./graphics/install_inkscape.sh

./multimedia/install_obs-studio.sh

./productivity/install_dropbox.sh

./security/install_protonvpn.sh
./security/install_torbrowser.sh
# diodon: clipboard manager; I hate it. But some of you seem to like it, so...
./system/install_diodon.sh

./themes/install_bootloader_theme.sh

./clean.sh
