main()
{
	// Event1_Dummy Path
	precacheModel("xmodel/trenches_dummies_scatterA");

	// Event1_Dummy2 Path
	precacheModel("xmodel/trenches_dummies_house2trainA");

	// Event2_Dummies
	precachemodel("xmodel/trenches_dummies_wood2houseA");
	// Event2_Dummies_2
	precachemodel("xmodel/trenches_dummies_backhouseA");

	// Event4_Wounded_dummies
	precachemodel("xmodel/trenches_dummies_woundedB");

	// Event4_Wounded_dummiesA
	precachemodel("xmodel/trenches_dummies_woundedA");

	// Event3 Village Dummies
	precacheModel("xmodel/trenches_dummies_villageA");

	// Event3 Prisoner Dummies
	precacheModel("xmodel/trenches_dummies_prisonerA");

	// DummyA Precache
	precacheModel("xmodel/kursk_dummies_path_A");

	// DummyB Precache
	precacheModel("xmodel/kursk_dummies_path_B");

	// Truck Dummy Precache
	precacheModel("xmodel/trenches_dummies_truckA");
	// Truck Dummy Precache
	precacheModel("xmodel/trenches_dummies_truckB");
	// Truck Dummy Precache
	precacheModel("xmodel/trenches_dummies_truck_climb");

	// Roadcross Dummies.
	precachemodel("xmodel/trenches_dummies_roadcrossA");
	// Village treeline dummies.
	precacheModel("xmodel/trenches_dummies_villagetreeline");

	// For the AI getting out of the train
//	precacheModel("xmodel/trenches_opening_dummie_guy01");
//	precacheModel("xmodel/trenches_opening_dummie_guy02");
//	precacheModel("xmodel/trenches_opening_dummie_guy03");
//	precacheModel("xmodel/trenches_opening_dummie_guy04");
//	precacheModel("xmodel/trenches_opening_dummie_guy05");
//	precacheModel("xmodel/trenches_opening_dummie_guy06");
//	precacheModel("xmodel/trenches_opening_dummie_guy07");
//	precacheModel("xmodel/trenches_opening_dummie_guy08");
//	precacheModel("xmodel/trenches_opening_dummie_guy09");
//	precacheModel("xmodel/trenches_opening_dummie_guy10");
//	precacheModel("xmodel/trenches_opening_dummie_guy11");
//	precacheModel("xmodel/trenches_opening_dummie_guy12");
//	precacheModel("xmodel/trenches_opening_dummie_guy13");
//	precacheModel("xmodel/trenches_opening_dummie_guy14");
//	precacheModel("xmodel/trenches_opening_dummie_guy15");
//	precacheModel("xmodel/trenches_opening_dummie_guy16");

	precacheModel("xmodel/trenches_opening_dummies");

	// Dummy characters
	character\fallschirmjager_soldier::precache();
	character\fallschirmjager_soldier_MP40b::precache();
	character\fallschirmjager_soldier_K98a::precache();
	character\RussianArmy ::precache();      
	character\RussianArmy2 ::precache();     
	character\RussianArmyMosin1 ::precache();

	precacheModel("xmodel/weapon_kAr98");
	precachemodel("xmodel/weapon_MP40");
	precachemodel("xmodel/weapon_mosinnagant");
	precachemodel("xmodel/weapon_ppsh");
}

#using_animtree("trenches_dummies_path");

// Spawns in the Animated Tag Model, sets up angle offset and optional loop.

