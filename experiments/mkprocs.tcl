# try to make some procs dynamically
# it doesn't work
#
foreach {tag msg} {
    name "Input your name"
    age "Input your age"
} {
    proc ask-user-$tag {} [list
        [list set tmsg $msg]
        [list append tmsg ": "]
        [list flush stdout]
        [list puts -nonewline $tmsg]
        [list return [gets stdin]]]
}

# calling
set a [ask-user-name]
puts "user name is $a"
