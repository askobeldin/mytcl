#!/usr/bin/env tclsh
# comment here
#
proc foo1 {arg} {
    puts $arg
}

foo1 "this is a foo"
foo1 "а тут текст по-русски"
foo1 "ебануться, this is english"
