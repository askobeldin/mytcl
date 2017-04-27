# http://gener8.be/site/articles/tcl_file_formats/tcl_file_formats.html
#
#
set currSystem ""

proc System {name args} {
  # Instead of pushing the new system on the 'stack' of current systems,
  # we remember it in a local variable, which ends up on TCL's
  # function call stack.
  global currSystem
  set oldSystem $currSystem
  set currSystem $name   ; # Thanks to this, all sub-structures called by
                           # 'uplevel' will know what the name of their
                           # immediate parent System is

  # Store the system in an internal data structure
  # (details not shown here)
  puts "Storing system '$currSystem'"

  # Execute the parsing procedures for the sub-systems
  puts "### in proc System command \"lindex \$args end\" returns [lindex $args end]"
  uplevel 1 [lindex $args end]

  # Pop the system off the 'stack' again.  Restore the old system as if nothing happened.
  set currSystem $oldSystem
}

proc Object {name} {
  global currSystem
  # Store the object in the internal data structure of the current
  # system (details not shown here)
  puts "System '$currSystem' contains object '$name'"
}

# load file
#source "datafile2.tcl"
