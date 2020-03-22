#using_animtree("generic_human");
main()
{
		
	level.mortar = loadfx ("fx/impacts/newimps/minefield_dark.efx");
	//level.mortar = level._effect["mortar"];
	maps\_load::main();
//	if (getcvar ("start") != "start")
//		return;
	thread checklev();

	if (level.check)
		maps\_mortar::main();
		
	level.globalTimer = 12;
	maps\_truck::main();
	maps\_wood::main();
	maps\credits_fx::main();
	maps\credits_anim::main();
	maps\_mortarteam::main();
	maps\_panzerIV::main_camo();
	maps\_tank::main();
	maps\_tiger::main_camo();
	precacheCredits();
	precacheString( &"CREDIT_NO_COWS");

	level.player.health = 1000;
	level.flag["tank arrived"] = false;	
	level.flag["credits done"] = false;	
	level.flag["ready to end"] = false;	
	level.flag["move center"] = false;	
	
	level.totalCredits = 0;	
	level.won = false;
	precacheturret("mg42_tiger_tank");
	level.player takeallweapons();
	precachemodel("xmodel/vehicle_tank_panzeriv_machinegun");
	precachemodel("xmodel/parachute_animrig");
	precachemodel("xmodel/character_soviet_overcoat");

	setCullFog(2500, 2900 , 0.0, 0.0, 0.0, 0);
	if (getcvar ("start") == "start")
		setCullFog(500, 900 , 0.0, 0.0, 0.0, 0);

	thread text();	
//	start = getent ("starting position","targetname");	
//	level.player setorigin (start.origin + (0,0,80));
	ender = getent ("ender","targetname");
	ender.name = "";
	ender.health = 50000;
	ender.ignoreme = true;
	ender character\_utility::new();
	ender character\foley::main();
	level.ender = ender;
	level thread enderThink (ender);

	wait (0.05);
	level notify ("wood_time");
	thread music();
	level.player.ignoreme = true;
	thread ai_overrides();
	thread tankTrigger (getent ("tank trigger","targetname"));
	thread mortarTriggerN (Getent ("mortar trigger","script_noteworthy"));
	array_levelthread (getentarray ("height","targetname"), ::height);
	array_levelthread (getentarray ("creditspawn","targetname"), ::creditSpawner);

	thread timer();
	thread skip();
//	thread globalTimer();	

//	org = spawn ("script_origin", level.player.origin + (0,0,-10));
	level.camorg = spawn ("script_origin", level.player.origin + (0,0,-10));
//	org.origin = start.origin + (0,0,10);
//	level.camorg thread follower (ender);
	level.camorg thread follower (ender);
	thread heightDestination();
	
	maps\_utility::spawn_failed(ender);
	ender.accuracy = 1;
	
	wait (0.05);
	level.cam_vec[0] = 0;
	level.cam_vec[1] = 0;
	level.cam_vec[2] = -10;
//	org thread rotateroler();
	level.camorg thread rotateroler();
	ender setgoalpos (ender.origin);
	ender.goalradius = 32;
//	thread cam_controls(0, "x");
//	thread cam_controls(1, "y");
//	thread cam_controls(2, "z");
	thread mortarTrigger (getent ("mortar trigger","targetname"));
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
	node = getnode (ender.target,"targetname");

	parachute = spawn_parachute();

	if (randomint (100) > 50)
		landing = "landing 1";
	else
		landing = "landing 2";
	
	ender.animname = "ender";
	guy[0] = ender;
	guy[1] = parachute;
	maps\_anim::anim_teleport (guy, "landing 2", undefined, node);
	wait (1);
	maps\_anim::anim_teleport (guy, "landing 2", undefined, node);
	if (level.check)
		anim_single (guy, "landing 2", undefined, node);

	level notify ("stop set dest height");
	
	if (level.check)
	{
		while (isdefined (node.target))
		{
			trigger = getent (node.target,"targetname");
			if (isdefined (trigger))
			{
				println ("^3 Waiting for trigger to clear");
				maps\_utility::living_ai_wait (trigger, "axis");
				println ("^3 Trigger cleared");
			}
			node = getnode (node.target,"targetname");
				
			level.enderNode = node;
			ender setgoalnode (node);
			ender.goalradius = 32;
			waittill_either (ender, "goal", "skip");
			if (isdefined (node.script_noteworthy))
			{
				if (node.script_noteworthy == "dont stop")
					continue;
				
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
						maps\_utility::living_ai_wait (trigger, "axis");
					ender allowedstances ("prone","crouch","stand");
					continue;
				}
			}
	
			if (isdefined (level.skip))
			{
				level.skip = undefined;
				continue;
			}
			wait (3);
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
		
	thread endLevel();
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
		
		level.leftoffset-=offset;
		wait (0.05);
	}
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
endLevel ()
{
	wait (7);
	flag_set ("move center");
	flag_wait ("credits done");
	wait (0.5);

	if ((level.check) || (level.won))
	{
		newStr = newHudElem();
				offsetter = 0;
	
	
		newStr setText(&"CREDIT_NO_COWS");
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
	}
	
	setCvar("ui_victoryquote", "@VICTORYQUOTE_THOSE_WHO_HAVE_LONG_ENJOYED");
	missionSuccess("training", false);
}

tank_killers_killThread (tank, gun_guy)
{
	tank maps\_anim::anim_single (gun_guy, "run", "tag_hatch");
	tank thread anim_loop ( gun_guy, "idle", "tag_hatch", "stop anim");
}

tank_killThread ()
{
	flag_wait ("tank arrived");

	level.ender.animname = "gun guy";
	tank = getent ("tank","targetname");
	gun_guy[0] = level.ender;
	tank thread maps\_anim::anim_reach (gun_guy, "run", "tag_hatch");

	spawner = getent ("tank killer","script_noteworthy");
	spawner waittill ("spawned",spawn);
	if (maps\_utility::spawn_failed(spawn))
		return;

	spawn.health = 50000;
	spawn.animname = "grenade guy";
	grenade_guy[0] = spawn;

 	guy[0] = gun_guy[0];
	guy[1] = grenade_guy[0];
	
	tank maps\_anim::anim_reach (gun_guy, "run", "tag_hatch");
	level thread tank_killers_killThread (tank, gun_guy);

	tank maps\_anim::anim_reach (grenade_guy, "run", "tag_hatch");
	tank thread maps\_anim::anim_single (grenade_guy, "run", "tag_hatch");
 	tank notify ("stop anim");

	tank maps\_anim::anim_reach (guy, "attack", "tag_hatch");
	tank.animname = "tank";
	tank assignanimtree();
	tank setFlaggedAnim( "single anim", level.scr_anim[tank.animname]["attack"]);
	tank thread maps\_anim::notetrack_wait (tank, "single anim", undefined, "attack");
	tank thread maps\_anim::anim_single (guy, "attack", "tag_hatch");
	level notify ("tank kilt");
	tank waittill ("attack");
	spawn setgoalnode (getnode ("flee tank","targetname"));
	tank.health = 5;
	wait (3);
	radiusDamage (tank.origin, 2, tank.health + 5000,  tank.health + 5000); // mystery numbers!
	tank notify ("death");
}

mortarTriggerN ( trigger )
{
	trigger waittill ("death");
//	trigger waittill ("Trigger");
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
		if (maps\_utility::spawn_failed(spawn))
			continue;
	
		spawn.suppressionwait = 0.001;
		spawn.animplaybackrate = 1.0;
	}
}

