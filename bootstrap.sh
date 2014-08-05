#!/bin/bash

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_OLD=$HOME/dotfiles_old
DOTFILES_LIST=dotfiles.txt
THIS_SCRIPT=$(basename $0)

# Create a list of all files (excluding git files, this script, current directory) in the dotfiles directory.
find . -type d -name .git -prune -o \( \! -type d -print \) > $DOTFILES_LIST

cd

# Backup all files that currently exist into the folder $DOTFILES_OLD, 
# while preserving the directory structure and dereferencing links.
# rsync prints errors for files which don't exist. They can be ignored.
mkdir -p $DOTFILES_OLD 
rsync -Razq --copy-links --files-from=$DOTFILES/dotfiles.txt . $DOTFILES_OLD/

# Loop over all dotfiles and create symlinks for all.
while read src
do
    SOURCE=$(readlink -f $DOTFILES/$src)
    if [ ! -d $(dirname $HOME/$src) ]; then
        mkdir -p $(dirname $HOME/$src)
    fi
    rm -f $HOME/$src
    ln -s $SOURCE $HOME/$src
done < $DOTFILES/$DOTFILES_LIST
 
# # Vim - Vundle
# git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# vim +VundleInstall +qall
# 
# # AwesomeWM - Beautiful Themes
# git clone https://github.com/mikar/awesome-themes.git ~/.config/awesome/themes
