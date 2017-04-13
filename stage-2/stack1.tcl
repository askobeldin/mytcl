# try to use struct::stack object from tcllibrary
#
#
package require struct::stack


::struct::stack S
S push a b c d

puts "Size of stack S: [S size]"
puts "Value in stack S: [S get]"
puts [S pop]
puts [S pop]
