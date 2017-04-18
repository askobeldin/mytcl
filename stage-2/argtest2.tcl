# welsh code: 7.2 (p. 164) modified
#
proc ArgTest {a {b foo} args} {
    puts [string repeat - 30]
    foreach param {a b args} {
        upvar 0 $param x
        puts "$param = $x"
    }
}


# work here
set x one
set y {two things}
set z \[special\$

ArgTest $x
ArgTest $y $z
ArgTest $x $y $z
ArgTest $z $y $z $x
