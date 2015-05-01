#!/usr/bin/env bash

# ~/bin/login/bashrc
# Lorin Ricker -- personal version

# Referenced by SYMBOLIC LINK: $HOME/.bashrc
# Setup:  $ ln -sv $HOME/bin/login/bashrc $HOME/.bashrc
# Non-interactive (non-login) shell: Sourced by bash(1).
# Interactive (login) shell: Sourced by .profile (or .bash_profile or .bash_login).

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
# see /usr/share/doc/bash/examples/startup-files (in package bash-doc) for examples
# =================================================================================
# To make PATH fix-ups stick, declare these in .profile -> ~/bin/login/profile ...
# =================================================================================

shF="$HOME/bin/login/bashrc"
Ident="${shF}  # (LMR version 5.00 of 05/01/2015)"
[ "$DEBUGMODE" = "1" ] && echo "%bashrc:login-I, ${Ident}"

# If not running interactively, don't do anything
##[ -z "$PS1" ] && return

case $- in
  *i* ) # Interactive... (continue)
   ;;
  * )   # Not interactive (or login), nothing else to do...
   return
   ;;
esac

# -----------------------------
set -o emacs
export EDITOR='subl'
export VISUAL='subl'

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
export LESS='mi'
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If this is an xterm set the TITLE-BAR to user@host:dir
case "$TERM" in
  xterm* | rxvt* )
    PROMPT_COMMAND='echo -en "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"' #LMR
    ## PROMPT_COMMAND='echo -en "\033]0;${HOSTNAME}\007"'
    ;;
  *)
    ;;
  esac

# -----------------------------
# Functions (2) to initialize and manage debug and trace modes:
[ -z "$DEBUGMODE" ] && declare -ix DEBUGMODE=0
f="$HOME/bin/login/debugmode"
[ -f "$f" ] && source $f

# Function definitions:
f="$HOME/bin/login/functions"
[ -f "$f" ] && source $f

# Magic path* function definitions:
f="$HOME/bin/login/path-magik"
[ -f "$f" ] && source $f

# Magic pygmentize function definitions:
f="$HOME/bin/login/pygmentize-magik"
[ -f "$f" ] && source $f

# DCLfunction definitions:
f="$HOME/bin/login/DCLfunctions"
[ -f "$f" ] && source $f

# Logical-name definitions:
f="$HOME/bin/login/logicals"
[ -f "$f" ] && source $f

# doc function:
f="$HOME/bin/login/doc_function"
[ -f "$f" ] && source $f

# tweak_path functions:
f="$HOME/bin/login/tweak_path"
[ -f "$f" ] && source $f

# Alias definitions:
f="$HOME/bin/login/aliases"
[ -f "$f" ] && source $f

# -----------------------------
# Enable programmable completion features (you don't need to enable this, if it's
# already enabled in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc).
f="/etc/bash_completion"
[ -f "$f" ] && source $f

# -----------------------------
# Disable/modify laptop's touchpad (tpad & distouchpad defined in functions):
tpad OFF 1>/dev/null 2>/dev/null ; tpad show 1>/dev/null 2>/dev/null

# -----------------------------

#  == RVM ===
#    Note: For Ruby development work, install Ruby using the great
#          Ruby enVironment Manager (RVM, http://rvm.io -- and see
#          http://rvm.io/rvm/install for help):
#
#          $ \curl -L https://get.rvm.io | bash -s stable
#
#          Be sure that .bashrc -> ~bin/login/bashrc contains this
#          line at its end, or execute this command interactively:
#
#            source $HOME/.rvm/scripts/rvm
#
#          Logout and then login to activate rvm commands, then
#          install Ruby version(s) of your choice:
#
#          $ rvm install 1.9.3     # Note! These Ruby installs may
#          $ rvm install 2.1       #       take 'a long time'!
#
#          Don't forget Ruby online documentation:
#
#          $ rvm docs generate-ri
#
#          Finally, set your desired Ruby version for use:
#
#          $ rvm use --default 2.1
#          $ rvm current   # to see/confirm
#  == end RVM ===

# Ruby Version Manager -- RVM setup:
f="$HOME/.rvm/scripts/rvm"
if [ -f "$f" ]; then
  source $f
  rvm gemset use bootcamp     # just to get started...
  curRuby=$( rvm current )
  echo "Using Ruby version: ${curRuby}   # (rvm current/RUBY_VERSION)"
  alias rvmset="source $f"
  alias rvmupd='rvm get stable'
  alias rvmrel='rvm reload'
  # Use '' for rvmgem, not ""a, want to do $GEM_HOME at cmd-runtime:
  alias rvmgem='GEM_PATH=$GEM_HOME gem list'
  # Add 'current-ruby' info to prompt's preceding-where line:
  SetPrompt '`pwd`' ' {`rvm current`}'
else
  SetPrompt '`pwd`'
fi
# -----------------------------

# git support functions:
f="$HOME/bin/login/git-magik"
[ -f "$f" ] && source $f

# --- Supercede RVM's cd function here...
#     (RVM's own cd supercedes bash built-in cd, and
#      breaks things like Atom.io's package manager)
# cd and where functions:
f="$HOME/bin/login/cd-magik"
[ -f "$f" ] && source $f

# cleanpath is defined in aliases; exeucte it to remove any
# accumulated duplicates from PATH, and show the PATH here:
cleanpath ; path

# exit 0
