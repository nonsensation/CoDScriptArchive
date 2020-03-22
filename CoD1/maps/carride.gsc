/**************************************************************************
Level: 		CARRIDE
Campaign: 	Allied
Objectives: 	1. Report the Village's Capture to Regimental HQ
		2. Get To A New Car
		3. Defend Private Elder
		4. Get In the Car
		5. (Report the Village's Capture to Regimental HQ)	
***************************************************************************/

#using_animtree ("generic_human");
main()
{
	setCullFog(0, 30000, .32, .36, .40, 0);
	level.peugeot = getent ("peugeot","targetname");
	level.fronttrig = getent ("peugeot_trigger_front","targetname");
	level.reartrig = getent ("peugeot_trigger_rear","targetname");
	
	maps\_load::main();
	maps\carride_anim::main();
	maps\carride_anim::dialogue_anims();
	maps\carride_anim::facial_anims();
	maps\carride_anim::peugeot_load_anims();
	maps\carride_anim::kubelwagon_load_anims();
	maps\carride_fx::main();
	character\moody::precache();
	character\elder::precache();
	maps\_tank::main();
	maps\_tiger::main();
	maps\_truck::main();
	maps\_wood::main();
	maps\_vehiclechase::main();
	maps\_kubelwagon::main();
	maps\_bmwbike::main();
	maps\_panzeriv::main();
	
	precacheModel("xmodel/vehicle_german_truck_d");
	precacheModel("xmodel/vehicle_peugeot_glass_front");
	precacheModel("xmodel/vehicle_peugeot_glass_rear");
	precacheModel("xmodel/vehicle_peugeot_shatteredglass_front");
	precacheModel("xmodel/vehicle_peugeot_shatteredglass_rear");
	precacheModel("xmodel/vehicle_tank_panzeriv_machinegun");
	precacheModel("xmodel/vehicle_tank_tiger_camo");
	precacheModel("xmodel/health_medium");
	precacheShellshock("default");
	precacheItem("item_health");
	
	level.flags["bumpy"] 		= true;		//'true' when the car should be bumpy
	level.flags["OutWindow"] 	= false;	//true when player is out window, false when in car
	level.flags["KubelStart"] 	= false;	//set true when elder hotwires kubelwagon
	level.flags["KubelDuck_Moody"] 	= false;	//set to true when you want moody to duck
	level.flags["PlayerInKubel"] 	= false;	//Set to true when the player gets into the kubelwagon
	level.flags["elder_end"]	= false;	//set to true when kubel gets to HQ and elder loops end animation
	level.flags["ElderTrans"]	= false;
	level.flags["KubelCrash1"] 	= false;
	level.flags["KubelCrash2"] 	= false;
	level.flags["KubelCrash3"] 	= false;
	
	level.ambient_track ["carride"] = "ambient_carride";
	thread maps\_utility::set_ambient("carride");
	
	level.moody 		= getent ("moody","targetname");	//Stg Moody (Driver)
	level.elder 		= getent ("elder","targetname");	//Pvt Elder (Back Seat)
	level.moody.failWhenKilled 	= false;
	level.elder.failWhenKilled 	= false;
	level.kubelwagon 	= getent ("kubelwagon","targetname");	//the kubelwagon (second car you ride in)
	level.windowtrig 	= getent ("windowtrig","targetname");	//trigger used to move you in and out of the peugeot window
	level.convoy 		= getentarray ("convoy","targetname");	//3 Convoy Trucks
	level.chasecar1		= getent ("chasecar1","targetname"); 	//1st Kubelwagon
	level.chasecar2 	= getent ("chasecar2","targetname");	//2nd Kubelwagon
	level.chasecar3 	= getent ("chasecar3","targetname");	//3rd Kubelwagon
	level.elderanim		= 0;
	level.eldernode		= 1;
	level.moodyanim		= 0;
	level.fullhealth	= level.player.health;
	level.goalinc		= 0;
	
	level.moody character\_utility::new();
	level.moody character\moody::main();
	
	level.elder character\_utility::new();
	level.elder character\elder::main();
	
	thread maps\carride_anim::elder_passenger_idle();
	thread maps\carride_anim::moody_drive_setup();
	thread maps\carride_anim::moody_drive_idle();
	thread moody_hardright();
	thread moody_hardleft();
	
	level.moody thread maps\_utility::magic_bullet_shield();
	level.elder thread maps\_utility::magic_bullet_shield();
	
	//This controls when enemy AI are deleted
	deletetrigger = getentarray ("delete_guys","targetname");
	for (i=0;i<deletetrigger.size;i++)
		deletetrigger[i] thread delete_guys();
	
	kubeltrig = getent ("kubelwagon_trigger","targetname");
	kubeltrig thread maps\_utility::triggerOff();
	kubeltrig setHintString (&"CARRIDE_HINT_GETINCAR");
	
	tempcar = getent ("peugeot_temp","targetname");
	tempcar delete();
	
	thread firstguys();			//controls behavior of the first 2 guys
	thread player_init();			//setup the player
	thread objectives();			//sets up and controls level objectives
	thread convoy_setup();			//setup the convoy and kubelwagons
	thread ai_setup();			//do setup things to AI
	thread prone_control();			//controls the emeny so they can't go prone while you're in the cars
	thread dialogue_triggers();		//controls the dialogue for Moody and Elder
	thread peugeot_stayalive();		//give peugeot unlimited health
	thread start_drive();			//make the car move
	thread house_explosion();		//setup the house and prepare it for explosion from tank fire
	thread house_explosion2();
	thread kubelwagon_setup();		//makes the kubelwagon ready for later in the level
	level.moody thread give_health();	//makes sure Moody doesn't die
	level.elder thread give_health();	//makes sure Elder doesn't die
	thread fences_break_sounds();
	thread skid_sounds();
	thread elder_anim_triggers();
	thread nodewaits();
	thread player_usebutton();
	level.peugeot thread maps\carride_anim::peugeot_bumpy();//make the car bumpy
	level.peugeot thread bumpy();
	thread autosave1();
	thread flooders_setup();
	level thread player_death_think();
	musicPlay("carride_a");
}

player_death_think()
{
	level endon ("ExitVehicle");
	level.player waittill ("death");//only works on natural death, not console command "kill"
	//while (level.player.health > 0)
	//	waitframe();
	level.peugeot thread maps\carride_anim::peugeot_moveplayer("death");
}

flooders_setup()
{
	
	guys = getspawnerteamarray ("axis");
	for (i=0;i<guys.size;i++)
		guys[i] notify ("disable");
		
	level waittill ("HotWire");
	
	for (i=0;i<guys.size;i++)
		guys[i] notify ("enable");
}

peugeot_window_setup()
{	
	level.fronttrig.origin = (level.peugeot gettagOrigin ("tag_fx_front"));
	level.reartrig.origin = (level.peugeot gettagOrigin ("tag_fx_rear"));
	level.fronttrig enablelinkto();
	level.reartrig enablelinkto();
	level.fronttrig linkto(level.peugeot, "tag_body");
	level.reartrig linkto(level.peugeot, "tag_body");
	level.fronttrig thread front_window_think();
	level.reartrig thread rear_window_think();
}

