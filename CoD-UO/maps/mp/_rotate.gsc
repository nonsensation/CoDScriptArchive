/*
	rotate object script by Roger Abrahamsson

	Make object into a script_brushmodel and give it targetname rotate

	Key speed sets seconds per revolution.
	Key script_noteworthy takes y, x or z and rotates around that axis.

*/


main()
{
	rotate_obj = getentarray("rotate","targetname");
	if(isdefined(rotate_obj))
	{
		for(i=0;i<rotate_obj.size;i++)
		{
			rotate_obj[i] thread ra_rotate();
		}
	}
}

ra_rotate()
{
	if (!isdefined(self.speed) || self.speed == 0)
		self.speed = 5;
	if (!isdefined(self.script_noteworthy))
		self.script_noteworthy = "y";

	while(true)
	{
		// rotateYaw(float rot, float time, <float acceleration_time>, <float deceleration_time>);
		if (self.script_noteworthy == "y")
			self rotateYaw(360,self.speed);
		else if (self.script_noteworthy == "x")
			self rotateRoll(360,self.speed);
		else if (self.script_noteworthy == "z")
			self rotatePitch(360,self.speed);
		wait ((self.speed)-0.1); // removes the slight hesitation that waittill("rotatedone"); gives.
	}
}
