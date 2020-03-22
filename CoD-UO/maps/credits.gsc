//
//Mapname: kharkov2
//Edited by: Mike
//

// Task List:
//-------------
//
// Bastogne1
//----------
// -Jeep Rail with 2 other guys.
// -Taking out tanks with Bazooka

// Bastogne2
//------------
// -Flares for mortars

// Foy
//-----
// -Haystack Run
// -Bell Tower
// -Bridge Crossing

// Noville
//---------
// -Riding Tanks
// -Defending Chateau

// Bomber
//--------
// -Couple flybys, camera on german fighter.

// Trainbridge
//-------------
// -Flashlights
// -Bridge Explosion

// Sicily
//--------
// -LightHouse
// -Bmwbike

// Trenches
//----------
// -Mortar Barrage
// -Trench battle
// -Stuka Crash

// Ponyri
//--------
// ??????????

// Kharkov1
//----------
// -Assault
// -Radio event

// Kharkov2
//----------
// -Assault square
// -Linen Statue
// -He-111s


#using_animtree("generic_human");
main()
{
	setCullFog(500, 900 , 0.0, 0.0, 0.0, 0);
	level.mortar = loadfx ("fx/impacts/newimps/minefield_dark.efx");

	maps\_load_gmi::main();
	maps\_debug_gmi::main();
	maps\_panzeriv_gmi::main();
	maps\_truck_gmi::main();
	maps\_wood_gmi::main();
	maps\credits_fx::main();
	maps\credits_anim::main();
	maps\_mortarteam_gmi::main();
	maps\_panzerIV_gmi::main_camo();
	maps\_tank_gmi::main();
	maps\_tiger_gmi::main_camo();
	maps\credits_slideshow::main(); // thad's cool pic stuff

	// Level. section
	level.mortar_maxdist = 3000;
	level.mortar_mindist = 256;
	level.mortar_min_delay = 5;
	level.mortar_max_delay = 20;
	level.tree_num = 0;
	level.moodyanim = 0;

	level.globalTimer = 12;

	maps\_treefall_gmi::main();

	maps\_willyjeep_gmi::main();
	maps\_sherman_gmi::main();
	precacheCredits();

	// Precache Section
	precacheturret("mg42_tiger_tank");
	precachemodel("xmodel/vehicle_tank_panzeriv_machinegun");
	precachemodel("xmodel/v_us_lnd_sherman_snow");
	precachemodel("xmodel/parachute_animrig");
	precachemodel("xmodel/character_soviet_overcoat");
	precacheItem("bazooka");

	// Ambient Tracks
	level.ambient_track ["exterior"] = "ambient_credits";
	thread maps\_utility_gmi::set_ambient("exterior");

	// Weather Section
	level.atmos["snow"] = loadfx ("fx/atmosphere/snow_light.efx");
	level.atmos["rain"] = loadfx ("fx/atmosphere/rain_medium.efx");

	// level. section
	level.flag["tank arrived"] = false;	
	level.flag["credits done"] = false;	
	level.flag["ready to end"] = false;	
	level.flag["move center"] = false;
	level.flags["ender_in_jeep"] = false;	
	level.won = false;
	level.flags["breaker"] = false;

	// --- Threads --- //

	level thread checklev();
	level thread text();
	level thread Setup_Characters();
	// Setup the Trees, for bursting.
	level thread Setup_TreeBurst();

	wait 0.05;
	level thread timer();
	level thread music();
	level thread Setup_Camera();

	level thread slideshow_think();

	if(!level.check)
	{
		println("^1level.check2: ", level.check2);
		if(level.check2)
		{
			level thread GMI_Characters();
		}
		level thread endLevel();
		return;
	}

	level thread endLevel();

	level thread Setup_Player();

	wait (0.05); // Waittill the game initializes before continuing.
	level thread ai_overrides();
//	level thread tankTrigger (getent ("tank trigger","targetname"));
	array_levelthread (getentarray ("height","targetname"), ::height);
	array_levelthread (getentarray ("creditspawn","targetname"), ::creditSpawner);
	array_levelthread (getentarray ("weather","targetname"), ::Weather);
	array_levelthread (getentarray ("x_axis","targetname"), ::x_axis);
	array_levelthread (getentarray ("y_axis","targetname"), ::y_axis);
	array_levelthread (getentarray ("fog","targetname"), ::fog);

	level thread Bastogne2_Battle();
	level thread Foy_Mortar();


	level thread skip();

//	level notify ("start slideshow");
//	wait 3;
//	level thread change_pitch(10);
}

slideshow_think()
{
	level waittill ("start_now_gsc");


	println(" ^4 ********	start_now_gsc    *************");  
	level notify ("start slideshow");
	level notify ("stop falling mortars");
	level notify("stop_atmosphere");
	println(" ^4 ********	thads shit start_now_gsc    *************");


//	wait 60;
//	level.credits_playing = false;
}

Setup_Player()
{
	level.player.health = 100000;
	level.player takeallweapons();
	level.player.ignoreme = true;
//	level.ender playloopsound ("jeep_engine_high");
//	level.ender playloopsound ("shell_explosion2");
}

Setup_Camera()
{
	println("^1Got to Setup camera");
	level.player freezeControls(true);

	if(!level.check)
	{
		return;
	}

	level.camorg = spawn ("script_origin", level.player.origin + (0,0,-10));

	level.camorg thread follower (level.ender);

	level thread heightDestination();
	level thread x_axisDestination();
	level thread y_axisDestination();

	println("^1Got to Setup camera 2");

	wait (0.05);

	println("^1Got to Setup camera 3");

	level.cam_vec[0] = 0;
	level.cam_vec[1] = 90;
	level.cam_vec[2] = 0;

	level.camorg thread rotateroler();
}

Setup_Characters()
{
	level character\foley::precache();

	ender = getent ("ender","targetname");
	ender.name = "";
	ender.health = 50000;
	ender.ignoreme = true;

	if(!level.check)
	{
		return;
	}

	ender character\_utility::new();
	ender character\foley::main();
	ender setgoalpos (ender.origin);
	ender.goalradius = 32;
	ender.accuracy = 1;
	level.ender = ender;
	level thread enderThink (ender);
}

globalTimer()
{
	wait (40);
	while (level.globalTimer > 6)
	{
		level.globalTimer-= 0.05;
		wait (0.2);
	}
}

setDestHeight ()
{
	level endon ("stop set dest height");
	while (1)
	{
		level.destinationHeight	= level.ender.origin[2];
		wait (0.05);		
	}
}
	
enderThink (ender)
{
	level.jeep = getent("willyjeep1","targetname");
	level.moody = getent("driver","targetname");
	
	level thread moody_peugeot_wait();
	
	
	wait 3;
	node = getnode (ender.target,"targetname");

//	parachute = spawn_parachute();

//	if (randomint (100) > 50)
//		landing = "landing 1";
//	else
//		landing = "landing 2";
	
//	ender.animname = "ender";
//	guy[0] = ender;
//	guy[1] = parachute;
//	maps\_anim::anim_teleport (guy, "landing 2", undefined, node);
//	wait (1);
//	maps\_anim::anim_teleport (guy, "landing 2", undefined, node);
//	if (level.check)
//		anim_single (guy, "landing 2", undefined, node);

	level notify ("stop set dest height");
	
	if (level.check)
	{
		while (isdefined (node.target))
		{
			trigger = getent (node.target,"targetname");
			if (isdefined (trigger))
			{
				println ("^3 Waiting for trigger to clear");
				maps\_utility_gmi::living_ai_wait (trigger, "axis");
				println ("^3 Trigger cleared");
			}
			node = getnode (node.target,"targetname");
				
			level.enderNode = node;
			println("^5ENDER ASSIGNED NEW NODE!");
			ender setgoalnode (node);
			ender.goalradius = 32;
			waittill_either (ender, "goal", "skip");
			if (isdefined (node.script_noteworthy))
			{
				if (node.script_noteworthy == "dont stop")
				{
					if(isdefined(node.script_uniquename))
					{
						if(node.script_uniquename == "end_previously")
						{
							level notify("end_previously");
						}
					}
					continue;
				}
				
				if (node.script_noteworthy == "tank")
				{
					level thread tank_killThread();
					level waittill ("tank kilt");
				}
	
				if (node.script_noteworthy == "neutral")
				{
					ender.team = "neutral";
					continue;
				}
				
				if (node.script_noteworthy == "prone attack")
				{
					ender allowedstances ("prone");
					node = getnode (node.target,"targetname");
					ender setgoalnode (node);
					ender waittill ("goal");
					ender setgoalpos (ender.origin);
					ender.goalradius = 256;
					wait (4);
					ender allowedstances ("crouch");
					ender.team = "allies";
	//				ender.ignoreme = false;
					trigger = getent (node.target,"targetname");
					if (isdefined (trigger))
						maps\_utility_gmi::living_ai_wait (trigger, "axis");
					ender allowedstances ("prone","crouch","stand");
					continue;
				}

				if(node.script_noteworthy == "intro")
				{
					wait 1;
					println("intro_node_reached");
					level notify("intro_node_reached");
				}

				if(node.script_noteworthy == "willyjeep1")
				{
					level.jeep = getent("willyjeep1","targetname");
					ender.goalradius = 4;
					level Enter_Jeep(level.jeep);
					ender.goalradius = 32;
				}

				if(node.script_noteworthy == "panzer1")
				{
					ender.goalradius = 32;
					level Bastogne1_Panzer();
				}
			}

			if (isdefined (level.skip))
			{
				level.skip = undefined;
				continue;
			}

			if(isdefined(node.script_delay))
			{
				wait node.script_delay;
			}
			else
			{
				wait (3);
			}
		}

		offset = 0;	
		offsetter = 0;
		level.screenOverlay fadeOverTime (5);
		level.screenOverlay.alpha = 1;
	}
	else
	{
		ender setgoalpos (ender.origin);
		offset = 0;
		offsetter = 0;
	}
		
	while (1)
	{
		if (offset < 5)
		{
			offsetter++;
			if (offsetter > 5)
			{
				offset++;
				offsetter = 0;
			}
		}
		
		level.current_x_axis-=offset;
		wait (0.05);
	}

//		level.current_x_axis = 120;
}


#using_animtree("animation_rig_parachute");
spawn_parachute()
{
	parachute = spawn ("script_model",(0,0,0));
	parachute.animname = "parachute";
	parachute setmodel ("xmodel/parachute_animrig");
	parachute.animtree = #animtree;
	parachute.landing_anim = %parachute_landing_roll;
	parachute.player_anim = %player_landing_roll;
	parachute useAnimTree (parachute.animtree);
	return parachute;
}

#using_animtree("generic_human");
endLevel () // this is for the end of the level.
{
	level waittill("credits_are_over");
	flag_set ("move center");
//	level.flag["move center"] = true;
	println("^2 ************* hey the end of the level should occur now !!!!!!!!!!!!!!!!!!*********");
	wait (7);
	flag_wait ("credits done");
	wait (1);

//	if ((level.check) || (level.won))
//	{
		newStr = newHudElem();
				offsetter = 0;
	
	
//		newStr setText(&"CREDIT_NO_COWS");
		newStr.x = 320;
		newStr.y = 240;
		newStr.alignX = "center";
		newStr.alignY = "middle";
		newStr.fontScale = 1.00;
		newStr.sort = 20;
		newStr.alpha = 0;
		newStr fadeOverTime (1.5);
		newStr.alpha = 1;
		wait (3.5);
		newStr fadeOverTime (1.5);
		newStr.alpha = 0;
		wait (3);
//	}

	level.blankElement = newHudElem();
	level.blankElement.blank = true;

	wait 59;

	println("^1GAME IS DONE!!!");
	println("^1GAME IS DONE!!!");
	println("^1GAME IS DONE!!!");
	println("^1GAME IS DONE!!!");

//	setCvar("cg_deadscreen_levelname", "levelshots/level_name_text/hud@kharkov2.tga");
//	setCvar("cg_victoryscreen_levelname", "levelshots/level_name_text/hud@kharkov2.tga");
//	setCvar("cg_victoryscreen_menu","off");
	setCvar("ui_victoryquote", "@VICTORYQUOTE_THOSE_WHO_HAVE_LONG_ENJOYED");
	missionSuccess("bastogne1", false);
}

tank_killers_killThread (tank, gun_guy)
{
	tank maps\_anim_gmi::anim_single (gun_guy, "run", "tag_hatch");
	tank thread anim_loop ( gun_guy, "idle", "tag_hatch", "stop anim");
}

tank_killThread ()
{
	flag_wait ("tank arrived");

	level.ender.animname = "gun guy";
	tank = getent ("tank","targetname");
	gun_guy[0] = level.ender;
	tank thread maps\_anim_gmi::anim_reach (gun_guy, "run", "tag_hatch");

	spawner = getent ("tank killer","script_noteworthy");
	spawner waittill ("spawned",spawn);
	if (maps\_utility_gmi::spawn_failed(spawn))
		return;

	spawn.health = 50000;
	spawn.animname = "grenade guy";
	grenade_guy[0] = spawn;

 	guy[0] = gun_guy[0];
	guy[1] = grenade_guy[0];
	
	tank maps\_anim_gmi::anim_reach (gun_guy, "run", "tag_hatch");
	level thread tank_killers_killThread (tank, gun_guy);

	tank maps\_anim_gmi::anim_reach (grenade_guy, "run", "tag_hatch");
	tank thread maps\_anim_gmi::anim_single (grenade_guy, "run", "tag_hatch");
 	tank notify ("stop anim");

	tank maps\_anim_gmi::anim_reach (guy, "attack", "tag_hatch");
	tank.animname = "tank";
	tank assignanimtree();
	tank setFlaggedAnim( "single anim", level.scr_anim[tank.animname]["attack"]);
	tank thread maps\_anim_gmi::notetrack_wait (tank, "single anim", undefined, "attack");
	tank thread maps\_anim_gmi::anim_single (guy, "attack", "tag_hatch");
	level notify ("tank kilt");
	tank waittill ("attack");
	spawn setgoalnode (getnode ("flee tank","targetname"));
	tank.health = 5;
	wait (3);
	radiusDamage (tank.origin, 2, tank.health + 5000,  tank.health + 5000); // mystery numbers!
	tank notify ("death");
}
 
skip ()
{
	setcvar ("skip", "");
	while (1)
	{
		if (getcvar ("skip") != "")
		{
			org = spawn ("script_origin",(0,0,0));
			org.origin = level.ender.origin;
			level.ender linkto (org);
			org moveto (level.enderNode.origin + (0,0,70), 0.1);
			wait (0.1);
			level.skip = true;
			level.ender notify ("skip");
			org delete();
		}
		setcvar ("skip", "");
		wait (0.1);
	}
}

timer ()
{
	return;
	seconds = 0;
	minutes = 0;
	while (1)
	{
		wait (1);
		seconds++;
		if (seconds >= 60)
		{
			minutes++;
			seconds-=60;
		}
		if (seconds < 10)
			println (minutes,":0",seconds);
		else
			println (minutes,":",seconds);
	}
}

ai_overrides()
{
	spawners = getspawnerarray();
	for (i=0;i<spawners.size;i++)
		spawners[i] thread spawner_overrides();

	ai = getaiarray();
	for (i=0;i<ai.size;i++)
		ai[i].animplaybackrate = 1.0;
}

spawner_overrides()
{
	while (1)
	{
		self waittill ("spawned", spawn);
		if (maps\_utility_gmi::spawn_failed(spawn))
			continue;
	
		spawn.suppressionwait = 0.001;
		spawn.animplaybackrate = 1.0;
	}
}

