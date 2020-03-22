//=====================================================================================================================
// SICILY1 scripted by Thaddeus Sasser
//=====================================================================================================================

//---------------------------
// SCRIPT NAMING CONVENTIONS - for script function related names
//---------------------------
//prefix
//	player_		=	anything directly player-related
//	docks_		=	docks
//	lighthouse_	=	lighthouse
//	courtyard_	=	courtyard
//	magazine_	=	magazine
//	gun_		=	guns (where # is the gun #)
//	radio_		=	radio rooms
//	motorpool_	=	underground garage
//	tower_		=	courtyard towers
//	quarters_	=	officer's quarters
//	mag_		=	magazine

//	use_		=	used for trigger_use

//suffix
//	_damage		=	used for trigger_damage
//	_hurt		=	used for trigger_hurt
//	_trigger	=	used for trigger_multiple

//---------------------------
// ENTITY NAMING CONVENTIONS - for map-based entity targetnames
//---------------------------
//prefix
//	p_		=	player related
//	d_		=	docks
//	lh_		=	lighthouse
//	r_		=	reinforcements
//	f_		= 	fort
//	c_		=	courtyard
//	mag_		=	magazine
//	g_		=	guns
//	q_		= 	officers' quarters
//	mp_		=	motorpool

//	use_		=	used for trigger_use

//mid, so far only AI's get a mid identifier
//	_axis_#		=	the enemy, obviously
//	sas1_#		=	Ingram's squad
//	sas2_#		=	squad 2, player's squad

//suffix
//	_door		=	used for doors
//	_truck		=	used for trucks
//	_boat		=	used for boats
//	_trigger	=	used for trigger_multiple
//	_damage		=	used for trigger_damage
//	_hurt		=	used for trigger_hurt

main()
{
	//INCLUDED FUNCTIONALITY
	maps\_load_gmi::main();
	maps\sicily1_fx::main();
	maps\sicily1_anim::main();
	maps\_truck_gmi::main();
	maps\_tank_gmi::main();
	maps\_panzeriv_gmi::main();
	maps\_debug_gmi::main();
	maps\_ptboat_player_gmi::main();	
	maps\_minefields_gmi::minefields();
	maps\_bmwbike_gmi::main();

	level._effect["truck_lights"]		= loadfx ("fx/vehicle/headlight_german_truck.efx");

	//DEBUG -- make ai print a selected variable above their head
//	setcvar("debug_ai_text", "bravery");	
//	setcvar("debug_ai_text", "health");	
//	setcvar("debug_ai_text", "walkdist");	

	//PRECACHING
	precacheShader("hudStopwatch");
	precacheShader("hudStopwatchNeedle");
	precacheModel("xmodel/explosivepack");
	precacheModel("xmodel/vehicle_tank_panzeriv_machinegun");
	precacheModel("xmodel/documents1_objective");
	precacheModel("xmodel/v_br_sea_sicily1_fishingboat");
	precacheModel("xmodel/v_br_sea_sicily1_fishingboat_rig");
	precacheModel("xmodel/projectile_BritishGrenade");
	precacheModel("xmodel/sicily1_lighthouse_explosion");
	precacheModel("xmodel/german_radio1_d");
	precacheModel("xmodel/german_field_radio_d");
	precacheModel("xmodel/sicily1_dockhouse_chair");

	//Alex's LMG Guy Script
	animscripts\lmg_gmi::precache();

	//Kubelwagen Stuff
	maps\carride_anim::kubelwagon_load_anims();
	maps\_kubelwagon::main();
	maps\_vehiclechase_gmi::main();
	loadfx("fx/explosions/vehicles/kubelwagon_complete.efx");

	//AMBIENT TRACK
	//Create the array of ambient tracks
	level.ambient_track["outside"] = "ambient_sicily1_ext_01";
	level.ambient_track["top of path"] = "ambient_sicily1_ext_02";
	level.ambient_track["inside"] = "ambient_sicily1_int";
	level.ambient_track["underground"] = "ambient_sicily1_underground_int";

	//Set the initial ambient track, and set a level variable that indicates how to use it with ambient_trigger
	thread maps\_utility_gmi::set_ambient("outside");
	level.current_ambient = "outside";

	//LEVEL VARIABLES
	level.player_weapon = "sten_silenced";
	level.guns_practice = true;
	level.docks_house_kills = 0;
	level.docks_alarm = false;
	level.totalnumofsas = 5;
	level.numreachedgoal = 0;
	level.docks_asleep = true;
	level.docks_truck_arrived = false;
	level.player_in_truck = false;
	level.num_radios_dead = 0;
	level.radios_dead = false;
	level.lh_light_on = true;
	level.r_trucks_unloaded = false;
	level.axis_courtyard_reinforcements_killed = 0;
	level.documents_found = false;
	level.elevator_ready = false;
	level.mp_door_close = true;
	level.guns_charges_planted = 0;
	level.mag_alt = 0;
	level.timersused = 0;
	level.kubelwagenGO = false;
	level.kubelwagenSTARTED = false;
	level.docks_house_1_dead = false;
	level.docks_house_2_dead = false;
	level.trucks_started = false;
	level.docks_done = false;

	//Level flags for bomb placement
	level.bomb_flag["lh_0"] = false;
	level.bomb_flag["lh_1"] = false;
	level.bomb_flag["lh_2"] = false;

	level.bomb_flag["gun_0"] = false;
	level.bomb_flag["gun_1"] = false;
	level.bomb_flag["gun_2"] = false;

	level.bomb_flag["mag_0"] = false;
	level.bomb_flag["mag_1"] = false;
	level.bomb_flag["mag_2"] = false;

	//LEVEL ENTITIES
	level.docks_house_door = getent("dock_house_door", "targetname");
	level.lhbo = getent("lighthouse_bomb_objective", "targetname");
	level.lh_light = getent("lighthouse_light", "targetname");
	level.door_counter = 3;
	level.elevator = getent("guns_elevator", "targetname");
	level.mp_door_l = getent("mp_door_l", "targetname");
	level.mp_door_r = getent("mp_door_r", "targetname");
	level.elevator = getent("guns_elevator", "targetname");
	level.elevator_blocker = getent("player_elevator_blocker", "targetname");
	level.mag_door_right = getent("mag_door_right", "targetname");
	level.mag_door_left = getent("mag_door_left", "targetname");
	level.mp_truck_blocker = getent("mp_truck_blocker", "targetname");
	level.lighthouse_remove = getent("lighthouse_remove", "targetname");
	level.docks_blocker = getent("docks_blocker", "targetname");

	level.lighthouse[0] = getent("top", "targetname");
	level.lighthouse[1] = getent("middle", "targetname");
	level.lighthouse[2] = getent("light", "targetname");
	level.lighthouse[3] = getent("chunk1", "targetname");
	level.lighthouse[4] = getent("chunk2", "targetname");
	level.lighthouse[5] = getent("chunk3", "targetname");
	level.lighthouse[6] = getent("light_top", "targetname");
	level.lighthouse[7] = getent("bottom", "targetname");
	level.lighthouse[8] = getent("lower_remains", "targetname");

	println("^5Lighthouse.size = ",level.lighthouse.size);

		for(n=0;n<level.lighthouse.size;n++)
		{
			if(isdefined(level.lighthouse[n]))
			{
				level.lighthouse[n] hide();
				println("^6#:",n, "HAS BEEN HIDDEN!");
			}
			else
			{
				println("^6: LIGHTHOUSE[",n,"^6] IS NOT DEFINED");
			}
		}

		//--LEVEL ENTITY PREPARATION--
		level.elevator_blocker notsolid();
	
		//Gets rid of the motorpool truck blocker at the start of the map
		level.mp_truck_blocker hide();
		level.mp_truck_blocker connectpaths();

		//Hides motorcycle trigger in courtyard at start of map
		trg = getent("bike_use", "targetname");
		trg maps\_utility_gmi::triggerOff();

		//Hides killspawner_100 for dudes who assault lighthouse from cliffside door
		trg = getent("killspawner_100", "targetname");
		trg maps\_utility_gmi::triggerOff();

		//name elevator trigger
		trg = getent("elevator_interior_top", "targetname");
		trg setHintString (&"SCRIPT_HINTSTR_USEELEVATOR");

		//Ramp blocker1 for garage
		blocker = getent("rampblocker", "targetname");
		blocker maps\_utility_gmi::triggeroff();
		blocker connectpaths();

		blocker = getent("ramp_blocker", "targetname");
		blocker maps\_utility_gmi::triggeroff();
		blocker connectpaths();

		//Courtyard gate -- close it
		level.cy_gate = getent("cy_gate", "targetname");
		//rotateTo(vec orent, float time, <float acceleration_time>, <float deceleration_time>);
		level.cy_gate rotateto( (0,-45,0), 0.5, 0, 0);

	//SKILL LEVEL
	switch ( getcvar("g_gameskill") )
	{
		case "0": 
				level.skill = 1; 
				level.skillname = "Greenhorn"; 
				level.axis_courtyard_total_reinforcements = 5;
				break;		//greenhorn

		case "1": 
				level.skill = 2; 
				level.skillname = "Normal"; 
				level.axis_courtyard_total_reinforcements = 10;
				break;		//normal
		
		case "2": 
				level.skill = 3; 
				level.skillname = "Hardened"; 
				level.axis_courtyard_total_reinforcements = 10;
				break;		//hardened

		case "3": 
				level.skill = 4; 
				level.skillname = "Veteran"; 
				level.axis_courtyard_total_reinforcements = 10;
				break;		//veteran
	}
	println("^5Current Game Skill Level is ^1", level.skillname);
	if(!isdefined(level.skill)) println("^1%%%level.skill is UNDEFINED%%%");

	//LEVEL INITIALIZING THREADS
	level thread garbage_cleanup();
	level thread dialogue_array();
	level thread level_setup();
	level thread Ambient_sound_track_handler();
	level thread music();
	level thread mp_doors_setup();

	//Fix for bug#2563
	level thread dont_shoot_the_boat_driver();


	if(getcvarint("sv_cheats") > 0 )
	{	
		//Level debug functionality to teleport the player to certain areas for testing
		if( getcvar("skipto") == "" ) 
		{
			setcvar("skipto", "none");
		}
	
		if(getcvar("skipto") == "cliffside")
		{
			level thread deleter();
			level thread cliffside_cheat();
//			setcvar("skipto","none");
			return;
		}
		else 
		if(getcvar("skipto") == "elevator")
		{
			level thread deleter();
			level thread fort_cheat();
//			setcvar("skipto","none");
			return;
		}
		else
		if(getcvar("skipto") == "explosion")
		{
			level thread deleter();
			level thread lighthouse_money_shot();
//			setcvar("skipto", "none");
			return;
		}
		else
		if(getcvar("skipto") == "motorpool")
		{
			println("Motorpool cheat activated");
			level thread deleter();
			level thread motorpool_cheat();
//			setcvar("skipto", "none");
			return;
		}
		else
		{
//			setcvar("skipto", "none");
		}
	}
	level thread start_of_map();
}

garbage_cleanup()
{
	//Garbage is any temporary ents I've got in the map that should be removed at game play time
	//Usually these are needed when collision maps need to be loaded for a certain vehicle that I'll be spawning in later
	garbage = getentarray("garbage", "targetname");

	for(n=0;n<garbage.size;n++)
	{
		garbage[n] delete();
	}
}

deleter()
{
	//Deletes all the actors that spawn at the start of the map...a mere convenience for the cheat functions
	axis = getaiarray("axis");
	for(n=0; n<axis.size;n++)
	{
		if(issentient(axis[n])) axis[n] delete();
	}
}

debug_what_killed_me()
{
	self waittill("damage", amt, who);
	println(self.name, " took ",amt," from ",who.classname);
	self thread debug_what_killed_me();
}


//=====================================================================================================================
// LEVEL SETUP FUNCTIONS
//=====================================================================================================================
level_setup()
{
	level thread friendly_chains_off();
	level thread friendly_squads_setup();
	level thread docks_setup();
	level thread docks_too_far_setup();
	level thread docks_house_music();
	level thread seagulls_go();
	level thread float_boats();
	level thread destroyable_boxes_setup();
	level thread destroyable_glass_setup();
	level thread red_barrel_setup();
	level thread boat_damage_setup();
	level thread lighthouse_light_setup();
	level thread road_bunker_setup();
	level thread fort_klaxon();
	level thread alert_sound();
	level thread bomb_objectives_hide();
	level thread guns_setup();

	//El Cheapo hack
	level thread docks_house_hack_2();
}

friendly_chains_off()
{
	maps\_utility_gmi::chain_off("10");
	maps\_utility_gmi::chain_off("20");
	maps\_utility_gmi::chain_off("30");
	maps\_utility_gmi::chain_off("40");
	maps\_utility_gmi::chain_off("50");
	maps\_utility_gmi::chain_off("60");
	maps\_utility_gmi::chain_off("70");
	maps\_utility_gmi::chain_off("80");		//Outside the docks house, turn it on at compromised or stealth successs
	maps\_utility_gmi::chain_off("90");
	maps\_utility_gmi::chain_off("100");		//100 should be LH right now it's not
	maps\_utility_gmi::chain_off("110");
	maps\_utility_gmi::chain_off("120");
	maps\_utility_gmi::chain_off("130");
	maps\_utility_gmi::chain_off("140");
	maps\_utility_gmi::chain_off("150");
	maps\_utility_gmi::chain_off("160");
	maps\_utility_gmi::chain_off("170");
	maps\_utility_gmi::chain_off("180");
	maps\_utility_gmi::chain_off("190");
	maps\_utility_gmi::chain_off("200");

	maps\_utility_gmi::chain_off("210");		//Fort Wall FC

	maps\_utility_gmi::chain_off("281");		//Radio Room exit FC
	maps\_utility_gmi::chain_off("283");		//Radio Room stairs FC

							
	maps\_utility_gmi::chain_off("331");		//300 is guns -- Now I'm using the odd numbers to represent "exit" 
	maps\_utility_gmi::chain_off("333");		//friendlychains...that is, the ones that only activate to retrace your 
	maps\_utility_gmi::chain_off("341");		//steps once X is done -- the even numbered fc's are already on
	maps\_utility_gmi::chain_off("343");

	maps\_utility_gmi::chain_off("420");		//400 is motorpool, 420 is the motorpool entrance
	maps\_utility_gmi::chain_off("440");		//440 is garage exit to elevator

	maps\_utility_gmi::chain_off("495");
	maps\_utility_gmi::chain_off("493");
	maps\_utility_gmi::chain_off("491");
	maps\_utility_gmi::chain_off("489");		//Exit from horseshoe back to garage
	maps\_utility_gmi::chain_off("487");
	maps\_utility_gmi::chain_off("485");
	maps\_utility_gmi::chain_off("483");

	//chain in mag					
	maps\_utility_gmi::chain_off("500");		//500 is mag

	//courtyard exit to bike
	maps\_utility_gmi::chain_off("700");
	maps\_utility_gmi::chain_off("702");		//700 is courtyard
	maps\_utility_gmi::chain_off("704");
	maps\_utility_gmi::chain_off("706");

	//Killspawner Setup
	trg = getent("killspawner_310", "targetname");	//300 is guns
	trg maps\_utility_gmi::triggeroff();

	trg = getent("killspawner_500", "targetname");	//500 is garage on way back
	trg maps\_utility_gmi::triggeroff();

	trg = getent("cy_2_garage", "groupname");	//Garage attackers on catwalk, with floodspawner
	trg maps\_utility_gmi::triggeroff();

	trg = getent("garage_comeback", "targetname");	//2 guys to start garage fight
	trg maps\_utility_gmi::triggeroff();

//	level.grenade_spawner = getent("grenade_spawner", "targetname");
//	level.grenade_spawner maps\_utility_gmi::triggeroff();
}

friendly_squads_setup()
{
	names[0] = "Maj. Ingram";
	names[1] = "Pvt. Luyties";
	names[2] = "Pvt. Hoover";

	names[3] = "Pvt. Moditch";
	names[4] = "Pvt. Denny";

	animnames[0] = "ingram";
	animnames[1] = "luyties";
	animnames[2] = "hoover";
	animnames[3] = "moditch";
	animnames[4] = "denny";

	sas1 = getentarray("sas1", "groupname");

	for(n=0; n<sas1.size; n++)
	{
		level.sas1[n] = getent("sas1_" + n, "targetname");
		level.sas1[n] character\_utility::new();

		level.sas1[n].name = names[n];
		level.sas1[n].animname = animnames[n];
		level.sas1[n].n = n;
		level.sas1[n].squad = "sas1";

		level.sas1[n] [[level.scr_character[animnames[n]]]]();
		level.sas1[n].pacifist = 1;
		
		//Everyone, get down!
		level.sas1[n] allowedStances("crouch");
		
		//Set them so that they will shoot while they move
		level.sas1[n].bravery = 1;

		//No one fires until I say so!
		level.sas1[n].pacifist = 1;

		//And, don't play pain anims!
		level.sas1[n].playpainanim = 0;

		//THAD THE ALLY_BRITISH_SILENCER.GSC SETS THESE VALUES...YOU COMMENTED IT OUT LOCALLY BUT DID NOT CHECK IT INTO SS
		//The values listed below are the ones from the character file
		//	self.accuracy = 0.2;
		//	self.health = 350;
		//	self.grenadeWeapon = "";
		//	self.bravery = 6;
		//	self.grenadeAmmo = 0;

		level.sas1[n].accuracy = 0.2;
		level.sas1[n].health = 600;
		level.sas1[n].myMaxHealth = level.sas1[n].health;
		level.sas1[n].grenadeWeapon = "MK1britishfrag";		//at least now they don't throw invisible grenades, ha ha
		level.sas1[n].bravery = 6;				
		level.sas1[n].grenadeAmmo = 3;

		//if(n==0 || n== 1) level.sas1[n] thread maps\_utility_gmi::magic_bullet_shield();
		//Everyone's shielded now
		level.sas1[n] thread maps\_utility_gmi::magic_bullet_shield();

		level.sas1[n] thread squad_slow_regen();

		level.sas1[n] thread squad_did_you_die();

		level.sas1[n] thread debug_what_killed_me();

		level.sas1[n] thread squad_flinch_but_dont_die();

		//Hide Ingram's gun
		if(n==0)
		{
			level.sas1[n] animscripts\shared::PutGunInHand("none");
			if(n==0) level.sas1[n] attach("xmodel/w_us_spw_binocular_world", "tag_weapon_left");
		}

		println(level.sas1[n].name," ^5has ",level.sas1[n].health," ^5health");
	}

	sas2 = getentarray("sas2", "groupname");

	for(n=0; n<sas2.size; n++)
	{
		m=n+3;

		level.sas2[n] = getent("sas2_" + n, "targetname");
		level.sas2[n] character\_utility::new();

		//level.sas2[n] thread maps\_utility_gmi::magic_bullet_shield();

		level.sas2[n].name = names[m];
		level.sas2[n].animname = animnames[m];
		level.sas2[n].n = n;
		level.sas2[n].squad = "sas2";

		level.sas2[n] [[level.scr_character[animnames[m]]]]();

		level.sas2[n] allowedStances("crouch");	//hrm

		//Set your squad to pacifist at start
		level.sas2[n].pacifist = true;

		level.sas2[n].accuracy = 0.2;
		level.sas2[n].health = 600;
		level.sas2[n].myMaxHealth = level.sas2[n].health;
		level.sas2[n].grenadeWeapon = "MK1britishfrag";
		level.sas2[n].bravery = 6;
		level.sas2[n].grenadeAmmo = 3;

		//Moditch and Denny start in god mode, but will be vulnerable after the motorpool area
		level.sas2[n] thread maps\_utility_gmi::magic_bullet_shield();

		//Put Moditch's gun in his left hand
		if(n==0) level.sas2[n] animscripts\shared::PutGunInHand("left");

		level.sas2[n] thread squad_slow_regen();

		level.sas2[n] thread squad_did_you_die();

		level.sas2[n] thread debug_what_killed_me();

		level.sas2[n] thread squad_flinch_but_dont_die();

		println(level.sas2[n].name," ^5has ",level.sas2[n].health," ^5health");
	}

	//Set up truck climbtags
	level.sas1[0].climbtag = "TAG_CLIMB01";
	level.sas1[2].climbtag = "TAG_CLIMB04";
	level.sas2[0].climbtag = "TAG_CLIMB05";
	level.sas2[1].climbtag = "TAG_CLIMB06";

	level.sas1[0].idletag = "TAG_GUY01";
	level.sas1[2].idletag = "TAG_GUY04";
	level.sas2[0].idletag = "TAG_GUY05";
	level.sas2[1].idletag = "TAG_GUY06";

	level.sas1[0].exittag = "TAG_GUY01";
	level.sas1[2].exittag = "TAG_GUY04";
	level.sas2[0].exittag = "TAG_GUY05";
	level.sas2[1].exittag = "TAG_GUY06";
}

docks_setup()
{
	//ALL DOCKs AXIS ARE SET UP HERE
	level.docks_axis = getentarray("docks_axis", "groupname");

	for(n=0;n<level.docks_axis.size;n++)
	{
		// 0 - The patrolling officer, outside the house
		// 1 - The sitting guard, at the desk inside the house
		// 2 - The sleeping guard, on the bed in the back room
		// 3 - The eastern beach patroller
		// 4 - The machine gunner in the bunker
		// 5 - The officer in the bunker, also seated
		// 6 - The western beach patroller

		//Get each entity, as described above by index number
		level.d_axis[n] = getent("d_axis_"+n, "targetname");

//		if(n!= 0 && n!=1 && n!=2)
//		{
//			//Thread all of the guards into the stealth function
//			level.d_axis[n] thread axis_stealth();
	
			level.d_axis[n].pacifist = 1;
	
//		}
		
		//Set their health low
		level.d_axis[n].health = 50;

		if (n==4) level.d_axis[n].ignoreme = true;
	}

	level.d_axis[2].health = 1;

	//Send each guy off into his own handler
	level.d_axis[0] thread docks_0_handler();
	level.d_axis[1] thread docks_1_handler();
	level.d_axis[2] thread docks_2_handler();
	level.d_axis[3] thread axis_patroller(3);
	level.d_axis[4] thread axis_patroller(4);
	level.d_axis[5]	thread docks_5_handler();
	level.d_axis[6] thread axis_patroller(6);

	//Handle all of the intial friendly chains
	maps\_utility_gmi::chain_on("10");
	maps\_utility_gmi::chain_on("20");
	maps\_utility_gmi::chain_on("30");
	maps\_utility_gmi::chain_on("40");
	maps\_utility_gmi::chain_on("50");
	maps\_utility_gmi::chain_on("60");
	maps\_utility_gmi::chain_on("70");
	//Wait till stealth complete or stealth failed for chain 80
	maps\_utility_gmi::chain_on("90");
	maps\_utility_gmi::chain_on("100");
	maps\_utility_gmi::chain_on("110");
}

docks_too_far_setup()
{
	level endon("player in truck");

	trg = getent("too_far_1", "targetname");

	trg waittill("trigger");

	iprintln(&"GMI_SICILY1_DONT_GO_TOO_FAR");

	trg = getent("too_far_2", "targetname");

	trg waittill("trigger");

	iprintln(&"GMI_SICILY1_YOU_WENT_TOO_FAR");

	wait 1;

	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
	missionFailed();
}

lighthouse_light_setup()
{
	level waittill("finished intro screen");

	level thread destroyable_lighthouse_light();

	//This rotates the lighthouse light model
	light = level.lh_light;

	playfxonTag(level._effect["light_beam"], level.lh_light, "tag_light");

	while(level.lh_light_on == true)
	{
		if(!isdefined(light)) break;

		light rotateto( (0,10,0), 4, 0.5, 0.5 );
		light waittill("rotatedone");

		if(!isdefined(light)) break;

		light rotateto( (0,-150,0), 4, 0.5, 0.5 );
		light waittill("rotatedone");
	}
}

destroyable_lighthouse_light()
{
	//This is the damage trigger that encases the light
	trg = getent("lh_light_damage", "targetname");
	trg waittill("trigger");
	
	//Could use a better sound here
	level.lh_light playsound("glass_break");

	//Turn off the light and stop its rotation
	stopattachedfx(level.lh_light);
	level.lh_light_on = false;
}

//Hide all of the bomb_incomplete objectives
bomb_objectives_hide()
{
	bombs = getentarray("bomb", "groupname");

	for(n=0;n<bombs.size;n++)
	{
		bombs[n] hide();
	}

	//Tried to hide the cursorhints on the triggers, this does NOT work
	//New method:  Trigger_off on the trigger (it works, SHIP IT)
	bomb_trigger_array[0] = "lh_";		//lighthouse
	bomb_trigger_array[1] = "g_";		//guns
	bomb_trigger_array[2] = "m_";		//magazine
	for(n=0;n<3;n++)
	{
		thesetrgs = getentarray(bomb_trigger_array[n], "groupname");

		for(n2=0;n2<thesetrgs.size;n2++)
		{
			thesetrgs[n] setcursorhint("HINT_NONE");
		}
	}
}

mp_doors_setup()
{
	//Grabs and hides the destroyed portions of the motorpool door
	level.mp_door_destroyed_l = getent("mp_door_destroyed_l", "targetname");
	level.mp_door_destroyed_r = getent("mp_door_destroyed_r", "targetname");

	level.mp_door_destroyed_l hide();
	level.mp_door_destroyed_r hide();
}



//=====================================================================================================================
// * * * GAME FUNCTIONS && UTILITIES * * *
//=====================================================================================================================
array_thread (ents, process, var, excluders)
{
	//Utility function included here
	maps\_utility_gmi::array_thread (ents, process, var, excluders);
}

playerline(mytarget)
{
	//Draws a simple line from the player to the passed entity
	mytarget endon("death");
	while(1)
	{
		myorg = mytarget.origin;
		line(level.player.origin, myorg, (1,0,0),1);
		wait 0.1;
	}
}

squad_flinch_but_dont_die()
{
	//This section is threaded by each guy in the squad
	//It makes the guy react to fire, then set himself to ignore for a few seconds, then turn that off
	//It should prevent the "guy getting repeatedly owned but not dying" bug

	//debug print
	println(self.animname," HAS ENTERED SQUAD_FLINCH_BUT_DONT_DIE");

	self endon("stop flinching");

	self waittill("pain");
	self.ignoreme = 1;
	wait 5;
	self.ignoreme = 0;
	self thread squad_flinch_but_dont_die();
}

squad_adopt_player_stance()
{
//	self thread squad_reset_stance_on_stop_adopt_stance();
//
//	level endon("stop adopt stance");
//	
//	//This makes the guys in Squad1 react to the player's posture until the notify to stop doing so is sent
//	while(1)
//	{
//		oldstance = chkstance;
//		if(!isdefined(oldstance)) oldstance = "none";
//		wait 0.05;
//		chkstance = level.player getstance();
//		if (chkstance == oldstance) continue;
//
//		switch (chkstance)
//		{
//			case "prone": 	self allowedStances("prone");
//					self thread squad_get_down();
//					break;
//	
//			case "stand":	
//					if(self.anim_script != "combat")
//					{
//						self allowedStances("stand");
//					}
//					else
//					{
//						self allowedStances("crouch");
//					}
//					break;
//
//			case "crouch":	self allowedStances("crouch");
//					break;
//		}
//	}
}

squad_reset_stance_on_stop_adopt_stance()
{
//	level waittill("stop adopt stance");
//
//	self allowedStances("stand","crouch","prone");
}	


//Helper for the above function
squad_get_down()
{
//	if(isdefined(self.thistime) && ( (gettime() - self.thistime < 15000 )) )
//	{
//		return;
//	}
//	else
//	{
//		//Here's where the vo would play...
//		println("^5Friendly shouts line about adopting player stance");
//	}
//	self.thistime = gettime();
//	wait 0.5;
}

waittill_any (string1, string2, string3, string4, string5)
{
	self endon ("death");
	ent = spawnstruct();

	if (isdefined (string1))
		self thread waittill_string (string1, ent);

	if (isdefined (string2))
		self thread waittill_string (string2, ent);

	if (isdefined (string3))
		self thread waittill_string (string3, ent);

	if (isdefined (string4))
		self thread waittill_string (string4, ent);

	if (isdefined (string5))
		self thread waittill_string (string5, ent);

	ent waittill ("returned");
	ent notify ("die");
}

waittill_string (msg, ent)
{
	self endon ("death");
	ent endon ("die");
	self waittill (msg);
	ent notify ("returned");
}

waittill_multiple (string1, string2, string3, string4, string5)
{
	self endon ("death");
	ent = spawnstruct();
	ent.threads = 0;

	if (isdefined (string1))
	{
		self thread waittill_string (string1, ent);
		ent.threads++;
	}
	if (isdefined (string2))
	{
		self thread waittill_string (string2, ent);
		ent.threads++;
	}
	if (isdefined (string3))
	{
		self thread waittill_string (string3, ent);
		ent.threads++;
	}
	if (isdefined (string4))
	{
		self thread waittill_string (string4, ent);
		ent.threads++;
	}
	if (isdefined (string5))
	{
		self thread waittill_string (string5, ent);
		ent.threads++;
	}

	while (ent.threads)
	{
		ent waittill ("returned");
		ent.threads--;
	}

	ent notify ("die");
}

