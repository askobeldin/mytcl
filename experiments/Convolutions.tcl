# http://wiki.tcl.tk/11503
#
##+##########################################################################
#
# Convolutions.tcl - a tk port of a tcl port by Setok Lawson of a perl
# program written by Mikko "Ravel" Tuomela. The original program was
# designed as a party invitation to be run on a vt100.
# See http://www.altparty.org/archive/invi.tcl
#
# - original Alternative Party 2003 invitation intro by Mikko "Ravel"
#   Tuomela on 18-Nov-2002
# - conversion by Kristoffer "Setok" Lawson from the original perl
#   code with several optimisations making it noticably faster.
# - conversion to tk by Keith Vetter
 
package require Tcl 8.4
package require Tk
 
set S(title) "Convolutions"
set S(columns) 80
set S(rows) 40
set S(ObAmount) 2
 
set S(MaxColumns) 100
set S(MaxRows) 100
 
set S(go) 1                                     ;# For starting and stopping
set S(precalc) 0                                ;# Flag for precalc needed
set S(pause) 0                                  ;# Variable to vwait on
set S(reset) 0
 
set Chars {
    "OOOO    "
    "  .,+o$M"
    "@@ == @@"
    "-\"!*.._#"
    "OO  OO  "
    "M¤o+,.  "
    "O O O O "
    "OO      "
    "..  MM  "
}
 
 
set Text {
    "   Ravel and Setok present    "
    "   a Sleber Eid production    " 
    "   the first ever Tcl demo!   "
    "   and an invitation to       "
    "   Alternative Party 2003     "
    "   10th-12th January 2003     "
    "   Gloria Helsinki Finland    "
    "   http://www.altparty.org/   "
    "   Press Ctrl-C to stop       "
}
 
set Text {
    "Keith Vetter presents"
    "a tk port"
    "of a tcl port by Setok Lawson"
    "of a perl program by Ravel Tuomela"
    "http://www.altparty.org/"
}
 
 
# Weird construct: $effectCode is a procedure template which gets
# modified via string map for each different effect.
#
# The text %HEIGHT% from the code should be replaced (f.ex. by using
# [string map]) with the code to set the value for height of that
# particular character.
# The text %HEIGHTLIMITER% should be replace with the code to convert
# an existing height value (in the 'height' variable) with a value
# that limits it to 0-7.
 
#
# Variables that can be used at the point of %HEIGHT% execution:
# 'x','y'   X and Y position of character being drawn.
# 'ob   Number of object handled.
# 'obCenterX', 'obCenterY'   X and Y position of object center.
# 'distance'  Two-dimensional distance table.
# 'altDistance'  Alternative to 'distance'.
# 'S(ObAmount)'  Amount of objects.
# 'obNum'  Set to 0, increase in the loop if you need it.
#
# At %HEIGHTLIMITER% the additional 'height' variable can be used.
#
# No, not the most beautiful possible.
 
set effectCode {
    global part Chars S Text Part
    if {$S(precalc)} {
        set S(precalc) 0
        precalc
        .t config -height [expr {$::S(rows)+1}] -width [expr {$::S(columns) + 1}]
        after idle [list [lindex [info level 0] 0] $::Distance $::Coords]
        return
    }

    if {$part < [llength $Text]} {
        set charset [split [lindex $Chars $part] ""]
        set msg [lindex $Text $part]

        apply {{time rows columns ObAmount effect msg charset distance coords} {
            global part S
            if {$time <= 100} {
                if {$S(go)} {
                    #if {$S(reset)} return  ;# Reset, so starts anew
                    if {$S(reset)} {
                        set S(reset) 0
                        after idle [list $effect $::Distance $::Coords]
                        return
                    }
                    set full ""
                    for {set y 0} {$y <= $rows} {incr y} {
                        for {set x 0} {$x <= $columns} {incr x} {
                            set height 0                    
                            set flipflop 1  ;# Required by FX 2
                            foreach ob $coords {
                                incr height %HEIGHT%
                            } 
                            set height %HEIGHTLIMITER%
                            append full [lindex $charset $height]
                        }
                        append full "\n"
                    }
         
                    Show $full $msg
         
                    # Move circles
                    for {set ob 0} {$ob < $ObAmount} {incr ob} {
                        lset coords $ob 0 [expr {[lindex $coords $ob 0] + 
                                                   [lindex $coords $ob 2]}]
                        lset coords $ob 1 [expr {[lindex $coords $ob 1] +
                                                   [lindex $coords $ob 3]}]
                        if {([lindex $coords $ob 0] < 0) ||
                            ([lindex $coords $ob 0] > $columns)} {
                            lset coords $ob 2 [expr {-[lindex $coords $ob 2]}]
                        }
                        if {([lindex $coords $ob 1] < 0) ||
                            ([lindex $coords $ob 1] > $rows)} {
                            lset coords $ob 3 [expr {-[lindex $coords $ob 3]}]
                        }
                        lset coords $ob 4 [expr {int([lindex $coords $ob 0])}]
                        lset coords $ob 5 [expr {int([lindex $coords $ob 1])}]
                    }
                    incr time
                }
                after idle [lrange [info level 0] 0 1] [list \
                    $time $rows $columns $ObAmount $effect $msg $charset $distance $coords]
            } else {
                incr part
                after idle [list $effect $distance $coords]
            }
        }} 0 $S(rows) $S(columns) $S(ObAmount) [lindex [info level 0] 0] $msg $charset $distance $coords

    } else {
        incr ::eidx
    }
}

 
# For testing purposes. We want the output to be exactly the same every time.
##expr {srand(5)}
 
