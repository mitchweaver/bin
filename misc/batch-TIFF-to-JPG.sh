#!/bin/bash
for i in *.tiff ; do convert "$i" "${i%.*}.jpg" ; done &&
rm -rf *.tiff &

echo "ALL DONE!"
