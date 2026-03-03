#!/bin/sh

# ============================================================================>

sudo xbps-install tuigreet

if [ -n "$CHEZMOI_SOURCE_DIR" ]; then
	sudo cp -ri "$CHEZMOI_SOURCE_DIR/.root-config/etc/greetd" /etc/
fi

if [ ! -e "/var/service/greetd" ]; then
	sudo ln -sf /etc/sv/greetd /var/service/
fi

sudo sv restart greetd

# ============================================================================>
