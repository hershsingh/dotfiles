source ~/.zsh/colors.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/agnoster.zsh-theme
source ~/.zsh/completion.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/bindkeys.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/history.zsh

## Plugins
source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

AIS_USER="hersh"
mount_internal_ntfs_partition() {
    # This needs to be executed as root, but will allow $AIS_USER to read/write.
    gpasswd -a $AIS_USER disk
    mkdir -p /mnt/c /mnt/d
    chown $AIS_USER:$AIS_USER /mnt/c /mnt/d
    mount -t ntfs-3g -o uid=$AIS_USER,gid=$AIS_USER,umask=0022 /dev/sda3
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
