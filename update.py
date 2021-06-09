#!/usr/bin/env python

import sys
import os
import shutil
import difflib
import pprint

excludes = ['diff.sh', 'README.md', 'update.py']
homepath = os.path.expanduser('~')

def findlocals(): 
    for dirpath, dirnames, filenames in os.walk('.', topdown=True, followlinks=False):
        if dirpath.startswith('./.git'):
            continue

        
        for fn in filenames:
            if fn not in excludes:
                yield os.path.join(dirpath, fn)

file_pairs = {}

for gitfn in findlocals():
    localfn = gitfn
    if localfn.startswith('./_'):
        localfn = localfn.replace('_', '.', 1)
    localfn = localfn.replace('.', homepath, 1)
    file_pairs[gitfn] = localfn

# now compare all the files
missings = []
oks = []
diffs = []
for g, l in file_pairs.items():
    if os.path.exists(l):
        delta = list(difflib.context_diff(open(g, mode='r').readlines(), open(l, 'r').readlines()))
        if len(delta) != 0:
            diffs.append((g, l))
        else:
            oks.append((g, l))
    else:
        missings.append((g, l))


if __name__ == '__main__':
    if missings:
        print('Missing locally:')
        for m in missings:
            print('   ', m[1])
        print()

    if diffs:
        print('Differing:')
        for m in diffs:
            print('   ', m[1])
        print()

    if oks:
        print('OK:')
        for m in oks:
            print('   ', m[1])
        print()

if missings:
    print('Fixing locally missing files...')
    for g, l in missings:
        print(g, '--->', l)
        shutil.copy2(g, l)

 
update_target = 'none'
if len(sys.argv) > 1:
    update_target = sys.argv[1]

if diffs:
    if update_target == 'local':
        print('Updating LOCAL version from GIT version')
        for g, l in diffs:
            print(g, '--->', l)
            shutil.copy2(g, l)
    elif update_target == 'git':
        print('Updating GIT version from LOCAL version')
        for g, l in diffs:
            print(l, '--->', g)
            shutil.copy2(l, g)
    else:
        print('Not updating. Specify local or git next time.')

