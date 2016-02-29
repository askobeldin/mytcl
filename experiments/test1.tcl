# tcl and the Tk toolkit
# ch 9.4
#
#

# It needs global variables with names a and b
proc printVars {} {
    global a b
    puts "a is $a, b is $b"
}

proc sum {args} {
    set total 0
    foreach val $args {
        set total [expr {$total + $val}]
    }
    return $total
}


# script
puts "sum is [sum 1 2 3 4 5]"

# error
printVars
