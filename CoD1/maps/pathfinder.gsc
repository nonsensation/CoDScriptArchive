main()
{
	maps\_load::main();
	maps\_treadfx::main("night");
	maps\pathfinder_anim::main();
	maps\pathfinder_anim::props();
	maps\pathfinder_fx::main();
	maps\_truck::main();
	musicplay("datestamp");
	
	level.player.threatbias = -150; // A good threatbias #? Who knows!
//	array_thread (getentarray ("siren","targetname"), ::siren_sound);

	precacheItem("THOMPSON");
	precacheItem("COLT");
	character\foley::precache();
	character\Airborne3b_thompson::precache();
	character\Airborne_scripted_pathfinder::precache();
	precacheModel("xmodel/c47");
	precacheModel("xmodel/eureka_beacon");
	precacheModel("xmodel/chessgame_animrig");
	precacheModel("xmodel/holophane_lamp");
	precacheModel("xmodel/piss_sequence_gunpose");
	precacheModel("xmodel/chessgame_animnode");
	precacheModel("xmodel/chessgame_animrig");
	precacheModel("xmodel/parachute_flat_A");
	
	level.scr_sound ["incoming"] = "mortar_incoming5";

	level.ambient_track ["before battle"] = "ambient_pathfinder_quiet";
	level.ambient_track ["during battle"] = "ambient_pathfinder";
	thread maps\_utility::set_ambient("before battle");

	// flags
	level.flag["legbag"] = false;
	level.flag["flares set"] = false;
	level.flag["killed chain 500"] = false;
	level.flag["no more parachuters"] = false;
	level.flag["planes can be hit"] = false;
	level.flag["drop parachuters"] = false;
	level.flag["attack underway"] = false;

	// global variables
	level.followrange = -3;
	level.followrangeboost = 0;
	level.parachuters = 0;
	level.totalFriends = 0;
	setCullFog(0, 15000, .1, .1, .13, 0);
	level.campaign = "american";

//	Hint prints:
	level.hintPrint["press tab"]["string"] = &"SCRIPT_HINT_OBJECTIVEKEY";
	level.hintPrint["press tab"]["command"] = "+scores";
	level.hintPrint["follow compass"]["string"] = &"SCRIPT_HINT_OBJECTIVEONCOMPASS";
	level.hintPrint["cant enter"]["string"] = &"SCRIPT_HINT_CANT_OPEN_DOORS";

	level.hintPrint["press use"]["string"] = &"SCRIPT_HINT_FIRSTOBJECTIVE";
	level.hintPrint["press use"]["command"] = "+activate";

	level.hintPrint["use grenades"]["string"] = &"PATHFINDER_GRENADEHINT";
	level.hintPrint["use grenades"]["command"] = "weaponslot grenade";

//	Initial array_threading:  
	array_levelthread (getentarray ("delete","targetname"), ::delete_this);	
	array_levelthread (getentarray ("blocker","targetname"), ::hide_this);	

	thread ai_overrides();
	thread piss (getnode ("piss","targetname"));
	thread chess (getnode ("chess","targetname"));
	
	thread objectives();
	thread enemy_waves();
	thread airplanes_setup();
	thread plane_intro();
	thread attack_effects();
	thread explosive( getent ("explosive","targetname"));
	thread early_guy_trigger( getent ("intro house german","targetname"));
	thread early_guy (getent ("first house german","targetname"));
	
	// Makes 1 way ai wall pop in
	thread blocker_adder( getent ("blocker adder","targetname"));
	
	level thread end_level (getent ("end level","targetname"));
	level thread friendly_delete (getent ("friendly delete","targetname"));
//	level thread friendly_goal (getent ("friendly goal","targetname"));
	level thread kill_ai (getent ("kill ai","targetname"));
	level thread guy_opens_door (getent ("guy opens door","script_noteworthy"));
	level thread newFriends (getent ("new friend trigger","targetname"));
	
	level thread germanRadio (getent ("radio","targetname"));
	getent ("radio music","targetname") playloopsound ("radio_bruckner");

	// end of level player gets nabbed
	level thread ambush (getent ("ambush","targetname"));
	level thread stopFlames (getent ("stop flames","targetname"));
	parachute_player();
	array_levelthread (getentarray ("hint print","targetname"), ::hint_print);	
	array_thread (getentarray ("truck intro","targetname"), ::early_truck);
//	array_thread (getentarray ("truck intro","targetname"), ::early_truck_damage);
	array_levelthread(getentarray ("truck attack","targetname"), maps\chateau::german_truck);
	array_levelthread(getentarray ("follow boost","targetname"), ::followbooster);

	array_levelthread(getentarray ("trigger_multiple","classname"), ::preSpawnAlive);
	// German jumps out of truck, kicks open door
//	thread kick_door (getent ("kick door","targetname"));
	
//	wait ();

//	misc
	level thread no_prone (getent ("no prone","targetname"));		
}

blocker_adder ( trigger )
{
	blocker = getent (trigger.target,"targetname");
	blocker connectpaths();
	blocker hide();
	blocker notsolid();
	trigger waittill ("trigger");
	blocker solid();
	blocker disconnectpaths();
	trigger delete();
}

followbooster ( trigger )
{
	trigger waittill ("trigger");
	trigger delete();	
	ai = getaiarray ("allies");
	for (i=0;i<ai.size;i++)
	{
		ai[i].followmin++;
		ai[i].followmax++;
	}
	
	level.followrangeboost++;
}

delete_this (ent)
{
	ent delete();
}

hide_this (ent)
{
	ent hide();
}

no_prone ( trigger )
{
	while (1)
	{
		trigger waittill ("trigger");
		level.player allowProne (false);
		level.player allowCrouch (false);
		while (level.player istouching (trigger))
			wait (0.05);
			
		level.player allowProne (true);
		level.player allowCrouch (true);
	}
}

ai_overrides()
{
	spawners = getspawnerarray();
	for (i=0;i<spawners.size;i++)
		spawners[i] thread spawner_overrides();
		
	ai = getaiarray();
	for (i=0;i<ai.size;i++)
	{
		ai[i].grenadeAmmo = 1;
		ai[i].bravery = 500000;
		ai[i].suppressionwait = 0;
	}
}

early_guy_trigger ( trigger )
{
	trigger waittill ("trigger");
	level notify ("early guy alert!");
	trigger delete();
}

early_guy ( spawner )
{
	// No early guy
	return;
	level waittill ("early guy alert!");
	wait (0.9);
	house_door = getent ("intro house door","targetname");
	house_door connectpaths();
	house_door rotateyaw (170, 0.8);
	house_door playsound ("wood_door_kick");
	
	spawner dospawn();
}

// Special backyard explosion
explosive (trigger)
{
	trigger waittill ("trigger");
	presound(7);
	thread maps\_utility::exploder(7);
}

germanRadio (radio)
{
	radio endon ("stop radio sound");
	while (1)
	{
		radio playloopsound ("german_radio_pathfinder", "sounddone");
		radio waittill ("sounddone");
	}
}

guy_opens_door ( trigger )
{
	trigger waittill ("trigger");
//	maps\_utility::autosave(2);
	spawner = getent ("doorguy","targetname");
	spawner.count = 1;
	while (!isdefined (spawn))
	{
		wait (1.5);
		spawn = spawner dospawn();
	}
	
	spawn endon ("death");
	spawn.health = 50000;
	spawn.animname = "generic";
	spawn.allowDeath = false;
	node = getnode (spawn.target,"targetname");
	if (randomint (100) > 50)
		spawn thread anim_single_solo (spawn, "kick door 1", undefined, node);
	else
		spawn thread anim_single_solo (spawn, "kick door 2", undefined, node);

	spawn waittillmatch ("single anim", "kick");
	house_door = getent ("house door", "targetname");
	house_door connectpaths();
	house_door rotateyaw (-170, 0.8);
	house_door playsound ("wood_door_kick");
	wait (0.85);
	house_door playsound ("wood_door_kick");
	house_door rotateyaw (30, 0.5, 0, 0.5);
	wait (0.5);
	getent ("player stop clip","targetname") delete();
	
	if (isdefined (node.target))
		node = getnode (node.target,"targetname");

	spawn.health = 100;	
	spawn setgoalnode (node);
	if (isdefined (node.radius))
		spawn.goalradius = node.radius;
}

// Ambush and Foley
ambush ( trigger )
{
	spawner = getent (trigger.target,"targetname");
	thread ambushSpawner(spawner);
	trigger waittill ("trigger");

	thread foleyThink();	
	trigger delete();
}

stopFlames ( trigger )
{
	trigger waittill ("trigger");
	level notify ("stop fx" + "stop flames");
}

