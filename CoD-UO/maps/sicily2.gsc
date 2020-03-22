main()
{
//	setExpFog(.0000144, 0.5, 0.52, 0.70, 0); 

	/*
	tag positione
	**back of tr*
	1	2   
	3	4   
	5	6   
	7	8   
	    0       
*/       
	playerbike = getent("player_vehicle","targetname");
	playerbike.vehicletype = "GermanBMW";
	healthpacks = getentarray("bikehealth","targetname");
	for(i=0;i<healthpacks.size;i++)
	{
		healthpacks[i].origin += (12,0,-22);
		healthpacks[i] linkto (playerbike,"tag_body");
	}
	
	level.scr_sound["fruitstand"] = "fence_crash";
	
	level.vehiclegroupcontrol["maxoffset"]	[7] = 200;		// how bad they will mis
	level.vehiclegroupcontrol["shotramp"]	[7] = 25000; 		// time that it takes for shots to get zero'd in
	level.vehiclegroupcontrol["zerooffset"]	[7] = 10; 		// random offset shoot in a random range of 0 +or- half of this  

	level.vehiclegroupcontrol["maxoffset"]	[4] = 200;		// how bad they will mis
	level.vehiclegroupcontrol["shotramp"]	[4] = 13500; 		// time that it takes for shots to get zero'd in
	level.vehiclegroupcontrol["zerooffset"]	[4] = 70; 		// random offset shoot in a random range of 0 +or- half of this  
	

	level.vehiclegroupcontrol["maxoffset"]	[1] = 150;		// how bad they will mis
	level.vehiclegroupcontrol["shotramp"]	[1] = 12000; 		// time that it takes for shots to get zero'd in
	level.vehiclegroupcontrol["zerooffset"]	[1] = 60; 		// random offset shoot in a random range of 0 +or- half of this  


	level.truckguypositions[1][0] = 0; //probably good to leave position 0 as driver
	level.truckguypositions[1][1] = 2;
	level.truckguypositions[1][2] = 6;
	level.truckguypositions[1][3] = 8;
	level.truckguypositions[1][4] = 4;
	level.truckguypositions[1][5] = 1;
	level.truckguypositions[1][6] = 3;
	level.truckguypositions[1][7] = 5;
	level.truckguypositions[1][8] = 7;
	
	level.truckguypositions[17][0] = 0; //probably good to leave position 0 as driver
	level.truckguypositions[17][1] = 7;
	level.truckguypositions[17][2] = 5;
	level.truckguypositions[17][3] = 3;
	level.truckguypositions[17][4] = 1;
	level.truckguypositions[17][5] = 2;
	level.truckguypositions[17][6] = 4;
	level.truckguypositions[17][7] = 6;
	level.truckguypositions[17][8] = 8;

	level.truckguypositions[13][0] = 0; //probably good to leave position 0 as driver
	level.truckguypositions[13][1] = 2;
	level.truckguypositions[13][2] = 6; 
	level.truckguypositions[13][3] = 8;
	level.truckguypositions[13][4] = 4;
	level.truckguypositions[13][5] = 1;
	level.truckguypositions[13][6] = 3;
	level.truckguypositions[13][7] = 5;
	level.truckguypositions[13][8] = 7;

	level.truckguypositions[6][0] = 0; //probably good to leave position 0 as driver
	level.truckguypositions[6][1] = 1;
	level.truckguypositions[6][2] = 5; 
	level.truckguypositions[6][3] = 3;
	level.truckguypositions[6][4] = 4;
	level.truckguypositions[6][5] = 2;
	level.truckguypositions[6][6] = 6;
	level.truckguypositions[6][7] = 8;
	level.truckguypositions[6][8] = 7;

	level.truckguypositions[21][0] = 0; //probably good to leave position 0 as driver
	level.truckguypositions[21][1] = 1;
	level.truckguypositions[21][2] = 5; 
	level.truckguypositions[21][3] = 3;
	level.truckguypositions[21][4] = 4;
	level.truckguypositions[21][5] = 2;
	level.truckguypositions[21][6] = 6;
	level.truckguypositions[21][7] = 8;
	level.truckguypositions[21][8] = 7;
	
	level.truckguypositions[7][0] = 0; //probably good to leave position 0 as driver
	level.truckguypositions[7][1] = 1;
	level.truckguypositions[7][2] = 5; 
	level.truckguypositions[7][3] = 3;
	level.truckguypositions[7][4] = 4;
	level.truckguypositions[7][5] = 2;
	level.truckguypositions[7][6] = 6;
	level.truckguypositions[7][7] = 8;
	level.truckguypositions[7][8] = 7;


	level.ambient_track["ambient_sicily2_int"] = "ambient_sicily2_int";
	level.ambient_track["Ambient_sicily2_int"] = "ambient_sicily2_int";
	level.ambient_track["Ambient_sicily2_ext"] = "ambient_sicily2_ext";
	level.ambient_track["Ambient_sicily2_village_int"] = "ambient_sicily2_village_int";
	level.ambient_track["Ambient_sicily2_village_ext"] = "ambient_sicily2_village_ext";
	level.ambient_track["Ambient_sicily2_shoreline"] = "ambient_sicily2_shoreline";	
	maps\sicily2_fx::main();

	if(getcvar("ingramreport") == "")
		setcvar("ingramreport","off");
	maps\sicily2_anim::main();
	maps\_treadfx_gmi::main();
	maps\_truck_gmi::main();
	maps\_kubelwagon_gmi::main();
	maps\_bmwbike_gmi::main();
	maps\_panzeriv_gmi::main();
	maps\_boat_gmi::main();
	maps\_ptboat_gmi::main();
	maps\_music_gmi::main();
	maps\_ptboat_player_gmi::main();
	maps\_halftrack_gmi::precache();
	precacheshader("black");
	precacheShader( "gfx/hud/tankhudhealthbar" );
	precacheShader( "gfx/hud/tankhudhealthbar2" );  //test
	precacheShader( "gfx/hud/tankhudback" );
	precachemodel("xmodel/v_ge_sea_view_ptboat");
	precachemodel("xmodel/w_br_smg_sten_silenced_world");
	precachemodel("xmodel/v_br_sea_fishing-boat_dmg");
	precacheitem("webley");
	precacheitem("Med Health");
	precachemodel("xmodel/w_br_pst_webley_world"); 
	precacheShellshock("default_nomusic");
	precachemodel("xmodel/vehicle_tank_panzeriv_machinegun"); // put this in panzeriv_gmi.gsc
	precachemodel("xmodel/v_br_sea_sicily2_fishingboat");
	precacheItem("sten_silenced");
	precacheitem("panzerfaust");
	
	
	level.friendboatisatheock = 0;
	level.friendboatsprayfx = loadfx("fx/vehicle/watersprayboat_pt.efx");
	level.friendptboatwakefx= loadfx("fx/vehicle/wakeboat_pt.efx");
	level.boatspark = loadfx("fx/impacts/metalhit_large.efx");
	level.buddyisonboat = 0;

	maps\truckride_anim::main();	

	maps\_utility_gmi::array_levelthread(getentarray("pot","targetname"), ::pots);
	maps\_utility_gmi::array_levelthread(getentarray("pots","targetname"), ::pots); //oops.. heh  I fix my map errors with script!! =/
	maps\_utility_gmi::array_levelthread(getentarray("clipremove","targetname"), ::clipremove);
	maps\_utility_gmi::array_levelthread(getentarray("conditionaldeathmessage","targetname"), ::trigger_conditionaldeathmessage);
	maps\_utility_gmi::array_levelthread(getentarray("soundtrigger","target"), ::trigger_soundtrigger);
	

	thread trigger_setup_explodercrash();  //have to do this before load so that trigger doesn't turn into an exploder.
	thread trigger_setup_vehicleevent(); // generic trigger that will notify vehice an event when it's hit use to make vehicles do stuff at triggers.
	thread trigger_setup_vehiclenotify(); // notify the vehicle a groupedanimevent

	maps\_load_gmi::main();
	thread damagereport();
	maps\sicily2_fx::main();
	level.scr_sound["fruitstand"] = "fence_crash";
	startvar = getcvar("start");

	level.player setplayerangles(level.player.angles+ (0,190,0));
	
	thread seagulls_go();
	maps\_vehiclechase_gmi::main();
	thread objectives();
	thread setup_grenadethrowtrigs();


	//&&&&&&&&&&&  Debug stuff - ts
//	level thread tellmeifplayerhealthisovermax();
	//&&&&&&&&&&&


	buddy = getent("buddy","targetname");
	buddy thread maps\_utility::magic_bullet_shield();
//	buddy.accuracy = 1; // make him baddass
	
	level.buddy = buddy; // main characters get asigned to global variables!
	 
	buddy character\_utility::new();
	buddy character\ally_british_ingram::main();
	buddy.name = "Major Ingram";

	level.onfoot = 0;

	if(startvar == "onfoot" || startvar == "onfootdownhill" || startvar == "tophill" || startvar == "bottomhill")
	{
		level.onfoot = 1;
			
	}
	else
	{
		playerbike = getent("player_vehicle","targetname");
		playerbike.vehicletype = "GermanBMW";

	}

	thread healthpackhandle(healthpacks);
	
	startspots = getentarray("startspot","targetname");
	if(!level.onfoot)
	{
		level.player allowStand(false);
		level.player allowCrouch(true);
		level.player allowProne(false);
		level.player setorigin ((playerbike getTagOrigin ("tag_player")));
		level.player linkto(playerbike,"tag_passenger");
//		level.player playerlinkto(playerbike,"tag_player",( 0.1, .2, 0.9 ));
		playerbike thread playervehicleaction(buddy);	
	}
	else  //put the player in different start spots
	{
		for(i=0;i<startspots.size;i++)
		{
			if(startspots[i].script_noteworthy == startvar)
			{
				level.player setorigin (startspots[i].origin);
				buddy teleport (level.player.origin + (0,0,256));
				buddy.followmax = 1;
				buddy.followmin = 0;
	
			}
		}
	}

	if(!(level.onfoot))
	{
		if(level.script == "sicily2")
			thread music();
		thread truckchicken(playerbike);
		thread roadblock(playerbike);
		thread ohnoatruckisblockingthepath(playerbike);
		thread playerbmwwreck();
		
	}
	// specialtriggered sequences // 	
	if(startvar != "bottomhill")
	{
		thread tank_cattleprod1();
		thread tank_cattleprod2();
		thread tank_cattleprod3();
		thread balconydoor1trig();
		thread fencebreak();
		thread breakthroughfencetrigger();

	}
	
	thread boatguydying();
	thread boatsequence();
	thread shootatfriendlyboat();
	thread ingramtalk(playerbike);
	thread truckshield();
	aicleartrigs = getentarray("aiclear","targetname");
	for(i=0;i<aicleartrigs.size;i++)
	{
		aicleartrigs[i] thread trigger_aiclear_wait();
	}
	///////////////////////////////
	axisspawners = getspawnerteamarray("axis");
	for(i=0;i<axisspawners.size;i++)
	{
		axisspawners[i] thread accuracylower();
	}
	if(startvar == "bottomhill")
	{
		ai = getspawnerarray();
		for(i=0;i<ai.size;i++)
		{
			if(isdefined(ai[i].targetname) && (ai[i].targetname == ("flakguards") || ai[i].targetname == ("auto2435")))
			ai[i] dospawn();
		}


	}
	thread waterdamage();
	
	thread triggers_changefollow();
	thread boatsetup();
	
	thread cliffboats();
	level.player maps\_loadout_gmi::refill_ammo();
	
	ai = getspawnerarray();
	for(i=0;i<ai.size;i++)
	{
		if(isdefined(ai[i].target) && ai[i].target == "natestah1623")
			ai[i] thread barricade_panzershrekguy(playerbike);
	}
	
	wait .5;
		level.player allowStand(true);	
//	iprintlnbold(&"GMI_SICILY2_WHILE_RIDING_THE_BMW");

	
	
	
//	level.player thread tempregen();
}
barricade_panzershrekguy(playerbike)
{
	self waittill ("spawned",guy);
	guy endon ("death");
	guy.pacifist = true;
	guy.pacifistwait = 9999999;
	guy.ignoreme = true;
	wait 6;
	
	
	targ = spawn("script_origin", level.player.origin+(0,0,4));
	guy.pacifist = true;
	guy.pacifistwait = 9999999;
	guy.ignoreme = true;

	
	wait .15;
	guy animscripts\combat_gmi::fireattarget((0,0,0), .58, "forceShoot", false, targ, true);
	guy shoot ( 1 , targ.origin );	
//	targ delete();
}

