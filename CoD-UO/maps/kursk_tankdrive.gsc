
main(introscreen)
{

	if (getcvar("debug_notank") == "")
		setcvar("debug_notank", "off");
/*	commenting out these debug cvars until I see they are applicable to kursk

	if (getcvar("debug_passiveattackmsg") == "")
		setcvar("debug_passiveattackmsg", "off");
	if (getcvar("debug_focusfiremessage") == "")
		setcvar("debug_focusfiremessage", "off");
*/	if (getcvar("debug_tankgod") == "")
		setcvar("debug_tankgod", "off");
/*	if (getcvar("debug_tankpaths") == "")
		setcvar("debug_tankpaths", "off");
	if (getcvar("debug_tankspawners") == "")
		setcvar("debug_tankspawners", "off");

	if (getcvar("debug_tankdriveall") == "")
		setcvar("debug_tankdriveall", "off");
	if (getcvar("debug_tankdrivenone") == "")
		setcvar("debug_tankdrivenone", "off");

	if(getcvar("debug_tankdrivenone") != "off")
	{
		setcvar("debug_tankall", "off");
		setcvar("debug_notank", "off");
		setcvar("debug_passiveattackmsg", "off");
		setcvar("debug_focusfiremessage", "off");
		setcvar("debug_tankgod", "off");
		setcvar("debug_tankpaths", "off");
		setcvar("debug_tankspawners", "off");
		setcvar("debug_tankdrivenone", "off");
	}

	if (getcvar("debug_tankdriveall") != "off")
	{
		setcvar("debug_passiveattackmsg", "on");
		setcvar("debug_focusfiremessage", "on");
		setcvar("debug_tankgod", "on");
		setcvar("debug_tankpaths", "on");
		setcvar("debug_tankspawners", "on");
		setcvar("debug_tankdriveall", "off");
	}
	*/

	level.farm_cleaned_up_1 = false;
	level.farm_cleaned_up_2 = false;
//	level.barrier_cleaned_up = false;

	//  burning tank effect which can be disabled
	level.fireydeath = loadfx ("fx/fire/pathfinder_extreme.efx");
	level.watereffects 	= loadfx ("fx/water/tug_froth.efx");
	
//	maps\_tank_gmi::main(); redundant, called in _load.gsc
	
	getonramps();
	
	level.resumespeedaccel = 15; // acceleration after stopping
	level.turretfiretime = 1; // delay on the tanks MG turrets
//	level.waitingforplayer = false;

	// player tank setup
	playertank = getent("player_tank","targetname");

	playertank maps\_t34_pi::init_player();
	playertank thread maps\_tankgun_gmi::mginit(); // spawns the playertank's MG turret
	playertank.ismoving = 1;
	level.playertank = playertank;
	level.playertank thread maps\_treads_pi::main(); // tread fx

	if(getcvar("debug_notank") == "off")
	{
		level thread put_player_in_tank();
	}


	//keep the player's health at full while he's in the tank.  If tank dies, player does too
	level.player thread regen(playertank);

	// layout the tank hud
	playertank thread tank_hud();

	// fx waits
	playertank thread watersplashes(true);

	trigger_minefields();
}

put_player_in_tank()
{
	level.playertank useby(level.player); // puts player in tank
}

// handles player exiting the tank
exit_tank()
{
	level.playertank useby(level.player);
	level.playertank setmodel("xmodel/vehicle_tank_t34");
	level.playertank.mgturret setmode("manual");

	level notify("exit_tank");

	level.player.maxhealth = level.player.oldmaxhealth;
	level.player.health = level.player.maxhealth;
}

tank_hud()
{
	level endon("exit_tank");

	level thread tank_hud_fireicon();
	level thread tank_hud_fireicon_remove();
	
	self.maxhealth = self.health;

	maxvisheight = 118; // full health bar
	minvisheight = 12; // empty health bar
	
	tankhud = newHudElem();
	tankhud setShader("gfx/hud/tankhudhealthbar", 32, maxvisheight);
	tankhud.alignX = "right";
	tankhud.alignY = "bottom";
	tankhud.x = 635;
	tankhud.y = 450;
	
	tankhud2 = newHudElem();
	tankhud2 setShader("gfx/hud/tankhudback", 32, 128);
	tankhud2.alignX = "right";
	tankhud2.alignY = "bottom";
	tankhud2.x = 635;
	tankhud2.y = 450;

	level thread tank_hud_remove(tankhud, tankhud2);

	if (getcvar("debug_tankgod") != "off")
	while(1)
	{
		self waittill ("damage");
		self.health = self.maxhealth;
	}
	
	while(self.health > 0)
	{
		level.autosavehealth = self.health / self.maxhealth;
		
		self waittill ("damage",amount,attacker);
		
//		println("tankdrive::tank_hud damage:  ",amount);
/*
		// TODO change this!  Tank won't take damage less than 999
		if((currenthealth - self.health) < 999)
		{
			println("self.health: ",self.health," being set to currenthealth: ",currenthealth);
			self.health = currenthealth;
			
		}
		else
		{
			println("currenthealth: ",currenthealth," being set to self.health: ",self.health);
			currenthealth = self.health;
		}
*/


		height = (((float)self.health / (float)self.maxhealth) * (float)(maxvisheight - minvisheight)) + minvisheight;

//		println("Height:  ",height);

		// this can happen if the player takes a bunch of damage
		if(height<0)
		{
			height = 0;
		}

		tankhud setShader("gfx/hud/tankhudhealthbar", 32, height);

/*
		if(attacker != self && attacker != level.player)
		{
			//CHAD - USE ANOTHER SOUND HERE THAT ISN'T BRITISH
			//self playsound ("tankdrive_damaged","damaged",1);
		}
*/
		
	}

	// kill tank and player
	radiusDamage ( self.origin, 2, 10000, 9000);
	level.player DoDamage ( level.player.health + 50, (0,0,0) );
}

tank_hud_remove(tankhud, tankhud2)
{
	level waittill("exit_tank");

	tankhud destroy();
	tankhud2 destroy();
}


tank_hud_fireicon()
{
	level endon("exit_tank");

	level.tankfireicon = newHudElem();			
	level.tankfireicon.alignX = "center";
	level.tankfireicon.alignY = "middle";
	level.tankfireicon.x = 590;
	level.tankfireicon.y = 420;
	level.tankfireicon setShader("gfx/hud/hud@fire_ready_shell.tga", 64, 64);
	
	while (1)
	{
		level.tankfireicon.alpha = 1;
		level.playertank waittill ("turret_fire");
		level.tankfireicon.alpha = 0;
		wait .5;
		level.playertank playsound ("tank_reload");
		while (level.playertank isTurretReady() != true)
			wait .2;
	}
	
}

