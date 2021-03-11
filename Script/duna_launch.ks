lock steering to up.
rcs on.



lock throttle to 1.

print "going up " . 
wait 2. 

gear off. 

wait 18. 

//retract gear. 

print "First turn". 

lock steering to  HEADING(90, 45). 

wait 10.

print "Prograde.".  

lock steering to prograde.

wait until SHIP:APOAPSIS > 65000. 

print "circularizing".  

lock throttle to 0.

wait 1. 

kuniverse:timewarp:warpto(time:seconds + ETA:APOAPSIS - 45).

wait until ETA:APOAPSIS < 17.

lock throttle to 1.

wait until SHIP:PERIAPSIS > 55000. 

lock throttle to 0.

print "In orbit.".
