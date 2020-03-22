/****************************************************************************

Level: 		PEGASUS BRIDGE DAY 
Campaign: 	British
Objectives: 	1. Hold the bridge until relieved by Allied forces. (Persistent, becomes current after objective #3 is completed.)
		2. Defend the west bank of the canal.
		3. Fall back across the bridge with the rest of the squad.
		4. Secure the area and clear out any remainng enemies.
		
*****************************************************************************/

#using_animtree("generic_human");

main()
{	
	setExpFog(0.00025, 0.6484, 0.6484, 0.6015, 0);

	//*** Mortar Hit Effects

	precacheString(&"PEGASUSDAY_REINFORCEMENTS_ARRIVING");

	level.eShellShockGroundFX = loadfx ("fx/impacts/newimps/blast_gen3.efx");
	level.eLightMortarShellFX = loadfx ("fx/impacts/newimps/blast_gen3nomark.efx");
	level.eTankShellTarget = getent("tankshelltarget","targetname");
	level.eTankShellFX = loadfx ("fx/impacts/newimps/blast_gen3nomark.efx");
	level.fireydeath = loadfx ("fx/fire/pathfinder_extreme.efx");
	level.lingerfx = loadfx("fx/smoke/oneshotblacksmokelinger.efx");
	
	//*** Campaign 
	
	level.campaign = "british";	//sets friendly names to British list
	
	aMartyrs = getentarray("martyr","targetname");
	for(n=0; n<aMartyrs.size; n++)
	{
		aMartyrs[n].script_noDeathMessage = 1;
	}
	
	//*** Load External Scripts
	
	//precacheShellshock("default");
	precacheShellshock("default_nomusic");
	
	level.nPrice = getent("price","targetname");
	level.nPrice.animname = "price";
	level.nPrice character\price::precache();
	level.nPrice character\_utility::new();
	level.nPrice character\price::main();
	
	maps\pegasusday_fx::main();
	maps\_load::main();
	maps\pegasusday_anim::main();
	maps\_tiger::main(); //precaches the models
	maps\_tiger::main_camo();
	maps\_treadfx::main(); //tread dust fx
	precachemodel("xmodel/vehicle_tank_panzeriv_machinegun");
	precachemodel("xmodel/vehicle_tank_tiger_camo_d");
	
	level.mortar = loadfx ("fx/impacts/newimps/blast_gen3nomark.efx");
	
	//*** Ambient Sound Effects Track

	level.ambient_track ["outside"] = "ambient_pegasusday";
	thread maps\_utility::set_ambient("outside");
	
	//*** Flak 88 Init
	
	eFlak88 = getent("flak_88","targetname");
	level thread flak88_init(eFlak88);
	level thread flak88_usemonitor(eFlak88);
	eFlak88 makeVehicleUnusable();	//not usable until appropriate moment

	//*** Level Variables

	level.victory = 0; 	//mark it 1 when mission is accomplished, used to cap AI population at victory time

	//Axis Squads

	level.strAlpha = "alpha";
	level.strBeta = "beta";
	level.strGamma = "gamma";
	level.strDelta = "delta";
	level.strEpsilon = "epsilon";
	level.strZeta = "zeta";
	level.strEta = "eta";
	
	//Allied Squads
	
	level.strTheta = "theta";
	level.strIota = "iota";
	level.strKappa = "kappa";
	
	/*
	level.strLambda = "lambda";
	level.strMu = "mu";
	level.strNu = "nu";
	level.strXi = "xi";
	level.strOmikron = "omikron";
	level.strPi = "pi";
	level.strRho = "rho";
	level.strSigma = "sigma";
	level.strTau = "tau";
	*/
	
	level.iStopBarrage = 0; 	//on-off switch for intro barrage
	
	//Population threshold and spawn controls
	
	level.iDoomsdayPause = 0;	//on-off switch for 'doomsday' spawning
	level.grudgemode = 0;		//on-off switch for 'doomsday' navigation
	level.fSpawnInterval = 1;	//wait between whole squad spawns
	
	//Squad navigation controls
	
	level.initDoomRadius = 1600;	//initial goalradius for doomsday mode (to player)
	level.minDoomRadius = 512;	//minimum goalradius for doomsday mode (to player)
	
	level.minSquadRadius = 512;	//minimum goalradius for normal squad advancement nodes
	level.maxSquadRadius = 2200;	//starting goalradius for normal squad advancement nodes
	
	//Time spacing of spawned troop deployment
	
	level.fBaseInterval = 0.5;		//wait at least this much time between deployments
	level.fGapInterval = 1.2;		//max random variation added to base time interval
		
	//Friendly Survival Info
	
	level.friendlyDefenseRadius = 924;
	
	//Tank speech variation checks
	
	level.tankspeech1 = 0;
	level.tankspeech2 = 0;
	level.tankspeech3 = 0;
	
	//getcvar "battle" check for wall breach
	
	level.wallbreach = 0;
	level.skipintro = 1;
	
	level.population_failsafe = 0;	//this polls for the axis population after the victory condition is notified
	
	level.victoryrally = 0;		//check for if newly spawned commandos should be rallying instead of fighting 
	
	//Battle durations and other time values
	
	if (getcvar ("start") == "battle")
	{
		setcvar ("gameplay", "testing");
	}
	else
	{
		setcvar ("gameplay", "");
	}
	
	//Spawn Settings
	
	if (getcvar ("gameplay") == "testing")
	{
		level.westDuration = 5;	//west end battle length in seconds, default 100 seconds
		level.westBaglimit = 1;	//player must kill this many in west battle
		level.stopwatch = 2;	//east end battle requisite length in minutes, replaces eastduration for this purpose
		level.eastDuration = level.stopwatch*60;	//in seconds, used to control spawns
		
		level.iRosterMax = 9;		//starting enemy troop population
		level.westPhases = 3;		//number of times to boost the enemy roster limit
		level.westBoostRate = 3; 	//number of extra guys to add to the roster limit each phase
		level.eastRosterMaxStart = 12; 	//starting enemy troop population after bridge retreat is done
		level.eastzonewaves = 2;	//number of waves that will attack a player straggling in the east zone
		level.eastzonedelay = 120;	//time in seconds before straggler check
		level.eastPhases = 3;		//number of times to boost the enemy roster limit
		level.eastBoostRate = 2;	//number of extra guys to add to the roster limit each phase
	}
	else
	{
		level.westDuration = 210;	//west end battle length in seconds, default 240 seconds
		level.westBaglimit = 12;	//player must kill this many in west battle
		level.stopwatch = 5;	//east end battle requisite length in minutes, replaces eastduration, must be at least 1.5 
		level.stopwatchmusic = level.stopwatch*60 - 84;
		level.eastDuration = level.stopwatch*60;	//in seconds, used to control spawns
		
		if (getcvarint("g_gameskill") == 0)
		{
			level.iRosterMax = 7;		//starting enemy troop population
			level.westPhases = 2;		//number of times to boost the enemy roster limit
			level.westBoostRate = 2; 	//number of extra guys to add to the roster limit each phase
			level.eastRosterMaxStart = 10; 	//starting enemy troop population after bridge retreat is done
			level.eastzonewaves = 2;	//number of waves that will attack a player straggling in the east zone
			level.eastzonedelay = 160;	//time in seconds before straggler check
			level.eastPhases = 2;		//number of times to boost the enemy roster limit
			level.eastBoostRate = 2;	//number of extra guys to add to the roster limit each phase
	
		}
		if (getcvarint("g_gameskill") == 1)
		{
			level.iRosterMax = 9;		//starting enemy troop population
			level.westPhases = 3;		//number of times to boost the enemy roster limit
			level.westBoostRate = 3; 	//number of extra guys to add to the roster limit each phase
			level.eastRosterMaxStart = 13; 	//starting enemy troop population after bridge retreat is done
			level.eastzonewaves = 2;	//number of waves that will attack a player straggling in the east zone
			level.eastzonedelay = 100;	//time in seconds before straggler check
			level.eastPhases = 3;		//number of times to boost the enemy roster limit
			level.eastBoostRate = 2;	//number of extra guys to add to the roster limit each phase
		}
		
		if (getcvarint("g_gameskill") == 2)
		{
			level.iRosterMax = 10;		//starting enemy troop population
			level.westPhases = 3;		//number of times to boost the enemy roster limit
			level.westBoostRate = 3; 	//number of extra guys to add to the roster limit each phase
			level.eastRosterMaxStart = 14; 	//starting enemy troop population after bridge retreat is done
			level.eastzonewaves = 2;	//number of waves that will attack a player straggling in the east zone
			level.eastzonedelay = 80;	//time in seconds before straggler check
			level.eastPhases = 4;		//number of times to boost the enemy roster limit
			level.eastBoostRate = 2;	//number of extra guys to add to the roster limit each phase
		}
		
		if (getcvarint("g_gameskill") == 3)
		{
			level.iRosterMax = 10;		//starting enemy troop population
			level.westPhases = 3;		//number of times to boost the enemy roster limit
			level.westBoostRate = 3; 	//number of extra guys to add to the roster limit each phase
			level.eastRosterMaxStart = 14; 	//starting enemy troop population after bridge retreat is done
			level.eastzonewaves = 2;	//number of waves that will attack a player straggling in the east zone
			level.eastzonedelay = 80;	//time in seconds before straggler check
			level.eastPhases = 4;		//number of times to boost the enemy roster limit
			level.eastBoostRate = 2;	//number of extra guys to add to the roster limit each phase
		}
	}
	
	level.westBattleTimeout = 0;	//flag for time elapsed in west battle
	
	level.fallbacknodedist = 1200; 	//dist to be considered 'across the bridge'
	
	level.northeastdelay = 3;	//delay for those pesky long wait north east tanks and Price's dialogue
	
	level.eastskirmish = 0;		//flag for forcing squad_assault to spawn over the max during west battle
	level.eastBattleTimeout = 0;	//flag for time elapsed in east battle
	
	level.bridgeassault = 0;
	level.bridgeAssaultMinTime = 15;
	level.bridgeAssaultMaxTime = 45;
	level.bridgeAssaultFrac = 0.9;
	level.bridgeAssaultMaxDist = 5200;
	level.bridgeAssaultMinDist = 1000;		
	
	level.mgtimeout = 0;		//flag for timing out the machine gun fall back usage requirement
	level.skipBackTalk = 0;
	
	//Other stuff
	
	level.activetank = 0;		//flag A for making the player invulnerable while operating the Flak gun
	level.usingflak = 0;		//flag B for making the player invulnerable while operating the Flak gun
	
	level.tankobjon = 1;	//check for end game objective formatting if tank is around
	
	level.noguys = 0;	//flag for end level conditions
	
	//Get bit part NPCs
	
	aNames = getaiarray("allies");
	
	for(i=0; i<aNames.size; i++)
	{	
		if(isdefined(aNames[i].script_namenumber))
		{
			if(aNames[i].script_namenumber == "1")
			{
				level.nBeal = aNames[i];
				level.nBeal.animname = "friend1";
			}
			if(aNames[i].script_namenumber == "2")
			{
				level.nThorne = aNames[i];
				level.nThorne.animname = "friend2";
			}
			if(aNames[i].script_namenumber == "3")
			{
				level.nWatson = aNames[i];
			}
		}
	}
	
	aNames = undefined;
	
	//Price and Davis are invulnerable for anti-player interference on intro
	
	level.nPrice thread maps\_utility::magic_bullet_shield();
	
	level.nBeal thread maps\_utility::magic_bullet_shield();
	level.nThorne thread maps\_utility::magic_bullet_shield();
	level.nWatson thread maps\_utility::magic_bullet_shield();

	level.nDavis = getent("davis","targetname");
	level.nDavis.animname = "davis";
	level.nDavis thread maps\_utility::magic_bullet_shield();
		
	level.nPrice.dontavoidplayer = true;
	level.nDavis.dontavoidplayer = true;
	
	//Friendlies don't slow down as they approach their goals
	
	aFriendlies = getaiarray("allies");
	for(s=0; s<aFriendlies.size; s++)
	{
		aFriendlies[s].walkdist = 0;
		aFriendlies[s].bravery = 50000;
		aFriendlies[s].suppressionwait = 0.5;
		aFriendlies[s].dontavoidplayer = 1;
	}
	
	//Martyrs have no name
	
	aMartyrs = getentarray("martyr", "targetname");
	for(n=0; n<aMartyrs.size; n++)
	{
		aMartyrs[n].script_noDeathMessage = 1;
	}
	
	org = spawn ("script_origin",(384, -3344, 120));
	org playloopsound ("bigfire_pegasus");
	
	//*** Threads
	
	thread objectives();
	thread intro();
	thread hideall_craters();
	thread ai_overrides();
	thread death_failsafe();
	thread music();
}


