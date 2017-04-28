# uplevel and upvar experiments
#
proc one {} {
    puts "calling proc [lindex [info level 0] 0], level: [info level]"
    set parent "text line"
    puts "info vars > [info vars]"
    puts "info locals > [info locals]"
    puts "-----"
    two
}

proc two {} {
    puts "calling proc [lindex [info level 0] 0], level: [info level]"
    if {![uplevel 1 [list info exists parent]]} {
        set theparent "None"
    } else {
        upvar 1 parent theparent
    }
    puts "info vars > [info vars]"
    puts "info locals > [info locals]"
    puts "-----"
    puts "theparent is $theparent"
}

proc foo {} {
    puts "calling proc [lindex [info level 0] 0], level: [info level]"
    two
    puts "info vars > [info vars]"
    puts "info locals > [info locals]"
    puts "-----"
}


# main script
one
foo

