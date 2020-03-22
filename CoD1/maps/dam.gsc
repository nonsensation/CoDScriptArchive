#using_animtree ("generic_human");
main()
{
 	setExpFog(0.000005, 0.19, 0.15 , 0.19, 0);

	character\Waters::precache();
	character\Price::precache();
	precacheItem("panzerfaust");
	precachemodel("xmodel/prop_panzerfaust");
	precachemodel("xmodel/prop_panzerfaust_lid");
	precachemodel("xmodel/prop_panzerfaust_emptybox");

	maps\dam_fx::main();
	thread spray_fx();
	maps\_load::main();
	maps\_treadfx::main();
	maps\_bombs::init();
//	maps\dam_camera::main();

	level.ambient_track ["interior"] = "ambient_dam_int";
	level.ambient_track ["exterior"] = "ambient_dam_ext";
	level.ambient_track ["generator"] = "ambient_dam_generator";
	thread maps\_utility::set_ambient("exterior");

	level.return_started = "false";

	//Objective 1: Disable the ant-aircraft guns protecting the dam. (# remaining)
	//Objective 2: Plant the radio homing beacon for the bombers.
	//Objective 3: Plant explosives on the generators. (# remaining)
	//Objective 4: Meet up with Captain Price and escape.

	thread top_AAgun_objective();
	thread AAgun_objective();
	thread generator_objective();
	thread escape_objective();

	elevator1 = getent ("elevator1", "targetname");
	elevator2 = getent ("elevator2", "targetname");
	elevator1 thread elevator_setup(4, "elevator_med", "top");
	elevator2 thread elevator_setup(8.25, "elevator_long", "middle");
	elevator2 thread elevator_attack();

	thread return_triggers();

	precachemodel("xmodel/searchlight_large_off");
	maps\dam_anim::searchlights();
	models = getentarray ("script_model", "classname");
	for (i=0;i<models.size;i++)
	{
		if(models[i].model == "xmodel/searchlight_large_on")
			models[i] thread spotlights();
	}

	level.currently_random_alert = false;
	thread alert_sound();

	outside_guys = getentarray ("outside_guys", "targetname");
	for (i=0;i<outside_guys.size;i++)
	{
		outside_guys[i] thread outside_guys();
	}


	truck_back_trigger = getent ("truck_back_trigger", "targetname");
	truck_back_trigger maps\_utility::triggerOff();

	thread music();
}

music()
{
	wait .05;
	musicplay("redsquare_tense");

	start_alarms = getent ("start_alarms", "targetname");
	start_alarms waittill ("trigger");

	musicplay("dam_a");

	tunnel_music = getent ("tunnel_music", "targetname");
	tunnel_music waittill ("trigger");

	musicplay("dam_b");

	wait 90;

	musicplay("redsquare_tense");

	truck_back_trigger = getent ("truck_back_trigger", "targetname");
	truck_back_trigger waittill("trigger");

	musicplay("airfield_main");
}



top_AAgun_objective()
{
	level.objectives_done[1] = 0;
	//Objective 1: Disable the ant-aircraft guns protecting the dam. (# remaining)
	thread maps\_bombs::main(1, &"DAM_OBJ_AAGUNS_TOP", "top_AAgun_bombs");
	objective_current(1);

	door_dam_top = getent ("door_dam_top", "targetname");
	door_dam_top rotateyaw(-90, 0.4,0,0);

	wait .4;
	door_dam_top disconnectpaths();

	level waittill ("objective_complete1");

	spawners = getentarray ("obj1_guy", "targetname" );
	for (i = 0; i<spawners.size ; i++)
	{
		temp = spawners[i] dospawn();
	}

	door_dam_top rotateyaw(90, 0.4,0,0);

	level.objectives_done[1] = 1;
	update_objectives();

	wait .4;
	door_dam_top disconnectpaths();
}

generator_objective()
{
	level.objectives_done[2] = 0;
	//Objective 2: Plant explosives on the generators. (# remaining)
	thread maps\_bombs::main(2, &"DAM_OBJ_GENERATORS", "generator_bombs");

	level waittill ("objective_complete2");

	level.objectives_done[2] = 1;
	update_objectives();
}

