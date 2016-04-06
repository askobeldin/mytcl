# try to make some procs dynamically
#
proc ask-user-template {msg} {
    set tmsg "-msg"
    append tmsg ": "
    puts -nonewline $tmsg
    flush stdout
    return [gets stdin]
}

proc makeInput {procname parmlist {template ask-user-template}} {
    set arg [info args $template]
    set body [info body $template]
    foreach {msg text} $parmlist {
        regsub -all -- $msg $body $text body
    }
    puts "*** body after regsub: $body"
    eval "proc ask-user-$procname {} {$body}"
}

foreach {tag msg} {
    name {-msg "Input your name"}
    age {-msg "Input your age"}
} {
    makeInput $tag $msg
}

# calling
set a [ask-user-name]
set b [ask-user-age]
puts "user name =>$a"
puts "user age =>$b"
