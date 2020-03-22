//Noville
//Edited by: JoeC
//
//Task List
//---------


//-should check in alamo wave 3 if it's safe to spawn
// guys. ie. don't spawn unless enemies died down.
// also have guys stop and take cover then go or waittill it's safe

// maybe let guys get into house easier (esp. east wing), currently too many guys in god
// mode protecting player(anderson, moody, foley)

// have tanks destroy the destroyed buildings

// check in chateau, east wing blows up should kill guy and player and also 
// become an exterior ambient

// tank on street not always dying. must enforce.


//Log


#using_animtree("generic_human");

main()
{
	setCullFog (0, 6000, .4078, .4980, .6549, 0 );
	//setCullFog (500, 6000, .9568, .9843, 1, 0 );

	maps\_load_gmi::main();
	maps\noville_fx::main();
	maps\noville_anim::main();
	maps\_debug_gmi::main();
	maps\_treadfx_gmi::main();	
	maps\_sherman_gmi::main();
	maps\_panzeriv_gmi::main();
	maps\_panzeriv_gmi::main_camo();
	maps\_tiger_gmi::main_snow();
	maps\_panzer_gmi::main();
	maps\_halftrack_gmi::main();
	maps\_treefall_gmi::main();
	maps\_p47_gmi::main();
	maps\noville_dummies::main();	

	
	level thread Setup_Characters();
	level thread Setup_Low_Spec();
//	level thread start_weapon_control();

	// debug stuff
	if(getcvar("skipto_chateau") == "")
	{
		setcvar("skipto_chateau","0");
	}
	
	level thread Objectives();
	level thread Objective_1_check();
	level thread Objective_2_check();
	level thread Objective_3_check();
	
	if(getcvar("skipto_chateau") != 1)
	{
		level thread tank_setup();
		level thread walkies();
		level thread Event2();	// event2 functions
	}


	level thread Event1_boundary();

	// When a friendly AI spawns in to catch up to squad, he will run this THREAD.
	level thread Friendly_Respawner_Setup();
	level thread Event3_tank_death();
	level thread Event3_dialog();
	level thread Event3_boundary();

	level thread sign_anim_loop();
		
	//chateau
	level thread chateau_dialog();
	level thread alamo_battle();
	level thread alamo_door();
	level thread alamo_corner_ambient();
//	level thread bazooka_setup();
	level thread music();

	//drones
	level thread drone_control();
	

//	MikeD: Colored syntax for future prints.
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

	//global
	level.mortar = loadfx ("fx/explosions/artillery/pak88_snow.efx"); // loads the fx file mortars
	level.mortar_low = loadfx ("fx/explosions/artillery/pak88_snow_low.efx");

	level.mortar_quake = 0.5;	// sets the intensity of the mortars
	level.mortar_mindist = 660;
	level.mortar_maxdist = 2000;
	level.mortar_random_delay = 15;

	// Limit of respawning friendlies.
	level.friendlies = 4;
	//event 2 stuff
	level.blow_basement = 0;
	//finale - indicates finale begun
	level.finale = 0;

	//sound for explosion events. - temp
	level.scr_sound["building_explode"] = "shell_explosion1";

	level.p47_bomb = loadfx("fx/explosions/vehicles/p47_bomb_snow.efx");	
	level.p47_bomb_low = loadfx("fx/explosions/vehicles/p47_bomb_snow_low.efx");



	// to fix script error
	precachemodel("xmodel/vehicle_tank_panzeriv_machinegun");

	// MikeD: Need to precache the bomb model.
	precacheModel("xmodel/explosivepack");
	precachemodel("xmodel/vehicle_tank_PanzerIV_camo");
	precachemodel("xmodel/vehicle_tank_PanzerIV_d");
	precachemodel("xmodel/v_us_lnd_sherman_snow");
	precachemodel("xmodel/v_us_air_p47");

	precacheModel("xmodel/ammo_panzerfaust_box2");
	precacheModel("xmodel/weapon_panzerfaust");

	precacheitem("colt");
	precacheItem("panzerfaust");


	// for lmg
	animscripts\lmg_gmi::precache();
	
	// Ambient sounds
	level.ambient_track ["exterior"] = "ambient_noville_ext";
	level.ambient_track ["interior"] = "ambient_noville_int";
	thread maps\_utility_gmi::set_ambient("exterior");

	// delete garbage
	garbage = getentarray("garbage", "targetname");
	for(i=0; i < garbage.size; i++)
	{
		// to prevent potential infinite loop
		wait(0.05);
		garbage[i] delete();
	}

	if(getcvar("skipto_chateau") == 1)
	{
		level thread skipTo_chateau();
	}
	
	//delete upstairs bazooka if not on greenhorn.
	if(getcvarint("g_gameskill") > 0)
	{
		bazooka = getent("easy_only", "targetname");
		bazooka delete();
	}


//	if(getcvarint("sv_cheats") > 0 )
//	{
//		wait 0.1;
//		//give player weapons
//		level.player giveWeapon("m1carbine");
//		level.player switchToWeapon("m1carbine");
//		level.player giveWeapon("colt");
//		level.player giveWeapon("fraggrenade");		
//	}
//	thread test();
}	

//test()
//{
//		thread	maps\_squad_manager::manage_spawners("delta", 2, 5,"wave1_over", 1, ::squad_init_stand);	//	4
//		thread	maps\_squad_manager::manage_spawners("alpha", 2, 5,"wave1_over", 1, ::squad_init_stand);	//	4
//
//}

Setup_Low_Spec()
{
	level waittill("finished intro screen");

	wait 1;

	println("^3 Low Spec Setup");
	println("^3----------------");

	if(getcvarint("scr_gmi_fast") > 0)
	{
		println("^3level.p47_bomb = level.p47_bomb_low");
		level.p47_bomb = level.p47_bomb_low;

		println("^3level.mortar = level.mortar_low");
		level.mortar = level.mortar_low;
	
		//turn off ambient fights at beginning
		println("^3no ambient fights");
		amb_fight = getent("special1", "script_noteworthy");
		amb_fight maps\_utility_gmi::triggerOff();
	}
}


Setup_Characters()
{
	// Foley
	character\Foley::precache();
	foley = getent("foley","targetname");
	foley.animname = "foley";
	foley character\_utility::new();
//	foley character\foley::main();
	foley character\Foley_winter::main();

	foley thread maps\_utility_gmi::magic_bullet_shield();
	level.foley = foley;

	// Anderson
//	character\Foley::precache();
	anderson = getent("anderson","targetname");
	anderson.animname = "anderson";
	anderson thread maps\_utility_gmi::magic_bullet_shield();
	level.anderson = anderson;

	// Moody
//	character\Moody::precache();
	character\moody_winter::precache();
	moody = getent("moody_intro","targetname");
	moody.animname = "moody";
	moody character\_utility::new();
//	moody character\moody::main();
	moody character\moody_winter::main();
	moody thread maps\_utility_gmi::magic_bullet_shield();
	level.moody = moody;
}

//take away player weapon while on tank
//start_weapon_control()
//{
//	wait 1; 
//	primary = level.player getWeaponSlotWeapon("primary");
//	primaryb = level.player getWeaponSlotWeapon("primaryb");
//	pistol = level.player getWeaponSlotWeapon("pistol");
//	grenade = level.player getWeaponSlotWeapon("grenade");
//		
//	level waittill("player_offtank");
//		 
//	level.player setWeaponSlotWeapon("primary", primary);
//	level.player setWeaponSlotWeapon("primaryb", primaryb);
//	level.player setWeaponSlotWeapon("pistol", pistol);
//	level.player setWeaponSlotWeapon("grenade", grenade);
//}


Event2()
{
	level thread Event2_artillery_death();
	level thread Event2_mortar();
	level thread Event2_basement();

	// move baker squad
	level thread second_squad2();
}


// move guys 
Event2_squad_move()	
{

	squad_guys = getentarray ("squad_guy", "targetname");
	nodes= getnodearray("meet_node", "targetname");
	
	for( n=0; n < squad_guys.size; n++)
	{
		//squad_guys[n].goalradius = 4;
		squad_guys[n] setgoalnode (nodes[n]);
	}

	level.foley waittill("goal");

	//save
	maps\_utility_gmi::autosave(1);

	//go to the house	
	house_node = getnode("house_node", "targetname");
	level.player setfriendlychain (house_node);

	// sets principals to follow player
	level.foley setgoalentity(level.player);
	level.anderson setgoalentity(level.player);
	
	wait 0.25;

	for(i=0;i<squad_guys.size;i++)
	{
		if(isalive(squad_guys[i]))
		{	
			squad_guys[i] setgoalentity(level.player); // makes ai follow player
		}
	}
}


Event2_mortar()
{
	// Setup instant mortars that are triggered by a brush. these are key mortars.
	instant_mortars = getentarray("instant_mortar","targetname");
	for(i=0;i<instant_mortars.size;i++)
	{
		instant_mortars[i] thread instant_mortar_trigger();
		if(isdefined(instant_mortars[i].script_noteworthy) && instant_mortars[i].script_noteworthy == "start the mortars")
		{
			trigger = instant_mortars[i];
		}
	}
		
	trigger waittill("trigger");
	println("mortars,mortars");

	// start random mortars
	mortars = getentarray("mortar","targetname");
	for(i=0;i<mortars.size;i++)
	{
		mortars[i] thread mortars();
	}
}

mortars()
{
	level endon ("stop falling mortars");
	maps\_mortar_gmi::setup_mortar_terrain();
	ceiling_dust = getentarray("ceiling_dust","targetname");

	while (1)
	{
		if ((distance(level.player getorigin(), self.origin) < level.mortar_maxdist) &&
			(distance(level.player getorigin(), self.origin) > level.mortar_mindist))
		{
//			println("MORTAR DELAY",level.mortar_random_delay);
			wait (1 + randomfloat (level.mortar_random_delay));			
			maps\_mortar_gmi::activate_mortar();
			if(isdefined(level._effect) && isdefined(level._effect["ceiling_dust"]))
			{
				for(i=0;i<ceiling_dust.size;i++)
				{
					if(distance(self.origin, ceiling_dust[i].origin) < 512)
					{
						playfx ( level._effect["ceiling_dust"], ceiling_dust[i].origin );
						ceiling_dust[i] playsound ("dirt_fall");
					}
				}
			}
			wait (level.mortar_random_delay);
		}

		wait (1);
	}
}

instant_mortar_trigger()
{
	self waittill("trigger");

	mortar = getent(self.target,"targetname");
	
	println("Instant Mortar Trigger");
	mortar instant_mortar();
}

instant_mortar (range, max_damage, min_damage, fQuakepower, iQuaketime, iQuakeradius)
{
	self instant_incoming_sound();

	level notify ("mortar");
	self notify ("mortar");

	if (!isdefined (range))
	{
		range = 256;
	}
	if (!isdefined (max_damage))
	{
		max_damage = 400;
	}
	if (!isdefined (min_damage))
	{
		min_damage = 25;
	}

	radiusDamage ( self.origin, range, max_damage, min_damage);

	if ((isdefined(self.has_terrain) && self.has_terrain == true) && (isdefined (self.terrain)))
	{
		for (i=0;i<self.terrain.size;i++)
		{
			if (isdefined (self.terrain[i]))
				self.terrain[i] delete();
		}
	}
	
	if (isdefined (self.hidden_terrain) )
	{
		self.hidden_terrain show();
	}
	self.has_terrain = false;
	
	self instant_mortar_boom( self.origin, fQuakepower, iQuaketime, iQuakeradius );
}

instant_mortar_boom (origin, fPower, iTime, iRadius)
{
println("^3*********Should not be here!!!!!*****************");
println("^3*********Should not be here!!!!!*****************");
println("^3*********Should not be here!!!!!*****************");
	if(isdefined(level.mortar_quake))
	{
		fpower = level.mortar_quake;
	}
	else
	{ 
		if(!isdefined(fPower))
		{
			fPower = 0.15;
		}
	}

	if (!isdefined(iTime))
	{
		iTime = 2;
	}
	if (!isdefined(iRadius))
	{
		iRadius = 850;
	}

	self instant_mortar_sound();

	if (isdefined(self.script_noteworthy))
	{
		if(self.script_noteworthy != "no_fx")
		{
			playfx(level.mortar, origin );
		}
		else if (isdefined (self.script_exploder))
		{
			self thread maps\_utility_gmi::exploder(self.script_exploder);
		}
	}
	else
	{
		playfx(level.mortar, origin );	
	}

	earthquake(fPower, iTime, origin, iRadius);

	ceiling_dust = getentarray("ceiling_dust","targetname");
	for(i=0;i<ceiling_dust.size;i++)
	{
		if(distance(self.origin, ceiling_dust[i].origin) < 512)
		{
			playfx ( level._effect["ceiling_dust"], ceiling_dust[i].origin );
			ceiling_dust[i] playsound ("dirt_fall");
		}
	}
}

instant_mortar_sound()
{
	if (!isdefined (level.mortar_last_sound))
	{
		level.mortar_last_sound = -1;
	}

	soundnum = 0;
	while (soundnum == level.mortar_last_sound)
	{
		soundnum = randomint(3) + 1;
	}

	level.mortar_last_sound	= soundnum;

	if (soundnum == 1)
	{
		self playsound ("shell_explosion1");
	}
	else if (soundnum == 2)
	{
		self playsound ("shell_explosion2");
	}
	else
	{
		self playsound ("shell_explosion3");
	}
}

