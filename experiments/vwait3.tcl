# A coroutine-based wait-for-variable command
proc waitvar globalVar {
    trace add variable ::$globalVar write \
            [list apply {{v c args} {
        trace remove variable $v write \
                [lrange [info level 0] 0 3]
        after 0 $c
    }} ::$globalVar [info coroutine]]
    yield
}

# A coroutine-based wait-for-some-time command
proc waittime ms {
    after $ms [info coroutine]
    yield
}

coroutine task-1 eval {
    puts "waiting for a"
    waitvar a
    puts "a was set"
    puts "setting b"
    set b 42
}

coroutine task-2 eval {
    waittime 500
    puts "waiting for b"
    waitvar b
    puts "b was set"
    set done ok
}

coroutine task-3 eval {
    waittime 1000
    puts "setting a"
    set a 10
}

vwait done
