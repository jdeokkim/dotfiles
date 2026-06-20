#!/bin/sh

# ============================================================================>

sudo xbps-install -S nftables runit-nftables

# ============================================================================>

if [ -n "$CHEZMOI_SOURCE_DIR" ]; then
    sudo cp -i "$CHEZMOI_SOURCE_DIR/.root-config/etc/nftables.conf" /etc/
fi

if [ ! -d "/var/service/nftables/" ]; then
    sudo ln -s /etc/sv/nftables /var/service/
fi

# ============================================================================>
