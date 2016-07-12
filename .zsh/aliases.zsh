# Neovim 
alias vim='nvim'
# Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -GFh --color=auto'

# Grep colors
alias grep='grep --color=auto'

# Same as above, but in long listing format
alias ll='ls -GFhal --color=auto'

# Pipe output to xclip to put it in the X clipboard so that you can paste it.
alias xclip='xclip -selection c'

# bc - default scale set to 20 digits
alias bc='bc -l'

# ix.io is a CLI pastebin service. Pipe stuff to ixio like
#   $ command | ixio
alias ixio='ix | xclip && xclip -o'

# Do more with less
alias less='less -NRmsx4 '

# Safety Features
alias mv="mv -i" 
alias cp="cp -i" 
alias rm="rm -i" 
alias ln="ln -i" 

