# http://daapp.livejournal.com/5681.html
# С чистого листа
# Данилов Александр
#
#
package require Tk
package require Ttk

namespace eval editor {
    variable win .editor

    namespace ensemble create -subcommands {
        show hide
    }
}

proc editor::show {} {
    variable win

    if { ! [winfo exists $win]} {
        set f [toplevel $win]

        ttk::scrollbar $f.sx -orient horizontal -command [list $f.text xview]
        ttk::scrollbar $f.sy -orient vertical   -command [list $f.text yview]
        text $f.text -xscrollcommand [list $f.sx set] \
                     -yscrollcommand [list $f.sy set]

        grid $f.sy -row 0 -column 1 -sticky ns
        grid $f.sx -row 1 -column 0 -sticky ew
        grid $f.text -row 0 -column 0 -sticky nsew
        grid columnconfigure $f 0 -weight 1
        grid rowconfigure $f 0 -weight 1

        bind $f.text <F9> {puts [eval [%W get 0.0 end]]}
        bind $f.text <Control-F9> {
            %W insert end [eval [%W get sel.first sel.last]]
        }

        bind $f.text <Control-o> [namespace current]::Open
        bind $f.text <Control-s> [namespace current]::Save
    }
}

proc editor::hide {} {
    variable win

    destroy $win
}

proc editor::Save {} {
    variable win

    set filename [tk_getSaveFile -parent $win]
    if {$filename ne ""} {
        if {[catch {set f [::open $filename w]} errorMessage]} {
            tk_messageBox -type ok -icon error \
                -message "Unable to save file \"$filename\": $errorMessage"
        } else {
            chan puts -nonewline $f [$win.text get 0.0 end]
            chan close $f
        }
    }
}

proc editor::Open {} {
    variable win

    set filename [tk_getOpenFile -parent $win]
    if {$filename ne ""} {
        if {[catch {set f [::open $filename r]} errorMessage]} {
            tk_messageBox -type ok -icon error \
                -message "Unable to open file \"$filename\": $errorMessage"
        } else {
            $win.text delete 0.0 end
            $win.text insert end [chan read $f]
            chan close $f
        }
    }
}