foleyThink ()
{
	foleySpawner = getent ("foley","targetname");
	foley = foleySpawner dospawn();
	if (maps\_utility::spawn_failed(foley))
		return;
		
	foley thread maps\_utility::magic_bullet_shield();
	foley character\_utility::new();
	foley character\foley::main();
	foley.animname = "foley";
	
	trigger = getent ("foley trigger","targetname");
	trigger waittill ("trigger");
	node = getnode (foley.target,"targetname");
	anim_single_solo (foley, "get moving", undefined, node);
	remover = getnode ("remover","targetname");
	foley setgoalnode (remover);
	foley.goalradius = 24;
	foley waittill ("goal");
	foley delete();
}

ambushSpawner (spawner)
{
	spawner waittill ("spawned",spawn);
	if (maps\_utility::spawn_failed(spawn))
		return;
	spawn setgoalentity (level.player);
	spawn.goalradius = 64;
	spawn.health = 50;
}


spawner_overrides()
{
	while (1)
	{
		self waittill ("spawned", spawned);
		wait (0.05);
		if (issentient (spawned))
		{
			spawned.grenadeAmmo = 1;
			spawned.bravery = 500000;
			spawned.suppressionwait = 0;
		}
	}
}

hint_print ( trigger )
{
	note = trigger.script_noteworthy;
	if ((note == "follow compass") || (note == "press tab"))
		leaveTrigger = true;
	else
		leaveTrigger = false;
		
	trigger waittill ("trigger");
	if (leaveTrigger)
	{
		while (level.player istouching (trigger))
			wait (1);
	}
	
	if(isdefined(level.hintPrint[note]["command"]))
		maps\_utility::keyHintPrint(level.hintPrint[note]["string"], getKeyBinding(level.hintPrint[note]["command"]));
	else
		iprintlnbold (level.hintPrint[note]["string"]);

	trigger delete();
}

end_level ( trigger )
{
	trigger waittill ("trigger");
	objective_state(4, "done");
	missionSuccess ("burnville", true);
}

friendly_delete (trigger)
{
	while (1)
	{
		trigger waittill ("trigger", other);
		if (!isalive (other))
			continue;
			
		if (!isSentient (other))
			continue;
			
		other delete();
	}
}

friendly_goal (trigger)
{
	node = getnode (trigger.target,"targetname");

	while (1)
	{
		trigger waittill ("trigger");
		
		ai = getaiarray ("allies");
		for (i=0;i<ai.size;i++)
		{
			ai[i] setgoalnode (node);
			ai[i].goalradius = 512;
		}
		ai = undefined;
	}
}

newFriends ( trigger )
{
	println ("^3 setting up trigger..");
	trigger waittill ("trigger");
//	maps\_utility::error ("no more friends");
	flag_set ("no more parachuters");
	spawner = getent ("new friend","targetname");
	while (1)
	{
		println ("^2 waiting for parachute death");
		level waittill ("parachuter died");
		while (level.totalFriends < 7)
		{
			println ("^2 spawning parachute guy");
			spawner.count = 1;
			spawn = spawner stalingradspawn();
			if (maps\_utility::spawn_failed(spawn))
				continue;
				
			println ("^2 parachute guy spawned");
			spawn setgoalentity (level.player);
			level thread newFriendThink(spawn);
			wait (3 + randomfloat (2));
		}
	}
}

newFriendThink (spawn)
{
	level.totalFriends++;
	spawn waittill ("death");
	level.totalFriends--;
	level notify ("parachuter died");
}

airplanes_wait ()
{
	level waittill ("start planes");
	thread airplanes();
}

attack_effects ()
{
	effects = getentarray ("attack effect","targetname");
	for (i=0;i<effects.size;i++)
		effects[i] hide();

	thread airplanes_wait();

//	flag_wait ("flares set");
	level waittill ("start attack effects");
	thread maps\pathfinder_fx::fieldBattle();
//	thread ambient();
	for (i=0;i<effects.size;i++)
	{
		ent = random(level.effect_struct[effects[i].script_fxid]);
		maps\_fx::gunfireLoopfx (effects[i].script_fxid, effects[i].origin, ent.num1, ent.num2, ent.num3, ent.num4, ent.num5, ent.num6);
		wait (2 + randomfloat (2));
	}
}


airplanes_setup ()
{
	airplanes = getentarray ("airplane","targetname");
	for (i=0;i<airplanes.size;i++)
		airplanes[i] hide();
}

airplanes ()
{
	thread real_airplanes();
	airplanes = getentarray ("airplane","targetname");

	while (1)
	{
		for (i=0;i<airplanes.size;i++)
		{
			maps\_fx::OneShotfx(airplanes[i].script_fxid, airplanes[i].origin, 0);
			wait (20);
		}
	}
}

getvehiclenodeScriptNoteworthy (msg,  note)
{
	nodes = getvehiclenodearray (msg,"targetname");
	for (i=0;i<nodes.size;i++)
	{
		if (!isdefined (nodes[i].script_noteworthy))
			continue;
			
		if (nodes[i].script_noteworthy != note)
			continue;
		
		return nodes[i];
	}
}

real_airplanes ()
{
	flag_wait ("drop parachuters");
	realplanes = getvehiclenodearray ("airplane","targetname");
					
	for (i=0;i<realplanes.size;i++)
		realplanes[i].isInUse = false;
					
	firstplane = getvehiclenodeScriptNoteworthy ("airplane", "first plane");
	thread realplane(firstplane);
	wait (5);
		
	for (i=0;i<realplanes.size;i++)
	{
		if (realplanes[i].script_plane != 100)
			continue;
		thread realplane(realplanes[i]);
		wait (5);
	}

	while (1)
	{
		if ((!flag("no more parachuters")) && (level.parachuters < 6))
		{
			thread realplane(firstplane);
			wait (5);
		}
		
		for (i=0;i<realplanes.size;i++)
		{
//			if (realplanes[i].script_plane != 100)
//				continue;
			thread realplane(realplanes[i]);
			wait (5);
		}
		realplanes = maps\_utility::array_randomize(realplanes);
	}
}

realplane_hitbad ()
{
	if (!isdefined (level.lastBadHit))
		level.lastBadHit = gettime() + 5000;
	self endon ("hit bad, going down");
	while (1)
	{
		self waittill ("plane is hit");
		if (!flag ("planes can be hit"))
			continue;
			
		if (gettime() > level.lastBadHit)
		{
			level.lastBadHit = gettime() + 8000 + randomint (4000);
			self thread realplane_hit();
			self notify ("hit bad, going down");
		}
	}
}

realplane_drop_parachute_guy (path)
{
//	self endon ("hit bad, going down");
	
	self thread realplane_hitbad();
	while (1)
	{
		self setWaitNode (path);
		self waittill ("reached_wait_node");
		if (!isdefined (path.target))
			return;

		path = getvehiclenode (path.target, "targetname");
		
		if (!isdefined (path.script_noteworthy))
			continue;
			
		if (path.script_noteworthy == "parachute_fake")
		{
//			println ("^cPARACHUTE FAKE!");
			self thread realplane_drops_guy_fake(path.script_parachutegroup);
			continue;
		}

		if (flag("no more parachuters"))
			return;

		if (path.script_noteworthy != "parachute")
			continue;
		
		if (level.parachuters >= 8) // 4
			continue;

			
		self thread realplane_drops_guy(path.script_parachutegroup);
	}
}

realplane_drops_guy_fake (num)
{
//	self endon ("hit bad, going down");
	potentialPaths = getvehiclenodeArray ("parachute drop","targetname");
	paths = [];
	for (i=0;i<potentialPaths.size;i++)
	{
		if (potentialPaths[i].script_parachutegroup != num)
			continue;
			
		paths[paths.size] = potentialPaths[i];
	}
			
	for (i=0;i<paths.size;i++)
		level thread realplane_parachute_fake_think (paths[i]);
}

realplane_drops_guy (num)
{
//	self endon ("hit bad, going down");
	potentialPaths = getvehiclenodeArray ("parachute drop","targetname");
	paths = [];
	for (i=0;i<potentialPaths.size;i++)
	{
		if (potentialPaths[i].script_parachutegroup != num)
			continue;
			
		paths[paths.size] = potentialPaths[i];
	}
			
	for (i=0;i<paths.size;i++)
		level thread realplane_parachute_think (paths[i]);
}

realplane (path)
{
	if (path.isInUse)
		return;
	path.isInUse = true;
	level.antiair_tracers = getentarray ("antiair tracer","targetname");
	plane = spawnVehicle( "xmodel/c47", "plane", "C47", (0,0,0), (0,0,0) );
//	println ("making a plane");
	plane attachPath( path );
	plane playsound ("c47_fly_by");

	plane startPath();
	plane thread plane_animation();
	if (flag("attack underway"))
		plane thread realplane_lightup();
		
	plane thread realplane_drop_parachute_guy(path);
	plane waittill ("reached_end_node");
	plane delete();
	path.isInUse = false;
	
//	println ("deleted a plane");
}

