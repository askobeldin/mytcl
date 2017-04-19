# We will internally store the data in these three lists:
set l_patterns [list]
set l_sources [list]
set l_categories [list]

# We also need a variable to keep track of the Pattern structure we are
# currently in:
set curPattern ""

# This is the parsing procedure for the 'Source' keyword.
# As you can see, the keyword is followed by an id (the unique tag for the
# source), and some textual description of the source.
proc Source {id info} {
   # Remember that we saw this source.
   global l_sources
   lappend l_sources $id

   # Remember the info of this source in a global array.
   global a_sources
   set a_sources($id,info) $info
}

# The parsing procedure for the 'Category' keyword is similar.
proc Category {id info} {
   global l_categories
   lappend l_categories $id

   global a_categories
   set a_categories($id,info) $info
}

# This is the parsing procedure for the 'Pattern' keyword.
# Since a 'Pattern' structure can contain sub-structures,
# we use 'uplevel' to recursively handle those.
proc Pattern {name args} {
   global curPattern
   set curPattern $name   ; # This will be used in the sub-structures,
                            # which are parsed next.
   global l_patterns
   lappend l_patterns $curPattern

   # We treat the final argument as a piece of Tcl code.
   # We execute that code in the caller's scope.  It contains calls
   # to 'Categories', 'Level' and other commands which implement
   # the sub-structures.
   # This is similar to how we use the 'source' command to parse the entire
   # data file.
   uplevel 1 [lindex $args end]

   # We're no longer inside a pattern body, so set curPattern to empty.
   set curPattern ""
}

# The parsing procedure for one of the sub-structures.  It is called
# by 'uplevel' as we described in the comments above.
proc Categories {categoryList} {
   global curPattern   ; # We access the global variable 'curPattern'
                         # to find out inside which structure we are.
   global a_patterns
   set a_patterns($curPattern,categories) $categoryList
}

# The following parsing procedures are for the other sub-structures
# of the Pattern structure.

proc Level {level} {
   global curPattern
   global a_patterns
   set a_patterns($curPattern,level) $level
}

proc Sources {sourceList} {
   global curPattern
   global a_patterns
   # We store the codes such as 'SYST:99' in a global array.
   # My implementation uses regular expressions to extract the source tag
   # and the page number from such a code (not shown here).
   set a_patterns($curPattern,sources) $sourceList
}

proc Info {info} {
   global curPattern
   global a_patterns
   set a_patterns($curPattern,info) $info
}
