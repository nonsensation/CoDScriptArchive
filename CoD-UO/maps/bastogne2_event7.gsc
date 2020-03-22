//=====================================================================================================================
// Bastogne2_event7
//	
//	CONTAINS EVENTS:
//
//		EVENT 7a - Attack the convoy (noisy)
//		EVENT 7b - Attack convoy (stealth)
//
//=====================================================================================================================


//=====================================================================================================================
//	event2_init
//
//		Sets up any thing that needs to be set up for event2 and threads all event2 functions
//=====================================================================================================================
event7_init()
{
	level.flags["tank_dead"] = false;
	level.flags["tank_support_dead"] = false;
	// process the skipto
	level thread event7_debug_skipto();


	maps\_vehiclechase_gmi::main();
	
	//level waittill("event6_end");
	level notify("event7_begin");
	// start the friendly chains for the area
	
	getent ("spawn_convoy_assault","targetname") waittill ("trigger");
	
	level.blue[0].followmin = 0;
	level.blue[1].followmin = 0;
	level.blue[2].followmin = 0;
	level.blue[0].followmax = 0;
	level.blue[1].followmin = 0;
	level.blue[2].followmin = 0;
	
	level.blue[0] setgoalentity(level.player);
	level.blue[1] setgoalentity(level.player);
	level.blue[2] setgoalentity(level.player);
	
	// threads
	level thread event7_cleanup();
	level thread event7a_halftrack();
	level thread event7a_bazooka_guy1();
	level thread event7a_bazooka_guy2();
	level thread event_7_ambush_setup();
	level thread event_7_tank();
	level thread event_7_squad2();
//	level thread event_7_bazooka();
	level thread event7_retreat_from_tank();
	level thread event7_axis_control_normal();
	level thread event7_axis_control_special();
	level thread event7_player_fires_early();
	level thread event7_moody_hitdirt();
	level thread event7_allied_tank();
	level thread event7_last_squad_setup();
	level thread level_end();
	level thread event7_kill_all_ai();
	level thread event7_spawn_tank_support();
	level thread event7_wait_for_ai_deaths();
	level thread event7_completed();
	level thread event7_stand_backup();
	level thread event7_player_ignore();
	level thread event7_support();
	level thread event7_rock_explosion_setup();
	level thread event7_tank_hit_once_support();
	level.player thread init_player_dmg();
}

//=====================================================================================================================
//	event7_skipto
//
//		Sets up the event if we are skipping to it from the begining
//=====================================================================================================================
event7_debug_skipto()
{
	level endon("event7_end");

	
	if ( getcvar("skipto") == "event7" )
	{
		level notify("event6_end");
		level notify("event1to2_end");
		level notify("event2_end");
		level notify("event3_end");
	
		setcvar("skipto","none");
		
		level.player allowStand(true);
		level.player allowCrouch(true);
		level.player allowProne(true);
		
		// make sure the first events are killed
		//wait(0.05);
		//level notify("maps\bastogne2_event1to2::event1_end");
		//wait(0.05);
		//level notify("maps\bastogne2_event1to2::event1to2_end");
		
		// delete anybody that may remain from the begining of the level
		//maps\bastogne2_event1to2::event1_debug_cleanup();

		org = getnode("event7_skipto_player", "targetname");

		// move the player  underground so he can not see the teleports
		level.player setorigin((0,0,-10000));

		// move each of the characters to the appropriate starting position

		for(n=0;n<level.blue.size;n++)
		{
			myspot = getnode("event7_blue_skipto_"+(n+1), "targetname");
			level.blue[n] teleport (myspot.origin);
			level.blue[n] setgoalnode(getnode("event7_blue_skipto_"+(n+1),"targetname"));
		}
		

		level.player setorigin((11817,6648,105));

		// move player to their position
//		level.player unlink();
//		level.player setorigin( org.origin );
		
		wait 3;
		
		for(n=0;n<level.blue.size;n++)
		{
			level.blue[n] setgoalentity (level.player);
		}
		level.moody = level.blue[0];
		
		
	}
}

//=====================================================================================================================
//	event7_cleanup
//
//		Cleans up any thing that needs to be cleaned up for event7
//=====================================================================================================================
event7_cleanup()
{
	level waittill("event6_end");
}

//=====================================================================================================================
//	event7a_halftrack
//
//		Spawns in halftrack, gets blown up, veers off road.
//=====================================================================================================================

event7a_halftrack()
{
	wait 1;
//	level.moody thread anim_single_solo(level.moody,"moody_goto_ambush");
	
	htnode = getvehiclenode("convoy_halftrack","targetname");
	
	getent ("convoy_start","targetname") waittill ("trigger");
	//level waittill ("convoy begin");

	level notify ("convoy begin");
	ht1 = getent ("halftrack1","targetname");
	ht1 thread maps\_halftrack_gmi::init("reached_end_node");
	ht1 thread maps\_vehiclechase_gmi::main();
	ht1.health = 100;
	ht1 thread kill_lights();
//	ht1 thread kill();
	path = getVehicleNode(ht1.target,"targetname");

	ht1 thread enemy_vehicle_paths_mod(path);

	ht1 startpath();


	playfxontag( level._effect["truck_lights"], ht1,"tag_origin");
	
	wait 2;
	
	trucktrig = getent ("ta_1","script_noteworthy");
	trucktrig useBy(level.player);
	
	wait 1.5;
	
	trucktrig = getent ("ta_2","script_noteworthy");
	trucktrig useBy(level.player);
	
	ht1 thread mg42_halftrack_off();
	

//	node = getvehiclenode ("jesse274","targetname");	
 	node = getvehiclenode ("jesse275","targetname");
	ht1 setWaitNode (node);
	ht1 waittill ("reached_wait_node");
	wait 1.4;
//	wait 2.4;

	level notify ("blow me up tom");

	
//	ht1 waittill ("reached_end_node");


//	ht1 disconnectpaths();
}

