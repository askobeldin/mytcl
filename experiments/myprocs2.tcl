# http://stackoverflow.com/questions/2341441/how-can-i-safely-deal-with-optional-parameters
#
#

# Your proc definition is incorrect (you'd get the error message too many
# fields in argument specifier "comment = """). Should be:

# proc dump_header { test description {comment ""}} {
    # puts $comment
# }

# If you want to use args, you could examine the llength of it:

# proc dump_header {test desc args} {
    # switch -exact [llength $args] {
        # 0 {puts "no comment"}
        # 1 {puts "the comment is: $args"}
        # default {
            # puts "the comment is: [lindex $args 0]"
            # puts "the other args are: [lrange $args 1 end]"
        # }
    # }
# }

# You might also want to pass name-value pairs in a list:

# proc dump_header {test desc options} {
    # # following will error if $options is an odd-length list
    # array set opts $options

    # if {[info exists opts(comment)]} {
        # puts "the comment is: $opts(comment)"
    # }
    # puts "here are all the options given:"
    # parray opts
# }

# dump_header "test" "description" {comment "a comment" arg1 foo arg2 bar}

# Some prefer a combination of args and name-value pairs (a la Tk)

proc dump_header {test desc args} {
    # following will error if $args is an odd-length list
    array set opts $args
    if {[info exists opts(-comment)]} {
        puts "the comment is: $opts(-comment)"
    }
    parray opts
}

dump_header "test" "description" -comment "a comment" -arg1 foo -arg2 bar
dump_header тест описание -comment "это комментарий, бля!" \
-arg1 фоо -arg2 бар
