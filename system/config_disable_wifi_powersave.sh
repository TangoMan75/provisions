#!/bin/bash
set -e

#/*
# * This script is based on TangoMan Shoe Shell Microframework version 0.8.0-xxs
# *
# * This file is distributed under to the MIT license.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
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
# * Configure Disable Wifi Powersave
# *
# * @category system
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @version 0.8.0-xxs
# * @link    https://unix.stackexchange.com/questions/269661/how-to-turn-off-wireless-power-management-permanently
# */

#--------------------------------------------------
# Place your constants after this line
#--------------------------------------------------

## Disable all
disable_all() {
    disable_conf
    disable_pcie
}

## Enable all
enable_all() {
    enable_conf
    enable_pcie
}

## Print current wifi config
status() {
    echo_info 'iwconfig'
    iwconfig
}

## Disable power management with nmcli (temporary)
disable_nmcli() {
    # Check nmcli installation
    if [ ! -x "$(command -v nmcli)" ]; then
        echo_error "\"$(basename "${0}")\" requires nmcli, try: 'sudo apt-get install -y nmcli'\n"
        return 1
    fi

    device="$(nmcli connection show --active | grep -m1 wifi | awk '{print $NF}')"
    if [ -z "${device}" ]; then
        echo_error 'no network connection found.\n'
        return 1
    fi

    echo_info "sudo iwconfig \"${device}\" power off"
    sudo iwconfig "${device}" power off
}

## Disable power management from "NetworkManager/conf.d" (permanent)
disable_conf() {
    echo_info "sudo sed -i -E '/wifi.powersave =/s/[0-9]+/2/' /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf\n"
    sudo sed -i -E '/wifi.powersave =/s/[0-9]+/2/' /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
}

## Re-enable power management from "NetworkManager/conf.d"
enable_conf() {
    echo_info "sudo sed -i -E '/wifi.powersave =/s/[0-9]+/3/' /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf\n"
    sudo sed -i -E '/wifi.powersave =/s/[0-9]+/3/' /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
}

## Disable PCIe Active State Power from grub
disable_pcie() {
    # pcie_aspm=      [PCIE] Forcibly enable or disable PCIe Active State Power
    #                 Management.
    #         off     Disable ASPM.
    #         force   Enable ASPM even on devices that claim not to support it.
    #                 WARNING: Forcing ASPM on may cause system lockups.

    echo_success 'Disable PCIe Active State Power\n'
    # remove default grub style if any
    echo_info "sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/d' /etc/default/grub\n"
    sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/d' /etc/default/grub

    echo_info "sudo bash -c \"echo 'GRUB_CMDLINE_LINUX_DEFAULT=\"pcie_aspm=off\"' >> /etc/default/grub\"\n"
    sudo bash -c "echo 'GRUB_CMDLINE_LINUX_DEFAULT=\"pcie_aspm=off\"' >> /etc/default/grub"

    update_grub
}

## Enable PCIe Active State Power from grub
enable_pcie() {
    # pcie_aspm=      [PCIE] Forcibly enable or disable PCIe Active State Power
    #                 Management.
    #         off     Disable ASPM.
    #         force   Enable ASPM even on devices that claim not to support it.
    #                 WARNING: Forcing ASPM on may cause system lockups.

    echo_success 'Disable PCIe Active State Power\n'
    # remove default grub style if any
    echo_info "sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/d' /etc/default/grub\n"
    sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/d' /etc/default/grub

    echo_info "sudo bash -c \"echo 'GRUB_CMDLINE_LINUX_DEFAULT=\"\"' >> /etc/default/grub\"\n"
    sudo bash -c "echo 'GRUB_CMDLINE_LINUX_DEFAULT=\"\"' >> /etc/default/grub"

    update_grub
}

update_grub() {
    # Update grub config
    echo_success 'Updating grub config...\n'
    if [[ -x "$(command -v update-grub)" ]]; then
        echo_info 'sudo update-grub\n'
        sudo update-grub

    elif [[ -x "$(command -v grub-mkconfig)" ]]; then
        echo_info 'sudo grub-mkconfig -o /boot/grub/grub.cfg\n'
        sudo grub-mkconfig -o /boot/grub/grub.cfg

    elif [[ -x "$(command -v grub2-mkconfig)" ]]; then
        if [[ -x "$(command -v zypper)" ]]; then
            echo_info 'sudo grub2-mkconfig -o /boot/grub2/grub.cfg\n'
            sudo grub2-mkconfig -o /boot/grub2/grub.cfg

        elif [[ -x "$(command -v dnf)" ]]; then
            echo_info 'sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg\n'
            sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
        fi
    fi
}

