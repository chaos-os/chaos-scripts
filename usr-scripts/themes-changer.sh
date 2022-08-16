#!/bin/env bash

# Please fail on hidden bugs
set -euo pipefail

N=`cat /etc/neon-os/.config/script-dependencies/themes.txt | dmenu -p 'select your theme:' -l 20`

case $N in
    "dracula")
	sed -i "s|colors = color_picker(\"[a-zA-Z\-]*\")|colors = color_picker(\"dracula\")|"g ~/.config/qtile/config.py
	sed -i "s|include [a-zA-Z\-]*.conf|include dracula.conf|"g ~/.config/kitty/kitty.conf
	sed -i "s|(load-theme 'doom-[a-zA-Z\-]* t)|(load-theme 'doom-dracula t)|"g ~/.emacs.d/init.el
	sed -i "s|local colorscheme = 'doom-[a-zA-Z\-\+]*'|local colorscheme = 'doom-dracula'|"g ~/.config/nvim/lua/settings/colorschemes/init.lua
	sed -i "s|local colors = themes.pick_a_theme(\"[a-zA-Z\-]*\");|local colors = themes.pick_a_theme(\"dracula\");|"g ~/.config/awesome/themes/powerarrow/theme.lua
	;;
    "tomorrow-night")
	sed -i "s|colors = color_picker(\"[a-zA-Z\-]*\")|colors = color_picker(\"tomorrow-night\")|"g ~/.config/qtile/config.py
	sed -i "s|include [a-zA-Z\-]*.conf|include tomorrow-night.conf|"g ~/.config/kitty/kitty.conf
	sed -i "s|(load-theme 'doom-[a-zA-Z\-]* t)|(load-theme 'doom-tomorrow-night t)|"g ~/.emacs.d/init.el
	sed -i "s|local colorscheme = 'doom-[a-zA-Z\-\+]*'|local colorscheme = 'doom-dark+'|"g ~/.config/nvim/lua/settings/colorschemes/init.lua
	sed -i "s|local colors = themes.pick_a_theme(\"[a-zA-Z\-]*\");|local colors = themes.pick_a_theme(\"tomorrow-night\");|"g ~/.config/awesome/themes/powerarrow/theme.lua
	;;
    *)
	echo "quit";;
esac

N=`echo -e "Yes\nNo" | dmenu -p 'Do you want to log out to make the changes have effect?' -l 2`
case $N in
    "Yes")
	loginctl kill-user $USER
	;;
    "No")
	zenity --info --text="Please make sure to log out to make the changes take effect." --icon-name="bell" --ellipsize
	;;
    *)
	zenity --info --text="Please make sure to log out to make the changes take effect." --icon-name="bell" --ellipsize;;
esac
