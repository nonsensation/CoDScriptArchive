/****************************************************************************

Level: 		Pavlov's House
Campaign: 	Russian
Objectives: 	
		1. Assemble with Sgt. Pavlov's squad.
		2. Eliminate the snipers.
			- Pvt. Kovalenko draws out the snipers, he can't die until the objective is completed
			- Snipers will change target to the player after a few seconds of firing at Kovalenko
		3. Get across the field.
			- trigger detects when player is out of the danger zone of the barrage
		4. Secure all floors of the apartment building.
			- There is a fixed number of defending troops once the player reaches the street which
			have to be eliminated
		5. Regroup with Sgt. Kamarov on the fourth floor.
			- Set the objective point at the top floor
			- run Sgt. Kamarov to a cool overlook point
			- have him tell the player about the anti-tank guns
		6. Hold the building until relieved by friendly units.
			- Timer countdown
			- If the timer hits zero but the enemy tanks aren't dead, the armada of Soviet tanks takes care of them
		7. Clear the area of any remaining enemy forces.
			- When the reinforcements show up and all enemy tanks and soldiers are dead, the level ends

*****************************************************************************/

#using_animtree("generic_human");

main()
{
	//setCullFog(0, 8000, 0.8, 0.8, 0.8, 0);
	setExpFog(0.00015, 0.8, 0.8, 0.8, 0);
	
	precacheString(&"PAVLOV_REINFORCEMENTS_ARRIVING");
	
	maps\_load::main();
	maps\_tank::main();
	maps\_t34::main();
	maps\_panzerIV::main();
	maps\_panzeriv::main_camo();
	maps\pavlov_anim::main();
	maps\pavlov_fx::main();
	maps\_utility::precache("xmodel/vehicle_tank_panzeriv_machinegun");
	maps\_utility::precache("xmodel/head_blane");
	maps\_utility::precache("xmodel/gib_brick");
	
	level.lingerfx = loadfx("fx/smoke/oneshotblacksmokelinger.efx");
	level.fireydeath = loadfx ("fx/fire/pathfinder_extreme.efx");
	
	level.altmortar = loadfx ("fx/impacts/newimps/blast_gen3nomark.efx");
	
	level.nRabbit = getent("rabbit", "targetname");	
	level.nRabbit.animname = "kovalenko";
	level.nKamarov = getent("kamarov", "targetname");
	level.nKamarov.animname = "sgtpavlov";
	
	character\pavlov::precache();
	level.nKamarov character\_utility::new();
	level.nKamarov character\pavlov::main();
	
	character\kovalenko::precache();
	level.nRabbit character\_utility::new();
	level.nRabbit character\kovalenko::main();
	
	//*** Sound
	
	level.ambient_track ["outside"] = "ambient_pavlov_ext";
	level.ambient_track ["inside"] = "ambient_pavlov_int";
	thread maps\_utility::set_ambient("outside");
	
	//Anti Tank Rifles (ATR) positioning setup, hide, then change position
	
	level.atr1 = getent("antitankrifle1", "targetname");
	level.atr2 = getent("antitankrifle2", "targetname");
	level.hidespot = getent("hidespot", "targetname");
	
	//save the atr positions and angles and hiding spot
		
	level.atr1spot = level.atr1.origin;
	level.atr1view = level.atr1.angles;
	
	level.atr2spot = level.atr2.origin;
	level.atr2view = level.atr2.angles;
	
	level.hidespotloc = level.hidespot.origin;
	
	//move the atr rifles to the hiding spot
	
	level.atr1.origin = level.hidespotloc;
	level.atr2.origin = level.hidespotloc;
	
	level.fielddone = 0;
	level.mortar = loadfx ("fx/surfacehits/mortarimpact_snow_nolight2.efx");
	level._effect["treads"]	= loadfx ("fx/tagged/snow4tanktread.efx");	//need this for tread puffs
	
	level.iStopBarrage = 0;	//turns on and turns off the mortars
	
	level.centerreached = 0;	//on off toggle for when the player gets to the broken wall area
	
	level.floorsleft = 6;	//number of floors still active with enemies
	level.floorcount = 6; 	//number of floors in the house
	
	level.teampop = 5;	//number of friendlies including Kamarov, originally 8
	
	level.usingrifle = 0;
	
	if ((getcvar ("start") != "skipintro") && (getcvar ("start") != "skipall"))
	{
		level.stopwatch = 4;	//length of final defense in minutes - 5 default
		level.stopwatchsecs = level.stopwatch * 60;	
	}
	else
	if (getcvar ("start") == "skipall")
	{
		level.stopwatch = 0.2;	//length of final defense in minutes - 5 default
		level.stopwatchsecs = level.stopwatch * 60;	
	}
	else
	{
		level.stopwatch = 0.5;	//length of final defense in minutes - 5 default
		level.stopwatchsecs = level.stopwatch * 60;	
	}
	
	level.fSpawnInterval = 6; //time between wave spawns during final battle
	
	level.tanksdead = 0; 	//switch for enemy tank population at end
	
	level.nTankArray = [];
	
	level.replacementson = 1;	//switch for maintain friendly spawning at start
	
	level.locatorswitch = 0;	//AI flank routing seed
	
	level.shocktime = 7;		//Length of shellshock
	
	level.northfired = 0;		//locking mechanism for allowing only one tank to fire at a time at north
	level.southfired = 0;		//locking mechanism for allowing only one tank to fire at a time at south
	
	level.fourthfloormortartime = 15;	//time between checks to see if player is hiding on the fourth floor
	
	level.upperfloorshocktime = 10; 	//duration of shellshock caused by roof blasts
	
	level.nDefensePractice = 1;		//sets different properties on initial AI attacks
	
	if (getcvarint("g_gameskill") == 0)
	{
		level.practiceGracePeriod = 12;
		level.realGracePeriod = 8;
		level.counterattack_ai_accuracy = 0.05;
		level.friendly_defense_health = 1500;
		level.Pavlov_defense_health = 2000;
		level.defense_enemy_practice_total = 9;
		level.defense_enemy_total = 12;
	}
	
	if (getcvarint("g_gameskill") == 1)
	{
		level.practiceGracePeriod = 6;
		level.realGracePeriod = 4;
		level.counterattack_ai_accuracy = 0.2;
		level.friendly_defense_health = 900;
		level.Pavlov_defense_health = 1200;
		level.defense_enemy_practice_total = 11;
		level.defense_enemy_total = 16;
	}
	
	if (getcvarint("g_gameskill") == 2)
	{
		level.practiceGracePeriod = 5;
		level.realGracePeriod = 4;
		level.counterattack_ai_accuracy = 0.5;
		level.friendly_defense_health = 700;
		level.Pavlov_defense_health = 1000;
		level.defense_enemy_practice_total = 12;
		level.defense_enemy_total = 17;
	}
	
	if (getcvarint("g_gameskill") == 3)
	{
		level.practiceGracePeriod = 4;
		level.realGracePeriod = 4;
		level.counterattack_ai_accuracy = 0.7;
		level.friendly_defense_health = 400;
		level.Pavlov_defense_health = 500;
		level.defense_enemy_practice_total = 12;
		level.defense_enemy_total = 17;
	}
	
	//Floor IDs denoting cleared floors
	
	level.nFloorID_0 = 0;
	level.nFloorID_1 = 0;
	level.nFloorID_2 = 0;
	level.nFloorID_3 = 0;
	level.nFloorID_4 = 0;
	level.nFloorID_5 = 0;
	
	level.scr_sound ["pavlov_randomantitank"] = "pavlov_randomantitank";
	level.scr_sound ["pavlov_randomguns"] = "pavlov_randomguns";
	level.scr_sound ["pavlov_randomready0"] = "pavlov_randomready0";
	level.scr_sound ["pavlov_randomready1"] = "pavlov_randomready1";
	level.scr_sound ["pavlov_randomready2"] = "pavlov_randomready2";
	
	level.strAlpha = "alpha";
	level.strBeta = "beta";
	level.strGamma = "gamma";
	level.strDelta = "delta";
	level.strEpsilon = "epsilon";
	level.strZeta = "zeta";
	level.strEta = "eta";
	
	if (getcvar ("start") != "tanksonly")
	{	
		thread field_sniper_setup();
		thread intro_friendly_setup();
		thread intro();
		thread objectives();
		thread field_sniper_rushtest();
		
		thread ai_overrides();
		thread house_floor_tally();
		
		thread tank_sort();
		thread intro_ditch_stance_check();
		
		thread bomberflight();
		
		thread carpetbombing();
		
		thread house_cleared_failsafe();
	}
	else
	{
		level.tanksdead = 1;
		
		thread tank_sort();
		wait 1;
		level notify ("friendly tank assault");
	}
	
	getent("plane", "targetname") delete();	
}

intro_friendly_setup()
{
	level.nKamarov.suppressionwait = 0;
	level.nKamarov.pacifist = true;
	//level.nKamarov.maxsightdistsqrd = 25;
	level.nKamarov thread maps\_utility::magic_bullet_shield();
	level.nKamarov.script_usemg42 = 0;
	level.nKamarov.ignoreme = 1;
	
	level.nRabbit.suppressionwait = 0;
	level.nRabbit.dontavoidplayer = true;
	//level.nRabbit.maxsightdistsqrd = 25;
	level.nRabbit.pacifist = true;
	level.nRabbit thread maps\_utility::magic_bullet_shield();
	level.nRabbit allowedstances("crouch");
	//level.nRabbit.run_combatanim = %sprint1_loop;
	
	aFriendlies = getaiarray("allies");
	for(i=0; i<aFriendlies.size; i++)
	{
		if(isdefined(aFriendlies[i].script_commonname) && (aFriendlies[i].script_commonname == "friendly_ditch"))
		{
			//aFriendlies[i] allowedstances("prone");	
			aFriendlies[i].ignoreme = 1;
			aFriendlies[i].script_usemg42 = 0;
			//aFriendlies[i].maxsightdistsqrd = 25;
			aFriendlies[i].dontavoidplayer = true;
			aFriendlies[i].goalradius = 16;
			aFriendlies[i].pacifist = 1;
			aFriendlies[i].interval = 8;
		}
	}
	
	wait 0.1;
	
	for(i=0; i<aFriendlies.size; i++)
	{
		if(isdefined(aFriendlies[i].script_commonname) && (aFriendlies[i].script_commonname == "friendly_ditch"))
		{
			aFriendlies[i] allowedstances("prone");	
		}
	}
}

intro()
{	
	level.nKamarov.dontavoidplayer = true;
	level.nKamarov animscripts\shared::LookAtEntity(level.player, 6, "alert");
		
	nStartTalker = getent("startpavlovtalk", "targetname");
	nStartBlocker = getent("startpavlovblocker", "targetname");
	nIntroNode = getnode("intro_pavlov_dest", "targetname");
		
	nStartTalker waittill ("trigger");
		
	musicplay("pf_stealth");
		
		//DIALOG - Sgt. Pavlov - Stay in the ditch and keep your head down, Comrade! The Germans have snipers out there!
	
	if ((getcvar ("start") != "skipintro") && (getcvar ("start") != "skipsnipers") && (getcvar ("start") != "skipall"))
	{	
		level.nKamarov anim_single_solo(level.nKamarov, "stayinditch");
	}
	
	level.nKamarov setgoalnode(nIntroNode);
	level.nKamarov allowedstances("crouch");
	level.nKamarov.goalradius = 16;
	
	wait 0.5;
	nStartBlocker delete();
	
	level.nKamarov waittill("goal");
	
	//Wait for player to get close enough
	
	nPlayerProx = length(level.nRabbit.origin - level.player.origin);
	
	while(nPlayerProx > 192)
	{
		wait 0.25;
		nPlayerProx = length(level.nRabbit.origin - level.player.origin);
	}
	
	level.nKamarov animscripts\shared::LookAtEntity(level.nRabbit, 6, "alert");
	level.nRabbit animscripts\shared::LookAtEntity(level.nKamarov, 6, "alert");

	if ((getcvar ("start") != "skipintro") && (getcvar ("start") != "skipsnipers") && (getcvar ("start") != "skipall"))
	{	
		//DIALOG - Sgt. Pavlov - Private Kovalenko, as the fastest man here, you will be the bait.
		
		level.nKamarov anim_single_solo(level.nKamarov, "bethebait");
		
		//DIALOG - Sgt. Pavlov - Private Kovalenko, as the fastest man here, you will be the bait.
		
		level.nRabbit animscripts\shared::LookAtEntity(level.nKamarov, 3, "alert");
		level.nRabbit anim_single_solo(level.nRabbit, "nothanks");
		
		//DIALOG - Sgt. Pavlov - Private Kovalenko, as the fastest man here, you will be the bait.
		
		level.nKamarov animscripts\shared::LookAtEntity(level.nRabbit, 6, "alert");
		level.nKamarov anim_single_solo(level.nKamarov, "thatsanorder");
	}
	
	level notify ("objective2");
	
	if ((getcvar ("start") != "skipall") && (getcvar ("start") != "skipsnipers"))
	{
		thread field_dash();
	}
	else
	{
		thread field_dash_skip();
	}
}

