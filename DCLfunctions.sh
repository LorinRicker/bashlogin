#!/usr/bin/env bash

# $HOME/bin/login/DCLfunctions.sh
# Lorin Ricker: bash functions

# This group of bash functions mimics the (mostly) string-manipulation
# DCL (VMS) lexical functions, and mostly puts a familiar wrapper around
# the somewhat more baroque (unmemorable) bash syntax for similar things...

shF="$( basename ${0#-} ) - functions"
Ident="${shF}  # (LMR version 1.00 of 06/26/2014)"
[ "$DEBUGMODE" = "1" ] && echo "%login-I, ${Ident}"

# ===============================================================
# Note: Each function definition includes an "export -f fname" so
#       that these are "global", copied to forked sub-processes
#       and can also be listed by Ruby script lsfunction.rb
# ================================================================

# ==========
# f_element -- F$ELEMENT(elemno,separator,string)
# use: $ PATH=$( f_element $1 '$2' "$3" )
f_element()
  {
    «+»
  }
export -f f_element

# ==========
# f_extract -- F$EXTRACT(start,length,string)
# use: $ PATH=$( f_extract $1 $2 "$3" )
f_extract()
  {
    «+»
  }
export -f f_extract

# ==========
# f_locate -- F$LOCATE(substring,string)
# use: $ PATH=$( f_locate "$1" "$2" )
f_locate()
  {
    «+»
  }
export -f f_locate

# ==========
# f_length -- F$LENGTH(string)
# use: $ PATH=$( f_length "$1" )
f_length()
  {
    «+»
  }
export -f f_length

# ==========
# f_«+»
# use: $ PATH=$( f_«+» $1 )
f_«+»()
  {
    «+»
  }
export -f f_«+»

# ==========
# f_«+»
# use: $ PATH=$( f_«+» $1 )
f_«+»()
  {
    «+»
  }
export -f f_«+»

# ==========
# f_«+»
# use: $ PATH=$( f_«+» $1 )
f_«+»()
  {
    «+»
  }
export -f f_«+»

