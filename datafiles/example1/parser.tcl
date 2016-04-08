# parser.tcl
#
canvas .c
pack .c

set fid [open "datafile.dat" r]
while { ![eof $fid] } {
   # Read a line from the file and analyse it.
   gets $fid line

   if { [regexp \
      {^rectangle +([0-9]+) +([0-9]+) +([0-9]+) +([0-9]+) +([0-9]+) +(.*)$} \
         $line dummy x1 y1 x2 y2 thickness color] } {
      .c create rectangle $x1 $y1 $x2 $y2 -width $thickness -outline $color

   } elseif { [regexp \
      {^text +([0-9]+) +([0-9]+) +("[^"]*") +([^ ]+) +(.*)$} \
      $line dummy x y txt anchor color] } {
      .c create text $x $y -text $txt -anchor $anchor -fill $color

   } elseif { [regexp {^ *$} $line] } {
      # Ignore blank lines

   } else {
      puts "error: unknown keyword."
   }
}
close $fid
