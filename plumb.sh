#!/usr/bin/env dash
#
# http://github.com/mitchweaver/bin
#
# Script to plumb to various programs from 
# input. I use this with the terminal, st.
#

term='st -T floating-st -n floating-st'
shell='/bin/ksh'
pager='less -Q -R'
alias find='find -L'
# pattern="$(sselp)"
pattern="$(xsel -o)"
# trim whitespace
pattern="$(echo $pattern | awk '{$1=$1;print}')"

[ -z "$pattern" ] &&
    exit

# echo "$pattern" >> /tmp/plumb_history.txt

get_path() {
    pattern="$1"
    path=`find ${HOME}/downloads/ -name "*$pattern"`
    [ -z "$path" ] && path=`du -ahLd 1 ${HOME} | grep "*$pattern"`
    [ -z "$path" ] && path=`find ${HOME}/files/ -name "*$pattern"`
    [ -z "$path" ] && path=`find ${HOME}/programs/ -name "*$pattern"`
    [ -z "$path" ] && path=`find ${HOME}/tmp/ -name "*$pattern"`
    [ -z "$path" ] && path=`find ${HOME}/backup/ -name "*$pattern"`
    [ -z "$path" ] && path=`find /tmp/ -name "*$pattern"`
    [ -n "$path" ] &&
        echo -n "$path"
}

determine_and_open() {

    case "${1##*.}" in
        jpg|png|jpeg)
            if type meh > /dev/null 2>&1 ; then
                meh "$1" &
            elif type feh > /dev/null 2>&1 ; then
                feh --auto-rotate --title feh -q "$1" &
            fi
            ;;
        pdf|epub)
            if type zathura > /dev/null 2>&1 ; then
                zathura "$file" &
            elif type mupdf > /dev/null 2>&1 ; then
                mupdf "$file" &
            fi
            ;;
        mp4|mkv|gif|webm)
            mpv "$1" &
            ;;
        mp3|ogg|opus|flac|wav)
            mpv --no-video "$1" &
            ;;
        torrent)
            st -e rtorrent "$1" &
            ;;
        jar)
            $term -e $shell -c "java -jar $1 | $pager" &
            ;;
        docx|rtf)
            if type abiword > /dev/null 2>&1 ; then
                abiword "$1" &
            else
                libreoffice "$1" &
            fi
            ;;
        odt|pptx|xlsx)
            libreoffice "$1" &
            ;;
        blend)
            blender "$1" &
            ;;
        o|out)
            $term -e $shell -c "$1 | $pager"
            ;;
        *)
            $term -e $EDITOR "$1" &
    esac
}

if [ -f "$pattern" ] ; then

    determine_and_open "$pattern"

elif [ "${pattern#*http}"  != "$pattern" ] ||
     [ "${pattern#*www\.}" != "$pattern" ] ||
     [ "${pattern#*\.com}" != "$pattern" ] ||
     [ "${pattern#*\.org}" != "$pattern" ] ; then
        $BROWSER "$pattern" &
# ------------------------------------------------------- 
# if we're still here, it must have been a part of a 
# file name. We'll need to search for it as efficiently
# as we can.
else
    case "${pattern##*.}" in
        # Images
        jpg|png|jpeg)
            image=$(get_path "$pattern")
            [ -z "$image" ] && image=`find ${HOME}/images/ -name "*$pattern"`

            [ -n "$image" ] &&
                feh --auto-rotate --title feh -q "$image" &
            ;;
        # Music
        mp3|ogg|flac|opus|wav)
            song=$(get_path "$pattern")
            [ -z "$song" ] && song=`find ${HOME}/music/ -name "*$pattern"`

            [ -n "$song" ] &&
                mpv --no-video "$song" &
            ;;
        # Videos
        mp4|webm|mkv|gif)
            video=$(get_path "$pattern")
            [ -z "$video" ] && video=`find ${HOME}/videos/ -name "*$pattern"`

            [ -n "$video" ] &&
                mpv "$video" &
            ;;
        # Books
        pdf|epub)
            file=$(get_path "$pattern")
            [ -z "$file" ] && file=`find ${HOME}/books/ -name "*$pattern"`

            if [ -n "$file" ] ; then
                if type zathura > /dev/null 2>&1 ; then
                    zathura "$file" &
                elif type mupdf > /dev/null 2>&1 ; then
                    mupdf "$file" &
                fi
            fi
            ;;
        # Text
        txt|text|py|hs|c|cpp|asm|sh|md|java|html|css|js|coffee| \
            perl|yaml|json|rb|php|tex|csv|xml|mk|h|rc|conf|bk|bak|\
            cfg|cf)
            file=$(get_path "$pattern")
            [ -z "$file" ] && file=`find ${HOME}/bin/ -name "*$pattern"`
            [ -z "$file" ] && file=`find ${HOME}/programs/ -name "*$pattern"`
            [ -z "$file" ] && file=`find ${HOME}/.dotfiles/ -name "*$pattern"`
            [ -z "$file" ] && file=`find ${HOME}/workspace/ -name "*$pattern"`
            [ -z "$file" ] && file=`find ${HOME}/games/ -name "*$pattern"`

            [ -n "$file" ] &&
                $term -e $EDITOR "$file" &
            ;;
        # If extension was not within the selection,
        # Try to search the most common directories with
        # a full fuzzy search.
        *)
            path=`find ${HOME}/downloads/ -name "*$pattern*"`
            [ -z "$path" ] && path=`find ${HOME}/files/ -name "*$pattern*"`
            [ -z "$path" ] && path=`find ${HOME}/programs/ -name "*$pattern*"`
            [ -z "$path" ] && path=`find ${HOME}/tmp/ -name "*$pattern*"`
            [ -z "$path" ] && path=`find ${HOME}/backup/ -name "*$pattern*"`
            [ -z "$path" ] && path=`find ${HOME}/bin/ -name "*$pattern*"`
            [ -z "$path" ] && path=`find ${HOME}/workspace/ -name "*$pattern*"`
            [ -z "$path" ] && path=`find ${HOME}/.dotfiles/ -name "*$pattern*"`
            [ -n "$path" ] && 
                determine_and_open "$path"
                
    esac
fi
