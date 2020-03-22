//level thread maps\bastogne1_add::main();  // used to load up the level to this event

// need to add parrallel cover for the fight from the second house to the barn -- fighting off germans as they come from over the hill

// event where germans move up and try to kill wounded americans in barn
// fight a couple of germans on the way to crossroads

// germand fighting another squad at crossroads as the player aproaches

// added friendly that are hurt with place holder text stating anim


// add cross roads event


// ask about why I'm unable to spawn in any friendly guys to the level

// need to get friendly wounded in

// got cross roads guys in only enemy is spawning though.

// make friendlies work at cross roads and spawn in some more enemies and it should be ok...

// hourly updates

// check in where are you what has been done
	// need to get pc working at the moment .. This may be linked to Graydient.

	// need to make moody run upstairs to hear dialogue, then continue map

//=====================================================================================================================
// * * * EVENT 4 to 7 * * * 
//
//	Event 2 encompasses the clearing of the house, interrogation, ally protection and cross roads events
//=====================================================================================================================

//===================================================================
//
// Debug setup so this can be skipped to
//
//===================================================================
main_debug()
{
	// process the skipto
//	level thread event4_debug_skipto();
	
	//level waittill("event6_end");
//	level notify("event7_begin");



//	maps\_load_gmi::main();
//	maps\bastogne2_fx::main();
//	maps\bastogne2_anim::main();
//	maps\_bmwbike_gmi::main();

//	maps\_debug_gmi::main();

	level.ally_prisoner_count = 0;
	level.house_guard_count = 0;
	level.cross_german_count = 0;
	level.german_truck_count = 0;

	level.flag["farm_alerted_once"] = false;
	level.flag ["crossroads_alive"] = false;

	// --- Level.Stuff --- //
	// Used for the min/max delay of the distant lights
	level.dist_light_min_delay = 5;
	level.dist_light_max_delay = 15;

	level thread Ambience_Setup();

//		println("^6 ****************** event 4 event4_guys_setup before ****************");
//	level thread event4_init();
	level.player setorigin ((5270, 2916, -67));
//	level.player setorigin ((5152, 3368, -1000));
	wait 4;

//	level thread util_squad1_follow_player();

//	level thread event4_guys_setup();

	level thread hurt_squad_setup();
	level thread axis_clean_up();

	level thread event4_exec();
	level thread event4a_inter();	//starts the event where the officer is caught
//	level thread alpha_squad_setup();
	level thread barn_enter_setup();
	level thread barn_exit_setup();
	level thread setup_crossroad();
	level thread squad3_setup();
	level thread stay_behind_setup();
	level thread crossroads_clear();
	level thread delete_ambient_squad2();
	level thread event6_vehicle_init();

	level thread ambient_trucks_crossroads();

	level thread cross_squad_runaway();

	level thread flood_spawners_controller_crossroads();
	level thread event6_own_player();
	level thread whitney_block_player();
	level thread moody_talk_ridge();
	level thread ram_over_hill();
	level thread event6_distantbmw();
	level thread event4_clear_forest();
	level thread event7_triggers_controller();
	level thread goldstar_in_trench_at_Cross();
//	level thread debug_objectives();

	wait 2;

	level.player setorigin ((5461, 3361, 52));
	level thread maps\bastogne2_event2and3::event2_launch_flares();
}

//===================================================================
//
//  Normal play through
//
//===================================================================
main_normal_progression() //Doing a normal playthrough
{
	level.ally_prisoner_count = 0;
	level.house_guard_count = 0;
	level.cross_german_count = 0;
	level.german_truck_count = 0;

	level.flag["farm_alerted_once"] = false;
	level.flag ["crossroads_alive"] = false;


	// --- Level.Stuff --- //
	// Used for the min/max delay of the distant lights
	level.dist_light_min_delay = 5;
	level.dist_light_max_delay = 15;

	level thread Ambience_Setup();

	level thread hurt_squad_setup();
	level thread event4_exec();
	level thread event4a_inter();	//starts the event where the officer is caught
	level thread barn_enter_setup();
	level thread barn_exit_setup();
	level thread setup_crossroad();
	level thread squad3_setup();
	level thread stay_behind_setup();
	level thread crossroads_clear();
	level thread delete_ambient_squad2();
	level thread event6_vehicle_init();

	level thread ambient_trucks_crossroads();

	level thread cross_squad_runaway();

	level thread flood_spawners_controller_crossroads();
	level thread event6_own_player();
	level thread whitney_block_player();
	level thread moody_talk_ridge();
	level thread ram_over_hill();
	level thread event6_distantbmw();
	level thread event4_clear_forest();
	level thread goldstar_in_trench_at_Cross();
	level thread event7_triggers_controller();
}


//===================================================================
//
//  Ambient effects setup
//
//===================================================================
Ambience_Setup()
{
	orgs = getentarray("distant_light","targetname");
	for(i=0;i<orgs.size;i++)
	{
		orgs[i] thread Random_Distant_Light_Think();
		wait 0.05;
	}
}

axis_clean_up()
{
		ai = getaiarray ("axis");
		for (i=0;i<ai.size;i++)
		{
			ai[i] delete();
		}

//		ai2 = getaiarray ("allies");
//		for (n=0;n<ai.size;n++)
//		{
//			ai2[n] delete();
//		}
}

axis_do_damage()
{
		ai = getaiarray ("axis");
		for (i=0;i<ai.size;i++)
		{
			wait (0.1 + randomfloat (1.5));	 
			if(isalive(ai[i]))
			{
				ai[i] DoDamage ( ai[i].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );	
			}
		}
}

alpha_squad_setup()
{
	alpha = "alpha";
	ender_a = "end_alpha";
	time_a = 0.1;
	min_a = 2;
	max_a = 8;
	println("^6 ***************** FUBAR ************************");
	level thread maps\_squad_manager::manage_spawners(alpha,min_a,max_a,ender_a,time_a,::alpha_squad_init);

	wait 5;
	level notify ("end_alpha");
	wait 2;
	level notify ("track_alpha");
}

event4_clear_forest() // keeps track of forest...
{
	level waittill ("track_alpha");
	ai1 = maps\_squad_manager::alive_array("alpha");
	//ai3 = maps\_squad_manager::alive_array("js_zeta");
	//ai3 = getentarray("duder","targetname");
	
	level.alive_flag_event4 = 0;

	while (level.alive_flag_event4 == false)
	{
		alive_count = 0;
		for (i=0;i<ai1.size;i++)
		{
			if (isalive(ai1[i]))
			{
				alive_count++;
			}
		}

		if (alive_count == 2)
		{
			level notify("moody_open_barn_door");		
		}

		
		if (alive_count == 1)
		{
			level thread axis_do_damage();
			level.alive_flag_event4 = true;
		}
		wait 0.05;
	}
	wait 2;

//	level waittill ("all_guys_dead");
//	level notify something else here
}

alpha_squad_init()
{
	println("^6 ****************** Apha squad init****************");
	self.health = 230;
	self.accuracy = 0.8;
	self.goalradius = 120;      // goal radius is a good thing to set in the initialization 
	self.grenadeawareness = 0;      // goal radius is a good thing to set in the initialization 
	//self.bravery = 1000;         // you can set any other parameters you want here
//	wait 20;	
//	level notify("end_alpha");
}

//=====================================================================================================================
//	event2_init
//
//		Sets up any thing that needs to be set up for event2 and threads all event2 functions
//=====================================================================================================================
event4_init()
{
//	if(getCvar("scr_debug_event2") == "")		
//		setCvar("scr_debug_event2", "1");	
//	level.debug["event2"] = getcvarint("scr_debug_event2");
	
	// process the skipto
//	level thread event2_debug_skipto();
	
	// wait until maps\bastogne2_event1to2::event1 ends to set up the next event
//	level waittill("event1to2_end");
	
	wait (0.1);
	
	level notify("event4_begin");

	// start the friendly chains for the area
//	maps\_utility_gmi::chain_on("80");
//	maps\_utility_gmi::chain_on("90");
//	maps\_utility_gmi::chain_on("100");
	
	// threads
//	level thread event2_player_in_field();
//	level thread event2_farmhouse_goes_alert();
//	level thread event2_cleanup();
}


//if ( getcvar("skipto") == "event4" )
event4_exec()	// now sets up the interrigation event as well
{

		names[0] = "Sgt. Moody";
		names[1] = "Pvt. Whitney";
		names[2] = "Pvt. Anderson";
	
		animnames[0] = "moody";
		animnames[1] = "whitney";
		animnames[2] = "anderson";
		
		blue = getentarray("blue", "groupname");

		//Three members of blue, 0 is Moody, 1 is Whitney, 2 is Anderson
		for(n=1; n<blue.size; n++)
		{
			level.blue[n] = getent("blue_" + n, "targetname");
			level.blue[n] character\_utility::new();
	
			level.blue[n].name = names[n];
			level.blue[n].animname = animnames[n];
	
			level.blue[n] [[level.scr_character[animnames[n]]]]();
			level.blue[n].pacifist = 0;
//			level.blue[n] thread maps\bastogne2::util_dont_ff_me();
	
			level.blue[n].goalradius = 96;
			level.blue[n].followmax = 1;
			level.blue[n].followmin = 0;

			level.blue[n] setgoalentity (level.player);
			
			//Everyone, get down!
			level.blue[n] allowedStances("crouch");
			
			level.blue[n].bravery = 50;
	
//			level.blue[n] thread maps\_friendly_gmi::adopt_player_stance();
			
			//This used to be 600, same as player...I made them a little tougher seeing as they can't exactly
			//pick up health packs...
			level.blue[n].health = 1200;
		}

		level.blue[0].goalradius = 96;
		level.blue[0].followmax = 1;
		level.blue[0].followmin = 0;

		level.blue[0] setgoalentity (level.player);
		level.blue[0] allowedStances("crouch");

//		level.moody character\moody_winter::main();
//		level.blue[0] character\moody_winter::main();

	
		// move each of the characters to the appropriate starting position
		org = getnode("event4_skipto_player", "targetname");

		// move the player  underground so he can not see the teleports
//		level.player setorigin( (0,0,-10000) );

		for(n=0;n<level.blue.size;n++)
		{
			println("^2 ************* ally has been teleported *****************");
			myspot = getnode("event4_skipto_"+(n+1), "targetname");
			level.blue[n] teleport (myspot.origin);
		}
//		for(n=0;n<level.red.size;n++)
//		{
//			myspot = getnode("event4_skipto_" + (n + level.blue.size + 1), "targetname");
//			level.red[n] teleport (myspot.origin);
//		}

		// we want to move the contact to his final spot here
		
		// move player to their position
//		level.player setorigin( org.origin );

		// sets up and starts german attack on barn

		println("^6 ****************** event 4 event4_guys_setup before ****************");
		//level thread event4_guys_setup();
		println("^6 ****************** event 4 event4_guys_setup after ****************");

		level thread door_setups();
}