enemy_vehicle_paths_mod(path)
{
	pathstart = path;
	if(!isdefined (pathstart))
	{
		println (self.targetname, " isn't near a path");
		return;
	}
	pathpoint = pathstart;

	crash_paths = getvehiclenodearray("crash_path", "targetname");
	while(isdefined (pathpoint))
	{

		shorterdist = 128;
		for(i=0;i<crash_paths.size;i++)
		{
			length = distance(crash_paths[i].origin,pathpoint.origin);
			if(length < shorterdist)
			{
				theone = crash_paths[i];
				shorterdist = length;
			}
		}
		if(isdefined(theone))
		{
			pathpoint.crash_path_target = theone;
			theone = undefined;
		}
		if(isdefined (pathpoint.target))
			pathpoint = getvehiclenode(pathpoint.target, "targetname");
		else
			break;
	}
	pathpoint = pathstart;
	arraycount = 0;
	while(isdefined (pathpoint))
	{
		pathpoints[arraycount] = pathpoint;
		arraycount++;
		if(isdefined (pathpoint.target))
		{
			pathpoint = getvehiclenode(pathpoint.target, "targetname");

		}
		else
			break;
	}
	pathpoint = pathstart;
	for(i=0;i<pathpoints.size;i++)
	{
		if(isdefined(pathpoints[i].crash_path_target))
		{
			switchnode = pathpoints[i].crash_path_target;
			if(isdefined (switchnode))
			{
				self setWaitNode(pathpoints[i]);
				self.crashing_path = switchnode;
				self waittill ("reached_wait_node");

				waited = true;  //do multiple things on one node
				if(isdefined(self.deaddriver) || self.health <= 0)
				{

					if((!isdefined (switchnode.derailed)))
					{
						self notify ("crashpath");
						switchnode.derailed = 1;
						self setSwitchNode (pathpoints[i],switchnode);
					}
				}
			}
		}
		waited = false;
	}
}

kill()
{
	self waittill ("death");

	println("^3 *****************   HALFTRACK USE SLOW DEATH ***********");
	if(!isdefined(self.rollingdeath))
	{
		self setspeed(0,25);
	}

	if(self.speed < 1)
	{
		self setspeed(3,25);
	}
	println(self.targetname," ^1SELF ROLLINGDEATH!!!");
	wait 8;
//	self waittill ("deathrolloff");
	println(self.targetname," ^1SELF ROLLINGDEATH2!!!");
	self setspeed(0,25);

	wait 4;
	wait 0.3;
	self setspeed(0,10000);
	self notify ("deadstop");

	self freevehicle();
}

kill_lights()
{
	self waittill("death");
	level thread truck_turn_light_off(self);	// this will wait till they die to turn off lights
}

truck_turn_light_off(vehicle)
{
//	self waittill("death");
//	wait 0.05
	stopattachedfx(vehicle);
}

#using_animtree("generic_human");
event7a_bazooka_guy1()
{
	bazooka_spawn1 = getent("bazooka_guy_1","targetname");
	level waittill ("convoy begin");
	guy = bazooka_spawn1 stalingradspawn();
	guy waittill("finished spawning");
	
	guy.playpainanim = false;
	guy.ignoreme = true;
	guy.pacifist = true;
	guy.pacifistwait = 0;
	guy.health = 100000;
	guy.bravery = 50000;
	guy.goalradius = 8;
	guy.accuracy = 1.0;
//	guy.deathAnim = guy getExplodeDeath("generic", org, dist);
	
	node = getnode("bazooka_blast1","targetname");
	guy setgoalnode (node);
	guy waittill ("goal");
	
	halftrack = getent ("halftrack1","targetname");
	
	/*max_distance = 600;
	while(1)
	{
		if (distance (guy.origin, halftrack.origin) <= max_distance)
		{
			println(max_distance+": Distance from guy to HT: "+distance (guy.origin, halftrack.origin));
			break;
		}
		wait 0.05;
	}*/
	level waittill ("blow me up tom");

//	wait 5;	
	level.scr_anim["moody"]["moody_now"]			= (%c_us_bastogne2_moody_now);
	
	level.scr_notetrack["moody"][0]["notetrack"]		= "moody_now";
	level.scr_notetrack["moody"][0]["dialogue"]		= "moody_now";
	level.scr_notetrack["moody"][0]["facial"]		= (%f_bastogne2_moody_now);

	level.moody thread anim_single_solo(level.moody,"moody_now");

	level notify ("moody gives command");
	guy animscripts\combat_gmi::fireattarget(halftrack.origin+(400,0,100), 3, undefined, undefined, undefined, true);
	wait 1.1;
	
	level notify ("bazooka fired");
	
	node = getnode("bazooka_blast1_post","targetname");
	guy setgoalnode (node);
	guy waittill ("goal");
	
	guy.pacifist = false;
	guy.ignoreme = false;
	guy.accuracy = 0.5;
	guy.playpainanim = true;
	
	level.moody thread anim_single_solo(level.moody,"moody_mg34");
	// rich sound note -- add incoming panzier sound...
	
	level waittill("kill bazooka guy 1");
	wait .25;
	guy.deathAnim = guy getExplodeDeath("generic", org, dist);
	guy dodamage(guy.health + 50,(0,0,0));
}

event7a_bazooka_guy2()
{
	bazooka_spawn1 = getent("bazooka_guy_2","targetname");
	level.guy_b = bazooka_spawn1 stalingradspawn();
	level.guy_b waittill("finished spawning");
	level.guy_b.playpainanim = false;
	level.guy_b.ignoreme = true;
	level.guy_b.pacifist = true;
	level.guy_b.pacifistwait = 0;
	level.guy_b.health = 100000;
	level.guy_b.bravery = 50000;
	level.guy_b.goalradius = 8;
	level.guy_b.accuracy = 1.0;
	level.guy_b.friendname = "Pvt. Smith";
	
	halftrack = getent ("halftrack1","targetname");
	
	level waittill ("moody gives command");
	wait 0.1;
	level.guy_b animscripts\combat_gmi::fireattarget(halftrack.origin+(500,0,100), 3, undefined, undefined, undefined, true);
	wait 1.5;
	
	level notify ("bazooka fired");
	
//	guy thread event7_retreat_from_tank(); // makes guy runaway when tank comes...

	level waittill("kill bazooka guy");
	level.guy_b dodamage(level.guy_b.health + 50,(0,0,0));
	level notify("bazooka guy 2 dead");
	level.moody thread anim_single_solo(level.moody,"moody_scrap_panzer");
}