AAgun_objective()
{
	level.objectives_done[3] = 0;
	//Objective 3: Disable the ant-aircraft guns protecting the dam. (# remaining)
	thread maps\_bombs::main(3, &"DAM_OBJ_AAGUNS_BOTTOM", "AAgun_bombs");

	level waittill ("objective_complete3");

	level.objectives_done[3] = 1;
	update_objectives();
}



escape_objective()
{
	level.objectives_done[4] = 0;
	truck = getent ("truck", "targetname");
	truck_back_trigger = getent ("truck_back_trigger", "targetname");

	//Objective 4: Meet up with Captain Price and escape.
	//objective_add(4, "active", "Meet up with Captain Price on the top south end of the dam and escape", (truck_back_trigger.origin));
	objective_add(4, "active", &"DAM_OBJ_ESCAPE", (truck_back_trigger.origin));


	level waittill ("objective_complete2");

	if (level.objectives_done[3] != 1)
		level waittill ("objective_complete3");


	truck thread truck();
	level_end = getent ("level_end", "targetname");

	level_end waittill ("trigger");

	objective_state(4, "done");
	level.objectives_done[4] = 1;
	update_objectives();
//	changelevel("truckride", true);

	missionSuccess("truckride", false);
}

update_objectives()
{
	for (i=1;i<(level.objectives_done.size+1);i++)
	{
		if (level.objectives_done[i] != 1)
		{
			level.objectives_current = i;
			objective_current(i);
			println ("current objective: ", i);
			return;
		}
	}
}

/////////////////////////////

spotlights()
{
	self.animname = "searchlights";
	self UseAnimTree(level.scr_animtree[self.animname]);
	//self playloopsound("searchlight_moving");

	wait (randomfloat (3) );

	while (1)
	{
		d = distance (level.player getorigin(), self.origin);
		if (d < 1500)
		{
			//self stoploopsound("searchlight_moving");

			wait 1;

			//self playsound("searchlight_off");
			self setmodel ("xmodel/searchlight_large_off");
			break;
		}

		if (randomint (100) > 50)
			self animscripted ("scriptedanimdone", self.origin, self.angles, level.scr_anim[self.animname]["searchlight_search1"]);
		else
			self animscripted ("scriptedanimdone", self.origin, self.angles, level.scr_anim[self.animname]["searchlight_search2"]);
		self waittill ("scriptedanimdone");
	}
}

spray_fx()
{
	if (getcvar("scr_dam_spray") != 1)
		return;
		
	level.exterior = "false";
	interior_triggers = getentarray ("interior", "targetname");
	exterior_triggers = getentarray ("exterior", "targetname");
	for (i=0;i<interior_triggers.size;i++)
		interior_triggers[i] thread interiors();
	for (i=0;i<exterior_triggers.size;i++)
		exterior_triggers[i] thread exteriors();

	thread froth_fx();

	while (1)
	{
		if (level.exterior == "true")
		{
			playfx_thread("mistwall", (-26287.00, 4274.00, -1770.00), 0.30, undefined);
			//playfx_thread("mistwall", (-25279.00, 4453.00, -1770.00), 0.30, undefined);
			playfx_thread("mistwall", (-24279.00, 4633.00, -1770.00), 0.30, undefined);
			//playfx_thread("mistwall", (-23279.00, 4750.00, -1770.00), 0.30, undefined);
			playfx_thread("mistwall", (-22279.00, 4633.00, -1770.00), 0.30, undefined);
			//playfx_thread("mistwall", (-21800.00, 4422.00, -1770.00), 0.30, undefined);
		}
		wait 0.3;
	}
}

froth_fx()
{
	while (1)
	{
		if (level.exterior == "true")
		{
			playfx_thread("froth", (-24420, 5056, -1675), 0.5);
		}
		wait .5;
	}
}


playfx_thread(fxId, fxPos, ignore, ignore2)
{
	playfx ( level._effect[fxId], fxPos);
}

interiors()
{
	while (1)
	{
		self waittill ("trigger");
		level.exterior = "false";
		println ("interior");
	}
}

exteriors()
{
	while (1)
	{
		self waittill ("trigger");
		level.exterior = "true";
		println ("exterior");
	}
}

