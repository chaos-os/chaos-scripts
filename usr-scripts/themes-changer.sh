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
    "nord")
	sed -i "s|colors = color_picker(\"[a-zA-Z\-]*\")|colors = color_picker(\"nord\")|"g ~/.config/qtile/config.py
	sed -i "s|include [a-zA-Z\-]*.conf|include nord.conf|"g ~/.config/kitty/kitty.conf
	sed -i "s|(load-theme 'doom-[a-zA-Z\-]* t)|(load-theme 'doom-nord t)|"g ~/.emacs.d/init.el
	sed -i "s|local colorscheme = 'doom-[a-zA-Z\-\+]*'|local colorscheme = 'doom-nord'|"g ~/.config/nvim/lua/settings/colorschemes/init.lua
	sed -i "s|local colors = themes.pick_a_theme(\"[a-zA-Z\-]*\");|local colors = themes.pick_a_theme(\"nord\");|"g ~/.config/awesome/themes/powerarrow/theme.lua
	;;
    "gruvbox-dark")
	sed -i "s|colors = color_picker(\"[a-zA-Z\-]*\")|colors = color_picker(\"gruvbox-dark\")|"g ~/.config/qtile/config.py
	sed -i "s|include [a-zA-Z\-]*.conf|include gruvbox-dark.conf|"g ~/.config/kitty/kitty.conf
	sed -i "s|(load-theme 'doom-[a-zA-Z\-]* t)|(load-theme 'doom-gruvbox t)|"g ~/.emacs.d/init.el
	sed -i "s|local colorscheme = 'doom-[a-zA-Z\-\+]*'|local colorscheme = 'doom-gruvbox'|"g ~/.config/nvim/lua/settings/colorschemes/init.lua
	sed -i "s|local colors = themes.pick_a_theme(\"[a-zA-Z\-]*\");|local colors = themes.pick_a_theme(\"gruvbox-dark\");|"g ~/.config/awesome/themes/powerarrow/theme.lua
	;;
    "solarized-dark")
	sed -i "s|colors = color_picker(\"[a-zA-Z\-]*\")|colors = color_picker(\"solarized-dark\")|"g ~/.config/qtile/config.py
	sed -i "s|include [a-zA-Z\-]*.conf|include solarized-dark.conf|"g ~/.config/kitty/kitty.conf
	sed -i "s|(load-theme 'doom-[a-zA-Z\-]* t)|(load-theme 'doom-solarized-dark t)|"g ~/.emacs.d/init.el
	sed -i "s|local colorscheme = 'doom-[a-zA-Z\-\+]*'|local colorscheme = 'doom-palenight'|"g ~/.config/nvim/lua/settings/colorschemes/init.lua
	sed -i "s|local colors = themes.pick_a_theme(\"[a-zA-Z\-]*\");|local colors = themes.pick_a_theme(\"solarized-dark\");|"g ~/.config/awesome/themes/powerarrow/theme.lua
	;;
    "solarized-light")
	sed -i "s|colors = color_picker(\"[a-zA-Z\-]*\")|colors = color_picker(\"solarized-light\")|"g ~/.config/qtile/config.py
	sed -i "s|include [a-zA-Z\-]*.conf|include solarized-light.conf|"g ~/.config/kitty/kitty.conf
	sed -i "s|(load-theme 'doom-[a-zA-Z\-]* t)|(load-theme 'doom-solarized-light t)|"g ~/.emacs.d/init.el
	sed -i "s|local colorscheme = 'doom-[a-zA-Z\-\+]*'|local colorscheme = 'doom-ayu-light'|"g ~/.config/nvim/lua/settings/colorschemes/init.lua
	sed -i "s|local colors = themes.pick_a_theme(\"[a-zA-Z\-]*\");|local colors = themes.pick_a_theme(\"solarized-light\");|"g ~/.config/awesome/themes/powerarrow/theme.lua
	;;
    "monokai")
	sed -i "s|colors = color_picker(\"[a-zA-Z\-]*\")|colors = color_picker(\"monokai\")|"g ~/.config/qtile/config.py
	sed -i "s|include [a-zA-Z\-]*.conf|include monokai.conf|"g ~/.config/kitty/kitty.conf
	sed -i "s|(load-theme 'doom-[a-zA-Z\-]* t)|(load-theme 'doom-monokai-classic t)|"g ~/.emacs.d/init.el
	sed -i "s|local colorscheme = 'doom-[a-zA-Z\-\+]*'|local colorscheme = 'doom-monokai-classic'|"g ~/.config/nvim/lua/settings/colorschemes/init.lua
	sed -i "s|local colors = themes.pick_a_theme(\"[a-zA-Z\-]*\");|local colors = themes.pick_a_theme(\"monokai\");|"g ~/.config/awesome/themes/powerarrow/theme.lua
	;;
    "oceanic-next")
	sed -i "s|colors = color_picker(\"[a-zA-Z\-]*\")|colors = color_picker(\"oceanic-next\")|"g ~/.config/qtile/config.py
	sed -i "s|include [a-zA-Z\-]*.conf|include oceanic-next.conf|"g ~/.config/kitty/kitty.conf
	sed -i "s|(load-theme 'doom-[a-zA-Z\-]* t)|(load-theme 'doom-oceanic-next t)|"g ~/.emacs.d/init.el
	sed -i "s|local colorscheme = 'doom-[a-zA-Z\-\+]*'|local colorscheme = 'doom-oceanic-next'|"g ~/.config/nvim/lua/settings/colorschemes/init.lua
	sed -i "s|local colors = themes.pick_a_theme(\"[a-zA-Z\-]*\");|local colors = themes.pick_a_theme(\"oceanic-next\");|"g ~/.config/awesome/themes/powerarrow/theme.lua
	;;

    *)
	echo "quit";;
esac

windowManager=`echo -e "Yes\nNo" | dmenu -p 'Do you want to change the style of qtile?' -l 2`
case $windowManager in
    "Yes")
	N=`cat /etc/neon-os/.config/script-dependencies/theme-styles.txt | dmenu -p 'select your theme style:' -l 20`
	case $N in
	    "powerarrow")
		sed -i "s|face_style = \"[a-zA-Z\-]*\"|face_style = \"arrow\"|"g .config/qtile/modules/widgets.py;;
	    "semi-circle")
		sed -i "s|face_style = \"[a-zA-Z\-]*\"|face_style = \"semi-circle\"|"g .config/qtile/modules/widgets.py;;
	    "top-right-angled-triangle")
		sed -i "s|face_style = \"[a-zA-Z\-]*\"|face_style = \"top-right-triangle\"|"g .config/qtile/modules/widgets.py;;
	    "bottom-right-angled-triangle")
		sed -i "s|face_style = \"[a-zA-Z\-]*\"|face_style = \"bottom-right-triangle\"|"g .config/qtile/modules/widgets.py;;
	    "vertical")
		sed -i "s|face_style = \"[a-zA-Z\-]*\"|face_style = \"vertical\"|"g .config/qtile/modules/widgets.py;;
	    *)
		echo "quit";;
	esac;;
    *)
	echo "quit";;
esac

N=`echo -e "Yes\nNo" | dmenu -p 'Do you want to log out to make the changes have effect?' -l 2`
case $N in
    "Yes")
	loginctl kill-user $USER
	;;
    *)
	zenity --info --text="Please make sure to log out to make the changes take effect." --icon-name="bell" --ellipsize;;
esac
