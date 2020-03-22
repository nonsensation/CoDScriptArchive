// anim_loop( guy, anime, tag, ender, node, tag_entity )
// anim_single (guy, anime, tag, node)
main()
{
/*
	player = getent("player", "classname" );
	player setorigin ((961, 1354, 495));
	return;
*/
//	setCvar("cg_draw2d", "0");
//	setCvar("cg_drawgun", "0");
//	wait (4);
	level.totalguys_array = [];

	if (getCvar("totalguys") == "")
		setCvar("totalguys", "");

	if (getCvar("camera") == "")
		setCvar("camera", "off");

	if (getcvar ("voiceover") == "")
		setCvar("voiceover", "off");

	if (getcvar("minguys") == "")
		setcvar("minguys", "0");

	if (getcvar("see") == "")
		setcvar("see", "");

	if (getcvar("squib") == "")
		setcvar("squib", "0");

	if (getcvar("scr_stalingrad_fast") == "1")
		level.maxHillAI = 16;
	else
		level.maxHillAI = 31;
	
	
	thread setsight();
//	thread print_queue();

	if (getcvar ("scr_stalingrad_fast") == "1")
		setCullFog(0, 6000, (float)116/(float)255,(float)122/(float)255,(float)126/(float)255, 1);
	else
		setExpFog(.00006022,  (float)120/(float)255,(float)127/(float)255,(float)131/(float)255, 0);  //rgb values RED
	
	maps\_utility::array_thread(getentarray( "smokeshield", "targetname" ), ::smokeshield_think);

	thread squib_print();

	// Set the shaders to use on the dead player screen
	setCvar("cg_deadscreen_backdrop", "levelshots/deadscreen/russian.jpg");
	setCvar("cg_deadscreen_levelname", "levelshots/deadscreen/hud@stalingrad.tga");

//	setcvar("start", "down");


	level.flag["breaking through explosion"] = false;
	level.flag["ready for gun"] = true;
	level.flag["ready for ammo"] = true;
	level.flag["sniper is talking"] = false;
	level.flag["artillery fire"] = false;
	level.flag["sniper time"] = false;
	level.flag["sniper talk"] = false;
	level.flag["spotter ready"] = false;
	level.flag["explosive finale"] = false;
	level.flag["animatic27"] = false;
	level.flag["boats should unload"] = true; // Decided to make this true cause it holds up boats too long otherwise
	level.flag["endgame"] = false;
	level.flag["fleeing guy spawned"] = false;
	level.flag["player approaches final commissar"] = false;
	level.flag["go go go"] = false;
	level.flag["stop all MG42s"] = false;
	level.flag["mg42guy mg42s stop"] = false;
	level.flag["final plane attack"] = false;


	drawCompassFriendlies(false);

	precacheShellshock("default");
//	precacheItem("WEAPON_MOSINNAGANTAMMO");
    precacheItem("stalingrad_ammo");

	character\RussianArmySniper::precache();
	character\RussianArmyOfficer_flagwave::precache();
	character\RussianArmy_pants::precache();
	character\RussianArmy_nohat::precache();
	character\RussianArmy::precache();
	character\RussianArmyOfficer_ppsh::precache();;
	character\RussianArmyOfficer::precache();;
	character\RussianArmyOfficer_shout1::precache();;
	character\RussianArmyOfficer_ppsh::precache();;
	character\RussianArmyOfficer_ammogiver::precache();;
	character\RussianArmyOfficer_giver::precache();;
	character\RussianArmyOfficer_flagwave::precache();;
	character\RussianArmyOfficer_shout2::precache();;
	character\RussianArmyWoundedTunic::precache();;
	character\RussianArmyDead2::precache();;
	character\RussianArmyDead1::precache();;
	character\RussianArmyRadioman_dead::precache();;
	character\RussianArmyOfficer_spotter::precache();;
	character\RussianArmyOfficer_radio::precache();;
	character\RussianArmy_pants::precache();;
	character\RussianArmyOfficer_AI::precache();;
	character\RussianArmySniper::precache();;
	character\RussianArmyOfficer_flagwave::precache();;

	precacheModel("xmodel/equipment_russian_fieldphone(parts)_pack_spotter");
	precacheModel("xmodel/largegroup_20");
	precacheModel("xmodel/gunpass_crowd");
	precacheModel("xmodel/stalingrad_flag");
	precacheModel("xmodel/viewmodel_ammo");
	precacheModel("xmodel/character_soviet_overcoat_torso");
	precacheModel("xmodel/stalingrad_megaphone");
	precacheModel("xmodel/vehicle_russian_barge_demolished");
	precacheModel("xmodel/vehicle_plane_stuka_lowdetail");
	precacheModel("xmodel/character_soviet_tunic");
	precacheModel("xmodel/basehead_stalingradsniper");
	precacheModel("xmodel/character_soviet_tunicwound1");
	precacheModel("xmodel/character_soviet_tunicwound2");
	precacheModel("xmodel/character_soviet_tunicwound3");
	precacheModel("xmodel/character_soviet_tunicwound4");
	precacheModel("xmodel/character_soviet_tunicwound5");
	precacheModel("xmodel/stalingrad_clips");
	precacheModel("xmodel/vehicle_russian_tugboat_d");
	precacheModel("xmodel/stalingrad_papers");
	
	//precacheShader("levelshots/brecourt.tga");
	//precacheShader("levelshots/pathfinder.tga");
	//precacheShader("levelshots/chateau.tga");
	//precacheShader("levelshots/dam.tga");
	
	level.flag["mg42_trigger"] = false;
	if (getcvar ("squib") == "0")
		maps\stalingrad_traces::main();
//	else
//		maps\_utility::error ("no squibs");

	maps\_load::main();
//	thread tempfunction();	
	
	setPlayerIgnoreRadiusDamage(true);

	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player.threatbias = 5000;
	level.player.ignoreme = true;
	level.shellshock_safetime = 0;
	level.climb_time = 25;
	level.playerSafeFromMG42Time = 2000;
	level.activeVehicles = 0;

/*
	if (!isdefined (level.scr_sound))
		println ("SCR SOUND IS NOT DEFINED YA whatever");
	else
		println ("exaggerated flesh impact is ", level.scr_sound ["exaggerated flesh impact"]);
*/
	maps\stalingrad_anim::main();

//	thread temp();

	maps\_drones::main();
	maps\stalingrad_fx::main();

	// Briefing
//	level.player briefing();
//	level.player maps\_briefing::waitTillBriefingDone();

	maps\stalingrad_voice::main();

//	maps\stalingrad_camera::main();
	level.gunammo = "gun";

	if (getcvar ("scr_stalingrad_fast") != "1")
		thread groupstart("right", 20000, 60000, "spotter ready");
		
	thread groupstart("left", 7000, 10000);

	thread init_ending_smoke();

	maps\_utility::array_thread(getentarray( "bobber", "targetname" ), ::bobber);

	object = getnode ("ammo","targetname");

	maps\_utility::array_thread(getentarray( "cover", "targetname" ), ::cover_think);

	maps\_utility::array_thread(getVehicleNodearray( "airplane", "targetname" ), ::airplane_think);

	maps\_utility::array_thread(getentarray( "mortar", "targetname" ), ::mortar_think);

	thread spotter_trigger(getent ("spotter_trigger","targetname"));


	thread animatic16(getent ("animatic16","targetname"));
	thread animatic21(getent ("animatic21","targetname"));
	thread animatic27(getent ("animatic27","targetname"));

	getent ("player_barge","targetname") thread barge_trip();
	getent ("explode_barge","targetname") thread explode_barge();

	tugboats = getentarray ("player_tugboat","targetname");
	for (i=0;i<tugboats.size;i++)
	{
		path = getVehicleNode (tugboats[i].target,"targetname");
		tugboats[i] attachPath( path );
		tugboats[i] startPath();
	}

	if (getcvar ("start") == "start")
		maps\_utility::array_thread(getentarray( "barge", "targetname" ), ::barge_lives);

	maps\_utility::array_thread(getentarray( "barge_dies", "targetname" ), ::barge_dies);
	maps\_utility::array_thread(getentarray( "tug_dies", "targetname" ), ::tug_dies);

	maps\_utility::array_levelthread(getentarray ("train","targetname"), ::train);

	thread trainsound (getentarray ("train","targetname"));
	wait (0.5);
	musicPlay("stalingrad_boatride");
}

randomvec(num)
{
	return (randomfloat(num) - num*0.5, randomfloat(num) - num*0.5,randomfloat(num) - num*0.5);
}

briefing()
{
	maps\_briefing::start(0.5);

	wait(1);

	// First screen
	self thread maps\_briefing::image("levelshots/brecourt.tga");
	wait(0.5);
	self playsound("german_random_chatter", "sounddone");
	self waittill("sounddone");
	self playsound("german_random_chatter", "sounddone");
	self waittill("sounddone");
	wait(0.5);

	// Second screen
	self thread maps\_briefing::image("levelshots/pathfinder.tga");
	wait(0.5);
	self playsound("german_random_chatter", "sounddone");
	self waittill("sounddone");
	self playsound("german_random_chatter", "sounddone");
	self waittill("sounddone");
	wait(0.5);

	// Third screen
	self thread maps\_briefing::image("levelshots/chateau.tga");
	wait(0.5);
	self playsound("german_random_chatter", "sounddone");
	self waittill("sounddone");
	self playsound("german_random_chatter", "sounddone");
	self waittill("sounddone");
	wait(0.5);

	// Fourth screen
	self thread maps\_briefing::image("levelshots/dam.tga");
	wait(0.5);
	self playsound("german_random_chatter", "sounddone");
	self waittill("sounddone");
	self playsound("german_random_chatter", "sounddone");
	self waittill("sounddone");
	wait(0.5);

	maps\_briefing::end();
}


trainsound ( trains )
{
	train = trains[0];
	org = trains[0].origin[0];

	for (i=0;i<trains.size;i++)
	{
		if (trains[i].origin[0] < org)
		{
			org = trains[i].origin[0];
			train = trains[i];
		}
	}

	train playSound (level.scr_sound ["Train Movement"]);
}

train( train )
{
	if (train.model == "xmodel/vehicle_russian_trainengine")
		train thread looping_tag_effect ( "train smoke", "TAG_smokestack" );

	train movex (800, 0.1);
	wait (0.1);
//	train movex (-3600, 40, 15, 20);
	train movex (-4400, 60, 15, 20);
	wait (85);
	train delete();
}

init_ending_smoke()
{
	smoke = getentarray ("end_smoke","targetname");
	for (i=0;i<smoke.size;i++)
	{
		smoke[i] notsolid();
		smoke[i] connectpaths();
		smoke[i] hide();
	}
}

kill_intro_smoke()
{
	org = self.origin;
	offset = 1;
	self.origin = org + (0,offset,0);
	self show();

	wait (4);

	while (offset < 15000)
	{
		offset *= 1.1;
		self.origin = org + (0,offset,0);
		wait (0.05);
	}

	self delete();
}


start_ending_smoke()
{
	org = self.origin;
	offset = 25000;
	self.origin = org + (0,offset,0);
	self show();

	while (offset > 2)
	{
//		offset *= 0.998;
		offset *= 0.99;
//		offset *= 0.99;
		self.origin = org + (0,offset,0);
		wait (0.05);
	}
}

missile_launch ()
{
	explode[0] = 106;
	explode[1] = 101;
	explode[2] = 105;
	explode[3] = 103;
	explode[4] = 100;
	explode[5] = 102;
	explode[6] = 104;
	explode[7] = 107;

	explode_old[0] = 15;
	explode_old[1] = 16;
	explode_old[2] = 17;
	explode_old[3] = 18;
	explode_old[4] = 19;
	explode_old[5] = 20;
	explode_old[6] = 21;
	explode_old[7] = 22;

	maps\_utility::exploder (explode[0]);
	maps\_utility::exploder (explode_old[0]);
	wait (0.1395);
	maps\_utility::exploder (explode[1]);
	maps\_utility::exploder (explode_old[1]);
	wait (0.1395);
	maps\_utility::exploder (explode[2]);
	maps\_utility::exploder (explode_old[2]);
	wait (0.1395);
	maps\_utility::exploder (explode[3]);
	maps\_utility::exploder (explode_old[3]);
	wait (0.3395);
	maps\_utility::exploder (explode[4]);
	maps\_utility::exploder (explode_old[4]);
	wait (0.4395);
	maps\_utility::exploder (explode[5]);
	maps\_utility::exploder (explode_old[5]);
	wait (0.5395);
	maps\_utility::exploder (explode[6]);
	maps\_utility::exploder (explode_old[6]);
	wait (0.6395);
	maps\_utility::exploder (explode[7]);
	maps\_utility::exploder (explode_old[7]);
	wait (0.7395);
	maps\_utility::exploder (explode[0]);
	maps\_utility::exploder (explode_old[0]);
	wait (0.5395);
	maps\_utility::exploder (explode[1]);
	maps\_utility::exploder (explode_old[1]);
	wait (0.8395);
	maps\_utility::exploder (explode[2]);
	maps\_utility::exploder (explode_old[2]);
	wait (0.6395);
	maps\_utility::exploder (explode[3]);
	maps\_utility::exploder (explode_old[3]);
	wait (0.8395);
	maps\_utility::exploder (explode[4]);
	maps\_utility::exploder (explode_old[4]);
	wait (0.5395);
	maps\_utility::exploder (explode[5]);
	maps\_utility::exploder (explode_old[5]);
	wait (0.6395);
	maps\_utility::exploder (explode[6]);
	maps\_utility::exploder (explode_old[6]);
	wait (0.3395);
	maps\_utility::exploder (explode[7]);
	maps\_utility::exploder (explode_old[7]);
	wait (0.9395);
}

rumble_thread()
{
//	getent ("stalingrad_artillery_rumble","targetname") playloopsound ("Stalingrad_artillery_rumble");
	org = getent ("stalingrad_artillery_rumble","targetname");
	blend = spawn( "sound_blend", ( 0.0, 0.0, 0.0 ) );

// lerp of 0 will play Stalingrad_artillery_rumble_null only
	for (i=0;i<1;i+=0.01)
	{
		blend setSoundBlend( "Stalingrad_artillery_rumble_null", "Stalingrad_artillery_rumble", i );
		wait (0.05);
	}
	level waittill ("rumble down");
	for (i=1;i>0.5;i-=0.01)
	{
		blend setSoundBlend( "Stalingrad_artillery_rumble_null", "Stalingrad_artillery_rumble", i );
		wait (0.05);
	}
	level waittill ("rumble out");
	for (i=0.5;i>0;i-=0.01)
	{
		blend setSoundBlend( "Stalingrad_artillery_rumble_null", "Stalingrad_artillery_rumble", i );
		wait (0.05);
	}
}

explosive_ending ()
{
	level.flag["boats should unload"] = false;

	explode[0] = 15;
	explode[1] = 16;
	explode[2] = 17;
	explode[3] = 18;
	explode[4] = 19;
	explode[5] = 20;
	explode[6] = 21;
	explode[7] = 22;

	getent ("stalingrad_artillery_launch","targetname") playsound ("Stalingrad_artillery_launch");

	//timer = 1.2;
	thread missile_launch();

	timer = 0;
	for (i=0;i<5;i++)
	{
		explode = maps\_utility::array_randomize(explode);
		for (p=0;p<explode.size;p++)
		{
//			maps\_utility::exploder (explode[p]);
			timer -= 0.2;
			if (timer < 0.4)
				//timer = 0.4;
				timer = 0.1395;
			//wait (randomfloat (timer));
			wait (timer);
		}
	}

	explode = undefined;
	for (i=0;i<67-40;i++)
		explode[i] = 40 + i;

	//level notify ("stop all MG42s");
	//level.flag["stop all MG42s"] = true;


	thread rumble_thread();

	exploders = getentarray ("script_model","classname");
	for (i=0;i<exploders.size;i++)
	{
		if (!isdefined (exploders[i].script_exploder))
			continue;

		level.exploder_model[exploders[i].script_exploder] = exploders[i];
	}


	//println("phase1");

	thread exploder_engage(explode[20]);
	wait 0.27;
	thread exploder_engage(explode[16]);
	wait 0.24;
	thread exploder_engage(explode[19]);
	wait 0.19;
	thread exploder_engage(explode[14]);
	wait 0.14;

	thread exploder_engage(explode[13]);
	wait 0.22;
	thread exploder_engage(explode[12]);
	wait 0.24;
	thread exploder_engage(explode[11]);
	wait 0.23;
	thread exploder_engage(explode[14]);
	wait 0.25;
	thread exploder_engage(explode[10]);
	wait 0.12;

//	level notify ("stop all MG42s");
//	level.flag["stop all MG42s"] = true;

	thread exploder_engage(explode[20]);
	wait 0.1;
	thread exploder_engage(explode[2]);
	wait 0.15;
	thread exploder_engage(explode[24]);
	wait 0.1;
	thread exploder_engage(explode[7]);
	wait 0.2;
	thread exploder_engage(explode[22]);
	wait 0.1;
	thread exploder_engage(explode[1]);
	wait 0.1;
	thread exploder_engage(explode[3]);
	wait 0.2;
	thread exploder_engage(explode[0]);
	wait 0.1;
	thread exploder_engage(explode[23]);
	wait 0.1;
	thread exploder_engage(explode[4]);
	wait 0.13;
	thread exploder_engage(explode[2]);
	wait 0.1;
	thread exploder_engage(explode[5]);
	wait 0.12;
	thread exploder_engage(explode[7]);
	wait 0.1;
	thread exploder_engage(explode[10]);
	wait 0.15;

	maps\_utility::array_thread(getentarray( "end_smoke","targetname" ), ::start_ending_smoke);
	maps\_utility::array_thread(getentarray( "smokeshield", "targetname" ), ::kill_intro_smoke);
	setExpFog(.0004022,  (float)120/(float)255,(float)127/(float)255,(float)131/(float)255, 18);  //rgb values RED

	//println("phase2");

	thread exploder_engage(explode[14]);
	wait 0.25;
	thread exploder_engage(explode[19]);
	wait 0.25;
	thread exploder_engage(explode[2]);
	wait 0.27;
	thread exploder_engage(explode[17]);
	wait 0.32;
	thread exploder_engage(explode[12]);
	wait 0.28;
	thread exploder_engage(explode[18]);
	wait 0.26;
	thread exploder_engage(explode[0]);
	wait 0.3;
	thread exploder_engage(explode[14]);
	wait 0.26;
	thread exploder_engage(explode[1]);
	wait 0.25;
	thread exploder_engage(explode[22]);
	wait 0.2;
	thread exploder_engage(explode[17]);
	wait 0.23;
	thread exploder_engage(explode[21]);
	wait 0.28;
	thread exploder_engage(explode[19]);
	wait 0.38;
	thread exploder_engage(explode[24]);
	wait 0.26;
	thread exploder_engage(explode[6]);
	wait 0.34;
	thread exploder_engage(explode[14]);
	wait 0.34;
	thread exploder_engage(explode[11]);
	wait 0.34;
	thread exploder_engage(explode[18]);
	wait 0.2;
	thread exploder_engage(explode[0]);
	wait 0.28;
	thread exploder_engage(explode[8]);
	wait 0.26;
	thread exploder_engage(explode[18]);
	wait 0.26;
	thread exploder_engage(explode[14]);
	wait 0.36;
	thread exploder_engage(explode[22]);
	wait 0.3;
	thread exploder_engage(explode[17]);
	wait 0.33;
	thread exploder_engage(explode[0]);
	wait 0.1;
	thread exploder_engage(explode[21]);
	wait 0.28;
	thread exploder_engage(explode[19]);
	wait 0.18;
	thread exploder_engage(explode[24]);
	wait 0.4;
	thread exploder_engage(explode[14]);
	wait 0.15;
	thread exploder_engage(explode[19]);
	wait 0.1;
	thread exploder_engage(explode[2]);
	wait 0.26;
	thread exploder_engage(explode[17]);
	wait 0.32;
	thread exploder_engage(explode[1]);
	wait 0.1;
	thread exploder_engage(explode[12]);
	wait 0.25;
	thread exploder_engage(explode[18]);
	wait 0.37;
	thread exploder_engage(explode[14]);
	wait 0.24;
	thread exploder_engage(explode[22]);
	wait 1.2;


	//pause

	//println("phase3");
	/*
	thread exploder_engage(explode[10]);
	wait 0.15;
	thread exploder_engage(explode[7]);
	wait 0.1;
	thread exploder_engage(explode[22]);
	wait 0.1;
	thread exploder_engage(explode[5]);
	wait 0.12;
	thread exploder_engage(explode[21]);
	wait 0.2;
	thread exploder_engage(explode[4]);
	wait 0.13;
	thread exploder_engage(explode[3]);
	wait 0.2;
	thread exploder_engage(explode[17]);
	wait 0.23;
	thread exploder_engage(explode[13]);
	wait 0.12;
	thread exploder_engage(explode[1]);
	wait 0.1;
	thread exploder_engage(explode[20]);
	wait 0.2;
	thread exploder_engage(explode[2]);
	wait 0.1;
	thread exploder_engage(explode[18]);
	wait 0.16;
	thread exploder_engage(explode[14]);
	wait 0.16;
	thread exploder_engage(explode[22]);
	wait 0.5;
	*/
	thread exploder_engage(explode[7]);
	wait 0.23;
	thread exploder_engage(explode[22]);
	wait 0.26;
	thread exploder_engage(explode[12]);
	wait 0.25;
	thread exploder_engage(explode[24]);
	wait 0.27;
	thread exploder_engage(explode[16]);
	wait 0.28;
	thread exploder_engage(explode[0]);
	wait 0.13;
	thread exploder_engage(explode[19]);
	wait 0.15;
	thread exploder_engage(explode[11]);
	wait 0.29;
	thread exploder_engage(explode[23]);
	wait 0.25;
	thread exploder_engage(explode[1]);
	wait 0.17;
	thread exploder_engage(explode[14]);
	wait 0.21;
	thread exploder_engage(explode[10]);
	wait 0.28;
	thread exploder_engage(explode[2]);
	wait 1;
	level.flag["boats should unload"] = true;
	level notify ("boats should unload");


	//pause

	//println("phase4");

	thread exploder_engage(explode[1]);
	wait 0.25;
	thread exploder_engage(explode[0]);
	wait 0.23;
	thread exploder_engage(explode[6]);
	wait 0.2;
	thread exploder_engage(explode[26]);
	wait 0.2;
	thread exploder_engage(explode[25]);
	wait 0.1;
	thread exploder_engage(explode[3]);
	wait 0.1;
	thread exploder_engage(explode[24]);

	level.mg42guy["endguy"] notify ("killed");
	flag_set("end" + "killed");
	maps\_utility::exploder (30);

	wait 0.23;
	flag_set("stop all MG42s");
	
	thread exploder_engage(explode[23]);
	wait 0.2;
	thread exploder_engage(explode[22]);
	wait 0.21;
	thread exploder_engage(explode[1]);
	wait 0.1;
	thread exploder_engage(explode[21]);
	wait 0.2;
	thread exploder_engage(explode[19]);
	wait 0.24;
	thread exploder_engage(explode[20]);
	wait 0.23;

	//println("phase5");

	thread exploder_engage(explode[8]);
	wait 0.26;
	thread exploder_engage(explode[18]);
	wait 0.24;
	thread exploder_engage(explode[23]);
	wait 0.24;
	thread exploder_engage(explode[17]);
	wait 0.23;
	thread exploder_engage(explode[1]);
	wait 0.1;
	thread exploder_engage(explode[16]);
	wait 0.22;
	thread exploder_engage(explode[15]);
	wait 0.26;
	thread exploder_engage(explode[14]);
	wait 0.4;

	//pause

	thread exploder_engage(explode[12]);
	wait 0.28;
	thread exploder_engage(explode[13]);
	wait 0.3;
	thread exploder_engage(explode[10]);
	wait 0.24;
	thread exploder_engage(explode[0]);
	wait 0.1;
	thread exploder_engage(explode[21]);
	wait 0.23;
	thread exploder_engage(explode[14]);
	wait 0.26;
	thread exploder_engage(explode[22]);
	wait 0.23;
	thread exploder_engage(explode[1]);
	wait 0.1;
	thread exploder_engage(explode[16]);
	wait 0.16;
	thread exploder_engage(explode[15]);
	wait 0.21;
	thread exploder_engage(explode[17]);
	wait 0.23;

	//println("phase6");

	thread exploder_engage(explode[7]);
	wait 0.12;
	thread exploder_engage(explode[5]);
	wait 0.15;
	thread exploder_engage(explode[19]);
	wait 0.1;
	thread exploder_engage(explode[2]);
	wait 0.13;
	thread exploder_engage(explode[23]);
	wait 0.1;
	thread exploder_engage(explode[4]);
	wait 0.15;
	thread exploder_engage(explode[1]);
	wait 0.1;
	thread exploder_engage(explode[17]);
	wait 0.1;
	thread exploder_engage(explode[9]);
	wait 0.22;
	thread exploder_engage(explode[19]);
	wait 0.26;

	//println("phase7");

	thread exploder_engage(explode[18]);
	wait 0.2;
	thread exploder_engage(explode[19]);
	wait 0.23;
	thread exploder_engage(explode[20]);
	wait 0.24;
	thread exploder_engage(explode[21]);
	wait 0.33;
	thread exploder_engage(explode[1]);
	wait 0.1;
	thread exploder_engage(explode[22]);
	wait 0.55;
	thread exploder_engage(explode[24]);
	wait 0.35;
	thread exploder_engage(explode[23]);
	wait 1;

	//println("phase8");

	level notify ("rumble down");
	
	musicPlay("stalingrad_victory");
	
	thread exploder_engage(explode[8]);
	wait 1.1;
	thread exploder_engage(explode[10]);
	wait 0.7;
	thread exploder_engage(explode[11]);
	wait 1.16;
	thread exploder_engage(explode[12]);
	wait 0.4;
	thread exploder_engage(explode[13]);
	wait 1.4;
	thread exploder_engage(explode[1]);
	wait 0.1;
	thread exploder_engage(explode[14]);
	wait 1.5;
	thread exploder_engage(explode[16]);
	wait 1.1;
	thread exploder_engage(explode[15]);
	wait 2.1;
	thread exploder_engage(explode[17]);
	earthquake(0.25, 6, level.player.origin, 1450);
	wait 3;
	level notify ("rumble out");
//	getent ("stalingrad_artillery_rumble","targetname") delete();

}

exploder_engage (num)
{
	soundnum = randomint(3) + 1;
	//println ("num is ", num);
	if (soundnum == 1)
	{
		level.exploder_model[num] playsound ("mortar_incoming1");
		wait 0.7;
	}
	else
	if (soundnum == 2)
	{
		level.exploder_model[num] playsound ("mortar_incoming2");
		wait 0.7;
	}
	else
	{
		level.exploder_model[num] playsound ("mortar_incoming3");
		wait 0.7;
	}

	exploder_plus_sound (num);
}

exploder_plus_sound (num)
{
	maps\_utility::exploder (num);
	level.exploder_model[num] playsound ("Stalingrad_artillery_impact");
//	println ("Playing sound Stalingrad_Artillery_impact on entity ", level.exploder_model[num].classname, " at origin ", level.exploder_model[num].origin);
	//level.exploder_model[num] thread maps\_mortar::mortar_sound();
	earthquake(0.35, 3, level.player.origin, 1450);
}

looping_anim_ender (guy, ender)
{
	guy endon ("death");
	self waittill (ender);
	guy.loops--;
}

printloops (guy, anime)
{
	wait (0.05);
	guy.loops++;
	if (guy.loops > 1)
		maps\_utility::error ("guy with name "+ guy.animname+ " has "+ guy.loops+ " looping animations played, anime: "+ anime);
}

anim_reach (guy, anime, node)
{
//	println (guy[0].animname, " doing animation ", anime);
	if (isdefined (node))
	{
		org = node.origin;
		angles = node.angles;
	}
	else
	{
		org = self.origin;
		angles = self.angles;
	}

	ent = spawnstruct();

	threads = 0;
	for (i=0;i<guy.size;i++)
	{
//		println ("guy is ", guy[0].animname, " anime is ", anime, " tag is ", tag);
		startorg = getstartOrigin (org, angles, level.scr_anim[guy[i].animname][anime]);
		guy[i] setgoalpos (startorg);
		threads++;
		guy[i] thread reach_goal_notify (ent);
	}

	while (threads)
	{
		ent waittill ("reach notify");
		threads--;
	}
}

reach_death_notify (guy, ent)
{
	guy endon ("goal");
	guy waittill ("death");
	ent notify ("reach notify");
}

reach_goal_notify (ent)
{
	level thread reach_death_notify (self, ent);
	self.oldgoalradius = self.goalradius;
	self.goalradius = 0;
	self waittill ("goal");
	self.goalradius = self.oldgoalradius;
	ent notify ("reach notify");
}

end_recruits(msg, timer)
{
	wait (10);

	spawners = [];
	ai = getspawnerarray();
	for (i=0;i<ai.size;i++)
	if ((isdefined (ai[i].script_noteworthy)) && (ai[i].script_noteworthy == msg))
		spawners[spawners.size] = ai[i];
	ai = undefined;

	node = getnode ("end","targetname");
	while (1)
	{
		for (i=0;i<spawners.size;i++)
		{
			if (!isdefined (spawners[i].script_noteworthy))
				continue;
			if (spawners[i].script_noteworthy != msg)
				continue;

			spawners[i].count = 1;
			spawn = spawners[i] stalingradspawn("recruit_spawn");
			if (!isdefined (spawn))
				continue;

			spawn pre_seek_destination();
			spawn thread reach_delete();
			wait (timer);
		}

		wait (0.05);
	}
}

reach_delete()
{
	node = self;
	while (isdefined (node.target))
	{
		node = getnode (node.target,"targetname");
		self setgoalnode (node);
		self waittill ("goal");
	}

//	self.goalradius = 0;
	self delete();
}

attach_model()
{
	if (isdefined (level.scr_model[self.animname]))
	{
		for (i=0;i<level.scr_model[self.animname].size;i++)
		{
			model = spawn ("script_model",(9,9,3));
			model setmodel (level.scr_model[self.animname][i]);
			model linkto (self, level.scr_tag[self.animname][i], (0,0,0),(0,0,0));
//			self attach (level.scr_model[self.animname][i], level.scr_tag[self.animname][i]);
			println ("^d", self.animname, " attaching ", level.scr_model[self.animname][i], " to tag ", level.scr_tag[self.animname][i]);
		}
	}
}

fleeing_guy (spawner)
{
	while (1)
	{
		spawn = spawner stalingradspawn();
		if (isdefined (spawn))
			break;
		wait (1);
	}
	node = getnode (spawn.target,"targetname");
	level.flag["fleeing guy spawned"] = true;
	level notify ("fleeing guy spawned");
	level.fleeing_guy = spawn;
	spawn.health = 5;
	spawn endon ("death");
	spawn hide();
	spawn allowedstances ("prone");
	wait (0.10);
	spawn show();
	spawn allowedstances ("crouch");
	spawn.goalradius = 4;
	spawn setgoalnode (node);

	level waittill ("fleeing guy runs");
	println ("^6 spawn has fixbasepose: " , spawn.script_fixbasepose);
	while (isdefined (node.target))
	{
		node = getnode (node.target,"targetname");
		spawn setgoalnode (node);
		spawn waittill ("goal");
	}

	spawn coolKill();
}

