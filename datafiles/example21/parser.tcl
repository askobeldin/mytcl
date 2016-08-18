# example21/parser.tcl
#
#
#
#

set arg1 [lindex $argv 0]

if {$arg1 eq ""} {
    puts stderr "Usage: "
    exit 2
} else {
    set fileforparsing $arg1
}


canvas .c
# pack .c

##############################################################
# names in file
#
proc drect {x1 y1 x2 y2 thickness color} {
   .c create rectangle $x1 $y1 $x2 $y2 -width $thickness -outline $color
}

proc dtext {x y text anchor color} {
   .c create text $x $y -text $text -anchor $anchor -fill $color
}
##############################################################

source -encoding utf-8 $fileforparsing

pack .c
