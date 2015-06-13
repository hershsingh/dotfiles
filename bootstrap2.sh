DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_OLD=$HOME/dotfiles_old
THIS_SCRIPT=$(basename $0)


echo directory is $DOTFILES
cd $DOTFILES

# find -v -type d -exec mkdir --parents -- "~"/{} \;
find . -type d -not -iwholename '*.git*' -exec mkdir --parents -- ~/{} \;
find . -type f -not -iwholename '*.git/*' -exec ln --force --symbolic -- $DOTFILES/{} ~/{} \;
