
print "pointing up". 

lock steering to north.  
wait 15. 


set kuniverse:timewarp:warp to 7.
wait until ship:orbit:body:name = "Sun".  
set kuniverse:timewarp:warp to 0.

until kuniverse:timewarp:issettled {
//    print "rate = " + round(kuniverse:timewarp:rate,1).
    wait 0.1.
}

print "Out of Kerbin.".  

lock steering to north.  
wait 15. 

print ETA:APOAPSIS.

set kuniverse:timewarp:warp to 7.
wait until ETA:APOAPSIS < 10000.  
set kuniverse:timewarp:warp to 0.


Print "circularizing".  

until kuniverse:timewarp:issettled {
 //   print "rate = " + round(kuniverse:timewarp:rate,1).
    wait 0.1.
}

lock steering to prograde.  
wait 20. 

lock throttle to 1. 

wait until SHIP:PERIAPSIS > 0.95 * SHIP:APOAPSIS.  

lock throttle to 0. 

print "Circularized, pointing north and then looking for intersect.".

lock steering to north.  
wait 5. 

run intersect.ks. 

run fix_duna.ks.

print "Warping to Duna.". 
set kuniverse:timewarp:warp to 7.
wait until ship:orbit:body:name = "Duna".
set kuniverse:timewarp:warp to 0.


run duna_land.ks.

wait 30.

run duna_launch.ks. 

run inclination.ks.

run ike.ks.


print "Warping to Duna.". 
set kuniverse:timewarp:warp to 7.
wait until ship:orbit:body:name = "Ike".
set kuniverse:timewarp:warp to 0.


run ike_land.ks. 