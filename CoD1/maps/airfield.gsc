#using_animtree ("generic_human");
main()
{
	maps\_stuka::main();  // precachestuka stuff
	maps\_truck::main();
	maps\_condor::main();
	maps\_music::main();
	level.nopanzersleft = true; // so waters doesn't go looking for panzerfausts
	axisspawners = getspawnerteamarray("axis");
	for(i=0;i<axisspawners.size;i++)
	{
		axisspawners[i] thread accuracylower();
	}

	maps\truckride::watersandpricesetup();
	if (getcvar("debug_vclogin") == "")
		setcvar("debug_vclogin", "off");
	if (getcvar("planetest") == "")
		setcvar("planetest", "off");
//	level.truckshield = 1;  //in _truck.gsc puts regen on trucks so they don't die to bullets

	count = 0;
	level.planes = [];
	planes = [];
	vehicles = getentarray("script_vehicle","classname");
	for(i=0;i<vehicles.size;i++)
	{
		if(vehicles[i].model == "xmodel/vehicle_plane_stuka")
		{
			size = planes.size;
			planes[size]["targetname"] = vehicles[i].targetname;
			if(isdefined(vehicles[i].script_sound))
				planes[size]["sound"] = vehicles[i].script_sound;
			println("sound on plane" + planes[size]["targetname"] + "is" ,vehicles[i].script_sound);

		}
		if(isdefined(vehicles[i].script_vehiclegroup))
		{
			if(!isdefined(level.planes[vehicles[i].script_vehiclegroup]))
			{
				size = 0;
			}
			else
			{
				size = level.planes[vehicles[i].script_vehiclegroup].size;
			}
			level.planes[vehicles[i].script_vehiclegroup][size] = vehicles[i].targetname;

			if(isdefined(vehicles[i].script_delay))
				level.planesdelay[vehicles[i].script_vehiclegroup][size] = vehicles[i].script_delay;
			else
				level.planesdelay[vehicles[i].script_vehiclegroup][size] = 0;
		}

	}




	if(getcvar("debug_vclogin") != "off")
		planepathsoff();
//	thread countai();

	vehicles = getentarray("script_vehicle","classname");
	for(i=0;i<vehicles.size;i++)
	{
		if(isdefined(vehicles[i].script_team))
		{
			if(!(isdefined(vehicles[i].targetname) && vehicles[i].targetname == "player_vehicle"))
				maps\_vehiclespawn::spawner_setup(vehicles[i]);
		}
	}

	if (getcvar("planetest") != "off")
	{
		maps\_load::main();
		maps\airfield_anim::main();
		maps\airfield_sound::main();
		planetest(planes);
	}

	thread objectives();
	thread balconyguys();
	thread reenforceguys();
	thread gettoactiontrig();
	thread trigger_scattertriggers_setup();
	thread trigger_standtrigger_setup();
	thread trigger_boxblow();

	thread maps\truckride::playerkiller();
	thread dropthebombs();

	ambientPlay("ambient_airfield");

	///////////////////main////////////
	maps\_load::main();
	maps\airfield_anim::main();
	maps\airfield_sound::main();
	///////////////////main////////////
	maps\airfield_fx::main();
	maps\_treadfx::main();



	maps\_utility::precache("xmodel/gib_metalplate"); //where in the world this came from I don't know stupid thing don't annoy me


	flak = getent("flak1","targetname"); //maybe give it a better name?

	flak maps\_flakvierling::init();
	level.player takeallweapons();
	level.player giveWeapon("bren");
	level.player giveweapon("colt");

	level.player giveweapon ("panzerfaust");
	level.player takeweapon ("panzerfaust");
	level.player switchtoweapon("bren");

//	setExpFog(.000013, 0.1, 0.23, 0.5, 0);
//	setExpFog(.000014, 0.35, 0.36, 0.49, 0);
	setExpFog(.0000144, 0.5, 0.52, 0.70, 0);
	truck = getent("player_vehicle","targetname");
	level.player setorigin ((truck getTagOrigin ("tag_player")));
	level.player playerlinkto (truck, "tag_player", ( 0.1, .6, 0.9 ),(0,0,0));

	maps\_vehiclechase::main();
	truck thread driversetup();


	level.nowatersstartsequence = 1;
	maps\_truckridewaters::main();
	
	if (getcvarint("g_gameskill") == 0)
		thread spawn_health();
	
	truck thread setuptruck();  // animates crates into position

	thread towerguys();
	thread gatebreak(truck);
//	truck thread jolttest();
	truck thread regen();
	level.specialtruck = truck;

	truck thread maps\_treads::main();
	truck thread waitstart();

	truck thread getoutatunload();

//	setcvar("start","gunstart");
	if(getcvar("start") == "gunstart")
	{
		startorg = getent("gunstart","targetname");
		level.player setorigin(startorg.origin);
	}
	wait .05;
	level thread airfield_music();

	wait 2;
	truck thread watersdostuff();
	truck notify ("buddyevent","airfieldintro");
//	level.waters thread threadwaitsay("airfield_waters_comingupairfield",1);

	thread saystuffforfirsttruck();

	wait 1;
	level.price thread maps\_utility::magic_bullet_shield();
	
	thread stuka_special_deaths();
}