music ()
{
	musicPlay("pegasusbridge_credits");
	wait (81);
	musicPlay("codtheme");
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

unseenthread()
{
	self endon ("death");
//	self.goalradius = 64;
//	self waittill ("goal");
	turret = getent (getnode(self.target,"targetname").target, "targetname");
	while (1)
	{
		self useturret(turret); // dude should be near the mg42
		wait (1);
	}
}

creditSpawnerThink ( spawner, health )
{
	if (isdefined (spawner.script_noteworthy))
		msg = spawner.script_noteworthy;

	spawn = spawner stalingradspawn();
	if (maps\_utility::spawn_failed(spawn))
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
//			spawn thread unseenthread();
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
	tank thread maps\_tiger::init();
	tank thread maps\_tankdrive::splash_shield();
	path = getvehiclenode ("tank path","targetname");
	tank attachPath( path );
	tank startPath();
	tank maps\_tankgun::mgoff();
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
	level.destinationHeight = trigger.script_delay;
	if (isdefined (trigger.script_noteworthy))
	{
//		maps\_utility::error ("note " + trigger.script_noteworthy);
		if (trigger.script_noteworthy == "make mortars")
			getent ("mortar team","targetname") notify ("start");
	}
}

heightDestination()
{
	level.destinationHeight	= 0;
	level.currentHeight	= 0;
	dif = 0.98;
	while (1)
	{
		level.currentHeight = level.currentHeight * dif + level.destinationHeight * (1.0 - dif);
		wait (0.05);
	}
}

rotateroler ()
{
	self rotateto ((level.cam_vec[0],level.cam_vec[1],level.cam_vec[2]), 0.05);
	return;
		
	while (1)
	{
		println ("cam ",level.cam_vec[0], " ",level.cam_vec[1]," ",level.cam_vec[2]);
		self rotateto ((level.cam_vec[0],level.cam_vec[1],level.cam_vec[2]), 0.05);
//		level.player.angles = (level.cam_vec[0],level.cam_vec[1],level.cam_vec[2]);

		wait (0.2);
	}
}

follower (ender)
{
	timer = 0.15;
//	ender.origin;
	level.player.angles = (0,0,0);
	level.player playerlinkto (level.camorg, "", (1,1,1));
	level.player freezeControls(true);

	level.destinationHeight	= 0;
	level.currentHeight	= 0;
	offset = 54;
	level.leftoffset = 0;
	if (getcvar ("start") != "start")
		return;
		
	
	
	while (1)
	{
		self moveto ((ender.origin[0] - 40 + level.leftoffset, ender.origin[1] - 400, offset + level.currentHeight), timer);
//		self moveto ((ender.origin[0], ender.origin[1] - 400,  ender.origin[2]), timer);
//		print ("destination height ", level.destinationheight, " currentheight ", level.currentHeight);
//		println (" height ", offset + level.currentHeight);
//		println ("angles ", level.player.angles);
//		println ("player height ", level.player.origin[2]);
		wait (timer);
	}
}


mortarTrigger ( trigger )
{
	trigger waittill ("trigger");
	wait (0.35);
	org = getent (trigger.target,"targetname");
	terrain = getent (org.target,"targetname");
	
	org playsound ("mortar_incoming2", "sounddone");
	org waittill ("sounddone");
	org playsound ("mortar_explosion1");
	playfx ( level.mortar, org.origin );
	wait (0.1);
	terrain delete();
	
	ender = getent ("ender","targetname");
	ender animscripted("scriptedanimdone", ender.origin, ender.angles, %stand2prone_knockeddown_forward);
	ender thread animscripts\shared::DoNoteTracks("scriptedanimdone");
	ender waittillmatch ("scriptedanimdone","end");

	ender animscripted("scriptedanimdone", ender.origin, ender.angles, %scripted_standwabble_B);
	ender thread animscripts\shared::DoNoteTracks("scriptedanimdone");
	ender waittillmatch ("scriptedanimdone","end");
	wait (0.25);
	
	thread german_truck(getent ("truck fast","targetname"));
}

driver_think ( spawner )
{
	spawner waittill ("spawned",spawn);
	if (maps\_utility::spawn_failed(spawn))
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

//	truck thread maps\_utility::playSoundOnTag("stop_skid", "tag_origin");
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
	
//	newStr setText(text);

//	level.introstring1.x = 320;
//	level.introstring1.y = 260;
//	level.introstring1.alignX = "center";
//	level.introstring1.alignY = "middle";
//	level.introstring1.sort = 1; // force to draw after the background
//	level.introstring1.fontScale = 1.75;
//	level.introstring1.alpha = 0;
//	level.introstring1 fadeOverTime(1.2); 
//	level.introstring1.alpha = 1;
	
//	level.totalCredits++;
//	println ("credits total: ", level.totalCredits);
//	newStr = spawnstruct();
//	newStr.string = string;
//	newStr.placement = src.size;
//	newStr.location = 0;
//	newStr.blank = false;
//	newStr.fontScale = 1.00;
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
	src = addCreditsBold (src, &"CREDIT_INFINITY_WARD_CREDITS");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ENGINEERING_LEAD");
	src = addCredits (src, &"CREDIT_JASON_WEST");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_DESIGN_LEAD");
	src = addCredits (src, &"CREDIT_ZIED_RIEKE");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ART_LEAD");
	src = addCredits (src, &"CREDIT_JUSTIN_THOMAS");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ANIMATION_LEAD");
	src = addCredits (src, &"CREDIT_MICHAEL_BOON");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_PRODUCER");
	src = addCredits (src, &"CREDIT_VINCE_ZAMPELLA");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_DEVELOPMENT_DIRECTOR");
	src = addCredits (src, &"CREDIT_KEN_TURNER");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ENGINEERING");
	src = addCredits (src, &"CREDIT_ROBERT_FIELD");
	src = addCredits (src, &"CREDIT_FRANK_GIGLIOTTI");
	src = addCredits (src, &"CREDIT_CARL_GLAVE");
	src = addCredits (src, &"CREDIT_EARL_HAMMON");
	src = addCredits (src, &"CREDIT_JASON_WEST");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ADDITIONAL_PROGRAMMING");
	src = addCredits (src, &"CREDIT_BRYAN_KUHN");
	src = addCredits (src, &"CREDIT_MACKEY_MCCANDLISH");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_LEVEL_DESIGN_GAME_PLAY_SCRIPTING");
	src = addCredits (src, &"CREDIT_TODD_ALDERMAN");
	src = addCredits (src, &"CREDIT_KEITH_BELL");
	src = addCredits (src, &"CREDIT_STEVE_FUKUDA");
	src = addCredits (src, &"CREDIT_PRESTON_GLENN");
	src = addCredits (src, &"CREDIT_CHAD_GRENIER");
	src = addCredits (src, &"CREDIT_MACKEY_MCCANDLISH");
	src = addCredits (src, &"CREDIT_ZIED_RIEKE");
	src = addCredits (src, &"CREDIT_NATE_SILVERS");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ART");
	src = addCredits (src, &"CREDIT_BRAD_ALLEN");
	src = addCredits (src, &"CREDIT_CHRIS_HASSELL");
	src = addCredits (src, &"CREDIT_JEFF_HEATH");
	src = addCredits (src, &"CREDIT_PAUL_JURY_LEAD_2D");
	src = addCredits (src, &"CREDIT_JUSTIN_THOMAS");
	src = addCredits (src, &"CREDIT_KEVIN_CHEN_CONCEPT_ART");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ADDITIONAL_ART");
	src = addCredits (src, &"CREDIT_DAN_MODITCH");
	src = addCredits (src, &"CREDIT_SLOAN_ANDERSON");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ANIMATION");
	src = addCredits (src, &"CREDIT_MICHAEL_BOON");
	src = addCredits (src, &"CREDIT_URSULA_ESCHER");
	src = addCredits (src, &"CREDIT_CHANCE_GLASCO");
	src = addCredits (src, &"CREDIT_PAUL_MESSERLY");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ADDITIONAL_ANIMATION");
	src = addCredits (src, &"CREDIT_SHADOWS_IN_DARKNESS");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_SOUND");
	src = addCredits (src, &"CREDIT_CHUCK_RUSSOM");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ADDITIONAL_SOUND");
	src = addCredits (src, &"CREDIT_JACK_GRILLO");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_SYSTEM_ADMINISTRATOR");
	src = addCredits (src, &"CREDIT_BRYAN_KUHN");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_MANAGEMENT");
	src = addCredits (src, &"CREDIT_GRANT_COLLIER_CEO");
	src = addCredits (src, &"CREDIT_VINCE_ZAMPELLA_CCO");
	src = addCredits (src, &"CREDIT_JASON_WEST_CTO");
	src = addCredits (src, &"CREDIT_JANICE_TURNER_OFFICE_MANAGER");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_TESTERS");
	src = addCredits (src, &"CREDIT_CLIFTON_CLINE");
	src = addCredits (src, &"CREDIT_OLIVER_GEORGE");
	src = addCredits (src, &"CREDIT_CHRIS_HERMANS");
	src = addCredits (src, &"CREDIT_MATTHEW_LACKOWSKI");
	src = addCredits (src, &"CREDIT_SCOTT_MATLOFF");
	src = addCredits (src, &"CREDIT_GAVIN_MCCANDLISH");
	src = addCredits (src, &"CREDIT_DAVID_OBERLIN");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_HISTORICAL_REFERENCE");
	src = addCredits (src, &"CREDIT_MIKE_PHILLIPS");
	src = addCredits (src, &"CREDIT_JOSH_HENNIGER");
	src = addCredits (src, &"CREDIT_DAVE_SANTI");
	src = addCredits (src, &"CREDIT_E_COMPANY");
	src = addCredits (src, &"CREDIT_8TH_GUARDS");
	src = addCredits (src, &"CREDIT_PARTICIPANTS");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_SPECIAL_THANKS");
	src = addCredits (src, &"CREDIT_RON_DOORNINK");
	src = addCredits (src, &"CREDIT_LARRY_GOLDBERG_NAME");
	src = addCredits (src, &"CREDIT_MARK_LAMIA");
	src = addCredits (src, &"CREDIT_LAIRD_MALAMED");
	src = addCredits (src, &"CREDIT_BILL_ANKER");
	src = addCredits (src, &"CREDIT_GEORGE_ROSE");
	src = addCredits (src, &"CREDIT_GREG_DEUTSCH");
	src = addCredits (src, &"CREDIT_BRIAN_ADAMS");
	src = addCredits (src, &"CREDIT_THE_PHILLY_PLACE");
	src = addCredits (src, &"CREDIT_GRAY_MATTER");
	src = addCredits (src, &"CREDIT_JOHN_GARCIA_SHELTON");
	src = addCredits (src, &"CREDIT_SPARK_UNLIMITED");
	src = addCredits (src, &"CREDIT_THANKS1");
	src = addCredits (src, &"CREDIT_THANKS2");
	src = addBlank (src);
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ACTIVISION_CREDITS");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_PRODUCTION");
	src = addCredits (src, &"CREDIT_THAINE_LYMAN");
	src = addCredits (src, &"CREDIT_KEN_MURPHY");
	src = addCredits (src, &"CREDIT_ERIC_GROSSMAN");
	src = addCredits (src, &"CREDIT_DANIEL_HAGERTY");
	src = addCredits (src, &"CREDIT_MATTHEW_BEAL");
	src = addCredits (src, &"CREDIT_ROBERT_KIRSCHENBAUM");
	src = addCredits (src, &"CREDIT_PATRICK_BOWMAN");
	src = addCredits (src, &"CREDIT_ERIC_ADAMS");
	src = addCredits (src, &"CREDIT_LAIRD_MALAMED_SENIOR_EXECUTIVE");
	src = addCredits (src, &"CREDIT_MARK_LAMIA_VP");
	src = addCredits (src, &"CREDIT_LARRY_GOLDBERG");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_VOICES");
	src = addCredits (src, &"CREDIT_VOICE_CASTING2");
	src = addCredits (src, &"CREDIT_STEVE_BLUM");
	src = addCredits (src, &"CREDIT_JASON_STATHAM");
	src = addCredits (src, &"CREDIT_GIOVANNI_RIBISI");
	src = addCredits (src, &"CREDIT_GREGG_BERGER");
	src = addCredits (src, &"CREDIT_MICHAEL_GOUGH");
	src = addCredits (src, &"CREDIT_MICHAEL_BELL");
	src = addCredits (src, &"CREDIT_JIM_WARD");
	src = addCredits (src, &"CREDIT_NICK_JAMESON");
	src = addCredits (src, &"CREDIT_NEIL_ROSS");
	src = addCredits (src, &"CREDIT_DAVID_SOBOLOV");
	src = addCredits (src, &"CREDIT_ANDRE_SOGLIUZZO");
	src = addCredits (src, &"CREDIT_GRANT_ALBRECHT");
	src = addCredits (src, &"CREDIT_QUINTON_FLYNN");
	src = addCredits (src, &"CREDIT_JOSH_PASKOWITZ");
	src = addCredits (src, &"CREDIT_EARL_BOEN");
	src = addCredits (src, &"CREDIT_RECORDING_ENGINEERING_EDITING_VO_EFFECTS_DESIGN");
	src = addCredits (src, &"CREDIT_RIK_W_SCHAFFER_WOMB_MUSIC");
	src = addCredits (src, &"CREDIT_VOICES_RECORDED_AT_SALAMI_STUDIOS_AND_THE_CASTLE");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_MUSIC");
	src = addCredits (src, &"CREDIT_MICHAEL_GIACCHINO");
	src = addCredits (src, &"CREDIT_JUSTIN_SKOMAROVSKY");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_SCRIPT");
	src = addCredits (src, &"CREDIT_MICHAEL_SCHIFFER");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_GLOBAL_BRAND_MANAGEMENT");
	src = addCredits (src, &"CREDIT_BRAD_CARRAWAY");
	src = addCredits (src, &"CREDIT_RICHARD_BREST");
	src = addCredits (src, &"CREDIT_DAVID_POKRESS");
	src = addCredits (src, &"CREDIT_DUSTY_WELCH");
	src = addCredits (src, &"CREDIT_KATHY_VRABECK");
	src = addCredits (src, &"CREDIT_MIKE_MANTARRO");
	src = addCredits (src, &"CREDIT_MICHELLE_NINO");
	src = addCredits (src, &"CREDIT_TRICIA_BERTERO");
	src = addCredits (src, &"CREDIT_JOHN_DILULLO");
	src = addCredits (src, &"CREDIT_JULIE_DEWOLF");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_LEGAL");
	src = addCredits (src, &"CREDIT_GEORGE_ROSE");
	src = addCredits (src, &"CREDIT_GREG_DEUTSCH");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_CREATIVE_SERVICES");
	src = addCredits (src, &"CREDIT_DENISE_WALSH");
	src = addCredits (src, &"CREDIT_MATHEW_STAINNER");
	src = addCredits (src, &"CREDIT_JILL_BARRY");
	src = addCredits (src, &"CREDIT_SHELBY_YATES");
	src = addCredits (src, &"CREDIT_HAMAGAMI_CARROLL");
	src = addCredits (src, &"CREDIT_IGNITED_MINDS");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_INTERNATIONAL");
	src = addCredits (src, &"CREDIT_SCOTT_DODKINS");
	src = addCredits (src, &"CREDIT_ROGER_WALKDEN");
	src = addCredits (src, &"CREDIT_ALISON_TURNER");
	src = addCredits (src, &"CREDIT_NATHALIE_RANSON");
	src = addCredits (src, &"CREDIT_JACKIE_SUTTON");
	src = addCredits (src, &"CREDIT_TAMSIN_LUCAS");
	src = addCredits (src, &"CREDIT_SIMON_DAWES");
	src = addCredits (src, &"CREDIT_TREVOR_BURROWS");
	src = addCredits (src, &"CREDIT_DALEEP_CHHABRIA");
	src = addCredits (src, &"CREDIT_HEATHER_CLARKE");
	src = addCredits (src, &"CREDIT_LYNNE_MOSS");
	src = addCredits (src, &"CREDIT_VICTORIA_FISHER");
	src = addBlank (src);
	src = addCredits (src, &"CREDIT_GERMAN_LOCALIZATION");
	src = addCredits (src, &"CREDIT_FRENCH_LOCALIZATION");
	src = addCredits (src, &"CREDIT_ITALIAN_SPANISH_LOCALIZATION");
	src = addCredits (src, &"CREDIT_JAPANESE_LOCALIZATION");
	src = addCredits (src, &"CREDIT_CHINESE_LOCALIZATION");
	src = addCredits (src, &"CREDIT_KOREAN_LOCALIZATION");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ACTIVISION_GERMANY");
	src = addCredits (src, &"CREDIT_STEFAN_LULUDES");
	src = addCredits (src, &"CREDIT_BERND_REINARTZ");
	src = addCredits (src, &"CREDIT_JULIA_VOLKMANN");
	src = addCredits (src, &"CREDIT_STEFAN_SEIDEL");
	src = addCredits (src, &"CREDIT_THORSTEN_HMANN");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ACTIVISION_FRANCE");
	src = addCredits (src, &"CREDIT_BERNARD_SIZEY");
	src = addCredits (src, &"CREDIT_GUILLAUME_LAIRAN");
	src = addCredits (src, &"CREDIT_GAUTIER_ORMANCEY");
	src = addCredits (src, &"CREDIT_DIANE_DE_DOMECY");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_CENTRAL_TECHNOLGY");
	src = addCredits (src, &"CREDIT_JOHN_FRITTS");
	src = addCredits (src, &"CREDIT_ANDREW_PETTERSON");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_QUALITY_ASSURANCE_CUSTOMER_SUPPORT");
	src = addCredits (src, &"CREDIT_BRAD_SAAVEDRA");
	src = addCredits (src, &"CREDIT_MATT_MCCLURE");
	src = addCredits (src, &"CREDIT_MARILENA_RIXFORD");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_QUALITY_ASSURANCE");
	src = addCredits (src, &"CREDIT_BRYAN_JURY");
	src = addCredits (src, &"CREDIT_ERIK_MELEN");
	src = addCredits (src, &"CREDIT_PETER_BEAL");
	src = addCredits (src, &"CREDIT_ROBERT_MAX_MARTIN");
	src = addCredits (src, &"CREDIT_PAUL_GOLDILLA");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_TESTERS");
	src = addCredits (src, &"CREDIT_RANDOLPH_AMORE");
	src = addCredits (src, &"CREDIT_SEAN_BERRETT");
	src = addCredits (src, &"CREDIT_DONALD_MARSHALL");
	src = addCredits (src, &"CREDIT_SOUKHA_PHIMPASOUK");
	src = addCredits (src, &"CREDIT_KEITH_MCCLELLAN");
	src = addCredits (src, &"CREDIT_KIM_CARRASCO");
	src = addCredits (src, &"CREDIT_MIKE_CURRAN");
	src = addCredits (src, &"CREDIT_SUNGWON_CHOE");
	src = addCredits (src, &"CREDIT_SADULLAH_NADER");
	src = addCredits (src, &"CREDIT_JEFF_GRANT");
	src = addCredits (src, &"CREDIT_MICHAEL_RADZICHOVSKY");
	src = addCredits (src, &"CREDIT_PATRICK_RYAN");
	src = addCredits (src, &"CREDIT_CARLOS_RAMIREZ");
	src = addCredits (src, &"CREDIT_DYLAN_LEONG");
	src = addCredits (src, &"CREDIT_MORRISON_CHEN");
	src = addCredits (src, &"CREDIT_RODRICK_RIPLEY");
	src = addCredits (src, &"CREDIT_DOUG_WOOTEN");
	src = addCredits (src, &"CREDIT_AARON_MOSNY");
	src = addCredits (src, &"CREDIT_JAY_FRANKE");
	src = addCredits (src, &"CREDIT_HENRY_VILLANUEVA");
	src = addCredits (src, &"CREDIT_NATHANIEL_MCCLURE");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_SUPPORTING_LEADS");
	src = addCredits (src, &"CREDIT_CHRIS_KEIM");
	src = addCredits (src, &"CREDIT_NEIL_BARIZO");
	src = addCredits (src, &"CREDIT_TIM_VANLAW");
	src = addCredits (src, &"CREDIT_JEF_SEDIVY");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_CRG_TESTERS");
	src = addCredits (src, &"CREDIT_DOUGLAS_RICHARD_TODD");
	src = addCredits (src, &"CREDIT_MIKE_RESTIFO");
	src = addCredits (src, &"CREDIT_JAMES_CALL");
	src = addCredits (src, &"CREDIT_GIAN_DERIVI");
	src = addBlank (src);
	src = addCredits (src, &"CREDIT_PAUL_COLBERT");
	src = addCredits (src, &"CREDIT_ANTHONY_HATCH_KOROTKO");
	src = addCredits (src, &"CREDIT_ADAM_HARTSFIELD");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_LOCALIZATIONS_TEST_TEAM");
	src = addCredits (src, &"CREDIT_ANDREW_CHRISTY");
	src = addCredits (src, &"CREDIT_CHRIS_SIMON");
	src = addCredits (src, &"CREDIT_CHRIS_DOLAN");
	src = addCredits (src, &"CREDIT_JOHN_BATSHON");
	src = addCredits (src, &"CREDIT_MICHAEL_D_HILL");
	src = addCredits (src, &"CREDIT_JOHN_WHANG");
	src = addCredits (src, &"CREDIT_JESSE_BLACK_MOONEY");
	src = addCredits (src, &"CREDIT_DANNY_YANEZ");
	src = addCredits (src, &"CREDIT_ISREAL_BARCO");
	src = addCredits (src, &"CREDIT_DANIEL_CHENG");
	src = addCredits (src, &"CREDIT_RYAN_FORD");
	src = addCredits (src, &"CREDIT_DANE_FREDERIKSEN");
	src = addCredits (src, &"CREDIT_DUSTIN_GREEN");
	src = addCredits (src, &"CREDIT_MICHAEL_ISLES");
	src = addCredits (src, &"CREDIT_TIM_KEOSABABIAN");
	src = addCredits (src, &"CREDIT_KEVIN_KRAEER");
	
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_THIRD_SHIFT");
	src = addCredits (src, &"CREDIT_JASON_LEVINE");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_THIRD_SHIFT_TESTERS");
	src = addCredits (src, &"CREDIT_ANDREW_LIU");
	src = addCredits (src, &"CREDIT_RONALD_HART");
	src = addCredits (src, &"CREDIT_MATT_RYDER");
	src = addBlank (src);
	src = addCredits (src, &"CREDIT_BOB_MCPHERSON");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_CUSTOMER_SUPPORT_LEADS");
	src = addCredits (src, &"CREDIT_GARY_BOLDUC");
	src = addCredits (src, &"CREDIT_MICHAEL_HILL");
	src = addCredits (src, &"CREDIT_ROB_LIM");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_ACTIVISION_SPECIAL_THANKS");
	src = addCredits (src, &"CREDIT_STEVE_ROSENTHAL");
	src = addCredits (src, &"CREDIT_PETER_MURAVEZ");
	src = addCredits (src, &"CREDIT_JUAN_VALDEZ");
	src = addCredits (src, &"CREDIT_DOUG_AVERY");
	src = addCredits (src, &"CREDIT_STEVE_HOLMES");
	src = addCredits (src, &"CREDIT_JASON_KIM");
	src = addCredits (src, &"CREDIT_SAM_NOURIANI");
	src = addCredits (src, &"CREDIT_BRELAN_DUFF");
	src = addCredits (src, &"CREDIT_MATT_MORTON");
	src = addCredits (src, &"CREDIT_CARYN_LAW");
	src = addCredits (src, &"CREDIT_BRIAN_PASS");
	src = addCredits (src, &"CREDIT_BLAINE_CHRISTINE");
	src = addCredits (src, &"CREDIT_RYAN_RUCINSKI");
	src = addCredits (src, &"CREDIT_BRENT_BOYLEN");
	src = addCredits (src, &"CREDIT_JOE_SHACKLEFORD");
	src = addCredits (src, &"CREDIT_ASIF_HUSAIN");
	src = addCredits (src, &"CREDIT_CASEY_KEEFE");
	src = addCredits (src, &"CREDIT_JONATHAN_MOSES");
	src = addCredits (src, &"CREDIT_GENE_BAHNG");
	src = addCredits (src, &"CREDIT_GLENN_IGE");
	src = addCredits (src, &"CREDIT_AARON_GRAY");
	src = addCredits (src, &"CREDIT_DOUG_PEARSON");
	src = addCredits (src, &"CREDIT_DANNY_TAYLOR");
	src = addCredits (src, &"CREDIT_EAIN_BANKINS");
	src = addCredits (src, &"CREDIT_MARC_STRUHL");
	src = addCredits (src, &"CREDIT_PAT_DWYER");
	src = addCredits (src, &"CREDIT_JAMES_MAYEDA");
	src = addCredits (src, &"CREDIT_ROBERT_DEPALMA");
	src = addCredits (src, &"CREDIT_DAVID_DALZELL");
//	src = addCredits (src, &"CREDIT_KEVIN_KRAEER");
	src = addCredits (src, &"CREDIT_KEVIN_KRAFF");
	src = addCredits (src, &"CREDIT_GRAEME_DEVINE");
	src = addCredits (src, &"CREDIT_JAMES_MONROE");
	src = addCredits (src, &"CREDIT_STE_CORK");
	src = addCredits (src, &"CREDIT_DAVID_LUNTZ");
	src = addCredits (src, &"CREDIT_SEBASTIEN_LAURENT");
	src = addBlank (src);
	src = addCreditsBold (src, &"CREDIT_CS_QA_SPECIAL_THANKS");
	src = addCredits (src, &"CREDIT_JIM_SUMMERS");
	src = addCredits (src, &"CREDIT_JASON_WONG");
	src = addCredits (src, &"CREDIT_JOE_FAVAZZA");
//	src = addCredits (src, &"CREDIT_ADAM_HARTSFIELD_NAME");
	src = addCredits (src, &"CREDIT_ED_CLUNE");
	src = addCredits (src, &"CREDIT_NADINE_THEUZILLOT");
	src = addCredits (src, &"CREDIT_CHAD_SIEDOFF");
	src = addCredits (src, &"CREDIT_INDRA_GUNAWAN");
	src = addCredits (src, &"CREDIT_MARCO_SCATAGLINI");
	src = addCredits (src, &"CREDIT_JOULE_MIDDLETON");
	src = addCredits (src, &"CREDIT_TODD_KOMESU");
	src = addCredits (src, &"CREDIT_MIKE_BECK");
	src = addCredits (src, &"CREDIT_WILLIE_BOLTON");
	src = addCredits (src, &"CREDIT_JOHN_ROSSER");
	src = addCredits (src, &"CREDIT_JASON_POTTER");
	src = addCredits (src, &"CREDIT_GLENN_VISTANTE");
	src = addCredits (src, &"CREDIT_JENNIFER_VITIELLO");
	src = addCredits (src, &"CREDIT_MIKE_RIXFORD");
	src = addCredits (src, &"CREDIT_TYLER_RIVERS");
	src = addCredits (src, &"CREDIT_NICK_FAVAZZA");
	src = addCredits (src, &"CREDIT_JESSICA_MCCLURE");
	src = addCredits (src, &"CREDIT_JANNA_SAAVEDRA");
	src = addBlank (src);
	src = addCredits (src, &"CREDIT_CHAPTER_BRIEF1");
	src = addCredits (src, &"CREDIT_CHAPTER_BRIEF2");
	src = addCredits (src, &"CREDIT_EDWARD_F");
	src = addCredits (src, &"CREDIT_JARETT_MELVILLE");
	src = addBlank (src);
	src = addCredits (src, &"CREDIT_INTRODUCTION_CINEMATIC");
	src = addCredits (src, &"CREDIT_ROB_TROY");
	src = addCredits (src, &"CREDIT_LISA_RIZNIKOVE");
	src = addCredits (src, &"CREDIT_DAN_BAKER");

	
	/*
	level.huds = [];
	for (i=50;i<100;i++)
	{
		hdSetAlignment(i, "right", "center");
//		hdSetFontScale(i, 1.75);
		hdSetFontScale(i, 1.25);
		hdSetAlpha(i, 0);
		level.huds[level.huds.size] = i;
		level.hudUsed[i] = false;
	}
	*/
	
	if (getcvar ("start") == "start")
	{
		height = 60;
		height = 100;
		black[0] = newHudElem();
		black[1] = newHudElem();
		for (i=0;i<black.size;i++)
		{
			black[i].x = 0;
			black[i].y = 0;
//			black[i].alignX = "center";
//			black[i].alignY = "middle";
			black[i] setShader("black", 640, height);
			black[i].alpha = 1;
		}
		
		black[0].y = 480-height;

		black[2] = newHudElem();
		black[2].x = 0;
		black[2].y = 0;
		black[2] setShader("black", 640, 480);
		black[2].alpha = 1;
//		black[2] fadeOverTime (2);
		if (level.check)
			thread fadeout (black[2]);
		level.screenOverlay	= black[2];
	}
//	black[0].sort = 2000;
//	black[1].sort = 2000;
	
	for (i=0;i<black.size;i++)
		black[i].sort = 5;
	
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

		if (index+2 >= src.size)
			flag_set("ready to end");
		
		level thread launchCredit (src[index]);
//		timer = gettime() + 1000;
		timer = gettime() + 900;
		index++;
		if (index >= src.size)
			break;
	}
	
}

