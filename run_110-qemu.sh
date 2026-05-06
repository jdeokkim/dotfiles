#!/bin/sh

# ============================================================================>

sudo xbps-install qemu virt-manager

# ============================================================================>

if [ ! -L "/var/service/libvirtd" ]; then
    sudo ln -s /etc/sv/libvirtd /var/service/
    sudo ln -s /etc/sv/polkitd /var/service/
    sudo ln -s /etc/sv/virtlockd /var/service/
    sudo ln -s /etc/sv/virtlogd /var/service/
fi

# ============================================================================>

if [ -n "$USER" ]; then
    sudo usermod -aG libvirt jdeokkim
fi

# ============================================================================>