front_window_think()
{
	level.peugeot attach("xmodel/vehicle_peugeot_glass_front","tag_body");
	
	for (i=0;i<5;i++)
	{
		self waittill ("trigger");
		level.peugeot thread maps\_utility::playSoundOnTag("bullet_large_glass", "tag_fx_front");
	}
	
	level.peugeot attach("xmodel/vehicle_peugeot_shatteredglass_front","tag_body");
	playfxOnTag (level._effect["shatter"], level.peugeot, "tag_fx_front");
	level.peugeot detach("xmodel/vehicle_peugeot_glass_front","tag_body");
	
	//level.peugeot thread maps\_utility::playSoundOnTag("grenade_explode_glass", "tag_fx_front");
	self delete();
}

rear_window_think()
{
	level.peugeot attach("xmodel/vehicle_peugeot_glass_rear","tag_body");
	
	for (i=0;i<5;i++)
	{
		self waittill ("trigger");
		level.peugeot thread maps\_utility::playSoundOnTag("bullet_large_glass", "tag_fx_rear");
	}
	
	level.peugeot attach("xmodel/vehicle_peugeot_shatteredglass_rear","tag_body");
	playfxOnTag (level._effect["shatter"], level.peugeot, "tag_fx_rear");
	level.peugeot detach("xmodel/vehicle_peugeot_glass_rear","tag_body");
	
	//level.peugeot thread maps\_utility::playSoundOnTag("grenade_explode_glass", "tag_fx_front");
	self delete();
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

fences_break_sounds()
{
	trigs = getentarray ("wood_splinter","targetname");
	for (i=0;i<trigs.size;i++)
		trigs[i] thread fences_break_sounds_wait();
}

fences_break_sounds_wait()
{
	self waittill ("trigger");
	level.player playsound ("crash_wood");
}

kubel_duck()
{
	wait 2;
	level.flags["KubelDuck_Moody"] = true;
	
	wait 3.5;
	level.flags["KubelDuck_Moody"] = true;

	getent ("duck2","targetname") waittill ("trigger");
	level.flags["KubelDuck_Moody"] = true;
	
	wait 2;
	level notify ("BMW Go");
}

moody_restart_anims()
{
	level notify ("Stop Moody Anim");
	thread maps\carride_anim::moody_drive_idle();
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
		thread maps\carride_anim::driver_hardright();
		wait (1.0);
		thread maps\carride_anim::driver_hardleft();
		wait (1.0);
		thread maps\carride_anim::driver_hardright();
		wait (1.0);
		thread maps\carride_anim::driver_hardleft();
		wait (1.0);
		thread maps\carride_anim::driver_hardright();
		wait (0.5);
		thread maps\carride_anim::driver_hardleft();
	}
	else
	{
		thread maps\carride_anim::driver_hardright();
	}
}

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
		thread maps\carride_anim::driver_hardleft();
		wait (2.5);
		level notify ("Convoy Gap");
		wait (2.5);
		thread maps\carride_anim::driver_hardright();
	}
	else
	{
		thread maps\carride_anim::driver_hardleft();
	}
}

nodewaits()
{
	level.elderanim = (0);
	
	while (level.eldernode < 2)
		wait .25;
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);
	
	thread maps\carride_anim::elder_shoot(2, 1.5);//make elder shoot. (delay, length)
	
	while (level.eldernode < 3)
		wait .25;
	thread maps\carride_anim::play_rand_anim(2,undefined,undefined);
	
	thread maps\carride_anim::elder_shoot(1, 2);
	
	while (level.eldernode < 4)
		wait .25;
	thread maps\carride_anim::play_rand_anim(0,undefined,undefined);
	
	while (level.eldernode < 5)
		wait .25;
	thread maps\carride_anim::play_rand_anim(3,undefined,undefined);
	
	thread maps\carride_anim::elder_shoot(0, 6.5);
	level.elder waittill ("animdone");
	thread maps\carride_anim::play_rand_anim(3,1,undefined);
	
	while (level.eldernode < 6)
		wait .25;
	thread maps\carride_anim::play_rand_anim(1,undefined,undefined);
	
	while (level.eldernode < 7)
		wait .25;
	thread maps\carride_anim::play_rand_anim(3,undefined,undefined);
	level.elder waittill ("animdone");
	thread maps\carride_anim::play_rand_anim(0,undefined,undefined);
	
	while (level.eldernode < 8)
		wait .25;
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);//starts shooting at kubelwagon
	//level.elder waittill ("animdone");
	//thread maps\carride_anim::play_rand_anim(2,undefined,undefined);
	
	while (level.eldernode < 9)
		wait .25;
	thread maps\carride_anim::play_rand_anim(2,undefined,undefined);
	level.elder waittill ("animdone");
	
	//#######################################################
	//CHAD - ONLY DO THE NEXT LINE IF KUBEL1 IS STILL DRIVING
	if (level.flags["KubelCrash1"] == false)
		thread maps\carride_anim::elder_shoot(0, 2);
	//#######################################################
	
	wait 2;
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);
	
	while (level.eldernode < 10)
		wait .25;
	thread maps\carride_anim::play_rand_anim(2,undefined,undefined);
	
	//#######################################################
	//CHAD - ONLY DO THE NEXT LINE IF KUBEL1 IS STILL DRIVING
	if (level.flags["KubelCrash1"] == false)
		thread maps\carride_anim::elder_shoot(0, 3);
	//#######################################################
	
	wait 3;
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);
	level.elder waittill ("animdone");
	thread maps\carride_anim::play_rand_anim(0,undefined,undefined);
	
	while (level.eldernode < 11)
		wait .25;
	
	wait 6;
	thread maps\carride_anim::play_rand_anim(3,undefined,undefined);
	level.elder waittill ("animdone");
	thread maps\carride_anim::elder_shoot(.5, 1);
	wait 1.5;
	thread maps\carride_anim::play_rand_anim(5,undefined,undefined);
	wait 1;
	thread maps\carride_anim::play_rand_anim(2,undefined,undefined);
	level.elder waittill ("animdone");
	wait 3;
	
	//#######################################################
	//CHAD - ONLY DO THE NEXT LINE IF KUBEL2 OR KUBEL3 IS STILL DRIVING
	if ((level.flags["KubelCrash2"] == false) || (level.flags["KubelCrash3"] == false))
		thread maps\carride_anim::elder_shoot(0, 2.5);
	//#######################################################
	
	while (level.eldernode < 12)
		wait .25;
	thread maps\carride_anim::play_rand_anim(0,undefined,undefined);//car chase is over, entering town
	
	while (level.eldernode < 13)
		wait .25;
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);
	thread maps\carride_anim::elder_shoot(0, 4);
	level.elder waittill ("animdone");
	thread maps\carride_anim::play_rand_anim(2,undefined,undefined);
	level.elder waittill ("animdone");
	level.elder waittill ("animdone");
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);
	
	while (level.eldernode < 14)
		wait .25;
	thread maps\carride_anim::play_rand_anim(0,undefined,undefined);
	
	while (level.eldernode < 15)
		wait .25;
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);
	thread maps\carride_anim::elder_shoot(1, 1);
	
	while (level.eldernode < 16)
		wait .25;
	thread maps\carride_anim::play_rand_anim(0,undefined,undefined);//going down alley before breaking through fence
	
	thread tankstart();
	
	while (level.eldernode < 17)
		wait .25;
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);
	thread maps\carride_anim::elder_shoot(0, 2);
	level.elder waittill ("animdone");
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);
	
	while (level.eldernode < 18)
		wait .25;
	thread maps\carride_anim::play_rand_anim(2,undefined,undefined);
	
	while (level.eldernode < 19)
		wait .25;
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);
	thread maps\carride_anim::elder_shoot(1, 2);
	level.elder waittill ("animdone");
	thread maps\carride_anim::play_rand_anim(0,undefined,undefined);//idle while breaking fences
	
	while (level.eldernode < 20)
		wait .25;
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);
	thread maps\carride_anim::elder_shoot(2, 2);
	
	while (level.eldernode < 21)
		wait .25;
	thread maps\carride_anim::play_rand_anim(2,undefined,undefined);
	
	while (level.eldernode < 22)
		wait .25;
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);
	
	level.elder waittill ("animdone");
	thread maps\carride_anim::play_rand_anim(0,undefined,undefined);
}

