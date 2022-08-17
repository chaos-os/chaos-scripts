#!/bin/env python

from subprocess import getoutput, Popen

N = getoutput(
    "cat /etc/neon-os/.config/script-dependencies/search-engines.txt | cut -d '-' -f1 | dmenu -i -p 'select your search engine:' -l 20"
)
if not N:
    exit()
Y = getoutput("echo '' | dmenu -p {0} -i".format(N))
Z = getoutput(
    "cat /etc/neon-os/.config/script-dependencies/search-engines.txt | grep {0} | cut -d '-' -f2"
    .format(N))
if not Y:
    exit()
else:
    if N == "ArchWiki":
        for i in Y.split():
            Z += i + '_'
        Popen(["xdg-open", Z])
    else:
        X = ''
        for i in Y.split():
            Z += i + '+'
        Popen(["xdg-open", Z])
