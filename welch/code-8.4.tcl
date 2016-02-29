# inverting an array
#
# code 8.4
#
proc ArrayInvert {arrName inverseName {pattern *}} {
    upvar $arrName array $inverseName inverse
    foreach {index value} [array get array $pattern] {
        set inverse($value) $index
    }
}


### script

