#!/bin/sh
set -e

#/*
# * This script is based on TangoMan Shoe Shell Microframework version 0.8.0-xxs
# *
# * This file is distributed under to the MIT license.
# *
# * Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
# *
# * Permission is hereby granted, free of charge, to any person obtaining a copy
# * of this software and associated documentation files (the "Software"), to deal
# * in the Software without restriction, including without limitation the rights
# * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# * copies of the Software, and to permit persons to whom the Software is
# * furnished to do so, subject to the following conditions:
# *
# * The above copyright notice and this permission notice shall be included in all
# * copies or substantial portions of the Software.
# *
# * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# * SOFTWARE.
# *
# * Source code is available here: https://github.com/TangoMan75/shoe
# */

#/**
# * Configure Dell Inspiron keyboard
# *
# * This bash script modifies the keyboard layout configuration file (/usr/share/X11/xkb/symbols/pc) 
# * to swap the functionality of the F11 and F12 keys with the Home and End keys, respectively.
# *
# * @category system
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @version 0.8.0-xxs
# * @link    https://github.com/TangoMan75/provisions
# * @link    https://help.ubuntu.com/community/Custom%20keyboard%20layout%20definitions
# */

#--------------------------------------------------
# Place your constants after this line
#--------------------------------------------------

CONFIG_DIR="${CURDIR}/../config"

#--------------------------------------------------

## Default
run() {
    insert_xkb_symbols
}

## Open
open() {
    _echo_info 'sudo subl /usr/share/X11/xkb/symbols/pc\n'
    sudo subl /usr/share/X11/xkb/symbols/pc
}

## Config by editing xkb symbols
insert_xkb_symbols() {
    backup_xkb_symbols
    RELEASE="$(lsb_release -cs)"
    if [ "${RELEASE}" = focal ]; then
        _insert_xkb_symbols_focal

    elif [ "${RELEASE}" = noble ]; then
        _insert_xkb_symbols_noble

    else
        _echo_danger "error: Cannot configure \"${RELEASE}\", invalid version\n"
        return 1
    fi
    clear_xkb_cache
}

## Config by editing xkb symbols
_insert_xkb_symbols_focal() {
    # remove previous configuration :
    # search for any line containing `key <FK11>` (for F11) and `key <FK12>` (for F12)
    # using regular expressions `/.*key <FK\d\d>.*/`.
    # If found, the d command deletes those lines.
    # This effectively removes any existing definitions for the F11 and F12 keys.

    _echo_info "sudo sed -i '/.*key <FK11>.*/d' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '/.*key <FK11>.*/d' /usr/share/X11/xkb/symbols/pc

    _echo_info "sudo sed -i '/.*key <FK12>.*/d' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '/.*key <FK12>.*/d' /usr/share/X11/xkb/symbols/pc

    # Insert configuration :
    # The `16i` part instructs `sed` to insert the following content at line 16 of the file.
    # (Line must be inserted after `include "keypad(x11)"`)
    # The inserted content defines new key mappings:
    # Line 3: <FK12> key now sends End keystroke.
    # Line 4: <FK11> key now sends Home keystroke.

    _echo_info "sudo sed -i '16i\    key <FK12>  {    [ End, End, End, End ]   };' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '16i\    key <FK12>  {    [ End, End, End, End ]   };' /usr/share/X11/xkb/symbols/pc

    _echo_info "sudo sed -i '16i\    key <FK11>  {    [ Home, Home, Home, Home ]   };' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '16i\    key <FK11>  {    [ Home, Home, Home, Home ]   };' /usr/share/X11/xkb/symbols/pc

    # remap the keys associated with "<HOME>" and "<END>"
    # to generate the F11 or F12 key press (based on the replacement string).

    _echo_info "sudo sed -i '/key <HOME>/s/\[.*\]/[ F11, F11, F11, F11 ]/' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '/key <HOME>/s/\[.*\]/[ F11, F11, F11, F11 ]/' /usr/share/X11/xkb/symbols/pc

    _echo_info "sudo sed -i '/key  <END>/s/\[.*\]/[ F12, F12, F12, F12 ]/' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '/key  <END>/s/\[.*\]/[ F12, F12, F12, F12 ]/' /usr/share/X11/xkb/symbols/pc
}

