# dict experiments
#
#
# Make a dictionary to map extensions to descriptions
set filetypes [dict create .txt "Text File" .tcl "Tcl File"]

# Add/update the dictionary
dict set filetypes .tcl "Tcl Script"
dict set filetypes .tm  "Tcl Module"
dict set filetypes .gif "GIF Image"
dict set filetypes .png "PNG Image"
dict set filetypes .pdf "PDF document epta!"
dict set filetypes .tst "Testing file"

# Simple read from the dictionary
set ext ".tcl"
set desc [dict get $filetypes $ext]
puts "$ext is for a $desc"
puts [string repeat - 50]


# Somewhat more complex, with existence test
foreach filename [lsort [glob *]] {
    set ext [file extension $filename]
    if {[dict exists $filetypes $ext]} {
        # puts "$filename is a [dict get $filetypes $ext]"
        puts [format "%-30s%-30s" $filename [dict get $filetypes $ext]]
    }
}
