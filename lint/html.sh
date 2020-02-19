#!/bin/sh
test -f "$1" || exit
curl -s -F laxtype=yes -F parser=html5 -F level=error -F out=gnu -F doc=@$1 "https://validator.nu" |
sed 's,^.*":,'"$1:"','

# Taken from:
# https://github.com/kaihendry/vim-html5/blob/master/ftplugin/html.vim
#
# Also: makeformat is in ~/dotfiles/vim/bundles/mine/ftplugin/html.vim
#       taken from https://github.com/kaihendry/vim-html5/blob/master/ftplugin/html.vim
