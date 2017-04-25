# Ousterhout
#
# ch7, sect. 7.5, pg. 184
# updating dictionary values
#

# load pdict
source -encoding utf-8 pdict.tcl

proc print-by-name {varName} {
    upvar $varName var
    puts "$varName = $var"
}

# a nested dict pretty printer
# see: tcl/tk dev guide, pg. 158
proc show-dict {dct {indent 0}} {
    # if dict keys fails - this is not a dictionary
    if {[catch {dict keys $dct}]} {
        puts "[string repeat " " $indent]$dct"
        return
    }
    foreach k [dict keys $dct] {
        puts "[string repeat " " $indent]$k"
        set v [dict get $dct $k]
        show-dict $v [expr {$indent + 4}]
    }
}

set example [dict create firstname Ann initial E \
            surname Huan title Miss]
#print-by-name example
pdict example

dict append example firstname ie
#print-by-name example
pdict example

set shopping {fruit apple veg carrot}
dict lappend shopping fruit orange
dict lappend shopping fruit banana
dict lappend shopping veg cabbage beans
#print-by-name shopping
puts "### dictionary shopping ###"
#show-dict $shopping
pdict shopping
pdict $shopping

proc computeHistogram {text} {
    set frequencies {}
    foreach word [split $text] {
        # ignore empty words caused by double spaces
        if {$word eq ""} continue
        dict incr frequencies [string tolower $word]
    }
    return $frequencies
}

puts [computeHistogram "да епта this day is a happy happy day епта"]

# More complex updates are also possible. Here is an example that switches
# the values between two keys
dict update example firstname v1 surname v2 {
    lassign [list $v1 $v2] v2 v1
}
#print-by-name example
pdict example

# This example shows how to make a square-a-value operation
proc squareValue {dictVar key} {
    upvar 1 $dictVar d
    dict update d $key v {
        set v [expr {$v ** 2}]
    }
}

set polyFactors {C 1 x 2 y 3}
#print-by-name polyFactors
pdict example

squareValue polyFactors y
#print-by-name polyFactors
pdict example

# One tricky feature is that updates to the variable containing the dictionary
# happen only when the body of the dict update command finishes, and the key-value
# pairs not mapped by this subcommand are left untouched. This makes the behaviour
# of the system much easier to understand when a complex update is being performed
set example {firstname Ann surname Huan title Miss}
set i "a dummy value"
dict update example surname s notes n initial i {
    dict set example title Mrs
    unset s
    set n "have initial = [info exists i]"
    # print the current contents of the dictionary
    #puts $example
    pdict example
}

# Get the contents of the variable after the dict update command has completed;
# note it is different in several respects, but the value for 'title' is
# unchanged because that key was not listed at the start of the command

#puts $example
#print-by-name example
pdict example
