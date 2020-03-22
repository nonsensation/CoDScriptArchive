#using_animtree("generic_human");

/*
	CatchOfFire	
			does the setup for staying on fire 
			also here it checks for nearby ai's and
			sets them on fire if they are close enough
			and plays the particle effects
			and causes PAIN !
 */

CatchOnFire()
{
	self endon("death");

	nextpain = gettime() + randomint(500);
	//	we are going to pick a random tag from this list to spawn a particle from

	self notify ("never look at anything again");

	//	sit and look for nearby chumps 
	//	and set them on fire if we are in range

	// MikeD: Added check to see if the AI's health is lower than 1000 as well, cause we don't want them to play the
	// pain anim over and over, also prevents guys in god mode from catching on fire.
	while(self.health>0 && self.health < 1000)
	{
		//	find the closest ai apart from myself 


		// 	NOTE ALL THIS WAS REMOVED FOR SANITY , we can put it back in if we wish 
/*
		excluders[0] = self;
		catcher = maps\_utility_gmi::getClosestAI(self.origin,undefined,excluders);
		//	did we find one . 
		if (isdefined(catcher))
		{
			//	if we have never been near this fire then
			//	we need to define the variable

			if (!isdefined(catcher.onfire))
				catcher.onfire = 0;

			//	now we see if we are already on fire 
			//	don't want to do this multiple times

			if (catcher.onfire == 0)
			{
				//	see if we are in range
				cdistance = distance(catcher.origin,self.origin);
				if (cdistance<level.flame_radius)
				{
					//	yup , 
					//	set me on fire . kerosene
		
					catcher thread CatchOnFire();
					catcher.onfire = 1;
				}
			}
		}
*/
		//	cause me some pain 
		if (gettime() > nextpain)
		{
			self doDamage ( randomint(15), (0,0,0));
			nextpain = gettime() + 500 + randomint(500);
		}
		wait(0.05);
	}
}



do_flame_checks()
{	
	if (!isdefined(level.flame_particle))
		level.flame_particle = loadfx("fx/fire/fire_trail_25");

	if (!isdefined(level.flame_radius))
		level.flame_radius = 64;

	while(1)
	{
		ai = getaiarray ();

		for (i=0;i<ai.size;i++)
		{
			if (isdefined(ai[i].magic_bullet_shield))
			{
				if (ai[i].magic_bullet_shield==true)
				{
					continue;					
				}
			}

			// note this is only supposed to be FLAME damage anyway 

			if (ai[i].damagetype == 26)
			{
				if (!isdefined(ai[i].onfire))
					ai[i].onfire = 0;
				if (ai[i].onfire == 0)
				{
					ai[i] thread CatchOnFire();
					ai[i].onfire = 1;
				}
			}
		}
		wait(0.05);
	}
}
/*
	just sits in the level , checking for flame damage 
	and sets those guys on fire 
 */

main()
{
// RF, removed this since it is not used anymore
//	thread do_flame_checks();
}

