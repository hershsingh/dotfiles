
# Detect empty enter, execute git status if in git dir
magic-enter () {
        if [[ -z $BUFFER ]]; then
          if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
            echo -ne '\n'
            git status 
          fi
          zle accept-line
        else
          zle accept-line
        fi
}
zle -N magic-enter
bindkey "^M" magic-enter

findhere() {
# Does a quasi fuzzy search in the current directory.
    STRING=.*$(echo $@ | sed 's/\s/\.\*/g').*
    find . -iregex "$STRING" | less -N
}

function aurafind() {
# Searches both the arch official repos and the AUR for a package.
    aura -Ss $1; aura -As $1;
} 
