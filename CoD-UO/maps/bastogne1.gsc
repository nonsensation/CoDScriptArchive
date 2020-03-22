/**************************************************************************
Level: 		Bastogne
Campaign: 	Allied
Objectives: 	1. Get to the Jeep
		3. 
		4. Get orders from Luet
		5. Defend the attack from Germans
***************************************************************************/

//02/23/04
// placed first pass of path nodes for rail with minor tweaking on speed and angles
// prepped moody with anims and placed inside of the vehicle
// speed and angles tweaked to convoy

//02/24/04
// rial -puty in backwards 180 at 88 event
// rial- put in cow avoid with stall
// made new gdt for willy -- copied german small car peugeot
// made tank come over hill and attack jeep -- timing to slow right now
// made moody look backwards at tree crash with crash sound... and speed tweaks

//02/25/04
// new version checked in
// got tree to fall over as the tank rolls over it but it only worked with a certain tree
// going to place convoy in now
// tiger, kubel and halftrack are working now
// adding trucks filled with germans -- done there are now two trucks that can be shot at
// got sounds from steve so there are no longer any sound crashes

// make kubel

//02/25/04
// got right jeep with right sounds in
// added skid sounds to first half of rail
// added tanks and troops at event2b
// attached correct gun to jeep.  The is a communication issue between the gun and player just like TRINITY, streets2

//02/27/04
// need geometry entry points for the ai near event2b
// add static guys in an array that I can keep track of at 88's
// add event 6 parked trucks
// made guys at event4 be passive at the truck until the player attacks or gets to close
// added all tanks to beg
// added ai to beg
// setup all ai and tanks to delete themselves

// added more guys to beggining and spread nodes apart to make it look menacing

//03/23/04
// added guys near 88
// tweaked timing of car speed in third event
// helped fix two foy crashes and trigger issues

//03/24/04
// fleshed out guys running away at 88 need to animation
// added germans in last pocket area.. need to polish ai and a few other vehcles back there

// added carride bumpy code
// got moody to jump out of the vehicle


// added falling over trees
// connect new road on convoy
// 

// task list
// do one thing at a time
// add two guys in beggining
// made colision map for logs
// spawn in tank so there is collision for them.

// 04/01/04
// added all anims for static events pushing cart and pak 43
// added new jeep for alecs, multiple issues

// 04/02/04
// had two hour design meeting
// added four cull fog changes through out the level.


// tree bursts
// gettings into convy, though you can put guys on side of road
// can make guys near 
// added tree busrts	

// tree duck acting funny guy is not reseting his anim afterwards ask Dom if this a looping anim! 

// 4/26/04
// Fixed beginning. Moody now waits for Ender and Player.
// Event 5b guys should look a lot better (the guys coming out of the farm house)
// Event 2a should look a lot better
// Event 2 should look a lot better
// Fixed exploding trucks in all parts of the level
// NOt longer have to follow moody on lines to advance level

// 4/27/04
// Event 2b should look a lot better
// Breath FX added
// Snow FX added to jeep
// Tanks now in the back of the convoy



#using_animtree("generic_human");
main()
{
	// this changes fog
	//setCullFog (500, 15000, 0.19, 0.20, 0.21, 0 );
	
	setCullFog (0, 6000, .68, .73, .85, 0 );
	
	
	setCullDist (8000);

	// Precaches

	precachemodel("xmodel/bastogne_bottle");
	precacheModel("xmodel/character_foley");
	precacheModel("xmodel/head_foley");
	precacheModel("xmodel/gear_us_foley");

	precachemodel("xmodel/v_us_lnd_willysjeep_snow");
	precachemodel("xmodel/vehicle_tank_PanzerIV_camo");
	precachemodel("xmodel/vehicle_tank_PanzerIV_d");
	precachemodel("xmodel/v_us_lnd_sherman_snow");
	precachemodel("xmodel/vehicle_german_truck_d");
	precachemodel("xmodel/vehicle_german_truck_covered");
	precachemodel("xmodel/bastogne_kubelwagen_crash");
	precachemodel("xmodel/vehicle_german_kubelwagen");
	precachemodel("xmodel/vehicle_tank_panzeriv_machinegun");

	precachemodel("xmodel/toilet");

	precacheShellshock("default");	//type of shellshock in /scripts
	precacheshader("black");

	character\moody_winter::precache();
	character\Foley_winter::precache();

	//--------------mortar deaths ----------//
	level.scr_anim["generic"]["explode death up"] = %death_explosion_up10;
	level.scr_anim["generic"]["explode death back"] = %death_explosion_back13;	// Flies back 13 feet.
	level.scr_anim["generic"]["explode death forward"] = %death_explosion_forward13;
	level.scr_anim["generic"]["explode death left"] = %death_explosion_left11;
	level.scr_anim["generic"]["explode death right"] = %death_explosion_right13;

	level.scr_anim["generic"]["knockdown back"] = %stand2prone_knockeddown_back;
	level.scr_anim["generic"]["knockdown forward"] = %stand2prone_knockeddown_forward;
	level.scr_anim["generic"]["knockdown left"] = %stand2prone_knockeddown_left;
	level.scr_anim["generic"]["knockdown right"] = %stand2prone_knockeddown_right;
	level.scr_anim["generic"]["getup"]				= (%scripted_standwabble_A);
	
	//----------mortar setup ------------//
	//level.mortar = loadfx ("fx/explosions/artillery/pak88_snow.efx"); 		// loads the fx file for mortars
	//level.mortar_low = loadfx ("fx/explosions/artillery/pak88_snow_low.efx"); 
	
	//level._effect["mortar"] = loadfx ("fx/explosions/artillery/pak88_snow.efx");
	//level._effect["mortar_low"] = loadfx ("fx/explosions/artillery/pak88_snow_low.efx");
	
	if (getcvar("scr_gmi_fast") != 0)
	{
		//level.mortar = level._effect["mortar_low"];
		level.mortar = loadfx ("fx/explosions/artillery/pak88_snow_low.efx");
	}
	else
	{
		//level.mortar = level._effect["mortar"];
		level.mortar = loadfx ("fx/explosions/artillery/pak88_snow.efx");
	}
	//level.mortar = level._effect["mortar"];
	level.mortar_quake = 0.5;							// sets the intenssity of the mortars
	level.atmos["snow"] = loadfx ("fx/atmosphere/snow_light.efx");			// loads the fx file for the rain
	//playfxonplayer(level.atmos["snow"]);						// sets and places the rain fx on the player
	
	level.atmosphere_fx = level.atmos["snow"];
	level.atmosphere_speed = 0.05;
	level.atmosphere_dist = 512;
	level thread maps\_atmosphere::_spawner();

	//-------------map loads------------//
	
	maps\_load_gmi::main();	
	maps\_halftrack_gmi::main();
	maps\_sherman_gmi::main();		
	maps\_panzeriv_gmi::main_camo();
	maps\_tiger_gmi::main_snow();
	maps\_panzer_gmi::main();
	maps\_vehiclechase_gmi::main();
	maps\_kubelwagon_gmi::main();
	maps\_willyjeep_gmi::main();
	maps\_bmwbike_gmi::main();
	maps\_truck_gmi::main();
	maps\_treeburst_gmi::main();
	// will turn this back into an array with more trucks	
	//array_levelthread (ents, process, var, excluders);	
	maps\_utility_gmi::array_levelthread(getentarray ("truck attack","targetname"), ::german_truck);
	maps\bastogne1_anim::main();
//	maps\bastogne1_anim::dialogue_anims();
//	maps\bastogne1_anim::facial_anims();
	maps\bastogne1_anim::kubelwagon_load_anims();
//	maps\bastogne1_anim::peugeot_load_anims();
//	maps\bastogne1_anim::kubelwagon_load_anims();
	maps\bastogne1_anim::willyjeep_load_anims();
	maps\bastogne1_fx::main();
	maps\_treefall_gmi::main();
	maps\_debug_gmi::main();
	maps\_breath_gmi::breath_fx_main();
	maps\_kubelwagon::main();
	maps\bastogne1_dummies::main();	
//	level thread maps\_utility_gmi::set_ambient("exterior");

	// Ambient Tracks
	level.ambient_track ["exterior"] = "ambient_bastogne1_ext";
	thread maps\_utility_gmi::set_ambient("exterior");

	//level.flags
	level.flags["bumpy"]		= false;					//'true' when the car should be bumpy
	level.flags["PlayerInjeep"]  	= false;
	level.flags["ender_in_jeep"]	= false;
	level.flags["intro_over"] 	= false;
	level.flags["driver_home"] 	= false;
	level.flags["passenger_home"] 	= false;
	level.flags["gunner_home"] 	= false;
	level.flags["driver_anim_started"] = false;
	level.flags["passenger_anim_started"] = false;
	level.flags["gunner_anim_started"] = false;
	
	level.jeep_snow = 1;
	level.jeep_snow_fx = false;

	// Moody Setup
	level.moody 		= getent ("moody","targetname");			//Stg Moody (Driver)
	level.moody.failWhenKilled 	= false;
	level.moodyanim		= 0;
	level.moody character\_utility::new();
	level.moody character\moody_winter::main();
	level.moody.animname = "moody";
	level.moody thread maps\_utility::magic_bullet_shield();
	level.moody.playpainanim = 0;
	level.moody.pacifist = true;
	level.moody.pacifistwait = 0;
	level.moodytalkflag = false;
		
	// Ender Setup
	level.ender = getent("ender", "targetname");

	level.ender.dontavoidplayer = 0;
	level.ender.playpainanim = false;
	//level.ender.dontavoidplayer = true;
	level.enderanim		= 0;
	level.ender.anime = "ender";
	level.ender.animname = "ender";
	level.ender thread maps\bastogne1_anim::new_ender_shoot();
	// Jeep Setup
	level.jeep = getent ("willyjeep","targetname");
	level.jeep.health = 999999;
	level.jeep thread health_regen();
	level.jeep.snowfx = level._effect["jeep_snow"];
	
	//level.fronttrig = getent ("peugeot_trigger_front","targetname"); 	// trigger for window damage
	//level.reartrig = getent ("peugeot_trigger_rear","targetname"); 		// trigger for window damage
	level.ai_nosight1 = getent("ai_nosight1", "targetname");
	level.ender thread ender_get_to_jeep();
	level.ender thread jeep_damage_penalty();
	//level thread dead1_death_think();
	//level thread dead1_death();

	//----------Level threads-----------//
	
	level.player.original_threatbias = level.player.threatbias;
	
	level thread event1_guys_setup();
	level thread intro_begin();
	
	if (getcvar("start") != "jesse_start" && getcvar("start") != "plane_start")
	{
		//level thread maps\bastogne1_anim::moody_peugeot_wait();
		level thread moody_hardright();
		level thread moody_hardleft();
		level thread jeep_control_starting();					// Sets flag when player gets in jeep
		level thread jeep_control_loop();					// Notifies when both player and ender are in jeep
		level thread car1();
		level thread moody_vo_function();
		level thread skid_sounds();
		level thread german_yell((1544,17320,144));
		level thread objectives();
		level thread jeep_snow_effect_setup();
		level thread jeep_snow_effect_control();
		level thread convoy_kubelwagon_start();
		level thread event2_support();						// Setting up event 2, guys with tank
		level thread event2a();							// Guys in trucks taking off
		level thread event4a_setup_control();					// Guys coming over the wall
		level thread event4b_setup();
		level thread event5b_setup();						// Guys coming out of farmhouse
		level thread e5_damage_trigger();					// Alters AI if player fires early
		level thread e5_regular_trigger();					// Alerts AI when jeep reaches farmhouse
		level thread event5c_setup();						// Guys coming out from trees after farmhouse
		level thread event5d_setup();						// Last bit of tanks to attack
		level thread e5d_guys_setup();
		level thread maps\bastogne1_anim::moody_drive_fishtail();
		//level thread debug_func();
		//level thread intro_screen();
		level thread truck_exploders();
		//level thread intro_death_field();
		//level thread intro_death_kill();
		level thread intro_allies_setup();
		level thread intro_axis_patrol();
		level thread intro_kill_goldberg();
		level thread intro_kill_jeep();
		level thread intro_kill_willy_anim();
		level thread intro_kill_willy_trig();
		level thread intro_insubbordination();
		level thread intro_kill_slow_player();
		level thread intro_tree_bursts();
		level thread intro_group_stance();
		level thread intro_lock_player();
		level thread intro_group_pacifist();
	}
	
	if (getcvar("toiletry") == "true" && getcvarint("sv_cheats") > 0)
	{
		level thread toilet_hands();
	}
	
	// From bastogne1_add
	level thread maps\bastogne1_add::killmoreguys1_squad_setup();
	level thread maps\bastogne1_add::killmoreguys2_squad_setup();
	level thread maps\bastogne1_add::alpha_squad_setup();					// First battle squad
	level thread maps\bastogne1_add::beta_squad_setup();
	level thread maps\bastogne1_add::beta2nd_squad_setup();	
	level thread maps\bastogne1_add::gamma_squad_setup();
	level thread maps\bastogne1_add::epsilon_squad_setup();					// Tank support squads
	level thread maps\bastogne1_add::delta_squad_setup();
	level thread maps\bastogne1_add::zeta_squad_setup();
	level thread maps\bastogne1_add::mg34_squad_setup();					// Mg 34 squad on opposing line.
	level thread maps\bastogne1_add::final3_squad_setup();					// Send in the clowns.
	level thread maps\bastogne1_add::foxholeNearSoldier_setup();		// Soldiers in the foxholes
	level thread maps\bastogne1_add::foxhole2Soldier_setup();		// Soldiers in the foxholes (2nd half)
	level thread maps\bastogne1_add::field_halftrack();						// Half tracks to come out into battlefield.
	level thread maps\bastogne1_add::end_panzers();						// End panzer sequence.
	level thread maps\bastogne1_add::end_shermans();						// End sherman sequence.
	level thread maps\bastogne1_add::mortar_foxhole();						// Mortar that hits foxhole event.
	level thread maps\bastogne1_add::ai_retreat();						// Retreating guys at the end of level.
	level thread maps\bastogne1_add::level_end();						// Triggers end of level.
	level thread maps\bastogne1_add::save_game();						// Determines when to save the game.
	level thread maps\bastogne1_add::objectives_add();						// Threads objectives 3-7.
	level thread maps\bastogne1_add::fucked_tanks();						// Tanks that eat shit
	level thread maps\bastogne1_add::alpha_killer();						// Spawns in trigger_hurt to kill alpha squad.
	level thread maps\bastogne1_add::own_player();						// Owns player if outside of foxhole during battle 1.
	level thread maps\bastogne1_add::save_player();						// Takes heat off of player when in foxhole.
	level thread maps\bastogne1_add::mortar_killer();						// Killes th guys manning the mortars.
	level thread maps\bastogne1_add::foxhole_cleanup();						// Cleans up anyone left in foxholes.
	level thread maps\bastogne1_add::mortar_field();						// Adds mortar field between fences.
	level thread maps\bastogne1_add::end_panzers_owned();					// The last three panzers that get owned by shermans
	level thread maps\bastogne1_add::fifty_cal_modulate();					// Modulates the range and accuracy of the 50 cal.					// Sets up the last three groups of guys that get spawned in.
	level thread maps\bastogne1_add::foxhole_safe_tracker();
	level thread maps\bastogne1_add::p47_flyby();
	level thread maps\bastogne1_add::delete_halftracks();
	level thread maps\bastogne1_add::delete_tanks();
	level thread maps\bastogne1_add::plane_tanks();
	level thread maps\bastogne1_add::moodyattack1_squad_setup();
	level thread maps\bastogne1_add::moodyattack2_squad_setup();		
	level thread maps\bastogne1_add::moody_smokeover_go();
	level thread maps\bastogne1_add::mg30cal_remover();
	level thread maps\bastogne1_add::mg42_spawner_objective();
	level thread maps\bastogne1_add::shock_player();
	level thread maps\bastogne1_add::bazooka_guy();
	level thread maps\bastogne1_add::smoke_axis();
	level thread maps\bastogne1_add::final_allied_rush();
	level thread maps\bastogne1_add::moody_end_trig_check();
	level thread maps\bastogne1_add::mortar_field_end();
	level thread maps\bastogne1_add::path_spawners();
	level thread maps\bastogne1_add::line_death_field();
	level thread maps\bastogne1_add::line_zone_logic();
	level thread maps\bastogne1_add::drone_control();
	level thread maps\bastogne1_add::halftrack_blocker();
	level thread maps\bastogne1_add::moody_collapse();
	level thread maps\bastogne1_add::gamma_count_up();
	level thread maps\bastogne1_add::snow_fx_back_on();
	level thread maps\bastogne1_add::hint_prints();
	level thread maps\bastogne1_add::haystack_clips();
	//level thread maps\bastogne1_add::red_dot();
	
	level thread player_damage();

	
	
	level thread player_init();
	//level thread jeep_control_starting();					// Sets flag when player gets in jeep
	//level thread jeep_control_loop();					// Notifies when both player and ender are in jeep
	//level thread car1();
	//level thread moody_vo_function();
	//level thread skid_sounds();
	//level thread intro_begin();
	//level thread event1_guys_setup();
	//level thread german_yell((1615,15760,161));
	//level thread objectives();
	//level thread jeep_snow_effect_setup();
	//level thread jeep_snow_effect_control();
	
	// Threads for specific events
	
	//level thread convoy_kubelwagon_start();
	//level thread event2_support();						// Setting up event 2, guys with tank
	//level thread event2a();							// Guys in trucks taking off
	//level thread event4a_setup_control();					// Guys coming over the wall
	//level thread event4b_setup();
	//level thread event5b_setup();						// Guys coming out of farmhouse
	//level thread e5_damage_trigger();					// Alters AI if player fires early
	//level thread e5_regular_trigger();					// Alerts AI when jeep reaches farmhouse
	//level thread event5c_setup();						// Guys coming out from trees after farmhouse
	//level thread event5d_setup();						// Last bit of tanks to attack
	//level thread e5d_guys_setup();
	//level thread maps\bastogne1_anim::moody_drive_fishtail();
	
	//level thread debug_func();

	garbage = getentarray("garbage", "targetname");
	for(i=0; i < garbage.size; i++)
	{
		garbage[i] delete();
	}
	level thread maps\bastogne1_add::main();

	//level thread intro_screen();
}

