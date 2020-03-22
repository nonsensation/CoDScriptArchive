windmill_spin()
{
	original_angles = self.angles;
	original_origin = self.origin;
	
	base_time = 6;  // fastest this will ever go
	max_time = 20;
	time_range = max_time - base_time;
	max_step = 1;
	
	// this is the starting speed
	time = base_time + randomint( time_range );
	
	while(1)
	{
		// this will give us a random add or subtract bit
		plus_minus = randomint(3) - 1;
//		println("plus_minus " + plus_minus );
		
		step = randomint(max_step) + 1;
		
		// we can either speed up, slow down, or say the same
		if ( plus_minus > 0 )
		{
			time += step;
		}
		else if ( plus_minus < 0 )
		{
			time -= step;
		}
			
		// validate the time
		if ( time < base_time )
			time = base_time;
		else if ( time > max_time )
			time = max_time;		
	
//		println("windmill time " + time );
		
		// rotate the windmill
		self rotatepitch(-360,time,0,0);

		// do a timed wait so we can start the next rotate pitch before the current is done
		// that way we never have the rotation stop for one frame
		wait(time - 0.5);
//		self waittill("rotatedone");
	}
}