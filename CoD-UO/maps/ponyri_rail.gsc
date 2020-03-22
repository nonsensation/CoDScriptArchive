main()
{
	// for friendly_wave
	level.maxfriendlies = 6;
	level.friendlywave_thread = maps\ponyri_rail::Rail_ReplaceApproach;

	// level.flags
	level.flags["Rail_Assault_Dummies"] = false;
	level.flags["station_platform"] = false;
	level.flags["station0"] = false;
	level.flags["station0_spawn"] = false;
	level.flags["station0_premature"] = false;
	level.flags["station1"] = false;
	level.flags["station2"] = false;
	level.flags["station2_respawn"] = false;
	level.flags["station3"] = false;
	level.flags["station4"] = false;
	level.flags["station4_mbs"] = true;
	level.flags["station5"] = false;
	level.flags["station_done"] = false;
	level.flags["rail_fight2_mbs"] = true;
	level.flags["rail_fight2_movein"] = false;
	level.flags["rail_fight2_done"] = false;
	level.flags["rail_sniper_active"] = false;
	level.flags["rail_tower_done"] = false;
	level.flags["rail_left_trigger2"] = false;
	level.flags["t34_mg_fire"] = true;
	level.flags["t34_fake_turret_fire"] = false;
	level.flags["rail_fight3_done"] = false;
	level.flags["flankspeech"] = false;
	level.flags["flankspeech_done"] = false;
	level.flags["railwallmoveup"] = false;
	level.flags["t34_3_proceed"] = false;
//	level.flags["t34_rail_approach_done"] = false;
	level.flags["t34_shoot_rail_wall"] = false;

	vehicle_init();
	railyard_setup();

	// tanks start down the road
	thread tracks_approach();

	// lock the player
	dummy = spawn ("script_origin",(level.player.origin));
	level.player playerlinkto(dummy);

	level waittill ("starting final intro screen fadeout");

	// get a briefing from Antonov
	thread antonov_briefing();
	
	// Band of Comrades begins their march
	thread friends_approach();
	thread group2_approach();

	wait(0.1);

	thread maps\ponyri_dummies::Rail_Assault();

	level notify("Rail_Assault_Go"); // start dummies from the south

	wait(0.1);

	// triggers for gameplay stuff
	thread fight1();
	wait(0.1);
	thread rail_player_approaches();
	wait(0.1);

	trig = getent ( "station5_trigger", "targetname" );
	trig maps\_utility_gmi::triggerOff();
}

// =======================
// =======================
//  SETUP
// =======================
// =======================

vehicle_init()
{
	t34_1 = getent ( "t34_1", "targetname" );
	t34_1 maps\_t34_gmi::init();
	t34_1.isalive = 1;
	t34_1 thread rail_t34_fire_think();

	t34_2 = getent ( "t34_2", "targetname" );
	t34_2 maps\_t34_gmi::init();
	t34_2.health = 10000;
	t34_2.isalive = 1;
	t34_2 thread rail_t34_fire_think();

	t34_3 = getent ( "t34_3", "targetname" );
	t34_3 maps\_t34_gmi::init();
	t34_3.health = 10000;
	t34_3.isalive = 1;
	t34_3 thread rail_t34_fire_think();

	tiger_1 = getent ( "tiger_1", "targetname" );
	tiger_1 maps\_panzerIV_gmi::init();
	tiger_1 thread rail_panzer_fire_think();

	tiger_2 = getent ( "tiger_2", "targetname" );
	tiger_2 maps\_panzerIV_gmi::init();
	tiger_2 thread rail_panzer_fire_think();
}

railyard_setup()
{
	// Damaged Area A Sandbags
	dmgbags = getent("railyard_mg42_nest_01_damaged","targetname");
	dmgbags maps\_utility_gmi::triggerOff();

	// Area A
	axis_mg_1 = getent("axis_mg_1","targetname");
	axis_mg_1_replacement = getent("axis_mg_1_replacement","targetname");
	axis_mg_1.maxsightdistsqrd = 9000000;
	axis_mg_1_replacement.maxsightdistsqrd = 9000000;

	// Area B
	rail_B_guy = getentarray("rail_B_guy","targetname");
	for(x=0;x<rail_B_guy.size;x++)
	{
		rail_B_guy[x].maxsightdistsqrd = 9000000;
	}
}

// =======================
// =======================
//  GAMEPLAY
// =======================
// =======================

rail_player_approaches()
{
	trig = getent("rail_player_approaches","targetname");
	if(isdefined(trig))
		trig waittill("trigger");

	level.flags["Rail_Assault_Dummies"] = false;	// stop the assault dummies

	thread fight2_spawn();
	wait(0.1);
	fight2_manual_start();
}

// turn on and off the machinegun on the t34s from time to time
rail_panzer_fire_think(fake_target)
{
	self endon("death");

	wait1 = 3 + randomfloat (4);
	wait2 = 1 + randomfloat (1);

	self.script_accuracy = 400;
	firing = true;
	while(firing)
	{
		wait (wait1);
		self maps\_tankgun_gmi::mgon();
		wait (wait2);
		self maps\_tankgun_gmi::mgoff();
	}	
}

rail_t34_fire_think(fake_target)
{
	self endon("death");

	wait1 = 3 + randomfloat (4);
	wait2 = 1 + randomfloat (1);

	if(isdefined(fake_target))
		targ = getent(fake_target, "targetname");

	self.script_accuracy = 400;
	while(self.isalive == 1)
	{
		wait (wait1);
		if(level.flags["t34_mg_fire"] == true)
		{
			self maps\_tankgun_gmi::mgon();
			wait (wait2);
			self maps\_tankgun_gmi::mgoff();
		}
		else if(level.flags["t34_fake_turret_fire"] == true)
		{
			if(isdefined(targ))
			{
				self setTurretTargetEnt( targ, ( 0, 0, 60 ) );
				self waittill( "turret_on_vistarget" );
				self FireTurret();
			}
//			else println("^4 rail_t34_fire_think : couldnt find " + fake_target + "");
			wait (3);
		}
	}	
}

// -----------------------------------------------------------------------------------------------

stop_tiger_smoke()
{
//	println("^5 stop_tiger_smoke");
	wait( 1 + randomfloat(1) );
	tiger = getent("tiger_1", "targetname" );
	stopattachedfx ( tiger );
	wait( 2 + randomfloat(1) );
	tiger = getent("tiger_2", "targetname" );
	stopattachedfx ( tiger );
}

antonov_briefing()
{
	friendlies_group1 = getentarray("friendlies_group1","groupname");
	friendlies_group2 = getentarray("friendlies_group2","groupname");

	for(x=0;x<friendlies_group2.size;x++)
	{
		friendlies_group2[x].targetname = "friendlywave_guy";
	}

	friendlies_playergroup = add_array_to_array(level.friends, friendlies_group1);
	friendlies_initial = add_array_to_array(friendlies_playergroup, friendlies_group2);

	// We don't want our guys worrying about stuff off in the distance just yet
	for(i=0;i<friendlies_initial.size;i++)
	{
		// TODO Whenever we get a response from GMI on how to make our allies NOT shoot at enemies, put whatever those magic settings are here!!!
		friendlies_initial[i].pacifist = true;
		friendlies_initial[i].maxsightdistsqrd = 10;
		friendlies_initial[i].suppressionwait = 0;
		friendlies_initial[i].goalradius = 64; // keep them close to their nodes
		friendlies_initial[i].followmin = -3;
		friendlies_initial[i].followmax = 1;
	}

	level.antonov thread animscripts\shared::LookAtEntity(level.player, 5, "alert");
	level.boris thread animscripts\shared::LookAtEntity(level.antonov, 15, "casual");
	level.miesha thread animscripts\shared::LookAtEntity(level.antonov, 15, "casual");
	level.vassili thread animscripts\shared::LookAtEntity(level.antonov, 15, "casual");

	level.antonov thread anim_single_solo(level.antonov,"introspeech2");
	wait(20);	// FIXME adjust to final speech length

//	println("^5 antonov_briefing: start running guys!");
	level notify ("actually_start_running");

	// unlock the player when antonov is done talking
	level.player unlink();

	rail_objectives();
}

