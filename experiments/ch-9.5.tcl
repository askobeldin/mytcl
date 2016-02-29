# tcl and the Tk toolkit
# chapter 9.5
#
proc printArray {name} {
    upvar $name a
    foreach el [lsort [array names a]] {
        puts "$el = $a($el)"
    }
}


### script ###

set user(age) 37
set user(position) "Vice President"
set user(foo) 102
set user(bar) "this is a bar"
set user(жопа) "а тут все по-русски"

printArray user