//
// Support Functions.
//

german_truck (trigger)
{	
	trigger waittill ("trigger");
	truck = getent (trigger.target,"targetname");
	driver = getent (truck.target,"targetname");
	
	truck maps\_truck_gmi::init();
	truck maps\_truck_gmi::attach_guys(undefined,driver);
	path = getVehicleNode(truck.target,"targetname");
	truck attachpath (path);
	truck startPath();

	truck thread kill_lights();
	playfxontag( level._effect["truck_lights"], truck,"tag_origin");

	node = path;

	truck.health = 1000;
	
	while (1)
	{
		node = getvehiclenode (node.target,"targetname");
		truck setWaitNode (node);
		truck waittill ("reached_wait_node");
		if (isdefined (node.script_noteworthy))
		{
			if(node.script_noteworthy == "unload1" && truck.targetname == "convoy_truck_1")
			{
				truck disconnectpaths();
				break;
			}
			else if(node.script_noteworthy == "unload2" && truck.targetname == "convoy_truck_2")
			{
				truck disconnectpaths();
				break;
			}
			else if(node.script_noteworthy == "alert_axis")
			{
				level notify("axis alerted");
			}
		}
	}
	
	if (truck.targetname == "convoy_truck_1")
	{
		truck setSwitchNode (node,getvehiclenode("truck1_switch","targetname"));
	}
	
	if (truck.targetname == "convoy_truck_2")
	{
		truck setSwitchNode (node,getvehiclenode("truck2_switch","targetname"));
	}
	
	truck waittill ("reached_end_node");
	truck setspeed(0,1000000);
				
	truck notify ("unload");
	truck stopEngineSound();
	truck disconnectpaths();
}


mg42_halftrack_off()
{
	self.mgturret setturretrange(1);
}

mg42_halftrack_on()
{
	self.mgturret setturretrange(100000);
}

event_7_ambush_setup()
{
	//level waittill ("convoy begin");
	moody 	 = getent("blue_0","targetname");
	other	 = getent("blue_1","targetname");
	anderson = getent("blue_2","targetname");
	
	//moody setgoalnode(getnode("ambush_0","targetname"));
	//moody.goalradius = 8;
	moody.pacifist = true;
	moody.ignoreme = true;
	
	//other setgoalnode(getnode("ambush_1","targetname"));
	//other.goalradius = 8;
	other.pacifist = true;
	other.ignoreme = true;
	
	//anderson setgoalnode(getnode("ambush_2","targetname"));
	//anderson.goalradius = 8;
	anderson.pacifist = true;
	anderson.ignoreme = true;
	
	level waittill ("bazooka fired");
	
	moody.pacifist = false;
	moody.ignoreme = false;
	other.pacifist = false;
	other.ignoreme = false;
	anderson.pacifist = false;
	anderson.ignoreme = false;
}

event_7_tank() //tiger
{
	level waittill ("convoy begin");
	wait 10;
	
	tank1 = spawnVehicle("xmodel/vehicle_tank_PanzerIV_camo", "endpanzer1", "PanzerIV" ,(0,0,0), (0,0,0) );
	tank1 maps\_panzeriv_gmi::init();
	tank1 maps\_tankgun_gmi::mgon();
	tank1 attachpath(getVehicleNode ("tank_path","targetname"));
	tank1.isalive = 1;
	tank1.health = 1200;
	tank1 startpath();
	level notify ("panzer coming");
	wait 0.5;
	tank1 thread tank1_retreat();
	tank1 thread event7_tank_health_think();
	
	while (1)
	{
		node = getvehiclenode ("jesse295","targetname");		// Jesse bad, jesse very bad.
		tank1 setWaitNode (node);
		tank1 waittill ("reached_wait_node");
		if (isdefined (node.script_noteworthy))
		{
			if(node.script_noteworthy == "tank_retreat")
			{
				break;
			}
		}
	}


	level notify("tank retreat");

	wait 4;

	println("^3 ************* tank is at this defined waitnode******");
	tank1 thread event7_tank_fire_think();



	
	
	node = getvehiclenode ("jesse296","targetname");		// Jesse bad, jesse very bad.
	tank1 setWaitNode (node);
	tank1 waittill ("reached_wait_node");
//	level notify ("spawn tank support");
	
	tank1 waittill ("reached_end_node");
	tank1 disconnectpaths();

	tank1 thread event_7_tank_maingun_think();
	level notify("kill bazooka guy");
	level notify("objective_12_complete");
	
	// setup path so tank can move forward on path or backwards after getting hit once...
	
	while (isalive(tank1))
	{
		wait 0.25;
	}

	level thread event7_germans_run_when_tank_blown();
	level.flags["tank_dead"] = true;

	level notify ("end_weta");
//	wait 0.05;
	level thread axis_do_damage();
		

	println(" ^2 *********** TANK_DEAD IS complete **************");
}

tank1_retreat()
{
	while(isalive(self))
	{
	
			if(self.health <= 700)	// after one hit make it tough
			{
				self setTurretTargetEnt(level.player, (0, 0, 10) );
				self thread maps\_tiger_gmi::fire();
				println("^3 ********** tank fired:    tank1_retreat1 ");
				self attachpath(getVehicleNode ("tank_path_retreat","targetname"));
				self startpath();
				self setspeed(4,30);
				angle1 = (10240,6072,60);
				level thread event7_german_yells(angle1);
				self setTurretTargetEnt(level.player, (0, 0, 10) );
				println("^ 3 tank is now firing but the allies are still running away early");
				self thread maps\_tiger_gmi::fire();
				println("^3 ********** tank fired:    tank1_retreat2 ");
				break;
			}

		wait 0.05;
	}
}