//******************************************************

intro_dialogue_extra()
{
	//DIALOG Captain Price - "Everyone, take cover!"

	level.nPrice anim_single_solo(level.nPrice, "everyonecover");
	
	//DIALOG Lieutenant Davis - "Come on, get out of there - you! Move!"
	
	level.nDavis anim_single_solo(level.nDavis, "outofthere");
}

intro()
{	
	if (getcvar ("start") != "battle")
	{
		level.skipintro = 0;
		
		//iprintlnbold("Music plays briefly at intro here.");
		
		level waittill("finished intro screen");
		
		//**********************************************//
		//		Opening Conversation		//
		//**********************************************//
		
		nDavisIntroNode = getnode("davis_intronode", "targetname");
		nPriceIntroNode = getnode("price_intronode", "targetname");
	
		//DIALOG Captain Price and Lt. Davis
		
		//They should now walk
		
		//level.gerguard1.walk_noncombatanim = %patrolwalk_tired;
		
		level.nPrice animscripts\shared::LookAtEntity(level.nDavis, 15, "alert");
		level.nDavis animscripts\shared::LookAtEntity(level.nPrice, 15, "alert");
		
		//DIALOG: "Lt. Davis: This is what we salvaged from the area, sir, mostly German weapons and medical supplies."
		//DIALOG: "Lt. Davis: The men found a few Panzerfausts for fighting tanks with, but they're not terribly accurate weapons."
		
		if (getcvar ("start") == "testflak")
		{
			eFlak88 = getent( "flak_88", "targetname" );
			eFlak88 makeVehicleUsable();
			
			while(1)
			{
				wait 1;
			}
		}
		
		level.nDavis anim_single_solo(level.nDavis, "intro", undefined, nDavisIntroNode);
		//level.nDavis anim_single_solo(level.nDavis, "intro");
		
		//DIALOG: "Thank God we still have that flak gun. We can use it to hold the bridge until our relief shows up."
		
		level.nPrice anim_single_solo(level.nPrice, "intro", undefined, nPriceIntroNode);
		//level.nPrice anim_single_solo(level.nPrice, "intro");
		
		//***** Friendly Defenders sort through arrays and run to matching mortarcover nodes
		
		aFriendlies = getentarray("defender","targetname");
	
		for(i=0; i<aFriendlies.size; i++)
		{
			aMortarcover = getnodearray("mortarcover","targetname");
			
			for(j=0; j<aMortarcover.size; j++)
			{
				if((aFriendlies[i].script_noteworthy == aMortarcover[j].script_noteworthy) && isAlive (aFriendlies[i]))
				{
					aFriendlies[i].run_combatanim = %sprint1_loop;
					aFriendlies[i] setgoalnode(aMortarcover[j]);
					aFriendlies[i].goalradius = aMortarcover[j].radius;
				}
			}
		}	
		
		//******************************************************//
		//	Mortar Bombardment prior to German attack	//
		//******************************************************//
		
		//Fake mortar barrage around player
		
			thread maps\_mortar::railyard_style(0.0654, 6000, 100, undefined, undefined, undefined, 0.18, 2, 4250);
		
		//***** Friendly Martyrs sort through arrays and die from mortar hits before they make it back
		
			thread martyr_start();
		
		//DIALOG Friendly 1 - "Incoming!"
		
			level.nBeal thread anim_single_solo(level.nBeal, "incoming");
			
			wait 0.75;
			
		//Get Price and Davis to new positions
		
			level.nPrice.dontavoidplayer = false;
			level.nDavis.dontavoidplayer = false;
		
			nPriceNodeA = getnode("pricenode_a","targetname");
			level.nPrice setgoalnode(nPriceNodeA);
			level.nPrice.goalradius = nPriceNodeA.radius;
		
			nLtNodeA = getnode("ltnode_a","targetname");
			level.nDavis setgoalnode(nLtNodeA);
			level.nDavis.goalradius = nLtNodeA.radius;
		
			thread intro_dialogue_extra();
			
			aEveryone = getaiarray("allies");
		
			for(i=0; i<aEveryone.size; i++)
			{
				aEveryone[i] thread animscripts\shared::SetInCombat();
				aEveryone[i].interval = 8;
			}
			
		//DIALOG Friendly 2 - "Take cover!"
		
			level.nThorne thread anim_single_solo(level.nThorne, "takecover");
		
		//Temp open up walls during barrage, barrage ends
		
			thread wall_breach();
			level.wallbreach = 1;	//for getcvar "battle" check
			
			wait 8;		
		
		//Blasts player if player is in the killzone after some amount of time
		
			thread player_mortar_check();
			println("CHECKING TO HIT PLAYER");
		
			wait 8;
		
			level.iStopBarrage = 1;
			println("STOPPING BARRAGE");
			
			level notify ("barrage ends");
			
		//Pre-mixed sound montage of distant tanks rolling in and german shouts
			
			level.nBeal.run_combatanim = undefined;
			level.nThorne.run_combatanim = undefined;
			level.nWatson.run_combatanim = undefined;
			
			//wait 4.7;
	}
	
	//**********************************************//
	//		West Battle Begins		//
	//**********************************************//
	
	//Begin tracking squad population and mission failure conditions 
	
		if (level.skipintro == 1)
		{
			println("Skipped to west battle.");
			level.westDuration = 10;	//west end battle length in seconds, default 100 seconds
			println("West battle is now ", level.westDuration, " seconds.");
			
			thread wall_breach();
			
			aMartyrKill = getentarray("martyr","targetname");
			for(i=0; i<aMartyrKill.size; i++)
			{
				aMartyrKill[i] delete();
			}
			
			wait 0.1;
			level notify ("objective1");
			wait 0.1;
		}
	
		thread friendly_squad_info();
		//thread mission_badscene_check();
		
	//Objectives Update
	
		level notify ("objective2");
	
	//Reposition friendlies for the opening of the west battle
	
		thread friendly_defensive_pattern();
	
	//Awol check for desertion during westzone
	
		nWestZone = getent("westzone","targetname");
		//thread objective_area_check(nWestZone);
		//thread objective_area_desertion();
	
	thread intro_final_dialogue();
		
	//Launch enemy troops, prepare second objective countdown

	thread army_group_control("westbattle");	//launches enemy troops
	thread machinegun_defense();			//prepares machine gun (objective 4)
	thread bad_places();
	thread eastzone_skirmish();			//these guys harrass the player when hanging around in the east end
	thread army_rate_boost();			//increase rate of spawning to push them back
	
	//IT'S YOUR ONLY AUTOSAVE - MAKE IT LAST
	
	maps\_utility::autosave(1);	

	//level.nDavis notify ("stop magic bullet shield");	//now he's done talking and becomes mortal
	//level.nPrice notify ("stop magic bullet shield");	
	level.nBeal notify ("stop magic bullet shield");	
	level.nThorne notify ("stop magic bullet shield");	
	level.nWatson notify ("stop magic bullet shield");
	
	thread friendly_boost();
}

intro_final_dialogue()
{
	//thread intro_german_walla();	//reenable this for german distant dialogue
	
	//DIALOG Friendly 1 - "Infantry, coming in from the west!"
	
		level.nBeal anim_single_solo(level.nBeal, "fromwest");
		wait 1.5;
	
	//DIALOG Friendly 2 - "Bloody hell, watch the right flank!"
		
		level.nThorne anim_single_solo(level.nThorne, "watchright");
		wait 1.5;
	
	//DIALOG Captain Price - "Everybody hold this position...on my command!"
		
		level.nPrice thread anim_single_solo(level.nPrice, "mycommand");
}

intro_german_walla()
{
	level endon ("fall back across bridge");
	wait 5;
	
	while(1)
	{
		maps\_utility::playSoundinSpace("generic_misccombat_german_1_walla", (1204, -4124, 60));
		wait 1;
		maps\_utility::playSoundinSpace("generic_misccombat_german_2_walla", (-208, -4001, 115));
		wait 0.5;
		maps\_utility::playSoundinSpace("generic_misccombat_german_3_walla", (380, -4167, 77));
		wait 2;
		maps\_utility::playSoundinSpace("generic_misccombat_german_1_walla", (-208, -4001, 115));
		wait 0.6;
		maps\_utility::playSoundinSpace("generic_misccombat_german_2_walla", (1204, -4124, 60));
		wait 1;
		maps\_utility::playSoundinSpace("generic_misccombat_german_3_walla", (380, -4067, 77));
		wait 2;
		maps\_utility::playSoundinSpace("generic_misccombat_german_1_walla", (-208, -4101, 115));
		wait 0.2;
		maps\_utility::playSoundinSpace("generic_misccombat_german_2_walla", (-208, -4001, 115));
		wait 0.5;
		maps\_utility::playSoundinSpace("generic_misccombat_german_3_walla", (380, -4167, 77));
		wait 3;
		maps\_utility::playSoundinSpace("generic_misccombat_german_1_walla", (-208, -4001, 115));
		wait 1;
		maps\_utility::playSoundinSpace("generic_misccombat_german_2_walla", (1204, -4124, 60));
		wait 2;
		maps\_utility::playSoundinSpace("generic_misccombat_german_3_walla", (380, -4067, 77));
		wait 2;
		maps\_utility::playSoundinSpace("generic_misccombat_german_1_walla", (-208, -4101, 115));
		wait 4;
	}
}

//******************************************************

army_rate_boost() 
{
	for(i=0; i<level.westPhases; i++)
	{
		wait (level.westDuration / level.westPhases); //generate the time interval
		level.iRosterMax = level.iRosterMax + level.westBoostRate;
		println("Boosting population max to ", level.iRosterMax);
	}
	
	level waittill ("bridgeassault");
	
	//EAST SIDE BATTLE STARTING POPULATION
	
	level.iRosterMax = level.eastRosterMaxStart; 	
	
	for(i=0; i<level.eastPhases; i++)
	{
		wait (level.eastDuration / level.eastPhases); //generate the time interval
		level.iRosterMax = level.iRosterMax + level.eastBoostRate;
		println("Boosting population max to ", level.iRosterMax);
	}
}

eastzone_skirmish()
{
	//Deploy harassing troops to attack the player if he straggles in the east end
	
	level endon ("objective3");
	
	level waittill ("west defense established");
	
	wait level.eastzonedelay;
	
	nEastZoneTrig = getent("eastzone", "targetname");
	nTimeGap = 120;
	
	println("EAST ZONE IS ARMED");
	
	for(i=0; i<level.eastzonewaves; i++)
	{
		eastzone_waiter(nEastZoneTrig);
		
		println("EAST LAUNCH AGAINST STRAGGLER");
		
		thread squad_assault(level.strEpsilon, 0.75, 1);
		eastzone_spacer();
		wait nTimeGap;
		eastzone_waiter(nEastZoneTrig);
		
		thread squad_assault(level.strZeta, 0.75, 1);
		eastzone_spacer();
		wait nTimeGap;
		eastzone_waiter(nEastZoneTrig);
		
		thread squad_assault(level.strEta, 0.75, 1);
		eastzone_spacer();
		wait nTimeGap;
		eastzone_waiter(nEastZoneTrig);
		
		thread squad_assault(level.strEpsilon, 0.75, 1);
		eastzone_spacer();
		wait nTimeGap;
		eastzone_waiter(nEastZoneTrig);
		
	}
}

eastzone_waiter(nEastZoneTrig)
{
	while(!(level.player istouching(nEastZoneTrig)))
	{
		wait 1;
	}
}

eastzone_spacer()
{
	level endon ("objective3");
	
	nPop = getaiarray("axis");
	
	while(nPop.size > level.iRosterMax)
	{
		nPop = getaiarray("axis");
		wait 5;
	}
}

