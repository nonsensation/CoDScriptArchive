#using_animtree("pak43");
main()
{
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
		println("^3Waiting to fire. Pak43 at (" + self.origin + ")");
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


death_think()
{
	self waittill("death", attacker);
	self notify("stop_everything");

	self playsound(self.deathsound);

	// If we want a certain animation to play, insert here!

	self clearTurretTarget();
	playfxonTag ( self.deathfx, self, "tag_body" );
	lingerfx = loadfx("fx/smoke/oneshotblacksmokelinger.efx");
	earthquake( 0.25, 3, self.origin, 1050 );

	self setmodel( self.deathmodel );
	self freevehicle();
	self.dead = true;
}

pak43_random_fire(min_delay, max_delay, targetname, target_coords, fake_fire, dont_aim)
{
	self endon("death");
	self endon("stop_random_fire");
	self endon("stop_everything");

	while(1)
	{
		if(isdefined(min_delay) && isdefined(max_delay))
		{
			range = max_delay - min_delay;
			delay = (min_delay + randomfloat(max_delay));
		}
		else
		{
			delay = (5 + randomfloat(5));
		}

		println("^3Pak43 at (" + self.origin + ") is waiting for: ", delay ," ^3seconds before firing.");
		wait delay;

		if(isdefined(targetname))
		{	
			println("^5(pak43_random_fire): Targets = ",targetname);
			targets = getentarray(targetname,"targetname");
			randomnum = randomint(targets.size);

			if(!isdefined(dont_aim) || !dont_aim)
			{
				self setTurretTargetVec(targets[randomnum].origin);
				self waittill("turret_on_target");
			}
		}
		else if(isdefined(target_coords))
		{	
			randomnum = randomint(target_coords.size);

			self setTurretTargetVec(targets[randomnum]);
			self waittill("turret_on_target");
		}
		

		if(isdefined(fake_fire) && fake_fire)
		{
			self fake_shoot(targets[randomnum]);
		}
		else
		{
			self shoot();
		}
	}
}

// Customized "fake shooting" 
fake_shoot(targetent)
{
	// Currently does not support firing without guys on.
	while(!self.ready_to_fire)
	{
		println("^3Waiting to fire. Pak43 at (" + self.origin + ")");
		wait 0.1;
	}

	if(self.health < 0)
	{
		return;
	}

	println("^5(_pak43_gmi::fake_shoot): FAKE FIRE: TRUE");

	turret_fx = loadfx("fx/vehicle/muzzleflash_pak43.efx");
	playfxontag(turret_fx, self, "tag_flash");
	self playsound("flak88_fire");

	self notify("turret_fired");
	self setanimknobrestart(%v_ge_art_pak43_fire);

	dist = distance(self.origin, targetent.origin);
	wait (dist * .0001);
	self notify("hit_target");

	if(isdefined(targetent))
	{
		if(isdefined(targetent.script_exploder))
		{
			level thread maps\_utility_gmi::exploder(targetent.script_exploder);
		}
		else
		{
			soundnum = randomint(3) + 1;

			if(soundnum == 1)
			{
				targetent playsound ("mortar_explosion1");
			}
			else if (soundnum == 2)
			{
				targetent playsound ("mortar_explosion2");
			}
			else
			{
				targetent playsound ("mortar_explosion3");
			}
		
			playfx ( level.mortar, targetent.origin );
			earthquake(0.15, 2, targetent.origin, 850);
			radiusDamage (targetent.origin, 512, 400,  1);
		}
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
		println("^1(Init_Guys): Not enough Spawners to fill Pak43 Crew at (" + self.origin + ")");
		return;
	}

	// Spawn in the crew.
	for(i=0;i<spawnpoints.size;i++)
	{
		spawned = spawnpoints[i] dospawn();

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
			println("^1(Init_Guys): Unable to Spawn Pak43 Crew at (" + self.origin + ")");
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
	self thread pak43_crew_damage_tracker(pak43);
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
	self thread pak43_crew_damage_tracker(pak43);
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
}

pak43_crew_hop_off(pak43)
{
	pak43 waittill("stop_everything");
	println("^1pak43_crew_hop_off");
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