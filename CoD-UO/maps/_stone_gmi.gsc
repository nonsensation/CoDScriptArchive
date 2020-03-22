main()
{
	maps\_utility_gmi::precache ("xmodel/gib_stone1");
	maps\_utility_gmi::precache ("xmodel/gib_brick");
	maps\_utility_gmi::precache ("xmodel/m_gib_concrete_a");
	maps\_utility_gmi::precache ("xmodel/m_gib_concrete_b");
	
	precacheFX();
	
	
	stone = getentarray ("stone_splinter","targetname");
	maps\_utility_gmi::array_thread(stone, ::stone_think);
}
precacheFX()
{
	level._effect["_stone_gmi_impact"]	= loadfx ("fx/weapon/impacts/impact_lmg_concrete.efx");
}

stone_think()
{
	if (!isdefined (self.target))
	{
		println ("stone at ", self getorigin(), " has no target");
		self delete();
		return;
	}
	
	mainpiece = getentarray (self.target, "targetname");
	self waittill ("trigger", other);		
	org = other.origin;
	
	for (i=0;i<mainpiece.size;i++)
	{
		if (!isdefined (mainpiece[i]))
			continue;
		if(randomint(100) > 25)
			mainpiece[i] playsound ("bullet_large_brick");
		else 
			mainpiece[i] playsound ("bullet_large_concrete");
		if ( (isdefined (self.script_noteworthy)) && (self.script_noteworthy == "light"))
			mainpiece[i].light = true;
		playfx(level._effect["_stone_gmi_impact"], mainpiece[i] getorigin());
		mainpiece[i] thread splinter(org);
	}
	self delete();
	
}

splinter(org)
{
	splinter = [];
	count = randomint(1) + 1;
	for(i = 0; i < count; i++)
	{
		splinter[splinter.size] = spawn ("script_model", (0, 0, 0));
		if ( (isdefined (self.light)) && (self.light == true) )
			splinter[i] setmodel ("xmodel/gib_stone1");
		else
		{
			if (randomint(100) > 50)
				splinter[i] setmodel ("xmodel/gib_brick");
			else
				splinter[i] setmodel ("xmodel/gib_stone1");
		}
		
		splinter[i].origin = self getorigin();
		splinter[i].origin = ((splinter[i].origin[0] + randomfloat(1) - .5), (splinter[i].origin[1] + randomfloat(1) - .5), (splinter[i].origin[2] + randomfloat(1) - .5));
		splinter[i] thread go(org);
		
		thread small_gibs(splinter[i].origin, org);
		thread small_gibs(splinter[i].origin, org);
	}
	self delete();
}
go(org)
{
	temp_vec = vectornormalize (self.origin - org);
	temp_vec = maps\_utility_gmi::vectorScale (temp_vec, 150 + randomint (200));
//	println ("start ", self.origin , " end ", org, " vector ", temp_vec, " player origin ", level.player getorigin());
//	x = -80 - (randomint(40));

	x = temp_vec[0];
	y = temp_vec[1];
	z = 200 + randomint (200);
	if (x > 0)
		self rotateroll((1500 + randomfloat (2500)) * -1, 5,0,0);
	else
		self rotateroll(1500 + randomfloat (2500), 5,0,0);
	
	self moveGravity ((x, y, z), 12);
	wait (6);
	self delete();
}
small_gibs(org, startorg)
{
	for (i=0;i<randomint(3) + 1;i++)
	{
		splinter[i] = spawn ("script_model", org );

		splinter[i].origin += (randomfloat(10) - 5, 0, randomfloat(30) - 15);
		
		if (randomint(100) > 50)
			splinter[i] setmodel ("xmodel/m_gib_concrete_a");
		else
			splinter[i] setmodel ("xmodel/m_gib_concrete_b");

		startorg += (50 - randomint (100),50 - randomint (100),0);
		temp_vec = vectornormalize (org - startorg);
		temp_vec = maps\_utility_gmi::vectorScale (temp_vec, 300 + randomint (150));
			
		x = temp_vec[0];
		y = temp_vec[1];
		z = 120 + randomint (200);
		splinter[i] moveGravity ((x, y, z), 12);
//		splinter[i] rotateroll(1500 + randomfloat (2500), 5,0,0);
		
		if (x > 0)
			splinter[i] rotateroll((1500 + randomfloat (2500)) * -1, 5,0,0);
		else
			splinter[i] rotateroll(1500 + randomfloat (2500), 5,0,0);	
	}
	
	wait (6);
	for (i=0;i<splinter.size;i++)
		splinter[i] delete();
}