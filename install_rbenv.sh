#!/usr/bin/env bash

# First, clean out any previous Ruby environment/managers:
#   a) sudo apt-get purge ruby-switch
#   b) "deltree" the whole ~/.rvm... subdirectory tree

# install_rbenv.sh
# See https://github.com/rbenv/rbenv

cd ~
mkdir .rbenv/
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

# Optionally, try to compile dynamic bash extension to speed up rbenv.
# Don't worry if it fails; rbenv will still work normally --
cd ~/.rbenv && src/configure && make -C src

# Add ruby-build as an rbenv plugin --
$ mkdir -p "$(rbenv root)"/plugins
$ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# Edit .bashrc to include "$HOME/.rbenv/bin" and ".../shims" at the beginning of PATH --
#   $ echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.bash_profile
#   $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile

# In your .bashrc sequencing, *be sure* that all PATH elements, including those
#  for rbenv, are established correctly *before executing* eval "$(rbenv init -)"
#  in this script...

# Then --
#   Run ~/.rbenv/bin/rbenv init and follow the instructions to set up rbenv integration with your shell.
#   This is the step that will make running ruby "see" the Ruby version that you choose with rbenv.

# To check the overall rbenv installation, use the rbenv-doctor script --
# $ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

# To install a Ruby version -- using the rbenv plugin ruby-build --
# $ rbenv install --list                 # lists all available versions of Ruby
# $ rbenv install 2.5.0                  # installs Ruby 2.5.0 to ~/.rbenv/versions
# Downloading ruby-2.5.0.tar.bz2...
# -> https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.bz2
# Installing ruby-2.5.0...
# Installed ruby-2.5.0 to /home/lorin/.rbenv/versions/2.5.0
# $

# If the above Ruby build throws lib-dependency errors, it's likely that
#  one or more of the following will fix the problem:
#
#    apt-get install autoconf bison build-essential        \
#       libssl-dev libyaml-dev libreadline6-dev zlib1g-dev \
#       libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

# Trouble with irb or pry?  Try installing readline and recompiling Ruby"
#
#     Ubuntu: apt-get install libreadline-dev
