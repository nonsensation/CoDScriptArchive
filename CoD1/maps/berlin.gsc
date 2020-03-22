/**************************************************************************
Level: 		BERLIN
Campaign: 	Allied
Objectives: 	1. Destroy All Anti-Tank Positions [5 Remaining]
			(4 flak88 antitank, 1 tiger tank)
		2. Hold the Line Until the Tanks Arrive
			(Player must stay alive through massive gunfire
			in the courtyard until friendly tanks arive)
		3. Storm the Reichstag and Get to the Roof
			(Get through the Reichstag and to the roof where
			the flag carrier will wave the flag)
***************************************************************************/
#using_animtree("generic_human");
main()
{
	setCullFog(0, 15000, .64, .64, .6, 0);

	maps\_load::main();
	maps\berlin_fx::main();
	maps\berlin_anim::main();
	maps\_treefall::main();
	maps\_tank::main();
	maps\_tiger::main();
	maps\_t34::mainnoncamo();
	maps\_bombs::init();
	
	musicplay("stalingrad_battle");
	
	precacheModel ("xmodel/stalingrad_flag");
	
	level.flags["FX1"] = true;
	level.flags["FX2"] = false;
	level.flags["MoveTanks"] = true;
	level.flags["Tank2_InPosition"] = false;
	level.flags["objective_complete1"] = false;
	
	level.ambient_track ["interior"] = "ambient_berlin_int";
	level.ambient_track ["exterior"] = "ambient_berlin_ext";
	thread maps\_utility::set_ambient("exterior");
	
	friends = getentarray ("friend","targetname");
	for (i=0;i<friends.size;i++)
		thread friends(friends[i]);
	level.maxfriendlies = (7);
	level.friendlywave_thread = (maps\berlin::friends);
	level.targetnum = (1);
	level.followtargetgroup = (1);
	
	thread berlin_fx_triggers_setup();
	thread berlin_fx();
	thread followtanks_setup();
	thread objectives();
	thread intro();
	thread tankbust();
	thread spawners_setup();
	thread wall_exploder();
	thread wall_exploder_trigger();
	thread friendly_tanks_setup();
	thread change_follows();
	thread dialogue1();
	thread panzer_tankgun();
	
	trig = getent ("spawntransitionguys","targetname");
	trig thread maps\_utility::triggerOff();
	
	trig2 = getent ("friendchain_crosscourtyard","targetname");
	trig2 thread maps\_utility::triggerOff();
}

