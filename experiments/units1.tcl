# try to use units module
#
#
package require units

# kgf - is a killogramm of forse unit
::units::new kgf "9.8 N"

set moment "0.18 kgf*cm"
set destunits "N*m"

puts "Convert $moment to $destunits: [::units::convert $moment $destunits]"