damagereport()
{
	return; 
	while(1)
	{
		level.player waittill ("damage", dmg, who, dir, point, mod);
		if(isdefined(who) && isdefined(who.script_vehiclegroup))
			iprintlnbold("damaged comes from vehiclegroup", who.script_vehiclegroup);
	}
}

healthpackhandle(healthpacks)
{
	message = &"CGAME_PICKUPHEALTH";
	level.health_cursorhinticon = "gfx/icons/hint_health.dds";
	
	fontscale = ".86";
	ymessage = 317;
	xoffset = 255;
	messagespace = 40;
/*
	////////one///
	level.health_cursorhintmessagepart1 = newHudElem();
	level.health_cursorhintmessagepart1.alignX = "right";
	level.health_cursorhintmessagepart1.alignY = "bottom";

	level.health_cursorhintmessagepart1.fontscale = fontscale;
	level.health_cursorhintmessagepart1.alpha = 0;

	level.health_cursorhintmessagepart1.x = xoffset;
	level.health_cursorhintmessagepart1.y = ymessage;
	level.health_cursorhintmessagepart1.color = (1, 1, 1);	
	level.health_cursorhintmessagepart1.label = &"GMI_SICILY2_PRESS_USE_";	


	///////two///
	level.health_cursorhintmessagepart2 = newHudElem();
	level.health_cursorhintmessagepart2.alignX = "right";
	level.health_cursorhintmessagepart2.alignY = "bottom";

	level.health_cursorhintmessagepart2.fontscale = fontscale;
	level.health_cursorhintmessagepart2.alpha = 0;
	
	level.health_cursorhintmessagepart2.x = xoffset+messagespace;
	level.health_cursorhintmessagepart2.y = ymessage;
	level.health_cursorhintmessagepart2.color = (1, 1, 1);	
	level.health_cursorhintmessagepart2.label = getkeybinding("+activate")["key1"];
		
	///////three///
	level.health_cursorhintmessagepart3 = newHudElem();
	level.health_cursorhintmessagepart3.alignX = "left";
	level.health_cursorhintmessagepart3.alignY = "bottom";

	level.health_cursorhintmessagepart3.fontscale = fontscale;
	level.health_cursorhintmessagepart3.alpha = 0;

	level.health_cursorhintmessagepart3.x = xoffset+messagespace;
	level.health_cursorhintmessagepart3.y = ymessage;
	level.health_cursorhintmessagepart3.color = (1, 1, 1);	
	level.health_cursorhintmessagepart3.label = &"GMI_SICILY2__TO_PICKUP_HEALTH";	





*/

			
	
	
	level.health_cursorhint = newHudElem();
	level.health_cursorhint.alignX = "center";
	level.health_cursorhint.alignY = "bottom";

	level.health_cursorhint.fontscale = "1";
	level.health_cursorhint.alpha = 0;

	level.health_cursorhint.x = 320;
	level.health_cursorhint.y = 365;
	level.health_cursorhint.color = (1, 1, 1);

	level.health_cursorhint setShader(level.health_cursorhinticon, 40, 40);	
//	level.health_cursorhint settext(&"CGAME_PICKUPHEALTH", getkeybinding("+activate")["key1"]);  // this doesn't work.. iprintlnbold it is!
	

	if(getcvar("start") == "boat")
		return;

	count = 0;
	messagetime = 5000;
	timer = gettime()+messagetime;
	hudiconactive = false;
	while(count < 2 && !level.onfoot)
	{
		if(!(hudiconactive) && level.player.health < level.player.maxhealth*.6)
		{
			hudiconactive = true;
			level.health_cursorhint.alpha = 1;
//			level.health_cursorhintmessagepart1.alpha = 1;
//			level.health_cursorhintmessagepart2.alpha = 1;
//			level.health_cursorhintmessagepart3.alpha = 1;
		}
		
		if(level.player usebuttonpressed())
		if(level.player.health < level.player.maxhealth)
		{
			
			
			newhealth = level.player.health+ level.player.maxhealth/2;
			if(newhealth > level.player.maxhealth)
				level.player.health = level.player.maxhealth;
			else
				level.player.health+= newhealth;
			healthpacks[count] delete();
			count++;
			level.health_cursorhint.alpha = 0;
//			level.health_cursorhintmessagepart1.alpha = 0;
//			level.health_cursorhintmessagepart2.alpha = 0;
//			level.health_cursorhintmessagepart3.alpha = 0;
			hudiconactive = false;
			wait 1;
			continue;
		}
		wait .05;
	}
	while(count < 2)
	{
		healthpacks[count] delete();
		count++;
	}
	level.health_cursorhint destroy();
//	level.health_cursorhintmessagepart1 destroy();
//	level.health_cursorhintmessagepart2 destroy();
//	level.health_cursorhintmessagepart3 destroy();
}

