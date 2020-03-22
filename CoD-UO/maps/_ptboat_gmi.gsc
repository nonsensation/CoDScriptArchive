main()
{
	precachevehicle("boat");
	precacheturret("ptboat_turret");
	precachemodel("xmodel/v_ge_sea_pt-boat_turret");
	precachemodel("xmodel/v_ge_sea_pt-boat_d");
//	precachemodel("xmodel/b17_dorsal_ai");
//	maps\_willyjeep_gmi::main();  //test
	loadfx("fx/explosions/vehicles/ptboat_complete.efx");
	loadfx("fx/explosions/vehicles/ptboat_sink.efx");
	loadfx("fx/weapon/muzzleflash/mf_50cal");
	loadfx("fx/weapon/tracer/tracer_50cal");
	level.ptboatsprayfx = loadfx("fx/vehicle/watersprayboat_spraymain.efx");
	level.ptboatwakefx= loadfx("fx/vehicle/wakeboat_pt.efx");
	level.ptboatdeathfx = loadfx("fx/vehicle/wakeboat_pt.efx");
	
	character\german_tropical::precache();
	level.attacktargetcount = 0;  //hack so that first two boats can do something different than the rest.  I deem this entire script special case =)
}

init()
{
	self.fxturretshoot = loadfx("fx/weapon/muzzleflash/mf_50cal");
	self.tracer = 	loadfx("fx/weapon/tracer/tracer_50cal");

	life();
	thread kill();
	thread tread();
//	thread drawtags();
}

life()
{
	self.health = 11000;
	thread boatsparks();
	thread turretinit();
	thread nodeevents();
}

kill()
{
	explode = loadfx("fx/explosions/vehicles/ptboat_complete.efx");
	sink 	= loadfx("fx/explosions/vehicles/ptboat_sink.efx");
	self.deathmodel = "xmodel/v_ge_sea_pt-boat_d"; 
	self waittill( "death", attacker );
	self.turretdummy delete();
	self setspeed (0,50);
//	self setmodel (self.deathmodel);
	self hide();
	level thread deathfx(self,sink);
	playfx (explode , self.origin);
	playfxontag (sink, self, "tag_wake");
	self playsound ("Explo_boat");
	earthquake(0.25, 3, self.origin, 1050);
	self.turret delete();

	wait .2;
	self delete();

}


playSoundinSpace (alias, origin)
{
	org = spawn ("script_origin",(0,0,1));
	org.origin = origin;
	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}


turretinit()
{
	self endon("death");
	self.turret = spawnTurret("misc_turret", ( 0, 0, 0), "ptboat_turret");
	self.turret linkto(self, "tag_turret", (0, 0, 0), (0, 0, 0));
	self.turret maketurretunusable();	
	self.turret setmode("auto_nonai");
	self.turret setmodel("xmodel/v_ge_sea_pt-boat_turret");

	self.turret.script_delay_min = .5;	//	tweak here
	self.turret.script_delay_max = 1;	//	and here
	self.turret.script_burst_min = 3.5;	//	and here
	self.turret.script_burst_max = 4.2;	//	and here
	self.turret setturretaccuracy ( 0.2 );	//	and here

	thread turretdummy();
	target = spawn("script_origin",(0,0,0));
	self waittill ("refreshenemy");
	self.turret thread burst_fire_unmanned();
	while(1)
	{
//		if (isdefined(self.target))
//		{
//			iprintlnbold("target - ",self.target);
//		}
		self thread attacktarget(self.turret,target);
//		self.turret settargetentity(level.player);	//	if you really want to shoot something else change this  // I need it to attack the target that moves around (makes cool splashes in the water before the bullets start magicly hitting and killing);
		wait(0.05);
		self waittill ("refreshenemy");

	}
}
burst_fire_unmanned()
{
	if (isdefined (self.script_delay_min))
		mg42_delay = self.script_delay_min;
	else
		mg42_delay = maps\_mg42_gmi::burst_fire_settings ("delay");

	if (isdefined (self.script_delay_max)) 
		mg42_delay_range = self.script_delay_max - mg42_delay;
	else
		mg42_delay_range = maps\_mg42_gmi::burst_fire_settings ("delay_range");

	if (isdefined (self.script_burst_min))
		mg42_burst = self.script_burst_min;
	else
		mg42_burst = maps\_mg42_gmi::burst_fire_settings ("burst");

	if (isdefined (self.script_burst_max)) 
		mg42_burst_range = self.script_burst_max - mg42_burst;
	else
		mg42_burst_range = maps\_mg42_gmi::burst_fire_settings ("burst_range");

	pauseUntilTime = gettime();
	turretState = "start";

	for (;;)
	{
		duration = (pauseUntilTime - gettime()) * 0.001;
		if (self isFiringTurret() && (duration <= 0))
		{
			if (turretState != "fire")
			{
				turretState = "fire";

//				self setAnimKnobRestart(%standMG42gun_fire_foward);

				thread DoShoot();
			}

			duration = mg42_burst + randomfloat(mg42_burst_range);

			//println("fire duration: ", duration);
			thread maps\_mg42_gmi::TurretTimer (duration);

			self waittill("turretstatechange"); // code or script

			duration = mg42_delay + randomfloat(mg42_delay_range);
			//println("stop fire duration: ", duration);

			pauseUntilTime = gettime() + (int) (duration * 1000);
		}
		else
		{
			if (turretState != "aim")
			{
				turretState = "aim";

//				self setAnimKnobRestart(%standMG42gun_aim_foward);
			}
			
			//println("aim duration: ", duration);
			thread maps\_mg42_gmi::TurretTimer (duration);

			self waittill("turretstatechange"); // code or script
		}
	}
}

