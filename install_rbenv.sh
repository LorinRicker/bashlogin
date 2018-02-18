#!/usr/bin/env bash

# install_rbenv.sh
# See https://github.com/rbenv/rbenv

cd ~
mkdir .rbenv/
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

# Optionally, try to compile dynamic bash extension to speed up rbenv.
# Don't worry if it fails; rbenv will still work normally:
cd ~/.rbenv && src/configure && make -C src

# Add ruby-build as an rbenv plugin
$ mkdir -p "$(rbenv root)"/plugins
$ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build


# Edit .bashrc to include "$HOME/.rbenv/bin" at the beginning of PATH --
#   $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile

# Then --
#   Run ~/.rbenv/bin/rbenv init and follow the instructions to set up rbenv integration with your shell.
#   This is the step that will make running ruby "see" the Ruby version that you choose with rbenv.