music ()
{
	println("^2MusicPlay: pegasusbridge_credits");
	musicPlay("pegasusbridge_credits");
	level thread print_timer((50));
	wait (50);
	
	musicstop(3);
	wait 3.25;
	while(1)
	{
		println("^2MusicPlay: codtheme");
		musicPlay("codtheme");
		level thread print_timer(((60*5)));
		wait ((60*5)); // 5 minutes;
		musicstop(3);
		wait 3.25;
	}
}

print_timer(count)
{
	while(count > 0)
	{
		wait 1;
		count--;
		println("^2Print Timer: ",count);
	}
}

creditSpawner ( trigger )
{
	spawner = getentarray (trigger.target,"targetname");
	trigger.target = "null";
	while (1)
	{
		trigger waittill ("trigger", other);
		if (other != level.ender)
			continue;
		if ((isdefined (trigger.script_noteworthy)) && (trigger.script_noteworthy == "unkillable"))
			array_levelthread (spawner, ::creditSpawnerThink, 35000);
		else
		if ((isdefined (trigger.script_noteworthy)) && (trigger.script_noteworthy == "nohealth"))
			array_levelthread (spawner, ::creditSpawnerThink, 1);
		else
			array_levelthread (spawner, ::creditSpawnerThink, 100);
			
		trigger delete();
		return;
	}
}

creditSpawnerThink ( spawner, health )
{
	if (isdefined (spawner.script_noteworthy))
		msg = spawner.script_noteworthy;

	spawn = spawner stalingradspawn();
	if (maps\_utility_gmi::spawn_failed(spawn))
		return;
	if (spawn.team == "axis")
		level thread override(spawn);
		
	spawn endon ("override");
	spawn endon ("death");
	spawn.health = health;
	if (isdefined (msg))
	{
		msg = spawner.script_noteworthy;
		if (msg == "nohealth")
		{
			spawn.health = 1;
			spawn.accuracy = 0;
		}
		if (msg == "unseen")
		{
			spawn.ignoreme = true;
		}
	}
	
	node = spawn;
	while (isdefined (node.target))
	{
		node = getnode (node.target,"targetname");
		if (isdefined (node))
		{
			spawn setgoalnode (node);
			if (isdefined (node.radius))
				spawn.goalradius = node.radius;
			spawn waittill ("goal");
		}
		else
			break;
	}
}

override(spawn)
{	
	spawn endon ("death");
	wait (20 + randomint (5));
	spawn notify ("override");
	
	if (distance (spawn.origin, level.ender.origin) < 350)
	{
		spawn setgoalpos (level.ender.origin);
		spawn.goalradius = 64;
		return;
	}
	
	spawn DoDamage ( 1500, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
}

tankTrigger ( trigger )
{
	trigger waittill ("trigger");
	trigger delete();
//	wait (5);
	tank = getent ("tank","targetname");
	tank thread maps\_tiger_gmi::init();
	tank thread maps\_tankdrive_gmi::splash_shield();
	path = getvehiclenode ("tank path","targetname");
	tank attachPath( path );
	tank startPath();
	tank maps\_tankgun_gmi::mgoff();
	tank waittill ("reached_end_node");
	flag_set ("tank arrived");
}

cam_controls (vec, letter)
{
	setcvar (letter+"up","");
	setcvar (letter+"down","");
	while (1)
	{
		if (getcvar (letter+"up") != "")
			level.cam_vec[vec] += 5;	
		if (getcvar (letter+"down") != "")
			level.cam_vec[vec] -= 5;	
		setcvar (letter+"up","");
		setcvar (letter+"down","");
		wait (0.1);
	}
}

height ( trigger )
{
	wait (0.05);
	trigger waittill ("trigger");

	if(isdefined(trigger.script_noteworthy))
	{	
		if(trigger.script_noteworthy == "pitch")
		{
			println("^2 **************** trigger.script_noteworthy pitch 1**********");
			level thread change_pitch(trigger.script_accuracy);
		}
	}

	if(isdefined(trigger.script_noteworthy))
	{	
		if(trigger.script_noteworthy == "last")
		{
			println("^2 **************** trigger.script_noteworthy pitch 1**********");
			level thread change_pitch_last(trigger.script_accuracy);
		}
	}

	level.destinationHeight = trigger.script_delay;

	if(isdefined(trigger.script_wait))
	{
		level.cam_dif = trigger.script_wait;
	}
	else
	{
		level.cam_dif = 0.98;
	}

	if (isdefined (trigger.script_noteworthy))
	{
		if (trigger.script_noteworthy == "make mortars")
			getent ("mortar team","targetname") notify ("start");
	}
}

heightDestination()
{
	level.destinationHeight	= -120;
	level.currentHeight	= -120;
	level.cam_dif = 0.98;
	while (1)
	{
//		println("^3Currentheight: ", level.currentHeight," ^3DestinationHeight: ",level.destinationHeight, " ^5Level.Camorg.Origin: ",level.camorg.origin);
		level.currentHeight = level.currentHeight * level.cam_dif + level.destinationHeight * (1.0 - level.cam_dif);
		wait (0.05);
	}
}

x_axis ( trigger )
{
	wait (0.05);
	trigger waittill ("trigger");

	level.destination_x_axis = trigger.script_delay;

	if(isdefined(trigger.script_wait))
	{
		level.x_axis_cam_dif = trigger.script_wait;
	}
	else
	{
		level.x_axis_cam_dif = 0.98;
	}
}

x_axisDestination()
{
	level.destination_x_axis = 0;
	level.current_x_axis = 0;
	level.x_axis_cam_dif = 0.98;
	while (1)
	{
//		println("^3Currentheight: ", level.currentHeight," ^3DestinationHeight: ",level.destinationHeight, " ^5Level.Camorg.Origin: ",level.camorg.origin);
		level.current_x_axis = level.current_x_axis * level.x_axis_cam_dif + level.destination_x_axis * (1.0 - level.x_axis_cam_dif);
		wait (0.05);
	}
}

y_axis ( trigger )
{
	wait (0.05);
	trigger waittill ("trigger");

	level.destination_y_axis = trigger.script_delay;

	if(isdefined(trigger.script_wait))
	{
		level.y_axis_cam_dif = trigger.script_wait;
	}
	else
	{
		level.y_axis_cam_dif = 0.98;
	}
}

y_axisDestination()
{
	level.destination_y_axis = 0;
	level.current_y_axis = 0;
	level.y_axis_cam_dif = 0.98;
	while (1)
	{
//		println("^3Currentheight: ", level.currentHeight," ^3DestinationHeight: ",level.destinationHeight, " ^5Level.Camorg.Origin: ",level.camorg.origin);
		level.current_y_axis = level.current_y_axis * level.y_axis_cam_dif + level.destination_y_axis * (1.0 - level.y_axis_cam_dif);
		wait (0.05);
	}
}

change_pitch(angle)
{
	println("^2 **************** trigger.script_noteworthy pitch 2**********");
	level.camorg rotateto((angle, level.camorg.angles[1], level.camorg.angles[2]), 5, 2, 3);
}

change_pitch_last(angle)
{
	// moveTo(vec position, float time, <float acceleration_time>, <float deceleration_time>);
	println("^2 **************** trigger.script_noteworthy pitch 2**********");
	level.flags["breaker"] = true;
	level notify ("break it off");
	level.camorg moveto((level.camorg.origin + (-512,0,angle)), 5, 2, 3);
}



rotateroler ()
{	
	println("^1Got to rotateroler");

	self rotateto ((level.cam_vec[0],level.cam_vec[1],level.cam_vec[2]), 0.05);
	
	println("^1Camorg angles:", self.angles[0], self.angles[1], self.angles[2]);
	println("^1camvec angles:", level.cam_vec[0], level.cam_vec[1], level.cam_vec[2]);

	return;
	
	println("^1Got past rotateroler return");
	
	while (1)
	{
		println ("cam ",level.cam_vec[0], " ",level.cam_vec[1]," ",level.cam_vec[2]);
		self rotateto ((level.cam_vec[0],level.cam_vec[1],level.cam_vec[2]), 0.05);
		wait (0.2);
	}
}

follower (ender)
{
	timer = 0.15;
//	ender.origin;
	level.player.angles = (0,0,0);
	level endon ("break it off");

	if(getcvar("player_nolink") == "1")
	{
		level.player freezecontrols(false);
		return;
	}

	if(getcvar("nolink") != "1")
	{
//		level.player linkto (level.camorg);
		level.player playerlinkto (level.camorg, "", (0,0,0));
	}

//	level.camorg.origin = (44173,-496,-66);
	level.camorg.origin = (42297,-236,-66);
	
	if(!level.check)
	{
		return;
	}

	level.destinationHeight	= 0;
	level.currentHeight	= 0;
	offset = 54;
	level.current_x_axis = 0;

	level waittill("intro_node_reached");
	level thread Hud_Text((&"GMI_CREDIT_PREVIOUSLY"), "center", 320, 400, 1.2, "end_previously", time);

	while (1)
	{
		if (level.flags["breaker"] == true)
		{
			break;
		}
		self moveto ((ender.origin[0] - 40 + level.current_x_axis, ender.origin[1] - 400 + level.current_y_axis, offset + level.currentHeight), timer);
		wait (timer);
	}
}

driver_think ( spawner )
{
	spawner waittill ("spawned",spawn);
	if (maps\_utility_gmi::spawn_failed(spawn))
		return;
		
	spawn endon ("death");
	level.ender lookat (spawn, 8);
	node = spawn;
	while (isdefined (node.target))
	{
		node = getnode (node.target,"targetname");
		spawn setgoalnode (node);
		spawn waittill ("goal");
	}
}

german_truck (truck)
{

//	getent ("german truck clip","targetname") notsolid();
	driver = getent (truck.target,"targetname");
	
	if (isdefined (driver))
		level thread driver_think(driver);

//	truck.treaddist = 30;
	truck maps\_truck_gmi::init();
	truck maps\_truck_gmi::attach_guys(undefined,driver);
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

	truck notify ("unload");
	truck waittill ("reached_end_node");
	truck disconnectpaths();
	wait (2);
	println ("Truck origin: ", truck.origin, " truck angles: ", truck.angles);
}

addCredits (src, text)
{
	newStr = spawnstruct();
	newStr.string = text;
	newStr.placement = src.size;
	newStr.location = 0;
	newStr.sort = 20;
	newStr.blank = false;
	newStr.fontScale = 1.00;
	newStr.alignX = "right";
	src[src.size] = newStr;
	return src;
}

addCreditsBold (src, text)
{
	newStr = spawnstruct();
	newStr.string = text;
	newStr.placement = src.size;
	newStr.location = 0;
	newStr.sort = 20;
	newStr.blank = false;
	newStr.fontScale = 1.25;
	newStr.alignX = "right";
	src[src.size] = newStr;
	return src;
}

addBlank (src )
{
	newStr = level.blankElement;
	src[src.size] = newStr;
	return src;
}


text ()
{
	level.blankElement = newHudElem();
	level.blankElement.blank = true;
	
	
	src = [];	
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_GRAY_MATTER_STUDIOS");
	src = addBlank (src);	
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ART_AND_ANIMATION");
	src = addCredits (src, &"GMI_CREDIT_BRIAN_ANDERSON");
	src = addCredits (src, &"GMI_CREDIT_SLOAN_ANDERSON");
	src = addCredits (src, &"GMI_CREDIT_ISABELLE_DECENCIERE");
	src = addCredits (src, &"GMI_CREDIT_DOMINIQUE_DROZDZ2");
	src = addCredits (src, &"GMI_CREDIT_JASON_HOOVER");
	src = addCredits (src, &"GMI_CREDIT_DAN_MODITCH");
	src = addCredits (src, &"GMI_CREDIT_COLIN_WHITNEY");
	src = addCredits (src, &"GMI_CREDIT_TOM_SZAKOLCZAY");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_LEVEL_DESIGN_AND_SCRIPTING");
	src = addCredits (src, &"GMI_CREDIT_JOE_CHIANG");
	src = addCredits (src, &"GMI_CREDIT_MIKE_DENNY");
	src = addCredits (src, &"GMI_CREDIT_JEREMY_LUYTIES");
	src = addCredits (src, &"GMI_CREDIT_NIKOLAI_MOHILCHOCK");
	src = addCredits (src, &"GMI_CREDIT_PAUL_SANDLER");
	src = addCredits (src, &"GMI_CREDIT_THADDEUS_SASSER");
	src = addCredits (src, &"GMI_CREDIT_NATHAN_SILVERS");
	src = addCredits (src, &"GMI_CREDIT_JESSE_SNYDER");
	src = addCredits (src, &"GMI_CREDIT_SEAN_SOUCY");	
	src = addCredits (src, &"GMI_CREDIT_KEVIN_WORREL");
	src = addBlank (src);		
	src = addCreditsBold (src, &"GMI_CREDIT_PROGRAMMING");
	src = addCredits (src, &"GMI_CREDIT_JED_ADAMS");
	src = addCredits (src, &"GMI_CREDIT_ALEXANDER_CONSERVA");
	src = addCredits (src, &"GMI_CREDIT_RYAN_FELTRAIN");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_SOUND_FX_ENGINEERING");
	src = addCredits (src, &"GMI_CREDIT_STEVE GOLDBERG");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ADMINISTRATIVE_ASSISTANT");
	src = addCredits (src, &"GMI_CREDIT_ERIKA_NARIMATSU");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ART_DIRECTOR");
	src = addCredits (src, &"GMI_CREDIT_CORKY_LEHMKUHL");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_CREATIVE_LEAD");
	src = addCredits (src, &"GMI_CREDIT_RICHARD_FARRELLY");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_LEAD_DESIGNER");
	src = addCredits (src, &"GMI_CREDIT_DANIEL_KOPPEL");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_SENIOR_PRODUCER");
	src = addCredits (src, &"GMI_CREDIT_ROBB_ALVEY");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_TECH_DIR");
	src = addCredits (src, &"GMI_CREDIT_JM_MOREAL");
	//src = addBlank (src);
	//src = addCreditsbold (src, &"GMI_CREDIT_DOMINIQUE_DROZDZ");
	//src = addCredits (src, &"GMI_CREDIT_DOMINIQUE_DROZDZ2");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ACTIVISION");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_PRODUCTION");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_PRODUCER");
	src = addCredits (src, &"GMI_CREDIT_DOUG_PEARSON");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_EXECUTIVE_PRODUCER");
	src = addCredits (src, &"GMI_CREDIT_MARC_STRUHL");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ASSOCIATE_PRODUCER");
	src = addCredits (src, &"GMI_CREDIT_DAN_HAGERTY");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_PRODUCTION_COORDINATOR");
	src = addCredits (src, &"GMI_CREDIT_MATT_BURNS");
	src = addCredits (src, &"GMI_CREDIT_NATE_MCCLURE");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_PRODUCTION_TESTER");
	src = addCredits (src, &"GMI_CREDIT_ROB_KIRSCHENBAUM");
	src = addCredits (src, &"GMI_CREDIT_ISMAEL_GARCIA");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_VP_NORTH_AMERICAN_STUDIOS1");
	src = addCredits (src, &"GMI_CREDIT_MARK_LAMIA");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_PRES_ACTIVISION_PUBLISH");
	src = addCredits (src, &"GMI_CREDIT_KATHY_VRABECK1");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ADD_CONTENT");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ADDITIONAL_ANIMATION");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ADDITIONAL_ANIMATION2");
	src = addCreditsBold (src, &"GMI_CREDIT_ADDITIONAL_ANIMATION3");
	src = addCreditsBold (src, &"GMI_CREDIT_ADDITIONAL_ANIMATION4");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_INFINITY_WARD");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_LEVEL_DESIGN");
	src = addCredits (src, &"GMI_CREDIT_CHAD_GRENIER");
	src = addCredits (src, &"GMI_CREDIT_TODD_ALDERMAN");
	src = addCredits (src, &"GMI_CREDIT_KEITH_BELL");
	src = addCredits (src, &"GMI_CREDIT_MOHAMMED_ALAVI");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ANIMATION");
	src = addCredits (src, &"GMI_CREDIT_CHANCE_GLASCO");
	src = addCredits (src, &"GMI_CREDIT_PAUL_MESSERLY");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_PRODUCER");
	src = addCredits (src, &"GMI_CREDIT_KEN_TURNER");	
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ASSOCIATE_PRODUCER");
	src = addCredits (src, &"GMI_CREDIT_ERIC_JOHNSEN");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_PI_STUDIOS");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_ROBERT_ERWIN");
	src = addCredits (src, &"GMI_CREDIT_JOHN_FAULKENBURY");
	src = addCredits (src, &"GMI_CREDIT_ROB_HEIRONIMUS");
	src = addCredits (src, &"GMI_CREDIT_DIRK_JONES");
	src = addCredits (src, &"GMI_CREDIT_DAN_KRAMER");
	src = addCredits (src, &"GMI_CREDIT_CAMERON_LAMPRECHT");
	src = addCredits (src, &"GMI_CREDIT_PETER_MACK");
	src = addCredits (src, &"GMI_CREDIT_DAVID_MERTZ");
	src = addCredits (src, &"GMI_CREDIT_DANIEL_YOUNG");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_STANJEL");
	src = addCredits (src, &"GMI_CREDIT_ROGER_ABRAHAMSSON");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_SCRIPT_AND_VOICE");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_SCRIPTWRITER");
	src = addCredits (src, &"GMI_CREDIT_MICHAEL_SCHIFFER");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ADDITIONAL_WRITING");
	src = addCredits (src, &"GMI_CREDIT_RICHARD_FARRELLY");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_MILITARY_ADVISORS");
	src = addCreditsBold (src, &"GMI_CREDIT_MILITARY_ADVISORS2");
	src = addCreditsBold (src, &"GMI_CREDIT_MILITARY_ADVISORS3");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_CASTING_AND_VOICE_DIRECTION");
	src = addCredits (src, &"GMI_CREDIT_WOMB_MUSIC");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_VOICE_TALENT");
	src = addCredits (src, &"GMI_CREDIT_GREGG_BERGER");
	src = addCredits (src, &"GMI_CREDIT_STEVE_BLUM");
	src = addCredits (src, &"GMI_CREDIT_ROBIN_ATKIN_DOWNES");
	src = addCredits (src, &"GMI_CREDIT_SCOTT_BULLOCK");
	src = addCredits (src, &"GMI_CREDIT_NEIL_ROSS1");
	src = addCredits (src, &"GMI_CREDIT_SCOTT_MENVILLE");
	src = addCredits (src, &"GMI_CREDIT_JIM_WARD1");
	src = addCredits (src, &"GMI_CREDIT_DEE_BAKER");
	src = addCredits (src, &"GMI_CREDIT_JAMIE_ALCROFT");
	src = addCredits (src, &"GMI_CREDIT_NICK_JAMESON");
	src = addCredits (src, &"GMI_CREDIT_CAM_CLARKE");
	src = addCredits (src, &"GMI_CREDIT_ANDRE_SOGLIUZZO1");
	src = addCredits (src, &"GMI_CREDIT_GRANT_ALBRECHT");
	src = addCredits (src, &"GMI_CREDIT_GREG_ELLIS");
	src = addCredits (src, &"GMI_CREDIT_JAY_GORDON");
	src = addCredits (src, &"GMI_CREDIT_MATT_MORTON1");
	src = addCredits (src, &"GMI_CREDIT_BILL_HARPER");
	src = addCredits (src, &"GMI_CREDIT_QUINTON_FLYNN1");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_RECORDING");
	src = addCredits (src, &"GMI_CREDIT_RIK_W");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_VOICES_RECORDED_AT_SALAMI_STUDIOS_AND_THE_CASTLE");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_MUSIC_AND_SOUND_EFFECTS");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ORIGINAL_MUSICAL_SCORE");
	src = addCredits (src, &"GMI_CREDIT_MICHAEL_GIACCHINO");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ADDITIONAL_MUSIC");
	src = addCredits (src, &"GMI_CREDIT_JUSTIN_SKOMAROVSKY");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_GLOBAL_BRAND_TITLE");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ASSOCIATE_BRAND_MANAGER");
	src = addCredits (src, &"GMI_CREDIT_RICHARD_BREST");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_GLOBAL_BRAND_MANAGEMENT");
	src = addCredits (src, &"GMI_CREDIT_GLOBAL_BRAND_MANAGEMENT_DAVID");
	src = addBlank (src);
