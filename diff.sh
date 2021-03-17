#!/usr/bin/env bash

dotfiles=$(find . -type f|grep '^./_.*' |cut -c 4-)
binfiles=$(find ./bin -type f)

modifieds=

# dot files
for file in $dotfiles ; do
    diff -q $HOME/.$file _$file 
    if [ $? -ne 0 ] ; then
        modifieds="$modifieds $file"
    fi
done

# bin files
for file in $binfiles ; do
    diff -q $HOME/$file $file 
    if [ $? -ne 0 ] ; then
        modifieds="$modifieds $file"
    fi
done


echo
echo 
echo $modifieds
