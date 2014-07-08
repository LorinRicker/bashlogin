#!/usr/bin/env bash

# ~/bin/login/bashrc
# Referenced by SYMBOLIC LINK: $HOME/.bashrc
#  setup:  $ ln -sv $HOME/bin/login/bashrc $HOME/.bashrc
# Executed by bash(1) for non-login shells.

# Lorin Ricker -- personal version
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples
# ==========================================================================================
# To make PATH fix-ups stick, declare these in .bash_profile -> ~/bin/login/bash_profile ...
# ==========================================================================================

shF="$HOME/bin/login/bashrc"
Ident="${shF}  # (LMR version 4.11 of 06/26/2014)"
[ "$DEBUGMODE" = "1" ] && echo "%bashrc:login-I, ${Ident}"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Establish PATH *before* doing RVM Ruby setup:
f="$HOME/.bash_profile"
[ -f "$f" ] && source $f

# -----------------------------

# -----------------------------
set -o emacs

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# -----------------------------
# Identify the chroot you work in (used in the prompt below):
if [ -z "$dchroot" ] && [ -r /etc/dchroot ]; then
  dchroot=$(cat /etc/dchroot)
  echo "dchroot: '$dchroot'"
else
  dchroot=""
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal has the capability;
# turned off by default to not distract the user: the focus in a terminal
# window should be on the output of commands, not on the prompt.
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48 (ISO/IEC-6429).
  # (Lack of such support is extremely rare, and such a case would tend to
  #  support setf rather than setaf.)
      color_prompt=yes
    else
      color_prompt=
    fi
fi

# Setup prompt string -- I like simple "node$ " style (LMR):
if [ "$color_prompt" = yes ]; then
# PS1='${dchroot:+($dchroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  PS1='${dchroot:+($dchroot)}\[\033[01;32m\]\h\[\033[00m\]\$ '  #LMR
else
# PS1='${dchroot:+($dchroot)}\u@\h:\w\$ '
  PS1='${dchroot:+($dchroot)}\[\033[35m\]\ndir: \w\[\033[00m\]\n\[\033[31m\]\h\[\033[00m\]\$ '  #LMR
fi
unset color_prompt force_color_prompt dchroot

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
[ -f "$f" ] && . $f

# Function definitions:
f="$HOME/bin/login/functions"
[ -f "$f" ] && . $f

# DCLfunction definitions:
f="$HOME/bin/login/DCLfunctions"
[ -f "$f" ] && . $f

# Logical-name definitions:
f="$HOME/bin/login/logicals"
[ -f "$f" ] && . $f

# doc function:
f="$HOME/bin/login/doc_function"
[ -f "$f" ] && . $f

# tweak_path functions:
f="$HOME/bin/login/tweak_path"
[ -f "$f" ] && . $f

# Alias definitions:
f="$HOME/bin/login/aliases"
[ -f "$f" ] && . $f

# -----------------------------
# Enable programmable completion features (you don't need to enable this, if it's
# already enabled in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc).
f="/etc/bash_completion"
[ -f "$f" ] && . $f

# -----------------------------
# Disable/modify laptop's touchpad (tpad & distouchpad defined in functions):
tpad OFF 1>/dev/null 2>/dev/null ; tpad show 1>/dev/null 2>/dev/null

# -----------------------------

## Ruby setup:  <<<--- Now obsolete, using RVM (see below):
## f="$HOME/bin/login/ruby_setup"
## [ -f "$f" ] && . $f

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
[ -f "$f" ] && source $f && \
  echo "Using Ruby version: $( rvm current )   # (rvm current/RUBY_VERSION)"

# -----------------------------

# cleanpath is defined in aliases; exeucte it to remove any
# accumulated duplicates from PATH, and show the PATH here:
cleanpath ; path

# exit 0