#using_animtree( "panzerIV" );
panzer_tankgun()
{
	tank = getent ("auto21","targetname");
	tank useAnimTree( #animtree );
	
	tank maps\_tank::setteam("axis");
	tank maps\_tankgun::mginit();
	tank maps\_tankgun::mgon();
	
	level waittill ("auto20");
	tank maps\_tankgun::mgoff();
}

change_follows()
{
	getent ("resetfollows","targetname") waittill ("trigger");
	level.min = 0;
	level.max = 10;

	guys = getaiarray ("allies");
	for (i=0;i<guys.size;i++)
		if ( (isdefined (guys[i])) && (isalive (guys[i])) )
			guys[i] thread change_follows_guy();
}

change_follows_guy()
{
	self endon ("death");
	self.followmax = (10);
	self.followmin = (0);
	self setgoalentity (level.player);
	self.goalradius = 16;
}

followtanks_setup()
{
	thread followtanks_stopper();

	level.tank1 = getent ("followtank1","targetname");
	level.tank2 = getent ("followtank2","targetname");
	level.tank3 = getent ("followtank3","targetname");
	
	level.tanktouse = level.tank1;
	
	level.tank1 maps\_t34::init_friendly();
	level.tank2 maps\_t34::init_friendly();
	level.tank3 maps\_t34::init_friendly();

	level.tank1 thread followtank_keepalive();
	level.tank2 thread followtank_keepalive();
	level.tank3 thread followtank_keepalive();

	level.tank1.path = getVehicleNode (level.tank1.target,"targetname");
	level.tank2.path = getVehicleNode (level.tank2.target,"targetname");
	level.tank3.path = getVehicleNode (level.tank3.target,"targetname");

	level.tank1 attachpath(level.tank1.path);
	level.tank2 attachpath(level.tank2.path);
	level.tank3 attachpath(level.tank3.path);

	level.tank1 thread tank_paths();
	level.tank2 thread tank_paths();
	level.tank3 thread tank_paths();

	level.tank1 startpath();
	level.tank2 startpath();
	level.tank3 startpath();

	level.tank1 setspeed(0,5);
	level.tank2 setspeed(0,5);
	level.tank3 setspeed(0,5);

	level.tank1 thread followtanks_think1();
	level.tank1 thread followtanks_death1(level.tank2);
	level.tank2 resumespeed(3);
	level.tank3 resumespeed(3);

	level.tank1 thread followtank_aim_random();
	level.tank2 thread followtank_aim_random();
	level.tank3 thread followtank_aim_random();

	wait 3;
	level.flags["MoveTanks"] = true;
}

followtanks_stopper()
{
	getent ("firsttankstop","targetname") waittill ("trigger");
	if (level.flags["objective_complete1"] == false)
		level.flags["MoveTanks"] = false;
}

followtanks_think1()
{
	self endon ("death");
	self connectpaths();
	self resumespeed(3);
	level thread check_distances();
	while (1)
	{
		if (level.flags["objective_complete1"] == false)
		{
			if (level.flags["MoveTanks"] == true)
			{
				self connectpaths();
				self resumespeed(3);
			}
			else
			{
				self setspeed(0,5);
				self disconnectpaths();
				while (level.flags["MoveTanks"] == false)
					wait (1);
				self connectpaths();
				self resumespeed(3);
			}
	
			while ( (level.range > 350) && (level.flags["MoveTanks"] == true) )
				wait (.05);
			self setspeed(0,5);
			self disconnectpaths();
			while ( (level.range < 350) && (level.flags["MoveTanks"] == true) )
				wait (.05);
		}
		else
		{
			self connectpaths();
			self resumespeed(3);
			while (level.range > 350)
				wait (.5);
			self setspeed(0,5);
			self disconnectpaths();
			while (level.range <= 350)
				wait (.5);
			wait (.1);
		}
	}
}

check_distances()
{
	level endon ("HoldLine");
	
	level.range = 500000000;
	while (1)
	{
		range = 500000000;
		allies = [];
		if (level.flags["objective_complete1"] == false)
			allies = getaiarray ("allies");
		
		allies[allies.size] = level.player;
		
		for (i=0;i<allies.size;i++)
		{
			if (isalive (allies[i]))
			{
				newrange = distance (level.tanktouse.origin, allies[i].origin);
				if (newrange < range)
				{
					range = newrange;
				}
			}
		}
		level.range = range;
		
		wait 1;
	}
}

followtanks_death1(tank2)
{
	self waittill ("reached_end_node");
	level.tanktouse = level.tank2;
	if (level.flags["objective_complete1"] == false)
		level.flags["MoveTanks"] = false;
	self notify ("CanDie");
	self.health = (100);
	level notify ("EndMovers");
	tank2 thread followtanks_think1();
	self thread tankshooter1();
	level waittill ("TankGuyShot");
	wait 2.5;
	self.isalive = 0;
	self notify ("death");

}

followtank_keepalive()
{
	self endon ("CanDie");
	while (1)
	{
		self waittill ("damage");
		self.health = (50000);
	}
}

followtank_aim_random()
{
	self endon ("death");
	self endon ("StopRandomAim");

	target1 = getentarray ("followtarget1","targetname");
	target2 = getentarray ("followtarget2","targetname");
	target3 = getentarray ("followtarget3","targetname");

	last_targetnum1 = (target1.size + 1);
	last_targetnum2 = (target2.size + 1);
	last_targetnum3 = (target3.size + 1);

	while (1)
	{
		if (level.followtargetgroup == 1)
		{
			targetnum = randomint(target1.size);
			while (targetnum == last_targetnum1)
				targetnum = randomint(target1.size);
			last_targetnum1 = (targetnum);
			target = (target1[targetnum]);
		}
		else
		if (level.followtargetgroup == 2)
		{
			targetnum = randomint(target2.size);
			while (targetnum == last_targetnum2)
				targetnum = randomint(target2.size);
			last_targetnum2 = (targetnum);
			target = (target2[targetnum]);
		}
		else
		if (level.followtargetgroup == 3)
		{
			targetnum = randomint(target3.size);
			while (targetnum == last_targetnum3)
				targetnum = randomint(target3.size);
			last_targetnum3 = (targetnum);
			target = (target3[targetnum]);
		}

		self setTurretTargetEnt( (target), (0, 0, 64) );
		wait (5 + randomfloat(3));
		self clearTurretTarget();
	}
}

tankshooter1()
{
	shooter = getent ("tankshooter1","targetname");
	node = getnode ("tankshooter1_node","targetname");
	spawned = shooter dospawn();
	if (isalive (spawned))
	{
		spawned.health = (10000000);
		spawned.ignoreme = true;
		getent ("followtank2","targetname") thread followtanks_shoottankguy(spawned);
		spawned.radius = (8);
		spawned setgoalnode (node);
		spawned waittill ("goal");
		wait 2;
		spawned animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
		spawned.customtarget = (self);
		self.customAttackSpeed = "normal";
		self notify ("end_sequence");
		spawned.health = (100);
		level notify ("TankGuyShot");
	}
}

followtanks_shoottankguy(target)
{
	level endon ("stop shot 1");
	target endon ("death");
	getent ("followtank1","targetname") waittill ("death");
	self notify ("StopRandomAim");

	self setTurretTargetEnt( (target), (0, 0, 0) );
	self waittill("turret_on_vistarget");
	self clearTurretTarget();
	wait (3);
	self thread maps\_t34::fire();
	target playsound ("explo_rock");
	radiusDamage (self.origin, 256, 400, 25);

	self thread followtank_aim_random();
}

wall_exploder_trigger()
{
	tank = getent ("followtank2","targetname");
	getent ("wall_exploder_trigger","targetname") waittill ("trigger");
	level.flags["Tank2_InPosition"] = true;
	target = getent("tank_shootwall_target","targetname");
	level notify ("stop shot 1");
	tank setTurretTargetEnt(target, (0, 0, 0) );
	level waittill ("Tank2Fire");
	tank thread maps\_t34::fire();
	target playsound ("explo_rock");
}

wall_exploder()
{
	wallexploder_before = getentarray ("wallexploder_before","targetname");
	wallexploder_after = getentarray ("wallexploder_after","targetname");
	wallexploder_fx = getentarray ("wallexploder_fx","targetname");

	for (i=0;i<wallexploder_fx.size;i++)
		wallexploder_fx[i] hide();

	for (i=0;i<wallexploder_after.size;i++)
		wallexploder_after[i] hide();

	while ( (level.flags["Tank2_InPosition"] == false) || (level.flags["objective_complete1"] == false) )
		wait (6);
	wait (3);
	level notify ("Tank2Fire");

	for (i=0;i<wallexploder_after.size;i++)
		wallexploder_after[i] show();

	for (i=0;i<wallexploder_fx.size;i++)
		wallexploder_fx[i] thread maps\_utility::cannon_effect(wallexploder_fx[i]);

	trig = getent ("spawntransitionguys","targetname");
	trig thread maps\_utility::triggerOn();

	for (i=0;i<wallexploder_before.size;i++)
	{
		wallexploder_before[i] connectpaths();
		wallexploder_before[i] delete();
	}

	thread pole1_break();
}

followtarget3_trigger()
{
	getent ("followtarget3_trigger","targetname") waittill ("trigger");
	level.followtargetgroup = (3);
}

pole1_break()
{
	fxmodel = getent ("pole1_fx","targetname");
	before = getentarray ("pole1_before","targetname");
	after = getentarray ("pole1_after","targetname");

	for (i=0;i<after.size;i++)
		after[i] hide();
	fxmodel hide();

	level waittill ("Start_Tanks");
	while (distance(level.player.origin, fxmodel.origin) > 1200)
	{
		wait .5;
	}
	after = getentarray ("pole1_after","targetname");
	fxmodel = getent ("pole1_fx","targetname");

	fxmodel thread maps\_utility::cannon_effect(fxmodel);
	
	level thread maps\_utility::playSoundinSpace("explo_rock",fxmodel.origin);
	
	for (i=0;i<after.size;i++)
		after[i] show();
	wait .2;
	for (i=0;i<before.size;i++)
		before[i] delete();
}

spawners_setup()
{
	germans = getspawnerteamarray ("axis");
	maps\_utility::array_notify(germans,"disable");

	level waittill ("HoldLine");
	
	if (isdefined (level.tank2.mgturret))
		level.tank2.mgturret delete();
	level.tank2 delete();
	if (isdefined (level.tank3.mgturret))
		level.tank3.mgturret delete();
	level.tank3 delete();
	
	wait (randomint (3));
	maps\_utility::array_notify(germans,"enable");
	
	wait 3;
	dialogue4();

	level waittill ("Tanks_Arrived");
	maps\_utility::array_notify(germans,"disable");

	retreaters = getaiarray ("axis");
	for (i=0;i<retreaters.size;i++)
		if ( (isdefined (retreaters[i].script_noteworthy)) && (retreaters[i].script_noteworthy == "retreat") )
			if (isalive (retreaters[i]))
			{
				retreaters[i].goalradius = (32);
				retreaters[i] setgoalnode (getnode ("retreat_node","targetname"));
			}
}

final_mg42ers_start()
{
	all_spawners = getspawnerteamarray ("axis");
	for (i=0;i<all_spawners.size;i++)
	{
		if ( (isdefined (all_spawners[i].script_noteworthy)) && (all_spawners[i].script_noteworthy == "windowguy") )
		{
			spawners = [];
			spawners[spawners.size] = all_spawners[i];
		}
	}

	wait (10);

	last_rnum = (spawners.size + 1);
	if (spawners.size > 1)
	{
		while (1)
		{
			rnum = randomint(spawners.size);
			
			last_rnum = (rnum);
	
			spawned = spawners[rnum] dospawn();
			if ( (isdefined (spawned)) && (isalive (spawned)) )
			{
				spawned waittill ("death");
				wait randomint(4);
			}
			else
			{
				waitframe();
			}
		}
	}
}

waitframe()
{
	maps\_spawner::waitframe();
}

friends(guy)
{
	guy endon ("death");

	if (!isdefined (level.min))
		level.min = (-5);
	if (!isdefined (level.max))
		level.max = (5);

	guy.health = (350);
	guy.suppressionwait = (0.75);
	guy.goalradius = (32);
	guy.followmax = (level.max);
	guy.followmin = (level.min);
	guy setgoalentity (level.player);
}

objectives()
{
	thread maps\_bombs::main(1, &"BERLIN_OBJ1", "bomb_trigger", "plant those bombs");
	objective_current(1);
	thread objectives_wait();
}

objectives_wait()
{
	thread objectives_wait2();
	level notify ("plant those bombs");
	//level waittill ("auto14");
	level waittill ("bomb_trigger planted");
	maps\_utility::autosave(1);
	level.flags["MoveTanks"] = true;
	level.followtargetgroup = (2);
	thread followtarget3_trigger();
}

give_health()
{
	self.health = (1000000);
	while (1)
	{
		self waittill ("damage");
		self.health = (100000);
	}
}

objectives_wait2()
{
	level waittill ("objective_complete1");
	level.flags["objective_complete1"] = true;
	objective_state(1, "done");
	level.flags["MoveTanks"] = true;

	objective_add(2, "active", &"BERLIN_OBJ3", (3581, 9970, 1522));
	objective_current(2);
	
	level waittill ("HoldLine");
	
	musicplay("codtheme");
	
	objective_add(3, "active", &"BERLIN_OBJ2", (1348, 6168, 664));
	objective_current(3);

	level waittill ("Tanks_Arrived");
	thread dialogue_totheReichstag();
	trig = getent ("friendchain_crosscourtyard","targetname");
	trig thread maps\_utility::triggerOn();
	objective_state(3, "done");
	objective_current(2);
	maps\_utility::autosave(3);

	wait 5;

	getent ("end","targetname") waittill ("trigger");
	
	objective_state(2, "done");
	
	guy = maps\_utility::getClosestAI (level.player getorigin(), "allies" );
	if (isdefined (guy))
		guy thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][12], "berlin_russian1_berlinisours", 1.0);

	flagnode_carrier = getnode("flagnode_carrier","targetname");

	carrier = getent("flagguy_carrier","targetname");
	guy1 	= getent("flagguy_guy1","targetname");
	guy2 	= getent("flagguy_guy2","targetname");
	
	flagguy_carrier = carrier dospawn();
	flagguy_guy1 	= guy1 dospawn();
	flagguy_guy2 	= guy2 dospawn();
	
	if ((isdefined (flagguy_carrier)) && (isdefined (flagguy_guy1)) && (isdefined (flagguy_guy2)))
	{
		flagguy_carrier thread give_health();
		flagguy_guy1 thread give_health();
		flagguy_guy2 thread give_health();
		
		flagguy_carrier.maxsightdistsqrd = 3;
		flagguy_guy1.maxsightdistsqrd = 3;
		flagguy_guy2.maxsightdistsqrd = 3;
		
		flagguy_carrier.grenadeawareness = 0;
		flagguy_guy1.grenadeawareness = 0;
		flagguy_guy2.grenadeawareness = 0;
	}
	
	if (isdefined (flagguy_carrier))
	{
		flagguy_carrier attach ("xmodel/stalingrad_flag", "tag_weapon_Right");
		flagguy_carrier.walk_noncombatanim	= level.scr_anim["flagwaver"]["run"];
		flagguy_carrier.walk_noncombatanim2	= level.scr_anim["flagwaver"]["run"];
		flagguy_carrier.run_noncombatanim	= level.scr_anim["flagwaver"]["run"];
		flagguy_carrier.run_combatanim		= level.scr_anim["flagwaver"]["run"];
		flagguy_carrier.walk_combatanim		= level.scr_anim["flagwaver"]["run"];
	
		while (distance (flagguy_carrier.origin,flagnode_carrier.origin) > 10)
			waitframe();
	
		flagguy_carrier thread waver_loop(flagnode_carrier);
		wait 7;
	}

	if (level.missionfailed)
		return;

	if (isalive (level.player))
	{
		setcvar("nextmap", "map credits");
		setcvar("g_lastsavegame", "");
		setcvar("beat_the_game", "I_sure_did");
		cinematic("cod_end.roq");
	}
}

