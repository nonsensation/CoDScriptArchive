/**************************************************************************
Level: 		TANK FACTORY
Campaign: 	Soviet
Objectives: 	1. Secure the Tank repair facility
***************************************************************************/

#using_animtree("generic_human");
main()
{
	setExpFog (.000162, .78, .79, .80, 0);
	maps\_load::main();
	maps\_treadfx::main();
	maps\_bombs::init();
	
	//Set Ambient Tracks
	level.ambient_track ["interior"] = "ambient_factory_int";
	level.ambient_track ["exterior"] = "ambient_factory_ext";
	
	maps\factory_fx::main();
	maps\factory_anim::main();
	level.campaign = "russian";
	
	goal = getent ("goal","targetname");
	objective_add(1, "active", &"FACTORY_OBJECTIVE_SECURE", goal.origin);
	objective_current(1);
	
	thread firstspawners();
	thread First_Area();
	thread end_trigger();
	thread plantbomb();
	thread DoorFX_Setup();
	thread movetruck(1);
	thread movetruck(2);
	
	level.cinema1 = 0;
	level.cinema2 = 0;
	level.truck1 = 0;
	level.truck2 = 0;
	level.flags["bomber1_ready"] = false;
	level.flags["bomber2_ready"] = false;
	
	level.mortar = loadfx ("fx/surfacehits/mortarImpact_snow.efx");
	thread maps\_mortar::railyard_style();
	thread maps\_mortar::trigger_targeted();
	thread maps\_utility::set_ambient("exterior");
	thread CinemaSetup(1);
	thread CinemaSetup(2);
	thread bomb_setup();
	thread here_come_friends();
	thread musicloop();
}

musicloop()
{
	level endon ("in factory");
	wait .05;
	musicplay("pf_stealth");

	while(1)
	{
		wait 1;
		musicplay("pf_stealth");
	}
}

musicloop2()
{
	musicplay("redsquare_dark");

	while(1)
	{
		wait 15;
		musicplay("redsquare_dark");
	}
}

firstspawners()
{
	level waittill ("starting final intro screen fadeout");
	
	thread friends();
	
	guys = getentarray ("firstspawners","targetname");
	for (i=0;i<guys.size;i++)
		guys[i] dospawn();
}

end_trigger()
{
	end_trigger = getent ("end_trigger", "targetname");
	end_trigger waittill ("trigger");
	objective_state(1, "done");
	wait 1;
	if (isalive (level.player))
	{
		//maps\_utility::save_friendlies();
		//get number of friendly AI that are left with the player
		russians = getaiarray("allies");
		game["friendlies"] = 0;
		for (i=0;i<russians.size;i++)
		{
			if (distance(level.player.origin,russians[i].origin) < 1000)
				game["friendlies"]++;
		}
		missionSuccess ("railyard", true);
	}
}

friends()
{
	level.friends = getentarray ("friend", "targetname");
	for (i=0;i<level.friends.size;i++)
	{
		
		level.friends[i].followmax = 2;
		level.friends[i].followmin = -2;
		level.friends[i] setgoalentity (level.player);
		level.friends[i].goalradius = (256);
		
		if (i == 0)//make sure bombplanter 1 can't die
			level.friends[i].health = 50000;
		if (i == 1)//make sure bombplanter 2 can't die
			level.friends[i].health = 50000;
		if (i == 2)
			level.friends[i].health = 400;
	}
}

First_Area()
{
	getent ("firstarea","targetname") waittill ("trigger");
	
	if ( isalive (level.friends[0]) )
		level.friends[0] setgoalnode (getnode("bombwait1", "targetname"));
	if ( isalive (level.friends[1]) )
		level.friends[1] setgoalnode (getnode("bombwait2", "targetname"));
	
	thread Bombers_Wait();

	if ( isalive (level.friends[2]) )
		level.friends[2] setgoalnode (getnode("wait1", "targetname"));
	if ( isalive (level.friends[3]) )
		level.friends[3] setgoalnode (getnode("wait2", "targetname"));
	if ( isalive (level.friends[4]) )
		level.friends[4] setgoalnode (getnode("wait3", "targetname"));
	
	level.friends[0] waittill ("goal");
	level.flags["bomber1_ready"] = true;
	thread Second_Area();
}

