/****************************************************************************

Level: 		PEGASUS BRIDGE NIGHT
Campaign: 	British
Objectives: 	1. Clear out and secure the bridge area.
			- primary objective 
			- concludes when all remaining enemies have been eliminated
		2. Suppress the bunker and clear it out.
			- friendlies will try to take the bunker 
			- player can rush
			- completes when all bunkerguys are dead
		3. Regroup with Captain Price.
			- happens after tank enters and all friendlies run for cover
		4. Get Private Mills to the flak gun.
			- Captain Price orders the player to seek out Private Mills after the tank is encountered
			- When the player gets to Private Mills, he has to hit the use key to make him respond
			- Private Mills runs over to the Flak88 and does the reparing scripted animation
		7. Use the Flak88 gun to destroy the tank.
			- Now the gun is fully traversable through 360 degrees.
			- When hit, the tank erupts in a fancy explosion with multiple secondaries, ammo cookoffs, dlights

*****************************************************************************/

#using_animtree("generic_human");

main()
{
	setCvar("cg_draw2d", "1");
	setCvar("cg_drawgun", "1");
	
	//Fog parameters
	
	setExpFog(0.0008, 0, 0, 0, 0);
	setCullDist(7200);
	
	//setCullFog(0, 9000, 0, 0, 0.02, 0);
	//setExpFog(0.00005, 0, 0, 0, 0);
	
	precacheShellshock("groggy");	//type of shellshock in /scripts
	precacheshader("black");
	
	//Precache main character
	
	level.nPrice = getent("price", "targetname");
	level.nPrice.animname = "nPrice";
	level.nPrice character\price::precache();
	level.nPrice character\_utility::new();
	level.nPrice character\price::main();
	
	level.nMills = getent("mills", "targetname");
	level.nMills character\mills::precache();
	level.nMills character\_utility::new();
	level.nMills character\mills::main();
	
	level.gerguard1 = getent("gerguard1", "targetname");
	level.gerguard1.allowdeath = 1;
	level.gerguard1.animname = "gerguard1";
	level thread guardtalk_stop(level.gerguard1);
	
	level.gerguard2 = getent("gerguard2", "targetname");
	level.gerguard2.allowdeath = 1;
	level.gerguard2.animname = "gerguard2";
	level thread guardtalk_stop(level.gerguard2);
	
	maps\_load::main();
	maps\pegasusnight_anim::main();
	maps\pegasusnight_fx::main();
	maps\_panzerIV::main();
	maps\_panzeriv::main_camo();
	maps\_treadfx::main();
	
	maps\_utility::precache("xmodel/vehicle_tank_panzeriv_machinegun");

	level.player takeweapon ("bren");
	level.player takeweapon ("enfield");
	level.player takeweapon ("colt");
	level.player takeweapon ("MK1britishfrag");

	nTankPyre = getent("tankpyre", "targetname");
	nTankPyre hide();
	
	//*** Flak 88 Init
	
		eFlak88 = getent( "flak_88", "targetname" );
		eFlak88 thread flak88_init();
		eFlak88 makeVehicleUnusable();
	
	//*** Level Variables
	
		level.mortar = loadfx ("fx/surfacehits/mortarImpact.efx");	//an effect for the tank secondary explosions
	
		level.fadeintime = 4.0;		//time during player wakeup phase
		
		level.suppressionphase = 2.5;	//how long the bunker guys stay down when the player suppresses them
		level.suppression_response = 1;	//whether bunker guys will be suppressed or not
		
		level.ignoretime = 4;		//how long the friendly shield makes enemies ignore a friendly
		
		level.playerrushed = 0;		//if player gets there before the friendlies
		level.bunkercaptured = 0;	//level wide check for bunker capture status
		level.nCaptureRange = 356;	//how close Price needs to be to the bunker at capture time
		level.nLengthSquaredPrice = 100000; //intial number
		
		level.bunkergunners = 0;	//number of remaining bunker gunners
		
		level.iProxbias_add = 50000;	//how much the player's threatbias increases temporarily when close to the bunker
		level.iDeathbias_add = 10;	//how much the player's threatbias increases for each friendly lost
		
		level.tankalive = 1;		//marker for tank death to terminate tanktroop_assault
		
		level.bridgeregroup = 0;	//marker for guys to dash across bridge
		
		level.tankreact = 0;		//marker for tank related activity
		
		//Squadnames
		
		level.strAlpha = "alpha";
		level.strBravo = "bravo";
		level.strCharlie = "charlie";
		level.strDelta = "delta";
		//level.strEcho = "echo";
		//level.strFoxtrot = "foxtrot";
		//level.strGolf = "golf";
		//level.strHotel = "hotel";
		//level.strIndia = "india";
		//level.strJuliet = "juliet";
		level.strKilo = "kilo";
		level.strOmega = "omega";
		
		level.soundplayed = 0;		//test for a gunner to shout "open fire" only once
		
		//MG42s and position nodes
		
		level.nMG42a = getent("bunkermg42a", "targetname");
		level.nMG42b = getent("bunkermg42b", "targetname");
		level.nMG42c = getent("bunkermg42c", "targetname");
		
		level.nMG42Node1 = getnode("mg42node1", "targetname");
		level.nMG42Node2 = getnode("mg42node2", "targetname");
		level.nMG42Node3 = getnode("mg42node3", "targetname");

	//*** Ambient Sound Effects Track

		ambientPlay("pegasus_glider"); 
	
	//*** Glider Ride Sequence
	
	if (getcvar ("start") == "gliderdebug")
	{
		thread blackout();	//blackout at the end of the landing
		thread glider_ride();	//hide objects, glider ride sequence, redisplay objects
		thread bones();
	}
	else
	if (getcvar ("start") != "skipglider")
	{
		thread blackout();	//blackout at the end of the landing
		thread glider_ride();	//hide objects, glider ride sequence, redisplay objects
	}
	
	//*** NPC Setup
	
		thread intro_friendly_setup();
		thread intro_enemy_setup();
		thread intro_hero_setup();
		
	//*** Threads
	
	if (getcvar ("start") != "skipglider")
	{
		thread intro_music();
	}
	else
	{
		thread intro();
	}
		thread guardtalk();
		thread action_biastrigger_check();
		thread action_start();
		thread action_shot_detect();
		thread action_proximity_detect();
		thread action_player_rushcheck();
		thread bunker_suppression();
		thread bunker_suppression_check();
		thread west_goalchange();
		thread west_tank_start();
		
		thread objectives();
		
		thread death_failsafe();
		
		thread compass_erase();
}

compass_erase()
{
	aFriendlies = getaiarray("allies");
	
	for(i=0; i<aFriendlies.size; i++)
	{
		aFriendlies[i].DrawOnCompass = false;
	}
}

compass_draw()
{
	aFriendlies = getaiarray("allies");
	
	for(i=0; i<aFriendlies.size; i++)
	{
		aFriendlies[i].DrawOnCompass = true;
	}
}

death_failsafe()
{
	//Kills guys who mysteriously fall through the ground
	
	nDeathTrig = getent("death_guaranteed", "targetname");
	
	while(1)
	{
		nDeathTrig waittill ("trigger", guy);
		println("UNAUTHORIZED DEATH HAS OCCURRED AT ", guy.origin);
	}
}

guardtalk_stop(guard)
{
	guard waittill ("death");
	level notify ("action");
}

guardtalk_interrupt()
{
	self endon ("death");
	level waittill ("action");
	self notify ("single anim", "end");
	self stopanimscripted();	
}

guardtalk()
{
	level endon ("action");
	
	level.gerguard1 thread guardtalk_interrupt();
	level.gerguard2 thread guardtalk_interrupt();
	
	fStartTalkDist = length(level.gerguard1.origin - level.player.origin);
	while(fStartTalkDist > 1000)
	{
		fStartTalkDist = length(level.gerguard1.origin - level.player.origin);
		wait 0.1;
	}
	
	level.gerguard1 thread anim_single_solo(level.gerguard1, "guardstalking");
	level.gerguard2 anim_single_solo(level.gerguard2, "guardstalking");

	level.gerguard1.walk_noncombatanim = %patrolwalk_tired;
	bridgenode = getnode("bridgestartnode", "targetname");
	level.gerguard1 setgoalnode(bridgenode);
}

intro_friendly_setup()
{
	//*** Friendlies start unwilling to go into combat mode, log into threatbias deathwaiter 

	level.aFriendlies = getaiarray("allies");
	for(i=0; i<level.aFriendlies.size; i++)
	{
		if(isdefined(level.aFriendlies[i]) && isalive(level.aFriendlies[i]))
		{
			level.aFriendlies[i].pacifist = true;
			level.aFriendlies[i].dontavoidplayer = true;
			level.aFriendlies[i] allowedStances ("crouch");
			level.aFriendlies[i].walkdist = 0;
			level.aFriendlies[i].interval = 64;
			//level.aFriendlies[i].health = 850;
			level.aFriendlies[i].suppressionwait = 0.01;
			level.aFriendlies[i].health = 200;
			level.aFriendlies[i].accuracy = 0.5;
			
			level thread action_bias_deathwaiter(level.aFriendlies[i]);
			level thread friendly_shield(level.aFriendlies[i]);
			
			level.aFriendlies[i].run_combatanim = %sprint1_loop;
		}
	}
}

intro_enemy_setup()
{
	//*** Bunker gunner and guards are not alert

		aGuards = getaiarray("axis");
		
		for(i=0; i<aGuards.size; i++)
		{
			if(isdefined(aGuards[i]) && isalive(aGuards[i]))		
			{
				aGuards[i].maxsightdistsqrd = 100;
				aGuards[i].pacifist = true;
			}
		}

	//*** Make patrolling guy walk around
		
		level waittill ("blackout voices done");
		nPatrolGuard = getent("roamer","targetname");
		nPatrolGuard thread maps\_patrol::patrol();
		nPatrolGuard.walk_noncombatanim = %patrolwalk_tired;
}

intro_hero_setup()
{
	//*** Hero NPC setup

	level.nPrice thread maps\_utility::magic_bullet_shield();
	level.nPrice.accuracy = 1;
	
	level.nMills = getent("mills", "targetname");
	level.nMills.animname = "nMills";
	level.nMills thread maps\_utility::magic_bullet_shield();
	level.nMills.accuracy = 0.3;
}

intro_music()
{
	level waittill ("glider ride finished");
	
	ambientPlay("pegasusnight_ambient", level.fadeintime); 
	
	//thread fadein();
	
	//level.nPhono = getent("phonograph", "targetname");
	//nPhono playLoopSound("phonograph_bruckner");
	//level.nPhono playsound("pegasusnight_edith");
	
	thread intro_blackout_voices();
	
	level waittill ("blackout voices done");
	
	thread intro();
}

