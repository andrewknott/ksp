//ike landing.



set talt to 14000.
sas off.

lock steering to SHIP:UP  + R(0,90,0). 

set normalVec to vcrs(ship:velocity:orbit,-body:position).
set radialVec to vcrs(ship:velocity:orbit,normalVec).


if 	abs(ship:orbit:inclination) > 2 {
	lock steering to normalVec.
	print "Fixing inclination " + ship:orbit:inclination. 
	wait 15. 



	set done to 0.
	set inc to ship:orbit:inclination.
	lock throttle to 0.1. 
	until (done = 1) {
		wait 0.1.  
		if  ship:orbit:inclination > inc { 
			break.
		} 
		set normalVec to vcrs(ship:velocity:orbit,-body:position).
		set radialVec to vcrs(ship:velocity:orbit,normalVec).
	}
}

print "landing inclination: " + ship:orbit:inclination.

lock throttle to 0. 


lock steering to radialVec.

if ship:periapsis < talt { 
	lock steering to -radialVec.
}

wait 20. 

print ship:periapsis.

lock throttle to 0.5.  

wait until (ship:periapsis < talt and  ship:periapsis > talt * 0.9).  

lock throttle to 0.

lock throttle to 0.  

print ship:periapsis.

lock steering to retrograde.

wait 15. 

kuniverse:timewarp:warpto(time:seconds + ETA:PERIAPSIS - 180).


gear on. 

wait 10. 

wait until SHIP:ALTITUDE < ship:periapsis + 1000.  

lock throttle to 1.  

wait until SHIP:VELOCITY:surface:mag < 100.  

set t to 0. 

lock steering to SHIP:SRFRETROGRADE. 
wait 2. 

set t to 0.  
lock throttle to t. 

until SHIP:ALTITUDE - SHIP:GEOPOSITION:TERRAINHEIGHT < 500 {   
	print SHIP:VELOCITY:surface:mag. 
	if SHIP:VELOCITY:surface:mag > 80 { 
		set t to min(1,t + 0.01).  
	} else if SHIP:VELOCITY:surface:mag < 50 { 
		set t to max(0,t - 0.1). 
	}
	print t.
}

until SHIP:ALTITUDE - SHIP:GEOPOSITION:TERRAINHEIGHT < 7 {   
	print SHIP:VELOCITY:surface:mag. 
	set d to (SHIP:ALTITUDE - SHIP:GEOPOSITION:TERRAINHEIGHT)  / 100.
	if SHIP:VELOCITY:surface:mag > 4 + d { 
		set t to min(1,t + 0.1).  
	} else if SHIP:VELOCITY:surface:mag < 1 + d { 
		set t to max(0,t - 0.1). 
	}
	print t.
}

lock throttle to 0. 



print "landed!".  

unlock steering. 
wait 30.

run ike_launch.ks.  

