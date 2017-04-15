# working with lists
#
# 
set x {1 2}
puts $x

set y \$foo

set lst1 [list $x "a b" $y]
puts $lst1

set lst2 [list $lst1 $x]
puts $lst2

set cmd [list puts "This is a text line."]
eval $cmd