DoShoot()
{
	self endon("turretstatechange"); // code or script

	for (;;)
	{
		self ShootTurret();
		level notify ("boatshoot"); // tells magic sparks to happen on boats in sicily2..

	
		wait 0.5;
	}
}

attacktarget(mgturret,target)  //moves origin.. that is all..
{
	self endon ("death");
	self endon("refreshenemy");
	level.attacktargetcount++;
	if(level.attacktargetcount < 3)
	{
		time_max = 6000;
		maxoffset = -32;
		offset = -32;
		
	}
	else
	{
		time_max = 10000;
		maxoffset = -32;
		offset = -32;
	}
	timer = gettime()+time_max;
	offset *= (float)(time_max/(timer-gettime()));
	mgturret settargetentity(target);
	while(1)
	{
		if(gettime()<timer)
		{
			target linkto (self.turret_target,"tag_origin",(0,0,offset),(0,0,0)); // aim down below the thing so to cause lots of splashes!
			offset *= (float)(time_max/(timer-gettime()));
		}
		else
		{
			target linkto (self.turret_target,"tag_origin",(0,0,0),(0,0,0)); // aim down below the thing so to cause lots of splashes!
			mgturret setturretaccuracy (.76);
		}
		wait .2;		
	}
}

/*

attacktarget(target)
{
	level.escapeboat endon ("death"); //er oh the ugliness.. make it stop
	self endon ("death");
	self endon("refreshenemy");
	time_max = 10000;
	maxoffset = -32;
	offset = -32;
	timer = gettime()+time_max;
	offset *= (float)(time_max/(timer-gettime()));
	while(1)
	{
		myburstcount = ( randomint ( 15 ) + 5);	
		if(gettime()<timer)
		{
			target linkto (self.turret_target,"tag_origin",(0,0,offset),(0,0,0)); // aim down below the thing so to cause lots of splashes!
			offset *= (float)(time_max/(timer-gettime()));
		}
		else
		{
			target linkto (self.turret_target,"tag_origin",(0,0,0),(0,0,0)); // aim down below the thing so to cause lots of splashes!
		}
		self setTurretTargetEnt(target,(0,0,0));
		for (n=0; n< myburstcount; n++)			
		{
			wait .2;
			self fireTurret();
			level notify ("boatshoot"); // tells magic sparks to happen on boats in sicily2..
			playfxOnTag ( self.fxturretshoot, self, "tag_flash" );
			playfxontag(self.tracer, self, "tag_flash");
	
		}
		wait randomfloat(.3)+.4;		
	}

	
}
*/
#using_animtree ("ptboat");