plane_animation ()
{
	self.animname = "c47";
	self useAnimTree (level.scr_animtree[self.animname]);
	thread plane_idle();
	thread plane_hit_left();
	thread plane_hit_right();
}

plane_hit_left ()
{
	self endon ("hit right");
	self waittill ("hit left");
	self notify ("plane is hit");
	thread plane_hit_left_action();
}
	
plane_hit_left_action ()
{
//	self setflaggedAnimKnobAll("animdone", level.scr_anim[self.animname]["hit below"], level.scr_anim[self.animname]["root"]);
//	self waittill ("animdone");
	thread plane_idle();
	thread plane_hit_left();
	thread plane_hit_right();
}

plane_hit_right ()
{
	self endon ("hit left");
	self waittill ("hit right");
	self notify ("plane is hit");
	self thread plane_hit_right_action();
}

plane_hit_right_action ()
{
//	self setflaggedAnimKnobAll("animdone", level.scr_anim[self.animname]["hit above"], level.scr_anim[self.animname]["root"]);
//	self waittill ("animdone");
	thread plane_idle();
	thread plane_hit_left();
	thread plane_hit_right();
}

plane_idle ()
{
	self endon ("hit left");
	self endon ("hit right");
	guy[0] = self;
	while (1)
	{
		idleanim = maps\_anim::anim_weight (guy, "idle");
		self setflaggedAnimKnobAll("animdone", level.scr_anim[self.animname]["idle"][idleanim], level.scr_anim[self.animname]["root"]);
		self waittill ("animdone");
	}
}

realplane_hit ()
{
	while (1)
	{
		playfxOnTag ( level._effect["flameout"], self, "tag_door_left" );
		wait (randomfloat (0.15));
		playfxOnTag ( level._effect["flameout"], self, "tag_door_left" );
		wait (randomfloat (0.15));
		playfxOnTag ( level._effect["fireheavysmoke"], self, "tag_door_left" );
		wait (randomfloat (0.15));
	}
}


antiair_tracer_gen (overall_offset, hit)
{
	offset = randomvec (800) + overall_offset;

	launcher = maps\_utility::getClosest ( self.origin, level.antiair_tracers );
	forward = anglesToForward (self.angles);
	dist = distance (launcher.origin, self.origin + offset);
	forward = maps\_utility::vectorScale (forward, dist * 0.3);
	target = self.origin + forward + offset;
	dist = distance (launcher.origin, target);
	
	destination_angles = vectornormalize (target - launcher.origin);
	playfx ( level._effect["antiair single tracer"], launcher.origin, destination_angles);

	wait (dist * 0.00015);
	
//	self notify ("hit " + hit);
	playfxOnTag ( level._effect["light"], self, "tag_origin" );
//	playfx ( level._effect["flak solo"], self.origin + offset);
}

antiair_flak_gen (overall_offset, hit)
{
	offset = randomvec (800) + overall_offset;
	self notify ("hit " + hit);
	playfxOnTag ( level._effect["light"], self, "tag_origin" );
	playfx ( level._effect["flak solo"], self.origin + offset);
}

randomvec(num)
{
	return (randomfloat(num) - num*0.5, randomfloat(num) - num*0.5,randomfloat(num) - num*0.5);
}

antiair_flak (direction, directionString)
{
	offset = randomint (3) + 1; // 3? 2?
	wait (randomfloat(3) + 1);	
	range = 500;
	forward = anglesToForward (self.angles);
	forward = maps\_utility::vectorScale (forward, range);
	right = anglesToRight (self.angles);
	right = maps\_utility::vectorScale (right, range);
	
	back = anglesToForward (self.angles);
	back = maps\_utility::vectorScale (back, 0 - range);
	left = anglesToRight (self.angles);
	left = maps\_utility::vectorScale (left, 0 - range);
	
	for (i=0;i<10;i++)
	{
		if (offset == 1)
			thread antiair_flak_gen(right, "right");
		if (offset == 2)
			thread antiair_flak_gen(left, "left");
		if (offset == 3)
			thread antiair_flak_gen(back, "right");
		if (offset == 4)
			thread antiair_flak_gen(forward, "left");
			
		wait (randomfloat(0.2));
	}
}

realplane_lightup()
{
	range = 2500;
	while (1)
	{
		
		range = 500;
		forward = anglesToForward (self.angles);
		forward = maps\_utility::vectorScale (forward, range);
		right = anglesToRight (self.angles);
		right = maps\_utility::vectorScale (right, range);
		
		back = anglesToForward (self.angles);
		back = maps\_utility::vectorScale (back, 0 - range);
		left = anglesToRight (self.angles);
		left = maps\_utility::vectorScale (left, 0 - range);
		
		offset = randomint (3) + 1; // 3? 2?
		
		if (offset == 1)
			thread antiair_flak(right, "right");
		if (offset == 2)
			thread antiair_flak(left, "left");
		if (offset == 3)
			thread antiair_flak(back, "right");
		if (offset == 4)
			thread antiair_flak(forward, "left");

		for (i=0;i<10;i++)
		{
//			offset = 1;
			if (offset == 1)
				thread antiair_tracer_gen(right, "right");
			if (offset == 2)
				thread antiair_tracer_gen(left, "left");
			if (offset == 3)
				thread antiair_tracer_gen(back, "right");
			if (offset == 4)
				thread antiair_tracer_gen(forward, "left");
				
			wait (randomfloat(0.2));
/*			
			playfxOnTag ( level._effect["light"], self, "tag_origin" );
	
			playfx ( level._effect["flak solo"], self.origin + forward + right + (0, 0,  randomint (170) + 65), randomvec());
			wait (randomfloat(0.2));
*/			
		}
		wait (randomfloat(3) + 1);
	}
}

#using_animtree("generic_human");
parachute_player ()
{
	level.player allowProne (false);
	level.player allowCrouch (false);
	spawner = getent ("parachute friend","targetname");
	node = getnode (spawner.target,"targetname");
	parachute = spawn_parachute();
	
	parachute.origin = getStartOrigin (node.origin, node.angles, parachute.player_anim);
	parachute.angles = getStartAngles (node.origin, node.angles, parachute.player_anim);
	level.player linkto (parachute,"TAG_player",(0,0,0),(0,0,0));

	level waittill ("finished final intro screen fadein");
	wait (0.5); //2

	
	parachute animscripted("scriptedanimdone", node.origin, node.angles, parachute.player_anim);
	
	level.player thread maps\_utility::playSoundOnTag("parachute_land_player");

	parachute waittillmatch ("scriptedanimdone", "detach player");
	level.player giveWeapon("m1carbine");
	level.player giveWeapon("thompson");
	level.player giveWeapon("colt");
	level.player giveWeapon("fraggrenade");
	level.player switchToWeapon("m1carbine");
	
	level.player unlink();
	level.player allowProne (true);
	level.player allowCrouch (true);
}

tag_effect(parachute)
{
	while (1)
	{
		playfxOnTag ( level._effect ["medfire"], parachute, "nob01" );	
		wait (0.1);
	}
}

parachuteReplacement()
{
//	self waittill ("finished anim");
	self.parachute waittillmatch ("single anim","swap parachute");
	println ("^5 SWAP PARACHUTES");
	if (isdefined (self.replacement))
	{
		self.parachute moveto (self.parachute.origin + (0,0,-500), 5, 3, 2);
		wait (5);
		self.parachute delete();
		return;
	}
	self.replacement = true;
	model = spawn ("script_model",(0,0,-100));
	model setmodel ("xmodel/parachute_flat_A");
	model.origin = self.parachute.origin + (0,0,-150);
	model.angles = self.parachute.angles;
	model moveto (model.origin + (0,0,150), 0.5, 0.25, 0.25);
//	self.parachute delete();
	wait (0.75);
//	wait (5);
//	model delete();
//	return;
	
	self.parachute moveto (self.parachute.origin + (0,0,-500), 5, 3, 2);
	wait (5);
	self.parachute delete();
//	wait (5);
//	model delete();
}

