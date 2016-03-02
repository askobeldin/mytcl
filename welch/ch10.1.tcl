# experiment about chapter 10 
#
#

proc foo {} {
    puts "this is \"foo\""
}

# button .foo -text FOO -command foo
# pack .foo -side left


# ========================================
# first variant
# proc PackedButton {name txt cmd} {
    # button $name -text $txt -command $cmd
    # pack $name -side left
# }

# PackedButton .foo "code epta" foo
# ========================================

##########################################
# good variant
proc PackedButton {path txt cmd {pack {-side right}} args} {
    eval {button $path -text $txt -command $cmd} $args
    eval {pack $path} $pack
}

PackedButton .foo "red" {foo} {-side right} -background red
PackedButton .bar "yellow" {foo} {-side right} -background yellow
PackedButton .baz "green" {foo} {-side left} -background green
PackedButton .ban "cyan" {foo} {-side left} -background cyan
