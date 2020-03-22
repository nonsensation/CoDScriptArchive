main()
{
	setCvar("cg_hudcompassMaxRange","2047"); // this is as large as we can go it seems

	level.flags["stage2_enemies_spawned"] = false;		// PGM
	level.flags["stage3_enemies_spawned"] = false;		// PGM
	level.flags["knuckle_panzers_spawned"] = false;		// PGM

	// the min friendly tank count used for replenishing tanks
	level.friend_min = 3;
	level.friend_max = 3; // the friendly tank count at start-up
	
	// use a defualt spawn position
	level.tank_spawner = "tank_spawn";

	// for the pak43
	loadfx("fx/smoke/oneshotblacksmokelinger.efx"); 

	// precaching
	precachemodel("xmodel/vehicle_tank_t34");
	precachemodel("xmodel/vehicle_tank_panzeriv_d");

	level.tankstartstopped = true;

	// Level State Flags/Integer indicators

	// river crossing
	level.paks_dead = false;
	level.river_ai_dead = false;
	level.pakphase = 1;

	// farm ambush
	level.farmphase = 1;
	
	// barrier
	level.barrier_done = false;

	// duckshoot
	level.duckshoot_friendlies_awake = false;
	level.duckshoot_complete = false;

	// clearing
	level.clearingphase = 1;

	// tunnel
	level.tunnel_completed = false;
	
	// Level variables
	level.friendlies = getentarray("friendly","groupname");	// friendly T34 tanks in player's group
	level.t34_commander = getent("t34_cmdr","targetname"); // the invunerable tank commander (used to be t34_4)
	level.playertank_z_adjust = 0; // adjustment enemy tanks apply when targeting the player
//	level.playertank_z_adjust = -64; // adjustment enemy tanks apply when targeting the player

//	level.convoy_t34s = getentarray("convoy_t34s","groupname"); // t34 "dummies" the appear at the beginning across the stream

//	level.farmpanzers = getentarray("farmpanzers","groupname"); // the panzers in the farm ambush section
//	level.farmpanzers2 = getentarray("farmpanzers2","groupname"); // second group of panzers in the farm ambush section
//	level.farmpanzerkill = 0; // farm panzer event completion flag
//	level.farmpanzer2kill = 0; // farm panzer 2nd phase event completion flag

//	level.knucklepanzers = getentarray("knucklepanzers","groupname"); // the panzers in the farm ambush section
//	level.knucklekill = 0; // knuckle event completion flag

//	level.duckshoottigers = getentarray("duckshoottigers","groupname"); // the tigers at the duckshoot
//	level.duckshootkill = 0; // duckshoot event completion counter
	level.duckshootdiecount = 0; // ends the fake duckshoot combat, starts the real stuff

//	level.clearingpanzers = getentarray("clearingpanzers","groupname"); // the panzers in the clearing section -- wave 1
//	level.clearingpanzers2 = getentarray("clearingpanzers2","groupname"); // the panzers in the clearing section -- wave 2
//	level.clearingpanzerkill = 0; // clearing panzer wave 1 event completion flag
//	level.clearingpanzer2kill = 0; // clearing panzer wave 2 event completion flag

//	level.stage1_t34s = getentarray("stage1_t34s","groupname"); // the stage 1 end battle t34s
//	level.stage1_panzers = getentarray("stage1_panzers","groupname"); // the stage 1 end battle panzers
//	level.stage1_tigers = getentarray("stage1_tigers","groupname"); // the stage 1 end battle tigers
//	level.stage1kill = 0;
//	level.stage1tigerkill = 0;

//	level.stage2_elefants = getentarray("stage2_elefants","groupname"); // the stage 2 elefants
//	level.stage2_tanks = getentarray("stage2_tanks","groupname"); // the stage 2 panzers & tigers
//	level.stage2kill = 0;

//	level.stage3_elefants = getentarray("stage3_elefants","groupname"); // the stage 3 elefants
//	level.stage3_tigers = getentarray("stage3_tigers","groupname"); // the stage 3 panzers & tigers
//	level.stage3kill = 0;

	level.endphase = 0;	// 0 beginning of endphase
						// 1 after first 4 panzers dead
						// 2 after first 3 elefants are dead
						// 3 game over

	// initialization
	init_friendlies();

	// TODO:  several of these threads don't need to be started here.  We can probably call these later if we're worried about the number of active threads
//	level thread init_rivercrossing();
	level thread start_friendlies();
	level thread start_convoy_t34s();

//	level thread river_paks();
//	level thread start_river_dummies();
//	level thread barrier_start();
//	level thread duckshoot_more_t34s();
//	level thread clearing_start();
//	level thread tunnel_start();

	// Now start keeping track of the spawning position 
	// for friendly tanks.
	thread initTankSpawnTriggers();

	// tank replenish - pre-duckshoot
	thread refresh_friend_tanks("trig_tank_replenish", "tank_replenish", "dkramer669");

	// pre-final 
	thread refresh_friend_tanks("trig_replenish_2", "dyoung61", "dkramer775");

//	count_vehicles();
}
/*
count_vehicles()
{
	lastcount = -1;
	lastupdate = 0;
	counting = true;
	while (counting)
	{
		vehicles = getentarray ( "script_vehicle", "classname" );
		if(isdefined(vehicles))
		{
			count = LiveVehicleCount(vehicles);
			if((lastcount != count) || (lastupdate > 5))
			{
				println("^3 count_vehicles: currently " + count + " vehicles alive.");
				lastupdate = 0;
				for(x=0;x<vehicles.size;x++)
				{
					if(isdefined(vehicles[x]) && isalive(vehicles[x]))
						print("^3 " + vehicles[x].targetname + "");
				}
				println("");
			}
			lastcount = count;
			lastupdate++;
		}

		wait ( 1 );
	}
}
*/
init_friendlies()
{
 	for(i=0;i<level.friendlies.size;i++)
	{
		level.friendlies[i].killcommit = true;
		level.friendlies[i] maps\_t34_pi::init_mg_think_only();// no think function
		level.friendlies[i] thread maps\kursk_tankdrive::friendly_tank_think();
		level.friendlies[i].mgturret setmode("manual");

		// everybody gets invulnerable at the start
		level.friendlies[i].damage_shield_fraction = 1;

		// start the water effects
		level.friendlies[i] thread maps\kursk_tankdrive::watersplashes(false);
	}

	level.t34_commander.health = 5000;

	level.playertank.mgturret setmode("manual");
	// play tank damage VO
	thread maps\kursk_sound::tank_crew_damage_chatter();

}

truck_explode()
{
	truck = getent(self.target,"targetname");
	self waittill("trigger");

	fx = loadfx("fx/explosions/vehicles/truck_complete.efx");
	
	truck playsound ("explo_metal_rand");

	playfxOnTag ( fx, truck, "tag_origin" );

	earthquake(0.25, 3, truck.origin, 1050);
	radiusDamage (truck gettagorigin("tag_player"), 300, 400, 200);
	
	enginesmoke = spawn("script_origin",truck gettagorigin("tag_engine_left"));
	enginesmoke linkto(truck, "tag_engine_left");
	thread enginesmoke(enginesmoke);

	truck setmodel("xmodel/vehicle_german_truck_d");
}

enginesmoke(engine)
{
	if(self.model == "xmodel/v_rs_lnd_gazaaa")
	{
		return;
	}
	enginesmoke = loadfx("fx/smoke/blacksmokelinger.efx");
	accdist = 0.001;
	fullspeed = 1000.00;


	timer = gettime()+10000;
	while(self.speed > 100 && timer > gettime())
	{
		oldorg = engine.origin;
		wait(0.1);
		dist = distance(oldorg,engine.origin);
		accdist += dist;
		enginedist = 48;
		if(self.speed > 1)
		{
			if(accdist > enginedist)
			{
				speedtimes = self.speed/fullspeed;
				playfx (enginesmoke, engine.origin);
				accdist -= enginedist;
			}
		}
	}
	while(timer > gettime())
	{
		playfx (enginesmoke, engine.origin);
		wait randomfloat(.3)+.1;
	}
}

/* PGM - no longer used?
init_rivercrossing()
{
	pak43_1 = getent("pak43_1","targetname");
	pak43_1 maps\_pak43_pi::init(true);
	pak43_1.script_exploder = 201;

	pak43_2 = getent("pak43_2","targetname");
	pak43_2 maps\_pak43_pi::init(true);
	pak43_2.script_exploder = 202;

	truck1trig = getent("river_truck1_damage","targetname");
	truck1trig thread truck_explode();

	truck2trig = getent("river_truck2_damage","targetname");
	truck2trig thread truck_explode();

	truck3trig = getent("river_truck3_damage","targetname");
	truck3trig thread truck_explode();

	// init the death triggers
	thread maps\kursk_infantry::watch_pak_death("river_pak_damage_1", "pak43_1");
	thread maps\kursk_infantry::watch_pak_death("river_pak_damage_2", "pak43_2");


}
*/

start_friendlies()
{
	if(level.script=="dkkursk")  // dpk remove this
	{
		level.player takeallweapons();
		level.player giveWeapon("luger");
		level.player switchToWeapon("luger");
		wait 1;
		level.playertank playsound("kursk_introspeech1"); // go immediately
	}
	else
	{
		level waittill ("starting final intro screen fadeout");
		// beginning speech/voiceover
		level.playertank playsound("kursk_introspeech1"); // go immediately
	}
	level notify("level start tanks");
}

t34_dummy_setup()
{
		self maps\_t34_pi::init_mg_think_only();// no think function
		self thread maps\kursk_tankdrive::friendly_damage_handling();
	
		// attach them to the closest path (defined as a vehiclenode with targetname "vehicle_path")
		path = maps\kursk_tankdrive::nearestpath(self);
		if(!isdefined(path))
		{
			println("no path for friendly tank, doing nothing");
			return;
		}
		self attachpath(path);

		// fancy-shmancy pathing stuff
		self thread maps\kursk_tankdrive::friendly_path_setup(path);

		// turn off MGs
		self.mgturret setmode("manual");
}


start_convoy_t34s()
{
	tank1 = getent("convoy_t34_1","targetname");
	tank2 = getent("convoy_t34_2","targetname");
	tank3 = getent("convoy_t34_3","targetname");

	pak43_1 = getent("pak43_1","targetname");
    pak43_2 = getent("pak43_2","targetname");

	truck1trig = getent("river_truck1_damage","targetname");
	truck2trig = getent("river_truck2_damage","targetname");
	truck3trig = getent("river_truck3_damage","targetname");

	start_trig = getent("start_convoy","targetname");
	start_trig waittill("trigger");

	// this bit done to improve level performance
	level.convoy_t34s[0] = vehicle_spawn("xmodel/vehicle_tank_t34", tank1);
	level.convoy_t34s[1] = vehicle_spawn("xmodel/vehicle_tank_t34", tank2);
	level.convoy_t34s[2] = vehicle_spawn("xmodel/vehicle_tank_t34", tank3);
	
	wait(0.1);	// PGM

 	for(i=0;i<level.convoy_t34s.size;i++)
	{
		level.convoy_t34s[i] t34_dummy_setup();
		level.convoy_t34s[i] thread hide_at_end();
		//invulnerable
		level.convoy_t34s[i].damage_shield_fraction = 1;
	}

	wait(0.1);	// PGM

 	for(i=0;i<level.convoy_t34s.size;i++)
	{
		level.convoy_t34s[i] startpath();
	}

	wait(0.1);	// PGM

	river_paks[0] = vehicle_spawn("xmodel/v_ge_art_pak43", pak43_1);
	level.pak43_1 = river_paks[0];
	river_paks[1] = vehicle_spawn("xmodel/v_ge_art_pak43", pak43_2);
	level.pak43_2 = river_paks[1];
	
	river_paks[0] maps\_pak43_pi::init(true);
	river_paks[0].script_exploder = 201;
	
	river_paks[1] maps\_pak43_pi::init(true);
	river_paks[1].script_exploder = 202;

	wait(0.1);	// DAY

	// init the death triggers
	thread maps\kursk_infantry::watch_pak_death("river_pak_damage_1", "pak43_1");
	thread maps\kursk_infantry::watch_pak_death("river_pak_damage_2", "pak43_2");

	wait(0.1);	// PGM

	truck1trig thread truck_explode();
	truck2trig thread truck_explode();
	truck3trig thread truck_explode();

	wait(0.1);	// PGM

	level thread river_paks();

	speech_trig = getent("river_speech","targetname");
	if(isdefined(speech_trig))
		speech_trig waittill("trigger");
    
	river_ai = getentarray("river_ai","groupname"); // they have to be spawned first, so this get has to be after the trigger

	level.playertank playsound("kursk_bridge_out");

	// objectives are now handled in kursk.gsc, just track the paks and continue

	first_target = true;
	targets_left = true;

	while(targets_left == true)
	{
		// paks 1st
		targets_left = false;
		for(i=0;i<river_paks.size;i++)
		{
			if(isdefined(river_paks[i]) && isalive(river_paks[i]) && (isdefined(river_paks[i].disabled) && (river_paks[i].disabled == false)))
			{
				targets_left = true;
				wait(2);
				break;
			}
		}
	}

	level.paks_dead = true;
	level notify("paks_dead");

	targets_left = true;
	while(targets_left == true)
	{
		// guys next
		targets_left = false;
		for(i=0;i<river_ai.size;i++)
		{
			if(isdefined(river_ai[i]) && isalive(river_ai[i]))
			{
				targets_left = true;
				wait(2);
				break;
			}
		}
	}
//	println("all river ai dead");

	level.river_ai_dead = true;
	level.pakphase = 4;
}

hide_at_end()
{
	self endon("dont_hide"); // abort condition

	self waittill("reached_end_node");
	self setspeed(0,50);
	self hide();
}

river_paks()
{
	trig = getent("start_river_paks","targetname");
	trig waittill("trigger");

	// enable the river dummies
	level thread start_river_dummies();

	// attempt to deal with players rushing the paks -- proceed immediately to phase 2
	level thread pak_emergency_target();

	wait (0.1);

	// attempt to deal with players rushing the paks -- hop off and stop firing
	level thread pak_abort();

	// PGM - use stored level.pak43_1 instead of calling getent
//	pak43_1 = getent("pak43_1","targetname");
	if(isdefined(level.pak43_1) && isalive(level.pak43_1))
	{
		level.pak43_1 thread river_pak_1_fire();
	}

	waitfloat = randomfloat(1);
	wait(waitfloat); // so they're not in sync

//	pak43_2 = getent("pak43_2","targetname");
	if(isdefined(level.pak43_2) && isalive(level.pak43_2))
	{
		level.pak43_2 thread river_pak_2_fire();
	}

	level waittill("paks_dead");
	level.pakphase = 4;
}

pak_abort()
{
	// if a T34 gets this close, the PAK gunners jump off, it's too close!
	pak_abort = getent("pak_abort","targetname");
	pak_abort waittill("trigger");

	// PGM - use stored level.pak43_1 instead of calling getent
//	pak43_1 = getent("pak43_1","targetname");
//	pak43_2 = getent("pak43_2","targetname");
//	pak43_3 = getent("pak43_3","targetname");

	if(isdefined(level.pak43_1) && isalive(level.pak43_1))
	{
		level.pak43_1 notify("stop_everything");
	}

	if(isdefined(level.pak43_2) && isalive(level.pak43_2))
	{
		level.pak43_2 notify("stop_everything");
	}
/*
	if(isdefined(pak43_3) && isalive(pak43_3))
	{
		pak43_3 notify("stop_everything");
	}
*/
	// signify that out tanks should now advance
	level.pakphase = 4;
	level notify("paks_dead");
}

