# 
#
#
proc example {first {second ""} args} {
    set result {}
    if {$second eq ""} {
        lappend result 1
        lappend result "There is only one argument and it is: $first"
        return $result
    } else {
        if {$args eq ""} {
            lappend result 2
            lappend result "There are two arguments - $first and $second"
            return $result
        } else {
            lappend result "many"
            lappend result "There are many arguments - $first and $second and $args"
            return $result
        }
    }
}

set count(1) {example ONE}
set count(2) {example ONE TWO}
set count(3) {example ONE TWO THREE }
set count(4) {example ONE TWO THREE FOUR}
set count(5) {example ONE TWO THREE FOUR ептыть}

foreach {num} [lsort [array names count]] {
    set r [eval $count($num)]
    set a [lindex $r 0]
    set c [lindex $r 1]
    puts "$count($num) => arguments: $a, comment: $c"
}