Second_Area()
{
	getent ("secondarea","targetname") waittill ("trigger");
	for (i=0;i<level.friends.size;i++)
	{
		if (isalive(level.friends[i]))
		{
			level.friends[i].followmax = 0;
			level.friends[i].followmin = -2;
		}
	}
}

Bombers_Wait()
{
	level.friends[1] waittill ("goal");
	level.flags["bomber2_ready"] = true;
	
	while (1)
	{
		if ( (level.flags["bomber1_ready"] == true) && (level.flags["bomber2_ready"] == true) )
		{
			level notify ("Plant_Bombs");
			return;
		}
		wait .5;
	}
}

InFactory()
{
	
	getent ("infactory","targetname") waittill ("trigger");
	for (i=0;i<level.friends.size;i++)
	{
		if (isalive(level.friends[i]))
		{
			level.friends[i].followmax = 0;
			level.friends[i].followmin = -3;
			level.friends[i] setgoalentity (level.player);
			
			if (i == 0)
				level.friends[i].health = 100;//make him the second health biased friendly
			if (i == 1)
				level.friends[i].health = 400;
		}
	}
	
}

dialogue_start()
{
	if ( ( isalive (level.friends[0]) ) && ( isalive (level.friends[1]) ) )
	{
		level.friends[0] thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][0], "factory_private2_blastthisdoor", 1.0, "dialoguedone");
		wait 1.5;
		//level.friends[0] waittill ("dialoguedone");
		
		level.friends[1] thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][1], "factory_private1_generalsracing", 1.0, "dialoguedone");
		wait 2.5;
		//level.friends[1] waittill ("dialoguedone");
		
		level.friends[0] thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][2], "factory_private2_womenchampagne", 1.0, "dialoguedone");
		wait 2.5;
		//level.friends[0] waittill ("dialoguedone");
		
		level.friends[1] thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][3], "factory_private1_thelastgeneral", 1.0, "dialoguedone");
		wait 3;
		//level.friends[1] waittill ("dialoguedone");
		
		level.friends[0] thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][4], "factory_private2_nkvd", 1.0, "dialoguedone");
	}
}

over_here_dialogue()
{
	level endon ("Doing Bombs");
	
	wait 2;
	level.friends[0].scripted_dialogue = ("factory_private1_overhere1");
	level.friends[0].facial_animation = (level.scr_anim["face"][5]);
	level.friends[0] animscripted("animdone", level.friends[0].origin, level.friends[0].angles, level.scr_anim["private"]["overhere"]);
	
	wait 6;
	level.friends[0].scripted_dialogue = ("factory_private1_thisway");
	level.friends[0].facial_animation = (level.scr_anim["face"][6]);
	level.friends[0] animscripted("animdone", level.friends[0].origin, level.friends[0].angles, level.scr_anim["private"]["thisway"]);
}

