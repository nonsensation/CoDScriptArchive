#using_animtree ("generic_human");
main()
{
	precachemodel("xmodel/vehicle_german_truck_d"); 
	precacheString(&"POWCAMP_TIMER");

	setExpFog(.000008, 0, 0, 0, 0);
	maps\_load::main();
	maps\_truck::main();
	maps\_treadfx::main("night");
	maps\powcamp_anim::main();

	level.ambient_track ["inside"] = "ambient_powcamp_int";
	level.ambient_track ["outside"] = "ambient_powcamp_ext";
	thread maps\_utility::set_ambient("outside");
	

	//===================

	//Ingram character specific init

	character\ingram::precache();

	//===================

	if (getcvar ("start") == "jail")
	level.player setorigin ((-1914, -558, 32));

//	truck.driver = getent ("foley","targetname");
//	truck.driver character\_utility::new();
//	truck.driver character\foley::main();
//	truck.driver thread maps\_utility::magic_bullet_shield();

//	friends = getentarray ("friends","targetname");
//	maps\_utility::array_levelthread(friends,::friends_goal);

//	level.duration = 100;		//west end battle length in seconds, default 100 seconds
	level.stopwatch = 10;		//visible countdown timer length in minutes, default 7.5 minutes

//	level.foley = getent ("foley","targetname");
//	level.foley character\_utility::new();
//	level.foley character\foley::main();

	thread driver();

	thread objectives();
	thread return_triggers();
	thread end_trigger();
	level thread no_prone (getent ("no prone","targetname"));
	thread guardshoot();
	thread gate_guards();

	thread garage_truck(2);
	thread ingramproperties();

	thread alert_off();
	thread alert_on();
	thread music();
	thread timerstop();

//	thread ingram_talk();

	spawners = getentarray ("door guy", "script_noteworthy");
	maps\_utility::array_levelthread(spawners,::door_think);

	//gate properties
	gatedoorleft = getent ("gate_doorleft","targetname");
	gatedoorright = getent ("gate_doorright","targetname");
	gatedoorleft rotateyaw(0, 0.4,0,0);
	gatedoorright rotateyaw(0, 0.4,0,0);
	
	door = getent ("cooler_door","targetname");    
	door rotateyaw(0, 0.4,0,0);   

	level.flag["turn off gate alert"] = true;
}

timetest()
{
	while (1)
	{
		iprintlnbold (gettime() - level.starttime);
		wait 1;
	}
}

//OBJECTIVES##########

objectives()
{
	objective_add(1, "current", &"POWCAMP_OBJ1", (-128, 6928, 34));
	objective_add(2, "active", &"POWCAMP_OBJ2", (-2900, -104, 32));
	objective_current(1);
}

objective_stopwatch()
{
	fMissionLength = level.stopwatch;				//how long until relieved (minutes)
	iMissionTime_ms = gettime() + (int)(fMissionLength*60*1000);	//convert to milliseconds

	// Setup the HUD display of the timer.
//	level.hudTimerIndex = 20;
//	hdSetString(level.hudTimerIndex, &"POWCAMP_TIMER" ,hdGetTimerString(getTime()+(level.stopwatch*60*1000), "downremove"));
//	hdSetAlignment(level.hudTimerIndex, "right", "top");
//	hdSetPosition(level.hudTimerIndex, -8,120);
	
	level.timer = newHudElem();
	level.timer.alignX = "left";
	level.timer.alignY = "middle";
	level.timer.x = 470;
	level.timer.y = 150;
	level.timer.label = &"POWCAMP_TIMER";
	level.timer setTimer(600);
	
	
	level.starttime = gettime();
	level.currenttime = gettime() - (level.starttime);
	
	thread end_cond();
	
//	wait(level.stopwatch*60);

//	iprintlnbold(&"POWCAMP_TEN_MINUTES_HAVE_ELAPSED");
//	wait 2;
//	setCvar("ui_deadquote", "@POWCAMP_TEN_MINUTES_HAVE_ELAPSED");
//	missionFailed();
//	objective_state(2, "done");
}

end_cond()
{
	level endon ("end triggered");
	
	wait(level.stopwatch*60);
	setCvar("ui_deadquote", "@POWCAMP_TEN_MINUTES_HAVE_ELAPSED");
	missionFailed();
}

