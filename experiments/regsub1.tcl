# regsub experiments
#
#
set file tclIO.c
set r1 {([^\.]*)\.c$}

# regsub {([^\.]*)\.c$} $file {cc -c & -o \1.o} ccCmd
regsub $r1 $file {cc -c & -o \1.o} ccCmd
puts $ccCmd

# do nothing
regsub $r1 test.html {cc -c & -o \1.o} ccCmd
puts $ccCmd


set string "The regular      expression metacharacters       in \$unique1 and \$unique need 
to be quoted so they are not     treated as metacharacters."

regsub -all {\s+} $string " " string
puts $string
