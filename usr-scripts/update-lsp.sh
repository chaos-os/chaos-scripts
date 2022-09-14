#!/usr/bin/env bash

if [[ -d "$HOME/.local/share/nvim/mason/bin" ]]; then
	doas -- cp -svf ~/.local/share/nvim/mason/bin/* /usr/bin/
fi
