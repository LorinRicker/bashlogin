# ~/.pryrc -> ~/bin/login/pryrc -- version 1.3 of 11/14/2014

Pry.config.editor = "subl"
Pry.commands.alias_command 'q', 'exit'

# Requires gems "pry", "pry-nav" and "pry-byebug"
# (if pry-nav and pry-byebug are installed, pry uses them) --
#
# Use in a Ruby script/program is:
#     require 'pry'
#     ...
#     binding.pry if options[:debug] >= 3
#
Pry.commands.alias_command 'b', 'break'
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'
Pry.commands.alias_command '$', 'exit-program'  # back to $-prompt, same as '!!!'

# Hit <Enter> to repeat last command
Pry::Commands.command /^$/, "Repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end

Pry.config.prompt = [proc { "pry> " },
                     proc { "   | " }]
