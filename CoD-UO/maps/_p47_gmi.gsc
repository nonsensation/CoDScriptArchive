// Rewrite this as P-47 assets come in.

#using_animtree ("stuka");

main()
{
	precachemodel("xmodel/v_us_air_p47");
	precachemodel("xmodel/vehicle_plane_stuka_d");
	//precachemodel("xmodel/vehicle_plane_stuka_gun");
	//precachemodel("xmodel/vehicle_plane_stuka_d");
	//precachemodel("xmodel/vehicle_plane_stuka_shot");
	precachevehicle("Stuka");
	precacheturret("Stuka_guns");
	precachemodel("xmodel/o_ge_prp_stukabomb"); // MikeD: Added for droping bombs.
	loadfx("fx/explosions/metal_b.efx");
	loadfx("fx/tagged/tailsmoke_flameout2.efx");
	loadfx("fx/tagged/stukka_boom1.efx ");
	loadfx("fx/tagged/stukka_firestream.efx");

}

init(bomb_count)
{
	life();
	thread kill();
	thread plane_end();
	thread takeoff();
	thread wheelsup();

	self.inflight = 0;
	if(isdefined(bomb_count))
	{
		self thread attach_bombs(bomb_count);
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "noturrets")
	{
		println("^3No Turrets ",self.targetname);
		return;
	}
	self.leftturret = spawnTurret("misc_turret", (0,0,0), "p47_guns");
	self.rightturret = spawnTurret("misc_turret", (0,0,0), "p47_guns");
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

life()
{
	self.health = 300;
	thread regen();
}

kill()
{
	self.crashfx = loadfx("fx/explosions/metal_b.efx");
	self.smokefx = loadfx("fx/tagged/tailsmoke_flameout2.efx");
	self.explode1 = loadfx("fx/tagged/stukka_boom1.efx ");
	self.explode2 = loadfx("fx/tagged/stukka_firestream.efx");
	self.deathmodel = ("xmodel/vehicle_plane_stuka_shot");
	self waittill( "death", attacker );
	thread turret_kill();

	self playsound ("explo_metal_rand");
	thread deadexploded();

	earthquake(0.25, 3, self.origin, 1050);
	self.enginesmokeleft = spawn("script_origin",(0,0,0));
	self.enginesmokeleft linkto (self,"tag_engine_left",(0,0,0),(0,0,0));

	thread enginesmoke();
	//println ("^2PLANE SHOT DOWN! MUHAHAHA!!!!");
	
	if (!isdefined (self.script_vehiclegroup))
	{
		println ("^2SPECIAL PLANE SHOT DOWN");
		self setmodel ("xmodel/vehicle_plane_stuka_d");
	}
	else if ( (self.script_vehiclegroup == 4) || (self.script_vehiclegroup == 5) )
	{
		println ("^2SPECIAL PLANE SHOT DOWN");
		self setmodel ("xmodel/vehicle_plane_stuka_d");
	}
	else
	{
		self setmodel (self.deathmodel);
	}

	wait .7;
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
				accdist -= enginedist;
			}
		}
	}
}