tank_hud_fireicon_remove()
{
	level waittill("exit_tank");
	level.tankfireicon destroy();
}

regen(tank)
{
	// need these for when player exits tank
	level endon("exit_tank");
	level.player.oldmaxhealth = level.player.maxhealth;

	self.health =  5000;
	while(isalive(self))
	{
		self waittill ("damage");
	
//		println("tankdrive::regen damage taken");

		if(tank.health <= 0)
			self DoDamage ( self.health + 50, (0,0,0) );
		else
			self.health = 5000;
	}
}

getonramps()
{
	level.onramps = [];
	onrampcount = 0;
	pathnodes = getallvehiclenodes();
	for(i=0;i<pathnodes.size;i++)
	{
		if(isdefined(pathnodes[i].script_noteworthy) && pathnodes[i].script_noteworthy == "onramp")
		{
			level.onramps[onrampcount] = pathnodes[i];
			onrampcount++;
		}
	}
//	println("Onrampcount: ",onrampcount);
}

friendly_tank_think()
{
	self addvehicletocompass();

	// Set up how friendly tanks respond to damage
	thread friendly_damage_handling();

	// attach them to the closest path (defined as a vehiclenode with targetname "vehicle_path")
	path = nearestpath(self);
	if(!isdefined(path))
	{
		println("no path for friendly tank, doing nothing");
		return;
	}
	self attachpath(path);

	// fancy-shmancy pathing stuff
	thread friendly_path_setup(path);

	self gopath();

}

enemy_damage_shield()
{
	// This buffer is needed because the damage will already have occurred in the game engine.  Since we want to handle damage here,
	// we have to make sure the tank isn't already killed by the time it gets here.

	buffer = 2000;
	
	self.health += buffer;
	currenthealth = self.health; // so we can compare what the health was before the game engine subtracted damage

	while(self.health > 0)
	{
		self waittill ("damage", amount, attacker);
		print(amount, " damage on ",self.targetname," ");
		if(isdefined(attacker))
		{
			// ignore damage done to oneself or by one's own team
			if(attacker == self)
			{
				self.health = currenthealth;
				println("by self.  Ignoring.  Health is now: ",self.health);
			}
			else if(isdefined(attacker.script_team) && isdefined(self.script_team) && (attacker.script_team == self.script_team))
			{
				self.health = currenthealth;
				println("by own team.  Ignoring.  Health is now: ",self.health);
			}
			// player gets to damage enemy tanks as if they had no shield
			else if(attacker == level.playertank)
			{
				self.health = currenthealth - amount;
				currenthealth = self.health;
				println("by player.  Health is now: ",self.health);
			}
			else
			{
				if(isdefined(self.damage_shield_fraction))
				{
					reduced_amount = (amount * (1-self.damage_shield_fraction));
					self.health = currenthealth - reduced_amount;
					println("reduced by ",self.damage_shield_fraction," to ", reduced_amount," Health is now ",self.health);

				}
				else
				{
					println("by something we're not handling yet!  Health is now: ",self.health);
				}
				currenthealth = self.health;
			}
		}

		// check to see if the tank would be dead without the buffer fakery
		if( self.health < buffer )
		{
			break;
		}
			
	}

	radiusDamage ( self.origin, 2, 10000, 9000);
}


friendly_damage_handling()
{
	// This buffer is needed because the damage will already have occurred in the game engine.  Since we want to handle damage here,
	// we have to make sure the tank isn't already killed by the time it gets here.

	buffer = 25000;
	
	self.health += buffer;
	currenthealth = self.health; // so we can compare what the health was before the game engine subtracted damage

	while(self.health > 0)
	{
		self waittill ("damage", amount, attacker);
		print(amount, " damage on ",self.targetname," ");
		if(isdefined(attacker))
		{
			// don't let the player damage friendly tanks
			if(attacker == level.playertank)
			{
				self.health = currenthealth;
				println("by player.  Ignoring.  Health is now: ",self.health);
			}
			else
			{
				if(isdefined(self.damage_shield_fraction))
				{
					reduced_amount = (amount * (1-self.damage_shield_fraction));
					self.health = currenthealth - reduced_amount;
					println("reduced by ",self.damage_shield_fraction," to ", reduced_amount," Health is now ",self.health);

				}
				else
				{
					println("by something we're not handling yet!  Health is now: ",self.health);
				}
				currenthealth = self.health;
			}
		}

		// check to see if the tank would be dead without the buffer fakery
		if( self.health < buffer )
		{
			break;
		}
			
	}

	radiusDamage ( self.origin, 2, 10000, 9000);
}

nearestpath(vehicle)
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
	if(!isdefined(theone))
		return undefined;
	return theone;
}

enemy_path_setup(path)
{
	self notify ("newpath");
//	path_detour_flag(path); // set up detours off this path
	path_endnode_flag(path); // set up any onramp connections to the endnode of this path
//	friendly_path_wait_spots(path); // set up triggers and associated nodes to wait for player
	enemy_pathwaits(path);
}

friendly_path_setup(path)
{
	self notify ("newpath");
//	path_detour_flag(path); // set up detours off this path
	path_endnode_flag(path); // set up any onramp connections to the endnode of this path
	friendly_path_wait_spots(path); // set up triggers and associated nodes to wait for player
	friendly_pathwaits(path);
}
/*
path_detour_flag(path)
{
	paths = [];
	count = 0;
	pathspot = path;
	while(isdefined(pathspot))
	{
		paths[count] = pathspot;
		count++;
		if(isdefined(pathspot.script_noteworthy) && pathspot.script_noteworthy == "detour")
		{
			detourpath = nearestdetourpath(pathspot);
			if(isdefined(detourpath))
			{
				paths[count-1].detourstart = pathspot;
				paths[count-1].detourpath = detourpath;
				paths[count-1].script_noteworthy = "detourwait";
				paths[count-1].detoured = 0;
			}
			else
			{
				println("can't find detour path for path here ",pathspot.origin);
			}

		}
		count++;
		pathspot = path_next_inloop(pathspot);
	}
}

nearestdetourpath(vehicle)
{
	vehiclepaths = getvehiclenodearray("vehicle_detour", "targetname");
	distance = 512;
	for(i=0;i<vehiclepaths.size;i++)
	{
		newdistance = distance(vehicle.origin,vehiclepaths[i].origin);
		if(newdistance < distance)
		{
			theone = vehiclepaths[i];
			distance = newdistance;
		}
	}
	if(!isdefined(theone))
		return undefined;
	return theone;
}
*/