rail_objectives()
{
	spot1 = getent ( "rail_station_obj", "targetname" );
	if(!isdefined(spot1))
		println("^1 >>>>> rail_objectives: where's rail_station_obj??");

	objective_add(level.rail_obj_num, "active", &"PI_PONYRI_OBJECTIVE1", spot1.origin );
	objective_position (level.rail_obj_num, spot1.origin );
	objective_current(level.rail_obj_num);
	objective_ring(level.rail_obj_num);

	if(level.flags["flankspeech"] == false)
		level waittill ( "flankspeech" );

	// antonov tells them to flank
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_outflank");

	wait ( 1 );	// FIXME - adjust this to the final sound duration
	level notify ("flankspeech_done");
	level.flags["flankspeech_done"] = true;

	spot2 = getent ( "rail_flank_obj", "targetname" );
	objective_string(level.rail_obj_num, &"PI_PONYRI_OBJECTIVE1A");
	objective_position (level.rail_obj_num, spot2.origin );
	objective_current(level.rail_obj_num);
	objective_ring(level.rail_obj_num);

	if(level.flags["rail_fight2_movein"] == false)
		level waittill ( "rail_fight2_movein" );

	level.flags["t34_shoot_rail_wall"] = true;
	level notify ("t34_shoot_rail_wall");

	spot2 = getent ( "rail_flank_obj2", "targetname" );
	objective_position (level.rail_obj_num, spot2.origin );
	objective_ring(level.rail_obj_num);

	if(level.flags["rail_fight2_done"] == false)
		level waittill ( "rail_fight2_done" );

	// the player can now go to the station
	level.flags["station0_premature"] = true;
	level notify("station0_premature");

	level thread stop_tiger_smoke();

	if(level.flags["rail_sniper_active"] == false)
		level waittill ( "rail_sniper_active" );

	spot2 = getent ( "rail_tower_obj", "targetname" );
	objective_string (level.rail_obj_num, &"PI_PONYRI_OBJECTIVE1B");
	objective_position (level.rail_obj_num, spot2.origin );
	objective_current(level.rail_obj_num);
	objective_ring(level.rail_obj_num);

	if(level.flags["rail_tower_done"] == false)
		level waittill ( "rail_tower_done" );

	if(level.flags["station_platform"] == false)
	{
		// send the player up onto the platform
		spot3 = getent ( "rail_station0_obj", "targetname" );
		objective_string(level.rail_obj_num, &"PI_PONYRI_OBJECTIVE1C");
		objective_position (level.rail_obj_num, spot3.origin );
		objective_current(level.rail_obj_num);
		objective_ring(level.rail_obj_num);

		level waittill ("station_platform");

		// send the player to the hole in the station wall (but only do objective_current if the text changes)
		objective_position (level.rail_obj_num, spot1.origin );
		objective_ring(level.rail_obj_num);
	}
	else
	{
		// send the player to the hole in the station wall (but only do objective_current if the text changes)
		objective_string(level.rail_obj_num, &"PI_PONYRI_OBJECTIVE1C");
		objective_position (level.rail_obj_num, spot1.origin );
		objective_current(level.rail_obj_num);
		objective_ring(level.rail_obj_num);
	}

	if(level.flags["station1"] == false)
		level waittill ("station1");

	// antonov tells them to go into the station
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_intostation");

	// wait for the player to charge ahead or the bad guys to get killed
	if(level.flags["station2"] == false)
		level waittill("station2_spawn");

	// prod the player to go inside the station
	crumb = getent ( "station2_crumb", "targetname" );
	objective_position (level.rail_obj_num, crumb.origin );
	objective_ring(level.rail_obj_num);

	// send the team to station2
	level.player setFriendlyChain(getnode("station2_chain", "targetname"));

//	println("^5rail_objectives: waiting for station3_start");
	if(level.flags["station3"] == false)
		level waittill ( "station3_start" );
	level.player setfriendlychain ( getnode ( "station3_chain","targetname" ));

	// prod the player to go upstairs
	crumb = getent ( "station3_crumb", "targetname" );
	objective_position (level.rail_obj_num, crumb.origin );
	objective_ring(level.rail_obj_num);

//	println("^5rail_objectives: town_warm_up");
	level thread town_warm_up();
	
	level thread rail_talk();

//	println("^5rail_objectives: waiting for station4_start");
	if(level.flags["station4"] == false)
		level waittill ( "station4_start" );
	level.player setfriendlychain ( getnode ( "station4_chain","targetname" ));

	level notify ("rail_shutup");
	
//	println("^5rail_objectives: waiting for station5_start");
	if(level.flags["station5"] == false)
		level waittill ( "station5_start" );

	level.antonov allowedStances ("stand");

	level.player setfriendlychain ( getnode ( "station5_chain","targetname" ));

	// prod the player to go downstairs
	crumb = getent ( "station5_crumb", "targetname" );
	objective_position (level.rail_obj_num, crumb.origin );
	objective_ring(level.rail_obj_num);

//	println("^5rail_objectives: waiting for station5_done");
	if(level.flags["station_done"] == false)
		level waittill ( "station5_done" );

	// mark the train station as done
	objective_string(level.rail_obj_num, &"PI_PONYRI_OBJECTIVE1");
	objective_state (level.rail_obj_num, "done");

	level.antonov notify ( "stop_running" );
	level.vassili notify ( "stop_running" );
	level.antonov setgoalentity (level.player);
	level.vassili setgoalentity (level.player);

	wait ( 2 );

	// fire up the tank movement
	level.flags["railwalltrig"] = true;
	level notify ( "railwalltrig" );

	// wait just a sec in case people aren't there yet
	wait ( 1 );

	// fire off antonov town speech
	level.antonov thread anim_single_solo(level.antonov,"town_briefing");

	wait ( 3 );

	// the school script should now get ready
	level notify ("continue_school_main");
	level notify ("stop_rail_FX");

	wait ( 3 );

	maps\_utility_gmi::autosave(4);

//	println("^4 rail_objectives - louder");
	level.ambient_sound_distance_base = 384;

	wait ( 0.5 );

	// spawn in the watertower baddies
	watertower_guys = getentarray ( "watertower1", "targetname" );
	if(isdefined (watertower_guys))
	{
		for(x=0;x<watertower_guys.size;x++)
		{
			if(isdefined(watertower_guys[x]))
			{
				guy = watertower_guys[x] dospawn();
			}
		}
	}

	wait ( 0.1 );

	// make the tower guys invulnerable
	watertower_guys = getentarray ( "wt_spotter", "groupname" );
	if(isdefined (watertower_guys))
	{
		for(x=0;x<watertower_guys.size;x++)
		{
			if(isdefined(watertower_guys[x]))
			{
				guy thread maps\_utility_gmi::magic_bullet_shield();
//				println("^5rail_objectives: water tower spotter made invulnerable");
			}
		}
	}

	wait ( 0.1 );

	// put the max friendlies back
	level.maxfriendlies = 6;
	level notify ( "stop_town_warmup");

	Door_Kick();

	wait ( 0.1 );

	// mark the town as the next job
	crumb = getent ( "wt_crumb1", "targetname" );
	objective_add(level.town_obj_num, "active", &"PI_PONYRI_OBJECTIVE2", crumb.origin);
	objective_position (level.town_obj_num, crumb.origin );
	objective_current(level.town_obj_num);
	objective_ring (level.town_obj_num);

	level.antonov allowedStances ("stand", "crouch", "prone");
	level.antonov setgoalentity(level.player);

	level notify ("start_wt_team_movement");

//	println("^4 rail_objectives - Even louder");
	level.ambient_sound_distance_base = 0;
}