deadexploded()
{
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

	self waittill ("reached_end_node");
	if(!(isdefined(self.script_noteworthy) && self.script_noteworthy == "noturrets"))
	{
		turret_kill();
	}

	if(isdefined(self.bomb))
	{
		for(i=0;i<self.bomb.size;i++)
		{
			if(isdefined(self.bomb[i]) && !self.bomb[i].dropped)
			{
				self.bomb[i] delete();
			}
		}
	}

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

turret_kill()
{
	if(isdefined(self.leftturret) && isalive(self.leftturret))
		self.leftturret delete();
	if(isdefined(self.rightturret) && isalive(self.rightturret))
		self.rightturret delete();
}

shoot_guns(notarget)
{
	self notify ("stop mg42s");
	self endon ("stop mg42s");
	self endon ("death");
	if(!(self.health > 0))
		return;

	fFirerate = 0.050;

	if(!isdefined(notarget))
	{
		self.rightturret settargetentity(level.player);
		self.leftturret settargetentity(level.player);
	}

	while(1)
	{
		self.leftturret shootturret();
		self.rightturret shootturret();
		wait fFirerate;
	}

}

sirens()
{
	self endon ("stop_mg42s");
	while(1)
	{
		self playsound("stuka_siren");
		self waittill ("sounddone");

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
takeoff()
{
	self UseAnimTree(#animtree);
	self waittill ("takeoff");
	self setanim(%stuka_takeoff);
	self setanim(%stuka_pose);
}

wheelsup()
{
	return;
	self UseAnimTree(#animtree);
	self waittill ("wheelsup");
	println("wheelsup!!!!!!!");
	self setanim(%stuka_takeoff);
}

attach_bombs(bomb_count)
{
	self.bomb_count = bomb_count;

	self.bomb = [];
	for(i=0;i<self.bomb_count;i++)
	{
		self.bomb[i] = spawn("script_model",(self.origin));
		self.bomb[i] setmodel("xmodel/o_ge_prp_stukabomb");
		self.bomb[i].dropped = false;

		if(i<2)
		{
			self.bomb[i] linkto(self,"tag_smallbomb0" + (i + 1) + "Left",(0,0,-4),(-10,0,0));
		}
		else
		{
			self.bomb[i] linkto(self,"tag_smallbomb0" + (randomint(2) +1) + "Right",(0,0,-4),(-10,0,0));
		}
	}
}

drop_bombs(amount, delay, delay_trace, damage_range, max_damage, min_damage)
{
	total_bomb_count = self.bomb.size;

	if(!isdefined(self.bomb.size))
	{
		return;
	}

	if(self.bomb.size == 0 || total_bomb_count == 0)
	{
		println(self.targetname, " ^3Sorry Stuka has no bombs!");
		return;
	}

	if(isdefined(delay))
	{
		user_delay = delay;
		println("user_delay ",user_delay);
	}

	if(isdefined(amount))
	{
		if(amount == 0)
		{
			return;
		}

		if(amount > self.bomb_count)
		{
			amount = self.bomb_count;
		}

		for(i=0;i<amount;i++)
		{
			if(total_bomb_count <= 0)
			{
				println("Sorry no more bombs!");
				return;
			}

			if(isdefined(self.bomb[i]) && self.bomb[i].dropped)
			{
				for(q=0;q<self.bomb_count;q++)
				{
					if(isdefined(self.bomb[q]) && !self.bomb[q].dropped)
					{
						i = q;
						q = (self.bomb_count + 1);
					}
				}
			}
			else if(!isdefined(self.bomb[i]))
			{
				for(q=0;q<self.bomb_count;q++)
				{
					if(isdefined(self.bomb[q]) && !self.bomb[q].dropped)
					{
						i = q;
						q = (self.bomb_count + 1);
					}
				}
			}

			// There's a bug in here... If you call more than total_amount to drop, like drop 
			// 1, drop 1, drop 1 drop 1, drop 1, it will either error out or have the 1st bomb 
			// get carried over.

			total_bomb_count--;
			self.bomb_count--;
			self.bomb[i].dropped = true;

			forward = anglestoforward(self.angles);
			vec = maps\_utility_gmi::vectorScale (forward, self.speed);

			// Compensates for the frame delay when "unlinked."
			vec_predict = self.bomb[i].origin + maps\_utility_gmi::vectorScale (forward, (self.speed * 0.06));

			self.bomb[i] unlink();
			self.bomb[i].origin = vec_predict; // Compensates for the frame delay when "unlink" is called.
			self.bomb[i] moveGravity (((vec)), 10);
			self.bomb[i] thread bomb_wiggle();

			self.bomb[i] thread bomb_trace(delay_trace, damage_range, max_damage, min_damage);
	
			if(isdefined(user_delay))
			{
				delay = user_delay;
			}
			else
			{
				delay = 0.1 + randomfloat(0.5);
			}
			wait delay;
		}		
	}
	else
	{
		for(i=0;i<self.bomb.size;i++)
		{
			if(!isdefined(self.bomb[i]) || self.bomb[i].dropped)
			{
				continue;
			}

			if(total_bomb_count <= 0)
			{
				println("Sorry no more bombs! ",self.targetname);
				return;
			}

			total_bomb_count--;
			self.bomb_count--;
			forward = anglestoforward(self.angles);
			vec = maps\_utility_gmi::vectorScale (forward, self.speed);

			// Compensates for the frame delay when "unlinked."
			vec_predict = self.bomb[i].origin + maps\_utility_gmi::vectorScale (forward, (self.speed * 0.06));

			vec = ( (vec[0] + (-20 + randomfloat(40))),(vec[1] + (-20 + randomfloat(40))),vec[2]);

			self.bomb[i] unlink();
			self.bomb[i].origin = vec_predict; // Compensates for the frame delay when "unlink" is called.
			self.bomb[i] moveGravity ((vec), 10);
			self.bomb[i] thread bomb_wiggle();

			self.bomb[i] thread bomb_trace(delay_trace, damage_range, max_damage, min_damage);
	
			if(isdefined(user_delay))
			{
				delay = user_delay;
			}
			else
			{
				delay = 0.1 + randomfloat(0.5);
			}
			wait delay;
		}
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
		time = 0.25 + randomfloat(0.25);
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

test()
{
	self endon("death");
	while(1)
	{
		vec1 = self.origin;
		forward = anglestoforward(self.angles);
		vec2 = vec1 + maps\_utility_gmi::vectorScale(forward,self.speed);
		trace_result = bulletTrace(vec1, vec2, false, undefined);
		line(vec1, vec2);
		wait 0.05;
	}
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
			if (!isdefined(level.p47_bomb))
			{
				maps\_utility_gmi::error ("level.p47_bomb is not defined. Please specify in your script.");
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
	if(isdefined(level.p47_bomb_qpower))
	{
		quake_power = level.p47_bomb_qpower;
	}
	else
	{
		quake_power = 0.7;
	}

	if(isdefined(level.p47_bomb_qtime))
	{
		quake_time = level.p47_bomb_qtime;
	}
	else
	{
		quake_time = 2;
	}

	if(isdefined(level.p47_bomb_qradius))
	{
		quake_radius = level.p47_bomb_qradius;
	}
	else
	{
		quake_radius = 3072;
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
	sound_org playsound ("allied_bomb");
	sound_org thread bomb_sound_delete();

	println("^1BOOOM!!! ^7(Dmg Radius: ", damage_range, " | Max Dmg: ",max_damage," | Min Dmg: ",min_damage,")");

	playfx ( level.p47_bomb, self.origin );
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

	// MikeD: I know not to do this, but need it for flinching guys in the trucks.
	if(level.script == "trenches")
	{
		truckriders = [];
		truck1_riders = getentarray("truck1_rider","targetname");
		truckriders = add_array_to_array(truckriders,truck1_riders);
	
		truck2_riders = getentarray("truck2_rider","targetname");
		truckriders = add_array_to_array(truckriders,truck2_riders);
	
		friends = getentarray("friends","groupname");
		truckriders = add_array_to_array(truckriders,friends);

		for(i=0;i<truckriders.size;i++)
		{
			if(isalive(truckriders[i]) && distance(self.origin, truckriders[i].origin) < 5000)
			{
				truckriders[i] notify("truck flinch");
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

add_array_to_array(array1, array2)
{
	if(!isdefined(array1) || !isdefined(array2))
	{
		println("^3(ADD_ARRAY_TO_ARRAY)WARNING! WARNING!, ONE OF THE ARRAYS ARE NOT DEFINED");
		return;
	}

	array = array1;

	for(i=0;i<array2.size;i++)
	{
		array[array.size] = array2[i];
	}
	return array;
}