#using_animtree("generic_human");
main()
{
	thread stuff();
	setExpFog(0.00001, 0, 0, 0, 0);
	maps\_load::main();
	maps\_treadfx::main("night");
	maps\chateau_anim::main();
	maps\chateau_fx::main();
	maps\_truck::main();
	maps\_music::main();
	level.ambient_track ["exterior"] = "ambient_chateau_ext";
	level.ambient_track ["interior"] = "ambient_chateau_int";
	level.ambient_track ["jail"] = "ambient_chateau_jail";
	thread maps\_utility::set_ambient("exterior");
	thread music();
	
	// Model precaches
	precacheModel("xmodel/eaglebust");
	precacheModel("xmodel/explosivepack");
	precacheModel("xmodel/german_radio1_d");
	precacheModel("xmodel/german_radio2_d");
	precacheModel("xmodel/german_field_radio_d");

	character\foley::precache();
	character\moody::precache();
	character\price::precache();
	character\harding::precache();
	character\brooks::precache();

//	sound/music/chateau.wav

/*
	leftdoor = getent ("leftdoor","targetname");
	rightdoor = getent ("rightdoor","targetname");
	leftdoor rotateyaw(-90, 0.4,0,0);
	rightdoor rotateyaw(90, 0.4,0,0);
*/

	rotatingdoor = getent ("rotatingdoor","targetname");
	rotatingdoor rotateyaw(90, 0.4,0,0);

	leftshutter = getent ("leftshutter","targetname");
	rightshutter = getent ("rightshutter","targetname");
//	leftshutter notsolid();
//	rightshutter notsolid();
	leftshutter rotateyaw(-90, 0.4,0,0);
	rightshutter rotateyaw(90, 0.4,0,0);

	thread ai_overrides();
	thread truck_think(getent ("truck","targetname"));
	thread later_autosave (getent ("save trigger","targetname"));
	thread foley_breaks_off (getent ("foley breaks off","targetname"));
	thread foley_good_job();

//	thread german_truck(getent ("german truck","targetname"));
	maps\_utility::array_levelthread(getentarray ("truck attack","targetname"), ::german_truck);
	maps\_utility::array_thread(getentarray ("block","targetname"), ::deletion);
	maps\_utility::array_levelthread(getentarray ("playerseek","script_noteworthy"), ::playerseek);
	maps\_utility::array_levelthread(getentarray ("kick trigger","targetname"), ::kick_trigger);
	maps\_utility::array_levelthread(getentarray ("close door","targetname"), ::close_door);


	thread officer_debug (getent ("officer","script_noteworthy"));
	thread radio_door_trigger (getent ("radio room", "script_noteworthy"));
	thread foley_bomb_chat (getent ("friendly_dialogue","targetname"));
	flag_trigger (getent ("friendlies follow again","targetname"), "player passes bomb door");

	rotatingdoor = getent ("rotatingdoor","targetname");
	rotatingdoor rotateyaw(90, 0.4,0,0);
	rotatingdoor playsound ("wood_door_kick");

	array_thread (getentarray ("price trigger","targetname"), maps\_utility::triggerOff);
	array_levelthread (getentarray ("doortrigger","targetname"), ::doortriggerthread);
	array_levelthread (getentarray ("foley kick door","targetname"), ::foleytriggerthread);
	array_levelthread(getentarray ("trigger_multiple","classname"), ::preSpawnAlive);
	thread bomb_door ( getent ("bomb door","targetname"));
	thread windowTrigger (getent ("window_animation_trigger", "targetname"));

	player = getent("player", "classname" );
	level.currentspawner = 1;

	friends = getentarray ("friend", "targetname");
	for (i=0;i<friends.size;i++)
	{
		level thread friends_deathThread(friends[i]);
		friends[i].followmin = -5;
		friends[i].followmax = 2;
		friends[i].goalradius = (25);
	}

//	enemies = getentarray("enemy", "targetname");
//	for (i=0;i<enemies.size;i++)
//		enemies[i].goalradius = (64);

//    thread mg42stuff();

	level.flag["EnterGate"] = false;
	level.flag["EnterChateau"] = false;
	level.flag["TurnBust"] = false;
	level.flag["ComEquip1"] = false;
	level.flag["ComEquip2"] = false;
	level.flag["RescuePrice"] = false;
	level.flag["window_animation_trigger"] = false;
	level.flag["player passes bomb door"] = false;

//    radiosize = (getentarray ("obj3radio", "targetname")).size + (getentarray ("obj4radio", "targetname")).size;
	radiosize = 2;

	//Break through the main gate.
    objective_add(1, "active", &"CHATEAU_OBJ1", (getnode("obj1org", "targetname" )).origin);
    	//Find a way into the chateau.
	objective_add(2, "active", &"CHATEAU_OBJ2", (getnode("obj2org", "targetname" )).origin);

	objective_add(3, "active", &"CHATEAU_OBJ3", (getnode("obj3org", "targetname" )).origin);

	objective_add(4, "active", &"CHATEAU_OBJ4", (getent("obj4org", "targetname" )).origin);

	objective_add(5, "active", &"CHATEAU_OBJ5", (getnode("obj5org", "targetname" )).origin);

	objective_add(6, "active", &"CHATEAU_OBJ6", (getent("obj6org", "targetname" )).origin);

	objective_add(7, "active", &"CHATEAU_OBJ7", (getnode("window_animation2", "targetname" )).origin);

	thread objectives();
	if (getcvar("start") == "start")
		thread early_action();

	thread bust_trigger_thread(getent ("busttrigger","targetname"));

		//rotatingdoor bust busttrigger

//	savegame (("Chateau"), "Welcome to the Chateau");


	wait 0.15;

	if (getcvar("start") == "inside")
	{
		vec = (1144, -123, 198);
    	player setorigin (vec);
		friends = getentarray ("friend", "targetname");
		friends[0] teleport ((1520, 128, 176));
		friends[1] teleport ((1603, 140, 208));
		friends[2] teleport ((1496, 8, 208));
		friends[3] teleport ((1616, 40, 216));

		for (i=0;i<friends.size;i++)
		{
			friends[i] setgoalentity(getent("player","classname"));
			friends[i].goalradius = (800);
			friends[i].health = 50000;
		}

		level.flag["EnterGate"] = true;
		objective_current(2);
	}

	if (getcvar("start") == "bomb")
	{
		getent ("foley","targetname") delete();
		getent ("moody","targetname") delete();
//		array_thread (friends, ::delete);
		for (i=0;i<friends.size;i++)
			friends[i] delete();

		vec = (408, 1176, 62);
    	player setorigin (vec);
		level.flag["EnterGate"] = true;
		level.flag["EnterChateau"] = true;
		level.flag["TurnBust"] = true;
		level.flag["ComEquip1"] = true;
		level.flag["ComEquip2"] = true;

		objective_current(6);
	}
	if (getcvar("start") == "radio")
	{
		vec = (891, 1674, 200);
    	player setorigin (vec);
		level.flag["EnterGate"] = true;
		level.flag["EnterChateau"] = true;
		level.flag["TurnBust"] = true;
		objective_current(4);
	}

	if (getcvar("start") == "window")
	{
		leftshutter rotateyaw(90, 0.4,0,0);
		rightshutter rotateyaw(-90, 0.4,0,0);
		level.flag["EnterGate"] = true;
		level.flag["EnterChateau"] = true;
		level.flag["TurnBust"] = true;
		level.flag["ComEquip1"] = true;
		level.flag["ComEquip2"] = true;
		level.flag["RescuePrice"] = true;
		objective_current(7);


		vec = (307, 459, 184);
    	player setorigin (vec);
	}
}