intro_ditch_stance_check()
{
	//Checks to see if player is standing in the ditch and fires a magicbullet
	//If the player is in the other trigger on the high part of the ditch he gets shot at regardless of stance
	
	level.player endon("death");
	
	nStanceTrig = getent("stancetrigger", "targetname");
	nStanceTrigExposed = getent("stancetrigger_exposed", "targetname");
	nShotSound = getent("autokillsound", "targetname");
	
	while(!level.fielddone)
	{
		if(level.player istouching(nStanceTrig))
		{
			if(level.player getstance() != "prone" && level.player getstance() != "crouch")
			{
				//warning shot at player
				
				magicbullet ("kar98k_pavlovsniper", nShotSound.origin, level.player.origin + (16, 16, 1072));
				wait 0.15;
				
				//whizby
				
				thread maps\_utility::playSoundinSpace("whizby", level.player.origin);
				
				wait 2.5;	//simulated rechamber time
				
				if(level.player getstance() != "prone" && level.player getstance() != "crouch")	
				{
					//next shot hits player
				
					dmgFrac = 0.5;
					dmg = level.player.maxhealth * dmgFrac;
					magicbullet ("kar98k_pavlovsniper", nShotSound.origin, level.player.origin);
					wait 0.15;
					level.player doDamage (dmg, (nShotSound.origin));
					wait 2.5;	//simulated rechamber time	
				}
			}
		}
		else
		if(level.player istouching(nStanceTrigExposed))
		{
			magicbullet ("kar98k_pavlovsniper", nShotSound.origin, level.player.origin + (16, 16, 1072));
			wait 0.15;
				
			//whizby
				
			thread maps\_utility::playSoundinSpace("whizby", level.player.origin);
			
			wait 2.5;	//simulated rechamber time
				
			//next shot hits player
			
			if(level.player istouching(nStanceTrigExposed))
			{
				dmgFrac = 0.5;
				dmg = level.player.maxhealth * dmgFrac;
				magicbullet ("kar98k_pavlovsniper", nShotSound.origin, level.player.origin);
				wait 0.15;
				level.player doDamage (dmg, nShotSound.origin);
				wait 2.5;	//simulated rechamber time	
			}
		}
		
		wait 0.1;
	}
}

field_sniper_rushtest()
{
	nSniperRushTrig = getent("sniperrush","targetname");
	while(level.fielddone != 1)
	{
		if(level.player istouching(nSniperRushTrig))
		{
			//println("Player is out of safe zone");
			//nShotSound = spawn ("script_origin", level.player.origin + (0, randomintrange(800,900), 1200));
			//nShotSound = spawn ("script_origin", level.player.origin + (0, 3000, 1200));
			//nShotSound playsound("weap_kar98k_fire");
			nShotSound = getent("autokillsound", "targetname");
			//thread maps\_utility::playSoundinSpace("pavlov_kar98ksniper", (-9474, 10089, 697));
			//nShotSound playsound("pavlov_kar98ksniper");
			wait 0.2;
			magicbullet ("kar98k_pavlovsniper", nShotSound.origin, level.player.origin);
			wait 0.1;
			level.player doDamage (level.player.health + 10050, nShotSound.origin);
			break;
		}
		wait 0.1;
	}
}

field_sniper_setup()
{
	//script_commonname: pavlovsniper
	//script_namenumber: sniper#
	
	level.aSnipers = [];
	
	aSpawners = getspawnerarray();
	for(i=0; i<aSpawners.size; i++)
	{
		if(isdefined(aSpawners[i].script_commonname) && aSpawners[i].script_commonname == "pavlovsniper")
		{
			//level.aSnipers = maps\_utility::add_to_array(level.aSnipers, aSpawners[i]);
			level.aSnipers[level.aSnipers.size] = aSpawners[i];
		}
	}
	
	level.aSnipersCount = level.aSnipers.size;
	
	//level.aSnipers = maps\_utility::array_randomize(level.aSnipers);
}

field_dash_skip()
{
	//German artillery starts landing and works its way up to kill the player if the player doesn't keep moving up
			
	thread field_artillery();
	
	//Player is cleared to rush
	
	level.fielddone = 1;
	
	//Check for player to reach the wall and complete the objective
	
	thread field_crosscheck();
	
	wait 1;
	
	//DIALOG - Sgt. Pavlov - They've got us zeroed in! We're all dead if we stay here! Let's go comrades! Go! Get moving! All of you, go!
	
	level.nKamarov thread anim_single_solo(level.nKamarov, "zeroedin");
	
	wait 2;
	
	level.nRabbit notify ("stop magic bullet shield");
	level.nRabbit.health = 150;
	
	//Friendlies dash en masse to the broken wall
	
	thread field_friendly_crossing();
}

field_dash()
{
	nDashNode = getnode("dashstart","targetname");
	level.nRabbit.goalradius = 96;
	level.nRabbit.animplaybackrate = 1.2;
	level.nRabbit.pacifist = true;
	
	
	level.nRabbit thread animscripts\shared::SetInCombat(15000);
	
	thread field_sniper();
	thread field_sync();
	
	while(1)
	{
		level.nRabbit allowedstances("stand");
		level.dashreached = 0;
		level.nRabbit setgoalnode(nDashNode);
		level.nRabbit.threatbias = 1000000000;
		level.nRabbit waittill("goal");
		
		if(isdefined(nDashNode.script_commonname) && nDashNode.script_commonname == "dashpause")
		{
			//println("---- KOVALENKO REACHED GOAL -----");
			
			level.nRabbit allowedstances("crouch");
			
			level.dashreached = 1;
			
			if(level.sniperdead != 1)
			{
				//println("kovalenko cowers");
			}
			
			level.nRabbit allowedstances("crouch");
			
			wait 4;
			
			level notify("sniper_switchtarget");
			
			//Sniper must be dead
			
			while(level.sniperdead != 1)
			{
				wait 0.1;
			}
			
			level notify("dashsync");
			level waittill ("sync");
		}
		else
		if(isdefined(nDashNode.script_commonname) && nDashNode.script_commonname == "dashend")
		{
			//println("---- KOVALENKO REACHED END -----");
			
			level.dashreached = 1;
			
			level.nRabbit.threatbias = 0;
			
			if(level.sniperdead != 1)
			{
				//println("kovalenko cowers");
			}
			
			level.nRabbit allowedstances("crouch");
			level notify("sniper_switchtarget");
			
			while(level.sniperdead != 1)
			{
				wait 0.1;
			}
			
			//German artillery starts landing and works its way up to kill the player if the player doesn't keep moving up
			
			thread field_artillery();
			
			//Player is cleared to rush
			
			level.fielddone = 1;
			
			//Check for player to reach the wall and complete the objective
			
			thread field_crosscheck();
			
			wait 1;
			
			//DIALOG - Sgt. Pavlov - They've got us zeroed in! We're all dead if we stay here! Let's go comrades! Go! Get moving! All of you, go!
			
			level.nKamarov thread anim_single_solo(level.nKamarov, "zeroedin");
			
			level.player.ignoreme = 0;
			
			wait 2;
			
			level.nRabbit notify ("stop magic bullet shield");
			level.nRabbit.health = 150;
			
			//Friendlies dash en masse to the broken wall
			
			thread field_friendly_crossing();
			
			break;
		}
		
		if(isdefined(nDashNode.target))
		{
			nDashNode = getnode(nDashNode.target, "targetname");
		}
	}
}

field_sniper_stance(nSniper)
{
	nSniper endon ("death");
	wait 0.25;
	if(isalive(nSniper))
	{
		nSniper allowedstances ("stand");
	}
}

field_sniper()
{	
	//println("Asnipers = ", level.aSnipers.size);
	
	aSniperNodes = getnodearray("snipernode","targetname");
	
	level.aSnipers = maps\_utility::array_randomize(level.aSnipers);
	
	for(k=0; k<level.aSnipers.size; k++)
	{
		level.aSnipers[k].script_moveoverride = 1;
		nSniper = level.aSnipers[k] dospawn();
		level thread field_sniper_stance(nSniper);
		
		if(isdefined(nSniper))
		{
			//println("Sniper default goalradius = ", nSniper.goalradius);
			level.sniperdead = 0;
			level thread field_sniper_targeting(nSniper);
			
			for(i=0; i<aSniperNodes.size; i++)
			{
				//Match sniper to his node, send off
				
				if(isdefined(aSniperNodes[i].script_namenumber) && isdefined(nSniper.script_namenumber) && aSniperNodes[i].script_namenumber == nSniper.script_namenumber)
				{
					//println("Sniper activated");
					nSniper.goalradius = 8;
					nSniper.ignoreme = 1;
					nSniper.walkdist = 0;
					//println("Sniper goalradius = ", nSniper.goalradius);
					nSniper allowedstances ("stand");
					nSniper.suppressionwait = 0;
					//println("Sniper suppwait = ", nSniper.suppressionwait);
					nSniper setgoalnode(aSniperNodes[i]);
					//nSniper.accuracy = 1;
					//println("Sniper accuracy = ", nSniper.accuracy);
					
					thread field_sniper_faketarget(nSniper);
				
					//nSniper.favoriteenemy = level.nRabbit;
					//println("Sniper fav enemy = ", nSniper.favoriteenemy);
					nSniper.ignoreme = 1;
					level.player.ignoreme = 1;
					
					nSniper waittill("death");
					level.sniperdead = 1;
					
					level.aSnipersCount--;
					level notify ("sniper down");
					
					//Rabbit must have reached his pause point
					
					while(level.dashreached != 1)
					{
						wait 0.1;
					}
					
					level notify("snipersync");
					level waittill ("sync");
					
					break;
				}
			}
		}
	}
}

field_sniper_faketarget(nSniper)
{
	nSniper endon("death");
	level endon("sniper_switchtarget");
	
	nSniper waittill("goal");
	
	level.nRabbit.ignoreme = 1;
	
	while(1)
	{
		println("SNIPER ACCURACY IS ", nSniper.accuracy);
		
		nFakeTarget = spawn("script_origin", level.nRabbit.origin + (32, 32, 128));
		if(isalive(nSniper))
		{
			nSniper animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
			nSniper.customtarget = (nFakeTarget);
			nSniper.accuracy = 1000;
		}
		
		wait 1;
		
		if(isalive(nSniper))
		{
			nSniper notify ("end_sequence");
		}
		nFakeTarget delete();
		wait 1;
	}
}

field_sniper_targeting(nSniper)
{
	nSniper endon("death");
	
	level waittill("sniper_switchtarget");
	
	wait 1;
	
	if(isalive(nSniper))
	{
		nSniper notify ("end_sequence");
		nSniper.team = "axis";
		nSniper.accuracy = 1000;
		nSniper.favoriteenemy = level.player;
	}
	level.player.ignoreme = 0;
	
	println("***** SNIPER CHANGING TO TARGET PLAYER *****");
}

field_sync()
{
	while(1)
	{
		level.sync = 0;
		
		thread field_dash_sync();
		thread field_sniper_sync();
		
		while(level.sync != 2)
		{
			wait 0.1;
		}
		
		//Rabbit has reached pause point and sniper for that stretch is dead
		
		level notify("sync");
		
		if(level.fielddone == 1)
		{
			break;
		}
	}
}

field_dash_sync()
{
	//Rabbit must reach pause point
	level waittill("dashsync");
	level.sync++;
}

field_sniper_sync()
{
	//Sniper must die
	level waittill("snipersync");
	level.sync++;
}

field_friendly_crossing()
{
	chain = maps\_utility::get_friendly_chain_node ("brokenwall");
	level.player SetFriendlyChain (chain);
			
	aFriendlies = getaiarray("allies");
	for(i=0; i<aFriendlies.size; i++)
	{
		aFriendlies[i] thread animscripts\shared::SetInCombat(120);
		
		if(isdefined(aFriendlies[i].targetname) && aFriendlies[i].targetname == "kamarov")
		{
			aFriendlies[i] allowedstances ("stand", "crouch");
			aFriendlies[i] setgoalentity(level.player);
			aFriendlies[i].goalradius = 16;
			//aFriendlies[i].maxsightdistsqrd = 100000000000;
			aFriendlies[i].dontavoidplayer = 0; 
			aFriendlies[i].suppressionwait = 1;
			aFriendlies[i].pacifist = false;
			aFriendlies[i].accuracy = 0.8;
			continue;
		}
		else
		{
			level thread field_startrun(aFriendlies[i]);
			aFriendlies[i] allowedstances ("stand", "crouch");
			aFriendlies[i].ignoreme = 0;
			//aFriendlies[i] setgoalentity(level.player);
			aFriendlies[i].dontavoidplayer = 0; 
			aFriendlies[i].goalradius = 16;
			//aFriendlies[i].maxsightdistsqrd = 100000000000;
			aFriendlies[i].suppressionwait = 1;
			aFriendlies[i].animplaybackrate = 1.1;
			aFriendlies[i].health = 250;
			aFriendlies[i].pacifist = false;
			aFriendlies[i].accuracy = 0.7;
		}
	}
}

field_startrun(nSoldier)
{
	nSoldier endon ("death");
	wait randomfloat(0.5);
	if(isalive(nSoldier))
	{
		nSoldier setgoalentity(level.player);
	}
}