//	src = addCreditsBold (src, &"GMI_CREDIT_DIRECTOR_GBM");
//	src = addCredits (src, &"GMI_CREDIT_MICHELLE_NINO");
//	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_VP_GBM");
	src = addCredits (src, &"GMI_CREDIT_DUSTY_WELCH");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_SENIOR_PUBLICIST");
	src = addCredits (src, &"GMI_CREDIT_MIKE_MANTARRO");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_PUBLICIST");
	src = addCredits (src, &"GMI_CREDIT_MACLEAN_MARSHALL");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_DIRECTOR_CORP_COMMUNICATIONS");
	src = addCredits (src, &"GMI_CREDIT_MICHELLE_NINO");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_VP_TRADE_MARKETING");
	src = addCredits (src, &"GMI_CREDIT_TRICIA_BERTERO");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_NORTH_AMERICAN_SALES");
	src = addCredits (src, &"GMI_CREDIT_NORTH_AMERICAN_SALES2");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_TRADE_MARKETING_MANAGER");
	src = addCredits (src, &"GMI_CREDIT_JULIE_DEWOLF");
	src = addCredits (src, &"GMI_CREDIT_AMY_LONGHI");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_BUSINESS_LEGAL_AFFAIRS");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_DIRECTOR_B_L");
	src = addCredits (src, &"GMI_CREDIT_GREG_DEUTSCH");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_SENIOR_VP_BL");
	src = addCredits (src, &"GMI_CREDIT_GEORGE_ROSE");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_CREATIVE_SERVICES");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_DENISE_WALSH");
	src = addCredits (src, &"GMI_CREDIT_DENISE_WALSH2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_MATHEW_STAINNER");
	src = addCredits (src, &"GMI_CREDIT_MATHEW_STAINNER2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_JILL_BARRY");
	src = addCredits (src, &"GMI_CREDIT_JILL_BARRY2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_SHELBY_YATES");
	src = addCredits (src, &"GMI_CREDIT_SHELBY_YATES2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_HAMAGAMI_CARROLL2");
	src = addCredits (src, &"GMI_CREDIT_HAMAGAMI_CARROLL");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_IGNITED_MINDS");
	src = addCredits (src, &"GMI_CREDIT_IGNITED_MINDS2");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_INTERNATIONAL");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_SCOTT_DODKINS");
	src = addCredits (src, &"GMI_CREDIT_SCOTT_DODKINS2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_ROGER_WALKDEN");
	src = addCredits (src, &"GMI_CREDIT_ROGER_WALKDEN2");
	src = addBlank (src);		
	src = addCredits (src, &"GMI_CREDIT_ALISON_TURNER");
	src = addCredits (src, &"GMI_CREDIT_ALISON_TURNER2");
	src = addBlank (src);	
	src = addCredits (src, &"GMI_CREDIT_TIM_PONTING");
	src = addCredits (src, &"GMI_CREDIT_TIM_PONTING2");
	src = addBlank (src);	
	src = addCredits (src, &"GMI_CREDIT_NATHALIE_RANSON");
	src = addCredits (src, &"GMI_CREDIT_NATHALIE_RANSON2");
	src = addBlank (src);	
	src = addCredits (src, &"GMI_CREDIT_TAMSIN_LUCAS1");
	src = addCredits (src, &"GMI_CREDIT_TAMSIN_LUCAS12");
	src = addBlank (src);	
	src = addCredits (src, &"GMI_CREDIT_JACKIE_SUTTON");
	src = addCredits (src, &"GMI_CREDIT_JACKIE_SUTTON2");
	src = addBlank (src);	
	src = addCredits (src, &"GMI_CREDIT_SIMON_DAWES");
	src = addCredits (src, &"GMI_CREDIT_SIMON_DAWES2");
	src = addBlank (src);	
	src = addCredits (src, &"GMI_CREDIT_PHILIP_BAGNALL");
	src = addCredits (src, &"GMI_CREDIT_PHILIP_BAGNALL2");
	src = addBlank (src);	
	src = addCredits (src, &"GMI_CREDIT_DALEEP_CHHABRIA");
	src = addCredits (src, &"GMI_CREDIT_DALEEP_CHHABRIA2");
	src = addBlank (src);	
	src = addCredits (src, &"GMI_CREDIT_HEATHER_CLARKE");
	src = addCredits (src, &"GMI_CREDIT_HEATHER_CLARKE2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_VICTORIA_FISHER");
	src = addCredits (src, &"GMI_CREDIT_VICTORIA_FISHER2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_LYNNE_MOSS");
	src = addCredits (src, &"GMI_CREDIT_LYNNE_MOSS2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_GERMAN_LOCALIZATION");
	src = addCredits (src, &"GMI_CREDIT_GERMAN_LOCALIZATION2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_FRENCH_LOCALIZATION");
	src = addCredits (src, &"GMI_CREDIT_FRENCH_LOCALIZATION2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_ITALIAN_SPANISH_LOCALIZATION");
	src = addCredits (src, &"GMI_CREDIT_ITALIAN_SPANISH_LOCALIZATION2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_JAPANESE_LOCALIZATION");
	src = addCredits (src, &"GMI_CREDIT_JAPANESE_LOCALIZATION2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_CHINESE_LOCALIZATION");
	src = addCredits (src, &"GMI_CREDIT_CHINESE_LOCALIZATION2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_KOREAN_LOCALIZATION");
	src = addCredits (src, &"GMI_CREDIT_KOREAN_LOCALIZATION2");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ACTIVISION_GERMANY");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_STEFAN_LULUDES");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_BERND_REINARTZ");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_JULIA_VOLKMANN");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_STEFAN_SEIDEL");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_THORSTEN_HMANN");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ACTIVISION_FRANCE");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_BERNARD_SIZEY");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_GUILLAUME_LAIRAN");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_GAUTIER_ORMANCEY");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_DIANE_DE_DOMECY");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_CENTRAL_TECHNOLOGY");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_ED_CLUNE");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_ANDREW_PETTERSON");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_INFORMATION_TECHNOLOGY");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_NIEL_ARMSTRONG");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_DAVID_SMITH");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_ERWIN_BARCEGA");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_RICARDO_ROMERO");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_JASON_MCAULIFFE");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_BRYAN_FUNG");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_QUALITY_ASSURANCE_CUSTOMER_SUPPORT");
	src = addBlank (src);
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_ERIK_MELEN");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_GLENN_VISTANTE");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_MARILENA_RIXFORD");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_MATT_MCCLURE");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_DONALD_MARSHALL");
	src = addBlank (src);

	// TESTERS NAMES BEGIN
	src = addCreditsBold (src, &"GMI_CREDIT_TESTERS");
//	src = addCredits (src, &"GMI_CREDIT_TESTERS_NAMES");
	src = addCredits (src, &"GMI_CREDIT_TESTER_AVERY_BENNET");
	src = addCredits (src, &"GMI_CREDIT_TESTER_ALBERT_YAO");
	src = addCredits (src, &"GMI_CREDIT_TESTER_CRIS_ONEILL");
	src = addCredits (src, &"GMI_CREDIT_TESTER_JASON_RALYA");
	src = addCredits (src, &"GMI_CREDIT_TESTER_JIM_NORRIS");
	src = addCredits (src, &"GMI_CREDIT_TESTER_PETER_MCKERNAN");
	src = addCredits (src, &"GMI_CREDIT_TESTER_SCOTT_SOLTERO");
	src = addCredits (src, &"GMI_CREDIT_TESTER_DANIEL_YOON");
	src = addCredits (src, &"GMI_CREDIT_TESTER_JASON_GUYAN");
	src = addCredits (src, &"GMI_CREDIT_TESTER_JULIO_RODRIGUEZ");
	src = addCredits (src, &"GMI_CREDIT_TESTER_MATTHEW_MURRAY");
	src = addCredits (src, &"GMI_CREDIT_TESTER_SERG_SOULEIMAN");
	src = addCredits (src, &"GMI_CREDIT_TESTER_ADAM_LUSKIN");
	src = addCredits (src, &"GMI_CREDIT_TESTER_TRAVIS_CUMMINGS");
	src = addCredits (src, &"GMI_CREDIT_TESTER_EVAN_VINCENT");
	src = addCredits (src, &"GMI_CREDIT_TESTER_MATTHEW_BROWN");
	src = addCredits (src, &"GMI_CREDIT_TESTER_MIKE_SALWET");
	src = addCredits (src, &"GMI_CREDIT_TESTER_ROBERT_DION");
	src = addCredits (src, &"GMI_CREDIT_TESTER_FRANKIE_GUTIERREZ");
	src = addCredits (src, &"GMI_CREDIT_TESTER_JOHN_SHUBERT");
	src = addCredits (src, &"GMI_CREDIT_TESTER_DAVID_MOYA");
	src = addCredits (src, &"GMI_CREDIT_TESTER_PETER_VON_OY");
	src = addCredits (src, &"GMI_CREDIT_TESTER_JIM_CHENG");
	src = addBlank (src);
	// TESTERS NAME ENDS

	src = addCredits (src, &"GMI_CREDIT_CHRIS_KEIM");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_NEIL_BARIZO");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_FRANCIS_JIMENEZ");
	src = addCredits (src, &"GMI_CREDIT_FRANCIS_JIMENEZ2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_COMPATIBILITY_TESTERS");
	src = addCredits (src, &"GMI_CREDIT_COMPATIBILITY_TESTERS2");
	src = addCredits (src, &"GMI_CREDIT_COMPATIBILITY_TESTERS3");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_TIM_VANLAW");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_JEF_SEDIVY");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_CRG_TESTERS");
	src = addCredits (src, &"GMI_CREDIT_CRG_TESTERS2");
	src = addCredits (src, &"GMI_CREDIT_CRG_TESTERS3");
	src = addCredits (src, &"GMI_CREDIT_CRG_TESTERS4");
	src = addCredits (src, &"GMI_CREDIT_CRG_TESTERS5");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_LOCALIZATION_PROJECT_LEAD");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_ANTHONY_HATCH_KOROTKO");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_ADAM_HARTSFIELD");
	src = addBlank (src);
	src = addCreditsbold (src, &"GMI_CREDIT_LOCALIZATIONS_TEST_TEAM");
	// LOCAL TEST TEAM BEGIN
