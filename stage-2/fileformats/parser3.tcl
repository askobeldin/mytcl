# working with assemblies and parts
#

set offset 0

proc prt {designation {name ""}} {
    # part
    puts -nonewline "calling proc [lindex [info level 0] 0], level: [info level]  "
    global offset
    puts "[string repeat " " $offset]part $designation, name: \"$name\""
}

proc asm {designation {name ""} args} {
    # assembly
    puts -nonewline "calling proc [lindex [info level 0] 0], level: [info level]  "
    global offset
    puts "[string repeat " " $offset]assembly $designation, name: \"$name\""
    if {[llength $args] > 0} {
        # print info
        puts "[string repeat " " $offset]args = $args"
        incr offset 4
        uplevel #0 [lindex $args end]
        incr offset -4
    }
}
