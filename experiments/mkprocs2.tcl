# try to make some procs dynamically
#
proc ask-user-template {msg} {
    set tmsg {$msg}
    append tmsg ": "
    puts -nonewline \$tmsg
    flush stdout
    return [gets stdin]
}

proc makeInput {procname msg {template ask-user-template}} {
    set body [info body $template]
    set msg $msg
    set body [subst -nocommands $body]
    eval "proc ask-user-$procname {} {$body}"
}

foreach {tag msg} {
    name "Input your name"
    age "Input your age"
} {
    makeInput $tag $msg
}

# calling
set a [ask-user-name]
puts "user name =>$a"
