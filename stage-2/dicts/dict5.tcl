# Ousterhout
#
# ch7, sect. 7.6, pg. 187
# working with nested dictionaries
#
proc print-by-name {varName} {
    upvar $varName var
    puts "$varName = $var"
}

# the command:
#    dict get $dictionary keyOne keyTwo
# is exactly the same as
#    dict get [dict get $dictionary keyOne] keyTwo
#

set nestedDict {firstname Ann surname Huan}
dict set nestedDict address street "Ordinary Way"
dict set nestedDict address city Springfield
print-by-name nestedDict

puts [dict get $nestedDict address street]

dict unset nestedDict address street
print-by-name nestedDict

set example {
    A {
        alphabet {a alpha b bravo c charlie}
        animals {cow calf sheep lamb pig ? goose ?}
    }
    C {
        comedians {laurel&hardy morecambe&wise}
    }
}

dict with example C {
    puts "comedians: $comedians"
    lappend comedians "steve martin"
}

print-by-name example

dict with example A alphabet {
    puts "NATO ABC: $a $b $c"
}

dict with example A animals {
    set pig piglet
    set goose gosling
}

dict with example A {
    dict for {k v} $animals {
        puts "$k has baby $v"
    }
}

# The dict with command can be used to allow the stowing of some persistent
# procedure state in a global variable without polluting the global namespace
# with lots of different variables or requiring every use of the global state to
# be encapsulated within array syntax, which is the other solution.
set counters {
    next 0
}

proc makeCounter {{step 1} {offset 0}} {
    global counters
    set id counter[dict get $counters next]
    dict incr counters next
    dict set counters $id [dict create \
                state 0 step $step offset $offset]
    return $id
}

proc stepCounter {id} {
    global counters
    dict with counters $id {
        return [expr {[incr state $step] + $offset}]
    }
}

# usage
set a [makeCounter]
set b [makeCounter 5 -4]
puts "a: [stepCounter $a]"
puts "a: [stepCounter $a]"
puts "a: [stepCounter $a]"
puts "a: [stepCounter $a]"
puts "b: [stepCounter $b]"
puts "b: [stepCounter $b]"
puts "b: [stepCounter $b]"
puts "b: [stepCounter $b]"
puts "b: [stepCounter $b]"
puts "a: [stepCounter $a]"
puts "a: [stepCounter $a]"
puts $counters