///////////////////////////////////////////
elevator_setup(move_time, move_sound, currentfloor)
{
	self.currentfloor = currentfloor;
//	println (self.target, "   ", self.script_noteworthy, "    ", self.classname);

	self.internal_handle = getent (self.script_noteworthy, "targetname");
	self.internal_handle linkto (self);
	self.internal_handle init_handle();

	call_triggers = getentarray (self.target, "targetname");
	for (i=0;i<call_triggers.size;i++)
		self thread call_triggers(call_triggers[i], move_time, move_sound);


	internal_triggers = getentarray (self.script_triggername, "targetname");
	for (i=0;i<internal_triggers.size;i++)
		self thread internal_triggers(internal_triggers[i], move_time, move_sound);

}

init_handle()
{
	maps\dam_anim::switch_objective();
	self.animname = "switch_objective";
	self UseAnimTree(level.scr_animtree[self.animname]);
	self animscripted ("scriptedanimdone", self.origin, self.angles, level.scr_anim[self.animname]["switch_objective_up"]);
}

call_triggers(trigger, move_time, move_sound)
{
	trigger setHintString (&"SCRIPT_HINTSTR_USEELEVATOR");
	stuff = getentarray (trigger.target, "targetname");
	for (i=0;i<stuff.size;i++)
	{
		if (stuff[i].classname == "script_model")
			handle = stuff[i];
		else
			goal = stuff[i];
	}

	handle init_handle();
	if (!isdefined (trigger.script_noteworthy))
		goalfloor = "middle";
	else
		goalfloor = trigger.script_noteworthy;
	thread trigger_think(goalfloor, trigger);

	while (1)
	{
		trigger waittill ("trigger");

		handle animscripted ("scriptedanimdone", handle.origin, handle.angles, level.scr_anim[handle.animname]["switch_objective_down"]);
		handle playsound ("switch", "sounddone");
		handle waittill ("scriptedanimdone");
		handle animscripted ("scriptedanimdone", handle.origin, handle.angles, level.scr_anim[handle.animname]["switch_objective_up"]);

		self notify ("moving");
		self moveto (goal.origin, move_time, 2, 2);
		self playsound (move_sound);

		self waittill ("movedone");
		self disconnectpaths();
		self notify ("floor_change");
		self.currentfloor = goalfloor;
	}
}

trigger_think(goalfloor, trigger)
{
	if (!isdefined (goalfloor) )
		goalfloor = "middle";
	while(1)
	{
		if (goalfloor != self.currentfloor)
			trigger thread maps\_utility::triggerOn();
		else
			trigger thread maps\_utility::triggerOff();

		self waittill ("floor_change");
	}
}

trigger_off_while_moving(trigger)
{
	while(1)
	{
		self waittill ("moving");
		trigger thread maps\_utility::triggerOff();
		self waittill ("floor_change");
		trigger thread maps\_utility::triggerOn();
	}
}

internal_triggers(trigger, move_time, move_sound)
{
	trigger setHintString (&"SCRIPT_HINTSTR_USEELEVATOR");
	temp = getentarray (self.script_bottomfloor, "targetname");
	for (i=0;i<temp.size;i++)
	{
		//println (temp[i].classname);
		if (temp[i].classname == "script_origin")
		{
			//println ("z:        found");
			bottomfloor = temp[i];
			break;
		}
	}

	temp = getentarray (self.script_topfloor, "targetname");
	for (i=0;i<temp.size;i++)
	{
		//println (temp[i].classname);
		if (temp[i].classname == "script_origin")
		{
			//println ("z:        found");
			topfloor = temp[i];
			break;
		}
	}

	if (!isdefined (bottomfloor))
		blah = getent ("Time to Stop the Script!", "targetname");
	if (!isdefined (topfloor))
		blah = getent ("Time to Stop the Script!", "targetname");

	thread trigger_off_while_moving(trigger);

	while (1)
	{
		trigger waittill ("trigger");

		if (self.currentfloor != "bottom")
		{
			goalfloor = "bottom";
			goal = bottomfloor;
		}
		else
		{
			goalfloor = "top";
			goal = topfloor;
		}


		self.internal_handle animscripted ("scriptedanimdone", self.internal_handle.origin, self.internal_handle.angles, level.scr_anim[self.internal_handle.animname]["switch_objective_down"]);
		self.internal_handle playsound ("switch", "sounddone");
		self.internal_handle waittill ("scriptedanimdone");
		self.internal_handle animscripted ("scriptedanimdone", self.internal_handle.origin, self.internal_handle.angles, level.scr_anim[self.internal_handle.animname]["switch_objective_up"]);

		self notify ("moving");
		self moveto (goal.origin, move_time, 2, 2);
		self playsound (move_sound);

		self waittill ("movedone");
		self disconnectpaths();
		self notify ("floor_change");
		self.currentfloor = goalfloor;
	}
}

