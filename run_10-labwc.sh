#!/bin/sh

# ============================================================================>

sudo xbps-install Waybar intel-video-accel labwc labwc-menu-generator \
    mesa-dri xcursor-vanilla-dmz xdg-user-dirs

# ============================================================================>

menu_xml="$HOME/.config/labwc/menu.xml"

mkdir -p "$HOME/.config/labwc/"
mkdir -p "$HOME/.local/share/themes/void-esm/labwc/"

true > "$menu_xml"

# ============================================================================>

printf '%b\n' '<?xml version="1.0" encoding="UTF-8"?>
<openbox_menu>
<menu id="root-menu" label="root-menu">' >> "$menu_xml";

labwc-menu-generator -b -n >> "$menu_xml";

printf '%b\n' '<separator />
  <item label="Reconfigure">
    <action name="Reconfigure" />
  </item>
  <item label="Exit">
    <action name="Exit" />
  </item>
</menu> <!-- root-menu -->
</openbox_menu>' >> "$menu_xml";

# ============================================================================>

pkill -SIGHUP -x labwc
pkill -SIGUSR2 -x waybar

# ============================================================================>