stuka_special_deaths()
{
	planes = [];
	planes[planes.size] = getent ("auto2987","targetname");
	planes[planes.size] = getent ("auto2988","targetname");
	planes[planes.size] = getent ("auto2989","targetname");
	planes[planes.size] = getent ("auto2990","targetname");
	println ("^2PLANES FOUND: " + planes.size);
}

stuka_special_deaths_wait()
{
	self waittill ("death");
	println ("^2SPECIAL STUKA DIED");
	wait 5;
	println ("^2SPECIAL STUKA - SETTING THIRD MODEL");
	if (isdefined (self))
		self setmodel ("xmodel/vehicle_plane_stuka_d");
	
}

airfield_music()
{
	musicplay("airfield_main");
	wait level.musiclength["airfield_main"];
	musicplay("airfield_loop");
	level waittill ("inthetruck");
	musicStop();
	musicplay("airfield_escape");
}

spawn_health()
{
	health = spawn("item_health", (-7370, 18332, -840));
	health2 = spawn("item_health", (-7378, 18316, -840));
	wait 5;
	health.origin = (-7370, 18332, -840);
	health2.origin = (-7378, 18316, -840);
}

waitstart()
{
	self thread maps\_vehiclechase::start();
}

plane_spawn(strplane,delay)
{
	if(isdefined(delay))
		wait delay;
	vehicle = maps\_vehiclespawn::vehicle_spawn(strplane);
	vehicle.ismoving = 0;
	vehicle maps\_vehiclechase::getonpath();
	vehicle maps\_vehiclechase::enemy_chaser();

	if(isdefined(vehicle.script_sound))
	{
		if(isdefined(level.airfieldsounddelay[vehicle.script_sound]))
			wait(level.airfieldsounddelay[vehicle.script_sound]);
		if(isdefined(level.airfieldsound[vehicle.script_sound]) && vehicle.health > 0)
			vehicle playsound (level.airfieldsound[vehicle.script_sound]);
	}
}


driversetup()
{
	driverspawner = getent("driver","targetname");
	driverspawner.origin = self.origin + (128,52,96);
	driver = driverspawner dospawn();
	level.price = driver;
	if(isdefined(driver))
		self notify ("guyenters", driver);  //put the driver in the truck
}

startsequence(guy)
{
	level.player takeallweapons();

}


jolttest()
{
	while(1)
	{
		while(self.speed > 200)
		{
			wait randomfloat(0.2)+(0.3);
			self joltbody((self.origin + (0,0,64)),.4);
		}
		waitframe();
	}

}

