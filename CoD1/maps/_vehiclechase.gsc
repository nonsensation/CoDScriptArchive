#using_animtree ("generic_human");
main()
{

	if (getcvar("debug_vclogin") == "")
		setcvar("debug_vclogin", "off");
	if (getcvar("debug_vcloginplanes") == "")
		setcvar("debug_vcloginplanes", "off");
	if (getcvar("debug_crashpaths") == "")
		setcvar("debug_crashpaths", "off");
	if (getcvar("debug_vehiclespeed") == "")
		setcvar("debug_vehiclespeed", "off");
	if (getcvar("debug_vehicleenemiesoff") == "")
		setcvar("debug_vehicleenemiesoff", "off");
	if (getcvar("debug_playeroutofsighthack") == "")
		setcvar("debug_playeroutofsighthack", "off");

	level.debugvclogin = 0;

	if (getcvar("debug_vclogin") != "off")
		vclogin();


	debugvehicles = getcvar("debug_vehicleenemiesoff");
	thread setupbuddyjumpers();
	thread trigger_setup_vehiclegroupspawn();
	thread trigger_setup_vehiclegrouprunto();
	thread trigger_setup_vehiclemovers();
	thread trigger_setup_vehicledoorcloser();
	thread trigger_setup_vehiclegroupdelete();
	thread trigger_setup_vehiclefiretriggers();
	thread trigger_setup_vehiclegrouploweracc();
	thread trigger_setup_vehiclegroupraiseacc();
	thread trigger_setup_vehiclegroupblowmeup();

	pswitchtrigs = getentarray("playerPswitch","targetname");

	vehicles = getentarray("script_vehicle", "classname");
	for(i=0;i<vehicles.size;i++)
	{
		/// renames script_team  to one thing..
		if(isdefined (vehicles[i].script_team))
		{
			if(vehicles[i].script_team == "friendly")
			{
				vehicles[i].script_team = "allies";
			}
			else if(vehicles[i].script_team == "enemy")
			{
				vehicles[i].script_team = "axis";
			}
		}
		///////////////
		/// sets player vehicle up in strange ways.. I don't know what I was thinking when I did this stuff..
		///////////////

		if(isdefined(vehicles[i].script_team) && vehicles[i].script_team == "allies" && debugvehicles == "off")
		{
			vehicles[i] thread setup_player_vehicle(pswitchtrigs);
			if(vehicles[i].vehicletype == "GermanFordTruck")
			{
				vehicles[i] maps\_truck::init();
				vehicles[i] thread maps\_truck::handle_attached_guys();
			}
		}

		///////////////
	}


	spawntrigs = getentarray("tgroupspawn","targetname");
	for(i=0;i<spawntrigs.size;i++)
	{
		targ = getent(spawntrigs[i].target,"targetname");
		if(isdefined(targ))
		{
			maps\_vehiclespawn::spawner_setup(targ);
		}

	}

/*


//	evspawncount = 0;

	for(i=0;i<vehicles.size;i++)
	{

		if(isdefined (vehicles[i].script_team))
		{
			if(vehicles[i].script_team == "friendly")
			{
				vehicles[i].script_team = "allies";
			}
			else if(vehicles[i].script_team == "enemy")
			{
				vehicles[i].script_team = "axis";
			}
		}
		if(isdefined (vehicles[i].targetname))
		{
			if(isdefined(vehicles[i].script_team) && vehicles[i].script_team == "axis" && debugvehicles == "off")
			{
				maps\_vehiclespawn::spawner_setup(vehicles[i]);
			}
			else
			if(isdefined(vehicles[i].script_team) && vehicles[i].script_team == "allies" && debugvehicles == "off")
			{

				vehicles[i] thread setup_player_vehicle(pswitchtrigs);
				if(vehicles[i].vehicletype == "GermanFordTruck")
				{
					vehicles[i] maps\_truck::init();
					vehicles[i] thread maps\_truck::handle_attached_guys();
				}
				if(vehicles[i].vehicletype == "kubelwagon")
				{
					vehicles[i] maps\_kubelwagon::init();
					vehicles[i] thread maps\_kubelwagon::handle_attached_guys();
				}
			}
		}
	}
	*/
}

trigger_path_switch(playervehicle)
{

	targ = getvehiclenode(self.target,"targetname");
	if(!isdefined(targ))
	{
		println("no vehicle node for path switch trigger at ", self.targetname);
		return;
	}
	self waittill ("trigger",vehicle);

	waitnode = find_last_node(playervehicle.attachedpath);
	playervehicle setswitchnode(waitnode,targ);

	playervehicle.attachedpath = targ;
	playervehicle player_vehicle_paths();

}



