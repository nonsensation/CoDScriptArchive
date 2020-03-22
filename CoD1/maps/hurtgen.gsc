#using_animtree ("generic_human");
main()
{
	precachemodel("xmodel/vehicle_tank_PanzerIV_camo_d");
	precachemodel("xmodel/scriptorigin");
	fx = loadfx("fx/explosions/explosion1.efx");

	setCullFog (0, 2000, .32, .36, .40, 0 );
	maps\_load::main();
	maps\hurtgen_anim::main();
	maps\_panzerIV::main();
//	maps\_flak::main();
	level.starting_health = level.player.health;
	println ("starting health: ", level.starting_health);

    	level.mortar = loadfx ("fx/surfacehits/mortarImpact_snow.efx");

    	level.ambient_track ["inside"] = "ambient_hurtgen_int";
	level.ambient_track ["outside"] = "ambient_hurtgen_ext";
	thread maps\_utility::set_ambient("outside");

	level.flag["follow player"] = false;
	level.flag["moving"] = false;
	level.flag["tank talk"] = false;

	
//	thread dead_guys();
	thread foleytrigger();
	thread foley();
	thread maps\_mortar::hurtgen_style();
	thread start();
	thread chain_start();
	thread documents_autosaves();
	thread ai_overrides();
	thread chain_triggers();
	thread music();
  
	thread mg_badplaces("mg_gunners", (1448, -3906, -196), 1600, (-1, 0, 0), 60, 60);
	thread mg_badplaces("mg_1", (1832, -2007, -196), 1600, (-1, 0, 0), 30, 35);
	thread mg_badplaces("mg_2", (2215, -1682, -187), 1110, (-1, 0, 0), 35, 5);
//	thread mg_badplaces("mg_3", (2095, -1758, -195), 1600, (0, 1, 0), 30, 35);

	thread mg_badplaces("mg_4", (3324, 626, -127), 1600, (0, -1, 0), 35, 35);
	thread mg_badplaces("mg_5", (3071, 892, -111), 1600, (-1, 0, 0), 25, 35);
//	thread mg_badplaces("mg_6", (2993, 1012, -111), 1600, (0, -1, 0), 35, 5);
	



	level.flak1 = getent("flak1", "targetname" );
	level.flak2 = getent("flak2", "targetname" );
	level.flak1 thread flak88_init();
	level.flak2 thread flak88_init();
	level.flak1 thread maps\_flak::flak88_playerinit(level.flak1, level.flak2);
	level.flak1.script_flaktype = "flakair";
	level.flak2.script_flaktype = "flakair";

	vec1 = (4446, 1356, 496);
	level.flak1 setTurretTargetVec(vec1);

	vec2 = (3892, -1856, 496);
	level.flak2 setTurretTargetVec(vec2);
	maps\_flak::main();
	
//	maps\_utility::array_thread (getentarray ("deadguys","script_noteworthy"), ::dead_guys);

	maps\_treefall::main();

	//1 Capture enemy documents [3 remaining]
	thread maps\_documents::main(1, &"HURTGEN_OBJ_DOCUMENTS", "documents");
	objective_current(1);

	thread tanks_objective();
	//2 Destroy the German tanks [2 remaining]

}


//////////---------------------------

//dead_guys()
//{
//	self waittill ("spawned",deadguys);
//	if (maps\_utility::spawn_failed(deadguys))
//		return;
		
//	deadguys delete();
//}

