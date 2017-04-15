#! /usr/bin/tclsh

if { $argc eq 0 } {
    puts "Печать hex-дампа файла
Использование: $argv0 имя_файла"
    exit 0
}
if ![file exists $argv] {
    puts "Файл не найден"
    exit 1
}
set fl [open $argv r]
fconfigure $fl -translation binary
while {![eof $fl]} {
    set str ""
    puts -nonewline [format "%08x   " [tell $fl]]
    set a [read $fl 16]
    foreach sym [split $a {}] {
        set c [scan $sym %c]
        puts -nonewline [format "%02x " $c]
        if {$c < 32 || $c > 126} {
            append str .
        } else {
            append str [format %c $c]
        }
    }
    puts \t$str
}
close $fl
