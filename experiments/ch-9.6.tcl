# tcl and the Tk toolkit
# chapter 9.6
#
proc do {varName first last body} {
    upvar $varName v
    for {set v $first} {$v <= $last} {incr v} {
        uplevel $body
    }
}


### script ###
set squares {}

do i 1 5 {
    lappend squares [expr $i * $i]
}

puts [set squares]
puts [set i]