//////////////////////////
elevator_attack()
{
	level.hit_elevator_attack_cancel = false;
	cancel_trigger = getent ("elevator_attack_cancel", "targetname");
	cancel_trigger thread elevator_attack_cancel();
	trigger = getent ("elevator_attack", "targetname");

	trigger waittill ("trigger");

	if ( (level.return_started != "true") && (level.hit_elevator_attack_cancel == false) )
	{
		println ("elevator attacking");
		spawners = getentarray ("elevator_spawners", "targetname" );
		for (i = 0; i<spawners.size ; i++)
		{
			temp = spawners[i] dospawn();
		}

		self notify ("moving");
		self movez ( 288, 2, .5, .5);
		self playsound ("elevator_short");

		self waittill ("movedone");
		self disconnectpaths();
		self notify ("floor_change");
	}
	else
		println ("elevator not attacking, return started or hit cancel first");

}

elevator_attack_cancel()
{
	self waittill ("trigger");

	level.hit_elevator_attack_cancel = true;
}


///////////////////////////////
truck()
{
	truck_back_trigger = getent ("truck_back_trigger", "targetname");
	truck_back_trigger maps\_utility::triggerOn();
	truck_back_trigger setHintString (&"DAM_GET_IN_TRUCK");
	//bomb_table_trigger setHintString (&"SCRIPT_HINTSTR_PICKUPEXPLOSIVES");

	path = getVehicleNode(self.target,"targetname");

	self attachpath (path);
	self.health = 10000;
	self thread regentruckhealth();
	self thread maps\_truckridewaters::truck_panzers_andstuff();

	self thread animatetruckstuffintoplace();

	thread waters();
	thread price();

	truck_horn = getent ("truck_horn", "targetname");
	truck_horn waittill ("trigger");
	self playsound ("truck_horn");
	wait 2;

	//level.price thread maps\_anim::anim_single (level.moodyarray, "talk3");
	level.price animscripts\face::SaySpecificDialogue(undefined, "dam_price_goodman", "pain", "dialog_done");
	//"..get on the truck..."
	level.price waittill ("dialog_done");

//	truck_back_trigger waittill("trigger");
//	wait 1.5;
	truck_back_trigger waittill("trigger");


//////////////////////////////////////////
	dest_org = (self getTagOrigin ("tag_player"));
	dummy = spawn ("script_origin",(level.player.origin));
	level.player playerlinkto (dummy);
	level.player freezeControls(true);
	dummy moveTo((dest_org + (0,0,15)), .35, .05, .05);
	wait (.25);
	dummy moveTo(dest_org, .5, .05, .05);
	wait (.5);
	level.player setorigin ((self getTagOrigin ("tag_player")));
	level.player playerlinkto (self, "tag_player", ( 0, 0, 0 ));
	wait .2;
	level.player playerlinkto (self, "tag_player", ( .3, .3, .3 ));
	level.player freezeControls(false);
////////////////////////////////////////


	self startpath ();
	level.price.idleanim = %germantruck_driver_drive_loop;

	generator_explosion_trigger = getent ("generator_explosion", "targetname");

	generator_explosion_trigger waittill ("trigger");

//	maps\_utility::exploder (1);


//	bombs = getentarray ("generator_bombs", "targetname");
//	for (i=0;i<bombs.size;i++)
//	{
//		bombs[i] playsound ("explo_metal_rand");
//	}

	wait 3;

	airplane_sound = getent ("airplane_sound", "targetname");
	airplane_sound playsound ("RAF_Bomber");

	truck_crash = getent ("truck_crash", "targetname");
	if (isdefined (truck_crash) )
	{
		truck_crash waittill ("trigger");
		level.player playsound ("truck_crash_wood_barrier");
	}
}

regentruckhealth()
{
	while(1)
	{
		self waittill ("damage");
		self.health = 10000;
	}
}

