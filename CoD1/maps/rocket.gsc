#using_animtree("generic_human");
main()
{
	setCullFog (0, 3000, .32, .36, .40, 0 ); //was 2000
	fx = loadfx("fx/explosions/explosion1.efx");
	precachemodel ("xmodel/switch_objective_complete");
	precachemodel ("xmodel/vehicle_german_truck_d");

	maps\rocket_anim::main();
	maps\_load::main();
	maps\_truck::main();
	maps\_treadfx::main();
	maps\_bombs::init();
	if (getcvar("start") == "truck")
		level.player setorigin ( ( 7616, -3744, 264) );

	thread waters();
	thread bombs_objective();
	thread trucks_objective();
	thread locate_v2s_objective();
	thread fuel_v2s_objective();
	thread destroy_v2s_objective();
	thread escape_objective();

	level.ambient_track ["interior"] = "ambient_rocket_int";
	level.ambient_track ["exterior"] = "ambient_rocket_ext";
	thread maps\_utility::set_ambient("exterior");
	
	thread music();
	println ("this is gay");
}

music()	
{	
	wait .05;
	musicplay("pf_stealth");
	
	v2s_located = getent ("v2s_located", "targetname");
	v2s_located waittill ("trigger");
	
	while(1)
	{
		wait 1;
		musicplay("redsquare_tense");
	}
}

bombs_objective()
{
	level.objectives_done[1] = 0;
	thread maps\_bombs::main(1, &"ROCKET_OBJ_AAGUNS", "bomb_trigger");
	objective_current(1);

	//level waittill ("bomb_trigger exploded");
	level waittill ("bomb_trigger planted");
	level.objectives_done[1] = 2;
	wait .1;
	maps\_utility::autosave(1);

	//level waittill ("bomb_trigger planted");
	level waittill ("objective_complete1");
	level.objectives_done[1] = 1;
	update_objectives();
	wait .1;
	maps\_utility::autosave(2);
}

trucks_objective()
{
	level.flag["truck2_dead"] = false;

	obj2 = getent ("obj2", "targetname");
	level.objectives_done[2] = 0;
	objective_add(2, "active", &"ROCKET_OBJ_SUPPLYTRUCKS", (obj2.origin));
	objective_string(2, &"ROCKET_OBJ_SUPPLYTRUCKS", 2);
	thread trucks();

	level waittill ("truck_mine");

	objective_string(2, &"ROCKET_OBJ_SUPPLYTRUCKS", 1);

	if ( level.flag["truck2_dead"] == false)
		level waittill ("truck2_destroyed");

	objective_string(2, &"ROCKET_OBJ_SUPPLYTRUCKS", 0);
	objective_state(2, "done");
	level.objectives_done[2] = 1;
	update_objectives();

	friends = getaiarray ("allies");
	truck_dead_nodes = getnodearray ("truck_dead_nodes", "targetname");
	for (i=0;i<friends.size;i++)
	{
		friends[i] setgoalnode (truck_dead_nodes[i]);
		friends[i].goalradius = (32);
	}
	level.waters waittill ("goal");
	
	friends = getaiarray ("allies");
	for (i=0;i<friends.size;i++)
	{
		friends[i] animscripts\shared::SetInCombat(false);
	}
	wait .2;
	println ("z:          here");
	
	//level.waters thread maps\_anim::anim_single (level.watersarray, "mines");	
	level.waters animscripts\face::SaySpecificDialogue(level.scr_anim["waters"]["mines"], "rocket_waters_helloboys", "pain", "dialog_done");
	level.waters waittill ("dialog_done");
	//iprintlnbold ("Sgt Waters says: Excellent use of mines, Jamison.");
	maps\_utility::autosave(3);

	friends = getaiarray ("allies");
	for (i=0;i<friends.size;i++)
	{
		friends[i] setgoalentity(level.player);
		friends[i].goalradius = (500);
	}
}

/*



 (cardinal point ref: North)
*/

locate_v2s_objective()
{
	v2s_located = getent ("v2s_located", "targetname");
	level.objectives_done[3] = 0;
	objective_add(3, "active", &"ROCKET_OBJ_LOCATEV2", (v2s_located.origin));

	v2s_located waittill ("trigger");
	objective_state(3, "done");
	level.objectives_done[3] = 1;
	update_objectives();
	maps\_utility::autosave(4);

	v2s_fuel_message = getent ("v2s_fuel_message", "targetname");
	v2s_fuel_message waittill ("trigger");

	while (1)
	{
		d = distance (level.player getorigin(), level.waters.origin);
		if (d < 400)
		{
			break;
		}
		wait 1;
	}
	if (level.objectives_done[4] != 1)
	{
		//level.waters thread maps\_anim::anim_single (level.watersarray, "enoughexplosives");
		level.waters animscripts\face::SaySpecificDialogue(level.scr_anim["waters"]["enoughexplosives"], "rocket_waters_v2fuel", "pain", "dialog_done");
		level.waters waittill ("dialog_done");
		//iprintlnbold ("Sgt Waters says: We don’t have enough exposives to destroy these V2s completely.");
	}
}

