# http://wiki.tcl.tk/2822
#
# Tcl is somehow more than just a programming language. At times it feels like
# a quite powerful operating system, with commands that have their own "small
# languages" (sed, awk in Unix; expr, regexp... in Tcl). But while implementing
# seds or awks functionality in C is hard work, in Tcl the creation of a custom
# "small language" is made easy by strong string processing commands. Hence I
# chose a small math language for my New Year's Eve fun project.
#
# The accepted language is based on expr's, which is well known to Tcl'ers and
# able to express all C arithmetics (and more), so isn't exactly small.
# However, I added some functionalities discussed earlier on comp.lang.tcl,
# plus some sugar to make it look more similar to conventional math notation:
#
# - allow multiple expressions, separated by semicolon
# - allow one infix assignment per expression, like i = j + 1
# - allow references to existing variables without prefixed dollar sign
# - allow omission of parens around simple function arguments
# - allow omission of the * operator after numeric constants
# - allow one fraction to be written with horizontal bar instead of /
#
# These effects took little effort, as they were reached by string
# manipulations on the arguments to math, which transform them to valid expr
# language, and evaluate that in caller's scope. On the other hand, no
# tokenization like that of expr was done (where $i+$j is equivalent to $i +
# $j), so the arguments have to be list elements separated by whitespace. At
# the place marked "more preprocessing here", you can add your own ideas. See
# the usage examples at end, and enjoy!

proc math args {
    if {[llength $args]==1} {set args [lindex $args 0]}
    foreach mathcmd [split $args ";"] {
        set cmd ""
        if {[lindex $mathcmd 1]=="="} {
            set cmd [list set [lindex $mathcmd 0]]
            set expr [lrange $mathcmd 2 end]
        } else {set expr $mathcmd}
        set expr2 "expr \{("
        set previous ""
        foreach i $expr {
            if [uplevel 1 info exists $i] {set i \$$i}
            if [regexp -- {--+} $i] {set i )/double(}
            if [isBuiltin $previous] {set i ($i)}
            if {[isNumeric $previous] && [regexp {^[$A-Za-z_]} $i]} {
                set i *$i
            }
            # more preprocessing here..
            set previous $i
            append expr2 $i 
        }
        append expr2 ")\}"
        if {$cmd==""} {
            set cmd $expr2
        } else {
            append cmd " \[$expr2\]"
        }
        set res [uplevel 1 $cmd]
    }
    set res ;# return last expression's result
}

proc isBuiltin word {
    expr [lsearch -exact {
        abs     cosh    log     sqrt
        acos    double  log10   srand
        asin    exp     pow     tan
        atan    floor   rand    tanh
        atan2   fmod    round
        ceil    hypot   sin
        cos     int     sinh} $word ]>=0
}

proc isNumeric x {expr ![catch {expr $x*1}]}


# testing, and usage examples:
math {
    a = 1 * (2 - 1);
    b = sqrt 4;

    c = 3 a - b
        -------
         a + b
}

puts "c = $c"
