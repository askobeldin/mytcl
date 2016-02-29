# tcl and the Tk toolkit
# chapter 9.7
#
proc map {lambda list} {
    set result {}
    foreach item $list {
        lappend result [apply $lambda $item]
    }
    return $result
}


### script ###
puts [map {x {expr {$x ** 2}}} {1 2 3 4 5}]
