main()
{
	precachevehicle("boat");
	loadfx("fx/explosions/vehicles/boat_generic.efx");
}

init()
{

	life();
	thread kill();
}

life()
{
	self.health = 300;
	thread regen();
	thread nodeevents();
}

kill()
{
	explode = loadfx("fx/explosions/vehicles/boat_generic.efx");
	self.deathmodel = self.model; //   no deathmodel yet.("xmodel/vehicle_plane_stuka_shot");
	self waittill( "death", attacker );
	self notify ("groupedanimevent","animsinking");
	self setspeed (0,25);
	playfx (explode , self.origin);
	self playsound ("explo_metal_rand");
	earthquake(0.25, 3, self.origin, 1050);
}

playSoundinSpace (alias, origin)
{
	org = spawn ("script_origin",(0,0,1));
	org.origin = origin;
	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}

regen()
{
	self endon ("death");
	healthbuffer = 1000;
	self.health+=healthbuffer;
	while(1)
	{
		self waittill ("damage",amount);
		if(amount<300)
			self.health += amount;
		else
		{
			break;
		}
	}
	radiusDamage ( self.origin, 2, 10000, 9000);
}



#using_animtree ("ptboat");

nodeevents()
{
	self.animfast = %v_ge_sea_ptboat_fast;
	self.animslow = %v_ge_sea_ptboat_slow;
	self.animslowing_down = %v_ge_sea_ptboat_slowing_down;
	self.animidle = %v_ge_sea_ptboat_idle;
	self.animleft = %v_ge_sea_ptboat_left;
	self.animright = %v_ge_sea_ptboat_right;
	self.animsinking = %v_ge_sea_ptboat_sinking;
	while (1)
	{
		self waittill ("groupedanimevent",other);
		if(other == "animfast")
			thread animfast();
		else if(other == "animslow")
			thread animslow();
		else if(other == "animslowing_down")
			thread animslowing_down();
		else if(other == "animidle")
			thread animidle(animidle);
		else if(other == "animleft")
			thread animleft();
		else if(other == "animright")
			thread animright();
		else if(other == "animsinking")
			thread animsinking();		
	}
}



animslow()
{
	self endon ("groupedanimevent");
	while(1)
		boatanim(self.animslow);
}

animfast()
{
	self endon ("groupedanimevent");
	while(1)
		boatanim(self.animfast);	
}

animidle()
{
	self endon ("groupedanimevent");
	while(1)
		boatanim(self.animidle);	
}

animleft()
{
	self endon ("groupedanimevent");
	while(1)
		boatanim(self.animleft);	
}

animright()
{
	self endon ("groupedanimevent");
	while(1)
		boatanim(self.animright);	
}

animslowing_down()
{
	self endon ("groupedanimevent");
	boatanim(self.animslowing_down);
	animslow();	
}

animsinking()
{

	self endon ("groupedanimevent");
	boatanim(self.animsinking);
	self setanim(self.animsinking, 191, .4);

	wait 8;
	self delete();
}





boatanim(animation)
{
	self useanimtree (#animtree);
	self setflaggedanimknobrestart("boatanim",animation);	
	self waittillmatch ("boatanim","end");
}