proc precalc {} {
    global Distance AltDistance Coords S
 
    set Distance {}
    set AltDistance {}
    set Coords {}
 
    for {set x 0} {$x <= 200} {incr x} {
        set innerDistance [list]
        set innerAltDistance [list]
        for {set y 0} {$y <= 200} {incr y} {
            lappend innerDistance [expr { int(sqrt(pow($x, 2) + pow($y, 2)))}]
            lappend innerAltDistance \
                [expr { int(sqrt(abs(pow($x, 2) - pow($y, 2))))}]
        }
        lappend Distance $innerDistance
        lappend AltDistance $innerAltDistance
    }
 
    for {set ob 0} {$ob < $S(ObAmount)} {incr ob} {
        set inner [list [expr { rand() * $S(columns)}] \
                       [expr { rand() * $S(rows)}] \
                       [expr { rand() * 2}] \
                       [expr { rand() * 2}]]
        lappend inner [expr { int([lindex $inner 0])}]
        lappend inner [expr { int([lindex $inner 1])}]
        if {rand()*10 < 5} {
            lset inner 2 "-[lindex $inner 2]"
        } 
        if {rand()*10 < 5} {
            lset inner 3 "-[lindex $inner 3]"
        }
        lappend Coords $inner
    }
}
 
 
proc effect1 {distance coords} \
    [string map {
        %HEIGHT% {[expr {
                         [lindex $distance \
                              [expr {abs($x - [lindex $ob 4])}] \
                              [expr {abs($y - [lindex $ob 5])}]]
                         & 0x7}]}
        %HEIGHTLIMITER% {[expr {$height / $S(ObAmount)}]}
    } $effectCode]
 
 
 
proc effect2 {distance coords} \
    [string map {
        %HEIGHT% {[expr {$flipflop * \
                             [lindex $distance \
                                  [expr {abs($x - [lindex $ob 4])}] \
                                  [expr {abs($y - [lindex $ob 5])}]]
                     }]
            #       incr obNum
            set flipflop [expr {-$flipflop}]
        }
        %HEIGHTLIMITER% {[expr {$height % 8}]}
    } $effectCode]
 
##+##########################################################################
# 
# DoDisplay -- puts up our GUI
# 
proc DoDisplay {} {
    global S
    
    wm title . $::S(title)
    wm protocol . WM_DELETE_WINDOW exit
    frame .ctrl -relief ridge -bd 2 -padx 5 -pady 5
    frame .screen -bd 0 -relief raised
 
    label .t -font {Courier 8} -textvariable S(txt) -relief ridge \
        -height [expr {$::S(rows)+1}] -width [expr {$::S(columns) + 1}] 
    label .l -textvariable S(msg)
    .l configure  -font "[font actual [.l cget -font]] -weight bold"
    option add *font [.l cget -font]
    
    scale .rows -from 10 -to $S(MaxRows) -command {Resize rows} -orient h \
        -variable S(rows) -relief raised -label Rows
    scale .cols -from 10 -to $S(MaxColumns) -command {Resize cols} -orient h \
        -variable S(columns) -relief raised -label Columns
    scale .objs -from 1 -to 8 -command {Resize objs} -orient h \
        -variable S(ObAmount) -relief raised -label "Objects"
 
    checkbutton .stop -variable S(go) -text "Pause" -relief raised
 
    bind all <Key-F2> {console show}
    bind .l <Configure> {
        precalc
        set eidx 0
    }
    pack .ctrl -side left -fill both -ipady 5
    pack .screen -side right -fill both -expand 1
    pack .t -side top -fill both -expand 1 -in .screen
    pack .l -side bottom -fill x -expand 1 -in .screen
    grid .rows -in .ctrl -sticky ew -row 0
    grid .cols -in .ctrl -sticky ew
    grid .objs -in .ctrl -sticky ew
    grid .stop -in .ctrl -pady 50 -sticky ew -ipady 5
 
    grid rowconfigure .ctrl 100 -weight 1
}
##+##########################################################################
# 
# Show -- displays current screen and message
# 
proc Show {what msg} {
    set ::S(txt) [string trimright $what]
    set ::S(msg) $msg
}
##+##########################################################################
# 
# Resize -- called when screen is resized or number of objects changes
# 
proc Resize {args} {
    set ::S(precalc) 1                          ;# Need to recalc everything
}
##+##########################################################################
# 
set effects { 
    {effect1 $Distance $Coords}
    {effect1 $AltDistance $Coords}
    {effect2 $Distance $Coords}
    {effect2 $AltDistance $Coords}
}

trace add variable eidx write {
    set part 0
    after idle {eval [lindex $::effects [expr {$eidx % [llength $::effects]}]]}
    # this backslash eats the arguments to the trace \
}

DoDisplay