waver_loop(node)
{
	while (1)
	{
		self animscripted("waveanimdone", node.origin, node.angles, level.scr_anim["flagwaver"]["wave"]);
		self waittillmatch ("waveanimdone","end");
	}
}

first_spawners()
{
	firstspawner = getentarray ("firstspawners","targetname");
	level waittill ("Spawn_First_Spawners");
	for (i=0;i<firstspawner.size;i++)
		if (isdefined (firstspawner[i]))
			firstspawner[i] dospawn();
}

friendly_tanks_setup()
{
	friendlytank1 = getentarray ("friendlytank1","targetname");
	friendlytank2 = getentarray ("friendlytank2","targetname");
	level.tanktarget = getentarray ("tanktarget","targetname");
	level.tanktarget2 = getentarray ("tanktarget2","targetname");

	for (i=0;i<friendlytank1.size;i++)
		if (isdefined (friendlytank1[i]))
		{
			friendlytank1[i] maps\_t34::init_friendly();
			friendlytank1[i] thread friendly_tanks_cantdie();
			friendlytank1[i] thread friendly_tanks_think(1);
			friendlytank1[i] thread tank_paths();
		}

	for (i=0;i<friendlytank2.size;i++)
		if (isdefined (friendlytank2[i]))
		{
			friendlytank2[i] maps\_t34::init_friendly();
			friendlytank2[i] thread friendly_tanks_cantdie();
			friendlytank2[i] thread friendly_tanks_think(2);
			friendlytank2[i] thread tank_paths();
		}

	thread friendly_tanks_trigger();
}