#--------------------------------------------------
# Semantic colors set
#--------------------------------------------------

# shellcheck disable=SC2034
{
    PRIMARY='\033[97m'; SECONDARY='\033[94m'; SUCCESS='\033[32m'; DANGER='\033[31m'; WARNING='\033[33m'; INFO='\033[95m'; LIGHT='\033[47;90m'; DARK='\033[40;37m'; DEFAULT='\033[0m'; EOL='\033[0m\n';
    ALERT_PRIMARY='\033[1;104;97m'; ALERT_SECONDARY='\033[1;45;97m'; ALERT_SUCCESS='\033[1;42;97m'; ALERT_DANGER='\033[1;41;97m'; ALERT_WARNING='\033[1;43;97m'; ALERT_INFO='\033[1;44;97m'; ALERT_LIGHT='\033[1;47;90m'; ALERT_DARK='\033[1;40;37m';
}

echo_primary()   { printf "%b%b${DEFAULT}" "${PRIMARY}"   "${*}"; }
echo_secondary() { printf "%b%b${DEFAULT}" "${SECONDARY}" "${*}"; }
echo_success()   { printf "%b%b${DEFAULT}" "${SUCCESS}"   "${*}"; }
echo_danger()    { printf "%b%b${DEFAULT}" "${DANGER}"    "${*}"; }
echo_warning()   { printf "%b%b${DEFAULT}" "${WARNING}"   "${*}"; }
echo_info()      { printf "%b%b${DEFAULT}" "${INFO}"      "${*}"; }
echo_light()     { printf "%b%b${DEFAULT}" "${LIGHT}"     "${*}"; }
echo_dark()      { printf "%b%b${DEFAULT}" "${DARK}"      "${*}"; }

echo_label()     { if [ $# -eq 2 ]; then printf "%b%-${1}s ${DEFAULT}" "${SUCCESS}" "$2"; else printf "%b%b ${DEFAULT}" "${SUCCESS}" "${*}"; fi }
echo_error()     { printf "%berror: %b${DEFAULT}" "${DANGER}"  "${*}"; }

alert_primary()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_PRIMARY}"   '' "${ALERT_PRIMARY}"   "${*}" "${ALERT_PRIMARY}"   ''; }
alert_secondary() { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_SECONDARY}" '' "${ALERT_SECONDARY}" "${*}" "${ALERT_SECONDARY}" ''; }
alert_success()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_SUCCESS}"   '' "${ALERT_SUCCESS}"   "${*}" "${ALERT_SUCCESS}"   ''; }
alert_danger()    { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_DANGER}"    '' "${ALERT_DANGER}"    "${*}" "${ALERT_DANGER}"    ''; }
alert_warning()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_WARNING}"   '' "${ALERT_WARNING}"   "${*}" "${ALERT_WARNING}"   ''; }
alert_info()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_INFO}"      '' "${ALERT_INFO}"      "${*}" "${ALERT_INFO}"      ''; }
alert_light()     { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_LIGHT}"     '' "${ALERT_LIGHT}"     "${*}" "${ALERT_LIGHT}"     ''; }
alert_dark()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_DARK}"      '' "${ALERT_DARK}"      "${*}" "${ALERT_DARK}"      ''; }

#--------------------------------------------------
# Self documentation
#--------------------------------------------------

### Help

## Print this help (default)
help() {
    alert_primary 'TangoMan Shoe XXS'
    echo_warning 'Infos:\n'
    echo_label 10 '  author';  echo_primary '"Matthias Morin" <mat@tangoman.io>\n'
    echo_label 10 '  version'; echo_primary '0.8.0-xxs\n'
    echo_label 10 '  link';    echo_primary 'https://github.com/TangoMan75/shoe\n\n'
    echo_warning 'Description:\n'
    echo_primary '  Create self documented shell scripts with argument validation easily. Prefix a comment with two pound signs on the previous line of any function or variable you want documented with the "help" command.\n\n' | fold -w 64 -s
    echo_warning 'Usage:\n'
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