dont_shoot_the_boat_driver()
{
	trg = getent("dont_shoot_the_boat_driver", "targetname");

	trg waittill("trigger");

	setCvar("ui_deadquote", "@SCRIPT_MISSIONFAIL_KILLTEAM_BRITISH");
	missionFailed();
}

docks_no_noisy_weapons()
{
	level endon("house infiltrated");
	level endon("stealth failed");

	level waittill("docks guard dead");

	level.no_noise = true;
	while(level.no_noise)
	{
		wait 0.05;
		if(level.player AttackButtonPressed())
		{
			if( (level.player getCurrentWeapon()) != "sten_silenced")
			{
				level notify("stealth failed");
				level.no_noise = false;
			}
		}
	}
}

//AMBIENT SEAGULLS
#using_animtree("sicily1_dummies_path");
seagulls_go()
{
	level.anim_wait[0] = 98;
	level.anim_wait[1] = 104;
	level.anim_wait[2] = 88;
	level.anim_wait[3] = 126;
	level.anim_wait[4] = 143;
	level.anim_wait[5] = 65;
	level.anim_wait[6] = 110;

	//(pos, model, total_tags, angle_offset, loop_time, loop_num, path_anim, anim_wait)
	level thread maps\sicily1_dummies::dummies_setup( (2013, -5277, 52) , "xmodel/sicily1_dummies_seagulls_a", 7, ( 0, 180, 0) , 12, 1000, %sicily1_dummies_seagulls_a, 0);
}

//CLIFFSIDE GUNS
cliff_guns_shoot()
{
	rand_gun = ( randomint(3) + 1 );
	guns_target = getent("g_target", "targetname");
	guns_whizby = getent("g_whizby", "targetname");

	for(n=1; n<4; n++)
	{
		gun[n] = getent("g_" + n,"targetname");
	}

	while(level.guns_practice == true)
	{
		old_gun = rand_gun;

		if(rand_gun == old_gun)
		{
			while(rand_gun == old_gun)
			{
				rand_gun = (randomint(3) + 1);
			}
		}
	
		org = gun[rand_gun].origin;

		playfx(level._effect["guns_shoot"], org);
		gun[rand_gun] playsound("big_gun_fire");
		wait 0.3;
		guns_whizby playsound("shell_flyover");
		rand_wait = (randomint(2)+8);
		wait rand_wait;
		
		guns_target playsound("shell_flash");

		rand_wait = randomfloat(4) + 2.05;
		wait rand_wait;
	}
}



//=-------------------=
//=OBJECTIVES TRACKING=
//=-------------------=
objective_1()				//***Get to the lighthouse***
{
	//-=Control=-
	level thread objective_2();
	
	level endon("objective 1 complete");
	//-=Control=-

	level.docks_objective = 1;

	index = 0;

	//SECURE THE DOCKS
	//Old marker
	objectivemarker[0] = getent("marker_objective_0", "targetname");			//marker_objective_0, on docks at start
	
	//HACKED MARKER TO REPRESENT UPDATED LOCATION OF DOCKS HOUSE OBJECTIVE
	objectivemarker[1] = getent("marker_objective_0_1", "targetname");			//marker_objective_0_1, in house

	//STORM THE BUNKER
	objectivemarker[2] = getent("marker_objective_1_1", "targetname");			//marker_objective_1_1

	//GET IN THE TRUCK
	objectivemarker[3] = getent("marker_objective_1_2", "targetname");			//marker_objective_1_2

	//ENGAGE ENEMY AT THE LIGHTHOUSE AND GET INSIDE
	objectivemarker[4] = getent("marker_objective_1_5", "targetname");			//marker_objective_1_3

	//ENGAGE ENEMY AT THE LIGHTHOUSE AND GET INSIDE
	objectivemarker[5] = getent("marker_objective_1_5", "targetname");			//marker_objective_1_4

	//ENGAGE ENEMY AT THE LIGHTHOUSE AND GET INSIDE
	objectivemarker[6] = getent("marker_objective_1_5", "targetname");			//marker_objective_1_5

	objective_add(1, "active", "", objectivemarker[index].origin);
	objective_string(1, &"GMI_SICILY1_OBJECTIVE_0");					//GMI_SICILY1_OBJECTIVE_1_0
	objective_current(1);

	while(1)
	{
		wait 0.05;
		
		level waittill("update objective 1");

		level.docks_objective++;

		index++;

		switch(index)
		{
			case 1:	objective_string(1, &"GMI_SICILY1_OBJECTIVE_1_0");		//GMI_SICILY1_OBJECTIVE_1_0
				objective_position(1, objectivemarker[index].origin);
				objective_ring(1);
				break;

			case 2:	objective_string(1, &"GMI_SICILY1_OBJECTIVE_1_1");		//GMI_SICILY1_OBJECTIVE_1_1
				objective_position(1, objectivemarker[index].origin);
				objective_ring(1);
				break;

			case 3: objective_string(1, &"GMI_SICILY1_OBJECTIVE_1_2");		//GMI_SICILY1_OBJECTIVE_1_2
				objective_position(1, objectivemarker[index].origin);
				objective_ring(1);
				break;

			case 4:	objective_string(1, &"GMI_SICILY1_OBJECTIVE_1_3");		//GMI_SICILY1_OBJECTIVE_1_3
				objective_position(1, objectivemarker[index].origin);
				objective_ring(1);
				break;
	
			case 5:	objective_string(1, &"GMI_SICILY1_OBJECTIVE_1_4");		//GMI_SICILY1_OBJECTIVE_1_4
				objective_position(1, objectivemarker[index].origin);
				objective_ring(1);
				break;

			case 6:	objective_string(1, &"GMI_SICILY1_OBJECTIVE_1_5");		//GMI_SICILY1_OBJECTIVE_1_5
				objective_position(1, objectivemarker[index].origin);
				objective_ring(1);
				break;
		}

		objective_current(1);
	}
}

objective_2()				//***Plant charges in lighthouse (3 of 3)***
{
	//-=Control=-
	level waittill("objective 1 complete");

	objective_state(1, "done");

	level thread objective_3();

	level endon("objective 2 complete");
	//-=Control=-

	index = 0;
	bombs = 3;

	//I switched the location of the markers to the actual bombs themselves
	//Plant charge #1
	objectivemarker[0] = getent("lh_bomb_0", "targetname");			//marker_objective_2_0

	//Plant charge #2
	objectivemarker[1] = getent("lh_bomb_1", "targetname");			//marker_objective_2_1

	//Plant charge #3
	objectivemarker[2] = getent("lh_bomb_2", "targetname");			//marker_objective_2_2

	objective_add(2, "active", "", objectivemarker[index].origin);
	objective_string(2, &"GMI_SICILY1_OBJECTIVE_2", bombs);					//GMI_SICILY1_OBJECTIVE_2  %bombs
	objective_current(2);

	while(bombs>1)
	{
		level waittill("bomb planted");

		bombs--;

		//	bomb just got planted
		//	check to see if the next bomb in the order has been planted
		//	if it hasn't update the marker to it
		//	if it has, check the other 2 bombs and mark the first one of them
	
		// OK -- I was trying to be crafty here...
		// So what happens is, it checks the first in the list of charges to be planted
		// If that charge has been placed, it updates to and checks the next one
		// If that one's been placed too, it updates to and checks the third one
		// If all three have been placed, it continues on out of the function
		// So, each bomb as it's placed will mark its flag true and be skipped in the update marker location loop

		name = "lh_" + index;
		while(level.bomb_flag[name] == true)
		{
			index++;
			if(index>2) index = 0;
			name = "lh_" + index;
			wait 0.05;
			if(level.bomb_flag["lh_0"] == true && level.bomb_flag["lh_1"] == true && level.bomb_flag["lh_2"] == true) continue;
		}

		//
		//
		//
		//

		objective_position(2, (objectivemarker[index].origin) );
		objective_ring(2);
		objective_string(2, &"GMI_SICILY1_OBJECTIVE_2", bombs);				//GMI_SICILY1_OBJECTIVE_2  %bombs
	}

	//Handle the last bomb...this was poorly planned, next time set and ring the position BEFORE the bomb gets planted, not the 
	//NEXT bomb after THIS bomb is planted
	level waittill("bomb planted");
	bombs--;
	objective_string(2, &"GMI_SICILY1_OBJECTIVE_2", bombs);				//GMI_SICILY1_OBJECTIVE_2  %bombs
	level notify("objective 2 complete");
}

objective_3()				//***Find radio rooms***
{
	//-=Control=-
	level waittill("objective 2 complete");

	objective_state(2, "done");

	level thread objective_4();

	level endon("objective 3 complete");
	//-=Control=-

	index = 0;

	//REGROUP OUTSIDE ON THE PATH
	objectivemarker[0] = getent("marker_objective_3_0", "targetname");			//marker_objective_3_0

	//HEAD UP THE PATH
	objectivemarker[1] = getent("marker_objective_3_1", "targetname");			//marker_objective_3_1

	//AVOID THE TRUCKS
	objectivemarker[2] = getent("marker_objective_3_3", "targetname");			//marker_objective_3_2

	//GET UP ONTO THE WALL
	objectivemarker[3] = getent("marker_objective_3_4", "targetname");			//marker_objective_3_4

	//FIND RADIO ROOMS
	objectivemarker[4] = getent("marker_objective_3_5", "targetname");			//marker_objective_3_5

	//FIND RADIO ROOMS2
	objectivemarker[5] = getent("marker_objective_4", "targetname");			//marker_objective_3_5

	objective_add(3, "active", "", objectivemarker[index].origin);				
	objective_string(3, &"GMI_SICILY1_OBJECTIVE_3_0");					//GMI_SICILY1_OBJECTIVE_3_0
	objective_current(3);

	while(1)
	{
		wait 0.05;

		level waittill("update objective 3");

		index++;
		
		switch(index)
		{
			case 1: objective_string(3, &"GMI_SICILY1_OBJECTIVE_3_1");		//GMI_SICILY1_OBJECTIVE_3_1
				objective_position(3, objectivemarker[index].origin);
				objective_ring(3);
				break;

			case 2: objective_string(3, &"GMI_SICILY1_OBJECTIVE_3_2");		//GMI_SICILY1_OBJECTIVE_3_2
				objective_position(3, objectivemarker[index].origin);
				objective_ring(3);
				break;

			case 3: objective_string(3, &"GMI_SICILY1_OBJECTIVE_3_4");		//GMI_SICILY1_OBJECTIVE_3_3
				objective_position(3, objectivemarker[index].origin);
				objective_ring(3);
				break;

			case 4: objective_string(3, &"GMI_SICILY1_OBJECTIVE_3_5");		//GMI_SICILY1_OBJECTIVE_3_4
				objective_position(3, objectivemarker[index].origin);
				objective_ring(3);
				break;

				//Note: this is the same marker, I just don't want to update the text string yet
			case 5: objective_string(3, &"GMI_SICILY1_OBJECTIVE_3_5");		//GMI_SICILY1_OBJECTIVE_3_5
				objective_position(3, objectivemarker[index].origin);
				objective_ring(3);
				break;
		}
		objective_current(3);
	}
}

objective_4()				//***Take out radios (5 of 5)***
{
	//-=Control=-
	level waittill("objective 3 complete");

	objective_state(3, "done");

	level thread objective_5();

	//Note: NO level endon objective complete because this function does some additional control for squad2	
	//-=Control=-


	radios = 5;

	objectivemarker = getent("marker_objective_4", "targetname");				//marker_objective_4

	//TAKE OUT THE FIVE RADIOS
	objective_add(4, "active", "", objectivemarker.origin);
	objective_string(4, &"GMI_SICILY1_OBJECTIVE_4", radios);				//GMI_SICILY1_OBJECTIVE_4  %radios
	objective_current(4);
	objective_ring(4);

	while(radios>0)
	{
		level waittill("radio killed");
	
		radios--;
	
		objective_string(4, &"GMI_SICILY1_OBJECTIVE_4", radios);			//GMI_SICILY1_OBJECTIVE_4  %radios
	}

	//level.radiosaredead = true;
	level.radios_dead = true;
}

objective_5()				//***Get to garage***
{
	//-=Control=-
	level waittill("objective 4 complete");

	objective_state(4, "done");

	level thread objective_6();

	level endon("objective 5 complete");
	//-=Control=-

	index = 0;
	
	//FIND A WAY OUT INTO THE COURTYARD
	objectivemarker[0] = getent("marker_objective_5_0", "targetname");			//marker_objective_5_0

	//REGROUP WITH 1ST SQUAD
	objectivemarker[1] = getent("marker_objective_5_1", "targetname");			//marker_objective_5_1

	//SECURE THE GARAGE
	objectivemarker[2] = getent("marker_objective_5_2", "targetname");			//marker_objective_5_2

	objective_add(5, "active", "", objectivemarker[index].origin);
	objective_string(5, &"GMI_SICILY1_OBJECTIVE_5_0");					//GMI_SICILY1_OBJECTIVE_5_0
	objective_current(5);

	while(1)
	{
		wait 0.05;

		level waittill("update objective 5");

		index++;
		
		switch(index)
		{
			case 1: objective_string(5, &"GMI_SICILY1_OBJECTIVE_5_1");		//GMI_SICILY1_OBJECTIVE_5_1
				objective_position(5, objectivemarker[index].origin);
				objective_ring(5);
				break;

			case 2: objective_string(5, &"GMI_SICILY1_OBJECTIVE_5_2");		//GMI_SICILY1_OBJECTIVE_5_2
				objective_position(5, objectivemarker[index].origin);
				objective_ring(5);
				break;
		}
		objective_current(5);
	}
}

objective_6()				//***Find the documents***
{
	//-=Control=-
	level waittill("objective 5 complete");

	objective_state(5, "done");

	level thread objective_7();

	level endon("objective 6 complete");
	//-=Control=-


	index = 0;

	//FIND THE DOCUMENTS (1)
	objectivemarker[0] = getent("marker_objective_6_0", "targetname");

	//FIND THE DOCUMENTS (2)
	objectivemarker[1] = getent("marker_documents", "targetname");

	objective_add(6, "active","", objectivemarker[index].origin);
	objective_string(6, &"GMI_SICILY1_OBJECTIVE_6_0");					//GMI_SICILY1_OBJECTIVE_6_0
	objective_current(6);

	level waittill("update objective 6");

	index++;
	objective_position(6, objectivemarker[index].origin);
	objective_ring(6);
	objective_current(6);
}

objective_7()				//***Find the guns***
{
	//-=Control=-
	level waittill("objective 6 complete");

	objective_state(6,"done");

	level thread objective_8();

	level endon("objective 7 complete");
	//-=Control=-


	index = 0;

	//GET ON THE ELEVATOR
	objectivemarker[0] = getent("marker_objective_7_0", "targetname");			//marker_objective_7_0

	//FIND THE GUNS
	objectivemarker[1] = getent("marker_objective_7_1", "targetname");			//marker_objective_7_1

	objective_add(7, "active", "", objectivemarker[index].origin);				
	objective_string(7, &"GMI_SICILY1_OBJECTIVE_7_0");					//GMI_SICILY1_OBJECTIVE_7_0
	objective_current(7);

	level waittill("update objective 7");

	index++;
	objective_string(7, &"GMI_SICILY1_OBJECTIVE_7_1");					//GMI_SICILY1_OBJECTIVE_7_1
	objective_position(7, objectivemarker[index].origin);
	objective_ring(7);
	objective_current(7);

	level.guns_practice = false;
}

objective_8()				//***Plant charges on guns (3 of 3)***
{
	//-=Control=-
	level waittill("objective 7 complete");

	objective_state(7, "done");

	level thread objective_9();

	//Note: NO level endon objective complete because this function does some additional control for squad2	
	//-=Control=-


	index = 0;
	bombs = 3;

	//Plant charge #1
	objectivemarker[0] = getent("marker_objective_8_0", "targetname");			//marker_objective_8_0

	//Plant charge #2
	objectivemarker[1] = getent("marker_objective_8_1", "targetname");			//marker_objective_8_1

	//Plant charge #3
	objectivemarker[2] = getent("marker_objective_8_2", "targetname");			//marker_objective_8_2

	objective_add(8, "active", "", objectivemarker[index].origin);
	objective_string(8, &"GMI_SICILY1_OBJECTIVE_8", bombs);					//GMI_SICILY1_OBJECTIVE_8  %bombs remain
	objective_current(8);

	autosavenum = 8;

	while(bombs>1)
	{
		level waittill("bomb planted");

		bombs--;

		//	bomb just got planted
		//	check to see if the next bomb in the order has been planted
		//	if it hasn't update the marker to it
		//	if it has, check the other 2 bombs and mark the first one of them

		name = "gun_" + index;
		while(level.bomb_flag[name] == true)
		{
			index++;
			if(index>2) index = 0;
			name = "gun_" + index;
			wait 0.05;
			if(level.bomb_flag["gun_0"] == true && level.bomb_flag["gun_1"] == true && level.bomb_flag["gun_2"] == true) continue;		
		}
		
		//
		//
		//
		//

		objective_string(8, &"GMI_SICILY1_OBJECTIVE_8", bombs);
		objective_position(8, (objectivemarker[index].origin) );
		objective_ring(8);

		//Wait until after the previous charge explodes, just to make sure we don't save a dead player :)
		wait 9;

		//Autosave Point #autosavenum
		maps\_utility_gmi::autosave(autosavenum);
		println("^5Autosave ",autosavenum," complete!");

		autosavenum++;
	}

	level waittill("bomb planted");

	level notify("objective 8 complete");

	bombs = 0;
	objective_string(8, &"GMI_SICILY1_OBJECTIVE_8", bombs);					//GMI_SICILY1_OBJECTIVE_8  %bombs remain
	objective_state(8, "done");

	//Autosave Point #autosavenum
	maps\_utility_gmi::autosave(autosavenum);
	println("^5Autosave ",autosavenum," complete!");

	maps\_utility_gmi::chain_on("500");		//500 is mag

	wait 2;

	//Squad moves to appropriate mag door
	if(level.mag_door_opened == "left")
	{
		level thread squad_moveup("mag",2,"cover_left");
	}
	else
	{
		level thread squad_moveup("mag",2,"cover_right");
	}

	//Retarget everyone back on to the friendlychains once the magazine trigger is crossed
	trg = getent("friendlychain_500", "targetname");

	trg waittill("trigger");

	level thread squad_retarget(2);
}

objective_9()			//***Plant charges in magazine (3 of 3)***
{
	//-=Control=-
	level waittill("objective 8 complete");

	objective_state(8,"done");

	level thread objective_10();

	//Note: Level endon for objective not used, "completed" notify at end of this function, due to need to set objective value to 0
	//-=Control=-

	//plant magazine charge and escape
	index = 0;
	charges = 3;

	//FIND THE MAGAZINE (1)
	objectivemarker[0] = getent("marker_objective_9_1", "targetname");			//marker_objective_9_0

	//PLANT THE CHARGES (3 of 3)
	objectivemarker[1] = getent("marker_objective_9_1", "targetname");			//marker_objective_9_1
	objectivemarker[2] = spawn("script_origin", (-8808, -3112, 1824) );			//left shelf
	objectivemarker[3] = spawn("script_origin", (-7584, -3112, 1824) );			//right shelf

	objective_add(9, "active", "", objectivemarker[index].origin);
	objective_string(9, &"GMI_SICILY1_OBJECTIVE_9_0");				//GMI_SICILY1_OBJECTIVE_9_0
	objective_current(9);

	level thread mag_wait_for_objective_update();
	level waittill("update objective 9");

	index = 1;
	objective_string(9, &"GMI_SICILY1_OBJECTIVE_9_1", charges);			//GMI_SICILY1_OBJECTIVE_9_1  %charges remain
	objective_position(9, (objectivemarker[index].origin) );
	objective_ring(9);

	while(charges>1)
	{
		level waittill("bomb planted");

		charges--;

		name = "mag_" + (index-1);		//-1 == HACK!!!  Or really, poor planning

		while(level.bomb_flag[name] == true)
		{
			index++;
			if(index>3) index = 1;		//Hacky here again...make the indices for the name match the names on the charges
			name = "mag_" + ( (index-1 ) );	//-1 == HACK!!!  Or really, poor planning
			wait 0.05;

			for(n=0;n<3;n++)
			{
				println("^5====", level.bomb_flag["mag_"+n] );
			}

			println("^6!!!!!!^7mag_",(index-1)," is ", level.bomb_flag["mag_"+ (index-1) ]);
			if(level.bomb_flag["mag_0"] == true && level.bomb_flag["mag_1"] == true && level.bomb_flag["mag_2"] == true) continue;		
		}

		objective_string(9, &"GMI_SICILY1_OBJECTIVE_9_1", charges);		//GMI_SICILY1_OBJECTIVE_9_1  %charges remain
		println("^3objective marker ",index," activated!");
		objective_position(9, (objectivemarker[index].origin) );
		objective_ring(9);
	}
	
	level waittill("bomb planted");
	charges = 0;
	objective_string(9, &"GMI_SICILY1_OBJECTIVE_9_1", charges);			//GMI_SICILY1_OBJECTIVE_9_1  %charges remain

	level notify("objective 9 complete");
}

objective_10()
{
	//-=Control=-
	level waittill("objective 9 complete");

	objective_state(9,"done");

	//NOTE:  Doesn't matter if this objective is notified "complete" or not, it's the last one of the map

	//-=Control=-

	index = 0;

	//GET BACK TO THE ELEVATOR
	objectivemarker[0] = getent("marker_objective_10_0", "targetname");			//marker_objective_10_0

	//REGROUP IN THE GARAGE
	objectivemarker[1] = getent("marker_objective_10_1", "targetname");			//marker_objective_10_1

	//ESCAPE TO THE COURTYARD
	objectivemarker[2] = getent("marker_objective_10_2", "targetname");			//marker_objective_10_2

	//GET ON THE MOTORBIKE
	objectivemarker[3] = getent("marker_objective_10_3", "targetname");			//marker_objective_10_3

	objective_add(10, "active", "", objectivemarker[index].origin);
	objective_string(10, &"GMI_SICILY1_OBJECTIVE_10_0");					//GMI_SICILY1_OBJECTIVE_10_0
	objective_current(10);

	while(1)
	{
		wait 0.05;

		level waittill("update objective 10");

		index++;
		
		switch(index)
		{
			case 1: objective_string(10, &"GMI_SICILY1_OBJECTIVE_10_1");		//GMI_SICILY1_OBJECTIVE_10_1
				objective_position(10, objectivemarker[index].origin);
				objective_ring(10);
				break;

			case 2: objective_string(10, &"GMI_SICILY1_OBJECTIVE_10_2");		//GMI_SICILY1_OBJECTIVE_10_2
				objective_position(10, objectivemarker[index].origin);
				objective_ring(10);
				break;

			case 3: objective_string(10, &"GMI_SICILY1_OBJECTIVE_10_3");		//GMI_SICILY1_OBJECTIVE_10_3
				objective_position(10, objectivemarker[index].origin);
				objective_ring(10);
				break;
		}

		objective_current(10);
	}		
}
//---------------
// END OBJECTIVES
//---------------



mag_wait_for_objective_update()
{
	trg = getent("friendlychain_500", "targetname");
	trg waittill("trigger");

	level notify("update objective 9");
}

// ****************
axis_ambush(ambush)
{
	//first trigger spawns dudes, name of ambush_#_trigger_1
	//dudes with groupname of ambush_#
	
	//name of ambush_#_trigger_2
	//second trigger represents the optimal spot for squad to attack

	//guys stay in pacifist until one is attacked or second trigger is hit
	//guys do not move off their markers until trap is sprung (or they are shot at)
	//then, everyone tries to kill the player

	trg = getent("ambush_"+ambush+"_trigger_1", "targetname");

	trg waittill("trigger");

	ambush_array = getentarray("ambush_"+ambush, "groupname");

	for(n=0;n<ambush_array.size;n++)
	{
		println("ambusher spawned...");
		ambusher[n] = ambush_array[n] dospawn();
		ambusher[n].pacifist = 1;
		ambusher[n].goalradius = 4;
		ambusher[n].health = 100;
		ambusher[n].team = "axis";
		ambusher[n].bravery = 1;
		ambusher[n] thread ambusher_wait_for_combat();
		ambusher[n] thread ambusher_wait_for_notify();
	}

	//this is the trigger that tells them "go"
	trg = getent("ambush_"+ambush+"_trigger_2", "targetname");
	
	trg waittill("trigger");

	level notify("ambush alerted");	
}

ambusher_wait_for_combat()
{
	self waittill ("combat");

	level notify("ambush alerted");
}

ambusher_wait_for_notify()
{
	self waittill("ambush alerted");
	
	self.pacifist = 0;
	self.favoriteenemy = level.player;

	//self setgoalentity(level.player);
	myspot = getnode(self.target, "targetname");
	self setgoalnode(myspot);

	self.oldwalkdist = self.walkdist;
	self.walkdist = 0;
}	
// ****************

axis_stealth()
{
	//This function is intended to handle any ai I want to be in "non-alerted" mode.  Essentially, everyone threaded into this
	//will not react to the player until engaged in combat or otherwise alerted with a "stealth failed" notify.

	//WISHLIST: If this guy dies, check his entire group and see if anyone's within X units of his corpse, and alert them if 
	//they are and a trace can be made to his corpse
	//Perhaps thread entire group arrays into this function, might be a good way to do that

	//When this guy dies he cannot shout the alarm
	self endon("death");

	//Special exception for the docks house!! Thad this is lame!
	self endon("damaged");

	//If stealth is already failed, don't fail it again
	level endon("stealth failed");

	//Tell him to not attack the player until alerted
	self.pacifist = 1;

	//If the guys spawned in this function receive a "stealth failed" alert them by means of this thread
	self thread axis_stealth_alert_on_fail();
	
	//This guy will waittill he's engaged in combat
	self waittill("combat");

	if(isdefined(self.targetname))
	{
		println(self.targetname, " ^3is about to notify stealth failed!");
	}
	else
	{
		println("^3Axis_stealth entity is about to notify stealth failed!");
	}

	//Give a slight delay so that the player can kill this guy before he shouts the alarm
	wait 2;

	if(isdefined(self.targetname))
	{
		println(self.targetname, " ^3notified stealth failed!");
	}
	else
	{
		println("^3Axis_stealth entity notified stealth failed!");
	}
	
	//Shout "Der Fiend!" or whatever
	dialogueLine = "enemysighted";
	self animscripts\face::SayGenericDialogue(dialogueLine);

	//Make him attack and tell the level that this guy woke up
	self.pacifist = 0;

	level notify("stealth failed");
}

axis_stealth_alert_on_fail()
{
	//If this guy is dead, he obviously can't attack
	self endon("death");

	//Stealth has been failed! Wake up!
	level waittill("stealth failed");

	//If this guy has a script_noteworthy of "attack player" then he should charge the player when he's alerted
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "attack player")
	{
		self.goalradius = 256;
		self.favoriteenemy = level.player;
		self setgoalentity(level.player);
	}

	//Take this guy out of pacifist
	self.pacifist = 0;
}

//I wrote this function to check all of the specified group of friendlies to see that they are alive, and if they are they retarget
//the player to assist in friendly chain stuff...1 is sas1, 2 is sas2, 3 is both sas1 and 2.
squad_retarget(squad)
{
	if(!isdefined(squad))
	{
		println("^1ERROR (001): INVALID USE OF FUNCTION - SQUAD TO RETARGET TO PLAYER IS NOT SPECIFIED");
		return;
	}

	println("^5SQUAD ", squad, " ^5IS RETARGETING");

	switch (squad)
	{
		//Switch for squad1
		case 1:
				for(n=0;n<level.sas1.size;n++)
				{
					if(isalive(level.sas1[n]))
					{
						level.sas1[n] setgoalentity(level.player);
					}
				}
				break;

		//Switch for squad2
		case 2:
				for(n=0;n<level.sas2.size;n++)
				{
					if(isalive(level.sas2[n]))
					{
						level.sas2[n] setgoalentity(level.player);
					}
				}
				break;
			
		//Switch for both squads
		case 3:
				for(n=0;n<level.sas1.size;n++)
				{
					if(isalive(level.sas1[n]))
					{
						level.sas1[n] setgoalentity(level.player);
					}
				}
				for(n=0;n<level.sas2.size;n++)
				{
					if(isalive(level.sas2[n]))
					{
						level.sas2[n] setgoalentity(level.player);
					}
				}
				break;
	}
}