intro_phonograph()
{	
	level.nPhono = spawn ("script_origin",(0,0,0));
	level.nPhono endon ("death");
	
	org = getent("phonograph", "targetname");
	
	level.nPhono.origin = org.origin;
	
	level.nPhono playLoopSound("phonograph_bruckner");
	println("playing music");
}

intro_blackout_voices()
{
	//maps\_utility::playSoundinSpace (alias, origin)
	
	nDV_hardlanding = getent("disvoice_hardlanding", "targetname");
	nDV_everyone = getent("disvoice_everyoneallright", "targetname");
	nDV_yeahfine = getent("disvoice_yeahfine", "targetname");
	nDV_buttonup = getent("disvoice_buttonup", "targetname");
	nDV_movemove = getent("disvoice_movemove", "targetname");
	
	level.player allowCrouch(true);
	
	wait 0.1;
	
	level.player allowStand(false);
	level.player allowProne(false);
	
	wait 2;	
	
	thread maps\_utility::playSoundinSpace("pegnight_crash1", nDV_hardlanding.origin);
	
	wait 3;
	
	thread maps\_utility::playSoundinSpace("pegnight_crash2", nDV_everyone.origin);
	
	wait 3;
	
	thread maps\_utility::playSoundinSpace("pegnight_crash3", nDV_yeahfine.origin);
	
	wait 2;
	
	thread maps\_utility::playSoundinSpace("pegnight_crash4", nDV_buttonup.origin);
	
	wait 1;
	
	thread maps\_utility::playSoundinSpace("pegnight_crash5", nDV_movemove.origin);
	
	wait 5;
	
	level notify ("blackout voices done");
}

intro_fadein()
{
	thread compass_draw();
	
	thread glider_collmaps();
	
	level.player setplayerangles((0,240,0));
	
	setExpFog(0.0001, 0, 0, 0, 0);
	
	//hdSetAlpha(0, 0, 1.5);
	level.blackoutelem fadeOverTime(1.5); 
	level.blackoutelem.alpha = 0;
	
	level.player freezeControls(false);
	
	level.player giveweapon ("bren");
	level.player giveweapon ("enfield");
	level.player giveweapon ("colt");
	level.player giveweapon ("MK1britishfrag");
	
	wait 1.5;
	level.blackoutelem destroy();
	
	level.player allowStand(true);
	level.player allowLeanLeft(true);
	level.player allowLeanRight(true);
	level.player allowProne(true);
	level.player allowCrouch(true);
}

glider_collmaps()
{
	aGliderCollmaps = getentarray("glider_collmap", "targetname");
	aGliders = getentarray("dummyglider", "targetname");
	
	println("aGliderCollmaps.size = ", aGliderCollmaps.size);
	println("aGliders.size = ", aGliders.size);
	
	for(i=0; i<aGliders.size; i++)
	{
		println("collmap moving");
		aGliderCollmaps[i].origin = aGliders[i].origin;
		aGliderCollmaps[i].angles = aGliders[i].angles;
		
		println("Glider is at ", aGliders[i].origin, " and Collmap is at ", aGliderCollmaps[i].origin);
		println("Glider is angled ", aGliders[i].angles, " and Collmap is at angles ", aGliderCollmaps[i].angles);
	}
}

intro()
{	
	//level waittill ("starting final intro screen fadeout");
	
	level endon ("action");
	//level notify ("wakeupcall");
	
	thread intro_fadein();
	thread intro_phonograph();
	
	//DIALOG - Capt. Price - Sergeant Evans, glad you're still with us -- we're in luck. The Germans haven't responded to our stellar landing.
	
	nPriceIntroNode = getnode("price_intro_speechnode", "targetname");
	
	level.nPrice animscripts\shared::LookAtEntity(level.player, 15, "alert");
	level.nPrice anim_single_solo(level.nPrice, "stellar", undefined, nPriceIntroNode);
	
	//DIALOG - Captain Price - Find a good spot to suppress their bunker. We'll advance behind your base of fire.
	
	level.nPrice anim_single_solo(level.nPrice, "goodspot", undefined, nPriceIntroNode);
	
	level notify ("objective2");
	
	level.nPrice allowedStances ("crouch","stand");
	
	//Price takes off to his ready point
	
	nPriceReady = getnode("priceready", "targetname");
	level.nPrice setgoalnode(nPriceReady);
}

action_biastrigger_check()
{
	//If player approaches bunker too aggressively, increase player's threatbias
	//Remove proxbias_add amount on bunker capture
	//Two of the MG42s exclusively attack the player.

	nBiastrigger = getent("biastrigger","targetname");
	t = 0;
	
	while(1)
	{
		if(level.player istouching(nBiastrigger) && t==0)
		{
			level.player.threatbias = level.player.threatbias + level.iProxbias_add;
			println("PLAYER THREATBIAS = ", level.player.threatbias);
			level.suppression_response = 0;	//suppression doesn't work
			t = 1;
			
			nMG42a_user = level.nMG42a getTurretOwner();
			nMG42c_user = level.nMG42c getTurretOwner();
			
			if(isdefined(nMG42a_user) && isalive(nMG42a_user))
			{
				level.nMG42a setmode("manual_ai");
				level.nMG42a notify ("startfiring");
				level.nMG42a settargetentity(level.player);
			}
			
			if(isdefined(nMG42c_user) && isalive(nMG42c_user))
			{
				level.nMG42c setmode("manual_ai");
				level.nMG42c notify ("startfiring");
				level.nMG42c settargetentity(level.player);
			}
		}
		else
		if(!(level.player istouching(nBiastrigger)) && t==1)
		{
			level.player.threatbias = level.player.threatbias - level.iProxbias_add;
			println("PLAYER THREATBIAS = ", level.player.threatbias);
			level.suppression_response = 1;	//suppression works
			t = 0;
			
			level.nMG42a setmode("auto_ai");
		}

		if(level.bunkercaptured == 1 && t==1)
		{
			level.nMG42a setmode("auto_ai");
			level.player.threatbias = level.player.threatbias - level.iProxbias_add;
			println("PLAYER THREATBIAS = ", level.player.threatbias);
			break;
		}
		
		wait 0.1;
	}
}

action_bias_deathwaiter(nSoldier)
{
	//Player gains some points of threatbias for each friendly lost; this never goes away
	
	nSoldier waittill("death");
	level.player.threatbias = level.player.threatbias + level.iDeathbias_add; 
	println("PLAYER THREATBIAS = ", level.player.threatbias);	
}

action_shot_detect()
{
	//*** Detects if a shot has been fired and alerts the enemy
	
		level endon ("proximity_started");
	
		tCoverBlown = getent("ndtrigger","targetname");
		tCoverBlown waittill ("trigger");
	
		//println("ACTION DETECTED, GUARDS ALERTED");
	
		level notify ("shot_started");
		level notify ("action");
}

action_proximity_detect()
{
	//*** Detects if the player has gotten too close to the guarded area and alerts the enemy
	
		level endon ("shot_started");
	
		tProxtrigger = getent("proxtrigger","targetname");
		tProxtrigger waittill("trigger");
		
		//println("PROXIMITY DETECTED, GUARDS ALERTED");
		
		level notify ("proximity_started");
		level notify ("action");
}

action_start()
{
	level waittill("action");
	level notify ("objective2");
	
	//*** Get closest guard and play the right detection sound
	
		action_guards_alert();		//waitthread
		
	//*** Set friendlies' properties again
	
		action_friendly_setup();	//waitthread
		
	//DIALOG - Captain Price - SUPPRESSING FIRE!
		
		level.nPrice anim_single_solo(level.nPrice, "suppressshout");
	
	//DIALOG - Captain Price - Sergeant Evans! Suppress that bunker! Keep their heads down!
	
		level.nPrice thread anim_single_solo(level.nPrice, "keepheadsdn");
		
	//*** Deploy the friendlies' to attack bunker and check for capture condition
	
		thread bunker_assault_schedule();
		thread bunker_capture();
}

phonograph_stop()
{
	level.nPhono stopLoopSound();
	level.nPhono playsound("pegasusnight_phonoswipe");
}

action_friendly_setup()
{
	for(i=0; i<level.aFriendlies.size; i++)
	{
		if(isdefined(level.aFriendlies[i]) && isalive(level.aFriendlies[i]))
		{
			level.aFriendlies[i].dontavoidplayer = false;
			level.aFriendlies[i].pacifist = false;
			level.aFriendlies[i] allowedStances ("crouch");
		}
	}
}

action_guards_alert()
{
	aGuards = getaiarray("axis");
	
	t = 0;
	
	for(i=0; i<aGuards.size; i++)
	{
		nLength = length(aGuards[i].origin - level.player.origin);
		
		if(t==0)
		{
			nOldLength = nLength;
			nClosestGuard = aGuards[i];
			t = 1;
		}
		
		if(nLength < nOldLength)
		{
			nOldLength = nLength;
			nClosestGuard = aGuards[i];
		}
	}
	
	for(i=0; i<aGuards.size; i++)
	{
		level thread action_wakeup(aGuards[i]);
		//println("I'm AWAKE");
	}
	
	//DIALOG German sentry 1
	
	nClosestGuard.animname = "alertedguard";
	nClosestGuard thread anim_single_solo(nClosestGuard, "germanalerted");
	wait 1;
	
	t = 0;
	
	for(i=0; i<aGuards.size; i++)
	{
		if(isdefined(aGuards[i]) && isalive(aGuards[i]))
		{		
			nLength = length(aGuards[i].origin - level.player.origin);
		}
		else
		{
			continue;
		}
		
		if(t==0)
		{
			nOldLength = nLength;
			nClosestGuard = aGuards[i];
			t = 1;
		}
		
		if(nLength < nOldLength)
		{
			nOldLength = nLength;
			nClosestGuard = aGuards[i];
		}
	}
	
	//DIALOG German sentry 2
	
	nClosestGuard.animname = "sightedguard";
	nClosestGuard thread anim_single_solo(nClosestGuard, "germansighted");
	
	wait 4;
}

