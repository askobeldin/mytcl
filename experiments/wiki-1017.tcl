# wiki.tcl/1017 page
#
#
#
proc verbose_eval {script} {
    set cmd {} 
    foreach line [split $script \n] {
    if {$line eq {}} {continue}
        append cmd $line\n
        if {[info complete $cmd]} {
            puts "cmd: [string trim $cmd]"
            puts [string trim [uplevel 1 $cmd]]
            set cmd ""
        }
    }
}

set script {
    puts hello
    puts [expr {2.2 * 3}]
    puts "охуенно"
}

set script2 {
    set a 10
    puts $a
    puts [expr {$a * 3}]
}

verbose_eval $script 
verbose_eval $script2
