//=====================================================================================================================
// Bastogne2
//=====================================================================================================================

//---------------------------
// TARGETNAME NAMING CONVENTIONS
//---------------------------
//	p_		=	player
//	r_		=	reinforcements
//	c_		=	courtyard
//	m_		=	magazine
//	g_		=	guns
//	q_		= 	officers' quarters
//	_door		=	used for doors
//	_truck		=	used for trucks
//	_boat		=	used for boats
//	_guard		=	used for normal axis troops
//	_officer	=	used for officers
//	_sas_		=	used for friendly ai
//	_trigger_	=	used for trigger_multiple
//	_damage_	=	used for trigger_damage
//	_use_		=	used for trigger_use
//	_hurt_		=	used for trigger_hurt
//
// ---------------------------
// TEAMS
// ---------------------------
//	blue		=	Core group (Moody, Whitney, Anderson) who must not die.
//	red		=	Part of player group but can die
//	green		=	Second squad

//====================================================================================================
//
//	Make mortar explode before surprise happens, I may need to use Thad's code for guys patrolling
//
//===================================================================================================

main()	
{
	setCullFog (0, 5000, 0.0274, 0.0823, 0.1607, 0 );
//	setCullDist (10000);
//	setCullDist (8000);

	precachemodel("xmodel/vehicle_tank_PanzerIV_camo");
	precachemodel("xmodel/vehicle_tank_PanzerIV_d");
	precachemodel("xmodel/vehicle_tank_panzeriv_machinegun");
	precachemodel("xmodel/vehicle_german_truck_d");
	precachemodel("xmodel/v_ge_art_pak43(d)");
	precachemodel("xmodel/head_foley");
	precachemodel("xmodel/c_us_bod_moody_winter");
	precachemodel("xmodel/head_moody");
	precacheShellshock("default_nomusic");
	
	precacheturret( "mg30cal_bipod_prone");

	if(getcvarint("scr_gmi_fast") >= 1)
	{
		level.mortar = loadfx ("fx/explosions/artillery/pak88_snow_low.efx"); // loads the fx file for mortars
		level._effect["mortar"] = loadfx ("fx/explosions/artillery/pak88_snow_low.efx");
	}

	if(getcvarint("scr_gmi_fast") == 0)
	{
		level.mortar = loadfx ("fx/explosions/artillery/pak88_snow.efx"); // loads the fx file for mortars
		level._effect["mortar"] = loadfx ("fx/explosions/artillery/pak88_snow.efx");
	}

	//temp - add to fx.gsc
	level._effect["truck_lights"]		= loadfx ("fx/vehicle/headlight_german_truck.efx");
	
	//INCLUDED FUNCTIONALITY
	maps\_load_gmi::main();
	maps\_sherman_gmi::main();
	maps\bastogne2_fx::main();
	maps\bastogne2_anim::main();
	maps\_bmwbike_gmi::main();
	maps\_halftrack_gmi::main();
	maps\_breath_gmi::breath_fx_main();
	maps\_truck_gmi::main();
	maps\_vehiclechase_gmi::main();
	maps\_panzeriv_gmi::main_camo();
	maps\_tiger_gmi::main_snow();
	maps\_panzer_gmi::main();
	maps\_flashlight::main();
	maps\_treeburst_gmi::main();
	maps\_treefall_gmi::main();
	maps\_utility_gmi::array_levelthread(getentarray ("truck attack","targetname"), maps\bastogne2_event7::german_truck);
	animscripts\lmg_gmi::precache();

	level.mortar = loadfx ("fx/explosions/artillery/pak88_snow.efx"); // loads the fx file for mortars
	level._effect["mortar"] = loadfx ("fx/explosions/artillery/pak88_snow.efx");
	level.mortar = level._effect["mortar"];
	level.mortar_quake = 0.2;

	level.mortar_mindist = 660;
	level.mortar_maxdist = 3000;
	level.mortar_random_delay = 50;

	//LEVEL INITIALIZING THREADS
	level thread debug_setup();
	level level_setup();

//------Ambient sounds
	level.ambient_track ["exterior"] = "ambient_bastogne2_ext";
	level.ambient_track ["interior"] = "ambient_bastogne2_int";
	thread maps\_utility_gmi::set_ambient("exterior");


	level.flag["farm_alerted_once"] = false;
	level.flag ["crossroads_alive"] = false;


	level.flag ["is_player_cheesing"] = true;
	
//	level waittill("finished intro screen");	//Map's loaded, GO!

	println("^1************************************************************************************");

	level thread util_player_weapon_choice();

	level thread start_of_map();
	level thread mission_success();
}