path_next_inloop(pathspot)
{
	if(isdefined(pathspot.target))
	{
		pathspot = getvehiclenode(pathspot.target, "targetname");
		return pathspot;
	}
	else
	{
		return undefined;
	}
}

path_endnode_flag(path)
{

	count = 0;
	pathz = [];
	pathspot = path;

	// get the last node in this path
	while(isdefined(pathspot))
	{
		pathz[count] = pathspot;
		count++;
		thenode = pathspot;
		pathspot = path_next_inloop(pathspot);

	}

	if(!isdefined(thenode))
		println("thenode not defined");

	// setup any onramps near the end of this path
	nextpath = nearestonramp(thenode);
	if(!isdefined(nextpath))
	{
//		if (getcvar("debug_tankpaths") != "off")
//			println("nextpath not defined for node ",thenode.targetname," at ",thenode.origin);
		return;

	}

	pathz[count-1].script_noteworthy = "pathexitswitch";
	pathz[count-1].startswitch = thenode;
	pathz[count-1].endswitch = nextpath;
}

nearestonramp(endnode)
{
	if(isdefined(level.onramps))
	{

		distance = 128;
		for(i=0;i<level.onramps.size;i++)
		{
			newdistance = distance(endnode.origin,level.onramps[i].origin);
			if(newdistance < distance)
			{
				theone = level.onramps[i];
				distance = newdistance;
			}
		}
		if(!isdefined(theone))
		{
			return undefined;
		}
		return theone;
	}
	return undefined;
}

friendly_path_wait_spots(path)
{
	// get everything (all triggers) with targetname friendwait 
	friendwaits = getentarray("friendwait","targetname");

	// for each friendwait trigger, take the node it's targetted to and set its friendlywait to 1 (friendly_path_flag).  Then, 
	for(i=0;i<friendwaits.size;i++)
	{
		flagged = friendwaits[i] friendly_path_flag(); // flag the nodes this trigger targets as friendlywaits
		if(isdefined(flagged))
		{
			friendwaits[i] thread friendly_path_wait(friendwaits[i]); // set up the trigger to wait for the player
		}
	}
	flagged = undefined;

	friendwaitsarray = getentarray("friendwaitarray","targetname");
	for(i=0;i<friendwaitsarray.size;i++)
	{
		targs = getentarray(friendwaitsarray[i].target,"targetname");
		for(j=0;j<targs.size;j++)
		{
			flagged = targs[j] friendly_path_flag();
			friendwaitsarray[i] thread friendly_path_wait(targs[j]);
		}
	}
}

// handles ENTITIES(triggers) with targetname "friendwait" or "friendwaitarray"
friendly_path_flag()
{
	// get the node associated with the trigger
	if(isdefined(self.target))
	{
		node = getvehiclenode(self.target,"targetname");
	}
	else
	{
		println("no target on trigger at ", self.origin);
		return undefined;
	}

	// set the friendlywait flag on that vehiclenode
	if(isdefined(node))
	{
		node.friendlywait = 1;
	}
	else
	{
		println("trigger doesn't target vehiclenode at", self.origin);
		return undefined;
	}
	return 1;
}

// handles friendlywait triggers
friendly_path_wait(trig)
{
	node = getvehiclenode(trig.target,"targetname");

//	println("Trigger targetting ", trig.target," is waiting");

	self waittill("trigger");
	if (isdefined (self.script_noteworthy))
	{
		level notify (self.script_noteworthy + " friendwait triggered");
		while (!level.flags[self.script_noteworthy])
			wait 1;
		self waittill("trigger");
	}
	
//	println("Trigger targetting ", trig.target," has been triggered");

	node.playerhasbeenhere = 1;
	node notify("playerishere");
//	level.waitingforplayer = false;
}

friendly_pathwaits(path)
{
	pathspot = path;
	while(isdefined(pathspot))
	{
		// if this node is associated with a friendlywait trigger, set it as a waitnode for this tank
		if(isdefined(pathspot.friendlywait))
		{
			self setwaitnode(pathspot);
			self waittill("reached_wait_node");
			// when the tank reaches this waitnode, pause until the player hits its associated trigger
			self thread waitforfriend(pathspot);
		}
		else if(isdefined(pathspot.script_noteworthy))
		{
			// turn on this vehicle's deathroll flag
			if(pathspot.script_noteworthy == "deathrollon")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self deathrollon();
			}
			//turn off this vehicle's deathroll flag
			else if(pathspot.script_noteworthy == "deathrolloff")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self deathrolloff();
			}
			else if(pathspot.script_noteworthy == "deathroll_offramp")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(!isdefined(pathspot.offramp_used) && (self.rollingdeath == 1) && (self.health < 0))
				{
					self thread offramp_friendly(pathspot);
					break;
				}				
			}
			// set this node up as a detour
	/*		else if(pathspot.script_noteworthy == "detourwait")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				
				// if we haven't detoured...
				if(isdefined(pathspot.detoured) && pathspot.detoured == 0)
				{
					self setswitchnode(pathspot.detourstart,pathspot.detourpath);
					pathspot.detoured = 1;
					thread friendly_path_setup(pathspot.detourpath); // run through all the path setup stuff on this new path
					break;
				}
			}
	*/		// set-up the transfer to an onramp node's path
			else if(pathspot.script_noteworthy == "pathexitswitch")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
//				println(pathspot.targetname, "is pathexitswitching");
				self setswitchnode(pathspot.startswitch,pathspot.endswitch);
				thread friendly_path_setup(pathspot.endswitch); // run through all the path setup stuff on this new path
				break;
			}