#using_animtree("spotter");
spotter_trigger( trigger )
{
	trigger waittill ("trigger");
	getent ("endlevel","targetname") thread endlevel();

	thread final_commissar();
	thread fleeing_guy (getent ("fleeing_guy","targetname"));
//	maps\_utility::error ("TRIGGERED");
//	thread end_recruits("final_assault_guys",1.5);
	trigger delete();


	spotter = spawn ("script_model",(9,9,9));
	level thread add_totalguys(spotter);
	level.spotter = spotter;
	node = getnode ("spotter","targetname");
	spotter.origin = node.origin;
	spotter.angles = node.angles;
	spotter.animname = "spotter";
	spotter UseAnimTree(level.scr_animtree[spotter.animname]);
	spotter [[level.scr_character[spotter.animname]]]();

	spotter attach_model();

	guy[0] = spotter;
	spotter thread anim_loop(guy, "idle", undefined, "stop anim", node);
//	level waittill ("suicide4");
//	wait (8);
//	spotter notify ("stop anim");
//	anim_single(guy, "fullbody66", undefined, node);

	getent ("ending_finale_trigger","targetname") waittill ("trigger");
	level.flag["spotter ready"] = true;
	level notify ("spotter ready");

	if (!level.flag["artillery fire"])
		level waittill ("artillery fire");


	spotter notify ("stop anim");
	anim_single(guy, "fullbody68", undefined, node);
	thread ending_rush_boat (getent ("ending_rush_boat","targetname"));
	anim_single(guy, "fullbody69", undefined, node);
	anim_single(guy, "fullbody70", undefined, node);

	level.player.threatbias = 5000;


	anim_single(guy, "fullbody71", undefined, node);

	level.flag["explosive finale"] = true;

	spotter thread anim_loop(guy, "cower", undefined, "stop anim", node);
	level notify ("stop mortars");
	level notify ("start end barrage");

//	level.mg42guy["endguy"] notify ("killed");
//	level notify ("end" + "killed");
	explosive_ending();

	level notify ("endgame");
//	thread end_recruits("ending_guys",0.75);

	level.flag ["endgame"] = true;

	/*
	ai = getaiarray ("axis");
	for (i=0;i<ai.size;i++)
		ai[i] coolKill();
	*/

	wait (5);
	spotter notify ("stop anim");
	anim_single(guy, "transition", undefined, node);
	objective_state(2, "done");
	objective_add(3, "active", &"STALINGRAD_OBJ3", (-3804, 1745, 648));
	objective_current(3);
	
	thread anim_loop(guy, "idle", undefined, undefined, node);
}

