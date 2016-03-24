# regexp testing 2
#
proc doregexp {expression text args} {
    puts "Evaluate: regexp $expression $text $args"
    puts [string repeat - 80]
    if {[eval {regexp $expression $text} $args]} {
        # puts good
        puts "Results:"
        foreach {n} $args {
            puts "$n = [set $n]"
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