door_setups()	// need to have this waitill after the inerrogation event
{
	level thread barn_door_last();
	door2 = getent ("door2", "targetname");	//sets up door to barn

	level waittill("moody_open_barn_door");
//	level notify("end_alpha");
	level.blue[0].goalradius = 5;

	fnode = getnode("open_barn_door", "targetname");
	level.blue[0] setgoalnode(fnode);
	level.blue[0] waittill("goal");	// getst into position
	wait 2;

	while(1)
	{
	println("^9 moody is waiting now");
		if (level.alive_flag_event4 == true)
		{
			break;
		}
		wait 0.05; 
	}

//	level waittill ("all_guys_dead");

	println("^5 EVent3a has been triggered");
	// this makes the door open
	level.moody thread anim_single_solo(level.moody,"kickdoor");
	level.moody waittillmatch ("single anim", "kick");
	door2 playsound ("wood_door_kick");
	door2 connectpaths();
	door2 rotateroll(-93, 0.3,0,0.3);
//	door2 rotateyaw(-93, 0.3,0,0.3);


	level.blue[0].dontavoidplayer = 1;		
	level.blue[0].goalradius = 96;
	level.blue[0].followmax = 1;
	level.blue[0].followmin = 0;
	level.blue[0] setgoalentity (level.player);
	level notify("second_squad_protect_pris");
}

barn_door_last()
{
	trigger = getent ("after_medic_barn_go", "targetname");
	trigger maps\_utility_gmi::triggerOff();

	level waittill ("open_last_door");
	wait 3;

//	wait 10;
	door3 = getent ("last_barn_door", "targetname");	//sets up door to barn
//	door3 rotateto((0,45,0), 2,1,0);
//	door3 playsound ("wood_door_kick");
	door3 connectpaths();

	pos = (6464,4016,88);
	door3 moveTo(pos, 3, 1.6,0.3);


	moody_ang = spawn("script_origin", level.moody.origin);
	moody_ang.angles = (0,180,0);
	
	level.moody thread anim_single_solo(level.moody, "open_mill_door", undefined, moody_ang);

//	level.moody thread anim_single_solo(level.moody,"open_mill_door");
	door3 playsound ("barn_door_open");
//	level.scr_anim["moody"]["open_mill_door"]=(%trenches_antonov_mill_door);
	wait 1;
	trigger maps\_utility_gmi::triggerOn();
	level.blue[0].dontavoidplayer = 0;
	level.blue[0].followmax = 2;
	level.blue[0].followmin = 0;
	level.blue[0] setgoalentity (level.player);

//	door3 rotateroll(-90, 0.3,0,0.3);
}

#using_animtree("generic_human");
event4a_inter()	// starts event.. need to include kickind door now..
{
	wait 6;
//	fhouse_door1 = getent("farm_house_door1", "targetname");
//
//// 	need node for moody to open door to farm house
//	fnode = getnode("open_farm_door", "targetname");
//	level.blue[0] setgoalnode(fnode);
//	level.blue[0].goalradius = 5;
//	level.blue[0].dontavoidplayer = 1;
//	level.blue[0] waittill("goal");
//
//
//	println("^6 ****************** event 4 guys setup is working ****************");
//	squad2_array =[];// this defines it as an array
//	squad2_group = getentarray("squad2", "groupname");
//
//	for(i=0;i<(squad2_group.size);i++)//		
//	{
////		wait 5;
//		//squad2_array[i] = getent("squad2_guy_" + i, "targetname");
//		guy = squad2_group[i] stalingradspawn();
//		guy waittill ("finished spawning");
//		guy thread maps\_utility_gmi::magic_bullet_shield();
//		guy.targetname = squad2_group[i].targetname +"_guy";
//		guy.pacifist = true;
//		guy.team = "neutral";
//		guy allowedstances("stand");
//		guy.grenadeawareness = 0;
//		guy thread get_moody();
//		guy thread continue_after_interogation();
//		guy thread koppel_conversation(); // telling this guys who is now Koppel to do conversation	
//		guy thread denny_conversation_sync();
//
//	}
//
//	wait 0.05;
//	level thread setup_house_fight();


// try waiting for player here for better flow..


	fhouse_door1 = getent("farm_house_door1", "targetname");

// 	need node for moody to open door to farm house
	fnode = getnode("open_farm_door", "targetname");
	level.blue[0] setgoalnode(fnode);
	level.blue[0].goalradius = 5;
	level.blue[0].dontavoidplayer = 1;
	level.blue[0] waittill("goal");


	while(1)
	{
		if (distance (level.player getorigin(), level.blue[0].origin) < 250)	
		{					
			break; // continue once the player is close enough to the event.
		}
		wait 1;
	}


	println("^6 ****************** event 4 guys setup is working ****************");
	squad2_array =[];// this defines it as an array
	squad2_group = getentarray("squad2", "groupname");

	for(i=0;i<(squad2_group.size);i++)//		
	{
//		wait 5;
		//squad2_array[i] = getent("squad2_guy_" + i, "targetname");
		guy = squad2_group[i] stalingradspawn();
		guy waittill ("finished spawning");
		guy thread maps\_utility_gmi::magic_bullet_shield();
		guy.targetname = squad2_group[i].targetname +"_guy";
		guy.pacifist = true;
		guy.team = "neutral";
		guy allowedstances("stand");
		guy.grenadeawareness = 0;
		guy thread get_moody();
		guy thread continue_after_interogation();
		guy thread koppel_conversation(); // telling this guys who is now Koppel to do conversation	
		guy thread denny_conversation_sync();

	}

	wait 0.05;
	level thread setup_house_fight();

	wait 5;


	level.scr_anim["moody"]["moody_crossfire"]		= (%c_us_bastogne2_moody_crossfire);
	
	level.scr_notetrack["moody"][0]["notetrack"]		= "moody_crossfire";
	level.scr_notetrack["moody"][0]["dialogue"]		= "moody_crossfire";
	level.scr_notetrack["moody"][0]["facial"]		= (%f_bastogne2_moody_crossfire);


	level.moody thread anim_single_solo(level.moody,"moody_crossfire");
	println(" ^3 ***********  cross fire");

	wait 3.3;

	level notify("moody_at_door");
	
//	anim_single (guy, anime, tag, node, tag_entity)	
	level.moody thread anim_single_solo(level.moody,"kickdoor");
//anim/sound end
	level.moody waittillmatch ("single anim", "kick");
	fhouse_door1 playsound ("wood_door_kick");

//	wait 3;
	fhouse_door1 connectpaths();	
	fhouse_door1 rotateyaw(-130, 0.3,0,0.3);
	fnode1a = getnode("inside_farm_house_attack", "targetname");
	level.blue[0] setgoalnode(fnode1a);
	level.blue[0] waittill("goal");
	level notify("moody_in_house");

//	level.blue[0].gaolradius = 512;
//	level.blue[0].dontavoidplayer = 0;

//	level.blue[0] setgoalentity(level.player);
//	level.blue[0].followmax = -1;
//	level.blue[0].followmin = 0;


	// jeremy added new ending for two squads that are fighting outside of the barn... this talks back to previous scripting waiting to be stopped
//	level thread maps\bastogne2_event2and3:: not used right now...	
}

continue_after_interogation()// after the german officer gives up the goods... these guys follow downstairs then wait with injured!
{
	level waittill("inter_over");
	self.team = "allies";
	self.grenadeawareness = 1;
	self.goalradius = 30;
	self.pacifist = false;
//	self.pacifist = true;
//	self.script_flashlight = 1;
	self allowedstances("crouch");
//	self allowedstances("stand","crouch","prone");
	println(" ********* second squad should go outside now *********");

	if(self.targetname == "squad2_guy_1_guy")	// follow german denny
	{

//		self.dontavoidplayer = 1;	
		guys[0] = self;
		maps\_anim_gmi::anim_pushPlayer(guys);	
		self.animname = "medic";
//		wait 14;
//		self thread walkies();
		println(" ********* second squad guy 1 go now *********");
		//	squad2_array_ai[i] thread get_moody();
//		fnode = getnode("squad2_spot4_hit_officer", "targetname");
//		self setgoalnode(fnode);
//		self waittill("goal");

//		level notify ("denny_in_position");

//		level waittill("moody_says_hit_him");
		println("^3 ****** denny hit german then run away dog********");
//		self thread anim_single_solo(self,"moody_melee1");
	
			
//		wait 1;
//		self thread walkies_off();

		fnode = getnode("squad2_spot_4", "targetname");
		self setgoalnode(fnode);


		level waittill("squad_group_for_orders_to_stay_behind");
		fnode = getnode("squad2_spot_4a", "targetname");
		self setgoalnode(fnode);
		self waittill("goal");
		wait 1;

		self thread anim_single_solo(self,"medic_wall");
		wait 6;
		self thread anim_single_solo(self,"medic_run");
		wait 3;
		self thread anim_loop_solo(self,"medic_wall_idle");
	}

	if(self.targetname == "squad2_guy_2_guy")
	{
		println(" ********* second squad guy 1 go now *********");
		//	squad2_array_ai[i] thread get_moody();
		fnode = getnode("squad2_spot_5", "targetname");
		self setgoalnode(fnode);
		self notify ("stop magic bullet shield");

		level waittill("squad_group_for_orders_to_stay_behind");
		fnode = getnode("squad2_spot_5a", "targetname");
		self setgoalnode(fnode);

		self waittill("goal");

		self thread maps\_utility_gmi::magic_bullet_shield();


	}

	if(self.targetname == "squad2_guy_3_guy")
	{
		println(" ********* second squad guy 1 go now *********");
		//	squad2_array_ai[i] thread get_moody();
		fnode = getnode("squad2_spot_6", "targetname");
		self setgoalnode(fnode);
		self notify ("stop magic bullet shield");

		level waittill("squad_group_for_orders_to_stay_behind");
		fnode = getnode("squad2_spot_6a", "targetname");
		self setgoalnode(fnode);


		self waittill("goal");
		self.pacifist = true;

		self thread maps\_utility_gmi::magic_bullet_shield();
//		self.script_flashlight = 1;
	}
	
}

