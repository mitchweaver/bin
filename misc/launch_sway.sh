#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1
export XCURSOR_SIZE=24

export XDG_RUNTIME_DIR="/tmp/.$USER-xdg_runtime_dir"

if [ -d "$XDG_RUNTIME_DIR" ] ; then
	rm -r "$XDG_RUNTIME_DIR"
fi
mkdir "${XDG_RUNTIME_DIR}"
chmod 0700 "${XDG_RUNTIME_DIR}"

export XDG_SESSION_TYPE=sway
export XDG_SESSION_DESKTOP=sway

############export WLR_NO_HARDWARE_CURSOR=1
############export WLR_RENDERER_ALLOW_SOFTWARE=1

##########export WLR_DRM_DEVICES=/dev/dri/card0

mkdir -p ~/.cache
exec dbus-run-session sway --unsupported-gpu >~/.cache/sway.log 2>&1

