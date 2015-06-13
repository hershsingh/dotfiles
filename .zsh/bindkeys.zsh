# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

## Emacs keybindings
#bindkey "^K"      kill-whole-line                      # ctrl-k
bindkey "^R"      history-incremental-search-backward  # ctrl-r
#[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
#bindkey "^E"      beginning-of-line                    # ctrl-a  
#bindkey "^I"      end-of-line                          # ctrl-e
#bindkey "[B"      history-search-forward               # down arrow
#bindkey "[A"      history-search-backward              # up arrow
#bindkey "^D"      delete-char                          # ctrl-d
#bindkey "^F"      forward-char                         # ctrl-f
#bindkey "^B"      backward-char                        # ctrl-b
#bindkey -e   # Default to standard emacs bindings, regardless of editor string

# Add missing vim hotkeys
# fixes backspace deletion issues
# http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo
#bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey '^F'      vi-forward-word                         # ctrl-f
#bindkey '^I'      end-of-line                          # ctrl-e


# History substring search plugin
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
