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
Ident="${shF}  # (LMR version 6.03 of 04/25/2018)"
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
   # return
   ;;
esac

# show Linux version, etc.
uname -noprsv | grep Linux  # highlight...

# -----------------------------
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

# Make less more friendly for non-text input files, see lesspipe(1);
# also get less's handling of ANSI escape characters under control,
# especially so that things like git diff will dispaly coherently:
export LESS='Rmi'  # --RAW-CONTROL-CHARS --ignore-case --long-prompt
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

# Function definitions:
f="$HOME/bin/login/functions-logicals"
[ -f "$f" ] && source $f

# Function definitions:
f="$HOME/bin/login/functions-ResetGlobbing"
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
# Diagnostic:
# echo "Original PATH = $PATH"
# Initialize my own PATH, then remove any
# accumulated duplicates, and show it here:
export PATH=$( perfectpath ${RUBY_CURRENT_VERSION} )
export PATH=$( pathclean "$PATH" )
path

# Get the correct PATH straightened out and established
#   *before* setting-up rbenv (or others)...

# Magic ruby* function definitions --
# f="$HOME/.rbenv/bin/rbenv"
# if [ -f "$f" ]; then
#   echo "%bashrc-I, rbenv init..."
#   eval "$(rbenv init -)"
# fi
f="$HOME/bin/login/ruby-magik"
[ -f "$f" ] && source $f
# -----------------------------

# --- Supercede RVM's cd function here...
#     (RVM's own cd supercedes bash built-in cd, and
#      breaks things like Atom.io's package manager)
# cd and where functions:
f="$HOME/bin/login/cd-magik"
[ -f "$f" ] && source $f

# =========================
# Show your own aliases & logicals at login-time --
# currently, would have to export DEBUGMODE='2' manually,
# as script debugmode doesn't know how to set this value yet...
if [ "$DEBUGMODE" \> "1" ]; then
  alias -p   # display aliases
  logicals   # display logical names
  echo -e "\n%Ruby-I, aliases set for [1mRuby v${RUBY_CURRENT_VERSION}[0m"
fi
# =========================

# exit 0
