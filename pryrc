# ~/.pryrc -> ~/bin/login/pryrc -- version 1.5 of 02/03/2015

Pry.config.editor = "subl"

# Ruby debugger --> pry and byebug...
# Requires gems "pry", "pry-nav" and "pry-byebug"
# (if pry-nav and pry-byebug are installed, pry uses them) --
#
# Use in a Ruby script/program is (typically after):
#
#    optparse = OptionParser.new { |opts|
#      opts.on ...
#    }.parse!  # leave residue-args in ARGV
#
#####################################
#    if options[:debug] >= DBGLVL3  #
#      require 'pry'                #
#      binding.pry                  #
#    end                            #
#####################################
#

Pry.commands.alias_command 'b',  'break'        # set a breakpoint line# [--condition]
Pry.commands.alias_command 'w',  'watch'        # set a watchpoint [EXPRESSION]
Pry.commands.alias_command 'go', 'continue'    # "go", continue to next breakpoint or end-of-program
Pry.commands.alias_command 'n',  'next'         # execute current line (step-over methods/blocks)
Pry.commands.alias_command 's',  'step'         # execute into current method or block
Pry.commands.alias_command 'f',  'finish'       # run to end-of-program (no breakpoints)
Pry.commands.alias_command 'q',  'exit'         # Pops the previous binding (does not exit program)
Pry.commands.alias_command '$',  'exit-program' # exit back to $-prompt, same as '!!!'

# Hit <Enter> to repeat last command
Pry::Commands.command /^$/, "Repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end

Pry.config.prompt = [proc { "pry> " },  # byebug overrides this with its own "input> "
                     proc { "   | " }]
