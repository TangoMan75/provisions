#!/bin/bash

#/**
# * install server
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

## Initialise git submodules
if [ -f ./.gitmodules ] && [ ! -f ./tools/.git ]; then
    git submodule update --init --recursive
fi

./update.sh

./graphics/install_flameshot.sh
./graphics/install_inkscape.sh
./multimedia/install_obs-studio.sh

./clean.sh