music_control() // POWER OF MUSIC BABY!!!
{
	musicPlay("bastogne_night_datestamp"); // intro

	level waittill ("speeches over");
	wait 8;
	musicPlay("bastogne_night_stealth"); // start
//	getent("event1_player_cresting_hill","targetname") waittill ("trigger");
	level waittill("event1_powned_arrived");
	musicstop(2); // stop

	level waittill ("keep_moving_forward_done");
	wait 4;
	musicPlay("bastogne_night_dark"); // start
	level waittill("team_wait_on_car");
	musicstop(2); // stop

	level waittill ("moody_goto_ambush_done");
	wait 3;
	musicPlay("bastogne_night_stealth"); // start

	level waittill ("bazooka fired");
	musicstop(2); // stop
}

//=====================================================================================================================
// * * * SETUP FUNCTIONS * * *
//=====================================================================================================================
level_setup()
{
	level thread maps\bastogne2_event1to2::event1_friendly_setup();
	level thread maps\bastogne2_event1to2::event1to2_friendly_setup();
	level thread maps\bastogne2_event2and3::event2_friendly_setup();
	level thread maps\bastogne2_event2and3::trucks_health();
//	level thread maps\bastogne2_event2and3::event3_mortars();// test


//	level thread objectives();		//Handles the objectives for the player

	level thread friendly_chain_setup();	//Turns all friendly chains OFF and then reenables the first chains
}

//=====================================================================================================================
//	mission_success
//
//		Waits for the mission success notify and then starts the next mission
//=====================================================================================================================
mission_success()
{
	level waittill("mission success");
	missionsuccess("foy",true);
}

//=====================================================================================================================
//	debug_setup
//
//		Sets up all debug functionality for the level
//=====================================================================================================================
debug_setup()
{
	level.debug = [];

	maps\_debug_gmi::main();
	
	if ( getcvar("skipto") == "" )
	{
		setcvar("skipto", "none");
	}

	if ( getcvar("skipto") == "event4" )
	{
		setcvar("skipto", "none");
		level thread maps\bastogne2_event4::main_debug();
	}
	
//	Colored syntax for future prints.
	println("^1 1, Red");    
	println("^2 2, Green");  
	println("^3 3, Yellow"); // Debugging.
	println("^4 4, Blue");   
	println("^5 5, Cyan");   
	println("^6 6, Purple"); // Voice overs.
	println("^7 7, White");  
	println("^8 8, NA");     
	println("^9 9, NA");     
	println("^0 0, Black");
//	End Colored Syntax for prints.
}

//=====================================================================================================================
//	debug_cleanup_ai
//
//		If the message comes in then the ai will delete itself
//=====================================================================================================================
debug_cleanup_ai(event_notify,cleanup_notify)
{
	self endon("death");
	level endon(event_notify);
	level waittill(cleanup_notify);
	
	self delete();
}