instant_incoming_sound(soundnum)
{
	if (!isdefined (soundnum))
	{
		soundnum = randomint(3) + 1;
	}

	if(isdefined(level.ambient) && level.ambient == "interior")
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


objectives()
{

	// ref file in stringEd, and give coord for compass
	//Clear Houses.
	objective_add(1, "active", &"GMI_NOVILLE_OBJECTIVE_1", (544, -560, 128));
	objective_current(1);
	level waittill("objective_1_complete");	
	objective_state(1,"done");

	//Rendezvous at the Chateau.
	objective_add(2, "active", &"GMI_NOVILLE_OBJECTIVE_2", (250,5500,100));
	objective_current(2);
	level waittill("objective_2_complete");	
	objective_state(2,"done");

	//Clear Chateau.
	objective_add(3, "active", &"GMI_NOVILLE_OBJECTIVE_3", (-714, 6946, 468));
	objective_current(3);
	level waittill("objective_3_complete");	
	objective_state(3,"done");

	//Protect South Flank.
	objective_add(4, "active", &"GMI_NOVILLE_OBJECTIVE_4", (-560, 7000, 468));
	objective_current(4);
	level waittill("objective_4_complete");	
	objective_state(4,"done");

	//Protect North Flank.
	objective_add(5, "active", &"GMI_NOVILLE_OBJECTIVE_5", (175, 7046, 230));
	objective_current(5);
	level waittill("objective_5_complete");	
	objective_state(5,"done");

	//Protect Third Squad and Sgt. Moody.
	objective_add(6, "active", &"GMI_NOVILLE_OBJECTIVE_6", (-162, 5495, 136));
	objective_current(6);
	level waittill("objective_6_complete");	
	objective_state(6,"done");

	//Defend Chateau.
	objective_add(7, "active", &"GMI_NOVILLE_OBJECTIVE_7", (-230, 7090, 230));
	objective_current(7);
	level waittill("objective_7_complete");	
	objective_state(7,"done");

	//Regroup with Cpt. Foley.
	objective_add(8, "active", &"GMI_NOVILLE_OBJECTIVE_8", (30, 7280, 230));
	objective_current(8);
	level waittill("objective_8_complete");	
	objective_state(8,"done");

}

// checks for objective to be completed
objective_1_check()
{
	//breadcrumbs
	update = getent ("objective1_update", "targetname");
	update waittill ("trigger");
	objective_position (1,(728, 2936, 188));

	// using an area trigger
	check = getent ("objective_1_complete", "targetname");
	println ("^3-=>", check.targetname);

	check waittill ("trigger");
	
	println ("^3 objective_1_complete");
	level notify ("objective_1_complete");
	
	//send message to end mortars
	level notify ("stop falling mortars");

	//save after basement
	maps\_utility_gmi::autosave(5);

}

objective_2_check()
{
	// using an area trigger
	check = getent ("objective_2_complete", "targetname");
	println ("^3-=>", check.targetname);

	check waittill ("trigger");
	
	println ("^3 objective_2_complete");
	level notify ("objective_2_complete");
	
	//Drive ‘em back!
	level.foley anim_single_solo(level.foley, "foley_drive_em_back");		
//	level.foley playsound("foley_drive_em_back");

		//save at chateau
	maps\_utility_gmi::autosave(6);

	//move to side of house before mg34	
	trigger = getent("alamo_wave3", "targetname");
	trigger waittill("trigger");

	//temp dialog Foley:"That must be their C.P. keep moving boys we have to take this building!"
	level.foley thread anim_single_solo(level.foley, "foley_cp");
}

objective_3_check()
{
	// using an area trigger
	check = getent ("objective_3_complete", "targetname");
	println ("^3-=>", check.targetname);

	check waittill ("trigger");
	
	println ("^3 objective_3_complete");
	level notify ("objective_3_complete");
}


objective_4_check()
{

	println ("^3 objective_4_complete");
	level notify ("objective_4_complete");
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

tank_setup() 
{ 
     	for(i=1;i<4;i++) 
     	{ 
		squad = getentarray("squad" + i, "groupname"); 
          	tank = getent("sherman_tank" + i, "targetname"); 
		
		new_squad = [];
		
		//grab only ai not spawners
		for(n=0;n<squad.size;n++)
		{
			if(issentient(squad[n]))
			{
				println("adding ai "+ i + "to array");
				new_squad[new_squad.size] = squad[n];
			}
		}

		if(new_squad.size > 0)
		{
			squad = new_squad;
		}

		//attach to tank
		level thread maps\_sherman_gmi::attach_guys(tank, squad); 
     	} 
 
	tank2 = getent("sherman_tank2","targetname"); 
	                 
	// create a script_origin on fly 
	tank2.player_origin = spawn("script_origin", (level.player.origin)); 


	//attach player
	level.player linkto(tank2.player_origin); 

	// get the player position on tank  
	pos1 = tank2 gettagorigin("tag_guy03"); 
	tank2.player_origin moveto(pos1,0.05); 
	tank2.player_origin waittill("movedone");

	tank2.player_origin linkto(tank2); 
	
	level thread tank_move();
	
	level waittill ("starting final intro screen fadeout");

	//start foley speech and anim
	tank2 thread maps\_sherman_gmi::force_anim(4,"foley_brief");
	tank2 thread maps\_sherman_gmi::force_anim(1,"trooper1_dinner");

}

//tank drives down street

tank_move()	
{
	for (i=1; i < 4; i++)
	{
		tank = getent("sherman_tank" + i, "targetname");
		tank thread maps\_sherman_gmi::init();
			
		// lets tanks get closer to each other	
		tank.coneradius = 100;
				
		start_node = getvehiclenode("sherman_tank" + i + "_start", "targetname");
		tank attachPath(start_node);
		tank startPath();

		// unload tank
 		tank thread Event1_tank_think();
	}

	level thread Event2_tank_death1();
	
	// Temp Intro
//	iprintlnbold(&"GMI_NOVILLE_TEMP_INTRO_PT1");
	
	println("^5 FOLEY Speaking");

	//Listen up, guys – listen up! Noville’s had bad weather for the past two weeks, so we have no aerial recon. 
	//That means we don’t have a damn clue what the German’s have got up there – so we gotta watch each other’s backs.
//	level.foley thread anim_single_solo(level.foley, "foley_brief1");
//	level.foley playsound ("foley_brief1");
	wait 13;

	//Once we’ve got boots on the ground, we split up and go house-to-house.
	//I’ll be with First Squad -- going straight up the middle of the road.
//	level.foley thread anim_single_solo(level.foley, "foley_brief2");

//	level.foley playsound ("foley_brief2");
	wait 8;

	//Second Squad will come in from the left.  And Sergeant Moody will take third squad -- flanking right.
	// There’s a Chateau just west of town.  Rendezvous there.  Any questions?
//	level.foley thread anim_single_solo(level.foley, "foley_brief3");
//	level.foley playsound ("foley_brief3");
	wait 11;

	//Sir, do we get our dinner there?!
//	level.anderson playsound("trooper1_dinner");
	wait 3;
	
	// (off laughter) If you’re cookin’, Anderson.  (off more laughter) Alright first squad -- follow me!
//	level.foley anim_single_solo(level.foley, "foley_letsgo");		
//	level.foley playsound ("foley_letsgo");
//	wait(6.5);

	
	 // get trigger to start tanks again
	tank_move = getent("tanks_go", "targetname");
	tank_move waittill ("trigger");
	level notify ("tanks_go");
	println("tanks go!!!");
}

//makes starting guys walk
walkies()
{
	walkers = getentarray("walkers", "targetname");
	for (i=0; i < walkers.size; i++)
	{
		walkers[i] allowedstances("stand");
		walkers[i].pacifist = 1;
		walkers[i].goalradius = 0;
		walkers[i].walkdist = 9999;
		patrolwalk[0] = %patrolwalk_bounce;
		patrolwalk[1] = %patrolwalk_tired;
		patrolwalk[2] = %patrolwalk_swagger;
		//walkers[i].walk_noncombatanim_old = walkers[i].walk_noncombatanim;
		//walkers[i].walk_noncombatanim2_old = walkers[i].walk_noncombatanim2;
		walkers[i].walk_noncombatanim = maps\_utility_gmi::random(patrolwalk);
		walkers[i].walk_noncombatanim2 = maps\_utility_gmi::random(patrolwalk);
		//self animscriptedloop("scripted_animdone", self.origin, self.angles, self.walk_noncombatanim);
	}

	level waittill("squad3_unload");
	for (i=0; i < walkers.size; i++)
	{ 
		walkers[i].pacifist = false;
		walkers[i] allowedstances("stand","crouch","prone");
		walkers[i].walk_noncombatanim = walkers[i].walk_noncombatanim_old;
		walkers[i].walk_noncombatanim2 = walkers[i].walk_noncombatanim2_old;
		walkers[i].walkdist = 0;
		walkers[i].goalradius = 8;
	}
}	


// tells each tank to stop and unload
Event1_tank_think()
{
	// self from tank_move()
	node = getvehiclenode(self.targetname + "_unload","targetname");

	self setWaitNode(node);
	self waittill ("reached_wait_node");
	self setspeed (0, 5);	
	wait 0.5;
	self notify("unload");
	self disconnectpaths();

	if(self.targetname == "sherman_tank2")
	{
		level thread Event2_squad_move();
		
		// pause to let player synch up with squad
		wait 3.5;

		// unlink script_origin
		self.player_origin unlink();

		// move player to spot to the side, simulate jumping off
		self.player_origin moveto((-85,-1490,39),0.5); 
		self.player_origin waittill("movedone"); 
		
		level.player unlink();
		level notify("player_offtank");
		self.player_origin delete();
		
		//wait and thread tank turret turning
		println("^3 Turret should be turning");
		self thread Tank_Turret_Random_Turning();


		// tank moving again
		level waittill ("tanks_go");
		println("tanks move");
		self resumespeed (10000);
	}
	
	if(self.targetname == "sherman_tank3")
	{
		level notify("squad3_unload");
		
		// get the goalnodes for squad
		goal_node = getnode ("squad3_event1_goal", "targetname");
		squad = getentarray("squad3", "groupname");
		for( i=0; i < squad.size; i++)
		{
			squad[i].goalradius = 4;
			squad[i] setgoalnode (goal_node);
			squad[i] thread Event1_delete();
		}

		//wait and thread tank turret turning
		wait(3);
		println("^3 Turret should be turning");
		self thread Tank_Turret_Random_Turning();	

		// tank moving again
		
		level waittill ("tanks_go");
		println("tanks move");
		self resumespeed (10000);
	}

	if(self.targetname == "sherman_tank1")
	{
		// get the goalnodes for squad

		goal_node = getnode ("squad1_event1_goal", "targetname");
		squad = getentarray("squad1", "groupname");
		for( i=0; i < squad.size; i++)
		{
			squad[i].goalradius = 4;
			squad[i] setgoalnode (goal_node);
			squad[i] thread Event1_delete();
		}

		wait(3);
		println("^3 Turret should be turning");
		self thread Tank_Turret_Random_Turning();

		// tank moving again
		level waittill ("tanks_go");
		println("tanks move");
		self resumespeed (10000);
		
		//stop tank again before 1st street fight

		fight_node = getvehiclenode("street_fight1","targetname");
		self setWaitNode(fight_node);
		self waittill ("reached_wait_node");
		self setspeed (0, 5);

		// fire a shell

		// Get Script_Origins for the tanks target.	
		origins = getentarray("chateau_target", "targetname");
		for(n=0;n<origins.size;n++)
		{
			origins[n].non_living = true;
		}
		self thread Tank_Add_Targets(origins);

		// Start the TURRET THINK for the TANK.
		self thread Tank_Turret_Think(undefined, undefined, true);
		
		// start it up again when wall blown away
		tank_move = getent("street_fight1_trigger", "targetname");
		tank_move waittill ("trigger");	

		wait(2);

		self resumespeed (10000);
	}
	
}

Event1_boundary()
{
	//boundary_intro trigger
	trigger = getent("boundary_intro", "targetname");
	trigger maps\_utility_gmi::triggerOff();

	level waittill("player_offtank");

	trigger maps\_utility_gmi::triggerOn();
	trigger waittill("trigger");

	//mission fail - insubordination
	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
	missionFailed();
}

Event1_delete()
{
	//self is squad[i] from Event1_tank_think()
	self waittill ("goal");
	self delete();
}

// Two of the Sherman tanks get destroyed

Event2_tank_death1()
{
	//tanks need to be in position, play animation of turrets while tanks waiting.
	
	//player crosses trigger
	death = getent ("tank_death1", "targetname");
	death waittill ("trigger");

	// gets tank and insures death	
	tank2 = getent ("sherman_tank2", "targetname");
	tank2.health = 100;
	
	// use mortar to kill tank
	tank2 thread instant_mortar();
	
	// pause before next tank
	wait 2;
	//put foley line 
	//Artillery! Take cover!
	level.foley anim_single_solo(level.foley, "foley_zeroed");
//	level.foley playsound("foley_zeroed");

	//Take the next building! Move!
	level.foley anim_single_solo(level.foley, "foley_next_building");

//	level.foley playsound("foley_next_building");
//	wait 2;

	// 2nd tank dies
	tank3 = getent ("sherman_tank3", "targetname");
	tank3.health = 100;

	tank3 thread instant_mortar();
	println("^3tank3 should blow!!!!!!!!");
	
	wait 2;

	//save
	maps\_utility_gmi::autosave(2);

	//extend artillery strike
	mortars = getentarray("first_strike", "targetname");
	println("^3mortars size ", mortars.size);

	for(i=0; i < mortars.size; i++)
	{
		println("^3!!!!first_strike!!!!!!!!");
		mortars[i] thread instant_mortar();
		wait(2.3);
	}

	//kill player if he's outside
	level notify("start_mortars");
	println("^3start_mortars");

}

Event2_artillery_death()
{
	level waittill("start_mortars");

	trigger = getent("mortar_kill", "targetname");
	trigger waittill ("trigger");
	println("^mortar_kill triggered!!!");
	wait 0.5;
	playfx (level.mortar,level.player.origin);
	earthquake(0.5, 3, level.player.origin, 1000);
	level.player playsound ("shell_explosion1");
	wait 0.5;
	level.player dodamage(level.player.health + 100, (0,0,0));
	
	println("^1Killing player (hit death brush)");
}

ambient_fight_delete()

{ 
	for(n=1; n<3;n++)
	{
		ambient_fighters = getentarray("ambient_fight"+n, "groupname");

		for (i=0; i < ambient_fighters.size; i++)
		{
			ambient_fighters[i] delete();
		}
	}

}

//dialog on street
Event3_dialog()
{
	trigger = getent("street_chain_trigger", "targetname");
	trigger waittill("trigger");
	
	//Move up the street! Don’t stop now!
	level.foley anim_single_solo(level.foley, "foley_up_street");		

//	level.foley playsound("foley_up_street");
//	wait 4;

	//send them into next room
	chain = getnode("street_chain", "targetname");
	level.player setfriendlychain(chain);

	tank_trigger = getent("trigger_lastleg", "targetname");
	tank_trigger waittill ("trigger");
	
	//Keep advancing! Go!
	level.foley anim_single_solo(level.foley, "foley_keep_advancing");		
 
//	level.foley playsound("foley_keep_advancing");
}


// germans panzerfaust tank before chateau
Event3_tank_death()
{
	tank_spawner = getent("event3_tank_trigger", "targetname");
	tank_spawner waittill ("trigger");
	
	// spawn tank 
	tank = spawnVehicle("xmodel/v_us_lnd_sherman_snow", "dead_tank", "ShermanTank" ,(0,0,0), (0,0,0) );
	tank thread maps\_sherman_gmi::init();

	start_node = getVehicleNode ("Event3_start", "targetname");
	
	tank attachPath (start_node);
	tank startPath();

	tank thread Tank_Turret_Random_Turning();	

	// sets up rollingdeath
	tank.rollingdeath = 1;

	// wait until node is reached
	lastlegNode = getVehicleNode ("lastleg_start", "targetname");
	tank setwaitnode(lastlegNode);
	tank waittill ("reached_wait_node");
	tank setspeed (0, 5);	

	// let battle go on for set amount of time
	// fire another shell and miss chateau?
	wait(5);

	// tank wait till plyr crosses trigger
	tank_trigger1 = getent("tank_death", "targetname");
	tank_trigger1 waittill ("trigger");
	println("^1tank_death triggered!!!");

	tank resumespeed(100);

	// define specific node	
	death_node = getvehiclenode("tank_death_node", "targetname");
		
	// wait until node is reached
	tank setwaitnode(death_node);
	tank waittill ("reached_wait_node");
		
	// set in motion tank crashing into wall later
	tank thread event3_tank_crash_think();

	// defines the guy
	tank_killer = getent("tank_killer", "targetname"); 
	if(!isdefined(tank_killer))
	{
		println("^1tank_killer is not defined!!!");
	}
	//spawns the guy
	tk_guy = tank_killer stalingradspawn();
	wait 0.05;

	// makes guy ignore enemies
	tk_guy.pacifist = true;
 
	// makes guy invulnerable
	tk_guy thread maps\_utility_gmi::magic_bullet_shield();
	println("tank_killer spawned");
	wait .25;
	
	// make guy shoot thru window
	guy_fire = getnode("window", "targetname");
	
	tk_guy.goalradius = 1;
	tk_guy setgoalnode(guy_fire);
		
	tk_guy waittill ("goal");
	println("tank_killer is at window");
	
	// get pos of tank death
	death = getent("tank_death2", "targetname");
	targ_pos = (death.origin);

	// weaken tank
	tank.health = 50;

	//open shutters
	level thread Event3_shutters_open();

	println("^5 tank health is ", tank.health);
	// allow ai to shoot while moving, set waitforstop to true
	// FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop)
	tk_guy animscripts\combat_gmi::fireattarget(targ_pos, 3, undefined, undefined, undefined, true);
	println("tank_killer fired!!");

	//insure tank dead
	while(tank.health > 0)
	{
		println("^3tank health is " + tank.health);
		//dodamage wasn't working on tank.origin -- using radiusdamage
		radiusdamage(death.origin, 128, 100, 100);
		println("^2tank health set to" + tank.health);
		wait 0.05;
	}

	println("^3tank health should be 0, is it" + tank.health);

	//play tank broken sound
	tank playsound ("sherman_die_long");

	//panzerschrek!
	level.foley playsound("foley_panzerschreck");
	
	//make guy normal	
	tk_guy notify ("stop magic bullet shield");
	wait 5;
	tk_guy.pacifist = false;
}


Event3_shutters_open()
{
	wait 2.1;		

	//open shutters
	l_shutter = getent("left_shutter", "targetname");	
	r_shutter = getent("right_shutter", "targetname");
	
	l_shutter rotateyaw(-90,.25,.25,0);
	r_shutter rotateyaw(90,.25,.25,0);

	l_shutter playsound ("shutter_open");
	println("shutters opening");	
}


Event3_tank_crash_think()
{
	// tank crashes into chateau
	wall_break = getvehiclenode ("wall_break_node", "targetname");
	
	// self = tank from tank()
	self setwaitnode(wall_break);
	self waittill ("reached_wait_node");
	println ("Tank is at wall");
	wait .25;
		
	// sets off anything script_exploder = 5. make sure tank crash is 5
	maps\_utility_gmi::exploder (5);
}

//in case player tries to go back up street
Event3_boundary()
{
	trigger = getent("boundary_street", "targetname");
	trigger waittill("trigger");

	//mission fail - insubordination
	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
	missionFailed();

	//put in magic bullet hit
//	MagicBullet( "mp40", origin, playerPos );
//	MagicBullet( "mp40", -216 3056 128, level.player.origin  );

//	level.player DoDamage ( level.player.health + 50, level.player.origin );
}

chateau_dialog()
{
	//upon entering chateau in kitchen
	trigger = getent("enter_chateau", "targetname");
	trigger waittill("trigger");
	
	level notify("entering_kitchen");

	//kill mg42 guy in window
	guy = getentarray("chateau_mg42", "groupname");
	for (i=0; i < guy.size;i++)
	{
		if(isalive(guy[i]))
		{
			guy[i] dodamage(guy[i].health + 50, guy[i].origin);
			println ("^3mg42guy is dead!!!");
		}
	}	

	//send guys to nodes
	f_mark = getnode("foley_mark_kitchen", "targetname");
	a_mark = getnode("anderson_mark_kitchen", "targetname");

	level.foley setgoalnode(f_mark);
	level.anderson setgoalnode(a_mark);

	level.anderson waittill("goal");

	//player must be near
	kitchen_trigger = getent("kitchen_trigger", "targetname");
	kitchen_trigger waittill("trigger");

	//Damn...champagne, Cap!
	level.anderson anim_single_solo(level.anderson, "anderson_champagne");		

//	level.anderson playsound("anderson_champagne");
//	wait 3;//remove

	//We’ll celebrate later. Leave it! 
	level.foley anim_single_solo(level.foley, "foley_celebrate_later");		
	
//	level.foley playsound("foley_celebrate_later");
//	wait 2;//remove
//	should autosave here

	//send them into next room
	chain = getnode("library_chain", "targetname");
	level.player setfriendlychain(chain);
	wait .25;

	//put guys back on chain
	level.foley setgoalentity(level.player);
	wait 0.5;
	level.anderson setgoalentity(level.player);

	//german chatter 
	german = spawn("script_origin",(-224, 6606, 230));

	german playsound("generic_misccombat_german_1");
	wait 2;
	german playsound("generic_misccombat_german_2");
}

second_squad1_delete()
{
	
	// delete second_squad1 when player is out of range 

	second = getentarray ("second_squad1", "groupname");
	for (i=0; i < second.size; i++)
	{
		 second[i] delete();
	}

}

second_squad2()
{
	// move 2nd squad closer to chateau then delete
	
	//trigger to move
	move_trigger = getent("squad2_move_trigger", "targetname");
	move_trigger waittill ("trigger");
	println ("second_squad2 moving up");
	wait .25;
	
	// get the guys	
	second = getentarray ("second_squad2", "groupname");

	// fix by MD
	second_ai = [];
	for(i=0;i<second.size;i++)
	{
		if(issentient(second[i]))
		{
			second_ai[second_ai.size] = second[i];
		}
	}

	println("^SECOND_AI SIZE : ", second_ai.size);
	// get the goalnodes
	second_nodes = getnodearray ("second_squad2_move", "targetname");
	println("^5SECOND_NODES SIZE : ", second_nodes.size);

	// move them by setting goalnodes
	for (i=0; i < second_ai.size; i++)
	{
		if(isalive(second_ai[i]))
		{
			second_ai[i] setgoalnode (second_nodes[i]);
		}
	}

}

second_squad2_delete()
{
	
	// delete second_squad2 when player is out of range 
	println("^3 second_squad2 should be deleted");

	second = getentarray ("second_squad2", "groupname");
	for (i=0; i < second.size; i++)
	{
		 second[i] delete();
	}

	//cleanup
	enemy = getaiarray("axis");
	if(enemy.size != 0)
	{
		for (j=0; j < enemy.size; j++)
		{
			wait 0.05; 
			enemy[j] delete();
		}
	}
}


Event2_basement()
{
	// hide wall that traps group
	basement_trap = getent("basement_trap", "targetname");
	basement_trap notsolid();
	basement_trap hide();
	basement_trap connectpaths();

	bomb = getent("bomb_model", "targetname");
	bomb hide();
	
	//autosave before basement
	trigger = getent("pre_basement","targetname");
	trigger waittill("trigger");
	maps\_utility_gmi::autosave(3);

	// guys are going to basement
	friendly_trigger = getent("goto_basement", "targetname");
	friendly_trigger waittill ("trigger");

	//Fall back!  Get down those stairs!
	level.foley anim_single_solo(level.foley, "foley_fall_back");

	node = getnode("anderson_mark_basement", "targetname");
	level.anderson setgoalnode(node);
	level.anderson.player_push = true;
	level.anderson pushPlayer(true);
	
	node = getnode("foley_mark_basement", "targetname");
	level.foley setgoalnode(node);	
	level.foley.player_push = true;
	level.foley pushPlayer(true);

//	level.foley playsound("foley_fall_back"); 

	squad_guys = getentarray ("squad_guy", "targetname");

	// add foley to the array
	squad_guys = maps\_utility_gmi::add_to_array(squad_guys,level.foley);

	// add anderson to the array	
	squad_guys = maps\_utility_gmi::add_to_array(squad_guys,level.anderson);

	for(i=0;i<squad_guys.size;i++)
	{
		squad_guys[i] thread Event2_basement_counter();
	}
}	

Event2_basement_counter()
{
	// MAY NEED DEATH FUNCTION IF GUYS GET KILLED

	// self is squad_guys[i] from Event2_basement()
	// goalradius needs to be small to insure guys are on node
	self.og_goalradius = self.goalradius; //gets the goal radius
	self.goalradius = 8;	//sets to 8 until node reached
	self waittill ("goal");
	self.goalradius = self.og_goalradius;	//set back to original

	level.blow_basement++;
	
	// check if team is alive
	squad_guys = getentarray ("squad_guy", "targetname");
	
	// add foley to the array
	squad_guys = maps\_utility_gmi::add_to_array(squad_guys,level.foley);
	
	// add anderson to the array	
	squad_guys = maps\_utility_gmi::add_to_array(squad_guys,level.anderson);	

	total_guy_count = 0;
	for(i=0;i<squad_guys.size;i++)
	{
		if(isalive(squad_guys[i]))
		{
			total_guy_count++;
		}
	}
	println ("alive guys = ", total_guy_count);
	
	if( total_guy_count == level.blow_basement)
	{
		println("^2player not in trigger");

		// patch bug fix, insure player is in basement
		basement_trigger = getent("basement_trigger", "targetname");
		basement_trigger waittill ("trigger");
		println("^3player in trigger");
		level thread Event2_basement_blow();
	}
	
}


Event2_basement_blow()
{	
	// trigger basement event
	basement_trigger = getent("basement_trigger", "targetname");
	basement_trigger waittill ("trigger");

	//so player can't get out
	basement_trap = getent("basement_trap", "targetname");
	basement_trap solid();

	//thread guys grabbing helmets or associated with mortars

	// get script origin and thread instant mortar
	mortar = getent("basement_mortar", "targetname");
	mortar instant_mortar();	
	
	// blow up trap
	maps\_utility_gmi::exploder (6);
	level thread event2_basement_flinch();

	// wall behind collapses
	basement_trap show();
	basement_trap disconnectpaths();
	
	// delete ambient_fight and tank for sound reasons
	level thread ambient_fight_delete();
	level thread second_squad1_delete();
	
	tank = getent("sherman_tank1", "targetname");
		
	if(isdefined(tank.mgturret))
	{
		tank.mgturret delete();
		println("turret deleted");
	}

	tank delete();

	mortar = getent("basement_mortar2", "targetname");
	
	level notify("basement_trap");	
	
	wait 2;

	//anderson and foley anims
	level thread Event2_basement_anim();

	// more explosions
	mortar instant_mortar();
	level thread event2_basement_flinch();

	wait 4;

	// more explosions
	mortar instant_mortar();	
	
	wait 2;

	//anderson plants bomb
	level thread event2_basement_bomb();

	// more explosions
	mortar instant_mortar();

	//move guys into spots
	level.foley setgoalentity(level.player);
	chain = getnode("post_plant_chain", "targetname");
	level.player setfriendlychain(chain);

	// more explosions
	mortar instant_mortar();

	wait 2;

	mortar instant_mortar();

	wait 1.5;

	mortar instant_mortar();

//	// guy should run to node
//	// should get his goalradius and reset later
//	level.anderson.goalradius = (8);
//	level.anderson setgoalnode (getnode("bombnode","targetname"));
//	println ("anderson to wall");
//
//	//level waittill ("goal");
//	wait 2;
//
//	// plant bomb
//
//	bombs = getentarray ("bomb", "targetname");
//	for (i=0;i<bombs.size;i++)
//	{
//		bombs[i] show();
//	}
//
//	wait 1;
//	// guy should take cover
//	
//	level.anderson setgoalnode (getnode("bomb_cover","targetname"));
//	wait 3;
//
//	// temp explosion
//	maps\_utility_gmi::exploder (1);
//
//	// get rid of bombs
//	bombs = getentarray ("bomb", "targetname");
//	for (i=0;i<bombs.size;i++)
//	{
//		bombs[i] delete();
//	}
//
//	level.anderson setgoalentity(level.player);
//
//	// spawn germans 
//	level thread spawn_enemies();
}

event2_basement_flinch()
{
	println ("^2flinch threaded!!!");

	squad_guys = getentarray ("squad2", "groupname");

	println("squad size ", squad_guys.size);
	for(i=0;i<squad_guys.size;i++)
	{
		if(isalive(squad_guys[i]))  
		{		
//			if(squad_guys[i].targetname == "foley"  || squad_guys[i].targetname == "anderson" || isdefined(squad_guys[i]))
			if(isdefined(squad_guys[i].targetname))
			{
				println ("^2foley or anderson!!!");
			}
			else
			{
				squad_guys[i] thread event2_basement_flinchAnim();
			}
		}
	}
}

event2_basement_flinchAnim()
{
	self.animname = "foley";
	self anim_single_solo(self, "stand2flinch");		
	self thread anim_single_solo(self, "flinchloop");
}

event2_basement_bomb()
{
	node = getnode ("bombnode","targetname");
	level.anderson.goalradius = 4;
	level.anderson setgoalnode(node);
	level.anderson waittill("goal");

	level thread event2_basement_hack();
	
	//play bomb plant anim
	level.scr_anim["anderson"]["anderson_bomb"]			= (%c_us_noville_anderson_satchel);
//
//	level.scr_notetrack["anderson"][0]["notetrack"]		= "attach bomb = \"left\"";
//	level.scr_notetrack["anderson"][0]["attach model"]		= "xmodel/explosivepack";
//	level.scr_notetrack["anderson"][0]["selftag"]			= "tag_weapon_left";
//	level.scr_notetrack["anderson"][0]["anime"]			= "anderson_bomb";
//
//	level.scr_notetrack["anderson"][1]["notetrack"]		= "detach bomb = \"left\"";
//	level.scr_notetrack["anderson"][1]["detach model"]		= "xmodel/explosivepack";
//	level.scr_notetrack["anderson"][1]["selftag"]			= "tag_weapon_left";
//	level.scr_notetrack["anderson"][1]["anime"]			= "anderson_bomb";
//
//	level.scr_notetrack["anderson"][2]["notetrack"]		= "plant bombs = \"left\"";
//	level.scr_notetrack["anderson"][2]["create model"]		= "xmodel/explosivepack";
//	level.scr_notetrack["anderson"][2]["detach model"]		= "xmodel/explosivepack";
//	level.scr_notetrack["anderson"][2]["selftag"]			= "tag_weapon_left";
//	level.scr_notetrack["anderson"][2]["anime"]			= "anderson_bomb";

	level.anderson anim_single_solo(level.anderson, "anderson_bomb");
	
	//take cover
	level.anderson setgoalnode (getnode("bomb_cover","targetname"));
	level.anderson waittill("goal");
	wait 1;

	//explosion
	maps\_utility_gmi::exploder (1);

	bomb = getent("bomb_model", "targetname");
//	radiusDamage ( self.origin, range, max_damage, min_damage)
	radiusdamage(bomb.origin, 128, 1000, 350);
	earthquake(0.25, 2, bomb.origin, 1050);

	println("^3bomb should do damage!!!!");
	
	//delete bomb
	bomb delete();		

//	guy[0] = level.anderson;
//	
//	println ("^3 Time to reach the goal!");
//
////	pushes player away if blocking
//	anim_pushPlayer (guy);
//	
//	println("guy [0] is = ",guy[0] , " targetname ", guy[0].targetname, " animname ", guy[0].animname);
//	println("node is = ", node , " targetname ", node.targetname, " angles ", node.angles);
//	println("level.scr_anim[guy[i].animname][anime] = ",level.scr_anim[guy[0].animname]["bomb"]);
//	
//	anim_reach (guy, "bomb", undefined, node);
//
//	// Planting bombs
//	anim_dontPushPlayer (guy);
//
//	anim_single (guy, "bomb", undefined, node);
//
//	level.anderson setgoalnode (getnode ("bomb_cover","targetname"));
//
//	level.anderson.goalradius = 64;
//
//	wait (0.4);
//
//	// spawn germans behind wall
//	
//	// temp explosion
//	//maps\_utility_gmi::exploder (1);

	wait (2);

	// should trigger a chain to push guys into next room
	level.anderson setgoalentity (level.player);
	level thread event2_basement_enemies();

	//turn off push_player
	level.anderson.player_push = false;
	level.anderson pushPlayer(false);
	level.foley.player_push = true;
	level.foley pushPlayer(true);
	
	//save
	maps\_utility_gmi::autosave(4);
}

event2_basement_hack()
{
	wait 6;
	bomb = getent("bomb_model", "targetname");
	bomb show();

}

Event2_basement_anim()
{
	//anderson_basement anim
	level.scr_anim["anderson"]["anderson_basement"]			= (%c_us_noville_anderson_basement);

	level.scr_notetrack["anderson"][0]["notetrack"]              	= "anderson_trapped"; 
     	level.scr_notetrack["anderson"][0]["dialogue"]                	= "anderson_trapped"; 
     	level.scr_notetrack["anderson"][0]["facial"]                	= (%f_noville_anderson_trapped);

	level.scr_notetrack["anderson"][1]["notetrack"]              	= "anderson_blown"; 
     	level.scr_notetrack["anderson"][1]["dialogue"]                	= "anderson_blown"; 
     	level.scr_notetrack["anderson"][1]["facial"]                	= (%f_noville_anderson_blown);

	level.anderson thread anim_single_solo(level.anderson, "anderson_basement");

	//foley_basement anim
	level.scr_anim["foley"]["foley_basement"]			= (%c_us_noville_foley_basement);

	level.scr_notetrack["foley"][0]["notetrack"]           		="foley_satchel"; 
     	level.scr_notetrack["foley"][0]["dialogue"]          		="foley_satchel"; 
     	level.scr_notetrack["foley"][0]["facial"]              		=(%f_noville_foley_satchel);

	level.foley thread anim_single_solo(level.foley, "foley_basement");	
}


bazooka_setup()
{
	bazookas = getentarray ("bazooka", "targetname");
	for (i=0;i<bazookas.size;i++)
	{	
		bazookas[i] maps\_utility_gmi::triggerOff();
	}
}

//rename to event2_basement_enemies()
event2_basement_enemies()
{
	enemy = getentarray ("enemy4","targetname");
	for (i=0;i<enemy.size;i++)
	{
		enemy[i] dospawn();
	}

	// turn guys off
	enemy_spawn = getentarray ("enemy4","groupname");
	for (i=0;i<enemy_spawn.size;i++)
	{
		if(isalive(enemy_spawn[i]))
		{
			enemy_spawn[i].pacifist = true;
//			enemy_spawn[i] thread event2_basement_chatter();
		}
	}

	level thread event2_basement_chatter();
	// wait before turning guys on	
	wait 2;
	
	// turn them back on
	//enemy_spawn = getentarray ("enemy4","groupname");
	for (i=0;i<enemy_spawn.size;i++)
	{
		if(isalive(enemy_spawn[i]))
		{
			enemy_spawn[i].pacifist = false;
//			enemy_spawn[i] playsound("generic_misccombat_german_1");
			wait 0.5;
		}
	}	
}

//germans yell
event2_basement_chatter()
{
	//german chatter 
	german = spawn("script_origin",(652, 2506, 24));

	german playsound("generic_misccombat_german_1");
	wait 2;
	german playsound("generic_misccombat_german_2");
	wait 2;
	german playsound("generic_misccombat_german_1");
}

anim_pushPlayer (guy)
{
	maps\_anim_gmi::anim_pushPlayer(guy);
}

anim_dontPushPlayer (guy)
{
	maps\_anim_gmi::anim_dontPushPlayer(guy);
}

anim_reach (guy, anime, tag, node, tag_entity)
{
	maps\_anim_gmi::anim_reach (guy, anime, tag, node, tag_entity);
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

anim_reach_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_reach(newguy, anime, tag, node, tag_entity);
}

skipto_chateau()
{
	wait .1;
	
	//blow up chateau front wall
	level thread maps\_utility_gmi::exploder(5);

	// start in chateau courtyard

	// Teleport Player To new spot.
	level.player setorigin((-112, 6454, 448));
	
	
	//grab squad
	squad = getentarray("squad2", "groupname"); 
        new_squad = [];
		
	//grab only ai not spawners
	for(n=0;n<squad.size;n++)
	{
		if(issentient(squad[n]))
		{
			//println("adding ai "+ i + "to array");
			new_squad[new_squad.size] = squad[n];
		}
	}

	if(new_squad.size > 0)
	{
		squad = new_squad;
	}
	
	wait 0.5;

	// teleport squad
	org = (735, 4702, 120);
	for(i=0;i<squad.size;i++)
	{
		squad[i] teleport(org);
		squad[i] setgoalentity(level.player);

		org = ((org[0] - 36), org[1], org[2]);
	}

// delete tank riders

	squad1 = getentarray("squad1", "groupname"); 
	for (i=0; i<squad1.size; i++)
	{
		squad1[i] delete();
	}

	squad3 = getentarray("squad3", "groupname"); 
	for (j=0; j<squad1.size; j++)
	{
		squad3[j] delete();
	}

// put tank in chateau courtyard

//	tank = getent("sherman_tank1", "targetname");
//	start_node = getvehiclenode("JCauto98", "targetname");
//	tank attachPath(start_node);

	// delete triggers of spawners
	trigger_spawners= getentarray("flood_spawner", "targetname");

	for (k=0; k<trigger_spawners.size;k++)
	{
		if(isdefined(trigger_spawners[k].target))
		{
			if (	trigger_spawners[k].target == "chateau_wave1" ||
			
				trigger_spawners[k].target == "chateau_wave1a" ||
			
				trigger_spawners[k].target == "chateau_wave2" ||
			
				trigger_spawners[k].target == "chateau_wave2a" ||
			
				trigger_spawners[k].target == "chateau_wave3" ||
					
				trigger_spawners[k].target == "chateau_wave4" ||
					
				trigger_spawners[k].target == "pre_chateau" ||
			
				trigger_spawners[k].target == "street" )
			
			{
				trigger_spawners[k] delete();
			}
		}	
	}

	//give player weapons
	level.player giveWeapon("m1carbine");
	level.player switchToWeapon("m1carbine");
	level.player giveWeapon("fraggrenade");	

	// check off objectives
	level notify ("objective_1_complete");
	wait 0.5;
	level notify ("objective_2_complete");
	wait 0.5;	
	level notify ("objective_3_complete");
}


//chateau
alamo_battle()
{
	trigger = getent("alamostart", "targetname");
	trigger waittill("trigger");
	
	level thread alamo_trigger_damages();
	level thread alamo_wing_think();
	level thread second_squad2_delete();
	level thread alamo_whitney();
	level thread alamo_wave3_prevent();

	//alamo_mg34 trigger off
	trigger = getent("alamo_mg34", "targetname");
	trigger maps\_utility_gmi::triggerOff();

	wait(5); // allow friends to get in position and future dialogue

	//alamo wave 1 - south
	level thread alamo_wave1();
	level waittill ("wave1_over");
	
	//check axis alive, don't start wave until certain amt left
	while(!(AI_Check(5, "axis")))	// (# of ai, "team")	 
	{ 
     		wait 0.5; 
	}

	// to let the action die down
 	wait (5);
	level thread objective_4_check();

	//alamo wave 2 - north
	level thread alamo_wave2();
	maps\_utility_gmi::autosave(8);
	level waittill ("wave2_over");

	//check axis alive, don't start wave until certain amt left
	while(!(AI_Check(5, "axis")))	// (# of ai, "team")	 
	{ 
     		wait 0.5; 
	}

	wait (5);
	level thread objective_5_check();
		
	//alamo wave 3 - east
	level thread alamo_wave3();
	maps\_utility_gmi::autosave(9);
	level waittill ("wave3_over");

	//check axis alive, don't start wave until certain amt left
	while(!(AI_Check(6, "axis")))	// (# of ai, "team")	 
	{ 
     		wait 0.5; 
	}

	wait (5);
	level thread objective_6_check();

		
	//alamo wave 4 - south/west
	level thread alamo_wave4();
	maps\_utility_gmi::autosave(12);
	level waittill ("wave4_over");

	//check axis alive, don't start wave until certain amt left
	while(!(AI_Check(5, "axis")))	// (# of ai, "team")	 
	{ 
     		wait 0.5; 
	}
	wait (5);

	//alamo wave 5 - north/west
	level thread alamo_wave5();
	maps\_utility_gmi::autosave(13);
	level waittill ("wave5_over");
	
	//alamo wave 6 - Finale
	level thread alamo_wave6();
	maps\_utility_gmi::autosave(14);
	level waittill ("wave6_over");

	friends = getaiarray("allies");
	for(i=0; i < friends.size; i++)
	{
		friends[i].accuracy = 1;
		println("^3 friends accuracy boosted");
	}
	
	//kill guys near player(dist check)
	wait(10);

	for(i=0; i < friends.size; i++)
	{
		if(isalive(friends[i]))
		{
			friends[i].pacifists = true;
			friends[i].pacifistwait = 0;
			friends[i].suppressionwait = 0;
			friends[i].team = "neutral";
			friends[i].generic_dialogue = false;
			println("^3 friends team is", friends[i].team);
			println("^3 friends pacified, stop shooting");
		}	
	}

	wait 2;//should be pacified no shooting

	// "Fly boys...they love to make a dramatic entrance!" 
	level.foley anim_single_solo(level.foley, "foley_flyboys");		

//	level.foley playsound("foley_flyboys");
//	wait(4);

	//Any way they want, Sir...any way they want.
	level.whitney anim_single_solo(level.whitney, "whitney_anyway");		

//	level.whitney playsound("whitney_anyway");
//	wait 5;

	level thread objective_7_check();

	level thread alamo_ending();
}


alamo_ending()
{
	//send guys to back porch

	//put moody and whitney on chain for the end
	level.moody setgoalentity (level.player);
	level.whitney setgoalentity (level.player);

	//move foley and anderson first
	f_mark = getnode("foley_mark_end", "targetname");
	level.foley.goalradius = 4;
	level.foley setgoalnode(f_mark);
	level.foley.player_push = true;

	a_mark = getnode("anderson_mark_end", "targetname");
	level.anderson.goalradius = 32;	
	level.anderson setgoalnode(a_mark);
	level.anderson.player_push = true;

	//porch
	chain = getnode("JCauto527", "targetname");
	level.player setfriendlychain(chain);

//	level.foley waittill("goal");
	level.foley anim_reach_solo(level.foley, "foley_goodjob", undefined, f_mark);		

	//objective at porch

	//get the back porch trigger
	trigger= getent("end_foley_trigger", "targetname");
	trigger waittill("trigger");

	level thread objective_8_check();

	// "(Turns, faces his troops)  Guys, this may be the hardest day I’ve been through...and the proudest I’ve ever been
	// of the men in my command.  (pause) Anderson -- go get that champagne we found.  Dinner’s on the way -- the drinks are on me!"
	level.foley anim_single_solo(level.foley, "foley_goodjob", undefined, f_mark);		

//	level.foley playsound("foley_goodjob");

	wait(2);

	missionSuccess("gmi_uk_intro", false);
	println("^5 MISSION OVER, MISSION OVER!!!!!");
}

//bring whitney to the party
alamo_whitney()
{
	whitney_spawner = getent("whitney", "targetname");
	whitney = whitney_spawner dospawn();
	whitney thread maps\_utility_gmi::magic_bullet_shield();
	whitney.animname = "whitney";
	level.whitney = whitney;
	level.whitney.goalradius = 32;
}

AI_Check(num, team) 
{ 
	ai = getaiarray(team); 
 
     	total_alive = []; 
     	for(i=0;i<ai.size;i++) 
     	{ 
        	if(isalive(ai[i])) 
	        { 
	    		total_alive[total_alive.size] = ai[i]; 
	        } 
     	} 
 
	println("^5 ai alive is ",total_alive.size);

    	if(total_alive.size <= num) 
   	{ 
       		return true; 
     	} 
     	else 
     	{ 
       		return false; 
     	} 
}

alamo_trigger_damages()
{
	origins = getentarray("alamo_tank_target","targetname");

	for(i=0;i<origins.size;i++)
	{
		if(isdefined(origins[i].target))
		{
			trigger = getent(origins[i].target,"targetname");
			trigger thread alamo_trigger_damage_think(origins[i]);
		}
	}
}

alamo_trigger_damage_think(origin)
{
	self maps\_utility_gmi::triggerOff();
	self waittill("trigger");

	level Remove_Target_From_All_Tanks(origin);
	origin delete();
}

// open door connecting rooms

alamo_door()
{
	doors = getentarray("alamo_door", "targetname");
	door_opener = getent("alamostart", "targetname");
	door_opener waittill ("trigger");
	
	for(n=0; n<doors.size; n++)
	{
		if(!isdefined(doors[n]))
		{
			println("^1door is not defined!!!");
		}
	
		// open door
		doors[n] connectpaths();
		doors[n] rotateyaw(-90, 1,0.25,0.25);
	}
		
}


//checks for germans in house
alamo_wing_think()
{
	level endon("wave5_over");

	// get the wing triggers in house
	alamo_wings = getentarray("alamo_wing", "targetname");

	// check where it's being triggered and call out
	while(1)
	{
		axis = getaiarray ("axis");

		for (i=0;i<alamo_wings.size;i++)
		{
		
			switch(alamo_wings[i].script_noteworthy)
			{
				case "south":
					if(randomint(2) == 0)
					{
						sound = "whitney_germans_in_house";
					}
					else
					{
						sound = "anderson_germans_in_house";
					}
					break;

				case "west":
					if(randomint(2) == 0)
					{
						sound = "foley_germans_porch";
					}
					else
					{
						sound = "foley_germans_in_house";
					}
					break;

				case "north":
					if(randomint(2) == 0)
					{
						sound = "anderson_germans_north_kitchen";
					}
					else
					{
						sound = "anderson_germans_north";
					}
					break;
			}
	
			for(n=0; n<axis.size; n++)
			{
				// so it calls only once per german
				if(isdefined(axis[n].favoriteenemy) && axis[n].favoriteenemy == level.player)
				{
					continue;
				}			
	
				if(axis[n] istouching(alamo_wings[i]))
				{
					axis[n] thread alamo_target_player();
					//            alamo_callout(sound, wing)
					level.foley alamo_callout(sound, alamo_wings[i].script_noteworthy);
				}
			}
		}
		wait(0.01);
	}
}

// make enemies in house go after player
alamo_target_player()
{
	println("^1 german goal is player!!!");
	level notify("german_in_house");
	self.health = 150;
	self setgoalentity(level.player);
	self.goalradius = 128;
	self.favoriteenemy = level.player;
	self.accuracy = .8;
	self waittill("goal");
	println("^1 german tracked player down !!!");
}

alamo_callout(sound, wing)
{
	if(!isdefined(level.foley.last_call) || !isdefined(level.foley.last_call[wing]))
	{
//		last_call[wing] = gettime();
		// so it plays once
		level.foley.last_call[wing] = 0;	
	}

	//don't call again unless at least 10 secs have gone by
	if (level.foley.last_call[wing] + 10000 > gettime())
	{
		println("^3 10 secs hasn't gone by");
		return;
	}

	level.foley.last_call[wing] = gettime();
	println("^3 last_call was at ",level.foley.last_call[wing]);
	self playsound(sound);
}

//tracks how many germans in house, reset manually on every wave
alamo_germans_inside()
{
	while(1)
	{
		level waittill("german_in_house");
		level.germans_inside++;
		println("germans in house is", level.germans_inside);
		wait 0.1;
	}
}

//drones to start the alamo
alamo_dummies()
{

}

alamo_wave1()
{
	// 1st wave, infantry only, 120 secs
//	Protect South
	//notify drones
	level notify("start_drones");

	//level.whitney waittill("goal")
	mark = getnode("JCauto599", "targetname");
	
	level.whitney anim_reach_solo(level.whitney, "whitney_sonofa", undefined, mark);

	level.whitney anim_single_solo(level.whitney, "whitney_sonofa", undefined, mark);
			
	//open up whitney radius so he'll roam
	level.whitney.goalradius = 192;

	//beat
	wait 1;

	// (Glances out, then shouts) Cover the windows and doors! Hold your fire until they’re in range.
	level.foley anim_single_solo(level.foley, "foley_sonofa");		

	//save after speech
	maps\_utility_gmi::autosave(7);	

	level thread alamo_bodycount();
	level.germans_inside = 0;
	level thread alamo_germans_inside();

	//manage_spawners(strSquadName,mincount,maxcount,ender,spawntime,a,b,c)
//	thread	maps\_squad_manager::manage_spawners("alpha", 2, 4,"wave1a_over", 1, ::squad_init_stand);	//	4
//	thread	maps\_squad_manager::manage_spawners("alpha2", 1, 2,"wave1a_over", 1, ::squad_init_stand);	//	4
	thread	maps\_squad_manager::manage_spawners("charlie", 2, 5,"wave1a_over", 1,::squad_init_stand);	//	2 seconds
	thread maps\_squad_manager::manage_spawners("bravo",2, 4,"wave1a_over", 1, ::squad_init_stand);	//	
	thread	maps\_squad_manager::manage_spawners("delta", 2, 5,"wave1a_over", 1, ::squad_init_stand);	//	4

	wait(30);
	level notify("wave1a_over");

	//alamo_mg34 trigger on
	trigger = getent("alamo_mg34", "targetname");
	trigger maps\_utility_gmi::triggerOn();

//	thread maps\_squad_manager::manage_spawners("bravo",2, 5,"wave1b_over", 1, ::squad_init_stand);	//	
	thread	maps\_squad_manager::manage_spawners("charlie", 2, 4,"wave1b_over", 1,::squad_init_stand);	//	2 seconds
	thread	maps\_squad_manager::manage_spawners("alpha", 2, 4,"wave1b_over", 1, ::squad_init_stand);	//	4
	thread	maps\_squad_manager::manage_spawners("alpha2", 1, 2,"wave1b_over", 1, ::squad_init_stand);	//	4

	wait(30);
	level notify("wave1b_over");

	thread	maps\_squad_manager::manage_spawners("delta", 2, 5,"wave1_over", 1, ::squad_init_stand);	//	4
	thread	maps\_squad_manager::manage_spawners("charlie", 2, 5,"wave1_over", 1,::squad_init_stand);	//	2 seconds
	thread maps\_squad_manager::manage_spawners("bravo",2, 4,"wave1_over", 1, ::squad_init_stand);	//	

	wait(30);
	level notify("wave1_over"); 
	println("^3 wave1_over");

	// delete mg34 spawner
	spawners= getspawnerarray();

	for (i=0;i<spawners.size;i++)
	{
		if(isdefined(spawners[i].targetname) && spawners[i].targetname == "echo")
		{
			spawners[i] delete();
		}	
	}
}

squad_init_stand()
{
	self.goalradius = 64;			// goal radius is a good thing to set in the initialization 
//    	self.bravery = 1000;         		// you can set any other parameters you want here
   	self.maxsightdistsqrd = 1000000; 	// 1000 units
    	self allowedstances("stand");
	//can't thread self because will die
	level thread baglimit(self);
	
	//pacify for a bit
	self.pacifist = true;
	
	wait 5;
	
	if(isalive(self))
	{
		self.pacifist = false;
		println("^3 squad is not pacifist!!!");
	}
}


alamo_wave2()
{
//	Protect North
	wait 1;

	// spawn tank thread alamo_tank_spawner("node name")
	level thread alamo_tank_spawner("start_wave2_tank","wave2_tank");
	
	//call out tank
	level.anderson anim_single_solo(level.anderson, "anderson_panzer_north");		
//	level.anderson playsound ("anderson_panzer_north");

	//check status and repeat line
	level thread alamo_wave2_tankcheck();	
	
	level.germans_inside = 0;
	level thread alamo_germans_inside();

	wait(20);

	// manage_spawners(strSquadName,mincount,maxcount,ender,spawntime,a,b,c)
			
	thread	maps\_squad_manager::manage_spawners("golf", 2, 5, "wave2a_over",1, ::squad_init_stand);	

	wait(30);
	level notify("wave2a_over"); 
	
	thread	maps\_squad_manager::manage_spawners("foxtrot", 2, 3,"wave2b_over",1, ::squad_init_stand);

	wait(30);
	level notify("wave2b_over"); 

	//halftrack
	thread	maps\_squad_manager::manage_spawners("hotel",2, 4,"wave2_over",1, ::squad_init_stand);		

	wait(30);

	//tank must be dead before next wave	
	while(level.wave2_tank != 1)
	{
		wait 0.5;
	}

	level notify("wave2_over"); 
	println("^3 wave2_over");

	//cleanup guys out front
	cleanup = getentarray("chateau_wave2a", "groupname");
	for(i=0; i < cleanup.size; i++)
	{
		cleanup[i] delete();
		println("^3 deleting friends upfront");
	}
}

//track status of tank
alamo_wave2_tankcheck()
{
	//get tank
	wave2_tank = getent("wave2_tank", "targetname");
	
	//tank is alive
	level.wave2_tank = 0;
	
	//countdown and repeat
	wave2_tank thread alamo_tank_reminder(level.anderson, "anderson_panzer_north");

	//wait till tank is dead
	wave2_tank waittill("death");
	
	//tank is dead
	level.wave2_tank = 1;
	println("^3 wave2_tank dead!!!");
}

alamo_tank_reminder(speaker, sound_alias)
{
	self endon("death");	

	while(isalive(self))
	{
		x=30;
		while (x>0)
		{	
			wait 1;
			x--;
		}
		//remind player
		speaker anim_single_solo(speaker, sound_alias);
	}
}

alamo_wave3()
{
	//Sir...a Kraut tank just took out half of Third Squad! Sgt Moody’s rounded up the rest and they’re trying to get up here!
	level.anderson anim_single_solo(level.anderson, "anderson_third_squad");		

//	level.anderson playsound("anderson_third_squad");
	wait 1;

	//Riley - Anderson get up to the front and see if you can cover Third Squad’s approach.
	level.foley anim_single_solo(level.foley, "foley_cover_third");		
//
//	level.foley playsound ("foley_cover_third");
	
	// spawn bad guys
	thread	maps\_squad_manager::manage_spawners("juliet",1, 3,"wave3_over",1, ::squad_init_stand);
	thread	maps\_squad_manager::manage_spawners("kilo",1, 3,"wave3_over",2, ::squad_init_stand);
//	thread	maps\_squad_manager::manage_spawners("lima",1, 1,"wave3_over",10, ::squad_init_stand);
	
	maps\_utility_gmi::autosave(10);

	//make foley stay - should turn off chains
	node = getnode("JCauto160", "targetname");
	level.foley setgoalnode(node);	

	//send anderson to front
	node = getnode("anderson_mark_escort", "targetname");
	level.anderson setgoalnode(node);
	level.anderson.goalradius = 256;

	level.player setfriendlychain(node);

//	// trigger waittill to make sure player sees stuff
//	trigger = getent("alamo_wave3", "targetname");
//	trigger waittill("trigger");
		
	//waittill player is 512 units from objective marker
	while (distance (level.player.origin, (-162, 5495, 136)) > 960)
		wait (0.5);

	println("^3 player is close enough, start escort!!!");
//	wait(5);

	thread	maps\_squad_manager::manage_spawners("india",1, 3,"moody_begin",1, ::squad_init_target_player);

	level thread alamo_wave3_escort_think();
			
	wait(30);	
	
	//halftrack pulls up
	//        alamo_halftrack_spawner(targetname, origin)
	level thread alamo_halftrack_spawner("ht1", "south");

	
	level waittill("objective_6_complete"); 

	//delete guys
	spawners= getspawnerarray();
	for (i=0;i<spawners.size;i++)
	{
		if(isdefined(spawners[i].targetname) && spawners[i].targetname == "alamo_wave3_help")
		{
			spawners[i] delete();
		}	
	}
}

alamo_wave3_sniper()
{
	wait randomint(3);

	//open shutters
	l_shutter = getent("alamo_left_shutter", "targetname");	
	r_shutter = getent("alamo_right_shutter", "targetname");
	
	l_shutter rotateyaw(-90,.25,.25,0);
	r_shutter rotateyaw(90,.25,.25,0);
	println("^2 sniper shutters opening");	

	thread	maps\_squad_manager::manage_spawners("mike",1, 1,"wave3_over",15, ::squad_init_target_player);
	level.anderson playsound("sniper");
}


alamo_wave3_escort_think()
{
	level.wave3_saved = 0;
	level.wave3_amount_to_save = 6;

//	// Insert "OBJECTIVE ADD" here
//	objective_string(6, &"GMI_NOVILLE_OBJECTIVE_6_TRACKER", level.wave3_amount_to_save);
//
//	//print to screen
//	iprintlnbold(&"GMI_NOVILLE_OBJECTIVE_6_TRACKER", level.wave3_amount_to_save);
		
//	level thread test();

	while(level.wave3_saved < level.wave3_amount_to_save)
	{
		random_num = 2 + randomint(2); // gives up to 3 guys

		if(level.wave3_saved >= (level.wave3_amount_to_save - 2))
		{
			//insures that we spawn only enough to satisfy amount_to_save
			random_num = level.wave3_amount_to_save - level.wave3_saved;

		}

		the_spawner = getentarray("alamo_third_squad", "targetname");
		for(i=0; i < random_num; i++)
		{
			the_spawner[i].count = 1;
			third_squad_guy = the_spawner[i] stalingradspawn();

			println("^6 SPAWNED THIRD SQUAD GUY *********************************");
			// dospawn is slow
			wait 0.05;
			third_squad_guy.goalradius = 32;
			third_squad_guy.bravery = 1000;

			third_squad_guy thread alamo_wave3_guy_think();
			third_squad_guy thread alamo_wave3_guy_death_think();
		}

		while(random_num > 0)
		{
			level waittill ("wave3_saved");
			random_num--;
		}

		if(level.wave3_saved >= level.wave3_amount_to_save)
		{
			//bring out the sniper
			level thread alamo_wave3_sniper();
			break;
		}

		//spawn every 5 secs till certain amt saved
		wait(randomfloat(5));
	}
	
	level thread alamo_wave3_moody();
	
}


alamo_wave3_moody()
{
	level notify("moody_begin");
	
	maps\_utility_gmi::autosave(11);

	wait(2);

	//spawn moody once amt to save is satisfied
	moody_spawner = getent ("moody", "targetname");
	moody_guy = moody_spawner stalingradspawn();
	println("^2 moody spawned");
	wait 0.1;
	moody_guy.animname = "moody";
	moody_guy character\_utility::new();
	moody_guy character\moody_winter::main();

	level.moody = moody_guy;
	level.moody.bravery = 10000;
	level.moody.goalradius = 64;
	level.moody.suppressionwait = 0;
	
	level thread alamo_wave3_fail(level.moody);

	//goal currently targeted in editor
	
	objective_string(6, &"GMI_NOVILLE_OBJECTIVE_6_MOODY");
	//print to screen
//	iprintlnbold(&"GMI_NOVILLE_OBJECTIVE_6_MOODY");

	//halfway home	
	level.moody waittill("goal");
	level thread alamo_wave3_moodykill();
	println("^2 moody halfway");

	safe_node = getnode("safe_node", "targetname");
	level.moody setgoalnode(safe_node);
	level.moody waittill("goal");
	println("^2 moody safe");

	level notify("wave3_over"); 
	println("^3 wave3_over");

	//fix moody - should use regen?
	level.moody thread maps\_utility_gmi::magic_bullet_shield();
	node = getnode("anderson_mark_escort", "targetname");
	level.player setfriendlychain(node);
	level.moody setgoalentity(level.player);

	//clear remaining enemies
	level waittill("objective_6_complete");	

	//send moody upstairs.
	upstairs_node = getnode("upstairs_node","targetname");
	level.moody setgoalnode(upstairs_node);
}

alamo_wave3_moodykill()
{
	spawners = getentarray("moody_killer", "targetname");
	for(i=0; i< spawners.size; i++)
	{
		enemy[i] = spawners[i] stalingradspawn();
		enemy[i].pacifist = true;
	}
	
	wait 2;
		
	for(i=0; i< spawners.size; i++)
	{
		enemy[i].goalradius = 64;
		enemy[i].bravery = 10000;
		enemy[i].suppressionwait = 0;
		enemy[i].favoriteenemy = level.moody;
		enemy[i].pacifist = false;
		enemy[i] thread alamo_wave3_moodychase();
	}
	println("^2 moody killers!! RUN");
}

alamo_wave3_moodychase()
{
	println("^2 follow moody");
	level endon("wave3_over");

	while(1)
	{
		self endon("death");
		if(isalive(level.moody))
		{
			self setgoalpos(level.moody.origin);
			println("moody origin is ", level.moody.origin);
		}
		wait 1;
	}
}

alamo_wave3_guy_think()
{
	self endon("death");
	
	println("^2 going to node3");
	safe_node = getnode("safe_node", "targetname");
	if(!isdefined(safe_node))
	{
		println("^1 Node3 is not defined!!!");
		return;
	}
	self setgoalnode(safe_node);
	self waittill("goal");
	// so no keeps shooting at guys
	self.ignoreme = true;

	level.wave3_saved++;
	
	remaining_num = level.wave3_amount_to_save - level.wave3_saved;
	
//	if(remaining_num != 0)
//	{
//		objective_string(6, &"GMI_NOVILLE_OBJECTIVE_6_TRACKER", remaining_num);
//	
//		//print to screen
//		iprintlnbold(&"GMI_NOVILLE_OBJECTIVE_6_TRACKER", remaining_num);
//	}
	
	level notify ("wave3_saved");

	// send them into kitchen to be deleted
	println("^1 guy going to be deleted!!!");
	delete_node = getnode("delete_me", "targetname");
	self setgoalnode(delete_node);
	self waittill("goal");
	self delete();
}

alamo_wave3_guy_death_think()
{
	self endon("goal");

	self waittill ("death");
	level notify ("wave3_saved");
}

alamo_wave3_fail(guy)
{
//	self endon("goal");

	guy waittill ("death");
	wait 0.5;
	
	setCvar("ui_deadquote", "@GMI_SCRIPT_NOVILLE_MOODYDIED");

	missionfailed();
}


//prevents player from leaving courtyard during escort
alamo_wave3_prevent()
{ 
     level endon("wave3_over"); 
 
     while(1) 
     { 
          //reuse old trigger 
          trigger = getent("tank_death", "targetname"); 
          trigger waittill("trigger"); 
 
          while(level.player istouching(trigger)) 
          { 
               axis = getaiarray("axis"); 
               println("^3 player is on street!!!"); 
               for(i=0; i < axis.size; i++) 
               { 
                    if(isalive(axis[i])) 
                    { 
                         axis[i].accuracy = 1; 
                         axis[i].threatbias = 10000; 
                    } 
               } 
               wait 0.5; 
          } 
 
          println("^1 player is OFF street!!!"); 
          axis = getaiarray("axis");           
          for(i=0; i < axis.size; i++) 
          { 
               if(isalive(axis[i])) 
               { 
                    axis[i].accuracy = .4; 
                    axis[i].threatbias = 0; 
               } 
          } 
     } 
}


squad_init_target_player()
{
	self.goalradius = 8;      // goal radius is a good thing to set in the initialization 
	self.bravery = 1000;         // you can set any other parameters you want here	
    
	self.favoriteenemy = level.player;
}


//test()
//{
//	level endon("wave3_over");
//
//	while(1)
//	{
//		wait 0.25;
//		println("^2level.wave3_saved = ",level.wave3_saved);
//	}
//
//
//}

alamo_wave4()
{
	//cleanup
	enemy = getaiarray("axis");
	if(enemy.size != 0)
	{
		for (j=0; j < enemy.size; j++)
		{
			wait 0.25; 
//			enemy[j] delete();
			if(isalive(enemy[j]))
			{
				enemy[j] DoDamage (enemy[j].health + 50, enemy[j].origin );
				println("^2enemies being killed");
			}
		}
	}

	//Riley – Anderson! Get yer asses back here!
//	level.foley anim_single_solo(level.foley, "foley_get_back_here");
	//so line can be heard in courtyard
	org = spawn("script_origin",(160, 6460, 454));
	org playsound("foley_get_back_here");
	wait 3;

//	iprintlnbold(&"GMI_NOVILLE_OBJECTIVE_7");
	//send anderson back
	node = getnode("anderson_mark_alamo", "targetname");
	level.anderson setgoalnode(node);
	level.anderson.goalradius = 192;	

	level.germans_inside = 0;
	level thread alamo_germans_inside();

	thread	maps\_squad_manager::manage_spawners("delta", 2, 4,"wave4a_over",1,::squad_init_stand);		

	//check player is in house

	//use distance check
	while (distance (level.player.origin, (-217, 6962, 437)) > 640)
		wait (0.5);

	println("^3 player is close enough, spawn tank!!!");
	
	// spawn tank thread alamo_tank_spawner("node name")
	level thread alamo_tank_spawner("tank1_wave4", "wave4_tank1");
	level.whitney anim_single_solo(level.whitney, "whitney_panzer_south");

	//countdown and repeat
	wave4_tank1 = getent("wave4_tank1", "targetname");
	wave4_tank1 thread alamo_tank_reminder(level.whitney, "whitney_panzer_south");		

	wait(10);

	//You’re doin’ great, guys – hang in there!
	level.foley anim_single_solo(level.foley, "foley_hold_chateau");		

//	level.foley playsound ("foley_hold_chateau");
//	wait(2);
	thread	maps\_squad_manager::manage_spawners("charlie", 2, 3,"wave4a_over",1,::squad_init_stand);

	wait(30);

	//insure tank dead before spawning another		
	while(1)
	{
		if(!isdefined(wave4_tank1) || !isalive(wave4_tank1) || wave4_tank1.health <= 0)
		{
			break;
		}
		wait 1;
		println("^3 waiting for tank to die!!!");
	}

	// spawn tank thread alamo_tank_spawner("node name")
	level thread alamo_tank_spawner("tank2_wave4", "wave4_tank2");
//	level.foley playsound ("foley_panzer_west");
	level.foley anim_single_solo(level.foley, "foley_panzer_west");
			
	//countdown and repeat
	wave4_tank2 = getent("wave4_tank2", "targetname");
	wave4_tank2 thread alamo_tank_reminder(level.foley, "foley_panzer_west");	

	wait(30);

	level notify("wave4a_over");
	thread	maps\_squad_manager::manage_spawners("alpha", 2, 4,"wave4_over",1,::squad_init_stand);
	thread	maps\_squad_manager::manage_spawners("bravo", 2, 4,"wave4_over",1,::squad_init_stand);

	//insure tank dead before spawning another		
	while(1)
	{
		if(!isdefined(wave4_tank2) || !isalive(wave4_tank2) ||wave4_tank2.health <= 0)
		{
			break;
		}
		wait 1;
		println("^3 waiting for tank to die!!!");
	}

	//halftrack pulls up
	//        alamo_halftrack_spawner(targetname, origin)
	level thread alamo_halftrack_spawner("ht2", "south");
	
	wait(20);
	
	level notify("wave4_over"); 
	println("^3 wave4_over");
}


alamo_wave5()
{
	
	// spawn tank thread alamo_tank_spawner("node name","targetname")
	level thread alamo_tank_spawner("tank1_wave5", "wave5_tank1");
	level.anderson anim_single_solo(level.anderson, "anderson_panzer_north");		

	//countdown and repeat
	wave5_tank1 = getent("wave5_tank1", "targetname");
	wave5_tank1 thread alamo_tank_reminder(level.anderson, "anderson_panzer_north");	

	level.germans_inside = 0;
	level thread alamo_germans_inside();

	wait(15);

	thread	maps\_squad_manager::manage_spawners("golf", 2, 4,"wave5a_over",1, ::squad_init_stand);	
	thread	maps\_squad_manager::manage_spawners("hotel",2, 4,"wave5a_over",1, ::squad_init_stand);

	wait(15);

	//insure tank dead before spawning another		
	while(1)
	{
		if(!isdefined(wave5_tank1) || !isalive(wave5_tank1) || wave5_tank1.health <= 0)
		{
			break;
		}
		wait 1;
		println("^3 waiting for tank to die!!!");
	}

	level notify("wave5a_over");

	//halftrack
	level thread alamo_halftrack_spawner("ht3", "north");

	wait(20);
	//guys from south
	thread	maps\_squad_manager::manage_spawners("charlie", 2, 5,"wave5b_over", 1,::squad_init_stand);	//	2 seconds
	thread maps\_squad_manager::manage_spawners("bravo",2, 4,"wave5b_over", 1, ::squad_init_stand);	//	
	thread maps\_squad_manager::manage_spawners("alpha",2, 4,"wave5b_over", 1, ::squad_init_stand);	//	

	wait(20);
	level notify("wave5b_over");
	//guys from north
	thread	maps\_squad_manager::manage_spawners("golf", 2, 4,"wave5_over",1, ::squad_init_stand);	
	thread	maps\_squad_manager::manage_spawners("foxtrot", 2, 3,"wave5_over", 1, ::squad_init_stand);

	wait(20);
		
	thread	maps\_squad_manager::manage_spawners("hotel",2, 4,"wave5_over",1, ::squad_init_stand);
		
	// spawn tank thread alamo_tank_spawner("node name","targetname")
	level thread alamo_tank_spawner("tank2_wave5","wave5_tank2");
	level.foley anim_single_solo(level.foley, "foley_panzer_west");		

	//countdown and repeat
	wave5_tank2 = getent("wave5_tank2", "targetname");
	wave5_tank2 thread alamo_tank_reminder(level.foley, "foley_panzer_west");	
	
	//wait till tank is dead
	wave5_tank2 waittill("death");
	println("^3 wave5_tank dead!!!");

	//start music
	level notify("finale_music");
		
	wait(10);
	
	level notify("wave5_over"); 
	println("^3 wave5_over");
}

alamo_wave6()
{
	//finale
	
	//spawn germans
	thread	maps\_squad_manager::manage_spawners("charlie", 4, 4,"wave6_over",1, ::squad_init_stand);	
	thread	maps\_squad_manager::manage_spawners("foxtrot", 3, 3,"wave6_over",1, ::squad_init_stand);
	thread	maps\_squad_manager::manage_spawners("delta", 3, 3,"wave6_over",1, ::squad_init_stand);
	thread	maps\_squad_manager::manage_spawners("bravo", 3, 3,"wave6_over",1, ::squad_init_stand);
	
	wait(10);

	level.finale = 1;
	println("^2level.finale is ", level.finale);

	// spawn tank thread alamo_tank_spawner("node name","targetname")
	level thread alamo_tank_spawner("tank2_wave6","end_tank_3");
	level thread alamo_tank_spawner("tank4_wave6","end_tank_4" );

	level.foley anim_single_solo(level.foley, "foley_panzer_west");		

//	level.foley playsound ("foley_panzer_west");
	wait(1);
	
	// spawn tank thread alamo_tank_spawner("node name","targetname")
	level thread alamo_tank_spawner("tank3_wave6","end_tank_5");
	level.whitney anim_single_solo(level.whitney, "whitney_panzer_south");		

//	level.whitney playsound ("whitney_panzer_south");		
//	wait(3);

	// spawn tank thread alamo_tank_spawner("node name")
	level thread alamo_tank_spawner("tank1_wave6","end_tank_2");
	level thread alamo_tank_spawner("tank5_wave6","end_tank_1");

	//callout
	level.anderson anim_single_solo(level.anderson, "anderson_panzer_north");		
//	level.anderson playsound ("anderson_panzer_north");
	
	waittime = 10;
	while(waittime > 0)
	{
		println("^WAITING FOR PLANES, DOES IT FEEL DESPERATE!!!!!!");
		wait 1;
		waittime--;
	}
	
	// get player's attention	
	level thread Plane_Spawner("p47", "bf109_start", 0, undefined, true, 1, 1);	
	
	wait 1.5;
	//Incoming aircraft!
	level.whitney anim_single_solo(level.whitney, "whitney_incoming_air");		
//	level.whitney playsound("whitney_incoming_air");
//	wait 1.5;

	println("^4Theirs or ours?");
	level.anderson anim_single_solo(level.anderson, "anderson_theirs_ours");		

//	level.anderson playsound("anderson_theirs_ours");
	wait 3.5;
	
	//P-47s!
	level.whitney anim_single_solo(level.whitney, "whitney_p47s");		

//	level.whitney playsound("whitney_p47s");
//	wait 2;
//		Plane_Spawner(type, start_node, delay, health, start_sound, plane_num, spawn_delay)
	level thread Plane_Spawner("p47", "bf109_start", 0, undefined, true, 2, 1);
	
	println("^4alright, alright");
	level.anderson anim_single_solo(level.anderson, "anderson_alright");		
//	level.anderson playsound("anderson_alright");
	//play cheers
		
	// wait for planes
	wait(2);

	// simulate tanks being bombed
	for(i=1; i<6; i++)
	{
		tank_bombed = getent("end_tank_" + i,"targetname"); 
		tank_bombed.health = 1;
		println("^3 tank is", tank_bombed.targetname);
		println("^3 tank_bombed.health is", tank_bombed.health);
//		tank_bombed thread instant_mortar();
		tank_bombed dodamage(tank_bombed.health + 100, tank_bombed.origin);
		wait(0.5);
		println("^3 tank_bombed.health should be 0 ", tank_bombed.health);
	}
	
	level notify("wave6_over"); 
	println("^3 wave6_over");
	
	//grab all axis and make them run away like cowards
	// could use a line saying "look at them run".
	deserters = getaiarray("axis");
	
	for (n=0; n<deserters.size; n++)
	{
		if (isalive (deserters[n]))
		{
			deserters[n].health = (1);
			deserters[n].goalradius = (32);
			deserters[n].pacifist = true;
			deserters[n].pacifistwait = 0;
			//forces AI to do whatever it's told regardless of danger, ironic in this case
			deserters[n].bravery = 500000;	
			deserters[n] setgoalnode (getnode ("retreat_node","targetname"));
			deserters[n] thread Event1_delete();
		}
	}

	wait(2);

	//kill dudes near player
	for (n=0; n<deserters.size; n++)
	{
		if(isalive (deserters[n]))
		{
			dist = distance(level.player.origin, deserters[n].origin);
			visible = deserters[n] canSee(level.player);
			println("^3 enemy visible is ", visible);
			if((dist < 640) && visible != true)
			{
				deserters[n] dodamage(deserters[n].health + 100, deserters[n].origin);	
				println("^3 enemy_killed_magic_death!!!");
				deserters[n] playsound ("weap_kar98k_fire");
			}
			wait 0.05;
		}
	}

		//		Plane_Spawner(type, start_node, delay, health, start_sound, plane_num, spawn_delay)
	level thread Plane_Spawner("p47", "bf109_start", 0, undefined, true, 1, 1);
}


baglimit(enemy)
{
	//Notifies any time an enemy dies to track how many are killed by the player
	
	enemy waittill ("death", nAttacker);
	if(isdefined(nAttacker) && nAttacker == level.player)
	{
		level notify ("enemy_killed");
		println("^1enemy_killed_by_player");
	}
}


//tracks how many guys player kills
alamo_bodycount()
{
	i = 0;
	println("^3body count threaded");

//	while(i < min_kill)
	while(1)
	{
		level waittill ("enemy_killed");
		i++;
		println("^3ENEMIES KILLLED IS NOW ", i);
		println("^3ENEMIES KILLLED IS NOW ", i);
	}
	
}


alamo_halftrack_spawner(targetname, origin)
{
	halftrack = getent ( targetname,"targetname");
	halftrack thread maps\_halftrack_gmi::init("reached_end_node");
	
	halftrack startpath();
	wait (2);
	
	if(origin == "north")
	{
		level.anderson anim_single_solo(level.anderson, "anderson_halftrack_north");		
//		level.foley playsound("foley_halftrack_north");
	}	
	
	else if(origin == "south")
	{
		level.whitney anim_single_solo(level.whitney, "whitney_halftrack_south");		
//		level.whitney playsound ("whitney_halftrack_south");
	}

	halftrack waittill ("reached_end_node");
	println("^3 *** HT Reached node");

	halftrack disconnectpaths();
}


alamo_tank_spawner(node_name, targetname, add_player)
{
	if(!isdefined(node_name))
	{
		println("^1(alamo_tank_spawner): Node_name is not specified!!!");
		return;
	}
	
	if(!isdefined(targetname))
	{
		println("^1(alamo_tank_spawner): targetname is not specified, setting to a default!!!");
		targetname = "tank";
		
	}

	println("^5 PANZER Spawned!!!!");
	tank = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", targetname, "PanzerIV" ,(0,0,0), (0,0,0) );
	tank maps\_panzeriv_gmi::init();

	// attachedpath is for alamo_tank_think();
	tank.groupname = "alamo_tanks";

	path = getVehicleNode (node_name,"targetname");
	tank.attachedpath = path;
	tank attachpath(path);
	tank startpath();

	tank maps\_tankgun_gmi::mgoff();

	// Health Regenerates till it gets notified to stop.
	tank thread Tank_Health_Regen(10000);

	// Think function while the tank moves.
	tank thread alamo_tank_think();
		
	//update objective to tank
	if(level.finale == 0)
	{
		level thread alamo_tank_objective_update(tank);
		level thread alamo_tank_objective_reset(tank);	
	}

	if(node_name == "start_wave2_tank")
	{
		//track tank death
		level thread alamo_tank_status(tank);
	}

	// Get Script_Origins for the tanks target.	
	origins = getentarray("alamo_tank_target", "targetname");
	for(n=0;n<origins.size;n++)
	{
		origins[n].non_living = true;
	}

	tank thread Tank_Add_Targets(origins);

	if(isdefined(add_player))
	{
		player[0] = level.player;
		player[1] = level.player;
		tank thread Tank_Add_Targets(player);
	}
}

alamo_tank_think()
{
	self endon("death");
	self endon("stop_tank_think");
	
	if(!isdefined(self.attachedpath))
	{
		println("^1NO '.ATTACHEDPATH' FOUND FOR TANK, ",self.targetname);
		return;
	}
	pathstart = self.attachedpath;

	pathpoint = pathstart;
	arraycount = 0;

	// Puts the pathpoints in order, from start to finish.
	while(isdefined (pathpoint))
	{
		pathpoints[arraycount] = pathpoint;
		arraycount++;
		if(isdefined(pathpoint.target))
		{
			pathpoint = getvehiclenode(pathpoint.target, "targetname");

		}
		else
		{
			break;
		}
	}

	pathpoint = pathstart;

	// Checks to see if there is a script_noteworthy on each node for the tank.
	for(i=0;i<pathpoints.size;i++)
	{
		if(isdefined(pathpoints[i].script_noteworthy))
		{
			self setWaitNode(pathpoints[i]);
			self waittill ("reached_wait_node");

			if(pathpoints[i].script_noteworthy == "stop_health_regen")
			{
				self notify("stop_health_regen");
			}
			else if(pathpoints[i].script_noteworthy == "start_firing")
			{
				// Star the TURRET THINK for the TANK.
				self thread Tank_Turret_Think(undefined, undefined, true);
			}
		}
	}
}

alamo_tank_objective_update(tank)
{
	tank endon ("death");

	//fix for wave5
	if(tank.attachedpath.targetname == "start_wave2_tank")
	{
		level.objective_5 = 0;
		println("^1objective_5 is ", level.objective_5);	
		objective_add(6, "active", &"GMI_NOVILLE_OBJECTIVE_7_TANK", (tank.origin));
		objective_current(6);
	
		while(isalive(tank))
		{
			objective_position(6, tank.origin);
			objective_ring(6);
			wait 0.7;
			println("^1in loop should be obj 6!!!!");
		}
		
		return;
	}	

	println("^1objective should be tank!!!!");
	objective_add(7, "active", &"GMI_NOVILLE_OBJECTIVE_7_TANK", (tank.origin));
	objective_current(7);
	
	while(isalive(tank))
	{
		objective_position(7, tank.origin);
		objective_ring(7);
		wait 0.7;
		println("^1in the while loop!!!!");
	}
}

alamo_tank_objective_reset(tank)
{
	//Briefly show the objective as complete, then nuke it
	//Restore the main objective to defend chateau.
	
	if(tank.attachedpath.targetname == "start_wave2_tank")
	{
		level.objective_5 = 0;
		println("^1objective_5 is ", level.objective_5);	
	}
	tank waittill ("death");
	
	println("^3 Tank died!!!!");	

	if(level.objective_5 == 0)
	{
		objective_state(6, "done");
		objective_delete(6);
		objective_add(5, "active", &"GMI_NOVILLE_OBJECTIVE_5", (175, 7046, 230));
		objective_current(5);
		level.objective_5 = 1;
		println("^1objective_5 is ", level.objective_5);
	}
	else
	{
		objective_state(7, "done");
		objective_delete(7);
		objective_add(7, "active", &"GMI_NOVILLE_OBJECTIVE_7", (-230, 7090, 230));
		objective_current(7);
		println("^1objective shoulde be ", &"GMI_NOVILLE_OBJECTIVE_7");
	}
}


alamo_tank_status(tank)
{
	tank waittill("death");
	
//		level thread tank_dialogue(ent, dialogue);
	wait 1;
	if(randomint(2) == 0)
	{
		level.foley anim_single_solo(level.foley, "foley_dang_nailed");		
	}
	else
	{
		level.whitney anim_single_solo(level.whitney, "whitney_dang_nailed");		

//		level.whitney playsound("whitney_dang_nailed");
	}
}


//checks if corner wall of chateau blown out, turns on exterior ambient
alamo_corner_ambient()
{
	trigger = getent("corner_exterior", "targetname");
	trigger maps\_utility_gmi::triggerOff();

	wall = getent("alamo_wave2_wall", "targetname");
	wall waittill("trigger");
	
	//delete mount when wall blows up
	mount = getent("corner_mount", "targetname");
	mount delete();

	trigger maps\_utility_gmi::triggerOn();
}



// Adds targets to the tanks enemy_targets list.
Tank_Add_Targets(targets)
{
	println("^5 TANK add targets");
	if(!isdefined(targets))
	{
		println("^1(Tank_Add_Targets) Invalid Target");
	}

	println("^5(Tank_Add_Targets) Targets size ",targets.size);
	for(i=0;i<targets.size;i++)
	{
		if(!isdefined(targets[i]))
		{
			println("^1(Tank_Add_Targets) Invalid Target(2) | i = ", i);
		}
		self.enemy_targets = verify_and_add_to_array(self.enemy_targets, targets[i]);
	}

	if(isdefined(self.enemy_targets))
	{
		// Prints out the new list of enemy_targets
		for(i=0;i<self.enemy_targets.size;i++)
		{
			if(self.enemy_targets[i] == level.player)
			{
				println("^5(Tank_Add_Targets) Enemy_Target.Classname [" + i + "]= ^7Player <- Dummy!");				
			}
			else
			{
				println("^5(Tank_Add_Targets) Enemy_Target.Classname [" + i + "]= ", self.enemy_targets[i].classname);
			}
		}
	}
}

// Removes a target from the tanks enemy_targets list.
Tank_Remove_Target(target)
{
	self.enemy_targets = maps\_utility_gmi::array_remove(self.enemy_targets, target);
}


Remove_Target_From_All_Tanks(target)
{
	tanks = getentarray("alamo_tanks","groupname");
	for(i=0;i<tanks.size;i++)
	{
		println("^5(Remove_Target_From_All_Tanks) tanks[i].health: ",tanks[i].health);
		println("^5(Remove_Target_From_All_Tanks) tanks[i].targetname: ",tanks[i].targetname);
		println("^5(Remove_Target_From_All_Tanks) tanks[i].enemy_targets: ",tanks[i].enemy_targets);
		
		if(isdefined(tanks[i].enemy_targets))
		{
			tanks[i].enemy_targets = maps\_utility_gmi::array_remove(tanks[i].enemy_targets, target);
		}
	}
}

// Finds the closest living enemy tank and fires at it.
Tank_Turret_Think(min_delay, max_delay, random_target)
{
	self endon("death");

	println("^5 TANK after thread");

	old_target = level.player;
	shot_count = 0;

	while(1)
	{
		if(isdefined(random_target))
		{
			if(isdefined(self.enemy_targets))
			{
				random_num = randomint(self.enemy_targets.size);
				target = self.enemy_targets[random_num];
			}
		}
		else
		{
			target = Tank_Get_Closest_Target();
		}

		if(target == old_target)
		{
			wait 0.05;
			continue;
		}

		//excludes shermans from firing at player
		if(self.model != "xmodel/v_us_lnd_sherman_snow")
		{	
			//own player if tank has fired more than 5 shots
			if(shot_count > 5)
			{
				println("^3 tank always aiming at player!!!");
				shot_count = 3;		//resets to 4
				target = level.player;
			}
		}

		if(isdefined(target))
		{
			old_target = target;
			if(isdefined(target.targetname))
			{
				println("^5TANK TARGET.TARGETNAME = ",target.targetname);
			}
			else if(target == level.player)
			{
				println("^5TANK TARGET.TARGETNAME = ^7PLAYER!!!");
			}

			if(isdefined(self.script_accuracy))
			{
				dist = distance(self.origin, target.origin);
				distacc = self.script_accuracy * (dist / 5000);
				randx = randomint(distacc * 0.85) + (distacc * 0.15);
				randy = randomint(distacc * 0.85) + (distacc * 0.15);
				randz = randomint(distacc * 0.85) + (distacc * 0.15);
				accuracy = (randx, randy, randz);
			}
			else
			{
				if(isdefined(target.classname) && target.classname == "script_origin")
				{
					accuracy = (0,0,0);
				}
				else
				{
					accuracy = (0,0,64);
				}
			}

			self thread Tank_Fire_Turret(target, undefined, randomfloat(2), randomfloat(2), accuracy, true);
			shot_count++;

			self waittill("turret_fire_done");
		}

		if(!isdefined(min_delay))
		{
			min_delay = 0.25;
		}

		if(!isdefined(max_delay))
		{
			max_delay = 3;
		}

		delay_range = max_delay - min_delay;
		delay = min_delay + randomfloat(delay_range);

//		println("^5(Tank_Turret_Think) Restarting in " + delay + " seconds...");

		wait delay;
	}
}

// This gets the closest living self.enemy_targets to the tank.
// Also validates the closest enemy before firing.
Tank_Get_Closest_Target()
{
	self endon("death");

	valid_target = false;

	not_valid_tanks = [];

	// Find closest living enemy tank
//	println("^5(Tank_Get_Closest_Target) Start");
	while(!valid_target)
	{
		if(isdefined(self.enemy_targets))
		{
			println("^5self.enemy_targets.size = ",self.enemy_targets.size);
		}

		if(!isdefined(self.enemy_targets) || self.enemy_targets.size == 0)
		{
//			println("^3(Tank_Get_Closest_Target) No Assigned Targets for Tank: ",self.targetname);
			wait 1;
			return undefined;
		}

//		if(isdefined(self.enemy_targets.size))
//		{
//			println("^5(Tank_Get_Closest_Target) self.enemy_targets.size", self.enemy_targets.size);
//		}

		dist1 = undefined;
		closest_tank = undefined;

		for(i=0;i<self.enemy_targets.size;i++)
		{
			not_valid = false;
			failsafe_check = false;

			if(isdefined(self.non_living)) // non_living used for the end of the map, for random targets.
			{
				if(!isalive(self.enemy_targets[i]))
				{
	//				println("^3(Tank_Get_Closest_Target) Tank  (" + i + ") is dead");
					self Tank_Remove_Target(self.enemy_targets[i]);
					continue;
				}
			}
			else if(!isalive(self.enemy_targets[i]))
			{
	//			println("^3(Tank_Get_Closest_Target) Tank  (" + i + ") is dead");
				self Tank_Remove_Target(self.enemy_targets[i]);
				continue;
			}

			// Check to see if the tank previously failed a valid check
			for(q=0;q<not_valid_tanks.size;q++)
			{
				if(not_valid_tanks[q] == self.enemy_targets[i])
				{
					not_valid = true;
				}
			}

			if(not_valid)
			{
				println("^3(Tank_Get_Closest_Target) Not at Valid Target  (" + i + ")");
				continue;
			}

//			println("^3(Tank_Get_Closest_Target) Check Closest for Tank (" + i + ")"); 
			if(!isdefined(dist1))
			{
				dist1 = distance(self.enemy_targets[i].origin, self.origin);
			}
	
			if(isdefined(closest_tank))
			{
				dist2 = distance(self.enemy_targets[i].origin, self.origin);
				if(dist2 < dist1)
				{
					closest_tank = self.enemy_targets[i];
					dist1 = dist2;
				}
			}
			else
			{
				closest_tank = self.enemy_targets[i];
			}
		}

		if(isdefined(closest_tank))
		{
			// Testing...
//			for(i=0;i<self.enemy_targets.size;i++)
//			{
//				if(closest_tank == self.enemy_targets[i])
//				{
//					println("^2(Tank_Get_Closest_Target) Closest Tank (" + i + ")");
//				}
//			}

			// Testing, see which one is the closest tank
			valid_target = self Tank_Validate_Target(closest_tank, "tag_turret", (0,0,64));
	
			if(!valid_target)
			{
//				println("Not valid size ",not_valid_tanks.size);
				if(not_valid_tanks.size == 0)
				{
					println("^6Added to Not Valid Tanks (" + not_valid_tanks.size + ")");
					not_valid_tanks[not_valid_tanks.size] = closest_tank;
				}
				else
				{
//				println("Not valid size 2 ",not_valid_tanks.size);
					for(i=0;i<not_valid_tanks.size;i++)
					{
						if(not_valid_tanks[i] != closest_tank && !failsafe_check)
						{
							// Added so it doesn't go twice for some reason.
							failsafe_check = true;
//							println("^6Added to Not Valid Tanks (" + not_valid_tanks.size + ")");
							not_valid_tanks[not_valid_tanks.size] = closest_tank;
						}
					}
				}
			}

//			if(isdefined(not_valid_tanks))
//			{
//				println("^6(Valid Check) not_valid_tanks.size: ",not_valid_tanks.size," ^6self.enemty_targets.size: ",self.enemy_targets.size);
//			}

			if(not_valid_tanks.size >= self.enemy_targets.size)
			{
				println("^1(Tank_Get_Closest_Target) No Valid Targets for Tank: ",self.targetname);
				return;
			}
		}

		if(valid_target)
		{	
			break;
		}
		wait 0.1;
	}

	return closest_tank;
}

// Validates the Target for the tank firing. Does a trace and returns a boolean for
// verification.
Tank_Validate_Target(target, tag, offset)
{
	self endon("death");

	if(isdefined(tag))
	{
		turret_origin = self gettagorigin(tag);
	}
	else
	{
		turret_origin = self gettagorigin("tag_turret");
	}

	if(isdefined(offset))
	{
		target_pos = (target.origin + offset);
	}
	else
	{
		target_pos = target.origin;
	}

	trace_result = bulletTrace(turret_origin, target_pos, false, self);

	// Debug line drawing.
//	level thread do_line(turret_origin, trace_result["position"], (1,1,0), "target");

	if(distance(trace_result["position"],(target.origin + offset)) < 32)
	{
		return true;
	}
	else
	{
		return false;
	}
}

// This function fires the turret on the tank
// Self = The tank
// TargetEnt = Target the turret at the ENT
// TargetPos = Target the turret at the POS
// Start_Delay = Delay before tracking the target.
// Shot_Delay = Delay after tracking the target, before shooting the turret.
// End_Notify = Notifies the entity when it's done, if not specified, 
// then: "turret_fire_done" will be notified
Tank_Fire_Turret(targetent, targetpos, start_delay, shot_delay, offset, validate)
{
	self endon("death");
	self notify("stop_random_turret_turning");

	if(isdefined(start_delay))
	{
		wait start_delay;
	}

	if(isdefined(targetent))
	{
		if(!isdefined(offset))
		{
			offset = (0,0,0);
		}

		self setTurretTargetEnt(targetent, offset);
	}
	else if(isdefined(targetpos))
	{
		self setTurretTargetVec(targetpos);
	}
	else
	{
		println("^1***(Tank_Fire_Turret) NO TARGET SPECIFIED!***");
		return;
	}

	// Debug line drawing.
//	level thread do_line(self.origin, targetent.origin, (0,1,0), "target1");

	self waittill("turret_on_target");

	if(targetent == level.player)
	{
		self clearTurretTarget();
		wait 0.5; // Adjust this number if needed.
	}

	if(isdefined(shot_delay))
	{
		wait shot_delay;
	}
	else
	{
		wait 0.5;
	}

	// Validate the target, one last time.
	// Only for Entities.
	if(isdefined(validate))
	{
		valid = self Tank_Validate_Target(targetent, "tag_flash", offset);
		if(!valid)
		{
			self notify("turret_fire_done");
			return;
		}
	}

	// We assume the script_origin is targetting a trigger_damage.
	// If so, turn the trigger on.
	if(isdefined(targetent.target))
	{
		trigger = getent(targetent.target, "targetname");
		trigger maps\_utility_gmi::triggerOn();
	}
	
	// Fires turret on Tank.
	self notify("turret_fire");
//	self FireTurret();
	self notify("turret_fire_done");
}

// Regens the Health on a tank... Forever.
Tank_Health_Regen(max_health)
{
	self endon("stop_health_regen");

	self.old_health = self.health;
	self thread Tank_Health_Reset();

	if(!isdefined(max_health))
	{
		max_health = 1000;
	}

	while(1)
	{
		self.health = max_health;
		self waittill("damage");
	}
}

Tank_Health_Reset()
{
	self waittill("stop_health_regen");
	self.health = self.old_health;
}

verify_and_add_to_array(array,ent)
{
	doadd = 1;
	if(isdefined(array))
	{
		for(i=0;i<array.size;i++)
		{
			if(array[i] == level.player)
			{
				continue;
			}
			if(array[i] == ent)
			{
				doadd = 0;
			}
		}
	}

	if(doadd == 1)
	{
		array = maps\_utility_gmi::add_to_array (array, ent);
	}
	return array;
}

// Tank turrets Random looking around
Tank_Turret_Random_Turning()
{
	self endon("death");
	self endon("stop_random_turret_turning");

	self.random_turret_think = true;

	// Yaw depending on world angles, not self.angles.
	self.min_yaw = 45;
	self.max_yaw = 135;
	self.use_self_angles = false;

	self thread Tank_Turret_Random_Turning_Think();

	random_yaw = 0;

	while(1)
	{
		if(self.random_turret_think)
		{
			range = self.max_yaw - self.min_yaw;

			if(range < 0)
			{
				range = range * -1;
				random_yaw = self.min_yaw + randomint(range);
				random_yaw = random_yaw * -1;
			}
			else
			{
				random_yaw = self.min_yaw + randomint(range);
			}

			random_z = randomint(100);

			if(self.use_self_angles)
			{
				forward_angles = anglestoforward(self.angles + (0, random_yaw, 0));
			}
			else
			{
				forward_angles = anglestoforward((0, random_yaw, 0));
			}
			vec = self.origin + maps\_utility_gmi::vectorScale(forward_angles,2000);

			if((vec[2] + random_z) < self.origin[2])
			{
				println(self.targetname, " ^3reseting vec[2]");
				vec = (vec[0], vec[1], (self.origin[2] + 64));
			}

			self.fake_target = (vec + (0, 0, random_z));

			self setTurretTargetVec(self.fake_target,(0,0,0));
			self waittill("turret_on_target");
			self clearTurretTarget();			
		}

		wait (1 + randomfloat(10));
	}
}

// Toggle their random turning on/off
Tank_Turret_Random_Turning_Think()
{
	self endon("death");

	while(1)
	{
		self waittill("stop_random_turret_turning");
		self.random_turret_think = false;

		self waittill("start_random_turret_turning");
		self.random_turret_think = true;
		self thread Tank_Turret_Random_Turning();
	}
}





do_line(pos1, pos2, color, msg)
{
	level.flag["blah"] = true;
	if(!isdefined(level.flag[msg]))
	{
		level.flag[msg] = false;
	}

	if(level.flag[msg])
	{
		level notify(msg + "_done");
		wait 0.05;
	}
	level endon(msg + "_done");

	level.flag[msg] = true;

	if(!isdefined(color))
	{
		color = (1, 1, 1);
	}

	while(1)
	{
		line(pos1, pos2, color);
		wait 0.06;
	}
}





//****Respawn Stuff****

Friendly_Respawner_Catch_UP()
{
	self endon("death");

	self.health = 100;
	self.goalradius = 32;
	self setgoalentity (level.player);
}

Friendly_Respawner_Setup()
{
	squad2 = getentarray("squad2","groupname");
	for(i=0;i<squad2.size;i++)
	{
		if(issentient(squad2[i]))
		{
			squad2[i] thread Friendly_Respawner_Death_Think();
		}
	}

	level thread Friendy_Respawner_Toggle();
	level thread Friendly_Respawner_Think();

	triggers = getentarray("friendly_respawner","targetname");

	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread Friendly_Respawner_Trigger();
	}
}

Friendly_Respawner_Trigger()
{
	// Set spawner count to 0, so they don't spawn in, when the player walks through the trigger.
	spawners = getentarray(self.target,"targetname");
	for(i=0;i<spawners.size;i++)
	{
		spawners[i].count = 0;
	}

	self waittill("trigger");
	level.friendly_respawner_trigger = self;
}

Friendly_Respawner_Think()
{
	level endon("stop_friendly_respawner");
	while(1)
	{
		level waittill("friendly_killed");

		if(isdefined(level.friendly_respawner_trigger))
		{
			spawners = getentarray(level.friendly_respawner_trigger.target,"targetname");

			guy_count = Friend_Respawner_AI_Counter();
		
			while(guy_count < level.friendlies)
			{
				wait 1 + randomfloat(3);

				random_num = randomint(spawners.size);

				spawners[random_num].count = 1;

				spawned = spawners[random_num] dospawn();

				spawners[random_num].count = 0;

				if(isdefined(spawned))
				{
					spawned maps\_names_gmi::get_name();
					spawned thread Friendly_Respawner_Catch_UP();
					spawned thread Friendly_Respawner_Death_Think();
				}

				guy_count = Friend_Respawner_AI_Counter();
			}
		}
	}
}

Friend_Respawner_AI_Counter()
{
	all_squad2 = getentarray("squad2","groupname");

	squad2 = [];

	for(i=0;i<all_squad2.size;i++)
	{
		if(isalive(all_squad2[i]))
		{
			squad2[squad2.size] = all_squad2[i];
		}
	}

	return squad2.size;
}

Friendly_Respawner_Death_Think()
{
	self waittill("death");
	level notify("friendly_killed");
}

Friendy_Respawner_Toggle()
{
	while(1)
	{
		level waittill("start_friendly_respawner");
		level thread Friendly_Respawner_Think();
		level waittill("stop_friendly_respawner");
	}
	
}


Plane_Spawner(type, start_node, delay, health, start_sound, plane_num, spawn_delay)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	if(!isdefined(plane_num))
	{
		plane_num = 1;
	}

	if(!isdefined(spawn_delay))
	{
		spawn_delay = 2;
	}

	path = getvehiclenode(start_node,"targetname");

	for(i=0;i<plane_num;i++)
	{
		if(isdefined(type))
		{
			if(type == "p47")
			{
				plane = spawnvehicle("xmodel/v_us_air_p47","p47","BF109",path.origin,path.angles);
				bomb_count = 6;
				plane.script_noteworthy = "noturrets";
				plane maps\_p47_gmi::init(bomb_count);
				plane thread p47_bombing_think(bomb_count);
			
				// If we want to blow up a plane, insert INIT() here!
			}
		}
		else
		{
			println("^1Tried to spawn a vehicle, without specifying the type");
			return;
		}
	
		if(!isdefined(health))
		{
			health = 1000000;
		}
	
		println("^3" + type + " on it's Way, along path: " + path.targetname);
		plane.health = health;
		plane notify("wheelsup");
		plane notify("takeoff");
	
		plane.attachedpath = path;
		plane attachPath(path);
		plane startpath();

		if(isdefined(start_sound))
		{
			if(isdefined(path.script_noteworthy))
			{
				plane playsound(path.script_noteworthy);
			}
			else
			{
				plane playsound("p47_attack");
			}
		}
	
		plane thread Plane_Think();

		wait spawn_delay;
	}
}