//-------------------------------------------------------------------------------------
//This function is to handle all of the independent, non-friendly-chain advancing stuff
//	Form for use:   
//
//	squad_moveup("d",1,"insert");
//
// This moves sas1 up to the markers named "d_sas1_n_insert" where n is each member of the squad
//
squad_moveup(location, squad, marker, individual)
{
	//Check to make sure all those parameters are valid when passed in
	if( (!isdefined(location)) || (!isdefined(squad)) || (!isdefined(marker)) )
	{
		println("^1ERROR (002): INVALID USE OF SQUAD_MOVEUP FUNCTION - UNDEFINED PARAMETERS");
		return;
	}

	if(squad != "1" && squad != "2" && squad !="3")
	{
		println("^1ERROR (003): INVALID SQUAD TYPE FOR FUNCTION SQUAD_MOVEUP -- MUST BE BETWEEN 1 AND 3, CURRENTLY ", squad);
		return;
	}
	
	//We don't really need this here, because the error check at the getnode seciton would catch it...but this may help 
	//determine if it's the node that is named bad or if I have passed a bad parameter through the script
	if(	location != "lh" && 			//lighthouse
		location != "d" &&			//docks
		location != "f" &&			//fort
		location != "g1" &&			//gun 1
		location != "g2" &&			//gun 2
		location != "g3" &&			//gun 3
		location != "m" &&			//magazine, 1
		location != "cy" &&			//courtyard
		location != "mp" &&			//motorpool
		location != "r" &&			//radio rooms
		location != "mag" )			//magazine, 2
	{
		println("^1ERROR (004): INVALID LOCATION FOR FUNCTION SQUAD_MOVEUP -- MUST BE A VALID CHARACTER STRING, ", location, " ^1IS NOT VALID");
		return;
	}

	//This initializes the metgoal array for use by the squads
	level thread squad_clear_metgoal();

	//Most of the time this will be for squad stuff, so if individual is not defined skip over it 
	if(isdefined(individual))
	{
		n=individual;
		if(squad == 1)
		{
			myspot = getnode(location + "_sas1_" + n + "_" + marker, "targetname");
	
			if(!isdefined(myspot))
			{
				println("^1ERROR (005): NODE NOT FOUND FOR FUNCTION SQUAD_MOVEUP -- ", location,"_sas1_",n,"_",marker);
				return;
			}

			if( (isalive(level.sas1[n]) && isdefined(myspot) ) ) 
			{	
				level.sas1[n] setgoalnode(myspot);
				level.sas1[n].squadgroup = squad;
				level.sas1[n] thread squad_wait_for_death();
				level.sas1[n] thread squad_wait_for_goal();
			}
			else println("^3Could not set node for dead friendly!");
		}
		else
		if( (squad == 2) || (squad == 3) )
		{
			myspot = getnode(location + "_sas2_" + n + "_" + marker, "targetname");
			
			if(!isdefined(myspot))
			{
				println("^1ERROR (006): NODE NOT FOUND FOR FUNCTION SQUAD_MOVEUP -- ", location, "_sas2_",n,"_",marker);
				return;
			}

			if(isalive(level.sas2[n])) 
			{	
				level.sas2[n] setgoalnode(myspot);
				level.sas2[n].squadgroup = squad;
				level.sas2[n] thread squad_wait_for_death();
				level.sas2[n] thread squad_wait_for_goal();
			}
			else println("^3Could not set node for dead friendly!");
		}
	}

	//Ok, it's not one guy, it's a whole squad
	else
	{
		if( (squad == 1) || (squad == 3) )
		{
			//Here for squad 1...
			for(n=0;n<level.sas1.size;n++)
			{
				myspot = getnode(location + "_sas1_" + n + "_" + marker, "targetname");
		
				if(!isdefined(myspot))
				{
					println("^1ERROR (007): NODE NOT FOUND FOR FUNCTION SQUAD_MOVEUP -- ", location,"_sas1_",n,"_",marker);
					return;
				}

				if( (isalive(level.sas1[n]) && isdefined(myspot) ) ) 
				{
					level.sas1[n] setgoalnode(myspot);
					level.sas1[n].squadgroup = squad;
					level.sas1[n] thread squad_wait_for_death();
					level.sas1[n] thread squad_wait_for_goal();
				}
				else println("^3Could not set node for dead friendly");
			}
		}

		if( (squad == 2) || (squad == 3) )
		{
			//and here for squad2...
			for(n=0;n<level.sas2.size;n++)
			{
				myspot = getnode(location + "_sas2_" + n + "_" + marker, "targetname");
			
				if(!isdefined(myspot))
				{
					println("^1ERROR (008): NODE NOT FOUND FOR FUNCTION SQUAD_MOVEUP -- ", location, "_sas2_",n,"_",marker);
					return;
				}

				if( isalive(level.sas2[n]) && isdefined(myspot) ) 
				{
					level.sas2[n] setgoalnode(myspot);
					level.sas2[n].squadgroup = squad;
					level.sas2[n] thread squad_wait_for_death();
					level.sas2[n] thread squad_wait_for_goal();
				}
				else println("^3Could not set node for dead friendly");
			}
		}
	}
}

squad_clear_metgoal()
{
	//Initializes or cleans up the squad_metgoal array
	for(n=0;n<level.sas1.size;n++)
	{
		level.squad1_metgoal[n] = false;
	}
	for(n=0;n<level.sas2.size;n++)
	{
		level.squad2_metgoal[n] = false;
	}
	println("^5SQUAD_CLEAR_METGOAL");
}

squad_wait_for_death()
{
	//On squadmember's death, do appropriate accounting
	self endon("goal");

	self waittill("death");

	println("^5SQUAD_WAIT_FOR_DEATH ACTIVATED");

	if(self.groupname == "sas1")
	{
		level.squad1_metgoal[self.n] = true;		//Assign self.n to entities when you create them
	
		self thread squad_wait_for_metgoal();
	}
	else 
	if(self.groupname == "sas2")
	{
		level.squad2_metgoal[self.n] = true;
	
		self thread squad_wait_for_metgoal();
	}
}

squad_wait_for_goal()
{
	//On squadmember achieving the appropriate goal, do the accounting
	self endon ("death");

	self waittill("goal");

	if(self.groupname == "sas1")
	{
		level.squad1_metgoal[self.n] = true;
		self thread squad_wait_for_metgoal();
	}
	else
	if (self.groupname == "sas2")
	{
		level.squad2_metgoal[self.n] = true;
		self thread squad_wait_for_metgoal();
	}

	println("^5SQUAD_WAIT_FOR_GOAL");
}

squad_wait_for_metgoal()
{
	//Each person who checks in will do the tally and see if it's time to notify the level that everyone's in place
	//Switch according to the "squad group type" send into the squad_move second parameter
	//squadgrouptype = 1 2 or 3, 3 being both 1 and 2
	squadtype = self.squadgroup;

	switch (squadtype)
	{
		case 1:	//Only check for squad 1 in place
			everyones_in_place = true;
			for(n=0;n<level.sas1.size;n++)
			{
				if(level.squad1_metgoal[n] == false && isalive(level.sas1[n]) ) 
				{
					println("sas1_",n," is not in place!");
					everyones_in_place = false;
				}
			}

			if(everyones_in_place) 			
			{
				println("1 THEY ALL GOT THERE");
				level notify("everyone's in place");
			}
			else println("1 NOT YET");
			break;
	
		case 2: //Only check 2nd squad in place
			everyones_in_place = true;
			for(n=0;n<level.sas2.size;n++)
			{
				if(level.squad2_metgoal[n] == false && isalive(level.sas2[n]) )				
				{
					println("sas2_",n," is not in place!");
					everyones_in_place = false;
				}
			}

			if(everyones_in_place) 
			{
				println("2 THEY ALL GOT THERE");
				level notify("everyone's in place");
			}
			else println("2 NOT YET");
			break;

		case 3: //Ok, check 'em both!
			everyones_in_place = true;
			for(n=0;n<level.sas1.size;n++)
			{
				if(level.squad1_metgoal[n] == false && isalive(level.sas1[n]) ) 
				{
					println("sas1_",n," is not in place!");
					everyones_in_place = false;
				}
			}
			for(n=0;n<level.sas2.size;n++)
			{
				if(level.squad2_metgoal[n] == false && isalive(level.sas2[n]) ) 
				{
					println("sas2_",n," is not in place!");
					everyones_in_place = false;
				}
			}

			if(everyones_in_place) 			
			{
				println("3 THEY ALL GOT THERE");
				level notify("everyone's in place");
			}

			else println("3 NOT YET");
			break;
	}
}		

squad_slow_regen()
{
	//This helps out your guys, they will regen slowly when not in combat
	self endon("death");

	//Checks to see if the guy's health is less than his starting health
	//if it is, the guy will regenerate 50 hp per minute until he's max if he's not in combat
	//if he is in combat, it will wait 1 minute before checking again
	myMaxHealth = self.myMaxHealth;

	while(1)
	{
		wait 0.05;

		if(self.anim_script != "combat")
		{
			if (self.health < myMaxHealth)
			{
				self.health += 50;
				println(self.name," ^2just regenerated 50 hp, now has ", self.health);
				wait 60;
			}
		}
		else
		{
			println(self.name," ^2is in combat, not regenerating for 1 minute - ", self.health,"/",myMaxHealth);
			wait 60;
		}
	}
}

//Stuff for the bomb planting sections
get_bomb_array(arrayname)
{
	//get all the triggers
	level.bombs = getentarray(arrayname, "groupname");

	for(n=0;n<level.bombs.size;n++)
	{
		//thread each trigger into its own wait 
		//and tell us that it hasn't been planted
		level.bombs[n] thread plant_this_bomb(n, arrayname);
		level.bombs[n].planted = false;
	}

	//thread the level into a check for all of the bombs
	level thread check_all_bombs_planted();
}

plant_this_bomb(n, arrayname)
{
	trg = level.bombs[n];

	bomb_incomplete = getent(trg.target, "targetname");

	bomb_incomplete show();

	trg setcursorhint("HINT_ACTIVATE");

	//Wait until the player uses the trigger
	trg waittill("trigger");

	if(!isdefined(bomb_incomplete.script_triggername))
	{
		println("^1BOMB_INCOMPLETE.SCRIPT_TRIGGERNAME IS NOT DEFINED");
	}
	else
	{
		name = bomb_incomplete.script_triggername;
		level.bomb_flag[name] = true;
	}		

	org = bomb_incomplete.origin;

	ang = bomb_incomplete.angles;

	bomb_complete = spawn("script_model", org);

	bomb_complete.angles = ang;

	bomb_complete setmodel ("xmodel/explosivepack");

	bomb_incomplete hide();

	bomb_complete playsound ("explo_plant_no_tick");

	println("Bomb planted!");

	if(arrayname == "g_bomb") 
	{
		trg thread guns_bombs_go_off(bomb_complete);
	}

	trg setcursorhint("HINT_NONE");

	level.bombs[n].planted = true;

	//play sound, plant charge
	level notify("bomb planted");

	level.bomb_delete[n] = bomb_complete;
}

check_all_bombs_planted()
{
	while(1)
	{
		wait 0.05;

		level waittill("bomb planted");
	
		all_bombs_planted = true;

		for(n=0;n<level.bombs.size;n++)
		{
			//Gee this looks familiar, eh...used the same method in squad_moveup
			if(level.bombs[n].planted == false) all_bombs_planted = false;
		}
		
		if(all_bombs_planted)
		{
			level notify("all bombs planted");
			println("all bombs planted");
			return;
		}
	}
}

squad_did_you_die()
{
	name = self.name;

	squad = self.squad;

	n = self.n;

	self waittill("death", who);

	level notify("teammate died!");

	//level thread squad_man_down(squad, n, name, who);
}

squad_man_down(squad,n,name, who)
{
	if(who!=level.player)
	{
		println(name," ^1has been killed!!!");
	}
	else
	{
		wait 1.5;
		missionfailed();
	}
}

squad_pacifist(pacifist)
{
	if(!isdefined(pacifist))
	{
		println("^1ERROR 015: PACIFIST STATE NOT SPECIFIED FOR SQUAD_PACIFIST");
		return;
	}

	if(pacifist > 1 || pacifist < 0)
	{
		println("^1ERROR 016: PACIFIST VALUE IS OUT OF RANGE FOR SQUAD_PACIFIST");
		return;
	}

	for(n=0;n<level.sas1.size;n++)
	{
		if(isalive(level.sas1[n])) level.sas1[n].pacifist = pacifist;
	}
	for(n=0;n<level.sas2.size;n++)
	{
		if(isalive(level.sas2[n])) level.sas2[n].pacfist = pacifist;
	}
	if(pacifist == 1) println("^5SQUADS SET TO PACIFIST");
	if(pacifist == 0) println("^5SQUADS SET TO NON-PACIFIST");
	println("^5SQUAD_PACIFIST");
}

float_boats()
{
	boats = getentarray("floating_boats", "groupname");
	
	for(n=0;n<boats.size;n++)
	{
		boats[n] thread float_my_boat();
		boats[n] thread rock_my_boat();
	}
}

float_my_boat()
{
	oldorigin = self.origin + (0,0,5);
	self.origin = oldorigin;

	while(1)
	{
		//sets up the random "float" movements
		num = (1+randomint(2));
		for (i=0; i<num; i++)
		{
			move_x = (4 - randomfloat(8));
			move_y = (4 - randomfloat(8));
			move_z = (1 - randomfloat(4));
			rand_time = (2.05+randomfloat(1));

			//***moveTo(vec position, float time, <float acceleration_time>, <float deceleration_time>);
			self moveTo ( (self.origin + (move_x, move_y, move_z) ), (rand_time), 1, 1 );
			self waittill ( "movedone" );
		}

		self moveTo ( oldorigin, (rand_time), 1, 1 );
		self waittill ("movedone");
	}
}

rock_my_boat()
{
	oldangles = self.angles;

	while(1)
	{
		//set up the random "bob" movements
		num = (1+randomint(2));
		for(i=0;i<num;i++)
		{
			roll = (4 - randomfloat(8));
			pitch = (8 - randomfloat(16));
			yaw = (1 - randomfloat(2));
			rand_time = (1 + randomfloat(2));

			self rotateto ( (self.angles + (roll, pitch, yaw) ), (rand_time), 0.25, 0.25);
			self waittill("rotatedone");
		}
	
		self rotateto ( oldangles, (rand_time), 0.25, 0.25);
		self waittill("rotatedone");
	}
}

//---------------------------
// DIALOGUE SUPPORT FUNCTIONS
//---------------------------
dialogue_array()
{
	level.dialogue_array = [];

	// level.dialogue_array["dlnum"].dline
	// level.dialogue_array["dlnum"].danim

	//"dlnum" = dialogue line index number
	//"dline" = dialogue line text string
	//"danim" = dialogue animation

	level.dialogue_array[0] = "ingram_brief1";
//	level.dialogue_array[0].danim = undefined;

	level.dialogue_array[1] = "ingram_brief2";

	level.dialogue_array[2] = "ingram_brief3";

	level.dialogue_array[3] = "ingram_bunker";

	level.dialogue_array[4] = "ingram_comms";

	level.dialogue_array[5] = "ingram_docks1";

	level.dialogue_array[6] = "ingram_docks2";

	level.dialogue_array[7] = "ingram_fort";

	level.dialogue_array[8] = "ingram_goodmen";

	level.dialogue_array[9] = "ingram_hoover";

	level.dialogue_array[10] = "ingram_hornets";

	level.dialogue_array[11] = "ingram_kill";

	level.dialogue_array[12] = "ingram_kubel";

	level.dialogue_array[13] = "ingram_lighthouse";

	level.dialogue_array[14] = "ingram_lorry";

	level.dialogue_array[15] = "ingram_courtyard";

	level.dialogue_array[16] = "ingram_kubel";

	level.dialogue_array[17] = "ingram_off_boat";

	level.dialogue_array[18] = "ingram_radios";

	level.dialogue_array[19] = "ingram_sabotage";

	level.dialogue_array[20] = "ingram_sentry";

	level.dialogue_array[21] = "ingram_staylow";

	level.dialogue_array[22] = "ingram_surprise";

	level.dialogue_array[23] = "ingram_towers";

	level.dialogue_array[24] = "ingram_uphill";

	level.dialogue_array[25] = "ingram_wall";

	level.dialogue_array[26] = "ingram_commentary";

	level.dialogue_array[27] = "luyties_sorry";

	level.dialogue_array[28] = "german1_starving";

	level.dialogue_array[29] = "german2_bored";

	level.dialogue_array[30] = "german1_stomach";

	level.dialogue_array[31] = "ingram_low_cover";

	level.dialogue_array[32] = "luyties_lorry_stalled";

	level.dialogue_array[33] = "ingram_sticky_wicket";

	level.dialogue_array[34] = "moditch_behindyou";

	level.dialogue_array[35] = "denny_lookout";
	
	level.dialogue_array[36] = "moditch_search";

	level.dialogue_array[37] = "moditch_good";

	level.dialogue_array[38] = "moditch_fire_hole";

	level.dialogue_array[39] = "denny_fire_hole";

	level.dialogue_array[40] = "denny_outta_here";

	level.dialogue_array[41] = "moditch_oh_man";
}

//---------------------------
// ANIMATION SUPPORT FUNCTION
//---------------------------
anim_single_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_single (newguy, anime, tag, node, tag_entity);
}

anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
{
	newguy[0] = guy;
	maps\_anim::anim_loop ( newguy, anime, tag, ender, node, tag_entity );
}

//----------------------------
delete_all_axis()
{	
	//DELETE ALL OF THE GUYS!!! ALL OF EM!!!
	alltheaxis = getaiarray("axis");
	for(n=0;n<alltheaxis.size;n++)
	{
		if(isdefined(alltheaxis[n].script_noteworthy))
		{
			//Exclude some dudes...eg bunker guards etc.
			if(alltheaxis[n].script_noteworthy != "exclude me")
			{
	
				//For now, only call this when you want to delete EVERYONE (except tagged individuals)
				//If you get a bug about some guy deleting when the player can see him, it's here...
				alltheaxis[n] delete();
			}
		}
		else
		{
			alltheaxis[n] delete();
		}

	}
}

hide_player()		//For cheat functionality, allows tp'ing the friendlies around
{
	oldorg = level.player.origin;
	level.player setorigin( (0,0,-10000) );
	level waittill("tp done");
	level.player setorigin(oldorg);
}

destroyable_boxes_setup()
{
	array_thread (getentarray("box_damage", "groupname"), ::destroyable_box);
}

destroyable_box()
{
	self waittill("trigger");
	
	if(!isdefined(self.target))
	{
		println("^1BOX ERROR: TRIGGER_DAMAGE TARGET NOT DEFINED");
		return;
	}

	mybox = getent(self.target, "targetname");
	speaker = spawn("script_origin", mybox.origin);

	if(isdefined(mybox.target)) myclip = getent(mybox.target, "targetname");
	if(isdefined(myclip)) myclip delete();
	mybox delete();
	self delete();

	speaker playsound("wood_shatter");
	playfx(level._effect["wood"], speaker.origin);
	wait 1;
	myclip = getent(mybox.target, "targetname");
	myclip delete();
	speaker delete();
}

destroyable_glass_setup()
{
	array_thread (getentarray("glass", "groupname"), ::destroyable_glass);
}

destroyable_glass()
{
	self waittill("trigger");

	myglass = getent(self.target, "targetname");

	if(!isdefined(myglass)) 
	{
		println("^1ERROR: GLASS NOT DEFINED");
		return;
	}

	org = myglass.origin;
 	if(!isdefined(org)) 
	{
		println("Glass org not defined, cannot play FX");
	}
	else
	{
		playfx(level._effect["lh_glass"], org);
	}

	myglass delete();

	self delete();
}

red_barrel_setup()
{
	array_thread(getentarray("barrel_damage", "groupname"), ::red_barrel);
}

red_barrel()
{
	self waittill("damage", amt);

	if(!isdefined(self.ttldmg))
	{
		self.ttldmg = 0 + amt;
	}

	if(isdefined(self.ttldmg))
	{
		self.ttldmg+=amt;
	}

	if(self.ttldmg < 100)
	{
		self thread red_barrel();
		return;
	}
	
	mybarrel = getent(self.target, "targetname");

	speaker = spawn("script_origin", mybarrel.origin);

	myclip = getent(mybarrel.target, "targetname");

	//Get rid of the barrel and the trigger so they don't interfere
	mybarrel delete();	
	self delete();
	myclip delete();

	speaker playsound("explo_metal_rand");
	playfx(level._effect["red_barrel"], speaker.origin);

	//origin, range, max damage, min damage
	radiusDamage (speaker.origin + (0,0,10), 300, 590, 100);

	//scale, duration, source, radius
	earthquake(0.25, 1, speaker.origin, 1050);

	if(isdefined(self.script_triggername))
	{
		simultaneous_explosions = getentarray(self.script_triggername, "targetname");
		for(n=0;n<simultaneous_explosions.size;n++)
		{
			wait 0.05 + randomfloat(0.2);
			thisbarrel = getent(simultaneous_explosions[n].target, "targetname");
			if(!isdefined(thisbarrel)) return;
			thisspeaker = spawn("script_origin", thisbarrel.origin);

			//Get rid of the barrel and the trigger so they don't interfere
			thisbarrel delete();
			self delete();

			playfx(level._effect["red_barrel"], speaker.origin);
			thisspeaker playsound("explo_metal_rand");
			radiusDamage (speaker.origin + (0,0,10), 300, 590, 100);
			earthquake(0.25, 3, speaker.origin, 1050);
		}
	}
}

boat_damage_setup()
{
	//Nope, it's CUT. Too bad, but someday I'll get to decide what gets cut
//	array_thread(getentarray("boat_damage", "groupname"), ::boat_damage);
}

boat_damage()
{
	//First topmost boat in stack gets threaded, it points to the other boats

	//Wait for damage
	self waittill("damage", amt);

	if(!isdefined(self.ttldmg))
	{
		self.ttldmg = 0 + amt;
	}

	if(isdefined(self.ttldmg))
	{
		self.ttldmg+=amt;
	}

	//If there's not enough damage done, wait until there is
	if(self.ttldmg < 600)
	{
		self thread boat_damage();
		return;
	}

	myboat = getent(self.target, "targetname");
	
	if(isdefined(self.script_triggername))
	{
		mynextboat = getent(self.script_triggername, "targetname");
		mynextboat thread boat_damage();
	}

	playfx(level._effect["boatwood"], myboat.origin);

	myboat delete();
	self delete();
}

Falling_Debris(targetname)
{
	anim_name = "sicily1_lighthouse_explosion";

	debris = getentarray(targetname,"targetname");

	org = spawn("script_model", (0,0,0));

	if(isdefined(anim_name))
	{
		org.animname = anim_name;
	}
	else
	{
		println("^1ERROR 009:  ANIM NAME NOT SPECIFIED FOR SCRIPT DEBRIS, ", targetname);
		return;
	}

	println("^2org.animname: ",org.animname);

	// Setup the fake origin.
	org setmodel(("xmodel/" + org.animname));

	// org UseAnimTree(level.scr_animtree["kharkov2_debris"]);
	org UseAnimTree(level.scr_animtree["sicily1_debris"]);

	// Link the debris to the tags on the script_model.
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
				//debris[i] notsolid();		//Player won't be able to interact with this crap
				org thread Falling_Debris_FX(org, debris[i].script_noteworthy, debris[i]);
				org thread Falling_Debris_Fire(org, debris[i].script_noteworthy, debris[i]);
			}
		}
	}

	// Play the animation.
//	org setFlaggedAnimKnobRestart("animdone", level.scr_anim[self.animname]["reactor"]);
	org animscripted("single anim", org.origin, org.angles, level.scr_anim[org.animname]["reactor"]);

//	org thread maps\_anim_gmi::notetrack_wait(org, "single anim", undefined, "reactor");

	org waittillmatch("single anim","end");

//	org notify("stop_looping_fx");		//Mike said this was old

	wait 0.1;

	// Unlink the Objects.
	for(i=0;i<debris.size;i++)
	{
		if(isdefined(debris[i]))
		{
			debris[i] unlink();
//			debris[i] thread Debris_Solid_Think();
		}
	}

	org delete();
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
	org endon("death");
	while(1)
	{
		org waittillmatch("single anim",tag + "_sound");

		if(tag == "tag_top" || tag == "tag_middle" || tag == "tag_bottom")
		{
			println("^3LIGHTHOUSE SOUND PLAYING FOR (",tag,")");
			self playsound("big_stone_crash");
		}
		else
		{
			println("^1LIGHTHOUSE SOUND NOT PLAYING BECAUSE THIS PIECE IS INCIDENTAL - ", tag);
		}
	}
}

Falling_Debris_FX(org, tag, debris)
{
	org thread Falling_Debris_FX_Think(org, tag);
	debris thread Falling_Debris_Sound(org, tag);
	
	org endon(tag + "_stopfx");
	while(1)
	{
		playfxontag(level._effect["debris_trail_50"], org, tag);
		wait 0.05;
	}
}

Falling_Debris_FX_Think(org, tag)
{
	org waittillmatch("single anim", tag + "_fx");
	org notify(tag + "_stopfx");
	println("END!!! = ",tag);
}

Falling_Debris_Fire(org, tag, debris)
{
	org thread Falling_Debris_Fire_Think(org, tag);
	org endon(tag + "_firestop");

	org waittill(tag + "_firestart");
	while(1)
	{
		playfxontag(level._effect["lighthouse_firetrail"], org, tag);
		wait 0.05;
	}
}

Falling_Debris_Fire_Think(org,tag)
{
	org waittillmatch("single anim", tag + "_firestart");
	org notify(tag + "_firestart");
	org waittillmatch("single anim", tag + "_firestop");
	org notify(tag + "_firestop");
	println("FIRE FX END = ",tag);
}

Ambient_sound_track_handler()
{
	trgs = getentarray("ambient_trigger", "groupname");

	if( !isdefined(trgs) )
	{
		println("^1ERROR 010: NO AMBIENT SOUND TRIGGERS PRESENT IN MAP");
		return;
	}

	level thread array_thread(trgs,::ambient_trigger_waitfor_switch);
}

ambient_trigger_waitfor_switch()
{
	if (!isdefined(self.script_noteworthy)) 
	{
		println("^1ERROR 011: AMBIENT SOUND TRIGGER DOES NOT HAVE SCRIPT_NOTEWORTHY SPECIFIED");
		return;
	}
	this_sound = self.script_noteworthy;

	self waittill("trigger");
	
	if(level.current_ambient != this_sound)
	{
		if(this_sound != "inside" && this_sound != "outside" && this_sound != "top of path" && this_sound != "underground")
		{
			println("^1ERROR 012: INVALID AMBIENT SOUND SPECIFIED IN SCRIPT_NOTEWORTHY: ", this_sound);
			return;
		}

		level thread maps\_utility_gmi::set_ambient(this_sound);
	
		level.current_ambient = this_sound;

		self thread ambient_trigger_waitfor_switch();
	}
	else
	{
		println(self.script_noteworthy," sound is already playing, aborting switch!");
	
		wait 0.5;

		self thread ambient_trigger_waitfor_switch();	
	
		return;
	}
}

// Music for start of map
music()
{
	//level waittill("finished intro screen");
	musicplay("sicily1_boatride");
}

//=====================================================================================================================
// * * * END GAME FUNCTIONS && UTILITIES * * *
//=====================================================================================================================



//=====================================================================================================================
// * * * MAIN GAME SCRIPT * * *
//=====================================================================================================================
start_of_map()
{
	level thread objective_1();

	level thread docks_boatride();
}