friendly_chain_setup()
{
	//I'm going to turn off all of the friendly chains until they are needed / wanted...let's see how this works
	maps\_utility_gmi::chain_off("10");		
	maps\_utility_gmi::chain_off("20");	// start of maps\bastogne2_event1to2::event1to2	
	maps\_utility_gmi::chain_off("30");	// start of maps\bastogne2_event1to2::event1to2	
	maps\_utility_gmi::chain_off("40");	// start of maps\bastogne2_event1to2::event1to2	
	maps\_utility_gmi::chain_off("50");	// start of maps\bastogne2_event1to2::event1to2	
	maps\_utility_gmi::chain_off("60");	// start of maps\bastogne2_event1to2::event1to2	
	maps\_utility_gmi::chain_off("70");	// start of maps\bastogne2_event1to2::event1to2	
	maps\_utility_gmi::chain_off("80");	// start of maps\bastogne2_event1to2::event1to2	
	maps\_utility_gmi::chain_off("90");	// start of maps\bastogne2_event1to2::event1to2	
	maps\_utility_gmi::chain_off("5000");	// start of maps\bastogne2_event1to2::event1to2	
	maps\_utility_gmi::chain_off("6000");	// start of maps\bastogne2_event1to2::event1to2	
}

//=====================================================================================================================
// * * * GAME FUNCTIONS && UTILITIES * * *
//=====================================================================================================================
util_dont_ff_me()
{
	
}

util_draw_voice(textstr)
{
	//Draws the indicated text string above the character's head (temp)
	z = 90;
	while( 1)
	{
		aboveHead = self GetEye() + (-50,0,20);
		print3d (aboveHead, textstr, (1,1,1), 1, 0.25);	// origin, text, RGB, alpha, scale
		wait 0.05;
		z--;
	}
}

util_group_allowedstance(groupname,a,b,c)
{
	group = getentarray(groupname, "groupname");

	for(n=0; n<group.size; n++)
	{
		if ( !IsAlive(group[n]) )
			continue;
			
		if ( isDefined(c) )
			group[n] allowedStances(a,b,c);	
		else if ( isDefined(b) )
			group[n] allowedStances(a,b);	
		else if ( isDefined(a) )
			group[n] allowedStances(a);	
	}
}

//=====================================================================================================================
//	util_event 
//
//		Event which will happen when the player looks at the trigger or a certain amount of time has passed.
//		Pass in the trigger name, the time to wait, the message which will be sent when event occured,
//		and the notify that will kill the event
//=====================================================================================================================
util_event(lookat_trigger, time, done_notify, kill_notify)
{
	self endon(kill_notify);
	self endon(done_notify);
	
	self thread util_event_lookat(lookat_trigger, done_notify, kill_notify );
	self thread util_event_wait(time, done_notify, kill_notify );
}

//=====================================================================================================================
//	util_event_lookat 
//
//		sub function of the util_event
//=====================================================================================================================
util_event_lookat(lookat_trigger, done_notify, kill_notify )
{
	self endon(kill_notify);
	self endon(done_notify);
	self endon("death");

	trigger = getent(lookat_trigger,"targetname");
	
	if ( !isdefined(trigger) )
		maps\_utility_gmi::error ("Trigger " + lookat_trigger + " does not exist in the map");
	
	trigger waittill("trigger");
	
	self notify(done_notify);
}

//=====================================================================================================================
//	util_event_wait 
//
//		sub function of the util_event
//=====================================================================================================================
util_event_wait(time, done_notify, kill_notify )
{
	self endon(kill_notify);
	self endon(done_notify);
	self endon("death");
	
	wait(time);
	
	self notify(done_notify);
}

//=====================================================================================================================
//	util_squad1_follow_player
//
//		Sets all of the guys (who are alive) in squad1 to follow the player on friendly chains
//=====================================================================================================================
util_squad1_follow_player()
{
	// set all the ai onto the friendly chain
	for (i=0; i < level.blue.size; i++ )
	{
		if (!isAlive(level.blue[i]) )
			continue;
		level.blue[i] setgoalentity(level.player);
	}
	for (i=0; i < level.red.size; i++ )
	{
		if (!isAlive(level.red[i]) )
			continue;
		level.red[i] setgoalentity(level.player);
	}
}