music ()
{
	wait (0.05);
	track[0] = "datestamp";
	track[1] = "pf_stealth";
	track[2] = "redsquare_tense";
	track[3] = "redsquare_dark";

	musicPlay (track[0]);
	wait (level.musicLength[track[0]]);
	level waittill ("intro");
	musicPlay (track[1]);
	wait (level.musicLength[track[1]]);
	musicPlay (track[2]);
	wait (level.musicLength[track[2]]);
	musicPlay (track[3]);
	wait (level.musicLength[track[3]]);
	for (i=1;i<4;i++)
	{
		musicPlay (track[3]);
		wait (level.musicLength[track[3]]);
	}
	

}

windowTrigger ( trigger )
{
	trigger waittill ("trigger");
	flag_set("window_animation_trigger");
}


stuff ()
{
	level waittill ("starting final intro screen fadeout");
	println ("fadeout!");
}

foley_good_job ()
{
	level waittill ("foley good work");
	wait (1);
	chain = maps\_utility::get_friendly_chain_node ("50");
	level.player SetFriendlyChain (chain);
	maps\_utility::chain_off ("10");
}

ai_overrides ()
{
	spawners = getspawnerteamarray("axis");
	for (i=0;i<spawners.size;i++)
		spawners[i] thread spawner_overrides();

	ai = getaiarray("axis");
	for (i=0;i<ai.size;i++)
		ai[i].grenadeAmmo = 5;
//		ai[i] thread bloody_death_waittill();
//		level thread add_totalguys(ai[i]);
}

spawner_overrides ()
{
	while (1)
	{
		self waittill ("spawned", spawned);
		wait (0.05);
		if (issentient (spawned))
			spawned.grenadeAmmo = 5;
	}
}

deletion ()
{
	wait 1;
	self delete();
}

friends_deathThread ( guy )
{
	guy waittill ("death");
	level notify ("friend has died");
}

playerseek ( spawner )
{
	spawner waittill ("spawned", spawn);
	spawn endon ("death");
	wait (0.05);
	node = getnode (spawn.target,"targetname");
	spawn.goalradius = 512;
	spawn setgoalnode (node);
	spawn waittill ("goal");
	spawn.pacifist = false;
	spawn setgoalentity (level.player);
}

later_autosave ( trigger )
{
	trigger maps\_utility::triggerOff();
	level waittill ("autosave objective");
	trigger maps\_utility::triggerOn();
	trigger waittill ("trigger");
	// Before kick door
	maps\_utility::autosave(3);
	trigger delete();
}

officer_debug (spawner)
{
	spawner waittill ("spawned",spawn);
	spawn endon ("death");
	wait (0.05);
	spawn.bravery = 50000000;
	node = getnode (spawn.target,"targetname");
	spawn setgoalnode (node);
//	spawn waittill ("goal");
	spawn.animname = "officer";
	spawn.allowdeath = true;
	spawn maps\_utility::lookat (level.player);
	guy[0] = spawn;
	spawn thread anim_loop ( guy, "idle", undefined, "damage", node);
	wait (20);
	spawn notify ("damage");

//	println ("SPAWNED THE OFFICER");
//	spawn maps\_utility::debug_message ("officer", 10000);
}

radio_door_trigger ( trigger )
{
	level waittill ("destroyed equipment");
	trigger notify ("trigger");
}

close_gate ( trigger )
{
	trigger waittill ("trigger");
	level notify ("close gate");
}

open_gate ()
{
	leftgate = getent ("gate left","targetname");
	rightgate = getent ("gate right","targetname");
	leftgate connectpaths();
	rightgate connectpaths();
	leftgate rotateyaw(90, 0.4,0.1,0.1);
	rightgate rotateyaw(-90, 0.4,0.1,0.1);
	maps\_utility::array_levelthread(getentarray ("close gate","targetname"), ::close_gate);
	level waittill ("close gate");
	leftgate rotateyaw(-90, 0.4,0.1,0.1);
	rightgate rotateyaw(90, 0.4,0.1,0.1);
	wait (2);
	leftgate disconnectpaths();
	rightgate disconnectpaths();
}

