
set tt to NODE( TIME:SECONDS + 100000, 0, 0, -2 ).  
add tt.  

if tt:orbit:hasnextpatch {
	print tt:orbit:nextpatch.
}
if encounter <> "None" {
	print "Encounter".
}