#using_animtree("barge");
ending_rush_boat (boat)
{
	path = getVehicleNode (boat.target,"targetname");
	boat attachPath( path );

	boat UseAnimTree(#animtree);
	boat setAnimKnob( %barge_boatanim_sway);
	boat startPath();
	boat waittill ("reached_end_node");
	println ("reached end of boat thing");

	spawners = getentarray ("end_rush","targetname");
	next_flag = 1;
	while (1)
	{
		spawners = maps\_utility::array_randomize(spawners);
		for (i=0;i<spawners.size;i++)
		{
			spawners[i].count = 1;
			spawn = spawners[i] stalingradspawn();


			if (isdefined (spawn))
			{
				spawn pre_seek_destination();
				next_flag--;
				if (!next_flag)
				{
					next_flag = 10 + randomint (10);
					spawn.animname = "flagrun";
					spawn.hasWeapon = false;
					spawn.team = "allies";
					spawn.walk_noncombatanim = level.scr_anim[spawn.animname]["idle"][0];
					spawn.walk_noncombatanim2 = level.scr_anim[spawn.animname]["idle"][0];
					spawn.run_noncombatanim = level.scr_anim[spawn.animname]["idle"][0];
					spawn attach ("xmodel/stalingrad_flag", "tag_weapon_Right");
					spawn allowedstances ("stand");
				}

				spawn thread ending_rush_think();
			}

			wait (0.5 + randomfloat(1));
		}

		wait (randomfloat(1));
	}
}

ending_rush_think()
{

	node = self;
	while (isdefined (node.target))
	{
		node = getnode (node.target,"targetname");
		self setgoalnode (node);
		self waittill ("goal");
	}

	self delete();
}

endlevel()
{
	self waittill ("trigger");
//	changelevel("stalingrad", 0, false, false);
	missionSuccess ("redsquare", false);
}

explode_barge()
{
	if (getcvar ("start") == "docks")
	{
		self delete();
		return;
	}

	path = getVehicleNode (self.target,"targetname");
	self attachPath( path );

	self UseAnimTree(#animtree);
	self setAnimKnob( %barge_boatanim_sway);

//	self setAnimKnob( %russian_barge_d_sink);
	level waittill ("init explode boat");

	if (getcvar ("scr_stalingrad_fast") != "1")
	{
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupA02", "groupA_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupD05", "groupD_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupD03", "groupD_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupD01", "groupD_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupC01", "groupC_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupC03", "groupC_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupC05", "groupC_guy01");
	}

	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupA", "groupA_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupA01", "groupA_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupC", "groupC_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupC02", "groupC_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupC04", "groupC_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupD", "groupD_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupD02", "groupD_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupD04", "groupD_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupE", "groupE_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupE01", "groupE_guy01");

	thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerA", "officerA");
//	thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerA01", "officerA");
	thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerA02", "officerA");
//	thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerB", "officerB");
	thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerB01", "officerB");
//	thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerC", "officerC");

	level waittill ("start explode boat");
	self startPath();
	level waittill ("destroy explode boat");
	self notify ("explode guys");
	sink();
}

smokeshield_think()
{
//	self.solid = false;
//	self.notsolid = true;
	level endon ("stop shields");
	player = getent("player", "classname" );
	level.player = player;
	self notsolid();
	self connectpaths();

	shield = getentarray( "smokeshield", "targetname" );

	wait (0.1);
	if (self != shield[0])
		return;


/*
	if (!isdefined (self.script_noteworthy))
	{
		self delete();
		return;
	}
*/
	origin = self.origin;
	self.origin = origin;

	start = -15671;
	end = -2160;
	dist = 5000;

	start = -7671;
	end = -1800;
	dist = 1400;

	level.player endon ("death");

	while (1)
	{
		org = level.player.origin[1];

		if (org < start)
			org = start;
		if (org > end)
			org = end;

		org -= end;
		org *= dist;
		org /= (start - end);
		org = dist - org;

		self.origin = origin - (0,org,0);
		wait (0.05);
	}

//	-2160	0
//	-15671	5000

}

dock_commissar_think ()
{
	spawn = spawn ("script_model",(0,0,0));
	level thread add_totalguys(spawn);
	spawn.origin = self.origin;
	spawn.angles = self.angles;
	spawn.animname = self.script_noteworthy;

	spawn UseAnimTree(level.scr_animtree[spawn.animname]);

	if (isdefined (level.scr_character[spawn.animname]))
		spawn [[level.scr_character[spawn.animname]]]();
	else
		spawn setmodel ("xmodel/character_soviet_overcoat");

	guy[0] = spawn;
	thread anim_loop(guy, "idle");
	level waittill ("breaking through explosion");
	guy[0] delete();
}

flag_guy()
{
	spawn = spawn ("script_model",(0,0,0));
	level thread add_totalguys(spawn);
	spawn.origin = self.origin;
	spawn.angles = self.angles;
	spawn.animname = "flagwave";

	spawn UseAnimTree(level.scr_animtree[spawn.animname]);
	if (isdefined (level.scr_character[spawn.animname]))
		spawn [[level.scr_character[spawn.animname]]]();
	else
		spawn setmodel ("xmodel/character_soviet_overcoat");

	guy[0] = spawn;
	spawn thread anim_loop(guy, "idle", undefined, undefined, getnode ("flag_guy","targetname"));
	level waittill ("stuka1");
	spawn delete();
}

radio_guy()
{
	guy = spawn ("script_model",(0,0,0));
//	level thread add_totalguys(guy);
	guy.origin = self.origin;
	guy.angles = self.angles;
	guy.animname = "deadguy_radio";

	guy UseAnimTree(level.scr_animtree[guy.animname]);
	if (isdefined (level.scr_character[guy.animname]))
		guy [[level.scr_character[guy.animname]]]();
	else
		guy setmodel ("xmodel/character_soviet_overcoat");

	guy animscripted("scriptedanimdone", self.origin, self.angles, level.scr_anim[guy.animname]["death"]);
}

ai_pick_direction( trigger )
{
	num = 0;
	leftnodes = getnodearray ("destination_left", "targetname");
	rightnodes = getnodearray ("destination_right", "targetname");

	nodes = getnodearray ("animatic33_guys","targetname");
	for (i=0;i<nodes.size;i++)
		nodes[i].filled = false;

	while (1)
	{
		trigger waittill ("trigger", other);
		if ((!isdefined (other.direction)) && (isSentient (other)) && (isalive (other)))
		{
			other.direction = true;
//			other maps\_utility::can_shoot();

			breaker = false;
			for (i=0;i<nodes.size;i++)
			if (!nodes[i].filled)
			{
				node = nodes[i];
				breaker = true;
				i = nodes.size + 1;
			}

			if (breaker)
			{
				level thread death_node (other, node);
				other setgoalnode (node);
				other.goalradius = 4;
				node.filled = true;
			}
			else
			{
				if (!num)
				{
					num = 1;
					other setgoalnode (leftnodes[randomint (leftnodes.size)]);
					other thread soon_die();
					println ("^aset goal node to left");
				}
				else
				{
					num = 0;
					other setgoalnode (rightnodes[randomint (rightnodes.size)]);
					other thread soon_die();
					println ("^aset goal node to right");
				}
			}
		}
	}
}

death_node (guy, node)
{
	guy endon ("quick duck");
	guy waittill ("death");
	node.filled = false;
}

quick_duck_node (node)
{
	self waittill ("quick duck");
	node.filled = false;
}

soon_die()
{
	wait (randomfloat (8));
	self coolKill();
}

deadradioguy()
{
	guy = spawn ("script_model",(0,0,0));
	level thread add_totalguys(guy);
	guy.origin = self.origin;
	guy.angles = self.angles;
	guy.animname = "deadguy_radio";

	guy UseAnimTree(level.scr_animtree[guy.animname]);
	if (isdefined (level.scr_character[guy.animname]))
		guy [[level.scr_character[guy.animname]]]();
	else
		guy setmodel ("xmodel/character_soviet_overcoat");

	guy animscripted("scriptedanimdone", self.origin, self.angles, level.scr_anim[guy.animname]["death"]);
}

#using_animtree("stalingrad_radio_officerp");	// Boon, added 8/18/03 when I added %stalingrad_captain_facial_57_whereisartillery below.
scriptguy_think(node) //officerP
{
	spawn = spawn ("script_model",(0,0,0));
	level thread add_totalguys(spawn);
	spawn.origin = node.origin;
	spawn.angles = node.angles;
	spawn.animname = node.script_noteworthy;
	node radio_guy();

	spawn UseAnimTree(level.scr_animtree[spawn.animname]);
	if (isdefined (level.scr_character[spawn.animname]))
		spawn [[level.scr_character[spawn.animname]]]();
	else
		spawn setmodel ("xmodel/character_soviet_overcoat");

	if (node.script_noteworthy == "officerP")
		node thread deadradioguy();

	guy[0] = spawn;
	level thread anim_loop(guy, "idle", undefined, "stop anim", node);

	println ("^2 waiting for player to get shell shocked");
	level waittill ("player got shell shocked");
	println ("^2 waiting for shellshock safetime ", (level.shellshock_safetime - gettime()) * 0.001);
	shellshocktime = (level.shellshock_safetime - gettime()) * 0.001;
	if (shellshocktime > 0)
		wait (shellshocktime);
	
//	wait (25);
/*
//	trigger = getent("plane_attack", "targetname");
//	trigger waittill ("trigger");

	timer = (level.radio_captain_time - gettime()) * 0.001;
//	timer -= 14;
	println ("^atimer is ", timer);
	if (timer > 0)
		wait (timer);

*/
	println ("^2 starting captain dialogue");
	level notify ("stop anim");
//	wait 1;

	println ("^2 playing captain animation");
	guy[0] animscripts\face::SaySpecificDialogue(%stalingrad_captain_facial_57_whereisartillery, "captain_line57", 1.0, "sounddone new");	// Boon, added 8/18/03
//	guy[0] playsound ("captain_line57","sounddone");
	guy[0] waittill ("sounddone new");
	level notify ("stop plane attacks now");
	println ("^2 stopping the planes");
	wait 0.5; // 1
//	level notify ("stop anim");
	level notify ("start leftguys");
	guy[0] anim_single (guy, "fullbody58", undefined, node);
	level thread anim_loop(guy, "idle", undefined, "start planes 5", node);
	
	flag_wait ("final plane attack");
	/*
	trigger = getent("plane_attack_two", "targetname");
	if (!level.player istouching (trigger))
	{
		trigger waittill ("trigger");
	}
	*/
	level notify ("start planes 5");
	wait (4); // 6
//	wait (3.6);
	// open fire
	level thread scriptguyContinues (guy, node);
	wait (4.2);
	level notify ("global target");
	wait (0.8);
	level notify ("sniper time");
	level.flag["sniper time"] = true;
	wait (4.5); // 4.5
	level notify ("flag pickup guy");
}

scriptguyContinues ( guy, node )
{
	guy[0] anim_single (guy, "fullbody59", undefined, node);
	thread anim_loop(guy, "idle", undefined, undefined, node);
}

#using_animtree("barge");	// Boon, added 8/18/03 when I added using_animtree("stalingrad_radio_officerp") above.

dropper_fx_setup(owner)
{
	self hide();
}

dropper_fx_think(owner)
{
	targ = getent (self.target,"targetname");
	org = vectornormalize (targ.origin - self.origin);

	while (1)
	{
		playfx ( level._effect["dust"], self.origin, org );
		wait (randomfloat (1));
	}
}

dropper()
{
	maps\_utility::array_thread(getentarray( self.target,"targetname" ), ::dropper_fx_setup);
	level waittill ("dropper");
	maps\_utility::array_thread(getentarray( self.target,"targetname" ), ::dropper_fx_think);

	self moveZ(-1000, 7, 2, 0);
	wait (8);

	fx = getentarray( self.target,"targetname" );
	for (i=0;i<fx.size;i++)
	{
		targ = getent (fx[i].target, "targetname");
		targ delete();
		fx[i] delete();
	}

	self delete();
}

stretcher_think()
{
//	org = self gettagOrigin (tag);
//	ang = self gettagAngles (tag);
	org = self.origin;
	angles = self.angles;

	spawn = spawn ("script_model",(0,0,0));
	level thread add_totalguys(spawn);
	spawn.origin = (org);
	spawn.angles = (angles);
	spawn.animname = self.script_noteworthy;

//	if (isdefined (level.scr_character[spawn.animname]))
		spawn [[level.scr_character[spawn.animname]]]();
/*		
	else
	{
		spawn setmodel ("xmodel/character_soviet_overcoat");
		rand = randomint(100);
		if (rand<50)
			spawn attach("xmodel/head_mike");
		else
			spawn attach("xmodel/head_blane");
	}
	*/

	spawn UseAnimTree(level.scr_animtree[spawn.animname]);

	if (isdefined (level.scr_anim[spawn.animname]["death"]))
	{
		spawn animscripted("scriptedanimdone", org, angles, level.scr_anim[spawn.animname]["death"]);
		return;
	}

	guy[0] = spawn;
	thread anim_loop(guy, "idle", undefined, undefined, self);
	while (1)
	{
		spawn playsound ("stalingrad_wounded_guys");
		wait (4 + randomfloat(10));
	}
}

setsight()
{
	spawners = getspawnerarray();
	for (i=0;i<spawners.size;i++)
		spawners[i] thread killsight();

	ai = getaiarray();
	for (i=0;i<ai.size;i++)
	{
//		ai[i] maps\_utility::cant_shoot();
//		ai[i].dontDropWeapon = true;
		ai[i].DropWeapon = false;
		ai[i] thread bloody_death_waittill();
		level thread add_totalguys(ai[i]);
//		ai[i].dontavoidplayer = true;
	}
}

killsight()
{
	while (1)
	{
		self waittill ("spawned", spawned);
		if (issentient (spawned))
		{
			level thread add_totalguys(spawned);
			spawned thread bloody_death_waittill();
//			spawned maps\_utility::cant_shoot();
//			spawned.dontDropWeapon = true;
			spawned.DropWeapon = false;
//			spawned.dontavoidplayer = true;
		}
	}
}

mg42_manual_doshoot_think()
{
	self endon("turretstatechange"); // code
	while (1)
	{
		self ShootTurret();
		wait 0.1;
	}
}

mg42_manual_doshoot()
{
	while (1)
	{
		if (self isFiringTurret())
			self thread mg42_manual_doshoot_think();

		self waittill ("turretstatechange");
	}
}

mg42_manual_doshoot_burst()
{
	while (1)
	{
		self startfiring();
		self waittill ("mg42 stop");
		self stopfiring();
		self waittill ("mg42 start");
	}
}

mg42_auto_doshoot_burst()
{
	self endon ("died");
	self endon ("stop auto");
	while (1)
	{
		self startfiring();
		wait (0.4 + randomfloat (0.2));
		self stopfiring();
		wait (1 + randomfloat (1.6));
	}
}

mg42_random_target()
{
	getent ("sniper_start","targetname") waittill ("trigger");
	wait (4);
	toucher = getent ("ai_safety","targetname");
	while (1)
	{
		ai = getentarray ("recruit_spawn","targetname");
		ai = maps\_utility::array_randomize(ai);
		for (i=0;i<ai.size;i++)
		{
			if (!(ai[i] istouching (toucher)))
			{
				level.mg42_random_target = ai[i];
				ai[i].allowDeath = 1;
				ai = undefined;
				level.mg42_random_target waittill ("death");
				level.mg42_random_target = undefined;
				break;
			}
		}

		wait (2);
	}
}

mg42_target(org)
{
	self.suicide_targets = getentarray (self.script_noteworthy,"targetname");
	firing_target = spawn ("script_origin",(0,0,0));

	while (1)
	{
		if (isdefined (level.mg42_target))
		{
			if (level.mg42_target.classname == "trigger_multiple")
				targets = getentarray (level.mg42_target.target, "targetname");
			else
				targets[0] = level.mg42_target;

			target = targets[randomint (targets.size)];
			if (isdefined (target))
				self settargetentity(target);
		}
		else
		{
			if (level.flag["mg42_trigger"])
				firing_target.origin = self.suicide_targets[randomint(self.suicide_targets.size)].origin;
			else
				firing_target.origin = org.origin;

			firing_target.origin += (randomint (80) - 40, randomint (80) - 40, randomint (80) - 40);
			self settargetentity(firing_target);
//				line (self.origin + (0,0,35), self.suicide_targets[randomint(self.suicide_targets.size)].origin, (0.2, 0.5, 0.8), 0.5);
		}

		wait (0.1);
		wait (randomfloat (0.25));
	}
}

newtargetentity ( target )
{
	self notify ("new target");
	self thread shoot_target (target);
}

stance_num ()
{
	if (level.player getstance() == "prone")
		return (0,0,5);
	else
	if (level.player getstance() == "crouch")
		return (0,0,25);

	return (0,0,50);
}

shoot_target (target)
{
	level endon ("stop all MG42s");
	self endon ("new target");
	target endon ("death");
	start = self.org.origin;
	self.org unlink();

	wait_time = 0.1; // 0.08; // 2.8 / 20;
	if (target == level.player)
		dif = 0.05; // 0.25 // 0.2; // 1 / 20;
	else
		dif = 0.05; // 1 / 20;

	self notify ("mg42 start");

	for (i=0;i<1;i+=dif)
	{
		if (target == level.player)
			self.org.origin = maps\_mg42::vectorMultiply (target.origin + stance_num(), i) +
				maps\_mg42::vectorMultiply (start, 1-i);
		else
		if (isSentient (target))
			self.org.origin = maps\_mg42::vectorMultiply (target.origin + (0,0,40), i) +
				maps\_mg42::vectorMultiply (start, 1-i);
		else
			self.org.origin = maps\_mg42::vectorMultiply (target.origin, i) +
				maps\_mg42::vectorMultiply (start, 1-i);

		wait (wait_time);
	}

	if (target == level.player)
		self.org.origin = target.origin + stance_num();
	else
	if (isSentient (target))
		self.org.origin = target.origin + (0,0,randomfloat(50));
	else
		self.org.origin = target.origin;

	self.org linkto (target);
}


endgame_delete()
{
	level waittill ("stop all MG42s");
	self delete();
}

// -2100, -1250
mg42_leftguys(line, stopline, zone, restart_time)
{
	level endon ("stop all MG42s");
	wait (randomfloat (4));
	node = getnode (self.target,"targetname");
	turret = getent (node.target, "targetname");
	level.mg42guy[self.script_noteworthy] = turret;
	turret setmode("manual");
	turret thread mg42_manual_doshoot();
	turret thread endgame_delete();
	mg42owner = getent (self.target,"targetname");
	mg42owner thread script_gunner_init(node);
	org = mg42owner.origin;
	ang = mg42owner.angles;
	turret.turretOrg = spawn ("script_model",(0,0,0));
	//turret.turretOrg setmodel ("xmodel/temp");
	
	while (1)
	{
//		turret thread mg42_auto_doshoot_burst();
		self thread firepattern(turret, restart_time);
		self thread left_think (turret, line, stopline, zone);
		mg42owner thread script_gunner_think(turret, org,ang);

		targets = getentarray (zone,"targetname");
		targets = targets[randomint(targets.size)];
		turret settargetentity (targets);
	//	turret startfiring();

		turret waittill ("killed");
		level notify (self.script_noteworthy + "killed");
		println ("KILLED A TURRET with noteworthy ", self.script_noteworthy);
		turret stopfiring();
		turret notify ("died");
		mg42owner notify ("die gunner");
		wait (10);
	}
}


firepattern(turret, restart_time)
{
	level endon ("stop all MG42s");
	turret endon ("killed");
	self.is_firing = false;
	while (1)
	{
		if (!level.flag["sniper is talking"])
		{
			turret startfiring();
			self.is_firing = true;
			wait (0.4 + randomfloat (0.2));
		}
		self.is_firing = false;

		turret stopfiring();
		if (level.flag["sniper is talking"])
		{
			level waittill ("sniper stops talking");
			if (isdefined (restart_time))
				wait (restart_time + randomfloat (0.1));
			else
				wait (0.25 + randomfloat (0.8));

			turret startfiring();
			level waittill ("left mg42s stop firing");
			turret stopfiring();
			wait (2 + randomfloat (2));
		}
		else
			wait (1 + randomfloat (1.6));
	}
}

//		if (isdefined (self.fire_override))
//			self.fire_override waittill ("death");

ai_num()
{
	while (1)
	{
		ai = getaiarray();
		for (i=0;i<ai.size;i++)
			print3d ((ai[i].origin + (0, 0, 165)), i, (0.78,9.4,0.26), 0.85);

		wait (0.05);
	}
}

current_target(timer, msg)
{
	if (isdefined (timer))
		timer = gettime() + timer;
	else
		timer = gettime() + 1000;

	if (!isdefined (msg))
		msg = "YO";
	while (gettime() < timer)
	{
		print3d ((self.origin + (0, 0, 65)), msg, (0.48,9.4,0.76), 0.85);

		wait (0.05);
	}
}

left_startShootingPlayer ( turret )
{
	level endon ("player is safe from left mg42s");
	turret notify ("stop current left mg42");
	turret endon ("stop current left mg42");
	
	range = 1500;
	left = randomint (range);
	left = 800;
	if (randomint (100) > 50)
		left*=-1;
	
	up = 2000;
//	if (randomint (100) > 50)
//		up*=-1;

	tOrg = turret.turretOrg;
	turret settargetentity (tOrg);
	
	maxtime = level.playerSafeFromMG42Time;
	timer = gettime() + maxtime;
	while (1)		
	{
		currentTime = timer - gettime();
		dif = (float) currentTime / (float) maxtime;
		if (dif < 0)
		{
			println ("^5 TARGET THE PLAYER");
			turret settargetentity (level.player);
			return;
		}
		tOrg.origin = level.player.origin + (left * dif, up * dif, 0);
		wait (0.1);
	}
}

left_think (turret, line, stopline, zone)
{
	level endon ("stop all MG42s");
	turret endon ("killed");
	targets = getentarray (zone,"targetname");

	while (1)
	{
		if ((self.script_noteworthy == "endguy") && (level.player.origin[0] < line) && (level.player.origin[0] > stopline))
		{
//			if ((self.script_noteworthy != "endguy") && (!self.is_firing))
			if (!self.is_firing)
				turret stopfiring();

			self.fire_override = undefined;
//			turret.targettime = gettime() + 5000;
//			turret.newtarget = level.player;
			turret settargetentity (level.player);
		}
		else
		if ((flag("sniper talk")) && (!level.playerSafe))
		{
			level thread left_startShootingPlayer (turret);
			level waittill ("player is safe from left mg42s");
		}
		else
		{
			has_target = false;
			ai = getentarray ("wave_spawn","targetname");
			for (i=0;i<ai.size;i++)
			{
				if ((ai[i].origin[0] < line) && (ai[i].origin[0] > stopline))
				{
					has_target = true;
//					turret.targettime = 0;
//					turret.newtarget = ai[i];
					turret settargetentity (ai[i]);
					turret startfiring();
					self.fire_override = ai[i];
//					ai[i] thread current_target();
					i = ai.size + 1;
				}
			}
			ai = undefined;

			if (!has_target)
				turret settargetentity (random(targets));
		}

		wait (1);
	}
}

script_gunner_init(node)
{
//	self.origin = node.origin;
//	self.angles = node.angles;
	level thread add_totalguys(self);
	self.animname = "german mg42owner";
//	self hide();
	self UseAnimTree(level.scr_animtree[self.animname]);
	self [[level.scr_character[self.animname]]]();
	level waittill ("stop all MG42s");
	self delete();
}

script_gunner_think(turret, org, angles)
{
	level endon ("stop all MG42s");
	node = spawn ("script_origin",(0,0,0));
	node.origin = org + (0,0,60);
	node.angles = angles;
	self.origin = org;
	self.angles = angles;
	self linkto (node);
	thread script_gunner_death(node);
	thread script_gunner_anim(node, turret);
	guy[0] = self;
	self show();
	self anim_single (guy, "intro", undefined, node);
}

script_gunner_anim(node, turret)
{
	level endon ("stop all MG42s");
	self endon ("die gunner");
	guy[0] = self;
	while (1)
	{
		turret waittill ("turretstatechange");
		self notify ("stop anim");
		if (turret isFiringTurret())
			self thread anim_loop (guy, "fire", undefined, "stop anim", node);
		else
			self thread anim_loop (guy, "aim", undefined, "stop anim", node);
	}
}

script_gunner_death(node)
{
	level endon ("stop all MG42s");
	self waittill ("die gunner");
	println ("playing death anim");
	guy[0] = self;
//	self anim_single (guy, "death1", undefined, node);
	self animscripted("scriptedanimdone", node.origin, node.angles, level.scr_anim[self.animname]["death1"], "deathplant");
	self waittill ("scriptedanimdone");
	node delete();
	self hide();
}

player_is_hiding()
{
	if (level.player getstance() == "crouch")
		return true;

	if (level.player getstance() == "prone")
		return true;

	return false;
}

shoot_up_targets ( turret )
{
}

shoot_upper_targets(org, other_targets)
{
	self endon ("stop shooting upper targets");
	while (1)
	{
		org.origin = random(other_targets).origin + (randomfloat(20) - 10, randomfloat(20) - 10, randomfloat(20) - 100);
		wait (randomfloat (1.5));
	}
}


mg42_turret_stop()
{
	level waittill ("stop all MG42s");
	self notify ("died");
	self stopfiring();
}

mg42guy()
{
	level endon ("stop all MG42s");
	org = spawn ("script_model",(0,0,0));
//	org setmodel ("xmodel/temp");

	org.origin = (-92,156,280);
	node = getnode (self.target,"targetname");

	turret = getent (node.target, "targetname");

	mg42guy = getent (self.target,"targetname");
	self.mg42guy = mg42guy;
	self.mg42guy thread script_gunner_init(node);
	self.mg42guy thread script_gunner_think(turret, self.mg42guy.origin, self.mg42guy.angles);

	turret.org = org;
	turret setmode("manual");
	turret settargetentity(org);
	turret startfiring();

	turret thread mg42_turret_stop();
	turret thread mg42_manual_doshoot();
	turret thread mg42_auto_doshoot_burst();

	level endon ("player is leading sniper");
	other_targets = getentarray (turret.target,"targetname");
	thread leading_sniper(turret);
	allowed_time = 2500;
	if (self.script_noteworthy == "leftguy")
		offset = -1;
	else
	{
		println ("^ascript noteworthy was ", self.script_noteworthy);
		offset = 1;
	}

	thread shoot_upper_targets(org, other_targets);

	level waittill ("breaking through explosion");

	self notify ("stop shooting upper targets");

	timer = 0;
	while (1)
	{
		thread shoot_upper_targets(org, other_targets);

		while (player_is_safe())
			wait (0.1);

		self notify ("stop shooting upper targets");

		turret notify ("stop auto");
		turret startfiring();
		if (gettime() > timer)
		{
			timer = gettime() + allowed_time;
			while ((timer > gettime()) && (!player_is_safe()))
			{
				dist = ((timer - gettime()) * 750) / allowed_time;
				start = level.player.origin;
				start += (0 + (((dist+20)*0.5)*offset), 0 + ((dist+20)*1.0), 200);
				end = start + (0,0,-400);

				trace = bulletTrace(start, end, false, undefined);
				if (trace["fraction"] < 1.0)
				{
	//				line (start, trace["position"], (1,0.2,0.3), 0.5);
					playfx ( level._effect["ground"], trace["position"] );
	//				org.origin = trace["position"] + (0,0,-100);
					org.origin = trace["position"];

//					bulletTracer(start, trace["position"]);
					bulletTracer(self.origin, trace["position"]);
				}

				wait (randomfloat(0.1));
			}
		}

		while (!player_is_safe())
		{
			org.origin = level.player.origin + (0,0,randomfloat(100) - 50);
			wait (0.05);
		}

		turret thread mg42_auto_doshoot_burst();

		// Time it takes before they stop pegging you
		timer = gettime() + 2500;
		while ((gettime() < timer) && (isdefined (level.cover_trigger)) && (player_is_safe()))
		{
			target = random(getentarray (level.cover_trigger.target,"targetname"));
//			org.origin = target.origin + (randomfloat(20) - 10, randomfloat(20) - 10, randomfloat(20) - 10);
			org.origin = target.origin + (randomfloat(20) - 10, randomfloat(20) - 10, randomfloat(20) - 60);
//			println ("target origin " , target.origin);
			if (isdefined (target.script_fxid))
			{
				playfx ( level._effect [target.script_fxid], target.origin + (randomfloat(8) - 4, 0, randomfloat(8) - 4));
				target playSound (level.scr_sound ["dirt hit"]);
			}
//				target.origin + (randomfloat(20) - 10, randomfloat(20) - 10, randomfloat(20) - 10));
			else
			{
				target playSound (level.scr_sound ["metal hit"]);
				playfx ( level._effect ["metal small"], target.origin + (randomfloat(8) - 4, 0, randomfloat(8) - 4));

//				target.origin + (randomfloat(20) - 10, randomfloat(20) - 10, randomfloat(20) - 10));
			}

			wait (randomfloat (0.25));
		}
	}
}

leading_sniper (turret)
{
	level waittill ("player is leading sniper");
	self notify ("stop shooting recruits");
	self notify ("stop getting targets");
	turret stopfiring();
}

player_is_safe ()
{
	if (level.flag["mg42guy mg42s stop"])
		return true;

	if (gettime() < level.shellshock_safetime)
		return true;


	if ((isdefined (level.cover_trigger)) && (level.player getstance() != "stand"))
		return true;

//	println ("org ", level.player.origin);
	if (level.player.origin[1] < -1000)
		return true;

//	if (level.player.origin[1] < -1300)
//		return true;

	if (level.player.origin[0] > -1300)
		return false;


	return true;
}

death_think()
{
	level endon ("duck done");
	level waittill ("on docks");
	wait (5);
	self waittill ("trigger");
	//level.player DoDamage ( level.player.health + 50, (0,0,0) );
}

countdown_buffer()
{
	self waittill ("trigger");
	level.deathtime = gettime() + 3000;
	if (!isdefined (self.target))
	{
		self delete();
		return;
	}

	getent (self.target,"targetname") thread countdown_buffer();
	self delete();
}

play_warning (num)
{
	node = getnodearray( "commissar", "targetname" );

	voicenode = [];
	for (i=0;i<node.size;i++)
	{
		if ((isdefined (node[i].script_noteworthy))
		 && (isdefined (level.commissar_speech[node[i].script_noteworthy]))
		 && (isdefined (level.commissar_speech[node[i].script_noteworthy]["worthless_dog"]))
		 && (isdefined (level.commissar_speech[node[i].script_noteworthy]["worthless_dog"][num])))
			voicenode[voicenode.size] = node[i];
	}

	if (!voicenode.size)
		return;

	ent = maps\_utility::getClosest (level.player.origin, voicenode);

	ent.guy playsound (level.commissar_speech[ent.script_noteworthy]["worthless_dog"][num]);
}

death_countdown(trigger)
{
	trigger waittill ("trigger");
	getent (trigger.target,"targetname") thread countdown_buffer();
	trigger delete();
	level endon ("stop countdown");
	level.deathtime = gettime() + 30000;
	while (gettime() < level.deathtime)
		wait (0.2);

	play_warning (0);

	level.deathtime = gettime() + 10000;
	while (gettime() < level.deathtime)
		wait (0.2);

	play_warning (1);

	level.deathtime = gettime() + 10000;
	while (gettime() < level.deathtime)
		wait (0.2);

//	level.player DoDamage ( level.player.health + 50, (0,0,0) );
}

safety_trigger()
{
	oldspawners = level.recruit_spawners;
	newspawners = "animatic37";
	while (1)
	{
		self waittill ("trigger");
		level.recruit_spawners = newspawners;
		while (level.player istouching (self))
			wait (2);
		level.recruit_spawners = oldspawners;
	}
}


fodder_think()
{
	if (!delete_ai(1))
	{
		wait (1);
		return;
	}
//	println ("Fodder: Current ai size ", getaiarray().size);

	self.count = 1;
	spawn = self stalingradspawn("fodder guy");
	if (!isdefined (spawn))
		return;

	spawn endon ("death");

	spawn pre_seek_destination();
	spawn.health = 1;

	if (isdefined (spawn.script_noteworthy))
	{
		if (spawn.script_noteworthy == "kaboom")
			spawn thread mortar_impact();
	}

	node = getnode (spawn.target,"targetname");
	while (1)
	{
		spawn setgoalnode (node);
		spawn waittill ("goal");

		if (!isdefined (node.target))
			break;

		if (!isdefined (getnode (node.target,"targetname")))
			println ("node at origin ", node.origin," doesn't target but does");
		node = getnode (node.target,"targetname");
	}

	spawn coolKill();
}

mortar_impact ()
{
	self playsound ("mortar_incoming", "sounddone", true);
	self waittill ("sounddone");
	playfx ( level.mortar[randomint (level.mortar.size)], self.origin );
	self playsound ("mortar_explosion");

	ang = vectornormalize ( self.origin - level.player.origin );
//	ang = vectorToAngles (ang);
//  ang = anglesToForward(ang);
	ang = maps\_utility::vectorScale (ang, 100);
	mortar_hit (self.origin + ang);
//	mortar_hit (self.origin + (randomfloat(50) - 25, randomfloat(50) - 25, 0));
}

is_looking_towards (ent)
{
    forward = anglesToForward(self.angles);
    return (vectordot(forward, ent.origin - self.origin) > 0);
}

fodder_spawner ()
{
	level endon ("sniper talk");
	spawners = getentarray ("fodder","targetname");
	lastspawner = spawners[0];
	while (1)
	{
		possible_spawners = [];
		for (i=0;i<spawners.size;i++)
		{
			if (spawners[i] == lastspawner)
				continue;

			if (level.player is_looking_towards (spawners[i]))
				continue;

			possible_spawners[possible_spawners.size] =spawners[i];
		}

		if (possible_spawners.size)
		{
			spawner = random(possible_spawners);
			spawner thread fodder_think();
			lastspawner = spawner;
		}

		wait (0.5 + randomfloat (1));
	}
}

#using_animtree("generic_human");
dragger(dragger)
{
	org = dragger.origin;
	dragged = getent (dragger.target,"targetname");
	end_org = getent (dragged.target,"targetname").origin;
	ang = vectornormalize ( end_org - dragger.origin );
	ang = vectorToAngles (ang);

	dragged.count = 1;
	dragged = dragged stalingradspawn();
	if (maps\_utility::spawn_failed(dragged))
		return;	

	dragger.count = 1;
	dragger = dragger stalingradspawn();
	if (maps\_utility::spawn_failed(dragger))
		return;	

//	start_org = dragger.origin;
	dragger animscripts\shared::putGunInHand ("none");
	dragger.hasWeapon = false;
	dragged animscripts\shared::putGunInHand ("none");
	dragged.hasWeapon = false;

	dragged.health = 1;
	dragger.health = 1;
	level thread on_death_kill (dragger, dragged);
	level thread on_death_kill (dragged, dragger);
	dragger endon ("death");
	dragged endon ("death");
	dragger thread PrintOnDeath();
	dragged thread PrintOnDeath();
	node = spawnstruct();
	node.origin = dragger.origin;
	node.angles = ang;
	offset = (0, 0, 0);

	dragger.deathanim = %wounded_dragger_death;
	dragged.deathanim = %wounded_dragged_death;
	dragger.allowDeath = 1;
	dragged.allowDeath = 1;
	
	finalOrg2 = node.origin[2];
	level thread dragAnimation(dragger, dragged, node, offset, finalOrg2, end_org);
}

dragAnimation (dragger, dragged, node, offset, finalOrg2, end_org)
{
	dragger endon ("death");
	dragged endon ("death");
	
	dragger hide();
	dragged hide();
	wait (0.05);
	dragger show();
	dragged show();
	while (distance (dragger.origin, end_org) > 50)
	{
		println ("^6 draggin 1");
		vec = (node.origin[0] + offset[0], node.origin[1] + offset[1], finalOrg2);
		dragger animscripted("scriptedanimdone", vec, node.angles, %wounded_dragger_cycle);
		dragged animscripted("scriptedanimdone", vec, node.angles, %wounded_dragged_cycle);
		dragger waittillmatch ("scriptedanimdone", "end");
		offset += getCycleOriginOffset(node.angles, %wounded_dragger_cycle);
		offset += (0,0,offset[2]*-1);

		start = dragger.origin + (0,0,100);
		end = dragger.origin + (0,0,-100);
		trace = bulletTrace(start, end, false, undefined);
//		if (trace["fraction"] < 1.0)
		finalOrg2 = trace["position"][2];
		
//			offset += (0,0,trace["fraction"][2]*-1);
	}

	dragger coolKill();
	dragged coolKill();
}

PrintOnDeath()
{
	self waittill ("death");
	println ("###### I died!  Time: ",GetTime(),".");
}

on_death_kill (killer, killed)
{
	killer waittill ("death");
	if (isalive (killed))
		killed coolKill();
}

dragger_trigger(trigger)
{
	trigger waittill ("trigger");
	thread dragger (getent (trigger.target,"targetname"));
	trigger delete();
}

wounded_guy (wounded_guy, string)
{
	return;
	guy[0] = wounded_guy;
	guy[1] = getent (wounded_guy.target,"targetname");
	guy[2] = getent (guy[1].target,"targetname");
	guy[0].animname = "carrywalk1";
	guy[1].animname = "carrywalk2";
	guy[2].animname = "carrywalk3";

	guy[1].origin = guy[0].origin;
	guy[2].origin = guy[0].origin;

	for (i=0;i<guy.size;i++)
	{
		guy[i].count = 1;
		guy[i].health = 1;
		guy[i] = guy[i] stalingradspawn();
		guy[i] animscripts\shared::putGunInHand ("none");
		guy[i].hasWeapon = false;
	}

	end_org = getnode (guy[0].target,"targetname").origin;
	ang = vectornormalize ( end_org - guy[0].origin );
	ang = vectorToAngles (ang);

	thread wounded_walk (guy);
	level waittill ("breaking through explosion");
//	guy[0] notify ("stop walk");

	org = getent ("explode_crates_shellshock","targetname").origin;

	for (i=0;i<guy.size;i++)
	{
		guy[i].allowDeath = true;
		guy[i].deathAnim = guy[i] getExplodeDeath("generic", org, distance (guy[i].origin, org));
		guy[i] doDamage ( 50, (0,0,0) );
	}

}

wounded_walk (guy)
{
	level endon ("breaking through explosion");
	while (1)
	{
		for (i=0;i<guy.size;i++)
			guy[i] setFlaggedAnimKnob("animdone", level.scr_anim[guy[i].animname]["walk"][0]);

		guy[0] waittill ("animdone");
//		guy[0] thread anim_loop (guy, "walk", undefined, "stop walk", guy[0]);
	}
}

/*
wounded_guy_old (wounded_guy, string)
{
	guy[0] = wounded_guy;
	guy[1] = getent (wounded_guy.target,"targetname");
	guy[2] = getent (guy[1].target,"targetname");
	guy[0].animname = "carrywalk1";
	guy[1].animname = "carrywalk2";
	guy[2].animname = "carrywalk3";

	for (i=0;i<guy.size;i++)
	{
		guy[i].count = 1;
		guy[i].health = 1;
		guy[i] = guy[i] stalingradspawn();
		guy[i] animscripts\shared::putGunInHand ("none");
		guy[i].hasWeapon = false;
	}

	guy[0].targetname = string;

	end_org = getnode (guy[0].target,"targetname").origin;
	ang = vectornormalize ( end_org - guy[0].origin );
	ang = vectorToAngles (ang);
//	start_org = dragger.origin;

	guy[0] thread anim_loop (guy, "idle", undefined, "stop idle", guy[0]);
	guy[0] thread allowdeath (guy, "looping anim", "stop idle");

	guy[0] waittill ("stop idle");
	level waittill ("breaking through explosion");
	guy[0] thread anim_single (guy, "pickup", undefined, guy[0]);
	for (i=0;i<guy.size;i++)
		guy[i].allowDeath = true;

	guy[0] waittill ("single anim");

	guy[0] thread anim_loop (guy, "walk", undefined, "stop walk", guy[0]);
//	guy[0] thread allowdeath (guy, "looping anim", "stop walk");

	guy[0] notify ("stop walk");
	level waittill ("breaking through explosion");
	org = getent ("explode_crates_shellshock","targetname").origin;

	for (i=0;i<guy.size;i++)
	{
		guy[i].deathAnim = getExplodeDeath(org, distance (guy[i].origin, org));
		guy[i] doDamage ( 50, (0,0,0) );
	}
}
*/

allowdeath (array, msg, ender)
{
	self endon (ender);
	while (1)
	{
		for (i=0;i<array.size;i++)
			array[i].allowDeath = true;

		self waittill (msg);
	}
}

retreater()
{
	level endon ("sniper talk");

	spawners = getentarray ("retreater","targetname");
	lastspawner = -1;
	while (1)
	{
		index = -1;
		dist = 10000;

		for (i=0;i<spawners.size;i++)
		{
			if (lastspawner == i)
				continue;

			if ((index == -1) && (isdefined (spawners[i].script_noteworthy)))
				index = i;
//			if (level.player.origin[1] > spawners[i].origin[1])
//				continue;

			if (level.player is_looking_towards (spawners[i]))
				continue;

			newdist = distance (level.player.origin, spawners[i].origin);
			if (newdist > dist)
				continue;

			dist = newdist;
			index = i;
		}

		if (index != -1)
		{
			lastspawner = index;
			spawners[index] thread retreater_think();
		}
		wait (2.5);
	}
}

retreater_think()
{
	level endon ("sniper talk");
	if (!delete_ai(1))
	{
		wait (1);
		return;
	}
//	println ("Retreater: Current ai size ", getaiarray().size);

	self.count = 1;
	spawn = self stalingradspawn();
	if (!isdefined (spawn))
		return;

	spawn endon ("death");

	spawn pre_seek_destination();
	spawn.health = 1;

	if (isdefined (spawn.script_noteworthy))
	{
		if (spawn.script_noteworthy == "kaboom")
			spawn thread mortar_impact();
	}

	index = -1;
	node = spawn;
	while (1)
	{
		node = getrandomnode (node.target,"targetname");

		if (!isdefined (node.target))
			break;

		spawn setgoalnode (node);
		spawn waittill ("goal");


//		if (!isdefined (getnode (node.target,"targetname")))
//			println ("node at origin ", node.origin," doesn't target but does");

		if (!isdefined (node.script_chaintarget))
			continue;

		if (index != -1)
			continue;

		guys = getentarray ("commissar think guy","targetname");

//		dist = 1550;
		dist = 2000;
		for (i=0;i<guys.size;i++)
		{
			if (isdefined (guys[i].customTarget))
				continue;

//			thread line_time (guys[i], 2000);

			if (!guys[i] is_looking_towards (spawn))
				continue;

			newdist = (distance (guys[i].origin, spawn.origin));
			if (newdist < dist)
			{
				index = i;
				dist = newdist;
			}
		}

		if (index == -1)
			continue;

		guys[index].customTarget = spawn;
		guys[index] notify ("yell at custom target now");
	}

	spawn setgoalnode (node);

	if (index != -1)
	{
		spawn.goalradius = 100;
		spawn waittill ("goal");
		guys[index] notify ("shoot custom target now");
		guys = undefined;
		spawn.goalradius = 0;
		spawn waittill ("goal");
		spawn coolKill();
	}

	spawn waittill ("goal");
	spawn coolKill();
}



stop_recruit_spawner(trigger)
{
	trigger waittill ("trigger");
	self notify ("stop spawning");
}

debug_recruit_print (spawners)
{
	self endon ("stop spawning");
	while (1)
	{
		for (i=0;i<spawners.size;i++)
			print3d ((spawners[i].origin + (0, 0, 65)), "spawn", (0.48,9.4,0.76), 0.85);
		wait (0.05);
	}
}

recruit_spawn_thread (spawners)
{
	self endon ("stop spawning");
//	while (1)
//		o_recruit_spawn(spawners);
}

recruit_spawners_think()
{
	self.count = 1;
	spawn = self stalingradspawn("recruit_spawn");
	if (isdefined (spawn))
		spawn thread seek_destination();
}

death_ent_notify (spawn, ent)
{
	spawn endon ("reached first goal");
	spawn waittill ("death");
	ent notify ("reached first goal");
}

delete_ai (num)
{
	space = num;
	ai = getaiarray();
	num+=ai.size;
	num-=level.maxHillAI;
	if (num <= 0)
		return true;

	ai = getentarray ("wave_spawn","targetname");
	ai = maps\_utility::array_randomize(ai);

	to_be_deleted = [];
	for (i=0; i < ai.size; i++)
	{
		if (num <= 0)
			break;

		if (ai[i].spawnflags & 4)
			continue;

//		println ("Targetname ", ai[i].targetname);

		if (level.player is_looking_towards (ai[i]))
			continue;

		ai[i] thread coolkill();
		to_be_deleted[to_be_deleted.size] = ai[i];
//		ai[i] delete();
		num--;
	}

	if (to_be_deleted.size)
	{
		wait (1.5);
		for (i=0;i<to_be_deleted.size;i++)
		{
			if (isdefined (to_be_deleted[i]))
			{
				to_be_deleted[i] delete();
//				println ("deleted AI");
			}
		}
	}

	ai = getaiarray();
	num = space;
	num+=ai.size;
	num-=level.maxHillAI;
	if (num <= 0)
		return true;
	else
		return false;

	ai = getentarray ("wave_spawn","targetname");
	if (!ai.size)
		return false;

	index = 0;
	for (i=0; i<ai.size; i++)
		ai[i].delete_dist = distance (level.player.origin, ai[i].origin);

	returner = true;
	for (p=0;p<num;p++)
	{
//		ai = getaiarray();
		ai = getentarray ("wave_spawn","targetname");
		if (!ai.size)
			return false;
		index = 0;
		for (i=1; i<ai.size; i++)
		{
			if (ai[i].spawnflags & 4)
				continue;

//			println ("Targetname ", ai[i].targetname);

			if (ai[i].delete_dist > ai[index].delete_dist)
				index = i;
		}

		if (ai[index].spawnflags & 4)
		{
			returner = false;
			continue;
		}

		ai[index] delete();
	}

	return returner;

}

do_recruit_spawn(spawners)
{
	ent = spawnstruct();
	ent.threads = 0;

	current_spawners = 0;

	if ((level.player.angles[1] > 25) && (level.player.angles[1] < 155))
	{
		for (i=1;i<spawners.size;i++)
		{
			if (spawners[i][0].origin[1] > level.player.origin[1])
				continue;

			if (spawners[i][0].origin[1] > spawners[current_spawners][0].origin[1])
				current_spawners = i;
		}
	}

	spawners = spawners[current_spawners];
	if (!delete_ai(4))
	{
		wait (1);
		return;
	}

	for (i=0;i<spawners.size;i++)
	{
		spawners[i].count = 1;
		spawn = spawners[i] stalingradspawn ();
		if (!isdefined (spawn))
		{
//			println ("couldnt spawn, but why?");
			continue;
		}

//		spawners[i] thread current_target(1500);

		spawn thread seek_destination(ent);
		spawn thread interval_change();
		level thread death_ent_notify (spawn, ent);
		ent.threads++;
	}

	if (!ent.threads)
		wait (1);

	while (ent.threads)
	{
		ent waittill ("reached first goal");
		ent.threads--;
//		println ("Threads left ", ent.threads);
	}

	wait (0.05); // In case all the guys instantly reach their goal soooomehow.

/*
	if (isdefined (spawners[0].script_side))
	{
		if (level.recruit_spawn_side == spawners[0].script_side)
		{
			if (level.recruit_spawn_side == "left")
				level.recruit_spawn_side = "right";
			else
				level.recruit_spawn_side = "left";
		}
		else
		{
			println ("side is ", level.recruit_spawn_side);
			return;
		}
	}

	maps\_utility::array_thread(spawners, ::recruit_spawners_think);
*/
}

interval_change ()
{
	self endon ("death");
	wait (8);
	self.interval = 48;
}

recruit_spawner (spawnername, ender)
{
	if (isdefined (ender))
		level endon (ender);
//	level endon ("stop spawning new recruits");
//	level.recruit_spawners = getentarray ("first_spawner","targetname");
	spawners = getentarray (spawnername,"targetname");
//	thread debug_recruit_print (spawners);
	for (i=0;i<spawners.size;i++)
		newspawners[spawners[i].script_hillgroup] = [];

	for (i=0;i<spawners.size;i++)
		newspawners[spawners[i].script_hillgroup][newspawners[spawners[i].script_hillgroup].size] = spawners[i];

	for (i=0;i<newspawners.size;i++)
	{
		for (p=1;p<newspawners[i].size;p++)
		{
			if (newspawners[i][p].origin[1] > newspawners[i][0].origin[1])
			{
				temp_spawner = newspawners[i][0];
				newspawners[i][0] = newspawners[i][p];
				newspawners[i][p] = temp_spawner;
			}
		}
	}

	temp_spawner = undefined;
	spawners = undefined;

	while (1)
		do_recruit_spawn(newspawners);
}

#using_animtree("generic_human");
shoot_plane()
{
	self endon ("death");

	level waittill ("global target");
	wait (randomfloat (1));
	self animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
	self.customtarget = (level.global_target);
	wait (9);
	self notify ("end_sequence");
}

trigger_scatter (trigger)
{
	nodes = getallnodes();
	scatter_nodes = [];
	for (i=0;i<nodes.size;i++)
	{
		if (!isdefined (nodes[i].script_scatter))
			continue;

		if (nodes[i].script_scatter != trigger.script_scatter)
			continue;

		scatter_nodes[scatter_nodes.size] = nodes[i];
	}

	nodes = undefined;
	level thread trigger_scatter_nodes (trigger, scatter_nodes);
}

trigger_scatter_nodes (trigger, scatter_nodes)
{
	while (1)
	{
		trigger waittill ("trigger");
		for (i=0;i<scatter_nodes.size;i++)
			level notify ("move broadcast " + scatter_nodes[i].script_linked);
	}
}


pre_seek_destination ()
{
	if ((!isdefined (self.animname)) || ((self.animname != "gunguy") && (self.animname != "ammoguy")))
	{
		if (randomint (100) > 75)
		{
			self.animname = "gunguy";
			self.hasWeapon = true;
		}
		else
		{
			self.animname = "ammoguy";
			self.hasWeapon = false;
		}
	}

	self.team = "allies";

//	self.interval = 40;
//	self.interval = 16;
	self.walk_noncombatanim = undefined;
	self.walk_noncombatanim2 = undefined;
	self.run_noncombatanim = undefined;
	self.suppressionwait = 0;
	self.maxsightdistsqrd = 0;

	self.interval = 0;

	self.walkdist = 0;
	self.health = 100;
	self.killable = false;
	self.on_move = true;
	self.goalradius = 128;
//	self.personalspace = 0;

	// BASE POSE CAUSER
	self allowedStances ("crouch");
//	self animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
//	self lookat (level.player);
}

destination_line()
{
	while (1)
	{
		line (self.origin + (0,0,10), self.destination_origin  + (0,0,10), (0.2, 1, 0.2), 1, true);
		wait (0.05);
	}
}

getrandoment (msg, type)
{
	ent = getentarray (msg, type);
	if (ent.size)
		return random(ent);
	else
		return ent;
}

getrandomnode (msg, type)
{
	ent = getnodearray (msg, type);
	if (ent.size)
		return random(ent);
	else
		return ent;
}

seek_destination (ent)
{
	self endon ("death");
	pre_seek_destination();
	if (!isdefined (self.seekingdest))
		self.seekingdest = true;
	else
		maps\_utility::error ("DOUBLE SEEK on guy at " + self.origin + " with " + self.targetname);
		
	if (self.hasWeapon)
		thread shoot_plane();

	self thread kill_on_msg( "stop all MG42s" );

	if (!isdefined (self.target))
	{
//		println ("origin is ", self.origin);
		return;
	}

	destination = getrandoment (self.target,"targetname");
	destination_is_entity = true;

	if (!destination.size)
	{
		destination = getrandomnode (self.target,"targetname");
		destination_is_entity = false;
	}


//	self animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
//	self notify ("end_sequence");
	if (!isdefined (destination))
		println ("Target: ", self.target);

	self.destination_origin = destination.origin;
//	self thread destination_line();
	firstgoal = true;
	skipgoal = false;

	while (1)
	{
		if (destination_is_entity)
			self setgoalpos (destination.origin);
		else
		{
			self setgoalnode (destination);
			if (!isdefined (destination.script_linked))
				println (destination.origin);
			level notify ("move broadcast " + destination.script_linked);
		}

		self.destination_origin = destination.origin;

		if (!skipgoal)
		{
			if (isdefined (destination.script_linked))
			{
 				if (!isdefined (destination.wave_user))
 				{
					destination.wave_user = self;
//					level thread draw_user(self, destination);
					level thread clear_wave_user_on_death (self, destination);
					self waittill ("goal");
				}
			}
			else
				self waittill ("goal");
		}
		else
			skipgoal = false;


//		self thread current_target(500);

		if (!isdefined (destination.target))
			break;

		if ((firstgoal) && ((isdefined (destination.script_linked)) || (isdefined (destination.script_chaintarget))))
		{
			if (!isdefined (self.targetname))
				self.targetname = "wave_spawn";
			firstgoal = false;
			thread notify_reached (ent);
		}

		if ((isdefined (destination.script_linked)) && (isdefined (destination.wave_user)) && (destination.wave_user == self))
		{
			self.customtarget = undefined;

			wait (1);
			level waittill ("move broadcast " + destination.script_linked);
			destination.wave_user = undefined;
			self notify ("move broadcast received SIR");
			wait (randomfloat (0.6));
		}
		else
			skip_goal = true;

		newdestination = getrandoment (destination.target,"targetname");
		destination_is_entity = true;

		if (!newdestination.size)
		{
			newdestination = getrandomnode (destination.target,"targetname");

			if (isdefined (newdestination.script_noteworthy))
			{
				if ((!level.flag["sniper time"]) && (newdestination.script_noteworthy == "call plane"))
					level notify ("start planes 25");

				if (newdestination.script_noteworthy == "kaboom")
					self thread mortar_impact();
			}

			destination_is_entity = false;
		}

//		if (!isdefined (newdestination))
//			println ("Destination origin ", destination.origin);

		destination = newdestination;
	}

	if (self.origin[0] > -1700)
		self coolKill();
	else
	{
		if (!level.flag["player approaches final commissar"])
			level waittill ("player approaches final commissar");

		self setgoalnode (getnode ("end","targetname"));
		self waittill ("goal");
		self delete();
	}
}

clear_wave_user_on_death (ent, destination)
{
	ent endon ("move broadcast received SIR");
	ent waittill ("death");
	destination.wave_user = undefined;
}

draw_user(ent, destination)
{
	ent endon ("move broadcast received SIR");
	ent endon ("death");

	while (1)
	{
		org = destination.wave_user.origin;
		line (destination.origin + (0,0,125), org, (0.9,0.8,1.0), 0.5);
		wait (0.05);
	}
}

/*
clear_wave_user (node)
{
	level waittill ("move broadcast " + node.script_linked);
	node.wave_user = undefined;
}
*/

notify_reached (ent)
{
	wait (1); // this time has to stay the same as the wait 1 above
	self notify ("reached first goal");

	if (isdefined (ent))
		ent notify ("reached first goal");
}

/*
sniper_start(trigger)
{
	trigger waittill ("trigger");
}
*/

final_commissar ()
{
	spawner = getent ("final_commissar","targetname");
	while (1)
	{
		spawn = spawner stalingradspawn();
		if (isdefined (spawn))
			break;
		wait (1);
	}
	spawn endon ("death");
	spawn.alwaysPop = true;


	spawn.health = 50000;
	level.mg42guy["commissar"] = spawn;
	spawn.animname = "buildingcommissar";
	spawn character\_utility::new();
	if (isdefined (level.scr_character[spawn.animname]))
		spawn [[level.scr_character[spawn.animname]]]();

	spawn.team = "neutral";
	level.player.ignoreme = false;
	spawn lookat(level.player);
	level.player.ignoreme = true;
	spawn thread kill_fleeing_guy();
//	spawn thread kill_friendlies();
	wait (1);
//	spawn.dropWeapon = true;
	spawn.dropWeapon = false;

	getent ("kill_commissar","targetname") waittill ("trigger");
	level notify ("player approaches final commissar");
	level.flag["player approaches final commissar"] = true;
	spawn notify ("kill player");
	spawn lookat(level.player);
	wait (1);

	spawn animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
	spawn.customtarget = (level.player);
	spawn thread commissar_anim_killer();
	spawn.allowDeath = 1;
	spawn thread allow_death();
//	spawn playsound ("BuildingCommissar", "sounddone");
//	spawn waittill ("sounddone");
}

kill_fleeing_guy()
{
	self endon ("kill player");
	level waittill ("fleeing guy runs");
//	level.flag["fleeing guy spawned"] = true;
	if (!isdefined (level.fleeing_guy))
		return;


	self animscripts\face::SaySpecificDialogue(undefined, "commissar3_line49", 1.0, "sounddone new 2");
//	self playsound ("commissar3_line49","sounddone");
	self lookat(level.fleeing_guy);
	self.customTarget = level.fleeing_guy;
	self waittill ("sounddone new 2");
	while ((isalive (level.fleeing_guy)) && (distance (self.origin, level.fleeing_guy.origin) > 190))
		wait (0.05);

	if (isalive (level.fleeing_guy))
	{
		self animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
		level.fleeing_guy waittill ("death");
		wait (1);
		self.customTarget = undefined;
		self notify ("end_sequence");
	}

	self thread kill_friendlies();
}

commissar_anim_killer()
{
	self endon ("death");
	guy[0] = self;
	anim_single (guy, "fullbody");
	level.player coolKillplayer(self.origin + (0,0,70));
}

combine_arrays(a, b)
{
	for (i = 0; i < b.size; i++)
		a[a.size] = b[i];
	return a;
}

kill_friendlies()
{
	self endon ("kill player");
	while (1)
	{
		recruit_spawn = getentarray ("recruit_spawn","targetname");
		wave_spawn = getentarray ("wave_spawn","targetname");
		ai = combine_arrays(recruit_spawn, wave_spawn);
		recruit_spawn = undefined;
		wave_spawn = undefined;

		left = -2800;
		num = -1;
		for (i=0;i<ai.size;i++)
		{
			if (ai[i].origin[0] < left)
			{
				left = ai[i].origin[0];
				num = i;
			}
		}

		if (num >= 0)
		{
			self animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
			self.customtarget = ai[num];
			self.team = "neutral";
			ai[num] waittill ("death");
///			self.team = "allies";
			self notify ("end_sequence");
		}
		else
		{
			self.customtarget = undefined;
			wait (1);
		}

	}
}

kill_on_msg (msg)
{
	self endon ("death");
	level waittill (msg);
	wait (randomfloat (2.5));
	self coolKill();
}

end_german ( spawner )
{
	level endon ("start end barrage");
//	while (1)
	{
		while (1)
		{
			spawner.count = 1;
			spawn = spawner stalingradspawn();
			if (isdefined (spawn))
				break;
			wait (1);
		}
		spawn thread kill_on_msg("start end barrage");

		spawn allowedstances ("crouch", "stand");
		spawn.suppressionwait = 0;
		spawn setgoalnode (getnode (spawn.target,"targetname"));
		spawn.goalradius = 256;
		spawn waittill ("death");
		wait (2);
	}
/*
	while (1)
	{
		spawn thread kill_nearest_ally();
		spawn waittill ("move on");
	}
*/

}

auto_move_on()
{
	self endon ("move on");
	wait (6);
	self notify ("move on");
}

kill_nearest_ally()
{
	self endon ("move on");
	self thread auto_move_on();
	ai = maps\_utility::getClosestAI (self.origin, "allies");
	self.favoriteEnemy = ai;
	ai.threatbias = 50000;
	ai waittill ("death");
	self notify ("move on");
}

allow_death()
{
	wait (0.05);
	self.allowDeath = 1;
}

lookat (ent, timer)
{
	if (!isdefined (timer))
		timer = 10000;

	self animscripts\shared::lookatentity(ent, timer, "alert");
}

kill_mg42_right( trigger )
{
	level.flag["kill mg42 right"] = false;
	trigger waittill ("trigger");
	trigger delete();
	level.flag["kill mg42 right"] = true;
	level notify ("kill mg42 right");
}

kill_mg42_left( trigger )
{
	level.flag["kill mg42 left"] = false;
	trigger waittill ("trigger");
	trigger delete();
	level.flag["kill mg42 left"] = true;
	level notify ("kill mg42 left");
}

kill_commissar( trigger )
{
	level.flag["kill commissar"] = false;
	trigger waittill ("trigger");
	level.flag["kill commissar"] = true;
	level notify ("kill mg42 left");
}

trigger_waittill_delete (name)
{
	trigger = getent (name,"targetname");
	trigger waittill ("trigger");
	trigger delete();
}

sniper_death (sniper)
{
	sniper waittill ("death");
	println ("^dSNIPER DIED");
}

mg42_flashes_cleanup ( trigger )
{
	level.mg42guy[trigger.script_noteworthy] waittill ("killed");
	wait (0.4);
	trigger notify ("stop gen");
	wait (1);

	target = trigger;
	while (isdefined (target.target))
	{
		newtarget = getent (target.target,"targetname");
		target delete();
		target = newtarget;
	}
}

mg42_flashes (trigger)
{
	trigger endon ("stop gen");
//	level.mg42guy[trigger.script_noteworthy] endon ("killed");
	level thread mg42_flashes_cleanup(trigger);
	trigger waittill ("trigger");

	target = trigger;
	targets = [];
	while (isdefined (target.target))
	{
		target = getent (target.target,"targetname");
		target playSound (level.scr_sound ["metal hit"]);
		playfx ( level._effect ["metal"], target.origin + (randomfloat(8) - 4, 0, randomfloat(8) - 4));
		wait (randomfloat (0.1));
		targets[targets.size] = target;
	}

	while (1)
	{
		targets = maps\_utility::array_randomize(targets);
		for (i=0;i<targets.size;i++)
		{
			targets[i] playSound (level.scr_sound ["metal hit"]);
			playfx ( level._effect ["metal"], targets[i].origin + (randomfloat(8) - 4, 0, randomfloat(8) - 4));
			wait (randomfloat (0.1));
		}
	}
}

nextSniperObjective (timer, obj)
{
	wait (timer);
	objective_position (2, obj.origin);
	objective_ring(2);
}

sniper_think (spawner)
{
	sniper = spawner stalingradspawn("sniper");
	/*
	sniper.animname = "sniper";
	node = getnode ("mg42_kill4","targetname");
	sniper thread sniper_moves_on (node);
	return;
	*/
	
	sniper.threatbias = 5000;

	thread sniper_death( sniper );
//	level thread kill_mg42_right (getent ("kill_mg42_right","targetname"));
//	level thread kill_mg42_left (getent ("kill_mg42_left","targetname"));
//	level thread kill_commissar (getent ("kill_commissar","targetname"));
	level.sniper = sniper;
	sniper maps\_names::get_name(true);
	sniper.team = "neutral";
	sniper.health = 50000;
	sniper.animname = "sniper";
	sniper.ignoreme = true;
	sniper allowedstances ("stand");

//	guy maps\_utility::
//	guy character\_utility::new();
//	guy.hasWeapon = false;
//	guy [[level.scr_character[guy.animname]]]();
//	guy animscripts\shared::putGunInHand ("left");
//	guy animscripts\shared::doNoteTracks("scriptedanimdone");
	sniper character\_utility::new();
	sniper [[level.scr_character[sniper.animname]]]();
	
	sniper pushPlayer(true);

//	guy[i] animscripts\shared::doNoteTracks(uniquename);
	node = getnode ("kill_mg42_right","targetname");
	sniper.goalradius = node.radius;
	sniper setgoalnode (node);
	sniper waittill ("goal");

	trigger = getent ("sniper_start","targetname");
	trigger waittill ("trigger");
	maps\_utility::array_levelthread(getentarray( "mg42_flashes","targetname" ), ::mg42_flashes);


//	maps\_utility::error ("sniper talk");

	guy[0] = sniper;
	anim_single(guy, "transitionA", undefined, node);
	sniper thread anim_loop (guy, "idleA", undefined, "sniper talk", node);

//	level waittill ("sniper time");

	trigger = getent ("sniper_talk","targetname");
	if (!(level.player istouching (trigger)))
		trigger waittill ("trigger");

//	level.flag["mg42guy mg42s stop"] = true;
//	sniper lookat (level.player);
	sniper animscripts\shared::LookAtAnimations(level.scr_anim[sniper.animname]["lookleft"], level.scr_anim[sniper.animname]["lookright"]);

	flag_set ("sniper talk");

//	maps\_utility::autosave(3);

//	objective_state(2, "done");
//	objective_add(3, "active", &"STALINGRAD_OBJ3", (-3804, 1745, 648));
//	objective_current(3);
	setPlayerIgnoreRadiusDamage(false);

	sniper notify ("sniper talk");

//	anim_single(guy, "transitionB", undefined, node);
/*
	sniper thread anim_loop (guy, "idleB", undefined, "stop anim", node);
	wait (1);
	sniper notify ("stop anim");
*/
	anim_single(guy, "transitionC", undefined, node);
	println ("starting COMRADE I CANT GET..");

	sniper allowedstances ("crouch");

	sniper.desired_anim_pose = "crouch";
	sniper animscripts\utility::UpdateAnimPose();

//	level thread wait_notify (15.5, "go go go"); // 14.5
	level thread wait_notify (14.9, "go go go"); // 14.5
	level thread wait_notify (16.5, "sniper is talking"); // 14.5
	level.playerSafeFromMG42Time = 4000;
	objectiveDestination = getent ("sniper destination","targetname");
	level thread nextSniperObjective (9, objectiveDestination);

	anim_single(guy, "fullbody60", undefined, node);
	println ("READY.........");
	sniper thread anim_loop (guy, "idleC", undefined, "stop anim", node);

	wait (1);

	sniper notify ("stop anim");

	sniper animscripts\shared::LookAtAnimations(undefined, undefined);
//	sniper playsound (level.scrsound[sniper.animname]["fullbody61"]);
	level thread wait_notify (1, "sniper stops talking"); // 14.5
	anim_single(guy, "fullbody61", undefined, node);
	anim_single(guy, "transitionD", undefined, node);

	sniper thread anim_loop (guy, "idleD", undefined, "stop anim", node);
	println ("gogogogo");

	level.flag["sniper is talking"] = false;
	node = getnode ("kill_mg42_right","targetname");
	trigger_waittill_delete ("kill_mg42_right");
	thread groupstart("left far dock", 7000, 10000, "stop all MG42s");

	sniper setgoalpos (sniper.origin);

//	anim_single(guy, "transitionD", undefined, node);
//	sniper.interval = 16;
	sniper.walkdist = 0;

	node = getnode (node.target,"targetname");
	sniper.goalradius = node.radius;
//	sniper thread current_target();

	// Let the MG42s in the first area allow the hill guys to get to the next area.
//	level notify ("player is leading sniper");

//	sniper setgoalnode (node);
	wait (0.5); // was 1.25
	sniper sniper_kills ("rightguy2");
//	sniper setgoalnode (node);
//	sniper waittill ("goal");
	wait (0);
	waitUntilPlayerTouchesSafeTrigger ("rightguy");
	sniper sniper_kills ("rightguy", "left mg42s stop firing");
	sniper notify ("stop anim");
	wait (1);









	node = getnode ("kill_mg42_left","targetname");
//	sniper.goalradius = node.radius;
	sniper.goalradius = 4;
	sniper setgoalnode (node);
	wait (2);
	sniper allowedstances ("stand");
	sniper waittill ("goal");
	sniper setgoalpos (sniper.origin);


	sniper animscripts\shared::LookAtAnimations(level.scr_anim[sniper.animname]["lookleft62"], level.scr_anim[sniper.animname]["lookright62"]);
	anim_reach(guy, "fullbody62", node);
	level thread wait_notify (9.2, "sniper is talking"); // 14.5
	objectiveDestination = getent (objectiveDestination.target,"targetname");
	level thread nextSniperObjective (5, objectiveDestination);
	anim_single(guy, "fullbody62", undefined, node);

	sniper animscripts\shared::LookAtAnimations(undefined, undefined);
	sniper thread anim_loop (guy, "holdidle", undefined, "stop anim", node);

	wait (1);

//	level waittill ("leftguy" + "stop"); // GO GO GO
	sniper notify ("stop anim");

	anim_single(guy, "fullbody63", undefined, node); // GO GO GO
//	sniper.facial_animation = level.scr_face[sniper.animname]["fullbody63"];
//	sniper animscripted("scriptedanimdone", node.origin, node.angles, level.scr_anim[sniper.animname]["fullbody63"]);
//	sniper playsound (level.scrsound[sniper.animname]["fullbody61"]);
	println ("gogogogo");
	level.flag["sniper is talking"] = false;
	level notify ("sniper stops talking");

	sniper thread anim_loop (guy, "holdidle", undefined, "stop anim", node);
	trigger_waittill_delete ("kill_mg42_left");
//	if (!level.flag["kill mg42 left"])
//		level waittill ("kill mg42 left");
	sniper notify ("stop anim");

	node = getnode (node.target,"targetname");
	sniper.goalradius = node.radius;
	sniper allowedstances ("crouch");

	sniper setgoalnode (node);
	wait (0.5);
//	sniper animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
	sniper sniper_kills ("leftguy2");
	sniper setgoalnode (node);
	sniper waittill ("goal");
	wait (0);
	waitUntilPlayerTouchesSafeTrigger ("leftguy");
	sniper sniper_kills ("leftguy", "left mg42s stop firing");
	wait (1);
//	sniper notify ("end_sequence");









	node = getnode ("kill_commissar","targetname");
	sniper.goalradius = 4;
//	sniper.goalradius = node.radius;
	sniper setgoalnode (node);
	sniper waittill ("goal");
	sniper setgoalpos (sniper.origin);

	level thread wait_notify (4, "fleeing guy runs");
//	level thread wait_notify (3, "sniper is talking"); // 14.5
	objectiveDestination = getent (objectiveDestination.target,"targetname");
	level thread nextSniperObjective (7, objectiveDestination);
	anim_reach(guy, "fullbody64", node);
	anim_single(guy, "fullbody64", undefined, node);
	anim_single(guy, "fullbody64gogo", undefined, node);

//	anim_single(guy, "fullbody63", undefined, node); // GO GO GO
	println ("gogogogo");
//	level thread wait_notify (0, "sniper stops talking"); // 14.5
	sniper thread anim_loop (guy, "fullbody64idle", undefined, "stop anim", node);

//	if (!level.flag["kill commissar"])
//		level waittill ("kill commissar");

	trigger_waittill_delete ("kill_commissar");
	sniper notify ("stop anim");

	node = getnode (node.target,"targetname");
	sniper.goalradius = node.radius;
//	sniper setgoalnode (node);
//	sniper waittill ("goal");

//	sniper animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
	wait (1);
	sniper.customAttackSpeed = "hide";
	sniper sniper_kills ("commissar");
	sniper.customAttackSpeed = "fast";
//	sniper notify ("end_sequence");

	node = getnode ("mg42_kill4","targetname");
	sniper.goalradius = node.radius;
	sniper setgoalnode (node);
	sniper lookat (sniper, 0.1);
	sniper waittill ("goal");
	sniper setgoalpos (sniper.origin);

//	sniper lookat (level.spotter);
	if (!level.flag["spotter ready"])
		level waittill ("spotter ready");

	wait (0.25);
//	if (!level.flag["explosive finale"])
//	maps\_utility::array_levelthread(getentarray( "end_german","targetname" ), ::end_german);
	sniper.team = "allies";

	anim_single(guy, "fullbody67", undefined, node);
//	sniper SetFlaggedAnimRestart("scripted_anim_facedone", level.scr_face[sniper.animname]["fullbody67"], 1, .1, 1);
//	level playSoundinSpace (level.scrsound[sniper.animname]["fullbody67"], sniper.origin);

	sniper.goalradius = 256;
//	sniper animcustom (animscripts\scripted\stalingrad_cover_crouch::main);

	level.playerSafeFromMG42Time = 1000;

	level.flag["artillery fire"] = true;
	level notify ("artillery fire");
	sniper_targets = getentarray ("sniper_target","targetname");
	sniper thread sniper_moves_on(node);
//	if (!level.flag["start end barrage"])
//		level waittill ("start end barrage");

//	sniper notify ("end_sequence");

	return;

	level endon ("endgame");
	while (1)
	{
		sniper animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
		newtarget = random(sniper_targets);

// LOOK HERE
		while (sniper.customtarget == newtarget)
			newtarget = random(sniper_targets);

		sniper.customtarget = newtarget;
		sniper lookat (sniper.customtarget);
		wait (1 + randomfloat (1));
		sniper notify ("end_sequence");
		wait (randomfloat (3));
	}

}

wait_notify (delay, msg)
{
	wait (delay);
	self notify (msg);
	level.flag[msg] = true;
}

sniper_moves_on (node)
{
	level waittill ("endgame");
	self notify ("end_sequence");
//	self playsound ("lead_conscript_line72", "sounddone");
	guy[0] = self;	
	anim_reach(guy, "retaking redsquare", node);
	anim_single(guy, "retaking redsquare", undefined, node);
		
//	self animscripts\face::SaySpecificDialogue(undefined, "lead_conscript_line72", 1.0, "sounddone new 3");
//	self waittill ("sounddone new 3");
//	wait (1.5);
	node = getnode ("end","targetname");
	self setgoalnode (node);
	self waittill ("goal");
	self delete();
}

//	anim_loop (guy, "holdidle", undefined, undefined, node);

random (array)
{
	return array [randomint (array.size)];
}

sniperDelayedShoot ()
{
	wait (0.4);
	self shoot();
}

sniper_kills(msg, notifier)
{
	enemy = level.mg42guy[msg];

	wait (1);
	/*
	if (msg != "commissar")
	{
		self animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
		self.customtarget = (enemy);
	}
	*/

	if ((msg == "leftguy") || (msg == "leftguy2"))
	{
		self animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
		self.customtarget = (enemy);
	}

	level.mg42guy[msg] notify ("killed");
	println ("^4notified killed on ", level.mg42guy[msg]);
	if ((msg == "leftguy") || (msg == "leftguy2"))
		thread sniperDelayedShoot();
	else
		self shoot();

	if (msg == "commissar")
	{
		level.mg42guy[msg] thread coolKill();
//		level thread playSoundinSpace (level.scr_sound ["sniper rifle fire"], level.player.origin);
//		level.player playsound (level.scr_sound ["sniper rifle fire"]);
//		level thread playSoundinSpace (, level.player.origin);
	}

	println ("*BANG*");
	if (isdefined (notifier))
		level notify (notifier);

//	self playsound (level.scr_sound ["sniper rifle fire"]);

//	wait (0.5);
	if (msg != "commissar")
		wait (1.5);

	if ((msg == "leftguy") || (msg == "leftguy2"))
		self notify ("end_sequence");
}

his_own_death()
{
	wait (0.1);
	self coolKill();
}

cover_think()
{
	self waittill ("trigger");
//	level notify ("manual doshoot burst");

	while (1)
	{
		level.cover_trigger = self;
		if (isdefined (self.script_noteworthy))
			level notify (self.script_noteworthy);

		while (level.player istouching (self))
			wait (0.25);
		level.cover_trigger = undefined;
//		println ("2 COVER TRIGGER UNDEFINED ", self getorigin());
		self waittill ("trigger");
	}
}

kill_cover_trigger ( msg )
{
	triggers = getentarray ("cover","targetname");
	for (i=0;i<triggers.size;i++)
	{
		if ((!isdefined (triggers[i].script_noteworthy)) || (triggers[i].script_noteworthy != msg))
			continue;

		if ((isdefined (level.cover_trigger)) && (level.cover_trigger == triggers[i]))
			level.cover_trigger = undefined;

		triggers[i] delete();
	}
}

mg42_trigger(trigger)
{
	trigger waittill ("trigger");
	while (level.player istouching (trigger))
		wait (0.5);
	trigger delete();

	level.flag["mg42_trigger"] = true;

	level notify ("duck done");


	while (1)
	{
		while (!isdefined (level.cover_trigger))
			wait (0.25);

		level.mg42_target = level.cover_trigger;
		println ("target is cover trigger");

		self thread trigger_check();
		self thread continue_check();
		self waittill ("continue");

/*
		timer = gettime() + 3000;
		while (gettime() < timer)
		{
			if (!isdefined (level.cover_trigger))
				break;
			wait (0.1);
		}
*/

		level.mg42_target = undefined;

		while (isdefined (level.cover_trigger))
			wait (0.2);

		level.mg42_target = level.player;
		println ("target is player");
	}
}

animatic31_think()
{
//	wait (5);
//	thread seek_destination();

	self endon ("quick duck");
	pre_seek_destination();


	/*
	self.goalradius = 70;
	node = getnode ("pick_direction","targetname");
	self setgoalnode (node);
	println ("WAITING FOR GOAL");
	self waittill ("goal");
	println ("REACHED GOAL");

	nodes = getnodearray ("animatic33_guys","targetname");
	for (i=0;i<nodes.size;i++)
	if (!isdefined(nodes[i].filled))
		nodes[i].filled = false;

	breaker = false;
	for (i=0;i<nodes.size;i++)
	if (!nodes[i].filled)
	{
		node = nodes[i];
		breaker = true;
		i = nodes.size + 1;
		println ("found an empty node");
	}

	if (breaker)
	{
		println ("going to empty node");
		level thread death_node (self, node);
//		self thread quick_duck_node (node);
		self setgoalnode (node);
		self thread arrive_at_wall (node);
		node.filled = true;
	}
	else
		seek_destination();
	*/
}

arrive_at_wall (node)
{
	self waittill ("goal");
//	if (distance (node.origin, self.origin) < 100)
//		self animcustom(animscripts\scripted\stalingrad_cover_crouch::main);
}




continue_check()
{
	self endon ("continue");
	level waittill ("mg42 stop");
	self notify ("continue");
}

trigger_check()
{
	self endon ("continue");
	while (1)
	{
		if (!isdefined (level.cover_trigger))
			break;
		wait (0.1);
	}
	self notify ("continue");
}


create_gunpass_tag ( gunpass, selftag, feed1, feed2, feed3)
{
//	tag = spawn ("script_origin",(0,0,0));
	tag = spawnstruct();
	tag.origin = gunpass gettagOrigin (selftag);
	tag.angles = gunpass gettagAngles (selftag);
	tag.tag = selftag;

	feeder = [];
	if (isdefined (feed1))
		feeder[feeder.size] = feed1;

	if (isdefined (feed2))
		feeder[feeder.size] = feed2;

	if (isdefined (feed3))
		feeder[feeder.size] = feed3;

	tag.feeder = feeder;

	return tag;
}

gunammo_idle(tag)
{
	self endon ("stop gunammo idle");

	guy[0] = self;
	while (1)
	{
		idleanim = anim_weight (guy, "idle");
		self.facial_animation = level.scr_face[self.animname]["idle"][idleanim];
		self animscripted("scriptedanimdone", tag.origin, tag.angles, level.scr_anim[self.animname]["idle"][idleanim]);
		self waittillmatch ("scriptedanimdone", "end");
	}
}

add_queue (num)
{
	if (!isdefined (level.queue))
		level.queue[0] = num;
	else
		level.queue[level.queue.size] = num;
}

remove_queue (num)
{
	if (!isdefined (level.queue))
		return;

	newqueue = [];
	for (i=0;i<level.queue.size;i++)
	{
		if (level.queue[i] == num)
			continue;

		newqueue[newqueue.size] = level.queue[i];
	}

	if (newqueue.size)
		level.queue = newqueue;
	else
		level.queue = undefined;
}

print_queue ()
{
	setcvar ("queue", "");

	while (1)
	{
		wait 1;
		if (getcvar ("queue") == "")
			continue;

		setcvar ("queue", "");

		if (!isdefined (level.queue))
		{
			println ("^ano queue");
			continue;
		}

		for (i=0;i<level.queue.size;i++)
			println ("^bQueue ", level.queue[i], " is active");
	}
}
move_to_new_tag (gunpass, newtag, oldtag)
{
	self.angleLerpRate = 150;
	self endon ("death");
	self notify ("stop gunpass idle");
	org = gunpass gettagorigin (newtag.tag);
	ang = gunpass gettagangles (newtag.tag);
	ang = vectornormalize ( newtag.origin - oldtag.origin );
	ang = vectorToAngles (ang);
	self.hasWeapon = true;
	uniquenum = randomint (5000);

	move_anim = randomint (level.scr_anim[self.animname]["move"].size);
	self.facial_animation = level.scr_face[self.animname]["move"][move_anim];

	if (newtag.tag == "tag_guy00")
	{
		self animscripted("scriptedanimdone", org, ang, level.scr_anim[self.animname]["move"][move_anim]);
		self waittillmatch ("scriptedanimdone", "end");

//		if (isdefined (self.anchor))
//		{
//			level.gunammo = "ammo";
//			level.flag["ready for ammo"] = true;
//			level notify ("ready for ammo");
//		}
		item = level.gunammo;

		if (level.gunammo == "gun")
			level.gunammo = "ammo";
		else
			level.gunammo = "gun";

		self thread gunammo_idle(newtag);
		self.facial_animation = level.scr_face[self.animname]["idle"][0];
		self animscripted("loop", org, ang, level.scr_anim[self.animname]["idle"][0]);
		node = getnode ("ammo","targetname");

		if (item == "gun")
		{
			if (!level.flag["ready for gun"])
				level waittill ("ready for gun");
			self notify ("stop gunammo idle");
			self.facial_animation = level.scr_face[self.animname]["getgun"];
			self animscripted("getstuff", node.origin, node.angles, level.scr_anim[self.animname]["getgun"]);
			self thread clear_tags (newtag,oldtag,1.0);
			thread ammo_ready();
		}
		else
		{
			if (!level.flag["ready for ammo"])
				level waittill ("ready for ammo");
			self notify ("stop gunammo idle");
			self.facial_animation = level.scr_face[self.animname]["getammo"];
			self animscripted("getstuff", node.origin, node.angles, level.scr_anim[self.animname]["getammo"]);
			self thread clear_tags (newtag,oldtag,0.0);
			thread gun_ready();
		}

		self waittillmatch ("getstuff", "end");
//		if (isdefined (self.anchor))
//		{
//			println ("SELF ANCHOR");
//			if (!level.flag["ready for ammo"])
//				level waittill ("ready for ammo");
//		}

		self thread make_ai_get_gunammo( node, item );
	}
	else
	{
		self animscripted("scriptedanimdone", org, ang, level.scr_anim[self.animname]["move"][move_anim]);
		self waittillmatch ("scriptedanimdone", "end");

		tag = newtag.tag;
//		newtag.user = self;
		oldtag.user = undefined;
		remove_queue (oldtag.tag);

		self.tag = newtag;

//		self waittillmatch ("scriptedanimdone", "end");
		self.in_use = undefined;
		self thread gunpass_idle();
//		wait (randomfloat (0.5));


//		if ((tag != "tag_guy01") && (tag != "tag_guy02"))
//			wait (randomfloat (0.5));
	}

}

ammo_ready()
{
	level notify ("stop ammo ready");
	level endon ("stop ammo ready");
	level.flag["ready for ammo"] = false;
	wait (2.5);
	level.flag["ready for ammo"] = true;
	level notify ("ready for ammo");
}

gun_ready()
{
	level notify ("stop gun ready");
	level endon ("stop gun ready");
	level.flag["ready for gun"] = false;
	wait (0.5);
	level.flag["ready for gun"] = true;
	level notify ("ready for gun");
}


clear_tags (newtag,oldtag,delay)
{
//	wait (delay);
	newtag.user = undefined;
	oldtag.user = undefined;
	self.in_use = undefined;
	remove_queue (newtag.tag);
	remove_queue (oldtag.tag);
}

reset_user (tag)
{
	tag.user = undefined;
}

feedline (tags)
{
	println ("{");
	println ("\"classname\" \"script_origin\"");
	println ("\"origin\" \"" + tags.origin[0] + " " + tags.origin[1] + " " + tags.origin[2] + "\"");
	println ("}");


	/*
	msg = tag.tag[7] + tag.tag[8];

	if (isdefined (tag.feeder))
		feeder = tag.feeder.size;
	else
		feeder = 0;

	while (1)
	{
		print3d ((tag.origin + (0, 0, 55)), msg, (0.48,9.4,0.76), 0.85);
		print3d ((tag.origin + (400, 0, 55)), feeder, (0.98,0.5,0.16), 0.85);
		for (i=0;i<tag.feeder.size;i++)
			line (tag.origin + (0,0,55), tag.feeder[i].origin + (0,0,25), (0.3, 0.8, 1), 0.9);
		wait (0.05);
	}
	*/

}


gunpass_idle()
{
	self endon ("stop gunpass idle");
	if (!isdefined (self.anchor))
		self animscripts\shared::putGunInHand ("none");

	guy[0] = self;
	while (1)
	{
		idleanim = anim_weight (guy, "idle");
		self.facial_animation = level.scr_face[self.animname]["idle"][idleanim];
		self animscripted("scriptedanimdone", self.tag.origin, self.tag.angles, level.scr_anim[self.animname]["idle"][idleanim]);
		self waittillmatch ("scriptedanimdone", "end");
	}
}


gunpass_setup(tags)
{
	for (i=0;i<tags.size;i++)
	{
		if ((!isdefined (tags[i].user)) && (tags[i].tag != "tag_guy00"))
		{
//			self teleport (tags[i].origin);
			self.origin = tags[i].origin;
			ai = getaiarray();
			spawn = self stalingradspawn("recruit_spawn");

			spawn.killable = false;
			spawn.on_move = true;

			tags[i].user = spawn;

			if (isdefined (spawn))
			{
				spawn.tag = tags[i];
				spawn.animname = "gunguy";
				self.spawn = spawn;
			}
			else
				println ("failed to spawn");

			return i;
		}
	}
}

line_spawner (tags)
{
	level endon ("breaking through explosion");
	spawner = getent ("line_spawner","targetname");
	while (1)
	{
		for (i=0;i<tags.size;i++)
		{
			if (!isdefined (tags[i].user))
			{
				spawner.count = 1;
				spawn = spawner stalingradspawn("recruit_spawn");
				if (isdefined (spawn))
					spawn thread line_think(tags[i]);
			}
		}

/*
		if (level.flag["animatic27"])
		{
			while (1)
			{
				ai = getaiarray ();
				if (ai.size < 24)
					break;
				else
					wait (1);
			}

			ai = undefined;
		}
*/

		wait (0.05);
	}
}

look_around()
{
	self endon ("got gun or ammo");
	lookats = getentarray ("line_lookat","targetname");
	while (1)
	{
		lookater = lookats[randomint(lookats.size)];
		self lookat (lookater);
		wait (randomfloat (3));
	}
}

line_think(tags)
{
//	self setgoalnode (getnode (self.target,"targetname"));
	self thread look_around();

	self.animname = "gunguy";
	self.walk_noncombatanim = level.scr_anim["ammoguy"]["walk"];
	self.walk_noncombatanim2 = level.scr_anim["ammoguy"]["walktwitch"];
	self.run_noncombatanim = level.scr_anim["ammoguy"]["walk"];

	self.hasWeapon = false;
	self.goalradius = 4;
	self.walkdist = 90;
	self.interval = 0;
	self.killable = false;
	self.on_move = true;
//	self waittill ("goal");

	tags.user = self;
	self.tag = tags;
	self.in_use = true;
	self setgoalpos (tags.origin);
	self waittill ("goal");
//	tags.user = undefined;
//	println (tags.tag);
//	self delete();
	self.in_use = undefined;
	self thread gunpass_idle();
}

line_hookup (trigger, tags)
{
	level endon ("got hookup");
	delete = true;
	for (i=0;i<tags.size;i++)
	{
		if (tags[i].tag != trigger.script_noteworthy)
			continue;

		delete = false;
		tag = tags[i];
		break;
	}

	if (delete)
	{
		trigger delete();
		return;
	}

	tags = undefined;
	trigger.origin = tag.origin;

	while (1)
	{
		trigger waittill ("trigger");
		while (level.player istouching (trigger))
		{
			if (!isdefined (tag.user))
				break;
			wait (0.05);
		}
		if (!isdefined (tag.user))
			break;
	}

	level notify ("got hookup");
	line_join_start (tag);
	triggers = getentarray ("line_join_hookup","targetname");
	for (i=0;i<triggers.size;i++)
		triggers[i] delete();
}

notsolid_brush()
{
	self notsolid();
}

solid_brush()
{
	self solid();
}

line_join_start (tags)
{
	maps\_utility::array_thread(getentarray ("playerblock","targetname"), ::notsolid_brush);

	anchor = spawn ("script_model",(0,0,0));
	anchor setmodel ("xmodel/character_soviet_overcoat");
	anchor.animname = "lineguy";
	anchor UseAnimTree(level.scr_animtree[anchor.animname]);
	anchor hide();
	anchor.anchor = true;

	tags.user = anchor;
	anchor.tag = tags;
	anchor.origin = tags.origin;
	anchor.angles = tags.angles;
	anchor.in_use = true;
	level.player mergeto (anchor, 1.5);
	anchor.in_use = undefined;
	anchor thread gunpass_idle();
}

mergeto (target, timer)
{
	merger = spawn ("script_model",(0,0,0));
	merger setmodel ("xmodel/character_soviet_overcoat");
	merger hide();

	merger.origin = level.player getorigin();
	level.player linkto (merger, "TAG_ORIGIN", (0,0,0),(0,0,0));
	merger moveto (target.origin, timer, timer * 0.25, timer * 0.25);
	wait (timer);

	level.player setorigin (target.origin);
	level.player linkto (target, "TAG_ORIGIN", (0,0,0),(0,0,0));
	merger delete();
}

when_player_finishes_with_tags()
{
	level waittill ("player is done with tags");
	level.player_tags = undefined;
}

set_player_tag ( tags )
{
	thread when_player_finishes_with_tags();
	level endon ("player is done with tags");

	while (1)
	{
		dist = 500000;

		if ((isdefined (level.player_tags)) && (isdefined (level.player_tags[0])) && (isdefined (level.player_tags[0].user)))
		{
			if (!isdefined (level.player_tags[0].user.anchor))
				maps\_utility::error ("tag " + level.player_tags[0].tag + " had user and was being used by player");
		}


		for (i=0;i<tags.size;i++)
		{
			if (isdefined (tags[i].user))
				continue;

			if (tags[i].tag == "tag_guy00")
				continue;

			if (tags[i].tag == "tag_guy13")
				continue;

			if (tags[i].tag == "tag_guy14")
				continue;

			if (tags[i].tag == "tag_guy22")
				continue;

			newdist = distance (level.player.origin, tags[i].origin);
			if (newdist > dist)
				continue;

			dist = newdist;
			level.player_tags[0] = tags[i];
		}
		if (isdefined (level.player_tags[0]))
			print3d ((level.player_tags[0].origin + (0, 0, 15)), "YO", (0.48,9.4,0.76), 0.85);

		wait (0.05);
	}
}


animatic16(trigger)
{
	level waittill ("boat ride finishing");
	gunpass = spawn ("script_model",(0,0,0));
	gunpass setmodel ("xmodel/gunpass_crowd");
	gunpass.origin = getnode ("ammo","targetname").origin;
	gunpass.angles = getnode ("ammo","targetname").angles;
	tags = [];

	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy00", "tag_guy01", "tag_guy03");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy01", "tag_guy04", "tag_guy05");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy04", "tag_guy08");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy08", "tag_guy13");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy13", "tag_guy20");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy05", "tag_guy09");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy09", "tag_guy14");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy14", "tag_guy21");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy03", "tag_guy06", "tag_guy07");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy06", "tag_guy10", "tag_guy11");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy10", "tag_guy15", "tag_guy16");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy15", "tag_guy22");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy07", "tag_guy12");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy11", "tag_guy17");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy16", "tag_guy23");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy12", "tag_guy18", "tag_guy19");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy17", "tag_guy24", "tag_guy25");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy19", "tag_guy27");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy18", "tag_guy26");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy20");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy21");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy22");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy23");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy24");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy25");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy26");
	tags[tags.size] = create_gunpass_tag (gunpass, "tag_guy27");
	ai = getspawnerarray ();
	total_gunguys = 0;
	spawner = [];
	for (i=0;i<ai.size;i++)
	{
		if ((isdefined (ai[i].script_noteworthy)) && (ai[i].script_noteworthy == "animatic16"))
		if (randomint (100) < 85)
		{
			spawner[spawner.size] = ai[i];
			total_gunguys++;
			if (total_gunguys >= 11)
				i = ai.size + 1;
		}
	}

	level.total_gun_and_ammo_guys = spawner.size +9999; // never stop giving guns and ammo

	introblock = getentarray ("introblock","targetname");
	for (i=0;i<introblock.size;i++)
		introblock[i] delete();

	for (i=0;i<spawner.size;i++)
	{
//		tags[spawner[i] gunpass_setup(tags)].user = spawner[i].spawn;
		spawner[i] gunpass_setup(tags);

/*
		for (p=0;p<introblock.size;p++)
		{
			if (!isdefined (introblock[p].used))
			{
				introblock[p].used = true;
				spawner[i].spawn.introblock = introblock[p];
				introblock[p].origin = spawner[i].spawn.origin;
				introblock[p] linkto (spawner[i].spawn);
				p = introblock.size + 1;
			}
		}
*/
	}

	guy = [];
	for (i=0;i<spawner.size;i++)
		guy[guy.size] = spawner[i].spawn;