action_wakeup(nEnemy)
{
	nEnemy endon ("death");
				
	if(isdefined(nEnemy.script_noteworthy) && nEnemy.script_noteworthy == "bunkerguy")
	{
		//println("BUNKER GUY DETECTED");
		
		//wait 2.5;
		
		if(!level.soundplayed)
		{
			//DIALOG German Bunker Sentry
			
			nEnemy playsound("pegasusnight_enemy_openfire");
			level.soundplayed = 1;
			
			//Sort Seed Gunners and start MG42s firing
			
			aGunners = getaiarray("axis");
			for(i=0; i<aGunners.size; i++)
			{
				//println("SORTING GUNNERS FOR GUNNER ASSIGNMENT");
				
				if(isdefined(aGunners[i]) && isalive(aGunners[i]) && isdefined(aGunners[i].script_namenumber) && (aGunners[i].script_namenumber == "bunkerspawn1" || aGunners[i].script_namenumber == "bunkerspawn2" || aGunners[i].script_namenumber == "bunkerspawn3"))
				{
					//println("ASSIGNED TO GUN AND NODE");
					level.bunkergunners++;
					level thread action_mg42_start(aGunners[i]);	
					wait (0.5 + randomfloat(0.5));
				}
			}
		}
	}
	
	wait 1.5;
	
	nEnemy.maxsightdistsqrd = 100000000;
	nEnemy.pacifist = false;			
	
	//*** Phonograph stops
	
	thread phonograph_stop();
}

action_mg42_start(nGunner)
{
	level endon ("capturedbunker");
	
	if(!isdefined(nGunner))
	{
		maps\_utility::error("You must specify the 'nGunner' parameter for action_mg42_start");
	}
	if(isdefined(nGunner.script_namenumber) && nGunner.script_namenumber == "bunkerspawn1")
	{
		nNode = level.nMG42Node1;
		nMG42 = level.nMG42a;
	}
	if(isdefined(nGunner.script_namenumber) && nGunner.script_namenumber == "bunkerspawn2")
	{
		nNode = level.nMG42Node2;
		nMG42 = level.nMG42b;
	}
	if(isdefined(nGunner.script_namenumber) && nGunner.script_namenumber == "bunkerspawn3")
	{
		nNode = level.nMG42Node3;
		nMG42 = level.nMG42c;
	}
	if(isdefined(nGunner.script_namenumber) && (nGunner.script_namenumber == "bunkerspawn1" || nGunner.script_namenumber == "bunkerspawn2" || nGunner.script_namenumber == "bunkerspawn3"))
	{
		nSpawnKey = nGunner.script_namenumber;
		level thread action_mg42_use(nGunner, nMG42, nNode);
		level thread action_mg42_death(nGunner, nSpawnKey);
		level thread action_mg42_popcheck(nGunner);
	}
	
	//println("RUNNING TO GUN");
}

action_mg42_popcheck(nGunner)
{
	nGunner waittill ("death");
	level.bunkergunners--;
}

action_mg42_use(nGunner, nMG42, nNode)
{	
	nGunner endon ("death");
	level endon ("capturedbunker");
	
	while(1)
	{
		//Get close to gun
		
		nGunner.goalradius = 64;
		nGunner setgoalnode(nNode);
		nGunner waittill ("goal");
		
		//Use the gun
		
		nGunner useturret(nMG42);
		nMG42 setmode("auto_ai");
		nMG42 notify ("startfiring");
		
		level waittill ("suppression");	//bunker_suppression
		//println("WE ARE SUPPRESSED!");	
		
		nGunner stopuseturret();
		
		level waittill ("good to go");	//bunker_timeout
	}
}

action_mg42_death(nGunner, nSpawnKey)
{
	level endon ("capturedbunker");
	
	nGunner waittill ("death");
	
	t = 0;
	
	aSpawners = getspawnerarray();
	
	for(i=0; i<aSpawners.size; i++)
	{
		//Respawn if matching spawner found, player hasn't closed in, and Price is farther than required capture range from destination
		
		if(isdefined(aSpawners[i].script_namenumber) && aSpawners[i].script_namenumber == nSpawnKey && level.playerrushed != 1 && level.nLengthSquaredPrice > level.nCaptureRange)
		{
			while(t != 1)
			{
				//println("TRYING TO SPAWN");
				nGunner = aSpawners[i] doSpawn();
				if(isdefined(nGunner))
				{
					t = 1;
					nGunner.dropweapon = false;
					level.bunkergunners++;
					break;
				}
				wait 0.5;
			}
			
			if(!isdefined(nGunner))
			{
				//println("I CAN'T SPAWN FOR SOME REASON");
				break;
			}
			
			//println("SPAWNED REPLACEMENT: ", nGunner.classname);	
			aSpawners[i].count = 50;	//keep resetting for unlimited spawns
			
			break;
		}
	}
	
	if(isdefined(nGunner) && isalive(nGunner))
	{
		//println("NEW GUNNER IS ", nGunner.classname);
		level thread action_mg42_start(nGunner);
	}
}

action_player_rushcheck()
{
	tRushTrigger = getent("player_rushtrigger", "targetname");
	tRushTrigger waittill ("trigger");
	
	level.playerrushed = 1;
}

bunker_assault_schedule()
{
	//Squad assault schedule for the initial bunker capture by the Allies
	
	strAssaultType = "preplaced";
	thread squad_assault(level.strBravo, strAssaultType);
	thread squad_assault(level.strAlpha, strAssaultType);
	thread squad_assault(level.strCharlie, strAssaultType);
	thread squad_assault(level.strDelta, strAssaultType);
}

bunker_suppression()
{
	level endon ("capturedbunker");
	
	while(1)
	{	
		level waittill ("suppression");
		
		aEnemies = getaiarray("axis");
		
		for(i=0; i<aEnemies.size; i++)
		{
			if(isdefined(aEnemies[i].script_noteworthy) && aEnemies[i].script_noteworthy == "bunkerguy")
			{
				level thread bunker_lockdown(aEnemies[i]);
			}
		}
		
		aEnemies = undefined;
	}
}

bunker_suppression_check()
{
	level endon ("suppression_timeout");
	level endon ("capturedbunker");
	
	tDetector = getent("hitdetector","targetname");
	nBurstlimit = 3;	//number of bullets in a valid suppressing burst
	
	while(1)
	{
		nSuppression = 0;	//toggle for suppression status
		nShots = 0;		//number of shots fired
		
		while(!nSuppression)
		{	
			thread bunker_suppression_timer();
			tDetector waittill("trigger", activator);
			
			if (level.player == activator && level.suppression_response == 1)
			{
				//println("activator classname is ",activator.classname);
				level notify ("suppression_process");
				nShots++;
				if(nShots == nBurstlimit)
				{
					//println("VALID BURST FIRE");
					level notify ("suppression");
					wait level.suppressionphase;
					break;
				}
			}
		}
	}
}

bunker_suppression_timer()
{
	level endon ("suppression_process");
	level endon ("capturedbunker");
	
	wait 0.4;
	//println("INCOMPLETE BURST, LOOKING FOR A REAL BURST");
	level notify ("suppression_timeout");
	thread bunker_suppression_check();
}

bunker_lockdown(nEnemy)
{
	level endon ("capturedbunker");
	nEnemy endon ("death");
	
	nEnemy allowedStances ("crouch");
	wait 5;
	
	nEnemy.suppressionwait = level.suppressionphase;
	//println("I'm suppressed, can't do a thing, sir!");
	
	level thread bunker_timeout(nEnemy);
}

bunker_timeout(nEnemy)
{
	level endon ("suppression");
	nEnemy endon ("death");
	
	wait level.suppressionphase;		//this is how long each suppression period is effective
				
	//Enemies come back to normal

	nEnemy.suppressionwait = 0.01;
	nEnemy allowedStances ("stand", "crouch");
	nEnemy.accuracy = 1;
	nEnemy.script_mg42 = 1;

	level notify ("good to go");
	//println("I'm good to go, sir!");
}

bunker_capture()
{
	nCaptured = 0;
	
	nCaptureNode = spawn ("script_origin", (1,1656,0));
	
	while(!nCaptured)
	{
		level.nLengthSquaredPrice = length(nCaptureNode.origin - level.nPrice.origin);
		
		if((level.nLengthSquaredPrice <= level.nCaptureRange || level.playerrushed == 1) && level.bunkergunners == 0)
		{
			nCaptured = 1;
			level notify ("capturedbunker");
			level.bunkercaptured = 1;
			//println("BUNKER IS CAPTURED, WELL DONE");
		}
		
		wait 0.5;
	}
	
	//toss grenades here maybe
	
	level notify ("objective3");
	
	thread bridge_regroup();
	thread westflood_reaction();
}

bridge_regroup()
{
	//The squad regroups at the bridge  
	
	level notify ("bridge_regroup");
	
	nBridgeStartNode = getnode("bridgestartnode", "targetname");
	
	for(i=0; i<level.aFriendlies.size; i++)
	{
		if(isdefined(level.aFriendlies[i]) && isalive(level.aFriendlies[i]))
		{
			level.aFriendlies[i] setgoalnode(nBridgeStartNode);
			level.aFriendlies[i].goalradius = nBridgeStartNode.radius;
			level.aFriendlies[i] allowedstances ("crouch");
		}
	}
	
	wait 5;
	
	level.bridgeregroup = 1;
}

westflood_reaction()
{
	aSpawners = getspawnerarray();
	aReactionSpawners = [];
	
	for(i=0; i<aSpawners.size; i++)
	{
		if(isdefined(aSpawners[i].targetname) && aSpawners[i].targetname == "westflood")
		{					
			//aReactionSpawners = maps\_utility::add_to_array(aReactionSpawners, aSpawners[i]);
			aReactionSpawners[aReactionSpawners.size] = aSpawners[i];
		}
	}
	
	if(isdefined(aReactionSpawners))
	{
		for(i=0; i<aReactionSpawners.size; i++)
		{
			thread maps\_utility::flood_spawn(aReactionSpawners);
			wait 0.05;
		}
	}
}

west_goalchange()
{
	tGoalChanger = getent("goalchange_trigger", "targetname");
	
	while(1)
	{
		tGoalChanger waittill ("trigger");
		if(level.bunkercaptured != 1 || level.bridgeregroup != 1)
		{
			continue;
		}
	
		thread maps\pegasusnight_fx::fieldBattle();
	
		for(i=0; i<level.aFriendlies.size; i++)
		{
			if(isdefined(level.aFriendlies[i]) && isalive(level.aFriendlies[i]))
			{
				level.aFriendlies[i].goalradius = 64;
				level.aFriendlies[i].interval = 8;
				level.aFriendlies[i] setgoalentity(level.player);
				level.aFriendlies[i] allowedstances ("crouch", "stand");
				wait randomfloat(1.5);
			}
		}
		
		nMillsCovernode = getnode("mills_covernode", "targetname");
		level.nMills setgoalnode(nMillsCovernode);
		
		nPriceCovernode = getnode("price_covernode", "targetname");
		level.nPrice setgoalnode(nPriceCovernode);
		
		level.tankreact = 1;
		
		break;
	}
}

