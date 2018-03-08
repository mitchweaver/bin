#!/bin/dash

perc=0
if [ $(apm -a) -eq 1 ] ; then
    echo "\\uf492" # charging
    exit 0
fi

perc="$(apm -l)"

[ $perc -eq 99 ] && perc=100

[ -n "$perc" ] &&
if [ $perc -gt 76 ] ; then 
    echo "\\uf240" # 76-100
elif [ $perc -gt 51 ] ; then 
    echo "\\uf241" # 51-76
elif [ $perc -gt 26 ] ; then
    echo "\\uf242" # 26-51
elif [ $perc -gt 10 ] ; then
    echo "\\uf243" # 6-25
elif [ $perc -gt 5 ] ; then
    echo "\\uf244" # 6-25
else 
    echo "\\uf244☠️ " # 0-5
fi 
