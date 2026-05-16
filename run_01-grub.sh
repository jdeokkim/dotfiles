#!/bin/sh

# ============================================================================>

if [ ! -d "/tmp/grub-theme" ]; then
    git clone https://github.com/jdeokkim/minimal-grub-theme \
        /tmp/grub-theme
fi

make install -C /tmp/grub-theme

# ============================================================================>
