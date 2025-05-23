#!/usr/bin/env bash
# mantenedor: m4teo.dev
# date: 6-4-25
# licencia GPLv3

## Generate sha256sum and gpg signature files
PWD=`pwd`
DIR="$PWD/iso"

if [[ ! -d "$DIR" ]]; then
	exit 1
fi

RELEASE=`find $DIR -type f -name "EosOS_gnome-*.iso" -printf "%f\n"`

if [[ -n "$RELEASE" ]]; then
	echo -e "\n[*] Generating sha256sum for ${RELEASE} ..."
	cd "$DIR" && sha256sum ${RELEASE} > ${RELEASE}.sha256sum
	if [[ -e "${RELEASE}.sha256sum" ]]; then
		echo -e "[*] Checksum generated successfully."
	else
		echo -e "[!] Failed to generate checksum file."
	fi	
	
	echo -e "\n[*] Generating gpg signature for ${RELEASE} ..."
	gpg --default-key sourcecorearch@gmail.com --output ${RELEASE}.sig --detach-sig ${RELEASE}
	if [[ -e "${RELEASE}.sig" ]]; then
		echo -e "[*] Signature generated successfully.\n"
	else
		echo -e "[!] Failed to generate signature file.\n"
	fi
else
	echo -e "\n[!] There's no ISO file in 'files' directory.\n[!] Copy the ISO file in 'files' directory & Run this script again.\n"
	exit 1
fi
