main()
{
	// OPening Path
	precacheModel("xmodel/foy_dummies_opening");

	// Haystack Path
	precacheModel("xmodel/foy_dummies_haystack");

	// Easthill Path
	precacheModel("xmodel/foy_dummies_easthill");

	// Westhill Path
	precacheModel("xmodel/foy_dummies_westhill");

	// Lasthill Path
	precacheModel("xmodel/foy_dummies_lasthill");

	// Dummy characters
	// Axis:
	character\German_wehrmact_snow::precache();

	// Allies:
	character\Airborne1a_thompson_snow ::precache();      
	character\Airborne1b_garand_snow ::precache();     
	character\Airborne1c_bar_snow ::precache();

	precacheModel("xmodel/weapon_kAr98");
	precachemodel("xmodel/weapon_MP40");
	precachemodel("xmodel/weapon_garand");
	precacheModel("xmodel/weapon_thompson");

	level._effect["fake_snow_impact"] = loadfx ("fx/weapon/impacts/impact_snow_distant.efx");
}

#using_animtree("foy_dummies_path");

// Spawns in the Animated Tag Model, sets up angle offset and optional loop.

// Syntax:
// dummies_setup(pos, model, total_tags, angle_offset, loop_time, loop_num, path_anim, weap, anim_name, anim_wait, random_move_forward, gun_fire_notify, mortar_amount);
// -------
// pos - (Coordinates) position, coordinates the TAG MODEL will spawn in at. ex: (123,123,123)
// model - (Model Name) file name of the actual TAG MODEL ex: "xmodel/blah"
// total_tags - (Number) Total amount of tags on the TAG MODEL. ex: 19
// angle_offset - (ANgles) Angle offset, sometimes artist will have it the wrong way. ex: (0,180,0)
// loop_time - (Number) If you want it to loop, this sets the delay between each wave of guys. ex: 5
// loop_num - (Number) If you want it to loop, this sets the number of times it loops. ex: 7
// path_anim - (Filename) The filename of the animation that the TAG MODEL will use to animate. ex: %foy_dummies_blah
// weap - (Boolean) If you want the guys to spawn in with a weapon in hand. ex: true
// anim_name - (String) The animname the guys will spawn in with. ex: "drone"
// anim_wait - (Array) The delay before the guys will die. ex: anim_wait[0] = 1;
// random_move_forward - (Boolean) If you want the guys to animate randomly while running. ex: true
// gun_fire_notify - (String) The level notify that will be sent out when the last guy dies. ex: "stop gun fire"
// mortar_amount - (Number) The total amount of mortars that are allowed to be dropped on a wave of guys. ex: 2