tempregen()  /// temp
{
	level endon ("onfoot");
	while(1)
	{
//		if(self.health < 0 && self.health < self.maxhealth/2)
//			self.health += self.maxhealth/3;
//		self maps\_loadout_gmi::refill_ammo();
		wait 10;	
	}
}


truckshield()
{
	while(1)
	{
		level waittill("vehiclespawned",vehicle);
		if(vehicle.model == "xmodel/v_ge_lnd_truck_lowbed")
			vehicle thread truckshieldgo();
		if(vehicle.targetname == "auto2412")
			vehicle thread crashatendofpath();
			
		vehicle = undefined;
	}	
}

crashatendofpath()  // quick hack to make a vehicle make a crash sound at the end of its path
{
	self waittill ("reached_end_node");
	self playsound ("vehicle_impact");
}

truckshieldgo()
{
	self endon ("removeshield");
	while(1)
	{
		self waittill ("damage",amount); 
		if(self.health > 0 && amount < 1000)
			self.health += amount;
		else
			break;
	}
	
}
drawtargetname()
{
	while(1)
	{
		print3d (self.origin + (0,0,55), self.targetname, (1,1,1), 1);
		wait .05;
		
	}
}
waterdamage()
{
	watertrigger = getent("water","targetname");
	if(!isdefined(watertrigger))
		return; // for compiling without the layer
	watertrigger thread hidewateruntillisayso();
	watertrigger settakedamage(true);
	while(1)
	{
		watertrigger waittill("damage",dmg,who,dir,point,mod);
		if(who.classname == "script_vehicle" || who.classname == "misc_turret" || who.classname == "worldspawn")
		{
			playfx(level._effect["watersplashbigguns"],point);
		}
	}
}

hidewateruntillisayso()  // water is a big entity because I didn't want to deal with trying to get it to react to projectiles and stuff so here I'm hiding it since it has a tendancy to be drawn even though it's not visible. should save some framerate in the bike ride.
{
	self hide();
	level waittill ("turn on water");
	self show();
}


roadblock(playerbike)
{
	trigger = getent("roadblock","targetname");
	if(!isdefined(trigger))
	{
		return; // for compiling without the layer..
	}
	trigger waittill ("trigger");
	playerbike notify ("groupedanimevent","fire");
	playerbike setspeed (10,10);
	wait .5;
	playerbike notify ("stopfiring");
	playerbike.driver.idling = 1;
	playerbike notify ("groupedanimevent","idle");
	wait .5;
	playerbike resumespeed(15);
}

truckchicken(playerbike)
{
	trigger = getent("truckchicken","targetname");
	if(!isdefined(trigger))
	{
		return; /// case map is compiled without the layer
	}
	trigger waittill ("trigger");
	playerbike notify ("groupedanimevent","fire");
	playerbike setspeed (15,15);
	wait 5;
	playerbike notify ("stopfiring");
	playerbike.driver.idling = 1;
	playerbike notify ("groupedanimevent","idle");
	wait 1;
	

	playerbike resumespeed(15);
}






music()
{
	level thread music_bikeride();
	level waittill ("end bike ride music");
	level notify ("new music");
	musicstop(.1);
	wait .2;
	level thread music_footpath();
	level waittill ("start boatride music");
	level notify ("new music");
	musicstop(.05);
	wait .1;
	level thread music_boatride();
	level waittill ("last boats destroyed");
	level notify ("new music");
	musicstop(8);
}

music_bikeride()
{
	level endon ("new music");
	while(1)
	{
		musicplay("sicily2_bikeride");
		wait level.musiclength["sicily2_bikeride"];
	}
	
}
music_boatride()
{
	level endon ("new music");
	while(1)
	{
		musicplay("sicily2_bikeride");
		wait level.musiclength["sicily2_bikeride"];
	}
	
}

music_footpath()
{
	level endon ("new music");
	while(1)
	{
		musicplay("sicily2_onfoot_1");
		wait (level.musiclength["sicily2_onfoot_1"]);
		musicstop(.1);
		wait(.3);
		musicplay("sicily2_onfoot_2");
		wait (level.musiclength["sicily2_onfoot_2"]-4);
		musicstop(.1);
		wait(.2);
	}
}



//=====================================================================================================================
//AMBIENT SEAGULLS
//=====================================================================================================================
#using_animtree("sicily2_dummies_path");
seagulls_go()
{
	println("SEAGULLS HAVE GO GO GO GO GO GO!");

	level.anim_wait[0] = 80;
	level.anim_wait[1] = 94;
	level.anim_wait[2] = 118;
	level.anim_wait[3] = 135;
	level.anim_wait[4] = 139;
	level.anim_wait[5] = 87;
	level.anim_wait[6] = 111;
//	(pos, model, total_tags, angle_offset, loop_time, loop_num, path_anim, anim_wait)
	level thread maps\sicily2_dummies::dummies_setup( (8953, -12000, -220) , "xmodel/sicily2_dummies_seagulls_a", 7, ( 0, 0, 0) , 12, 1000, %sicily2_dummies_seagulls_a, 0);
}

playervehicleaction(buddy)
{
	if(getcvar("start") == "boat")
		return; // I make a mess..
	outsidewindow = getnode("outsidewindow","targetname"); //outside window is a node of course grr.
	trigger = getent("windowkicktrig","targetname");
	window = getent("windowkickerouter","target");  //breaking glass
//	window disconnectpaths();
	kickdoor =getnode("kickdoor","targetname");
	node = getnode("buddyhole","targetname");
	thread maps\_bmwbikedriver_gmi::main(buddy);
	self waittill ("reached_end_node");
	buddy thread rollandthendostuff(node,kickdoor,window,trigger,outsidewindow); //must get some sleep
	level.player unlink();
	wait .05;
	self delete();

}




//*************************************

//*************************************
#using_animtree("generic_human");
//*************************************

//*************************************


boatguydying()
{
////	ent_trigger = getent("boatguy","target"); 
//	ent_trigger waittill ("trigger");
	fishboat = getent("fishboat","targetname");
	boatguyspawner = getent("boatguy","targetname");
	if(!isdefined(boatguyspawner)) //map can be compiled without this layer turned on
		return;
	boatguyspawner waittill("spawned",ai_boatguy);
	
	ai_boatguy.accuracy = 0; // he keeps killing everybody before I get there heh.
	ai_boatguy.accuracystationarymod = 0;
	ent_frienddeathtrig = getent("frienddeath","targetname");
	boatguy = getent("buddy","targetname");

	ai_boatguy thread maps\_utility::magic_bullet_shield();
//	boatguy thread maps\_utility::magic_bullet_shield();

	ent_frienddeathtrig waittill("trigger");
	ai_boatguy notify ("stop magic bullet shield");
	
	explosionorg = fishboat.origin;
	

	
	targettrigger = getent("boatdamage","targetname");
	targ = spawn("script_origin", explosionorg);
	spawners = getspawnerarray();
	for(i=0;i<spawners.size;i++)
	{
		if(isdefined(spawners[i].targetname) && spawners[i].targetname == "rocketman")
		{
			rocketman = spawners[i] stalingradspawn();
			rocketman.pacifist = true;
			rocketman.pacifistwait = 9999999;
			rocketman.ignoreme = true;
		}
	}

	wait .3;
	thread maps\_utility_gmi::playSoundinSpace ("weap_bazooka_fire",(11112,-11031,202));
	rocketman animscripts\combat_gmi::fireattarget((0,0,0), .58, "forceShoot", false, targ, true);
	rocketman shoot ( 1 , targ.origin );
	rocketman delete();
		
	targettrigger waittill ("damage");
	
	fishboat setmodel("xmodel/v_br_sea_fishing-boat_dmg");
	fishboat.origin += (0,0,-48);
	playfx(level._effect["boatblow"], fishboat.origin);
		
	thread maps\_utility_gmi::playSoundinSpace ("Explo_boat",explosionorg);
	org = spawn ("script_origin",(0,0,1));
	org.origin = explosionorg;
//	org.origin = level.player.origin;

	org playloopsound("truckfire_high");
	wait .2;
	
	
	ai_boatguy doDamage ( ai_boatguy.health + 50, ai_boatguy.origin + (0,0,100) );
//	drawthing("boatguy",level.player,offset,(1,0,0),5);
	wait 63;
	org stoploopsound("truckfire_high");
	org delete();
	
}



ingramtalk(playerbike)
{
	level.player thread talkhandle();
	triggers = getentarray("ingramtalk","target");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread ingramtalk_trigger(playerbike);
	}
}

