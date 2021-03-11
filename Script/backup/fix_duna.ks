

 
set kuniverse:timewarp:warp to 0.

until kuniverse:timewarp:issettled {
//    print "rate = " + round(kuniverse:timewarp:rate,1).
    wait 0.1.
}


print "fixing normal".
set t to 1000. 
set z to -20.
set peri to 999999999.  

until z > 20 { 
	set test2 to NODE( TIME:SECONDS + t, 0, z, 0).  
	add test2.  
	if test2:orbit:hasnextpatch {
//		print z + " has peri " + encounter:periapsis.  
		if (test2:orbit:nextpatch:periapsis < peri  and test2:orbit:nextpatch:periapsis > 100000) { 
			set test to NODE(TIME:SECONDS + t, 0, z, 0).  
			set peri to test2:orbit:nextpatch:periapsis. 
//			print z  + " New Peri " + peri. 
		}
	}
	set z to z + 0.11.  
	remove test2.  
}

add test.  

if (abs(test:normal) > 0.15) { 
	run execute_node.ks. 
} else {
	print "burn too small, skipping.". 
}

wait 1. 
set peri to test:orbit:nextpatch:periapsis.

remove test. 



print "fixing radial".

set t to 1000. 
set z to -5.

set target_z to 0.  
until z > 5 { 
	set test2 to NODE( TIME:SECONDS + t, z, 0, 0).  
	add test2.  
	if test2:orbit:hasnextpatch {
		wait 0.1.
		if (test2:orbit:nextpatch:periapsis < peri and test2:orbit:nextpatch:periapsis > 50000) { 
			set test to NODE(TIME:SECONDS + t, z, 0, 0).  
			set peri to test2:orbit:nextpatch:periapsis. 
//			print z  + " New Peri " + peri. 
		}
	}
	set z to z + 0.1.  
	remove test2.  
}

add test.  

if (abs(test:radialout) > 0.15) { 
	run execute_node.ks.
} else {
	print "burn too small, skipping.". 
}

remove test. 


print "finished fixing duna orbit.". 

lock steering to north.  
wait 15. 

