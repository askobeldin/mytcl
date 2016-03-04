# Ousterhout chapter 15.5.2
#
#
proc printProcs {file} {
    set f [open $file w]
    foreach proc [info procs] {
        set argList {}
        foreach arg [info args $proc] {
            if {[info default $proc $arg default]} {
                lappend argList [list $arg $default]
            } else {
                lappend argList [list $arg]
            }
        }
        puts $f [list proc $proc $argList [info body $proc]]
    }
    close $f
}


printProcs aaa
