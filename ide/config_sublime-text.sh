#!/bin/bash

#/**
# * config sublime text
# *
# * @category ide
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

CONFIG_DIR="${BASEDIR}/../config"

# config sublime text
echo_info "cp -Rfv ${CONFIG_DIR}/home/.config/sublime-text-3 ~/.config"
cp -Rfv ${CONFIG_DIR}/home/.config/sublime-text-3 ~/.config

# # open with sublime text
# echo_info "sudo cp -fv ${CONFIG_DIR}/home/.local/share/sublime_text.desktop ~/.local/share/applications/sublime_text.desktop"
# sudo cp -fv ${CONFIG_DIR}/home/.local/share/sublime_text.desktop ~/.local/share/applications/sublime_text.desktop

# echo_info "sudo chown -R $USER:$USER ~/.local/share/applications/sublime_text.desktop"
# sudo chown -R $USER:$USER ~/.local/share/applications/sublime_text.desktop

# echo_info "sudo chmod 744 -R ~/.local/share/applications/sublime_text.desktop"
# sudo chmod 744 -R ~/.local/share/applications/sublime_text.desktop

# # add open with sublime text in folders context menu
# cat > ~/.local/share/nautilus/scripts/Open\ folder\ with\ Sublime\ Text <<EOL
# #!/bin/bash
# 
# subl $1
# exit 0
# EOL
# 
# echo_info 'chmod 755 ~/.local/share/nautilus/scripts/Open\ folder\ with\ Sublime\ Text'
# chmod 755 ~/.local/share/nautilus/scripts/Open\ folder\ with\ Sublime\ Text

# set sublime text as git default editor if installed
if [ -x /usr/bin/git ] ; then
    git config --global core.editor 'subl --wait'
fi
