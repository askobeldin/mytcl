# coroutine command help
#
#
proc allNumbers {} {
    yield
    set i 0
    while 1 {
        yield $i
        incr i 2
    }
}

coroutine nextNumber allNumbers

for {set i 0} {$i < 20} {incr i} {
    puts "received [nextNumber]"
}

# delete command
rename nextNumber {}
