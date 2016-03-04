# procs for testing
#
#

proc test {label cmd result} {
    puts -nonewline "test $label:\t"
    set _result [eval $cmd]
    if {$_result eq $result} {
        puts OK
    } else {
        puts "ERROR\t$result != $_result"
    }
}

# info about script
# puts [info script]
set arg1 [lindex $argv 0]
puts "Argument of script is $arg1"

if {$arg1 eq ""} {
    set testing_files [glob -types f mytest*.tcl]
} else {
    set testing_files [glob -types f $arg1*.tcl]
}


# do testing
foreach scriptfile $testing_files {
    puts "Файл с тестами: $scriptfile"
    source -encoding utf-8 $scriptfile
}

