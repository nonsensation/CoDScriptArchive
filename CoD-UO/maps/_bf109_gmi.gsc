#using_animtree ("stuka");


main()
{
	//This file is for the ME109 fighters, right now the spitfires are in here too
//	precachemodel("xmodel/vehicle_plane_stuka_gun");
//	precachemodel("xmodel/vehicle_plane_stuka_d");
//	precachemodel("xmodel/vehicle_plane_stuka_shot");
//	precachevehicle("Stuka");

	precachemodel("xmodel/vehicle_plane_stuka_gun");		//need a new gun? i dunno u never see em


	precachemodel("xmodel/v_ge_air_me-109");
	precachevehicle("bf109");	
	precacheturret("stuka_guns");					//make our own turret here

	//particle effects for exploding me-109
	precachemodel("xmodel/v_ge_air_me-109_fuselage(d)");
	precachemodel("xmodel/v_ge_air_me-109_lwing(d)");
	precachemodel("xmodel/v_ge_air_me-109_rwing(d)");
	precachemodel("xmodel/v_ge_air_me-109_propeller(d)");
	precachemodel("xmodel/v_ge_air_me-109_tail(d)");
	precachemodel("xmodel/v_ge_air_me-109_windshield(d)");

	level._effect["me109_dis"] = loadfx ("fx/explosions/vehicles/me109_complete");
	level._effect["me109_l_wing"] = loadfx ("fx/explosions/vehicles/me109_l_wing");
	level._effect["me109_r_wing"] = loadfx ("fx/explosions/vehicles/me109_r_wing");
	level._effect["me109_tail"] = loadfx ("fx/explosions/vehicles/me109_tail");

	loadfx("fx/explosions/metal_b.efx");
	loadfx("fx/map_bomber/smoke_trail_fighter.efx");
	loadfx("fx/tagged/stukka_boom1.efx");
	loadfx("fx/map_bomber/fire_trail_fighter.efx");

	//particle effects for exploding spitfire
	level._effect["spitfire_dis"] = loadfx ("fx/explosions/vehicles/spitfire_complete");
	level._effect["spitfire_r_wing"] = loadfx ("fx/explosions/vehicles/spitfire_r_wing");
	level._effect["spitfire_tail"] = loadfx ("fx/explosions/vehicles/spitfire_tail");
	level._effect["spitfire_l_wing"] = loadfx ("fx/explosions/vehicles/spitfire_l_wing");

}


init()
{
	life();
	thread dont_ff_me();
	thread kill();
	thread plane_end();
	thread health_check();	//damage levels for fighters
	thread gun_shooting();	//	handle shoot guns
	thread set_speed();
}

set_speed()
{
	self endon ("death");
	while(1)
	{
		self waittill("set_speed",other);
		switch(other)
		{
			case	0:	speed_0();	break;
			case	90:	speed_90();	break;
			case	180:	speed_180();	break;
			case	999:	speed_max();	break;
		}
	}
}

gun_shooting()
{
	self endon ("death");

	while(1)
	{
		self waittill("shoot_guns");
		shoot_guns();
	}
}

