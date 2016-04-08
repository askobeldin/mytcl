# example2/parser.tcl
#
#
#
#
canvas .c
pack .c

proc d_rect {x1 y1 x2 y2 thickness color} {
   .c create rectangle $x1 $y1 $x2 $y2 -width $thickness -outline $color
}

proc d_text {x y text anchor color} {
   .c create text $x $y -text $text -anchor $anchor -fill $color
}

source datafile.dat
