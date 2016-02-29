proc Serve {chan addr port} {
    fconfigure $chan -translation auto -buffering line
    set line [gets $chan]
    set path [file join . [string trimleft [lindex $line 1] /]]
    if { $path == "." } {set path ./index.html}
    if { $path == "./reload" } {
        set reload 1
        source [info script]
        puts $chan "HTTP/1.0 200 OK"
        puts $chan "Content-Type: text/html"
        puts $chan ""
        puts $chan "Server reloaded"
    } else {
	   puts "Request: $path"                ;##
        if { [catch {
            set fl [open $path]
        } err] } {
            puts $chan "HTTP/1.0 404 Not Found"
        } else {
            puts $chan "HTTP/1.0 200 OK"
            puts $chan "Content-Type: text/html"
            puts $chan ""
            puts $chan [read $fl]
            close $fl
        }
    }
        close $chan
 }

 #catch {console show}                ;##
 if { ! [info exists reload] } {
    set sk [socket -server Serve 8090]
    vwait forever
 } else {
    unset reload
 }
