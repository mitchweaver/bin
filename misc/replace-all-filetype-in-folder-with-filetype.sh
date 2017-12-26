#!/bin/bash

for f in *.$1; do
mv -- "$f" "${f%.$1}.$2"
done
