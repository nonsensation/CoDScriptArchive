main()
{
	level.flags["fapp_trigger1"] = false;
	level.flags["fapp_door_open"] = false;
	level.flags["boris_mortal"] = false;

	level.flags["yard_fight_started"] = false;

	precacheFX();

	setup_approach();
}

precacheFX()
{
	// bomb stuff
	precacheItem("panzerfaust");
	precacheShader("hudStopwatch");
	precacheShader("hudStopwatchNeedle");
	precacheModel("xmodel/explosivepack");
	// bomb stuff

	loadfx ("fx/vehicle/wheelspray_truck_dirt.efx");
}

vehicle_spawn(vspawner)
{
	vehicle = spawnVehicle( vspawner.model, vspawner.targetname, vspawner.vehicletype ,vspawner.origin, vspawner.angles );
	if(isdefined(vehicle))
	{
		if(isdefined(vspawner.drivertriggered))
			vehicle.drivertriggered = vspawner.drivertriggered;
		if(isdefined(vspawner.script_delay))
			vehicle.script_delay = vspawner.script_delay;
		if(isdefined(vspawner.script_noteworthy))
			vehicle.script_noteworthy = vspawner.script_noteworthy;
		if(isdefined(vspawner.script_team))
			vehicle.script_team = vspawner.script_team;
		if(isdefined(vspawner.script_accuracy))
			vehicle.script_accuracy = vspawner.script_accuracy;
		if(isdefined(vspawner.script_vehiclegroup))
			vehicle.script_vehiclegroup = vspawner.script_vehiclegroup;
		if(isdefined(vspawner.target))
			vehicle.target = vspawner.target;
		if(isdefined(vspawner.vehicletype))
			vehicle.vehicletype = vspawner.vehicletype;
		if(isdefined(vspawner.triggeredthink))
			vehicle.triggeredthink = vspawner.triggeredthink;
		if(isdefined(vspawner.script_sound))
			vehicle.script_sound = vspawner.script_sound;
	}
//	else
//		println("^5 vehicle_spawn: FAILED!");

	return vehicle;
}


// =============================
// =============================
//  Factory Approach
// =============================
// =============================

FA_Replace(guy)
{
	guy.targetname = "friendlywave_guy";
	guy.groupname = "friendlywave_guy";
	
	wait ( 0.1 );

	guy.goalradius = 128;
	guy.followmin = -3;
	guy.followmax = 1;
	guy setgoalentity (level.player);
}

setup_approach()
{
	// turn off the bombs trigger
	bombs_trigger = getent ( "tank_bomb_trigger", "targetname" );
	bombs_trigger maps\_utility_gmi::triggerOff();

	birdcage1 = getent ( "fapp_birdcage1", "targetname" );
	birdcage1 maps\_utility_gmi::triggerOff();
	birdcage1 connectpaths();

	fa_bads2_trigger = getent ( "fa_bads2_trigger", "targetname" );
	fa_bads2_trigger maps\_utility_gmi::triggerOff();

	trigger = getent ( "start_factory_approach", "targetname" );
	trigger maps\_utility_gmi::triggerOff();

	// turn off the bombs
	bombs = getent ( "tank_bomb", "targetname" );
	bombs hide();
	bombs_trigger.bomb = bombs;

	getent ( "tank1_bomb", "targetname" ) hide();
	getent ( "tank2_bomb", "targetname" ) hide();
	getent ( "tank1_bomb_trigger", "targetname" ) maps\_utility_gmi::triggerOff();
	getent ( "tank2_bomb_trigger", "targetname" ) maps\_utility_gmi::triggerOff();

	tank1_placeholder = getent ("approach_tank1", "targetname");
	tank1_placeholder hide();
	tank2_placeholder = getent ("approach_tank2", "targetname");
	tank2_placeholder hide();

	// wait for the death of the school MG guy
	level waittill ( "setup_factory_approach" );

	//println("^6setting up factory approach");

	// for friendly_wave
	level.maxfriendlies = 6;
	level.friendlywave_thread = maps\ponyri_fa::FA_Replace;

	level.fa_tank1 = vehicle_spawn(tank1_placeholder);
	level.fa_tank1 maps\_panzerIV_gmi::init();

	level.fa_tank2 = vehicle_spawn(tank2_placeholder);
	level.fa_tank2 maps\_panzerIV_gmi::init();

	// set this to false if you've enabled the appropriate tank
	level.flags["tank1_dead"] = false;
	level.flags["tank2_dead"] = false;

	// set up the tanks
	tank1_path = getvehiclenode ( level.fa_tank1.target, "targetname" );
	level.fa_tank1 attachpath (tank1_path);

	tank2_path = getvehiclenode ( level.fa_tank2.target, "targetname" );
	level.fa_tank2 attachpath (tank2_path);

	// set up the machinegunner guy
	thread approach_mg_guys();

	level thread approach_events();

	// wait for player to get close, then start up the tanks and stuff
	trigger = getent ( "start_factory_approach", "targetname" );
	trigger maps\_utility_gmi::triggerOn();
	trigger waittill ( "trigger" );

	level notify("start_factory_approach");

	// mark the school objective as done
	objective_string(level.school_obj_num, &"PI_PONYRI_OBJECTIVE3");
	objective_state (level.school_obj_num, "done");

	maps\ponyri_rail::CleanRailStation();
}

