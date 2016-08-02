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
Ident="${shF}  # (LMR version 5.10 of 08/01/2016)"
# Exports global variable DEBUGMODE (value '0'|'1'):
f="$HOME/bin/login/debugmode"
if [ -f $f ]; then
  [ -z "$DEBUGMODE" ] && source $f OFF
fi
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
# Get less's handling of ANSI escape characters under control,
# especially so that things like git diff will dispaly coherently:
export LESS="-Rmi"  # --RAW-CONTROL-CHARS --ignore-case --long-prompt

# Establish the right text editor defaults:
export EDITOR='atom'
export VISUAL='atom'
set -o emacs

# Shell Options --
shopt -s checkwinsize    # Enable:  Check window size after each command and
                         #          update values of LINES/COLUMNS if necessary.
# Glob Shell Options --
#   check these with: $ shopt | grep -i glob
shopt -u dotglob         # Disable: Include filenames beginning with '.'
                         #          in pathname expansion.
shopt -s extglob         # Enable:  Extended pattern matching features are added
                         #          to the default '*', '?' and '[...]' --
                         #          ?(pattern-list) - match zero or one of
                         #                            these given patterns
                         #          *(pattern-list) - match zero or more of...
                         #          +(pattern-list) - match one or more of...
                         #          @(pattern-list) - match one of...
                         #          !(pattern-list) - match anything except...
shopt -u failglob        # Disable: Globs which fail to match file expansion
                         #          report an expansion error.
shopt -s globstar        # Enable:  Pattern '**' used in a pathname expansion
                         #          will match all files and zero or more dirs
                         #          and sub-dirs. If pattern is followed by '/',
                         #          only directories and subdirectories match.
shopt -u globasciiranges # Disable: Range expressions in globbing behave as if
                         #          in the traditional C locale for comparisons.
shopt -s nocaseglob      # Enable:  Matches filenames case-insensitively.
shopt -u nullglob        # Disable: Allows patterns which match no files to
                         #          expand to a null-string '', rather than
                         #          returning the literal pattern string.

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

# DCLfunction definitions:
f="$HOME/bin/login/DCL-magik"
[ -f "$f" ] && source $f

# Logical-name definitions:
f="$HOME/bin/login/logicals"
[ -f "$f" ] && source $f

# Alias definitions:
f="$HOME/bin/login/aliases"
[ -f "$f" ] && source $f

# git support functions:
f="$HOME/bin/login/git-magik"
[ -f "$f" ] && source $f

# Alias definitions:
f="$HOME/bin/login/ANSI-magik"
[ -f "$f" ] && source $f

# Magic pygmentize function definitions:
f="$HOME/bin/login/pygmentize-magik"
[ -f "$f" ] && source $f

# doc function:
f="$HOME/bin/login/doc_function"
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

# Magic path* function definitions --
# do this *before* RVM setup! ...
f="$HOME/bin/login/path-magik"
[ -f "$f" ] && source $f

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
  # Set "latest" ruby with corresponding gemsets --
  # change this with new RVM installs --
  rvm use ${RUBY_DEFAULT_VERSION}          # just to...
  rvm gemset use bootcamp                  # get started...
  curRuby=$( rvm current )
  echo "Using Ruby version: ${curRuby}   # (rvm current/RUBY_VERSION)"
  alias rvmset="source $f"
  alias rvmupd='rvm get stable'
  alias rvmrel='rvm reload'
  # Use '' for rvmgem, not ""a, want to do $GEM_HOME at cmd-runtime:
  alias rvmgem='GEM_PATH=$GEM_HOME gem list'
  # Add 'current-ruby' info to prompt's preceding-where line:
  SetPrompt '`pwd`' ' -- {`rvm current`}' ' -- [clock `date +%T`]'
else
  # Default Ruby version, system-wide install --
  #    $ sudo apt-add-repository ppa:brightbox/ruby-ng
  #    $ sudo apt-get update
  #    $ sudo apt-get install ruby2.x ruby2.x-dev ruby-switch
  setruby     # function setruby is based on ruby-switch
fi
# -----------------------------

# --- Supercede RVM's cd function here...
#     (RVM's own cd supercedes bash built-in cd, and
#      breaks things like Atom.io's package manager)
# cd and where functions:
f="$HOME/bin/login/cd-magik"
[ -f "$f" ] && source $f

# cleanpath is defined in aliases; exeucte it to remove any
# accumulated duplicates from PATH, and show the PATH here:
export PATH=$( perfectpath ${RUBY_DEFAULT_VERSION} )
cleanpath ; path

# =========================
# Show your own aliases & logicals at login-time --
# currently, would have to export DEBUGMODE='2' manually,
# as script debugmode doesn't know how to set this value yet...
if [ "$DEBUGMODE" \> "1" ]; then
  alias -p   # display aliases
  logicals   # display logical names
  echo -e "\n%Ruby-I, aliases set for [1mRuby v${RUBY_DEFAULT_VERSION}[0m"
fi
# =========================

# exit 0