army_group_control(strAttackPattern)
{
	//***** Controls enemy squad deployments
	
	level endon ("victory");
	level endon ("end army phase");
	
	if(strAttackPattern == "westbattle")
	{	
		//Initial flood
		
		thread squad_assault(level.strAlpha);
		thread squad_assault(level.strBeta);
		thread squad_assault(level.strGamma);
		thread squad_assault(level.strDelta);
		
		//Cycle spawn across western spawners
		
		while(1)
		{
			thread squad_assault(level.strBeta);
			wait(level.fSpawnInterval);
			
			thread squad_assault(level.strGamma);
			wait(level.fSpawnInterval);
			
			thread squad_assault(level.strAlpha);
			wait(level.fSpawnInterval);
			
			thread squad_assault(level.strDelta);
			wait(level.fSpawnInterval);
			
			thread squad_assault(level.strGamma);
			wait(level.fSpawnInterval);
			
			thread squad_assault(level.strAlpha);
			wait(level.fSpawnInterval);
			
			thread squad_assault(level.strDelta);
			wait(level.fSpawnInterval);
			
			thread squad_assault(level.strGamma);
			wait(level.fSpawnInterval);
			
			thread squad_assault(level.strBeta);
			wait(level.fSpawnInterval);
		}
	}
	
	if(strAttackPattern == "eastbattle")
	{
		//Initial flood
		
		thread squad_assault(level.strEpsilon);
		thread squad_assault(level.strZeta);
		thread squad_assault(level.strEta);
		thread squad_assault(level.strEpsilon);
		
		//Cycle spawn across eastern spawners
		
		while(1)
		{
			thread squad_assault(level.strEta);
			wait(level.fSpawnInterval);
			thread squad_assault(level.strZeta);
			wait(level.fSpawnInterval);
			thread squad_assault(level.strEta);
			wait(level.fSpawnInterval);
			thread squad_assault(level.strEpsilon);
			wait(level.fSpawnInterval);
			thread squad_assault(level.strEta);
			wait(level.fSpawnInterval);
			thread squad_assault(level.strZeta);
			wait(level.fSpawnInterval);
			thread squad_assault(level.strEpsilon);
			wait(level.fSpawnInterval);
			thread squad_assault(level.strEta);
			wait(level.fSpawnInterval);
		}
	}
}

//******************************************************

//Countdown for west end defense, Captain gives orders when player is around, 
//Then player optionally covers with machine gun as guys fall back to east end
//Friendlies will eventually fall back regardless of player's actions

west_battle_checks()
{
	//Player baglimit = X kills;
	//Survival timelimit = X minutes;
	//Sends victory notification when both are satisfied.

	thread west_battle_timer();

	i = 0;
	
	while(i<level.westBaglimit)
	{
		level waittill ("enemy killed west");
		i++;
		println("WEST BAGLIMIT IS NOW ", i);
	}
	
	println("West BAGLIMIT reached at ", i);

	while(!level.westBattleTimeout)
	{
		wait 1;
	}

	level notify ("west battle complete");
}

west_battle_timer()
{
	//Countdown and flag completion of time requirement 

	wait (level.westDuration/2);
	
	ratio = level.player.health/level.player.maxhealth;
	ratiolimit = 0.6;
	println("Health percentage at ", ratio*100, " percent.");
	
	if(ratio >= ratiolimit)
	{
		maps\_utility::autosave(2);
	}
	
	wait (level.westDuration/2);
	
	level.westBattleTimeout = 1;
}

machinegun_defense()
{		
	thread west_battle_checks();
	
	level waittill ("west battle complete");	//west baglimit must be reached AND west time must have elapsed
	
	if(isAlive(level.nPrice))
	{	
		//Price gives orders when player is in the area and in shouting range
		
		nLocationChecker = getent("westzone","targetname");
		
		thread machinegun_area_check(nLocationChecker);	//Captain Price tries to reach the player and give new orders
		thread machinegun_captain();	//speech activates, notifies "machinegun_continue"
		
		level waittill("machinegun_continue");
		
		aFriendlies = getaiarray("allies");
		
		level.bridgetally = aFriendlies.size;	//use to keep track of how many of the friendly squad have made it across the bridge
		
		for(i=0; i<aFriendlies.size; i++)
		{
			println("Heading to pre-retreat rallypoint");
			level thread machinegun_retreat(aFriendlies[i]);
			level thread machinegun_deathwaiter(aFriendlies[i]);
		}		
		
		thread bridge_retreat();
		thread machinegun_armed();
		//thread machinegun_armed_timeout();
		thread machinegun_complete();
	}
	
	wait 3;
	
	if(isdefined(level.nPrice) && isalive(level.nPrice))
	{
		//DIALOG Captain Price - "Fall back across the bridge! Sergeant Evans! Get back to the machine gun and cover us!!"
	
		nHutMG42 = getent("hut_mg42","targetname");
		nHutMG42user = nHutMG42 getTurretOwner();
	
		if(!isdefined(nHutMG42user))
		{
			level.nPrice anim_single_solo(level.nPrice, "fallback");
		}
	}
	
	level notify ("objective3");
}

//-----------------------------------------

machinegun_area_check(zone)
{	
	while(1)
	{
		if(level.player istouching(zone))
		{
			//set followmin larger than followmax for Barney behavior
			
			level.nPrice.ignoreme = true;
		
			level.nPrice.followmin = 600;
			level.nPrice.followmax = 200;
			level.nPrice setgoalentity(level.player);
			level.nPrice.goalradius = 512;
			
			//continue only if Price is within range of the player
			
			dist = length(level.nPrice.origin - level.player.origin);
			if(dist <= 512)
			{
				break;
			}
		}
		else
		{
			//otherwise keep polling with soft wait
			
			wait 2;
			
			level.mgtimeout++;
			 
			if(level.mgtimeout == 5)	//player is not in zone but has achieved baglimit and timelimit
			{
				level.skipBackTalk = 1;
				break;
			}
			 
			level.nPrice.ignoreme = false;
			
			nPriceDefNode = getnode("defensePrice","targetname");
			level.nPrice setgoalnode(nPriceDefNode);
			level.nPrice.goalradius = 800;
		}
		
		wait 0.05;
	}
	
	if(level.skipBackTalk == 1)
	{
		println("Captain is in range and player is in valid area.");
	}
	
	wait 0.05;
	
	level notify ("regroup men");
}

machinegun_captain()
{
	level.nPrice endon("death");
	
	level waittill ("regroup men");
	
	println("I'm looking at you Sergeant Evans!!!");
	
	level.nPrice animscripts\shared::LookAtEntity(level.player, 12, "alert");	
	
	if(isdefined(level.nPrice) && isalive(level.nPrice))
	{
		println("I'm TALKING TO YOU RIGHT NOW!");
		
		//DIALOG Captain Price - "Regroup, men! Back to the bridge! Fall back to the bridge! Let's go!"
		level.nPrice anim_single_solo(level.nPrice, "regroup");		
	}
	
	level notify ("machinegun_continue");
	
	level.nPrice.ignoreme = false;
}

//-----------------------------------------

machinegun_armed()
{
	//Checks to see if the player is on the MG42. 
	
	nHutMG42 = getent("hut_mg42","targetname");
	nHutMG42user = nHutMG42 getTurretOwner();
	
	while(1)
	{
		if((isdefined(nHutMG42user) && level.player != nHutMG42user) || !isdefined(nHutMG42user))
		{
			nHutMG42 waittill("turretownerchange");
			nHutMG42user = nHutMG42 getTurretOwner();
		}
		else
		{
			break;
		}
	}
	
	level notify ("everyone falls back");
}

bridge_retreat()
{
	level waittill ("everyone falls back");
	
	level notify ("delete badplace1"); 	//open up all of the west end
	thread bridgeassault();
	
	while(level.bridgetally > 0)
	{
		level notify ("fall back across bridge");
		wait 0.5;
	}
}
	
machinegun_retreat(nSoldier)
{
	nSoldier endon ("death");

	//wait 8;

	nRegroupNode = getnode("regroupingnode","targetname");
	level attack_move_node(nSoldier, 0.5, 2.5, 0.85, nRegroupNode, 800);	//waitthread
	
	nSoldier allowedStances ("crouch", "prone");
	
	//println("I'M IN POSITION, READY TO FALL BACK!!!");
	
	level waittill("fall back across bridge");
	
	wait (randomfloatrange(1,3));	//natural staggering
	
	//println("I'M FALLING BACK, COVER ME!!!.");

	nRallyNode = getnode("bridgerallypoint","targetname");
	level attack_move_node(nSoldier, 0.5, 2.5, 0.85, nRallyNode, 2300);	//waitthread
	
	level.bridgetally--;
	
	nSoldier allowedStances ("stand", "crouch", "prone");
	
	nSoldier.goalradius = 1700;
	println("I MADE IT ALL THE WAY ACROSS. REMAINING: ", level.bridgetally);
}

machinegun_deathwaiter(nFriendly)
{
	nFriendly waittill("death");
	wait 0.5;
	level.bridgetally--;
}

machinegun_complete()
{
	//level endon ("victory");
	
	while(level.bridgetally > 0)
	{
		wait 0.1;
	}

	nRallyPoint = getnode("bridgerallypoint", "targetname");
	dist = length(nRallyPoint.origin - level.player.origin);
	
	while(dist > level.fallbacknodedist)
	{
		dist = length(nRallyPoint.origin - level.player.origin);	
		wait 0.1;
	}

	level notify ("objective final");
	
	//level.player.threatbias = 1000;
	
	thread final_battle_prep();
}

//***************************************************

final_battle_prep()
{	
	level notify ("end army phase");	//stop the west spawning
	level notify ("east battle and stopwatch begin");
	
	thread army_group_control("eastbattle");	//start eastern spawners
	
	maps\_utility::autosave(3);	
	
	level notify ("start flak monitor");
	thread flak88_useshield();
	thread tank_autodestruct();
	thread tank_death_autosave();
	thread final_battle_friendlies();
	
	thread final_battle_checks();
	thread victory_population_failsafe();
	thread victory_tankpop_failsafe();
}

final_battle_friendlies()
{
	if(isAlive(level.nDavis))
	{
		level.nDavis.health = 600;
		level.nDavis.accuracy = 0.96;
		level thread friendly_shield(level.nDavis);
	}
}

final_battle_checks()
{
	//Player baglimit = X kills;
	//Survival timelimit = X minutes;
	//Sends victory notification when both are satisfied.
	
	thread final_battle_timer();
	
	i = 0;
	
	while(!level.eastBattleTimeout)
	{
		wait 1;
	}
	
	level notify ("objectives complete");
}

final_battle_timer()
{
	//Countdown and flag completion of time requirement 
	
	objective_stopwatch();
	level.eastBattleTimeout = 1;
}

baglimit(nSoldier, side)
{
	//Notifies any time an enemy dies to track how many are killed by the player
	
	nSoldier waittill ("death", nAttacker);
	if(isdefined(nAttacker) && nAttacker == level.player && side == "west")
	{
		level notify ("enemy killed west");
	}
	else
	if(isdefined(nAttacker) && nAttacker == level.player && side == "east")
	{
		level notify ("enemy killed east");
	}
}

//=======================================================================================================================================================//
//=======================================================================================================================================================//

//******************************************************//
//		INFANTRY COMBAT UTILITIES		//
//******************************************************//

/*******************

Squads (groups) of enemy troops come out from their spawn locations. Troops in squads spawn simultaneously and take slightly different routes at slightly 
offset start times to destination areas in sequence - terms like contact, entry, and capture are purely jargon, functionally equivalent to start, middle, end.

The soldiers "attack_move" from one goalnode to the next. Each destination has a steadily shrinking goal radius that pulls the AI in at some set rate. 
They are less likely to mindlessly run to their goal and are more likely to fight towards it in a more believable way. 

The squad's attack is complete when its remaining soldiers have started towards the 'capture' position. They defend the capture area until killed, or receive
some other orders. The navigation sequence is controlled from squad_move.

Squad spawning is called by a single function call passing a unique script_squadname as a level-wide variable.

Nodes per squad:

squad_route (many, required)
squad_entry (many, optional)
squad_contact (many, optional)
squad_capture (one, required)

1. turn on squad spawn (call assault thread)
2. pass the desired script_squadname to the squad_assault thread
3. getspawnerarray on squad spawners 
4. choose spawners with specified squadname only
5. spawn the guys
6. array the guys for individual specification
7. array the squad_route nodes
8. referring to array entries of the guys and route nodes, run the guys through the course of their journey with calls to attack_move_node

********************/