// wait until stopped at the end of my trail, then show the bomb and
// set up the trigger fields and bomb handling code
approach_tank_think(bombname, triggername, plant_flagname, dead_flagname, target_seedname)
{
	self endon ( "death" );

	self startpath();
	self waittill ("reached_end_node");

	wait1 = 3 + randomfloat (4);
	wait2 = 1 + randomfloat (1);

	self.script_accuracy = 400;

	shooting = true;
	while(shooting)
	{
		wait (wait1);
		self maps\_tankgun_gmi::mgon();
		wait (wait2);
		self maps\_tankgun_gmi::mgoff();
	}
}

approach_tank_shoot_think(target_seedname, initialwait)
{
	self endon ( "death" );
	self waittill ("reached_end_node");

	wait (initialwait);

	targ = getent(target_seedname, "targetname");
	while(isdefined(targ))
	{
		wait( 4 + randomint(2));

		self setTurretTargetEnt ( targ, (0,0,0) );
		self waittill( "turret_on_vistarget" );

		wait ( 2 );

		self FireTurret();

		targ = getent ( targ.target, "targetname" );
	}
}

// ====================
// bomb drop
// ====================
bomb_think(dead_flagname)
{
	iprintlnbold (&"TRAINING_EXPLOSIVESPLANTED");
	self.bomb setModel("xmodel/explosivepack");
	self.bomb playsound ("explo_plant_rand");
	self maps\_utility_gmi::triggerOff();

//	hdSinglePlayerTimer(level.player, getTime()+(10*1000)); //5 second stop watch timer
	stopwatch = newHudElem();
	stopwatch.x = 36;
	stopwatch.y = 240;
	stopwatch.alignX = "center";
	stopwatch.alignY = "middle";
	stopwatch setClock(10, 60, "hudStopwatch", 64, 64); // count down for 10 of 60 seconds, size is 64x64
	wait 10;
	stopwatch destroy();

	//BEGIN EXPLOSION
	self.bomb playsound ("explo_rock");

	radiusDamage (self.bomb.origin, 450, 2000, 400);

	earthquake(0.25, 3, self.bomb.origin, 1050);

//	playfx (level.explo_fx, self.bomb.origin );

	level notify ("bomb_exploded");

	level.flags[dead_flagname] = true;
	level notify (dead_flagname);

	self.bomb hide();
}

pester_player_about_tank1()
{
	level endon ("fapp_trigger1");

	wait(20);
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_killtank2");
	
	wait(20);
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_killtank2");
}

