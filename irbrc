# .irbrc --> irbrc -- v0.8 - 07/14/2014 LMR

require 'pp'
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:PROMPT_MODE] = :SIMPLE

%w[rubygems looksee/shortcuts wirble].each do |gem|
  begin
    require gem
    if gem == 'wirble'
      module Wirble      # monkeypatch, but local-effects only
        module Colorize
          # a couple of DEFAULT_COLORS are unusable on white-background screen:
          DEFAULT_COLORS[:symbol_prefix] = :red          # was :yellow
          DEFAULT_COLORS[:symbol]        = :cyan         # was :yellow
          DEFAULT_COLORS[:object_class]  = :light_green  # was :white
        end
      end                # monkeypatch
      # Wirble.init; Wirble.colorize:
      %w{init colorize}.each { |str| Wirble.send(str) }
    end
  rescue LoadError
  end
end

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  # print documentation:
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    system 'ri', method.to_s
  end
end

# -----
def copy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

def copy_history
  history = Readline::HISTORY.entries
  index = history.rindex("exit") || -1
  content = history[(index+1)..-2].join("\n")
  puts content
  copy content
end

def paste
  `pbpaste`
end

# -----
# Quick benchmark timer (suggested by PickAxe, Chapter 18):
#   Call with braces-{} around the code-block to time --
#   for example:  elapsed { n!(100) }
def elapsed( &block )
  require 'benchmark'
  bmresult = nil
  timing = Benchmark.measure do
    bmresult = block.()
  end
  puts "#{' '*25}user     system      total (      real)"
  puts "Elapsed execution: #{timing} (seconds)"
  bmresult
end  # elapsed
# -----

# -----
# File load (fl) and reload (rl) and require-based reload (rql) --
#   as suggested by www.themomorohoax.com/2009/03/27/irb-tip-load-files-faster
# e.g.   >> fl 'factr'
#        => true
def fl( fname, prfx = "" )
  fname += '.rb' unless fname =~ /\.rb/
  @@recentfname = fname
  load "#{fname}"
  puts "fl - file #{prfx}load: #{fname}"
end

def rl
  fl( @@recentfname, "re" )
end

def rql( fname )
  $".delete( fname + ".rb" ) # reset/remove module from require-loaded array ($")
  require( fname )           # and then re-require it...
end
# -----

def cmdhelp
  rule = '-' * 78
  puts <<-HELPDOC
  #{rule}
    auto-required:  pp, irb/completion, irb/ext/save-history
    tab-completion is enabled
  #{rule}
  irb commands:
    cmdhelp                      # generates this help-text

    fl 'rubymodule[.rb]'         # "file load", loads a Ruby module
    rl 'rubymodule[.rb]'         # "re-load", reloads a Ruby module
    rql 'rubymodule'             # "require", requires a Ruby module

    elapsed { block }            # benchmark-time a Ruby code block

    Wirble:
      Class.ri                   # shows ri doc for Class
      ri Class#method            #   and optional method
      Class.ri :method
      obj.ri :method

      local_methods              # display sorted list of local methods
      local_variables            #    "      "     "   "  local variables

      po object                  # display sorted list of object's methods
      poc object                 #    "      "     "   "  object's constants

    help                         # enters help-mode for irb-known methods
      method_name
      ^D                         # exits help-mode...
  #{rule}

  HELPDOC
end

alias q exit
alias quit exit

## load File.dirname(__FILE__) + '/.railsrc' if ($0 == 'irb' && ENV['RAILS_ENV']) || ($0 == 'script/rails' && Rails.env)
