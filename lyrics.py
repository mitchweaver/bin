#!/usr/bin/env python3

import lyricfetcher
import sys

input = []
artist = []
song = []

for i in sys.argv:
    input.add(i)

input = ("".join(input)).split(" - ")
artist = input(0)
song = input(1)

lyrics = lyricfetcher.get_lyrics('lyricswikia', artist[0], song[1])

print(lyrics)
