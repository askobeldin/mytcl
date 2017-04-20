# Ousterhout
#
# ch7, sect. 7.3, pg. 180
# Creating and updating dictionaries
#
proc print-by-name {varName} {
    upvar $varName var
    puts "$varName = $var"
}

dict create a b c {d e} {f g} h a "b repeated"
# => a {b repeated} c {d e} {f g} h

set example [dict create firstname Ann initial E \
            surname Huan]
puts $example

set example [dict replace $example initial Y]
puts $example

set example [dict replace $example title Mrs surname Boddie]
puts $example

puts [dict remove $example firstname title]


set colors1 {foreground white background black}
set colors2 {highlight red foreground green}

print-by-name colors1
print-by-name colors2

puts [dict merge $colors1 $colors2]

dict set example title -MRS-
print-by-name example

dict unset example initial
print-by-name example
