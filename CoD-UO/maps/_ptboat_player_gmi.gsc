main()
{
	precachevehicle("ptboat_player");
	precachemodel("xmodel/v_ge_sea_pt-boat_turret");
	precachemodel("xmodel/v_us_lnd_willysjeep");
	
	
	loadfx("fx/smoke/smoke_trail_15.efx");
	loadfx("fx/explosions/vehicles/ptboat_complete.efx");
	loadfx("fx/explosions/vehicles/ptboat_sink.efx");
	loadfx("fx/weapon/muzzleflash/mf_50cal");
	loadfx("fx/weapon/tracer/tracer_50cal");
	
	level.ptboatplayersprayfx = loadfx("fx/vehicle/watersprayboat_spraymain.efx");
	level.ptboatplayerwakefx= loadfx("fx/vehicle/wakeboat_pt.efx");
}

init()
{
	self.fxturretshoot = loadfx("fx/weapon/muzzleflash/mf_50cal");
	self.tracer = 	loadfx("fx/weapon/tracer/tracer_50cal");

	life();
	thread kill();
	thread maps\_ptboat_gmi::tread();
}

life()
{
	self.health = 6000;
	thread regen();
	thread maps\_ptboat_gmi::nodeevents();
	thread player_shoot();
//	thread drawtags();
}

kill()
{
	explode = loadfx("fx/explosions/vehicles/ptboat_complete.efx");
	sink 	= loadfx("fx/explosions/vehicles/ptboat_sink.efx");
	self.deathmodel = self.model; //   no deathmodel yet.("xmodel/vehicle_plane_stuka_shot");
	self waittill( "death", attacker );
	self notify ("groupedanimevent","animsinking");
	self setspeed (0,25);
	playfx (explode , self.origin);
	playfxontag (sink, self, "tag_wake");
	self playsound ("Explo_boat");
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
	healthbuffer = 300;
	self.health+=healthbuffer;
	while(self.health > healthbuffer)
	{
		self waittill ("damage",amount);
//		iprintlnbold("damage amount: ",amount);
		if(isdefined(level.boatride) && level.boatride)
			continue;
		if(amount<300)
			self.health += amount;
	}
	radiusDamage ( self.origin, 2, 10000, 9000);
}

player_shoot()
{
//	coolscale = 40;
//	thread gunburnout(coolscale);
//	thread gunoverheat();
	while(self.health > 0)
	{
		self waittill( "turret_fire" );
//		self.turretcool+= -3;
		self fire();
//		quakemodifier = (1.03-(float)self.turretcool/(float)coolscale);
//		quakemodifierramped = quakemodifier*(quakemodifier/.3);
//		earthquake(.2*quakemodifierramped, .15, self.origin, 2250);
		earthquake(.15, .15, self.origin, 2250);
//		if(self.turretcool < 2)
//		{
//			self notify ("gun overheat");
//			self waittill ("turret cool");
//			maps\sicily2::playSoundonobject("ingram_gun",level.escapeboat);
//			
//		}
		
	}
}

gunoverheat()
{
	gunfx = loadfx("fx/smoke/smoke_trail_15.efx");
	while(1)
	{
		self waittill ("gun overheat");
		iprintlnbold(&"GMI_SICILY2_GUN_OVERHEATED");
		thread dothesmoke(gunfx); // Danny was here
		
	}
}

dothesmoke(gunfx)
{
	timer = gettime()+4000;
	while(gettime()<timer)
	{
		playfxontag (gunfx, self, "tag_flash");
		wait .05;	
	}
}
gunburnout(coolscale)
{
	self.turretcool = coolscale;
	while(1)
	{
//		iprintln ("turret cool is " + self.turretcool + "out of " + coolscale);
		wait .15;
		if(!(self.turretcool >= coolscale))
		{
			if(self.turretcool < coolscale/2)
				self.turretcool +=2.3;
			else
				self.turretcool +=2;         //ghetto math
		}
		if(self.turretcool > coolscale)
			self.turretcool = coolscale; // cap it at coolscale..
		if(self.turretcool > coolscale-5)
			self notify ("turret cool");
	}
}


fire()
{
	if(self.health <= 0)
		return;

	// fire the turret
	self FireTurret();

	// play the fire animation
//	self setAnimKnobRestart( %PanzerIV_fire );
}
#using_animtree ("ptboat");


drawtags()
{
	tags = [];
	tags[tags.size] = "tag_turret";
	tags[tags.size] = "tag_flash";
	tags[tags.size] = "tag_wake";
//	tags[tags.size] = "tag_spray_lf";
//	tags[tags.size] = "tag_backspray";
//	tags[tags.size] = "tag_wake";
	
	while(1)
	{
		for(i=0;i<tags.size;i++)
		{
			tagorg = self gettagorigin(tags[i]); 
			tagang = self gettagangles(tags[i]);
			print3d(tagorg, tags[i], (1,1,1),1);
			vectang = anglestoforward(tagang);
			vectang = maps\_utility_gmi::vectorMultiply(vectang,20);
			line(tagorg,tagorg+vectang);
			
		}
		wait .05;
	}
}