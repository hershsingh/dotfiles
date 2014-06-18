#!/bin/bash

DOTFILES=$(pwd)
DOTFILES_OLD=$HOME/dotfiles_old

# Create a list of all files (excluding git files) in the current directory.
find . * -type f | grep -v "\./.\git" > dotfiles.txt

mkdir -p $DOTFILES_OLD

# Backup all files that currently exist into the folder $DOTFILES_OLD, 
# while preserving the directory structure and dereferencing links.
rsync -Razq --copy-links --files-from=$DOTFILES/dotfiles.txt . $DOTFILES_OLD/

# Loop over all dotfiles and create symlinks for all.
while read src
do
    if [ ! -d $(dirname $HOME/$src) ]; then
        mkdir -p $(dirname $HOME/$src)
    fi
    rm -f $HOME/$src
    ln -s $DOTFILES/$src $HOME/$src
done < $DOTFILES/dotfiles.txt
