#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=vim

# TexLive Network Installation
export PATH=$PATH:/usr/local/texlive/2013/bin/i386-linux

alias ixio='ix | xclip && xclip -o'

findhere() {
    STRING=.*$(echo $@ | sed 's/\s/\.\*/g').*
    find . -iregex "$STRING" | less 
}

function aurafind() {
  aura -Ss $1; aura -As $1;
} 

# use like $ wakeat 'tomorrow 6:30'
function wakeat() {
    #echo $(echo \'$1\')
    sudo rtcwake --mode no --local --time $(date +%s -d "$1")
}

export WINEPREFIX=/home/hersh/.wine/win32
export WINEARCH=win32

export PATH=$PATH:/home/hersh/bin/:/home/hersh/.gem/ruby/2.0.0/bin:/home/hersh/.gem/ruby/2.1.0/bin

# This is to fix a problem with the LESS pager, which sometimes issues the warning: 
#   Warning: Terminal is not fully functional.
export TERM=rxvt-unicode-256color

alias less='less -NRmsx4 '
alias mousereload='sudo rmmod psmouse; sudo modprobe psmouse'
alias ecfs='ecryptfs-simple '
alias wget_images='wget -r -l1 -H -t1 -nd -N -np -A.jpeg,.jpg -erobots=off'
alias noteftp='lftp ftp://192.168.43.1:3721'
alias notetalk='sudo netctl start wlan0-ES_1469 && lftp ftp://192.168.43.1:3721'
alias noteshut='sudo netctl stop wlan0-ES_1469'
alias susy='sudo systemctl '
alias ls='ls --color=auto'
alias todo='urxvt -e bash -ic "vim ~/notes/do_now/do_now.txt"'
#alias todo='vim ~/notes/todo.txt'
alias kikita='vim ~/notes/kikita.txt'
alias wordlist='vim ~/notes/wordlist.txt'
alias ipyqt='ipython2 qtconsole --pylab=inline'
alias ipy='ipython2 --gui=wx'

alias msword='WINEPREFIX=~/.win32 wine "/home/hersh/.win32/drive_c/Program Files/Microsoft Office/Office14/WINWORD.EXE"'
alias wgetimages='wget -r -l1 -H -np -nd -A.jpg'

# https://bbs.archlinux.org/viewtopic.php?pid=1068202#p1068202

[ -n "$RANGER_LEVEL" ] && PS1="$PS1"'[in ranger] '
