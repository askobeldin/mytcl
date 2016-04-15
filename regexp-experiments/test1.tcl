# my regular expressions

doregexp {([^:]*):} "sage:0.1" match host
doregexp {([^:]+)://([^:/]+)(:([0-9]+))?(/.*)} "http://www.beedub.com:80/index.html" \
    match protocol server x port path
doregexp {([^:-]*)-} "sage-0.1" match host
doregexp {([^:-]*)-([0-9]*?).([0-9]*?)} "sage-03.142" match host n1 n2
doregexp {([^:-]*)-(\d*?).(\d*?)} "sage-03.142" match host n1 n2
