#!/bin/sh

# ============================================================================>

sudo xbps-install ImageMagick xcursorgen

# ============================================================================>

if [ -n "/tmp/retrosmart/" ]; then 
    git clone https://github.com/mdomlop/retrosmart-x11-cursors \
        /tmp/retrosmart/

    make -C /tmp/retrosmart/ && sudo make -C /tmp/retrosmart/ install
fi

# ============================================================================>
