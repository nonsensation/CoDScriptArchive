/**************************************************************************
Level: 		Bastogne (additional)
Campaign: 	Allied
***************************************************************************/

/*

Jesse's Bug / To Do / Request / Notes list:

Bugs:
- 2nd set of mortars (not in use atm) not stopping on halt command

High Priority:
- stagger squad to advance
- squads should advance with tanks (2nd line)
- Moody needs to slide across top of jeep (awaiting art)
- Remove temp moody (awaiting above)
- music?

Medium Priority:
- Begin balancing with god mode off
- Medics tend to passengers after jeep parks. (waiting for art)
- put in doms medics anims
- mg42 shoot at script_origin
- adjust tanks so they dont "pop" over trees
- Need bazooka AI (waiting for art)
- 50 cal needs new stand and model
- make shermans more cautious

Low Priority:
- Need to add some in animations for foxhole guys
- add in panzerfaust soldiers to 2nd line?

// Waiting on others /  other people need to complete:

- foxhole models are disappearing
- Art needs to fix 30 cal model in game (turned to the side)
- Aim needs to be adjusted for 30 cal (waiting on ?)
- get guys into foxholes properly now that new models have been added (wait for kevin to update foxhole model placement)

*/

// 
//
//
//
// Main
//

main()
{	
	maps\_mortarteam_gmi::main();
	maps\_minefields_gmi::minefields();
	maps\_p47_gmi::main();
	
	level thread ammo_max_setup();
	
	if (getcvar("scr_gmi_fast") != 0)
	{
		//level.mortar = level._effect["mortar_low"];
		level.p47_bomb = loadfx ("fx/explosions/vehicles/p47_bomb_snow_low.efx");
	}
	else
	{
		//level.mortar = level._effect["mortar"];
		level.p47_bomb = loadfx ("fx/explosions/vehicles/p47_bomb_snow.efx");
	}
	
	
	if (getcvar("start") != "jesse_start" && getcvar("start") != "plane_start")
	{
		getent ("trigger_jesse","targetname") waittill ("trigger");	// Wait for trigger on rail to start execution of this script.
	}
	
	level thread delete_ai();						// Deletes any leftover ai.
	
	wait 0.5;
	
	level.flags["near30cal"] = false;		   			// Player hasn't been near 30 cal
	level.flags["moody_speech_over"] = false;		   		// Moody's speech is over in barn
	level.flags["battle_over"] = false;					// Flag for 1st battle	
	level.flags["smoke_pop_event"] = false;
	level.flags["battle2_over"] = false;					// Flag for 2nd (tank) battle
	level.flags["dragger_dead"] = false;					// If the dragged guy is dead or not
	level.flags["safe1"] = true;						// Safe foxhole 1 on 2nd line on or off
	level.flags["safe2"] = true;						// Safe foxhole 2 on 2nd line on or off
	level.flags["safe3"] = true;						// Safe foxhole 3 on 2nd line on or off
	level.flags["mg_mod"] = false;
	level.flags["foxholes_on"] = false;
	level.flags["30cal_moveout"] = false;
	level.flags["tank1_reached_node"] = false;
	level.flags["tank2_reached_node"] = false;
	level.flags["tank3_reached_node"] = false;
	level.flags["moody_to_ridge"] = false;
	level.flags["kill_more_guys_event"] = false;
	level.flags["snipers_dead"] = false;
	level.flags["moody_punish_off"] = false;
	level.flags["sniper_begin"] = false;
	level.flags["mg42s_alive"] = false;
	level.flags["30cal_open_path"] = false;
	level.flags["no_more_path_spawn"] = false;
	level.flags["end_chickenshit"] = false;
	level.flags["anderson_prod"] = true;
	level.flags["dontplayflag"] = false;
	level.flags["endtankalive1"] = 1;
	level.flags["endtankalive2"] = 1;
	level.flags["endtankalive3"] = 1;

	//MikeD: Added this to support "preventing the kill_player mortar"
	level.flags["stop_kill_player_mortar"] = true;
	level.flags["use_pummel_player"] = false;
	level.flags["pummeling_player"] = false;
	
	level.deadtanks = 0;
	
	level.nodearray_30cal = getnodearray("30cal_ai_go_here","targetname");
	level.nodearray_counter = 0;
	
	level.mortar2 = level._effect["barn_dust"];				// Barn dust
	level.mortar2_quake = 0.5;						// sets the intenssity of the mortars
	//level.barn_sound = "barn_not";						// Set to "barn" for far off sounds.
	
	level.iStopBarrage = 0;	   						// Bool for Regular mortar barage on lines
	level.iStopBarrage2 = 0;						// Bool for Barn dust "mortars"
	level.iStopBarrage3 = 0;						// Bool for US team mortars
	level.iStopBarrage4 = 0;						// Bool 2nd line mortars
		
	//level.starting_thirtycal = getentarray ("weapon_mg30cal", "classname");	// Gets the 30 cal
	//level.starting_bazooka = getentarray ("zooka", "script_noteworthy");	// Gets the 'zooka
	//level.starting_bazooka_main = getentarray ("zooka", "script_noteworthy");	// Gets the 'zooka
	
	anderson_spawn = getent("anderson","targetname");	   		// Get Anderson, thread his stuff
	anderson = anderson_spawn stalingradspawn();
	level.anderson = anderson;
	//moodytemp_spawn = getent("moodytemp","targetname");			// FIX: Temp-Get Moody, thread his stuff
	//moodytemp = moodytemp_spawn stalingradspawn();
	
	//thread thirtycal_check();			   			// Notification of picking up 30 cal
	
	anderson thread anderson_think();		   			// Mr. Bodymasageman GO
	level.moody thread moody_think();					// Moody GO
	
	level thread fiftycal_guy_setup();					// Soldiers in the foxholes
	level thread foxholeSoldier_setup();					// Soldiers in the foxholes
	level thread officer_setup();						// Spawns in officers in barn.
	level thread table_map_anim();						// Map and bottle animation
	level thread foley();							// Spawns in Foley, sets his attributes.
	level thread wall_flower_init();
	level thread player_favorite();
	level thread medics_in_barn();
	
	level thread pre_drag_node((getnodearray ("drag_guy","targetname"))[0]);// dragged guy idle
	level thread drag_node((getnodearray ("drag_guy","targetname"))[0]);	// Set drag guy events into action
	
	
	//input for mortars			(fRandomtime, iMaxRange, iMinRange, iBlastRadius, iDamageMax, iDamageMin, fQuakepower, iQuaketime, iQuakeradius, targetsUsed, seedtime,         stopper, 		targets, 	level_mortar, 	mortar_notify, quakePower, 		fx, 		soundnum, sound_flag, dust_notify)
	level thread maps\_mortar_gmi::railyard_style   (0.5,       3000,      1,         0,            150,        25,         0.15,        2,          150,          0,	      0);
	level thread mortar_general_distance		(3,       1024,      1,         0,            0,          0,          0.05,        1,          1024,         0,	      0,	level.iStopBarrage2,	"barn_dust",	level.mortar2,	undefined,	level.mortar2_quake,	level.mortar2, undefined, undefined, true);
	level thread mortar_general_distance		(2,         3000,      1,         0,            0,          0,          0.15,        1,          512,          0,	      0,	level.iStopBarrage3,	"us_mortar",	level.mortar,	undefined,	undefined,		level.mortar,  undefined, undefined);
	//level thread mortar_general_distance		(0.5,       4000,      1,         0,            150,        25,         0.15,        2,          256,          0,	      0,	level.iStopBarrage4,	"mortar2",	level.mortar,	undefined,	level.mortar_quake,	level.mortar,  undefined, undefined);

	//thread garbage_man();							// Removes ents marked as garbage

	//cvar checks
	
	if (getcvar("start") == "jesse_start")
	{
		wait 3;		
		level.moody unlink();
		node = getnode("moody_jeep_end","targetname");
		level.player setorigin((-10000,-10000,-10000),(0,0,0)); 
		level.moody teleport(node.origin,(0,0,0));
		
		println("moody teleported");
		
		wait 0.05;
								// Debug stuff
		level.player setorigin((-5128,-7488,64),(0,0,0));  		// Debug stuff
		level notify("objective_1_complete");
		wait 0.25;
		level notify("objective_2_complete");
		
		
			setCullFog (0, 6000, .61, .66, .68, 22 );
			println("^6 ************ cullfog set to 6000 ************");
	
		level.player allowuse(true);
		level.ender delete();
		guys = getentarray("intro_group","groupname");
		for (i=0;i<guys.size;i++)
		{
			guys[i] delete();
		}
	}
	
	if (getcvar("start") == "plane_start")
	{
		wait 3;		
		level.moody unlink();
		//vehiclenode = getvehiclenode("jesse186","targetname");
		node1 = getnode("moody_popsmoke6","targetname");
		node2 = getnode("moody_popsmoke7","targetname");
		org = getent("mortar_foxhole2","targetname");
		level.moody teleport(node1.origin,(0,0,0));
		
		println("moody teleported");
		wait 0.25;
								// Debug stuff
		level.player setorigin((-619,-6909,124),(0,0,0));  		// Debug stuff
		wait 2;
		
		
		node = getnode("moody_popsmoke6", "targetname");
		level.moody setgoalnode (node);
		level.moody waittill("goal");
	
		level.moody thread anim_single_solo(level.moody,"moody_throw");

		smoketarget = getent("orange_smoke","targetname");
		smokeorigin = getent (smoketarget.target,"targetname");	
		wait 4;
		maps\_fx_gmi::OneShotFx("orange_smoke", smoketarget.origin, 0.1,smokeorigin.origin);
	
		node = getnode("moody_popsmoke7", "targetname");
		level.moody setgoalnode (node);
		level notify ("planetanks go");
		wait 4;
		level notify ("flyby go");
		level.moody waittill("goal");
	
		wait 3;
		iprintlnbold(&"GMI_BASTOGNE1_TEMP_SLOW");
		//level notify("objective_6_complete");					// FIX
		//level.moody thread animscripts\shared::lookatentity(level.player, 10000000, "casual");
		wait 5;
	
		//level.moody thread anim_single_solo(level.moody,"moody_rightflank");			// Riley! On me... Germans breaking...
		wait 2;
		level notify("moody to ridge");
		//setCullFog (0, 6000, .68, .73, .85, 8 );				// Back to old cull fog
		//level.moody thread animscripts\shared::lookatstop();
	
		node = getnode("moody_popsmoke8", "targetname");
		level.moody setgoalnode (node);
		level.moody waittill("goal");
	
		node = getnode("moody_popsmoke1", "targetname");
		level.moody setgoalnode (node);
		level.moody waittill("goal");
	}
	if (getcvar("shermans") == "go")
	{
		wait 15;
			level notify ("final tanks move out");
	}

}

//
//
//

/*anim_tester()
{
	
	test1 = getent ("test1", "targetname");
	test2 = getent ("test2", "targetname");
	test3 = getent ("test3", "targetname");
	test4 = getent ("test4", "targetname");
	
	test1.animname = "test1";
	test2.animname = "test2";
	test3.animname = "test3";
	test4.animname = "test4";
	
	//guy2 animscripts\shared::putGunInHand ("none");
	test1 thread anim_loop_solo(test1, "test1", undefined, "o2 stop anim");
	test2 thread anim_loop_solo(test2, "test2", undefined, "o2 stop anim");
	test3 thread anim_loop_solo(test3, "test3", undefined, "o2 stop anim");
	test4 thread anim_loop_solo(test4, "test4", undefined, "o2 stop anim");
	
}*/

// 
// Adds objectives.
//

objectives_add()
{
	getent ("in_barn","targetname") waittill ("trigger");
	the_30cal = getent("the_30cal","targetname");
	bazooka_1 = getent("bazooka_1","targetname");
	bazooka_1.org = bazooka_1.origin;
	bazooka_2 = getent("bazooka_2","targetname");
	bazooka_2.org = bazooka_2.origin;
	bazooka_3 = getent("bazooka_3","targetname");
	bazooka_3.org = bazooka_3.origin;
	foxhole_loc = getent("mortar_foxhole2","targetname");
	foxhole_killmore_loc = getent("mortar_foxhole3","targetname");
	mg42s = getent("mg42_spawner_obj1","targetname");
	lastnode = getnode("fh2_8","targetname");
	
	// Get the 30 Cal
	//objective_add(3, "active", &"GMI_BASTOGNE1_OBJECTIVE_3", (the_30cal.origin));
	//objective_current(3);
	//level waittill("objective_3_complete");	
	//objective_state(3,"done");

	// get to the fox hole
	objective_add(3, "active", &"GMI_BASTOGNE1_OBJECTIVE_3", (272,-7194,206));
	objective_current(3);
	level waittill("objective_3_complete");	
	objective_state(3,"done");
	
	// Defend incoming attack. Basically, stay alive.
	objective_add(4, "active", &"GMI_BASTOGNE1_OBJECTIVE_4", (272,-7194,206));
	objective_current(4);
	level waittill("objective_4_complete");	
	objective_state(4,"done");
	
	// Defend incoming attack. Basically, stay alive.
	objective_add(5, "active", &"GMI_BASTOGNE1_OBJECTIVE_5", (foxhole_killmore_loc.origin));
	objective_current(5);
	level waittill("objective_5_complete");	
	objective_state(5,"done");
	
	// KILLROY KILLROY killroy... ungh
	objective_add(5, "active", &"GMI_BASTOGNE1_OBJECTIVE_5A", (foxhole_killmore_loc.origin));
	objective_current(5);
	level waittill("objective_5a_complete");	
	objective_state(5,"done");
	
	// Kill Mg42s
	objective_add(6, "active", &"GMI_BASTOGNE1_OBJECTIVE_6_1", (foxhole_loc.origin));
	objective_current(6);
	level waittill("objective_6_complete");	
	objective_state(6,"done");
		
	// Conver moody dummy objective
	objective_add(7, "active", &"GMI_BASTOGNE1_OBJECTIVE_7A", (foxhole_loc.origin));
	objective_current(7);
	
	// Follow Moody to hill top.
	level waittill("moody to ridge");	
	//objective_add(7, "active", &"GMI_BASTOGNE1_OBJECTIVE_7", (2920,-7898,460));
	objective_position(7, (2920,-7898,460));
	objective_string(7, &"GMI_BASTOGNE1_OBJECTIVE_7");
	level waittill("objective_7_complete");	
	objective_state(7,"done");

	//Go to foxhole 1
	//objective_add(8, "active", &"GMI_BASTOGNE1_OBJECTIVE_8", (bazooka_1.org));
	//objective_current(8);
	//level waittill("objective_tank_complete");	
	//objective_state(8,"done");
	
	//Go to foxhole 2
	//objective_add(9, "active", &"GMI_BASTOGNE1_OBJECTIVE_9", (bazooka_2.org));
	//objective_current(9);
	//level waittill("objective_tank_complete");	
	//objective_state(9,"done");
	
	//Go to foxhole 3
	//objective_add(10, "active", &"GMI_BASTOGNE1_OBJECTIVE_10", (bazooka_3.org));
	//objective_current(10);
	//level waittill("objective_tank_complete");	
	//objective_state(10,"done");
	
	level thread tank_death_obj_controller();
	
	level waittill ("all panzers dead now");
	objective_state(8,"done");
	
	// Defend From tanks. Should be last objective.
	objective_add(9, "active", &"GMI_BASTOGNE1_OBJECTIVE_11", (lastnode.origin));
	objective_current(9);
	level waittill("objective_11_complete");	
	objective_state(9,"done");
}

tank_death_obj_controller()
{
	bazooka_1 = getent("bazooka_1","targetname");
	bazooka_1.org = bazooka_1.origin;
	bazooka_2 = getent("bazooka_2","targetname");
	bazooka_2.org = bazooka_2.origin;
	bazooka_3 = getent("bazooka_3","targetname");
	bazooka_3.org = bazooka_3.origin;
	
	//Go to foxhole 1
	objective_add(8, "active", &"GMI_BASTOGNE1_OBJECTIVE_8", (bazooka_1.org));
	objective_current(8);
	//level waittill("objective_tank_complete");	
	//objective_state(8,"done");
	
	level waittill("objective_tank_complete");
	objective_string(8, &"GMI_BASTOGNE1_OBJECTIVE_9");
	level.moody thread anim_single_solo(level.moody,"moody_another_panzer");
	if (level.flags["endtankalive1"] == 0)
	{
		objective_position(8, bazooka_2.org);
		level waittill("objective_tank_complete");
		objective_string(8, &"GMI_BASTOGNE1_OBJECTIVE_10");
		if (level.flags["endtankalive2"] == 0)
		{
			objective_position(8, bazooka_3.org);
			level waittill("objective_tank_complete");
			level notify ("all panzers dead now");
		}
		else if (level.flags["endtankalive3"] == 0)
		{
			level waittill("objective_tank_complete");
			level notify ("all panzers dead now");
		}
	}
	else if (level.flags["endtankalive2"] == 0)
	{
		level waittill("objective_tank_complete");
		objective_string(8, &"GMI_BASTOGNE1_OBJECTIVE_10");
		if (level.flags["endtankalive1"] == 0)
		{
			objective_position(8, bazooka_3.org);
			level waittill("objective_tank_complete");
			level notify ("all panzers dead now");
		}
		else if (level.flags["endtankalive3"] == 0)
		{
			level waittill("objective_tank_complete");
			level notify ("all panzers dead now");
		}
	}
	else if (level.flags["endtankalive3"] == 0)
	{
		level waittill("objective_tank_complete");
		objective_string(8, &"GMI_BASTOGNE1_OBJECTIVE_10");
		if (level.flags["endtankalive1"] == 0)
		{
			objective_position(8, bazooka_2.org);
			level waittill("objective_tank_complete");
			level notify ("all panzers dead now");
		}
		else if (level.flags["endtankalive2"] == 0)
		{
			level waittill("objective_tank_complete");
			level notify ("all panzers dead now");
		}
	}
}

anderson_Star_Tracker()
{
	level endon("objective_3_complete");

	while(1)
	{
		objective_position(3, self.origin);
		wait 0.05;
	}
}

moody_Star_Tracker(num)
{
	level endon("moody follow complete");

	while(1)
	{
		objective_position(num, self.origin);
		wait 0.05;
	}
}



//
// Logic for the 30 cal. Once the weapon is picked up, the level will continue.
//

/*thirtycal_check()
{
	
	while (1)
	{
		thirtycal = getentarray ("weapon_mg30cal", "classname");
		if (thirtycal.size < level.starting_thirtycal.size)
			break;
		wait 2;
		
	}
	
	level notify("30calget");
	level notify("objective_3_complete");
}*/

//
// Gets triggers which will give max ammo
//
ammo_max_setup()
{
	ammo = getentarray ("ammo","targetname");
	for (i=0;i<ammo.size;i++)
	{
		ammo[i] thread ammo_max_think();
	}
}

//
// Gives the max ammo, deletes trigger and script model
//
ammo_max_think()
{
	self waittill ("trigger");
	can = getent(self.target,"targetname");
	level.player giveMaxAmmo("mg30cal"); 
	can delete();
	self delete();	
}

//
// Hint for picking up weapons. FIX: Currently states UNBOUND which is inaccurate.
//

hint_pickup_weapons()
{
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_PICKUPWEAPONKEY", getKeyBinding("+activate"));
}


//
// Get all the goodies. Wait until 30cal is taken. After, give speech and goto target.
//

