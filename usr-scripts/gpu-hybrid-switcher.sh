#!/bin/env bash

# for debugging
# set -euox pipefail

echo "##################################################################################"
echo "#########               WELCOME TO AMD HYBRID SWITCHER                 ###########"
echo "##################################################################################"

sudo rm -rf /etc/X11/xorg.conf.d/*

while :
do
    echo -e "Which gpu do you want to switch to: \n\n1)Amdgpu \n2)Radeon \n3)Intel \n4)Nvidia \n5)Quit\n"
    read -p "Select your choice: " answer
    case $answer in
	"1")
	    echo "switching to Amdgpu"
	    sudo rm -rf /etc/X11/xorg.conf.d/*
	    sudo cp /opt/neon-os-scripts/20-amdgpu.conf /etc/X11/xorg.conf.d/
	    break;;
	"2" | "") 
	    echo "switching to Radeon"
	    sudo rm -rf /etc/X11/xorg.conf.d/*
	    sudo cp /opt/neon-os-scripts/20-radeon.conf /etc/X11/xorg.conf.d/
	    break;;
	"3")
	    echo "switching to Intel"
	    sudo rm -rf /etc/X11/xorg.conf.d/*
	    sudo cp /opt/neon-os-scripts/20-intel.conf /etc/X11/xorg.conf.d/
	    break;;
	"4")
	    echo "switching to Nvidia"
	    sudo rm -rf /etc/X11/xorg.conf.d/*
	    sudo cp /opt/neon-os-scripts/20-nvidia.conf /etc/X11/xorg.conf.d/
	    break;;
	"5")
	    echo "terminated"
	    break;;
	*)
	    echo "Invalid answer. Please answer 1,2,3,4 or 5.";;
    esac
done

echo "##################################################################################"
echo "#########                      REBOOTING YOUR SYSTEM                   ###########"
echo "##################################################################################"

while :
do
    read -p "Do you want reboot your system [Y/N]? " answer
    case $answer in
	"Y" | "y" | "")
	    echo "rebooting"
	    reboot
	    break;;
	"N" | "n")
	    echo "please make sure to reboot your system!"
	    break;;
	*)
	    echo "Invalid answer. Please answer [Yy/Nn].";;
    esac
done