pak_emergency_target()
{
	pak_emergency_target = getent("pak_emergency_target","targetname");
	pak_emergency_target waittill("trigger");

	// go immediately to phase 2
	if(level.pakphase < 2)
	{
		// PGM - use stored level.pak43_1 instead of calling getent
//		pak43_1 = getent("pak43_1","targetname");
//		pak43_2 = getent("pak43_2","targetname");
//		pak43_3 = getent("pak43_3","targetname");

//		println("Player rushing, jumping to pakphase 2");

		if(isdefined(level.pak43_1) && isalive(level.pak43_1))
		{
			level.pak43_1 notify("stop_random_fire");
			level.pak43_1 notify("random fire done");
		}

		if(isdefined(level.pak43_2) && isalive(level.pak43_2))
		{		
			level.pak43_2 notify("stop_random_fire");
			level.pak43_2 notify("random fire done");
		}
/*
		if(isdefined(pak43_3) && isalive(pak43_3))
		{		
			pak43_3 notify("stop_random_fire");
			pak43_3 notify("random fire done");
		}
*/
	}
}

river_pak_1_fire()
{
	self endon("death");
	self endon("stop everything");

	// phase 1 pak firing -- harmless to give player a chance `to kill them quickly
	self thread maps\_pak43_pi::pak43_random_fire(2, 4, "pak43_1_early_target", undefined, 3);

	self waittill("random fire done");

//	println("pak 1 going to phase 2");

	level.pakphase = 2;

	playertargetlist = [];
	playertargetlist[0] = level.playertank;

	friendlytargetlist = [];
	friendlytargetlist[0] = getent("t34_2","targetname");
	friendlytargetlist[1] = getent("t34_cmdr","targetname");

	// if the player is on the west side, attack him twice, otherwise fire at closest friendly t_34
	for( i=0;i<2;i++ )
	{
		if((level.playertank.origin[0] < -320) && (level.playertank.origin[1] < -60800))
		{
			self thread maps\_pak43_pi::pak43_random_fire(2, 4, undefined, playertargetlist, 1);
		}
		else
		{
			self thread maps\_pak43_pi::pak43_random_fire(2, 4, undefined, friendlytargetlist, 1);
		}
		self waittill("random fire done");
	}

	level.pakphase = 3;

	// continue phase 2 behavior indefinitely
	while(level.paks_dead == false)
	{
		if((level.playertank.origin[0] < -320) && (level.playertank.origin[1] < -60800))
		{
			self thread maps\_pak43_pi::pak43_random_fire(2, 4, undefined, playertargetlist, 1);
		}
		else
		{
			self thread maps\_pak43_pi::pak43_random_fire(2, 4, undefined, friendlytargetlist, 1);
		}
		self waittill("random fire done");
	}
}

river_pak_2_fire()
{
	self endon("death");
	self endon("stop everything");

	// first set of targets are for flash and effect -- 3 shots
	self thread maps\_pak43_pi::pak43_random_fire(2, 4, "pak43_2_early_target", undefined, 3);

	self waittill("random fire done");

//	println("pak 2 going to phase 2");

	level.pakphase = 2;

	playertargetlist = [];
	playertargetlist[0] = level.playertank;

	friendlytargetlist = [];
	friendlytargetlist[0] = getent("t34_1","targetname");
	friendlytargetlist[1] = getent("t34_cmdr","targetname");

	// if the player is on the west side, attack him twice, otherwise fire at a friendly t_34
	for( i=0;i<2;i++ )
	{
		if((level.playertank.origin[0] >= -320) && (level.playertank.origin[1] < -60800))
		{
			self thread maps\_pak43_pi::pak43_random_fire(2, 4, undefined, playertargetlist, 1);
		}
		else
		{
			self thread maps\_pak43_pi::pak43_random_fire(2, 4, undefined, friendlytargetlist, 1);
		}
		self waittill("random fire done");
	}

	level.pakphase = 3;

	// continue phase 2 behavior indefinitely
	while(level.paks_dead == false)
	{
		if((level.playertank.origin[0] >= -320) && (level.playertank.origin[1] < -60800))
		{
			self thread maps\_pak43_pi::pak43_random_fire(2, 4, undefined, playertargetlist, 1);
		}
		else
		{
			self thread maps\_pak43_pi::pak43_random_fire(2, 4, undefined, friendlytargetlist, 1);
		}
		self waittill("random fire done");
	}
}

objective4()
{
	objective_4_target_1 = getent("objective4_target_1","targetname");
	objective_4_target_2 = getent("objective4_target_2","targetname");
	objective_4_target_3 = getent("objective4_target_3","targetname");
	objective_4_target_4 = getent("objective4_target_4","targetname");
	objective_4_target_5 = getent("objective4_target_5","targetname");
	objective_4_target_6 = getent("objective4_target_6","targetname");

	objective_4_trig_2 = getent("objective4_trig_2","targetname");
	objective_4_trig_3 = getent("objective4_trig_3","targetname");
	objective_4_trig_4 = getent("objective4_trig_4","targetname");
	objective_4_trig_5 = getent("objective4_trig_5","targetname");
	objective_4_trig_6 = getent("objective4_trig_6","targetname");

	objective_1_target_2 = getent("objective_1_target_2","targetname");
	objective_1_target_3 = getent("objective_1_target_3","targetname");
	objective_1_target_4 = getent("objective_1_target_4","targetname");
	objective_1_target_5 = getent("objective_1_target_5","targetname");

	objective_1_trig_3 = getent("objective_1_trig_3","targetname");
	objective_1_trig_4 = getent("objective_1_trig_4","targetname");
	objective_1_trig_5 = getent("objective_1_trig_5","targetname");

	// Destroy the German Column
//	objective_add(4, "active", level.objective_text[4], objective_4_target_1.origin );

	objective_position(1, objective_4_target_1.origin);
	objective_current(1);

	// breadcrumbing the compass star
	objective_4_trig_2 waittill("trigger");
	objective_position(1, objective_4_target_2.origin);
	objective_4_trig_3 waittill("trigger");
	objective_position(1, objective_4_target_3.origin);
	objective_4_trig_4 waittill("trigger");
	objective_position(1, objective_4_target_4.origin);
	objective_4_trig_5 waittill("trigger");
	objective_position(1, objective_4_target_5.origin);
	objective_4_trig_6 waittill("trigger");
	objective_position(1, objective_4_target_6.origin);
	// TODO:  makes this match up with the convoy's destruction
	level waittill("clearing_event_done");
//	objective_state(4, "done");

	// go back to objective1 (Prevent the Germans from crossing the Psel), but with updated position
	objective_position(1,objective_1_target_2.origin);
//	objective_current(1);
	objective_1_trig_3 waittill("trigger");
	objective_position(1, objective_1_target_3.origin);
	objective_1_trig_4 waittill("trigger");
	objective_position(1, objective_1_target_4.origin);
	objective_1_trig_5 waittill("trigger");
	objective_position(1, objective_1_target_5.origin);
}

start_river_dummies()
{
	trig = getent("start_river_dummies","targetname");
	trig waittill("trigger");

	t34_1 = getent("convoy_t34_1","targetname");
	t34_1_node = getvehiclenode("river_dummy_path1","targetname");

	t34_2 = getent("convoy_t34_2","targetname");
	t34_2_node = getvehiclenode("river_dummy_path2","targetname");

//	level thread farm_start();

	t34_1 attachpath(t34_1_node);
	t34_2 attachpath(t34_2_node);

	t34_1 show();
	t34_2 show();

	t34_1 resumespeed(30);
	t34_2 resumespeed(30);

	t34_1 thread hide_at_end();
	t34_2 thread hide_at_end();

	farm_start();
}

init_farmpanzers()
{
	// farmpanzers
	tank1 = getent("dkramer847","targetname");
//	tank2 = getent("dkramer848","targetname");
	tank3 = getent("farmpanzer_4","targetname");

	//farmpanzers2
	tank4 = getent("farmpanzer_1","targetname");
	tank5 = getent("farmpanzer_2","targetname");
	tank6 = getent("farmpanzer_3","targetname");
	tank7 = getent("farmpanzer_5","targetname");

	// this bit done to improve level performance
	level.farmpanzers[0] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", tank1);
//	level.farmpanzers[1] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", tank2);
	level.farmpanzers[1] = getent("dkramer848","targetname"); // for precaching purposes
	level.farmpanzers[2] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", tank3);

	wait (0.1);		// PGM

	level.farmpanzers2[0] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", tank4);
	level.farmpanzers2[1] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", tank5);
	level.farmpanzers2[2] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", tank6);
	level.farmpanzers2[3] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", tank7);

	wait (0.1);		// PGM

	// wave 1
 	for(i=0;i<level.farmpanzers.size;i++)
	{
		level.farmpanzers[i].killcommit = true;
		level.farmpanzers[i] maps\_panzerIV_pi::init_Kursk(); // think not included!
		path = maps\kursk_tankdrive::nearestpath(level.farmpanzers[i]);
		level.farmpanzers[i] attachpath(path);
		level.farmpanzers[i] thread maps\kursk_tankdrive::enemy_path_setup(path);
//		level.farmpanzers[i] thread farmpanzer_killcount();
	}
	level thread farmpanzer_killcount2();

	wait (0.1);		// PGM

	// wave 2
 	for(i=0;i<level.farmpanzers2.size;i++)
	{
		level.farmpanzers2[i].killcommit = true;
		level.farmpanzers2[i] maps\_panzerIV_pi::init_Kursk(); // think not included!
		path = maps\kursk_tankdrive::nearestpath(level.farmpanzers2[i]);
		level.farmpanzers2[i] attachpath(path);
		level.farmpanzers2[i] thread maps\kursk_tankdrive::enemy_path_setup(path);
//		level.farmpanzers2[i] thread farmpanzer2_killcount();
	}
	level thread farmpanzer2_killcount2();

//	wait (0.1);		// PGM
}
/*
farmpanzer_killcount()
{
	eventnode1 = getvehiclenode("dkramer359","targetname");
	eventnode2 = getvehiclenode("dkramer165","targetname");
	eventnode3 = getvehiclenode("dkramer402","targetname");

	println("^5 farmpanzer_killcount: thread started");
	self waittill("death");
	level.farmpanzerkill++;

	if( level.farmpanzerkill > 2 )
	{
//		println("Farm Panzer event stage 1 completed");
		eventnode1.eventwaiting = false;
		eventnode2.eventwaiting = false;
		eventnode3.eventwaiting = false;


		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i] notify("stopthink");
				level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
			}
		}
	}
}
*/
farmpanzer_killcount2()
{
	while(LiveVehicleCount(level.farmpanzers) > 0)
		wait (1);

	eventnode1 = getvehiclenode("dkramer359","targetname");
	eventnode2 = getvehiclenode("dkramer165","targetname");
	eventnode3 = getvehiclenode("dkramer402","targetname");

	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;
	eventnode3.eventwaiting = false;

	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i] notify("stopthink");
			level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
		}
	}
}
/*
farmpanzer2_killcount()
{
	eventnode1 = getvehiclenode("dkramer367","targetname");
	eventnode2 = getvehiclenode("dkramer392","targetname");
	eventnode3 = getvehiclenode("dkramer374","targetname");

	println("^5 farmpanzer2_killcount: thread started");
	self waittill("death");
	level.farmpanzer2kill++;

	if( level.farmpanzer2kill > 3 )
	{
//		println("Farm Panzer event stage 2 completed");
		eventnode1.eventwaiting = false;
		eventnode2.eventwaiting = false;
		eventnode3.eventwaiting = false;

		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i] notify("stopthink");
				level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
			}
		}

		// clean up the river crossing event
		maps\_pi_utils::DeleteEntArray("river_ai", "groupname");
	}
}
*/
farmpanzer2_killcount2()
{
	while(LiveVehicleCount(level.farmpanzers2) > 0)
		wait (1);

	eventnode1 = getvehiclenode("dkramer367","targetname");
	eventnode2 = getvehiclenode("dkramer392","targetname");
	eventnode3 = getvehiclenode("dkramer374","targetname");

	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;
	eventnode3.eventwaiting = false;

	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i] notify("stopthink");
			level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
		}
	}

	// clean up the river crossing event
	maps\_pi_utils::DeleteEntArray("river_ai", "groupname");
}
/*
knuckle_killcount()
{
	eventnode1 = getvehiclenode("dkramer381","targetname");
	eventnode2 = getvehiclenode("dkramer875","targetname");
	eventnode3 = getvehiclenode("dkramer578","targetname");

	println("^5 knuckle_killcount: thread started");
	self waittill("death");
	level.knucklekill++;

	if( level.knucklekill > 1 )
	{
//		println("knuckle completed");
		eventnode1.eventwaiting = false;
		eventnode2.eventwaiting = false;
		eventnode3.eventwaiting = false;

		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i] notify("stopthink");
				level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
			}
		}
	}
}
*/

knuckle_killcount2()
{
	while(LiveVehicleCount(level.knucklepanzers) > 0)
		wait (1);

	eventnode1 = getvehiclenode("dkramer381","targetname");
	eventnode2 = getvehiclenode("dkramer875","targetname");
	eventnode3 = getvehiclenode("dkramer578","targetname");

	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;
	eventnode3.eventwaiting = false;

	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i] notify("stopthink");
			level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
		}
	}
}

// selects a target from the closest member of the player + level.friendlies
general_panzer_think()
{
	self endon("stopthink");
	self endon("death");
	while(1)
	{
		// resort targets every 5 seconds
		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]) && (level.friendlies[i] != level.t34_commander))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.friendlies[i]);
			}
		}
		
		self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.playertank);
		closest_target = maps\kursk_tankdrive::get_closest_target(self.enemyqueue);
		if(isdefined(closest_target))
		{
	//		println("closest target to ",self.targetname," is ",closest_target.targetname);
			maps\_tank_pi::queue_add_to_front(closest_target);
		}
		wait(5);
	}
}

farm_friendly_knuckletargeting()
{
	leftalive = 0;
	for(i=0;i<level.knucklepanzers.size;i++)
	{
		if(isdefined(level.knucklepanzers[i]) && isalive(level.knucklepanzers[i]))
		{
			leftalive++;
			self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.knucklepanzers[i]);
		}
	}
	
	closest_target = maps\kursk_tankdrive::get_closest_target(self.enemyqueue);
	if(isdefined(closest_target))
	{
//		println("closest target to ",self.targetname," is ",closest_target.targetname);
		maps\_tank_pi::queue_add_to_front(closest_target);
	}

	if(leftalive == 0)
	{
		self notify("stopthink");
	}
}