german_truck (trigger)
{
	trigger waittill ("trigger");
	if ((isdefined (trigger.script_noteworthy)) && (trigger.script_noteworthy == "open gate"))
		thread open_gate();

	truck = getent (trigger.target,"targetname");

//	getent ("german truck clip","targetname") notsolid();
	driver = getent (truck.target,"targetname");
//	if (isdefined (driver))
//		driver thread driver_kill (truck);

//	truck.treaddist = 30;
	truck maps\_truck::init();
	truck maps\_truck::attach_guys(undefined,driver);
	path = getVehicleNode(truck.target,"targetname");

	truck attachpath (path);
	truck startPath();
	node = path;
	while (1)
	{
		node = getvehiclenode (node.target,"targetname");
		truck setWaitNode (node);
		truck waittill ("reached_wait_node");
		if (isdefined (node.script_noteworthy))
			break;
	}

	truck thread maps\_utility::playSoundOnTag("stop_skid", "tag_origin");
	truck notify ("unload");
	truck stopEngineSound();
	truck waittill ("reached_end_node");
	truck disconnectpaths();
	wait (2);
	println ("Truck origin: ", truck.origin, " truck angles: ", truck.angles);
}

priceTriggerSpawner ( spawner, trigger )
{
	if (spawner.count == 0)
	{
		trigger.totalSpawners--;
		trigger notify ("finished spawning");
		return;
	}
	
	spawner waittill ("spawned",spawn);
	if (maps\_utility::spawn_failed(spawn))
	{
		trigger.totalSpawners--;
		trigger notify ("finished spawning");
		return;
	}

	trigger.totalSpawners--;
	trigger.totalSpawnedGuys++;
	trigger notify ("finished spawning");

	spawn waittill ("death");
	trigger.totalSpawnedGuys--;
	trigger notify ("spawn died");
}

priceTriggerOn ( trigger )
{
	spawners = getentarray (trigger.target,"targetname");
	trigger.totalSpawnedGuys = 0;
	trigger.totalSpawners = spawners.size;
	array_levelthread (spawners, ::priceTriggerSpawner, trigger);
	trigger maps\_utility::triggeron();
}

ptriggerTalk ( trigger, type )
{
	level endon ("stop triggertalk");
	level notify ("stop triggertalk");
	setcvar ("ptrigger", "");
	while (1)
	{
		if (getcvar ("ptrigger") == "")
		{
			wait (0.5);
			continue;
		}

		setCvar ("ptrigger", "");		
		if (type == "spawners")
			println ("^6 Spawners left: ", trigger.totalSpawners);
		
		if (type == "spawnedguys")
			println ("^6 SpawnerGuys left: ", trigger.totalSpawnedGuys);
	}
}

ptrigger (price, trigger)
{
	node = getnode (trigger.target,"targetname");
	price setgoalnode (node);
	price.goalradius = 32;

	thread ptriggerTalk (trigger, "spawners");
	while (trigger.totalSpawners > 0)
		trigger waittill ("finished spawning");

	thread ptriggerTalk (trigger, "spawnedguys");
	while (	trigger.totalSpawnedGuys > 0 )
		trigger waittill ("spawn died");

	level notify ("stop triggertalk");
	
	node = getnode (node.target,"targetname");
	price setgoalnode (node);
}

bravery_spawn ()
{
	self waittill ("spawned",spawn);
	if (maps\_utility::spawn_failed(spawn))
		return;

	spawn.bravery = 500000;
}

kick_trigger ( trigger )
{
	targets = getentarray (trigger.target,"targetname");
	for (i=0;i<targets.size;i++)
	{
		if (targets[i].classname != "script_brushmodel")
			continue;
			
		targets[i] disconnectpaths();
	}

	doors = [];
	kickers = [];
	for (i=0;i<targets.size;i++)
	{
		if (targets[i].classname == "script_brushmodel")
		{
			doors[doors.size] = targets[i];
			if (!isdefined (targets[i].target))
				continue;

			if (isdefined (targets[i].target))
			{
				doortargs = getentarray (targets[i].target,"targetname");
				
				for (p=0;p<doortargs.size;p++)
				{
					if (doortargs[p].classname == "trigger_multiple")
					{
						doorBlocker = doortargs[p];
						continue;
					}
					
					doortargs[p] linkto (targets[i]);
				}
			}
		}
		else
		{
			targets[i] thread bravery_spawn();
			if (!isdefined (targets[i].target))
				continue;

			node = getnode (targets[i].target, "targetname");
			if (!isdefined (node))
				continue;
			if (!isdefined (node.script_noteworthy))
				continue;

			if (node.script_noteworthy != "kick")
				continue;

			kickers[kickers.size] = targets[i];

			targets[i].count = 0;
			targets[i].origin = node.origin;
			targets[i].angles = node.angles;
		}
	}

	trigger waittill ("trigger");
	println ("door size is ", doors.size);
	
	if (isdefined (doorBlocker))
	{
		while (level.player istouching (doorBlocker))
			wait (0.1);
	}

	if (kickers.size > 0)
	{
		for (i=0;i<kickers.size;i++)
			thread kick_anim( kickers[i], trigger );

		trigger waittill ("kick!");
	}

	for (i=0;i<doors.size;i++)
	{
		doors[i] connectpaths();
		if (doors[i].script_noteworthy == "left door")
			doors[i] thread rotateyawPain(-90, 0.4,0.05,0.05);
		else
			doors[i] thread rotateyawPain(90, 0.4,0.05,0.05);

		doors[i].opened = true;
	}
	doors[0] playsound ("wood_door_kick");
}

rotateyawPain (angle, time, in, out)
{
	self rotateyaw(angle, time, in, out);
	self thread hurtPlayer();
	wait (time);
	while ((distance (level.player.origin, self getorigin())) < 75)
		wait (0.05);

	self notify ("stop hurting player");
}

hurtPlayer ()
{
	self endon ("stop hurting player");
	while (1)
	{
		if ((distance (level.player.origin, self getorigin())) < 75)
			level.player DoDamage ( 25, self.origin );
		wait (0.5);
	}
}