tanks_objective()
{
	tank1 = getent ("tank1", "targetname");
	tank2 = getent ("tank2", "targetname");
	tank2.lasttrig = level.player; // from teh ghetto
	remaining_tanks = 2;
//	obj_text = &"HURTGEN_OBJ2";
//	objective_add(2, "active", "", (tank1.origin));
//	objective_string(2, obj_text ,remaining_tanks);
	

//////////////////////
	level waittill ("objective_complete1");
//////////////////////

//	iprintlnbold ("obj1 complete");
//	level.foley.followmax = -1;
//	level.foley.followmin = 1;
//	level.foley.goalradius = 350;


//	iprintlnbold ("waittill trigger");
//	level waittill ("tank talk");
//	iprintlnbold ("triggered");

	//* Martin, quick! We've got two Panzers comin' over the ridge!  Get on one of those 88's and take 'em out!
	foleyarray[0] = level.foley;

	nodes = getnodearray ("foleynode", "targetname");
	node = maps\_utility::getClosest(level.player.origin, nodes);
//	anim_teleport (guy, anime, tag, node, tag_entity)

	level.foley maps\_anim::anim_teleport (foleyarray, "quick panzers", undefined, node);
	
	level.foley maps\_anim::anim_reach (foleyarray, "quick panzers", undefined, node);
	
	flag_wait ("tank talk");
	
	thread playtanksound();
	
	tanksound = getent ("tanksound", "targetname");
	tanksound playloopsound ("panzerIV_engine_high");
	
	level.foley maps\_anim::anim_single_solo (level.foley, "quick panzers", undefined, node);
//	level.foley maps\_anim::anim_single_solo (level.foley, "quick panzers");

//	iprintlnbold ("foley spoke");
	
//	friends = getaiarray ("allies");
//	for (i=0;i<friends.size;i++)
//	{
//		friends[i].followmax = -1;
//		friends[i].followmin = 1;
//		friends[i].goalradius = 768;
//		friends[i] setgoalentity (level.player);
//	}

	obj_text = &"HURTGEN_OBJ2";
	objective_add(2, "active", "", (tank1.origin));
	objective_string(2, obj_text ,remaining_tanks);
	objective_current(2);
	
	level.foley.followmax = -1;  
	level.foley.followmin = 1;   
	level.foley.goalradius = 512;
	level.foley setgoalentity (level.player);
	
	maps\_utility::array_thread (getentarray ("end_wave","targetname"), ::spawn_attack);

	wait 6;
	
	level notify ("tanks spawned");
	
	tank1 tanks_obj_setup();
	tank2 tanks_obj_setup();
	tank2snode2 = getvehiclenode("auto1775","targetname");
	tank2snode1 = getvehiclenode("auto1774","targetname");
	tank2 setswitchnode(tank2snode1,tank2snode2);
	thread tankswitchers();

/*
	tank1_mg42 = getent("tank1_mg42","targetname");
	tank1_mg42 linkto(tank1, "tag_turret2", (0, 0, 0), (0, 0, 0));
	tank1_mg42 setmode("manual");
	level thread maps\_tankmg42::tank_mg42targeting(tank1, tank1_mg42);

	tank2_mg42 = getent("tank2_mg42","targetname");
	tank2_mg42 linkto(tank2, "tag_turret2", (0, 0, 0), (0, 0, 0));
	tank2_mg42 setmode("manual");
	level thread maps\_tankmg42::tank_mg42targeting(tank2, tank2_mg42);
*/
//	tank2 thread tank_distance_check(tank1);

	while ((isalive (tank1)) && (isalive (tank2)))
	{
		wait 1;
	}
	remaining_tanks = 1;
	objective_string(2, obj_text ,remaining_tanks);

	while ((isalive (tank1)) || (isalive (tank2)))
	{
		wait 1;
	}

	remaining_tanks = 0;
	objective_string(2, obj_text ,remaining_tanks);
	objective_state(2, "done");
	level notify ("tanks dead");
	
//	level.foley.followmax = -1;  
//	level.foley.followmin = 1;   
//	level.foley.goalradius = 350;

	while (1)
	{
		d = distance (level.player getorigin(), level.foley.origin);
		if (d < 400)
		{
			break;
		}
		//println ("distance: ", d);
		wait 1;
	}

	//* Great job on those tanks.  Private Martin, you've done yourself proud.  I can hardly believe. . .we've done it.
//	foleyarray[0] = level.foley;
//
//	nodes = getnodearray ("foleyendnode", "targetname");
//	node = maps\_utility::getClosest(level.foley.origin, nodes);

//	level.foley maps\_anim::anim_reach (foleyarray, "great job", undefined, node);

	wait 3;
	level.foley maps\_anim::anim_single_solo (level.foley, "great job");
	level.foley thread maps\_anim::anim_single_solo (level.foley, "paused");


	//changelevel(<mapname>, <persistent> = false);
	//persistent: if you want the player to keep their inventory through the transition.
	setCvar("ui_campaign", "british"); // next mission is british, this fixes the loading screen
	missionSuccess("rocket", false);
}