regen()
{
	self endon ("death");
	self.health = 6000;
	health = self.health;
	while(1)
	{
		self waittill( "damage");
		waitframe();
		self.health = health;
	}
}

waitframe()
{
	maps\_spawner::waitframe();
}

getoutatunload()
{
	blocker = getentarray("blocker1","targetname");
	for (i=0;i<blocker.size;i++)
		blocker[i] notsolid();
	truckstop = getent("truckstop","targetname");
	truckstop waittill ("trigger");
	level notify ("gettoaction");
	self waittill ("hardstop");
	
	self joltbody((self.origin + (0,0,64)),.5);
	self disconnectpaths();
	
	thread doorguy1();
	
	for (i=0;i<blocker.size;i++)
		blocker[i] solid();
	node = getnode("watersmg42","targetname");
	
	self notify ("buddypain");
	
	level.waters.jumpout = %airfield_waters_jumpout;
	level.waters.jumpin = %airfield_waters_climbin;
	
	println("self.angles = ",self.angles);
	println("self.origin = ",self.origin);
	
	self notify ("buddyevent","jumpout");
	self disconnectpaths();
	
	thread waitunlink(1.4);
	thread jointhefunprice(level.price);  //join the fun later haahhah
	level.waters waittill ("jumpedout");
	
	level.waters maps\_spawner::go_to_node(node);
	truck = maps\_vehiclechase::spawnvehiclegroup("spawningtruck1");
	truck maps\_vehiclechase::enemy_chaser();
	truck thread gotoactionwhenpathisdone();
	
	truck = undefined;
	level.waters thread maps\_spawner::go_to_node(node);
	
	wait 7; //~time it used to take go_to_node to finish before it was threaded (trying to sync music)
	
	wait 5;
	level.waters thread threadwaitsay("airfield_waters_lightupstukas",2,"lightupstukas");
	
	level.waters maps\_spawner::go_to_node(node);
	truck = maps\_vehiclechase::spawnvehiclegroup("spawningtruck2");
	truck maps\_vehiclechase::enemy_chaser();
	truck thread gotoactionwhenpathisdone();
	wait 15;
	thread turretattackers();
	
	wait 6;
	
	level waittill ("turretattackersdone");
	level notify ("stopreenforce");
	
	friendplane = getent("friendlyplane","targetname");
	friendplane show();
	friendplane maps\_condor::init();
	friendplane thread missionfailed_on_condordeath();
	path = maps\_vehiclechase::latch_to_nearestpath(friendplane);
	friendplane attachpath(path);
	friendplane thread maps\_vehiclechase::gopath();
	iprintlnbold(&"AIRFIELD_DONTSHOOTCONDOR");
	level.waters thread threadwaitsay("airfield_waters_dontshootplane",1,"dontshoot");
	level.waters thread threadwaitsay("airfield_waters_outoftime",0,"saybackinthetruck","dontshoot");
	
	wait 5;
	
	level.price thread threadwaitsay("airfield_price_planeisready",3);
	
	thread watersgetbackin();
	level notify ("backinthetruck");
	level notify ("distraction");  // objective update
	truckintrig = getent("truckgetin","targetname");
	thread hinttotruck();
	truckintrig waittill ("trigger");
	targ = getent(truckintrig.target,"targetname");
	moverorg = spawn("script_origin",level.player.origin);
	moverorg.angles = level.player.angles;
	level.player linkto (moverorg);
	movetime = (1.0/100.0)*(float)(distance(level.player.origin,targ.origin)); //move at 100 units per second
	println("movetime is ",movetime);
	moverorg moveTo(targ.origin, movetime, 0, 0);
	moverorg waittill ("movedone");
	tagorg = self getTagOrigin("tag_player");
	moverorg moveTo(tagorg, 1, 0, 0);
	moverorg waittill ("movedone");
	tagorg = self getTagOrigin("tag_player");
	level.player setorigin ((self getTagOrigin ("tag_player")));
	level.player playerlinkto (self, "tag_player", ( 0.1, .6, 0.9 ));
	level notify ("inthetruck"); // objectivepointer to condor
	
	if(level.watersin != 1)
		level waittill ("watersin");
	if(level.pricein != 1)
		level waittill ("pricein");
	level.waters thread threadwaitsay("airfield_waters_blimeybeauty",4,"beauty");

	self resumespeed (15);
	self waittill ("unload");
	level notify ("at condor");
	level.player unlink();
	musicStop(2);
	level.player.ignoreme = true;
	if (isalive (level.waters))
		level.waters.ignoreme = true;
	if (isalive (level.price))
		level.price.ignoreme = true;
	wait 2;
	if (isalive (level.player))
		missionsuccess("ship",false);
}
waitunlink(time)
{
	wait(time);
	level.player unlink();

}