close_door ( trigger )
{
	trigger waittill ("trigger");
	targets = getentarray (trigger.target,"targetname");
	for (i=0;i<targets.size;i++)
	{
		if (!isdefined (targets[i].opened))
			continue;

		if (targets[i].script_noteworthy == "left door")
			targets[i] rotateyaw(90, 0.4,0.05,0.05);
		else
			targets[i] rotateyaw(-90, 0.4,0.05,0.05);
	}
	targets[0] playsound ("wood_door_kick");

	wait (1);
	for (i=0;i<targets.size;i++)
	{
		if (!isdefined (targets[i].opened))
			continue;

		targets[i] disconnectpaths();
		targets[i].opened = undefined;
	}
}

kick_anim (spawner, trigger)
{
	spawner.count = 1;
	spawn = spawner stalingradspawn();
	spawn.animname = "generic";
	spawn.allowDeath = true;
	node = getnode (spawn.target,"targetname");
	guy[0] = spawn;
	if (randomint (100) > 50)
		thread anim_single (guy, "kick door 1", undefined, node);
	else
		thread anim_single (guy, "kick door 2", undefined, node);
	spawn waittillmatch ("single anim", "kick");
	trigger notify ("kick!");
	if (isdefined (node.target))
		node = getnode (node.target,"targetname");

	spawn setgoalnode (node);
	if (isdefined (node.radius))
		spawn.goalradius = node.radius;
}

doortriggerthread( trigger )
{
	targets = getentarray (trigger.target,"targetname");
	for (i=0;i<targets.size;i++)
	{
		if (targets[i].classname != "script_brushmodel")
			continue;
			
		targets[i] disconnectpaths();
	}
	
	trigger maps\_utility::triggeroff();
	level waittill ("door open" + trigger.script_noteworthy);
	trigger maps\_utility::triggeron();

	targets = getentarray (trigger.target,"targetname");
	doors = [];
	for (i=0;i<targets.size;i++)
	{
		if (targets[i].classname == "script_brushmodel")
		{
			targets[i] connectpaths();
			doors[doors.size] = targets[i];
			if (isdefined (targets[i].target))
			{
				doortargs = getentarray (targets[i].target,"targetname");
				println ("targets origin :", targets[i].origin);
				for (p=0;p<doortargs.size;p++)
					doortargs[p] linkto (targets[i]);
			}
		}
		else
		{
			if (!isdefined (targets[i].target))
				continue;

			node = getnode (targets[i].target, "targetname");
			if (!isdefined (node))
				continue;
			spawner = targets[i];
			spawner.count = 0;
		}
	}

	trigger waittill ("trigger");
	if (isdefined (spawner))
	{
		spawner.count = 1;
		spawn = spawner stalingradspawn();
		spawn.animname = "generic";
		spawn.allowDeath = true;

		guy[0] = spawn;
		//anim_single (guy, anime, tag, node, tag_entity)
		if (randomint (100) > 50)
			thread anim_single_solo (spawn, "kick door 1", undefined, node);
		else
			thread anim_single_solo (spawn, "kick door 2", undefined, node);
		spawn waittillmatch ("single anim", "kick");
	}

	for (i=0;i<doors.size;i++)
	{
		println ("door noteworthy ", doors[i].script_noteworthy);
		if (doors[i].script_noteworthy == "left door")
			doors[i] rotateyaw(-90, 0.4,0.05,0.05);
		else
			doors[i] rotateyaw(90, 0.4,0.05,0.05);
	}
	doors[0] playsound ("wood_door_kick");
}

foleytriggerthread( trigger )
{
	targets = getentarray (trigger.target,"targetname");
	for (i=0;i<targets.size;i++)
	{
		if (targets[i].classname != "script_brushmodel")
			continue;
			
		targets[i] disconnectpaths();
	}

	trigger maps\_utility::triggeroff();
	level waittill ("door open" + trigger.script_noteworthy);
	trigger maps\_utility::triggeron();

	targets = getentarray (trigger.target,"targetname");
	doors = [];
	for (i=0;i<targets.size;i++)
	{
		if (targets[i].classname == "script_brushmodel")
		{
			targets[i] connectpaths();
			doors[doors.size] = targets[i];
			if (isdefined (targets[i].target))
			{
				doortargs = getentarray (targets[i].target,"targetname");
				for (p=0;p<doortargs.size;p++)
					doortargs[p] linkto (targets[i]);
			}
		}
		else
		{
			if (!isdefined (targets[i].target))
				continue;

			node = getnode (targets[i].target, "targetname");
			if (!isdefined (node))
				continue;
			spawner = targets[i];
			spawner.count = 0;
		}
	}

	trigger waittill ("trigger");
	
	foleySpawner = getent ("foley bomber", "targetname");
	while (1)
	{
		foleySpawner.count = 1;
		foley = foleySpawner dospawn();
		if (!maps\_utility::spawn_failed(foley))
			break;

		wait (1);
	}

	foley thread maps\_utility::magic_bullet_shield();
	foley character\_utility::new();
	foley character\foley::main();
	foley.animname = "foley";
	level.foley = foley;

	moodySpawner = getent ("moody bomber", "targetname");
	while (1)
	{
		moodySpawner.count = 1;
		moody = moodySpawner dospawn();
		if (!maps\_utility::spawn_failed(moody))
			break;

		wait (1);
	}
	moody thread maps\_utility::magic_bullet_shield();
	moody character\_utility::new();
	moody character\moody::main();
	moody.animname = "moody";
	level.moody = moody;
	moody setgoalentity (level.player);
	moody.goalradius = 400;

	node = getnode ("foley kick","targetname");
	foley setgoalnode (node);
	foley.goalradius = 384;
//	foley animscripts\face::SaySpecificDialogue(undefined, level.scrsound["foley"]["good job"], 1.0);
	foley anim_single_solo (foley, "good job");
	
	foley anim_reach_solo (foley, "kick door 1", undefined, node);
	foley thread anim_single_solo (foley, "kick door 1", undefined, node);
	foley waittillmatch ("single anim", "kick");
	if (isdefined (spawner))
	{
		spawner.count = 1;
		spawn = spawner stalingradspawn();
	}

	for (i=0;i<doors.size;i++)
	{
		if (doors[i].script_noteworthy == "left door")
			doors[i] rotateyaw(-90, 0.4,0.05,0.05);
		else
			doors[i] rotateyaw(90, 0.4,0.05,0.05);
	}
	doors[0] playsound ("wood_door_kick");
	foley setgoalentity (level.player);
	foley.goalradius = 400;
	maps\_utility::chain_off ("100");
	
	if (getcvar ("start") == "bomb")
	{
		level notify ("start bomb notify");
		return;
	}
		
	chain = maps\_utility::get_friendly_chain_node ("110");
	level.player SetFriendlyChain (chain);
	
}

