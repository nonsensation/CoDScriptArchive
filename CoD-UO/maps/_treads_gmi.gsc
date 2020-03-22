main()
{
	if(!isdefined(self.treaddist))
		self.treaddist = 92;
	if(!isdefined(self.fullspeed))
		self.fullspeed = 1000.00;

	trightorg = self gettagorigin("tag_wheel_back_right");
	trightang = self.angles;

	tleftorg = self gettagorigin("tag_wheel_back_left");
	tleftang = self.angles;

	right = spawn ("script_origin", (1,1,1));
	left = spawn ("script_origin", (1,1,1));

	angoffset = (32,0,0);
	right.origin = trightorg;
	right.angles = trightang + angoffset;
	left.origin = tleftorg;
	left.angles = tleftang + angoffset;

	right linkto (self);
	left linkto (self);
	self thread tread(left,"back_left");
	self thread tread(right,"back_right");

}

tread(tread,side)
{
	tread endon ("death");
	self endon ("death");
	accdist = 0.001;
	self.watersplashing = 0;

	if ( getcvar("scr_gmi_fast") != "0" )
		return;
		
	if (!isdefined (level._effect) || !isdefined (level._effect["treads_grass"]))
		maps\_utility_gmi::error ("Tread effects are undefined. Add _treadfx::main(); to this level");
	treadfx = treadget(side);
	while (isdefined (tread))
	{
		oldorg = tread.origin;
 		// MIkeD Modified, to give more a random to the spawning of treadfx (old: wait .11;)
		wait randomfloat(0.2);
		dist = distance(oldorg,tread.origin);
		accdist += dist;
		if(self.speed > 1 && distance(level.player.origin,self.origin) < 6000)
		{
			if(accdist > self.treaddist)
			{
				vectang = anglestoforward(tread.angles);
				speedtimes = self.speed/self.fullspeed;
				vectang = maps\_utility_gmi::vectorMultiply(vectang,speedtimes);
				// MikeD, so we can control the "kickup" of the dust.
				if(isdefined(self.tread_muliplier))
				{
					vectang = maps\_utility_gmi::vectorMultiply(vectang,self.tread_muliplier);
				}
				lastfx = treadfx;
				treadfx = treadget(side);
				if(treadfx != lastfx)
					self notify ("treadtypechanged");
				if(treadfx != "nofx")
					playfx (treadfx, tread.origin,(0,0,0)-vectang);
				accdist -= self.treaddist;
			}
		}

	}
}


treadget(side)
{
	surface = self getwheelsurface(side);  // might need to make different effects for different vehicles someday.
	if(surface == "grass")
		treadfx = level._effect["treads_grass"];
	else if(surface == "sand")
		treadfx = level._effect["treads_sand"];
	else if(surface == "dirt")
		treadfx = level._effect["treads_dirt"];
	else if(surface == "rock")
		treadfx = level._effect["treads_rock"];
	else if(surface == "snow")
		treadfx = level._effect["treads_snow"];
	else if(surface == "ice")
	{
		self notify ("iminwater");
		treadfx = "nofx";
	}
	else
		treadfx = "nofx";

	if(!isdefined(treadfx))
		treadfx = "nofx"; //ghetto defensive scripting.. for some reason "rock" is commented out in _treadfx.gsc and I'm too lazy to find out why
	return treadfx;

}

waitframe()
{
	maps\_spawner_gmi::waitframe();
}