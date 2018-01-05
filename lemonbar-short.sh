#!/usr/bin/env bash

# kill bar if already running
if [ $(pgrep lemonbar) ] ; then
    pkill -9 lemonbar
fi

# source wal colors
. ${HOME}/.cache/wal/colors.sh

# ─────────────────────────────────────────────────────── #
DIM=$(xrandr | grep \* |awk '{print $1}')
s_width="$(sed 's/x.*//' <<< "$DIM")"
s_height="$(sed 's/^[^x]*x//' <<< "$DIM")"
# ─────────────────────────────────────────────────────── #

# ───────────── shorter along the bottom ──────────────── #
w=$(echo $s_width / 1.5 | bc)
h=$(echo $s_height / 16 | bc)
x=$(echo $(echo $s_width / 2 | bc) - $(echo $w / 2 | bc) | bc)
y=$(echo $(echo $s_height / 20 | bc) - $(echo $h / 2 | bc) | bc)
# ─────────────────────────────────────────────────────── #

# ───────────── shorter along top ─────────────────────── #
# w=$(echo $s_width / 1.5 | bc)
# h=$(echo $s_height / 16 | bc)
# x=$(echo $(echo $s_width / 2 | bc) - $(echo $w / 2 | bc) | bc)
# y=$(echo "$s_height - $s_height / 20 - $h/2" | bc)
# ─────────────────────────────────────────────────────── #


# ────────────── Spanned Across bottom ────────────────── #
# gap=24
# w=$(echo $s_width - $gap*2 | bc)
# h=$(echo $s_height / 12 | bc)
# x=$gap
# y=$gap
# ─────────────────────────────────────────────────────── #

# vol() {
#     sh ~/bin/BSDNixVolume.sh -get
# }

getdate(){
    echo $(date '+%a %b %d - %l:%M %p')
}

layout() { 
    case $(cat /tmp/dwm_info/current_layout) in
        # "0") echo "\\uf44e" ;; # tiled
        # "1") echo "\\ue28e" ;; # floating
        # "2") echo "\\ue245" ;; # monocle
        # "3") echo "[CMC]" ;; # center master
        # "4") echo "[CFM]" ;; # center floating master
        # "5") echo "[VVV]" ;; # fibonacci
        # "6") echo "\\uf037" ;; # top master
        "0") echo "\\uf44e" ;; # tiled
        "1") echo "[F]" ;; # floating
        "2") echo "[M]" ;; # monocle
        "3") echo "[G]" ;; # grid
        "4") echo "[CMC]" ;; # center master
        "5") echo "[CFM]" ;; # center floating master
        "6") echo "[VVV]" ;; # fibonacci
        "7") echo "[DDD]" ;; # top master

    esac
}

wrksp() {
    # case "$1" in
    #     "1") echo "" ;;
    #     "2") echo "" ;;
    #     "3") echo "" ;;
    #     "4") echo "" ;;
    #     "5") echo "" ;;
    #     "6") echo "" ;;
    # esac

    if [ $(cat /tmp/dwm_info/ws"$1") -eq 1 ] ; then
        echo "%{F$color2}$1%{F-}"
    else
        echo "$1"
    fi
}
iscur() { 
    if [ $CUR_WS -eq $1 ] ; then
        echo "%{+u}"
    else
        echo "%{-u}"
    fi
}

vol(){
    val=$(sh ~/bin/BSDNixVolume.sh -get)
    if [ $val -gt 50 ] ; then 
        vol="\\uf028"
    elif [ $val -gt 0 ] ; then
        vol="\\uf027"
    else 
        vol="\\uf026"
    fi
    echo $vol
}

space=" "
underline_pix=6
clickable_areas=0
song=$(bash ~/bin/get-song.sh 25 '')
for((;;)) {
    CUR_WS=$(cat /tmp/dwm_info/current_ws)

    vpn=$(sh ~/bin/vpn-check.sh)
    wifi=$(sh ~/bin/wifi-check.sh iwn0)
    bat=$(sh ~/bin/battery-check.sh)
    printf " %s%s%s%s%s%s%b%b \\n" \
        "%{T4}$(iscur 1)$space$(wrksp 1)$space" \
        "%{T4}$(iscur 2)$space$(wrksp 2)$space" \
        "%{T4}$(iscur 3)$space$(wrksp 3)$space" \
        "%{T4}$(iscur 4)$space$(wrksp 4)$space" \
        "%{T4}$(iscur 5)$space$(wrksp 5)$space" \
        "%{T4}$(iscur 6)$space$(wrksp 6)$space%{-u}%{T-}" \
        " %{F$color2}$(getdate) %{F-} %{T2}$(layout)%{T-}%{T2} $bat%{T-}%{T2} $wifi%{T2} $vpn%{T2} $(vol)" \
        "%{T5}%{r}$song" 

        # "%{c}%{F$color2}$(getdate)%{F-}" \
        # "%{T3}%{r} $song"

    sleep 0.1
} |\

lemonbar -db \
         -f "RobotoMono Nerd Font Mono:size=14" \
         -f "FontAwesome:size=16" \
         -f "RobotoMono Nerd Font Mono:size=14" \
         -f "RobotoMono Nerd Font Mono:size=12" \
         -f "tewi:size=14" \
         -g "$w"x"$h"+$x+$y \
         -n "lemonbar" \
         -u "$underline_pix" \
         -U "$color2" \
         -B "$color0" \
         -F "$color1" \
         -a "$clickable_areas" \

# -f "DejaVu Sans Mono" \
# -f "Noto Sans Mono" \
# -f "Droid Sans Mono" \
# -f "Symbola" \


# printf "    %s    \\n" "$(vol)%{c}$(tim)%{r}$(wrksp)   $(bat)"
         # -f "Terminus" \

