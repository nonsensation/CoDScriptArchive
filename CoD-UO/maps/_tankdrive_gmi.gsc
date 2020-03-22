
main(introscreen)
{

	if (getcvar("debug_notank") == "")
		setcvar("debug_notank", "off");
	if (getcvar("debug_enemykillcomit") == "")
		setcvar("debug_enemykillcomit", "off");
	if (getcvar("debug_passiveattackmsg") == "")
		setcvar("debug_passiveattackmsg", "off");
	if (getcvar("debug_focusfiremessage") == "")
		setcvar("debug_focusfiremessage", "off");
	if (getcvar("debug_tankgod") == "")
		setcvar("debug_tankgod", "off");
	if (getcvar("debug_tankpaths") == "")
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
		setcvar("debug_enemykillcomit", "off");
		setcvar("debug_passiveattackmsg", "off");
		setcvar("debug_focusfiremessage", "off");
		setcvar("debug_tankgod", "off");
		setcvar("debug_tankpaths", "off");
		setcvar("debug_tankspawners", "off");
		setcvar("debug_tankdrivenone", "off");
	}

	if (getcvar("debug_tankdriveall") != "off")
	{
		setcvar("debug_enemykillcomit", "on");
		setcvar("debug_passiveattackmsg", "on");
		setcvar("debug_focusfiremessage", "on");
		setcvar("debug_tankgod", "on");
		setcvar("debug_tankpaths", "on");
		setcvar("debug_tankspawners", "on");
		setcvar("debug_tankdriveall", "off");
	}
	
	level.fireydeath = loadfx ("fx/fire/pathfinder_extreme.efx");
	
	maps\_tank_gmi::main();
	
	getonramps();
	
	level.resumespeed = 10;
	level.turretfiretime = 1;
	
	// player tank setup
	playertank = getent("player_tank","targetname");
	playertank maps\_t34_gmi::init_player();
	playertank thread maps\_tankgun_gmi::mginit();
	playertank.ismoving = 1;
	level.playertank = playertank;

	//thread tankkilledmessage();

	level.playertank thread maps\_treads_gmi::main();
	
	if(getcvar("debug_notank") == "off")
		playertank useby(level.player);

	//give health to the player when he's damaged by radius damage also kills him when tank blows up
	level.player thread regen(playertank);
	playertank thread tank_hud();  // also does regen
	
	trigger_thinks(); // sets .triggeredthing flag so the guys don't start shooting untill notified
	trigger_spawners();
	trigger_spawnersarray();
	trigger_focusfirearray();
	trigger_moveenemy();
	trigger_moveenemyarray();
	trigger_attacktarget();
	trigger_reenforcements();
	trigger_reenforcements_clear();
	trigger_turrethint();
	trigger_minefields();
	trigger_guyexploder();
	trigger_gates();
	trigger_scattertriggers_setup();
	trigger_setup_panzerfaustguys();
	trigger_neutral_tank_spawner();
	trigger_delete_tanks();
	trigger_delete_tanks_neutral();
	trigger_delete_ai();

	// map boundry warning guy in tank says "that's not the way to our objective" in some cool way
	thread wrongwaymessages();

	//tanks setup for tanks who aren't spawned
	tanks = getentarray("script_vehicle","classname");
	for(i=0;i<tanks.size;i++)
	{
		if(isdefined(tanks[i].script_team))
		{
			if (tanks[i].vehicletype == "GermanFordTruck")
				continue;
			if(tanks[i].script_team == "enemy")
			{
				tanks[i] maps\_tank_gmi::setteam("axis");
				if ( (isdefined (tanks[i].script_noteworthy)) && (tanks[i].script_noteworthy == "panzeriv") )
					tanks[i] maps\_panzeriv_gmi::init();
				else
					tanks[i] maps\_tiger_gmi::init();
				tanks[i] thread enemy_tanks_think();
			}
			if(tanks[i].script_team == "friendly")
			{
				tanks[i] maps\_tank_gmi::setteam("allies");
				tanks[i] maps\_t34_gmi::init_friendly();
				tanks[i] thread friendly_tanks_think(introscreen);  //introscreen keeps friendlies from taking off early
			}
			if(tanks[i].script_team == "neutral")
			{
				tanks[i] maps\_tank_gmi::setteam("neutral");
				if ( (isdefined (tanks[i].script_noteworthy)) && (tanks[i].script_noteworthy == "panzeriv") )
					tanks[i] maps\_panzeriv_gmi::init_noattack();
				else
					tanks[i] maps\_tiger_gmi::init_noattack();
				tanks[i] thread neutral_tanks_think();  //introscreen keeps friendlies from taking off early
			}
		}
		else
		{
			if(!(tanks[i].targetname == "player_tank"))
				println("tank without a team at ", tanks[i].origin);
		}
	}

}