friendly_tanks_cantdie()
{
	self endon ("StopCantDie");
	while (1)
	{
		self waittill ("damage");
		self.health  = (500000);
	}
}

friendly_tanks_trigger()
{
	getent ("starttanks","targetname") waittill ("trigger");
	level notify ("HoldLine");
	wait 20;
	level notify ("Tanks Comming Soon");
	wait 10;
	level notify ("Start_Tanks");
	wait (20);
	level notify ("Tanks_Arrived");
}

friendly_tanks_think(wave)
{
	self endon ("death");
	level waittill ("Start_Tanks");
	if (isdefined (wave))
	{
		if (wave == 2)
			wait (randomint(5));
		if (wave == 2)
			wait (10 + randomint(5));
	}
	path = getVehicleNode (self.target,"targetname");
	self attachpath(path);
	self startpath();
	self thread friendly_tanks_shoot();
	thread final_mg42ers_start();
	wait 5;
	self notify ("StopCantDie");
	self.health = (2500);

	self thread friendly_tanks_goal();
	self thread friendly_tanks_goal_timeout();
}

friendly_tanks_goal()
{
	self endon ("stopped");
	self endon ("death");
	self waittill ("reached_end_node");
}

friendly_tanks_goal_timeout()
{
	self endon ("death");
	wait (25);
	self notify ("stopped");
}