//TRIGGERS##########

return_triggers()
{
	trigger_onces = getentarray ("trigger_once", "classname");
	return_autosaves = [];
	for (i=0;i<trigger_onces.size;i++)
	{
		if (isdefined (trigger_onces[i].script_noteworthy) )
			if (trigger_onces[i].script_noteworthy == "return_autosave")
			{
				return_autosaves[return_autosaves.size] = trigger_onces[i];
				trigger_onces[i] thread maps\_utility::triggerOff();
			}
	}
	return_triggers = getentarray ("return_spawner", "targetname");
	for (i=0;i<return_triggers.size;i++)
	{
		return_triggers[i] thread maps\_utility::triggerOff();
	}

        /////////////////
        level waittill ("half way");
        /////////////////

	level notify ("return_started");
	level.return_started = "true";

	nonreturn_triggers = getentarray ("non_return", "targetname");
	for (i=0;i<nonreturn_triggers.size;i++)
	{
		nonreturn_triggers[i] delete();
	}

	for (i=0;i<return_triggers.size;i++)
	{
		return_triggers[i] thread maps\_utility::triggerOn();
	}
	for (i=0;i<return_autosaves.size;i++)
	{
		return_autosaves[i] thread maps\_utility::triggerOn();
	}
}

end_trigger()
{

	end_trigger = getent ("end_trigger", "targetname");
	end_trigger thread maps\_utility::triggerOff();

        /////////////////
        level waittill ("half way");
        /////////////////

	end_trigger thread maps\_utility::triggerOn();
	end_trigger waittill ("trigger");
	
	level notify ("end triggered");

	objective_state(3, "done");

	level.ingram.followmax = -1;
	level.ingram.followmin = 1;
	level.ingram.goalradius = 256;

	ingramarray[0] = level.ingram;

	nodes = getnodearray ("ingram_end_node", "targetname");
	node = maps\_utility::getClosest(level.ingram.origin, nodes);

	//* Good show Captain, to you and your boys! Well done, well done!
	level.ingram maps\_anim::anim_single_solo (level.ingram, "good show");

	if (isalive (level.player))
	{
		setCvar("ui_campaign", "british");
		missionSuccess ("uk_6ab", false);
	}
}

no_prone ( trigger )
{
	while (1)
	{
		trigger waittill ("trigger");
		level.player allowProne (false);
		while (level.player istouching (trigger))
			wait (0.05);

		level.player allowProne (true);
	}
}

alarm_sound()
{
	wait 4; //soft wait

	alarms = getentarray ("alarm_sound", "targetname");
	for (i=0;i<alarms.size;i++)
	{
		alarms[i] playloopsound("air_raid_siren");
	}
}


//GUARDS SETUP##########

guardshoot()
{
	guards = getentarray("gate_guard", "targetname");
	maps\_utility::array_levelthread(guards,::guardpain);
	triggers = getentarray("guard_shoot", "targetname");

	maps\_utility::array_levelthread(triggers,::guard_trigger,guards);

	maps\_utility::array_thread(guards,maps\_utility::cant_shoot);
}

guard_trigger(trigger,guards)
{
	trigger waittill ("trigger");
	for (i=0;i<guards.size;i++)
	{
		if (isAlive (guards[i]))
			guards[i] maps\_utility::can_shoot();
	}
	thread objective_stopwatch();

	stopwatch_trigger = getentarray("guard_shoot", "targetname");
	maps\_utility::array_thread(stopwatch_trigger,::stopwatch_trigger_delete);
	wait 1;

	thread alarm_sound();

	wait 2;

	thread alert_sound();
}

stopwatch_trigger_delete(trigger)
{
	self delete();
}

guardpain(guards)
{
	guards waittill ("pain");
	guards maps\_utility::can_shoot();
}

gate_guards()
{
	guards = getentarray ("gate_guard","targetname");
	maps\_utility::array_levelthread(guards, ::guard_think);
	count = guards.size;
	while (count)
	{
		level waittill ("guards died");
		count--;
	}

	level notify ("gate guards dead");
	
	thread movetruck(1);
	objective_state(1, "done");
	objective_current(2);
}

guard_think(guards)
{
	guards waittill ("death");
	level notify ("guards died");
}

