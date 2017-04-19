# working with arrays
#
#
array set colorcount {
    red   1
    green 5
    blue  4
    white 9
}

array set fruit {
    best kiwi
    worst peach
    ok banana
}

set var 100

proc print-by-name {varName} {
    upvar $varName var
    puts "$varName = $var"
}

proc print-variable {varName} {
    upvar $varName var
    if {[array exists var]} {
        puts "array ${varName}:"
        foreach {name value} [array get var] {
            puts "[string repeat " " 8]$name: $value"
        }
    } else {
        # simple variable
        puts "variable $varName = $var"
    }
}

print-variable colorcount
print-variable fruit
print-variable var