anim_single_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
 	maps\_anim_gmi::anim_single (newguy, anime, tag, node, tag_entity);
}

setup_house_fight()	// spawns in guys that are in the house..
{
		level thread house_count_up_tracker();	
		germans1_group = getentarray("clear_house_guards", "groupname");

		for(i=0;i<(germans1_group.size);i++)//		
		{
		
			//squad2_array[i] = getent("squad2_guy_" + i, "targetname");
			guy = germans1_group[i] stalingradspawn();
//			guy waittill ("finished spawning");
			guy thread death_inc_up();
			guy.pacifist = 1;
			guy.health = 10;
			guy.goalradius = 30;
			guy.targetname = germans1_group[i].targetname +"_guy";
			guy allowedstances("stand","crouch","prone");
//			guy allowedstances("stand");
			guy thread german_blown_from_behind();
//			guy thread ammo_loop();
//			guy thread house_guard_others();
//			guy setgoalentity("level.player");
		}
}

ammo_loop()
{
//	while(1)
//	{
//		self.personalspace = 2000;
//		self.bulletsInClip = 0;
//		self.weaponclipsize = 0;
//		wait 10;
//	}
}

german_blown_from_behind()	// german who gets blown up from behind...
{
	if(self.targetname == "house_guard_3_guy")
	{
		//	squad2_array_ai[i] thread get_moody();
		fnode = getnode("kop_talk1", "targetname");
		self setgoalnode(fnode);
		self.ignoreme = true;
		self.goalradius = 10;
		self.health = 5000;
		self waittill("goal");

		level waittill("moody_at_door");
		// make explosion happen from behind

		window_explode = getent("w_explosion", "targetname");

		wait 0.3;
//		while(1)
//		{
			//playfx ( level._effect["building2_glass"], vec );
			playfx(level._effect["building2_glass"], window_explode.origin);
			window_explode playsound("mortar_explosion1");
			wait 1;
			playfx(level._effect["building2_glass"], window_explode.origin);
			window_explode playsound("mortar_explosion1");

//		}
		self.health = 50;

		self DoDamage ( self.health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );		
	}

//	wait 1;
	level waittill("moody_in_house");
//	self waittill("combat");
	if(isalive(self))
	{
		self.pacifist = false;
	}	 
}

death_inc_up()
{
	


	println("^3 **************** GERMAN OFFICER EVENT GO house_guard_count add one before death  *****************");
	self waittill("death");
	
	level.house_guard_count++;
	println("^3 **************** GERMAN OFFICER EVENT GO house_guard_count add one after death*****************", level.house_guard_count);
}

house_count_up_tracker()
{
	
	while(1)
	{
		if(level.house_guard_count == 4) 
		{
			wait 7;
	
//			level notify("continue_farm_house_guards_dead"); // lets farm house continue because guys are now dead...
	
			println("^6 **************** GERMAN OFFICER EVENT GO house_guard_count = 4 *****************");
			println("^8 **************** GERMAN OFFICER EVENT GO house_guard_count = 4 *****************");
			println("^2 **************** GERMAN OFFICER EVENT GO house_guard_count = 4 *****************");
			println("^7 **************** GERMAN OFFICER EVENT GO house_guard_count = 4 *****************");
			break;
			// We lost one ... keep them alive
			// battle is tough level one
		}
		wait 0.05;

	}
}



house_guard_others()
{
	if(self.targetname == "house_guard_4_guy") 
	{
		self DoDamage ( self.health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );			
		//self delete();
	}
}

get_moody() // sends koppel to top of stairs calling down to moody to come upstairs
{
	println("^3 ********* Hey kop got his line and should go to spot 1*");

	if(self.targetname == "squad2_guy_3_guy") // this is koppel
	{	
		level waittill("moody_at_door");	
		level thread german_officer();
		self.animname = "trooper";
		wait 6;

		println("^3 ********* Hey kop got his line and should go to spot 2*");
		//	squad2_array_ai[i] thread get_moody();
		fnode = getnode("kop_talk1", "targetname");
		self setgoalnode(fnode);
		self.goalradius = 30;
		self waittill("goal");
		

		while(1)
		{
			if(level.house_guard_count == 4) 
			{
				break;
			}
			wait 0.05;
		}

//		level waittill("continue_farm_house_guards_dead"); // lets farm house continue because guys are now dead...
//		wait 3;
		// make a level notify that makes the guy wait for germans to be dead..
//		wait 2;	// gonna have to wait till germans are dead I presume
		println("^3 ********* kop say officer is here*");
		wait 2;
//		self playsound("trooper_officer");	//clear up rich 

//		self playsound("trooper_officer");	//clear down rich 
		self thread anim_single_solo(self,"trooper_officer"); // salute

//		self playanimsingle("trooper_officer");	// he we got a german officer up here
		wait 3.5;
		level.blue[0] anim_single_solo (level.blue[0], "moody_clear_down");
		level notify("objective_7_complete");
		// add notify that will continue conversation with koppel talking not the other guys
		level thread german_conversation_event();
	}
}

//=========================================
//	whitney_block_player
//
//	This makes one ai block the player while the inter conversation occurs
//
//=========================================
whitney_block_player()
{
	wait 4;
	level waittill ("koppel_dia_continue");
	fnode = getnode("open_farm_door", "targetname");
	level.blue[1] setgoalnode(fnode);
	level.blue[1].goalradius = 5;
	level.blue[1].dontavoidplayer = 1;
//	level waittill("inter_over");

	level waittill("moody_says_hit_him");	// allows the american to hit the german


	level.blue[1].dontavoidplayer = 0;
	level.blue[1] setgoalentity(level.player);
	level.blue[1] allowedstances("stand","crouch","prone");
	level.blue[1].followmax = 3;
	level.blue[1].followmin = 0;
}

denny_conversation_sync()
{
	if(self.targetname == "squad2_guy_1_guy")	// follow german
	{
		self.animname = "denny";

		level waittill ("koppel_dia_continue");

		org = spawn("script_origin",(5420.52, 2684, 160.4));
		org.angles = (0, -39.205, 0);


//		level.scr_notetrack["denny"][0]["notetrack"]		= "impact";


		self thread anim_single_solo (self,"denny_interrogation", undefined, org); // I can sarge a little


		//impact

		wait 36;

		level.scr_anim["denny"]["denny_walk_to_window"]	= (%c_us_bastogne2_denny_walkalarm);

////			FRAME 14 "step_walk_wood" 0
////			FRAME 31 "step_walk_wood"1
////			FRAME 46 "step_walk_wood"2
////			FRAME 58 "step_walk_wood"3
////			FRAME 71 "step_walk_wood"4
////			FRAME 85 "step_walk_wood"5
////			FRAME 99 "step_walk_wood"6
////			FRAME 100 "step_walk_wood"7
////			FRAME 117 "step_walk_wood"8
////			FRAME 128 "step_walk_wood"9
////			FRAME 146 "step_walk_wood"10
////			FRAME 181 "step_walk_wood"11
////			FRAME 212 "step_walk_wood"12
////			FRAME 227 "step_walk_wood"13


//		level.scr_notetrack["denny"][0]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][0]["dialogue"]		= "step_walk_wood";

//		level.scr_notetrack["denny"][1]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][1]["dialogue"]		= "step_walk_wood";
//
//		level.scr_notetrack["denny"][2]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][2]["dialogue"]		= "step_walk_wood";
//
//		level.scr_notetrack["denny"][3]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][3]["dialogue"]		= "step_walk_wood";
//
//		level.scr_notetrack["denny"][4]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][4]["dialogue"]		= "step_walk_wood";
//
//		level.scr_notetrack["denny"][5]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][5]["dialogue"]		= "step_walk_wood";
//
//		level.scr_notetrack["denny"][6]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][6]["dialogue"]		= "step_walk_wood";
//
//		level.scr_notetrack["denny"][7]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][7]["dialogue"]		= "step_walk_wood";
//
//		level.scr_notetrack["denny"][8]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][8]["dialogue"]		= "step_walk_wood";
//
//		level.scr_notetrack["denny"][9]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][9]["dialogue"]		= "step_walk_wood";
//
//		level.scr_notetrack["denny"][10]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][10]["dialogue"]		= "step_walk_wood";
//
//		level.scr_notetrack["denny"][11]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][11]["dialogue"]		= "step_walk_wood";
//
//		level.scr_notetrack["denny"][12]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][12]["dialogue"]		= "step_walk_wood";

//		level.scr_notetrack["denny"][13]["notetrack"]		= "step_walk_wood";
//		level.scr_notetrack["denny"][13]["dialogue"]		= "step_walk_wood";

//		level.scr_notetrack["denny"][14]["notetrack"]	= "step_walk_wood";
//		level.scr_notetrack["denny"][14]["dialogue"]		= "step_walk_wood";
//
//		level.scr_notetrack["denny"][15]["notetrack"]	= "step_walk_wood";
//		level.scr_notetrack["denny"][15]["dialogue"]		= "step_walk_wood";

		self thread anim_single_solo (self,"denny_walk_to_window", undefined, org); // good then ask about patrol
	}
}

