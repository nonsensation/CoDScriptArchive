#using_animtree ("he111");

main()
{
	precachemodel("xmodel/v_ge_air_he111");
	precachemodel("xmodel/o_ge_prp_stukabomb"); // MikeD: Added for droping bombs.
	loadfx("fx/smoke/smoke_trail_125_white.efx");
	loadfx("fx/explosions/vehicles/he111_complete.efx");
	loadfx("fx/fire/fire_trail_100.efx");
	loadfx("fx/smoke/smoke_trail_100.efx");

	level.he111_bomb = loadfx ("fx/explosions/vehicles/he111_bomb.efx");
	level.he111_bomb_low = loadfx ("fx/explosions/vehicles/he111_bomb_low.efx");
}

init(health)
{
	self life(health);
	self thread kill();
	self thread plane_end();

	// Currently not used
//	self thread takeoff();
//	self thread wheelsup();

	self thread damage_tracker();

	self.inflight = 0;

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "noturrets")
	{
		println("^3No Turrets ",self.targetname);
		return;
	}

	// ***Insert Turrets, if needed, here!***
}

life(health)
{
	if(!isdefined(health))
	{
		self.health = 1200;
	}
	else
	{
		self.health = health;
	}
}

damage_tracker()
{
	if(isdefined(self.no_damage) && (self.no_damage))
	{
		return;
	}

	qtr_health = (self.health * 0.25);
	half_health = (self.health * 0.5);

	self.smokefx = loadfx("fx/smoke/smoke_trail_125_white.efx");
	self.damagemodel = ("xmodel/v_ge_air_he111");

	self.enginesmokeleft = spawn("script_origin",(0,0,0));
	self.enginesmokeleft linkto (self,"tag_engine_left",(0,0,0),(0,0,0));
	self.enginesmokeright = spawn("script_origin",(0,0,0));
	self.enginesmokeright linkto (self,"tag_engine_right",(0,0,0),(0,0,0));

	while(self.health > qtr_health)
	{
		self waittill("damage");
		if(self.health < half_health)
		{
			half_health = -10000;
			random_side = randomint(2);
			if(random_side == 0)
			{
				self thread enginesmoke("left");
			}
			else
			{
				self thread enginesmoke("right");
			}

			self setmodel(self.damagemodel);
		}

		if(self.health < qtr_health)
		{
			qtr_health = -10000;

			if(random_side == 0)
			{
				self thread enginesmoke("right");
			}
			else
			{
				self thread enginesmoke("left");
			}
		
			self thread enginesmoke("right");
		}
	}
}

kill()
{
// OLD:
//	self.crashfx = loadfx("fx/explosions/metal_b.efx");
//	self.smokefx = loadfx("fx/tagged/tailsmoke_flameout2.efx");
//	self.explode1 = loadfx("fx/tagged/stukka_boom1.efx ");
//	self.explode2 = loadfx("fx/tagged/stukka_firestream.efx");
//	self.deathmodel = ("xmodel/v_ge_air_he111");

// NEW:
	self.crashfx = loadfx("fx/explosions/vehicles/he111_complete.efx");
	self.smokefx = loadfx("fx/smoke/smoke_trail_100.efx");
	self.explode1 = loadfx("fx/explosions/vehicles/he111_complete.efx");
	self.explode2 = loadfx("fx/fire/fire_trail_100.efx");
	self.deathmodel = ("xmodel/v_ge_air_he111");

	self waittill( "death", attacker );

	self playsound ("explo_metal_rand");
	self thread deadexploded();

	earthquake(0.25, 3, self.origin, 1050);
	
//	self hide();
	self setmodel (self.deathmodel);
}

enginesmoke(side)
{
	accdist = 0.001;
	fullspeed = 1000.00;

	timer = gettime()+10000;
	while(1)
	{
		oldorg = self.origin;
		wait 0.1 + randomfloat(0.25);
		dist = distance(oldorg,self.origin);
		accdist += dist;
		enginedist = 128;
		if(self.speed > 1)
		{
			if(accdist > enginedist)
			{
				speedtimes = self.speed/fullspeed;
				if(side == "right")
				{
					playfx (self.smokefx, self.enginesmokeright.origin);
				}

				if(side == "left")
				{
					playfx (self.smokefx, self.enginesmokeleft.origin);
				}

				accdist -= enginedist;
			}
		}
	}
}