find_last_node(path)
{
	pathspot = path;
	while(isdefined(pathspot))
	{
		thenode = pathspot;
		pathspot = path_next_inloop(pathspot);

	}
	return thenode;
}

path_next_inloop(pathspot)
{
	if(isdefined(pathspot.target))
	{
		pathspot = getvehiclenode(pathspot.target, "targetname");
		return pathspot;
	}
	else
		return undefined;

}


setup_player_vehicle(pswitchtrigs)
{
	for(j=0;j<pswitchtrigs.size;j++)
		pswitchtrigs[j] thread trigger_path_switch(self);
	getonpath();
	thread player_vehicle_paths();
	thread waitforgo();

}


trigger_setup_vehiclemovers()
{
	triggers  = getentarray("moveenemy","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_vehiclemovers();
}



trigger_setup_vehiclegrouprunto()
{
	triggers  = getentarray("tgrouprunto","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_vehiclerunto();
}






trigger_setup_vehiclegroupdelete()
{
	triggers  = getentarray("tgroupdelete","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_vehiclegroupdelete();
}

trigger_vehiclegroupdelete()
{
	self waittill ("trigger");
	if(!isdefined(self.target))
		println("no target on trigger at ",self.origin);
	vehicle = getent(self.target,"targetname");
	if(isdefined(vehicle))
		vehicle thread delete_group();


}

delete_group()
{

	ai = getaiarray("axis");
	if(!isdefined(self.script_vehiclegroup))
	{
		println("no vehicle group on me here ", self.origin);
		return;
	}
	for(j=0;j<ai.size;j++)
	{
		if(isdefined(ai[j].script_vehiclegroup) && ai[j].script_vehiclegroup == self.script_vehiclegroup)
		{
			ai[j] delete();
		}
	}
	if(isdefined(self.spawnedtokillyouguy))
	{
		 self.spawnedtokillyouguy delete();
	}
	self delete();
}


trigger_setup_vehiclegroupspawn()
{
	triggers  = getentarray("tgroupspawn","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_vehiclegroupspawn();
}

trigger_vehiclegroupspawn()
{
	self waittill ("trigger");
	if(!isdefined(self.target))
		println("no target on trigger at ",self.origin);
	spawnvehiclegroup(self.target);

}

spawnvehiclegroup(vehicletargetname)
{
	vehicle = maps\_vehiclespawn::vehicle_spawn(vehicletargetname);
	vehicle.ismoving = 0;
	vehicle getonpath();
	waitframe();
	vehicle thread spawn_group();
	return vehicle;
}

spam()
{
	println("*****_vehiclechase******");
}

trigger_vehiclemovers()
{
	self waittill ("trigger");
	vehicle = getent(self.target,"targetname");
	if(isdefined(vehicle))
		vehicle thread enemy_chaser();
}


trigger_vehiclerunto()
{
	self waittill ("trigger");
	node = getnode(self.target,"targetname");
	thread enemy_grouprunto(node);
}

enemy_grouprunto(node)
{
	if(!isdefined(self.script_vehiclegroup))
	{
		println("no vehicle group on me here ", self getorigin());
		return;
	}
	ai = getaiarray("axis");

	for(j=0;j<ai.size;j++)
	{
		if(isdefined(ai[j].script_vehiclegroup) && ai[j].script_vehiclegroup == self.script_vehiclegroup)
		{
			ai[j] setgoalnode (node);
			ai[j].goalradius = 512;
		}
	}
}

enemy_chaser()
{
//	thread debug_vehiclespeed();
	thread enemy_vehicle_paths();
	if(isdefined(self.script_delay))
	{
		wait self.script_delay;
	}
	thread gopath();
}


spawn_group()
{
	if(!isdefined(self.script_vehiclegroup))
	{
		println("no vehicle group on me here ", self.origin);
		return;
	}
	spawners = getspawnerteamarray("axis");
	for(j=0;j<spawners.size;j++)
	{
		if(isdefined(spawners[j].script_vehiclegroup) && spawners[j].script_vehiclegroup == self.script_vehiclegroup)
		{
			spawners[j].script_moveoverride = 1; //keeps _spawner.gsc from setting a goalradius
			spawnerguy = spawners[j] dospawn();
			if(isdefined (spawnerguy))
			{
				spawnerguy allowedstances ("stand");
				thread spawned_think(spawnerguy);
				waitframe();// so that when guys are added they don't all notify the truck at the same time, assures that everybody is delt with in orderly fashtion =).
			}
			else
			{
				println("spawner failed at ",spawners[j].origin);
			}
		}
	}
}

waitframe()
{
	maps\_spawner::waitframe();
}

driver()
{
	truck = find_nearest_player_vehicle(self);
	org = truck gettagOrigin ("tag_driver");
	angles = truck gettagAngles ("tag_driver");
	self teleport(getstartorigin(org, angles, %germantruck_driver_drive_loop), getstartangles(org, angles, %germantruck_driver_drive_loop));
	self linkto(truck, "tag_driver");
	while (1)
	{

		org = truck gettagOrigin ("tag_driver");
		angles = truck gettagAngles ("tag_driver");
		self animscripted("driveranimdone", org, angles, %germantruck_driver_drive_loop);
		self waittillmatch ("driveranimdone","end");
	}
}

buddy()
{
	self allowedStances ("stand");
	truck = find_nearest_player_vehicle(self);
	tag = ("tag_guy07");
	org = truck gettagorigin(tag);
	angles = truck gettagAngles(tag);
	self teleport(org,angles);

//	self animscripted("movetospot", org, angles, %stand_alert_1);
//	self waittillmatch ("movetospot","end");
	self linkto (truck, tag,(0,0,0),(0,0,0));
}

regenwhilestopped()
{
	health = self.health;
	while(self.ismoving == 0)
	{
		self waittill( "damage", amount );
		if(self.ismoving == 0)
			self.health = health;
	}
}

setupbuddyjumpers()
{
	ai = getspawnerteamarray("axis");
	for(i=0;i<ai.size;i++)
	{
		if(isdefined (ai[i].targetname))
		{
			for(j=0;j<ai.size;j++)
			{
				if(isdefined (ai[j].target))
				{
					if(ai[j].target == ai[i].targetname)
						ai[i].buddyjump = ai[j];
				}
			}
		}
	}
}



waitforgo()
{
	self waittill ("start_playervehiclepath");
	self thread gopath();
}

start()
{
	self notify ("start_playervehiclepath");
}


/*
debug_vehiclespeed()
{
	if (getcvar("debug_vehiclespeed") != "off")
	{
		while(1)
		{
			print3d (self.origin + (0,0,128), self.speed, (1, 1, 1), 1);
			maps\_spawner::waitframe();
		}
	}
}


debug_vehiclespeed_nodes()
{
	if (getcvar("debug_vehiclespeed") == "off")
		return;
	if(!isdefined (self.speed))
		return;
	while(1)
	{
		print3d (self.origin + (0,0,128), self.speed, (1, 1, 0), 1);
		maps\_spawner::waitframe();
	}
}
*/

spawned_think(guy)
{
	// "script_noteworthy" "startinvehicle" - guys to teleport to inside the vehicle, first guy is driver
	// "script_delay" - time to wait for two guys to jump into the back of the vehicle
	if(isdefined (guy.script_noteworthy))
	{
		if(guy.script_noteworthy == "startinvehicle")
			thread startinvehicle(guy);
	}
	else if(isdefined (guy.buddyjump))
		thread buddyjump(guy);
	else
		thread runtovehicle(guy);
	guy thread deathremove();
}

deathremove()
{
	self waittill ("death");
	wait 2;
	self delete();
}

startinvehicle(guy)
{
	self notify ("guyenters", guy);
}

buddyjump(guy)
{

	buddy = guy.buddyjump dospawn();
	buddy allowedstances ("stand");
	buddy.animatein = 1;
	guy.animatein = 1;
	buddyanim1 = %germantruck_guyA_climbin;
	buddyanim2 = %germantruck_guyB_climbin;

	climbinnode = "tag_climbnode";
	climborg = self gettagorigin(climbinnode);
	climbang = self gettagangles(climbinnode);

	org1 = getStartOrigin (climborg, climbang, buddyanim1);
	angles1 = getStartAngles (climborg, climbang, buddyanim1);
	org2 = getStartOrigin (climborg, climbang, buddyanim2);
	angles2 = getStartAngles (climborg, climbang, buddyanim2);

	if(isdefined (guy.script_delay))
		wait guy.script_delay;

	guy teleport (org1);
	buddy teleport (org2);
	guy linkto(self);
	buddy linkto(self);
	self thread animontagandgetin(guy, climbinnode , buddyanim1);
	self thread animontagandgetin(buddy, climbinnode , buddyanim2);

}
animwaitnotify(vehicle)
{
	self waittillmatch ("jumpin","end");
	vehicle notify ("buddydone");
}
animontagandgetin(guy, tag , animation)
{
	guy endon ("death");
	org = self gettagOrigin (tag);
	angles = self gettagAngles (tag);
	guy animscripted("animontagdone", org, angles, animation);
	if(isdefined(guy.deathanim))
		guy.allowdeath = 1;
	guy waittillmatch ("animontagdone","end");
	self notify ("guyenters", guy);
}

runtovehicle(guy)
{
	guy.animatein = 1;

	climbinnode = self.climbnode; //"tag_climbnode"
	climbinanim = self.climbanim;
	closenode = climbinnode[0];
	currentdist = 5000;
	for(i=0;i<climbinnode.size;i++)
	{
		climborg = self gettagorigin(climbinnode[i]);
		climbang = self gettagangles(climbinnode[i]);
		org = getstartorigin (climborg, climbang, climbinanim[i]);
		distance = distance(guy.origin, climborg);
		if(distance < currentdist)
		{
			currentdist = distance;
			closenode = climbinnode[i];
			thenode = i;
		}

	}

	climborg = self gettagorigin(climbinnode[thenode]);
	climbang = self gettagangles(climbinnode[thenode]);
	org = getStartOrigin (climborg, climbang, climbinanim[thenode]);
//	guy thread drawme();

	guy maps\_utility::cant_shoot();

	guy setgoalpos (org);
	guy.goalradius = 16;
	guy waittill ("goal");
	guy maps\_utility::cant_shoot();

	if(self.ismoving != 1)
	{
		guy linkto (self);
		guy animscripted("hopinend", climborg,climbang, climbinanim[thenode]);
		guy waittillmatch ("hopinend", "end");
		self notify ("guyenters", guy);
	}
}
drawme()
{
	while(isalive (self))
	{
		print3d (self.origin + (0,0,64), ("ME"), (1, 1, 1), 1);
		print3d (self.origin + (0,0,32), (self.goalradius), (1, 1, 1), 1);
		self.goalradius = 4;

		maps\_spawner::waitframe();
	}
}

find_nearest_player_vehicle(guy)
{
	vehicles = getentarray("player_vehicle","targetname");
	distance = 8192;
	for(i=0;i<vehicles.size;i++)
	{
		newdistance = distance(vehicles[i].origin,guy.origin);
		if(newdistance < distance)
		{
			theone = vehicles[i];
			distance = newdistance;
		}
	}
	return theone;
}


enemy_vehicle_paths()
{
	self thread skidder();  // applies skidding sound when pathnode has "script_noteworthy" "skidon"
	pathstart = self.attachedpath;
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
//			pathpoint thread debug_vehiclespeed_nodes();
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
//				self thread draw_crash_path();
				self waittill ("reached_wait_node");

				waited = true;  //do multiple things on one node
				if(isdefined(self.deaddriver) || self.health <= 0 || (isdefined(switchnode.script_noteworthy) && switchnode.script_noteworthy == "forcedcrash") || (level.debugvclogin))  //script_noteworthy was for forced crash path I think
				{

					if((!isdefined (switchnode.derailed)) || (isdefined(switchnode.script_noteworthy) && switchnode.script_noteworthy == "planecrash"))
					{
						self notify ("crashpath");
						switchnode.derailed = 1;
						self setSwitchNode (pathpoints[i],switchnode);
					}
				}
			}
		}
		if(isdefined(pathpoints[i].script_noteworthy))
		{
			if(!(waited))
			{
				self setWaitNode(pathpoints[i]);
				self waittill ("reached_wait_node");
			}
			if (pathpoints[i].script_noteworthy == "flighton")
			{
				self notify ("takeoff");
				self.inflight = 1;
			}
			else
			if (pathpoints[i].script_noteworthy == "flightoff")
			{
				self.inflight = 0;
			}
			else
			if (pathpoints[i].script_noteworthy == "wheelsup")
			{
				self notify ("wheelsup");
			}
			else
			if (pathpoints[i].script_noteworthy == "skidon")
			{
				self notify ("skidon");
			}
			else
			if (pathpoints[i].script_noteworthy == "skidoff")
			{
				self notify ("skidoff");
			}
			else
			if (pathpoints[i].script_noteworthy == "start_firing")
			{
				self thread maps\_stuka::shoot_guns();
			}
			else
			if (pathpoints[i].script_noteworthy == "stop_firing")
			{
				self notify ("stop mg42s");
				self thread maps\_stuka::turret_kill();
			}
			else
			if (pathpoints[i].script_noteworthy == "dropthebomb")
			{
				if(self.health > 0)
					level notify("dropthebomb");
			}
		}
		waited = false;
	}
}

skidderon()
{
	self endon ("skidoff");
	self waittill ("skidon");
	while(1)
	{
		self playsound("Dirt_skid","skidsound",true);
		self waittill ("skidsound");
	}

}
skidder()
{
	while(1)
	{
		self waittill ("skidon");
		self notify ("skidoff");
		thread skidderon();
	}
}

/*
draw_crash_path()
{
	if(getcvar("debug_crashpaths") == "off")
		return;
	path = self.crashing_path;
	drawpath = path;
	arraycount = 0;
	while (isdefined (drawpath))
	{
		drawpaths[arraycount] = drawpath;
		if(isdefined (drawpath.target))
		{
			drawpath = getvehiclenode(drawpath.target, "targetname");
			arraycount++;
		}
		else
			break;
	}
	drawpath = path;
	while (self.crashing_path == path)
	{
		line (self.origin, path.origin, (0, 1, 0), 0.5);
		print3d (path.origin + (0,0,64), path.targetname, (1, 1, 1), 1);
		print3d (path.origin + (0,0,50), "targeting", (1, 1, 1), 1);
		print3d (path.origin + (0,0,36), path.target, (1, 1, 1), 1);
		for(i=0;i<drawpaths.size;i++)
		{
			if(isdefined (drawpaths[i+1]))
				line (drawpaths[i].origin, drawpaths[i+1].origin, (1, 0, 0), 0.5);
		}
		maps\_spawner::waitframe();
	}
}
*/

getonpath()
{
	if(self.targetname == ("player_vehicle"))
	{
		startcvar = getcvar("start");
		if(startcvar != "start")
		{
			theone = get_start_node(startcvar);
			if(!isdefined(theone))
				theone = latch_to_nearestpath(self);
		}
		else
		{
			theone = latch_to_nearestpath(self);
		}

	}
	else
	{
		theone = latch_to_nearestpath(self);
	}

	self.attachedpath = theone;
	self.origin = theone.origin;
	self attachpath (theone);
	self disconnectpaths();
}

get_start_node(str)
{
	switchtrigs = getentarray ("playerPswitch","targetname");
	for(i=0;i<switchtrigs.size;i++)
	{
		if(isdefined(switchtrigs[i].script_uniquename) && switchtrigs[i].script_uniquename == str)
		{
			if(isdefined(switchtrigs[i].target))
			{
				target = getvehiclenode(switchtrigs[i].target,"targetname");
				if(isdefined(target))
				{
					return target;
				}
				else
				{
					println("target on switchtrigger at " + switchtrigs[i].origin + " doesn't exist");
					return undefined;
				}
			}
		}
	}
}

gopath()
{

	if(!(self.health > 0))
		return;
	if(self.targetname != "player_vehicle")
	{
		driver = self.driver;
		if(isdefined (driver))
		{
//			driver.idling = 0;
			if(isdefined (self.script_noteworthy) && self.script_noteworthy == "driverdelay")
				driver waittill ("gotime");
		}
	}
	self.ismoving = 1;
	self startpath();
	self waittill ("reached_end_node");
	self notify ("unload");
	self setspeed(0,200);
	self joltbody((self.origin + (0,0,64)),.5);
	self disconnectpaths();
}


latch_to_nearestpath(vehicle)
{
	vehiclepaths = getvehiclenodearray("vehicle_path", "targetname");
	distance = 1024;
	for(i=0;i<vehiclepaths.size;i++)
	{
		newdistance = distance(vehicle.origin,vehiclepaths[i].origin);
		if(newdistance < distance)
		{
			theone = vehiclepaths[i];
			distance = newdistance;
		}
	}
	if(!isdefined (theone))
	{
		println ("vehicle is not close enough to path, or sometihgn at origin : ", vehicle.origin);
	}
	return theone;
}

vclogin()
{

	level.debugvclogin = 1;
	paths = getvehiclenodearray("crash_path","targetname");
	for(i=0;i<paths.size;i++)
	{
		vehicle = spawnVehicle( "xmodel/vehicle_german_truck_truckride", "vclogger", "GermanFordTruck" ,(0,0,0), (0,0,0) );
		vehicle attachpath(paths[i]);
		tagorg = vehicle gettagorigin("tag_player");
		level.player setorigin (tagorg);
		level.player playerlinkto (vehicle, "tag_player", ( 0.1, .6, 0.9 ));
		vehicle startpath();
		vehicle setspeed (100,50);
		vehicle waittill ("reached_end_node");
		level.player unlink();
		vehicle delete();

	}

}


trigger_setup_vehicledoorcloser()
{
	triggers = getentarray("enemyclosedoor","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread trigger_vehicledoorcloser_wait();
	}
}

trigger_vehicledoorcloser_wait()
{
	vehicle = getent(self.target,"targetname");
	vehicle.drivertriggered = 1;
	self waittill ("trigger");
	vehiclespawned = getent(self.target,"targetname");
	vehiclespawned notify ("driverclosedoor");

}

trigger_setup_vehiclefiretriggers()
{
	kubelfiretriggers = getentarray("tgroupfire","targetname");
	for(i=0;i<kubelfiretriggers.size;i++)
	{
		kubelfiretriggers[i] thread trigger_vehiclefiretriggers_wait();
	}
}

trigger_vehiclefiretriggers_wait()
{

	while(1)
	{
		self waittill ("trigger",other);
		if(isalive(other) && other.targetname == self.target)
		{
			break;
		}

	}
	other notify ("groupedanimevent","stand");



}

player_vehicle_paths()
{
	self thread skidder();
	pathstart = self.attachedpath;
	if(!isdefined (pathstart))
	{
		println (self.targetname, " isn't near a path");
		return;
	}
	pathpoint = pathstart;
	while(isdefined (pathpoint))
	{
		if(isdefined(pathpoint.script_noteworthy))
		{
			if (pathpoint.script_noteworthy == "hardstop")
			{
				self setWaitNode(pathpoint);
				self waittill ("reached_wait_node");
				self setspeed (0,1000);
				self notify ("hardstop");
			}
			else if (pathpoint.script_noteworthy == "skidon")
			{
				self setWaitNode(pathpoint);
				self waittill ("reached_wait_node");
				self notify ("skidon");
			}
			else if (pathpoint.script_noteworthy == "skidonoff")
			{
				self setWaitNode(pathpoint);
				self waittill ("reached_wait_node");
				self notify ("skidoff");
			}

		}
		if(isdefined (pathpoint.target))
		{
			pathpoint = getvehiclenode(pathpoint.target, "targetname");
		}
		else
			break;
	}
}


trigger_setup_vehiclegrouploweracc()
{
	triggers = getentarray("tgrouploweracc","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread trigger_vehiclegrouploweracc();
	}
}
trigger_vehiclegrouploweracc()
{
	self waittill ("trigger");
	targ = getent(self.target,"targetname");
	if(!isdefined(targ))
		return;
	ai = getaiarray("axis");
	for(i=0;i<ai.size;i++)
	{
		if(isdefined(ai[i].script_vehiclegroup) && ai[i].script_vehiclegroup == targ.script_vehiclegroup)
		{
			ai[i] thread loweracc();
		}
	}

}
loweracc()
{
	self.accuracystationaryMod = 0;
	self.accuracy = 0.1;
	self.favoriteenemy = level.player;
}

trigger_setup_vehiclegroupraiseacc()
{
	triggers = getentarray("tgroupraiseacc","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread trigger_vehiclegroupraiseacc();
	}
}
trigger_vehiclegroupraiseacc()
{
	self waittill ("trigger");
	targ = getent(self.target,"targetname");
	if(!isdefined(targ))
		return;
	ai = getaiarray("axis");
	for(i=0;i<ai.size;i++)
	{
		if(isdefined(ai[i].script_vehiclegroup) && ai[i].script_vehiclegroup == targ.script_vehiclegroup)
		{
			ai[i] thread raiseacc();
		}
	}

}
raiseacc()
{
	self.accuracystationaryMod = 0;
	self.accuracy = .1;
	self.favoriteenemy = level.player;
}
trigger_setup_vehiclegroupblowmeup()
{
	triggers = getentarray("tgroupblowup","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread trigger_vehiclegroupblowmeup();
	}
}

trigger_vehiclegroupblowmeup()
{
	while(1)
	{
		self waittill ("trigger",other);
		if(isalive(other) && other.targetname == self.target)
		{
			break;
		}

	}
	println("stuffdoingno0w");
	radiusDamage (other.origin, 2, 10000, 10000);
}