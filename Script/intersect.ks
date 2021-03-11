

set t to 1000. 

set done to 0.

until done = 1 {
	until t > 10000000 {  
	
		set dv to 500.  
	
		until dv > 750 {
			set test to NODE( TIME:SECONDS + t, 0, 0, dv ).
			add test. 
		
			if test:orbit:hasnextpatch {
				print "Found " + test:orbit:nextpatch:body:name.
				set peri to test:orbit:nextpatch:periapsis. 
				set done to 1. 
				break.
			}
			remove test. 
			set dv to dv + 1. 
		}
		if done = 1 {
			print "Outer found".
			break.
		}
	
		set t to t + 100000. 
	} 
	if t < 10000000 {	
		Print "Starting Peri: " + peri.  
		remove test. 
		set done to 1.
	} else {
		print "No intersect found.  Warping.".  
		kuniverse:timewarp:warpto(time:seconds + 10000000).
		wait until time:seconds + 99000000.
		wait 2. 
		set t to 1000.  

	}

}

print "Found an intersection.  Adjusting time.". 
wait 1. 

set d to 0.  
set t to t - 50000. 

until d > 100000 {

	set d to d + 500.  
	set test2 to NODE( TIME:SECONDS + t + d, 0, 0, dv ).  
	add test2.  

	if test2:orbit:hasnextpatch  {
		if (test2:orbit:nextpatch:periapsis < peri and test2:orbit:nextpatch:periapsis > 100000)   { 
			set test to NODE(TIME:SECONDS + t + d, 0, 0, dv).  
			set peri to test2:orbit:nextpatch:periapsis. 
//			print d + "New Peri " + peri. 
			set new_t to t + d.  
		}
	}
	remove test2.  
}

print "New Peri " + peri. 

add test.  

wait 5.  

remove test. 
print "Adjusting normal.". 

set z to -100.  

until z > 100 { 
	set test2 to NODE( TIME:SECONDS + new_t, 0, z, dv ).  
	add test2.  
	if test2:orbit:hasnextpatch {
//		print z + " has peri " + encounter:periapsis.  
		if (test2:orbit:nextpatch:periapsis < peri and test2:orbit:nextpatch:periapsis > 100000) { 
			set test to NODE(TIME:SECONDS + new_t, 0, z, dv).  
			set peri to test2:orbit:nextpatch:periapsis. 
//			print z  + " New Peri " + peri. 
		}
	}
	set z to z + 1.  
	remove test2.  
}

print "New Peri " + peri. 


add test. 

wait 1. 
set e to test:orbit:nextpatch:epoch.  
print e. 

run execute_node.  

lock steering to north.  
wait 15. 

set kuniverse:timewarp:warp to 7.
wait until (time:seconds > e*0.90).  
set kuniverse:timewarp:warp to 0.

until kuniverse:timewarp:issettled {
//    print "rate = " + round(kuniverse:timewarp:rate,1).
    wait 0.1.
}

remove test.


 

