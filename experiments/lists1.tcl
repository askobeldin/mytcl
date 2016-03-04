# For each sub-list:
# - index 0 = the user's name
# - index 1 = a list of {home value}
# - index 2 = a list of {id value}
# - index 3 = a list of {shell value}
set users {
    {john {home /users/john} {id 501} {shell bash}}
    {alex {home /users/alex} {id 502} {shell csh}}
    {neil {home /users/neil} {id 503} {shell zsh}}
}   

# Search for user name == neil
set term neil
puts "Search for name=$term returns: [lsearch -index 0 $users $term]"; # 2

# Search for user with id = 502. That means we first looks at index
# 2 for {id value}, then index 1 for the value
set term 502
puts "Search for id=$term returns: [lsearch -index {2 1} $users $term]"; # 1

# Search for shell == sh (should return -1, not found)
set term sh
puts "Search for shell=$term returns: [lsearch -index {3 1} $users $term]"; # -1