//=====================================================================================================================
// THE DOCKS
//=====================================================================================================================
#using_animtree ("fishingboat");
docks_boatride()
{
	//Get the location of the end of the docks & place the rig
	//Then spawn the boat model and link it to the rig,
	//hiding the rig but threading it into the next function
	org = getent("dock_anim","targetname").origin;
	p_boat_dummy = spawn("script_model",org);
	p_boat_dummy setmodel ("xmodel/v_br_sea_sicily1_fishingboat_rig");
	p_boat = spawn("script_model",p_boat_dummy.origin);
	p_boat setmodel ("xmodel/v_br_sea_sicily1_fishingboat");
	p_boat UseAnimTree(#animtree);
	level.p_boat_dummy = p_boat_dummy;
	level.p_boat = p_boat;
	p_boat linkto(p_boat_dummy,"tag_origin",(0,0,0),(0,0,0) );
	p_boat_dummy hide();
	p_boat_dummy UseAnimTree(#animtree);


	p_boat_dummy thread docks_boat_arrival();
	
	//Wake effects
	p_boat thread maps\sicily1_fx::boat_wake(p_boat_dummy);
	
	//Don't allow player to prone in his seat
	level.player allowStand(true);
	level.player allowCrouch(true);
	level.player allowProne(false);
	
	level waittill("finished intro screen");

	//Do the guard assassination stuff...
	level thread docks_assassination_idle();
	level thread docks_assassination_guard_dies();
	level thread ingram_wait_to_ready_gun();

	//Moditch has gun in left hand
	level.sas2[0] animscripts\shared::PutGunInHand("left");	

	wait 7;

	//Cliff guns shoot as npc points at them
	level thread cliff_guns_shoot();

	//*Should be* replaced by
	//NOTETRACKS!!!

	wait 20;

	level waittill("continue talking 2");

	//Ingram gives orders to Hoover and Luyties
	//$$
	level.sas1[0] thread anim_single_solo(level.sas1[0], level.dialogue_array[9]);		//ingram_hoover  "Hoover, Luyties, remove that sentry"
	//$$

	wait 6;
	//$$
	level.sas1[0] thread anim_single_solo(level.sas1[0], level.dialogue_array[17]);		//ingram_off_boat
	//$$
}

ingram_wait_to_ready_gun()
{
	//*Should be*
	//Replaced by NOTETRACKS

	wait 13;
	
	//Ready Ingram's gun as he puts down the binoculars
	level.sas1[0] animscripts\shared::PutGunInHand("right");
	level.sas1[0] detach("xmodel/w_us_spw_binocular_world", "tag_weapon_left");
}

docks_boat_arrival()
{
	//Start docks stuff
	level thread docks_vo();
	level thread docks_house_guards_kibitz();

	//Set the player's origin to the tag they should be on, then link them
	tagorg = level.p_boat gettagorigin("tag_player");
	level.player setorigin(tagorg);
	level.player playerlinkto(level.p_boat, "tag_player", (0.3,0.3,0.3) );

	//Link the friendly squad members to the appropriate tag on the boat
	level.sas2[0] linkto(level.p_boat, "tag_guy1", (0,0,0), (0,0,0));		//moditch
	level.sas1[1] linkto(level.p_boat, "tag_guy2", (0,0,0), (0,0,0));		//luyties
	level.sas1[2] linkto(level.p_boat, "tag_guy3", (0,0,0), (0,0,0));		//hoover
	level.sas2[1] linkto(level.p_boat, "tag_guy4", (0,0,0), (0,0,0));		//denny
	level.sas1[0] linkto(level.p_boat, "tag_guy5", (0,0,0), (0,0,0));		//ingram

	//Start the boat animations for the ride into the docks area
	level.p_boat setflaggedanimrestart("boatanim",%v_br_sea_sicily1_boatfishing,1,.1,1);
	self setflaggedanimrestart("boatanim",%v_br_sea_sicily1_boatfishing_path,1,.1,1);

	//Handle all of the animating passengers
	level thread docks_boat_driver_handler();
	level thread docks_boat_passenger_1();
	level thread docks_boat_passenger_2();
	level thread docks_boat_passenger_3();
	level thread docks_boat_passenger_4();
	level thread docks_boat_passenger_5();

	//Play the sound of the boat motoring in
	level.p_boat playsound("fishing_boat_ride");
	
	//When the animation's over, notify the level
	self waittillmatch ("boatanim","end");
	level notify("boat's at dock");

	//Play the idle "bobbing" animation at the docks
	while(1)
	{
		level.p_boat setanimrestart(%v_br_sea_sicily1_boatfishing_end,1,.1,1);
		level.p_boat waittill ("end");
	}
}

docks_vo()
{
	//*Should be*
	//REPLACED BY NOTETRACKS

	//Opening speech Ingram makes
	//$$
	level waittill("finished intro screen");
	level waittill("continue talking");

	anim_single_solo(level.sas1[0], level.dialogue_array[22]);		//ingram_surprise
	anim_single_solo(level.sas1[0], level.dialogue_array[5]);		//ingram_docks1
	anim_single_solo(level.sas1[0], level.dialogue_array[6]);		//ingram_docks2

	level notify("continue talking 2");
}

docks_boat_driver_handler()
{
	//The boat driver is just an animating model, not an actual AI
	level.boatdriver = spawn("script_model", level.p_boat.origin );
	level.boatdriver.angles = level.p_boat.angles;
	level.boatdriver setmodel ("xmodel/c_br_body_ingram");
	level.boatdriver.animname = "boatdriver";
	level.boatdriver UseAnimTree(level.scr_animtree[level.boatdriver.animname]);
	level.boatdriver [[level.scr_character["boatdriver"]]]();
	level.boatdriver linkto(level.p_boat,"tag_boat", (0,0,0),(0,0,0));
	level.boatdriver setflaggedanimknobrestart("boatdriver anim1 done", level.scr_anim["boatdriver"]["boatdriver1"], 1, 0.5, 1 );
	
	//Wait until the boat's at the dock, then begin your idle animation
	level waittill("boat's at dock");
	level.boatdriver setflaggedanimknobrestart("boatdriver animend done", level.scr_anim["boatdriver"]["boatdriverend"], 1, 0.5, 1 );
}

docks_boat_passenger_1()	//moditch
{
	level.p_boat anim_single_solo(level.sas2[0], "boatguy1", "tag_guy1");

	//At the end of his animation, unlink him
	level.sas2[0] unlink();
}

docks_boat_passenger_2()	//luyties
{
	level thread puke_noises();
	
	level.p_boat anim_single_solo(level.sas1[1], "boatguy2", "tag_guy2");

	//At the end of his animation, unlink him
	level.sas1[1] unlink();

	//Set this guy's run animation speed up so that he can "sprint" into position
	level.oldrun1 = level.sas1[1].runanimplaybackrate;
    	level.sas1[1].runanimplaybackrate = 1.6;

	//Set this guy's nodes for the assassination of the docks sentry
	myspot = getnode("d_sas1_1_strangled", "targetname");
	level.sas1[1] setgoalnode(myspot);

	//Reset his animation playback rate so that he can no longer sprint
    	level.sas1[1].runanimplaybackrate = level.oldrun1;
}

puke_noises()
{
	//187 frame / 30 = 6.233
	//256 frame / 30 = 8.533
	//318 frame / 30 = 10.6
	//384 frame / 30 = 12.8

	wait 6.233;

	println("sick1");

	wait 2.3;
	println("sick2");
	level.sas1[1] playsound("luyties_puke01");

	wait 2.066;
	println("barf1");
	level.sas1[1] playsound("luyties_puke02");

	wait 2.2;
	println("barf2");
	level.sas1[1] playsound("luyties_puke03");

	wait 3;

	//$$
	println("luyties_sorry");
	anim_single_solo(level.sas1[1], level.dialogue_array[27]);		//luyties_sorry
	level notify("continue talking");
}

docks_boat_passenger_3()	//hoover
{
	level.p_boat anim_single_solo(level.sas1[2], "boatguy3", "tag_guy3");

	//At the end of his animation, unlink him from the boat
	level.sas1[2] unlink();

	//Set this guy's run animation speed up so that he can "sprint" into position
	level.oldrun2 = level.sas1[2].runanimplaybackrate;
    	level.sas1[2].runanimplaybackrate = 1.6;

	//Set this guy's nodes for the assassination of the docks sentry
	myspot = getnode("d_sas1_2_strangled", "targetname");
	level.sas1[2] setgoalnode(myspot);

	//Reset his animation playback rate so that he can no longer sprint
    	level.sas1[2].runanimplaybackrate = level.oldrun2;
}

docks_boat_passenger_4()	//denny
{
	level.p_boat anim_single_solo(level.sas2[1], "boatguy4", "tag_guy4");

	//Unlink him at the end of his animation
	level.sas2[1] unlink();
}

docks_boat_passenger_5()	//ingram
{
	level.sas1[0] thread ingram_notetracks();

	level.p_boat anim_single_solo(level.sas1[0], "boatingram1", "tag_guy5");

	//Unlink Ingram from the boat
	level.sas1[0] unlink();

	//Continue the flow 				//-=>docks_a
	level thread docks_get_off_the_boat();
}

ingram_notetracks()
{
	while(1)
	{
		self waittill("single anim", notetrack);

		if(isdefined(notetrack))
		{
			switch(notetrack)
			{
				case "step_walk_wood":	self playsound("step_walk_wood");
							break;
	
				case "step_walk_metal": self playsound("step_walk_metal");
							break;
	
		//Here's where the alternate notetrack system is...notetracks in animation are currently not timed properly
		//so I hacked in the timing, and it's worked well enough
//				case "ingram_surprise": level thread anim_single_solo(level.sas1[0], level.dialogue_array[22]);		//ingram_surprise
//							break;
//				
//				case "ingram_docks1": 	level thread anim_single_solo(level.sas1[0], level.dialogue_array[5]);		//ingram_docks1
//							break;
//	
//				case "ingram_docks2":	level thread anim_single_solo(level.sas1[0], level.dialogue_array[6]);		//ingram_docks2
//							break;
//		
//				case "attach_sten":	self animscripts\shared::PutGunInHand("right");
//							self detach("xmodel/w_us_spw_binocular_world", "tag_weapon_left");
//							break;
//	
//				case "ingram_hoover":	self thread anim_single_solo(level.sas1[0], level.dialogue_array[9]);		//ingram_hoover  "Hoover, Luyties, remove that sentry"
//							break;
//	
//				case "ingram_off_boat":	self thread anim_single_solo(level.sas1[0], level.dialogue_array[17]);		//ingram_off_boat
//							break;
			}
		}
	}
}

docks_get_off_the_boat()
{
	//Start the docks insertion 			//docks_a<=-|-=>docks_b
	level thread docks_insertion();

	squad_retarget(2);

	//Allow the player to stand up
	level.player allowStand(true);
	level.player allowCrouch(true);
	level.player allowProne(true);

	wait 1;

	level.player setorigin(level.player.origin + (0,0,10));

	level.player unlink();

	//Turn off that pesky friendlychain on the docks, it keeps calling 2nd squad back to block you
	maps\_utility_gmi::chain_off("10");
}

//////////
//Handler functions to control the guys on the docks area
/////////
docks_0_handler()
{
	self.pacifist = 1;
	//animate me
}

docks_1_handler()
{	
	self.pacifist = 1;
	//animate me too
}

docks_2_handler()
{
	self.pacifist = 1;
}

docks_5_handler()
{
	self.pacifist = 1;
}

//////////
//Main flow of game level continues here
/////////
#using_animtree("generic_human");
docks_insertion()					
{
	//Set up the docks house
	level thread docks_house_setup();			

	//Open the dock house door 
	level.docks_house_door rotateto( (0,-90,0), 0.4, 0.2, 0);
	level.docks_house_door connectpaths();

	//Set up the "alert the guards if the player sucks"
	level thread docks_no_noisy_weapons();

	//Notify the individual guards if the level is notified "stealth failed"
	level thread docks_house_stealth_failed();

	//Play the kibitz sounds after the trigger is hit
	level thread docks_house_guards_kibitz_sounds();

	//If the player shoots the MG gunner, alert the officer
	level thread docks_bunker_mg_death_alerts_officer();
	
	//Set up the truck the player will use in the near future
	level thread docks_truck_setup();

	//Set up crouch/prone stealth triggers and set up bypass check
	level thread docks_neck_stealth();

	//MG gunner takes his gun on alert
	level thread docks_mg_gunner();

	//This thread causes the friendly squad reaction "compromised!"
	level thread docks_compromised();		

	//This thread allows the player to interrupt the assassination attempt
	level thread docks_assassination_interrupted();	

	/////////////////////////////////////////
	//End this thread if the officer dies...
	level.d_axis[0] endon("death");
	/////////////////////////////////////////
	//Once the player shoots at the officer and doesn't kill him, abort his patrol
	level endon("stealth failed");
	/////////////////////////////////////////

	//Remove Hoover's gun
	level.sas1[2] animscripts\shared::PutGunInHand("none");

	//Get the assassin up into position and wait for his backup
	level.sas1[1] waittill("goal");

	org = level.d_axis[0].origin;
	ang = level.d_axis[0].angles;

	startorg = getstartOrigin (org, ang, level.scr_anim["hoover"]["kill_guard"]);

	level.sas1[1].goalradius = 4;

	level.sas1[2] setgoalpos(startorg + (60, 0, 0) );
	level.sas1[2] waittill("goal");

	//He's in place, start the assassination
	level notify("assassination setup complete");

	level.sas1[2] animscripted( "scriptedanimdone", org + (-29,0,0), ang, level.scr_anim["hoover"]["kill_guard"] );

	level notify("guard is dead");

	level.sas1[2] waittill("scriptedanimdone");

	//Hoover's gun goes back in hand
	level.sas1[2] animscripts\shared::PutGunInHand("sten_silenced");

	println("^5OBJECTIVE 1 IS UPDATING!");
	level notify("update objective 1");

	level thread docks_assassination_continue();
}

docks_assassination_idle()
{
	level.d_axis[0] endon("death");
	level endon("assassination setup complete");
	level endon("stealth failed");

	//Get guard into place and then start his idle animation
	node = getnode("d_axis_0_patrol_2", "targetname");
	level.d_axis[0] teleport( node.origin );
	org = node.origin;
	ang = node.angles;

	level.d_axis[0].org = org;
	level.d_axis[0].ang = ang;

	while(isalive(level.d_axis[0]))
	{
		//self animscripted("scriptedanimdone", self.seeknode.origin, self.seeknode.angles, level.scr_anim[notifyname][self.character]["animation"]);
		level.d_axis[0] animscripted("scriptedanimdone", org, ang, level.scr_anim["d_axis_0"]["guard_loop"]);

		level.d_axis[0] waittill("scriptedanimdone");
	}
}

docks_assassination_guard_dies()
{
	level waittill("assassination setup complete");

	org = level.d_axis[0].org;
	ang = level.d_axis[0].ang;

	//Set his deathanim then kill him	
	level.d_axis[0].deathanim = undefined;

	level.d_axis[0].allowdeath = 0;
	level.d_axis[0] animscripted("scriptedanimdone", org, ang, level.scr_anim["d_axis_0"]["guard_death"]);
	level.d_axis[0] waittill("scriptedanimdone");
	
	level.d_axis[0] settakedamage(0);
	level.d_axis[0].ignoreme = true;
	level.d_axis[0].team = "neutral";

	//remove the clip stopping the player from progressing up the ramp
	level.docks_blocker delete();

	while(1)
	{
		level.d_axis[0] animscripted("scriptedanimdone", org, ang, level.scr_anim["d_axis_0"]["guard_dead"]);
		level.d_axis[0] waittill("scriptedanimdone");
	}
}

docks_assassination_continue()
{
	myspot = getnode("thad_701", "targetname");
	level.sas2[1] setgoalnode(myspot);

	wait 0.5;

	//This thread because the previous one terminates on the guard's death
	maps\_utility_gmi::autosave(1);
	println("^5Autosave 1 completed.");

	//Give the player his gun back so he can mess up the event
	level.player giveweapon(level.player_weapon);
	level.player switchtoweapon(level.player_weapon);

	level.sas1[0] anim_single_solo(level.sas1[0], level.dialogue_array[31]);		//ingram_low_cover

	//squad1 to moveS into post-strangle positions
	level thread squad_moveup("d",1,"insert");
	println("squad 1 moveup...");

	for(n=3;n<level.d_axis.size;n++)
	{
		//Thread all of the guards into the stealth function
		if(isalive(level.d_axis[n])) level.d_axis[n] thread axis_stealth();
		wait 0.05;
	}

	//Slight pause after the officer is dead
	wait 0.5;

	myspot = getnode("thad_700", "targetname");
	level.sas2[0] setgoalnode(myspot);

	level.sas2[0] waittill("goal");

	chain = maps\_utility::get_friendly_chain_node ("20");
	level.player SetFriendlyChain (chain);
	squad_retarget(2);
}

docks_assassination_interrupted()
{
	level thread docks_assassination_death_check();

	//Ends on guy's death
	level endon("docks guard dead");

	level endon("stealth failed");

	//If he finishes his single anim...he's gonna die within 1 second
	level.d_axis[0] waittillmatch("single anim", "end");

	level.d_axis[0] stopanimscripted();

	//Reset the assassins' run anim playback speed, because I bumped it up so they could "sprint"
    	level.sas1[1].runanimplaybackrate = level.oldrun1;
    	level.sas1[2].runanimplaybackrate = level.oldrun2;

	wait 1;

	squad_retarget(2);

	squad_pacifist(0);

//	//The enemy shouts and attacks the player
//	dialogueLine = "enemysighted";
//	level.d_axis[0] animscripts\face::SayGenericDialogue(dialogueLine);
//	level.d_axis[0].favoriteenemy = level.player;
//	level.d_axis[0].pacifist = 0;
//
//	//The player has shot at the officer and failed to kill him
//	level notify("stealth failed");
}

docks_assassination_death_check()
{
	//Wait until the officer dies
	level.d_axis[0] waittill("death", who);

	level notify("docks guard dead");

	//Reset the assassins' run anim playback speed, because I bumped it up so they could "sprint"
    	level.sas1[1].runanimplaybackrate = level.oldrun1;
    	level.sas1[2].runanimplaybackrate = level.oldrun2;
	
	//If it wasn't the player that killed him, return
	if(isdefined(who) && who!=level.player) return;
	
	//Otherwise, continue the flow
	level thread squad_moveup("d",1,"insert");
}

docks_compromised()
{
	//Once the player's in the house, Ingram's not gonna shout "compromised"
	level endon("house infiltrated");

	//Wait for the guards to be alerted
	level waittill("stealth failed");						

	level notify("bypass failed");

	maps\_utility_gmi::chain_on("80");		//Outside the docks house

	//All of the Axis guards get deadlier
	docks_axis = getentarray("docks_axis", "groupname");
	for(n=0;n<docks_axis.size;n++)
	{
		if(isalive(docks_axis[n]))
		{
			docks_axis[n].health = 200;
			docks_axis[n].accuracy = 1;
		}
	}
	println("^5All of the docks_axis are deadlier because stealth was failed!");

	//Only update the objective if it hasn't been
	if(level.docks_objective == "2") level notify("update objective 1");		

	wait 0.05;
	
	//Ingram hollers when the sh*t jumps off
	level.sas1[0] anim_single_solo(level.sas1[0], level.dialogue_array[11]);	//ingram_kill "Compromised!  Kill them, quickly!"

	//Once stealth is failed, let everyone know to move up
	level thread squad_moveup("d",2,"cover");

	//Moves squad1 up to advance nodes to engage the bunker
	squad_moveup("d",1,"advance");

	//Retargets the player's squad at the player so that they are back on the friendly chains for the combat
	squad_retarget(2);

	//Don't do anything else until the MG guy is eliminated
	while(isalive(level.d_axis[4]))
	{
		wait 1;
	}

	//If the patroller's still alive, advance to position 1
	if(isalive(level.d_axis[3]))
	{
		squad_moveup("d",1,"advance");
		level waittill("everyone's in place");		
	}
	
	//The MG and patroller are both dead, move squad1 up farther along the docks neck
	level thread squad_moveup("d",1,"cover");
	println("squad1 covering from docks_compromised");

	level thread docks_bunker_wait_to_be_cleared();

	level thread docks_get_in_the_truck();
}

docks_mg_gunner()
{
	//Waiting for alert from guys threaded into axis_stealth
	level waittill("stealth failed");

	//Tell the MG gunner to grab that gun!
	for(n=0;n<level.docks_axis.size;n++)
	{
		if(isalive(level.d_axis[n])) 
		{
			wait 0.5;
			level.d_axis[n].pacifist = 0;
			if(n==4) level thread docks_axis_4_useturret();
		}
	}
}

docks_house_setup()						
{
	//Make sure the player didn't try to break my carefully crafted event ;)
	level thread docks_house_bypass_check();

	//Continue control of the level
	level thread docks_house_friendlies_go();		

	//Make sure that once the bunker is cleared, the level continues
	level thread docks_bunker_wait_to_be_cleared();				
}

docks_house_hack_2()
{
	level.d_axis[1] thread maps\_utility_gmi::magic_bullet_shield();
	level.d_axis[2] thread maps\_utility_gmi::magic_bullet_shield();
	level.d_axis[1] settakedamage(0);
	level.d_axis[2] settakedamage(0);
	println("^3level.d_axis[2] received magic_bullet_shield");

	//
	level waittill_any("d_axis_2 vulnerable", "stealth failed");
	//

	level.d_axis[1] notify("stop magic bullet shield");
	level.d_axis[2] notify("stop magic bullet shield");
	level.d_axis[1] settakedamage(1);
	level.d_axis[2] settakedamage(1);
	println("^3level.d_axis[2] received stop magic bullet shield");
}

docks_house_guards_kill_check()
{
	level endon("stealth failed");

	while( level.docks_house_1_dead == false || level.docks_house_2_dead  == false )
	{
		wait 0.05;
	}
	level notify("docks house guards dead");
}

#using_animtree("dock_house_chair");
docks_house_guards_kibitz()
{
	//Use the origin of the world and place the rig there
	//Then spawn the chair model and link it to the rig,
	//hiding the rig but threading it into the next function
	org = (0,0,0);
	level.chair_dummy = spawn("script_model",org);
	level.chair_dummy setmodel ("xmodel/sicily1_dockhouse_chair");
	level.chair_dummy.animname = "dock_house_chair";
	level.chair_dummy UseAnimTree(#animtree);
	level.chair = getent("dock_house_chair", "targetname");
	level.chair linkto(level.chair_dummy,"tag_chair",(0,0,0),(0,0,0) );
	level.chair_dummy hide();
	level.chair_dummy UseAnimTree(#animtree);

	//Set the various attributes on the guards
	level.d_axis[1].animname = "d_axis_1";
	level.d_axis[1].deathanim = level.scr_anim["d_axis_1"]["seated_death"];
	level.d_axis[1].allowdeath = true;
	level.d_axis[1].health = 1;
	level.d_axis[1] thread docks_house_guards_kibitz_idle_1();
	level.d_axis[1] thread docks_house_alerted_1();
	level.d_axis[1] thread docks_house_death_1();

	level.d_axis[2].animname = "d_axis_2";

	level.d_axis[2].health = 1;
	level.d_axis[2].allowdeath = true;
	level.d_axis[2] thread docks_house_guards_kibitz_idle_2();
	level.d_axis[1] thread docks_house_alerted_2();
	level.d_axis[1] thread docks_house_death_2();

	level.d_axis[1] thread docks_guard_1_wait_for_death();
	level.d_axis[2] thread docks_guard_2_wait_for_death();

	//Send the most visible guy into a loop that notifies the level when the player gets too close
	level.d_axis[1] thread kibitz_radius();
}

docks_house_stealth_failed()
{
	level endon("house infiltrated");

	//Waits for level notify, then notifys house guards specifically to work with waittill_any()
	level waittill_any("stealth failed", "kibitz interrupted");

	level notify("kibitz interrupted");

	if(isalive(level.d_axis[1])) level.d_axis[1] notify("stealth failed");
	if(isalive(level.d_axis[2])) level.d_axis[2] notify("stealth failed");
}

kibitz_radius()
{
	self endon ("death");
	self endon ("stealth failed");
	
	while (distance (level.player.origin, self.origin) > 300)
	{
		wait (0.5);
	}

	trg = getent("docks_house_trigger","targetname");
	if(!(level.player istouching(trg)))
	{
		wait 0.2;
		self thread kibitz_radius();
		return;
	}

	level notify ("kibitz interrupted");

	println("player got too close");

	if (isalive (level.d_axis[1]))
	{
			level.d_axis[1].deathanim = undefined;
	}
}

docks_house_guards_kibitz_sounds()
{
	level.d_axis[1] endon ("death");
	level.d_axis[2] endon ("death");
	level endon("stealth failed");
	level endon ("kibitz interrupted");

	level thread docks_house_guards_kibitz_interrupted();

	level.speaker = 0;

	trg = getent("friendlychain_60", "targetname");
	trg waittill("trigger");

	println("kibitz go");

	//Make guard 2 susceptible to bullets
	level notify("d_axis_2 vulnerable");

	//SaySpecificDialogue(facialanim, soundAlias, importance, notifyString, waitOrNot, timeToWait)
	//////////////////////////////////////////////////////////////////////////////////////////////
	// Makes the character play the specified sound and animation.  The anim and the sound are optional - you 
	// can just define one if you don't have both.
	// Generally, importance should be in the range of 0.6-0.8 for scripted dialogue.
	// Importance is a float, from 0 to 1.  
	// 0.0 - Idle expressions
	// 0.1-0.5 - most generic dialogue
	// 0.6-0.8 - most scripted dialogue 
	// 0.9 - pain
	// 1.0 - death
	// Importance can also be one of these strings: "any", "pain" or "death", which specfies what sounds can 
	// interrupt this one.

	level.speaker = 1;
	println("guard 1 kibitz 1");
	level.d_axis[1] animscripts\face::SaySpecificDialogue (undefined, "german1_starving", 1.0, "sounddone");
	level.d_axis[1] waittill ("sounddone");

	level.speaker = 2;
	println("guard 2 kibitz 1");
	level.d_axis[2] animscripts\face::SaySpecificDialogue (undefined, "german2_bored", 1.0, "sounddone");
	level.d_axis[2] waittill ("sounddone");

	level.speaker = 1;
	println("guard 1 kibitz 2");
	level.d_axis[1] animscripts\face::SaySpecificDialogue (undefined, "german1_stomach", 1.0, "sounddone");
	level.d_axis[1] waittill ("sounddone");
	level.speaker = 0;

	wait 5;

	level notify("stealth failed");
}

docks_house_guards_kibitz_interrupted()
{
	level waittill("kibitz interrupted");

	if(isdefined(level.speaker))
	{
		println("kibitz interrupted");
		if(level.speaker == 0) return;
		if(isalive(level.d_axis[level.speaker])) level.d_axis[level.speaker] animscripts\face::SaySpecificDialogue (undefined, "german_enemy_sighted", 1.0);
		
	}
}

docks_guard_1_wait_for_death()
{
	level.d_axis[1] waittill("death");
	level.docks_house_1_dead = true;
}

docks_guard_2_wait_for_death()
{
	level.d_axis[2] waittill("death");
	level.docks_house_2_dead = true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


docks_house_guards_kibitz_idle_1()
{
	//End the guard's idle on death, combat, or pain
	level.d_axis[1] endon("death");
	level.d_axis[1] endon("pain");
	level.d_axis[1] endon("stealth failed");

	while(1)
	{
		level.d_axis[1] anim_single_solo(level.d_axis[1], "seated_idle", "dummy node",undefined,level.chair_dummy);
		level.d_axis[1] waittillmatch("single anim", "end");
	}
}

#using_animtree("dock_house_chair");
docks_house_alerted_1()
{
	level.d_axis[1] endon("death");
	level.d_axis[1] waittill_any("stealth failed", "friend died");
	level.d_axis[1].deathanim = undefined;

	wait 1;
	level.d_axis[1] anim_single_solo(level.d_axis[1],"seated_to_standing", "dummy node", undefined, level.chair_dummy);
	level.chair_dummy setflaggedanimrestart("chairanim",level.scr_anim["dock_house_chair"]["chair_fall"],1,.1,1);

	wait 1.0;
	level.d_axis[1].pacifist = 0;
	level notify("stealth failed");
}

docks_house_death_1()
{
	level.d_axis[1] endon("stealth failed");
	level.d_axis[1] endon("friend died");
	level.d_axis[1] waittill("damage");

	if(isalive(level.d_axis[2])) level.d_axis[2] notify("friend died");
	level.d_axis[1] animscripts\face::SayGenericDialogue("death");
	level.chair_dummy setflaggedanimrestart("chairanim",level.scr_anim["dock_house_chair"]["chair_fall"],1,.1,1);
	level.docks_house_1_dead = true;

	if(!isalive(level.d_axis[2])) return;
	level.d_axis[2] endon("death");

	wait 1.5;
	level notify("stealth failed");
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

docks_house_guards_kibitz_idle_2()
{
	level.d_axis[2].health =1;

	level.d_axis[2] endon("death");
	level.d_axis[2] endon("stealth failed");
	level.d_axis[2] endon("friend died");
	level.d_axis[2] endon("killed");

	while(1)
	{
		level.d_axis[2] anim_single_solo(level.d_axis[2], "laying_idle", "dummy node",undefined,level.chair_dummy);
		level.d_axis[2] waittillmatch("single anim", "end");
	}
}

docks_house_alerted_2()
{
	level.d_axis[2] endon("death");
	level.d_axis[2] endon("pain");
	level.d_axis[2] endon("killed");

	level.d_axis[2] waittill_any("stealth failed", "friend died");

	level.d_axis[2] anim_single_solo(level.d_axis[2],"laying_to_standing", "dummy node", undefined, level.chair_dummy);
	level.d_axis[2] waittillmatch("single anim", "end");
	level.d_axis[2] notify("end death");
	level.d_axis[2].deathanim = undefined;

	wait 1.5;

	level.d_axis[2].pacifist = 0;
	level.d_axis[2].maxsightdistsqrd = 2048;
	level.d_axis[2].favoriteenemy = level.player;
	level.d_axis[2] setgoalentity(level.player);

	wait 0.5;

	level notify("stealth failed");
}

docks_house_death_2()
{
	level.d_axis[2] endon("end death");
	level.d_axis[2] waittill_any("damage", "pain", "death");

	//Do accounting
	level.d_axis[2] notify("killed");

	//level.d_axis[2].allowdeath = 0;

	level.d_axis[2].deathanim = undefined;

	//If the other guard's alive, let him know his pal just died
	if(isalive(level.d_axis[1])) level.d_axis[1] notify("friend died");

	//Play death anim and loop dead frames
	level thread docks_house_death_2_loop_death();

	//Handles "breaking stealth" if 2nd guard is shot first
	if(!isalive(level.d_axis[1])) return;
	level.d_axis[1] endon("death");
	wait 1.5;
	level notify("stealth failed");
}

docks_house_death_2_loop_death()
{	
	level.d_axis[2] endon("death");

	org = level.chair_dummy GetTagOrigin ( "dummy node" ); 
	ang = level.chair_dummy GetTagAngles ( "dummy node" );

	level.d_axis[2] animscripted("deathanim", org, ang, level.scr_anim["d_axis_2"]["laying_death"]);
	level.d_axis[2] waittillmatch("deathanim", "end");

	level.docks_house_2_dead = true;

	while(1)
	{
		level.d_axis[2] animscripted("deathanimloop", org, ang, level.scr_anim["d_axis_2"]["laying_dead"]);
		level.d_axis[2] waittillmatch("deathanimloop", "end");
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



#using_animtree ("germantruck");
docks_truck_setup()
{
	//Set up the truck the player is going to use
        level.p_truck = getent("p_truck", "targetname");
	level.p_truck.treaddist = 30;
	level.p_truck maps\_truck_gmi::init();
	level.p_truck thread maps\_truck_gmi::nodeath();
	mypath = getvehiclenode("p_truck_start", "targetname");
	level.p_truck attachpath(mypath);
	level.p_truck.attachedpath = mypath;
//	level.p_truck thread maps\_vehiclechase_gmi::enemy_vehicle_paths();
	level.p_truck startpath();
	level.p_truck setspeed(0,25);
}

docks_house_music()
{
	radio_play = getent("d_radio_music", "targetname");
	radio_play playLoopSound("radio_bruckner");

	org = radio_play.origin;

	trg = getent("d_radio_damage", "targetname");
	trg waittill("trigger");

	radio_play stoploopsound();
	radio_play playsound("radio_explode");
	playfx(level._effect["radio_exp"], org);

	radio = getent("d_radio", "targetname");

	org = radio.origin;
	ang = radio.angles;

	dradio = spawn("script_model", org);
	dradio setmodel("xmodel/german_field_radio_d");
	dradio.angles = ang;

	radio delete();

	wait 0.25;

	if(isalive(level.d_axis[1])) 
	{
		level.d_axis[1] animscripts\face::SayGenericDialogue("enemysighted");
	}
	else
	if(isalive(level.d_axis[2]))
	{
		level.d_axis[2] animscripts\face::SayGenericDialogue("enemysighted");
	}
	
	wait 0.25;

	//Stealth's failed if you shoot this first
	if(isalive(level.d_axis[1]) || isalive(level.d_axis[2]))
	{
		if(level.docks_house_1_dead == true && level.docks_house_2_dead == true) return;
		
		level notify("stealth failed");
	}
}

docks_house_bypass_check()
{	
	level endon("bypass failed");

	//This checks to see if the player tried to bypass the house
	trg = getent("docks_past_house", "targetname");
	trg waittill("trigger");
	level notify("stealth failed");
}

docks_neck_stealth()
{
	level thread docks_player_got_too_close();

	level waittill("bypass failed");

	level thread docks_no_sight_while_crouched();
	level thread docks_no_sight_while_prone();
	level thread docks_sight();
}

docks_player_got_too_close()
{
//	level endon("assassination setup complete");
//
//	trg = getent("friendlychain_20", "targetname");
//
//	trg waittill("trigger");
//
//	wait (randomfloat(1)+0.5);
//
//	//Give the player his gun back so he can mess up the event
//	level.player giveweapon(level.player_weapon);
//	level.player switchtoweapon(level.player_weapon);
//
//	level notify("stealth failed");
//
//	//The enemy shouts and attacks the player
//	dialogueLine = "enemysighted";
//	level.d_axis[0] animscripts\face::SayGenericDialogue(dialogueLine);
//	level.d_axis[0].favoriteenemy = level.player;
//	level.d_axis[0].pacifist = 0;
//	level.d_axis[0] setgoalentity(level.player);
}

docks_no_sight_while_crouched()
{
	level endon("stealth failed");

	//Player will only be spotted in this trigger
	trg = getent("no_sight_while_crouched", "targetname");

	trg waittill("trigger", who);
	
		if(who!=level.player) 
		{
			return;
	}

	//if player is crouched / prone, ignore otherwise alarm
	if (who getstance() == "crouch" || who getstance() == "prone")
	{
		//println("player is stealthy in crouchprone brush");
		wait 0.1;
	}
	else
	{
		level notify("stealth failed");
		return;
	}

	level thread docks_no_sight_while_crouched();
}

docks_no_sight_while_prone()
{
	level endon("stealth failed");

	trg = getent("no_sight_while_prone", "targetname");

	trg waittill("trigger", who);

	if(who!=level.player) 
	{
		return;
	}

	//if player is prone, ignore otherwise alarm
	if (who getstance() == "prone")
	{
		if(who!=level.player) name = who.name; else name = "player";
		//println(name, " is stealthy in prone brush");
		wait 0.1;
	}
	else
	{
		level notify("stealth failed");
		return;
	}

	level thread docks_no_sight_while_prone();
}

docks_sight()
{
	level endon("stealth failed");

	trg = getent("sight", "targetname");

	trg waittill("trigger");

	level notify("stealth failed");
}

docks_bunker_mg_death_alerts_officer()
{
	//Sends the officer off on a tear once the MG guy goes down
	level.d_axis[4] waittill("death");

	if(isalive(level.d_axis[5]))
	{
		level.d_axis[5].pacifist = 0;
		level.d_axis[5].favoriteenemy = level.player;
		level.d_axis[5] setgoalentity(level.player);
	
		dialogueLine = "enemysighted";
		level.d_axis[5] thread animscripts\face::SayGenericDialogue(dialogueLine);
		wait 0.5;

		//Alert the level that stealth has been broken	
		level notify("stealth failed");
	}
}

#using_animtree("generic_human");
axis_patroller(n)
{
	//Check the entity for a script_triggername, if that script_triggername is defined it's going to be
	//an integer that indicates the number of patrol points in this guy's path
	if(isdefined(self.script_triggername))
	{
		patrolpoints = 3;
	}

	//NOTE:	The patrol path will go from the last point to point 0!  Meaning, if there are three points, the patrol will be a
	//	triangle shape
	if(!isdefined(patrolpoints))
	{
		println("^3Defaulting to 2 patrol nodes for entity ",self.targetname);
		patrolpoints = 2;
	}

	//Stop the patrol if the guard is engaged, killed, or alerted, or told to stop by script
	self endon("combat");
	self endon("death");
	self endon("stealth failed");
	self endon("stop patrol");

	//Set up the entity variables	
	self.old_walkdist = self.walkdist;
	self.walkdist = 9999;		
	self thread waittill_combat();
	self.goalradius = 4;

	//Define the walk animations
	patrolwalk[0] = %patrolwalk_bounce;
	patrolwalk[1] = %patrolwalk_tired;
	patrolwalk[2] = %patrolwalk_swagger;
	self.walk_noncombatanim = maps\_utility_gmi::random(patrolwalk);
	self.walk_noncombatanim2 = maps\_utility_gmi::random(patrolwalk);

	while(1)
	{
		for(n=0;n<patrolpoints;n++)
		{
			patrolnode = n;
			thisnode = getnode(self.targetname+"_patrol_"+patrolnode, "targetname");		//e.g. "d_axis_0_patrol_0"
			if(!isdefined(thisnode)) 
			{
				println("^1ERROR 018: NODE ", self.targetname+"_patrol_"+patrolnode," ^1 WAS NOT FOUND IN AXIS_PATROLLER");
				return;
			}
	
			self setgoalnode(thisnode);
			self waittill("goal");
	
			//Establishes a random chance that the guy will idle at the node he just reached
			rand_chance = randomfloat(1);
			if(rand_chance>0.8)
			{
				patrolstand[0] = %patrolstand_twitch;
				patrolstand[1] = %patrolstand_look;
				patrolstand[2] = %patrolstand_idle;
				self.patrolstand = maps\_utility_gmi::random(patrolstand);
	
				self thread clear_my_patrol_anim();

				self animscripted("scripted_animdone", self.origin, self.angles, self.patrolstand);
				self waittill("scripted_animdone");
			}
		}
	}
}

clear_my_patrol_anim()
{
	self waittill("pain");
	if(isdefined(self.patrolstand)) self clearanim(self.patrolstand, 0);
}

waittill_combat()
{
	//Resets the guys walkdist once combat starts, docks guards patrollers get threaded into this
	//Also the fort wall patroller
	self waittill("combat");
	self.walkdist = self.old_walkdist;
}

docks_axis_4_wait_for_death()
{
	//Sends out a notify when the MG guy dies
	self waittill("death");

	level notify("docks bunker mg guy died");
}

docks_axis_4_useturret()
{
	//In the future, thread the guy into this function and call everything through "self"
	level.d_axis[4] endon("death");
	turret = getent("d_mg34_1","targetname");
	myspot = getnode("d_mount_mg34_1", "targetname");
	level.d_axis[4] setgoalnode(myspot);
	level.d_axis[4] waittill("goal");
	level.d_axis[4] useturret(turret);
}

docks_house_friendlies_go()
{
	level thread docks_house_friendlies_doublecheck();

	//Terminate this event once stealth is failed, because everyone's going to charge the bunker
	level endon("stealth failed");

	level thread docks_get_in_the_truck();

	//Enemy guards in bunker are already threaded through axis_stealth
	//No "stealth failed" notify has been sent at this point, so they are still in pacifist
	//They have the same behavior no matter when you alert them
	//Wait until the house guards are dead
	level thread docks_house_guards_kill_check();
	level waittill("docks house guards dead");

	//Reset Ingram's goal radius to make sure he gets exactly on his node and then send everyone up to assemble in the house
	level.sas1[0].goalradius = 4;	
	level thread squad_moveup("d",3,"regroup");
	level waittill("everyone's in place");

	wait 1;

	level thread docks_house_windows_left();

	level.sas1[0] OrientMode("face angle", 45 );

	wait 0.25;

	println("Objective 1 updated");
	level notify ("update objective 1");

	//Threading a new function to stop the "stealth failed" endon
	level thread docks_storm_bunker_from_house();

	//Once everyone's in place, Ingram begins his speech about attacking the bunker

	//$$
	level.sas1[0] anim_single_solo(level.sas1[0], level.dialogue_array[3]);		//ingram_bunker
	//$$

	//The house has been infiltrated, Ingram will no longer shout "compromised"
	level notify("house infiltrated");

}

docks_house_friendlies_doublecheck()
{
	level waittill("stealth failed");

	level.sas1[0] stopanimscripted();
	level thread squad_moveup("d",1,"cover");
	squad_retarget(2);
}

docks_storm_bunker_from_house()
{
	//Turn off the FC at the house door so that the guys will exit the house when the player does, and turn on the outside one
	maps\_utility_gmi::chain_off("60");
	maps\_utility_gmi::chain_on("80");		//Outside the docks house
	//Turn off the Bypass check that alerted the guards if the player ran out in front of the house before killing the guys inside
	level notify("bypass failed");

	//Make sure squad2 leaves the house now
	level thread docks_squad2_leave_house();

	level endon("stealth failed");

	//Send squad1 to their cover spots
	//Set up the windows to be opened by the appropriate AI who reaches that node
	//Squad1 waiting at the windows for the player to fire his gun
	level thread squad_moveup("d",1,"window");
	level thread docks_house_windows_right();
	level thread docks_squad1_wait_to_suppress();

	//Don't do anything else until the MG guy is eliminated
	level waittill("docks bunker mg guy died");

	//If the patroller's still alive, advance to position 1
	if(isalive(level.d_axis[3]))
	{
		squad_moveup("d",1,"advance");
		level.d_axis[3] waittill("death");
	}
	
	//The MG and patroller are both dead, move squad1 up farther along the docks neck
	level thread squad_moveup("d",1,"cover");

	//Once the MG and patrollers are dead, your squad stops adopting stance
	level notify("stop adopt stance");
}

docks_squad2_wait_to_adopt_stance()
{
	println("^5SQUAD_SQUAD2_WAIT_TO_ADOPT_STANCE");

	//not being used
	trg = getent("friendlychain_90", "targetname");
	
	trg waittill("trigger");

	println("^5Squad2 adopting player stance now!");
	for(n=0;n<level.sas2.size;n++)
	{
		level.sas2[n] thread squad_adopt_player_stance();
	}
}

docks_squad2_leave_house()
{
	//Get the guys out the door
	level thread squad_moveup("d",2,"leave_house");
	level waittill("everyone's in place");

	//Once they are out, put them back on the friendly chain		
	level thread squad_retarget(2);
}

docks_squad1_wait_to_suppress()
{
	level endon("stealth failed");

	//Set up each of the required guys to supress once the player fires
	for(n=0;n<level.sas1.size;n++)
	{	
		if(isalive(level.sas1[n])) level.sas1[n] thread docks_squad1_suppress_handler();
	}

	while(1)
	{
		if(level.player attackButtonPressed())
		{
			wait 0.5;
			level notify("suppress");
			dl = "doingsuppression"; 
			level.sas1[0] animscripts\face::SayGenericDialogue(dl);

			for(n=0;n<level.sas2.size;n++)
			{
				if(isalive(level.sas2[n])) level.sas2[n].pacifist = 0;
			}

			level notify("stop adopt stance");
			break;
		}
		wait 0.05;
	}

	wait 6;

	//Allow everyone to stand up and run for it after at most 6 seconds of supressing fire
	for(n=0;n<level.sas1.size;n++)
	{
		if(isalive(level.sas1[n])) level.sas1[n] allowedStances("stand","crouch","prone");
	}

	squad_moveup("d",1,"advance");
}

docks_squad1_suppress_handler()
{
	self endon("death");

	level endon("bunker clear");

	level.d_axis[4] endon("death");
	
	level waittill("suppress");

	//get the target
	targ = getent("d_mg34_1", "targetname");

	target_position = targ.origin;

	level notify("stealth failed");

	curtime = gettime();
	nexttime = gettime() + 1000;
	burstfire = false;
	while(isalive(level.d_axis[4]))
	{
		if (gettime() > nexttime)
		{
			burstfire = !burstfire;
			nexttime = gettime() + (1000);
		}
		else
		{
			if (burstfire == true)
			{
				self animscripts\combat_gmi::FireAtTarget(target_position, 6, undefined, undefined, spawned, true);
			}
		}
		//FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop)
		wait 0.05;
	}
}

docks_house_windows_left()
{
	wait 8;

	//Send the appropriate npc to the window, and once he gets there open it
	w1 = getent("d_window_4_l", "targetname");
	w2 = getent("d_window_4_r", "targetname");

	w1 rotateto( (0,90,0), 1, 0, 0);
	w2 rotateto( (0,-90,0), 1, 0, 0);
}

docks_house_windows_right()
{
	level endon("stealth failed");
	
	if(!isalive(level.sas1[2])) return;

	//Send the appropriate npc to the window, and once he gets there open it
	myspot = getnode("d_sas1_2_window", "targetname");
	mymodpos = myspot.origin + (0,-26,0);
	level.sas1[2] setgoalpos(mymodpos);

	level.sas1[2].goalradius = 1;

	level.sas1[2] waittill("goal");

	wait 0.25;
	level.sas1[2] OrientMode("face angle", 90 );
	wait 0.25;
	level.sas1[2] thread anim_single_solo(level.sas1[2], "window");
	wait 1.5;
	w3 = getent("d_window_3_l", "targetname");
	w3 rotateto( (0,90,0), 1, 0, 0);
	level.sas1[2] setgoalnode(myspot);
}

docks_bunker_wait_to_be_cleared()
{
	loop = true;
	while(loop)
	{
		if(	isalive(level.d_axis[3]) ||
			isalive(level.d_axis[4]) ||
			isalive(level.d_axis[5]) || 
			isalive(level.d_axis[6]) 
		  )
		{
			wait 0.05;	
		}
		else
		{
			level notify("bunker cleared");

			for(n=0;n<level.sas1.size;n++)
			{
				if(isalive(level.sas1[n])) level.sas1[n].pacifist = 1;
			}

			for(n=0;n<level.sas2.size;n++)
			{
				if(isalive(level.sas2[n])) level.sas2[n].pacifist = 1;
			}

			loop = false;
		}
	}
}

docks_get_in_the_truck()
{
	if(level.docks_done == true) return;

	level.docks_done = true;


	loop = true;
	while(loop)
	{
		if(	isalive(level.d_axis[3]) ||
			isalive(level.d_axis[4]) ||
			isalive(level.d_axis[5]) || 
			isalive(level.d_axis[6]) 
		  )
		{
			wait 0.05;	
		}
		else 
		{	
			loop = false;
		}
	}

	//Get everyone into place to board the truck
	level thread squad_moveup("d",1,"truck");

	level waittill("everyone's in place");

	//$$
	//Ingram tells everyone to get into the truck
	level.sas1[0] thread anim_single_solo(level.sas1[0], level.dialogue_array[14]);		//ingram_lorry
	//$$

	//UPDATE OBJECTIVE FROM "STORM THE BUNKER" TO "GET IN THE TRUCK"
	level notify("update objective 1");

	level thread player_truck_start();
}



//=====================================================================================================================
// PLAYER TRUCKRIDE
//=====================================================================================================================
#using_animtree("germantruck");
truckRide_Anim(animation)
{
	self UseAnimTree(#animtree);

	//Start animation
	self setflaggedanimknob("animdone",animation);
	self waittillmatch ("animdone","end");
}

truckRide_driver_loop(truck)
{
	level.p_truck endon("unload");

	self endon("exited truck");

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

truck_debug()
{
	while(1)
	{
		for(n=1;n<9;n++)
		{
			tagorg = level.p_truck gettagorigin("tag_guy0"+n);
			print3d (tagorg, "tag_guy0"+n, (1,0,0), 1, 0.75);	// origin, text, RGB, alpha, scale
			wait 0.05;
		}
	}
}

player_truck_start()
{
//	level thread truck_debug();

	trg = getent("use_truck", "targetname");

	trg setcursorhint("HINT_ACTIVATE");

	trg setHintString (&"DAM_GET_IN_TRUCK");

	//This thread spawns all of the lighthouse dudes and gets them ready for the player
	level thread lighthouse_setup();

	//Here's where we allow the player to get on the truck
	level thread docks_truck_player_get_in();

	//
	println("^5docks_truck_player_get_in");

	level.p_truck disconnectpaths();
	level.p_truck.tagcycle = 8;
	mypath = getvehiclenode("p_truck_start", "targetname");
	level.p_truck attachpath(mypath);

	//
	println("^5truck init");

	level.p_truck thread truckRide_Anim(level.scr_anim["germantruck"]["closedoor_startpose"]);

	org = level.p_truck.origin+(-10,-10,0);
	level thread maps\_utility::playSoundinSpace ("truck_door_open", org);

	//
	println("^5truck door");

	allies = getaiarray ("allies");
	level.allySize = allies.size;

	//Build a new array that has the guys in the order they board the truck
	guys = [];
	guys[guys.size] = level.sas1[1];		//driv - luyties

	guys[guys.size] = level.sas2[1];		//pos5 - denny
	guys[guys.size] = level.sas2[0];		//pos6 - moditch
	guys[guys.size] = level.sas1[2];		//pos7 - hoover
	guys[guys.size] = level.sas1[0];		//pos8 - ingram

	//Don't forget about the driver
	guys[0] thread truckRide_driver_JumpIn(level.p_truck);
	for(n=1;n<guys.size;n++)
	{
		guys[n] notify("stop flinching");

		guys[n] thread truckRide_allies_JumpIn();

		level waittill("guy's at back of truck");
	}	
	
	//Wait untill everyone's in
	while(allies.size - 1 + level.p_truck.tagcycle != 8) 
	{ 
		wait 0.5; 
	}

	//Wait until the player is in the truck
	while(level.player_in_truck == false)
	{
		wait 0.05;
	}
	
	wait 2 + randomfloat(1);

	//UPDATE OBJECTIVE FROM "GET IN THE TRUCK" TO "ELIMINATE ANY ENEMY RESISTANCE AT THE LIGHTHOUSE"
	level notify("update objective 1");

	//level.p_truck startpath();
	level.p_truck resumespeed(5);

	//$$
	level.sas1[0] anim_single_solo(level.sas1[0], level.dialogue_array[0]);		//ingram_brief1
	//$$

	wait 0.5;

	level.sas1[0] anim_single_solo(level.sas1[0], level.dialogue_array[1]);			//ingram_brief2

	trg = getent("truck_out_of_gas", "targetname");

	trg waittill("trigger");

	level.p_truck playsound("truck_out_of_gas");

	wait 0.25;

	level.p_truck StopEngineSound();		//yay

	wait 1.5;

	level.sas1[2] anim_single_solo(level.sas1[1], level.dialogue_array[32]);		//luyties_lorry_stalled

	level.sas1[0] anim_single_solo(level.sas1[0], level.dialogue_array[33]);		//ingram_sticky_wicket

	level.player setTakeDamage(0);

	level.player unlink();

	for(n=0;n<level.sas1.size;n++)
	{
		level.sas1[n] setTakeDamage(0);
		level.sas1[n].playpainanim = 1;
	}
	for(n=0;n<level.sas2.size;n++)
	{
		level.sas2[n] setTakeDamage(0);
	}

	level.p_truck waittill("reached_end_node");
	level.p_truck notify("unload");

	level.sas1[1] notify("exited truck");
	level.sas1[1].driving = false;
	level.sas1[1] unlink();

	org = level.p_truck.origin+(-10,-10,0);
	level thread maps\_utility::playSoundinSpace ("truck_door_open", org);

	level.player allowLeanLeft(true);
	level.player allowLeanRight(true);
	level.player allowCrouch(true);
	level.player allowProne(true);
	level.player allowStand(true);

	level thread lighthouse();
	level thread lighthouse_top();
	level thread lighthouse_eliminate_resistance();

	lh_axis_spawners = getentarray("lh_axis", "groupname");
	for(n=0;n<lh_axis_spawners.size;n++)
	{
		//This condition excepts the nade thrower, who needs to spawn at the start of the map
		if(n!=5)
		{
			this_spawner = getent("lh_axis_"+n,"targetname");
				if(!isdefined(this_spawner)) println("^1SPAWNER IS NOT DEFINED");
	
			level.lh_axis[n] = this_spawner stalingradspawn();
				if(!issentient(level.lh_axis[n])) println("^1ENTITY WAS NOT SPAWNED");
	
			level.lh_axis[n] waittill("finished spawning");

			level.lh_axis[n].team = "axis";
			level.lh_axis[n].pacifist = false;
			if(n==6 || n==7) 
			{
				level.lh_axis[n].pacifist = true;
				level.lh_axis[n] allowedStances("stand");
			}
		}
	}


	level.lh_axis[3] thread axis_stealth();
	level.lh_axis[4] thread axis_stealth();
	level.lh_axis[8] thread axis_stealth();

	//Ensure that the axis aren't ignoring them anymore
	level.sas1[0].ignoreme = false;
	level.sas1[1].ignoreme = false;
	level.sas2[0].ignoreme = false;
	level.sas2[1].ignoreme = false;

	squad_moveup("lh",3,"cover");

	//Autosave Point #2
	maps\_utility_gmi::autosave(2);
	println("autosave 2 complete");

	wait 1;

	musicplay("sicily1_stealth");	

	wait 6;

	//$$
	level.sas1[0] anim_single_solo(level.sas1[0], level.dialogue_array[13]);		//ingram_lighthouse
	//$$

	wait 1;

	level.player setTakeDamage(1);

	for(n=0;n<level.sas1.size;n++)
	{
		level.sas1[n] allowedStances("stand","crouch","prone");
		level.sas1[n] setTakeDamage(1);
	}
	for(n=0;n<level.sas2.size;n++)
	{
		level.sas2[n] allowedStances("stand","crouch","prone");
		level.sas2[n] setTakeDamage(1);
	}

	level.lh_axis[3].pacifist = 0;
	level.lh_axis[4].pacifist = 0;
	level.lh_axis[8].pacifist = 0;

	level waittill("everyone's in place");

	if(isalive(level.lh_axis[3])) level.lh_axis[3] thread lighthouse_run_for_help();
	if(isalive(level.lh_axis[8])) level.lh_axis[8] thread lighthouse_run_for_help();

	//Take them all out of pacifist, so that they can shoot at the Germans
	for(n=0;n<level.sas1.size;n++)
	{
		level.sas1[n].pacifist = 0;
	}

	for(n=0;n<level.sas2.size;n++)
	{
		level.sas2[n].pacifist = 0;
	}

	squad_retarget(2);

	level.sas1[0] animscripts\face::SayGenericDialogue("coverme");

	squad_moveup("lh",1,"assault");
}

docks_truck_player_get_in()
{	
	trg = getent("use_truck", "targetname");
	trg thread maps\_utility_gmi::triggerOn();
	trg waittill("trigger");

	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowCrouch(false);
	level.player allowProne(false);
	wait 0.05;

	tagorg = (getent("marker_objective_1_2", "targetname")) getorigin();

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
	tagorg = level.p_truck getTagOrigin("tag_player");
	tagorg = (level.player.origin[0] + 1.0, level.player.origin[1], ((tagorg[2] - level.player.origin[2]) * .5) + level.player.origin[2]);
	moveorg moveTo(tagorg, .5, .1, .1);
	moveorg waittill ("movedone");

	tagorg = level.p_truck getTagOrigin("tag_player");
	tagorg = (level.player.origin[0] - 1.0, level.player.origin[1], tagorg[2]);
	moveorg moveTo(tagorg, .5, .1, .1);
	moveorg waittill ("movedone");

	//move the entity to the back of the truck
	tagorg = level.p_truck getTagOrigin("tag_player");
	moveorg moveTo(tagorg, 1, 0, 0);
	moveorg waittill ("movedone");
	
	moveorg delete();
	trg delete();

	level.player playerlinkto (level.p_truck, "tag_player", ( 0.6, .6, 0.9 ));	//link the player to the truck

	level.player allowLeanLeft(true);
	level.player allowLeanRight(true);
	level.player allowCrouch(true);
	level.player allowProne(false);
	level.player allowStand(false);
	
	wait 1;

	level.player_in_truck = true;

	level notify("player in truck");
}

truckRide_allies_JumpIn()
{
	self.oldmaxSightDistSqrd = self.maxSightDistSqrd;
	self.maxSightDistSqrd = 0;
	        
	self endon ("death");

	self thread truck_lines();
	
	self.oldwalkdist = self.walkdist;
	self.oldgoalradius = self.goalradius;
	self.walkdist = 0;
	self.goalradius = 4;

	//HACK to force the guy to the tag_climbnode
	self.climbtag = "tag_climbnode";
	
	//make the guy run to the node at the back of the truck
	startorg = getstartOrigin (level.p_truck getTagOrigin(self.climbtag), level.p_truck getTagAngles(self.climbtag), level.scr_anim[self.animname]["jumpin"]);

//	println("^5::",self.animname,", ",self.climbtag,", ",level.scr_anim[self.animname]["jumpin"]);

	self setgoalpos (startorg);
	self waittill ("goal");

	level notify("guy's at back of truck");

	//when the guy is at the node make him play the animation and get into the truck
	self animscripted("climbin done", level.p_truck getTagOrigin(self.climbtag), level.p_truck getTagAngles(self.climbtag), level.scr_anim[self.animname]["jumpin"]);
	self waittillmatch ("climbin done", "end");
	
	//THIS IS IW'S METHOD I've commented out
	//get the next passenger tag and make the guy go to it
	tag = ("tag_guy0" + level.p_truck.tagcycle);
	//tag = self.idletag;

	//This sets the guys position exception for _truck_gmi
//	self.truck_pos = level.p_truck.tagcycle;
	self.truck_pos = self.idletag;

//	goalpos = (level.p_truck getTagOrigin(tag));
	goalpos = ( level.p_truck getTagOrigin(self.idletag) );

	level.p_truck.tagcycle--;

	dummy = spawn ("script_origin",self.origin);
	self linkto (dummy);
	dummy moveto (goalpos, 1, 0.3, 0.3);
	dummy waittill ("movedone");
	self unlink();
	dummy delete();
	self linkto (level.p_truck, tag, (0, 0, 0), (1, 1, 1));
	self setgoalpos (goalpos);

	self.maxSightDistSqrd = self.oldmaxSightDistSqrd;

	level.p_truck.norandom = 1;

	self thread truckride_handle_guys();

	level.p_truck endon("unload");

	while(1)
	{
		//self animscripted("animloopdone", truck getTagOrigin("tag_driver"), truck getTagAngles("tag_driver"), level.scr_anim["truck_driver"]["jumpin_slow"]);
		self animscripted("animloopdone", level.p_truck getTagOrigin(self.idletag), level.p_truck getTagAngles(self.idletag), level.scr_anim[self.animname]["truckidle"]);
		self waittillmatch("animloopdone", "end");
	}
}

truck_lines()
{
//	self endon("death");
//	while(1)
//	{
//		pos1 = level.p_truck getTagOrigin(self.climbtag);
//		line(pos1, self.origin, (1,1,1));
//		wait 0.06;
//	}
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
	
	//make the guy run to the driver getin node
	startorg = getstartOrigin (truck getTagOrigin("tag_driver"), truck getTagAngles("tag_driver"), level.scr_anim["truck_driver"]["jumpin_slow"]);
	self setgoalpos (startorg);
	self waittill ("goal");
	
	//when the guy is at the node make him play the animation and get into the truck
	truck thread truckRide_Anim(level.scr_anim["germantruck"]["closedoor_slow"]);
	self thread truckride_driver_anim(truck);

	wait 2.2;

	//door sound trickery
	org = level.p_truck.origin+(-20,-20,10);
	level thread maps\_utility::playSoundinSpace ("car_door_close", org);

	//get the driver tag and make the guy go to it
	tag = ("tag_driver");
	self linkto (truck, tag, (0, 0, 0), (1, 1, 1));
	self.maxSightDistSqrd = self.oldmaxSightDistSqrd;
	
	//set his driving animation
	self.driving = true;
	self thread truckRide_driver_loop(truck);
}

truckride_driver_anim(truck)
{
	self animscripted("animloopdone", truck getTagOrigin("tag_driver"), truck getTagAngles("tag_driver"), level.scr_anim["truck_driver"]["jumpin_slow"]);
//	self waittillmatch ("animloopdone", "end");
}

truckride_handle_guys(guys)
{
	level.p_truck waittill("unload");

	self unlink();

	org = level.p_truck gettagOrigin (self.exittag);
	ang = level.p_truck gettagAngles (self.exittag);

	println("org = ",org);
	println("ang = ",ang);
	println("vs truck ang = ", level.p_truck.angles);

	ang= ang + (0,180,0);

	//self animscripted("animloopdone", truck getTagOrigin("tag_driver"), truck getTagAngles("tag_driver"), level.scr_anim["truck_driver"]["jumpin_slow"]);
	self animscripted("jumpout", org, ang, level.scr_anim[self.animname]["jumpout"]);
	self waittillmatch ("jumpout","end");

	self allowedstances("stand","crouch","prone");
}


lighthouse_eliminate_resistance()
{
	trg = getent("lighthouse_eliminate_resistance", "targetname");

	trg waittill("trigger");

	//UPDATE OBJECTIVE FROM "ELIMINATE ENEMY RESISTANCE" 
	level notify("update objective 1");

	trg = getent("friendlychain_150", "targetname");

	trg waittill("trigger");

	//COMPLETE OBJECTIVE 1
	level notify("objective 1 complete");	
}
//=====================================================================================================================
// END PLAYER TRUCKRIDE
//=====================================================================================================================



//=====================================================================================================================
// LIGHTHOUSE
//=====================================================================================================================
lighthouse_setup()
{
	//Sets up road bunker's nosight brush that can be removed
//	level thread lighthouse_road_bunker_nosight();

	//Sets up ambush from cliffside doors
	level thread lighthouse_ladder();

	//Sets up guy who's gonna attack the player from the wooden planked floor above the stairs
	level thread lighthouse_stairs();

	//Friendly Chain management for lighthouse
	maps\_utility_gmi::chain_on("120");
	maps\_utility_gmi::chain_on("130");
	maps\_utility_gmi::chain_on("140");
	maps\_utility_gmi::chain_on("150");
	//160-200 already off

	//Set up toofar triggers
	level thread lighthouse_too_far();

	//Trying to get the nader dude to shout before he throws...
	//level thread lighthouse_nader_warning();
}

lighthouse_stairs()
{
	trg = getent("lighthouse_stairs", "targetname");
	trg waittill("trigger");

	myspot = getnode("lighthouse_stairs_cover", "targetname");

	if(!isalive(level.lh_axis[2])) return;

	level.lh_axis[2].goalradius = 4;
	level.lh_axis[2] setgoalnode(myspot);

	//Shout "Der Fiend!" or whatever
	dialogueLine = "enemysighted";
	level.lh_axis[2] thread animscripts\face::SayGenericDialogue(dialogueLine);
}

lighthouse_too_far()
{
	level thread lighthouse_too_far_2();

	level endon("objective 6 complete");

	trg = getent("too_far_3_b", "targetname");

	trg waittill("trigger");

	iprintln(&"GMI_SICILY1_DONT_GO_TOO_FAR");

	trg = getent("too_far_4_b", "targetname");

	trg waittill("trigger");

	iprintln(&"GMI_SICILY1_YOU_WENT_TOO_FAR");

	wait 1;

	//This is a temporary deadquote, need a new one for "you disobeyed orders"
	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
	missionFailed();
}

lighthouse_too_far_2()
{
	level endon("objective 2 complete");

	trg = getent("too_far_3", "targetname");

	trg waittill("trigger");

	iprintln(&"GMI_SICILY1_DONT_GO_TOO_FAR");

	trg = getent("too_far_4", "targetname");

	trg waittill("trigger");

	iprintln(&"GMI_SICILY1_YOU_WENT_TOO_FAR");

	wait 1;

	//This is a temporary deadquote, need a new one for "you disobeyed orders"
	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
	missionFailed();
}

road_bunker_setup()
{
	for(n=2;n<6;n++)
	{
		//Define their turrets
		level.bunkermg[n] = getent("mg"+n,"targetname");
		println(level.bunkermg[n].targetname);
	}

	//Get array of road bunker guys, spawn them, put them in god mode
	//Put them in ignoreme so hopefully the squad will not shoot them
	//Make them pacifist, then thread a function that waits for the trigger to be hit
	guys = getentarray("road_bunker_guy", "groupname");
	for(n=0;n<4;n++)
	{
		//Define the roadbunker guys
		level.roadbunker[n] = getent("mgdude" + n,"targetname");
		level.roadbunker[n].n = n;
		level.roadbunker[n] thread maps\_utility_gmi::magic_bullet_shield();
		level.roadbunker[n].pacifist = true;
		level.roadbunker[n].ignoreme = 1;
		level.roadbunker[n].accuracy = 1;
		level.roadbunker[n].health = 1000000;
		level.roadbunker[n].oldmaxsightdistsqrd = level.roadbunker[n].maxsightdistsqrd;
		level.roadbunker[n].maxsightdistsqrd = 0;
		level.roadbunker[n] thread stay_on_my_turret();
	}
	level thread road_bunker_kill_player();
//	level thread road_bunker_nosight();
}

stay_on_my_turret()
{
	while(1)
	{
		wait 0.05;
		self useturret( level.bunkermg[self.n + 2] );
	}
}

road_bunker_kill_player()
{
	trg = getent("road_bunker_approach", "targetname");

	trg waittill("trigger");

	for(n=0;n<level.roadbunker.size;n++)
	{
		level.roadbunker[n].pacifist = 0;
		level.roadbunker[n].ignoreme = 0;
		level.roadbunker[n].favoriteenemy = level.player;
		level.roadbunker[n].maxsightdistsqrd = 1210000;
		wait 0.05;
	}
}

road_bunker_nosight()
{
	//Caused more problems than it's worth

/*
	//Anyone shoots this brush, it's gone.  It's meant to block LOS to the bunker from the lighthouse.
	//It also alerts the guards here...Don't know that this is a good idea, but let's try it.
	trg = getent("road_bunker_nosight_damage", "targetname");
	trg waittill("trigger");
	tgt = getent(trg.target, "targetname");

	for(n=0;n<level.roadbunker.size;n++)
	{
		level.roadbunker[n].pacifist = 0;
		level.roadbunker[n].ignoreme = 0;
		level.roadbunker[n].maxsightdistsqrd = level.roadbunker[n].oldmaxsightdistsqrd;
		wait 0.05;
	}

	tgt delete();
	trg delete();
*/
}

road_bunker_guards_reached_help()
{
	//Caused more problems than it's worth

/*
	//Likewise, if these guards reach the bunker, let's alert the bunker.
	//I'm contemplating calling the tank also.
	trg = getent("road_bunker_nosight_damage", "targetname");
	tgt = getent(trg.target, "targetname");

	for(n=0;n<level.roadbunker.size;n++)
	{
		level.roadbunker[n].pacifist = 0;
		level.roadbunker[n].ignoreme = 0;
		level.roadbunker[n].maxsightdistsqrd = level.roadbunker[n].oldmaxsightdistsqrd;
		wait 0.05;
	}

	tgt delete();
	trg delete();
*/
}

lighthouse_run_for_help()
{
	self endon("death");
	self waittill("combat");

	//Randomly some of the dudes will just flat out run for it
	xrand = randomint(2)+1;
	if(xrand>1) 
	{	
		println("^3run for it, fritz!");
		self.bravery = 500000;
		self setgoalnode(getnode("lh_run_for_help", "targetname") );
		self waittill("goal");

		//ROAD BUNKER ALERTED
		level thread road_bunker_guards_reached_help();
	}
}

lighthouse_top()
{
	wait 25;
	
	//Wake up those dudes on top of the lighthouse
	//and run em into balcony fall spots
	myspot = getnode("lh_axis_6_balcony", "targetname");

	if(isalive(level.lh_axis[6])) level.lh_axis[6] setgoalnode(myspot);

	myspot = getnode("lh_axis_7_balcony", "targetname");
	if(isalive(level.lh_axis[7])) level.lh_axis[7] setgoalnode(myspot);

	wait 4;

	if(isalive(level.lh_axis[6]))
	{	
		level.lh_axis[6].pacifist = 0;
		level.lh_axis[6].team = "axis";
	}

	if(isalive(level.lh_axis[7]))
	{	
		level.lh_axis[7].pacifist = 0;
		level.lh_axis[7].team = "axis";
	}
}

lighthouse()
{
	//I have a habit of starting all the doors off closed and opening them...this is pretty unnecessary
	level thread lighthouse_ground_floor();

	level thread lighthouse_explosives();

	lighthouse_door = getent("lighthouse_door", "targetname");
	
	lighthouse_door rotateto( (0,-90,0), 1, 0, 0 );

	lighthouse_door connectpaths();
}

lighthouse_ground_floor()
{
	level waittill("open lighthouse door");

	lighthouse_door = getent("lighthouse_door", "targetname");
	
	lighthouse_door rotateto( (0,-90,0), 1, 0, 0 );
	
	lighthouse_door connectpaths();

//	level.grenade_spawner maps\_utility_gmi::triggeron();

	level thread lighthouse_nader_run_off();

	lighthouse_ground_floor_blocker = getent("lighthouse_ground_floor_blocker", "targetname");

	level.lh_axis[0] waittill("death");

	for(n=1;n<4; n++)
	{
		//charge the player
		if(isalive(level.lh_axis[n])) level.lh_axis[n] setgoalentity(level.player);
	}

	lighthouse_ground_floor_blocker connectpaths();

	lighthouse_ground_floor_blocker delete();
}

lighthouse_nader_warning()
{
	level.nader = getent("lh_axis_5", "targetname");		//Hi Ralph

	level.nader waittill("enemyvisible");

	level.nader animscripts\face::SayGenericDialogue("enemysighted");
}

lighthouse_explosives()
{
	//Set the hintstring on the bombs so the nubs understand what to do
	bombs = getentarray("lh_bomb", "groupname");
	for(n=0;n<bombs.size;n++)
	{
		bombs[n] setHintString (&"SCRIPT_HINTSTR_PLANTEXPLOSIVES");
	}

	level thread get_bomb_array("lh_bomb");

	level waittill("objective 2 complete");

	//Disable the front door FC and reenable the "regroup outside" FCs
	maps\_utility_gmi::chain_off("140");
	maps\_utility_gmi::chain_off("150");
	maps\_utility_gmi::chain_on("160");
	maps\_utility_gmi::chain_on("170");
	maps\_utility_gmi::chain_on("180");
	maps\_utility_gmi::chain_on("190");
	maps\_utility_gmi::chain_on("200");
	//-------------------------------\\

	//Move squad2 outside
	squad_moveup("lh",2,"outside");

	trg = getent("friendlychain_160", "targetname");
	trg waittill("trigger");

	level thread lighthouse_player_ran_past();

	squad_retarget(2);

	//Wait until player hits killspawner for cliff door guys
	trg = getent("killspawner_100", "targetname");
	trg waittill("trigger");

	//Once all the guys are dead, wait a second then say your line
	loop = true;
	while(loop)
	{
		loop = false;
		group = getentarray("lh_axis_cliffdoor", "groupname");
		for(n=0;n<group.size;n++)
		{
			if((isalive(group[n]))) loop = true;
		}
		if(level.condition == true) loop = false;
		wait 0.05;
	}
	println("^5ALL CLIFFSIDE DOOR GUYS ARE DEAD, OR PLAYER HAS ADVANCED");

	//Check player's distance from ingram; if he's too far, wait until he gets close enough
	level.eval = true;
	while(level.eval)
	{
		if(distance(level.player.origin, level.sas1[0].origin) < 512) level.eval = false;
		if(level.condition == true) level.eval = false;
		wait 0.05;
	}

	//$$
	level thread anim_single_solo(level.sas1[0], level.dialogue_array[24]);		//ingram_uphill
	//$$

	//UPDATE OBJECTIVE FROM "REGROUP OUTSIDE" TO "HEAD UP THE PATH"
	level notify("update objective 3");

	wait 0.75;

	squad_moveup("lh",1,"cliffside");

	level thread cliffside();		//Continue the level flow

	//Autosave Point #3
	maps\_utility_gmi::autosave(3);
	println("autosave 3 complete");
}

lighthouse_player_ran_past()
{
	level.condition = false;

	trg = getent("friendlychain_190", "targetname");
	trg waittill("trigger");

	level.condition = true;
}

lighthouse_nader_run_off()
{
	//Handles our loverly grenade tosser
	nader = getent("lh_axis_5", "targetname");		//Hi Ralph

	nader endon("death");

	runoff = getent("nader_run_off", "targetname");

	runoff waittill("trigger");

	nader animscripts\face::SayGenericDialogue("grenadeattack");

	hideme = getnode("nader_hide", "targetname");

	chuckem = getnode("nader_throw", "targetname");

	nader setgoalnode(hideme);

	wait randomint(1) + 2;

	nader setgoalnode(chuckem);

	level thread lighthouse_nader_run_off();
}

lighthouse_ladder()
{
	//AMBUSH OUTSIDE LIGHTHOUSE
	trg = getent("lh_ambush", "groupname");

	trg waittill("trigger");

	println("PLAYER HIT AMBUSH TRIGGER");

	level thread squad_moveup("lh",1,"landbridge");

	println("squad1 moving up!");	

	if(isalive(level.lh_axis[6]))
	{
		level.lh_axis[6].pacifist = 0;
		level.lh_axis[6] setgoalentity(level.player);
		level.lh_axis[6].favoriteenemy = level.player;
	}
	if(isalive(level.lh_axis[7]))
	{
		level.lh_axis[7].pacifist = 0;
		level.lh_axis[7] setgoalentity(level.player);
		level.lh_axis[7].favoriteenemy = level.player;
	}
	
 	lcdoor = getent("cliff_door_l", "targetname");
	rcdoor = getent("cliff_door_r", "targetname");

	lcdoor rotateto( (0,-85,0), 0.75, 0.4, 0.2);
	rcdoor rotateto( (0,85,0), 0.75, 0.4, 0.2);

	lcdoor connectpaths();
	rcdoor connectpaths();

	//Replace killspawner so dudes don't keep spawning
	trg = getent("killspawner_100", "targetname");
	trg maps\_utility_gmi::triggerOn();
}

lighthouse_reinforcements1()
{
	level thread motorpool_door_open();

	for(n=0;n<3;n++)
	{
		level.r_truck[n] = spawnvehicle("xmodel/vehicle_german_truck", "r_truck_"+n, "germanfordtruck", (0,0,0), (0,0,0) );

		mypath = getvehiclenode("r_truck_start", "targetname");

		level.r_truck[n].script_vehiclegroup = n;

		level.r_truck[n] maps\_truck_gmi::init();

		level.r_truck[n] maps\_truck_gmi::attach_guys();

		//If this works, yippeee...
		axis_reinforcements = getentarray("reinforcements", "groupname");
	
		for(i=0;i<axis_reinforcements.size;i++)
		{
			if(issentient(axis_reinforcements[i]))
			{
				axis_reinforcements[i] allowedstances("crouch");
			}
		}

		level.r_truck[n] attachpath(mypath);

		level.r_truck[n] startpath();

		level.r_truck[n] thread r_trucks(n);

		wait 6;
	}
	
	wait 2;

	level thread motorpool_door_close();

	level thread lighthouse_reinforcements2();
}

r_trucks(n)
{
	playfxontag( level._effect["truck_lights"], self, "tag_origin");

	axis_reinforcements = getentarray("reinforcements", "groupname");

	println("truck ",n," has started");

	self waittill("reached_end_node");

	if(n==0)
	{
		mynewpath = getvehiclenode("r_truck_0_park", "targetname");
		level.r_truck[n] attachpath(mynewpath);
		level.r_truck[n] startpath();

		level.r_truck[n] waittill("reached_end_node");
		level.r_truck[n] notify("unload");
	}
	else 
	if (n==1)
	{
		mynewpath = getvehiclenode("r_truck_1_park", "targetname");
		level.r_truck[n] attachpath(mynewpath);
		level.r_truck[n] startpath();

		level.r_truck[n] waittill("reached_end_node");
		level.r_truck[n] notify("unload");
	}
	else
	{
		mynewpath = getvehiclenode("r_truck_2_park", "targetname");
		level.r_truck[n] attachpath(mynewpath);
		level.r_truck[n] startpath();

		level.r_truck[n] waittill("reached_end_node");
		level.r_truck[n] notify("unload");
		level.r_trucks_unloaded = true;
	}

	for(i=0;i<axis_reinforcements.size;i++)
	{
		if(issentient(axis_reinforcements[i]))
		{
			axis_reinforcements[i] allowedstances("stand", "crouch", "prone");
		}
	}
}

courtyard_reinforcements1()
{
	level thread courtyard_reinforcements2();

	n=0;

	level.cy_truck[n] = spawnvehicle("xmodel/vehicle_german_truck", "cy_truck_"+n, "germanfordtruck", (0,0,0), (0,0,0) );
	mypath = getvehiclenode("cy_truck_start", "targetname");

	level.cy_truck[n].script_vehiclegroup = 8;		//these guys are group 8 for whatever reason

	level.cy_truck[n] maps\_truck_gmi::init();
	level.cy_truck[n] maps\_truck_gmi::attach_guys();

	level.cy_truck[n] attachpath(mypath);
	level.cy_truck[n] maps\_vehiclechase_gmi::enemy_vehicle_paths();
	level.cy_truck[n] startpath();

	level.cy_truck[n] thread cy_trucks(n);
}

cy_trucks(n)
{
	level thread cy_extras();

	//motorpool door charge goes OFF!
	axis_reinforcements = getentarray("reinforcements", "groupname");

	if(!isdefined(axis_reinforcements)) return;

	wait 4.5;
	level.cy_truck[n] playsound("dirt_skid");
	level.cy_truck[n] waittill("reached_end_node");
	level.cy_truck[n] notify("unload");

	for(i=0;i<axis_reinforcements.size;i++)
	{
		if(issentient(axis_reinforcements[i]))
		{
			if( isalive(axis_reinforcements[i]) )
			{
				axis_reinforcements[i] allowedstances("stand", "crouch", "prone");
				axis_reinforcements[i].pacifist = false;
				axis_reinforcements[i].goalradius = 256;
				axis_reinforcements[i] setgoalentity(level.player);
				axis_reinforcements[i].favoriteenemy = level.player;
			}
		}
		wait 0.05;
	}
}

cy_extras()
{
	wait 10;

	cy_extra = getentarray("mp_extra_guys", "groupname");

	for(n=0;n<cy_extra.size;n++)
	{
		guy[n] = cy_extra[n] dospawn();
		guy[n] setgoalentity(level.player);
		guy[n].goalradius = 256;
	}
}

courtyard_reinforcements2()
{
	n=1;
	level.cy_truck[n] = spawnvehicle("xmodel/vehicle_german_truck", "cy_truck_"+n, "germanfordtruck", (0,0,0), (0,0,0) );
	mypath = getvehiclenode("cy_truck_2_start", "targetname");

	level.cy_truck[n].script_vehiclegroup = 0;
	level.cy_truck[n] maps\_truck_gmi::init();

	level.cy_truck[n] attachpath(mypath);
	level.cy_truck[n] notify("start_engine");
	
	blocker = getent("rampblocker", "targetname");
	blocker maps\_utility_gmi::triggeron();
	blocker disconnectpaths();
}

lighthouse_reinforcements2()						//The Tank
{
	level.r_tank[0] = spawnvehicle("xmodel/vehicle_tank_panzeriv", "r_tank_0", "panzeriv", (0,0,0), (0,0,0) );

	mypath = getvehiclenode("r_tank_start", "targetname");

	level.r_tank[0].script_vehiclegroup = 3;
	level.r_tank[0] maps\_panzeriv_gmi::init();
	level.r_tank[0] thread maps\_tankgun_gmi::mgoff();
	level.r_tank[0].health = 10000000;
	level.r_tank[0] attachpath(mypath);
	level.r_tank[0] startpath();

	level notify("r_tank started");

	wait 3;

	level notify("klaxon off");

	level.r_tank[0] waittill("reached_end_node");

	tanktarget = level.player;

	level endon("next wave");

	while(1)
	{
		dist = distance(level.player.origin, level.r_tank[0].origin);
		if(dist<3050)
		{
			println("^5Player in range of tank!");
			level.r_tank[0] setTurretTargetEnt(tanktarget, (0,0,0) );
			wait 4;
			level.r_tank[0] thread maps\_panzerIV_gmi::fire();
		}
		wait 0.05;
	}
}



//=====================================================================================================================
// CLIFFSIDE
//=====================================================================================================================
cliffside()
{
	level thread fort_rubble_too_soon();

	level waittill("everyone's in place");

	//Sets every friendly to pacifist
	squad_pacifist(1);

	//Move everyone in 1st squad up to the top of the cliff
	squad_moveup("lh",1,"cliffside");
	level waittill("everyone's in place");

	//Check player's distance from ingram; if he's too far, wait until he gets close enough
	eval = true;
	while(eval)
	{
		if(distance(level.player.origin, level.sas1[0].origin) < 384) eval = false;
		wait 0.05;
	}

	//Wait a moment, have Ingram say his line, and BOOM
	wait (randomfloat(1)+0.05);

	level.scr_notetrack["ingram"][0]["notetrack"]			= "ingram_hornets";
	level.scr_notetrack["ingram"][0]["dialogue"] 			= "ingram_hornets";
	level.scr_notetrack["ingram"][0]["facial"]			= level.scr_face["ingram"]["ingram_hornets2"];

	level.sas1[0] thread anim_single_solo(level.sas1[0], level.dialogue_array[10]);

	level.sas1[0] waittillmatch("single anim","explosion");
	println("^1waittillmatch('single anim','explosion')");

	//Hide miscellaneous crap that would otherwise float in the sky
	obj[0] = getent("lh_health1", "targetname");
	obj[1] = getent("lh_health2","targetname");
	obj[2] = getent("lh_mp44","targetname");
	obj[3] = getent("lh_box1","targetname");
	obj[4] = getent("lh_nades", "targetname");
	for(i=0;i<obj.size;i++)
	{
		if(isdefined(obj[i])) obj[i] delete();
	}

	//::DELETE LIGHTHOUSE BREAKABLE GLASS::
	//NOTE NOTE NOTE!!!  	If you make any other breakable glass in the map, you'll have to tag the lighthouse glass with
	//			a script_noteworthy or something to distinguish which glass to delete at this point!!!
	glass = getentarray("glass","groupname");
	for(n=0;n<glass.size;n++)
	{
		thispiece = getent(glass[n].target, "targetname");

		//Nice little check to see if the player shot the glass in the same frame it's getting deleted...
		//Found a script crash here ONE time
		if(isdefined(thispiece)) thispiece delete();
		else println("^1ERROR - GLASS - 001: TRIED TO DELETE NON EXISTANT PIECE!");
	}
	////////////

	//Delete the charges
	for(n=0;n<3;n++)
	{
		level.bomb_delete[n] delete();
	}

	//Kill anyone left inside!
	if(isdefined(level.lh_axis.size))
	{
		for(n=0;n<level.lh_axis.size;n++)
		{
			if(isalive(level.lh_axis[n])) level.lh_axis[n] dodamage(10000,level.lh_axis[n].origin);
			wait 0.05;
		}
	}

	//Flush corpses, THANKS ALEX
	flushcorpses();

	//Grab up the explosion locations
	for(n=0; n<3; n++)
	{
		level.exp[n] = getent("lh_bomb_" + n, "targetname");
		if(!isdefined(level.exp[n])) println("^1ERROR 016: LH_BOMB_",n," ^1IS NOT DEFINED FOR LIGHTHOUSE EXPLOSION");
	}

	//Start the animations of the pieces falling off
	level thread lighthouse_money_shot();

	//Play the explosion FX at the appropriate locations with the correct delays	
	for(n=0;n<3;n++)
	{
		switch(n)
		{
			case 0:	playfx(level._effect["lh_bomb1"], level.exp[n].origin);
				level.exp[n] playsound("explo_metal_rand");
				earthquake(0.5, 2, level.player.origin, 2500);		//scale duration source radius
				speaker = getent("lh_speaker", "targetname");
				speaker playsound("long_stone_crash");
				wait 1.333;
				break;
	
			case 1: playfx(level._effect["lh_bomb2"], level.exp[n].origin);
				level.exp[n] playsound("explo_metal_rand");
				earthquake(0.4, 1.8, level.player.origin, 2500);		//scale duration source radius
				//Turn off the lighthouse light and stop the rotation
				stopattachedfx(level.lh_light);
				level.lh_light_on = false;
				wait 1.333;
				break;
	
			case 2: playfx(level._effect["lh_bomb3"], level.exp[n].origin);
				//Delete the light
				level.lh_light delete();
				level.exp[n] playsound("explo_metal_rand");
				earthquake(0.3, 1.5, level.player.origin, 2500);		//scale duration source radius
				break;
		}
	}

	//Start up ancilliary functions	
	level thread radio_room();
	level thread courtyard_towers();

	//Ok the player has reached the top of the cliff
	//Turn on the "mission fail" triggers it the player goes back down the cliffside
	level thread cliffside_too_far();

	//Start the air raid siren
	level thread fort_air_raid();

	//Start the trucks on their way
	level thread lighthouse_reinforcements1();

	//Turn on the fort wall FC
	maps\_utility_gmi::chain_on("210");		

	//Squad 1 takes new cover closer to the wall
	squad_moveup("f",1,"hide");
	level waittill("everyone's in place");

	//UPDATE OBJECTIVE FROM "HEAD UP THE PATH" TO "AVOID THE TRUCKS"
	level notify("update objective 3");

	//$$										//Don't engage those trucks or we're done for!
	level.sas1[0] thread anim_single_solo(level.sas1[0], level.dialogue_array[21]);		//ingram_staylow
	//$$

	for(n=0;n<level.mgguy.size;n++)
	{
		level.mgguy[n] thread fort_dont_shoot_the_towers_yet();
	}

	//Ok Squad1 move up to the little ruins area and cower there, squad2 provide cover (haha, don't forget they are in pacifist)
	//NOTE: Squad2 is still targeting friendlychains around the player
	squad_moveup("f",1,"ruins");
	level waittill("everyone's in place");

	//Avoid the trucks!
	level thread fort_avoid_the_trucks();
	level waittill("trucks past");

	level thread fort_wall_continue();
}

lighthouse_money_shot()
{
	level.lighthouse_remove delete();
	for(n=0;n<level.lighthouse.size;n++)
	{
		level.lighthouse[n] show();
	}
	//lighthouse GO
	level thread falling_debris("top");
	level thread falling_debris("middle");
	level thread falling_debris("light");
	level thread falling_debris("chunk1");
	level thread falling_debris("chunk2");
	level thread falling_debris("chunk3");
	level thread falling_debris("light_top");
	level thread falling_debris("bottom");

	delme = getent("interior_misc", "targetname");
	delme delete();

	maps\_fx_gmi::loopfx("fire_lighthouse_base", (-4081, -3152, 1993), 0.4);
}

cliffside_too_far()
{
	trg = getent("too_far_5", "targetname");

	trg waittill("trigger");

	iprintln(&"GMI_SICILY1_DONT_GO_TOO_FAR");

	trg = getent("too_far_6", "targetname");

	trg waittill("trigger");

	iprintln(&"GMI_SICILY1_YOU_WENT_TOO_FAR");

	wait 1;

	//This is a temporary deadquote, need a new one for "you disobeyed orders"
	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
	missionFailed();
}



//=====================================================================================================================
// FORT WALL
//=====================================================================================================================
fort_avoid_the_trucks()
{
	squad_pacifist(1);

	level.trucks_started = true;

	//Get the array of guys and thread them into the "don't shoot me" type function
	axis = getentarray("reinforcements", "groupname");

	for(n=0;n<axis.size;n++)
	{
		axis[n] thread fort_trucks_reinforcements_alert();
	}

	level endon("trucks alerted");

	wait 12;

	level notify("trucks past");
	println("^3trucks are safely past the player");
}

fort_trucks_reinforcements_alert()
{
	level endon("next wave");

	level endon("trucks past");

	self waittill("combat");

	//Shout "Der Fiend!" or whatever
	dialogueLine = "enemysighted";
	self animscripts\face::SayGenericDialogue(dialogueLine);

	level notify("trucks alerted");

	for(n=0;n<3;n++)
	{
		level.r_truck[n] setspeed(0,25);
		level.r_truck[n] notify("unload");
	}

	wait 2;
	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
	missionFailed();
}

fort_dont_shoot_the_towers_yet()
{
	level endon("trucks past");

	self waittill_any("combat", "death", "pain");

	level notify("trucks alerted");
}

barracks_b_alarmed()
{
//	axis = getentarray("barracks_b_charge", "groupname");
//
//	for(n=0;n<3;n++)
//	{
//		myspot = getnode("barracks_b_charge_"+n,"targetname");
//
//		if(!isdefined(myspot)) 
//		{
//			println("^3MYSPOT IS NOT DEFINED: ",n);
//		}
//		else
//		{
//			guy = axis[n] stalingradspawn(); 
//			guy waittill("finished spawning");
//			
//			if(isdefined(guy))
//			{
//				guy setgoalnode(myspot);
//				guy.health = 100;
//				guy.accuracy = 0.2;
//			}
//		}
//	}
}

fort_wall_continue()
{
	//UPDATE OBJECTIVE FROM "AVOID THE TRUCKS" TO "GET UP ONTO THE WALL"
	level notify("update objective 3");

	level thread fort_rubble();

	//$$
	level.sas1[0] anim_single_solo(level.sas1[0], level.dialogue_array[25]);		//ingram_wall
	//$$
}

fort_rubble_too_soon()
{
	level endon("trucks past");
	trg = getent("friendlychain_220", "targetname");
	trg waittill("trigger");

	if(level.trucks_started == true) 
	{
		level notify("trucks alerted");
		for(n=0;n<3;n++)
		{
			level.r_truck[n] setspeed(0,25);
			level.r_truck[n] notify("unload");
		}
	}
	wait 2;
	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
	missionFailed();
}

fort_rubble()
{
	squad_moveup("f",1,"courtyard_setup");

	myspot = getnode("f_teleport_0", "targetname");
	level.sas2[0] setgoalnode(myspot);

	myspot = getnode("f_teleport_1", "targetname");
	level.sas2[1] setgoalnode(myspot);

	trg = getent("friendlychain_220", "targetname");
	trg waittill("trigger");

	//Autosave Point #4!
	maps\_utility_gmi::autosave(4);

	//$$
	level.sas1[0] thread anim_single_solo(level.sas1[0], level.dialogue_array[4]);		//ingram_comms
	//$$

	//UPDATE OBJECTIVE FROM "GET UP ONTO THE WALL" TO "FIND THE RADIO ROOM"
	level notify("update objective 3");

	level thread radio_room_sound_alarm();
	level thread courtyard_squad1_moveup();
	squad_retarget(2);

	//Everyone can shoot
	squad_pacifist(0);
}

radio_room_sound_alarm()
{
	trg = getent("barracks_b_exit", "targetname");

	trg waittill("trigger");

	//Delete those Axis guys
	level thread courtyard_entry();

	level.no_noise = false;

	level notify("start_alarms");
}

cliffside_cheat()
{
	for(n=0;n<10;n++)
	{
		println("^1CLIFFSIDE CHEAT DISABLED");
	}
	wait 5;
	missionFailed();
}



//=====================================================================================================================
// RADIO ROOM STUFF
//=====================================================================================================================
radio_room()
{
	//MAIN FLOW CONTINUES					//-=>
	level thread radio_room_radios();			

	level thread fort_elevator();

	trg = getent("radio_approach", "targetname");
	
	trg waittill("trigger");

	wait 0.5;

	level thread radio_room_shout_alarm();

	level thread radio_room_continue();

	musicStop(2);
}

radio_room_shout_alarm()
{
	thisspawn = getent("r_axis_officer_1", "targetname");

	guy = thisspawn dospawn();

	dialogueLine = "enemysighted";

	guy animscripts\face::SayGenericDialogue(dialogueLine);

	wait 2;

	dialogueLine = "misccombat";

	guy animscripts\face::SayGenericDialogue(dialogueLine);

	wait 1;

	level notify("courtyard alarm");
}


radio_room_radios()
{
	for(n=0; n<5; n++)
	{
		level.radio[n] = getent("radio_"+n,"targetname");

		level.radio_dmg[n] = getent("radio_"+n+"_dmg", "targetname");

		level.radio_dmg[n].totaldmg = 0;

		level.radio_dmg[n] thread radio_dmg(n);
	}
}
                                                
radio_dmg(n)
{
	if(n==2) self playloopsound("german_radio");
	if(n==4) self playloopsound("radio_static");

	self waittill("damage", dmg, who);

	if(n==2 || n==4) self stoploopsound();

	//radio's dead!
	self delete();

	org = level.radio[n].origin;
	ang = level.radio[n].angles;
	level.radio[n] hide();

	playfx(level._effect["radio_exp"], org);
	level.radio[n] playsound("radio_explode");
	level.num_radios_dead++;
	level notify("radio killed");

	println("^5dmodel radio spawned!");
	dradio = spawn("script_model", org);
	dradio setmodel("xmodel/german_radio1_d");
	dradio.angles = ang;
}

radio_room_continue()
{
	while(level.radios_dead == false)
	{
		wait 0.05;
	}

	//Turn off the entry FCs
	maps\_utility_gmi::chain_off("270");
	maps\_utility_gmi::chain_off("280");
	maps\_utility_gmi::chain_off("282");

	//Turn on the exit and stairs FCs and thread 281 to retarget the squad
	maps\_utility_gmi::chain_on("281");
	maps\_utility_gmi::chain_on("283");
	level thread radio_room_exit();

	//Marks objective as complete, threads downstairs door event, and then tells squad to go to the windows
	level notify("objective 4 complete");
	level thread radio_door_kicked_open();
	squad_moveup("r",2,"radios_destroyed");	
}

radio_room_exit()
{
	//Sends the squad after the player once the radios are dead
	trg = getent("friendlychain_281", "targetname");

	trg waittill("trigger");

	level thread squad_retarget(2);
}

radio_door_kicked_open()
{
	trg = getent("friendlychain_283", "targetname");
	trg waittill("trigger");

	//Autosave Point #5
	maps\_utility_gmi::autosave(5);

	trg = getent("radio_door_trigger", "targetname");
	trg waittill("trigger");

	level notify("update objective 5");

	println("^3motorpool door closing!");
	level thread motorpool_door_close();

	door = getent("radio_door", "targetname");

	//grab the 2 dudes who just spawned
	axis = getentarray("radio_door_axis", "groupname");

	spawn1 = axis[0] dospawn();
	spawn2 = axis[1] dospawn();

	spawn1 waittill("finished spawning");
	spawn1.animname = "spawn1";
	spawn1.goalradius = 4;
		
	myspot = getnode("cy_door", "targetname");
	spawn1 setgoalnode(myspot);
	spawn1 waittill("goal");
	
	spawn1 thread anim_single_solo(spawn1, "kick_door_2");

	spawn1 waittillmatch ("single anim", "kick");
	door playsound ("wood_door_kick");

	door rotateto( (0,-120,0), 0.5, 0.2, 0.2);
	door waittill("rotatedone");

	door connectpaths();

	//Tell these two dudes to aggro on the player
	spawn1 setgoalentity(level.player);
	spawn2 setgoalentity(level.player);

	door rotateto( (0,-90, 0), 0.5, 0, 0.2);
	door waittill("rotatedone");

	door rotateto( (0, -120, 0), 0.25, 0, 0.2);
	door waittill("rotatedone");

	door rotateto( (0, -94, 0), 0.5, 0, 0.2);
	door waittill("rotatedone");

	door rotateto( (0,-110,0), 0.5, 0.2, 0.2);
	door waittill("rotatedone");

	door rotateto( (0,-98, 0), 0.5, 0, 0.2);
	door waittill("rotatedone");

	door rotateto( (0, -100, 0), 0.25, 0, 0.2);

	//For now, I'm forcing the spawners to stop once the player comes out of the radio room
	//This set of notifys turns off the spawners, they may already be off but no harm no foul
	//This ensures that once the player enters the motorpool,regardless of how many he's killed, it stops spawning
	level notify("end alpha");
	level notify("end beta");
	level notify("end gamma");
	level notify("end delta");
	//------------------------

	trg = getent("regroup_courtyard_trigger", "targetname");
	trg waittill("trigger");

	level notify("update objective 5");

	//$$
	level.sas1[0] thread anim_single_solo(level.sas1[0], level.dialogue_array[19]);	//ingram_sabotage
	//$$

	wait 1;

	level thread motorpool_prepare_to_enter();
}



//-----------------
// COURTYARD, ENTRY
//-----------------
courtyard_entry()
{
	//Delete the lighthouse truck guys
	axis_remove = getentarray("reinforcements", "groupname");
	
	for(n=0; n<axis_remove.size; n++)
	{
		if(isalive(axis_remove[n])) axis_remove[n] delete();
	}
}

courtyard_squad1_moveup()
{
	level thread update_find_radio_rooms();

	trg = getent("barracks_b_exit", "targetname");
	trg waittill("trigger");

	for(n=0;n<level.sas1.size;n++)
	{
		if(isalive(level.sas1[n])) level.sas1[n].goalradius = 4;
	}
	squad_moveup("f",1,"courtyard_entry");
	squad_moveup("f", 1, "courtyard_proper");
}

update_find_radio_rooms()
{
	trg = getent("friendlychain_barracks_b", "targetname");
	trg waittill("trigger");
	level notify("update objective 3");

	trg = getent("friendlychain_270", "targetname");
	trg waittill("trigger");

	level notify("objective 3 complete");
}

courtyard_towers()
{
	//MAIN FLOW CONTINUES HERE			//-=>
	level thread courtyard_tower_reinforcements();

	//Spawn the two tower dudes in
	mgguyspawner = getentarray("tower_mgguy", "targetname");
	//Set up their characteristics
	for(n=0;n<mgguyspawner.size;n++)
	{
		level.mgguy[n] = mgguyspawner[n] stalingradspawn();
		level.mgguy[n].health = 1;
		level.mgguy[n].pacifist = 1;
		level.mgguy[n] thread courtyard_stealth_kill();
		level.mgguy[n] thread courtyard_towers_wait_for_alarm();
		level.mgguy[n] thread courtyard_towers_wait_for_death();
		level.mgguy[n] thread courtyard_towers_wait_for_combat();
	}
	level thread courtyard_no_noisy_weapons();
	level thread courtyard_towers_pass();
	level thread courtyard_towers_wait_for_success();
}

courtyard_no_noisy_weapons()
{
	level.no_noise = true;
	while(level.no_noise)
	{
		wait 0.05;
		if(level.player AttackButtonPressed())
		{
			if( (level.player getCurrentWeapon()) != "sten_silenced")
			{
				level notify("courtyard alarm");
				level.no_noise = false;
			}
		}
	}
}

courtyard_stealth_kill()
{	
	self endon("death");

	level endon("courtyard stealth success");

	self waittill("combat");

	wait 2;

	level notify("courtyard alarm");

	dialogueLine = "enemysighted";
	self animscripts\face::SayGenericDialogue(dialogueLine);

	//Attack!
	self.pacifist = 0;
	self.favoriteenemy = level.player;
}

courtyard_alarmed()
{
	level waittill("courtyard alarm");	
	//$$
	level.sas1[0] anim_single_solo(level.sas1[0], level.dialogue_array[18]);		//ingram_radios_go
	//$$
}

courtyard_towers_wait_for_combat()
{
	self endon("death");

	self waittill("combat");

	wait 2;

	self.pacifist = 0;

	self.favoriteenemy = level.player;

	level notify("courtyard alarm");
}

courtyard_towers_wait_for_alarm()
{
	self endon("death");
	self waittill("courtyard alarm");
	wait (randomfloat(1) + 0.05);

	//Attack!
	self.pacifist = 0;
	self.favoriteenemy = level.player;
}

courtyard_towers_wait_for_death()
{
	//When a dude gets shot, checks other guy and gives him 2 seconds to react
	self waittill("death");

	if(isalive(level.mgguy[0]))
	{
		level.mgguy[0] endon("death");
		wait 1;
		level.mgguy[0] OrientMode("face direction", level.player.origin); 
		level.mgguy[0] animscripts\shared::lookatentity(level.player, 5, "casual");
		wait 2;
		dialogueLine = "enemysighted";
		level.mgguy[0] animscripts\face::SayGenericDialogue(dialogueLine);
		level notify("courtyard alarm");
	}
	else
	if(isalive(level.mgguy[1]))
	{
		level.mgguy[1] endon("death");
	
		wait 1;
		level.mgguy[1] OrientMode("face direction", level.player.origin); 
		level.mgguy[1] animscripts\shared::lookatentity(level.player, 5, "casual");
		wait 2;
		dialogueLine = "enemysighted";
		level.mgguy[1] animscripts\face::SayGenericDialogue(dialogueLine);
		level notify("courtyard alarm");
	}
}

courtyard_towers_pass()
{
	//If the tower guys are still alive when the player exits Barracks B, alert everyone!
	//Otherwise this won't happen until the player engages the guys in the radio room
	trg = getent("friendlychain_260", "targetname");
	trg waittill("trigger");

	level.no_noise = false;

	level thread barracks_b_exit_trigger();	
	if( (isdefined(level.mgguy[0]) && isalive(level.mgguy[0])) || (isdefined(level.mgguy[1]) && isalive(level.mgguy[1]))  ) 
	{
		wait 0.5;
		level notify("courtyard alarm");
	}
}

courtyard_towers_wait_for_success()
{
	level endon("courtyard alarm");

	while(1)
	{
		wait 0.05;

		if(!isalive(level.mgguy[0]) && !isalive(level.mgguy[1])) 
		{
			level notify("courtyard stealth success");

			break;
		}
	}
}

courtyard_tower_reinforcements()
{
	level waittill("courtyard alarm");

	level thread fort_alarm();

	level thread motorpool_door_open();

	//manage_spawners(strSquadName,mincount,maxcount,ender,spawntime, spawnfunction)
	//  	Squad name -- "alpha", "beta", etc.
	//	MinCount -- Once the number of AI from this spawner are reduced to this number, more will be spawned
	//	MaxCount -- The maximum number of AI this spawner will allow at any one time
	//	Ender -- the notify that stops this spawner
	//	SpawnFunction -- Any function you desire the AI in this squad to run once they spawn
	
	//Alpha = Squads outside the gate
	level thread maps\_squad_manager::manage_spawners("alpha", 1,3,"end alpha", 5, ::axis_motorpool_manager);
	level thread maps\_squad_manager::manage_spawners("beta", 2,3,"end beta", 5, ::axis_motorpool_manager);
	level thread maps\_squad_manager::manage_spawners("gamma", 1,2,"end gamma", 10, ::axis_motorpool_manager);
	//Delta = MG guys
	level thread maps\_squad_manager::manage_spawners("delta", 1,3,"end delta", 10, ::axis_motorpool_manager);
}

barracks_b_exit_trigger()
{
	trg = getent("barracks_b_exit", "targetname");
	
	trg waittill("trigger");

	for(n=0;n<level.mgguy.size;n++)
	{
		if( isdefined( level.mgguy[n] ) )
		{
			if( isalive( level.mgguy[n] ) && issentient( level.mgguy[n] ) )
			{
				level.mgguy[n] dodamage( level.mgguy[n].health + 50, (0,0,0) );
			}
		}
		wait 0.05;
	}

	level thread fort_alarm();
	level notify("courtyard alarm");
}



//=====================================================================================================================
// FORT
//=====================================================================================================================
fort_klaxon()
{
	speaker = getent("f_klaxon_speaker", "targetname");

	level waittill("klaxon on");

	speaker playloopsound("klaxxon_alarm");

	level waittill("klaxon off");

	speaker stoploopsound("klaxon_alarm");

	level thread fort_klaxon();
}	                             

fort_alarm()
{
	level notify("klaxon on");

	wait 20;

	level notify("klaxon off");
}

fort_air_raid()
{
	speaker = getent("f_klaxon_speaker", "targetname");
	speaker playloopsound("air_raid_siren");
	wait 60;
	speaker stoploopsound("air_raid_siren");
}

fort_toggle_inside_alarm(onoff)
{
	if(!isdefined(onoff))
	{
		println("^1ERROR 014: ONOFF NOT SPECIFIED FOR FORT_TOGGLE_INSIDE_ALARM");
		return;
	}

	switch(onoff)
	{
		case "on":	level notify("klaxon on");
				break;

		case "off":	level notify("klaxon off");
				break;
	}
}

random_alerts(alerts, alarms)
{
	while (1)
	{
		if (level.random_alerts == true)
		{
			fort_toggle_inside_alarm("off");

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
				alert = "dam_german_PA_truckpark";
			}
			if (num == 4)
			{
				alert = "dam_german_PA_SASinside";
			}
			if (num == 5)
			{
				alert = "dam_german_PA_shootintruders";
			}

	 		for (i=0;i<alerts.size;i++)
				alerts[i] playsound(alert);
			level.currently_random_alert = true;

			wait 6;
			level.currently_random_alert = false;
			fort_toggle_inside_alarm("on");
		}

		wait (15 + randomint (10) );
	}
}

alert_sound()
{
	alarms = getentarray ("alarm_sound", "script_noteworthy");

	alerts = [];
	for (i=0;i<alarms.size;i++)
	{
		if (isdefined (alarms[i].origin) )
		{
			alerts[i] = spawn ("script_origin", (0,0,0));
			alerts[i].origin = alarms[i].origin;
		}
	}

	level.return_alerts = false;

	level waittill("start_alarms");

	level.random_alerts = true;

	thread random_alerts(alerts, alarms);


	level waittill("alarms_garage");

	level.random_alerts = false;

	wait 3;

	fort_toggle_inside_alarm("off");

//	if (level.currently_random_alert != true)
//	{
// 		for (i=0;i<alerts.size;i++)
//			alerts[i] playsound("dam_PA_lies");
//		println ("British commandos, we have captured your commanding officer etc. etc....");
//	}
	wait 12;

	level.random_alerts = true;

	//
	level.return_alerts = true;
	//

	fort_toggle_inside_alarm("on");

	/////////////////
}

fort_cheat()		//Teleports you to the elevator, before the guns are blown
{
	level thread objective_6();
	wait 0.05;
	level notify("objective 5 complete");
	wait 0.05;
	level notify("update objective 6");

	level.lighthouse_light = false;
	level.guns_practice = false;
	level.elevator_ready = false;

	level.player setorigin( (-10000,-10000,-10000) );

	for(n=0;n<level.sas1.size;n++)
	{
		myspot = getnode("mp_sas1_"+n+"_hold_cr", "targetname");
		level.sas1[n] teleport(myspot.origin);
		println("^5Cheat teleport to fort elevator successful for sas1[",n,"^5]");
	}

	for(n=0;n<level.sas2.size;n++)
	{
		myspot = getnode("f_sas2_"+n+"_elevator_top", "targetname");
		level.sas2[n] teleport(myspot.origin);
		println("^5Cheat teleport to fort elevator successful for sas2[",n,"^5]");
	}

	myspot = getnode("fort_cheat", "targetname");
	level.player setorigin(myspot.origin);

	level thread squad_retarget(2);

	level thread quarters_documents();

	level thread quarters_radios();

	level thread fort_elevator();
}

squad_head_for_elevator_top()
{
	if ( (isalive(level.sas2[0])) || (isalive(level.sas2[1])) )
	{
		if (isalive(level.sas2[0])) level.sas2[0].goalradius = 4;
		if (isalive(level.sas2[1])) level.sas2[1].goalradius = 4;
	
		println("^3squadmove elevator_inside_top");
		squad_moveup("f",2,"elevator_inside_top");
	
		level waittill("everyone's in place");

		println("^3squadmove completed, elevator ready");

		level.elevator_ready = true;

		if (isalive(level.sas2[0])) link0 = spawn("script_origin", level.sas2[0].origin);

		if (isalive(level.sas2[1])) link1 = spawn("script_origin", level.sas2[1].origin);

		if (isalive(level.sas2[0])) level.sas2[0] linkto(link0);
		if (isalive(level.sas2[1])) level.sas2[1] linkto(link1);

		if (isalive(level.sas2[0])) link0 linkto(level.elevator);
		if (isalive(level.sas2[1])) link1 linkto(level.elevator);
	}
}

fort_elevator()
{
	level thread fort_elevator_too_soon();

	level thread fort_elevator_wait_for_going_down();

	level thread guns_bombs();
}

fort_elevator_too_soon()
{
	trg = getent("elevator_interior_top", "targetname");

	trg maps\_utility_gmi::triggeroff();

	level waittill("player spoke to ingram");

	trg maps\_utility_gmi::triggeron();
}


fort_elevator_wait_for_going_down()
{
	// I think this fix is for Mr. Hal9000  :)
//	level waittill("player spoke to ingram");

	trg = getent("elevator_interior_top", "targetname");

	trg setHintString (&"SCRIPT_HINTSTR_USEELEVATOR");

	trg waittill("trigger");

	if(level.documents_found == false)
	{
		println("^3ELEVATOR USE FAILED, DOCUMENTS NOT ACQUIRED");

		level.sas2[0] anim_single_solo(level.sas2[0], level.dialogue_array[36]);		//moditch_search

		thread fort_elevator_wait_for_going_down();
		return;
	}

	level.sas2[0] OrientMode("face angle", 90 );
	
	if(level.elevator_ready == false)
	{
		println("^3ELEVATOR NOT READ");
		level thread fort_elevator_wait_for_going_down();
		return;
	}
	level.elevator_ready = false;

	thread anim_single_solo(level.sas2[0], level.dialogue_array[37]);			//moditch_good

	level notify("update objective 7");

	level thread guns_wait_for_objective_update();

	//Animate switch here!
	handle = getent("handle1", "targetname");
	handle linkto(level.elevator);

	level.elevator_blocker solid();

	//Autosave #7!
	maps\_utility_gmi::autosave(7);
	println("autosave 7 complete");

	wait 1;

	//Ends player detector
	level notify("elevator going down");
	
	level.elevator playsound("elevator_very_long");
	level.elevator movez (-508,10,2,4);
	level.elevator waittill("movedone");
	level.elevator_blocker notsolid();

	if (isalive(level.sas2[0])) level.sas2[0] unlink();
	if (isalive(level.sas2[1])) level.sas2[1] unlink();

	squad_retarget(2);
	

	level thread fort_elevator_wait_for_going_up();
}

fort_elevator_player_inside_top(trg)
{
//	level endon("elevator going down");
//
//	trg2 = getent("going_down_trigger", "targetname");
//
//	trg2 waittill("trigger");
//
//	trg maps\_utility_gmi::triggeron();
//
//	while(level.player istouching(trg2))
//	{
//		wait 0.05;
//	}
//
//	trg maps\_utility_gmi::triggeroff();
//	level thread fort_elevator_player_inside_top(trg);
}

fort_elevator_wait_for_going_up()
{
	trg = getent("elevator_interior_bottom", "targetname");
	trg setHintString (&"SCRIPT_HINTSTR_USEELEVATOR");
	trg maps\_utility_gmi::triggeroff();

	//Don't start looping the wait for ready for the elevator until the mag charges are planted
	level waittill("magazine charge planted");

	while(level.elevator_ready == false)
	{
		wait 0.5;
	}

	trg maps\_utility_gmi::triggeroff();

	level thread fort_elevator_player_inside_bottom(trg);

	trg maps\_utility_gmi::triggeron();

	trg waittill("trigger");

	trg maps\_utility_gmi::triggeroff();

	level.elevator_ready = false;

	//Animate the switch handle
	handle = getent("handle1", "targetname");

	//Spun-off events
	//level thread delete_all_axis();
	level thread fort_elevator_barracks_a_charge();
	level thread back_to_the_motorpool();

	level notify("update objective 10");

	level.elevator_blocker solid();

	//Set up the garage return fight
	trg = getent("killspawner_500", "targetname");	//500 is garage on way back
	trg maps\_utility_gmi::triggeron();

	trg = getent("cy_2_garage", "groupname");	//Garage attackers on catwalk, with floodspawner
	trg maps\_utility_gmi::triggeron();

	//Turn on the friendlychains that leave the horseshoe
	maps\_utility_gmi::chain_on("495");
	maps\_utility_gmi::chain_on("493");
	maps\_utility_gmi::chain_on("491");
	maps\_utility_gmi::chain_on("489");		//Exit from horseshoe back to garage
	maps\_utility_gmi::chain_on("487");
	maps\_utility_gmi::chain_on("485");
	maps\_utility_gmi::chain_on("483");

	//Turn off the entry friendlychains
	maps\_utility_gmi::chain_off("440");
	maps\_utility_gmi::chain_off("442");
	maps\_utility_gmi::chain_off("444");
	maps\_utility_gmi::chain_off("446");
	maps\_utility_gmi::chain_off("448");
	maps\_utility_gmi::chain_off("450");
	maps\_utility_gmi::chain_off("452");
	maps\_utility_gmi::chain_off("454");

	//Autosave #11		
	maps\_utility_gmi::autosave(11);
	println("autosave 11 complete");

	wait 1;

	level.elevator playsound("elevator_very_long");

	level.elevator movez (508,10,4,2);
	level.elevator waittill("movedone");

	level.elevator_blocker notsolid();
	trg = getent("elevator_interior_top", "targetname");
	trg maps\_utility_gmi::triggeroff();

	if(isalive(level.sas2[0])) level.sas2[0] unlink();
	if(isalive(level.sas2[1])) level.sas2[1] unlink();

	level thread motorpool_the_son_of_motorpool();

	squad_retarget(2);
}

fort_elevator_player_inside_bottom(trg)
{
	level endon("elevator going down");

	trg2 = getent("going_up_trigger", "targetname");
	trg2 waittill("trigger");
	trg maps\_utility_gmi::triggeron();

	while(level.player istouching(trg2))
	{
		wait 0.05;
	}

	trg maps\_utility_gmi::triggeroff();
	level thread fort_elevator_player_inside_bottom(trg);
}


guns_wait_for_objective_update()
{
		trg = getent("friendlychain_300", "targetname");
		trg waittill("trigger");

		level notify("objective 7 complete");
}

fort_elevator_barracks_a_charge()
{
	//open the door
	barracks_a_door = getent("barracks_a_door", "targetname");
	barracks_a_door	rotateto( (0,-120,0), 0.5, 0.2, 0.2);
	barracks_a_door waittill("rotatedone");
	barracks_a_door connectpaths();

	//spawn the dudes in there, and tell them to get OUT
	fort_axis = getentarray("barracks_a_reinforcements", "groupname");
	println("^3spawned ",fort_axis.size," guys from barracks A, they are moving into position");
	for(n=0;n<fort_axis.size;n++)
	{
		fort_axis[n] dospawn();
		fort_axis[n] waittill("finished spawning");
		fort_axis[n].pacifist = 0;
		fort_axis[n].goalradius = 32;
	}
}



//----------
// MOTORPOOL
//----------
motorpool_prepare_to_enter()
{
	//Activate the trigger / chain outside the motorpool door
	maps\_utility_gmi::chain_on("420");

	level thread motorpool_entry();

	squad_moveup("f",3,"mp_entry");

	level.sas1[0] waittill("goal");

	level thread motorpool_side_door_kick();
}

motorpool_entry()
{
	trg = getent("motorpool_entry", "targetname");

	trg waittill("trigger");

	level thread quarters_entry();
}

motorpool_side_door_kick_check()
{
		level.sas1[0] waittill("goal");
		level.side_door_kick = true;
}

motorpool_side_door_kick()
{
	//Grab the door entity
	mp_door = getent("mp_door", "targetname");

	//Set our "met goal" condition to false for ingram's position
	level.side_door_kick = false;

	//Get the node for ingram, set his goal radius, and set his goal
	myspot = getnode("mp_door_kick", "targetname");
	level.sas1[0].goalradius = 4;
	level.sas1[0] setgoalnode(myspot);

	//Thread ingram into a check to wait until he hits his goal
	level thread motorpool_side_door_kick_check();

	//While ingram's not at his goal, reissue the goal periodically to prevent player blocking his goal
	while(level.side_door_kick == false)
	{
		wait 2;
		myspot = getnode("mp_door_kick", "targetname");
		level.sas1[0] setgoalnode(myspot);
	}

	//Autosave Point #6
	maps\_utility_gmi::autosave(6);
	println("autosave 6 complete");

	level.sas1[0] OrientMode("face angle", 180 );

	wait 0.25;

	level.sas1[0] thread anim_single_solo(level.sas1[0], "kick_door_2");

	wait 0.25;

	mp_door playsound ("wood_door_kick");
	mp_door rotateto( (0,120,0), 0.5, 0.2, 0.2);
	mp_door waittill("rotatedone");

	mp_door connectpaths();

	level thread motorpool_finish_door();

	//Resets squad two to follow the player on the friendly chain specified
	chain = maps\_utility::get_friendly_chain_node("320");
	level.player SetFriendlyChain(chain);
	squad_retarget(2);

	squad_moveup("mp",1,"hold_cr");

	level waittill("everyone's in place");

	while(	( ( isalive(level.sas1[0]) ) && ( isdefined(level.sas1[0].script_anim)  && ( level.sas1[0].script_anim == "combat" ) ) ) ||
		( ( isalive(level.sas1[1]) ) && ( isdefined(level.sas1[1].script_anim)  && ( level.sas1[1].script_anim == "combat" ) ) ) ||
		( ( isalive(level.sas1[2]) ) && ( isdefined(level.sas1[2].script_anim)  && ( level.sas1[2].script_anim == "combat" ) ) ) ||
		( ( isalive(level.sas2[0]) ) && ( isdefined(level.sas2[0].script_anim)  && ( level.sas1[0].script_anim == "combat" ) ) ) ||
		( ( isalive(level.sas2[1]) ) && ( isdefined(level.sas2[1].script_anim)  && ( level.sas1[1].script_anim == "combat" ) ) ) )
		{
			wait 1;
			println("^3Friendlies still in combat in garage");
		}

	//Check player's distance from ingram; if he's too far, wait until he gets close enough
	eval = true;
	while(eval)
	{
		if(distance(level.player.origin, level.sas1[0].origin) < 164) eval = false;
		wait 0.05;
	}
	level notify("objective 5 complete");
	maps\_utility_gmi::chain_on("440");
	level thread motorpool_wait_for_update_objectives();

	level notify("player spoke to ingram");

	//$$
	level.sas1[0] thread anim_single_solo(level.sas1[0], level.dialogue_array[7]);	//ingram_fort
	//$$

	//Cheesy movement of squad 1 to nodes in the garage area to prep for player coming back
	myspot = getnode("mp_truck_6", "targetname");
	if(isalive(level.sas1[2])) level.sas1[2] setgoalnode(myspot);
	myspot = getnode("garage_cover_100", "targetname");
	if(isalive(level.sas1[1])) level.sas1[1] setgoalnode(myspot);

	squad_moveup("mp",2,"door");
	trg = getent("friendlychain_440", "targetname");
	trg waittill("trigger");
	squad_retarget(2);

	myspot = getnode("thad_2004", "targetname");
	if(isalive(level.sas1[0])) level.sas1[0] setgoalnode(myspot);
}

motorpool_wait_for_update_objectives()
{
	trg = getent("friendlychain_483", "targetname");
	trg waittill("trigger");
	squad_retarget(2);
	level notify("update objective 6");
	level notify("alarms_garage");
	musicplay("sicily1_bunker");
}

motorpool_finish_door()
{
	mp_door = getent("mp_door", "targetname");

	mp_door rotateto( (0,90, 0), 0.5, 0, 0.2);
	mp_door waittill("rotatedone");

	mp_door rotateto( (0, 120, 0), 0.25, 0, 0.2);
	mp_door waittill("rotatedone");

	mp_door rotateto( (0, 94, 0), 0.5, 0, 0.2);
	mp_door waittill("rotatedone");

	mp_door rotateto( (0,110,0), 0.5, 0.2, 0.2);
	mp_door waittill("rotatedone");

	mp_door rotateto( (0,98, 0), 0.5, 0, 0.2);
	mp_door waittill("rotatedone");

	mp_door rotateto( (0, 100, 0), 0.25, 0, 0.2);
}

motorpool_close_side_door()
{
	mp_door = getent("mp_door", "targetname");
	
	mp_door rotateto( (0, 0, 0), 0.25, 0, 0.2);

	mp_door waittill("movedone");

	mp_door disconnectpaths();
}

motorpool_door_open()
{
	if(level.mp_door_close == false) return;

	level.mp_door_close = false;
	
	level.mp_door_l moveto(level.mp_door_l.origin + (0,76,0),4,2,1);
	level.mp_door_r moveto(level.mp_door_r.origin + (0,-76,0),4,2,1);
	
	level.mp_door_l waittill("movedone");

	level.mp_door_l connectpaths();
	level.mp_door_r connectpaths();
}

motorpool_door_close()
{
	if(level.mp_door_close == true) return;

	level.mp_door_close = true;

	level.mp_door_l moveto(level.mp_door_l.origin + (0,-76,0),4,2,1);
	level.mp_door_r moveto(level.mp_door_r.origin + (0,76,0),4,2,1);

	level.mp_door_l waittill("movedone");

	level.mp_door_l disconnectpaths();
	level.mp_door_r disconnectpaths();
}

axis_motorpool_manager()
{
	self.bravery = 500000;

	self thread axis_motorpool_did_player_kill_me();
}

axis_motorpool_did_player_kill_me()
{
	self waittill("death", who);

	if(level.axis_courtyard_reinforcements_killed == -1) return;

	if(who==level.player)
	{
		level.axis_courtyard_reinforcements_killed++;
	
		if(level.axis_courtyard_reinforcements_killed > level.axis_courtyard_total_reinforcements)
		{
			level.axis_courtyard_reinforcements_killed = -1;	
					
			level notify("end alpha");
			level notify("end beta");
			level notify("end gamma");
			level notify("end delta");
		
			level thread motorpool_door_close();	
		}
	}
}

motorpool_the_son_of_motorpool()
{
	spawners = getentarray("son_of_motorpool", "targetname");
	for(n=0;n<spawners.size;n++)
	{
		son = spawners[n] dospawn();
	}

	trg = getent("garage_comeback", "targetname");	//2 guys to start garage fight
	trg maps\_utility_gmi::triggeron();
}



//---------
// QUARTERS
//---------
quarters_entry()
{
	level thread quarters_documents();

	level thread quarters_radios();

	officer = (getent("q_officer", "targetname")) dospawn();
	println("officer spawned");

	officer.health = 100;

	officer.accuracy = 1;
	
	officer.favoriteenemy = level.player;

	officer.bravery = 1;
}

quarters_documents()
{
	trg = getent("use_documents", "targetname");

	trg maps\_utility_gmi::triggeroff();

	level waittill("player spoke to ingram");

	trg maps\_utility_gmi::triggeron();

	org = (getent("marker_documents", "targetname")).origin;

	docu = spawn("script_model", org);

	docu setmodel("xmodel/documents1_objective");
	println("documents spawned");

	trg setHintString(&"GMI_SCRIPT_HINTSTR_GET_DOCUMENTS");

	trg waittill("trigger");

	docu_speaker = getent("marker_documents", "targetname");
	docu_speaker playsound("paper_pickup");

	docu delete();

	trg setcursorhint("HINT_NONE");

	trg delete();

	level notify("got documents");

	level notify("objective 6 complete");

	//Lets the elevator and the level know that the documents have been found
	level.documents_found = true;

	//level thread motorpool_close_side_door();

	//Tells the squad to get into the elevator up top
	//and handles elevator ready state once they reach it
	level thread squad_head_for_elevator_top();
	println("Squad2 issued moveup to elevator");
}

quarters_radios()
{
	for(n=0;n<4;n++)
	{
		level.radio2_trg[n] = getent("quarters_radio_dmg_"+n,"targetname");
	
		level.radio2[n] = getent("quarters_radio_"+n, "targetname");

		if(!isdefined(level.radio2[n]))
		{
			println("^1Quarters_radio[",n,"^1] IS NOT DEFINED");
			return;
		}

		level.radio2_trg[n].totaldmg = 0;

		level.radio2_trg[n] thread quarters_radio_wait_for_death(n);

	}
}

quarters_radio_wait_for_death(n)
{
	if(n==1)
	{
		self playloopsound("radio_static");
	}
	
	if(n==3)
	{
		self playloopsound("german_radio");
	}

	self waittill("damage", dmg, who);

	if(n==1 || n==3) self stoploopsound();

	org = level.radio2[n].origin;
	ang = level.radio2[n].angles;

	//radio's dead!
	println("^5dmodel radio spawned!");
	dradio = spawn("script_model", org);
	dradio setmodel("xmodel/german_radio1_d");
	dradio.angles = ang;

	self delete();

	level.radio2[n] hide();

	playfx(level._effect["radio_exp"], org);

	level.radio2[n] playsound("radio_explode");
}



//-----
// GUNS
//-----
guns_setup()
{
	dguns = getentarray("destroyed_gun", "script_noteworthy");
	for(n=0;n<dguns.size;n++)
	{
		dguns[n] hide();
	}
}

guns_bombs()
{
	bombs = getentarray("g_bomb", "groupname");
	for(n=0;n<bombs.size;n++)
	{
		bombs[n] setHintString (&"SCRIPT_HINTSTR_PLANTEXPLOSIVES");
	}

	level thread get_bomb_array("g_bomb");

	level waittill("all bombs planted");

	squad_retarget(2);

	//Thread magazine, and escape objective
	level thread magazine_bombs();

	level thread objective_10();
}

guns_bombs_go_off(bombmodel)
{
	//Thread the trigger into this function if it's a g_bomb

	//Get the ents we will need
	passtarget = getent(self.target, "targetname");		//this is the bombmodel
	gun = getent(passtarget.target, "targetname");		//this is the gun model currently showing
	dgun = getent(gun.target, "targetname");		//this is the gun dmodel which is initially hidden
	exporg = passtarget.origin;				//the origin of the explosion
	self.bomb = passtarget;

	if(!isdefined(self.script_noteworthy))
	{
		println("^1ERROR 013: NO SEQUENCE SPECIFIED FOR GUNS_BOMBS");
		return;
	}
	else
	{
		//if two other guns are planted, do the alternate mag event thread
		if(level.guns_charges_planted == 2)
		{
			switch (self.script_noteworthy)
			{
				case "1" :	//Center charge or right charge placed last, squad moves to outside right door
				case "2" : 	level.mag_door_opened = "right";
						level thread mag_door_right();
						break;
				case "3" :	level.mag_door_opened = "left";
						level thread mag_door_left();
						break;
			}
		}
		else
		{
			switch (self.script_noteworthy)
			{
				case "1":	//Do nothing, it's the first gun
						break;
	
				case "2":	//Switch up the FC on the right side
						//Turn off the incoming ones
						maps\_utility_gmi::chain_off("330");
						maps\_utility_gmi::chain_off("332");
						maps\_utility_gmi::chain_off("334");
						maps\_utility_gmi::chain_off("336");
						//Turn on the outgoing ones
						maps\_utility_gmi::chain_on("331");
						maps\_utility_gmi::chain_on("333");
						break;
	
				case "3":	//Switch up the FC on the left side, GO!
						maps\_utility_gmi::chain_off("340");
						maps\_utility_gmi::chain_off("342");
						maps\_utility_gmi::chain_off("344");
						//Turn on the outgoing ones
						maps\_utility_gmi::chain_on("341");
						maps\_utility_gmi::chain_on("343");
						break;
			}
		}
	}


	//iprintlnbold (&"SCRIPT_EXPLOSIVESPLANTED");
	self maps\_utility_gmi::triggerOff();
	
	//self.bomb playsound ("explo_plant_no_tick");
	self.bomb playloopsound ("bomb_tick");

	//count down
	if (isdefined (level.bombstopwatch))
		level.bombstopwatch destroy();

	level.bombstopwatch = newHudElem();
	level.bombstopwatch.x = 36;
	level.bombstopwatch.y = 240;
	level.bombstopwatch.alignX = "center";
	level.bombstopwatch.alignY = "middle";
	level.bombstopwatch setClock(5, 60, "hudStopwatch", 64, 64); // count down for 10 of 60 seconds, size is 64x64
	level.timersused++;
	wait 5;
	self.bomb stoploopsound ("bomb_tick");
	level.timersused--;
	if (level.timersused < 1)
	{
		if (isdefined (level.bombstopwatch))
			level.bombstopwatch destroy();
	}

	//origin, range, max damage, min damage
	radiusDamage (self.bomb.origin, 500, 600, 50);
	earthquake(0.25, 3, self.bomb.origin, 1050);

	playfx(level._effect["guns_exp"], exporg);

	gun playsound("explo_metal_rand");

	gun hide();
	dgun show();
	passtarget delete();
	bombmodel delete();
	level.guns_charges_planted++;
}



//---------
// MAGAZINE
//---------
magazine_bombs()
{
	bombs = getentarray("m_bomb", "groupname");
	for(n=0;n<bombs.size;n++)
	{
		bombs[n] setHintString (&"SCRIPT_HINTSTR_PLANTEXPLOSIVES");
	}

	level thread get_bomb_array("m_bomb");

	level waittill("all bombs planted");

	level notify("magazine charge planted");						//For elevator

	//Turn on the killspawner in the basement that will stop the flood of guys from the elevator
	trg = getent("killspawner_310", "targetname");						//300 is guns
	trg maps\_utility_gmi::triggeron();

	level.sas2[1] anim_single_solo(level.sas2[1], level.dialogue_array[40]);		//denny_outta_here

	//From this point on, Moditch and Denny can die
	level.sas1[0] thread maps\_utility_gmi::stop_magic_bullet_shield(600);
	level.sas1[1] thread maps\_utility_gmi::stop_magic_bullet_shield(600);

	println("^5Moditch and Denny are now vulernable!");

	//Opens up the other side of the magazine stairs for the player to exit
	level thread mag_door_open_alternate();

	//SQUAD MOVES TO ELEVATOR_INSIDE_BOTTOM	
	if(isalive(level.sas2[0]) || isalive(level.sas2[1]) )
	{
		if(isalive(level.sas2[0])) level.sas2[0].goalradius = 4;
		if(isalive(level.sas2[1])) level.sas2[1].goalradius = 4;

		squad_moveup("f",2,"elevator_inside_bottom");
		level waittill("everyone's in place");

		level.elevator_ready = true;

		if(isalive(level.sas2[0])) link0 = spawn("script_origin", level.sas2[0].origin);
		if(isalive(level.sas2[1])) link1 = spawn("script_origin", level.sas2[1].origin);

		if(isalive(level.sas2[0])) level.sas2[0] linkto(link0);
		if(isalive(level.sas2[1])) level.sas2[1] linkto(link1);

		if(isalive(level.sas2[0])) link0 linkto(level.elevator);
		if(isalive(level.sas2[1])) link1 linkto(level.elevator);
	}
	else
	if (!isalive(level.sas2[0]) && !isalive(level.sas2[1]))
	{
		level.elevator_ready = true;
	}
}

mag_door_right()
{
	wait 6;
	mag_guys = getentarray("mag_guys_right", "groupname");
	for(n=0;n<mag_guys.size;n++)
	{
		guy = mag_guys[n] dospawn();
		guy setgoalentity(level.player);
	}

	//open door
	level.mag_door_right rotateto( (0,90,0), 0.4, 0.2, 0);
	level.mag_door_right connectpaths();

	if(level.mag_alt == 1) return;

	trg = getent("mag_door_right_trigger", "targetname");
	trg waittill("trigger");
	
	squad_moveup("m",2,"moveto");
}

mag_door_left()
{
	wait 6;

	//spawn dudes
	//set dude's goal to player
	mag_guys = getentarray("mag_guys_left", "groupname");
	for(n=0;n<mag_guys.size;n++)
	{
		guy = mag_guys[n] dospawn();
		guy setgoalentity(level.player);
	}

	//open door
	level.mag_door_left rotateto( (0,90,0), 0.4, 0.2, 0);
	level.mag_door_left connectpaths();

	if(level.mag_alt == 1) return;

	trg = getent("mag_door_left_trigger", "targetname");
	trg waittill("trigger");
	
	squad_moveup("m",2,"moveto");
}

mag_door_open_alternate()
{
	//Called once the mag charges are placed
	if(level.mag_door_opened == "left")
	{
		//I was just opening the doors, but what the heck let's spawn those guys for kicks
		//level.mag_door_right rotateto( (0,-90,0), 0.4, 0.2, 0);
		level.mag_alt = 1;
		level thread mag_door_right();
	}
	else
	{
		//Note: The level.mag_alt var keeps track of whether or not the second call to the function should move the squad up
		//level.mag_door_left rotateto( (0,90,0), 0.4, 0.2, 0);
		level.mag_alt = 1;
		level thread mag_door_left();
	}
}



//-----------
// END OF MAP
//-----------
motorpool_cheat()
{
	level.lighthouse_light = false;
	level.documents_found = true;
	level.elevator_ready = true;

	level.player setorigin( (-10000,-10000,-10000) );

	for(n=0;n<level.sas1.size;n++)
	{
		myspot = getnode("mp_sas1_"+n+"_kwr", "targetname");

		if(n==0) myspot = getnode("cy_sas1_0_bike", "targetname");

		level.sas1[n] teleport(myspot.origin);

		println("^5Cheat teleport to fort elevator successful for sas1[",n,"^5]");
	}

	for(n=0;n<level.sas2.size;n++)
	{
		myspot = getnode("mp_sas2_"+n+"_kwr", "targetname");
		level.sas2[n] teleport(myspot.origin);
		println("^5Cheat teleport to fort elevator successful for sas2[",n,"^5]");
	}

	level.player setorigin((-8224,-3872,3112));

	wait 10;

	//$$
	level.sas1[0] anim_single_solo(level.sas1[0], level.dialogue_array[16]);	//ingram_kubel
	//$$

	level thread head_for_bike();

	level thread get_on_the_kubelwagen();
}

back_to_the_motorpool()
{
	trg = getent("friendlychain_483", "targetname");

	trg waittill("trigger");

	level notify("update objective 10");

	level notify("next wave");

	exp = getent("mp_door_destroyed_charge", "targetname");
	exporg = exp.origin;
	
	wait 0.05;

	playfx(level._effect["guns_exp"], exporg);

	exp playsound("explo_metal_rand");

	level.mp_door_l delete();
	level.mp_door_r delete();
	level.mp_door_destroyed_l show();
	level.mp_door_destroyed_r show();

	//Make the truck stopping area inaccessible to the AI
	level.mp_truck_blocker show();
	level.mp_truck_blocker disconnectpaths();

	level thread courtyard_reinforcements1();
	level thread motorpools_revenge();
}

motorpools_revenge()
{
	blocker = getent("ramp_blocker", "targetname");
	blocker maps\_utility_gmi::triggeron();
	blocker disconnectpaths();

	wait 15;

	level thread barracks_b_alarmed();
	println("Barracks_b_alarmed thread started");

	wait 15;

	level.sas2[0] thread anim_single_solo(level.sas2[0], level.dialogue_array[41]);	//moditch_oh_man

	maps\_utility_gmi::chain_on("700");
	maps\_utility_gmi::chain_on("702");		//700 is courtyard
	maps\_utility_gmi::chain_on("704");
	maps\_utility_gmi::chain_on("706");

	blocker = getent("ramp_blocker", "targetname");
	blocker maps\_utility_gmi::triggeroff();
	blocker connectpaths();

	squad_retarget(1);
	squad_retarget(2);

	trg = getent("friendlychain_706", "targetname");

	trg waittill("trigger");

	while( distance(level.player.origin, level.sas1[0].origin) > 256 )
	{
		wait 0.05;
	}

	level thread head_for_bike();

	level thread get_on_the_kubelwagen();

	//$$
	level.sas1[0] thread anim_single_solo(level.sas1[0], level.dialogue_array[16]);	//ingram_kubel
	//$$
}

get_on_the_kubelwagen()
{
	wait 1;

	//def the kubel
	level.kubelwagen = getent("kubelwagen", "targetname");

	//tell the dudes to get on the bike, except ingram
	level.numguysinplace = 0;
	level.numguysalive = 0;

	level thread squad1_get_on_bike();
	level thread squad2_get_on_bike();
	level thread bike_setup();

	kubel_guys = [];

	if(isalive(level.sas1[1]))		//luyties
	{
		level.numguysalive++;
		kubel_guys = maps\_utility_gmi::add_to_array ( kubel_guys, level.sas1[1] );
	}
	if(isalive(level.sas1[2]))		//hoover
	{
		level.numguysalive++;
		kubel_guys = maps\_utility_gmi::add_to_array ( kubel_guys, level.sas1[2] );
	}
	if(isalive(level.sas2[0]))		//moditch
	{
		level.numguysalive++;
		kubel_guys = maps\_utility_gmi::add_to_array ( kubel_guys, level.sas2[0] );

	}	
	if(isalive(level.sas2[1]))		//denny
	{
		level.numguysalive++;
		kubel_guys = maps\_utility_gmi::add_to_array ( kubel_guys, level.sas2[1] );
	}

	level.flags["KubelStart"] = false;		

	while(level.numguysinplace < level.numguysalive)
	{
		wait 0.05;
		level.numguysalive = 0;

		if(isalive(level.sas1[1])) level.numguysalive++;
		if(isalive(level.sas1[2])) level.numguysalive++;
		if(isalive(level.sas2[0])) level.numguysalive++;
		if(isalive(level.sas2[1])) level.numguysalive++;
	}

	level.kubelwagen maps\_kubelwagon_gmi::init();
	level.kubelwagen.health = 10000000;
	level.kubelwagen thread maps\_kubelwagon_gmi::handle_attached_guys2(kubel_guys);		//note: handle_attached_guys2<-

	level waittill("guys in kubelwagen");

	level.kubelwagen attachpath( getVehicleNode ("kubel_start","targetname") );

	level.kubelwagen thread dont_kill_the_kubel();

	level.kubelwagen.attachedpath = getVehicleNode ("kubel_start","targetname");
	level.kubelwagen startpath();

	//
	level.kubelwagen thread maps\_vehiclechase_gmi::enemy_vehicle_paths();
	//

	level.kubelwagen waittill("reached_end_node");
	level.kubelwagen thread dont_kill_the_kubel();

	level.kubelwagenSTARTED = true;

	while(level.kubelwagenGO == false)
	{
		wait 0.05;
	}

	level thread demo_the_courtyard();

	level.kubelwagen.attachedpath = getvehiclenode("kubel_wait", "targetname");
	level.kubelwagen attachpath( getvehiclenode("kubel_wait", "targetname") );

	//
	level.kubelwagen thread maps\_vehiclechase_gmi::enemy_vehicle_paths();
	//

	level.kubelwagen startpath();

	wait 4;

	level.cy_gate rotateto( (0,45,0), 0.5, 0, 0);
	level.kubelwagen playsound("wood_door_kick");

	level.kubelwagen waittill("reached_end_node");

	wait 3;

	//$$
	level.sas1[0] thread anim_single_solo(level.sas1[0], level.dialogue_array[8]);	//ingram_goodmen
	//$$
}

dont_kill_the_kubel()
{
	self endon("kubel vulnerable");
	self waittill("death");
	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
	missionFailed();
}	

demo_the_courtyard()
{
	level.ct = 1.5;

	wait 1;

	println("^1COURTYARD DEMO STARTED!");

	exparray = getentarray("cy_truck", "groupname");

	println("^5size = ", exparray.size);

	for(n=0;n<exparray.size;n++)
	{
		//thread each ent into its own explosion function
		exparray[n] thread blow_up();
	}
}		

blow_up()
{
	level.ct += randomfloat(1) + 0.15;	
	println(self.groupname," ^3is about to blow up");
	wait 3.5 + level.ct;
	fx = loadfx("fx/explosions/vehicles/truck_complete.efx");
	self playsound ("explo_metal_rand");
	playfx ( fx, self.origin + (0,0,20) );
	earthquake(0.25, 3, self.origin, 1050);
	radiusDamage (self.origin, 245, 200, 100);
}

squad1_get_on_bike()
{
	level thread squad1_get_on_bike2();

	if(isalive(level.sas1[1]))		//Luyties, the driver...
	{
		myspot = getnode("mp_sas1_1_kwr", "targetname");

		level.sas1[1].goalradius = 16;

		level.sas1[1] setgoalnode(myspot);

		level.sas1[1] waittill("goal");

		level.numguysinplace++;

		level waittill("guys in kubel");

		level.sas1[1] linkto(level.kubelwagen, "tag_driver", (0,0,0), (0,0,0) );
	}
}

squad1_get_on_bike2()
{
	if(isalive(level.sas1[2]))		//Hoover, if he's still kicking
	{
		myspot = getnode("mp_sas1_2_kwr", "targetname");

		level.sas1[2].goalradius = 16;

		level.sas1[2] setgoalnode(myspot);

		level.sas1[2] waittill("goal");

		level.numguysinplace++;

		level waittill("guys in kubel");

		level.sas1[2] linkto(level.kubelwagen, "tag_passenger", (0,0,0), (0,0,0) );
	}
}

squad2_get_on_bike()
{
	level thread squad2_get_on_bike2();

	if(isalive(level.sas2[0]))		//moditch
	{
		myspot = getnode("mp_sas2_0_kwr", "targetname");

		level.sas2[0].goalradius = 16;

		level.sas2[0] setgoalnode(myspot);

		level.sas2[0] waittill("goal");

		level.numguysinplace++;

		level waittill("guys in kubel");

		level.sas2[0] linkto(level.kubelwagen, "tag_guy02", (0,0,0), (0,0,0) );
	}
}

squad2_get_on_bike2()
{
	if(isalive(level.sas2[1]))		//denny
	{
		myspot = getnode("mp_sas2_1_kwr", "targetname");

		level.sas1[1].goalradius = 16;

		level.sas2[1] setgoalnode(myspot);

		level.sas2[1] waittill("goal");

		level.numguysinplace++;

		level waittill("guys in kubel");

		level.sas2[1] linkto(level.kubelwagen, "tag_guy01", (0,0,0), (0,0,0) );

	}
}

bike_setup()
{
	level.player_bike = getent("player_vehicle", "targetname");
	path = getvehiclenode(level.player_bike.target, "targetname");
	level.player_bike attachpath(path);

	while(level.kubelwagenSTARTED == false)
	{
		wait 0.05;
	}

	trg = getent("bike_use", "targetname");
	trg sethintstring(&"GMI_SCRIPT_HINTSTR_GET_IN_SIDECAR");
	trg setcursorhint("hint_activate");
	trg maps\_utility_gmi::triggerOn();

	trg waittill("trigger");

	level.player_bike thread maps\_bmwbikedriver_gmi::main(level.sas1[0]);
	level.player_bike thread maps\_vehiclechase_gmi::enemy_vehicle_paths();

	level.player allowStand(true);
	level.player allowCrouch(true);
	level.player allowProne(false);

	level.player setorigin ((level.player_bike getTagOrigin ("tag_player")));
	level.player playerlinkto(level.player_bike,"tag_player",( 1, 1, 0.6 ));

	level.player_bike startpath();

	level.kubelwagenGO = true;

	musicplay("sicily1_escape");

	level thread evil_axis_tank();

	wait 37;

	missionSuccess ("sicily2", true);
}

head_for_bike()
{
	myspot = getnode("cy_sas1_0_bike", "targetname");

	level.sas1[0].goalradius = 16;

	level.sas1[0] setgoalnode(myspot);

	level.sas1[0] waittill("goal");

	wait 1;

	level notify("update objective 10");

//	level notify("head for bike");
}

evil_axis_tank()
{
	level.r_tank[0] endon("death");	

	mypath = getvehiclenode("r_tank_return", "targetname");
	tanktarget = level.kubelwagen;

	level.r_tank[0] attachpath(mypath);
	level.r_tank[0] startpath();

	trg = getent("kubel_fire", "targetname");
	trg waittill("trigger");
	level.kubelwagen notify("kubel vulnerable");
	level.kubelwagen.health = 1;

	level.r_tank[0] thread maps\_tankgun_gmi::mgon();
	level.r_tank[0] setTurretTargetEnt(tanktarget, (0,0,0) );
	wait 1.25;
	level.r_tank[0] thread maps\_panzerIV_gmi::fire();
	wait 1.25;
	level.r_tank[0] thread maps\_panzerIV_gmi::fire();
}