west_tank_start()
{
	tTankStart = getent("tank_trigger", "targetname");
	tTankStart waittill ("trigger");
	
	thread tank_spawn();
}

tank_evacuate(eTank, eMG42, eMG42startnode, eTankRetreatNode)
{
	eTank setWaitNode(eTankRetreatNode);
	eTank waittill("reached_wait_node");
	
	thread tank_price_ready();	
	
	level thread tank_mg42start(eTank, eMG42, eMG42startnode);
}

tank_price_ready()
{
	while(level.tankreact == 0)
	{
		wait 0.5;
	}	

	println("*********PRICE ABOUT TO SHOUT*******");
	
	//DIALOG - Capt. Price - Panzer!! Take cover!!
	
	level.nPrice thread anim_single_solo(level.nPrice, "panzercover");
	level.nPrice.ignoreme = 1;
	
	chain = get_friendly_chain_node ("tank_evacuate");
	level.player SetFriendlyChain (chain);
	
	wait 0.05;
	
	thread tank_price_orders();
}

get_friendly_chain_node (chainstring)
{
	trigger = getentarray ("trigger_friendlychain","classname");
	for (i=0;i<trigger.size;i++)
	{
		if ((isdefined (trigger[i].script_chain)) && (trigger[i].script_chain == chainstring))
		{
			chain = trigger[i];
			break;
		}
	}
	
	if (!isdefined (chain))	
	{
		maps\_utility::error ("Tried to get chain " + chainstring + " which does not exist with script_chain on a trigger.");
		return undefined;
	}

	node = getnode (chain.target,"targetname");
	return node;
}

tank_price_orders()
{
	println("STARTING ORDERS OBJECTIVE");
	
	level.nPrice.goalradius = 32;
	level.nPrice waittill ("goal");
	
	level notify ("regroup");
	
	nLength = length(level.nPrice.origin - level.player.origin);
	
	while(nLength > 160)
	{
		wait 0.5;
		nLength = length(level.nPrice.origin - level.player.origin);
	}
	
	wait 0.5;
	
	//DIALOG - Capt. Price - Find Pvt. Mills!
	
	maps\_utility::autosave(3);
	
	nPriceGetMillsNode = getnode("price_covernode", "targetname");
	
	level.nPrice animscripts\shared::LookAtEntity(level.player, 12, "alert");
	level.nPrice thread anim_single_solo(level.nPrice, "findmills", undefined, nPriceGetMillsNode);
	
	level.nPrice.ignoreme = 0;
	
	level notify ("objective4");
	level.repairneeded = 1;
	
	thread mills_flakrepair();
	
	thread tanktroop_assault();
}

mills_flakrepair()
{
	thread maps\pegasusnight_fx::supertracers();
	
	nLength = length(level.nMills.origin - level.player.origin);
	
	while(nLength > 384)
	{
		wait 0.5;
		nLength = length(level.nMills.origin - level.player.origin);
	}
	
	maps\_utility::keyHintPrint(&"SCRIPT_HINT_USEPRIVATEMILLS", getKeyBinding("+activate"));
	
	level.nMills.useable = true;
	level.nMills waittill ("trigger");
	level.nMills.useable = false;
	
	thread tanktroop_final_assault();
	
	//DIALOG - Mills - I'll get it working, etc.
	
	level notify ("mills makes a run for it");
	
	level.nMills animscripts\shared::LookAtEntity(level.player, 6, "alert");
	level.nMills thread anim_single_solo(level.nMills, "followme");
	
	level notify ("mills_found"); //advances objective position marker in objectives()
	
	nMillsRepairNode = getnode("mills_repairnode", "targetname");
	level.nMills.maxsightdistsqrd = 8;
	level.nMills.pacifist = true;
	level.nMills setgoalnode(nMillsRepairNode);
	level.nMills.goalradius = 8;
	level.nMills allowedstances ("stand");
	level.nMills waittill ("goal");
	
	level.nMills.ignoreme = 1;
	level.nMills allowedstances ("crouch");
	
	nFlak88 = getent("flak_88", "targetname");
	
	//anim_single (guy, anime, tag, entity, tag_entity)
	
	//Wait for player to get close enough
	
	dist = length(level.player.origin - level.nMills.origin);
	while(dist > 512)
	{
		dist = length(level.player.origin - level.nMills.origin);	
		wait 0.25;
	}
	
	//level.nMills.animname = "nMills";
	guy[0] = level.nMills;
	nFlak88 playsound ("pegasusnight_mills_adjusting");
	level.nMills maps\_anim::anim_single(guy, "repair", undefined, nFlak88);
	
	//DIALOG - Mills - Try it now!
	
	level.nMills thread anim_single_solo(level.nMills, "oughtadoit");	
	
	nBridgeStartNode = getnode("mills_postrepair_node", "targetname");
	level.nMills setgoalnode(nBridgeStartNode);
	level.nMills.goalradius = 600;
	
	eFlak88 = getent( "flak_88", "targetname" );
	eFlak88 makeVehicleUsable();
	
	level.nMills.pacifist = false;
	level.nMills.maxsightdistsqrd = 100000000;
	level.nMills.ignoreme = 0;
	
	level notify ("objective5");
}

tanktroop_assault()
{
	level endon ("victory");
	strAssaultType = "spawner";
	//squad_assault(strSquadName, strType, iAxisAcc, iAlliedAcc, iRosterMax, iInterval, iAxisSuppWait, iAlliesSuppWait)
	
	nWaves = 3;
	
	//while(level.tankalive == 1)
	for(i=0; i<nWaves; i++)
	{
		thread squad_assault(level.strOmega, strAssaultType, 0.15, undefined, 20, 64, 0.01);
		thread squad_assault(level.strKilo, strAssaultType, 0.15, undefined, 20, 64, 0.01);
		wait (10 + randomfloat(8.5));
	}
}

tanktroop_final_assault()
{
	nFlak88 = getent("flak_88", "targetname");
	activateDist = 800;
	startDist = length(level.player.origin - nFlak88.origin);
	
	while(startDist > activateDist)
	{
		wait 1;
		startDist = length(level.player.origin - nFlak88.origin);
	}
	
	thread tanktroop_assault();
}

victory()
{
	level notify ("objective6");
	level notify ("victory");
	
	level.aLastEnemies = [];
	level.aLastEnemies = getaiarray("axis");
	
	if(level.aLastEnemies.size == 0)
	{
		thread ending();
		return;
	}
	
	n = level.aLastEnemies.size;
	
	for(i=0; i<n; i++)
	{
		if(!(isalive(level.aLastEnemies[i])) || !(isdefined(level.aLastEnemies[i])))
		{
			level.aLastEnemies = maps\_utility::subtract_from_array(level.aLastEnemies, level.aLastEnemies[i]);	
		}
	}
	
	for(i=0; i<level.aLastEnemies.size; i++)
	{
		if(isdefined(level.aLastEnemies[i]) && isalive(level.aLastEnemies[i]))
		{
			level thread victory_deathwaiter(level.aLastEnemies[i]);
			level thread victory_suiciderun(level.aLastEnemies[i]);
		}
	}
	
	thread victory_deathcounter();
}

victory_deathwaiter(nEnemy)
{
	nEnemy waittill("death");
	level.aLastEnemies = maps\_utility::subtract_from_array(level.aLastEnemies, nEnemy);
	println("There are currently ", level.aLastEnemies.size, " enemy soldiers in the level.");
	objective_add(1, "active", "", (288, -1392, 32));
	objective_string(1, &"PEGASUSNIGHT_CLEAR_THE_AREA_COUNTER", level.aLastEnemies.size);
	objective_current(1);
}

victory_deathcounter()
{
	objective_add(1, "active", "", (288, -1392, 32));
	objective_string(1, &"PEGASUSNIGHT_CLEAR_THE_AREA_COUNTER", level.aLastEnemies.size);
	objective_current(1);
	
	while(level.aLastEnemies.size > 0)
	{
		wait 0.25;
	}
	
	println("All enemies are dead.");
	
	thread ending();
}

victory_suiciderun(nSoldier)
{
	nSoldier endon ("death");
	
	wait randomintrange(10, 25);
	
	
}

ending()
{
	level notify ("allclear");
	
	wait 1;
	
	ending_extras();
	
	thread maps\_utility::save_friendlies(); 
	
	missionSuccess("pegasusday", true);
}

ending_extras()
{
	//Spawn farthest friendlies to generate reasonable speech sources and repopulate at end
	
	nWestRefNode = getnode("west_refnode", "targetname");
	nEastRefNode = getnode("east_refnode", "targetname");
	
	westdist = length(level.player.origin - nWestRefNode.origin);
	eastdist = length(level.player.origin - nEastRefNode.origin);
	
	aSpawner = getspawnerarray();
	
	if(westdist <= eastdist)
	{
		for(i=0; i<aSpawner.size; i++)
		{
			if(isdefined(aSpawner[i].targetname) && aSpawner[i].targetname == "friendly_backup_troops_east")
			{
				nTalker = aSpawner[i] doSpawn();	
			}
		}
	}
	else
	{
		for(i=0; i<aSpawner.size; i++)
		{
			if(isdefined(aSpawner[i].targetname) && aSpawner[i].targetname == "friendly_backup_troops_west")
			{
				nTalker = aSpawner[i] doSpawn();	
			}
		}
	}
	
	level.nMills anim_single_solo(level.nMills, "bridgeclearmills");
	wait 1;
	level thread house_rally_reply("victory1");
	wait 1.8;
	level thread house_rally_reply("victory2");
	wait 2.5;
	level thread house_rally_reply("victory3");
	wait 1;
	level thread house_rally_reply("victory5");
	wait 1.8;
	//level thread house_rally_reply("victory4");
	//wait 2;
}

house_rally_reply(nAnimRef)
{
	aFriendlies = [];
	aFriendlies = getaiarray("allies");
	if(aFriendlies.size > 1)
	{
		for(i=0; i<aFriendlies.size; i++)
		{
			if(isdefined(aFriendlies[i].targetname) && (aFriendlies[i].targetname == "price" || aFriendlies[i].targetname == "mills"))
			{
				maps\_utility::subtract_from_array(aFriendlies, aFriendlies[i]);
			}
		}
		nSize = aFriendlies.size;
		nRandomFriend = aFriendlies[randomint(nSize)];
		nRandomFriend.animname = "randomguy";
		
		nRandomFriend thread anim_single_solo(nRandomFriend, nAnimRef);
	}
	
	aFriendlies = undefined;
}

