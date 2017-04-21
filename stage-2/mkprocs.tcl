# try to make some procs dynamically
#
proc print-by-name {varName} {
    upvar $varName var
    puts "$varName = $var"
}

proc print-variable {varName} {
    upvar $varName var
    if {[array exists var]} {
        puts "array ${varName}:"
        foreach {name value} [array get var] {
            puts "[string repeat " " 8]$name: $value"
        }
    } else {
        # simple variable
        puts "variable $varName = $var"
    }
}

proc ask-user-template {msg} {
    set t "msg"
    append t ": "
    puts -nonewline $t
    flush stdout
    return [gets stdin]
}

proc makeInput {procname text {template ask-user-template}} {
    set arg [info args $template]
    set body [info body $template]
    # puts "*** arg is $arg"
    # puts "*** body is $body"
    regsub -all -- $arg $body $text body
    # puts "*** body after regsub: $body"
    eval "proc ask-user-$procname {} {$body}"
}

set procs {
    name "Input your name"
    age "Input your age"
    жопа "Размер жопы"
}

foreach {procname msg} $procs {
    makeInput $procname $msg
}

# calling created procedures
set a [ask-user-name]
set b [ask-user-age]
set c [ask-user-жопа]

puts "user name => $a"
puts "user age => $b"
puts "жопа размера => $c"

#print-variable a
#print-variable b
#print-variable c