friendly_tanks_shoot()
{
	last_targetnum = (level.tanktarget.size + 1);
	last_targetnum2 = (level.tanktarget2.size + 1);
	while (isalive (self))
	{
		
		targetnum = randomint(level.tanktarget.size);
		while (targetnum == last_targetnum)
			targetnum = randomint(level.tanktarget.size);
		
		last_targetnum = (targetnum);
		target = ( level.tanktarget[targetnum] );
		
		self setTurretTargetEnt( (target), (0, 0, 64) );
		wait 3;
		delay = (2 + randomfloat(2));
		wait (delay);
		self clearTurretTarget();
		self thread maps\_t34::fire();
		target playsound ("explo_rock");
		
		if ( (isdefined (target.script_noteworthy)) && (target.script_noteworthy == "damage") )
		{
			radiusDamage (target.origin, 256, 400, 25);
		}

		delay = (2 + randomfloat(2));
		wait (delay);
	}
}

tankbust()
{
	before 		= getentarray ("tankbust_before","targetname");
	after 		= getentarray ("tankbust_after","targetname");
	fxmodel 	= getentarray ("tankbust_fx","targetname");

	for (i=0;i<fxmodel.size;i++)
	if (isdefined (fxmodel[i]))
		fxmodel[i] hide();

	for (i=0;i<after.size;i++)
		after[i] hide();

	getent ("tankbust_trigger","targetname") waittill ("trigger");
	
	for (i=0;i<after.size;i++)
		after[i] show();

	for (i=0;i<fxmodel.size;i++)
	if (isdefined (fxmodel[i]))
		fxmodel[i] thread maps\_utility::cannon_effect(fxmodel[i]);

	for (i=0;i<before.size;i++)
		before[i] delete();
}