/*			else if(pathspot.script_noteworthy == "passiveattack")
			{
								self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				pathspot set_killcommit(self); // ??  Not sure of the purpose of this yet
				self thread attack(pathspot);

			
			}
*/			else if(pathspot.script_noteworthy == "pakattack") // specifically for the kursk river crossing
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread pakattack();
			}
			else if(pathspot.script_noteworthy == "pakwait") // specifically for the kursk river crossing
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread pakwait();
			}
			else if(pathspot.script_noteworthy == "barrierattack") // specifically for the kursk river crossing
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread barrierattack();
			}
			else if(pathspot.script_noteworthy == "eventwait") // wait here until a notify is recieved from script
			{	
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread eventwait(pathspot);
			}
			else if(pathspot.script_noteworthy == "offramp") // send first vehicle off this path onto another
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(!isdefined(pathspot.offramp_used))
				{
					self thread offramp_friendly(pathspot);
					break;
				}

			}
			else if(pathspot.script_noteworthy == "offramp2") // send first two vehicles off this path onto another
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(!isdefined(pathspot.offramp_used) || (pathspot.offramp_used < 2))
				{
					self thread offramp_friendly(pathspot);
					break;
				}

			}
			else if(pathspot.script_noteworthy == "offramp_alternate") // alternate sending vehicles off this path onto another
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(!isdefined(pathspot.offramp_used))
				{
					self thread offramp_friendly(pathspot);
					break;
				}
				else
				{
					pathspot.offramp_used = undefined;
				}

			}
			else if(pathspot.script_noteworthy == "offramp_after1") // sending vehicles off this path onto another after the first one passes
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(!isdefined(pathspot.offramp_used))
				{
					pathspot.offramp_used = 0;
				}
				else
				{
					self thread offramp_friendly(pathspot);
					break;
				}

			}
			else if(pathspot.script_noteworthy == "eventwait_after1") // eventwaiting after the first one passes
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(!isdefined(pathspot.eventwait_used))
				{
					pathspot.eventwait_used = 1;
				}
				else
				{
					self thread eventwait(pathspot);
				}

			}
			else if(pathspot.script_noteworthy == "farmpause5") // pause the tank for 5 seconds if farm event is still going on
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(level.farmphase < 6)
				{
					self thread pausevehicle(5);
				}
			}
			else if(pathspot.script_noteworthy == "clearingpause5") // pause the tank for 5 seconds if clearing phase 1 is still going on
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(level.clearingphase < 4)
				{
					self thread pausevehicle(5);
				}
			}
			else if(pathspot.script_noteworthy == "clearing2pause5") // pause the tank for 5 seconds if clearing phase 2 is still going on
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(level.clearingphase < 6)
				{
					self thread pausevehicle(5);
				}
			}
			else if(pathspot.script_noteworthy == "stage1pause5") // pause the tank for 5 seconds if stage 1 is still going on
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(level.endphase < 1)
				{
					self thread pausevehicle(5);
				}
			}
			else if(pathspot.script_noteworthy == "stage2pause5") // pause the tank for 5 seconds if stage 2 is still going on
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(level.endphase < 2)
				{
					self thread pausevehicle(5);
				}
			}
			else if(pathspot.script_noteworthy == "dummyfire") // fire, no matter where we're pointed at the moment
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self notify("turret_fire");
			}
			else if(pathspot.script_noteworthy == "river_cleanup") // kill off any remaining infantry at the river crossing
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread river_cleanup();
			}
/*
			else if(pathspot.script_noteworthy == "barrier_cleanup") // kill off any remaining infantry at the barrier section
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread barrier_cleanup();
			}
*/
			else if(pathspot.script_noteworthy == "die") // blow up
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				level.duckshootdiecount++;
				if(level.duckshootdiecount>2)
				{
					level notify("duckshoot_combat_start");
				}
				self notify("death");
				break;
			}
			else if(pathspot.script_noteworthy == "triggeredthink") // lets tanks using turret_attack_think_Kursk start shooting
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self notify("triggeredthink");
				self.triggeredthink = false;
			}
			else if(pathspot.script_noteworthy == "tunnel_attack") // shoot at the elefant in the tunnel
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread tunnel_attack();
			}
			else if(pathspot.script_noteworthy == "invincible_on") // shoot at the elefant in the tunnel
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(isdefined(self.damage_shield_fraction))
				{
					self.old_damage_shield_fraction = self.damage_shield_fraction;
                    self.damage_shield_fraction = 1.0;
				}
			}
			else if(pathspot.script_noteworthy == "invincible_off") // shoot at the elefant in the tunnel
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(isdefined(self.old_damage_shield_fraction))
				{
                    self.damage_shield_fraction = self.old_damage_shield_fraction;
				}
			}
			else if(pathspot.script_noteworthy == "farm_cleanup1") // kill off any remaining infantry at the farm
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread farm_cleanup1();
			}
			else if(pathspot.script_noteworthy == "farm_cleanup2") // kill off any remaining infantry at the farm
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread farm_cleanup2();
			}
		}
		pathspot = path_next_inloop(pathspot);
	}
}

pausevehicle(time)
{
	self setspeed(0,10);
	wait(time);
	if(isdefined(self) && isalive(self))
	{
		self resumespeed(5);
	}
}

barriershot()
{
	self setspeed(0,20);
	self notify("barriershot");
	self waittill("barriershot_done");
	self resumespeed(10);
}

tunnel_attack()
{	
	self endon("death");

	tunnel_elefant = getent("tunnel_elefant","targetname");

	
	if(level.tunnel_completed == false)
	{
		tunnel_t34_targets = getentarray("tunnel_t34_target","targetname");
	}
	while(level.tunnel_completed == false)
	{
		// pick a target, any target
		targetarray = [];
		targetarray = add_array_to_array(targetarray, tunnel_t34_targets);
		if(isdefined(tunnel_elefant) && isalive(tunnel_elefant))
		{
			targetarray = maps\_utility_gmi::add_to_array(targetarray, tunnel_elefant);
		}
	
		if(targetarray.size > 0)
		{
			target = targetarray[randomint(targetarray.size)];
	
			self setTurretTargetEnt(target,(0,0,0));
			self waittill("turret_on_target");
			self notify( "turret_fire" );
			wait(2 + randomfloat(2));
		}
		else
		{
			println("targetarray.size not greater than zero!:  ",targetarray.size);
			wait(1);
		}
	}

//	println("tunnel_done");

	self resumespeed(10);
	self thread setturretforward();
}

convoy_path_setup(path)
{
	self notify ("newpath");
//	path_detour_flag(path); // set up detours off this path
	path_endnode_flag(path); // set up any onramp connections to the endnode of this path
	convoy_path_wait_triggers(path); // set up triggers and associated nodes to wait for player
	self thread convoy_pathwaits(path);
}

convoy_path_wait_triggers(path)
{
	// get everything (all triggers) with targetname convoywait 
	convoywaits = getentarray("convoywait","targetname");

	// for each convoywait trigger, take the node it's targetted to and set its convoywait to 1 
	for(i=0;i<convoywaits.size;i++)
	{
		flagged = convoywaits[i] convoy_path_flag(); // flag the nodes this trigger targets as convoywaits
		if(isdefined(flagged))
		{
			convoywaits[i] thread convoy_path_wait(convoywaits[i]); // set up the trigger to wait for the player
		}
	}
}

// handles convoywait triggers
convoy_path_wait(trig)
{
	node = getvehiclenode(trig.target,"targetname");
	self waittill("trigger");
	if (isdefined (self.script_noteworthy))
	{
		level notify (self.script_noteworthy + " convoywait triggered");
		while (!level.flags[self.script_noteworthy])
			wait 1;
		self waittill("trigger");
	}
	node = getvehiclenode(trig.target,"targetname");
	node notify("convoy_go");
}