// ====================
//  GUYS AND MG42s
// ====================
kick_door_in ( kicker, doorname, nodename, seconddoorname )
{
	kicker endon ("death");

	oldanimname = "antonov";
	if(isdefined (kicker.animname))
		oldanimname = kicker.animname;

	kicker.animname = "antonov";

	scripting_point = getnode ( nodename, "targetname" );

	kick_guy[0] = kicker;

	maps\_anim_gmi::anim_pushPlayer(kick_guy);

	kick_anim[0] = "kick_door_1";
	kick_anim[1] = "kick_door_2";

	num = randomint(2);

	maps\_anim_gmi::anim_reach(kick_guy, kick_anim[num], undefined, scripting_point);

	level maps\_anim_gmi::anim_dontPushPlayer(kick_guy);

	level thread maps\_anim_gmi::anim_single(kick_guy, kick_anim[num], undefined, scripting_point);

	kick_guy[0] waittillmatch ("single anim", "kick");

	door = getent(doorname, "targetname");
	door playsound ("wood_door_kick");
	door rotateto((0,90,0), 0.5, 0, 0.2);
	
	if(isdefined(seconddoorname))
	{
		door2 = getent(seconddoorname, "targetname");
		door2 rotateto((0,-90,0), 0.5, 0, 0.2);
	}

	door waittill("rotatedone");
	door connectpaths();

	if(isdefined(seconddoorname))
	{
		door2 connectpaths();
	}

	kicker.animname = oldanimname;
}

fa_bads0()
{
	level endon ( "stop_fa_bads0" );

	spawners = getentarray ( "fa_bads0", "targetname" );

	spawning = true;
	while(spawning)
	{
		dude = maps\_pi_utils::fire_clown_car ( 4, spawners, "fa_bads0_guy");
		if(isdefined(dude))
		{
			dude thread maps\_pi_utils::run_blindly_to_nodename ( dude.target, "targetname", 600000 );
		}
		wait ( 1 );
	}
}

shutdown_mg1_spawner()
{
	trigger = getent ( "approach_mg_house", "targetname" );
	if( isdefined (trigger) )
	{
		trigger waittill ("trigger");

		crumb = getent ( "approach_mg_spot", "targetname" );
		objective_position (level.fapp_obj_num, crumb.origin );

		level notify ("stop_house_mg");

		maps\ponyri_rail::wait_for_group_clear("fapp_mg", 1, "mg_killed");
			
		level.flags["mg42_1_dead"] = true;
		level notify ("mg42_1_dead");

		// have antonov kick the door open
		kick_door_in ( level.boris, "approach_door", "approach_door_node" );

		level.flags["fapp_door_open"] = true;
		level notify("fapp_door_open");
	}
}

approach_respawn_think()
{
	level endon ("stop_house_mg");

	superman = 1;
	while(superman)
	{
		guy = self dospawn();
		if( isdefined (guy) )
		{
			wait(0.1);
			guy.targetname = "approach_mg_guy";
			guy thread maps\_pi_utils::run_blindly_to_nodename ( guy.target, "targetname", 600000 );
			guy waittill ( "death" );
			wait ( 2 + randomfloat ( 2 ) );
		}
		wait ( 1 );
	}
}

approach_mg_guys()
{
	level endon ("stop_house_mg");

	level thread shutdown_mg1_spawner();

	mg = getentarray ( "approach_mg_guy_spawner", "targetname" );
	if( isdefined(mg) )
	{
		level.flags["mg42_1_dead"] = false;

		for(x=0;x<mg.size;x++)
		{
			mg[x] thread approach_respawn_think();
		}
	}
}

// ======================
// ======================
// stages
// ======================
// ======================
approach7_trigger()
{
	level endon( "yard_fight_started" );

	trig = getent ("approach7_trigger", "targetname");
	if(isdefined(trig))
		trig waittill("trigger");

	if(level.flags["yard_fight_started"] == false)
	{
		level.flags["yard_fight_started"] = true;
		level thread maps\ponyri_factory::yard_fight_start();
	}
}

