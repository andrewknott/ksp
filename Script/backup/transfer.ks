
PARAMETER sourceName.
PARAMETER destinationName.

SET sourceParts to SHIP:PARTSDUBBED(sourceName).
SET destinationParts to SHIP:PARTSDUBBED(destinationName).


//SET sourceParts to SHIP:PARTSDUBBED("Rockomax64.BW").
//SET destinationParts to SHIP:PARTSDUBBED("MK1Fuselage").

print "xfer from & to: ". 
print sourceParts.
print destinationParts.  

SET foo TO TRANSFERALL("liquidfuel", sourceParts, destinationParts).
SET foo:ACTIVE to TRUE.


print "xfer started.".  