fadeout (elem)
{
	wait (1);
	elem fadeOverTime (2);
	elem.alpha = 0;
}

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
		ender = true;
	else
		ender = false;
		
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
//	timer = 17;
	timer = level.globalTimer;
	
	newStr.y = 370;
	newStr moveOverTime(timer);
	newStr.y = 100;
	wait (timer - (level.globalTimer/6));
	newStr fadeOverTime (level.globalTimer/6);
	newStr.alpha = 0;
	wait (2);

	newStr destroy();	
	if (!ender)
		return;

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
	maps\_utility::array_thread (ents, process, var, excluders);
}

array_levelthread (ents, process, var, excluders)
{
	maps\_utility::array_levelthread (ents, process, var, excluders);
}


anim_loop ( guy, anime, tag, ender, node, tag_entity )
{
	maps\_anim::anim_loop ( guy, anime, tag, ender, node, tag_entity );
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

anim_single_queue (guy, anime, tag, node, tag_entity)
{
	maps\_anim::anim_single_queue (guy, anime, tag, node, tag_entity);
}

anim_reach (guy, anime, tag, node, tag_entity)
{
	maps\_anim::anim_reach (guy, anime, tag, node, tag_entity);
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

checkLev()
{
	if (getcvar("beat_the_game") == "I_sure_did")
		level.check = true;
	else
		level.check = false;
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
	precacheString(&"CREDIT_INFINITY_WARD_CREDITS");
	
	precacheString(&"CREDIT_ENGINEERING_LEAD");
	precacheString(&"CREDIT_JASON_WEST");
	
	precacheString(&"CREDIT_DESIGN_LEAD");
	precacheString(&"CREDIT_ZIED_RIEKE");
	
	precacheString(&"CREDIT_ART_LEAD");
	precacheString(&"CREDIT_JUSTIN_THOMAS");
	
	precacheString(&"CREDIT_ANIMATION_LEAD");
	precacheString(&"CREDIT_MICHAEL_BOON");
	
	precacheString(&"CREDIT_PRODUCER");
	precacheString(&"CREDIT_VINCE_ZAMPELLA");
	
	precacheString(&"CREDIT_DEVELOPMENT_DIRECTOR");
	precacheString(&"CREDIT_KEN_TURNER");
	
	precacheString(&"CREDIT_ENGINEERING");
	precacheString(&"CREDIT_ROBERT_FIELD");
	precacheString(&"CREDIT_FRANK_GIGLIOTTI");
	precacheString(&"CREDIT_CARL_GLAVE");
	precacheString(&"CREDIT_EARL_HAMMON");
	precacheString(&"CREDIT_JASON_WEST");
	
	precacheString(&"CREDIT_ADDITIONAL_PROGRAMMING");
	precacheString(&"CREDIT_BRYAN_KUHN");
	precacheString(&"CREDIT_MACKEY_MCCANDLISH");
	
	precacheString(&"CREDIT_LEVEL_DESIGN_GAME_PLAY_SCRIPTING");
	precacheString(&"CREDIT_TODD_ALDERMAN");
	precacheString(&"CREDIT_KEITH_BELL");
	precacheString(&"CREDIT_STEVE_FUKUDA");
	precacheString(&"CREDIT_PRESTON_GLENN");
	precacheString(&"CREDIT_CHAD_GRENIER");
	precacheString(&"CREDIT_MACKEY_MCCANDLISH");
	precacheString(&"CREDIT_ZIED_RIEKE");
	precacheString(&"CREDIT_NATE_SILVERS");
	
	precacheString(&"CREDIT_ART");
	precacheString(&"CREDIT_BRAD_ALLEN");
	precacheString(&"CREDIT_CHRIS_HASSELL");
	precacheString(&"CREDIT_JEFF_HEATH");
	precacheString(&"CREDIT_PAUL_JURY_LEAD_2D");
	precacheString(&"CREDIT_JUSTIN_THOMAS");
	precacheString(&"CREDIT_KEVIN_CHEN_CONCEPT_ART");
	
	precacheString(&"CREDIT_ADDITIONAL_ART");
	precacheString(&"CREDIT_DAN_MODITCH");
	precacheString(&"CREDIT_SLOAN_ANDERSON");
	
	precacheString(&"CREDIT_ANIMATION");
	precacheString(&"CREDIT_MICHAEL_BOON");
	precacheString(&"CREDIT_URSULA_ESCHER");
	precacheString(&"CREDIT_CHANCE_GLASCO");
	precacheString(&"CREDIT_PAUL_MESSERLY");
	
	precacheString(&"CREDIT_ADDITIONAL_ANIMATION");
	precacheString(&"CREDIT_SHADOWS_IN_DARKNESS");
	
	precacheString(&"CREDIT_SOUND");
	precacheString(&"CREDIT_CHUCK_RUSSOM");
	
	precacheString(&"CREDIT_ADDITIONAL_SOUND");
	precacheString(&"CREDIT_JACK_GRILLO");
	
	precacheString(&"CREDIT_SYSTEM_ADMINISTRATOR");
	precacheString(&"CREDIT_BRYAN_KUHN");
	
	precacheString(&"CREDIT_MANAGEMENT");
	precacheString(&"CREDIT_GRANT_COLLIER_CEO");
	precacheString(&"CREDIT_VINCE_ZAMPELLA_CCO");
	precacheString(&"CREDIT_JASON_WEST_CTO");
	precacheString(&"CREDIT_JANICE_TURNER_OFFICE_MANAGER");
	
	precacheString(&"CREDIT_TESTERS");
	precacheString(&"CREDIT_CLIFTON_CLINE");
	precacheString(&"CREDIT_OLIVER_GEORGE");
	precacheString(&"CREDIT_CHRIS_HERMANS");
	precacheString(&"CREDIT_MATTHEW_LACKOWSKI");
	precacheString(&"CREDIT_SCOTT_MATLOFF");
	precacheString(&"CREDIT_GAVIN_MCCANDLISH");
	precacheString(&"CREDIT_DAVID_OBERLIN");
	
	precacheString(&"CREDIT_HISTORICAL_REFERENCE");
	precacheString(&"CREDIT_MIKE_PHILLIPS");
	precacheString(&"CREDIT_JOSH_HENNIGER");
	precacheString(&"CREDIT_DAVE_SANTI");
	precacheString(&"CREDIT_E_COMPANY");
	precacheString(&"CREDIT_8TH_GUARDS");
	precacheString(&"CREDIT_PARTICIPANTS");
	
	precacheString(&"CREDIT_SPECIAL_THANKS");
	precacheString(&"CREDIT_RON_DOORNINK");
	precacheString(&"CREDIT_LARRY_GOLDBERG_NAME");
	precacheString(&"CREDIT_MARK_LAMIA");
	precacheString(&"CREDIT_LAIRD_MALAMED");
	precacheString(&"CREDIT_BILL_ANKER");
	precacheString(&"CREDIT_GEORGE_ROSE");
	precacheString(&"CREDIT_GREG_DEUTSCH");
	precacheString(&"CREDIT_BRIAN_ADAMS");
	precacheString(&"CREDIT_THE_PHILLY_PLACE");
	precacheString(&"CREDIT_GRAY_MATTER");
	precacheString(&"CREDIT_JOHN_GARCIA_SHELTON");
	precacheString(&"CREDIT_SPARK_UNLIMITED");
	precacheString(&"CREDIT_THANKS1");
	precacheString(&"CREDIT_THANKS2");
	
	
	precacheString(&"CREDIT_ACTIVISION_CREDITS");
	
	precacheString(&"CREDIT_PRODUCTION");
	precacheString(&"CREDIT_THAINE_LYMAN");
	precacheString(&"CREDIT_KEN_MURPHY");
	precacheString(&"CREDIT_ERIC_GROSSMAN");
	precacheString(&"CREDIT_DANIEL_HAGERTY");
	precacheString(&"CREDIT_MATTHEW_BEAL");
	precacheString(&"CREDIT_ROBERT_KIRSCHENBAUM");
	precacheString(&"CREDIT_PATRICK_BOWMAN");
	precacheString(&"CREDIT_ERIC_ADAMS");
	precacheString(&"CREDIT_LAIRD_MALAMED_SENIOR_EXECUTIVE");
	precacheString(&"CREDIT_MARK_LAMIA_VP");
	precacheString(&"CREDIT_LARRY_GOLDBERG");
	
	precacheString(&"CREDIT_VOICES");
	precacheString(&"CREDIT_VOICE_CASTING2");
	precacheString(&"CREDIT_STEVE_BLUM");
	precacheString(&"CREDIT_JASON_STATHAM");
	precacheString(&"CREDIT_GIOVANNI_RIBISI");
	precacheString(&"CREDIT_GREGG_BERGER");
	precacheString(&"CREDIT_MICHAEL_GOUGH");
	precacheString(&"CREDIT_MICHAEL_BELL");
	precacheString(&"CREDIT_JIM_WARD");
	precacheString(&"CREDIT_NICK_JAMESON");
	precacheString(&"CREDIT_NEIL_ROSS");
	precacheString(&"CREDIT_DAVID_SOBOLOV");
	precacheString(&"CREDIT_ANDRE_SOGLIUZZO");
	precacheString(&"CREDIT_GRANT_ALBRECHT");
	precacheString(&"CREDIT_QUINTON_FLYNN");
	precacheString(&"CREDIT_JOSH_PASKOWITZ");
	precacheString(&"CREDIT_EARL_BOEN");
	precacheString(&"CREDIT_RECORDING_ENGINEERING_EDITING_VO_EFFECTS_DESIGN");
	precacheString(&"CREDIT_RIK_W_SCHAFFER_WOMB_MUSIC");
	precacheString(&"CREDIT_VOICES_RECORDED_AT_SALAMI_STUDIOS_AND_THE_CASTLE");
	
	precacheString(&"CREDIT_MUSIC");
	precacheString(&"CREDIT_MICHAEL_GIACCHINO");
	precacheString(&"CREDIT_JUSTIN_SKOMAROVSKY");
	
	precacheString(&"CREDIT_SCRIPT");
	precacheString(&"CREDIT_MICHAEL_SCHIFFER");
	
	precacheString(&"CREDIT_GLOBAL_BRAND_MANAGEMENT");
	precacheString(&"CREDIT_BRAD_CARRAWAY");
	precacheString(&"CREDIT_RICHARD_BREST");
	precacheString(&"CREDIT_DAVID_POKRESS");
	precacheString(&"CREDIT_DUSTY_WELCH");
	precacheString(&"CREDIT_KATHY_VRABECK");
	precacheString(&"CREDIT_MIKE_MANTARRO");
	precacheString(&"CREDIT_MICHELLE_NINO");
	precacheString(&"CREDIT_TRICIA_BERTERO");
	precacheString(&"CREDIT_JOHN_DILULLO");
	precacheString(&"CREDIT_JULIE_DEWOLF");
	
	precacheString(&"CREDIT_LEGAL");
	precacheString(&"CREDIT_GEORGE_ROSE");
	precacheString(&"CREDIT_GREG_DEUTSCH");
	
	precacheString(&"CREDIT_CREATIVE_SERVICES");
	precacheString(&"CREDIT_DENISE_WALSH");
	precacheString(&"CREDIT_MATHEW_STAINNER");
	precacheString(&"CREDIT_JILL_BARRY");
	precacheString(&"CREDIT_SHELBY_YATES");
	precacheString(&"CREDIT_HAMAGAMI_CARROLL");
	precacheString(&"CREDIT_SHELBY_YATES");
	precacheString(&"CREDIT_IGNITED_MINDS");
	
	precacheString(&"CREDIT_INTERNATIONAL");
	precacheString(&"CREDIT_SCOTT_DODKINS");
	precacheString(&"CREDIT_ROGER_WALKDEN");
	precacheString(&"CREDIT_ALISON_TURNER");
	precacheString(&"CREDIT_NATHALIE_RANSON");
	precacheString(&"CREDIT_JACKIE_SUTTON");
	precacheString(&"CREDIT_TAMSIN_LUCAS");
	precacheString(&"CREDIT_SIMON_DAWES");
	precacheString(&"CREDIT_TREVOR_BURROWS");
	precacheString(&"CREDIT_DALEEP_CHHABRIA");
	precacheString(&"CREDIT_HEATHER_CLARKE");
	precacheString(&"CREDIT_LYNNE_MOSS");
	precacheString(&"CREDIT_VICTORIA_FISHER");
	
	precacheString(&"CREDIT_GERMAN_LOCALIZATION");
	precacheString(&"CREDIT_FRENCH_LOCALIZATION");
	precacheString(&"CREDIT_ITALIAN_SPANISH_LOCALIZATION");
	precacheString(&"CREDIT_JAPANESE_LOCALIZATION");
	precacheString(&"CREDIT_CHINESE_LOCALIZATION");
	precacheString(&"CREDIT_KOREAN_LOCALIZATION");
	
	precacheString(&"CREDIT_ACTIVISION_GERMANY");
	precacheString(&"CREDIT_STEFAN_LULUDES");
	precacheString(&"CREDIT_BERND_REINARTZ");
	precacheString(&"CREDIT_JULIA_VOLKMANN");
	precacheString(&"CREDIT_STEFAN_SEIDEL");
	precacheString(&"CREDIT_THORSTEN_HMANN");
	
	precacheString(&"CREDIT_ACTIVISION_FRANCE");
	precacheString(&"CREDIT_BERNARD_SIZEY");
	precacheString(&"CREDIT_GUILLAUME_LAIRAN");
	precacheString(&"CREDIT_GAUTIER_ORMANCEY");
	precacheString(&"CREDIT_DIANE_DE_DOMECY");
	
	precacheString(&"CREDIT_CENTRAL_TECHNOLGY");
	precacheString(&"CREDIT_JOHN_FRITTS");
	precacheString(&"CREDIT_ANDREW_PETTERSON");
	
	precacheString(&"CREDIT_QUALITY_ASSURANCE_CUSTOMER_SUPPORT");
	precacheString(&"CREDIT_BRAD_SAAVEDRA");
	precacheString(&"CREDIT_MATT_MCCLURE");
	precacheString(&"CREDIT_MARILENA_RIXFORD");
	
	precacheString(&"CREDIT_QUALITY_ASSURANCE");
	precacheString(&"CREDIT_BRYAN_JURY");
	precacheString(&"CREDIT_ERIK_MELEN");
	precacheString(&"CREDIT_PETER_BEAL");
	precacheString(&"CREDIT_ROBERT_MAX_MARTIN");
	precacheString(&"CREDIT_PAUL_GOLDILLA");
	
	precacheString(&"CREDIT_TESTERS");
	precacheString(&"CREDIT_RANDOLPH_AMORE");
	precacheString(&"CREDIT_SEAN_BERRETT");
	precacheString(&"CREDIT_DONALD_MARSHALL");
	precacheString(&"CREDIT_SOUKHA_PHIMPASOUK");
	precacheString(&"CREDIT_KEITH_MCCLELLAN");
	precacheString(&"CREDIT_KIM_CARRASCO");
	precacheString(&"CREDIT_MIKE_CURRAN");
	precacheString(&"CREDIT_SUNGWON_CHOE");
	precacheString(&"CREDIT_SADULLAH_NADER");
	precacheString(&"CREDIT_JEFF_GRANT");
	precacheString(&"CREDIT_MICHAEL_RADZICHOVSKY");
	precacheString(&"CREDIT_PATRICK_RYAN");
	precacheString(&"CREDIT_CARLOS_RAMIREZ");
	precacheString(&"CREDIT_DYLAN_LEONG");
	precacheString(&"CREDIT_MORRISON_CHEN");
	precacheString(&"CREDIT_RODRICK_RIPLEY");
	precacheString(&"CREDIT_DOUG_WOOTEN");
	precacheString(&"CREDIT_AARON_MOSNY");
	precacheString(&"CREDIT_JAY_FRANKE");
	precacheString(&"CREDIT_HENRY_VILLANUEVA");
	precacheString(&"CREDIT_NATHANIEL_MCCLURE");
	
	precacheString(&"CREDIT_SUPPORTING_LEADS");
	precacheString(&"CREDIT_CHRIS_KEIM");
	precacheString(&"CREDIT_NEIL_BARIZO");
	precacheString(&"CREDIT_TIM_VANLAW");
	precacheString(&"CREDIT_JEF_SEDIVY");
	
	precacheString(&"CREDIT_CRG_TESTERS");
	precacheString(&"CREDIT_DOUGLAS_RICHARD_TODD");
	precacheString(&"CREDIT_MIKE_RESTIFO");
	precacheString(&"CREDIT_JAMES_CALL");
	precacheString(&"CREDIT_GIAN_DERIVI");
	
	precacheString(&"CREDIT_PAUL_COLBERT");
	precacheString(&"CREDIT_ANTHONY_HATCH_KOROTKO");
	precacheString(&"CREDIT_ADAM_HARTSFIELD");
	
	precacheString(&"CREDIT_LOCALIZATIONS_TEST_TEAM");
	precacheString(&"CREDIT_ISREAL_BARCO");
	precacheString(&"CREDIT_DANIEL_CHENG");
	precacheString(&"CREDIT_ANDREW_CHRISTY");
	precacheString(&"CREDIT_CHRIS_SIMON");
	precacheString(&"CREDIT_CHRIS_DOLAN");
	precacheString(&"CREDIT_JOHN_BATSHON");
	precacheString(&"CREDIT_MICHAEL_D_HILL");
	precacheString(&"CREDIT_RYAN_FORD");
	precacheString(&"CREDIT_DANE_FREDERIKSEN");
	precacheString(&"CREDIT_JOHN_WHANG");
	precacheString(&"CREDIT_JESSE_BLACK_MOONEY");
	precacheString(&"CREDIT_DUSTIN_GREEN");
	precacheString(&"CREDIT_MICHAEL_ISLES");
	precacheString(&"CREDIT_TIM_KEOSABABIAN");
	precacheString(&"CREDIT_KEVIN_KRAEER");
	precacheString(&"CREDIT_DANNY_YANEZ");
	
	precacheString(&"CREDIT_THIRD_SHIFT");
	precacheString(&"CREDIT_JASON_LEVINE");
	
	precacheString(&"CREDIT_THIRD_SHIFT_TESTERS");
	precacheString(&"CREDIT_ANDREW_LIU");
	precacheString(&"CREDIT_RONALD_HART");
	precacheString(&"CREDIT_MATT_RYDER");
	
	precacheString(&"CREDIT_BOB_MCPHERSON");
	
	precacheString(&"CREDIT_CUSTOMER_SUPPORT_LEADS");
	precacheString(&"CREDIT_GARY_BOLDUC");
	precacheString(&"CREDIT_MICHAEL_HILL");
	precacheString(&"CREDIT_ROB_LIM");
	
	precacheString(&"CREDIT_ACTIVISION_SPECIAL_THANKS");
	precacheString(&"CREDIT_STEVE_ROSENTHAL");
	precacheString(&"CREDIT_PETER_MURAVEZ");
	precacheString(&"CREDIT_JUAN_VALDEZ");
	precacheString(&"CREDIT_DOUG_AVERY");
	precacheString(&"CREDIT_STEVE_HOLMES");
	precacheString(&"CREDIT_JASON_KIM");
	precacheString(&"CREDIT_SAM_NOURIANI");
	precacheString(&"CREDIT_BRELAN_DUFF");
	precacheString(&"CREDIT_MATT_MORTON");
	precacheString(&"CREDIT_CARYN_LAW");
	precacheString(&"CREDIT_BRIAN_PASS");
	precacheString(&"CREDIT_BLAINE_CHRISTINE");
	precacheString(&"CREDIT_RYAN_RUCINSKI");
	precacheString(&"CREDIT_BRENT_BOYLEN");
	precacheString(&"CREDIT_JOE_SHACKLEFORD");
	precacheString(&"CREDIT_ASIF_HUSAIN");
	precacheString(&"CREDIT_CASEY_KEEFE");
	precacheString(&"CREDIT_JONATHAN_MOSES");
	precacheString(&"CREDIT_GENE_BAHNG");
	precacheString(&"CREDIT_GLENN_IGE");
	precacheString(&"CREDIT_AARON_GRAY");
	precacheString(&"CREDIT_DOUG_PEARSON");
	precacheString(&"CREDIT_DANNY_TAYLOR");
	precacheString(&"CREDIT_EAIN_BANKINS");
	precacheString(&"CREDIT_MARC_STRUHL");
	precacheString(&"CREDIT_PAT_DWYER");
	precacheString(&"CREDIT_JAMES_MAYEDA");
	precacheString(&"CREDIT_DAVID_DALZELL");
//	precacheString(&"CREDIT_KEVIN_KRAEER");
	precacheString(&"CREDIT_KEVIN_KRAFF");
	precacheString(&"CREDIT_GRAEME_DEVINE");
	precacheString(&"CREDIT_JAMES_MONROE");
	precacheString(&"CREDIT_STE_CORK");
	precacheString(&"CREDIT_DAVID_LUNTZ");
	precacheString(&"CREDIT_SEBASTIEN_LAURENT");
	precacheString(&"CREDIT_ROBERT_DEPALMA");
	
	precacheString(&"CREDIT_CS_QA_SPECIAL_THANKS");
	precacheString(&"CREDIT_JIM_SUMMERS");
	precacheString(&"CREDIT_JASON_WONG");
	precacheString(&"CREDIT_JOE_FAVAZZA");
	precacheString(&"CREDIT_ADAM_HARTSFIELD_NAME");
	precacheString(&"CREDIT_ED_CLUNE");
	precacheString(&"CREDIT_NADINE_THEUZILLOT");
	precacheString(&"CREDIT_CHAD_SIEDOFF");
	precacheString(&"CREDIT_INDRA_GUNAWAN");
	precacheString(&"CREDIT_MARCO_SCATAGLINI");
	precacheString(&"CREDIT_JOULE_MIDDLETON");
	precacheString(&"CREDIT_TODD_KOMESU");
	precacheString(&"CREDIT_MIKE_BECK");
	precacheString(&"CREDIT_WILLIE_BOLTON");
	precacheString(&"CREDIT_JOHN_ROSSER");
	precacheString(&"CREDIT_JASON_POTTER");
	precacheString(&"CREDIT_GLENN_VISTANTE");
	precacheString(&"CREDIT_JENNIFER_VITIELLO");
	precacheString(&"CREDIT_MIKE_RIXFORD");
	precacheString(&"CREDIT_TYLER_RIVERS");
	precacheString(&"CREDIT_NICK_FAVAZZA");
	precacheString(&"CREDIT_JESSICA_MCCLURE");
	precacheString(&"CREDIT_JANNA_SAAVEDRA");
	
	precacheString(&"CREDIT_CHAPTER_BRIEF1");
	precacheString(&"CREDIT_CHAPTER_BRIEF2");
	precacheString(&"CREDIT_EDWARD_F");
	precacheString(&"CREDIT_JARETT_MELVILLE");
	
	precacheString(&"CREDIT_INTRODUCTION_CINEMATIC");
	precacheString(&"CREDIT_ROB_TROY");
	precacheString(&"CREDIT_LISA_RIZNIKOVE");
	precacheString(&"CREDIT_DAN_BAKER");
	
}