// Syntax:
// dummies_setup(<vec>, <modelname>, <int>, <angles>, <int>, <%anim>, <bool>, <animname/string>, <array>, <bool>);
dummies_setup(pos, model, total_tags, angle_offset, loop_time, loop_num, path_anim, weap, anim_name, anim_wait, random_move_forward, wait_till)
{
	if(!isdefined(level.dummy_count))
	{
		level.dummy_count = 0;
	}

	if(isdefined(loop_time) && loop_time != "random")
	{
		if(getcvarint("scr_gmi_fast") == 2)
		{
			loop_time = loop_time * 2;
		}
	}
	
	loops = 0;
	while(1)
	{	
//println("^5DUMMY PATH SPAWNED!");
		dummies_path = spawn ("script_model",(pos));
		dummies_path setmodel (model);
		dummies_path.num = 0;
		dummies_path.total_tags = total_tags;
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

		if(anim_name == "event3_prisoner_dummies")
		{
			dummies_path thread special_prisoner_path_think(path_anim, weap, anim_name, anim_wait, random_move_forward, wait_till);
		}
		else if(anim_name == "event1_truck_dummies")
		{
			dummies_path thread special_truck_path_think(path_anim, weap, anim_name, anim_wait, random_move_forward, wait_till);
		}
		else
		{
			dummies_path thread dummies_path_think(path_anim, weap, anim_name, anim_wait, random_move_forward, wait_till);
		}

		if(isdefined(loop_time))
		{
			loops++;

			if(loop_time == "random")
			{
				if(getcvarint("scr_gmi_fast") == 2)
				{
					wait (3 + randomfloat(3));
				}
				else
				{
					wait (1 + randomfloat(3));
				}
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
}

dummies_path_think(path_anim, weap, anim_name, anim_wait, random_move_forward, wait_till)
{
	self setFlaggedAnimKnobRestart("animdone", path_anim);

	dummie_scale = getcvarint("scr_gmi_fast");
	count = self.total_tags;

	if(dummie_scale == 1)
	{
		count = count * 0.5;
	}
	else if(dummie_scale == 2)
	{
		if(count < 3)
		{
			count = count * 0.5;
		}
		else
		{
			count = 2 + (int)(count * 0.25);
		}
	}

//	println("Dummy Count = ",count);

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

		// Special case for guys running in village.
		if(anim_name == "event3_village_dummies")
		{
//			dummy thread do_print3d(dummy, dummy.tag);
//			num = (int)((count*0.5) + 1);
			if(dummy.tag == "tag_guy16")
			{
				dummy playloopsound("troops_running");
			}
		}		

		if(weap)
		{
//			if(!(dummy.animname == "event3_village_dummies" && dummy.num == 31)) // Special Case, for the last guy in village-dummies.
//			{
				random_weapon = randomint(2);
				if(random_weapon == 0)
				{
					dummy attach("xmodel/weapon_ppsh", "tag_weapon_right");
				}
				else
				{
					dummy attach("xmodel/weapon_mosinnagant", "tag_weapon_right");				
				}
//			}
		}

		dummy [[random(level.scr_character[anim_name])]]();

		dummy thread dummy_think_death(self);
		dummy thread dummy_think(self, anim_wait, random_move_forward, wait_till);
	}
}

special_prisoner_path_think(path_anim, weap, anim_name, anim_wait, random_move_forward, wait_till)
{
	self setFlaggedAnimKnobRestart("animdone", path_anim);

	for (i=0;i<self.total_tags;i++)
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

		if(dummy.num == 2 || dummy.num == 6)
		{
			dummy [[random(level.scr_character[anim_name])]]();
			random_weapon = randomint(2);
			if(random_weapon == 0)
			{
				dummy attach("xmodel/weapon_ppsh", "tag_weapon_right");
			}
			else
			{
				dummy attach("xmodel/weapon_mosinnagant", "tag_weapon_right");				
			}
		}
		else
		{
			dummy [[random(level.scr_character["drone"])]]();
		}

		dummy thread dummy_think_death(self);
		dummy thread dummy_think(self, anim_wait, random_move_forward, wait_till);
	}
}

special_truck_path_think(path_anim, weap, anim_name, anim_wait, random_move_forward, wait_till)
{
	if(self.model == "xmodel/trenches_dummies_truckA")
	{
		truck = getent("truck3","targetname");
		dummies_path2 = spawn ("script_model",(truck.origin));
		dummies_path2 setmodel ("xmodel/trenches_dummies_truck_climb");
		dummies_path2.angles = truck.angles;
	}
	else
	{
		truck = getent("truck4","targetname");
		dummies_path2 = spawn ("script_model",(truck.origin));
		dummies_path2 setmodel ("xmodel/trenches_dummies_truck_climb");
		dummies_path2.angles = truck.angles;
	}

//	self setFlaggedAnimKnobRestart("animdone", path_anim);
	self animscripted("single anim", self.origin, self.angles, path_anim);

	for (i=1;i<self.total_tags;i++)
	{
		if (self.model == "xmodel/trenches_dummies_truckA")
		{
			tag_num = ("tag_guy0" + i);
		}
		else
		{
			tag_num = ("tag_guy1" + i);
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

		random_weapon = randomint(2);
		if(random_weapon == 0)
		{
			dummy attach("xmodel/weapon_ppsh", "tag_weapon_right");
		}
		else
		{
		dummy attach("xmodel/weapon_mosinnagant", "tag_weapon_right");				
		}
		
		dummy [[random(level.scr_character[anim_name])]]();

		dummy thread special_truck_dummy_death(self);
		dummy thread special_truck_dummy_think(self, dummies_path2, anim_wait, random_move_forward, wait_till);
	}
}

#using_animtree("trenches_dummies");
dummy_think(dummies_path, anim_wait, random_move_forward, wait_till)
{
	if(self.animname == "event4_wounded" || self.animname == "event3_prisoner_dummies")
	{
		self.move_anim = level.scr_anim[self.animname]["move_forward"][self.num];
	}
	else
	{
		self.move_index = randomint (level.scr_anim[self.animname]["move_forward"].size);
		self.move_anim = level.scr_anim[self.animname]["move_forward"][self.move_index];
	}

	self UseAnimTree(#animtree);
	self.origin = dummies_path gettagorigin (self.tag);
	self linkto (dummies_path, self.tag, (0,0,0), (0,0,0));
//println("^5Position ",self.origin);

	self thread dummy_animloop(random_move_forward);

	if(isdefined(wait_till))
	{
		level waittill(wait_till);
	}
	else if(isdefined(anim_wait))
	{
		if(anim_wait.size == 1)
		{
			wait (anim_wait[0]);
		}
		else
		{
//println("^5WAITING : ",anim_wait[self.num]);
			wait (anim_wait[self.num]);
		}
	}
	else
	{
		if (self.num < 10)
		{
			wait 5;
		}
		else if (self.num >= 10 )
		{
			wait 10;
		}
	}

	self unlink();
//	println("^5UNLINK!!!!");

	if(isdefined(level.scr_anim[self.animname]["death"]))
	{
		deathanim = random (level.scr_anim[self.animname]["death"]);
		self animscripted("death anim", self.origin, self.angles, deathanim, "deathplant");
		wait 4;
		self movez (-100, 3, 2, 1);
		wait 3;
	}

	self.died = true;
	dummies_path.num--;
	level.dummy_count--;
	self delete();
}

dummy_animloop(random_move_forward, movement)
{
	self endon("death");
	self endon("stop_anim");

//	println("^1(tag_name) = " + self.tag + " " + "self.poopy = ",self.poopy);

	while (self.died == false)
	{
		if(!isdefined(num))
		{
			num = 0;
		}

//		self animscripted("single anim", self.origin, self.angles, self.move_anim);
		self setFlaggedAnimKnobrestart("animdone", self.move_anim, 1, 0.1, 1);
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
		else if(movement == "force_idle")
		{
			if(num == 3)
			{
				self.move_index = randomint (level.scr_anim[self.animname]["idle"].size);
				self.move_anim = level.scr_anim[self.animname]["idle"][self.move_index];
				num = 0;
			}
		}
		else if(movement == "idle")
		{
			if(random_move_forward)
			{
				if(isdefined(self.climb_tag))
				{
					if(self.climb_tag == "tag_climb01")
					{
						self.move_anim = level.scr_anim[self.animname]["sicily1_idle1"];
					}
					else if(self.climb_tag == "tag_climb04")
					{
						self.move_anim = level.scr_anim[self.animname]["sicily1_idle4"];
					}
					else if(self.climb_tag == "tag_climb05")
					{
						self.move_anim = level.scr_anim[self.animname]["sicily1_idle5"];
					}
					else if(self.climb_tag == "tag_climb06")
					{
						self.move_anim = level.scr_anim[self.animname]["sicily1_idle6"];
					}
					else
					{
						self.move_index = randomint (level.scr_anim[self.animname]["idle"].size);
						self.move_anim = level.scr_anim[self.animname]["idle"][self.move_index];
						num = 0;
					}
				}
				else if(num == 3)
				{
					self.move_index = randomint (level.scr_anim[self.animname]["idle"].size);
					self.move_anim = level.scr_anim[self.animname]["idle"][self.move_index];
					num = 0;
				}
			}			
		}
		else if(movement == "no_crouch")
		{
			if(random_move_forward)
			{
				if(num == 5)
				{
					self.move_index = randomint (level.scr_anim[self.animname]["move_forward"].size - 1);
					self.move_anim = level.scr_anim[self.animname]["move_forward"][self.move_index];
					num = 0;
				}
			}		
		}
	}
}

#using_animtree("trenches_truck_dummies");
special_truck_dummy_think(dummies_path, dummies_path2, anim_wait, random_move_forward, wait_till)
{
//	self thread dummy_3d();

	self.move_index = randomint (level.scr_anim[self.animname]["move_forward"].size - 1);
	self.move_anim = level.scr_anim[self.animname]["move_forward"][self.move_index];

	self UseAnimTree(#animtree);
	self.origin = dummies_path gettagorigin (self.tag);
	self linkto (dummies_path, self.tag, (0,0,0), (0,0,0));

	if(dummies_path.model == "xmodel/trenches_dummies_truckA")
	{
		truck = getent("truck3","targetname");
	}
	else
	{
		truck = getent("truck4","targetname");
	}

	self thread dummy_animloop(random_move_forward, "no_crouch");

	if(self.tag == "tag_guy01")
	{
		self.tag2 = "tag_origin01";
		self.truck_tag = "tag_guy01";
		self.climb_tag = "tag_climb01";
	}
	else if(self.tag == "tag_guy02")
	{
		self.tag2 = "tag_origin02";
		self.truck_tag = "tag_guy02";
		self.climb_tag = "tag_climb02";
	}
	else if(self.tag == "tag_guy03")
	{
		self.tag2 = "tag_origin03";
		self.truck_tag = "tag_guy03";
		self.climb_tag = "tag_climb03";
	}
	else if(self.tag == "tag_guy04")
	{
		self.tag2 = "tag_origin04";
		self.truck_tag = "tag_guy04";
		self.climb_tag = "tag_climb04";
	}
	else if(self.tag == "tag_guy05")
	{
		self.tag2 = "tag_origin05";
		self.truck_tag = "tag_guy05";
		self.climb_tag = "tag_climb05";
	}
	else if(self.tag == "tag_guy06")
	{
		self.tag2 = "tag_origin06";
		self.truck_tag = "tag_guy06";
		self.climb_tag = "tag_climb06";
	}
	else if(self.tag == "tag_guy07")
	{
		self.tag2 = "tag_origin07";
		self.truck_tag = "tag_guy07";
		self.climb_tag = "tag_climb07";
	}
	else if(self.tag == "tag_guy08")
	{
		self.tag2 = "tag_origin08";
		self.truck_tag = "tag_guy08";
		self.climb_tag = "tag_climb08";
	}
	else if(self.tag == "tag_guy11")
	{
		self.tag2 = "tag_origin01";
		self.truck_tag = "tag_guy01";
		self.climb_tag = "tag_climb01";
	}
	else if(self.tag == "tag_guy12")
	{
		self.tag2 = "tag_origin02";
		self.truck_tag = "tag_guy02";
		self.climb_tag = "tag_climb02";
	}
	else if(self.tag == "tag_guy13")
	{
		self.tag2 = "tag_origin03";
		self.truck_tag = "tag_guy03";
		self.climb_tag = "tag_climb03";
	}
	else if(self.tag == "tag_guy14")
	{
		self.tag2 = "tag_origin04";
		self.truck_tag = "tag_guy04";
		self.climb_tag = "tag_climb04";
	}
	else if(self.tag == "tag_guy15")
	{
		self.tag2 = "tag_origin05";
		self.truck_tag = "tag_guy05";
		self.climb_tag = "tag_climb05";
	}
	else if(self.tag == "tag_guy16")
	{
		self.tag2 = "tag_origin06";
		self.truck_tag = "tag_guy06";
		self.climb_tag = "tag_climb06";
	}
	else if(self.tag == "tag_guy17")
	{
		self.tag2 = "tag_origin07";
		self.truck_tag = "tag_guy07";
		self.climb_tag = "tag_climb07";
	}
	else if(self.tag == "tag_guy18")
	{
		self.tag2 = "tag_origin08";
		self.truck_tag = "tag_guy08";
		self.climb_tag = "tag_climb08";
	}

	self thread dummy_unlink_think(dummies_path, "stand_after_anim");

	self notify("stop_anim");
	dummies_path waittillmatch("single anim","end");

	self unlink(); // To make sure every guy is detached

	self.move_anim = level.scr_anim[self.animname]["climb"][(self.num - 1)];

	tag_angles = truck gettagangles(self.climb_tag);
	tag_origin = truck gettagorigin(self.climb_tag);

	if (self.climb_tag == "tag_climb07")
	{
		tag_origin = tag_origin + (0,15,0);
	}

	self.angles = tag_angles;
	self.origin = tag_origin;

	self animscripted( "single anim", tag_origin, tag_angles, self.move_anim);
	self waittillmatch("single anim", "end");

	self notify("stop_anim");
	self unlink();
	self linkto(truck);
	
	if(self.climb_tag == "tag_climb01")
	{
		self.move_anim = level.scr_anim[self.animname]["sicily1_idle1"];
	}
	else if(self.climb_tag == "tag_climb04")
	{
		self.move_anim = level.scr_anim[self.animname]["sicily1_idle4"];
	}
	else if(self.climb_tag == "tag_climb05")
	{
		self.move_anim = level.scr_anim[self.animname]["sicily1_idle5"];
	}
	else if(self.climb_tag == "tag_climb06")
	{
		self.move_anim = level.scr_anim[self.animname]["sicily1_idle6"];
	}
	else
	{
		self.move_index = randomint (level.scr_anim[self.animname]["idle"].size);
		self.move_anim = level.scr_anim[self.animname]["idle"][self.move_index];
	}

	wait 0.25;
	self thread dummy_animloop(true, "idle");

	level waittill(wait_till);

	if(isdefined(level.scr_anim[self.animname]["death"]))
	{
		deathanim = random (level.scr_anim[self.animname]["death"]);
		self animscripted("death anim", self.origin, self.angles, deathanim, "deathplant");
		wait 4;
		self movez (-100, 3, 2, 1);
		wait 3;
	}
}

dummy_3d()
{
	self endon("death");
	while(1)
	{
		print3d((self.origin + (0,0,100)),self.tag,(1,1,1));
		wait 0.06;
	}
}

dummy_unlink_think(dummies_path, msg)
{
	self endon("death");

	while(1)
	{
//println("^2Self.tag = ",self.tag);
		dummies_path waittill("single anim", notetrack);
	
		if(isdefined(notetrack))
		{
//			println("^3NOTETRACK: ",notetrack);
			if(notetrack == (self.tag + "_unlink"))
			{
				self notify("stop_anim");
				self unlink();
	
				if(isdefined(msg) && msg == "stand_after_anim")
				{
					self.move_index = randomint (level.scr_anim[self.animname]["idle"].size);
					self.move_anim = level.scr_anim[self.animname]["idle"][self.move_index];
					self thread dummy_animloop(true, "force_idle");
				}
				break;
			}
		}
	}
}

#using_animtree("trenches_dummies");
dummy_think_death(dummies_path)
{
	self endon("death");

	self waittill("explosion death");
	if(self.died)
	{
		return;
	}
//	println("^5BOOOOOOOOOOOOOOM! Dead");
	self unlink();
//	println("^5UNLINK!!!!");
	self notify("stop_anim");
	self.animname = "event1_dummies";

	deathanim = random (level.scr_anim[self.animname]["death"]);
	self animscripted("death anim", self.origin, self.angles, deathanim, "deathplant");

	wait 4;
	self movez (-100, 3, 2, 1);
	wait 3 + randomfloat(5);

	self.died = true;
	if(isdefined(dummies_path))
	{                          
		dummies_path.num--;
	}                          
	level.dummy_count--;       
	self delete();             
}                                  

#using_animtree("trenches_truck_dummies");
special_truck_dummy_death(dummies_path)
{
	if(self.died)
	{
		return;
	}
	self endon("death");

	self waittill("explosion death");
//	println("^5BOOOOOOOOOOOOOOM! Dead");
	self unlink();
//	println("^5UNLINK!!!!");
	self notify("stop_anim");

	self.died = true;
	deathanim = random (level.scr_anim[self.animname]["death"]);
	delay = getanimlength(deathanim);

//	self thread death_move_down(delay);
	self animscripted("death anim", self.origin, self.angles, deathanim );

	wait 4;
	self movez (-100, 3, 2, 1);
	wait 3 + randomfloat(5);

	if(isdefined(dummies_path))
	{
		dummies_path.num--;
	}
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


extra_dummy_think_death(dummies_path)
{
	self endon("death");
	self UseAnimTree(level.scr_animtree[self.animname]);
	self.targetname = "dummy";

	self waittill("explosion death");
	if(isdefined(self.died) && self.died)
	{
		return;
	}
//	println("^5BOOOOOOOOOOOOOOM! Dead");
	self unlink();
//	println("^5UNLINK!!!!");
	self notify("stop_anim");

	deathanim = random (level.scr_anim[self.animname]["death"]);
	self animscripted("death anim", self.origin, self.angles, deathanim, "deathplant");

	wait 4;
	self movez (-100, 3, 2, 1);
	wait 3;

	self.died = true;
	if(isdefined(dummies_path))
	{
		dummies_path.num--;
	}
//	level.dummy_count--;
	self delete();
}

#using_animtree("trenches_dummies_path");
animate_climbing()
{
	self UseAnimTree(#animtree);
	self setFlaggedAnimKnobRestart("animdone", %trenches_dummies_truck_climb);
}


//Random Arrays
random (array)
{
	return array [randomint (array.size)];
}

do_print3d(ent, msg)
{
	ent endon("death");
	while(1)
	{
		print3d(ent.origin,msg,(1,0,0),1,3);
		wait 0.06;
	}
}