convoy_path_flag()
{
	// get the node associated with the trigger
	if(isdefined(self.target))
	{
		node = getvehiclenode(self.target,"targetname");
	}
	else
	{
		println("no target on trigger at ", self.origin);
		return undefined;
	}

	// set the convoywait flag on that vehiclenode
	if(isdefined(node))
	{
		node.convoywait = 1;
	}
	else
	{
		println("trigger doesn't target vehiclenode at", self.origin);
		return undefined;
	}
	return 1;
}

deathroll_only_pathwaits(path)
{
	pathspot = path;
	while(isdefined(pathspot))
	{	
		if(isdefined(pathspot.script_noteworthy))
		{
			if(pathspot.script_noteworthy == "deathrollon")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self deathrollon();
			}
			else if(pathspot.script_noteworthy == "deathrolloff")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self deathrolloff();
			}
		}
		pathspot = path_next_inloop(pathspot);
	}
}


convoy_pathwaits(path)
{
	pathspot = path;
	while(isdefined(pathspot))
	{
		if(isdefined(pathspot.convoywait))
		{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread convoy_playerwait(pathspot);
		}
		else if(isdefined(pathspot.script_noteworthy))
		{
			// set-up the transfer to an onramp node's path
			if(pathspot.script_noteworthy == "pathexitswitch")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self setswitchnode(pathspot.startswitch,pathspot.endswitch);
				thread convoy_path_setup(pathspot.endswitch); // run through all the path setup stuff on this new path -- SKIP this for the specialized case we have here
				break;
			}
			else if(pathspot.script_noteworthy == "deathrollon")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self deathrollon();
			}
			else if(pathspot.script_noteworthy == "deathrolloff")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self deathrolloff();
			}
			else if(pathspot.script_noteworthy == "deathroll_offramp")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if(!isdefined(pathspot.offramp_used) && (self.rollingdeath == 1) && (self.health < 0))
				{
					self thread offramp_convoy(pathspot);
					break;
				}				
			}
			else if(pathspot.script_noteworthy == "offramp_tank") // tanks (only) take this one
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				if((self.vehicletype == "PanzerIV") || (self.vehicletype == "Tiger"))
				{
					self thread offramp_convoy(pathspot);
					break;
				}
			}
		}
		pathspot = path_next_inloop(pathspot);
	}
}

convoy_playerwait(pathspot)
{
	// wait here until player hits the trigger targetted to this node
	if(!isdefined(pathspot.convoyarrived))
	{
		pathspot.convoyarrived = 1; // when the first one gets here, the rest will pass on by
		self setspeed(0,15);
		println("CONVOY WAITING");
		pathspot waittill("convoy_go");
		println("CONVOY GOING");
		if(self.health > 0)
		{
			self resumespeed(level.resumespeedaccel);
		}
	}
}

waitforfriend(pathspot)
{
	if(!isdefined(pathspot.playerhasbeenhere))
	{
		// pause until the player hits the trigger pointing to this node
		self setspeed(0,15);


//		println("^2waitforfriend: WAITING FOR PLAYER!");
		self thread waiting_for_player(pathspot); // start barking at the player to get a move on 
		pathspot waittill("playerishere");

//		println("^2PLAYERISHERE!");

		if(self.health > 0)
		{
			self resumespeed(level.resumespeedaccel);
		}
	}
}

waiting_for_player(node)
{
	node endon("playerishere");

//	if( level.waitingforplayer == false )
//	{
//		level.waitingforplayer = true;
//		println("level.waitingforplayer set to true");

		if( isdefined( node.playerwait ) )
		{
			wait(node.playerwait); // initial wait
		}
		else
		{
			wait(5.0);
		}

		while(!isdefined(node.playerhasbeenhere))
		{
			println(self.targetname, " is WAITING FOR PLAYER");
		//	level.playertank playsound("kursk_hurryup");
			wait(5);
		}
//	}
//	else
//	{
//		println("level.waitingforplayer is not false: ",level.waitingforplayer);
//	}
	return;
}

//turn on rollingdeath
deathrollon()
{
	if(self.health > 0)
	{
//		println(self.targetname, "^1: ROLLINGDEATH ON");
		self.rollingdeath = 1;
	}
}

//turn off rollingdeath
deathrolloff()
{
//	println(self.targetname, "^2: ROLLINGDEATH OFF");
	self.rollingdeath = undefined;
	self notify("deathrolloff");
}


set_killcommit(tank)
{
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "passiveattack")
	{
//		if(getcvar("debug_passiveattackmsg") != "off")
//			iprintlnbold("passiveattackmsg");
		tank.killcommit = undefined;
	}
	else
		tank.killcommit = 1;
}

gopath()
{
	if (isdefined (level.tankstartstopped))
	{
		level waittill ("level start tanks");
		level.tankstartstopped = undefined;
	}
	
	if(self.health > 0)
	{
		wait(randomfloat(2)); // just so all the tanks don't start at the same instant
		self startpath();
		self.ismoving = 1;
	}
}

// fires at the pak 43s at the first river crossing in kursk
pakattack()
{
	pak43_1 = getent("pak43_1","targetname");
	pak43_2 = getent("pak43_2","targetname");
//	pak43_3 = getent("pak43_3","targetname");

	if( !isdefined(pak43_1) && !isdefined(pak43_2))// && !isdefined(pak43_3))
	{
		println("WARNING: pakattack being called without paks!");
		return;
	}

	self endon("death");
//	level endon("paks_dead");

	// slow down for firing speed
	self setspeed(5,5);

	// manual targeting

	if(self.targetname == "t34_2")
	{
		self.paktarget = 1;
		target = pak43_1;
	}
	else if(self.targetname == "t34_cmdr")
	{
		self.paktarget = 2;
//		self.paktarget = 3;
		target = pak43_2;
//		target = pak43_3;
	}
	else
	{
		self.paktarget = 2;
		target = pak43_2;
	}

	// we're in phase 1, so randomly choose one of the cool, whiz-bang, (but safe) targets
	targetlist = getentarray("river_t34_early_target","targetname");

	while(level.pakphase < 2)
	{
		wait( 3 + randomfloat(2));		
		targetent = randomint(targetlist.size);
		self setTurretTargetEnt(targetlist[targetent],(0,0,0));
		self waittill("turret_on_target");
		self notify( "turret_fire" );
	}

	// phase 2, our damage shield is reduced
	// commander remains invulnerable
	if(self.targetname != "t34_cmdr")
	{
		self.damage_shield_fraction = 0.9;
	}

	// in phase 2, same as 1 (with lower damage shield)
	while(level.pakphase < 3)
	{
		wait( 3 + randomfloat(2));		
		targetent = randomint(targetlist.size);
		self setTurretTargetEnt(targetlist[targetent],(0,0,0));
		self waittill("turret_on_target");
		self notify( "turret_fire" );
	}

	if(level.pakphase == 3)
	{
		// in phase 3, we'll actually be useful to the player and clean up after his lousy play
		self thread fire_at_target(target, randomfloat(3), -30, -30, 30, 60, 60, 35);
	}

	if(level.paks_dead == false)
	{
		level waittill("paks_dead");
//		println(self.targetname," recieving paks_dead");
	}
	// event done
	self resumespeed(10);
	self thread setturretforward();
}