farm_friendly_think()
{
	self endon("stopthink");
	self endon("death");
	while(1)
	{
		// resort targets every 5 seconds
		for(i=0;i<level.farmpanzers.size;i++)
		{
			if(isdefined(level.farmpanzers[i]) && isalive(level.farmpanzers[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.farmpanzers[i]);
			}
		}
		
		closest_target = maps\kursk_tankdrive::get_closest_target(self.enemyqueue);
		if(isdefined(closest_target))
		{
	//		println("closest target to ",self.targetname," is ",closest_target.targetname);
			maps\_tank_pi::queue_add_to_front(closest_target);
		}
		wait(5);
	}
}

farm_friendly_think2()
{
	self endon("stopthink");
	self endon("death");
	while(1)
	{
		// resort targets every 5 seconds
		for(i=0;i<level.farmpanzers2.size;i++)
		{
			if(isdefined(level.farmpanzers2[i]) && isalive(level.farmpanzers2[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.farmpanzers2[i]);
			}
		}
		
		closest_target = maps\kursk_tankdrive::get_closest_target(self.enemyqueue);
		if(isdefined(closest_target))
		{
	//		println("closest target to ",self.targetname," is ",closest_target.targetname);
			maps\_tank_pi::queue_add_to_front(closest_target);
		}
		wait(5);
	}
}

farm_friendly_knucklethink()
{
	self endon("stopthink");
	self endon("death");

	if(level.flags["knuckle_panzers_spawned"] == false)
		level waittill ("knuckle_panzers_spawned");
	while(1)
	{
		// resort targets every 5 seconds
		self thread farm_friendly_knuckletargeting();
		wait(5);
	}
}

farm_start()
{
	trig = getent("farm_start","targetname");
//	trig = getent("farm_activate","targetname");
	trig waittill("trigger");

	// initialize the farm panzers
	init_farmpanzers();

	// trigger the pf guys in the farm area
//	maps\kursk_infantry::manage_farm_infantry();

	wait(0.1);		// PGM

	for(i=0;i<level.farmpanzers.size;i++)
	{
		if(isdefined(level.farmpanzers[i]) && isalive(level.farmpanzers[i]))
		{
			// initial target selection
			level.farmpanzers[i] thread general_panzer_think();
			level.farmpanzers[i] startpath();
			// in phase 1, enemy tanks have lousy accuracy, and friendlies still have high damage shields
			level.farmpanzers[i].script_accuracy = 1000;
			level.farmpanzers[i].triggeredthink = true; // so they don't start shooting right away
			level.farmpanzers[i] thread maps\_tank_pi::turret_attack_think_Kursk();
		}
	}

	// again with the hacked timing! 
	wait(2);
	level.playertank playsound("kursk_ambush");
	level.vo_played = gettime();
	wait(2);

	// enable the barrier stuff
	level thread barrier_start();

	// enter phase 2, enemies get a little more lethal, friendlies start shooting, albeit ineffectively
	level.farmphase = 2;
//	println("FARM PHASE 2");

//	if(level.farmpanzerkill < 3)
	if(LiveVehicleCount(level.farmpanzers) > 0)
	{

		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i] thread farm_friendly_think();
				level.friendlies[i].script_accuracy = 400;
				level.friendlies[i].damage_shield_fraction = 0.8;
				level.friendlies[i] thread maps\_tank_pi::turret_attack_think_Kursk();
				level.friendlies[i].mgturret setmode("manual");
			}
		}

		level.t34_commander.damage_shield_fraction = 1;

		for(i=0;i<level.farmpanzers.size;i++)
		{
			if(isdefined(level.farmpanzers[i]) && isalive(level.farmpanzers[i]))
			{
				// in phase 2, enemy tanks have better accuracy
				level.farmpanzers[i].script_accuracy = 500;
			}
		}

		wait(10);
	}

	level.farmphase = 3;
//	println("FARM PHASE 3");

	// enter phase 3, enemies accurate, friendlies accurate, stage 2 introduced
//	if(level.farmpanzerkill < 3)
	if(LiveVehicleCount(level.farmpanzers) > 0)
	{
		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i].script_accuracy = 100;
				level.friendlies[i].damage_shield_fraction = 0.8;
			}
		}

		level.t34_commander.damage_shield_fraction = 1;

		for(i=0;i<level.farmpanzers.size;i++)
		{
			if(isdefined(level.farmpanzers[i]) && isalive(level.farmpanzers[i]))
			{
				// in phase 3, enemy tanks have better accuracy
				level.farmpanzers[i].script_accuracy = 250;
			}
		}
	}

// stage 2
	for(i=0;i<level.farmpanzers2.size;i++)
	{
		if(isdefined(level.farmpanzers2[i]) && isalive(level.farmpanzers2[i]))
		{
			// initial target selection
			level.farmpanzers2[i] thread general_panzer_think();
			level.farmpanzers2[i] startpath();
			// in phase 1, enemy tanks have lousy accuracy, and friendlies still have high damage shields
			level.farmpanzers2[i].script_accuracy = 300;
			level.farmpanzers2[i].triggeredthink = true; // so they don't start shooting right away
			level.farmpanzers2[i] thread maps\_tank_pi::turret_attack_think_Kursk();
		}
	}

//	while(level.farmpanzerkill < 3)
	while(LiveVehicleCount(level.farmpanzers) > 0)
	{
		wait(3);
		//friendlies continually get more accurate
		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i].script_accuracy = (level.friendlies[i].script_accuracy * .75);
			}
		}
		}

	level.farmphase = 4;
//	println("FARM PHASE 4 - DONE");
// in phase 4, friendlies need to shift their focus to farmpanzers2

//	if(level.farmpanzer2kill < 4)
	if(LiveVehicleCount(level.farmpanzers2) > 0)
	{

		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{

				// initial target selection
				level.friendlies[i] thread farm_friendly_think2();
				level.friendlies[i].script_accuracy = 400;
				level.friendlies[i].damage_shield_fraction = 0.8;
				level.friendlies[i] thread maps\_tank_pi::turret_attack_think_Kursk();
				level.friendlies[i].mgturret setmode("manual");
			}
		}
		level.t34_commander.damage_shield_fraction = 1;

		for(i=0;i<level.farmpanzers2.size;i++)
		{
			if(isdefined(level.farmpanzers2[i]) && isalive(level.farmpanzers2[i]))
			{
				// in phase 2, enemy tanks have better accuracy
				level.farmpanzers2[i].script_accuracy = 150;
			}
		}

		wait(5);

	}

	level.farmphase = 5; // final farmphase

//	if(level.farmpanzer2kill < 4)
	if(LiveVehicleCount(level.farmpanzers2) > 0)
	{
		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i].script_accuracy = 100;
				level.friendlies[i].damage_shield_fraction = 0.8;
			}
		}

		level.t34_commander.damage_shield_fraction = 1;

		for(i=0;i<level.farmpanzers2.size;i++)
		{
			if(isdefined(level.farmpanzers2[i]) && isalive(level.farmpanzers2[i]))
			{
				// in phase 3, enemy tanks have better accuracy
				level.farmpanzers2[i].script_accuracy = 75;
			}
		}
	}

//	while(level.farmpanzer2kill < 4)
	while(LiveVehicleCount(level.farmpanzers2) > 0)
	{
		wait(3);
		//friendlies continually get more accurate
		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i].script_accuracy = (level.friendlies[i].script_accuracy * .75);
			}
		}
	}

	// bit of a delay
	wait(3);

	//knucklepanzers
	tank8 = getent("dkramer862","targetname");
	tank9 = getent("dkramer873","targetname");

	level.knucklepanzers[0] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", tank8);
	level.knucklepanzers[1] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", tank9);

	wait(1);

	// knuckle
 	for(i=0;i<level.knucklepanzers.size;i++)
	{
		level.knucklepanzers[i].killcommit = true;
		level.knucklepanzers[i] maps\_panzerIV_pi::init_Kursk(); // think not included!
		path = maps\kursk_tankdrive::nearestpath(level.knucklepanzers[i]);
		level.knucklepanzers[i] attachpath(path);
		level.knucklepanzers[i] thread maps\kursk_tankdrive::enemy_path_setup(path);
//		level.knucklepanzers[i] thread knuckle_killcount();
	}
	level thread knuckle_killcount2();

	wait(1);

	level.flags["knuckle_panzers_spawned"] = true;
	level notify ("knuckle_panzers_spawned");

	// and now the knuckle
	for(i=0;i<level.knucklepanzers.size;i++)
	{
		if(isdefined(level.knucklepanzers[i]) && isalive(level.knucklepanzers[i]))
		{
			level.knucklepanzers[i] thread general_panzer_think();
			level.knucklepanzers[i] startpath();
			// in phase 1, enemy tanks have lousy accuracy, and friendlies still have high damage shields
			level.knucklepanzers[i].script_accuracy = 1500;
			level.knucklepanzers[i].triggeredthink = true; // so they don't start shooting right away
			level.knucklepanzers[i] thread maps\_tank_pi::turret_attack_think_Kursk();
		}
	}

	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{

			// initial target selection
			level.friendlies[i] thread farm_friendly_knucklethink();
			level.friendlies[i].script_accuracy = 400;
			level.friendlies[i].damage_shield_fraction = 0.75;
			level.friendlies[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.friendlies[i].mgturret setmode("manual");
		}
	}
	level.t34_commander.damage_shield_fraction = 1;


//	while(level.knucklekill < 2)
	while(LiveVehicleCount(level.knucklepanzers) > 0)
	{
		wait(3);
		//friendlies continually get more accurate
		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i].script_accuracy = (level.friendlies[i].script_accuracy * .95);
			}
		}
		// so do enemies
		for(i=0;i<level.knucklepanzers.size;i++)
		{
			if(isdefined(level.knucklepanzers[i]) && isalive(level.knucklepanzers[i]))
			{
				level.knucklepanzers[i].script_accuracy = (level.knucklepanzers[i].script_accuracy * .85);
			}
		}
	}
	//end of event, cleanup

	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i].script_accuracy = 0;
			level.friendlies[i].damage_shield_fraction = 0.75;
			level.friendlies[i] notify ("stopthink");
			level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
		}
	}
	level.t34_commander.damage_shield_fraction = 1;
}
/*
fire_speech()
{
	trig1 = getent("fire_speech1","targetname");
	trig2 = getent("fire_speech2","targetname");

	trig1 waittill("trigger");
	level.playertank playsound("kursk_fire1");

	// TODO: tie in the trigger_damage to this as well

	trig2 waittill("trigger");
	level.playertank playsound("kursk_fire2");
}

firedamagetrigger()
{
	trig = getent("fire_damage","targetname");

	if(isdefined(trig))// REMOVEME can be removed once testing/development is complete
	{
		while(1)
		{
			trig waittill("trigger");
			if(isdefined(level.playertank))// REMOVEME can be removed once testing/development is complete
			{
				while(level.playertank istouching(trig))
				{
					radiusdamage(level.playertank getorigin(), 1000, 1000, 1000);
					wait .1;
				}
			}
		}
	}
}
*/

barrier_start()
{
	// set up the barrier_truck to explode when shot
	barrier_truck_trig = getent("barrier_truck_trig","targetname");
	barrier_truck_trig thread truck_explode();

	trig = getent("barrier_start","targetname");
	trig2 = getent("barrier_panzer_start","targetname");

	// disable the trigger until the convoy passes
	activatetrig = getent("barrier_activate","targetname");
	trig maps\_utility_gmi::triggerOff();
	trig2 maps\_utility_gmi::triggerOff();
	activatetrig waittill("trigger");

//	This bit has to be done early enough to allow the panzer time to swing its turret around to the proper position
    		// initialize the barrier_panzer
			tank1 = getent("barrier_panzer","targetname");

			// this bit done to improve level performance
			barrier_panzer = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", tank1);

			barrier_panzer.killcommit = true;
			barrier_panzer maps\_panzerIV_pi::init_Kursk(); // think not included!
			path = maps\kursk_tankdrive::nearestpath(barrier_panzer);
			barrier_panzer attachpath(path);
			barrier_panzer thread maps\kursk_tankdrive::enemy_path_setup(path);
			barrier_panzer thread maps\kursk_tankdrive::enemy_damage_shield(); // so he doesn't blow himself up
			barrier_panzer.damage_shield_fraction = 0;

			// get the panzer ready to do its thing
			barrier_panzer thread barrier_panzer_think();


	trig maps\_utility_gmi::triggerOn();
	trig2 maps\_utility_gmi::triggerOn();

	trig waittill("trigger");

	// play the giant explosion fx
	level thread barrier_explosions();

	// initialize the pak
	pak1 = getent("barrier_pak","targetname");
	barrier_pak = vehicle_spawn("xmodel/v_ge_art_pak43",pak1);
	barrier_pak maps\_pak43_pi::init(true);

	// set up the death trigger for the pak
	thread maps\kursk_infantry::watch_pak_death("barrier_pak_damage_1", "barrier_pak");

	paktrigger = getent("barrier_pak_attack","targetname");
	paktrigger waittill("trigger");

	// there is a TINY TINY TINY possibility that the player can set off the friendlywait trigger and NOT set off the 'paktrigger'
	// in order to avoid making a map change, I'm putting in this check
	if(isdefined(barrier_pak) && isalive(barrier_pak))
	{
		barrier_pak thread barrier_pak_attack();
	}

	level thread barrier_completion();

	// enable the duckshoot stuff
	level thread duckshoot_more_t34s();
}

barrier_completion()
{
	barrier_pak = getent("barrier_pak","targetname");
	barrier_panzer = getent("barrier_panzer","targetname");

	// set our eventwait nodes
	eventnode1 = getvehiclenode("dkramer424","targetname");
	eventnode2 = getvehiclenode("dkramer661","targetname");
	eventnode3 = getvehiclenode("dkramer654","targetname");
	eventnode4 = getvehiclenode("dkramer638","targetname");
	eventnode5 = getvehiclenode("dkramer666","targetname");

	while((isdefined(barrier_panzer) && isalive(barrier_panzer)) || (isdefined(barrier_pak) && isalive(barrier_pak)))
	{
/*		if(isdefined(barrier_panzer) && isalive(barrier_panzer))
		{
			println("barrier_panzer still defined and alive");
		}
		if(isdefined(barrier_pak) && isalive(barrier_pak))
		{
			println("barrier_pak still defined and alive");
		}
*/		wait 2;
	}
	
	// barrier event done
	level.barrier_done = true;

	//println("level.barrier_done is true");
	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;
	eventnode3.eventwaiting = false;
	eventnode4.eventwaiting = false;
	eventnode5.eventwaiting = false;
}