//==========================================
//
// Makes squad follow closly to the player
//
//==========================================
util_squad1_follow_player_close()
{
	// set all the ai onto the friendly chain
	for (i=0; i < level.blue.size; i++ )
	{
		if (!isAlive(level.blue[i]) )
			continue;
		level.blue[i] setgoalentity(level.player);
		level.blue[i].followmin = 3; 
		level.blue[i].followmax = 1;
	}
	for (i=0; i < level.red.size; i++ )
	{
		if (!isAlive(level.red[i]) )
			continue;
		level.red[i] setgoalentity(level.player);
		level.red[i].followmin = 3; 
		level.red[i].followmax = 1;
	}
}

//==========================================
//
// Makes squad follow standard
//
//==========================================
util_squad1_follow_player_normal()
{
	// set all the ai onto the friendly chain
	for (i=0; i < level.blue.size; i++ )
	{
		if (!isAlive(level.blue[i]) )
			continue;
		level.blue[i] setgoalentity(level.player);
		level.blue[i].followmin = 3; 
		level.blue[i].followmax = 0;
	}
	for (i=0; i < level.red.size; i++ )
	{
		if (!isAlive(level.red[i]) )
			continue;
		level.red[i] setgoalentity(level.player);
		level.red[i].followmin = 0; 
		level.red[i].followmax = 1;
	}
}

dprintln(event, string)
{
	if ( !isDefined( level.debug[event] ) )
	{
		println("^2Warning: Printing debug for an event ("+event+") which is not defined.");
	}
	if ( !level.debug[event])
	{
		return;
	}
	
	println(event+ ": "+ string);
}

//=====================================================================================================================
// * * * MAIN GAME FUNCTIONS * * * 
//=====================================================================================================================
start_of_map()
{
	println("^1STARTING MAP");
	
	//
	//	EVENTS
	//

	level thread objectives();
	level thread save_game();

	level thread maps\bastogne2_event1to2::event1_init();
	level thread maps\bastogne2_event1to2::event1to2_init();
	level thread maps\bastogne2_event2and3::event2_init();
	level thread maps\bastogne2_event2and3::event3_init();
//	level thread maps\bastogne2_event4::main_debug();
//	level thread event4_objectives_debug();
	level thread maps\bastogne2_event7::event7_init();

	level thread music_control();



	level thread event_7_bazooka_hide_show();
//	wait 1;
//	wait 1;
	level waittill("finished intro screen");	//Map's loaded, GO!
}

