# trying to use eval
#
#

proc foo {label cmd result} {
    puts -nonewline $label\t
    set _result [eval $cmd]
    if {$_result eq $result} {
        puts OK
    } else {
        puts "ERROR\t$result != $_result"
    }
}



foo 1 {expr {3 * 3}} 9
foo 2 {expr {3 * 2}} 9