//	src = addCredits (src, &"GMI_CREDIT_LOCALIZATIONS_TEAM_TESTERS");
//	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_LOC_TESTER_JASON_SMITH");
	src = addCredits (src, &"GMI_CREDIT_LOC_TESTER_JASON_GILMORE");
	src = addCredits (src, &"GMI_CREDIT_LOC_TESTER_AARON_SEDILLO");
	src = addCredits (src, &"GMI_CREDIT_LOC_TESTER_EDMUND_PARK");
	src = addCredits (src, &"GMI_CREDIT_LOC_TESTER_KENDRICK_HSU");
	src = addCredits (src, &"GMI_CREDIT_LOC_TESTER_DAN_ROHAN");
	src = addCredits (src, &"GMI_CREDIT_LOC_TESTER_DAVID_HADDOCK");
	src = addCredits (src, &"GMI_CREDIT_LOC_TESTER_AKSHAY");
	src = addCredits (src, &"GMI_CREDIT_LOC_TESTER_HOAN_BUI");
	src = addBlank (src);
	// LOCAL TEST TEAM END
	src = addCredits (src, &"GMI_CREDIT_BOB_MCPHERSON");
	src = addCredits (src, &"GMI_CREDIT_BOB_MCPHERSON2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_GARY_BOLDUC");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_MICHAEL_HILL");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS");
	// begin
	src = addCredits (src, &"GMI_CREDIT_JOHN_BOJORQUEZ");
	src = addCredits (src, &"GMI_CREDIT_BRANDON_GRADA");
	src = addCredits (src, &"GMI_CREDIT_BRADLY_SHAW");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_RATUMS_THE_HAMSTER");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_ANNABELLE");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_COMPANY");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_VALERIE_FARRELLY");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_ETHAN_F");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_BARB");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_EDWIN");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_SOFIA");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_SOUCY2");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_SOUCY3");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_SOUCY4");

	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_ELLISA");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_SEAN");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_LORNA");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_ALEX");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_ANNA");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_CAITLIN");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_CHANG");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_BA");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_WENDY");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_TED");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_RUBY");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_ELISABETH");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_IGOR");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_SEA");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_STACY");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_DALE");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_YELA");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_SCHLEH");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_DELEON");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_ROBERT");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_MODITCH");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_MODITCH2");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_DARA");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_JIM");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_JERRI");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_JASON_W");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_MANDI");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_HENNY");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_MIKE_DAD");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_ADAMS");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_ADAMS2");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_SANDI");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_JULIEANNE_CONSERVA");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_SHUCK");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_WAVE");
	src = addCredits (src, &"GMI_CREDIT_GMI_SPECIAL_THANKS_SPARK");

	// end
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_PI_SPECIAL_THANKS");
	src = addCredits (src, &"GMI_CREDIT_CHRISTIAN_CUMMINGS");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS");
	src = addCreditsBold (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_DOORNINK");
//	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_NAMES");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_BRAD_CARRAWAY");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_KEN_MURPHY");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_CARYN_LAW");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_STEVE_HOLMES");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_MATTHEW_BEAL");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_JASON_KIM");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_STACY_SCOOTER");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_BULLIS");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_ROHRA");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_FRITTS");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_CLARENCE_WASHINGTON");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_DION_BRAIN");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_NANCY_WOLFE");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_MICHAEL_CARTER");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_SUZY_LUKO");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_BARAJAS");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_DANIELLE_KIM");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_MICHAEL_LARSON");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_JAY_KOMAS");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_BETTY_KIM");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_LORI_PAGER");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_LETTY_CADENA");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_JUSTIN_BERENBAUM");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_JIM_BLACK");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_MITCH_SOULE");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_REX_SIKORA");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_CATHY_KINZER");
	src = addCredits (src, &"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_EDDIE_BANKS");
	src = addBlank (src);
//	src = addBlank (src);
//	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_QA_SPECIAL_THANKS");
//	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_NAMES");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_JIM_SUMMERS");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_JASON_WONG");
//	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_MARILENA_RIXFORD");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_JOE_FAVAZZA");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_JASON_LEVINE");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_NADINE_THEUZILLOT");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_JASON_POTTER");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_JOHN_ROSSER");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_CHAD_SIEDHOFF");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_INDRA_YEE");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_TODD_KOMESU");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_JOULE_MIDDLETON");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_JENNIFER_VITIELLO");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_MIKE_RIXFORD");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_JESSICA_MCCLURE");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_JOANNE_SHINOZAKI");
	src = addCredits (src, &"GMI_CREDIT_QA_THANKS_JB_BERNSTEIN");

	src = addBlank (src);
//	src = addCreditsBold (src, &"GMI_CREDIT_CHAPTER_BRIEF1");
//	src = addCredits (src, &"GMI_CREDIT_EDWARD_F");
//	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_INTRODUCTION_CINEMATIC");
	src = addCreditsBold (src, &"GMI_CREDIT_INTRODUCTION_CINEMATIC2");
	src = addCredits (src, &"GMI_CREDIT_ANT_FARM");
	src = addCredits (src, &"GMI_CREDIT_ANT_FARM2");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_CINEMATIC_AUDIO_PROCESSING_BY");
	src = addCreditsBold (src, &"GMI_CREDIT_CINEMATIC_AUDIO_PROCESSING_BY2");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_SONIC_POOL");
	src = addBlank (src);
	src = addCredits (src, &"GMI_CREDIT_PUNK_BUSTER");
	src = addCredits (src, &"GMI_CREDIT_PUNK_BUSTER2");
	src = addCredits (src, &"GMI_CREDIT_TONY_RAY");
	src = addBlank (src);
	src = addBlank (src);
////	src = addCreditsBold (src, &"GMI_CREDIT_THANKS1");
////	src = addCreditsBold (src, &"GMI_CREDIT_THANKS1a");
	src = addCreditsBold (src, &"GMI_CREDIT_INFINITY_WARD");
	src = addCredits (src, &"GMI_CREDIT_TODD_ALDERMAN");
	src = addCredits (src, &"GMI_CREDIT_BRAD_ALLEN");
	src = addCredits (src, &"GMI_CREDIT_KEITH_BELL");
	src = addCredits (src, &"GMI_CREDIT_MICHAEL_BOON");
	src = addCredits (src, &"GMI_CREDIT_KEVIN_CHEN");
	src = addCredits (src, &"GMI_CREDIT_CLIFTON_CLINE");
	src = addCredits (src, &"GMI_CREDIT_GRANT_COLLIER");
	src = addCredits (src, &"GMI_CREDIT_URSULA_ESCHER");
	src = addCredits (src, &"GMI_CREDIT_ROBERT_FIELD");
	src = addCredits (src, &"GMI_CREDIT_STEVE_FUKUDA");
	src = addCredits (src, &"GMI_CREDIT_OLIVER_GEORGE");
	src = addCredits (src, &"GMI_CREDIT_FRANK_GIGLIOTTI");
	src = addCredits (src, &"GMI_CREDIT_CHANCE_GLASCO");
	src = addCredits (src, &"GMI_CREDIT_CARL_GLAVE");
	src = addCredits (src, &"GMI_CREDIT_PRESTON_GLENN");
	src = addCredits (src, &"GMI_CREDIT_CHAD_GRENIER");
	src = addCredits (src, &"GMI_CREDIT_JACK_GRILLO");
	src = addCredits (src, &"GMI_CREDIT_EARL_HAMMON");
	src = addCredits (src, &"GMI_CREDIT_CHRIS_HASSELL");
	src = addCredits (src, &"GMI_CREDIT_JEFF_HEATH");
	src = addCredits (src, &"GMI_CREDIT_CHRIS_HERMANS");
	src = addCredits (src, &"GMI_CREDIT_PAUL_JURY");
	src = addCredits (src, &"GMI_CREDIT_BRYAN_KUHN");
	src = addCredits (src, &"GMI_CREDIT_SCOTT_MATLOFF");
	src = addCredits (src, &"GMI_CREDIT_FAIRFAX");
	src = addCredits (src, &"GMI_CREDIT_GAVIN_MCCANDLISH");
	src = addCredits (src, &"GMI_CREDIT_PAUL_MESSERLY");
	src = addCredits (src, &"GMI_CREDIT_DAVID_OBERLIN");
	src = addCredits (src, &"GMI_CREDIT_ZIED_RIEKE");
	src = addCredits (src, &"GMI_CREDIT_CHUCK_RUSSOM");
	src = addCredits (src, &"GMI_CREDIT_NATE_SILVERS");
	src = addCredits (src, &"GMI_CREDIT_JUSTIN_THOMAS");
	src = addCredits (src, &"GMI_CREDIT_JANICE_TURNER");
	src = addCredits (src, &"GMI_CREDIT_KEN_TURNER");
	src = addCredits (src, &"GMI_CREDIT_JASON_WEST");
	src = addCredits (src, &"GMI_CREDIT_VINCE_ZAMPELLA");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ACTIVISION_PRODUCTION");
	src = addCreditsBold (src, &"GMI_CREDIT_ACTIVISION_PRODUCTION2");
	src = addCredits (src, &"GMI_CREDIT_THAINE_LYMAN");
	src = addCredits (src, &"GMI_CREDIT_KEN_MURPHY");
	src = addCredits (src, &"GMI_CREDIT_DAN_HAGERTY");
	src = addCredits (src, &"GMI_CREDIT_ERIC_GROSSMAN");
	src = addCredits (src, &"GMI_CREDIT_PATRICK_BOWMAN");
	src = addCredits (src, &"GMI_CREDIT_ROB_KIRSCHENBAUM");
	src = addCredits (src, &"GMI_CREDIT_LAIRD_MALAMED");
	src = addCredits (src, &"GMI_CREDIT_MARK_LAMIA");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_LICENSES");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_ID");
	src = addCreditsBold (src, &"GMI_CREDIT_ID2");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_BINK");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_MILES");
	src = addBlank (src);
	src = addCreditsBold (src, &"GMI_CREDIT_THANKS1b");
////	src = addCreditsBold (src, &"GMI_CREDIT_THANKS2");
////	src = addCreditsBold (src, &"GMI_CREDIT_THANKS2aa");
	src = addCreditsBold (src, &"GMI_CREDIT_THANKS2b");
	src = addCreditsBold (src, &"GMI_CREDIT_THANKS2a");
	src = addBlank (src);
	src = addBlank (src);
	if (getcvar ("start") == "start") // black borders around level
	{
		height = 60;
		height = 100;
		black[0] = newHudElem();
		black[1] = newHudElem();
		for (i=0;i<black.size;i++)
		{
			black[i].x = 0;
			black[i].y = 0;
			black[i] setShader("black", 640, height);
			black[i].alpha = 1;
		}
		
		black[0].y = 480-height;

		black[2] = newHudElem();
		black[2].x = 0;
		black[2].y = 0;
		black[2] setShader("black", 640, 480);
		black[2].alpha = 1;
		if (level.check)
			thread fadeout (black[2]);
		level.screenOverlay	= black[2];
	}
	
	for (i=0;i<black.size;i++)
	{
		black[i].sort = 5;
	} // black border end
	
	wait (0.05);
	
	timer = 0;
	index = 0;
	while (1)
	{
		if (gettime() < timer)
		{
			wait (0.05);
			continue;
		}

//		println("index = ",index);
//		println("src.size = ",src.size);

		if (index+70 >= src.size) // sets pics to center upon how many lines are left
		{
			println("^2READY TO END!");
			level.credits_playing = false; // Thad end credits
//			wait 3;
			flag_set("ready to end");
		}
		
		level thread launchCredit (src[index]);
		timer = gettime() + 900;
		index++;
		if (index >= src.size)
			break;
	}
	
}

// Fade away, so it's transparant
fadeout (elem)
{
	wait (1);
	elem fadeOverTime (2);
	elem.alpha = 0;
}

// Fade up, so, it's opaque.
fadein (elem)
{
	wait (1);
	elem fadeOverTime (2);
	elem.alpha = 1;
}
		
launchCredit (src)
{			
	if (src.blank)
		return;


	if (flag("ready to end"))
	{
		println("ENDER IS TRUE!");
		ender = true;
		level notify("credits_are_over");
//		level.credits_playing = false; // Thad end credits
	}
	else
	{
		ender = false;
	}
		
	newStr = newHudElem();
	newStr setText(src.string);
	newStr.placement = src.placement;
	newStr.location = src.location;
	newStr.sort = src.sort;
	newStr.fontScale = src.fontScale;
	// Move words back to center after visual credits end
	if ((newStr.fontScale == 1.25) && (flag("move center")))
	{
		if (level.check)
			level.won = true;
		level.check = false;
	}
	newStr.alignX = src.alignX;
	
	newStr.x = 630;
		
	if (!level.check)
	{
		newStr.alignX = "center";
		newStr.x = 320;
	}
		
	fade = "in";	
	newStr.alpha = 0;
	newStr fadeOverTime (level.globalTimer/6);
	newStr.alpha = 1;
	
	placement = 370;
	timer = level.globalTimer;
	
	newStr.y = 370;
	newStr moveOverTime(timer);
	newStr.y = 100;
	wait (timer - (level.globalTimer/6));
	newStr fadeOverTime (level.globalTimer/6);
	newStr.alpha = 0;
	wait (2);

	newStr destroy();	

//	println("ENDER = ",ender);
	if (!ender)
	{
		return;
	}

	wait (1);
	flag_set ("credits done");
}
	

lookat (ent, timer)
{
	if (!isdefined (timer))
		timer = 10000;

	self animscripts\shared::lookatentity(ent, timer, "alert");
}

array_thread (ents, process, var, excluders)
{
	maps\_utility_gmi::array_thread (ents, process, var, excluders);
}

array_levelthread (ents, process, var, excluders)
{
	maps\_utility_gmi::array_levelthread (ents, process, var, excluders);
}


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
	println("^2newguy: ",newguy[0]);
	maps\_anim_gmi::anim_single (newguy, anime, tag, node, tag_entity);
}

anim_single_queue (guy, anime, tag, node, tag_entity)
{
	maps\_anim_gmi::anim_single_queue (guy, anime, tag, node, tag_entity);
}

anim_reach (guy, anime, tag, node, tag_entity)
{
	maps\_anim_gmi::anim_reach (guy, anime, tag, node, tag_entity);
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
	println("^3MSG = ",msg);
	level.flag[msg] = true;
	level notify (msg);
}

checkLev()
{
	if (getcvar("game_completed") == "yup_yup")
	{
		level.check = true;
		level.check2 = false;
	}
	else 
	{
		if(getcvar("game_completed") == "yup_yup2")
		{
			level.check2 = true;
			level.check = false;
		}
		else
		{
			level.check = false;
			level.check2 = false;
		}
	}
}

waittill_either_think (ent, msg)
{
//	println (ent, "^1 is waiting for ", msg);
	ent waittill (msg);
//`	println (ent, "^1 got ", msg);
	self notify ("got notify");
}

waittill_either(waiter, msg1, msg2, msg3 )
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


assignanimtree()
{
	self UseAnimTree(level.scr_animtree[self.animname]);
}

