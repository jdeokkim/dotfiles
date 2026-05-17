#!/bin/sh

# ============================================================================>

sudo xbps-install Thunar alacritty brightnessctl cscope ctags feh \
    firefox-esr flatpak grim nwg-look okular slurp strace swappy \
    thunar-archive-plugin void-repo-nonfree vscode xarchiver \
    xdg-desktop-portal-gtk xdg-desktop-portal-wlr

# ============================================================================>

flatpak install flathub com.discordapp.Discord
flatpak install flathub md.obsidian.Obsidian

# ============================================================================>

xdg-user-dirs-update

# ============================================================================>
