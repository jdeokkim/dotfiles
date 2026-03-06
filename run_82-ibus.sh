#!/bin/sh

# ============================================================================>

sudo xbps-install ibus ibus-hangul 

# ============================================================================>

if [ -n "$CHEZMOI_SOURCE_DIR" ]; then
    dconf load /desktop/ibus/ < \
        "$CHEZMOI_SOURCE_DIR/.backup/dconf-desktop_ibus.ini"

    dconf load /org/freedesktop/ibus/ < \
        "$CHEZMOI_SOURCE_DIR/.backup/dconf-org_freedesktop_ibus.ini" 
fi

# ============================================================================>