field_artillery()
{
	//script_commonname: fieldmortar1 to 5
	//get all common script_commonname fieldmortars (script_origin) into its own sector array, getentarray off script_noteworthy
	//run each one through railyard_style, give targetname 'mortar' on the fly, time gaps between sectors, player has to run 
	//make targetname undefined as soon as they are used by railyard_style to keep sectors independent
	//stop a little bit after player has dropped down into the central region
	//kill the player if he is inside an active sector for more than a certain amount of time
	
	aFieldMortar1 = [];
	aFieldMortar2 = [];
	aFieldMortar3 = [];
	aFieldMortar4 = [];
	aFieldMortar5 = [];
	
	aMortarHits = getentarray("mortarhit", "script_noteworthy");
	for(i=0; i<aMortarHits.size; i++)
	{
		if(isdefined(aMortarHits[i].script_commonname) && aMortarHits[i].script_commonname == "fieldmortar1")
		{
			//aFieldMortar1 = maps\_utility::add_to_array(aFieldMortar1, aMortarHits[i]);
			aFieldMortar1[aFieldMortar1.size] = aMortarHits[i];
		}
		if(isdefined(aMortarHits[i].script_commonname) && aMortarHits[i].script_commonname == "fieldmortar2")
		{
			//aFieldMortar2 = maps\_utility::add_to_array(aFieldMortar2, aMortarHits[i]);
			aFieldMortar2[aFieldMortar2.size] = aMortarHits[i];
		}
		if(isdefined(aMortarHits[i].script_commonname) && aMortarHits[i].script_commonname == "fieldmortar3")
		{
			//aFieldMortar3 = maps\_utility::add_to_array(aFieldMortar3, aMortarHits[i]);
			aFieldMortar3[aFieldMortar3.size] = aMortarHits[i];
		}
		if(isdefined(aMortarHits[i].script_commonname) && aMortarHits[i].script_commonname == "fieldmortar4")
		{
			//aFieldMortar4 = maps\_utility::add_to_array(aFieldMortar4, aMortarHits[i]);
			aFieldMortar4[aFieldMortar4.size] = aMortarHits[i];
		}
		if(isdefined(aMortarHits[i].script_commonname) && aMortarHits[i].script_commonname == "fieldmortar5")
		{
			//aFieldMortar5 = maps\_utility::add_to_array(aFieldMortar5, aMortarHits[i]);
			aFieldMortar5[aFieldMortar5.size] = aMortarHits[i];
		}
	}
	
	level notify ("launch the bombers");
	
	thread field_bombingop(aFieldMortar1, aFieldMortar2, aFieldMortar3, aFieldMortar4, aFieldMortar5);
	
	thread field_artillery_sector(aFieldMortar1);
	wait 7;
	thread field_artillery_sector(aFieldMortar2);
	wait 7;
	thread field_artillery_sector(aFieldMortar3);
	wait 6;
	thread field_artillery_playerkill(aFieldMortar3);
	thread field_artillery_sector(aFieldMortar4);
	wait 4;
	thread field_artillery_playerkill(aFieldMortar4);
	thread field_artillery_sector(aFieldMortar5);
	wait 3;
	thread field_artillery_playerkill(aFieldMortar5);
	//println("main barrage stops");
	
	level.iStopBarrage = 1;
	level.centerreached = 1;
	
	/*
	wait 1;
	level.iStopBarrage = 0;
	level.centerreached = 1;
	wait 0.5;
	level.centerreached = 0;
	//println("secondary barrage 1");
	thread field_artillery_sector(aFieldMortar4);
	wait 2;
	thread field_artillery_playerkill(aFieldMortar4);
	level.iStopBarrage = 1;
	wait 1;
	level.iStopBarrage = 0;
	level.centerreached = 1;
	wait 0.5;
	level.centerreached = 0;
	//println("secondary barrage 2");
	thread field_artillery_sector(aFieldMortar2);
	wait 4;
	level.iStopBarrage = 1;
	wait 1;
	level.iStopBarrage = 0;
	level.centerreached = 1;
	wait 0.5;
	level.centerreached = 0;
	//println("secondary barrage 3");
	thread field_artillery_sector(aFieldMortar3);
	wait 3;
	thread field_artillery_playerkill(aFieldMortar3);
	wait 5;
	level.iStopBarrage = 1;
	level.centerreached = 1;
	//println("field barrage has ended");
	*/
	thread replacement_spawn();
}

field_bombingop(aFieldMortar1, aFieldMortar2, aFieldMortar3, aFieldMortar4, aFieldMortar5)
{
	wait 30;
	
	thread field_artillery_sector(aFieldMortar1, 1);
	wait 0.5;
	
	level.iStopBarrage = 1;
	wait 0.05;
	level.iStopBarrage = 0;
	level.centerreached = 1;
	wait 0.05;
	level.centerreached = 0;
	
	thread field_artillery_sector(aFieldMortar2, 1);
	wait 0.5;
	
	level.iStopBarrage = 1;
	wait 0.05;
	level.iStopBarrage = 0;
	level.centerreached = 1;
	wait 0.05;
	level.centerreached = 0;
	
	thread field_artillery_sector(aFieldMortar3, 1);
	wait 0.5;
	thread field_artillery_playerkill(aFieldMortar3);
	wait 0.5;
	
	level.iStopBarrage = 1;
	wait 0.05;
	level.iStopBarrage = 0;
	level.centerreached = 1;
	wait 0.05;
	level.centerreached = 0;
	
	thread field_artillery_sector(aFieldMortar4, 1);
	wait 0.5;
	thread field_artillery_playerkill(aFieldMortar4);
	wait 0.5;
	
	level.iStopBarrage = 1;
	wait 0.05;
	level.iStopBarrage = 0;
	level.centerreached = 1;
	wait 0.05;
	level.centerreached = 0;
	
	thread field_artillery_sector(aFieldMortar5, 1);
	wait 0.5;
	thread field_artillery_playerkill(aFieldMortar5);
	wait 0.5;
	
	level.iStopBarrage = 1;
	level.centerreached = 1;
}

field_artillery_sector(aHits, bomblet)
{	
	for(i=0; i<aHits.size; i++)
	{
		aHits[i].targetname = "mortar";
		wait 0.05;
	}
	
	//railyard_style(fRandomtime, iMaxRange, iMinRange, iBlastRadius, iDamageMax, iDamageMin, fQuakepower, iQuaketime, iQuakeradius, targetsUsed, seedtime)
	if(!isdefined(bomblet))
	{
		thread maps\_mortar::railyard_style(0.14, 8000, 100, 256, 900, 150, 0.18, 2, 4250, undefined, 0.4);
	}
	else
	{
		//thread maps\_mortar::railyard_style(0.0654, 8000, 100, 256, 900, 150, 0.18, 2, 4250);
		thread maps\_mortar::railyard_style(0.3, 8000, 100, 256, 900, 150, 0.18, 2, 4250);
	}
	
	wait 0.1;
	
	for(i=0; i<aHits.size; i++)
	{
		aHits[i].targetname = "nothing";
		wait 0.05;
	}
}

field_artillery_playerkill(aMortars)
{
	aFieldKillTriggers = getentarray("fieldkillzone", "script_noteworthy");
	for(i=0; i<aFieldKillTriggers.size; i++)
	{
		if(isdefined(aFieldKillTriggers[i].script_commonname) && aFieldKillTriggers[i].script_commonname == aMortars[i].script_commonname)
		{
			while(level.centerreached == 0)
			{
				if(level.player istouching(aFieldKillTriggers[i]))
				{
					level.player playsound ("mortar_incoming1");
		
					origin = (level.player getorigin() + (0,8,2));
					range = 420;
					maxdamage = 1000; 
					mindamage = 100;
					
					wait 0.7;
				
					level.player thread maps\_mortar::mortar_sound();
					playfx (level.mortar, level.player.origin);
					radiusDamage(level.player.origin, range, maxdamage, mindamage);
					println("damaged player");
					level.player doDamage (level.player.health + 10050, (0,0,0));
					earthquake(0.75, 2, origin, 2250);
					break;
				}
				
				wait 0.05;
			}
		}
	}
}

field_crosscheck()
{
	nFieldCrossTrig = getent("wallreached","targetname");
	nFieldCrossTrig waittill("trigger");
	
	level notify("objective4");
	
	wait 2;
	
	thread center_stats();
	thread road_crossing();
}

center_stats()
{
	level.player.threatbias = 100000;
}

road_crossing()
{
	level endon ("entering house");
	
	wait 8;
	
	aEnemies = [];
	aEnemies = getaiarray("axis");
	
	nClear = 0;
	
	while(!nClear)
	{
		while(aEnemies.size > 5)
		{
			wait 0.05;
			aEnemies = undefined;
			aEnemies = [];
			aEnemies = getaiarray("axis");
		}
		
		aEnemies = [];
		aEnemies = getaiarray("axis");
		
		for(i=0; i<aEnemies.size; i++)
		{
			if(!(isdefined(aEnemies[i].script_mg42)))
			{
				//println("starting the road crossing");
				nClear = 1;
			}
		}
		
		wait 0.1;
	}

	level.nKamarov thread anim_single_solo(level.nKamarov, "clearitout");
	
	chain = maps\_utility::get_friendly_chain_node ("chain_south1");
	level.player SetFriendlyChain (chain);
	
	maps\_utility::autosave(3);
}

replacement_spawn()
{
	//level endon("objective5");
	
	level.nReplacer = getent("replacement_spawner", "targetname");
	
	while(level.replacementson == 1)
	{
		aFriendlies = getaiarray("allies");
		k = aFriendlies.size;
		
		for(x=0; x<k; x++)
		{
			if(!(isalive(aFriendlies[x])) || !(isdefined(aFriendlies[x]))) 
			{
				aFriendlies = maps\_utility::subtract_from_array(aFriendlies, aFriendlies[x]);	
			}
		}
		/*
		for(i=0; i<aFriendlies.size; i++)
		{
			level thread replacement_deathwaiter(aFriendlies[i]);
		}
		*/
		if(aFriendlies.size < level.teampop)
		{
			aAxis = getaiarray("axis");
			aAllies = getaiarray("allies");
			nPopulation = aAxis.size + aAllies.size;
			
			//println("There are ", aFriendlies.size, " friendlies at this point.");
			//println("There can be a total of ", level.teampop, " friendlies.");
			//println("There are currently ", nPopulation, " AI in the level.");
			
			n = level.teampop - aFriendlies.size;
			//println("The difference is ", n);
			
			for(i=0; i<n; i++)
			{
				nReplacement = level.nReplacer dospawn();
				if(isdefined(nReplacement))
				{
					//println("Spawned 1 replacement");
					//level thread replacement_deathwaiter(nReplacement);
					level thread replacement_settings(nReplacement);	
					level.nReplacer.count = 50;
				}
				else
				{
					//println("Can't spawn for some reason.");
				}
				wait 3.5;
			}
		}
		
		wait 4;
	}
}

replacement_settings(nSoldier)
{
	nSoldier endon ("death");
	
	level endon("objective5");
	wait 0.05;
	if(isdefined(nSoldier) && isalive(nSoldier))
	{
		if(isalive(nSoldier))
		{
			nSoldier setgoalentity(level.player);
			nSoldier.followmin = -6;
			nSoldier.followmax = 6;
			nSoldier.script_usemg42 = 0;
			nSoldier.ignoreme = 1;
			nSoldier.dontavoidplayer = 0;
			nSoldier.suppressionwait = 0.5;
			nSoldier allowedstances ("stand", "crouch");
		}
		
		wait 20;
		if(isalive(nSoldier))
		{
			nSoldier.ignoreme = 0;
			nSoldier.accuracy = 0.5;
		}
	}
}

ai_overrides()
{
	spawners = getspawnerteamarray("axis");
	for (i=0;i<spawners.size;i++)
	{
		spawners[i] thread spawner_overrides();
	}
}

spawner_overrides()
{
	level endon ("kill override");
	
	while (1)
	{
		self waittill ("spawned", spawned);
		wait 0.05;
		if (isdefined(spawned) && isalive(spawned))
		{
			spawned.suppressionwait = 0;
			spawned.interval = 0;
		}
	}
}

defense_ai_overrides()
{
	spawners = getspawnerteamarray("axis");
	for (i=0;i<spawners.size;i++)
	{
		spawners[i] thread defense_spawner_overrides();
	}
}

defense_spawner_overrides()
{
	level endon ("kill override");
	
	while (1)
	{
		self waittill ("spawned", spawned);
		wait 0.1;
		if (isdefined(spawned) && isalive(spawned))
		{
			//println("changing enemy AI parameters");
			spawned.suppressionwait = 0.15;
			spawned.interval = 32;
			spawned.accuracy = level.counterattack_ai_accuracy;
			spawned.favoriteenemy = level.player;
		}
	}
}