toilet_hands()
{
	wait 0.3;
	while (1)
	{
		guys = getaiarray("axis");
		guys2 = getaiarray("allies");
		if (isdefined (guys.size))
		{
			for (i=0;i<guys.size;i++)
			{
				if (isalive(guys[i]))
				{
					if (!isdefined (guys[i].toilethands))
					{
						toilet1 = spawn("script_model",(0,0,0));
						toilet1 setmodel("xmodel/toilet");
						toilet2 = spawn("script_model",(0,0,0));
						toilet2 setmodel("xmodel/toilet");
						toilet1 linkto(guys[i], "tag_weapon_right",  (0,0,0), (0,0,0));
						toilet2 linkto(guys[i], "tag_weapon_left",  (0,0,0), (0,0,0));
						guys[i].toilethands = 1;
					}
				}
				wait 0.05;		
			}
		}
		if (isdefined (guys2.size))
		{
			for (i=0;i<guys2.size;i++)
			{
				if (isalive(guys2[i]))
				{
					if (!isdefined (guys2[i].toilethands))
					{
						toilet1 = spawn("script_model",(0,0,0));
						toilet1 setmodel("xmodel/toilet");
						toilet2 = spawn("script_model",(0,0,0));
						toilet2 setmodel("xmodel/toilet");
						toilet1 linkto(guys2[i], "tag_weapon_right",  (0,0,0), (0,0,0));
						toilet2 linkto(guys2[i], "tag_weapon_left",  (0,0,0), (0,0,0));
						guys2[i].toilethands = 1;
					}
				}		
			}
			wait 0.05;
		}	
	}
	wait 0.1;	
}

debug_func()
{
	node = getnode("event5b_guy_node_2","targetname");
	
	if (getcvar("start") == "pak43")
	{	
		 trig1 = getent("event5_trig","targetname");
		 trig2 = getent("event5_trig_fire","targetname");
		 trig1 useby(level.jeep);
		 trig2 useby(level.jeep);
		 
		 level thread event5_setup();	
		 wait 3;								// Debug stuff
		level.player setorigin((node.origin),(0,0,0));  		// Debug stuff
		level.player thread maps\_utility::magic_bullet_shield();
	}
}


//
// Cool Intro stuff
//
intro_screen()
{
	if (getcvar("no_intro") != "true")
	{
		//level thread intro_snowsteps();
		level thread intro_breath();
		level thread intro_explosions();
		level thread intro_tank_sounds();
		level thread intro_axis_yells();
		level thread intro_allied_yells();
		
		level.blackoutelem = newHudElem();
		level.blackoutelem setShader("black", 640, 480);
	
		println("It goes black!");
	
		level.blackoutelem.alpha = 1;
	
		wait 0.05;
		level.player freezeControls(true);
	
		wait 3;
	
		level.player shellshock("default", 3);
	
		wait 1;
	
		startpoint = getent("player_startpoint","targetname");
		level.player setorigin((startpoint.origin),(0,0,0)); 
	
		wait 0.5;
	
		level.blackoutelem fadeOverTime(1.5); 
		level.blackoutelem.alpha = 0;
	
	}
	
	level notify("intro over");
	
	
	level.flags["intro_over"] = true;
	
	wait 2;
	level.player freezeControls(false);
}

intro_breath()
{
	explosion = getent("intro_breath","targetname");
	while (level.flags["intro_over"] == false)
	{
		explosion playsound("fatigue_breath");
		wait 0.5;
	}
}

intro_snowsteps()
{
	steps = getentarray ("intro_snow_steps","targetname");
	
	for (i = 0;i<steps.size;i++)
	{
		steps[i] thread intro_snow_sounds();
		wait randomfloat(1.0);
	}
}

intro_snow_sounds()
{
	while (level.flags["intro_over"] == false)
	{
		self playsound("step_sprint_snow");
		wait randomfloat(0.3,0.5);
	}
}

intro_explosions()
{
		//wait 4;
		explosion = getent("intro_explosions_1","targetname");
		explosion playsound("shell_flash");
		
		//wait 3;
		//explosion = getent("intro_explosions_2","targetname");
		//explosion playsound("shell_flash");
		
		//wait 2;
		//explosion = getent("intro_explosions_3","targetname");
		//explosion playsound("shell_explosion_muffled");
		
		wait 1;
		explosion = getent("intro_explosions_4","targetname");
		explosion playsound("shell_explosion_muffled");
		
		wait 1.5;
		explosion = getent("intro_explosions_5","targetname");
		explosion playsound("mortar_incoming1");
		wait 1;
		explosion playsound("mortar_explosion1");
}

intro_allied_yells()
{
	
	wait 3;
	allied = getent("intro_allied_yells1","targetname");
	allied  playsound("moody_go");
	
	wait 4;
	allied = getent("intro_allied_yells2","targetname");
	allied  playsound("moody_watchout");
	
}

intro_axis_yells()
{
	axis = getentarray ("intro_axis_yells","targetname");
	for (i=0;i<axis.size;i++)
	{
		axis[i] thread intro_axis_yells_sounds();
	}
}

intro_axis_yells_sounds()
{
	while (level.flags["intro_over"] == false)
	{
		self playsound("generic_misccombat_german_1");
		wait randomfloatrange(1.0,4.0);
	}
}