event7_tank_health_think()
{
	// full health == easy
	// one hit == accuracy increase for main gun and cannons with movement
	while(1)
	{
		if(self.health <= 700)
		{
			axis = getaiarray("axis");
			println("^4 ARRRRRRRRRRRRRRRRRRRGHG increase defensive manuevers", self.health);
			println("^4 ARRRRRRRRRRRRRRRRRRRGHG increase defensive manuevers");
			println("^4 ARRRRRRRRRRRRRRRRRRRGHG increase defensive manuevers");
			println("^4 ARRRRRRRRRRRRRRRRRRRGHG increase defensive manuevers");
			println("^4 ARRRRRRRRRRRRRRRRRRRGHG increase defensive manuevers");
				for (i=0;i<axis.size;i++)
				{
					if(isalive(axis[i]))
					{
						axis[i].accuracy = 0.8;	
						//axis[i].health = 190;
					}
					wait 0.05;
				}
			level notify ("spawn tank support");
			break;
		}
		wait 0.05;
	}
}

// when he says stay down.. make sure the player stays down...

event_7_tank_maingun_think()	// make tank choose between two targets then hit guys...
{
//	wait 5;
//	tank setTurretTargetEnt(tree_burst, (0, 0, 0) );
	println("^3 ********* tank fired at tree now ************");
	self thread maps\_panzeriv_gmi::fire();


	while(isalive(self))
	{
			if(self.health >= 700)	// full health ... the tank is inaccurate
			{
				self endon("death");
				wait (6 + randomfloat (4));
				{
					self endon("death");	
					self setTurretTargetEnt(level.player, (250, 150, 120) );
					wait (0.3 + randomfloat (0.9));
					self endon("death");
					self thread maps\_panzeriv_gmi::fire();	
				}
			}
	
			if(self.health <= 700)	// after one hit make it tough
			{
				self endon("death");
				wait (3.3 + randomfloat (3.3));
				{
					self endon("death");	
					self setTurretTargetEnt(level.player, (10, 10, 10) );
					wait (0.1 + randomfloat (0.3));
					self endon("death");
					self thread maps\_panzeriv_gmi::fire();	
				}
			}

		wait 0.05;
	}
}

event7_completed() // end counter...
{
//	while (level.flags["tank_dead"] == false || level.flags["tank_support_dead"] == false)
//	{
//		wait 0.25;
//	}

	while (level.flags["tank_dead"] == false)
	{
		wait 0.25;
	}
	level notify("tank dead");
	level notify("objective_13_complete");
	wait 7;
	level.moody thread anim_single_solo(level.moody,"moody_helluva_fight");
}

event7_kill_all_ai()
{
	getent ("spawn_convoy_assault","targetname") waittill ("trigger");
	
	println("^1Removing all Axis now.");
	level notify("end_beta");
	level notify("end_alpha");

	ai = getaiarray("axis");
	for (i=0;i<ai.size;i++)
	{
		if(isalive(ai[i]))
		{
			ai[i] delete();
		}
	}
}

event7_spawn_tank_support()
{
	level waittill ("spawn tank support");
	
	ai = getentarray("tank_group","groupname");
	
	for (i=0;i<ai.size;i++)
	{
		guy = ai[i] stalingradspawn();
		guy waittill("finished spawning");
		guy.pacifist = 0;
		guy.ignoreme = true;
		guy.bravery = 5000000;
		guy allowedstances("stand");
		guy thread event7_tank_support_think();	
	}
	
	level notify ("panzer support spawned");
}

event7_tank_support_think()
{
	self waittill ("goal");
	self allowedstances("stand","crouch","prone");
	self.ignoreme = true;
}

event7_germans_run_when_tank_blown()
{	
	axis = getaiarray("axis");
	
	for (i=0;i<axis.size;i++)
	{

		if(isalive(axis[i]))
		{

				axis[i] thread event7_runaway_think();
		}
	}
}

event7_runaway_think()
{
	fnode = getnode("tank_blown_run", "targetname");
	self setgoalnode(fnode);
	self waittill("goal");
	self dodamage(self.health + 50,(0,0,0));
	println("^3 ********8 thig guy will RUN HIS LITTLE ASS OFF *************");
}


event7_wait_for_ai_deaths()
{
	level waittill ("panzer support spawned");
	level notify ("end_zeta");	// this stops support group that comes from over the hill
	alive_flag = false;
	ai = getaiarray("axis");
	
	while (alive_flag == false)
	{
		alive_count = 0;
		for (i=0;i<ai.size;i++)
		{
			if (isalive(ai[i]))
			{
				alive_count++;
			}
		}
		
		if (alive_count == 0)
		{
			level notify("stop_spooky_german_sounds");
			alive_flag = true;
		}
		wait 0.05;
	}
	level.flags["tank_support_dead"] = true;
	level notify ("engage_event7_tank_hit_once_support"); // bring in last guys
}



event_7_squad2()
{
	spawners = getentarray("squad2_convoy","targetname");
	
	for (i=0;i<spawners.size;i++)
	{
		level.guy = spawners[i] stalingradspawn();
		level.guy waittill("finished spawning");
		level.guy.pacifist = true;
		level.guy.ignoreme = true;
		level.guy thread event_7_squad2_think();
		
		if (isdefined(spawners[i].script_noteworthy))
		{
			level.guy.targetname = spawners[i].script_noteworthy; //squad2_1 and so on up to three
		}
		
	}
	
}

event_7_squad2_think()
{
	self allowedstances("crouch");
	self waittill("bazooka fired");
	self allowedstances("prone","stand","crouch");
	self.ignoreme = false;
	self.pacifist = false;	
}

event_7_bazooka()
{
	bazooka = getent("the_bazooka","targetname");
	oldorg = bazooka.origin;
	bazooka.origin = bazooka.origin + (0,0,-1000);
	level waittill("bazooka guy 2 dead");
	bazooka.origin = oldorg;
	
	while (level.flags["tank_dead"] == false)
	{
		wait 0.25;
	}
	
	bazooka delete();
}

