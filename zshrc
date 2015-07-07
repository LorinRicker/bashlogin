#!/usr/bin/env zsh

# ~/bin/login/zshrc
# Lorin Ricker -- personal version

# Referenced by SYMBOLIC LINK: $HOME/.zshrc
# Setup:  $ ln -sv $HOME/bin/login/zshrc $HOME/.zshrc

# Z Shell has autocomplete plugins - use them --
# see: github.com/robbyrussell/oh-my-zsh
# and: github.com/robbyrussell/oh-my-zsh/wiki/Plugins
# (other contenders: autojump )
plugins=( ruby rvm git atom sublime sudo )

shF="$HOME/bin/login/zshrc"
Ident="${shF}  # (LMR version 1.0 of 07/07/2015)"
[ "$DEBUGMODE" = "1" ] && echo "%zshrc:login-I, ${Ident}"