nodeevents()
{
	self.boataniming = 0;
	self.animdirection = "none"; 
	if(self.model == "xmodel/v_ge_sea_view_ptboat")
	{
		self.animfast = %v_ge_sea_view_ptboat_fast;		
		self.animslow = %v_ge_sea_view_ptboat_slow;
		self.animslowing_down = %v_ge_sea_view_ptboat_slowing_down;
		self.animidle = %v_ge_sea_view_ptboat_idle;
		self.animleft = %v_ge_sea_view_ptboat_left;
		self.animright = %v_ge_sea_view_ptboat_right;
		self.animbeginning = %v_ge_sea_view_ptboat_beginning;	
		self.animright2fast = %v_ge_sea_ptboat_right2fast;	
		self.animleft2fast = %v_ge_sea_ptboat_left2fast;	
		self.animleftstart = %v_ge_sea_ptboat_fast2left;	
		self.animrightstart = %v_ge_sea_ptboat_fast2right;	
	
	}
	else
	{
		self.animfast = %v_ge_sea_ptboat_fast;
		self.animslow = %v_ge_sea_ptboat_slow;
		self.animslowing_down = %v_ge_sea_ptboat_slowing_down;
		self.animidle = %v_ge_sea_ptboat_idle;
		self.animleft = %v_ge_sea_ptboat_left;
		self.animright = %v_ge_sea_ptboat_right;
	}
	rand = randomint(3);
	if(rand == 0)
		self.animsinking = %v_ge_sea_ptboat_death_a;
	else if (rand == 1)
		self.animsinking = %v_ge_sea_ptboat_death_b;		
	else if (rand == 2)
		self.animsinking = %v_ge_sea_ptboat_death_c;
	else
		iprintlnbold("screwy logic here in nodeevents");		
		
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
		else if(other == "animbeginning")
			thread animbeginning();
		else if(other == "animsinking")
		{
			thread animsinking();	
			return; // boat has been notified death but not deleted in such a way that this thread would go away. 
		}	
	}
}



animslow()
{
	self endon ("death");
	self endon ("groupedanimevent");
	if(self.boataniming)
		self waittillmatch ("boatanim","end"); //let the current animation get finished to avoid jerking
	while(1)
		boatanim(self.animslow);
}

animfast()
{
	self endon ("death");
	self endon ("groupedanimevent");
	if(self.boataniming)
		self waittillmatch ("boatanim","end"); //let the current animation get finished to avoid jerking
	if(self.model == "xmodel/v_ge_sea_view_ptboat")
	{
		if(self.animdirection == "right")
		{
			boatanim(self.animright2fast);
		}
		else if(self.animdirection == "left")
		{
			boatanim(self.animleft2fast);
		}
		self.animdirection = "fast";
	}
	while(1)
		boatanim(self.animfast);	
}

animidle()
{
	self endon ("death");
	self endon ("groupedanimevent");
	if(self.boataniming)
		self waittillmatch ("boatanim","end"); //let the current animation get finished to avoid jerking
	while(1)
		boatanim(self.animidle);	

}

animleft()
{
	self endon ("death");
	self endon ("groupedanimevent");
	if(self.boataniming)
		self waittillmatch ("boatanim","end"); //let the current animation get finished to avoid jerking
	if(self.model == "xmodel/v_ge_sea_view_ptboat")
	{
		boatanim(self.animleftstart);
		self.animdirection = "left";
	}
	while(1)
		boatanim(self.animleft);	
}
animbeginning()
{
	self endon ("death");
	self endon ("groupedanimevent");
	if(self.boataniming)
		self waittillmatch ("boatanim","end"); //let the current animation get finished to avoid jerking
	while(1)
		boatanim(self.animbeginning);	
}

animright()
{
	self endon ("death");
	self endon ("groupedanimevent");
	if(self.boataniming)
	{
		self waittillmatch ("boatanim","end"); //let the current animation get finished to avoid jerking
	}
	if(self.model == "xmodel/v_ge_sea_view_ptboat")
	{
		boatanim(self.animrightstart);
		self.animdirection = "right";
	}	
	while(1)
		boatanim(self.animright);	
}

animslowing_down()
{
	thread animfast();
	return; // nobody slows down!
	self endon ("death");
	self endon ("groupedanimevent");
	if(self.boataniming)
		self waittillmatch ("boatanim","end"); //let the current animation get finished to avoid jerking
	boatanim(self.animslowing_down);
	animslow();	
}