anderson_think()
{	
	self thread maps\_utility_gmi::magic_bullet_shield();
	self.dontavoidplayer = true;
	self.goalradius = 100;
	self.targetname = "anderson_guy";
	self.animname = "anderson";
	self.accuracy = .3;
	self thread friendly_damage_penalty();
	
	//self thread animscripts\shared::lookatentity(level.player, 10000000, "casual");
	self thread anderson_comeon_loop();
	self thread anderson_star_tracker();
	self thread foxhole_near_accuracy_debuff();
	
	getent ("anderson_moveout","targetname") waittill ("trigger");
	//level waittill ("30calget");
	level.flags["anderson_prod"] = false;
	
	while (level.flags["moody_speech_over"] == false)
	{
		wait 0.05;
	}

	//iprintlnbold("You ready Riley? Let's go! The krauts ain't gonna wait on you.");
	level notify("anderson on the move");
	
	self setgoalentity (level.player);
	
	self.dontavoidplayer = false;
	self.pacifist = true;
	
	getent ("anderson_1","targetname") waittill ("trigger");
	node = getnode("jesse41", "targetname");
	level.player setfriendlychain (node);
	level notify ("anderson 1");	
	getent ("anderson_2","targetname") waittill ("trigger");
	node = getnode("jesse43", "targetname");
	level.player setfriendlychain (node);
	level notify ("anderson 2");
	getent ("anderson_3","targetname") waittill ("trigger");
	node = getnode("jesse10", "targetname");
	level.player setfriendlychain (node);
	level notify ("anderson 3");
	getent ("anderson_4","targetname") waittill ("trigger");
	node = getnode("jesse40", "targetname");
	level.player setfriendlychain (node);
	level notify ("anderson 4");
	getent ("anderson_5","targetname") waittill ("trigger");
	node = getnode("jesse38", "targetname");
	level.player setfriendlychain (node);
	level notify ("anderson 5");
	level notify ("1: drone 2 go");
	
	getent ("start_battle1","targetname") waittill ("trigger");
	wait 3;
	self.pacifist = false;
}

anderson_prod()
{
	while (level.flags["anderson_prod"] == true)
	{
		level.anderson thread anim_single_solo(level.anderson,"anderson_riley");
		wait 7;
	}
}

//
//
//

anderson_comeon_loop()
{
	self thread anderson_comeone_loop_break();
	while (level.flags["moody_speech_over"] == false)
	{
		index = randomint(2);
		println("^1index= "+index);
		if (index == 0)
			self thread anim_single_solo(self,"comeon_c");
		if (index == 1)
			self thread anim_single_solo(self,"comeon_d");
		self waittillmatch ("single anim","end");
		
		if (level.flags["moody_speech_over"] == true)
			break;
		
		self thread anim_loop_solo(self, "comeon_idle", "TAG_ORIGIN", "stop idle", undefined);
		wait randomintrange(3,8);
		self notify ("stop idle");
	}
}

anderson_comeone_loop_break()
{
	while (level.flags["moody_speech_over"] == false)
	{
		wait 0.25;
	}
	self notify ("stop idle");
}