rail_talk()
{
	level endon ("rail_shutup");

	speakers = getentarray ("railstation_speaker", "targetname");
	if(isdefined(speakers))
	{
		while (1)
		{
			speakers[0] playsound ("german_jabber1");
			wait(2.2);
			speakers[1] playsound ("german_jabber2");
			wait(0.7);
			speakers[0] playsound ("german_jabber3");
			wait(1.5);
			speakers[1] playsound ("german_jabber4");
			wait(2.5);
			speakers[0] playsound ("german_jabber5");
			wait(2.8);
			speakers[1] playsound ("german_jabber6");
			wait(1.9);
			speakers[0] playsound ("german_jabber7");
			wait(3.6);
		}
	}
}


station_platform()
{
	trig = getent ( "rail_station_entry_obj_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill("trigger");
	
	level notify ("station_platform");
	level.flags["station_platform"] = true;

	level notify ("station0_spawn");
	level.flags["station0_spawn"] = true;

	// allow the player to get onto the rail station platform
	block = getent ( "railstation_platform_player_blocker", "targetname" );
	block maps\_utility_gmi::triggerOff();

	station1();
}

wait_for_group_clear(groupname, threshold, notification_string)
{
	waiting = true;

	grp = getentarray(groupname, "groupname");
	if(isdefined(grp))
	{
		while(waiting)
		{
			german_count = maps\_pi_utils::LiveEntCount(grp);
			if(german_count < threshold)
				waiting = false;
			else
			{
//				println("^4 wait_for_group_clear: " + groupname + " at " + german_count + " / " + threshold + "");
				wait(1);
			}
		}
	}
	else
		println("^5>>>>>>>>>>>> wait_for_group_clear: group " + groupname + "not found!!!");

//	println("^4 wait_for_group_clear: "+groupname+" clear");
	level notify (notification_string);
}	

wait_for_station_clear()
{
	waiting = 1;
	german_count = 1;

	grp1 = getentarray ("station1","groupname");
	grp2 = getentarray ("station2","groupname");
	grp3 = getentarray ("station3","groupname");
	while(waiting)
	{
		wait ( 1 );

		german_count = maps\_pi_utils::LiveEntCount(grp1);
		
		wait ( 1 );
		
		german_count = german_count + maps\_pi_utils::LiveEntCount(grp2);

		wait ( 1 );
		
		german_count = german_count + maps\_pi_utils::LiveEntCount(grp3);

		if(german_count < 1)
			waiting = 0;
	}
	level notify ( "rail_station_clear" );
}

Door_Kick()
{
	node = getnode("door_kick_node","targetname");

	kick_guy[0] = level.antonov ;

	maps\_anim_gmi::anim_pushPlayer(kick_guy);

	kick_anim[0] = "kick_door_1";
	kick_anim[1] = "kick_door_2";

	num = randomint(2);

	anim_reach(kick_guy, kick_anim[num], undefined, node);
	level maps\_anim_gmi::anim_dontPushPlayer(kick_guy);

	level thread anim_single(kick_guy, kick_anim[num], undefined, node);

	kick_guy[0] waittillmatch ("single anim", "kick");

	door = getent("railstation_door1","targetname");
	door2 = getent("railstation_door1a","targetname");
	door playsound("wood_door_kick");
	door2 rotateto((0,100,0), 0.5, 0, 0.2);
	door rotateto((0,-100,0), 0.5, 0, 0.2);
	door waittill("rotatedone");
	door connectpaths();
	door2 connectpaths();
}

town_warm_up()
{
	level endon ( "stop_town_warmup" );

	warming = true;

	spawner_list1 = getentarray ( "town_warm1", "targetname" );
	spawner_list2 = getentarray ( "town_warm2", "targetname" );

	if(isdefined(spawner_list1) && isdefined(spawner_list2))
	{
		while(warming)
		{
			// fire up the russian clown car
			maps\_pi_utils::fire_clown_car (4, spawner_list1, "town_warm_guy1");
			wait(0.5);

			// fire up the german clown car
			maps\_pi_utils::fire_clown_car (4, spawner_list2, "town_warm_guy2");
			wait(0.5);
		}
	}
}

// =====================================
// =====================================
//	APPROACH SEQUENCES
// =====================================
// =====================================

/*
3 T34s, and one Gazaaa loaded with allies put into initial position.  The truck unloads when it nears the player, providing the basis for the westernmost clip wall.
Tanks move along the road between the hills.  Column halts when lead tank encounters the roadblock.
*/
tracks_approach()
{
//	tankblock1 = getent ( "tankblock1", "targetname");
//	tankblock1 maps\_utility_gmi::triggerOff();
	tankblock2 = getent ( "tankblock2", "targetname");
	tankblock2 maps\_utility_gmi::triggerOff();

	t34_1 = getent ( "t34_1", "targetname" );
	t34_1_path = getvehiclenode("t34_1_path","targetname");
	t34_1 attachpath(t34_1_path);

	t34_2 = getent ( "t34_2", "targetname" );
	t34_2_path = getvehiclenode("t34_2_path","targetname");
	t34_2 attachpath(t34_2_path);

	t34_3 = getent ( "t34_3", "targetname" );
	t34_3_path = getvehiclenode("t34_3_path","targetname");
	t34_3 attachpath(t34_3_path);

	tiger_1 = getent ( "tiger_1", "targetname" );
	tiger_1_path = getvehiclenode("tiger_1_path","targetname");
	tiger_1 attachpath(tiger_1_path);

	tiger_2 = getent ( "tiger_2", "targetname" );
	tiger_2_path = getvehiclenode("tiger_2_path","targetname");
	tiger_2 attachpath(tiger_2_path);

	// T34s start moving down the road
	t34_1 startpath();
	t34_1 setspeed ( 4.5, 10 );
	wait ( 0.2 );
	t34_2 startpath();
	t34_2 setspeed ( 4.5, 10 );
	wait ( 0.2 );
	t34_3 startpath();
	t34_3 setspeed ( 4.5, 10 );

	// They pause as the lead tank sees the road ominously blocked ahead
	t34_1_wait1 = getvehiclenode ( "dkramer134", "targetname" );
    t34_1 setwaitnode(t34_1_wait1);
	t34_1 waittill( "reached_wait_node" );

	// swing turret around to the north
	t34_1 setTurretTargetEnt( getent ( "t34_1_target1", "targetname" ), ( 0, 0, 0 ) );

	// proceed north toward the rail station
	t34_1 setspeed(7.5,5);
	t34_2 setspeed(6.5,1);
	t34_3 setspeed(5.5,1);

	// branch off lead tank behavior for timing purposes
	t34_1 thread lead_t34();

	getent("tiger_start", "targetname") waittill ("trigger");
	// uh-oh!  Here come the Tigers!
    tiger_1 startpath();
	tiger_2 startpath();
	getent("tiger_target", "targetname") waittill ("trigger");
	tiger_1 setTurretTargetEnt( t34_1, ( 0, 0, 0 ) );
	tiger_2 setTurretTargetEnt( t34_1, ( 0, 0, 0 ) );

	level waittill("t34_1_fired");

	// wait until the tigers reach their end nodes
	tiger_2 waittill ( "reached_end_node" );

	// tiger1 shoots and kills t34_1
	tiger_2 thread fire_on_target(t34_1, 3 );

	// once t34_1 is dead
	t34_1 waittill ( "death" );

	// t34_3 kills tiger2
	t34_3 thread fire_on_target(tiger_2, 3);

	wait ( 2 );

	// and t34_2 kills tiger1
	t34_2 thread fire_on_target(tiger_1, 3);

	if(isalive(tiger_2))
		tiger_2 waittill ( "death");

	if(isalive(tiger_1))
		tiger_1 waittill("death");

	// once both tigers are dead, t34s can move up
	level.flags["t34_3_proceed"] = true;
	level notify("t34_3_proceed");
}

group1_start_running()
{
	level waittill ("actually_start_running");

	friendlies_group1 = getentarray("friendlies_group1","groupname");
	immortals_group1 = getentarray("friends", "groupname");
	friendlies_playergroup = add_array_to_array(immortals_group1, friendlies_group1);

	// start the friends running
	for(i=0;i<friendlies_playergroup.size;i++)
	{
		friendlies_playergroup[i] setgoalentity(level.player);
		friendlies_playergroup[i].bravery = 1000;
	}
}

friends_approach()
{
	level.boris.groupname = "friends2";
	level.vassili.groupname = "friends2";

	level thread group1_start_running();

	viswall = getent("rail_fight1_viswall1", "targetname");
	viswall maps\_utility_gmi::triggerOff();

	// we'll key our comrades' advance off t34_2's nodes
	t34_2 = getent ( "t34_2", "targetname" );

	t34_2 setwaitnode(getvehiclenode("dkramer276","targetname"));
	t34_2 waittill("reached_wait_node");
	level.player setfriendlychain(getnode("antonov0","targetname"));

	t34_2 setwaitnode(getvehiclenode("dkramer126","targetname"));
	t34_2 waittill("reached_wait_node");
	level.player setfriendlychain(getnode("dkramer289","targetname"));

	level thread maps\_pi_utils::objective_tracker(level.rail_obj_num, t34_2);

	t34_2 setwaitnode(getvehiclenode("dkramer278","targetname"));
	t34_2 waittill("reached_wait_node");
	level.player setfriendlychain(getnode("antonov1","targetname"));
	level.flags["Rail_Assault_Dummies"] = false; // stop the assault dummies

	t34_2 setwaitnode(getvehiclenode("dkramer127","targetname"));
	t34_2 waittill("reached_wait_node");
	spot = getnode("dkramer296","targetname");
	level.player setfriendlychain(spot);

	// PGM FIXME - change the VO dropoff rate so the player hears this for sure?
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_tankcover");

	t34_2 setwaitnode(getvehiclenode("dkramer284","targetname"));
	t34_2 waittill("reached_wait_node");
	spot = getnode("dkramer301","targetname");
	level.player setfriendlychain(spot);

	t34_2 setwaitnode(getvehiclenode("dkramer282","targetname"));
	t34_2 waittill("reached_wait_node");
	spot = getnode("antonov2","targetname");
	level.player setfriendlychain(spot);

	t34_2 setwaitnode(getvehiclenode("dkramer283","targetname"));
	t34_2 waittill("reached_wait_node");
	spot = getnode("antonov3","targetname");
	level.player setfriendlychain(spot);

	t34_2 setwaitnode(getvehiclenode("dkramer285","targetname"));
	t34_2 waittill("reached_wait_node");
	spot = getnode("dkramer314","targetname");
	level.player setfriendlychain(spot);

	t34_2 setwaitnode(getvehiclenode("dkramer211","targetname"));
	t34_2 waittill("reached_wait_node");
	spot = getnode("antonov4","targetname");
	level.player setfriendlychain(spot);

	t34_2 setwaitnode(getvehiclenode("dkramer212","targetname"));
	t34_2 waittill("reached_wait_node");
	spot = getnode("dkramer319","targetname");
	level.player setfriendlychain(spot);

	t34_2 setwaitnode(getvehiclenode("dkramer214","targetname"));
	t34_2 waittill("reached_wait_node");
	spot = getnode("dkramer324","targetname");
	level.player setfriendlychain(spot);

	t34_2 setwaitnode(getvehiclenode("dkramer215","targetname"));
	t34_2 waittill("reached_wait_node");
	spot = getnode("antonov5","targetname");
	level.player setfriendlychain(spot);

	// antonov5 is the last spot that the right side tank stops at

	tankblock2 = getent ( "tankblock2", "targetname");
	tankblock2 maps\_utility_gmi::triggerOn();

	// send antonov and friend to behind the rock so they can shoot
	level.player setfriendlychain(getnode("rail_rock_chain", "targetname"));

	level notify ( "stop_objective_tracker" );

	spot = getent ( "rail_station_obj", "targetname" );
	objective_position (level.rail_obj_num, spot.origin );
	objective_ring(level.rail_obj_num);

//	level.flags["Fake_Rail_MGs"] = false ;

	t34_2 setspeed(0,6);

	if(level.flags["t34_3_proceed"] == false)
		level waittill("t34_3_proceed");

	tankblock2 maps\_utility_gmi::triggerOff();

	viswall maps\_utility_gmi::triggerOn();

	// drive up a little bit
	t34_2 setspeed(6,1);
	t34_2 setwaitnode(getvehiclenode("dkramer241","targetname"));
	t34_2 waittill("reached_wait_node");

	t34_2 setspeed(0,6);

	// reset our turret target while t34_3 moves into secondary position
	wait(1.5);
	t34_2 setTurretTargetEnt( getent ( "t34_1_target2", "targetname" ), ( 0, 0, 15 ) );
}

friends_railyard_movement()
{
//	println("^5 friends_railyard_movement: MOVING TO RAIL FIGHT 1 COVER CHAIN");

	level.player setfriendlychain( getnode("rail_fight1_chain","targetname"));
	level.flags["t34_mg_fire"] = false;		// turn off t34 fire for a bit
	level.flags["t34_fake_turret_fire"] = true;		// make the t34s fire the main guns for a while

	wait ( 5 );

	viswall = getent("rail_fight1_viswall1", "targetname");
	viswall maps\_utility_gmi::triggerOff();

	if(level.flags["flankspeech"] == false)
		level waittill ( "flankspeech" );

	viswall = getent("rail_fight1_viswall2", "targetname");
	viswall maps\_utility_gmi::triggerOff();

	// send boris and miesha ahead to cover spots
	wait ( 1 );
//	println("^5 RA: boris and miesha ahead to fighting cover");
	level.boris setgoalnode(getnode("ra_boris_spot","targetname"));
	level.miesha setgoalnode(getnode("ra_miesha_spot","targetname"));

	// send the team up to fight 2 when the speech is done
	if(level.flags["flankspeech_done"] == false)
		level waittill ("flankspeech_done");
	level.player setfriendlychain( getnode("rail_fight2_chain","targetname"));

	level.flags["t34_mg_fire"] = true;		// let the T34s shoot again

	// move everyone up into the midst of fight2
	if(level.flags["rail_fight2_movein"] == false)
		level waittill ("rail_fight2_movein");

	level.flags["t34_fake_turret_fire"] = false;		// stop the t34s fire the main guns for a while

//	println("^5 RA: got fight2 move in command!!!");
	level.player setfriendlychain( getnode("rail_fight2_movein","targetname"));

	// now bring miesha and boris back to the team
//	println("^5 RA: boris and miesha rejoin group");
	level.boris setgoalentity(level.player);
	level.miesha setgoalentity(level.player);

	// move up to the supply depot
	if(level.flags["rail_fight2_done"] == false)
		level waittill ("rail_fight2_done");

//	println("^5 RA: moving up for fight3");
	level.player setfriendlychain( getnode("rail_fight3_chain","targetname"));

	blind_teamchain_guys_until_goal(900000);

	level thread antonov_tower_speech();

	// start the friends going towards the station
	if(level.flags["rail_tower_done"] == false)
		level waittill ("rail_tower_done");
//	level.player setFriendlyChain(getnode ( "station0_chain", "targetname" ));

	// wait for the station0 guys to get killed and fight3 to finish
	wait_for_group_clear("station0", 1, "station0_done");

	// then send the team to the station entry point
	level.player setFriendlyChain(getnode ( "station_entry_chain", "targetname" ));

	// turn off birdcage #1
	birdcage = getent ("ra_birdcage1", "targetname");
	if(isdefined(birdcage))
	{
//		println("^5 >> removing the ra_birdcage1 birdcage");
		birdcage maps\_utility_gmi::triggerOff();	// this moves the wall out of play
		birdcage connectpaths();
	}

	// send boris and miesha off to south side of station
	level.miesha setgoalnode ( getnode ( "miesha_station_spot", "targetname" ) );
	level.boris setgoalnode ( getnode ( "boris_station_spot", "targetname" ) );

	// wait for the player to move into the station building
	if(level.flags["railwallmoveup"] == false)
		level waittill ( "railwallmoveup" );

	// get miesha out of the way of the tanks
	level.miesha setgoalnode ( getnode ( "miesha_duck_spot", "targetname" ) );
}

antonov_tower_speech()
{
	if(level.flags["rail_tower_done"] == false)
		level.antonov waittill("goal");

	level.flags["rail_sniper_active"] = true;
	level notify ( "rail_sniper_active" );

	for(x=0;x<3;x++)
	{
		if(level.flags["rail_tower_done"] == false)
//			level.antonov playsound ("antonov_railsnipers");
			level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_railsnipers");
		
		wait(20);
	}
}

blind_run_to_teamchain(temp_sight_sqrd)
{
	if(!isdefined(temp_sight_sqrd))
		temp_sight_sqrd = 10;


	if(isdefined(self))
	{
		self endon("death");

//		println("^3 blind_run_to_teamchain: blind running to chain");
		self.maxsightdistsqrd = temp_sight_sqrd;	// make him blind
		self.suppressionwait = 0;
		self.pacifist = true;

		self waittill ("goal");

		self.maxsightdistsqrd = 9000000;	// restore sight to 3000
		self.suppressionwait = 1;
		self.pacifist = false;
//		println("^3 blind_run_to_teamchain: blind running done");
	}
}

blind_teamchain_guys_until_goal(temp_sight_sqrd)
{
	if(!isdefined(temp_sight_sqrd))
		temp_sight_sqrd = 10;

	level.boris thread blind_run_to_teamchain(temp_sight_sqrd);
	level.vassili thread blind_run_to_teamchain(temp_sight_sqrd);
	level.miesha thread blind_run_to_teamchain(temp_sight_sqrd);
	level.antonov thread blind_run_to_teamchain(temp_sight_sqrd);

	guys = getentarray("friendlywave_guy", "groupname");
	if(isdefined(guys))
	{
		for(x=0;x<guys.size;x++)
		{
			if(isdefined(guys[x]) && issentient(guys[x]) && isalive(guys[x]))
				guys[x] thread blind_run_to_teamchain(temp_sight_sqrd);
		}
	}
}

group2_start_running(group2_leader, group2_immortal)
{
	level waittill ("actually_start_running");

//	println("^5 group2_start_running: starting to run!");

	group2_leader setgoalentity(group2_leader);
	group2_immortal setgoalentity(group2_leader);

	friendlies_group2 = getentarray("friendlies_group2","groupname");
	for(i=0;i<friendlies_group2.size;i++)
	{
		friendlies_group2[i] setgoalentity(group2_leader);
//		friendlies_group2[i].threatbias = -500;
		friendlies_group2[i].bravery = 1000;
	}
}

group2_approach()
{
	group2_leader = level.vassili;
	group2_immortal = level.boris;

	level thread group2_start_running(group2_leader, group2_immortal);

//	println("^4 group2_approach: setting boris and vassili to group2 chain");
	group2_leader setfriendlychain(getnode("group2_start_chain","targetname"));

	// we'll key our comrades' advance off t34_3's nodes
	t34_3 = getent ( "t34_3", "targetname" );

	t34_3 setwaitnode(getvehiclenode("dkramer132","targetname"));
	t34_3 waittill("reached_wait_node");
	group2_leader setfriendlychain(getnode("antonov0","targetname"));

	t34_3 setwaitnode(getvehiclenode("dkramer330","targetname"));
	t34_3 waittill("reached_wait_node");
	group2_leader setfriendlychain(getnode("dkramer289","targetname"));

	t34_3 setwaitnode(getvehiclenode("dkramer329","targetname"));
	t34_3 waittill("reached_wait_node");
	group2_leader setfriendlychain(getnode("antonov1","targetname"));

	t34_3 setwaitnode(getvehiclenode("dkramer133","targetname"));
	t34_3 waittill("reached_wait_node");
	group2_leader setfriendlychain(getnode("dkramer296","targetname"));

	t34_3 setwaitnode(getvehiclenode("pgm1094","targetname"));
	t34_3 waittill("reached_wait_node");
	group2_leader setfriendlychain(getnode("antonov2","targetname"));

	t34_3 setwaitnode(getvehiclenode("dkramer332","targetname"));
	t34_3 waittill("reached_wait_node");
	group2_leader setfriendlychain(getnode("pgm1095","targetname"));

	t34_3 setwaitnode(getvehiclenode("dkramer149","targetname"));
	t34_3 waittill("reached_wait_node");
	group2_leader setfriendlychain(getnode("dkramer333","targetname"));

//	println("^5Group2 moving 6 -> T34-3 HIT 332");

	t34_3 setwaitnode(getvehiclenode("t34_3_firepause","targetname"));
	t34_3 waittill("reached_wait_node");
	t34_3 setspeed(0,2);
	t34_3 setTurretTargetEnt( getent ( "t34_1_target2", "targetname" ), ( 0, 0, 0 ) );

	group2_leader setfriendlychain(getnode("dkramer349","targetname"));

//	println("^2 group2_approach: t34_3 at wait node t34_3_firepause");

	if(level.flags["t34_3_proceed"] == false)
		level waittill("t34_3_proceed");

//	println("^2 group2_approach: t34_3_proceed RECIEVED by t34_3 in third_t34();");
	t34_3 setspeed(6,1);

	t34_3 setwaitnode(getvehiclenode("dkramer150","targetname"));
	t34_3 waittill("reached_wait_node");
	group2_leader setfriendlychain(getnode("pgm1096","targetname"));

	t34_3 setwaitnode(getvehiclenode("dkramer228","targetname"));
	t34_3 waittill("reached_wait_node");
	group2_leader setfriendlychain(getnode("pgm1101","targetname"));

	t34_3 setwaitnode(getvehiclenode("dkramer229","targetname"));
	t34_3 waittill("reached_wait_node");
	group2_leader setfriendlychain(getnode("pgm1101","targetname"));

	t34_3 setspeed(0,10);

	level thread friends_railyard_movement();

	// handles tanks breaking through wall
	level thread maps\ponyri_watertower::RailWallBreakthrough();

	wait(1);

	friendlies_group2 = getentarray("friendlies_group2","groupname");
	if( isdefined(friendlies_group2) )
	{	
		// return group 2 to 'normal'
		for(i=0;i<friendlies_group2.size;i++)
		{
			if(isdefined(friendlies_group2[i]) && isalive(friendlies_group2[i]) && issentient(friendlies_group2[i]))
			{
				friendlies_group2[i].pacifist = false;
				friendlies_group2[i].maxsightdistsqrd = 10000000;
				friendlies_group2[i].suppressionwait = .5;
				friendlies_group2[i].goalradius = 256;
				friendlies_group2[i].threatbias = 0;
				friendlies_group2[i].bravery = 100;
			}
		}
	}

	group2_leader setfriendlychain(getnode("rail_group2_fight1_chain","targetname"));

	if(level.flags["flankspeech_done"] == false)
		level waittill ("flankspeech_done");

	friendlies_group2 = getentarray("friendlies_group2","groupname");
	if( isdefined(friendlies_group2) )
	{	
		// return group 2 to 'normal'
		for(i=0;i<friendlies_group2.size;i++)
		{
			if(isdefined(friendlies_group2[i]) && isalive(friendlies_group2[i]) && issentient(friendlies_group2[i]))
				friendlies_group2[i] setgoalentity(level.player);
		}
	}

	group2_leader.groupname = "friends";
	group2_immortal.groupname = "friends";
	group2_immortal setgoalentity(level.player);
	group2_leader setgoalentity(level.player);
}

lead_t34()
{

	// start the panzerfaust guy
	t34_1_wait2 = getvehiclenode ( "t34_1_postpause", "targetname" );
    self setwaitnode(t34_1_wait2);
	self waittill( "reached_wait_node" );
	level notify("Panzerfaust_Guy_Go");

	// point the lead tank's turret at the rail station
	t34_1_wait2 = getvehiclenode ( "dkramer135", "targetname" );
    self setwaitnode(t34_1_wait2);
	self waittill( "reached_wait_node" );
	t34target = getent ( "t34_1_target2", "targetname" );
	self setTurretTargetEnt( t34target, ( 0, 0, 0 ) );
	wait(6);

	rocketstart = getent ( "rail_pfguy", "targetname" );
	rockettarget = getent("rail_pfguy_target", "targetname");
	maps\ponyri_dummies::launch_panzerfaust ( rocketstart, rockettarget, 1, "rocketexplosion_dirt");

	wait(2);
	// Lead T34 blows a chunk out of the rail station...
	self setTurretTargetEnt(t34target, ( 0, 0, 0 ) );
	self FireTurret();
	wait(.1);
	thread maps\_utility_gmi::exploder(102);

	//swap sandbags
	dmgbags = getent("railyard_mg42_nest_01_damaged","targetname");
	dmgbags maps\_utility_gmi::triggerOn();
	goodbags = getent("railyard_mg42_nest_01","targetname");
	goodbags maps\_utility_gmi::triggerOff();
	radiusdamage(dmgbags.origin + (0,0,48), 300, 20000, 20000);

	// a few optional smoke effects for the platform corner
	if(getcvarint("scr_gmi_fast") < 2)
		maps\ponyri_fx::spawnPlatformFX();

	// kill the Area A guys for good measure
	main_gunner = getent("axis_mg_1", "targetname");
	if(isdefined(main_gunner))
	{
		main_gunner dodamage(main_gunner.health+50,main_gunner.origin);
	}
	replacement_gunner = getent("axis_mg_1_replacement", "targetname");
	if(isdefined(replacement_gunner))
	{
		replacement_gunner dodamage(replacement_gunner.health+50,replacement_gunner.origin);
	}

	angles = vectornormalize(t34target.origin - dmgbags.origin);
	playfx(level._effect["blow_mg42_nest"], dmgbags.origin, angles);

	wait(.5);
	// ...then notices it's about to be smacked by two Tigers.
	self endon ("death");
	tiger_1 = getent ( "tiger_1", "targetname" );

	self waittill("reached_end_node");
	level notify("t34_1_fired");

	if (self.health > 0)
	{
		self  setTurretTargetEnt( tiger_1, ( 0, 0, 0 ) );
	}
}

// fire at this target until I'm dead or the target is
fire_on_target(target, delay)
{
	self.engaged = true;
	self endon("death"); // end if I get killed
	self endon("change_target");
	self setTurretTargetEnt( target, ( 0, 0, 60 ) );
	if ( self.health > 0)
	{
		wait (delay);
		while (isalive(target))
		{
			if ( self.health > 0)
			{
				self setTurretTargetEnt( target, ( 0, 0, 60 ) );
			}
			self waittill( "turret_on_vistarget" );
			self FireTurret();
			if ( self.health > 0)
			{
				wait (5 + randomfloat(3));
			}
			else
			{
				break;
			}
		}
	}
}

delayed_run_to_target()
{
	if(isdefined(self.target))
	{
		self endon("death");
		wait(0.1);
		self maps\_pi_utils::run_blindly_to_nodename(self.target, "targetname", 10);
	}
}

// =======================
// =======================
//   FIGHT 1
// =======================
// =======================

fight1()
{
	// handle the magic bullet shield
	trig = getent ( "rail_fight1_mbs_trigger", "targetname" );
	if(isdefined(trig))
	{
		guys = getentarray("rail_fight_1", "groupname");
		if(isdefined(guys))
		{
			for(x=0;x<guys.size;x++)
			{
				if(isdefined(guys[x]) && issentient(guys[x]) && isalive(guys[x]))
				{
					guys[x] thread maps\_utility_gmi::magic_bullet_shield();
				}
			}
			
			if(isdefined(trig))
				trig waittill ( "trigger" );

			guys = getentarray("rail_fight_1", "groupname");
			if(isdefined(guys))
			{
				for(x=0;x<guys.size;x++)
				{
					if(isdefined(guys[x]) && issentient(guys[x]) && isalive(guys[x]))
					{
						guys[x] notify ("stop magic bullet shield");
					}
				}
			}
			else println("^4 fight1: COULDNT TURN OFF MBS!!!!");
		}
		else println("^4 fight1: couldnt find guys to set MBS");
	}

	wait_for_group_clear ("rail_fight_1", 2, "rail_fight1_done");

//	println("^5 fight1	: firing off fight2");
	level notify ( "rail_fight2_spawn");
	level.flags["flankspeech"] = true;
	level notify ( "flankspeech" );
}

// =======================
// =======================
//   FIGHT 2
// =======================
// =======================

// triggered when player crosses over towards the left side sandbags
fight2_manual_start()
{
	level endon ("rail_fight2_respawn");

	trig = getent("rail_fight2_manual_start","targetname");
	if(isdefined(trig))
		trig waittill("trigger");

	thread station_platform();

//		println("^5 fight2_manual_start: firing fight2 guys");
	level notify ("rail_fight2_spawn");

	level notify("rail_fight2_mbs");
	level.flags["rail_fight2_mbs"] = false;

	trig = getent("rail_fight2_manual_respawn","targetname");
	if(isdefined(trig))
		trig waittill("trigger");

	// if the player gets here, spawn in the rest of the supply depot guys
	level notify ("rail_fight2_respawn");
//	println("^5 fight2_manual_respawn: firing respawn guys");
}

fight2_spawn()
{
//	println("waiting for fight2 to start");
	level waittill ("rail_fight2_spawn");
//	println("starting fight2");

	// spawn in the front line of baddies and send them on their way
	spawners = getentarray("rail_fight2","targetname");
	for(x=0;x<spawners.size;x++)
	{
		guy = spawners[x] dospawn();
		if(isdefined(guy))
		{
//			println("^5Area_F_Spawn: new FRONT bad guy!");
			guy.groupname = "rail_fight2_guy";

			if(level.flags["rail_fight2_mbs"] == true)
				guy thread maps\_utility_gmi::magic_bullet_shield();
			guy thread delayed_run_to_target();
		}
	}

	// turn off the magic bullet shield
	if(level.flags["rail_fight2_mbs"] == true)
	{
		level waittill ("rail_fight2_mbs");
		guys = getentarray("rail_fight2_guy", "groupname");
		if(isdefined(guys))
		{
			for(x=0;x<guys.size;x++)
				guys[x] notify ("stop magic bullet shield");
		}
	}

	level thread wait_for_group_clear ("rail_fight2_guy", 3, "rail_fight2_respawn");
//	println("waiting to spawn in fight2 reinforcements");
	level waittill ("rail_fight2_respawn");

//	println("^5 fight2: move in!");
	level.flags["rail_fight2_movein"] = true;
	level notify("rail_fight2_movein");

	// spawn in the second round of baddies and send them on their way
	spawners = getentarray("rail_fight2w","targetname");
	for(x=0;x<spawners.size;x++)
	{
		guy = spawners[x] dospawn();
		if(isdefined(guy))
		{
//			println("^5Area_F_Spawn: new REINFORCEMENT bad guy!");
			guy.groupname = "rail_fight2_guy";
		}
	}

	wait_for_group_clear ("rail_fight2_guy", 2, "rail_fight2_respawn");

	level.flags["rail_fight2_done"] = true;
	level notify ("rail_fight2_done");
	
	rail_fight3_spawn();
}

// =======================
// =======================
//   FIGHT 3
// =======================
// =======================

rail_fight3_respawn()
{
	level endon ("rail_fight3_stop_respawn");

	respawning = true;
	while(respawning)
	{
		guy = self dospawn();
		if(isdefined(guy))
		{
//			println("^4 rail_fight3_respawn: window guy");
			guy waittill("death");
		}
		else
		{
			wait(0.5);
		}
	}
}

rail_fight3_spawn()
{
	level thread station0_spawn();

	// spawn in the window guys and send them on their way
	spawners = getentarray("rail_fight3","targetname");
	for(x=0;x<spawners.size;x++)
	{
		spawners[x] thread rail_fight3_respawn();
		wait(0.1);
	}

	// spawn in the north building baddies and send them on their way
	spawners = getentarray("rail_fight3_north","targetname");
	for(x=0;x<spawners.size;x++)
	{
		guy = spawners[x] dospawn();
		if(isdefined(guy))
		{
			guy.targetname = "rail_fight3_north_guy";
			snipers = maps\_utility_gmi::add_to_array(snipers, guy);
			guy thread maps\_utility_gmi::magic_bullet_shield();
			wait(0.1);
			guy.goalradius = 16;
		}
	}

	if(level.flags["rail_sniper_active"] == false)
		level waittill ("rail_sniper_active");

	if(isdefined(snipers))
	{
		for(x=0;x<snipers.size;x++)
			snipers[x] notify ("stop magic bullet shield");
	}

	level notify ( "station0_spawn" );
	level.flags["station0_spawn"] = true;

	wait_for_group_clear ("rail_fight3_north", 1, "rail_fight3_stop_respawn");

	level.flags["rail_tower_done"] = true;
	level notify ( "rail_tower_done");

	level notify ( "rail_fight3_stop_respawn" );
}

// =================
// =================
// STATION 0 (getting up to the building)
// =================
// =================

station0_spawn()
{
	if(level.flags["station0_spawn"] == false)
		level waittill ( "station0_spawn" );

	spawners = getentarray("station0","targetname");
	for(x=0;x<spawners.size;x++)
	{
		guy = spawners[x] dospawn();
		if(isdefined(guy))
		{
			guy.groupname = "station0";
			guy.bravery = 20;
			if(level.flags["station0_premature"] == false)
			{
				guy.dontdropweapon = 1;
			}
		}
	}

	while(level.flags["station0_premature"] == false)
	{
		wait_for_group_clear ("station0", 4, "station0_more_guys");
		if(level.flags["station0_premature"] == false)
		{
			spawners = getentarray("station0","targetname");
			for(x=0;x<spawners.size;x++)
			{
				guy = spawners[x] dospawn();
				if(isdefined(guy))
				{
					guy.groupname = "station0";
					guy.bravery = 20;
					guy.dontdropweapon = 1;
				}
			}
			wait (1);
		}
	}
}


// =================
// =================
// STATION 1 (getting in the door)
// =================
// =================

station1()
{
	trig = getent( "station1_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");

	level notify ("station1");
	level.flags["station1"] = true;

	thread station2();
	wait(0.1);
	thread station2_force_respawn();
	wait(0.1);
	maps\ponyri_fx::spawnStationFX();

	// we don't want guys spawning behind the player
	level.flags["station0_premature"] = true;
	level notify ( "station0_premature" );

	birdcage = getent ("station0_birdcage", "targetname");
	if(isdefined(birdcage))
	{
//		println("^5 >> removing the station0 birdcage");
		birdcage maps\_utility_gmi::triggerOff();	// this moves the wall out of play
		birdcage connectpaths();
	}

	level.flags["railwallmoveup"] = true;
	level notify ( "railwallmoveup" );
	
	spawners = getentarray("station1", "targetname");
	for(x=0;x<spawners.size;x++)
	{
		guy = spawners[x] dospawn();
	}

//	println("^4 station1: waiting for group clear");
	wait_for_group_clear("station1", 1, "station2_spawn");
	level notify("station2_spawn");
	level.flags["station2"] = true;
}

// =================
// =================
// STATION 2 (main downstairs room)
// =================
// =================

station2_spawn()
{
	level waittill ("station2_spawn");

	spawners = getentarray("station2", "targetname");
	for(x=0;x<spawners.size;x++)
	{
		guy = spawners[x] dospawn();
	}

	thread station3();
	
//	println("^4 station2: waiting for group station2 clear");
	level thread wait_for_group_clear("station2", 2, "station2_respawn");

	if(level.flags["station2_respawn"] == false)
	{
		level waittill ( "station2_respawn");
		level.flags["station2_respawn"] = true;
	}

//	println("^4 station2_spawn: spawning reinforcements");

	spawners = getentarray("station2w", "targetname");
	for(x=0;x<spawners.size;x++)
	{
		guy = spawners[x] dospawn();
		if(isdefined(guy))
		{
//			println("^4 station2_spawn: reinforcement!");
			guy thread delayed_run_to_target();
		}
	}

	wait_for_group_clear("station2", 1, "station3_start");
}

station2_force_respawn()
{
	level endon ( "station2_respawn" );

	trig = getent( "station2_respawn", "targetname" );
	if(isdefined(trig))
	{
		trig waittill ("trigger");

//		println("^4 station2_force_respawn: forcing respawn!");
		level.flags["station2_respawn"] = true;
		level notify ( "station2_respawn");
	}
}

station2()
{
	level thread station2_spawn();

	trig = getent( "station2_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");

	maps\_pi_utils::KillEntArray("rail_fight3_north","groupname");

	level notify ("station2_spawn");

//	println("^4 station2 - Quieter");
	level.ambient_sound_distance_base = 384;

	wait ( 5 );

//	println("^4 station2 - Even Quieter");
	level.ambient_sound_distance_base = 768;
}

// ==========================
// ==========================
//  STATION 3 (going up the stairs)
// ==========================
// ==========================

station3_trigger()
{
	trig = getent("station3_trigger");
	if(isdefined(trig))
		trig waittill("trigger");

	level notify ("station3_start");
	level.flags["station3"] = true;
}

station3()
{
	level waittill ( "station3_start" );
	level.flags["station3"] = true;

//	println("^4 station3: spawning bad guys");

	spawners = getentarray("station3", "targetname");
	for(x=0;x<spawners.size;x++)
	{
		guy = spawners[x] dospawn();
	}

	thread station4();
	wait(0.1);
	thread station4_trigger();
	wait(0.1);
	
	wait_for_group_clear("station3", 1, "station4_start");
}

// ==========================
// ==========================
//  STATION 4 (mopping up upstairs)
// ==========================
// ==========================

station4_trigger()
{
	trig = getent("station4_trigger", "targetname");
	if(isdefined(trig))
		trig waittill("trigger");

//	println("^5 station4_trigger: station4 MBS turning off");
	level.flags["station4_mbs"] = false;
	level notify ("station4_mbs");

	level notify ("station4_start");
	level.flags["station4"] = true;
}

station4()
{
	level waittill ( "station4_start" );
	level.flags["station4"] = true;

	spawners = getentarray("station4", "targetname");
	for(x=0;x<spawners.size;x++)
	{
		guy = spawners[x] dospawn();
		if(level.flags["station4_mbs"] == true)
		{
//			println("^5 station4: station4 MBS turned on");
			station4_guys = maps\_utility_gmi::add_to_array(station4_guys, guy);
			guy thread maps\_utility_gmi::magic_bullet_shield();
		}
	}

	if(	level.flags["station4_mbs"] == true )
	{
//		println("^5 station4: station4 MBS waiting for deactivation");
		level waittill ("station4_mbs");

		if(isdefined(station4_guys))
		{
			for(x=0;x<station4_guys.size;x++)
			{
//				println("^5 station4: station4 MBS deactivated on dude");
				station4_guys[x] notify ("stop magic bullet shield");
			}
		}
	}
	
	wait_for_group_clear("station4", 1, "station5_start");

	station5();
}

// ==========================
// ==========================
//  STATION 5 (guys kicking door open)
// ==========================
// ==========================
station5_pester()	// yell at the player to come downstairs
{
	level endon ("station5_trigger");

	wait ( 10 );

	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_secure");
	wait ( 20 );
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_secure");
}

station5()
{
	level.flags["station5"] = true;

	// wait for the player to come downstairs
	trig = getent ( "station5_trigger", "targetname" );
	if(isdefined(trig))
	{
		level thread station5_pester();

		trig maps\_utility_gmi::triggerOn();
		trig waittill ("trigger");

		level notify ("station5_trigger");
	}

	spawners = getentarray("station5", "targetname");
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			guy = spawners[x] dospawn();
		}

		door = getent("station_inside_door","targetname");
		door playsound("wood_door_kick");
		door rotateto((0,-90,0), 0.5, 0, 0.2);
		door waittill("rotatedone");
		door connectpaths();

		// send guys running for cover!
		level.player setfriendlychain(getnode("station5_cover_chain","targetname"));
	}

	wait_for_group_clear("station5", 1, "station5_done");
	level.flags["station_done"] = true;
}

