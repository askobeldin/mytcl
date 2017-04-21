# Flynt code ch.7, ex. 11
#
#
# Create procedure stack1 with a local variable x.  display the value of x,
# call stack2, and redisplay the value of x
proc stack1 { } {
    set x 1
    puts "X in stack1 starts as $x"
    stack2
    puts "X in stack1 ends as $x"
    puts ""
}

# Create procedure stack2 with a local variable x.  display the value of x,
# call stack3, and redisplay the value of x
proc stack2 { } {
    set x 2
    puts "X in stack2 starts as $x"
    stack3
    puts "X in stack2 ends as $x"
}

# Create procedure stack3 with a local variable x.  display the value of x,
# display the value of x in the scope of procedures that invoked stack3 using
# relative call stack level.  Add 10 to the value of x in the proc that called
# stack3 (stack2) Add 100 to the value of x in the proc that called stack2
# (stack1) Add 200 to the value of x in the global scope.  display the value of
# x using absolute call stack level.
proc stack3 { } {
    set x 3
    puts "X in stack3 starts as $x"
    puts ""
    # display the value of x at stack levels relative to the
    # current level.
    for {set i 1} {$i <= 3} {incr i} {
        upvar $i x localX
        puts "X at upvar $i is $localX"
    }
    puts "\nx is being modified from procedure stack3"
    # Evaluate a command in the scope of procedures above the
    # current call level.
    uplevel 1 {incr x 10}
    uplevel 2 {incr x 100}
    uplevel #0 {incr x 200}
    puts ""
    # display the value of x at absolute stack levels
    for {set i 0} {$i < 3} {incr i} {
        upvar #$i x localX
        puts "X at upvar #$i is $localX"
    }
    puts ""
}

# Example Script
set x 0;
puts "X in global scope is $x"
stack1
puts "X in global scope ends as $x"
