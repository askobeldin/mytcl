# vwawit example from help file
#
#
after 500 {
    puts "waiting for b"
    vwait b
    puts "b was set"
}

after 1000 {
    puts "setting a"
    set a 10
}

puts "waiting for a"
vwait a

puts "a was set"
puts "setting b"
set b 42