//	for (i=0;i<introblock.size;i++)
//		if (!isdefined (introblock[i].used))
//			introblock[i] delete();

//	wait (3);

//	maps\_utility::array_levelthread(tags, ::tag_think, tags);

//	maps\_utility::array_thread(guy, ::gunpass_think);
	for (i=0;i<tags.size;i++)
	{
		if (isdefined (tags[i].feeder))
		{
			for (t=0;t<tags[i].feeder.size;t++)
			{
				for (p=0;p<tags.size;p++)
				{
					if (tags[i].feeder[t] == tags[p].tag)
					{
						tags[i].feeder[t] = tags[p];
						p = tags.size + 1;
					}
				}
			}
		}
	}

//	for (i=0;i<tags.size;i++)
//		if (isdefined (tags[i].feeder))
//			thread feedline (tags[i]);

	for (i=0;i<guy.size;i++)
		guy[i] thread gunpass_idle();

//	trigger waittill ("trigger");
//	trigger delete();

	level waittill ("boat explodes");

	maps\_utility::exploder (1);
//	earthquake(0.25, 5, level.player getorigin(), 850); // scale duration source radius
	earthquake(0.3, 3, level.player getorigin(), 850); // scale duration source radius
	//println ("SHELL SHOCKED");
//	level notify ("boat explodes");
	maps\_utility::array_thread(getentarray( "death", "targetname" ), ::death_think);
	level notify ("on docks");

	wait (0.4);

	level notify ("stopwatch");

	useable_tags = [];
	for (i=0;i<tags.size;i++)
	{
		if ((tags[i].tag == "tag_guy13") ||
			(tags[i].tag == "tag_guy14") ||
			(tags[i].tag == "tag_guy22"))
				useable_tags[useable_tags.size] = tags[i];
	}

	thread line_spawner (useable_tags);

	maps\_utility::array_levelthread(getentarray ("line_join_hookup","targetname"), ::line_hookup, tags);

	while (!level.flag["breaking through explosion"])
	{
		breaker = true;
		tags = maps\_utility::array_randomize(tags);
		for (i=0;i<tags.size;i++)
		{
			if (!isdefined (tags[i].feeder))
				continue;

			if (isdefined (tags[i].user))
			{
				breaker = false;
				continue;
			}

			if ((isdefined (level.player_tags)) && (tags[i] isPartofArray ( level.player_tags )))
				continue;

			tags[i].feeder = maps\_utility::array_randomize(tags[i].feeder);
			anchor_action = false;
			for (p=0;p<tags[i].feeder.size;p++)
			{
				if (!isdefined (tags[i].feeder[p].user))
					continue;

				if (!isdefined (tags[i].feeder[p].user.anchor))
					continue;

//				println ("tag is ", tags[i].feeder[p].tag);
				breaker = false;
				if (isdefined (tags[i].feeder[p].user.in_use))
					continue;

//				println ("Not in use");

				if ((tags[i].tag == "tag_guy00") && (level.gunammo == "gun"))
					continue;

//				println ("tag isnt 00 or level.gunammo isnt gun");
				anchor_action = true;
				add_queue (tags[i].feeder[p].tag);

				tags[i].user = tags[i].feeder[p].user;
				tags[i].feeder[p].user.in_use = true;

				tags[i].feeder[p].user thread move_to_new_tag (gunpass, tags[i], tags[i].feeder[p]);

				wait (randomfloat (0.3));
				break;
//				p = tags[i].feeder.size + 1;
			}

			if (anchor_action)
				continue;

			for (p=0;p<tags[i].feeder.size;p++)
			{
				if (!isdefined (tags[i].feeder[p].user))
					continue;

				breaker = false;
				if (isdefined (tags[i].feeder[p].user.in_use))
					continue;

				if ((isdefined (tags[i].feeder[p].user.anchor)) &&
					(tags[i].tag == "tag_guy00") && (level.gunammo == "gun"))
					continue;

				add_queue (tags[i].feeder[p].tag);

				tags[i].user = tags[i].feeder[p].user;
				tags[i].feeder[p].user.in_use = true;

				tags[i].feeder[p].user thread move_to_new_tag (gunpass, tags[i], tags[i].feeder[p]);

//				p = tags[i].feeder.size + 1;
				wait (randomfloat (0.3));
				break;
			}
		}

//		if (breaker)
//			break;
//		wait (randomfloat (1.5));
		wait (0.1);
	}

	for (i=0;i<tags.size;i++)
	{
		if (isdefined (tags[i].user))
			tags[i].user delete();
	}
}