//TRUCK BUSTS THROUGH GATE##########

driver()
{
	truck = getent ("truck1","targetname");
	spawners = getentarray ("friends","targetname");
	driver = getent ("foley","targetname");


        maps\_utility::array_levelthread(spawners,::friends_grenade);


	truck maps\_truck::life();
	truck maps\_truck::attach_guys(undefined,driver,1,600);
	truck thread maps\_treads::main();

//	truck maps\_truck::opendoor();

	driver = truck.driver;
	truck.driver.DrawOnCompass = false;
	truck.driver character\_utility::new();
	truck.driver character\foley::main();
	truck.driver thread maps\_utility::magic_bullet_shield();
	level.foley = truck.driver;
	level.foley.animname = "foley";
	level.foley.hasweapon = false;
	level.foley animscripts\shared::PutGunInHand("none");
	truck.health = 100000;
	thread truckhealth(truck);
	truck.animname = "truck";

	level waittill ("starting final intro screen fadeout");

//	thread doorclose(truck);
	truck assignanimtree();
	truck setAnimKnobRestart(level.scr_anim[truck.animname]["ok martin"], 1, .1, 1);
	thread door_sound(truck);
	thread foley_interrupt(truck);

	//"Ok Martin, we're ready to ram the gate..."
	level.foley animscripts\shared::LookAtEntity(level.player, 30, "casual", "eyes only");
	
	level endon ("guards died");
	
	truck maps\_anim::anim_single_solo (level.foley, "ok martin", "tag_driver");
	
	level notify ("speech ended");
	
	truck thread maps\_anim::anim_loop_solo (level.foley, "truck idle", "tag_driver");
	level.foley animscripts\shared::LookAtStop();
}

foley_interrupt(truck)
{
	level endon ("speech ended");
	level waittill ("guards died");
	truck stopanimscripted();
	level.foley animscripts\face::SaySpecificDialogue(undefined, "null_dialog",1);
	truck thread maps\_anim::anim_loop_solo (level.foley, "truck idle", "tag_driver");
//	truck thread maps\_truck::closedoor();
	truck setanimknob (level.scr_anim[truck.animname]["door close"]);
	level.foley animscripts\shared::LookAtStop();
}

door_sound(truck)
{
	wait 21;
	truck playSound("car_door_close");
}

truckhealth(truck)
{
	while (1)
	{
		self waittill ("damage");
		self.health = 100000;
	}
}

friends_grenade(spawners)
{
	spawners waittill ("spawned",friend);
	if (maps\_utility::spawn_failed(friend))
		return;
	friend.grenadeawareness = 0;
	
	level waittill ("truck unload");
	
	friend.grenadeawareness = .2;
	
}


//doorclose(truck)
//{
//	wait 18.2;
//	truck maps\_truck::closedoor();
//}


movetruck(num)
{
	if ( num == 1 )
	{
		truck = getent ("truck1", "targetname");
		path1 = getVehicleNode(truck.target,"targetname");
		gatenode = getVehicleNode("auto285","targetname");

		truck attachpath (path1);

		wait .1;

		truck startPath();

		wait 1;

		level.truck = 1;

		truck setWaitNode (gatenode);
		truck waittill ("reached_wait_node");
		thread gateopen();

		wait 4;
		truck disconnectpaths();

		truck notify ("unload");
		level notify ("truck unload");

		maps\_utility::array_thread (getentarray ("rush_guys1","targetname"),::spawn_attack);

		//"...I'll stay and secure the truck!"
		level.foley thread maps\_anim::anim_single_solo (level.foley, "secure truck");
	}
}

spawn_attack()
{
	self.count = 1;
	spawn = self dospawn();
}


gateopen()
{
	thread openleftgate();
	thread openrightgate();
}

openleftgate()
{
	gatedoorleft = getent ("gate_doorleft","targetname");

	gatedoorleft playSound("truck_crash_gate");

	gatedoorleft rotateyaw (150, .5,.3,0);
	gatedoorleft waittill("rotatedone");

	gatedoorleft rotateyaw (-15, .5,0,.4);
	gatedoorleft waittill("rotatedone");

	gatedoorleft disconnectpaths();
}

