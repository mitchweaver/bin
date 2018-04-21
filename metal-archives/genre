#!/usr/bin/env python3
#
# http://github.com/mitchweaver/bin
#
# get the genre of a given band from metal-archives
#

from bs4 import BeautifulSoup
from bs4.element import Comment
import urllib.request
import sys

def tag_visible(element):
    if element.parent.name in ['style', 'script', 'head', 'title', 'meta', '[document]']:
        return False
    if isinstance(element, Comment):
        return False
    return True

def text_from_html(body):
    soup = BeautifulSoup(body, 'html.parser')
    texts = soup.findAll(text=True)
    visible_texts = filter(tag_visible, texts)  
    lines = []
    for line in visible_texts:
        lines.append(line)
    return lines

    # return " ".join(t.strip() for t in visible_texts)

def parse(url):
    try:
        html = urllib.request.urlopen(url).read()

        genre = []
        found_count = 0
        for line in text_from_html(html):
            if len(line.strip()) < 2: continue
            if 'Genre:' in line:
                genre.append(line)
                found_count = 1
            elif found_count > 0:
                genre.append(line)
                found_count += 1
            if found_count == 2:
                break

        print(genre[0] + ' ' + genre[1])
    except:
        print("Can't find it?")

def main():
    parse(url = 'https://www.metal-archives.com/bands/' + sys.argv[1])

if __name__ == "__main__": main()