#using_animtree("generic_human");
koppel_conversation()
{
	self.animname = "koppel";
	if(self.targetname == "squad2_guy_2_guy") // this is koppel
	{

		fnode2 = getnode("kopp_talk_german", "targetname");
		self setgoalnode(fnode2);
//		self waittill("goal");

		level waittill ("koppel_dia_continue");
//		level thread inter_lock_player();



//		anim_single_solo(entity, anim index name, node name, undefined, node entity)l

		level.scr_anim["moody"]["moody_interrogation"]		= (%c_us_bastogne2_moody_interrogation);
	
		level.scr_notetrack["moody"][0]["notetrack"]		= "moody_translate";
		level.scr_notetrack["moody"][0]["dialogue"]		= "moody_translate";
		level.scr_notetrack["moody"][0]["facial"]		= (%f_bastogne2_moody_translate);
	
		level.scr_notetrack["moody"][1]["notetrack"]		= "moody_missing_patrol";
		level.scr_notetrack["moody"][1]["dialogue"]		= "moody_missing_patrol";
		level.scr_notetrack["moody"][1]["facial"]		= (%f_bastogne2_moody_missing_patrol);
	
		level.scr_notetrack["moody"][2]["notetrack"]		= "moody_ask_again";
		level.scr_notetrack["moody"][2]["dialogue"]		= "moody_ask_again";
		level.scr_notetrack["moody"][2]["facial"]		= (%f_bastogne2_moody_ask_again);
	
		level.scr_notetrack["moody"][3]["notetrack"]		= "moody_more_like_it";
		level.scr_notetrack["moody"][3]["dialogue"]		= "moody_more_like_it";
		level.scr_notetrack["moody"][3]["facial"]		= (%f_bastogne2_moody_more_like_it);



//		level.scr_anim["koppel"]["koppel_interrogation"]	= (%c_us_bastogne2_koppel_interrogation);
 //		level.scr_face["koppel"]["koppel_interrogation"]	= (%f_bastogne2_koppel_translate);
 //		level.scrsound["koppel"]["koppel_interrogation"]	= "koppel_translate";

//						FRAME 100 "koppel_translate"
//						FRAME 294 "koppel_translate_patrol"
//						FRAME 534 "koppel_no_luck"
//						FRAME 771 "Koppel_are_you_sure"
//						FRAME 906 "koppel_show_us"
//						FRAME 1031 "koppel_where_our_men"


		level.scr_notetrack["koppel"][0]["notetrack"]		= "koppel_translate";
		level.scr_notetrack["koppel"][0]["dialogue"]		= "koppel_translate";
		level.scr_notetrack["koppel"][0]["facial"]		= (%f_bastogne2_koppel_translate);
		
		level.scr_notetrack["koppel"][1]["notetrack"]		= "koppel_translate_patrol";
		level.scr_notetrack["koppel"][1]["dialogue"]		= "koppel_translate_patrol";
		level.scr_notetrack["koppel"][1]["facial"]		= (%f_bastogne2_koppel_translate_patrol);
		
		level.scr_notetrack["koppel"][2]["notetrack"]		= "koppel_no_luck";
		level.scr_notetrack["koppel"][2]["dialogue"]		= "koppel_no_luck";
		level.scr_notetrack["koppel"][2]["facial"]		= (%f_bastogne2_koppel_no_luck);
		
		level.scr_notetrack["koppel"][3]["notetrack"]		= "koppel_are_you_sure";
		level.scr_notetrack["koppel"][3]["dialogue"]		= "koppel_are_you_sure";
		level.scr_notetrack["koppel"][3]["facial"]		= (%f_bastogne2_koppel_are_you_sure);
		
		level.scr_notetrack["koppel"][4]["notetrack"]		= "koppel_show_us";
		level.scr_notetrack["koppel"][4]["dialogue"]		= "koppel_show_us";
		level.scr_notetrack["koppel"][4]["facial"]		= (%f_bastogne2_koppel_show_us);
		
		level.scr_notetrack["koppel"][5]["notetrack"]		= "koppel_where_our_men";
		level.scr_notetrack["koppel"][5]["dialogue"]		= "koppel_where_our_men";
		level.scr_notetrack["koppel"][5]["facial"]		= (%f_bastogne2_koppel_where_our_men);

		
		level.scr_anim["koppel"]["koppel_interrogation"]	= (%c_us_bastogne2_koppel_interrogation);
//		level.german1_ai thread anim_single_solo (self,"koppel_interrogation"); // I can sarge a little
//		level.german1_ai thread anim_single_solo (level.moody,"moody_interrogation"); // good then ask about patrol


		level.german1_ai notify("end anim");

		level.scr_anim["g_officer"]["gofficer_interrogation"]	= (%c_us_bastogne2_gofficer_interrogation);

		level.scr_notetrack["g_officer"][0]["notetrack"]	= "gofficer_know_nothing";
		level.scr_notetrack["g_officer"][0]["dialogue"]		= "gofficer_know_nothing";
		level.scr_notetrack["g_officer"][0]["facial"]		= (%f_bastogne2_gofficer_know_nothing);

		level.scr_notetrack["g_officer"][1]["notetrack"]	= "smack_prisoner01";
		level.scr_notetrack["g_officer"][1]["dialogue"]		= "smack_prisoner01";

		level.scr_notetrack["g_officer"][2]["notetrack"]	= "gofficer_cooperate";
		level.scr_notetrack["g_officer"][2]["dialogue"]		= "gofficer_cooperate";
		level.scr_notetrack["g_officer"][2]["facial"]		= (%f_bastogne2_gofficer_cooperate);


//		level.german1_ai thread anim_single_solo (level.german1_ai,"gofficer_interrogation"); // good then ask about patrol

		// place timed sound here... for german being hit and making a pain noise


//		org = org GetTagOrigin ( "dummy node" ); 
//		ang = level.chair_dummy GetTagAngles ( "dummy node" );
//
//		level.d_axis[2] animscripted("deathanim", org, ang, level.scr_anim["d_axis_2"]["laying_death"]);
//		level.d_axis[2] waittillmatch("deathanim", "end");

//		org =  (5420.52, 2684, 160.4);
//		tag =  (5420.52, 2684, 160.4);
//		ang =  (-39.205, 0, 0);
//		anim_single_solo (guy, anime, tag, node, tag_entity)


//		X          5420.52
//		Y          2684
//		Z          160

		//self thread anim_single_solo (self,"denny_interrogation"); // I can sarge a little

		org = spawn("script_origin",(5420.52, 2684, 160.4));
		org.angles = (0, -39.205, 0);

		level.german1_ai thread anim_single_solo (level.german1_ai,"gofficer_interrogation", undefined, org); // good then ask about patrol
		level.german1_ai thread anim_single_solo (self,"koppel_interrogation", undefined, org); // I can sarge a little
		level.german1_ai thread anim_single_solo (level.moody,"moody_interrogation", undefined, org); // good then ask about patrol


//		level.german1_ai animscripted("interranim", org, ang, level.scr_anim[level.german1_ai.animname]["gofficer_interrogation"]);
//		level.german1_ai animscripted("koppelanim", org, ang, level.scr_anim[self.animname]["koppel_interrogation"]);
//		level.german1_ai animscripted("moodyanim", org, ang, level.scr_anim[level.moody.animname]["moody_interrogation"]);

		wait 36;

//		level.scr_anim["g_officer"]["gofficer_interrogation"]	= (%c_us_bastogne2_gofficer_interrogation);
		level.scr_anim["g_officer"]["gofficer_alarm"]	= (%c_us_bastogne2_gofficer_walkalarm);

////		FRAME 24 "step_walk_wood"
////		FRAME 38 "step_walk_wood"
////		FRAME 50 "step_walk_wood"
////		FRAME 64 "step_walk_wood"
////		FRAME 77 "step_walk_wood"
////		FRAME 95 "step_walk_wood"
////		FRAME 102 "gofficer_alarm"
////		FRAME 105 "step_walk_wood"
////		FRAME 121 "smack_prisoner02"

		level.scr_notetrack["g_officer"][0]["notetrack"]	= "step_walk_wood";
		level.scr_notetrack["g_officer"][0]["dialogue"]		= "step_walk_wood";

		level.scr_notetrack["g_officer"][1]["notetrack"]	= "step_walk_wood";
		level.scr_notetrack["g_officer"][1]["dialogue"]		= "step_walk_wood";

		level.scr_notetrack["g_officer"][2]["notetrack"]	= "step_walk_wood";
		level.scr_notetrack["g_officer"][2]["dialogue"]		= "step_walk_wood";

		level.scr_notetrack["g_officer"][3]["notetrack"]	= "step_walk_wood";
		level.scr_notetrack["g_officer"][3]["dialogue"]		= "step_walk_wood";

		level.scr_notetrack["g_officer"][4]["notetrack"]	= "step_walk_wood";
		level.scr_notetrack["g_officer"][4]["dialogue"]		= "step_walk_wood";

		level.scr_notetrack["g_officer"][5]["notetrack"]	= "step_walk_wood";
		level.scr_notetrack["g_officer"][5]["dialogue"]		= "step_walk_wood";

		level.scr_notetrack["g_officer"][6]["notetrack"]	= "step_walk_wood";
		level.scr_notetrack["g_officer"][6]["dialogue"]		= "step_walk_wood";


		level.scr_notetrack["g_officer"][7]["notetrack"]	= "gofficer_alarm";
		level.scr_notetrack["g_officer"][7]["dialogue"]		= "gofficer_alarm";
		level.scr_notetrack["g_officer"][7]["facial"]		= (%f_bastogne2_gofficer_alarm);

		level.scr_notetrack["g_officer"][8]["notetrack"]	= "step_walk_wood";
		level.scr_notetrack["g_officer"][8]["dialogue"]		= "step_walk_wood";

		level.scr_notetrack["g_officer"][9]["notetrack"]	= "smack_prisoner02";
		level.scr_notetrack["g_officer"][9]["dialogue"]		= "smack_prisoner02";



//		level.scr_anim["g_officer"]["gofficer_alarm"]		= (%c_us_bastogne2_gofficer_alarm);
//		
//		level.scr_notetrack["g_officer"][0]["notetrack"]	= "gofficer_alarm";
//		level.scr_notetrack["g_officer"][0]["dialogue"]		= "gofficer_alarm";
//		level.scr_notetrack["g_officer"][0]["facial"]		= (%f_bastogne2_gofficer_alarm);


		level.german1_ai thread anim_single_solo (level.german1_ai,"gofficer_alarm", undefined, org); // good then ask about patrol

		wait 4.2;
		level notify("inter_over");
		wait 4;
		level notify("objective_8_complete");	
	}
}