animsinking()
{
	self notify ("boatanim","end"); // tell the boatanimthread to end
	self.turret delete();
	boatanim(self.animsinking);
	self delete();
	
}

boatanim(animation)
{
	self.boataniming = 1;
	self useanimtree (#animtree);
	self setflaggedanimknobrestart("boatanim",animation);  	
	self waittillmatch ("boatanim","end");
}

tread()
{

	self endon ("death");
	fullwakespeed = 200.00;  // speed at which the spray effect will be played at 1
	fullsprayspeed = 930.00;  // speed at which the spray effect will be played at 1
	accspraydist = 0.001;  // define accumulated spray distance
	accwakedist = 0.001;  // define accumulated wake distance	
	wakedist = 24; // every wakedist units spit out an a wake effect
	spraydist = 12; // every spraydist units spit out an a spray effect
	
	wakedummy = spawn("script_model", self.origin);
	wakedummy setmodel("xmodel/v_ge_sea_pt-boat_turret");
	wakedummy linkto (self,"tag_wake",(0,0,0),(0,90,90));
	wakedummy hide();
//	wakedummy thread drawthing("tag_origin");
	while(1)
	{
		
		oldorg = self.origin;
		//waitframe();
		wait .15;
		dist = distance(oldorg,self.origin);
		accspraydist += dist;
		accwakedist += dist;
		vectang = (0,0,0);
		if(self.speed > 1)
		{
			
			speedtimes = self.speed/fullsprayspeed;

			if(accspraydist > spraydist)
			{
//	tags[tags.size] = "tag_wake";
//	tags[tags.size] = "tag_spray_fl";
//	tags[tags.size] = "tag_spray_fr";
//	tags[tags.size] = "tag_backspray";
//	tags[tags.size] = "tag_wake";
				vectang = anglestoforward(self gettagangles ("tag_spray_fl"));
				vectang = maps\_utility_gmi::vectorMultiply(vectang,speedtimes);
				playfx (level.ptboatsprayfx, self gettagorigin ("tag_spray_fl"),vectang);
				vectang = anglestoforward(self gettagangles ("tag_spray_fr"));
				vectang = maps\_utility_gmi::vectorMultiply(vectang,speedtimes);
				playfx (level.ptboatsprayfx, self gettagorigin ("tag_spray_fr"),vectang);
				vectang = anglestoforward(self gettagangles ("tag_backspray"));
				vectang = maps\_utility_gmi::vectorMultiply(vectang,speedtimes);
				playfx (level.ptboatsprayfx, self gettagorigin ("tag_backspray"),vectang);
				//playfxontag (level.ptboatsprayfx, self, "tag_wake");
				accspraydist -= spraydist;  //reset accumulated distance and start over
			}
			if(accwakedist > wakedist)
			{
				vectang = anglestoforward(self.angles);
				speedtimes = self.speed/fullwakespeed;
				vectang = maps\_utility_gmi::vectorMultiply(vectang,speedtimes);
//				thread newline(self.origin, self.origin-(maps\_utility_gmi::vectorMultiply(vectang,100)));
//				playfx (level.ptboatwakefx, self.origin,(0,0,0)-vectang);				//playfxontag (level.ptboatwakefx, self, "tag_origin");
				//playfxontag (level.ptboatwakefx, self, "tag_wake");
				playfxontag (level.ptboatwakefx, wakedummy, "tag_origin");
				accwakedist -= wakedist;  //reset accumulated distance and start over
			}
			
			
			
		}

	}

}

newline(par1,par2)
{
	level notify ("newline");
	level endon ("newline");
	while(1)
	{
		print3d(par1,"0");
		line(par1, par2);
		wait .05;
	}
}

drawtags()
{
	tags = [];
	tags[tags.size] = "tag_turret";
	tags[tags.size] = "tag_boat";
	
//	tags[tags.size] = "tag_flash";
//	tags[tags.size] = "tag_wake";
//	tags[tags.size] = "tag_spray_fl";
//	tags[tags.size] = "tag_spray_fr";
//	tags[tags.size] = "tag_backspray";
	//tags[tags.size] = "tag_wake";
	
	while(1)
	{
		for(i=0;i<tags.size;i++)
		{
			tagorg = self gettagorigin(tags[i]); 
			tagang = self gettagangles(tags[i]);
			print3d(tagorg, tags[i], (1,1,1),1);
			vectanga = anglestoforward(tagang);
			vectanga = maps\_utility_gmi::vectorMultiply(vectanga,20);
			vectangb = anglestoup(tagang);
			vectangb = maps\_utility_gmi::vectorMultiply(vectangb,20);
			vectangc = anglestoright(tagang);
			vectangc = maps\_utility_gmi::vectorMultiply(vectangc,20);
			line(tagorg,tagorg+vectanga,(1,1,0));
			line(tagorg,tagorg+vectangb,(0,1,0));
			line(tagorg,tagorg+vectangc,(0,0,1));
			
		}
		wait .05;
	}
}


drawthing(tag)
{
	while(1)
	{
			tagorg = self gettagorigin(tag); 
			tagang = self gettagangles(tag);
			print3d(tagorg, tag, (1,1,1),1);
			vectanga = anglestoforward(tagang);
			vectanga = maps\_utility_gmi::vectorMultiply(vectanga,20);
			vectangb = anglestoup(tagang);
			vectangb = maps\_utility_gmi::vectorMultiply(vectangb,20);
			vectangc = anglestoright(tagang);
			vectangc = maps\_utility_gmi::vectorMultiply(vectangc,20);
			line(tagorg,tagorg+vectanga,(1,0,0));
			line(tagorg,tagorg+vectangb,(0,1,0));
			line(tagorg,tagorg+vectangc,(0,0,1));
			wait .05;
		
	}
}

boatsparks()
{
	maxhealth = self.health;
	healthbuffer = 2000;
	self.health+=healthbuffer;
	smoking = false;
	while(self.health > healthbuffer)
	{
		self waittill("damage",dmg,who,dir,point,mod);
		if(who.classname == "worldspawn")
		{
			self.health += dmg;  // give back health taken from friendly fire they enemy turrets damage returns worldspawn as the classname.. 
		}
		else
			playfx(level._effect["enemyboatspark"],point,anglestoforward(dir));  // effect defined in sicily2_fx.gsc
		if(!(smoking) && (((float)self.health-(float)healthbuffer)/(float)maxhealth < .5))
		{
			smoking = true;
			self thread turretsmoking();
		} 
		
	}
	self notify ("death");
}

turretsmoking()
{
	playfxontag(level._effect["boatdamage"],self,"tag_origin");
	while(1)
	{
		playfxontag(level._effect["boatsmoke"],self,"tag_turret");
		wait .1;
	}	
}

deathfx(boat,sink)
{
	deathmodel = spawn ("script_model",boat.origin);
	deathmodel.angles = boat.angles;
	deathmodel setmodel (boat.deathmodel);
	deathmodel useanimtree (#animtree);
	rand = randomint(3);
	if(rand == 0)
		animsinking = %v_ge_sea_ptboat_death_a;
	else if (rand == 1)
		animsinking = %v_ge_sea_ptboat_death_b;		
	else if (rand == 2)
		animsinking = %v_ge_sea_ptboat_death_c;
	else
		iprintlnbold("screwy logic here in deathfx");	
	playfxontag (sink, deathmodel, "tag_wake");
	deathmodel boatanim(animsinking);
	deathmodel hide(); // still playing the sink fx maybe?
	wait 5;
	stopattachedfx(deathmodel);
	wait 1;
	deathmodel delete();
}

#using_animtree ("sicily2_dummies");

turretdummy()
{
	self endon ("death");
	ent_turret = self.turret;
	str_tag = "tag_barrel";
	ent_dummy = spawn("script_model",(0,0,0));
	ent_dummy setmodel ("xmodel/c_ge_bod_tropical");
	ent_dummy character\german_tropical::main();
	ent_dummy linkto(ent_turret,str_tag,(0,0,0),(0,0,0));
	self.turretdummy = ent_dummy; //handle to delete guy on death..
	ent_dummy useanimtree (#animtree);
	animation = %c_ge_sicily2_gunner_idle;
	while(1)
	{
		org = ent_turret gettagOrigin (str_tag);
		angles = ent_turret gettagAngles (str_tag);
		ent_dummy animscripted("animontagdone", org, angles, animation);
		ent_dummy waittillmatch ("animontagdone","end");
	}
}