ingramtalk_trigger(playerbike,nontrigger)
{
	if(!isdefined(nontrigger))
		self waittill ("trigger");
	if(getcvar("ingramreport") != "off")
		iprintlnbold("triggering ingram talk", self.script_noteworthy);
	if(isdefined(level.buddy) && isalive(level.buddy))
	{
		if(distance(level.player.origin,level.buddy.origin) > 200)
		{
			org = spawn("script_origin",level.player.origin);
			org linkto(level.player);
			level.buddy.goalradius = 200;
			level.buddy setgoalentity(org);
			level.buddy waittill ("goal");
			level.buddy setgoalentity(level.player);
			org delete();
			
		}
//		level.buddy thread lookatplayerfortime(3000);
//		level.buddy setanimknob(%eyes_lookup_30);

		if(!level.onfoot)
			playerbike notify ("groupedanimevent","talk");


//		level.buddy animscripts\face::sayspecificdialogue(level.scr_anim[self.script_noteworthy],self.script_noteworthy,1,"dialog_done");
	}
//	else
	level.player talkerque(self.script_noteworthy);

}

lookatplayerfortime(thetime) //test.. looks like turning the head is done via animation blending.
{
	timer = gettime()+thetime;
	while(gettime()<timer)
	{
		lookTargetPos = level.player geteye();
		self setLookAt(lookTargetPos);
		wait .05;
	}
	
}