squad_assault(strSquadName, iAxisAcc, nEastskirmish)
{	
	level endon ("victory");
	
	//Create blank arrays
	
	aSpawner = [];		//sort for roster	
	aSquadNodeSort = [];	//sort from route nodes
	aSquadRoster = [];	//soldiers in the specified squad
	aSquadRoutes = [];	//all squad route nodes
	aSquadContact = [];	//all contact nodes
	aSquadEntry = [];	//all entry nodes
	aSquadCapture = [];	//all capture nodes
	
	aSquadContactNodes = [];
	aSquadEntryNodes = [];
	
	if(!isdefined(strSquadName))
	{
		thread maps\_utility::error("You need to specify a squadname string.");
	}
	if(!isdefined(iAxisAcc))
	{
		iAxisAcc = 0.06;		//accuracy of spawned axis troops
	}
	if(!isdefined(nEastskirmish))
	{
		nEastskirmish = 0;		//means this AI will not count whatsoever for any of the fraglimits, it's to give a straggler something to do
	}
	
	//***** Create roster for specified squad
	
	aSpawner = getspawnerarray();	
	
	for(i=0; i<aSpawner.size; i++)
	{	
		//Check and don't spawn troops over the max number of enemies (before victory) or friendlies (at victory) allowed in the level
		
		aArmyRoster = getaiarray("axis");
		nBodyCount = aArmyRoster.size;
		if(level.victory == 1)
		{
			aFriendRoster = getaiarray("allies");
			nBodyCount = aFriendRoster.size + aArmyRoster.size;
		}
		
		//Force east spawning if this is to skirmish a straggler during the west end battle
		
		if(nEastskirmish == 1)
		{
			nBodyCount = level.iRosterMax - 1;
		}
		
		if(isdefined (aSpawner[i].script_squadname) && (aSpawner[i].script_squadname == strSquadName) && (nBodyCount < level.iRosterMax))
		{
			aArmyRoster = undefined;
			
			println("Spawning Group ", strSquadName, " Soldier ", i);
			nSoldier = aSpawner[i] doSpawn();	
			
			if(isdefined (nSoldier))
			{
				nSoldier.targetname = strSquadName;
				nSoldier.interval = 96;	
				nSoldier.suppressionwait = 0.01;
				nSoldier.bravery = 50000;
				if(nSoldier.team == "axis")
				{	
					if(nSoldier.targetname == "alpha" || nSoldier.targetname == "beta" || nSoldier.targetname == "gamma" || nSoldier.targetname == "delta")
					{
						side = "west";
					}
					else
					{
						side = "east";
					}
					
					if(nEastskirmish != 1)
					{
						level thread baglimit(nSoldier, side);
					}
				}
				
				if(nSoldier.team == "allies")
				{
					nSoldier.accuracy = 1;
				}

				//aSquadRoster = maps\_utility::add_to_array(aSquadRoster, nSoldier);							
				aSquadRoster[aSquadRoster.size] = nSoldier;
			}
			
			aSpawner[i].count = 50;	//reset spawn limit, never run out
		}	
	}
	
	aSpawner = undefined;	
	
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
	
	for(i=0; i<aSoldiers.size; i++)
	{
		if(isdefined (aSoldiers[i]))
		{	
			aSoldiers[i].script_moveoverride = 1;
		
			aSoldiers[i] setgoalnode(aRoutes[randomint(aRoutes.size)]);	//random routes, sequential guys
		
			if(isalive (aSoldiers[i]))
			{
				level thread squad_move(aSoldiers[i], aContactNodes, aEntryNodes, nCaptureNode);	//movement orders
				level thread squad_bridgeassault(aSoldiers[i]);	//new orders when bridgeassault is activated
			}
		
			wait (level.fBaseInterval + randomfloat(level.fGapInterval));	//random natural pause between individual soldier deployments
		}
	}
}

squad_move(nSoldier, aContactNodes, aEntryNodes, nCaptureNode)
{
	//Wait for soldier to reach route node
	nSoldier endon ("death");
	
	if(isdefined(nSoldier.team) && nSoldier.team == "allies")
	{
		level endon ("rally with Price");
	}
	
	if(isdefined(nSoldier.team) && nSoldier.team == "axis")
	{
		level endon ("victory");
	}
	
	//Catch any newly spawned reinforcements if debrief rally is already underway

	if(level.victoryrally == 1 && nSoldier.team == "allies")
	{
		wait 1;
		nCommandoNode = level.aCommandoNodes[randomint(level.aCommandoNodes.size)];
		level.aCommandoNodes = maps\_utility::subtract_from_array(level.aCommandoNodes, nCommandoNode);
		println("COMMANDO NODES REMAINING: ", level.aCommandoNodes.size);
		
		aFinalAllies = getaiarray("allies");
		for(i=0; i<aFinalAllies.size; i++)
		{
			if(isdefined(aFinalAllies[i].script_commonname) && aFinalAllies[i].script_commonname == "hero" || aFinalAllies[i] == level.nPrice)
			{
				aFinalAllies = maps\_utility::subtract_from_array(aFinalAllies, aFinalAllies[i]);		
			}
		}
		
		println("THERE ARE THIS MANY COMMANDOS IN THE LEVEL: ", aFinalAllies.size);
			
		nSoldier setgoalnode(nCommandoNode);
		nSoldier.dontavoidplayer = 1;
		nSoldier.goalradius = 8;
		nSoldier thread animscripts\shared::SetInCombat(false);
		return;
	}
	
	nSoldier waittill("goal");

	//If doomsday mode is off, attack by nodes normally

	if(level.grudgemode != 1)
	{
		//Send soldier to random entry node if any
	
		if(aEntryNodes.size > 0)
		{
			nRndEntryNode = aEntryNodes[randomint(aEntryNodes.size)];			
			
			if((nSoldier.targetname == "alpha" || nSoldier.targetname == "beta" || nSoldier.targetname == "gamma" || nSoldier.targetname == "delta") && nSoldier.team == "axis" && !level.bridgeassault)
			{
				level attack_move_node(nSoldier, 2.5, 3.5, 0.8, nRndEntryNode, undefined, 300);
			}
			else
			if((nSoldier.targetname == "epsilon" || nSoldier.targetname == "zeta") && nSoldier.team == "axis")
			{
				level attack_move_node(nSoldier, 2.5, 3.5, 0.8, nRndEntryNode, undefined, 300);
			}
			else
			if((nSoldier.targetname == "eta") && nSoldier.team == "axis")
			{
				level attack_move_node(nSoldier, 5, 8, 0.7, nRndEntryNode, undefined, 600);
			}
			else
			if(nSoldier.team == "axis")
			{
				level attack_move_node(nSoldier, 2.5, 3.5, 0.8, nRndEntryNode, undefined, 300);
			}
			
			if(nSoldier.team == "allies")
			{
				level attack_move_node(nSoldier, 0.25, 0.8, 0.8, nRndEntryNode, undefined, 300);
			}
		}
	
		//Send soldier to contact zone
	
		if(aContactNodes.size > 0)
		{
			nRndContactNode = aContactNodes[randomint(aContactNodes.size)];
			if((nSoldier.targetname == "alpha" || nSoldier.targetname == "beta" || nSoldier.targetname == "gamma" || nSoldier.targetname == "delta") && nSoldier.team == "axis" && !level.bridgeassault)
			{
				level attack_move_node(nSoldier, 2.4, 3.5, 0.96, nRndContactNode, undefined, 320);
			}
			else
			if((nSoldier.targetname == "epsilon" || nSoldier.targetname == "zeta") && nSoldier.team == "axis")
			{
				level attack_move_node(nSoldier, 2.5, 3.5, 0.8, nRndEntryNode, undefined, 300);
			}
			else
			if((nSoldier.targetname == "eta") && nSoldier.team == "axis")
			{
				level attack_move_node(nSoldier, 5, 8, 0.7, nRndContactNode, undefined, 600);
			}
			else
			if(nSoldier.team == "axis")
			{
				level attack_move_node(nSoldier, 2.4, 3.5, 0.96, nRndContactNode, undefined, 320);
			}
			
			if(nSoldier.team == "allies")
			{
				level attack_move_node(nSoldier, 1.8, 2.1, 0.9, nRndContactNode, undefined, 320);
			}
		}
		
		//Send soldier to capture point
		
		if((nSoldier.targetname == "alpha" || nSoldier.targetname == "beta" || nSoldier.targetname == "gamma" || nSoldier.targetname == "delta") && nSoldier.team == "axis" && !level.bridgeassault)
		{
			level attack_move_node(nSoldier, 3.3, 4.5, 0.95, nCaptureNode, undefined, 512);
		}
		else
		if((nSoldier.targetname == "epsilon" || nSoldier.targetname == "zeta") && nSoldier.team == "axis")
		{
			level attack_move_node(nSoldier, 2.5, 3.5, 0.8, nRndEntryNode, undefined, 300);
		}
		else
		if((nSoldier.targetname == "eta") && nSoldier.team == "axis")
		{
			level attack_move_node(nSoldier, 5, 8, 0.7, nRndEntryNode, undefined, 600);
		}
		else
		if(nSoldier.team == "axis")
		{
			level attack_move_node(nSoldier, 3.3, 4.5, 0.95, nCaptureNode, undefined, 512);
		}
		
		if(nSoldier.team == "allies")
		{
			level attack_move_node(nSoldier, 5, 7, 0.9, nCaptureNode, undefined, 2612);
		}
		
		if(!level.bridgeassault)
		{
			level waittill ("bridgeassault");
		}
		
		//Special bridgeassault case for Axis in west zone squads
		
		if((nSoldier.targetname == "alpha" || nSoldier.targetname == "beta" || nSoldier.targetname == "gamma" || nSoldier.targetname == "delta") && nSoldier.team == "axis")
		{	
			//Send axis soldier across the bridge when ready (SPECIAL DESTINATION NODE, NON-STANDARD FOR SQUAD_MOVE)

			level thread squad_bridgeassault(nSoldier, 1);
		}
	}
	
	//If doomsday mode is on, just attack the player
	
	if(level.grudgemode == 1)
	{
		level thread doomsdayNav(nSoldier);
	}
}