isPartofArray ( array )
{
	for (i=0;i<array.size;i++)
		if (self == array[i])
			return true;

	return false;
}

trenchrun_trigger ( trigger )
{
	trigger waittill ("trigger");
	flag_set ("go trenchguys go!");
	trigger delete();
}

trenchrun ( trigger )
{
	level.flag["go trenchguys go!"] = false;
	spawners = getentarray(trigger.target,"targetname");
	trigger.target = "null";
	level thread trenchrun_trigger ( trigger );
	level waittill ("breaking through explosion");
	
	maps\_utility::array_thread(spawners, ::trenchrun_guys);
	flag_wait ("go trenchguys go!");
	wait 6;
	maps\_utility::exploder (3);
	wait (0.25);
	level notify ("trench guys die");
}

trenchrun_guys ()
{
	node = getnode (self.target,"targetname");
	spawn = self stalingradspawn();
	if (maps\_utility::spawn_failed(spawn))
	{
		maps\_utility::Error ("trenchrun guy failed to spawn");
		return;
	}

	spawn endon ("death");
	spawn hide();
//	wait (0.5);
	spawn allowedstances ("prone");
	wait (0.1);
	spawn show();
	spawn setgoalpos (spawn.origin);
	level thread trenchrun_guy_think ( spawn, node );
	level thread trenchrun_guy_forcego ( spawn );
	flag_wait ("go trenchguys go!");
	spawn notify ("go spawn go");
}

trenchrun_guy_forcego ( spawn )
{
	spawn endon ("death");
	wait (8) + randomint (4);
	spawn notify ("go spawn go");
}

trenchrun_guy_think ( spawn, node )
{
	spawn endon ("death");
	spawn waittill ("go spawn go");
	wait (randomfloat (2));
	spawn allowedstances ("crouch");

	spawn setgoalnode (node);
	spawn.goalradius = 4;
	level waittill ("trench guys die");
	wait (randomfloat (0.5));
	spawn coolKill();
	if (randomint (100) > 75)
		spawn.deathAnim = getExplodeDeath("generic");

	if (randomint (100) > 50)
		spawn.deathAnim = %scripted_death_rolldownhill;

}

coolKillPlayer (org)
{
//	return;
	self endon ("death");
	dmg = level.player.health / 5;
	if (dmg < 50)
		dmg = 50;
		
	while (1)
	{
		self doDamage ( dmg, org );
		wait (0.05);
	}
//	self doDamage ( self.health - 1, org );
//	self doDamage ( self.health + 50, org );
//	magicbullet ("mp40", org, level.player.origin);
}

coolKill ()
{
	self doDamage ( self.health + 50, (0,0,0) );
}

bloody_death_waittill ()
{
	self waittill ("death");
	if (!isdefined (self))
		return;

	self bloody_death();
}

bloody_death()
{

	tag_array = level.scr_dyingguy["tag"];
	tag_array = maps\_utility::array_randomize(tag_array);
	tag_index = 0;
	waiter = false;

	for (i=0;i<3 + randomint (5);i++)
	{
		playfxOnTag ( level._effect [random (level.scr_dyingguy["effect"])], self, level.scr_dyingguy["tag"][tag_index] );
		thread playSoundOnTag(random (level.scr_dyingguy["sound"]), level.scr_dyingguy["tag"][tag_index]);

		tag_index++;
		if (tag_index >= tag_array.size)
		{
			tag_array = maps\_utility::array_randomize(tag_array);
			tag_index = 0;
		}

		if (waiter)
		{
			wait (0.05);
			waiter = false;
		}
		else
			waiter = true;
//		wait (randomfloat (0.3));
	}
}

shock_commissar()
{
	while (1)
	{
		spawn = self stalingradspawn();
		if (isdefined (spawn))
			break;
	}

	spawn.animname = "commissar4";
	spawn commissar_init();
	node = spawnstruct();
	node.origin = spawn.origin;
	node.angles = spawn.angles;
	guy[0] = spawn;
	self thread anim_loop(guy, "idle", undefined, "stop anim", node);
	level waittill ("breaking through");
	self notify ("stop anim");
	spawn playsound (level.scrsound["commissar4"]["breaking through"]);
	node = getnode (spawn.target,"targetname");
	spawn setgoalnode (node);
//	spawn waittill ("goal");
	level waittill ("breaking through explosion");
	node = getnode (node.target,"targetname");
	println ("^cgettin knock down");
	animation = spawn getKnockDown(spawn.origin + (0,100,0));
	ang = vectornormalize ( node.origin - spawn.origin );
	ang = vectorToAngles (ang);
	spawn animscripted("scriptedanimdone", spawn.origin, ang, animation);
	spawn animscripts\shared::DoNoteTracks("scriptedanimdone");
	spawn allowedstances ("prone");
	spawn waittillmatch ("scriptedanimdone", "end");
//	self animscripted("scriptedanimdone", self.origin, ang, level.scr_anim["generic"]["getup"]);
//	self waittillmatch ("scriptedanimdone", "end");

	wait (1);
	anim_reach(guy, "shellshock");
	spawn allowedstances ("crouch","stand");

	spawn.desired_anim_pose = "crouch";
	spawn animscripts\utility::UpdateAnimPose();

	anim_single(guy, "shellshock");
	spawn setgoalnode (node);
	spawn waittill ("goal");
	spawn thread commissar_think (node);
}

commissar_init()
{
	self.walkdist = 16;
	self.health = 5000;
	self.goalradius = 4;
	self.suppressionwait = 0;
	self character\_utility::new();
	self [[level.scr_character[self.animname]]]();
	self.team = "allies";
}

commissar_spawner( spawner )
{
	while (1)
	{
		spawn = spawner stalingradspawn();
		if (isdefined (spawn))
			break;
		else
			wait (1);
	}

	spawn.animname = "commissar4";
	spawn commissar_init();
	spawn setgoalnode (getnode (spawn.target,"targetname"));
	spawn thread commissar_think (getnode (spawn.target,"targetname"));
}

commissar_player( spawner )
{
	while (1)
	{
		spawn = spawner stalingradspawn();
		if (isdefined (spawn))
			break;
		else
			wait (1);
	}

	spawn.animname = "commissar4";
	spawn commissar_init();
	node = getnode (spawn.target,"targetname");
	spawn setgoalnode (node);

	spawn.threatbias = -500000;
	org = spawn ("script_origin",(0,0,0));
	org.origin = node.origin;
	guy[0] = spawn;
//	spawn linkto (org);
	spawn.team = "allies";
	spawn.ignoreme = true;
	while (1)
	{
		spawn thread kill_player("stop anim");
		spawn thread anim_loop(guy, "idle", undefined, "stop anim", node);
		level waittill ("stop killing player");
	}
}

kill_player(msg)
{
	trigger = getent ("commissar_player_start", "targetname");
	trigger waittill ("trigger");
	println ("TRIGGERED");
	self.team = "neutral";
	self notify (msg);
	self animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
	self.customtarget = (level.player);
	while (level.player istouching (trigger))
		wait (1);

	self.team = "allies";
	self notify ("end_sequence");
	level notify ("stop killing player");
}

commissar_think ( node )
{
	level endon ("stop all MG42s");
	level endon ("global target");
	self thread kill_on_msg( "stop all MG42s" );
	self.targetname = "commissar think guy";
	self.angleLerpRate = 150;
	self.threatbias = -50000;
	self.ignoreme = true;

	org = spawn ("script_origin",(0,0,0));
	org.origin = node.origin;
	self.team = "allies";
	thread commissar_shoot_plane();

	if (!isdefined (node.script_linked))
		println ("node at origin ", node.origin, " has no script_linked");

	thread commissar_shoot_recruits();
}

commissar_shoot_recruits()
{
	level endon ("stop all MG42s");
	level endon ("global target");
	guy[0] = self;
	while (1)
	{
		self thread anim_loop(guy, "idle", undefined, "yell at custom target now", node);
		self waittill ("yell at custom target now");
		guy[0] = self;
		self lookat (self.customTarget);
		anim_single (guy, "fullbody41");

		if (isdefined (self.customTarget))
		{
			thread kill_enemy (self.customTarget);
			self waittill ("move on");
		}
		self.team = "allies";
		self notify ("end_sequence");

		wait (0.5);
		self lookat (self, 0);
	}
}

commissar_shoot_plane()
{
	level waittill ("global target");

	self.team = "allies";
	self notify ("yell at custom target now");
	self notify ("end_sequence");
	self notify ("move on");
	self lookat (self, 0);
//	self lookat (level.global_target);
	self animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
	self.customtarget = (level.global_target);
	wait (9);
	self notify ("end_sequence");
	thread commissar_shoot_recruits();
}


enemy_death (enemy)
{
	self endon ("move on");
	enemy waittill ("death");
	wait (0.4 + randomfloat(0.4));
	self notify ("move on");
}

kill_enemy (enemy)
{
	self endon ("move on");
	self thread enemy_death (enemy);

//	if (isdefined (level.global_target))
//		enemy = level.global_target;
//	self lookat (self.customTarget);
//	wait (0.5);
	self.team = "neutral";
//	self.customAttackSpeed = "hide";
	self waittill ("shoot custom target now");
	self animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
	self.customAttackSpeed = "fast";
//	self.customtarget = (enemy);

	wait (5 + randomfloat(4));
	self notify ("move on");
}

line_time (ent, delay)
{
	ent endon ("death");
	if (isdefined (delay))
		timer = gettime() + delay;
	else
		timer = gettime() + 2000;

	while (gettime() < timer)
	{
		line (self.origin, ent.origin, (0,0.5,1), 0.5);
		wait (0.05);
	}
}

hill_planes()
{
	level endon ("stop plane attacks now");
	while (1)
	{
		level notify ("start planes 3");
//		wait (5);
		wait (9);
		level notify ("start planes 4");
//		wait (14);
		wait (20);
	}
}

death_delete(node)
{
	guy[0] = self;
	self thread anim_loop(guy, "deathidle", undefined, "stop anim", node);
	wait (10);
	self notify ("stop anim");
	self delete();
}


flag_leader ( spawner )
{
	spawn = spawner stalingradspawn();
	spawn.goalradius = 64;
	spawn.suppressionwait = 0;
	spawn.maxsightdistsqrd = 0;
	spawn.interval = 0;
	spawn.walkdist = 0;
	spawn.health = 10000;
	spawn.animname = "flagrun";
	spawn.hasWeapon = false;
	spawn.team = "allies";
	spawn.walk_noncombatanim = level.scr_anim[spawn.animname]["idle"][0];
	spawn.walk_noncombatanim2 = level.scr_anim[spawn.animname]["idle"][0];
	spawn.run_noncombatanim = level.scr_anim[spawn.animname]["idle"][0];
	spawn attach ("xmodel/stalingrad_flag", "tag_weapon_Right");

	destination = spawn;

	while (1)
	{
		destination = getent (destination.target,"targetname");
		if (!isdefined (destination.target))
			break;

		spawn setgoalpos (destination.origin);
		spawn waittill ("goal");
	}

	org = getStartOrigin (destination.origin, destination.angles, level.scr_anim["flagrun"]["death"]);
	angles = getStartAngles (destination.origin, destination.angles, level.scr_anim["flagrun"]["death"]);

	spawn setgoalpos (org);
	spawn.goalradius = 4;
	spawn waittill ("goal");

//	spawn.deathAnim = level.scr_anim[spawn.animname]["death"];
//	spawn DoDamage ( spawn.health + 50, (0,0,0) );
//	spawn coolKill();
//	destination thread current_target (2000);
	spawn animscripted("scriptedanimdone", destination.origin, destination.angles, level.scr_anim["flagrun"]["death"]);
	spawn waittillmatch ("scriptedanimdone","end");
//	spawn thread death_delete(destination);

	spawn detach ("xmodel/stalingrad_flag", "tag_weapon_right");
	flag = spawn ("script_model",(0,3,1));
	flag.origin = spawn gettagorigin ("tag_weapon_right");
	flag.angles = spawn gettagangles ("tag_weapon_right");
	flag setmodel ("xmodel/stalingrad_flag");

//	flag linkto (spawn,"tag_weapon_right");
	spawn delete();

	level waittill ("flag pickup guy");

	spawn = getent ("flag_man2","targetname") stalingradspawn();
//	spawn allowedStances ("crouch");
	spawn.playPainAnim = false;
	spawn.goalradius = 64;
	spawn.dontavoidplayer = true;
	spawn.suppressionwait = 0;
	spawn.maxsightdistsqrd = 0;
	spawn.interval = 0;
	spawn.walkdist = 0;
	spawn.health = 15000;
	spawn.animname = "flagrun";
	spawn.hasWeapon = false;
	spawn.team = "allies";

	destination = getent (spawn.target,"targetname");
	while (1)
	{
		spawn setgoalpos (destination.origin);
		spawn waittill ("goal");
		if (!isdefined (destination.target))
			break;

		destination = getent (destination.target,"targetname");
	}
//	destination thread current_target (2000);
	org = getStartOrigin (destination.origin, destination.angles, level.scr_anim["flagrun"]["pickup"]);
	angles = getStartAngles (destination.origin, destination.angles, level.scr_anim["flagrun"]["pickup"]);
	spawn setgoalpos (org);
	spawn.goalradius = 4;
	spawn waittill ("goal");
	spawn.goalradius = 64;

	spawn animscripted("scriptedanimdone", destination.origin, destination.angles, level.scr_anim["flagrun"]["pickup"]);
	spawn waittill ("scriptedanimdone");
	flag delete();
	spawn attach ("xmodel/stalingrad_flag", "tag_weapon_Right");
	spawn waittillmatch ("scriptedanimdone", "end");
	spawn.walk_noncombatanim = level.scr_anim[spawn.animname]["idle"][0];
	spawn.walk_noncombatanim2 = level.scr_anim[spawn.animname]["idle"][0];
	spawn.run_noncombatanim = level.scr_anim[spawn.animname]["idle"][0];
	node = getnode ("flag_destination", "targetname");
	spawn setgoalnode (node);
	spawn.goalradius = 4;
	guy[0] = spawn;
	anim_reach(guy, "trans", node);
	anim_single(guy, "trans", undefined, node);
	level thread anim_loop(guy, "crouchidle", undefined, "go go go", node);
	flag_wait ("go go go");
	spawn notify ("end_sequence");

	node = getnode (node.target,"targetname");
	spawn setgoalnode (node);
	spawn.goalradius = 80;
	spawn waittill ("goal");
	spawn.deathAnim = level.scr_anim[spawn.animname]["death"];
	spawn coolKill();

/*
	flagguy = spawn ("script_model",(0,0,3));
	flagguy.origin = spawn.origin;
	flagguy.angles = spawn.angles;
	flagguy setmodel ("xmodel/character_soviet_overcoat");
	flagguy UseAnimTree(level.scr_animtree["flagwaver"]);
	flag linkto (flagguy,"tag_weapon_right");
	flagguy animscripted("scriptedanimdone", spawn.origin, spawn.angles, level.scr_anim["flagwaver"]["death"]);
*/
}

planeAttackTwo ( trigger )
{
	trigger waittill ("trigger");
	flag_set("final plane attack");
}

animatic27(trigger)
{
	trigger waittill ("trigger");
	thread sniper_think(getent ("sniper spawner","targetname"));

	level.flag["animatic27"] = true;
	level notify ("start mortars");
	level.flag["boats should unload"] = true;
	level notify ("boats should unload");
	maps\_utility::array_thread(getentarray( "mg42guy", "targetname" ), ::mg42guy);
	maps\_utility::array_levelthread(getentarray( "scatter", "targetname" ), ::trigger_scatter);
	level.shellshock_safetime = gettime() + 50000;
	thread trenchrun (getent ("trench","targetname"));
	thread flag_leader (getent ("flag_man","targetname"));
	thread planeAttackTwo (getent("plane_attack_two", "targetname"));
	maps\_utility::array_levelthread(getentarray("mg42 death trigger", "targetname"), ::mg42DeathTrigger);

	maps\_utility::array_levelthread(getentarray ("wounded at breakthrough","script_noteworthy"), ::wounded_guy, "wounded at breakthrough");

	trigger delete();
	level notify ("ammo");
	objective_state(1, "done");
	objective_add(2, "active", &"STALINGRAD_OBJ2", (getent ("sniper","targetname").origin));
	objective_current(2);

	thread plane_attack(getent ("plane_attack","targetname"));
//	maps\_utility::array_thread(getnodearray( "deadguy", "targetname" ), ::scriptguy_think);
	thread scriptguy_think (getnode( "deadguy", "targetname" ));

	// Start the 3 guys being carried thing

	maps\_utility::array_levelthread(getentarray( "commissar_spawner", "targetname" ), ::commissar_spawner);
	level thread commissar_player (getent ("commissar_player","targetname"));
	getent ("shellshockedcommissar","targetname") thread shock_commissar();
	thread fodder_spawner();
	thread recruit_spawner("first_spawner", "spotter ready");
	thread recruit_spawner("second_spawner", "sniper talk");
	thread retreater();

	create_recruits ("animatic27");
	guy = get_recruits (guy, "animatic27");
	if (isdefined (guy))
		maps\_utility::array_thread(guy, ::seek_destination);
	println ("*6");
	wait (2);
	maps\_utility::autosave(2);

	trigger = getent ("breaking_through","targetname");
	trigger waittill ("trigger");
	trigger delete();
	thread hill_planes();

	guy = undefined;

	create_recruits ("hill_explosion_guys");
	guy = get_recruits (guy, "hill_explosion_guys");
	if (isdefined (guy))
		maps\_utility::array_thread(guy, ::seek_destination);


	level notify ("breaking through");
	// Make the 3 wounded guys go
//	getent ("wounded at breakthrough","targetname") notify ("stop idle");

	level.shellshock_safetime = 0;

	trigger = getent ("breaking_through_explosion","targetname");
	trigger waittill ("trigger");
	trigger delete();

//	wait (2);
	thread landsplash();

	org = getent ("explode_crates_shellshock","targetname");
	org playsound ("mortar_incoming1_new", "sounddone");
	wait (1);
//	org waittill ("sounddone");
	playfx ( level.mortar[randomint (level.mortar.size)], org.origin );
	org playsound ("mortar_explosion");
//	earthquake(1.5, 1, getent ("explode_crates_shellshock","targetname").origin, 2450); // scale duration source radius

	earthquake(0.25, 1, level.player.origin, 2450); // scale duration source radius
	thread exploder (2);
//	wait (1);
	level.wallguy_num = 0;
	maps\_utility::array_thread(getnodearray( "wall_guy", "targetname" ), ::wall_guy);
	level notify ("breaking through explosion");
	println ("drag the guy!");
	level thread dragger(getent ("drag_guy","targetname"));
	level thread dragger_trigger(getent ("drag_trigger","targetname"));

	kill_cover_trigger ("explode_crates");
	level notify ("no more guns and ammo");
	level.flag["breaking through explosion"] = true;
}

