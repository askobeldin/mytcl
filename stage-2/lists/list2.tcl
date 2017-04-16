set b [list a b {c d e} {f {g h}}]
puts "Treated as a list: $b\n"

set b [split "a b {c d e} {f {g h}}"]
puts "Transformed by split: $b\n"

set a [concat a b {c d e} {f {g h}}]
puts "Concated: $a\n"

lappend a {ij K lm}                        ;# Note: {ij K lm} is a single element
puts "After lappending: $a\n"

set b [linsert $a 3 "1 2 3"]               ;# "1 2 3" is a single element
puts "After linsert at position 3: $b\n"

set b [lreplace $b 3 5 "AA" "BB"]
puts "After lreplacing 3 positions with 2 values at position 3: $b\n"


set lst [list a b c d]
puts [lindex $lst 1]
puts [llength $lst]
foreach v $lst {puts $v}
lappend lst e
lappend lst f
puts $lst
linsert $lst end test
puts $lst
puts [lreplace $lst 0 0 one two three]
lset lst 1 test
puts $lst