barrier_panzer_think()
{
	self endon("death");

	target1 = getent("barrier_panzer_target1","targetname");
	target2 = getent("barrier_panzer_target2","targetname");
	target3 = getent("barrier_panzer_target3","targetname");

	barrier_panzer_trigger2 = getent("barrier_panzer_trigger2","targetname");
	barrier_panzer_trigger3 = getent("barrier_panzer_trigger3","targetname");

	self setTurretTargetEnt(target1, (0,0,0));
	
	barrier_panzer_start = getent("barrier_panzer_start","targetname");
	barrier_panzer_start waittill("trigger");

	// fire a shot across the player's bow
	self notify("turret_fire");

	// advance to out next barriershot node, fire at target, repeat
	self startpath();
	self setTurretTargetEnt(target2, (0,0,0));

	// fire second luring shot
	self waittill("barriershot");
	self setTurretTargetEnt(target2, (0,0,0));
	if(isalive(barrier_panzer_trigger2))
	{
		barrier_panzer_trigger2 waittill("trigger");
	}
	self notify("turret_fire");
	self setTurretTargetEnt(target3, (0,0,0));
	self notify("barriershot_done");

	// fire third luring shot
/* REMOVED -- doesn't look good with new more hilly terrain

	self waittill("barriershot");
	self setTurretTargetEnt(target3, (0,0,0));
	barrier_panzer_trigger3 waittill("trigger");
	self notify("turret_fire");
	self notify("barriershot_done");
*/
	// ok, now we're going to target stuff for real
	self waittill("barriershot");
	//target the closest t34 -- updating every 5 seconds
//	level.playertank_z_adjust = -52; // terrain is quite hilly
	self thread general_panzer_think(); 
	// and begin firing, accuracy low at first
	self.script_accuracy = 200;
	self thread maps\_tank_pi::turret_attack_think_Kursk();
	self.mgturret setmode("manual");
	self waittill("turret_fire"); // start moving once we've fired once

	// stop shooting so we don't blow ourselves up during the u-turn
	self notify("stopthink");
	self notify("barriershot_done");

	// resume shooting
	self waittill("barriershot");
	self thread general_panzer_think(); 
	self thread maps\_tank_pi::turret_attack_think_Kursk();
	self.mgturret setmode("manual");


	// increase our accuracy over time
	while(self.script_accuracy > 1)
	{
		self.script_accuracy = (self.script_accuracy * 0.5);
//		println(self.targetname," script_accuracy = ",self.script_accuracy);
		self waittill("turret_fire");
	}
	self.script_accuracy = 0;
}

barrier_pak_attack()
{
	self endon("death");
	self endon("stop everything");

	// early pak firing -- harmless twice to give player a chance to kill it quickly
	self thread maps\_pak43_pi::pak43_random_fire(2, 4, "barrier_pak_early_target", undefined, 2);
	self waittill("random fire done");

	targetarray = [];
	finaltarget = [];
	for(i=0;i<level.friendlies.size;i++)
	{
		targetarray[i] = level.friendlies[i];
	}
	targetarray[level.friendlies.size] = level.playertank;

	// don't target the commander, since he's invulnerable and it looks bad
	targetarray = maps\_utility_gmi::array_remove(targetarray, level.t34_commander);

	while(level.barrier_done == false)
	{
		culled_targetarray = maps\_pi_utils::CullDead(targetarray);
		closest_target = maps\kursk_tankdrive::get_closest_target(culled_targetarray);

//		println("barrier_pak target is ",closest_target.targetname," at ",closest_target.origin);
		finaltarget[0] = closest_target;
		self thread maps\_pak43_pi::pak43_random_fire(1, 3, undefined, finaltarget, 1);
		self waittill("random fire done");
	}
}

barrier_explosions()
{

	explosions = getentarray("barrier_fx","targetname");

	delay = 0;

	for(i=0;i<explosions.size;i++)
	{
		pos2 = explosions[i].origin + (0,0,100);
		level thread maps\_fx_gmi::OneShotfx(explosions[i].script_fxId, explosions[i].origin, delay, pos2);
		level thread play_delayed_sound("mortar_explosion",explosions[i].origin, delay);
		if((i==0)||(i==3)||(i==4)) // play the treeburst sound only on these
		{
			level thread play_delayed_sound("tankdrive_treefall", explosions[i].origin, (delay+0.5));
		}
		delay += randomfloat(1);
	}
	// German yelling "go! go! go!"
	level thread play_delayed_sound("kursk_barrier_german_go", explosions[0].origin, (delay+1));
	// engine starting
	level thread play_delayed_sound("kubel_start", explosions[0].origin, (delay+1.2));

	level thread barrier_treefall(delay);

}

barrier_treefall(delay)
{
	tree1 = getent("barrier_tree1","targetname");
	tree2 = getent("barrier_tree2","targetname");

	wait(delay);
	tree2 rotateTo((334,252,68),1.5,1.5);
	level thread maps\_utility_gmi::playsoundinspace("tankdrive_treefall",tree2.origin);

	wait(1);
	tree1 rotateTo((270,300,0),2,2);
	level thread maps\_utility_gmi::playsoundinspace("tankdrive_treefall",tree1.origin);
}

play_delayed_sound(soundalias,origin, delay)
{
	wait(delay);
	level thread maps\_utility_gmi::playsoundinspace(soundalias,origin);
}

duckshoot_more_t34s()
{
	t34_1 = getent("convoy_t34_1","targetname");
	t34_1_node = getvehiclenode("duckshoot_t34_path1","targetname");

	t34_2 = getent("convoy_t34_2","targetname");
	t34_2_node = getvehiclenode("duckshoot_t34_path2","targetname");

	t34_3 = getent("convoy_t34_3","targetname");
	t34_3_node = getvehiclenode("duckshoot_t34_path3","targetname");

	trig = getent("attach_duckshoot_t34s","targetname");
	trig waittill("trigger");

	init_duckshoot_vehicles();

	t34_1 attachpath(t34_1_node);
	t34_2 attachpath(t34_2_node);
	t34_3 attachpath(t34_3_node);

	t34_1 notify("dont_hide");
	t34_2 notify("dont_hide");
	t34_3 notify("dont_hide");

	t34_1 show();
	t34_2 show();
	t34_3 show();


	t34_1 thread maps\kursk_tankdrive::friendly_path_setup(t34_1_node);
	t34_2 thread maps\kursk_tankdrive::friendly_path_setup(t34_2_node);
	t34_3 thread maps\kursk_tankdrive::friendly_path_setup(t34_3_node);

	t34_1 thread dummy_fire_loop("dummy_loop_target",0);
	t34_2 thread dummy_fire_loop("dummy_loop_target",0);

	for(i=0;i<level.duckshoottigers.size;i++)
	{
		level.duckshoottigers[i] thread dummy_fire_loop("duckshoot_tiger_targets",0);
	}

	trig2 = getent("start_duckshoot_t34s","targetname");
	trig2 waittill("trigger");

	t34_1 startpath();
	t34_2 startpath();
	t34_3 startpath();

	// temp hack fix
	t34_1 resumespeed(100);
	t34_2 resumespeed(100);
	t34_3 resumespeed(100);

	t34_3 thread dummy_fire_loop("dummy_loop_target",5);

	t34_1.damage_shield_fraction = 0;
	t34_2.damage_shield_fraction = 0;
	t34_3.damage_shield_fraction = 0;

	for(i=0;i<level.duckshoottigers.size;i++)
	{
		if(isdefined(level.duckshoottigers[i]) && isalive(level.duckshoottigers[i]))
		{
			level.duckshoottigers[i] startpath();
		}
	}

	level thread duckshoot_triggered_start();

	level waittill("duckshoot_combat_start");

//	println("starting duckshoot combat!");

	// un-invulnerablify the Tigers, and start them shooting at the player
	for(i=0;i<level.duckshoottigers.size;i++)
	{
		if(isdefined(level.duckshoottigers[i]) && isalive(level.duckshoottigers[i]))
		{
			level.duckshoottigers[i] notify("stop_dummy_fire_loop");
			level.duckshoottigers[i].damage_shield_fraction = 0;
			level.duckshoottigers[i] thread general_panzer_think();
			// tigers are scary, mmkay
			level.duckshoottigers[i].script_accuracy = 250;
			level.duckshoottigers[i] thread maps\_tank_pi::turret_attack_think_Kursk();
		}
	}

	// and cue your buds
	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i] thread duckshoot_friendly_think();
			level.friendlies[i].script_accuracy = 400;
			level.friendlies[i].damage_shield_fraction = 0.75;
//			println(level.friendlies[i].targetname," calling turret_attack_think_Kursk");
			level.friendlies[i].triggeredthink = true;
			level.friendlies[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.friendlies[i].mgturret setmode("manual");
		}
	}
	level.t34_commander.damage_shield_fraction = 1;

	// enable the clearing start
	level thread clearing_start();

//	while(level.duckshootkill < 3)
	while(LiveVehicleCount(level.duckshoottigers) > 0)
	{
		wait(3);
		//friendlies continually get more accurate
		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i].script_accuracy = (level.friendlies[i].script_accuracy * .75);
			}
		}
	}

}

duckshoot_friendly_think()
{
	self endon("stopthink");
	self endon("death");
	while(1)
	{
		// resort targets every 5 seconds
		for(i=0;i<level.duckshoottigers.size;i++)
		{
			if(isdefined(level.duckshoottigers[i]) && isalive(level.duckshoottigers[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.duckshoottigers[i]);
			}
		}
		
		closest_target = maps\kursk_tankdrive::get_closest_target(self.enemyqueue);
		if(isdefined(closest_target))
		{
	//		println("closest target to ",self.targetname," is ",closest_target.targetname);
			maps\_tank_pi::queue_add_to_front(closest_target);
		}
		wait(5);
	}
}

duckshoot_triggered_start()
{
	trig = getent("duckshoot_real_start","targetname");
	trig waittill("trigger");
	level notify("duckshoot_combat_start");
}

dummy_fire_loop(targetname,delay)
{
	// get us a fake target, and fire every few seconds
	self endon("stop_dummy_fire_loop");
	self endon("death");

	targetarray = getentarray(targetname,"targetname");

	if(delay > 0)
	{
		wait(delay);
	}

	delay = 3 + randomfloat(3);

	while(1)
	{
		self setTurretTargetEnt(targetarray[randomint(targetarray.size)], (0,0,0));
		wait ( 7 );
//		self thread turretTargetTimer(5);
//		self maps\_utility_gmi::waittill_any("turret_on_vistarget","turret_target_timeout");
		self notify("turret_fire");
//		println(self.targetname, " firing!");
		wait(delay);
	}

}

turretTargetTimer(time)
{
	self endon("turret_on_vistarget");
	wait(time);
	self notify("turret_target_timeout");
//	println(self.targetname, " timing out on vistargetwait");
}

init_duckshoot_vehicles()
{
	tiger1 = getent("duckshoot_tiger_1","targetname");
	tiger2 = getent("duckshoot_tiger_2","targetname");
	tiger3 = getent("duckshoot_tiger_3","targetname");

	// this bit done to improve level performance
	level.duckshoottigers[0] = vehicle_spawn("xmodel/vehicle_tank_tiger_camo", tiger1);
	level.duckshoottigers[1] = vehicle_spawn("xmodel/vehicle_tank_tiger_camo", tiger2);
	level.duckshoottigers[2] = vehicle_spawn("xmodel/vehicle_tank_tiger_camo", tiger3);

 	for(i=0;i<level.duckshoottigers.size;i++)
	{
		level.duckshoottigers[i].killcommit = true;
		level.duckshoottigers[i] maps\_tiger_pi::init_Kursk();

		// temporary invlunerability
		level.duckshoottigers[i] thread maps\kursk_tankdrive::enemy_damage_shield();
		level.duckshoottigers[i].damage_shield_fraction = 1;

		path = maps\kursk_tankdrive::nearestpath(level.duckshoottigers[i]);
		level.duckshoottigers[i] attachpath(path);
		level.duckshoottigers[i] thread maps\kursk_tankdrive::enemy_path_setup(path);
//		level.duckshoottigers[i] thread duckshoot_killcount();
	}
	level thread duckshoot_killcount2();
}
/*
duckshoot_killcount()
{

	eventnode1 = getvehiclenode("dkramer745","targetname");
	eventnode2 = getvehiclenode("dkramer743","targetname");
	eventnode3 = getvehiclenode("dkramer746","targetname");

	println("^5 duckshoot_killcount: thread started");

	self waittill("death");
	level.duckshootkill++;

	if( level.duckshootkill > 2 )
	{
		level notify("duckshoot_event_done");
//		level.clearingphase = 4;
		println("duckshoot completed");

		eventnode1.eventwaiting = false;
		eventnode2.eventwaiting = false;
		eventnode3.eventwaiting = false;


		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i] notify("stopthink");
				level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
			}
		}
	}
}
*/
duckshoot_killcount2()
{
	while(LiveVehicleCount(level.duckshoottigers) > 0)
		wait (1);

	eventnode1 = getvehiclenode("dkramer745","targetname");
	eventnode2 = getvehiclenode("dkramer743","targetname");
	eventnode3 = getvehiclenode("dkramer746","targetname");

	level notify("duckshoot_event_done");
//	level.clearingphase = 4;
	println("duckshoot completed");

	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;
	eventnode3.eventwaiting = false;

	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i] notify("stopthink");
			level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
		}
	}
}
/*
clearing_killcount()
{
	eventnode1 = getvehiclenode("dkramer770","targetname");
	eventnode2 = getvehiclenode("dkramer464","targetname");
	eventnode3 = getvehiclenode("dkramer765","targetname");
	eventnode4 = getvehiclenode("dkramer780","targetname");
	eventnode5 = getvehiclenode("dkramer786","targetname");

	println("^5 clearing_killcount: thread started");
	self waittill("death");
	println("clearingpanzerkill: ",level.clearingpanzerkill);
	level.clearingpanzerkill++;

	if( level.clearingpanzerkill > 2 )
	{
		level notify("clearing_event_done");
		level.clearingphase = 4;
		println("clearing wave 1 completed");
		eventnode1.eventwaiting = false;
		eventnode2.eventwaiting = false;
		eventnode3.eventwaiting = false;
		eventnode4.eventwaiting = false;
		eventnode5.eventwaiting = false;

		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i] notify("stopthink");
				level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
			}
		}
	}
}
*/
clearing_killcount2()
{
	while(LiveVehicleCount(level.clearingpanzers) > 0)
		wait (1);

	eventnode1 = getvehiclenode("dkramer770","targetname");
	eventnode2 = getvehiclenode("dkramer464","targetname");
	eventnode3 = getvehiclenode("dkramer765","targetname");
	eventnode4 = getvehiclenode("dkramer780","targetname");
	eventnode5 = getvehiclenode("dkramer786","targetname");

	level notify("clearing_event_done");
	level.clearingphase = 4;
//	println("clearing wave 1 completed");
	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;
	eventnode3.eventwaiting = false;
	eventnode4.eventwaiting = false;
	eventnode5.eventwaiting = false;

	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i] notify("stopthink");
			level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
		}
	}
}
/*
clearing2_killcount()
{
	eventnode1 = getvehiclenode("dkramer781","targetname");
	eventnode2 = getvehiclenode("dkramer788","targetname");
	eventnode3 = getvehiclenode("dkramer791","targetname");
	eventnode4 = getvehiclenode("dkramer767","targetname");
	eventnode5 = getvehiclenode("dkramer773","targetname");

	println("^5 clearing2_killcount: thread started");
	self waittill("death");
	level.clearingpanzer2kill++;

	if( level.clearingpanzer2kill > 1 )
	{
		level notify("clearing2_event_done");
		println("clearing phase 2 event completed");
		eventnode1.eventwaiting = false;
		eventnode2.eventwaiting = false;
		eventnode3.eventwaiting = false;
		eventnode4.eventwaiting = false;
		eventnode5.eventwaiting = false;

		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i] notify("stopthink");
				level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
			}
		}
	}
}
*/
clearing2_killcount2()
{
	while(LiveVehicleCount(level.clearingpanzers2) > 0)
		wait (1);

	eventnode1 = getvehiclenode("dkramer781","targetname");
	eventnode2 = getvehiclenode("dkramer788","targetname");
	eventnode3 = getvehiclenode("dkramer791","targetname");
	eventnode4 = getvehiclenode("dkramer767","targetname");
	eventnode5 = getvehiclenode("dkramer773","targetname");

	level notify("clearing2_event_done");
//	println("clearing phase 2 event completed");
	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;
	eventnode3.eventwaiting = false;
	eventnode4.eventwaiting = false;
	eventnode5.eventwaiting = false;

	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i] notify("stopthink");
			level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
		}
	}
}

