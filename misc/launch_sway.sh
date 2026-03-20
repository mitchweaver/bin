#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland

export XCURSOR_SIZE=24

export XDG_RUNTIME_DIR="/tmp/.$USER-xdg_runtime_dir"

if [ -d "$XDG_RUNTIME_DIR" ] ; then
	mv "$XDG_RUNTIME_DIR" "${XDG_RUNTIME_DIR}.$$.old"
fi
mkdir -p "${XDG_RUNTIME_DIR}"
chmod 0700 "${XDG_RUNTIME_DIR}"

export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

############export WLR_NO_HARDWARE_CURSOR=1
############export WLR_RENDERER_ALLOW_SOFTWARE=1

# this fixes mouse stuttering and errors of
# "Atomic commit failed: Device or resource busy"
export WLR_DRM_NO_ATOMIC=1

########export WLR_DRM_DEVICES=/dev/dri/card1

mkdir -p ~/.cache
exec dbus-run-session sway --unsupported-gpu >~/.cache/sway.log 2>&1