event7_retreat_from_tank()
{
	level waittill("tank retreat");
	
	allies = getaiarray("allies");
	
	for (i=0;i<allies.size;i++)
	{
		if(isalive(allies[i]))
		{
			allies[i].ignoreme = false;
			allies[i].pacifist = false;
			allies[i] allowedstances("crouch", "prone");
		}
	}
	
	guy1 = getent("squad2_1","targetname");
	if (isalive(guy1))
	{
//		println("^3 ********** runaway!!!! ", guy1.targetname, guy2.health);
		guy1.goalradius = 8;
		guy1 setgoalnode(getnode("retreat_point1","targetname"));
	}
	
	guy2 = getent("squad2_2","targetname");
	if (isalive(guy2))
	{
		println("^3 ********** runaway!!!! ", guy2.targetname, guy2.health);
		guy2.goalradius = 8;
		guy2 setgoalnode(getnode("retreat_point2","targetname"));	
	}

//	guy3 = getent("bazooka_guy_2","targetname");
	if (isalive(level.guy_b))
	{
		println("^3 ********** runaway!!!! ", level.guy_b.targetname, level.guy_b.health);
		level.guy_b.goalradius = 75;
//		level.guy_b setgoalnode(getnode("ambush_2","targetname"));
		level.guy_b setgoalnode(getnode("jesse307","targetname"));
		level.guy_b waittill ("goal");
		level.guy_b thread blow_bazooka_guy();	
	}

// whitney and anderson
	if (isalive(level.blue[1]))
	{
//		println("^3 ********** runaway!!!! ", guy1.targetname, guy2.health);
		level.blue[1].goalradius = 40;
		level.blue[1] setgoalnode(getnode("retreat_point1","targetname"));
	}
	
	if (isalive(level.blue[2]))	// anderson
	{
//		println("^3 ********** runaway!!!! ", guy2.targetname, guy2.health);
		level.blue[2].goalradius = 40;
		level.blue[2] setgoalnode(getnode("retreat_point2","targetname"));	
	}
	
	level waittill ("tank dead");

	wait 6;
	
	if (isalive(guy1))
	{
		guy1.goalradius = 8;
		guy1 setgoalnode(getnode("end_other1","targetname"));
	}
	
	if (isalive(guy2))
	{
		guy2.goalradius = 8;
		guy2 setgoalnode(getnode("end_other2","targetname"));	
	}
}

blow_bazooka_guy()
{	
		level waittill("kill bazooka guy");
		origin = (self getorigin() );
	//	level.player maps\_mortar::incoming_sound();
		org = self.origin;
//		playSoundinSpace ("mortar_incoming", org);
		radiusDamage ( origin, 20, 20, 20);
//		radiusDamage ( origin, 400, 10000, 10000);
		playfx ( level.mortar, origin );
//		level.player maps\_mortar::mortar_sound();	
}

event7_tank_fire_think()
{
	node_firepoint1 = getnode("bazooka_blast1_post","targetname");
	firepoint1 = spawn("script_origin",node_firepoint1.origin);

	self setTurretTargetEnt(firepoint1, (0, 0, 20) );
//	wait 18;
	println("^ 3 tank is now firing but the allies are still running away early");
	self thread maps\_tiger_gmi::fire();
	println("^3 ********** tank fired:    event7_tank_fire_think ");
}

event7_rock_explosion_setup()	// I would like to write this in a more generic manner.... this is sloppy right now...
{
//	level endon (level.flags["tank_dead"] == "true");
	triggerclose = getent("triggerclose_rock", "targetname");
	triggerclose_dmg = getent("triggerclose_dmg", "targetname");

	triggermiddle = getent("triggermiddle_rock", "targetname");
	triggermiddle_dmg = getent("triggermiddle_dmg", "targetname");

	triggerfar = getent("triggerfar_rock", "targetname");
	triggerfar_dmg = getent("triggerfar_dmg", "targetname");
	// need a trigger for each rock.. 
	// then check if player is in area of rock


	triggerclose_dmg maps\_utility_gmi::triggerOff();	
	triggermiddle_dmg maps\_utility_gmi::triggerOff();
	triggerfar_dmg maps\_utility_gmi::triggerOff();


	triggerclose_dmg thread rocks_shell();	
	triggermiddle_dmg thread rocks_shell();
	triggerfar_dmg thread rocks_shell();


//	perfect_timing = getentarray("dmg_end_rocks","script_noteworthy");
//	for (i=0;i<perfect_timing.size;i++)
//	{
//		perfect_timing[i] maps\_utility_gmi::triggerOff();
//	}

	level waittill ("bazooka fired");


	while(1)
	{
		triggerclose_dmg maps\_utility_gmi::triggerOff();	
		triggermiddle_dmg maps\_utility_gmi::triggerOff();
		triggerfar_dmg maps\_utility_gmi::triggerOff();


		if(level.player istouching(triggerclose))
		{
			triggerclose_dmg maps\_utility_gmi::triggerOn();	
			println("^3 ********** in triggerclose this can explode now *********");
			wait 0.05;
		}

		if(level.player istouching(triggermiddle))
		{
			triggermiddle_dmg maps\_utility_gmi::triggerOn();
			println("^3 ********** in triggermiddle this can explode now *********");
			wait 0.05;
		}

		if(level.player istouching(triggerfar))
		{

			triggerfar_dmg maps\_utility_gmi::triggerOn();
			println("^3 ********** in triggerfar this can explode now *********");
			wait 0.05;
		}

		wait 0.3;
	}
	
//	wait 4;
	
//	for (i=0;i<perfect_timing.size;i++)
//	{
//		perfect_timing[i] maps\_utility_gmi::triggerOn();
//	}		
}

// start these for this event
rock_close()
{
	while(1)
	{
		if(level.player istouching(triggerclose))
		{
			triggerclose_dmg maps\_utility_gmi::triggerOn();	
			println("^3 ********** in triggerclose this can explode now *********");
			wait 0.05;
		}

//		if(!(level.player istouching(triggerclose)))
//		{
//			triggerclose_dmg maps\_utility_gmi::triggerOff();	
//			println("^3 ********** in triggerclose this can explode now *********");
//			wait 0.05;
//		}	
	}
}


rock_middle()
{
	while(1)
	{
		if(level.player istouching(triggermiddle))
		{
			triggermiddle_dmg maps\_utility_gmi::triggerOn();	
			println("^3 ********** in triggerclose this can explode now *********");
			wait 0.05;
		}	

//		if(!(1level.player istouching(triggermiddle)))
//		{
//			triggermiddle_dmg maps\_utility_gmi::triggerOn();	
//			println("^3 ********** in triggerclose this can explode now *********");
//			wait 0.05;
//		}	
	}
}