house_floor_tally()
{	
	nFloorCheckTrig = getent("housespawndetect", "targetname");
	nFloorCheckTrig waittill("trigger");

	level notify ("entering house");
	
	level.nKamarov.ignoreme = 0;
	
	wait 0.05; 	//some of the spawners are killed at this point by script_killspawner triggers
	
	aSpawners = getspawnerteamarray("axis");
	for(i=0; i<aSpawners.size; i++)
	{
		if(isdefined(aSpawners[i]) && isdefined(aSpawners[i].script_commonname) && aSpawners[i].script_commonname == "housespawner")
		{
			aSpawners[i] dospawn();
			wait 0.05;
		}
	}
	
	aEnemies = getaiarray("axis");
	level.housefullpop = aEnemies.size;
	thread house_clear_check();
	
	//Init empty arrays
	
	aEnemiesFloor0 = [];
	aEnemiesFloor1 = [];
	aEnemiesFloor2 = [];
	aEnemiesFloor3 = [];
	aEnemiesFloor4 = [];
	aEnemiesFloor5 = [];
	
	for(i=0; i<aEnemies.size; i++)
	{
		if(isdefined(aEnemies[i].script_noteworthy) && aEnemies[i].script_noteworthy == "floor0")
		{ 
			//aEnemiesFloor0 = maps\_utility::add_to_array(aEnemiesFloor0, aEnemies[i]);
			aEnemiesFloor0[aEnemiesFloor0.size] = aEnemies[i];
		}
		if(isdefined(aEnemies[i].script_noteworthy) && aEnemies[i].script_noteworthy == "floor1")
		{
			//aEnemiesFloor1 = maps\_utility::add_to_array(aEnemiesFloor1, aEnemies[i]);
			aEnemiesFloor1[aEnemiesFloor1.size] = aEnemies[i];
		}
		if(isdefined(aEnemies[i].script_noteworthy) && aEnemies[i].script_noteworthy == "floor2")
		{
			//aEnemiesFloor2 = maps\_utility::add_to_array(aEnemiesFloor2, aEnemies[i]);
			aEnemiesFloor2[aEnemiesFloor2.size] = aEnemies[i];
		}
		if(isdefined(aEnemies[i].script_noteworthy) && aEnemies[i].script_noteworthy == "floor3")
		{
			//aEnemiesFloor3 = maps\_utility::add_to_array(aEnemiesFloor3, aEnemies[i]);
			aEnemiesFloor3[aEnemiesFloor3.size] = aEnemies[i];
		}
		if(isdefined(aEnemies[i].script_noteworthy) && aEnemies[i].script_noteworthy == "floor4")
		{
			//aEnemiesFloor4 = maps\_utility::add_to_array(aEnemiesFloor4, aEnemies[i]);
			aEnemiesFloor4[aEnemiesFloor4.size] = aEnemies[i];
		}
		if(isdefined(aEnemies[i].script_noteworthy) && aEnemies[i].script_noteworthy == "floor5")
		{
			//aEnemiesFloor5 = maps\_utility::add_to_array(aEnemiesFloor5, aEnemies[i]);
			aEnemiesFloor5[aEnemiesFloor5.size] = aEnemies[i];
		}
	}
	
	level.floor0pop = aEnemiesFloor0.size;
	//println("Floor 0 Population = ", level.floor0pop);
	thread house_floortracker(aEnemiesFloor0, 0);
	
	level.floor1pop = aEnemiesFloor1.size;
	//println("Floor 1 Population = ", level.floor1pop);
	thread house_floortracker(aEnemiesFloor1, 1);
	
	level.floor2pop = aEnemiesFloor2.size;
	//println("Floor 2 Population = ", level.floor2pop);
	thread house_floortracker(aEnemiesFloor2, 2);
	
	level.floor3pop = aEnemiesFloor3.size;
	//println("Floor 3 Population = ", level.floor3pop);
	thread house_floortracker(aEnemiesFloor3, 3);
	
	level.floor4pop = aEnemiesFloor4.size;
	//println("Floor 4 Population = ", level.floor4pop);
	thread house_floortracker(aEnemiesFloor4, 4);
	
	level.floor5pop = aEnemiesFloor5.size;
	//println("Floor 5 Population = ", level.floor5pop);
	thread house_floortracker(aEnemiesFloor5, 5);
}

house_floortracker(aEnemies, nFloorID)
{	
	level endon ("floor clearing failsafe");
	
	nInHouseTrig = getent("inthehousetrigger", "targetname");
	
	if(!aEnemies.size)
	{
		//println("===Floor already clear!===");
		
		switch(nFloorID)
		{
			case 0:
				level.nFloorID_0 = 1;
				level notify ("floorcleared0");
				level.floorcount--;
				level notify ("floordone");
				break;
			case 1:
				level.nFloorID_1 = 1;
				level notify ("floorcleared1");
				level.floorcount--;
				level notify("floordone");
				break;
			case 2:
				level.nFloorID_2 = 1;
				level notify ("floorcleared2");
				level.floorcount--;
				level notify("floordone");
				break;
			case 3:
				level.nFloorID_3 = 1;
				level notify ("floorcleared3");
				level.floorcount--;
				level notify("floordone");
				break;
			case 4:
				level.nFloorID_4 = 1;
				level notify ("floorcleared4");
				level.floorcount--;
				level notify("floordone");
				break;
			case 5:
				level.nFloorID_5 = 1;
				level notify ("floorcleared5");
				level.floorcount--;
				level notify("floordone");
				break;
		}	
		
		return;	
	}
	
	for(i=0; i<aEnemies.size; i++)
	{	
		level thread house_deathcounter(aEnemies[i]);
	}
	
	wait 0.1;
	
	aEnemies = undefined;
	aEnemies = [];
	aEnemies = getaiarray("axis");
	
	for(i=0; i<aEnemies.size; i++)
	{
		if(!(aEnemies[i] istouching(nInHouseTrig)))
		{
			aEnemies[i] setgoalentity(level.player);
			aEnemies[i].goalradius = 512;
		}
	}
}

house_deathcounter(nEnemy)
{
	level endon ("floor clearing failsafe");
	
	//println("My Floor ID is = ", nEnemy.script_noteworthy);
	nFloorID = nEnemy.script_noteworthy;
	nEnemy waittill("death");
	level notify ("housespawner died");
	
	if(nFloorID == "floor0")
	{
		level.floor0pop--;
		//println("Floor 0 Population = ", level.floor0pop);
		
		if(!level.floor0pop)
		{
			level notify ("floorcleared0");
			level.nFloorID_0 = 1;
			level.floorcount--;
			wait 0.05;
			level notify("floordone");
			//println("++++ Floor0 is clear ++++");
			//println("level.nFloorID_0 = ", level.nFloorID_0);
			
		}
	}
	else
	if(nFloorID == "floor1")
	{
		level.floor1pop--;
		//println("Floor 1 Population = ", level.floor1pop);
		
		if(!level.floor1pop)
		{
			level notify ("floorcleared1");
			level.nFloorID_1 = 1;
			level.floorcount--;
			wait 0.05;
			level notify("floordone");
			//println("++++ Floor1 is clear ++++");
			//println("level.nFloorID_1 = ", level.nFloorID_1);
		}
	}
	else
	if(nFloorID == "floor2")
	{
		level.floor2pop--;
		//println("Floor 2 Population = ", level.floor2pop);
		
		if(!level.floor2pop)
		{
			level notify ("floorcleared2");
			level.nFloorID_2 = 1;
			level.floorcount--;
			wait 0.05;
			level notify("floordone");
			//println("++++ Floor2 is clear ++++");
			//println("level.nFloorID_2 = ", level.nFloorID_2);
		}
	}
	else
	if(nFloorID == "floor3")
	{
		level.floor3pop--;
		//println("Floor 3 Population = ", level.floor3pop);
		
		if(!level.floor3pop)
		{
			level notify ("floorcleared3");
			level.nFloorID_3 = 1;
			level.floorcount--;
			wait 0.05;
			level notify("floordone");
			//println("++++ Floor3 is clear ++++");
			//println("level.nFloorID_3 = ", level.nFloorID_3);
		}
	}
	else
	if(nFloorID == "floor4")
	{
		level.floor4pop--;
		//println("Floor 4 Population = ", level.floor4pop);
		
		if(!level.floor4pop)
		{
			level notify ("floorcleared4");
			level.nFloorID_4 = 1;
			level.floorcount--;
			wait 0.05;
			level notify("floordone");
			//println("++++ Floor4 is clear ++++");
			//println("level.nFloorID_4 = ", level.nFloorID_4);
		}
	}
	else
	if(nFloorID == "floor5")
	{
		level.floor5pop--;
		//println("Floor 5 Population = ", level.floor5pop);
		
		if(!level.floor5pop)
		{
			level notify ("floorcleared5");
			level.nFloorID_5 = 1;
			level.floorcount--;
			wait 0.05;
			level notify("floordone");
			//println("++++ Floor5 is clear ++++");
			//println("level.nFloorID_5 = ", level.nFloorID_5);
		}
	}
}

objective_floors()
{
	level endon ("floor clearing failsafe");
	
	nFloor0Marker = getent("floor0objective", "targetname");
	nFloor1Marker = getent("floor1objective", "targetname");
	nFloor2Marker = getent("floor2objective", "targetname");
	nFloor3Marker = getent("floor3objective", "targetname");
	nFloor4Marker = getent("floor4objective", "targetname");
	nFloor5Marker = getent("floor5objective", "targetname");
	
	if(level.nFloorID_0 != 1)
	{
		//println("Waiting...........Floor 0");
		level.objectiveorigin = nFloor0Marker.origin;
		level waittill("floorcleared0");
		//println("CLEARED 0");
	}
	if(level.nFloorID_1 != 1)
	{
		//println("Waiting...........Floor 1");
		
		level.objectiveorigin = nFloor1Marker.origin;
		level waittill("floorcleared1");
		//println("CLEARED 1");
	}
	if(level.nFloorID_2 != 1)
	{
		//println("Waiting...........Floor 2");
		level.objectiveorigin = nFloor2Marker.origin;
		level waittill("floorcleared2");
		//println("CLEARED 2");
	}
	if(level.nFloorID_3 != 1)
	{
		//println("Waiting...........Floor 3");
		level.objectiveorigin = nFloor3Marker.origin;
		level waittill("floorcleared3");
		//println("CLEARED 3");
	}
	if(level.nFloorID_4 != 1)
	{
		//println("Waiting...........Floor 4");
		level.objectiveorigin = nFloor4Marker.origin;
		level waittill("floorcleared4");
		//println("CLEARED 4");
	}
	
	level notify ("objective5");
	
	println("OBJECTIVE 5 ACTIVATED");
}

house_cleared_failsafe()
{
	level waittill ("entering house");
	
	wait 5;
	
	aEnemies = [];
	aEnemies = getaiarray("axis");
	
	while(aEnemies.size > 0)
	{
		wait 1;
		aEnemies = undefined;
		aEnemies = [];
		aEnemies = getaiarray("axis");	
	}
	
	level notify ("floor clearing failsafe");
	level notify ("objective5");
	level.housefullpop = 0;
}

house_clear_check()
{	
	while(level.housefullpop > 0)
	{	
		level waittill ("housespawner died");
		level.housefullpop--;
	}
	
	//println("!!!!!!!! HOUSE IS SECURE !!!!!!!!!!!");
	
	//Setups for defense
	
	thread kamarov_regroup();
}

kamarov_regroup()
{	
	//Get in position
	
	level.nKamarov thread animscripts\shared::SetInCombat(false);
	
	nKamarovNode = getnode("kamarovregroup", "targetname");
	level.nKamarov setgoalnode(nKamarovNode);	
	level.nKamarov.goalradius = 96;
	
	level.nKamarov waittill("goal");
	level.nKamarov allowedStances ("crouch");
	level.nKamarov.dontavoidplayer = 1;
	
	//Wait for player to get close enough
	
	nPlayerProx = length(nKamarovNode.origin - level.player.origin);
	
	while(nPlayerProx > 128)
	{
		wait 0.25;
		nPlayerProx = length(nKamarovNode.origin - level.player.origin);
	}
	
	//Spawn the anti-tank rifles on floors 2 and 3
	
	//println("****** SPAWN THE RIFLES NOW AS MISC_TURRETS ********");
	
	thread defense_atr_deploy();
		
	//Barney to player
	
	//level.nKamarov.followmin = -6;
	//level.nKamarov.followmax = 6;
	//level.nKamarov.goalradius = 100;
	//level.nKamarov setgoalentity(level.player);
	
	//DIALOG - Sgt. Pavlov - Comrade Alexei, we've got those anti-tank rifles on the second and third floor! You take out the tanks - we'll stop the troops!
	
	level.nKamarov animscripts\shared::LookAtEntity(level.player, 8, "alert");
	level.nKamarov anim_single_solo(level.nKamarov, "comradealexei");
	
	level.nKamarov allowedStances ("stand", "crouch");

	//Release the practice tanks and troops
	
	thread defense_enemy_practice_schedule();
	level notify ("practice tank assault south");
	
	//Rally the troops
	
	nRallyRun = getnode("pavlov_rallyrun", "targetname");
	level.nKamarov setgoalnode(nRallyRun);
	level.nKamarov.goalradius = 8;
	level.nKamarov.dontavoidplayer = 0;
	//level.nKamarov waittill("goal");
	
	thread house_rally_speech();
	
	level.nKamarov thread animscripts\shared::SetInCombat(1200);
	
	while(1)
	{
		if(isdefined(nRallyRun.target))
		{
			nRallyRun = getnode(nRallyRun.target, "targetname");
			level.nKamarov setgoalnode(nRallyRun);
			level.nKamarov waittill("goal");
		}
		else
		{
			//aStations = [];
			//aStations = getnodearray("battlestation", "targetname");
			nPavlovStation = getnode("pavlov_battlestation", "targetname");
			
			//level.nKamarov setgoalnode(aStations[randomint(aStations.size)]);
			level.nKamarov setgoalnode(nPavlovStation);
			level.nKamarov.goalradius = 1000;
			break;
		}
	}	
}

