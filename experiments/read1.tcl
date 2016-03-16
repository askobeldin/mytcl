# try to read from file
# непонятное поведение info complete
#

set fl [open pscript1.tcl]
set data [read $fl]
close $fl

set lines [split $data \n]

set cmd ""
foreach line $lines {
    append cmd "$line\n"
    if {[info complete $cmd]} {
        puts "cmd is: $cmd"
        puts "evaluating..."
        eval $cmd
        set cmd ""
    }
}
