# try to make some procs dynamically
#
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

foreach {tag msg} {
    name "Input your name"
    age "Input your age"
    жопа "Размер жопы"
} {
    makeInput $tag $msg
}

# calling
set a [ask-user-name]
set b [ask-user-age]
set c [ask-user-жопа]
puts "user name =>$a"
puts "user age =>$b"
puts "жопа размера =>$c"
