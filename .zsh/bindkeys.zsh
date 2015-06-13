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