// ======================
//  Objectives
// ======================

boris_watchfordeath()
{
	self endon ("boris_immortal");
	self waittill ("death");

	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
	missionfailed();
}

boris_mortality()
{
	// boris is on his way to boris_fapp1, wait for it
//	println("^5 boris_mortality: waiting for boris to get in position "+ self.bravery + ""); 
	self waittill ("goal");

	// make boris mortal and watch for his death
//	println("^5 boris_mortality: boris killable"); 
	self notify ("stop magic bullet shield");
	self thread boris_watchfordeath();

	level.flags["boris_mortal"] = true;
	level notify("boris_mortal");

	// wait until boris plants the bomb
	level waittill ( "tank1_planted" );

	// turn him immortal again for the run across the street
	self thread maps\_utility_gmi::magic_bullet_shield();
//	println("^5 boris_mortality: bomb planted, boris immortal again"); 

	// wait until boris is sent to kill tank2
	self waittill ("boris_to_tank2");

	// make boris mortal and watch for his death
	self notify ("stop magic bullet shield");
	self thread boris_watchfordeath();
//	println("^5 boris_mortality: boris to tank2, mortal again"); 

	// wait for him to plant the second bomb
	level waittill ("tank2_planted");

	// turn him immortal again 
	self thread maps\_utility_gmi::magic_bullet_shield();
//	println("^5 boris_mortality: tank2 planted, immortal again"); 
}

