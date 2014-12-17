#!/usr/bin/env bash

# ~/bin/login/bash_profile
# Lorin Ricker -- personal version

# Referenced by SYMBOLIC LINK: << none! >>
# Setup:  See $HOME/projects/logins/Login_Setup for details

shF="$HOME/bin/login/bash_profile"
Ident="${shF}  # (LMR version 1.02 of 12/16/2014)"
[ "$DEBUGMODE" = "1" ] && echo "%bash_profile:login-I, ${Ident}"

# ############################################################################
# THIS FILE IS EMPTY AND NOT USED -- see ~/.profile -> $HOME/bin/login/profile
# ############################################################################

# see /usr/share/doc/bash/examples/startup-files (in package bash-doc) for examples

# A non-login (non-interactive) shell just sources ~/.bashrc directly

# A login (interactive) shell first executes (sources):
#   /etc/profile
# and then searches/sources the following in this order:
#   ~/.bash_profile
#   ~/.bash_login
#   ~/.profile

# Personal (LMR) convention/practice is to remove (delete) both ~/.bash_* files
# and to set ~/.profile as a symlink to point to $HOME/bin/login/profile --
# see $HOME/projects/login/Login_Setup for details.
