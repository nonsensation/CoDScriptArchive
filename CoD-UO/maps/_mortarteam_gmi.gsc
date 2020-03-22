#using_animtree("generic_human");
main()
{
	precacheModel("xmodel/scripted_granatwerfer_shell");
//    level._effect["mortar launch"] = loadfx ("fx/surfacehits/dawnville_mortar.efx");
    level._effect["mortar launch"] = loadfx ("fx/muzzleflashes/mortarflash.efx");
    

	level.scr_anim ["loader"]["idle"] 			= %mortar_loadguy_readyidle;
	level.scr_anim ["loader"]["wait idle"] 		= %mortar_loadguy_waitidle;
	level.scr_anim ["loader"]["wait twitch"] 	= %mortar_loadguy_waittwitch;
	level.scr_anim ["loader"]["pickup"] 		= %mortar_loadguy_pickup;
	level.scr_anim ["loader"]["fire"] 			= %mortar_loadguy_fire;

	level.scr_anim ["aimer"]["idle"] = %mortar_aimguy_readyidle;
	level.scr_anim ["aimer"]["wait idle"] = %mortar_aimguy_waitidle;
	level.scr_anim ["aimer"]["wait twitch"] = %mortar_aimguy_waittwitch;
	level.scr_anim ["aimer"]["pickup"] = %mortar_aimguy_pickup;
	level.scr_anim ["aimer"]["fire"] = %mortar_aimguy_fire;

	level.scr_notetrack["loader"][0]["notetrack"] = "attach shell = left";
	level.scr_notetrack["loader"][0]["attach model"] = "xmodel/scripted_granatwerfer_shell";
	level.scr_notetrack["loader"][0]["selftag"] = "TAG_WEAPON_LEFT";

	level.scr_notetrack["loader"][1]["notetrack"] = "detach shell = left";
	level.scr_notetrack["loader"][1]["detach model"] = "xmodel/scripted_granatwerfer_shell";
	level.scr_notetrack["loader"][1]["selftag"] = "TAG_WEAPON_LEFT";

	level.scr_notetrack["loader"][2]["notetrack"] = "fire";
	level.scr_notetrack["loader"][2]["sound"] = "mortar_launch";

	level.scr_notetrack["loader"][3]["notetrack"] = "fire";
	level.scr_notetrack["loader"][3]["effect"] = "mortar launch";
	level.scr_notetrack["loader"][3]["selftag"] = "TAG_WEAPON_LEFT";


//	level.scr_notetrack["loader"][3]["notetrack"] = "detach shell = left";
//	level.scr_notetrack["loader"][3]["sound"] = "mortar_load";

	
	maps\_utility_gmi::array_levelthread (getentarray ("mortar team","targetname"), ::mortar_think);
	maps\_utility_gmi::array_levelthread (getentarray ("mortar drone","targetname"), ::mortar_drone);
}

anim_loop ( guy, anime, tag, ender, node, tag_entity )
{
	maps\_anim_gmi::anim_loop ( guy, anime, tag, ender, node, tag_entity );
}

anim_single (guy, anime, tag, node, tag_entity)
{
	maps\_anim_gmi::anim_single (guy, anime, tag, node, tag_entity);
}

anim_reach (guy, anime, tag, node, tag_entity)
{
	maps\_anim_gmi::anim_reach (guy, anime, tag, node, tag_entity);
}

mortar_trigger ( trigger, node )
{
	println ("SETTING UP MORTAR TRIGGER");
	trigger waittill ("trigger");
	println ("TRIGGERED MORTAR TEAM");
	node notify ("start");
	trigger delete();
}

// Triggers targetted by the spawners will turn off the whole thing
mortar_stopper_trigger ( trigger, spawn )
{
	spawn endon ("death");
	trigger waittill ("trigger");
	trigger delete();
	spawn notify ("triggered to stop");
}

mortar_spawner_think (spawner, ent)
{
	spawner waittill ("spawner activated");
	println ("^cmortar: Spawned guy");
	if (isalive (spawner.spawned))
		spawner.spawned waittill ("death");
	
	ent notify ("spawner finished");
}

mortar_level_notify (node, spawners )
{
	ent = spawnstruct();
	maps\_utility_gmi::array_levelthread (spawners, ::mortar_spawner_think, ent);
	for (i=0;i<spawners.size;i++)
		ent waittill ("spawner finished");
		
	mortar_level_notify_death (node);
}		

mortar_level_notify_death (node)
{
	newMortarTeams = [];
	
	for (i=0;i<level.mortar_team_position.size;i++)
	{
		if (level.mortar_team_position[i] == node.origin)
			continue;
			
		newMortarTeams[newMortarTeams.size] = level.mortar_team_position[i];
	}
	
	level.mortar_team_position = newMortarTeams;
	
	level notify ("Mortar Team Dispatched");
}

makeMortarsStop (node)
{
	self waittill ("triggered to stop");
	level.stoppedmortarOrigin = node.origin;
	level notify ("mortar teams got off mortar");
}

