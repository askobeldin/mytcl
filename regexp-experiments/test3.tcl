# my regular expressions

doregexp {^\#{1}\s+(.+)} "# Заголовок уровня один" match title
doregexp {^\#{1}\s+(.+)\s+} "# Тоже заголовок    уровня    один        " match title
