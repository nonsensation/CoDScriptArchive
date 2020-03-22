#using_animtree("generic_human");
main()
{

	precacheShellshock("default");
	setcvar("introscreen","1");
	mort = getent ("mortar attack","targetname");
//    level.mortar = loadfx ("fx/surfacehits/mortarImpact.efx");
//	level._effect["mortar"] = loadfx ("fx/impacts/dirthit_mortar.efx"); // "fx/impacts/beach_mortar.efx"
//	level._effect["mortar"] = loadfx ("fx/impacts/newimps/blast_gen3.efx");
	level._effect["mortar"] = loadfx ("fx/impacts/newimps/dirthit_mortar2daymarked.efx");
	level.mortar = level._effect["mortar"];
	thread ai_overrides();
	maps\_load::main();
	maps\_tank::main();
	maps\_mortarteam::main();
	maps\_panzerIV::main_camo();
	maps\_tiger::main_camo();
	maps\dawnville_anim::main();
	weapon = level.player getcurrentweapon();

/*	
	while (1)
	{
		newweapon = level.player getcurrentweapon();
		
		if (newweapon != weapon)
		{
			weapon = newweapon;
			println ("Player weapon is ", weapon);
		}
		wait (0.05);
	}
*/

//	gun = spawn ("FG42", (0,0,0));
//	gun = spawn ("weapon_FG42", (0,0,0));
	
	maps\dawnville_fx::main();
	level.ambient_track ["exterior"] = "ambient_dawnville";
	level.ambient_track ["interior"] = "ambient_dawnville_int";
	thread maps\_utility::set_ambient("exterior");
	precacheturret("mg42_tiger_tank");
	precacheItem("panzerfaust");

	maps\_utility::chain_off ("500");
	maps\_utility::chain_off ("450");
	maps\_utility::chain_off ("460");
	maps\_utility::chain_off ("125");
	chain = get_friendly_chain_node ("50");
	level.player SetFriendlyChain (chain);


	level._effect["treads_sand"] 	= loadfx ("fx/tagged/tread_dust_brown.efx");
	level._effect["treads_grass"] 	= loadfx ("fx/tagged/tread_dust_brown.efx");
	level._effect["treads_dirt"] 	= loadfx ("fx/tagged/tread_dust_brown.efx");
	level._effect["treads_rock"] 	= loadfx ("fx/tagged/tread_dust_brown.efx");

	character\moody::precache();
	character\foley::precache();
	character\elder::precache();

//	precachemodel("xmodel/vehicle_tank_tiger_d");
//	precachemodel("xmodel/vehicle_tank_PanzerIV_d");
//	precacheModel("xmodel/head_blane");  //head for script dieing models
	precacheModel("xmodel/ammo_panzerfaust_box2");
	precacheModel("xmodel/weapon_panzerfaust");
	precacheModel("xmodel/vehicle_tank_panzeriv_machinegun");
	precacheModel("xmodel/character_moody");
	precacheModel("xmodel/head_moody");
	precacheModel("xmodel/character_elder");
	precacheModel("xmodel/head_elder");
	precacheModel("xmodel/dawnville_map");
	precacheModel("xmodel/dawnville_pencil");
	precacheModel("xmodel/vehicle_car");

//	maps\dawnville_anim::main();
//	maps\dawnville_export::main();

//	fogvars ( 1.4 1.4 1.4  ) 16500

	level.scr_anim["generic"]["explode death up"] = %death_explosion_up10;
	level.scr_anim["generic"]["explode death back"] = %death_explosion_back13;			// Flies back 13 feet.
	level.scr_anim["generic"]["explode death forward"] = %death_explosion_forward13;
	level.scr_anim["generic"]["explode death left"] = %death_explosion_left11;
	level.scr_anim["generic"]["explode death right"] = %death_explosion_right13;

	level.scr_anim["generic"]["knockdown back"] = %stand2prone_knockeddown_back;
	level.scr_anim["generic"]["knockdown forward"] = %stand2prone_knockeddown_forward;
	level.scr_anim["generic"]["knockdown left"] = %stand2prone_knockeddown_left;
	level.scr_anim["generic"]["knockdown right"] = %stand2prone_knockeddown_right;
	level.scr_anim["generic"]["getup"]				= (%scripted_standwabble_A);

//	Initial level flags:
	level.flag["west tank finished moving"] = false;
	level.flag["west tank destroyed"] = false;
	level.flag["east tank finished moving"] = false;
	level.flag["east tank destroyed"] = false;
	level.flag["northeast tank finished moving"] = false;
	level.flag["northeast tank destroyed"] = false;
	level.flag["mortars stop"] = false;
	level.flag["got panzers"] = false;
	level.flag["church has been defended"] = false;
	level.flag["player is at church"] = false;
	level.flag["foley moves on"] = false;
	level.flag["west tank attacks"] = false;
	level.flag["friendlies report to the car"] = false;
	level.flag["player got in car"] = false;
	level.flag["moody exists"] = false;
	level.flag["elder exists"] = false;
	level.flag["falling back"] = false;
	level.flag["parker speech"] = false;
	level.flag["church under siege"] = false;
	level.flag["parker is a go"] = false;
	level.flag["chain 100 off forever"] = false;
	level.flag["chain 125 off forever"] = false;
	level.flag["Friendlies crouch for conference"] = false;

//	Initial array_threading:
	array_levelthread (getentarray ("delete","targetname"), ::delete_this);
	array_thread (getVehicleNodeArray ("tank","targetname"), ::tank_think);

//	Initial threads, not array threaded:
	thread mortar_init();
	thread shoot_tank(getent ("shoot_tank","targetname"));
	thread second_flak_early_trigger(getent ("second flak early trigger","targetname"));

	setCullFog (0, 16500, 0.7, 0.85, 1.0, 0);
	setCullFog (0, 16500, 0.7, 0.85, 1.0, 0);

	// Characters:
	foley = getent ("foley", "targetname");

	foley.animname = "foley";
	foley character\_utility::new();
	foley character\foley::main();
	foley.followMin = 4;
	foley.followMax = 8;
	foley.script_usemg42 = false; // Foley is too cool for MG42s
	foley thread animscripts\shared::SetInCombat(60.0);
	foley.dontFollow = true;

	// Blocks AI from renetering the safehouse later on.
	block = getent ("safehouse block","targetname");
	block connectpaths();
	block notsolid();

	
//	foley animscripted( "single anim", foley.origin, foley.angles, level.scr_anim["foley"]["end"] );
/*
	foley thread anim_single_solo (foley, "end");
	while (1)
	{
		foley waittill ( "single anim", notetrack);
		println ("animation notetrack: ", notetrack, " time ", gettime());
	}
	*/

	// Elder
	thread elder (getent ("elder","targetname"));

	level.player.threatbias = -2;
	level.player.threatbias = 2000000;
	ai = getaiarray ("allies");
	for (i=0;i<ai.size;i++)
		ai[i] setgoalpos (ai[i].origin);

	thread sequence_init();

	if (getcvar ("start") == "whale")
	{
		chain = get_friendly_chain_node ("50");
		level.player SetFriendlyChain (chain);

		thread sequence_3b();
		thread guyFleesTank (getent ("player advances","targetname"));
		clip = getent ("second flak monster clip","targetname");
		clip connectpaths();
		clip delete();

		array_thread(getentarray ("church rear","script_noteworthy"), maps\_utility::triggerOff);
		
		level.player setOrigin ((900, -15045, -24));
		level.flag["west tank finished moving"] = false;
		level.flag["west tank destroyed"] = false;
		level.flag["east tank finished moving"] = true;
		level.flag["east tank destroyed"] = true;
		level.flag["northeast tank finished moving"] = false;
		level.flag["northeast tank destroyed"] = false;
		level.flag["mortars stop"] = true;
		level.flag["got panzers"] = true;
		level.flag["church has been defended"] = true;
		level.flag["player is at church"] = true;

				
		spawner = getent ("moody","script_noteworthy");
		spawner.count = 1;
		spawn = spawner dospawn();
		wait (1);
		spawn setgoalentity (level.player);
		return;
	}

	if (getcvar ("start") == "tank")
	{
//		level.flag["west tank finished moving"] = true;
//		level.flag["west tank destroyed"] = true;
		level.flag["east tank finished moving"] = true;
		level.flag["east tank destroyed"] = true;
		level.flag["northeast tank finished moving"] = true;
		level.flag["northeast tank destroyed"] = true;
		level.flag["mortars stop"] = true;
		level.flag["got panzers"] = true;
		level.flag["church has been defended"] = true;
		level.flag["player is at church"] = true;
		level.flag["foley moves on"] = true;
//		level.flag["west tank attacks"] = true;

		chain = get_friendly_chain_node ("50");
		level.player SetFriendlyChain (chain);
		level.player setOrigin ((729, -16475, 72));
		level notify ("tank start west");
		wait (1);
		thread tank_west_trigger( getent ("last tank attacks","targetname") );
		thread sequence_4();

		/*
		spawners = getentarray ("end allies","targetname");
		for (i=0;i<spawners.size;i++)
		{
			spawn = spawners[i] stalingradspawn();
			if (spawn.script_friendname == "Moody")
			{
				spawn character\_utility::new();
				spawn character\moody::main();
			}
			else
			{
				spawn character\_utility::new();
				spawn character\elder::main();
			}
		}
		*/
		spawner = getent ("moody","script_noteworthy");
		spawner.count = 1;
		spawn = spawner dospawn();
		wait (1);
		spawn setgoalentity (level.player);
		return;
	}

	thread sequence_1();

	wait (10);
}


