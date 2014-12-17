#!/usr/bin/env bash

# ~/bin/login/profile
# Lorin Ricker -- personal version

# Referenced by SYMBOLIC LINK: $HOME/.profile
# Setup:  $ ln -sv $HOME/bin/login/profile $HOME/.profile
# Executed by bash(1) for interactive/login shells.

shF="$HOME/bin/login/profile"
Ident="${shF}  # (LMR version 1.02 of 12/16/2014)"
[ "$DEBUGMODE" = "1" ] && echo "%profile:login-I, ${Ident}"

# see /usr/share/doc/bash/examples/startup-files (in package bash-doc) for examples

# A non-login (non-interactive) shell just sources ~/.bashrc directly

# A login (interactive) shell first executes (sources):
#   /etc/profile
# and then searches/sources the following in this order:
#   ~/.bash_profile
#   ~/.bash_login
#   ~/.profile

# The default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 077

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# Don't put duplicate lines in the history, and ignore same successive entries:
export HISTCONTROL=ignoreboth
export IGNOREEOF=2   # at least two Ctrl/D's to exit shell

# PATH environment variable declared here --
#   (see http://www.troubleshooters.com/linux/prepostpath.htm) --

export CDPATH=.:~:~/anchor:~/scratch:~/projects  #LMR
export PATH=~/bin:$PATH                          #LMR
## echo $PATH                                       # (debug)

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
