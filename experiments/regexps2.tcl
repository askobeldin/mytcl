# regexp testing 2
#
proc doregexp {expression text args} {
    puts "Evaluate: regexp $expression $text $args"
    puts [string repeat - 80]
    if {[eval {regexp $expression $text} $args]} {
        puts "Results:"
        foreach {n} $args {
            upvar 0 $n v
            puts "$n = $v"
        }
        puts [string repeat \n 1]
    } else {
        puts Bad
    }
}


doregexp {([^:]*):} "sage:0.1" match host
doregexp {([^:]+)://([^:/]+)(:([0-9]+))?(/.*)} "http://www.beedub.com:80/index.html" \
    match protocol server x port path
doregexp {([^:-]*)-} "sage-0.1" match host
doregexp {([^:-]*)-([0-9]*?).([0-9]*?)} "sage-03.142" match host n1 n2