Plane_Think()
{
	level endon("stop_random_stukas");
	self endon("death");

	if(!isdefined(self.attachedpath))
	{
		println("^1NO '.ATTACHEDPATH' FOUND FOR STUKA, ",self.targetname);
		return;
	}
	pathstart = self.attachedpath;

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
		{
			break;
		}
	}

	pathpoint = pathstart;
	random_num = 0;
	for(i=0;i<pathpoints.size;i++)
	{
		if(isdefined(pathpoints[i].script_noteworthy))
		{
			self setWaitNode(pathpoints[i]);
			self waittill ("reached_wait_node");

			if (pathpoints[i].script_noteworthy == "flyby_sound")
			{
				if(isdefined(pathpoints[i].script_delay))
				{
					wait pathpoints[i].script_delay;
				}
				println("^5Plane flyby_sound");
			}
		}
	}

	self waittill("reached_end_node");
	self delete();
}

p47_bombing_think(amount)
{
	wait 2.5;
//	self thread maps\_p47_gmi::drop_bombs(amount, randomfloatrange(0.2,0.5), 0, 1000, 3000, 3000);
	self thread maps\_p47_gmi::drop_bombs(amount, .5, 0, 1500, 3000, 3000);

}

music()
{
	
	//after basement trap
	level waittill("basement_trap");	
	musicplay("noville_streetfight");
	//before entering chateau kitchen
	level waittill("entering_kitchen");	
	musicstop(5);

	level waittill("finale_music");
	println("^3 finale music!!!");
	musicplay("noville_finale");

	//fade out
//	level waittill("objective_7_complete");
//	musicstop(5);
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
	anim_wait2[0] = 100;
	
	anim_wait3 = [];
	anim_wait3[0] = 9;
	
	level waittill ("start_drones");
	level thread maps\noville_dummies::dummies_setup((0,0,0), "xmodel/noville_dummies", 60, (0, 180, 0), 7, 1, "field_dummy_path1", true, "axis_drone", anim_wait2, false, gun_fire_notify, 1, true);
//	
//	level waittill ("1: drone 3 go");
//	level thread maps\bastogne1_dummies::dummies_setup((0,0,0), "xmodel/bastogne1_field_dummies3", 5, (0,180,0), 7, 1, "field_dummy_path3", true, "axis_drone", anim_wait3, true, gun_fire_notify, 1, true);
//
//	level waittill ("2: drone 1 go");	
//	level thread maps\bastogne1_dummies::dummies_setup((0,0,0), "xmodel/bastogne1_field_dummies1", 5, (0,180,0), 7, 1, "field_dummy_path1", true, "axis_drone", anim_wait1, true, gun_fire_notify, 1, true);
//	
//	level waittill ("2: drone 2 go");
//	level thread maps\bastogne1_dummies::dummies_setup((0,0,0), "xmodel/bastogne1_field_dummies2", 5, (0,180,0), 7, 1, "field_dummy_path2", true, "axis_drone", anim_wait2, true, gun_fire_notify, 1, true);
//	
//	level waittill ("3: drone 1 go");	
//	level thread maps\bastogne1_dummies::dummies_setup((0,0,0), "xmodel/bastogne1_field_dummies1", 5, (0,180,0), 7, 1, "field_dummy_path1", true, "axis_drone", anim_wait1, true, gun_fire_notify, 1, true);
//
//	level waittill ("3: drone 3 go");
//	level thread maps\bastogne1_dummies::dummies_setup((0,0,0), "xmodel/bastogne1_field_dummies3", 5, (0,180,0), 7, 1, "field_dummy_path3", true, "axis_drone", anim_wait3, true, gun_fire_notify, 1, true);
//	
}    

