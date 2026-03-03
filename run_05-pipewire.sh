#!/bin/sh

# ============================================================================>

sudo xbps-install blueman bluez libspa-bluetooth pipewire wiremix 

sudo mkdir -p /etc/pipewire/pipewire.conf.d/

sudo ln -sf /usr/share/examples/wireplumber/10-wireplumber.conf \
  /etc/pipewire/pipewire.conf.d/
sudo ln -sf /usr/share/examples/pipewire/20-pipewire-pulse.conf \
  /etc/pipewire/pipewire.conf.d/

# ============================================================================>