waters()
{
	waters = getent ("waters","targetname");
	waters = waters dospawn();
	waters character\_utility::new();
	waters character\Waters::main();
	waters.sittag = "tag_waters";
	waters teleport (self gettagorigin("tag_waters"),self gettagorigin("tag_waters"));
	waters linkto (self, waters.sittag);

	waters.attackidle[0] = %truckride_waters_attackidleA;
	waters.attackidle[1] = %truckride_waters_attackidleB;
	waters.hasweapon = false;
//	waters animscripts\shared::PutGunInHand("none");
//	waters.weapon = "panzerfaust";

	while(1)
	{
		animontag(waters, waters.sittag, waters.attackidle[1]);
	}
}

price()
{
	price = getent("driver","targetname");
	price = price dospawn();
	level.price = price;
	price character\_utility::new();
	price character\Price::main();

	price.idleanim = %germantruck_driver_sitidle_loop;
	price.sittag = "tag_driver";

	price teleport (self gettagorigin("tag_driver"));
	price linkto (self, price.sittag, (0, 0, 0), (0, 0, 0));
	price.hasweapon = false;
	price animscripts\shared::PutGunInHand("none");

	while (1)
	{
		org = self gettagOrigin (price.sittag);
		angles = self gettagAngles (price.sittag);

		price animscripted("driveranimdone", org, angles, price.idleanim);
		price waittillmatch ("driveranimdone","end");
	}
}

animontag(guy, tag , animation, notetracks, sthreads)
{
	org = self gettagOrigin (tag);
	angles = self gettagAngles (tag);
	guy animscripted("animontagdone", org, angles, animation);
	if(isdefined(notetracks))
	{
		for(i=0;i<notetracks.size;i++)
		{
			if(!isdefined(notetracks[i]))
			{
				println("notetrack is undefined");

			}


			guy waittillmatch ("animontagdone",notetracks[i]);

//
			guy thread [[sthreads[i]]]();
		}

	}
	guy waittillmatch ("animontagdone","end");
	guy notify ("dothestuff");
}


/////////////////////////////////
return_triggers()
{
	trigger_onces = getentarray ("trigger_once", "classname");
	return_autosaves = [];
	for (i=0;i<trigger_onces.size;i++)
	{
		if (isdefined (trigger_onces[i].script_noteworthy) )
			if (trigger_onces[i].script_noteworthy == "return_autosave")
			{
				return_autosaves[return_autosaves.size] = trigger_onces[i];
				trigger_onces[i] thread maps\_utility::triggerOff();
			}
	}
	return_triggers = getentarray ("return_spawner", "targetname");
	for (i=0;i<return_triggers.size;i++)
	{
		return_triggers[i] thread maps\_utility::triggerOff();
	}
	start_return_trigger = getent ("start_return", "targetname");

	/////////////////
	start_return_trigger waittill ("trigger");
	/////////////////



	level notify ("return_started");
	level.return_started = "true";
	nonreturn_triggers = getentarray ("non_return", "targetname");
	for (i=0;i<nonreturn_triggers.size;i++)
	{
		nonreturn_triggers[i] delete();
	}

	for (i=0;i<return_triggers.size;i++)
	{
		return_triggers[i] thread maps\_utility::triggerOn();
	}
	for (i=0;i<return_autosaves.size;i++)
	{
		return_autosaves[i] thread maps\_utility::triggerOn();
	}
}




alarms_on(alarms)
{
	println ("z:     alarms on");
	level.alarm_one_point playloopsound("klaxxon_alarm");

//	for (i=0;i<alarms.size;i++)
//	{
//		alarms[i] playloopsound("klaxxon_alarm");
//	}
}

alarms_off(alarms)
{
	println ("z:     alarms off");
	level.alarm_one_point stoploopsound();

//	for (i=0;i<alarms.size;i++)
//	{
//		alarms[i] stoploopsound();
//	}
}