#using_animtree("noville_signs");
sign_anim_loop()
{
	level.scr_anim["sign_a"]["swing"][0] = (%o_us_prp_sign_a);

	sign = getent("sign_a","targetname");
	sign useAnimTree( #animtree );
	sign.animname = "sign_a";
	sign thread maps\_anim_gmi::anim_loop_solo(sign, "swing");

	level.scr_anim["sign_b"]["swing"][0] = (%o_us_prp_sign_b);

	sign = getent("sign_b","targetname");
	sign useAnimTree( #animtree );
	sign.animname = "sign_b";

	sign thread maps\_anim_gmi::anim_loop_solo(sign, "swing");

	level.scr_anim["sign_c"]["swing"][0] = (%o_us_prp_sign_c);

	sign = getent("sign_c","targetname");
	sign useAnimTree( #animtree );
	sign.animname = "sign_c";

	sign thread maps\_anim_gmi::anim_loop_solo(sign, "swing");

	level.scr_anim["sign_d"]["swing"][0] = (%o_us_prp_sign_c);

	sign = getent("sign_d","targetname");
	sign useAnimTree( #animtree );
	sign.animname = "sign_d";

	sign thread maps\_anim_gmi::anim_loop_solo(sign, "swing");

	level.scr_anim["curtains"]["medium"][0] = (%m_curtain_medium_a);

	curtains = getentarray("curtains_medium", "targetname");
	for(i=0; i < curtains.size; i++)
	{
		curtains[i] useAnimTree( #animtree );
		curtains[i].animname = "curtains";
		curtains[i] thread maps\_anim_gmi::anim_loop_solo(curtains[i], "medium");
	}

} 


               