//===============================================
// UTIL CODE
//===============================================

Rail_ReplaceApproach(guy)
{
//	println("^2Rail_ReplaceApproach Friendly Wave Guy Spawned!");
	guy.targetname = "friendlywave_guy";
	guy.groupname = "friendlywave_guy";

	wait ( 0.1 );

	guy.goalradius = 128;
	guy.followmin = -3;
	guy.followmax = 1;
	guy setgoalentity (level.player);
}

// ------ gameplay cleanup fns

CleanRailyard()
{
//	level.flags["MG_Nest1_active"] = false; // stop the respawning of the now-destroyed Area A.
//	level.flags["Area_F_spawning"] = false;

	wait(2);

	maps\_pi_utils::DeleteEntArray("rail_fight_1", "groupname");
	wait(0.1);
	maps\_pi_utils::DeleteEntArray("rail_fight2", "targetname");
	wait(0.1);
	maps\_pi_utils::DeleteEntArray("rail_fight3_north", "targetname");
}

CleanRailStation()
{
	maps\_pi_utils::DeleteEntArray("station0", "groupname");
	wait(0.1);
	maps\_pi_utils::DeleteEntArray("station1", "groupname");
	wait(0.1);
	maps\_pi_utils::DeleteEntArray("station2", "groupname");
	wait(0.1);
	maps\_pi_utils::DeleteEntArray("station3", "groupname");
	wait(0.1);
	maps\_pi_utils::DeleteEntArray("station4", "groupname");
	wait(0.1);
	maps\_pi_utils::DeleteEntArray("station5", "groupname");
	wait(0.1);
}

// ------ PI utility fns

// AssignGroupLeader sets array's members to have the 0th member as their goalentity

AssignGroupLeader( array )
{
	for(i=0;i<array.size;i++)
	{
		array[i] setgoalentity(array[0]);
	}
}

// ------ GMI/IW utility fns------------

// Adds the 2 given arrays together and returns them into 1 array
add_array_to_array(array1, array2)
{
	if(!isdefined(array1) || !isdefined(array2))
	{
//		println("^3(ADD_ARRAY_TO_ARRAY)WARNING! WARNING!, ONE OF THE ARRAYS ARE NOT DEFINED");
		return;
	}

	array = array1;

	for(i=0;i<array2.size;i++)
	{
		array[array.size] = array2[i];
	}
	return array;
}

anim_reach (guy, anime, tag, node, tag_entity)
{
	maps\_anim_gmi::anim_reach(guy, anime, tag, node, tag_entity);
}

anim_single (guy, anime, tag, node, tag_entity)
{
	maps\_anim_gmi::anim_single (guy, anime, tag, node, tag_entity);
}

anim_single_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;

	maps\_anim_gmi::anim_single (newguy, anime, tag, node, tag_entity);
}
