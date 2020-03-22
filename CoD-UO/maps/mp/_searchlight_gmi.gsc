main()
{
    	level._effect["searchlight"]			= loadfx ("fx/atmosphere/v_light_searchlight.efx");
    	
    	// delay so we dont get lost in the initial level load confusion
    	wait(2);
    	
    	level thread searchlight();
}

searchlight()
{
	searchlights = getentarray("searchlight","targetname");
	
	// start the effect on the model
	for ( i = 0; i < searchlights.size; i++ )
	{
		playfxontag( level._effect["searchlight"], searchlights[i], "tag_light" );
		searchlights[i] thread searchlight_move();
		
		// delay them a bit so they are not all synced up
		wait(0.2);
	}
	
}

searchlight_move()
{
	// have them move around
	pitch = 0;
	while(1)
	{
//		println("angles: " + self.angles[2] );
		rotate_pitch = 30 + randomint( 30 );
		
		if ( (self.angles[2] + rotate_pitch) > 50 )
		{
			rotate_pitch = 50 - self.angles[2];
		}
		rotate_time = 10 + randomint(5);
		
		self rotateroll(rotate_pitch,rotate_time,2 + randomint(4) ,2 + randomint(4));
		wait (rotate_time);	
		wait(randomfloat(1.0));

//		println("angles: " + self.angles[2] );
		rotate_pitch = -1 * (30 + randomint( 30 ));

		if ( (self.angles[2] + rotate_pitch) < -50 )
		{
			rotate_pitch = -50 - self.angles[2];
		}
		rotate_time = 10 + randomint(5);

		self rotateroll(rotate_pitch,rotate_time,2 + randomint(4) ,2 + randomint(4));
		wait (rotate_time);	
		wait(randomfloat(1.0));
	}
	
}