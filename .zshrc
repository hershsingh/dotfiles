source ~/.zsh/colors.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/agnoster.zsh-theme
source ~/.zsh/completion.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/bindkeys.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/history.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey -v
export KEYTIMEOUT=1

zle-keymap-select () {
  if [ $KEYMAP = vicmd ]; then
    if [[ $TMUX = '' ]]; then
      echo -ne "\033]12;Red\007"
    else
      printf '\033Ptmux;\033\033]12;red\007\033\\'
    fi
  else
    if [[ $TMUX = '' ]]; then
      echo -ne "\033]12;Grey\007"
    else
      printf '\033Ptmux;\033\033]12;grey\007\033\\'
    fi
  fi
}
zle-line-init () {
  zle -K viins
  echo -ne "\033]12;Grey\007"
}
zle -N zle-keymap-select
zle -N zle-line-init

# If not in tmux already, run tmux
if [ -z "$TMUX" ]; then
    tmux
fi                     