pakwait()
{
	river_paks = getentarray("river_paks","groupname");

	if( level.paks_dead == false )
	{
//		println(self.targetname," stopping because paks_dead == false");
		self setspeed(0,5);

		while(level.pakphase < 3)
		{
			wait(1);
		}

		while(level.paks_dead == false)
		{
			// find us a live one, and shoot at it
			culled_array = maps\_pi_utils::CullDead(river_paks);
			if(isdefined(culled_array) && (culled_array.size > 0))
			{
				targetint = randomint(culled_array.size);
				self thread fire_at_target(culled_array[targetint], randomfloat(3), -30, -30, 30, 60, 60, 35);
				self waittill("target dead");
			}
			else
			{
				break;
			}
		}
		self resumespeed(5);
	}
}

barrierattack()
{
//	println(self.targetname," starting barrierattack.");

	self endon("death");

	if(level.barrier_done == false)
	{
		barrier_pak = getent("barrier_pak","targetname");
		barrier_panzer = getent("barrier_panzer","targetname");
		barrier_t34_targets = getentarray("barrier_t34_target","targetname");

//		println("barrier_t34_targets.size = ",barrier_t34_targets.size);
		self setspeed(5,10);
	}

	while(level.barrier_done == false)
	{
		// pick a target, any target
		targetarray = [];
		targetarray = add_array_to_array(targetarray, barrier_t34_targets);
		if(isdefined(barrier_panzer) && isalive(barrier_panzer))
		{
			targetarray = maps\_utility_gmi::add_to_array(targetarray, barrier_panzer);
		}
		if(isdefined(barrier_pak) && isalive(barrier_pak))
		{
			targetarray = maps\_utility_gmi::add_to_array(targetarray, barrier_pak);
		}
	
		if(targetarray.size > 0)
		{
//			println("targetarray.size = ",targetarray.size);
			target = targetarray[randomint(targetarray.size)];
			self setTurretTargetEnt(target,(0,0,0));
			self waittill("turret_on_target");
			self notify( "turret_fire" );
			wait(3); // pausing seems necessary to prevent a crazily huge barrage of fire
		}
		else
		{
			println("targetarray.size not greater than zero!:  ",targetarray.size);
			wait(1);
		}
	//	println("barrier_t34_targets.size = ",barrier_t34_targets.size);
	}

//	println("barrier_done");
	self resumespeed(10);
	self thread setturretforward();
}

// Adds the 2 given arrays together and returns them into 1 array
add_array_to_array(array1, array2)
{
	if(!isdefined(array1) || !isdefined(array2))
	{
		println("^3(ADD_ARRAY_TO_ARRAY)WARNING! WARNING!, ONE OF THE ARRAYS IS NOT DEFINED");
		return;
	}

	array = array1;

	for(i=0;i<array2.size;i++)
	{
		array[array.size] = array2[i];
	}
	return array;
}

eventwait(node)
{
	if(!isdefined(node.eventwaiting))
	{
		node.eventwaiting = true;
	}

	if(node.eventwaiting == true)
	{
		while( node.eventwaiting == true)
		{
//			println(node.targetname," eventwaiting");
			self setspeed(0,15);
			wait(1);
		}
		self resumespeed(15);
	}
}

offramp_friendly(node)
{
//	println("OFFRAMP switching");

	if(!isdefined(node.offramp_used))
	{
		node.offramp_used = 0;
	}

	node.offramp_used++;
	// find an onramp and switch to it
	nextpath = nearestonramp(node);

	if(!isdefined(nextpath))
	{
		println("ERROR: Offramp can't find an onramp!");
		return;

	}
//	println("Onramp found: ",nextpath.targetname);
	self setswitchnode( node, nextpath );
	thread friendly_path_setup(nextpath); // run through all the path setup stuff on this new path
}

offramp_convoy(node)
{
//	println("DEATHROLL OFFRAMP switching");

	if(!isdefined(node.offramp_used))
	{
		node.offramp_used = 0;
	}

	node.offramp_used++;
	// find an onramp and switch to it
	nextpath = nearestonramp(node);

	if(!isdefined(nextpath))
	{
		println("ERROR: Offramp can't find an onramp!");
		return;

	}
//	println("Onramp found: ",nextpath.targetname);
	self setswitchnode( node, nextpath );
	thread convoy_path_setup(nextpath); // run through all the path setup stuff on this new path
}

// fire at this target until I'm dead or the target is
fire_at_target(target, initial_delay, offset_x, offset_y, offset_z, random_offset_x, random_offset_y, random_offset_z)
{
	self endon("death"); // end if I get killed
	self endon("change target"); // end if something tells me to change targets

	if( !isdefined(offset_x))
	{
		x = 0;
	}
	if( !isdefined(offset_y))
	{
		y = 0;
	}
	if( !isdefined(offset_z))
	{
		z = 0;
	}

	if( isdefined(random_offset_x) )
	{
		x = offset_x + randomfloat(random_offset_x);
	}
	if( isdefined(random_offset_y) )
	{
		y = offset_y + randomfloat(random_offset_y);
	}
	if( isdefined(random_offset_z) )
	{
		z = offset_z + randomfloat(random_offset_z);
	}

	if(isdefined(target) && isalive(target))
	{
		self setTurretTargetEnt( target, (x,y,z) );
	}

	if ( self.health > 0)
	{
		wait (initial_delay);
		while ( isalive( target ) )
		{
			if ( self.health > 0)
			{
				if( isdefined(random_offset_x) )
				{
					x = offset_x + randomfloat(random_offset_x);
				}
				if( isdefined(random_offset_y) )
				{
					y = offset_y + randomfloat(random_offset_y);
				}
				if( isdefined(random_offset_z) )
				{
					z = offset_z + randomfloat(random_offset_z);
				}

				self setTurretTargetEnt( target, (x,y,z));
			}
//			println(self.targetname, " TARGETTING ", target.targetname);
			self thread turretTargetTimer(5);
			self maps\_utility_gmi::waittill_any("turret_on_vistarget","turret_target_timeout");
	//	self waittill( "turret_on_vistarget" );
			if( isalive( target ) )
			{
//				println(self.targetname, " FIRING at ",target.targetname);
				self FireTurret();
			}
			else
			{
				self notify("target dead");
				break;
			}
			if ( self.health > 0)
			{
				wait (3 + randomfloat(3));
			}
			else
			{
				break;
			}
			// for pak43s whose loaders are killed and so are not technically 'dead'
			if(!isalive(target) || (isdefined(target.disabled) && (target.disabled == true)))
			{
				self notify("target dead");
				break;
			}
		}
//		println("Target dead.  ",self.targetname," RESUMING SPEED");
		self notify("target dead");
	//	println(self.targetname," setting turret forward");
		self thread setturretforward();
	}
}