fuel_v2s_objective()
{
	fuel_lever = getent ("fuel_lever", "targetname");
	fuel_lever_model = getent (fuel_lever.target, "targetname");

	maps\rocket_anim::switch_objective();
	fuel_lever_model.animname = "switch_objective";
	fuel_lever_model UseAnimTree(level.scr_animtree[fuel_lever_model.animname]);

//	obj4_door = getent ("obj4_door", "targetname");
//	obj4_door_trigger = getent (obj4_door.target, "targetname");
//	obj4_door_trigger maps\_utility::triggerOff();
//	obj4_exit = getent ("obj4_exit", "targetname");
//	obj4_exit_trigger = getent (obj4_exit.target, "targetname");
//	obj4_exit_trigger thread locked_message();
	level.objectives_done[4] = 0;
	objective_add(4, "active", &"ROCKET_OBJ_FUELV2", (fuel_lever.origin));

//	obj4_door rotateyaw(90, 0.4,0,0);

//	wait 1;
//	obj4_door connectpaths();

	fuel_lever sethintstring (&"ROCKET_FUEL_LEVER");
	fuel_lever waittill ("trigger");
	fuel_lever thread maps\_utility::triggerOff();

	fuel_lever_model playsound ("switch");
	fuel_lever_model animscripted ("scriptedanimdone", fuel_lever_model.origin, fuel_lever_model.angles, level.scr_anim[fuel_lever_model.animname]["switch_objective_down"]);
	fuel_lever_model waittill ("scriptedanimdone");
	fuel_lever_model thread fuel_sound();

	fuel_lever_model setModel("xmodel/switch_objective_complete");


	maps\_utility::autosave(5);

//	obj4_door_trigger maps\_utility::triggerOn();
//	obj4_door_trigger thread locked_message();
	level notify ("v2s_fueled");
	objective_state(4, "done");
	level.objectives_done[4] = 1;
	update_objectives();
//	obj4_door rotateyaw(-90, 0.4,0,0);
//	obj4_exit rotateyaw(-90, 0.4,0,0);
//	obj4_exit_trigger maps\_utility::triggerOff();
//	wait .1;
//	obj4_door connectpaths();
//	obj4_exit connectpaths();

	while (1)
	{
		d = distance (level.player getorigin(), level.waters.origin);
		if ( (d < 300) && (level.ambient == "exterior") )
			break;
		wait 1;
	}

	if (level.objectives_done[5] != 1)
	{
		//level.waters thread maps\_anim::anim_single (level.watersarray, "placeyourbombs");
		println ("z:               saying rocket_waters_placebombs");
		level.waters animscripts\face::SaySpecificDialogue(level.scr_anim["waters"]["placeyourbombs"], "rocket_waters_placebombs", "pain", "dialog_done");
		level.waters waittill ("dialog_done");
		//iprintlnbold ("Sgt Waters says: Good, now place explosives on those V2s.");
	}
}

fuel_sound()
{
	self playsound ("rocket_fuel_pump_on", "sounddone");
	wait (2.5);

	self playloopsound ("rocket_fuel_pump_loop");
}

destroy_v2s_objective()
{
	fuel_lever = getent ("fuel_lever", "targetname");
	level.objectives_done[5] = 0;
	thread maps\_bombs::main(5, &"ROCKET_OBJ_V2", "v2bomb_trigger", "v2s_fueled");

	level waittill ("objective_complete5");
	level.objectives_done[5] = 1;
	update_objectives();

	if (level.objectives_current != 6)
		level waittill ("obj6_current");
		
	while (1)
	{
		d = distance (level.player getorigin(), level.waters.origin);
		if ( (d < 400) )
			break;
		wait 1;
	}
	
	//level.waters thread maps\_anim::anim_single (level.watersarray, "brilliant");
	level.waters animscripts\face::SaySpecificDialogue(level.scr_anim["waters"]["brilliant"], "rocket_waters_brilliant", "pain", "dialog_done");
	level.waters waittill ("dialog_done");
	///iprintlnbold ("Sgt Waters says: Good, now we escape through the northern bunker.");
}

