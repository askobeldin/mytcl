# http://pleac.sourceforge.net/pleac_tcl/datesandtimes.html


# 3. Dates and Times #

## Introduction ##

# A single command, [clock], is used for a wide range
# of date/time-related tasks.  Subcommands include
# seconds, which returns a seconds-since-epoch value,
# and format, which formats a date/time-string like
# the result of POSIX strftime.

# get current time in epoch seconds
set now [clock seconds]
# print default-formatted time
puts [clock format $now]
# print custom formatted time
set fmt "Today is day %j of the current year."
puts [clock format $now -format $fmt]


## Finding Today's Date ##

set now [clock seconds]
foreach {day month year} [clock format $now -format "%d %m %Y"] break

set now [clock seconds]
set fmt "%Y-%m-%d"
puts "The current date is [clock format $now -format $fmt]."

## Converting DMYHMS to Epoch Seconds ##

# this is one of several possible variants of scannable
# date/time strings; clock scan is considerably more
# versatile than the Perl functions in this recipe.
#set time [clock scan "$hours:$min:$sec $year-$mon-$mday"]
# => 999955820

#set time [clock scan "$hours:$min:$sec $year-$mon-$mday" -gmt yes]
# => 999963020


## Converting Epoch Seconds to DMYHMS ##

if {[string match *.test [info script]]} {
    # we are testing, supply a known value
    set now 1000000000
} else {
    set now [clock seconds]
}
set vars [list seconds minutes hours dayOfMonth month year wday yday]
set desc [list S       M       H     d          m     Y    w    j]
foreach v $vars d $desc {
    set $v [clock format $now -format %$d]
}
format %s-%s-%sT%s:%s:%s $year $month $dayOfMonth $hours $minutes $seconds
# => 2001-09-09T03:46:40

if {[string match *.test [info script]]} {
    # we are testing, supply a known value
    set now 1000000000
} else {
    set now [clock seconds]
}
set vars [list seconds minutes hours dayOfMonth month year wday yday]
set desc [list S       M       H     d          m     Y    w    j]
foreach v $vars d $desc {
    set $v [clock format $now -format %$d -gmt yes]
}
format %s-%s-%sT%s:%s:%s $year $month $dayOfMonth $hours $minutes $seconds
# => 2001-09-09T01:46:40


## Adding to or Subtracting from a Date ##

#     set when [expr {$now + $difference}]
#     set when [expr {$now - $difference}]

# The following is slightly more idiomatic:

#     set when [clock scan "$difference seconds"]
#     set when [clock scan "$difference seconds ago"]
#     set when [clock scan "-$difference seconds"] ;# same as previous

set newTime [clock scan "$y-$m-$d $offset days"]
foreach {y2 m2 d2} [clock format $newTime -format "%Y %m %d"] break
return [list $y2 $m2 $d2]

set oldTime [clock scan $time]
set newTime [clock scan "
    $daysOffset days
    $hourOffset hours
    $minuteOffset minutes
    $secondOffset seconds
" -base $oldTime]


## Difference of Two Dates ##

set bree [clock scan "16 Jun 1981 4:35:25"]
set nat  [clock scan "18 Jan 1973 3:45:50"]
set difference [expr {$bree - $nat}]
format "There were $difference seconds between Nat and Bree"
# => There were 265333775 seconds between Nat and Bree

set bree [clock scan "16 Jun 1981 4:35:25"]
set nat  [clock scan "18 Jan 1973 3:45:50"]
set difference [expr {$bree - $nat}]
set vars    {seconds minutes hours days}
set factors {60      60      24    7}
foreach v $vars f $factors {
    set $v [expr {$difference % $f}]
    set difference [expr {($difference-[set $v]) / $f}]
}
set weeks $difference
format "($weeks weeks, $days days, $hours:$minutes:$seconds)"
# => (438 weeks, 4 days, 23:49:35)


## Day in a Week/Month/Year or Week Number ##

set then [clock scan 6/16/1981]
set format {
%Y-%m-%d was a %A
in week number %W,
and day %j of the year.
}
clock format $then -format $format
# => 
# =>         1981-06-16 was a Tuesday
# =>         in week number 24,
# =>         and day 167 of the year.
# =>         


## Parsing Dates and Times from Strings ##

# The [clock scan] command parses a wide variety of date/time
# strings, converting them to epoch seconds.

# Examples:

#     set t [clock scan "1998-06-03"]
#     set t [clock scan "2 weeks ago Friday"]
#     set t [clock scan "today"]

#     # second Sunday of 1996:
#     set t [clock scan "Sunday" -base [clock scan "1996-01-01 1 week"]]

# The result can be converted to lists of year, month, etc
# values or to other date/time strings by the [clock format]
# command.


## Printing a Date ##

puts [clock format [clock scan 01/18/73] -gmt yes]
# => Wed Jan 17 23:00:00 GMT 1973

puts [clock format [clock scan 01/18/73] -format "%A %D"]
# => Thursday 01/18/73

set format "%a %b %e %H:%M:%S %Z %Y"
puts [clock format [clock scan "18 Jan 1973 3:45:50 GMT"] -format $format -gmt yes]
# => Thu Jan 18 03:45:50 GMT 1973


## High-Resolution Timers ##

puts "Press return when ready"
set before [clock clicks -milliseconds]
gets stdin
set elapsed [expr {([clock clicks -milliseconds] - $before) / 1000.0}]
puts "You took $elapsed seconds"

set size 500
set numberOfTimes 100
set a [list]
for {set j 0} {$j < $size} {incr j} {
    lappend a [expr {rand()}]
}
puts "Sorting $size random numbers:"
puts [time {
    set a [lsort -real $a]
} $numberOfTimes]