elder_anim_triggers()
{
	level.elderanim = (0);
	
	keynode[0]	= ("auto11");
	keynode[1]	= ("auto15");
	keynode[2]	= ("auto18");
	keynode[3]	= ("auto28");
	keynode[4]	= ("auto57");
	keynode[5]	= ("auto36");
	keynode[6]	= ("auto66");
	keynode[7]	= ("auto67");
	keynode[8]	= ("auto71");
	keynode[9]	= ("auto72");
	keynode[10]	= ("auto88");
	keynode[11]	= ("auto257");
	keynode[12]	= ("auto167");
	keynode[13]	= ("auto172");
	keynode[14]	= ("auto178");
	keynode[15]	= ("auto187");
	keynode[16]	= ("auto189");
	keynode[17]	= ("auto191");
	keynode[18]	= ("auto266");
	keynode[19]	= ("auto272");
	keynode[20]	= ("auto289");
	
	for (i=0;i<keynode.size;i++)
	{
		level.peugeot setWaitNode(getVehicleNode(keynode[i],"targetname"));
		level.peugeot waittill ("reached_wait_node");
		level.eldernode = (level.eldernode + 1);
	}
}

player_usebutton()
{
	level endon ("ExitVehicle");
	while (1)
	{
		if(level.player useButtonPressed())
		{
			level.peugeot thread maps\carride_anim::peugeot_moveplayer();
			//wait (1);
			level.peugeot waittillmatch ("leandone","end");
			while (level.player useButtonPressed())
				waitframe();
		}
		waitframe();
	}
}

firstguys()
{
	firstguy1 = getent ("firstguy1","targetname");
	firstguy2 = getent ("firstguy2","targetname");
	firstguy1_node = getnode ("firstguy1_node","targetname");
	firstguy2_node = getnode ("firstguy2_node","targetname");
	
	firstguy1.accuracy = 0.05;
	firstguy1.accuracyStationaryMod = 0.05;
	firstguy1.favoriteEnemy = level.player;
	
	firstguy2.accuracy = 0.05;
	firstguy2.accuracyStationaryMod = 0.05;
	firstguy2.favoriteEnemy = level.player;
	
	getent ("firstguys_trigger","targetname") waittill ("trigger");
	
	if ( (isdefined (firstguy1)) && (isalive (firstguy1)) )
	{
		firstguy1.goalradius = (16);
		firstguy1.old_maxsightdistsqrd = firstguy1.maxsightdistsqrd;
		firstguy1.maxsightdistsqrd = 3;
		firstguy1 allowedstances ("stand");
		firstguy1.bravery = (5000);
		firstguy1 setgoalnode (firstguy1_node);
		firstguy1 thread firstguys_wait(firstguy1.old_maxsightdistsqrd);
	}
	
	if ( (isdefined (firstguy2)) && (isalive (firstguy2)) )
	{
		firstguy2.goalradius = (16);
		firstguy2.old_maxsightdistsqrd = firstguy2.maxsightdistsqrd;
		firstguy2.maxsightdistsqrd = 3;
		firstguy2 allowedstances ("stand");
		firstguy2.bravery = (5000);
		firstguy2 setgoalnode (firstguy2_node);
		firstguy2 thread firstguys_wait(firstguy2.old_maxsightdistsqrd);
	}
}

firstguys_wait(maxsight)
{
	self endon ("death");
	self waittill ("goal");
	self.maxsightdistsqrd = maxsight;
}

objectives()
{
	objective_add(1, "active", &"CARRIDE_OBJECTIVE_HQ", (-3300, -35860, 788));
	objective_current(1);
	
	level waittill ("Objective_NewCar");
	
	objective_add(2, "active", &"CARRIDE_OBJECTIVE_NEWCAR", (14006, -40027, 764));
	objective_current(2);
	
	level waittill ("Objective_Hotwire");
	
	objective_state(2, "done");
	objective_add(3, "active", &"CARRIDE_OBJECTIVE_DEFEND_ELDER", (14006, -40027, 764));
	objective_current(3);
	
	level waittill ("Objective_GetInCar");
	
	objective_state(3, "done");
	objective_add(4, "active", &"CARRIDE_OBJECTIVE_GETINCAR", (14006, -40027, 764));
	objective_current(4);
	
	level waittill ("Objective_InCar");
	objective_state(4, "done");
	objective_current(1);
}

player_init()
{
	level.player.ignoreme = (true);
	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowCrouch(false);
	level.player setorigin ((level.peugeot getTagOrigin ("tag_player")));
	//level.player playerlinkto (level.peugeot, "tag_player", ( .3, .3, .3 ));
	level.player playerlinkto (level.peugeot, "tag_player", ( 1, 1, 1 ));
	
	//make sure the player doesn't have a panzerfaust since most vehicles cannot be destroyed by it in this level
	hasweapon_panzerfaust = level.player hasweapon("panzerfaust");
	if (hasweapon_panzerfaust == true)
		level.player takeweapon("panzerfaust");
	
	//Make sure the player has an automatic weapon
	//hasautoweapon = false;
	hasweapon_mp40 = level.player hasweapon("mp40");
	if (hasweapon_mp40 == true)
		return;
	hasweapon_mp44 = level.player hasweapon("mp44");
	if (hasweapon_mp44 == true)
		return;
	hasweapon_bar = level.player hasweapon("bar");
	if (hasweapon_bar == true)
		return;
	hasweapon_fg42 = level.player hasweapon("fg42");
	if (hasweapon_fg42 == true)
		return;
	hasweapon_thompson = level.player hasweapon("thompson");
	if (hasweapon_thompson == true)
		return;
	hasweapon_thompson = level.player hasweapon("thompson");
	if (hasweapon_thompson == true)
		return;
	
	//If it makes it this far, the player doesn't have an automatic weapon
	//Check to see what weapon slot the player is using
	currentweapon = level.player getCurrentWeapon();
	slot1weapon = level.player getWeaponSlotWeapon("primary");
	if (currentweapon == slot1weapon)
		level.player setWeaponSlotWeapon("primaryb", "thompson");
	else
		level.player setWeaponSlotWeapon("primary", "thompson");
}