talkhandle()
{
	self.talking = 0;
	while(1)
	{
		if(isdefined(self.talkque))
		{
			self.talking = 1;
			talker(self.talkque[0]);
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


talker(dialog,importance,notifystring)
{
	if(!isdefined(importance))
		importance = .7;
	if(isdefined(level.buddy) && isalive(level.buddy))
	{
		level.buddy animscripts\face::sayspecificdialogue(level.scr_anim[dialog],dialog,1,"facedone");
		level.buddy waittill ("facedone");
	}
	else
		self playSoundonobject(dialog,level.escapeboat); 
	if(isdefined(notifystring))
		self notify (notifystring);
}

talkerque(dialog,importance,notifystring)
{
	self.talkque = talker_queadd(dialog,self.talkque);
	self notify("talk update");
}

talker_queremove(dialog,que)
{
	if(!isdefined(que))
	{
		return;
	}
	que = maps\_utility::array_remove(que,dialog);
	return que;
}

talker_queadd(dialog,que)  //target being dialog.
{
	if(!isdefined(dialog))
		return;
	que = talker_add_to_arrayfinotinarray( que, dialog );
	return que;
}

talker_add_to_arrayfinotinarray(array,dialog)
{
	doadd = 1;
	if(isdefined(array))
		for(i=0;i<array.size;i++)
		{
			if(array[i] == dialog)
				doadd = 0;
		}
	if(doadd == 1)
	{

		array = maps\_utility::add_to_array (array, dialog);
	}
	return array;
}

playSoundonobject (alias, object)
{
	org = spawn ("script_origin",(0,0,1));
	org.origin = object.origin;
	org linkto (object);
	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}







breakthroughfencetrigger()
{
	 
	trigger = getent("breakthefence","targetname");
	if(!isdefined(trigger))
		return; //layer disabled..
	goalnode = getnode(trigger.target,"targetname");
	trigger waittill ("trigger");
	level.buddy setgoalnode(goalnode);
	level.buddy.goalradius = 0;
	level.buddy waittill ("goal");
	level.buddy animscripted("fencekick",goalnode.origin,goalnode.angles,%jump_over_low_wall);
	friendchain = getnode("auto1692","targetname"); // this is a nono done want to wait 7minutes for recompile //lazy bad er..
	level.buddy setgoalentity(level.player);
	level.player setfriendlychain(friendchain);
}

rollandthendostuff(node,kickdoor,window,trigger,outsidewindow)
{
	self notify ("stopdriving");	
	self.followmax = 2;
	self.followmin = 1;
	self.ignoreme = 1;
	self.weapon = "sten_silenced";
	self.hasweapon = true;
	self animscripts\shared::PutGunInHand("right");

//	self animscripted("animontagdone", self.origin+(0,0,-36), self.angles, %wagon_backleft_death_roll);
//	self animscripted("animontagdone", self.origin+(0,0,0), self.angles+(0,0,0), %c_gr_sicily2_driver_crash);
	self unlink();

	wait .5;  //give vehicle chance to delete before animation is finished.
//	self setgoalnode(node);
//	self.goalradius = 256;	
//	self waittill ("goal");
	self.supressionwait = 0;
//	level.buddy animscripts\face::sayspecificdialogue(level.scr_anim["ingram_bike_toast"],"ingram_bike_toast",1,eventnotify);
	

	while(!(level.player istouching(trigger))&& !(self istouching(trigger)))
	{
		trigger waittill ("trigger");
		wait .05;		
	}
	level.buddy animscripts\face::sayspecificdialogue(level.scr_anim["ingram_dead_end"],"ingram_dead_end",1,"facedone");
	level notify ("Ingram to safety");
	self setgoalnode(kickdoor);
	self.goalradius = 0;
	self waittill ("goal");
	
	self animscripted("doorkicked",kickdoor.origin,kickdoor.angles,%chateau_kickdoor1);
	wait .4;
	maps\_utility::exploder(11);
	if(isalive(window))
		window notify ("damage", 155);  //player can shoot the window out or this script will trigger it
	level.player playsound("boarded_window_kick");
	
//	window hide();
//	window notsolid();
//	window connectpaths();
	
	self setgoalnode(outsidewindow);
	self.goalradius = 32;
	self waittill ("goal");
	self.followmax = 1;
	self.followmin = -1;
	self setgoalentity (level.player);
	
	ai = getaiarray("axis");
	for(i=0;i<ai.size;i++)
	{
		ai[i].accuracy = .4;
		ai[i].accuracystationarymod = .4;
	}
	spawners = getspawnerarray();
	for(i=0;i<spawners.size;i++)
	{
		spawners[i].script_accuracy = .4;
		spawners[i].script_accuracystationarymod = .4;
	}
	
}


//********************************************************
//****************Begin grenade truck sequence************
//********************************************************
killskid()
{
	wait 2;
	self notify ("skidoff");
	
}


bmwwreckchasers(spawner)
{	
	while(1)
	{
		spawner waittill ("spawned",other);
		thread setgoalplayerongoal(other,1,500);
		other = undefined;
	}
}

windowchasers(guy)
{	
	setgoalplayerongoal(guy,5,600);
}


setgoalplayerongoal(guy,float_goalwait,int_endradius)
{
	if(!isdefined(int_endradius))
		int_endradius = 700;
	if(!isdefined(float_goalwait))
		float_goalwait = 4.0;
	if(!isalive(guy))
	{
		return;
	}
	guy endon ("death");
	guy waittill ("goal");
	wait float_goalwait;
	guy setgoalentity (level.player);
	while (isalive (guy))
	{
		if (guy.goalradius > int_endradius)
			guy.goalradius -= 200;
		else
			guy.goalradius = int_endradius;
		guy setgoalentity (level.player);

		wait 3;
	}
}


//********************************************************
//****************/end grenade truck sequence*************
//********************************************************

waitframe()
{
	wait .5;
}


///******************// oh no !!a truck is blocking the path!!!!//**********
//**************************************************************************
ohnoatruckisblockingthepath(playerbike)
{
	trigger = getent("ohnoatruckisblockingthepath","targetname");
	if(!isdefined(trigger))
		return; // layer isn't enabled..
	trigger waittill ("trigger");
	playerbike setspeed (4,25);
	wait 2;
	playerbike resumespeed(25);

	if( (level.player.health + level.player.maxhealth/3) < level.player.maxhealth )
	{
		level.player.health += level.player.maxhealth/3;
		//&&&&&&
		println("^5PLAYER HEALTH INCREASED BY ",level.player.maxhealth/3," AND IS NOW ",level.player.health,"...MAX HEALTH IS ", level.player.maxhealth);
		//&&&&&&
	}

	level.player.health += level.player.maxhealth/3;


	maps\_utility_gmi::autosave(3);
	level.player maps\_loadout_gmi::refill_ammo();


}

playerbmwwreck()
{

	spawners = getspawnerarray();
	for(i=0;i<spawners.size;i++)
		if(isdefined(spawners[i].script_noteworthy))
			if(spawners[i].script_noteworthy == "bmwchasers")
				thread bmwwreckchasers(spawners[i]);

//	maps\_utility_gmi::array_levelthread(getentarray("auto1475","targetname"), ::bmwwreckchasers);
	
	trigger = getent("playerbmwwreck","targetname");
	if(!isdefined(trigger))
	{
		return;  //layer disabled..
	}
//	dummybike = spawn ("script_model",(15795, -11862, 1288));  //somewhere around where it's supposed to be
//	dummybike hide();
	trigger waittill ("trigger", bike);
	level notify ("end bike ride music");
	level.player playsound ("vehicle_impact");
	thread maps\sicily2_anim::crashtiming(bike);
	level notify ("onfoot");
	level.onfoot = 1;
	thread spawnersdrophealth();

//	//main(duration, nMaxDamageBase, nRanDamageBase, nMinDamageBase, nExposed, customShellShock)
//	thread maps\_shellshock::main(3, undefined, undefined, undefined, undefined, "default_nomusic");
	earthquake(0.75, 2, level.player.origin, 2250);
	level.player shellshock("default_nomusic",4);
//	level.player shellshock("test",4);
	
	
//	dummybike.origin = bike.origin;
//	dummybike.angles = bike.angles;
//	dummybike show();
	bike hide();
	bike setspeed ((bike getspeedmph() *.7), 20);
//	bike setspeed (1,200);
//	wait .1;
//	bike resumespeed(200);
	wait 1;
	maps\_utility_gmi::autosave(4);
	
	wait 6;	
	level.player talkerque("ingram_continue_onfoot");	

//	level.buddy animscripts\face::sayspecificdialogue(level.scr_anim["ingram_continue_onfoot"],"ingram_continue_onfoot",1,undefined,1);
	wait 1;
}

spawnersdrophealth()
{
	spawners = getspawnerarray();
	for(i=0;i<spawners.size;i++)
	{
		wait .1; // lots of spawners to do the stuff with I guess (giving infinate loop errors)
		spawners[i] thread droprandomhealth();// probably not the official way to do this but I'm in a hurry!
	}
}

droprandomhealth()
{
	self waittill("spawned",other);
	if(isdefined(other.grenadeammo))
		other.grenades = 5;
	if(randomint(100)<50)
		other thread maps\_spawner_gmi::drophealth();
}


trigger_setup_explodercrash()
{
	explodercrash = getentarray("tgroupexplodercrash","targetname");
	for(i=0;i<explodercrash.size;i++)
	{
		explodercrash[i] thread trigger_explodercrash_wait();
	}
}

trigger_setup_vehicleevent()
{
	vehicleevent = getentarray("vehicleevent","targetname");
	for(i=0;i<vehicleevent.size;i++)
	{
		vehicleevent[i] thread trigger_vehicleevent_wait();
	}
}

trigger_vehicleevent_wait()
{

	if(!isdefined(self.script_noteworthy))
	{
		iprintlnbold("vehicleevent trigger without script_noteworthy at ", self getorigin());
		return;
	}
	while(1)
	{
		self waittill ("trigger",other);
		if(isalive(other) && isdefined(other.targetname) && other.targetname == self.target)
		{
			break;
		}
	}
	level notify (self.script_noteworthy,other);
}

trigger_explodercrash_wait()
{

	if(!isdefined(self.script_exploder))
	{
		iprintlnbold("exploder doesn't work at ", self getorigin());
		return;
	}
	explodergroup = self.script_exploder;
	self.script_exploder = undefined;
	while(1)
	{
		self waittill ("trigger",other);
		if(isalive(other) && isdefined(other.targetname) && other.targetname == self.target)
		{
			break;
		}
	}

	maps\_utility::exploder(explodergroup);
	if(explodergroup == 13)
	{

		playfxontag(level._effect["chicken"],other,"tag_fork");
		wait .3;
		playfxontag(level._effect["chicken"],other,"tag_fork");

	}
}

accuracylower()  //yanked from truckride
{
	level endon ("onfoot");
	self.script_accuracystationaryMod = 0;
	self.script_accuracy = 0;

	self waittill("spawned",other);
	waitframe();
	if(isdefined(other) && isalive(other))
	{
		other.dropweapon = false;
		other.favoriteenemy = level.player;
	}
}

tank_cattleprod1()
{
	fleenode1 = getnode("fleenode1","targetname");
	movecattleprodtank1 = getent("movecattleprodtank1","targetname");
	if(!isdefined(movecattleprodtank1))
		return;//layer disabled..
	level waittill ("cattleprod1", other);
	other setspeed (0,25);
	
	movecattleprodtank1 waittill ("trigger");
	ai = getaiarray("axis");
	nodes = getnodearray("gategotonodes1","targetname");
	for(i=0;i<ai.size;i++)
		ai[i] thread runtonode(nodes[randomint(nodes.size-1)]);


	if( (level.player.health + level.player.maxhealth/3) < level.player.maxhealth )
	{
		level.player.health += level.player.maxhealth/3;
		//&&&&&&
		println("^5PLAYER HEALTH INCREASED BY ",level.player.maxhealth/3," AND IS NOW ",level.player.health,"...MAX HEALTH IS ", level.player.maxhealth);
		//&&&&&&
	}

	maps\_utility_gmi::autosave(5);
	other.mgturret delete();
	other delete();
}

runtonode(node)
{
	self setgoalnode (node);
	self.goalradius = 47;
	thread windowchasers(self);
}


tank_cattleprod2()
{
//	fleenode2 = getnode("fleenode2","targetname");

	movecattleprodtank2 = getent("movecattleprodtank2","targetname");
	if(!isdefined(movecattleprodtank2))
		return; //layerdisabled
	level waittill ("cattleprod2", other);
	other setspeed (0,25);
	
	movecattleprodtank2 waittill ("trigger");
//	ai = getaiarray("axis");
//	for(i=0;i<ai.size;i++)
//		ai[i] thread fleeandbegone(fleenode1);

	other resumespeed(15);
	
}

tank_cattleprod3()
{
//	fleenode2 = getnode("fleenode2","targetname");
	gate = getent("halftrackgate","targetname");
	movecattleprodtank3 = getent("movecattleprodtank3","targetname");
	if(!isdefined(movecattleprodtank3))
		return;//layer disabled..
	movecattleprodtank3 thread tank_cattleprod3_thing();
	level waittill ("cattleprod3", other);
	other setspeed (0,25);
	other notify ("unload");
	other thread tank_cattleprod3_disconnectpath();
	if(level.cattleprodproceed == 0)
		movecattleprodtank3 waittill ("trigger");
	
//	ai = getaiarray("axis");
//	for(i=0;i<ai.size;i++)
//		ai[i] thread fleeandbegone(fleenode1);

	other resumespeed(15);
	other connectpaths();
	gate rotateYaw(90, .2, .1, .1);
	wait 5;
	gate rotateYaw(-90, .2, .1, .1);
}
tank_cattleprod3_disconnectpath()
{
	wait 1;
	self disconnectpaths();
}


tank_cattleprod3_thing()
{
	level.cattleprodproceed = 0;
	self waittill ("trigger");
	level.cattleprodproceed = 1;
}



fleeandbegone(node)  //run to a node and delete your self beoTCH
{
	self setgoalnode (node);
	self.goalradius = 128;
	self waittill ("goal");
	self delete();
}

balconydoor1trig()
{
	balconydoor1 = getent("balconydoor1","targetname");
	if(!isdefined(balconydoor1))
		return; //layer disabled..
	balconydoor1 notsolid();
	balconydoor1 connectpaths();
	balconydoor1trig = getent("balconydoor1trig","targetname");
	balconydoor1trig waittill("trigger");
	balconydoor1 rotateYaw(-90, .2, .1, .1);


}

fencebreak()
{
//	fencegate = getent ("fencegate","targetname");
//	fencegate notsolid();
//	fencegate connectpaths();
//	fencegate solid();
	fencebreak = getent("fencebreak","targetname");
	if(!isdefined(fencebreak))
		return; //layer disabled..
	fencebreak waittill ("trigger");
	fencebreak playsound("fence_crash");
	level notify ("fencebreak"); // updates objective position
	level notify ("turn on water"); //seems like a good place to show() the water.
	maps\_utility_gmi::autosave(6);
}


trigger_aiclear_wait()
{
	targ = getent(self.target,"targetname");
	self waittill ("trigger");
	ai = getaiarray();
	for(i=0;i<ai.size;i++)
	{
		if(!(ai[i] istouching(targ)) && !isdefined(ai[i].script_vehiclegroup) && ai[i].team != "allies")
		{
			ai[i] delete();
		}
	}
}


objectives()
{
	temporg = (0,0,0);
	startvar = getcvar("start");
	

	objective_add( 1, "active", &"GMI_SICILY2_GET_TO_THE_SHORE", (11644,-9555,-41) );
	objective_current(1);
	if(!(startvar == "tophill" || startvar == "bottomhill"))
		level waittill ("onfoot");
	objective_add( 2, "active", &"GMI_SICILY2_FOLLOW_INGRAM_TO_SAFETY", (16224,-13516,1188));
	objective_current(2);
	if(!(startvar == "tophill" || startvar == "bottomhill"))
		level waittill ("Ingram to safety");
	objective_state(2,"done");
	objective_current(1);

	objective_position( 1, (18185,-13995, 1137));
	level waittill ("fencebreak");
	objective_position( 1, (11644,-9555,-41));
/*
	obj
	objective_add( 3, "active", &"GMI_SICILY2_THROW_GRENADES_AT_THE", level.player.origin );
	objective_current(3);
	objective_state(3,"done");
	objective_current(1);
*/	

	level waittill("defend the friendly");  //friendly boats that is..
	objective_state(1,"done");
//	objective_add( 3, "active", &"GMI_SICILY2_DESTROY_ALL_ENEMY_BOATS", (0,0,0) );
//	objective_string(3, &"GMI_SICILY2_DESTROY_ALL_ENEMY_BOATS", (4));
//	objective_current(3);
//	level waittill ("boats destroyed");
//	objective_state(3,"done");
	objective_add( 3, "active", &"GMI_SICILY2_GET_ON_THE_ESCAPE_BOAT", (11644,-9555,-41) );
	objective_current(3);
	level waittill ("on the boat");
	objective_state(3,"done");

	
	thread objective_handle_4();

	level waittill ("last boats destroyed");
	objective_string(4,&"GMI_SICILY2_DESTROY_ALL_ENEMY_BOATS",0);	
	objective_state(4,"done");

}

objective_handle_4()
{
	level endon ("last boats destroyed");

	level waittill ("enemy boat count update");

	objective_add(4, "active", &"GMI_SICILY2_DESTROY_ALL_ENEMY_BOATS");

	objective_string(4,&"GMI_SICILY2_DESTROY_ALL_ENEMY_BOATS",level.enemyboatsremaining);	

	objective_current(4);

	while(1)
	{
		level waittill ("enemy boat count update");
		objective_string(4,&"GMI_SICILY2_DESTROY_ALL_ENEMY_BOATS",level.enemyboatsremaining);	
	}
}


shootatfriendlyboat(delay)
{

	level waittill ("shootatfriendlyboat",other);
	if(!isdefined(other.script_delay))
		delay = 5;
	else
		delay = other.script_delay;
	other endon ("death");
	thread shootatfriendlyboat(delay);  // spawn another copy of this thread so that other boats can shoot too.
	other.turret_target = level.escapeboat;
	wait .3;
	other notify ("refreshenemy");
	wait delay;  //don't start doing damage untill delay is up.	
	while(1)
	{
		level waittill ("boatshoot");
		level notify ("sparks");  //sparks jump off of the boat!
		level notify ("damage vehicle");
	}
}

boat_hud()
{
	explode = loadfx("fx/explosions/vehicles/ptboat_complete.efx");
	health = 2500;
	healthbuffer = 2000;
	
	maxhealth = health;
	basehealth = health;
	health += healthbuffer;
	height = 128;
	baseheight = height;
	minheight = 0;
	
	if(getcvar("start") == "boat") // order gets screwed up for some reason
	{
	
		tankhud2 = newHudElem();
		tankhud2 setShader("gfx/hud/tankhudback", 32, height);
		tankhud2.alignX = "right";
		tankhud2.alignY = "bottom";
		tankhud2.x = 635;
		tankhud2.y = 450;
				
		tankhud = newHudElem();
		tankhud setShader("gfx/hud/tankhudhealthbar", 32, height);
		tankhud.alignX = "right";
		tankhud.alignY = "bottom";
		tankhud.x = 635;
		tankhud.y = 450;
	}
	else
	{
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
		
	}	

//	setcvar("eq_time", .22);
//	setcvar("eq_scale",.25);

	ammount = 11;  //damage amount
	level.boatsmoking = false;
	
	thread cvarhealth();
	health -= basehealth-(basehealth*.92);
	while(health > healthbuffer)
	{
	//	x = (float) height;
	//	y = (float) baseheight;
	//	level.autosavehealth = x/y;
		
		level waittill ("damage vehicle");
	
		earthquake(0.23, .12, level.player.origin, 2250);
//		earthquake(getcvar("eq_scale"), getcvar("eq_time"), level.player.origin, 2250);
		if(getcvar("boathealth") != "non")
		{
			health = maxhealth+healthbuffer;
			setcvar("boathealth","non");
		}
		else
			health-=ammount;
		if(!(health < healthbuffer))
		{
			//iprintlnbold ("health percentis ,", ((float)health-(float)healthbuffer)/(float)basehealth);
			if(!(level.boatsmoking) && (((float)health-(float)healthbuffer)/(float)basehealth < .4))
			{
				
				//iprintlnbold("playing fx");
				thread turretsmoking();
				
			}
			height = ((float)(health - healthbuffer)*(float)baseheight)/(float)basehealth;
		}
		else
			height = 0;
		if(height > minheight)
		{
			level notify ("update hud");
			level thread huddamager(tankhud,height);
			tankhud setShader("gfx/hud/tankhudhealthbar2", 32, height);
		}
		else
		{
			tankhud setShader("gfx/hud/tankhudhealthbar", 32, minheight);
			break;
		}
	}
	level thread friendboatdeath(explode);
}

cvarhealth()
{
	setcvar("boathealth","non");
	while(1)
	{
		if(getcvar("boathealth") != "non")
			level notify ("damage vehicle");
		wait .05;
				
	}
}

turretsmoking()
{
	playfxontag(level._effect["boatdamage"],level.escapeboat,"tag_origin");
	
	level.boatsmoking = true;
	while(1)
	{
		playfxontag(level._effect["boatsmoke"],level.escapeboat,"tag_turret");
		wait .1;
	}	
}

huddamager(tankhud,height)
{
	level endon ("update hud");
	wait 3;
	tankhud setShader("gfx/hud/tankhudhealthbar", 32, height);
}


friendboatdeath(explode)
{
	if(isdefined(level.escapeboatkilled))
		return;
	else
		level.escapeboatkilled = true;
	level notify ("boatkilled");
//	level.escapeboat notify ("death");
	level.player DoDamage ( level.player.health + 50, (0,0,0) );
	
	level.escapeboat setspeed(0,25);
	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_SICILY2");
	missionfailed();
///	radiusDamage ( level.escapeboat.origin, 2, 10000, 9000);
	
	level.escapeboat playsound ("Explo_boat");
	playfx (explode , level.escapeboat.origin);
	wait .1;
	level.escapeboat playsound ("Explo_boat");
	playfx (explode , level.escapeboat.origin+(-56,128,128));
	wait .2;
	playfx (explode , level.escapeboat.origin+(54,-128,128));
	wait 1;
		
}

endlevelondeath()
{
	self waittill ("death");
	radiusDamage (level.player.origin, 64, 10000, 10000);
//	missionfailed();
}

drawthing(id,lineto,offset,color,time)
{

	self.drawingthing = 1;
	if(!isdefined(offset))
		offset = (0,0,0);
	if(!isdefined(color))
		color = (1, 1, 1);
	timer = gettime()+(time*1000);
	while(gettime()<timer)
	{
		print3d (self.origin + (offset), id, color, 1);
		if(isdefined(lineto))
			line ((self.origin + offset + (0,0,-8)),lineto.origin, color, 1);
			wait .05;
	}
}

blowupcliffguns()
{
//	level notify ("boatguyanim","react");

        maps\_fx_gmi::LoopFx("biggunexplode",      (-7209, -4766, 2233), 20, (-6828, -5146, 2233));
        earthquake(0.35, 2, level.player.origin, 2250);
	wait 1;
        maps\_fx_gmi::LoopFx("biggunexplode",      (-6621, -4198, 2188), 20, (-6270, -4558, 2188));
        wait .8;
        maps\_fx_gmi::LoopFx("biggunexplode",      (-7790, -5331, 2108), 20, (-7391, -5720, 2108));

//	maps\_utility::exploder(7);
	wait .2;
	earthquake(0.45, 2, level.player.origin, 2250);
	wait 3;

	earthquake(0.35, 2, level.player.origin, 2250);
	wait 3;
	level.player talkerque("ingram_off_coast");	
	wait 6;
	missionsuccess("gmi_ru_intro",false);
} 


trigger_setup_vehiclenotify()
{
	triggers = getentarray("vehiclenotify","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread trigger_vehiclenotify_wait();  //trigger_explodercrash_wait
	}
}


trigger_vehiclenotify_wait()
{
	note = self.script_noteworthy;
	if(!isdefined(note))
		return;
	while(1)
	{
		self waittill ("trigger",other);
		if(isalive(other) && isdefined(other.targetname) && other.targetname == self.target)
		{
			break;
		}
	}
	other notify ("groupedanimevent",note);
}


animontag(guy, tag , animation)
{
	org = self gettagOrigin (tag);
	angles = self gettagAngles (tag);
	guy animscripted("animontagdone", org, angles, animation);
	guy waittillmatch ("animontagdone","end");
}

buddygetontheboat(ent_boat)
{
//	ent_boat thread maps\_ptboat_gmi::drawtags();
	trigger = getent("ingramgetin","targetname");
	trigger waittill ("trigger");
//	boatnode = getnode("friendboatnode","targetname");
//	self setgoalnode(boatnode);
	org = ent_boat gettagorigin("tag_boat");
	angles = ent_boat gettagangles("tag_boat");
	boatpos = getstartorigin(org, angles, %c_br_sicily2_ingram_jump);
	self setgoalpos(boatpos); 

	self.goalradius = 1;
	self waittill ("goal");

//	self linkto(ent_boat,"tag_boat",(0,0,0),(0,0,0));
	self linkto(ent_boat);
	ent_boat animontagtest (self, "tag_boat", %c_br_sicily2_ingram_jump);

	level.buddyisonboat = 1;
	level notify ("friend is on the boat");
	level.player talkerque("ingram_day_cruise");
	self delete();
}

animontagtest(guy, tag , animation)
{
	org = self gettagOrigin (tag);
	angles = self gettagAngles (tag);
	guy animscripted("animontagdone", org, angles, animation);
	guy waittillmatch ("animontagdone","end");
}
//////////////////////////////
//////////////////////////////

//                __                /\ \__                       
//   __      ___ /\_\    ___ ___    \ \ ,_\  _ __    __     __   
// /'__`\  /' _ `\/\ \ /' __` __`\   \ \ \/ /\`'__\/'__`\ /'__`\ 
///\ \L\.\_/\ \/\ \ \ \/\ \/\ \/\ \   \ \ \_\ \ \//\  __//\  __/ 
//\ \__/.\_\ \_\ \_\ \_\ \_\ \_\ \_\   \ \__\\ \_\\ \____\ \____\
// \/__/\/_/\/_/\/_/\/_/\/_/\/_/\/_/    \/__/ \/_/ \/____/\/____/
// heheh

#using_animtree ("fishingboat");
//////////////////////////////
//////////////////////////////

usetrigger(ent_trigger)
{
	maps\_utility_gmi::array_levelthread(getentarray("boatusetrig","targetname"), ::usetrigger_triggers);
	level waittill ("boattriggered");
}

usetrigger_triggers(ent_trigger)
{
	level endon ("boattriggered");
	ent_trigger setHintString (&"GMI_SCRIPT_HINTSTR_GETINTHEBOAT");

	ent_trigger waittill ("trigger");
	level notify ("boattriggered");	
}


getontehboat(ent_boat)
{
//	level.escapeboat hide();
	level.buddy thread buddygetontheboat(ent_boat);
	getontehboat = getent("getontehboat","targetname");
	if(getcvar("start") != "boat")
	{
		getontehboat waittill ("trigger");
	
		usetrigger(getontehboat);
	
		level notify ("on the boat");
		
		level.blackoutelem = newHudElem();
		level.blackoutelem setShader("black", 640, 480);
		
		level.blackoutelem.alpha = 0;
		level.blackoutelem fadeOverTime(1); 
		level.blackoutelem.alpha = 1;
		level.player freezeControls(true);
		
		wait 1.5;
	}
	
	/////////////////////////
	//delete things
	
	
	//28 script_origins
	//188 script_models reduced to 33
	//228 trigger_multiples reduced to 128
	
	

	//don't need pots anymore.
	maps\_utility_gmi::array_levelthread(getentarray("pot","targetname"), ::deleteme);
	maps\_utility_gmi::array_levelthread(getentarray("pots","targetname"), ::deleteme); //oops.. heh  I fix my map errors with script!! =/
	
	//don't need mg42's
	maps\_utility_gmi::array_levelthread(getentarray("misc_mg42","classname"), ::deleteme);
	
	//don't need boat use triggers anymore
	maps\_utility_gmi::array_levelthread(getentarray("boatusetrig","targetname"), ::deleteme);

	//don't need healthkits anymore
	maps\_utility_gmi::array_levelthread(getentarray("item_health","classname"), ::deleteme);

	//don't need trigger_friendlychain anymore
	maps\_utility_gmi::array_levelthread(getentarray("trigger_friendlychain","classname"), ::deleteme);
	

//	dtriggers = getentarray("trigger_multiple","classname");
//	maps\_utility_gmi::array_levelthread(dtriggers, ::deletexplus);
//	dtriggers = getentarray("trigger_multiple","classname");
	
	dscriptorg = getentarray("script_model","classname");
	maps\_utility_gmi::array_levelthread(dscriptorg, ::deletexplus);
	dscriptorg = getentarray("script_model","classname");

	dscriptbmodel = getentarray("script_brushmodel","classname");
	maps\_utility_gmi::array_levelthread(dscriptbmodel, ::deletexplus);
	dscriptbmodel = getentarray("script_brushmodel","classname");


	
//	nodes = getnodearray("node_pathnode","classname");
//	thread deletearrayslowly(nodes);

	
	
	
	/////////////////////////
	/////////////////////////
	if(isdefined(level.buddy) && isalive(level.buddy))
		level.buddy delete();
	level thread boat_hud();
	level.player freezeControls(false);
	level.escapeboat show();
	level.escapeboat notify ("groupedanimevent","animbeginning");
	level notify ("start boatride music");
//	level.blackoutelem delete();
//	ent_boat.mgturret delete();
	ent_boat delete();
	level.escapeboat notify ("start_playervehiclepath");
	level.escapeboat useby(level.player);
	level.player allowuse(false);	
	spawners = getspawnerarray();  // hack.. should be deleting them with triggers.
	for(i=0;i<spawners.size;i++)
	{
		spawners[i] delete();
	}
	ai = getaiarray();
	for(i=0;i<ai.size;i++)
	{
		ai[i] delete();  // no more ai woo!
	}
	
//		startpoint = getent("player_startpoint","targetname");
//		level.player setorigin((startpoint.origin),(0,0,0)); 
	if(getcvar("start") != "boat")
		level.blackoutelem.alpha = 0;
	maps\_utility_gmi::autosave(7);
	level.escapeboat waittill ("reached_end_node");
}

deletearrayslowly(nodes)
{
	cound = 0;
	for(i=0;i<nodes.size;i++)
	{
		nodes[i] delete();
		count++;
		if(count>10)
		{
			count = 0;
			wait .05;
		}
	}
}

deletexplus(object)
{
	org = object getorigin();
	if(org[0] > 17544)
	{
		object delete();
	}	
}



boatsequence()
{
	temp =getent("dockend","targetname");
	if(!isdefined(temp))
		return;  // layer is disabled..

	org = temp.origin;
	trigger = getent("docpanzeraction","targetname");
	trigger waittill ("trigger");
//	maps\_utility_gmi::autosave(5);
	level notify ("defend the friendly");
}

boatsetup()
{
	
	deleteme = getent("getawayboat","target");
	if(isdefined(deleteme))
		deleteme delete();
	else
		return;  //compiling without the layer.. 
	level.escapeboat = getent("viewboat","targetname");
	if(!isdefined(level.escapeboat))
		return;
	boatfxdummys = getentarray("boatfxdummies","targetname");
	for(i=0;i<boatfxdummys.size;i++)
	{
		boatfxdummys[i] linkto (level.escapeboat,"tag_body");
		boatfxdummys[i] hide();
	}	
	level.escapeboat hide();
		ent_boat = maps\_vehiclechase_gmi::spawnvehiclegroup("getawayboat");  //whaoheh let the l33thackage begin
	
	
//	if(getcvar("start") != "boat")
//		level waittill ("friendboatspawned", ent_boat);
//	else
//	{
//		ent_boat = maps\_vehiclechase_gmi::spawnvehiclegroup("getawayboat");  //whaoheh let the l33thackage begin
//	}

	ent_boat thread animatdock();
	level thread boatfxdummys(boatfxdummys);
//	vehicle = spawnVehicle( vspawner.model, vspawner.targetname, vspawner.vehicletype ,vspawner.origin, vspawner.angles );

//	level.escapeboat = spawnVehicle( "xmodel/v_ge_sea_view_ptboat", "getawayboatr", ent_boat.vehicletype ,ent_boat.origin, ent_boat.angles );
	//level.escapeboat = ent_boat;
	level.escapeboat maps\_ptboat_player_gmi::init();
	level.escapeboat setup_player_vehicle(ent_boat.attachedpath);
	level.escapeboat thread endlevelondeath();
	level.escapeboat thread nodamageuntillisayso();
	thread getontehboat(ent_boat);
	level waittill ("engineblow",other);
//	level.escapeboat notify("groupedanimevent","animslowing_down");
//	level.escapeboat setspeed(10,20);
	wait 3;
	level.escapeboat resumespeed(20);
	level.escapeboat notify("groupedanimevent","fast");
	wait 3;
	while(level.cliffboats > 0)
		level waittill ("cliffboatdeath");
	level notify ("last boats destroyed"); // stops music // updates objective too.
	wait 2;
		level.player talkerque("ingram_enjoy");
	wait 2;
	level thread blowupcliffguns();
	

	
//	iprintlnbold("engine blown with effects.. now fend off incoming attackers and watch the cliff blow up!!");	
}

boatfxdummys(boatfxdummys)
{
	
	while(1)
	{
		level waittill ("sparks");
		pick = boatfxdummys[randomint(boatfxdummys.size)];
		playfx(level.boatspark,pick.origin,anglestoforward(pick.angles));
	}
}

waitforgo()
{
	self waittill ("start_playervehiclepath");
	self startpath();
}

setup_player_vehicle(node)
{
	self attachpath(node);
	self.attachedpath = node;
	
	thread maps\_vehiclechase_gmi::player_vehicle_paths();
	thread maps\_vehiclechase_gmi::waitforgo();

}

nodamageuntillisayso()
{
	level endon ("boatkilled");
	while(1)
	{
		self waittill ("damage",amount);
		self.health += amount;
	}
}

enemyboathandle()
{
	self thread maps\_vehiclechase_gmi::enemy_chaser();
	self waittill ("death");
	level notify ("enemyboatdeath");
	self setspeed (0,100);
	level notify ("boatkilled");  // do sinking animation maybe?
}


drawboat()
{
	while(1)
	{
		print3d (self.origin + (0,0,25), "me", (1,1,1), 1);
		wait .05;
	}
}


#using_animtree ("sicily2_dummies");


triggers_changefollow()
{
	
	triggers = getentarray("followmodify","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread trigger_changefollow();
	}
}

trigger_changefollow()
{
	self waittill ("trigger");
//	iprintln("changing buddy's follow parms : ",self.script_noteworthy);
	if(self.script_noteworthy == "1") // just before tank comes on outside onfoot area.
	{
		level.buddy.followmin = 2;
		level.buddy.followmax = 3;
	}
	if(self.script_noteworthy == "2")
	{
		level.buddy.followmin = -2;// before the assault on the bunker
		level.buddy.followmax = 1;
	}
	if(self.script_noteworthy == "3")
	{
		level.buddy.followmin = -1;// before the assault on the bunker added so it would happen on /start bottomhill
		level.buddy.followmax = 1;
	}
	if(self.script_noteworthy == "4")
	{
		level.buddy.followmin = 0;// inside the bunker
		level.buddy.followmax = 1;
	}
	if(self.script_noteworthy == "5")
	{
		level.buddy.followmin = 1;// inbetween 1 and 2
		level.buddy.followmax = 1;
	}
//	iprintlnbold("buddy follow min = ", level.buddy.followmin);
//	iprintlnbold("buddy follow max = ", level.buddy.followmax);
}

setup_grenadethrowtrigs()
{
	grenadethrows = getentarray("grenadethrow","targetname");
	for(i=0;i<grenadethrows.size;i++)
	{
		
		target = getent(grenadethrows[i].target,"targetname");
		trigger = getent(target.target,"targetname");
		thread grenadethrowattrigger(target.origin,trigger,grenadethrows[i].origin);
		target delete();
		grenadethrows[i] delete();
	}
	
}

grenadethrowattrigger(vec_target, ent_trigger, vec_origin)
{
	ents = getentarray(ent_trigger.targetname,"target");
	ontrigger = false;
	aivolumes = [];
	for(i=0;i<ents.size;i++)
	{
		if(ents[i].classname == "trigger_multiple")
		{
			if(isdefined(ents[i].targetname))
			{
				if(ents[i].targetname == "grenadeaivolume")
				{
					aivolumes[aivolumes.size] = ents[i];
					
				}
				continue;
			}
			ent_ontrigger = ents[i]; 
			ontrigger = true;
		}
		
	}
	if(ontrigger)
	{
		ent_ontrigger waittill ("trigger");
		
	}
	if(isdefined(ent_trigger.script_delay))
	{
		delay = ent_trigger.script_delay;	
	}
	else
		delay = (float)4;
		
	aitouchingvolume = false;
	grenadecount = 0;
	grenadethrown = 3;
	while(grenadecount<grenadethrown)
	{
		
		ent_trigger waittill ("trigger");
		while(level.player istouching (ent_trigger) && grenadecount<grenadethrown)
		{
			ai = getaiarray();
			for(i=0;i<aivolumes.size;i++)
			{
				for(j=0;j<ai.size;j++)
					if(ai[j] istouching (aivolumes[i]))
						aitouchingvolume = true;
			}
			if(!(aitouchingvolume))
			{
				wait .5;
				continue;
			}
			level.buddy.grenadeawareness = 0;
			level.buddy MagicGrenade( vec_origin, vec_target , 4 );
			grenadecount++;
			wait delay+randomfloat(delay/3);
		}
		level.buddy.grenadeawareness = 1;
	}
}

pots(pot)
{

	pot settakedamage(true);
	pot waittill("damage",dmg,who,dir,point,mod);
	playfx(level._effect["potsmash"],pot.origin);
	pot delete();
	
}
deleteme(me)
{
	me delete();
}





clipremove(ent_trigger)
{
	ent_clip = getent(ent_trigger.target,"targetname");
	
	ent_trigger waittill ("trigger");
	ent_clip notsolid();
	ent_clip connectpaths();
}

trigger_conditionaldeathmessage(ent_trigger)
{
//	maps\_utility_gmi::array_levelthread(getentarray(ent_trigger.target,"targetname"), ::conditionaldeathmessage,ent_trigger);
	ent_targs = getentarray(ent_trigger.target,"targetname");
	ent_trigger waittill ("trigger");
	for(i=0;i<ent_targs.size;i++)
	{
		ent_targs[i] thread conditionaldeathmessage(ent_targs[i],ent_trigger);
	}
	for(i=0;i<ent_targs.size;i++)
	{
		ent_trigger waittill ("boatdead");
		
	}
	level.player talkerque(ent_trigger.script_noteworthy);
	
}

conditionaldeathmessage(ent_scriptorg,ent_trigger)
{
	ent_boat = getent(ent_scriptorg.target,"targetname");
	ent_boat waittill ("death");
	ent_trigger notify ("boatdead");
	
}

#using_animtree ("ptboat");

animatdock()
{
	self.boataniming = 1;
//	animtest = [];
//	animtest[animtest.size] = %v_ge_sea_view_ptboat_fast;
//	animtest[animtest.size] = %v_ge_sea_ptboat_fast2right;
//	animtest[animtest.size] = %v_ge_sea_view_ptboat_right;
//	animtest[animtest.size] = %v_ge_sea_ptboat_right2fast;
//	animtest[animtest.size] = %v_ge_sea_view_ptboat_fast;
//	self setmodel("xmodel/v_ge_sea_view_ptboat");
	while(1)
	{
//		for(i=0;i<animtest.size;i++)
//		{
	//		maps\_ptboat_gmi::boatanim(%v_ge_sea_player_ptboat_idle);
			self useanimtree (#animtree);
			self setflaggedanimknobrestart("boatanim",(%v_ge_sea_player_ptboat_idle));
//			self setflaggedanimknobrestart("boatanim",(animtest[i]));
			self waittillmatch ("boatanim","end");
			
//		}
	}
}

trigger_soundtrigger(ent_trigger)
{
	ent_trigger waittill("trigger");
	level.player playsound(ent_trigger.script_noteworthy);
}

cliffboats()  // piggy backing some objectives stuff
{
	level.enemyboatsremaining = 8;
	level.cliffboats = 4;
	level.cliffboats_dead = false;
	while(1)
	{
		//These aren't vehicles the player kills
		level waittill ("vehiclespawned",ent_vehicle);
		if(ent_vehicle.targetname == "natestah892"
		|| ent_vehicle.targetname == "natestah795"
		|| ent_vehicle.targetname == "natestah720"
		|| ent_vehicle.targetname == "natestah1140")
		{
			 level thread cliffboatque(ent_vehicle);
		}
		
		if(ent_vehicle.model == "xmodel/v_ge_sea_pt-boat")
		{
			//pony - changed this so that the variable starts at the max num of boats possible to kill...
			//level.enemyboatsremaining++;
			level notify ("enemy boat count update");
			ent_vehicle thread enemyboatsremaining();
		}
	}
}

enemyboatsremaining()
{
	self waittill ("death");
	level.enemyboatsremaining--;
	level notify ("enemy boat count update");
}

cliffboatque(ent_vehicle)
{
	ent_vehicle waittill ("death");
	level notify ("cliffboatdeath");
	level.cliffboats += -1;
}

tellmeifplayerhealthisovermax()
{
	while(1)
	{
		wait 0.5;
		if(level.player.health > level.player.maxhealth)
		{
			println("^1##################################################");
			println("^1##################################################");
			println("^1##################################################");
	
			println("^5PLAYER MAX HEALTH EXCEEDED!!!!");

			println("^1##################################################");
			println("^1##################################################");
			println("^1##################################################");
		}
	}
}

