/*
	noprone script by Roger Abrahamsson

	Make trigger multiple and give it targetname noprone
	Make another trigger multiple and place it 32 units above the highest bottom part of the noprone area
	Give in a unique targetname and set this as a target in the first trigger.
*/


main()
{
	areas = getentarray("noprone","targetname");
	if(isdefined(areas))
	{
		for(i=0;i<areas.size;i++)
		{
			areas[i] thread NoProneArea();
		}
	}
}

NoProneArea()
{
	
	if(isdefined(self.target) )
	{
		ceilingname = self.target;
		ceiling = getent(ceilingname,"targetname");
		while(true)
		{
			self waittill("trigger",user);
			if (!user istouching(ceiling))
			{
				user setClientCvar("cl_stance", 1);
			}
			wait 0.5;
		}
	}
}