start_drive()
{
	peugeot_window_setup();
	
	path = getVehicleNode (level.peugeot.target,"targetname");
	level.peugeot attachpath(path);
	level.peugeot thread maps\_treads::main();
	
	sound_ent = spawn ("script_origin",level.peugeot.origin);
	
	sound_ent playloopsound("peugeot_engine_high");
	
	level waittill ("starting final intro screen fadeout");
	level.peugeot startpath();
	level.player.ignoreme = (false);
	sound_ent stoploopsound("peugeot_engine_high");
	sound_ent delete();
	
	wait 15;
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_LEANOUTWINDOW", getKeyBinding("+activate"));
}
/*
place_thompson()
{
	hasweapon_thompson = level.player hasweapon("thompson");
	if (hasweapon_thompson == true)
		return;
	else
	{
		//attach the thompson to the car so the player can have one in this level
		thompson = spawn ("weapon_thompson", (level.peugeot.origin + (-15, 1, 19)));
		thompson.angles = (0, 175, 0);
		thompson linkto (level.peugeot);
	}
}
*/
prone_control()
{
	guys1 = getaiarray("axis");
	guys2 = getspawnerteamarray("axis");
	for (i=0;i<guys1.size;i++)
		if (isdefined (guys1[i]))
			if (isalive (guys1[i]))
				guys1[i] allowedstances ("crouch", "stand");
	for (i=0;i<guys2.size;i++)
		if (isdefined (guys2[i]))
			guys2[i] thread prone_control_guy();
}

prone_control_guy()
{
	self waittill ("spawned", spawned);
	spawned allowedstances ("crouch", "stand");
}

delete_guys()
{
	self waittill ("trigger");
	guys = getaiarray("axis");
	
	for (i=0;i<guys.size;i++)
		if (isdefined (guys[i]))
		if(isalive (guys[i]))
		if ( (isdefined (guys[i].script_noteworthy)) && (guys[i].script_noteworthy == self.script_noteworthy) )
			guys[i] delete();
}

dialogue_triggers()
{
	getent ("dialogue_trig1","targetname") waittill ("trigger");
		thread dialogue_roadblock();
	getent ("dialogue_trig2","targetname") waittill ("trigger");
		thread dialogue_convoy();
	
	level waittill ("ExitVehicle");
		thread dialogue_crash();
	
	level waittill ("Going to Kubelwagon");
		thread dialogue_stealcar();
	
	level waittill ("HotWire");
		thread dialogue_hotwire();
	
	level waittill ("Objective_InCar");
		thread dialogue_leavegarage();
	
	getent ("dialogue_trig3","targetname") waittill ("trigger");
		thread dialogue_clearedlines();
	
	getent ("dialogue_trig4","targetname") waittill ("trigger");
		thread dialogue_turnright();
	
	level waittill ("EndDialogue");
		thread dialogue_reporthq();
}

dialogue_roadblock()
{
	//ROADBLOCK
		//Ugh! That's a German roadblock. What now?
			level.elder.scripted_dialogue = ("carride_elder_roadblock");
			level.elder.facial_animation = (level.scr_anim["face"]["thatsagerman"]);
			level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["thatsagerman"]);
			level.elder waittill ("scripted_anim_facedone");
		
		//Gee I don’t know, how about you try shoot'n the bastards.
			thread maps\carride_anim::moody_driver_dialogue_anim(1);
			wait (7);
			
		//Adios, amigos
			thread maps\carride_anim::moody_driver_dialogue_anim(2);
}

dialogue_convoy()
{
	//CONVOY GAP
		//What the hell are you doing Sarge?
			level.elder.scripted_dialogue = ("carride_elder_whatthehell");
			level.elder.facial_animation = (level.scr_anim["face"]["whatthehell"]);
			level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["whatthehell"]);
			level.elder waittill ("scripted_anim_facedone");
			//level.elder waittillmatch ("animdone","end");
			
		//I don't know, sure hope it works.
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["hopeitworks"], "carride_Moody_049", 1.0);
		
		level waittill ("Convoy Gap");
		
		//Hit it! Go! Go! Go!
			level.elder.scripted_dialogue = ("carride_elder_hitit");
			level.elder.facial_animation = (level.scr_anim["face"]["hititgo"]);
			level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["hititgo"]);
			
			wait (8);
			
		//Come on guys, stop ‘em.
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["stopem"], "carride_Moody_050", 1.0);
}

dialogue_crash()
{
	//PEUGEOT CRASH
		//Oh hey, great. Good move. Remind me to thank the captain.
			wait (1.0);
			level.elder thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["ohheygreat"], "carride_elder_goodmove", 1.0, "dialoguedone");
			wait 3;
			//level.elder waittill ("dialoguedone");
			
		//Shut up Elder, and get your ass out. Let’s go Martin, move it, move.
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["shutup"], "carride_Moody_051", 1.0, "dialoguedone");
			wait 3.5;
			//level.moody waittill ("dialoguedone");
		
		//I can't believe I agreed to do this.
			level.elder thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["icantbelieve"], "carride_elder_cantbelieve", 1.0, "dialoguedone");
			wait 2.2;
			//level.elder waittill ("dialoguedone");
		
		//You didn't, remember? You were volunteered.
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["volunteered"], "carride_Moody_052", 1.0);
}

dialogue_stealcar()
{
	//STEAL A CAR
		//Elder, ever steal a car?
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["stealacar"], "carride_Moody_053", 1.0, "dialoguedone");
			wait 2;
			//level.moody waittill ("dialoguedone");
		
		//Only when I need one Sarge.
			level.elder thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["onlywhenineed"], "carride_elder_onlywhen", 1.0, "dialoguedone");
			//level.elder waittill ("dialoguedone");
}

dialogue_hotwire()
{
	//HOTWIRE CAR
		//Martin cover him! Damn it Elder, hurry up.
			//wait (4.0);
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["coverhim"], "carride_Moody_054", 1.0, "dialoguedone");
			wait 3.2;
			//level.moody waittill ("dialoguedone");
		
		//Workin' Sarge, I'm workin on it!
			level.elder thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["workinsarge"], "carride_elder_workin", 1.0, "dialoguedone");
			wait 1.8;
			//level.elder waittill ("dialoguedone");
			
			//wait (2.0);
		
		//Quit working and get done.
			level.moody thread animscripts\shared::LookAtEntity(level.elder, 1.2, "alert");
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["getdone"], "carride_Moody_055", 1.0, "dialoguedone");
			wait 3;
			//level.moody waittill ("dialoguedone");
		
		//Our father who art in heaven…
			level.elder thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["ourfather"], "carride_elder_ourfather", 1.0, "dialoguedone");
			wait 1;
			//level.elder waittill ("dialoguedone");
			
		//God's busy this is on you.
			level.moody thread animscripts\shared::LookAtEntity(level.elder, 1.0, "alert");
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["godsbusy"], "carride_Moody_056", 1.0, "dialoguedone");
			//level.moody waittill ("dialoguedone");
			
			wait (4.5);
			level.moody thread animscripts\shared::LookAtEntity(level.elder, 1.3, "alert");
			level.elder thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["elder_kubelwagon_startcar"], "carride_elder_igotit", 1.0);
			wait (1.5);
			
			level.flags["KubelStart"] = true;		
			level waittill ("CarStarted");
		
		//In the car, Martin cover us.
			level.moody thread animscripts\shared::LookAtEntity(level.player, 1.0, "alert");
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["inthecar"], "carride_Moody_058", 1.0);
		
		level endon ("Player Entering Kubelagon");
		
		//Martin, over here. Get in the car.
			wait 6;
			level.moody thread animscripts\shared::LookAtEntity(level.player, 1.0, "alert");
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["inthecar"], "dawnville_moody_getincar", 1.0);
}

