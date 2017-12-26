#!/bin/bash
for i in *.tif ; do convert "$i" "${i%.*}.jpg" ; done &&
rm -rf *.tif &

echo "ALL DONE!"
