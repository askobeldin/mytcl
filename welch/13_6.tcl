#
# Example 13-6
# A procedure to read and evaluate commands.
#

proc Command_Process {inCmd outCmd} {
	global command
	append command(line) [eval $inCmd]
	if {[info complete $command(line)]} {
		set code [catch {uplevel #0 $command(line)} result]
		eval $outCmd {$result $code}
		set command(line) {}
	}
}

proc Command_Read {{in stdin}} {
	if {[eof $in]} {
		if {$in != "stdin"} {
			close $in
		}
		return {}
	}
	return [gets $in]
}

# my changes
proc Command_Display {file result code} {
    # my change
    # set s [string repeat = 80]
    # puts stdout $s
    # puts stdout "FILE: $file, RESULT: $result, CODE: $code"
    # puts stdout $s
	puts stdout $result
}


while {![eof stdin]} {
	Command_Process {Command_Read stdin} \
		{Command_Display stdout}
}