dialogue_leavegarage()
{
	//KUBELWAGON LEAVES GARAGE
		//Step on it, get us outta here.
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["steponit"], "carride_Moody_059", 1.0, "dialoguedone");
			wait 3;
			//level.moody waittill ("dialoguedone");
			
			wait (1.0);
			
		//Come on Elder, faster, hit it.
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["comeonelder"], "carride_Moody_060", 1.0, "dialoguedone");
			wait 2.5;
			//level.moody waittill ("dialoguedone");
		
		//I AM driving faster!
			level.elder thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["iamdriving"], "carride_elder_drivingfaster", 1.0, "dialoguedone");
			wait (8);
			//level.elder waittill ("dialoguedone");
		
		//Turn right. Right up there.
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["turnright"], "carride_Moody_061", 1.0, "dialoguedone");
			wait 1.5;
			//level.moody waittill ("dialoguedone");
			
		//What's it look like I'm doing, damnit?
			level.elder thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["whatsitlooklike"], "carride_elder_whatsitlook", 1.0, "dialoguedone");
			wait 1.7;
			//level.elder waittill ("dialoguedone");
			
		//You mean besides getting us killed.
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["getuskilled"], "carride_Moody_062", 1.0, "dialoguedone");
			wait 2;
			//level.moody waittill ("dialoguedone");
		
		//Well hey, you didn't finish the job.
			level.elder thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["youdidntfinishjob"], "carride_elder_finishjob", 1.0, "dialoguedone");
			//level.elder waittill ("dialoguedone");
}

dialogue_clearedlines()
{
	//CLEARED GERMAN LINES
		//We cleared the german lines. You can slow down private.
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["clearedlines"], "carride_Moody_063", 1.0, "dialoguedone");
			wait 4;
			//level.moody waittill ("dialoguedone");
			
			wait (3.0);
			
		//I said you can slow down.
			level.moody thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["Isaidslowdown"], "carride_Moody_064", 1.0, "dialoguedone");
			wait 3;
			//level.moody waittill ("dialoguedone");
			
		//Oh yeah, right. Sorry Sarge.
			level.elder thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["ohyeahright"], "carride_elder_sorrysarge", 1.0);
}

dialogue_turnright()
{
	//TURN RIGHT HERE
		//Right turn, right here.
			level.moody.scripted_dialogue = ("carride_Moody_065");
			level.moody.facial_animation = (level.scr_anim["face"]["turnright"]);
			level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["turnright"]);
			level.moody waittill ("scripted_anim_facedone");
			
		//Yup, you got it. You got it.
			level.elder thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"]["yougotit"], "carride_elder_yougotit", 1.0);
}

dialogue_reporthq()
{
	//ELDER REPORTS TO HQ
		//I gotta go report in to Major Sheperd and get our orders. Take five but stay put.
			level.moody.scripted_dialogue = ("carride_Moody_066");
			level.moody.facial_animation = (level.scr_anim["face"]["igottago"]);
			level.moody animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_passenger")), (level.kubelwagon gettagAngles ("tag_passenger")), level.scr_anim["moody"]["igottago"]);
			level.moody waittill ("scripted_anim_facedone");
			
		//Okie doke Sarge. What the hell else am I gonna do?
			level.elder.scripted_dialogue = ("carride_elder_okiedoke");
			level.elder.facial_animation = (level.scr_anim["face"]["oksarge"]);
			level.elder animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_driver")), (level.kubelwagon gettagAngles ("tag_driver")), level.scr_anim["elder"]["oksarge"]);
			level.elder waittill ("scripted_anim_facedone");
			
			level notify ("EndLevel");
			
			while (1)
			{
				
				level.elder animscripted("animdone", (level.kubelwagon gettagOrigin ("tag_driver")), (level.kubelwagon gettagAngles ("tag_driver")), level.scr_anim["elder"]["restidle"]);
				level.elder waittillmatch ("animdone","end");
			}
}

convoy_setup()
{
	getent ("convoy_trigger","targetname") waittill ("trigger");
	for (i=0;i<level.convoy.size;i++)
	{
		path = getVehicleNode (level.convoy[i].target,"targetname");
		level.convoy[i] attachpath(path);
		level.convoy[i] maps\_truck::init();
		level.convoy[i] maps\_truck::attach_guys();
		level.convoy[i].isalive = 1;
		level.convoy[i] thread convoy_wait();
	}
	
	level.chasecar1 attachpath( getVehicleNode (level.chasecar1.target,"targetname") );
	level.chasecar1 maps\_kubelwagon::init();
	level.chasecar1 maps\_kubelwagon::attach_guys();
	level.chasecar1.isalive = 1;
	level.chasecar1 thread hittree();
	level.chasecar1.attachedpath = getVehicleNode (level.chasecar1.target,"targetname");
	level.chasecar1 thread maps\_vehiclechase::enemy_vehicle_paths();
	level.chasecar1 thread convoy_wait(1);
	level.chasecar1 thread kubel_crash_wait(1);
	
	level.chasecar2 attachpath( getVehicleNode (level.chasecar2.target,"targetname") );
	level.chasecar2 maps\_kubelwagon::init();
	level.chasecar2 maps\_kubelwagon::attach_guys();
	level.chasecar2.isalive = 1;
	level.chasecar2.attachedpath = getVehicleNode (level.chasecar2.target,"targetname");
	level.chasecar2 thread maps\_vehiclechase::enemy_vehicle_paths();
	level.chasecar2 thread convoy_wait(2);
	level.chasecar2 thread kubel_crash_wait(2);
}

kubel_crash_wait(num)
{
	self waittill ("crashpath");
	if (num == 1)
		level.flags["KubelCrash1"] = true;
	else if (num == 2)
		level.flags["KubelCrash2"] = true;
	else if (num == 3)
		level.flags["KubelCrash3"] = true;
}

convoy_wait(num)
{
	self endon ("death");
	wait (1.2);
	self startpath();
	wait (4.9);
	self setspeed(0,15);
	
	wait (1.2);
	
	if (self.vehicletype == "kubelwagon")
	{
		if (isdefined (num))
		{
			if (num == 1)
			{
				self.health = 1500;
				wait (2.9);
				self resumespeed(6);
				wait 5;
				self notify ("groupedanimevent","stand");
				wait 5;
				self notify ("groupedanimevent","stand");
				wait 5;
				self notify ("groupedanimevent","stand");
				return;
			}
			else if (num == 2)
			{
				self.health = 1500;
				wait (2.5);
				self resumespeed(5);
				wait 5;
				self notify ("groupedanimevent","stand");
				wait 5;
				self notify ("groupedanimevent","stand");
				wait 5;
				self notify ("groupedanimevent","stand");
				wait 5;
				self notify ("groupedanimevent","stand");
				return;
			}
		}
		else
		{
			wait (2.5);
		}
	}
	self resumespeed(5);
	self waittill ("reached_end_node");
	self notify ("unload");
	thread spawncar3();
}

