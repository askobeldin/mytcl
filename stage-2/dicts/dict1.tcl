# Ousterhout
# ch. 7, pg. 178
#
set example {firstname Joe surname Schmoe title Mr}
puts "--- 1 ---"
puts [dict get $example surname]

set prefers {
    Joe {the easy life}
    Jeremy {fast cars}
    {Uncle Sam} {motherhood and apple pie}
}

puts "--- 2 ---"
puts [dict get $prefers Joe]
puts [dict get $prefers "Uncle Sam"]

set employees {
    0001 {
        firstname Joe
        surname Schmoe
        title Mr
    }
    1234 {
        firstname Ann
        initial E
        surname Huan
        title Miss
    }
}

puts "--- 3 ---"
puts [dict get [dict get $employees 1234] firstname]