plantbomb()//start scripted sequence of ai putting bombs on door and running.
{
	getent ("bombguys","targetname") waittill ("trigger");
	
	while ( (level.flags["bomber1_ready"] == false) || (level.flags["bomber2_ready"] == false) )
		wait .5;
	
	thread InFactory();
	if ( ( isalive (level.friends[0]) ) && ( isalive (level.friends[1]) ) )
	{
		
		thread over_here_dialogue();
		
		while ( (distance(level.player.origin, level.friends[0].origin) > 400) || (distance(level.player.origin, level.friends[1].origin) > 400) )
			wait 1;
		
		level notify ("Doing Bombs");
		
		thread dialogue_start();
		
		level.friends[0].goalradius = (128);
		level.friends[1].goalradius = (128);
		level.friends[0] setgoalnode (getnode("bombnode2","targetname"));
		level.friends[1] setgoalnode (getnode("bombnode1","targetname"));
		
		wait 1;
		level.guysdoinganim = 0;
		level.friends[0] thread maps\_scripted::main ("bomb", "left", "bombnode1", maps\factory::leftbombguy_thread);
		level.friends[1] thread maps\_scripted::main ("bomb", "right", "bombnode1", maps\factory::rightbombguy_thread);
		
		if ( isalive (level.friends[2]) )
			level.friends[2] setgoalnode (getnode("cover1", "targetname"));
		if ( isalive (level.friends[3]) )
			level.friends[3] setgoalnode (getnode("cover2", "targetname"));
		if ( isalive (level.friends[4]) )
			level.friends[4] setgoalnode (getnode("cover3", "targetname"));
		
		while (level.guysdoinganim < 1)
			wait 1;
		wait 12;
		thread SpawnEnemies();
		
		leftdoor = getent ("leftdoor","targetname");
		rightdoor = getent ("rightdoor","targetname");
		leftdoor connectpaths();
		rightdoor connectpaths();
		
		leftorg = (leftdoor.origin - (0, 32, 0));
		rightorg = (rightdoor.origin - (0, 32, 0));
		leftdoor thread doors_blowopen(leftorg, 1);
		rightdoor thread doors_blowopen(rightorg, 2);
		level notify ("Stop Tick");
		
		level thread maps\_utility::playSoundinSpace("Explo_metal_doors", (0,444,48));
		
		level notify ("DoFX");
		
		bombs = getentarray ("bomb", "targetname");
		for (i=0;i<bombs.size;i++)
			bombs[i] delete();
	}
	else
	{
		thread SpawnEnemies();
		leftdoor = getent ("leftdoor","targetname");
		rightdoor = getent ("rightdoor","targetname");
		leftdoor delete();
		rightdoor delete();
		
		brokendoors = getent("brokendoors","targetname");
		if (isdefined (brokendoors))
			brokendoors delete();
	}
}

doors_blowopen(org, opt)
{
	temp_vec = vectornormalize (self.origin - org);
	temp_vec = maps\_utility::vectorScale (temp_vec, 300);

	x = temp_vec[0];
	y = temp_vec[1];
	z = 350;
	
	//wait .2;
	
	if (opt == 1)
	{
		self rotateVelocity((250,250,250),1,0,0); //(x,y,z),time,accel,decel
		self moveGravity ((x, y, z), 1); //(x,y,z),time
	}
	if (opt == 2)
	{
		self rotateVelocity((-200,-175,-150),1,0,0);
		self moveGravity ((x, y, z), 1);
	}
	
	wait (1);
	self delete();
	level notify ("in factory");
	level thread musicloop2();
}

DoorFX_Setup()
{
	doorfx = getentarray ("doorfx","targetname");
	for (i=0;i<doorfx.size;i++)
	{
		if (isdefined(doorfx[i]))
			doorfx[i] hide();
	}
	
	level waittill ("DoFX");
	
	doorfx = getentarray ("doorfx","targetname");
	for (i=0;i<doorfx.size;i++)
	{
		if (isdefined(doorfx[i]))
			doorfx[i] thread maps\_utility::cannon_effect(doorfx[i]);
	}
	radiusDamage ( (20,400,50),  200, 400, 200);
}

bomb_setup()
{
	bombs = getentarray ("bomb", "targetname");
	for (i=0;i<bombs.size;i++)
		bombs[i] hide();
}

SpawnEnemies()//spawns enemies on other side of the door, called from plantbomb()
{
	enemy = getentarray ("auto77","targetname");
	for (i=0;i<enemy.size;i++)
		enemy[i] dospawn();
}

leftbombguy_thread()//prep left guy to plant bomb on door
{
	self animscripts\shared::PutGunInHand("none");
	self thread more_notes();
	self animscripts\shared::DoNoteTracks("scriptedanimdone", ::LeftGuy_Anim);
}

rightbombguy_thread()//prep right guy to plant bomb on door
{
	self animscripts\shared::PutGunInHand("none");
	self animscripts\shared::DoNoteTracks("scriptedanimdone", ::RightGuy_Anim);
	self.goalradius = (32);
	self setgoalnode (getnode("bombguy2cover","targetname"));
}

