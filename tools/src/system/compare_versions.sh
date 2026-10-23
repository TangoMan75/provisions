#!/bin/bash

#/*
## This file is part of TangoMan Bash Tools package.
##
## Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## TangoMan Bash Tools
##
## A set of tools for shell scripts
##
## @licence MIT
## @author  "Matthias Morin" <mat@tangoman.io>

## Compare two semantic versions
compare_versions() {
    local INPUT

    for INPUT in "$1" "$2"; do
        if [[ ! "${INPUT}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            echo -ne "\033[1;31merror:\t\033[0;31minvalid version (${INPUT})\033[0m\n"
            return 1
        fi
    done

    local VERSION_1=()
    local VERSION_2=()

    # # split each version string with dot character (option 1, not zsh compliant)
    # BKP=${IFS}
    # IFS='.'
    # read -r -a VERSION_1 <<< "$1"
    # read -r -a VERSION_2 <<< "$2"
    # IFS=${BKP}

    # # zsh handles arrays in a weird fashion (option 2, not bash compliant)
    # VERSION_1=("${(@s/./)1}")
    # VERSION_2=("${(@s/./)2}")

    # # split each version string with dot character (option 3, non working option)
    # BKP="${IFS}"
    # IFS="."
    # while read -r ITEM; do VERSION_1+=("${ITEM}"); done < <(echo "$1")
    # while read -r ITEM; do VERSION_2+=("${ITEM}"); done < <(echo "$2")
    # IFS="${BKP}"

    # split each version string with dot character (option 4, short syntax but not shellcheck valid)
    # shellcheck disable=2207
    VERSION_1=($(echo "$1" | tr '.' ' '))
    # shellcheck disable=2207
    VERSION_2=($(echo "$2" | tr '.' ' '))

    # compare each number
    for KEY in {0..2}; do
        if [ "${VERSION_1[$KEY]}" -eq "${VERSION_2[$KEY]}" ]; then
            continue
        fi
        if [ "${VERSION_1[$KEY]}" -gt "${VERSION_2[$KEY]}" ]; then
            echo '>'
            return 0
        elif [ "${VERSION_1[$KEY]}" -lt "${VERSION_2[$KEY]}" ]; then
            echo '<'
            return 0
        fi
    done

    echo '='
    return 0
}