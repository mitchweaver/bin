#!/bin/sh

[ -f /tmp/redshift ] || echo "5" > /tmp/redshift

case $(< /tmp/redshift) in
    "5")
        redshift -x # clears to default
        echo 4 > /tmp/redshift
        ;;
    "4")
        redshift -O 5000
        echo 3 > /tmp/redshift
        ;;
    "3")
        redshift -O 3400
        echo 2 > /tmp/redshift
        ;;
    "2")
        redshift -O 3000
        echo 1 > /tmp/redshift
        ;;
    "1")
        redshift -O 2700
        echo 0 > /tmp/redshift
        ;;
    "0")
        redshift -O 2350
        echo 5 > /tmp/redshift
        ;;

esac