realplane_guy_drops (path, animname)
{
	if (isdefined (path.script_delay))
		wait (path.script_delay);
	spawner = getent (path.target,"targetname");

//	println ("Waited: ", path.script_delay);
	ent = spawnstruct();
	org = spawn ("script_origin",(0,0,0));
	org.origin = path.origin;
	while (isdefined (path.target))
		path = getvehiclenode (path.target,"targetname");
	org.angles = path.angles;

	endPos = path.origin + (0,0,-24);
	endAng = path.angles;

	parachute = spawn_parachute();
	parachute.origin = org.origin;
	parachute.origin = getStartOrigin (org.origin, org.angles, parachute.landing_anim);
	parachute.angles = getStartAngles (org.origin, org.angles, parachute.landing_anim);
	parachute linkto (org);
		
	spawner.origin = getStartOrigin (org.origin, org.angles, parachute.landing_anim);
	spawner.angles = getStartAngles (org.origin, org.angles, parachute.landing_anim);
	spawner.count = 1;
	
	if (!isdefined (animname))
	{
		spawn = spawner stalingradspawn();
		spawn.animname = "paraguy";
		spawn.health = 500000;
		if (maps\_utility::spawn_failed(spawn))
		{
			ent.good2go = false;
			parachute delete();
			org delete();
			return ent;
		}
		path.parachute = parachute;
		path thread parachuteReplacement();
	}
	else
	{
		spawn = spawn ("script_model",(0,0,0));
		spawn.animname = animname;
		spawn assignanimtree();
		spawn character\_utility::new();
		spawn character\Airborne3b_thompson::main();
		spawn.origin = spawner.origin;
		spawn.angles = spawner.angles;
	}

	spawn linkto (org);
	
	guy[0] = spawn;
	guy[1] = parachute;
	
	falltime = 10;
	org moveto (endPos, falltime);
	org rotateto (endAng, falltime);
	org thread realplane_guy_animations (guy);
	spawn thread maps\_utility::playSoundOnTag("parachute_land_friendly");

	wait (falltime);
	
	org notify ("stop idle");
	org anim_single (guy, "hit", undefined);
	path notify ("finished anim");
	parachute unlink();
	spawn unlink();
	org delete();
	
	ent.spawn = spawn;
	ent.parachute = parachute;
	ent.good2go = true;
	return ent;
}

realplane_guy_animations (guy)
{
	self anim_single (guy, "jump", undefined);
	self thread anim_loop ( guy, "jump idle", undefined, "stop idle");
}

realplane_parachute_fake_think ( path )
{
	ent = realplane_guy_drops(path, "paraguy fake");
	if (ent.good2go)
	{
		ent.spawn delete();
		ent.parachute delete();
	}
}

realplane_parachute_think ( path )
{
	if (level.parachuters >= 7)
		return;
		
	level.totalFriends++;
	level.parachuters++;
	println ("dropping guy ", level.totalFriends, " ", level.parachuters);
	ent = realplane_guy_drops(path);
	level notify ("touch down");
	spawn = ent.spawn;
	spawn.health = 100;
	spawn setgoalentity (level.player);

	localboost = 0;		
	level.followrange++;
	if (level.followrange >= -3)
	{
		level.followrange = -5;
		localboost = 5;
	}
		
	spawn.followmin = level.followrange + level.followrangeboost + localboost;
	spawn.followmax = level.followrange + level.followrangeboost + 4 + localboost;
		
	println ("^2 real parachuter waiting for death");
	level thread spawnDeath(spawn);
//	level thread spawnDeath(spawn);
}

spawnDeath (spawn)
{
	spawn waittill ("death");
	level.totalFriends--;
	level.parachuters--;
	level notify ("parachuter died");
	println ("^2 notified real parachuter death");
}

spawnDeath2 (spawn)
{
	while (isalive (spawn))
		wait (0.05);
	println ("^2 SPAWN DIED!");
}

