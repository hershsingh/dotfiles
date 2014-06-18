#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignorespace:ignoredups:erasedups
export EDITOR=vim
export BROWSER=firefox

#Pipe output to xclip to put it in the X clipboard so that you can copy-paste
alias xclip='xclip -selection c'

# TexLive Network Installation
export PATH=$PATH:/usr/local/texlive/2013/bin/i386-linux

#invoke bc with default scale set to 20 digits
alias bc='bc -l'

alias ixio='ix | xclip && xclip -o'

alias grep='grep --color=auto' #colored grep
alias ls='ls --color=auto' #colored ls
export LESS="-R" # colored less
export SUDO_EDITOR="/usr/bin/vim -p -X"

alias pacfind='sudo pacman -Ss'
alias pacput='sudo pacman -S'
alias pacputu='sudo pacman -U'

# Safety Features
# By default "mv" overwrites existing files without asking! Correct that.
alias mv="mv -i" 
alias cp="cp -i" 
alias rm="rm -i" 
alias ln="ln -i" 

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

#for colored man pages using "less"
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
# https://bbs.archlinux.org/viewtopic.php?pid=1068202#p1068202

PS1="\[\033[0;37m\]╾─\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\u'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\[\033[0;37m\]─╼ \[\033[0m\]"

PS3='> '
PS4='+ '

# Impersonate another non-reparenting WM recognized by Java VM. Required to make MATLAB work.
# wmname LG3D
#to use system anti-aliased fonts and make swing use the GTK look and feel:
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
[ -n "$RANGER_LEVEL" ] && PS1="$PS1"'[in ranger] '
