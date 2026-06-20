#!/bin/sh

# ============================================================================>

sudo xbps-install -S base-devel git intel-ucode nftables runit-nftables

# ============================================================================>

if [ ! -d "/tmp/grub-theme/" ]; then
    git clone https://github.com/jdeokkim/minimal-grub-theme \
        /tmp/grub-theme
fi

make install -C /tmp/grub-theme

# ============================================================================>

if [ -n "$CHEZMOI_SOURCE_DIR" ]; then
    sudo cp -i "$CHEZMOI_SOURCE_DIR/.root-config/etc/nftables.conf" /etc/
fi

if [ ! -d "/var/service/nftables/" ]; then
    sudo ln -s /etc/sv/nftables /var/service/
fi

# ============================================================================>
