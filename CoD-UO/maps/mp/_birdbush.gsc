main()
{
	birdbush = getentarray("birdbush","targetname");
	if(isdefined(birdbush))
	{
		for(i=0;i<birdbush.size;i++)
		{
			birdbush[i] thread birdbush();
		}
	}

	bird = getentarray("bird","targetname");
	if(isdefined(bird))
	{
		for(i=0;i<bird.size;i++)
		{
			bird[i].dest = bird[i].origin;
			bird[i].active = false;
			bird[i] hide();
		}
	}

}

birdbush()
{
	bird = getentarray("bird","targetname");
	self.trigger_time = 0;
	if (!isdefined(self.script_noteworthy))
		self.script_noteworthy = 5000;
	while(true)
	{
		self waittill("trigger");
		if (self.trigger_time < (int) gettime())
			self.trigger_time = (int) gettime() + (int) self.script_noteworthy;
		else
			continue;
	
//		if (isdefined(bird)) // for test only
		rand = randomint(100);
		if (rand < 15 && isdefined(bird))
		{
			start = self.origin;
			a = 0;
			for(i=0;i<bird.size;i++)
			{
				if (!bird[i].active && randomint(3) > 0)
				{
					bird[i].origin = start;
					bird[i] thread flyaway();
					a++;
				}
			}
		}
	}
}

flyaway()
{
	self.active = true;
	self show();
	wait randomfloat(0.5)+0.01;
	self playsound ("ra_bird_flight_single");
	start = self.origin;
	dest = start;
	a = randomint(3)+1;
	for (i = 0;i<a;i++)
	{
		if (i == 0)
		{
			speed = 0.5;
			x = rndneg(randomint(50)+75);
			y = rndneg(randomint(50)+75);
			z = randomint(25)+50;
			dest = dest+(x,y,z);
			self moveto(dest, speed, 0, 0.4);
			wait speed-0.2;
		}
		else
		{
			speed = randomint(1)+0.5;
			x = rndneg(randomint(50)+50);
			y = rndneg(randomint(50)+50);
			z = randomint(50)+25;
			dest = dest+(x,y,z);
			self moveto(dest, speed, 0, 0);
			wait speed-0.05;
		}
	}

	movetime = (1.0/300.0)*(float)(distance(self.origin,self.dest)); //move at 300 units per second
	if (movetime < 0)
		movetime = 0.1;
	self moveto(self.dest, movetime, 0, 0);
	wait movetime;
	self hide();
	self.active = false;
}

rndneg(value)
{
	if (randomint(2) == 0)
		return (value * -1);
	else
		return value;
}