# regexp testing
#
#
#
set env(DISPLAY) sage:0.1
set r1 {([^:]*):}

# regexp {([^:]*):} $env(DISPLAY) match host
regexp $r1 $env(DISPLAY) match host
puts "Apply regexp \"$r1\" to \"$env(DISPLAY)\""
puts "match is \"$match\""
puts "host is $host"
puts [string repeat = 80]

set url http://www.beedub.com:80/index.html
set r2 {([^:]+)://([^:/]+)(:([0-9]+))?(/.*)}
# regexp {([^:]+)://([^:/]+)(:([0-9]+))?(/.*)} $url \
    # match protocol server x port path
regexp $r2 $url match protocol server x port path
puts "Apply regexp \"$r2\" to \"$url\""
puts "match is $match"
puts "protocol is $protocol"
puts "server is $server"
puts "x is $x"
puts "port is $port"
puts "path is $path"