squad_bridgeassault(nSoldier, active)
{
	nSoldier endon ("death");
	
	if(!isdefined(active))
	{
		level waittill ("bridgeassault");
	}
	
	wait 0.5;
	
	if((nSoldier.targetname == "alpha" || nSoldier.targetname == "beta" || nSoldier.targetname == "gamma" || nSoldier.targetname == "delta") && nSoldier.team == "axis")
	{	
		//Send axis soldier across the bridge when ready (SPECIAL DESTINATION NODE, NON-STANDARD FOR SQUAD_MOVE)

		println("German soldier attacking the bridge directly.");
		nBridgeNode = getnode("bridgerallypoint","targetname");
		
		level attack_move_node(nSoldier, level.bridgeAssaultMinTime, level.bridgeAssaultMaxTime, level.bridgeAssaultFrac, nBridgeNode, level.bridgeAssaultMaxDist, level.bridgeAssaultMinDist); 		
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
	
	level endon ("rally with Price");
	level endon ("victory");
	
	nSoldier endon("death");
	
	if(!isdefined(nGoalNode))
	{
		maps\_utility::error("Missing a goal node.");
	}
	if(isdefined(nGoalNode.radius) && !isdefined(fStartRadius))
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
	
	println("Soldier's fStartRadius = ", fStartRadius);
	
	while(nSoldier.goalradius > fDestRadius)
	{
		wait (randomfloatrange(fWaitMin,fWaitMax));
		nSoldier.goalradius = nSoldier.goalradius * fClosureRate;
		nSoldier waittill("goal");	
	}
	
	if(isalive(nSoldier) && nSoldier.team == "axis" && isdefined(nSoldier.script_namenumber) && nSoldier.script_namenumber == "leftover guy")
	{
		nSuicideNode = getnode("bridgerushnode", "targetname");
		level thread attack_move_node(nSoldier, 15, 30, 0.965, nSuicideNode, 2200);
		println("LEFTOVER GUY IS MOVING TO FINAL DESTINATION ON BRIDGE");
	}
	
	println("nSoldier.", nSoldier.targetname, " is moving to the next objective.");
}

//***************************************************

bad_places()
{
	nNode1 = getnode("badplace1","targetname");
	badplace_cylinder("nBadPlace1", -1, nNode1.origin, nNode1.radius, 512, "axis");
	
	badplace_cylinder("badplaceallied1", -1, (106, -800, 68), 64, 512, "allies");
	badplace_cylinder("badplaceallied2", -1, (456, -800, 68), 64, 512, "allies");
}

bridgeassault()
{
	println("Bridgeassault ENGAGED!");
	
	level.bridgeassault = 1;
	
	while(1)
	{
		level notify ("bridgeassault");	//push all axis forces up to the bridge
		wait 1;
	}
}


//**********************************************//
//		FLAK GUN UTILITIES		//
//**********************************************//

flak88_init(nFlak)
{
	nFlak thread maps\_flak::flak88_playerinit();
	level thread flak88_life(nFlak);
	level thread flak88_kill(nFlak);
	level thread flak88_shoot(nFlak);
	level thread flak88_panzerfausthint(nFlak);
}

flak88_panzerfausthint(nFlak)
{
	nFlak waittill ("death");
	
	if (getcvarint("g_gameskill") == 0 || getcvarint("g_gameskill") == 1)
	{
		for(i=0; i<2; i++)
		{
			iprintlnbold(&"SCRIPT_USE_THE_PANZERFAUST_ANTITANK");	//prints a hint to get a panzerfaust if the flak88 is killed
			wait 16;
		}
	}
}

flak88_life(nFlak)
{
	nFlak endon("death");
	
	nFlak.isalive = 1;
	nFlak.health  = 25000000;	//otherwise, the random mortars at the start sometimes kill the flak
	
	level waittill ("objective final");
	
	eFlak88 = getent( "flak_88", "targetname" );
	eFlak88 makeVehicleUsable();
	
	//nFlak makeVehicleUsable();	//now the player can use this gun
	nFlak.health = 250;
}

flak88_kill(nFlak)
{
	nFlak.deathmodel = "xmodel/turret_flak88_d";
	nFlak.deathfx    = loadfx( "fx/explosions/explosion1.efx" );
	nFlak.deathsound = "explo_metal_rand";

	maps\_utility::precache( nFlak.deathmodel );

	nFlak waittill( "death", attacker );
	
	level.usingflak = 0;

	nFlak.isalive = 0;
	
	nFlak setmodel( nFlak.deathmodel );
	nFlak playsound( nFlak.deathsound );
	nFlak clearTurretTarget();
	
	playfx( nFlak.deathfx, nFlak.origin );
	
	level thread radius_damage(nFlak, 320, 750, 650); 	//nObject, range, maxdamage, mindamage
	
	earthquake( 0.25, 3, nFlak.origin, 1050 );
}

flak88_shoot(nFlak)
{	
	while( nFlak.isalive == 1 )
	{
		nFlak waittill( "turret_fire" );
		nFlak FireTurret();
		wait 1;
		nFlak playsound ("flak_reload");
	}
}

flak88_useshield()
{
	while(1)
	{
		if(level.activetank == 1 && level.usingflak == 1 && level.friendlypop > 0)
		{
			level.player.ignoreme = 1;
			println("TANK ACTIVE and FLAK IN USE - ignoring player!!!");
		}
		else
		{
			wait 2;	//so they don't destroy the player the moment he gets off the flak88 and a tank is dead
			level.player.ignoreme = 0;
			println("TANK IS DEAD and or FLAK IS NOT IN USE - aware of player!!!");
		}
		
		wait 0.25;
	}
}

flak88_usemonitor(eFlak88)
{
	eFlak88 endon ("death");
	
	level waittill ("start flak monitor");
	
	while(1)
	{
		eFlak88user = eFlak88 getVehicleOwner();	
		if(isdefined(eFlak88user))
		{
			level.usingflak = 1;
		}
		else
		{
			level.usingflak = 0;
		}
		
		wait 0.25;
	}
}

//**************************************//
//		TANK UTILITIES		//
//**************************************//

#using_animtree( "panzerIV" ); 

/********

Tanks spawn once per route, in random order, but not from the same area twice in a row, unless all other routes have been used up. There are three areas which are 
at corners of the map. Some areas have more than one tank route emerging, some only have one route. They attack one at a time. When one is killed, the next one 
enters after some time has passed. This cycle continues until the pool of tanks, equal to the number of routes, is exhausted. The tanks do not fire at the Flak 88 
until they have reached their firing positions. En route, they use their forward MG42. When they reach the end of their routes, they 
fire at the Flak 88, which destroys the Flak 88 in one shot and causes the mission to fail. 

*********/

tank_assault()
{	
	level endon ("stoptanks");
	level endon ("victory");
	
	aTankStart = getVehicleNodeArray ("tankstart","targetname");	
	
	while (aTankStart.size >= 1)
	{	
		while(1)
		{
			nPath = aTankStart[randomint(aTankStart.size)];		//pick a new tank starting node	from the current array size
			
			if (!isdefined (nLastGroup))				//if a repeatable area has been used, continue
			{
				break;
			}
			if (isdefined (nPath.script_noteworthy))		//if node is from non-repeatable spawn area, break
			{
				
				//********************************
				
				//Worst Case Scenario For Loop
				
				//This for loop checks all available nodes in the event that the only remaining node is a consecutive repeatable area node
				
				nBreaker = true;				//set true
				
				for(i=0; i<aTankStart.size; i++)				//cycle through all start nodes remaining in the array
				{
					if (!isdefined (aTankStart[i].script_noteworthy))	//if node is from non-repeatable spawn area, set false
					{
						nBreaker = false;				
					}
					else
					if (aTankStart[i].script_noteworthy != nLastGroup)	//if node from repeating area is not consecutive, set false
					{
						nBreaker = false;
					}
				}	
				
				//********************************
				
				if (nBreaker)	//if true - if no nodes are available from non-rpt areas, and node is consecutive, it's the last one, so break
				{		//if false - skips over this because there are still other non-consecutive usable nodes in the array		
					break;
				}
				
				if (nPath.script_noteworthy != nLastGroup)	//if node from repeating area is not repeating, break
				{
					break;
				}
			}
			else	
			{			
				break;
			}
			
			wait 0.05;
		}
					
		if (isdefined (nPath.script_noteworthy)) 	//if node is from a repeatable area, repeatable area is marked as used
		{
			nLastGroup = nPath.script_noteworthy;
		}
		else
		{
			nLastGroup = undefined;
		}
		
		//Tank is now allowed to spawn and move out from the randomly chosen and approved node
		
		level.tanksource = nPath.script_noteworthy;
		tank_spawn(nPath);	//waitthread		
		println("Next tank coming up...");			
		aTankStart = maps\_utility::subtract_from_array(aTankStart, nPath);
	}
	
	//println("All tanks destroyed!");
	
	level notify ("objectives_finish");
}

tank_troop_reset(eTank)
{
	eTank waittill ("death");
	
	level endon ("the end");
	
	aAllies = getaiarray("allies");
	
	nRallyPoint = getnode("bridgerallypoint", "targetname");
	
	for(i=0; i<aAllies.size; i++)
	{
		if((isdefined(aAllies[i].script_commonname) && aAllies[i].script_commonname == "hero") || aAllies[i] == level.nPrice)
		{
				aAllies[i] setgoalnode(nRallyPoint);
				aAllies[i].goalradius = 1400;
		}
	}
}

tank_troop_evasion(eTank)
{
	eTank endon ("death");
	
	aAllies = getaiarray("allies");
	
	if(level.tanksource == "doublezone")
	{
		aSouthWestNodes = getnodearray("southwestshelter", "targetname");
		
		for(i=0; i<aAllies.size; i++)
		{
			if((isdefined(aAllies[i].script_commonname) && aAllies[i].script_commonname == "hero") || aAllies[i] == level.nPrice)
			{
				aAllies[i] setgoalnode(aSouthWestNodes[i]);
				aAllies[i].goalradius = 32;
			}
		}
	}
	
	if(level.tanksource == "twoway")
	{
		aSouthNodes = getnodearray("southshelter", "targetname");
		
		for(i=0; i<aAllies.size; i++)
		{
			if((isdefined(aAllies[i].script_commonname) && aAllies[i].script_commonname == "hero") || aAllies[i] == level.nPrice)
			{
				aAllies[i] setgoalnode(aSouthNodes[i]);
				aAllies[i].goalradius = 32;
			}
		}
	}
	
	if(level.tanksource == "threeway")
	{
		aNorthNodes = getnodearray("northshelter", "targetname");
		
		for(i=0; i<aAllies.size; i++)
		{
			if((isdefined(aAllies[i].script_commonname) && aAllies[i].script_commonname == "hero") || aAllies[i] == level.nPrice)
			{
				aAllies[i] setgoalnode(aNorthNodes[i]);
				aAllies[i].goalradius = 32;
			}
		}
	}
}

tank_mg42_delayfire(eTank)
{
	eTank endon ("death");
	
	if(level.tanksource == "doublezone")
	{
		//Southwest tanks 
		wait 20; 	
	}
	else
	if(level.tanksource == "twoway")
	{
		//South Southeast tanks
		wait 15;
	}
	else
	if(level.tanksource == "threeway")
	{
		wait 35;
	}
	
	if(isalive(eTank))
	{
		eTank thread maps\_tankgun::mgon();
	}
}

tank_spawn(eStartNode)
{
	eTank = spawnVehicle( "xmodel/vehicle_tank_tiger_camo", "tank", "tiger", (0,0,0), (0,0,0) );	//model, targetname, type, origin, angles
	
	level.activetank = 1;
	
	eTank.script_team = "axis";
	
	eTank thread maps\_treads::main();
	
	eTank thread maps\_tankgun::mginit();
	eTank thread maps\_tankgun::mgoff();
	
	level thread tank_mg42_delayfire(eTank);
	
	eTank.mgturret setTurretAccuracy(0.1);
	
	thread tank_mg42_accuracymod(eTank);
	
	thread tank_init(eTank);	
	thread tank_kill(eTank);	
	thread tank_smoke(eTank);
	eTank thread maps\_tiger::kill();
	thread tank_speech(eTank);
	thread tank_objective_reset(eTank);
	thread tank_objective_update(eTank);
	
	eTank attachPath(eStartNode);
	
	thread tank_troop_evasion(eTank);
	thread tank_troop_reset(eTank);
	
	thread tank_target(eTank, eStartNode);
	tank_status(eTank); 	//waitthread
}

tank_mg42_accuracymod(eTank)
{
	eTank endon ("death");
	
	while(1)
	{
		guntarget = eTank.mgturret getTurretTarget();
		
		if(isdefined(guntarget) && (guntarget == level.nPrice || guntarget == level.nDavis))
		{
			println("Tank hull MG42 is targeting ", guntarget);
			eTank.mgturret setTurretAccuracy(0);
		}
		else
		{
			println("Tank hull MG42 is targeting ", guntarget);
			eTank.mgturret setTurretAccuracy(0.1);
		}
		
		wait 1;
	}
}

tank_speech(eTank)
{
	//DIALOG Captain Price
	//Speech clue hints from Captain Price as to where the tanks are coming from
	
	eTank endon("death");
	
	wait 4;
	
	if(level.tanksource == "doublezone")
	{
		if(isdefined(level.nPrice) && isalive(level.nPrice))
		{
			if(level.tankspeech1 == 0)
			{
				for(i=0; i<2; i++)
				{
					//DIALOG Captain Price - "TANK TO THE SOUTHWEST ACROSS THE CANAL!!!! SERGEANT EVANS, TAKE IT OUT!!!"
					level.nPrice anim_single_solo(level.nPrice, "southwest1");
					level.tankspeech1 = 1;
					wait 5;
				}
			}
			else
			{	
				//DIALOG Captain Price - "THERE'S ANOTHER TANK TO THE SOUTHWEST!"
				
					level.nPrice anim_single_solo(level.nPrice, "southwest2");
					wait 5;
				
				//DIALOG Captain Price - "TANK TO THE SOUTHWEST ACROSS THE CANAL!!!! SERGEANT EVANS, TAKE IT OUT!!!"
				level.nPrice anim_single_solo(level.nPrice, "southwest1");
			}
		}
	}
	if(level.tanksource == "twoway")
	{
		if(isdefined(level.nPrice) && isalive(level.nPrice))
		{
			if(level.tankspeech2 == 0)
			{
					//DIALOG Captain Price - "SERGEANT EVANS, DESTROY THAT TANK TO THE SOUTH!!!!"
					level.nPrice anim_single_solo(level.nPrice, "southeast1");
					level.tankspeech2 = 1;
					wait 5;
					
					//DIALOG Captain Price - "ENEMY TANK MOVING IN FROM THE SOUTHEAST ROAD!"
					level.nPrice anim_single_solo(level.nPrice, "southeast2");
			}
			else
			{	
					//DIALOG Captain Price - "ENEMY TANK MOVING IN FROM THE SOUTHEAST ROAD!"
					level.nPrice anim_single_solo(level.nPrice, "southeast2");
					wait 5;
					
					//DIALOG Captain Price - "SERGEANT EVANS, DESTROY THAT TANK TO THE SOUTH!!!!"
					level.nPrice anim_single_solo(level.nPrice, "southeast1");
			}
		}
	}
	if(level.tanksource == "threeway")
	{
		
		if(level.tankspeech3 == 0)
		{
			tank_rangepause(eTank);	//pause until tank is at a better position for Price to alert the player in a timely manner
			
			if(isdefined(level.nPrice) && isalive(level.nPrice))
			{
				wait level.northeastdelay;
				
				//DIALOG Captain Price - "TANK, NORTHEAST! KEEP YOUR EYES OPEN EVANS!"
				level.nPrice anim_single_solo(level.nPrice, "northeast1");
				level.tankspeech3 = 1;
				wait 5;
				
				//DIALOG Captain Price - "ENEMY TANK! MOVING IN FROM THE NORTH!"
				level.nPrice anim_single_solo(level.nPrice, "northeast3");
			}
		}
		else
		if(level.tankspeech3 == 1)
		{	
			tank_rangepause(eTank);	//pause until tank is at a better position for Price to alert the player in a timely manner
			
			if(isdefined(level.nPrice) && isalive(level.nPrice))
			{
				wait level.northeastdelay;
				for(i=0; i<2; i++)
				{
					//DIALOG Captain Price - "NORTHEAST AGAIN! ANOTHER TANK!"
					level.nPrice anim_single_solo(level.nPrice, "northeast2");
					level.tankspeech3 = 2;
					wait 5;
					
					//DIALOG Captain Price - "TANK, NORTHEAST! KEEP YOUR EYES OPEN EVANS!"
					level.nPrice anim_single_solo(level.nPrice, "northeast1");
					wait 5;
				}
			}
		}
		else
		if(level.tankspeech3 == 2)
		{	
			tank_rangepause(eTank);	//pause until tank is at a better position for Price to alert the player in a timely manner
			
			if(isdefined(level.nPrice) && isalive(level.nPrice))
			{
				wait level.northeastdelay;

				//DIALOG Captain Price - "ENEMY TANK! MOVING IN FROM THE NORTH!"
				level.nPrice anim_single_solo(level.nPrice, "northeast3");
				wait 5;
				
				//DIALOG Captain Price - "TANK, NORTHEAST! KEEP YOUR EYES OPEN EVANS!"
				level.nPrice anim_single_solo(level.nPrice, "northeast1");
			}
		}
	}
}

tank_rangepause(eTank)
{
	//Checks the distance between the tank and bridgerallypoint
	//Functions as a big wait, returns to calling thread and resumes
	
	eTank endon ("death");
	
	nTestNode = getnode("bridgerallypoint", "targetname");
	nPoint1 = nTestNode.origin;
	nPoint2 = eTank.origin;
	fDistance = length(nPoint1 - nPoint2);
	iRangeLimit = 5700; 	//how far from bridgerallypoint the tank should be before Price warns the player
	
	while(fDistance > iRangeLimit)
	{
		nPoint2 = eTank.origin;
		fDistance = length(nPoint1 - nPoint2);
		wait 0.5;
	}
}

tank_target(eTank, eStartNode)
{
	eTank endon("death");
	
	flak_killnode = tank_fire_control_flak(eTank, eStartNode);
	
	//Get moving
	
	eTank startPath();
	
	eTank setWaitNode(flak_killnode);
	eTank waittill("reached_wait_node");
	
	eFlak88 = getent("flak_88","targetname");
	eTank setTurretTargetEnt(eFlak88, (0,0,32));
	
	println("tank is going for the flak88");
	
	while(isAlive(eFlak88))
	{
		eTank waittill( "turret_on_vistarget" );
		//println("TARGET ACQUIRED, FIRE!");
		wait 0.5;		//grace period
		eTank maps\_panzerIV::fire();
		wait 4;			//reloading
	}
	
	println("tank is going for the bunker");
	
	eBunkerAimPoint = getent("bunkeraimpoint","targetname");
	eTank setTurretTargetEnt(eBunkerAimPoint, (0,0,0));
	
	tBunkerShockTrig = getent("tankshock", "targetname");
	
	while(1)
	{
		if(level.player istouching(tBunkerShockTrig))
		{
			println("targeting bunker now");
			eTank waittill( "turret_on_vistarget" );
			println("TARGET ACQUIRED, FIRE!");
			wait 2;				//grace period
			eTank maps\_panzerIV::fire();
			if(level.player istouching(tBunkerShockTrig))
			{
				thread player_shellshock();	//player is shellshocked
				thread player_shellshock_failsafe(eTank);
			}
			wait 8;					//reloading and giving more time to the player
		}
		
		wait 0.05;
	}
}

tank_fire_control_flak(eTank, nNode)
{
	//Scan up through the node sequence to find the flakkill nodes
	//Pass them to the tank_target thread
	
	eTank endon("death");
	
	println("nNode is ", nNode);
	
	while(1)
	{
		if(isdefined(nNode.script_namenumber) && nNode.script_namenumber == "flakkill")
		{
			println("script_namenumber is", nNode.script_namenumber);
			return(nNode);
			break;
		}
		
		if(!isdefined(nNode.target))
		{
			break;
		}
		
		println("targetnode target = ", nNode.target);
		nNode = getvehiclenode(nNode.target, "targetname");
		println("targetnode target = ", nNode);
		
		wait 0.05;
	}
}

tank_init(eTank)
{
	eTank endon("death");
	
	eTank useAnimTree( #animtree );
	eTank.isalive = 1;
	eTank.health  = 1000;
}

tank_smoke(eTank)
{
	eTank waittill ("death");
	
	flameemitter = spawn("script_origin",etank.origin);

	while(1)
	{
		playfx(level.lingerfx,flameemitter.origin);
		wait 15;
	}
}

tank_kill(eTank)
{
	eTank waittill( "death" );
	
	level.activetank = 0;
	
	level notify ("tank was killed");
	
	flameemitter = spawn("script_origin",etank.origin+(0,0,32));
	while(1)
	{
		playfx(level.fireydeath,flameemitter.origin);
		wait (randomfloat (0.15)+.1);
	}
}

tank_death_autosave()
{
	i = 0;
	ratiolimit = 0.6;	//what percentage of health the player must have for an autosave to occur
	
	while(1)
	{
		level waittill ("tank was killed");
		
		ratio = level.player.health/level.player.maxhealth;
		println("Health percentage at ", ratio*100, " percent.");
		
		i++;
		if((i == 2) && (ratio >= ratiolimit))
		{
			maps\_utility::autosave(4);
		}
		else 
		if((i==4) && (ratio >= ratiolimit))
		{
			maps\_utility::autosave(5);
		}
	}
}

tank_status(eTank)
{
	eTank waittill("death");

	eTank setspeed (0,5);
	
	//println("Tank destroyed.");
	
	wait (8 + randomfloat(4));	//pause before next deployment
}

tank_autodestruct()
{
	level waittill ("victory");
	aTank = [];
	aTank = getentarray("tank","targetname");
	
	for(i=0; i<aTank.size; i++)
	{
		if(isdefined(aTank[i]) && isalive(aTank[i]))
		{
			origin = (aTank[i] getorigin() + (0,8,2));
			range = 200;
			maxdamage = 2500;
			mindamage = 2000;
			wait 0.7;
			
			if(isalive(aTank[i]))
			{
				println("SHOOT THE TANK NOW");
			
				aTank[i] setspeed (0,5);
				aTank[i] playsound ("mortar_incoming1");
			
				wait (1.07 - 0.25);
			
				
			
				playfx (level.eLightMortarShellFX, origin);
			
				wait 0.1;
			
				radiusDamage(origin, range, maxdamage, mindamage);
				earthquake(0.75, 2, origin, 2250);
			
				wait 0.1;
			
				earthquake(0.75, 2, origin, 2250);			
				wait 0.25;
			}
			
			if(isalive(aTank[i]))
			{
				aTank[i] playsound ("mortar_incoming1");
				wait (1.07 - 0.25);
				playfx (level.eLightMortarShellFX, origin);
			}
		}
	}
}

radius_damage(nObject, range, maxdamage, mindamage)
{
	origin = nObject getorigin();
	
	radiusDamage(origin, range, maxdamage, mindamage);
}

//**********************************************//
//		MORTAR/MARTYR UTILITIES		//
//**********************************************//

martyr_start()
{
	aMartyrs = [];
	aMartyrs = getentarray("martyr","targetname");
	
	for(k=0; k<aMartyrs.size; k++)
	{
		if(isalive(aMartyrs[k]))
		{
			level thread martyr_moveout(aMartyrs[k]);
			level thread martyr_countdown(aMartyrs[k]);	
		}
	}
}

martyr_moveout(nMartyr)
{
	nMartyrNode = getnode("martyrdest","targetname");
	wait (randomfloat(0.6));
	nMartyr setgoalnode(nMartyrNode);
}

martyr_countdown(nMartyr)
{
	//Blows up any NPC with the targetname "martyr"
		
	nKillTime = randomfloat(1)+randomfloat(3);
	wait nKillTime;
	println("nKillTime = ", nKillTime);
	
	if(isalive(nMartyr))
	{	
		soundnum = randomint(3) + 1;
	
		if (soundnum == 1)
		{
			nMartyr playsound ("mortar_incoming1");
			wait (1.07 - 0.25);
		}
		else
		if (soundnum == 2)
		{
			nMartyr playsound ("mortar_incoming2");
			wait (0.67 - 0.25);
		}
		else
		{
			nMartyr playsound ("mortar_incoming3");
			wait (1.55 - 0.25);
		}
	}
	
	if(isalive(nMartyr))
	{
		nMartyr playsound ("weapons_rocket_explosion");
		
		level thread radius_damage(nMartyr, 192, 370, 150); 	//nObject, range, maxdamage, mindamage
	
		wait 0.05;
		if(isalive(nMartyr))
		{
			nMartyr doDamage (nMartyr.health + 10050, (0,0,0));
		}

		playfx (level.eLightMortarShellFX, nMartyr.origin);
		earthquake(0.35, 2, nMartyr.origin, 3150);
	}
}

player_mortar_check()
{	
	nKillZone = getentarray("mortarkillzone","targetname");
	
	for(j=0; j<nKillZone.size; j++)
	{
		thread player_mortar_wait(nKillZone[j]);
	}		
}

player_mortar_wait(killzone)
{
	level endon ("barrage ends");
	
	while(!(level.player istouching(killzone)))
	{
		wait 0.05;
	}
	
	thread player_mortar_hit(killzone);
}

player_mortar_hit(killzone)
{
	if(isalive(level.player) && level.player istouching(killzone))
	{
		level.player playsound ("mortar_incoming1");
		
		origin = (level.player getorigin() + (0,8,2));
		range = 320;
		maxdamage = 200 + randomint(100); 
		mindamage = 100;
		//println("LOOK OUT!!!!!!");
		playfx (level.eShellShockGroundFX, origin);
		level.player playsound ("weapons_rocket_explosion");
		wait 0.25;
		
		radiusDamage(origin, range, maxdamage, mindamage);
		earthquake(0.75, 2, origin, 2250);
		
		if(isalive(level.player))
		{
			level.player allowStand(false);
			level.player allowCrouch(false);
			level.player allowProne(true);
			
			wait 0.15;
			level.player viewkick(127, level.player.origin);  //Amount should be in the range 0-127, and is normalized "damage".  No damage is done.
			level.player shellshock("default_nomusic", 20);
			
			wait 1.5;
			
			level.player allowStand(true);
			level.player allowCrouch(true);
		}
	}
}

player_shellshock()
{
	//main(duration, nMaxDamageBase, nRanDamageBase, nMinDamageBase, nExposed, customShellShock)
	thread maps\_shellshock::main(6, undefined, undefined, undefined, undefined, "default_nomusic");
}

player_shellshock_failsafe(eTank)
{
	eTank waittill ("death");
	
	wait 1.65;
	
	level.player allowStand(true);
	level.player allowCrouch(true);
}

hideall_craters()
{
	aMortars = getentarray("mortar","targetname");
	
	for(i=0; i<aMortars.size; i++)
	{
		if(isdefined(aMortars[i].script_hidden))
		{
			nCrater = getent(aMortars[i].script_hidden, "targetname");
			nCrater hide();
		}
	}
}

//**********************************************//
//		EXPLODER UTILITIES		//
//**********************************************//

wall_breach()
{
	maps\_utility::exploder (1);	//set off any script_brushmodel with a script_exploder of 1
	maps\_utility::exploder (2);
	maps\_utility::exploder (3);
}

//**********************************************//
//		FRIENDLY UTILITIES		//
//**********************************************//

friendly_squad_info()
{
	aFriendlySquad = getaiarray("allies");
	level.friendlytotal = (float)aFriendlySquad.size;
	level.friendlypop = aFriendlySquad.size;

	if(level.friendlytotal > 0)
	{
		level.friendlypercent = (int)((level.friendlypop/level.friendlytotal)*100);
	}

	for(i=0; i<aFriendlySquad.size; i++)
	{
		if(isdefined(aFriendlySquad[i]))
		{
			level thread friendly_death_waiter(aFriendlySquad[i]);
		}
	}
}

friendly_death_waiter(nFriendly)
{
	nFriendly waittill("death");
	level.friendlypop--;
}

friendly_boost()
{
	wait 0.05;
	
	//Give the defenders and superiors a good chunk of health
	
	aDefenders = getentarray("defender","targetname");
	for(i=0; i<aDefenders.size; i++)
	{
		if (getcvarint("g_gameskill") == 0)
		{
			aDefenders[i].accuracy = 0.75;		
			aDefenders[i].health = 900;
		}
		if (getcvarint("g_gameskill") == 1)
		{
			aDefenders[i].accuracy = 0.7;		
			aDefenders[i].health = 800;
		}
		if (getcvarint("g_gameskill") == 2)
		{
			aDefenders[i].accuracy = 0.6;		
			aDefenders[i].health = 700;
		}
		if (getcvarint("g_gameskill") == 3)
		{
			aDefenders[i].accuracy = 0.5;		
			aDefenders[i].health = 600;
		}
		
		level thread friendly_shield(aDefenders[i]);
	}
	
	//level.nPrice.health = 3200;
	//level.nPrice.accuracy = 0.8;
	//level thread friendly_shield(level.nPrice);
	
	level.nDavis.health = 900;
	level.nDavis.accuracy = 0.8;
	level thread friendly_shield(level.nDavis);
}

friendly_shield(nFriendly)
{
	//Variant of magic bullet shield 
	
	level endon ("stop magic friendly shield");
	nFriendly endon ("death");
	
	while (isAlive(nFriendly))
	{
		nFriendly waittill ("pain");
		nFriendly.ignoreme = true;
		wait 5;
		if(isAlive(nFriendly))
		{
			nFriendly.ignoreme = false;
			nFriendly.health = nFriendly.health + 20;
		}
	}
}

friendly_defensive_pattern()
{	
	aFriendlies = getaiarray("allies");
	for(i=0; i<aFriendlies.size; i++)
	{
		aFriendlies[i] allowedStances ("stand");
	}
		
	aDefenders = getentarray("defender","targetname");
	
	nPriceDefNode = getnode("defensePrice","targetname");
	level.nPrice setgoalnode(nPriceDefNode);
	//level thread friendly_expand(level.nPrice);
	
	wait(randomfloat(0.2)+randomfloat(0.6));
	
	nDavisDefNode = getnode("defenseDavis","targetname");
	level.nDavis setgoalnode(nDavisDefNode);
	//level thread friendly_expand(level.nDavis);
	
	wait(randomfloat(0.2)+randomfloat(0.6));
	
	for(i=0; i<aDefenders.size; i++)
	{
		aDefenseNodes = getnodearray("defense_pattern_west","targetname");
			
		for(j=0; j<aDefenseNodes.size; j++)
		{
			if(isdefined(aDefenders[i]) && (aDefenders[i].script_noteworthy == aDefenseNodes[j].script_noteworthy) && isAlive (aDefenders[i]))
			{
				aDefenders[i] setgoalnode(aDefenseNodes[j]);
				aDefenders[i].goalradius = aDefenseNodes[j].radius;
				wait(randomfloat(0.2)+randomfloat(0.6));
			}		
		}
	}
	
	wait 10;
	
	level notify ("west defense established");
}

friendly_expand(nSoldier)
{
	//Boost goalradius once in position to defend
	
	nSoldier endon ("death");
	
	nSoldier waittill("goal");
	
	
	nSoldier.goalradius = level.friendlyDefenseRadius;
	nSoldier allowedStances ("stand", "crouch", "prone");
}

//**********************************************//
//		OBJECTIVE UTILITIES		//
//**********************************************//

objectives()
{	
	nRallyNode = getnode("bridgerallypoint","targetname");
	
	objective_add(1, "active", &"PEGASUSDAY_HOLD_THE_BRIDGE_UNTIL", (nRallyNode.origin));
	objective_current(1);
	
	level waittill ("objective2");
		
	objective_add(2, "active", &"PEGASUSDAY_DEFEND_THE_WEST_BANK", (256, -1040, 8));
	objective_current(2);
	
	level waittill ("objective3");
	
	objective_state(2, "done");
	
	objective_add(3, "active", &"PEGASUSDAY_FALL_BACK_ACROSS_THE", (-80, 216, 120));
	objective_current(3);
	
	level waittill ("objective final");
	
	objective_state(3, "done");
	
	objective_current(1);
	thread tank_assault();
	
	level waittill ("objectives complete");
	
	objective_state(1, "done");
	
	if(!level.tankobjon)
	{
		objective_add(4, "active", &"PEGASUSDAY_HELP_THE_REINFORCEMENTS", (nRallyNode.origin));
		objective_current(4);
	}
	else
	{
		objective_add(5, "active", &"PEGASUSDAY_HELP_THE_REINFORCEMENTS", (nRallyNode.origin));
		//objective_current(5);
	}
	
	thread victory();
	println("^3+++++++++VICTORY ARMY MORALE ++++++++++++");
	thread victory_army_morale();
	
	level waittill ("the end");
	
	objective_add(4, "active", &"PEGASUSDAY_HELP_THE_REINFORCEMENTS", (nRallyNode.origin));
	objective_current(4);
	objective_state(4, "done");
	
	objective_add(5, "active", &"PEGASUSDAY_DEBRIEF_WITH_CAPTAIN", (nRallyNode.origin));
	objective_current(5);
	
	level waittill ("really the end");
	
	objective_state(5, "done");
}

objective_stopwatch()
{
	fMissionLength = level.stopwatch;				//how long until relieved (minutes)	
	iMissionTime_ms = gettime() + (int)(fMissionLength*60*1000);	//convert to milliseconds
	
	// Setup the HUD display of the timer.
	
	level.hudTimerIndex = 20;
	
	level.timer = newHudElem();
	level.timer.alignX = "left";
	level.timer.alignY = "middle";
	level.timer.x = 460;
	level.timer.y = 100;
	level.timer.label = &"PEGASUSDAY_REINFORCEMENTS_ARRIVING";
	level.timer setTimer(level.stopwatch*60);
	
	wait(level.stopwatch*60);
	
	level.timer destroy();
}

tank_objective_update(eTank)
{
	eTank endon ("death");
	
	level.tankobjon = 1;
	
	objective_add(4, "active", &"PEGASUSDAY_DESTROY_THE_INCOMING", (eTank.origin));
	objective_current(4);
	
	while(isalive(eTank))
	{
		objective_position(4, eTank.origin);
		objective_ring(4);
		wait 0.7;
	}
}

tank_objective_reset(eTank)
{
	//Briefly show the objective as complete, then nuke it
	//Restore the main objective to hold the bridge
	//If victory is already notified, then reformat the objective positions.
	
	eTank waittill ("death");
	level.tankobjon = 0;
	objective_state(4, "done");
	objective_delete(4);
	
	nRallyNode = getnode("bridgerallypoint","targetname");
	
	aEnemies = getaiarray("axis");
	
	if(!level.victory)
	{
		objective_current(1);
	}
	else
	if(aEnemies.size > 0)
	{
		objective_delete(5);
		
		objective_add(4, "active", &"PEGASUSDAY_HELP_THE_REINFORCEMENTS", (nRallyNode.origin));
		objective_current(4);
	}
}

//**********************************************//
//		DOOMSDAY UTILITIES		//
//**********************************************//

doomsdayDevice()
{
	println("++++++ WE ARE HUNTING DOWN THE PLAYER ++++++++");
	
	level endon ("victory");
	
	level.fSpawnInterval = 1;	
	level.iRosterMax = 18;		
	level.grudgemode = 1;		
	
	//All previously existing AI must refocus on player
	
	aDoomsdayArmy = getaiarray("axis");
	
	for(i=0; i<aDoomsdayArmy.size; i++)
	{
		level thread doomsdayNav(aDoomsdayArmy[i]);
	}
	
	//New deployment orders from German HQ
	
	while(level.iDoomsdayPause != 1)
	{
		nDoomAcc = 1;
		
		thread squad_assault(level.strZeta, nDoomAcc);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strEpsilon, nDoomAcc);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strEta, nDoomAcc);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strEpsilon, nDoomAcc);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strZeta, nDoomAcc);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strBeta, nDoomAcc);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strGamma, nDoomAcc);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strAlpha, nDoomAcc);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strEta, nDoomAcc);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strDelta, nDoomAcc);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strBeta, nDoomAcc);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strEpsilon, nDoomAcc);
		wait(level.fSpawnInterval);
	}
}