mortar_think ( node )
{
	targets = getentarray (node.target,"targetname");
	spawners = [];
	
	trigger = false;
	for (i=0;i<targets.size;i++)
	{
		if (targets[i].classname == "trigger_multiple")
		{
			level thread mortar_trigger (targets[i], node);
			trigger = true;
		}
		else
			spawners[spawners.size] = targets[i];
	}
	
	if (spawners.size != 2)
		maps\_utility_gmi::error ("You need 2 spawners connected to Mortar Teams, origin: " + node.origin);
		
	if (!isdefined (level.mortar_team_position))
		level.mortar_team_position[0] = node.origin;
	else
		level.mortar_team_position[level.mortar_team_position.size] = node.origin;

	thread mortar_level_notify( node, spawners);
	println ("^cmortar:mortar team waitin for trigger!");
	
	if (trigger)
		node waittill ("start");
	println ("mortar team goes!");
	
	guy = [];
	spawn = [];
	for (i=0;i<spawners.size;i++)
	{
		if (!i)
			animname = "loader";
		else
			animname = "aimer";
			
//		spawners[i].origin = getStartOrigin (node.origin + (0,0,150), node.angles, level.scr_anim[animname]["idle"]);
		spawners[i].count = 1;
		if (level.script == "credits")
			spawn[animname] = spawners[i] stalingradspawn();
		else
			spawn[animname] = spawners[i] dospawn();
		println ("^cmortar: Spawning guy");
		
		if (isdefined (spawn[animname]))
			spawners[i].spawned = spawn[animname];
		else
		{
			spawners[i] notify ("spawner activated");
			println ("^cmortar: spawn did not spawn with animname ", animname);
			continue;
		}
		
		spawners[i] notify ("spawner activated");

		if (isdefined (spawn[animname].target))
			maps\_utility_gmi::array_levelthread (getentarray (spawn[animname].target,"targetname"), ::mortar_stopper_trigger, spawn[animname]);
		
		spawn[animname].allowDeath = true;
		spawn[animname].animname = animname;
		spawn[animname] endon ("triggered to stop");
		spawn[animname] thread makeMortarsStop(node);
		spawn[animname] endon ("death");
//		spawn[animname] animscripts\shared::putGunInHand ("none");
		guy[guy.size] = spawn[animname];
	}
	
	if (spawn.size != 2)
	{
		println ("^cmortar: mortar guys ", spawn.size);
		return;
	}

	println ("^cmortar: running for node");
	anim_reach (guy, "wait idle", undefined, node);
	println ("^cmortar: reached node");
			
	for (i=0;i<guy.size;i++)
		guy[i] animscripts\shared::putGunInHand ("none");
	
//	pickup = 0;
//	guy = undefined;
//	guy[0] = spawn["loader"];
	while (1)
	{
		anim_single (guy, "wait idle", undefined, node);
		anim_single (guy, "wait twitch", undefined, node);
		anim_single (guy, "wait idle", undefined, node);
//		pickup++;
//		println ("doing pickup for time: ", pickup);
		anim_single (guy, "pickup", undefined, node);
		anim_single (guy, "idle", undefined, node);
		anim_single (guy, "fire", undefined, node);
		wait 0.05;
	}	
}

mortar_drone(node)
{
	println("^1MADE IT TO MORTAR DRONE");
	mortar_drone_anims();
	
	guy = [];
	
	guy[0] = spawn("script_model", node.origin);
	guy[0].angles = (node.angles);
	guy[0] setmodel ("xmodel/character_airborne_winter");
	guy[0].animname = "drone_loader";
	guy[0] UseAnimTree(level.scr_animtree["drone_loader"]);
	
	if (!isdefined(level.scr_character["drone_mortar_team"]))
	{
		println("^1level.scr_character['drone_mortar_team'] is not defined");
		return;
	}
	guy[0] [[random_int(level.scr_character["drone_mortar_team"])]]();

	guy[1] = spawn("script_model", node.origin);
	guy[1].angles = (node.angles);
	guy[1] setmodel ("xmodel/character_airborne_winter");
	guy[1].animname = "drone_aimer";
	guy[1] UseAnimTree(level.scr_animtree["drone_aimer"]);
	
	guy[1] [[random_int(level.scr_character["drone_mortar_team"])]]();
	
	targets = getentarray (node.target,"targetname");
	
	trigger = false;
	for (i=0;i<targets.size;i++)
	{
		if (targets[i].classname == "trigger_multiple")
		{
			level thread mortar_trigger (targets[i], node);
			trigger = true;
		}

	}
	
	println ("^cmortar:mortar team waiting for trigger!");
	
	if (trigger)
		node waittill ("start");
	println ("mortar team goes!");
	
	while (1)
	{
		println ("^1 Made it to mortar team loop "+guy.size);
		for (i=randomintrange(0,2);i< 3;i++)
		{
			drone_single_anim (guy, "wait idle", undefined, node);
			drone_single_anim (guy, "wait twitch", undefined, node);
			drone_single_anim (guy, "wait idle", undefined, node);
		}

		drone_single_anim (guy, "pickup", undefined, node);
		drone_single_anim (guy, "idle", undefined, node);
		drone_single_anim (guy, "fire", undefined, node);
		wait 0.05;
	}	
	
	
	
}