random_alerts(alerts, alarms)
{
	while (1)
	{
		if (level.random_alerts == true)
		{
			alarms_off(alarms);

			if (level.return_alerts == true)
				num = randomint (6);
			else
				num = randomint (4);
			if (num == 0)
			{
				alert = "dam_german_PA_shootintruders";
				// ("We are under attack! Battlestations! Shoot intruders on sight!")
			}
			if (num == 1)
			{
				alert = "dam_german_PA_sectionlevel";
				// ("Intruders spotted in Section 6, Level B!")
			}
			if (num == 2)
			{
				alert = "dam_german_PA_noprisoners";
				// ("They're British SAS! Do not take prisoners!")
			}
			if (num == 3)
			{
				alert = "dam_german_PA_SASinside";
				// ("British SAS troops have entered the dam! Enemy troops have broken through!"))
			}
			if (num == 4)
			{
				alert = "dam_german_PA_truckpark";
				//  ("2nd and 5th platoon, divert to the truck park! Enemy troops have overrun the garrison...")
			}
			if (num == 5)
			{
				alert = "dam_german_PA_graff";
				// ("Comms have been lost with the gun crews at the foot of the dam, Lt. Graff, take a squad down there...")
			}
			println ("Z:      alert sound: ", alert);

	 		for (i=0;i<alerts.size;i++)
				alerts[i] playsound(alert);
			level.currently_random_alert = true;

			wait 6;
			level.currently_random_alert = false;
			alarms_on(alarms);
		}

		wait (15 + randomint (10) );
	}
}

alert_sound()
{
	alarms = getentarray ("alarm_sound", "targetname");
	level.alarm_one_point = spawn ("script_origin", (-23936, 6168, -832));

	alerts = [];
	for (i=0;i<alarms.size;i++)
	{
		if (isdefined (alarms[i].origin) )
		{
			alerts[i] = spawn ("script_origin", (0,0,0));
			alerts[i].origin = alarms[i].origin;
		}
	}
	println ("z:     alarms.size ", alarms.size);
	println ("z:     alerts.size ", alerts.size);

	start_alarms = getent ("start_alarms", "targetname");
	alarms_turbines = getent ("alarms_turbines", "targetname");
	alarms_foot = getent ("alarms_foot", "targetname");
	start_return_trigger = getent ("start_return", "targetname");
	level.return_alerts = false;
	alarms_return_elevator = getent ("alarms_return_elevator", "targetname");

	start_alarms waittill ("trigger");

	musicplay("dam_a");

	level.random_alerts = true;
	thread random_alerts(alerts, alarms);

	///////////////////
	alarms_turbines waittill ("trigger");

	level.random_alerts = false;

	wait 3;

	alarms_off(alarms);
	
	if (level.currently_random_alert != true)
	{
 		for (i=0;i<alerts.size;i++)
			alerts[i] playsound("dam_german_PA_turbines");
		println ("The British troops are in the turbine rooms! Cut them off before they reach the power station!");
	}
	wait 10;

	level.random_alerts = true;
	alarms_on(alarms);

	/////////////////
	alarms_foot waittill ("trigger");

	level.random_alerts = false;

	wait 3;

	alarms_off(alarms);
	if (level.currently_random_alert != true)
	{
 		for (i=0;i<alerts.size;i++)
			alerts[i] playsound("dam_german_PA_footofdam");
		println ("To all troops at the foot of the dam - British forces are headed your way!");
	}
	
	wait 8;

	level.random_alerts = true;
	alarms_on(alarms);

	//////////
	start_return_trigger waittill ("trigger");

	level.return_alerts = true;
	level.random_alerts = false;

	wait 3;

	alarms_off(alarms);
	if (level.currently_random_alert != true)
	{
	 	for (i=0;i<alerts.size;i++)
			alerts[i] playsound("dam_german_PA_turbines");
		println ("The British troops are in the turbine rooms! Cut them off before they reach the power station!");
	}

	wait 15;

	level.random_alerts = true;
	alarms_on(alarms);

	/////////////
	alarms_return_elevator waittill ("trigger");

	level.random_alerts = false;

	wait 3;

	alarms_off(alarms);
	if (level.currently_random_alert != true)
	{
	 	for (i=0;i<alerts.size;i++)
			alerts[i] playsound("dam_PA_lies");
		println ("British commandos, we have captured your commanding officer etc. etc....");
	}
	
	wait 10;

	level.random_alerts = true;
	alarms_on(alarms);
}

outside_guys()
{
	self.maxsightdistsqrd = 1440000;
	// 1200 = 1,440,000
	// 1500 = 2,250,000

	while (!isdefined (self.enemy))
	{
		wait .2;
	}

	self.goalradius = 7000;
}
#using_animtree ("germantruck");
animatetruckstuffintoplace()
{
	wait 2;
	self maps\_truckridewaters::truckanim(%truckride_truck_startidle);

}