parachute_think ( num, optionalThread )
{
	level.totalFriends++;
	level.parachuters++;
	wait (randomfloat (num));
	
	node = getnode (self.target,"targetname");
//	destination = getnode ("destination","targetname");
	
	parachute = spawn_parachute();
	
	self.origin = getStartOrigin (node.origin, node.angles, %airborne_landing_roll);
	self.angles = getStartAngles (node.origin, node.angles, %airborne_landing_roll);
	parachute.origin = getStartOrigin (node.origin, node.angles, parachute.landing_anim);
	parachute.angles = getStartAngles (node.origin, node.angles, parachute.landing_anim);

	if (randomint (100) > 50)
		landing = "landing 1";
	else
		landing = "landing 2";
	
	self.count = 1;
	spawn = self stalingradspawn();
	if (maps\_utility::spawn_failed(spawn))
		return;
		
	spawn endon ("death");
	spawn.animname = "paraguy";
	spawn.health = 500000;
	guy[0] = spawn;
	guy[1] = parachute;
	anim_single (guy, landing, undefined, node);
	
//	spawn animscripted("scriptedanimdone", node.origin, node.angles, level.scr_anim["paraguy"]["landing 1"]);
//	parachute animscripted("scriptedanimdone", node.origin, node.angles, parachute.landing_anim);
//	spawn waittill ("scriptedanimdone");
	spawn.health = 100;
	
	if (isdefined (optionalThread))
		spawn thread [[optionalThread]]();
	else
		spawn setgoalentity (level.player);
		
	spawn.followmin = randomint (5);
	spawn.followmax = randomint (5) + 5;
		
	spawn waittill ("death");
	level.totalFriends--;
	level.parachuters--;
	level notify ("parachuter died");	
	println ("^2 notified parachuter death");
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

flare_setup ()
{
	self hide();
}

beacon_think ( beacon )
{
	beacon hide();
	trigger = getent (beacon.target,"targetname");
	trigger maps\_utility::triggerOff();
	binding = getKeyBinding("+activate");
	trigger setHintString(&"PATHFINDER_BEACON"); // + binding
	
	flag_wait("legbag");
	beacon show();
	trigger maps\_utility::triggerOn();
	trigger waittill ("trigger");
	trigger delete();
	flag_set ("flares set");

	level.parachuters = 0;
	level.totalFriends = 0;
	beacon setmodel ("xmodel/eureka_beacon");
	beacon playsound ("Beacon_plant");
	wait (1.25);
	maps\_fx::loopSound("Beacon_hum", beacon.origin);
}

flare_think ()
{
	flare = self;
	flares = 6;
	flareTriggers = getentarray ("flare triggers","script_noteworthy");
	for (i=0;i<flareTriggers.size;i++)
		flareTriggers[i] maps\_utility::triggerOff();

	while (1)
	{
		targets = getentarray (flare.target,"targetname");
		trigger = undefined;
		model = undefined;
		
		for (i=0;i<targets.size;i++)
		{
			if (targets[i].classname == "trigger_use")
				trigger = targets[i];
			else
				model = targets[i];
		}
		
		flare hide();
		if (!isdefined (model))
			return;
			
		flare = model;
		flare hide();
	}
}

assignanimtree()
{
	self UseAnimTree(level.scr_animtree[self.animname]);
}


hanging_treeguy ()
{
	node = getnode ("treenode","targetname");
	spawn = spawn ("script_model",(0,0,0));
	spawn.origin = node.origin;
	spawn.animname = "tree_guy";
	spawn AssignAnimTree();
//	spawn setmodel ("xmodel/airborne");
	
	spawn character\_utility::new();
//	spawn character\Airborne3b_thompson::main();
	spawn character\Airborne_scripted_pathfinder::main();

	
	parachute = spawn ("script_model",(0,0,0));
	parachute.origin = node.origin;
	parachute.animname = "parachute";
	parachute setmodel ("xmodel/parachute_animrig_treeguy");
	parachute AssignAnimTree();
	
	clip = getent ("hanging clip","targetname");
	clip linkto (spawn,"tag_origin",(0,0,0),(0,0,0));
	
	guy[0] = spawn;
	guy[1] = parachute;
	thread anim_loop ( guy, "idle", undefined, undefined, node);
}

objectives ()
{
	thread hanging_treeguy();
	thread beacon_think( getent ("beacon","targetname"));
	getent ("flare","targetname") thread flare_think();
	
	legbag = getEnt("legbag","targetname");
	array_thread (getentarray ("flare","script_noteworthy"), ::flare_setup);
	array_thread (getentarray ("beacon","script_noteworthy"), ::flare_setup);
	
 	objective_add(0, "active", &"PATHFINDER_OBJ0",legbag.origin);
	objective_current(0);
 	
	trigger = getent ("press use", "script_noteworthy");
	trigger waittill ("trigger");
	objective_state(0, "done");
 	
 	objective_add(1, "active", &"PATHFINDER_OBJ1",legbag.origin);
	objective_current(1);

	trigger = getent ("legbag_trigger", "targetname");
	trigger setHintString(&"PATHFINDER_LEGBAG"); // + binding
	trigger waittill ("trigger");
	flag_set("legbag");
	org = legbag.origin;
	legbag delete();
	trigger delete();
	maps\_utility::keyHintPrint(&"PATHFINDER_OBJECTIVEHINT", getKeyBinding("+scores"));
	objective_state(1, "done");
 	objective_add(2, "active", &"PATHFINDER_OBJ2", getent ("beacon","targetname").origin);
	objective_current(2);
	maps\_utility::playSoundinSpace ("PU_leg_bag", org);
	
	flag_wait ("flares set");
	objective_state(2, "done");
 	objective_add(3, "active", &"PATHFINDER_OBJ3", (-1664, 5440, 32));
	objective_current(3);
 	objective_add(4, "active", &"PATHFINDER_OBJ4", (-3032, 10288, -20));
//	getent ("flare","targetname") thread flare_think();
}

deleter ()
{
	self endon ("death");
	println ("waiting for soundplayer deletion");
	level waittill ("chess interrupted");
	println ("deleting soundplayer");
//	self stopsound();
	self delete();
}

playSoundinSpace (alias, origin)
{
	org = spawn ("script_origin",(0,0,1));
	org thread deleter();
	org.origin = origin;
	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}

stopChessSounds ()
{
	self endon ("death");
	self waittill ("fight");
	if (self.chessSounds)
		self animscripts\face::SaySpecificDialogue (undefined, "german_enemy_sighted", 1.0);
}


chessSounds (guy1, guy2)
{
	guy1 endon ("death");
	guy2 endon ("death");
	guy1 endon ("fight");
	guy2 endon ("fight");
	
	guy1 thread stopChessSounds();
	guy2 thread stopChessSounds();
	guy1.chessSounds = false;
	guy2.chessSounds = false;
	level.chessTalkTrigger waittill ("trigger");
	guy1.chessSounds = true;
	guy2.chessSounds = true;
	println ("^5 TIME TO CHESS TALK");
	level endon ("chess interrupted");
	guy1 animscripts\face::SaySpecificDialogue (undefined, "Pathfinder_German_Guard1_wonder", 1.0, "sounddone");
	guy1 waittill ("sounddone");
	guy2 animscripts\face::SaySpecificDialogue (undefined, "Pathfinder_German_Guard2_1sttoknow", 1.0, "sounddone");
	guy2 waittill ("sounddone");
	guy1 animscripts\face::SaySpecificDialogue (undefined, "Pathfinder_German_Guard1_wrong", 1.0, "sounddone");
	guy1 waittill ("sounddone");
	guy2 animscripts\face::SaySpecificDialogue (undefined, "Pathfinder_German_Guard2_thepointis", 1.0, "sounddone");
	guy2 waittill ("sounddone");
	guy1 animscripts\face::SaySpecificDialogue (undefined, "Pathfinder_German_Guard1_sowhat", 1.0, "sounddone");
	guy1 waittill ("sounddone");
	maps\pathfinder_anim::enableChessSounds();
	guy1.chessSounds = false;
	guy2.chessSounds = false;
}

chess_leap_deathanim ()
{
	self endon ("death");
	while (1)
	{
		self waittill ("single anim", notetrack);

		if (notetrack == "god mode")
		{
//			self.allowdeath = false;
			props[0] = level.chess_pieces;
//			if ((isalive (guy[0])) && (isdefined (guy[0].deathanim)))
			thread anim_single (props, "fight", undefined, level.chess_pieces);
			continue;
		}

		if (notetrack != "normal death")
			continue;
			
		self.allowdeath = true;
		self.deathanim = undefined;
//		self notify ("stop leaping");
//		self.health = 90;
		return;
	}
}

chessSpecialDeath (spawn, node)
{
//	self endon ("stop leaping");
	spawn.allowdeath = true;
//	spawn.health = 50000;
	spawn waittill ("pain");
//	spawn.deathanim = level.scr_anim[spawn.animname]["leap death"];
	anim_single_solo (spawn, "leap death", undefined, node);
	spawn DoDamage ( spawn.health + 50, spawn.origin );
}

chess ( node )
{
	targets = getentarray (node.target,"targetname");
	spawners = [];
	for (i=0;i<targets.size;i++)
	{
		if (targets[i].classname == "trigger_multiple")
		{
			start_trigger = targets[i];
			level.chessTalkTrigger = start_trigger;
			stop_triggers = getentarray (start_trigger.target,"targetname");
		}
		else
			spawners[spawners.size] = targets[i];
	}
	targets = undefined;
	spawners[0].animname = "sit";
	spawners[1].animname = "stand";
	
//	thread maps\_anim::anim_spawner_teleport (spawners, "move 1", undefined, node);
	
	guy = [];
	for (i=0;i<spawners.size;i++)
	{
		spawners[i].count = 1;
		while (1)
		{
			guy[i] = spawners[i] stalingradspawn();
			if (isalive (guy[i]))
				break;
			else
				wait (1);
		}
	}

	for (i=0;i<guy.size;i++)
	{
		if (!i)
		{
			guy[i].animname = "sit";
			guy[i].deathanim = level.scr_anim[guy[i].animname]["sit death"];
			guy[i] thread chess_leap_deathanim();
		}
		else
		{
			guy[i].animname = "stand";
			guy[i].deathanim = level.scr_anim[guy[i].animname]["death"];
		}
		
		guy[i].allowdeath = true;
		guy[i].health = 1;
//		guy[i] endon ("death");
//		guy[i] endon ("pain");
	}
	
	thread chessSounds(guy[0], guy[1]);
	chess_node = spawn ("script_model",(0,0,0));
	chess_node setmodel ("xmodel/chessgame_animnode");
	chess_node.origin = node.origin;
	chess_node.angles = node.angles;
	
	chess_pieces = spawn ("script_model",(0,0,0));
	chess_pieces setmodel ("xmodel/chessgame_animrig");
	chess_pieces.animname = "pieces";
	chess_pieces.origin = chess_node gettagorigin ("TAG_crate");
	chess_pieces.angles = chess_node gettagangles ("TAG_crate");
	chess_pieces UseAnimTree(level.scr_animtree[chess_pieces.animname]);
	level.chess_pieces = chess_pieces;
	level thread chess_think( guy, node, chess_pieces );
	array_thread (stop_triggers, ::trigger_stop, start_trigger);
//	array_levelthread (guy, ::chess_pain);
	level thread chess_radius( guy[0] );
	start_trigger waittill ("stop trigger");

	newguy = [];

	continuer = false;
	for (i=0;i<guy.size;i++)
	{
		if (isalive (guy[i]))
		{
//			if (guy[i].animname == "sit")
//				thread chessSpecialDeath (guy[i], chess_node);

			newguy[newguy.size] = guy[i];
			continuer = true;
		}
	}	
	if (!continuer)
		return;
	guy = newguy;	
	
	level notify ("chess interrupted");
	guy[0] notify ("fight");
	
	anim_single (guy, "fight", undefined, node);
	
	for (i=0;i<guy.size;i++)
	{
		if (isalive (guy[i]))
		{
			guy[i].deathanim = undefined;
//			guy[i].health = 100;
		}
	}
}

chess_pain ( ai )
{
	ai waittill ("pain");
	if (isalive (ai))
		ai notify ("end_sequence");
}

chess_radius ( guy )
{
	guy endon ("death");
	guy endon ("fight");
	
	while (distance (level.player.origin, guy.origin) > 350)
		wait (0.5);
	
	guy notify ("player approaches");
}

chess_think ( guy, node, chess_pieces )
{
	level endon ("chess interrupted");
	for (i=0;i<guy.size;i++)
	{
		guy[i] endon ("death");
		guy[i] endon ("pain");
		guy[i] endon ("fight");
	}
	
	props[0] = chess_pieces;

	guy[0] thread anim_loop ( guy, "idle", undefined, "player approaches", node);
	println ("^c 1");
	guy[0] waittill ("player approaches");	

	guy[0] anim_single (guy, "guard", undefined, node);

	props[0] thread anim_single (props, "move 1", undefined, chess_pieces);
	guy[0] anim_single (guy, "move 1", undefined, node);

	guy[0] anim_single (guy, "think 1", undefined, node);
	guy[0] anim_single (guy, "think 2", undefined, node);
	guy[0] anim_single (guy, "think 1", undefined, node);
	guy[0] anim_single (guy, "think 1", undefined, node);
	guy[0] anim_single (guy, "think 2", undefined, node);


	guy[0] anim_single (guy, "think 1", undefined, node);
	guy[0] anim_single (guy, "think 2", undefined, node);
	guy[0] anim_single (guy, "think 1", undefined, node);

	props[0] thread anim_single (props, "move 2", undefined, chess_pieces);
	guy[0] anim_single (guy, "move 2", undefined, node);

	guy[0] anim_single (guy, "think 1", undefined, node);
	guy[0] anim_single (guy, "think 1", undefined, node);
	guy[0] anim_single (guy, "think 2", undefined, node);
	guy[0] anim_single (guy, "think 1", undefined, node);

	props[0] thread anim_single (props, "move 3", undefined, chess_pieces);
	guy[0] anim_single (guy, "move 3", undefined, node);
	
	level anim_loop ( guy, "idle", undefined, "chess interrupted", node);
}

dropprint (ai)
{
	ai waittill ("death");
	println (ai.dropweapon);
}

piss ( node )
{
	targets = getentarray (node.target,"targetname");
	for (i=0;i<targets.size;i++)
	{
		if (targets[i].classname == "trigger_multiple")
		{
			start_trigger = targets[i];
			stop_triggers = getentarray (start_trigger.target,"targetname");
		}
		else
			ai = targets[i];
	}
	targets = undefined;

	level thread dropprint(ai);
	ai endon ("death");
	ai endon ("done");
	ai endon ("pain");
	

	ai.allowdeath = true;
	ai.animname = "pisser";
	ai.health = 1;
	
	wait (7);
//	start_trigger waittill ("trigger");

	rig = spawn ("script_model",(0,0,0));
	rig setmodel ("xmodel/piss_sequence_gunpose");
	
	rig.origin = node.origin;
	rig.angles = node.angles;
		
	rig maps\_anim::gun_leave_behind (ai, level.scr_notetrack[ai.animname][0]);

	level thread alert_other_guy ( ai );
	level thread piss_stop ( ai, "fight" );
	level thread piss_stop ( ai, "all done" );
	level thread piss_stop ( ai, "pain" );
	level thread piss_stop ( ai, "death" );
	level thread piss_pain( ai );
	level thread piss_think( ai, node );
	if (getcvar ("special") == "indeed")
		level thread piss_allover (ai);
	
//	ai.looper = spawn ("script_origin",(0,0,0));
//	ai.looper.origin = ai.origin;
//	ai.looper linkto (ai);
//	ai.looper playloopsound ("Pissing_Guy");
	ai playloopsound ("Pissing_Guy");
//	ai.looper thread ghetto_loop ("Pissing_Guy");
	
	array_thread (stop_triggers, ::trigger_stop, start_trigger);
	
	start_trigger waittill ("stop trigger");
	ai notify ("fight");
	guy[0] = ai;
	ai anim_single (guy, "flinch turn", undefined, node);
	ai.health = 100;
	node = getnode ("urinazi goes","targetname");
}

piss_allover (ai)
{
	ai endon ("death");
	ai endon ("fight");	
	ai endon ("all done");
	
	timer = 0;
	while (1)
	{
		origin = ai gettagorigin ("Bip01 Pelvis");
		angles = ai gettagangles ("Bip01 Pelvis");
		angles = anglesToForward (angles);
		dest = maps\_utility::vectorScale (angles, -100);
		dif = 25;
		trace = bulletTrace(origin, origin+dest, false, undefined);
		smokeorg =  trace["position"];

		
		randnum = randomint (4) + 1;
		if (gettime() > timer)
		{
			playfxOnTag ( level._effect["special line"], ai, "Bip01 Pelvis" );
			timer = gettime() + 500;
		}
		
		for (i=0;i<randnum;i++)
		{
			brightness = randomfloat (100) * 0.01;
//			playfx ( level._effect["special line"], origin, origin);//, origin + dest + (randomfloat (dif) - dif*0.5,randomfloat (dif) - dif*0.5,randomfloat (dif) - dif*0.5));
			playfx ( level._effect["special smoke"], smokeorg );
			/*
			line (origin, origin + dest + (randomfloat (dif) - dif*0.5,randomfloat (dif) - dif*0.5,randomfloat (dif) - dif*0.5),
			 (1*brightness,1*brightness,0), 1, true);
			*/ 
		}
		
		wait (0.05);
	}
}

alert_other_guy ( ai )
{
	ai waittill ("death");
	level notify ("early guy alert!");
}

piss_stop (ai, notifier)
{
//	ai endon ("death");
	ai waittill (notifier);
//	if (isdefined (ai.looper))
//		ai.looper delete();
	ai stoploopsound ("Pissing_Guy");

//	ai.looper stoploopsound ("pissing_guy");
}

trigger_stop ( trigger )
{
	if (self.classname == "trigger_damage")
		self enableGrenadeTouchDamage();
	self waittill ("trigger");
	trigger notify ("stop trigger");
}

piss_pain ( ai )
{
	ai waittill ("pain");
	if (isalive (ai))
		ai notify ("end_sequence");
}

piss_think ( ai, node )
{
	ai endon ("death");
	ai endon ("fight");
	ai endon ("pain");

	guy[0] = ai;
	ai anim_single (guy, "idle", undefined, node);
	ai notify ("all done");
	ai anim_single (guy, "shakeout", undefined, node);
	ai anim_single (guy, "casual turn", undefined, node);
	ai notify ("done");
	node = getnode ("urinazi goes","targetname");
	ai setgoalnode (node);
	while (isdefined (node.target))
	{
		node = getnode (node.target,"targetname");
		ai setgoalnode (node);
		wait (10);
	}
	
}

sameVehicleGroup ()
{
	potentials = getaiarray();
	ai = [];
	for (i=0;i<potentials.size;i++)
	{
		if (!isdefined (potentials[i].script_vehiclegroup))
			continue;
		
		if (potentials[i].script_vehiclegroup != self.script_vehiclegroup)
			continue;
			
		ai[ai.size] = potentials[i];
	}
	
	return ai;
}

early_truck_damage()
{
	self waittill ("truck is drivin");
	
	ai = self sameVehicleGroup();
	array_levelthread (ai, ::early_truck_ai_think, self);
	self waittill ("damage");
	wait (1.8);
	self notify ("unload");
	wait (1);
	self setSpeed(0,30);
}

early_truck_ai_think (guy, truck)
{
	if (isdefined (guy.dontIdle))
		return;
		
	guy.allowDeath = true;
	guy.animname = "stand";
	truck thread anim_loop_solo ( guy, "idle", guy.exittag, "stop idle");
	truck waittill ("damage");
	wait (1.75);
	guy notify ("stop idle");
	guy stopanimscripted();
}

dontIdle ()
{
	self waittill ("spawned", spawn);
	if (maps\_utility::spawn_failed(spawn))
		return;
		
	spawn.dontIdle = true;
}

early_truck()
{
	self endon ("death");
	wait (self.script_delay);

/*	
	driver = getent (self.target,"targetname");
	if (isdefined (driver))
		driver thread driver_kill (self);
*/
		
	driver = getent (self.target,"targetname");
	if (isdefined (driver))
		driver thread dontIdle();

	self.treaddist = 30;
	self maps\_truck::init();
	self maps\_truck::attach_guys(undefined,driver);
	path1 = getVehicleNode(self.target,"targetname");

						
	self attachpath (path1);
	wait .1;
	self notify ("truck is drivin");

	riders = self sameVehicleGroup();
	array_thread (riders, ::driver_kill, self);
	
	self startPath();
	
//	level.truck = 1;
	self waittill ("reached_end_node");
	
	self delete();	
}

driver_kill ( truck )
{
//	self waittill ("spawned",spawn);
//	truck waittill ("truck is drivin");
	truck waittill ("reached_end_node");
	self delete();
}

enemy_truck(num)
{
	if ( num == 1 )
	{     		                              
		truck = getent ("truck1","targetname");
		driver = getent ("truck1_driver","targetname");
		unloadnode = getVehicleNode("auto946","targetname");
		
		truck.treaddist = 30;
		truck maps\_truck::init();
		truck maps\_truck::attach_guys(undefined,driver);
		path1 = getVehicleNode(truck.target,"targetname");
							
		truck attachpath (path1);
				
		wait .1;
		
		truck startPath();
		
		level.truck = 1;
				
		truck disconnectpaths();
		
		truck setWaitNode (unloadnode);
		truck waittill ("reached_wait_node");
		
		truck notify ("unload");
	}
	if ( num == 2 )
	{     		                              
		truck2 = getent ("truck2","targetname");
		driver = getent ("truck2_driver","targetname");
		unloadnode = getVehicleNode("auto885","targetname");
		
		truck2.treaddist = 30;
		truck2 maps\_truck::init();
		truck2 maps\_truck::attach_guys(undefined,driver);
		path2 = getVehicleNode(truck2.target,"targetname");
							
		truck2 attachpath (path2);
				
		wait .1;
		
		truck2 startPath();
		
		level.truck = 2;
				
		truck2 disconnectpaths();
		
		truck2 setWaitNode (unloadnode);
		truck2 waittill ("reached_wait_node");
		
		truck2 notify ("unload");
	}
}

spawn_attack_think (spawner, msg, optionalThread)
{
	spawn = spawner dospawn();
	if (isalive (spawn))
	{
		if (isdefined (optionalThread))
			spawn thread [[optionalThread]]();
		spawn waittill ("death");
	}
	
	level notify ("group died " + msg);
}

spawn_attack_group (msg)
{
	spawners = getentarray (msg,"targetname");
	for (i=0;i<spawners.size-1;i++)
		level thread spawn_attack_think(spawners[i], msg);
	
	for (i=0;i<spawners.size-1;i++)
		level waittill ("group died " + msg);
}

kill_ai ( trigger )
{
	while (1)
	{
		trigger waittill ("trigger",other);
		if (!isalive (other))
			continue;
			
		other delete();
	}
}
spawn_attack_flee ()
{
	node = getnode ("flee","targetname");
	wait (randomint (30));
	self setgoalnode (node);
	goalradius = 800;
	while (1)
	{
		self.goalradius = goalradius;
		wait (randomint (10));
		goalradius-=200;
		if (goalradius <= 250)
			break;
	}
}

spawn_attack_group_flee (msg)
{
	spawners = getentarray (msg,"targetname");
	for (i=0;i<spawners.size-1;i++)
		level thread spawn_attack_think(spawners[i], msg, ::spawn_attack_flee);
	
	for (i=0;i<spawners.size-1;i++)
		level waittill ("group died " + msg);
}

window_guy ( spawner )
{
	spawner waittill ("spawned",spawn);
	if (maps\_utility::spawn_failed(spawn))
		return;
	
	wait (0.5);
	window = getent ("window german","targetname");
	window rotateyaw (-135, 1, 0, 0.8);
}

flee_fight ()
{
	self waittill ("spawned",spawn);
	if (maps\_utility::spawn_failed(spawn))
		return;
	
	spawn endon ("death");
	node = getnode (spawn.target,"targetname");
	spawn setgoalnode (node);
	spawn.goalradius = 32;
	spawn waittill ("goal");
	wait (0.25 + randomfloat (1));
	node = getnode (node.target,"targetname");
	spawn setgoalnode (node);
	spawn.goalradius = node.radius;
}

flee_delete ()
{
	while (self.count > 0)
	{
		self waittill ("spawned",spawn);
		if (!maps\_utility::spawn_failed(spawn))
			level thread flee_delete_think(spawn);
	}
}

flee_delete_think (spawn)
{
	spawn endon ("death");
	wait ((8) + randomfloat (10));
	node = getnode ("delete node","targetname");
	spawn setgoalnode (node);
	spawn.goalradius = 32;
	spawn waittill ("goal");
	spawn delete();
}

spawn_attack ()
{
	self.count = 1;
	spawn = self dospawn();
}	

// Friendlies that are off the play area, for show. They fight then exit.
field_parachuters (msg)
{
	parachuters = getentarray (msg,"targetname");
	for (i=0;i<parachuters.size;i++)
		parachuters[i] thread parachute_think(8, ::spawn_attack_flee);
}

deleteChain ( chainName )
{
	chains = getentarray ("trigger_friendlychain","classname");
	for (i=0;i<chains.size;i++)
	{
		if (!isdefined (chains[i].script_chain))
			continue;
			
		if (chains[i].script_chain != chainName)
			continue;
			
		chains[i] delete();
	}
}

house_enemies_spawn ()
{
	self.count = 1;
	spawn = self dospawn();
	println ("spawning house guy");
	if (maps\_utility::spawn_failed(spawn))
	{
		println ("house guy spawn failed");
		return;
	}
	println ("Spawn was a success!");

	thread house_enemies_think( spawn );
}

house_enemies_think ( spawn )
{

	level.house_enemies++;
	spawn waittill ("death");
	level.house_enemies--;
	level notify ("house enemy died");
}

windowGuyDeath (windowGuy)
{
	windowGuy waittill ("death");
	level notify ("windowguy Done");
	wait (3.5);
	mg42 = getent ("secret mg42","targetname");
	mg42 hide();
	leftwindow = getent ("window left","targetname");
	rightwindow = getent ("window right","targetname");
	leftwindow delete();
	rightwindow delete();
}

windowGuyAutomaticDeath(windowGuy)
{
	windowGuy endon ("death");
	wait (25);
	windowGuy DoDamage ( windowGuy.health + 50, windowGuy.origin );
}

crouchWarning ()
{
	wait (2);
	if (level.player getstance() == "stand")
		thread hint_stand2crouch();
	if (level.player getstance() == "prone")
		thread hint_prone2crouch();
}

windowGuySequence()
{
	while (!isdefined (windowGuy))
	{
		wait (1);
		windowGuy = getent ("window mg42 guy","targetname") dospawn();
	}
	thread crouchWarning();
	
	windowGuy.dropweapon = false;
	windowGuy.health = 500;
	
	mg42 = getent ("secret mg42","targetname");
	level thread windowGuyDeath(windowGuy);
	
	// Kill the windowguy after awhile if nobody does
	level thread windowGuyAutomaticDeath(windowGuy);
	
	mg42 waittill("turretstatechange"); // code or script
	
	leftwindow = getent ("window left","targetname");
	leftwindow rotateyaw (-165, 0.35, 0, 0.35);
	rightwindow = getent ("window right","targetname");
	rightwindow rotateyaw (165, 0.35, 0, 0.35);
	rightwindow playsound ("wood_door_kick");
	
	mg42 show();
}

randomExplosions ()
{
	presound(2);
	thread maps\_utility::exploder(2);
	wait (1.5);
	presound(3);
	thread maps\_utility::exploder(3);
	wait (2);
	presound(4);
	thread maps\_utility::exploder(4);
	wait (3.5);
	presound(5);
	thread maps\_utility::exploder(5);
	wait (0.25);
	presound(6);
	thread maps\_utility::exploder(6);
}

fast_truck ( truck )
{
	truck thread early_truck();
}

fast_truck_trigger (trigger)
{
	while (1)
	{
		trigger waittill ("trigger", other);
		if (!isdefined (other.targetname))
			continue;
		
		if (other.targetname == "fast truck")
			break;
	}
	
	trigger delete();
	
	other setSpeed(0,10);
	other thread maps\_utility::playSoundOnTag("stop_skid", "tag_origin");
	wait (4);	
	other setSpeed(40,40);
}

siren_sound ()
{
	wait (7);
	wait (self.script_delay);
	self playloopsound ("Air_raid_siren_pathfinder");
	wait (30 + randomfloat (30));
	self stoploopsound();
	self delete();
	return;
	
	timer = 30 + randomfloat (30);
	timer*=1000;
	timer+= gettime();
	
	while (gettime() < timer)
	{
		self playsound ("Air_raid_siren_pathfinder", "sounddone");
		self waittill ("sounddone");
	}
//	self stoploopsound();
	self delete();
}

kickOpenDoor ()
{
	level endon ("door is kicked");
	node = getnode ("new house door node", "targetname");
	while (1)
	{
		level thread kickdooropenGo (node);
		level thread kickdoortookTooLong();
		level waittill ("door took too long to be kicked");
	}
}

kickdoortookTooLong ()
{
	wait (15);
	if (isalive (level.closeFriend))
	{
		level.closeFriend setgoalentity (level.player);
		level.closeFriend notify ("stop magic bullet shield");
		level.closeFriend = undefined;
	}
	level notify ("door took too long to be kicked");
}

kickdooropenGo (node)
{
	level endon ("door took too long to be kicked");
	
	while (1)
	{
		level.closeFriend = undefined;
		ai = getaiarray ("allies");
		for (i=0;i<ai.size;i++)
		{
//			if (distance (ai[i].origin, node.origin) > 384)
			if (distance (ai[i].origin, node.origin) > 512)
				continue;
		
			level.closeFriend = ai[i];	
		}
		
		if (!isdefined (level.closeFriend))
		{
			wait (1);
			continue;
		}
		
		if (maps\_utility::spawn_failed(level.closeFriend))
			continue;
		level.closeFriend endon ("death");		
		level.closeFriend.animname = "generic";
		level.closeFriend thread maps\_utility::magic_bullet_shield();
		closeArray[0] = level.closeFriend;
		maps\_anim::anim_reach (closeArray, "kick door 1", undefined, node);
		break;
	}
	
	if (randomint (100) > 50)
		level.closeFriend thread anim_single_solo (level.closeFriend, "kick door 1", undefined, node);
	else
		level.closeFriend thread anim_single_solo (level.closeFriend, "kick door 2", undefined, node);

	level.closeFriend waittillmatch ("single anim", "kick");
	level.closeFriend notify ("stop magic bullet shield");
	level.closeFriend setgoalentity (level.player);
	level notify ("door is kicked");
}

radioAttack (radio)
{
	radio playsound ("Pathfinder_German_Radio_1", "sounddone");
	radio waittill ("sounddone");
	radio playsound ("Pathfinder_German_Radio_2", "sounddone");
	radio waittill ("sounddone");
	radio delete();
	
}

enemy_waves ()
{
//	thread airplanes();
	mg42 = getent ("secret mg42","targetname");
	mg42 hide();
	trigger = getent ("start_wave", "targetname");
	trigger waittill ("trigger");
	trigger delete();
	musicplay("pf_stealth");
	
	chain = maps\_utility::get_friendly_chain_node ("100");
	level.player SetFriendlyChain (chain); // Make friendlies move up to the first flak area.
	
	array_thread (getentarray ("truck early","targetname"), ::early_truck);

	flag_wait ("flares set");
	
	thread fast_truck_trigger (getent ("fast truck trigger","targetname"));
	thread fast_truck (getent ("truck fast","targetname"));
	
	radio = getent ("radio","targetname");
	wait (2);
//	radio stoploopsound();
	radio notify ("stop radio sound");
	thread radioAttack(radio);
//	maps\_utility::playSoundinSpace ("Pathfinder_German_Radio_1", radio.origin);
	array_thread (getentarray ("siren","targetname"), ::siren_sound);
	level notify ("start planes");
	wait (5);
//	wait (4);
	flag_set ("drop parachuters");
	maps\_utility::autosave(1);
	
	wait (10);
	level notify ("start attack effects");
	flag_set ("attack underway");
//	level notify ("start parachutes");
	level waittill ("touch down");
	
//	wait (4);
	
	
//	chain = maps\_utility::get_friendly_chain_node ("100");
//	level.player SetFriendlyChain (chain);
//	wait (20);
	
	
//	chain = maps\_utility::get_friendly_chain_node ("200");
//	level.player SetFriendlyChain (chain);
//	wait (36);
//	thread enemy_truck(1); ********
	
//	chain = maps\_utility::get_friendly_chain_node ("300");
//	level.player SetFriendlyChain (chain);
	thread spawn_attack_group ("group1");
	flag_set("planes can be hit");
//	array_thread (getentarray ("group1","targetname"), ::spawn_attack);
	wait (5);
	thread window_guy (getent ("window guy","targetname"));
	array_thread (getentarray ("bottom floor guy","targetname"), ::spawn_attack);
	
//	// These lower floor guys run out, see the player, and then run to the backyard to get their buddies.
//	array_thread (getentarray ("run guy","targetname"), ::flee_fight);

	// The top floor guys run out, fight a bit, then run away and disappear.
	array_thread (getentarray ("top floor guy","targetname"), ::flee_delete);
	thread maps\_spawner::flood_spawn (getentarray ("top floor guy","targetname"));

	thread windowGuySequence();
	
	// Explosions rock the countryside
	thread randomExplosions();
	
	level waittill ("windowguy Done");
	
	presound(1);
	thread maps\_utility::exploder(1);
	
	maps\_spawner::kill_spawnerNum(1);
	
	chain = maps\_utility::get_friendly_chain_node ("200");
	level.player SetFriendlyChain (chain); // Make friendlies move up to the first flak area.
	
	wait (3);
	thread maps\_utility::set_ambient("during battle");
	level thread kickOpenDoor();
	level waittill ("door is kicked");
	
	house_door2 = getent ("new house door", "targetname");
	house_door2 connectpaths();
	house_door2 rotateyaw (-100, 0.8);
	house_door2 playsound ("wood_door_kick");
	
//	thread house_enemies();
//	thread field_parachuters("field parachuter");
	wait (3);
//	deleteChain("100");
//	if (!level.flag["killed chain 500"])
//	{	
//	}
	
	objective_state(3, "done");
	objective_current(4);
//	spawn_attack_group_flee ("group3"); ***********
//	array_thread (getentarray ("group2","targetname"), ::spawn_attack);
//	thread enemy_truck(2); *******
	wait (3);
	
//	spawn_attack_group_flee ("group2"); ********
//	array_thread (getentarray ("group3","targetname"), ::spawn_attack);
	wait (10);
	thread field_parachuters("field parachuter 2");
	
//	if (!level.flag["killed chain 500"])
//	{	
//	}
}

plane_intro ()
{
	wait (0.05);
	plane = spawnVehicle( "xmodel/c47", "plane", "C47", (0,0,0), (0,0,0) );
	path = getvehiclenode ("player plane","targetname");
	plane attachPath( path );
	plane playsound ("c47_fly_by");
	plane startPath();
	plane waittill ("reached_end_node");
	plane delete();	
}

hint_stand2crouch()
{
	binding = getKeyBinding("gocrouch");
	if(binding["count"])
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_CROUCHKEY", binding);
	else
	{
		binding = getKeyBinding("togglecrouch");
		if(binding["count"])
		{
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_CROUCHKEY", binding);
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_CROUCHTOGGLEFROM", binding);
		}
		else
		{
			binding = getKeyBinding("+movedown");
			if(binding["count"])
			{
				maps\_utility::keyHintPrint(&"SCRIPT_HINT_HOLDDOWNCROUCHKEY", binding);
			}
			else
			{
				binding = getKeyBinding("lowerstance");
				if(binding["count"])
				{
					maps\_utility::keyHintPrint(&"SCRIPT_HINT_CROUCHKEY", binding);
				}
			}
		}
	}

}

hint_prone2crouch()
{
	binding = getKeyBinding("gocrouch");
	if(binding["count"])
		maps\_utility::keyHintPrint(&"SCRIPT_HINT_CROUCHKEY", binding);
	else
	{
		binding = getKeyBinding("togglecrouch");
		if(binding["count"])
		{
			maps\_utility::keyHintPrint(&"SCRIPT_HINT_CROUCHKEY", binding);
			iprintlnbold(&"SCRIPT_HINT_CROUCHTOGGLEFROM");
		}
		else
		{
			binding = getKeyBinding("+movedown");
			if(binding["count"])
				maps\_utility::keyHintPrint(&"SCRIPT_HINT_HOLDDOWNCROUCHKEY", binding);
			else
			{
				binding = getKeyBinding("raisestance");
				if(binding["count"])
					maps\_utility::keyHintPrint(&"SCRIPT_HINT_RAISEFROMPRONETOCROUCH", binding);
				else
				{
					binding = getKeyBinding("+moveup");
					if(binding["count"])
						maps\_utility::keyHintPrint(&"SCRIPT_HINT_RAISEFROMPRONETOCROUCH", binding);
				}
			}
		}
	}
}


array_thread (ents, process, var, excluders)
{
	maps\_utility::array_thread (ents, process, var, excluders);
}

array_levelthread (ents, process, var, excluders)
{
	maps\_utility::array_levelthread (ents, process, var, excluders);
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
}

flag (msg)
{
	if (!level.flag[msg])
		return false;
		
	return true;
}


random (array)
{
	return array [randomint (array.size)];
}

anim_loop ( guy, anime, tag, ender, node, tag_entity )
{
	maps\_anim::anim_loop ( guy, anime, tag, ender, node, tag_entity );
}

anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
{
	newguy[0] = guy;
	maps\_anim::anim_loop ( newguy, anime, tag, ender, node, tag_entity );
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

presound (num)
{
	ents = level._script_exploders;

	for (i=0;i<ents.size;i++)
	{
		if (!isdefined (ents[i]))
			continue;

		if (ents[i].script_exploder != num)
			continue;
			
		if (isdefined (ents[i].script_presound))
		{
			level maps\_utility::playSoundinSpace (level.scr_sound[ents[i].script_presound], ents[i].origin);
			return;
		}
	}	
}

waittill_either_think (ent, msg)
{
	println (ent, "^1 is waiting for ", msg);
	ent waittill (msg);
	println (ent, "^1 got ", msg);
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
 
preSpawnThink ( spawner, trigger )
{
	spawn = spawner dospawn();
	if (maps\_utility::spawn_failed(spawn))
		return;
		
	spawn endon ("death");
	spawn setgoalpos (spawn.origin);
	spawn.goalradius = 16;
	trigger waittill ("trigger");
	level thread maps\_spawner::spawn_think_action (spawn);
}
 
preSpawnAlive ( trigger )
{
	if (!isdefined (trigger.target))
		return;
	
	spawnTriggerArray = getentarray (trigger.target,"targetname");
	if (spawnTriggerArray.size != 1)
		return;
		
	spawnTrigger = spawnTriggerArray[0];
		
	if (spawnTrigger.classname != "trigger_multiple")
		return;
		
	spawners = getentarray (spawnTrigger.target,"targetname");
	spawnTrigger.target = "null";
	
	trigger waittill ("trigger");
	trigger delete();
	array_levelthread(spawners, ::preSpawnThink, spawnTrigger);
}