#using_animtree("stalingrad_wallguys");
wall_guy()
{
	spawn = spawn ("script_model",(0,0,0));
	level thread add_totalguys(spawn);
	spawn.origin = self.origin;
	spawn.angles = self.angles;
	spawn.animname = "wallguy";

//	spawn UseAnimTree(level.scr_animtree[spawn.animname]);
//	spawn UseAnimTree(level.scr_animtree[spawn.animname]);
	spawn UseAnimTree(#animtree);
	if (isdefined (level.scr_character[spawn.animname]))
		spawn [[level.scr_character[spawn.animname]]]();
	else
		spawn setmodel ("xmodel/character_soviet_overcoat");

	level.wallguy_num++;
	guy[0] = spawn;

	if (level.wallguy_num == 1)
		thread anim_loop(guy, "idle", undefined, undefined, self);
	else
	if (level.wallguy_num == 2)
	{
		while (1)
		{
			thread anim_loop(guy, "idleA", undefined, "stop the anim", self);
			wait (randomfloat (8));
			self notify ("stop the anim");

			anim_single(guy, "AtoB", undefined, self);
			thread anim_loop(guy, "idleB", undefined, "stop the anim", self);
			wait (randomfloat (5));
			self notify ("stop the anim");
			anim_single(guy, "BtoA", undefined, self);
		}
	}
	else
	if (level.wallguy_num == 3)
	{
		for (;;)
		{
			playbackRate = 0.9 + randomfloat(0.2);
			spawn setFlaggedAnimKnobAllRestart("coweranim", %hideLowWall_fetal, %root, 1, .1, playbackRate);
			animscripts\shared::DoNoteTracks("coweranim");
		}
	}
	else
	if (level.wallguy_num == 4)
	{
		for (;;)
		{
			playbackRate = 0.9 + randomfloat(0.2);
			if (!isDefined(scaredSet))
			{
				if (randomint(100)<50)
					scaredSet = "A";
				else
					scaredSet = "B";
			}
			if (scaredSet=="A")
			{
				rand = randomint(100);
				if (rand<60)
					spawn setFlaggedAnimKnobAllRestart("coweranim", %hideLowWall_scaredA, %root, 1, .1, playbackRate);
				else if (rand<90)
					spawn setFlaggedAnimKnobAllRestart("coweranim", %hideLowWall_scaredA_twitch, %root, 1, .1, playbackRate);
				else
				{
					spawn setFlaggedAnimKnobAllRestart("coweranim", %hideLowWall_scaredAtoB, %root, 1, .1, playbackRate);
					scaredSet = "B";
				}
				animscripts\shared::DoNoteTracks("coweranim");
			}
			else
			{
				rand = randomint(100);
				if (rand<85)
					spawn setFlaggedAnimKnobAllRestart("coweranim", %hideLowWall_scaredB, %root, 1, .1, playbackRate);
				else
				{
					spawn setFlaggedAnimKnobAllRestart("coweranim", %hideLowWall_scaredBtoA, %root, 1, .1, playbackRate);
					scaredSet = "A";
				}
				animscripts\shared::DoNoteTracks("coweranim");
			}
		}
	}
	else
	if (level.wallguy_num == 5)
	{
		for (;;)
		{
			playbackRate = 0.9 + randomfloat(0.2);
			rand = randomint(100);
			if (rand<50)
				spawn setFlaggedAnimKnobAllRestart("coweranim", %hidelowwall_scaredc_idle, %root, 1, .1, playbackRate);
			else if (rand<75)
				spawn setFlaggedAnimKnobAllRestart("coweranim", %hidelowwall_scaredc_twitch, %root, 1, .1, playbackRate);
			else
				spawn setFlaggedAnimKnobAllRestart("coweranim", %hidelowwall_scaredc_look, %root, 1, .1, playbackRate);
			animscripts\shared::DoNoteTracks("coweranim");
		}
	}
	else
	{
		for (;;)
		{
			playbackRate = 0.9 + randomfloat(0.2);
			rand = randomint(100);
			if (rand<50)
				spawn setFlaggedAnimKnobAllRestart("coweranim", %hidelowwall_scaredd_idle, %root, 1, .1, playbackRate);
			else if (rand<75)
				spawn setFlaggedAnimKnobAllRestart("coweranim", %hidelowwall_scaredd_twitch, %root, 1, .1, playbackRate);
			else
				spawn setFlaggedAnimKnobAllRestart("coweranim", %hidelowwall_scaredd_look, %root, 1, .1, playbackRate);
			animscripts\shared::DoNoteTracks("coweranim");
		}
	}

}

wallguys_shoot_plane ()
{
	self.suppressionwait = 0;
	self allowedstances ("crouch");
	self setmodel ("xmodel/character_soviet_overcoat");
	self animcustom (animscripts\scripted\stalingrad_cover_crouch::main);

	level waittill ("global target");
	self animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
	self.customtarget = (level.global_target);
}

exploder (num)
{
	maps\_utility::exploder (num);
	org = getent ("explode_crates_shellshock","targetname");
	mortar_hit (org.origin);
//	earthquake(1.5, 3, .origin, 2450); // scale duration source radius
//	model = spawn ("script_model",(0,0,0));
//	model setmodel ("xmodel/temp");
//	model.origin = org.origin;
	dist = distance (level.player.origin, org.origin);
	maxdist = 320;
	if (dist > maxdist)
		dist = maxdist;

	dist = maxdist - dist;
	if (dist < 0)
		dist = 0;
		

//	dist = dist * 20 / maxdist;
//	dist = dist * 50 / maxdist;
	/*
	dist		0
	maxdist		25
	*/
	println ("^2dist is ", dist);
	dist = (dist * 35) / maxdist;
	println ("^3dist is ", dist);

	if (dist > 25)
		dist = 25;

//	dist = 34;
	level.shellshock_safetime = gettime() + (dist * 1000);
	level.shellshock_safetime -= 2500;
	level notify ("player got shell shocked");

//	level.radio_captain_time = gettime() + 31000;
//	level.shellshock_safetime = gettime() + 25600; // for e3

//	if (dist < 5)
//		return;

//	wait (1.1); // was 1.2
    //	level.player shellshock("default", dist);
    if (dist > 7)
    {
		maps\_shellshock::main (dist);
		musicstop(3);
	}
	// level.player shellshock("default", 27);
//	println ("SHELL SHOCKED for 37 seconds!");
}

die_soon()
{
	self endon ("death");
	wait (randomfloat (4));
	self coolKill();
}

getup ( animation, org )
{
	ang = vectornormalize ( org - self.origin );
	ang = vectorToAngles (ang);

	self.getting_up = true;
	self endon ("death");
//	self allowedstances ("prone");
	self animscripted("scriptedanimdone", self.origin, ang, animation);
	self animscripts\shared::DoNoteTracks("scriptedanimdone");
	self waittillmatch ("scriptedanimdone","end");
	wait (randomfloat (1));
	self animscripted("scriptedanimdone", self.origin, self.angles, level.scr_anim[self.animname]["getup"]);
	self animscripts\shared::DoNoteTracks("scriptedanimdone");
//	self allowedStances ("crouch");
//	self animscripts\shared::DoNoteTracks("scriptedanimdone");
	self waittillmatch ("scriptedanimdone","end");
	self.getting_up = undefined;
}

/*
	    90
   135      45
 180	       0
-180	       0
  -135     -45
       -90

*/

getExplodeDeath (msg, org, dist)
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

getKnockDown(org)
{
	msg = "generic";
	ang = vectornormalize ( self.origin - org );
	ang = vectorToAngles (ang);
	ang = ang[1];
	ang -= self.angles[1];
	if (ang <= -180)
		ang += 360;
	else
	if (ang > 180)
		ang -= 360;

//	println ("angles are ", ang);

	if ((ang >= 45) && (ang <= 135))
		return level.scr_anim[msg]["knockdown forward"];
	if ((ang >= -135) && (ang <= -45))
		return level.scr_anim[msg]["knockdown back"];
	if ((ang <= 45) && (ang >= -45))
		return level.scr_anim[msg]["knockdown right"];

	return level.scr_anim[msg]["knockdown left"];
}


mortar_hit (org)
{
	earthquake(0.3, 3, org, 850); // scale duration source radius
	do_mortar_deaths ("recruit_spawn", org);
	do_mortar_deaths ("wave_spawn", org);
	radiusDamage (org, 150, 150, 0);
}

do_mortar_deaths (msg, org)
{
	ai = getentarray (msg, "targetname");
	for (i=0;i<ai.size;i++)
	{
		dist = distance (ai[i].origin, org);
		if (dist < 190)
		{
			ai[i].allowDeath = true;
			ai[i].deathAnim = ai[i] getExplodeDeath("generic", org, dist);
			ai[i] DoDamage ( ai[i].health + 50, (0,0,0) );
			continue;
		}

		if (isdefined (ai[i].getting_up))
			continue;

		if (dist < 300)
			ai[i] thread getup(ai[i] getKnockDown(org), org);
	}
}

incoming_landsound(splash, soundnum)
{
	splash playsound ("mortar_incoming", "sounddone", true);
	splash waittill ("sounddone");
	playfx ( level.mortar[randomint (level.mortar.size)], splash.origin );
	splash playsound ("mortar_explosion");
	mortar_hit (splash.origin);
	if (isdefined (splash.script_noteworthy))
		maps\_utility::exploder (splash.script_noteworthy);
	splash delete();
}


landsplash()
{
	splash = getent ("landsplash","targetname");
	waits[0] = 0.5;
	waits[1] = 0.5;
	waits[2] = 0.2;
	waits[3] = 0.2;
	waits[4] = 0.4; // 3.3

	soundnum[0] = 0;
	soundnum[1] = 1;
	soundnum[2] = 2;
	soundnum[3] = 1;
	soundnum[4] = 2;

//	println ("^c prepping");
	i = 0;
	while (1)
	{
		if (!isdefined (splash.target))
			break;

		wait (waits[i]);
		i++;

		thread incoming_landsound(splash, soundnum[i]);
		splash = getent (splash.target,"targetname");
	}
/*
	splash playsound ("mortar_incoming1", "sounddone");
//	println ("^c waiting");
	splash waittill ("sounddone");
//	println ("^c done!");

	playfx ( level.mortar[randomint (level.mortar.size)], splash.origin );
	playfx ( level._effect["barge_explosion"], splash.origin );

	splash playsound ("mortar_explosion");
	if (isdefined (splash.script_noteworthy))
		maps\_utility::exploder (splash.script_noteworthy);
	level.shell_shocked_org = splash.origin;
	splash delete();

	level notify ("shell shock 2");
*/
}

animatic21(trigger)
{
	trigger waittill ("trigger");
//	trigger thread explode_crates();
//	trigger delete(); // used for ambient
//	level notify ("mg42 attack");

//	thread landsplash();
}



get_recruit_spawner (animatic)
{
	spawner = [];
	ai = getspawnerarray();
	for (i=0;i<ai.size;i++)
	if ((isdefined (ai[i].script_noteworthy)) && (ai[i].script_noteworthy == animatic))
		spawner[spawner.size] = ai[i];

	return spawner;
}

create_recruits (animatic)
{
	ai = getspawnerarray();
	for (i=0;i<ai.size;i++)
	if ((isdefined (ai[i].script_noteworthy)) && (ai[i].script_noteworthy == animatic))
	{
		ai[i].count = 1;
//		if (isdefined (ai[i].script_fixbasepose))
//			ai[i] maps\_spawner::fixBasePose();
		ai[i] stalingradspawn("recruit_spawn");
	}
}

get_recruits (guy, animatic)
{
	guy = [];
	ai = getentarray ("recruit_spawn","targetname");
	for (i=0;i<ai.size;i++)
	if ((isdefined (ai[i].script_noteworthy)) && (ai[i].script_noteworthy == animatic))
		guy[guy.size] = ai[i];
	ai = undefined;

	return guy;
}


toucher_think()
{
	while (1)
	{
		self waittill ("trigger");
		level.toucher = self;
		while (level.player istouching (self))
			wait (0.5);
		level.toucher = undefined;
	}
}

plane_attack(trigger)
{
	maps\_utility::array_levelthread(getentarray( "safe place", "targetname" ), ::safePlacePlayerSafe);

	mg42guys = getentarray ("endmg42guy","targetname");
	for (i=0;i<mg42guys.size;i++)
	{
		if (mg42guys[i].script_noteworthy == "leftguy")
			mg42guys[i] thread mg42_leftguys(-2225, -7500, "mg42_suicidezone2", 0);
		else
		if (mg42guys[i].script_noteworthy == "leftguy2")
			mg42guys[i] thread mg42_leftguys(-2225, -7500, "mg42_suicidezone2", 0.7);
		else
		if (mg42guys[i].script_noteworthy == "rightguy")
			mg42guys[i] thread mg42_leftguys(-1250, -2000, "mg42_suicidezone1", 0);
		else
		if (mg42guys[i].script_noteworthy == "rightguy2")
			mg42guys[i] thread mg42_leftguys(-1250, -2000, "mg42_suicidezone1", 0.7);
		else
		if (mg42guys[i].script_noteworthy == "endguy")
			mg42guys[i] thread mg42_leftguys(-3710, -7500, "mg42_suicidezone3");
	}

	level.rightsquib = -1250;
	level.leftsquib = -2300;
	level.endsquib = -3710;

	thread squib_attack (level.rightsquib, "right", 4.7); // 4.2
	thread squib_attack (level.leftsquib, "left", 3.5);
	thread squib_attack (level.endsquib, "end", 1);
//	thread squib_attack (-1250, "right", 3.5);
//	thread squib_attack (-2300, "left", 2.5);
//	thread squib_attack (-3710, "end", 1);
}

waitUntilPlayerTouchesSafeTrigger (noteworthy)
{
	safeTrigger = matchTargetnameScriptnoteworthy ("safe place",noteworthy);
	safeTrigger waittill ("trigger");
}

matchTargetnameScriptnoteworthy (msg1, msg2)
{
	matches = getentarray (msg1,"targetname");
	for (i=0;i<matches.size;i++)
	{
		if (matches[i].script_noteworthy == msg2)
		{
			match = matches[i];
			break;
		}
	}
	return match;
}

flagCheck (name)
{
	level.flag[name] = false;
	level waittill (name);
	println ("^4 flag killed: ", name);
	level.flag[name] = true;
}

// mg42 death trigger
mg42DeathTrigger ( trigger )
{
	
	trigger waittill ("trigger");
	
	allowed_time = 2000;
	timer = gettime() + allowed_time;
	while (timer > gettime())
	{
		println ("^3KILLING PLAYER COUNTDOWN");
		dist = ((timer - gettime()) * 200) / allowed_time;
		start = level.player.origin;
//		if (randomint (100) > 50)
		start += (0, dist + 20 * 2.2, 200);
		
//			start += (0 - ((dist+20)*1.2) - randomfloat(50), 0 - ((dist+20)*0.8) - randomfloat(50),200);
//		else
//			start += (0 - ((dist+20)*1.2) - randomfloat(50), 0 + ((dist+20)*0.8) - randomfloat(50),200);

		end = start + (0,0,-400);

		trace = bulletTrace(start, end, false, undefined);
		if (trace["fraction"] < 1.0)
		{
//			line (start, end, (1,0.2,0.3), 0.5);
//			line (start, trace["position"], (1,0.2,0.3), 0.5);
			playfx ( level._effect["big ground"], trace["position"] );
			thread playSoundinSpace (level.scr_sound ["Stuka hit"], trace["position"]);
		}

		wait (0.05);
	}

//	maps\_utility::Error ("STOP!");
	level.player coolKillplayer((-600, 22392, 3776));
}

safePlacePlayerSafe (trigger)
{
	while (1)
	{
		level notify ("player is safe from left mg42s");
		level.playerSafe = true;
		while (level.player istouching (trigger))
			wait (0.2);
			
		level.playerSafe = false;
		trigger waittill ("trigger");
	}
}

squib_attack (line, name, allowed_time)
{
	allowed_time *= 1000;
	trigger = getent ("dusthits_" + name, "targetname");
	name = (name + "guy");
//	if ((name == "rightguy") || (name == "leftguy"))
//		name = name + "2";

	level endon (name + "killed");
	level thread flagCheck (name + "2killed");
	level thread flagCheck (name + "killed");
	safeTrigger = matchTargetnameScriptnoteworthy ("safe place",name);

	while (1)
	{
		trigger waittill ("trigger");
		timer = gettime() + allowed_time;
		timer2 = gettime() + allowed_time*0.76;
		while ((level.player.origin[0] < line) && (timer > gettime()))
		{
//
//			1520
//			3000	100
//
			dist = ((timer - gettime()) * 200) / allowed_time;
			start = level.player.origin;
			if (randomint (100) > 50)
				start += (0 - ((dist+20)*1.2) - randomfloat(50), 0 - ((dist+20)*0.8) - randomfloat(50),200);
			else
				start += (0 - ((dist+20)*1.2) - randomfloat(50), 0 + ((dist+20)*0.8) - randomfloat(50),200);

			end = start + (0,0,-400);
//			line (start, end, (0,0.5,1), 0.5);

			trace = bulletTrace(start, end, false, undefined);
			if (trace["fraction"] < 1.0)
			{
//				line (start, trace["position"], (1,0.2,0.3), 0.5);
				playfx ( level._effect["big ground"], trace["position"] );
			}

			if ((gettime() > timer2) && (!level.flag[name+"2killed"]))
				break;
//			wait (randomfloat(0.1));
			wait (0.05);
		}
		
		println ("^3flag 1 is: ", level.flag[name+"killed"]);
		println ("^3flag 2 is: ", level.flag[name+"2killed"]);
//		println ("line is ", line, " player origin is ", level.player.origin);

		if (level.player.origin[0] >= line)
			continue;

		if ((level.flag[name+"2killed"]) && (level.player istouching (safetrigger)))
			continue;

		level.player coolKillplayer((-600, 22392, 3776));
		println ("killed the player from gun with name ", name);
	}
}

animatic34_death()
{
	wait 4;
	wait (randomfloat (2));
	self coolKill();
}

start_moving()
{
	self endon ("death");
	wait (1);
	wait randomfloat (1);
	wait (0.25);

	self seek_destination();
}

player_must_duck()
{
	wait (1);
	level endon ("duck done");
	while (1)
	{
		if (!isdefined (level.toucher))
		if (level.player getstance() == "stand")
			level.player DoDamage ( 25 + randomfloat (35), (0,0,0) );

		wait (randomfloat (1.5));
	}
}

large_death ()
{
//		if (self.num == "00")
//			println ("DIED");

	self notify ("you die");

	self.youdie = 1;
	org = self.origin;
//	angles = group gettagAngles (self.tag);
	self unlink();
	self.origin = org;
	angles = self.angles;
//	self.angles = angles;


	self animscripted("scriptedanimdone", org, angles, level.scr_anim[self.animname]["death"]);
//	self setFlaggedAnimKnobAll("animdone", level.scr_anim[self.animname]["death"], %root);
	self waittillmatch ("scriptedanimdone", "end");
	wait (4);
	self moveto (self.origin - (0,0,100), 5, 2);
	wait (5);
	self delete();
}

kill_large(org, range)
{
	largeguys = getentarray ("largeguy","targetname");
	for (i=0;i<largeguys.size;i++)
		if (distance (org, largeguys[i].origin) < range)
			largeguys[i] thread large_death();
}

mortar_think()
{
	return;
	level waittill ("start mortars");
	level endon ("stop mortars");
	wait randomfloat (35);
	while (1)
	{
//		kill_large(self.origin, 150);
		self playsound ("mortar_incoming", "sounddone", true);
		self waittill ("sounddone");
		playfx ( level.mortar[randomint (level.mortar.size)], self.origin );
		self playsound ("mortar_explosion");
		mortar_hit (self.origin);
		wait (randomfloat (85) + 10);
//		wait (randomfloat (35) + 10);
	}
}

#using_animtree("stalingrad_truckguy1");
truckguy1_think()
{
	guy = spawn ("script_model", (0,0,0));
	level thread add_totalguys(guy);
	guy.animname = "truckguy1";
	guy setmodel ("xmodel/character_soviet_overcoat");
	guy UseAnimTree(#animtree);
	guy thread handout_guns ("truckguy1", "tag_weapon_left");
	if (isdefined (level.scr_character[guy.animname]))
		guy [[level.scr_character[guy.animname]]]();

	level waittill ("breaking through explosion");
	guy delete();
}

#using_animtree("stalingrad_truckguy2");
truckguy2_think()
{
	guy = spawn ("script_model", (0,0,0));
	level thread add_totalguys(guy);
	guy.animname = "truckguy2";
	guy setmodel ("xmodel/character_soviet_overcoat");
	guy UseAnimTree(#animtree);
	guy thread handout_guns ("truckguy2", "tag_weapon_right");
	if (isdefined (level.scr_character[guy.animname]))
		guy [[level.scr_character[guy.animname]]]();

	level waittill ("breaking through explosion");
	guy delete();
}

#using_animtree("stalingrad_truckguy3");
truckguy3_think()
{
	guy = spawn ("script_model", (0,0,0));
	level thread add_totalguys(guy);
	guy.animname = "truckguy3";
	guy setmodel ("xmodel/character_soviet_overcoat");
	guy UseAnimTree(#animtree);
	guy thread handout_guns ("truckguy3", "tag_weapon_right", "ammoguy");
	if (isdefined (level.scr_character[guy.animname]))
		guy [[level.scr_character[guy.animname]]]();

	level waittill ("breaking through explosion");
	guy delete();
}

crateguy_think()
{
	spawn = spawn ("script_model", (0,0,0));
	level thread add_totalguys(spawn);
	spawn.animname = "crateguy";
	spawn setmodel ("xmodel/character_soviet_overcoat");
	spawn UseAnimTree(level.scr_animtree[spawn.animname]);

	node = getnode ("intro","targetname");
	org = getStartOrigin (node.origin, node.angles, level.scr_anim["crateguy"]["idle"][0]);
	angles = getStartAngles (node.origin, node.angles, level.scr_anim["crateguy"]["idle"][0]);
	spawn.origin = org;
	spawn.angles = angles;
	if (isdefined (level.scr_character[spawn.animname]))
		spawn [[level.scr_character[spawn.animname]]]();

	guy[0] = spawn;
	while (1)
	{
//		guy[0] thread current_target (2500, "hello");
		anim_single (guy, "fullbody42", undefined, node);
		guy[0] thread anim_loop(guy, "idle", undefined, "stop anim", node);
		wait (randomfloat(1) + 0.5);
		guy[0] notify ("stop anim");
		anim_single (guy, "fullbody43", undefined, node);
//		guy[0] thread anim_loop(guy, "idle", undefined, "stop anim", node);
//		wait (randomfloat(2));
//		guy[0] notify ("stop anim");
		anim_single (guy, "fullbody44", undefined, node);
		guy[0] thread anim_loop(guy, "idle", undefined, "stop anim", node);
		wait (randomfloat(1) + 0.5);
		guy[0] notify ("stop anim");
	}

//	guy thread handout_guns ("truckguy2", "right");
}

crate_farshore()
{
	spawn = spawn ("script_model", (0,0,0));
	level thread add_totalguys(spawn);
	spawn.animname = "crateguy";
	spawn setmodel ("xmodel/character_soviet_overcoat");
	spawn UseAnimTree(level.scr_animtree[spawn.animname]);

	node = getnode ("crate_farshore","targetname");
	org = getStartOrigin (node.origin, node.angles, level.scr_anim["crateguy"]["idle"][0]);
	angles = getStartAngles (node.origin, node.angles, level.scr_anim["crateguy"]["idle"][0]);
	spawn.origin = org; spawn.angles = angles;
	if (isdefined (level.scr_character[spawn.animname]))
		spawn [[level.scr_character[spawn.animname]]]();

	guy[0] = spawn;
	guy[0] thread anim_loop(guy, "idle", undefined, "stop anim", node);
	level waittill ("stuka1");
	spawn delete();
}

/*
#using_animtree("stalingrad_truckguy2");
truckguy2_think()
{
	println ("guy with export ", self.export, " is anim tree stalingrad_truckguy2");
	self UseAnimTree(#animtree);
	thread handout_guns ("truckguy2", "right");
}
*/

groupstart(unload, starttime, endtime, ender)
{
//	level waittill ("boat ride finishing");
//	for (i=0;i<10;i++)
	if (isdefined (ender))
		level endon (ender);

	while (1)
	{
		if (unload == "left")
		{
			level waittill ("boat unload" + unload);
			thread large_group(unload, starttime, endtime, ender, 0);
			wait (5);
			if (!level.flag["stop all MG42s"])
				thread large_group(unload, starttime, endtime, ender, 1);
			else
				thread large_group("left ending", starttime, endtime, ender, 1);
			wait (5);
			thread large_group(unload, starttime, endtime, ender, 2);
			wait (5);
			if (!level.flag["stop all MG42s"])
				thread large_group(unload, starttime, endtime, ender, 1);
			else
				thread large_group("left ending", starttime, endtime, ender, 1);
		}
		else
		if (unload == "right")
		{
			level waittill ("boat unload" + unload);
			thread large_group(unload, starttime, endtime, ender, 0);
		}
		else
		if (unload == "left far dock")
		{
			thread large_group(unload, starttime, endtime, ender, 0);
			wait (7);
			thread large_group(unload, starttime, endtime, ender, 1);
			wait (5);
			thread large_group(unload, starttime, endtime, ender, 2);
			wait (7);
			thread large_group(unload, starttime, endtime, ender, 1);
			wait (12);
		}

//		wait (20);
	}
}


idle_anim(name)
{
	node = getnode ("ammo","targetname");
	self endon ("g_scripted_idle_anim");
	while (1)
	{
		self.facial_animation = level.scr_face[self.animname]["idle"][0];
		self animscripted("scriptedanimdone", node.origin, node.angles, level.scr_anim[name]["idle"][0]);
		self setflaggedanimrestart("scripted_anim_facedone", self.facial_animation, 1, .1, 1);
		self waittillmatch ("scriptedanimdone", "end");
	}
}

handout_animloop (name, ammoguy)
{
	if (!isdefined (ammoguy))
		level endon ("no more guns and ammo");

	node = getnode ("ammo","targetname");
	org = getStartOrigin (node.origin, node.angles, level.scr_anim[name]["idle"][0]);
	angles = getStartAngles (node.origin, node.angles, level.scr_anim[name]["idle"][0]);
	self.origin = org;
	self.angles = angles;

	while (1)
	{
		self thread idle_anim(name);

		if (isdefined (ammoguy))
		{
			level waittill ("ammo");
//			thread ammo_finished();
//			level.flag["ready for ammo"] = false;
		}
		else
		{
			level waittill ("gun");
//			thread gun_finished();
//			level.flag["ready for gun"] = false;
		}

		self notify ("g_scripted_idle_anim");
//		if (isdefined (level.scr_face[name]["gun"][0]))
		self.facial_animation = level.scr_face[name]["gun"][0];
		self setflaggedanimrestart("scripted_anim_facedone", self.facial_animation, 1, .1, 1);
		self animscripted("scriptedanimdone", node.origin, node.angles, level.scr_anim[name]["gun"][0]);

		self waittillmatch ("scriptedanimdone", "end");

		/*
		if ((!isdefined (ammoguy)) && (!level.total_gun_and_ammo_guys))
		{
			level notify ("no more guns and ammo");
			return;
		}
		*/
	}
}

/*
ammo_finished()
{
	wait (4.9);
	level.flag["ready for ammo"] = true;
	level notify ("ready for ammo");
}

gun_finished()
{
	wait (1.3);
	level.flag["ready for gun"] = true;
	level notify ("ready for gun");
}
*/

handout_stop (name, ammoguy, hand)
{
	level waittill ("no more guns and ammo");

	if ((!isdefined (ammoguy)) && (self.attached))
		self detach("xmodel/weapon_mosinnagant", hand);

	self.attached = false;

	node = getnode ("ammo","targetname");
	org = getStartOrigin (node.origin, node.angles, level.scr_anim[name]["idle"][0]);
	angles = getStartAngles (node.origin, node.angles, level.scr_anim[name]["idle"][0]);
//	self.origin = org;
//	self.angles = angles;

	if (isdefined (level.scr_anim[name]["trans"]))
	{
		if (isdefined (level.scr_face[self.animname]["trans"]))
			self.facial_animation = level.scr_face[self.animname]["trans"];
		self animscripted("scriptedanimdone", node.origin, node.angles, level.scr_anim[name]["trans"]);
		self waittillmatch ("scriptedanimdone", "end");
	}

	guy[0] = self;

	while (1)
	{

		idleanim = anim_weight (guy, "endidle");
		if (isdefined (level.scr_face[self.animname]["endidle"][idleanim]))
			self.facial_animation = level.scr_face[self.animname]["endidle"][idleanim];
		self animscripted("scriptedanimdone", node.origin, node.angles, level.scr_anim[name]["endidle"][idleanim]);
		self waittillmatch ("scriptedanimdone", "end");
	}
}


handout_guns (name, hand, ammoguy)
{
	level endon ("no more guns and ammo");
	thread handout_animloop(name, ammoguy);
	thread handout_stop (name, ammoguy, hand);

//	self animscripts\shared::putGunInHand ("none");

	self.attached = true;

	if (isdefined (ammoguy))
		return;

	self attach("xmodel/weapon_mosinnagant", hand);

	while (1)
	{
		self waittill ("scriptedanimdone",notetrack);
		if ((notetrack == "attach") && (level.total_gun_and_ammo_guys))
		{
			if (!self.attached)
				self attach("xmodel/weapon_mosinnagant", hand);

			self.attached = true;
		}
		else
		if (notetrack == "detach")
		{
			if (self.attached)
				self detach("xmodel/weapon_mosinnagant", hand);

			self.attached = false;
		}
//			self animscripts\shared::putGunInHand ("none");
	}
}

fog()
{
	while (1)
	{
		org = level.player getorigin();
		dist = 5500 - org[1];
		setCullFog(dist * 0.5, dist , .18, .20, .22, 0);
		wait (1);
	}
}

#using_animtree("stalingrad_drones");
/*
cliffguy_delete (group)
{
	self endon ("death");
	group waittill ("delete time");
	self delete();
}
*/

cliffguy_run (animname)
{
	self endon ("death");
	while (1)
	{
		self waittill ("run");
//		self thread current_target(1500, "run");
		self.move_anim = level.scr_anim[animname]["run"][self.run_index];
		self thread cliffguy_animloop ();
	}
}

cliffguy_walk (animname)
{
	self endon ("death");
	while (1)
	{
		self waittill ("walk");
//		self thread current_target(1500, "walk");
		self.move_anim = level.scr_anim[animname]["walk"][self.walk_index];
		self thread cliffguy_animloop ();
	}
}

cliffguy_animloop ()
{
//	self endon ("walk");
//	self endon ("run");
//	self endon ("death");
//	self endon 

	while (self.origin[1] < self.stopline)
	{
		self setFlaggedAnimKnob("animdone", self.move_anim);
		self waittillmatch ("animdone", "end");
	}

	self notify ("finished animating");
}

totalguys_print()
{
	self endon ("death");

	while(1)
	{
		print3d ((self.origin + (0, 0, 65)), self.guy_num, (0.48,9.4,0.76), 0.85);
		wait (0.05);
	}
}

calc_totalguys ()
{
	newarray = [];
	for (i=0;i<level.totalguys_array.size;i++)
	{
		if (isdefined (level.totalguys_array[i]))
			newarray[newarray.size] = level.totalguys_array[i];
	}

	level.totalguys_array = newarray;
	for (i=0;i<level.totalguys_array.size;i++)
		level.totalguys_array[i].guy_num = i+1;
}

add_totalguys (guy)
{
	return;
	/*
	if (getcvar ("totalguys") == "")
		return;

	level.totalguys_array[level.totalguys_array.size] = guy;
	calc_totalguys();

	text = 21;
	hdSetString(text, ("Total guys: " + level.totalguys_array.size));
	hdSetAlignment(text, "center", "bottom");
	hdSetPosition(text, 0, -20);
	hdSetFontScale(text, 2);
	hdSetAlpha(text, 1);

	guy thread totalguys_print();
	guy waittill ("death");
	calc_totalguys();
	hdSetString(text, ("Total guys: " + level.totalguys_array.size));
	hdSetAlignment(text, "center", "bottom");
	hdSetPosition(text, 0, -20);
	hdSetFontScale(text, 2);
	hdSetAlpha(text, 1);
	*/
}

cliffguy_think (group, live)
{
	level thread add_totalguys(self);
	self.run_index = randomint (level.scr_anim[self.animname]["run"].size);
	self.walk_index = randomint (level.scr_anim[self.animname]["walk"].size);
	self.move_anim = level.scr_anim[self.animname]["run"][self.run_index];


//	self thread cliffguy_delete(group);
	self thread cliffguy_mortar_death();
	self endon ("mortar death");
	self UseAnimTree(#animtree);
	self [[random(level.scr_character[self.animname])]]();
	self.origin = group gettagorigin (self.tag);
	wait (0.1);
	if ((level.flag["stop all MG42s"]) || (live)) // was "endgame" but we want less with the dying.."
		self.stopline = 2250;
	else
		self.stopline = -250;

	self linkto (group, self.tag, (0,0,0), (0,0,0));

	self thread cliffguy_animloop();
	self waittill ("finished animating");

	wait (randomfloat (3.5));

	self unlink();

	deathanim = random (level.scr_anim[self.animname]["death"]);
	if (self.animname == "flag drone")
	{
		org = getStartOrigin (self.origin, self.angles, deathanim);
		ang = getStartAngles (self.origin, self.angles, deathanim);
		self moveto (org, 0.15);
		self rotateto (ang, 0.15);
		wait (0.15);
	}

	self animscripted("death anim", self.origin, self.angles, deathanim, "deathplant");
	self.died = true;
	self bloody_death();

	wait (4);
	self movez (-100, 3, 2, 1);
	wait (3);
	self delete();
}

cliffguy_mortar (delayer)
{
//	wait ((starttime) + randomint (endtime));
	wait (2);
	while (self.origin[1] < -250)
		wait (2);

	self playsound ("mortar_incoming", "sounddone", true);
	self waittill ("sounddone");
	playfx ( level.mortar[randomint (level.mortar.size)], self.origin );
	self playsound ("mortar_explosion");

	earthquake(0.3, 3, self.origin, 850); // scale duration source radius
	radiusDamage (self.origin, 150, 150, 0);

	ai = getentarray ("drone","targetname");
	for (i=0;i<ai.size;i++)
	{
		if (isdefined (ai[i].died))
			continue;

		dist = distance (ai[i].origin, self.origin);
		if (dist < 200)
		{
			ai[i].died = true;
			ai[i].mortarDeath = getExplodeDeath("drone", self.origin, dist);
			ai[i] notify ("mortar death");
			ai[i] animscripted("death anim", ai[i].origin, ai[i].angles, ai[i].mortarDeath);
			ai[i] unlink();
		}
	}
}

cliffguy_mortar_death ()
{
//	guy endon ("death");
	self waittill ("mortar death");
	level thread cliffguy_mortar_sink (self);
}

cliffguy_mortar_sink (guy)
{
	org = spawn ("script_origin",(0,0,3));
	org.origin = guy.origin;
	org.angles = guy.angles;
	guy linkto (org);
//	guy thread current_target(8000);
	if (guy.mortarDeath == level.scr_anim["drone"]["explode death up"])
	{
		upHeight = 200;
		downHeight = -500;
//		println ("^FLY SKY HIGH");
	}
	else
	{
		upHeight = 30;
		downHeight = -500;
	}
	
	org moveto (guy.origin + (0,0,upHeight), 0.3);
	wait (0.3);
	if (isdefined (guy))
		org moveto (guy.origin + (0,0,downHeight), 1.2, 1.2);
	wait (1.2);
//	self waittillmatch ("death anim", "end");
//	self bloody_death();
	org delete();
	if (isdefined (guy))
		guy delete();
}

#using_animtree("animation_rig_largegroup20");
large_group (groupnum, starttime, endtime, ender, flagguy)
{
//	level endon ("stoplarge" + groupnum);
//	println ("Starting wave ", groupnum);
	if (isdefined (ender))
		level endon (ender);

	node = getnode ("group","targetname");

	group = spawn ("script_model",(1,2,3));
//	group.origin = (-84, -2101, -20);
	group.origin = node.origin;
	group.origin = node.origin + (0, 0, 0);
	group setmodel ("xmodel/largegroup_20");
	group hide();
	group UseAnimTree(#animtree);
	group.angles = (0,0,0);

//	println ("doing anim for group ", groupnum);
	group setFlaggedAnimKnobRestart("animdone", level.large_group[groupnum]);
	mortarguy = randomint (20);
	guys = [];
	if (getcvar ("scr_stalingrad_fast") == "1")
		level.fastMap = true;
	else
		level.fastMap = false;
		
	for (i=0;i<20;i++)
	{
		
		if ((i != flagguy) && (level.fastMap) && (randomint (100) > 65))
			continue;
		
		if (i < 10)
			msg = ("tag_guy0" + i);
		else
			msg = ("tag_guy" + i);

		guy = spawn ("script_model",(1,2,3));
		guy.targetname = "drone";
//		guy setmodel ("xmodel/character_soviet_overcoat");
		guy.tag = msg;
		guy.num = i;

		if (i == mortarguy)
		{
			guy thread cliffguy_mortar (i);
			live = true;
		}
		else
			live = false;

		if (i == flagguy)
			guy.animname = "flag drone";
		else
			guy.animname = "drone";
			
		guy thread cliffguy_think(group, live);
		guys[guys.size] = guy;
	}

	while (1)
	{
		group waittill ("animdone", notetrack);

		if (notetrack == "end")
			break;
/*
		for (i=0;i<20;i++)
		{
			if (i < 10)
				msg = ("guy0" + i);
			else
				msg = ("guy" + i);

			if (!isdefined (guys[i]))
				continue;

			if (notetrack == msg + " walk")
			{
				guys[i].move_anim = level.scr_anim[guys[i].animname]["walk"][guys[i].walk_index];
//				guys[i] thread cliffguy_animloop();
			}
			else
			if (notetrack == msg + " run")
			{
				guys[i].move_anim = level.scr_anim[guys[i].animname]["run"][guys[i].walk_index];
//				guys[i] thread cliffguy_animloop();
			}
		}
*/		
	}

//	group notify ("delete time");
	for (i=0;i<guys.size;i++)
	{
		if (isdefined (guys[i]))
			guys[i] delete();
	}
	group delete();
}

anim_death (guy, tag)
{
	if (!isdefined (guy))
	{
		println ("guy at tag ", tag, " was undefined");
		return;
	}
	org = self gettagOrigin (tag);
	angles = self gettagAngles (tag);

	uniquename = "looping anim";
	guy.playDeathAnim = false;
	guy animscripted(uniquename, org, angles, level.scr_anim[guy.animname]["death"]);

	if (isdefined (level.scr_notetrack[guy.animname]))
		thread maps\_anim::notetrack_wait (guy, uniquename);
	else
		guy waittillmatch (uniquename, "end");


//	wait (3);
//	guy DoDamage ( guy.health + 50, guy.origin );
//	guy delete();
}

anim_weight (guy, anime)
{
	total_anims = level.scr_anim[guy[0].animname][anime].size;
	idleanim = randomint (total_anims);
	if (total_anims > 1)
	{
		weights = 0;
		anim_weight = 0;

		for (i=0;i<total_anims;i++)
		{
			if (isdefined (level.scr_anim[guy[0].animname][anime + "weight"]))
			{
				if (isdefined (level.scr_anim[guy[0].animname][anime + "weight"][i]))
				{
					weights++;
					anim_weight += level.scr_anim[guy[0].animname][anime + "weight"][i];
				}
			}
		}

		if (weights == total_anims)
		{
			anim_play = randomfloat (anim_weight);
			anim_weight	= 0;

			for (i=0;i<total_anims;i++)
			{
				anim_weight += level.scr_anim[guy[0].animname][anime + "weight"][i];
				if (anim_play < anim_weight)
				{
					idleanim = i;
					break;
				}
			}
		}
	}

	return idleanim;
}

animnamer ()
{
	self endon ("death");
	while (1)
	{
		print3d ((self.origin + (0, 0, 65)), self.animname, (0.48,9.4,0.76), 0.85);
		wait (0.05);
	}
}

//#using_animtree("generic_human");
init (guy, tag, deleter)
{
	org = self gettagOrigin (tag);
	ang = self gettagAngles (tag);

	for (i=0;i<guy.size;i++)
	{
		level thread add_totalguys(guy[i]);
		guy[i].origin = (org);
		guy[i].angles = (ang);
		guy[i] linkto (self, tag);
//		guy[i] thread animnamer();

//		if (isdefined (level.scr_character[guy[i].animname]))
			guy[i] [[level.scr_character[guy[i].animname]]]();
			/*
		else
		{
			guy[i] setmodel ("xmodel/character_soviet_overcoat");
			rand = randomint(100);
			if (rand<50)
				guy[i] attach("xmodel/head_mike");
			else
				guy[i] attach("xmodel/head_blane");
		}
		*/

		guy[i] UseAnimTree(level.scr_animtree[guy[i].animname]);
		guy[i] thread delete_on_boat_explodes();
		level.voiceoverguys[level.voiceoverguys.size] = guy[i];
//		println ("setup voiceover guy ", level.voiceoverguys.size);
	}
	
	if (level.fastMap)
	{
		newGuys = [];
		for (i=0;i<guy.size;i++)
		{
			if (isdefined (guy[i].fastDelete))
			{
				guy[i] delete();
				//maps\_utility::error ("deleted guy needlessly");
				continue;
			}
				
			newGuys[newGuys.size] = guy[i];
		}
		
		if ((isdefined (deleter)) && (deleter == true))
			return newGuys;
	}
	else
		newGuys = guy;

//	println ("guy had size ", guy.size, " and newguys has size ", newguys.size);
	thread impact_duck(newGuys, tag, "stuka1");
	return newGuys;
}

stuka_stop(msg)
{
	level waittill (msg);
	self notify ("stop anim");
}

impact_duck(guy, tag, msg)
{
	level endon ("stuka1");
	level endon ("stuka");
	level endon ("climb");

	if ((isdefined (level.scr_anim[guy[0].animname]["ducktrans"])) &&
	   (isdefined (level.scr_anim[guy[0].animname]["duckidle"])) &&
	   (isdefined (level.scr_anim[guy[0].animname]["duckflinch"])))
	{
		guy[0] notify ("stop anim");
		guy[0] thread anim_loop(guy, "idle", tag, "stop anim", undefined, self);
		guy[0] thread stuka_stop(msg);
		while (1)
		{
			level waittill ("duck event: incoming mortar");
//			println ("Distance is: ", distance (level.mortar_origin, guy[0].origin));
			if (distance (level.mortar_origin, guy[0].origin) < 6000)
			{
				wait (randomfloat (0.5));
				guy[0] notify ("stop anim");
				anim_single (guy, "ducktrans", tag);

				guy[0] thread anim_loop(guy, "duckidle", tag, "stop anim", undefined, self);
				level waittill ("duck event: mortar hit");
				wait (randomfloat (0.5));

//				println ("Distance is: ", distance (level.mortar_origin, guy[0].origin));
				if (distance (level.mortar_origin, guy[0].origin) < 4500)
				{
//					println ("mortar hit");
					guy[0] notify ("stop anim");
					anim_single (guy, "duckflinch", tag);
					guy[0] thread anim_loop(guy, "duckidle", tag, "stop anim", undefined, self);
				}
				thread duck (guy, tag, msg);
			}
		}
	}
	else
	{
		if (guy[0].animname != "shoutguy")
			level thread anim_loop(guy, "idle", tag, msg, undefined, self);
	}
}

duck (guy, tag, msg)
{
	level endon (msg);
	level endon ("duck event: incoming mortar");
	wait (randomfloat (5));
	guy[0] notify ("stop anim");
	anim_single (guy, "ducktransout", tag);
	guy[0] thread anim_loop(guy, "idle", tag, "stop anim", undefined, self);
}


delete_on_boat_explodes ()
{
	level waittill ("boat explodes");
	wait (0.5);
	self delete();
}

pistolguy (guy, tag)
{
	guy = init (guy,tag);

//	thread anim_loop(guy, "idle", tag, "stuka1");
//	thread anim_loop(guy, "idle", tag, "duck");
//	level waittill ("duck");
//	anim_single (guy, "duck", tag);
//	thread anim_loop(guy, "crouchidle", tag, "stuka1");
	level waittill ("stuka1");

//	anim_single (guy, "flinch", tag);
	anim_single (guy, "duck", tag);
	level thread anim_loop(guy, "crouchidle", tag, "stuka", undefined, self);
	level waittill ("stuka");

	thread anim_single (guy, "stuka", tag);
	level waittill ("jump");

	anim_single (guy, "jump", tag);
	level thread anim_loop (guy, "standidle", tag, "climb", undefined, self);
	level waittill ("climb");
	anim_single (guy, "climb", tag);

//	for (i=0;i<guy.size;i++)
//		guy[i] thread get_gunammo ();

}

bloodsplat (guy)
{
	wait (1);
	playfxOnTag ( level._effect["flesh small"] , guy, "Bip01 Neck" );
}

groupA (guy, tag, deleter)
{
	guy = init (guy,tag, deleter);
	if (deleter)
	{
		for (i=0;i<guy.size;i++)
			guy[i] delete();
		return;
	}


//	thread anim_loop(guy, "idle", tag, "stuka");
//	thread anim_loop(guy, "idle", tag, "duck");
	level waittill ("stuka1");
	anim_single (guy, "duck", tag);
	level thread anim_loop (guy, "crouchidle", tag, "stuka", undefined, self);

	level waittill ("stuka");

	newguys = [];
	for (i=0;i<guy.size;i++)
	{
		if (isdefined (level.scr_anim[guy[i].animname]["death"]))
		{
			thread anim_death (guy[i], tag);
//			thread bloodsplat (guy[i]);
		}
		else
			newguys[newguys.size] = guy[i];
	}

	if (!newguys.size)
		return;

	guy = newguys;
	newguys = undefined;

//	println (guy[0].animname + " " + tag);
	thread anim_single (guy, "stuka", tag);
	level waittill ("jump");

	anim_single (guy, "jump", tag);
	thread impact_duck(guy, tag, "climb");
//	level thread anim_loop (guy, "idle", tag, "climb", undefined, self);
//	wait (randomfloat (level.climb_time));
	level waittill ("climb");
	anim_single (guy, "climb", tag);

//	for (i=0;i<guy.size;i++)
//		guy[i] thread get_gunammo ();
}

groupC (guy, tag, deleter)
{
	guy = init (guy,tag, deleter);
	if (deleter)
	{
		for (i=0;i<guy.size;i++)
			guy[i] delete();
		return;
	}

//	thread anim_loop(guy, "idle", tag, "stuka");
//	thread anim_loop(guy, "idle", tag, "duck");
	level waittill ("stuka1");
	anim_single (guy, "duck", tag);
//	level thread anim_loop(guy, "crouchidle", tag, "stuka0", undefined, self);
//	level waittill ("stuka0");
//	anim_single (guy, "lookright", tag);
	level thread anim_loop(guy, "crouchidle", tag, "stuka", undefined, self);
	level waittill ("stuka");

	thread anim_single (guy, "stuka", tag);
	level waittill ("jump");

	anim_single (guy, "jump", tag);
//	level thread anim_loop(guy, "idle", tag, "climb", undefined, self);
//	wait (randomfloat (level.climb_time));
	thread impact_duck(guy, tag, "climb");
	level waittill ("climb");
	thread anim_single (guy, "climb", tag);
}

groupE (guy, tag)
{
	guy = init (guy,tag);

//	thread anim_loop(guy, "idle", tag, "stuka");
//	thread anim_loop(guy, "idle", tag, "duck");
	level waittill ("stuka1");

	newguys = [];
	for (i=0;i<guy.size;i++)
	{
		if (isdefined (level.scr_anim[guy[i].animname]["death"]))
			thread anim_death (guy[i], tag);
		else
			newguys[newguys.size] = guy[i];
	}

	guy = newguys;
	newguys = undefined;
	if (!guy.size)
		return;

	anim_single (guy, "duck", tag);
	level thread anim_loop(guy, "crouchidle", tag, "stuka", undefined, self);
	level waittill ("stuka");


	thread anim_single (guy, "stuka", tag);
	level waittill ("jump");

	anim_single (guy, "jump", tag);
//	level thread anim_loop(guy, "idle", tag, "climb", undefined, self);
//	wait (randomfloat (level.climb_time));
	thread impact_duck(guy, tag, "climb");
	level waittill ("climb");
	thread anim_single (guy, "climb", tag);
}

groupD (guy, tag, deleter)
{
	guy = init (guy,tag, deleter);
	if (deleter)
	{
		for (i=0;i<guy.size;i++)
			guy[i] delete();
		return;
	}

//	thread anim_loop(guy, "idle", tag, "stuka");
//	thread anim_loop(guy, "idle", tag, "duck");
	level waittill ("stuka1");
	anim_single (guy, "duck", tag);

//	level thread anim_loop(guy, "crouchidle", tag, "stuka0", undefined, self);
//	level waittill ("stuka0");
//	anim_single (guy, "lookright", tag);
	level thread anim_loop(guy, "crouchidle", tag, "stuka", undefined, self);
	level waittill ("stuka");


	thread anim_single (guy, "stuka", tag);
	level waittill ("jump");

	anim_single (guy, "jump", tag);
//	level thread anim_loop(guy, "idle", tag, "climb", undefined, self);
//	wait (randomfloat (level.climb_time));
	thread impact_duck(guy, tag, "climb");
	level waittill ("climb");
	thread anim_single (guy, "climb", tag);
}


get_stacknode()
{
	ammonode = getnode ("ammo","targetname");
	if ((!isdefined (ammonode.taken)) || (!ammonode.taken))
	{
		ammonode.taken = true;
		return ammonode;
	}

	org = ammonode.origin;
	nodes = getnodearray ("stackup","targetname");
	excluders = [];
	for (i=0;i<nodes.size;i++)
	if ((isdefined (nodes[i].taken)) && (nodes[i].taken))
		excluders[excluders.size] = nodes[i];

	return maps\_utility::getClosest (org, nodes, excluders);
}

get_gunammo ()
{
	self unlink();
	self seek_destination();
	return;

	node = get_stacknode ();
	node.taker = self;
}

player_unlink()
{
	wait (1.5);
	level.player unlink();
}


make_ai_get_gunammo( node, item )
{
//	guy = node.taker;
//	node.taker = undefined;
	self endon ("death");

	if (isdefined (self.anchor))
	{
		anchor = true;
//		level notify ("ammo");
	}
	else
		anchor = false;

	level notify (item);

	if (item == "gun")
	{
		node = getnode ("ammo","targetname");
		org = getStartOrigin (node.origin, node.angles, level.scr_anim[self.animname]["gun"][0]);
		angles = getStartAngles (node.origin, node.angles, level.scr_anim[self.animname]["gun"][0]);

		level.total_gun_and_ammo_guys--;
		self.facial_animation = level.scr_face[self.animname]["gun"][0];
		self animscripted("scriptedgun", node.origin, node.angles, level.scr_anim[self.animname]["gun"][0]);
		self waittill ("scriptedgun", notetrack);
		if (!anchor)
			self animscripts\shared::putGunInHand ("left");
		self.hasWeapon = true;
		self.animname = "gunguy";
	}
	else
	{
		node = getnode ("ammo","targetname");
		org = getStartOrigin (node.origin, node.angles, level.scr_anim[self.animname]["ammo"][0]);
		angles = getStartAngles (node.origin, node.angles, level.scr_anim[self.animname]["ammo"][0]);

//		if (!anchor)
//			self.team = "allies";
//		else
		if (anchor)
			self thread give_player_ammo_clip();

		level.total_gun_and_ammo_guys--;
		self.facial_animation = level.scr_face[self.animname]["ammo"][0];
		self animscripted("scriptedgun", node.origin, node.angles, level.scr_anim[self.animname]["ammo"][0]);
		self.hasWeapon = false;
		self.animname = "ammoguy";
	}

	self waittillmatch ("scriptedgun","end");
	self notify ("got gun or ammo");
//	self.spawnflags -= 4;
//	if (isdefined (self.introblock))
//		self.introblock delete();

	if (!anchor)
		self thread seek_destination();
	else
	{
		maps\_utility::array_thread(getentarray ("playerblock","targetname"), ::solid_brush);

		level.player unlink();
		level notify ("player is done with tags");
		self delete();
	}
}

give_player_ammo_clip()
{
	wait (0.85);
	level.player giveWeapon("stalingrad_ammo");
	level.player switchToWeapon("stalingrad_ammo");
	wait (10);
	level.player takeweapon ("stalingrad_ammo");
}

jumper (guy, tag)
{
	guy = init (guy,tag);

//	thread anim_loop(guy, "idle", tag, "stuka");
//	thread anim_loop(guy, "idle", tag, "duck");
	level waittill ("stuka1");
	anim_single (guy, "duck", tag);
	level thread anim_loop(guy, "crouchidle", tag, "stuka", undefined, self);
	level waittill ("stuka");

	thread anim_single (guy, "stuka", tag);
	level waittill ("jump");

	thread anim_death (guy[0], tag);
}

ppsh (guy, tag)
{
	guy = init (guy,tag);

//	level thread anim_loop(guy, "idle", tag, "stuka1");
//	level thread anim_loop(guy, "idle", tag, "duck");
//	level waittill ("duck");
//	anim_single (guy, "duck", tag);
//	level thread anim_loop(guy, "idle", tag, "stuka1");
	level waittill ("stuka1");

	anim_single (guy, "duck", tag);
	level thread anim_loop(guy, "idle", tag, "stuka", undefined, self);
	level waittill ("stuka");
	thread anim_death(guy[0], tag);
	wait (3.6);
	playfxOnTag ( level._effect["flesh"] , guy[0], "Bip01 Neck" );
}

shout (guy, tag)
{
	guy = init (guy,tag);
	wait (0.5);
	thread shout2 (guy,tag);
	anim_single (guy, "fullbody 1", tag);
	level thread anim_loop(guy, "lookidle", tag, "duck", undefined, self);
}

shout2 (guy,tag)
{
	level waittill ("duck");
	wait (1);
	anim_single (guy, "fullbody 2", tag);
	anim_single (guy, "fullbody 3", tag);

	level thread anim_loop(guy, "idle",  tag, "stuka1", "stuka1", self);
	level waittill ("stuka1");
	anim_single (guy, "duck", tag);

	level thread anim_loop(guy, "idle",  tag, "stuka", "stuka", self);
	level waittill ("stuka");
	thread anim_single (guy, "stuka", tag);

	level waittill ("jump");
	anim_single (guy, "jump", tag);
	level thread anim_loop(guy, "standidle", tag, "climb", "climb", self);
	level waittill ("climb");
	anim_single (guy, "climb", tag);
}

officerA (guy, tag, deleter)
{
	init(guy,tag, deleter);
	
	if (deleter)
	{
		for (i=0;i<guy.size;i++)
			guy[i] delete();
		return;
	}
//	level thread anim_loop(guy, "idle", tag, "stuka1");
//	level thread anim_loop(guy, "idle", tag, "duck");
//	level waittill ("duck");
//	anim_single (guy, "duck", tag);
//	level thread anim_loop(guy, "idle",  tag, "stuka1");
	level waittill ("stuka1");
	anim_single (guy, "duck", tag);
	level thread anim_loop(guy, "idle",  tag, "stuka", undefined, self);
	level waittill ("stuka");
	thread anim_single (guy, "stuka", tag);
	level waittill ("jump");
	anim_single (guy, "jump", tag);
	level thread anim_loop(guy, "idle", tag, "climb", undefined, self);
	level waittill ("climb");
	anim_single (guy, "climb", tag);
}

officerB (guy, tag)
{
	init(guy,tag);

//	level thread anim_loop(guy, "idle", tag, "stuka1", undefined, self);
//	level thread anim_loop(guy, "idle", tag, "duck");
//	level waittill ("duck");
//	anim_single (guy, "duck", tag);
//	level thread anim_loop(guy, "crouchidle", tag, "stuka1");
	level waittill ("stuka1");
	anim_single (guy, "duck", tag);
	level thread anim_loop(guy, "crouchidle", tag, "stuka", undefined, self);
	level waittill ("stuka");
	thread anim_single (guy, "stuka", tag);
	level waittill ("jump");
	anim_single (guy, "jump", tag);
	level thread anim_loop(guy, "idle",  tag, "climb", undefined, self);
	level waittill ("climb");

//	anim_single (guy, "climb", tag);
}

stopwatch()
{
	level endon ("stopwatch");
	timer = gettime();
//	thread stopwatch_precise();
	while (1)
	{
		num = (gettime() - timer) * 0.001;
		println ("time ", num);
		wait 1;
	}
}

stopwatch_precise()
{
	level endon ("stopwatch");
	timer = gettime();
	setcvar ("timer1","");
	setcvar ("timer2","");
	while (1)
	{
		if (getcvar ("timer1") != "")
		{
			setcvar ("timer1","");
			println ("^acurrent time 1: ", gettime() - timer);
			plane_strafe1();
		}

		if (getcvar ("timer2") != "")
		{
			setcvar ("timer2","");
			println ("^acurrent time 2: ", gettime() - timer);
			plane_strafe2();
		}
		wait (0.05);
	}
}

attach_model_to_tag ( tag )
{
	model = spawn ("script_model",(0,0,0));
	model setmodel ("xmodel/temp");
	model linkto (self, tag, (0,0,0),(0,0,0));
}

plane_strafe1()
{
	/*
	for (i=0;i<level.boat_left_tag.size;i++)
		self attach_model_to_tag (level.boat_left_tag[i]);

	for (i=0;i<level.boat_right_tag.size;i++)
		self attach_model_to_tag (level.boat_right_tag[i]);
	*/

	wait (88);
//	thread playSoundOnTag(level.scr_sound ["bullet impact canvas"]);
	thread boat_effects_right_up();
	thread boat_effects_left_down();
	thread boat_effects_dust_right();
	wait (0.4);
	thread boat_effects_right_up();
	thread boat_effects_dust_right();
	thread boat_effects_left_down();
	wait (0.4);
	thread boat_effects_right_up();
	thread boat_effects_dust_right();
	thread boat_effects_left_down();
	wait (0.4);
	thread boat_effects_right_up();
	thread boat_effects_dust_right();
}

boat_effects_right_up()
{
	for (i=0;i<level.boat_right_effect.size;i++)
	{
		playfxOnTag ( level._effect[level.boat_right_effect[i]], self, level.boat_right_tag[i] );
		if (level.boat_right_effect[i] == "metal")
			thread playSoundOnTag(level.scr_sound ["metal hit"], level.boat_right_tag[i]);
		else
			thread playSoundOnTag(level.scr_sound ["exaggerated flesh impact"], level.boat_right_tag[i]);
		wait (0.1);
	}
}

boat_effects_right_down()
{
	for (i=level.boat_right_effect.size-1;i>=0;i--)
	{
		playfxOnTag ( level._effect[level.boat_right_effect[i]], self, level.boat_right_tag[i] );
		if (level.boat_right_effect[i] == "metal")
			thread playSoundOnTag(level.scr_sound ["metal hit"], level.boat_right_tag[i]);
		else
			thread playSoundOnTag(level.scr_sound ["exaggerated flesh impact"], level.boat_right_tag[i]);
		wait (0.1);
	}
}

boat_effects_dust_right()
{
	for (i=0;i<level.dust_right_tag.size;i++)
	{
		thread playSoundOnTag( level.scr_sound ["bullet impact canvas"], level.dust_right_tag[i] );
		playfxOnTag ( level._effect["boat dust"], self, level.dust_right_tag[i]);
		wait (0.1);
	}
}

plane_strafe2()
{
	wait (98);
//	thread playSoundOnTag(level.scr_sound ["bullet impact canvas"]);
	thread boat_effects_left_up();
	thread boat_effects_right_down();
	thread boat_effects_dust_left();
	wait (0.4);
	thread boat_effects_left_up();
	thread boat_effects_right_down();
	thread boat_effects_dust_left();
	wait (0.4);
	thread boat_effects_left_up();
	thread boat_effects_dust_left();
	thread boat_effects_right_down();
	wait (0.4);
	thread boat_effects_left_up();
//	thread boat_effects_dust_left();
}

boat_effects_dust_left()
{
	for (i=0;i<level.dust_left_tag.size;i++)
	{
		thread playSoundOnTag( level.scr_sound ["bullet impact canvas"], level.dust_left_tag[i] );
		playfxOnTag ( level._effect["boat dust"], self, level.dust_left_tag[i] );
		wait (0.1);
	}
}

boat_effects_left_up()
{
	for (i=0;i<level.boat_left_effect.size;i++)
	{
		playfxOnTag ( level._effect[level.boat_left_effect[i]], self, level.boat_left_tag[i] );
		if (level.boat_left_effect[i] == "metal")
			thread playSoundOnTag(level.scr_sound ["bullet impact canvas"], level.boat_left_tag[i]);
		else
			thread playSoundOnTag(level.scr_sound ["exaggerated flesh impact"], level.boat_left_tag[i]);
		wait (0.1);
	}
}

boat_effects_left_down()
{
	for (i=level.boat_left_effect.size-1;i>=0;i--)
	{
		playfxOnTag ( level._effect[level.boat_left_effect[i]], self, level.boat_left_tag[i] );
		if (level.boat_left_effect[i] == "metal")
			thread playSoundOnTag(level.scr_sound ["bullet impact canvas"], level.boat_left_tag[i]);
		else
			thread playSoundOnTag(level.scr_sound ["exaggerated flesh impact"], level.boat_left_tag[i]);
		wait (0.1);
	}
}

setup_boatguys()
{
	level.voiceoverguys = [];
	if (getcvar ("scr_stalingrad_fast") == "1")
		level.fastMap = true;
	else
		level.fastMap = false;


	tag = "tag_groupA";
	guy = [];
	for (i=0;i<3;i++)
	{
		newguy = spawn ("script_model", (0,0,0));
		guy[guy.size] = newguy;

		if (i==0)
			guy[i].animname = "groupA_guy01";
		if (i==1)
			guy[i].animname = "groupA_guy02";
		if (i==2)
			guy[i].animname = "groupA_guy03";
	}
	thread groupA(guy, tag, false);
	

	maxguys = 2;
	if (level.fastMap)
		maxguys = 1;

	for (p=0;p<2;p++)
	{
		if (p==0)
			tag = "tag_groupA01";
		if (p==1)
			tag = "TAG_groupA02";
	
		guy = [];
		for (i=0;i<3;i++)
		{
			newguy = spawn ("script_model", (0,0,0));
			guy[guy.size] = newguy;
	
			if (i==0)
			{
				guy[i].animname = "groupA_guy01_back";
				guy[i].fastDelete = true;
			}
			if (i==1)
				guy[i].animname = "groupA_guy02_back";
			if (i==2)
			{
				guy[i].animname = "groupA_guy03_back";
				guy[i].fastDelete = true;
			}
		}
	
		thread groupA(guy, tag, p >= maxguys);
	}

	maxguys = 6;
	if (level.fastMap)
		maxguys = 4;

	if ((getcvar ("see") == "") || (getcvar ("see") == "groupc"))
	for (p=0;p<6;p++)
	{
		if (p==0)
			tag = "tag_groupc";
		if (p==1)
			tag = "TAG_groupc01";
		if (p==2)
			tag = "TAG_groupc02";
		if (p==3)
			tag = "tag_groupc03";
		if (p==4)
			tag = "TAG_groupc04";
		if (p==5)
			tag = "TAG_groupc05";

		guy = [];
		for (i=0;i<3;i++)
		{
			newguy = spawn ("script_model", (0,0,0));
			guy[guy.size] = newguy;

			if (i==0)
				guy[i].animname = "groupC_guy01";
			if (i==1)
			{
				guy[i].animname = "groupC_guy02";
				guy[i].fastDelete = true;
			}
			if (i==2)
			{
				guy[i].animname = "groupC_guy03";
				guy[i].fastDelete = true;
			}
		}

		thread groupc(guy, tag, p >= maxguys);
	}

	maxguys = 6;
	if (level.fastMap)
		maxguys = 3;

	for (p=0;p<6;p++)
	{
		if (p==0)
			tag = "tag_groupd";
		if (p==1)
			tag = "TAG_groupd01";
		if (p==2)
			tag = "TAG_groupd02";
		if (p==3)
			tag = "tag_groupd03";
		if (p==4)
			tag = "TAG_groupd04";
		if (p==5)
			tag = "TAG_groupd05";

		guy = [];
		for (i=0;i<1;i++)
		{
			newguy = spawn ("script_model", (0,0,0));
			guy[guy.size] = newguy;

			if (i==0)
				guy[i].animname = "groupD_guy01";
		}
		
		thread groupd(guy, tag, p >= maxguys);
	}

	for (p=0;p<2;p++)
	{
		if (p==0)
			tag = "tag_groupe";
		if (p==1)
			tag = "TAG_groupe01";

		guy = [];
		for (i=0;i<3;i++)
		{
			newguy = spawn ("script_model", (0,0,0));
			guy[guy.size] = newguy;

			if (i==0)
				guy[i].animname = "groupE_guy01";
			if (i==1)
				guy[i].animname = "groupE_guy02";
			if (i==2)
			{
				guy[i].animname = "groupE_guy03";
				guy[i].fastDelete = true;
			}
		}

		thread groupE(guy, tag);
	}

	tag = "tag_pistolguy";
	guy = [];
	newguy = spawn ("script_model", (0,0,0));
	guy[guy.size] = newguy;
	guy[0].animname = "pistolguy";
	thread pistolguy(guy, tag);

	tag = "TAG_jumpguy";
	guy = [];
	newguy = spawn ("script_model", (0,0,0));
	guy[guy.size] = newguy;
	guy[0].animname = "groupB_jumpguy";
	thread jumper(guy, tag);

	tag = "TAG_jumpguy01";
	guy = [];
	newguy = spawn ("script_model", (0,0,0));
	guy[guy.size] = newguy;
	guy[0].animname = "back_jumpguy";
	thread jumper(guy, tag);

	maxguys = 3;
	if (level.fastMap)
		maxguys = 2;

	for (p=0;p<3;p++)
	{
		if (p==0)
			tag = "TAG_officerA";
		if (p==1)
			tag = "TAG_officerA01";
		if (p==2)
			tag = "TAG_officerA02";

		guy = [];
		for (i=0;i<1;i++)
		{
			newguy = spawn ("script_model", (0,0,0));
			guy[guy.size] = newguy;

			if (i==0)
				guy[i].animname = "officerA";
		}

		thread officerA(guy, tag, p >= maxguys);
	}

	for (p=0;p<2;p++)
	{
		if (p==0)
			tag = "TAG_officerB";
		if (p==1)
			tag = "TAG_officerB01";

		guy = [];
		for (i=0;i<1;i++)
		{
			newguy = spawn ("script_model", (0,0,0));
			guy[guy.size] = newguy;

			if (i==0)
				guy[i].animname = "officerB";
		}

		thread officerB(guy, tag);
	}

	tag = "TAG_officerC";
	guy = [];
	newguy = spawn ("script_model", (0,0,0));
	guy[guy.size] = newguy;
	guy[0].animname = "officerC";
	thread officerB(guy, tag);

	tag = "tag_ppshguy";
	guy = [];
	newguy = spawn ("script_model", (0,0,0));
	guy[guy.size] = newguy;
	guy[0].animname = "ppshguy";
	thread ppsh(guy, tag);

	tag = "tag_shoutguy";
	guy = [];
	newguy = spawn ("script_model", (0,0,0));
	guy[guy.size] = newguy;
	guy[0].animname = "shoutguy";
	thread shout(guy, tag);
}

spawn_linker (model, tag, animname)
{
	spawn = spawn ("script_model", (0,0,0));
	level thread add_totalguys(spawn);
	spawn.animname = animname;
	if (isdefined (level.scr_character[spawn.animname]))
	{
		spawn character\_utility::new();
		spawn [[level.scr_character[spawn.animname]]]();
	}
	spawn UseAnimTree(level.scr_animtree[spawn.animname]);
	spawn setmodel (model);

	guy[0] = spawn;
//	level notify ("stop boatguy anims");
	org = self gettagOrigin (tag);
	ang = self gettagAngles (tag);
	spawn.origin = (org);
	spawn.angles = (ang);
	spawn linkto (self, tag);
	self thread anim_loop(guy, "idle", tag, "stop anim");
	thread spawn_explode_guys (spawn);
	thread spawn_delete_guys (spawn);
}

spawn_explode_guys (spawn)
{
	self endon ("delete guys");
	self waittill ("explode guys");
	self notify ("stop anim");
//	println (spawn.animname);
	guy[0] = spawn;
	spawn thread anim_loop( guy, "explode death", undefined, "death" );
//	spawn animscripted("scriptedanimdone", spawn.origin, spawn.angles,
//	random (level.scr_anim[spawn.animname]["explode_death"]);
	spawn unlink();
	org = spawn ("script_origin",(0,0,0));
	org.origin = spawn.origin;
	org.angles = spawn.angles;
	spawn linkto (org);
	spawn setmodel ("xmodel/character_soviet_overcoat");
	spawn lockLightVis();
	num = 900;
	org moveGravity (((randomfloat(num) - num/2), (randomfloat(num) - num/2), (randomfloat(num*2) - num)), 12);
	org rotateyaw (2000, 8);
	wait (8);
	org delete();
	spawn delete();
}

spawn_delete_guys (spawn)
{
	self endon ("explode guys");
	self waittill ("delete guys");
	self notify ("stop anim");

//	wait (randomfloat (20));
	spawn delete();
}

orgprint()
{
	while (1)
	{
		println (self.origin);
		wait (1);
	}
}

#using_animtree("barge");
barge_dies()
{
	if (getcvar ("start") == "docks")
	{
		self delete();
		return;
	}

	path = getVehicleNode (self.target,"targetname");

	while (isdefined (path.target))
	{
		lastpath = path;
		path = getVehicleNode (path.target,"targetname");
		if (!isdefined (path))
			break;
	}

/*
BONE 9 2 "TAG_groupA"
BONE 10 2 "TAG_groupA01"
BONE 11 2 "TAG_groupA02"
BONE 12 2 "TAG_groupC"
BONE 13 2 "TAG_groupC01"
BONE 14 2 "TAG_groupC02"
BONE 15 2 "TAG_groupC03"
BONE 16 2 "TAG_groupC04"
BONE 17 2 "TAG_groupC05"
BONE 18 2 "TAG_groupD"
BONE 19 2 "TAG_groupD01"
BONE 20 2 "TAG_groupD02"
BONE 21 2 "TAG_groupD03"
BONE 22 2 "TAG_groupD04"
BONE 23 2 "TAG_groupD05"
BONE 24 2 "TAG_groupE"
BONE 25 2 "TAG_groupE01"
*/
	if (getcvar ("scr_stalingrad_fast") != "1")
	{
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupD03", "groupD_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupA02", "groupA_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupC05", "groupC_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupC02", "groupC_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupD02", "groupD_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupD05", "groupD_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupC03", "groupC_guy01");
		thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupE01", "groupE_guy01");
	}
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupA", "groupA_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupA01", "groupA_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupC", "groupC_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupC01", "groupC_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupC04", "groupC_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupD", "groupD_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupD01", "groupD_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupD04", "groupD_guy01");
	thread spawn_linker ("xmodel/character_soviet_overcoat_torso", "TAG_groupE", "groupE_guy01");

	thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerA", "officerA");
//	thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerA01", "officerA");
	thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerA02", "officerA");
//	thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerB", "officerB");
	thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerB01", "officerB");
//	thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerC", "officerC");

	self UseAnimTree(#animtree);
	self setAnimKnob( %barge_boatanim_sway);
	path = getVehicleNode (self.target,"targetname");
	self attachPath( path );
	if (isdefined (self.script_delay))
		wait (self.script_delay);

//	wait (14);
	self startPath();
//	self waittill ("reached_end_node");
	self setwaitnode( lastpath );
	self waittill ("reached_wait_node");
	self playsound ("mortar_incoming", "sounddone", true);
	self waittill ("sounddone");
	self notify ("explode guys");
	playfx ( level._effect["waterhit"], self.origin + (0,0,-64) );
	self playsound ("mortar_explosion_water_new");
	println ("SINKING A DEATH SHIP");
	sink();
}

barge_lives()
{
	println ("classname ", self.classname);
	if (self.origin == (-5993, -14491, -101))
		self.script_delay = 110;
	else
		println ("origin was ", self.origin);


	path = getVehicleNode (self.target,"targetname");
	self UseAnimTree(#animtree);
	self setAnimKnob( %barge_boatanim_sway);
	self attachPath( path );
	if (isdefined (self.script_delay))
		wait (self.script_delay);

	self startPath();
}

tug_dies()
{
	if (getcvar ("start") == "docks")
	{
		self delete();
		return;
	}

	path = getVehicleNode (self.target,"targetname");

	while (isdefined (path.target))
	{
		lastpath = path;
		path = getVehicleNode (path.target,"targetname");
		if (!isdefined (path))
			break;
	}

	self UseAnimTree(#animtree);
//	self tugboat_effects();
	self setAnimKnob( %barge_boatanim_sway);
	path = getVehicleNode (self.target,"targetname");
	self attachPath( path );
	if (isdefined (self.script_delay))
		wait (self.script_delay);
//	wait (15);
	self startPath();
	thread playLoopSoundOnTag(level.scr_sound ["tugboat movement"]);
//	self waittill ("reached_end_node");
	self setwaitnode( lastpath );
	self waittill ("reached_wait_node");
	self playsound ("mortar_incoming", "sounddone", true);
	self waittill ("sounddone");
	self notify ("stop sound" + level.scr_sound ["tugboat movement"]);

	playfx ( level._effect["waterhit"], self.origin + (0,0,-64) );
	self playsound ("mortar_explosion_water_new");
	println ("SINKING A DEATH SHIP");
	sink();
}

plane_attack_damage()
{
	wait (96.6);
	if (level.player getstance() == "stand")
		level.player DoDamage ( 45, (0,0,0) );
	wait (1.4);

	for (i=0;i<35;i++)
	{
		if (level.player getstance() != "stand")
			continue;

		level.player DoDamage ( 35, (0,0,0) );
		wait (0.05);
	}
}

barge_trip()
{
	if (getcvar ("start") == "mg42")
	{
		level notify ("mg42 attack");
		level.player setorigin ( (464, -2096, 0) );
		return;
	}

	if (getcvar ("start") == "docks")
	{
		maps\_utility::array_thread(getnodearray( "commissar", "targetname" ), ::dock_commissar_think);
		maps\_utility::array_thread(getentarray( "stretcher", "targetname" ), ::stretcher_think);
		maps\_utility::array_levelthread(getvehiclenodearray ("boat_comes","targetname"), ::boat_comes_goes);

		dockguys = getentarray ("dockguys","targetname");
		for (i=0;i<dockguys.size;i++)
			dockguys[i] delete();

		level thread truckguy1_think();
		level thread truckguy2_think();
		level thread truckguy3_think();
		level thread crateguy_think();

		level notify ("boat ride finishing");

		level.player setorigin ( (164, -2096, 0) );

		wait (2);
		level notify ("boat explodes");
		maps\_utility::array_levelthread(getentarray( "floating_body", "targetname" ), ::floating_body_think);
		self delete();
		return;
	}

	thread flag_guy();
	thread crate_farshore();
	level.player_barge = self;
	path = getVehicleNode (self.target,"targetname");
	self attachPath( path );

	level.player.origin = self getTagOrigin ("tag_player");
	if (getcvar("camera") != "on")
		level.player linkto (self, "tag_player");


	setup_boatguys();
	dockguys = getentarray ("dockguys","targetname");
	for (i=0;i<dockguys.size;i++)
	{
		dockguys[i].hasWeapon = false;
		dockguys[i] allowedStances ("crouch");
	}

	wait (0.5);
	maps\_utility::set_ambient ("water");

	wait (4); // was 10

	self UseAnimTree(#animtree);
	self setAnimKnob( %barge_boatanim_sway);

	self startPath();

	timer = gettime();
	thread stopwatch();
	thread plane_strafe1();
	thread plane_strafe2();
	thread stopboat();
	thread secondhalf(timer);
	thread lastthird(timer);
	thread plane_attack_damage();

	if (getcvar ("see") == "") // No voiceovers if you're debugging a specific set of boatguys.
		start_voiceovers ();

	getent ("explosive_tugboat", "targetname") thread explosive_tugboat();

//	maps\_utility::array_thread(dockguys, ::dockguy_think);
	wait (2);
	wait (4);

	println ("^bthreaded splash ", gettime() - timer);
	thread splash();

	level waittill ("tugboat destroyed");
	for (i=0;i<dockguys.size;i++)
		dockguys[i] delete();

	println ("^btimer2 is ", gettime() - timer);
//	wait (0.5);
//	level notify ("duck");
//	self setFlaggedAnimRestart("animdone", %barge_boatanim_bigmortar_left, 1.0);
}

dockguy_think ()
{
	self.goalradius = 0;
	node = getnode (self.target,"targetname");
	org = self.origin;
	while (1)
	{
		self setgoalnode (node);
		self waittill ("goal");
		wait (randomfloat (2));
		self setgoalpos (org);
		self waittill ("goal");
		wait (randomfloat (2));
	}
}


stopboat()
{
	wait (132.200);
	level notify ("stop player boat");
}


secondhalf(timer)
{
//	wait (30.75);

//	wait (38.5);
//	println ("get ready...");
//	wait (12);
	lastnode = getVehicleNode ("auto402","targetname");
	self setwaitnode( lastnode );
	self waittill ("reached_wait_node");
	level notify ("reached second node");
	level notify ("start planes 0");
	wait (6);
	level notify ("start planes 1");
	wait (3.2);
	level.player playsound ("conscript1_line20"); // look out
	level notify ("stuka0");
	wait (7); // was 7
	level notify ("stuka1");
	level notify ("start planes 2");
	wait (7);
	level notify ("init explode boat");
	level.player playsound ("conscript2_line22"); // they're coming back
	wait (1);
	level notify ("stuka");
	wait (4.5);

	level notify ("stoplarge" + 0);

	level notify ("boat ride finishing");

	wait (1.5);
	level notify ("jump");
	println ("jump time ", timer);
}

lastthird(timer)
{
	level waittill ("reached second node");
	maps\_utility::array_levelthread(getvehiclenodearray ("boat_comes","targetname"), ::boat_comes_goes);
	lastnode = getVehicleNode ("auto403","targetname");
	self setwaitnode( lastnode );
	self waittill ("reached_wait_node");

	// Start dock commissars
	maps\_utility::array_thread(getnodearray( "commissar", "targetname" ), ::dock_commissar_think);
	maps\_utility::array_thread(getentarray( "stretcher", "targetname" ), ::stretcher_think);

	wait (1.7);
	wait (11); // change time here
	maps\_utility::autosave(1);
	wait (3); // change time here
	level notify ("start explode boat");
	thread explode_boats(timer);
	thread truckguy1_think();
	thread truckguy2_think();
	thread truckguy3_think();
	level thread crateguy_think();

	level waittill ("stop player boat");
	level notify ("climb");

	thread player_exit();

	level notify ("climb");

	level waittill ("boat explodes");
	maps\_utility::array_levelthread(getentarray( "floating_body", "targetname" ), ::floating_body_think);

	println ("^btimer4 is ", gettime() - timer);
	level notify ("dropper");

	self playsound (level.scr_sound ["boat explosion"]);
	playfx (level._effect["barge_explosion"], self.origin);
	wait (0.25);
	thread looping_effect("froth");
	self hide();
	boat = spawn ("script_model",(0,0,0));
	boat UseAnimTree(#animtree);
	boat.origin = self.origin;
	boat.angles = self.angles;
	boat setmodel ("xmodel/vehicle_russian_barge_demolished");
	boat setAnimKnob( %russian_barge_d_sink);
	boat thread looping_tag_effect ("sinking boat smoke", "TAG_SMOKE");
	boat thread looping_tag_effect ("sinking boat smoke", "TAG_SMOKE01");

	wait (20);
	self delete();
	boat delete();
}

explode_boats(timer)
{
	splash = getent ("explode_splash","targetname");
	waits[0] = 0;
	waits[1] = 5;
	waits[2] = 7.5;
	waits[3] = 0.8; // 3.3

	i = 0;
	while (1)
	{
		wait (waits[i]);
		i++;
		println ("^bexplode_Boats timer ", i, " ", gettime() - timer);

		if (i == 3)
			thread incoming_explodeboat_sound(splash, 1, "waterhit", "destroy explode boat");
		else
		if (i == 4)
			thread incoming_explodeboat_sound(splash, 3, "waterhit"); // , "boat explodes");
		else
			thread incoming_explodeboat_sound(splash, undefined, "waterhit");

		if (!isdefined (splash.target))
			break;

		splash = getent (splash.target,"targetname");
	}
}

incoming_explodeboat_sound(splash, soundnum, effect, msg)
{
	if (isdefined (soundnum))
		splash playsound ("mortar_incoming" + soundnum + "_new", "sounddone");
	else
		splash playsound ("mortar_incoming", "sounddone", true);

	level.mortar_origin = splash.origin;
	level notify ("duck event: incoming mortar");

	splash waittill ("sounddone");
	if (isdefined (effect))
		playfx ( level._effect[effect], splash.origin + (0,0,-64) );

	level.mortar_origin = splash.origin;
	level notify ("duck event: mortar hit");

	splash playsound ("mortar_explosion_water_new");
	if (isdefined (msg))
		level notify (msg);
}

looping_tag_effect (effect, tag)
{
	self endon ("death");
	if (isdefined (level._effect_rate [effect]))
		rate = level._effect_rate [effect];
	else
		rate = 1;

	while (1)
	{
		playfxOnTag ( level._effect[effect], self, tag );
		wait (rate);
	}
}

looping_effect (effect)
{
	self endon ("death");
	if (isdefined (level._effect_rate [effect]))
		rate = level._effect_rate [effect];
	else
		rate = 1;

	while (1)
	{
		playfx (level._effect[effect], self.origin + (randomfloat(300) - 150, randomfloat(300) - 150, 0), (0,0,1));
		wait (rate);
	}
}

boat_shake()
{
	if (!isdefined (level.player_barge))
		return;

	dist = distance (self.origin, level.player_barge.origin);
	if (dist > 2000)
		return;

	wait (dist / 1400);

	if (!isdefined (level.player_barge))
		return;

	if (self.origin[0] > level.player_barge.origin[0])
		level.player_barge setFlaggedAnimRestart("animdone", %barge_boatanim_bigmortar_right, 1.0);
	else
		level.player_barge setFlaggedAnimRestart("animdone", %barge_boatanim_bigmortar_left, 1.0);

	level notify ("duck");
}

error (msg)
{
	maps\_utility::error (msg);
}

floating_body_think (owner)
{
	floater = spawn ("script_model",(0,0,0));
	floater.origin = owner.origin;
	floater.angles = owner.angles;

	floater.animname = ("floater" + (randomint(4) + 1));
	floater UseAnimTree(level.scr_animtree[floater.animname]);
//	floater setmodel ("xmodel/character_soviet_overcoat");
	floater character\_utility::new();
	floater [[level.scr_character[floater.animname]]]();

	guy[0] = floater;
	floater linkto (owner);
	floater thread anim_loop(guy, "idle", undefined, undefined, owner);
	wait (15 + randomfloat (10));
	owner moveto (owner.origin + (0,0,-60), 5, 5);
	wait (5);
	floater delete();
	owner delete();
}

playExtraSound (alias)
{
	ent = spawn ("script_origin",(0,0,0));
	ent.origin = self.origin;
	ent linkto (self);
	ent thread playSoundDelete (alias);
}

playSoundDelete (alias)
{
	self playsound (alias, "sounddone");
	self waittill ("sounddone");
	self delete();
}

sink ()
{
	thread boat_shake();
	self playsound (level.scr_sound ["boat explosion"]);
	self playExtraSound (level.scr_sound ["boat sinking"]);

	playfx (level._effect["new boat explosion"], self.origin);
	wait (0.35);
	playfx (level._effect["barge_explosion"], self.origin + (0,300,0));
	wait (0.15);
	playfx (level._effect["new boat explosion"], self.origin + (50,-300,0));
	wait (0.25);
	playfx (level._effect["barge_explosion"], self.origin + (50,-50,50));
	wait (0.15);
	if ((self.model == "xmodel/vehicle_russian_barge") ||
		(self.model == "xmodel/vehicle_russian_barge_lowdetail"))
	{
		self setmodel ("xmodel/vehicle_russian_barge_demolished");
		self setAnimKnob( %russian_barge_d_sink);
		thread looping_tag_effect ("sinking boat smoke", "TAG_SMOKE01");
	}
	else
	if ((self.model == "xmodel/vehicle_russian_tugboat") ||
		(self.model == "xmodel/vehicle_russian_tugboat_low"))
	{
		self setmodel ("xmodel/vehicle_russian_tugboat_d");
		self setAnimKnobRestart( %russian_tugboat_d_sink);
	}

	thread looping_effect("froth");
	thread looping_tag_effect ("sinking boat smoke", "TAG_SMOKE");
	wait (28);
	self delete();
}


player_exit ()
{
	wait (1);
	/*
	model = spawn ("script_model",(0,0,0));
	model setmodel ("xmodel/vehicle_russian_barge");
	model hide();
	model.origin = self.origin;
	model.angles = self.angles;
	model linkto (self, "tag_origin",(0,0,0),(0,0,0));	
	level.player linkto (model, "tag_player");
	model UseAnimTree(#animtree);
	model setflaggedAnimKnob( "finished", %barge_boatanim_player_exit);
	*/
	self setflaggedAnimKnob( "finished", %barge_boatanim_player_exit);
	self waittill ("finished",notetrack);
//	model unlink();
	println ("notetrack was ", notetrack);
	level notify ("boat explodes");
	
//	model waittill ("finished",notetrack);
//	model delete();
	self waittill ("finished",notetrack);
	println ("Unlinking on notetrack ", notetrack);
//	if (getcvar ("start") == "start")
//		level.player shellshock("default", 2.5);
	level.player unlink();
	maps\_shellshock::main (7);
	level.player setVelocity((-400,0,100));

	self waittill ("finished",notetrack);
	level.player allowLeanLeft(true);
	level.player allowLeanRight(true);
	

	objective_add(1, "active", &"STALINGRAD_OBJ1", (-128, -1880, -8));
	objective_current(1);

//	wait (4);
}

bobber()
{
	self delete();
	return;

	wait (randomfloat (1.5));
	org = self.origin;
	timer = 1.1;
	while (1)
	{
		self moveto (org + (0,0,3), timer, timer*0.5, timer*0.5);
		wait (timer);
		self moveto (org + (0,0,-8), timer, timer*0.5, timer*0.5);
		wait (timer);
	}
}

spawngun (plane, tag)
{
	gun = spawn ("misc_mg42",(0,0,0));
	gun.origin = plane gettagorigin (tag);
	gun.angles = plane gettagangles (tag);
	gun linkto (plane);
}

play_mg42effect (tag)
{

	org = self gettagorigin (tag);
	angles = self gettagangles (tag);

	playfx ( level.mg42_effect, org, angles );
	println ("playing effect at origin ", org, " angles ", angles);
//	angles = anglesToForward (angles);
//	dest = maps\_utility::vectorScale (angles, 100);
//	self magicbullet ("mp40", org, (org + dest));
}

create_squib (script_plane, trace, start_time)
{
	if ((!isdefined (level.plane_squib)) || (!isdefined (level.plane_squib [script_plane])))
	{
		level.plane_squib[script_plane][0] = spawnstruct();
		level.plane_squib[script_plane][0].delay = gettime() - start_time;
		level.plane_squib[script_plane][0].origin = trace["position"];
		level.plane_squib[script_plane][0].surface = trace["surfacetype"];
	}
	else
	{
		num = level.plane_squib[script_plane].size;
		level.plane_squib[script_plane][num] = spawnstruct();
		level.plane_squib[script_plane][num].delay = gettime() - start_time;
		level.plane_squib[script_plane][num].origin = trace["position"];
		level.plane_squib[script_plane][num].surface = trace["surfacetype"];
	}

	if ((level.player getstance() == "stand") || (trace["surfacetype"] != "water"))
		plane_shot (trace["position"]);

//	level.mortar[randomint (level.mortar.size)]
	playfx (level._effect["stuka dirt"] , trace["position"]);
}

temp()
{
	org = spawn ("script_origin",(0,0,0));
	org.origin = level.player.origin;
	org linkto(level.player);

	while (1)
	{
//		playfx ( level.mg42_effect, ((level.player getorigin()) + (0,200,32)));
		org playsound ("mortar_incoming", "sounddone", true);
		org waittill ("sounddone");
	}
}

shoot_mg42s(start_time, script_plane)
{
	self notify ("stop mg42s");
	self endon ("stop mg42s");

	timer = 0;
	counts = 0;

//	if ((!isdefined (level.plane_squib)) || (!isdefined (level.plane_squib [script_plane])))
	if (getcvar ("squib") == "on")
		squib = true;
	else
		squib = false;

//	thread playLoopSoundOnTag(level.scr_sound ["stuka gun loop"]);

	lnext = 0;
	rnext = 0;
	while (1)
	{
//		thread play_mg42effect ("tag_gunLeft");
//		thread play_mg42effect ("tag_gunRight");

/*
		if (gettime() > timer)
		{
			println ("counts is ", counts);
			counters = 0;
			timer = gettime() + 1000;
		}
*/

//		ang = anglesToForward (self gettagangles("tag_gunRight"));
		ang = anglesToForward (self.angles);
		ang = maps\_utility::vectorScale(ang, 5000);
//		org = self gettagorigin("tag_gunLeft");
//		line (org, org + ang, (1,0.2,0.3), 0.75);

		lnext--;
		if (lnext <= 0)
		{
			lnext = randomint (5);

			if (squib)
			{
				org = self gettagorigin("tag_gunLeft");
//				magicbullet ("mp40", org, (org + ang));
				trace = bulletTrace(org, org + ang, false, undefined);
				if (trace["fraction"] < 1.0)
				{
					create_squib (script_plane, trace, start_time);
					if (isdefined (trace["entity"]))
						line (org, trace["position"], (1,0.2,0.3), 0.5);
					else
						line (org, trace["position"], (0.3,0.2,1.0), 0.5);
				}
			}

			playfxOnTag ( level.mg42_effect, self, "tag_gunLeft" );
			playfxOnTag ( level.mg42_effect2, self, "tag_gunLeft" );

//			self playsound ("airplane_guns");

			org = self gettagorigin("tag_gunLeft");
			bulletTracer(org, org + ang);
		}

		rnext--;
		if (rnext <= 0)
		{
			rnext = randomint (5);

			if (squib)
			{
				org = self gettagorigin("tag_gunRight");
//				magicbullet ("mp40", org, (org + ang));
				trace = bulletTrace(org, org + ang, false, undefined);
				if (trace["fraction"] < 1.0)
				{
					create_squib (script_plane, trace, start_time);
					if (isdefined (trace["entity"]))
						line (org, trace["position"], (1,0.2,0.3), 0.5);
					else
						line (org, trace["position"], (0.3,0.2,1.0), 0.5);
				}
			}
			playfxOnTag ( level.mg42_effect, self, "tag_gunRight" );
			playfxOnTag ( level.mg42_effect2, self, "tag_gunRight" );
//			self playsound ("airplane_guns");

			org = self gettagorigin("tag_gunRight");
			bulletTracer(org, org + ang);
		}

		wait (0.05);
	}
}


squib_think ( num, i )
{
	wait (level.plane_squib[num][i]["delay"] * 0.001);
	if (level.plane_squib[num][i]["surface"] == "water")
	{
		playfx ( level._effect["stuka water hit"], level.plane_squib[num][i]["origin"]);
		return;
	}
	else
		playfx ( level._effect["stuka dirt"], level.plane_squib[num][i]["origin"]);

//	radiusDamage (vec origin, float range, float max_damage, float min_damage);
//	radiusDamage ( level.plane_squib[num][i]["origin"], 60, 100, 100);
	plane_shot (level.plane_squib[num][i]["origin"]);
}

plane_shot (org)
{
	radiusDamage ( org, 100, 100, 100);
}

fire_squibs( num )
{
	for (i=0;i<level.plane_squib[num].size;i++)
		thread squib_think (num, i);
}

orgthread()
{
	while (1)
	{
		println (self.origin);
		wait (0.5);
	}
}

plane_quake()
{
	while (1)
	{
		earthquake(0.35, 0.5, self.origin, 1450); // scale duration source radius
		wait (0.05);
	}
}

airplane_think ()
{
	if (!isdefined (self.target))
		return;

	level.last_planesound[self.script_plane] = 0;

	path = self;
	if (!isdefined (self.script_plane))
	{
		if (isdefined (self.script_delay))
			wait (self.script_delay);
	}

//	nextnode = getvehiclenode (path.target,"targetname");
//	if (!isdefined (nextnode))
//		maps\_utility::error ("no node");

	while (1)
	{
		level waittill ("start planes " + self.script_plane);
		if (isdefined (self.script_delay))
			wait (self.script_delay);

		self thread plane_flight(path);
	}

/*
	if (randomint (100) > 50)
		sound = "c47_flyby1";
	else
		sound = "c47_flyby2";

	airsounds= getentarray ("airsound","targetname");
	for (i=0;i<airsounds.size;i++)
	{
		org = spawn ("script_origin", (0,0,0));
		org.origin = airsounds[i].origin;
		org thread do_sound (sound);
	}
	thread planedie (plane);
	wait (14);
	plane notify ("die");
	plane delete();
	self delete();
*/
}



plane_flight (path)
{
	level.activeVehicles++;
//	println ("^5 vehicles: ", 	level.activeVehicles);
	nextnode = getvehiclenode (path.target,"targetname");
	plane = spawnVehicle( "xmodel/vehicle_plane_stuka_lowdetail", "plane", "C47", (0,0,0), (0,0,0) );

	plane attachPath( path );
	plane startPath();
	plane thread plane_quake();

	starttime = gettime();
	if (self.script_plane == 5)
	{
		org = spawn ("script_model",(0,0,0));
		org linkto (plane, "Box02", (1000,0,0),(0,0,0));
		level.global_target = org;
	}

	if (gettime() > level.last_planesound[self.script_plane])
	{
		level.last_planesound[self.script_plane] = gettime() + 4000;;
		plane playsound (level.scr_sound["plane" + self.script_plane]);
	}

	start_time = gettime();

	if (getcvar("squib") == "0")
	if ((isdefined (level.plane_squib)) && (isdefined (level.plane_squib[self.script_plane])))
		fire_squibs (self.script_plane);

	earthquake = false;
	while (isdefined (nextnode.target))
	{
		plane setWaitNode (nextnode);

		plane waittill ("reached_wait_node");

		if (isdefined (nextnode.script_noteworthy))
		{
			if (nextnode.script_noteworthy == "start_firing")
				plane thread shoot_mg42s(start_time, self.script_plane);

			if (nextnode.script_noteworthy == "stop_firing")
			{
				plane notify ("stop mg42s");
				plane notify ("stop sound" + level.scr_sound["stuka gun loop"]);
//				println ("^aStopped plane ", self.script_plane, " gun loop after ", gettime() - starttime, " milliseconds");
			}

			if (nextnode.script_noteworthy == "start_smoking")
			{
				plane thread plane_smoke();
				thread playSoundinSpace (level.scr_sound ["Stuka hit"], plane.origin);
			}
		}
		nextnode = getvehiclenode (nextnode.target,"targetname");

		if (isdefined (nextnode.script_explode))
			earthquake = nextnode.script_explode;
	}


	plane notify ("stop mg42s");
	plane waittill ("reached_end_node");

	if (earthquake)
	{
		maps\_utility::exploder (earthquake);
		thread wait_quake (0.25, 1, 1, plane.origin, 35500);
		thread playSoundinSpace (level.scr_sound ["Stuka explosion"], plane.origin);
	}

	level.activeVehicles--;
	plane delete();
	if (isdefined (org))
		org delete();
}

wait_quake (delay, num1, num2, org, num3)
{
	wait (delay);
	earthquake(num1, num2, org, num3); // scale duration source radius
}

playSoundinSpace (alias, origin)
{
	org = spawn ("script_origin",(0,0,1));
	org.origin = origin;
	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}


print_org(org, org2)
{
	while ((isdefined (org)) && (isdefined (org2)))
	{
		println ("First: ", org.origin, " Second: ", org2.origin);
		wait (0.05);
	}
	if (!isdefined (org))
		println ("org is undefined");
	if (!isdefined (org2))
		println ("org2 is undefined");
}

plane_smoke()
{
	while (1)
	{
		playfxOnTag ( level._effect["flameout"], self, "tag_engine_left" );
		wait (randomfloat (0.2));
		playfxOnTag ( level._effect["flameout"], self, "tag_engine_right" );
		wait (randomfloat (0.4));
	}
}

boat_comes_goes (path)
{
	if ((path.script_noteworthy == "right") && (getcvar ("scr_stalingrad_fast") == "1"))
		return;
		
	endpath = getvehiclenodearray ("boat_goes","targetname");
	for (i=0;i<endpath.size;i++)
	{
		if (endpath[i].script_noteworthy == path.script_noteworthy)
		{
			endpath = endpath[i];
			break;
		}
	}

	while (1)
	{
		thread boat_going_think (path, endpath);
		if (level.activeVehicles <= 22)
		if (!level.flag["boats should unload"])
			level waittill ("boats should unload");
		if (path.script_noteworthy == "right")
			wait (60);
		else
			wait (35);
	}
}

boat_going_think (path, endpath)
{
	if (level.activeVehicles > 22)
		return;
		
	level.activeVehicles++;
//	println ("^5 vehicles: ", 	level.activeVehicles);
	boat = spawnVehicle( "xmodel/vehicle_russian_barge_lowdetail", "barge", "C47", (0,0,0), (0,0,0) );
	boat attachPath( path );

	if (getcvar ("scr_stalingrad_fast") != "1")
	{
		boat thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerA01", "officerA");
		boat thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerB01", "officerB");
	}
	
	boat thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerA", "officerA");
	boat thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerA02", "officerA");
	boat thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerB", "officerB");
	boat thread spawn_linker ("xmodel/character_soviet_officer", "TAG_officerC", "officerC");

	boat startPath();
	println ("boat arrived");
	boat waittill ("reached_end_node");
	println ("boat wants to leave");
	if (!level.flag["boats should unload"])
	{
		level waittill ("boats should unload");
		wait (1.5);
	}
	println ("boat left");

	level notify ("boat unload" + path.script_noteworthy);
	wait (20);
	boat attachPath( endpath );
	boat startPath();
	boat waittill ("reached_end_node");
	boat notify ("delete guys");
	wait (0.05); // boat deletes itself before it gets its notifies
	boat delete();
	level.activeVehicles--;
}


tugboat_effects()
{
	self thread looping_tag_effect ( "bow left", "TAG_BOW_LEFT" );
	self thread looping_tag_effect ( "bow right", "TAG_BOW_RIGHT" );
	self thread looping_tag_effect ( "bow smokestack", "TAG_SMOKESTACK" );
	self thread looping_tag_effect ( "bow back", "TAG_BACK" );
//	spawn = spawn ("script_model",(0,0,0));
//	spawn setmodel ("xmodel/temp");
//	spawn linkto (self, "TAG_SMOKESTACK", (0,0,0), (0,0,0));
}

#using_animtree("barge");
explosive_tugboat()
{

/*
TAG_BOW_LEFT      (fx/tagged/tag_bow_left.efx)
TAG_BOW_RIGHT	(fx/tagged/tag_bow_right.efx)
TAG_SMOKESTACK (fx/smoke/ash_smoke.efx)	We will need to tweak this but we should get it in there.
TAG_BACK		(fx/water/em_froth.efx)  we will need to work with this one too.
*/
	self tugboat_effects();
	path = getVehicleNode (self.target,"targetname");
	self UseAnimTree(#animtree);
	self setAnimKnob( %barge_boatanim_sway);
	self attachPath( path );

	if (getcvar("scr_stalingrad_fast") != "1")
	{
		self thread spawn_linker ("xmodel/character_soviet_officer", "TAG_deckguy02", "officerB");
		self thread spawn_linker ("xmodel/character_soviet_officer", "TAG_deckguy05", "officerC");
		self thread spawn_linker ("xmodel/character_soviet_officer", "TAG_deckguy06", "officerC");
	}
	
	self thread spawn_linker ("xmodel/character_soviet_officer", "TAG_driver",    "officerA");
	self thread spawn_linker ("xmodel/character_soviet_officer", "TAG_deckguy01", "officerB");
	self thread spawn_linker ("xmodel/character_soviet_officer", "TAG_deckguy03", "officerB");
	self thread spawn_linker ("xmodel/character_soviet_officer", "TAG_deckguy04", "officerC");
	self thread spawn_linker ("xmodel/character_soviet_officer", "TAG_deckguy07", "officerA");

	wait (4);
	self startPath();
//	self playLoopSound (level.scr_sound ["tugboat Movement"]);
	thread playLoopSoundOnTag(level.scr_sound ["tugboat movement"]);
	level waittill ("tugboat destroyed");
	self notify ("stop sound" + level.scr_sound ["tugboat movement"]);
	self notify ("explode guys");
	sink();
//	playfx ( level._effect["explosion"], self.origin + (0,0,16) );
//	self delete();
}

splash ()
{
	splash = getent ("splash","targetname");
/*
	waits[0] = 5;
	waits[1] = 4.6;
	waits[2] = 5.25;
	waits[3] = 4.55;
	waits[4] = 3.0;
	waits[5] = 1.6;
*/
	waits[0] = 0;
	waits[1] = 0; // 8.6;
	waits[2] = 0; // 7.55;
	waits[3] = 22.55; // 6.4;

	waits[4]  = 9.3;
	waits[5]  = 12.3;
	waits[6]  = 12; //8.3;
	waits[7]  = 7.3;
	waits[8] = 9.3;
	waits[9] = 12.3;
	waits[10] = 5.3;
	waits[11] = 9.3;
	waits[12] = 12.3;
	waits[13] = 10.3;

	i = 0;
	while (1)
	{
		println ("^ddropping mortar: ", i);
		level.mortar_origin = splash.origin;
		if (isdefined (waits[i]))
			wait (waits[i]);
		else
			wait (3);

		i++;
		if ((isdefined (waits[i-1])) && (!waits[i-1]))
			continue;

		if (i == 4)
		{
			splash playsound ("mortar_incoming1_new", "sounddone");
			level.mortar_origin = splash.origin;
			level notify ("duck event: incoming mortar");
			println ("tugboat destroyed start");
			splash waittill ("sounddone");
//			wait (1);
			playfx ( level._effect["waterhit"], splash.origin + (0,0,-64) );
			level.mortar_origin = splash.origin;
			level notify ("duck event: mortar hit");
			println ("tugboat destroyed hit");
			splash playsound ("mortar_explosion_water_new");
			level notify ("tugboat destroyed");
		}
		else
			thread incoming_sound(splash, "waterhit");

		if (isdefined (splash.target))
			splash = getent (splash.target,"targetname");
		else
			return;
	}
}

incoming_sound(splash, effect)
{
	splash playsound ("mortar_incoming", "sounddone", true);
	level.mortar_origin = splash.origin;
	level notify ("duck event: incoming mortar");
	splash waittill ("sounddone");
	level.mortar_origin = splash.origin;
	level notify ("duck event: mortar hit");
	earthquake(0.3, 3, splash.origin, 850); // scale duration source radius
	if (isdefined (effect))
		playfx ( level._effect[effect], splash.origin + (0,0,-64) );

	splash playsound ("mortar_explosion_water_new");
}

squib_print()
{

	while (1)
	{
		if ((getcvar("squib") != "0") && (getcvar("squib") != "on") && (getcvar("squib") != "off"))
		{
			setcvar("squib", "0");
			println (" ---------------- Printing squib info --------------- ");
			if (isdefined (level.plane_squib))
			{
//				level.plane_squib[script_plane][num].origin = trace["position"];

				for (i=0;i<50;i++)
				{
					if (isdefined (level.plane_squib[i]))
					{
						for (p=0;p<level.plane_squib[i].size;p++)
						{
							println ("level.plane_squib[", i, "][",p,"][\"delay\"] = ", level.plane_squib[i][p].delay, ";");
							println ("level.plane_squib[", i, "][",p,"][\"origin\"] = ", level.plane_squib[i][p].origin, ";");
							println ("level.plane_squib[", i, "][",p,"][\"surface\"] = \"", level.plane_squib[i][p].surface, "\";");
						}
					}
				}
			}

			println (" ---------------- Ending squib info --------------- ");
		}
		wait (2);
	}
}

start_voiceovers()
{
	if (getcvar("scr_stalingrad_fast") != "1")
	if ((getcvar ("voiceover") == "1") || (getcvar ("voiceover") == "on"))
	{
		for (i=0;i<level.voiceoverguys.size;i++)
		{
	//		println ("time for voice over ", i);
			level.voiceoverguys[i] thread vo_number(i);
		}
	}

	if (isdefined (level._voiceover))
	{
		for (i=0;i<level._voiceover.size;i++)
		{
//			println ("doing voice over ", i, " num ", level._voiceover[i].guynum);
			level.voiceoverguys[level._voiceover[i].guynum] thread play_voiceover (level._voiceover[i].sound, level._voiceover[i].delay);
		}
	}

//	return;
	level._voiceover = undefined;
	level.voiceoverguys = undefined;
}

play_voiceover (sound, delay)
{
//	println ("Setting up voiceover guy to play alias ", sound, " after delay ", delay);
	self endon ("death");
	wait (delay);
	self playsound (sound);
}

vo_number(num)
{
	while (1)
	{
		print3d ((self.origin + (0, 0, 65)), num, (0.48,9.4,0.76), 0.85);
		wait (0.05);
	}
}

waitframe()
{
	wait (0.05);
}

playSoundOnTag (alias, tag)
{
	if ((isSentient (self)) && (!isalive (self)))
		return;

	org = spawn ("script_origin",(0,0,0));
	thread delete_on_death (org);
	if (isdefined (tag))
		org linkto (self, tag, (0,0,0), (0,0,0));
	else
	{
		org.origin = self.origin;
		org.angles = self.angles;
		org linkto (self);
	}

	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}


playLoopSoundOnTag(alias, tag)
{
	org = spawn ("script_origin",(0,0,0));
	org endon ("death");
	thread delete_on_death (org);
	if (isdefined (tag))
		org linkto (self, tag, (0,0,0), (0,0,0));
	else
	{
		org.origin = self.origin;
		org.angles = self.angles;
		org linkto (self);
	}
//	org endon ("death");
	org playloopsound (alias);
//	println ("playing loop sound ", alias," on entity at origin ", self.origin, " at ORIGIN ", org.origin);
	self waittill ("stop sound" + alias);
	org stoploopsound (alias);
	org delete();
}

delete_on_death (ent)
{
	ent endon ("death");
	self waittill ("death");
	if (isdefined (ent))
		ent delete();
}

anim_loop ( guy, anime, tag, ender, node, tag_entity )
{
	maps\_anim::anim_loop ( guy, anime, tag, ender, node, tag_entity );
}

anim_single (guy, anime, tag, node, tag_entity)
{
	maps\_anim::anim_single (guy, anime, tag, node, tag_entity);
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