spawncar3()
{
	getent ("spawncar3","targetname") waittill ("trigger");
	
	tank2 = getent ("tanksmoke","targetname");
	playfx( level._effect["tanksmoke"], tank2.origin );
	
	level.chasecar3 attachpath( getVehicleNode (level.chasecar3.target,"targetname") );
	level.chasecar3 maps\_kubelwagon::init();
	level.chasecar3 maps\_kubelwagon::attach_guys();
	level.chasecar3.isalive = 1;
	level.chasecar3.attachedpath = getVehicleNode (level.chasecar3.target,"targetname");
	level.chasecar3 thread maps\_vehiclechase::enemy_vehicle_paths();
	level.chasecar3 thread lastchaser();
	level.chasecar3 thread kubel_crash_wait(3);
}

lastchaser()
{
	self endon ("death");
	self endon ("reached_end_node");
	getent ("startcar3","targetname") waittill ("trigger");
	wait (0.5);
	self startpath();
	thread autosave2();
	wait (2.0);
	while (1)
	{
		self notify ("groupedanimevent","stand");
		wait 5;
	}
}

hittree()
{
	self endon ("death");
	self waittill ("reached_end_node");
	if ( (isdefined (self)) && (isalive (self)) )
		self notify ("death");
		self setspeed(0,15);
}

tankstart()
{
	tank = spawnVehicle( "xmodel/vehicle_tank_tiger_camo", "vclogger", "PanzerIV" ,(0,0,0), (0,0,0) );
	tank maps\_tiger::init();
	tanktarget = getent ("tanktarget","targetname");
	path = getVehicleNode ("auto301","targetname");
	tank attachpath(path);
	tank.isalive = 1;
	tank.health = (1000000);
	getent ("tankstart","targetname") waittill ("trigger");
	thread rearendcar();
	thread startreverse();
	
	tank maps\_tankgun::mgoff();
	
	tank startpath();
	wait 4.5;
	tank setspeed(0,15);
	
	wait 2;
	//Hit it! Go! Go! Go!
		level.elder.scripted_dialogue = ("carride_elder_hitit");
		level.elder.facial_animation = (level.scr_anim["face"]["hititgo"]);
		level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["hititgo"]);
	
	wait 1;
	
	tank setTurretTargetEnt(level.peugeot, (0, 0, 64) );
	tank setspeed(1,15);
	wait 2;
	tank resumespeed(5);
	wait 1;
	
	tank setTurretTargetEnt(tanktarget, (0, 0, 0) );
	wait 2;
	tank clearTurretTarget();
	tank thread maps\_tiger::fire();
	level notify ("Explode");
	tanktarget playsound ("explo_rock");
	
	tank thread tank_shoot_target2();
	
	while (level.flags["bumpy"] == true)
		wait (0.5);
	
	while (level.goalinc < 2)
		wait (0.5);
	
	tank maps\_tankgun::mgon();
	tank resumespeed(5);
	level waittill ("KubelMoving");
	tank delete();
	thread tank_dosequence2();
}

tank_shoot_target2()
{
	wait 6;
	tanktarget2 = getent ("tanktarget2","targetname");
	self setTurretTargetEnt(tanktarget2, (0, 0, 0) );
	self waittill ("turret_on_target");
	self clearTurretTarget();
	self thread maps\_tiger::fire();
	level notify ("Explode2");
	tanktarget2 playsound ("explo_rock");
	wait 14;
	tanktarget3 = getent ("tanktarget3","targetname");
	self setTurretTargetEnt(tanktarget3, (0, 0, 0) );
	self waittill ("turret_on_target");
	self clearTurretTarget();
	wait 1;
	self thread maps\_tiger::fire();
	radiusDamage (tanktarget3.origin, 250, 600, 50);
	thread maps\_fx::OneShotfx("tankdirt", tanktarget3.origin, .2);
}

tank_dosequence2()
{
	tank = spawnVehicle( "xmodel/vehicle_tank_tiger_camo", "vclogger", "PanzerIV" ,(0,0,0), (0,0,0) );
	tank maps\_tiger::init();
	
	//get the path
	path = getVehicleNode ("tank2path","targetname");
	
	//put the tank on the path and wait
	tank attachpath(path);
	tank thread maps\_tankgun::mgoff();
	
	getent ("starttank2","targetname") waittill ("trigger");
	
	//do shooting sequences
	tank thread move_tank2();
	
	tank2target1 = getent ("tank2target1","targetname");
	tank setTurretTargetEnt(tank2target1, (0, 0, 0) );
	tank waittill ("turret_on_target");
	tank clearTurretTarget();
	tank thread maps\_tiger::fire();
	thread maps\_fx::OneShotfx("tankdirt", tank2target1.origin, .25);
	
	tank setTurretTargetEnt(level.kubelwagon, (0, 0, 0) );
	
	finaltanktarget_1 = getent ("finaltanktarget_1","targetname");
	finaltanktarget_2 = getent ("finaltanktarget_2","targetname");
	
	wait 10;
	tank thread maps\_tiger::fire();
	thread maps\_fx::OneShotfx("tankdirt", finaltanktarget_1.origin, .25);
	
	wait 3;
	tank thread maps\_tiger::fire();
	thread maps\_fx::OneShotfx("tankdirt", finaltanktarget_2.origin, .25);
	
	
}

move_tank2()
{
	wait 6;
	//move the tank along the path
	self startpath();
	self setspeed (10,5);
}

follow_trigger()
{
	getent ("follow_trigger","targetname") waittill ("trigger");
	
	level.moody.followmax 	= 0;
	level.moody.followmin 	= -2;
	level.moody.goalradius	= (16 + randomint(16));
	level.moody setgoalentity (level.player);
	
	level.elder.followmax 	= 0;
	level.elder.followmin 	= -2;
	level.elder.goalradius	= (16 + randomint(16));
	level.elder setgoalentity (level.player);
}

house_explosion()
{
	before 	= getentarray ("explosion_before","targetname");
	after 	= getentarray ("explosion_after","targetname");
	fxmodel = getentarray ("explosion_fx","targetname");
	
	after = [];
	for (i=0;i<fxmodel.size;i++)
		if (isdefined (fxmodel[i]))
			after[after.size] = fxmodel[i];
	
	for (i=0;i<after.size;i++)
		after[i] hide();
	
	level waittill ("Explode");
	
	before 	= getentarray ("explosion_before","targetname");
	after 	= getentarray ("explosion_after","targetname");
	fxmodel = getentarray ("explosion_fx","targetname");
	
	//level.player shellshock("default", 1);
	
	for (i=0;i<fxmodel.size;i++)
		if (isdefined(fxmodel[i]))
			fxmodel[i] thread maps\_utility::cannon_effect(fxmodel[i]);
	
	for (i=0;i<after.size;i++)
		after[i] show();
	
	for (i=0;i<before.size;i++)
	{
		before[i] connectpaths();
		before[i] delete();
	}
}