objectives()
{
	obj_protect_moody = getent("obj_protect_moody","targetname");
	obj_clear_forest = getent("obj_clear_forest","targetname");
	obj_clear_mg42 = getent("obj_clear_mg42","targetname");
	obj_clear_courtyard = getent("obj_clear_courtyard","targetname");
	obj_clear_farmhouse = getent("obj_clear_farmhouse","targetname");
	obj_interrogate = getent("obj_interrogate","targetname");
	obj_protect_prisoners = getent("obj_protect_prisoners","targetname");
	obj_clear_crossroads = getent("obj_clear_crossroads","targetname");
	obj_ambush = getent("obj_ambush","targetname");
	obj_tank = getent("obj_tank","targetname");
	obj_end = getent("obj_end","targetname");
	
	// Follow moody to the ridge
	objective_add(1, "active", &"GMI_BASTOGNE2_OBJECTIVE_1", (level.blue[0].origin));
	objective_current (1);
	level thread moody_Star_Tracker(1);
	level waittill("objective_1_complete");
	level notify("moody follow complete");
	objective_state(1,"done");
	
	// Protect moody
	objective_add(2, "active", &"GMI_BASTOGNE2_OBJECTIVE_2", (obj_protect_moody.origin));
	objective_current (2);
	level waittill("objective_2_complete");
	objective_state(2,"done");
	
	// Clear the Forest
	objective_add(3, "active", &"GMI_BASTOGNE2_OBJECTIVE_3", (obj_clear_forest.origin));
	objective_current (3);
	level waittill("objective_3_complete");
	objective_state(3,"done");
	
	// Follow moody.  Grey out till the player gets to the 42 nest.
	objective_add(4, "active", &"GMI_BASTOGNE2_OBJECTIVE_4", (level.blue[0].origin));
	objective_current (4);
	level thread moody_Star_Tracker(4);
	level waittill("objective_4_complete");
	level notify("moody follow complete");
	objective_state(4,"done");
	
	// Clear Mg42 nest.
	objective_add(5, "active", &"GMI_BASTOGNE2_OBJECTIVE_5", (obj_clear_mg42.origin));
	objective_current(5);
	level waittill("objective_5_complete");	
	objective_state(5,"done");
	
	// Clear courtyard and spike 88's.	
	objective_add(6, "active", &"GMI_BASTOGNE2_OBJECTIVE_6", (obj_clear_courtyard.origin));
	objective_current(6);
	level waittill("objective_6_complete");	
	objective_state(6,"done");

	//Clear Farm house.
	objective_add(7, "active", &"GMI_BASTOGNE2_OBJECTIVE_7", (obj_clear_farmhouse.origin));
	objective_current(7);
	level waittill("objective_7_complete");	
	objective_state(7,"done");
	
	//Interrogate Officer
	objective_add(8, "active", &"GMI_BASTOGNE2_OBJECTIVE_8", (obj_interrogate.origin));
	objective_current(8);
	level waittill("objective_8_complete");	
	objective_state(8,"done");
	
	//Protect the prisoners.
	objective_add(9, "active", &"GMI_BASTOGNE2_OBJECTIVE_9", (obj_protect_prisoners.origin));
	objective_current(9);
	level waittill("objective_9_complete");	
	objective_state(9,"done");
	
	// Follow Moody to the Crossroads
	objective_add(10, "active", &"GMI_BASTOGNE2_OBJECTIVE_10", (13686,4904,100));
	objective_current(10);
//	level thread moody_Star_Tracker(10);
	level waittill("objective_10_complete");
	level notify("moody follow complete");	
	objective_state(10,"done");
	
	// Clear the Crossroads.
	objective_add(11, "active", &"GMI_BASTOGNE2_OBJECTIVE_11", (14114,5882,100));
	objective_current(11);


	level waittill ("player_is_in_trench");
	objective_position(11, (15050,5864,15));
//	//      obj_clear_crossroads.origin
	objective_ring(11);

	// made it to fox
//	level waittill ok remember that you have to put a script noteworthy on the flood spawner at this point.. to change the gold star to the bunker area
//	objective_position(11, (-434,6267,204));
//	objective_ring(11);

	level waittill("objective_11_complete");	
	objective_state(11,"done");
	
	// Ambush Convoy
	objective_add(12, "active", &"GMI_BASTOGNE2_OBJECTIVE_12", (obj_ambush.origin));
	objective_current(12);
	level waittill("objective_12_complete");	
	objective_state(12,"done");
	
	// Destroy Tank.
	objective_add(13, "active", &"GMI_BASTOGNE2_OBJECTIVE_13", (obj_tank.origin));
	objective_current(13);
	level waittill("objective_13_complete");	
	objective_state(13,"done");
	
	// Return back to Crossroads.
	objective_add(14, "active", &"GMI_BASTOGNE2_OBJECTIVE_14", (obj_end.origin));
	objective_current(14);
	level waittill("objective_14_complete");	
	objective_state(14,"done");
}

