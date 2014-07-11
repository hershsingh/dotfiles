#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignorespace:ignoredups:erasedups

# Preferred applications
export EDITOR=vim
export BROWSER=firefox
export SUDO_EDITOR="/usr/bin/vim -p -X"

# Pipe output to xclip to put it in the X clipboard so that you can paste it.
alias xclip='xclip -selection c'

# PATH variable #
# TexLive Network Installation
export PATH=$PATH:/usr/local/texlive/2013/bin/x86_64-linux
# Ruby Gems
export PATH=$PATH:/home/hersh/.gem/ruby/2.0.0/bin:/home/hersh/.gem/ruby/2.1.0/bin

# bc - default scale set to 20 digits
alias bc='bc -l'

# ix.io is a CLI pastebin service. Pipe stuff to ixio like
#   $ command | ixio
alias ixio='ix | xclip && xclip -o'

# More Colors!
alias grep='grep --color=auto' #colored grep
alias ls='ls --color=auto' #colored ls
export LESS="-R" # colored less

# Do more with less
alias less='less -NRmsx4 '

# for colored man pages using "less"
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

# Make life with Pacman easier
alias pacfind='sudo pacman -Ss'
alias pacput='sudo pacman -S'

# Safety Features
alias mv="mv -i" 
alias cp="cp -i" 
alias rm="rm -i" 
alias ln="ln -i" 

# This is to fix a problem with the LESS pager, which sometimes issues the warning: 
#   Warning: Terminal is not fully functional.
export TERM=rxvt-unicode-256color

# Some random aliases

# Reload the mouse module. Fixes random issues with the mouse.
alias mousereload='sudo rmmod psmouse && sudo modprobe psmouse'

# Download all images on a page. Usage
#   $ wget_images http://www.example.com/index.html
alias wget_images='wget -r -l1 -H -t1 -nd -N -np -A.jpeg,.jpg -erobots=off'

# Bash Prompts:
#   PS1 - Default interaction prompt
#   PS2 – Continuation interactive prompt
#   PS3 – Prompt used by “select” inside shell script
#   PS4 – Used by “set -x” to prefix tracing output
PS1="\[\033[0;37m\]╾─\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\u'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\[\033[0;37m\]─╼ \[\033[0m\]"
PS2='\[\033[0;37m\]─╼ \[\033[0m\]'
PS3='> '
PS4='+ '
# Remember if shell is inside ranger file manager
[ -n "$RANGER_LEVEL" ] && PS1="$PS1"'[in ranger] '

# Impersonate another non-reparenting WM recognized by Java VM. Required to make MATLAB work with AwesomeWM.
# wmname LG3D

# Use system anti-aliased fonts and make swing use the GTK look and feel:
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

mount_internal_ntfs() {
# $ mount_internal_ntfs /dev/sda3 as hersh
# This needs to be executed as root, but will allow user $3 to read/write.
# User needs to be a member of disks group
# gpasswd -a $AIS_USER disk
# FIX THIS.
    MOUNTDIR=/media/"$(blkid -s LABEL -o value $1)"
    sudo sh -c "mkdir -p $MOUNTDIR; chown $3 $MOUNTDIR; mount -t ntfs-3g -o uid=$3,gid=$3,umask=0022 $1 $MOUNTDIR"
}

findhere() {
# Does a quasi fuzzy search in the current directory.
    STRING=.*$(echo $@ | sed 's/\s/\.\*/g').*
    find . -iregex "$STRING" | less -N
}

function aurafind() {
# Searches both the arch official repos and the AUR for a package.
    aura -Ss $1; aura -As $1;
} 

function wakeat() {
# Wakes the computer at a given time.
# Usage:
#   $ wakeat 'tomorrow 6:30'
    sudo rtcwake --mode no --local --time $(date +%s -d "$1")
}
