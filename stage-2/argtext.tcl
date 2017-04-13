# welsh code: 7.2 (p. 164)
#
proc ArgTest {a {b foo} args} {
    puts "------------------"
    foreach param {a b args} {
        puts "$param = [set $param]"
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
