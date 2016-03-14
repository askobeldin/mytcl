# try to input from kbd
#
#

proc getuserinput {} {
    puts -nonewline "Enter value: "
    flush stdout
    set answer [gets stdin]
    return $answer
}

set a [getuserinput]
puts "user input is $a"
