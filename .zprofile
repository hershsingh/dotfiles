## Start X on login

# Don't start X within tmux.
if [[ -z ${TMUX} ]] ; then
    # No $DISPLAY means X is not running in this terminal.
    # $XDG_VTNR is the current tty number.
    # Change '1' to some 'x' to start X at 'ttyx'.
    if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 ]]; then
        exec startx
    fi 
fi
