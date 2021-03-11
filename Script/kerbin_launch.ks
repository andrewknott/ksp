
wait 2. 

rcs on.  
sas off.  

lock extra_fuel to ship:partsdubbed("fuelTank")[0]:resources[0]:amount.

cd("0:/"). 
//run transfer.ks. 


when SHIP:PARTSDUBBED("Rockomax64.BW")[0]:resources[0]:amount = 0 then { 

	print "Orange tank: " + SHIP:PARTSDUBBED("Rockomax64.BW")[0]:resources.
	stage. 
	rcs on.
}


when SHIP:PARTSDUBBED("SolidBooster1-1")[0]:resources[0]:amount = 0 then {
	print "SRB cut off: "  + time:seconds.
}

when SHIP:PARTSDUBBED("punt1")[0]:resources[0]:amount = 0 then { 

	print "Punt1: " + SHIP:PARTSDUBBED("punt1")[0]:resources.
	stage. 
}



print SHIP:PARTSDUBBED("SolidBooster1-1")[0]:resources[0]:amount. 


LOCK THROTTLE TO 1.0.

LOCK STEERING TO UP + + R(0,0,180).

UNTIL SHIP:MAXTHRUST > 0 {
    WAIT 0.5. // pause half a second between stage attempts.
    PRINT "Stage activated.".
    STAGE. // same as hitting the spacebar.
}

wait 1.
rcs off.

WAIT UNTIL SHIP:ALTITUDE > 1200.

print "turning on nuclear engines.".  
STAGE.

WAIT UNTIL SHIP:VERTICALSPEED > 280.

AG1 ON. 
rcs on. 
 
print "turning off main engine.".  

//critical timing to match fuel and srb.  
wait 11.3. 	

print "Last fuel then staging".  
AG1 OFF.  
rcs off. 

wait 1. 
print "First turn.".  

set x to 0. 
until  x < -1 { 
	lock steering to UP + R(0,x,180).
//	print ETA:APOAPSIS.
//	print SHIP:MAXTHRUST. 
	wait 0.1.
	set x to x - 0.1.  
}


LOCK THROTTLE TO 1.0.

print "Gravity Turn".  

set done to 0. 
set x to round(x). 
until x < -47 { 
	lock steering to UP + R(0,x,180).
//	print extra_fuel.
	set x to x - 1.
	wait 0.6.
	if (done = 0) {
		if (extra_fuel < 1) { 
			print "Staging".  
			wait 0.5. 
			Print time:seconds.
			print ship:partsdubbed("fuelTank")[0]:resources[0]. 
			print "SRB: " + SHIP:PARTSDUBBED("SolidBooster1-1")[0]:resources[0]. 
			STAGE.
			unlock extra_fuel. 
			set extra_fuel to -1.
			set done to 1.  
		}
	}
}

print "waiting for apo > 50000".  

until SHIP:APOAPSIS > 50000 { 
//	print SHIP:APOAPSIS. 
	wait 0.1.  
}

AG1 ON.  
rcs on.  

lock steering to prograde.  
  

print "turned off main engine, waiting until 50000 alt.".  

until SHIP:ALTITUDE >  50000  {
	wait 0.1. 
}

AG1 OFF.  


print "main engine on, waiting for apo > 70900".  

until SHIP:APOAPSIS > 70900 { 
//	print SHIP:APOAPSIS. 
	wait 0.1.  
}





set test2 to NODE(TIME:SECONDS + ETA:APOAPSIS - 2.5, 0, 0, 2280 - SHIP:VELOCITY:orbit:mag). 

add test2.

rcs on.
lock steering to prograde.

lock throttle to 0. 


run  execute_node.ks.

remove test2. 



//AG1 ON.
//rcs on. 

//print "turned off main engine, waiting until apo 9 seconds away.".  

//print SHIP:MAXTHRUST.

//wait until (ETA:APOAPSIS < 9). 
//AG1 OFF.  
//wait until (SHIP:VELOCITY:orbit:mag > 2100 or SHIP:MAXTHRUST < 200). 
//print "running transfer.".  
//RUNPATH("transfer"). 



//wait until SHIP:PERIAPSIS > 30000. 
//lock throttle to 0. 

//print "running transfer.".  


print "final adjustment.".  

lock steering to prograde. 
wait 1. 
kuniverse:timewarp:warpto(time:seconds + ETA:APOAPSIS - 20).

wait ETA:APOAPSIS - 5. 

lock throttle to 1. 

wait until SHIP:PERIAPSIS > 70500.  

lock throttle to 0. 

//run sun.ks. 
//run duna.ks. 