playtanksound()
{
	tanksound = getent ("tanksound", "targetname");
	tanksound playloopsound ("panzerIV_engine_high");
	level waittill ("tanks spawned");
	wait (2);
	tanksound delete();
}

tanks_obj_setup()
{
	self.script_team = "axis";
	self thread maps\_tankgun::mginit();

	path = getvehiclenode (self.target, "targetname");
	self attachPath( path );
	
	self startPath();

	self.attack_range = 1650;
	//self.attack_range = 1350;
	self.health = 500;
	self.playersafe = true;
	self.so1 = spawn ("script_origin", (self.origin + (-160,-160,100)) );
	self.so2 = spawn ("script_origin", (self.origin + (160,-160,100)) );
	self.so1 linkto (self);
	self.so2 linkto (self);
/*
	self.targ_mdl1 = spawn ("script_model", (self.origin + (-160,-160,100)) );
	self.targ_mdl2 = spawn ("script_model", (self.origin + (160,-160,100)) );
	self.targ_mdl1 setmodel ("xmodel/temp");
	self.targ_mdl2 setmodel ("xmodel/temp");
	self.targ_mdl1 linkto (self);
	self.targ_mdl2 linkto (self);
*/
	self.next_target = 1;
	self.current_target = self.so1;
//	println ("here0: ", self.current_target);

	self thread maps\_panzerIV::init_noattack();
//	self thread distance_printer();
	self thread tank_player_safe_check();
	self thread tank_scan_mode();
	self thread tank_kill_mode();
	self thread splash_shield();

	self thread disconnectpathsatzero();
//	self waittill( "reached_end_node" );
//	self disconnectpaths();
}

disconnectpathsatzero()
{
	wait 2; //give it time to have a speed before doing this stuff.
	self setwaitspeed(0);
	while(1)
	{
		self waittill("reached_wait_speed");
		println("waitspeed reached!!");
		self disconnectpaths();
		self waittill ("resumed");
		self connectpaths();
	}
}


splash_shield()
{
	healthbuffer = 2000;
	self.health += healthbuffer;
	currenthealth = self.health;
	while(self.health > 0)
	{
		self waittill ("damage",amount, attacker);

		if((amount) < 999)
			self.health = currenthealth;
		else
			currenthealth = self.health;
		if(self.health < healthbuffer)
			break;
	}
	radiusDamage ( self.origin, 2, 10000, 9000);
}


tank_player_safe_check()
{
	while (self.health > 0)
	{
		if (distance (self.origin, level.player.origin) < self.attack_range)
		{
			tank_trace_org = (self.origin + (0,0,100));
			player_trace_org = (level.player.origin + (0,0,60));
			CheckShot = bulletTrace( tank_trace_org, player_trace_org, false, self);
			if(CheckShot["fraction"] == 1)
			{
				self.playersafe = false;
				self setTurretTargetEnt(level.player, (0,0,40));
				self notify ("player_not_safe");
				//iprintln ("player not safe - trace");
				color = (1,0.2,0.3);
			}
			else
			{
				self.playersafe = true;
				self setTurretTargetEnt(self.current_target, (0,0,0));
				self notify ("player_safe");
				//iprintln ("player safe - trace");
				color = (.2,1,1);
			}
			//self thread tank_drawline(tank_trace_org, player_trace_org, color);
		}
		else
		{
			self.playersafe = true;
			self setTurretTargetEnt(self.current_target, (0,0,0));
			self notify ("player_safe");
			//iprintln ("player safe - distance");
		}
		wait 5;
	}
}

tank_drawline(pos1, pos2, color)
{
	for (i=0; i<10;i++)
	{
		line (pos1, pos2, color, 0.5);
		wait .1;
	}
}
tank_scan_mode()
{
	while (self.health > 0)
	{
		while (self.playersafe == true)
		{
			if (self.next_target == 1)
			{
				self.current_target = self.so1;
			//	println ("here1: ", self.current_target);
				self.next_target = 2;
			}
			else
			{
				self.current_target = self.so2;
			//	println ("here2: ", self.current_target);
				self.next_target = 1;
			}

			//iprintln ("^2 aiming at new scan mode target");
			self waittill("turret_on_vistarget");
		}
		self waittill ("player_safe");
		self clearTurretTarget();
	}
}