precacheCredits ()
{
	precacheString(&"GMI_CREDIT_GRAY_MATTER_STUDIOS");
	precacheString(&"GMI_CREDIT_ART_AND_ANIMATION");
	precacheString(&"GMI_CREDIT_BRIAN_ANDERSON");
	precacheString(&"GMI_CREDIT_SLOAN_ANDERSON");
	precacheString(&"GMI_CREDIT_ISABELLE_DECENCIERE");
	precacheString(&"GMI_CREDIT_JASON_HOOVER");
	precacheString(&"GMI_CREDIT_DAN_MODITCH");
	precacheString(&"GMI_CREDIT_TOM_SZAKOLCZAY");
	precacheString(&"GMI_CREDIT_COLIN_WHITNEY");
	precacheString(&"GMI_CREDIT_LEVEL_DESIGN_AND_SCRIPTING");
	precacheString(&"GMI_CREDIT_JOE_CHIANG");
	precacheString(&"GMI_CREDIT_MIKE_DENNY");
	precacheString(&"GMI_CREDIT_JEREMY_LUYTIES");
	precacheString(&"GMI_CREDIT_NIKOLAI_MOHILCHOCK");
	precacheString(&"GMI_CREDIT_PAUL_SANDLER");
	precacheString(&"GMI_CREDIT_THADDEUS_SASSER");
	precacheString(&"GMI_CREDIT_NATHAN_SILVERS");
	precacheString(&"GMI_CREDIT_SEAN_SOUCY");	
	precacheString(&"GMI_CREDIT_JESSE_SNYDER");
	precacheString(&"GMI_CREDIT_KEVIN_WORREL");
	precacheString(&"GMI_CREDIT_PROGRAMMING");
	precacheString(&"GMI_CREDIT_JED_ADAMS");
	precacheString(&"GMI_CREDIT_ALEXANDER_CONSERVA");
	precacheString(&"GMI_CREDIT_RYAN_FELTRAIN");
	precacheString(&"GMI_CREDIT_SOUND_FX_ENGINEERING");
	precacheString(&"GMI_CREDIT_STEVE GOLDBERG");
	precacheString(&"GMI_CREDIT_ADMINISTRATIVE_ASSISTANT");
	precacheString(&"GMI_CREDIT_ERIKA_NARIMATSU");
	precacheString(&"GMI_CREDIT_ART_DIRECTOR");
	precacheString(&"GMI_CREDIT_CORKY_LEHMKUHL");
	precacheString(&"GMI_CREDIT_CREATIVE_LEAD");
	precacheString(&"GMI_CREDIT_RICHARD_FARRELLY");
	precacheString(&"GMI_CREDIT_LEAD_DESIGNER");
	precacheString(&"GMI_CREDIT_DANIEL_KOPPEL");
	precacheString(&"GMI_CREDIT_SENIOR_PRODUCER");
	precacheString(&"GMI_CREDIT_ROBB_ALVEY");
	precacheString(&"GMI_CREDIT_TECH_DIR");
	precacheString(&"GMI_CREDIT_JM_MOREAL");
	precacheString(&"GMI_CREDIT_DOMINIQUE_DROZDZ");
	precacheString(&"GMI_CREDIT_DOMINIQUE_DROZDZ2");
	precacheString(&"GMI_CREDIT_ACTIVISION");
	precacheString(&"GMI_CREDIT_PRODUCER");
	precacheString(&"GMI_CREDIT_DOUG_PEARSON");
	precacheString(&"GMI_CREDIT_EXECUTIVE_PRODUCER");
	precacheString(&"GMI_CREDIT_MARC_STRUHL");
	precacheString(&"GMI_CREDIT_ASSOCIATE_PRODUCER");
	precacheString(&"GMI_CREDIT_DAN_HAGERTY");
	precacheString(&"GMI_CREDIT_PRODUCTION_COORDINATOR");
	precacheString(&"GMI_CREDIT_MATT_BURNS");
	precacheString(&"GMI_CREDIT_NATE_MCCLURE");
	precacheString(&"GMI_CREDIT_PRODUCTION_TESTER");
	precacheString(&"GMI_CREDIT_ROBERT_KIRSCHENBAUM");
	precacheString(&"GMI_CREDIT_ISMAEL_GARCIA");
	precacheString(&"GMI_CREDIT_VP_NORTH_AMERICAN_STUDIOS1");
	precacheString(&"GMI_CREDIT_MARK_LAMIA");
	precacheString(&"GMI_CREDIT_PRES_ACTIVISION_PUBLISH");
	precacheString(&"GMI_CREDIT_KATHY_VRABECK1");
	precacheString(&"GMI_CREDIT_ADD_CONTENT");
	precacheString(&"GMI_CREDIT_ADDITIONAL_ANIMATION");
	precacheString(&"GMI_CREDIT_ADDITIONAL_ANIMATION2");
	precacheString(&"GMI_CREDIT_ADDITIONAL_ANIMATION3");
	precacheString(&"GMI_CREDIT_ADDITIONAL_ANIMATION4");
	precacheString(&"GMI_CREDIT_INFINITY_WARD");
	precacheString(&"GMI_CREDIT_LEVEL_DESIGN");
	precacheString(&"GMI_CREDIT_CHAD_GRENIER");
	precacheString(&"GMI_CREDIT_TODD_ALDERMAN");
	precacheString(&"GMI_CREDIT_KEITH_BELL");
	precacheString(&"GMI_CREDIT_MOHAMMED_ALAVI");
	precacheString(&"GMI_CREDIT_ANIMATION");
	precacheString(&"GMI_CREDIT_CHANCE_GLASCO");
	precacheString(&"GMI_CREDIT_PAUL_MESSERLY");
	precacheString(&"GMI_CREDIT_PRODUCER");
	precacheString(&"GMI_CREDIT_KEN_TURNER");	
	precacheString(&"GMI_CREDIT_ASSOCIATE_PRODUCER");
	precacheString(&"GMI_CREDIT_ERIC_JOHNSEN");
	precacheString(&"GMI_CREDIT_PI_STUDIOS");
	precacheString(&"GMI_CREDIT_ROBERT_ERWIN");
	precacheString(&"GMI_CREDIT_JOHN_FAULKENBURY");
	precacheString(&"GMI_CREDIT_ROB_HEIRONIMUS");
	precacheString(&"GMI_CREDIT_DIRK_JONES");
	precacheString(&"GMI_CREDIT_DAN_KRAMER");
	precacheString(&"GMI_CREDIT_CAMERON_LAMPRECHT");
	precacheString(&"GMI_CREDIT_PETER_MACK");
	precacheString(&"GMI_CREDIT_DAVID_MERTZ");
	precacheString(&"GMI_CREDIT_DANIEL_YOUNG");
	precacheString(&"GMI_CREDIT_STANJEL");
	precacheString(&"GMI_CREDIT_ROGER_ABRAHAMSSON");
	precacheString(&"GMI_CREDIT_SCRIPT_AND_VOICE");
	precacheString(&"GMI_CREDIT_SCRIPTWRITER");
	precacheString(&"GMI_CREDIT_MICHAEL_SCHIFFER");
	precacheString(&"GMI_CREDIT_ADDITIONAL_WRITING");
	precacheString(&"GMI_CREDIT_MILITARY_ADVISORS");
	precacheString(&"GMI_CREDIT_MILITARY_ADVISORS2");
	precacheString(&"GMI_CREDIT_MILITARY_ADVISORS3");
	precacheString(&"GMI_CREDIT_RICHARD_FARRELLY");
	precacheString(&"GMI_CREDIT_CASTING_AND_VOICE_DIRECTION");
	precacheString(&"GMI_CREDIT_WOMB_MUSIC");
	precacheString(&"GMI_CREDIT_VOICE_TALENT");
	precacheString(&"GMI_CREDIT_STEVE_BLUM");
	precacheString(&"GMI_CREDIT_ROBIN_ATKIN_DOWNES");
	precacheString(&"GMI_CREDIT_SCOTT_BULLOCK");
	precacheString(&"GMI_CREDIT_NEIL_ROSS1");
	precacheString(&"GMI_CREDIT_SCOTT_MENVILLE");
	precacheString(&"GMI_CREDIT_JIM_WARD1");
	precacheString(&"GMI_CREDIT_DEE_BAKER");
	precacheString(&"GMI_CREDIT_JAMIE_ALCROFT");
	precacheString(&"GMI_CREDIT_NICK_JAMESON");
	precacheString(&"GMI_CREDIT_CAM_CLARKE");
	precacheString(&"GMI_CREDIT_ANDRE_SOGLIUZZO1");
	precacheString(&"GMI_CREDIT_GRANT_ALBRECHT");
	precacheString(&"GMI_CREDIT_GREG_ELLIS");
	precacheString(&"GMI_CREDIT_JAY_GORDON");
	precacheString(&"GMI_CREDIT_MATT_MORTON1");
	precacheString(&"GMI_CREDIT_BILL_HARPER");
	precacheString(&"GMI_CREDIT_QUINTON_FLYNN1");
	precacheString(&"GMI_CREDIT_RECORDING");
	precacheString(&"GMI_CREDIT_RIK_W");
	precacheString(&"GMI_CREDIT_VOICES_RECORDED_AT_SALAMI_STUDIOS_AND_THE_CASTLE");
	precacheString(&"GMI_CREDIT_MUSIC_AND_SOUND_EFFECTS");
	precacheString(&"GMI_CREDIT_ORIGINAL_MUSICAL_SCORE");
	precacheString(&"GMI_CREDIT_MICHAEL_GIACCHINO");
	precacheString(&"GMI_CREDIT_ADDITIONAL_MUSIC");
	precacheString(&"GMI_CREDIT_JUSTIN_SKOMAROVSKY");
	precacheString(&"GMI_CREDIT_GLOBAL_BRAND_MANAGEMENT");
	precacheString(&"GMI_CREDIT_GLOBAL_BRAND_MANAGEMENT_DAVID");
	precacheString(&"GMI_CREDIT_BRAND_MANAGER");
	precacheString(&"GMI_CREDIT_BRAD_CARRAWAY");
	precacheString(&"GMI_CREDIT_ASSOCIATE_BRAND_MANAGER");
	precacheString(&"GMI_CREDIT_RICHARD_BREST");
	precacheString(&"GMI_CREDIT_DIRECTOR_GBM");
	precacheString(&"GMI_CREDIT_MICHELLE_NINO");
	precacheString(&"GMI_CREDIT_VP_GBM");
	precacheString(&"GMI_CREDIT_DUSTY_WELCH");
	precacheString(&"GMI_CREDIT_SENIOR_PUBLICIST");
	precacheString(&"GMI_CREDIT_MIKE_MANTARRO");
	precacheString(&"GMI_CREDIT_PUBLICIST");
	precacheString(&"GMI_CREDIT_MACLEAN_MARSHALL");
	precacheString(&"GMI_CREDIT_DIRECTOR_CORP_COMMUNICATIONS");
	precacheString(&"GMI_CREDIT_MICHELLE_NINO");
	precacheString(&"GMI_CREDIT_VP_TRADE_MARKETING");
	precacheString(&"GMI_CREDIT_TRICIA_BERTERO");
	precacheString(&"GMI_CREDIT_NORTH_AMERICAN_SALES");
	precacheString(&"GMI_CREDIT_NORTH_AMERICAN_SALES2");
	precacheString(&"GMI_CREDIT_TRADE_MARKETING_MANAGER");
	precacheString(&"GMI_CREDIT_JULIE_DEWOLF");
	precacheString(&"GMI_CREDIT_AMY_LONGHI");
	precacheString(&"GMI_CREDIT_BUSINESS_LEGAL_AFFAIRS");
	precacheString(&"GMI_CREDIT_DIRECTOR_B_L");
	precacheString(&"GMI_CREDIT_GREG_DEUTSCH");
	precacheString(&"GMI_CREDIT_SENIOR_VP_BL");
	precacheString(&"GMI_CREDIT_GEORGE_ROSE");
	precacheString(&"GMI_CREDIT_CREATIVE_SERVICES");
	precacheString(&"GMI_CREDIT_DENISE_WALSH");
	precacheString(&"GMI_CREDIT_DENISE_WALSH2");
	precacheString(&"GMI_CREDIT_MATHEW_STAINNER");
	precacheString(&"GMI_CREDIT_MATHEW_STAINNER2");
	precacheString(&"GMI_CREDIT_JILL_BARRY");
	precacheString(&"GMI_CREDIT_JILL_BARRY2");
	precacheString(&"GMI_CREDIT_SHELBY_YATES");
	precacheString(&"GMI_CREDIT_SHELBY_YATES2");
	precacheString(&"GMI_CREDIT_HAMAGAMI_CARROLL");
	precacheString(&"GMI_CREDIT_HAMAGAMI_CARROLL2");
	precacheString(&"GMI_CREDIT_IGNITED_MINDS");
	precacheString(&"GMI_CREDIT_IGNITED_MINDS2");
	precacheString(&"GMI_CREDIT_INTERNATIONAL");
	precacheString(&"GMI_CREDIT_SCOTT_DODKINS");
	precacheString(&"GMI_CREDIT_SCOTT_DODKINS2");
	precacheString(&"GMI_CREDIT_ROGER_WALKDEN");
	precacheString(&"GMI_CREDIT_ROGER_WALKDEN2");
	precacheString(&"GMI_CREDIT_ALISON_TURNER");
	precacheString(&"GMI_CREDIT_ALISON_TURNER2");
	precacheString(&"GMI_CREDIT_TIM_PONTING");
	precacheString(&"GMI_CREDIT_TIM_PONTING2");
	precacheString(&"GMI_CREDIT_NATHALIE_RANSON");
	precacheString(&"GMI_CREDIT_NATHALIE_RANSON2");
	precacheString(&"GMI_CREDIT_TAMSIN_LUCAS1");
	precacheString(&"GMI_CREDIT_TAMSIN_LUCAS12");
	precacheString(&"GMI_CREDIT_JACKIE_SUTTON");
	precacheString(&"GMI_CREDIT_JACKIE_SUTTON2");
	precacheString(&"GMI_CREDIT_SIMON_DAWES");
	precacheString(&"GMI_CREDIT_SIMON_DAWES2");
	precacheString(&"GMI_CREDIT_PHILIP_BAGNALL");
	precacheString(&"GMI_CREDIT_PHILIP_BAGNALL2");
	precacheString(&"GMI_CREDIT_DALEEP_CHHABRIA");
	precacheString(&"GMI_CREDIT_DALEEP_CHHABRIA2");
	precacheString(&"GMI_CREDIT_HEATHER_CLARKE");
	precacheString(&"GMI_CREDIT_HEATHER_CLARKE2");
	precacheString(&"GMI_CREDIT_VICTORIA_FISHER");
	precacheString(&"GMI_CREDIT_VICTORIA_FISHER2");
	precacheString(&"GMI_CREDIT_LYNNE_MOSS");
	precacheString(&"GMI_CREDIT_LYNNE_MOSS2");
	precacheString(&"GMI_CREDIT_GERMAN_LOCALIZATION");
	precacheString(&"GMI_CREDIT_GERMAN_LOCALIZATION2");
	precacheString(&"GMI_CREDIT_FRENCH_LOCALIZATION");
	precacheString(&"GMI_CREDIT_FRENCH_LOCALIZATION2");
	precacheString(&"GMI_CREDIT_ITALIAN_SPANISH_LOCALIZATION");
	precacheString(&"GMI_CREDIT_ITALIAN_SPANISH_LOCALIZATION2");
	precacheString(&"GMI_CREDIT_JAPANESE_LOCALIZATION");
	precacheString(&"GMI_CREDIT_JAPANESE_LOCALIZATION2");
	precacheString(&"GMI_CREDIT_CHINESE_LOCALIZATION");
	precacheString(&"GMI_CREDIT_CHINESE_LOCALIZATION2");
	precacheString(&"GMI_CREDIT_KOREAN_LOCALIZATION");
	precacheString(&"GMI_CREDIT_KOREAN_LOCALIZATION2");
	precacheString(&"GMI_CREDIT_ACTIVISION_GERMANY");
	precacheString(&"GMI_CREDIT_STEFAN_LULUDES");
	precacheString(&"GMI_CREDIT_BERND_REINARTZ");
	precacheString(&"GMI_CREDIT_JULIA_VOLKMANN");
	precacheString(&"GMI_CREDIT_STEFAN_SEIDEL");
	precacheString(&"GMI_CREDIT_THORSTEN_HMANN");
	precacheString(&"GMI_CREDIT_ACTIVISION_FRANCE");
	precacheString(&"GMI_CREDIT_BERNARD_SIZEY");
	precacheString(&"GMI_CREDIT_GUILLAUME_LAIRAN");
	precacheString(&"GMI_CREDIT_GAUTIER_ORMANCEY");
	precacheString(&"GMI_CREDIT_DIANE_DE_DOMECY");
	precacheString(&"GMI_CREDIT_CENTRAL_TECHNOLOGY");
	precacheString(&"GMI_CREDIT_ED_CLUNE");
	precacheString(&"GMI_CREDIT_ANDREW_PETTERSON");
	precacheString(&"GMI_CREDIT_INFORMATION_TECHNOLOGY");
	precacheString(&"GMI_CREDIT_NIEL_ARMSTRONG");
	precacheString(&"GMI_CREDIT_DAVID_SMITH");
	precacheString(&"GMI_CREDIT_ERWIN_BARCEGA");
	precacheString(&"GMI_CREDIT_RICARDO_ROMERO");
	precacheString(&"GMI_CREDIT_JASON_MCAULIFFE");
	precacheString(&"GMI_CREDIT_BRYAN_FUNG");
	precacheString(&"GMI_CREDIT_QUALITY_ASSURANCE_CUSTOMER_SUPPORT");
	precacheString(&"GMI_CREDIT_ERIK_MELEN");
	precacheString(&"GMI_CREDIT_GLENN_VISTANTE");
	precacheString(&"GMI_CREDIT_MARILENA_RIXFORD");
	precacheString(&"GMI_CREDIT_MATT_MCCLURE");
	precacheString(&"GMI_CREDIT_DONALD_MARSHALL");
	precacheString(&"GMI_CREDIT_TESTERS");
//	precacheString(&"GMI_CREDIT_TESTERS_NAMES");

	// TESTER NAMES BEGIN
	precacheString(&"GMI_CREDIT_TESTER_AVERY_BENNET");
	precacheString(&"GMI_CREDIT_TESTER_CRIS_ONEILL");
	precacheString(&"GMI_CREDIT_TESTER_JASON_RALYA");
	precacheString(&"GMI_CREDIT_TESTER_MATTHEW_BROWN");
	precacheString(&"GMI_CREDIT_TESTER_JIM_NORRIS");
	precacheString(&"GMI_CREDIT_TESTER_PETER_MCKERNAN");
	precacheString(&"GMI_CREDIT_TESTER_SCOTT_SOLTERO");
	precacheString(&"GMI_CREDIT_TESTER_DANIEL_YOON");
	precacheString(&"GMI_CREDIT_TESTER_JASON_GUYAN");
	precacheString(&"GMI_CREDIT_TESTER_JULIO_RODRIGUEZ");
	precacheString(&"GMI_CREDIT_TESTER_MATTHEW_MURRAY");
	precacheString(&"GMI_CREDIT_TESTER_SERG_SOULEIMAN");
	precacheString(&"GMI_CREDIT_TESTER_ADAM_LUSKIN");
	precacheString(&"GMI_CREDIT_TESTER_TRAVIS_CUMMINGS");
	precacheString(&"GMI_CREDIT_TESTER_EVAN_VINCENT");
	precacheString(&"GMI_CREDIT_TESTER_MIKE_SALWET");
	precacheString(&"GMI_CREDIT_TESTER_ROBERT_DION");
	precacheString(&"GMI_CREDIT_TESTER_FRANKIE_GUTIERREZ");
	precacheString(&"GMI_CREDIT_TESTER_JOHN_SHUBERT");
	precacheString(&"GMI_CREDIT_TESTER_ALBERT_YAO");
	precacheString(&"GMI_CREDIT_TESTER_DAVID_MOYA");
	precacheString(&"GMI_CREDIT_TESTER_PETER_VON_OY");
	precacheString(&"GMI_CREDIT_TESTER_JIM_CHENG");
	// END TESTER NAMES

	precacheString(&"GMI_CREDIT_CHRIS_KEIM");
	precacheString(&"GMI_CREDIT_NEIL_BARIZO");
	precacheString(&"GMI_CREDIT_FRANCIS_JIMENEZ");
	precacheString(&"GMI_CREDIT_FRANCIS_JIMENEZ2");
	precacheString(&"GMI_CREDIT_COMPATIBILITY_TESTERS");
	precacheString(&"GMI_CREDIT_COMPATIBILITY_TESTERS2");
	precacheString(&"GMI_CREDIT_COMPATIBILITY_TESTERS3");
	precacheString(&"GMI_CREDIT_TIM_VANLAW");
	precacheString(&"GMI_CREDIT_JEF_SEDIVY");
	precacheString(&"GMI_CREDIT_CRG_TESTERS");
	precacheString(&"GMI_CREDIT_CRG_TESTERS2");
	precacheString(&"GMI_CREDIT_CRG_TESTERS3");
	precacheString(&"GMI_CREDIT_CRG_TESTERS4");
	precacheString(&"GMI_CREDIT_CRG_TESTERS5");
	precacheString(&"GMI_CREDIT_LOCALIZATION_PROJECT_LEAD");
	precacheString(&"GMI_CREDIT_ANTHONY_HATCH_KOROTKO");
	precacheString(&"GMI_CREDIT_ADAM_HARTSFIELD");
	precacheString(&"GMI_CREDIT_LOCALIZATIONS_TEST_TEAM");

	// LOC TEST TEAM BEGIN
	precacheString(&"GMI_CREDIT_LOCALIZATIONS_TEAM_TESTERS");
	precacheString(&"GMI_CREDIT_LOC_TESTER_JASON_SMITH");
	precacheString(&"GMI_CREDIT_LOC_TESTER_JASON_GILMORE");
	precacheString(&"GMI_CREDIT_LOC_TESTER_AARON_SEDILLO");
	precacheString(&"GMI_CREDIT_LOC_TESTER_EDMUND_PARK");
	precacheString(&"GMI_CREDIT_LOC_TESTER_KENDRICK_HSU");
	precacheString(&"GMI_CREDIT_LOC_TESTER_DAN_ROHAN");
	precacheString(&"GMI_CREDIT_LOC_TESTER_DAVID_HADDOCK");
	precacheString(&"GMI_CREDIT_LOC_TESTER_AKSHAY");
	
	precacheString(&"GMI_CREDIT_LOC_TESTER_HOAN_BUI");
	// LOC TEST TEAM END

	precacheString(&"GMI_CREDIT_LOCALIZATIONS_TEAM_TESTERS");
	precacheString(&"GMI_CREDIT_BOB_MCPHERSON");
	precacheString(&"GMI_CREDIT_BOB_MCPHERSON2");
	precacheString(&"GMI_CREDIT_GARY_BOLDUC");
	precacheString(&"GMI_CREDIT_MICHAEL_HILL");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS");

	precacheString(&"GMI_CREDIT_JOHN_BOJORQUEZ");
	precacheString(&"GMI_CREDIT_BRANDON_GRADA");
	precacheString(&"GMI_CREDIT_BRADLY_SHAW");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_RATUMS_THE_HAMSTER");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_ANNABELLE");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_COMPANY");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_VALERIE_FARRELLY");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_ETHAN_F");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_ELLISA");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_BARB");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_EDWIN");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_SOFIA");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_SOUCY2");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_SOUCY3");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_SOUCY4");

	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_SEAN");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_LORNA");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_ALEX");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_ANNA");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_CAITLIN");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_CHANG");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_BA");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_WENDY");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_TED");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_RUBY");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_ELISABETH");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_IGOR");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_SEA");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_STACY");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_DALE");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_YELA");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_SCHLEH");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_DELEON");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_ROBERT");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_MODITCH");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_MODITCH2");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_DARA");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_JIM");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_JERRI");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_JASON_W");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_MANDI");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_HENNY");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_MIKE_DAD");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_ADAMS");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_ADAMS2");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_SANDI");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_JULIEANNE_CONSERVA");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_SHUCK");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_WAVE");
	precacheString(&"GMI_CREDIT_GMI_SPECIAL_THANKS_SPARK");
	precacheString(&"GMI_CREDIT_GMI_CREDIT_JOHN_BOJORQUEZ");
	precacheString(&"GMI_CREDIT_PI_SPECIAL_THANKS");
	precacheString(&"GMI_CREDIT_CHRISTIAN_CUMMINGS");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_DOORNINK");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_BRAD_CARRAWAY");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_KEN_MURPHY");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_CARYN_LAW");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_STEVE_HOLMES");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_MATTHEW_BEAL");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_JASON_KIM");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_STACY_SCOOTER");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_BULLIS");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_ROHRA");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_FRITTS");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_CLARENCE_WASHINGTON");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_DION_BRAIN");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_MICHAEL_CARTER");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_SUZY_LUKO");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_BARAJAS");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_DANIELLE_KIM");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_MICHAEL_LARSON");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_JAY_KOMAS");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_BETTY_KIM");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_LORI_PAGER");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_LETTY_CADENA");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_JUSTIN_BERENBAUM");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_JIM_BLACK");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_MITCH_SOULE");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_REX_SIKORA");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_EDDIE_BANKS");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_NANCY_WOLFE");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_CATHY_KINZER");
	precacheString(&"GMI_CREDIT_ACTIVISION_SPECIAL_THANKS_NAMES");
	precacheString(&"GMI_CREDIT_QA_SPECIAL_THANKS");
	precacheString(&"GMI_CREDIT_QA_THANKS_NAMES");

	//  GMI_CREDIT_QA_THANKS_NAMES begin
	precacheString(&"GMI_CREDIT_QA_THANKS_JIM_SUMMERS");
	precacheString(&"GMI_CREDIT_QA_THANKS_JASON_WONG");
	precacheString(&"GMI_CREDIT_QA_THANKS_MARILENA_RIXFORD");
	precacheString(&"GMI_CREDIT_QA_THANKS_JOE_FAVAZZA");
	precacheString(&"GMI_CREDIT_QA_THANKS_JASON_LEVINE");
	precacheString(&"GMI_CREDIT_QA_THANKS_NADINE_THEUZILLOT");
	precacheString(&"GMI_CREDIT_QA_THANKS_JASON_POTTER");
	precacheString(&"GMI_CREDIT_QA_THANKS_JOHN_ROSSER");
	precacheString(&"GMI_CREDIT_QA_THANKS_CHAD_SIEDHOFF");
	precacheString(&"GMI_CREDIT_QA_THANKS_INDRA_YEE");
	precacheString(&"GMI_CREDIT_QA_THANKS_TODD_KOMESU");
	precacheString(&"GMI_CREDIT_QA_THANKS_JOULE_MIDDLETON");
	precacheString(&"GMI_CREDIT_QA_THANKS_JENNIFER_VITIELLO");
	precacheString(&"GMI_CREDIT_QA_THANKS_MIKE_RIXFORD");
	precacheString(&"GMI_CREDIT_QA_THANKS_JESSICA_MCCLURE");
	precacheString(&"GMI_CREDIT_QA_THANKS_JOANNE_SHINOZAKI");
	precacheString(&"GMI_CREDIT_QA_THANKS_JB_BERNSTEIN");

	//  GMI_CREDIT_QA_THANKS_NAMES end
	precacheString(&"GMI_CREDIT_CHAPTER_BRIEF1");
	precacheString(&"GMI_CREDIT_EDWARD_F");
	precacheString(&"GMI_CREDIT_INTRODUCTION_CINEMATIC");
	precacheString(&"GMI_CREDIT_INTRODUCTION_CINEMATIC2");
	precacheString(&"GMI_CREDIT_ANT_FARM");
	precacheString(&"GMI_CREDIT_ANT_FARM2");
	precacheString(&"GMI_CREDIT_CINEMATIC_AUDIO_PROCESSING_BY");
	precacheString(&"GMI_CREDIT_CINEMATIC_AUDIO_PROCESSING_BY2");
	precacheString(&"GMI_CREDIT_SONIC_POOL");
	precacheString(&"GMI_CREDIT_PUNK_BUSTER");
	precacheString(&"GMI_CREDIT_PUNK_BUSTER2");
	precacheString(&"GMI_CREDIT_TONY_RAY");
	precacheString(&"GMI_CREDIT_THANKS1");
	precacheString(&"GMI_CREDIT_THANKS1a");
	precacheString(&"GMI_CREDIT_THANKS1b");
	precacheString(&"GMI_CREDIT_THANKS2");
	precacheString(&"GMI_CREDIT_THANKS2aa");
	precacheString(&"GMI_CREDIT_THANKS2b");
	precacheString(&"GMI_CREDIT_THANKS2a");
	precacheString(&"GMI_CREDIT_INFINITY_WARD");
	precacheString(&"GMI_CREDIT_TODD_ALDERMAN");
	precacheString(&"GMI_CREDIT_BRAD_ALLEN");
	precacheString(&"GMI_CREDIT_KEITH_BELL");
	precacheString(&"GMI_CREDIT_MICHAEL_BOON");
	precacheString(&"GMI_CREDIT_KEVIN_CHEN");
	precacheString(&"GMI_CREDIT_CLIFTON_CLINE");
	precacheString(&"GMI_CREDIT_GRANT_COLLIER");
	precacheString(&"GMI_CREDIT_URSULA_ESCHER");
	precacheString(&"GMI_CREDIT_ROBERT_FIELD");
	precacheString(&"GMI_CREDIT_STEVE_FUKUDA");
	precacheString(&"GMI_CREDIT_OLIVER_GEORGE");
	precacheString(&"GMI_CREDIT_FRANK_GIGLIOTTI");
	precacheString(&"GMI_CREDIT_CHANCE_GLASCO");
	precacheString(&"GMI_CREDIT_CARL_GLAVE");
	precacheString(&"GMI_CREDIT_PRESTON_GLENN");
	precacheString(&"GMI_CREDIT_CHAD_GRENIER");
	precacheString(&"GMI_CREDIT_JACK_GRILLO");
	precacheString(&"GMI_CREDIT_EARL_HAMMON");
	precacheString(&"GMI_CREDIT_CHRIS_HASSELL");
	precacheString(&"GMI_CREDIT_JEFF_HEATH");
	precacheString(&"GMI_CREDIT_CHRIS_HERMANS");
	precacheString(&"GMI_CREDIT_PAUL_JURY");
	precacheString(&"GMI_CREDIT_BRYAN_KUHN");
	precacheString(&"GMI_CREDIT_SCOTT_MATLOFF");
	precacheString(&"GMI_CREDIT_FAIRFAX");
	precacheString(&"GMI_CREDIT_GAVIN_MCCANDLISH");
	precacheString(&"GMI_CREDIT_PAUL_MESSERLY");
	precacheString(&"GMI_CREDIT_DAVID_OBERLIN");
	precacheString(&"GMI_CREDIT_ZIED_RIEKE");
	precacheString(&"GMI_CREDIT_CHUCK_RUSSOM");
	precacheString(&"GMI_CREDIT_NATE_SILVERS");
	precacheString(&"GMI_CREDIT_JUSTIN_THOMAS");
	precacheString(&"GMI_CREDIT_JANICE_TURNER");
	precacheString(&"GMI_CREDIT_KEN_TURNER");
	precacheString(&"GMI_CREDIT_JASON_WEST");
	precacheString(&"GMI_CREDIT_VINCE_ZAMPELLA");
	precacheString(&"GMI_CREDIT_ACTIVISION_PRODUCTION");
	precacheString(&"GMI_CREDIT_ACTIVISION_PRODUCTION2");
	precacheString(&"GMI_CREDIT_THAINE_LYMAN");
	precacheString(&"GMI_CREDIT_KEN_MURPHY");
	precacheString(&"GMI_CREDIT_DAN_HAGERTY");
	precacheString(&"GMI_CREDIT_ERIC_GROSSMAN");
	precacheString(&"GMI_CREDIT_PATRICK_BOWMAN");
	precacheString(&"GMI_CREDIT_ROB_KIRSCHENBAUM");
	precacheString(&"GMI_CREDIT_LAIRD_MALAMED");
	precacheString(&"GMI_CREDIT_MARK_LAMIA");
	precacheString(&"GMI_CREDIT_LICENSES");
	precacheString(&"GMI_CREDIT_ID");
	precacheString(&"GMI_CREDIT_ID2");
	precacheString(&"GMI_CREDIT_BINK");
	precacheString(&"GMI_CREDIT_MILES");
	precacheString(&"GMI_CREDIT_BRANDON_GRADA");
	precacheString(&"GMI_CREDIT_BRADLY_SHAW");
	precacheString(&"GMI_CREDIT_GREGG_BERGER");
	precacheString(&"GMI_CREDIT_PRODUCTION");
	precacheString(&"GMI_CREDIT_GLOBAL_BRAND_TITLE");

	// Unrelated to the actual credits:
	precacheString(&"GMI_CREDIT_PREVIOUSLY");
}