house_rally_speech()
{
	//Kamarov rallies the troops verbally and gets replies
	
	thread defense_start();
	
	wait 2; 
	level.nKamarov anim_single_solo(level.nKamarov, "readyantitank");
	
	level thread house_rally_reply("atriflesready");
	wait 2;
	
	level.nKamarov anim_single_solo(level.nKamarov, "machineguns");
	
	level thread house_rally_reply("mgsready");
	wait 1.5;
	
	level.nKamarov anim_single_solo(level.nKamarov, "readycomrades");
	
	wait 1.25;
	
	level thread house_rally_reply("holdthispos");
}

house_rally_reply(nSoundAlias)
{
	aFriendlies = [];
	aFriendlies = getaiarray("allies");
	if(aFriendlies.size > 1)
	{
		for(i=0; i<aFriendlies.size; i++)
		{
			if(isdefined(aFriendlies[i].targetname) && aFriendlies[i].targetname == "kamarov")
			{
				maps\_utility::subtract_from_array(aFriendlies, aFriendlies[i]);
			}
		}
		nSize = aFriendlies.size;
		nRandomFriend = aFriendlies[randomint(nSize)];
		nRandomFriend.animname = "randomguy";
		
		nRandomFriend thread anim_single_solo(nRandomFriend, nSoundAlias);
	}
	aFriendlies = undefined;
}

defense_atr_deploy()
{
	level.atr1.origin = level.atr1spot;
	level.atr1.angles = level.atr1view;
	
	level.atr2.origin = level.atr2spot;
	level.atr2.angles = level.atr2view;
	
	level thread atrifle_usemonitor(level.atr1, level.atr2);
}

defense_start()
{
	//println("+++++ SO BEGINS THE FINAL BATTLE FOR SURVIVAL +++++");
	
	level.replacementson = 0;
	
	maps\_utility::autosave(4);
	
	level.player.threatbias = 1;
	
	level.nKamarov notify ("stop magic bullet shield");
	
	aStations = getnodearray("battlestation", "targetname");
	
	aFriendlies = getaiarray("allies");
	level.defenseFriendlies = aFriendlies.size;
	
	for(i=0; i<aFriendlies.size; i++)
	{	
		aFriendlies[i] allowedstances ("stand", "crouch");
		aFriendlies[i].script_usemg42 = 3;
		aFriendlies[i].goalradius = 128;
		aFriendlies[i].suppressionwait = 0;
		aFriendlies[i].health = level.friendly_defense_health;
		aFriendlies[i].accuracy = 1;
		aFriendlies[i].dontavoidplayer = 0;
		aFriendlies[i] setgoalnode(aStations[i]);
		level thread defense_posturing(aFriendlies[i]);
		level thread defense_friendly_deathwaiter(aFriendlies[i]);
	}
	
	wait 0.05;
	
	if(isdefined(level.nKamarov) && isalive(level.nKamarov))
	{
		level.nKamarov.health = level.Pavlov_defense_health;
		level.nKamarov.accuracy = 1;
	}
	
	level waittill ("start the main counterattack");
	
	aFriendlies = getaiarray("allies");
	for(i=0; i<aFriendlies.size; i++)
	{	
		aFriendlies[i].health = level.friendly_defense_health;
		aFriendlies[i].accuracy = 0.9;
	}
	
	thread defense_stopwatch();
	thread defense_4thfloor_mortars();
	thread defense_room_mortars();
	
	level notify ("kill override");
	wait 1;
	
	thread defense_ai_overrides();
	wait 0.05;
	thread defense_enemy_schedule();
	
	wait 5;
	
	//println("Deploying enemy tanks.");
}

defense_friendly_deathwaiter(nFriendly)
{
	nFriendly waittill("death");
	level.defenseFriendlies--; 
}

defense_posturing(nFriendly)
{
	nFriendly waittill("goal");
	nFriendly allowedstances ("crouch");
}