doomsdayNav(nSoldier)
{
	nSoldier endon("death");
	
	wait randomintrange(10, 25);
	println("---SEEKING PLAYER---");
	nSoldier setgoalentity(level.player);
	n = randomint(3);
	
	if(n == 0)
	{
		nSoldier.favoriteenemy = level.nDavis;
	}
	if(n == 1)
	{
		nSoldier.favoriteenemy = level.nPrice;
	}
	if(n >= 2)
	{
		nSoldier.favoriteenemy = level.player;
	}
	
	nSoldier.goalradius = 1600;
}

//**********************************************//
//		VICTORY UTILITIES		//
//**********************************************//

victory()
{
	level notify ("victory"); 	//shuts down all enemy spawn schedules and other threads
	level notify ("stoptanks");	//stops tank assaults
	level.grudgemode = 0;		//resume normal AI navigation for squad_move
	level.victory = 1;		//filters rostermax for friendly spawns 
	
	thread victory_army_group();	//spawns in tons of friendlies from the outskirts	
	thread victory_music();	
	thread failsafe_deaths();	//failsafe for any situation where the AI is nowhere in playable space
	
	badplace_delete("badplaceallied1");
	badplace_delete("badplaceallied2");
	
	wait 2;
	
	level.player.ignoreme = 0;
	
	//DIALOG Captain Price if not incapacitated (ie: alive)
	
	if(isdefined(level.nPrice) && isalive(level.nPrice))
	{
		//DIALOG Captain Price - "WE'VE GOT FRIENDLIES TO THE WEST! WATCH YOUR FIRE!"
		level.nPrice anim_single_solo(level.nPrice, "victory1");
	}
}