LeftGuy_Anim(note)
{
	level.guysdoinganim++;
	switch (note)
	{
		case "attach bomb = \"left\"":
			self attach("xmodel/explosivepack", "tag_weapon_left");
			break;
		case "plant bombs":
			//self attach("xmodel/explosivepack", "tag_weapon_right");
			break;
		case "attach bomb = \"right\"":
			level notify ("new bomb soon");
			break;
		case "factory equip weapon":
			self animscripts\shared::PutGunInHand("right");
			break;
		case "factory end":
			self notify ("end_sequence");
			self.goalradius = (32);
			self setgoalnode (getnode("bombguy1cover","targetname"));
			self.health = 300;
			//wait 3;
			//level notify ("bombfinish");
			break;
	}
}

more_notes()
{
	level waittill ("new bomb soon");
	wait 1.2;
	self attach("xmodel/explosivepack", "tag_weapon_right");
	level waittill ("bomb switch");
	wait (0.1);
	self detach("xmodel/explosivepack", "tag_weapon_left");
	self detach("xmodel/explosivepack", "tag_weapon_right");
}

RightGuy_Anim(note)
{
	level.guysdoinganim++;
	switch (note)
	{
		case "dialogue1":
			self attach("xmodel/explosivepack", "tag_weapon_left");
			self attach("xmodel/explosivepack", "tag_weapon_right");
			break;
		case "dialogue2":
			self detach("xmodel/explosivepack", "tag_weapon_left");
			break;
		case "dialogue3":
			self attach("xmodel/explosivepack", "tag_weapon_left");
		case "plant bombs":
			//level thread dobombstuff_rightguy(self);
			/*
			println ("^2############################");
			println ("^3############################");
			println ("^4############################");
			*/
			self.goalradius = (32);
			self setgoalnode (getnode("bombguy2cover","targetname"));
			self.health = 300;
			
			wait 1;
			bombs = getentarray ("bomb", "targetname");
			for (i=0;i<bombs.size;i++)
				bombs[i] show();
			
			level thread bomb_tick();
			
			level notify ("bomb switch");
			self detach("xmodel/explosivepack", "tag_weapon_left");
			self detach("xmodel/explosivepack", "tag_weapon_right");
			wait 2;
			self.allowdeath = 1;
			
			break;
		case "anim_movement = \"run\"":
			/*
			println ("^2############################");
			println ("^3############################");
			println ("^4############################");
			self.goalradius = (32);
			self setgoalnode (getnode("bombguy2cover","targetname"));
			self.health = 300;
			*/
			break;
	}
}

bomb_tick()
{
	soundent = spawn ("script_origin",(0,444,48));
	soundent playloopsound ("bomb_tick");
	level waittill ("DoFX");
	soundent stoploopsound ("bomb_tick");
	soundent delete();
}

dobombstuff_rightguy(guy)
{
	wait 1;
	bombs = getentarray ("bomb", "targetname");
	for (i=0;i<bombs.size;i++)
		bombs[i] show();
	
	level notify ("bomb switch");
	guy detach("xmodel/explosivepack", "tag_weapon_left");
	guy detach("xmodel/explosivepack", "tag_weapon_right");
	wait 2;
	guy.allowdeath = 1;
}