openrightgate()
{
	gatedoorright = getent ("gate_doorright","targetname");

	gatedoorright rotateyaw(-135, .5,.4,0);
	gatedoorright waittill("rotatedone");

	gatedoorright rotateyaw(10, .6,0,.5);
	gatedoorright waittill("rotatedone");

	gatedoorright disconnectpaths();
}


//ENEMY TRUCK##########

garage_truck(num)
{
	if ( num == 2 )
	{
		garagetrigger = getent ("garage_truck_start","targetname");
		garagetrigger thread maps\_utility::triggerOff();

	        /////////////////
	        level waittill ("half way");
	        /////////////////

     		garagetrigger thread maps\_utility::triggerOn();

     		/////////////////
     		garagetrigger waittill ("trigger");
     		/////////////////

		garagedoor = getent ("garage_door","targetname");
		garagetruck = getent ("garage_truck","targetname");
		driver = getent ("garage_truck_driver","targetname");
		unloadnode = getVehicleNode("auto885","targetname");

		garagedoor delete();

		garagetruck maps\_truck::init();
		garagetruck maps\_truck::attach_guys(undefined,driver);
		pathgaragetruck = getVehicleNode(garagetruck.target,"targetname");

		garagetruck attachpath (pathgaragetruck);

		wait .1;

		garagetruck startPath();

		level.garagetruck = 2;

		garagetruck setWaitNode (unloadnode);
		garagetruck waittill ("reached_wait_node");

		garagetruck notify ("unload");
		garagetruck disconnectpaths();


	}
}

//MAJOR ` SETUP##########
ingramproperties()
{
    spawner = getent ("ingram", "targetname");
    spawner waittill ("spawned",ingram);

    guard = getent ("chokeguard", "targetname") doSpawn();
    guard.animname = "guard";

    level.ingram = ingram;
    level.ingram.animname = "ingram";
    level.ingram thread maps\_utility::magic_bullet_shield();
    level.ingram character\_utility::new();
    level.ingram character\ingram::main();

	
//	guard.hasweapon = false;
//	guard.Anim_gunInHand = "none";
    guard.weapon = "none";
    node = getnode ("node_jail", "targetname");
    ingramarray[0] = ingram;
    ingramarray[1] = guard;
    level thread maps\_anim::anim_loop (ingramarray, "choke", undefined, "stop loop", node);
    wait (1);
    level.ingram maps\_anim::gun_leave_behind (ingram, level.scr_notetrack[ingram.animname][5]);
   	guard animscripts\shared::PutGunInHand("none");

	triggers = getentarray ("start_return", "targetname");
	maps\_utility::array_levelthread(triggers,::halfway);

    /////////////////
    level waittill ("half way");
    /////////////////

    level notify ("stop loop");

	door = getent ("cooler_door", "targetname");
	door connectpaths();


    guard.deathanim = level.scr_anim[guard.animname]["yanks"];
//	guard.playDeathAnim = false;


    level thread maps\_anim::anim_single_solo (level.ingram, "yanks", undefined, node);
    thread guard_die(guard,node);
    thread keys_jingle(door);

	wait 4;
	door notsolid();
	door playSound("cell_door");
	door rotateyaw(-90, 0.4,0.1,0.1);
	door waittill("rotatedone");
	door rotateyaw (10, .5,0,.4);
	door solid();
	door disconnectpaths();
	
	level.ingram setgoalentity (level.player);
	
	
	//	ingram.hasWeapon = false;
	//	guy [[level.scr_character[guy.animname]]]();
	//	guy animscripts\shared::putGunInHand ("left");
	//	guy animscripts\shared::doNoteTracks("scriptedanimdone");
	
	objective_state(2, "done");
	objective_add(3, "active", &"POWCAMP_OBJ3", (-486, 6830, 50));
	objective_current(3);
}

guard_die(guard,node)
{
        level maps\_anim::anim_single_solo (guard, "yanks", undefined, node);
        guard.allowdeath = true;
        guard DoDamage ( guard.health + 50, guard.origin );
}

keys_jingle(door)
{
	wait 1;
	door playSound("keys_jingle");
}

