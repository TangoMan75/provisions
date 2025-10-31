#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## fabric
##
## Configuration:
## ```
## ~/.config/fabric
## ```
##
## @category ai
## @link     https://github.com/danielmiessler/fabric

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PROJECT=fabric
AUTHOR=danielmiessler
REPOSITORY=${AUTHOR}/${PROJECT}
REMOTE_FILE=fabric_Linux_x86_64.tar.gz
BINARY="${PROJECT}"
DESTINATION=/usr/bin
URL="https://github.com/${REPOSITORY}/releases/latest/download/${REMOTE_FILE}"
ARCHIVE="${REMOTE_FILE}"

#--------------------------------------------------

alert_primary "Install ${PROJECT}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    echo_info "curl -L \"${URL}\" -o \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    curl -L "${URL}" -o "${TEMP_DIR}/${REMOTE_FILE}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    echo_info "wget -nv \"${URL}\" -O \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    wget -nv "${URL}" -O "${TEMP_DIR}/${REMOTE_FILE}"

else
    echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

echo_warning 'Extract files\n'

# Extract file based on its extension
#
# ${ARCHIVE##*.} : This is a parameter expansion expression
#             ## : Removes the shortest pattern that matches the entire string from the end of the value
#              * : Matches zero or more characters
#              . : Matches a literal dot (.)
case "${ARCHIVE##*.}" in
    gz)
        # extract with tar
        # -x, --extract
        # -v, --verbose
        # -z, --gzip, --gunzip --ungzip
        # -f, --file [ARCHIVE]
        # -C, --directory [DIR] : destination directory
        echo_info "tar -xvzf \"${TEMP_DIR}/${ARCHIVE}\" -C \"${TEMP_DIR}\"\n"
        tar -xvzf "${TEMP_DIR}/${ARCHIVE}" -C "${TEMP_DIR}"
        ;;
    zip)
        echo_info "unzip \"${TEMP_DIR}/${ARCHIVE}\" -d \"${TEMP_DIR}\"\n"
        unzip "${TEMP_DIR}/${ARCHIVE}" -d "${TEMP_DIR}"
        ;;
    *)
        echo_danger "error: Unsupported archive format \"${ARCHIVE##*.}\".\n"
        exit 1
        ;;
esac

#--------------------------------------------------

if [ ! -d "${DESTINATION}" ]; then
    echo_warning 'Create destination folder\n'

    echo_info "mkdir -p \"${DESTINATION}\"\n"
    mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

echo_warning 'Move binary to destination\n'

echo_info "sudo mv \"${TEMP_DIR}/${BINARY}\" \"${DESTINATION}\"\n"
sudo mv "${TEMP_DIR}/${BINARY}" "${DESTINATION}"

#--------------------------------------------------

echo_warning 'Cleaning up temporary files\n'

echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

echo_warning 'Set executable permissions\n'

echo_info "sudo chmod uga+x \"${DESTINATION}/${BINARY}\"\n"
sudo chmod uga+x "${DESTINATION}/${BINARY}"

#--------------------------------------------------

echo_warning 'update system\n'

echo_info 'sync\n'
sync

#--------------------------------------------------

# Check PATH and provide instructions
if ! echo "${PATH}" | grep -q "${DESTINATION}"; then
    echo_warning "${DESTINATION} is not in your PATH\n"
    echo_info "To use ${APP_NAME} from anywhere, add the following to your shell profile:\n\n"
    echo_warning "  export PATH=\"\$PATH:${DESTINATION}\"\n\n"
    echo_info 'For bash, add it to ~/.bashrc or ~/.bash_profile\n'
    echo_info 'For zsh, add it to ~/.zshrc\n'
    echo_info "For fish, run: fish_add_path ${DESTINATION}\n"
fi

#--------------------------------------------------

echo_warning 'Run the setup to set up your directories and keys\n'
echo_warning 'fabric --setup\n'