jointhefunprice(guy)
{


	jumpoutanim = %germantruck_driver_climbout;
	jumpinanim = %germantruck_driver_climbin;

	guy.hasweapon = true;
	guy animscripts\shared::PutGunInHand("right");
	maps\_truckridewaters::animontag(guy, "tag_driver", jumpoutanim);
	thread maps\_truck::jumpoutdoor();
	level.pricein = 0;
	level.price unlink();
	node = getnode("pricenode","targetname");
	guy setgoalnode(node);
	guy.goalradius = 32;

	level waittill ("backinthetruck");

	org = self gettagOrigin ("tag_driver");
	angles = self gettagAngles ("tag_driver");
	guy setgoalpos(org);
	guy.goalradius = 32;
	maps\_truckridewaters::animontag(guy, "tag_driver", jumpinanim);
	guy.hasweapon = false;
	guy animscripts\shared::PutGunInHand("none");
	level.price linkto(self,"tag_driver");

	thread maps\_truck::driver_idle(guy);
	level.pricein = 1;
	level notify ("pricein");

}

watersgetbackin()
{
	level.watersin = 0;
	tagang = self gettagangles(level.waters.sittag);
	tagorg = self getTagOrigin(level.waters.sittag);
	level.waters.jumpin = %airfield_waters_climbin;
	org = getstartorigin (tagorg,tagang,%truckride_waters_climbin);
	level.waters.goalradius = 32;
	level.waters maps\_spawner::friendly_mg42_stop_use();
	level.waters setgoalpos (org);
	level.waters waittill ("goal");
	wait .5;
	self notify("buddyevent","jumpin");
	level.waters waittill ("jumpedin");
	level.waters linkto(self,level.waters.sittag);
	level.watersin = 1;
	level notify ("watersin");
}

drawtag(tag)
{
	while(1)
	{
		print3d(self gettagorigin(tag),"i",(1,1,1),1,1);
		waitframe();
	}
}


gatebreak(truck)
{

	gate = getent("gate","targetname");
	gate waittill ("trigger");
	gateorg = gate getorigin();
	truck  joltbody((gateorg + (0,0,64)),.8);
	truck playsound("Crash_wood");


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
	target = getent(self.target,"targetname");
	nodes = getnodearray(target.target,"targetname");

	self waittill ("trigger");
	guys = getaiarray("axis");
	nodecycle = 0;
	for(i=0;i<guys.size;i++)
	{
		if(guys[i] istouching(target))
		{
			node = nodes[nodecycle];
			nodecycle++;
			if(nodecycle>=nodes.size)
				nodecycle = 0;
			guys[i] setgoalnode (node);
			guys[i].goalradius = 32;
			node = undefined;
		}

	}
}

trigger_standtrigger_setup()
{
	triggers = getentarray("standtrigger","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread trigger_standtrigger_wait();
	}
}