// NEW STUFF
//-----------

Weather(trigger)
{
	trigger waittill("trigger");

	if(trigger.script_noteworthy == "stop")
	{
		num = getcvarint("cg_atmosDense");
		wait 0.1;
	
		while(num < 200)
		{
			wait 0.25;
			num += 5;
			setcvar("cg_atmosDense",num);
		}		
	}
	else
	{
		num = 200;
		level.atmosphere_fx = level.atmos[trigger.script_noteworthy];
//		playfxonplayer(level.atmos[trigger.script_noteworthy]);
		level.atmosphere_speed = 0.1;
		level thread maps\_atmosphere::_spawner();
		wait 0.1;
		setcvar("cg_atmosDense",num);
	
		while(num > 50)
		{
			wait 0.25;
			num -= 5;
			setcvar("cg_atmosDense",num);
		}
		setcvar("cg_atmosDense","50");
	}
}

Fog(trigger)
{
	trigger waittill("trigger");

	if(!isdefined(trigger.script_delay))
	{
		trigger.script_delay = 3;
	}

	setCullFog(500, trigger.script_idnumber, 0.0, 0.0, 0.0, trigger.script_delay);
}


// Bastogne1 Section
//-------------------
Enter_Jeep(jeep)
{
	level.ender.animname = "ender";
	level.ender linkto(jeep, "tag_passenger");
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_jumpin"]);
	level.ender waittillmatch ("animdone","end");
	level.ender thread Ender_Jeep_Idle(level.jeep);
	level.flags["ender_in_jeep"] = true;
	level thread moody_drive_idle();

	level thread jeep_lose_control();

	start_node = getvehiclenode(jeep.target,"targetname");
	level.jeep attachpath(start_node);
	level.jeep thread tread_setup();
	level.jeep startpath();

	level thread fake_skids();

	level.ender playsound ("jeep_engine_low");
	wait 1;
	level.ender playsound ("dirt_skid");
	wait 2;
//	level.ender playsound ("jeep_engine_high")

	level.ender playloopsound ("jeep_engine_high");
	jeep.tread_muliplier = 0.5;

	level.jeep waittill("reached_end_node");
	self thread tree_crash_restart_sounds();
	level.ender stoploopsound ("jeep_engine_high");
	level.ender playsound ("vehicle_impact");
	//level notify ("ExitVehicle");
	//level.moodyanim = 0;
	//level.flags["ender_in_jeep"] = false;
	//level thread moody_peugeot_wait();
	level.ender unlink();
	level.ender notify("stop_idle_anim");
	org = spawn("script_origin",(level.ender.origin));
	level.ender linkto(org);
	org.origin = (33153, -301, -91);
	level.ender unlink();
	wait 0.1;
	org delete();
	return;
}

