
wait 2. 
"Determine location".  

cd("1:/"). 
if ship:orbit:body:name = "Kerbin" {

	if ship:orbit:transition = "FINAL" {
		
		if ship:velocity:surface:mag < 1 { 
			print "On the ground on Kerbin".  
			copypath("0:/kerbin_launch.ks","1:/").  
			run kerbin_launch.  
			deletepath("1:/kerbin_launch.ks").
		}
		
		if ship:velocity:surface:mag > 2000 and  ship:periapsis > 70000 { 
			print "In orbit in Kerbin".  
			copypath("0:/sun.ks","1:/").  
			run sun. 
		}
	} else {
		print "unhandled Kerbin orbit type" + ship:orbit:transition.  
		wait 2. 
		reboot. 
	}

	
}
		