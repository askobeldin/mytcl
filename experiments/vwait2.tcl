# vwait example from help file
#
#
after 500 {
    puts "waiting for b"
    trace add variable b write {apply {args {
        global a b
        trace remove variable ::b write \
                [lrange [info level 0] 0 1]
        puts "b was set"
        set ::done ok
    }}}
}

after 1000 {
    puts "setting a"
    set a 10
}

puts "waiting for a"

trace add variable a write {apply {args {
    global a b
    trace remove variable a write [lrange [info level 0] 0 1]
    puts "a was set"
    puts "setting b"
    set b 42
}}}

vwait done
