# http://wiki.tcl.tk/2822
# calculator.tcl
#
# Script to emulate a calculator, allows the on-the-spot
# evaluation of expressions as well the use of macros
#
# Author: Arjen Markus (arjen.markus@wldelft.nl)
#

# Macro --
#    Namespace for the user-defined macros
#
namespace eval ::Macro {
}

# Calculator --
#    Namespace for the public commands
#
namespace eval ::Calculator {
}

# HandleCommand --
#    Identify the type of command and handle accordingly
#
# Arguments:
#    command     Command that must be handled
# Return value:
#    {} if the command is a definition or the value of the expression.
# Side effects:
#    Definitions are handled directly
#
proc ::Calculator::HandleCommand { command } {
   set new_command [string map { " " "" "\t" "" } $command]

   #
   # Definitions take the form "name=some expression"
   if { [regexp {^[A-Za-z_][A-Za-z0-9]*=[^=]} $new_command] } {
      HandleDefinition $new_command
      return ""
   } else {
      Evaluate $new_command
   }
}

# Evaluate --
#    Evaluate the expression
#
# Arguments:
#    command     Command that must be evaluated
# Return value:
#    The value of the expression.
#
proc ::Calculator::Evaluate { command } {

   set new_command [ConstructMacroCalls $command]
   return [expr $new_command]
}

# ConstructMacroCalls --
#    Construct the calls to a macro
#
# Arguments:
#    body        The raw body of the macro
# Return value:
#    An expression valid for use in [expr]
# Note:
#    Beware of expressions like "sin(1.0)" - they are not macros
#
proc ::Calculator::ConstructMacroCalls { body } {

   regsub -all {([A-Za-z_][A-Za-z_0-9]*)} \
      $body {[::Macro::\1]} new_body
   regsub -all {\[::Macro::([A-Za-z_][A-Za-z_0-9]*)\]\(} \
      $new_body {\1(} new_body

   return $new_body
}

# HandleDefinition --
#    Define the macro based on the given command
#
# Arguments:
#    command     Command that represents a definition
# Return value:
#    The value of the expression.
#
proc ::Calculator::HandleDefinition { command } {

   regexp {(^[A-Za-z_][A-Za-z0-9]*)=(.*)} $command matched macro body
   set new_body [ConstructMacroCalls $body]
   proc ::Macro::$macro {} [list expr $new_body]
   return
}


# main code --
#    In a loop, read the expressions and evaluate them
#
puts "Calculator:
   Example:
   >> a=b+1

   >> b=1

   >> a
   2
   >>1.0+2.0+3.0
   6.0
   (Use quit to exit the program)"

while { 1 } {
   puts -nonewline ">> "
   flush stdout
   gets stdin line

   if { $line == "quit" } {
      break
   } else {
      if { [ catch {
                puts [::Calculator::HandleCommand $line]
             } message ] != 0 } {
         puts "Error: [lindex [split $message "\n"] 0]"
      }
   }
}