foley_bomb_chat ( trigger )
{
	while (1)
	{
		trigger waittill ("trigger", other);
		if (other.animname == "foley")
			break;
	}
	
//	level.foley animscripts\face::SaySpecificDialogue(undefined, level.scrsound["foley"]["bomb quote"], 1.0);
	foley anim_single_solo (foley, "bomb quote");
}


doortriggerskipthread()
{
	targets = getent (self.target,"targetname");
	for (i=0;i<targets.size;i++)
	if (targets[i].classname == "script_brushmodel")
	{
		targets[i] connectpaths();

		if (targets[i].script_noteworthy == "left door")
			targets[i] rotateyaw(-90, 0.4,0.05,0.05);
		else
			targets[i] rotateyaw(90, 0.4,0.05,0.05);

		targets[i] playsound ("wood_door_kick");
	}
	else
	if (targets[i].classname == "actor_protogerman")
		targets[i].count = 0;
}

bust_trigger_thread (trigger)
{
	targ = getent (trigger.target,"targetname");
	targ.targetname = "bust";
	door = getent ("rotatingdoor","targetname");

	trigger setHintString(&"CHATEAU_BUSTS");
	trigger waittill ("trigger");
	trigger delete();
	level notify ("obj4");
	busts = getentarray ("bust","targetname");
	for (i=0;i<busts.size;i++)
		busts[i] setmodel ("xmodel/eaglebust");

	targ playsound ("misc_bust");

	targ rotateyaw(45, 1,0.25,0.25);
	wait (1);
	door playsound ("misc_noise");
	wait (3);
	door playsound ("misc_turn");
	door rotateyaw(-91, 3,1,0);
	wait (3);
	door rotateyaw(1, 0.1,0,0);
	// change sound here
	door playsound ("fireplace_stop");
}

objectives ()
{
	objective_current(1);
	thread node_trigger (1);
	thread node_trigger (2);
	thread node_trigger (3);
	thread node_trigger (4);
	thread node_trigger (5);
	thread node_trigger (6);
}

radio_thread (nodenum)
{
	level.radio[nodenum]++;
	self waittill ("trigger");
	println ("got shot!");
	level.radio[nodenum]--;
	println ("radio ", level.radio[nodenum]);
	if (!level.radio[nodenum])
		level notify ("obj" + nodenum);

	ent = getent (self.target,"targetname");

	println (ent.model);
	if (ent.model == "xmodel/objective_german_radio1")
	{
		ent setmodel ("xmodel/german_radio1_d");
		println ("set model radio d");
	}
	if (ent.model == "xmodel/objective_german_radio2")
		ent setmodel ("xmodel/german_radio2_d");
	if (ent.model == "xmodel/objective_german_field_radio")
		ent setmodel ("xmodel/german_field_radio_d");

	ent playsound ("explo_radio");

	maps\_fx::GrenadeExplosionfx(ent.origin);

	if (isdefined (ent.target))
	{
		children = getentarray (ent.target, "targetname");

		for (i=0;i<children.size;i++)
			children[i] delete();
	}

//	level thread objupdate();
	self delete();
}

objupdate()
{
	wait 0.25;
	radiosize = 0;

	if (!level.flag["ComEquip1"])
		radiosize++;

	if (!level.flag["ComEquip2"])
		radiosize++;

	objective_string(4, &"CHATEAU_OBJ4COUNT",radiosize);
}

foley_breaks_off ( trigger )
{
	trigger waittill ("trigger");
	nextTrigger = getent (trigger.target,"targetname");
	nodes = getnodearray (trigger.target,"targetname");
	trigger delete();

	foley = getent ("foley","targetname");
	moody = getent ("moody","targetname");

	foley setgoalentity (level.player);
	foley.followmin = 5;
	foley.followmax = 1;
	foley.goalradius = 200;	
	//	Martin, get in there, grab any docs, knock out their communications, then meet back up with us.  Sergeant Moody and I will find Price and Ingram."
	foley thread anim_single_solo ( foley, "split up" );
	foley waittill ("split up");

	foley setgoalnode (nodes[0]);
	foley.goalradius = 32;
	moody setgoalnode (nodes[1]);
	moody.goalradius = 32;

	nextTrigger waittill ("trigger");
	foley delete();
	moody delete();
}

bomb_door ( trigger )
{
	if (getcvar ("start") == "bomb")
	{
		doortrig = getent ("foley kick door","targetname");
		level notify ("door open" + doortrig.script_noteworthy);
		wait (0.05);
		doortrig notify ("trigger");
		level waittill ("start bomb notify");
	}

	spawners = getentarray ("bomb spawners","targetname");
	waitUntilSpawnedDie(spawners);

	thread priceRescue (getent ("obj6","targetname"));

	node = getnode ("explodeguy1","targetname");
	guy[0] = level.foley;
	guy[1] = level.moody;
	println ("^3 Time to reach the goal!");
	anim_pushPlayer (guy);
	anim_reach (guy, "bomb", undefined, node);
	// Planting bombs
	maps\_utility::autosave(6);
	anim_dontPushPlayer (guy);
	anim_single (guy, "bomb", undefined, node);
	leftdoor = getent ("leftdoor","targetname");
	rightdoor = getent ("rightdoor","targetname");

	leftdoor connectpaths();
	rightdoor connectpaths();
	leftdoor rotateyaw(90, 0.4,0.1,0.1);
	rightdoor rotateyaw(-90, 0.4,0.1,0.1);

	level.foley setgoalnode (getnode ("foley bomb node","targetname"));
	level.moody setgoalnode (getnode ("moody bomb node","targetname"));
	level.foley.goalradius = 64;
	level.moody.goalradius = 64;
	wait (0.4);
	leftdoor disconnectpaths();
	rightdoor disconnectpaths();
	wait (2);
	flag_wait ("player passes bomb door");
	level.foley setgoalentity (level.player);
	level.moody setgoalentity (level.player);
}