trigger_standtrigger_wait()
{

	self waittill ("trigger");
	guys = getspawnerarray ();
	for(i=0;i<guys.size;i++)
	{
		if(isdefined(guys[i].targetname) && guys[i].targetname == self.target)
		{
			guys[i] thread spawnandstand();

		}

	}
}
spawnandstand()
{
	guy = self dospawn();
	if(isdefined(guy))
	{
		guy allowedstances("stand");
		guy.accuracy = .1;
	}

}


turretattackers()
{

	level.waters thread threadwaitsay("airfield_waters_divebombers",4,"saydivebomb");
	threeplanespawn();
	wait 18;
	thread balconyguysgo();
	wait 8;
	leftplanespawn();
	level.waters thread threadwaitsay("airfield_waters_keepstukasoff",4,"saystukasoff");
	wait 10;
	rightplanespawn();
	level.waters thread threadwaitsay("airfield_waters_lightupstukas",6,"lightupstukas");
	wait 17;
	thread balconyguysgo();

	wait 6;
	thread balconyguysgo();

	wait 8;
	threeplanespawn();
	level.price thread threadwaitsay("airfield_price_bloodystukas",3);

	wait 5;
	rightplanespawn();

	wait 17;
	if(getcvar("debug_vclogin") != "off")
	{
		for(i=0;i<10;i++)
		{
			wait 7;
			threeplanespawn();

		}
	}

	level notify ("turretattackersdone");
}

threeplanespawn()
{
	for(j=0;j<level.planes[1].size;j++)
	{
		thread plane_spawn(level.planes[1][j],level.planesdelay[1][j]);

	}
}

rightplanespawn()
{
	for(j=0;j<level.planes[8].size;j++)
	{
		thread plane_spawn(level.planes[8][j],level.planesdelay[8][j]);

	}
}

leftplanespawn()
{
	for(j=0;j<level.planes[9].size;j++)
	{
		thread plane_spawn(level.planes[9][j],level.planesdelay[9][j]);

	}
}

gettoactiontrig()
{
	trig = getent("gettoaction","targetname");
	trig waittill ("trigger");
	ai = getaiarray("axis");
	node = getnode(trig.target,"targetname");


	truck = getent("auto3038","targetname");
	if(isdefined(truck))
		truck delete();

	truck2 = getent("auto3091","targetname");
	if(isdefined(truck2))
		truck2 delete();

	plane = getent("friendlyplane","targetname");
	plane hide();

	level waittill ("gettoaction");





	ai2 = getaiarray("axis");
	count = ai2.size;
	for(i=0;i<ai.size;i++)
	{
//		if(count > 10)
//		{
//
//			if(isdefined(ai[i]) && isalive(ai[i]))
//				ai[i] delete();  // might want to do some sighttrace check or something because these guys might decide to give chase or something
//		}
//		else
		if(isdefined(ai[i]) && isalive(ai[i]))
		{
			ai[i] delete();
//			ai[i] allowedstances("crouch","prone","stand");
//			ai[i] setgoalnode (node);
//			ai[i].goalradius = 256;
//			ai[i] thread goalplayerwhenreached();
		}
	}
}

goalplayerwhenreached()
{
	self thread reenforce(); // yay for ghetto!
//	self waittill ("goal");
//	self.goalradius = 32;

}
reenforce()
{
	self.dropweapon = 0;
	self waittill ("death");
	ai = getaiarray("axis");
	if(ai.size > 7)
		return;
	level notify ("reenforce");
}


watersdostuff()
{

	level notify ("endstartsequence");
//	level.waters waittill ("buddyidle");
//	self notify ("buddyevent","idlenoammo");

//	wait 6;
//	level.waters waittill ("buddyidle");
//	self notify ("buddyevent","cower");
}