berlin_fx()
{
	berlin_fx0 = getentarray ("berlin_fx0","targetname");
	berlin_fx1 = getentarray ("berlin_fx1","targetname");
	berlin_fx2 = getentarray ("berlin_fx2","targetname");

	for (i=0;i<berlin_fx0.size;i++)
		berlin_fx0[i] thread playfx_thread(berlin_fx0[i].script_fxid, berlin_fx0[i].origin, 0.3);

	while (1)
	{
		level waittill ("FXTransition");

		if (level.flags["FX1"] == true)
			for (i=0;i<berlin_fx1.size;i++)
				berlin_fx1[i] thread playfx_thread(berlin_fx1[i].script_fxid, berlin_fx1[i].origin, 0.3);
		else
			for (i=0;i<berlin_fx1.size;i++)
				berlin_fx1[i] notify ("stopfx");

		if (level.flags["FX2"] == true)
			for (i=0;i<berlin_fx2.size;i++)
				berlin_fx2[i] thread playfx_thread(berlin_fx2[i].script_fxid, berlin_fx2[i].origin, 0.3);
		else
			for (i=0;i<berlin_fx2.size;i++)
				berlin_fx2[i] notify ("stopfx");
	}
}

playfx_thread(fxId, fxPos, ignore, ignore2)
{
	self endon ("stopfx");
	while (1)
	{
		playfx (level._effect[fxId], fxPos);
		wait (.3);
	}
}

