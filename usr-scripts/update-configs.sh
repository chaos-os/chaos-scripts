#!/usr/bin/env bash

if [[ -d "/etc/neon-os/dotfiles/.config/" ]]; then
	pkexec cp -rsvf /etc/neon-os/dotfiles/.config/* ~/.config/
	pkexec chown $USER -R ~/.config/
fi