escape_objective()
{
	level_end = getent ("level_end", "targetname");
	level.objectives_done[6] = 0;
	objective_add(6, "active", &"ROCKET_OBJ_ESCAPE", (level_end.origin));

	level_end waittill ("trigger");

	level.objectives_done[6] = 1;
	objective_state(6, "done");

	//changelevel(<mapname>, <persistent> = false);
	//persistent: if you want the player to keep their inventory through the transition.

	setCvar("ui_campaign", "russian"); // next mission is russian, this fixes the loading screen
	missionSuccess("berlin", false);
}

////////////////////////////////////////////////////
update_objectives()
{
	for (i=1;i<(level.objectives_done.size+1);i++)
	{
		if (level.objectives_done[i] != 1)
		{
			level.objectives_current = i;
			objective_current(i);
			println ("current objective: ", i);


			if (level.objectives_current == 6)
			{
				level notify ("obj6_current");
				obj6_door = getent ("obj6_door", "targetname");
				obj6_door rotateyaw(90, 0.4,0,0);
				wait 1;
				obj6_door connectpaths();
			}

			return;
		}
	}
}



waters()
{
//	waters setgoalentity (undefined);
//	level.player.origin = (-568, 4656, 236);
	
	println ("setting goal entity");
	waters = getent ("waters", "targetname");
	waters character\_utility::new();
	waters character\waters_winter::main();
	waters.goalradius = 1000;
	waters.followmin = 0;
	waters.followmax = 3;
        waters.accuracy = 0.20;
	waters thread maps\_utility::magic_bullet_shield();
	level.waters = waters;
	level.watersarray[0] = waters;
	level.waters.animname = "waters";
	level.waters.name = "Sgt. Waters";

	waters thread intro_dialog();
}

intro_dialog()
{
	self setgoalpos (self.origin);
	self allowedStances ("crouch");
	level waittill ("finished intro screen");
	wait .1;
	level.waters OrientMode("face direction", level.player.origin-level.waters.origin ); 
	wait .3;

	self animscripts\shared::lookatentity(level.player, 10, "casual");

	level.waters thread maps\_anim::anim_single (level.watersarray, "headeast");
	self animscripts\face::SaySpecificDialogue(level.scr_anim["waters"]["headeast_facial"], "rocket_waters_brensupport", "pain", "dialog_done");
	self waittill ("dialog_done");
	self allowedStances ("stand");
	self setgoalentity (level.player);

	//iprintlnbold ("Sgt Waters says: We'll head east, destroying any targets of opportunity");
	//iprintlnbold ("Sgt Waters says: And meet up with the rest of the squad");
	//iprintlnbold ("Sgt Waters says: You take point");
	//iprintlnbold ("Sgt Waters says: I'll give you sniper cover");


	thread first_flak();
	thread second_flak();
	thread first_flak_order();
	thread second_flak_order();
}

first_flak_order()
{
	trigger = getent ("flak1_order", "targetname");
	trigger waittill ("trigger");

	//self thread maps\_anim::anim_single (level.watersarray, "talk3");
	self animscripts\face::SaySpecificDialogue(level.scr_anim["waters"]["destroyflak"], "rocket_waters_needtoblowup", "pain", "dialog_done");
	self waittill ("dialog_done");
	//iprintlnbold ("Sgt Waters says: Martin, Place some explosives on that Flak gun.");
}

second_flak_order()
{
	trigger = getent ("flak2_order", "targetname");
	trigger waittill ("trigger");

	//self thread maps\_anim::anim_single (level.watersarray, "talk3");
	self animscripts\face::SaySpecificDialogue(level.scr_anim["waters"]["destroyflak"], "rocket_waters_needtoblowup", "pain", "dialog_done");
	self waittill ("dialog_done");
	//iprintlnbold ("Sgt Waters says: Martin, Destroy that Flak gun.");
}

first_flak()
{
	trigger = getent ("waters_first_flak", "targetname");
	trigger waittill ("trigger");
	if (level.objectives_done[1] != 2)
	{
		//self thread maps\_anim::anim_single (level.watersarray, "talk3");
		self animscripts\face::SaySpecificDialogue(level.scr_anim["waters"]["destroyflak_reminder"], "rocket_waters_deafdumbblind1", "pain", "dialog_done");
		self waittill ("dialog_done");
		//iprintlnbold ("Sgt Waters says: Martin, Destroy that Flak gun to the west.");
	}
	else
	{
		//iprintlnbold ("Sgt Waters says: Martin, good job on that Flak gun, One more to go.");
	}
}