//////////////////////////////////////////////////////
//USED FOR OUTDOOR BATTLES SEEN FROM FACTORY WINDOWS//
//////////////////////////////////////////////////////
CinematicGuyson(j)//used to keep spawning AI as they die until the player walks through a triggeroff
{
	if (j == 1)
	{
		self waittill("trigger");
		if (level.cinema1 == 0)
		{
			level.cinema1 = 1;
			
			for (i=0;i<level.CinemaTrigger1on.size;i++)
				level.CinemaTrigger1on[i] thread maps\_utility::triggerOff();
			
			for (i=0;i<level.CinemaTrigger1off.size;i++)
			{
				level.CinemaTrigger1off[i] thread maps\_utility::triggerOn();
				level.CinemaTrigger1off[i] thread CinematicGuysoff(1);
			}
			
			count = 0;
			while (level.cinema1 == 1)
			{	
				GetCinemaGuyArrays(1);
				
				if (level.Cinematic_Axis1.size < level.axisguys.size)
				if (level.truck2 != 1)
				{
					guy = level.axisguys[randomint(level.axisguys.size)] dospawn("Cinematic_Axis_Alive");
					if ((isdefined (guy)) && (isalive (guy)))
						guy.DropWeapon = false;
					count = (count + 1);
					if (count >= 20)
						CinemaDone(1);
				}
				
				if (level.Cinematic_Allies1.size < 4)
				{
					guy2 = level.alliesguys[randomint(level.alliesguys.size)] dospawn("Cinematic_Allies_Alive");
					if ((isdefined (guy2)) && (isalive (guy2)))
						guy2.DrawOnCompass = false;
					if ((isdefined (guy2)) && (isalive (guy2)))
						guy2.DropWeapon = false;
					if ((isdefined (guy2)) && (isalive (guy2)))
						guy2.bravery = guy2.bravery + 1000;
				}
				wait ( 0.5 + randomint(5) );
			}
		}
	}
	
	if (j == 2)
	{
		self waittill("trigger");
		if (level.cinema2 == 0)
		{
			level.cinema2 = 1;
			
			for (i=0;i<level.CinemaTrigger2on.size;i++)
				level.CinemaTrigger2on[i] thread maps\_utility::triggerOff();
			
			for (i=0;i<level.CinemaTrigger2off.size;i++)
			{
				level.CinemaTrigger2off[i] thread maps\_utility::triggerOn();
				level.CinemaTrigger2off[i] thread CinematicGuysoff(2);
			}
			
			while (level.cinema2 == 1)
			{
				GetCinemaGuyArrays(2);
				
				if (level.Cinematic_Axis2.size < 15)
				if (level.truck1 == 0)
				{
					guy = level.axisguys2[randomint(level.axisguys2.size)] dospawn("Cinematic_Axis_Alive2");
					if ((isdefined (guy)) && (isalive (guy)))
						guy.DropWeapon = false;
				}
				
				if (level.Cinematic_Allies2.size < 10)
				{
					guy2 = level.alliesguys2[randomint(level.alliesguys2.size)] dospawn("Cinematic_Allies_Alive2");
					if ((isdefined (guy2)) && (isalive (guy2)))
						guy2.DrawOnCompass = false;
					if ((isdefined (guy2)) && (isalive (guy2)))
						guy2.DropWeapon = false;
					if ((isdefined (guy2)) && (isalive (guy2)))
						guy2.bravery = guy2.bravery + 1000;
				}
				wait ( 0.5 + randomint(5) );
			}
		}
	}
}

CinematicGuysoff(n)//used when a player triggers an off trigger, the triggers are reset and AI are deleted
{
	if (n == 1)
	{
		self waittill("trigger");
		if (level.cinema1 != 0)
		{
			level.cinema1 = 0;
			//DeleteCinemaGuys(1);
			CinemaSetup(1);
		}
	}
	if (n == 2)
	{
		self waittill("trigger");
		if (level.cinema2 == 1)
		{
			level.cinema2 = 0;
			//DeleteCinemaGuys(2);
			CinemaSetup(2);
		}
	}
}

GetCinemaGuyArrays(num)//pulls the entities into the variabls
{
	if (num == 1)
	{
		level.axisguys = 		getentarray ("cinematicAxis1", "targetname");
		level.alliesguys = 		getentarray ("cinematicAllies1", "targetname");
		level.Cinematic_Axis1 = 	getentarray ("Cinematic_Axis_Alive", "targetname");
		level.Cinematic_Allies1 = 	getentarray ("Cinematic_Allies_Alive", "targetname");
	}
	if (num == 2)
	{
		level.axisguys2 = 		getentarray ("cinematicAxis2", "targetname");
		level.alliesguys2 = 		getentarray ("cinematicAllies2", "targetname");
		level.Cinematic_Axis2 = 	getentarray ("Cinematic_Axis_Alive2", "targetname");
		level.Cinematic_Allies2 = 	getentarray ("Cinematic_Allies_Alive2", "targetname");
	}
}