trigger_moveenemyarray()
{
	triggers = getentarray("moveenemyarray","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_moveenemyarray_relay();
}

trigger_moveenemyarray_relay()
{
	relays = getentarray(self.target,"targetname");

	for(i=0;i<relays.size;i++)
		thread trigger_moveenemys_wait(relays[i]);
}

trigger_moveenemy()
{
	triggers = getentarray("moveenemy","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_moveenemys_wait(triggers[i]);
}

trigger_moveenemys_wait(ent)
{
	if(!isdefined(ent.target))
	{
		println("no target found for ent at ",ent.origin);
		return;
	}
	self waittill ("trigger");
	tank = getent(ent.target, "targetname");
	if(isdefined (ent.script_delay))
		wait ent.script_delay;
	if (isdefined (tank))
		tank notify ("moveenemy");
}

tank_hud()
{
	level thread tank_hud_fireicon();
	
	self.healthbuffer = 2000;
	self.health += self.healthbuffer;
	self.maxhealth = self.health;
	basehealth = self.health;
	currenthealth = basehealth;
	height = 128;
	baseheight = height;
	minheight = 0;
	
	tankhud = newHudElem();
	tankhud setShader("gfx/hud/tankhudhealthbar", 32, height);
	tankhud.alignX = "right";
	tankhud.alignY = "bottom";
	tankhud.x = 635;
	tankhud.y = 450;
	
	tankhud2 = newHudElem();
	tankhud2 setShader("gfx/hud/tankhudback", 32, height);
	tankhud2.alignX = "right";
	tankhud2.alignY = "bottom";
	tankhud2.x = 635;
	tankhud2.y = 450;

	if (getcvar("debug_tankgod") != "off")
	while(1)
	{
		self waittill ("damage");
		self.health = basehealth;
	}
	
	while(self.health > 0)
	{
		x = (float) height;
		y = (float) baseheight;
		level.autosavehealth = x/y;
		
		self waittill ("damage",ammount,attacker);
		
		if((currenthealth - self.health) < 999)
			self.health = currenthealth;
		else
			currenthealth = self.health;
		if(!(self.health < self.healthbuffer))
			height = ((self.health - self.healthbuffer)*baseheight)/basehealth;
		else
			height = 0;
		if(height > minheight)
			tankhud setShader("gfx/hud/tankhudhealthbar", 32, height);
		else
		{
			tankhud setShader("gfx/hud/tankhudhealthbar", 32, minheight);
			break;
		}
		if(attacker != self && attacker != level.player)
		{
			//CHAD - USE ANOTHER SOUND HERE THAT ISN'T BRITISH
			//self playsound ("tankdrive_damaged","damaged",1);
		}
	}
	radiusDamage ( self.origin, 2, 10000, 9000);
	level.player DoDamage ( level.player.health + 50, (0,0,0) );
}

tank_hud_fireicon()
{
	level.fireicon = newHudElem();			
	level.fireicon.alignX = "center";
	level.fireicon.alignY = "middle";
	level.fireicon.x = 590;
	level.fireicon.y = 420;
	level.fireicon setShader("gfx/hud/hud@fire_ready_shell.tga", 64, 64);
	
	while (1)
	{
		level.fireicon.alpha = 1;
		level.playertank waittill ("turret_fire");
		level.fireicon.alpha = 0;
		wait .5;
		level.playertank playsound ("tank_reload");
		while (level.playertank isTurretReady() != true)
			wait .2;
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

		if(isdefined(attacker) && isdefined(attacker.script_team) && attacker.script_team == self.script_team
		|| isdefined(attacker) && self.script_team == "allies" && isdefined(attacker.targetname) && attacker.targetname == "player_tank"
		|| isdefined(self.script_team) && self.script_team == "allies" && attacker == level.player)
			self.health = currenthealth;
		else if((currenthealth - self.health) < 999)
			self.health = currenthealth;
		else
			currenthealth = self.health;
		if(self.health < healthbuffer)
			break;
	}
	if(isdefined(level.playertank))
	if(isdefined(attacker) && attacker == level.playertank && isdefined(self.script_team) && self.script_team == "axis")
		level notify ("tank shot by player");
	radiusDamage ( self.origin, 2, 10000, 9000);
}

splash_shield_friendliesintankdrivecountry()
{
	healthbuffer = 2000;
	self.health += healthbuffer;
	currenthealth = self.health;
	while(self.health > 0)
	{
		self waittill ("damage",amount, attacker);
		if ((isdefined (level.tankcommander)) && (level.tankcommander == self))
		{
			self.health = 10000;
		}
		else if ((isdefined (level.tanktalker)) && (level.tanktalker == self))
		{
			self.health = 10000;
		}
		else
		{
			if(isdefined(attacker) && isdefined(attacker.script_team) && attacker.script_team == self.script_team
			|| isdefined(attacker) && self.script_team == "allies" && isdefined(attacker.targetname) && attacker.targetname == "player_tank"
			|| isdefined(self.script_team) && self.script_team == "allies" && attacker == level.player || issentient(attacker))
				self.health = currenthealth;
			else if((currenthealth - self.health) < 999)
				self.health = currenthealth;
			else
				currenthealth = self.health;
			if(self.health < healthbuffer)
				break;
		}
	}
	if(isdefined(level.playertank))
	if(isdefined(attacker) && attacker == level.playertank && isdefined(self.script_team) && self.script_team == "axis")
		level notify ("tank shot by player");
	radiusDamage ( self.origin, 2, 10000, 9000);
}
regen(tank)
{
	self.health =  5000;
	while(isalive(self))
	{
		self waittill ("damage");
		if(tank.health <= 0)
			self DoDamage ( self.health + 50, (0,0,0) );
		else
			self.health = 5000;
	}
}

trigger_thinks()
{
	triggers = getentarray("thinktrigger","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_think(triggers[i]);

	trigarray = getentarray("thinktriggerarray","targetname");
	for(i=0;i<trigarray.size;i++)
	{
		targs = getentarray (trigarray[i].target,"targetname");
		for(j=0;j<targs.size;j++)
			trigarray[i] thread trigger_think(targs[j]);
	}


	//piggy back think stuff on moveenemy's with script_noteworthy thinktrigger
	movetrigs = getentarray("moveenemy","targetname");
	for(i=0;i<movetrigs.size;i++)
		if(isdefined(movetrigs[i].script_noteworthy) && movetrigs[i].script_noteworthy == "thinktrigger")
			movetrigs[i] thread trigger_think(movetrigs[i]);


	targs = undefined;

	//piggy back think stuff on moveenemyarray's with script_noteworthy thinktrigger
	arraytrigs = getentarray("moveenemyarray","targetname");
	for(i=0;i<arraytrigs.size;i++)
	{
		if(isdefined(arraytrigs[i].script_noteworthy) && arraytrigs[i].script_noteworthy == "thinktrigger")
		{
			targs = getentarray(arraytrigs[i].target,"targetname");
			for(j=0;j<targs.size;j++)
				arraytrigs[i] thread trigger_think(targs[j]);
		}
	}

}

trigger_think(ent)
{
	//if (!isdefined (ent.target))
	//	return;
	targtank = getent(ent.target,"targetname");
	targtank.triggeredthink = 1;
	if(!isdefined(targtank))
		return;
	self waittill ("trigger");
	targtank = getent(ent.target,"targetname");  //vehicle is deleted and respawned by this point got to get it again.
	if (!isdefined (targtank))
		return;
	if(isdefined (targtank.script_delay))
		wait targtank.script_delay;
	targtank notify ("triggeredthink",delay);
}

wrongwaymessages()
{
//	triggers = getentarray("wrongwaymessage","targetname");
	triggers = getentarray("trigger_multiple","classname");
	for(i=0;i<triggers.size;i++)
	{
		if((isdefined(triggers[i].script_noteworthy) && triggers[i].script_noteworthy == "wrongwaymessage")
			|| (isdefined(triggers[i].targetname) && triggers[i].targetname == "wrongwaymessage"))
			triggers[i] thread wrongwaymessage();
	}
}
wrongwaymessage()
{
	level.dontgotheremessage = 0;
	while(1)
	{
		self waittill ("trigger", other);
		if(!level.dontgotheremessage)
		{
			level.dontgotheremessage = 1;
			level.playertank playsound ("tankdrive_wrongway","sounddone",1);
			level.playertank waittill ("sounddone");
			level.dontgotheremessage = 0;
		}
			wait 5;

	}
}

enemy_tanks_think()
{
	level thread fireydeath(self);
	self endon ("death");
	if(getcvar ("debug_enemykillcomit") != "off")
		self thread draw_kill_comit();
	self.killcomit = 1;
//	thread maps\_tank_gmi::treads();
	self.startenemy = level.playertank;
	self thread splash_shield();
	path = nearestpath(self);
	if(!isdefined(path))
		return;
	self attachpath(path);
	self waittill ("moveenemy");
	
	self thread maps\_tank_gmi::avoidtank();


	self thread enemy_pathwaits(path);
	self gopath();
}

neutral_tanks_think()
{
	level thread fireydeath(self);
	self endon ("death");
	
	self thread splash_shield();
	path = nearestpath(self);
	if(!isdefined(path))
		return;
	self attachpath(path);
	self waittill ("moveenemy");
	
	self thread maps\_tank_gmi::avoidtank();

	self thread enemy_pathwaits(path);
	self gopath();
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
				self thread deathrollon();
			}
			else
			if(pathspot.script_noteworthy == "deathrolloff")
			{
				self setwaitnode(pathspot);
				self waittill("reached_wait_node");
				self thread deathrolloff();
			}
		}
		pathspot = path_next_inloop(pathspot);
	}
}

