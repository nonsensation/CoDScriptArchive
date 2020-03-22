#using_animtree ("generic_human");
main()
{
	precachemodel("xmodel/vehicle_german_truck_d");
	precachemodel("xmodel/vehicle_tank_panzeriv_d");
	precachemodel("xmodel/explosivepack");
	precachemodel("xmodel/vehicle_tank_panzeriv_machinegun");
	precachemodel("xmodel/health_medium");
	precachemodel("xmodel/trainbridge_bridgedummies");
	precachemodel("xmodel/trainbridge_bridgedummies_hang");
	precachemodel("xmodel/trainbridge_parachute");
	precachemodel("xmodel/o_br_prps_parachute");

	precacheitem("item_health");
	precacheitem("webley");
	precacheitem("MK1britishfrag");

	precacheShellshock("default"); 
	
	//precache the LMG guys.
	animscripts\lmg_gmi::precache();

	//temp - add to fx.gsc
	level._effect["truck_lights"]		= loadfx ("fx/vehicle/headlight_german_truck.efx");
	level._effect["train_light"]		= loadfx ("fx/vehicle/headlight_train.efx");
//	level._effect["truck_lights"]		= loadfx ("fx/vehicle/bmw_headlight.efx");
		
	maps\_load_gmi::main();
	maps\_tank_gmi::main();    
	maps\_panzeriv_gmi::main();  
	maps\_truck_gmi::main();
	maps\_halftrack_gmi::main();
	maps\_treadfx_gmi::main("night");
	maps\_wood_gmi::main();
	maps\_stone_gmi::main();
	maps\_debug_gmi::main();
	maps\_flashlight::main();
	
	maps\trainbridge_anim::main();
	maps\trainbridge_fx::main();

	setExpFog(.000044, .1, .06, 0.1, 0);
	setCullFog (0, 15000, 0.0274, 0.0823, 0.1607, 0 );
	
	//level flags
	level.flag["ally panzer shot"] 		= false;
	level.flag["panzer1 fire"]		= false;
	level.flag["panzer2 fire"]		= false;
	level.flag["tank ready"] 		= false;
	level.flag["tank miss truck 1"] 	= false;
	level.flag["tank miss truck 2"] 	= false;
	level.flag["farmhouse mg42 dead"]	= false;
	level.flag["farmhouse guy1 dead"] 	= false;
	level.flag["farmhouse guy2 dead"] 	= false;
	level.flag["farmhouse allies ready"]	= false;
	level.flag["farmhouse empty"]		= false;
	level.flag["player sees barn"]		= false;
	level.flag["allies in the house"]	= false;

	//state of farmfight
	level.farmfight = 0;

	//state of pickup explosives
	level.bombs = 0;

	//so it threads only once
	level.vandyke_kill = 0;

	//Level flags for bridge bombs
	level.bomb_flag["bomb_0"] 		= false;
	level.bomb_flag["bomb_1"] 		= false;
	level.bomb_flag["bomb_2"] 		= false;
	level.bomb_flag["bomb_3"] 		= false;

	level thread Setup_Characters();
	
	thread start();
	thread farm_setup();
	thread woods_setup();
	thread music();

	thread Event_bridge_setup();
	thread Event_bridge();
	
	thread objectives();
	
	thread tunnel_depot_dialog();
	thread depot_setup();

	thread downhill_halftrack();
	thread downhillguys2_setup();

	thread chasegroup();

	thread truckRide_Manager();

	// Ambient sounds
	level.ambient_track ["exterior"] = "ambient_trainbridge_ext";
	level.ambient_track ["interior"] = "ambient_trainbridge_int";
	thread maps\_utility_gmi::set_ambient("exterior");
		
	//BARN DOORS
	barndoorleft 	= getent ("barndoorleft","targetname");
	barndoorright 	= getent ("barndoorright","targetname");
	smallbarndoor1 	= getent ("barnsmalldoor1","targetname");
	barndoorleft 	disconnectpaths();
	barndoorright 	disconnectpaths();
	smallbarndoor1 	disconnectpaths();
	
	//farmhouse stuff
	house_door = getent ("farmhouse_bustdoor", "targetname");
	house_door disconnectpaths();
	house_car = getentarray("bustdoor_car", "targetname");
	for(i=0; i < house_car.size; i++)
	{
		house_car[i] hide();
		house_car[i] thread maps\_utility_gmi::triggerOff();
	}
	maps\_utility_gmi::chain_off ("500");
	trigger = getent("mobileArtillary_fire2", "targetname");
	trigger thread maps\_utility_gmi::triggerOff();

	//trigger hurt for truckattack
	trigger = getent("truck_fire", "targetname");
	trigger thread maps\_utility_gmi::triggerOff(); 

	//block tunnel with halftrack
	clip = getent("block_tunnel", "targetname");
	clip thread maps\_utility_gmi::triggerOff();
	clip connectpaths();

	
	//truckride
	trigger = getent("gate_wood_splinter", "script_noteworthy");
	trigger thread maps\_utility_gmi::triggerOff();
	boards = getentarray("tank_whole_wood_gate", "targetname");
	for(i=0; i<boards.size; i++)
		boards[i] disconnectpaths();
	boards = getentarray("tank_break_wood_gate", "targetname");
	for(i=0; i < boards.size; i++)
		boards[i] hide();

	//chase stuff
	chase_triggers = getentarray ("chase_trigger","script_noteworthy");
	for(i = 0; i < chase_triggers.size; i++)
	{
		chase_triggers[i] thread maps\_utility_gmi::triggerOff();
	}

	// debug stuff
	if(getcvar("skipto_bridge") == "")
	{
		setcvar("skipto_bridge","0");
	}

	if(getcvar("skipto_bridge") == 1 && getcvarint("sv_cheats") > 0)
	{
		level thread skipTo_bridge();
	}

	// Throw away the garbage! Models/temp objects not used in the game.
	garbage = getentarray("garbage","targetname");
	for(i=0;i<garbage.size;i++)
	{
		garbage[i] delete();
	}


	//disable lean
	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowCrouch(false);

//	thread test();

}

test()
{
//	wait 10;
//	level notify("all_bombs_planted");
//	thread temp_different_start();
//	wait 1;
//	level.player unlink();
//	level notify("ingram_done");

//	println("test threaded!!");
//	test = getentarray("test", "groupname");
//	for(i=0; i<test.size; i++)
//	{		
//		if(issentient(test[i]))
//		while(1)
//		{
//			println("^3test pos is ", test[i].origin);
//			wait 1;
//		}	
//	}
}


Setup_Characters()
{
	//Ingram
	Ingram = getent("ingram","targetname");
	Ingram.animname = "ingram";
	Ingram character\_utility::new();
	Ingram character\ally_british_ingram::main();

	Ingram thread maps\_utility_gmi::magic_bullet_shield();
	level.Ingram = Ingram;

	//Van Dyke
	van_dyke = getent("van_dyke","targetname");
	van_dyke.animname = "van_dyke";

	van_dyke character\_utility::new();
	van_dyke character\Resistance_Tom::main();

	//rest of the fools
	level.character_type = [];
	level.character_type[level.character_type.size] = "Resistance_Old";	
	level.character_type[level.character_type.size] = "Resistance_Moe";	
	level.character_type[level.character_type.size] = "Resistance_Bucky";	
	level.character_type[level.character_type.size] = "Resistance_Fat";	
	level.character_type[level.character_type.size] = "Resistance_Dom";	

	//there's a bug currently b/c guys are already associated with weapons. when fixed can use all guys
	level.resistance = getentarray("resistance", "groupname");	
	println("^5 SIZE IS ", level.resistance.size);

	for(n=0; n < level.resistance.size; n++)
	{
		switch(n)
		{
			case 0:	
					level.resistance[n] character\_utility::new();
					level.resistance[n] character\Resistance_Bucky::main();
					break;
			case 1:	
					level.resistance[n] character\_utility::new();
					level.resistance[n] character\Resistance_Moe::main();
					break;
			case 2:										
					level.resistance[n] character\_utility::new();
					level.resistance[n] character\Resistance_Old::main();	
					break;
			case 3:	
					level.resistance[n] character\_utility::new();
					level.resistance[n] character\Resistance_Fat::main();
					break;
			case 4:	
					level.resistance[n] character\_utility::new();
					level.resistance[n] character\Resistance_Dom::main();
					break;
		}

		level.resistance[n].oldname = level.resistance[n].name;
		level.resistance[n].name = "";
	}

	level.ingram.oldname = level.ingram.name;
	level.ingram.name = "";

	//this isn't gonna work...
	level.van_dyke = van_dyke;
	level.van_dyke.oldname = van_dyke.name;
	level.van_dyke.name = "";
	
}

//AMBUSH ON FIRST PATROL

start()
{
	wait 0.01;
	
	maps\_utility_gmi::chain_off ("25");
	
	friend = getaiarray ("allies");
	maps\_utility_gmi::array_levelthread(friend,::friend_wait);
	//read me*************************************************************************************************************************************************
	//read me*************************************************************************************************************************************************
	//read me*************************************************************************************************************************************************
	/*
		Since there's no reasonable way to replenish troops in this level (it's not a big war, it's a covert operation with a select group of people), we
		gotta make sure our guys last through most of the level.  especially since you need at least one person in the end (to drive the truck).  So we'll 
		put a magic bullet shield on them.  But it also looks unrealisitc if they never die.  So at key points in the level, we can take the shield off of one 
		random teammate.  this way - you can assure that you always have at least a certain number of teammates...but it still makes the game a little dynamic
		every time you play
	*/
	for(i = 0; i < friend.size; i++)
		friend[i] thread maps\_utility_gmi::magic_bullet_shield();
	//read me*************************************************************************************************************************************************
	//read me*************************************************************************************************************************************************
	//read me*************************************************************************************************************************************************
	level.player.ignoreme = true;

	patrol1_guys = getentarray ("patrol1", "targetname");
	level.patrol1guys = patrol1_guys.size;
        maps\_utility_gmi::array_levelthread(patrol1_guys,::patrol1_think);
	
	thread patrol1_dialog();
	thread start_dialog();

	//put in gentle swaying here
	level thread start_sway();	

	level waittill ("patrol1 died");


	//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	// pony -- Turn on friendly AI names so that they show up now, not earlier
	for(n=0;n<level.resistance.size;n++)
	{
		level.resistance[n].name = level.resistance[n].oldname;
	}
	level.ingram.name = level.ingram.oldname;

	//No, no...
	level.van_dyke.name = level.van_dyke.oldname;
	//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

	
	//player stuff
	level.player.ignoreme = false;

	//bring guys to tree after fight
	chain = get_friendly_chain_node ("25");
	level.player SetFriendlyChain (chain);
	
	level waittill ("ingram_done");

	//player get out of tree
	wait 1.75;		//to synch to falling sound
	level.player unlink();

	//enable lean
	level.player allowLeanLeft(true);
	level.player allowLeanRight(true);
	level.player allowCrouch(true);

	maps\_utility_gmi::autosave(1);	
	thread start_dialog2();

	//give player weapons
	level.player giveWeapon("webley");
//	level.player giveWeapon("MK1britishfrag");
	wait 2.5;
	level.player switchtoweapon("webley");
	level.player playsound("weap_raise");
}

start_sway()
{

	start = getent("in_tree", "targetname");
	level.player setorigin(start.origin);
	level.player linkto(start); 
	start thread sway_failsafe();
		
//	bomber_parachute
//	parachute = spawn ("script_model",(start.origin) + (0, 45, 0));
	parachute = getent("parachute", "targetname");
	parachute setmodel("xmodel/trainbridge_parachute");
	parachute UseAnimTree(level.scr_animtree["trainbridge_parachute"]);
	start linkTo(parachute, "TAG_PLAYER", (0,0,-56),(0,0,0));
	
//	parachute setflaggedanimknobrestart("ingram_done", level.scr_anim["parachute"]["sway"], 1, 0, 1 );
//	parachute thread anim_single_solo(parachute, "sway");
	//parachute animscripted("single anim", parachute.origin, parachute.angles, level.scr_anim["parachute"]["sway"]);
	parachute thread sway_sound();


	level waittill ("ingram_done");
	start playsound("drop_from_tree");

	//wait for player to unlink
	wait 1.85;	
	pack = spawn ("script_model",(start.origin) + (0,90,0));	//line up with chute
	pack setmodel("xmodel/o_br_prps_parachute");
	pack linkto(parachute, "TAG_PLAYER", (0,0,0),(0,0,0));
}

//in case player never gets attached to parachute
sway_failsafe()
{
	level endon ("ingram_done");

	while(1)
	{
		level.player linkto(self);
		wait 0.1;	
		println("^3failsafe linkto!!!");
	}
}
//sound of parachute swaying
sway_sound()
{
	level endon("ingram_done");
	println("^3!!sway threaded!!");
	println("^3!!sway threaded!!");
//	self playsound("swing_in_tree");
	self animscripted("single anim", self.origin, self.angles, level.scr_anim["parachute"]["sway"]);
	while(1)
	{
		
		println("in the sway while");
		self waittill("single anim", notetrack);
		println("notetrack is ", notetrack);
		
		if(isdefined(notetrack) && notetrack == "swing_in_tree")
		{
			self playsound("swing_in_tree");
			println("swing_in_tree sound!!!!");
		}
		else if (isdefined(notetrack) && notetrack == "end")
		{
			self animscripted("single anim", self.origin, self.angles, level.scr_anim["parachute"]["sway"]);
			self playsound("swing_in_tree");
			println("swing_in_tree sound!!!!");
		}
	}	
}

start_dialog()
{
	level waittill ("patrol1 died");

	node = getnode("ingram_mark_start", "targetname");
	level.Ingram setgoalnode(node);
	level.ingram.goalradius = 4;

	level.ingram waittill("goal");
//	//ingram spot
//	level.ingram anim_reach_solo(level.ingram, "ingram_intro", undefined, node);

	wait 1;

	//Nasty way to go, eh wot?  You can come down now...he won’t give you any more trouble.
//	level.ingram anim_single_solo(level.ingram, "ingram_comedown");
	level.ingram thread anim_single_solo(level.ingram, "ingram_intro");
	level.ingram thread animscripts\shared::lookatentity(level.player, 17, "casual");

//	wait 5.2;
	wait 3.5;

	level notify("ingram_done");

	wait 15;
	//ingram chatter
	level notify("ingram_finish");
}

start_dialog2()
{
	level thread start_tunnel_guys();

	level waittill("ingram_finish");
	wait .5;
	//(Introducing himself) Major Ingram, SOE.  You are a very lucky man.
//	level.ingram anim_single_solo(level.ingram, "ingram_intro");

	//Grab a weapon from one of those dead Gerries, keep quiet and do as you’re told and we’ll get you out right as rain. Let’s go.
//	level.ingram anim_single_solo(level.ingram, "ingram_quiet");

	//send dudes up road
	chain = get_friendly_chain_node ("150");
	level.ingram setgoalentity(level.player);
	level.player SetFriendlyChain (chain);
	
	//send ingram to rock before tunnel	
	trigger = getent("JCauto54", "targetname");
	trigger waittill("trigger");

	mark = getnode("ingram_mark_patrol", "targetname");
	level.Ingram setgoalnode(mark);
}

//first encounter by tunnel
start_tunnel_guys()
{
	trigger = getent("ingram_careful", "targetname");
	trigger waittill("trigger");

	//(hissing, urgent) Easy lads, careful.
	level.ingram anim_single_solo(level.ingram, "ingram_careful");

	//pacify friends
	level thread start_friends_pacifist();

	//spawn enemies
	spawners = getentarray("tunnel_guys", "targetname");
	level.tunnel_guys = spawners.size;
	maps\_utility_gmi::array_levelthread(spawners,::start_tunnelguys_think);
	println("level.tunnel_guys is ", level.tunnel_guys);

	//check if player fired
	level thread start_tunnel_playerfired();

	
	//start the event
	trigger = getent ("tunnel_guys_start","targetname");
	trigger waittill ("trigger");
	
	//(hissing, urgent) Shhh...down...German patrol.
	level.ingram anim_single_solo(level.ingram, "ingram_shh");

	level.ingram thread animscripts\shared::lookatentity(level.player, 5, "casual");
	//(hissing, urgent) "Doyle, find some cover."
	level.ingram anim_single_solo(level.ingram, "ingram_find_cover");
	
	// put ingram back on the chain
	level.ingram setgoalentity(level.player);

	maps\_utility_gmi::autosave(2);

//	//when patrol gets to spot start action
//	trigger = getent("tunnel_guys_fight", "targetname");
//	trigger waittill ("trigger");
//	println("^3 triggered by tunnel trigger");

	wait 2;

	level notify ("tunnel_fight_start");
}

start_tunnelguys_think(spawners)
{
	spawners.count = 1;
	tunnelguy = spawners stalingradspawn();
	tunnelguy thread start_tunnel_setup();
}

start_tunnel_setup()
{
	println("^5tunnelguy spawned********************************************");
	self.pacifist = 1;
	self.goalradius = 16;
	self.team = "axis";
	println("guy accuracy is ", self.accuracy);
	println("guy health is ", self.health);

	self thread start_tunnel_death();
	self thread start_tunnel_see();
//	self thread start_tunnel_pain();

	level waittill("tunnel_fight_start");
	self.pacifist = false;
	self.goalradius = 512;
}

start_tunnel_death()
{
	self waittill ("death");
	println("guy died");
	
	//counter goes here
	level.tunnel_guys--;
	println("^3 tunnel_guys = " + level.tunnel_guys);

	if (level.tunnel_guys <= 0)
	{
		println("^tunnel_guys died, see once");
		level thread start_tunnel_finish();
	}
}
//replace with button press check
start_tunnel_playerfired()
{
	while (level.tunnel_guys > 0)
	{
		if(level.player attackButtonPressed())
		{
			println("^3 *********** PLayer fired ********************");
			println("^3 *********** PLayer fired ********************");
			level notify ("tunnel_fight_start");
			break;
		}
		wait 0.05;
	}
	println("^3 tunnel_fight started");
}

//if the player runs up while enemies in pacifist mode
start_tunnel_see()
{
	self endon("death");
	println("^3waiting for player to pull rambo");
	trigger = getent("tunnel_see", "targetname");
	trigger waittill ("trigger");
	println("^3player trying to be rambo!!!");

	self.pacifist = false;
	self.favoriteenemy = level.player;
	self.health = 350;
	self.accuracy = 1;
	self setgoalentity(level.player);

	level notify ("tunnel_fight_start");

	println("ramboguy accuracy is ", self.accuracy);
	println("ramboguy health is ", self.health);
}

start_tunnel_finish()
{
	friends = getaiarray ("allies");
	for (i=0;i<friends.size;i++)
	{
		friends[i].generic_dialogue = false;
	}
	//line for get off road
	mark = getnode("ingram_forest", "targetname");
	level.Ingram setgoalnode(mark);
	
	while (distance (level.player.origin, level.ingram.origin) > 800)
	{
		wait (0.1);
	}

	//There’s way too much bloody activity on this road. We’ll have to cut through the forest. Doyle – stay close.
	level.ingram thread anim_single_solo(level.ingram, "ingram_goto_forest");	
	
	wait 2;
	
	//next chain
	barn_chain = getnode("barn_chain", "targetname");
	level.player SetFriendlyChain (barn_chain);
	println("^3 friendlies should move to barn");

	//update objective position to barn
	objective_position (1,(124, 5586, 380));			

	mark = getnode("ingram_mark_barn", "targetname");
	level.Ingram setgoalnode(mark);

	for (i=0;i<friends.size;i++)
	{
		friends[i].generic_dialogue = true;
	}
}

start_friends_pacifist()
{
	//pacify friends
	friends = getaiarray ("allies");
	for (i=0;i<friends.size;i++)
	{
		friends[i].pacifist = true;
		friends[i].bravery = 1000;
		println("friend accuracy is ", friends[i].accuracy);
	}
	println("^3 friend should be pacifists");

	level waittill("tunnel_fight_start");
		
	//unpacify
	for (i=0;i<friends.size;i++)
	{
		friends[i].pacifist = false;
	}
	println("^3 friend should be fighting");
}


//patrol1_think(spawners)
//{
//	spawners.count = 1;
//	enemy = spawners doSpawn();
//	if (maps\_utility_gmi::spawn_failed(enemy))
//	{
//		level.patrol1guys--;	
//		return;
//	}
//	enemy.team = "neutral";
//	enemy.goalradius = 16;
//	
//	thread enemypain(enemy);
//	thread enemydeath(enemy);
//	
//	level waittill ("ambush2");
//	
//	enemy.team = "axis";
//	enemy.goalradius = 512;
//	
//	enemy waittill ("death");
//	level.patrol1guys--;
//	if (level.patrol1guys <= 0)
//	{
//		level notify ("patrol1 died");
//	}
//}

