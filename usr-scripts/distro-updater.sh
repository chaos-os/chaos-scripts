#!/bin/env bash

# For debugging
# set -euo pipefail

Status_File=$HOME/.cache/distro-update-status.txt
pacman_pkglist=/etc/neon-os/.config/script-dependencies/pkglists/pacman.txt
aur_pkglist=/etc/neon-os/.config/script-dependencies/pkglists/aur.txt

echo "############################################################################"
echo "########                     UPDATING NEON-OS                       ########"
echo "############################################################################"

initialization()
{
    if [[ -f "$Status_File" ]]
    then
        echo "Check Passed"
    else
        echo "Success" > $Status_File
    fi
}

initialization || "ERROR: Failed to initialize"

check_root()
{
    if [[ `id -u` == 0 ]]
    then
        echo "##################################################################"
        echo "This script MUST NOT be run as ROOT because it runs commands which"
        echo "makes changes to the system and if ran as ROOT may potentially"
        echo "break the system, So it is highly recommended to run it as"
        echo "unprivileged (normal) USER. If necessory at times the script"
        echo "will ask the user for it's sudo/doas/root password."
        echo "##################################################################"
        exit
    fi
}

check_root || echo "ERROR: Failed to check for root"

internet_connectivity_error_message()
{
    echo "ERROR: It seems like you are not connected to the internet, Make sure you are connected and Try again."
    echo "Failed" > $Status_File
    exit
}

internet_connection_check()
{
    ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` 2>/dev/null 1>/dev/null || internet_connectivity_error_message
}

failure_management()
{
    echo "ERROR: Failed to update"
    echo "Failed" > $Status_File
    exit
}

on_success()
{
    cd $HOME
    if [[ `cat $Status_File` == "Success" ]]
    then
        rm -rf .config.bak
        rm -rf .emacs.d/init.el.bak
        rm -rf .imwheelrc.bak
        rm -rf .bashrc.bak
        mv ~/.config ~/.config.bak
        mv ~/.emacs.d/init.el ~/.emacs.d/init.el.bak
        mv ~/.imwheelrc ~/.imwheelrc.bak
        mv ~/.bashrc ~/.bashrc.bak
    fi
}

update_distro()
{
    doas -- nextdns stop || echo "ERROR: Failed to stop nextdns"
    echo "cCc---------------------------Updating Mirrors-------------------------------cCc"
    doas -- reflector --save /etc/pacman.d/mirrorlist -a 48 -l 20 -f 5 --sort rate
    echo "cCc---------------------------Installing Updates-----------------------------cCc"
    doas -- pacman -Sy - < $pacman_pkglist --ask 4 --overwrite=\*
    paru -S - < $aur_pkglist --ask 4 --overwrite=\*
}

configs_install()
{
    on_success || failure_management
    internet_connection_check
    update_distro || failure_management
    cd /etc/neon-os/dotfiles/
    doas -- cp -rf .config/ ~/
    doas -- chown -R $USER ~/.config
    doas -- cp -rf .imwheelrc ~/
    doas -- chown $USER ~/.imwheelrc
    doas -- cp -rf .emacs.d/init.el ~/.emacs.d/
    doas -- chown -R $USER ~/.emacs.d
    doas -- cp -rf .bashrc ~/
    doas -- chown $USER ~/.bashrc
    doas -- nextdns start || echo "ERROR: Failed to start nextdns"
}

configs_install || failure_management
echo "Success" > $Status_File
