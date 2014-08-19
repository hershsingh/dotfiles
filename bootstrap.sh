#!/bin/bash

## Preamble
# Define colors for 'tput'
textrev=$(tput rev)
textred=$(tput setaf 1)
textblue=$(tput setaf 4)
textreset=$(tput sgr0)
note() {
    echo ${textblue}$@${textreset}
}
header() {
    echo ${textred}$@${textreset}
}

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_OLD=$HOME/dotfiles_old
DOTFILES_LIST=dotfiles.txt
THIS_SCRIPT=$(basename $0)

header "The Dotfiles Bootstrap Script"
echo

# Create a list of all files (excluding git files, this script, current directory) in the dotfiles directory.
note "Creating a list of all dotfiles to be loaded..."
find . -type d -name .git -prune -o \( \! -type d -print \) > $DOTFILES_LIST

cd

# Backup all files that currently exist into the folder $DOTFILES_OLD, 
# while preserving the directory structure and dereferencing links.
# rsync prints errors for files which don't exist. They can be ignored.
note "Backing up old dotfiles (ignore the errors that rsync generates) into $DOTFILES_OLD..."
mkdir -p $DOTFILES_OLD 
rsync -Razq --copy-links --files-from=$DOTFILES/dotfiles.txt . $DOTFILES_OLD/

# Loop over all dotfiles and create symlinks for all.
note "Copying the new dotfiles..."
while read src
do
    SOURCE=$(readlink -f $DOTFILES/$src)
    if [ ! -d $(dirname $HOME/$src) ]; then
        mkdir -p $(dirname $HOME/$src)
    fi
    rm -f $HOME/$src
    ln -s $SOURCE $HOME/$src
done < $DOTFILES/$DOTFILES_LIST
 
# Vim - Vundle
header "Vim - Install Plugins"
read -p "Do you wish to install the vim plugins? (y/N)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +VundleInstall +qall
fi
echo

# AwesomeWM - Beautiful Themes
header "AwesomeWM - Install Themes"
read -p "Do you wish to install awesome themes? (y/N)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git clone https://github.com/mikar/awesome-themes.git ~/.config/awesome/themes
fi
echo