intro_tank_sounds()
{
	node = getvehiclenode ("intro_tank1","targetname");
	ht = spawnVehicle( "xmodel/v_ge_lnd_halftrack", "intro_1", "GermanHalfTrack" ,(0,0,0), (0,0,0) );
	ht attachpath(node);
	ht.isalive = 1;
	ht.health = (1000000);
	ht startpath();
	
	node = getvehiclenode ("intro_tank2","targetname");
	tank1 = spawnVehicle( "xmodel/vehicle_tank_tiger_camo", "vclogger", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank1 maps\_tiger_gmi::init();
	tank1 attachpath(node);
	tank1.isalive = 1;
	tank1.health = (1000000);
	tank1 maps\_tankgun_gmi::mgoff();
	tank1 startpath();
	
	node = getvehiclenode ("intro_tank3","targetname");
	tank2 = spawnVehicle( "xmodel/vehicle_tank_tiger_camo", "vclogger", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank2 maps\_tiger_gmi::init();
	tank2 attachpath(node);
	tank2.isalive = 1;
	tank2.health = (1000000);
	tank2 maps\_tankgun_gmi::mgoff();
	tank2 startpath();
	
	wait 15;
	
	
	level thread remove_vehicle(tank1);
	level thread remove_vehicle(tank2);
	level thread remove_vehicle(ht);
}

//
// Regeneration of health for the jeep
//
health_regen()  
{  
	level endon("ExitVehicle");  
  
	my_health = self.health;  
  
    	while(1)  
	{       
		self waittill("damage");  
		self.health = my_health;  
		wait 0.25;  
	}  
}

//
//Objectives for the rail
//
objectives()
{
	// Follow your squad
	objective_add(1, "active", &"GMI_BASTOGNE1_OBJECTIVE_1A", (1472,15736,156));
	objective_current(1);
	level waittill("objective_1a_complete");	
	objective_state(1,"done");

	// Get to the jeep
	objective_add(1, "active", &"GMI_BASTOGNE1_OBJECTIVE_1", (level.jeep.origin));
	objective_current(1);
	level waittill("objective_1_complete");	
	objective_state(1,"done");

	// get to the cp
	objective_add(2, "active", &"GMI_BASTOGNE1_OBJECTIVE_2", (-4341,-6999,257));
	objective_current(2);
	level waittill("objective_2_complete");	
	objective_state(2,"done");
}


//
// Lets rail know when player is on jeep
//
jeep_control_starting()
{

	
	level.jeep waittill ("player_on_vehicle"); //- when player gets on vehicle
	level.flags["PlayerInjeep"]  = true;
	maps\_utility_gmi::autosave(1);
	level notify ("player in jeep");

}

// 
// Controls when jeep actually begins motion
//
jeep_control_loop()
{
	while ((level.flags["PlayerInjeep"] == false) || (level.flags["ender_in_jeep"] == false))
	{
		wait 0.1;
	}
	level notify ("jeep go");
	musicPlay("jeepride");
	println("^1jeep go sent");
	
	while (level.moodytalkflag == true)
	{
		wait 0.1;
	}
	
	level.ender thread anim_single_solo(level.ender,"ender_joey");
	level thread maps\bastogne1_anim::ender_speakshort();
	wait 2;
	level.moody thread anim_single_solo(level.moody,"moody_use_50");
	level thread maps\bastogne1_anim::moody_speakshort();
}

jeep_snow_effect_setup()
{
	if (getcvar("scr_gmi_fast") != 0)
	{
		return;
	}
	
	trigs = getentarray("jeep_snow_trigs","targetname");
	for (i=0;i<trigs.size;i++)
	{
		trigs[i] thread jeep_snow_increment();
	}
	
}

jeep_snow_increment()
{
	if (getcvar("scr_gmi_fast") != 0)
	{
		return;
	}
	self waittill ("trigger");
	//level.jeep_snow++;
	
	println("^1triggered snow effect: "+self.targetname);
	
	if (self.script_noteworthy == "jeep_snow_on")
		level.jeep_snow_fx = true;
	else
		level.jeep_snow_fx = false;
	
}

jeep_snow_effect_control()
{
	if (getcvar("scr_gmi_fast") != 0)
	{
		return;
	}
	level thread jeep_snow_debug();
	while (1)
	{
		if (level.jeep_snow_fx == true)
		{
			playfxonTag (level.jeep.snowfx, level.jeep, "tag_origin");
		}
		wait 0.4;
	}
}

jeep_snow_debug()
{
	/*while (1)
	{
		if(getcvar("stop_snow_print") == "1")
		{
			wait 1;
			continue;
		}
		println("jeepsnownum: "+level.jeep_snow_fx+" jeep origin: "+level.jeep.origin);
		//println("jeep origin: "+level.jeep_snow_fx);
		wait 0.05;
		
		trigs = getentarray("jeep_snow_trigs","targetname");
		for (i=0;i<trigs.size;i++)
		{
			line(level.player.origin, trigs[i].origin, (1,1,1), 1, 0);
		}
	}*/
}

moody_vo_function()
{
	wait 2;
	level.player.start_health = level.player.health;
	level.jeep makevehicleunusable();
	
	level.moody animscripts\shared::putGunInHand ("none");
	level.moody.hasweapon = false;	
	level.moody.oldrun_noncombatanim = level.moody.run_noncombatanim;
	level.moody.run_noncombatanim = %unarmed_run_officer;
	level.moody.oldstandanim = level.moody.standanim;
	level.moody.standanim = %line_officer_stand_idle;
	
	
	level.moody thread anim_single_solo(level.moody,"moody_intro_anim", "tag_driver", undefined, level.jeep);
	level.ender thread anim_single_solo(level.ender,"ender_intro_anim", "tag_driver", undefined, level.jeep);
	level.moody thread anim_single_solo(level.moody,"moody_intro");	
	//wait 8.5;
	level.ender waittillmatch ("single anim","ender_skip_patrol");
	level.ender thread anim_single_solo(level.ender,"ender_skip_patrol");	
	//wait 4;
	level.moody waittillmatch ("single anim","moody_done_sweep");
	level.moody thread anim_single_solo(level.moody,"moody_done_sweep");
	level.ender waittillmatch ("single anim","end");	
	//wait 5;
	
	level notify ("moody talk done");
	
	level thread arrow_help();
	
	level thread moody_intro_idle_anim();
	
	level waittill("back to jeeps");
	
	level.jeep makevehicleusable();
	level.moody.interval = 0;
	level.moody.dontavoidplayer = true;
	level.moody.goalradius = 4;
	//level.moody setgoalnode(getnode("moody_getin1","targetname"));
	//level.moody waittill ("goal");
	//level.moody setgoalnode(getnode("moody_getin2","targetname"));
	//level.moody waittill ("goal");
	level.moody thread anim_single_solo(level.moody,"moody_climbin", "tag_driver", undefined, level.jeep);
	level.moody waittillmatch ("single anim","end");
	//level.moody thread anim_single_solo(level.moody,"moody_jumpin", "tag_driver", undefined, level.jeep);
	//level.moody waittillmatch ("single anim","end");
	jeep_idle = getent("jeep_idler", "targetname");
	jeep_idle playloopsound ("jeep_idle_high");
	//level waittill("intro over");
	//wait 3;

	//level.moody thread anim_single_solo(level.moody,"moody_go");

	//wait 4;

	//level.moody thread anim_single_solo(level.moody,"moody_use_50");

	thread maps\bastogne1_anim::moody_drive_setup();
	level thread maps\bastogne1_anim::moody_peugeot_wait();
	
	level waittill("jeep go");
	
	jeep_idle stoploopsound();
		
	level.moodyanim = 0;
	level.enderanim = 0;
	thread maps\bastogne1_anim::moody_drive_idle();
	thread maps\bastogne1_anim::ender_passenger_idle();
	//thread maps\bastogne1_anim::ender_passenger_idle();

	//thread maps\bastogne1_anim::play_rand_anim(1,undefined,undefined);	// random idle 	

	level waittill ("watch out vo");
	level.moody thread anim_single_solo(level.moody,"moody_watch_out");
	
	level waittill ("hq vo");
	level.moody thread anim_single_solo(level.moody,"moody_backto_hq");
	
	level waittill ("watch it vo");
	//level.moody thread anim_single_solo(level.moody,"moody_watchit");

	level waittill ("eyes open vo");
	level.moody thread anim_single_solo(level.moody,"moody_eyesopen");
	
	level waittill ("to the right vo");
	level.moody thread anim_single_solo(level.moody,"moody_totheright");

	level waittill ("dead ahead vo");
	level.moody thread anim_single_solo(level.moody,"moody_deadahead");
	
	level waittill ("passright vo");
	level.ender thread anim_single_solo(level.ender,"ender_passright");
	
	level waittill ("stop yakin vo");
	level.moody thread anim_single_solo(level.moody,"moody_stopyackin");
	
	level waittill ("to the left vo");
	level.moody thread anim_single_solo(level.moody,"moody_totheleft");

	level waittill("moody_stalled_vo");
	level.moody thread anim_single_solo(level.moody,"moody_stalled");

	level waittill ("offtoright vo");
	level.ender thread anim_single_solo(level.ender,"ender_offtoright");

	level waittill("moody_almost_vo");
	level.moody thread anim_single_solo(level.moody,"moody_almost");

	level waittill ("hitit vo");
	level thread maps\bastogne1_anim::ender_speak();
	level.ender thread anim_single_solo(level.ender,"ender_hitit");
	
	level waittill ("dontlikethis vo");
	level.ender thread anim_single_solo(level.ender,"ender_dontlikethis");
	
	level waittill ("whats to like vo");
	level.moody thread anim_single_solo(level.moody,"moody_whatstolike");
	
	level waittill("moody_shortcut_vo");
	level.moody thread anim_single_solo(level.moody,"moody_shortcut");

	level waittill("ender_shortcut2_vo");
	level.moody thread anim_single_solo(level.ender,"ender_shortcut2");

	level waittill("moody_heregoes_vo");
	level.moody thread anim_single_solo(level.moody,"moody_heregoes");

	level waittill("moody_wherehit_vo");
	level.moody thread anim_single_solo(level.moody,"moody_wherehit");

	level waittill ("ender_watchout vo");
	level.ender thread anim_single_solo(level.ender,"ender_watchout");

	level waittill("moody_wherehit2_vo");
	level.moody thread anim_single_solo(level.moody,"moody_wherehit2");
	
	level waittill("moody_oh_baby_vo");
	level.moody thread anim_single_solo(level.moody,"moody_oh_baby");
	
	level waittill("moody_clear_vo");
	level.moody thread anim_single_solo(level.moody,"moody_clear");
	
	level waittill("moody_medic_vo");
	level.moody thread anim_single_solo(level.moody,"moody_medic");

}

arrow_help()
{
	wait 3;
	iprintlnbold(&"GMI_BASTOGNE1_ARROW_HELP");
}

moody_intro_idle_anim()
{
	level endon("back to jeeps");
	while (1)
	{
		level.moody thread anim_single_solo(level.moody, "moody_intro_idle", "tag_driver", undefined, level.jeep);
		level.moody waittillmatch ("single anim","end");
	}
}

// this is a loop that checks distance to player and tells them to get into the jeep
moody_tell_50cal()
{
}

ender_get_to_jeep()
{
	level waittill("back to jeeps");
	//wait 3.3;
	node = getnode("ender_spot1", "targetname");
	level.ender allowedstances ("stand");
	level.ender.pacifist = true;
	//level.ender.pacifistwait = 0;
	level.ender.interval = 0;
	level.ender.ignoreme = 1;
	level.ender.goalradius = 4;
	level.ender setgoalnode(node);
	level.ender.runanimplaybackrate = 1.4;
	level.ender waittill ("goal");	

    	level.ender setgoalnode (node); 
        level.ender waittill ("goal");

	thread maps\bastogne1_anim::ender_peugeot();
}



dead1_death()
{
	level waittill("intro over");
	//wait 2.3;
	node = getnode("dead1_spot1", "targetname");

	level.dead1.goalradius = 4;
	level.dead1.runanimplaybackrate = 1.4;
	level.dead1 allowedstances("crouch");
	level.dead1 setgoalnode(node);
	level.dead1 waittill ("goal");

	//level thread dead1_death_think();


	node = getnode("dead1_spot2", "targetname");	
	level.dead1 setgoalnode(node);
	level.dead1 waittill ("goal");

	org = level.dead1.origin;
	mortar_hit_explosion (org);

	wait 3; // lower ai_nosight brush so attack begins but only after the Ender wiggin makes it over hump
	level.ai_nosight1 moveTo((1464, 16632, -192 ), 0.01, 0, 0);
}

dead1_death_think()
{
	level.dead1 = getent("dead1", "targetname");
	level.dead1 playsound("generic_grenadedanger_elder");	
}

mortar_hit_explosion ( vec )
{
	playfx ( level.mortar, vec );
	thread playSoundinSpace ("mortar_explosion", vec);
	earthquake(0.3, 3, vec, 850); // scale duration source radius
	do_mortar_deaths (getaiarray(), vec);
	radiusDamage (vec, 64, 300, 300);
}

playSoundinSpace (alias, origin)
{
	org = spawn ("script_origin",(0,0,1));
	org.origin = origin;
	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}

#using_animtree("generic_human");
do_mortar_deaths (ai, org)
{
	for (i=0;i<ai.size;i++)
	{
		if (isdefined (ai[i].magic_bullet_shield))
			continue;

		dist = distance (ai[i].origin, org);
		if (dist < 190)
		{
			ai[i].allowDeath = true;
			ai[i].deathAnim = ai[i] getExplodeDeath("generic", org, dist);
			ai[i] DoDamage ( ai[i].health + 50, (0,0,0) );
			println ("Killing an AI");
			continue;
		}

//		if (isdefined (ai[i].getting_up))
//			continue;
//
//		if (dist < 300)
//			ai[i] thread getup(ai[i] getKnockDown(org), org);
	}
}

getExplodeDeath(msg, org, dist)
{
	if (isdefined (org))
	{
		if (dist < 50)
			return level.scr_anim[msg]["explode death up"];

		ang = vectornormalize ( self.origin - org );
		ang = vectorToAngles (ang);
		ang = ang[1];
		ang -= self.angles[1];
		if (ang <= -180)
			ang += 360;
		else
		if (ang > 180)
			ang -= 360;

		if ((ang >= 45) && (ang <= 135))
			return level.scr_anim[msg]["explode death forward"];
		if ((ang >= -135) && (ang <= -45))
			return level.scr_anim[msg]["explode death back"];
		if ((ang <= 45) && (ang >= -45))
			return level.scr_anim[msg]["explode death right"];

		return level.scr_anim[msg]["explode death left"];
	}

	randdeath = randomint(5);
	if (randdeath == 0)
		return level.scr_anim[msg]["explode death up"];
	else
	if (randdeath == 1)
		return level.scr_anim[msg]["explode death back"];
	else
	if (randdeath == 2)
		return level.scr_anim[msg]["explode death forward"];
	else
	if (randdeath == 3)
		return level.scr_anim[msg]["explode death left"];

	return level.scr_anim[msg]["explode death right"];
}

attach_turret(tagname,turretname,turretmodel,offset)
{
    if (!isdefined(offset))
    {
        offset = (0,0,0);
    }
    precacheturret(turretname);
    self.turret = spawnturret("misc_turret", (0, 0, 0), turretname);
    self.turret setmode("manual");
	
    self.turret linkto(self,tagname, offset, (0, 0, 0));
    self.turret setmodel(turretmodel);
}

// end mortar death stuff

player_init()
{
	level.player setWeaponSlotAmmo("primary", 10);
	level.player.inithealth = level.player.health;
	level.player allowuse(false);
	//level.player thread maps\_utility_gmi::magic_bullet_shield();
	//#########################################################################
	//#########################################################################
//	level.player playerlinkto (level.jeep, "tag_player", ( .3, .3, .3 ));
//	level.player playerlinkto (level.jeep, "tag_player", ( 1, 1, 1 ));
//	level.player freezeControls(false);
	level waittill ("back to jeeps");
	level.player allowuse(true);
	level.jeep waittill ("player_on_vehicle"); //- when player gets on vehicle
	level.player.health = level.player.inithealth;
	/*for (i=10;i>0;i--)
	{
		println(i);
		wait 1;
	}*/
	level.player allowuse(false);
	
	level.jeep maps\_willyjeep_gmi::init_player();
	
	//musicPlay("jeepride");
	level.flags["PlayerInKubel"] = false;
	level.flags["bumpy"] 		= true;						//'true' when the PLAYER should be bumpy
//	peugeot thread bumpy();
	//level.jeep thread maps\bastogne1_anim::willyjeep_bumpy();			//make the car bumpy
	//#########################################################################
	//#########################################################################
	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowCrouch(false);

	level notify("objective_1_complete");

	level thread start_drive();
	level.jeep.health = 990000000;
	
	healthstuff = getentarray ("health_be_gone","targetname");
	for (i=0;i<healthstuff.size;i++)
	{
		healthstuff[i] delete();
	}
}

bumpy()
{
	while (level.flags["bumpy"] == true)
	{
		delay = randomfloatrange(1,1.1);
		jolt = randomfloat(.5);
		self joltbody((self.origin + (0,0,64)),jolt);
		wait (delay);
	}
}

start_drive()
{
	
	sound_ent = spawn ("script_origin",level.jeep.origin);
	
	level waittill ("jeep go");
	
	path = getVehicleNode (level.jeep.target,"targetname");
	level.jeep attachpath(path);
	level.jeep thread maps\_treads_gmi::main();
	
	level.jeep startpath();

	level.player.ignoreme = (false);

}

//////////////////////////////////////////////////////
// sets up hard right left and right for moody only //
//////////////////////////////////////////////////////

moody_hardleft()
{
	hardleft = getentarray ("hardleft","targetname");
	for (i=0;i<hardleft.size;i++)
		hardleft[i] thread moody_hardleft_think();
}

moody_hardleft_think()
{
	self waittill ("trigger");
	if ( (isdefined (self.script_noteworthy)) && (self.script_noteworthy == "special1") )
	{
		//MOODY SKIDS THROUGH THE CONVOY
		thread maps\bastogne1_anim::driver_hardleft();
		wait (2.5);
		level notify ("Convoy Gap");
		wait (2.5);
		thread maps\bastogne1_anim::driver_hardright();
	}
	else
	{
		thread maps\bastogne1_anim::driver_hardleft();
	}
}

moody_hardright()
{
	hardright = getentarray ("hardright","targetname");
	for (i=0;i<hardright.size;i++)
		hardright[i] thread moody_hardright_think();
}

moody_hardright_think()
{
	self waittill ("trigger");
	if ( (isdefined (self.script_noteworthy)) && (self.script_noteworthy == "special1") )
	{
		//MOODY STEERS PAST THE SHOOTING TANK
		thread maps\bastogne1_anim::driver_hardright();
		wait (1.0);
		thread maps\bastogne1_anim::driver_hardleft();
		wait (1.0);
		thread maps\bastogne1_anim::driver_hardright();
		wait (1.0);
		thread maps\bastogne1_anim::driver_hardleft();
		wait (1.0);
		thread maps\bastogne1_anim::driver_hardright();
		wait (0.5);
		thread maps\bastogne1_anim::driver_hardleft();
	}
	else
	{
		thread maps\bastogne1_anim::driver_hardright();
	}
}



skid_sounds()
{
	trigs = getentarray ("skid","targetname");
	for (i=0;i<trigs.size;i++)
		trigs[i] thread skid_sounds_wait();
}

skid_sounds_wait()
{
	self waittill ("trigger");
	level.player playsound ("dirt_skid");
}


// spawn all vehicles and ai in the beggining of the map
intro_begin()
{
	level waittill("start intro vehicles");
	//level waittill ("intro over");
	halftrack = spawnVehicle( "xmodel/v_ge_lnd_halftrack", "intro_1", "GermanHalfTrack" ,(0,0,0), (0,0,0) );
//	halftrack thread maps\_halftrack_gmi::init();
//	halftrack maps\_halftrack_gmi::init();
	path = getVehicleNode ("intro_half1_path","targetname");
	halftrack attachpath(path);
	halftrack.isalive = 1;
	halftrack.health = (1000000);
	halftrack thread intro_trash();

	tank2a = spawnVehicle( "xmodel/vehicle_tank_tiger_camo", "intro_2", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank2a maps\_tiger_gmi::init();
	tanktarget = getent ("willyjeep","targetname");
	path2a = getVehicleNode ("intro_tank2_path","targetname");
	tank2a attachpath(path2a);
	tank2a.isalive = 1;
	tank2a.health = (1000000);
	tank2a maps\_tankgun_gmi::mgoff();
	//tank2a thread intro_fire_think_mg42();	
	tank2a thread intro_fire_think();
	tank2a thread intro_trash();


	tank3 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "intro_3", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank3 maps\_panzeriv_gmi::init();
//	tanktarget = getent ("willyjeep","targetname");
	path3 = getVehicleNode ("intro_tank3_path","targetname");
	tank3 attachpath(path3);
	tank3.isalive = 1;
	tank3.health = (1000000);
	tank3 maps\_tankgun_gmi::mgoff();
	//tank3 thread intro_fire_think_mg42();
	tank3 thread intro_fire_think();
	tank3 thread intro_trash();

	tank4 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "intro_4", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank4 maps\_panzeriv_gmi::init();
//	tanktarget = getent ("willyjeep","targetname");
	path4 = getVehicleNode ("intro_tank4_path","targetname");
	tank4 attachpath(path4);
	tank4.isalive = 1;
	tank4.health = (1000000);
	tank4 maps\_tankgun_gmi::mgoff();
	//tank4 thread intro_fire_think_mg42();
	tank4 thread intro_trash();

	/*tank5 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "intro_5", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank5 maps\_panzeriv_gmi::init();
//	tanktarget = getent ("willyjeep","targetname");
	path5 = getVehicleNode ("intro_tank5_path","targetname");
	tank5 attachpath(path5);
	tank5.isalive = 1;
	tank5.health = (1000000);
	tank5 maps\_tankgun_gmi::mgoff();
	//tank5 thread intro_fire_think_mg42();
	tank5 thread intro_fire_think();
	tank5 thread intro_trash();*/

	tank6 = spawnVehicle( "xmodel/vehicle_tank_tiger_camo", "intro_2", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank6 maps\_tiger_gmi::init();
	tanktarget = getent ("willyjeep","targetname");
	path6 = getVehicleNode ("intro_tank6_path","targetname");
	tank6 attachpath(path6);
	tank6.isalive = 1;
	tank6.health = (1000000);
	tank6 maps\_tankgun_gmi::mgoff();
	//tank6 thread intro_fire_think_mg42();
	tank6 thread intro_trash();

	tank7 = spawnVehicle( "xmodel/vehicle_tank_tiger_camo", "intro_2", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank7 maps\_tiger_gmi::init();
	tanktarget = getent ("willyjeep","targetname");
	path7 = getVehicleNode ("intro_tank7_path","targetname");
	tank7 attachpath(path7);
	tank7.isalive = 1;
	tank7.health = (1000000);
	tank7 maps\_tankgun_gmi::mgoff();
	//tank7 thread intro_fire_think_mg42();
	tank7 thread intro_trash();
	
	//level waittill("intro over");
	
	halftrack startpath();
	halftrack setspeed(6,15);
	tank2a startpath();
	tank2a setspeed(6,25);
	tank3 startpath();
	tank3 setspeed(6,10);
	tank4 startpath();
	tank4 setspeed(6,10);
	//tank5 startpath();
	//tank5 setspeed(6,10);
	tank6 startpath();
	tank6 setspeed(6,25);	
	tank7 startpath();
	tank7 setspeed(6,25);	
}

intro_trash()
{
	level waittill("clean_up1");
	level thread remove_vehicle(self);
}

intro_fire_think()
{
	while(isalive(self))
	{
		wait (3 + randomfloat (4));
		{
			self setTurretTargetEnt(level.player, (250, 150, 200) );
			self thread maps\_tiger_gmi::fire();	
		}
	}
}

intro_fire_think_mg42()
{
	while(isalive(self))
	{
		wait (4 + randomfloat (4));
		{
			self maps\_tankgun_gmi::mgon();
			wait(1 + randomfloat (2));	
			self maps\_tankgun_gmi::mgoff();	
		}
	}
}

///
/// Kills player if they leave certain bounds during intro
///

intro_death_field()
{
	trigs = getentarray ("intro_death_field","targetname");
	
	for (i=0;i<trigs.size;i++)
	{
		trigs[i] thread intro_death_field_think();
	}
	
}

intro_death_field_think()
{
	level.jeep endon ("player_on_vehicle");
	
	self waittill ("trigger");
	
	playfx (level.mortar,level.player.origin);
	earthquake(0.5, 3, level.player.origin, 1000);
	level.player playsound ("shell_explosion1");
	level.player dodamage(level.player.health + 100, (0,0,0));
	
	println("^1Killing player (hit death brush)");
}

intro_death_kill()
{
	level.jeep endon ("player_on_vehicle");
	
	level waittill ("intro over");
	wait 20;
	
	playfx (level.mortar,level.player.origin);
	earthquake(0.5, 3, level.player.origin, 1000);
	level.player playsound ("shell_explosion2");
	level.player dodamage(level.player.health + 100, (0,0,0));
	
	println("^1Killing player (took too long)");
}

german_yell(angle1)
{
//	angle1 = (1615,15760,161);
//	angle2 = (1680,16304,161);
//	angle2 = (965,-1518,64);
	german_cart = (1802,4383,133);

	german_88_left = (6505,3186,112);
	german_88_center = (6338,2590,101);
	german_88_center = (5425,3440,85);

	german_yell_1 = spawn("script_origin",(angle1));
	german_yell_2 = spawn("script_origin",(angle1));
	german_yell_3 = spawn("script_origin",(angle1));

	for(i=0;i<10;i++)
	{
		wait (0.1 + randomfloat (0.4));	
		println("^3 ***************  german yells"        + i);
		german_yell_1 playsound("generic_misccombat_german_1");
		wait 2;
		german_yell_2 playsound("generic_misccombat_german_2");
		wait 2;
		german_yell_3 playsound("generic_flankright_german_2");
	}
}

event1_guys_setup()	// guys near truck
{
	//level waittill("intro over");
	level waittill("start old intro spawners");
	germans1_array =[];// this defines it as an array
	germans1_group = getentarray("event1_guys", "groupname");

	for(i=1;i<(germans1_group.size+1);i++)//		
	{
		germans1_array[i] = getent("event1_guy_" + i, "targetname");
		germans1_array_ai[i] = germans1_array[i] stalingradspawn();
		germans1_array_ai[i] waittill ("finished spawning");
		germans1_array_ai[i].pacifist = true;
		germans1_array_ai[i].accuracy = 0;
		germans1_array_ai[i] allowedstances("crouch");
		germans1_array_ai[i] thread e1_node(i);
	}
}

e1_node(i)
{
	if(isalive(self))
	{	
		wait (0.2 + randomfloat (0.9));		
		node = getnode("event1_guy_node_" + i, "targetname");
		self setgoalnode(node);
		self waittill("goal");
		self.pacifist = false;
	}

	if(isalive(self))
	{
		wait 15;
		self delete();
	}
}


//////////////-- INTRO END -- //////////////////////

hittingtree()
{
	//fx = loadfx("fx/explosions/explosion1.efx");

	earthquake(0.25, 3, level.player.origin, 1050);

	level.jeep setspeed (0,10);
	wait .5;
	level.flags["bumpy"] 		= false;		//'true' when the car should be bumpy

	level thread event4_halftrack();

	wait 6;

	level.jeep resumespeed(10,0);
	level.flags["bumpy"] 		= true;		//'true' when the car should be bumpy
	level.jeep thread bumpy();
}

reverse_from_pak44()
{
	level.flags["bumpy"] 		= false;

	wait 5;

	level.flags["bumpy"] 		= true;		
	level.jeep thread bumpy();
	
	wait 5;
}

// starts first tank forcing the car to make a quick right
tankstart()
{
	tank = spawnVehicle( "xmodel/vehicle_tank_tiger_camo", "vclogger", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
//	tank maps\_panzeriv_gmi::init();
	tank maps\_tiger_gmi::init();
	tanktarget1 = getent ("event2_tank_target","targetname");
	tanktarget2 = getent ("willyjeep","targetname");
	path = getVehicleNode ("jl153","targetname");
	tank attachpath(path);
	tank.isalive = 1;
	tank.health = (1000000);
	tank maps\_tankgun_gmi::mgoff();
	tank setTurretTargetEnt(tanktarget1, (0, 0, 0) );
	getent ("tankstart","targetname") waittill ("trigger");

	tank startpath();
	
	tank setspeed(1,15);
	
	wait 2;
	
	tank resumespeed(5);
	
	wait 3;
	
	tank setTurretTargetEnt(tanktarget2, (0, 200, 100) );
	
	wait 6;
	
	tank thread maps\_tiger_gmi::fire();

	wait 15;
	level thread remove_vehicle(tank);
}

event2_support()
{
	getent ("event_2_trigger","targetname") waittill ("trigger");
	if (getcvarint("g_gameskill") != 3)
	{
		node = getnode ("event2_guys_dest","targetname");
	//	getent ("event_2_trigger","targetname") waittill ("trigger");
		germans2 = getentarray("event2_guys", "groupname");
		for(i=0;i<germans2.size;i++)
		{
			germans2_guys_ai[i] = germans2[i] stalingradspawn();
			germans2_guys_ai[i] waittill ("finished spawning");
			germans2_guys_ai[i].pacifist = true;
			germans2_guys_ai[i].accuracy = 0;
			germans2_guys_ai[i].goalradius = 25;
			germans2_guys_ai[i] thread event2_support_think(node);
		}
	}
	
	germans2_crouch = getentarray("event2_guys_crouch", "groupname");
	for(i=0;i<germans2_crouch.size;i++)
	{
		germans2_guys_ai_c[i] = germans2_crouch[i] stalingradspawn();
		germans2_guys_ai_c[i] waittill ("finished spawning");
		if(isalive(germans2_guys_ai_c[i]))
		{
			germans2_guys_ai_c[i].goalradius = 8;
			germans2_guys_ai_c[i].accuracy = 0.05;
			germans2_guys_ai_c[i] allowedstances("crouch");
			//germans2_guys_ai_C[i].runanimplaybackrate = 1.1;
			germans2_guys_ai_c[i] thread event2_death_think_crouch();
		}
	}

}

event2a()
{
	getent ("event_2a_trigger","targetname") waittill ("trigger");
	germans2a = getentarray("event2a_guys", "groupname");
	germans2a_guys_ai = [];
	for(i=0;i<germans2a.size;i++)
	{
		germans2a_guys_ai[i] = germans2a[i] stalingradspawn();
		germans2a_guys_ai[i] waittill ("finished spawning");
		if(isalive(germans2a_guys_ai[i]))
		{
			germans2a_guys_ai[i].pacifist = true;
			germans2a_guys_ai[i].goalradius = 25;
			germans2a_guys_ai[i] allowedstances("stand");
			germans2a_guys_ai[i].runanimplaybackrate = 0.7;
			germans2a_guys_ai[i] thread event2a_death_think();
	//		germans3_guys_ai[i] setgoalnode(node);
	//		germans3_guys_ai[i] thread event2_support_think(node);
		}
	}	

	truck2 = spawnVehicle( "xmodel/vehicle_german_truck_snow", "c_2", "GermanFordTruck" ,(0,0,0), (0,0,0) );
	truck2 maps\_truck_gmi::init();
	path4 = getVehicleNode ("event2a_truck2_path","targetname");
	truck2 attachpath(path4);
	truck2.isalive = 1;
	truck2.health = (10000000);
	truck2 startpath();
	truck2 thread event2b_death_think();

	truck1 = spawnVehicle( "xmodel/v_ge_lnd_halftrack", "c_1", "GermanHalfTrack" ,(0,0,0), (0,0,0) );
	truck1 maps\_truck_gmi::init();
	path3 = getVehicleNode ("event2a_truck1_path","targetname");
	truck1 attachpath(path3);
	truck1.isalive = 1;
	truck1.health = (10000000);
	wait 3;
	truck1 startpath();
	truck1 thread event2a_death_think();
}

event2_death_think_crouch()
{

	if(isalive(self))
	{
		self waittill("goal");
		self.pacifist = false;
		wait 10;
		self delete();
	}
}

event2a_death_think()
{
	if(isAI(self))
	{
		wait 6;
		node = getnode("event2a_guys_dest","targetname");
		self setgoalnode(node);
	}

	if(isalive(self))
	{
		wait 13;
		self delete();
	}
}

event2b()
{
	wait 2;

	germans3 = getentarray("event2b_guys", "groupname");
	germans3_c = getentarray("event2b_guys_crouch", "groupname");
	
	for(i=0;i<germans3_c.size;i++)
	{
		germans3_c_guys_ai[i] = germans3_C[i] stalingradspawn();
		germans3_c_guys_ai[i] waittill("finished spawning");

		if(isalive(germans3_c_guys_ai[i]))
		{
			germans3_c_guys_ai[i].pacifist = true;
			germans3_c_guys_ai[i].goalradius = 25;
			germans3_c_guys_ai[i].accuracy = 0.05;
			germans3_c_guys_ai[i] allowedstances("crouch");
			germans3_c_guys_ai[i] thread animscripts\shared::lookatentity(level.player, 10000000, "alert");
			germans3_C_guys_ai[i] thread event2b_death_think_crouch();
		}
	}
	
	for(i=0;i<germans3.size;i++)
	{
		index = randomint(3);
		germans3_guys_ai[i] = germans3[i] stalingradspawn();
		germans3_guys_ai[i] waittill("finished spawning");

		if(isalive(germans3_guys_ai[i]))
		{
			wait 0.25;
		
			germans3_guys_ai[i].pacifist = true;
			
			if (index == 0)
				germans3_guys_ai[i].pacifist = false;
				
			germans3_guys_ai[i].goalradius = 25;
			germans3_guys_ai[i].accuracy = 0.05;
			germans3_guys_ai[i] allowedstances("stand");
			germans3_guys_ai[i] thread animscripts\shared::lookatentity(level.player, 10000000, "alert");
			germans3_guys_ai[i] thread event2b_death_think();
			germans3_guys_ai[i] thread event2b_goto_nodes();
	//		germans3_guys_ai[i] setgoalnode(node);
	//		germans3_guys_ai[i] thread event2_support_think(node);
		}
	}	
	
	wait 3;
	
	tank3 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "vclogger3", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank3 maps\_panzeriv_gmi::init();
	tanktarget = getent ("willyjeep","targetname");
	path3 = getVehicleNode ("event2b_tank1_path","targetname");
	tank3 attachpath(path3);
	tank3.isalive = 1;
	tank3.health = (1000000);
	tank3 maps\_tankgun_gmi::mgoff();
	tank3 startpath();
	tank3 thread event2b_fire_think();
	tank3 setspeed(5,25);
	tank3 thread event2b_death_think();

	tank4 = spawnVehicle( "xmodel/vehicle_tank_tiger_camo", "vclogger4", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank4 maps\_tiger_gmi::init();
	tanktarget = getent ("willyjeep","targetname");
	path4 = getVehicleNode ("event2b_tank2_path","targetname");
	tank4 attachpath(path4);
	tank4.isalive = 1;
	tank4.health = (1000000);
	tank4 maps\_tankgun_gmi::mgoff();
	tank4 startpath();
	tank4 thread event2b_fire_think();
	tank4 setspeed(6,25);
	tank4 thread event2b_death_think();
}

event2b_goto_nodes()
{
	node = getnode ("event_2b_goto_1","targetname");
	self setgoalnode(node);
	getent ("event_2b_trig_2","targetname") waittill ("trigger");
	
	node = getnode ("event_2b_goto_2","targetname");
	self setgoalnode(node);
	getent ("event_2b_trig_3","targetname") waittill ("trigger");
	
	node = getnode ("event_2b_goto_3","targetname");
	self setgoalnode(node);
	getent ("event_2b_trig_4","targetname") waittill ("trigger");
	
	node = getnode ("event_2b_goto_4","targetname");
	self setgoalnode(node);
}

event2b_fire_think()
{
	while(isalive(self))
	{
		wait (2 + randomfloat (4));
		{
			self setTurretTargetEnt(level.jeep, (100, 50, 100) );
			self thread maps\_tiger_gmi::fire();
		}
	}
}

event2b_death_think()
{
	self endon ("death");
	if(isalive(self))
	{
		wait 20;
		self delete();
	}
}

event2b_death_think_crouch()
{
	self endon ("death");
	if(isalive(self))
	{
		self waittill ("goal");
		self.pacifist = false;
		wait 15;
		self delete();
	}
}


event2_support_think(node)
{
	newnode = getnode("event2_guys_dest2","targetname");
	
	rand = randomint(2);
	
	if (rand == 0)
		self.pacifist = false;
	
	self setgoalnode(node);
	self thread animscripts\shared::lookatentity(level.player, 10000000, "alert");

	getent("event2_goto","targetname") waittill ("trigger");

	self setgoalnode(newnode);

	self waittill("goal");

	if(isalive(self))
	{
		wait 8;
		self delete();
	}
}

// controls all events/anims off of the nodes in the rail 
car1()
{
	level waittill ("jeep go");
	
	level thread tankstart();

	//anim 
	//level.jeep setWaitNode(getVehicleNode("jl4","targetname"));
	//level.jeep waittill ("reached_wait_node");
	//level notify ("watch out vo");
		
	level.jeep setWaitNode(getVehicleNode("jl6","targetname"));
	level.jeep waittill ("reached_wait_node");

	//level.enderanim  = 3;
	//thread maps\bastogne1_anim::ender_shoot( 2,3.7);
	level thread maps\bastogne1_anim::ender_attack1();
	
	level.jeep setWaitNode(getVehicleNode("jl10","targetname"));
	level.jeep waittill ("reached_wait_node");
	level notify ("watch out vo");
	
	level.jeep setWaitNode(getVehicleNode("jl11","targetname"));
	level.jeep waittill ("reached_wait_node");
	level notify ("hq vo");
	level thread maps\bastogne1_anim::moody_speak();
	//level notify ("watch it vo");
	
	//wait 0.25;

	level.jeep setWaitNode(getVehicleNode("jl14","targetname"));
	level.jeep waittill ("reached_wait_node");
	//level thread maps\bastogne1_anim::play_rand_anim(3,undefined,undefined);	// drive by
	level.ender notify ("animdone");
	//level.enderanim = 3;
	//level thread maps\bastogne1_anim::ender_shoot( 2,4.8);
	//level thread maps\bastogne1_anim::ender_attack1();
	level notify ("watch it vo");
	
	level.jeep setWaitNode(getVehicleNode("jl15","targetname"));
	level.jeep waittill ("reached_wait_node");
	level thread maps\bastogne1_anim::moody_drive_duck();   			// duck tree
	//level thread maps\bastogne1_anim::ender_attack1();
	
	level.jeep setWaitNode(getVehicleNode("jl16","targetname"));
	level.jeep waittill ("reached_wait_node");
	level thread maps\bastogne1_anim::ender_attack1();
	
	// guys after tank
	level.jeep setWaitNode(getVehicleNode("jl17","targetname"));
	level.jeep waittill ("reached_wait_node");
	level thread event2b();

	wait 0.25;

	level thread convoy_begin();

	level thread fog_changer();

	//anim
	level.jeep setWaitNode(getVehicleNode("jl21","targetname"));
	level.jeep waittill ("reached_wait_node");
	level notify ("eyes open vo");

	level.jeep setWaitNode(getVehicleNode("jl23","targetname"));
	level.jeep waittill ("reached_wait_node");
	level thread maps\bastogne1_anim::moody_drive_duck();   			// duck tree

	level.jeep setWaitNode(getVehicleNode("jl24","targetname"));
	level.jeep waittill ("reached_wait_node");
	//level thread maps\bastogne1_anim::play_rand_anim(9,undefined,undefined);	// drive by
	//level.enderanim =3;
	//level thread maps\bastogne1_anim::ender_shoot( 2,6);
	level thread maps\bastogne1_anim::ender_attack2();
	level notify ("to the right vo");

	level.jeep setWaitNode(getVehicleNode("jl25","targetname"));
	level.jeep waittill ("reached_wait_node");

	level.jeep setWaitNode(getVehicleNode("jl30","targetname"));
	level.jeep waittill ("reached_wait_node");
	level thread maps\bastogne1_anim::moody_drive_duck();   			// duck tree

	level.jeep setWaitNode(getVehicleNode("jl31","targetname"));
	level.jeep waittill ("reached_wait_node");
	level notify ("dead ahead vo");
	
	level.jeep setWaitNode(getVehicleNode("jl32","targetname"));
	level.jeep waittill ("reached_wait_node");
	
	//anim
	level.jeep setWaitNode(getVehicleNode("jl33","targetname"));
	level.jeep waittill ("reached_wait_node");
//	level thread maps\bastogne1_anim::play_rand_anim(5,undefined,undefined);	// convoy attack1
//	level thread maps\bastogne1_anim::ender_shoot( 2,5.3); DONT UPDATE
	// guys after tank
	level.jeep setWaitNode(getVehicleNode("jl34","targetname"));
	level.jeep waittill ("reached_wait_node");
	level thread event4_setup();
	level notify ("passright vo");
	level thread maps\bastogne1_anim::ender_attack3();

	level.jeep setWaitNode(getVehicleNode("jl35","targetname"));
	level.jeep waittill ("reached_wait_node");
	//level notify ("stop yakin vo");
	
	level.jeep setWaitNode(getVehicleNode("jl36","targetname"));
	level.jeep waittill ("reached_wait_node");
	
	//level.jeep setWaitNode(getVehicleNode("jl35","targetname"));
	//level.jeep waittill ("reached_wait_node");
	//level thread maps\bastogne1_anim::play_rand_anim(5,undefined,undefined);	// drive by
	//level.enderanim  =5;
	//level thread maps\bastogne1_anim::ender_shoot(0,5.5);
	
	wait 1;
	level notify ("stop yakin vo");
	
	level.jeep setWaitNode(getVehicleNode("jl37","targetname"));
	level.jeep waittill ("reached_wait_node");
		
	level.jeep setWaitNode(getVehicleNode("jl38","targetname"));
	level.jeep waittill ("reached_wait_node");
	level notify ("to the left vo");

	level.jeep setWaitNode(getVehicleNode("jl39","targetname"));
	level.jeep waittill ("reached_wait_node");
	level thread delete_convoy_ai();
	angle1 = getent("event4_guy_2","targetname");
	
	level notify("jeep_event4_combat");
	level thread german_yell(angle1.origin);

	level thread maps\bastogne1_anim::moody_drive_tree_crash();
	level thread maps\bastogne1_anim::ender_crash();
	level.jeep playsound ("dirt_skid");
	
// --- jeep crash here -------//

	//wait 0.25;
	level.jeep setWaitNode(getVehicleNode("jl142","targetname"));
	level.jeep waittill ("reached_wait_node");
	wait 0.1;
	level.jeep playsound ("vehicle_impact");
	level thread tree_crash_restart_sounds();
	
	level.jeep setWaitNode(getVehicleNode("jl143","targetname"));
	level.jeep waittill ("reached_wait_node");	
	level thread hittingtree();
	level notify("moody_stalled_vo");
	level notify("event 4b spawn in");

	wait 1.5;
	level notify ("offtoright vo");	
	
	wait 1.5;

	level notify("moody_almost_vo");	
	
	wait 3;
	
	println ("^1BEFORE RAND ANIM FUNC ",level.enderanim);
	//level thread maps\bastogne1_anim::play_rand_anim(8,undefined,undefined);	// drive by
	//level.enderanim =5;
	//level thread maps\bastogne1_anim::ender_shoot(2,7);
	//level thread maps\bastogne1_anim::ender_attack4();
	
	//wait 2;
	
	//level.jeep setWaitNode(getVehicleNode("jl144","targetname"));
	//level.jeep waittill ("reached_wait_node");
	
	level.jeep setWaitNode(getVehicleNode("jl150","targetname"));
	level.jeep waittill ("reached_wait_node");
	level notify ("hitit vo");
	level notify("fog_change2"); // fog_changer
	
	level.jeep setWaitNode(getVehicleNode("jl43","targetname"));
	level.jeep waittill ("reached_wait_node");
	level notify ("dontlikethis vo");
	
	level.jeep setWaitNode(getVehicleNode("jl47","targetname"));
	level.jeep waittill ("reached_wait_node");
	//level thread maps\bastogne1_anim::play_rand_anim(3,undefined,undefined);	// drive by
	//level.enderanim=3;
	//level thread maps\bastogne1_anim::ender_shoot( 2,4.8);
	level thread maps\bastogne1_anim::ender_attack1();
	//wait 1;
	level notify ("whats to like vo");
	getent("event5_trig","targetname") waittill("trigger");


	level thread event5_setup();


//	level.jeep setWaitNode(getVehicleNode("jl153","targetname"));
//	level.jeep waittill ("reached_wait_node");


	
	level.jeep setWaitNode(getVehicleNode("jl53","targetname"));
	level.jeep waittill ("reached_wait_node");
	level notify("moody_shortcut_vo");
	level thread maps\bastogne1_anim::moody_speakshort();
	
	level.jeep setWaitNode(getVehicleNode("jl57","targetname"));
	level.jeep waittill ("reached_wait_node");


	level.jeep setWaitNode(getVehicleNode("jl61","targetname"));
	level.jeep waittill ("reached_wait_node");	
	level notify("88_guys_attack");
	//level thread event5b_setup();
	angle1 = (6338,2590,101);
	level thread german_yell(angle1);

	level thread maps\bastogne1_anim::moody_bastogne1_reverse2forward();

println("^1 reverse to forward threaded");

	//wait 0.05;
	level.jeep setWaitNode(getVehicleNode("jl62","targetname"));
	level.jeep waittill ("reached_wait_node");
	level notify("ender_shortcut2_vo");
	wait 1;
	level.ender playsound ("weap_gewehr43_fire");
	level thread maps\bastogne1_anim::ender_shot_and_wounded();		// shot and wounded at this point
	
	level.jeep setWaitNode(getVehicleNode("jl63","targetname"));
	level.jeep waittill ("reached_wait_node");
	//level notify("ender_shortcut2_vo");
	level notify("moody_heregoes_vo");
	level notify("fog_change3"); // fog_changer
	
	level.jeep setWaitNode(getVehicleNode("jl64","targetname"));
	level.jeep waittill ("reached_wait_node");
	//level.ender playsound ("weap_m1garand_fire");
	//level thread maps\bastogne1_anim::ender_shot_and_wounded();		// shot and wounded at this point
	wait 0.5;
println("^1 ender_shot_and_wounded threaded");

	//maps\_spawner_gmi::kill_spawnerNum(1); // kill spawner at fence near tree crash

	//level.jeep setWaitNode(getVehicleNode("jl69","targetname"));
	//level.jeep waittill ("reached_wait_node");	
	
	//wait 0.05;

	// deletes group 5 beggining
	level.jeep setWaitNode(getVehicleNode("jl73","targetname"));
	level.jeep waittill ("reached_wait_node");	
	level notify("moody_wherehit_vo");
	//level thread delete_event5a_guys();

	//level thread maps\bastogne1_anim::play_rand_anim(7,undefined,undefined);	// duck tree
	//level.enderanim=7;
	//level thread maps\bastogne1_anim::ender_duck();
	//peugeot_wound_hold
	
	//wait 0.05;

	level.jeep setWaitNode(getVehicleNode("jl76","targetname"));
	level.jeep waittill ("reached_wait_node");	
	//level thread event5d_setup();
	level notify ("ender_watchout vo");


	level.jeep setWaitNode(getVehicleNode("jl81","targetname"));
	level.jeep waittill ("reached_wait_node");
	level notify("moody_wherehit2_vo");
	level thread maps\bastogne1_anim::driver_hold();
	
	//wait 0.05;

	level.jeep setWaitNode(getVehicleNode("jl86","targetname")); // guys in forest after 
	level.jeep waittill ("reached_wait_node");	
	level thread event5e_setup();
	level notify("moody_oh_baby_vo");

	

	level.jeep setWaitNode(getVehicleNode("jl108","targetname"));
	level.jeep waittill ("reached_wait_node");

	//level thread maps\bastogne1_anim::driver_hold();

	level notify("fog_change4"); // fog_changer

	level.jeep setWaitNode(getVehicleNode("jl118","targetname")); // guys in forest after 
	level.jeep waittill ("reached_wait_node");
	level notify("moody_clear_vo");
	level notify("fog_change4"); // fog_changer
	level thread maps\bastogne1_anim::driver_hold();

	level.jeep setWaitNode(getVehicleNode("jl123","targetname"));
	level.jeep waittill ("reached_wait_node");

	//level thread maps\bastogne1_anim::driver_hold();

	level.jeep waittill ("reached_end_node");	

	level thread jeep_get_out();
}

tree_crash_restart_sounds()
{
	wait 3.9;
	level.jeep playsound ("jeep_start");
	wait 1.1;
	level.jeep playsound ("jeep_start");
	wait 3;
	level.jeep playsound ("dirt_skid");
	wait 4;
	level.jeep playsound ("dirt_skid");
}

fog_changer()
{
	

	
	// main road passing convoy
	//if (getcvar("scr_gmi_fast") == 0)
	//{
		setCullFog (0, 13000, .68, .73, .85, 25 );
		println("^6 ************ cullfog set to 13000 ************");
	//}
	//else
	//{
	//	setCullFog (0, 7000, .68, .73, .85, 14 );
	//	println("^6 ************ cullfog set to 7000 ************");
	//}
	
	level waittill("fog_change2"); // just before pak43

	//if (getcvar("scr_gmi_fast") == 0)
	//{
		setCullFog (0, 6000, .68, .73, .85, 10 );
		println("^6 ************ cullfog set to 6000 ************");
	//}
	//else
	//{
	//	setCullFog (0, 3000, .68, .73, .85, 9 );
	//	println("^6 ************ cullfog set to 3000 ************");
	//}

	level waittill("fog_change3");	// entering last stretch of road
	
	//if (getcvar("scr_gmi_fast") == 0)
	//{
		setCullFog (0, 13000, .68, .73, .85, 25 );
		println("^6 ************ cullfog set to 13000 ************");
	//}
	//else
	//{
	//	setCullFog (0, 7000, .68, .73, .85, 7 );
	//	println("^6 ************ cullfog set to 7000 ************");
	//}

	level waittill("fog_change4");	// entering barn

	//if (getcvar("scr_gmi_fast") == 0)
	//{
	
		setCullFog (0, 6000, .68, .73, .85, 25 );
		println("^6 ************ cullfog set to 6000 ************");

	//}
	//else
	//{
	//	setCullFog (0, 3300, .68, .73, .85, 22 );
	//	println("^6 ************ cullfog set to 3300 ************");
	//}
}

convoy_setup()
{	
	trigs = getentarray("truck attack", "targetname");
	for(i=0;i<trigs.size;i++)
	{
		if ( (isdefined (self.script_noteworthy)) && (self.script_noteworthy == "truck1") )
		{
			level thread convoy_trucks_wait();
		}

		if ( (isdefined (self.script_noteworthy)) && (self.script_noteworthy == "truck2") )
		{
			level thread convoy_trucks_wait();	
		}
	}
}

convoy_trucks_wait()
{
	
}	

// this is the convoy event setup
convoy_begin()
{
	getent ("startconvoy","targetname") waittill ("trigger");


	level notify("clean_up1");

	halftrack = spawnVehicle( "xmodel/v_ge_lnd_halftrack", "c_1", "GermanHalfTrack" ,(0,0,0), (0,0,0) );
	halftrack maps\_truck_gmi::init();
	path = getVehicleNode ("convoy_path","targetname");
	halftrack attachpath(path);
	halftrack.isalive = 1;
	halftrack.health = (1000000);
	halftrack startpath();

	wait 3;
	
	truck1 = spawnVehicle( "xmodel/vehicle_german_truck_covered", "c_2", "GermanFordTruck" ,(0,0,0), (0,0,0) );
	truck1 maps\_truck_gmi::init();
	path = getVehicleNode ("convoy_path","targetname");
	truck1 attachpath(path);
	truck1.isalive = 1;
	truck1.health = (10000);
	truck1 thread enemy_vehicle_paths_mod(path);
	truck1 startpath();
	
	wait 3;
	
	trucktrig = getent ("ta_1","script_noteworthy");
	trucktrig useBy(level.player);

	wait 3;

	truck2 = spawnVehicle( "xmodel/vehicle_german_truck_covered", "c_2", "GermanFordTruck" ,(0,0,0), (0,0,0) );
	truck2 maps\_truck_gmi::init();
	path = getVehicleNode ("convoy_path","targetname");
	truck2 attachpath(path);
	truck2.isalive = 1;
	truck2.health = (10000);
	truck2 thread enemy_vehicle_paths_mod(path);
	truck2 startpath();

	wait 4;

	level notify ("kubelwagon start");
	
	level thread convoy_tank_spawner();
	
	wait 45;

	level thread remove_vehicle(halftrack);
	level thread remove_vehicle(truck1);
	level thread remove_vehicle(truck2);
}

convoy_tank_spawner()
{
	trucktrig = getent ("ta_2","script_noteworthy");
	trucktrig useBy(level.player);
	
	wait 5;
	
	tankp1 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "vclogger3", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tankp1 maps\_panzeriv_gmi::init();
	tankp1 maps\_tankgun_gmi::mgoff();
	path = getVehicleNode ("convoy_path_tanks","targetname");
	tankp1 attachpath(path);
	tankp1.isalive = 1;
	tankp1.health = (10000);
	tankp1 startpath();
	
	wait 5;
	
	tankp2 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "vclogger3", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tankp2 maps\_panzeriv_gmi::init();
	tankp2 maps\_tankgun_gmi::mgoff();
	path = getVehicleNode ("convoy_path_tanks","targetname");
	tankp2 attachpath(path);
	tankp2.isalive = 1;
	tankp2.health = (10000);
	tankp2 startpath();
	
	wait 15;
	
	level thread remove_vehicle(tankp1);
	level thread remove_vehicle(tankp2);
}

german_truck (trigger)
{	
	trigger waittill ("trigger");
	truck = getent (trigger.target,"targetname");
	driver = getent (truck.target,"targetname");
	
	truck maps\_truck_gmi::init();
	truck maps\_truck_gmi::attach_guys(undefined,driver);
	path = getVehicleNode(truck.target,"targetname");
	
	truck thread enemy_vehicle_paths_mod(path);
	
	truck attachpath (path);
	truck startPath();
	node = path;

	truck.health = 10000;
	
		/*while (1)
		{
			node = getvehiclenode(node.target,"targetname");
			//node = getvehiclenode (node.target,"targetname");
			//truck setWaitNode (node);
			//truck waittill ("reached_wait_node");
			if (isdefined (node.script_noteworthy))
			{
				break;
				truck setWaitNode (node);
			}
		}*/
		

		
				
	//truck notify ("unload");
	truck stopEngineSound();
	truck waittill ("reached_end_node");
	//truck disconnectpaths();
	
	wait 1;
	level thread remove_vehicle(truck);
}

delete_convoy_ai()
{
	convoy_group = getentarray("convoy_ai", "groupname");
	for(i=1;i<(convoy_group.size+1);i++)	
	{
		if(isalive(convoy_group[i]))
		{
			convoy_group[i] delete();
		}
					
	}
	
	wait 26;
	
	convoy_group = getentarray("convoy_ai_2", "groupname");
	for(i=1;i<(convoy_group.size+1);i++)	
	{
		if(isalive(convoy_group[i]))
		{
			convoy_group[i] delete();
		}
					
	}
		
}

remove_vehicle(vehicle)
{
	stopattachedfx(vehicle);
	wait 1;
	vehicle delete();
}

event4_setup()	// guys near truck
{
	germans4_array =[];// this defines it as an array
	germans4_group = getentarray("event4_guys", "groupname");
	for(i=1;i<(germans4_group.size+1);i++)//		
	{
		germans4_array[i] = getent("event4_guy_" + i, "targetname");		
		germans4_array_ai[i] = germans4_array[i] stalingradspawn();
		germans4_array_ai[i].pacifist = true;
		germans4_array_ai[i].goalradius = 4;
		//germans4_array_ai[i] thread e4_cover_combat(i);
	

		if(isdefined(germans4_array[i].targetname))
		{
			germans4_array_ai[i] thread e4_guys_push_think(germans4_array[i].targetname);
		}

		germans4_array_ai[i] thread e4_cover_jeep_combat(i);
	}
}

event4_halftrack()
{
	getent ("event_4a_trig","targetname") waittill ("trigger");
	ht1 = getent ("halftrack_p43","targetname");
	ht1 thread maps\_halftrack_gmi::init("reached_end_node");
	ht1.isalive = 1;
	ht1.health = (1000000);
	ht1 startpath();
	//ht1 thread maps\bastogne1_add::mg42_halftrack_modulate();
	ht1 waittill ("reached_end_node");
	//ht1 notify ("death",level.player);
	ht1 delete();
	
	/*halftrack = spawnVehicle( "xmodel/v_ge_lnd_halftrack", "halftrack", "GermanHalfTrack" ,(0,0,0), (0,0,0) );
	halftrack maps\_halftrack_gmi::init();
	path = getVehicleNode ("event4_tank1_path","targetname");
	halftrack attachpath(path);
	halftrack.isalive = 1;
	halftrack.health = (1000000);
	halftrack startpath();
	wait 25;
	halftrack delete();*/
}

e4_guys_push_think(targetname)
{
	if(isdefined(targetname))
	{ 
		if(targetname == "event4_guy_2")
		{
			self.animname = "kubelwagonpush";
			self animscripts\shared::putGunInHand ("none");	
			self.allowdeath = true;
			self thread anim_loop_solo(self,"pusherleft_loop", undefined, "end anim1");
		}

		if(targetname == "event4_guy_3")
		{
			self.animname = "kubelwagonpush";
			self animscripts\shared::putGunInHand ("none");	
			self.allowdeath = true;
			self thread anim_loop_solo(self,"pusherright_loop", undefined, "end anim1");
		}

		if(targetname == "event4_guy_1")
		{
			self.animname = "officer1";
			self animscripts\shared::putGunInHand ("none");	
			self.allowdeath = true;
			self thread anim_loop_solo(self,"officer_loop", undefined, "end anim1");
//			self thread anim_loop_solo(self,"officer_gogogo", undefined, "end anim1");
		}
	}

	self waittill("end anim1");
}

e4_cover_combat(i)
{
	self waittill("combat");
	if(isalive(self))
	{
		self notify("end anim1");
		node = getnode("event4_guy_node_" + i, "targetname");
		self setgoalnode(node);	
		self waittill("goal");
		self.pacifist = false;
	}
}

e4_cover_jeep_combat(i)
{
	level waittill("jeep_event4_combat");
	if(isalive(self))
	{			
		self notify("end anim1");
		node = getnode("event4_guy_node_" + i, "targetname");
		self setgoalnode(node);	
		self waittill("goal");
		self.pacifist = false;
	}
	
	wait 28;
	if(isalive(self))
		self delete();
}

event4a_setup_control()
{
	getent ("event_4a_trig","targetname") waittill ("trigger");
	level thread event4a_setup();
}

//
// Guys coming from over wall
//
event4a_setup()	// guys near truck
{
	spawner_guy_group = getentarray("event4a_guys", "groupname");

	for(i=0;i<5;i++)		
	{
		spawn_index = i+1;
		index = randomint (3);
		spawner_guy = getent("event4a_guy"+spawn_index, "targetname");		
		guy = spawner_guy stalingradspawn();
		guy waittill ("finished spawning");
		//wait randomfloatrange (0.5, 1.5);			// So they don't look the same the 2nd time around
		guy.pacifist = true;
		
		if (index == 0)
			guy.pacifist = false;
			
		guy.goalradius = 4;
		
		node = getnode ("event4a_guy"+spawn_index+"_node","targetname");
		guy setgoalnode (node);
		
		guy thread event4a_death_think();
	}
}

//
// Death to guys coming from over wall
//
event4a_death_think()
{
	self endon ("death");
	
	node = getnode ("event4a_guy_main_node","targetname");
	
	self waittill ("goal");
	
	if (isalive(self))
		self setgoalnode (node);
	
	wait 8;
	
	if (isalive(self))
		self delete();	
		
}


event4b_setup()
{
	level waittill("event 4b spawn in");
	guys = getentarray("event4b_guys","groupname");
	
	for (i=1;i<guys.size+1;i++)
	{
		the_spawner = getent("event4b_guy"+i,"targetname"); 
		the_spawner.node_num = i;
		the_spawner thread event4b_spawners();
		wait 0.25;
	}
}

event4b_spawners()
{
	guy = self stalingradspawn();
	guy waittill ("finished spawning");
	guy.node_num = self.node_num;
	guy thread event4b_guy_setup();
	guy.spawner_ent = self;
	guy thread event4b_guy_death();
	

	
	//wait 8;
	
	//guy = self stalingradspawn();
	//guy waittill ("finished spawning");
	//guy.node_num = self.node_num;
	//guy thread event4b_guy_setup();
}

event4b_guy_setup()
{
	self endon("death");
	self.goalradius = 8;
	self.pacifist = true;
	self allowedstances ("stand","crouch");
	self thread event4b_ramp_up_accuracy();
	node = getnode ("event4b_node"+self.node_num,"targetname");
	self setgoalnode(node);
	self waittill("goal");
	self.pacifist = false;
	
	node = getnode ("event4b_node"+self.node_num+"_2","targetname");
	self setgoalnode(node);
}

event4b_guy_death()
{
	self waittill("death");
	spawner_ent = self.spawner_ent;
	
	guy = spawner_ent stalingradspawn();
	guy waittill ("finished spawning");
	guy.node_num = self.node_num;
	guy thread event4b_guy_setup();
	guy.spawner_ent = self;
}

event4b_ramp_up_accuracy()
{
	self endon("death");
	self.accuracy = 0;
	wait 7;
	while (self.accuracy < 0.15)
	{
		self.accuracy = self.accuracy + 0.05;
		wait 2;
	}
	
	wait 1;
	self.accuracy = 0;
}

// event 5 germans at 88 working and caught completely off guard

event5_setup()	
{
	germans5_array =[];
	germans5_group = getentarray("event5a_guys", "groupname");
	for(i=1;i<(germans5_group.size+1);i++)		
	{
		germans5_array[i] = getent("event5_guy_" + i, "targetname");	
		germans5_array_ai[i] = germans5_array[i] stalingradspawn();
		germans5_array_ai[i] waittill ("finished spawning");
		germans5_array_ai[i].pacifist = true;
		germans5_array_ai[i].allowdeath = true;
		germans5_array_ai[i].accuracy = 0.1;
		germans5_array_ai[i].accuracystationarymod = 0.1;
		//germans5_array_ai[i].goalradius = 7000;
		//germans5_array_ai[i].maxsightdistsqrd = 1440000;
		if(isdefined(germans5_array[i].targetname))
		{
			germans5_array_ai[i] thread e5_guy4_lean_think(germans5_array[i].targetname);
			
			germans5_array_ai[i] thread e5_cover_combat(i,germans5_array[i].targetname);
			//else if (germans5_array[i].targetname == event5_guy_9)
			//{
			//	germans5_array_ai[i] thread e5_guy_9_reaction(germans5_array[i].targetname);
			//}
		}
		//germans5_array_ai[i] thread e5_combat(i);
	}
	
	wait 7;
	
	level thread event5_farmhouse_setup();
	
}

event5_farmhouse_setup()	
{
	germans5_fh_array =[];
	germans5_fh_group = getentarray("event5a_guys_farmhouse", "groupname");
	for(i=1;i<(germans5_fh_group.size+1);i++)		
	{
		germans5_fh_array[i] = getent("event5_fh_guy" + i, "targetname");	
		germans5_fh_array_ai[i] = germans5_fh_array[i] stalingradspawn();
		germans5_fh_array_ai[i] waittill ("finished spawning");
		germans5_fh_array_ai[i].goalradius = 4;
		germans5_fh_array_ai[i].accuracy = 0;
		germans5_fh_array_ai[i].accuracystationarymod = 0;
	}
}

e5_cover_combat(i, targetname)
{
	//level waittill("88_guys_attack");
	level waittill("event5 damaged");
	if(isalive(self))
	{
		wait (randomfloat (1.5));			
		self notify("end anim");
		
		if (isdefined(targetname))
		{
			if (targetname == "event5_guy_9")
			{
				self allowedstances ("prone");
			}
			if (targetname == "event5_guy_8")
			{
				self allowedstances ("prone");
			}
			if (targetname == "event5_guy_1")
			{
				node = getnode("event5_guy_node_1", "targetname");
				self setgoalnode(node);	
			}
			if (targetname == "event5_guy_2")
			{
				node = getnode("event5_guy_node_2", "targetname");
				self setgoalnode(node);	
			}
			if (targetname == "event5_guy_3")
			{
				self.pacifist = false;
				self allowedstances ("crouch","stand");
				node = getnode("event5_guy_node_3", "targetname");
				self setgoalnode(node);	
			}
			if (targetname == "event5_guy_4")
			{
				self allowedstances ("stand");
				node = getnode("event5_guy_node_4", "targetname");
				self setgoalnode(node);	
			}
			if (targetname == "event5_guy_5")
			{
				self allowedstances ("stand");
				node = getnode("event5_guy_node_5", "targetname");
				self setgoalnode(node);
			}
			if (targetname == "event5_guy_6")
			{
				self allowedstances ("stand");
				node = getnode("event5_guy_node_6", "targetname");
				self setgoalnode(node);
			}
			if (targetname == "event5_guy_7")
			{
				self.pacifist = false;
				self allowedstances ("crouch","stand");
				node = getnode("event5_guy_node_7", "targetname");
				self setgoalnode(node);	
			}
		}
		else
		{
			node = getnode("event5_guy_node_" + i, "targetname");
			self setgoalnode(node);	
			self waittill("goal");
			self.pacifist = false;	
		}
		
	}
}

//------------------anim functions begin------------------//

e5_guy4_lean_think(targetname) // on wheel well
{
	if(isdefined(targetname))
	{ 
		if(targetname == "event5_guy_7")
		{
			self.allowdeath = true;
			self.goalradius = 0;
			self.walkdist = 9999;
			patrolwalk[0] = %patrolwalk_bounce;
			patrolwalk[1] = %patrolwalk_tired;
			patrolwalk[2] = %patrolwalk_swagger;
			self.walk_noncombatanim = maps\_utility_gmi::random(patrolwalk);
			self.walk_noncombatanim2 = maps\_utility_gmi::random(patrolwalk);
			self animscripted("scripted_animdone", self.origin, self.angles, self.walk_noncombatanim);
			self waittill("scripted_animdone");
		}
		
		if(targetname == "event5_guy_3")
		{
			self.allowdeath = true;
			self.goalradius = 0;
			self.walkdist = 9999;
			patrolwalk[0] = %patrolwalk_bounce;
			patrolwalk[1] = %patrolwalk_tired;
			patrolwalk[2] = %patrolwalk_swagger;
			self.walk_noncombatanim = maps\_utility_gmi::random(patrolwalk);
			self.walk_noncombatanim2 = maps\_utility_gmi::random(patrolwalk);
			self animscripted("scripted_animdone", self.origin, self.angles, self.walk_noncombatanim);
			self waittill("scripted_animdone");
		}
		
		
		if(targetname == "event5_guy_4")
		{
			self.animname = "leaner1";
			self animscripts\shared::putGunInHand ("none");	
			self.allowdeath = true;
			self thread anim_loop_solo(self,"lean_loop", undefined, "end anim");
			self thread animscripts\shared::lookatentity(level.player, 10000000, "alert");
		}

		if(targetname == "event5_guy_5")
		{
			self.animname = "waiting1";
			self animscripts\shared::putGunInHand ("none");	
			self.allowdeath = true;
			self thread anim_loop_solo(self,"guy2_wait_loop", undefined, "end anim");
		}

		if(targetname == "event5_guy_9")
		{
			self.animname = "bed1";
			self animscripts\shared::putGunInHand ("none");	
			self.allowdeath = true;
			self thread anim_loop_solo(self,"guy1_bed_loop", undefined, "end anim");
		}

		if(targetname == "event5_guy_1")
		{
			self.animname = "lifter1";
			self animscripts\shared::putGunInHand ("none");	
			self.allowdeath = true;
			self thread anim_loop_solo(self,"guy1_lift_loop", undefined, "end anim");
		}

		if(targetname == "event5_guy_2")
		{
			self.animname = "lifter2";
			self animscripts\shared::putGunInHand ("none");	
			self.allowdeath = true;
			self thread anim_loop_solo(self,"guy2_lift_loop", undefined, "end anim");
		}

		if(targetname == "event5_guy_8")
		{
			crate = spawn("script_model", self.origin);
			crate setmodel("xmodel/crate_misc2");
			tag_angles = self gettagangles("TAG_WEAPON_LEFT");
			tag_origin = self gettagorigin("TAG_WEAPON_LEFT");
			crate.angles = tag_angles;
			crate.origin = tag_origin;
			crate linkto(self, "TAG_WEAPON_LEFT",  (0,0,-25), (0,0,0));
			
			self.animname = "crate1";
			self animscripts\shared::putGunInHand ("none");	
			self.allowdeath = true;
			self thread anim_loop_solo(self,"guy2_crate2_beg", undefined, "end anim");
		}
	}

	self waittill("end anim");

	if(isdefined(targetname))
	{ 
		if(targetname == "event5_guy_4")
		{
			if(isAlive(self)) // check to see if alive or comment out!
			{
				self.animname = "leaner1";
				self animscripts\shared::putGunInHand ("none");	
				self.allowdeath = true;
		//		self thread anim_single_solo(level.moody,"On_me");
				self thread anim_single_solo(self,"lean_end");
		//		self thread anim_single_solo(self,"lean_loop", undefined, "end anim");
			}
		}

		if(targetname == "event5_guy_5")
		{
			if(isAlive(self)) // check to see if alive or comment out!
			{
				self.animname = "waiting1";
				self animscripts\shared::putGunInHand ("none");	
				self.allowdeath = true;
		//		self thread anim_single_solo(level.moody,"On_me");
				self thread anim_single_solo(self,"guy2_wait_end");
		//		self thread anim_single_solo(self,"lean_loop", undefined, "end anim");
			}
		}

		if(targetname == "event5_guy_9")
		{
			if(isalive(self)) // check to see if alive or comment out!
			{
				self.animname = "bed1";
				self animscripts\shared::putGunInHand ("none");	
				self.allowdeath = true;
		//		self thread anim_single_solo(level.moody,"On_me");
				self thread anim_single_solo(self,"guy1_bed_end");
		//		self thread anim_single_solo(self,"lean_loop", undefined, "end anim");
			}
		}

		if(targetname == "event5_guy_1")
		{
			if(isalive(self)) // check to see if alive or comment out!
			{
				self.animname = "lifter1";
				self animscripts\shared::putGunInHand ("none");	
				self.allowdeath = true;
		//		self thread anim_single_solo(level.moody,"On_me");
				self thread anim_single_solo(self,"guy1_lift_end");
		//		self thread anim_single_solo(self,"lean_loop", undefined, "end anim");
			}
		}

		if(targetname == "event5_guy_2")
		{
			if(isalive(self)) // check to see if alive or comment out!
			{
				self.animname = "lifter2";
				self animscripts\shared::putGunInHand ("none");	
				self.allowdeath = true;
		//		self thread anim_single_solo(level.moody,"On_me");
				self thread anim_single_solo(self,"guy2_lift_end");
		//		self thread anim_single_solo(self,"lean_loop", undefined, "end anim");	
			}
		}

		if(targetname == "event5_guy_8")
		{
			if(isalive(self)) // check to see if alive or comment out!
			{
				self.animname = "crate1";
				self animscripts\shared::putGunInHand ("none");	
				self.allowdeath = true;
		//		self thread anim_single_solo(level.moody,"On_me");
				self thread anim_loop_solo(self,"guy2_crate2_loop", undefined, "end anim");
		//		self thread anim_single_solo(self,"guy2_crate2_beg");
		//		self thread anim_single_solo(self,"lean_loop", undefined, "end anim");
			}
		}


		if(targetname == "whoever_else_you_want")
		{
			// insert other animations here.
		}

	}

	
}

e5_guy5_wait1_think() // same truck waiting for box from back of truck
{
	if(germans5_array_ai[i].targetname == "event5_guy_5")
	{
		event5_guy_5.animname = "waiter1";
		event5_guy_5 animscripts\shared::putGunInHand ("none");	
		event5_guy_5.allowdeath = true;
		event5_guy_5 thread anim_loop_solo(event5_guy_5,"guy2_wait_loop", undefined, "end anim");	
	}
}

e5_guy_9_reaction(targetname)
{
	self endon ("death");
	level waittill("event5 damaged");
	if (isalive(self))
	{
		self.pacifist = true;
		self allowedstances ("prone");
	}
}

e5_damage_trigger()
{
	getent("event5_trig_fire","targetname") waittill ("trigger");
	while (1)
	{
		if(level.player attackButtonPressed())
		{
			level notify ("event5 damaged");
			break;
		}
		wait 0.05;
	}

}

e5_regular_trigger()
{
	getent("event_5b_trigger","targetname") waittill ("trigger");
	level notify ("event5 damaged");
}

spotter_anim_think()
{
	wait 6;
	self.animname = "spotter";
	wait 0.05;
	self animscripts\shared::putGunInHand ("none");
//	guy1 thread anim_loop_solo(guy1, "map_read1", "TAG_ORIGIN", "o1 stop anim", table);	
	self.allowdeath = true;
	self thread anim_loop_solo(self,"spot_anim", undefined, "end anim");	
}	

// setting up anims for all the guys doing different things at different positions


//------------------anim functions end------------------//



delete_event5a_guys()
{
	germans5_group = getentarray("event5a_guys", "groupname");
	for(i=1;i<(germans5_group.size+1);i++)		
	{
		if(isalive(germans5_group[i]))
		{
			germans5_group[i] delete();
		}
					
	}	
}

//------------------event 5 end

// event5b // these are the guys that come out of the house behind the jeep

event5b_setup()	// guys at 88
{
	getent ("event_5b_trigger","targetname") waittill ("trigger");
	wait 11;
	germans5b_array =[];
	germans5b_group = getentarray("event5b_guys", "groupname");
	for(i=1;i<germans5b_group.size+1;i++)		
	{
		germans5b_array[i] = getent("event5b_guy_" + i, "targetname");		
		germans5b_array_ai[i] = germans5b_array[i] stalingradspawn();
		germans5b_array_ai[i] waittill ("finished spawning");
		germans5b_array_ai[i].goalradius = 4;	
		germans5b_array_ai[i].accuracy = 0;
		germans5b_array_ai[i].accuracystationarymod = 0;
		germans5b_array_ai[i] thread animscripts\shared::lookatentity(level.player, 10000000, "alert");
		germans5b_array_ai[i] allowedStances ("stand");
	}
	wait 10;
}

e5b_combat(i)
{
	if(isalive(self))
	{
		node = getnode("event5b_guy_node_" + i, "targetname");
		self setgoalnode(node);	
		self waittill("goal");
		self.pacifist = false;
	}
}

// event5c

event5c_setup()	// guys that come from behind the house and intercept the moving jeep from within the trees
{
	getent("event5c_trig","targetname") waittill ("trigger");
	germans5c_array =[];
	germans5c_group = getentarray("event5c_guys", "groupname");
	for(i=1;i<germans5c_group.size+1;i++)		
	{
		index = randomint(4);
		germans5c_array[i] = getent("event5c_guy_" + i, "targetname");		
		germans5c_array_ai[i] = germans5c_array[i] stalingradspawn();
		germans5c_array_ai[i].pacifist = true;
		germans5c_array_ai[i] waittill ("finished spawning");
		germans5c_array_ai[i].goalradius = 4;
		germans5c_array_ai[i].accuracy = 0.05;
		//germans5c_array_ai[i] animscripts\shared::SetInCombat();
		germans5c_array_ai[i] allowedStances ("stand");	
		
		if (index == 0)
		{
			germans5c_array_ai[i].pacifist = true;
		}
		
		germans5c_array_ai[i] thread e5c_combat(i);
	}
}

e5c_combat(i)
{
	if(isalive(self))
	{
		node = getnode("event5c_guy_node_" + i, "targetname");
		self setgoalnode(node);	
		self waittill("goal");
		self.pacifist = false;
	}
}
// event5c done

// event5d open area after 88 house -- guys running around vehicles in last open area before mortars
event5d_setup()	// guys at 88
{
	getent ("event5d_trig","targetname") waittill ("trigger");
	tank5d = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "event5c_tank1", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank5d maps\_panzeriv_gmi::init();
	tanktarget = getent ("willyjeep","targetname");
	path5d = getVehicleNode ("event5d_tank3_path","targetname");
	tank5d attachpath(path5d);
	tank5d.isalive = 1;
	tank5d.health = (1000000);
	tank5d maps\_tankgun_gmi::mgoff();
	tank5d startpath();
	tank5d setspeed(5,25);

	wait 1;

	tank6d = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "event5c_tank2", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank6d maps\_panzeriv_gmi::init();
	tanktarget = getent ("willyjeep","targetname");
	path6d = getVehicleNode ("event5d_tank2_path","targetname");
	tank6d attachpath(path6d);
	tank6d.isalive = 1;
	tank6d.health = (1000000);
	tank6d maps\_tankgun_gmi::mgoff();
	tank6d startpath();

	wait 1;
	
	tank7d = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "event5c_tank3", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank7d maps\_panzeriv_gmi::init();
	tanktarget = getent ("willyjeep","targetname");
	path7d = getVehicleNode ("event5d_tank4_path","targetname");
	tank7d attachpath(path7d);
	tank7d.isalive = 1;
	tank7d.health = (1000000);
	tank7d maps\_tankgun_gmi::mgoff();
	tank7d startpath();
	
	wait 1;

	tank8d = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "event5c_tank4", "PanzerIV_nodam" ,(0,0,0), (0,0,0) );
	tank8d maps\_panzeriv_gmi::init();
	tanktarget = getent ("willyjeep","targetname");
	path8d = getVehicleNode ("event5d_tank1_path","targetname");
	tank8d attachpath(path8d);
	tank8d.isalive = 1;
	tank8d.health = (1000000);
	tank8d maps\_tankgun_gmi::mgoff();
	tank8d startpath();

	wait 10;
	
	tank5d thread intro_fire_think();
	tank6d thread intro_fire_think();
	tank7d thread intro_fire_think();
	tank8d thread intro_fire_think();
}

e5d_guys_setup()
{
	getent ("event5d_trig","targetname") waittill ("trigger");
	germans5d_group_1 = getentarray("event5d_guys_1", "groupname");
	for(i=0;i<germans5d_group_1.size;i++)		
	{
		index = randomint(3);
		guy = germans5d_group_1[i] stalingradspawn();
		guy.pacifist = true;
		guy.goalradius = 4;
		guy allowedStances ("stand");
		
		if (index == 0)
		{
			guy.pacifist = false;
		}	
		guy thread e5d_combat(1); 
	}
	
	wait 2;
	
	germans5d_group_2 = getentarray("event5d_guys_2", "groupname");
	for(i=0;i<germans5d_group_2.size;i++)		
	{
		index = randomint(3);
		guy = germans5d_group_2[i] stalingradspawn();
		guy.pacifist = true;
		guy.goalradius = 4;
		guy allowedStances ("stand");
		
		if (index == 0)
		{
			guy.pacifist = false;
		}	
		guy thread e5d_combat(1); 
	}
	
	
	wait 2;
	
	germans5d_group_3 = getentarray("event5d_guys_3", "groupname");
	for(i=0;i<germans5d_group_3.size;i++)		
	{
		index = randomint(3);
		guy = germans5d_group_3[i] stalingradspawn();
		guy.pacifist = true;
		guy.goalradius = 4;
		guy allowedStances ("stand");
		
		if (index == 0)
		{
			guy.pacifist = false;
		}	
		guy thread e5d_combat(3); 
	}
	
}

e5d_combat(num)
{
	self endon ("death");
	if(isalive(self))
	{
		
		if (num == 1)
		{
			node = getnode ("event5d_node1","targetname");
			self setgoalnode (node);
			getent ("event5d_move_trig1","targetname") waittill ("trigger");
		}
		
		node = getnode ("event5d_node2","targetname");
		self setgoalnode (node);
		
		getent ("event5d_move_trig2","targetname") waittill ("trigger");
		
		node = getnode ("event5d_node3","targetname");
		self setgoalnode (node);
		
	}
}

// end 


event5e_setup()	// guys at 88
{
	germans5e_array =[];// this defines it as an array
	germans5e_group = getentarray("event5e_guys", "groupname");
	for(i=1;i<(germans5e_group.size+1);i++)//		
	{
		germans5e_array[i] = getent("event5e_guy_" + i, "targetname");
		germans5e_array_ai[i] = germans5e_array[i] dospawn();
		germans5e_array_ai[i].pacifist = 0;
		germans5e_array_ai[i].goalradius = 4;	
		germans5e_array_ai[i] animscripts\shared::SetInCombat();
		germans5e_array_ai[i] allowedStances ("stand");
	}
}

axis_clean_up()
{
		ai = getaiarray ("axis");
		for (i=0;i<ai.size;i++)
		{
			ai[i] delete();
		}
}

jeep_get_out()
{
	level thread maps\bastogne1_anim::willyjeep_end();
	println("^1THE BUMP FLAG IS OFF");
	level.flags["bumpy"] = false;		//'true' when the car should be bumpy
	level notify ("ExitVehicle");
	level.flags["PlayerInjeep"]  = false;
	level notify("objective_2_complete");	
	
	level.jeep notify ("idle done");
	level notify("moody_medic_vo");
	
	wait 3;
	level.jeep ejectdriver();
	level.player allowLeanLeft(true);
	level.player allowLeanRight(true);
	level.player allowCrouch(true);
	level.player allowuse(true);
	
	if (getcvarint("g_gameskill") == 3)	// The macaroni WITH the cheese
	{
		level.player.health = level.player.start_health;
	}
}

tree_burst_setup()
{
	trigs = getentarray("tree_burst", "targetname");
	for(i=0;i<trigs.size;i++)
	{
		trigs[i] thread tree_burst_think();
	}
}

tree_burst_think()
{
	self waittill("trigger");

	targets = getentarray(self.target,"targetname");

	for(i=0;i<targets.size;i++)
	{
		targets[i] thread tree_burst_anim();
		wait (randomfloat(.5));
	}
}

tree_burst_anim()
{
}

//------------ anim stuff ----------//
anim_single_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_single (newguy, anime, tag, node, tag_entity);
}

anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_loop ( newguy, anime, tag, ender, node, tag_entity );
}

#using_animtree("kubelwagon_kubel_path");
convoy_kubelwagon_start()
{
	level waittill ("kubelwagon start");
	kubel = spawn("script_model", (0,0,0));
	kubel setmodel("xmodel/vehicle_german_kubelwagen");
	kubel.script_vehiclegroup = 19;
	kubel.health = 100;
	
	kubel_tag_model = spawn("script_model", (0,0,0));
	kubel_tag_model setmodel("xmodel/bastogne_kubelwagen_crash");
	
	kubel_fx = getent("kubel_fx","targetname");
	//kubel_tag_model = getent("kubel_tag","targetname");
	//kubel = getent("kubel","targetname");
	
	kubel linkto(kubel_tag_model, "TAG_KUBELWAGEN",  (0,0,0), (0,0,0));
	
	wait 3.55;
	kubel maps\_kubelwagon_gmi::attach_guys();
	
	kubel_tag_model UseAnimTree(#animtree);
	kubel_tag_model setanimknobrestart(level.scr_anim["kubelwagon"]["crash"]);
	
	wait 0.5;
	level thread kubel_guys_health();
	
	wait 2.9;
	earthquake(0.8, 1.5, level.player.origin, 1050);
	kubel playsound("Barricade_smash");
	level thread maps\bastogne1_anim::moody_drive_crash_kubel();
	level thread maps\bastogne1_anim::ender_crash_kubel();
	
	wait 0.1;
	kubel thread kubel_crash();
	
	wait 0.5;
	kubel playsound("car_roll");
	
	wait 0.4;
	playfx (level._effect["snow_bank_hit"], kubel_fx.origin );
	
}



kubel_guys_health()
{
	guys = getentarray("kubel_guy","targetname");
	
	for (i=0;i<guys.size;i++)
	{
		guys[i].health = 99999999;
	}
}

#using_animtree("kubelwagon");
kubel_crash()
{
	self notify ("crasher");

	for(i=0;i<self.attachedguys.size;i++)
	{
		if(isdefined(self.attachedguys[i]))
		{
			if(isdefined(self.attachedguys[i].deathanimloop) || isalive(self.attachedguys))
			{
				self.attachedguys[i] unlink ();
				//self.attachedguys[i] linkto (model,"tag_body");
			}
			if(isalive(self.attachedguys[i]))
			{
				thread guy_fastdeathroll(self.attachedguys[i]);
			}
		}
	}

	//model playsound("car_roll");
	if(isdefined(self.enginesmoke))
	{
		self.enginesmoke unlink();
		self.enginesmoke linkto(model);
	}
}


#using_animtree ("generic_human");
guy_fastdeathroll(guy)
{
	guy notify ("customdeath");
	guy.deathanimloop = undefined;
	guy.allowdeath = 0;
	org = self gettagOrigin (guy.sittag);
	angles = self gettagAngles (guy.sittag);
	guy animscripted("animontagdone", org, angles, guy.deathanim);
	guy.deathanim = %wagon_backleft_death_roll;
	guy waittillmatch ("animontagdone","end");
	guy unlink();
	guy.allowdeath = 1;
	guy dodamage(guy.health + 50,(0,0,0));
}

enemy_vehicle_paths_mod(path)
{
	pathstart = path;
	if(!isdefined (pathstart))
	{
		println (self.targetname, " isn't near a path");
		return;
	}
	pathpoint = pathstart;

	crash_paths = getvehiclenodearray("crash_path", "targetname");
	while(isdefined (pathpoint))
	{

		shorterdist = 128;
		for(i=0;i<crash_paths.size;i++)
		{
			length = distance(crash_paths[i].origin,pathpoint.origin);
			if(length < shorterdist)
			{
				theone = crash_paths[i];
				shorterdist = length;
			}
		}
		if(isdefined(theone))
		{
			pathpoint.crash_path_target = theone;
			theone = undefined;
		}
		if(isdefined (pathpoint.target))
			pathpoint = getvehiclenode(pathpoint.target, "targetname");
		else
			break;
	}
	pathpoint = pathstart;
	arraycount = 0;
	while(isdefined (pathpoint))
	{
		pathpoints[arraycount] = pathpoint;
		arraycount++;
		if(isdefined (pathpoint.target))
		{
			pathpoint = getvehiclenode(pathpoint.target, "targetname");

		}
		else
			break;
	}
	pathpoint = pathstart;
	for(i=0;i<pathpoints.size;i++)
	{
		if(isdefined(pathpoints[i].crash_path_target))
		{
			switchnode = pathpoints[i].crash_path_target;
			if(isdefined (switchnode))
			{
				self setWaitNode(pathpoints[i]);
				self.crashing_path = switchnode;
				self waittill ("reached_wait_node");

				waited = true;  //do multiple things on one node
				if(isdefined(self.deaddriver) || self.health <= 0)
				{

					if((!isdefined (switchnode.derailed)))
					{
						self notify ("crashpath");
						switchnode.derailed = 1;
						self setSwitchNode (pathpoints[i],switchnode);
					}
				}
			}
		}
		waited = false;
	}
}

truck_exploders()
{
	exploders = getentarray("not_moving_truck","targetname");
	
	for (i=0;i<exploders.size;i++)
	{
		
		exploders[i] thread truck_exploders_think();
	}
	
	
}

truck_exploders_think()
{
	truck = getent(self.target,"targetname");
	truck_dead = getent(truck.target,"targetname");
	
	truck_dead hide();
	
	dmg_accum = 0;
	while (1)
	{
		self waittill ("damage",dmg);
		dmg_accum = dmg_accum + dmg;
		if (dmg_accum > 10000)
		{
			break;
		}
	}
	
	truck hide();
	truck_dead show();
	
	fx = loadfx("fx/explosions/vehicles/truck_complete.efx");
	
	sound_org = spawn("script_origin",truck.origin+(0,0,100));
	
	sound_org playsound ("explo_metal_rand");

	playfxOnTag ( fx, truck_dead, "tag_origin" );

	tag_org = truck_dead getTagOrigin("tag_engine_left");
	
	earthquake(0.5, 3, truck_dead.origin, 2050);
	// jeremy add 
	//radiusDamage(vec origin, float range, float max_damage, float min_damage);
	radiusDamage (tag_org + (0,0,128), 300, 800, 500);
	
	enginesmoke = spawn("script_origin",truck_dead gettagorigin("tag_engine_left"));
	enginesmoke linkto(truck_dead, "tag_engine_left");

	truck_dead thread enginesmoke(enginesmoke);	
}

enginesmoke(engine)
{
	enginesmoke = loadfx("fx/smoke/blacksmokelinger.efx");
	accdist = 0.001;
	fullspeed = 1000.00;

	timer = gettime()+10000;
	while(self.speed > 100 && timer > gettime())
	{
		oldorg = engine.origin;
		maps\_spawner_gmi::waitframe();
		dist = distance(oldorg,engine.origin);
		accdist += dist;
		enginedist = 48;
		if(self.speed > 1)
		{
			if(accdist > enginedist)
			{
				speedtimes = self.speed/fullspeed;
				playfx (enginesmoke, engine.origin);
				accdist -= enginedist;
			}
		}
	}
	while(timer > gettime())
	{
		playfx (enginesmoke, engine.origin);
		wait randomfloat(.3)+.1;		
	}

}

player_damage()
{
	while(1)
	{
		level.player waittill ("damage", dmg, who, dir, point, mod);
		println(dmg + " " + mod);
	}
}

intro_allies_setup()
{
	guy1 = getent("intro_ally_1","targetname");
	guy1 thread maps\_utility_gmi::magic_bullet_shield();
	guy1.goalradius = 8;
	guy1.accuracy = 0.05;
	
	guy2 = getent("intro_ally_2","targetname");
	guy2 thread maps\_utility_gmi::magic_bullet_shield();
	guy2.goalradius = 8;
	guy2.accuracy = 0.05;
	
	guy3 = getent("intro_ally_3","targetname");
	guy3 thread maps\_utility_gmi::magic_bullet_shield();
	guy3.goalradius = 8;
	guy3.accuracy = 0.05;
	
	dead1 = getent("dead1","targetname");
	dead1 thread maps\_utility_gmi::magic_bullet_shield();
	dead1.goalradius = 8;
	dead1.accuracy = 0.05;
	
	level.ender thread maps\_utility_gmi::magic_bullet_shield();
	level.ender.goalradius = 8;
	level.ender.accuracy = 0.05;
	
	level waittill ("moody talk done");
	
	guy1 setgoalnode(getnode("intro_place_1","targetname"));
	guy2 setgoalnode(getnode("intro_place_2","targetname"));
	dead1 setgoalnode(getnode("intro_place_dead1","targetname"));
	guy3 setgoalnode(getnode("intro_place_3","targetname"));
	level.ender setgoalnode(getnode("intro_place_ender","targetname"));
	
	//level.ender thread intro_allies_think();
	//guy3 thread intro_allies_think();
	
	//level waittill ("pos 3 met");
	
	getent("friendlychain_lol","targetname") waittill ("trigger");
	
	guy1 setgoalnode(getnode("guy1_position","targetname"));
	guy2 setgoalnode(getnode("guy2_position","targetname"));
	guy3 setgoalnode(getnode("guy3_position","targetname"));
	level.ender setgoalnode(getnode("ender_position","targetname"));
	dead1 setgoalnode(getnode("goldberg_position","targetname"));
	
	level waittill ("back to jeeps");
	
	guy1 thread intro_gunner_getin();
	guy2 thread intro_driver_getin();
	guy3 thread intro_passenger_getin();
	
	guy1 thread intro_gunner_death_fly();
	guy2 thread intro_driver_death_fly();
	guy3 thread intro_passenger_death_fly();
	
}

intro_allies_think()
{
	self setgoalnode(getnode("guys_pos_1","targetname"));
	self waittill ("goal");
	self setgoalnode(getnode("guys_pos_2","targetname"));
	self waittill ("goal");
	self setgoalnode(getnode("guys_pos_3","targetname"));
	self waittill ("goal");
	level notify("pos 3 met");
}

intro_axis_patrol()
{
	getent("intro_spawner_trig","targetname") waittill ("trigger");
	level.ender thread anim_single_solo(level.ender,"ender_kraut_patrol");	
	spawners = getentarray("intro_guys","groupname");
	
	guys = [];
	for (i=0;i<spawners.size;i++)
	{
		guys[i] = spawners[i] stalingradspawn();
		guys[i] allowedstances("stand","crouch");
		guys[i].bravery = 100000;
		guys[i].accuracy = 0.05;
	}
	wait 3;
 	level thread distantTankRumble (getent("tankblend_1","targetname"),"panzer");
	wait 12;
	level.ender thread anim_single_solo(level.ender,"ender_hear_that");
	level notify ("stop tank rumble");
	level notify ("start old intro spawners");
	level notify ("start intro vehicles");
	wait 13;
	level.ender thread anim_single_solo(level.ender,"ender_cmon");
	level notify ("back to jeeps");
	level notify("objective_1a_complete");
	//musicPlay("jeepride");
	wait 3;
	level notify("moody getin jeep");
	level.ender thread anim_single_solo(level.ender,"ender_go");
	wait 5;
	level.moody thread anim_single_solo(level.moody,"moody_go");
	level thread moody_getin_jeep_bitch();
	wait 14;
	
	
	for (i=0;i<guys.size;i++)
	{
		if (isalive(guys[i]))
		{
			guys[i] delete();
		}
	}
	//wait 5;
	//level.ender thread anim_single_solo(level.ender,"ender_ohman");
	//wait 5;
	
	
}

moody_getin_jeep_bitch()
{
	//level endon ("player in jeep");
	wait 6;
	while (level.flags["PlayerInjeep"] == false)
	{
		//wait 7;
		level.moodytalkflag = true;
		level.moody thread anim_single_solo(level.moody,"moody_go");
		wait 3;
		level.moodytalkflag = false;
		wait 7;
	}
}

intro_kill_goldberg()
{
	level waittill ("back to jeeps");
	wait 4;
	
	dead1 = getent("dead1","targetname");
	
	dead1 notify ("stop magic bullet shield");
	
	playfx (level.mortar,dead1.origin);
	earthquake(0.5, 3, dead1.origin, 1000);
	dead1 playsound ("shell_explosion1");
	dead1 animscripted("animontagdone", dead1.origin, dead1.angles, level.scr_anim["goldberg"]["gold_death"]);
	dead1 dodamage(dead1.health + 100, (0,0,0));
}

intro_kill_jeep()
{
	jeep = getent("dead_willy","targetname");
	
	jeep.health = 100000;
	jeep.isalive = true;
	jeep thread maps\_willyjeep_gmi::player_kill();
	
	level waittill ("kill jeep");
	
	playfx (level.mortar,jeep.origin);
	jeep playsound ("shell_explosion1");
	radiusDamage(jeep.origin, 0, jeep.health + 100, jeep.health + 100);
//	level.player shellshock("default", 3);
	level notify("jeep dead");
}

intro_gunner_getin()
{
	level endon ("kill jeep");
	jeep = getent("dead_willy","targetname");
	self setgoalnode(getnode("gunner_getin","targetname"));
	
	self.pacifist = true;
	self.interval = 0;
	self.ignoreme = 1;
	self.goalradius = 4;
	self.allowdeath = true;

	self waittill ("goal");	
	
	self linkto(jeep);
	org = jeep gettagOrigin ("tag_player");
	angles = jeep  gettagAngles ("tag_player");
	level.flags["gunner_anim_started"] = true;
	self animscripted("animontagdone", org, angles, level.scr_anim["gunner"]["gunner_jumpin"]);
	self waittillmatch ("animontagdone","end");
	level.flags["gunner_home"] = true;
	while(1)
	{
		self animscripted("animontagdone", org, angles, level.scr_anim["gunner"]["gunner_idle"]);
		self waittillmatch ("animontagdone","end");
	}
	
}

intro_gunner_death_fly()
{
	jeep = getent("dead_willy","targetname");
	org = jeep.origin;
	angles = jeep.angles;
	
	level waittill ("kill jeep");
	wait 0.05;
	if (level.flags["gunner_anim_started"] == true)
	{
		self animscripted("animontagdone", org, angles, level.scr_anim["gunner"]["gunner_death"]);
		//self waittillmatch ("animontagdone","end");
		wait 0.8;
		self dodamage (self.health+100,(0,0,0));
	}
	else
	{
		self playsound ("weap_mp40_fire");
		self dodamage (self.health+100,(0,0,0));
	}
}


intro_driver_getin()
{
	level endon ("kill jeep");
	jeep = getent("dead_willy","targetname");
	self setgoalnode(getnode("driver_getin","targetname"));
	
	self.pacifist = true;
	self.interval = 0;
	self.ignoreme = 1;
	self.goalradius = 4;
	self.allowdeath = true;

	self waittill ("goal");	
	
	self linkto(jeep);
	org = jeep gettagOrigin ("tag_driver");
	angles = jeep gettagAngles ("tag_driver");
	level.flags["driver_anim_started"] = true;
	self animscripted("animontagdone", org, angles, level.scr_anim["driver"]["driver_jumpin"]);
	self waittillmatch ("animontagdone","end");
	level.flags["driver_home"] = true;
	while(1)
	{
		self animscripted("animontagdone", org, angles, level.scr_anim["driver"]["driver_idle"]);
		self waittillmatch ("animontagdone","end");
	}
}

intro_driver_death_fly()
{
	jeep = getent("dead_willy","targetname");
	org = jeep.origin;
	angles = jeep.angles;
	
	level waittill ("kill jeep");
	wait 0.05;
	if (level.flags["driver_anim_started"] == true)
	{
		self animscripted("animontagdone", org, angles, level.scr_anim["driver"]["driver_death"]);
		//self waittillmatch ("animontagdone","end");
		wait 0.8;
		self dodamage (self.health+100,(0,0,0));
	}
	else
	{
		self playsound ("weap_mp40_fire");
		self dodamage (self.health+100,(0,0,0));
	}
}

intro_passenger_getin()
{
	level endon ("kill jeep");
	jeep = getent("dead_willy","targetname");
	self setgoalnode(getnode("passenger_getin","targetname"));
		
	self.pacifist = true;
	self.interval = 0;
	self.ignoreme = 1;
	self.goalradius = 4;
	self.allowdeath = true;

	self waittill ("goal");	
	
	level.flags["passenger_anim_started"] = true;
	self animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["passenger"]["passenger_jumpin"]);
	self waittillmatch ("animdone","end");
	level.flags["passenger_home"] = true;
	while(1)
	{
		self animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["passenger"]["passenger_idle"]);
		self waittillmatch ("animdone","end");
	}
}

intro_passenger_death_fly()
{	
	jeep = getent("dead_willy","targetname");
	org = jeep.origin;
	angles = jeep.angles;
	
	level waittill ("kill jeep");
	wait 0.05;
	if (level.flags["passenger_anim_started"] == true)
	{
		self animscripted("animontagdone", org, angles, level.scr_anim["passenger"]["passenger_death"]);
		//self waittillmatch ("animontagdone","end");
		wait 0.8;
		self dodamage (self.health+100,(0,0,0));
	}
	else
	{
		self playsound ("weap_mp40_fire");
		self dodamage (self.health+100,(0,0,0));
	}
}

intro_kill_willy_trig()
{
	level endon ("jeep dead");
	getent("kill_willy","targetname") maps\_utility_gmi::triggerOff();
	level waittill ("back to jeeps");
	getent("kill_willy","targetname") maps\_utility_gmi::triggerOn();
	getent("kill_willy","targetname") waittill ("trigger");
	//level.ender thread anim_single_solo(level.ender,"ender_mandown");
	level notify ("kill jeep");
	level notify ("kill jeep trig");
}

intro_kill_willy_anim()
{
	level endon ("jeep dead");
	level waittill ("back to jeeps");
	while (level.flags["driver_home"] == false || level.flags["passenger_home"] == false || level.flags["gunner_home"] == false)
	{
		wait 0.05;
	}
	level notify ("kill jeep");
	level notify ("kill jeep all in");
}

intro_insubbordination()
{
	level endon ("jeep go");
	getent("intro_insub","targetname") waittill ("trigger");
	setCvar("ui_deadquote", "@GMI_BASTOGNE1_INSUBORDINATION");
	missionfailed();
}

intro_kill_slow_player()
{
	trig1 = getent("intro_killer1","targetname");
	trig2 = getent("intro_killer2","targetname");
	trig3 = getent("intro_killer3","targetname");
	trig4 = getent("intro_killer4","targetname");
	trig5 = getent("intro_killer5","targetname");
	
	trig1 thread intro_kill_slow_player_think();
	trig2 thread intro_kill_slow_player_think();
	trig3 thread intro_kill_slow_player_think();
	trig4 thread intro_kill_slow_player_think();
	trig5 thread intro_kill_slow_player_think();
	
	trig1 maps\_utility_gmi::triggerOff();
	trig2 maps\_utility_gmi::triggerOff();
	trig3 maps\_utility_gmi::triggerOff();
	trig4 maps\_utility_gmi::triggerOff();
	trig5 maps\_utility_gmi::triggerOff();
	
	level waittill ("back to jeeps");
	
	wait 9;
	trig1 maps\_utility_gmi::triggerOn();
	wait 4;
	trig2 maps\_utility_gmi::triggerOn();
	wait 4;
	trig3 maps\_utility_gmi::triggerOn();
	wait 4;
	trig4 maps\_utility_gmi::triggerOn();
	wait 4;
	trig5 maps\_utility_gmi::triggerOn();
}

intro_kill_slow_player_think()
{
	self waittill ("trigger");
	
	playfx (level.mortar,level.player.origin);
	earthquake(0.5, 3, level.player.origin, 1000);
	level.player playsound ("shell_explosion1");
	level.player dodamage(level.player.health + 100, (0,0,0));
}

intro_tree_bursts()
{
	trees = getentarray("start_bursts","groupname");
	for (i=0;i<trees.size;i++)
	{
		trees[i] maps\_utility_gmi::triggerOff();
	}
	
	level waittill ("back to jeeps");
	
	for (i=0;i<trees.size;i++)
	{
		trees[i] maps\_utility_gmi::triggerOn();
	}
}

intro_group_stance()
{
	guys = getentarray("intro_group","groupname");
	for (i=0;i<guys.size;i++)
	{
		x = randomint(3);
		if (x == 0)
		{
			guys[i] allowedstances("crouch");
		}
	}
	level waittill ("moody talk done");
	
	for (i=0;i<guys.size;i++)
	{
		guys[i] allowedstances("crouch","stand","prone");
		guys[i] thread jeep_damage_penalty();
		guys[i].suppressionwait = 0;
	}
}

intro_group_pacifist()
{
	level waittill ("back to jeeps");
	guys = getentarray("intro_group","groupname");
	for (i=0;i<guys.size;i++)
	{
		guys[i].pacifist = true;
		guys[i].pacifistwait = true;
	}
}

intro_lock_player()
{
	lock = spawn("script_origin", level.player.origin);
	level.player linkTo(lock);
	level waittill ("moody talk done");
	level.player unlink();
}

jeep_damage_penalty()
{
	self endon ("death");	
	self endon ("end jeep damage penalty");	
	self waittill ("damage", dmg, who);
	
	if (who == level.jeep)
	{
		setCvar("ui_deadquote", "@SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
		missionfailed();
	}
}

distanceTankRumbleDeathEnder ()
{
	level waittill ("stop tank rumble");
	wait (2);
	self delete();
}

distantTankRumble (blend_point,type)
{
	org = spawn ("script_origin",(0,0,0));
	org endon ("death");
	org thread distanceTankRumbleDeathEnder();
	offset = 11200;
	vec = blend_point.origin;
	while (offset > 0)
	{
		offset -= 50;
		if (type == "panzer")
		{
			org.origin = (vec[0], vec[1] + offset, vec[2]);
			org playloopsound ("panzerIV_engine_high");
		}
		if (type == "sherman")
		{
			org.origin = (vec[0] + offset, vec[1], vec[2]);
			org playloopsound ("sherman_engine_high");
		}
		else
		{
			println ("Need to specify type.");
		}
		wait (0.05);
	}
}

