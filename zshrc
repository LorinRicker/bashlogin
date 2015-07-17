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
Ident="${shF}  # (LMR version 1.1 of 07/17/2015)"
[ "$DEBUGMODE" = "1" ] && echo "%zshrc:login-I, ${Ident}"

# Customizations directory --
ZSH_CUSTOM=$HOME/bin/login    # export?

# code goes here...

# export  PS1="%{${bg[white]}${fg[red]}%}%m:%1~/ %{${bg[white]}${fg[black]}%}·zsh·%# "
export  PS1="%m:%1~/ ·zsh·$ "
export RPS1=" [%T]"

unsetopt NOMATCH BAD_PATTERN
setopt   HIST_VERIFY APPEND_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
setopt   HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_EXPIRE_DUPS_FIRST
setopt   HIST_IGNORE_SPACE HIST_NO_FUNCTIONS HIST_NO_STORE
HISTSIZE=1024
SAVEHIST=1024
HISTFILE=~/.zsh_history

# path adjustments, esp. for RVM --
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