inter_lock_player() // call this from moody starting event... from his distance check
{
	lock = spawn("script_origin", level.player.origin);
	level.player linkTo(lock);

	lock moveTo((5536, 2592, 160 ), 4, 0, 0);	

	level waittill ("inter_over");
	wait 3;
	level.player unlink();
}

#using_animtree("generic_human");
german_officer()
{
	german1 = getent("int_officer", "targetname");
//	german1 thread maps\_utility_gmi::magic_bullet_shield();
//	german1.team = "neutral";
	//println(" ^6 ***********************  :  ", self.targetname, self.health);
		
	
	
	level.german1_ai = german1 stalingradspawn();
	level.german1_ai waittill ("finished spawning");
	level.german1_ai animscripts\shared::putGunInHand ("none");
	level.german1_ai.pacifist = true;
	level.german1_ai.goalradius = 5;
	level.german1_ai.hasweapon = false;
	level.german1_ai.team = "allies";
	level.german1_ai.dontavoidplayer = 1;
	level.german1_ai.dropweapon = 1;
//	level.german1_ai = german_officer.targetname +"_guy";
//	level.german1_ai thread maps\_utility_gmi::magic_bullet_shield();
	level.german1_ai.animname = "g_officer";

	level.german1_ai character\_utility::new();
	level.german1_ai character\german_wehrmact_snow_nohelm::main();

//	level.german1_ai.pushplayer
//	level.german1_ai thread event4_german_in_window_loop();


	level.german1_ai thread maps\bastogne2::friendly_damage_penalty_pow();

	level.german1_ai thread gofficer_anim();

	level waittill("inter_over");

	level thread moody_to_barn();

//	wait 16; // must be timed with walk...  even though he gets set goal node he will not continue until walk anim activated

//	fnode = getnode("gofficer_help", "targetname");
//	level.german1_ai setgoalnode(fnode);

//	level.german1_ai waittill("goal");
	println("^3 **************** German walk over there now fooolio");


//	level waittill ("denny_in_position");

//	level.scr_anim["moody"]["moody_crossroad"]		= (%c_us_bastogne2_moody_crossroad);
//	level.scr_notetrack["moody"][0]["notetrack"]		= "moody_crossroad";
//	level.scr_notetrack["moody"][0]["dialogue"]		= "moody_crossroad";
//	level.scr_notetrack["moody"][0]["facial"]		= (%f_bastogne2_moody_crossroad);



	// animscripted(string notifyName, vector nodeOrigin, vector nodeAngles, Anim anim);


     	level notify ("prisoner yelled"); 
//	level.scr_anim["g_officer"]["gofficer_alarm"]		= (%c_us_bastogne2_gofficer_alarm);
//	
//	level.scr_notetrack["g_officer"][0]["notetrack"]	= "gofficer_alarm";
//	level.scr_notetrack["g_officer"][0]["dialogue"]		= "gofficer_alarm";
//	level.scr_notetrack["g_officer"][0]["facial"]		= (%f_bastogne2_gofficer_alarm);


//	level.german1_ai animscripted("animontagdone", self.origin+(0,0,48), self.angles, level.scr_anim["g_officer"]["gofficer_alarm"]);

//	level.german1_ai thread anim_single_solo(level.german1_ai,"gofficer_alarm");

//	wait 2;


	level thread alpha_squad_setup(); // start event 

	level.blue[0] playsound ("moody_shutup");
	wait 0.2;
	level notify("moody_says_hit_him");	// allows the american to hit the german
//	wait 7;
	level.german1_ai.deathanim = level.scr_anim["g_officer"]["gofficer_dead"];
	level.german1_ai notify ("stop magic bullet shield");
	wait 0.05;
	level.german1_ai DoDamage ( level.german1_ai.health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );			

	maps\_utility_gmi::chain_on("5000");	// start of maps\bastogne2_event1to2::event4to7
	chain = maps\_utility::get_friendly_chain_node ("5000");
	level.player SetFriendlyChain (chain);	

	level.blue[0] allowedstances("crouch","prone");


//	maps\_utility_gmi::chain_off("4999");	// start of maps\bastogne2_event1to2::event1to2
//	wait 10;	// lenght of courtyard battle
}

koppel_interrogation_anims()
{
}

player_killed_prisoner() 
{
     	level endon ("prisoner yelled"); 
	level.german1_ai waittill ("death", attacker); 

	if(attacker != level.player)
	{
		return;
	}

    	level.player endon ("death"); 
	level notify ("mission failed"); 
      
     	if (level.missionfailed == true) 
     	{ 
         	 return; 
     	} 
     	else 
     	{ 
       	   level.missionfailed = true; 
     	} 
      
     	setCvar("ui_deadquote", "@SCRIPT_MISSIONFAIL_KILLTEAM_POW"); 
      
 	missionfailed(); 
} 

event4_german_in_window_loop() // need to split up for death idle
{
    	level waittill ("prisoner yelled"); 
	wait 8;
//	level.scr_anim["g_officer"]["gofficer_alarm"]		= (%c_us_bastogne2_gofficer_dead);
//	self endon ("death");
//	level endon ("event1_stop_wounded_rescued_idle");
	org = self.origin;
	ang = self.angles;
	while (1)
	{
		// c_us_bastogne2_gofficer_dead
		self animscripted("animdone", org, ang, level.scr_anim["g_officer"]["gofficer_dead"]);
		wait 3;
//		level.powned.allowDeath = 0;
		self waittillmatch ("animdone", "g_officer");
	}
}

moody_to_barn()
{
	fnode = getnode("kop_talk1", "targetname");
	level.blue[0] setgoalnode(fnode);

	level waittill("moody_says_hit_him");	// allows the american to hit the german
	
	wait 3.8;
	
	level.moody thread anim_single_solo(level.moody,"moody_goto_barn");
	println(" ^3 ***********  moody_goto_barn");


	fnode = getnode("defend_barn_door", "targetname");
	level.blue[0] setgoalnode(fnode);
	level.blue[0] waittill("goal");
}

gofficer_anim()
{
	println("************* play anim **********");
	level.german1_ai thread anim_loop_solo(level.german1_ai,"stand_idle", undefined, "end anim");	

	level waittill("inter_over");


//	level.german1_ai thread anim_loop_solo(level.german1_ai,"stand_idle", undefined, "end anim");	

//	wait 6;

//	level.german1_ai notify("end anim");

//	level.german1_ai.goalradius = 40;



//	level.german1_ai thread officer_walk();




//
//	level.german1_ai thread anim_loop_solo(level.german1_ai,"walk_idle", undefined, "end anim");	
}

german_conversation_event() // all guys
{
	level.blue[0] allowedstances("stand");
	node1 = getnode("moody_officer_talk1", "targetname");
	level.blue[0] setgoalnode(node1);
	level.blue[0] waittill("goal");

	while(1)
	{
		if (distance (level.player getorigin(), level.blue[0].origin) < 300)	
		{
//			level.blue[0] playsound ("moody_translate");	// can anyone translate here
			wait 1;
			level notify ("koppel_dia_continue");
			// also need to send out command from here that blocks player in house...
			// level thread block_player_in_house;
			break;								
		}
		wait 1;
	}


//	level.blue[0] thread print_dialog3d(level.blue[0],"OMG what the hell it's a another german kill this sorry punk"); // Fun print stuff.

}

event4_guys_setup()	// guys near truck
{
	println("^6 ****************** event 4 guys setup is working ****************");
	germans4_array =[];// this defines it as an array
	germans4_group = getentarray("event4_guys", "groupname");

	for(i=1;i<(germans4_group.size+1);i++)//		
	{
	
		germans4_array[i] = getent("event4_guy_" + i, "targetname");
		germans4_array_ai[i] = germans4_array[i] dospawn();
		germans4_array_ai[i].pacifist = true;
		germans4_array_ai[i] allowedstances("stand");
		germans4_array_ai[i] thread e4_node(i);
	}
}

e4_node(i)
{
//	level waittill("intro over");
	if(isalive(self))
	{	
		wait (0.2 + randomfloat (0.9));		
		node = getnode("event4_guy_node_" + i, "targetname");
		self setgoalnode(node);
		self waittill("goal");
		self.pacifist = false;
	}

	if(isalive(self))
	{
		// then continue to inside of the barn and kill american soldiers
	}
}

// sets up barn event
barn_enter_setup()
{
	getent("enter_barn","targetname") waittill ("trigger");

	jl_beta = "jl_beta";
	ender_b = "end_beta";
	time_b = 0.5;
	min_b = 1;
	max_b = 4;

//	level thread maps\_squad_manager::manage_spawners(alpha,2,4,alpha_group1_done,3,::alpha_squad_init);

//	wait 5;

//	level notify("end_alpha");

	println("^6 ***************** FUBAR ************************");
	level thread maps\_squad_manager::manage_spawners(jl_beta,min_b,max_b,ender_b,time_b,::beta_squad_init);
}

beta_squad_init()
{
	wait 4;
	
	level notify("end_beta");
}

barn_exit_setup()
{
//	getent("exit_barn","targetname") waittill ("trigger");
	println("^6 ******************  exit barn trigger working and random guys spawn on path towards crossroads*************");
}

// americans that are inside the barn and can be killed
hurt_squad_setup()
{
	println("^6 ****************** event 4 guys setup is working ****************");
	hurt_array =[];// this defines it as an array
	hurt_group = getentarray("hurt_guys", "groupname");

	for(i=0;i<(hurt_group.size);i++) //		
	{	
		//squad2_array[i] = getent("squad2_guy_" + i, "targetname");
		guy = hurt_group[i] stalingradspawn();
		guy waittill ("finished spawning");
		guy.targetname = hurt_group[i].targetname +"_guy";
		guy animscripts\shared::putGunInHand ("none");
		guy thread maps\_utility_gmi::magic_bullet_shield();
		guy.hasweapon = false;
		guy.pacifist = true;
//		guy.team = "al";
//		guy allowedstances("prone");
		guy thread hurt_alive_count();
		guy.allowdeath = true;
		//guy.loops = 100;
//		guy thread anim_loop_solo(guy,"idle");
//		thread anim_loop(guy, "idle", undefined, undefined, self);
//		guy thread anim_loop_solo(guy,"idle", undefined, "end anim");
//		guy thread maps\_anim_gmi::anim_loop_solo ( guy, "idle", tag, "stop_anim", node, tag_entity );
		guy thread play_anims();
	}

//	hurt_group[i] thread maps\_anim_gmi::anim_loop ( guy, "idle", tag, "stop_anim", node, tag_entity );
}