//=======================================================================================================================================================//
//=======================================================================================================================================================//

//**********************************************//
//		OBJECTIVE UTILITIES		//
//**********************************************//

objectives()
{
	if (getcvar ("start") != "skipglider")
	{
		level waittill ("blackout voices done");
	}
	
	maps\_utility::autosave(1);
	
	objective_add(1, "active", &"PEGASUSNIGHT_CLEAR_THE_AREA_OF_ENEMIES");
	objective_current(1);
	
	level waittill ("objective2");
	
	objective_add(2, "active", &"PEGASUSNIGHT_CAPTURE_THE_BUNKER", (16, 1396, 56));
	objective_current(2);
	
	level waittill ("objective3");
	
	objective_state(2, "done");
	
	objective_add(1, "active", &"PEGASUSNIGHT_CLEAR_THE_AREA_OF_ENEMIES", (288, -1392, 32));
	objective_current(1);
	
	maps\_utility::autosave(2);
	
	level waittill ("regroup");
	
	objective_add(3, "active", &"PEGASUSNIGHT_REGROUP_WITH_CAPTAIN", level.nPrice.origin);
	objective_current(3);
	
	level waittill ("objective4");
	
	objective_state(3, "done");
	
	objective_add(4, "active", &"PEGASUSNIGHT_FIND_AN_ARMY_ENGINEER", (level.nMills.origin));
	objective_current(4);
	
	level waittill ("mills_found");
	
	nFlak88 = getent("flak_88", "targetname");
	
	objective_add(4, "active", &"PEGASUSNIGHT_GET_BACK_TO_THE_FLAK", (nFlak88.origin));
	objective_current(4);
	
	level waittill ("objective5");
	
	objective_state(4, "done");
	
	nPyreFX = getent("tankpyre", "targetname");
	
	objective_add(5, "active", &"PEGASUSNIGHT_USE_THE_FLAK88_GUN_TO", (nFlak88.origin));
	objective_current(5);
	
	level waittill ("objective6");
	
	objective_state(5, "done");
	
	level waittill ("allclear");
	
	objective_state(1, "done");
}

//******************************************************//
//		INFANTRY COMBAT UTILITIES		//
//******************************************************//

/*******************

squad_route (many, required)
squad_entry (many, optional)
squad_contact (many, optional)
squad_capture (one, required)

Variables:

strSquadName (name of squad - script_squadname)
strType (specify "spawner" or "preplaced")

Endon:

"victory"

Notes:

1. turn on squad spawn (call assault thread)
2. pass the desired script_squadname to the squad_assault thread
3. getspawnerarray on squad spawners OR sort through preplaced AI
4. choose spawners OR preplaced guys with specified squadname only 
5. spawn the guys OR use preplaced guys
6. array the guys for individual specification (squadRoster array)
7. array the squad_route nodes
8. referring to array entries of the guys and route nodes, run the guys through the course of their journey with calls to attack_move_node

********************/

squad_assault(strSquadName, strType, iAxisAcc, iAlliedAcc, iRosterMax, iInterval, iAxisSuppWait, iAlliesSuppWait)
{	
	level endon ("victory");
	
	//Create blank arrays
	
	aSpawner = [];		//sort for roster	
	aPreplaced = [];	//sort for roster if there are no spawners involved, just guys already pre-placed
	aSquadNodeSort = [];	//sort from route nodes
	aSquadRoster = [];	//soldiers in the specified squad
	aSquadRoutes = [];	//all squad route nodes
	aSquadContact = [];	//all contact nodes
	aSquadEntry = [];	//all entry nodes
	aSquadCapture = [];	//all capture nodes
	
	aSquadContactNodes = [];
	aSquadEntryNodes = [];
	
	//pegasusday magic numbers are defaults
	
	if(!isdefined(strSquadName))
	{
		thread maps\_utility::error("You need to specify a squadname string.");
	}
	if(!isdefined(strType))
	{
		thread maps\_utility::error("You need to specify a squad type string, 'spawner' or 'preplaced.'");
	}
	if(!isdefined(iAxisAcc))
	{
		iAxisAcc = 0.2;		//accuracy of spawned axis troops
	}
	if(!isdefined(iAlliedAcc))
	{
		iAlliedAcc = 1;	//accuracy of spawned allied troops
	}
	if(!isdefined(iRosterMax))
	{
		iRosterMax = 32;		//max number of individual AI allowed in level
	}
	if(!isdefined(iInterval))
	{
		iInterval = 96;		//magical interval number for spawned axis troops
	}
	if(!isdefined(iAxisSuppWait))
	{
		iAxisSuppWait = 0.1;		//suppressionwait of spawned axis troops
	}
	if(!isdefined(iAlliesSuppWait))
	{
		iAlliesSuppWait = 0.01;		//suppressionwait of spawned axis troops
	}

	//***** Spawner or Preplaced - Create roster for specified squadname
	
	if(strType == "spawner")
	{
		aSpawner = getspawnerarray();	
		
		for(i=0; i<aSpawner.size; i++)
		{	
			//Check and don't spawn troops over the max number of enemies (before victory) or friendlies (at victory) allowed in the level
			
			aArmyRoster = getaiarray("axis");
			aFriendRoster = getaiarray("allies");
			nBodyCount = aFriendRoster.size + aArmyRoster.size;
			
			if(isdefined (aSpawner[i].script_squadname) && (aSpawner[i].script_squadname == strSquadName) && (nBodyCount < iRosterMax))
			{
				aArmyRoster = undefined;
				aFriendRoster = undefined;
				
				//println("Spawning Group ", strSquadName, " Soldier ", i);
				nSoldier = aSpawner[i] doSpawn();	
				
				if(isdefined (nSoldier))
				{
					nSoldier.interval = iInterval;	
					nSoldier.suppressionwait = iAxisSuppWait;
					nSoldier.bravery = 500000;	//forces AI to do whatever it's told regardless of danger
					if(nSoldier.team == "axis")
					{
						nSoldier.accuracy = iAxisAcc;	
					}
					if(nSoldier.team == "allies")
					{
						nSoldier.accuracy = iAlliedAcc;	
						nSoldier.suppressionwait = iAlliesSuppWait;
					}
					nSoldier.targetname = strSquadName; //for easy testing ID with g_entinfo
					//aSquadRoster = maps\_utility::add_to_array(aSquadRoster, nSoldier);
					aSquadRoster[aSquadRoster.size] = nSoldier;							
				}
				
				aSpawner[i].count = 50;	//reset spawn limit, never run out
			}	
		}
		
		aSpawner = undefined;	
	}
	//******************************************************
	
	//*** For pre-placed squads of AI units
	
	if(strType == "preplaced")
	{
		aPreplaced = getaiarray();
		
		for(i=0; i<aPreplaced.size; i++)
		{	
			if(isdefined (aPreplaced[i].script_squadname) && (aPreplaced[i].script_squadname == strSquadName))
			{	
				aPreplaced[i].script_moveoverride = 1;	
				aPreplaced[i].bravery = 500000;	//forces AI to do whatever it's told regardless of danger	
				if(aPreplaced[i].team == "axis")
				{
					aPreplaced[i].accuracy = iAxisAcc;	
					aPreplaced[i].suppressionwait = iAxisSuppWait;
				}
				if(aPreplaced[i].team == "allies")
				{
					aPreplaced[i].accuracy = iAlliedAcc;	
					aPreplaced[i].suppressionwait = iAlliesSuppWait;
				}				
				
				//aSquadRoster = maps\_utility::add_to_array(aSquadRoster, aPreplaced[i]);	
				aSquadRoster[aSquadRoster.size] = aPreplaced[i];
			}	
		}
	}
	
	//******************************************************
	
	//***** Create the squad_route choices
	
	aSquadNodeSort = getnodearray("squad_route","targetname");
	for(i=0; i<aSquadNodeSort.size; i++)
	{
		if(isdefined (aSquadNodeSort[i].script_squadname) && (aSquadNodeSort[i].script_squadname == strSquadName))
		{
			//aSquadRoutes = maps\_utility::add_to_array(aSquadRoutes, aSquadNodeSort[i]);
			aSquadRoutes[aSquadRoutes.size] = aSquadNodeSort[i];
		}
	}
	aSquadNodeSort = undefined;
	
	//***** Get contact node
	
	aSquadContact = getnodearray("squad_contact","targetname");
	for(i=0; i<aSquadContact.size; i++)
	{
		if(isdefined (aSquadContact[i].script_squadname) && (aSquadContact[i].script_squadname == strSquadName))
		{
			//aSquadContactNodes = maps\_utility::add_to_array(aSquadContactNodes, aSquadContact[i]);
			aSquadContactNodes[aSquadContactNodes.size] = aSquadContact[i];
		}
	}
	aSquadContact = undefined;
	
	//***** Get entry node
	
	aSquadEntry = getnodearray("squad_entry","targetname");
	for(i=0; i<aSquadEntry.size; i++)
	{
		if(isdefined (aSquadEntry[i].script_squadname) && (aSquadEntry[i].script_squadname == strSquadName))
		{
			//aSquadEntryNodes = maps\_utility::add_to_array(aSquadEntryNodes, aSquadEntry[i]);
			aSquadEntryNodes[aSquadEntryNodes.size] = aSquadEntry[i];
		}
	}
	aSquadEntry = undefined;
	
	//***** Get capture node
	
	aSquadCapture = getnodearray("squad_capture","targetname");
	for(i=0; i<aSquadCapture.size; i++)
	{
		if(isdefined (aSquadCapture[i].script_squadname) && (aSquadCapture[i].script_squadname == strSquadName))
		{
			nSquadCaptureNode = aSquadCapture[i];
		}
	}
	aSquadCapture = undefined;
	
	//***** Deploy squad on assault mission with roster, routes, and nodes
	
	thread squad_deploy(aSquadRoster, aSquadRoutes, aSquadContactNodes, aSquadEntryNodes, nSquadCaptureNode);
}