alert_sound()
{
	alerts = getentarray ("alert_attack_sound", "targetname");
	while (1)
	{
		if (!level.flag["turn off gate alert"])
		{
			for (i=1;i<alerts.size;i++)
				alerts[i] playsound("powcamp_german_PA_gatebreach");

			alerts[0] playsound("powcamp_german_PA_gatebreach","sounddone");
			alerts[0] waittill ("sounddone");
			wait 6+ randomfloat (6);
		}

		for (i=1;i<alerts.size;i++)
			alerts[i] playsound("powcamp_german_PA_underattack");

		alerts[0] playsound("powcamp_german_PA_underattack","sounddone");
		alerts[0] waittill ("sounddone");
		wait 6+ randomfloat (6);


		for (i=1;i<alerts.size;i++)
			alerts[i] playsound("powcamp_german_PA_battlestations");

		alerts[0] playsound("powcamp_german_PA_battlestations","sounddone");
		alerts[0] waittill ("sounddone");
		wait 6+ randomfloat (6);

		if (!level.flag["turn off gate alert"])
		{
			for (i=1;i<alerts.size;i++)
			alerts[i] playsound("powcamp_german_PA_enemyeast");

			alerts[0] playsound("powcamp_german_PA_enemyeast","sounddone");
			alerts[0] waittill ("sounddone");
			wait 6+ randomfloat (6);
		}
	}
}

alert_off()
{
	trigger = getent ("alertoff_trigger", "targetname");
	trigger waittill ("trigger");

	level.flag["turn off gate alert"] = true;
}

alert_on()
{
	trigger = getent ("alerton_trigger", "targetname");
	trigger waittill ("trigger");

	level.flag["turn off gate alert"] = false;
}

//ingram_talk()
//{
//	trigger = getent ("ingram_talk", "targetname");
//	trigger waittill ("trigger", other);
//
//	while (1)
//	{
//		trigger waittill ("trigger", other);
//		if (other == level.ingram)
//			break;
//	}
//
//	//* Lead on lads, no time for handshakes and hellos
//	level.ingram thread maps\_anim::anim_single_solo (level.ingram, "lead on");
//}

door_think(spawners)
{
	spawners waittill ("spawned",guy);

	if (!maps\_utility::spawn_failed(guy))
	{
	        node = getnode (guy.target, "targetname");

		guy.animname = "generic";
		guy.allowDeath = true;

		if (randomint (100) > 50)
			thread maps\_anim::anim_single_solo (guy, "kick door 1", undefined, node);
		else
			thread maps\_anim::anim_single_solo (guy, "kick door 2", undefined, node);
		guy waittillmatch ("single anim", "kick");
	}

	doors = getentarray (spawners.target, "targetname");

	for (i=0;i<doors.size;i++)
	{
		if (!isDefined (doors[i].script_noteworthy))
			doors[i].script_noteworthy = "right door";
		doors[i] connectpaths();
		if (doors[i].script_noteworthy == "left door")
			doors[i] rotateyaw(178, 0.5,0.1,0.1);
		else
			doors[i] rotateyaw(-178, 0.5,0.1,0.1);
	}
	doors[0] playsound ("wood_door_kick");
	doors[0] waittill("rotatedone");

	for (i=0;i<doors.size;i++)
	{
		doors[i] connectpaths();
		if (doors[i].script_noteworthy == "left door")
			doors[i] rotateyaw(-20, .4,0,.4);
		else
			doors[i] rotateyaw(20, .4,0,.4);
	}
	doors[0] playsound ("door_bounce");
	doors[0] waittill("rotatedone");
	doors[0] disconnectpaths();
        node = getnode (node.target, "targetname");
        if (isAlive(guy))
		guy setgoalnode(node);
}

halfway(trigger)
{
	trigger waittill ("trigger");
	level notify ("half way");
}

assignanimtree()
{
	self UseAnimTree(level.scr_animtree[self.animname]);
}

music()
{
	level waittill ("finished intro screen");
	musicPlay("redsquare_dark_loop");
	
	level waittill ("gate guards dead");
	musicStop();
	musicPlay("powcamp_ramgate");
	
	wait 34;
	musicPlay("redsquare_tense");
	
	while(1)
	{
		wait 135;
		musicplay("redsquare_tense");
	}
}
	
timerstop()
{
	level waittill ("end triggered");
	
	level.currenttime = gettime() + 100000;
	level.timer destroy();
}