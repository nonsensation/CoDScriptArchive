/**********************************************************************************
Level: 		RAILYARD (Tank Factory Part 2)
Campaign: 	Soviet
Objectives: 	1. Secure the Tank repair facility
		2. Regroup with the 4th army on the outskirts of the factory complex
***********************************************************************************/

main()
{
	setExpFog (.000162, .78, .79, .80, 0);
	maps\railyard_anim::main();
	maps\railyard_anim::tank_load_anims();
	maps\_load::main();
	maps\_tank::main();
	maps\_tiger::main();
	maps\_panzeriv::main();
	
	factorytanks_setup();
	
	//Set Ambient Tracks
	level.ambient_track ["interior"] = "ambient_railyard_int";
	level.ambient_track ["exterior"] = "ambient_railyard_ext";
	
	precacheModel("xmodel/vehicle_tank_panzeriv_machinegun");
	level.mortar = loadfx ("fx/surfacehits/mortarImpact_snow.efx");
	
	thread maps\_mortar::railyard_style();
	thread follow_player();
	thread artillery();
	thread maps\_utility::set_ambient("interior");
	thread level_end();
	thread tank();
	thread attack_player();
	thread musicloop();
	
	if (isdefined (game["friendlies"]))
	{
		if (game["friendlies"] > 2)
		{
			guy = getent ("extrarussian1","targetname");
			guy dospawn();
			game["friendlies"]--;
			if (game["friendlies"] > 2)
			{
				guy = getent ("extrarussian2","targetname");
				guy dospawn();
			}
			game["friendlies"] = undefined;
		}
	}
}

factorytanks_setup()
{
	tanks = getentarray ("warehousetank_tiger","targetname");
	for (i=0;i<tanks.size;i++)
	{
		tanks[i].tankgetout = 0;
		tanks[i] thread maps\_tiger::init_noattack();
	}
	
	tanks = getentarray ("warehousetank_panzer","targetname");
	for (i=0;i<tanks.size;i++)
	{
		tanks[i].tankgetout = 0;
		tanks[i] thread maps\_panzeriv::init_noattack();
	}
}

attack_player()
{
	getent ("goforplayer","targetname") waittill ("trigger");
	guys = getaiarray ("axis");
	for (i=0;i<guys.size;i++)
	{
		if ( (isalive (guys[i])) && (isdefined (guys[i].script_noteworthy)) && (guys[i].script_noteworthy == "getplayer") )
		{
			guys[i].goalradius = 64;
			guys[i] setgoalentity (level.player);
		}
	}
}

artillery()
{	
	allies = getaiarray ("allies");
	russian1 = allies[0];
	russian2 = allies[1];
	
	russian1 thread maps\_utility::magic_bullet_shield(1000000,3,400);
	russian2 thread maps\_utility::magic_bullet_shield(1000000,3,400);
	
	level waittill ("mortar");
	level waittill ("mortar");
	
	russian1 thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][0], "railyard_private1_whosearty", 1.0);
	wait 2;
	
	russian2 thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][1], "railyard_private2_matters", 1.0);
	wait 3.5;
	
	russian2 thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][2], "railyard_private1_iftheydidknow", 1.0);
	wait 2;
	
	russian2 thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][3], "railyard_private2_hardtosay", 1.0);
	wait 2;
	
	//russian1.health = 400;
	//russian2.health = 400;
	
	russian1 notify ("stop magic bullet shield");
	russian2 notify ("stop magic bullet shield");
}

musicloop()
{
	wait .05;
	musicplay("redsquare_tense");

	while(1)
	{
		wait 1;
		musicplay("redsquare_tense");
	}
}

splash_shield()
{
	healthbuffer = 2000;
	self.health += healthbuffer;
	while(self.health > 0)
	{
		oldhealth = self.health;
		self waittill ("damage",amount, attacker);
		
		if (attacker != level.player)
		{
			self.health = oldhealth;
			continue;
		}
		else if (amount > 999)
			break;
	}
	radiusDamage ( self.origin, 2, 10000, 9000);
}

