#!/bin/bash
DEVICE="/dev/$1"
USER="mocha"
DISPLAY=$(loginctl show-user $USER --property=Display | cut -d'=' -f2)
XDG_RUNTIME_DIR=/run/user/$(id -u $USER)
MOUNT_POINT="/mnt/external"

mkdir -p "$MOUNT_POINT"
mount -o uid=1000,gid=1000,umask=0022 "$DEVICE" "$MOUNT_POINT"
GG_FILE=$(find "$MOUNT_POINT" -type f -name "*.gg" | head -n 1)

if [[ -n "$GG_FILE" ]]; then
	echo "Found .gg file: $GG_FILE"
	sudo -u $USER XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR systemctl --user --no-block start run-cart@$1.service
fi


# umount "$MOUNT_POINT"