approach_events()
{
	level notify ("stop_factory_hack");

	// bring tank # 1 to life regardless
	level.fa_tank1 thread approach_tank_think ( "tank1_bomb", "tank1_bomb_trigger", "tank1_planted", "tank1_dead" );
	level.fa_tank1 thread approach_tank_shoot_think("fa_targ1a", 30);

	// send the guys into battle
	level.player setfriendlychain ( getnode( "fapp_chain0", "targetname" ));

	// spawn some guys to fight them over there
	level thread fa_bads0();

	// wait for the player to get close for antonov's line
	level waittill("start_factory_approach");

	wait ( 3 );

	// yell at player to help boris blow up tank #1
	level.antonov waittill ("goal");
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_killtank1");
	wait ( 0.5 );

	// send boris ahead (towards panzer)
	level.boris setgoalnode ( getnode ("boris_fapp1", "targetname") );
	level.boris thread boris_mortality();

	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_killtank2");
	wait ( 0.5 );

	objective_add (level.fapp_obj_num, "active", &"PI_PONYRI_OBJECTIVE4B");
	objective_current(level.fapp_obj_num);

	level notify ("stop_church_dummy_fight");

	level thread maps\_pi_utils::objective_tracker(level.fapp_obj_num, level.boris);

//	crumb = getent ( "fapp_breadcrumb1", "targetname" );
//	objective_position (level.fapp_obj_num, crumb.origin );
//	objective_ring(level.fapp_obj_num);

	level.miesha setgoalentity (level.player);
	
	trig = getent ( "fapp_trigger1", "targetname" );
	if(isdefined(trig))
	{
		level thread pester_player_about_tank1();
		trig waittill ("trigger");
		level notify ( "fapp_trigger1" );
	}

	// wait until boris is in position and made mortal
	if(level.flags["boris_mortal"] == false)
		level waittill ("boris_mortal");

	// send boris ahead
	level.boris setgoalnode ( getnode ("boris_fapp2", "targetname") );

//	crumb = getent ( "fapp_breadcrumb2", "targetname" );
//	objective_position (level.fapp_obj_num, crumb.origin );
//	objective_ring(level.fapp_obj_num);

	// wait for the player
	trig = getent ( "fapp_trigger1a", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");

	// send boris ahead
	level.boris setgoalnode ( getnode ("boris_fapp3", "targetname") );

	// wait for the player
	trig = getent ( "fapp_trigger2", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");

	// send boris ahead
	level.boris setgoalnode ( getnode ("boris_fapp4", "targetname") );

	// wait for the player
	trig = getent ( "fapp_trigger3", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");

	// turn on boris tracker
	level thread maps\_pi_utils::objective_tracker(level.fapp_obj_num, level.boris);

	level notify ("stop_fa_bads0");

	level.boris thread set_bombs( level.boris, "tank1_bomb_trigger", "tank1_bomb", "tank1_bomb_spot", "tank1_planted", "tank1_dead" );

	// turn on fa_bads2 trigger
	level waittill ( "tank1_planted" );
	
	// turn off boris tracker
	level notify ( "stop_objective_tracker" );

	birdcage1 = getent ( "fapp_birdcage1", "targetname" );
	birdcage1 maps\_utility_gmi::triggerOn();
	birdcage1 connectpaths();

	// send the player back to antonov
	crumb = getent ("tank1_planted_regroup_spot", "targetname");
	objective_string(level.fapp_obj_num, &"PI_PONYRI_OBJECTIVE3C");
	objective_position (level.fapp_obj_num, crumb.origin );
	objective_current(level.fapp_obj_num);
	objective_ring(level.fapp_obj_num);

	maps\_pi_utils::KillEntArray("fapp1","groupname"); 

	// tank 1 is about to die
	// if tank2 is still alive, wake up tank #2
	if(level.flags["tank2_dead"] == false)
	{
		level.fa_tank2 thread approach_tank_think ( "tank2_bomb", "tank2_bomb_trigger", "tank2_planted", "tank2_dead");

		// tank blows up wall
		level.fa_tank2 thread tank2_shootstuff();
	}

	fa_bads2_trigger = getent ( "fa_bads2_trigger", "targetname" );
	fa_bads2_trigger maps\_utility_gmi::triggerOn();

	// send boris back to cover
	//println("^6 approach_events: sending boris back to cover");
	level.boris setgoalnode ( getnode ("boris_fapp5a", "targetname"));
	
	// tell manager thread that when boris returns to cover, make him immortal for the run across the street
	level.boris notify ("boris_planted_bomb1");
	
	level waittill ( "tank1_dead" );

	maps\_pi_utils::KillEntArray("fapp_tank1","groupname"); 

	// clean up the school area
	level thread maps\ponyri_school::CleanSchool();

	// move the guys up when tank #1 is dead
	//println("^6 approach_events: tank1 dead, moving to car and wall");
	// set existing guys to follow antonov so switch later is smooth
	level.player setfriendlychain (getnode ( "fapp_chain2", "targetname" ));
	level.antonov setfriendlychain (getnode ( "fapp_chain2", "targetname" ));
	level.antonov setgoalentity (level.antonov);
	level.vassili setgoalentity (level.antonov);
	level.miesha setgoalentity (level.antonov);

	redshirts = getentarray ( "friendlywave_guy", "targetname" );
	if(isdefined (redshirts))
	{
		for(x=0;x<redshirts.size;x++)
		{
			redshirts[x] setgoalentity (level.antonov);
		}
	}

	wait ( 1 );

	level.antonov waittill ("goal");

	//println("^6approach_events: antonov talking, moving boris into bldg2");
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_stopmg");
	wait ( 0.5 );

	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_stopmg2");
	wait ( 0.5 );

	crumb = getent ( "fapp_breadcrumb4", "targetname" );
	objective_string(level.fapp_obj_num, &"PI_PONYRI_OBJECTIVE4C");
	objective_position (level.fapp_obj_num, crumb.origin );
	objective_current(level.fapp_obj_num);
	objective_ring(level.fapp_obj_num);

	level.player setfriendlychain ( getnode ("boris_fapp6", "targetname") );
	level.boris setgoalentity ( level.player );
	crumb = getent ( "fapp_breadcrumb5", "targetname" );
	objective_position (level.fapp_obj_num, crumb.origin );

	// if it hasn't been hit, wait for someone to get near bldg2
	trig = getent("fa_bldg2_trigger", "targetname");
	if(isdefined(trig))
		trig waittill("trigger");

	//println("^6 approach_events: sending boris into the backyard");
	level.player setfriendlychain ( getnode ("boris_fapp7", "targetname") );

	level.player setfriendlychain ( getnode ("boris_fapp7", "targetname") );

	trig = getent ( "fapp_trigger5", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");

	// turn off FX at the school and in the water tower approach
	level notify ("stop_school_fx");
	level notify ("stop_wt_fx");

	redshirts = getentarray ( "friendlywave_guy", "targetname" );
	if(isdefined (redshirts))
	{
		for(x=0;x<redshirts.size;x++)
		{
			redshirts[x] setgoalentity (level.player);
		}
	}

	// if it hasn't been hit, wait for the player to get near tank2's broken wall
	trig = getent("fa_to_mg_trigger", "targetname");
	if(isdefined(trig))
		trig waittill("trigger");

	crumb = getent ( "fapp_breadcrumb6", "targetname" );
	objective_position (level.fapp_obj_num, crumb.origin );

	//println("^6 approach_events: sending boris into the mg building");
	level.player setfriendlychain ( getnode ("boris_fapp8", "targetname") );

	// send boris ahead when you move into the house enough
	trig = getent ( "mg_house_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");
	level.player setfriendlychain ( getnode ("boris_fapp9", "targetname") );

	level thread approach7_trigger();

	if(level.flags["mg42_1_dead"] == false)
		level waittill("mg42_1_dead");

//	crumb = getent ( "boris_tank2_obj_spot", "targetname" );
	objective_string(level.fapp_obj_num, &"PI_PONYRI_OBJECTIVE4B");
//	objective_position (level.fapp_obj_num, crumb.origin );
//	objective_current(level.fapp_obj_num);
//	objective_ring(level.fapp_obj_num);

	// make boris mortal and track him
	level.boris notify ("boris_to_tank2");
	level thread maps\_pi_utils::objective_tracker(level.fapp_obj_num, level.boris);

	//println("^6 approach_events: fapp MG dead, moving up to sandbags");
	level.antonov setfriendlychain (getnode ( "fapp_chain2a", "targetname" ));

	if(level.flags["fapp_door_open"] == false)
		level waittill("fapp_door_open");

	//println("^6 approach_events: boris sent to blow up tank2");
	level.boris thread set_bombs( level.boris, "tank2_bomb_trigger", "tank2_bomb", "tank2_bomb_spot", "tank2_planted", "tank2_dead" );
	level.player setfriendlychain (getnode ( "boris_planting_chain", "targetname" ));

	// if tank2's bomb isn't planted yet, wait until it is
	if(level.flags["tank2_planted"] == false)
		level waittill ( "tank2_planted" );

	// turn off boris tracker
	level notify ( "stop_objective_tracker" );

	// bomb planted, run everyone across the street
	//println("^6 approach_events: boris planted the bomb");
	level.player setfriendlychain ( getnode("fapp_chain3", "targetname"));
	level.boris setgoalentity(level.player);

	// send the player to the last breadcrumb
	// tell them to "clear the way to the factory"
	crumb = getent ( "fapp_breadcrumb3", "targetname" );
	objective_string(level.fapp_obj_num, &"PI_PONYRI_OBJECTIVE4F");
	objective_position (level.fapp_obj_num, crumb.origin );
	objective_current(level.fapp_obj_num);
	objective_ring(level.fapp_obj_num);

	// if tank2 isn't dead, wait until it is
	if(level.flags["tank2_dead"] == false)
		level waittill ( "tank2_dead" );

	birdcage1 = getent ( "fapp_birdcage1", "targetname" );
	birdcage1 maps\_utility_gmi::triggerOff();
	birdcage1 connectpaths();

	// kill the guys around the tank
	//println("^6 approach_events: killing the tank friends");
	maps\_pi_utils::KillEntArray("fapp_tank2","groupname"); 

	level.boris setgoalentity(level.player);
	level.antonov setgoalentity (level.player);
	level.vassili setgoalentity (level.player);
	level.miesha setgoalentity (level.player);

	wait ( 2 );

	// tank 2 killed, inform it's friends so they'll be angry
	tank2guys = getentarray ( "tank2_reprisal", "targetname");
	for(x=0;x<tank2guys.size;x++)
	{
		dude = tank2guys[x] dospawn();
		if(isdefined(dude))
		{
			dude.groupname = "fapp7";
		}
	}

	maps\ponyri_rail::wait_for_group_clear("fapp7", 2, "fapp_clear");

	// mark the town objective as done
	objective_string(level.town_obj_num, &"PI_PONYRI_OBJECTIVE2");
	objective_state (level.town_obj_num, "done");

	wait ( 0.2 );

	//println("^6approach_events: sending folks on to the factory");
	level.player setfriendlychain (getnode ( "fact_yard_chain", "targetname" ));

	wait ( 0.2 );

	maps\_utility_gmi::autosave(9);

	wait ( 1 );

	if(level.flags["yard_fight_started"] == false)
	{
		level.flags["yard_fight_started"] = true;
		level notify("yard_fight_started");
		level thread maps\ponyri_factory::yard_fight_start();
	}

	wait ( 3 );

//	level.player playsound ("antonov_assault");
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_assault");

	objective_string (level.fapp_obj_num, &"PI_PONYRI_OBJECTIVE4");
	objective_state (level.fapp_obj_num, "done");

	spot = getent ("factory_entry_spot", "targetname");
	objective_add(level.factory_obj_num, "active", &"PI_PONYRI_OBJECTIVE4G", spot.origin );
	objective_position (level.factory_obj_num, spot.origin );
	objective_current(level.factory_obj_num);
	objective_ring(level.factory_obj_num);

}

tank2_shootstuff()
{
	wait ( 5 );	// FIXME - better wait mechanism??

	targ = getent("fa_targ2a", "targetname");
	wait( 1 );
	self setTurretTargetEnt ( targ, (0,0,0) );
	self waittill( "turret_on_vistarget" );
	self FireTurret();
	wait(0.3);
	thread maps\_utility_gmi::exploder(7);		// break open the wall

	targ = getent("fa_targ2b", "targetname");
	wait( 1 );
	self setTurretTargetEnt ( targ, (0,0,0) );
	self waittill( "turret_on_vistarget" );
	self FireTurret();
	wait(0.2);
	thread maps\_utility_gmi::exploder(6);		// break open the wall
}


// =============================
// =============================
//  Team Bomb Placement
// =============================
// =============================

set_bombs( bomber, bomb_trigger_name, bombname, nodename, plant_flagname, dead_flagname )
{
	level endon (plant_flagname);
	level endon (dead_flagname);
	bomber endon ("death");

	oldanimname = "antonov";
	if(isdefined (bomber.animname))
		oldanimname = bomber.animname;

	bomber.animname = "antonov";

	scripting_point = getnode ( nodename, "targetname" );

	bomb_guy[0] = bomber;

	maps\_anim_gmi::anim_pushPlayer(bomb_guy);

	bomb_anim = "plants_bomb_panzer_p";

	maps\_anim_gmi::anim_reach(bomb_guy, bomb_anim, undefined, scripting_point);

	level maps\_anim_gmi::anim_dontPushPlayer(bomb_guy);

	level thread maps\_anim_gmi::anim_single(bomb_guy, bomb_anim, undefined, scripting_point);

	bomb_guy[0] waittillmatch ("single anim", "release bomb from hands");

	bomber.animname = oldanimname;

	bomb_trigger = getent(bomb_trigger_name, "targetname");
	bomb_trigger.bomb = getent (bombname, "targetname");
	bomb_trigger.bomb show();

	level notify ( plant_flagname );
	level.flags [plant_flagname] = true;

	bomb_trigger bomb_think(dead_flagname);
}
