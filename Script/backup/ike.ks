//ike.

set peri to 99999999.
set t to 60.  
until t > 100000 { 
	set test2 to NODE( TIME:SECONDS + t, 0, 0, 280).  
	add test2.  
	wait 0.1.
	if encounter <> "None" {
//		print z + " has peri " + encounter:periapsis.  
		if (encounter <> "None" and encounter:periapsis < peri ) { 
			set test to NODE(TIME:SECONDS + t, 0, 0, 280).  
			set peri to encounter:periapsis. 
			print t  + " New Peri " + peri. 
			break. 
		}
	}
	set t to t + 100.  
	remove test2.  
}

//add test.  


run execute_node. 

remove test.