level_end()
{
	trigger_level_end = getent ("level_end", "targetname");
	//objective_add(1, "done", &"FACTORY_OBJECTIVE_SECURE", (trigger_level_end.origin));
	//objective_state(1, "done");
	objective_add(1, "active", &"FACTORY_OBJECTIVE_REGROUP", (trigger_level_end.origin));
	objective_current(1);
	
	trigger_level_end waittill ("trigger");
	
	flooders = getentarray("auto1166","targetname");
	thread maps\_utility::array_notify(flooders,"disable");
	
	german_spawner = getspawnerteamarray ("axis");
	maps\_utility::array_notify(german_spawner,"disable");
	
	wait 1;
	germans = getaiarray ("axis");
	level.numleft = 0;
	for (i=0;i<germans.size;i++)
	{
		if ( (isdefined (germans[i].script_noteworthy)) && (germans[i].script_noteworthy == "mustdie") )
		{
			germans[i] thread wait_die();
			germans[i].count = 0;
			level.numleft++;
			//iprintln ("MUSTDIE GERMAN STILL ALIVE");
		}
	}
	
	//iprintln ("WAITING FOR " + level.numleft + " MUSTDIE GERMANS TO DIE");
	
	while (level.numleft > 0)
		wait 1;
	
	//iprintln ("GERMANS ARE DEAD - ENDING LEVEL");
	
	friends = getaiarray ("allies");
	for (i=0;i<friends.size;i++)
	{
		if ( (isdefined (friends[i].script_noteworthy)) && (friends[i].script_noteworthy == "finaltalker") )
		{
			talker = friends[i];
			talker.health = (1000000);
			break;
		}
	}
	
	objective_state(1, "done");
	
	if (isdefined (talker))
	{
		talker.goalradius = 8;
		talker setgoalnode (getnode ("finaldialogue","targetname"));
		talker waittill ("goal");
		talker thread final_dialogue();
	}
	wait 10;
	missionSuccess("tankdrivecountry", false);
}

wait_die()
{
	if ( (isdefined (self)) && (isalive (self)) )
		self waittill ("death");
	level.numleft--;
}

final_dialogue()
{
	self thread animscripts\shared::SetInCombat(false);
	self thread animscripts\shared::LookAtEntity(level.player, 10, "casual");
	self thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][4], "railyard_captain_goodforyou", 1.0, "dialoguedone");
	//wait 4;
	self waittill ("dialoguedone");
	self thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][5], "railyard_captain_beforetheartystarts", 1.0, "dialoguedone");
}

get_two_close_friendlies(distance)
{
	friendlies = getaiarray ("allies");
	while (1)
	{
		if ( ( isalive (friendlies[0]) ) && ( isalive (friendlies[1]) ) )
		{
			d0 = distance (level.player getorigin(), friendlies[0].origin);
			d1 = distance (level.player getorigin(), friendlies[1].origin);
		}
		else
		{
			while (1)
			{
				friendlies = getaiarray ("allies");
				if (friendlies.size < 2)
					wait 1;
				else
					break;
			}
			d0 = distance (level.player getorigin(), friendlies[0].origin);
			d1 = distance (level.player getorigin(), friendlies[1].origin);
		}
		
		if ( (d0 < distance) && (d1 < distance) )
		{
			return;
		}
		wait 1;
	}
}

follow_player()
{
	friends = getentarray ("friend", "targetname");
	for (i=0;i<friends.size;i++)
		friends[i].health = 1000000;
	
	first_area = getent("first_area", "targetname" );
	first_area waittill ("trigger");
	
	for (i=0;i<friends.size;i++)
		if (isalive(friends[i]))
		{
			friends[i].followmax = 0;
			friends[i].followmin = -2;
		}
}

tankguy1_damage()
{
	level.tank endon ("tankkilled");
	level endon ("INTANK");
	level endon ("GetInTank");
	
	self waittill ("damage");
	level notify ("GetInTank");
}

tankguy2_damage()
{
	level.tank endon ("tankkilled");
	level endon ("INTANK");
	level endon ("GetInTank");
	
	self waittill ("damage");
	level notify ("GetInTank");
}

