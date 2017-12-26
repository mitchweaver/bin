#!/bin/bash
for i in *.png ; do convert "$i" "${i%.*}.jpg" ; done &&
rm -rf *.png &

echo "ALL DONE!"
