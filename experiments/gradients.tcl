set im [image create photo -width 600 -height 768]

for {set i 1} {$i < 256} {incr i} {
set col [format "%2.2XFFFF" $i]        
$im put "#$col" -to 0 $i 600 [expr {$i + 1}]
}

for {set i 1} {$i < 256} {incr i} {
set col [format "FF%2.2XFF" $i]        
set yi [expr {$i + 256}]
$im put "#$col" -to 0 $yi 600 [expr {$yi + 1}]
}

for {set i 1} {$i < 256} {incr i} {
set col [format "FFFF%2.2X" $i]        
set yi [expr {$i + 512}]
$im put "#$col" -to 0 $yi 600 [expr {$yi + 1}]
}
        
        
pack [canvas .c -bd 0 -height 768 -width 600] 
.c create image 300 384 -image $im -tag im
.c bind im <Button-1> {puts [$im get %x %y]}
