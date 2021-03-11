

SET sourceParts to SHIP:PARTSDUBBED("punt2").
SET destinationParts to SHIP:PARTSDUBBED("MK1Fuselage").

print "results". 
print sourceParts.
print destinationParts.  

SET foo TO TRANSFERALL("liquidfuel", sourceParts, destinationParts).
SET foo:ACTIVE to TRUE.