rock_far()
{
	while(1)
	{
		if(level.player istouching(triggerfar))
		{
			triggerfar_dmg maps\_utility_gmi::triggerOn();	
			println("^3 ********** in triggerclose this can explode now *********");
			wait 0.05;
		}	

//		if(!(level.player istouching(triggerfar)))
//		{
//			triggerfar_dmg maps\_utility_gmi::triggerOn();	
//			println("^3 ********** in triggerclose this can explode now *********");
//			wait 0.05;
//		}	
	}
}

rocks_shell()
{
	self endon("death");
	
	while(1)
	{
		// Talk to aleks I need triggers to use the same shit as the player -- detecting damage that is
//		self waittill("damage", ammount, attacker,dir, point, mod);
		if(level.player istouching(self))
		{
//			level.player thread DoShellShock(mod);
		}
		wait 0.05;
	}
}

event7_axis_control_normal()
{
	level waittill ("convoy begin");
	wait 3;
	
	axis = getaiarray("axis");
	allies = getaiarray("allies");
	
	for (i=0;i<axis.size;i++)
	{
		if(isalive(axis[i]))
		{
			axis[i].pacifist = true;
			axis[i].bravery = 50000;
			axis[i].maxsightdistsqrd = 0;
		}
	}
	
	for (i=0;i<allies.size;i++)
	{
		if(isalive(allies[i]))
		{
			allies[i].maxsightdistsqrd = 1000000;
			allies[i].accuracy = 0;
			allies[i] allowedstances("crouch");
		}
	}
	
	level waittill ("bazooka fired");
	
	for (i=0;i<axis.size;i++)
	{
		if(isalive(axis[i]))
		{
			axis[i].pacifist = false;
			axis[i].ignoreme = false;
		}
	}
	
	for (i=0;i<allies.size;i++)
	{
		if(isalive(allies[i]))
		{
			allies[i].ignoreme = false;
			allies[i].pacifist = false;
			allies[i] allowedstances("stand");
		}
	}
	
	wait 10;
	
	for (i=0;i<allies.size;i++)
	{
		if(isalive(allies[i]))
		{
			allies[i].accuracy = 35;
		}
	}
}

event7_axis_control_special()
{
	level waittill ("player fired early");
	ht1 = getent ("halftrack1","targetname");
	ht1 thread mg42_halftrack_on();
	
	axis = getaiarray("axis");
	
	for (i=0;i<axis.size;i++)
	{
		if(isalive(axis[i]))
		{
			axis[i].pacifist = false;
			//axis[i].bravery = 100;
		}
	}
	
	allies = getaiarray("allies");
	
	for (i=0;i<allies.size;i++)
	{
		if(isalive(allies[i]))
		{
			allies[i].ignoreme = false;
		}
	}
}

event7_player_fires_early()
{
	// if the player fires early then this event will be a lot tougher
	level endon("moody gives command");
	level waittill ("axis alerted");
	while (1)
	{
		if(level.player attackButtonPressed())
		{	
				axis = getaiarray("axis");			
				for (i=0;i<axis.size;i++)
				{
					if(isalive(axis[i]))
					{
						axis[i].accuracy = 0.6;
						axis[i].health = 170;
					}
					wait 0.05;
				}


			level notify ("player fired early");
			break;
		}
		wait 0.05;
	}
//	iprintlnbold(&"GMI_BASTOGNE2_TEMP_FIRE_EARLY");
}

#using_animtree("generic_human");
event7_moody_hitdirt()
{
	getent ("convoy_start","targetname") waittill ("trigger");
	wait 3;
	level.scr_anim["moody"]["moody_hit_dirt"]		= (%c_us_bastogne2_moody_hit_dirt);
	
	level.scr_notetrack["moody"][0]["notetrack"]		= "moody_hit_dirt";
	level.scr_notetrack["moody"][0]["dialogue"]		= "moody_hit_dirt";
	level.scr_notetrack["koppel"][0]["facial"]		= (%f_bastogne2_moody_hit_dirt);	
	level.moody thread anim_single_solo(level.moody,"moody_hit_dirt");
}

event7_stand_backup()
{
	while (level.flags["tank_dead"] == false)
	{
		wait 0.25;
	}
	
	axis = getaiarray("axis");
	allies = getaiarray("allies");
	
	for (i=0;i<allies.size;i++)
	{
		if(isalive(allies[i]))
		{
			allies[i] allowedstances("stand");
			allies[i].suppressionwait = 0;
			allies[i].goalradius = 64;
			allies[i].pacifist = false;
			allies[i].maxsightdistsqrd = 1000000;
			allies[i].accuracy = 0.1;
		}
	}
	
	for (i=0;i<axis.size;i++)
	{
		if(isalive(axis[i]))
		{
			axis[i].ignoreme = false;
			axis[i].maxsightdistsqrd = 1000000;
		}
	}
	
	if (level.flags["tank_support_dead"] == false)
	{
		node1 = getnode("offensive_1","targetname");
		node2 = getnode("offensive_2","targetname");
		node3 = getnode("offensive_3","targetname");
		
		level.blue[0] setgoalnode (node3);
		level.blue[1] setgoalnode (node1);
		level.blue[2] setgoalnode (node2);
	}
}


