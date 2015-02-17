# Currently this path is appendend to dynamically when picking a ruby version
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl:/usr/local/texlive/2013/bin/x86_64-linux:/home/hersh/.gem/ruby/2.0.0/bin:/home/hersh/.gem/ruby/2.1.0/bin

# Setup terminal, and turn on colors
export TERM=rxvt-unicode-256color
export CLICOLOR=1
#export LSCOLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
# export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'
export EDITOR='vim'

# Use system anti-aliased fonts and make swing use the GTK look and feel:
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# Preferred applications
export EDITOR=vim
export BROWSER=firefox
export SUDO_EDITOR="/usr/bin/vim -p -X"