gotoactionwhenpathisdone()
{

	self waittill ("reached_end_node");
	trig = getent("gettoaction","targetname");
	ai = getaiarray("axis");
	node = getnode(trig.target,"targetname");
	for(i=0;i<ai.size;i++)
	{
		if(isdefined(ai[i].script_vehiclegroup) && ai[i].script_vehiclegroup == self.script_vehiclegroup)
		{
			ai[i] setgoalnode (node);
			ai[i].goalradius = 384;
			ai[i] thread goalplayerwhenreached();
		}
	}

}

towerguys()
{
	towerguys = getentarray ("towerguy","targetname");
	for(i=0;i<towerguys.size;i++)
	{
		towerguys[i] delete();
//		towerguys[i] allowedstances("stand");
//		towerguys[i].accuracy = .1;
//		towerguys[i].accuracystationarymod = .2;
	}
}



reenforceguys()
{
	level endon ("stopreenforce");
	level.cycle = 0;
	renforce = getentarray("renforcer","targetname");
	println("renforcer size is ",renforce.size);
	println("******");

	while(1)
	{
		level waittill ("reenforce");

		spawned = renforce[level.cycle] dospawn();
		if(isdefined(spawned))
			spawned thread reenforce();
		renforce[level.cycle].count = 1;
		level.cycle++;
		if(level.cycle >= renforce.size)
			level.cycle = 0;

	}


}

threadwaitsay(dialog,delay,eventnotify,waitevent)
{
	if(isdefined(waitevent))
		self waittill (waitevent);
	if(isdefined(delay))
		wait delay;
	self animscripts\face::sayspecificdialogue(level.scr_anim[dialog],dialog,1,eventnotify);
}


doorguy1()
{
	door = getent("door", "targetname");
	door rotateYaw(90, .2, .1, .1);
	door notsolid();
	door connectpaths();

	door waittill("rotatedone");


	doornode = getnode("doornode","targetname");

	spawner = getent("doorguy1","targetname");
	doorguy = spawner dospawn();
	doorguy.script_moveoverride = 1; //keeps _spawner.gsc from setting a goalradius
	doorguy.goalradius = 4;
	doorguy setgoalnode (doornode);


	wait 2;


	door rotateYaw(-90, .2, .1, .1);
	door waittill("rotatedone");
	door solid();


}

balconyguys()
{
	trig= getent("balconyaction","targetname");
	trig waittill ("trigger");
	maps\_utility::autosave(1);
	balconyguysgo();
}

balconyguysgo()
{
	balconyguys = getentarray("roofguys","targetname");
	balconyguys = maps\_utility::array_randomize(balconyguys);
	
	if (getcvarint("g_gameskill") == 0)
		balconyguys[balconyguys.size - 1] = undefined;
	
	for(i=0;i<balconyguys.size;i++)
	{
		balconyguys[i] thread spawnme();
		wait 4;
	}
}

spawnme()
{
	self.count = 1;
	guy = self dospawn();
	if(!isdefined(guy))
		return;
	guy.script_moveoverride = 1; //keeps _spawner.gsc from setting a goalradius
	guy.accuracy = .1;
	guy.goalradius = 32;
}









#using_animtree ("germantruck");