house_explosion2()
{
	before 	= getentarray ("explosion_before2","targetname");
	after 	= getentarray ("explosion_after2","targetname");
	fxmodel = getentarray ("explosion_fx2","targetname");
	
	for (i=0;i<fxmodel.size;i++)
		if (isdefined (fxmodel[i]))
			after[after.size] = fxmodel[i];
		//after = maps\_utility::add_to_array (after, fxmodel[i]);
	
	for (i=0;i<after.size;i++)
		after[i] hide();
	
	level waittill ("Explode2");
	
	before 	= getentarray ("explosion_before2","targetname");
	after 	= getentarray ("explosion_after2","targetname");
	fxmodel = getentarray ("explosion_fx2","targetname");
	
	for (i=0;i<fxmodel.size;i++)
		if (isdefined(fxmodel[i]))
			fxmodel[i] thread maps\_utility::cannon_effect(fxmodel[i]);
	
	for (i=0;i<after.size;i++)
		after[i] show();
	
	for (i=0;i<before.size;i++)
		before[i] delete();
}

rearendcar()
{
	rearendcar = getent ("rearendcar","targetname");
	
	getent ("rearendcar_start","targetname") waittill ("trigger");
	rearendcar maps\_kubelwagon::init();
	rearendcar maps\_kubelwagon::attach_guys();
	path = getVehicleNode (rearendcar.target,"targetname");
	rearendcar attachpath(path);
	rearendcar.isalive = 1;
	rearendcar.health = (1000000);
	
	wait (3);
	rearendcar startpath();
	
	rearendcar waittill ("reached_end_node");
	rearendcar notify ("unload");
	level waittill ("rearend_crash");
	
	kubelguys = getaiarray ("axis");
	for (i=0;i<kubelguys.size;i++)
	{
		if ( (isdefined (kubelguys[i].script_noteworthy)) && (kubelguys[i].script_noteworthy == "crushed") )
		{
			if ( (isdefined (kubelguys[i])) && (isalive (kubelguys[i])) )
			{
				kubelguys[i] dodamage ((kubelguys[i].health + 100),(0,0,0));
			}
		}
	}
	
	fx = loadfx("fx/explosions/explosion1.efx");
	rearendcar.isalive = 0;
	level.player playsound ("explo_metal_rand");
	playfx (fx, rearendcar.origin );
	earthquake(0.25, 3, rearendcar.origin, 1050);
	wait .5;
	rearendcar setmodel ("xmodel/vehicle_german_kubelwagen_d");
	
	musicPlay("redsquare_dark");
}