squad_deploy(aSoldiers, aRoutes, aContactNodes, aEntryNodes, nCaptureNode)
{	
	//Send soldiers to random routes
	
	if(!aRoutes.size)
	{
		thread maps\_utility::error("You have to have at least one 'targetname = squad_route' node with this squadname.");
	}
	
	nDefaultNode = aRoutes[randomint(aRoutes.size)];
	
	for(i=0; i<aSoldiers.size; i++)
	{
		if(isdefined (aSoldiers[i]) && isalive(aSoldiers[i]))
		{	
			if(!aRoutes.size)
			{
				nRouteNode = nDefaultNode;
				aSoldiers[i] setgoalnode(nRouteNode);	//random routes, single use only
			}
			else
			{
				r = randomint(aRoutes.size);
				nRouteNode = aRoutes[r];
				aSoldiers[i] setgoalnode(nRouteNode);	//random routes, single use only
				aRoutes = maps\_utility::subtract_from_array(aRoutes, aRoutes[r]);
			}
			
			level thread squad_move(aSoldiers[i], aContactNodes, aEntryNodes, nCaptureNode);	//movement orders
		
			wait 0.25;
		
			//wait (level.fBaseInterval + randomfloat(level.fGapInterval));	//random natural pause between individual soldier deployments
		}
	}
}

squad_move(nSoldier, aContactNodes, aEntryNodes, nCaptureNode)
{
	//Wait for soldier to reach route node
	
	level endon ("bridge_regroup");
	nSoldier endon ("death");
	
	nSoldier waittill("goal");

	//Send soldier to random entry node if any

	//Format: attack_move_node(nSoldier, fWaitMin, fWaitMax, fClosureRate, nGoalNode, fStartRadius, fEndRadius)

	if(aEntryNodes.size > 0)
	{
		nRndEntryNode = aEntryNodes[randomint(aEntryNodes.size)];			
		if(nSoldier.team == "axis")
		{
			level attack_move_node(nSoldier, 2, 6, 0.88, nRndEntryNode, undefined, 300);
		}
		if(nSoldier.team == "allies")
		{
			level attack_move_node(nSoldier, 0.1, 0.2, 0.9, nRndEntryNode, undefined, 256);
		}
	}

	//Send soldier to contact zone

	if(aContactNodes.size > 0)
	{
		nRndContactNode = aContactNodes[randomint(aContactNodes.size)];
		if(nSoldier.team == "axis")
		{
			level attack_move_node(nSoldier, 4.8, 7, 0.96, nRndContactNode, undefined, 640);
		}
		if(nSoldier.team == "allies")
		{
			level attack_move_node(nSoldier, 0.5, 0.6, 0.9, nRndContactNode, undefined, 256);
		}
	}
	
	//Send soldier to capture point
	
	if(!isdefined(nCaptureNode))
	{
		thread maps\_utility::error("You need to place a capture node for this squadname.");
	}
	if(nSoldier.team == "axis")
	{
		level attack_move_node(nSoldier, 3.3, 4.5, 0.96, nCaptureNode, undefined, 1200);
	}
	if(nSoldier.team == "allies")
	{
		level attack_move_node(nSoldier, 0.2, 0.5, 0.9, nCaptureNode, undefined, 384);
	}
}

//***************************************************

attack_move_node(nSoldier, fWaitMin, fWaitMax, fClosureRate, nGoalNode, fStartRadius, fEndRadius)
{
	/*
		nSoldier	= 	the soldier
		fWaitMin 	=	wait at least this many seconds before advancing 	(default 0.5)
		fWaitMax	= 	wait no more than this many seconds before advancing	(default 2.5)
		fClosureRate	=	pare down the goalradius by this amount (use values < 1)(default 0.85)
		nGoalNode	=	variable assigned goalnode				(required, get this just before calling attack_move_node)
		fStartRadius	=	initial goalradius of the soldier 			(default 1200, or set on node or in call)
		fEndRadius	=	final goalradius of the soldier				(default 512, or set directly in call)	
	
		Jacked up and good to go! Use to make AI fight towards a goal node.
	*/
	
	level endon ("bridge_regroup");
	nSoldier endon("death");
	
	if(!isdefined(nGoalNode))
	{
		maps\_utility::error("Missing a goal node.");
	}
	if(isdefined(nGoalNode.radius))
	{
		fStartRadius = nGoalNode.radius;
	}
	if(!isdefined(fStartRadius))
	{
		fStartRadius = 1200;
	}
	if(!isdefined(fWaitMin))
	{
		fWaitMin = 0.5;
	}
	if(!isdefined(fWaitMax))
	{
		fWaitMax = 2.5;
	}
	if(!isdefined(fClosureRate))
	{
		fClosureRate = 0.85;
	}
	if(isdefined(fEndRadius))		
	{
		fDestRadius = fEndRadius;
	}
	else
	{
		fDestRadius = 512;		
	}
	
	wait (randomfloatrange(0.5,2.25));	//usually used on multiple guys, so start out randomly
	
	nSoldier setgoalnode(nGoalNode);
	nSoldier.goalradius = fStartRadius;
	
	while(nSoldier.goalradius > fDestRadius)
	{
		wait (randomfloatrange(fWaitMin,fWaitMax));
		nSoldier.goalradius = nSoldier.goalradius * fClosureRate;
		nSoldier waittill("goal");	
	}
}

//***************************************************

friendly_shield(nFriendly)
{
	//Variant of magic bullet shield 
	
	level endon ("stop magic friendly shield");
	nFriendly endon ("death");
	
	while (isAlive(nFriendly))
	{
		nFriendly waittill ("pain");
		nFriendly.ignoreme = true;
		wait level.ignoretime;
		if(isAlive(nFriendly))
		{
			nFriendly.ignoreme = false;
			//nFriendly.health = nFriendly.health + 20;
		}
	}
}

//**********************************************//
//		TANK UTILITIES			//
//**********************************************//

#using_animtree( "panzerIV" ); 

tank_spawn()
{
	eStartNode = getVehicleNode("start_path", "targetname");
	eTank = spawnVehicle( "xmodel/vehicle_tank_panzeriv_camo", "tank", "PanzerIV", (0,0,0), (0,0,0) );	//model, targetname, type, origin, angles
	
	eTank thread maps\_panzerIV::kill();
	
	eTank.script_team = "axis";
	
	eTank thread maps\_tankgun::mginit();
	eTank thread maps\_tankgun::mgoff();
	
	eMG42startnode = getVehicleNode("tankmgstart", "targetname");
	eTankRetreatNode = getVehicleNode("tankretreatnode", "targetname");
	
	level thread tank_init(eTank);	
	level thread tank_kill(eTank);	
	level thread tank_evacuate(eTank, eMG42, eMG42startnode, eTankRetreatNode);
	
	eTank attachPath(eStartNode);
	
	eTank startPath();
	level thread tank_status(eTank); 	
}

tank_mg42start(eTank, eMG42, eMG42startnode)
{
	eTank setWaitNode(eMG42startnode);
	eTank waittill("reached_wait_node");
	
	eTank thread maps\_tankgun::mgon();
	
	level thread tank_mg42_accuracy(eTank);
}

tank_mg42_accuracy(eTank)
{	
	//Regulates the accuracy of the tank MG42 according to player proximity and special NPC activity
	eTank endon("death");
	
	eTank.mgturret setTurretAccuracy(0.15);
	eTank.mgturret.convergencetime = 3;
	
	level waittill ("mills makes a run for it");
	
	while(1)
	{	
		guntarget = eTank.mgturret getTurretTarget();
		
		if(isdefined(guntarget))
		{
			if(guntarget == level.nMills)
			{
				println("MG42 targeting Mills");
				eTank.mgturret setTurretAccuracy(0);
				eTank.mgturret.convergencetime = 6;
			}
			else
			if(guntarget == level.player)
			{
				println("MG42 targeting Player");
				dist = length(level.player.origin - eTank.origin);
				if(dist <= 800)
				{
					eTank.mgturret setTurretAccuracy(0.5);
					eTank.mgturret.convergencetime = 2;
				}
				else
				if(dist > 800 && dist <= 1500)
				{
					eTank.mgturret setTurretAccuracy(0.5);
					eTank.mgturret.convergencetime = 2;
				}
				else
				if(dist > 1500 && dist <= 2500)
				{
					eTank.mgturret setTurretAccuracy(0.1);
					eTank.mgturret.convergencetime = 4;
				}
				else
				if(dist > 2500)
				{
					eTank.mgturret setTurretAccuracy(0.05);
					eTank.mgturret.convergencetime = 6;
				}
			}
		}
		wait 0.1;
	} 
}