//
// Moody goes up and down the line...
//
#using_animtree("generic_human");
moody_think()
{
	
	numMoodyNodes = 14;
	
	self.dontavoidplayer = true;
	self.pacifist = true;
	self.pacifistwait = 0;
	self.playpainanim = false;
	self.ignoreme = true;
	//self.bravery = 50000000;
	self.threatbias = -5000;
	self.suppressionwait = 0.5;
	self allowedStances ("stand", "crouch");
	self.maxsightdistsqrd = 0;
	self.targetname = "moodytemp_guy";
	self.animname = "moody";
	
	self thread maps\_utility_gmi::magic_bullet_shield();
	
	getent ("in_barn","targetname") waittill ("trigger");
	wait 5;
	
	self.anim_movement = "stop";
	//self thread anim_single_solo(self,"moody_report");
	//wait 8.8;
	//self thread anim_single_solo(self,"moody_30cal");
	//level thread anderson_prod();
	//wait 1.5;
	//level.flags["moody_speech_over"] = true;

	getent ("foxhole3_trig","targetname") waittill ("trigger");
	
	level notify ("stop moody idle barn anims");
	
	self.goalradius = 10;
	
	level.moody.hasweapon = true;
	level.moody animscripts\shared::putGunInHand ("right");
	level.moody.run_noncombatanim = level.moody.oldrun_noncombatanim;
	level.moody.standanim = level.moody.oldstandanim;
	
	for (i=0; i<numMoodyNodes+1; i++)
	{
		self.goalradius = 10;
		self.threatbias = -5000;
		self.maxsightdistsqrd = 0;
		self.pacifist = true;
		self.ignoreme = true;
		
		node = getnode("moody_" + i, "targetname");	
		self setgoalnode (node);
		self waittill("goal");
	
		rand = randomint(2);
	
		if ((i == 12) || (i == 13) || (i == 14) || i == 15)
		{	//iprintlnbold(moody_dialog());
			if (rand == 0)
			{
				self thread anim_single_solo(self,"moody_keepfiring");
			}
			self allowedstances("crouch");
			//level waittillmatch("single anim","end");
			wait 4;
			self allowedstances("crouch","stand");
		}

	}
	
	index = 11;
	indexDirection = 1;
	
	while (1)
	{
		/*while (indexNew == indexOld)
		{
			indexNew = randomIntRange(12, 16);
			node = getnode("moody_"+ indexNew, "targetname");
			self setgoalnode (node);
			self waittill("goal");
		}*/
		
		//iprintlnbold(moody_dialog());
		
		if (index == 11)
		{
			indexDirection = 1;
		}
		else if (index == 15)
		{
			indexDirection = 0;
		}
		
		if (indexDirection == 1)
		{
			index++;
		}
		else if (indexDirection == 0)
		{
			index--;
		}
		
		println("^1MOODY NODE NUM: "+index);
		
		node = getnode("moody_"+ index, "targetname");
		self setgoalnode (node);
		self waittill("goal");
		
		rand = randomint(2);
		
		if (rand == 0)
		{
			self thread anim_single_solo(self,"moody_keepfiring");
		}
		wait 5;
		
		if (level.flags["kill_more_guys_event"] == true)
		{
			break;
		}
	}

	node = getnode("moody_15", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	
	level thread mg42_killer();
	
	self thread moody_kill_more_guys();
	level waittill ("kill more guys over");

	level thread mg42_killer();
	
	level notify ("mg42 obj spawn in");
	
	self thread moody_smoke_pop();							// Goes to smoke pop event
	level waittill ("smoke over");
	
	//level notify ("moody set up");
	//iprintlnbold("Riley! On me! Germans breaking through the right flank!");
	//self thread anim_single_solo(self,"moody_rightflank");
	
	self thread moody_putup_fight();
	level waittill ("moody fight over");
	level notify ("final tanks move out");
	
	node = getnode("moody_final", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	
	self.pacifist = false;
	
	level notify("objective_7_complete");
	level notify("moody follow complete");
	
	//while (level.flags["moody_punish_off"] == false)
	//{
	//	wait 0.25;	
	//}
	
	wait 13;
	
	//iprintlnbold("We have to do something about those tanks or we are all dead!");
	self thread anim_single_solo(self,"moody_tanks");
	wait 3;
	//iprintlnbold("Riley! Grab that bazooka! Take out those panzers!");
	self thread anim_single_solo(self,"moody_bazooka");
	
	node = getnode("moody_final_move1", "targetname");
	self setgoalnode (node);
	level waittill ("objective_8_complete");
	node = getnode("moody_final_move2", "targetname");
	self setgoalnode (node);
	level waittill ("objective_9_complete");
	node = getnode("moody_final_move3", "targetname");
	self setgoalnode (node);
}

moody_collapse()
{
	getent("moody_collapse","targetname") waittill ("trigger");
	level.moody thread anim_single_solo(level.moody,"moody_line_collapsed");
	level notify ("moody collapse trigger");
}

//
//
//
moody_end_trig_check()
{
	getent ("moody_punish_off","targetname") waittill ("trigger");
	level.flags["moody_punish_off"] = true;
	level notify ("end battle 1 punishers");
}

//
//
//
moody_wait_for_player()
{
	level endon ("moody was seen");
	lookat = getent("moody_lookat","targetname");
	lookat.org = lookat.origin;
	
	lookat.origin = self.origin;
	
	lookat waittill ("trigger");
	
	level notify ("moody was seen");
	lookat.origin = lookat.org;
}

moody_wait_for_player2()
{
	level endon ("moody was seen");
	getent("moody_move_your_ass","targetname") waittill ("trigger");
	level notify ("moody was seen");
}

//
//
//
moody_repeat_lines1(line_string)
{
	level endon ("moody was seen");
	while (1)
	{
		self thread anim_single_solo(self,line_string);
		self animscripts\point::point(180, true, undefined, undefined);
		wait 8;
	}
}


//
//
//
moody_kill_more_guys()
{
	level notify("objective_4_complete");
	self thread moody_Star_Tracker(5);
	
	//iprintlnbold(&"GMI_BASTOGNE1_TEMP_LEFT");
	//self thread anim_single_solo(self,"moody_withme");
	
	self thread moody_repeat_lines1("moody_withme");
	self thread moody_wait_for_player();
	self thread moody_wait_for_player2();
	
	level waittill ("moody was seen");
	wait 1;
		
	node = getnode("moody_14", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	
	node = getnode("moody_12", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	
	//self animscripts\point::point(90, true, undefined, undefined);
	//wait 2;
	
	moody_ang = spawn("script_origin", self.origin);
	moody_ang.angles = (0,90,0);
	
	//self linkto(moody_ang);
	
	self thread anim_single_solo(self, "moody_30cal_move", undefined, moody_ang);
	
	//self thread anim_single_solo(self,"moody_30cal_move");
	
	wait 1;
	
	self unlink();
	
	moody_ang delete();
	
	level notify("moody follow complete");
	foxhole_killmore_loc = getent("mortar_foxhole3","targetname");
	objective_position(5, foxhole_killmore_loc.origin);
	
	//iprintlnbold(&"GMI_BASTOGNE1_TEMP_30CAL_HOLD");
	//self thread anim_single_solo(self,"moody_withme");
	
	wait 4;
	
	//level thread own_chickenshit_player_think();
	
	level notify ("moody back in action");
	
	index = 11;
	indexDirection = 1;
	
	while (1)
	{
		if (index == 11)
		{
			indexDirection = 1;
		}
		else if (index == 15)
		{
			indexDirection = 0;
		}
		
		if (indexDirection == 1)
		{
			index++;
		}
		else if (indexDirection == 0)
		{
			index--;
		}
		

		println("^1MOODY NODE NUM: "+index);
		node = getnode("moody_"+ index, "targetname");
		self setgoalnode (node);
		self waittill("goal");
		
		rand = randomint (2);
		
		if (rand == 0)
		{
			self thread anim_single_solo(self,"moody_keepfiring");
		}
		
		wait 5;
		
		if (level.flags["smoke_pop_event"] == true)
		{
			break;
		}
	}
	
	level notify ("kill more guys over");
	level notify ("end chickenshit");
}

//
// Moody event where he goes to a foxhole, then goes to pop smoke for planes.
//
moody_smoke_pop()
{	
	//redshirt1 = getent("foxholeguy5","targetname");
	redshirt2 = getent("foxholeguy6","targetname");
	
	//redshirt1.health = 10;
	redshirt2.health = 1;
	
	wait 0.5;
	
	mortar = getent ("mortar_foxhole2","targetname");
	mortar thread maps\_mortar_gmi::activate_mortar (100, 1000, 200, .3, 1, 1500);
	if (isalive(redshirt2))
	{
		radiusDamage(redshirt2.origin, 10, 10, 10);
	}
	
	node = getnode("moody_12", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	
	level notify("objective_5_complete");
	
	level thread objective5a_checker();
	
	self thread moody_Star_Tracker(5);
	//iprintlnbold(&"GMI_BASTOGNE1_TEMP_COVER_RIGHT");
	self thread anim_single_solo(self,"moody_changin");
	
	wait 2;
	
	node = getnode("moody_popsmoke1", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	
	level notify ("moody to sniper hole");
	level.flags["sniper_begin"] = true;
	
	player_distance = 1000;
	while(player_distance > 280)
	{
		moody_origin = self.origin;
		
		player_distance = distance ((level.player getorigin()), moody_origin);
		
		wait 0.2;
	}
	
	level notify("moody follow complete");
	foxhole2_loc = getent("mortar_foxhole2","targetname");
	objective_position(5, foxhole2_loc.origin);
	objective_position(6, foxhole2_loc.origin);
	
	//iprintlnbold(&"GMI_BASTOGNE1_TEMP_SNIPER");
	if (level.flags["snipers_dead"] == false)
	{
			self thread anim_single_solo(self,"moody_pop_smoke");
	}
	
	self thread animscripts\shared::lookatentity(level.player, 10000000, "casual");
	level notify ("moody moving in");
	wait 3;
	self thread animscripts\shared::lookatstop();
	
	self allowedstances("crouch", "stand");
	
	node = getnode("moody_popsmoke2", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	wait 1;
	
	level notify ("moody moving in 2");
	
	node = getnode("moody_popsmoke3", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	wait 2;
	
	//node = getnode("moody_popsmoke4", "targetname");
	//self setgoalnode (node);
	//self waittill("goal");
	
	while(level.flags["snipers_dead"] == false)
	{
		wait 0.25;
	}
	//level notify("objective_6_complete");
	level notify ("stop moody attackers");
	level notify ("3: drone 1 go");
	
	self thread moody_remove_threats2();
	self.pacifist = false;
	self.bravery = 500000;
	
	node = getnode("moody_popsmoke5", "targetname");
	self setgoalnode (node);
	
	self waittill("goal");
	//wait 4;
	
	self thread moody_remove_threats();
	
	node = getnode("moody_popsmoke6", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	
	self thread anim_single_solo(self,"moody_throw");

	smoketarget = getent("orange_smoke","targetname");
	smokeorigin = getent (smoketarget.target,"targetname");	
	wait 2;
	maps\_fx_gmi::OneShotFx("orange_smoke", smoketarget.origin, 0.1,smokeorigin.origin);
	
	node = getnode("moody_popsmoke7", "targetname");
	self setgoalnode (node);
	level notify ("planetanks go");
	wait 4;
	level notify ("flyby go");
	self waittill("goal");
	
	//self thread dont_aim();
	
	self allowedstances("crouch");
	
	moody_ang = spawn("script_origin", self.origin);
	
	//self linkto (moody_ang);
	//moody_ang.angles = (0,90,0);
	
	//wait 3;
	
	
	//iprintlnbold(&"GMI_BASTOGNE1_TEMP_SLOW");
	//level notify("objective_6_complete");					// FIX
	//self thread animscripts\shared::lookatentity(level.player, 10000000, "casual");
	wait 14;
	
	//self thread anim_single_solo(self,"moody_slow_down");
	moody_ang.angles = (0,270,0);
	self thread anim_single_solo(self, "moody_slow_down", undefined, moody_ang);
	wait 3;
	self thread anim_single_solo(self, "moody_rightflank", undefined, moody_ang);
	//self thread anim_single_solo(self,"moody_rightflank");			// Riley! On me... Germans breaking...
	wait 2;
	
	//self unlink();
	
	self allowedstances("crouch","stand");
	
	level notify("moody to ridge");
	self thread moody_star_tracker(7);
	//self thread animscripts\shared::lookatstop();
	
	
	node = getnode("moody_popsmoke8", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	
	node = getnode("moody_popsmoke1", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	
	node = getnode("moody_12_2", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	
	while (level.flags["moody_to_ridge"] == false)
	{
		wait 0.25;
	}
	
	/*node = getnode("moody_13", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	
	node = getnode("moody_to_ridge1", "targetname");
	self setgoalnode (node);
	self waittill("goal");
	
	node = getnode("moody_to_ridge2", "targetname");
	self setgoalnode (node);
	self waittill("goal");*/
	
 	level notify ("smoke over");
	level notify ("3: drone 3 go");
}

objective5a_checker()
{
	level endon("objective_5a_complete");
	getent("player_in_foxhole2","targetname") waittill ("trigger");
	level notify("objective_5a_complete");
}

dont_aim()
{
	level endon("moody to ridge");
	while (1)
	{
		self thread animscripts\aim::dontaim();
		wait 0.05;
	}
}
//
//
//
moody_smokeover_go()
{
	moody_trig = getent ("moody_smoke_over","targetname");
	moody_trig maps\_utility_gmi::triggerOff();
	
	getent ("player_in_foxhole2","targetname") waittill ("trigger");
	
	moody_trig maps\_utility_gmi::triggerOn();
	moody_trig waittill ("trigger");
	level.flags["moody_to_ridge"] = true;
}

//
//
//
moody_putup_fight()
{
	level endon ("moody fight over");
	node = getnode("moody_putup1","targetname");
	self setgoalnode (node);
	self.accuracy = 0.1;
	level thread path_harder();
	
	while (level.putup_count < 2)
	{
		wait 0.05;
	}
	level notify ("moody fight over");
}

path_harder()
{
	level endon ("moody fight over");
	getent ("path_harder","targetname") waittill ("trigger");
	level.flags["no_more_path_spawn"] = true;
	
	guys = getentarray("path2ers","groupname");
	for (i=0;i<guys.size;i++)
	{
		if (isalive(guys[i]))
		{
			guys[i].accuracy = 1;
			guys[i].favoriteenemy = level.player;
		}
	}
	level notify ("moody fight over");
	
}

//
//
//
moody_remove_threats()
{
	aSquad1 = maps\_squad_manager::alive_array("moody_attack1");
	aSquad2 = maps\_squad_manager::alive_array("moody_attack2");
	
	for (i=0;i<aSquad1.size;i++)
	{
		if (isalive(aSquad1[i]))
		{
			aSquad1[i] playsound ("weap_m1garand_fire");
			aSquad1[i] dodamage(aSquad1[i].health + 50, (0,0,0));
		}
		wait randomfloatrange(0.5,2.0);
	}
	
	for (i=0;i<aSquad2.size;i++)
	{
		if (isalive(aSquad2[i]))
		{
			aSquad2[i] playsound ("weap_bar_fire");
			aSquad2[i] dodamage(aSquad2[i].health + 50, (0,0,0));
		}
		wait randomfloatrange(0.5,2.0);
	}
}

moody_remove_threats2()
{
	level endon ("moody to ridge");
	
	max_distance = 250;
	ai = getaiarray("axis");
	while (1)
	{
		for (i=0;i<ai.size;i++)
		{
			if (isalive(ai[i]))
			{
				if (distance (self getorigin(), ai[i] getorigin()) <= max_distance)
				{
					ai[i] playsound ("weap_bar_fire");
					ai[i] dodamage(ai[i].health + 50, (0,0,0));
				}		
			}
		}
		wait 0.25;
	}
		
}

//
//
//

wall_flower_init()
{		
	wf1_spawn = getent("wall_lean1","targetname");
	wf2_spawn = getent("wall_lean2","targetname");
	
	wf1 = wf1_spawn stalingradspawn();
	wf1 waittill ("finished spawning");
	wf2 = wf2_spawn stalingradspawn();
	wf2 waittill ("finished spawning");
	
	wf1.script_noteworthy = wf1_spawn.script_noteworthy;
	wf2.script_noteworthy = wf2_spawn.script_noteworthy;
	
	wf1 thread wall_flower_1();
	wf2 thread wall_flower_2();
	
	wf1 thread friendly_damage_penalty();
	wf2 thread friendly_damage_penalty();
}

//
//
//
wall_flower_1()
{
	self.animname = "wallflower_1";
	
	self thread mg30cal_guys_moveout(1);
	
	while(level.flags["30cal_moveout"] == false)
	{
		index = randomint(2);
		if (index == 0)
			flinch = "stand_flinchb";
		else
			flinch = "stand_flincha";
			
		index2 = randomint(5);
		
		if (index2 == 0)
		{
			self thread anim_single_solo(self, "stand_scratch");
			self waittillmatch ("single anim","end");
		}
		
		if (level.flags["30cal_moveout"] == true)			// Break here
			break;
		
		self thread anim_loop_solo(self, "stand_idle", "TAG_ORIGIN", "stop idle", undefined);
		level waittill ("dust falling");
		
		if (level.flags["30cal_moveout"] == true)			// Break here
			break;
		
		wait randomfloat (0.4);
		self notify("stop idle");
		self thread anim_single_solo(self, flinch);
		
		if (level.flags["30cal_moveout"] == true)			// Break here
			break;
		
		level waittill ("dust over");
		
		wait 0.1;
	}
	
}

//
//
//
wall_flower_2()
{
	self.animname = "wallflower_2";
	
	self thread mg30cal_guys_moveout(2);
	
	while(1)
	{
		index = randomint(2);
		if (index == 0)
			flinch = "wall_flinchb";
		else
			flinch = "wall_flincha";
			
		index2 = randomint(7);
		
		if (index2 == 0)
		{
			self thread anim_single_solo(self, "wall_dustoff");
			self waittillmatch ("single anim","end");
		}
		else if (index2 == 1)
		{
			self thread anim_single_solo(self, "wall_inspect");
			self waittillmatch ("single anim","end");
		}
		
		if (level.flags["30cal_moveout"] == true)			// Break here
			break;
		
		self thread anim_loop_solo(self, "wall_idle", "TAG_ORIGIN", "stop idle", undefined);
		level waittill ("dust falling");
		
		if (level.flags["30cal_moveout"] == true)			// Break here
			break;
		
		wait randomfloat (0.4);
		self notify("stop idle");
		self thread anim_single_solo(self, flinch);
		
		if (level.flags["30cal_moveout"] == true)			// Break here
			break;
		
		level waittill ("dust over");
		wait 0.1;
	}
}

//
//
//

p47_flyby()
{
	level waittill ("flyby go");
	bomb_count = 12;
	path = getvehiclenode("p47_path1","targetname");
	
	p47 = spawnvehicle("xmodel/v_us_air_p47","p471","BF109",(0,0,0),(0,0,0));
	p47.health = 10000000;
	p47.script_noteworthy = "noturrets";
	p47 maps\_p47_gmi::init(bomb_count);
	p47.attachedpath = path;
	p47 attachPath(path);
	p47 startpath();
	p47 playsound("p47_attack");
	p47 thread p47_bombing_think(bomb_count);
	p47 thread health_regen();
	wait 5;
	
	path = getvehiclenode("p47_path2","targetname");
	p47 = spawnvehicle("xmodel/v_us_air_p47","p472","BF109",(0,0,0),(0,0,0));
	p47.health = 10000000;
	p47.script_noteworthy = "noturrets";
	p47 maps\_p47_gmi::init(bomb_count);
	p47.attachedpath = path;
	p47 attachPath(path);
	p47 startpath();
	p47 playsound("p47_attack");
	p47 thread p47_bombing_think(bomb_count);
	p47 thread health_regen();
	wait 1;
	
	path = getvehiclenode("p47_path3","targetname");
	p47 = spawnvehicle("xmodel/v_us_air_p47","p473","BF109",(0,0,0),(0,0,0));
	p47.health = 10000000;
	p47.script_noteworthy = "noturrets";
	p47 maps\_p47_gmi::init(bomb_count);
	p47.attachedpath = path;
	p47 attachPath(path);
	p47 startpath();
	p47 playsound("p47_attack");
	p47 thread p47_bombing_think(bomb_count);
	p47 thread health_regen();
}

//
//
//
health_regen()  
{  
	level endon("start_panzers");  
  
	my_health = self.health;  
  
    	while(1)  
	{       
		self waittill("damage");  
		self.health = my_health;  
		wait 0.25;  
	}  
}

//
// 
//

p47_bombing_think(amount)
{
	wait 2;
	self thread maps\_p47_gmi::drop_bombs(amount, randomfloatrange(0.2,0.5), 0, 500, 3000, 3000);
}
//
// Initialize the 50 cal guy on the ridge.
//

fiftycal_guy_setup()
{
	wait 5;
	level endon("end_gamma");
	
	soldiers = getentarray("mg_42guy", "targetname");
	turret = getent("fifty_cal", "targetname");
	
	for (i=0;i<soldiers.size;i++)
	{
			guy = soldiers[i] stalingradspawn();
			wait 0.25;
			node = getnode(soldiers[i].target, "targetname");
			guy setgoalnode(node);
			guy.threatbias = 1000;
			guy.targetname = "50cent";
			guy thread maps\_utility::magic_bullet_shield();
	}
	while (1)
	{
		guy useturret(turret);
		wait 1;
	}
}

//
// 30 cal guy set up
//
mg30cal_guy_setup()
{
	self endon("death");
	self.health = 1000000;
	mg30cal = getent("30cal_deleteable","targetname");
	
	while(1)
	{
		self useturret(mg30cal);
		wait 0.25;
	}
}

//
// Initialize the soldiers in the foxholes (near barn).
//


foxholeNearSoldier_setup()
{
	soldiers = getentarray("foxhole_near", "targetname");
	
	getent ("foxhole3_trig","targetname") waittill ("trigger");
	
	for (i=0;i<soldiers.size;i++)
	{
			guy = soldiers[i] stalingradspawn();
			guy waittill ("finished spawning");
			guy.script_noteworthy = "remove_me_foxhole_near";
			
			if (isdefined(soldiers[i].target))
			{
				node = getnode(soldiers[i].target, "targetname");
			}
			//guy setgoalnode(node);
			//guy.threatbias = 1000;
			
			if(isdefined(soldiers[i].script_noteworthy) && soldiers[i].script_noteworthy == "pointer")
			{
				guy.allowdeath = true;
				guy.animname = "foxhole_pointer";
				guy thread anim_loop_solo(guy, "pointing", "TAG_ORIGIN", "stop pointing", undefined);
				guy.targetname = "foxhole_pointer";
				guy.health = 100000;
				
			}
			
			if(isdefined(soldiers[i].script_noteworthy) && soldiers[i].script_noteworthy == "pointer_friend")
			{
				guy.allowdeath = true;
				guy.animname = "foxhole_pointer_friend";
				guy.targetname = "foxhole_pointer_friend";
				guy.health = 100000;
				
			}
			
			if(isdefined(soldiers[i].script_noteworthy) && soldiers[i].script_noteworthy == "5")
			{
				guy.health = 1000000;
				guy.targetname = "foxholeguy5";
				
				guy thread foxhole_init();
				guy thread chatter_general(guy.origin,25,"us",guy, "chatter go 2");
				guy thread foxhole_near_accuracy_debuff();
			}
			
			if(isdefined(soldiers[i].script_noteworthy) && soldiers[i].script_noteworthy == "6")
			{
				guy.health = 1000000;
				guy.targetname = "foxholeguy6";
				
				guy thread foxhole_init();
				guy thread chatter_general(guy.origin,25,"us",guy, "chatter go 2");
			}
			
						
			if(isdefined(soldiers[i].script_noteworthy) && soldiers[i].script_noteworthy == "7")
			{
				guy.health = 1000000;
				guy.targetname = "foxholeguy7";
				
				guy thread foxhole_init();
				guy thread chatter_general(guy.origin,25,"us",guy, "chatter go 2");
				guy thread foxhole_near_accuracy_debuff();
			}
			
			if(isdefined(soldiers[i].script_noteworthy) && soldiers[i].script_noteworthy == "8")
			{
				guy.health = 1000000;
				guy.targetname = "foxholeguy8";
				
				guy thread foxhole_init();
				guy thread chatter_general(guy.origin,25,"us",guy, "chatter go 2");
				guy thread mg30cal_guy_setup();
			}
				
			else
			{
				//guy thread maps\_utility::magic_bullet_shield();
				
			}	
	}
	
	getent ("start_panzers","targetname") waittill ("trigger");
	
	soldiers = getentarray("remove_me_foxhole_near", "script_noteworthy");
	
	for (i=0;i<soldiers.size;i++)
	{
		guy = soldiers[i];
		if (isalive(guy))
		{
			guy delete();
		}
	}
}

//
// Initialize the soldiers in the foxholes (far from barn).
//

foxholeSoldier_setup()
{
	soldiers = getentarray("foxhole", "targetname");
	
	for (i=0;i<soldiers.size;i++)
	{
			guy = soldiers[i] stalingradSpawn();
			guy waittill ("finished spawning");
			guy.script_noteworthy = "remove_me_foxhole";
			
			if (isdefined(soldiers[i].target))
			{
				node = getnode(soldiers[i].target, "targetname");
			}
			//guy setgoalnode(node);
			//guy.threatbias = 1000;
			//guy.targetname = "foxholer";
				
			
			if(isdefined(soldiers[i].script_noteworthy) && soldiers[i].script_noteworthy == "1")
			{
				//guy teleport((guy.origin + (0,16,-20)),(guy.angles + (0,180,0)));
				guy.allowdeath = true;
				//guy.animname = "foxhole_cower1";
				//guy thread anim_loop_solo(guy, "cower1", "TAG_ORIGIN", "stop cower1", undefined);
				guy.targetname = "foxholeguy1";
				guy thread foxhole_init();
				guy thread chatter_general(guy.origin,50,"us",guy, "chatter go 1");
			}
			
			if(isdefined(soldiers[i].script_noteworthy) && soldiers[i].script_noteworthy == "2")
			{
				guy.allowdeath = true;
				//guy.animname = "foxhole_cower2";
				//guy thread anim_loop_solo(guy, "cower2", "TAG_ORIGIN", "stop cower2", undefined);
				guy.targetname = "foxholeguy2";
				guy thread foxhole_init();
				guy thread chatter_general(guy.origin,50,"us",guy, "chatter go 1");
			}
			
			if(isdefined(soldiers[i].script_noteworthy) && soldiers[i].script_noteworthy == "3")
			{
				guy.allowdeath = true;
				//guy.animname = "foxhole_cower2";
				//guy thread anim_loop_solo(guy, "cower2", "TAG_ORIGIN", "stop cower2", undefined);
				guy.targetname = "foxholeguy3";
				guy thread foxhole_init();
				guy thread chatter_general(guy.origin,25,"us",guy, "chatter go 2");
				
			}
			
			if(isdefined(soldiers[i].script_noteworthy) && soldiers[i].script_noteworthy == "4")
			{
				guy.allowdeath = true;
				//guy.animname = "foxhole_cower2";
				//guy thread anim_loop_solo(guy, "cower2", "TAG_ORIGIN", "stop cower2", undefined);
				guy.targetname = "foxholeguy4";
				guy thread foxhole_init();
				guy thread chatter_general(guy.origin,25,"us",guy, "chatter go 2");
			}
			
			
			//level thread mg42_Guys_Spawn(); 
			
		/*	else
			{
				guy.threatbias = 1000;
				guy setgoalnode(node);
			}
		*/	
			/*if(isdefined(soldiers[i].script_noteworthy) && soldiers[i].script_noteworthy == "setup30cal")
			{
				guy.allowdeath = true;
				guy.animname = "foxhole_30cal";
				guy thread anim_loop_solo(guy, "setup30cal", "TAG_ORIGIN", "stop 30cal", undefined);
			}*/
	}
	
	
}

//
// Initializes guys in their foxholes based on their 
//

foxhole_init()
{
	
	if (self.targetname == "foxholeguy1")
	{
		getent ("foxhole1_trig","targetname") waittill ("trigger");
		level notify ("chatter go 2");
		 node = getnode("foxhole_node1", "targetname");  
		 self setgoalnode(node);
	}
	if (self.targetname == "foxholeguy2")
	{
		getent ("foxhole1_trig","targetname") waittill ("trigger");
		node = getnode("foxhole_node2", "targetname"); 
		self setgoalnode(node);
	}
	if (self.targetname == "foxholeguy3")
	{
		getent ("foxhole2_trig","targetname") waittill ("trigger");
		 node = getnode("foxhole_node3", "targetname");  
		 self setgoalnode(node);
	}
	if (self.targetname == "foxholeguy4")
	{
		getent ("foxhole2_trig","targetname") waittill ("trigger");
		node = getnode("foxhole_node4", "targetname"); 
		self setgoalnode(node);
	}
	if (self.targetname == "foxholeguy5")
	{
		getent ("foxhole3_trig","targetname") waittill ("trigger");
		node = getnode("foxhole_node5", "targetname"); 
		self setgoalnode(node);
	}
	if (self.targetname == "foxholeguy6")
	{
		getent ("foxhole3_trig","targetname") waittill ("trigger");
		node = getnode("foxhole_node6", "targetname"); 
		self setgoalnode(node);
	}
	if (self.targetname == "foxholeguy7")
	{
		getent ("foxhole3_trig","targetname") waittill ("trigger");
		node = getnode("foxhole_node7", "targetname"); 
		self setgoalnode(node);
	}
	if (self.targetname == "foxholeguy8")
	{
		getent ("foxhole3_trig","targetname") waittill ("trigger");
		node = getnode("foxhole_node8", "targetname"); 
		self setgoalnode(node);
		// MikeD: Fix so the player can't push him off the 30 cal.
		self.dontavoidplayer = true;
	}
	
	
}

//
// Kills any guys left over in foxholes.
//

foxhole_cleanup()
{
	getent ("ai_remover","targetname") waittill ("trigger");
	
	soldiers = getentarray("remove_me_foxhole", "script_noteworthy");
	
	for (i=0;i<soldiers.size;i++)
	{
		guy = soldiers[i];
		if (isalive(guy))
		{
			guy delete();
		}
	}	
	
	trig = getentarray("friendly_mg42", "targetname");
	for (i=0;i<trig.size;i++)
	{
		trigger = trig[i];
		trigger maps\_utility_gmi::triggerOff();
	}
}

//
// Medics in Barn
//

medics_in_barn()
{
	medic_spawn1 = getent("medic1","targetname");
	level.medic1 = medic_spawn1 stalingradspawn();
	level.medic1 waittill("finished spawning");
	level.medic1.playpainanim = false;
	level.medic1.ignoreme = true;
	level.medic1.pacifist = true;
	level.medic1.pacifistwait = 0;
	level.medic1.health = 100000;
	level.medic1.goalradius = 1;
	level.medic1.script_noteworthy = "remove_me_foxhole";
	level.medic1 thread friendly_damage_penalty();
	
	getent ("in_barn","targetname") waittill ("trigger");
	node = getnode("nurse_node","targetname");
	
	wait 2;
	level.medic1 setgoalnode(node);
	level.medic1 waittill ("goal");
	
	level.medic1 animscripts\shared::putGunInHand ("none");
	level.medic1 thread maps\bastogne1_anim::medics_in_barn_anim();
}


//
// Bazooka Guys
//

bazooka_guy()
{
	bazooka_spawn1 = getent("bazooka_guy_1","targetname");
	bazooka_spawn2 = getent("bazooka_guy_2","targetname");
	bazooka_spawn3 = getent("bazooka_guy_3","targetname");
	
	level waittill ("fucked tank 1 spawned");
	wait 8;
	guy = bazooka_spawn2 stalingradspawn();
	guy waittill("finished spawning");
	guy.playpainanim = false;
	guy.ignoreme = true;
	guy.pacifist = true;
	guy.pacifistwait = 0;
	guy.health = 100000;
	guy.bravery = 50000;
	guy.goalradius = 8;
	guy.accuracy = 1.0;
	guy thread bazooka_filler();
	node = getnode("bazooka_blast2","targetname");
	guy setgoalnode (node);
	fire_point = getent("bazooka_target2","targetname");
	guy waittill ("goal");
	
	guy animscripts\combat_gmi::fireattarget(fire_point.origin, 1.5, undefined, undefined, undefined, true);
	
	wait .5;
	guy.health = 1;
	radiusDamage(guy.origin, 10, 10, 10);
	
	//////////
	
	level waittill ("fucked tank 2 spawned");
	wait 7.5;
	guy = bazooka_spawn1 stalingradspawn();
	guy waittill("finished spawning");
	guy.playpainanim = false;
	guy.ignoreme = true;
	guy.pacifist = true;
	guy.pacifistwait = 0;
	guy.health = 100000;
	guy.bravery = 50000;
	guy.goalradius = 8;
	guy.accuracy = 1.0;
	guy thread bazooka_filler();
	node = getnode("bazooka_blast1","targetname");
	guy setgoalnode (node);
	fire_point = getent("bazooka_target1","targetname");
	guy waittill ("goal");
	
	guy animscripts\combat_gmi::fireattarget(fire_point.origin, 1.5, undefined, undefined, undefined, true);
	
	wait .5;
	guy.health = 1;
	radiusDamage(guy.origin, 10, 10, 10);
	
	///////////
	
	level waittill ("swing and a miss");
	wait 30;
	guy = bazooka_spawn3 stalingradspawn();
	guy waittill("finished spawning");
	guy.playpainanim = false;
	guy.ignoreme = true;
	guy.pacifist = true;
	guy.pacifistwait = 0;
	guy.health = 100000;
	guy.bravery = 50000;
	guy.goalradius = 8;
	guy.accuracy = 1.0;
	guy thread bazooka_filler();
	node = getnode("final_allied_node_1","targetname");
	guy setgoalnode (node);
	fire_point = getent("bazooka_target3","targetname");
	guy waittill ("goal");
	
	guy animscripts\combat_gmi::fireattarget(fire_point.origin, 1.5, undefined, undefined, undefined, true);
	
	wait .5;
	guy.health = 1;
	radiusDamage(guy.origin, 10, 10, 10);
	
}
//
// 30 cal guys wake up.
//

/*mg42_Guys_Spawn()  
{  
	spawners = getentarray("mg42_guys","targetname");  
	for(i=0;i<spawners.size;i++)  
	{  
     	
		spawned = spawners[i] stalingradSpawn();  
            	
		if (isdefined(spawned))
		{  
			if(isdefined(spawners[i].script_noteworthy))  
			{  
				spawned thread mg42_guy_think(spawners[i].script_noteworthy);  
			}  
	   	}
	}  
}*/  

//
// I'm mighty tighty whitey and I'm smuggling plums.
//
  
mg30cal_guys_moveout(turret)  
{  
	turret1 = getent ("30cal_1","targetname");
	turret2 = getent ("30cal_2","targetname");
	
	getent ("30cal_goto","targetname") waittill ("trigger");
 	level notify ("chatter go 1");
 	
 	level.flags["30cal_moveout"] = true;
 	
 	self notify ("stop idle");
  
	node = getnode(self.script_noteworthy, "targetname");  
  
  	//self.script_mg42 = node.script_mg42;
  
	self setgoalnode(node); 
	self.goalradius = 8;
	self waittill ("goal");

	self.script_noteworthy = "remove_me_foxhole";
	
	if (turret == 1)
		self useturret(turret1);
	if (turret == 2)
		self useturret(turret2);
}

//
// Initialize / delete the offiers milling about.
//

#using_animtree("generic_human");
officer_setup()
{
	soldier1 = getent("officer1", "targetname");
	soldier2 = getent("officer2", "targetname");
	
	table = getent ("table","targetname");
	
	guy1 = soldier1 stalingradspawn();
	guy1 waittill ("finished spawning");
	guy1 teleport(table.origin,table.angles);
	guy1.targetname = "officer";
	guy1.animname = "officer1";
	guy1.loop = true;
	guy1 animscripts\shared::putGunInHand ("none");
	guy1 thread anim_loop_solo(guy1, "map_read1", "TAG_ORIGIN", "o1 stop anim", table);		
	guy1 thread friendly_damage_penalty();
	
	guy2 = soldier2 stalingradspawn();
	guy2 waittill ("finished spawning");
	guy2 teleport(table.origin,table.angles);
	guy2.targetname = "officer";
	guy2.animname = "officer2";
	guy2.loop = true;
	guy2 animscripts\shared::putGunInHand ("none");
	guy2 thread anim_loop_solo(guy2, "map_read2", "TAG_ORIGIN", "o2 stop anim", table);
	guy2 thread friendly_damage_penalty();
	
	guy2 thread bottle_test();
	//guy2 waittillmatch("loop anim","attach");
//	guy2 attach("xmodel/bastogne_bottle", "tag_weapon_left");
	
	//guy2 thread animscripts\shared::DoNoteTracksForever("officer2", "die bottle", ::bottle_mover, undefined);
	//guy2 thread maps\_scripted::main ("officer2", "map_read2", "moody_0", maps\bastogne1_add::bottle_thread);
	
	
	// Clean / remove officers up here
	getent ("ai_remover","targetname") waittill ("trigger");
	
	soldiers = getentarray("officer", "targetname");
	
	for (i=0;i<soldiers.size;i++)
	{
		guy = soldiers[i];
		if (isalive(guy))
		{
			guy delete();
		}
	}
	
	if (isalive (level.ender))
	{
		level.ender delete();
	}
}

//
// Bottle animation sequence. Not a test function anymore.
//

bottle_test()
{
	self endon("death");
	bottle = spawn("script_model", level.player.origin);
	bottle setmodel("xmodel/bastogne_bottle");

	while(1)
	{
		self waittillmatch("looping anim","attach");
		
		tag_angles = self gettagangles("TAG_WEAPON_LEFT");
		tag_origin = self gettagorigin("TAG_WEAPON_LEFT");
		bottle.angles = tag_angles;
		bottle.origin = tag_origin;
		bottle linkto(self, "TAG_WEAPON_LEFT",  (0,0,0), (0,0,0));

		self waittillmatch("looping anim","detach");
		bottle unlink(self, "TAG_WEAPON_LEFT",  (0,0,0), (0,0,0));
	}
}

//
// Foley's setup.
//

foley()
{
	
	fs = getent("foley_spawn", "targetname");
	
	level.foley = fs stalingradspawn();
	
	level.foley waittill ("finished spawning");
	
	level.foley endon ("death");

	level.foley character\_utility::new();
	level.foley character\Foley_winter::main();
	level.foley.script_friendname = "Cpt. Foley";
	level.foley.name = "Cpt. Foley";
	//level.foley.hasweapon = false;
	//level.foley animscripts\shared::PutGunInHand("none");

	level.foley thread maps\_utility::magic_bullet_shield();

	level.foley.animname = "foley";
	level.foley thread friendly_damage_penalty();

	getent ("in_barn","targetname") waittill ("trigger");
	level notify ("stop_atmosphere");
	wait 5;
	node = getnode("foley_go","targetname");
	level.foley.goalradius = 4;
	level.foley setgoalnode(node);
	level.foley waittill("goal");
	
	foley_ang = spawn("script_origin", level.foley.origin);
	foley_ang.angles = (0,200,0);
	
	//wait 5.3;
	//level.foley thread anim_single_solo(level.foley,"foley_foxhole");
	level.moody animscripts\shared::putGunInHand ("none");
	level.moody thread anim_single_solo(level.moody, "moody_report_anim", undefined, undefined);
	level.moody thread anim_single_solo(level.moody, "moody_report", undefined, undefined);
	level.foley thread anim_single_solo(level.foley, "foley_foxhole_anim", undefined, foley_ang);
	level.foley waittillmatch ("single anim","foley_foxhole");
	level.foley thread anim_single_solo(level.foley, "foley_foxhole", undefined, foley_ang);
	level.moody waittillmatch ("single anim","moody_30cal");
	level.flags["moody_speech_over"] = true;
	level.foley thread foley_loop_idle_anim();
	level.moody thread anim_single_solo(level.moody, "moody_30cal", undefined, undefined);
	level.moody waittillmatch ("single anim","end");
	//level.moody thread anim_loop_solo(level.moody, "foley_foxhole_idle", "stop idle", undefined);
	//level.foley thread anim_loop_solo(level.foley, "moody_30cal_idle", "stop idle", undefined);
	
	level.moody thread moody_loop_idle_anim();
	
	level thread anderson_prod();

	getent ("ai_remover","targetname") waittill ("trigger");
	
	level notify ("stop foley idle barn anims");
	
	level.foley delete();
	//level.foley.walk_noncombatanim = level.scr_anim["foley"]["unarmedwalk"];
	//level.foley.walk_noncombatanim2 = level.scr_anim["foley"]["unarmedwalk"];
	//level.foley.run_noncombatanim = level.scr_anim["foley"]["unarmedrun"];
	//level.foley.standanim = level.scr_anim["foley"]["breathing"][0];
}

foley_loop_idle_anim()
{
	level endon ("stop foley idle barn anims");
	while (1)
	{	
		level.foley thread anim_single_solo(level.foley, "moody_30cal_idle", undefined, undefined);
		level.foley waittillmatch ("single anim","end");
	}
}

moody_loop_idle_anim()
{
	level endon ("stop moody idle barn anims");
	while (1)
	{
		level.moody thread anim_single_solo(level.moody, "foley_foxhole_idle", undefined, undefined);
		level.moody waittillmatch ("single anim","end");
	}
}


killmoreguys1_squad_init()
{
	self endon("death");
	
	self allowedstances("stand","crouch");
	self.goalradius = 8;
	self.maxSightDistSqrd = 640000;
	self.bravery = 100000;
	self.pacifist = true;
	self.pacifistwait = 0;
	self thread ai_remover();
	self.accuracy = 0.0;
	
	self waittill("goal");
	self allowedstances("stand","crouch","prone");
	self.pacifist = false;
	wait randomintrange(8,10);
	
	//self setgoalentity(level.player);
	x = randomint (3);
	
	if (x == 0)
	{
		index = randomint(level.nodearray_30cal.size);
		self setgoalnode(level.nodearray_30cal[index]);
		//self setgoalnode(level.nodearray_30cal[level.nodearray_counter]);
		//level.nodearray_counter++;
		//if (level.nodearray_counter > level.nodearray_30cal.size)
		//{
		//	level.nodearray_counter = 0;
		//}
	}
	else
	{
		self setgoalnode(getnode("30cal_ai_go_here_main","targetname"));
	}
	
	self allowedstances("stand","crouch");
	self.accuracy = 0.0;
}

//
// Beta squad spawn manager. This squad is directly opposed to the player, so has more AI.
//

killmoreguys1_squad_setup()
{	
	beta = "killmoreguys_1";
	ender_b = "end_killmoreguys_1";
	time_b = 0.2;
	min_b = 2;
	max_b = 4;

	getent("start_battle2","targetname") maps\_utility_gmi::triggerOff();
	
	getent ("start_battle2","targetname") waittill ("trigger");
	guy = getent ("foxholeguy7","targetname");
	guy.health = 500;
	//guy.accuracy = 0.1;
	
	wait 5;

	level thread maps\_squad_manager::manage_spawners(beta,min_b,max_b,ender_b,time_b,::killmoreguys1_squad_init);
	
	wait 10;
	level notify ("debuff accuracy");
	wait 70;
	
	level notify("end_killmoreguys_1");
	level notify ("buff accuracy");
	//level.player.threatbias = level.player.oldtb;
	
	wait 12;
	level notify ("2: drone 2 go");
}

killmoreguys2_squad_init()
{
	self endon("death");

	self allowedstances("stand","crouch");
	self.goalradius = 8;
	self.maxSightDistSqrd = 640000;
	self.bravery = 100000;
	self.pacifist = true;
	self.pacifistwait = 0;
	self thread ai_remover();
	self.accuracy = 0.0;

	self waittill("goal");
	self allowedstances("stand","crouch","prone");
	self.pacifist = false;
	wait randomintrange(10,12);
	
	//self setgoalentity(level.player);
	x = randomint (3);
	if (x == 0)
	{
		if (isalive (self))
		{
			index = randomint(level.nodearray_30cal.size);
			self setgoalnode(level.nodearray_30cal[index]);
			//self setgoalnode(level.nodearray_30cal[level.nodearray_counter]);
			//level.nodearray_counter++;
			//if (level.nodearray_counter > level.nodearray_30cal.size)
			//{
			//	level.nodearray_counter = 0;
			//}
		}
	}
	else
	{
		self setgoalnode(getnode("30cal_ai_go_here_main","targetname"));
	}
	
	self allowedstances("stand","crouch");
	self.accuracy = 0.0;
}

//
// Beta squad spawn manager. This squad is directly opposed to the player, so has more AI.
//

killmoreguys2_squad_setup()
{	
	beta = "killmoreguys_2";
	ender_b = "end_killmoreguys_2";
	time_b = 0.2;
	min_b = 2;
	max_b = 5;

	getent ("start_battle2","targetname") waittill ("trigger");
	getent ("30cal_nosight","targetname") delete();

	wait 5;

	level thread maps\_squad_manager::manage_spawners(beta,min_b,max_b,ender_b,time_b,::killmoreguys2_squad_init);
	
	wait 70;
	
	level notify("end_killmoreguys_2");
	level notify("end chickenshit");
	wait 12;
	
	level.flags["smoke_pop_event"] = true;
}

//
//
//

alpha_squad_init()
{
	
	self allowedstances("stand","crouch");
}

//
// Alpha squad spawn manager.
//

alpha_squad_setup()
{	
	if (getcvar("scr_gmi_fast") != 0)
	{
		wait 35;
		level notify ("1: drone 3 go");
		return;
	}
	
	alpha = "alpha";
	ender_a = "end_alpha";
	time_a = 2;
	min_a = 2;
	max_a = 5;

	getent ("foxhole3_trig","targetname") waittill ("trigger");	

	wait 5;

	level thread maps\_squad_manager::manage_spawners(alpha,min_a,max_a,ender_a,time_a,::alpha_squad_init);
	
	wait 30;
	level notify ("1: drone 3 go");
	wait 20;
	
	level notify("end_alpha");
}


//
//
//

beta_squad_init()
{
	self allowedstances("stand","crouch");
	self.goalradius = 8;
	
	self waittill("goal");
	self allowedstances("stand","crouch","prone");
	
	wait randomintrange(18,20);
	
	newnodes = getnodearray("beta2","targetname");
	
	index = randomint(newnodes.size);
	
	self setgoalnode(newnodes[index]);
}

//
// Beta squad spawn manager. This squad is directly opposed to the player, so has more AI.
//

beta_squad_setup()
{	
	beta = "beta";
	ender_b = "end_beta";
	time_b = 0.2;
	min_b = 3;
	max_b = 5;

	getent ("foxhole3_trig","targetname") waittill ("trigger");

	wait 5;

	level thread maps\_squad_manager::manage_spawners(beta,min_b,max_b,ender_b,time_b,::beta_squad_init);
	
	wait 50;
	
	level notify("end_beta");
	
	wait 18;
	
	level.flags["battle_over"] = true;
	
	level notify ("stop finding favorite");
	level notify ("remove 30 cal now");
	
	level.flags["kill_more_guys_event"] = true;
	
	wait 8;
	level notify ("alpha killer now off again");
}

//
//
//

beta_2nd_squad_init()
{
	self allowedstances("stand","crouch");
	self.goalradius = 8;
	
	self waittill("goal");
	self allowedstances("stand","crouch","prone");
	
	wait randomintrange(18,20);
	
	newnodes = getnodearray("beta2","targetname");
	
	index = randomint(newnodes.size);
	
	self.goalradius = 8;
	self setgoalnode(newnodes[index]);
	self.goalradius = 8;
}

//
// Beta squad spawn manager. This squad is directly opposed to the player, so has more AI.
//

beta2nd_squad_setup()
{	
	beta = "beta_2nd";
	ender_b = "end_beta_2nd";
	time_b = 0.2;
	min_b = 3;
	max_b = 4;

	getent ("foxhole3_trig","targetname") waittill ("trigger");

	wait 5;

	level thread maps\_squad_manager::manage_spawners(beta,min_b,max_b,ender_b,time_b,::beta_2nd_squad_init);
	
	wait 5;
	level thread own_chickenshit_player_think();	


	wait 45;
	level notify("end chickenshit");	
	level notify("end_beta_2nd");
}

//
//
//

gamma_squad_init()
{
	
	self allowedstances("stand","crouch");
	self.goalradius = 8;
	
	self waittill("goal");
	self allowedstances("stand","crouch","prone");
}

//
// Gamma squad spawn manager. Across from 50 cal, gets continously pounded.
//

gamma_squad_setup()
{	
	//if (getcvar("scr_gmi_fast") != 0)
	//{
	//	return;
	//}
	
	gamma = "gamma";
	ender_c = "end_gamma";
	time_c = 1;
	min_c = 3;
	max_c = 5;
	
	getent ("foxhole3_trig","targetname") waittill ("trigger");

	wait 5;

	level thread maps\_squad_manager::manage_spawners(gamma,min_c,max_c,ender_c,time_c,::gamma_squad_init);
	
	//wait 100;
	
	level waittill ("shermans incoming");
	level notify("end_gamma");

}

gamma_count_up()
{
	level endon ("shermans incoming");
	guys = getentarray("ooga_booga","script_noteworthy");
	while (1)
	{
		for (i=0;i<guys.size;i++)
		{
			guys[i].count = 40;
		}
		wait 20;
	}
}
//
//
//

delta_squad_init()
{
	self allowedstances("stand","crouch");
	self.goalradius = 8;
	self.pacifist = true;
	self.pacifistwait = 0;
	
	self waittill("goal");
	
	self.pacifist = false;
	
	self allowedstances("stand","crouch","prone");
	
	wait randomintrange(10,12);
	
	newnodes = getnodearray("delta2","targetname");
	
	index = randomint(newnodes.size);
	
	self.goalradius = 8;
	self setgoalnode(newnodes[index]);
}

//
// Delta squad spawn manager. A tank squad.
//

delta_squad_setup()
{	
	delta = "delta";
	ender_d = "end_delta";
	time_d = 0.1;
	min_d = 1;
	max_d = 3;

	level waittill("start tank squads");

	level thread maps\_squad_manager::manage_spawners(delta,min_d,max_d,ender_d,time_d,::delta_squad_init);
	
	level waittill("shermans incoming");
	
	wait 15;
	
	level notify("end_delta");
}


//
//
//

epsilon_squad_init()
{
	
	self allowedstances("stand","crouch");
	self.goalradius = 8;
	self.pacifist = true;
	self.pacifistwait = 0;
	
	self waittill("goal");
	
	self.pacifist = false;
	
	if (level.flags["tank1_reached_node"] == true)
	{
		wait randomintrange(5,7);
	}
	else
	{
		while(level.flags["tank1_reached_node"] == false)
		{
			wait 0.5;
		}
	}
	
	self allowedstances("stand","crouch","prone");
	
	newnodes = getnodearray("epsilon2","targetname");
	index = randomint(newnodes.size);
	self setgoalnode(newnodes[index]);	
	self waittill("goal");
	
	wait randomintrange(8,10);
	
	newnodes = getnodearray("epsilon3","targetname");
	index = randomint(newnodes.size);
	self setgoalnode(newnodes[index]);	
}

//
// Epsilon squad spawn manager. A tank squad.
//

epsilon_squad_setup()
{	
	epsilon = "epsilon";
	ender_e = "end_epsilon";
	time_e = 0.1;
	min_e = 1;
	max_e = 3;

	level waittill("start tank squads");

	level thread maps\_squad_manager::manage_spawners(epsilon,min_e,max_e,ender_e,time_e,::epsilon_squad_init);
	
	level waittill("shermans incoming");
	
	wait 15;
	
	level notify("end_epsilon");
}

//
//
//

zeta_squad_init()
{
	self allowedstances("stand","crouch");
	self.goalradius = 8;
	self.pacifist = true;
	self.pacifistwait = 0;
	
	self waittill("goal");
	
	self.pacifist = false;
	
	self allowedstances("stand","crouch","prone");
	
	wait randomintrange(10,12);
	
	newnodes = getnodearray("zeta2","targetname");
	
	index = randomint(newnodes.size);
	
	self.goalradius = 8;
	self setgoalnode(newnodes[index]);
}

//
// Zeta squad spawn manager. A tank squad.
//

zeta_squad_setup()
{	
	zeta = "zeta";
	ender_f = "end_zeta";
	time_f = 0.1;
	min_f = 1;
	max_f = 3;

	level waittill("start tank squads");

	level thread maps\_squad_manager::manage_spawners(zeta,min_f,max_f,ender_f,time_f,::zeta_squad_init);
	
	level waittill("shermans incoming");
	
	wait 15;
	
	level notify("end_zeta");
}

//
//
//

mg34_squad_init()
{
	
	//self allowedstances("stand");
}


//
// mg34 spawn manager. A tank squad.
//

mg34_squad_setup()
{	
	zeta = "mg34_squad";
	ender_f = "end_mg34";
	time_f = 10;
	min_f = 1;
	max_f = 3;

	getent ("foxhole3_trig","targetname") waittill ("trigger");

	wait 25;

	level thread maps\_squad_manager::manage_spawners(zeta,min_f,max_f,ender_f,time_f,::mg34_squad_init);
	
	wait 60;
	
	level notify("end_mg34");
	
	squad = maps\_squad_manager::alive_array("mg34_squad");
	
	for (i=0;i<squad.size;i++)
	{
		if (isalive(squad[i]))
		{
			squad[i] dodamage(squad[i].health + 50, (0,0,0));
		}
		wait randomfloatrange(0.5,2.0);
	}
	
}

//
//
//

moodyattack1_squad_init()
{
	
	self allowedstances("stand");
	
	self waittill("goal");
	self allowedstances("stand","crouch","prone");
	
	wait randomintrange(10,12);
	
	newnodes = getnodearray("moody_attack","targetname");
	
	index = randomint(newnodes.size);
	
	self setgoalnode(newnodes[index]);
	self waittill("goal");
	
	self thread goto_player(10);
}

//
// Moody squad 1 attack
//

moodyattack1_squad_setup()
{	
	attackers = "moody_attack1";
	ender_f1 = "moody_attack1_end";
	time_f1 = 1;
	min_f1 = 1;
	max_f1 = 2;

	level waittill ("moody moving in");

	level thread maps\_squad_manager::manage_spawners(attackers,min_f1,max_f1,ender_f1,time_f1,::moodyattack1_squad_init);
	
	level waittill("stop moody attackers");
	
	level notify("moody_attack1_end");
}

//
//
//

moodyattack2_squad_init()
{
	
	self allowedstances("stand");
	
	self waittill("goal");
	self allowedstances("stand","crouch","prone");
	
	wait randomintrange(10,12);
	
	newnodes = getnodearray("moody_attack","targetname");
	
	index = randomint(newnodes.size);
	
	self setgoalnode(newnodes[index]);
	self waittill("goal");
	
	self thread goto_player(10);
}


//
// Moody squad 1 attack
//

moodyattack2_squad_setup()
{	
	attackers = "moody_attack2";
	ender_f1 = "moody_attack2_end";
	time_f1 = 1;
	min_f1 = 1;
	max_f1 = 2;

	level waittill ("moody moving in");

	level thread maps\_squad_manager::manage_spawners(attackers,min_f1,max_f1,ender_f1,time_f1,::moodyattack2_squad_init);
	
	level waittill("stop moody attackers");
	
	level notify("moody_attack2_end");
}

//
// Kills guys from alpha squad.
//

alpha_killer()
{
	killer = getent ("alpha_killer","targetname");
	
	killer maps\_utility_gmi::triggerOff();
	
	getent ("player_save","targetname") waittill ("trigger");
	level notify("objective_3_complete");
	
	killer maps\_utility_gmi::triggerOn();
	
	level waittill ("alpha killer now off again");
	
	killer maps\_utility_gmi::triggerOff();
}

//
// Kills guys manning mortars.
//

mortar_killer()
{
	//killer1 = getent ("mortar_death1","targetname");

	//killer1 maps\_utility_gmi::triggerOff();

	//getent ("trigger_foxhole2","targetname") waittill ("trigger");
	
	//killer1 maps\_utility_gmi::triggerOn();

}

//
//
//

final3_squad_init()
{
	
	self allowedstances("stand");
}

//
// Final 3 squad spawn manager.
//

final3_squad_setup()
{	
	final3 = "final3";
	ender_f3 = "end_final3";
	time_f3 = 0.2;
	min_f3 = 5;
	max_f3 = 5;
	
	level waittill("owned panzers go");

	wait 3;
	
	ai = getaiarray("axis");
	
	if ((32 - ai.size) < max_f3)
	{
		max_f3 = ai.size - 32;
	} 

	if (max_f3 > 0)
	{
		level thread maps\_squad_manager::manage_spawners(final3,min_f3,max_f3,ender_f3,time_f3,::final3_squad_init);
	}
	
	wait 1;
	
	level thread final2_squad_setup();
	level notify("end_final3");
}

//
//
//

final2_squad_init()
{
	
	self allowedstances("stand");
}

//
// Final 2 squad spawn manager.
//

final2_squad_setup()
{	
	final2 = "final2";
	ender_f2 = "end_final2";
	time_f2 = 0.2;
	min_f2 = 4;
	max_f2 = 4;
	
	level waittill ("end_final3");
	
	ai = getaiarray("axis");
	
	if ((32 - ai.size) < max_f2)
	{
		max_f2 = ai.size - 32;
	} 
	
	if (max_f2 > 0) 
	{
		level thread maps\_squad_manager::manage_spawners(final2,min_f2,max_f2,ender_f2,time_f2,::final2_squad_init);
	}
	
	wait 1;
	
	level thread final1_squad_setup();
	level notify("end_final2");
}

//
//
//

final1_squad_init()
{
	
	self allowedstances("stand");
}

//
// Final 1 squad spawn manager.
//

final1_squad_setup()
{	
	final1 = "final1";
	ender_f1 = "end_final1";
	time_f1 = 0.2;
	min_f1 = 4;
	max_f1 = 4;

	level waittill ("end_final2");
	
	ai = getaiarray("axis");
	
	if ((32 - ai.size) < max_f1)
	{
		max_f1 = ai.size - 32;
	} 
	
	if (max_f1 > 0) 
	{
		level thread maps\_squad_manager::manage_spawners(final1,min_f1,max_f1,ender_f1,time_f1,::final1_squad_init);
	}
	
	wait 1;
	
	level notify("end_final1");
}

//
// Half tracks that spawn in across hay field.
//

field_halftrack()
{

	getent ("foxhole3_trig","targetname") waittill ("trigger");
	wait 15;
	ht1 = getent ("ht1","targetname");
	ht1 thread maps\_halftrack_gmi::init("reached_end_node");
	ht1.health = 10000000;
	ht1 startpath();
	ht1 thread mg42_halftrack_modulate();
	ht1 thread remove_smoke_minspec();
	ht1 waittill ("reached_end_node");
	ht1 disconnectpaths();

	wait 20;
	ht2 = getent ("ht2","targetname");
	ht2 thread maps\_halftrack_gmi::init("reached_end_node");
	ht2.health = 10000000;
	ht2 startpath();
	ht2 thread mg42_halftrack_modulate();
	ht2 thread remove_smoke_minspec();
	ht2 waittill ("reached_end_node");
	ht2 disconnectpaths();

	wait 67;
	ht3 = getent ("ht3","targetname");
	ht3 thread maps\_halftrack_gmi::init("reached_end_node");
	ht3.health = 10000000;
	ht3 startpath();
	level.flags["30cal_open_path"] = true;
	ht3 thread mg42_halftrack_modulate();
	ht3 thread remove_smoke_minspec();
	ht3 waittill ("reached_end_node");
	ht3 disconnectpaths();
	level notify ("halftrack_blocker moved");
}

//
// Deletes half tracks once past that part of the level,
//
delete_halftracks()
{
	getent ("moody_punish_off","targetname") waittill ("trigger");
	ht1 = getent ("ht1","targetname");
	ht2 = getent ("ht2","targetname");
	ht3 = getent ("ht3","targetname");
	
	level thread maps\bastogne1::remove_vehicle(ht1);
	level thread maps\bastogne1::remove_vehicle(ht2);
	level thread maps\bastogne1::remove_vehicle(ht3);	
}

//
// Spawn panzer
//

spawn_panzer(pathname)
{
	tank1 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "vclogger", "PanzerIV" ,(0,0,0), (0,0,0) );
	tank1 maps\_panzeriv_gmi::init();
	path1 = getVehicleNode (pathname,"targetname");
	tank1 attachpath(path1);
	tank1.isalive = 1;
	tank1.script_noteworthy = "remove_me_tank";
	tank1.health = (100);
	//tank1 maps\_tankgun_gmi::mgoff();
	tank1 startpath();
	tank1 thread tank_fire_think_mg42();
	tank1 thread remove_smoke_minspec();
	
	return tank1;
}

//
// Deletes tanks once past that part of the level,
//
delete_tanks()
{
	getent ("moody_punish_off","targetname") waittill ("trigger");
	
	tanks = getentarray("remove_me_tank","script_noteworthy");
	
	//fx = loadfx("fx/smoke/oneshotblacksmokelinger.efx")
	
	for (i=0;i<tanks.size;i++)
	{
		level thread maps\bastogne1::remove_vehicle(tanks[i]);
	}	
}

//
// Spawn tigers
//

spawn_tiger(pathname, targetname)
{
	tank1 = spawnVehicle( "xmodel/vehicle_tank_tiger_camo", targetname, "PanzerIV" ,(0,0,0), (0,0,0) );
	tank1 maps\_tiger_gmi::init();
	path1 = getVehicleNode (pathname,"targetname");
	tank1 attachpath(path1);
	tank1.isalive = 1;
	tank1.health = (100);
	tank1.script_noteworthy = "remove_me_tank";
	//tank1 maps\_tankgun_gmi::mgoff();
	tank1 startpath();
	tank1 thread tank_fire_think_mg42();
	tank1 thread remove_smoke_minspec();
	return tank1;
}

//
// Fucked panzers gets OWNED hard - by planes.
//

plane_tanks()
{
	
	level waittill ("planetanks go");
	
	tank1 = spawn_panzer("planetank1");
	
	tank2 = spawn_panzer("planetank2");
}

//
// Fucked panzer gets OWNED hard - by bazookas.
//

fucked_tanks()
{	
	getent ("foxhole3_trig","targetname") waittill ("trigger");
	
	wait 25;
	
	tank1 = spawn_panzer("fucked_panzer1");
	level notify ("fucked tank 1 spawned");
	tank1 setWaitNode(getVehicleNode("jesse168","targetname"));
	wait 19.5;
	radiusDamage(tank1.origin, 300, 500, 500);
	
	wait 40;

	tank2 = spawn_tiger("fucked_panzer2","fucked_tiger2");
	level notify ("fucked tank 2 spawned");
	tank2 setWaitNode(getVehicleNode("jesse186","targetname"));
	tank2 thread panzer_fireTank_cannon_at_trees();			// Fires at trees near player foxhole (hardcoded).
	level notify ("2: drone 1 go");
	wait 20;
	radiusDamage(tank2.origin, 300, 500, 500);
	
	wait 50;
	
	tank3 = spawn_tiger("fucked_panzer3","fucked_tiger3");
	tank3 setWaitNode(getVehicleNode("jesse174","targetname"));
	tank3 waittill ("reached_wait_node");
	radiusDamage(tank3.origin, 300, 500, 500);
}

//
// Panzers coming over the hill sequence.
//

end_panzers()
{
	
	//getent ("trigger_foxhole2","targetname") waittill ("trigger");
	level waittill ("final tanks move out");
	level.tankcounter = 0;
	level notify("start tank squads");
	
	wait 10;
	
	tank1 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "endpanzer1", "PanzerIV" ,(0,0,0), (0,0,0) );
	level.tankcounter++;
	tank1 maps\_panzeriv_gmi::init();
	path1 = getVehicleNode ("end_tank_path2","targetname");
	tank1 attachpath(path1);
	tank1.isalive = 1;
	tank1.health = (1200);
	//tank1 maps\_tankgun_gmi::mgoff();
	tank1 startpath();
	tank1 setspeed(5,10);
	tank1 thread end_panzer_notify_squad(1, "jesse108");
	tank1 thread end_tank_roll_paths(path1);
	tank1 thread end_on_tank_death(1,8);
	tank1 thread remove_smoke_minspec();
	getent ("panzer_fire","targetname") waittill ("trigger");
	tank1 thread panzer_fireTank_cannon();
	tank1 thread tank_fire_think_mg42();
	
	tank2 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "endpanzer2", "PanzerIV" ,(0,0,0), (0,0,0) );
	level.tankcounter++;
	tank2 maps\_panzeriv_gmi::init();
	path2 = getVehicleNode ("end_tank_path1","targetname");
	tank2 attachpath(path2);
	tank2.isalive = 1;
	tank2.health = (1200);
	//tank2 maps\_tankgun_gmi::mgoff();
	tank2 thread tank_fire_think_mg42();
	level notify ("swing and a miss");
	/*while (1)				// Prevents tank 2 from coming in
	{
		if (!isalive(tank1))
		{
			break;	
		}
		wait 0.1;
	}*/
	wait 15;
	
	tank2 startpath();
	tank2 setspeed(5,10);
	tank2 thread end_panzer_notify_squad(2,"jesse304");
	tank2 thread end_tank_roll_paths(path2);
	tank2 thread end_on_tank_death(2,9);
	tank2 thread remove_smoke_minspec();
	getent ("panzer_fire","targetname") waittill ("trigger");
	tank2 thread panzer_fireTank_cannon();
	
	tank3 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "endpanzer3", "PanzerIV" ,(0,0,0), (0,0,0) );
	level.tankcounter++;
	tank3 maps\_panzeriv_gmi::init();
	path3 = getVehicleNode ("end_tank_path3","targetname");
	tank3 attachpath(path3);
	tank3.isalive = 1;
	tank3.health = (1200);
	//tank3 maps\_tankgun_gmi::mgoff();
	tank3 thread tank_fire_think_mg42();

	/*while (1)				// Prevents tank 3 from coming in
	{
		if (!isalive(tank2))
		{
			break;	
		}
		wait 0.1;
	}*/
	wait 15;
	
	tank3 startpath();
	tank3 setspeed(5,10);
	tank3 thread end_panzer_notify_squad(3,"jesse114");
	tank3 thread end_tank_roll_paths(path3);
	tank3 thread end_on_tank_death(3,10);
	tank3 thread remove_smoke_minspec();
	getent ("panzer_fire","targetname") waittill ("trigger");
	tank3 thread panzer_fireTank_cannon();
	
	while (level.deadtanks != 3)				// Once last tank dies, bring in shermans
	{
		//if (!isalive(tank3))
		//{
		//	break;	
		//}
		wait 0.1;
	}
	
	level notify ("owned panzers go");
	level notify ("shermans incoming");
}

//
//
//

end_panzer_notify_squad(squad_num, wait_node)
{
	self setWaitNode(getVehicleNode(wait_node,"targetname"));
	self waittill ("reached_wait_node");
	
	if (squad_num == 1)
		level.flags["tank1_reached_node"] = true;
}


//
//
//
end_on_tank_death(number, objnum)
{
	
	while (1)
	{
		if (!isalive(self))
		{
			break;	
		}
		wait 0.5;
	}
	bazooka = getent("bazooka_"+number,"targetname");
	bazooka delete();
	level notify("objective_"+objnum+"_complete");
	level notify("objective_tank_complete");
	
	if (number == 1)
	{
		num = "safe1";
		//level.moody thread anim_single_solo(level.moody,"moody_another_panzer");
		level.deadtanks++;
		level.flags["endtankalive1"] = 0;
	}
	if (number == 2)
	{
		num = "safe2";
		level.deadtanks++;
		level.flags["endtankalive2"] = 0;
	}
	if (number == 3)
	{
		num = "safe3";
		level.deadtanks++;
		level.flags["endtankalive3"] = 0;
	}
	
	level.flags[num] = false;
}

//
// LAst three panzers that "get blown up by shermans." Haha, OR SO YOU THINK.
//

end_panzers_owned()
{
	
	level waittill("owned panzers go");
	
	tank1 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "deadpanzer1", "PanzerIV" ,(0,0,0), (0,0,0) );
	tank1 maps\_panzeriv_gmi::init();
	path1 = getVehicleNode ("end_tank_path1","targetname");
	tank1 attachpath(path1);
	tank1.isalive = 1;
	tank1.health = (100);
	//tank1 maps\_tankgun_gmi::mgoff();
	tank1 startpath();
	tank1 setspeed(10,10);
	tank1 thread end_panzer_fire_think(1);
	tank1 thread tank_fire_think_mg42();
	//tank1 thread panzer_fireTank_cannon();
	//tank1 end_tank_roll_paths(path1);
	tank1 thread remove_smoke_minspec();
	
	tank2 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "deadpanzer2", "PanzerIV" ,(0,0,0), (0,0,0) );
	tank2 maps\_panzeriv_gmi::init();
	path2 = getVehicleNode ("end_tank_path2","targetname");
	tank2 attachpath(path2);
	tank2.isalive = 1;
	tank2.health = (100);
	//tank2 maps\_tankgun_gmi::mgoff();
	//tank2 thread panzer_fireTank_cannon();
	tank2 startpath();
	tank2 setspeed(10,10);
	tank2 thread end_panzer_fire_think(2);
	tank2 thread tank_fire_think_mg42();
	tank2 thread remove_smoke_minspec();
	//tank2 end_tank_roll_paths(path2);
	
	/*tank3 = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "deadpanzer3", "PanzerIV" ,(0,0,0), (0,0,0) );
	tank3 maps\_panzeriv_gmi::init();
	path3 = getVehicleNode ("end_tank_path4","targetname");
	tank3 attachpath(path3);
	tank3.isalive = 1;
	tank3.health = (100);
	tank3 maps\_tankgun_gmi::mgoff();
	//tank3 thread panzer_fireTank_cannon();
	tank3 startpath();
	tank3 setspeed(10,10);*/
	//tank3 end_tank_roll_paths(path3);
	
	//while (isalive(tank1) && isalive(tank2) && isalive(tank3))				
	//{
	//	wait 0.1;
	//}
	
	wait 5;
	level.moody thread anim_single_solo(level.moody,"moody_oh_god");
	
	wait 10;
	tank1 thread kill_panzer();
	wait 5;
	tank2 thread kill_panzer();
	//wait 4;
	//tank3 thread kill_panzer();
	
	level notify ("panzers dead");
	
}

//
// Just does some radius damage. Used for killing panzers mostly. MOSTLY.
//

kill_panzer()
{
	radiusDamage(self.origin, 300, 500, 500);
}

//
// Panzers in Shermans direction.
//
end_panzer_fire_think(num)
{
	self endon ("death");
	target1 = getent("end_tank_target_1","targetname");
	target2 = getent("end_tank_target_2","targetname");
	
	if (num == 1)
	{
		wait 3;
		self setTurretTargetEnt(target1, (0,0,0));
		wait 5;
		self thread maps\_tiger_gmi::fire();
		wait 5;
		self thread maps\_tiger_gmi::fire();
	}
	if (num == 2)
	{
		wait 5;
		self setTurretTargetEnt(target2, (0,0,0));
		wait 5;
		self thread maps\_tiger_gmi::fire();
		wait 5;
		self thread maps\_tiger_gmi::fire();
	}
}

//
// Shermans coming over the hill sequence.
//

end_shermans()
{
	
	level waittill ("shermans incoming");
	
	wait 3;
	level thread maps\bastogne1::distantTankRumble (getent("tankblend_7","targetname"),"sherman");
	wait 7; 
	
	level.iStopBarrage = 1;
	level.iStopBarrage4 = 1;
	
	//iprintlnbold("Did you hear that? Is that one of ours? ");
	sound_org = spawn("script_origin", level.player.origin+(-100,-100,0));
	
	level notify ("stop tank rumble");
	sherman1 = spawnVehicle("xmodel/v_us_lnd_sherman_snow", "vclogger", "ShermanTank" ,(0,0,0), (0,0,0) );
	sherman1 thread maps\_sherman_gmi::init();
	sherman1 thread maps\_tankgun_gmi::mgoff(); // Turn OFF MG.
	path1 = getVehicleNode ("sherman_path1","targetname");
	sherman1 attachpath(path1);
	sherman1.isalive = 1;
	sherman1.health = (1000000);
	sherman1 startpath();
		
	sherman2 = spawnVehicle("xmodel/v_us_lnd_sherman_snow", "vclogger", "ShermanTank" ,(0,0,0), (0,0,0) );
	sherman2 thread maps\_sherman_gmi::init();
	sherman2 thread maps\_tankgun_gmi::mgoff(); // Turn OFF MG.
	path2 = getVehicleNode ("sherman_path2","targetname");
	sherman2 attachpath(path2);
	sherman2.isalive = 1;
	sherman2.health = (1000000);
	sherman2 startpath();
	
	sherman3 = spawnVehicle("xmodel/v_us_lnd_sherman_snow", "vclogger", "ShermanTank" ,(0,0,0), (0,0,0) );
	sherman3 thread maps\_sherman_gmi::init();
	sherman3 thread maps\_tankgun_gmi::mgoff(); // Turn OFF MG.
	path3 = getVehicleNode ("sherman_path3","targetname");
	sherman3 attachpath(path3);
	sherman3.isalive = 1;
	sherman3.health = (1000000);
	sherman3 startpath();
	
	sherman4 = spawnVehicle("xmodel/v_us_lnd_sherman_snow", "vclogger", "ShermanTank" ,(0,0,0), (0,0,0) );
	sherman4 thread maps\_sherman_gmi::init();
	sherman4 thread maps\_tankgun_gmi::mgoff(); // Turn OFF MG.
	path4 = getVehicleNode ("sherman_path4","targetname");
	sherman4 attachpath(path4);
	sherman4.isalive = 1;
	sherman4.health = (1000000);
	sherman4 startpath();
	
	wait 3;
	
	//p1 = getent("deadpanzer1","targetname");
	//p2 = getent("deadpanzer2","targetname");
	//p3 = getent("deadpanzer3","targetname");
	
	//sherman1 thread sherman_fireTank_cannon_tank(p1);
	//sherman2 thread sherman_fireTank_cannon_tank(p1);
	//sherman3 thread sherman_fireTank_cannon_tank(p2);
	//sherman4 thread sherman_fireTank_cannon_tank(p3);
	
	//level waittill("panzers dead");
	
	sherman1 thread sherman_fireTank_cannon();
	sherman2 thread sherman_fireTank_cannon();
	sherman3 thread sherman_fireTank_cannon();
	sherman4 thread sherman_fireTank_cannon();
	
	sherman1 thread sherman_fireTank_mg42();
	sherman2 thread sherman_fireTank_mg42();
	sherman3 thread sherman_fireTank_mg42();
	sherman4 thread sherman_fireTank_mg42();

	level notify("objective_11_complete");
		
	wait 4;
	playSoundinSpace ("trooper_ours", sound_org.origin);
		
	level notify("begin retreat");
	wait 5;
	playSoundinSpace ("trooper_alright", sound_org.origin);
	level thread friendly_cheer();

	wait 5;
	level.moody thread anim_single_solo(level.moody,"moody_tincans");
	wait 5;
	
	level notify("level win");
}

//
// Start the last guys in the foxhole fighting.
//

foxhole2Soldier_setup()
{	
	soldiers = getentarray("foxhole2", "targetname");
	
	getent ("trigger_foxhole2","targetname") waittill ("trigger");
	
	for (i=0;i<soldiers.size;i++)
	{
		guy = soldiers[i] stalingradspawn();
		guy waittill ("finished spawning");
		guy.script_noteworthy = "2ndline";
		guy.health = 10000;
		guy.goalradius = 8;
		if (isdefined(soldiers[i].script_noteworthy))
		{
			if (soldiers[i].script_noteworthy == "fh2_4")
			{
				guy.targetname = "keeper";
			}
			else if (soldiers[i].script_noteworthy == "fh2_8")
			{
				guy.targetname = "keeper";
			}
			else if (soldiers[i].script_noteworthy == "fh2_3")
			{
				guy.targetname = "keeper";
			}
			else if (soldiers[i].script_noteworthy == "fh2_6")
			{
				guy.targetname = "keeper";
			}
			else
			{
				guy.targetname = "not_keeper";
			}
			guy.whodatis = soldiers[i].script_noteworthy;
		}
		else
		{
			guy.targetname = "not_keeper";
		}
		if (guy.team == "axis")
		{
			guy thread kill_me_sooner();
		}
	}	
	
	//getent ("start_panzers","targetname") waittill ("trigger");
	
	level waittill ("moody collapse trigger");
	
	soldiers = getentarray("2ndline", "script_noteworthy");
	
	for (i=0;i<soldiers.size;i++)
	{
		if (isalive(soldiers[i]))
		{
			if (isdefined(soldiers[i].targetname))
			{
				if (soldiers[i].targetname == "keeper")
				{
					soldiers[i].health = 20000;
				}
				else
				{
					soldiers[i].health = 400;
				}
			}
			soldiers[i] dodamage(5, (0,0,0));
		}
	}
	
	wait 10;
	
	for (i=0;i<soldiers.size;i++)
	{
		if (isalive(soldiers[i]))
		{
			if (isdefined(soldiers[i].whodatis))
			{
				node = getnode(soldiers[i].whodatis,"targetname");
				if (isalive(soldiers[i]))
				{
					soldiers[i].goalradius = 8;
					soldiers[i] setgoalnode(node);
				}
			}
		}
	}
	
}

//
//
//

kill_me_sooner()
{
	self endon ("death");
	while (1)
	{
		self waittill ("damage", dmg, who);
		if (who == level.player)
		{
			if (isalive(self))
			{
				self dodamage (self.health + 50, (0,0,0));
			}
		}
	}
}

//
// Guys in foxhole get OWNED. GG Mortar.
//

mortar_foxhole()
{
	mortar = getent ("mortar_foxhole","targetname");
	
	getent ("trigger_mortar_foxhole","targetname") waittill ("trigger");
	
	//for (i=0;i<mortar.size;i++)
	//{
	//	mortar[i] maps\_mortar_gmi::activate_mortar (100, 1000, 200, .3, 1, 1500);
	//}
	
	playfx (level.mortar ,mortar.origin);
	earthquake(0.5, 3, mortar.origin, 1500);
	mortar playsound ("shell_explosion1");
	
	pointer = getent("foxhole_pointer","targetname");
	pointer_friend = getent("foxhole_pointer_friend","targetname");
	
	pointer notify ("stop pointing");
	
	pointer thread foxhole_killfunc1();
	pointer_friend thread foxhole_killfunc2();
}

foxhole_killfunc1()
{
	//self.deathanim = undefined;
	//self.allowdeath = false;
	self endon ("death");
	
	
	self animscripted("animontagdone", self.origin+(0,0,48), self.angles, level.scr_anim["foxhole_pointer"]["pointer_death"]);
	self waittill ("animontagdone");
	
	self animscripted("animontagdone", self.origin+(0,0,-14), self.angles, level.scr_anim["foxhole_pointer"]["pointer_death_idle"]);
	self waittill ("animontagdone");
	
	//self.health = 1;
	//self dodamage (80,(0,0,0));
	self.ignoreme = true;
	self.team = "axis";
	self settakedamage(0);
	
	while (1)
	{
		self animscripted("animontagdone", self.origin+(0,0,0), self.angles, level.scr_anim["foxhole_pointer"]["pointer_death_idle"]);
		self waittill ("animontagdone");
	}	
	
	//self dodamage (self.health+100,(0,0,0));
	//self stopanimscripted();
}

foxhole_killfunc2()
{
	//self.deathanim = undefined;
	//self.allowdeath = false;
	self endon ("death");
	
	self animscripted("animontagdone", self.origin+(0,0,48), self.angles, level.scr_anim["foxhole_pointer_friend"]["pointer_friend_death"]);
	self waittill ("animontagdone");
	
	self animscripted("animontagdone", self.origin+(0,0,-18), self.angles, level.scr_anim["foxhole_pointer_friend"]["pointer_friend_death_idle"]);
	self waittill ("animontagdone");
	
	self.ignoreme = true;
	self.team = "axis";
	self settakedamage(0);
		
	while (1)
	{
		self animscripted("animontagdone", self.origin+(0,0,0), self.angles, level.scr_anim["foxhole_pointer_friend"]["pointer_friend_death_idle"]);
		self waittill ("animontagdone");
	}
	//self dodamage (self.health+100,(0,0,0));
	//self stopanimscripted();
}

//
// Panzy ass krauts take to the hills.
//

ai_retreat()
{
	node = getnode("retreat_point", "targetname");
	
	level waittill("begin retreat");
	
	while (1)
	{
		ai = getaiarray("axis");
		
		for (i=0;i<ai.size;i++)
		{	
			if (isalive(ai[i]))
			{
				ai[i].maxSightDistSqrd = 0;
				ai[i].pacifist = true;
				ai[i].pacifistwait = 0;
				ai[i] allowedStances ("stand");
				ai[i] setgoalnode (node);
			}
		}
		
		if (level.flags["battle2_over"] == true)
		{
			break;
		}
		wait 1;	
	}
}

//
// General Punish function. Punished player when leaves Anderson's side.
//

punish_player(ai, max_distance)
{
	self endon("stop punishing");
	
	while(1)
	{
		ai_origin = ai.origin;
		if (isdefined (ai.targetname))
		{
			println ("("+max_distance+")"+"distance from"+ai.targetname+": "+distance ((level.player getorigin()), ai_origin));
		}
		if (distance ((level.player getorigin()), ai_origin) >= max_distance)
		{
			
				origin = (level.player getorigin());
				playSoundinSpace ("mortar_incoming", origin);
				radiusDamage (origin, 200, 10000, 10000);
				playfx (level.mortar, origin);
				level.player maps\_mortar::mortar_sound();
				earthquake(0.15, 2, origin, 850);
		}
		wait 2.5;
	}
}

//
// Assigns when punishing begins / starts.
//

punish_assign()
{
	wait 5;
	
	anderson = getent("anderson_guy", "targetname");			// Anderson
	moody = getent("moodytemp_guy", "targetname");
	sniper_hole = getent("mortar_foxhole2", "targetname");
	mg30cal_hole = getent("mortar_foxhole3", "targetname");
	
	getent ("anderson_out","targetname") waittill ("trigger");
	
	trig = getent ("anderson_out","targetname");
	trig delete();
	
	level thread punish_player(anderson, 550);
	getent ("start_battle1","targetname") waittill ("trigger");
	
	level notify("stop punishing");
	
	level thread punish_player(anderson, 200);				// Just a bit outside the foxhole
	level waittill ("objective_4_complete");
	level notify("stop punishing");
	
	level thread punish_player(moody, 800);				// Moody
	level waittill ("moody back in action");				// Moody goes into loop again
	level notify("stop punishing");
	
	wait 8;
	
	level thread punish_player(mg30cal_hole, 200);
	level waittill ("objective_5_complete");
	level notify("stop punishing");
	
	level thread punish_player(moody, 800);				// Moody
	level waittill ("moody moving in 2");					// Moody goes in for plane smoke
	level notify("stop punishing");
	
	level thread punish_player(sniper_hole, 200);
	level waittill ("moody to ridge");
	level notify("stop punishing");
	
	level thread punish_player(moody, 800);				// Moody
	getent ("moody_punish_off","targetname") waittill ("trigger");		// Turn off after player goes over ridge.
	level notify("stop punishing");
}

snow_fx_back_on()
{
	getent ("anderson_out","targetname") waittill ("trigger");
	level thread maps\_atmosphere::_spawner();
}
//
// Mortar field between fences on the 2nd line.
//

mortar_field()
{
	level endon ("owned panzers go");
	getent ("mortar_field","targetname") thread line_death_field_think();
	
	//level thread punish_player(level.player, 0);
}

mortar_field_end()
{
	level waittill ("owned panzers go");
	getent ("mortar_field","targetname") maps\_utility_gmi::triggerOff();
}

//
// Own player for standing up outside of foxhole.
//

own_player()
{
	trigger = getent("own_player", "targetname");
	trigger waittill("trigger");
		
	while(level.player istouching(trigger))	
	{
		if (level.flags["battle_over"] == true)
		{
			println("^1breaking from loop due to battle over");
			trigger maps\_utility_gmi::triggerOff(); 
			break;
		}
		mg42s = getentarray("misc_turret","classname");
		level.player.threatbias = 20000;					
		println ("^3player getting OWNED");
		
		for (i=0;i<mg42s.size;i++)
		{
			if (!isdefined(mg42s[i].script_noteworthy))
			{
				mg42s[i] setturretaccuracy(0.9);
			}
		}
	
		wait 0.25;
	}	
		
	if (level.flags["battle_over"] == false)
	{
		level thread own_player();
	}
		
	level.player.threatbias = level.player.original_threatbias;
	println ("^2OWN THREAD IS OUT");
}

//
// Modulates the accuracy of the 50 cal turret so it doesnt own guys in the same place all the time.
//

fifty_cal_modulate()
{
	getent ("foxhole3_trig","targetname") waittill ("trigger");
	wanksta = getent ("50_cent","script_noteworthy");
	while (1)
	{
		wanksta setturretaccuracy(randomFloatRange(0.4, 1.0));
		wanksta setturretrange (randomintrange(1000,2200));
		wait 1;
	}
}

//
// Modulates range on halftrack turret.
//

mg42_halftrack_modulate()
{
	while (level.flags["foxholes_on"] == false)
	{
		println("^1 changing turret range");

		self.mgturret setturretrange(10000);
		wait randomintrange(2,5);
		self.mgturret setturretrange(100);
		wait randomfloatrange(0.5,1.0);	
		wait 0.1;
		if (level.flags["sniper_begin"] == true)
		{
			self.mgturret setturretrange(10000);
			break;
		}
	}
	self.mgturret setturretrange (10000);
}

//
// Modulates the accuracy of the 50 cal turret so it doesnt own guys in the same place all the time.
//

mg34_modulate()
{
	getent ("foxhole3_trig","targetname") waittill ("trigger");
	wanksta = getentarray ("mg_34","script_noteworthy");
	while (level.flags["mg42s_alive"] == false)
	{
		for (i=0;i<wanksta.size;i++)
		{
			wanksta[i] setturretaccuracy(randomFloatRange(0.05, 0.8));
			wanksta[i] setturretrange (100);
			wait randomintrange(2,3);
			wanksta[i] setturretrange (1000000);	
			wait randomintrange(2,3);
		}
	}
	
	for (i=0;i<wanksta.size;i++)
	{
		wanksta[i] setturretaccuracy(randomFloatRange(0.05, 0.1));
		wanksta[i] setturretrange (1000000);	
	}
}

//
// 30 cal killer
//

mg30cal_remover()
{
	cal = getent("mg_30cal_pickup","targetname");
	cal.old_origin = cal.origin;
	cal.origin = cal.origin - (0,0,200);
	
	level waittill ("remove 30 cal now");
	cal.origin = cal.old_origin;
	guy = getent("foxholeguy8","targetname");
	guy.health = 1;
	wait 0.5;
	mortar = getent ("mortar_foxhole3","targetname");
	mortar thread maps\_mortar_gmi::activate_mortar (100, 1000, 200, .3, 1, 1500);
	
	if (isalive(guy))
	{
		radiusDamage(guy.origin, 10, 10, 10);
	}
	
	mg30cal = getent("30cal_deleteable","targetname");
	wait 2;
	mg30cal delete();
}

//
// Mg 34 / 42 gun objectives
//

mg42_spawner_objective()
{
	level waittill ("mg42 obj spawn in");
	
	level.flags["mg42s_alive"] = true;
	
	//setCullFog (0, 9000, .68, .73, .85, 5 );				// So we can see snipers
	
	wait 5;
	
	spawn1 = getent("mg42_spawner_obj1","targetname");
	spawn2 = getent("mg42_spawner_obj2","targetname");
	foxhole_killmore_loc = getent("mortar_foxhole3","targetname");
	
	obj1 = spawn1 stalingradspawn();
	obj1 waittill("finished spawning");
	obj1.health = 200;
	obj2 = spawn2 stalingradspawn();
	obj2 waittill("finished spawning");
	obj2.health = 200;
	obj1 thread mg42_spawner_objective_think();
	obj2 thread mg42_spawner_objective_think();
	obj1 thread mg42_stay_mounted("jesse322");
	obj2 thread mg42_stay_mounted("jesse321");
	
	while (isalive(obj1) || isalive(obj2))
	{
		if (isalive(obj1) && isalive(obj2))
		{
			//objective_string(6, &"GMI_BASTOGNE1_OBJECTIVE_6_1");
		}
		else
		{
			objective_string(6, &"GMI_BASTOGNE1_OBJECTIVE_6_2");
		}
		level waittill("sniper died");
		wait 0.05;
	}
	
	//setCullFog (0, 6000, .68, .73, .85, 8 );				// Back to old cull fog
	
	objective_string(6, &"GMI_BASTOGNE1_OBJECTIVE_6_3");	
	level notify("objective_6_complete");
	level.flags["snipers_dead"] = true;
}

mg42_spawner_objective_think()
{
	self waittill("death");
	level notify("sniper died");
	level notify("objective_5a_complete");
}

mg42_stay_mounted(mgname)
{
	self endon ("death");
	
	mg34 = getent(mgname,"targetname");
	
	while (1)
	{
		self useturret(mg34);
		wait 1;
	}
}	

//
// Mg 42 killer
//

mg42_killer()
{
	mortar = getentarray("mg42_killer","targetname");
	
	for (i=0;i<mortar.size;i++)
	{
		mortar[i] thread maps\_mortar_gmi::activate_mortar (400, 1000, 1000, .3, 1, 1500);
	}
}

//
//
//
player_favorite()
{
	level endon ("stop finding favorite");
	trigger = getent("player_favorite","targetname");  
	while(1)  
	{  
     		trigger waittill("trigger");  
       
		axis_guys = getaiarray("axis");  
		for(i=0;i<axis_guys.size;i++)  
 		{  
			if(isdefined(axis_guys[i].favoriteenemy) && axis_guys[i].favoriteenemy == level.player)  
			{  
				continue;  
			}  
			else  
			{  
  				if(axis_guys[i] istouching(trigger))  
				{  
					axis_guys[i].favoriteenemy = level.player; 
					axis_guys[i] thread goto_player(12); 
				}  
			}  
		}  
		wait 0.5;
	}
}

goto_player(waittime)
{
	wait waittime;
	self.goalradius = 128;
	self setgoalentity(level.player);
}

//
// Keeps player alive while in the fox hole... takes threat off of player.
//

save_player()
{
	trigger = getent("player_save", "targetname");
	trigger waittill("trigger");
	level.player.original_threatbias = level.player.threatbias;
	
	while(level.player istouching(trigger))	
	{
		// MIkeD: Added to prevent the "kill player" mortar thread.
		level.flags["stop_kill_player_mortar"] = true;
		level.zone_timer = 0; // Reset the clock.

		mg42s = getentarray("misc_turret","classname");
		level.player.threatbias = -20000;					
		println ("^4player NOT getting OWNED");
			
		for (i=0;i<mg42s.size;i++)
		{
			if (!isdefined(mg42s[i].script_noteworthy))
			{
				mg42s[i] setturretaccuracy(0.03);
			}	
		}
			
		if (level.flags["battle_over"] == true)
		{
			break;
		}	
		wait 0.25;
	}
	
	if (level.flags["battle_over"] == false)
	{
		level thread save_player();
	}
	
	level.player.threatbias = level.player.original_threatbias;
	
	println ("^2SAVE THREAD IS OUT");
	
}

//
// Shock player
//
shock_player()
{
	getent ("shell_shocker","targetname") waittill ("trigger");
	org = getent("mortar_player","targetname");
	org maps\_mortar_gmi::activate_mortar (100, 0, 0, .7, 1, 1500);
	level.player shellshock("default", 3);	
	getent ("foxhole_pointer_friend","targetname") delete();
	getent ("foxhole_pointer","targetname") delete();
}

//
// Places to save the game.
//

save_game()
{
	getent ("in_barn","targetname") waittill ("trigger");
	maps\_utility_gmi::autosave(2);
	
	getent ("player_save","targetname") waittill ("trigger");
	getent("start_battle2","targetname") maps\_utility_gmi::triggerOn();
	wait 4;
	
	maps\_utility_gmi::autosave(3);
	
	level waittill ("objective_4_complete");
	maps\_utility_gmi::autosave(4);
	
	level waittill("objective_5_complete");
	maps\_utility_gmi::autosave(5);
	
	level waittill("objective_7_complete");
	maps\_utility_gmi::autosave(6);
}

//
// Ends the level.
//

level_end()
{
	level waittill("level win");
	missionSuccess("bastogne2", false);
}

//
// Delete AI that might be left over from rail.
//

delete_ai()
{
	
	ai = getaiarray("axis");
		
	for(i=0; i < ai.size; i++)
	{
		if (isalive(ai[i]))
		{
			ai[i] delete();
		}
	}
}

//
// Deletes ents marked as garbage. Mainly used for adding colmaps to level for vehicles.
//

garbage_man()
{
	garbage = getentarray("garbage","targetname");
	
	for(i=0;i<garbage.size;i++)
	{
		garbage[i] delete();
	}
}

//
// Map on table that moves around. FIX.
//

table_map_anim()
{
	map = getent("map", "targetname");
	map.animname = "map";
	map UseAnimTree(level.scr_animtree[map.animname]);
	
	table = getent ("table","targetname");
	map thread anim_loop_solo(map, "map_anim", undefined, "map stop anim", undefined);
}


//
// General chatter function, which can play for any team.
//

chatter_general(origin, numtimes, team, linker, wait_for)
{
	yell = spawn("script_origin",origin);

	if (isdefined(linker))
	{
		yell linkto(linker, "TAG_ORIGIN",  (0,0,0), (0,0,0));
	}
	
	if (isdefined (wait_for))
	{
		level waittill (wait_for);
	}

	for(i=0;i<numtimes;i++)
	{
		
		wait (randomfloatrange (1.5,3.0));	
		if (team == "ge")
		{
			yell playsound("generic_misccombat_german_"+ (randomint(3)+1));	
		}
		if (team == "us")
		{
			no_four_or_five = (randomint(6)+1);
			while ((no_four_or_five == 4) || (no_four_or_five == 5))
			{
				no_four_or_five = (randomint(6)+1);
			}	
			yell playsound("generic_misccombat_american_" + no_four_or_five);	
		}
		if (team == "br")
		{
			yell playsound("generic_misccombat_british_" + (randomint(6)+1));	
		}
		if (team == "ru")
		{
			yell playsound("generic_misccombat_russian_" + (randomint(6)+1));	
		}
	}
}


end_tank_roll_paths(start_node)
{
	waited = false;
	self.attachedpath = start_node;
	pathstart = self.attachedpath;

	if(!isdefined (pathstart))
	{
		println (self.targetname, " doesn't have an attached path");
		return;
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
		if(isdefined(pathpoints[i].script_noteworthy))
		{
			if(!(waited))
			{
				self setWaitNode(pathpoints[i]);
				self waittill ("reached_wait_node");
			}
			if (pathpoints[i].script_noteworthy == "roll_on")
			{
				self.rollingdeath = 1;
				println ("^1ROLL IS ON");
			}
			else if (pathpoints[i].script_noteworthy == "roll_off")
			{
				self.rollingdeath = 0;
				println ("^1ROLL IS OFF");
			}
		}
		waited = false;
	}
}

//
//
//

foxhole_safe_tracker()
{
	getent ("start_panzers","targetname") waittill ("trigger");

	level.flags["foxholes_on"] = true;
	
	fh1 = getent ("foxhole_safe1","targetname");
	fh2 = getent ("foxhole_safe2","targetname");
	fh3 = getent ("foxhole_safe3","targetname");
	
	level thread foxhole_safe(1,fh1);
	level thread foxhole_safe(2,fh2);
	level thread foxhole_safe(3,fh3);
	
	level.player.threatbias = 100;
}

//
// Keeps player safe in latter foxholes
//

foxhole_safe(number, trig)
{	
	trig waittill("trigger");
	
	tank = getent("endpanzer"+number,"targetname");
	
	original_bias = level.player.threatbias;
	
	if (number == 1)
	{
		num = "safe1";
	}
	if (number == 2)
	{
		num = "safe2";
	}
	if (number == 3)
	{
		num = "safe3";
	}
	
	while(level.player istouching(trig))
	{
		level.player.threatbias = -10000;
		
		if (level.flags[num] == false)
		{
			break;
		}
			
		wait 0.3;
		println("^2safe at the moment");
		level.flags["mg_mod"] = false;
	}
	
	level.player.threatbias = original_bias;
	
	if (level.flags[num] == true)
	{
		level thread foxhole_safe(number,trig);
	}
	
	level.flags["mg_mod"] = true;
	
	if (isalive(tank))
	{
		tank thread panzer_mg_modulate();
	}
		
	println("ending safe thread");
	
}


//
// Function to play a sound in space. Although in space, you can't hear anything. Weird.
//

playSoundinSpace (alias, origin)
{
	org = spawn ("script_origin",(0,0,1));
	org.origin = origin;
	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}

//
//
//

dragger_setup()
{	
	/*soldiers = getentarray("drag_spawners", "targetname");
	
	//getent ("foxhole1_trig","targetname") waittill ("trigger");
	
	println("size = "+soldiers.size);
	
	for (i=0;i<soldiers.size;i++)
	{
			guy = soldiers[i] stalingradSpawn();
			guy waittill ("finished spawning");
			guy.targetname = "jesse_drag";
	}*/	
}

pre_drag_node(node)
{
	//drag_spawners = getentarray ("drag_spawners","targetname");

	//getent ("foxhole1_trig","targetname") waittill ("trigger");
	
	//wait 0.5;
	
	soldiers = getentarray("drag_spawners", "targetname");
	
	//getent ("foxhole1_trig","targetname") waittill ("trigger");
	
	println("size = "+soldiers.size);
	
	for (i=0;i<soldiers.size;i++)
	{
			guy = soldiers[i] stalingradSpawn();
			guy waittill ("finished spawning");
			guy.targetname = "jesse_drag";
	}
	
	drag_guys = getentarray ("jesse_drag","targetname");
	println ("drag_Guys size ", drag_guys.size);
	
	org = getStartOrigin (node.origin, node.angles, %wounded_dragged_start);
	dragged = drag_guys[0];
	dragged.targetname = "dragged";
	dragged.ignoreme = true;
	dragged setgoalpos (org);
	dragged.goalradius = 32;
	dragged.health = 50000;
	dragged notify ("break_from_tradition");
	dragged thread drag_idle(node, %wounded_dragged_idle);
	
	org = getStartOrigin (node.origin, node.angles, %wounded_dragger_start);
	dragger = drag_guys[1];
	dragger.targetname = "dragger";
	dragger.ignoreme = true;
	dragger setgoalpos (org);
	dragger.goalradius = 32;
	dragger.health = 50000;
	dragger notify ("break_from_tradition");
	dragger thread drag_idle(node, %wounded_dragger_idle);
}

drag_idle(node, anima)
{
	level endon ("drag_time");
	while (1)
	{
		self animscripted("scriptedanimdone", node.origin, node.angles, anima);
		self waittill ("scriptedanimdone");
	}	
}

drag_node(node)
{
	getent ("foxhole2_trig","targetname") waittill ("trigger");
	
	//wait 1;
	
	drag_guys = getentarray ("jesse_drag","targetname");
	
	//drag_guys = getentarray (node.target,"targetname");

	dragged = getent ("dragged","targetname");
	/*if (!isAlive(dragged))
	{
		level notify ("wood_time");
		return;
	}*/
	
	dragger = getent ("dragger","targetname");
	/*if (!isAlive(dragger))
	{
		level notify ("wood_time");
		return;
	}*/
	
	org = getStartOrigin (node.origin, node.angles, %wounded_dragger_start);
	dragger allowedStances ("crouch");
	dragger.targetname = "dragger";
	dragged.targetname = "dragged";
	dragged thread drag_death( dragger );
	dragger thread drag_stopanim (dragged );
	//dragger thread newgoal();
//	dragged thread newgoal();
	dragger endon ("death");
	dragged endon ("death");
	dragged.health = 100;
	dragged.maxhealth = dragged.health * 20;
	dragger.health = 100;

	offset = (0, 0, 0);

//	dragged thread dragging_sequence_dialog(dragger);

	level notify ("drag_time");
	//dragger thread drag_mg42();

	dragger thread drag_vo(dragger);

	numcycles = 0;
	while ((dragger.origin[0] < 560))
	{
		numcycles++;
		println ("dragging guy");	
		dragger animscripted("scriptedanimdone", node.origin + offset, node.angles, %wounded_dragger_cycle);
		dragged animscripted("scriptedanimdone", node.origin + offset, node.angles, %wounded_dragged_cycle);
		dragger.deathanim = %wounded_dragger_death;
		dragged.deathanim = %wounded_dragged_death;
		dragger.allowDeath = 1;
		dragged.allowDeath = 1;
		dragger waittill ("scriptedanimdone");
		offset += getCycleOriginOffset(node.angles, %wounded_dragger_cycle);
		//wait 0.1;
		blah = 1;
		if (blah == 0)
		{
			wait 0.1;
		}
		if (numcycles == 25)
		{
			level.flags["dragger_dead"] = true;
		}
		if (level.flags["dragger_dead"] == true)
		{
			break;
		}
		
	}

	dragged kill_guy();
	dragger kill_guy();
/*	org = node.origin + offset;
	dragger animscripted("scriptedanimdone", org, node.angles, %wounded_dragger_end);
	dragged animscripted("scriptedanimdone", org, node.angles, %wounded_dragged_end);
	dragger.allowDeath = 1;
	dragged.allowDeath = 1;
	dragger waittill ("scriptedanimdone");

	//dragged notify ("made_it");
	//dragger notify ("made_it");
	dragger.pacifist = false;
	dragged.pacifist = false;
	dragged thread dragged_end_idle(org,node);*/
}

/*dragged_end_idle(org,node)
{
	self.health = 100;
	self.maxhealth = self.health * 20;
	while (distance (self.origin, level.player.origin) < 1800)
	{
		self animscripted("scriptedanimdone", org, node.angles, %wounded_dragged_endidle);
		self.allowDeath = 1;
		self waittill ("scriptedanimdone");
	}
	self delete();
}*/

drag_death(otherguy)
{
	self endon ("made_it");
	otherguy waittill ("death");

	self.health = 1;
	self kill_guy ();
}

drag_stopanim(otherguy)
{
	self endon ("made_it");
	otherguy waittill ("death");
	self stopanimscripted();
}

kill_guy()
{

	self DoDamage ( self.health + 50, self.origin );
	return;
	
	/*ai = getaiarray ("axis");
	for (i=0;i<ai.size;i++)
	{
		magicbullet ("mp40", self.origin + (10,10,100), self.origin + (0,0,20) );
		if (!isalive (self))
			return;
	}*/
}

drag_vo (attach)
{
	getent ("anderson_3","targetname") waittill ("trigger");
	attach playsound("medic_youre_ok");
}


// ****************************************
// Mortar based functions.
// ****************************************

//
// Changes: level.iStopBarrage2 = stopper;"name of script origins" = targets; level.mortar2 = level_mortar; level.mortar2_notify = mortar_notify;
//

mortar_general_distance (fRandomtime, iMaxRange, iMinRange, iBlastRadius, iDamageMax, iDamageMin, fQuakepower, iQuaketime, iQuakeradius, targetsUsed, seedtime, stopper, targets, level_mortar, mortar_notify, quakePower, fx, soundnum, sound_flag, dust_notify)
{
	// One mortar within iMaxRange distance goes off every (random + random) seconds but not within iMinRange units of the player
	// Terminate on demand by setting level.iStopBarrage != 0, operates indefinitely by default
	// Pass optional custom radius damage settings to activate_mortar()
	// Also pass optional custom earthquake settings to mortar_boom() via activate_mortar() if you want more shaking

	if (!isdefined(fRandomtime))
		fRandomtime = 7;
	if (!isdefined(iMaxRange))
		iMaxRange = 2200;
	if (!isdefined(iMinRange))
		iMinRange = 300;
	if (!isdefined(dust_notify))
		dust_notify = false;
	if (!isdefined(stopper))
	{
		stopper = 0;
	}

	if (!isdefined(targetsUsed))	//this allows railyard_style to get called again and not setup any terrain related stuff
		targetsUsed = 0;

	mortars = getentarray (targets,"targetname");
	lastmortar = -1;
	
	if ( !(isdefined (level_mortar) ) )
		maps\_utility_gmi::error ("level_mortar not defined. define in level script");

	if (isdefined(mortar_notify))
		level waittill (mortar_notify);
	while (stopper == 0)
	{
		if(isdefined(seedtime))
		{
			wait (seedtime + (randomfloat (fRandomtime) + randomfloat (fRandomtime) ));
		}
		else
		{
			wait (randomfloat (fRandomtime) + randomfloat (fRandomtime) );
		}

		r = randomint (mortars.size);

		for (i=0;i<mortars.size;i++)
		{
			c = (i + r) % mortars.size;
			//println ("current number: ", c);
			d = distance (level.player getorigin(), mortars[c].origin);
			if ( (d < iMaxRange) && (d > iMinRange) && (c != lastmortar ) )
			{
				mortars[c] activate_mortar(iBlastRadius, iDamageMax, iDamageMin, fQuakepower, iQuaketime, iQuakeradius, quakePower, fx, soundnum, sound_flag, dust_notify);
				lastmortar = c;
				break;
			}
		}
	}
}

//
// Used with ceiling barn dust functions.
//

activate_mortar (range, max_damage, min_damage, fQuakepower, iQuaketime, iQuakeradius, quakePower, fx, soundnum, sound_flag, dust_notify)
{
	incoming_sound(soundnum,sound_flag);

	level notify ("mortar");
	self notify ("mortar");

	if (!isdefined (range))
		range = 300;
	if (!isdefined (max_damage))
		max_damage = 400;
	if (!isdefined (min_damage))
		min_damage = 25;

	radiusDamage ( self.origin, range, max_damage, min_damage);

	if(isdefined(level.dummy_count) && level.dummy_count > 1 && range != 0)
	{
		dummies = getentarray("dummy","targetname");
		for(i=0;i<dummies.size;i++)
		{
			if(range <= 256)
			{
				range = 512;
			}
			if(distance(self.origin,dummies[i].origin) < range)
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
		self.hidden_terrain show();
	self.has_terrain = false;
	
	mortar_boom( self.origin, fQuakepower, iQuaketime, iQuakeradius, quakePower, fx, last_sound, sound_flag, dust_notify);
}

//
// level.mortar2_quake = quakePower; level.mortar2 = fx;
//

mortar_boom (origin, fPower, iTime, iRadius, quakePower, fx, last_sound, sound_flag, dust_notify)
{
	if(isdefined(quakePower))
	{
		fpower = quakePower;
	}
	else
	{ 
		if(!isdefined(fPower))
		{
			fPower = 0.15;
		}
	}


	if (!isdefined(iTime))
		iTime = 2;
	if (!isdefined(iRadius))
		iRadius = 850;

	mortar_sound(last_sound, sound_flag, dust_notify);
	playfx ( fx, origin );
	earthquake(fPower, iTime, origin, iRadius);
	
	// Special Burnville Shell shocking
	//if (level.script != "burnville")
		return;
	/*if (isdefined (level.playerMortar))
		return;
	if (distance (level.player.origin, origin) > 300)
		return;

	level.playerMortar = true;		
	level notify ("shell shock player",	iTime*4);
	maps\_shellshock_gmi::main(iTime*4);*/
}

//
// Changes: level.mortar2_last_sound is now last_sound; level.barn_sound = sound_flag
//

mortar_sound(last_sound, sound_flag, dust_notify)
{
	if (!isdefined (last_sound))
		last_sound = -1;

	soundnum = 0;
	while (soundnum == last_sound)
		soundnum = randomint(3) + 1;

	last_sound = soundnum;


	if(isdefined(sound_flag) && sound_flag == "barn")
	{
		if (soundnum == 1)
		{
			self playsound ("shell_explosion_muffled1");
			wait 0.35;
			self playsound ("dirt_fall");
			if (dust_notify == true)
			{
				level notify("dust falling");
				wait 1.5;
				level notify("dust over");
			}
		}
		else
		if (soundnum == 2)
		{
			self playsound ("shell_explosion_muffled2");
			wait 0.35;
			self playsound ("dirt_fall");
			if (dust_notify == true)
			{
				level notify("dust falling");
				wait 1.5;
				level notify("dust over");
			}
		}
		else
		{
			self playsound ("shell_explosion_muffled3");
			wait 0.35;
			self playsound ("dirt_fall");
			if (dust_notify == true)
			{
				level notify("dust falling");
				wait 1.5;
				level notify("dust over");
			}
		}
	}
	else
	{
		if (soundnum == 1)
		{
			self playsound ("shell_explosion1");
			wait 0.35;
			self playsound ("dirt_fall");
			if (dust_notify == true)
			{
				level notify("dust falling");
				wait 1.5;
				level notify("dust over");
			}
			
		}
		else
		if (soundnum == 2)
		{
			self playsound ("shell_explosion2");
			wait 0.35;
			self playsound ("dirt_fall");
			if (dust_notify == true)
			{
				level notify("dust falling");
				wait 1.5;
				level notify("dust over");
			}
		}
		else
		{
			self playsound ("shell_explosion3");
			wait 0.35;
			self playsound ("dirt_fall");
			if (dust_notify == true)
			{
				level notify("dust falling");
				wait 1.5;
				level notify("dust over");
			}
		}
	}
}

//
// Changes: sound_flag was level.barn_sound
//

incoming_sound(soundnum,sound_flag)
{
	if (!isdefined (soundnum))
	{
		soundnum = randomint(3) + 1;
	}

	if(isdefined(sound_flag) && sound_flag == "barn")
	{
		if (soundnum == 1)
		{
			self playsound ("shell_incoming_muffled1");
			wait (1.07 - 0.25);
		}
		else
		if (soundnum == 2)
		{
			self playsound ("shell_incoming_muffled2");
			wait (0.67 - 0.25);
		}
		else
		{
			self playsound ("shell_incoming_muffled3");
			wait (1.55 - 0.25);
		}
	}
	else
	{
		if (soundnum == 1)
		{
			self playsound ("shell_incoming");
			wait (1.07 - 0.25);
		}
		else
		if (soundnum == 2)
		{
			self playsound ("shell_incoming");
			wait (0.67 - 0.25);
		}
		else
		{
			self playsound ("shell_incoming");
			wait (1.55 - 0.25);
		}
	}
}

// *********************************************
// Animation Calls -- brought over from Trenches
// *********************************************

anim_loop ( guy, anime, tag, ender, node, tag_entity )
{
	maps\_anim_gmi::anim_loop ( guy, anime, tag, ender, node, tag_entity );
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

anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_loop ( newguy, anime, tag, ender, node, tag_entity );
}

anim_reach (guy, anime, tag, node, tag_entity)
{
	maps\_anim_gmi::anim_reach (newguy, anime, tag, node, tag_entity);
}

anim_reach_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_reach (newguy, anime, tag, node, tag_entity);
}



// *****************************************
// Tank firing utilites
// *****************************************

//
// Fires mg42s.
//

#using_animtree( "panzerIV" );
sherman_fireTank_mg42()
{	
	//self maps\_tankgun_gmi::mgoff();
	wait 5;
	
	while(self.isalive == 1)
	{	
		wait (4 + randomint (4));
		self maps\_tankgun_gmi::mgon();
		
		wait(4 + randomint (4));	
		self maps\_tankgun_gmi::mgoff();
		
		if (self.health == 0)
		{
			break;
		}
	}
}

//
// Fires Sherman Cannons. Fires roughly at AI.
//

sherman_fireTank_cannon()
{	
	while(self.isalive == 1)
	{
		ai = getaiarray("axis");
		
		if (ai.size > 0)
		{
			index = randomInt(ai.size);
			ai_guy = ai[index];
		}
		
		if (isdefined(ai_guy))
		{
			self setTurretTargetVec(ai_guy.origin+(0,0,16));
			self waittill("turret_on_target");
			wait randomIntRange(3,8);
			self endon("death");
			self FireTurret();
			self setAnimKnobRestart( %PanzerIV_fire );
		}
		else
		{
			break;
		}
	}		
}

//
// Fires Sherman Cannons. Fires roughly at AI.
//

sherman_fireTank_cannon_tank(tanktokill)
{	
	while(self.isalive == 1)
	{
		self setTurretTargetVec(tanktokill.origin+(0,0,20));
		self waittill("turret_on_target");
		self endon("death");
		self FireTurret();
		self setAnimKnobRestart( %PanzerIV_fire );
		if (!isalive(tanktokill))
		{
		    break;	
		}
		wait 2;
	}		
}

//
// Fires Panzer Cannons. Fires at predetermined targets.
//

panzer_fireTank_cannon()
{	
	self endon("death");
	owntime1 = 35000;
	owntime2 = 50000;
	rand = 15;	
	self endon("death");
	starttime = gettime();
	println("^1starttime: "+starttime);
	self endon("death");
	while(self.health > 0)
	{
		self endon("death");
		targets = getentarray("panzer_target", "targetname");
		self endon("death");
		target = targets[randomInt(targets.size)];
		self endon("death");
		index = randomint(rand);
		println("^3index: "+index);
		self endon("death");
		if (index == 0)
		{
			self endon("death");
			target = level.player;
			self endon("death");
		}
		
		self endon("death");
		if (self.health > 0)
		{
			self endon("death");
			self setTurretTargetVec(target.origin+(0,0,45));
			self endon("death");
			self waittill("turret_on_target");
			self endon("death");
			wait randomIntRange(2,5);
			self endon("death");
			self FireTurret();
			self endon("death");
			self setAnimKnobRestart( %PanzerIV_fire );
			self endon("death");
		}
		else
		{
			break;
		}
		self endon("death");
		newtime = gettime();
		if ((newtime - starttime) > owntime1)
		{
			rand = 7;
			println("^1rand: "+rand);
		}
		if ((newtime - starttime) > owntime2)
		{
			rand = 1;
			self maps\_tankgun_gmi::mgon();
			println("^1rand: "+rand);
		}
		
	}		
}

panzer_fireTank_cannon_at_trees()
{	
	self endon("death");
	getent ("tank2_burster","targetname") waittill ("trigger");
	
	target1 = getent("tank_burst1", "targetname");
	target2 = getent("tank_burst2", "targetname");
	
	self setTurretTargetVec(target1.origin);	
	self waittill("turret_on_target");
	self FireTurret();
	self setAnimKnobRestart( %PanzerIV_fire );
	
	wait 2;
	
	self setTurretTargetVec(target2.origin);
	self waittill("turret_on_target");
	self FireTurret();
	self setAnimKnobRestart( %PanzerIV_fire );		
}

//
// Being worked on....
//
panzer_mg_modulate()
{	
	tanks = [];
	for (i=0;i<level.tankcounter;i++)
	{
		tanks[i] = getent("endpanzer"+i,"targetname");
	}
	while(level.flags["mg_mod"] == true)
	{
		println("modulating");	
		
		if (isalive(tanks[i]))	
			self maps\_tankgun_gmi::mgon();
			
		wait randomint(5);
		
		if (isalive(tanks[i]))	
			self maps\_tankgun_gmi::mgoff();
			
		wait randomint(1,3);
	}
	if (isalive(tanks[i]))	
		self maps\_tankgun_gmi::mgoff();
}

//
// Smoke Event
//

smoke_axis()
{
	if (getcvar("scr_gmi_fast") != 0)
	{
		return;
	}
	
	smoke1 = getent("axis_smoke1","targetname");
	smoke1target = getent(smoke1.target,"targetname");
	smoke2 = getent("axis_smoke2","targetname");
	smoke2target = getent(smoke2.target,"targetname");
	smoke3 = getent("axis_smoke3","targetname");
	smoke3target = getent(smoke3.target,"targetname");
	smoke4 = getent("axis_smoke4","targetname");
	smoke4target = getent(smoke4.target,"targetname");
	smoke5 = getent("axis_smoke5","targetname");
	smoke5target = getent(smoke5.target,"targetname");
	
	getent ("foxhole3_trig","targetname") waittill ("trigger");
	maps\_fx_gmi::OneShotFx("gray_smoke", smoke1.origin, 0.1,smoke1target.origin);
	
	wait 4;
	maps\_fx_gmi::OneShotFx("gray_smoke", smoke2.origin, 0.1,smoke2target.origin);
	
	getent ("start_battle2","targetname") waittill ("trigger");
	maps\_fx_gmi::OneShotFx("gray_smoke", smoke3.origin, 0.1,smoke3target.origin);
	
	wait 10;
	maps\_fx_gmi::OneShotFx("gray_smoke", smoke4.origin, 0.1,smoke4target.origin);
	
	wait 35;
	maps\_fx_gmi::OneShotFx("gray_smoke", smoke5.origin, 0.1,smoke5target.origin);
}

final_allied_rush()
{	
	level waittill ("owned panzers go");
	allied_rush = getentarray("allied_rush","groupname");
	for(i=1; i<allied_rush.size+1; i++)		
	{
		spawnerer = getent("final_allied_rush"+i,"targetname");
		guy = spawnerer stalingradspawn();
		guy waittill("finished spawning");
		guy.goalradius = 4;
		guy allowedStances ("stand","crouch");
		
		node = getnode("final_allied_node_"+i,"targetname");
		guy setgoalnode(node);
		if (i == 3)
		{
			guy thread final_allied_rush_guy_3();
		}
	}
}

final_allied_rush_guy_3()
{
	self waittill ("goal");
	node = getnode("final_allied_node_3_1","targetname");
	self setgoalnode(node);
}

tank_fire_think_mg42()
{
	self endon ("death");
	while(isalive(self))
	{
		wait (5 + randomintrange (2,6));
		self maps\_tankgun_gmi::mgon();
		wait (1 + randomintrange (0,2));	
		self maps\_tankgun_gmi::mgoff();	
	}
}

friendly_damage_penalty()
{
	level thread moody_ender_ff();
	
	level endon ("anderson on the move");
	
	self waittill ("damage", dmg, who);
	
	if (who == level.player || who == level.jeep)
	{
		setCvar("ui_deadquote", "@SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
		missionfailed();
	}
}

moody_ender_ff()
{
	level endon ("anderson on the move");
	getent ("in_barn","targetname") waittill ("trigger");
	
	level.moody thread friendly_damage_penalty();
	level.ender thread friendly_damage_penalty();
}

path_spawners()
{
	level.putup_count = 0;
	getent("path1_trig","targetname") maps\_utility_gmi::triggerOff();
	getent("path2_trig","targetname") maps\_utility_gmi::triggerOff();
	level waittill ("smoke over");
	getent("path1_trig","targetname") maps\_utility_gmi::triggerOn();
	getent("path2_trig","targetname") maps\_utility_gmi::triggerOn();
	
	getent("path1_trig","targetname") waittill ("trigger");
	spawners = getentarray ("path_spawners1","targetname");
	
	for (i=0;i<spawners.size;i++)
	{
		guy = spawners[i] stalingradspawn();
		guy waittill ("finished spawning");
		guy setgoalnode (getnode("moody_to_ridge1","targetname"));
		guy.health = 1;
		guy.bravery = -100;
		//guy setgoalentity(level.moody);
	}
	
	getent("path2_trig","targetname") waittill ("trigger");
	spawners = getentarray ("path_spawners2","targetname");
	
	for (i=0;i<spawners.size;i++)
	{
		guy = spawners[i] stalingradspawn();
		guy waittill ("finished spawning");
		guy.spawner_name = spawners[i].script_noteworthy;
		guy.groupname = "path2ers";
		guy.goalradius = 4;
		//guy setgoalnode (getnode("moody_to_ridge2","targetname"));
		//guy.health = 1;
		guy.bravery = 50000;
		//guy setgoalentity(level.moody);
		guy thread path_spawner_death();
	}
	
}

path_spawner_death()
{
	//spawner_ent = getent(self.spawner_name,"targetname"); 
	self waittill ("death");
	level.putup_count++;
	//if (level.flags["no_more_path_spawn"] == false)
	//{
	//	guy = spawner_ent stalingradspawn(); 
	//	guy waittill ("finished spawning");
	//	guy thread path_spawner_death();
	//}
}

line_death_field()
{
	trigs = getentarray ("line_death_field","targetname");
	
	for (i=0;i<trigs.size;i++)
	{
		trigs[i] thread line_death_field_think();
	}
	
	trigs = getentarray ("line_zones","groupname");
	
	for (i=0;i<trigs.size;i++)
	{
		trigs[i] thread line_zone_field_think();
	}
	
}

line_zone_field_think()
{
	self endon("death");

	use_tracer = false;

	while(1)
	{
		self waittill ("trigger");
//		println(" -- ^2line_zone_field_think() Triggered! Trigger #: ");
	
		level.flags["stop_kill_player_mortar"] = false;
		
		//MikeD: Pummel player before killing him.

		level set_global_timer();
		if(level.flags["use_pummel_player"] == true)
		{
			if(level.flags["pummeling_player"] == true)
			{
				continue;
			}

			while((global_timer() > 0))
			{
				level.flags["pummeling_player"] = true;

				// Randomly choose a AI.
				axis = getaiarray("axis");
				if(axis.size > 1)
				{
					random_int = randomint(axis.size);
					use_origin = axis[random_int].origin;
					use_tracer = true;
				}
				else
				{
					use_origin =  level.player.origin;
					use_tracer = false;
				}
		
				dmg = 5 + randomint(10);
		
				println("^2 -- line_zone_field_think(): Damage: ", dmg, " ^2Timer: ", global_timer());

				if(use_tracer)
				{		
					bulletTracer((use_origin + (0,0,64)), (level.player.origin + ((16 - randomint(16)), (16 - randomint(16)), (16 - randomint(16)))));
				}

				level.player dodamage((5 + randomint(10)), use_origin);
				wait 0.1 + randomfloat(0.25);
			}

			level.flags["pummeling_player"] = false;
		}

//		println("^2level.flags['pummeling_player'] = ", level.flags["pummeling_player"]);

		if(level.flags["pummeling_player"] == true)
		{
			continue;
		}

//		println("^2level.flags['stop_kill_player_mortar'] = ", level.flags["stop_kill_player_mortar"]);
		// MikeD: Stops the mortar from firing, to support getting back to the foxhole.
		if(level.flags["stop_kill_player_mortar"] == true)
		{
			continue;
		}

//		println("^2global_timer : ", global_timer());
		// MikeD: Don't mortar the player just yet.
		// Make sure the global timer is 0 before.
		if((global_timer() > 0))
		{
			continue;
		}
		
		playfx (level.mortar ,level.player.origin);
		earthquake(0.5, 3, level.player.origin, 1000);
		level.player playsound ("shell_explosion1");
		level.player dodamage(level.player.health + 100, (0,0,0));
		
		println("^1line_ZONE_field_think(): Killing player (hit death brush)");
	}
}


set_global_timer()
{
	if(!isdefined(level.zone_timer))
	{
		level.zone_timer = 0;
	}

	if(level.zone_timer > gettime())
	{
		return;
	}

	level.zone_timer = gettime() + 3000;
	return;
}

global_timer()
{
	time = level.zone_timer - gettime();
	println("Global_Timer = ",time);
	return time;
}

// MikeD: If player hits these triggers, he dies instantly.
line_death_field_think()
{
	self endon("death");
	self waittill ("trigger");

	playfx (level.mortar ,level.player.origin);
	earthquake(0.5, 3, level.player.origin, 1000);
	level.player playsound ("shell_explosion1");
	level.player dodamage(level.player.health + 100, (0,0,0));
	
	println("^1line_DEATH_field_think(): Killing player (hit death brush)");
}

line_zone_logic()
{
	trigs = getentarray ("line_zones","groupname");
	
	for (i=0;i<trigs.size;i++)
	{
		trigs[i] maps\_utility_gmi::triggerOff();
	}
	
	level waittill ("anderson 1");
	wait 3;
	getent ("line_zone1","targetname") maps\_utility_gmi::triggerOn();
	
	level waittill ("anderson 3");
	getent ("line_zone2","targetname") maps\_utility_gmi::triggerOn();
	
	level waittill ("anderson 4");
	getent ("line_zone3","targetname") maps\_utility_gmi::triggerOn();
	
	level waittill ("anderson 5");
	getent ("line_zone4","targetname") maps\_utility_gmi::triggerOn();
	
	getent ("start_battle1","targetname") waittill ("trigger");		// Start of Battle 1
	
	// MikeD: Add so that the player will get battered with bullets before getting mortared.
	level.flags["use_pummel_player"] = true;

	getent ("line_zone5","targetname") maps\_utility_gmi::triggerOn();
	getent ("line_zone8","targetname") maps\_utility_gmi::triggerOn();
	getent ("line_zone9","targetname") maps\_utility_gmi::triggerOn();
	getent ("line_zone10","targetname") maps\_utility_gmi::triggerOn();
	wait 10;
	getent ("line_zone6","targetname") maps\_utility_gmi::triggerOn();
	getent ("line_zone7b","targetname") maps\_utility_gmi::triggerOn();
	
	level waittill("objective_4_complete");					// Moving to 30 cal event
	getent ("line_zone5","targetname") maps\_utility_gmi::triggerOff();
	getent ("line_zone6","targetname") maps\_utility_gmi::triggerOff();
	getent ("line_zone7b","targetname") maps\_utility_gmi::triggerOff();
	
	//level waittill ("moody back in action");
	wait 25;
	getent ("line_zone7","targetname") maps\_utility_gmi::triggerOn();
	wait 10;
	getent ("line_zone6","targetname") maps\_utility_gmi::triggerOn();
	wait 10;
	getent ("line_zone5b","targetname") maps\_utility_gmi::triggerOn();
	
	level waittill("kill more guys over");
	getent ("line_zone5b","targetname") maps\_utility_gmi::triggerOff();
	getent ("line_zone6","targetname") maps\_utility_gmi::triggerOff();
	
	level waittill ("moody to sniper hole");
	wait 20;
	getent ("line_zone5","targetname") maps\_utility_gmi::triggerOn();
	getent ("line_zone6b","targetname") maps\_utility_gmi::triggerOn();
	
	level  waittill("moody to ridge");
	getent ("line_zone6b","targetname") maps\_utility_gmi::triggerOff();
	getent ("line_zone7","targetname") maps\_utility_gmi::triggerOff();
	getent ("line_zone8","targetname") maps\_utility_gmi::triggerOff();
	getent ("line_zone9","targetname") maps\_utility_gmi::triggerOff();
	getent ("line_zone10","targetname") maps\_utility_gmi::triggerOff();
	
	//getent ("path2_trig","targetname") waittill ("trigger");
	level  waittill("moody fight over");
	wait 15;
	getent ("line_zone7","targetname") maps\_utility_gmi::triggerOn();
	
	//getent ("trigger_foxhole2","targetname") waittill ("trigger");
	wait 20;
	getent ("line_zone8","targetname") maps\_utility_gmi::triggerOn();
	
	//level waittill ("objective_7_complete");
	wait 20;
	getent ("line_zone9","targetname") maps\_utility_gmi::triggerOn();
	wait 30;
	getent ("line_zone10","targetname") maps\_utility_gmi::triggerOn();
}

own_chickenshit_player_think()
{
	println("^1Beginning Chickenshit");
	level endon("end chickenshit");
	old_time = gettime() / 1000;
	while(level.flags["end_chickenshit"] == false)
	{
		new_time = gettime() / 1000;
		if (new_time - old_time > 20)
		{
			level thread own_chickenshit_player();
		}
		if (level.player attackButtonPressed())
		{
			old_time = gettime() / 1000;	
			println("^1Time was: "+(new_time - old_time)+". New time assigned!");
		}
		wait 0.05;
	}
}

own_chickenshit_player()
{	
	playfx (level.mortar ,level.player.origin);
	earthquake(0.5, 3, level.player.origin, 1000);
	level.player playsound ("shell_explosion1");
	level.player dodamage(level.player.health + 100, (0,0,0));
	
	println("^1Killing player (didn't fight)");
	level notify ("end chickenshit");
	level.flags["end_chickenshit"] = true;
}

drone_control()
{
	if (getcvarint("scr_gmi_fast") > 1)
	{
		return;
	}
	
	anim_wait1 = [];
	anim_wait1[0] = 9;
	
	anim_wait2 = [];
	anim_wait2[0] = 10;
	
	anim_wait3 = [];
	anim_wait3[0] = 9;
	
	level waittill ("1: drone 2 go");
	level thread maps\bastogne1_dummies::dummies_setup((0,0,0), "xmodel/bastogne1_field_dummies2", 5, (0,180,0), 7, 1, "field_dummy_path2", true, "axis_drone", anim_wait2, true, gun_fire_notify, 1, true);
	
	level waittill ("1: drone 3 go");
	level thread maps\bastogne1_dummies::dummies_setup((0,0,0), "xmodel/bastogne1_field_dummies3", 5, (0,180,0), 7, 1, "field_dummy_path3", true, "axis_drone", anim_wait3, true, gun_fire_notify, 1, true);

	level waittill ("2: drone 1 go");	
	level thread maps\bastogne1_dummies::dummies_setup((0,0,0), "xmodel/bastogne1_field_dummies1", 5, (0,180,0), 7, 1, "field_dummy_path1", true, "axis_drone", anim_wait1, true, gun_fire_notify, 1, true);
	
	level waittill ("2: drone 2 go");
	level thread maps\bastogne1_dummies::dummies_setup((0,0,0), "xmodel/bastogne1_field_dummies2", 5, (0,180,0), 7, 1, "field_dummy_path2", true, "axis_drone", anim_wait2, true, gun_fire_notify, 1, true);
	
	level waittill ("3: drone 1 go");	
	level thread maps\bastogne1_dummies::dummies_setup((0,0,0), "xmodel/bastogne1_field_dummies1", 5, (0,180,0), 7, 1, "field_dummy_path1", true, "axis_drone", anim_wait1, true, gun_fire_notify, 1, true);

	level waittill ("3: drone 3 go");
	level thread maps\bastogne1_dummies::dummies_setup((0,0,0), "xmodel/bastogne1_field_dummies3", 5, (0,180,0), 7, 1, "field_dummy_path3", true, "axis_drone", anim_wait3, true, gun_fire_notify, 1, true);
	
}

/*battle_30cal_openpaths()
{	
	node1 = getnode("30cal_fork1","targetname");
	node2 = getnode("30cal_fork2","targetname");
	
	self.old_target = self.target;
	
	random_int = randomint(4);
	if (random_int == 0)
	{
		self setgoalnode(node1);
		self waittill ("goal");
		self setgoalnode(self.old_target,"targetname");
	}
	if (random_int == 1)
	{
		self setgoalnode(node2);
		self waittill ("goal");
		self setgoalnode(self.old_target,"targetname");
	}
	
}*/

foxhole_near_accuracy_debuff()
{
	self.old_accuracy = self.accuracy;
	level waittill ("debuff accuracy");
	self.accuracy = 0.1;
	level waittill ("buff accuracy");
	self.accuracy = self.old_accuracy;
}

axis_accuracy_buff()
{
	self.old_accuracy = self.accuracy;
	level waittill ("axis debuff accuracy");
	self.accuracy = 0.9;
	level waittill ("axis buff accuracy");
	self.accuracy = self.old_accuracy;
}

halftrack_blocker()
{
	//level waittill ("halftrack_blocker moved");
	halftrack_blocker = getent("halftrack_blocker","targetname");
	halftrack_blocker.origin = halftrack_blocker.origin + (0,0,-4000);
	level waittill ("halftrack_blocker moved");
	halftrack_blocker connectpaths();
}


ai_remover()
{
	self waittill ("death");
	if (self istouching(getent("start_battle2","targetname")))
	{
		wait 0.8;
		self delete();
	}
}

bazooka_filler()
{
	self endon ("death");
	while (isalive(self))
	{
		self.weapon = "bazooka";
		wait 0.05;
	}
}

friendly_cheer()
{
	ai = getaiarray("allies");
	
	for (i=0;i<ai.size;i++)
	{
		if (isalive(ai[i]))
		{
			if (!isdefined(ai[i].animname))
			{
				ai[i].animname = "cheerguy";
				ai[i] thread cheer_think();
			}
		}
	}
}

cheer_think()
{
	while (1)
	{
		randanim = randomint(9);
		randsound = randomint (3);
			
		self animscripted("animdone", self.origin, self.angles, level.scr_anim["cheerguy"]["cheer"][randanim]);
		self playsound ("us_cheer"+(randsound+1));
		self waittill("animdone");
	}
}

remove_smoke_minspec()
{
	if (getcvarint("scr_gmi_fast") > 1)
	{
		self waittill ("death");
		wait 12;
		stopattachedfx(self);
	}
}

hint_prints()
{
	getent ("start_battle2","targetname") waittill ("trigger");
	maps\_utility_gmi::keyHintPrint(&"GMI_BASTOGNE1_PICKUP_HINT", getKeyBinding("+activate"));
	wait 4;
	maps\_utility_gmi::keyHintPrint(&"GMI_BASTOGNE1_DEPLOY_HINT", getKeyBinding("toggle cl_run"));	
}

haystack_clips()
{
	getent("haystack1","targetname") thread haystack_clips_think1();
	getent("haystack2","targetname") thread haystack_clips_think2();
}

haystack_clips_think1()
{
	self waittill ("trigger");
	clip = getent("haystack_clip1","targetname");
	model = getent("hax1","groupname");
	
	wait 0.05;
	
	clip.origin = model.origin;
	clip.angles = model.angles;
	
}

haystack_clips_think2()
{
	self waittill ("trigger");
	clip = getent("haystack_clip2","targetname");
	model = getent("hax2","groupname");
	
	wait 0.05;
	
	clip.origin = model.origin;
	clip.angles = model.angles;
	
}