ai_overrides()
{
	spawners = getspawnerteamarray("allies");
	for (i=0;i<spawners.size;i++)
		spawners[i] thread spawner_overrides();

	ai = getaiarray("allies");
	for (i=0;i<ai.size;i++)
		ai[i].bravery = 500000;
		
	if (getcvar ("scr_dawnville_fast") == "1")
	{
		for (i=0;i<ai.size;i++)
		{
			if (!isdefined (ai[i].script_dawnville_fast))
				continue;
			if (ai[i].script_dawnville_fast != 2)
				continue;
				
				ai[i] DoDamage ( 1500, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
		}
	}
}

spawner_overrides()
{
	if (getcvar ("scr_dawnville_fast") == "1")
	{
		if ((isdefined (self.script_dawnville_fast)) && (self.script_dawnville_fast == 2))
		{
			self delete();
			return;
		}
	}
	
	while (1)
	{
		self waittill ("spawned", spawned);
		wait (0.05);
		if (issentient (spawned))
			spawned.bravery = 500000;
	}
}

delete_this (ent)
{
	ent delete();
}

wait_until_no_axis (trigger)
{
	while (1)
	{
		ai = getaiarray ("axis");
		breaker = true;
		for (i=0;i<ai.size;i++)
		{
			if (ai[i] istouching (trigger))
				breaker = false;
		}

		if (breaker)
		{
			wait (5);
			ai = getaiarray ("axis");
			for (i=0;i<ai.size;i++)
			{
				if (ai[i] istouching (trigger))
					breaker = false;
			}
		}

		if (breaker)
			break;

		wait (2.5);
	}
}

// Various functions for doing mortars near the player
mortar_init ()
{
	level.mortarTime = 5000;
	mortars = getentarray ("mortar spot","targetname");
	for (i=0;i<mortars.size;i++)
	{
		mortars[i].usedTime = 0;
	}
}

mortar_closest ()
{
	mortars = getentarray ("mortar spot","targetname");
	index = 0;
	dist = distance (level.player.origin, mortars[index].origin);
	currentTime = gettime();
	indexSecondClosest = -1;
	for (i=0;i<mortars.size;i++)
	{
		if (mortars[i].usedTime > currentTime)
			continue;

		newdist = distance (level.player.origin, mortars[i].origin);
		if (newdist < 650)
			continue;

		if (newdist > dist)
			continue;

		indexSecondClosest = index;
		index = i;
		dist = newdist;
	}

	if (indexSecondClosest == -1)
		return undefined;

	mortars[index].usedTime = currentTime + level.mortarTime;
	return mortars[index];
}

mortar_killplayer ()
{
	thread playSoundinSpace ("mortar_incoming", level.player.origin);
	wait (0.4);
	thread playSoundinSpace ("mortar_explosion", level.player.origin);
	playfx (level._effect["mortar"], level.player.origin);
	radiusDamage (level.player.origin, 2000, 2000, 0); // mystery numbers!
	earthquake(0.3, 3, level.player.origin, 850); // scale duration source radius
}

mortar_nearplayer ()
{
	mortar = mortar_closest();
	if (!isdefined (mortar))
		return;

	mortar_explosion (mortar);
}

mortar_explosion (mortar)
{
	mortar playsound ("mortar_incoming", "sounddone");
	mortar waittill ("sounddone");
	mortar playsound ("mortar_explosion");
	playfx (level._effect["mortar"], mortar.origin + (0,0,-76)); // Lower into ground MORE -32
	radiusDamage (mortar.origin, 200, 200, 0); // mystery numbers!
	earthquake(0.3, 3, mortar.origin, 850); // scale duration source radius
	level notify ("mortars ongoing HIT");
}

mortar_explosion_prehit (mortar)
{
	wait randomfloat(0.5);
	mortar_explosion (mortar);
}

mortar_drop_on_axis ()
{
	array_levelthread (getentarray ("mortar automatic","targetname"), ::mortar_explosion_prehit);
}

mortar_drop_nearplayer ()
{
	for (i=0;i<3;i++)
	{
		mortar_nearplayer();
		wait (randomfloat (3));
	}
}

mortar_ongoing ()
{
	level notify ("mortars ongoing STOP");
	level endon ("mortars ongoing STOP");
	while (1)
	{
		mortar_nearplayer();
		wait (3 + randomfloat (5));
	}
}

player_mortar_death ( trigger )
{
	level endon ("mortars stop");
	trigger waittill ("trigger");
	mortar_killplayer();
}

turnChurchMG42backOn ()
{
	flag_wait ("player is at church");
	array_thread(getentarray ("church rear","script_noteworthy"), maps\_utility::triggerOn);
}

second_flak_early_trigger ( trigger )
{
	targets = getentarray (trigger.target,"targetname");
	array_levelthread (targets, ::second_flak_spawner);
	level waittill ("kill second flak early trigger");
	trigger delete();
}

second_flak_spawner ( spawner )
{
	level endon ("kill second flak early trigger");
	if (isdefined (spawner.target))
		return;

	spawner waittill ("spawned", spawn);
	if (spawn.team != "axis")
		return;

	spawn endon ("death");
	wait (0.05);
	spawn setgoalentity (level.player);
	num = 800;
	spawn.goalradius = num;
	while (num > 300)
	{
		num -= 100;
		wait (15);
	}
}

hurtPlayer (trigger)
{
	trigger.deleteself = false;
	while (1)
	{
		while (level.player istouching (trigger))
		{
			level.player DoDamage ( 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
			wait (0.05);
		}
		wait (0.5);
		if (trigger.deleteself)
		{
			trigger delete();
			return;
		}
	}
}

shoot_tank (trigger)
{
	target = getent (trigger.target,"targetname");
	clip = getent (target.target,"targetname");

	clip disconnectpaths();
	// Tank is the tank that hits the trigger leading down the road
	trigger waittill ("trigger",tank);
	trigger delete();
//	tank setTurretTargetEnt( target, ( 0, 0, 50 ) );
//	tank waittill( "turret_on_vistarget" );
//	wait (1);
//	tank FireTurret();
	target delete();
	wait (0.1);

	pushed_tank = getent ("tank_pushed","targetname");
	tankDamage = getent ("tank damage trigger","targetname");
	tankDamage enableLinkto();
	tankDamage linkto (pushed_tank);
	level thread hurtPlayer(tankDamage);
	clip linkto (pushed_tank);

	org = getent (pushed_tank.target,"targetname");
	pushed_tank linkto (org);
	clip connectpaths();
//	org rotateyaw (75, 3.8, 0, 0.8);
	org rotateyaw (75, 5, 0, 0.8);
//	org rotateyaw (75, 1.2, 0, 0.8);
	wait (5);
	tankDamage.deleteself = true;
	clip disconnectpaths();
	tank restart_aim();
	tank waittill ("reached_end_node");
	tank.health = 1000;
	tank thread triggerHintThink(tank.triggerHint);
}

tank_rampage_explode (tank, exploder, trigger)
{
	level endon ("northeast tank destroyed");
	while (1)
	{
		self waittill ("trigger",other);
		if (other == tank)
			break;
	}
	thread maps\_utility::exploder	(exploder);
	level notify ("stop rampage " + exploder);
	trigger notify ("destroyed");
//	println ("^bstopping rampage ", exploder);
}

guyFleesTank (trigger)
{
	spawner = getent (trigger.target,"targetname");
	spawner waittill ("spawned",spawn);
	if (maps\_utility::spawn_failed(spawn))
		return;

	spawn endon ("death");
	node = getnode (spawn.target,"targetname");
	spawn setgoalpos (spawn.origin);
	spawn.goalradius = 4;
	level waittill ("tank start northeast");
	
	spawn thread bloody_death_waittill();
	spawn.health = 1;
	wait (0.5);
	tank = getent ("tank northeast","targetname");
	if (!isdefined(tank))
	{
		spawn setgoalentity (level.player);
		return;
	}
	
	spawn maps\_utility::lookat(tank);
	spawn setgoalnode (node);
	node = getnode (node.target,"targetname");
	wait (1);
	spawn setgoalnode (node);
	node = getnode (node.target,"targetname");
	wait (1.5);
	spawn setgoalnode (node);
	level thread playSoundinSpace ("weap_kar98k_fire", spawn.origin);
	spawn DoDamage ( spawn.health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
}

isTanktouching ( ent )
{
	org = spawn ("script_origin",self.origin);
	org.origin = self.origin + (0,0,60);

	if (org istouching (ent))
		answer = true;
	else
		answer = false;

	org delete();

	return answer;
}

tempPlayerKill ( trigger )
{
	level endon ("northeast tank destroyed");
	trigger waittill ("trigger");
	//iprintlnbold ("THE TANK KILLED YOU WITH HIS MAGIC MACHINE GUN!");
	level.player DoDamage ( level.player.health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );

}

tank_rampage_trigger ( tank )
{
	level endon ("northeast tank destroyed");
	level endon ("stop rampage " + self.script_noteworthy);
//	println ("^brampage stopper is ", self.script_noteworthy);
	damage_trigger = getent (self.target,"targetname");
	org = getent (damage_trigger.target,"targetname");

	level.rampage_done[self.target] = true;

	tankTrigger = getentarray ("tank rampage includer","targetname");
	for (i=0;i<tankTrigger.size;i++)
	{
		if (tankTrigger[i].script_noteworthy == self.script_noteworthy)
		{
			tankTrigger = tankTrigger[i];
			break;
		}
	}

	damage_trigger thread tank_rampage_explode(tank, self.script_noteworthy, self);
	self endon ("destroyed");
	tank = getent ("tank northeast","targetname");
	if (!isalive (tank))
		return;

	tank endon ("death");
	while (1)
	{
		self waittill ("trigger");
		if (!tank isTanktouching (tankTrigger))
			continue;

		level.rampage_index = self.target;
		level.rampage_org = org;
		level.rampageTrigger = self;
		level notify ("got rampage trigger");
	}
}

tank_rampage()
{
	self endon ("death");
	// These triggers make the northeast tank shoot at the player
	array_thread(getentarray ("tank rampage","targetname"), ::tank_rampage_trigger, self);
	ref = getent ("gate reference","targetname");
	offset = 50;
	while (1)
	{
		level waittill ("got rampage trigger");
		self notify ("stop wanderaiming");
		rampageTrigger = level.rampageTrigger;
		if ((self.origin[0] < ref.origin[0] + offset) && (self.origin[0] > ref.origin[0] - (offset)))
		{
			println ("was too close to gate to be able to shoot");
			continue;
		}
		

		targetOrigin = level.rampage_org.origin;
		self setTurretTargetEnt( level.rampage_org, ( 0, 0, 50 ) );
		self waittill( "turret_on_target" );
		self FireTurret();
		self thread tank_rampage_wanderaim();

		// Shell shock the player for standing near the explosion.
//		if ((rampageTrigger == level.rampageTrigger) && (level.player istouching (rampageTrigger)))
		wait (0.1);

		if ((rampageTrigger != level.rampageTrigger) || (distance (level.player.origin, targetOrigin) > 250))
			continue;
			
		if (isdefined (level.playerShellShocked_Dawnville))
			continue;
			
		maps\_shellshock::main(8);
		level.playerShellShocked_Dawnville = true;
	}
}

tank_rampage_wanderaim_org (tank)
{
	waittill_either (tank, "death","stop wanderaiming");
	self delete();
}

rangeVec (range)
{
	return ((randomint (range) - range*0.5, randomint (range) - range*0.5, randomint (range) - range*0.5));
}

tank_rampage_wanderaim ()
{
	self endon ("death");
	self notify ("stop wanderaiming");
	self endon ("stop wanderaiming");
	org = spawn ("script_origin",(0,0,0));
	org thread tank_rampage_wanderaim_org(self);
	wait (2);
	
	while (1)
	{
		org.origin = level.rampage_org.origin + rangeVec(200);
		self setTurretTargetEnt( org, ( 0, 0, 50 ) );
		self waittill( "turret_on_target" );
		wait (1 + randomfloat(2));
	}
}

getUnusedAttackNode ( nodes )
{
	for (i=0;i<nodes.size;i++)
	{
		if (isdefined (nodes[i].usedForAttack))
			continue;

		nodes[i].usedForAttack = true;
		return nodes[i];
	}

	return undefined;
}

player_attackers_reroute ()
{
	level waittill ("new tank guard nodes");
	node = getUnusedAttackNode (level.tank_guard_nodes);

	if (isdefined(node))
	{
		self setgoalnode (node);
		self.goalradius = node.radius;
	}
}

player_attackers_spawner ()
{
	self.count = 1;
	spawn = self dospawn();
	if (maps\_utility::spawn_failed(spawn))
		return;

	if (isdefined (level.tank_guard_nodes))
		node = getUnusedAttackNode (level.tank_guard_nodes);

	if (isdefined(node))
	{
		spawn setgoalnode (node);
		spawn.goalradius = node.radius;
	}
	else
	{
		spawn setgoalentity (level.player);
		spawn.goalradius = 340;
	}

	level.player_attackers++;
	spawn thread player_attackers_reroute();
	spawn waittill ("death");
	if (isdefined (node))
		node.usedForAttack = undefined;

	level.player_attackers--;
	level notify ("player attacker died");
}

player_attackers_spawnAgain ( trigger, spawners )
{
	trigger waittill ("trigger");
	array_thread(spawners, ::player_attackers_spawner);
}

player_attackers ()
{
	level endon ("northeast tank destroyed");
	
	level.player_attackers = 0;
	spawners = getentarray ("attack player","targetname");
	trigger = getent ("player attack trigger","targetname");
	wait (5);
	array_thread(spawners, ::player_attackers_spawner);
	array_levelthread(getentarray ("tank defenders attack","targetname"), ::player_attackers_spawnAgain, spawners);
	
	/*
	while (1)
	{
		if (level.player_attackers > 2)
			level waittill ("player attacker died");
		else
			wait (1);

		if (level.player_attackers <= 3)
			array_thread(spawners, ::player_attackers_spawner);

		while (level.player istouching (trigger))
			wait (3);
	}
	*/
}

tank_northeast_guard ( trigger )
{
	trigger waittill ("trigger");
	level.tank_guard_nodes = getnodearray (trigger.target,"targetname");
	level notify ("new tank guard nodes");
	trigger delete();
}

tank_northeast_shoot ()
{
	self endon ("told to move");
	self endon ("death");
	self thread tank_rampage(); // Handles tank shooting at player
	self thread tank_northeast_move();
	array_levelthread (getentarray ("tank guard trigger","targetname"), ::tank_northeast_guard);
	thread player_attackers();
	trigger = getent ("tank target","targetname");
	trigger waittill ("trigger");
	trigger delete();
	wait (0.5);

	target_trigger = getent ("tank target 1","targetname");
	org = spawn ("script_origin",(0,0,0));
	org.origin = target_trigger getorigin();

	self setTurretTargetEnt( org, ( 0, 0, 50 ) );
	wait (3);
	self waittill( "turret_on_vistarget" );
	self FireTurret();
	wait (0.1);
	maps\_utility::exploder(target_trigger.script_noteworthy);
	radiusDamage (org.origin, 400, 500, 0);
	target_trigger delete();
	org delete();

	target_trigger = getent ("tank target 2","targetname");
	org = spawn ("script_origin",(0,0,0));
	org.origin = target_trigger getorigin();

	self setTurretTargetEnt( org, ( 0, 0, 50 ) );
	wait (3);
	self waittill( "turret_on_vistarget" );
	self FireTurret();
	wait (0.1);
	maps\_utility::exploder(target_trigger.script_noteworthy);
	radiusDamage (org.origin, 400, 500, 0);

	target_trigger delete();
	org delete();
	
	self setTurretTargetEnt( getent ("new gun target","targetname")	, ( 0, 0, 50 ) );
}

tank_northeast_move ()
{
	self endon ("death");
	self endon ("told to move");
	thread tank_northeast_restart_move();
	stopnode = getvehiclenode ("tank stop node","targetname");
	self setwaitnode (stopnode);
	self waittill ("reached_wait_node");
	self.nospawning = false;
	self setSpeed(0,30);
	self disconnectpaths();
}

tank_northeast_restart_move ()
{
	self endon ("death");
	trigger = getent ("tank move","targetname");
	trigger waittill ("trigger");
	foley = getent ("foley","targetname");
	foley.followMin = 5;
	foley.followMax = -5;
	
	self setTurretTargetEnt( getent ("new gun target","targetname")	, ( 0, 0, 50 ) );
	self notify ("told to move");

	self endon ("player reached second go point");
	thread tank_northwest_restart_2nd();
	self resumespeed(10);
//	self notify ("start
	self connectpaths();

	stopnode = getvehiclenode (trigger.target,"targetname");
	self setwaitnode (stopnode);
	self waittill ("reached_wait_node");
	self setSpeed(0,30);
	self disconnectpaths();
}

tank_northwest_restart_2nd ()
{
	self endon ("death");
	trigger = getent ("tank move 2","targetname");
	trigger waittill ("trigger");
	self notify ("player reached second go point");


	self resumespeed(30);
	self connectpaths();

	self thread restart_aim();
//	target_trigger delete();
//	org delete();

	trigger = getent ("gate","targetname");
	trigger waittill ("trigger");
	trigger delete();
	gate_left = getent ("gate left","targetname");
	gate_right = getent ("gate right","targetname");
	gate_left connectpaths();
	gate_right connectpaths();

	gate_left playsound (level.scr_sound["tank gatecrash"]);

	gate_left rotatepitch (-85, 0.6, 0, 0.4);
	gate_right rotatepitch (-85, 0.6, 0, 0.4);
	gate_left notsolid();
	gate_right notsolid();
	self waittill ("reached_end_node");
	self disconnectpaths();
}

restart_aim ()
{
	org = spawn ("script_model",(0,0,0));
//	org setmodel ("xmodel/temp");
	angles = anglesToForward (self.angles);
	dest = maps\_utility::vectorScale (angles, 300);
	org.origin = self.origin + dest + (0,0,45);
	org linkto (self);
	self setTurretTargetEnt( org, ( 0, 0, 50 ) );
	self waittill( "turret_on_vistarget" );
	self clearturrettarget();
	org delete();
}

tank_west_escort ( spawner )
{
	spawner.count = 1;
	spawn = spawner dospawn();
	if (maps\_utility::spawn_failed(spawn))
		return;

	spawn setgoalentity (level.player);
	spawn.goalradius = 1024 + randomint (200);
}

tank_west_think ( tank )
{
	stopnode = getvehiclenode ("tank halt","targetname");
	tank setwaitnode (stopnode);
	thread tank_killers(); // Prep the guys that jump on the west tank
	tank waittill ("reached_wait_node");
	
//	if (!flag("northeast tank destroyed"))
	{
		tank setSpeed(0,3000);
		wait (0.1);
	}

	flag_wait ("northeast tank destroyed");
//	flag_wait ("west tank attacks");
//	tank setSpeed(15,0.2);
	tank setSpeed(15,0.8); // 1
	tank waittill ("reached_end_node");
}

tank_west_trigger ( trigger )
{
	wait (0.01);
	level thread tank_west_think ( getent ("tank west","targetname"));
	trigger waittill ("trigger");
	flag_set ("west tank attacks");
	
}

tank_think ()
{
	while (1)
	{
		level waittill ("tank start " + self.script_noteworthy);
		thread tank_start();
	}
}

tank_end_events( tank )
{
	level waittill ("west tank finished moving");
	if (self.script_noteworthy == "west")
	{
		clip = getent ("west tank clip","targetname");
		clip connectpaths();
		clip delete();
		tank disconnectpaths();
	}
}

tank_death_event ( tank )
{
//	level endon (tank.script_noteworthy + " tank finished moving");
	num = tank.script_noteworthy;
	level.flag[num + " tank finished moving"] = false;
	level.flag[num + " tank destroyed"] = false;


	tank waittill ("death");
		
	if (!flag (num + " tank finished moving"))
		flag_set (num + " tank finished moving");

	flag_set (num + " tank destroyed");

	if (num == "west")
	{
		org = tank.origin;	
		wait (0.05);
		maps\_utility::scriptedRadiusDamage ( org, 450 );
	}
}

// Prints hint if you attack tanks with the wrong weapons
triggerHintThink ( trigger )
{
	trigger enableGrenadeTouchDamage();
	self endon ("death");
	while (1)
	{
		trigger waittill ("trigger", other);
		if (!isdefined (other.classname))
			continue;
		if (other.classname == "worldspawn")
			continue;

		if (other == self)
			continue;
						
		if ((other != level.player) && (other.classname != "grenade"))
			continue;
		wait (0.05);
		println ("^2HIT by ", other.classname, " , ", other);
		//Tanks can not be destroyed by Grenades or Bullets
		iprintlnbold (&"DAWNVILLE_TANKGRENADESBULLETS");
		wait (60);
	}
}

tank_start ()
{
	path = getvehiclenode (self.target,"targetname");
//	tank = spawnVehicle( "xmodel/vehicle_tank_tiger", "tank " + self.script_noteworthy , "tiger", (0,0,0), (0,0,0) );
	if (self.script_noteworthy == "northeast")
		tank = spawnVehicle( "xmodel/vehicle_tank_PanzerIV_camo", "tank " + self.script_noteworthy , "panzerIV", (0,0,0), (0,0,0) );
	else
		tank = spawnVehicle( "xmodel/vehicle_tank_tiger_camo", "tank " + self.script_noteworthy , "tiger", (0,0,0), (0,0,0) );

//	tanker = getent ("tank " + self.script_noteworthy , "targetname");
//	println (tanker.origin);
//	tank maps\_tiger::init("mg42_tiger_tank");
//	tank maps\_panzerIV::init("mg42_tiger_tank");
	triggerHints = getentarray ("tank damage hint","targetname");
	for (i=0;i<triggerHints.size;i++)
	{
		if (triggerHints[i].script_noteworthy == self.script_noteworthy)
		{
			tank.triggerHint = triggerHints[i];
			tank.triggerHint enableLinkto();
			tank.triggerHint linkto (tank,"tag_origin",(0,0,0),(0,0,0));
			break;
		}
	}


	if (self.script_noteworthy == "northeast")
	{
		tank.nospawning = true;
		tank thread maps\_panzerIV::init("mg42_tiger_tank");
	}
	else
		tank thread maps\_tiger::init();

	tank.script_noteworthy = self.script_noteworthy;
	if (self.script_noteworthy == "west")
	{
		clip = getent ("west tank clip","targetname");
		clip disconnectpaths();
	}

	tank.health = 1000;

	if (self.script_noteworthy == "northeast")
	{
		tank thread tank_northeast_shoot();
		tank.health = 100000;
	}

	if (self.script_noteworthy == "west")
		tank.health = 100000;
	else
		tank thread triggerHintThink(tank.triggerHint);

	thread tank_end_events(tank);

	tank endon ("death");
	level thread tank_death_event(tank);
//	thread tank_death(tank);
	tank attachPath( path );
	tank startPath();
	tank thread tank_quake();
	if (self.script_noteworthy == "northeast")
		return;

	tank waittill ("reached_end_node");
	flag_set (self.script_noteworthy + " tank finished moving");

	return;
	wait (1);
	while (1)
	{
		tank setTurretTargetEnt( level.player, ( 0, 0, 50 ) );
		tank waittill( "turret_on_vistarget" );
		tank FireTurret();
		wait (4);
	}
}

escort_think (spawner)
{

	spawner.count = 1;
	spawn = spawner stalingradspawn();

	if (!isdefined (spawn))
		return;

	spawn endon ("death");
	/*
	org = spawn ("script_model",(0,0,3));
	org setmodel ("xmodel/temp");
	if (!isdefined (tank.left))
		tank.left = org;
	else
		tank.right = org;

    forward = anglesToForward(tank.angles);
    forward = maps\_utility::vectorScale (forward, 120);
    right = anglesToRight(tank.angles);
    if (tank.left == org)
    	right = maps\_utility::vectorScale (right, 135);
    else
    	right = maps\_utility::vectorScale (right, -135);

    org.origin = tank.origin + forward + right;
    org linkto (tank);
	spawn.goalradius = 4;
	while (1)
	{
		spawn setgoalpos (org.origin);
		wait (0.05);
	}

	return;
	*/
	spawn.goalradius = 32;

	node = spawn;
	while (isdefined (node.target))
	{
		node = getnode (node.target,"targetname");
		spawn setgoalnode (node);
		spawn waittill ("goal");
	}
}

tank_death(tank)
{
	tank waittill ("death");
	tank delete();
}

tank_quake()
{
	return;
	while (1)
	{
		earthquake(0.1, 0.5, self.origin, 1450); // scale duration source radius
		wait (0.05);
	}
}

player_flak ()
{
	level.player_flak = self;
	self.health  = 1000;
	self endon ("death");
	level thread player_flak_death( self );
	while( 1 )
	{
		self waittill( "turret_fire" );
		self FireTurret();
	}
}

player_flak_death (flak)
{
	flak waittill ("death");
	//THE FLAK IS DESTROYED, MISSION FAILED
	iprintlnbold (&"DAWNVILLE_FLAKDESTROYED");
	wait (2);
	while (1)
	{
		level.player DoDamage ( level.player.health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
		wait randomfloat (0.5);
	}
}

spawn_attack()
{
	self.count = 1;
	spawn = self dospawn();
	if (maps\_utility::spawn_failed(spawn))
		return;
	if (!isdefined (spawn.target))
	{
		println ("Spawner at origin ", self.origin, " had no target");
		return;
	}
	node = getnode (spawn.target,"targetname");
	spawn setgoalnode (node);
	spawn.goalradius = 4;
	spawn waittill ("goal");
	if (isdefined (node.script_radius))
		spawn.goalradius = node.script_radius;	
	else
		spawn.goalradius = 512;
}

spawn_attack_moveup ()
{
	self.count = 1;
	spawn = self dospawn();
	if (maps\_utility::spawn_failed(spawn))
		return;

	spawn endon ("death");
	wait (10);

	node = getnode (spawn.target,"targetname");
	node = getnode (node.target,"targetname");
	spawn setgoalnode (node);
	spawn.goalradius = node.radius;
}

group6_attack ()
{
	self.count = 1;
	spawn = self dospawn();
	if (!isdefined (spawn))
		return;

	spawn endon ("death");
	node = getnode (spawn.target,"targetname");
	spawn.goalradius = 4;
	spawn.oldaccuracy = spawn.accuracy;

	spawn.accuracy = 1;
	spawn.threatbias = -5000;
	spawn setgoalnode (node);
	spawn waittill ("goal");
	spawn.goalradius = 512;
	spawn.accuracy = spawn.oldaccuracy;
	spawn.threatbias = 0;
}

spawn_node_attack (optionalThread)
{
	self.count = 1;
	spawn = self dospawn();
	if (maps\_utility::spawn_failed(spawn))
		return;

	if (isdefined (optionalThread))
		level thread [[optionalThread]](spawn);
	spawn endon ("death");
	spawn.goalradius = 0;
	node = getnode(spawn.target,"targetname");
	spawn setgoalnode (node);
	spawn waittill ("goal");
	if (isdefined (node.radius))
		spawn.goalradius = node.radius;
}

friendly_start ()
{
	self.suppressionwait = 0;
	self.goalradius = 32;
	if (!isdefined (self.target))
		return;

	node = getnode (self.target, "targetname");
	self setgoalnode (node);
//	guy setgoalentity (level.player);
}

player_at_church_trigger ()
{
	trigger = getent ("at church","targetname");

	if (level.player istouching (trigger))
	{
		level notify ("player is at church");
		flag_set ("player is at church");
	}
	else
	{
		level notify ("player is not at church");
		level.flag["player is at church"] = false;
	}

		
	while (1)
	{
		while (level.player istouching (trigger))
			wait (1.5);

		level.flag["player is at church"] = false;
		println (level.player.origin);
		println ("^5 player is NOT at church");
		level notify ("player is not at church");
		trigger waittill ("trigger");

		level.flag["player is at church"] = true;
		println ("^5 player is at church");
		println (level.player.origin);
		level notify ("player is at church");
	}
}

foleyTakeCover ( foley )
{
	wait (3);
	// Tiger tank!!! Take cover!!!
	foley anim_single_solo (foley, "tiger tank");
}

killAIbehindTank ()
{
	flag_wait ("northeast tank destroyed");
	kill_ai_touching (getent ("tank kill axis touching","targetname"), "axis");
}

constant_attack (msg, timer)
{
	timer *= 1000;
	spawners = getentarray ( msg,"targetname");
	timer = gettime() + timer;
	level.spawner_guy_total = 0;

	while (gettime() < timer)
	{
		spawners = maps\_utility::array_randomize(spawners);
		for (i=0;i<spawners.size*0.75;i++)
		{
			if (level.spawner_guy_total > 5)
				level waittill ("spawner guy died");

			wait (randomfloat (3));
			random(spawners) thread spawner_think();
		}
	}
}

secondguy_think ( guy )
{
	if (!isalive (guy))
		println ("SECONDGUY IS DEAD!");

	guy waittill ("death");
	println ("SECONDGUY DIED!");
}

church_flank_think ( node )
{
	self endon ("death");
	self.threatbias = -500;
	level endon ("fallbacker_trigger1");

	self.goalradius = 4;
	self setgoalnode (node);
	self waittill ("goal");

	while (isdefined (node.target))
	{
		node = getnode (node.target,"targetname");
		self setgoalnode (node);
		self waittill ("goal");
		self.grenadeammo = 5;
	}
	//THROW GRENADES NOW
//	iprintlnbold (&"DAWNVILLE_THROWGRENADES");
}

foley_moves_on_trigger ( trigger )
{
	trigger waittill ("trigger");
	flag_set("foley moves on");
}

foley_moves_on_followup ( foley )
{
	flag_wait ("foley moves on");
	foley setgoalentity (level.player);
	foley.goalradius = 384;
}

get_noteworthy_ai ( msg )
{
	ents = getentarray ( msg, "script_noteworthy" );
	for (i=0;i<ents.size;i++)
		if (isalive (ents[i]))
			return ents[i];
}


kill_germans_at_trigger ( msg )
{
	trigger = getent (msg,"targetname");
	ai = getaiarray ("axis");
	for (i=0;i<ai.size;i++)
	{
		if (!ai[i] istouching (trigger))
			continue;

		ai[i] delete();
	}
}

second_flak_think ()
{
	self.count = 1;
	self waittill ("spawned",spawn);
	/*
	spawn = self dospawn("second flak defenders");
	if (!isdefined (spawn))
		return;
	*/

	if (spawn.team != "axis")
		return;

	if (!isdefined (spawn.target))
		return;

	wait (0.01);
	node = getnode (spawn.target,"targetname");
	spawn.suppressionwait = 0;
	spawn setgoalnode (node);
	spawn.goalradius = 4;
	spawn waittill ("goal");
	if (isdefined (node.radius))
		spawn.goalradius = node.radius;
	else
		spawn.goalradius = 128;

	spawn.suppressionwait = 2;
}


spawner_follow_player ()
{
	spawn = self dospawn();
	if (maps\_utility::spawn_failed(spawn))
		return;

	spawn endon ("death");
	spawn setgoalentity (level.player);
	level waittill ("tank start northeast");
	wait (3);
	spawn maps\_spawner::friendly_mg42_stop_use();
	spawn setgoalentity (level.player);
	println ("^5following player B");
}

spawner_death_notify ( guy )
{
	guy waittill ("death");
	level notify ("spawner guy died");
	level.spawner_guy_total--;
}

spawner_think()
{
	level.spawner_guy_total++;
	level thread spawner_death_notify(self);
	self.count = 1;
	spawn = self stalingradspawn();
//	println ("Trying to spawn constant attack guy");
	if (!isdefined (spawn))
		return;
//	println ("Spawned constant attack guy");
}

mortar_hit ( vec )
{
	playSoundinSpace ("mortar_incoming", vec);
	mortar_hit_explosion ( vec );
}

mortar_hit_explosion ( vec )
{
	playfx ( level._effect["mortar"], vec );
	thread playSoundinSpace ("mortar_explosion", vec);
	earthquake(0.3, 3, vec, 850); // scale duration source radius
	do_mortar_deaths (getaiarray(), vec);
	radiusDamage (vec, 150, 150, 0);
}

mortar_hit_running ( guy )
{
	guy endon ("death");
	wait (2);
	playSoundinSpace ("mortar_incoming", guy.origin);
	playfx ( level._effect["mortar"], guy.origin );
	vec = guy.origin;
	thread playSoundinSpace ("mortar_explosion", vec);
	earthquake(0.3, 3, vec, 850); // scale duration source radius
	do_mortar_deaths (getaiarray(), vec);
	radiusDamage (vec, 150, 150, 0);
}

do_mortar_deaths (ai, org)
{
	for (i=0;i<ai.size;i++)
	{
		if (isdefined (ai[i].magic_bullet_shield))
			continue;

		dist = distance (ai[i].origin, org);
		if (dist < 190)
		{
			ai[i].allowDeath = true;
			ai[i].deathAnim = ai[i] getExplodeDeath("generic", org, dist);
			ai[i] DoDamage ( ai[i].health + 50, (0,0,0) );
			println ("Killing an AI");
			continue;
		}

//		if (isdefined (ai[i].getting_up))
//			continue;

//		if (dist < 300)
//			ai[i] thread getup(ai[i] getKnockDown(org), org);
	}
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


player_got_too_close ( trigger )
{
	while (1)
	{
		trigger waittill ("trigger");
		level.player.threatbias = 500000;
		while (level.player istouching (trigger))
			wait (2);
		level.player.threatbias = 0;
	}
}

get_friendly_chain_node (chainstring)
{
	trigger = getentarray ("trigger_friendlychain","classname");
	for (i=0;i<trigger.size;i++)
	{
		if ((isdefined (trigger[i].script_chain)) && (trigger[i].script_chain == chainstring))
		{
			chain = trigger[i];
			break;
		}
	}

	if (!isdefined (chain))
	{
		maps\_utility::error ("Tried to get chain " + chainstring + " which does not exist with script_chain on a trigger.");
		return undefined;
	}

	node = getnode (chain.target,"targetname");
	return node;
}

reinforcements_think ()
{
	self.count = 1;
	spawn = self dospawn();
	if (maps\_utility::spawn_failed(spawn))
		return;

	spawn endon ("death");
	node = getnode (spawn.target,"targetname");
	spawn setgoalnode (node);
	spawn.goalradius = node.radius;

	level waittill ("reinforcements move up");
	node = getnode (node.target,"targetname");
	spawn setgoalnode (node);
	spawn.goalradius = node.radius;
}

church_defender_start (  )
{
	self.count = 1;
	while (1)
	{
		if (isdefined (self.script_noteworthy))
			spawn = self dospawn(self.script_noteworthy);
		else
			spawn = self dospawn();

		if (isdefined (spawn))
			break;

		wait (2);
	}

	spawn.health = 500;
	spawn thread maps\_utility::magic_bullet_shield();
	spawn.suppressionwait = 0;
	spawn endon ("death");
	flag_wait ("church under siege");
	spawn maps\_spawner::friendly_mg42_stop_use();

	node = getnode (spawn.target,"targetname");
	node = getnode (node.target,"targetname");
	spawn setgoalnode (node);
	spawn.goalradius = node.radius;

	spawn notify ("stop magic bullet shield");

	spawn.oldaccuracy = spawn.accuracy;
	while (1)
	{
		if (!level.flag["player is at church"])
		{
			spawn.accuracy = 0;
			level waittill ("player is at church");
		}
		else
		{
			spawn.accuracy = spawn.oldaccuracy;
			level waittill ("player is not at church");
		}
	}
}


mortar_stopper()
{
	safe_trigger = getent ("safe house","targetname");
	wait (10);
	while (!level.player istouching (safe_trigger))
		wait (0.5);

	flag_set("mortars stop");
}

mortar_thread ()
{
	thread mortar_stopper();

	waits[0] = 0;
	waits[1] = 1.1;
	waits[2] = 0.2;
	waits[3] = 1.5;
	waits[4] = 1.2;
	waits[5] = 0.9;
	waits[6] = 0.5;
	waits[7] = 0.8;
	waits[8] = 1.2;
	waits[9] = 1.5;
	waits[10]= 0.7;

	index = 0;
	starter = self;
	ent = self;

	while (!level.flag["mortars stop"])
	{
		wait (waits[index]);
		index++;
		if (index >= waits.size)
			index = 0;

		mortar_hit( ent.origin + (0,0,-60));

		if (isdefined (ent.target))
			ent = getent (ent.target,"targetname");
		else
			ent = starter;
	}
}

asset_think ()
{
	self endon ("death");
	self thread animscripts\shared::SetInCombat();

	self.health = 150;
	self thread maps\_utility::magic_bullet_shield();
	self.suppressionwait = 0;
	self endon ("death");
	node = getnode (self.target,"targetname");
	self setgoalnode (node);
	self waittill ("goal");
	self.goalradius = 4;
	level waittill ("go go go");
	self notify ("stop magic bullet shield");
	self notify ("ä");
	node = getnode (node.target,"targetname");
	self setgoalnode (node);
	self waittill ("goal");
	level waittill ("go onward");
	if (isdefined (node.target))
	{
		node = getnode (node.target,"targetname");
		self setgoalnode (node);
		self waittill ("goal");
	}

	level waittill ("final charge");
	if (isdefined (node.target))
	{
		node = getnode (node.target,"targetname");
		self setgoalnode (node);
		self waittill ("goal");
	}

	flag_wait ("got panzers");
	self.goalradius = 512;
}

go_target ()
{
	self setgoalnode (getnode (self.target,"targetname"));
}

playSoundinSpace (alias, origin)
{
	org = spawn ("script_origin",(0,0,1));
	org.origin = origin;
	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}

getExplodeDeath(msg, org, dist)
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

msg_send (guy, lvlmsg, msg)
{
	guy waittill (msg);
	level notify (lvlmsg);
}

wait_any (guy, lvlmsg, msg1, msg2, msg3, msg4, msg5, msg6, msg7)
{
	if (isdefined (msg1))
		level thread msg_send (guy, lvlmsg, msg1);
	if (isdefined (msg2))
		level thread msg_send (guy, lvlmsg, msg2);
	if (isdefined (msg3))
		level thread msg_send (guy, lvlmsg, msg3);
	if (isdefined (msg4))
		level thread msg_send (guy, lvlmsg, msg4);
	if (isdefined (msg5))
		level thread msg_send (guy, lvlmsg, msg5);
	if (isdefined (msg6))
		level thread msg_send (guy, lvlmsg, msg6);
	if (isdefined (msg7))
		level thread msg_send (guy, lvlmsg, msg7);
}

german_retreat () // Handles germans that have fled from the church to flee to the end of the level
{
	trigger = getent (self.target,"targetname");
//	while (1)
//	{
//		self waittill ("trigger");

		ai = getaiarray ("axis");
		retreater = [];
		for (i=0;i<ai.size;i++)
		{
			if (isdefined (ai[i].retreating))
				continue;

			if (!ai[i] istouching (trigger))
				continue;

			retreater[retreater.size] = ai[i];
		}

		nodes = getnodearray ("retreat node","targetname");
		index = 0;

		for (i=0;i<retreater.size;i++)
		{
			retreater[i] thread retreater_think (nodes[index]);
			index++;
			if (index >= nodes.size)
				index = 0;
		}
		ai = undefined;
		retreater = undefined;
		nodes = undefined;
//		wait (2);
//	}
}

retreater_think ( node )
{
	self endon ("death");
	self.goalradius = 4;
	self setgoalnode (node);
	self.bravery = 500000;
	self.suppressionwait = 0;
	self waittill ("goal");
	self.goalradius = 512;
}

elder ( spawner )
{
	spawner waittill ("spawned",spawn);
	// Keep trying because Elder is required.
	while (maps\_utility::spawn_failed(spawn))
	{
		wait (1);
		spawner.count = 1;
		spawn = spawner dospawn();
	}

	flag_set ("elder exists");
	level.elder = spawn;
	spawn.animname = "elder";
	spawn character\_utility::new();
	spawn character\elder::main();
	spawn.script_usemg42 = false;
	spawn.dontFollow = true;
	spawn thread maps\_utility::magic_bullet_shield();
}

moody ( spawner )
{
	spawner waittill ("spawned",spawn);
	// Keep trying because Moody is required.
	while (maps\_utility::spawn_failed(spawn))
	{
		wait (1);
		spawner.count = 1;
		spawn = spawner dospawn();
	}

	flag_set ("moody exists");

	level.moody = spawn;
	spawn.animname = "moody";
	spawn character\_utility::new();
	spawn character\moody::main();
	spawn thread maps\_utility::magic_bullet_shield();
	spawn.script_usemg42 = false;
	spawn.dontFollow = true;
	level thread moodyChat(spawn);
}

moodyChat ( spawn )
{
	trigger = getent ("moody chat trigger","targetname");
	trigger waittill ("trigger");
	if (!level.flag["church has been defended"])
	{
		// Damnit Martin, get to the church with Foley. We got this area covered."
		spawn anim_single_solo (spawn, "got it covered");
	}
}

second_flak_preaction ()
{
	allied_spawners = getentarray ("second flak guys allied","targetname");
	axis_spawners = getentarray ("second flak guys axis","targetname");

	spawned_allies = false;
	while (1)
	{
		self waittill ("trigger");
		if (!flag("church has been defended"))
		{
			if (spawned_allies)
				continue;

			spawned_allies = true;

			for (i=0;i<allied_spawners.size;i++)
				allied_spawners[i] thread spawn_node_attack(::followPlayerLater);
		}
		else
		{
			if (!spawned_allies)
			for (i=0;i<allied_spawners.size;i++)
				allied_spawners[i] thread spawn_node_attack(::followPlayerLater);

			for (i=0;i<axis_spawners.size;i++)
				axis_spawners[i] thread spawn_node_attack();

			break;
		}
	}

	maps\_spawner::flood_spawn (getentarray ("second flak flood spawner","targetname"));
}

church_preaction_trigger (trigger)
{
	level endon ("church defenders start");
	trigger waittill ("trigger");
	level notify ("church defenders start");
}

// Start up the church guys
church_preaction ()
{
//	self waittill ("trigger");
	thread church_preaction_trigger(getent ("start church trigger","targetname"));
	level waittill ("church defenders start");
	array_thread(getentarray ("church defend","targetname"), ::church_defender_start); // Start up church defenders to hang out
	trigger = getent ("at church","targetname");
	while (level.player istouching (trigger))
		wait (1);
//	trigger waittill ("trigger");

//	pre_attack_spawners = getentarray ("church preattack","targetname");
//	maps\_spawner::flood_spawn (pre_attack_spawners); // Give the defenders a couple guys to shoot at
	wait (2);
	//<Lewis> We're seeing some light acion, but we've got this area covered sir!
	//iprintlnbold (&"DAWNVILLE_LIGHTACTION");

	flag_wait ("east tank destroyed");

	church_entrance_trigger = getent ("church entrance","targetname");
	while (level.player istouching (church_entrance_trigger))
		wait (0.05);
//	church_entrance_trigger waittill ("trigger");


//	level waittill ("church under siege");
//	for (i=0;i<pre_attack_spawners.size;i++)
//		pre_attack_spawners[i] notify ("disable");

	spawners = getentarray ("church attack","targetname");
	array_levelthread (spawners, ::church_spawner_think);
	maps\_spawner::flood_spawn (spawners);
	trigger waittill ("trigger");
}

church_spawner_think (spawner)
{
	spawner endon ("death");
	while (1)
	{
		if (spawner.count > 1)
			teleporter = true;
		else
			teleporter = false;

		spawn = undefined;
		spawner waittill ("spawned",spawn);
		/*
		if (!isalive(spawn))
		{
			println ("spawn aint alive!");
			println ("there are ", getaiarray().size," ai");
		}
		else
		{
			wait (1);
			if (isalive (spawn))
				spawn delete();
			continue;
		}
		*/
		
		if (maps\_utility::spawn_failed(spawn))
		{
			/*
			println ("Spawn failed!");
			wait (1);
			if (isalive (spawn))
			{
				println ("but the spawn lives!!!!!");
				spawn delete();
			}
			*/
			continue;
		}
					
		spawn thread churchStayinAlive();
		spawn.suppressionwait = 0;
		if (teleporter)
			spawn thread churchAttackMove(spawner, teleporter);
	}
}

churchStayinAlive ()
{
	self endon ("death");
	maxhealth = self.maxhealth;
	if (!flag("player is at church"))
	{
		oldhealth = self.health;
		self.health = 500000;
		level waittill ("player is at church");
		self.health = oldhealth;
		self.maxhealth = maxhealth;
	}	
	
	while (1)
	{
		level waittill ("player is not at church");
		oldhealth = self.health;
		self.health = 500000;
		level waittill ("player is at church");
		self.health = oldhealth;
		self.maxhealth = maxhealth;
	}
}

churchAttackMove (spawner, teleporter)
{
	startOrigin = spawner.origin;
	self endon ("death");
	level endon ("fallback initiated " + self.script_fallback);
	println ("fallback is ", self.script_fallback);

	node = getnode ("escape","targetname");
	startnode = getnode (self.target,"targetname");
	oldradius = self.goalradius;

	while (1)
	{
		wait (15 + randomfloat (4));
		if (!teleporter)
			wait (20);
		self.goalradius = 4;
		while (distance (self.origin, node.origin) > 64)
		{
			self setgoalnode (node);
			self waittill ("goal");
		}

		if (!teleporter)
		{
			self delete();
			return;
		}

		self teleport (startOrigin);
		self.goalradius = oldradius;
		self setgoalnode (startnode);
		self waittill ("goal");
	}
}

flak_node ( spawn )
{
	spawn endon ("death");
	if (!isdefined (spawn.target))
		return;
		
	node = getnode (spawn.target,"targetname");
	spawn setgoalnode (node);
	spawn waittill ("goal");
	wait (0.2);
	spawn.goalradius = 1000;
}

flak_attackers ( spawn )
{
	level.flak_attackers++;
	level thread flak_node(spawn);
	spawn waittill ("death");
	level.flak_attackers--;
}

more_attackers ()
{
//	if (level.flag["got panzers"])
//		return;
//	level endon ("got panzers");
	
	if (flag ("east tank destroyed"))
		return;
	
	level endon ("east tank destroyed");

	ai = getentarray ("flak_attack","targetname");
	level.flak_attackers = 0;

	for (i=0;i<ai.size;i++)
		ai[i] thread spawn_node_attack(::flak_attackers);

	while (1)
	{
		ai = maps\_utility::array_randomize(ai);
		for (i=0;i<ai.size;i++)
		{
			wait (20 + randomfloat (5));

			if (level.flak_attackers > 2)
				continue;

			ai[i] thread spawn_node_attack(::flak_attackers);
		}
	}

}

tank_killers_death (node, guy)
{
	node waittill ("death");
	for (i=0;i<guy.size;i++)
	{
		if (!isalive (guy[i]))
			continue;
			
		guy[i] notify ("stop magic bullet shield");
		guy[i] setgoalentity (level.player);
		guy[i] stopanimscripted();
		guy[i].allowDeath = true;
		guy[i].deathanim = %death_explosion_back13;
		println ("guy ",i," health ", guy[i].health);
	}
}

tank_killers_killThread (node, gun_guy)
{
	node endon ("death");
	node maps\_anim::anim_single (gun_guy, "run", "tag_hatch");
	node thread anim_loop ( gun_guy, "idle", "tag_hatch", "stop anim");
}

tank_killers_destroyed ()
{
	self endon ("death");
	flag_wait("west tank destroyed");
	self notify ("stop magic bullet shield");
}

tank_killers_think (tank_killers)
{
	for (i=0;i<tank_killers.size;i++)
		if (tank_killers[i].animname == "gun guy")
			gun_guy[0] = tank_killers[i];
		else
			grenade_guy[0] = tank_killers[i];

	node = getent ("tank west","targetname");
	node.nospawning = true;
	node endon ("death");
 	guy[0] = gun_guy[0];
	guy[1] = grenade_guy[0];
	array_thread(guy, ::tank_killers_destroyed);
	
	level thread tank_killers_death(node, guy);
	flag_wait ("west tank attacks");
	flag_wait ("west tank finished moving");
	println ("Time to attack the tank!");
	
	node maps\_anim::anim_reach (gun_guy, "run", "tag_hatch");
	level thread tank_killers_killThread (node, gun_guy);

	node maps\_anim::anim_reach (grenade_guy, "run", "tag_hatch");
	node thread maps\_anim::anim_single (grenade_guy, "run", "tag_hatch");
	node waittill ("run");

	
 	node notify ("stop anim");

	node maps\_anim::anim_reach (guy, "attack", "tag_hatch");
	node.animname = "tank";
	node assignanimtree();
	node setFlaggedAnim( "single anim", level.scr_anim[node.animname]["attack"]);
	node thread maps\_anim::notetrack_wait (node, "single anim", undefined, "attack");
	
//	maps\_utility::chain_off ("125");

	node thread maps\_anim::anim_single (guy, "attack", "tag_hatch");
	node waittill ("attack");

	badplace_cylinder("why must I set a name?", 3, node.origin, 400, 400, "allies");
	for (i=0;i<guy.size;i++)
	{
		if (!isalive (guy[i]))
			continue;
			
		guy[i] notify ("stop magic bullet shield");
		guynode = getnode (guy[i].target,"targetname");
		guynode = getnode (guynode.target,"targetname");
		guy[i] setgoalnode (guynode);
		guy[i].goalradius = 4;
	}
	wait (3);
	for (i=0;i<guy.size;i++)
	{
		if (!isalive (guy[i]))
			continue;
		guy[i] setgoalentity (level.player);
		guy[i].deathanim = undefined;
	}
		
//	radiusDamage (node.origin + (0,0,50), 1900, 1700,  1300); // mystery numbers!
	radiusDamage (node.origin, 2, node.health + 5000,  node.health + 5000); // mystery numbers!
//	node DoDamage ( node.health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );

}

tank_killers_spawn (spawners)
{
	guy = [];
	for (i=0;i<spawners.size;i++)
	{
		if (!i)
			animname = "gun guy";
		else
			animname = "grenade guy";

		spawners[i].count = 1;
		spawn[animname] = spawners[i] dospawn();
		while (!isalive (spawn[animname]))
		{
			spawners[i].count = 1;
			spawn[animname] = spawners[i] dospawn();
			wait (1);
		}
		
		spawn[animname] thread maps\_utility::magic_bullet_shield();
		spawn[animname].dontFollow = true;
		
//		spawn[animname].allowDeath = true;
		spawn[animname].animname = animname;
//		spawn[animname] endon ("death");
//		spawn[animname] animscripts\shared::putGunInHand ("none");
		guy[guy.size] = spawn[animname];
	}

	return guy;
}

/*
tank_killers_trigger( trigger, spawners )
{
	trigger waittill ("trigger");
	guy = tank_killers_spawn (spawners);
	guy.setgoalpos = guy.origin;
	guy.goalradius = 64;
	level notify ("tank killers trigger");
	thread tank_killers_think(guy);
}
*/

tank_killers ()
{
	spawners = getentarray ("tank killer", "targetname");
	trigger = getent ("last tank attacks","targetname");
	level endon ("tank killers trigger");
	guy = tank_killers_spawn (spawners);
	thread tank_killers_think(guy);
}

// If the player leaves the safe house before Foley, he gets in trouble for it.
punishPlayerForLeavingSafety ( trigger )
{
	level endon ("left safehouse!");
	while (level.player istouching (trigger))
		wait (1);

	level notify ("left safehouse!");
//	array_thread(getentarray ("group2","targetname"), ::spawn_attack);
//	array_thread(getentarray ("reprimand church","targetname"), ::spawn_attack);
}

house_guy_think()
{
	self endon ("death");
	self thread animscripts\shared::SetInCombat();

	node = getnode (self.target,"targetname");
	self setgoalnode (node);
	self.goalradius = 0;
	self waittill ("goal");
	wait (3);
	node = getnode (node.target,"targetname");
	self setgoalnode (node);
	self.deathanim = %death_run_left;
	wait (0.7);
	self notify ("reached final objective");
}

goToLaterPartOfLevel ()
{
	self endon ("death");
	self.goalradius = 600;
	self maps\_spawner::friendly_mg42_stop_use();
	self.script_usemg42 = false; // Foley is too cool for MG42s
	self setgoalentity (level.player);
	wait (4);
	self waittill ("goal");
	self setgoalentity (level.player);
	wait (4);
	self waittill ("goal");
	self setgoalentity (level.player);
}

killAllAxisOverTime ()
{
	while (1)
	{
		ai = getaiarray ("axis");
		if (ai.size > 0)
			ai[0] DoDamage ( ai[0].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
		else
			return;
			
		wait (1 + randomfloat (1));
	}
}

deleteFarthestAllies ()
{
	potentialAI = getaiarray ("allies");
	ai = [];
	foley = getent ("foley","targetname");
	if (!isdefined (level.moody))
		level.moody = foley;
	if (!isdefined (level.elder))
		level.elder = foley;
	if (!isdefined (level.parker))
		level.parker = foley;
		
	for (i=0;i<potentialAI.size;i++)
	{
		if (potentialAI[i] == foley)
			continue;
		if (potentialAI[i] == level.moody)
			continue;
		if (potentialAI[i] == level.parker)
			continue;
		if (potentialAI[i] == level.elder)
			continue;
						
		ai[ai.size] = potentialAI[i];
	}
	
	if (ai.size <= 0)
		return;
	
	saveFriendlies = 4;
//	if (getcvar ("scr_dawnville_fast") == "1")
//		saveFriendlies = 2;
			
	num = ai.size - (saveFriendlies);
	for (p=0;p<ai.size;p++)
		ai[p].goneNow = false;
		
	for (i=0;i<num;i++)
	{
		index = -1;
		range = 0;
		for (p=0;p<ai.size;p++)
		{
			if (ai[p].goneNow)
				continue;
				
			newrange = distance (level.player.origin, ai[p].origin);
			if (newrange > range)
			{
				range = newrange;
				index = p;
			}
		}
		
		if (index != -1)
			ai[index].goneNow = true;
	}
	
	for (p=0;p<ai.size;p++)
	{
		if (!ai[p].goneNow)
			continue;

		ai[p] DoDamage ( ai[p].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
	}
}

parkerSpawnerThink ()
{
	
	flag_wait ("parker is a go");
	println ("parker is a go..");
	spawner = level.parkerSpawner;
	println (level.parkerSpawner.origin);
	println ("0spawner ", spawner.origin);

	while (1)
	{
		spawner.count = 1;
		spawn = spawner dospawn();
		if (!maps\_utility::spawn_failed(spawn))
			break;
		wait (0.1);
	}
	spawn endon ("death");
	spawn.animname = "parker";
	spawn thread maps\_utility::magic_bullet_shield();
	spawn.dontavoidplayer = true;
	spawn.dontFollow = true;
	level.parker = spawn;
	
	// Set the friendlies running to the parker spot
	maps\_utility::chain_on ("450");
	chain = get_friendly_chain_node ("450");
	level.player SetFriendlyChain (chain);

	flag_Set ("chain 100 off forever");
	flag_Set ("chain 125 off forever");

	level thread deleteFarthestAllies();
	
	ai = getaiarray ("allies");
	for (i=0;i<ai.size;i++)
	{
		if (isdefined (ai[i].dontFollow))
			continue;
		ai[i] thread goToLaterPartOfLevel();
	}
	
	level.moody setgoalentity (level.player);

	foley = getent ("foley","targetname");
/*
	spawn waittill ("goal");

	while (distance (foley.origin, spawn.origin) > spawn.goalradius - 5)
		wait (0.5);

	spawn notify ("stop following foley");
*/	
	guy[0] = spawn;
	guy[1] = foley;
	node = getnode ("parker scene","targetname");
	foley allowedstances ("stand");
	maps\_anim::anim_reach (guy, "get mortars", undefined, node);
	foley lookat (foley, 0);
	level thread croucher();
	maps\_anim::anim_single (guy, "get mortars", undefined, node);
	flag_set ("parker speech");
	level.flag["Friendlies crouch for conference"] = false;
	
	maps\_utility::chain_off ("450");
	maps\_utility::chain_on ("460");
	chain = get_friendly_chain_node ("460");
	level.player SetFriendlyChain (chain);
	
	foley allowedstances ("crouch", "stand");
	foley setgoalentity (level.player);
	spawn setgoalentity (level.player);
	spawn notify ("stop magic bullet shield");
}

croucher ()
{
	wait (1.15);
	flag_set("Friendlies crouch for conference");
	println ("^3time to crouch!");
	//trigger = getent ("croucher","targetname");
	//thread croucher_trigger (trigger);
	
	ai = getaiarray ("allies");
	foley = getent ("foley", "targetname");
	for (i=0;i<ai.size;i++)
	{
		if (ai[i] == foley)
			continue;
			
//		if (!ai[i] istouching (trigger))
//			continue;
		
		if (ai[i].anim_pose == "prone")
		{
			ai[i] OrientMode ("face default");	// We were most likely in "face current" while we were prone.
			ai[i] exitprone(1.0); // make code stop lerping in the prone orientation to ground
			ai[i] UpdateProne(%prone_shootfeet_straight45up, %prone_shootfeet_straight45down, 1, 0.1, 1);
		}
		ai[i].anim_pose = "crouch";
	}
	return;
	
	flag_wait ("parker speech");

	ai = getaiarray ("allies");
	for (i=0;i<ai.size;i++)
	{
		if (ai[i] == foley)
			continue;

		ai[i] allowedStances ("prone", "stand", "crouch");
	}
}
	
croucher_trigger (trigger)
{
	level endon ("parker speech");
	while (1)
	{
		trigger waittill ("trigger", other);
		if (!isalive (other))
			continue;
			
		if (flag("Friendlies crouch for conference"))
		{
			if (other.anim_pose == "crouch")
				continue;
				
			if (other.anim_pose == "prone")
			{
				other OrientMode ("face default");	// We were most likely in "face current" while we were prone.
				other exitprone(1.0); // make code stop lerping in the prone orientation to ground
				other UpdateProne(%prone_shootfeet_straight45up, %prone_shootfeet_straight45down, 1, 0.1, 1);
			}
			other.anim_pose = "crouch";
		}
		else
			other allowedStances ("prone", "stand", "crouch");
	}
}

lookaround (foley)
{
	foley endon ("get mortars");
	allies = getaiarray ("allies");
	for (i=0;i<allies.size;i++)
	{
		wait ((1) + randomfloat (1));
		if (!isalive (allies[i]))
			continue;

		foley lookat(allies[i]);
	}
}

parkerTrigger ( trigger )
{
	level.parkerSpawner = getent (trigger.target,"targetname");
	println (level.parkerspawner.origin);
	trigger.target = "moot";
	trigger waittill ("trigger");
	println (level.parkerspawner.origin);
	flag_set ("parker is a go");
	println (level.parkerspawner.origin);
	trigger delete();
}

house_guy_function ( foley, house_guy )
{
	level endon ("left safehouse!");
	wait (4.2); // 4.2
	if (isalive (house_guy))
	{
		house_guy.health = 1;
		house_guy.animname = "johnson";
		// All right, the mortars are taking a break."
		node = getnode (foley.target,"targetname");
// (Boon 01/09/03) Removed this SetInCombat because it isn't necessary, and it is overriding the one from the beginning of the level.
//		foley thread animscripts\shared::SetInCombat();
		foley thread anim_single_solo (foley, "mortars stopped", undefined, node);
		wait (1.0);
		
		if (isalive (house_guy))
		{
			foley lookat(house_guy);
			house_guy lookat(foley);
			wait (2.5);
		}

		if (isalive (house_guy))
		{
			// Right, Captain.
			house_guy thread anim_single_solo (house_guy, "right captain");
			wait (0.7);
		}

		if (isalive (house_guy))
		{
			house_guy lookat(house_guy, 2);
	
			house_guy thread bloody_death_waittill();
			house_guy thread house_guy_think();
			house_guy.goalradius = 200;
			level thread wait_any (house_guy, "house guy finishes", "reached final objective", "death");
			level waittill ("house guy finishes");
		}
		
		if ((isalive (house_guy)) && (level.player istouching (getent ("safe house","targetname"))))
		{
			level thread playSoundinSpace ("weap_kar98k_fire", house_guy.origin);
			house_guy DoDamage ( house_guy.health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
		}

		wait (0.3);

		if (!isalive (house_guy))
		{
			// They got him! Damn!
			foley thread anim_single_solo (foley, "they got him");
		}
	}
	else
	{
		// All right, the mortars are taking a break."
		foley thread anim_single_solo (foley, "mortars stopped 2");
		wait (1);
	}

	level notify ("left safehouse!");
}

fallback_wait ()
{
	level waittill ("fallback initiated " + 1);
	flag_set ("falling back");
}


deathInTime (timer)
{
	self endon ("death");
	wait (timer);
	self delete();
}

kill_axis ( trigger )
{
	while (1)
	{
		trigger waittill ("trigger",other);
		if (!isSentient(other))
			continue;

		other thread deathInTime(8);
	}
}

tankObjectiveComplete()
{
	flag_wait ("northeast tank destroyed");
	objective_state(5, "done");
}

tankReplacesObjective ()
{
	level waittill ("picked up infinite panzerfaust");
	objective_string(5, &"DAWNVILLE_OBJ5SECONDTANK");
	level thread objective_org(5, getent ("tank northeast","targetname"));
	objective_current(5);
	flag_wait ("northeast tank destroyed");
	objective_state(5, "done");
}

foleyTellsYouToGetAnotherPanzerfaust ( foley )
{
	wait (5);
	foley thread anim_single_solo (foley, "get another panzer");
}


niceShot ( foley )
{
	wait (2);
	//*-15. Good job, son!
	if (isalive (level.player))
		foley thread anim_single_solo (foley, "good job");
}

gotPanzers ()
{
	flag_wait ("got panzers");
	objective_state(1, "done");
	maps\_utility::autosave(2);
}

objective_org (num, ent)
{
	ent endon ("death");
	ent endon ("stop being objective");
	while (1)
	{
		objective_position(num, ent.origin);

		wait (0.1);
	}
}

mortarStopper ()
{
	usedOrgs = [];
	while (1)
	{
		level waittill ("mortar teams got off mortar");
		used = false;
		for (i=0;i<usedOrgs.size;i++)
		{
			if (usedOrgs[i] == level.stoppedmortarOrigin)
				used = true;
		}
		
		if (!used)
			usedOrgs[usedOrgs.size] = level.stoppedmortarOrigin;
			
		if (usedOrgs.size >= 2)
			break;
	}
	
	level notify ("mortars ongoing STOP");
}

// Give the player a hint for when he first picks up an fg42
rateOfFireHintCheck ()
{
	return;
	while (1)
	{
		level.player waittill ("pickup", item);
//		item = item.classname;
		println ("^5Item was ", item);
		if ((item == "FG42") || (item == "weapon_FG42"))
			break;
	}
	
	maps\_utility::keyHintPrint(&"DAWNVILLE_RATE_OF_FIRE", getKeyBinding("weapalt"));
}

distanceTankRumbleDeathEnder ()
{
	level waittill ("stop tank rumble");
	wait (2);
	self delete();
}

distantTankRumble ()
{
	org = spawn ("script_origin",(0,0,0));
	org endon ("death");
	org thread distanceTankRumbleDeathEnder();
//	org.origin = (2396, -16170, 50);
	offset = 11200;
	vec = (2396, -16170, 50);
	while (offset > 0)
	{
		offset -= 50;
		org.origin = (vec[0] + offset, vec[1], vec[2]);
		org playloopsound ("panzerIV_engine_high");
		wait (0.05);
	}
}
	


tankBlowsUpBuilding ( tank )
{
	tank endon ("death");
	org = getent ("tank east target","targetname");
	tank setTurretTargetEnt( org, ( 0, 0, 0 ) );
	tank waittill( "turret_on_vistarget" );
	tank FireTurret();
	//                    origin, range, max damage, min damage
	radiusDamage (org.origin, 550, level.player.health * 0.85, level.player.health * 0.25); // mystery numbers!
	if (distance (level.player.origin, org.origin) < 500)
		maps\_shellshock::main(7);
		
	maps\_utility::exploder(10);
	block = getent ("safehouse block","targetname");
	block solid();
	block disconnectpaths();
	destroyed = getentarray ("destroy these","targetname");
	for (i=0;i<destroyed.size;i++)
		destroyed[i] delete();
}

// For the northern approach sequence where the friendlies push the Germans back
followPlayerLater (spawn)
{
	if (!isalive (spawn))
		return;
	spawn endon ("death");
	level waittill ("friendlies push germans back");
	spawn setgoalentity (level.player);
	level waittill ("tank start northeast");
	wait (3);
	spawn maps\_spawner::friendly_mg42_stop_use();
	spawn setgoalentity (level.player);
	println ("^5following player A");
}

sequence_init ()
{
	regroup_friendly_trigger = getent ("regroup friendly chain","targetname");
	push_germans_back_trigger = getent ("end of the road", "targetname");

	push_germans_back_trigger maps\_utility::triggerOff();
	regroup_friendly_trigger maps\_utility::triggerOff();
	end_level_trigger = getent ("end level trigger","targetname");
	end_level_trigger maps\_utility::triggerOff();

	clip = getent ("second flak monster clip","targetname");
	clip connectpaths();
	clip notsolid();
	thread parkerTrigger(getent ("parker trigger","targetname"));

	// Trigger at the end of the retreat that kills Germans as they flee.
	thread kill_axis(getent ("kill axis","targetname"));

	thread moody( getent ("moody","script_noteworthy"));

	foley = getent ("foley", "targetname");
	baker = getent ("baker","script_noteworthy");
	jackson = getent ("jackson","script_noteworthy");

	foley.animname = "foley";
	baker.animname = "baker";
	jackson.animname = "jackson";

	foley thread maps\_utility::magic_bullet_shield();
	thread fallback_wait();

	// For later in the game, make ai get to the right places for car finale
	thread carTrigger(	getent ("car sequence","targetname"));
	
	// Stop mortars if player interrupts both mortar teams
	thread mortarStopper();
	
	// Give the player a hint for when he first picks up an fg42
	thread rateOfFireHintCheck();
}

sequence_1 () // Go to the Safe house, get the panzerfaust, kill the tank
{
//	firstguy = getent ("firstguy", "targetname");
	explosionguy = getent ("explosion guy","targetname");
	foley = getent ("foley", "targetname");
	flak_trigger = getent ("at flak","targetname");
	house_guy = getent ("house guy","targetname");
	safe_trigger = getent ("safe house","targetname");
	church_entrance_trigger = getent ("church entrance trigger","targetname");
	player_advance_trigger = getent ("player advances","targetname");
	baker = getent ("baker","script_noteworthy");
	jackson = getent ("jackson","script_noteworthy");
	player_start_trigger = getent ("player start","targetname");

	// Kill the player if he strays too far!
	thread player_mortar_death (getent ("player mortar death","targetname"));
	// For a tank later on
	start_tank_trigger = getent ("start tank","targetname");
	start_tank_trigger maps\_utility::triggerOff();

	thread church_preaction();
//	getent ("start church trigger","targetname") thread church_preaction ();
	getent ("second flak guys trigger","targetname") thread second_flak_preaction();
	thread sequence_2();

	player_advance_trigger maps\_utility::triggerOff();


	clip = getent ("east tank clip","targetname");
	clip connectpaths();
	clip notsolid();

	getent ("mortar attack","targetname") thread mortar_thread();

	wait (0.05);
	if (isalive (baker))
	{
		// Up! Get up! Wake it and shake it! The Germans are bringing your coffee!
		baker thread anim_single_solo (baker, "wake up");
	}

	level waittill ("starting final intro screen fadeout");

	foley_node = getnode (foley.target,"targetname");
	foley_outernode = getnode (foley_node.target,"targetname");
	foley_finalnode = getnode (foley_outernode.target,"targetname");
	foley_finalchargeNode = getnode (foley_finalnode.target,"targetname");


	foley.goalradius = 4;
	foley.suppressionwait = 0;

	node = getnode (explosionguy.target,"targetname");
	explosionguy.goalradius = 128;
	explosionguy setgoalnode (node);
	if (isalive (explosionguy))
		level thread mortar_hit_running (explosionguy);


	// Off the streets! Mortars!
//	if (level.player istouching (player_start_trigger))
	wait (0.4);
	foley lookat(foley, 0);
	foley setgoalnode (foley_node);
	wait (.8);
	foley anim_single_solo (foley, "off the streets");
	//Follow Captain Foley to a safe place.
	objective_add(0, "active", &"DAWNVILLE_OBJ0", safe_trigger getorigin());
	objective_current(0);
	
//	foley lookat(level.player, 4);
//	if (level.player istouching (player_start_trigger))
//		foley thread anim_single_solo (foley, "wave follow");

	array_thread(getentarray ("asset","targetname"), ::asset_think); // Baker and Jackson


	if (isalive (jackson))
	{
		// Incoming! Take cover!
		jackson thread anim_single_solo (jackson, "mortars");
		waittill_either (jackson, "mortars","death");
	}

	wait (1);
	if (isalive (baker))
	{
		// Mortars, incoming!"
		baker thread anim_single_solo (baker, "mortars");
	}

	foley waittill ("goal");

	timer = gettime() + 8000;
	while (!level.player istouching (safe_trigger))
	{
		if (gettime() > timer)
		{
			randomx = randomint ( 15 ) + 25;
			if (randomint (100) > 50)
				randomx *= -1;

			randomy = randomint ( 15 ) + 25;
			if (randomint (100) > 50)
				randomy *= -1;

			timer = gettime() + 12000 + randomint (6500);
			playSoundinSpace ("mortar_incoming", level.player.origin + (randomx, randomy, 0) );
			mortar_hit_explosion ( level.player.origin + (randomx, randomy, 0) );
			maps\_shellshock::main(9);
			break;
		}
		wait (1);
	}

	timer = gettime() + 6000;

	while (!level.player istouching (safe_trigger))
	{
		if (gettime() > timer)
		{
			playSoundinSpace ("mortar_incoming", level.player.origin);
			mortar_hit_explosion ( level.player.origin );
		}

		wait (1);
	}

	thread punishPlayerForLeavingSafety( safe_trigger );
	flag_wait ("mortars stop");
	maps\_utility::autosave(1);

	level thread objective_org (0, foley);
	level thread house_guy_function(foley, house_guy);
	level waittill ("left safehouse!");
	maps\_spawner::flood_spawn (getentarray ("church annoyer","targetname"));
	foley lookat( foley, 0 );

	wait (0.25);

	level notify ("go go go");
//	if (isalive (tank))
	foley setgoalnode (foley_outernode);
	wait (1);

	array_thread(getentarray ("reprimand church","targetname"), ::spawn_attack);
	wait (1.5);
	array_thread(getentarray ("group2","targetname"), ::spawn_attack);

	level notify ("tank start east");
	clip solid();
	clip disconnectpaths();
	wait (12);
	obj0Complete = false;
	if (level.flag["got panzers"])
	{
		foley notify ("stop being objective");
		objective_state(0, "done");
		obj0Complete = true;
	}
	
	thread sequence_1_tank(obj0Complete);

	tank = getent ("tank east","targetname");

	if (isalive (tank))
	{
		if (isalive (jackson))
		{
			// We got company! Tiger, moving in from the east!"
			jackson thread anim_single_solo (jackson, "tiger incoming");
			waittill_either (jackson, "tiger incoming","death");
		}
		else
		if (isalive (baker))
		{
			// Enemy tank! Look out!
			baker thread anim_single_solo (baker, "enemy tank");
			waittill_either (baker, "enemy tank","death");
		}

		wait (1);
		// Behind you!
		foley anim_single_solo (foley, "behind you");
	}

	if (!level.flag["got panzers"])
	{
		if (!obj0Complete)
		{
			foley notify ("stop being objective");
			objective_state(0, "done");
		}
//		objective_state(0, "done");
		foley notify ("stop being objective");
		objective_add(1, "active", &"DAWNVILLE_OBJ1", getent ("panzerfaust","targetname").origin);
		objective_current(1);
		getent ("infinite panzerfaust","targetname") notify ("infinite panzerfaust objective on");
		thread gotPanzers();
	}

	level notify ("go onward");
	if (isalive (tank))
		foley setgoalnode (foley_finalnode);
//	foley waittill ("goal");

	// Guys that run in from off camera to help the player
	array_thread(getentarray ("reinforcements","targetname"), ::reinforcements_think);
	if ((isalive (tank)) && (!level.flag["got panzers"]))
		wait (4);

	if ((isalive (tank)) && (!level.flag["got panzers"]))
	{
		// That's a Tiger! Martin, get a Panzerfaust from the church and take that mother out!"
		foley anim_single_solo (foley, "get a panzer");
		wait (1);
	}
	
	// Turn on the guys in the church
	level notify ("church defenders start");

	if ((isalive (tank)) && (!level.flag["got panzers"]))
		wait (12);

	array_thread(getentarray ("group2","targetname"), ::spawn_attack);
	if ((isalive (tank)) && (!level.flag["got panzers"]))
		wait (2);

	if ((isalive (tank)) && (!level.flag["got panzers"]))
	{
//		wait (4);
		// Jackson, Baker, we'll draw their fire! Go!"
		foley anim_single_solo (foley, "draw their fire");
		wait (1);
	}

	//iprintlnbold ("<Foley> Alright everybody, LET'S GO!");
	level notify ("final charge");
	level notify ("reinforcements move up");
	if (isalive (tank))
		foley setgoalnode (foley_finalchargeNode);

	if ((isalive (tank)) && (!level.flag["got panzers"]))
		wait (6);

	array_thread(getentarray ("reprimand church","targetname"), ::spawn_attack_moveup);
	ai = getaiarray ("allies");
	for (i=0;i<ai.size;i++)
		ai[i].grenadeammo = 5;

	if ((isalive (tank)) && (!level.flag["got panzers"]))
	{
		// Martin! The Panzerfausts are in the church! Go!
		foley thread anim_single_solo (foley, "panzer reminder");
	}

	ai = getentarray ("third flak defenders","targetname");
	ai = maps\_utility::array_randomize(ai);
	for (i=0;i<ai.size;i++)
	{
		wait (0.5 + randomfloat (1));
		ai[i] thread spawn_attack();
	}

	if (isalive (tank))
		tankBlowsUpBuilding( tank );

	if (!level.flag["got panzers"])
		wait (4);

	if (!level.flag["got panzers"])
	{
		// Martin! The church! Go! Go! Go!
		foley thread anim_single_solo (foley, "panzer reminder 2");
	}
}

sequence_1_tank (obj0Complete)
{
	flag_wait ("got panzers");
	foley = getent ("foley", "targetname");
	foley.goalradius = 512;
	tank = getent ("tank east","targetname");

	if (!obj0Complete)
	{
		foley notify ("stop being objective");
		objective_state(0, "done");
	}

	if (isalive (tank))
	{
		objective_add(2, "active", &"DAWNVILLE_OBJ2", getent ("tank east","targetname").origin);
		level thread objective_org (2, getent ("tank east","targetname"));
		objective_current(2);
//	array_thread(getentarray ("flak_attack","targetname"), ::spawn_attack);
		thread more_attackers();
		flag_wait ("east tank destroyed");
		objective_state(2, "done");
	}
//	wait (2.5);
//	array_thread(getentarray ("flak_attack","targetname"), ::spawn_attack);

}

sequence_2() // Defend the Church
{
	flak_trigger = getent ("at flak","targetname");
	foley = getent ("foley", "targetname");

	level waittill ("picked up infinite panzerfaust");
/*
	trigger = getent ("get panzer","targetname");
	trigger waittill ("trigger");
	trigger delete();
*/
	flag_set("got panzers");
	flag_wait ("east tank destroyed");
	flag_set ("church under siege");
	// Turn off rear MG42s for friendly use.
	array_thread(getentarray ("church rear","script_noteworthy"), maps\_utility::triggerOff);
	

	wait (0.5);
	// Martin - back to the church with me! The rest of you hold this position!
	foley anim_single_solo (foley, "to the church");
	node = getnode ("church","targetname");
	foley setgoalnode (node);
/*
	foley.goalradius = 32;
	foley waittill ("goal");
	foley.goalradius = 512;
*/
	//Defend the Church.
	objective_add(3, "active", &"DAWNVILLE_OBJ3", (214, -15984, 64));
	objective_current(3);
	maps\_spawner::kill_spawnerNum(10);
	maps\_utility::autosave(3);

	level thread player_at_church_trigger();
	foley lookat( foley, 0 );

	thread sequence_3();
}

sequence_3 ()
{
	foley = getent ("foley", "targetname");
	lewis = get_noteworthy_ai ("lewis");
	franklin = get_noteworthy_ai ("franklin");
	backyard_trigger = getent ("backyard","targetname");
	player_advance_trigger = getent ("player advances","targetname");
	push_germans_back_trigger = getent ("end of the road", "targetname");
	regroup_friendly_trigger = getent ("regroup friendly chain","targetname");

	church_trigger = getent ("at church","targetname");
	church_trigger waittill ("trigger");


	flag_wait ("falling back");
	wait (8);

	thread foley_moves_on_trigger ( getent ("foley moves on","targetname") );

	spawners = getentarray ("second flak guys","targetname");
	for (i=0;i<spawners.size;i++)
		spawners[i] thread second_flak_think();

	maps\_spawner::kill_spawnerNum(2);
	// "They're pullin' back! Alright! Good work, but don't let down. They'll be back."
	foley anim_single_solo (foley, "germans retreat");

	if ((isalive (lewis)) && (isalive (franklin)))
	{
		foley lookat( franklin );
		// Lewis, Franklin, hold the church."
		foley anim_single_solo (foley, "L + F hold church");
	}
	else
	if (isalive (lewis))
	{
		foley lookat( lewis );
		// Lewis, hold the church."
		foley anim_single_solo (foley, "L hold church");
	}
	else
	if (isalive (franklin))
	{
		foley lookat( franklin );
		// Franklin, hold the church."
		foley anim_single_solo (foley, "F hold church");
	}

	if ((isalive (lewis)) || (isalive (franklin)))
	{
		if (isalive (lewis))
			foley lookat( lewis );
		else
			foley lookat( franklin );

		// Everyone else, follow me!"
		foley anim_single_solo (foley, "everyone else follow");
	}
	else
	{
		// Everyone follow me!
		foley anim_single_solo (foley, "everyone follow");
	}

	flag_wait ("player is at church");
	if (!flag ("foley moves on"))
	{
		foley setgoalnode (getnode (getent ("foley moves on","targetname").target, "targetname"));
		foley.goalradius = 4;
		thread foley_moves_on_followup(foley);
	}
	else
		foley setgoalentity (level.player);

	level notify ("kill second flak early trigger");
	objective_state(3, "done");

	//Reinforce the Northern approach.
	objective_add(4, "active", &"DAWNVILLE_OBJ4", (2336, -15887, -20));
	objective_current(4);
	// Turn the front mg42 off.
	array_thread(getentarray ("church front","script_noteworthy"), maps\_utility::triggerOff);
	
	flag_set("church has been defended");

	clip = getent ("second flak monster clip","targetname");
	clip disconnectpaths();
	clip solid();

	foley lookat( foley, 0 );
	chain = get_friendly_chain_node ("50");
	level.player SetFriendlyChain (chain);

	// Make foley run ahead then wait for the player.
//	thread foley_moves_on (foley, getent ("foley moves on","targetname"));

	spawn = getentarray ("second flak defenders","targetname");
	for (i=0;i<spawn.size;i++)
	{
		if (spawn[i].team != "allies")
			continue;

		spawn[i] setgoalentity (level.player);
	}

	guys = getentarray ("churchgoer guys","targetname");
	for (i=0;i<guys.size;i++)
		guys[i] setgoalentity (level.player);

	if (level.player istouching (church_trigger))
	{
		church_exit_trigger = getent ("foley church trigger","targetname");
		while (1)
		{
			church_exit_trigger waittill ("trigger", other);
			if (other == level.player)
				break;
		}

		array_thread(getentarray ("church spawner","targetname"), ::spawner_follow_player);
	}

//	foley setgoalentity (level.player);
//	array_thread(getentarray ("group3","targetname"), ::spawn_attack);

	trigger = getent ("second flak guys trigger", "targetname");
	trigger waittill ("trigger");
	maps\_spawner::kill_spawnerNum(10);
	maps\_spawner::kill_spawnerNum(11);
	maps\_spawner::kill_spawnerNum(12);

	// Kill unnecessary axis
	ai = getaiarray ("axis");
	for (i=0;i<ai.size;i++)
	{
		if ((isdefined (ai[i].script_noteworthy)) && (ai[i].script_noteworthy == "second flak germans"))
			continue;

		ai[i] DoDamage ( ai[i].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
	}
	
	maps\_utility::autosave(4);

	level thread player_got_too_close (getent ("target the player","targetname"));

	wait (10);
	array_thread(getentarray ("group5","targetname"), ::spawn_attack);
	wait (9);
	array_thread(getentarray ("group4","targetname"), ::spawn_attack);
//	array_thread(getentarray ("group4","targetname"), ::spawn_attack);
	wait (5);
	array_thread(getentarray ("group5","targetname"), ::spawn_attack);
	wait (5);
	axis_trigger = getent ("germans under arch","targetname");
	wait_until_no_axis (axis_trigger); // Wait until all the axis here are dead.

	clip = getent ("second flak monster clip","targetname");
	clip connectpaths();
	clip delete();

	chain = get_friendly_chain_node ("150");
	level.player SetFriendlyChain (chain); // Make friendlies move up to the first flak area.
	level notify ("friendlies push germans back");

	// They're fallin' back! Push 'em outta here! Move it -- go!
	foley thread anim_single_solo (foley, "push them back");
	objective_position(4, getnode ("third objective", "targetname").origin);

	wait (0.8);

	player_advance_trigger maps\_utility::triggerOn();
	thread guyFleesTank (player_advance_trigger);

	player_advance_trigger waittill ("trigger"); // Wait until the player advances with the friendlies
	
	// Turn the rear church mg42 back on once the player reenters the church.
	thread turnChurchMG42backOn();
	
//	wait_until_no_axis (getent ("germans at second flak","targetname"));
	thread mortar_drop_on_axis();
	thread mortar_drop_nearplayer();

	thread sequence_3b();

	wait (1);
	//iprintlnbold ("<Foley> Mortars!! Let's find that mortar team!");
	objective_state(4, "done");
	maps\_utility::autosave(5);
	// Take out the mortar team
	objective_add(5, "active", &"DAWNVILLE_OBJ5", getent ("faux mortar","targetname").origin);
	objective_current(5);
	foley.followmin = 4;
	foley.followmax = 12;
	push_germans_back_trigger maps\_utility::triggerOn();
	regroup_friendly_trigger maps\_utility::triggerOn();

	chain = get_friendly_chain_node ("115");
	level.player SetFriendlyChain (chain); // Make friendlies move up to the first flak area.
	foley thread anim_single_solo (foley, "regroup");
}

sequence_3b ()
{

	foley = getent ("foley","targetname");

	start_tank_trigger = getent ("start tank","targetname");
	start_tank_trigger maps\_utility::triggerOn();
	level thread distantTankRumble();

	start_tank_trigger waittill ("trigger"); // Wait for the player to double back

//	wait (3);
	level notify ("tank start northeast");
	array_thread(getentarray ("east mg42","script_noteworthy"), maps\_utility::triggerOff);
	
	wait (0.05);
	// Friendly chain in the middle of the level
//	maps\_utility::chain_on ("125");
//	level thread tempPlayerKill (getent ("player tank death","targetname"));
	thread foleyTakeCover(foley);
	thread killAIbehindTank();
	
	
	//trigger = getent ("tank target","targetname");
	//trigger waittill ("trigger");

	//Destroy the second tank.

	playerWeapon[0] = level.player getweaponslotweapon("primary");
	playerWeapon[1] = level.player getweaponslotweapon("primaryb");
	if ((playerWeapon[0] == "panzerfaust") || (playerWeapon[1] == "panzerfaust"))
	{
		objective_string(5, &"DAWNVILLE_OBJ5SECONDTANK");
		level thread objective_org(5, getent ("tank northeast","targetname"));
		level thread tankObjectiveComplete();
	}
	else		
	{
		objective_string(5, &"DAWNVILLE_OBJ1");
		objective_position(5, getent ("panzerfaust","targetname").origin);
		getent ("infinite panzerfaust","targetname") notify ("infinite panzerfaust objective on");
		thread tankReplacesObjective();
		thread foleyTellsYouToGetAnotherPanzerfaust(foley);
	}
		
	objective_current(5);
	level notify ("stop tank rumble");
	
	// SPlash shield change
	tank = getent ("tank northeast","targetname");
	tank.health = 1000;
	tank thread splash_shield();
	
	

//	thread constant_attack("flak_attack", 15);

	foley setgoalentity (level.player);
	foley.goalradius = 250;
	foley lookat( level.player, 4 );
//	wait (14);
	level notify ("tank start west");
	thread tank_west_trigger( getent ("last tank attacks","targetname") );
	flag_wait ("northeast tank destroyed");

	wait (0.1); // Duh the notifies happen simultaneously

	wait (1);
	maps\_utility::autosave(6);
	wait (1);
	// Nice shot, Martin."
	if (isalive (level.player))
		foley thread anim_single_solo (foley, "hey man nice shot");
		
	if (!flag("chain 125 off forever"))
	{
		regroup_friendly_trigger = getent ("regroup friendly chain","targetname");
		regroup_friendly_trigger maps\_utility::triggerOff();
		chain = get_friendly_chain_node ("125");
		level.player SetFriendlyChain (chain);
	}	

	/*
	objective_add(7, "active","", (-4288,-15629,76));
	objective_string(7,&"DAWNVILLE_OBJ7",2);
	//Destroy the mortar team [%s remaining]
	objective_current(7);
	*/
	
	sequence_4(); // Broken off to be able to start at sequence 4 for testing.
}

splash_shield ()
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

sequence_4 ()
{
	// Throw some guys out there to defend the latest tank
	array_thread(getentarray ("flak_attack","targetname"), ::spawn_attack);
	// Guy that runs up and tells foley about the mortar guys.
	thread parkerSpawnerThink();

	foley = getent ("foley", "targetname");
//	array_levelthread (getentarray ("reinforcers","targetname"), ::tank_west_escort);

	if (!flag("west tank destroyed"))
	{
		if (!flag ("west tank attacks"))
		{
			objective_add(6, "active", &"DAWNVILLE_OBJ5", getent ("faux mortar 2","targetname").origin);
			objective_current(6);
			flag_wait ("west tank attacks");
		}
		if (!flag("west tank destroyed"))
		{
	//		// Guys that run out ahead to shoot the player!
	//		array_levelthread (getentarray ("reinforcers","targetname"), ::tank_west_escort);
			//Destroy the third tank.
			objective_add(6, "active", &"DAWNVILLE_OBJ6", getnode ("final goal", "targetname").origin);
			objective_current(6);
	//		objective_string(7,&"DAWNVILLE_OBJ7",mortarTeams);
			level thread objective_org (6, getent ("tank west","targetname"));
	//		objective_current(6);
	
	//		iprintlnbold ("<Random Guy> Another tank! He's moving in quick!");
			flag_wait ("west tank destroyed");
		}
		objective_state(6, "done");
//		thread niceShot(foley);
	}
	thread sequence_5();
	
	foley.followMin = 0;
	foley.followMax = 5;

//	level notify ("tank killers go!");
	thread mortar_ongoing();
	flag_wait ("parker speech");
//	foley setgoalnode (getnode ("foley prep","targetname"));
	println ("foley go to node");
	foley setgoalentity (level.player);
	maps\_utility::chain_on ("500");
}

sequence_5 ()
{
	mortarTeams = level.mortar_team_position.size;
	if (mortarTeams > 0)
	{
//		maps\_utility::autosave(7);
//		chain = get_friendly_chain_node ("100");
//		level.player SetFriendlyChain (chain);

		objectiveOrg = level.mortar_team_position[mortarTeams-1];
		objective_add(7, "active","", objectiveOrg);
		//Destroy the mortar team [%s remaining]
		objective_string(7,&"DAWNVILLE_OBJ7",mortarTeams);
		objective_current(7);

		kill_germans_at_trigger( "germans at second flak" );

		while (1)
		{
			level waittill ("Mortar Team Dispatched");
			mortarTeams = level.mortar_team_position.size;
			println ("mortar: ", mortarTeams, " mortars left");

			if (mortarTeams > 0)
			{
 				objectiveOrg = level.mortar_team_position[mortarTeams-1];
				objective_add(7, "active","", objectiveOrg);
				//Destroy the mortar team [%s remaining]
				objective_string(7,&"DAWNVILLE_OBJ7",mortarTeams);
				objective_current(7);
				if (isalive (elder))
					elder thread getToNode ("elder");
				if (isalive (moody))
					moody thread getToNode ("moody");

			}
			else
				break;
		}
//		trigger = getent ("final area","targetname");
//		trigger waittill ("trigger");
//		wait_until_no_axis (trigger);
		//Destroy the mortar team [%s remaining]
	}

	objective_string(7,&"DAWNVILLE_OBJ7",0);
	objective_state(7, "done");
	//Regroup with Cpt Foley at the French car.
	flag_wait ("parker speech");
	objective_add(8, "active", &"DAWNVILLE_OBJ8", (getent ("end level trigger", "targetname")) getorigin());
	objective_current(8);
	level notify ("mortars ongoing STOP");
	flag_wait ("friendlies report to the car");

	foley = getent ("foley","targetname");
	flag_wait ("moody exists");
	
	moody = level.moody;
	flag_wait ("elder exists");
	elder = level.elder;

	elder getToNode ("elder");
	moody getToNode ("moody");
	foley lookat( foley, 0 );

	car = getent ("car","targetname");
	level.car = car;
	car.health = 50000;
	car makeVehicleUnusable();	//not usable until appropriate moment
//	car playloopsound ("peugeot_idle_low");
	car.animname = "car";
	car assignanimtree();
	
	door_solid = getent ("car door","targetname");
	door_solid linkto (car, "tag_door_back_left", (0,0,0), (0,90,0));

	if (!isdefined (foley))
		maps\_utility::error ("no foley");
	if (!isdefined (moody))
		maps\_utility::error ("no moody");
	if (!isdefined (elder))
		maps\_utility::error ("no elder");

//	carbase anim_single_solo ( car, "start");
	moody linkto (car, "tag_driver", (0,0,0), (0,0,0));
	moody animscripts\shared::PutGunInHand("none");
	elder linkto (car, "tag_passenger", (0,0,0), (0,0,0));

	car thread anim_loop_solo ( moody, "idle", "tag_driver", "moody stop");
	car thread anim_loop_solo ( elder, "startidle", "tag_passenger", "elder stop");
	
	maps\_spawner::kill_spawnerNum(7);
	maps\_spawner::kill_spawnerNum(8);
	thread killAllAxisOverTime();
	
	car attachPath( getvehiclenode ("ride out","targetname"));
	car startPath();
	wait (0.1);
//	car thread maps\_utility::playLoopSoundOnTag("peugeot_idle_high", "tag_origin");
	car waittill ("reached_end_node");
	car setanim (level.scr_anim[car.animname]["start"]);

	foley setgoalnode (getnode ("foley node","targetname"));
	println ("foley go to foley node");
	foley.goalradius = 256;	
//	car anim_reach_solo ( foley, "reach idle", "tag_driver");
	foley allowedstances ("crouch","stand");
	
	println ("foley must now get to foley node");
	foley getToNode ("foley");

	foley attach("xmodel/dawnville_pencil", "tag_weapon_right");
	foley attach("xmodel/dawnville_map", "tag_weapon_left");

	foley animscripts\shared::PutGunInHand("none");
	car thread anim_loop_solo ( foley, "idle", "tag_driver", "foley stop");
	thread getInCar(getent ("end level trigger","targetname"));
	end_level_trigger = getent ("end level trigger","targetname");
	end_level_trigger maps\_utility::triggerOn();
	end_level_trigger setHintString(&"DAWNVILLE_CAR");
	end_level_trigger enableLinkto();
	end_level_trigger linkto (car, "tag_door_back_left", (0,0,0), (0,90,0));
	
//	moody lookat (level.player);
	while (1)
	{
		car notify ("moody stop");
//		carbase thread anim_single_solo (moody, "01");
		car anim_single_solo ( moody, "wave", "tag_driver");
		car thread anim_loop_solo ( moody, "idle", "tag_driver", "moody stop");

		timer = 5 + randomfloat (8);
		timer *= 1000;
		timer += gettime();

		breaker = false;
		while (gettime() < timer)
		{
			if (flag("player got in car"))
			{
				breaker = true;
				break;
			}
			else
				wait (0.1);
		}
		if (breaker)
			break;
	}
	
//	moody lookat (moody, 0);
	end_level_trigger delete();
	door_solid delete();
	
	objective_state(8, "done");
	
/*	
	carbase anim_single_solo ( car, "playerin");
	car.origin = carbase.origin;
	car.angles = carbase.angles;

	carbase notify ("elder stop");
	carbase thread anim_single_solo ( car, "trans");
	carbase anim_single_solo ( elder, "trans", "tag_passenger");
	carbase thread anim_loop_solo ( elder, "idle", "tag_passenger");
//	carbase thread anim_loop_solo ( car, "idle", "tag_passenger");
	car.origin = carbase.origin;
	car.angles = carbase.angles;

*/
	car notify ("elder stop");
	car notify ("moody stop");
	car notify ("foley stop");
	foley allowedstances ("stand");
	
	foley setgoalnode (getnode ("foley hide","targetname"));
	foley.goalradius = 4;
	car thread anim_single_solo ( elder, "end", "tag_passenger");
	car thread anim_single_solo ( foley, "end", "tag_driver");
//	car thread anim_single_solo ( car, "end");
	car setanimknob (level.scr_anim[car.animname]["end"]);
	level thread playSoundinSpace ("car_door_close", car.origin);
	car anim_single_solo ( moody, "end", "tag_driver");
	
	car thread anim_loop_solo ( elder, "idle", "tag_passenger");
	car thread anim_loop_solo ( moody, "endidle", "tag_driver");
	

//	objective_add(8, "active", "Regroup with Cpt Foley at the French car.", (getent ("end level trigger", "targetname")) getorigin());
//	objective_current(8);

//	if (level.playerWeapon[0] != "none")
//		level.player giveWeapon(level.playerWeapon[0]);
//	if (level.playerWeapon[1] != "none")
//		level.player giveWeapon(level.playerWeapon[1]);
	
	missionSuccess ("carride", true);

//	foley waittill ("goal");
}

getInCar( trigger )
{
	trigger waittill ("trigger");
	level.car setmodel ("xmodel/vehicle_car");
	org = spawn ("script_origin",(0,0,0));
	org.origin = level.player.origin;
	level.player linkto (org);
	car = getent ("car","targetname");
	origin = car gettagOrigin ("tag_player");
	org moveto (origin, 1, 0.5, 0.5);
	wait (0.8);
	flag_set ("player got in car");
	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowProne(false);
	level.player allowCrouch(false);
//	level.playerWeapon[0] = level.player getweaponslotweapon("primary");
//	level.playerWeapon[1] = level.player getweaponslotweapon("primaryb");
//	level.player takeallweapons();
}

carTrigger ( trigger )
{
	trigger waittill ("trigger");
	tank = getent ("tank west","targetname");
	if (isalive (tank))
		radiusDamage (tank.origin, 2, tank.health + 5000,  tank.health + 5000); // mystery numbers!
	
	flag_wait ("parker speech");
	flag_set ("friendlies report to the car");
	foley = getent ("foley","targetname");
	flag_wait ("moody exists");
	flag_wait ("elder exists");
	
	moody = level.moody;
	elder = level.elder;
	foley.dontavoidplayer = true;
	foley setgoalnode (getnode ("foley node","targetname"));
	moody.dontavoidplayer = true;
	moody setgoalnode (getnode ("moody node","targetname"));
	elder.dontavoidplayer = true;
	elder setgoalnode (getnode ("elder node","targetname"));
}

getToNode( msg )
{
	node = getnode (msg + " node","targetname");
	self.goalradius = 4;
	while (distance (self.origin, node.origin) > 32)
	{
		self setgoalnode (node);
		self waittill ("goal");
	}
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

anim_teleport_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim::anim_single (newguy, anime, tag, node, tag_entity);
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

anim_reach_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim::anim_reach (newguy, anime, tag, node, tag_entity);
}

array_thread (ents, process, var, excluders)
{
	maps\_utility::array_thread (ents, process, var, excluders);
}

array_levelthread (ents, process, var, excluders)
{
	maps\_utility::array_levelthread (ents, process, var, excluders);
}

random (array)
{
	return array [randomint (array.size)];
}

lookat (ent, timer)
{
	if (!isdefined (timer))
		timer = 10000;

	self animscripts\shared::lookatentity(ent, timer, "alert");
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

assignanimtree()
{
	self UseAnimTree(level.scr_animtree[self.animname]);
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

	if (getcvar ("cg_blood") == "0")
		level._effect["flesh small"] = level._effect["ground"];
	
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

delete_on_death (ent)
{
	ent endon ("death");
	self waittill ("death");
	if (isdefined (ent))
		ent delete();
}

kill_ai_touching (trigger, team)
{
	println ("^2 killing AI touching trigger");
	
	ai = getaiarray (team);
	for (i=0;i<ai.size;i++)
	{
		if (ai[i] istouching (trigger))
		{
			println ("killing ai at origin ", ai[i].origin);
			ai[i] DoDamage ( ai[i].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
		}
	}
}