patrol1_think(patrol1_guys)
{
	println("^3 patrol1 is neutral");
	patrol1_guys.team = "neutral";
	patrol1_guys.goalradius = 16;
	patrol1_guys.health = 1;
	patrol1_guys.pacifist = true;

	//make guy walk
	patrol1_guys.walkdist = 9999;
	patrolwalk[0] = %patrolwalk_bounce;
	patrolwalk[1] = %patrolwalk_tired;
	patrolwalk[2] = %patrolwalk_swagger;
	patrol1_guys.walk_noncombatanim = maps\_utility_gmi::random(patrolwalk);
	patrol1_guys.walk_noncombatanim2 = maps\_utility_gmi::random(patrolwalk);

	level waittill ("ambush2");
	
	println("^3 patrol1 is axis");
	patrol1_guys.team = "axis";
	patrol1_guys.goalradius = 512;
	patrol1_guys.walkdist = 0;
	patrol1_guys.pacifist = false;

	patrol1_guys waittill ("death");
	
	level.patrol1guys--;
	if (level.patrol1guys <= 0)
	{
		level notify ("patrol1 died");
	}
}

enemypain(enemy)
{
	enemy waittill ("pain");
	level notify ("ambush2");
	println("^1 been hurt turning back to Axis");
	enemy.team = "axis";
}

enemydeath(enemy)
{
	enemy waittill ("death");
	level notify ("ambush2");
	enemy.team = "axis";
}

patrol1_dialog()
{
	//temp
	truck = getent("truck75", "targetname");
	truck maps\_truck_gmi::init();

	playfxontag( level._effect["truck_lights"], truck,"tag_origin");

	//***************************************
	node = getnode("piss_node","targetname");
	println("node targetname is ", node.targetname);
	pisser = getent(node.targetname,"target");
	println("pisser is ", pisser.targetname);

	other_node = getnode("patrol1_speak","targetname");
	talker = getent(other_node.targetname,"target");

	level waittill ("starting final intro screen fadeout");

	println("German: Why do they have us out here searching all night? I doubt anyone survived that bomber crash.");
//	pisser playsound("patrol1_chat");
	pisser playsound("ge_gen_10");

	wait 6;

//	iprintlnbold("German: Ha! Would you prefer the Russian front? I hear there is plenty of action there. No this is just fine for me.");
	talker playsound("patrol2_chat");

	pisser waittill("goal");	

	level thread patrol1_piss(pisser,node);

	level waittill("piss_over");
	pisser.goalradius = 128;

	//move guys closer to tree
	chain = get_friendly_chain_node ("100");
	level.player SetFriendlyChain (chain);

//	iprintlnbold("German: Achtung! Englander!");
//	talker playsound("patrol1_alert");

	level notify ("ambush2");

//	iprintlnbold("German: Fire!");
	talker playsound("patrol2_fire");
}

patrol1_piss(pisser,node)
{
	pisser.animname = "pisser";
	guy[0] = pisser;

	//iprintlnbold("German: Hang on. I have to take a leak.");
	pisser playsound("patrol1_chat2");
	wait 2;
	
//	pisser playloopsound ("Pissing_Guy");
//
//	pisser anim_single (guy, "idle", undefined, node);
//	pisser anim_single (guy, "shakeout", undefined, node);
//	pisser stoploopsound ("Pissing_Guy");
//
//	pisser thread anim_single (guy, "casual turn", undefined, node);
	pisser thread patrol_piss_sound();
	pisser anim_single(guy, "pissing", undefined, node);

	level notify("piss_over");
}

patrol_piss_sound()
{
	self endon("death");
	
	while(1)
	{
		self waittill("single anim",notetrack);
		println("in the piss while");
		println("notetrack is ", notetrack);

		
		if(notetrack == "start_piss")
		{
			self playloopsound("Pissing_Guy");
			println("piss sound!!!!");
		}
		else if(notetrack == "stop_piss")
		{
	  		self stoploopsound("Pissing_Guy");
		}
	}	
}

friend_wait(friend)
{
	friend.team = "neutral";
	friend.generic_dialogue = false;
	
	chain = get_friendly_chain_node ("50");
	level.player SetFriendlyChain (chain);

	friend allowedStances ("crouch");
	
	level waittill ("ambush2");
	
	friend.team = "allies";
	friend.generic_dialogue = true;
	friend.pacifist = false;
	friend allowedStances ("crouch", "prone", "stand");
}

//FARM SCENE
farm_setup()
{
	//hide the broken part of the house
	wall = getentarray("house_breakwall1", "script_noteworthy");
	for(i=0; i < wall.size; i++)
		wall[i] hide();
	wall2 = getentarray("house_breakwall2", "script_noteworthy");
	for(i=0; i < wall2.size; i++)
		wall2[i] hide();
		
	trigger = getent ("farm_setup_trigger","targetname");
	trigger waittill ("trigger");

	friend = getaiarray ("allies");
	maps\_utility_gmi::array_levelthread(friend,::friendfarm);
	
//	level.player.ignoreme = true;
	
	//play line
	trigger = getent("ingram_getto_barn", "targetname");
	trigger waittill("trigger");

	//(whispered) Get up to that barn -- right quick.
	level.ingram anim_single_solo(level.ingram, "ingram_getto_barn");

	//player is near barn
	near_barn = getent("near_barn", "targetname");
	near_barn waittill("trigger");

	//needs to be on his mark
//	level.Ingram waittill("goal");
	node = getnode("ingram_mark_barn", "targetname");

	//ingram speaks
//	iprintlnbold("INGRAM: We'll have to clear out that house; they could give us trouble later if we don't.");
	level.scr_anim["ingram"]["ingram_clear_house"]			= (%c_br_trainbridge_ingram_clear_house);

	level.scr_notetrack["ingram"][0]["notetrack"]              	="ingram_clear_house"; 
     	level.scr_notetrack["ingram"][0]["dialogue"]                	="ingram_clear_house"; 
     	level.scr_notetrack["ingram"][0]["facial"]                	=(%f_trainbridge_ingram_clear_house);

	level.ingram anim_reach_solo(level.ingram, "ingram_clear_house", undefined, node);
	wait .5;
	level.ingram thread animscripts\shared::lookatentity(level.player, 5, "casual");
	level.ingram anim_single_solo(level.ingram, "ingram_clear_house", undefined, node);

	spawners = getentarray ("offdutyguys", "targetname");
        maps\_utility_gmi::array_levelthread(spawners,::offdutyguys_think);

	thread farmfight_start();
	thread farm_objectives();
	thread barn_init();
	thread mobileArtillary_events();
	thread farm_bustdoor();
	thread farm_outhouse();
	thread farm_music();
	thread offdutysee();
	thread offdutyhear(); 
	thread farm_bypass(); 
	thread farm_bypass2(); 

	objective_state(1, "done");
	level notify ("objective_1_complete");

	maps\_utility_gmi::autosave(3);
		
	// put ingram back on the chain
	level.ingram setgoalentity(level.player);
	
	//move to wall near house
	wall_chain = getnode("wall_chain", "targetname");
	level.player SetFriendlyChain (wall_chain);

	//push friendlies closer to house
	chain_trigger = getent("near_house", "targetname");
	chain_trigger waittill("trigger");

	if(level.farmfight == 0)
	{
		level.ingram thread animscripts\shared::lookatentity(level.player, 5, "casual");
		//(whispered) They haven’t seen us. Hold your fire. Get up as close as you can. 
		level.ingram anim_single_solo(level.ingram, "ingram_close_as_can");
	}

	thread farmfight_chain_decide();

//	chain = getnode("250a", "targetname");
//	level.player SetFriendlyChain (chain);
	println("^3 friedlies should move closer to house");
}

farm_music()
{
	music_play = getent("phonograph", "targetname");
	music_play playSound("phonograph_chopin");

	level waittill ("farmfight start");
}

farm_outhouse()
{
	trigger = getent("outhouse_trigger","targetname");
	trigger waittill("trigger");
	println("outhouse_trigger");

	wait 2;

	//spawn the outhouse guy
	outhouse_guy = getent("outhouse_guy", "targetname");
	guy = outhouse_guy dospawn();
	
	//open the outhouse door
	outhouse_door = getent("outhouse_door","targetname");
	outhouse_door connectpaths();
	outhouse_door rotateyaw (120, .5,.3,0);
	outhouse_door playsound ("wood_door_kick");
	println("outhouse_door should be open");

	//wake up if shot
	guy thread offdutypain();
	guy thread offdutydeath();
	guy thread offdutyfight();

//	//start fight when he gets to node
	wait .5;
	guy.goalradius = 32;
	goal = getnode("outhouse_goal", "targetname");
	guy setgoalnode(goal);

	guy waittill("goal");
	wait (1 +randomint(2)); // should have a line
	if(isalive(guy))
	{
		guy playsound("generic_misccombat_german_1");
		level notify("farmfight start");
	}
	//***when player is in truck leaving barn***

	//have truck hit door
	crash = getent("break_outhouse", "targetname");
	crash waittill("trigger");

	outhouse_door playsound ("wood_crash");
	outhouse_door delete();
}


farm_objectives()
{
	level waittill("objective_1_complete");	

	//infiltrate the house
	objective_add(2, "active", &"GMI_TRAINBRIDGE_OBJECTIVE_2", (-3650, 6500, 250));
	objective_current(2);

	//mg34
	level waittill ("farmfight start");
	level.farmfight = 1;

	//pause before mg34 windows open
	level waittill("windows_open");

	wait 3;	//lets mg34 spawn

	//We need to take out those bloody machine guns!
	level.ingram anim_single_solo(level.ingram, "ingram_mg34");

	objective_add(2, "active", "", (0,0,0));
	objective_current(2);
	mgnum = 0;
	while(!flag("farmhouse mg42 dead"))
	{
		if(!isdefined(level.mg1) || !isalive(level.mg1))
			origin = level.mg2.origin;	
		else if(!isdefined(level.mg2) || !isalive(level.mg2))
			origin = level.mg1.origin;
		else
		{
			d1 = distanceSquared(level.player.origin, level.mg1.origin);
			d2 = distanceSquared(level.player.origin, level.mg2.origin);
			if(d1 < d2)
				origin = level.mg1.origin;
			else
				origin = level.mg2.origin;
		}
		if(mgnum != level.mg42guys)
		{
			objective_string(2,  &"GMI_TRAINBRIDGE_OBJECTIVE_2_TRACKER", level.mg42guys);
			mgnum = level.mg42guys;
		}
		objective_position(2, origin);
		wait .05;
	}
	//clear house
	flag_wait("farmhouse mg42 dead");

	//Take out the MG34Gunners on the 2nd Floor.
	objective_string(2, &"GMI_TRAINBRIDGE_OBJECTIVE_2_MG");
	objective_state(2, "done");

	//Clear out the remaining enemies in the farmhouse.
	objective_add(3, "active", &"GMI_TRAINBRIDGE_OBJECTIVE_3", (-3250, 6488, 428));
	objective_current(3);

	//destroy barn guys
	flag_wait("farmhouse empty");
	
	wait 1;

//	iprintlnbold("INGRAM: More Jerries in the barn! Clear it out!");
	level.ingram anim_single_solo(level.ingram, "ingram_barn");

	//Clear the enemies by barn.
	objective_add(4, "active", &"GMI_TRAINBRIDGE_OBJECTIVE_4", (-1544, 5312, 320));
	while(1)
	{
		println("^3 IN THE WACKY WHILE LOOP!!");
		enemies = getaiarray("axis");
		if((enemies.size < level.barnguy) <= 0)
			break;
		wait .1;	
	}
	objective_state(3, "done");
	objective_current(4);

	//mobile artillary dead
	level waittill ("barn gunners died");
	objective_state(4, "done");
	level notify("objective_4_complete");
	maps\_utility_gmi::autosave(5);
}

//prevent player from bypassing farmhouse
farm_bypass()
{
	level endon("truck_attack1_done");	

	//near woods
	trigger = getent("near_woods", "targetname");
	trigger waittill("trigger");
	
	level thread insubordination_trigger();
}

//prevent player from going back to woods
farm_bypass2()
{
	level waittill("chase2_dead");

	//near woods
	trigger = getent("near_woods", "targetname");
	trigger waittill("trigger");
	
	level thread insubordination_trigger();
}

insubordination_trigger()
{
	//mission fail - insubordination
	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
	missionFailed();
}

mobileArtillary_events()
{
	level waittill ("guys in house died");
	wait 2;
	thread mobileArtillary_house1();
	thread mobileArtillary_house2();
	
}
mobileArtillary_lookatflag1()
{
	lookat = getent("mobileArtillary_look", "targetname");
	lookat waittill("trigger");
	flag_set("player sees barn");
	lookat delete();
}

//changed to trigger damage, no longer automatic
mobileArtillary_house2()
{
	println("waiting for second explosion");
	trigger = getent("mobileArtillary_fire2", "targetname");
	trigger thread maps\_utility_gmi::triggerOn();
	trigger waittill("trigger");
	println("second explosion should happen");

//	wait 1;
	//fx stuff
	impact = getentarray("mobileArtillary_impact2", "targetname");
	for(i = 0; i < impact.size; i++)	
		maps\_utility_gmi::exploder(impact[i].script_exploder);
//	impact[0] playsound("mortar_explosion" + ( randomint(5) + 1 ), "sounddone");
	wait .1;
	//house stuff
	earthquake(0.65, 2, impact[0] getorigin(), 5000);
	wallbreak = getentarray("house_breakwall2", "script_noteworthy");
	wallwhole = getentarray("house_wholewall2", "script_noteworthy");
	for(i = 0; i < wallwhole.size; i++)
		wallwhole[i] delete();	
	for(i = 0; i < wallbreak.size; i++)
		wallbreak[i] show();
	
	//player stuff
	thread mobileArtillary_effectPlayer("mobileArtillary_hurtzone2", impact[0] getorigin());
	thread mobileArtillary_hurtenemy("mobileArtillary_hurtzone2", impact[0] getorigin());
	
	//tablestuff
	chair = getent("explode2_table","targetname");
	endorg = getent("explode2_tablepos", "targetname");
	moveorg = spawn("script_origin", (0,0,0));
	moveorg.origin = chair.origin;
	moveorg.angles = chair.angles;
	endangles = endorg.angles;
	chair linkto(moveorg);
	time = .5;
	moveorg moveTo(endorg.origin, time, 0, .25);
	moveorg rotateTo(endangles, time, 0, .25);	
	moveorg waittill("movedone");
	chair unlink();
	moveorg delete();
	chair delete();
}
mobileArtillary_house1()
{
	thread mobileArtillary_lookatflag1();
	
	//this gives the player a couple seconds to see the shot fired, before actually shooting the mobile artillary no matter what.
	counter = 2;
	while(!flag("player sees barn") && counter > 0)
	{
		counter -= .05;
		wait .05;	
	}
	
	//fx stuff
	impact = getentarray("mobileArtillary_impact1", "targetname");
	for(i = 0; i < impact.size; i++)	
		maps\_utility_gmi::exploder(impact[i].script_exploder);
	impact[0] playsound("mortar_explosion" + ( randomint(5) + 1 ), "sounddone");
	
	wait .1;
	//house stuff
	earthquake(0.65, 2, level.player.origin, 5000);
	wallbreak = getentarray("house_breakwall1", "script_noteworthy");
	wallwhole = getentarray("house_wholewall1", "script_noteworthy");
	mg42 = getent("farmhouse_mg42_E", "targetname");
	
	for(i = 0; i < wallwhole.size; i++)
		wallwhole[i] delete();	
	mg42 notify ("deleted");
	mg42 delete();
	for(i = 0; i < wallbreak.size; i++)
		wallbreak[i] show();
	
	//player stuff
	thread mobileArtillary_effectPlayer("explode_wall1", impact[0] getorigin());
	thread mobileArtillary_hurtenemy("explode_wall1", impact[0] getorigin());
	
	//chair stuff
	chair = getent("explode1_chair","targetname");
	chair delete();

	wait 2;

	maps\_utility_gmi::autosave(4);
//	endorg = getent("mobileArtillary_chairpos", "targetname");
//	moveorg = spawn("script_origin", (0,0,0));
//	moveorg.origin = chair.origin;
//	moveorg.angles = chair.angles;
//	endangles = endorg.angles;
//	chair linkto(moveorg);
//	time = .5;
//	moveorg moveTo(endorg.origin, time, 0, .25);
//	moveorg rotateTo(endangles, time, 0, .25);	
//	moveorg waittill("movedone");
//	chair unlink();
//	moveorg delete();
}
mobileArtillary_hurtenemy(touchtrigger, impactpoint)
{
	enemy = getaiarray("axis");
	trigger = getent(touchtrigger, "targetname");
	for(i=0; i< enemy.size; i++)
	{
		if(enemy[i] istouching(trigger))
		{
			enemy[i] dodamage(enemy[i].health + 1000, impactpoint);
		}
	}	
}
mobileArtillary_effectPlayer(touchtrigger, impactpoint) 
{
	trigger = getent(touchtrigger, "targetname");	
	if(level.player istouching(trigger))
	{
	/*	move = spawn("script_origin", (0,0,0));
		move.origin = level.player.origin;
		move.angles = level.player.angles;
		
		vec = level.player.origin - impactpoint;
		vec = (vec[0], vec[1], level.player.origin[2]);
		vectornormalize
		vec = maps\_utility_gmi::vectorScale(vec, 256);
	*/
		level.player freezeControls(true);
		level.player allowLeanLeft(false);
		level.player allowLeanRight(false);
		level.player allowCrouch(false);
		level.player allowStand(false);
		level.player allowProne(true);

		println("^5 impactpoint is ", impactpoint);
		//radiusDamage(origin, range, maxdamage, mindamage);
		radiusDamage(impactpoint, 256, 250, 50);
		println("^5 player should be hurt if within 256 units");

		level.player Shellshock("default", 4);	
	/*	
		level.player linkto(move);
		move moveTo(vec, .5, 0, 0);
		move waittill ("movedone");
		level.player unlink();
		move delete();
	*/
		wait .5;
		level.player freezeControls(false);
		level.player allowLeanLeft(true);
		level.player allowLeanRight(true);
		level.player allowCrouch(true);
		wait .5;
		level.player allowStand(true);
	}		
}
offdutyguys_think(spawners)
{
	spawners.count = 1;	// was 3 but changed to 1, way too many dudes
	offdutyguy = spawners stalingradspawn();
//	if (maps\_utility_gmi::spawn_failed(offdutyguy))
//	{	
//		return;
//	}
//	offdutyguy waittill("finished spawning");

	offdutyguy thread offdutyguys_setup();
}	

offdutyguys_setup()
{
	println("^5guy spawned********************************************");
	self.pacifist = 1;
	self.goalradius = 16;
	self.team = "axis";
	
	self thread offdutypain();
	self thread offdutydeath();
	self thread offdutyfight();
}

offdutypain()
{
	println("offdutyguy is waiting for combat");
	self waittill ("combat");
	println("offdutyguy triggered combat");
	level notify ("farmfight start");
}

offdutydeath()
{
	self waittill ("death");

	level notify ("farmfight start");
	println("guy died");
}

offdutyfight()
{
	level waittill("farmfight start");
	self.pacifist = 0;
	self.goalradius = 512;
}

offdutysee()
{
	trigger = getent("farmhouse_caught", "targetname");
	trigger waittill ("trigger");	
	level notify ("farmfight start");
}