init_clearing_vehicles()
{
//	clearingpanzers
	panzer1 = getent("clear_panzer_1","targetname");
	panzer2 = getent("clear_panzer_2","targetname");
	panzer3 = getent("clear_panzer_3","targetname");

//	clearingpanzers2
	panzer4 = getent("clear_panzer_4","targetname");
	tiger1 = getent("clear_tiger_2","targetname");

	level.clearingpanzers[0] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", panzer1);
	level.clearingpanzers[1] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", panzer2);
	level.clearingpanzers[2] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", panzer3);

	level.clearingpanzers2[0] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", panzer4);
	level.clearingpanzers2[1] = vehicle_spawn("xmodel/vehicle_tank_tiger_camo", tiger1);

	// wave 1
 	for(i=0;i<level.clearingpanzers.size;i++)
	{
		level.clearingpanzers[i].killcommit = true;
		// think based on what type we are
		if(level.clearingpanzers[i].vehicletype == "tiger")
		{
			level.clearingpanzers[i] maps\_tiger_pi::init_Kursk();
		}
		// if we're not a tiger, we're a panzeriv
		else
		{
			level.clearingpanzers[i] maps\_panzerIV_pi::init_Kursk();
		}
		path = maps\kursk_tankdrive::nearestpath(level.clearingpanzers[i]);
		level.clearingpanzers[i] attachpath(path);
		level.clearingpanzers[i] thread maps\kursk_tankdrive::enemy_path_setup(path);
//		level.clearingpanzers[i] thread clearing_killcount();
	}
	level thread clearing_killcount2();

	// wave 2
 	for(i=0;i<level.clearingpanzers2.size;i++)
	{
		level.clearingpanzers2[i].killcommit = true;
		// think based on what type we are
		if(level.clearingpanzers2[i].vehicletype == "tiger")
		{
			level.clearingpanzers2[i] maps\_tiger_pi::init_Kursk();
		}
		// if we're not a tiger, we're a panzeriv
		else
		{
			level.clearingpanzers2[i] maps\_panzerIV_pi::init_Kursk();
		}
		path = maps\kursk_tankdrive::nearestpath(level.clearingpanzers2[i]);
		level.clearingpanzers2[i] attachpath(path);
		level.clearingpanzers2[i] thread maps\kursk_tankdrive::enemy_path_setup(path);
//		level.clearingpanzers2[i] thread clearing2_killcount();
	}
	level thread clearing2_killcount2();
}

clearing_friendly_think()
{
	self endon("stopthink");
	self endon("death");
	while(1)
	{
		// resort targets every 5 seconds
		for(i=0;i<level.clearingpanzers.size;i++)
		{
			if(isdefined(level.clearingpanzers[i]) && isalive(level.clearingpanzers[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.clearingpanzers[i]);
			}
		}
		
		closest_target = maps\kursk_tankdrive::get_closest_target(self.enemyqueue);
		if(isdefined(closest_target))
		{
	//		println("closest target to ",self.targetname," is ",closest_target.targetname);
			maps\_tank_pi::queue_add_to_front(closest_target);
		}
		wait(5);
	}
}


clearing2_friendly_think()
{
	self endon("stopthink");
	self endon("death");
	while(1)
	{
		// resort targets every 5 seconds
		for(i=0;i<level.clearingpanzers2.size;i++)
		{
			if(isdefined(level.clearingpanzers2[i]) && isalive(level.clearingpanzers2[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.clearingpanzers2[i]);
			}
		}
		
		closest_target = maps\kursk_tankdrive::get_closest_target(self.enemyqueue);
		if(isdefined(closest_target))
		{
	//		println("closest target to ",self.targetname," is ",closest_target.targetname);
			maps\_tank_pi::queue_add_to_front(closest_target);
		}
		wait(5);
	}
}

clearing_start()
{
	trig = getent("clearing_start","targetname");
	trig waittill("trigger");

	// initialize the vehicles
	init_clearing_vehicles();

//	println("CLEARING STARTING");

	// start the first wave of baddies -- phase 1
	for(i=0;i<level.clearingpanzers.size;i++)
	{
		if(isdefined(level.clearingpanzers[i]) && isalive(level.clearingpanzers[i]))
		{
			level.clearingpanzers[i] thread general_panzer_think();
			level.clearingpanzers[i] startpath();
			// in phase 1, enemy tanks have lousy accuracy
			level.clearingpanzers[i].script_accuracy = 400;
			level.clearingpanzers[i] thread maps\_tank_pi::turret_attack_think_Kursk();
		}
	}

	wait(2); // waiting 2 seconds, then buddies join in
//	if(level.clearingpanzerkill < 3)
	if(LiveVehicleCount(level.clearingpanzers) > 0)
	{

//		println("CLEARING FRIENDLIES STARTING");

		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				// initial target selection
				level.friendlies[i] thread clearing_friendly_think();
				level.friendlies[i].script_accuracy = 400;
				level.friendlies[i].damage_shield_fraction = 0.65;
//				println(level.friendlies[i].targetname," calling turret_attack_think_Kursk");
				level.friendlies[i].triggeredthink = true;
				level.friendlies[i] thread maps\_tank_pi::turret_attack_think_Kursk();
				level.friendlies[i].mgturret setmode("manual");
				wait(randomfloat(2));
			}
		}
		level.t34_commander.damage_shield_fraction = 1;

		wait(5);
	}

	// enable the tunnel
	level thread tunnel_start();

//	if(level.clearingpanzerkill < 3)
	if(LiveVehicleCount(level.clearingpanzers) > 0)
	{
		level.clearingphase = 2;

//		println("CLEARING PHASE 2");

		for(i=0;i<level.clearingpanzers.size;i++)
		{
			if(isdefined(level.clearingpanzers[i]) && isalive(level.clearingpanzers[i]))
			{
				// in phase 2, enemy tanks have better accuracy
				level.clearingpanzers[i].script_accuracy = 200;
			}
		}

		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i].script_accuracy = 100;
				level.friendlies[i].damage_shield_fraction = 0.6;
				wait(randomfloat(2));
			}
		}
		level.t34_commander.damage_shield_fraction = 1;
		wait(10); // waiting 10 seconds, then phase 3
	}

	// phase 3 -- accurate enemies and the introduction of wave 2!
	level.clearingphase = 3;

//	if(level.clearingpanzerkill < 3)
	if(LiveVehicleCount(level.clearingpanzers) > 0)
	{
	
//		println("CLEARING PHASE 3");
		
		for(i=0;i<level.clearingpanzers.size;i++)
		{
			if(isdefined(level.clearingpanzers[i]) && isalive(level.clearingpanzers[i]))
			{
				level.clearingpanzers[i].script_accuracy = 75;
			}
		}
		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i].script_accuracy = 50;
				level.friendlies[i].damage_shield_fraction = 0.6;
				wait(randomfloat(2));
			}
		}
		level.t34_commander.damage_shield_fraction = 1;

	}

//	println("CLEARING WAVE 2 PANZERS");

	// wave 2 starts in phase 3
	for(i=0;i<level.clearingpanzers2.size;i++)
	{
		if(isdefined(level.clearingpanzers2[i]) && isalive(level.clearingpanzers2[i]))
		{
			level.clearingpanzers2[i] thread general_panzer_think();
			level.clearingpanzers2[i] startpath();
			// in phase 1, enemy tanks have lousy accuracy
			level.clearingpanzers2[i].script_accuracy = 300;
			level.clearingpanzers2[i] thread maps\_tank_pi::turret_attack_think_Kursk();
		}
	}

	// keep phase 2 panzers from being too deadly until the first phase is cleared
//	while(level.clearingpanzerkill < 3)
	while(LiveVehicleCount(level.clearingpanzers) > 0)
	{
		wait(1);
	}
	
	// ok, everybody from phase 1 is dead:
	level.clearingphase = 4;

//	println("CLEARING WAVE 1 ENDED");


//	if(level.clearingpanzer2kill < 2)
	if(LiveVehicleCount(level.clearingpanzers2) > 0)
	{
		// ratchet up phase 2 guys
		for(i=0;i<level.clearingpanzers2.size;i++)
		{
			if(isdefined(level.clearingpanzers2[i]) && isalive(level.clearingpanzers2[i]))
			{
				// in phase 2, enemy tanks have better accuracy
				level.clearingpanzers2[i].script_accuracy = 250;
			}
		}
		// tell our buddies to start going after the phase 2 tanks

//		println("CLEARING FRIENDLIES ATTACKING WAVE 2");

		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				// start the phase2 think
				level.friendlies[i] thread clearing2_friendly_think();
				level.friendlies[i].script_accuracy = 200;
				level.friendlies[i].damage_shield_fraction = 0.55;
//				println(level.friendlies[i].targetname," calling turret_attack_think_Kursk");
				level.friendlies[i] thread maps\_tank_pi::turret_attack_think_Kursk();
				level.friendlies[i].mgturret setmode("manual");
				wait(randomfloat(2));
			}
		}
		wait(5);
	}

	level.clearingphase = 5; // the final phase

//	if(level.clearingpanzer2kill < 2)
	if(LiveVehicleCount(level.clearingpanzers2) > 0)
	{
		// ratchet up phase 2 guys
		for(i=0;i<level.clearingpanzers2.size;i++)
		{
			if(isdefined(level.clearingpanzers2[i]) && isalive(level.clearingpanzers2[i]))
			{
				level.clearingpanzers2[i].script_accuracy = 100;
			}
		}
		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{

				level.friendlies[i].script_accuracy = 100;
				level.friendlies[i].damage_shield_fraction = 0.5;
			}
		}
		wait(5);
	}

//	while(level.clearingpanzer2kill < 2)
	while(LiveVehicleCount(level.clearingpanzers2) > 0)
	{
		//friendlies continually get more accurate
		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				level.friendlies[i].script_accuracy = (level.friendlies[i].script_accuracy * .75);
			}
		}
		wait(3);
	}

	level.clearingphase = 6; // we're done

	// reset our friendlies
	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i].script_accuracy = 0;
			level.friendlies[i].damage_shield_fraction = 0.5;
			level.friendlies[i] notify ("stopthink");
			level.friendlies[i] thread maps\kursk_tankdrive::setturretforward();
		}
	}
	level.t34_commander.damage_shield_fraction = 1;
}

tunnel_elefant_death()
{
	eventnode1 = getvehiclenode("dkramer820","targetname");
	eventnode2 = getvehiclenode("dkramer832","targetname");
	eventnode3 = getvehiclenode("dkramer828","targetname");

	self waittill("death");
	level.tunnel_completed = true;
    
	level notify("stage1_begin");

	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;
	eventnode3.eventwaiting = false;
}

tunnel_start()
{
	tunnel_truck_trigger = getent("tunnel_truck_trigger","targetname");
	tunnel_elefant = getent("tunnel_elefant","targetname");
	path = getvehiclenode("tunnel_tiger_path","targetname");
	tunnel_tiger_trigger = getent("tunnel_tiger_trigger","targetname");
	tunnel_guys = getentarray("tunnel_guys","targetname");

	level thread tunnel_dummies();

	trig = getent("tunnel_start","targetname");
	trig waittill("trigger");

	// start the T34 drive-by
	level notify("start_tunnel_dummies");
//	println("start_tunnel_dummies sent");

	// manage the infantry
//	thread maps\kursk_infantry::manage_tunnel_infantry();

	tunnel_truck_trigger thread truck_explode();

	tunnel_elefant.killcommit = true;
//	tunnel_elefant thread maps\_elefant_pi::init_Kursk();	// PGM
	tunnel_elefant maps\_elefant_pi::init_Kursk();			// PGM
	tunnel_elefant attachpath(path);

	// start the elefant firing
	tunnel_tiger_trigger waittill("trigger");
	tunnel_elefant thread general_panzer_think();
	tunnel_elefant thread tunnel_elefant_death();
	tunnel_elefant.script_accuracy = 100;
	tunnel_elefant thread maps\_tank_pi::turret_attack_think_Kursk();

	// set-up stage 1 of the end battle
	thread stage1_start();
//	thread end_battle();	// PGM

	end_battle();	// PGM - re-thread this if needed
}

//T34 driveby
tunnel_dummies()
{
	level waittill("start_tunnel_dummies");

	tank1 = getent("dkramer924","targetname");
	tank2 = getent("dkramer925","targetname");
	tank3 = getent("dkramer926","targetname");

	dummies[0] = vehicle_spawn("xmodel/vehicle_tank_t34",tank1);
	dummies[1] = vehicle_spawn("xmodel/vehicle_tank_t34",tank2);
	dummies[2] = vehicle_spawn("xmodel/vehicle_tank_t34",tank3);

	// init the dummies
	dummies = getentarray("tunnel_t34s","groupname");
	for(i=0;i<dummies.size;i++)
	{
		dummies[i].targetname = "tunnel_t34";
		dummies[i] t34_dummy_setup();
		dummies[i].damage_shield_fraction = 1;
		dummies[i] startpath();
	}

	dummies[2] waittill("reached_end_node");

	wait (3);

	dummies[0] attachpath(getvehiclenode("stage3_t34_1_path","targetname"));
	wait(0.1);
	dummies[0] notify("death");
	wait(0.1);
	dummies[1] attachpath(getvehiclenode("stage3_t34_2_path","targetname"));
	wait(0.1);
	dummies[1] notify("death");
	wait(0.1);
	dummies[2] attachpath(getvehiclenode("stage3_t34_3_path","targetname"));
	wait(0.1);
	dummies[2] notify("death");
}

stage1_start() // start limited AI movement
{
	trig = getent("stage1_start","targetname");
	trig waittill("trigger");
	level notify("stage1_begin");
}

