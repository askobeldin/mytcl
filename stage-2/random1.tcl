# welsh code 7.4 (p. 168)
#
proc RandomInit {seed} {
    global randomSeed
    set randomSeed $seed
}

proc Random {} {
    global randomSeed
    set randomSeed [expr {($randomSeed*9301 + 49297) % 233280}]
    return [expr {$randomSeed/double(233280)}]
}

proc RandomRange {range} {
    expr {int([Random]*$range)}
}


RandomInit [pid]

for {set x 0} {$x < 10} {incr x} {
    puts "[expr {$x + 1}] [Random]"
}
puts [RandomRange 100]
