

print "checking inclination " + ship:orbit:inclination.  
lock steering to SHIP:UP  + R(0,90,0). 

set normalVec to vcrs(ship:velocity:orbit,-body:position).
set radialVec to vcrs(ship:velocity:orbit,normalVec).
lock steering to normalVec.

if 	abs(ship:orbit:inclination) > 0.3 {
	print "pointing up.". 
	wait 30. 
}

set talt to (ship:apoapsis + ship:periapsis) / 2.  

until abs(ship:orbit:inclination) < 0.3 { 
	lock steering to normalVec.
	print "fixing inclination " + ship:orbit:inclination.  
	wait 2. 
	set kuniverse:timewarp:warp to 3.
	wait until  (ship:orbit:body:geopositionof(ship:position):lat > ship:orbit:inclination / 2). 
	print "waiting for low lat". 
	wait until  (ship:orbit:body:geopositionof(ship:position):lat < ship:orbit:inclination / 20 + 0.1). 
	set kuniverse:timewarp:warp to 0.
	print ship:orbit:body:geopositionof(ship:position):lat. 
	lock throttle to ship:orbit:inclination/5 + 0.01. 
	wait until (ship:orbit:body:geopositionof(ship:position):lat < -0.1 or ship:orbit:inclination < 0.2).  
	lock throttle to 0. 
	if (ship:periapsis < talt *0.9) { 
		print "fixing peri".  
		lock steering to prograde. 
		wait 6. 
		lock throttle to 1.
		wait until (ship:periapsis > talt *0.91).
		lock throttle to 0. 
		lock steering to normalVec.
		wait 6. 
	}
	
}
