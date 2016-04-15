# evalregexps.tcl
#
# Evaluates test*.tcl files with regexps sentences
#
#
if {[info procs doregexp] eq ""} {
    source doregexp.tcl
}

set arg1 [lindex $argv 0]
# puts "Argument of script is $arg1"

if {$arg1 eq ""} {
    set testing_files [lsort [glob -types f test*.tcl]]
} else {
    set testing_files [lsort [glob -types f $arg1*.tcl]]
}

# do testing
foreach scriptfile $testing_files {
    puts "*** Файл с тестами: $scriptfile ***\n"
    source -encoding utf-8 $scriptfile
}