tank_kill_mode()
{
	while (self.health > 0)
	{
		while (self.playersafe == false)
		{
		//	iprintln ("^2 aiming at player");
		//	self setTurretTargetEnt(level.player, (0,0,0));
			self waittill("turret_on_target");
			if (self.playersafe == false)
			{
				self waittill("turret_on_vistarget");
				if (self.health > 0)
					self FireTurret();
			//	self notify( "turret_fire" );
			//	iprintln ("^6TANK FIRES");
				wait 7;
				//iprintln ("^2 done reloading");
			}
		}
		self waittill ("player_not_safe");
		self clearTurretTarget();
	}
}

///////////////////////////////


distance_printer()
{
	while (1)
	{
		iprintln (distance (self.origin, level.player.origin), " player is safe: ", self.playersafe );
		wait .5;
	}
}

tank_distance_check(other_tank)
{
	while (1)
	{
		if ( (!isalive (self)) || (!isalive (other_tank)) )
			break;
		d = distance (self.origin, other_tank.origin);
		if (d < 700)
		{
			self setSpeed( 0, 20);
			break;
		}
		wait 1;
	}
}

//////////---------------------------
documents_autosaves()
{
	level.gotten_docs = 0;

	while (level.gotten_docs < 2)
	{
		level waittill ("documents gotten");

		level.gotten_docs++;
		time = gettime();
		if (isdefined (level.old_time) )
		{
			if ( time > (level.old_time + 4000) )
				maps\_utility::autosave(level.gotten_docs + 1);
		}
		else
		{
			maps\_utility::autosave(level.gotten_docs + 1);
		}
	}
}

foley()
{
	level.foley = getent ("foley", "targetname");
	level.foley thread maps\_utility::magic_bullet_shield();
	level.foley character\_utility::new();
	level.foley character\Foley_winter::main();
	level.foley.animname = "foley";

	bunker_triggers = getentarray ("bunker", "targetname");
	for (i=0; i<bunker_triggers.size; i++)
		bunker_triggers[i] thread bunkers();
}

bunkers()
{
	self waittill ("trigger");

	if (isdefined (level.bunker) )
	{

	//* Martin, that bunker's yours.  Take any documents you find.
	level.foley thread maps\_anim::anim_single_solo (level.foley, "same drill");

	}
	else
	{
		level.bunker = "said";

		//* Same drill Martin.  Clear this bunker and search for documents.
		level.foley thread maps\_anim::anim_single_solo (level.foley, "that bunker");
		level notify ("bunker music start");
	}
}



//////////---------------------------
start()
{
	friends = getaiarray ("allies");
	for (i=0;i<friends.size;i++)
	{
		friends[i] setgoalpos (friends[i].origin);

		if (randomint (2) == 0)
		{
			friends[i] allowedStances ("crouch");
		}
	}

//START DIALOGUE###############################################

	level.foley allowedStances ("stand");

	level waittill ("finished intro screen");
	wait .2;
	//* Gentlemen, we've fought a whole bunch of these, so I know you know what to do.
	level.foley maps\_anim::anim_single_solo (level.foley, "indulge me");

	thread timer();
	thread keep_moving();


	friends = getaiarray ("allies");
	for (i=0;i<friends.size;i++)
		friends[i] thread run();

	wait (2);

	level notify ("start_mortars");
}

keep_moving()
{
	trigger = getent ("keep_moving", "targetname");
	trigger waittill ("trigger");

	//* Keep moving guys, don't stop!
	level.foley thread maps\_anim::anim_single_solo (level.foley, "keep moving");
}

timer()
{
	level.timer_trigger = "not_hit";
	trigger = getent ("end_timer", "targetname");
	trigger thread timer_trigger();

	wait (40);
	if (level.timer_trigger != "hit")
		println ("10 SECONDS LEFT");

	wait (5);
	if (level.timer_trigger != "hit")
		println ("5 SECONDS LEFT");

	wait (5);

	if (level.timer_trigger != "hit")
	{
		println ("TOO SLOW, 0 SECONDS LEFT");
		origin = (level.player getorigin() );
		level.player maps\_mortar::incoming_sound();
		radiusDamage ( origin, 400, 10000, 10000);
		playfx ( level.mortar, origin );
		level.player maps\_mortar::mortar_sound();
		earthquake(0.15, 2, origin, 850);
	}
}