fake_skids()
{
	wait 7;
	level.ender playsound ("dirt_skid");	
	wait 4;
	level.ender playsound ("dirt_skid");	
	wait 4;
	level.ender playsound ("dirt_skid");	
	wait 4;
	level.ender playsound ("dirt_skid");	
	wait 4;
}

tree_crash_restart_sounds()
{
	level.ender playsound ("jeep_start");
	wait 1.1;
	level.ender playsound ("jeep_start");
	wait 1.1;
	level.ender playsound ("jeep_start");
	wait 1.1;
	level.ender playsound ("jeep_start");
}          

Ender_Jeep_Idle(jeep)
{
	level.ender endon("stop_idle_anim");

	level.enderanim = 1;
	lastanim = 0;
	while (1)
	{	
		lastanim = level.enderanim;
		switch (level.enderanim)
		{
			case 0:
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle_idleA"]);
				break;
			case 1:
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle_idleB"]);
				break;
			case 2:
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle_idleC"]);
				break;
			case 3:
//			// ATTACKING EVENT1	
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event1"]);
				level.ender waittillmatch ("animdone","end");
				break;

			case 4:
//			// ATTACKING EVENT2	
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event2"]);
				level.ender waittillmatch ("animdone","end");
				break;
			case 5:
//			// ATTACKING convoy attack1 and 2
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event3in"]);
				level.ender waittillmatch ("animdone","end");	

				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event3_loop"]);
				level.ender waittillmatch ("animdone","end");
				break;
			case 6:
			// crash into tree
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_tree_crash"]);
				level.ender waittillmatch ("animdone","end");
//				level.ender animscripts\shared::PutGunInHand("right");
				break;
			case 7:
			// duck
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_tree_duck"]);
				level.ender waittillmatch ("animdone","end");
//				level.ender animscripts\shared::PutGunInHand("right");
				break;
			case 8:
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_in"]);
				level.ender waittillmatch ("animdone","end");	

				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_out"]);
				level.ender waittillmatch ("animdone","end");
			
				break;
			case 9:
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_in"]);
				level.ender waittillmatch ("animdone","end");	

				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (jeep gettagOrigin ("tag_passenger")), (jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_out"]);
				level.ender waittillmatch ("animdone","end");
				
				break;
		}
		level.ender waittillmatch ("animdone","end");
	}
}

Bastogne1_Panzer()
{
	level thread Bastogne1_TreeBursts();
//	level thread enemy_test();
	level.ender.maxSightDistSqrd = 3000;
	level.ender.ignoreme = true;
	level.ender settakedamage(0);
	level.ender waittill("goal");

	wait 1;

	level.ender.maxSightDistSqrd = 9000000;

	tank = getent("panzer1","targetname");
	path = getvehiclenode("panzer1_start","targetname");
	tank maps\_panzerIV_gmi::init("no_turret");
	tank.attachedpath = path;
	tank attachpath(path);
	tank thread Pathnode_Think();
	tank thread Bastogne1_tank_turret();
	tank startpath();

	tank waittill("reached_end_node");

	level.ender.maxSightDistSqrd = 1;
	level.ender.pacifist = true;
	level.ender.pacifistwait = 0;

	println(level.ender);
	level.ender allowedstances("crouch");
	wait 1;
	level.ender thread anim_single_solo(level.ender, "force_reload");
	wait 0.25;
	level.ender.secondaryweapon = level.ender.weapon;
	level.ender.weapon = "bazooka";
	level.ender waittill("force_reload");

	level.ender allowedstances ("stand");
	wait 1;

	tank.health = 500;

	while(tank.health > 0)
	{
		level.ender anim_single_solo(level.ender, "reload_bazooka");
	
	//	level.ender.enemy = undefined;
		println("level.ender.enemy: ", level.ender.enemy);
	
		level.ender.accuracy = 1.0;
		level.ender FireAtTarget((tank.origin + (0,0,64)), 3, true, completeLastShot, posOverrideEntity, waitForStop);
	//	level.ender animscripts\combat::ShootVolley(completeLastShot, true, tank);

		if(tank.health > 0)
		{
			wait 3;
			level.ender thread anim_single_solo(level.ender, "force_reload");
			wait 0.25;
			level.ender.secondaryweapon = level.ender.weapon;
			level.ender.weapon = "bazooka";
			level.ender waittill("force_reload");
		}
	}
	wait 0.05;
	level.ender settakedamage(1);
	level.ender.maxSightDistSqrd = 9000000;
	level.ender.pacifist = false;
	level.ender.pacifistwait = 0.1;
}

Bastogne1_tank_turret()
{
	self endon ("death");
	while(1)
	{
			target_pos[0] = (33064, -291, 64);
			target_pos[1] = (33064, -299, 30);
			target_pos[2] = (33064, -257, 55);
			target_pos[3] = (33064, -233, 55);

		fired = false;
	
		while(!fired)
		{
			random_num = randomint(target_pos.size);
			
//			dist = distance(self.origin + (0,0,128), random_targ);
//			dist = distance(random_targ);

			trace_result = bulletTrace((self.origin + (0,0,128)), target_pos[random_num], true, undefined);
//			dist2 = distance(self.origin + (0,0,128), trace_result["position"]);

			if(distance(target_pos[random_num], trace_result["position"]) < 1000256)
			{
				self setTurretTargetVec(target_pos[random_num]);
				self waittill("turret_on_target");
				wait 1;
				self FireTurret();
				fired = true;
			}
			wait 0.25;
		}

//		wait 5;
		wait (2.4 + randomfloat(2));
	}
}

Bastogne1_TreeBursts()
{
	trees = getentarray("bastogne1_tree_bursts","targetname");

	trees = maps\_utility::array_randomize(trees);
	level thread TreeBurst_Think(trees, 0.5, 3);
}
enemy_test()
{
	while(1)
	{
		println(level.ender.enemy);
		wait 0.05;
	}
}

// End Bastogne1 Section
//-----------------------


// Start Bastogne2 Section
//-----------------------

Bastogne2_Battle()
{
	trigger = getent("bastogne2_trigger","targetname");
	trigger waittill("trigger");

	wait 1;
	guy_spawner = getent("bastogne2_bike_driver","targetname");
	guy = guy_spawner stalingradspawn();
	if (maps\_utility_gmi::spawn_failed(guy))
	{
		return;
	}
	guy settakedamage(0);
	println("^1BIKE START!!");

	bike = getent("bastogne2_bike","targetname");
	path = getvehiclenode("bastogne2_bike_start","targetname");
	bike.health = 100000;

	guys[0] = guy;
	bike thread maps\_bmwbike_gmi::handle_attached_guys(guys);
	bike thread Bastogne2_Bike_Think(guy);

	bike.attachedpath = path;
	bike attachpath(path);
	bike startpath();
	bike thread Pathnode_Think();
	playfxontag( level._effect["bmw_headlight"], bike,"tag_light");

	level waittill("shoot_flare");

	level.ender.ignoreme = false;

	spawners = getentarray("bastogne2_axis_group1","targetname");
	array_levelthread (spawners, ::creditSpawnerThink, 100);

	playfx (level._effect["bastogne2_flare"], (29856, -136, 300));
//	playfx (level._effect["bastogne2_flare"], (level.ender.origin + (0,0,100)));
	wait 1;
	setCullFog(500, 1200 , 0.0, 0.0, 0.0, 1);

	spawners = getentarray("bastogne2_allies_group1","targetname");
	array_levelthread (spawners, ::creditSpawnerThink, 300);

	level.ender.ignoreme = true;
}

Bastogne2_Bike_Think(guy)
{
	self waittill("reached_end_node");
	guy delete();
	stopattachedfx(self);

	wait 1;
	self delete();
}



// End Bastogne2 Section
//-----------------------

// Start Foy Section
//-----------------------

Foy_Mortar()
{
	trigger = getent("foy_trigger","targetname");
	trigger waittill("trigger");

	level thread Foy_sherman();
	level thread foy_bridge();

	spawners = getentarray("foy_allies_group1","targetname");
	array_levelthread (spawners, ::creditSpawnerThink, 300);

	level.mortar = level._effect["snow_mortar"];	

	orgs = getentarray("foy_mortar1","targetname");
	for(i=0;i<orgs.size;i++)
	{
		orgs[i] thread Mortars();
	}

	level thread Foy_Shellshock();
}

Foy_sherman()
{
	trigger = getent("foy_shellshock","targetname");
	trigger waittill("trigger");
	wait 3;
	sherman1 = spawnVehicle("xmodel/v_us_lnd_sherman_snow", "vclogger", "ShermanTank" ,(0,0,0), (0,0,0) );
	sherman1 thread maps\_sherman_gmi::init();
	sherman1 thread maps\_tankgun_gmi::mgoff(); // Turn OFF MG.
	path1 = getVehicleNode ("sherman_path1","targetname");
 	sherman1 thread maps\_treads_gmi::main();
	sherman1 attachpath(path1);
	sherman1.isalive = 1;
	sherman1.health = (1000000);
	sherman1 startpath();

	// guys setup on the bridge
	spawners = getentarray("foy_allies_group3","targetname");
	array_levelthread (spawners, ::creditSpawnerThink, 300);

	wait 2;

	sherman2 = spawnVehicle("xmodel/v_us_lnd_sherman_snow", "vclogger1", "ShermanTank" ,(0,0,0), (0,0,0) );
	sherman2 thread maps\_sherman_gmi::init();
	sherman2 thread maps\_tankgun_gmi::mgoff(); // Turn OFF MG.
	path2 = getVehicleNode ("sherman_path2","targetname");
 	sherman1 thread maps\_treads_gmi::main();
	sherman2 attachpath(path2);
	sherman2.isalive = 1;
	sherman2.health = (1000000);
	sherman2 startpath();
}

foy_bridge()
{
	trigger = getent("foy_bridge","targetname");
	trigger waittill("trigger");
	println("^3 ********** foy_bridge  triggered *************");

	// guys who come running across the bridge
	spawners = getentarray("foy_allies_group2","targetname");
	array_levelthread (spawners, ::creditSpawnerThink, 1000);

	// axis waiting on the bridge
	spawners = getentarray("foy_axis_group3","targetname");
	array_levelthread (spawners, ::creditSpawnerThink, 1000);

	println("^3 ********** start pics now*************");
	wait 18;
//	level notify ("start slideshow");
	println("^3 ********** start pics now*************");	
	level notify ("start_now_gsc");
}

foy_bridge_end()
{
//	trigger = getent("foy_bridge_end","targetname");
//	trigger waittill("trigger");

//	level notify ("start_now_gsc");

}

Foy_ShellShock()
{
	trigger = getent("foy_shellshock","targetname");
	trigger waittill("trigger");

	level thread ShellShock_Func(5);
	level.ender allowedstances("prone");

	wait 7;
	level.ender allowedstances("prone", "crouch", "stand");
}

// End Foy Section
//-----------------------


// NON-EVENT RELATED FUNCTIONS
//-----------------------------

ShellShock_Func(duration)
{
	earthquake(0.75, 2, level.player.origin, 2250);
	
	if(isalive(level.player))
	{
		wait 0.15;
		level.player viewkick(127, level.player.origin);  //Amount should be in the range 0-127, and is normalized "damage".  No damage is done.
		level.player shellshock("default", duration);
	}
}

Mortars()
{
	level endon ("stop falling mortars");
	maps\_mortar_gmi::setup_mortar_terrain();
	ceiling_dust = getentarray("ceiling_dust","targetname");

	while (1)
	{
		wait (level.mortar_min_delay + randomfloat(level.mortar_max_delay));

		if ((distance(level.ender.origin, self.origin) < level.mortar_maxdist) &&
			(distance(level.ender.origin, self.origin) > level.mortar_mindist))
		{
//			maps\_mortar_gmi::activate_mortar(range, max_damage, min_damage, fQuakepower, iQuaketime, iQuakeradius);
			self Mortar_Boom(self.origin);
			for(i=0;i<ceiling_dust.size;i++)
			{
				if(distance(self.origin, ceiling_dust[i].origin) < 512)
				{
					playfx ( level._effect["ceiling_dust"], ceiling_dust[i].origin );
					ceiling_dust[i] playsound ("dirt_fall");
				}
			}
		}
	}
}

Mortar_Boom (origin, fPower, iTime, iRadius)
{
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

	Mortar_Sound();
	playfx ( level.mortar, origin );
	earthquake(fPower, iTime, origin, iRadius);
}

Mortar_Sound()
{
	if (!isdefined (level.mortar_last_sound))
		level.mortar_last_sound = -1;

	soundnum = 0;
	while (soundnum == level.mortar_last_sound)
		soundnum = randomint(3) + 1;

	level.mortar_last_sound	= soundnum;


	if(isdefined(level.ambient) && level.ambient == "interior")
	{
		if (soundnum == 1)
		{
			self playsound ("shell_explosion_muffled1");
		}
		else
		if (soundnum == 2)
		{
			self playsound ("shell_explosion_muffled2");
		}
		else
		{
			self playsound ("shell_explosion_muffled3");
		}
	}
	else
	{
		if (soundnum == 1)
		{
			self playsound ("shell_explosion1");
		}
		else
		if (soundnum == 2)
		{
			self playsound ("shell_explosion2");
		}
		else
		{
			self playsound ("shell_explosion3");
		}
	}
}

Hud_Text(text, format, x_pos, y_pos, scale, wait_till, time)
{
	if(!isdefined(scale))
	{
		scale = 1;	
	}

	if(!isdefined(format))
	{
		format = "center";
	}

	if(!isdefined(x_pos))
	{
		x_pos = 320;
	}
	
	if(!isdefined(y_pos))
	{
		y_pos = 240;
	}

	newStr = newHudElem();
	newStr setText(text);
	newStr.sort = 6; // 6, just over the letterbox.
	newStr.y = y_pos;
	newStr.x = x_pos;
	newStr.fontScale = scale;
	newStr.alignX = format;

	newStr.alpha = 0;
	newStr fadeOverTime (2);
	newStr.alpha = 1;


	if(isdefined(wait_till))
	{
		level waittill(wait_till);
	}
	else
	{
		if(!isdefined(time))
		{
			time = 3;
		}

		wait time;
	}

	newStr.alpha = 1;
	newStr fadeOverTime (2);
	newStr.alpha = 0;

	wait 3;

	newStr destroy();
}

FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop)
{
	self animscripts\combat_gmi::FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop);
}