end_battle()
{
	stage1_t34_1 = getent("stage1_t34_1","targetname");
	stage1_t34_2 = getent("stage1_t34_2","targetname");
	stage1_t34_3 = getent("stage1_t34_3","targetname");
//	stage1_t34_4 = getent("stage1_t34_4","targetname");
//	stage1_t34_5 = getent("stage1_t34_5","targetname");

	stage1_panzer_1 = getent("stage1_panzer_1","targetname");
	stage1_panzer_2 = getent("stage1_panzer_2","targetname");
	stage1_panzer_3 = getent("stage1_panzer_3","targetname");
	stage1_panzer_4 = getent("stage1_panzer_4","targetname");

	stage1_tiger_1 = getent("dkramer941","targetname");
	stage1_tiger_2 = getent("dkramer942","targetname");

	wait ( 0.1 );	// PGM

/*
	stage2_elefant_1 = getent("dkramer1018","targetname");
	stage2_elefant_2 = getent("dkramer1019","targetname");
	stage2_elefant_3 = getent("dkramer1020","targetname");

	stage2_tanks_1 = getent("dkramer1041","targetname");
	stage2_tanks_2 = getent("dkramer1038","targetname");
	stage2_tanks_3 = getent("dkramer1042","targetname");
*/
/*
	stage3_elefant_1 = getent("stage3_elefant_1","targetname");
	stage3_elefant_2 = getent("stage3_elefant_2","targetname");
	stage3_elefant_3 = getent("stage3_elefant_3","targetname");

	stage3_tiger_1 = getent("stage3_tiger_1","targetname");
*/

	wait ( 0.1 );	// PGM

	level.stage1_t34s[0] = vehicle_spawn("xmodel/vehicle_tank_t34", stage1_t34_1);
	level.stage1_t34s[1] = vehicle_spawn("xmodel/vehicle_tank_t34", stage1_t34_2);
	level.stage1_t34s[2] = vehicle_spawn("xmodel/vehicle_tank_t34", stage1_t34_3);
//	level.stage1_t34s[3] = vehicle_spawn("xmodel/vehicle_tank_t34", stage1_t34_4);	// PGM - moved to reinforcements moment
//	level.stage1_t34s[4] = vehicle_spawn("xmodel/vehicle_tank_t34", stage1_t34_5);

	wait ( 0.1 );	// PGM

	level.stage1_panzers[0] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", stage1_panzer_1);
	level.stage1_panzers[1] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", stage1_panzer_2);
	level.stage1_panzers[2] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", stage1_panzer_3);
	level.stage1_panzers[3] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", stage1_panzer_4);

	wait ( 0.1 );	// PGM

	level.stage1_tigers[0] = vehicle_spawn("xmodel/vehicle_tank_tiger_camo", stage1_tiger_1);
	level.stage1_tigers[1] = vehicle_spawn("xmodel/vehicle_tank_tiger_camo", stage1_tiger_2);
/*
	level.stage2_elefants[0] = vehicle_spawn("xmodel/v_ge_lnd_elefant", stage2_elefant_1);
	level.stage2_elefants[1] = vehicle_spawn("xmodel/v_ge_lnd_elefant", stage2_elefant_2);
	level.stage2_elefants[2] = vehicle_spawn("xmodel/v_ge_lnd_elefant", stage2_elefant_3);

	wait ( 0.1 );	// PGM

	level.stage2_tanks[0] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", stage2_tanks_1);
	level.stage2_tanks[1] = vehicle_spawn("xmodel/vehicle_tank_tiger_camo", stage2_tanks_2);
	level.stage2_tanks[2] = vehicle_spawn("xmodel/vehicle_tank_tiger_camo", stage2_tanks_3);

	wait ( 0.1 );	// PGM
*/
/*
	level.stage3_elefants[0] = vehicle_spawn("xmodel/v_ge_lnd_elefant", stage3_elefant_1);
	level.stage3_elefants[1] = vehicle_spawn("xmodel/v_ge_lnd_elefant", stage3_elefant_2);
	level.stage3_elefants[2] = vehicle_spawn("xmodel/v_ge_lnd_elefant", stage3_elefant_3);

	level.stage3_tigers[0] = vehicle_spawn("xmodel/vehicle_tank_tiger_camo", stage3_tiger_1);
	level.stage3_tigers[1] = getent("stage3_tiger_2","targetname"); // left for precaching purposes
*/

	wait ( 0.1 );	// PGM

// INITIALIZATION

	// initialize the stage 1 stuff -- start off as just dummies
//	for(i=0;i<level.stage1_t34s.size;i++)
	for(i=0;i<3;i++)	// PGM - just the first three
	{
		level.stage1_t34s[i] t34_dummy_setup();
		level.stage1_t34s[i].damage_shield_fraction = 1;
//		level.stage1_t34s[i] thread t34_death_reinforcement(); // when a t34 dies, summon another, if available
	}
	level thread t34_death_reinforcement2();

	wait ( 0.1 );	// PGM

 	for(i=0;i<level.stage1_panzers.size;i++)
	{
		level.stage1_panzers[i].killcommit = true;
		level.stage1_panzers[i] maps\_panzerIV_pi::init_Kursk();

		// temporary invlunerability
		level.stage1_panzers[i] thread maps\kursk_tankdrive::enemy_damage_shield();
		level.stage1_panzers[i].damage_shield_fraction = 1;

		path = maps\kursk_tankdrive::nearestpath(level.stage1_panzers[i]);
		level.stage1_panzers[i] attachpath(path);
		level.stage1_panzers[i] thread maps\kursk_tankdrive::enemy_path_setup(path);

//		level.stage1_panzers[i] thread stage1_killcount();

	}
	level thread end_stage1_killcount2();

	wait ( 0.1 );	// PGM

 	for(i=0;i<level.stage1_tigers.size;i++)
	{
		level.stage1_tigers[i].killcommit = true;
		level.stage1_tigers[i] maps\_tiger_pi::init_Kursk();

		// temporary invlunerability
		level.stage1_tigers[i] thread maps\kursk_tankdrive::enemy_damage_shield();
		level.stage1_tigers[i].damage_shield_fraction = 1;

		path = maps\kursk_tankdrive::nearestpath(level.stage1_tigers[i]);
		level.stage1_tigers[i] attachpath(path);
		level.stage1_tigers[i] thread maps\kursk_tankdrive::enemy_path_setup(path);

//		level.stage1_tigers[i] thread duckshoot_killcount();
	}	

//	wait ( 0.1 );	// PGM
/*
 	for(i=0;i<level.stage2_elefants.size;i++)
	{
		level.stage2_elefants[i].killcommit = true;
		level.stage2_elefants[i] maps\_elefant_pi::init_Kursk();

		path = maps\kursk_tankdrive::nearestpath(level.stage2_elefants[i]);
		level.stage2_elefants[i] attachpath(path);
		level.stage2_elefants[i] thread maps\kursk_tankdrive::enemy_path_setup(path);

//		level.stage2_elefants[i] thread stage2_killcount();
	}	

 	for(i=0;i<level.stage2_tanks.size;i++)
	{
		level.stage2_tanks[i].killcommit = true;
		if(level.stage2_tanks[i].vehicletype == "tiger")
		{
			level.stage2_tanks[i] maps\_tiger_pi::init_Kursk();
		}
		// if we're not a tiger, we're a panzeriv
		else
		{
			level.stage2_tanks[i] maps\_panzerIV_pi::init_Kursk();
		}
		path = maps\kursk_tankdrive::nearestpath(level.stage2_tanks[i]);
		level.stage2_tanks[i] attachpath(path);
		level.stage2_tanks[i] thread maps\kursk_tankdrive::enemy_path_setup(path);

//		level.stage2_tanks[i] thread stage2_killcount();
	}
	level thread end_stage2_killcount2();
*/
//	wait ( 0.1 );	// PGM

/*
 	for(i=0;i<level.stage3_elefants.size;i++)
	{
		level.stage3_elefants[i].killcommit = true;
		level.stage3_elefants[i] maps\_elefant_pi::init_Kursk();

		// temporary invlunerability
		level.stage3_elefants[i] thread maps\kursk_tankdrive::enemy_damage_shield();
		level.stage3_elefants[i].damage_shield_fraction = 1;
	
	
		path = maps\kursk_tankdrive::nearestpath(level.stage3_elefants[i]);
		level.stage3_elefants[i] attachpath(path);
		level.stage3_elefants[i] thread maps\kursk_tankdrive::enemy_path_setup(path);
	}

 	for(i=0;i<level.stage3_tigers.size;i++)
	{
		level.stage3_tigers[i].killcommit = true;
		level.stage3_tigers[i] maps\_tiger_pi::init_Kursk();

		// temporary invlunerability
		level.stage3_tigers[i] thread maps\kursk_tankdrive::enemy_damage_shield();
		level.stage3_tigers[i].damage_shield_fraction = 1;

		path = maps\kursk_tankdrive::nearestpath(level.stage3_tigers[i]);
		level.stage3_tigers[i] attachpath(path);
		level.stage3_tigers[i] thread maps\kursk_tankdrive::enemy_path_setup(path);
	}
*/
//	wait ( 0.1 );	// PGM

// END INITIALIZATION

	// start the first 3 t34s firing at dummy targets
	level.stage1_t34s[0] thread dummy_fire_loop("stage1_t34_1_target",0);
	level.stage1_t34s[1] thread dummy_fire_loop("stage1_t34_2_target",1);
	level.stage1_t34s[2] thread dummy_fire_loop("stage1_t34_3_target",1.5);

	wait ( 0.1 );	// PGM

	// start the first 4 panzers firing at dummy targets
	level.stage1_panzers[0] thread dummy_fire_loop("stage1_panzer_1_target",0);
	level.stage1_panzers[1] thread dummy_fire_loop("stage1_panzer_1_target",0); // yes, this is supposed to be stage1_panzer_1_target
	level.stage1_panzers[2] thread dummy_fire_loop("stage1_panzer_3_target",0);
	level.stage1_panzers[3] thread dummy_fire_loop("stage1_panzer_4_target",0);

	// set the Tigers up to start when the 1st Panzer is killed
	level thread stage1_tiger_start();

	level waittill("stage1_begin");
//	println("stage1_beginning");

	// dummies on the western side
//	level thread stage3_dummy_fight();		// PGM

	level.stage1_t34s[0] startpath();
	level.stage1_t34s[1] startpath();
	level.stage1_t34s[2] startpath();

	eventnode1 = getvehiclenode("dkramer944","targetname");
	eventnode2 = getvehiclenode("dkramer962","targetname");

	trig = getent("stage1_vulnerable","targetname");
	if(isdefined(trig))
		trig waittill("trigger");
	level notify("stage1_vulnerable");
//	println("stage1_vulnerable");

	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;

	// friendlies actually fighting
//	level.stage1_t34s[3].triggeredthink = true;
//	level.stage1_t34s[4].triggeredthink = true;

	for(i=0;i<level.stage1_t34s.size;i++)
	{
		if(isdefined(level.stage1_t34s[i]) && isalive(level.stage1_t34s[i]))
		{
			level.stage1_t34s[i] notify("stop_dummy_fire_loop");
			level.stage1_t34s[i] thread stage1_t34_think();
			level.stage1_t34s[i].script_accuracy = 250;
			level.stage1_t34s[i].damage_shield_fraction = 0.25;
			level.stage1_t34s[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.stage1_t34s[i].mgturret setmode("manual");
			level.stage1_t34s[i] addvehicletocompass();
		}
	}

	// Germans too
	for(i=0;i<level.stage1_panzers.size;i++)
	{
		if(isdefined(level.stage1_panzers[i]) && isalive(level.stage1_panzers[i]))
		{
			level.stage1_panzers[i] notify("stop_dummy_fire_loop");
			level.stage1_panzers[i] thread stage1_panzer_think();
			level.stage1_panzers[i] startpath();
			level.stage1_panzers[i].script_accuracy = 250;
			level.stage1_panzers[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.stage1_panzers[i].damage_shield_fraction = 0.2; // the end battle panzers tend to be a little tougher
		}
	}

	// your buddies
	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i] notify("stopthink");
			level.friendlies[i] thread stage1_t34_think();
			level.friendlies[i].script_accuracy = 150;
			level.friendlies[i].damage_shield_fraction = 0.25;
            level.friendlies[i].triggeredthink = true;
			level.friendlies[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.friendlies[i].mgturret setmode("manual");
			wait(randomfloat(2));
		}
	}

//	thread stage2_elefants()
//  thread stage2_panzers();
}

stage1_tiger_start()
{
	level waittill("stage1_tiger_start");
	
 	for(i=0;i<level.stage1_tigers.size;i++)
	{
		if(isdefined(level.stage1_tigers[i]) && isalive(level.stage1_tigers[i]))
		{
			level.stage1_tigers[i].damage_shield_fraction = 0; // tigers are hard enough
			level.stage1_tigers[i] thread stage1_panzer_think();
			level.stage1_tigers[i] startpath();
			level.stage1_tigers[i].script_accuracy = 150;
			level.stage1_tigers[i].triggeredthink = true; // so they don't start shooting right away
			level.stage1_tigers[i] thread maps\_tank_pi::turret_attack_think_Kursk();
//			level.stage1_tigers[i] thread stage1_tigerkillcount();
		}
	}
	level thread end_stage1_tigerkillcount2();

	//  make your buddies add the new Tigers to their target list
	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i] notify("stopthink"); // for turret_attack_think_kursk
			level.friendlies[i] notify("stop_stage1_t34_think"); // friendlies will use a new think that includes the tigers
			level.friendlies[i] thread stage1_t34_think2();
			level.friendlies[i].script_accuracy = 200;
			level.friendlies[i].damage_shield_fraction = 0.2;
 			level.friendlies[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.friendlies[i].mgturret setmode("manual");
			wait(randomfloat(2));
		}
	}

	// and the new t34s should do the same
	
	for(i=0;i<level.stage1_t34s.size;i++)
	{
		if(isdefined(level.stage1_t34s[i]) && isalive(level.stage1_t34s[i]))
		{
			// start the phase2 think
			level.stage1_t34s[i] notify("stopthink"); // for turret_attack_think_kursk
			level.stage1_t34s[i] notify("stop_stage1_t34_think"); // friendlies will use a new think that includes the tigers
			level.stage1_t34s[i] thread stage1_t34_think2();
			level.stage1_t34s[i].script_accuracy = 200;
			level.stage1_t34s[i].damage_shield_fraction = 0.2;
 			level.stage1_t34s[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.stage1_t34s[i].mgturret setmode("manual");
			wait(randomfloat(2));
		}
	}
	
}
stage1_panzer_think()
{
	self endon("stopthink");
	self endon("death");
	while(1)
	{
		// resort targets every 5 seconds
		for(i=0;i<level.friendlies.size;i++)
		{
			if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.friendlies[i]);
			}
		}

		for(i=0;i<level.stage1_t34s.size;i++)
		{
			if(isdefined(level.stage1_t34s[i]) && isalive(level.stage1_t34s[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.stage1_t34s[i]);
			}
		}
		
		self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.playertank);
		closest_target = maps\kursk_tankdrive::get_closest_target(self.enemyqueue);
		if(isdefined(closest_target))
		{
	//		println("closest target to ",self.targetname," is ",closest_target.targetname);
			maps\_tank_pi::queue_add_to_front(closest_target);
		}
		wait(5);
	}
}
/*
stage1_killcount()
{
	eventnode1 = getvehiclenode("dkramer968","targetname");
	eventnode2 = getvehiclenode("dkramer197","targetname");
	eventnode3 = getvehiclenode("dkramer981","targetname");

	// the allied t34s
	eventnode4 = getvehiclenode("dkramer956","targetname");
	eventnode5 = getvehiclenode("dkramer961","targetname");

	self waittill("death");
	level.stage1kill++;
//	println("level.stage1kill: ",level.stage1kill);

	if(level.stage1kill == 1)
	{
//		println("stage1_tiger_start");
		level notify("stage1_tiger_start"); // cue the tigers
	}

	// after the 4 stage one panzers are killed, stage 2 begins
	if( level.stage1kill == 4 )
	{
		level notify("stage1_panzers_done");
//		println("stage1_panzers_done, starting stage 2");
		level thread stage2();
		level.endphase = 1;
		eventnode1.eventwaiting = false;
		eventnode2.eventwaiting = false;
		eventnode3.eventwaiting = false;
		eventnode4.eventwaiting = false;
		eventnode5.eventwaiting = false;
	}
}
*/
end_stage1_killcount2()
{
	while(LiveVehicleCount(level.stage1_panzers) > 3)
		wait (1);

//	println("stage1_tiger_start");
	level notify("stage1_tiger_start"); // cue the tigers

	while(LiveVehicleCount(level.stage1_panzers) > 0)
		wait (1);

	level notify("stage1_panzers_done");
//	println("stage1_panzers_done, starting stage 2");

	eventnode1 = getvehiclenode("dkramer968","targetname");
	eventnode2 = getvehiclenode("dkramer197","targetname");
	eventnode3 = getvehiclenode("dkramer981","targetname");

	// the allied t34s
	eventnode4 = getvehiclenode("dkramer956","targetname");
	eventnode5 = getvehiclenode("dkramer961","targetname");
		
	level.endphase = 1;
	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;
	eventnode3.eventwaiting = false;
	eventnode4.eventwaiting = false;
	eventnode5.eventwaiting = false;
	
	stage2();	// PGM - thread this if not at the end of the function
}
/*
stage1_tigerkillcount()
{
	eventnode1 = getvehiclenode("dkramer1105","targetname");
	eventnode2 = getvehiclenode("dkramer1108","targetname");

	self waittill("death");
	level.stage1tigerkill++;
	println("level.stage1tigerkill: ",level.stage1tigerkill);

	// after the 2 stage one tigers are killed, allow the new t34s to advance further
	if( level.stage1tigerkill == 2 )
	{
		eventnode1.eventwaiting = false;
		eventnode2.eventwaiting = false;
	}
}
*/
end_stage1_tigerkillcount2()
{
	while(LiveVehicleCount(level.stage1_tigers) > 0)
		wait (1);

//	println("stage1_tigers killed ");

	// after the 2 stage one tigers are killed, allow the new t34s to advance further
	eventnode1 = getvehiclenode("dkramer1105","targetname");
	eventnode2 = getvehiclenode("dkramer1108","targetname");
	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;
}