berlin_fx_triggers_setup()
{
	berlin_fx_inarea1 = getent ("berlin_fx_inarea1","targetname");
	berlin_fx_inarea1 thread maps\_utility::triggerOff();
	thread berlinfx_inarea1();
}

berlinfx_inarea1()
{
	trig = getent ("berlin_fx_inarea2","targetname");
	trig waittill ("trigger");
	level notify ("FXTransition");

	trig thread maps\_utility::triggerOff();
	level.flags["FX1"] = false;
	level.flags["FX2"] = true;
	getent ("berlin_fx_inarea1","targetname") thread maps\_utility::triggerOn();

	thread berlinfx_inarea2();
}

berlinfx_inarea2()
{
	trig = getent ("berlin_fx_inarea1","targetname");
	trig waittill ("trigger");
	level notify ("FXTransition");
	trig thread maps\_utility::triggerOff();
	level.flags["FX1"] = true;
	level.flags["FX2"] = false;
	getent ("berlin_fx_inarea2","targetname") thread maps\_utility::triggerOn();

	thread berlinfx_inarea1();
}

tank_paths()
{
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

intro()
{
	thread first_spawners();
	level waittill ("finished final intro screen fadein");
	level notify ("FXTransition");
	thread opening_dialogue();
	level waittill ("starting final intro screen fadeout");
	level notify ("Spawn_First_Spawners");
}

opening_dialogue()
{
	soundents = getentarray ("opening_shouts","targetname");

	soundents[0] playsound ("berlin_russian5_victorydeath");
	wait 2;
	soundents[1] playsound ("berlin_russian1_ontoreichstag");
	wait 2;
	soundents[2] playsound ("berlin_russian3_deathtofascists");
	wait 2;
	soundents[3] playsound ("berlin_russian1_noretreat");
}

dialogue1()
{
	getent ("dialogue1","targetname") waittill ("trigger");
	thread dialogue2();
	guy = maps\_utility::getClosestAI (level.player getorigin(), "allies" );
	if (isdefined (guy))
		guy thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][0], "berlin_russian4_needtogetflaks", 1.0);
}

dialogue2()
{
	getent ("dialogue2","targetname") waittill ("trigger");
	thread dialogue3();
	guy = maps\_utility::getClosestAI (level.player getorigin(), "allies" );
	if (isdefined (guy))
		guy thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][1], "berlin_russian3_letsgetthenextone", 1.0);
}