turretTargetTimer(time)
{
	self endon("turret_on_vistarget");
	wait(time);
	self notify("turret_target_timeout");
//	println(self.targetname, " timing out on vistargetwait");
}

enemy_vehicle_think(path)
{
	level thread fireydeath(self);
	self endon ("death");

//	self.killcommit = 1;
//	thread maps\_tank_gmi::treads();
//	self.startenemy = level.playertank;
//	self thread splash_shield();

	if(!isdefined(path))
	{
		path = nearestpath(self);
		if(!isdefined(path))
			return;
	}

	self attachpath(path);
	self waittill ("moveenemy");
	
	self thread maps\_tank_pi::avoidtank();
	self thread enemy_pathwaits(path);
	self gopath();
}

fireydeath(tank)
{

	tank waittill("deadstop");
	tank endon("fireextinguish");
	level endon ("fireextinguish");
	level endon ("fireextinguish"+tank.targetname);

	flameemitter = spawn("script_origin",tank.origin+(0,0,32));
	flameemitter thread deleteonextinguish();
	while(1)
	{
		playfx(level.fireydeath,flameemitter.origin);
		wait (randomfloat (0.15)+.1);
	}

}

deleteonextinguish()
{
	level waittill ("fireextinguish");
	wait .05;
	self delete();
}

enemy_pathwaits(path)
{
	pathspot = path;
	while(isdefined(pathspot))
	{
		if(isdefined(pathspot.script_noteworthy))
		{
			if(pathspot.script_noteworthy == "deathrollon")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self deathrollon();
			}
			else if(pathspot.script_noteworthy == "deathrolloff")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self deathrolloff();
			}
			else if(pathspot.script_noteworthy == "farmpause5") // pause the tank for 5 seconds -- technically nothing to do with the farm...
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread pausevehicle(5);
			}
			else if(pathspot.script_noteworthy == "barriershot") // fires a "luring" shot for the barrier section
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread barriershot();
			}
			else if(pathspot.script_noteworthy == "duckshoot_aim") // turns the tanks' turrets to prepare for firing
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread duckshoot_aim();
			}
			else if(pathspot.script_noteworthy == "duckshoot_fire") // fires at the Russians
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread duckshoot_fire();
			}
			else if(pathspot.script_noteworthy == "triggeredthink") // lets tanks using turret_attack_think_Kursk start shooting
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self notify("triggeredthink");
				self.triggeredthink = false;
			}
			else if(pathspot.script_noteworthy == "eventwait") // wait here until a notify is recieved from script
			{	
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread eventwait(pathspot);
			}
		}
		pathspot = path_next_inloop(pathspot);
	}
}

duckshoot_aim()
{
	target = getent("duckshoot_aimtarget","targetname");
	self setTurretTargetEnt(target, (0,0,0));

	if(level.duckshoot_friendlies_awake == false)
	{
		// wake up your T34 buddies
		level.duckshoot_friendlies_awake = true;
		level notify("duckshoot_friendlies_awake");
	}

}

duckshoot_fire()
{

	self waittill("turret_on_vistarget");
	self endon("death");
	// shot from the hip
	self notify("turret_fire");
	wait(3);

	// target the closest Russian and fire
	targetarray = [];
	for(i=0;i<level.friendlies.size;i++)
	{
		targetarray[i] = level.friendlies[i];
	}
	targetarray[level.friendlies.size] = level.playertank;

	// don't target the commander, since he's invulnerable and it looks bad
	targetarray = maps\_utility_gmi::array_remove(targetarray, level.t34_commander);

	while(1)
	{
		culled_targetarray = maps\_pi_utils::CullDead(targetarray);
		closest_target = maps\kursk_tankdrive::get_closest_target(culled_targetarray);
		self setTurretTargetEnt(closest_target, (0,0,0));
		self waittill("turret_on_vistarget");
		self notify("turret_fire");
		wait(3);
	}
}

river_cleanup()
{
	self endon("death");

//	println(self.targetname," cleaning up river infantry");
	river_ai = getentarray("river_ai","groupname");
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
				self setspeed(0,30);
				self setTurretTargetEnt(river_ai[i], (0,0,0));
				wait(2 + randomfloat(2));
				if(isdefined(river_ai[i]) && isalive(river_ai[i]))
				{
					self notify("turret_fire");
				}
				break;
			}
		}
	}
	speed = self getspeedmph();
	if(speed == 0)
	{
		self resumespeed(10);
	}

	self thread setturretforward();
}

farm_cleanup1()
{
	if(level.farm_cleaned_up_1 == false) // only want one tank to do this
	{
		self endon("death");
		level.farm_cleaned_up_1 = true; // so only one tank does this

		farm_ai_1 = getentarray("farm_ai_1","groupname");
		targets_left = true;
		while(targets_left == true)
		{
			self notify("stopthink"); // since we'll probably be in the middle of shooting at other tanks

			// guys next
			targets_left = false;
			for(i=0;i<farm_ai_1.size;i++)
			{
				if(isdefined(farm_ai_1[i]) && isalive(farm_ai_1[i]))
				{
					targets_left = true;
					self setspeed(0,30);
					self setTurretTargetEnt(farm_ai_1[i], (0,0,0));
					self thread turretTargetTimer(7);
					self maps\_utility_gmi::waittill_any("turret_on_vistarget","turret_target_timeout");
					if(isdefined(farm_ai_1[i]) && isalive(farm_ai_1[i]))
					{
						self notify("turret_fire");
						wait(3);
					}
					break;
				}
			}
		}
		speed = self getspeedmph();
		if(speed == 0)
		{
			self resumespeed(10);
		}

		// now that we're done with the infantry, see if we should resume shooting at some tanks...
		self thread maps\kursk_tank::farm_friendly_knucklethink();
		self thread maps\_tank_pi::turret_attack_think_Kursk();
		self.mgturret setmode("manual");
	}
}


