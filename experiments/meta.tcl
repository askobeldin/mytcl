# http://wiki.tcl.tk/401
#
proc makeTemplate {procname templatename parmlist} {
    set arg  [info args $templatename]
    set body [info body $templatename]

    foreach {a b} $parmlist {
        # нет проверки на количество успешных замен
        regsub -all $a $body $b body
    }
    eval "proc $procname {$arg} {$body}"
}

proc FooTemplate {a b} {
    puts "MSG1"
    puts "hello, $a, $b"
    puts "MSG2"
}

makeTemplate foo1 FooTemplate {MSG1 "hello, епта!" MSG2 "бывай!"}
makeTemplate foo2 FooTemplate {MSG1 "hi!" MSG2 "bye!"}

foo1 mom dad
foo2 breathren cistern


# output:
#
# hello, епта!
# hello, mom, dad
# бывай!
# hi!
# hello, breathren, cistern
# bye!
