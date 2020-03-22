#using_animtree ("generic_human");

main()
{
	maps\_treadfx::main();
	maps\_truck::main();
	maps\_kubelwagon::main();
	maps\_bmwbike::main();
	maps\truckride_anim::main();
	precacheShellshock("default");
	precachemodel("xmodel/prop_panzerfaust");
	precachemodel("xmodel/weapon_mp44");
	truck = getent("player_vehicle","targetname");
	healths = getentarray("healthpack","targetname");
	for(i=0;i<healths.size;i++)
	{
		healths[i].origin = healths[i].origin + (0,0,-42);
		healths[i] linkto (truck);

	}

	setcvar("introscreen","1");
	ambientPlay("ambient_truckride");

	if (getcvar("getout") == "")
		setcvar("getout", "off");
	if (getcvar("jumpsnapshot") == "")
		setcvar("jumpsnapshot", "off");
	watersandpricesetup();

	splashes = getentarray  ("waterfallsplashes","targetname");  //hack
	for(i=0;i<splashes.size;i++)
	{
		splashes[i].script_delay = .1;
	}

	setExpFog(.0000144, 0.5, 0.52, 0.70, 0);
	thread getout();
	axisspawners = getspawnerteamarray("axis");
	for(i=0;i<axisspawners.size;i++)
	{
		axisspawners[i] thread accuracylower();
	}



	vehicles = getentarray("script_vehicle","classname");
	for(i=0;i<vehicles.size;i++)
	{
		if(isdefined(vehicles[i].script_noteworthy) && vehicles[i].script_noteworthy == "driverdelay")
			vehicles[i].script_noteworthy = "";  //ghetto hack fix up driver delay stuff
	}



	maps\_load::main();
	maps\_bmwbike::main();
	
	if (getcvar("bridgeblow") == "")
		setcvar("bridgeblow", "off");
	if (getcvar("bridgesquibs") == "")
		setcvar("bridgesquibs", "off");
	maps\truckride_fx::main();

	if (getcvar("bridgeblow") != "off")
		bridgeblowtest();
	level.player takeallweapons();
	level.player giveweapon("colt");
	level.player giveWeapon("bren");
	level.player giveweapon ("panzerfaust");
	level.player takeweapon ("panzerfaust");
	maps\_vehiclechase::main();
	maps\_truckridewaters::main();
	aicleartrigs = getentarray("aiclear","targetname");
	for(i=0;i<aicleartrigs.size;i++)
	{
		aicleartrigs[i] thread trigger_aiclear_wait();
	}

	tgroupspawns= getentarray("tgroupspawn","targetname");
	for(i=0;i<tgroupspawns.size;i++)
	{
		if(tgroupspawns[i].target == "auto1469")
			jumpersetuptrig = tgroupspawns[i];
	}
	jumpersetuptrig thread jumpersetup();

	trucksplashers = getentarray("trucksplasher","targetname");
	for(i=0;i<trucksplashers.size;i++)
	{
		trucksplashers[i] thread trigger_trucksplasher_wait();
	}
	if (getcvar("jumpsnapshot") != "off")
		showshot();


	treefallers = getentarray("treepusher","targetname");
	for(i=0;i<treefallers.size;i++)
	{
		treefallers[i] thread trigger_treefaller_wait();
	}

	jumpsnapshottrig = getent("jumpsnapshot","targetname");
	jumpsnapshottrig thread takeshot();
	jumpsnapshottrig thread crazynazijumping();

	pricetalktrigs = getentarray("pricetalk","targetname");
	for(i=0;i<pricetalktrigs.size;i++)
	{
		pricetalktrigs[i] thread pricetalk();
	}
	
	level.waters.playpainanim = false;
	level.waters thread talkhandle();
	waterstalktrigs = getentarray("waterstalk","targetname");
	for(i=0;i<waterstalktrigs.size;i++)
	{
		waterstalktrigs[i] thread waterstalk();
	}

	thread waterstalkkubelandtruck();
	thread crashvehicle();
	truck = getent("player_vehicle","targetname");
	truck thread driversetup();
	truck thread regen();
	level.playertruck = truck;
	level.player setorigin ((truck getTagOrigin ("tag_player")));
	level.player playerlinkto (truck, "tag_player", ( 0.1, .6, 0.9 ));
	truck thread maps\_treads::main();
	truck thread waitstartvehiclechase();

	thread playerkiller(); // to be replaced with truck triggers rather than being triggered by ai on the truck
	truck thread trigger_cower();
	truck thread trigger_cliffjump();
	truck thread trigger_lastfaust();
	thread trigger_endlevel();
	autosavetrig = getent("autosave1","targetname");
	autosavetrig thread save1();
	bridgestop = getent("bridgestop","targetname");
	bridgestop thread bridgestopsequence();


	bridgeholdpanzer = getent("truckride_waters_makeitacross","script_noteworthy");
	bridgeholdpanzer thread bridgeholdpanzer();

	level.player setautopickup(false);
	objective_add(1, "active", &"TRUCKRIDE_OBJ1_GET_TO_THE_AIR_FIELD");
	objective_current(1);
	wait .05;
	musicplay("truckride");
}