// this function will play anims for guys that are on the ground
play_anims()
{
//	self.animname = "neckguy";
//	self thread anim_loop_solo(self,"idle");
	println("^3*************  hurt guy made it to function ***********");
	println("^6*************  hurt guy made it to function ***********");
	println("^3*************  hurt guy made it to function ***********");
	println("^6*************  hurt guy made it to function ***********");
	println("^3*************  hurt guy made it to function ***********");

	if(self.targetname == "hurt_guy_1_guy")
	{
		println("^3*************  hurt guy made it to anim ***********");
		println("^6*************  hurt guy made it to anim ***********");
		println("^3*************  hurt guy made it to anim ***********");
		println("^6*************  hurt guy made it to anim ***********");
		println("^3*************  hurt guy made it to anim ***********");
		self.animname = "laying";
		self thread anim_loop_solo(self,"idle");
	}


	if(self.targetname == "hurt_guy_2_guy")
	{
		println("^3*************  hurt guy made it to anim ***********");
		println("^6*************  hurt guy made it to anim ***********");
		println("^3*************  hurt guy made it to anim ***********");
		println("^6*************  hurt guy made it to anim ***********");
		println("^3*************  hurt guy made it to anim ***********");
		self.animname = "neckguy";
		self thread anim_loop_solo(self,"idle");
	}

	if(self.targetname == "hurt_guy_3_guy")
	{
		self.animname = "wallb";
		self thread anim_loop_solo(self,"idle");
	}
}

anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_loop ( newguy, anime, tag, ender, node, tag_entity );
}

//===================================================================
//
//  This counts up until three of the injured americans are killed
//
//===================================================================
hurt_alive_count()
{
	level endon("objective_9_complete");	
	self waittill ("death");
	
	level.ally_prisoner_count++;


	if(level.ally_prisoner_count == 1) // Checks the death count of roofsnipers.
	{
		println("^3 **************** HEY ONE GUY IS DOWN *****************");
		println("^3 **************** HEY ONE GUY IS DOWN *****************");
		println("^3 **************** HEY ONE GUY IS DOWN *****************");
		println("^3 **************** HEY ONE GUY IS DOWN *****************");
		// We lost one ... keep them alive
		// battle is tough level one
	}

	if(level.ally_prisoner_count == 2) // Checks the death count of roofsnipers.
	{
		println("^3 **************** HEY TWO GUYS ARE DOWN *****************");
		println("^3 **************** HEY TWO GUYS ARE DOWN *****************");
		println("^3 **************** HEY TWO GUYS ARE DOWN *****************");
		println("^3 **************** HEY TWO GUYS ARE DOWN *****************");
		// WE lost two keep them alive 
		// battle is tough level two	
	}


//	println("^3**************** level.last_guys_near_88_count",level.last_guys_near_88_count.size);
	if(level.ally_prisoner_count == 3) // Checks the death count of roofsnipers.
	{
		// WE lost two keep them alive 
		// battle is tough level three	

		//missionfail

		println ("^5 MISSION FAIL BABY");
//		level notify("moody_start_cover_7");	// this tells the moody_move_thread to pick up after hes gone to cover6 
//		missionSuccess("noville", false);
//		wait 5;
		level thread mission_fail_all_prisnor_dead();
	}

	
}

mission_fail_all_prisnor_dead()
{
	iprintlnbold(&"GMI_BASTOGNE2_FAIL_PRISONERS");
	wait 5;
	missionfailed();
}

#using_animtree("generic_human");
stay_behind_setup()
{
	level waittill("second_squad_protect_pris");
//	getent("sold_stay_back","targetname") waittill ("trigger");

	// need to stop guys from spawning and then count them down then say these line.
	level.blue[0].pacifist = 1;
	level notify("squad_group_for_orders_to_stay_behind");
	fnode = getnode("moody_stay_behind", "targetname");
	level.blue[0] setgoalnode(fnode);
	level.blue[0] waittill("goal");	// getst into position
	wait 7;
	level notify("end_beta"); // stop sqaud from attacking from hills


	// distance check -- need to setup anobjective here...

	while(1)
	{
		if (distance (level.player getorigin(), level.blue[0].origin) < 100)	
		{	

			level.scr_anim["moody"]["moody_crossroad"]		= (%c_us_bastogne2_moody_crossroad);
		
			level.scr_notetrack["moody"][0]["notetrack"]		= "moody_crossroad";
			level.scr_notetrack["moody"][0]["dialogue"]		= "moody_crossroad";
			level.scr_notetrack["moody"][0]["facial"]		= (%f_bastogne2_moody_crossroad);	
			level.moody thread anim_single_solo(level.moody,"moody_crossroad");			
//			level.blue[0] playsound ("moody_crossroad");	// allies have been protected
			wait 4.6;
			level notify("objective_9_complete");	
		
			level thread to_crossroads_friendly_setup();
			// make any remaining guards stay with troopers

			break;
			//set health back to normal from here for everyone at crossroads
		}
		wait 1;
	}


	fnode = getnode("open_barn_last_door", "targetname");
	level.blue[0] setgoalnode(fnode);
	level.blue[0] waittill("goal");	// getst into position

//	wait 1.5;
	level notify ("open_last_door");
}

moody_talk_ridge()
{
	getent("ridge_line","targetname") waittill ("trigger");

//	while(1)
//	{
//		if (distance (level.player getorigin(), level.blue[0].origin) < 800)	
//		{					
			level.blue[0] playsound("moody_along_ridge");
			println("^3 *******8 moody said ridge line ***********");
//			break;
//		}
//		wait 0.05;
//	}	
}

to_crossroads_friendly_setup()
{
	level.blue[0] setgoalentity(level.player);
	level.blue[0] allowedstances("stand","crouch","prone");
	level.blue[0].pacifist = 0;
	level.blue[0].followmax = 3;
	level.blue[0].followmin = 0;

	level.blue[1].followmax = 3;
	level.blue[1].followmin = 0;
	level.blue[1] allowedstances("stand","crouch","prone");

	level.blue[2].followmax = 1;
	level.blue[2].followmin = 0;
	level.blue[2] allowedstances("stand","crouch","prone");

}

print_dialog3d(who,text,duration)
{
	if(!isdefined(duration))
	{
		duration = 3;
	}
	time = 0;
	while(time < duration)
	{
		print3d((who.origin + (0,0,100)), text,(1,1,1), 2, 1);
		wait 0.075;
		time = 0.1 + time;
	}
}

setup_crossroad()	// germans in bunker!!
{
	getent("cross_trigger","targetname") waittill ("trigger");
	level notify ("cross go");

	println("^6 ************** crossroad germans are spawned in now *****");
	germans1_array =[];// this defines it as an array
	germans1_group = getentarray("bunker_guards", "groupname");

	for(i=1;i<(germans1_group.size+1);i++)//		
	{
		println("^3 ************** crossroad DING german spawn!!! *****");
		germans1_array[i] = getent("event12_guy_" + i, "targetname");
		guy = germans1_array[i] dospawn();
	//	germans1_array_ai[i].pacifist = false;
		guy.health = 50000;
		guy thread cross_german_death_counter();
		guy thread pacifist_count();
		guy thread bunker_support1();

		guy.targetname = germans1_array[i].targetname +"_guy";
		guy thread bunker_germans_set_health();
	}

	level thread wait_player_dia();
}

//===================================================================
//
// If three of the cross road germans die, then start a spawner that attemps to fill the foxhole
//
//===================================================================
bunker_support1()
{
	while(1)
	{

		if(level.cross_german_count >= 2) 
		{
				level notify ("start_forward_flood_spawner");	
					break;
		}
		wait 1;
	}
}

//===================================================================
//
// The makes each guys slowly turn off his pacifist mode, to make the battle sound it's starting up slowly, instead of instantly!
//
//===================================================================
pacifist_count()	// slowly makes each guy not passive so it feels as if the battles gets intense
{
		wait (3 + randomfloat (15));
		self.pacifist = false;

}

//===================================================================
//
// This keeps the germans alive until the player gets closer to cross roads, insuring that the battle continues
//
//===================================================================
bunker_germans_set_health()
{
		level waittill("player_at_crossraods");
		self.health = 190;

		if(self.targetname == "event12_guy_1_guy")
		{
//				self thread maps\_utility_gmi::magic_bullet_shield();
				self thread maps\_utility_gmi::make_player_feel_important();

				while(1)
				{
					if (distance (level.player getorigin(), self.origin) < 300)	
					{
						println("^3 Mg 42 guy is not off of god mode now ");
						self notify ("stop magic bullet shield");
						break;	
					}
					wait 1;
				}
		}
}

cross_german_death_counter()
{
	self waittill("death");
	level.cross_german_count++;

}

// makes ai wait till player is near to give him orders
wait_player_dia()
{
	getent("tell_mg42","targetname") waittill ("trigger");
	level notify("player_at_crossraods");
//	while(1)
//	{
//		if (distance (level.player getorigin(), level.blue[0].origin) < 1500)	
//		{
					level thread over_the_hill_d(); // placed in seperate function because of timing
//					break;
					//set health back to normal from here for everyone at crossroads
//		}
//		wait 1;
//	}
}

over_the_hill_d()	// add ram to team names for thirs scquad
{

	wait 6;
	level.blue[0] playsound ("moody_silence_mg42"); // take our mg42 -- main resistence


	level notify("objective_10_complete");

}