offdutyhear()
{
	//uses trigger damage for shots that miss
	trigger = getent("farm_alarm", "targetname");
	trigger waittill ("trigger");	
	level notify ("farmfight start");
}	
friendfarm(friend)
{
//	friend.team = "neutral";
	friend.pacifist = true;
	friend.script_followmax = randomint(3) + 4;
	friend.script_followmin = randomint(2);
	
	level waittill ("farmfight start");
	println("^5 friends should be fighting");
	
	friend.team = "allies";	
	friend.pacifist = false;
	friend.oldgoalradius = friend.goalradius;
	friend.goalradius = 8;
}
farmfight_chain_decide()
{
	wait 0.1;	//to fix bug with allies.size = 0 

	farm_trigger_right = getent ("farmhouse_friendlychain_right", "targetname");
	farm_allies_left = getent("farmhouse_allies_left", "targetname");
	allies = getaiarray ("allies");
	println("allies.size = " + allies.size);

	//take the magic bullet shield off of two (maybe one) of your teammates
//	allies[randomint(allies.size)] notify("stop magic bullet shield");
//	allies[randomint(allies.size)] notify("stop magic bullet shield");
	level thread friend_redshirt("barn gunners died");
		
	//which side of farm is player on?	
	if(level.player istouching(farm_trigger_right))
		level.player.rightside = true;
	else
		level.player.rightside = false;

	//which side of the farm are the AI on (look stupid if they switch in the heat of battle)
	for(i = 0; i < allies.size; i++)
	{
		if(allies[i] istouching(farm_allies_left))
		{
			allies[i].rightside = false;
		}
		else
			allies[i].rightside = true;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//now the next part handles how the allies proceed towards the house...they stick to their own sides, but if you're on their side
	//they'll follow a friendly chain (make it look more natural), if they are on the oppisite side than you, then they'll just pick a 
	//random node and fight in that area (that would be similar to what they would do if they were on that side's friendly chain)
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if(level.player.rightside)
	{
		//guys on right side
		chain = get_friendly_chain_node ("250a");
		//guys on left side
		node = getnodearray("farmhouse_firstrun_left", "targetname"); 
		for(i = 0; i < allies.size; i++)
		{
			if(allies[i].rightside)
				allies[i] setgoalentity(level.player);
			else
				allies[i] setgoalnode(node[randomint(node.size-1)]);
		}
	}
	else
	{
		//guys on left side
		chain = get_friendly_chain_node ("250b");
		//guys on right side
		node = getnodearray("farmhouse_firstrun_right", "targetname"); 
		for(i = 0; i < allies.size; i++)
		{
			if(!allies[i].rightside)
				allies[i] setgoalentity(level.player);
			else
				allies[i] setgoalnode(node[randomint(node.size-1)]);
		}
	}
	//set the friendly chain
	level.player SetFriendlyChain (chain);
	
	//move up?
	flag_wait("farmhouse mg42 dead");
	
	//which side of farm is player on?	
	if(level.player istouching(farm_trigger_right))
		level.player.rightside = true;
	else
		level.player.rightside = false;
	//handle the allies
	if(level.player.rightside)
	{
		//guys on right side
		chain = get_friendly_chain_node ("255a");
		//guys on left side
		node = getnodearray("farmhouse_secondrun_left", "targetname"); 
		for(i = 0; i < allies.size; i++)
		{
			if(!isalive(allies[i]))
				continue;
			if(allies[i].rightside)
				allies[i] setgoalentity(level.player);
			else
				allies[i] setgoalnode(node[randomint(node.size-1)]);
		}
	}
	else
	{
		//guys on left side
		chain = get_friendly_chain_node ("255b");
		//guys on right side
		node = getnodearray("farmhouse_secondrun_right", "targetname"); 
		for(i = 0; i < allies.size; i++)
		{
			if(!isalive(allies[i]))
				continue;
			if(!allies[i].rightside)
				allies[i] setgoalentity(level.player);
			else
				allies[i] setgoalnode(node[randomint(node.size-1)]);
		}
	}
	//set the friendly chain
	level.player SetFriendlyChain (chain);
	
	//move up?
	flag_wait("farmhouse guy1 dead");
	flag_wait("farmhouse guy2 dead");
	if(flag("allies in the house") || flag("farmhouse empty"))
	{
		for(i = 0; i < allies.size; i++)
		{
			if(!isalive(allies[i]))
				continue;
			allies[i].goalradius = allies[i].oldgoalradius;
			allies[i].script_followmax = randomint(2) - 3;
			allies[i].script_followmin = randomint(7) * -1;
		}
		return;
	}
	enterSouth = getnodearray("farmhouse_enter_nodes_S", "targetname");
	enterEast = getnodearray("farmhouse_enter_nodes_E", "targetname");
	eastnum = 0;
	southnum = 0;
	
	for(i = 0; i < allies.size; i++)
	{
		if(!isalive(allies[i]))
				continue;
		if(allies[i].rightside)
		{
			if(eastnum < enterEast.size)
			{
				allies[i] setgoalnode(enterEast[eastnum]);
				eastnum++;
			}
			else if(southnum < enterSouth.size)
			{
				allies[i] setgoalnode(enterSouth[southnum]);
				southnum++;
			}
			else
			{
				allies[i] setgoalnode(enterEast[eastnum - enterEast.size]);	
				eastnum++;
			}
		}
		else 
		{
			if(southnum < enterSouth.size)
			{
				allies[i] setgoalnode(enterSouth[southnum]);
				southnum++;
			}
			else if(eastnum < enterEast.size)
			{
				allies[i] setgoalnode(enterEast[eastnum]);
				eastnum++;
			}
			else
			{
				allies[i] setgoalnode(enterSouth[southnum - enterSouth.size]);	
				southnum++;
			}
		}
		allies[i].goalradius = allies[i].oldgoalradius;
		allies[i].script_followmax = randomint(2) - 3;
		allies[i].script_followmin = randomint(7) * -1;
	}
	flag_set("farmhouse allies ready");
}

farmfight_start()
{
	trigger = getent ("enterhouse", "targetname");
	thread house_chain(trigger);
	
	level waittill ("farmfight start");
	
	level.player.ignoreme = false;
	
//	thread farmfight_chain_decide();
	
	spawners1 = getentarray ("farmguys1", "targetname");
	spawners2 = getentarray ("farmguys_runners", "targetname");
	
	level.farmguy = 0;
	level.runners = 0;

        maps\_utility_gmi::array_levelthread(spawners1,::farmguys1_think);
        maps\_utility_gmi::array_levelthread(spawners2,::farmguys2_think);  
    
  	wait 3;	//stagger the mg34 guys

    	spawners3 = getentarray ("farmguy_mg42", "targetname");
	level.mg42guys = spawners3.size;
		maps\_utility_gmi::array_levelthread(spawners3,::farmguysMG42_think);  
	thread farmwindows_open();
        
}
	
bustdoorguy_think(spawners)
{
	spawners.count = 1;
	doorguy = spawners stalingradSpawn();
	if (maps\_utility_gmi::spawn_failed(doorguy))
		return;
	doorguy.goalradius = 64;
}

farm_bustdoorSND(gate_origin)
{
	dist = 4000;
	move = spawn("script_origin", (0,0,0));
	move.origin = (gate_origin[0] - dist, gate_origin[1], gate_origin[2]);
	move playloopsound("kubel_engine_high");
	farm_bustdoorMoveSND(move, dist);
	move stoploopsound("kubel_engine_high");
	
	//skid sound
	move playsound("stop_skid");
	wait 1;

	//break gate
	move playsound ("Tank_gate_breakthrough", "sounddone");
	move waittill("sounddone");
	
	level notify("car guys arrived");
	println("^3car guys arrived");
	
	move playsound("car_door_close_loud", "sounddone");
	move waittill("sounddone");
	move playsound("car_door_close_loud", "sounddone");
	move waittill("sounddone");
//	wait .1;
//	move playsound("car_door_close_loud", "sounddone");
//	move waittill("sounddone");
	
	//german yelling
	println("^3YELL!!!");
	move playsound("generic_misccombat_german_1");
	wait 2;
	move playsound("generic_misccombat_german_2");
}

farm_bustdoorMoveSND(move, dist)
{
	end = (move.origin[0] + dist, move.origin[1], move.origin[2]);
 	move moveTo(end, 2.5, 0, .15);	//was.7 changed to 2
 	move waittill ("movedone");
}

farm_bustdoor()
{
	trigger = getent("farmhouse_bustdoorTrigger", "targetname");
	trigger waittill ("trigger");
	trigger delete();
	
	//spawn dudes on the second floor
	spawners = getentarray("farmguy_2ndfloor", "targetname");
	level.farm2ndflrguys = spawners.size;
		maps\_utility_gmi::array_levelthread(spawners,::farm2ndflrguy_think);
	thread house_empty_check();
	
	//show the truck busting through the gate
	house_gate = getent ("bustdoor_delete", "targetname");
	house_car = getentarray("bustdoor_car", "targetname");
	thread farm_bustdoorSND(house_gate getorigin());
	house_gate delete();
	
	for(i=0; i < house_car.size; i++)
	{
		house_car[i] show();
		house_car[i] thread maps\_utility_gmi::triggerOn();
	}

	//spawn the dudes behind the door and get one of em to kick the door down
	spawner1 = getentarray ("bustdoorguys","targetname");
		maps\_utility_gmi::array_levelthread(spawner1,::bustdoorguy_think);
	spawner2 = getent("bustdoorguys_kicker","targetname");
	while (!isdefined (kicker))
	{
		wait (0.1);
		kicker = spawner2 stalingradspawn();
	}
	
	kicker endon ("death");
	kicker.health = 50000;
	kicker.animname = "generic";
	kicker.allowDeath = false;

	level waittill("car guys arrived");

	node = getnode (kicker.target,"targetname");
	if (randomint (100) > 50)
		kicker thread anim_single_solo (kicker, "kick door 1", undefined, node);
	else
		kicker thread anim_single_solo (kicker, "kick door 2", undefined, node);

	kicker waittillmatch ("single anim", "kick");
	house_door = getent ("farmhouse_bustdoor", "targetname");
	house_door connectpaths();
	house_door rotateyaw (100, 0.2);
	house_door playsound ("wood_door_kick");
	//wait (0.85);
	//house_door playsound ("wood_door_kick");
	//house_door rotateyaw (-30, 0.5, 0, 0.5);
	wait (0.5);
	
	if (isdefined (node.target))
		node = getnode (node.target,"targetname");

	kicker.health = 100;	
	kicker setgoalnode (node);
	if (isdefined (node.radius))
		kicker.goalradius = node.radius;	
}

house_empty_check()
{
	flag_wait("farmhouse empty");
	
	level notify("guys in house died");
	
	allies = getaiarray("allies");
	for(i =0; i < allies.size; i++)
	{
		if(!isalive(allies[i]))
				continue;
		allies[i] setgoalentity(level.player);
		allies[i].goalradius = allies[i].oldgoalradius;
		allies[i].script_followmax = randomint(3) + 4;
		allies[i].script_followmin = randomint(2);
	}
}

farm2ndflrguy_think(spawners)
{
	spawners.count = 1;
	guy = spawners doSpawn();
	if (maps\_utility_gmi::spawn_failed(guy))
	{
		level.farm2ndflrguys--;
		return;
	}
	guy.goalradius = 16;
	guy waittill ("death");
	level.farm2ndflrguys--;
	
	if (level.farm2ndflrguys <= 0)
	{
		//if there's anyone still alive at this point - bumrush the player
		enemies = getaiarray("axis");
		for(i=0; i < enemies.size; i++)
			enemies[i] setgoalentity(level.player);
		flag_set("farmhouse empty");
	}
}

house_chain(trigger)
{
	//must make sure the mg34 gunners are dead (cause people will keep spawning in the house)
	flag_wait("farmhouse mg42 dead");
	
	trigger waittill ("trigger");
	//run the function that handles the dudes kicking the door down
	flag_set("allies in the house");
	//flag_wait("farmhouse allies ready");
	allies = getaiarray("allies");
	nodes = getnodearray("farmhouse_innerguard", "script_noteworthy");
	chain = get_friendly_chain_node ("225");
	level.player SetFriendlyChain (chain);
	//set two guys on the stairs
	if(isdefined(allies[0]))
	{
		allies[0] setgoalentity(level.player);
		allies[0].oldgoalradius = allies[0].goalradius;
		allies[0].goalradius = 16;
		allies[0].script_followmax = 2;
		allies[0].script_followmin = 0;
	}
	if(isdefined(allies[1]))
	{
		allies[1] setgoalentity(level.player);
		allies[0].oldgoalradius = allies[0].goalradius;
		allies[0].goalradius = 16;
		allies[1].script_followmax = -5;
		allies[1].script_followmin = -5;
	}
	for(i=2; i < allies.size; i++)
	{
		if(!isalive(allies[i]))
				continue;
		if(i < nodes.size)
			allies[i] setgoalnode(nodes[i]);
		else
			allies[i] setgoalnode(nodes[i - nodes.size]);
	}
}
	
farmguys1_moveup()
{
	self endon("death");
	node = getnodearray("farmfight_runnernode", "script_noteworthy");
	flag_wait("farmhouse mg42 dead");
	if(flag("allies in the house"))
		return;
	self setgoalnode (node[randomint(node.size)]);
}

farmguys_return()
{
	self endon("death");
	node = getnodearray("farmfight_returnnode", "script_noteworthy");
	flag_wait("allies in the house");
	self setgoalnode (node[randomint(node.size)]);	
}

farmguys1_think(spawners)
{
	spawners.count = 1;
	while(!flag("farmhouse mg42 dead") && spawners.count)
	{
		wait 1.5;
		farmguy = spawners doSpawn();
		if (maps\_utility_gmi::spawn_failed(farmguy))
			return;
		else
			level.farmguy++;
		
		//come back to the house if allies jump into it
		farmguy thread farmguys_return();
		
	//	farmguy.accuracy = .75;
		farmguy thread farmguys1_moveup();
		farmguy waittill ("death");
		level.farmguy--;
		wait 3.0;
	}
	
	if (level.farmguy <= 0)
		flag_set("farmhouse guy1 dead");
}

farmguys2_think(spawners)
{
	spawners.count = 1;
	while(!flag("farmhouse mg42 dead") && spawners.count)
	{
		wait 2;
		runners = spawners doSpawn();
		if (maps\_utility_gmi::spawn_failed(runners))
			return;
		else
			level.runners++;
		//come back to the house if allies jump into it
		runners thread farmguys_return();
		
	//	runners.accuracy = .75;
		runners waittill ("death");
		level.runners--;
		wait 3.5;
	}
	
	if (level.runners <= 0)
		flag_set("farmhouse guy2 dead");
}

farmguysMG42_think(spawners)
{
	spawners.count = 1;
	mg42guy = spawners doSpawn();
	if (maps\_utility_gmi::spawn_failed(mg42guy))
	{
		level.mg42guys--;
		return;
	}
	if(!isdefined(level.mg1))
		level.mg1 = mg42guy;
	else
		level.mg2 = mg42guy;
	mg42guy.health = 1;
//	mg42guy.favoriteenemy = level.player;
	
	mg42guy.goalradius = 4;
	mg42guy.ignoreme = true;
	mg42guy thread farmguysMG42_stayput(spawners.target);
	mg42guy thread farmguysMG42_alwaysshoot(spawners.target);	
	mg42guy waittill ("death");
	level.mg42guys--;
	
	if (level.mg42guys <= 0)
		flag_set("farmhouse mg42 dead");
}

farmguysMG42_alwaysshoot(starget)
{
	self endon("death");
	
	//make sure he always has something to shoot at
	node = getnode(starget, "targetname");
	self setgoalnode(node);
	mg42 = getent(node.target, "targetname");
	if(node.target == "farmhouse_mg42_E")
		temp = getnodearray("farmhouse_firstrun_right", "targetname");
	else
		temp = getnodearray("farmhouse_firstrun_left", "targetname");
	
	//has to be an entity - not a node
	target = [];
	for(i = 0; i < temp.size; i++)
		target[target.size] = spawn("script_origin", temp[i].origin);
		
	mg42 setmode("auto_ai");
	mg42 settargetentity ( target[randomint(target.size)] );
	mg42 endon("deleted");
	while (1)
	{
	//	if(!isalive(mg42))
		//	break;

		mg42 settargetentity ( target[randomint(target.size)] );
		mg42 startfiring();
		wait (0.4 + randomfloat (0.2));
		mg42 stopfiring();
		wait (.1 + randomfloat (0.6));	
	}
}

farmguysMG42_stayput(target)
{
	self endon("death");
	node = getnode(target, "targetname");
	turret = getent (node.target, "targetname");
	while(1)
	{
		wait .5;
		self setgoalnode(node);
		self.goalradius = (4);
		self waittill ("goal");
		self useturret(turret);
	//	self maps\_spawner_gmi::use_a_turret (turret);
	}
}

houseguy_think(spawners)
{
	spawners.count = 1;
	houseguy = spawners doSpawn();
	if (maps\_utility_gmi::spawn_failed(houseguy))
	{
		level.houseguy--;	
		return;
	}
	houseguy.goalradius = 256;
	houseguy waittill ("death");
	
	level.houseguy--;	
}	

barn_init()
{
	level waittill ("guys in house died");
	thread barndoorleft_open();
	thread barndoorright_open();
	thread barndoorsmall1_open();
	
	chain = get_friendly_chain_node ("300");
	level.player SetFriendlyChain (chain);
	thread barninitbackup1();
 
	spawners = getentarray ("barnguy", "targetname");
	level.barnguy = spawners.size;
        maps\_utility_gmi::array_levelthread(spawners,::barnguy_think);
        
        thread truck_attack1();	
}

barninitbackup1()
{
	if (flag("farmhouse mg42 dead"))
		return;
	while(1)
	{
		if(flag("farmhouse mg42 dead"))
		{
			wait 2;
			allies = getaiarray("allies");
			for(i =0; i < allies.size; i++)
				allies[i] setgoalentity(level.player);
			chain = get_friendly_chain_node ("300");
			level.player SetFriendlyChain (chain);	
			break;
		}
		wait .5;
	}
}
	
barnguy_think(spawners)
{
	spawners.count = 1;
	enemy = spawners stalingradSpawn();
	if (maps\_utility_gmi::spawn_failed(enemy))
	{
		level.barnguy--;	
		return;
	}
	
	enemy waittill ("death");
	
	level.barnguy--;
	if (level.barnguy <= 0)
	{
		level notify ("barn gunners died");
	}
}



farmwindows_open()
{
	farmwindowleft = getentarray ("farmhouse_window_left","targetname");
	farmwindowright = getentarray ("farmhouse_window_right","targetname");
	for(i = 0; i < farmwindowleft.size; i++)
	{
		farmwindowright[i] rotateyaw (-130, .5,.4,0);	
		farmwindowleft[i] rotateyaw (130, .5,.4,0);
	}
	level notify("windows_open");
}

barndoorleft_open()
{
	barndoorleft = getent ("barndoorleft","targetname");
	
	barndoorleft connectpaths();
	barndoorleft rotateyaw (-150, .5,.3,0);
	
	barndoorleft waittill("rotatedone");
	
	barndoorleft disconnectpaths();
}

barndoorright_open()
{
	barndoorright = getent ("barndoorright","targetname");
	
	barndoorright connectpaths();
	barndoorright rotateyaw (135, .5,.4,0);
	
	barndoorright waittill("rotatedone");
	
	barndoorright disconnectpaths();
}

barndoorsmall1_open()
{
	smallbarndoor1 = getent ("barnsmalldoor1","targetname");
	
	smallbarndoor1 connectpaths();
	smallbarndoor1 rotateyaw (119, .5,.4,0);
	
	smallbarndoor1 waittill("rotatedone");
	
	smallbarndoor1 disconnectpaths();
}

truck_attack1()
{
	level waittill ("barn gunners died");

	truck1 = getent ("truck1","targetname");
	driver = getent ("truck1_driver","targetname");
	unloadnode = getVehicleNode("auto888","targetname");

	truck1 maps\_truck_gmi::init();
	truck1 maps\_truck_gmi::attach_guys(undefined,driver);
	pathtruck1 = getVehicleNode(truck1.target,"targetname");

	truck1 attachpath (pathtruck1);
		
	wait .1;
	
	//don't start till player closer, reuse trigger
	trigger = getent("farmhouse_caught", "targetname");
	trigger waittill("trigger");
		
	truck1 startPath();
	playfxontag( level._effect["truck_lights"], truck1,"tag_origin");

	chain = get_friendly_chain_node ("350");
	level.player SetFriendlyChain (chain);
	
	//fix potential prog stop - hack
	friends = getaiarray("allies");
	for (i=0; i < friends.size; i++)
	{
		friends[i] setgoalentity(level.player);
		println("^3 FORCING FRIENDS BACK ON CHAIN!!!");
	}

	level.truck1 = 2;
	
	truck1 setWaitNode (unloadnode);
	truck1 waittill ("reached_wait_node");

	//skid sound
	truck1 playsound("dirt_skid");

	truck1 notify ("unload");
	truck1 disconnectpaths();
	
	wait 4;	//let guys get off

	//truck should always die over time
	println("truck1 health is ", truck1.health);
	truck1.health = 1;
	println("truck1 health is ", truck1.health);
	stopattachedfx(truck1);
	truck1 dodamage(truck1.health + 100,(0,0,0));

	println("^3 RADIUS DAMAGE!!!");
	radiusDamage(truck1.origin, 256, 150, 50);

	//trigger hurt for truckattack
	trigger = getent("truck_fire", "targetname");
	trigger thread maps\_utility_gmi::triggerOn(); 

	//keep looping till ai dead
	while(1)
	{
		//check ai
		enemies = getaiarray("axis");
		if(enemies.size <= 0)
		{
			break;
		}

		wait 0.05;
		println("ai is ", enemies.size);
	}
	
	level notify("truck_attack1_done");
}

woods_setup()
{
	level waittill("truck_attack1_done");

	node = getnode("ingram_mark_post_truck", "targetname");
	level.ingram setgoalnode(node);

//	level.ingram anim_reach_solo(level.ingram, "ingram_over_here", undefined, node);
	level.ingram waittill("goal");

	wait 0.5;
	
	level.ingram thread animscripts\shared::lookatentity(level.player, 10, "casual");
	println("Over here! (as they assemble) Alright, we’re done here.  Follow me.");
	level.ingram anim_single_solo(level.ingram, "ingram_over_here", undefined, node);
	
	//update obj to woods
	objective_position (5,(-5928, 10135, 336));

	//turn on chain to woods
	woods_chain = getnode("woods_chain", "targetname");
	level.player SetFriendlyChain (woods_chain);
		
	wait 0.5;
		
	//put ingram back on chain
	level.ingram setgoalentity(level.player);

	//fix potential prog stop - hack
	friends = getaiarray("allies");
	for (i=0; i < friends.size; i++)
	{
		friends[i] setgoalentity(level.player);
		println("^3 FORCING FRIENDS BACK ON CHAIN!!!");
	}

	objective_trigger = getent("near_woods", "targetname");
	objective_trigger waittill("trigger");

	level thread woods_guys();

	//make another redshirt
	level thread friend_redshirt();
	//so friends don't shoot till fight is setup
	level thread friends_pacifist("woods_start");

	//update obj to tunnel
	objective_position (5,(-2108 , 16774 , 1176));

//woods dialog

	level.ingram thread animscripts\shared::lookatentity(level.player, 10, "casual");
	//Doyle, stay close. You’re not shooting from ten thousand feet – you’re in the war now.
	level.ingram anim_single_solo(level.ingram, "ingram_real_war");

	wait 3;

	//Get moving, across this ridge!
	level.ingram anim_single_solo(level.ingram, "ingram_across");

	trigger = getent("hill_guys2_trigger", "targetname");
	trigger waittill("trigger");

	//Spread out! Spread out!
	level.ingram anim_single_solo(level.ingram, "ingram_spreadout");
}

woods_guys()
{
	trigger = getent("woods1_trigger", "targetname");
	trigger waittill("trigger");

	//setup woods1_guys
	spawners = getentarray ("woods1_guys", "targetname");
	level.wood1_guys = spawners.size;
	maps\_utility_gmi::array_levelthread(spawners,::woods_guys_think);



}
woods_guys_think(spawners)
{
	enemy = spawners stalingradSpawn();

	if (maps\_utility_gmi::spawn_failed(enemy))
	{
		level.wood1_guys--;
		return;
	}
	
	enemy waittill ("death");
	
	level.wood1_guys--;
	if (level.wood1_guys <= 0)
	{
		println("^3level.wood1_guys died");
		
		//move guys up
		chain = getnode("hill_chain", "targetname");
		level.player setfriendlychain(chain);
		println("^3guys going to hill");
	}
}

//tunnel before depot
tunnel_depot_dialog()
{
	//move ingram to tunnel
	ingram_move = getent("ingram_tunnel_trigger", "targetname");
	ingram_move waittill("trigger");

	//move group to tunnel	
	tunnel_chain = getnode("tunnel_chain", "targetname");
	level.player SetFriendlyChain (tunnel_chain);
	
	//move ingram to mark
	mark = getnode("ingram_mark_tunnel", "targetname");
	level.ingram setgoalnode(mark);

	//Ingram start talking
	trigger = getent("tunnel_dialog", "targetname");
	trigger waittill("trigger");
	
//	level.ingram waittill("goal");

	level.ingram anim_reach_solo(level.ingram, "ingram_depot", undefined, mark);

	wait 0.5;

	level.ingram thread animscripts\shared::lookatentity(level.player, 10, "casual");

	//"Quiet lads.  Doyle get over here.  
	//(pause) We’ve got to get through this tunnel. Expect the worst – this has been a picnic up until now."
	level.ingram anim_single_solo(level.ingram, "ingram_depot", undefined, mark);

	//update obj to bridge
	objective_position (5,(4175, 16891, 1176));
	maps\_utility_gmi::autosave(6);

	//put ingram back on friendly chain
	level.ingram setgoalentity(level.player);
	
	// send group to depot
	depot_chain = getnode("depot_chain", "targetname");
	level.player SetFriendlyChain (depot_chain);

//	make guys vulnerable, except for 2
	friends = getentarray("resistance", "groupname");
	for(i=0; i < (friends.size - 3); i++)
	{
		friends[i] notify("stop magic bullet shield");
		println(friends[i].script_friendname," is fair game");
		println("resistance is ", friends.size);
	}
}

depot_setup()
{
	trigger = getent("depot_trigger", "targetname");
	trigger waittill("trigger");
	println("^depot_guy triggered");

	spawners = getentarray ("depot_guys1","targetname");
	level.depot_guy = spawners.size;
	maps\_utility_gmi::array_levelthread(spawners,::depot_guy_think);

	//setup bunkerguys
	spawners = getentarray ("bunkerguy","targetname");
	level.bunkerguy = spawners.size;
	maps\_utility_gmi::array_levelthread(spawners,::bunkerguy_think);
	
	println("^2level.bunkerguy size is ", level.bunkerguy);
}

depot_guy_think(spawners)
{

	enemy = spawners stalingradSpawn();
	println("^3depot guys  ", level.depot_guy );

//	spawners waittill ("spawned",enemy);

	if (maps\_utility_gmi::spawn_failed(enemy))
	{
		level.depot_guy--;
		return;
	}
	
	enemy waittill ("death");
	level.depot_guy--;

	if (level.depot_guy <= 0)
	{
//		level notify ("bunker guys died");
		println("^depot_guy guys died");
			
//		// guys move up
//		chain =  getnode("depot_chain2", "targetname");
//		level.player SetFriendlyChain (chain);
//		println("^3guys should move up");
	}	
}
//BRIDGE SCENE
bunkerguy_think(spawners)
{
	spawners waittill ("spawned",enemy);

	//	fix for patch bug 332, breaking progression by bunker
	
	if(level.vandyke_kill < 1)
	{
		level thread bunkerguy_kill();
		println("^3bunkerguy kill threaded, only once");
		level.vandyke_kill = 1;
	}

	if (maps\_utility_gmi::spawn_failed(enemy))
	{
		level.bunkerguy--;
		return;
	}
	
	enemy waittill ("death");
	
	level.bunkerguy--;
	if (level.bunkerguy <= 0)
	{
		level notify ("bunker guys died");
		println("^3bunker guys died");
	}
}

//friendly dies and drops explosive
bunkerguy_kill()
{
	//wait for player to trigger
	//	trigger = getent("bunker_trigger", "targetname");
	//	trigger waittill("trigger");
	

	//move ingram to mark
	mark = getnode("ingram_mark_bunker", "targetname");
	level.ingram setgoalnode(mark);

	//Bunker on the right – get some grenades in there!
	level.ingram thread anim_single_solo(level.ingram, "ingram_bunker");
	
	van_dyke = getent("van_dyke","targetname");
	van_dyke.goalradius = 16;
	van_dyke.bravery = 5000;

	mark = getnode("van_dyke_die", "targetname");
	van_dyke setgoalnode(mark); 

	van_dyke waittill("goal");
	println("^3 van dyke will die!!!!!!");
	
	level thread bunkerguy_pickup_bomb(van_dyke.origin);

	van_dyke notify ("stop magic bullet shield");
	
	//play gunshot sound
	van_dyke playsound ("weap_kar98k_fire");
	van_dyke dodamage(van_dyke.health + 1000, (0,0,0));
	van_dyke setflaggedanimknoball("deathanim", %corner_death_pushup, %root, 1, .05, 1);
}

bunkerguy_pickup_bomb(van_dyke_origin)
{
	//drop explosive
	println("^3 guy will drop explosive!!!!!!");
	bomb = spawn("script_model", van_dyke_origin + (0,0,4));
	bomb setmodel("xmodel/explosivepack");
	bomb.angles = (90, 180, 0);

	level waittill("ingram_charges");

	wait 6; 	//synch up with end of 1st line
	
	println("^3 updating compass and objectives!!!!!!");
	//update objectives
	//pickup explosives, point compass to bomb.origin
	objective_string(5, &"GMI_TRAINBRIDGE_OBJECTIVE_5_PICKUP");
	objective_position (5,(bomb.origin));
	bomb thread bomb_position();

	bomb setmodel("xmodel/mp_explosivepack_objective");
	
	println("^3 bomb.origin ", bomb.origin);

	//trigger for player to pickup explosives
	pickup_trigger = getent("pickup_bomb", "targetname");
	pickup_trigger.origin = bomb.origin;
	pickup_trigger setHintString (&"SCRIPT_HINTSTR_PICKUPEXPLOSIVES");
	pickup_trigger waittill("trigger");
	println("^3 player picked up explosive!!!!!!");
	
	//obj completed
	level notify("bombs_acquired");

//	//bombs acquired, change variable
	level.bombs = 1;

	level thread objective_5_check();
//	level thread Event_bridge_dialog();

	pickup_trigger delete();
	bomb delete();
}

//makes compass keep flashing to position of explosive
bomb_position()
{
	
	level endon("bombs_acquired");	//end

	while(level.bombs == 0)
	{
		objective_position(5, self.origin);
		objective_ring(5);
		wait 0.7;
		println("^1in loop should be obj is bomb!!!!");
	}
}


// move guys to bridge area
Event_bridge_setup()
{
	level waittill ("bunker guys died");
	
	//sends guys to the bridge
	maps\_utility_gmi::chain_off ("425");
	maps\_utility_gmi::chain_off ("420");
	maps\_utility_gmi::chain_off ("421");


	chain = get_friendly_chain_node ("450");
	level.player SetFriendlyChain (chain);

	//move ingram to mark
	mark = getnode("ingram_mark_bridge", "targetname");
	level.ingram setgoalnode(mark);
//	level.ingram waittill("goal");

	level thread Event_bridge_dialog();
}

Event_bridge_dialog()
{
	//trigger
	trigger = getent("near_bridge", "targetname");
	trigger waittill("trigger");

	level notify("ingram_charges");

	println("^3 van_dyke is down!!!");
	//Van Dyke is down! Doyle! Make yourself useful -- grab his charges, get down those ladders -- and plant them on the lower arches of that bridge.
//	level.ingram playsound("ingram_grab_charges");
//	level.ingram anim_single_solo(level.ingram, "ingram_grab_charges");

	//The rest of you provide covering fire. When we’re finished, we’ll meet up on that ridge.
//	level.ingram playsound("ingram_grab_charges2");
//	level.ingram anim_single_solo(level.ingram, "ingram_grab_charges2");

	level.scr_anim["ingram"]["ingram_grab_charges1and2"]		= (%c_br_trainbridge_ingram_grab_charges_1and2);

	level.scr_notetrack["ingram"][0]["notetrack"]              	="ingram_grab_charges"; 
     	level.scr_notetrack["ingram"][0]["dialogue"]                	="ingram_grab_charges"; 
     	level.scr_notetrack["ingram"][0]["facial"]                	=(%f_trainbridge_ingram_grab_charges); 

	level.scr_notetrack["ingram"][1]["notetrack"]              	="ingram_grab_charges2"; 
     	level.scr_notetrack["ingram"][1]["dialogue"]                	="ingram_grab_charges2"; 
     	level.scr_notetrack["ingram"][1]["facial"]                	=(%f_trainbridge_ingram_grab_charges2); 

	node = getnode("ingram_mark_bridge", "targetname");

	level.ingram anim_reach_solo(level.ingram, "ingram_grab_charges1and2", undefined, node);
	wait 0.5;
	
	level.ingram thread animscripts\shared::lookatentity(level.player, 15, "casual");
	level.ingram anim_single_solo(level.ingram, "ingram_grab_charges1and2", undefined, node);

	maps\_utility_gmi::autosave(7);

	level notify("show_charges");
	println("^3 show_charges!!");

	while(level.bombs == 0)
	{
		wait 1;
		println("^1in loop waiting for bomb acquired!!!");
	}

	wait 1;

	//move ingram to bridge
	mark = getnode("ingram_bridge_cover", "targetname");
	level.ingram setgoalnode(mark);

	level waittill("on_bridge");
	println("^3 on_bridge message received");
	
	level.ingram.ignoreme = true;
	level.ingram thread animscripts\shared::lookatentity(level.player, 10, "casual");
	//Have you got them planted?  Good. (under attack, to squad) Fall back!
	level.ingram anim_single_solo(level.ingram, "ingram_them_planted");

	level thread Event_bridge_enemy();
	
	//move ingram to detonator
	mark = getnode("ingram_mark_detonator", "targetname");
	level.ingram setgoalnode(mark);

	wait 3;
	level.ingram.ignoreme = false;
}

//fake the splash sound off bridge
bridge_fall()
{
	println("^3bridge_fall threaded!!!");

	spawners = getentarray("wet_germans", "groupname");
	println("^3 SPAWNERS.size is", spawners.size);
	maps\_utility_gmi::array_levelthread(spawners,::bridge_fall_sound);
}


bridge_fall_sound(spawners)
{
	level endon("on_bridge"); //quick fix for when we delete enemies before bridge explodes

	spawners waittill ("spawned",enemy);

	println("^3wet_germans spawned!!!");
	println("wet german enemy.health ", enemy.health );

	enemy waittill("death");
	println("^3wet_germans waiting...");
	if(isdefined(enemy.script_balcony) && enemy.script_balcony && enemy.anim_pose == "stand")
	{
		//Quick check to see if he is using balcony death
		enemy waittill("balcony_death");

		while(enemy.origin[2] > -38)	//-38 is the surface of the water
		{
			wait 0.05;
			if(!isdefined(enemy))
			{
				break;
			}
		}

		if(isdefined(enemy))
		{
			//play splash sound
			enemy playsound("bodyfall_water_large");
			println("^3SPLASH!!!");
		}
	}
}

bridge_german1()
{
	trigger = getent("german1_stop_him", "targetname");
	trigger waittill("trigger");
	level.player playsound("german1_stop_him");
}

bridge_german2()
{
	trigger = getent("bridge_west2", "targetname");
	trigger waittill("trigger");
	level.player playsound("german1_up_there");
}

bridge_german3()
{
	trigger = getent("bridge_east1", "targetname");
	trigger waittill("trigger");
	level.player playsound("german2_look_out");
}

Event_bridge()
{
	level thread Event_bridge_blow();
	level thread Event_bridge_train();
	level thread Event_bridge_sounds();
	level thread event_bridge_toofar();
	level thread event_bridge_compass();
	level thread bridge_fall();


	//german chatter on bridge
	level thread bridge_german1();
	level thread bridge_german2();
	level thread bridge_german3();
	
	//bombs
	plant_bomb_triggers = getentarray("bombplant_trigger", "targetname");
	for(i = 0; i < plant_bomb_triggers.size; i++)
	{
		//hide model till bombs acquired
		plantedmodel = getent(plant_bomb_triggers[i] .target, "targetname");
		plantedmodel hide();
		
		// turn off triggers		
		plant_bomb_triggers[i] thread maps\_utility_gmi::triggerOff();
	}

	level waittill("bombs_acquired");

	//bombs can be planted
	for(i = 0; i < plant_bomb_triggers.size; i++)
	{
		//turn on triggers		
		plant_bomb_triggers[i] thread maps\_utility_gmi::triggerOn();
		
		//show model
		plantedmodel = getent(plant_bomb_triggers[i] .target, "targetname");
		plantedmodel show();

		thread Event_bridge_plant(plant_bomb_triggers[i]);
	}

	level.bombs_count = plant_bomb_triggers.size;
}

//handles bombs and tracks how many planted
Event_bridge_plant(trigger)
{
	trigger setHintString (&"SCRIPT_HINTSTR_PLANTEXPLOSIVES");
	trigger waittill("trigger");

	// Change model to planted version and delete trigger
	plantedmodel = getent(trigger.target, "targetname");
	plantedmodel setmodel("xmodel/explosivepack");
	plantedmodel playsound("explo_plant_no_tick");

	if(!isdefined(trigger.script_noteworthy))
	{
		println("^1trigger.script_noteworthy IS NOT DEFINED");
	}
	else
	{
		name = trigger.script_noteworthy;
		level.bomb_flag[name] = true;
	}		


	level notify("bomb_planted");	

	trigger delete();

	level.bombs_count--;	

	if(level.bombs_count > 0)
	{
		
		if(level.bombs_count == 2)
		{
			level notify("2bombs_planted");
			println("^32bombs planted!!!");
		}

		if(level.bombs_count == 1)
		{
			
			level notify("3bombs_planted");
			println("^33bombs planted!!!");
		}
	
//		// Insert "OBJECTIVE ADD" here
//		objective_string(6, &"GMI_TRAINBRIDGE_OBJECTIVE_6_TRACKER", level.bombs_count);

	}
	else
	{
		level notify("all_bombs_planted");
		println("^3all_bombs_planted");

		//We’ve got to blow this thing and go!
		level.ingram anim_single_solo(level.ingram, "ingram_blow");		

		objective_add(6, "active", &"GMI_TRAINBRIDGE_OBJECTIVE_6", (4068 , 16810, 1176));
		level thread objective_6_check();
		maps\_utility_gmi::autosave(8);			
	}
}

event_bridge_compass()
{
	level waittill("bombs_acquired");
	
	index = 0;
	bombs = 4;

	//Plant charge #1
	objectivemarker[0] = getent( (getent("bomb_0", "script_noteworthy")).target, "targetname");			

	//Plant charge #2
	objectivemarker[1] = getent( (getent("bomb_1", "script_noteworthy")).target, "targetname");			

	//Plant charge #3
	objectivemarker[2] = getent( (getent("bomb_2", "script_noteworthy")).target, "targetname");			

	//Plant charge #4
	objectivemarker[3] = getent( (getent("bomb_3", "script_noteworthy")).target, "targetname");	

	objective_add(6, "active", &"GMI_TRAINBRIDGE_OBJECTIVE_6", objectivemarker[index].origin);
	objective_string(6, &"GMI_TRAINBRIDGE_OBJECTIVE_6_TRACKER", bombs);					
	objective_current(6);
		
	while(bombs>0)
	{
		level waittill("bomb_planted");

		bombs--;
		println("^3 3bombs remaining ", bombs);

		//	bomb just got planted
		//	check to see if the next bomb in the order has been planted
		//	if it hasn't update the marker to it
		//	if it has, check the other 2 bombs and mark the first one of them
		
		name = "bomb_" + index;
		while(level.bomb_flag[name] == true)
		{
			index++;
			if(index>2) index = 0;
			name = "bomb_" + index;
			wait 0.05;
			if(level.bomb_flag["bomb_0"] == true && level.bomb_flag["bomb_1"] == true && level.bomb_flag["bomb_2"] == true && level.bomb_flag["bomb_3"] == true) continue;
		}

		//
		//
		//
		//

		objective_position(6, (objectivemarker[index].origin) );
		objective_ring(6);
		objective_string(6, &"GMI_TRAINBRIDGE_OBJECTIVE_6_TRACKER", bombs);				
	}
}


// handles bridge and train sounds
event_bridge_sounds()
{
	//stage 1 sound
	println("^3 event_bridge_sounds");
	level waittill("2bombs_planted");
	println("^3 2bombs_planted sounds");

	blend = spawn( "sound_blend", (0,0,0) );
	whistle = spawn("script_origin", (11054 , 16768 , 1440));

	//move to tunnel entrance
	blend.origin = (11054 , 16768 , 1440);

	//blend  
	for (i=0;i<0.4;i+=0.01)
	{
		blend setSoundBlend( "train_loop_distant_low", "train_loop_distant_high", i );
		wait (0.13);
	}

	//play train whistle
	whistle playsound("train_whistle_very_distant_01");

	wait 1;

	//(shouting from a distance) Here comes the train, Doyle!  Hurry up!
//	level.ingram playsound("ingram_herecomes_train");
	level.ingram anim_single_solo(level.ingram, "ingram_herecomes_train");
	
	//stage 2 sound
	level waittill("3bombs_planted");
	println("^3 3bombs_planted sounds");

	//blend  
	for (i=.4;i<0.7;i+=0.01)
	{
		blend setSoundBlend( "train_loop_distant_low", "train_loop_distant_high", i );
		wait (0.3);
	}

	//play train whistle
	whistle playsound("train_whistle_very_distant_02");

	wait 1;	

	//Doyle – hurry up!
	level.ingram anim_single_solo(level.ingram, "ingram_doyle_hurry");

	//stage 3 sound	
	level waittill("on_bridge");
	println("^3 on_bridge sounds");

	//blend  
	for (i=.7;i<1;i+=0.01)
	{
		blend setSoundBlend( "train_loop_distant_low", "train_loop_distant_high", i );
		wait (0.17);
	}

	//play train whistle
	whistle playsound("train_whistle_distant");

	//stage 4 sound
	level waittill("start_train");

	level thread player_tries_to_rush_train();	// pony - added this due to a bug where the player could run in front of train
	
	wait 3.5; 	//added because pushed train back in tunnel
	
	for (i=1;i>0;i-=0.1)
	{
		blend setSoundBlend( "train_loop_distant_low", "train_loop_distant_high", i );
		wait (0.1);
	}

	level waittill("bridge_explode");

	blend delete();
}

player_tries_to_rush_train()
{
	level.player_fail = getent("player_fail", "targetname");

	level.player_fail endon("pony train passed");

	level.player_fail waittill("trigger");

	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
	missionFailed();
}

event_bridge_sound_train()
{
	level waittill("start_train");

	wait 1.8;		//to synch with pushing train back

	self playsound("train_approach");

	wait 3;

	self playsound("train_whistle");
	
	level waittill("bridge_explode");

	//synch with first bomb
	wait 0.75;
	sound = spawn("script_origin", (7000, 16500, 700));
	sound playsound("train_bridge_wreck");
}

//spawns bridge enemies
Event_bridge_enemy()
{
	//manage_spawners(strSquadName,mincount,maxcount,ender,spawntime,a,b,c)
	level thread maps\_squad_manager::manage_spawners("alpha", 1, 4,"near_detonator", 1,::squad_init_stand);	
}

squad_init_stand()
{
	self.goalradius = 128;		// goal radius is a good thing to set in the initialization 
	self.accuracy = .2;
	//self.bravery = 1000;         	// you can set any other parameters you want here
       	self allowedstances("stand");
	self thread maps\_squad_manager::advance();
}


Event_bridge_blow()
{
	//brushmodel and collision
	detonator = getent("temp_detonator", "targetname");
	detonator1 = getent("detonator", "targetname");
	detonator hide();
	detonator1 hide();

	//get trigger on bridge
	on_bridge = getent("on_bridge", "targetname");
	on_bridge thread maps\_utility_gmi::triggerOff();


	//make trigger unavailable till we need it
	detonator_trigger = getent("detonator_trigger", "targetname");
	detonator_trigger thread maps\_utility_gmi::triggerOff();
	
	level waittill ("all_bombs_planted");
	
	//unveil brushmodel
	detonator show();
	detonator1 show();

	//chain stuff
	maps\_utility_gmi::chain_on ("500");
//	maps\_utility_gmi::chain_off ("bridge_chain");	

	level.player.ignoreme = false;
	
	friends = getaiarray ("allies");
	for (i=0;i<friends.size;i++)
	{
		//make guys run from fight
		friends[i].bravery = 1000;
	}

	//trigger on_bridge trigger
	on_bridge thread maps\_utility_gmi::triggerOn();
	on_bridge waittill("trigger");	
	level notify("on_bridge");
	
	//BRIDGE EXPLOSION
	trigger = getent ("watch_explosion_trigger", "targetname");
	trigger waittill ("trigger");
	level notify("near_detonator");
	
	//stop fighting
	enemies = getaiarray("axis");
	for(j=0; j < enemies.size; j++)
	{
		enemies[j] delete();
		println("deleting bridge enemies");
	}

//	level.ingram waittill("goal");
	node = getnode("ingram_mark_detonator", "targetname");

	level.ingram anim_reach_solo(level.ingram, "ingram_detonate1", undefined, node);
	wait 0.5;
	level.ingram thread animscripts\shared::lookatentity(level.player, 10, "casual");
//	("Well done. Since you did all the work I'll give you the honors. Detonate on my command.");
	level.ingram anim_single_solo(level.ingram, "ingram_detonate1", undefined, node);
	level.ingram waittillmatch("single anim", "end");
	level.ingram thread ingram_loop_idle_anim();

	//Blow Up Bridge When Train Arrives.
	objective_string(7, &"GMI_TRAINBRIDGE_OBJECTIVE_7");

	// make trigger available
	detonator_trigger thread maps\_utility_gmi::triggerOn();
	detonator_trigger setHintString (&"GMI_SCRIPT_TRAINBRIDGE_DETONATE");	//change to wait for command

	maps\_utility_gmi::autosave(9);

	
	for (i=0;i<friends.size;i++)
	{
		//in case a friend dies...awwh
		if(isalive(friends[i]))
		{
			friends[i].accuracy = .2;
		}
	}

	level notify("start_train");
	
	
	// thread mission fail
	level thread Event_bridge_failed();
//	//make trigger available
//	detonator_trigger thread maps\_utility_gmi::triggerOn();

	detonator_trigger thread Event_bridge_ready();
//	detonator_trigger thread Event_bridge_not_ready();

	wait 3;
	//stop idle	
	level notify("stop_ingram_waiting");
	// Wait...wait!
	level.ingram anim_single_solo(level.ingram, "ingram_wait_wait");
	level.ingram thread ingram_loop_idle_anim();

	// make trigger available
	level waittill("stop_ingram_waiting");
//	detonator_trigger thread maps\_utility_gmi::triggerOn();
	detonator_trigger setHintString (&"GMI_SCRIPT_HINTSTR_USEDETONATOR");
	
	level waittill("bridge_blown");

	//animate detonator
	detonator1 playsound("detonator");
	detonator1 useanimtree(level.scr_animtree["detonator"]);
	detonator1 setanimknobrestart(level.scr_anim["detonator"]["plunger"]);

	level waittill("bridge_explode");

	level thread falling_debris("bridge_debris");
	level thread falling_debris("train");
	level thread falling_debris("train_car");

	//bridge explosions
	for(j = 1; j < 5; j++)
	{	
		bombs = getent("bridge_bomb" + j, "targetname");
		maps\_utility_gmi::exploder(bombs.script_exploder);
		bombs playsound("big_blast");
		wait 0.75;
	}
	
	//post bomb fx
	level thread Event_bridge_fx();
//	//Arch by player
//        maps\_fx_gmi::loopfx("bridge_fire",     (6085, 16765, 590), .4);
//
//	//under hanging car
//        maps\_fx_gmi::loopfx("bridge_fire",     (7342, 16756, 1100), .4);
//
//        //Arch away from player
//        maps\_fx_gmi::loopfx("bridge_smoke",    (7595, 16765, 672), .6);
//
//        //pillar base
//        maps\_fx_gmi::loopfx("bridge_fire",     (7030, 16746, 100), .5);
// 	
	//don't start chase right away
	wait (8);

	level notify("bridge_over");
	

	node = getnode("ingram_mark_detonator", "targetname");
	
//	level.ingram thread animscripts\shared::lookatentity(level.player, 10, "casual");
	//We just woke up every German from here to Berlin! Fall back to the farmhouse.
//	level.ingram playsound("ingram_woke_up");
	println("^5 ingram woke up");
	level.ingram anim_single_solo(level.ingram, "ingram_woke_up", undefined, node);

	//success/autosave
	level thread objective_7_check();

	//back to the depot
	level.ingram setgoalentity(level.player);
	chain = get_friendly_chain_node ("600");
	level.player SetFriendlyChain (chain);
}

ingram_loop_idle_anim()
{
	level endon ("stop_ingram_waiting");
	while (1)
	{	
		level.ingram thread anim_single_solo(level.ingram, "ingram_waiting", undefined, undefined);
		level.ingram waittillmatch ("single anim","end");
	}
}

Event_bridge_fx()
{
	//post bomb fx

        //Arch by player
        maps\_fx_gmi::loopfx("bridge_fire_h",     (6085, 16765, 590), .4);

        //under hanging car
        maps\_fx_gmi::loopfx("bridge_fire_h",     (7342, 16756, 1100), .4);

        //Arch away from player
        maps\_fx_gmi::loopfx("bridge_smoke",    (7595, 16765, 672), .6);

       	//pillar base
        maps\_fx_gmi::loopfx("bridge_fire_h",     (7030, 16746, 75), .5);

        //top large
        maps\_fx_gmi::loopfx("bridge_fire_l",     (5270, 16860, 1125), .5);

        //top medium
        maps\_fx_gmi::loopfx("bridge_fire_m",     (5588, 16861, 1125), .5);

       	//top small a
        maps\_fx_gmi::loopfx("bridge_fire_s",     (5414, 16712, 1153), .5);

    	//top small b
        maps\_fx_gmi::loopfx("bridge_fire_s",     (5755, 16667, 1133), .5);
}

//success function
Event_bridge_ready()
{
	level endon ("train passed");
	
	level waittill ("train is here");
	
//	// make trigger available
//	self thread maps\_utility_gmi::triggerOn();
//	self setHintString (&"SCRIPT_TRAINBRIDGE_DETONATE");

	//stop idle	
	level notify("stop_ingram_waiting");
	level thread ingram_detonate_anim();

	self waittill("trigger");

	level notify("bridge_blown");
	
	self thread maps\_utility_gmi::triggerOff();
}

ingram_detonate_anim()
{
	println("^6NOW!!");
	level.ingram thread anim_single_solo(level.ingram, "ingram_detonate2");
	level.ingram waittillmatch("single anim", "end");
	level.ingram thread ingram_loop_idle_anim2();
}

ingram_loop_idle_anim2()
{
	level endon("bridge_over");
	while (1)
	{	
		level.ingram thread anim_single_solo(level.ingram, "ingram_looking", undefined, undefined);
		level.ingram waittillmatch ("single anim","end");
	}
}



//player too early - not gonna use
Event_bridge_not_ready()
{
	level endon ("train is here");

	self waittill("trigger");	
//	iprintlnbold ("^5INGRAM: Are you Daft? I said wait for my command!");
//	level.ingram playsound("ingram_daft");
	level.ingram anim_single_solo(level.ingram, "ingram_daft");
}


//kills player for trying to cross bridge
event_bridge_toofar()
{
	trigger = getent("bridge_mg34", "targetname");
	trigger waittill("trigger");
	println("^3 player is trying to cross bridge");

	//spawn mg34
	spawner = getent("bridge_guy", "targetname");
	bridge_guy = spawner stalingradspawn();
	
	//make invulnerable
	bridge_guy thread maps\_utility_gmi::magic_bullet_shield();
	bridge_guy.accuracy = 1;

	wait 5;

	level.player dodamage(level.player.health + 50,level.player.origin);
}

//function moves train
Event_bridge_train()
{
	// start train outside tunnel for lighting
	train= getent("train", "targetname");
	//thread train sound
	train thread event_bridge_sound_train();
	
	//attach player clip to train
	clip = getent("train_clip", "targetname");
	clip connectpaths();
	clip linkto(train);
	
	//rest of train
	trains= getentarray("train_car", "targetname");
	for(i=0; i < trains.size; i++)
	{
	//	moveX(float move, float time, <float acceleration_time>, <float deceleration_time>);
		trains[i] linkto(train);
		trains[i] hide();
	}
//	moveX(float move, float time, <float acceleration_time>, <float deceleration_time>);
//	train movex (6000, .1);
	train movex (7000, .1);

	train hide();
	
	level waittill("start_train");

	train show();

	for(i=0; i < trains.size; i++)
	{
		trains[i] show();
	}
	
//	moveX(float move, float time, <float acceleration_time>, <float deceleration_time>);
//	train movex (-6000, 13);
	train movex (-7000, 14);

	playfxontag( level._effect["train_light"], train,"tag_origin");


//smoke effect
//	if (train.model == "xmodel/vehicle_russian_trainengine")
//		train thread looping_tag_effect ( "train smoke", "TAG_smokestack" );

//	wait(11);
	wait 12;

	level notify("train is here");

	wait(1.5);

	level notify("train passed");
	
	wait(0.5);

	level notify("bridge_explode");
	
	//keep train moving in case of fail
	train movex (-1000, 2);

	wait 2;

	level.player_fail notify("pony train passed");
}

//failure function
Event_bridge_failed()
{
	level endon ("bridge_blown");
	
	level waittill("train passed");

//	iprintlnbold(&"GMI_TRAINBRIDGE_BRIDGE_FAIL");

	wait 0.5;
	setCvar("ui_deadquote", "@GMI_SCRIPT_TRAINBRIDGE_FAIL");
	missionfailed();
}

Falling_Debris(targetname)
{
	debris = getentarray(targetname,"targetname");

	org = spawn("script_model", (0,0,0));

	// Get the anim name.
	for(i=0;i<debris.size;i++)
	{
		if(!isdefined(org.animname))
		{
			if(isdefined(debris[i].script_animname))
			{
				org.animname = debris[i].script_animname;
			}
		}
	}

	println("^2org.animname: ",org.animname);
	// Setup the fake origin.

	org setmodel(("xmodel/trainbridge_bridgedummies"));
	org UseAnimTree(level.scr_animtree["bridge_collapse"]);


	// Link the targets to the org.
	for(i=0;i<debris.size;i++)
	{	
		if(!isdefined(debris[i].script_noteworthy))
		{
			println("^1Script_Noteworthy is needed for Falling_Debris @ (" + self.origin + ")");
			continue;
		}
		else
		{
			if(debris[i].script_noteworthy == "delete")
			{
				debris[i] delete();
			}
			else
			{
				debris[i] linkto(org, debris[i].script_noteworthy,(0,0,0),(0,0,0));
				debris[i] notsolid();
				debris[i] thread debris_debug();

				//the various effects
				org thread Falling_Debris_FX(org, debris[i].script_noteworthy, debris[i]); 
				debris[i] thread Falling_Debris_Sound(org, debris[i].script_noteworthy);
//				org thread Falling_Debris_FX(org, debris[i].script_noteworthy, debris[i], "_fx_water"); 
//				org thread Falling_Debris_FX(org, debris[i].script_noteworthy, debris[i], "_fx_exp"); 
			}
		}
	}

	// Play the animation.
//	org setFlaggedAnimKnobRestart("animdone", level.scr_anim[self.animname]["reactor"]);
	org animscripted("single anim", org.origin, org.angles, level.scr_anim[org.animname]["reactor"]);
//	org thread maps\_anim_gmi::notetrack_wait(org, "single anim", undefined, "reactor");	//temp till add notetracks
	org waittillmatch("single anim","end");
	org notify("stop_looping_fx");

	wait 0.1;
	
	// Unlink the Objects.
	for(i=0;i<debris.size;i++)
	{
		if(isalive(debris[i]))
		{
			debris[i] unlink();
//		debris[i] thread Debris_Solid_Think();
		}
	}

	org delete();
}
debris_debug()
{
	wait 0.1;

	while(1)
	{
		if(self.origin == (0,0,0))
		{
			println("^3debris at origin ", self.script_noteworthy);

		}
		wait 0.1;

	}

}
//Debris_Solid_Think()
//{
//	while(1)
//	{
//		if(distance(level.player.origin, self.origin) > 256)
//		{
//			break;
//		}
//		wait 0.5;
//	}
//
//	self solid();
//}

Falling_Debris_Sound(org, tag)
{
	println("^3Falling_Debris_sound thread!!!");

//	org endon("death");
	while(1)
	{
//		org waittillmatch("single anim",tag + "_sound");
		org waittill("single anim",notetrack);

		println("^3in the sound loop!!! ", notetrack, " TAG: ",tag);

		if(notetrack == tag + "_train_skid")
		{
			println("SOUND (",notetrack,")");
			self playsound("train_skid");
		}
		else if(notetrack == tag + "_stone_water_crash01")
		{
			println("SOUND (",notetrack,")");
			self playsound("stone_water_crash01");
		}
		else if(notetrack == tag + "_stone_water_crash02")
		{
			println("SOUND (",notetrack,")");
			self playsound("stone_water_crash02");
		}
		else if(notetrack == tag + "_stone_water_crash03")
		{
			println("SOUND (",notetrack,")");
			self playsound("stone_water_crash03");
		}
		else if(notetrack == tag + "_stone_water_crash04")
		{
			println("SOUND (",notetrack,")");
			self playsound("stone_water_crash04");
		}
		else if(notetrack == tag + "_stone_water_crash05")
		{
			println("SOUND (",notetrack,")");
			self playsound("stone_water_crash05");
		}
		else if(notetrack == tag + "_stone_water_crash06")
		{
			println("SOUND (",notetrack,")");
			self playsound("stone_water_crash06");
		}
	}
}

Falling_Debris_FX(org, tag, debris) 
{ 
	println("^3Falling_Debris_FX thread!!!");

	println("^waiting for this");
//	org waittillmatch("single anim", (tag + notify_name)); 

	while(1) 
	{
		org waittill("single anim", notify_name);

//		println("^should be playing this", (tag + notify_name));
		println("^3in the while loop!!! ", notify_name, " TAG: ",tag);

		if(!isdefined(debris))
		{
 			println("^3shouldn't see!!!");
			return;
		}

		if(notify_name == "end")
		{
			println("^1END!!!!");
			return;
		}
		else if(notify_name == (tag + "_fx_start")) 
		{
			org thread Falling_Debris_FX_Think(org, tag);
			println("^3Should be playing smoke!!!");
		}
		else if(notify_name == (tag + "_fx_stop")) 
		{
			org notify((tag + "stop_doing_fx")); 
			println("^1Should STOP playing smoke!!!");
		}
		else if(notify_name == (tag + "_fx_water"))
		{ 
			org notify((tag + "stop_doing_fx"));
			playfxontag(level._effect["train_water_impact"], org, tag);
			println("^3Should be water!!!");
		} 
		else if(notify_name == (tag + "_fx_exp"))
		{ 
			playfxontag(level._effect["train_car_exp"], org, tag);
			println("^3Should be exp!!!"); 
		}
		else if(notify_name == (tag + "_fx_steam"))
		{ 
			playfxontag(level._effect["train_car_steam"], org, tag);
			println("^3Should be steam!!!"); 
			debris playsound("train_steam_blast");
		}
		else if(notify_name == (tag + "_delete"))
		{
			println("^1delete!!!!");
			org notify((tag + "stop_doing_fx"));
			debris delete();
		}
	} 
} 

Falling_Debris_FX_Think(org, tag)
{
	org endon((tag + "stop_doing_fx"));
	while(1)
	{
		playfxontag(level._effect["train_trail_smoke"], org, tag);
		wait 0.5;
	}
}

//last piece of bridge falling at end of level
Event_bridge_final()
{
//	level waittill("crossing_bridge");
	wait 3; //synch up

//	level falling_debris("bridge_debris"); //for testing

	tag_model = spawn("script_model", (0,0,0));
	tag_model setmodel("xmodel/trainbridge_bridgedummies_hang");
	tag_model UseAnimTree(level.scr_animtree["bridge_collapse"]);

	debris = getentarray("bridge_debris", "targetname");
	//add train car to debris array
	train_cars = getentarray("train_car","targetname");
	for(j=0; j < train_cars.size; j++)
	{
		if(train_cars[j].script_noteworthy == "tag_car07")
		{
			debris = maps\_utility_gmi::add_to_array(debris, train_cars[j]);
		}
	}
 	//animate the select pieces
	for(i=0; i< debris.size; i++)
	{
		if(debris[i].script_noteworthy == "tag_car07" || debris[i].script_noteworthy == "tag_track04" || debris[i].script_noteworthy == "tag_arch07")
		{
			org = spawn("script_origin",(0,0,0));
			org.origin = tag_model gettagorigin(debris[i].script_noteworthy);
			org linkto(tag_model, debris[i].script_noteworthy, (0,0,0), (0,0,0));
			debris[i] linkto(org);
			tag_model thread Falling_Debris_FX(tag_model, debris[i].script_noteworthy, debris[i]); 
			//notetrack for sound
			debris[i] thread Falling_Debris_Sound(tag_model, debris[i].script_noteworthy);
		}
	}
	
	tag_model animscripted("single anim", tag_model.origin, tag_model.angles, level.scr_anim["bridge_hang"]["reactor"]);
	tag_model waittillmatch("single anim","end");
	tag_model notify("stop_looping_fx");
}

//WOODS CHASE

//downhillguys_think(spawners)
//{
//	println("^1downhillguys = " + level.downhillguys);
//	spawners.count = 1;
//	enemy = spawners stalingradSpawn();
//	if (maps\_utility_gmi::spawn_failed(enemy))
//	{
//		level.downhillguys--;	
//		return;
//	}
//	
//	enemy waittill ("death");
//	
//	level.downhillguys--;
//	println("^1downhillguys decrement, total = " + level.downhillguys);
//
//	if (level.downhillguys <= 0)
//	{
//		println("^3downhill guys died, should only see once");
//		
////		iprintlnbold("INGRAM: Ok lets get back to the lorry. Follow me!");
//		level.ingram playsound("ingram_follow");
//
//		println("^downhillguys died, should be 0 " + level.downhillguys);
//	
//		chase_trigger = getentarray ("chase_trigger","script_noteworthy");
//		for(i = 0; i < chase_trigger.size; i++)
//		{
//			chase_trigger[i] thread maps\_utility_gmi::triggerOn();
//		}
//		
//		chain = get_friendly_chain_node ("600");
//		level.player SetFriendlyChain (chain);
//		
//		spawners = getentarray ("downhill_guy2", "targetname");
//		level.downhillguys2 = spawners.size;
//		
//		//reuse trigger, let player get closer
//		trigger = getent("bunker_trigger", "targetname");
//		trigger waittill("trigger");
//		println("^3downhill2 triggered");
//
//	        maps\_utility_gmi::array_levelthread(spawners,::downhillguys2_think);
//	}
//}


downhillguys2_setup()
{
	level waittill("bridge_blown");

	spawners = getentarray ("downhill_guy2", "targetname");
	level.downhillguys2 = spawners.size;

	maps\_utility_gmi::array_levelthread(spawners,::downhillguys2_think);
//	level waittill("bridge_over");
		
	//so friends won't shoot till enemy is closer
	level thread friends_pacifist("bunker_trigger");

	//reuse trigger, let player get closer
	trigger = getent("bunker_trigger", "targetname");
	trigger waittill("trigger");
	println("^3downhill2 triggered");
 
	//spawn script origin
	yell = spawn("script_origin",(2148, 15866, 1172));
	println("^3 YELL triggered");
	yell playsound("generic_misccombat_german_2");

	//make another redshirt
	friends = getentarray("resistance", "groupname");
	println("resistance is ", friends.size);
	if(friends.size > 2)
	{
		for(i=0; i < (friends.size - 2); i++)
		{
			friends[i] notify("stop magic bullet shield");
			println(friends[i].script_friendname," is fair game");
		}
	}
}

downhillguys2_think(spawners)
{
	spawners.count = 1;
	enemy = spawners stalingradSpawn();
	if (maps\_utility_gmi::spawn_failed(enemy))
	{
		level.downhillguys2--;	
		return;
	}
	//allow the spawn
	wait 0.1;
	enemy.pacifist = true;

	enemy waittill ("death");
	
	level.downhillguys2--;
	if (level.downhillguys2 <= 0)
	{
		println("^3downhill2 guys died, only see once");
	
		//iprintlnbold("INGRAM: The tunnel is not safe! Cut through the forest!");
//		level.ingram playsound("ingram_thru_forest");
		level.ingram anim_single_solo(level.ingram, "ingram_thru_forest");

		chain = get_friendly_chain_node ("650");
		level.player SetFriendlyChain (chain);
	
		level notify("start_tunnel_halftrack");

		//turn chase trigger on
		chase_trigger = getent("chasegroup_1_trigger","targetname");
		chase_trigger thread maps\_utility_gmi::triggerOn();

		level notify("chase_begins");
	}
}

//halftrack in tunnel
downhill_halftrack()
{
	//so teleport doesn't fail
	level waittill("bridge_blown");	

	//delete halftrack clip
	ht_clip = getent("halftrack_clip", "targetname");
	ht_clip delete();
	println("^3 *** HT clip deleted");

	//block tunnel with halftrack
	clip = getent("block_tunnel", "targetname");
	clip thread maps\_utility_gmi::triggerOn();

	tunnel_halftrack = getent("tunnel_halftrack", "targetname");
	tunnel_halftrack thread maps\_halftrack_gmi::init("reached_end_node");
		
//	level thread test();

	level waittill("start_tunnel_halftrack");

	tunnel_halftrack startpath();
	playfxontag( level._effect["truck_lights"], tunnel_halftrack,"tag_origin");

	level thread downhill_block();
	tunnel_halftrack waittill ("reached_end_node");
	println("^3 *** HT Reached node");

	tunnel_halftrack disconnectpaths();
}


//kill player trying to get through tunnel

downhill_block()
{
	trigger = getent("depot_trigger", "targetname");
	trigger waittill("trigger");
	println("^3 *** crossing tunnel_block");
	wait .5;
	level.player dodamage(level.player.health + 100, level.player.origin);
}


chasegroup()
{
	level waittill("chase_begins");
	
	spawners = getentarray ("chasegroup_1", "targetname");
	level.chasegroup1 = spawners.size;
	maps\_utility_gmi::array_levelthread(spawners,::chasegroup1_think);
	
	//so friends won't shoot till enemy is closer
	level thread friends_pacifist("chase_group1_near");
	
	level waittill("chase1_spawned");

//	iprintlnbold("INGRAM: Wait here! Let's give them a little surprise.");
//	level.ingram playsound("ingram_surprise");
	level.ingram anim_single_solo(level.ingram, "ingram_surprise");

	//check if player shoots
	level thread chasegroup1_playerfired();

	level waittill("chase1_dead");
	
	//turn trigger on
	chase_trigger = getent("chasegroup_2_trigger","targetname");
	chase_trigger thread maps\_utility_gmi::triggerOn();

	spawners = getentarray ("chasegroup_2", "targetname");
	level.chasegroup2 = spawners.size;
	maps\_utility_gmi::array_levelthread(spawners,::chasegroup2_think);

	//so friends won't shoot till enemy is closer
	level thread friends_pacifist("chase_group2_near");
	
	level waittill("chase2_spawned");

	level thread chasegroup2_shack();

	yell = spawn("script_origin",(-512, 11142, 1080));
	println("^3 YELL triggered");
	yell playsound("generic_enemysighted_german_1vbritish");

//	They’re back behind us – take them out.
//	level.ingram playsound("ingram_back_behind");
	level.ingram anim_single_solo(level.ingram, "ingram_back_behind");

	//check if player shoots
	level thread chasegroup2_playerfired();
	     
	spawners = getentarray ("chasegroup_3", "targetname");
	level.chasegroup3 = spawners.size;
	maps\_utility_gmi::array_levelthread(spawners,::chasegroup3_think);
}

chasegroup1_think(spawners)
{
	println("^3chasegroup1 = " + level.chasegroup1);

	spawners waittill ("spawned",enemy);

	level notify("chase1_spawned");

	if (maps\_utility_gmi::spawn_failed(enemy))
	{
		level.chasegroup1--;
		return;
	}
	
	enemy thread chasegroup1_unpacify();
	enemy thread chasegroup1_prevent();

	enemy waittill ("death");

	//keep track of enemy
	level.chasegroup1--;
	println("^3chasegroup1 = " + level.chasegroup1);

	if (level.chasegroup1 <= 0)
	{
		println("^3chasegroup1 died, see once");
		level notify("chase1_dead");
		
		//update objective position to chase2
		objective_position (8,(-916 , 10637 , 861));
		maps\_utility_gmi::autosave(11);

		//(whispered) Alright, let’s move.
		level.ingram anim_single_solo(level.ingram, "ingram_lets_move");

		//turn on next chain	
		chain = get_friendly_chain_node ("700");
		level.player SetFriendlyChain (chain);

		wait 5;

		//(whispered) Keep quiet...
		level.ingram anim_single_solo(level.ingram, "ingram_keep_quiet");
	}
}

chasegroup1_playerfired()
{
	level endon("chase1_dead");
	i = 0;
	while (i == 0)
	{
		if(level.player attackButtonPressed())
		{
			i = 1;
			println("^3 *********** PLayer fired ********************");
			println("^3 *********** PLayer fired ********************");
			level notify ("chasegroup1_fight");
			break;
		}
		wait 0.05;
	}
}
// awaken enemy group prematurely
chasegroup1_unpacify()
{
	self endon("death");
	level waittill("chasegroup1_fight");
	self.pacifist = false;
}


//prevent rambo like behavior, listen to ingram 
chasegroup1_prevent()
{
	self endon("death");
	println("^3chase1_prevent waiting");

	trigger = getent("chase1_prevent", "targetname");
	trigger waittill("trigger");
	println("^3chase1_prevent triggered, take that!!!");
	
	self.pacifist = false;
	self.favoriteenemy = level.player;
	self.health = 350;
	self.accuracy = 1;
	self setgoalentity(level.player);
	println("ramboguy accuracy is ", self.accuracy);
	println("ramboguy health is ", self.health);
}


friends_pacifist(trigger_name)
{
	//pacify friends
	friends = getaiarray ("allies");
	for (i=0;i<friends.size;i++)
	{
		friends[i].pacifist = true;
		friends[i].bravery = 1000;
	}
	println("^3 friend should be pacifists");
	println("^3 friend should be pacifists");

	//enemy is close...
	println("^3 trigger is ",trigger_name);

	trigger = getent(trigger_name,"targetname");
	trigger waittill ("trigger");
		
	//unpacify enemies
	enemies = getaiarray("axis");
	for (i=0;i<enemies.size;i++)
	{
		enemies[i].pacifist = false;
	}
	println("^3 friend should be fighting");
	println("^3 friend should be fighting");
	//unpacify friends
	for (i=0;i<friends.size;i++)
	{
		if(isalive(friends[i]))
		{
			friends[i].pacifist = false;
		}
	}
}

//picks closest friend and makes him vulnerable
friend_redshirt(message)
{
	//array of excluder
	exclude = getentarray("ingram","targetname");
	add = getent("van_dyke", "targetname");
	exclude = maps\_utility_gmi::add_to_array(exclude, add);

	//get closestAI
	redshirt = maps\_utility::getClosestAI (level.player getorigin(), "allies", exclude);

	//make him a redshirt
	redshirt notify("stop magic bullet shield");
	println("^5guy is a redshirt!!!",redshirt.script_friendname);

	//might be cool is if we could check every few secs, moving bullseye, endon death

	if(isdefined(message))
	{
		//wait for notify
		level waittill(message);
		println("^5message is ", message);

		//check if alive, if so make invulnerable again
		if(isalive(redshirt))
		{
			redshirt thread maps\_utility_gmi::magic_bullet_shield();
			println("^5guy is safe!!!");
		}
	}
}


chasegroup2_think(spawners)
{
	println("^3chasegroup2 " + level.chasegroup2);
	spawners waittill ("spawned",enemy);
	println("^3chasegroup2 spawned");

	if (maps\_utility_gmi::spawn_failed(enemy))
	{
		level.chasegroup2--;
		return;
	}

	level notify("chase2_spawned");

	enemy thread chasegroup2_prevent();
	enemy thread chasegroup2_unpacify();

	enemy waittill("death");
	
	level.chasegroup2--;
	println("^3chasegroup2 decrement, now = " + level.chasegroup2);

	if (level.chasegroup2 <= 0)
	{
		println("^3chasegroup2 died, see once");
		println("^3chasegroup2 should be 0 " + level.chasegroup2);

		//update objective position to barn
		objective_position (8,(-857, 5476, 320));

		maps\_utility_gmi::autosave(12);
		
		level notify("chase2_dead");
	}
}

//prevent rambo like behavior
chasegroup2_prevent()
{
	self endon("death");
	println("^3chase2_prevent waiting!!!!");
	println("^3chase2_prevent waiting!!!!");

	trigger = getent("chase2_prevent", "targetname");
	trigger waittill("trigger");
	println("^3chase2_prevent triggered, take that!!!");
	
	self.pacifist = false;
	self.favoriteenemy = level.player;
	self.health = 350;
	self.accuracy = 1;
	println("ramboguy accuracy is ", self.accuracy);
	println("ramboguy health is ", self.health);
}

chasegroup2_playerfired()
{
	level endon("chase2_dead");
	i = 0;
	while (i == 0)
	{
		if(level.player attackButtonPressed())
		{
			i = 1;
			println("^3 *********** PLayer fired ********************");
			println("^3 *********** PLayer fired ********************");
			level notify ("chasegroup2_fight");
			break;
		}
		wait 0.05;
	}
}
// awaken enemy group prematurely
chasegroup2_unpacify()
{
	self endon("death");
	level waittill("chasegroup2_fight");
	self.pacifist = false;
}
#using_animtree("generic_human");
chasegroup2_shack()
{
	level waittill("chase2_dead");

	wait 1;
	
	// send group to fence
	fence_chain = getnode("fence_chain", "targetname");
	level.player SetFriendlyChain (fence_chain);
	
	//send ingram to gate
	node = getnode("shack_gate_node", "targetname");
	level.ingram.goalradius = 16;
	level.ingram setgoalnode(node);
	level.ingram waittill("goal");
	println("^3ingram reached goal");

	//wait for player
	kick_trigger = getent("near_gate", "targetname");
	Kick_trigger waittill("trigger");

	// kick gate
	level.ingram thread anim_single_solo (level.ingram, "kick door 1", undefined, node);
	level.ingram waittillmatch ("single anim", "kick");

	gate = getent("shack_gate", "targetname");
	gate connectpaths();
	gate rotateyaw (-90, 0.3);
	gate playsound ("gate_open_fast");

	//Alright – hurry up! Go!
	level.ingram.animname = "ingram";
	level.ingram anim_single_solo(level.ingram, "ingram_alright_go2");

	// guys go on chain to barn
	chain =  getnode("wall_chain", "targetname");
	level.ingram setgoalentity(level.player);
	level.player SetFriendlyChain (chain);
	println("^3guys should be at wall");

	//when see farmhouse
	trigger = getent("chase_group3_near", "targetname");
	trigger waittill("trigger");
	
	println("There it is, lads – steady now...");
	level.ingram thread anim_single_solo(level.ingram, "ingram_there_she_is");
//	level.ingram playsound("ingram_there_she_is");
	
	wait 3;

	yell = spawn("script_origin",(-2474, 6656, 224));
	println("^3 YELL triggered");
	yell playsound("generic_enemysighted_german_1vbritish");
	println("^3 YELL played");

	//trigger to truck, reuse old trigger
	go_truck = getent("near_house", "targetname");
	go_truck waittill("trigger");
	println("^3guys should be going to truck");

	chain = get_friendly_chain_node ("800");
	level.player SetFriendlyChain (chain);
}

chasegroup3_think(spawners)
{
	spawners waittill ("spawned",enemy);
	if (maps\_utility_gmi::spawn_failed(enemy))
	{
		level.chasegroup3--;
		return;
	}
	//so friends won't shoot till enemy is closer
//	level thread friends_pacifist("chase_group3_near");

	enemy waittill ("death");
	
	level.chasegroup3--;
	if (level.chasegroup3 <= 0)
	{
		println("^3chasegroup3 died");
		
		//update objective position
		objective_position (8,(-857, 5476, 320));
		
		chain = get_friendly_chain_node ("800");
		level.player SetFriendlyChain (chain);
	}
}


//TRUCK RIDE
truckRide_Manager()
{
	thread truckRide_setup();
	thread truckRide_healthregen();
	thread truckRide_geton();
	thread truckRide_attack1();
	thread truckRide_start();
	thread truckRide_tankstart();
	thread truckRide_tankaim();
	level.playerTruck thread truckRide_bumpyRide();
	thread truckRide_crashGate();
	thread truckRide_tankStop();
	thread truckRide_skid();
	thread truckRide_treeSound();	
//	thread truckRide_secondstart();
}

truckRide_healthregen()
{
	level endon("stop_regen");

	while(1)
	{
		level.playerTruck.health = 20000;
		wait .05;
	}
}

truckRide_health()
{

	while(level.playerTruck.health > 0)
	{
		println("^5level.playerTruck.health is ",  level.playerTruck.health);
		wait 1;
	}

	while(1)
	{
		println(" mission should fail, truck dead!!!!");
		wait 0.5;
	}
}

truckRide_tankaim()
{
	flag_wait("tank ready");
	//aim the turret at the first spot
	tanktarget = getent ("tunneltank_miss1","targetname");
	level.tunneltank setTurretTargetEnt( tanktarget, (0,0,0) );
	flag_wait("tank miss truck 1");
	//fire (and miss) when we first see truck
	level.tunneltank thread maps\_panzeriv_gmi::fire();
	earthquake(0.45, 1, level.player.origin, 5000);	
	playfx(level._effect["mortar_explosion"], tanktarget getorigin());
	tanktarget = getent ("tunneltank_miss2","targetname");
	level.tunneltank setTurretTargetEnt( tanktarget, (0,0,0) );
	flag_wait("tank miss truck 2");
	//fire (and miss) when we're in the turn
	level.tunneltank thread maps\_panzeriv_gmi::fire();
	earthquake(0.45, 1, level.player.origin, 5000);	
	playfx(level._effect["mortar_explosion"], tanktarget getorigin());
	level.tunneltank clearTurretTarget();
}
//truckRide_secondstart()
//{
//	level waittill ("ReadyToRide2");
//	level.playerTruck2 setspeed(35, 6);
//	wait(1.0);
//	level.playerTruck2 resumespeed(5);
//
//	//ingram end speech
//	node = getvehiclenode("auto1206", "targetname");
//	level.playerTruck2 setwaitnode(node);
//	level.playerTruck2 waittill ("reached_wait_node");
////	iprintlnbold("INGRAM: Not bad for an RAF bloke Doyle. You may have a future in this line of work. Let's see if we can get you back to England in one piece");
//	level.ingram playsound("ingram_england");
//	level thread objective_9_check();
//
//	//temp end level
//	node = getvehiclenode("level_end", "targetname");
//	level.playerTruck2 setwaitnode(node);
//	level.playerTruck2 waittill ("reached_wait_node");
//	missionSuccess("gmi_uk_mid", false);
//}
truckRide_tankstart()
{
	flag_wait("ally panzer shot");
	wait 4;
	level.tunneltank = getent("tunneltank", "targetname");
	level.tunneltank maps\_panzeriv_gmi::init();
	path = getVehicleNode(level.tunneltank.target,"targetname");
	level.tunneltank attachpath(path);
   	level.tunneltank startpath();
    	flag_set("tank ready");
    
    	path = getVehicleNode("tunneltank_stop1", "targetname");
    	level.tunneltank setwaitnode(path);
    	level.tunneltank waittill("reached_wait_node");
    	level.tunneltank setspeed(1, 5);	//was 0 but no tank moving sound
}
truckRide_attack1()
{
	level.playerTruck waittill ("ReadyToRide1");	
	
	truck = getent ("truck70","targetname");
	driver = getent ("truck70_driver","targetname");
	driver.health = 100000;

	truck maps\_truck_gmi::init();
	truck maps\_truck_gmi::attach_guys(undefined,driver);
	startnode = getVehicleNode(truck.target,"targetname");
	truck attachpath (startnode);
	truck.health = 100000;
	//make sure the timing is right (to run into you at the right moment)	
	wait 5.85;

	truck startPath();
	playfxontag( level._effect["truck_lights"], truck,"tag_origin");
	
	flag_wait ("ally panzer shot");

	thread truckRide_truckflip(truck, "truck70_guy");
}
//truckRide_geton2()
//{
//	level waittill("Get Back In Truck");
//
//	
//	//get back on
//	level.playerTruck2.tagcycle = 8;	
//	allies = getaiarray ("allies");
//	level.allySize = allies.size;
//	for(i = 1; i < allies.size; i++)
//		allies[i] thread truckRide_allies_JumpIn2();
//	
//	if(allies.size)
//	{
//		//dont foget about the driver
//		allies[0] thread truckRide_driver_JumpIn(level.playerTruck2);
//		
//		//wait till everyone's in
//		while(allies.size - 1 + level.playerTruck2.tagcycle != 8) { wait .5; }
//	}
//
//	
//	//do we wanna go yet?
//	TruckTrigger_geton = getent ("truck2_geton", "targetname");
//	TruckTrigger_geton thread maps\_utility_gmi::triggerOn();
//	TruckTrigger_geton waittill ("trigger");
//	
//	tagorg = TruckTrigger_geton getorigin();
//	level.player allowLeanLeft(false);
//	level.player allowLeanRight(false);
//	level.player allowCrouch(false);
//	level.player allowProne(false);
//	wait 0.05;
//	
//	/*****lets actually move the player in the truck*****/
//		//link player to entity we can safely manipulate
//		moveorg = spawn("script_origin",level.player.origin);
//		moveorg.angles = level.player.angles;
//		level.player linkto (moveorg);
//		//move player to center of truck back
//		tagorg = (tagorg[0], tagorg[1], level.player.origin[2]);
//		movetime = (1.0/100.0)*(float)(distance(level.player.origin, tagorg));
//		moveorg moveTo(tagorg, movetime, 0, 0);
//		moveorg waittill ("movedone");
//		//climb the entity (with linked player) onto truck
//		tagorg = level.playerTruck2 getTagOrigin("tag_player");
//		tagorg = (level.player.origin[0] + 1.0, level.player.origin[1], ((tagorg[2] - level.player.origin[2]) * .5) + level.player.origin[2]);
//		moveorg moveTo(tagorg, .5, .1, .1);
//		moveorg waittill ("movedone");
//		tagorg = level.playerTruck2 getTagOrigin("tag_player");
//		tagorg = (level.player.origin[0] - 1.0, level.player.origin[1], tagorg[2]);
//		moveorg moveTo(tagorg, .5, .1, .1);
//		moveorg waittill ("movedone");
//		//move the entity to the back of the truck
//		tagorg = level.playerTruck2 getTagOrigin("tag_player");
//		moveorg moveTo(tagorg, 1, 0, 0);
//		moveorg waittill ("movedone");
//	
//	//finalize it
//	//redundant?
////	tagorg = level.playerTruck getTagOrigin("tag_player"); 
//	moveorg delete();
//	TruckTrigger_geton delete();
////	level.player setorigin ((level.playerTruck getTagOrigin ("tag_player")));
//	level.player playerlinkto (level.playerTruck2, "tag_player", ( 0.1, .6, 0.9 ));	//link the player to the truck
//	wait 1.0;
//	level notify ("ReadyToRide2");	
//	level.player allowLeanLeft(true);
//	level.player allowLeanRight(true);
//	level.player allowCrouch(true);
//	level.player allowProne(true);
//}
//truckRide_attack2_think(guy)
//{
//	guy waittill ("spawned", enemy);
//	enemy waittill("death");
//	level.truckattack2guys--;
//	if(level.truckattack2guys <= 0)
//	{
//		level notify("Get Back In Truck");
//		//cleanup enemy ai
//		enemies = getaiarray("axis");
//		for(j=0; j < enemies.size; j++)
//		{
//			enemies[j] delete();
//			println("deleting enemies");
//		}
//		wait 2;
////		iprintlnbold("^5NOTE: Player may have to nudge guys towards the back/right of truck!!");
//		iprintlnbold(&"GMI_TRAINBRIDGE_TEMP_TRUCK_HINT");
//	}
//}
//truckRide_attack2()
//{
//	startnode = getVehicleNode("attack2start","targetname");
//	driver = getent ("truckRide_driver76","targetname");
//	attachedguys = getentarray("truckRide_guy76", "targetname");
//	
//	level.truckattack2guys = attachedguys.size + 1;//1 for driver
//	
//	level.playerTruck2 = getent ("truck76","targetname");
//	
//
//	maps\_utility_gmi::array_levelthread(attachedguys,::truckRide_attack2_think);
//	thread truckRide_attack2_think(driver);
//	level.playerTruck2 maps\_truck_gmi::init();
//	level.playerTruck2 maps\_truck_gmi::attach_guys(undefined,driver);
//	thread truckRide_geton2();
//	//time it to make sure we ram each other
//	wait 13;
//	level.playerTruck2 attachpath (startnode);
//	level.playerTruck2 startpath();
//	level.playerTruck2.health = 100000;	//prevents bug where truck dies
//	
//	startnode = getVehicleNode("badtruckend", "targetname");
//	level.playerTruck2 setwaitnode(startnode);
//	level.playerTruck2 waittill ("reached_wait_node");
//	level.playerTruck2 setspeed(0, 100);
//	level.playerTruck2 disconnectpaths();
//	level.playerTruck2 notify ("unload");
//	
//}
truckRide_truckPassesby()
{
	//time it to make sure we dont come too early
	startnode = getvehiclenode("spawntruckstart", "targetname");
	driver = getent ("truckRide_driver75","targetname");
	
	passTruck = getent ("truck75","targetname");
	passTruck maps\_truck_gmi::init();
	passTruck maps\_truck_gmi::attach_guys(undefined,driver);
	wait 3;
	passTruck attachpath (startnode);
	passTruck startPath();
	playfxontag( level._effect["truck_lights"], passTruck,"tag_origin");
	level thread truckRide_halftrackPassesby();

	passTruck waittill ("reached_end_node");	
	driver unlink();
	driver delete();
	passTruck unlink();
	passTruck delete();
}

truckRide_halftrackPassesby()
{
	//stagger behind truck
	wait 2;

	//init halftrack
	startnode = getvehiclenode("spawntruckstart", "targetname");
	halftrack = getent("halftrack_passby", "targetname");
	halftrack thread maps\_halftrack_gmi::init();
	halftrack attachpath (startnode);
	halftrack startPath();
	playfxontag( level._effect["truck_lights"], halftrack,"tag_origin");

	//delete at end of path
	halftrack waittill ("reached_end_node");	
	halftrack unlink();
	halftrack delete();
}

truckRide_setup()
{
	//initialize truck and position it in the right spot
	level.playerTruck = getent ("playertruck","targetname");
	level.playerTruck disconnectpaths();
	level.playerTruck maps\_truck_gmi::init();
//	TruckStartNode = getVehicleNode(level.playerTruck.target,"targetname");
//	level.playerTruck attachpath (TruckStartNode);
	//to make idle sound on truck
	TruckIdleNode = getVehicleNode("idle_node","targetname");
	level.playerTruck attachpath (TruckIdleNode);
	level.playerTruck.tagcycle = 8;
	level.playerTruck thread truckRide_Anim(level.scr_anim["germantruck"]["closedoor_startpose"]);
	//hide the trigger for now
	TruckTrigger_geton = getent ("TruckTrigger_geton", "targetname");
	TruckTrigger_geton thread maps\_utility_gmi::triggerOff();
	TruckTrigger_geton_friend = getent ("TruckTrigger_allies_geton", "targetname");
	TruckTrigger_geton_friend thread maps\_utility_gmi::triggerOff();
	maps\_utility_gmi::chain_off ("623");

	//truck model at farm for end battle
	end_truck = getent("end_truck", "targetname");
	end_truck hide();
	level waittill("chase2_dead");
	end_truck show();
}

truckRide_PanzerDudes_think()
{
	stopnode = getvehiclenode("panzerGuyFire", "targetname");	
	level.playerTruck setWaitNode(stopnode);
	//first guy misses you to get your attention in that area, second guy takes out truck attack 1
	thread flag_setTimed("panzer1 fire", 7);
	thread flag_setTimed("panzer2 fire", 15.2);
	thread truckRide_PanzerDudes_attack("truckRide_panzerdude1", "panzerspot1", 0.0, "panzer1 fire", level.scr_anim["panzer_dude"]["aim"]);
	thread truckRide_PanzerDudes_attack("truckRide_panzerdude2", "panzerspot2", 7.0, "panzer2 fire", level.scr_anim["panzer_dude"]["aim"]);
	maps\_utility_gmi::array_levelthread(getentarray ("truckRide_panzer_backup", "targetname"),::truckRide_PanzerDudes_backup);
	
	//the bazooka should hit the bad guy truck by now
	level.playerTruck waittill("reached_wait_node");
	flag_set("ally panzer shot");
}
truckRide_PanzerDudes_backup(spawners)
{
	wait 1.0;
	spawners.count = 1;
	enemy = spawners doSpawn();
	if (maps\_utility_gmi::spawn_failed(enemy))
	{
//		iprintlnbold ("Panzer Backup FAILED TO SPAWN!!!");
		return;
	}
	enemy allowedStances ("crouch", "stand");
	enemy thread killoffAI(30);
}
truckRide_PanzerDudes_attack(name, spot, startwait, msg, animation)
{
	spawners = getent(name, "targetname");
	goalnode = getnode(spot, "targetname");
	enemy = spawners stalingradSpawn();
	if (maps\_utility_gmi::spawn_failed(enemy))
	{
//		iprintlnbold (name + " FAILED TO SPAWN!!!");
		return;
	}
	enemy.team = "neutral";
	enemy.takedamage = false;
	enemy allowedStances ("crouch");
	
	wait startwait;
	
	enemy setgoalnode(goalnode);
	enemy.goalradius = 4;
	//wait till he gets to the point to aim the panzerfaust
	enemy waittill("goal");
	//point him the right direction
	enemy truckRide_human_loopAnim(animation, goalnode, msg);	
	
	//when it returns from this animation - we'll fire
	enemy shoot();
	enemy.team = "axis";
	enemy.takedamage = true;
	enemy thread killoffAI(30);
}

truckRide_human_loopAnim(animation, node, msg)
{
	while(1)
	{
		self animscripted("done", node.origin, node.angles, animation);
		wait 0.05;
		if(flag(msg))
			return;
	}
}
truckRide_geton()
{
	level waittill ("all_bombs_planted");
	boardtrigger = getent("gate_wood_splinter", "script_noteworthy");
	boardtrigger thread maps\_utility_gmi::triggerOn();
	level notify ("gate_wood_splinter");	
		
	TruckTrigger_geton = getent ("TruckTrigger_allies_geton", "targetname");
	TruckTrigger_geton thread maps\_utility_gmi::triggerOn();
	TruckTrigger_geton waittill ("trigger");
	level notify("near_truck");
	TruckTrigger_geton delete();
	
//	iprintlnbold("INGRAM:Everyone into the truck...let's go…let's go!");
	level.ingram anim_single_solo(level.ingram, "ingram_letsgo");
//	level.ingram playsound("ingram_letsgo");

	//lets pop everyone into the truck
//	allies = getaiarray ("allies");

	//gets everyone except ingram
	friends = getentarray("resistance", "groupname");
	println("^3 friends size is", friends.size);

	allies = [];
		
	//grab only alive ai(not spawners)
	for(n=0; n<friends.size; n++)
	{
		if(issentient(friends[n]))
		{
			println("adding ai to array");
			allies[allies.size] = friends[n];
		}
	}

	if(allies.size > 0)
	{
		friends = allies;
	}

	println("^3 allies size is", allies.size);

	//make them all invulnerable
	for(i = 0; i < allies.size; i++)
		allies[i] thread maps\_utility_gmi::magic_bullet_shield();
		
	wait .1;	//let it update?
	//the driver goes is first and goes first
	if(allies.size > 0)
		allies[0] thread truckRide_driver_JumpIn(level.playerTruck);
		//maps\_utility_gmi::array_levelthread(friend,::truckRide_allies_JumpIn);

	//add ingram to the group
	allies = maps\_utility_gmi::add_to_array(allies,level.ingram);
	println("^3 allies size with ingram", allies.size);

	//put the rest in
	for(i = 1; i < allies.size; i++)
	{
		allies[i] thread truckRide_allies_JumpIn();
	}
	
	level.allySize = allies.size;

	//wait till everyone's in
	while(allies.size - 1 + level.playerTruck.tagcycle != 8) { wait .5; }

//	//force ingram to tag 7, front/left
//	attachedguys = [];
//	attachedguys[attachedguys.size] = allies[1];
//	attachedguys[attachedguys.size] = level.ingram;
//
//	for(i=2; i < allies.size; i++)
//	{
//		attachedguys[attachedguys.size] = allies[i];
//	}
//
//	level.playerTruck thread maps\_truck_gmi::handle_attached_guys(attachedguys);

	//set their new node
	chain = get_friendly_chain_node ("623");
	level.player SetFriendlyChain (chain);

	//Everybody in – let’s move!
	level.ingram thread anim_single_solo(level.ingram, "ingram_everybody_in");
//	level.ingram playsound("ingram_everybody_in");

	//do we wanna go yet?
	TruckTrigger_geton = getent ("TruckTrigger_geton", "targetname");
	TruckTrigger_geton thread maps\_utility_gmi::triggerOn();
	
	TruckTrigger_geton setHintString (&"DAM_GET_IN_TRUCK");

	TruckTrigger_geton waittill ("trigger");

	level thread objective_8_check();

	tagorg = TruckTrigger_geton getorigin();
	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowCrouch(false);
	level.player allowProne(false);
	wait 0.05;
	
	/*****lets actually move the player in the truck*****/
		//link player to entity we can safely manipulate
		moveorg = spawn("script_origin",level.player.origin);
		moveorg.angles = level.player.angles;
		level.player linkto (moveorg);
		//move player to center of truck back
		tagorg = (tagorg[0], tagorg[1], level.player.origin[2]);
		movetime = (1.0/100.0)*(float)(distance(level.player.origin, tagorg));
		moveorg moveTo(tagorg, movetime, 0, 0);
		moveorg waittill ("movedone");
		//climb the entity (with linked player) onto truck
		tagorg = level.playerTruck getTagOrigin("tag_player");
		tagorg = (level.player.origin[0] + 1.0, level.player.origin[1], ((tagorg[2] - level.player.origin[2]) * .5) + level.player.origin[2]);
		moveorg moveTo(tagorg, .5, .1, .1);
		moveorg waittill ("movedone");
		tagorg = level.playerTruck getTagOrigin("tag_player");
		tagorg = (level.player.origin[0] - 1.0, level.player.origin[1], tagorg[2]);
		moveorg moveTo(tagorg, .5, .1, .1);
		moveorg waittill ("movedone");
		//move the entity to the back of the truck
		tagorg = level.playerTruck getTagOrigin("tag_player");
		moveorg moveTo(tagorg, 1, 0, 0);
		moveorg waittill ("movedone");
	
	//finalize it
	//redundant?
//	tagorg = level.playerTruck getTagOrigin("tag_player"); 
	moveorg delete();
	TruckTrigger_geton delete();
//	level.player setorigin ((level.playerTruck getTagOrigin ("tag_player")));
	level.player playerlinkto (level.playerTruck, "tag_player", ( 0.1, .6, 0.9 ));	//link the player to the truck
	wait 1.0;
	//all good guys in - init the dude with the panzer faust and start his logic
	thread truckRide_PanzerDudes_think();
	level.playerTruck notify ("ReadyToRide1");	
	level.player allowLeanLeft(true);
	level.player allowLeanRight(true);
	level.player allowCrouch(true);
	level.player allowProne(true);
}

truckRide_start()
{
//	//we set to go?
//	level.playerTruck waittill("ReadyToRide1");
//	//lets drive!
//	level.playerTruck startPath();
	
	level waittill("start_engine");	
	
	//car idling
	level.playerTruck startPath();
	
	level.playerTruck waittill("ReadyToRide1");

	//thread line so it doesn't mess up timing
	//Step on it, Jeeves!
	level.ingram thread anim_single_solo(level.ingram, "ingram_jeeves");
//	level.ingram playsound("ingram_jeeves");

	//lights on, drive...
	playfxontag( level._effect["truck_lights"], level.playerTruck,"tag_origin");
	TruckStartNode = getVehicleNode(level.playerTruck.target,"targetname");
	level.playerTruck attachpath (TruckStartNode);
}

truckRide_skid()
{
	trigs = getentarray ("skid","targetname");
	for (i=0;i<trigs.size;i++)
		trigs[i] thread truckRide_skid_sound();
}

truckRide_skid_sound()
{
	self waittill ("trigger");
	level.playerTruck playsound("dirt_skid");
}

truckRide_treeSound()
{
	trigger = getent("tree_sound", "targetname");
	
	while(1)
	{
		trigger waittill("trigger");
		level.playerTruck playsound ("movement_foliage");
		wait 0.01;
	}
}

truckRide_crashGate()
{
	gate = getent("gate_wood_splinter", "script_noteworthy");
	gateorg = gate getorigin();
	gate waittill("trigger");
	//also take care of the tank
	breaks = getentarray("tank_whole_wood_gate", "targetname");
	for(i=0; i < breaks.size; i++)
		breaks[i] delete();
	breaks = getentarray("tank_break_wood_gate", "targetname");
	for(i=0; i < breaks.size; i++)
		breaks[i] show();
	
	//when we bust through the gate - do some cool effects
	earthquake(0.45, 1, level.player.origin, 5000);	
	soundorigin = spawn("script_origin", level.player getorigin());
	soundorigin linkto (level.player);

	//hurt player if standing
	if(level.player getstance() != "prone" && level.player getstance() != "crouch")
	{
		level.player dodamage(level.player.health/3, (0,0,0));
		println("^3OUCH!!!");	
	}

	soundorigin playsound ("wood_crash", "sounddone");
	soundorigin waittill("sounddone");
	soundorigin delete();
}

truckRide_tankstop()
{
	flag_wait("ally panzer shot");
	stopnode = getvehiclenode("truckridetankstop", "targetname");	
	level.playerTruck setWaitNode(stopnode);
	level.playerTruck waittill("reached_wait_node");
	flag_set("tank miss truck 1");
	stopnode = getvehiclenode("truckRide_tankmiss2", "targetname");	
	level.playerTruck setWaitNode(stopnode);
	level.playerTruck waittill("reached_wait_node");
	flag_set("tank miss truck 2");
	//run the thread for the next stop
	thread truckRide_stop1();	
}

truckRide_stop1()
{
	//node for line to play
	stopnode = getvehiclenode("auto1220", "targetname");
	level.playerTruck setWaitNode(stopnode);
	level.playerTruck waittill("reached_wait_node");

	//	iprintlnbold ("German Lorry up ahead, Pull off the road and shut off the engine, maybe they won't see us.");
	level.ingram anim_single_solo(level.ingram, "ingram_pullover");
	//	level.ingram playsound("ingram_pullover");

	stopnode = getvehiclenode("TruckRideStop1", "targetname");
	level.playerTruck setWaitNode(stopnode);
	level.playerTruck waittill("reached_wait_node");
	//crap there's bad guys
	level.playerTruck setspeed(0, 20);
	thread truckRide_truckPassesby();
//	thread truckRide_attack2();

	thread truckRide_stop2();
}
truckRide_stop2()
{
	//set next spot to stop (between trees)
	stopnode = getvehiclenode("TruckRideStop2a", "targetname");
	level.playerTruck setWaitNode(stopnode);
	//back the truck up
	stopattachedfx(level.playerTruck);
	level.playerTruck setspeed(15, 6);
	level.playerTruck waittill("reached_wait_node");
	level.playerTruck resumespeed(20);	
	stopnode = getvehiclenode("TruckRideStop2", "targetname");
	level.playerTruck setWaitNode(stopnode);
	level.playerTruck waittill("reached_wait_node");
	//stop it until truck passes
	level.playerTruck setspeed(0, 20);
//		iprintlnbold ("Engine sound and Lights off");
	maps\_utility_gmi::autosave(14);

	wait 3;
	//They’re gone – let’s go
	level.ingram anim_single_solo(level.ingram, "ingram_theyre_gone");
//	level.ingram playsound("ingram_theyre_gone");

	//set when to resume
	stopnode = getvehiclenode("TruckRideStop2b", "targetname");
	playfxontag( level._effect["truck_lights"], level.playerTruck,"tag_origin");
	level.playerTruck setWaitNode(stopnode);
	level.playerTruck setspeed(20, 5);
	level.playerTruck waittill("reached_wait_node");
	level.playerTruck resumespeed(20);

//	//spawn guys near tunnel
//	last = getentarray("patrol2", "targetname");
//	for (i=0; i < last.size; i++)
//	{
//		last[i] stalingradspawn();
//	}

	level thread truckRide_endAttack();

	//trigger line
	node = getvehiclenode("auto1204", "targetname");
	level.playerTruck setwaitnode(node);
	level.playerTruck waittill ("reached_wait_node");
	
	//Get us to that airstrip fast!  Turn right at the bridge...
	level.ingram thread anim_single_solo(level.ingram, "ingram_steponit");

	//ingram end speech
	node = getvehiclenode("auto1211", "targetname");
	level.playerTruck setwaitnode(node);
	level.playerTruck waittill ("reached_wait_node");

	//make stuff fall off bridge
	level notify("crossing_bridge");
	level thread event_bridge_final();

	level.ingram thread animscripts\shared::lookatentity(level.player, 10, "casual");
//	println("INGRAM: Not bad for an RAF bloke Doyle. You may have a future in this line of work. Let's see if we can get you back to England in one piece");
	level.ingram anim_single_solo(level.ingram, "ingram_england");
//	level.ingram playsound("ingram_england");

	level thread objective_9_check();

	//temp end level
	node = getvehiclenode("level_end", "targetname");
	level.playerTruck setwaitnode(node);
	level.playerTruck waittill ("reached_wait_node");
	missionSuccess("gmi_uk_mid", false);

}

//spawns the last attack
truckRide_endAttack()
{
	println("end_guy ready!!");

	//spawn guys near tunnel
	last = getentarray("patrol2", "targetname");
	for (i=0; i < last.size; i++)
	{
		last[i] stalingradspawn();
	}

	spawner = getent("end_panzer", "targetname");
	end_guy = spawner stalingradspawn();
	end_guy waittill("finished spawning");

	wait 0.05;

	end_guy.playpainanim = false;
	end_guy.ignoreme = true;
	end_guy.pacifist = true;
	end_guy.pacifistwait = 0;
//	end_guy.health = 100000;
	end_guy.bravery = 50000;
	end_guy.goalradius = 8;
	end_guy.accuracy = 1.0;
	end_guy.suppressionwait = 0;
	
	end_guy allowedstances("crouch", "stand");

	level notify("stop_regen");
	level.playertruck.health = 500;
	thread truckRide_health();
	level thread truckride_endAttack_think();
		
	node = getvehiclenode("auto1181", "targetname");
	level.playerTruck setwaitnode(node);
	level.playerTruck waittill ("reached_wait_node");
	println("end_guy invulnerable!!");

	if(isalive(end_guy))
	{
		end_guy.pacifist = 1;
		end_guy thread maps\_utility_gmi::magic_bullet_shield();
		targ_pos = level.playerTruck.origin;
//		targ_pos = level.playerTruck.origin + (0, 0, 128);
		// allow ai to shoot while moving, set waitforstop to true
		// FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop)
		end_guy animscripts\combat_gmi::fireattarget(targ_pos, 3, undefined, undefined, undefined, true);
		println("end_guy fired!!");
	}
}

truckride_endAttack_think()
{
	while(1)
	{
		//kill player
		if(level.playertruck.health < 0)
		{
			earthquake(0.45, 1, level.player.origin, 5000);	
			wait .5;
			level.player dodamage(level.player.health + 1000, (0,0,0));
		}

		wait .5;
	}
}

//truckRide_crash()
//{
//	
//	//set when to resume
//	stopnode = getvehiclenode("TruckRideStop2b", "targetname");
//	level.playerTruck setWaitNode(stopnode);
//	level.playerTruck setspeed(25, 5);
//	level.playerTruck waittill("reached_wait_node");
//	level.playerTruck resumespeed(100);
//	
//	//we crashed?
//	stopnode = getvehiclenode("TruckRide_crash", "targetname");
//	level.playerTruck setWaitNode(stopnode);
//	level.playerTruck waittill("reached_wait_node");
//
////	iprintlnbold ("Look out!");
//	level.ingram playsound("ingram_lookout");
//
//	level.playerTruck setspeed(0, 20);
//	earthquake(0.45, 1, level.player.origin, 5000);	
//	
//	//knock off the people
//	thread truckRide_crash_throwPlayer();
//	level.playerTruck waittill("reached_end_node");
//	level.playerTruck disconnectpaths();
//	
//	allies = getaiarray ("allies");
//	allies[0].driving = false;
//	for(i = 0; i < allies.size; i++)
//	{
//		allies[i] thread truckRide_alliesgetout2();
//	}
//	level.playerTruck notify("unload");
//}
////#using_animtree("generic_human");
//truckRide_alliesgetout2(dist)
//{
//	//spot = spawn ("script_origin", (self.origin[0] + 50, self.origin[1] - 50, self.origin[2]))
//	//self linkto(spot);	
//	self unlink();
//	//self teleport((self.origin[0] + 256, self.origin[1] - 256, self.origin[2]));
//	
//	//self.takedamage = true;
//	//self.allowdeath = 1;
//	self.walkdist = self.oldwalkdist;
//	self.goalradius = self.oldgoalradius;
//}
//truckRide_crash_throwPlayer()
//{
//	//throw the player
//	level.player freezeControls(true);
//	level.player Shellshock("default", 4);
//	startnode = spawn("script_origin",level.player.origin);
//	startnode.angles = level.player.angles;
//	level.player linkto (startnode);
//	tempnode = getent("TruckRide_playerFallPos", "targetname");
//	landnode = tempnode.origin;
//	startnode moveTo(landnode, .25, 0, 0);
//	startnode waittill ("movedone");
//	level.player unlink();
//	level.player freezeControls(false);
//	level.player allowLeanLeft(false);
//	level.player allowLeanRight(false);
//	level.player allowProne(true);
//	level.player allowCrouch(false);
//	level.player allowStand(false);
//	wait 1; 
//	level.player allowLeanLeft(true);
//	level.player allowLeanRight(true);
//	level.player allowCrouch(true);
//	level.player allowStand(true);
//	startnode delete();
//}

//what does this do?-JC
truckRide_bumpyRide()
{
	while(1)
	{
		if (self.speed > 200)
		{
			jolt = randomfloat(.5);
			self joltbody((self.origin + (0,0,64)),jolt);
		}
		delay = randomfloat(1);
		wait (delay);
	}
}
#using_animtree("germantruck");
truckRide_truckflip(truck, guys)
{
	//animated truck stuff to init
	truckDummy = spawn("script_model", truck.origin);
	truckDummy.angles = truck.angles;
	truckDummy setmodel(truck.model);
	truckDummy linkto(truck);
	truck hide();
	
	attachedguys = getentarray(guys, "script_noteworthy");

	//temp for AI
	for(i=0; i < attachedguys.size;i++)
	{
		if(issentient(attachedguys[i]))
		{
			attachedguys[i] unlink ();
			attachedguys[i] delete();
		}
	}
		
	//explode
	truck playsound("big_truck_crash");
	playfxOnTag ( level._effect["truckRide_explosion"], truckDummy, "tag_climbnode");
	playfxOnTag	( level._effect["truckRide_fire"], truckDummy, "tag_driver");
	earthquake(0.45, 2, level.player.origin, 2500);	
	playfx(level._effect["mortar_explosion"], truckDummy getorigin());
	stopattachedfx(truck); //turn off lights

	truck setspeed(42, 5);

	//play the animation of the truck flipping
	truckDummy UseAnimTree(#animtree);
	//start animation
	truckDummy setflaggedanimknob("animdone",level.scr_anim["germantruck"]["truckflip"]);
	//truckDummy truckRide_Anim(level.scr_anim["germantruck"]["truckflip"]);
	truckDummy waittillmatch ("animdone", "end sparks (left and right)");
	truck setspeed(0, 10);

}


#using_animtree("germantruck");
truckRide_Anim(animation)
{
	
	self UseAnimTree(#animtree);
	//start animation
	self setflaggedanimknob("animdone",animation);
	self waittillmatch ("animdone","end");
}
truckRide_driver_loop(truck)
{
	self endon ("death");
	self animscripts\shared::PutGunInHand("none");
	while(isdefined(self.driving) && self.driving == true)
	{
		if(truck.speed > 0)
		{
			self.allowdeath = 0;
			self animscripted("animdone", (truck gettagOrigin ("tag_driver")), truck gettagAngles ("tag_driver"), level.scr_anim["truck_driver"]["drive_loop"]);
			self waittillmatch ("animdone","end");
		}
		else
		{
			self.allowdeath = 0;
			self animscripted("animdone", (truck gettagOrigin ("tag_driver")), truck gettagAngles ("tag_driver"), level.scr_anim["truck_driver"]["idle_loop"]);
			self waittillmatch ("animdone","end");
		}
	}
	self.allowdeath = 1;
}

truckRide_driver_JumpIn(truck)
{
	self.oldmaxSightDistSqrd = self.maxSightDistSqrd;
	self.maxSightDistSqrd = 0;
	        
	self endon ("death");
	
	self.oldwalkdist = self.walkdist;
	self.oldgoalradius = self.goalradius;
	self.walkdist = 0;
	self.goalradius = 1;
	
	//make the guy run to the node at the back of the truck
	startorg = getstartOrigin (truck getTagOrigin("tag_driver"), truck getTagAngles("tag_driver"), level.scr_anim["truck_driver"]["jumpin_slow"]);
	self setgoalpos (startorg);
	self waittill ("goal");
	
	//when the guy is at the node make him play the animation and get into the truck
	self animscripted("animloopdone", truck getTagOrigin("tag_driver"), truck getTagAngles("tag_driver"), level.scr_anim["truck_driver"]["jumpin_slow"]);
	truck thread truckRide_Anim(level.scr_anim["germantruck"]["closedoor_slow"]);

	//door sound trickery
	level thread truckRide_driver_door();
	
	self waittillmatch ("animloopdone", "end");
	
	//play truck start and idle
	level notify("start_engine");
	
	//get the next passenger tag and make the guy go to it
	tag = ("tag_driver");
	self linkto (truck, tag, (0, 0, 0), (1, 1, 1));
	self.maxSightDistSqrd = self.oldmaxSightDistSqrd;
	
	//set his driving animation
	self.driving = true;
	self thread truckRide_driver_loop(truck);
}

truckRide_driver_door()
{
	//hack to synch with anim
	wait 2.5;

	//door sound trickery
	org = level.playerTruck.origin+(-10,-10,0);
	level thread maps\_utility::playSoundinSpace ("car_door_close_loud", org);
}

//truckRide_allies_JumpIn2()
//{
//	self.oldmaxSightDistSqrd = self.maxSightDistSqrd;
//	self.maxSightDistSqrd = 0;
//	        
//	self endon ("death");
//	
//	self.oldwalkdist = self.walkdist;
//	self.oldgoalradius = self.goalradius;
//	self.walkdist = 0;
//	self.goalradius = 1;
//	
//	//make the guy run to the node at the back of the truck
//	startorg = getstartOrigin (level.playerTruck2 getTagOrigin("tag_climbnode"), level.playerTruck2 getTagAngles("tag_climbnode"), level.scr_anim["truckriders"]["jumpin"]);
//	self setgoalpos (startorg);
//	self waittill ("goal");
//	
//	//when the guy is at the node make him play the animation and get into the truck
//	self animscripted("animloopdone", level.playerTruck2 getTagOrigin("tag_climbnode"), level.playerTruck2 getTagAngles("tag_climbnode"), level.scr_anim["truckriders"]["jumpin"]);
//	self waittillmatch ("animloopdone", "end");
//	
//	//get the next passenger tag and make the guy go to it
//
//	tag = ("tag_guy0" + level.playerTruck2.tagcycle);
//	goalpos = (level.playerTruck2 getTagOrigin(tag));
//	level.playerTruck2.tagcycle--;
//	dummy = spawn ("script_origin",self.origin);
//	self linkto (dummy);
//	dummy moveto (goalpos, 1, 0.3, 0.3);
//	dummy waittill ("movedone");
//	self unlink();
//	dummy delete();
//	self linkto (level.playerTruck2, tag, (0, 0, 0), (1, 1, 1));
//	self setgoalpos (goalpos);
//	self allowedstances("crouch", "stand");
//	self.maxSightDistSqrd = self.oldmaxSightDistSqrd;
//}
truckRide_allies_JumpIn()
{
	self endon ("death");	//moved up to prevent bug?

	self.oldmaxSightDistSqrd = self.maxSightDistSqrd;
	self.maxSightDistSqrd = 0;
	        
//	self endon ("death");
	
	self.oldwalkdist = self.walkdist;
	self.oldgoalradius = self.goalradius;
	self.walkdist = 0;
	self.goalradius = 1;
	
	//make the guy run to the node at the back of the truck
	startorg = getstartOrigin (level.playerTruck getTagOrigin("tag_climbnode"), level.playerTruck getTagAngles("tag_climbnode"), level.scr_anim["truckriders"]["jumpin"]);
	self setgoalpos (startorg);
	self waittill ("goal");
	
	//when the guy is at the node make him play the animation and get into the truck
	self animscripted("animloopdone", level.playerTruck getTagOrigin("tag_climbnode"), level.playerTruck getTagAngles("tag_climbnode"), level.scr_anim["truckriders"]["jumpin"]);
	self waittillmatch ("animloopdone", "end");
	
	//get the next passenger tag and make the guy go to it

	tag = ("tag_guy0" + level.playerTruck.tagcycle);
	goalpos = (level.playerTruck getTagOrigin(tag));

	self.mytag = level.playertruck.tagcycle;
	println("^3tagcycle is ",level.playerTruck.tagcycle); 
	level.playerTruck.tagcycle--;

	dummy = spawn ("script_origin",self.origin);
	self linkto (dummy);
//	dummy moveto (goalpos, 1, 0.3, 0.3); 	
//	dummy waittill ("movedone");		
	dummy delete();

	self linkto (level.playerTruck, tag, (0, 0, 0), (1, 1, 1));
//	self setgoalpos (goalpos);		
//	self allowedstances("crouch", "stand");
	self allowedstances("crouch");

	self.maxSightDistSqrd = self.oldmaxSightDistSqrd;

	//new idle anim for the ride
	while(1)
	{
		//self animscripted("animloopdone", truck getTagOrigin("tag_driver"), truck getTagAngles("tag_driver"), level.scr_anim["truck_driver"]["jumpin_slow"]);
//		self animscripted("animloopdone", level.playerTruck getTagOrigin(tag), level.playerTruck getTagAngles(tag), level.scr_anim["truck_idle"]["truckidle"]);
		self animscripted("animloopdone", level.playerTruck getTagOrigin(tag), level.playerTruck getTagAngles(tag), level.scr_anim[self.mytag]["truckidle"]);
		self waittillmatch("animloopdone", "end");
//		self waittill("animloopdone");
		println(self.name, " is looping ", self.mytag, "  ",level.scr_anim[self.mytag]["truckidle"]);
		wait .01;
	}
}



//ADDITIONAL FUNCTIONS
killoffAI(time)
{
	self endon ("death");
	wait 10;
	self delete();	
}

get_friendly_chain_node (chainstring)
{
	trigger = getentarray ("trigger_friendlychain","classname");
	for (i=0;i<trigger.size;i++)
	{
		if ((isdefined (trigger[i].script_chain)) && (trigger[i].script_chain == chainstring))
		{
			chain = trigger[i];
			break;
		}
	}

	if (!isdefined (chain))
	{
		maps\_utility_gmi::error ("Tried to get chain " + chainstring + " which does not exist with script_chain on a trigger.");
		return undefined;
	}

	node = getnode (chain.target,"targetname");
	return node;
}	

skipTo_bridge()
{
	wait 0.2;

//	thread Event_bridge_setup();
//	thread Event_bridge();
	
	level notify ("ambush2");
	level.player unlink();
	level.player setorigin((6000 , 16810, 1176));
	
	level notify ("bunker guys died");
	level notify("bombs_acquired");
	level notify("all_bombs_planted");

	friends = getaiarray ("allies");
	x = 32;
	for(i = 0; i < friends.size; i++)
		friends[i] teleport((4700.0 + (x * i), 18238, 1500));

	barndoorleft_open();
	barndoorright_open();
}


temp_different_start()
{
	//temp teleport stuff
	level.player setOrigin ((-3000.0, 7864.0, 400));
	friends = getaiarray ("allies");
	x = 32;
	for(i = 0; i < friends.size; i++)
		friends[i] teleport((-3000.0 + (x * i), 7800, 400)); 
	
	barndoorleft_open();
	barndoorright_open();
	
	wait 8;	
	
	chain = get_friendly_chain_node ("800");
	level.player SetFriendlyChain (chain);
	wait 2;
	level notify ("all_bombs_planted");
}
flag_setTimed(msg, time)
{
	wait time;
	flag_set(msg);
}

flag_wait (msg)
{
	if (!level.flag[msg])
		level waittill (msg);
}

flag_set (msg)
{
	level.flag[msg] = true;
	level notify (msg);
	println("^3 level flag is ", msg);
}

flag (msg)
{
	if (!level.flag[msg])
		return false;

	return true;
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
	maps\_anim_gmi::anim_reach(newguy, anime, tag, node, tag_entity);
}

objectives()
{
	level waittill ("ingram_done");

	//Assist the Resistance.
	objective_add(1, "active", &"GMI_TRAINBRIDGE_OBJECTIVE_1", (3042, 5663 , 376));
	objective_current(1);
		
	level waittill("objective_4_complete");	

	objective_add(5, "active", &"GMI_TRAINBRIDGE_OBJECTIVE_5", (-4350 , 5922 , 224));
	objective_current(5);
	level waittill("objective_5_complete");	
	objective_state(5,"done");

	//Plant Bombs on Bridge.
	objective_add(6, "active", &"GMI_TRAINBRIDGE_OBJECTIVE_6", (6450 , 16885, 1165));
	objective_current(6);
	level waittill("objective_6_complete");	
	objective_state(6,"done");

	//Rendezvous with Ingram and detonator.
	objective_add(7, "active", &"GMI_TRAINBRIDGE_OBJECTIVE_7_INITIAL", (4780 , 18154, 1496));
	objective_current(7);
	level waittill("objective_7_complete");	
	objective_state(7,"done");
	maps\_utility_gmi::autosave(10);

	//Get to Truck in Barn.
	objective_add(8, "active", &"GMI_TRAINBRIDGE_OBJECTIVE_8", (665 , 13374, 1180));
	objective_current(8);
	level waittill("objective_8_complete");	
	objective_state(8,"done");
	maps\_utility_gmi::autosave(13);

	//Escape.
	objective_add(9, "active", &"GMI_TRAINBRIDGE_OBJECTIVE_9", (665 , 13374, 1180));
	objective_current(9);
	level waittill("objective_9_complete");	
	objective_state(9,"done");
}

objective_1_check()
{
	println ("^3 objective_1_complete");
	level notify ("objective_1_complete");
}


objective_5_check()
{
	println ("^3 objective_5_complete");
	level notify ("objective_5_complete");
}

objective_6_check()
{
	println ("^3 objective_6_complete");
	level notify ("objective_6_complete");
}

objective_7_check()
{
	println ("^3 objective_7_complete");
	level notify ("objective_7_complete");
}

objective_8_check()
{
	println ("^3 objective_8_complete");
	level notify ("objective_8_complete");
}
 
objective_9_check()
{
	println ("^3 objective_9_complete");
	level notify ("objective_9_complete");
}   

music()
{
	//from start
	musicplay("trainbridge_atmosphere");
	// play until barn
	near_barn = getent("near_barn", "targetname");
	near_barn waittill("trigger");
	musicstop(2);

	//ridge till depot
	level waittill("truck_attack1_done");
	musicplay("trainbridge_dark");

	//Ingram start talking
	trigger = getent("tunnel_dialog", "targetname");
	trigger waittill("trigger");
	musicstop(2);

	//pickup bomb
	level waittill("show_charges");
	musicplay("trainbridge_dark");
	level waittill("on_bridge");
	musicstop(2);

	//after detonate now
	level waittill("start_train");
	musicplay("trainbridge_crash");

	//from tunnel till last battle
	level waittill("chase_begins");
	musicplay("trainbridge_action");
	level waittill ("near_truck");
	musicstop(2);

	//from truck start
	TruckTrigger_geton = getent ("TruckTrigger_geton", "targetname");
	TruckTrigger_geton waittill ("trigger");
	musicplay("trainbridge_truck");
}


//track_player 
//{ 
//     level thread reach_spot(); 
//     trigger waittill("trigger"); 
//      
//     if(level.flag["miesha_reached_spot"]) 
//     { 
//          level.miesha thread anim_single_solo(level.miesha, "with_body", undefined, node); 
//     } 
//     else 
//     { 
//          level notify("stop_miesha_reach"); 
//          level.miesha thread anim_single_solo(level.miesha, "without_body", undefined, node); 
//     } 
//} 
// 
//reach_spot() 
//{ 
//     level endon("stop_miesha_reach"); 
//     level.miesha anim_reach_solo(level.miesha, "radio_trans_in", undefined, node); 
//     level.flag["miesa_reached_spot"] = true; 
//}   


//	level bombs(6, &"GMI_TRENCHES_OBJECTIVE6", "plant_tank_bomb_use");


//// Explosive Stuff
//bombs(objective_number, objective_text, array_targetname, activate_notify)
//{
//	bombs = getentarray (array_targetname, "targetname");
//	println (array_targetname, " bombs.size: ", bombs.size);
//	level.timersused = 0;
//	for (i=0;i<bombs.size;i++)
//	{
//		bombs[i].bomb = getent(bombs[i].target, "targetname");
//		bombs[i].used = 0;
//		bombs[i] thread bomb_think(activate_notify, array_targetname);
//	}
//
//	if (bombs.size != 0)
//	{
//		remaining_bombs = bombs.size;
//		closest = bomb_get_closest (bombs);
//		if (isdefined (closest))
//		{
//			println("^2Remaining Bombs ",remaining_bombs);
//			println("^2Closest ",closest);
//			println("^2Objective_number ",objective_number);
//			println("^objective_text ",objective_text);
//			objective_add(objective_number, "active", objective_text, (closest.bomb.origin));
//			objective_string(objective_number, objective_text, remaining_bombs);
//		}
//
//		while (remaining_bombs > 0)
//		{
//			level waittill (array_targetname + " planted");
//
//			remaining_bombs --;
//			objective_string(objective_number, objective_text, remaining_bombs);
//
//			closest = bomb_get_closest (bombs);
//			if (isdefined (closest))
//			{
//				objective_position(objective_number, (closest.bomb.origin));
//				objective_ring(objective_number);
//			}
//			else
//			{
//				objective_state(objective_number, "done");
//				temp = ("objective_complete" + objective_number);
//				//println (temp);
//				level notify (temp);
//			}
//		}
//	}
//
//	return;
//}
//
//bomb_get_closest(array)
//{
//	range = 500000000;
//	for (i=0;i<array.size;i++)
//	{
//		if (!array[i].used)
//		{
//			newrange = distance (level.player getorigin(), array[i].origin);
//			if (newrange < range)
//			{
//				range = newrange;
//				ent = i;
//			}
//		}
//	}
//	if (isdefined (ent) )
//		return array[ent];
//	else
//		return;
//}
//
//bomb_think (activate_notify, array_targetname)
//{
//
////	println ("waittill trigger");
//
//	self setHintString (&"SCRIPT_HINTSTR_PLANTEXPLOSIVES");
//
//	if (isdefined (activate_notify))
//	{
//		self maps\_utility_gmi::triggerOff();
//		self.bomb hide();
//
//		level waittill (activate_notify);
//
//		self.bomb show();
//		self maps\_utility_gmi::triggerOn();
//	}
//	self waittill("trigger");
//	//println ("triggered");
//
//	self.used = 1;
//	//iprintlnbold (&"SCRIPT_EXPLOSIVESPLANTED");
//	self.bomb setModel("xmodel/explosivepack");
//	level notify (array_targetname + " planted");
//	if (isdefined (self.target))
//	{
//		level notify (self.target + " planted");
//	}
//
//	self maps\_utility_gmi::triggerOff();
//	
//	self.bomb playsound ("explo_plant_no_tick");
//	
//	if (isdefined (self.script_noteworthy))
//		self waittill (self.script_noteworthy);
//	else
//	{
//		self.bomb playloopsound ("bomb_tick");
//		if (isdefined (level.bombstopwatch))
//			level.bombstopwatch destroy();
//		level.bombstopwatch = newHudElem();
//		level.bombstopwatch.x = 36;
//		level.bombstopwatch.y = 240;
//		level.bombstopwatch.alignX = "center";
//		level.bombstopwatch.alignY = "middle";
//		level.bombstopwatch setClock(10, 60, "hudStopwatch", 64, 64); // count down for 10 of 60 seconds, size is 64x64
//		level.timersused++;
//		wait 10;
//		self.bomb stoploopsound ("bomb_tick");
//		level.timersused--;
//		if (level.timersused < 1)
//		{
//			if (isdefined (level.bombstopwatch))
//				level.bombstopwatch destroy();
//		}
//	}
//
//	//origin, range, max damage, min damage
//	radiusDamage (self.bomb.origin, 350, 3000, 1);
//
//	earthquake(0.25, 3, self.bomb.origin, 1050);
//
//	//NOTIFY THE SCRIPT
//	level notify (array_targetname + " exploded");
//	if (isdefined (self.target))
//	{
//		level notify (self.target + " exploded");
//		level notify (self.target);
//	}
//
//	wait (.5);
//
//	self.bomb hide();
//}                                                                      