DeleteCinemaGuys(group)//actually deletes the AI, called from CinematicGuysoff()
{
	if (group == 1)
	{
		GetCinemaGuyArrays(1);
		for (i=0;i<level.Cinematic_Axis1.size;i++)
		{
			if (isalive (level.Cinematic_Axis1[i]))
			{
				level.Cinematic_Axis1[i] notify ("death");
				level.Cinematic_Axis1[i] delete();
			}
		}
		wait .5;
		for (i=0;i<level.Cinematic_Allies1.size;i++)
		{
			if (isalive (level.Cinematic_Allies1[i]))
			{
				level.Cinematic_Allies1[i] notify ("death");
				level.Cinematic_Allies1[i] delete();
			}
		}
	}
	if (group == 2)
	{
		GetCinemaGuyArrays(2);
		for (i=0;i<level.Cinematic_Axis2.size;i++)
		{
			if (isalive (level.Cinematic_Axis2[i]))
			{
				level.Cinematic_Axis2[i] notify ("death");
				level.Cinematic_Axis2[i] delete();
			}
		}
		wait .5;
		for (i=0;i<level.Cinematic_Allies2.size;i++)
		{
			if (isalive (level.Cinematic_Allies2[i]))
			{
				level.Cinematic_Allies2[i] notify ("death");
				level.Cinematic_Allies2[i] delete();
			}
		}
	}
		
}

CinemaSetup(num)//prepares the triggers at the start of the level and starts the CinematicGuyson() thread for the on triggers
{
	if (num == 1)
	{
		level.CinemaTrigger1on = getentarray ("cinematicGuys1_triggeron", "targetname");
		for (i=0;i<level.CinemaTrigger1on.size;i++)
		{
			level.CinemaTrigger1on[i] thread maps\_utility::triggerOn();
			level.CinemaTrigger1on[i] thread CinematicGuyson(1);
		}
		level.CinemaTrigger1off = getentarray ("cinematicGuys1_triggeroff", "targetname");
		for (i=0;i<level.CinemaTrigger1off.size;i++)
			level.CinemaTrigger1off[i] thread maps\_utility::triggerOff();
	}
	if (num == 2)
	{
		level.Allies2_targets 	= getnodearray ("cinematicAllies2_targets", "targetname");
		level.CinemaTrigger2on 	= getentarray ("cinematicGuys2_triggeron", "targetname");
		for (i=0;i<level.CinemaTrigger2on.size;i++)
		{
			level.CinemaTrigger2on[i] thread maps\_utility::triggerOn();
			level.CinemaTrigger2on[i] thread CinematicGuyson(2);
		}
		level.CinemaTrigger2off = getentarray ("cinematicGuys2_triggeroff", "targetname");
		for (i=0;i<level.CinemaTrigger2off.size;i++)
			level.CinemaTrigger2off[i] thread maps\_utility::triggerOff();
	}
}

CinemaDone(num)
{
	if (num == 1)
	{
		GetCinemaGuyArrays(1);
		while (level.Cinematic_Axis1.size > 0)
		{
			wait 1;
			GetCinemaGuyArrays(1);
		}
		
		level.cinema1 = 2;
		
		wait 1;
		GetCinemaGuyArrays(1);
		for (i=0;i<level.Cinematic_Allies1.size;i++)
			level.Cinematic_Allies1[i] thread Allies_MoveIn1("cinema1done");
	}
	else
	if (num ==2)
	{
		GetCinemaGuyArrays(2);
		while (level.Cinematic_Axis2.size > 0)
		{
			wait 1;
			GetCinemaGuyArrays(2);
		}
		
		level.cinema2 = 2;
		
		node = getnode ("allies2node","targetname");
		
		wait 1;
		GetCinemaGuyArrays(2);
		for (i=0;i<level.Cinematic_Allies2.size;i++)
			level.Cinematic_Allies2[i] thread Allies_MoveIn2(node);
	}
}

