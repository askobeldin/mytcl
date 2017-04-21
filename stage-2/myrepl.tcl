# try to do my simple repl
#

proc read-line {} {
    puts -nonewline ">>> "
    flush stdout
    return [gets stdin]
}

proc myrepl {} {
    set cmd ""
    while {[set uinput [read-line]] ne "quit"} {
        if {[string last "\\" $uinput] >= 0} {
            # user doesn't end command
            append cmd ${uinput}\n
        } else {
            # good cmd ?
            append cmd $uinput
            uplevel #0 $cmd
            set cmd ""
        }
    }
}

myrepl
