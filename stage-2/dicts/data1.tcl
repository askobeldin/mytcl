# comment
#
#
# хуйня какая-то

proc prt {designation {name ""}} {
    set data [list part designation $designation \
                        name $name]
    if {[uplevel 1 [list info exists adata]]} {
        upvar 1 adata localadata
        dict lappend [lindex $localadata end] items $data
    } else {
        puts $data
    }
    #return $data
}

proc asm {designation {name ""} args} {
    set adata [list assembly [dict create designation $designation \
                                          name $name \
                                          items {}]]
    uplevel 1 [lindex $args end]
    puts $adata
}


prt n01 d01
prt n02

asm n1 d1 {
    prt n2 d2
    prt n3 d3
}