waitstartvehiclechase()
{
	self thread maps\_vehiclechase::start();
}

save1()
{
	self waittill ("trigger");
	maps\_utility::autosave(1);
}

bridgestopsequence()
{
	level.waters endon ("death");
	bridgeblocker = getent("bridgepathbreak","targetname");
	bridgeblocker notsolid();
	bridgeblocker connectpaths();
	self waittill ("trigger");
	replensishpanzerfaust = false;
	level notify ("donttalkofkubel");  //stops thread of waters saying stuff about that kubelwagon being there
	thread lazyplayerkiller();
	other = getent("player_vehicle","targetname");
	level notify ("endstartsequence");
	other thread bridgestopnotify();
	if(level.waters.hasweapon)
		replensishpanzerfaust = true;
	other notify ("buddypain");
	level.waters.idling = 1;
	other notify ("buddyevent","idle");


	if(level.waters.hasweapon || isdefined(level.waters.anim_gunInHand))
		replensishpanzerfaust = true;
	if(isdefined(level.panzerfaustthing))
	{
		level.panzerfaustthing delete();
		replensishpanzerfaust = true;
	}

	level.waters.hasweapon = false;
	level.waters animscripts\shared::PutGunInHand("none");

	other setspeed (0,15);
	other waittill ("donewaitting");
	other notify ("endbouncy");
	
	other waittill ("soggy");
	
	objective_add(2,"active",&"TRUCKRIDE_OBJ2_COVER_SGT_WATERS");
	objective_current(2);
	
	truckrideaiocclude();
	if(level.player hasweapon ("panzerfaust"))
		replensishpanzerfaust = true;
	level.player takeweapon ("panzerfaust");
	level.player giveweapon ("kar98k_sniper");
	level.player switchtoweapon("kar98k_sniper");

	if(replensishpanzerfaust)
	{
		other thread maps\_truckridewaters::waitregenpanzer(1);

	}
	level.waters allowedstances ("stand");
	level.waters waittill ("buddyidle");

	thread reenforceguys();
	thread allowfewinarea();
	
	other notify ("buddyevent","jumpout");
	level.waters maps\_utility::cant_shoot();
	level.waters.script_moveoverride = 1; //keeps _spawner.gsc from setting a goalradius
	org = getnode("plungernode","targetname");
	level.waters setgoalpos (org.origin);
	level.waters.goalradius = 16;
	ai = getaiarray("axis");
	for(i=0;i<ai.size;i++)
		ai[i].ignoreme =1;  //all axis have ignoreme so waters will be consistant in his running to the point
	
	level.waters thread throwgunawayatgoal();
	wait 7.9;
	
	thread allowfewinarea();
	
	level.waters.hasweapon = false;
	level.waters animscripts\shared::PutGunInHand("none");
	wait 12;
	bridgenode = getnode("auto1695","targetname");
	bridgecrossnode = getnode("auto1627","targetname");
	ai = getaiarray("axis");
	{
		for(i=0;i<ai.size;i++)
		{
			if(isdefined(ai[i].script_vehiclegroup) && ai[i].script_vehiclegroup == 12)
			{
				ai[i] setgoalnode (bridgecrossnode);
				ai[i].goalradius = 512;
			}
		}
	}
	wait 14; //do cool fighting accrossed bridge stuff while waters figures out how to work the plungers
	if(!isdefined(level.waters.magic_bullet_shield))
		level.waters thread maps\_utility::magic_bullet_shield();

	bridgeblowers = getentarray("bridge_damage","targetname");
	for(i=0;i<bridgeblowers.size;i++)
	{
		bridgeblowers[i] thread bridgedamage();
	}
	bridgeblowers[0] playsound ("explo_bridge");
	maps\_utility::exploder(1);

	earthquake(0.45, 5, level.player.origin, 2250);
	thread bridgesquibs();
	bridgeblocker solid();
	bridgeblocker disconnectpaths();
	tagang = other gettagangles(level.waters.sittag);
	tagorg = other getTagOrigin(level.waters.sittag);

	org = getstartorigin (tagorg,tagang,level.waters.jumpin);
	level.waters setgoalpos (org);
	level notify ("stopreenforce");
	if(!isdefined(level.waters.magic_bullet_shield))
		level.waters thread maps\_utility::magic_bullet_shield();
	level.waters.ignoreme = true;
	// everbody point and shoot at waters so you don't accidently hit him with a stray bullet fired at the player
	ai = getaiarray("axis");
	for(i=0;i<ai.size;i++)
	{
		ai[i].accuracystationarymod = 0;
		ai[i].accuracy = 0;
		ai[i].favoriteenemy = level.waters;
	}
	
	timer = gettime();
	level.waters waittill ("goal");
	wait .5;
	other notify("buddyevent","jumpin");
	level.waters waittill ("buddyidle");
	level.price thread talker("truckride_price_beautiful");
	other thread maps\_truckridewaters::playerdeath();
	level.waters maps\_utility::can_shoot();
	level.waters.ignoreme = false;
	level.player takeweapon ("kar98k_sniper");
	level.player switchtoweapon("bren");
	other thread bouncy2();
	other thread maps\_truckridewaters::startsequence(level.waters);
	objective_state(2, "done");
	level notify ("Objective 2 Completed");
	objective_current(1);
	other resumespeed(15);
}

