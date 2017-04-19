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

set list1 {a b c d}
set list2 {1 2 3 4}
set list3 {one two}
set zipped [lmap a $list1 b $list2 {list $a $b}] 
set zipped2 [lmap a $list1 b $list3 {list $a $b}] 


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

proc rect {args} {
    set arr(-thickness) 1
    set arr(-color) blue
    array set arr $args
    puts "call rect with arguments:"
    print-variable arr
}

print-variable list1
print-variable list2
print-variable zipped
print-variable zipped2

rect 10 10 20 20 -color red
rect from {10 10} to {20 20} -color red
