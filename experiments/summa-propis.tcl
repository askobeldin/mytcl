# По словам Anton Kovalenko, "КЛАДР напомнил о бурной юности..", и он прислал
# мне кусок своего кода, любезно разрешив его опубликовать на правах Public
# Domain:

namespace eval speller {
    set names(19) { 
        {ноль} {один одна} {два две} три четыре пять шесть семь восемь девять 
        десять одиннадцать двенадцать тринадцать четырнадцать пятнадцать
        шестнадцать семнадцать восемнадцать девятнадцать}
    
    set names(90) { {} {}
        двадцать тридцать сорок пятьдесят шестьдесят 
        семьдесят восемьдесят девяносто }
    
    set names(900) { {}
        сто двести триста четыреста пятьсот шестьсот 
        семьсот восемьсот девятьсот}
    
    set major_triads {
        {1 тысяч а и {} 0} 
        {0 миллион {} а ов 0} 
        {0 миллиард {} а ов 0} 
        {0 триллион {} а ов 0} 
        {0 квадриллион {} а ов 0} 
        {0 квинтиллион {} а ов 0} 
        {0 секстиллион {} а ов 0} 
    }
    
    set rur_descrip {0 рубл ь я ей 1}
    
    set kop_descrip {1 копе йка йки ек 1}
    
    proc spell {num descrip {usercall 0}} {
        variable names
        foreach {female root one two five spellZero} [lindex $descrip 0] {break}
        set sexindex [lindex {0 end} $female]
        if {[string length $num] <4} {
            if {(![string length $num]) || (!$num)} {
                if {$spellZero} {
                    if {!$usercall} {
                        return $root$five
                    } else {
                        return "[lindex $names(19) 0] $root$five"
                    }
                } else {return {}}
            }
            if {$num<20} {
                switch $num {
                    1 {set suffix $one} 
                    2 - 3 - 4 {set suffix $two}
                    default {set suffix $five}
                }
                return "[lindex $names(19) $num $sexindex] $root$suffix"
            } elseif {$num<100} {
                return \
                "[lindex $names(90) [expr {$num/10}]] [spell [
                expr {$num % 10}] $descrip]"
            } else {
                return \
                "[lindex $names(900) [expr {$num/100}]] [spell [
                expr {$num % 100}] $descrip]"
            }
        } else {
            return "[string trim [spell [
            string range $num 0 end-3] [lrange $descrip 1 end]
            ]] [spell [string trimleft [string range $num end-2 end] 0] $descrip]"
        }
    }
    
    proc capitalize {str} {return [string toupper [string index $str 0]][
         string range $str 1 end]}
    
    proc spell-rur {num} {
        variable major_triads
        variable rur_descrip
        variable kop_descrip
        foreach {rub kop} [split $num .] {break}
        set str_rub [
            capitalize [spell $rub [concat [list $rur_descrip] $major_triads] 1]]
        set str_kop "$kop [lindex [spell $kop [list $kop_descrip]] end]"
        return $str_rub\ $str_kop
    }
}


puts [ speller::spell-rur 123000100.34 ]
puts [ speller::spell-rur 0.00 ]
puts [ speller::spell-rur 3.22 ]
puts [ speller::spell-rur 2718281231415926.53 ]