stage2()
{
	stage2_elefant_1 = getent("dkramer1018","targetname");
	stage2_elefant_2 = getent("dkramer1019","targetname");
	stage2_elefant_3 = getent("dkramer1020","targetname");

	stage2_tanks_1 = getent("dkramer1041","targetname");
	stage2_tanks_2 = getent("dkramer1038","targetname");
	stage2_tanks_3 = getent("dkramer1042","targetname");

	wait ( 0.1 );	// PGM

	level.stage2_elefants[0] = vehicle_spawn("xmodel/v_ge_lnd_elefant", stage2_elefant_1);
	level.stage2_elefants[1] = vehicle_spawn("xmodel/v_ge_lnd_elefant", stage2_elefant_2);
	level.stage2_elefants[2] = vehicle_spawn("xmodel/v_ge_lnd_elefant", stage2_elefant_3);

	wait ( 0.1 );	// PGM

	level.stage2_tanks[0] = vehicle_spawn("xmodel/vehicle_tank_panzeriv_camo", stage2_tanks_1);
	level.stage2_tanks[1] = vehicle_spawn("xmodel/vehicle_tank_tiger_camo", stage2_tanks_2);
	level.stage2_tanks[2] = vehicle_spawn("xmodel/vehicle_tank_tiger_camo", stage2_tanks_3);

	level.flags["stage2_enemies_spawned"] = true;
	level notify ("stage2_enemies_spawned");

 	for(i=0;i<level.stage2_elefants.size;i++)
	{
		level.stage2_elefants[i].killcommit = true;
		level.stage2_elefants[i] maps\_elefant_pi::init_Kursk();

		path = maps\kursk_tankdrive::nearestpath(level.stage2_elefants[i]);
		level.stage2_elefants[i] attachpath(path);
		level.stage2_elefants[i] thread maps\kursk_tankdrive::enemy_path_setup(path);

//		level.stage2_elefants[i] thread stage2_killcount();
	}	

	wait(0.1);

 	for(i=0;i<level.stage2_tanks.size;i++)
	{
		level.stage2_tanks[i].killcommit = true;
		if(level.stage2_tanks[i].vehicletype == "tiger")
		{
			level.stage2_tanks[i] maps\_tiger_pi::init_Kursk();
		}
		// if we're not a tiger, we're a panzeriv
		else
		{
			level.stage2_tanks[i] maps\_panzerIV_pi::init_Kursk();
		}
		path = maps\kursk_tankdrive::nearestpath(level.stage2_tanks[i]);
		level.stage2_tanks[i] attachpath(path);
		level.stage2_tanks[i] thread maps\kursk_tankdrive::enemy_path_setup(path);

//		level.stage2_tanks[i] thread stage2_killcount();
	}
	level thread end_stage2_killcount2();

	wait(0.1);
	
	for(i=0;i<level.stage2_tanks.size;i++)
	{
		if(isdefined(level.stage2_tanks[i]) && isalive(level.stage2_tanks[i]))
		{
			level.stage2_tanks[i] thread stage1_panzer_think();
			level.stage2_tanks[i] startpath();
			level.stage2_tanks[i].script_accuracy = 200;
			level.stage2_tanks[i].triggeredthink = true; // so they don't start shooting right away
			level.stage2_tanks[i] thread maps\_tank_pi::turret_attack_think_Kursk();
		}
	}

	for(i=0;i<level.stage2_elefants.size;i++)
	{
		if(isdefined(level.stage2_elefants[i]) && isalive(level.stage2_elefants[i]))
		{
			level.stage2_elefants[i] thread stage1_panzer_think();
			level.stage2_elefants[i] startpath();
			level.stage2_elefants[i].script_accuracy = 650;
			level.stage2_elefants[i].triggeredthink = true; // so they don't start shooting right away
			level.stage2_elefants[i] thread maps\_tank_pi::turret_attack_think_Kursk();
		}
	}

	// friendlies need to worry about stage1_tigers, stage2_tanks, and stage2_elefants
	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i] notify("stopthink"); // for turret_attack_think_kursk
			level.friendlies[i] notify("stop_stage1_t34_think2"); // friendlies will use a new think that includes the tigers
			level.friendlies[i] thread stage2_t34_think();
			level.friendlies[i].script_accuracy = 175;
			level.friendlies[i].damage_shield_fraction = 0.2;
 			level.friendlies[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.friendlies[i].mgturret setmode("manual");
			wait(randomfloat(2));
		}
	}
	// as do any allied tanks yet alive
	for(i=0;i<level.stage1_t34s.size;i++)
	{
		if(isdefined(level.stage1_t34s[i]) && isalive(level.stage1_t34s[i]))
		{
			level.stage1_t34s[i] notify("stopthink"); // for turret_attack_think_kursk
			level.stage1_t34s[i] notify("stop_stage1_t34_think2"); // friendlies will use a new think that includes the tigers
			level.stage1_t34s[i] thread stage2_t34_think();
			level.stage1_t34s[i].script_accuracy = 175;
			level.stage1_t34s[i].damage_shield_fraction = 0.2;
 			level.stage1_t34s[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.stage1_t34s[i].mgturret setmode("manual");
			wait(randomfloat(2));
		}
	}
}

