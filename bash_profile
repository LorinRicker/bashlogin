#!/usr/bin/env bash_profile

# ~/bin/login/bash_profile
# Referenced by SYMBOLIC LINK: $HOME/.bash_profile
#  setup:  $ ln -sv $HOME/bin/login/bashrc $HOME/.bash_profile
# Executed by bash(1) for non-login shells.

# Lorin Ricker -- personal version
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

shF="$HOME/bin/login/bash_profile"
Ident="${shF}  # (LMR version 1.01 of 03/25/2014)"
[ "$DEBUGMODE" = "1" ] && echo "%bash_profile:login-I, ${Ident}"

# PATH environment variable declared here --
#   (see http://www.troubleshooters.com/linux/prepostpath.htm) --

export CDPATH=.:~:~/anchor:~/scratch:~/projects  #LMR
export PATH=~/bin:$PATH                          #LMR
## echo $PATH                                       # (debug)

# Don't put duplicate lines in the history, and ignore same successive entries:
export HISTCONTROL=ignoreboth
export IGNOREEOF=2   # at least two Ctrl/D's to exit shell

# .bashrc is only read by a shell that's both interactive and non-login,
# so force its execution here for a login/interactive shell...
##[[ -r ~/.bashrc ]] && . ~/.bashrc