timer_trigger()
{
	self waittill ("trigger");
	println ("TIMER OFF");
	level.timer_trigger = "hit";
}

run()
{
	self.interval = 0;
	self endon ("death");
	level endon ("moving");

	//if (isdefined (self.script_delay) )
	//	wait (self.script_delay);

	wait (randomfloat (1));

	firstnode = getnode (self.target, "targetname");
	self setgoalnode (firstnode);

	self waittill ("goal");

	self animscripts\shared::SetInCombat();

	self allowedStances ("stand");

	nextnode = getnode (firstnode.target, "targetname");
	if ( !(isdefined (nextnode) ) )
	{
		println ("runner ", self.origin, " has a patrol of one node");
		return;
	}

	while (isdefined (nextnode) && isalive (self) )
	{
		//println (self, nextnode);
		self setgoalnode(nextnode);
		self waittill ("goal");

		if (isdefined (nextnode.target))
		{
			nextnode = getnode (nextnode.target, "targetname");
			if (nextnode.targetname == "auto1270")
			{
				//* Not there, watch out of those mines!
				level.foley thread maps\_anim::anim_single_solo (level.foley, "watch out");

			}


		}
		else
		{
			break;
		}
		if (isdefined (nextnode.script_delay) )
			wait (nextnode.script_delay);
	}

	if (isalive (self))
	{
		self.interval = 64;
		self allowedStances ("crouch");
	}

	level waittill ("moving");

	if (isalive (self))
	{
		self allowedStances ("crouch", "prone", "stand");
	}
}

//////////---------------------------
chain_start()
{
	triggers = getentarray ("start_chains", "targetname");

	for (i=0;i<triggers.size;i++)
		triggers[i] thread chain_start_trigger();

	flag_wait ("moving");

	if (.7 < (level.player.health/level.starting_health) )
		maps\_utility::autosave(1);

	ai = getaiarray ();
	for (i=0;i<ai.size;i++)
	{
		if (ai[i].team == "allies")
		{
			ai[i] setgoalentity (level.player);
			ai[i].goalradius = 32;
		}
	}
}

chain_start_trigger()
{
	self waittill ("trigger");

	flag_set ("moving");
}


//////////---------------------------
flak88_init()
{
	self.health  = 250;
	thread flak88_kill();
	thread flak88_shoot();
}



flak88_kill()
{
	self.deathmodel = "xmodel/turret_flak88_d";
	self.deathfx    = loadfx( "fx/explosions/explosion1.efx" );
	self.deathsound = "explo_metal_rand";

	maps\_utility::precache( self.deathmodel );

	self waittill( "death", attacker );



	self setmodel( self.deathmodel );
	self playsound( self.deathsound );
	self clearTurretTarget();

	playfx( self.deathfx, self.origin );
	earthquake( 0.25, 3, self.origin, 1050 );
}


flak88_shoot()
{
	while( self.health > 0 )
	{
		self waittill( "turret_fire" );
		self FireTurret();
		wait 1;
		self playsound ("flak_reload");
	}
	
	//destroy the shell hudelem
	if (isdefined (level.fireicon))
		level.fireicon destroy();
}