waitSpawnedThink ( spawner, ent )
{
	wait (0.05);
	if (spawner.count == 0)
	{
		ent notify ("spawn died");
		return;
	}
	
	spawner waittill ("spawned",spawn);
	if (maps\_utility::spawn_failed(spawn))
	{
		ent notify ("spawn died");
		return;
	}
	spawn waittill ("death");
	ent notify ("spawn died");
}

waitUntilSpawnedDie ( spawners )
{
	ent = spawnstruct();
	array_levelthread (spawners, ::waitSpawnedThink, ent);
	for (i=0;i<spawners.size;i++)
		ent waittill ("spawn died");
}

node_trigger (nodenum) // objectives
{
	if (nodenum < 7)
	{
//		objective_current(nodenum);
		if ((nodenum != 4) && (nodenum != 5))
		{
			trigger = getent (("obj" + nodenum), "targetname");
			if (nodenum == 3)
				trigger setHintString(&"SCRIPT_HINTSTR_DOCUMENTS");
				
			trigger waittill("trigger");
			level notify ("completed objective " + nodenum);
	
			if (nodenum == 3)
			{
				triggertarg = getent (trigger.target,"targetname");
				thread maps\_utility::playsoundinspace ("paper_pickup",triggertarg.origin);
			}
			
			if (isdefined (trigger.target))
			{
				triggertargs = getentarray (trigger.target,"targetname");
				for (i=0;i<triggertargs.size;i++)
					triggertargs[i] delete();
			}
		}
		else
		{
			if (nodenum == 4)
				level waittill ("obj" + nodenum);
			else
			{
				level.radio[nodenum] = 0;
				trigger = getentarray (("obj" + nodenum + "radio"), "targetname");
				for (i=0;i<trigger.size;i++)
					trigger[i] thread radio_thread (nodenum);

				level waittill ("obj" + nodenum);
			}
		}

		if (nodenum == 1)
		{
			// After you enter the area
			maps\_utility::autosave(1);
//			savegame (("Chateau" + nodenum), "Entering Chateau Grounds");
			level.flag["EnterGate"] = true;
		}

		level notify ("door open"+nodenum);

		if (nodenum == 2)
		{
//			savegame (("Chateau" + nodenum), "Inside the Chateau");
			// Once you get in
			maps\_utility::autosave(2);

			level.flag["EnterChateau"] = true;
			friends = getentarray ("friend", "targetname");

			/*
			p = 0;
			doornum = 1;
			for (i=0;i<friends.size;i++)
			{
				if (!isalive(friends[i]))
					continue;

				if (!isdefined (friends[i].script_noteworthy))
					continue;

				if (friends[i].script_noteworthy != "hold door")
					continue;

				friends[i].followmin = -5;
				friends[i].followmax = 3;
				friends[i].goalradius = (256);

				friends[i].goalradius = (25);
				friends[i] setgoalnode(getnode("guy"+doornum,"targetname"));
				friends[i] thread seekplayer();

				doornum++;
				if (doornum >= 3)
					break;
			}
			*/
		}

		if (nodenum == 3)
		{
			level.flag["ComEquip1"] = true;
//			savegame (("Chateau" + nodenum), "Documents Obtained");
			level notify ("autosave objective");
			trigger delete();
		}

		if (nodenum == 4)
			level.flag["TurnBust"] = true;

		if (nodenum == 5)
		{
			// Destroyed equipment
			maps\_utility::autosave(5);
			level.flag["ComEquip2"] = true;
			level notify ("destroyed equipment");
		}

		if (nodenum == 6)
		{
			level notify ("spawn truck");
//			getent ("truck","targetname") show();
//			truckclip = getent ("truckclip","targetname");
//			truckclip.origin = (getent ("truck","targetname")).origin;
		}

		objective_state(nodenum, "done");
		objective_current(nodenum+1);
	}
}

truck_think ( truck )
{
	org = truck.origin;
	ang = truck.angles;

	truck delete();

	level waittill ("spawn truck");
	path = getvehiclenode ("truck path","targetname");
	truck = spawnVehicle( "xmodel/vehicle_german_truck", "truck" , "germanfordtruck", (0,0,0), (0,0,0) );
	truck attachPath( path );
	truck startPath();
}