dialogue3()
{
	level waittill ("bomb_trigger exploded");
	wait 1;
	guy = maps\_utility::getClosestAI (level.player getorigin(), "allies" );
	if (isdefined (guy))
		guy thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][2], "berlin_russian1_tothenextgun", 1.0);
}

dialogue4()
{
	thread dialogue6();
	guy = maps\_utility::getClosestAI (level.player getorigin(), "allies" );
	if (isdefined (guy))
	{
		guy thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][3], "berlin_russian4_holdtheline", 1.0);
		excluders[0] = guy;
		thread dialogue5(excluders);
	}
	else
		thread dialogue5();
}

dialogue5(excl)
{
	level waittill ("Tanks Comming Soon");
	if ( (isdefined (excl)) && (isdefined (excl[0])) )
		guy = maps\_utility::getClosestAI (level.player getorigin(), "allies", excl );
	else
		guy = maps\_utility::getClosestAI (level.player getorigin(), "allies");

	if (isdefined (guy))
		guy thread maps\_utility::magic_bullet_shield();
		node = getnode("auto304","targetname");
		guy.goalradius = 8;
		guy setgoalnode (node);
		guy waittill ("goal");
			guy.scripted_dialogue = ("berlin_russian2_untiltanksthru");
			guy.facial_animation = (level.scr_anim["face"][4]);
			guy animscripted("animdone", guy.origin, (node.angles + (0,180,0)), level.scr_anim["body"]["waitfortanks"]);
			guy waittill ("scripted_anim_facedone");
		guy notify ("stop magic bullet shield");
		guy setgoalentity (level.player);
}

dialogue_totheReichstag()
{
	guy = maps\_utility::getClosestAI (level.player getorigin(), "allies" );
	if (isdefined (guy))
		guy thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][6], "berlin_russian2_forwardreichstag", 1.0);
	wait 2;
	excluders = [];
	if (isdefined (guy))
		excluders[0] = guy;
	if (isdefined (excluders[0]))
		guy = maps\_utility::getClosestAI (level.player getorigin(), "allies", excluders);
	else
		guy = maps\_utility::getClosestAI (level.player getorigin(), "allies");

	if (isdefined (guy))
		guy thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][7], "berlin_russian3_downwithfascism", 1.0);

	wait 5;
	guy = maps\_utility::getClosestAI (level.player getorigin(), "allies" );
	if (isdefined (guy))
		guy thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][5], "berlin_russian1_comeonletsgo", 1.0);

	wait 2;
	if (isdefined (guy))
		excluders[0] = guy;
	if (isdefined (excluders[0]))
		guy = maps\_utility::getClosestAI (level.player getorigin(), "allies", excluders);
	else
		guy = maps\_utility::getClosestAI (level.player getorigin(), "allies");

	if (isdefined (guy))
		guy thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][9], "berlin_russian4_supresswindows", 1.0);

}

dialogue6()
{
	getent ("dialogue3","targetname") waittill ("trigger");
	thread dialogue7();
	guy = maps\_utility::getClosestAI (level.player getorigin(), "allies" );
	if (isdefined (guy))
		guy thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][10], "berlin_russian1_uptotherooftop", 1.0);

	wait 4;
	excluders = [];
	if (isdefined (guy))
		excluders[0] = guy;
	if (isdefined (excluders[0]))
		guy = maps\_utility::getClosestAI (level.player getorigin(), "allies", excluders);
	else
		guy = maps\_utility::getClosestAI (level.player getorigin(), "allies");

	if (isdefined (guy))
		guy thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][8], "berlin_russian3_watchoutgetdown", 1.0);
}

dialogue7()
{
	getent ("dialogue4","targetname") waittill ("trigger");
	guy = maps\_utility::getClosestAI (level.player getorigin(), "allies" );
	if (isdefined (guy))
		guy thread animscripts\face::SaySpecificDialogue(level.scr_anim["face"][11], "berlin_russian2_flagtoroof", 1.0);
}