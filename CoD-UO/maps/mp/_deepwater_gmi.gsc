deepwater()
{
	deepwaters = getentarray("deepwater", "targetname");
	if (deepwaters.size > 0)
	{
		level._effect["deepwater_player"] = loadfx ("fx/water/impact_playerjump_water.efx");
	}
	
	for(i = 0; i < deepwaters.size; i++)
	{
		deepwaters[i] thread deepwater_think();
	}	
}

deepwater_think()
{
	while (1)
	{
		self waittill ("trigger",other);
		
		if ( isPlayer(other))
		{
			other thread deepwater_kill(self);
		}
		else if (isDefined(other.classname) && other.classname == "script_vehicle" )
		{
			other thread deepwater_kill_vehicle(self);
		}
	}
}

deepwater_kill_vehicle(trigger)
{
	if(isDefined(self.deepwater))
		return;
		
	self.deepwater = true;
//	self playsound ("land_water");

	wait(.5);
	wait(randomFloat(.5));

	if(self istouching(trigger))
	{
//		trace = bulletTrace(self.origin +(0, 0, 200),self.origin +(0, 0, -200), true, undefined);
//			
//		if(trace["fraction"] != 1)
//		{
//			playfx ( level._effect["deepwater_player"], trace["position"]);
//		}

		self dodamagemod (10000,(self.origin[0],self.origin[1],self.origin[2] - 20), "MOD_WATER");

		self waittill("allow_explode");
	}
	self.deepwater = undefined;
}

deepwater_kill(trigger)
{
	if(isDefined(self.deepwater) || !isAlive(self) )
	{
		return;
	}
		
	self.deepwater = true;
	self playsound ("land_water");

	if(self istouching(trigger))
	{
		trace = bulletTrace(self.origin +(0, 0, 200),self.origin +(0, 0, -200), false, undefined);
			
		if(trace["fraction"] != 1)
		{
			playfx ( level._effect["deepwater_player"], trace["position"]);
		}
		
		self dodamagemod (self.health+100,(self.origin[0],self.origin[1],self.origin[2] - 20), "MOD_WATER");
	}
	self.deepwater = undefined;
}

playSoundinSpace (alias, origin)
{
	org = spawn ("script_model",origin);
	wait 0.05;
	org playsound (alias);
	wait 6;
	org delete();
}