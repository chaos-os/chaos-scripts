#!/bin/env bash

# For debugging
# set -euo pipefail

echo "############################################################################" 
echo "########                   UPDATING NEON-OS                       ########" 
echo "############################################################################" 

check_root()
{
    if [[ `id -u` != 0 ]]
    then
	echo "##################################################################"
	echo "This script must be run as root as the commands executed do"
	echo "require root permission."
	echo "##################################################################"
	exit
    fi
}

check_root || echo "ERROR: Failed to check for root"

internet_connectivity_error_message()
{
    echo "ERROR: It seems like you are not connected to the internet, Make sure you are connected and Try again."
    exit
}

internet_connection_check()
{
     ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` 2>/dev/null 1>/dev/null || internet_connectivity_error_message 
}

internet_connection_check

configs_clone_install()
{
    internet_connection_check
    git clone https://gitlab.com/NEON-MMD/dotfiles.git
    cd dotfiles
}
configs_install()
{
    cd /tmp
    configs_clone_install || cd dotfiles
    cp -rf .config/* ~/.config/
    cp -rf .imwheelrc ~/
    cp -rf .emacs.d/ ~/
    cp -rf .bashrc ~/
    cd ..
    rm -rf dotfiles
}

configs_install || echo "ERROR: Failed to update"

