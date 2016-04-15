# my regular expressions

doregexp {^[yY]} "sage:0.1" match 
doregexp {^[yY]} "yes or no - nobody knows" match 
doregexp {^(.*)\s+(\d{1,3})\s+(.*)$} "yes or no - nobody   34    knows" match text num rest