bridgedamage()
{
	if(isdefined(self.script_delay))
		wait self.script_delay;
	radiusdamage(self.origin,300,5000,4000);

}

bridgestopnotify()
{
	self setwaitspeed(1);
	self waittill ("reached_wait_speed");
	self notify ("donewaitting");
	self disconnectpaths();
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

driversetup()
{
	driverspawner = getent("driver","targetname");
	level.price = driverspawner;
	driverspawner.origin = self.origin + (0,0,128);
	driver = driverspawner dospawn();
	if(isdefined(driver))
		self notify ("guyenters", driver);  //put the driver in the truck

}

playerkiller()
{
	playerkillers = getentarray("player_killer","targetname");
	for (i=0;i<playerkillers.size;i++)
		playerkillers[i] thread playerkillnow();
}

playerkillnow()
{
	targ = getent(self.target,"targetname");
	if(!isdefined(targ))
		return;
	
	targeters = getentarray(targ.targetname,"target");
	for(i=0;i<targeters.size;i++)
	{
		if(targeters[i].classname != "trigger_multiple")
		{
			spawner = targeters[i];
		}
	}
	if(!isdefined(spawner))
		level waittill ("never");
	
	while(1)
	{
		truck = undefined;
		self waittill ("trigger", truck);
		if(isalive(truck))
		if(truck.targetname != "player_vehicle" && truck.targetname == targ.target )
			break;
	}

	truck endon ("death");
	truck thread panzerguyinbackoftruck(guy,spawner);
	
	self thread playerkillend(targ,truck);
	
	red = 0.0;
	green = 1.0;
	targorg = targ getorigin();
	totaldist = distance(self getorigin(),targorg);


	truck waittill ("shootershot");
	wait .5;
	
	if(truck.health > 0  && isdefined(truck.spawnedtokillyouguy) && isalive(truck.spawnedtokillyouguy))
	{
		playertruck = getent("player_vehicle", "targetname");
		playertruck setspeed (0,15);
		origin = level.player getorigin ();
		level.player playsound ("weapons_rocket_explosion");
		playertruck notify ("buddypain");
		level.waters.deathanim = level.waters.pain[0];
		level.waters.health = 1;
		level.waters.allowdeath = 1;
		level.waters dodamage(level.waters.health + 50,level.waters.origin);
		radiusDamage ( origin, 500, 2000, 1000);
		earthquake(0.6, 2, level.player.origin, 5000);
		if (getcvar ("r_texturebits") != "16")
			level.player shellshock("default", 60);
	}
	truck setspeed (0,25);

}
panzerguyinbackoftruck(guy,spawner)
{

	spawner.origin = self gettagorigin("tag_player");

	guy = spawner stalingradspawn();
	guy endon ("fakedeathhappening");
	guy.health = 100;
	self.spawnedtokillyouguy = guy;
	guy.allowdeath = 1;
	guy.fakedeathanim = %death_stand_dropinplace;
	guy linkto(self,"tag_player",(0,0,0),(0,0,0));
	guy.croucher = %crouch_alert_A_idle;
	guy.crouchout = %crouchhide2stand;;
	guy.truckaim = %stand_aim_straight;
	thread maps\_truck::deathremove(guy);
	thread waitshot(guy);


	org = guy.origin;
	angles = vectortoangles(level.player.origin - org);
	guy endon("shootingnow");
	guy animscripted("animontagdone", org, angles, guy.crouchout);
	guy waittill ("animontagdone");

	while(isalive(self) && self.health > 0 && isalive(guy))
	{
		org = guy.origin;
		angles = vectortoangles(level.player.origin - org);
		guy animscripted("animontagdone", org, angles, guy.truckaim);
		wait .1;
	}


}

waitshot(guy)
{
	guy allowedstances ("stand");
	self endon("death");
	guy endon("fakedeathhappening");
	self waittill ("shoot");
	if(isalive(guy))
	{
		guy notify ("shootingnow");
		org = guy.origin;
		angles = vectortoangles(level.player.origin - org);
		guy animscripted("shooteranim", org, angles, guy.truckaim);
		waitframe();
		guy shoot();
	}
	self notify ("shootershot");
}


playerkillend(targ,truck)
{
	truck endon ("death");
	while(1)
	{
		targ waittill ("trigger",other);
		if(other == truck)
		{
			truck notify ("shoot");
			return;
		}
	}
}

playerkillend_oold(targ,truck)
{
	while(self.waiting == 1)
	{
		targ waittill ("trigger",other);
		if(other == truck)
		{
			self.waiting = 0;
			return;
		}

	}

}


trigger_cower()
{
	trigger = getent("jumpcower","targetname");
	trigger waittill ("trigger");
	level.waters waittill ("buddyidle");
	self.enemyque = undefined;
	waitframe();
	self notify ("buddyevent","cower");

}

crazynazijumping()
{

	self waittill ("trigger");
	guy = level.crazyguy;
	guy notify ("jumpererer");
	guy unlink();
	guy linkto (level.playertruck,"tag_waters",(0,0,0),(0,0,0));
	level.playertruck notify ("buddypain");
	level.waters.idling = 0;
	thread watersjumpstuff();
	level.playertruck thread animontag(guy , "tag_waters" , %truckride_jumpguy_jumpsequence);
}
watersjumpstuff()
{
	thread watersjumpgrunts();
	level.playertruck animontag(level.waters , "tag_waters" , %truckride_waters_jumpsequence);
	level notify ("watersdonejumpfighting");
	level.playertruck thread maps\_truckridewaters::buddy_idle_noammo(level.waters);
}

watersjumpgrunts()
{
	level endon ("watersdonejumpfighting");
	level.waters talker("truckride_waters_struggle1",.5);
	level.waters talker("truckride_waters_struggle2",.5);
	level.waters talker("truckride_waters_struggle3",.5);
}

jumpersetup()
{
	self waittill ("trigger");
	waitframe();
	truck = getent(self.target,"targetname");

	level.crazyguy = getent("vehiclejump","targetname") stalingradspawn();
	guy = level.crazyguy;
	guy endon ("jumpererer");
	guy linkto(truck,"tag_guy06",(0,0,0),(0,0,0));

	truck animontag(guy, "tag_guy06" , %truckride_jumpguy_hideidle);
	truck animontag(guy, "tag_guy06" , %truckride_jumpguy_hide2wait);
	while(1)
		truck animontag(guy, "tag_guy06" , %truckride_jumpguy_waitforjump);
}

animontag(guy, tag , animation, notetracks, sthreads)
{
	guy endon ("customdeath");
	guy endon ("death");
	org = self gettagOrigin (tag);
	angles = self gettagAngles (tag);
	guy animscripted("animontagdone", org, angles, animation);
	if(isdefined(notetracks))
	{
		for(i=0;i<notetracks.size;i++)
		{
			guy waittillmatch ("animontagdone",notetracks[i]);
			guy thread [[sthreads[i]]]();
		}

	}
	guy waittillmatch ("animontagdone","end");
}

talkhandle()
{
	self.talking = 0;
	while(1)
	{
		if(isdefined(self.talkque))
		{
			self.talking = 1;
			self animscripts\face::sayspecificdialogue(level.scr_anim[self.talkque[0]],self.talkque[0],.7,"talker");
			self waittill ("talker");
			self.talkque = talker_queremove(self.talkque[0],self.talkque);
			self.talking = 0;
		}
		else
		{
			self notify ("quetalked");
			self waittill ("talk update");
		}
	}
	if(isdefined(notifystring))
		self notify (notifystring);
}

#using_animtree ("germantruck");

crashvehicle()
{
	crashvehicletrigger = getent ("crashvehicle","targetname");
	crashvehicle = getent (crashvehicletrigger.target,"targetname");
	crashvehicle notsolid();
	crashvehicle UseAnimTree(#animtree);
	crashvehicletrigger waittill ("trigger");
	crashvehicle playsound("Barricade_smash");
	crashvehicle setanim (%germantruck_truck_smashedfromleft);
	earthquake(0.45, 1, level.player.origin, 5000);
}

bouncy2()
{
	self endon ("death");
	self endon ("endbouncy");
	self UseAnimTree(#animtree);
	self.bounceanim[0] = %truckride_truck_largebumpB;
	self.bounceanim[1] = %truckride_truck_smallbumpB;
	self.bounceanimocc[0] = 500;
	self.bounceanimocc[1] = 2000;
	while(1)
	{
		theanim = randomoccurrance(self.bounceanimocc);
		self setflaggedanimrestart("bounce",self.bounceanim[theanim]);
		self waittill ("bounce");

	}
}

randomoccurrance(occurrences)
{
	range = [];
	totaloccurrance = 0;
	for(i=0;i<occurrences.size;i++)
	{
		totaloccurrance += occurrences[i];
		range[i] = totaloccurrance;
	}
	pick = randomint(totaloccurrance);
	for(i=0;i<occurrences.size;i++)
	{
		if(pick < range[i])
		{
			return i;
		}
	}
}

trigger_cliffjump()
{
	trigger = getent("jumpbounce","targetname");
	trigger waittill ("trigger");
	self notify ("endbouncy");
	self UseAnimTree(#animtree);
	self setflaggedanimrestart("bounce",%truckride_truck_slidehill);
	self playsound("Truck_land_impact");

	while(1)
	{
		self setflaggedanimrestart("bounce",%truckride_truck_bouncehill);
		self waittill ("bounce");
	}
}

bridgeblowtest()
{
	spottrig = getent("autosave1","targetname");
	level.player setorigin(spottrig getorigin() - (0,0,512));
	chunks = getentarray("exploderchunk","targetname");
	planks = [];
	for(i=0;i<chunks.size;i++)
	{
		if(isdefined(chunks[i].script_exploder) && chunks[i].script_exploder == 1)
			planks[planks.size] = chunks[i];
	}
	level.watersplash = [];
	wait 2;

	if (getcvar("bridgesquibs") != "off")
	{
		for(i=0;i<planks.size;i++)
		{
			planks[i] thread watersplash();
		}
	}
	else
	{
		bridgesquibs();
	}
	maps\_utility::exploder(1);

	wait 5;
	
	level waittill ("never");


}

bridgesquibs()
{
	level.watersquib[0]["delay"] = 1.9;
	level.watersquib[0]["origin"] = (7083.55, 3081.60, -529.80);
	level.watersquib[1]["delay"] = 1.95;
	level.watersquib[1]["origin"] = (7681.50, 3128.00, -542.00);
	level.watersquib[2]["delay"] = 2.05;
	level.watersquib[2]["origin"] = (7831.40, 3213.60, -536.00);
	level.watersquib[3]["delay"] = 2.1;
	level.watersquib[3]["origin"] = (7209.60, 3191.20, -521.60);
	level.watersquib[4]["delay"] = 2.6;
	level.watersquib[4]["origin"] = (7198.25, 3260.80, -499.40);
	level.watersquib[5]["delay"] = 2.6;
	level.watersquib[5]["origin"] = (7797.45, 3304.80, -511.80);
	level.watersquib[6]["delay"] = 3.25;
	level.watersquib[6]["origin"] = (7211.50, 3360.00, -500.00);
	level.watersquib[7]["delay"] = 3.3;
	level.watersquib[7]["origin"] = (7775.35, 3571.20, -534.20);
	level.watersquib[8]["delay"] = 3.4;
	level.watersquib[8]["origin"] = (7020.35, 3509.60, -529.80);
	level.watersquib[9]["delay"] = 3.45;
	level.watersquib[9]["origin"] = (7669.50, 3668.00, -500.00);
	level.watersquib[10]["delay"] = 3.45;
	level.watersquib[10]["origin"] = (7804.10, 3387.20, -524.40);
	level.watersquib[11]["delay"] = 3.45;
	level.watersquib[11]["origin"] = (7195.50, 3708.00, -500.00);
	level.watersquib[12]["delay"] = 3.5;
	level.watersquib[12]["origin"] = (6878.65, 3411.40, -529.40);
	level.watersquib[13]["delay"] = 3.5;
	level.watersquib[13]["origin"] = (7106.15, 3615.80, -507.80);
	level.watersquib[14]["delay"] = 3.5;
	level.watersquib[14]["origin"] = (7982.25, 3459.20, -513.80);
	level.watersquib[15]["delay"] = 4.25;
	level.watersquib[15]["origin"] = (7705.50, 3736.00, -500.00);
	level.watersquib[16]["delay"] = 4.25;
	level.watersquib[16]["origin"] = (7191.50, 3776.00, -500.00);

	for(i=0;i<level.watersquib.size;i++)
	{
		maps\_fx::OneShotfx("waterfallsplash", level.watersquib[i]["origin"],level.watersquib[i]["delay"]);
	}

}

watersplash()
{
	time = gettime();
	while(1)
	{
		if(self.origin[2] < -494)
			break;
		waitframe();
	}
	timed = gettime() - time;

	place = level.watersplash.size;
	level.watersplash[place]["delay"] = timed/1000.00;
	level.watersplash[place]["origin"] = self.origin;
	maps\_fx::OneShotfx("waterfallsplash", self.origin,0);

}

trigger_lastfaust()
{
	trigger = getent("lastpanzer","targetname");
	trigger waittill ("trigger");
	level.player giveMaxAmmo("bren");
}

trigger_endlevel()
{
	trigger = getent("endlevel","targetname");
	trigger waittill ("trigger");
	missionsuccess("airfield",false);

}

waterstalk()
{
	self waittill ("trigger");
	if(isdefined(self.target))
		target = getent(self.target,"targetname");
	else
	{
		if(isdefined(self.script_noteworthy))
		{
			if(self.script_noteworthy == "truckride_waters_soggybastard")
				level.playertruck notify ("buddyevent","soggybastard");
			else
				level.waters talkerque(self.script_noteworthy);
		}
	}
	if(isdefined(target) && target.health > 0)
	{
		if(isdefined(self.script_noteworthy))
		{
			level.waters talkerque(self.script_noteworthy);
		}
	}

}

talker(dialog,importance,notifystring)
{
	if(!isdefined(importance))
		importance = .7;
	self animscripts\face::sayspecificdialogue(level.scr_anim[dialog],dialog,importance,"talker");
	self waittill ("talker");
	if(isdefined(notifystring))
		self notify (notifystring);
}

talkerque(dialog,importance,notifystring)
{
	if(dialog == "truckride_waters_panzerfaustbehind")
		dialog = "truckride_waters_germanlorry";  // hack
	self.talkque = talker_queadd(dialog,self.talkque);
	self notify("talk update");
}

talker_queremove(target,que)
{
	if(!isdefined(que))
	{
		return;
	}
	que = maps\_utility::array_remove(que,target);
	return que;
}

talker_queadd(target,que)
{
	if(!isdefined(target))
		return;
	que = talker_add_to_arrayfinotinarray( que, target );
	return que;
}

talker_add_to_arrayfinotinarray(array,ent)
{
	doadd = 1;
	if(isdefined(array))
		for(i=0;i<array.size;i++)
		{
			if(array[i] == ent)
				doadd = 0;
		}
	if(doadd == 1)
	{

		array = maps\_utility::add_to_array (array, ent);

	}
	return array;
}

pricetalk()
{
	self waittill ("trigger");
	if(isdefined(self.target))
		target = getent(self.target,"targetname");
	if(isdefined(target) && target.health > 0)
	{
		if(isdefined(self.script_noteworthy))
			level.price talker(self.script_noteworthy);

	}
	else if(!(isdefined(target)))
	{
		if(isdefined(self.script_noteworthy))
		{
			level.price talker(self.script_noteworthy);
		}
	}
}

accuracylower()
{
	self.script_accuracystationaryMod = .4;
	self.script_accuracy = .43;

	self waittill("spawned",other);
	waitframe();
	if(isdefined(other) && isalive(other))
	{
		other.dropweapon = false;
		other.favoriteenemy = level.player;
	}
}

reenforceguys()
{
	ai = [];

	ai = getaiarray("axis");
	for(i=0;i<ai.size;i++)
		ai[i] thread reenforce();
	maxsize = 8;
	level endon ("stopreenforce");
	level.cycle = 0;
	renforce = getentarray("renforcer","targetname");
	ai = getaiarray("axis");
	while(ai.size < maxsize)
	{
		spawned = renforce[level.cycle] stalingradspawn();  // these guys spawn behind a bush in the distance while the player is locked in the truck
		if(isdefined(spawned))
			spawned thread reenforce();
		renforce[level.cycle].count = 1;
		level.cycle++;
		if(level.cycle >= renforce.size)
			level.cycle = 0;
		ai = getaiarray("axis");
	}

	while(1)
	{
		level waittill ("reenforce");
		ai = getaiarray("axis");
		if(ai.size < maxsize)
		{
			spawned = renforce[level.cycle] stalingradspawn();  // these guys spawn behind a bush in the distance while the player is locked in the truck
			if(isdefined(spawned))
				spawned thread reenforce();
			renforce[level.cycle].count = 1;
			level.cycle++;
			if(level.cycle >= renforce.size)
				level.cycle = 0;
		}
	}
}

reenforce()
{
	self.dropweapon = 0;
	self waittill ("death");
	level notify ("reenforce");
}

trigger_treefaller_wait()
{
	self waittill ("trigger");
	pusher = getent(self.target,"targetname");
	tree = getent(pusher.target,"targetname");
	treefall(tree,pusher);
}

treefall(tree,triggerer)
{
	angle = vectortoangles((triggerer.origin)- tree.origin);
	triggerer.angles = angle;
	treeorg = spawn("script_origin", tree.origin);
	treeorg.origin = tree.origin;
	treeorg.angles = triggerer.angles;
	treeorg playsound ("tankdrive_treefall");
	tree playsound ("mortar_explosion");
	fx = loadfx("fx/explosions/explosion1.efx");
	playfx(fx,triggerer.origin);
 	treeang = tree.angles;
	ang = treeorg.angles;
	org = triggerer.origin;
	pos1 = (org[0],org[1],0);
	org = tree.origin;
	pos2 = (org[0],org[1],0);
	treeorg.angles = vectortoangles(pos1 - pos2);
	tree linkto(treeorg);
	treeorg rotatepitch(-83,1.1,.05,.2);
	treeorg waittill("rotatedone");
	treeorg rotatepitch(5,.21,.05,.15);
	treeorg waittill("rotatedone");
	treeorg rotatepitch(-5,.26,.15,.1);
	treeorg waittill("rotatedone");
	tree unlink();
	treeorg delete();
}

getout()
{
	while(1)
	{
		if(getcvar("getout") != "off")
		{

			level.player unlink();
			setcvar("getout","off");
		}
		wait .1;
	}
}

countai()
{
	while(1)
	{
		ai = getaiarray();
		wait 1;
	}
}

trigger_trucksplasher_wait()
{
	self waittill ("trigger",other );
	if(isdefined(other))
		other thread truckwatersplash();
}

truckwatersplash()
{
	time = gettime();
	while(1)
	{
		if(self.origin[2] < -494)
			break;
		waitframe();
	}
	timed = gettime() - time;
	self playsound ("truck_splash");
	maps\_fx::OneShotfx("truckwatersplash", self.origin,0);
}

deleteguysnotintriggers(triggers)
{
	ai= getaiarray("axis");
	for(j=0;j<ai.size;j++)
	for(i=0;i<triggers.size;i++)
	{
		if(!(ai[j] istouching(triggers[i])))
			ai[j] delete();
	}
}

takeshot()
{
	self waittill ("trigger");
	chaser = getent("auto1469","targetname");
	if(isdefined(chaser))
	{
		org1 = level.playertruck.origin;
		ang1 = level.playertruck.angles;
		org2 = chaser.origin;
		ang2 = chaser.angles;
	}
}

showshot()
{
	chaser = spawn("script_model",(-14465.41, 37705.74, 2350.25));
	chaser.angles = (14.85, 95.28, 2.27);
	pltruck = spawn("script_model",(-14312.29, 37667.36, 2351.92));
	pltruck.angles = (16.51, 99.70, -2.98);
	chaser setmodel("xmodel/vehicle_german_truck");
	pltruck setmodel("xmodel/vehicle_german_truck_truckride");
	level.player setorigin(pltruck.origin);
	
	level waittill ("never");
}

trigger_aiclear_wait()
{
	self waittill ("trigger");
	ai = getaiarray();
	for(i=0;i<ai.size;i++)
	{
		if(!(ai[i] istouching(self)) && !isdefined(ai[i].script_vehiclegroup) && ai[i] != level.waters && ai[i] != level.price)
		{
			ai[i] delete();
		}
	}
}

watersandpricesetup()
{
	character\waters::precache();
	character\price::precache();
	waters = getent("waters","targetname");
	price = getent("driver","targetname");
	waters thread waterswaitspawn();
	price thread pricewaitspawn();
	waters.script_friendname = "Sgt. Waters";
	price.script_friendname = "Cpt. Price";
}

waterswaitspawn()
{
	self.script_friendname = "Sgt Waters"; //overrides wrong friendname set in map
	self waittill ("spawned",waters);
	waters character\_utility::new();
	waters character\waters::main();
	waters.accuracy = 1;
	waters.accuracystationarymod = 1;
}

pricewaitspawn()
{
	self.script_friendname = "Cpt Price";  //overrides wrong friendname set in map
	self.script_ignoreme = 1;
	self waittill ("spawned",price);
	price character\_utility::new();
	price character\price::main();
	price.ignoreme = 1;
}

lazyplayerkiller()
{
	level endon ("stopreenforce");
	trigger = getent("bridgeenemydest","targetname");
	trigger.enemies = [];
	count = 0;

	skill = getdifficulty();
	if(skill == ("easy"))
		allowedbridgecrossers = 6;
	else
		allowedbridgecrossers = 4;
	
	while(count < allowedbridgecrossers)
	{
		enemycount = trigger.enemies.size;
		trigger waittill ("trigger",other);
		trigger.enemies = add_to_arrayfinotinarray( trigger.enemies, other );
		trigger thread removefromqueondeath(other);
		if(isdefined(trigger.enemies) && trigger.enemies.size > enemycount)
		{
			count++;
		}

	}
	blocker = getent ("watersblocker","targetname");
	if(isdefined(blocker))
		blocker delete();
	level.waters notify ("stop magic bullet shield");
	waitframe();
	level.waters.allowdeath = 1;
	level.waters.ignoreme = 0;
	level.waters.health = 300;
	level thread missionfailonmydeath(level.waters);
	thread raiseallaccuracy();
}

missionfailonmydeath(waters)
{
	level endon ("Objective 2 Completed");
	waters waittill("death");
	thread failedmessagefromdeath();

}

failedmessagefromdeath()
{
	objective_state(1, "failed");
	objective_state(2, "failed");
	wait 1;
	setCvar("ui_deadquote", "@TRUCKRIDE_FAILED_TO_COVER_SGT_WATERS");
	missionfailed();
}

removefromqueondeath(other)
{
	other waittill("death");
	if(isdefined(self.enemies))
		self.enemies = maps\_utility::array_remove(self.enemies,other);
}

add_to_arrayfinotinarray(array,ent)
{
	doadd = 1;
	if(isdefined(array))
		for(i=0;i<array.size;i++)
		{
			if(array[i] == ent)
				doadd = 0;
		}
	if(doadd == 1)
	{

		array = maps\_utility::add_to_array (array, ent);

	}
	return array;
}

raiseallaccuracy()
{
	node = getnode("auto1288","targetname");
	ai = getaiarray("axis");
	for(i=0;i<ai.size;i++)
	{
		ai[i] thread accuracyraise(node);
	}
}

accuracyraise(node)
{
	self.weapon = "mp44";
	self.accuracy = 1;
	self.accuracystationarymod = 1;
	self.favoriteenemy = level.waters;

	self setgoalnode (node);
	self.goalradius = 768;
}

waterstalkkubelandtruck()
{
	level endon ("donttalkofkubel");
	trigger = getent("waterstalklorrykubel","targetname");
	trigger waittill("trigger");
	kubel = getent("auto1055","targetname");
	truck = getent("auto1056","targetname");
	vehicles = 2;

	if(!(kubel.health > 0))
		vehicles --;
	else
		kubel thread kubeldeathreport();

	if(!(truck.health > 0))
		vehicles --;
	else
		truck thread truckdeathreport();
	
	if(vehicles == 2)
		level.waters thread talker("truckride_waters_anotherlorry",1);

	while(vehicles > 0)
	{
		level waittill ("waterstalkkubelandtruck");
		if(!(vehicles > 0))
			break;

		if(kubel.health > 0)
		{
			level.waters thread talker("truckride_waters_onedown",1);
			level.waters thread talker("truckride_waters_kubelstill",1);

		}
		else if(truck.health > 0)
		{
			level.waters thread talker("truckride_waters_onedown",1);
			level.waters thread talker("truckride_waters_lorrystill",1);
		}
	}
}

truckdeathreport()
{
	if(!(self.health > 0))
		return;
	self waittill ("death");
	level notify ("waterstalkkubelandtruck");
}

kubeldeathreport()
{
	if(!(self.health > 0))
		return;
	self waittill ("death");
	level notify ("waterstalkkubelandtruck");
}

bridgeholdpanzer()
{
	level.bridgeholdpanzer = 0;
	self waittill ("trigger");
	level.bridgeholdpanzer = 1;
}

allowfewinarea()
{
	trigger = getent("movenonallowedguys","targetname");
	targ = getnode(trigger.target,"targetname");
	ai = getaiarray("axis");
	count = 0;
	newai = [];
	for(i=0;i<ai.size;i++)
	{
		if(ai[i] istouching(trigger))
		{
			newai[newai.size] = ai[i];
			count++;
		}
	}
	num = 0;
	while(count > 3)
	{
		newai[num] thread gotothestuff(targ);
		num++;
		count--;
	}
}

gotothestuff(targ)
{
	self setgoalnode(targ);
	self.goalradius = 512;
}

truckrideaiocclude()
{
	trigger = getent("truckrideaiocclude","targetname");
	ai = getaiarray("axis");
	for(i=0;i<ai.size;i++)
	{
		if(!(ai[i] istouching(trigger)))
		{
			if(isdefined(ai[i].script_vehiclegroup))
			if(ai[i].script_vehiclegroup == 8 || ai[i].script_vehiclegroup == 12)
				continue;
			ai[i] delete();
		}
	}
}

throwgunawayatgoal()
{
	level.waters waittill ("goal");
}