stage2_t34_think()
{
	self endon("stop_stage2_t34_think");
	self endon("death");
	while(1)
	{
		// resort targets every 5 seconds
		for(i=0;i<level.stage1_tigers.size;i++)
		{
			if(isdefined(level.stage1_tigers[i]) && isalive(level.stage1_tigers[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.stage1_tigers[i]);
			}
		}

		for(i=0;i<level.stage2_tanks.size;i++)
		{
			if(isdefined(level.stage2_tanks[i]) && isalive(level.stage2_tanks[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.stage2_tanks[i]);
			}
		}

		for(i=0;i<level.stage2_elefants.size;i++)
		{
			if(isdefined(level.stage2_elefants[i]) && isalive(level.stage2_elefants[i]))
			{
					self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.stage2_elefants[i]);
			}
		}

		closest_target = maps\kursk_tankdrive::get_closest_target(self.enemyqueue);
		if(isdefined(closest_target))
		{
	//		println("closest target to ",self.targetname," is ",closest_target.targetname);
			maps\_tank_pi::queue_add_to_front(closest_target);
		}
		wait(5);
	}
}

/*
stage2_killcount()
{
	eventnode1 = getvehiclenode("dkramer200","targetname");
	eventnode2 = getvehiclenode("dkramer983","targetname");
	eventnode3 = getvehiclenode("dkramer972","targetname");
	eventnode4 = getvehiclenode("dkramer1115","targetname");
	eventnode5 = getvehiclenode("dkramer1123","targetname");

	self waittill("death");
	level.stage2kill++;
	println("level.stage2kill: ",level.stage2kill);

	// after the elefants  && the stage 2 tanks are killed, stage 3 begins
	if( level.stage2kill == 6 )
	{
		level notify("stage2_elefants_done");
		println("stage2_elefants_done");
		level.endphase = 2;
		level thread stage3();
		eventnode1.eventwaiting = false;
		eventnode2.eventwaiting = false;
		eventnode3.eventwaiting = false;
		eventnode4.eventwaiting = false;
		eventnode5.eventwaiting = false;

		clipremove = getent("final_battle_player_containment_01","targetname");
		clipremove delete();
	}
}
*/

end_stage2_killcount2()
{
	stage2_fullgroup = maps\kursk_tankdrive::add_array_to_array ( level.stage2_elefants, level.stage2_tanks );

	while(LiveVehicleCount(stage2_fullgroup) > 0)
		wait (1);

	// after the elefants  && the stage 2 tanks are killed, stage 3 begins
	level notify("stage2_elefants_done");
//	println("stage2_elefants_done");
	level.endphase = 2;

	eventnode1 = getvehiclenode("dkramer200","targetname");
	eventnode2 = getvehiclenode("dkramer983","targetname");
	eventnode3 = getvehiclenode("dkramer972","targetname");
	eventnode4 = getvehiclenode("dkramer1115","targetname");
	eventnode5 = getvehiclenode("dkramer1123","targetname");
	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;
	eventnode3.eventwaiting = false;
	eventnode4.eventwaiting = false;
	eventnode5.eventwaiting = false;

	clipremove = getent("final_battle_player_containment_01","targetname");
	clipremove delete();

	stage3();
}

stage3_dummy_fight()
{
	// teleport the T34s to their spots
	dummies = getentarray("tunnel_t34s","groupname");
	for(i=0;i<dummies.size;i++)
	{
		node = getvehiclenode("stage3_t34_"+(i+1)+"_path","targetname");
		dummies[i] attachpath(node);
		dummies[i] thread dummy_fire_loop("stage3_t34_"+(i+1)+"_target",0);
	}

/*
	stage3_elefant_1 = getent("stage3_elefant_1","targetname");
	stage3_elefant_2 = getent("stage3_elefant_2","targetname");
	stage3_elefant_3 = getent("stage3_elefant_3","targetname");

	stage3_tiger_1 = getent("stage3_tiger_1","targetname");
	stage3_tiger_2 = getent("stage3_tiger_2","targetname");

	stage3_elefant_1 thread dummy_fire_loop("stage3_elefant_1_target",0);
	stage3_elefant_2 thread dummy_fire_loop("stage3_elefant_2_target",0);
	stage3_elefant_3 thread dummy_fire_loop("stage3_elefant_3_target",0);

	stage3_tiger_1 thread dummy_fire_loop("stage3_elefant_1_target",0);
	stage3_tiger_2 thread dummy_fire_loop("stage3_elefant_3_target",0);
*/
	level waittill("stage1_panzers_done");

	wait(5);
	dummies[2] notify("death");
	wait(15);
	dummies[1] notify("death"); 
	wait(5);
	dummies[0] notify("death");
}

stage3()
{

	stage3_elefant_1 = getent("stage3_elefant_1","targetname");
	stage3_elefant_2 = getent("stage3_elefant_2","targetname");
	stage3_elefant_3 = getent("stage3_elefant_3","targetname");

	stage3_tiger_1 = getent("stage3_tiger_1","targetname");

//	println("starting stage 3");
	level.stage3_elefants[0] = vehicle_spawn("xmodel/v_ge_lnd_elefant", stage3_elefant_1);
	level.stage3_elefants[1] = vehicle_spawn("xmodel/v_ge_lnd_elefant", stage3_elefant_2);
	level.stage3_elefants[2] = vehicle_spawn("xmodel/v_ge_lnd_elefant", stage3_elefant_3);

	level.stage3_tigers[0] = vehicle_spawn("xmodel/vehicle_tank_tiger_camo", stage3_tiger_1);
	level.stage3_tigers[1] = getent("stage3_tiger_2","targetname"); // left for precaching purposes

	wait(0.1);	// PGM

	level.flags["stage3_enemies_spawned"] = true;
	level notify ("stage3_enemies_spawned");

 	for(i=0;i<level.stage3_elefants.size;i++)
	{
		level.stage3_elefants[i].killcommit = true;
		level.stage3_elefants[i] maps\_elefant_pi::init_Kursk();

		// temporary invlunerability
		level.stage3_elefants[i] thread maps\kursk_tankdrive::enemy_damage_shield();
		level.stage3_elefants[i].damage_shield_fraction = 1;
	
	
		path = maps\kursk_tankdrive::nearestpath(level.stage3_elefants[i]);
		level.stage3_elefants[i] attachpath(path);
		level.stage3_elefants[i] thread maps\kursk_tankdrive::enemy_path_setup(path);
	}

 	for(i=0;i<level.stage3_tigers.size;i++)
	{
		level.stage3_tigers[i].killcommit = true;
		level.stage3_tigers[i] maps\_tiger_pi::init_Kursk();

		// temporary invlunerability
		level.stage3_tigers[i] thread maps\kursk_tankdrive::enemy_damage_shield();
		level.stage3_tigers[i].damage_shield_fraction = 1;

		path = maps\kursk_tankdrive::nearestpath(level.stage3_tigers[i]);
		level.stage3_tigers[i] attachpath(path);
		level.stage3_tigers[i] thread maps\kursk_tankdrive::enemy_path_setup(path);
	}

	wait(0.1);	// PGM

	// clear the eventwaits
	eventnode1 = getvehiclenode("dkramer1064","targetname");
	eventnode2 = getvehiclenode("dkramer1071","targetname");
	eventnode3 = getvehiclenode("dkramer1078","targetname");
	eventnode4 = getvehiclenode("dkramer1081","targetname");
	eventnode5 = getvehiclenode("dkramer1084","targetname");

	eventnode1.eventwaiting = false;
	eventnode2.eventwaiting = false;
	eventnode3.eventwaiting = false;
	eventnode4.eventwaiting = false;
	eventnode5.eventwaiting = false;

	for(i=0;i<level.stage3_elefants.size;i++)
	{
		if(isdefined(level.stage3_elefants[i]) && isalive(level.stage3_elefants[i]))
		{
			level.stage3_elefants[i] notify("stop_dummy_fire_loop");
			level.stage3_elefants[i] thread stage1_panzer_think();
			level.stage3_elefants[i] startpath();
			level.stage3_elefants[i].script_accuracy = 400;
			level.stage3_elefants[i].triggeredthink = true; // so they don't start shooting right away
			level.stage3_elefants[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.stage3_elefants[i].damage_shield_fraction = 0.2;
		}
	}	

	for(i=0;i<level.stage3_tigers.size;i++)
	{
		if(isdefined(level.stage3_tigers[i]) && isalive(level.stage3_tigers[i]))
		{
			level.stage3_tigers[i] notify("stop_dummy_fire_loop");
			level.stage3_tigers[i] thread stage1_panzer_think();
			level.stage3_tigers[i] startpath();
			level.stage3_tigers[i].script_accuracy = 100;
			level.stage3_tigers[i].triggeredthink = true; // so they don't start shooting right away
			level.stage3_tigers[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.stage3_tigers[i].damage_shield_fraction = 0;
		}
	}

	// friendlies need to worry about stage1_tigers, stage2_tanks, stage3_elefants, and stage3_tigers
	for(i=0;i<level.friendlies.size;i++)
	{
		if(isdefined(level.friendlies[i]) && isalive(level.friendlies[i]))
		{
			level.friendlies[i] notify("stopthink"); // for turret_attack_think_kursk
			level.friendlies[i] notify("stop_stage2_t34_think"); // friendlies will use a new think that includes the tigers
			level.friendlies[i] thread stage3_t34_think();
			level.friendlies[i].script_accuracy = 200;
			level.friendlies[i].damage_shield_fraction = 0;
 			level.friendlies[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.friendlies[i].mgturret setmode("manual");
			wait(randomfloat(2));
		}
	}
	// so do allied t34s
	for(i=0;i<level.stage1_t34s.size;i++)
	{
		if(isdefined(level.stage1_t34s[i]) && isalive(level.stage1_t34s[i]))
		{
			level.stage1_t34s[i] notify("stopthink"); // for turret_attack_think_kursk
			level.stage1_t34s[i] notify("stop_stage2_t34_think"); // friendlies will use a new think that includes the tigers
			level.stage1_t34s[i] thread stage3_t34_think();
			level.stage1_t34s[i].script_accuracy = 200;
			level.stage1_t34s[i].damage_shield_fraction = 0;
 			level.stage1_t34s[i] thread maps\_tank_pi::turret_attack_think_Kursk();
			level.stage1_t34s[i].mgturret setmode("manual");
			wait(randomfloat(2));
		}
	}
}

stage3_t34_think()
{
	self endon("stop_stage3_t34_think");
	self endon("death");
	while(1)
	{
		// resort targets every 5 seconds
		for(i=0;i<level.stage1_tigers.size;i++)
		{
			if(isdefined(level.stage1_tigers[i]) && isalive(level.stage1_tigers[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.stage1_tigers[i]);
			}
		}

		for(i=0;i<level.stage2_tanks.size;i++)
		{
			if(isdefined(level.stage2_tanks[i]) && isalive(level.stage2_tanks[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.stage2_tanks[i]);
			}
		}

		for(i=0;i<level.stage3_elefants.size;i++)
		{
			if(isdefined(level.stage3_elefants[i]) && isalive(level.stage3_elefants[i]))
			{
					self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.stage3_elefants[i]);
			}
		}

		for(i=0;i<level.stage3_tigers.size;i++)
		{
			if(isdefined(level.stage3_tigers[i]) && isalive(level.stage3_tigers[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.stage3_tigers[i]);
			}
		}

		closest_target = maps\kursk_tankdrive::get_closest_target(self.enemyqueue);
		if(isdefined(closest_target))
		{
	//		println("closest target to ",self.targetname," is ",closest_target.targetname);
			maps\_tank_pi::queue_add_to_front(closest_target);
		}
		wait(5);
	}
}
/*
t34_death_reinforcement()
{
	stage1_t34_4 = getent("stage1_t34_4","targetname");
	stage1_t34_5 = getent("stage1_t34_5","targetname");
	level endon("t34_stage1_reinforcement");

	self waittill("death");


	stage1_t34_4 startpath();
	stage1_t34_5 startpath();

	level notify("t34_stage1_reinforcement");
}
*/
LiveVehicleCount(grp)
{
	count = 0;

	for ( x=0; x<grp.size; x++ )
	{
		if(isdefined( grp[x]) && isalive ( grp[x] ) )
			count = count + 1;
	}

	return count;
}

t34_death_reinforcement2()
{
	while(LiveVehicleCount(level.stage1_t34s) > 2)
		wait (1);

//	println("^5 t34_death_reinforcement2: spawning in guys 4 & 5");
	stage1_t34_4 = getent("stage1_t34_4","targetname");
	stage1_t34_5 = getent("stage1_t34_5","targetname");

	level.stage1_t34s[3] = vehicle_spawn("xmodel/vehicle_tank_t34", stage1_t34_4);
	level.stage1_t34s[4] = vehicle_spawn("xmodel/vehicle_tank_t34", stage1_t34_5);

	wait (0.1); 

	level.stage1_t34s[3] t34_dummy_setup();
	level.stage1_t34s[3].damage_shield_fraction = 1;
	level.stage1_t34s[4] t34_dummy_setup();
	level.stage1_t34s[4].damage_shield_fraction = 1;

	wait (0.1); 

	level.stage1_t34s[3] startpath();
	level.stage1_t34s[4] startpath();
	level notify("t34_stage1_reinforcement");
}

stage1_t34_think()
{
	self endon("stop_stage1_t34_think");
	self endon("death");
	while(1)
	{
		// resort targets every 5 seconds
		for(i=0;i<level.stage1_panzers.size;i++)
		{
			if(isdefined(level.stage1_panzers[i]) && isalive(level.stage1_panzers[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.stage1_panzers[i]);
			}
		}
		
		closest_target = maps\kursk_tankdrive::get_closest_target(self.enemyqueue);
		if(isdefined(closest_target))
		{
	//		println("closest target to ",self.targetname," is ",closest_target.targetname);
			maps\_tank_pi::queue_add_to_front(closest_target);
		}
		wait(5);
	}
}

stage1_t34_think2()
{
	self endon("stop_stage1_t34_think2");
	self endon("death");
	while(1)
	{
		// resort targets every 5 seconds
		for(i=0;i<level.stage1_panzers.size;i++)
		{
			if(isdefined(level.stage1_panzers[i]) && isalive(level.stage1_panzers[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.stage1_panzers[i]);
			}
		}
		for(i=0;i<level.stage1_tigers.size;i++)
		{
			if(isdefined(level.stage1_tigers[i]) && isalive(level.stage1_tigers[i]))
			{
				self.enemyqueue = maps\_utility_gmi::add_to_array(self.enemyqueue, level.stage1_tigers[i]);
			}
		}
		
		closest_target = maps\kursk_tankdrive::get_closest_target(self.enemyqueue);
		if(isdefined(closest_target))
		{
	//		println("closest target to ",self.targetname," is ",closest_target.targetname);
			maps\_tank_pi::queue_add_to_front(closest_target);
		}
		wait(5);
	}
}

//---------------------
//
// REFRESH TANKS
//
//---------------------


// Spawn a friendly tank from the current tank
// spawner position. This method returns a pointer
// to the new tank.

spawn_friend_tank() {

	// The spawn location is just a script origin.
	// The targetname is determined in manage_tank_spawner
	// The value can be overridden before spawn_friend_tank.

	spawn_origin = getent(level.tank_spawner, "targetname");

	println("^6SPAWNING TANK AT!!! ", level.tank_spawner);

	newTank = spawnVehicle( "xmodel/vehicle_tank_t34", "newTank", "T34" , spawn_origin.origin, (0,0,0) );

	// init the new tank as if it were a friendly
	newTank init_friendly_tank();

	return newTank;

}

refresh_friend_tanks(trig_name, spawn_origin_name, goal_node_name) {

	trig = getent(trig_name, "targetname" );
	trig waittill("trigger");

	tank_min = level.friend_min;
	tank_max = level.friend_max;

	living = [];
	living_count = 0;

	// keep tabs on living state and living count
	for (i = 0; i < tank_max; i++) {
		if (isalive(level.friendlies[i])) {
			living[i] = 1;
			living_count++;
		} else {
			living[i] = 0;
		}
	}

	// check for the minimum
	while (living_count < tank_min) {
		
		dead_index = -1;

		// find a dead tank in the friendly list

		for (i = 0; i < tank_max; i++) {			
			if (living[i] == 0) {
				dead_index = i;
			}
		}
		
		// manually set the spawn point...then spawn
		level.tank_spawner = spawn_origin_name;
		new_tank = spawn_friend_tank();
		
		living_count++;

		// manually set the path since we are not near a legit entry point
		path = getvehiclenode (goal_node_name,"targetname");
		new_tank attachpath(path);

		// pathing as in init_friendly_tank()
		// this is done again here since we do not find a legit path
		new_tank thread maps\kursk_tankdrive::friendly_path_setup(path);
		new_tank startpath();

		// now put the tank in the friendly list
		level.friendlies[dead_index] = new_tank;
		println("Replenishing level.friendlies[",dead_index,"]");
		living[dead_index] = 1;

		// let the tank get moving before we check to spawn again
		wait(5);

	}

}

init_friendly_tank()
{

	// Make sure the tank has the proper tags for 
	// being in the tank friendly wave.

	self.groupname = "friendly";
	self.script_team = "allies";
	self.killcommit = true;
	self maps\_t34_pi::init_mg_think_only();// no think function

	self thread maps\kursk_tankdrive::friendly_tank_think();
	self.mgturret setmode("manual");

	// Now we must figure out a way to put the new friendly tank
	// on a legitimate path.

	// everybody gets invulnerable at the start
	self.damage_shield_fraction = 1;

}


//------------------------------------------
//
// TANK SPAWNING
//
// Friendly Tank Spawn Origin Management
//------------------------------------------

// manage all triggers to ensure that there is only one spawn point 

initTankSpawnTriggers()
{

	spawnerTrigArray = getentarray("trig_tank_spawner", "targetname");

	// thread all area sound management triggers
	if(isdefined (spawnerTrigArray) )
	{
		for ( i = 0; i < spawnerTrigArray.size; i++)
		{
			if(isdefined(spawnerTrigArray[i])) {
				// wait for this area to become active
				thread manageActiveSpawner( spawnerTrigArray[i], true );
			}
		}
	}	
}

// manageActiveSpawner() 
//
// resetAreaFlag = true is used for initing the trigger
// resetAreaFlag = false is used for recursing when hitting duplicate
//	area triggers while the area is already active

manageActiveSpawner( areaTrigger, resetAreaFlag )
{

	if (!isdefined(areaTrigger) ) {
		println("^1Undefined trigger passed to manageActiveSpawner().");
		return;
	}

	// add a global flag for each area trigger
	// use the target name for a unique flag name

	if ( resetAreaFlag == true ) {
		level.flags[areaTrigger.target] = false;
	}

	// wait to enter the area

	areaTrigger waittill( "trigger" );

	// Since multiple triggers will point to the same spawners,
	// protect against multiples. This should be happening
	// since all triggers that share the same targets are turned off.

	if (level.flags[areaTrigger.target] == true) {

		// restart the thread
		thread manageActiveSpawner( areaTrigger, false );
		println("^1Recursing in manageActiveSpawner().");
		return;

	} else {
		// set the level flags
		setActiveSpawner(areaTrigger);

		// turn off all triggers that share targets
		triggerOffByTarget(areaTrigger.target);
	}

	println("^Updating Tank Spawner.");

	// we should only target one spawn location
	activeSpawner = getent( areaTrigger.target, "targetname" );

	// set the static name for the spawn position
	level.tank_spawner = areaTrigger.target;

	// wait for the active flag to go false
	while ( level.flags[areaTrigger.target] == true ) {
		wait(0.25);
	}

	// re-activate the triggers
	triggerOnByTarget( areaTrigger.target );

}

// reset all spawner flags, only activating the current area

setActiveSpawner( activeArea )
{
	areaTrigArray = getentarray("trig_tank_spawner", "targetname");

	// set all areas to false

	if( isdefined(areaTrigArray) ) {

		for ( i = 0; i < areaTrigArray.size; i++) {

			if(isdefined(areaTrigArray[i])) {
				// negate all flags
				level.flags[areaTrigArray[i].target] = false;
			}
		}
	}

	// set the active area
	if ( isdefined(activeArea) ) {
		level.flags[ activeArea.target ] = true;
	} else {
		println("^1Undefined trigger passed to setActiveSpawner().");		
	}

}

// triggerOffByTarget()
//
// -turn off all triggers that share this target

triggerOffByTarget(triggerTarget) 
{

	areaTrigArray = getentarray("trig_tank_spawner", "targetname");

	if(isdefined (areaTrigArray) )
	{
		for ( i = 0; i < areaTrigArray.size; i++)
		{
			if(isdefined(areaTrigArray[i])) {

				if ( areaTrigArray[i].target == triggerTarget ) {
					// trigger is the same, turn it off
					areaTrigArray[i] maps\_utility_gmi::triggerOff();
					println("^1Turned off spawn trigger.");		
				}
			}
		}
	}
}

// triggerOnByTarget()
//
// -turn on all triggers that share this target

triggerOnByTarget(triggerTarget) 
{

	areaTrigArray = getentarray("trig_tank_spawner", "targetname");

	// thread all area sound management triggers
	if(isdefined (areaTrigArray) )
	{
		for ( i = 0; i < areaTrigArray.size; i++)
		{
			if(isdefined(areaTrigArray[i])) {

				if ( areaTrigArray[i].target == triggerTarget ) {
					// trigger is the same, turn it off
					areaTrigArray[i] maps\_utility_gmi::triggerOn();
					println("^1Turned on spawn trigger.");		
				}
			}
		}
	}
}

// copies data from a dummy model, spawns a vehicle, deletes the dummy model, returns the newly spawned vehicle
vehicle_spawn(model, vspawner)
{
	vehicle = spawnVehicle( model, vspawner.targetname, vspawner.vehicletype ,vspawner.origin, vspawner.angles );

	if(isdefined(vspawner.script_noteworthy))
		vehicle.script_noteworthy = vspawner.script_noteworthy;
	if(isdefined(vspawner.script_team))
		vehicle.script_team = vspawner.script_team;
	if(isdefined(vspawner.script_accuracy))
		vehicle.script_accuracy = vspawner.script_accuracy;
	if(isdefined(vspawner.target))
		vehicle.target = vspawner.target;
	if(isdefined(vspawner.vehicletype))
		vehicle.vehicletype = vspawner.vehicletype;
	if(isdefined(vspawner.triggeredthink))
		vehicle.triggeredthink = vspawner.triggeredthink;
	if(isdefined(vspawner.script_sound))
		vehicle.script_sound = vspawner.script_sound;
	if(isdefined(vspawner.groupname))
		vehicle.groupname = vspawner.groupname;

	vspawner delete();

	println("Spawned vehicle with targetname: ",vehicle.targetname);
	return vehicle;
}
