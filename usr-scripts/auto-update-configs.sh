#!/usr/bin/env bash

if [[ -d "/etc/neon-os/dotfiles/.config/" ]]; then
	doas -- cp -rsvf /etc/neon-os/dotfiles/.config/* ~/.config/
	doas -- chown $USER -R ~/.config/
fi