#using_animtree("mortar_team");
mortar_drone_anims()
{
	level.scr_animtree["drone_loader"] 				= #animtree;
	level.scr_anim ["drone_loader"]["idle"] 			= %mortar_loadguy_readyidle;
	level.scr_anim ["drone_loader"]["wait idle"] 			= %mortar_loadguy_waitidle;
	level.scr_anim ["drone_loader"]["wait twitch"] 			= %mortar_loadguy_waittwitch;
	level.scr_anim ["drone_loader"]["pickup"] 			= %mortar_loadguy_pickup;
	level.scr_anim ["drone_loader"]["fire"] 			= %mortar_loadguy_fire;

	level.scr_animtree["drone_aimer"] 				= #animtree;
	level.scr_anim ["drone_aimer"]["idle"] 				= %mortar_aimguy_readyidle;
	level.scr_anim ["drone_aimer"]["wait idle"]			= %mortar_aimguy_waitidle;
	level.scr_anim ["drone_aimer"]["wait twitch"] 			= %mortar_aimguy_waittwitch;
	level.scr_anim ["drone_aimer"]["pickup"] 			= %mortar_aimguy_pickup;
	level.scr_anim ["drone_aimer"]["fire"] 				= %mortar_aimguy_fire;

	level.scr_notetrack["drone_loader"][0]["notetrack"] = "attach shell = left";
	level.scr_notetrack["drone_loader"][0]["attach model"] = "xmodel/scripted_granatwerfer_shell";
	level.scr_notetrack["drone_loader"][0]["selftag"] = "TAG_WEAPON_LEFT";

	level.scr_notetrack["drone_loader"][1]["notetrack"] = "detach shell = left";
	level.scr_notetrack["drone_loader"][1]["detach model"] = "xmodel/scripted_granatwerfer_shell";
	level.scr_notetrack["drone_loader"][1]["selftag"] = "TAG_WEAPON_LEFT";

	level.scr_notetrack["drone_loader"][2]["notetrack"] = "fire";
	level.scr_notetrack["drone_loader"][2]["sound"] = "mortar_launch";

	level.scr_notetrack["drone_loader"][3]["notetrack"] = "fire";
	level.scr_notetrack["drone_loader"][3]["effect"] = "mortar launch";
	level.scr_notetrack["drone_loader"][3]["selftag"] = "TAG_WEAPON_LEFT";
}

random_int (array)
{
	return array [randomint (array.size)];
}

drone_single_anim(guy, anime, tag, node, tag_entity)
{
	if (isdefined (tag))
	{
		if (isdefined (tag_entity))
		{
			org = tag_entity gettagOrigin (tag);
			angles = tag_entity gettagAngles (tag);
		}
		else
		{
			org = self gettagOrigin (tag);
			angles = self gettagAngles (tag);
		}
	}
	else
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

	scriptedAnimationIndex = -1;
	scriptedSoundIndex = -1;
	for (i=0;i<guy.size;i++)
	{
		doFacialanim = false;
		doAnimation = false;
		

		if ((isdefined (level.scr_anim[guy[i].animname])) &&
			(isdefined (level.scr_anim[guy[i].animname][anime])))
			doAnimation = true;
	
		if (doAnimation)
		{
			guy[i] animscripted( "single anim", org, angles, level.scr_anim[guy[i].animname][anime] );
			scriptedAnimationIndex = i;

			if (isdefined (level.scr_notetrack[guy[i].animname]))
				thread maps\_anim_gmi::notetrack_wait (guy[i], "single anim", tag_entity, anime);
			else
				guy[i] notify ("stop doing _anim notetracks");
		}		
	}
	
	if (scriptedAnimationIndex != -1)
	{
//		guy[scriptedAnimationIndex] endon ("death");	
		ent = spawnstruct();
		ent thread maps\_anim_gmi::anim_deathNotify(guy[scriptedAnimationIndex], anime);
		ent thread maps\_anim_gmi::anim_animationEndNotify(guy[scriptedAnimationIndex], anime);
		ent waittill (anime);
//		guy[scriptedAnimationIndex] waittillmatch ("single anim", "end");
	}
	else
	if (scriptedSoundIndex != -1)
	{
//		guy[scriptedSoundIndex] endon ("death");
		ent = spawnstruct();
		ent thread maps\_anim_gmi::anim_deathNotify(guy[scriptedSoundIndex], anime);
		ent thread maps\_anim_gmi::anim_dialogueEndNotify(guy[scriptedSoundIndex], anime);
		ent waittill (anime);
//		guy[scriptedSoundIndex] waittill ("single dialogue");
	}	
		
	self notify (anime);
}