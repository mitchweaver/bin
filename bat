#!/bin/dash

[ $(apm -a) -eq 1 ] &&
    echo "\\uf492" ||
        { perc="$(apm -l)"
          case ${perc%?} in
            [8-9]) echo "\\uf240" ;;
            [6-7]) echo "\\uf241" ;;
            [4-5]) echo "\\uf242" ;;
            [2-3]) echo "\\uf243" ;;
            [0-1]*) echo "\\uf244"
          esac }