second_flak()
{
	trigger = getent ("flak2_reminder", "targetname");
	trigger waittill ("trigger");
	if (level.objectives_done[1] != 1)
	{
		//self thread maps\_anim::anim_single (level.watersarray, "talk3");
		self animscripts\face::SaySpecificDialogue(level.scr_anim["waters"]["destroyflak_reminder"], "rocket_waters_deafdumbblind2", "pain", "dialog_done");
		self waittill ("dialog_done");
		//iprintlnbold ("Sgt Waters says: Martin, Destroy that Flak gun to the west.");
	}
	else
	{
		//self thread maps\_anim::anim_single (level.watersarray, "talk3");
		self animscripts\face::SaySpecificDialogue(level.scr_anim["waters"]["destroyflak_good"], "rocket_waters_foundcareer", "pain", "dialog_done");
		self waittill ("dialog_done");
		//iprintlnbold ("Sgt Waters says: Martin, good job on that Flak gun, One more to go.");
	}
}

trucks()
{
	trigger = getent ("obj2", "targetname");
	truck1 = getent ("truck1", "targetname");
	truck2 = getent ("truck2", "targetname");
	truck1 thread maps\_truck::init_rocket();
	truck2 thread maps\_truck::init_rocket();

	truck1 thread truck1_thinker();
	if (isdefined (truck2) )
		truck2 thread truck2_thinker();

	trigger waittill ("trigger");

	level notify ("start_trucks");

	//<scr_vehicle entity> setWaitNode( <node_name> )
	//<scr_vehicle entity> waittill( "reached_wait_node" )
	//<scr_vehicle entity> setSpeed( <speed>, <accel> )
	//<scr_vehicle entity> resumeSpeed( <accel> );
}



truck1_thinker()
{
	gate = getent ("gate", "targetname");
	path = getVehicleNode(self.target,"targetname");
	vec = (59, 0, 0);
	gate rotateTo( vec, 1, .1, .1);
	//rotateTo(vec orent, float time, <float acceleration_time>, <float deceleration_time>);

	level waittill ("start_trucks");
	println ("starting truck1");

	self attachpath (path);
	self maps\_truck::attach_guys();

	self startPath();


	minenode = getVehicleNode("minenode","targetname");
	self setWaitNode (minenode);
	self waittill ("reached_wait_node");

	dmg = self.health + 50000;
	//self DoDamage ( dmg, self.origin );
	radiusDamage (self.origin, 5, dmg, dmg);
	//radiusDamage(vec origin, float range, float max_damage, float min_damage);

	//iprintlnbold ("did damage: ", dmg);
	level notify ("truck_mine");
	self setSpeed (0, 20);
	//wait 2;
	//self notify ("unload");  //_truck.gsc uses this
}


truck2_thinker()
{
	gate = getent ("gate", "targetname");
	path = getVehicleNode(self.target,"targetname");

	level waittill ("start_trucks");

	wait 2;

	self attachpath (path);
	self maps\_truck::attach_guys();

	thread truck2_obj();
	self startPath();

	gatenode = getVehicleNode("truck_gate_end","targetname");
	self setWaitNode (gatenode);
	self waittill ("reached_wait_node");


	vec = (0, 0, 0);
	gate rotateTo( vec, 1, .1, .1);
	//rotateTo(vec orent, float time, <float acceleration_time>, <float deceleration_time>);
	self waittill ("reached_end_node");
	
	dmg = self.health + 50000;
	//self DoDamage ( dmg, self.origin );
	radiusDamage (self.origin, 5, dmg, dmg);
	//radiusDamage(vec origin, float range, float max_damage, float min_damage);
	
	//wait 2;
	//self notify ("unload");  //_truck.gsc uses this
}

truck2_obj()
{
	self waittill( "death", attacker );

	level.flag["truck2_dead"] = true;
	level notify ("truck2_destroyed");
}



locked_message()
{
	while (1)
	{
		self waittill ("trigger");

		iprintlnbold ("Locked. Find another route.");
		wait 3;
	}
}

give_ammo()
{
	while (1)
	{
		currentweapon = level.player getCurrentWeapon();
		currentammo = level.player getFractionMaxAmmo(currentweapon);

		if (currentammo < .3)
		{
			iprintlnbold ("TEMP: Giving the player more ammo.");
			level.player giveMaxAmmo(currentweapon);
		}
		wait 1;
	}
}
