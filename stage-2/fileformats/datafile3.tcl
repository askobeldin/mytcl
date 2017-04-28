# datafile 3
# parts and asseblies structure

prt d1 name1
prt d2 name2

asm d3 name3 {
    prt d4
    asm a202 name-a202
    prt d5
}

asm d7 name7 {
    asm d8 name8 {
        prt d10
        prt d11
    }
    prt d12 name12
    prt d13
    asm a201 name-a201
    asm d15 "assy num. 15" {
        prt d140
        prt d141
        asm a100 name-a100 {
            asm a101 name-a101 {
                prt d148
                prt d149
            }
            prt d145
            prt d146
            prt d147
        }
    }
}

prt d150 name150
prt d151 name151
asm a200 name-a200
