# Welch 
# code 8.10
#

proc RecordAppend {listName arrayName} {
    upvar $listName list
    lappend list $arrayName
}

proc RecordIterate {listName script} {
    upvar $listName list
    foreach arrayName $list {
        upvar #0 $arrayName data
        eval $script
    }
}

### script
array set a1 {
    k1 "value 1"
    k2 "value 2"
    k3 "value 3"
}

array set a2 {
    k1 "value 12"
    k2 "value 22"
    k3 "value 32"
}

array set a3 {
    k1 "value 13"
    k2 "value 23"
    k3 "value 33"
}


RecordAppend mylst a1
RecordAppend mylst a2
RecordAppend mylst a3

RecordIterate mylst {foreach {k v} [array get data] {puts "$k: $v"}}

puts "======================="

RecordIterate mylst {foreach {n} [array names data] {puts "name is $n"}}
