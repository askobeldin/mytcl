# doregexp.tcl
#
# usage: doregexp {([^:]*):} "sage:0.1" match host
#
#
proc doregexp {expression text args} {
    puts "Evaluate: regexp $expression \"$text\" $args"
    puts [string repeat - 80]
    if {[eval {regexp -expanded -- $expression $text} $args]} {
        puts "Results:"
        foreach {n} $args {
            upvar 0 $n v
            puts "$n = $v"
        }
        puts [string repeat \n 1]
    } else {
        puts "No matches\n"
    }
}