defense_enemy_schedule()
{
	level endon ("victory");
	level notify ("open the floodgates");
	
	//squad_assault(strSquadName, strType, iAxisAcc, iAlliedAcc, iRosterMax, iInterval, iAxisSuppWait, iAlliesSuppWait)
	
	strType = "spawner";
	
	nPopMax = level.defense_enemy_total;
	
	level.nDefensePractice = 0;
	
	while(1)
	{
		thread squad_assault(level.strGamma, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		thread squad_assault(level.strEpsilon, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		thread squad_assault(level.strDelta, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strBeta, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		thread squad_assault(level.strAlpha, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strBeta, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strAlpha, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strEta, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strGamma, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strZeta, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		thread squad_assault(level.strEta, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strAlpha, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strAlpha, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
	}
	
}

defense_enemy_practice_schedule()
{
	level endon ("open the floodgates");
	
	//squad_assault(strSquadName, strType, iAxisAcc, iAlliedAcc, iRosterMax, iInterval, iAxisSuppWait, iAlliesSuppWait)
	
	strType = "spawner";
	
	nPopMax = level.defense_enemy_practice_total;
	
	while(1)
	{
		thread squad_assault(level.strGamma, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait 3;
		thread squad_assault(level.strEpsilon, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait 2;
		thread squad_assault(level.strDelta, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strBeta, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strAlpha, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strGamma, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strZeta, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strEta, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strAlpha, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strBeta, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strEpsilon, strType, 0.1, undefined, nPopMax, undefined, 0, 0);
		wait(level.fSpawnInterval);
	}
	
}

defense_stopwatch()
{		
	fMissionLength = level.stopwatch;				//how long until relieved (minutes)	
	iMissionTime_ms = gettime() + (int)(fMissionLength*60*1000);	//convert to milliseconds
	
	// Setup the HUD display of the timer.
	
	level.hudTimerIndex = 20;
	//hdSetString(level.hudTimerIndex, &"PAVLOV_REINFORCEMENTS_ARRIVING", hdGetTimerString(getTime()+(level.stopwatch*60*1000), "downremove"));
	//hdSetAlignment(level.hudTimerIndex, "right", "top");
	//hdSetPosition(level.hudTimerIndex, 0, 120);
	
	level.timer = newHudElem();
	level.timer.alignX = "left";
	level.timer.alignY = "middle";
	level.timer.x = 460;
	level.timer.y = 150;
	level.timer.label = &"PAVLOV_REINFORCEMENTS_ARRIVING";
	level.timer setTimer(level.stopwatch*60);
	
	wait((level.stopwatch*60) / 2);
	
	maps\_utility::autosave(5);
	
	wait((level.stopwatch*60) / 2);
	
	level.timer destroy();
	
	level notify("friendly tank assault");
	
	thread victory_finalcheck();
}

defense_4thfloor_mortars()
{
	level endon ("victory");
	
	nOpen4thTrig = getent("mortar_4thfloor_trigger", "targetname");
	aOpenMortar4th = getentarray("mortar_4thfloor", "targetname");
	
	while(1)
	{
		nOpen4thTrig waittill("trigger");
		wait level.fourthfloormortartime;
		
		if(level.player istouching(nOpen4thTrig))
		{
			thread defense_4thfloor_shockdelay(undefined, nOpen4thTrig);
		
			for(i=0; i<aOpenMortar4th.size; i++)
			{
				aOpenMortar4th[i] thread activate_mortar_pavlov(256, 150, 100, 0.15, 0.5, 8000);
				wait 0.6 + randomfloat (0.3);
			}
		}
		
		wait level.upperfloorshocktime;
	}
}

defense_4thfloor_shockdelay(n, trigger)
{
	if(!isdefined(n))
	{
		wait 0.8;
	}
	
	if(level.player istouching(trigger))
	{
		thread maps\_shellshock::main(level.upperfloorshocktime, 30, 40, 25, 1);
	}
}

defense_room_mortars()
{
	aTopFloorTrigs = getentarray("mortar_4thfloor_roomtrig", "targetname");
	
	for(i=0; i<aTopFloorTrigs.size; i++)
	{
		level thread defense_room_mortar_check(aTopFloorTrigs[i]);
	}
}

defense_room_mortar_check(nTrigger)
{
	level endon ("victory");
	
	blasted = 0;
	
	while(1)
	{
		nTrigger waittill("trigger");
		wait level.fourthfloormortartime;
		
		if(level.player istouching(nTrigger))
		{	
			aExplosives = getentarray("roof_mortar", "targetname");
			for(i=0; i<aExplosives.size; i++)
			{
				if(nTrigger.script_noteworthy == aExplosives[i].script_noteworthy)
				{
					//println("EXPLODER MATCH FOUND");
					
					aExplosives[i] thread activate_mortar_pavlov(256, 150, 100, 0.15, 0.5, 8000, undefined, 1);
					level waittill ("mortar can explode");
					thread defense_4thfloor_shockdelay(1, nTrigger);
					
					if(!blasted)
					{
						//println("EXPLODING CEILING NOW");
						thread maps\_utility::exploder (aExplosives[i].script_noteworthy);
						blasted = 1;
					}
				} 
			}
		}
		
		wait level.upperfloorshocktime;
	}
}

tank_practice_schedule()
{
	level waittill ("practice tank assault south");
	
	tank_deploy(level.aPracticeTankNameSouth[0]);
	level waittill("practice tank dead");
	
	level notify("practice tank assault north");
	
	tank_deploy(level.aPracticeTankNameNorth[0]);
	level waittill("practice tank dead");
	
	level notify ("start the main counterattack");
}

tank_enemy_schedule()
{
	level waittill ("start the main counterattack");
	
	level.aEnemyTankNames = maps\_utility::array_randomize(level.aEnemyTankNames);
	
	deployInterval = level.stopwatchsecs / level.aEnemyTankNames.size;
	//println("Deploy interval is ", deployInterval);
	
	for(i=0; i<level.aEnemyTankNames.size; i++)
	{
		tank_deploy(level.aEnemyTankNames[i]);
		//wait randomintrange(8, 35);
		wait (deployInterval);
	}
}

tank_friendly_schedule()
{
	level waittill("friendly tank assault");
	
	level notify ("friendly tanks arrive");
	
	for(i=0; i<level.aGoodTankNames.size; i++)
	{
		tank_deploy(level.aGoodTankNames[i]);
		wait 0.1;	
	}
}

victory_failsafe()
{
	wait 0.3;
	
	aEnemies = [];
	aEnemies = getaiarray("axis");
	
	while(aEnemies.size > 0)
	{
		wait 1;
		aEnemies = undefined;
		aEnemies = [];
		aEnemies = getaiarray("axis");
	}
	
	println("Victory failsafe activated");
	
	level notify ("victory failsafe");
	thread victory();
}

victory_finalcheck()
{
	level notify ("victory");
	
	level.aLastEnemies = [];
	level.aLastEnemies = getaiarray("axis");
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
	
	level.replacementson = 1;
	level.teampop = 10;	//up to 12 nodes available here
	
	thread replacement_spawn();
	
	thread victory_failsafe();
}

victory_deathwaiter(nEnemy)
{
	level endon ("victory failsafe");
	
	nEnemy waittill("death");
	level.aLastEnemies = maps\_utility::subtract_from_array(level.aLastEnemies, nEnemy);
	println("There are currently ", level.aLastEnemies.size, " enemy soldiers in the level.");
	objective_add(9, "active", "");
	objective_string(9, &"PAVLOV_CLEAR_THE_AREA_OF_ANY1", level.aLastEnemies.size);
	objective_current(9);
}

victory_deathcounter()
{
	level endon ("victory failsafe");
	
	objective_add(9, "active", "");
	objective_string(9, &"PAVLOV_CLEAR_THE_AREA_OF_ANY1", level.aLastEnemies.size);
	objective_current(9);
	
	while(level.aLastEnemies.size > 0)
	{
		wait 0.25;
	}
	
	while(level.aTankArray.size > 0)
	{
		wait 0.25;
	}
	
	println("All enemies are dead and ", level.aTankArray.size, " enemy tanks are left.");
	
	thread victory();
}

victory_suiciderun(nSoldier)
{
	level endon ("victory failsafe");
	
	nSoldier endon ("death");
	
	wait randomintrange(10, 45);
	nSoldier setgoalentity(level.player);
	nSoldier.goalradius = 720;
}

victory_rally()
{
	//Player has to go to a concluding area
	
	aAllies = getaiarray("allies");
	aRallyNodes = getnodearray("final_assembly_node", "targetname");
	
	nNode = getnode("final_rally_point", "targetname");
	
	for(i=0; i<aAllies.size; i++)
	{
		aAllies[i] setgoalnode(aRallyNodes[i]);
		aAllies[i].goalradius = 32;
		
		n = randomint(3);
		
		if(n > 1)
		{
			aAllies[i] allowedStances("crouch");
		}
		else
		{
			aAllies[i] allowedStances("stand");
		}
		
	}
	
	dist = length(level.player.origin - nNode.origin);
	while(dist > 256)
	{
		dist = length(level.player.origin - nNode.origin);
		wait 0.05;	
	}
	
	aAllies = undefined;
	aAllies = [];
	aAllies = getaiarray("allies");
	
	if(aAllies.size > 0)
	{
		randAlly = aAllies[randomint(aAllies.size)];
		randAlly.animname = "vladimir";
		
		randAlly thread animscripts\shared::LookAtEntity(level.player, 3, "alert");
		randAlly OrientMode("face direction", level.player.origin-randAlly.origin ); 
		randAlly anim_single_solo (randAlly, "heyalexei");
	}
	
	wait 0.5;
	
	if(aAllies.size > 0)
	{
		randAlly = aAllies[randomint(aAllies.size)];
		randAlly.animname = "vladimir";
		
		randAlly thread animscripts\shared::LookAtEntity(level.player, 3, "alert");
		randAlly OrientMode("face direction", level.player.origin-randAlly.origin ); 
		randAlly anim_single_solo (randAlly, "heyalexei");
	}
	
	level notify("level finished");
}

victory()
{
	println("YOU WIN!!!! ALMOST!!!");
	level notify ("objective9");
	
	level waittill ("level finished");
	
	wait 1;
	missionSuccess("factory", false);
}

objectives()
{
	objective_add(1, "active", &"PAVLOV_ASSEMBLE_WITH_SGT_PAVLOVS", (level.nKamarov.origin));
	objective_current(1);
	
	thread objective_pingfollow();
	
	level waittill ("objective2");
	objective_state(1, "done");
	
	if ((getcvar ("start") != "skipsnipers") && (getcvar ("start") != "skipall"))
	{
		maps\_utility::autosave(1);
	
		thread objectives_snipercount();
	
		level waittill ("objective3");
	
		//objective_add(2, "active", &"PAVLOV_ELIMINATE_THE_SNIPERS", (-9500, 10000, 512));
		objective_add(2, "active", &"PAVLOV_ELIMINATE_THE_SNIPERS", (-9763, 6149, -97));
		objective_state(2, "done");
	}
	objective_add(3, "active", &"PAVLOV_GET_ACROSS_THE_FIELD", (-9600, 8512, 64));
	objective_current(3);
	
	level waittill ("objective4");
	objective_state(3, "done");
	
	maps\_utility::autosave(2);
	
	thread objective_floors();
	wait 0.05;
	thread objectives_floorcount();
	
	level waittill ("objective5");
	
	objective_string(4, &"PAVLOV_RETAKE_THE_APARTMENT");
	objective_state(4, "done");
	
	nKamarovNode = getnode("kamarovregroup", "targetname");
	
	objective_add(5, "active", &"PAVLOV_REGROUP_WITH_SGT_PAVLOV", nKamarovNode.origin);
	objective_current(5);
	
	level waittill ("practice tank assault south");
	
	objective_state(5, "done");
	
	objective_add(6, "active", &"PAVLOV_USE_THE_2ND_FLOOR_ANTITANK", (level.atr1spot));
	objective_current(6);
	
	level waittill ("practice tank assault north");
	
	objective_state(6, "done");
	
	objective_add(7, "active", &"PAVLOV_USE_THE_3RD_FLOOR_ANTITANK", (level.atr2spot));
	objective_current(7);
	
	level waittill ("start the main counterattack");
	
	objective_state(7, "done");
	
	objective_add(8, "active", &"PAVLOV_HOLD_THE_BUILDING_UNTIL");
	objective_current(8);
	
	level waittill("friendly tank assault");
	
	objective_state(8, "done");
	
	level waittill ("objective9");
	
	objective_add(9, "active", &"PAVLOV_CLEAR_THE_AREA_OF_ANY");
	objective_state(9, "done");
	
	thread victory_rally();
	
	nNode = getnode("final_rally_point", "targetname");
	
	objective_add(10, "active", &"PAVLOV_ASSEMBLE_WITH_THE_REINFORCEMENTS", nNode.origin);
	objective_current(10);
	
	level waittill ("level finished");
	
	objective_state(10, "done");
}

objective_pingfollow()
{
	//Makes the objective pointer follow Pavlov
	level endon ("objective2");
	
	while(1)
	{
		objective_position(1, level.nKamarov.origin);
		wait 0.05;
	}
}

objectives_snipercount()
{
	//objective_add(2, "active", "", (-9500, 10000, 512));
	objective_add(2, "active", "", (-9763, 6149, -97));
	objective_string(2, &"PAVLOV_ELIMINATE_THE_SNIPERS1", level.aSnipersCount);
	objective_current(2);
	
	while(level.aSnipersCount > 0)
	{
		level waittill ("sniper down");
		if(level.aSnipersCount > 0)
		{
			//objective_add(2, "active", "", (-9500, 10000, 512));
			objective_add(2, "active", "", (-9763, 6149, -97));
			objective_string(2, &"PAVLOV_ELIMINATE_THE_SNIPERS1", level.aSnipersCount);
			objective_current(2);
		}
	}
	
	level notify ("objective3");
}

objectives_floorcount()
{
	level endon ("floor clearing failsafe");
	
	objective_add(4, "active", "", level.objectiveorigin);
	objective_string(4, &"PAVLOV_CLEAR_OUT_THE_APARTMENT", level.floorcount);
	objective_current(4);
	
	while(level.floorcount > 0)
	{
		level waittill("floordone");
		if(level.floorcount == 1)
		{
			objective_add(4, "active", "", level.objectiveorigin);
			objective_string(4, &"PAVLOV_CLEAR_OUT_THE_APARTMENT1", level.floorcount);
			objective_current(4);
		}
		else if(level.floorcount > 0)
		{
			objective_add(4, "active", "", level.objectiveorigin);
			objective_string(4, &"PAVLOV_CLEAR_OUT_THE_APARTMENT", level.floorcount);
			objective_current(4);
		}
	}
	
	level notify ("objective5");
}

//******************************************************//
//		INFANTRY COMBAT UTILITIES		//
//******************************************************//

/*******************

squad_route (many, at least one required)
squad_entry (many, optional)
squad_contact (many, optional)
squad_capture (one, required)

Variables:

strSquadName (name of squad - script_squadname)
strType (specify "spawner" or "preplaced")

Endon:

"victory"

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
				
				wait 0.05;	//dospawn is a slow builtin function
				
				if(isdefined (nSoldier) && isalive (nSoldier))
				{
					nSoldier.interval = iInterval;	
					nSoldier.suppressionwait = iAxisSuppWait;
					nSoldier.bravery = 500000;	//forces AI to do whatever it's told regardless of danger
					if(nSoldier.team == "axis")
					{
						nSoldier.accuracy = iAxisAcc;
						if(level.nDefensePractice == 1)
						{
							nSoldier.health = 10;
							nSoldier.suppressionwait = 1.5;
						}
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
	
	if(!isdefined(nSoldier) || !isalive(nSoldier))
	{
		return;
	}
	
	nSoldier endon ("death");
	nSoldier endon ("I got there");
	
	nSoldier waittill("goal");

	//Send soldier to random entry node if any

	//Format: attack_move_node(nSoldier, fWaitMin, fWaitMax, fClosureRate, nGoalNode, fStartRadius, fEndRadius)

	if(!isalive(nSoldier))
	{
		return;
	}

	if(aEntryNodes.size > 0)
	{
		nRndEntryNode = aEntryNodes[randomint(aEntryNodes.size)];			
		if(nSoldier.team == "axis")
		{
			level attack_move_node(nSoldier, 2, 6, 0.5, nRndEntryNode, undefined, 300);
		}
		if(nSoldier.team == "allies")
		{
			level attack_move_node(nSoldier, 0.1, 0.2, 0.9, nRndEntryNode, undefined, 256);
		}
	}

	//Send soldier to contact zone

	if(!isalive(nSoldier))
	{
		return;
	}

	if(aContactNodes.size > 0)
	{
		nRndContactNode = aContactNodes[randomint(aContactNodes.size)];
		if(nSoldier.team == "axis")
		{
			level attack_move_node(nSoldier, 4.8, 7, 0.5, nRndContactNode, undefined, 320);
		}
		if(nSoldier.team == "allies")
		{
			level attack_move_node(nSoldier, 0.5, 0.6, 0.9, nRndContactNode, undefined, 256);
		}
	}
	
	//Send soldier to capture point
	
	if(!isalive(nSoldier))
	{
		return;
	}
	
	if(!isdefined(nCaptureNode))
	{
		thread maps\_utility::error("You need to place a capture node for this squadname.");
	}
	if(nSoldier.team == "axis")
	{
		level attack_move_node(nSoldier, 3.3, 4.5, 0.96, nCaptureNode, undefined, 512);
	}
	if(nSoldier.team == "allies")
	{
		level attack_move_node(nSoldier, 0.2, 0.5, 0.9, nCaptureNode, undefined, 384);
	}
	
	if(!isalive(nSoldier))
	{
		return;
	}
	
	//Send soldier to hunt down the player
	
	wait randomintrange(3, 8);
	
	//grab an established route 1 or 2
	
	aLocatorTrigs = [];
	aLocatorTrigs = getentarray("playerlocator", "targetname");
	
	aLocatorNodes = [];
	aLocatorNodes = getnodearray("playerlocator_node", "targetname");
	
	nOutside = 1;
	
	nTrenchCampTrig = getent("trenchcamptrigger", "targetname");
	nInHouseTrig = getent("inthehousetrigger", "targetname");
	
	/*
	if (!isdefined (nsoldier.attacknum))
			nsoldier.attacknum = 0;
		
		nsoldier.attacknum++;
		if (nsoldier.attacknum > 1)
			maps\_utility::error ("This function is not meant to be run twice on one guy");
		
		if (isdefined (nSoldier.toldToAttack))
			println ("^3 SOLDIER WAS TOLD TO ATTACK EVEN THOUGH HE'D ALREADY ATTACKED");
	*/		
	
	while(level.defenseFriendlies > 0)
	{	
		
		for(i=0; i<aLocatorTrigs.size; i++)
		{
			if(level.player istouching(aLocatorTrigs[i]))
			{
				nOutside = 0;
				
				aLocNodeList = [];
				
				for(j=0; j<aLocatorNodes.size; j++)
				{
					if(aLocatorNodes[j].script_namenumber == aLocatorTrigs[i].script_namenumber)
					{
						//aLocNodeList = maps\_utility::add_to_array(aLocNodeList, aLocatorNodes[j]);
						aLocNodeList[aLocNodeList.size] = aLocatorNodes[j];
					}
				}
			}
		}
		
		if(!nOutside)
		{
			if(level.locatorswitch == 1)
			{
				for(n=0; n<aLocNodeList.size; n++)
				{
					if(aLocNodeList[n].script_noteworthy == "option1")
					{
						nSoldier setgoalnode(aLocNodeList[n]);
						println("Enemy taking option1 ++++");
						level.locatorswitch = 0;
						
						level thread clearing_routing_plan(nSoldier, aLocNodeList[n]);
						nSoldier waittill ("continue searching");
					}
				}
			}
			else
			{
				for(n=0; n<aLocNodeList.size; n++)
				{
					if(aLocNodeList[n].script_noteworthy == "option2")
					{
						nSoldier setgoalnode(aLocNodeList[n]);
						println("Enemy taking option2 ++++");
						level.locatorswitch = 1;
						
						level thread clearing_routing_plan(nSoldier, aLocNodeList[n]);
						nSoldier waittill ("continue searching");
					}
				}
			}
		}
		else
		if(level.player istouching(nTrenchCampTrig))
		{	
			aEnemies = getaiarray("axis");
			
			for(i=0; i<aEnemies.size; i++)
			{
				if(aEnemies[i] istouching(nInHouseTrig))
				{
					aEnemies = maps\_utility::subtract_from_array(aEnemies, aEnemies[i]);	
				}
			}
			
			for(i=0; i<aEnemies.size; i++)
			{
				nSoldier setgoalentity(level.player);	//replace this with the following
				nSoldier.goalradius = 700;
			}
		}
		
		wait 0.25;
		
		if(!isalive(nSoldier))
		{
			return;
		}
	}
	
	println("Enemy ATTACKING PLAYER DIRECTLY!!");
	nSoldier setgoalentity(level.player);	//replace this with the following
	//nSoldier.goalradius = 384;
	nSoldier.goalradius = 700;
}

clearing_routing_plan(nSoldier, nLocNode)
{
	nSoldier endon ("death");

	hangtime = 3 + randomfloat(5);
	
	nSoldier.goalradius = 8;
	nSoldier waittill ("goal");
	
	endreached = 0;
	destNode = nLocNode;
	
	while(!endreached)
	{
		if(!isalive(nSoldier))
		{
			return;
		}
		
		if(isdefined(destNode.target))
		{
			destNode = getnode(destNode.target, "targetname");
			nSoldier setgoalnode(destNode);
			
			if(isdefined(destNode.radius))
			{
				nSoldier.goalradius = destNode.radius;
			}
			else
			{
				nSoldier.goalradius = 192;
			}
			
			nSoldier waittill("goal");
			wait hangtime;
		}
		else
		{
			println("++++++++++++++ ATTACKING PLAYER DIRECTLY ++++++++++++");
			endreached = 1;
			nSoldier.goalradius = 512;
			nSoldier setgoalentity(level.player);
			println("nSoldier goal is ", nSoldier.goalentity);
			nSoldier notify ("I got there");
			nSoldier.toldToAttack = true;
			return;
		}
		
		if((length(level.player.origin - nSoldier.origin)) < 96)
		{
			nSoldier.goalradius = 512;
			nSoldier setgoalentity(level.player);
			nSoldier notify ("I got there");
			break;
		}
	}
	
	nSoldier notify ("continue searching");
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

//******************************************************//
//		TANK COMBAT UTILITIES			//
//******************************************************//

tank_sort()
{
	//Store the tank names and setup the tanks
	
	aTanks = [];
	aTankNames = [];
	
	level.aEnemyTankNames = [];
	level.aGoodTankNames = [];
	
	aTanks = getentarray("axis_tank", "script_noteworthy");
	for(i=0; i<aTanks.size; i++)
	{
		nTankName = aTanks[i].targetname;
		//level.aEnemyTankNames = maps\_utility::add_to_array(level.aEnemyTankNames, nTankName);
		level.aEnemyTankNames[level.aEnemyTankNames.size] = nTankName;
		thread tank_setup(aTanks[i]);
	}
	
	level.nPracticeTankNorth = getent("enemytank_practice_north", "targetname");
	
	level.aPracticeTankNameNorth = [];
	//level.aPracticeTankNameNorth = maps\_utility::add_to_array(level.aPracticeTankName, level.nPracticeTankNorth.targetname);
	level.aPracticeTankNameNorth[level.aPracticeTankNameNorth.size] = level.nPracticeTankNorth.targetname;
	thread tank_setup(level.nPracticeTankNorth);
	
	level.nPracticeTankSouth = getent("enemytank_practice_south", "targetname");
	
	level.aPracticeTankNameSouth = [];
	//level.aPracticeTankNameSouth = maps\_utility::add_to_array(level.aPracticeTankName, level.nPracticeTankSouth.targetname);
	level.aPracticeTankNameSouth[level.aPracticeTankNameSouth.size] = level.nPracticeTankSouth.targetname;
	thread tank_setup(level.nPracticeTankSouth);
	
	thread tank_practice_schedule();
	
	thread tank_enemy_schedule();
	
	aGoodTanks = getentarray("allied_tank", "script_noteworthy");
	for(i=0; i<aGoodTanks.size; i++)
	{
		nGoodTankName = aGoodTanks[i].targetname;
		//level.aGoodTankNames = maps\_utility::add_to_array(level.aGoodTankNames, nGoodTankName);
		level.aGoodTankNames[level.aGoodTankNames.size] = nGoodTankName;
		thread tank_setup(aGoodTanks[i]);
	}
	
	thread tank_friendly_schedule();
}

tank_setup(tank)
{
	maps\_vehiclespawn::spawner_setup(tank);		//gets tank properties and deletes the originally placed script_vehicle
}

tank_deploy(tankname)
{
	if(tankname != "friendly_tank2" && tankname != "friendly_tank3")
	{
		vehicle = maps\_vehiclespawn::vehicle_spawn(tankname);	//spawns the tank 
	}
	else
	{
		return;
	}
	
	println("Tank name is ", tankname);
	vehicle.health = 1000;
	
	path = tank_nearestpath(vehicle);			
	vehicle attachpath(path);
	vehicle startPath();
	
	thread tank_cannon_targeting(tankname, vehicle);
	
	if(isdefined(vehicle.script_noteworthy) && vehicle.script_noteworthy == "allied_tank")
	{
		//vehicle thread maps\_tankgun::mginit();
		//vehicle thread maps\_t34::init();
		vehicle.failwhenkilled = true;
		level thread maps\_spawner::killfriends_missionfail_think(vehicle,1);
		level thread tank_smoke_deathwaiter(vehicle);
		level thread tank_flame_deathwaiter(vehicle);
		
		wait 1;
		
		//Tanks that should fire their forward MG42 are friendly_tank5, 4, 7, 6, 8
		
		if(isalive(vehicle))
		{
			//level thread label_tankname(vehicle, tankname);
			level thread tank_friendly_mg42_control(vehicle, tankname);
			vehicle thread maps\_tankgun::mgoff();
			//vehicle.mgturret setmode("manual");
			println("Vehicle mg is off on ", tankname);
		}
	}
	
	if(isdefined(vehicle.script_noteworthy) && vehicle.script_noteworthy == "axis_tank")
	{
		level thread tank_add_subtract(vehicle);
		level thread tank_smoke_deathwaiter(vehicle);
		level thread tank_flame_deathwaiter(vehicle);
		level thread tank_mg42_accuracy_change(vehicle);
	}
	
	if(tankname == "enemytank_practice_north" || tankname == "enemytank_practice_south")
	{
		println("starting the deathwaiter on the practice tank");
		level thread tank_practice_deathwaiter(vehicle);
		level thread tank_smoke_deathwaiter(vehicle);
		level thread tank_flame_deathwaiter(vehicle);
		level thread tank_mg42_accuracy_change(vehicle);
	}
}

tank_friendly_mg42_control(vehicle, tankname)
{
	vehicle endon ("death");
	
	if(tankname == "friendly_tank5" || tankname == "friendly_tank4" || tankname == "friendly_tank7" || tankname == "friendly_tank6" || tankname == "friendly_tank8")
	{
		wait (12 + randomfloat(6) + randomfloat(3));
		
		while(1)
		{
			if(isalive(vehicle))
			{
				vehicle thread maps\_tankgun::mgon();
				wait (2 + randomfloat(2));
				if(isalive(vehicle))
				{
					vehicle thread maps\_tankgun::mgoff();
					wait (1.5 + randomfloat(1.5));	
				}
			}
			else
			{
				break;
			}
			
			wait 0.05;
		}
		
	}
}

tank_mg42_accuracy_change(vehicle)
{
	vehicle endon ("death");
	level endon ("victory");
	
	while(1)
	{
		if(isalive(vehicle) && level.usingrifle == 1)
		{
			vehicle.mgturret setTurretAccuracy(0);
			//println("++++++++++ SETTING TANK MG42s to MISS PLAYER ++++++++++++++");
		}
		else
		if(isalive(vehicle))
		{
			vehicle.mgturret setTurretAccuracy(0.15);
			//println("++++++++++ SETTING TANK MG42s to HIT PLAYER ++++++++++++++");
		}
		else
		{
			//println("++++IT DIDN'T WORK WORK WORK WORK+++++++++++++");
			break;
		}
		
		wait 0.25;
	}
}

atrifle_usemonitor(atrifle1, atrifle2)
{	
	level endon("victory");
	
	while(1)
	{
		atRifleUser1 = atrifle1 getTurretOwner();
		atRifleUser2 = atrifle2 getTurretOwner();	
		if(isdefined(atRifleUser1) || isdefined(atRifleUser2))
		{
			level.usingrifle = 1;
			//println("+++++++++++ PLAYER IS USING AN ANTI-TANK RIFLE +++++++++++");
		}
		else
		{
			level.usingrifle = 0;
			//println("+++++++++++ ANTI-TANK RIFLE IS OPEN +++++++++++");
		}
		
		wait 0.25;
	}
}

tank_practice_deathwaiter(nTank)
{
	nTank waittill ("death");
	println("notifying death of practice tank");
	level notify ("practice tank dead");
}

tank_smoke_deathwaiter(eTank)
{
	eTank waittill("death");
	level endon ("friendly tanks arrive");
	
	flameemitter = spawn("script_origin", eTank.origin);

	while(1)
	{
		playfx(level.lingerfx,flameemitter.origin);
		wait 15;
	}
}

tank_flame_deathwaiter(eTank)
{
	eTank waittill("death");
	level endon ("friendly tanks arrive");
	
	flameemitter = spawn("script_origin",eTank.origin+(0,0,32));
	while(1)
	{
		playfx(level.fireydeath,flameemitter.origin);
		wait (randomfloat (0.15)+.1);
	}
}

tank_add_subtract(nTank)
{
	level.aTankArray = maps\_utility::add_to_array(level.aTankArray, nTank);
	nTank waittill("death");
	level.aTankArray = maps\_utility::subtract_from_array(level.aTankArray, nTank);
	//println("There are currently ", level.aTankArray.size, " enemy tanks in the level.");
}

tank_nearestpath(vehicle)
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

tank_cannon_targeting(tankname, vehicle)
{
	vehicle endon("death");

	//println("tank cannon is targeting!!!!");
	//println("tank's script_noteworthy is ", vehicle.script_noteworthy);
	
	aCannonTriggers = getentarray("tank_blast_trigger", "targetname");
	//println("aCannonTriggers exists and is size", aCannonTriggers.size);
	
	//Each tank is assigned the same target list but differently randomized
	//When the player enters one of the triggers, the tank targets the targetpoint and fires 
	//The exploder detonates, and shellshock is applied if the player is still touching the trigger volume
	//The tanks keep firing and shellshocking, so you have to kill the tanks or risk being messed up
	
	if(isdefined(vehicle.script_noteworthy) && vehicle.script_noteworthy == "axis_tank" || tankname == "enemytank_practice_north" || tankname == "enemytank_practice_south")
	{
		aCannonTriggers = getentarray("tank_blast_trigger", "targetname");
		for(i=0; i<aCannonTriggers.size; i++)
		{
			level thread tank_cannon_trigger(aCannonTriggers[i], tankname, vehicle);
			//println("running triggers now");
		}
	}
	else
	if(isdefined(vehicle.script_noteworthy) && vehicle.script_noteworthy == "allied_tank")
	{
		aCannonTargets = [];
		aCannonTargets = getentarray("axis_tank", "script_noteworthy");
		//println("There are ", aCannonTargets.size, " enemy tanks to kill.");
		
		while(1)
		{
			for(i=0; i<aCannonTargets.size; i++)
			{
				if(isdefined(aCannonTargets[i]) && isalive(aCannonTargets[i]))
				{
					friendly_tank_fire_loop(vehicle, aCannonTargets[i]);
					wait 0.5;
				}
				wait 0.05;
			}
			
			if(level.tanksdead == 1)
			{
				//println("level.tanksdead = ", level.tanksdead);
				break;
			}
		} 
	}
	else
	{
		println("No script_noteworthy found on tank.");
	}
}

tank_enemy_deathwaiter_north(vehicle)
{
	vehicle waittill("death");
	//println("NORTHFIRED RESET!!!!!!!!!!!!");
	level.northfired = 0;
}

tank_enemy_deathwaiter_south(vehicle)
{
	vehicle waittill("death");
	//println("SOUTHFIRED RESET!!!!!!!!!!!!");
	level.southfired = 0;
}

tank_cannon_trigger(nTrigger, tankname, vehicle)
{
	vehicle endon ("death");
	
	if(tankname == "enemytank2" || tankname == "enemytank3" || tankname == "enemytank_practice_north")
	{
		level thread tank_enemy_deathwaiter_north(vehicle);
	}
	else 
	if(tankname == "enemytank1" || tankname == "enemytank4" || tankname == "enemytank_practice_south")
	{
		level thread tank_enemy_deathwaiter_south(vehicle);
	}
	
	padding = 3;
	
	enemyTank2Shot = 0;
	enemyTank3Shot = 0;
	
	enemyTank1Shot = 0;
	enemyTank4Shot = 0;
	
	aAimPoints = getentarray("tank_aimpoint", "targetname");
	
	maxAttackRange = 4800;	//tank must be at least this close to ref point
	
	while(1)
	{
		//println("WAITING TO TRIGGER");
		nTrigger waittill ("trigger");
		
		//println("nTrigger.script_idnumber = ", nTrigger.script_idnumber);
		//println("tankname = ", tankname);
		
		refPoint = getent("floor2objective", "targetname");
		dist = length(vehicle.origin - refPoint.origin);
		
		//println("dist is ", dist);
		
		if(dist >= maxAttackRange)
		{
			wait 0.05;
			continue;
		}
		
		if(tankname == "enemytank2")
		{
			if(!enemyTank2Shot)
			{
				wait 0.2;
			}
			else
			{
				wait 0.6;
			}
		}
		else
		if(tankname == "enemytank3")
		{
			if(!enemyTank3Shot)
			{
				wait 0.6;
			}
			else
			{
				wait 0.2;
			}
		}
		else
		if(tankname == "enemytank1")
		{
			if(!enemyTank1Shot)
			{
				wait 0.2;
			}
			else
			{
				wait 0.6;
			}
		}
		else
		if(tankname == "enemytank4")
		{
			if(!enemyTank4Shot)
			{
				wait 0.6;
			}
			else
			{
				wait 0.2;
			}
		}
		
		if(nTrigger.script_idnumber <= 11 && (tankname == "enemytank2" || tankname == "enemytank3" || tankname == "enemytank_practice_north" || tankname == "enemytank_practice_south") && !level.northfired)
		{
			level.northfired = 1;
			
			if(tankname == "enemytank2")
			{
				enemyTank2Shot = 1;
				enemyTank3Shot = 0;
			}
			else
			{
				enemyTank2Shot = 0;
				enemyTank3Shot = 1;
			}
			
			//println("TANK FIRING TRIGGER ACTIVATED - ", tankname);
			//println("TANK FIRING AT nTrigger = ", nTrigger.script_idnumber);
			
			for(i=0; i<aAimPoints.size; i++)
			{
				if(aAimPoints[i].script_idnumber == nTrigger.script_idnumber)
				{
					nTarget = aAimPoints[i];
				}
			}
			
			//Get the turret on target, then fire
			
			//println("TRAVERSING TURRET");
			
			vehicle setTurretTargetEnt(nTarget, (0, 0, 0));
			vehicle waittill( "turret_on_vistarget" );
			
			if(tankname == "enemytank_practice_north" || tankname == "enemytank_practice_south")
			{
				wait level.practiceGracePeriod;
			}
			else
			{
				wait level.realGracePeriod; 	//grace period
			}
			
			//println("FIRING TURRET");
			
			vehicle maps\_panzerIV::fire();
			
			//If the exploder is unused, blow it up, then mark it used
			
			if(!isdefined(nTarget.script_noteworthy))
			{
				thread maps\_utility::exploder (nTarget.script_idnumber);
				//println("Destroying EXPLODER ", nTarget.script_idnumber);
				nTarget.script_noteworthy = "used";
			}
		
			//Do radius damage off trigger
			
			radiusDamage(nTrigger.origin, 512, 90, 60);
		
			//Shellshock the player if the player is still hanging around when the shot is fired
		
			if(level.player istouching(nTrigger))
			{
				thread maps\_shellshock::main(level.shocktime, 30, 40, 25, 1);
				wait level.shocktime + padding;	//Give the player some time to recover and get out of there
			}
			
			level.northfired = 0;
		}
		else
		if(nTrigger.script_idnumber >= 12 && (tankname == "enemytank1" || tankname == "enemytank4" || tankname == "enemytank_practice_north" || tankname == "enemytank_practice_south") && !level.southfired)
		{
			level.southfired = 1;
			
			if(tankname == "enemytank1")
			{
				enemyTank1Shot = 1;
				enemyTank4Shot = 0;
			}
			else
			{
				enemyTank1Shot = 0;
				enemyTank4Shot = 1;
			}
			
			//println("TANK FIRING TRIGGER ACTIVATED - ", tankname);
			//println("TANK FIRING AT nTrigger = ", nTrigger.script_idnumber);
			
			for(i=0; i<aAimPoints.size; i++)
			{
				if(aAimPoints[i].script_idnumber == nTrigger.script_idnumber)
				{
					nTarget = aAimPoints[i];
					//println("nTarget.script_idnumber is ", nTarget.script_idnumber);
				}
			}
			
			//Get the turret on target, then fire
			
			//println("TRAVERSING TURRET");
			
			vehicle setTurretTargetEnt(nTarget, (0, 0, 0));
			vehicle waittill( "turret_on_vistarget" );
			
			if(tankname == "enemytank_practice_north" || tankname == "enemytank_practice_south")
			{
				wait level.practiceGracePeriod;
			}
			else
			{
				wait level.realGracePeriod;	//grace period
			}
			
			//println("FIRING TURRET");
			
			vehicle maps\_panzerIV::fire();
			
			//If the exploder is unused, blow it up, then mark it used
			
			if(!isdefined(nTarget.script_noteworthy))
			{
				thread maps\_utility::exploder (nTarget.script_idnumber);
				//println("Destroying EXPLODER ", nTarget.script_idnumber);
				nTarget.script_noteworthy = "used";
			}
		
			//Do radius damage off trigger
			
			radiusDamage(nTrigger.origin, 512, 80, 40);
		
			//Shellshock the player if the player is still hanging around when the shot is fired
		
			if(level.player istouching(nTrigger))
			{
				thread maps\_shellshock::main(level.shocktime, 30, 40, 25, 1);
				wait level.shocktime + padding; 	//Give the player some time to recover and get out of there
			}
			
			level.southfired = 0;
		}
		
		wait 0.05;
	}
}

enemy_tank_fire_loop(vehicle, target)
{
	vehicle endon("death");
	
	vehicle setTurretTargetEnt(target, (0, 0, 0));
	//vehicle waittill( "turret_on_vistarget" );
	vehicle maps\_panzerIV::fire();
	wait randomintrange(3,5);		//reloading
	vehicle maps\_panzerIV::fire();
	wait randomintrange(3,5);		//reloading
}

friendly_tank_fire_loop(vehicle, target)
{
	vehicle endon("death");
	
	vehicle setTurretTargetEnt(target, (0, 0, 64));
	//vehicle waittill( "turret_on_vistarget" );
	vehicle maps\_t34::fire();
	wait randomintrange(2,4);		//reloading
	vehicle maps\_t34::fire();
	wait randomintrange(2,4);		//reloading
}

bomberflight()
{
	level waittill ("launch the bombers");
	
	aBomberNodes = getVehicleNodeArray("bomberpath_start", "targetname");
	
	for(i=0; i<aBomberNodes.size; i++)
	{
		level thread bomberspawn(aBomberNodes[i]);
	}
	
	wait 0.05;
	
	aBombers = getentarray("plane", "targetname");
	
	aBombers[1] playsound("bomber_formation_drone");
}

bomberspawn(nNode)
{
	plane = spawnVehicle( "xmodel/vehicle_german_condor_lowpoly_nofog", "plane", "condor_show", (0,0,0), (0,0,0));
	plane attachPath(nNode);
	plane startPath();
	
	level thread endpathdelete(plane);	
}

endpathdelete(plane)
{
	plane waittill ("reached_end_node");
	plane delete();
}

carpetbombing()
{
	level waittill ("launch the bombers");
	
	aSquibs0 = getentarray("squib_bomblet0", "targetname");
	aSquibs0a = getentarray("squib_bomblet0a", "targetname");
	aSquibs1 = getentarray("squib_bomblet1", "targetname");
	aSquibs2 = getentarray("squib_bomblet2", "targetname");
	aSquibs3 = getentarray("squib_bomblet3", "targetname");
	aSquibs4 = getentarray("squib_bomblet4", "targetname");
	aSquibs5 = getentarray("squib_bomblet5", "targetname");
	aSquibs6 = getentarray("squib_bomblet6", "targetname");
	
	aSquibs0 = maps\_utility::array_randomize(aSquibs0);
	aSquibs0a = maps\_utility::array_randomize(aSquibs0a);
	aSquibs1 = maps\_utility::array_randomize(aSquibs1);
	aSquibs2 = maps\_utility::array_randomize(aSquibs2);
	aSquibs3 = maps\_utility::array_randomize(aSquibs3);
	aSquibs4 = maps\_utility::array_randomize(aSquibs4);
	aSquibs5 = maps\_utility::array_randomize(aSquibs5);
	aSquibs6 = maps\_utility::array_randomize(aSquibs6);
	
	//wait 16;
	//wait 31;
	wait 23;
	
	thread bombardment_cycle(aSquibs0, 0);
	println("starting 0th squibs");
	
	//wait 5;
	wait 2.5;
	
	thread bombardment_cycle(aSquibs0a, "0a");
	println("starting 0ath squibs");
	
	//wait 6;
	wait 2;
	
	level notify ("bomb phase stop 0");
	level notify ("bomb phase stop 0a");
	
	//wait 5;
	wait 3;
	
	thread bombardment_cycle(aSquibs1, 1);
	println("starting 1st squibs");
	
	//wait 1;
	wait 2;
	level notify ("bomb phase stop 1");
	
	thread bombardment_cycle(aSquibs2, 2);
	println("starting 2nd squibs");
	//wait 2.5;
	wait 2;

	thread bombardment_cycle(aSquibs3, 3);
	println("starting 3rd squibs");
	
	//wait 3;
	wait 1.2;
	
	level notify ("bomb phase stop 2");

	thread bombardment_cycle(aSquibs4, 4);
	println("starting 4th squibs");
	
	//wait 3;
	wait 1.5;
	
	level notify ("bomb phase stop 3");

	thread bombardment_cycle(aSquibs5, 5);
	println("starting 5th squibs");
	
	//wait 2;
	wait 1.5;
	
	level notify ("bomb phase stop 4");
	
	//wait 3;
	wait 2.5;
	
	thread bombardment_cycle(aSquibs6, 6);
	println("starting 5th squibs");
	
	level notify ("bomb phase stop 5");
	
	//wait 2;
	wait 2.5;
	
	level notify ("bomb phase stop 6");
}

bombardment_cycle(array, n)
{
	level endon ("bomb phase stop " + n);
	
	//while(1)
	//{
		for(i=0; i<array.size; i++)
		{
			//range, max_damage, min_damage, fQuakepower, iQuaketime, iQuakeradius
			array[i] thread activate_mortar_pavlov(2, 2, 0, 0.15, 0.5, 8000);
			wait 0.5 + randomfloat(0.5);
		}
		
		array = maps\_utility::array_randomize(array);
	//}
}

//*************** DIALOG AND NOTES *************//

/*

Sgt. Kamarov:


[pavlov_kamarov_rabbit] Pvt. Kovalenko, as the fastest man here, you will draw fire from their snipers.
[pavlov_kamarov_gotime] Yes, you. Alexei will cover you with the sniper rifle from here. Now go!

//--------

Pvt. Kovalenko:

[pavlov_kovalenko] Me?

//--------

Random Friendlies

[pavlov_kamarov_charge] They've got us zeroed in! We're dead men if we stay here! Everybody move up! Let's go comrades!!
[pavlov_kamarov_secure] Secure the building! Clear it out, floor by floor! 
[pavlov_randomclear0] Basement all clear!
[pavlov_randomclear1] First floor clear!
[pavlov_randomclear2] Second floor is clear!
[pavlov_randomclear3] Clear on third floor!
[pavlov_randomclear4] Fourth floor is secure!
[pavlov_randomclear5] Top floor is clear!

[pavlov_randomsearch0] Alexei! The Sergeant's looking for you!
[pavlov_randomsearch1] Comrade, regroup with Sergeant Kamarov!

[pavlov_kamarov_antitank] Alexei, my men have set up anti-tank rifles on the second and third floor! You take out the tanks, we'll stop the troops!

[pavlov_kamarov_readytank] Here they come! Ready on the anti-tank rifles!!!
[pavlov_randomantitank] Anti-tank rifles ready!!!
[pavlov_kamarov_readyguns] Machine guns!!!
[pavlov_randomguns] Machine guns ready!!!!

[pavlov_randomready0] Get ready!!!
[pavlov_randomready1] Hold this position!!!
[pavlov_randomready2] Everyone ready!!!

//FIX FIX FIX

High Priority:

- fix basement hide exploit
- fix ammo dependency: unlimited rifle box lying nearby

Low Priority:

- northwest4/hall has a doorway with conc_crouch and corner_right in the line of fire
- westhall4 has a conc_crouch that should be turned in more
- south3 corner_left and conc_crouch are too close together

*/

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

activate_mortar_pavlov (range, max_damage, min_damage, fQuakepower, iQuaketime, iQuakeradius, soundnum, roofshot)
{
	incoming_sound_pavlov(soundnum, roofshot);
	
	mortar_boom_pavlov( self.origin, fQuakepower, iQuaketime, iQuakeradius );
	
	radiusDamage ( self.origin, range, max_damage, min_damage);
}

incoming_sound_pavlov(soundnum, roofshot)
{	
	if(isdefined(roofshot))
	{
		self playsound ("bomb_incoming1");
		wait(2.237);
		level notify ("mortar can explode");
		return;
	}
	
	if (!isdefined (soundnum))
		soundnum = randomint(3) + 1;

	if (soundnum == 1)
	{
		//self playsound ("mortar_incoming1");
		self playsound ("bomb_incoming2");
		//wait (1.07 - 0.25);
		wait (0.67 - 0.25);
		//wait(2.237);
		level notify ("mortar can explode");
	}
	else
	if (soundnum == 2)
	{
		//self playsound ("mortar_incoming2");
		self playsound ("bomb_incoming2");
		wait (0.67 - 0.25);
		level notify ("mortar can explode");
	}
	else
	{
		//self playsound ("mortar_incoming3");
		self playsound ("bomb_incoming3");
		wait (1.55 - 0.25);
		level notify ("mortar can explode");
	}
}

mortar_boom_pavlov (origin, fPower, iTime, iRadius)
{
	if (!isdefined(fPower))
		fPower = 0.15;
	if (!isdefined(iTime))
		iTime = 2;
	if (!isdefined(iRadius))
		iRadius = 850;

	mortar_sound_pavlov();
	playfx ( level.altmortar, origin );
	earthquake(fPower, iTime, origin, iRadius);
}

mortar_sound_pavlov()
{
	if (!isdefined (level.mortar_last_sound))
		level.mortar_last_sound = -1;

	soundnum = 0;
	while (soundnum == level.mortar_last_sound)
		soundnum = randomint(3) + 1;

	level.mortar_last_sound	= soundnum;

	if (soundnum == 1)
		self playsound ("mortar_explosion1");
	else
	if (soundnum == 2)
		self playsound ("mortar_explosion2");
	else
		self playsound ("mortar_explosion3");
}

/*
2) Creating a subarray:

eg. Replace:
	temp = getentarray ("weapon_panzerfaust", "classname");
	for (i=0; i<temp.size; i++)
	{
		if ( (isdefined (temp[i].targetname) ) && (temp[i].targetname == "respawn") )
			weapons = maps\_utility::add_to_array ( weapons, temp[i] );
	}

with:
	temp = getentarray ("weapon_panzerfaust", "classname");
	weapons = [];
	for (i=0; i<temp.size; i++)
	{
		if ( (isdefined (temp[i].targetname) ) && (temp[i].targetname == "respawn") )
			weapons[weapons.size] = temp[i];
	}

*/

label_tankname(vehicle, tankname)
{
	vehicle endon ("death");
	
	for(;;)
	{
		if(isalive(vehicle))
		{
			print3d (vehicle.origin + (0, 0, 128), tankname, (1,1,1), 1, 4.15);	// origin, text, RGB, alpha, scale
			wait 0.05;
		}
	}
}