ai_overrides()
{
	spawners = getspawnerteamarray("allies");
	for (i=0;i<spawners.size;i++)
		spawners[i] thread spawner_overrides();

	ai = getaiarray("allies");
	for (i=0;i<ai.size;i++)
		ai[i].chainfallback = 1;
//		ai[i] thread bloody_death_waittill();
//		level thread add_totalguys(ai[i]);

	if (getcvar ("scr_hurtgen_fast") == "1")
	{
		for (i=0;i<ai.size;i++)
		{
			if (isdefined (ai[i].script_dawnville_fast))
				ai[i] DoDamage ( 1500, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
		}
	}

}

spawner_overrides()
{
	if (getcvar ("scr_hurtgen_fast") == "1")
	{
		if (isdefined (self.script_dawnville_fast))
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
			spawned.chainfallback = 1;
	}
}


//////////---------------------------

//"USAGE: badplace_cylinder(name, duration, origin, radius, height, team [, team ...])\n"
//"If name is not \"\", the bad place can be moved or deleted by using the unique name.\n"
//"If duration > 0, the bad place will automatically delete itself after this time.\n"
//"If duration <= 0, the bad place must have a name and will last until manually deleted.\n"
//"You must specify at least one team for which this place is bad, but can give several.\n"
//"The allowed teams are 'axis', 'allies', and 'neutral'.\n"


mg_badplaces(msg,origin,range,direction,right,left)
{
	badplace_arc(msg, -1, origin, range, 400, direction, right, left, "allies");
	spawners_death(msg);
	badplace_delete(msg);
}
spawners_death(msg)
{
	spawners = getentarray (msg, "script_noteworthy");

	totalspawn = spawners.size;
	for (i=0;i<spawners.size;i++)
		thread spawnerworked(spawners[i],msg);

	while (totalspawn > 0)
	{
		level waittill ("spawner death" +msg);
		totalspawn--;
	}
// badplace off
}

spawnerworked(spawner,msg)
{
	spawner waittill ("spawned", spawn);
	if (!isAlive(spawn))
	{
		level notify ("spawner death" +msg);
		return;
	}
	spawn waittill ("death");
	level notify ("spawner death" +msg);
}

spawn_attack()
{
	self.count = 1;
	spawn = self dospawn();
	spawn endon ("death");
	
	level waittill ("tanks dead");

	
	retreatnode= getnode ("retreatnode", "targetname");
	spawn setgoalnode (retreatnode);
	spawn playsound ("generic_misccombat_german_1");
	spawn.ignoreme = true;
	
	friends = getaiarray ("allies");
	for (i=0;i<friends.size;i++)
	{
		friends[i].ignoreme = true;
	}
	
	
}



tankswitchers()
{
	triggers = getentarray("tankswitcher","targetname");
	for(i=0;i<triggers.size;i++)
	{
		targ = getent(triggers[i].target,"targetname");
		level thread tankswitcher(targ,triggers[i]);
	}
}

tankswitcher(targtrig,trigger)
{

	while(1)
	{
		while(1)
		{
			targtrig waittill ("trigger",other);
			if(isdefined(other.targetname) && other.targetname == targtrig.target && other.lasttrig != targtrig)
				break;
		}
		if(!(other.health>0))
			return;
		other endon ("death");
		other.lasttrig = targtrig;
		other setspeed(0,15);
		println("waiting for trigger ",trigger.targetname);
		trigger waittill ("trigger");
		println("resuming!");
		other notify ("resumed");
		other resumespeed(15);
		println("resuming speed");

	}
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

foleytrigger()
{
	foleytrigger = getentarray ("foley_tanks", "targetname");
	for (i=0;i<foleytrigger.size;i++)
	{
		foleytrigger[i] thread maps\_utility::triggerOff();
	}
	
	level waittill ("objective_complete1");
	
	maps\_utility::array_thread(foleytrigger,::foleytrigger_on);
	
	level waittill ("nearly tank talk");

	while (1)
	{
		d = distance (level.player getorigin(), level.foley.origin);
		if (d < 400)
		{
			break;
		}
		//println ("distance: ", d);
		wait 1;
	}
	flag_set ("tank talk");
}

foleytrigger_on()
{
	self maps\_utility::triggerOn();
	self waittill ("trigger");
	level notify ("nearly tank talk");
}
     

chain_triggers()
{
	lastchain = getentarray ("lastchain", "targetname");
	for (i=0;i<lastchain.size;i++)
	{
		lastchain[i] thread maps\_utility::triggerOff();
	}
	
	friendchains = getentarray ("friend_chains", "script_noteworthy");
	for (i=0;i<friendchains.size;i++)
	{
		friendchains[i] thread maps\_utility::triggerOn();
	}

        /////////////////
        level waittill ("objective_complete1");
        /////////////////

	for (i=0;i<lastchain.size;i++)
	{
		lastchain[i] thread maps\_utility::triggerOn();
	}
	for (i=0;i<friendchains.size;i++)
	{
		friendchains[i] thread maps\_utility::triggerOff();
	}
}                                  

music()
{
	musicPlay("datestamp");
	
	level waittill ("bunker music start");
	musicPlay("pf_stealth");
}
	    