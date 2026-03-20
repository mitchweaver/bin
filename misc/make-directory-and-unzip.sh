#!/bin/sh

for i in *zip ; do
    folder="${i%.zip}"

    printf '\n[*] Making directory: %s\n\n' "$folder"
    mkdir "$folder"

    printf '\n[*] moving .zip to: %s\n\n' "$folder"
    mv "$i" "$folder"

    cd "$folder"

    printf '\n[*] unzipping: %s\n\n' "$i"
    unzip "$i" && \
    { echo "Successs. Deleting zip." ; rm "$i" ; }

    cd ..
done