## Config by editing xkb symbols
_insert_xkb_symbols_noble() {
    # remove previous configuration :
    _echo_info "sudo sed -i '/.*key <FK11>.*/d' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '/.*key <FK11>.*/d' /usr/share/X11/xkb/symbols/pc

    _echo_info "sudo sed -i '/.*key <FK12>.*/d' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '/.*key <FK12>.*/d' /usr/share/X11/xkb/symbols/pc

    # Insert configuration :
    # The `75i` part instructs `sed` to insert the following content at line 75 of the file.
    # (Line must be inserted after `include "keypad(x11)"`)

    _echo_info "sudo sed -i '75i\    key <FK12> {[ End, End ]};' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '75i\    key <FK12> {[ End, End ]};' /usr/share/X11/xkb/symbols/pc

    _echo_info "sudo sed -i '75i\    key <FK11> {[ Home, Home ]};' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '75i\    key <FK11> {[ Home, Home ]};' /usr/share/X11/xkb/symbols/pc

    # remap the keys associated with "<HOME>" and "<END>"
    # to generate the F11 or F12 key press (based on the replacement string).

    _echo_info "sudo sed -i '/key <HOME>/s/\[.*\]/[  F11     ]/' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '/key <HOME>/s/\[.*\]/[  F11     ]/' /usr/share/X11/xkb/symbols/pc

    _echo_info "sudo sed -i '/key  <END>/s/\[.*\]/[  F12     ]/' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '/key  <END>/s/\[.*\]/[  F12     ]/' /usr/share/X11/xkb/symbols/pc

}

## Backup xkb symbols
backup_xkb_symbols() {
    CONFIG_DIR="$(dirname "$(realpath "$0")")/../config"
    SOURCE=/usr/share/X11/xkb/symbols
    DESTINATION=${CONFIG_DIR}${SOURCE}
    FILENAME="pc_$(lsb_release -cs | tail).bkp"

    if [ ! -f "${DESTINATION}/${FILENAME}" ]; then
        _echo_info "cp -f \"${SOURCE}/pc\" \"${DESTINATION}/${FILENAME}\"\n"
        cp -f "${SOURCE}/pc" "${DESTINATION}/${FILENAME}"
    fi
}

## Restore xkb symbols
restore_xkb_symbols() {
    CONFIG_DIR="$(dirname "$(realpath "$0")")/../config"
    SOURCE=/usr/share/X11/xkb/symbols
    DESTINATION=${CONFIG_DIR}${SOURCE}
    FILENAME="pc_$(lsb_release -cs | tail).bkp"

    if [ ! -f "${DESTINATION}/${FILENAME}" ]; then
        _echo_info "cp -f \"${DESTINATION}/${FILENAME}\" \"${SOURCE}/pc\"\n"
        cp -f "${DESTINATION}/${FILENAME}" "${SOURCE}/pc"
    fi

    clear_xkb_cache
}

