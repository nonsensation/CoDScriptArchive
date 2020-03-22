#using_animtree("pak43");
main()
{
	precachemodel("xmodel/v_ge_art_pak43");
	
	script_models = getentarray ("script_model","classname");
	script_vehicles = getentarray ("script_vehicle","classname");

	for(i=0;i<script_vehicles.size;i++)
	{
		script_models = maps\_utility_gmi::add_to_array ( script_models , script_vehicles[i]);
	}

	for (i=0;i<script_models.size;i++)
	{
		if ((script_models[i].model == "xmodel/v_ge_art_pak43") || (script_models[i].model == "xmodel/v_ge_art_pak43"))
		{
			precachemodel("xmodel/v_ge_art_pak43(d)");
			loadfx("fx/explosions/vehicles/tiger_complete.efx");
		}
	}

	turret_fx = loadfx("fx/vehicle/muzzleflash_pak43.efx");

	if(getcvar("debug_pak43") == "")
	{
		setcvar("debug_pak43", "0");
	}
}

init(guys)
{
	self useAnimTree( #animtree );
	self health();

	thread death_setup();


	if(isdefined(guys) && guys)
	{
		self.ready_to_fire = false;
		self thread init_guys();
	}
	else
	{
		self.ready_to_fire = true;
	}

	self.disabled = false;

//	//MikeD: Orientate the turret so it's aligned with animations
//	forward_angles = anglestoforward(self.angles + (10, 0, 0));
//	tag_origin = self gettagorigin("tag_turret");
//	vec = tag_origin + maps\_utility_gmi::vectorScale(forward_angles,2000);
//
//	self.fake_target = vec;
//
//	self setTurretTargetVec(self.fake_target,(0,0,0));
//	self waittill("turret_on_target");
//	self clearTurretTarget();

}

health()
{
	if(isdefined(self.health) && self.health <= 50)
	{
		self.health  = (randomint(1000)+500);
	}
}

shoot()
{
	// Currently does not support firing without guys on.
	while(!self.ready_to_fire)
	{
//		println("^3Waiting to fire. Pak43 at (" + self.origin + ")");
		wait 0.1;
	}

	if(self.health < 0)
	{
		return;
	}

	self fireturret();
	self notify("turret_fired");
	   //setanimrestart(Anim anim, float goalWeight = 1, float goalTime = 0.2, float rate = 1);
	self setanimknobrestart(%v_ge_art_pak43_fire);
}

death_setup()
{
	self UseAnimTree(#animtree);
	if(self.model == "xmodel/v_ge_art_pak43")
	{
		self.deathmodel = "xmodel/v_ge_art_pak43(d)";
		self.deathfx = loadfx("fx/explosions/vehicles/tiger_complete.efx");
		self.deathsound = "explo_metal_rand";
	}


	self thread death_think();
}

kill_gunners() {
	
	// blast the crew	
	thread maps\kursk_infantry::do_explosion_deaths (self.crew, self.origin);	
}

death_think()
{
	self waittill("death", attacker);
	self notify("stop_everything");

	if(self.disabled == false)
	{
		level notify("pak destroyed");
		self.disabled = true;
	}

	self playsound(self.deathsound);

	// play a gib effect
	playfx( level._effect["paknet"], self.origin );

	// take out the guys manning the pak
	self thread kill_gunners();

	// handle any exploders
	if(isdefined(self.script_exploder))
	{
		thread maps\_utility_gmi::exploder(self.script_exploder);
	}

	// If we want a certain animation to play, insert here!

	self clearTurretTarget();
	playfxonTag ( self.deathfx, self, "tag_body" );
	lingerfx = loadfx("fx/smoke/oneshotblacksmokelinger.efx");
	earthquake( 0.25, 3, self.origin, 1050 );

	self setmodel( self.deathmodel );
	self freevehicle();
	self.dead = true;

}

pak43_random_fire(min_delay, max_delay, targetname, targetarray, max_shots)
{
	self endon("death");
	self endon("stop_random_fire");
	self endon("stop_everything");

	shot_count = 0;

//	println("^5(pak43_random_fire): Target list = ",targetname);
	while(1)
	{
		if(isdefined(targetname))
		{	
			targets = getentarray(targetname,"targetname");
			randomnum = randomint(targets.size);

//			println("^5(pak43_random_fire): Target = ",targets[randomnum].targetname);
//			println("^5(pak43_random_fire): Target coords = ",targets[randomnum].origin);

			self setTurretTargetVec(targets[randomnum].origin);
			self waittill("turret_on_target");
		}
		else if(isdefined(targetarray))
		{	
			randomnum = randomint(targetarray.size);

			if(isdefined(targetarray[randomnum]) && isalive(targetarray[randomnum]))
			{
//			println("^5(pak43_random_fire): Target = ",targetarray[randomnum].targetname);
//			println("^5(pak43_random_fire): Target coords = ",targetarray[randomnum].origin);

				if (targetarray[randomnum] == level.playertank)
				{
					self setTurretTargetEnt(targetarray[randomnum],(0,0,-16));
				}
				else
				{
					self setTurretTargetEnt(targetarray[randomnum],(0,0,48));
				}
			}

			self waittill("turret_on_target");
		}
		
		self shoot();
		shot_count++;

		if(isdefined(max_shots))
		{
			if(shot_count >= max_shots)
			{
				self notify("random fire done");
				break;
			}
		}

		if(isdefined(min_delay) && isdefined(max_delay))
		{
			range = max_delay - min_delay;
			delay = (min_delay + randomfloat(range));
		}
		else
		{
			delay = (5 + randomfloat(5));
		}

//		println("^3Pak43 at (" + self.origin + ") is waiting for: ", delay ," ^3seconds before firing.");
		wait delay;
	}
}

// Spawns in the guys to start playing animations.
#using_animtree("generic_human");
init_guys()
{
	// Get the spawners.
	spawnpoints = getentarray(self.target,"targetname");

	// If 2 spawpoints are not found, return.
	if(spawnpoints.size < 2)
	{
//		println("^1(Init_Guys): Not enough Spawners to fill Pak43 Crew at (" + self.origin + ")");
		return;
	}

	// Spawn in the crew.
	for(i=0;i<spawnpoints.size;i++)
	{
//		spawned = spawnpoints[i] dospawn();
		// no, seriously, SPAWN THEM
		spawned = spawnpoints[i] stalingradspawn();

		if(i > 1)
		{
			continue;
		}
			
		if(isdefined(spawned))
		{
			if(i==0)
			{
				self.crew[0] = spawned;
				spawned.pak43_title = "loader";

				spawned thread pak43_loader(self);
			}
			else
			{
				self.crew[1] = spawned;
				spawned.pak43_title = "passer";
				
				spawned thread pak43_passer(self);
			}
		}
		else
		{
//			println("^1(Init_Guys): Unable to Spawn Pak43 Crew at (" + self.origin + ")");
			if(i > 0)
			{
				if(isdefined(self.pak43_loader))
				{
					self.pak43_loader delete();
				}
			}

			return;
		}
	}
	
	self.ready_to_fire = true;
	self thread pak43_anim();
}

pak43_loader(pak43)
{
	wait 0.1;
	self animscripts\shared::putGunInHand ("none");
	self.pak43_anim["fire"] = (%c_gr_pak43_charger_fire);
	self.pak43_anim["idle"] = (%c_gr_pak43_charger_idle);

	self.pak43_spot = pak43 gettagorigin("tag_guy1");
	self.pak43_spot_angles = pak43 gettagangles("tag_guy1");

	self teleport(self.pak43_spot);

	self thread pak43_crew_anim(pak43);
	self thread pak43_crew_death_tracker(pak43); // if one of the guys is killed, count it as having destroyed the pak
	self thread pak43_crew_hop_off(pak43);
}

pak43_passer(pak43)
{
	wait 0.1;
	self animscripts\shared::putGunInHand ("none");
	self.pak43_anim["fire"] = (%c_gr_pak43_passer_fire);
	self.pak43_anim["idle"] = (%c_gr_pak43_passer_idle);

	self.pak43_spot = pak43 gettagorigin("tag_guy2");
	self.pak43_spot_angles = pak43 gettagangles("tag_guy2");

	self teleport(self.pak43_spot);

	self thread pak43_crew_anim(pak43);
	self thread pak43_crew_death_tracker(pak43); // if one of the guys is killed, count it as having destroyed the pak
	self thread pak43_crew_hop_off(pak43);
}

// Controlls the animations for the crew.
pak43_anim()
{
	self endon("death");
	self endon("stop_everything");

	while(1)
	{
		self waittill("turret_fired");
		// Wait for the code to notify a "turret_fire"
		self.ready_to_fire = false;
	
		num = 2;
		while(num > 0)
		{
			self waittill("crew_fire_anim_done");
			num--;
		}
	
		self notify("crew_start_anim");
		
		num = 2;
		while(num > 0)
		{
			self waittill("crew_anim_done");
			num--;
		}

		self.ready_to_fire = true;	
	}
}

// Plays the crew members animations.
pak43_crew_anim(pak43)
{
	self endon("death");
	pak43 endon("stop_everything");

	self thread pak43_crew_idle(pak43);
	self thread print_3d();
	self.allowDeath = 1;
	while(1)
	{
		pak43 waittill("turret_fired");
		
		self.text = "Fire";

		self.currentanim = "fire";
		self animscripted("scriptedanimdone", self.pak43_spot, self.pak43_spot_angles, self.pak43_anim["fire"]);
		self waittill("scriptedanimdone");

		self.text = "Fire Done";
		pak43 notify("crew_fire_anim_done");


		pak43 waittill("crew_start_anim");

		self.text = "Idle";

		self.currentanim = "idle";
		self animscripted("scriptedanimdone", self.pak43_spot, self.pak43_spot_angles, self.pak43_anim["idle"]);
		self waittill("scriptedanimdone");

		self.text = "Idle Done";

		pak43 notify("crew_anim_done");

		self thread pak43_crew_idle(pak43);
	}
}

pak43_crew_idle(pak43)
{
	self endon("death");
	pak43 endon("turret_fired");
	pak43 endon("stop_everything");

	while(1)
	{
		self.currentanim = "idle";
		self animscripted("scriptedanimdone", self.pak43_spot, self.pak43_spot_angles, self.pak43_anim["idle"]);
//		self setFlaggedAnimKnobRestart("animdone", self.pak43_anim["idle"]);
		self waittill("scriptedanimdone");		
	}
}

pak43_crew_damage_tracker(pak43)
{
	pak43 endon("death");

	self waittill("damage");

	pak43 notify("stop_everything");

	if (isalive(pak43)) {
		// let's kill the whole crew instead
		pak43 notify("death"); 
	}
}

pak43_crew_death_tracker(pak43)
{
	pak43 endon("death");

	self waittill("death");
    
	if(pak43.disabled == false)
	{
		level notify("pak destroyed");
		pak43.disabled = true;
	}
	pak43 notify("stop_everything");

	if (isalive(pak43)) {
		// let's kill the whole crew instead
		pak43 notify("death"); 
	}

}


pak43_crew_hop_off(pak43)
{
	pak43 waittill("stop_everything");


//	println("^1pak43_crew_hop_off");
	
	self notify("stop_moving");

	self clearanim(self.pak43_anim[self.currentanim] ,0);

	if(isdefined(self.target))
	{
		node = getnode(self.target,"targetname");
		self setgoalnode(node);
	}
	else
	{
		self setgoalpos(self.origin);
	}

	self animscripts\shared::putGunInHand ("right");
}

print_3d(text)
{
	if(getcvar("debug_pak43") != "1")
	{
		return;
	}

	while(1)
	{
		if(isdefined(self.text))
		{
			print3d((self.origin + (0,0,100)), self.text,(1,0,0), 1, 1);
		}
		wait 0.06;
	}
}