getintank_wait()
{
	level.tank endon ("tankkilled");
	level endon ("INTANK");
	level endon ("GetInTank");
	
	getent ("tanktrigger","targetname") waittill ("trigger");
	level notify ("GetInTank");
}

tank()
{
	level.tankguy1 = getent ("tankguy1","targetname");
	level.tankguy2 = getent ("tankguy2","targetname");
	level.tank = getent ("tank","targetname");
	
	level.tank endon ("death");
	level.tank endon ("tankkilled");
	
	level.tank maps\_tiger::init();
	path = getVehicleNode(level.tank.target,"targetname");
	level.tank attachpath(path);
	level.tankguy1 thread anim_tankguy1();
	level.tankguy2 thread anim_tankguy2();
	thread maps\railyard_anim::tank_hatch();
	
	level.tankguy1 thread tankguy1_damage();
	level.tankguy2 thread tankguy2_damage();
	level.tank.health = (10000000);
	
	thread getintank_wait();
	
	level.tank thread splash_shield();
	
	level waittill ("StartTank");
	level.tank.health = (randomint(1000)+500);
	level.tank thread maps\_tankdrive::splash_shield();
	
	wait (5 + randomint(3));
	level.tank startpath();
	level.tank thread tank_paths();
	getent ("tankstop","targetname") waittill ("trigger");
	level.tank setspeed (0,5);
	
	getent ("tankturnaround","targetname") waittill ("trigger");
	level.tank resumespeed(3);
}

anim_tankguy1()
{
	level.tank endon ("tankkilled");
	self endon ("death");
	
	self allowedstances ("stand");
	self.health = (1000000);
	org = (level.tank gettagOrigin ("tag_hatch"));
	ang = (level.tank gettagAngles ("tag_hatch"));
	self teleport (org - (0,0,45));
	self linkto(level.tank, "tag_hatch");
	
	println("debug 0");
	level waittill ("GetInTank");
	println("debug 1");
	level notify ("INTANK");
	animscripts\shared::PutGunInHand("none");
	println("debug 2");
	self animscripted("animdone", org, ang, level.scr_anim["tankguy"]["getin"]);
	level notify ("close hatch");
	println("debug 3");
	self waittillmatch ("animdone","end");
	println("debug 4");
	self delete();
	level notify ("StartTank");
}

anim_tankguy2()
{
	level.tank endon ("tankkilled");
	self endon ("death");
	self allowedstances ("stand");
	self thread tankguy2_wait();
	self.health = (1000000);
	
	org = (level.tank gettagOrigin ("tag_hatch"));
	ang = (level.tank gettagAngles ("tag_hatch"));
	
	level waittill ("GetInTank");
	self unlink();
	self.health = (100);
	self animscripted("animdone", org, ang, level.scr_anim["tankguy2"]["jumpoff"]);
	self waittillmatch ("animdone","end");
	
}

tankguy2_wait()
{
	level.tank endon ("tankkilled");
	
	level endon ("GetInTank");
	org = (level.tank gettagOrigin ("tag_hatch"));
	ang = (level.tank gettagAngles ("tag_hatch"));
	dest = getStartOrigin(org, ang, level.scr_anim["tankguy2"]["idle"]);
	scr_org = spawn ("script_origin",dest);
	self teleport (dest);
	self linkto(scr_org);
	level waittill ("GetInTank");
	scr_org delete();
}

tank_paths()
{
	self endon ("death");
	while (1)
	{
		while (self getspeedmph() > 0)
		{
			self disconnectpaths();
			wait .25;
		}
		wait 1;
	}
}

/*
give_panzerfaust()
{
	while (1)
	{
		self waittill ("trigger");
		level.player giveweapon ("panzerfaust");
		level.player switchtoweapon("panzerfaust");
		
		if(level.player hasweapon("Panzerfaust"))
			maps\_spawner::waitframe();
	}
}
*/

waitframe()
{
	maps\_spawner::waitframe();
}