Allies_MoveIn1(node)
{
	/*
	self thread Goto_Chained_Node(node);
	self waittill ("DeleteCinemaGuy");
	self notify ("death");
	self delete();
	*/
	
	cinema1finaldest = getnode ("cinema1finaldest","targetname");
	if ( (isdefined (self)) && (isdefined (cinema1finaldest)) )
	{
		wait randomfloat(8);
		self setgoalnode (cinema1finaldest);
		self waittill ("goal");
		self delete();
	}
}

Allies_MoveIn2(node)
{
	self setgoalnode (node);
	self.goalradius = 10;
	self waittill ("goal");
	self notify ("death");
	self delete();
}

///////////////////////////////////////////
//USED FOR SOVIET TRUCK IN CINEMA BATTLES//
///////////////////////////////////////////
movetruck(num)
{
	if ( num == 1 )
	{
		truck1 = getent ("truck1", "targetname");
		path1 = getVehicleNode(truck1.target,"targetname");
		
		truck1 attachpath (path1);
		
		truck1 thread maps\_truck::init_factory();
		
		wait .1;
		
		getent ("start_truck1","targetname") waittill ("trigger");
		
		truck1 maps\_truck::attach_guys("Cinematic_Allies_Alive2");
		
		//wait 2;
		
		truck1 startPath();
		
		thread CinemaDone(2);
		
		wait 20;
		
		level.truck1 = 1;
		
		truck1 disconnectpaths();
		
		truck1 notify ("unload");
		
		truck1 setspeed(0, 5);
	}
	if ( num == 2 )
	{
		truck2 = getent ("truck2", "targetname");
		path2 = getVehicleNode(truck2.target,"targetname");
		
		getent ("start_truck2","targetname") waittill ("trigger");
		
		truck2 attachpath (path2);
		
		truck2 thread maps\_truck::init_factory();
		
		wait .1;
		
		truck2 maps\_truck::attach_guys("Cinematic_Allies_Alive");
		
		//wait 2;
		
		truck2 startPath();
		
		thread CinemaDone(1);
		
		wait 14;
		
		level.truck2 = 1;
		
		truck2 disconnectpaths();
		
		truck2 notify ("unload");
		//level notify ("unloadtruck");
		
		truck2 setspeed(0, 5);
	}
}

Goto_Chained_Node(node)
{
	firstnode = getnode (node, "targetname");
	self setgoalnode (firstnode);
	self waittill ("goal");
	
	nextnode = getnode (firstnode.target, "targetname");
 	if ( !(isdefined (nextnode) ) )
  		return;
	
	while (isdefined (nextnode) && isalive (self) )
 	{
  		self setgoalnode(nextnode);
  		self waittill ("goal");
		
  		if (isdefined (nextnode.target))
  			nextnode = getnode (nextnode.target, "targetname");
  		else
  		{
  			self notify ("DeleteCinemaGuy");
  			break;
  		}
	}
}

here_come_friends()
{
	door = getent ("friendlydoor1","targetname");
	getent ("reinforcements1_trigger","targetname") waittill ("trigger");
	reinforcements = getentarray ("reinforcements1","targetname");
	guy[0] = reinforcements[0] dospawn();
	guy[1] = reinforcements[1] dospawn();
	
	if (isalive (guy[0]))
	{
		guy[0].goalradius = (8);
		guy[0] setgoalnode (getnode("reinforcement_node1","targetname"));
		guy[0] thread reinforcement_wait();
	}
	if (isalive (guy[1]))
	{
		guy[1].goalradius = (8);
		guy[1] setgoalnode (getnode("reinforcement_node2","targetname"));
		guy[1] thread reinforcement_wait();
	}
	wait .5;
	door connectpaths();
	door rotateyaw(-90, 1,0.25,0.25);
}

reinforcement_wait()
{
	self waittill ("goal");
	self thread animscripts\face::SayGenericDialogue("greetplayerloud");
	self.followmax = 2;
	self.followmin = -2;
	self setgoalentity (level.player);
	self.goalradius = (256);
}