farm_cleanup2()
{
	if(level.farm_cleaned_up_2 == false) // only want one tank to do this
	{
		self endon("death");
		level.farm_cleaned_up_2 = true; // so only one tank does this

		farm_ai_2 = getentarray("farm_ai_2","groupname");
		targets_left = true;
		while(targets_left == true)
		{
			self notify("stopthink"); // since we'll probably be in the middle of shooting at other tanks

			// guys next
			targets_left = false;
			for(i=0;i<farm_ai_2.size;i++)
			{
				if(isdefined(farm_ai_2[i]) && isalive(farm_ai_2[i]))
				{
					targets_left = true;
					self setspeed(0,30);
					self setTurretTargetEnt(farm_ai_2[i], (0,0,0));
					self thread turretTargetTimer(7);
					self maps\_utility_gmi::waittill_any("turret_on_vistarget","turret_target_timeout");
					if(isdefined(farm_ai_2[i]) && isalive(farm_ai_2[i]))
					{
						self notify("turret_fire");
						wait(3);
					}
					break;
				}
			}
		}
		speed = self getspeedmph();
		if(speed == 0)
		{
			self resumespeed(10);
		}

		// now that we're done with the infantry, see if we should resume shooting at some tanks...
		self thread maps\kursk_tank::farm_friendly_knucklethink();
		self thread maps\_tank_pi::turret_attack_think_Kursk();
		self.mgturret setmode("manual");
	}
}

/*
barrier_cleanup()
{
	if(level.barrier_cleaned_up == false) // only want one tank to do this
	{
		self endon("death");
		level.barrier_cleaned_up = true; // so only one tank does this

	//	println(self.targetname," cleaning up river infantry");
		barrier_ai = getentarray("barrier_ai","groupname");
		targets_left = true;
		while(targets_left == true)
		{
			// guys next
			targets_left = false;
			for(i=0;i<barrier_ai.size;i++)
			{
				if(isdefined(barrier_ai[i]) && isalive(barrier_ai[i]))
				{
					targets_left = true;
					self setspeed(0,30);
					self setTurretTargetEnt(barrier_ai[i], (0,0,0));
					self thread turretTargetTimer(7);
					self maps\_utility_gmi::waittill_any("turret_on_vistarget","turret_target_timeout");
					if(isdefined(barrier_ai[i]) && isalive(barrier_ai[i]))
					{
						self notify("turret_fire");
						wait(3);
					}
					break;
				}
			}
		}
		speed = self getspeedmph();
		if(speed == 0)
		{
			self resumespeed(10);
		}

		self thread setturretforward();
	}
}
*/

setturretforward()
{
	self endon ("death");
	self clearTurretTarget();
	count = 0;
	while(count < 8)
	{
		count++;
		vector = anglesToForward(self.angles);
		vector = maps\_utility_gmi::vectorMultiply(vector,8000);
		vector = self.origin + vector;
		self setTurretTargetVec(vector);
		wait .5;
	}
	self clearTurretTarget();
}

// returns the closest entity to self
get_closest_target(targetarray)
{
	if(!isdefined(self.origin))
	{
//		println("self.origin undefined");
		return undefined;
	}
	if(!isdefined(targetarray))
	{
//		println("targetarray undefined");
		return undefined;
	}
	
	dist = 999999;
	theone = undefined;
//	println("get_closest_target: targetarray[0] dist = ", dist);

	for(i=0;i<targetarray.size;i++)
	{
		if(isdefined(targetarray[i]) && isalive(targetarray[i]))
		{
			newdist = distance(self.origin,targetarray[i].origin);
	//		println("get_closest_target: targetarray[",i,"] newdist = ", newdist);

			if(newdist < dist)
			{
	//			println("newdist is smaller, using ",targetarray[i].targetname);
				theone = targetarray[i];
				dist = newdist;
			}
		}
	}
	return theone;
}

trigger_minefields()
{
	minefield = getentarray("tankmine","targetname");
	for(i=0;i<minefield.size;i++)
	{
		if(isdefined(minefield[i].script_noteworthy) && minefield[i].script_noteworthy == "instantmine")
			minefield[i] thread minefields_tankinstantmine();
		else
			minefield[i] thread minefields_tank();
	}

}

minefields_tank()
{
	minefieldfx = loadfx ("fx/explosions/metal_b.efx");
	while(1)
	{
		self waittill ("trigger",other);
		wait(randomFloat(1)+ 2);

		if(other istouching(self))
		{
			origin = other getorigin();
			range = 300;
			maxdamage = other.health+1000;
			mindamage = 50;
			while(other.speed < 1)
				wait (0.05);
			self playsound ("misc_menu2");  // dunno what this is.. Copied from _minefields..
			wait .1;
			other playsound ("weapons_rocket_explosion");
			minefieldfx = loadfx ("fx/explosions/metal_b.efx");
			playfx( minefieldfx, other getorigin() );
			//maps\_fx_gmi::GrenadeExplosionfx(origin);
			radiusDamage(origin, range, maxdamage, mindamage);
			level notify ("mine death");
			setCvar("ui_deadquote", "@MINEFIELDS_MINEDIED_TANK");
			missionfailed();
		}
	}


}

minefields_tankinstantmine()
{
	minefieldfx = loadfx ("fx/explosions/metal_b.efx");
	self waittill ("trigger",other);
	self playsound ("misc_menu2");  // dunno what this is.. Copied from _minefields..
	origin = other getorigin();
	range = 300;
	maxdamage = other.health+1000;
	mindamage = 50;

	other playsound ("weapons_rocket_explosion");
	playfx( minefieldfx, other getorigin() );
	radiusDamage(origin, range, maxdamage, mindamage);
	level notify ("mine death");
	setCvar("ui_deadquote", "@MINEFIELDS_MINEDIED_TANK");
	missionfailed();
}



watersplashes(isPlayer)
{
	self endon ("death");
	treadfx = level.watereffects;
	count = 0;
	self.bigsplashed = 0;
	sparkcount = 3;
	if(isPlayer)
		sparkcount = 6;  //player tank doesn't require soo many splashes.
	while(self.health > 0)
	{

		self waittill ("iminwater");
		count++;
		if(count > sparkcount)
		{
			for(i=0;i<self.samplepoints.size;i++)
			{
				x = self.samplepoints[i].origin[0];
				y = self.samplepoints[i].origin[1];
				z = -96;  //level of water in kursk;
				playfx (treadfx, (x,y,z));
				playfx (level._effect["treads_ice"], (x,y,z));
				if(!(self.bigsplashed))
				{
					self thread bigsplash();
					self playsound ("tank_splash");
				}
			}
			count = 0;
			timer = gettime()+200;
		}
	}
}

bigsplash()
{
	self endon ("death");
	self.bigsplashed = 1;
	self waittill ("treadtypechanged");
	self.bigsplashed = 0;
}