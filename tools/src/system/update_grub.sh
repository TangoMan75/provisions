#!/bin/bash

#/*
# * This file is part of TangoMan Bash Tools package.
# *
# * Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * TangoMan Bash Tools
# *
# * A set of tools for shell scripts
# *
# * @licence MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

## Updates GRUB on multiple patforms
function update_grub() {
    # Update grub config
    echo_primary 'Updating grub config...'
    if [ -x "$(command -v update-grub)" ]; then
        echo_info 'update-grub'
        update-grub

    elif [ -x "$(command -v grub-mkconfig)" ]; then
        echo_info 'grub-mkconfig -o /boot/grub/grub.cfg'
        grub-mkconfig -o /boot/grub/grub.cfg

    elif [ -x "$(command -v grub2-mkconfig)" ]; then
        if [ -x "$(command -v zypper)" ]; then
            echo_info 'grub2-mkconfig -o /boot/grub2/grub.cfg'
            grub2-mkconfig -o /boot/grub2/grub.cfg

        elif [ -x "$(command -v dnf)" ]; then
            echo_info 'grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg'
            grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
        fi
    fi
}