event4_objectives_debug()
{
	obj_protect_moody = getent("obj_protect_moody","targetname");
	obj_clear_forest = getent("obj_clear_forest","targetname");
	obj_clear_mg42 = getent("obj_clear_mg42","targetname");
	obj_clear_courtyard = getent("obj_clear_courtyard","targetname");
	obj_clear_farmhouse = getent("obj_clear_farmhouse","targetname");
	obj_interrogate = getent("obj_interrogate","targetname");
	obj_protect_prisoners = getent("obj_protect_prisoners","targetname");
	obj_clear_crossroads = getent("obj_clear_crossroads","targetname");
	obj_ambush = getent("obj_ambush","targetname");
	obj_tank = getent("obj_tank","targetname");
	obj_end = getent("obj_end","targetname");


	//Clear Farm house.
	objective_add(7, "active", &"GMI_BASTOGNE2_OBJECTIVE_7", (obj_clear_farmhouse.origin));
	objective_current(7);
	level waittill("objective_7_complete");	
	objective_state(7,"done");
	
	//Interrogate Officer
	objective_add(8, "active", &"GMI_BASTOGNE2_OBJECTIVE_8", (obj_interrogate.origin));
	objective_current(8);
	level waittill("objective_8_complete");	
	objective_state(8,"done");
	
	//Protect the prisoners.
	objective_add(9, "active", &"GMI_BASTOGNE2_OBJECTIVE_9", (obj_protect_prisoners.origin));
	objective_current(9);
	level waittill("objective_9_complete");	
	objective_state(9,"done");
	
	// Follow Moody to the Crossroads
	objective_add(10, "active", &"GMI_BASTOGNE2_OBJECTIVE_10", (13686,4904,100));
	objective_current(10);
//	level thread moody_Star_Tracker(10);
	level waittill("objective_10_complete");
	level notify("moody follow complete");	
	objective_state(10,"done");
	
	// Clear the Crossroads.
	objective_add(11, "active", &"GMI_BASTOGNE2_OBJECTIVE_11", (14114,5882,100));
	objective_current(11);

	level waittill ("player_is_in_trench");

	objective_position(11, (15050,5864,15));
//	//      obj_clear_crossroads.origin
	objective_ring(11);

	// made it to fox
//	level waittill ok remember that you have to put a script noteworthy on the flood spawner at this point.. to change the gold star to the bunker area
//	objective_position(11, (-434,6267,204));
//	objective_ring(11);

	level waittill("objective_11_complete");	
	objective_state(11,"done");
	
	// Ambush Convoy
	objective_add(12, "active", &"GMI_BASTOGNE2_OBJECTIVE_12", (obj_ambush.origin));
	objective_current(12);
	level waittill("objective_12_complete");	
	objective_state(12,"done");
	
	// Destroy Tank.
	objective_add(13, "active", &"GMI_BASTOGNE2_OBJECTIVE_13", (obj_tank.origin));
	objective_current(13);
	level waittill("objective_13_complete");	
	objective_state(13,"done");
	
	// Return back to Crossroads.
	objective_add(14, "active", &"GMI_BASTOGNE2_OBJECTIVE_14", (obj_end.origin));
	objective_current(14);
	level waittill("objective_14_complete");	
	objective_state(14,"done");
}

moody_Star_Tracker(num)
{
	level endon("moody follow complete");

	while(1)
	{
		objective_position(num, level.blue[0].origin);
		wait 0.05;
	}
}

save_game()
{
	level waittill ("speeches over");
	wait 6.4;
	maps\_utility_gmi::autosave(1); // leaving for the mission 2-1

	level waittill ("player_at_ridge");
	maps\_utility_gmi::autosave(2); // entering the forest  2-2


	level waittill("objective_3_complete");	
	maps\_utility_gmi::autosave(3); // forest has been cleared  2-3


//	level waittill ("begin_clear_mg42_nest");
	level waittill("objective_4_complete");	
	maps\_utility_gmi::autosave(4);			// clear the  mg42 nest 2-4


	level waittill ("begin_spike_43");
	maps\_utility_gmi::autosave(5);			// spike the guns 2-5	everything is working up to here.	

//	level waittill("objective_6_complete");	


	level waittill("objective_7_complete");	 // the farm is clear, 
	maps\_utility_gmi::autosave(6);			// interogation 2-6

	level waittill("objective_8_complete");	 // inter done
	maps\_utility_gmi::autosave(7);			// Rescue the missing patrol 2-7


	level waittill("objective_9_complete");			
	maps\_utility_gmi::autosave(8);			// En route to the cross roads 2-8

	// newly added save
	level waittill ("bmw_can_delete_now"); // this is triggered when moody heads over the hill
	maps\_utility_gmi::autosave(9);			//arriving at the crossroads

	level waittill("objective_11_complete");	
	wait 5;
	maps\_utility_gmi::autosave(10);			// cross roads secure 2-9


	level waittill("objective_13_complete");	
	wait 8;
	maps\_utility_gmi::autosave(11);		// ambush success 2-10
	
}



