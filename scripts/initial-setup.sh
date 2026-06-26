#!/bin/bash

deps="zen-browser-bin tmux zsh oh-my-posh-bin neovim obsidian git lazygit stow thefuck television sesh-bin yazi wl-clipboard"

echo """
=== Installing $deps ===
"""

paru -S $deps

echo """
=== Changing default shell to zsh ===
"""

sudo chsh -s $(which zsh)

echo """
=== Configuring git ===
"""

git config --global user.email "cethrivias@gmail.com"
git config --global user.name "cethrivias"
