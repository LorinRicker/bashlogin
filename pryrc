# ~/.pryrc -> ~/bin/login/pryrc -- version 2.0 of 04/30/2017

Pry.config.editor = "atom"

# Ruby debugger --> pry and byebug...

# Requires gems "pry" and "pry-byebug" for Ruby v2.x (+)
#
#    $ sudo gem install pry
#    $ sudo gem install pry-byebug
#    $ sudo chmod -R 755 /var/lib/gems
#    $ sudo chmod    755 /usr/local/bin/pry
#
# When pry-byebug is installed, pry uses it.
#
# Also note that, according to github.com/deivid-rodriguez/pry-byebug/issues/45
#   pry-nav is obsolete on Ruby v2.x...
#   so don't install it, or uninstall if necessary;
#   e.g. -> $ sudo gem uninstall pry-nav --force)
#
# Ruby v2.2 and v2.3 (and up):
#  DO NOT install Gems byebug, pry-debugger or pry-nav
#  (pry-debugger and pry-nav are ONLY for Ruby versions <= 1.9.x)
#

# Use in a Ruby script/program is (typically after):
#
#    optparse = OptionParser.new { |opts|
#      opts.on ...
#    }.parse!  # leave residue-args in ARGV
#
#  ####################################
#      if options[:debug] >= DBGLVL3  #
#        require 'pry'                #
#        binding.pry                  #
#      end                            #
#  ####################################
#

## puts ".pryrc -- loading..."

# Load and execute a Ruby source file
def fl(fn)
  fn += '.rb' unless fn =~ /\.rb/
  @@recent = fn
  load "#{fn}"
end

# Reload and excute the most recently loaded ruby source file
def rl
  fl(@@recent)
end

# List all installed gems
def glist
  puts %x{ gem list }
end

# List gems matching search parameter
def gl2(str)
  puts %x{ gem list | sort | grep #{str} }
end

if defined?(PryByebug)
  ## Pry.commands.alias_command 'xw',  'watch'        # set a watchpoint [EXPRESSION]
  Pry.commands.alias_command 'go', 'continue'     # "go", continue to next breakpoint or end-of-program
  Pry.commands.alias_command 'n',  'next'         # execute current line (step-over methods/blocks)
  Pry.commands.alias_command 's',  'step'         # execute into current method or block
  Pry.commands.alias_command 'xx', 'exit'         # Pops the previous binding (does not exit program)
  Pry.commands.alias_command 'q',  'exit-program' # exit back to $-prompt, same as '!!!'
  Pry.commands.alias_command 'xf', 'finish'       # run to end-of-program (no breakpoints)
  ## The following aliases require that pry-byebug gem is installed too:
  ## Pry.commands.alias_command 'xb',  'break'        # set a breakpoint line# [--condition]
  puts "  ###################################################"
  puts "  # Command aliases:                                #"
  puts "  #   'n'=next (over), 's'=step (into),             #"
  puts "  #   'go'=continue (to next breakpoint or end),    #"
  puts "  #   'xf'=finish, 'q'|'xx'=exit-program            #"
  puts "  #   '$'=show-source, '@'=whereami, '?'=show-doc   #"
  puts "  # Use native byebug for:                          #"
  puts "  #   'break', 'watch', 'backtrace' (etc.)          #"
  puts "  ###################################################"
else
  puts '%pryrc-w-missingGem, must install pry-byebug (with pry & pry-nav) for debugger commands'
end

# Hit <Enter> to repeat last command
Pry::Commands.command /^$/, "Repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end

Pry.config.prompt = [proc { "pry> " },  # byebug overrides this with its own "input> "
                     proc { "   | " }]

puts ".pryrc -- loaded..."
