# http://wiki.tcl.tk/4884
# 
namespace eval ns1 {
    variable var1 1
    variable var2 2
}

namespace eval ns2 {
    variable var1 3
    variable var2 4
}

puts [apply {{x args} {
    foreach arg $args {
        lappend vals [set [namespace current]::$arg]
    }
    ::tcl::mathop::+ $x {*}$vals
} ns1} 3 var1 var2]
# -> 6

puts [apply {{x args} {
    foreach arg $args {
        lappend vals [set [namespace current]::$arg]
    }
    ::tcl::mathop::+ $x {*}$vals
} ns2} 3 var1 var2]
# -> 10
