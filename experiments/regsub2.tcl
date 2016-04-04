# http://wiki.tcl.tk/987
#
#
set unique1 {\|\|=>}
set unique2 {<=\|\|}

set string "random ||=> this is some text <=|| text"

set replacement "новый текст"

puts "Initial string: $string"

set new [regsub -- "($unique1) .* ($unique2)" $string "\\1$replacement\\2" newstring ]

puts "Number of replacements: $new"
puts "New string: $newstring"

# output:
# Initial string: random ||=> this is some text <=|| text
# Number of replacements: 1
# New string: random ||=>новый текст<=|| text
