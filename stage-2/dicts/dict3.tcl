# Ousterhout
#
# ch7, sect. 7.3, pg. 180
# Creating and updating dictionaries
#
proc print-by-name {varName} {
    upvar $varName var
    puts "$varName = $var"
}


set example [dict create firstname Ann initial E \
            surname Huan]
print-by-name example

puts [dict exists $example firstname]
puts [dict exists $example foo]

puts [dict keys $example]
puts [dict keys $example {*name}]
puts [dict values $example]

# pretty print using the format command
dict for {key value} $example {
    puts [format "%s --> %s" $key $value]
}
