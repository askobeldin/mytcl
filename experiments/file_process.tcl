# Welch, code 10.5
#
# применяет команду обратного вызова к каждой строке файла
#
# usage:
#       File_Process name.txt {puts} -encoding utf-8
#       -encoding -- for reading from file
#
#
proc File_Process {filename callback args} {
    set in [open $filename]
    eval {fconfigure $in} $args      ;# fconfigure $in -encoding utf-8
    while {[gets $in line] >= 0} {
        uplevel 1 $callback [list $line]
    }
    close $in
}

proc foo {line} {
    puts "foo1 --> $line"
}

proc bar {line} {
    puts "bar == [string length $line] ==> $line"
}


File_Process hw1.tcl {puts}
File_Process hw1.tcl {puts} -encoding utf-8
File_Process hw1.tcl {foo} -encoding utf-8
File_Process hw1.tcl {bar} -encoding utf-8
