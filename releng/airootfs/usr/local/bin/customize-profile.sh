#!/bin/bash

set -e -u

# Regenerar locales
locale-gen

# Habilitar servicios importantes
systemctl enable NetworkManager
systemctl enable firewalld.service
systemctl enable gdm.service

# Forzar el objetivo gráfico
systemctl set-default graphical.target

# Iniciar claves del sistema
pacman-key --init

## -------------------------------------------------------------- ##

## Modify /etc/mkinitcpio.conf file
#sed -i '/etc/mkinitcpio.conf' \
#        -e "s/#COMPRESSION=\"zstd\"/COMPRESSION=\"zstd\"/g"


## Fix Initrd Generation in Installed System
cat > "/etc/mkinitcpio.d/linux.preset" <<- _EOF_
	# mkinitcpio preset file for the 'linux' package

	ALL_kver="/boot/vmlinuz-linux"
	ALL_config="/etc/mkinitcpio.conf"

	PRESETS=('default' 'fallback')

	#default_config="/etc/mkinitcpio.conf"
	default_image="/boot/initramfs-linux.img"
	#default_options=""

	#fallback_config="/etc/mkinitcpio.conf"
	fallback_image="/boot/initramfs-linux-fallback.img"
	fallback_options="-S autodetect"    
_EOF_

## Delete ISO specific init files
## rm -rf /etc/mkinitcpio.conf.d