priceRescue ( trigger )
{
//	spawner = getent ("price","targetname");
	while (1)
	{
		price = getent ("price", "targetname") dospawn();
		if (!maps\_utility::spawn_failed(price))
			break;

		wait (1);
	}
	price endon ("death");
	node = getnode ("prisoner","targetname");
	price.animname = "price";
	price.allowdeath = true;
	price thread anim_loop_solo ( price, "idle", undefined, "stop idle", node);

	price.enemyDistanceSQ = 1000;
	price.team = "neutral";
	price animscripts\shared::PutGunInHand("none");

	level thread pricedeath(price);
	price character\_utility::new();
	price character\price::main();

	price.health = 400;
	price.maxhealth = price.health*16;
	price DoDamage ( 1, price.origin );
	price animscripts\shared::UpdateWounds();

	trigger waittill ("trigger");
	wait (1);
	price lookat (level.player);
	price animscripts\shared::LookAtAnimations(%stand_aim_look_left_90, %stand_aim_look_right_90);
	
	guy[0] = price;
	price notify ("stop idle");
	price.team = "allies";
	level thread anim_single (guy, "noticed", undefined, node);
	level waittill ("noticed");
	price thread anim_loop_solo ( price, "idle noticed", undefined, "stop idle", node);

//	wait (2);
	// Price is on the move
	maps\_utility::autosave(7);


//	price.hasWeapon = false;
//	price.dropWeapon = false;

	// Open the windows where price will later escape
	leftshutter = getent ("leftshutter","targetname");
	rightshutter = getent ("rightshutter","targetname");
	leftshutter rotateyaw(90, 0.4,0,0);
	rightshutter rotateyaw(-90, 0.4,0,0);


	// Turn on the german reinforcements that try to stop price
	array_levelthread (getentarray ("price trigger","targetname"), ::priceTriggerOn);

	foley = level.foley;
	guy[0] = price;
	guy[1] = foley;

	println ("^1Reaching..");
	anim_reach (guy, "get up", undefined, node);
	println ("^1..reaching!");
	price notify ("stop idle");
	price.team = "allies";
	price lookat (price, 0);
	anim_single (guy, "get up", undefined, node);
	
	thread pricesave();

	friends = getentarray ("friends","targetname");
	friends[friends.size] = foley;
	friends[friends.size] = level.moody;
	array_thread (friends, ::followAI, price);
	flag_set ("RescuePrice");
	thread morePriceFoleyDialogue (price, foley);

	while (!isalive (brooks))
	{
		brooks = getent("brooks2", "targetname") dospawn();
		if (!maps\_utility::spawn_failed(brooks))
			break;

		wait (0.1);
	}
	brooks thread maps\_utility::magic_bullet_shield();
	brooks character\_utility::new();
	brooks character\brooks::main();

	while (!isalive (harding))
	{
		harding = getent("harding2", "targetname") dospawn();
		if (!maps\_utility::spawn_failed(harding))
			break;

		wait (0.1);
	}
	harding thread maps\_utility::magic_bullet_shield();
	harding character\_utility::new();
	harding character\harding::main();

	brooks.animname = "brooks";
	harding.animname = "harding";
	node = getnode ("window_animation2", "targetname");
	idlers[0] = brooks;
	idlers[1] = harding;
	level thread anim_loop ( idlers, "idle", undefined, "stop idle", node);

	// Price moves up one room at a time as you clear the germans
	ptrigger (price, getent ("price trigger 1","script_noteworthy"));
	ptrigger (price, getent ("price trigger 2","script_noteworthy"));
	ptrigger (price, getent ("price trigger 3","script_noteworthy"));
	
	moody = level.moody;
	moodynode = getnode ("moody window node","targetname");
	moody.goalradius = 4;
	moody setgoalnode (moodynode);

	foleynode = getnode ("foley window node","targetname");
	foley.goalradius = 4;
	foley setgoalnode (foleynode);
	foley thread failsafe(10);
	waittill_either (foley, "goal", "failsafe");

	thread windowChat (foley, brooks);
	
	guy[0] = brooks;
	guy[1] = harding;
	guy[2] = price;

	anim_reach (guy, "window", undefined, node);
	flag_wait ("window_animation_trigger");
	
	brooks notify ("stop idle");
	harding notify ("stop idle");
	anim_single (guy, "window", undefined, node);
	foley setgoalentity (price);
	moody setgoalentity (price);
	price setgoalnode (getnode ("obj7org","targetname"));
	friends = [];
	friends[friends.size] = brooks;
	friends[friends.size] = harding;
	array_thread (friends, ::followAI, price);
	price.goalradius = 384;
	while (1)
	{
		getent ("ending speech trigger","targetname") waittill ("trigger", other);
		if (other == price)
			break;
	}

	//	Let's pile in. We're getting out.
//	foley animscripts\face::SaySpecificDialogue(undefined, level.scrsound["foley"]["truck 1"], 1.0, "talking");
//	foley waittill ("talking");
	foley anim_single_solo (foley, "truck 1");

	//	Captain, what about Major Ingram?"
//	brooks animscripts\face::SaySpecificDialogue(undefined, level.scrsound["brooks"]["truck 2"], 1.0, "talking");
//	brooks waittill ("talking");
	brooks anim_single_solo (brooks, "truck 2");

	//	We'll be back for him. Get in.
//	foley animscripts\face::SaySpecificDialogue(undefined, level.scrsound["foley"]["truck 3"], 1.0, "talking2");
//	foley waittill ("talking2");
	foley anim_single_solo (foley, "truck 3");
	
//	price waittill ("goal");
	endlevel();
}

windowChat (foley, brooks)
{
	brooks anim_single_solo (brooks, "window 1");
	foley anim_single_solo (foley, "window 2");

	/*
	brooks animscripts\face::SaySpecificDialogue(undefined, level.scrsound["brooks"]["window 1"], 1.0, "talking");
	brooks waittill ("talking");

	foley animscripts\face::SaySpecificDialogue(undefined, level.scrsound["foley"]["window 2"], 1.0, "talking");
	foley waittill ("talking");
	*/
}


morePriceFoleyDialogue (price, foley)
{
	//	Captain Price, Captain Foley. Where's Major Ingram?"
	foley anim_single_solo (foley, "where is ingram?");
	//	They moved him to a camp. Not to worry, I overheard where."
	price anim_single_solo (price, "moved ingram");
}

followAI ( guy )
{
	self.goalradius = 400;
	self.followmin = 2;
	self.followmax = 4;
	self setgoalentity (guy);
	return;
	
	if (!isalive (self))
		return;

	guy endon ("death");
	self.goalradius = 700;
	while (1)
	{
		self setgoalpos (guy.origin);
		wait (5);
	}
		/*
	self setgoalentity ( guy );
	self.goalradius = 100;
	self.followmin = -2;
	self.followmax = 2;
	*/
}

seekplayer ()
{
//	self.health = 1;
	while (1)
	{
		level waittill ("friend has died");
		friends = getentarray ("friend", "targetname");
		if (friends.size < 3)
		{
			self setgoalentity (level.player);
			break;
		}
		friends = undefined;
	}
}

obj5loop()
{
	while (isdefined(self))
	{
		objective_position(6, self.origin);
		wait (0.05);
	}
}

pricesave()
{
	wait 4;
//	savegame (("Chateau6"), "Price On the Move");
}

pricedeath(price)
{
	price waittill ("death");
	setCvar("ui_deadquote", "@CHATEAU_PRICEKILLED");
	missionfailed();
}