life()
{
	//prevents the planes from regenerating if you are supposed to MG them down
	if (!self.noregen)
	{
		self.health = 300;
		thread regen();
	}
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

kill()		//this starts the kill process, called after a plane is destroyed by fire
{
	self.crashfx = loadfx("fx/explosions/metal_b.efx");
	self.smokefx = loadfx("fx/map_bomber/smoke_trail_fighter.efx");
	self.explode1 = loadfx("fx/map_bomber/fire_trail_fighter.efx");
	self.explode2 = loadfx("fx/map_bomber/fire_trail_fighter.efx");

	self waittill( "death", attacker );

	self.mykiller = attacker;

	if( ( self.script_vehiclegroup ) == 9 && ( self.mykiller == level.player ) )
	{
		_debug("PLAYER SHOT DOWN A FRIENDLY PLANE");
		level thread maps\bomber::ff_death();
	}
	else 
	if( ( self.script_vehiclegroup ) == 8 && ( self.mykiller == level.player ) )	
	{
		_debug("PLAYER SHOT DOWN A DOGFIGHT ME-109");
	}
	else
	if( ( self.script_vehiclegroup ) == 7 && ( self.mykiller == level.player ) )
	{
		_debug("PLAYER SHOT DOWN ME-109 THAT KILLS B2");		//Not gonna happen this plane's in god mode
	}

	//self playsound ("fighter_explode");

	//thread turret_kill();

	thread deadexploded();
	
	earthquake(0.25, 3, self.origin, 1050);
	self.enginesmokeleft = spawn("script_origin",(0,0,0));
	self.enginesmokeleft linkto (self,"tag_engine_left",(0,0,0),(0,0,0));

	thread enginesmoke();

	thread kill_planes();
}

kill_planes()			//this blows up the plane with the random particle effect
{
	self.killme = false;

	self thread check_killme();

	playfx (level._effect["firetrail"], self.origin);

	rand1 = ( randomint (50) );

	while ( self.speed > 0 )
	{
		if ( ( rand1 > 0 ) && (self.killme == false) )
		{
			waitframe();
			rand1--;
		}
		else
		{
			break;
		}
	}

	vec1 = self.origin;

	forward = anglestoforward(self.angles);

	vec2 = vec1 + maps\_utility_gmi::vectorScale( forward, 1000 );

	angles = vectorNormalize( vec2 - vec1 );

	rand2 = randomint(4);

	if(self.model == "xmodel/v_ge_air_me-109")
	{
		switch (rand2)
		{
			case 0: playfx(level._effect["me109_dis"], self.origin, angles); break;
			
			case 1: playfx(level._effect["me109_r_wing"], self.origin, angles); break;
	
			case 2: playfx(level._effect["me109_tail"], self.origin, angles); break;
	
			case 3: playfx(level._effect["me109_l_wing"], self.origin, angles); break;
		}
	}
	else 
	if (self.model == "xmodel/v_br_air_spitfire")
	{
		switch (rand2)
		{
			case 0: playfx(level._effect["spitfire_dis"], self.origin, angles); break;
			
			case 1: playfx(level._effect["spitfire_r_wing"], self.origin, angles); break;
	
			case 2: playfx(level._effect["spitfire_tail"], self.origin, angles); break;

			case 3: playfx(level._effect["spitfire_l_wing"], self.origin, angles); break;
		}
	}
	self thread delete_plane();
}

check_killme()		//written to blow up "exploding" planes with additional damage dealt to them twice
{
	self waittill("damage");

	chance = randomint(100) + 1;

	//20% of the planes will not blow up with additional damage, just to make sure the player gets to see *some* crash paths
	if (chance > 20)
	{
		//ok, now wait for 2nd bullet...
		self waittill("damage");

		self.killme = true;
	}
	else
	{
		println("^2Hahaha, you can't kill *me* early!");
	}
}

delete_plane()			//Handle the accounting here
{
	if(isdefined(self.notatarget) && self.notatarget == true)
	{
		//Do nothing
	}
	else
	if ( (isdefined(self.mykiller)) && (self.mykiller == level.player) )
	{
		if( self.script_vehiclegroup != 9 )
		{
			//you get a kill marker if you killed it
			//you get no kills if it's a spitfire
			level.total_num_kills++;
		}

	}
	else
	if ( (isdefined(self.mykiller)) && (self.mykiller != level.player) )
	{
		//Sending out a notify for the "friendly killed a bf"
		if( self.script_vehiclegroup != 9 )
		{
			level notify("bf died");	
		}
	}

	if(isdefined(self.notatarget) && self.notatarget == true)
	{
		//Do nothing
	}
	else
	if	(	( isdefined(self.attack_ev_num) ) && 
			( self.script_vehiclegroup != 9 ) &&
			( self.script_vehiclegroup != 8 ) &&
			( self.script_vehiclegroup != 7 )
		)
	{
		//also, spitfires don't count in the number of planes alive
		//and the fakebf's don't count either
		level.num_planes_ended[self.attack_ev_num]++;
		level.num_planes_alive--;
	}

	self thread turret_kill();

	self delete();
}


get_rid_of_plane()		//No, no accounting is done here...the plane is leaving "naturally"
{
	self thread turret_kill();
	self delete();
}


health_check()
{
	me = self;

	while ( 1 )
	{
		me endon("death");

		me waittill("damage", dmg, who);	

		me.myattacker = who;

		me.max_health = level.bf109_health;

		if (!isdefined(me.health))
		{
			_error("THIS ME HAS NO MAX HEALTH");
			return;
		}

		if (!isdefined(me.health))
		{
			_error("THIS ME HAS NO HEALTH");
			return;
		}
		
		if ( (me.health <=  (me.max_health - ( 0.66 * me.max_health) ) ) && (me.health > 0) )
		{
			if(self.onfire == false)
			{
				self thread smoking_wreck();
			}
		}
	
		waitframe();
	}
}

smoking_wreck()
{
	self endon ("death");
	
	self.onfire = true;

	while(1)
	{
		playfxontag(level._effect["smoketrail"], self, "tag_engine_left");
		waitframe();
	}
}

enginesmoke()
{
	accdist = 0.001;
	fullspeed = 1000.00;


	timer = gettime()+10000;
	while(1)
	{
		oldorg = self.origin;
		waitframe();
		dist = distance(oldorg,self.origin);
		accdist += dist;
		enginedist = 128;
		if(self.speed > 1)
		{
			if(accdist > enginedist)
			{
				speedtimes = self.speed/fullspeed;
				playfx (self.smokefx, self.origin);
	//			playfx (self.smokefx, self.enginesmokeright.origin);
				accdist -= enginedist;
			}
		}
	}
}

deadexploded()
{
	self endon("death");

	thread explodesequence();
	accdist = 0.001;
	fullspeed = 1000.00;

	timer = gettime()+10000;
	while(1)
	{
		oldorg = self.origin;
		waitframe();
		dist = distance(oldorg,self.origin);
		accdist += dist;
		enginedist = 64;
		if(self.speed > 1)
		{
			if(accdist > enginedist)
			{
				speedtimes = self.speed/fullspeed;
				playfx (self.explode2, self.origin);
	//			playfx (self.smokefx, self.enginesmokeright.origin);
				accdist -= enginedist;
			}
		}
	}
}

explodesequence()
{
	playfx (self.explode1, self.origin);
	wait .2;
	playfx (self.explode1, self.origin);
	wait .4;
	playfx (self.explode1, self.origin);
}

crash()
{
	playfx(self.crashfx, self.origin );
	thread playSoundinSpace("Plane_crash",self.origin);
}

playSoundinSpace (alias, origin)
{
	org = spawn ("script_origin",(0,0,1));
	org.origin = origin;
	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}

plane_end()
{
	self endon ("death");
	self waittill ("reached_end_node");

	if( (isdefined(self.loop_num)) && (self.loop_num == -1))
	{
		self thread nonstop_loop();
	}

	if(!isdefined(self.loop_num))
	{
		_error("DELETING PLANE WITH INVALID LOOP NUM");
		println("AD ", self.attackdirection);
		println("RT ", self.rand_target);
		println("PF ", self.p_f);
		println("HL ", self.hi_lo);
		println("AEV/GN/PN: ", self.attack_ev_num, "/", self.group_num, "/", self.plane_num);
		println(level.player_target[self.attackdirection][self.rand_target]);
		_debug(" ");

		self thread delete_plane();
		return;
	}
		
	while( (self.loop_num > 0) )
	{
		if(self.loop_num > 0)
		{
			self.loop_num--;

			if(self.loop_num==0)
			{
				//plane's looped required number of times now

				if( !(isdefined(self.script_noteworthy) && self.script_noteworthy == "noturrets") )
				{
					turret_kill();
				}

				if( isdefined( self.script_vehiclegroup ) && ( self.script_vehiclegroup == 9 ) )
				{
					self notify("spits go home");
					println("^6spit arrived at end node");
				}
				else
				{
					self thread get_rid_of_plane();
				}
				break;
			}
		}

		//otherwise, this plane is still supposed to be looping, restart if on its path
		self attachpath(self.attachedpath);

		self startpath();

		if ( self.script_vehiclegroup != 9 )
		{
			self thread flyby_setup();
		}

		self waittill ( "reached_end_node" );

		waitframe();
	}
}

nonstop_loop()
{
	self endon ("death");
	
	while( 1 )
	{
		self attachpath(self.attachedpath);
	
		self startpath();
	
		if ( self.script_vehiclegroup != 9 )
		{
			self thread flyby_setup();
		}

		self waittill ( "reached_end_node" );
		waitframe();
	}
}

turret_create()
{
	self.leftturret = spawnTurret("misc_turret", (0,0,0), "stuka_guns");
	self.rightturret = spawnTurret("misc_turret", (0,0,0), "stuka_guns");
	self.leftturret setmode("manual");
	self.rightturret setmode("manual");
	self.leftturret setmodel("xmodel/vehicle_plane_stuka_gun");
	self.rightturret setmodel("xmodel/vehicle_plane_stuka_gun");
	self.leftturret.origin = self gettagorigin("tag_gunLeft");
	self.rightturret.origin = self gettagorigin("tag_gunRight");
	self.leftturret.angles = self.angles;
	self.rightturret.angles = self.angles;

	self.leftturret linkto (self,"tag_gunLeft", (0,0,0),(0,0,0));
	self.rightturret linkto (self,"tag_gunRight",(0,0,0),(0,0,0));
}

turret_kill()
{
	if(isdefined(self.leftturret))
	{
		self.leftturret delete();
	}
	if(isdefined(self.rightturret))
	{
		self.rightturret delete();
	}
}

shoot_guns()
{
	
	self notify ("stop mg42s");
	self endon ("stop mg42s");
	self endon ("death");

	gun_ctr = 0;		//for burst control

	fFirerate = 0.15;

	if(!isdefined(self.mytarget))
	{
		self thread maps\bomber::get_fighter_targets();
	}

	turret_create();				// JED ADDED

	if(!isdefined(self.mytarget))
	{
		_error("NO TARGET, DEFAULTING TO PLAYER");
		self.mytarget = level.player;
	}

	while(isdefined(self.mytarget))
	{

		//distanceSquared(vector posA, vector posB);
		dist_to_target = distancesquared( self.origin, self.mytarget.origin );
		if (dist_to_target <= ( 14000 * 14000) )
		{
			for (i = 0;i<(8+randomint(24));i++)
			{
				if 	(	
						isdefined(self.leftturret) && 
						isdefined(self.rightturret) &&
						isdefined(self.mytarget)
					)
				{
					//println("SHOOTING AT ", self.mytarget.targetname);

					self.rightturret settargetentity(self.mytarget);

					self.leftturret settargetentity(self.mytarget);

					self.leftturret shootturret();

					self.rightturret shootturret();

					wait fFirerate;

					if(self.targetname == "bf" || self.targetname == "fakebf" || self.script_vehiclegroup == 8)
					{
						self playsound ("bf109_gun_fire");
					}
					else
					if(self.script_vehiclegroup == 9)
					{
						self playsound ("spit_gun_fire");
					}
					else
					{
						println("^5*******************GUN FIRE SOUND NOT DEFINED!!!*************************");
					}

					gun_ctr++;

					burst_length = (randomint(10) + 5);

					if (gun_ctr > burst_length)
					{
						wait (randomfloat(1));
						gun_ctr = 0;
					}
				}
			}
		}
		waitframe();
	}
	//reset target, and delete turrets after it's fired its whole burst
	self.mytarget = undefined;
	turret_kill();
}

waitframe()
{
	maps\_spawner_gmi::waitframe();
}

dont_ff_me()
{
	self endon ("death");
	while( 1 )
	{
		self waittill ( "damage", amount, who);

		if ( isdefined(who.targetname) && isdefined(who.vehicletype) )
		{
//			if ( ( who.vehicletype == "BF109" ) && ( who.script_vehiclegroup != 9 ) )
//			{
//				self.health += amount;
//				_debug("ME-109 IGNORING FRIENDLY DAMAGE");
//			}
//			else
//			if ( ( who.script_vehiclegroup == 9) && ( who == level.player ) )
			{
				_debug("SPITFIRE DAMAGED BY PLAYER");
				maps\bomber::ff();			
			}
		}
		waitframe();
	}
}

flyby_setup()				//This sets up the flyby noise thread, it's called each time the plane hits startpath()
{					// BUT only for planes attacking the player
//	_debug("flyby setup");
	
	if(!isdefined(self.attackdirection))
	{
		_error("NO ATTACK DIRECTION IS SPECIFIED FOR THIS PLANE, HENCE NO FLYBY NOISE IS TASKED");
		return;
	}

	//translate attackdirection into the appropriate sound played at correct distance
	picker = self.attackdirection;
	
	soundnum = (randomint(4) + 1 ) ;

	switch (soundnum)
	{
		case 1: 	self.soundtype = 1; 
				self.sound_start_dist = ( (level.speed_90 * 17.6) * level.sound_apex["bf109_attack02"] );
				break;			

		case 2: 	self.soundtype = 2; 
				self.sound_start_dist = ( (level.speed_0 * 17.6) * level.sound_apex["bf109_attack01"] );
				break;			

		case 3: 	self.soundtype = 3; 
				self.sound_start_dist = ( (level.speed_90 * 17.6) * level.sound_apex["bf109_attack04"] );
				break;			

		case 4:		self.soundtype = 4; 
				self.sound_start_dist = ( (level.speed_180 * 17.6) * level.sound_apex["bf109_attack03"] );
				break;			
	}

	self thread flyby();
}


flyby()
{
	self endon ("death");

	self.playedsound = false;

	while (!self.playedsound)
	{
		dist_to_target = distance( self.origin, level.player.origin );

		if (dist_to_target < self.sound_start_dist)
		{
			switch ( self.soundtype )
			{
				case 1: self playsound("bf109_attack02"); break;
		
				case 2: self playsound("bf109_attack01"); break;
		
				case 3: self playsound("bf109_attack04"); break;
				
				case 4: self playsound("bf109_attack03"); break;
			}
			self.playedsound = true;
		}
		waitframe();
	}
}



// ***** ***** SPEED CHANGE SECTION ***** ***** called from _vehiclechase_gmi
speed_0()
{
	//setSpeed(<speed>, <accel>);
	self setSpeed(level.speed_0, 200);
//	_debug("speed 0, ", level.speed_0);

	level notify("setspeed", self);
}

speed_90()
{
	//setSpeed(<speed>, <accel>);
	self setSpeed(level.speed_90, 200);
//	_debug("speed 90, ", level.speed_90);

	level notify("setspeed", self);
}

speed_180()
{
	//setSpeed(<speed>, <accel>);
	self setSpeed(level.speed_180, 200);
//	_debug("SPEED 180, ", level.speed_180);

	level notify("setspeed", self);
}

speed_max()	//Handle some accounting here, make sure that the waves end when the planes start to get out of the skybox
{
		//setSpeed(<speed>, <accel>);
	self setSpeed(level.speed_max, 200);

	if( (self.script_vehiclegroup != 8 ) && (self.script_vehiclegroup != 9) )
	{
		level.num_planes_ended[self.attack_ev_num]++;
		level.num_planes_alive--;
	}
//	_debug("speed MAX, ", level.speed_max);

	level notify("setspeed_max", self);
}




//**********************************************************
_debug(arg1, arg2)
{
	if (!isdefined(arg2))
	{
		println("^5*************** ");
		println("^5*************** ", arg1);
		println("^5*************** ");
	}
	else
	{
		println("^5*************** ");
		println("^4*************** ", arg1, " " , arg2);
		println("^5*************** ");
	}
}


debug_value(arg1, arg2)
{
//	loop_wait = 2;
//
//	while ( 1 )
//	{
		if (!isdefined(arg2))
		{
			println("^3********** VALUE CHECK");
			println("^3********** ", arg1);
			println("^3----------");
		}
		else
		{
			println("^3********** VALUE CHECK");
			println("^3********** ",arg2," = ", arg1);
			println("^3----------");
		}
//	wait loop_wait;
//	}
}

_error(arg1,arg2)
{
	if (!isdefined(arg2))
	{
		println("^1*****************");
		println("^1ERROR ERROR ERROR ", arg1);
		println("^1*****************");
	}
	else
	{
		println("^1*****************");
		println("^3ERROR ERROR ERROR ", arg1, " " , arg2);
		println("^1*****************");
	}
}