## Clear xkb cache
clear_xkb_cache() {
    _echo_info 'sudo rm -rf /var/lib/xkb/*\n'
    sudo rm -rf /var/lib/xkb/*

    _echo_info 'sudo dpkg-reconfigure xkb-data\n'
    sudo dpkg-reconfigure xkb-data
}

## Config with xmodmap (not recommended)
config_xmodmap() {
    if [ ! -x "$(command -v xmodmap)" ]; then
        _echo_danger "error: \"$(basename "${0}")\" requires xmodmap, try: 'sudo apt-get install -y xmodmap'\n"
        return 1
    fi

_echo_info 'cat <<EOF | tee ~/.Xmodmap\n'
cat <<EOF | tee ~/.Xmodmap
keycode  95 = Home NoSymbol Home
keycode  96 = End NoSymbol End
keycode 110 = F11 XF86Switch_VT_11 F11
keycode 115 = F12 XF86Switch_VT_12 F12
EOF

    _echo_info 'xmodmap ~/.Xmodmap\n'
    xmodmap ~/.Xmodmap

    create_autostart
}

## Create autostart for xmodmap
create_autostart() {
    description='Config Dell Inspire Keyboard'
    name=xmodmap
    command="/usr/bin/xmodmap $HOME/.Xmodmap"

    _echo_info 'mkdir -p ~/.config/autostart/\n'
    mkdir -p ~/.config/autostart/

cat <<EOF | tee ~/.config/autostart/$name.desktop
[Desktop Entry]
Name=$name
Comment=$description
Exec=$command
Type=Application
Terminal=true
Hidden=false
EOF
}

## Remove xmodmap service
remove_service() {
    if [ -z "$1" ]; then
        set -- xmodmap
    fi

    _echo_info "systemctl --user stop \"$1.service\"\n"
    systemctl --user stop "$1.service"

    _echo_info "systemctl --user disable \"$1.service\"\n"
    systemctl --user disable "$1.service"

    _echo_info "sudo rm -f /etc/systemd/system/\"$1.service\"\n"
    sudo rm -f /etc/systemd/system/"$1.service"

    _echo_info "sudo rm -f ~/.config/systemd/user/\"$1.service\"\n"
    sudo rm -f ~/.config/systemd/user/"$1.service"
}

## Create xmodmap service
create_service() {
    # https://doc.ubuntu-fr.org/creer_un_service_avec_systemd
    description='Config Dell Inspire Keyboard'
    name=xmodmap
    command="/usr/bin/xmodmap $HOME/.Xmodmap"

_echo_info "cat <<EOF | sudo tee /etc/systemd/system/$name.service\n"
cat <<EOF | sudo tee /etc/systemd/system/$name.service
[Unit]
Description=$description
After=graphical.target

[Service]
ExecStart=$command
Type=oneshot
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

    _echo_info "systemctl enable $name.service\n"
    systemctl enable $name.service
}

## Create xmodmap user service
create_user_service() {
    description='Config Dell Inspire Keyboard'
    name=xmodmap
    command="/usr/bin/xmodmap $HOME/.Xmodmap"

_echo_info "cat <<EOF | tee ~/.config/systemd/user/$name.service\n"
cat <<EOF | tee ~/.config/systemd/user/$name.service
[Unit]
Description=$description
After=graphical.target

[Service]
ExecStart=$command
Type=oneshot
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

    _echo_info "systemctl --user enable $name.service\n"
    systemctl --user enable $name.service
}

## Show keymap
show_keymap() {
    if [ ! -x "$(command -v setxkbmap)" ]; then
        _echo_danger "error: \"$(basename "${0}")\" requires setxkbmap, try: 'sudo apt-get install -y setxkbmap'\n"
        return 1
    fi

    _echo_info 'setxkbmap -print\n'
    setxkbmap -print
}

## Show keboard events
show_keboard_events() {
    if [ ! -x "$(command -v xev)" ]; then
        _echo_danger "error: \"$(basename "${0}")\" requires xev, try: 'sudo apt-get install -y xev'\n"
        return 1
    fi

    _echo_info 'xev -event keyboard\n'
    xev -event keyboard
}

#--------------------------------------------------
# Colors global variables
#--------------------------------------------------

# shellcheck disable=SC2034
{
    PRIMARY='\033[97m'; SECONDARY='\033[94m'; SUCCESS='\033[32m'; DANGER='\033[31m'; WARNING='\033[33m'; INFO='\033[95m'; LIGHT='\033[47;90m'; DARK='\033[40;37m'; DEFAULT='\033[0m'; EOL='\033[0m\n';
    _alert_primary='\033[1;104;97m'; _alert_secondary='\033[1;45;97m'; _alert_success='\033[1;42;97m'; _alert_danger='\033[1;41;97m'; _alert_warning='\033[1;43;97m'; _alert_info='\033[1;44;97m'; _alert_light='\033[1;47;90m'; _alert_dark='\033[1;40;37m';
}

#--------------------------------------------------
# A semantic set of colors functions
#--------------------------------------------------

# Synopsys: echo_* [string] (indentation) (padding)
_echo_primary()   { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${PRIMARY}"    "$3" "$1" "${DEFAULT}"; }
_echo_secondary() { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${SECONDARY}"  "$3" "$1" "${DEFAULT}"; }
_echo_success()   { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${SUCCESS}"    "$3" "$1" "${DEFAULT}"; }
_echo_danger()    { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${DANGER}"     "$3" "$1" "${DEFAULT}"; }
_echo_warning()   { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${WARNING}"    "$3" "$1" "${DEFAULT}"; }
_echo_info()      { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${INFO}"       "$3" "$1" "${DEFAULT}"; }
_echo_light()     { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${LIGHT}"      "$3" "$1" "${DEFAULT}"; }
_echo_dark()      { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${DARK}"       "$3" "$1" "${DEFAULT}"; }

# Synopsys: alert_* [string]
_alert_primary()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_primary}"   '' "${_alert_primary}"   "$1" "${_alert_primary}"   ''; }
_alert_secondary() { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_secondary}" '' "${_alert_secondary}" "$1" "${_alert_secondary}" ''; }
_alert_success()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_success}"   '' "${_alert_success}"   "$1" "${_alert_success}"   ''; }
_alert_danger()    { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_danger}"    '' "${_alert_danger}"    "$1" "${_alert_danger}"    ''; }
_alert_warning()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_warning}"   '' "${_alert_warning}"   "$1" "${_alert_warning}"   ''; }
_alert_info()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_info}"      '' "${_alert_info}"      "$1" "${_alert_info}"      ''; }
_alert_light()     { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_light}"     '' "${_alert_light}"     "$1" "${_alert_light}"     ''; }
_alert_dark()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_dark}"      '' "${_alert_dark}"      "$1" "${_alert_dark}"      ''; }

#--------------------------------------------------
# Self documentation
#--------------------------------------------------

### Help

## Print this help (default)
help() {
    _alert_primary 'TangoMan Shoe XXS'
    _echo_warning 'Infos:\n'
    _echo_success 'author'  2 10; _echo_primary '"Matthias Morin" <mat@tangoman.io>\n'
    _echo_success 'version' 2 10; _echo_primary '0.8.0-xxs\n'
    _echo_success 'link'    2 10; _echo_primary 'https://github.com/TangoMan75/shoe\n'
    _echo_warning 'Description:\n'
    _echo_primary '  Create self documented shell scripts with argument validation easily. Prefix a comment with two pound signs on the previous line of any function or variable you want documented with the "help" command.\n\n' | fold -w 64 -s
    _echo_warning 'Usage:\n'
    printf "%b  sh $(basename "${0}") [%bcommand%b]\n\n" "${INFO}" "${SUCCESS}" "${INFO}"
    _print_commands 10
}

#--------------------------------------------------

_print_commands() {
    # $1 = padding
    if [ -z "$1" ]; then set -- 12; fi
    printf "%bCommands:%b\n" "${WARNING}" "${DEFAULT}"
    awk "/^### /{printf\"\n${WARNING}%s:${EOL}\",substr(\$0,5)}
        /^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub(\"^function \",\"\"); gsub(\"[ ()]\",\"\");
        FUNCTION = substr(\$0, 1, index(\$0, \"{\"));
        sub(\"{\$\", \"\", FUNCTION);
        if (substr(PREV, 1, 3) == \"## \" && substr(\$0, 1, 1) != \"_\")
        printf \"${SUCCESS}  %-$1s ${DEFAULT}%s\n\", FUNCTION, substr(PREV, 4)
    } { PREV = \$0 }" "$0"
    printf '\n'
}

#--------------------------------------------------
# Core
#--------------------------------------------------

_get_functions() {
    # this regular expression matches functions with either bash or sh syntax
    awk '/^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub("^function ",""); gsub("[ ()]","");   # remove leading "function ", round brackets and extra spaces
        FUNCTION = substr($0, 1, index($0, "{")); # truncate string after opening curly brace
        sub("{$", "", FUNCTION);                  # remove trailing curly brace
        if (substr(PREV, 1, 3) == "## " && substr($0, 1, 1) != "_") print FUNCTION
    } { PREV = $0 }' "$0"
}

#--------------------------------------------------
# Main loop
#--------------------------------------------------

_main() {
    if [ $# -lt 1 ]; then
        help
        exit 0
    fi

    _execute=''
    for _argument in "$@"; do
        _is_valid=false
        for _function in $(_get_functions); do
            # get shorthand character
            _shorthand="$(printf '%s' "${_function}" | awk '{$0=substr($0, 1, 1); print}')"
            if [ "${_argument}" = "${_function}" ] || [ "${_argument}" = "${_shorthand}" ]; then
                # append argument to the execute stack
                _execute="${_execute} ${_function}"
                _is_valid=true
                break
            fi
        done
        # unknown parameters will raise errors
        if [ "${_is_valid}" = false ]; then
            printf "${DANGER}error: \"%s\" is not a valid command${EOL}" "${_argument}"
            exit 1
        fi
    done

    for _function in ${_execute}; do
        eval "${_function}"
    done
}

_main "$@"