endlevel ()
{
	objective_state(7, "done");
	missionSuccess ("powcamp", false);
}

trigger_sequence(trigger)
{
	trigger waittill("trigger");
//	level thread threeguysthread();
}

early_action()
{
	friends = getentarray ("friend", "targetname");

	foley = getent ("foley","targetname");
	moody = getent ("moody","targetname");
	brooks = getent ("brooks","targetname");
	harding = getent ("harding","targetname");

	foley.animname = "foley";
	moody.animname = "moody";
	brooks.animname = "brooks";
	harding.animname = "harding";

	foley character\_utility::new();
	foley character\foley::main();
	moody character\_utility::new();
	moody character\moody::main();
	brooks character\_utility::new();
	brooks character\brooks::main();
	harding character\_utility::new();
	harding character\harding::main();
	
	foley thread maps\_utility::magic_bullet_shield();
	moody thread maps\_utility::magic_bullet_shield();
	brooks thread maps\_utility::magic_bullet_shield();
	harding thread maps\_utility::magic_bullet_shield();

	guy[0] = foley;
	guy[1] = moody;
	guy[2] = brooks;
	guy[3] = harding;
	node = getnode ("earlyaction","targetname");
	maps\_anim::anim_teleport (guy, "intro", undefined, node);

	for (i=0;i<guy.size;i++)
	{
		guy[i] setgoalpos (guy[i].origin);
		guy[i].goalradius = (0);
	}

	level waittill ("starting final intro screen fadeout");
	level anim_single (guy, "intro", undefined, node);

	foley.followmin = 1;
	foley.followmax = 5;

	moody.followmin = 3;
	moody.followmax = 6;

	friends = getentarray ("new friend","targetname");
	friends[0].followmin = 0;
	friends[0].followmax = 8;

	friends[1].followmin = 0;
	friends[1].followmax = 8;
	
	foley setgoalentity (level.player);
	foley.goalradius = (700);
	
	moody setgoalentity (level.player);
	moody.goalradius = (700);
	
	friends[0] setgoalentity (level.player);
	friends[0].goalradius = (700);
	
	friends[1] setgoalentity (level.player);
	friends[1].goalradius = (700);
	
	harding setgoalnode (getnode ("harding node","targetname"));
	brooks setgoalnode (getnode ("brooks node","targetname"));
	level waittill ("completed objective " + 1);
	harding delete();
	brooks delete();
}

waittill_either_think (ent, msg)
{
	println (ent, "^1 is waiting for ", msg);
	ent waittill (msg);
	println (ent, "^1 got ", msg);
	self notify ("got notify");
}

waittill_either (waiter, msg1, msg2, msg3 )
{
	ent = spawnstruct();
	if (isdefined (msg1))
		ent thread waittill_either_think(waiter, msg1);
	if (isdefined (msg2))
		ent thread waittill_either_think(waiter, msg2);
	if (isdefined (msg3))
		ent thread waittill_either_think(waiter, msg3);
		
	ent waittill ("got notify");
}

anim_loop ( guy, anime, tag, ender, node, tag_entity )
{
	maps\_anim::anim_loop ( guy, anime, tag, ender, node, tag_entity );
}

anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
{
	newguy[0] = guy;
	maps\_anim::anim_loop ( newguy, anime, tag, ender, node, tag_entity );
}

anim_single (guy, anime, tag, node, tag_entity)
{
	maps\_anim::anim_single (guy, anime, tag, node, tag_entity);
}

anim_single_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim::anim_single (newguy, anime, tag, node, tag_entity);
}

anim_reach_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim::anim_reach (newguy, anime, tag, node, tag_entity);
}

anim_reach (guy, anime, tag, node, tag_entity)
{
	maps\_anim::anim_reach (guy, anime, tag, node, tag_entity);
}

anim_pushPlayer (guy)
{
	maps\_anim::anim_pushPlayer(guy);
}

anim_dontPushPlayer (guy)
{
	maps\_anim::anim_dontPushPlayer(guy);
}

failsafe (timer)
{
	wait (timer);
	self notify ("failsafe");
}

flag_wait (msg)
{
	if (!level.flag[msg])
		level waittill (msg);
}

flag (msg)
{
	if (!level.flag[msg])
		return false;

	return true;
}

flag_set (msg)
{
	level.flag[msg] = true;
	level notify (msg);
}

flag_trigger (trigger, msg)
{
	level thread flag_trigger_think(trigger, msg);
}

flag_trigger_think (trigger, msg)
{
	trigger waittill ("trigger");
	flag_set (msg);
}

lookat (ent, timer)
{
	if (!isdefined (timer))
		timer = 10000;

	self animscripts\shared::lookatentity(ent, timer, "alert");
}

array_thread (ents, process, var, excluders)
{
	maps\_utility::array_thread (ents, process, var, excluders);
}

array_levelthread (ents, process, var, excluders)
{
	maps\_utility::array_levelthread (ents, process, var, excluders);
}

random (array)
{
	return array [randomint (array.size)];
}

 
preSpawnThink ( spawner, trigger )
{
	spawn = spawner dospawn();
	if (maps\_utility::spawn_failed(spawn))
		return;
		
	spawn endon ("death");
	spawn setgoalpos (spawn.origin);
	spawn.goalradius = 16;
	trigger waittill ("trigger");
	level thread maps\_spawner::spawn_think_action (spawn);
}
 
preSpawnAlive ( trigger )
{
	if (!isdefined (trigger.target))
		return;
	
	spawnTriggerArray = getentarray (trigger.target,"targetname");
	if (spawnTriggerArray.size != 1)
		return;
		
	spawnTrigger = spawnTriggerArray[0];
		
	if (spawnTrigger.classname != "trigger_multiple")
		return;
		
	if (!isdefined (spawnTrigger.target))
		return;
		
	spawners = getentarray (spawnTrigger.target,"targetname");
	spawnTrigger.target = "null";
	
	trigger waittill ("trigger");
	trigger delete();
	array_levelthread(spawners, ::preSpawnThink, spawnTrigger);
}