setuptruck()
{
	self UseAnimTree(#animtree);
	truckanim = %airfield_truck_start;
	self thread maps\_truckridewaters::truckanim(truckanim);
	for(i=0;i<self.pfmodel.size;i++)
	{
		level notify ("pfremove");  //removes panzerfaust from crates stuff in _truckridewaters.gsc
		waitframe();
	}
}

countai()
{
	while(1)
	{
		ai = getaiarray();
		println("ai size is ",ai.size);
		wait 1;
	}
}

planepathsoff()
{

	paths = getvehiclenodearray("crash_path","targetname");
	for(i=0;i<paths.size;i++)
	{
		paths[i].script_noteworthy = undefined;
	}
}

animateplayerout(delay)
{
	wait (delay);
	self UseAnimTree(#animtree);
	truckanim = %airfield_truck_playerout;
	if(isalive(level.player))
	{
		self setflaggedanimknobrestart("thing",truckanim);
		self waittill ("thing");
		level.player unlink();

	}

}


animateplayerin()
{
	self UseAnimTree(#animtree);
	truckanim = %airfield_truck_playerin;
	self setflaggedanimknobrestart("thing",truckanim);
	self waittill ("thing");
	level notify ("animateindone");
}



trigger_boxblow()
{
	boxblows = getentarray("boxblow","targetname");
	for(i=0;i<boxblows.size;i++)
	{
		boxblows[i] thread trigger_boxblow_wait();
	}
}

trigger_boxblow_wait()
{
	accdmg = 0;
	while(1)
	{
		self waittill ("damage",dmg);
		if(dmg > 280)
			break;
	}
	targ = getent(self.target,"targetname");
	maps\_utility::exploder(targ.script_exploder);

}

objectives()
{
	flak = getent("flak1","targetname");
	objective_add(1, "active", &"AIRFIELD_OBJ_PROVIDEDISTRACTION", flak.origin);
	objective_current(1);

	level waittill ("distraction");
	vehicle = getent("player_vehicle","targetname");
	objective_state(1, "done");
	objective_add(2, "active", &"AIRFIELD_OBJ_ESCAPEINCONDOR", vehicle.origin);
	objective_current(2);

	level waittill ("inthetruck");
	friendplane = getent("friendlyplane","targetname");
	objective_position(2, friendplane.origin);
	
	level waittill ("at condor");
	objective_state(2, "done");
}

accuracylower()
{
	self.script_accuracystationaryMod = .2;
	self.script_accuracy = 0.18;
	self waittill("spawned",other);
	waitframe();
	if(isdefined(other) && isalive(other))
	{
//		other.suppressionwait = 10;
		other.dropweapon = 0;
		other.favoriteenemy = level.player;
	}

}

missionfailed_on_condordeath()
{
	self waittill ("death");
	missionfailed();
}

dropthebombs()
{
	while(1)
	{
		level waittill ("dropthebomb");
		maps\_utility::exploder(23);
		damager = level.player.maxhealth/3;
		radiusdamage(level.player.origin, 500,damager,damager);
	}
}


planetest(planes)
{
	startorg = getent("gunstart","targetname");
	level.player setorigin(startorg.origin);
	theplane = getcvar("planetest");
	for(i=0;i<planes.size;i++)
	{
		if(planes[i]["sound"] == theplane)
			planetester(planes,i);
	}
	
	for(i=0;i<planes.size;i++)
		planetester(planes,i);
	
	level waittill ("never");
}

planetester(planes,i)
{
	println(planes[i]["targetname"]);
	vehicle = maps\_vehiclespawn::vehicle_spawn(planes[i]["targetname"]);
	vehicle maps\_vehiclechase::getonpath();
	vehicle thread maps\_vehiclechase::gopath();
	iprintlnbold("planeflying with soundid " + planes[i]["sound"]);
	if(isdefined(level.airfieldsounddelay[planes[i]["sound"]]))
	{
		wait(level.airfieldsounddelay[planes[i]["sound"]]);
		iprintlnbold("soundid " + planes[i]["sound"] +" delay ended");
	}
	vehicle playsound (level.airfieldsound[planes[i]["sound"]]);
	vehicle waittill ("reached_end_node");
}

saystuffforfirsttruck()
{
	return;
	trucktrigs = getentarray("moveenemy","targetname");
	for(i=0;i<trucktrigs.size;i++)
	{
		if(isdefined(trucktrigs[i].target) && trucktrigs[i].target == "auto3038")
		{
			trigger = trucktrigs[i];
			break;

		}
	}
	trigger waittill("trigger");
	level.waters thread threadwaitsay("truckride_waters_germanlorry",0);
}

hinttotruck()
{
	wait 3;
	iprintlnbold(&"AIRFIELD_BACKINTHETRUCK");
}