victory_population_failsafe()
{
	level waittill ("victory");
	
	wait 2;
	
	while(1)
	{
		aEnemies = [];
		aEnemies = getaiarray("axis");
		if(!aEnemies.size)
		{
			break;
		}
		else
		{
			aEnemies = undefined;
		}
		wait 0.05;
	}
	
	wait 2;
	
	println("FAILSAFE ENGAGED. POPULATION IS 0.");
	
	level.population_failsafe = 1;
}

victory_tankpop_failsafe()
{
	level waittill ("victory");
	
	wait 2; 
	
	aVehicles = [];
	aVehicles = getentarray("script_vehicle", "classname");
	
	for(i=0; i<aVehicles.size; i++)
	{
		if(isdefined(aVehicles[i].targetname) && aVehicles[i].targetname == "flak_88")
		{
			aVehicles = maps\_utility::subtract_from_array(aVehicles, aVehicles[i]);	
		}
	}
	
	while(1)
	{
		if(aVehicles.size == 1)
		{
			level.tankobjon = 0;
			println("FAILSAFE ENGAGED. TANKS ARE ALL GONE EXCEPT THE COLLMAP ONE.");
			break;
		}
		else
		{
			println("++++++++ THERE ARE ", aVehicles.size, " TANKS IN THE LEVEL.");
		}
		
		aVehicles = undefined;
		aVehicles = [];
		aVehicles = getentarray("script_vehicle", "classname");
	
		for(i=0; i<aVehicles.size; i++)
		{
			if(isdefined(aVehicles[i].targetname) && aVehicles[i].targetname == "flak_88")
			{
				aVehicles = maps\_utility::subtract_from_array(aVehicles, aVehicles[i]);	
			}
		}
			
		wait 0.5;
	}
}