ram_over_hill()
{
	getent("ram_over_hill","targetname") waittill ("trigger");

	println(" ^3 ***********  ram_over_hill trigger has been hit moody_thats_ramirez");
	level notify ("bmw_can_delete_now"); 

//	level.scr_anim["moody"]["moody_thats_ramirez"]		= (%c_us_bastogne2_moody_thats_ramirez);
//	level.scr_face["moody"]["moody_thats_ramirez"]		= (%f_bastogne2_moody_that_ramirez);

	level.moody thread anim_single_solo(level.moody,"moody_thats_ramirez");
	println(" ^3 ***********  moody_thats_ramirez");
}

squad3_setup()	// amricans that are across the road at the cross roads
{
	println("^4 ************** crossroad ally waiting  *****");
	level waittill ("cross go");

	println("^3 ************** crossroad before ally loop *****");

	squad3_array =[];// this defines it as an array
	squad3_group = getentarray("squad3", "groupname");

	println("^6 ************** crossroad allies just before spawn *****");
	for(n=1;n<(squad3_group.size+1);n++)//		
	{
		println("^6 ************** crossroad allies are spawned in now *****");	
		squad3_array[n] = getent("squad3_guy_" + n, "targetname");
		squad3_array_ai[n] = squad3_array[n] dospawn();
		squad3_array_ai[n].pacifist = true;
		squad3_array_ai[n].health = 50000;
		squad3_array_ai[n].suppressionwait = 0.5;
		squad3_array_ai[n] thread squad3_wait_for_player(n);
	}	

	wait 9;
	level.moody thread anim_single_solo(level.moody,"moody_heavy_fire");
	println(" ^3 ***********  moody_heavy_fire");
}

squad3_wait_for_player(n)	// makes squad three move up when all the germans are killed in bunker
{
//	level waittill ("squad3_move_to_bunker");

	while(1)
	{
//		if(level.cross_german_count == 8) // if all germans and dead and player is close to moody then continue to cross roads
//		{


			if(level.cross_german_count == 9) // if all germans and dead and player is close to moody then continue to cross roads
			{
						node = getnode("squad3_bunker_spot" + n, "targetname");
						self setgoalnode(node);	
						self waittill("goal");	
						level.flag ["crossroads_alive"] = false;						
				//		level waittill("player_at_crossraods");
				//		self.health = 300;
						break;
			}
//		}
		wait 1;
	}

}

// when ambush is clear...
crossroads_clear() // 
{
	getent("at_crossroads","targetname") waittill ("trigger");
	while(1)
	{

		if(level.cross_german_count == 9) // if all germans and dead and player is close to moody then continue to cross roads
		{
//			level notify ("squad3_move_to_bunker");
				if (distance (level.player getorigin(), level.blue[0].origin) < 1000)	
				{
					// tell player to do ambush now...
					maps\_utility_gmi::chain_off("5000");	// start of maps\bastogne2_event1to2::event4to7
					level.blue[0].followmax = 4;
					level.blue[0].followmin = 0;
					break;
				}
		}
		wait 1;
	}

	level notify("end_cross1");
	level thread maps\_spawner_gmi::kill_spawnerNum(3); // stops forward 3
	level thread maps\_spawner_gmi::kill_spawnerNum(4);	// stops forward 4
	level thread axis_do_damage();
	wait 5;

	ai = getaiarray ("axis");
	for (i=0;i<ai.size;i++)
	{ 
		if(isalive(ai[i]))
		{
			ai[i] DoDamage ( ai[i].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );	
		}
	}

	wait 2;


	while(1)
	{
		if (distance (level.player getorigin(), level.blue[1].origin) < 800)	
		{					
			break; // continue once the player is close enough to the event.
		}
		wait 0.05;
	}

	level notify ("turn_event7_triggers_controller_on"); // this turns on all triggers.. for event7

//	level.blue[1] playsound ("whitney_convoy"); // Ambush is coming sarge
	level.blue[1] thread anim_single_solo(level.blue[1], "whitney_convoy"); // setup ambush -- main resistence
	wait 3.3;
	level notify("objective_11_complete"); // go to ambush now

	level.moody thread anim_single_solo(level.moody, "moody_goto_ambush"); // setup ambush -- main resistence
	wait 8.6;
	level notify ("moody_goto_ambush_done");

// bug this chain is not working... I think it's turning on yet it's still acts funny	
	println("^6 * hey chain for last area is on now 1111111111111");
	maps\_utility_gmi::chain_on("6000");	// start of maps\bastogne2_event1to2::event4to7
	println("^6 * hey chain for last area is on now 2222222222222");
	chain = maps\_utility::get_friendly_chain_node ("6000");
	println("^6 * hey chain for last area is on now 3333333333333");
	level.player SetFriendlyChain (chain);
	// load jess stuff from here...
}

delete_ambient_squad2()
{
	level waittill("event4_begin");
	squad2 = [];
	squad2 = maps\_squad_manager::alive_array("event2_squad2_a");
	for (i=0;i<squad2.size;i++)
	{
		if (isalive(squad2[i]))
		{
			squad2[i] delete();
		}
	}
}

#using_animtree("generic_human");
officer_walk()
{	wait 8.4;
	guys[0] = self;
	maps\_anim_gmi::anim_pushPlayer(guys);
	self notify("end anim");
	self allowedstances("stand");
	self.goalradius = 0;
	self.walkdist = 9999;
	patrolwalk[0] = %c_prisoner_walk_c;
	patrolwalk[1] = %c_prisoner_walk_c;
//	self.walk_noncombatanim_old = self.walk_noncombatanim;
//	self.walk_noncombatanim2_old = self.walk_noncombatanim2;
	self.walk_noncombatanim = maps\_utility_gmi::random(patrolwalk);
	self.walk_noncombatanim2 = maps\_utility_gmi::random(patrolwalk);
	//self animscriptedloop("scripted_animdone", self.origin, self.angles, self.walk_noncombatanim);
}	

officer_walk_end()
{
	getent("event1_player_cresting_hill","targetname") waittill ("trigger");
	
	guys = getaiarray("allies");
	
	for (i=0;i<guys.size;i++)
	{
		if (isalive(guys[i]))
		{ 
			guys[i].pacifist = false;
			guys[i] allowedstances("stand","crouch","prone");
			guys[i].walk_noncombatanim = guys[i].walk_noncombatanim_old;
			guys[i].walk_noncombatanim2 = guys[i].walk_noncombatanim2_old;
			guys[i].walkdist = 0;
			guys[i].goalradius = 8;
		}
	}
}

// new walk fopr americans
walkies()
{
	if(self.targetname == "squad2_guy_1_guy")
	{
		self.dontavoidplayer = 1;
		self allowedstances("stand");
		self.pacifist = 1;
		self.goalradius = 0;
		self.walkdist = 9999;
		patrolwalk[0] = %c_walk_fastA;
		patrolwalk[1] = %c_walk_fastA;
		patrolwalk[2] = %c_walk_fastA;
		//self.walk_noncombatanim_old = self.walk_noncombatanim;
		//self.walk_noncombatanim2_old = self.walk_noncombatanim2;
		self.walk_noncombatanim = maps\_utility_gmi::random(patrolwalk);
		self.walk_noncombatanim2 = maps\_utility_gmi::random(patrolwalk);
		//self animscriptedloop("scripted_animdone", self.origin, self.angles, self.walk_noncombatanim);
	}
}	

walkies_off()
{
	self.dontavoidplayer = 0;		
	self allowedstances("stand","crouch","prone");
	self.walk_noncombatanim = self.walk_noncombatanim_old;
	self.walk_noncombatanim2 = self.walk_noncombatanim2_old;
	self.walkdist = 0;
	self.goalradius = 8;
}

//=====================================================================================================================
//	event6_vehicle_init()
//
//		Sets up the vehicle to drive by player on road towards the cross roads battle
//=====================================================================================================================
event6_vehicle_init() // adjusted nodes in beggining battler, fixed shooting at flare event, adjust nodes after pris and added mortocycle.
{
	if(getcvar("scr_gmi_fast") != "2")
	{
		setCullFog (0, 8700, 0.0274, 0.0823, 0.1607, 0 );
	}

	level waittill ("bmw_fade_up_done");
//	getent("event6_cresting_hill_trigger","targetname") waittill ("trigger");
//	wait 5;

	event6_vehicle = getent("event6_vehicle","targetname");
	event6_vehicle_driver_prep = getent("event6_vehicle_driver","targetname");
	println("^3 ", event6_vehicle_driver_prep.targetname);
	event6_vehicle_driver = event6_vehicle_driver_prep stalingradspawn();	
	event6_vehicle_path = getvehiclenode("event6_vehicle_node","targetname");
//	event6_vehicle thread maps/_bmwbike_gmi::crashroll();

	wait 0.01;
	
	// make sure he goes to the node
	event6_vehicle_driver.bravery = 500000;
	event6_vehicle_driver.goalradius = 2;
	event6_vehicle_driver.pacifist = 1;
	event6_vehicle_driver.ignoreme = true;
    	event6_vehicle_driver.pacifistwait = 0; 
//	event6_vehicle_driver.health = 1;
    // 	event6_vehicle_driver.playpainanim = false;		// this should keep the guy from reacting to pain
//	event6_vehicle_driver thread maps\_utility_gmi::cant_shoot();
//	event6_vehicle_driver thread maps\_utility::magic_bullet_shield();
	

	event6_vehicle_driver thread deathdriver();
	// mount the vehicle
//	event6_vehicle thread maps\_bmwbikedriver_gmi::main(event6_vehicle_driver);
	event6_vehicle thread maps\_bmwbike_gmi::init();
	event6_vehicle thread maps\_bmwbike_gmi::crashroll();
//	event6_vehicle thread maps\_vehiclechase_gmi::enemy_vehicle_paths();
//	event6_vehicle thread bmw_health_counter();
//	event6_vehicle_driver thread bmw_health_hurt();
	event6_vehicle thread deathroll(event6_vehicle);

	wait(0.05);

//	event6_vehicle_driver.health = 1;
	event6_vehicle.health = 1;
//	event6_vehicle thread maps\_bmwbike_gmi::crashroll();
	println("^3 ********* event6_vehicle_driver:   ", event6_vehicle_driver.health);
	
	// turn on the bmw
	playfxontag( level._effect["event1_bmw_headlight"], event6_vehicle,"tag_light");
	
	wait(3);

	event6_vehicle attachpath( event6_vehicle_path );

	guys = [];
	guys [0] = event6_vehicle_driver;

	event6_vehicle thread maps\_bmwbike_gmi::handle_attached_guys(guys);

	event6_vehicle startpath();

	event6_vehicle thread event6_vehicle_horn();
	
	wait 0.5;
	level notify ("stop bmw rumble");


	event6_vehicle waittill("reached_end_node");

//	level notify ("stop bmw rumble");

//	event6_vehicle delete();
	event6_vehicle_driver delete();
}

