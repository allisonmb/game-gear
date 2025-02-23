#!/bin/bash
MOUNT_POINT="/mnt/external"

GG_FILE=$(find "$MOUNT_POINT" -type f -name "*.gg" | head -n 1)

if [[ -n "$GG_FILE" ]]; then
	echo "Found .gg file: $GG_FILE"
	/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-genesis-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/gamegear/retroarch.cfg "$GG_FILE"
fi


# umount "$MOUNT_POINT"
