# my regular expressions

doregexp {^[yY]} "sage:0.1" match 
doregexp {^[yY]} "yes or no - nobody knows" match 
doregexp {^(.*)\s+(\d{1,3})\s+(.*)$} "yes or no - nobody   34    knows" match text num rest
doregexp {^\#{1}\s+(.+)} "# Title here" match title
doregexp {^\#{1}\s+(.+)\s+} "# Title    here        " match title
doregexp {('|")(.*?)\1} "this is \"a test here\" make name" match t text
doregexp {('|")(.*?)\1} "this is \'a test here 2\' make name" match t text