//======================================
//
//PLease add more cowbell to this event.
//
//======================================
event7_allied_tank()
{
	level waittill ("tank dead");

	wait 7;
	
	
	level.blue[0] setgoalnode(getnode("end_blue1","targetname"));
	level.blue[1] setgoalnode(getnode("end_blue2","targetname"));
	level.blue[2] setgoalnode(getnode("end_blue3","targetname"));
	
	level.blue[0].goalradius = 8;
	level.blue[1].goalradius = 8;
	level.blue[2].goalradius = 8;
	
	if (isalive(level.red[0]))
	{
		level.red[0] setgoalnode(getnode("end_red1","targetname"));
	}
	
	if (isalive(level.red[1]))
	{
		level.red[1] setgoalnode(getnode("end_red2","targetname"));
	}
	
	sherman1 = spawnVehicle("xmodel/v_us_lnd_sherman_snow", "vclogger", "ShermanTank" ,(0,0,0), (0,0,0) );
	sherman1 thread maps\_sherman_gmi::init();
	sherman1 thread maps\_tankgun_gmi::mgoff(); // Turn OFF MG.
	path = getVehicleNode ("allied_tank","targetname");
	sherman1 attachpath(path);
	sherman1.isalive = 1;
	sherman1.health = (1000000);
	sherman1 startpath();
//	sherman1 thread cowbell_turrets();
	sherman1 setspeed(3,3);

	level thread event7_allied_tank_support();
	
	foley = getent("foley_end","targetname") stalingradspawn();
	foley waittill ("finished spawning");

	foley character\_utility::new();
	foley character\foley_winter::main();

	foley.name = "Cpt. Foley"; 
	foley.animname = "foley";
	foley.dontavoidplayer = true;
	
	tanker = getent("tanker","targetname") stalingradspawn();
	tanker waittill ("finished spawning");
	tanker.name = "Cpt. Tanker"; 
	tanker.animname = "tanker";
	tanker.dontavoidplayer = true;
	
	level.blue[0] waittill ("goal");
	
	allies = getaiarray("allies");
	
	for (i=0;i<allies.size;i++)
	{
		if(isalive(allies[i]))
		{
			allies[i] allowedstances("crouch");
		}
	}

	while(1)
	{
		if (distance (level.player getorigin(), tanker.origin) < 300)	
//		if (distance (level.player getorigin(), level.blue[0].origin) < 600)	
		{

			ent = spawn("script_origin", level.player.origin);
				
			//level.player linkTo(ent);
			// also need to send out command from here that blocks player in house...
			// level thread block_player_in_house;
			break;								
		}
		wait 0.05;
	}


	level notify("objective_14_complete");
//	sherman1 freeVehicle();
	
	tanker thread anim_single_solo(tanker,"tanker_nicework");
	wait 5;
	foley thread anim_single_solo(foley,"foley_digin");
	wait 6;
	level.moody thread anim_single_solo(level.moody,"moody_letsgo");
	wait 3;
	level notify("level win");
}

event7_allied_tank_support()// add four more tanks with guys walking and guys on top of tanks...
{
	sherman2 = spawnVehicle("xmodel/v_us_lnd_sherman_snow", "vclogger2", "ShermanTank" ,(0,0,0), (0,0,0) );
	sherman2 thread maps\_sherman_gmi::init();
	sherman2 thread maps\_tankgun_gmi::mgoff(); // Turn OFF MG.
	path = getVehicleNode ("allied_tank2","targetname");
	sherman2 attachpath(path);
	sherman2.isalive = 1;
	sherman2.health = (1000000);
	sherman2 startpath();
//	sherman2 thread cowbell_turrets();
	sherman2 setspeed(0.1,0.1);

	sherman3 = spawnVehicle("xmodel/v_us_lnd_sherman_snow", "vclogger3", "ShermanTank" ,(0,0,0), (0,0,0) );
	sherman3 thread maps\_sherman_gmi::init();
	sherman3 thread maps\_tankgun_gmi::mgoff(); // Turn OFF MG.
	path = getVehicleNode ("allied_tank3","targetname");
	sherman3 attachpath(path);
	sherman3.isalive = 1;
	sherman3.health = (1000000);
	sherman3 startpath();
//	sherman3 thread cowbell_turrets();
	sherman3 setspeed(0.1,0.1);

	sherman4 = spawnVehicle("xmodel/v_us_lnd_sherman_snow", "vclogger3", "ShermanTank" ,(0,0,0), (0,0,0) );
	sherman4 thread maps\_sherman_gmi::init();
	sherman4 thread maps\_tankgun_gmi::mgoff(); // Turn OFF MG.
	path = getVehicleNode ("allied_tank4","targetname");
	sherman4 attachpath(path);
	sherman4.isalive = 1;
	sherman4.health = (1000000);
	sherman4 startpath();
//	sherman4 thread cowbell_turrets();
	sherman4 setspeed(0.1,0.1);

//	wait 10;
//	sherman2 freeVehicle();
//	sherman3 freeVehicle();
//	sherman4 freeVehicle();
}


cowbell_turrets() // random turret look
{
//	level waittill ("tank dead");
	while(1)
	{
			target_pos[0] = (14332, 8291, 500);
			target_pos[1] = (17308, 8499, 0);
			target_pos[2] = (18706, 4757, -300);
			target_pos[3] = (11998, 6233, 240);

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
				fired = true;
			}
			wait 0.25;
		}

//		wait 5;
		wait (1 + randomfloat(2));
	}
}

event7_last_squad_setup()	// guys near truck
{
	level waittill ("tank dead");
	wait 4;
	allies_group = getentarray("last_squad1", "groupname");

	for(i=0;i<(allies_group.size);i++)//		
	{
//		allies2_array[i] = getent("beg_squad2_" + i, "targetname");
		allies2_array_ai[i] = allies_group[i] stalingradspawn();
		allies2_array_ai[i] waittill ("finished spawning");
		allies2_array_ai[i].pacifist = true;
		allies2_array_ai[i].accuracy = 0;
		allies2_array_ai[i] allowedstances("stand");
		allies2_array_ai[i] thread walkies();
		allies2_array_ai[i] thread e2_node(i);
	}
}

e2_node(i)
{
	if(isalive(self))
	{	
		wait (0.2 + randomfloat (0.9));		
		node = getnode("event6_cross_runaway", "targetname");
		self setgoalnode(node);
		self waittill("goal");


//		wait (0.2 + randomfloat (0.9));		
//		node = getnode("event6_squad2_guy_node_" + i, "targetname");
//		self setgoalnode(node);
//		self waittill("goal");
//		self.pacifist = false;
//
//
//		wait (3.3 + randomfloat (7.3));
//	//	level waittill ("beg_sqauds_move_up");
//
//		node = getnode("event1_squad2_guy_node2_delete", "targetname");
//		self setgoalnode(node);
//		self waittill("goal");
	}

	if(isalive(self))
	{
		wait 15;
		self delete();
	}
}