deathrollon()
{
	if(self.health > 0)
		self.rollingdeath = 1;
}

deathrolloff()
{
	self.rollingdeath = undefined;
	self notify("deathrolloff");
}


friendly_tanks_think(intro)
{
	if ( (isdefined (self.script_noteworthy)) && (self.script_noteworthy == "commander") && (!isdefined (level.tankcommander)) )
		level.tankcommander = self;
	if ( (isdefined (self.script_noteworthy)) && (self.script_noteworthy == "tanktalker") && (!isdefined (level.tanktalker)) )
		level.tanktalker = self;
	self.script_accuracy = 200;
	self addvehicletocompass();
//	thread maps\_tank_gmi::treads();
	thread splash_shield_friendliesintankdrivecountry();
	//level thread reenforcements_ondeath(self);
	path = nearestpath(self);
	if(!isdefined(path))
	{
		println("no path for friendly tank, doing nothing");
		return;
	}
	self attachpath(path);
	thread friendly_path_setup(path);

	if(isdefined(intro)) //introscreen keeps friendlies from taking off early
		level waittill ("starting final intro screen fadeout");
	
	self gopath();
}


friendly_path_wait_spots(path)
{
	friendwaits = getentarray("friendwait","targetname");
	for(i=0;i<friendwaits.size;i++)
	{
		flagged = friendwaits[i] friendly_path_flag();
		if(isdefined(flagged))
			friendwaits[i] thread friendly_path_wait(friendwaits[i]);
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

friendly_path_flag()
{
	if(isdefined(self.target))
		node = getvehiclenode(self.target,"targetname");
	else
	{
		println("no target on trigger at ", self.origin);
		return undefined;
	}
	if(isdefined(node))
		node.friendlywait = 1;
	else
	{
		println("trigger doesn't target vehiclenode at", self.origin);
		return undefined;
	}
	return 1;
}

friendly_path_wait(trig)
{
	self waittill("trigger");
	if (isdefined (self.script_noteworthy))
	{
		level notify (self.script_noteworthy + " friendwait triggered");
		while (!level.flags[self.script_noteworthy])
			wait 1;
		self waittill("trigger");
	}
	node = getvehiclenode(trig.target,"targetname");
	node.playerhasbeenhere = 1;
	node notify("playerishere");
}

gopath()
{
	if (isdefined (level.tankstartstopped))
	{
		level waittill ("level start tanks");
		level.tankstartstopped = undefined;
	}
	
	if(self.health > 0)
		self startpath();
	self.ismoving = 1;
}

friendly_pathwaits(path)
{
	pathspot = path;
	while(isdefined(pathspot))
	{
		if(isdefined(pathspot.friendlywait))
		{
			self setwaitnode(pathspot);
			self waittill("reached_wait_node");
			self thread waitforfriend(pathspot);
		}
		else
		if(isdefined(pathspot.script_noteworthy))
		if(pathspot.script_noteworthy == "deathrollon")
		{
			self setwaitnode(pathspot);
			self waittill("reached_wait_node");
			self thread deathrollon();
		}
		else
		if(pathspot.script_noteworthy == "deathrolloff")
		{
			self setwaitnode(pathspot);
			self waittill("reached_wait_node");
			self thread deathrolloff();
		}
		else
		if(pathspot.script_noteworthy == "detourwait")
		{
			self setwaitnode(pathspot);

			self waittill("reached_wait_node");


			if(isdefined(pathspot.detoured) && pathspot.detoured == 0)
			{

				self setswitchnode(pathspot.detourstart,pathspot.detourpath);
				pathspot.detoured = 1;
				thread friendly_path_setup(pathspot.detourpath);
				break;
			}

		}
		else
		if(pathspot.script_noteworthy == "pathexitswitch")
		{
			self setwaitnode(pathspot);
			self waittill("reached_wait_node");
			self setswitchnode(pathspot.startswitch,pathspot.endswitch);
			thread friendly_path_setup(pathspot.endswitch);
			break;
		}
		else
		if(pathspot.script_noteworthy == "passiveattack")
		{
			self setwaitnode(pathspot);
			self waittill("reached_wait_node");
			pathspot set_killcomit(self);
			self thread attack(pathspot);

		}

		pathspot = path_next_inloop(pathspot);
	}
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

waitforfriend(pathspot)
{
	if(!isdefined(pathspot.playerhasbeenhere))
	{
		self setspeed(0,15);
		pathspot waittill("playerishere");
		if(self.health > 0)
			self resumespeed(level.resumespeed);
	}
}

getspottargetingtank(shootspot)
{
	enemytanks = getentarray("script_vehicle","classname");
	for(i=0;i<enemytanks.size;i++)
	{

		if(isdefined(enemytanks[i].script_team) && enemytanks[i].script_team == "axis"
			&& isdefined(enemytanks[i].target) && enemytanks[i].target == shootspot.targetname)
			return enemytanks[i];

	}
	return  undefined;
}

/*
attacktarget(trigger,target)
{
	self endon ("death");
	self notify ("attackernow");
	if(!isdefined(target))
		return;
	target thread maps\_tank_gmi::queadd(self);
//	target.guyshootingatme = self;  //fightback
	if(!isdefined(trigger))
	{
		speed = 0;
	}
	else if(isdefined(trigger.script_speed))
	{
		speed = trigger.script_speed;
	}
	else
	{
		speed = 0;
	}

	self setspeed(speed,15);
	if(target.health > 0)
		self thread maps\_tank_gmi::queadd(target);
	self waittill ("turretidle");
	if(!isdefined(self.enemyque))
		self setTurretTargetEnt(self.idletarget, (0, 0, 64));
//	self thread setturretforward();
	self resumespeed(level.resumespeed);

}
*/


attack(trigger)
{
	if(!isalive(self))
		return;
	self endon ("death");
	self notify ("attackernow");
//	if(!isdefined(self.enemyque))
//		self queallenemies();
	if(!isdefined(self.enemyque))
		return;
	else
		target = self.enemyque[0];
	target thread maps\_tank_gmi::queadd(self);  //fight back
	if(!isdefined(trigger))
	{
		speed = 0;
	}
	else if(isdefined(trigger.script_speed))
	{
		speed = trigger.script_speed;
	}
	else
	{
		speed = 0;
	}
	self endon ("deadstop");
	self setspeed(speed,15);

	self waittill ("turretidle");
//	self thread setturretforward();
	self resumespeed(level.resumespeed);
}

vistarget()
{
	self waittill("turret_on_vistarget");
	self notify("attacknow", "vistarget");
}

deadtarget()
{
	target = self.targetenemy;
	target waittill("death");
	self notify("attacknow","deadtarget");
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

setturretforward()
{
	self endon ("death");
	count = 0;
	while(!isdefined(self.enemyque) && count < 8)
	{
		count++;
		vector = anglesToForward(self.angles);
		vector = maps\_utility_gmi::vectorMultiply(vector,8000);
		vector = self.origin + vector;
		self setTurretTargetVec(vector);
		wait .5;
	}
	if(!isdefined(self.enemyque))
		self clearTurretTarget();
}


trigger_spawnersarray()
{
	triggers = getentarray("tspawnerarray","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] trigger_spawnersarray_relay();
}

trigger_spawnersarray_relay()
{
	relays = getentarray(self.target,"targetname");
	delay = 0;
	for(i=0;i<relays.size;i++)
	{
		tank = getspawnertank(relays[i]);
		thread trigger_spawners_wait(relays[i],tank,delay);
		delay+=.05;
	}
}

getspawnertank(ent)
{
	if(!isdefined(ent.target))
	{
		println("no target found for ent at ",ent.origin);
		return;
	}
	tank = getent(ent.target,"targetname");
	if(!isdefined(tank))
	{
		spam();println("no tank");
		return;
	}
	maps\_vehiclespawn_gmi::spawner_setup(tank);
	return tank;
}



trigger_spawners()
{
	tspawners = getentarray("tspawner","targetname");
	for(i=0;i<tspawners.size;i++)
	{
		tank = getspawnertank(tspawners[i]);
		tspawners[i] thread trigger_spawners_wait(tspawners[i],tank);
	}
}

trigger_spawners_wait(ent,tank,delay)
{
	self waittill ("trigger");
	if(isdefined(delay))
		wait delay;
	vehicle = maps\_vehiclespawn_gmi::vehicle_spawn(ent.target);
	if(!isdefined(vehicle))
	{
//		if (getcvar("debug_tankspawners") != "off")
//		{
//			println("vehicle failed to spawn for entity ", ent.targetname);
//			println("ents target is ", ent.target);
//		}
		return;
	}
	//if(vehicle.vehicletype == "PanzerIV")
	//	vehicle thread enemy_tanks_think();
	if ( (vehicle.vehicletype == "tiger") || (vehicle.vehicletype == "PanzerIV") )
	{
		if ((isdefined (vehicle.script_team)) && (vehicle.script_team == "neutral"))
			vehicle thread neutral_tanks_think();
		else
			vehicle thread enemy_tanks_think();
	}
	else if(vehicle.vehicletype == "t34")
		vehicle thread friendly_tanks_think();
	else
	{
		spam();
		println("unhandled vehicletype",vehicle.vehicletype);
		spam();
	}

}

spam()
{
	println("*****_tankdrive******");
}

trigger_attacktarget()
{
	triggers = getentarray("fighter","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread trigger_attacktarget_wait();
	}
}

trigger_attacktarget_wait()
{
//	self endon ("death");
	while(1)
	{
		self waittill ("trigger",other);
		if(((isdefined (other.targetname)) && (other.targetname != "player_tank")) && isdefined(other.script_team) && other.script_team != "axis")
		{
			break;
		}
	}
	other endon("death");
	set_killcomit(other);

	if(isdefined(self.target))
		targ = getent(self.target,"targetname");
	else
	{
		other queallenemies();
	}

	if(isdefined(targ))
	{
		other thread maps\_tank_gmi::queadd(targ);
	}
	if(other.health > 0)
		other thread attack(self);
	else
	{
		spam();
		println("dead tank triggered attacktrigger");
	}

}

set_killcomit(tank)
{
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "passiveattack")
	{
//		if(getcvar("debug_passiveattackmsg") != "off")
//			iprintlnbold("passiveattackmsg");
		tank.killcomit = undefined;
	}
	else
		tank.killcomit = 1;
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
}

nearestonramp(endnode)
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
		return undefined;
	return theone;
}

friendly_path_detour_flag(path)
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

friendly_path_endnode_flag(path)
{

	count = 0;
	pathz = [];
	pathspot = path;
	while(isdefined(pathspot))
	{
		pathz[count] = pathspot;
		count++;
		thenode = pathspot;
		pathspot = path_next_inloop(pathspot);

	}

	if(!isdefined(thenode))
		println("thenode not defined");
	nextpath = nearestonramp(thenode);
	if(!isdefined(nextpath))
	{
//		if (getcvar("debug_tankpaths") != "off")
//			println("nextpath not defined for node at ",thenode.origin);
		return;

	}

	pathz[count-1].script_noteworthy = "pathexitswitch";
	pathz[count-1].startswitch = thenode;
	pathz[count-1].endswitch = nextpath;
}

friendly_path_setup(path)
{
	self notify ("newpath");
	friendly_path_detour_flag(path);
	friendly_path_endnode_flag(path);
	friendly_path_wait_spots(path);
	friendly_pathwaits(path);
}

trigger_focusfirearray()
{
	triggers = getentarray("focusfirearray","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_focusfirearray_wait();
}

trigger_focusfirearray_wait(ent)
{

	targs = getentarray(self.target,"targetname");

	self waittill ("trigger",other);

//	if (getcvar("debug_focusfiremessage") != "off")
//		iprintlnbold("focusfire happening");


	for(i=0;i<targs.size;i++)
	{
		tank = getent(targs[i].target,"targetname");
		if(isdefined(tank) && tank.health > 0)
			tank thread focusfire(other);
		tank = undefined;
	}
}

focusfire(target)
{
	self endon ("death");
	self endon ("deadstop");
	self setspeed (5,15);
	maps\_tank_gmi::queaddtofront(target);
	target waittill ("death");


	self resumespeed (level.resumespeed);

}

trigger_reenforcements()
{

	reofftrigs = getentarray("reenforcementoff","targetname");
	for(i=0;i<reofftrigs.size;i++)
	{
		reofftrigs[i] thread trigger_reenforcement_zone();

	}
	rentrigs = getentarray("reenforcement","targetname");
	for(i=0;i<rentrigs.size;i++)
	{
		rentrigs[i] thread trigger_reenforcements_wait();
	}

}

trigger_reenforcements_wait()
{
	while(1)
	{
		self waittill ("trigger",other);
		if(other.targetname != "player_tank" && !isdefined(other.reenforcement))
		{
			break;
		}
	}

//	if(getcvar("debug_tankspawners") != "off")
//		iprintlnbold("settingreenforcment");
	renontrig = getent(self.target,"targetname");
	if(!isdefined(renontrig))
	{
		spam();
		println("target undefined for trigger_reenforcement ", self getorigin());
		spam();
	}
	if(other.health > 0)
	{
		other.reenforcement = getrenforcement(renontrig);
		other.rentrigger = renontrig;
	}

	else
	{
		spam();
		println("dead tank triggered reenforcement trigger");
	}
	self delete();

}

getrenforcement(zoneontrig)
{
	orgs = getentarray(zoneontrig.target,"targetname");
	for(i=0;i<orgs.size;i++)
	{
		target = orgs[i].target;
		orgs[i] delete();
		return target;
	}


}

trigger_reenforcement_zone()
{
	zoneontrig = getent (self.target,"targetname");
	zoneontrig.zoneon = 0;

	spawnorgs = getentarray(zoneontrig.target,"targetname");
	for(i=0;i<spawnorgs.size;i++)
	{
		if(isdefined(spawnorgs[i].target))
			tank = getent(spawnorgs[i].target,"targetname");
		else
		{
			spam();println("no .target on script origin at ",spawnorgs[i].origin);
		}

		if(isdefined(tank))
			maps\_vehiclespawn_gmi::spawner_setup(tank);
		else
		{
			spam();spam();
			println("notank !! for spawnorg at ", spawnorgs[i].origin);
		}
	}

	while(1)
	{
		zoneontrig waittill ("trigger");
		zoneontrig.zoneon = 1;
		self waittill ("trigger");
		zoneontrig.zoneon = 0;
	}


}

reenforcements_ondeath(tank)
{
	tank waittill ("death");
	if(!isdefined(tank.reenforcement))
	{
		println("no tank.reenforcement for tank at ", tank getorigin());
		return;
	}
	else
	{
		reenforcement = tank.reenforcement;
	}

	trig = tank.rentrigger get_renforcement_runto_trigger();
	if(isdefined(tank.rentrigger) && tank.rentrigger.zoneon == 0)
	{
		trig = tank.rentrigger get_renforcement_runto_trigger();
		tank.rentrigger waittill ("trigger");
	}
	vehicle = maps\_vehiclespawn_gmi::vehicle_spawn(reenforcement);
	vehicle thread friendly_tanks_think();

	vehicle setspeed(100,40);
	vehicle reen_haulassendtrig(trig);
	vehicle resumespeed(80);


}

draw_kill_comit()
{
	self endon ("death");
	while(self.health > 0)
	{
		if(isdefined (self.killcomit))
			thing = 1;
		else
			thing = 0;
		print3d(self.origin + (0,0,-16),"kill_comit"+thing,(0,1,0),1);
		//print3d (self.origin + (offset), id+num, color, 1);
		waitframe();
	}
}

waitframe()
{
	maps\_spawner_gmi::waitframe();
}

tankgod()
{
	while(1)
	{
		self waittill ("damage");
		self.health = 2000;
	}
}

queallenemies()
{
	tanks = level.tanks;
	for(i=0;i<tanks.size;i++)
	{
		if(self == level.playertank)
		{
			return;
		}
		if(isdefined(tanks[i].script_team) && tanks[i].script_team != self.script_team)
			self maps\_tank_gmi::queadd(tanks[i]);
	}
}

get_renforcement_runto_trigger()
{
	triggers = getentarray("reenforcemenrunto","targetname");
	for(i=0;i<triggers.size;i++)
	{
		if(triggers[i].target == self.targetname)
		{
			return triggers[i];
		}

	}
	spam();
	println("NO trigger for reenforcement guys to drive to for trigger at ", self getorigin() );
	spam();
}

reen_haulassendtrig(trig)
{
	while(1)
	{
		trig waittill ("trigger",other);
		if(other == self)
		{
			break;
		}
	}
	return;

}

trigger_reenforcements_clear()
{
	cleartrigs = getentarray("reenforecmentclear","targetname");
	for(i=0;i<cleartrigs.size;i++)
	{
		cleartrigs[i] thread trigger_reenforcements_clear_wait();
	}
}

trigger_reenforcements_clear_wait()
{
	while(1)
	{
		self waittill ("trigger",other);
		other.reenforcement = undefined;

	}

}

trigger_turrethint()
{
	turrethinttrig = getentarray("turrethint","targetname");
	for(i=0;i<turrethinttrig.size;i++)
	{
		turrethinttrig[i] thread trigger_turrethint_wait();
	}
}

trigger_turrethint_wait()
{
	target = getentarray(self.target,"targetname");
	if ( (!isdefined (target)) || (!isdefined(target[0])) )
	{
		println("target not defined for trigger at ", self getorigin());
	}
	while(1)
	{
		self waittill ("trigger",other);
		if(other.health > 0)
		{
			if (other.classname != "script_vehicle")
				continue;
			if(!isdefined(other.enemyque))
			{
				other.idletarget = target[randomint(target.size)];
				other setTurretTargetEnt(other.idletarget, (0, 0, 64));
			}
		}
	}
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

trigger_enemy_spotterarray()
{
	if(!isdefined(self.script_noteworthy))
		return;
	self waittill ("trigger");
	ents = getentarray(self.target,"targetname");
	for(i=0;i<ents.size;i++)
	{
		targ = getent(ents[i].target,"targetname");
		if(isdefined(targ))
		{
			thread messager(self.script_noteworthy);
			return;
		}
	}
}
trigger_enemy_spotter()
{
	self waittill ("trigger");
//	if(isdefined(self.target))
	targ = getent(self.target,"targetname");
	if(!isdefined(targ))
		return;
	if(!isdefined(self.script_noteworthy))
		return;
	thread messager(self.script_noteworthy);


}

messager(note)
{
	if(note == "east")
		message = "tankdrive_sighted_east";
	else
	if(note == "west")
		message = "tankdrive_sighted_west";
	else
	if(note == "north")
		message = "tankdrive_sighted_north";
	else
	if(note == "south")
		message = "tankdrive_sighted_south";
	else
	if(note == "stream")
	{
		if ( (isdefined (level.tankskilled)) && (level.tankskilled < 3) )
			message = "tankdrive_sighted_stream";
		else
			return;//friendlies killed the tanks already, dont give this dialogue
	}
	else
	if(note == "german")
		message = "tankdrive_sighted_german";
	else
	if(note == "panzer")
		message = "tankdrive_sighted_panzer";
	else
	if(note == "tiger")
		message = "tankdrive_sighted_tiger";

	level.playertank thread sounder(message);
}

sounder(message)
{
	self playsound(message,"sounder",1);
}

tankkilledmessage()
{
	while(1)
	{
		level waittill ("tank shot by player");
		level.playertank playsound ("tankdrive_kill","killmessage",1);

	}

}


trigger_gates()
{
	return;
	gates = getentarray("gateway","targetname");
	for(i=0;i<gates.size;i++)
	{
		gates[i] thread trigger_gates_wait();
	}
}

trigger_gates_wait()
{
	friendlytanks = [];
	while(1)
	{
		self waittill ("trigger",other);
		friendlytanks = getfriendlytankarray();
		while(other istouching(self))
		{
			for(i=0;i<friendlytanks.size;i++)
			{
				if(friendlytanks[i] istouching(self))
					thread gatewait(friendlytanks[i]);
			}
			waitframe();

		}
		self notify ("all clear");


	}
}
gatewait(tank)
{

	if(isalive(tank) && isdefined(tank.waiting) && tank.waiting != 1)
	{
		tank setspeed (0,50);
		tank.waiting = 1;
	}
	else
		return;
	self waittill ("all clear");
	if(isalive(tank))
	{
		tank resumespeed(15);
		tank.waiting = 0;

	}
}

getfriendlytankarray()
{
	tanks = [];
	for(i=0;i<level.tanks.size;i++)
	{
		if(isdefined(level.tanks[i].script_team) && level.tanks[i].script_team == "allies")
			tanks[tanks.size] = level.tanks[i];
	}
	if(tanks.size > 0)
		return tanks;

}

trigger_guyexploder()
{
	triggers = getentarray("guyexploder","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread trigger_guyexploder_wait();
	}
}

trigger_guyexploder_wait()
{
	while(1)
	{
		self waittill ("trigger",other);
		if(other ==level.playertank)
			break;
	}
	targ = getent(self.target,"targetname");
	if(isdefined(targ))
	{
		targ notify ("trigger");
	}
}

bigsplash()
{
	self endon ("death");
	self.bigsplashed = 1;
	self waittill ("treadtypechanged");
	self.bigsplashed = 0;
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

trigger_scattertriggers_setup()
{
	trigger = getentarray("scattertrigger","targetname");
	for(i=0;i<trigger.size;i++)
	{
		trigger[i] thread trigger_scattertriggers_wait();
	}
}

trigger_scattertriggers_wait()
{
	if (!isdefined (self.target))
		return;
	target = getent(self.target,"targetname");
	if ( (!isdefined (target)) || (!isdefined (target.target)) )
		return;
	nodes = getnodearray(target.target,"targetname");
	if (!isdefined (nodes))
		return;

	self waittill ("trigger");
	guys = getaiarray("axis");
	nodecycle = 0;
	for(i=0;i<guys.size;i++)
	{
		if(guys[i] istouching(target))
		{
			if ( (isdefined (guys[i].script_noteworthy)) && ( (guys[i].script_noteworthy == "dontscatter") || (guys[i].script_noteworthy == "panzerfaust") ) )
				continue;
			guys[i] notify ("scatter");
			node = nodes[nodecycle];
			nodecycle++;
			if(nodecycle>=nodes.size)
				nodecycle = 0;
			guys[i].goalradius = 32;
			guys[i] thread scattertriggers_chain(node);
			node = undefined;
		}
	}
}

scattertriggers_chain(node)
{
	self endon ("death");
	nextnode = node;
	while (1)
	{
		self setgoalnode (nextnode);
		self waittill ("goal");
		if (isdefined (nextnode.target))
		{
			if (!isdefined (nextnode.target))
			{
				self delete();
				return;
			}
			temp = getnode (nextnode.target,"targetname");
			nextnode = temp;
			temp = undefined;
		}
	}
}

trigger_setup_panzerfaustguys()
{
	triggers = getentarray("panzerfaustguys","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i].originalTarget = triggers[i].target;
		triggers[i].target = "null";
		triggers[i] thread trigger_panzerfaustguys();
	}
}

trigger_panzerfaustguys()
{
	spawners = getentarray(self.originalTarget,"targetname");
	if (!isdefined (spawners))
		return;
	self waittill ("trigger");
	for(i=0;i<spawners.size;i++)
	{
		if (!isdefined (spawners[i].target))
		{
			spawned = spawners[i] dospawn();
			if (isdefined (spawned))
				spawned setgoalentity (level.player);
		}
		else
		{
			spawners[i].originalTarget = spawners[i].target;
			spawners[i].target = "null";
			firstnode = getnode (spawners[i].originalTarget,"targetname");
			spawned = spawners[i] dospawn();
			if (isdefined (spawned))
			{
				if (isdefined (firstnode))
					spawned thread trigger_panzerfaustguys_chain(firstnode);
				else
					spawned thread trigger_panzerfaustguys_chain();
			}
		}
	}
}

trigger_panzerfaustguys_chain(node)
{
	if (!isdefined (node))
	{
		self setgoalentity (level.player);
		return;
	}
	self endon ("death");
	nextnode = node;
	while (1)
	{
		self setgoalnode (nextnode);
		self waittill ("goal");
		if ( (isdefined (nextnode.script_noteworthy)) && (nextnode.script_noteworthy == "attackplayer") )
		{
			self setgoalentity (level.player);
			return;
		}
		if (isdefined (nextnode.target))
		{
			if (!isdefined (nextnode.target))
				return;
			temp = getnode (nextnode.target,"targetname");
			nextnode = temp;
			if (!isdefined (nextnode))
				return;
			temp = undefined;
		}
	}
}

trigger_neutral_tank_spawner()
{
	triggers = getentarray("neutral_tank_spawner","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_neutral_tank_spawner_wait();
}

trigger_neutral_tank_spawner_wait()
{
	gotrigger = getent (self.target,"targetname");
	origins = getentarray (gotrigger.target,"targetname");
	self waittill ("trigger");
	for (i=0;i<origins.size;i++)
	{
		if ( (isdefined (self.script_noteworthy)) && (self.script_noteworthy == "panzeriv") )
		{
			vehicle = spawnVehicle("xmodel/vehicle_tank_panzeriv", "neutral_tank", "tiger", origins[i].origin, (0,0,0));
			vehicle.script_noteworthy = "panzeriv";
		}
		else
			vehicle = spawnVehicle("xmodel/vehicle_tank_tiger", "neutral_tank", "tiger", origins[i].origin, (0,0,0));
		vehicle thread trigger_neutral_tank_spawner_think(gotrigger);
	}
}

trigger_neutral_tank_spawner_think(gotrigger)
{
	if ( (isdefined (self.script_noteworthy)) && (self.script_noteworthy == "panzeriv") )
		self thread maps\_panzeriv_gmi::init_noattack();
	else
		self thread maps\_tiger_gmi::init_noattack();
	path = nearestpath(self);
	if(!isdefined(path))
		return;
	self attachpath(path);
	self thread maps\_tank_gmi::avoidtank();
	
	gotrigger waittill ("trigger");
	
	self thread gopath();
}

trigger_delete_tanks()
{
	triggers = getentarray("tank_remover","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_delete_tanks_wait();
}

trigger_delete_tanks_wait()
{
	/*
	area = getent (self.target,"targetname");
	self waittill ("trigger");
	
	for (i=0;i<level.tanks.size;i++)
	{
		if (!isalive (level.tanks[i]))
			continue;
		if (!isdefined (level.tanks[i].script_team))
			continue;
		if ( (level.tanks[i].script_team == "allies") || (level.tanks[i].script_team == "friend") )
			continue;
		if (level.tanks[i] istouching (area))
		{
			level.tanks[i].nospawning = true;
			level.tanks[i] notify ("death");
		}
	}
	*/
}

trigger_delete_tanks_neutral()
{
	triggers = getentarray("neutral_tank_remover","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_delete_tanks_neutral_wait();
}

trigger_delete_tanks_neutral_wait()
{
	self waittill ("trigger");
	
	for (i=0;i<level.tanks.size;i++)
	{
		if (!isdefined (level.tanks[i]))
			continue;
		if (isdefined (level.tanks[i].dead))
			continue;
		if ( (isdefined (level.tanks[i].script_team)) && (level.tanks[i].script_team == "neutral") )
		{
			level.tanks[i].nospawning = true;
			level.tanks[i] notify ("death");
		}
	}
}

trigger_delete_ai()
{
	triggers = getentarray("ai_remover","targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread trigger_delete_ai_wait();
}

trigger_delete_ai_wait()
{
	area = getent (self.target,"targetname");
	self waittill ("trigger");
	ai = getaiarray();
	for (i=0;i<ai.size;i++)
	{
		if (!isalive (ai[i]))
			continue;
		if (ai[i] istouching (area))
			ai[i] delete();
	}
}