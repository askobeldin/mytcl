# http://wiki.tcl.tk/1302
# This little program demonstrates what Chris Nelson stated above (vwaits
# nest):
set ::time 0
set ::a 0
set ::b 0
# my
set ::done 0

proc a_vwait {} {
    puts "Waiting 15 sec for ::a"
    vwait ::a
    puts "::a set"
}

proc b_vwait {} {
    puts "Waiting 30 sec for ::b"
    vwait ::b
    puts "::b set"
}


proc timer {} {
    incr ::time 1
    puts "$::time sec"
    if {$::time == 35} {
        # my
        # exit
        set ::done ok
    } else {
        after 1000 timer
    }
}

after 1 a_vwait
after 5 b_vwait
after 10 timer

after 15000 {set ::a 100}
after 30000 {set ::b 200}

puts "*** my change: a is $::a"
puts "*** my change: b is $::b"

# my
# vwait forever
vwait done

puts "*** my change2: a is $::a"
puts "*** my change2: b is $::b"

# Although there are two events set to trigger in 15 sec and 30 sec
# respectively, the 30 sec vwait blocks the 15 sec vwait, opposite of the
# intuitive reaction to this program.  When you understand this code snippit,
# you'll be free from the dangers of haphazardly using vwait.

# output:
# 
# *** my change: a is 0
# *** my change: b is 0
# Waiting 15 sec for ::a
# Waiting 30 sec for ::b
# 1 sec
# 2 sec
# 3 sec
# . . . . . .
# 29 sec
# 30 sec
# ::b set
# ::a set
# 31 sec
# 32 sec
# 33 sec
# 34 sec
# 35 sec
# *** my change2: a is 100
# *** my change2: b is 200