walkies()
{
	self allowedstances("stand");
	self.pacifist = 1;
	self.goalradius = 0;
	self.walkdist = 9999;
	patrolwalk[0] = %patrolwalk_bounce;
	patrolwalk[1] = %patrolwalk_tired;
	patrolwalk[2] = %patrolwalk_swagger;
	//self.walk_noncombatanim_old = self.walk_noncombatanim;
	//self.walk_noncombatanim2_old = self.walk_noncombatanim2;
	self.walk_noncombatanim = maps\_utility_gmi::random(patrolwalk);
	self.walk_noncombatanim2 = maps\_utility_gmi::random(patrolwalk);
	//self animscriptedloop("scripted_animdone", self.origin, self.angles, self.walk_noncombatanim);
}

event7_support() //
{
	level waittill ("bazooka fired"); 

	println("^6 *************** hill support guys coming in now ******************");
	event7_amb = "event7_amb";
	ender_z = "end_zeta";
	time_z = 0.5;
	min_z = 4;
	max_z = 4;

	level thread maps\_squad_manager::manage_spawners(event7_amb,min_z,max_z,ender_z,time_z,::event7_amb_init);
}

event7_amb_init()
{	
}

event7_tank_hit_once_support() 
{
	level waittill ("engage_event7_tank_hit_once_support"); 


	event7_tank_support3 = "event7_tank_support3";
	ender_w = "end_weta";
	time_w = 5.3;
	min_w = 3;
	max_w = 3;


	if (level.flags["tank_dead"] == false )
	{
		println("^6 *************** last tank support guys coming now!!! ******************");
		println("^6 *************** last tank support guys coming now!!! ******************");
		println("^6 *************** last tank support guys coming now!!! ******************");
		println("^6 *************** last tank support guys coming now!!! ******************");
		println("^6 *************** last tank support guys coming now!!! ******************");
		level thread maps\_squad_manager::manage_spawners(event7_tank_support3,min_w,max_w,ender_w,time_w,::event7_tank_support3_init);
	}

	while(level.flags["tank_dead"] == false )
	{
		wait 0.05;
	}

	level notify ("event7_tank_support3"); // stop these guys once the tank is dead...
}


event7_tank_support3_init()
{
	wait 2.4;	
}

anim_single_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
 	maps\_anim_gmi::anim_single (newguy, anime, tag, node, tag_entity);
}

level_end()
{
	level waittill("level win");
	missionSuccess("foy", true);
}

event7_player_ignore()
{
	level.player.ignoreme = true;
	level waittill ("bazooka fired");
	level.player.ignoreme = false;
}

//==========================================================================
// jeremy added 05/27/05
// MAke voices heard in field as germans yell to each other
//==========================================================================event7_
event7_german_yells(angle1)
{
	level endon("stop_spooky_german_sounds");
//	angle1 = (1615,15760,161);

	german_yell_1 = spawn("script_origin",(angle1));
	german_yell_2 = spawn("script_origin",(angle1));
	german_yell_3 = spawn("script_origin",(angle1));

	for(i=0;i<20;i++)
	{
		wait (0.1 + randomfloat (0.4));	
		println("^3 ***************  german yells"        + i);
		german_yell_1 playsound("generic_misccombat_german_1");
		wait 2;
		german_yell_2 playsound("generic_misccombat_german_2");
		wait 2;
		german_yell_3 playsound("generic_flankright_german_2");
	}
}

axis_do_damage()
{
		ai = getaiarray ("axis");
		for (i=0;i<ai.size;i++)
		{
			wait (0.1 + randomfloat (1.3));	 
			if(isalive(ai[i]))
			{
				ai[i] DoDamage ( ai[i].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );	
			}
		}
}

//==============================
//
//This makes the base go BOOM!@
//
//===========================
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

init_player_dmg()
{
		println("^2 ************** init_player_dmg waiting");

		while(1)
		{

			level.player waittill ("damage",ammount,attacker,dir, point, mod);
	
	//		level.player waittill ("damage");
	
	
			println("^2 ************** init_player_dmg has been taken start shell");
			
			level.player thread DoShellShock(mod);

			wait .1;
		}
}

// ----------------------------------------------------------------------------------
//	DoShellShock
//
// 	Shell shock effect for nades and 
//	ets in GMI multiplayer
// ----------------------------------------------------------------------------------
DoShellShock(sMeansOfDeath)
{
	// should this scr_shellshock be converted to a level variable like friendly fire was?
	//if(getCvar("scr_shellshock") == 1)
	//{		
		// if this is and explosion but not from a weapon (artillery or whatever) then do the shellshock
		if (   sMeansOfDeath == "MOD_GRENADE_SPLASH" 
		    || sMeansOfDeath == "MOD_EXPLOSIVE" 
		    || sMeansOfDeath == "MOD_PROJECTILE" || sMeansOfDeath == "MOD_PROJECTILE_SPLASH" 
		    || sMeansOfDeath == "MOD_ARTILLERY" || sMeansOfDeath == "MOD_ARTILLERY_SPLASH" )
		{
			self thread shell_shock();
		}
//	}
}

shell_shock()
{
	println("^6 *********** THreat bias is up part 3, player more then 1300 away from moody *********");
	origin = (level.player getorigin() );
//				level.player maps\_mortar::incoming_sound();
	org = level.player.origin;
//	playSoundinSpace ("mortar_incoming", org);
//	radiusDamage ( origin, 400, 10000, 10000);
//	playfx ( level.mortar, origin );
//	level.player maps\_mortar::mortar_sound();
	earthquake(0.15, 2, origin, 850);
	wait 0.05;


		if(isalive(level.player))
		 {
		 	level.player allowStand(false); 
			level.player allowCrouch(false); 
			level.player allowProne(true);
			
			wait 0.15;
			level.player viewkick(63, level.player.origin);  //Amount should be in the range 0-127, and is normalized "damage".  No damage is done.
			level.player shellshock("default_nomusic", 3);
			
			wait 1.5;
			
			level.player allowStand(true);
			level.player allowCrouch(true);
		}
}