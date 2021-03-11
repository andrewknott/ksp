
//land on duna.  

print "Landing.".  


set talt to 19300.
sas off.

lock steering to SHIP:UP  + R(0,90,0). 

set normalVec to vcrs(ship:velocity:orbit,-body:position).
set radialVec to vcrs(ship:velocity:orbit,normalVec).

print "inclination: " + ship:orbit:inclination.

if 	abs(ship:orbit:inclination) > 2 {
	lock steering to normalVec.
	print "pointing up.". 
	wait 15. 

	set done to 0.
	set inc to ship:orbit:inclination.
	lock throttle to 0.1 + min(0.5,ship:orbit:inclination / 100). 
	until (done = 1) {
		wait 0.1.  
		if  ship:orbit:inclination > inc { 
			break.
		} 
		set normalVec to vcrs(ship:velocity:orbit,-body:position).
		set radialVec to vcrs(ship:velocity:orbit,normalVec).
		set inc to ship:orbit:inclination. 
		print ship:orbit:inclination.  
	
	}

}


lock throttle to 0. 

if 	abs(ship:orbit:inclination) > 2 {
	lock steering to -normalVec.
	print "pointing down.". 
	wait 15. 

	set done to 0.
	set inc to ship:orbit:inclination.
	lock throttle to 0.1 + min(0.5,ship:orbit:inclination / 100). 
	until (done = 1) {
		wait 0.1.  
		if  ship:orbit:inclination > inc { 
			break.
		} 		
		set inc to ship:orbit:inclination. 
		set normalVec to vcrs(ship:velocity:orbit,-body:position).
		set radialVec to vcrs(ship:velocity:orbit,normalVec).
//		print ship:orbit:inclination.  

	}
}


lock throttle to 0. 

print "new inclination: " + ship:orbit:inclination.

lock steering to radialVec.
if ship:periapsis < talt { 
	lock steering to -radialVec.
}

wait 20. 

print ship:periapsis.

lock throttle to 0.02 + abs(ship:periapsis / (talt * 500)).  

wait until ship:periapsis < talt and  ship:periapsis > talt * 0.8.  

lock throttle to 0.  


runpath("transfer","MK1Fuselage","punt2").  


print ship:periapsis.

lock steering to retrograde.

wait 5. 

kuniverse:timewarp:warpto(time:seconds + ETA:PERIAPSIS - 120).

print "Waiting for target altitude." + talt.  

wait until SHIP:ALTITUDE < talt. 

print "Waiting " + ETA:PERIAPSIS + 10. 

wait ETA:PERIAPSIS + 10. 

print "Burning if we need to stay in Duna orbit.".

until ship:orbit:transition <> "Escape" {
//	print "Burning to stay in Duna.".
	lock throttle to 1. 
} 

wait 1. 
lock throttle to 0. 


print "Waiting for 52500 altitude.".  

set landing to 0.
until SHIP:ALTITUDE > 52500 { 

	wait 1.  
	if SHIP:APOAPSIS < 60000 {
		print "landing - apo is: " + SHIP:APOAPSIS.  
		set landing to 1. 
		break. 
	} 

}

//xfer("MK1Fuselage","punt2").  

if landing = 0 { 
	print "warping to apo.". 

	kuniverse:timewarp:warpto(time:seconds + ETA:APOAPSIS - 60).
	lock steering to prograde.  
	wait until ETA:APOAPSIS < 60.  
	print "increase Peri in 20 sec.".  
	wait 20. 
	lock throttle to 0.05. 

	wait until ship:periapsis > talt.
	lock throttle to 0.
	lock steering to retrograde.
	kuniverse:timewarp:warpto(time:seconds + ETA:PERIAPSIS - 200).
}



print "Waiting for target altitude " + talt.  

wait until SHIP:ALTITUDE < talt. 	

lock steering to SHIP:SRFRETROGRADE. 

print "waiting for 6k alt.".  

wait until SHIP:ALTITUDE - MAX(0,SHIP:GEOPOSITION:TERRAINHEIGHT) < 6000.  

print "staging.".  
stage.  
gear on. 

print "waiting for 3.5k alt.".  

wait until SHIP:ALTITUDE - MAX(0,SHIP:GEOPOSITION:TERRAINHEIGHT) < 3500.  

wait until SHIP:VELOCITY:surface:mag < 100.  

set t to 1. 
lock throttle to t. 


until SHIP:ALTITUDE - SHIP:GEOPOSITION:TERRAINHEIGHT < 300 {   
//	print SHIP:VELOCITY:surface:mag. 
	if SHIP:VELOCITY:surface:mag > 50 { 
		set t to min(1,t + 0.01).  
	} else if SHIP:VELOCITY:surface:mag < 30 { 
		set t to max(0,t - 0.1). 
	}
//	print t.
}



until SHIP:ALTITUDE - SHIP:GEOPOSITION:TERRAINHEIGHT < 7 {   
//	print SHIP:VELOCITY:surface:mag. 
	if SHIP:VELOCITY:surface:mag > 7 { 
		set t to min(1,t + 0.1).  
	} else if SHIP:VELOCITY:surface:mag < 3 { 
		set t to max(0,t - 0.1). 
	}
//	print t.
}

lock throttle to 0. 

print "Landed!".  

unlock steering.
