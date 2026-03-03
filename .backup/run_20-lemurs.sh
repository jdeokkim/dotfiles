#!/bin/sh

sudo xbps-install lemurs

if [ -n "$CHEZMOI_SOURCE_DIR" ]; then 
	sudo cp -ri "$CHEZMOI_SOURCE_DIR/root/etc/" /
	
	sudo chmod +x /etc/sv/lemurs/run
	
	sudo ln -sf /etc/sv/lemurs /var/service/	
fi