friendly_damage_penalty()
{	
	self waittill ("damage", dmg, who);
	
	if (who == level.player)
	{
		setCvar("ui_deadquote", "@SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
		missionfailed();
	}
}

deathdriver()
{

//	wait 8;
//	self.health = 100;

	self waittill ("damage", dmg, who);

	if (who == level.player)
	{
		level notify ("driver_dead");	
	}

	self thread deathdriver_sound();

	level notify ("stop bmw rumble");

	level waittill("bmw_can_delete_now");
	self delete();	
}

deathdriver_sound()
{
	self playsound("generic_misccombat_german_3");
}

deathroll(event6_vehicle)
{
	level waittill ("driver_dead");	
	self notify ("crashpath");

	self playsound ("Dirt_skid");

	wait 5;
	stopattachedfx(event6_vehicle);

	level waittill("bmw_can_delete_now");
	self delete();
}

event6_vehicle_horn()
{
	level endon ("driver_dead");
	wait 4;
	self playsound ("bike_horn_frantic");	
	println("NEED A HORN SOUND");
	wait (1);
	
	println("NEED A HORN SOUND");
	wait (3);
	self playsound ("bike_horn_frantic");	

	println("NEED A HORN SOUND");
}

distanttankrumbledeathender()
{
//	wait (10);
	level waittill ("stop bmw rumble");
	wait (2);
	self delete();
}

event6_distantbmw()
{
//	wait 5;
//	level.player setorigin ((7553, 5189, 309));

//	level.player setorigin ((6868, 4896, 174));
//	getent("ridge_line","targetname") waittill ("trigger");
	getent("start_bmw_sound","targetname") waittill ("trigger");


//	getent("event6_cresting_hill_trigger","targetname") waittill ("trigger");

	// (7732,8955,100));.  where it should start

//	wait 5;

	org = spawn ("script_origin", (0,0,0));
	org endon ("death");
	org thread distanttankrumbledeathender();
	org thread event6_distantbmw_kill_sound();


//   7864,9634,100
//	offset = 11200;
	offset = 8500;
	vec = (9144, 6112, 100);
//	vec = (7864,9634,100);
	while(offset > 8335)
	{
		offset -= 20;
		org.origin = (vec[0] + offset, vec[1], vec[2]);
		println(" ^9 ***********  PLAYSOUND OF JEEP 2***********");
		org playloopsound ("bmwbike_engine_high");
		wait 0.05;
	}

	level notify ("bmw_fade_up_done");
}

event6_distantbmw_kill_sound()
{
	level waittill ("stop bmw rumble");
	self delete();
}

// Think function for distant_light script_origins.
// Randomly plays the lights in the sky.
Random_Distant_Light_Think()
{
	getent("ram_over_hill","targetname") waittill ("trigger");
	level endon("stop_distant_lights");

	wait 6;

	if(getcvar("scr_gmi_fast") != "2")
	{
		while(1)
		{
			range = level.dist_light_max_delay - level.dist_light_min_delay;
			wait level.dist_light_min_delay + randomfloat(range);
			playfx(level._effect["distant_light"],self.origin);
			self playsound("shell_flash");
		}
	}
}

//=====================================================================================================================
//	ambient_trucks_crossroads()
//
//		makes random trucks drive away as the player gets to the crossroads
//=====================================================================================================================
ambient_trucks_crossroads()
{
	getent("start_runaway_guys","targetname") waittill ("trigger");
	while(1)
	{
		if(level.german_truck_count <= 1)	
		{	
			level.german_truck_count++;

			truck2 = spawnVehicle( "xmodel/vehicle_german_truck_snow", "c_2", "GermanFordTruck" ,(0,0,0), (0,0,0) );
			truck2 maps\_truck_gmi::init();
			path2 = getVehicleNode ("ambient_t1_path","targetname");
			truck2 attachpath(path2);
			playfxontag( level._effect["truck_lights"], truck2,"tag_origin");
			truck2.isalive = 1;
			truck2.health = (10000000);
			truck2 startpath();
			truck2 setspeed(20,15);
			truck2 thread ambient_trucks_crossroads_delete();
		
			wait (5.3 + randomfloat (9.3));	
				
		//	truck3 = spawnVehicle( "xmodel/vehicle_german_truck_covered", "c_2", "GermanFordTruck" ,(0,0,0), (0,0,0) );
			truck3 = spawnVehicle( "xmodel/vehicle_german_truck_snow", "c_3", "GermanFordTruck" ,(0,0,0), (0,0,0) );
			truck3 maps\_truck_gmi::init();
			path3 = getVehicleNode ("ambient_t1_path","targetname");
			truck3 attachpath(path3);
			playfxontag( level._effect["truck_lights"], truck3,"tag_origin");
			truck3.isalive = 1;
			truck3.health = (10000000);
			truck3 startpath();
			truck3 setspeed(25,25);
			truck3 thread ambient_trucks_crossroads_delete();
		}
		wait 0.01;	
	}
}

ambient_trucks_crossroads_delete()
{
	self waittill("reached_end_node");
	self delete();
}

cross_squad_runaway()
{
	getent("start_runaway_guys","targetname") waittill ("trigger");
	jl_cross1 = "event6_cross_runaway";
	ender_c = "end_cross1";
	time_c = 3;
	min_c = 1;
	max_c = 2;

	level thread maps\_squad_manager::manage_spawners(jl_cross1,min_c,max_c,ender_c,time_c,::cross_squad_runaway_init);
}

cross_squad_runaway_init()
{
	self.pacifist = 1;
	self waittill("goal");

	self delete();
}

//====================================
//
//  THis starts the crossroads battle sequence
//
//====================================
flood_spawners_controller_crossroads()
{
	trigger_forward1 = getent("forward1", "script_noteworthy"); // the bunker guards are down to seven left then spawn in reinforcement...

	trigger_forward1 maps\_utility_gmi::triggerOff();

	level waittill ("start_forward_flood_spawner");


	println ("^4 ************ forward spawner is now on ****************");
	trigger_forward1 maps\_utility_gmi::triggerOn();

//	trigger2 = getent("center", "script_noteworthy");
}

//====================================
//
//  If the player cross's the road to early own them
//
//====================================
event6_own_player()
{
	trigger1 = getent("own_player_crossroads", "targetname");
//
	level waittill("player_at_crossraods");
	level.flag ["crossroads_alive"] = true;
//
	wait 3;
	println("^3 event6_own_player is ready to fire...");
//	
	while(1)
	{
		while(level.player istouching(trigger1) && level.flag ["crossroads_alive"] == true)
		{
		       thread playSoundinSpace ("weap_kar98k_fire", level.player.origin);
	               org = (0,0,0);  
	               // Player starts off with 600 health... yes, 600 
	               dmg = 0; 
	 
	               // TODO: Insert playsound here, from the sniper guy of a  
	               // sniper rifle being fired. 
	 
	               level.player doDamage ( dmg, org); 
			println("^3 Hurt the player count up");
			wait (0.05 + randomfloat(0.5));
		}
		wait 0.05;
	}
}

playSoundinSpace (alias, origin)
{
	org = spawn ("script_origin",(0,0,1));
	org.origin = origin;
	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}

goldstar_in_trench_at_Cross()
{
	triggers = getentarray("flood_spawner", "targetname");

		println(" ^2 *********************  flood_spawner *************");
		println(" ^2 *********************  flood_spawner *************");
		println(" ^2 *********************  flood_spawner *************");
		println(" ^2 *********************  flood_spawner *************");
		println(" ^2 *********************  flood_spawner *************");
		println(" ^2 *********************  flood_spawner *************");
	for(i=0;i<triggers.size;i++)
	{

		println(" ^2 *********************  triggers 1 *************");

		// dead entity is not an object
		if (isdefined(triggers[i]))	//	maybe spot it 
		{

			println(" ^2 *********************  triggers 2 *************");

			if(isdefined(triggers[i].script_noteworthy) && triggers[i].script_noteworthy == "goldstar")
			{
				println(" ^2 *********************  script_noteworthy waiting *************");
				triggers[i] waittill ("trigger");
//				wait 6;
				println(" ^2 ********************* GOLDSTAR script_noteworthy activated *************");
				println(" ^2 ********************* GOLDSTAR script_noteworthy activated *************");
				println(" ^2 ********************* GOLDSTAR script_noteworthy activated *************");
				println(" ^2 ********************* GOLDSTAR script_noteworthy activated *************");
				println(" ^2 ********************* GOLDSTAR script_noteworthy activated *************");
				level notify ("player_is_in_trench");
			}
		}		
	}
}

//====================================
//
//  Turn event7 triggers off and then on at the right time.
//
//====================================
event7_triggers_controller()
{
	trigger1 = getent("event7_chain1", "targetname"); 
	trigger2 = getent("spawn_convoy_assault", "targetname"); 
	trigger3 = getent("event7_chain2", "targetname");
	trigger4 = getent("event7_chain3", "targetname");
	trigger5 = getent("convoy_start", "targetname");

	trigger1 maps\_utility_gmi::triggerOff();
	trigger2 maps\_utility_gmi::triggerOff();
	trigger3 maps\_utility_gmi::triggerOff();
	trigger4 maps\_utility_gmi::triggerOff();
	trigger5 maps\_utility_gmi::triggerOff();

	level waittill ("turn_event7_triggers_controller_on");

	trigger1 maps\_utility_gmi::triggerOn();
	trigger2 maps\_utility_gmi::triggerOn();
	trigger3 maps\_utility_gmi::triggerOn();
	trigger4 maps\_utility_gmi::triggerOn();
	trigger5 maps\_utility_gmi::triggerOn();

}