dummies_setup(pos, model, total_tags, angle_offset, loop_time, loop_num, path_anim, weap, anim_name, anim_wait, random_move_forward, gun_fire_notify, mortar_amount, no_random_wait)
{
	if(!isdefined(level.dummy_count))
	{
		level.dummy_count = 0;
	}

	loops = 0;
	while(1)
	{	
//println("^5DUMMY PATH SPAWNED!");
		dummies_path = spawn ("script_model",(pos));
		dummies_path setmodel (model);
		dummies_path.num = 0;
		dummies_path.total_tags = total_tags;

		if(isdefined(mortar_amount))
		{
			dummies_path.mortar_amount = mortar_amount;
		}
		else
		{
			dummies_path.mortar_amount = 1;
		}

		if(isdefined(angle_offset))
		{
			dummies_path.angles = (angle_offset);
		}
		else
		{
			dummies_path.angles = (0,0,0);
		}
		dummies_path hide();
		dummies_path UseAnimTree(#animtree);

		dummies_path thread dummies_path_think(path_anim, weap, anim_name, anim_wait, random_move_forward, gun_fire_notify, no_random_wait);

		if(isdefined(loop_time))
		{
			loops++;

			if(loop_time == "random")
			{
				wait (1 + randomfloat(3));
			}
			else
			{
				wait loop_time;
			}

			if(isdefined(loop_num) && loops == loop_num)
			{
				break;
			}
		}
		else
		{
			break;
		}
	}

	if (isdefined(dummies_path))
	{
		while(dummies_path.num > 0)
		{
			println("DUMMIES PATH NUM : ",dummies_path.num);
			wait 0.5;
		}
	}

	if(isdefined(gun_fire_notify))
	{
		println("GUN FIRE NOTIFY ",gun_fire_notify);
		level notify(gun_fire_notify);
	}
}

dummies_path_think(path_anim, weap, anim_name, anim_wait, random_move_forward, gun_fire_notify, no_random_wait)
{
	self setFlaggedAnimKnobRestart("animdone", path_anim);

	dummie_scale = getcvarint("scr_gmi_fast");
	count = self.total_tags;

	if (dummie_scale == 1)
		count = count / 2;
	if (dummie_scale == 2)
		count = 0;

//	iprintln("dummies wanted tags ",self.total_tags," got ",count);


	for (i=0;i<count;i++)
	{
		if (i < 10)
		{
			tag_num = ("tag_guy0" + i);
		}
		else
		{
			tag_num = ("tag_guy" + i);
		}

//println("^5DUMMY ",anim_name," Spawned! Num: ", i);
		dummy = spawn ("script_model",(self.origin));
		level.dummy_count++;
		self.num++;
		dummy.targetname = "dummy";
		dummy.tag = tag_num;
		dummy.num = i;
		dummy.died = false;
		dummy.animname = anim_name;

		dummy [[random(level.scr_character[anim_name])]]();
		if(weap)
		{
			random_weapon = randomint(2);

// Add a check for what character he is, then select the appropiate weapon.
			if(random_weapon == 0)
			{
				if(dummy.model == "xmodel/character_airborne_winter")
				{
					dummy attach("xmodel/weapon_Thompson", "tag_weapon_right");
				}
				else
				{
					dummy attach("xmodel/weapon_MP40", "tag_weapon_right");
				}
			}
			else
			{
				if(dummy.model == "xmodel/character_airborne_winter")
				{
					dummy attach("xmodel/weapon_M1Garand", "tag_weapon_right");
				}
				else
				{
					dummy attach("xmodel/weapon_kAr98", "tag_weapon_right");
				}
			}
		}

		dummy thread dummy_think_death(self);
		dummy thread dummy_think(self, anim_wait, random_move_forward, no_random_wait);
	}

	while(self.num > 0)
	{
		wait 0.5;
	}
	wait 1;

	self delete();
}

#using_animtree("foy_dummies");
dummy_think(dummies_path, anim_wait, random_move_forward, no_random_wait)
{
	self endon("death");

	self.move_index = randomint (level.scr_anim[self.animname]["move_forward"].size);
	self.move_anim = level.scr_anim[self.animname]["move_forward"][self.move_index];

	self UseAnimTree(#animtree);
	self.origin = dummies_path gettagorigin (self.tag);
	self linkto (dummies_path, self.tag, (0,0,0), (0,0,0));
//println("^5Position ",self.origin);

	self thread dummy_animloop(random_move_forward);

	if(isdefined(anim_wait))
	{
		if(isdefined(no_random_wait) && no_random_wait)
		{
			if(anim_wait.size == 1)
			{
				wait anim_wait[0];
			}
			else
			{
				wait anim_wait[self.num];
			}
		}
		else
		{
			if(anim_wait.size == 1)
			{
				wait ((anim_wait[0] - 2) - randomfloat(10));
			}
			else
			{
	//println("^5WAITING : ",anim_wait[self.num]);
				wait ((anim_wait[self.num] - 2) - randomfloat(10));
			}
		}
	}
	else
	{
		if (self.num < 10)
		{
			wait (5 + randomfloat (5)) ;
		}
		else if (self.num >= 10 )
		{
			wait (10 + randomfloat (5));
		}
	}

	random_num = randomint(2);

	if(self.died)
	{
		return;
	}

	if(random_num == 0 && isdefined(dummies_path) && dummies_path.mortar_amount > 0)
	{
		dummies_path.mortar_amount--;
		self thread instant_mortar();
		return;
	}

	// Wait for this to finish before playing death anim. 
	// Make sure you add a "top" delay of 2 seconds to the above anim_wait;
	self bloody_death(); 

	self unlink();
//	println("^5UNLINK!!!!");

	if(isdefined(level.scr_anim[self.animname]["death"]))
	{
		deathanim = random (level.scr_anim[self.animname]["death"]);
		self notify("stop_anim");
		self animscripted("death anim", self.origin, self.angles, deathanim, "deathplant");
		self.died = true;
		if(isdefined(dummies_path))
		{                          
			dummies_path.num--;
		}     
		wait 4;
		self movez (-100, 3, 2, 1);
		wait 3;
	}
	else
	{
		self.died = true;
		dummies_path.num--;
	}


	level.dummy_count--;
	self delete();
}

dummy_animloop(random_move_forward, movement)
{
	self endon("death");
	self endon("stop_anim");
	while (self.died == false)
	{
		if(!isdefined(num))
		{
			num = 0;
		}

		self setFlaggedAnimKnob("animdone", self.move_anim);
		self waittillmatch ("animdone", "end");
		num++;

		if(!isdefined(movement))
		{
			if(random_move_forward)
			{
				if(num == 5)
				{
					self.move_index = randomint (level.scr_anim[self.animname]["move_forward"].size);
					self.move_anim = level.scr_anim[self.animname]["move_forward"][self.move_index];
					num = 0;
				}
			}
		}
		else if(movement == "idle")
		{
			if(random_move_forward)
			{
				if(num == 3)
				{
					self.move_index = randomint (level.scr_anim[self.animname]["idle"].size);
					self.move_anim = level.scr_anim[self.animname]["idle"][self.move_index];
					num = 0;
				}
			}			
		}
	}
}

#using_animtree("foy_dummies");
dummy_think_death(dummies_path)
{
	self endon("death");

	self waittill("explosion death");
	if(self.died)
	{
		return;
	}

	wait randomfloat(0.25);
//	println("^5BOOOOOOOOOOOOOOM! Dead");
	self unlink();
//	println("^5UNLINK!!!!");
	self notify("stop_anim");

	deathanim = random (level.scr_anim[self.animname]["exp_death"]);
	self notify("stop_anim");
	self animscripted("death anim", self.origin, self.angles, deathanim, "deathplant");

	self.died = true;

	if(isdefined(dummies_path))
	{                          
		dummies_path.num--;
	}                        

	wait 4;
	self movez (-100, 3, 2, 1);
	wait 3 + randomfloat(5);

	level.dummy_count--;
	self delete();             
}                                  

death_move_down(delay)
{
	wait delay - 0.5;

	trace_result = bulletTrace((self.origin + (0,0,0)), (self.origin - (0,0,1000)), false, undefined);
	pos = trace_result["position"];

	self movez(pos[2] - self.origin[2], 1, 0, 0);
	self waittill("movedone");
	self notify("sink_into_ground");
}

//Random Arrays
random (array)
{
	return array [randomint (array.size)];
}

// **********START INSTANT MORTAR SECTION********** Probably should incorporate this into _mortar.gsc
instant_mortar (range, max_damage, min_damage, fQuakepower, iQuaketime, iQuakeradius)
{
	instant_incoming_sound();

	level notify ("mortar");
	self notify ("mortar");

	if (!isdefined (range))
	{
		range = 256;
	}
	if (!isdefined (max_damage))
	{
		max_damage = 400;
	}
	if (!isdefined (min_damage))
	{
		min_damage = 25;
	}

	if(isdefined(level.dummy_count) && level.dummy_count > 1 && range != 0)
	{
		dummies = getentarray("dummy","targetname");
		for(i=0;i<dummies.size;i++)
		{
			if(range <= 256)
			{
				range = 512;
			}
			if(distance(self.origin,dummies[i].origin) < (range * 0.75))
			{
				dummies[i] notify("explosion death");
			}
		}
	}

	if ((isdefined(self.has_terrain) && self.has_terrain == true) && (isdefined (self.terrain)))
	{
		for (i=0;i<self.terrain.size;i++)
		{
			if (isdefined (self.terrain[i]))
				self.terrain[i] delete();
		}
	}
	
	if (isdefined (self.hidden_terrain) )
	{
		self.hidden_terrain show();
	}
	self.has_terrain = false;
	
	instant_mortar_boom( self.origin, fQuakepower, iQuaketime, iQuakeradius );
}

instant_mortar_sound()
{
	if (!isdefined (level.mortar_last_sound))
	{
		level.mortar_last_sound = -1;
	}

	soundnum = 0;
	while (soundnum == level.mortar_last_sound)
	{
		soundnum = randomint(3) + 1;
	}

	level.mortar_last_sound	= soundnum;

	if (soundnum == 1)
	{
		self playsound ("mortar_explosion1");
	}
	else if (soundnum == 2)
	{
		self playsound ("mortar_explosion2");
	}
	else
	{
		self playsound ("mortar_explosion3");
	}
}

instant_mortar_boom (origin, fPower, iTime, iRadius)
{
	if(isdefined(level.mortar_quake))
	{
		fpower = level.mortar_quake;
	}
	else
	{ 
		if(!isdefined(fPower))
		{
			fPower = 0.15;
		}
	}

	if (!isdefined(iTime))
	{
		iTime = 2;
	}
	if (!isdefined(iRadius))
	{
		iRadius = 850;
	}

	instant_mortar_sound();
	playfx ( level.mortar, origin );
	earthquake(fPower, iTime, origin, iRadius);
}

instant_incoming_sound(soundnum)
{
	if (!isdefined (soundnum))
	{
		soundnum = randomint(3) + 1;
	}

	if (soundnum == 1)
	{
		self playsound ("mortar_incoming1");
		if(isdefined(self.sound_delay))
		{
			wait (self.sound_delay);
		}
	}
	else
	if (soundnum == 2)
	{
		self playsound ("mortar_incoming2");
		if(isdefined(self.sound_delay))
		{
			wait (self.sound_delay);
		}
	}
	else
	{
		self playsound ("mortar_incoming3");
		if(isdefined(self.sound_delay))
		{
			wait (self.sound_delay);
		}
	}
}

bloody_death(poor_bastard)
{
	tag_array = level.scr_dyingguy["tag"];
	tag_array = maps\_utility_gmi::array_randomize(tag_array);
	tag_index = 0;
	waiter = false;

	if(isdefined(poor_bastard) && poor_bastard)
	{
		self endon ("death");

		fx = loadfx ("fx/impacts/flesh_hit.efx");
		head_tag = "bip01 head";  
	
		playfxOnTag ( fx, self, head_tag );
		self thread playSoundOnTag("bullet_mega_flesh", head_tag);

		// Kill the bastard! :P
		self DoDamage ( self.health + 50, (-312, -2413, 367));
	}
	else
	{
		for (i=0;i<3 + randomint (5);i++)
		{
			playfxOnTag ( level._effect [random (level.scr_dyingguy["effect"])], self, level.scr_dyingguy["tag"][tag_index] );
			thread playSoundOnTag(random (level.scr_dyingguy["sound"]), level.scr_dyingguy["tag"][tag_index]);
	
			tag_index++;
			if (tag_index >= tag_array.size)
			{
				tag_array = maps\_utility::array_randomize(tag_array);
				tag_index = 0;
			}
	
			wait randomfloat(0.25);
		}
	}
}

playSoundOnTag (alias, tag)
{
	if ((isSentient (self)) && (!isalive (self)))
		return;

	org = spawn ("script_origin",(0,0,0));
	if (isdefined (tag))
		org linkto (self, tag, (0,0,0), (0,0,0));
	else
	{
		org.origin = self.origin;
		org.angles = self.angles;
		org linkto (self);
	}

	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}

// Syntax:
// fake_bullet_tracers(location, duration, wait_till, delay)
// -------
// location - (String) Sets up the correct coordinates for this map only. ex: "opening"
// duration - (Number) Sets the duration that it will fire for.
// wait_till - (String) If defined, it will make it so that it ends upon the level notify. ex: "stop mg42"
// delay - Amount of seconds to delay for before firing. ex: 12

fake_bullet_tracers(location, duration, wait_till, delay)
{

	dummie_scale = getcvarint("scr_gmi_fast");

	if (dummie_scale == 2) return;

	if(isdefined(wait_till))
	{
		level endon(wait_till);
	}

	if(delay)
	{
		wait delay;
	}

	// Used to keep track if the gun fire is suppose to (in conjunction with duration)
	if(!isdefined(level.fake_gun_fire))
	{
		level.fake_gun_fire[0] = true;
		num = 0;
	}
	else
	{
		level.fake_gun_fire[level.fake_gun_fire.size] = true;
		num = level.fake_gun_fire.size;
	}

	level thread fake_bullet_tracers_loop(location, num, wait_till);

	// If duration is defined, countdown the duration.
	if(isdefined(duration))
	{
		for(i=duration;i>0;i--)
		{
			wait 1;
		}
		level.fake_gun_fire[num] = false;
	}
}

fake_bullet_tracers_loop(location, num, wait_till, snow_effect)
{
	dummie_scale = getcvarint("scr_gmi_fast");

	if (dummie_scale == 2) return;

	if(isdefined(wait_till))
	{
		level endon(wait_till);
	}

	if(!isdefined(snow_effect))
	{
		snow_effect = true;
	}

	// Get the start origin to fire from, and end origin. Then fire the fake bullet tracer and effect.
	while(level.fake_gun_fire[num])
	{
		if(!isdefined(location))
		{
			println("^1***********COULD NOT PLAY FAKE_BULLET_TRACERS, LOCATION NOT DEFINED!!!!***********");
			return;
		}

		if(location == "opening")
		{
			start_org = ((randomint(500) - 904), (randomint(400) - 5920), (randomint(20) + 170));
			end_org = ((randomint(1500) - 3500), -9000, (randomint(100) + 124));
		}
		else if(location == "easthill")
		{
			start_org = ((randomint(500) - 904), (randomint(400) - 5920), (randomint(20) + 170));
			end_org = ((randomint(1500) - 3500), -9000, (randomint(100) + 124));
		}
		else if(location == "haystack")
		{
			start_org = ((randomint(500) - 904), (randomint(400) - 5920), (randomint(20) + 170));
			end_org = ((randomint(1500) - 3500), -9000, (randomint(100) + 124));
		}
		else if(location == "westhill")
		{
			start_org = ((randomint(500) - 904), (randomint(400) - 5920), (randomint(20) + 170));
			end_org = ((randomint(1500) - 3500), -9000, (randomint(100) + 124));
		}
		else if(location == "lasthill")
		{
			start_org = ((randomint(500) - 904), (randomint(400) - 5920), (randomint(20) + 170));
			end_org = ((randomint(1500) - 3500), -9000, (randomint(100) + 124));
		}

		random_delay = 1 + randomint(15);
		for(i=random_delay;i>0;i--)
		{
			end_org_mod = (end_org + (randomfloat(100), randomfloat(100), randomfloat(100)));

			if(snow_effect)
			{
				trace = bulletTrace(start_org, end_org_mod, false, undefined);
	
				if (trace["fraction"] < 1.0)
				{
	//				line (start, trace["position"], (1,0.2,0.3), 0.5);
					playfx ( level._effect["fake_snow_impact"], trace["position"] );
				}
			}

			bulletTracer(start_org, end_org_mod);
			wait 0.05;
		}
	}
}