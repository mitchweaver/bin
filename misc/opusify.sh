#!/bin/sh
#-loglevel -8

# note, runs this in parallel

find -name "*.ogg" -exec sh -c 'ffmpeg -i "{}" -y -acodec libopus -ab 128k "${0/.ogg}.opus" && rm "{}"' {} \; &
find -name "*.aac" -exec sh -c 'ffmpeg -i "{}" -y -acodec libopus -ab 128k "${0/.ogg}.opus" && rm "{}"' {} \; &
find -name "*.flac" -exec sh -c 'ffmpeg -i "{}" -y -acodec libopus -ab 128k "${0/.ogg}.opus" && rm "{}"' {} \; &
find -name "*.mp3" -exec sh -c 'ffmpeg -i "{}" -y -acodec libopus -ab 128k "${0/.ogg}.opus" && rm "{}"' {} \; &
