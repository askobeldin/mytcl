# http://wiki.tcl.tk/460
# Advanced split
#
# If you need to split string into list using some more complicated rule than
# builtin split command allows, use following function
#
proc xsplit [list str [list regexp "\[\t \r\n\]+"]] {
    set list  {}
    while {[regexp -indices -- $regexp $str match submatch]} {
       lappend list [string range $str 0 [expr [lindex $match 0] -1]]
       if {[lindex $submatch 0]>=0} {
           lappend list [string range $str [lindex $submatch 0]\
                   [lindex $submatch 1]] 
       }       
       set str [string range $str [expr [lindex $match 1]+1] end] 
    }
    lappend list $str
    return $list
}