startreverse()
{
	level.peugeot setWaitNode(getVehicleNode("auto296","targetname"));
	level.peugeot waittill ("reached_wait_node");
	
	level.moodyanim = 1;	//starts moody reverse anim, carride_anim script then loops reverse_loop until I change it
	level notify ("Stop Moody Anim");
	thread maps\carride_anim::moody_drive_idle();
	
	thread maps\carride_anim::play_rand_anim(4,undefined,undefined);//starts elder reverse anim, carride_anim script then loops reverse_loop until I change it
	
	level.peugeot setWaitNode(getVehicleNode("auto302","targetname"));//node car should stop
	level.peugeot waittill ("reached_wait_node");
	level.peugeot setspeed(0,25);//car stopped now
	
	level.peugeot setWaitNode(getVehicleNode("auto305","targetname"));//node car should stop
	level.peugeot setspeed(15,10);
	level.peugeot waittill ("reached_wait_node");
	wait (0.5);
	level.peugeot setspeed(0,25);//car stopped now
	thread maps\carride_anim::moody_reverse2forward();
	thread maps\carride_anim::play_rand_anim(0,undefined,undefined);
	
	level.peugeot setWaitNode(getVehicleNode("auto1660","targetname"));
	level.peugeot waittill ("reached_wait_node");
	
	level.moodyanim = 1;
	level notify ("Stop Moody Anim");
	thread maps\carride_anim::moody_drive_idle();
	
	level.peugeot setWaitNode(getVehicleNode("auto315","targetname"));
	level.peugeot waittill ("reached_wait_node");
	level.peugeot setspeed(0,25);//car stopped now
	wait (1.5);
	level.peugeot setspeed(15,10);
	wait 1;
	thread maps\carride_anim::play_rand_anim(8,undefined,undefined);
	
	level.peugeot waittill ("reached_end_node");
	level.peugeot playsound ("barricade_smash");
	level.player allowCrouch(false);
	level notify ("rearend_crash");
	thread follow_trigger();
	level.flags["bumpy"] = false;
	level notify ("Objective_NewCar");
	level notify ("ExitVehicle");
	
	//-------------------------------------------------------------
	level.peugeot setmodel ("xmodel/vehicle_peugeot_carride");
	level.peugeot thread maps\carride_anim::peugeot_anims(9);
	//-------------------------------------------------------------
	
	level.moody animscripted("reversecrashdone", (level.peugeot gettagOrigin ("tag_driver")), (level.peugeot gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_crash"]);
	level.elder animscripted("animdone", (level.peugeot gettagOrigin ("tag_passenger")), (level.peugeot gettagAngles ("tag_passenger")), level.scr_anim["elder"]["peugeot_reverse_crash"]);
	
	dummy = spawn ("script_origin",(level.peugeot getTagOrigin ("tag_player")));
	level.player playerlinkto (dummy);
	
	level.elder unlink();
	level.moody unlink();
	
	level.peugeot disconnectpaths();
	level.player allowLeanLeft(true);
	level.player allowLeanRight(true);
	
	level notify ("CanProne");
	level.player allowCrouch(true);
	
	level.moody.goalradius = (16);
	level.moody setgoalnode (getnode("auto347","targetname"));
	level.moody thread waittill_goal_thread();
	
	level.elder.goalradius = (16);
	level.elder setgoalnode (getnode("auto348","targetname"));
	level.elder thread waittill_goal_thread();
	
	//#########################################################################
	//#########################################################################
	wait 3;
	dest_org = (12252, -42908, 780);
	dummy moveTo(dest_org, .5, .2, .2);
	wait (.5);
	/*
	crashclipping = getentarray ("crashclipping","targetname");
	for (i=0;i<crashclipping.size;i++)
	{
		if (isdefined (crashclipping[i]))
			crashclipping[i] solid();
	}
	*/
	level.player unlink();
	level.player allowCrouch(true);
	//#########################################################################
	//#########################################################################
	
	level.moody.failWhenKilled = true;
	level.elder.failWhenKilled = true;
	
	getent ("inhouse","targetname") waittill ("trigger");
	maps\_utility::autosave(3); //in the house
	
	guys = getaiarray("axis");
	for (i=0;i<guys.size;i++)
		if (isdefined (guys[i]))
		if(isalive (guys[i]))
		if ( (isdefined (guys[i].script_noteworthy)) && (guys[i].script_noteworthy == "deleteguys8") )
			guys[i] delete();
	
	getent ("goto_new_car","targetname") waittill ("trigger");
	level notify ("Going to Kubelwagon");
	level.moody thread moody_kubelwagon();
	level.elder thread elder_kubelwagon();
	level.player thread player_kubelwagon();
	thread flood_control();
}

waittill_goal_thread()
{
	self waittill ("goal");
	level.goalinc++;
}

flood_control()
{
	trig = getent ("flood_spawner","targetname");
	trig thread maps\_utility::triggerOff();
	level waittill ("FloodSpawn");
	trig thread maps\_utility::triggerOn();
}

kubelwagon_setup()
{
	path = getVehicleNode (level.kubelwagon.target,"targetname");
	level.kubelwagon attachpath(path);
	//level.kubelwagon disconnectpaths();
	level.kubelwagon maps\_kubelwagon::init();
	level.kubelwagon thread give_health();
	
	//level.kubelwagon_model = spawn ("script_model",level.kubelwagon.origin);
	//level.kubelwagon_model.angles = (0, 270, 0);
	//level.kubelwagon_model setmodel ("xmodel/static_vehicle_german_kubelwagen");
	//level.kubelwagon hide();
}

elder_kubelwagon()
{
	self.bravery = 500000;
	self allowedstances ("stand");
	self.goalradius = 4;
	eldernode = getnode("elder_kubelwagon","targetname");
	self setgoalnode (eldernode);
	while (distance(self.origin,eldernode.origin) > 25)
		wait .25;
	level notify ("Objective_Hotwire");
	level notify ("ElderAtKubelwagon");
	thread maps\carride_anim::elder_kubelwagon();
}

moody_kubelwagon()
{
	self.bravery = 500000;
	self allowedstances ("stand");
	self.goalradius = 4;
	node = getnode("moody_kubelwagon","targetname");
	self setgoalnode (node);
	while (distance(self.origin,node.origin) > 25)
		wait .25;
	level notify ("MoodyAtKubelwagon");
	thread maps\carride_anim::moody_kubelwagon();
}

player_kubelwagon()
{
	level.moody pushPlayer(true);
	level.elder pushPlayer(true);
	level maps\_utility::waittill_multiple("MoodyAtKubelwagon","ElderAtKubelwagon");
	level.moody pushPlayer(false);
	level.elder pushPlayer(false);
	level notify ("HotWire");
	maps\_utility::autosave(4);//stealing the kubelwagon
	
	level waittill ("KubelwagonStarted");
	level notify ("Objective_GetInCar");
	trig = getent ("kubelwagon_trigger","targetname");
	trig thread maps\_utility::triggerOn();
	trig waittill ("trigger");
	
	level notify ("Player Entering Kubelagon");
	
	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowCrouch(false);
	level.player allowProne(false);
	waitframe();
	
	//#########################################################################
	//#########################################################################
	dest_org = (level.kubelwagon getTagOrigin ("tag_player"));
	dummy = spawn ("script_origin",(level.player.origin));
	self playerlinkto (dummy);
	level.player freezeControls(true);
	dummy moveTo((dest_org + (0,0,15)), .35, .05, .05);
	wait (.25);
	dummy moveTo(dest_org, .5, .05, .05);
	wait (.5);
	self setorigin ((level.kubelwagon getTagOrigin ("tag_player")));
	self playerlinkto (level.kubelwagon, "tag_player", ( 0, 0, 0 ));
	wait .2;
	//self playerlinkto (level.kubelwagon, "tag_player", ( .3, .3, .3 ));
	self playerlinkto (level.kubelwagon, "tag_player", ( 1, 1, 1 ));
	level.player freezeControls(false);
	//#########################################################################
	//#########################################################################
	
	level.moody.failWhenKilled = false;
	level.elder.failWhenKilled = false;
	
	level notify ("Objective_InCar");
	level.flags["PlayerInKubel"] = true;
	thread kubel_duck();
	
	//level.kubelwagon show();
	wait (0.1);
	//level.kubelwagon_model delete();
	
	level.kubelwagon startpath();
	level notify ("KubelMoving");
	level.flags["bumpy"] = true;
	level.kubelwagon thread bumpy();
	level.kubelwagon thread maps\carride_anim::kubelwagon_bumpy();
	thread levelend();
	
	musicPlay("carride_b");
	
	wait (1.0);
	thread maps\carride_anim::driver_hardleft(0,"yes");
	wait (2.0);
	thread maps\carride_anim::driver_hardright(0,"yes");
}

peugeot_stayalive()
{
	level.peugeot endon ("death");
	level.peugeot.health = (10000);
	health = level.peugeot.health;
	while(1)
	{
		level.peugeot waittill ("damage");
		waitframe();
		level.peugeot.health = (health);
	}	
}

waitframe()
{
	maps\_spawner::waitframe();
}

give_health()
{
	health = (9999999999);
	self.health = (health);
	while (1)
	{
		self waittill ("damage");
		waitframe();
		self.health = (health);
	}
}

bumpy()
{
	while (level.flags["bumpy"] == true)
	{
		delay = randomfloat(1);
		jolt = randomfloat(.5);
		self joltbody((self.origin + (0,0,64)),jolt);
		wait (delay);
	}
}

levelend()
{
	thread patroller_look();
	
	level.kubelwagon waittill ("reached_end_node");
	level.flags["elder_end"] = true;
	level.flags["bumpy"] = false;
	level notify ("EndDialogue");
	objective_state(1, "done");
	level.moody thread passenger_exit_kubelwagon();
	level waittill ("EndLevel");
	wait (2);
	if (isalive (level.player))
		missionSuccess ("brecourt", false);
}

driver_exit_kubelwagon()
{
	delay = randomfloat(2);
	wait (delay);
	org = level.kubelwagon gettagOrigin ("tag_driver");
	angles = level.kubelwagon gettagAngles ("tag_driver");
	level notify ("ExitKubelwagon");
	self animscripted("driveranimdone", org, angles, %wagon_driver_jumpout);
	self waittillmatch ("driveranimdone","end");
	self unlink();
	self.failWhenKilled = true;
}

passenger_exit_kubelwagon()
{
	wait (4);
	org = level.kubelwagon gettagOrigin ("tag_passenger");
	angles = level.kubelwagon gettagAngles ("tag_passenger");
	level notify ("ExitVehicle");
	self unlink();
	level.moody.goalradius = (16);
	level.moody setgoalnode (getnode ("moody_levelend","targetname"));
}

ai_setup()
{
	guys = getaiarray("axis");
	for (i=0;i<guys.size;i++)
		if ( (isdefined (guys[i].script_accuracy)) && (!isdefined (guys[i].script_vehiclegroup)) )
		{
			guys[i].health = (40);
			guys[i].DropWeapon = false;
		}
	
	spawners = getspawnerteamarray("axis");
	for (i=0;i<spawners.size;i++)
		if ( (isdefined (spawners[i].script_accuracy)) && (!isdefined (spawners[i].script_vehiclegroup)) )
			spawners[i] thread sethealth(40);
}

sethealth(val)
{
	self waittill ("spawned", spawned);
	if (issentient (spawned))
	{
		wait 1;
		spawned.health = (val);
		spawned.DropWeapon = false;
	}
}

autosave1()
{
	getent ("autosave1","targetname") waittill ("trigger");
	
	if (level.player.health < (level.fullhealth / 2) )
		return;
	
	maps\_utility::autosave(1);
}

autosave2()
{
	getent ("autosave2","targetname") waittill ("trigger");
	
	if (level.player.health < (level.fullhealth / 2) )
		return;
	
	maps\_utility::autosave(2);
}

patroller_look()
{
	getent ("patroller_look","targetname") waittill ("trigger");
	patrollers = getaiarray ("allies");
	for (i=0;i<patrollers.size;i++)
		if ( (isdefined (patrollers[i].script_noteworthy)) && (patrollers[i].script_noteworthy == "patroller_look") )
			patrollers[i] thread animscripts\shared::LookAtEntity(level.player, randomfloat(2), "casual");
}