tank_init(eTank)
{
	eTank endon("death");
	
	eTank useAnimTree( #animtree );
	eTank.isalive = 1;
	eTank.health  = 2000;
}

tank_kill(eTank)
{	
	/*
	eTank.deathmodel = "xmodel/vehicle_tank_panzeriv_d";
	eTank.deathfx    = loadfx( "fx/explosions/explosion1.efx" );
	eTank.deathsound = "explo_metal_rand";

	maps\_utility::precache( eTank.deathmodel );
	*/
	
	eTank waittill( "death" );
	
	/*
	eTank.isalive = 0;
	eTank setmodel( eTank.deathmodel );
	eTank playsound( eTank.deathsound );
	eTank setAnimKnobRestart( %PanzerIV_d );
	eTank clearTurretTarget();

	playfx( eTank.deathfx, eTank.origin );
	
	level thread radius_damage(eTank, 180, 750, 650);	//nObject, range, maxdamage, mindamage
	
	earthquake( 0.25, 3, eTank.origin, 2450 );
	*/
	
	thread tank_kill_explosions();
	
	//DIALOG - Mills - That did it!
	
	level.nMills anim_single_solo(level.nMills, "thatdidit");
	
	//DIALOG - Mills - Nice shot Sergeant!
	
	level.nMills anim_single_solo(level.nMills, "nicesarge");
	
	//Put everyone back on the friendlychain to go back to the west side of the bridge
	
	chain = get_friendly_chain_node ("bridge_regroup");
	level.player SetFriendlyChain (chain);
	
	level.nMills setgoalentity(level.player);
	wait 6;
	level.nMills anim_single_solo(level.nMills, "checktrenches");
}

tank_kill_explosions()
{	
	nTankPyre = getent("tankpyre", "targetname");
	lingerfx = loadfx("fx/smoke/oneshotblacksmokelinger.efx");
	
	eTankdeathfx    = loadfx( "fx/explosions/explosion1.efx" );
	eTankdeathsound = "explo_metal_rand";
	
	maps\_fx::loopfx(nTankPyre.script_fxid, nTankPyre.origin, 0.3);
	
	//Primary Blast
	nTankPyre thread maps\_mortar::mortar_boom((320, -3264, 142));
	nTankPyre thread maps\_mortar::mortar_boom((440, -3264, 142));
	wait 0.15;
	nTankPyre thread maps\_mortar::mortar_boom((374, -3100, 122));
	wait 0.15;
	nTankPyre thread maps\_mortar::mortar_boom((344, -3500, 92));
	wait 0.2;
	nTankPyre thread maps\_mortar::mortar_boom((324, -3250, 102));
	wait 0.12;
	nTankPyre thread maps\_mortar::mortar_boom((424, -3100, 122));
	nTankPyre thread maps\_mortar::mortar_boom((440, -3264, 142));
	playfx( eTankdeathfx, nTankPyre.origin );
	nTankPyre playsound( eTankdeathsound );
	
	//Secondary Blasts
	
	nTankPyre thread maps\_mortar::mortar_boom((384, -3392, 112));
	wait 0.8;
	nTankPyre thread maps\_mortar::mortar_boom((344, -3500, 92));
	wait 0.32;
	nTankPyre thread maps\_mortar::mortar_boom((374, -3100, 122));
	playfx( eTankdeathfx, nTankPyre.origin );
	nTankPyre playsound( eTankdeathsound );
	wait 0.8;
	nTankPyre thread maps\_mortar::mortar_boom((324, -3250, 102));
	wait 0.32;
	nTankPyre thread maps\_mortar::mortar_boom((424, -3100, 122));
	wait 0.35;
	playfx( eTankdeathfx, nTankPyre.origin );
	nTankPyre playsound( eTankdeathsound );
	nTankPyre thread maps\_mortar::mortar_boom((320, -3264, 142));
	wait 0.65;
	nTankPyre thread maps\_mortar::mortar_boom((440, -3264, 142));
	wait 0.8;
	playfx( eTankdeathfx, nTankPyre.origin );
	nTankPyre playsound( eTankdeathsound );
	nTankPyre thread maps\_mortar::mortar_boom((374, -3100, 122));
	wait 0.9;
	nTankPyre thread maps\_mortar::mortar_boom((344, -3500, 92));
	playfx( eTankdeathfx, nTankPyre.origin );
	nTankPyre playsound( eTankdeathsound );
	wait 0.8;
	nTankPyre thread maps\_mortar::mortar_boom((324, -3250, 102));
	wait 0.25;
	nTankPyre thread maps\_mortar::mortar_boom((424, -3100, 122));
	wait 0.5;
	nTankPyre thread maps\_mortar::mortar_boom((384, -3392, 112));	
	playfx( eTankdeathfx, nTankPyre.origin );
	nTankPyre playsound( eTankdeathsound );
	nTankPyre thread maps\_mortar::mortar_boom((320, -3264, 142));
	nTankPyre thread maps\_mortar::mortar_boom((440, -3264, 142));
	wait 0.2;
	nTankPyre thread maps\_mortar::mortar_boom((374, -3100, 122));
	wait 0.15;
	nTankPyre thread maps\_mortar::mortar_boom((344, -3500, 92));
	wait 0.3;
	nTankPyre thread maps\_mortar::mortar_boom((324, -3250, 102));
	wait 0.4;
	nTankPyre thread maps\_mortar::mortar_boom((424, -3100, 122));
	nTankPyre thread maps\_mortar::mortar_boom((440, -3264, 142));
	playfx( eTankdeathfx, nTankPyre.origin );
	nTankPyre playsound( eTankdeathsound );
	
	org = spawn ("script_origin",(nTankPyre.origin));
	org playloopsound ("bigfire_pegasus");
	
	while(1)
	{
		playfx( lingerfx, nTankPyre.origin );
		wait 0.8;
	}
}

tank_status(eTank)
{
	eTank waittill("death");

	level.tankalive = 0;
	thread victory();
}

radius_damage(nObject, range, maxdamage, mindamage)
{
	origin = nObject getorigin();
	
	maps\_fx::GrenadeExplosionfx(origin);
	radiusDamage(origin, range, maxdamage, mindamage);
}

//**********************************************//
//		FLAK GUN UTILITIES		//
//**********************************************//

flak88_init()
{
	thread maps\_flak::flak88_playerinit();
	thread flak88_life();
	thread flak88_kill();
	thread flak88_shoot();
}

flak88_life()
{
	self.isalive = 1;
	self.health  = 1000;
}

flak88_kill()
{
	self.deathmodel = "xmodel/turret_flak88_d";
	self.deathfx    = loadfx( "fx/explosions/explosion1.efx" );
	self.deathsound = "explo_metal_rand";

	maps\_utility::precache( self.deathmodel );

	self waittill( "death", attacker );

	self.isalive = 0;
	
	self setmodel( self.deathmodel );
	self playsound( self.deathsound );
	self clearTurretTarget();
	
	playfx( self.deathfx, self.origin );
	earthquake( 0.25, 3, self.origin, 1050 );
}

flak88_shoot()
{
	while( self.isalive == 1 )
	{
		self waittill( "turret_fire" );
		self FireTurret();
		wait 1;
		self playsound ("flak_reload");
	}
}

//**********************************************//
//	INTRO/OUTRO SCREEN UTILITIES		//
//**********************************************//
/*
fadein()
{
	black = 0;
	
	hdSetString(black, hdGetShaderString("ui/assets/fadebox.tga", 640, 480));
	hdSetPosition(black, 0, 0);
	hdSetAlpha(black, 1);

	level waittill ("wakeupcall");

	timer = level.fadeintime * 1000;
	total_time = gettime() + timer;
	
	while (gettime() < total_time)
	{
		fraction = (total_time - gettime());
		fraction = (float) fraction / (float) timer;
		hdSetAlpha(black, fraction);
		wait (0.01);
	}

	hdSetAlpha(black, 0);
}
*/
//**********************************************//
//	GLIDER RIDE SEQUENCE UTILITIES		//
//**********************************************//

blackout()
{
	//wait 22.3;
	
	level waittill ("startsecondhalf");
	wait 22.2;
	
	//hdSetPosition(0, 0, 0);
	//hdSetString(0, hdGetShaderString("black", 640, 480));
	
	level.blackoutelem = newHudElem();
	level.blackoutelem setShader("black", 640, 480);
	
	println("It goes black!");
	
	//hdSetAlpha(0, 1);
	
	level.blackoutelem.alpha = 1;
	
	aDummyGliders = getentarray("dummyglider", "targetname");
	for(i=0; i<aDummyGliders.size; i++)
	{
		aDummyGliders[i] show();
	}
	
	level.player unlink();
	
	level.player setorigin ((2928, 2648, -79));
	
	level.player freezeControls(true);
	
	aPassengers = getentarray("airborne_soldier", "targetname");
	for(i=0; i<aPassengers.size; i++)
	{
		aPassengers[i] delete();
	}
	
	nGlider = getent("glider_interior", "targetname");
	nGlider delete();
	
	level notify ("glider ride finished");
	
	level.player shellshock("groggy", 20);
}

glider_ride_music()
{
	wait 0.05;
	musicplay("pf_stealth");
}

glider_ride()
{	
	thread glider_ride_music();
	
	level.player setplayerangles((0,0,0));
	
	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowProne(false);
	level.player allowCrouch(false);
	
	aDummyGliders = getentarray("dummyglider", "targetname");
	for(i=0; i<aDummyGliders.size; i++)
	{
		aDummyGliders[i] hide();
	}
	
	nGlider = getent("glider_interior", "targetname");
	
	level thread glider_flight_start(nGlider);
	
	level.player linkto (nGlider, "tag_camera", (0,0,-56),(0,0,0));

	level notify ("glidercrashflight");
	
	thread glider_navigation(nGlider);
	thread glider_crash_sequence();

	//thread glider_shudders(nGlider);
	thread glider_speech(nGlider);
	
	aPassengers = getentarray("airborne_soldier", "targetname");
	
	for(i=0; i<aPassengers.size; i++)
	{
		aPassengers[i] character\BritishAirborne::precache();
		aPassengers[i] character\_utility::new();
		aPassengers[i] character\BritishAirborne::main();
		
		//Assign weapons to guys
		
		rand = randomint(100);
		/*
		if(i!=0 && i!=1 && i!=12)
		{
			if(rand >= 0 && rand < 40)
			{
				aPassengers[i] attach ("xmodel/weapon_enfield", "tag_weapon_Left");
			}
			else
			if(rand >= 40 && rand < 95)
			{
				aPassengers[i] attach ("xmodel/weapon_sten", "tag_weapon_Right");
			}
			else
			{
				aPassengers[i] attach ("xmodel/weapon_bren", "tag_weapon_Left");
			}
		}
		
		if(i == 12)
		{
			aPassengers[i] attach ("xmodel/weapon_sten", "tag_weapon_Right");
		}
		*/
		//Create animname refs
		
		aPassengers[i].animname = ("guy"+(i+1));
	
		if ((i+1) <= 9)
			tag = ("tag_guy0" + (i+1));
		else
			tag = ("tag_guy" + (i+1));
		
		aPassengers[i].tag = tag;
		
		if(aPassengers[i].tag == "tag_guy01" || aPassengers[i].tag == "tag_guy02")
		{
			aPassengers[i] character\BritishAirborneNoGear::precache();
			aPassengers[i] character\_utility::new();
			aPassengers[i] character\BritishAirborneNoGear::main();
		}
		
		if(aPassengers[i].tag == "tag_guy03" || aPassengers[i].tag == "tag_guy05")
		{
			aPassengers[i].swapWeapon = "xmodel/weapon_enfield";
			aPassengers[i] attach (aPassengers[i].swapWeapon, "tag_weapon_Left");
		}
		else
		if(aPassengers[i].tag == "tag_guy04")
		{
			aPassengers[i].swapWeapon = "xmodel/weapon_sten";
			aPassengers[i] attach (aPassengers[i].swapWeapon, "tag_weapon_Right");
		}
		else 
		if(aPassengers[i].tag == "tag_guy06")
		{
			aPassengers[i].swapWeapon = "xmodel/weapon_bren";
			aPassengers[i] attach (aPassengers[i].swapWeapon, "tag_weapon_Left");
		}
		else
		if(aPassengers[i].tag == "tag_guy07" || aPassengers[i].tag == "tag_guy08" || aPassengers[i].tag == "tag_guy09" || aPassengers[i].tag == "tag_guy11")
		{
			aPassengers[i].swapWeapon = "xmodel/weapon_enfield";
			aPassengers[i] attach (aPassengers[i].swapWeapon, "tag_weapon_Left");
		}
		else
		if(aPassengers[i].tag == "tag_guy12" || aPassengers[i].tag == "tag_guy10")
		{
			aPassengers[i].swapWeapon = "xmodel/weapon_sten";
			aPassengers[i] attach (aPassengers[i].swapWeapon, "tag_weapon_Right");
		}
		
		x = i+1;
		
		if(x==1)
		{
			aPassengers[i] useAnimTree (level.scr_animtree["guy1"]);
		}
		else 
		if(x==2)
		{
			aPassengers[i] useAnimTree (level.scr_animtree["guy2"]);
		}
		else
		if(x==5 || x==6 || x==7 || x==8 || x==9)
		{
			aPassengers[i] useAnimTree (level.scr_animtree["horsa_others"]);
		}
		else
		if(x==4 || x==10 || x==12)
		{
			aPassengers[i] useAnimTree (level.scr_animtree["horsa_stens"]);
		}
		else
		if(x==3 || x==11)
		{
			aPassengers[i] useAnimTree (level.scr_animtree["horsa_specials"]);
		}
		
		nGlider thread anim_teleport_solo (aPassengers[i], "2nd half", tag);
		aPassengers[i] linkto (nGlider, tag, (0,0,0),(0,0,0));
		//if ((i!=5) && (i!= 8))
		//	aPassengers[i] hide();
	}
	
	nGlider.animname = ("glider");
	nGlider useAnimTree (level.scr_animtree[nGlider.animname]);
	
	//Glider passenger animations (highturb, lowturb, etc.)
	
	thread glider_turb(nGlider, "low", aPassengers);
	wait 15;
	println("smoking now");
	
	aPassengers[5] notify ("stoploop5");
	aPassengers[8] notify ("stoploop8");
	
	nGlider thread maps\_anim::anim_single_solo (aPassengers[5], "cigarette", aPassengers[5].tag);
	nGlider maps\_anim::anim_single_solo (aPassengers[8], "cigarette", aPassengers[8].tag);
	
	thread glider_turb(nGlider, "high", aPassengers);
	wait 2;
	thread glider_turb(nGlider, "low", aPassengers);
	
	//2nd half animations begin
	
	level waittill ("startsecondhalf");
	
	for(i=0; i<aPassengers.size; i++)
	{
		nGlider notify ("stoploop"+i);
	}
	
	nGlider setFlaggedAnimKnobRestart("animdone", level.scr_anim[nGlider.animname]["2nd half"], 1.0);
	//nGlider thread maps\_anim::anim_teleport_solo (nGlider, "2nd half", tag);
	//nGlider thread maps\_anim::anim_single_solo (nGlider, "2nd half", tag);
	
	for(i=0; i<aPassengers.size; i++)
	{
		nGlider thread maps\_anim::anim_single_solo (aPassengers[i], "2nd half", aPassengers[i].tag);
	}
}

glider_turb(nGlider, type, aPassengers)
{
	level.turbulence = type;
	
	for(i=0; i<aPassengers.size; i++)
	{
		//[owner of tag] thread maps\_anim::anim_loop_solo (thing doing anim, name of the anim, tag on owner, ending notify string)
		nGlider notify ("stoploop"+i);
		nGlider thread maps\_anim::anim_loop_solo (aPassengers[i], type+"turb", aPassengers[i].tag, "stoploop"+i);
	}
	
	nGlider setAnimKnobRestart(level.scr_anim[nGlider.animname]["glider"+type+"turb"], 1.0);
}

glider_shudders(nGlider)
{
	//Controls the camera shaking caused by turbulence 
	
	level endon ("startsecondhalf");
	
	nGlider.animname = ("glider");
	
	while(1)
	{
		earthquake(0.1, 8, level.player.origin, 100000000); // scale duration source radius
		//nGlider setFlaggedAnimRestart("animdone", level.scr_anim[nGlider.animname]["gliderlowturb"], 1.0);
		wait randomfloat(3);
		wait 3;
		earthquake(0.07, 5, level.player.origin, 100000000); // scale duration source radius
		//nGlider setFlaggedAnimRestart("animdone", level.scr_anim[nGlider.animname]["gliderlowturb"], 1.0);
		wait randomfloat(4);
		wait 1;
		earthquake(0.12, 4, level.player.origin, 100000000); // scale duration source radius
		//nGlider setFlaggedAnimRestart("animdone", level.scr_anim[nGlider.animname]["gliderlowturb"], 1.0);
		wait randomfloat(2);
		earthquake(0.09, 6, level.player.origin, 100000000); // scale duration source radius
		//nGlider setFlaggedAnimRestart("animdone", level.scr_anim[nGlider.animname]["gliderhighturb"], 1.0);
		wait randomfloat(2);
	}
}

glider_speech(nGlider)
{
	wait 0.5;
	//maps\_utility::playSoundinSpace("pegnight_glider1", nGlider.origin);
	wait 18;
	maps\_utility::playSoundinSpace("pegnight_glider2", nGlider.origin);
	wait 0.3;
	maps\_utility::playSoundinSpace("pegnight_glider3", nGlider.origin);
	wait 0.3;
	maps\_utility::playSoundinSpace("pegnight_glider4", nGlider.origin);
	wait 0.2;
	maps\_utility::playSoundinSpace("pegnight_glider5", nGlider.origin);
	wait 1;
	maps\_utility::playSoundinSpace("pegnight_glider6", nGlider.origin);
	wait 6;
	
	level waittill ("start the landing sequence");
	
	//maps\_utility::playSoundinSpace("pegnight_glider7", nGlider.origin);
	wait 6;
	
	maps\_utility::playSoundinSpace("pegnight_glider8", nGlider.origin);
	wait 0.9;
	maps\_utility::playSoundinSpace("pegnight_glider9", nGlider.origin);
	
}

glider_navigation(nGlider)
{
	//Timing assist based on nodes along the flight path
	
	nGliderLandingNode = getVehicleNode("auto570", "targetname");
	
	nGlider setWaitNode(nGliderLandingNode);
	nGlider waittill("reached_wait_node");
	
	println("Turning to starboard 2 degrees");
	
	nGliderLandingNode = getVehicleNode("auto565", "targetname");
	
	nGlider setWaitNode(nGliderLandingNode);
	nGlider waittill("reached_wait_node");
	
	level notify ("start the landing sequence");
}

glider_crash_sequence()
{	
	//Controls the camera shaking during the touchdown portion
	
	level waittill ("start the landing sequence");
	
	level notify ("startsecondhalf");
	
	//2nd half anim starts right here!
	wait 7.6; 
	println("+++++++++Touchdown+++++++++++");
	earthquake(0.6, 2.5, level.player.origin, 100000000); // scale duration source radius
	wait 4;
	println("+++++++++Touchdown again+++++++++++");
	earthquake(0.35, 15, level.player.origin, 100000000); // scale duration source radius
	wait 7;
	earthquake(0.5, 4, level.player.origin, 100000000); // scale duration source radius
	wait 2;
	earthquake(0.6, 3, level.player.origin, 100000000); // scale duration source radius
	wait 1;
	println("+++++++++Anim ends, Blackout here+++++++++++");
}

glider_flight_start(nGlider)
{
	//Controls the basic flight path of the glider
	
	nFlightStartNode = getvehiclenode("flight_start", "targetname");

	nGlider attachPath(nFlightStartNode);
	
	level waittill ("glidercrashflight");
	
	nGlider startPath();
}

label_tag(tag)
{
	for(;;)
	{
		label_origin = self gettagorigin (tag);
		print3d (label_origin, tag, (1,1,1), 1, 0.15);	// origin, text, RGB, alpha, scale
		wait 0.05;
	}
}

bones()
{
	nGlider = getent("glider_interior", "targetname");

	/*
	nGlider thread label_tag("origin");
	nGlider thread label_tag("glider dummy");
	nGlider thread label_tag("Camera_rotation dummy");
	nGlider thread label_tag("Co-pilot steering dummy");
	nGlider thread label_tag("Glider");
	nGlider thread label_tag("Pilot steering dummy");
	*/
	
	nGlider thread label_tag("tag_guy01");
	nGlider thread label_tag("tag_guy02");
	nGlider thread label_tag("tag_guy03");
	nGlider thread label_tag("tag_guy04");
	nGlider thread label_tag("tag_guy05");
	nGlider thread label_tag("tag_guy06");
	nGlider thread label_tag("tag_guy07");
	nGlider thread label_tag("tag_guy08");
	nGlider thread label_tag("tag_guy09");
	nGlider thread label_tag("tag_guy10");
	nGlider thread label_tag("tag_guy11");
	nGlider thread label_tag("tag_guy12");
	
	/*
	nGlider thread label_tag("Camera_position dummy");
	nGlider thread label_tag("Co-pilot steering");
	nGlider thread label_tag("Parachute release");
	nGlider thread label_tag("Pilot steering");
	
	nGlider thread label_tag("TAG_CAMERA");
	*/
}

/*
BONE 0 -1 "origin"
BONE 1 0 "glider dummy"
BONE 2 1 "Camera_rotation dummy"
BONE 3 1 "Co-pilot steering dummy"
BONE 4 1 "Glider"
BONE 5 1 "Pilot steering dummy"
BONE 6 1 "tag_guy01"
BONE 7 1 "tag_guy02"
BONE 8 1 "tag_guy03"
BONE 9 1 "tag_guy04"
BONE 10 1 "tag_guy05"
BONE 11 1 "tag_guy06"
BONE 12 1 "tag_guy07"
BONE 13 1 "tag_guy08"
BONE 14 1 "tag_guy09"
BONE 15 1 "tag_guy10"
BONE 16 1 "tag_guy11"
BONE 17 1 "tag_guy12"
BONE 18 2 "Camera_position dummy"
BONE 19 5 "Co-pilot steering"
BONE 20 4 "Parachute release"
BONE 21 5 "Pilot steering"
BONE 22 18 "TAG_CAMERA"
*/

//**********************************************//
//		DIALOGUE UTILITIES		//
//**********************************************//

anim_loop ( guy, anime, tag, ender, node, tag_entity )
{
	maps\_anim::anim_loop ( guy, anime, tag, ender, node, tag_entity );
}

anim_single (guy, anime, tag, node, tag_entity)
{
	maps\_anim::anim_single (guy, anime, tag, node, tag_entity);
}

anim_single_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim::anim_single (newguy, anime, tag, node, tag_entity);
}

anim_reach (guy, anime, tag, node, tag_entity)
{
	maps\_anim::anim_reach (guy, anime, tag, node, tag_entity);
}

anim_teleport_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim::anim_teleport (newguy, anime, tag, node, tag_entity);
}

//*************** NOTES *************//

/*

FIX FIX FIX

- tank mg42 fancy handling against player standing still, favor movement

*/