// generic loop to see if the player has an auto weapon, which makes the game a lot easier

util_player_weapon_choice()
{
	slot1weapon = level.player getweaponslotweapon("primary");

	hasweapon_mp40 = level.player hasweapon("mp40");
	hasweapon_mp40 = level.player hasweapon("mp44");

	level.flag ["is_player_cheesing"] = true;

	while (1)
	{
	
		//while (level.flag ["crossroads_alive"] == true) // checks to see what weapons the player is playing with.
		while (level.flag ["is_player_cheesing"] == true) // checks to see what weapons the player is playing with.
		{
				currentweapon = level.player getcurrentweapon();
	
				//if (hasweapon_mp40 == true)
				if (currentweapon == "mp40")
				{
//					println("^9 ********* player is using better weapon!!!!!!!!!!!!! ************");
//					println("^9 ********* player is using better weapon!!!!!!!!!!!!! ************");
//					println("^9 ********* player is using better weapon!!!!!!!!!!!!! ************");
//					println("^9 ********* player is using better weapon!!!!!!!!!!!!! ************");
					ai = getaiarray ("axis");
					for (i=0;i<ai.size;i++)
					{
						if(isalive(ai[i]))
						{
							ai[i].accuracy = 0.7;
						}
					}			
				}

				if (currentweapon == "mp44")
				{
//					println("^3 ********* player is using better weapon!!!!!!!!!!!!! ************");
//					println("^3 ********* player is using better weapon!!!!!!!!!!!!! ************");
//					println("^3 ********* player is using better weapon!!!!!!!!!!!!! ************");
//					println("^3 ********* player is using better weapon!!!!!!!!!!!!! ************");
					ai = getaiarray ("axis");
					for (i=0;i<ai.size;i++)
					{
						if(isalive(ai[i]))
						{
							ai[i].accuracy = 0.7;
						}
					}			
				}
		
				wait 0.05;

//				println("^3 ********* player is not using cheese weapon!!!!!!!!!!!!! ************");
				ai = getaiarray ("axis");
				for (i=0;i<ai.size;i++)
				{
					if(isalive(ai[i]))
					ai[i].accuracy = 0.4;
				}

		}
		wait 0.05;
	}
}

//distanceSquared(vector posA, vector posB);
//Return the distance squared between two positions. This is faster than the distance command, good for relative distance comparisons.
//sqrdist = distanceSquared(level.[0].origin, level.[1].origin);


friendly_damage_penalty()
{	
	self waittill ("damage", dmg, who);
	
	if (who == level.player)
	{
		setCvar("ui_deadquote", "@SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
		missionfailed();
	}
}

friendly_damage_penalty_pow()
{	
	self waittill ("damage", dmg, who);
	
	if (who == level.player)
	{
				//	GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION
		setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_KILLTEAM_POW");
		missionfailed();
	}
}


friendly_turn_gen_talk_off(wait_till)
{
	self endon("death");

	if(!isdefined(wait_till))
	{
		println("^1(friendly_turn_gen_talk_off): MISSING WAIT TILL!");
		return;
	}

	self.generic_dialogue = false;

	level waittill(wait_till);

	self.generic_dialogue = true;
}

event_7_bazooka_hide_show()
{
	bazooka = getent("the_bazooka","targetname");
	oldorg = bazooka.origin;
	bazooka.origin = bazooka.origin + (0,0,-1000);
	level waittill("bazooka guy 2 dead");
	bazooka.origin = oldorg;
	
	while (level.flags["tank_dead"] == false)
	{
		wait 0.25;
	}
	
	bazooka delete();

}