victory_music()
{	
	level waittill ("music_threshold");
	
	//music plays here
	
	wait 25;
	
	while(1)
	{
		level notify ("musicdone");
		wait 0.1;
	}
}

victory_army_group()
{
	level endon ("musicdone");
	
	wait 0.5;
	level.fSpawnInterval = 1;
	level.iRosterMax = 18;
	
	while(1)
	{
		thread squad_assault(level.strTheta);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strIota);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strKappa);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strIota);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strKappa);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strTheta);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strKappa);
		wait(level.fSpawnInterval);
	}
}

victory_army_morale()
{
	wait 1;
	
	println("+++++++++++++ VICTORY ARMY MORALE IS STARTED ++++++++++++++");
	
	aEnemies = getaiarray("axis");
	level.nEnemyPop = aEnemies.size;
	
	nSuicideNode = getnode("bridgerushnode", "targetname");
	eta_suicide_node1 = getnode("eta_suicide1", "targetname");
	eta_suicide_node2 = getnode("eta_suicide2", "targetname");
	zeta_suicide_node = getnode("zeta_suicide", "targetname");	
	
	for(i=0; i<aEnemies.size; i++)
	{
		aEnemies[i].health = 1;
		aEnemies[i].suppressionwait = 0;
	
		level thread victory_deathwaiter(aEnemies[i]);
		
		println("aEnemies targetname is ", aEnemies[i].targetname);
		
		if(isdefined(aEnemies[i].targetname) && aEnemies[i].targetname == "eta")
		{
			length1 = length(aEnemies[i].origin - eta_suicide_node1.origin);
			length2 = length(aEnemies[i].origin - eta_suicide_node2.origin);
			
			if(length1 < length2)
			{
				//attack_move_node(nSoldier, fWaitMin, fWaitMax, fClosureRate, nGoalNode, fStartRadius, fEndRadius)
				aEnemies[i].script_namenumber = "leftover guy";
				aEnemies[i] thread attack_move_node(aEnemies[i], 6, 10, 0.9, eta_suicide_node1, 1000, 512);
			}
			else
			{
				//attack_move_node(nSoldier, fWaitMin, fWaitMax, fClosureRate, nGoalNode, fStartRadius, fEndRadius)
				aEnemies[i].script_namenumber = "leftover guy";
				aEnemies[i] thread attack_move_node(aEnemies[i], 8, 12, 0.9, eta_suicide_node2, 1000, 512);
			}
		}
		else
		if(isdefined(aEnemies[i].targetname) && aEnemies[i].targetname == "zeta")
		{
			//attack_move_node(nSoldier, fWaitMin, fWaitMax, fClosureRate, nGoalNode, fStartRadius, fEndRadius)
			aEnemies[i].script_namenumber = "leftover guy";
			aEnemies[i] thread attack_move_node(aEnemies[i], 5, 9, 0.8, zeta_suicide_node, 1000, 512);
		}
		else
		{
			//attack_move_node(nSoldier, fWaitMin, fWaitMax, fClosureRate, nGoalNode, fStartRadius, fEndRadius)
			aEnemies[i] setgoalnode(nSuicideNode);
			level thread attack_move_node(aEnemies[i], 15, 30, 0.965, nSuicideNode, 2800);
			//println("NEW ATTACK MOVE NODE CALLED FOR GENERICS");
		}
	}
	
	aFriendlies = getaiarray("allies");
	for(j=0; j<aFriendlies.size; j++)
	{
		aFriendlies[j].health = 2000;
		aFriendlies[j].accuracy = 1;
		aFriendlies[j].bravery = 500000;
		aFriendlies[j].suppressionwait = 0.01;
	}
	if(!level.nEnemyPop)
	{
		thread victory_ending();
	}
}

victory_deathwaiter(nEnemy)
{
	println("I'm ready to die");
	nEnemy waittill("death");
	level.nEnemyPop--;
	println("nPOP = ",level.nEnemyPop);
	if(level.nEnemyPop < 6)
	{
		level notify ("music_threshold");
	}
	if(!level.nEnemyPop)
	{
		level.noguys = 1;
		println("level.noguys is now 1");
		thread victory_ending();
		level.population_failsafe = 1;
	}
}

victory_ending()
{	
	while(!level.noguys || level.tankobjon != 0)
	{
		if(!level.population_failsafe || level.tankobjon != 0)
		{
			wait 0.1;
		}
		else
		{
			break;
		}
	}
	
	println("BRIDGE DEFENSE SUCCESSFUL. ALL ENEMY UNITS TERMINATED.");
	
	aEveryone = getaiarray("allies");
		
	for(i=0; i<aEveryone.size; i++)
	{
		aEveryone[i] thread animscripts\shared::SetInCombat(false);
	}
	
	//Captain Price goes to the end point to congratulate everyone
	
	if(isdefined(level.nPrice) && isalive(level.nPrice))
	{
		thread victory_rally();
		thread victory_pricetalk();	
	}
	
	level waittill ("victory pricetalk is done");
	
	wait 4; //soft wait
	
	//iprintlnbold("MISSION ACCOMPLISHED");
	
	level waittill ("musicdone");
	
	//changelevel("dam", false, 6);
	
	missionSuccess("uk_sas", false);
}

victory_pricetalk()
{
	
	wait 0.05;
	
	level notify ("the end");
	
	nNode = getnode("bridgerallypoint", "targetname");
	
	level.nPrice setgoalnode(nNode);
	level.nPrice.goalradius = 120;
	level.nPrice waittill ("goal");
		
	dist = length(level.player.origin - level.nPrice.origin);
	
	//Wait for player to rejoin 
	
	while(dist > 192)
	{
		dist = length(level.player.origin - level.nPrice.origin);
		wait 0.1;
	}
	
	thread price_looks_around();
	
	//DIALOG Captain Price - "I believe that's the last of them! Cease fire! Excellent work lads, bloody well done!"
	level.nPrice anim_single_solo(level.nPrice, "victory2");
	
	level notify ("really the end");
	level notify ("victory pricetalk is done");
}

price_looks_around()
{
	ai = getaiarray ("allies");	
	
	level.nPrice lookat(level.player, 1);
	
	wait 1;
	for (i=0;i<ai.size;i++)
	{
		time = (.6 + randomfloat (.8));
		if (isalive (ai[i]))
		{
			level.nPrice lookat(ai[i], time);
			wait (time);
		}
	}
	level.nPrice lookat(level.player, 1);
	wait 1;
}

lookat (ent, timer)
{
	if (!isdefined (timer))
		timer = 10000;
		
	self animscripts\shared::lookatentity(ent, timer, "alert");
}

victory_commandonode_subtract(commandonode)
{
	wait 0.05;
	level.aCommandoNodes = maps\_utility::subtract_from_array(level.aCommandoNodes, commandonode);
	println("COMMANDO NODES REMAINING AFTER FIRST PICKS: ", level.aCommandoNodes.size);
}

victory_rally()
{
	//Remaining starting NPCs rally in front of the bunker
	
	level.victoryrally = 1;

	level notify ("rally with Price");

	aHeroes = [];
	aCommandos = [];
	
	aAllies = getaiarray("allies");

	level.aCommandoNodes = getnodearray("commando_node", "targetname");	
	println("THERE ARE ", level.aCommandoNodes.size, " COMMANDONODES IN THE LEVEL.");
	
	//Put all current reinforcements into commandos array
	
	for(i=0; i<aAllies.size; i++)
	{
		if(!isdefined(aAllies[i].script_commonname) || !(aAllies[i].script_commonname == "hero"))
		{
			//aCommandos = maps\_utility::add_to_array(aCommandos, aAllies[i]);
			aCommandos[aCommandos.size] = aAllies[i];
			aAllies[i].dontavoidplayer = 1;
		}	
		
		println("EXISTING COMMANDO ", i, " HAS CLAIMED A NODE");
	}
	
	//Run commandos to decent spots to debrief with the captain or guard the perimeter
	
	for(i=0; i<aCommandos.size; i++)
	{
		println("RUNNING COMMANDO NOW");
		aCommandos[i] setgoalnode(level.aCommandoNodes[i]);
		thread victory_commandonode_subtract(level.aCommandoNodes[i]);
		
		aCommandos[i].goalradius = 8;
		
		n = randomint(3);
		
		if(n > 1)
		{
			aCommandos[i] allowedStances("crouch");
		}
		else
		{
			aCommandos[i] allowedStances("stand");
		}
	}
	
	//Send heroes to decent spots close to the captain
	
	for(i=0; i<aAllies.size; i++)
	{
		if(isdefined(aAllies[i].script_commonname) && aAllies[i].script_commonname == "hero")
		{
			//aHeroes = maps\_utility::add_to_array(aHeroes, aAllies[i]);
			aHeroes[aHeroes.size] = aAllies[i];
			println("HERO FOUND ADDING TO ARRAY");
		}
		wait 0.05;
	}
	
	aRallyNodes = getnodearray("schoolcircle_node", "targetname");
	
	for(i=0; i<aHeroes.size; i++)
	{
		aHeroes[i] setgoalnode(aRallyNodes[i]);
		aHeroes[i].goalradius = 32;
		println("HERO RUNNING TO SCHOOL CIRCLE");
		
		n = randomint(3);
		
		if(n > 1)
		{
			aHeroes[i] allowedStances("crouch");
		}
		else
		{
			aHeroes[i] allowedStances("stand");
		}
		
	}
}

//**********************************************//
//		ANIMATION UTILITIES		//
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

//**********************************************//
//		AI OVERRIDE UTILITIES		//
//**********************************************//

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
			spawned.script_moveoverride = 1;
			
			if (getcvarint("g_gameskill") == 0)
			{
				spawned.accuracy = 0.1;
			}
			if (getcvarint("g_gameskill") == 1)
			{
				spawned.accuracy = 0.3;
			}
			if (getcvarint("g_gameskill") == 2)
			{
				spawned.accuracy = 0.4;
			}
			if (getcvarint("g_gameskill") == 3)
			{
				spawned.accuracy = 0.6;
			}
			spawned.suppressionwait = 0.5;
			spawned.maxsightdistsqrd = 12250000;
		}
	}
}

death_failsafe()
{
	nDeathTrig = getent("death_guaranteed", "targetname");
	
	while(1)
	{
		nDeathTrig waittill ("trigger", guy);
		println("UNAUTHORIZED DEATH HAS OCCURRED AT ", guy.origin);
	}
}

failsafe_deaths()
{
	//forces all enemy ai to drop dead after failsafetime has elapsed
	
	failsafetime = 120;
	wait failsafetime;
	
	aEnemies = getaiarray("axis");
	for(i=0; i<aEnemies.size; i++)
	{
		aEnemies[i] doDamage (aEnemies[i].health + 10050, (0,0,0));
		wait 0.8 + randomfloat(2);
	}
}

//**********************************************//
//		  MUSIC UTILITIES		//
//**********************************************//

music()
{
	level waittill("east battle and stopwatch begin");
	if(isdefined(level.stopwatchmusic))
	{
		wait level.stopwatchmusic;
		musicPlay("pegasusbridge");
	}
}
