

lock steering to prograde.  

wait 6. 

print "Warp jumps until prograde towards the sun.". 
lock delta to ship:facing - sun:direction. 

until (abs(delta:yaw) < 4) {
	print delta:yaw.  
	set kuniverse:timewarp:warp to 2.
	if abs(delta:yaw) > 25 {  
		set kuniverse:timewarp:warp to 3.
		if abs(delta:yaw) > 85 {
			wait 85.
		}
		if abs(delta:yaw) > 45 {
			wait 85.
		}
		wait 85.  
		set kuniverse:timewarp:warp to 0.
	}
	wait 10. 
	set kuniverse:timewarp:warp to 0.
	wait 9. 
}
	
print delta:yaw.

SET escape to NODE( TIME:SECONDS + abs(ETA:APOAPSIS - ETA:PERIAPSIS)*1.05, 0, 0, 960 ).
ADD escape.

if encounter = "None" {
	wait 1.
	run execute_node.ks.  
	remove escape. 	
	wait 1.
} else { 
	print "Running into " + encounter:body.  
	set kuniverse:timewarp:warp to 4.
	wait abs(ETA:APOAPSIS - ETA:PERIAPSIS)*1.85. 
	set kuniverse:timewarp:warp to 0.	
	wait 20. 
	remove escape.  	
	run sun.ks.
} 