// Used for all vehicles in the level...
// When a vehicle gets to a specific node, it will do what we want. I.E. Fire, animate, etc.
Pathnode_Think(no_endon)
{
	if(!isdefined(no_endon) || !no_endon)
	{
		self endon("death");
	}

	self endon("stop_tank_think");

	if(!isdefined(self.attachedpath))
	{
		println("^1NO '.ATTACHEDPATH' FOUND FOR TANK, ",self.targetname);
		return;
	}

	self thread EndNode_Think();

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

	// Checks to see if there is a script_noteworthy on each node for the tank.
	for(i=0;i<pathpoints.size;i++)
	{
		if(isdefined(pathpoints[i].script_noteworthy))
		{
			self setWaitNode(pathpoints[i]);
			self waittill ("reached_wait_node");

			if(isdefined(self.skipto) && self.skipto > 0)
			{
				self.skipto--;
				continue;
			}

			if(pathpoints[i].script_noteworthy == "tank_waitnode")
			{
				self setspeed (0, 5);
				println(self.targetname," ^5Reached WAIT Node");
				self notify("reached_specified_waitnode");
				self disconnectpaths();
				level waittill("T34s_go"); // If you put in the while, take this out.

				println("^2T34s Go!");
				self resumespeed (10);
				self connectpaths();
			}
			else if(pathpoints[i].script_noteworthy == "bike_waitnode")
			{
				self setspeed (0, 10);
				println(self.targetname," ^5Reached WAIT Node");
				self notify("reached_specified_waitnode");
//				self disconnectpaths();
				if(isdefined(pathpoints[i].script_delay))
				{
					if(self.targetname == "bastogne2_bike")
					{
						level notify("shoot_flare");
					}
					wait pathpoints[i].script_delay;
				}
				else
				{
					level waittill("bike_go"); // If you put in the while, take this out.
				}

				println("^2Bike Go!");
				self resumespeed (20);
				self connectpaths();
			}
			else if(pathpoints[i].script_noteworthy == "mg_on")
			{
				self thread maps\_tankgun_gmi::mgon();
			}
			else if(pathpoints[i].script_noteworthy == "mg_off")
			{
				self thread maps\_tankgun_gmi::mgoff();				
			}
		}
	}
}

EndNode_Think()
{
	self waittill("reached_end_node");
	self disconnectpaths();
	println("REACHED END NODE: ",self.origin," ",self.angles);
}

tread_setup()
{
	if(!isdefined(self.treaddist))
		self.treaddist = 92;
	if(!isdefined(self.fullspeed))
		self.fullspeed = 1000.00;

	trightorg = self gettagorigin("tag_wheel_back_right");
	trightang = self.angles;

	tleftorg = self gettagorigin("tag_wheel_back_left");
	tleftang = self.angles;

	right = spawn ("script_origin", (1,1,1));
	left = spawn ("script_origin", (1,1,1));

	angoffset = (32,0,0);
	right.origin = trightorg;
	right.angles = trightang + angoffset;
	left.origin = tleftorg;
	left.angles = tleftang + angoffset;

	right linkto (self);
	left linkto (self);
	self thread tread(left,"back_left");
	self thread tread(right,"back_right");

}

tread(tread,side)
{
	tread endon ("death");
	self endon ("death");
	accdist = 0.001;
	self.watersplashing = 0;
		
	if (!isdefined (level._effect) || !isdefined (level._effect["treads_grass"]))
		maps\_utility_gmi::error ("Tread effects are undefined. Add _treadfx::main(); to this level");
	treadfx = treadget(side);
	while (isdefined (tread))
	{
		oldorg = tread.origin;
 		// MIkeD Modified, to give more a random to the spawning of treadfx (old: wait .11;)
		wait randomfloat(0.1);
		dist = distance(oldorg,tread.origin);
		accdist += dist;
		if(self.speed > 1 && distance(level.player.origin,self.origin) < 6000)
		{
			if(accdist > self.treaddist)
			{
				vectang = anglestoforward(tread.angles);
				speedtimes = self.speed/self.fullspeed;
				vectang = maps\_utility_gmi::vectorMultiply(vectang,speedtimes);
				// MikeD, so we can control the "kickup" of the dust.
				if(isdefined(self.tread_muliplier))
				{
					vectang = maps\_utility_gmi::vectorMultiply(vectang,self.tread_muliplier);
				}
				lastfx = treadfx;
				treadfx = treadget(side);
				if(treadfx != lastfx)
					self notify ("treadtypechanged");
			
				println("TREADFX = ",treadfx);
				if(treadfx != "nofx")
					playfx (treadfx, tread.origin,(0,0,0)-vectang);
				accdist -= self.treaddist;
			}
		}

	}
}

treadget(side)
{
	surface = self getwheelsurface(side);  // might need to make different effects for different vehicles someday.
	if(surface == "grass")
		treadfx = level._effect["treads_grass"];
	else if(surface == "sand")
		treadfx = level._effect["treads_sand"];
	else if(surface == "dirt")
		treadfx = level._effect["treads_dirt"];
	else if(surface == "rock")
		treadfx = level._effect["treads_rock"];
	else if(surface == "snow")
		treadfx = level._effect["treads_snow"];
	else if(surface == "ice")
	{
		self notify ("iminwater");
		treadfx = "nofx";
	}
	else
		treadfx = "nofx";

	if(!isdefined(treadfx))
		treadfx = "nofx"; //ghetto defensive scripting.. for some reason "rock" is commented out in _treadfx.gsc and I'm too lazy to find out why
	return treadfx;

}

waitframe()
{
	maps\_spawner_gmi::waitframe();
}

Setup_TreeBurst()
{
	trigs = getentarray("tree_burst", "targetname");
	num = 0;
	for(i=0;i<trigs.size;i++)
	{
		trigs[i] thread TreeBurst_Init();
		trigs[i] thread TreeBurst_Think_Trigger();
	}

	trees = getentarray("bastogne1_tree_bursts","targetname");
	TreeBurst_Init(trees);
}

TreeBurst_Init(actual_trees)
{
	if(!isdefined(actual_trees))
	{
		trees = getentarray(self.target,"targetname");
	}
	else
	{
		trees = actual_trees;
	}

	if(!isdefined(trees))
	{
		println("^1NO TREES WERE FOUND!");
		return;
	}
	
	for(i=0;i<trees.size;i++)
	{
		treeswap = spawn("script_model", trees[i].origin);
		treeswap setmodel("xmodel/tree_winter_firhighbranch");
		treeswap.targetname = "tree_to_die_" + level.tree_num;
		treeswap.angles = trees[i].angles;
						
		trees[i].target = "tree_to_die_" + level.tree_num;
		trees[i] hide();

		level.tree_num++;
	}
}

TreeBurst_Think_Trigger()
{
	self waittill("trigger");
	trees = getentarray(self.target,"targetname");
	level thread TreeBurst_Think(trees, 0,0);	
}

TreeBurst_Think(trees, min_delay, max_delay)
{	
	if(!isdefined(trees))
	{
		println("^1NO TREES WERE FOUND!");
		return;
	}

	for(i=0;i<trees.size;i++)
	{
		offset = (0,0,300);

		if (!isdefined(trees[i].script_noteworthy))
		{
			trees[i].script_noteworthy = "a_a";
			println ("^1Using default tree burst animation. Add script_noteworthy to script_model tree that will burst");
		}
		else if(trees[i].script_noteworthy == "b_a" || trees[i].script_noteworthy == "b_b" || trees[i].script_noteworthy == "b_c")
		{
			offset = (0,0,20);
		}
		
		trees[i] show();
		tohide = getent(trees[i].target, "targetname");
		tohide hide();
		
		// Put check for script model here
		trees[i] UseAnimTree(level.scr_animtree["treeburst"]);
		playfx(level._effect["tree_burst"], (trees[i].origin + offset));
		trees[i] thread TreeBurst_Snow_Fx();
		trees[i] playSound ("treeburst");
		trees[i] animscripted( "single anim", trees[i].origin, trees[i].angles, level.scr_anim["treeburst"][trees[i].script_noteworthy]);
//		trees[i] playsound ("tankdrive_treefall");

		if(!isdefined(min_delay))
		{
			min_delay = 0.25;
		}

		if(!isdefined(max_delay))
		{
			min_delay = 0.25;
		}			

		range = max_delay - min_delay;
		wait (min_delay + randomfloat(range));
	}
}

TreeBurst_Snow_Fx()
{
	if (getcvar("scr_gmi_fast") != 0)
	{
		return;
	}
	
	for (i=0;i<10;i++)
	{
		playfxontag(level._effect["tree_burst_snow"], self, "tag_snow");
		wait 0.15;
	}
}

// Showing the team.

GMI_Characters()
{
	println("^5Doing GMI_Characters()");
	level thread GMI_Camera_Mover();
}

GMI_Camera_Mover()
{
	println("^1 GMI CAMERA MOVER");
	wait 6;
	level.player freezeControls(true);
	wait 0.25;
	level.camorg = spawn ("script_origin", (level.player.origin + (0,0,64)));
	level.player setplayerangles(level.camorg.angles);
	wait 0.1;
	level.player playerlinkto (level.camorg, "", (1.01, 1.01, 1.01));
	wait 0.1;

	level thread print_angles();

	spot = 0;

	while(1)
	{
		spot++;
		the_spot = getent(("dev_team_spot" + spot),"targetname");

		if(!isdefined(the_spot))
		{
			// End this stuff.
		}

		level.camorg moveto(the_spot.origin, 3, 1, 1);
		level.camorg rotateto(the_spot.angles, 2.5);

		level GMI_Fade_Controller();

		level GMI_Character_Spawner(the_spot);
		level thread GMI_Camera_Look(the_spot);

		level waittill("move_the_camera");		
	}
}

GMI_Fade_Controller()
{
	level.camorg waittill("movedone");
	level thread fadeout(level.screenOverlay);
}

GMI_Camera_Look(the_spot)
{
	println("^5GMI_Camera_Look");

	all = getentarray(the_spot.script_noteworthy,"groupname");

	ai = GMI_AI_Filter(all);
	the_ai = GMI_AI_Organize(ai);

	offset = (0,0,60);
	offset_crouch = (0,0,32);

	for(i=0;i<the_ai.size;i++)
	{
		org = the_ai[i] gettagorigin("TAG_HELMET");
		org = org - (0,0,16);

		if(isdefined(the_ai[i].script_noteworthy) && the_ai[i].script_noteworthy == "crouch")
		{
			vec_direction = vectortoangles(org - level.camorg.origin);
		}
		else
		{
			vec_direction = vectortoangles(org - level.camorg.origin);			
		}

		level.camorg rotateto(vec_direction, 3, 1, 1);
		level.camorg waittill("rotatedone");
		wait 3;
	}
}

GMI_Character_Spawner(the_spot)
{
	println("^5the_spot.script_noteworthy: ",the_spot.script_noteworthy);
	spawners = getentarray(the_spot.script_noteworthy,"groupname");

	for(i=0;i<spawners.size;i++)
	{
		spawned = spawners[i] stalingradspawn();
		spawned waittill("finished spawning");
		spawned thread GMI_Character_Think();
		spawned thread AI_Org();
	}
}

GMI_Character_Think()
{
	if(isdefined(self.script_noteworthy))
	{
		if(self.script_noteworthy == "crouch")
		{
			self allowedstances("crouch");
		}
	}
}

GMI_AI_Filter(array)
{
	new_array = [];
	for(i=0;i<array.size;i++)
	{
		if(isai(array[i]))
		{
			new_array[new_array.size] = array[i];
		}
	}

	return new_array;
}

GMI_AI_Organize(array)
{
	new_array = [];
	for(i=0;i<array.size;i++)
	{
		if(isdefined(array[i].script_idnumber))
		{
			num = array[i].script_idnumber - 1;
			new_array[num] = array[i];
		}
		else
		{
			println("^3Warning! Guy missing script_idnumber!!");
		}
	}

	return new_array;
}

AI_Org()
{
	offset = (0,0,-64);
	while(1)
	{
		org = self gettagorigin("TAG_HELMET");
		org = org - (0,0,16);
//		print3d((self.origin + offset), "*", (1,0,0));
		line((self.origin), (org), (1,1,1));
		wait 0.06;
	}
}

print_angles()
{
	while(1)
	{
		println("^5level.player.angles: ",level.player.angles," ^5level.camorg.angles: ",level.camorg.angles);
		wait 0.05;
	}
}

moody_drive_idle()
{
	level endon ("ExitVehicle");
	level endon ("Stop Moody Anim");
	while (level.moodyanim == 0)
	{
		rand = (randomint(3));
		
		level.jeep thread maps\credits_anim::willyjeep_anims(rand);
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_idle"][rand]);
		level.moody waittill ("animdone");		
	}
}

moody_peugeot_wait()
{
	level.moody linkto(level.jeep, "tag_driver");
	level.moody animscripts\shared::PutGunInHand("none");

	rand_anim = ( randomint(3) + 1 );
	while (level.flags["ender_in_jeep"] == false)
	{
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_wait"]);
		level.moody waittillmatch ("animdone","end");


		rand_switch = randomint(2) + 1;
		switch(rand_switch)
		{
			case 1: level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_wait"]);
//				wait 0.1;
//				level.moody thread animscripts\shared::lookatentity(level.player, 10000000, "casual");
				level.moody waittillmatch ("animdone","end");
				break;
			case 2: level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_wave"]);
//				wait 0.1;
//				level.moody thread animscripts\shared::lookatentity(level.player, 10000000, "casual");
				level.moody waittillmatch ("animdone","end");
				break;
		}
	}
}

jeep_lose_control()
{
	level.jeep setWaitNode(getVehicleNode("md_22","targetname"));
	level.jeep waittill ("reached_wait_node");
	level thread maps\credits_anim::moody_drive_tree_crash();
}