deadexploded()
{
//	self thread explodesequence();
	playfx (self.explode1, self.origin);
	accdist = 0.001;
	fullspeed = 1000.00;


	timer = gettime()+10000;
	while(1)
	{
		oldorg = self.origin;
		wait 0.1;
		dist = distance(oldorg,self.origin);
		accdist += dist;
		enginedist = 64;
		if(self.speed > 1)
		{
			if(accdist > enginedist)
			{
				speedtimes = self.speed/fullspeed;
				playfx (self.explode2, self.origin);
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

	// ToDo: Need to add sound to level.
//	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}

plane_end()
{
	self waittill ("reached_end_node");

	if(self.health <= 0 && (self.inflight))
	{
		self crash();
		self delete();
	}
	else if(self.health > 0)
	{
		self delete();
	}
	else if(isdefined(self.script_noteworthy) && self.script_noteworthy == "loop")
	{
		self attachpath(self.path);
		self startpath();
	}
	else
	{
		self freevehicle();
	}

}

waitframe()
{
	maps\_spawner_gmi::waitframe();
}

regen()
{
	self endon ("death");
	healthbuffer = 1000;
	self.health += healthbuffer;
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

// Currently not used.
//takeoff()
//{
//	self UseAnimTree(#animtree);
//	self waittill ("takeoff");
//	self setanim(%stuka_takeoff);
//	self setanim(%stuka_pose);
//}

// Currently not used.
//wheelsup()
//{
//	return;
//	self UseAnimTree(#animtree);
//	self waittill ("wheelsup");
//	println("wheelsup!!!!!!!");
//	self setanim(%stuka_takeoff);
//}

drop_bombs(amount, delay, delay_trace, damage_range, max_damage, min_damage, random_vec)
{
	self endon("death");

	if(isdefined(delay))
	{
		user_delay = delay;
		println("user_delay ",user_delay);
	}

	if(!isdefined(amount))
	{
		amount = 8;
	}

	side = randomint(2);
	sound_num_check = 1;
	fx_num_check = 1;
	for(i=0;i<amount;i++)
	{
		if(side == 0)
		{
			bomb = spawn("script_model",(self gettagorigin("tag_smallbomb01Left")));
			bomb.angles = self gettagangles("tag_smallbomb01Left");
			side = 1;
		}
		else
		{
			bomb = spawn("script_model",(self gettagorigin("tag_smallbomb01Right")));
			bomb.angles = self gettagangles("tag_smallbomb01Right");
			side = 0;
		}
		bomb setmodel("xmodel/o_ge_prp_stukabomb");

		forward = anglestoforward(self.angles);
		vec = maps\_utility_gmi::vectorScale (forward, self.speed);

		// Compensates for the frame delay when "unlinked."
		vec_predict = bomb.origin + maps\_utility_gmi::vectorScale (forward, (self.speed * 0.06));

		// Add more side-ways to the bomb dropping.
		if(isdefined(random_vec))
		{
			half_random_vec = (random_vec * 0.5);
			vec = (vec[0], (half_random_vec - randomint(random_vec)), vec[2]);
		}

		// If a lot of bombs are dropped, we will run out of channels.
		// So, if the he111 has ".bomb_sound_number" it will assign every Nth
		// bomb the ability to play the explosion sound.

		if(isdefined(self.bomb_sound_every))
		{
			if(self.bomb_sound_number == 0)
			{
				bomb.play_sound = false;
			}
			else
			{
				if((self.bomb_sound_every * sound_num_check) == (i+1))
				{
					bomb.play_sound = true;
					sound_num_check++;
				}
				else
				{
					bomb.play_sound = false;
				}
			}
		}
		else
		{
			bomb.play_sound = true;
		}

		if(isdefined(self.bomb_fx_every))
		{
			if((self.bomb_fx_every * fx_num_check) == (i+1))
			{
				bomb.play_fx = true;
				fx_num_check++;
			}
			else
			{
				bomb.play_fx = false;
			}
		}
		else
		{
			bomb.play_fx = true;
		}

		bomb.origin = vec_predict; // Compensates for the frame delay when "unlink" is called.
//		println("Vec = ",vec);
		bomb moveGravity (((vec)), 10);
		bomb thread bomb_wiggle();
//
		bomb thread bomb_trace(delay_trace, damage_range, max_damage, min_damage);

		if(isdefined(user_delay))
		{
			delay = user_delay;
		}
		else
		{
			delay = 0.1 + randomfloat(0.25);
		}
		wait delay;
	}
}

bomb_wiggle()
{
	self endon("death");

	original_angles = self.angles;
	while(1)
	{
		roll = 10 + randomfloat(20);
		yaw = 4 + randomfloat(3);
//		angles = (0, (original_angles[1] + randomfloat(1)),(0.5 + randomfloat(1)));
		time = 0.5 + randomfloat(0.25);
		time_in_half = time/3;

		self bomb_pitch(time);
		self rotateto((self.pitch,(original_angles[1] + (yaw * -2)),(roll * -2)), (time * 2),(time_in_half * 2),(time_in_half * 2));
		self waittill("rotatedone");

		self bomb_pitch(time);
		self rotateto((self.pitch,(original_angles[1] + (yaw * 2)),(roll * 2)), (time * 2),(time_in_half * 2),(time_in_half * 2));
		self waittill("rotatedone");
	}
}

bomb_pitch(time_of_rotation)
{
	self endon("death");

	if(!isdefined(self.pitch))
	{
		original_pitch = self.angles;
		self.pitch = original_pitch[0];
		time = 15 + randomfloat(5);
	}

	if(self.pitch < 80)
	{
		self.pitch = (self.pitch + (40 * time_of_rotation));
		if(self.pitch > 80)
		{
			self.pitch = 80;
		}
	}
	return;
}

bomb_trace(delay_trace, damage_range, max_damage, min_damage)
{
	self endon("death");
	if(isdefined(delay_trace))
	{
		wait delay_trace;
	}
	while(1)
	{
		vec1 = self.origin;
		direction = anglestoforward((90,0,0));
		vec2 = vec1 + maps\_utility_gmi::vectorScale(direction,10000);
		trace_result = bulletTrace(vec1, vec2, false, undefined);

//		dist = distance(self.origin, trace_result["position"]);
//		println("Dist ", dist);

		// Check the distance, in order to blow up... Failsafe, if the bomb happened to go through the ground
		// the >= 10000 should pickup and blowup.
		if(distance(self.origin, trace_result["position"]) < 64 || distance(self.origin, trace_result["position"]) >= 10000)
		{
			if (!isdefined(level.he111_bomb))
			{
				maps\_utility_gmi::error ("^1level.he111_bomb is not defined. Please specify in your script.");
			}
			else
			{
				self thread bomb_explosion(damage_range, max_damage, min_damage);
			}

		}

//		line(vec1, trace_result["position"]);
		wait 0.05;
	}
}

bomb_explosion(damage_range, max_damage, min_damage)
{
	if(isdefined(level.he111_bomb_qpower))
	{
		quake_power = level.he111_bomb_qpower;
	}
	else
	{
		quake_power = 0.5;
	}

	if(isdefined(level.he111_bomb_qtime))
	{
		quake_time = level.he111_bomb_qtime;
	}
	else
	{
		quake_time = 2;
	}

	if(isdefined(level.he111_bomb_qradius))
	{
		quake_radius = level.he111_bomb_qradius;
	}
	else
	{
		quake_radius = 1024;
	}

	if(!isdefined(damage_range))
	{
		damage_range = 768;
	}

	if(!isdefined(max_damage))
	{
		max_damage = 400;
	}

	if(!isdefined(min_damage))
	{
		min_damage = 25;
	}

	soundnum = 0;
	soundnum = randomint(5) + 1;

	sound_org = spawn("script_origin",self.origin);
	// 

	if(isdefined(self.play_sound) && self.play_sound)
	{
		sound_org playsound ("stuka_bomb");
	}

	sound_org thread bomb_sound_delete();

//	println("^1BOOOM!!! ^7(Dmg Radius: ", damage_range, " | Max Dmg: ",max_damage," | Min Dmg: ",min_damage,")");

	if(!isdefined(level.he111_bomb_lod_dist))
	{
		level.he111_bomb_lod_dist = 5000;
	}

	if(self.play_fx)
	{
		if(distance(level.player.origin, self.origin) < level.he111_bomb_lod_dist)
		{
			playfx ( level.he111_bomb, self.origin );
		}
		else
		{
			playfx ( level.he111_bomb_low, self.origin );
		}
	}

	earthquake(quake_power, quake_time, self.origin, quake_radius);
	radiusDamage ( self.origin, damage_range, max_damage, min_damage);

	if(isdefined(level.dummy_count) && level.dummy_count > 1 && damage_range != 0)
	{
		dummies = getentarray("dummy","targetname");
		for(i=0;i<dummies.size;i++)
		{
			if(damage_range <= 256)
			{
				damage_range = 512;
			}
			if(distance(self.origin,dummies[i].origin) < damage_range)
			{
				dummies[i] notify("explosion death");
			}
		}
	}
	self delete();
}

bomb_sound_delete()
{
	wait 5;
	self delete();
}