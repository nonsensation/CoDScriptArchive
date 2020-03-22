/****************************************************************************

Level: 		RED SQUARE
Campaign: 	Russian
Objectives: 	1. Get across Red Square.
			- Objective is persistent until the player enters the underground tunnels
		2. Find a good flanking position above the enemy line.
			- get to the perch
		3. Eliminate the officers in the enemy blockade.
			- displays when the player has reached the sniping perch
			- completes when all the firing line troops are killed 
		4. Rendezvous with Major Zubov via the train station. 
			- passthrough objective, reach the fortified location, completes at level exit

*****************************************************************************/


main()
{
	setExpFog(0.00035, 0.4484, 0.4484, 0.4515, 0); 		//temp fog test
	
	maps\_panzerIV::main();
	maps\_panzerIV::main_camo();
	
	maps\_drones::main();
	maps\redsquare_fx::main();
	maps\redsquare_anim::main();
	maps\redsquare_anim::dialog();
	maps\_load::main();

	maps\_utility::precache("xmodel/sovietequipment_sidecap");
	maps\_utility::precache("xmodel/stalingrad_flag");
	maps\_utility::precache("xmodel/largegroup_20");
	maps\_utility::precache("xmodel/gib_concrete1");
	
	level.nSmartGuy = getent("smartguy", "targetname");
	
	character\makarov::precache();
	level.nSmartGuy character\_utility::new();
	level.nSmartGuy character\makarov::main();
	
	precacheItem("luger");
	
	nLedgeTurret = getent("ledgemg42","targetname");
	nLedgeTurret makeTurretUnusable();
	
	//*** Sound
	
	level.ambient_track ["outside"] = "ambient_redsquare_ext";
	level.ambient_track ["inside"] = "ambient_redsquare_int";
	level.ambient_track ["chargewalla"] = "ambient_redsquare_charge";
	thread maps\_utility::set_ambient("outside");
	
	//*** Level Variables
	
	//Axis Squads

	level.strAlpha = "alpha";
	level.strBeta = "beta";
	level.strGamma = "gamma";
	level.strDelta = "delta";
	level.strEpsilon = "epsilon";
	level.strZeta = "zeta";
	level.strEta = "eta";
	
	level.fSpawnInterval = 2.5;
	level.rs_alliedpoplimit = 16;	//maintain this allied population in Red Square
	
	//Campaign 
	
	level.campaign = "russian";	//sets friendly names to Russian list
	
	level.rs_assault_on = 0;
	level.rs_pausechance = 2;	//1 in pausechance+1 chance of occurring
	level.rs_pausebase = 4;		//wait at least this long at a pause node
	level.rs_pausetime = 4.8;	//add this to the base time
	
	level.redsquare_active = 1;	//pauses the wave spawning in the redsquare area if set to 0
	
	level.traitortime = 8;		//time after charge begins before commissars respond to traitor triggers
	
	level.mortar = loadfx ("fx/impacts/newimps/blast_gen3nomark.efx");
	level.altmortar = level.mortar;
	level.eTankShellFX = loadfx ("fx/surfacehits/mortarImpact.efx");
	level.fireydeath = loadfx ("fx/fire/pathfinder_extreme.efx");
	
	level.sniperrifle = getent("freesniperrifle", "targetname");
	level.acrossredsquare = getent("acrossredsquare", "targetname");
	level.trainstationmarker = getent("trainstationmarker", "targetname");
	
	level.rusmarker = getent("russian_marker", "targetname");
	level.germarker = getent("german_marker", "targetname");
	level.traitordist = 64;		//amount of fallback required to be considered a traitor
	level.traitor_sampletime = 0.5;	//amount of time between traitordist checks
	level.nomercydist = 700;	//if the player is anywhere near the commissars after the charge starts, they attack
	
	level.gunon1 = 0;
	level.gunon2 = 0;
	
	level.tankstatus = 0;
	
	level.rs_victory = 0;
	level.officersdead = 0;
	
	//*** Threads

	thread music();
	thread force_crouch();
	thread large_group_of_guys(); // Makes lots of guys charge across the field to their DOOM.
	thread hideall_craters();
	thread rs_mortar_barrage();
	thread rs_tank_setup();
	thread rs_axis_setup();
	thread intro_setup();
	thread intro();
	thread smartguy_setup();
	
	thread redsquare_proxcheck_near();
	thread redsquare_proxcheck_near2();
	thread redsquare_proxcheck_far();
	thread redsquare_proxcheck_far2();
	
	thread enemy_officers();
	
	thread move_with_player();
	
	thread redsquare_victory_guards();
	
	thread perch_reached();
	thread redsquare_complete();
	thread exitlevel();
	
	//thread vladimir_lookat();
	
	thread objectives();
	thread bad_places();
}

//***************************************************

bad_places()
{	
	level waittill("turn on bad place");
	
	badplace_cylinder("badplaceallied1", -1, (5228, 7596, 60), 420, 1024, "allies");
	
	//auto304 with a radius of 440 units
	
	nSafePoint = getnode("auto304", "targetname");
	dist = length(level.player.origin - nSafePoint.origin);
	
	while(dist > 440)
	{
		dist = length(level.player.origin - nSafePoint.origin);	
		wait 0.5;
	}
	
	badplace_delete("badplaceallied1");
}

redsquare_victory_guards()
{
	level waittill ("redsquare is under soviet control");
	
	level.rs_victory = 1;
	
	wait 1;
	
	level notify ("redsquare is under soviet control");
	
	aFriendlies = getaiarray("allies");
	aVictoryGuards = [];
	
	for(i=0; i<aFriendlies.size; i++)
	{
		if(isdefined(aFriendlies[i].script_commonname) && aFriendlies[i].script_commonname == "conscript")
		{
			aVictoryGuards[aVictoryGuards.size] = aFriendlies[i];
		}
	}
	
	aVictoryGuardNodes = getnodearray("hold_redsquare_node", "targetname");
	
	for(i=0; i<aVictoryGuards.size; i++)
	{
		println("Victor Guard Node ", i);
		if(isAlive(aVictoryGuards[i]) && isdefined(aVictoryGuardNodes[i]))
		{
			aVictoryGuards[i] setgoalnode(aVictoryGuardNodes[i]);
		}
	}
}

vladimir_lookat()
{
	nVladTrig = getent("vladimir_trigger", "targetname");
	nVladTrig waittill("trigger");
	
	aFriendlies = getaiarray("allies");
	
	for(i=0; i<aFriendlies.size; i++)
	{
		if(isdefined(aFriendlies[i]) && isdefined(aFriendlies[i].script_noteworthy) && aFriendlies[i].script_noteworthy == "vladimir")
		{
			nVlad = aFriendlies[i];
		}
	}
	
	dist = length(nVlad.origin - level.player.origin);
	while(dist > 256)
	{
		dist = length(nVlad.origin - level.player.origin);
		wait 0.05;	
	}
	
	if(isdefined(nVlad) && isalive(nVlad))
	{
		nVlad.animname = "vladimir";
		nVlad thread animscripts\shared::LookAtEntity(level.player, 3, "alert");
		nVlad thread anim_single_solo (nVlad, "heyalexei");
	}
}

large_group_of_guys()
{
	node = getnode ("scripted_runners","targetname");

	level waittill ("start the drones");

	level endon("stop charging you people");

	while (1)
	{
		thread maps\_drones::large_group("left", node, 208, 15, undefined, randomint (5));
		wait (8);
		thread maps\_drones::large_group("right", node, 208, 15, undefined, randomint (5));
		wait (8);
	}
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

rs_axis_setup()
{
	aAxis = getaiarray("axis");
	for(i=0; i<aAxis.size; i++)
	{
		aAxis[i].maxsightdistsqrd = 10240000;
		aAxis[i].team = "neutral";
	}
}

intro_setup()
{	
	//Commissar setup
	
	aCommissars = getentarray("commissar", "script_noteworthy");
	for(i=0; i<aCommissars.size; i++)
	{
		aCommissars[i].dontavoidplayer = true;
		aCommissars[i].DrawOnCompass = false;
		aCommissars[i].suppressionwait = 0;
	}
	
	//Start the blocking starters in a crouch and don't give weapons to some of them
	
	t = 1;
	u = 2;
	
	aStarters = getentarray("rs_charge_starter", "script_noteworthy");
	for(i=0; i<aStarters.size; i++)
	{
		aStarters[i] allowedstances ("crouch");
		aStarters[i].dontavoidplayer = true;
		aStarters[i].team = "neutral";
		aStarters[i].DrawOnCompass = false;
		
		if(t==u)
		{
			aStarters[i].hasWeapon = false;
			u = u+1;
		}
		else
		{
		 	t++;
		}
	}
	
	//Extras come in from the three main rs_charge_spawner areas and take up positions around the debris and junk, crouched
	
	nIntro = 1;
	thread redsquare_friendlycollect(nIntro);
}

//***************************************************

force_crouch()
{
	level.player allowStand(false);
	level.player allowCrouch(true);
	level.player allowProne(false);
	
	wait 0.05;
	
	level.player freezeControls(true);
	
	level waittill ("starting final intro screen fadeout");
	//level waittill ("finished final intro screen fadein");
	
	wait 1;
	
	level.player allowStand(true);
	level.player allowProne(true);
}

intro()
{	
	nLeadCom = getent("lead_commissar", "targetname");
	nLeadCom.maxsightdistsqrd = 1960000;
	nLeadCom.animname = "commissar1";
	
	nLeadCom.weapon = "luger";
  	nLeadCom.hasweapon = true;
  	nLeadCom animscripts\shared::PutGunInHand("right");
  	
  	//anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
  	nLeadCom thread anim_loop_solo (nLeadCom, "idling", undefined, "stop idling");
	
	nMainGunCom = getent("commissar_main_gunner", "targetname");
	nMainGunCom.animname = "commissar2";
	nMainGunCom.maxsightdistsqrd = 1000000;
	nMainGunCom allowedstances ("crouch");
	
	nBackfieldCom = getent("backfield_enforcer", "targetname");
	nBackfieldCom.animname = "commissar3";
	
	nMainMG42 = getent("commissar_gunner_mg42", "targetname");
	nMainMG42.convergencetime = 0.05;
	nMainMG42 setTurretAccuracy(1);
	nMainMG42 makeTurretUnusable();
	
	nMainGunCom useturret(nMainMG42);
	
	nRearGuardCom = getent("commissar_backfield_mg42", "targetname");
	nRearGuardMG42 = getent("ledgemg42", "targetname");
	nRearGuardMG42 makeTurretUnusable();
	nRearGuardCom.animname = "commissar4";
	
	nRearGuardCom useturret(nRearGuardMG42);
	
	thread traitor_system(nLeadCom, nMainGunCom, nBackfieldCom, nRearGuardCom, nMainMG42, nRearGuardMG42);
	thread intro_mortar_squibs();
	
	nRetreatTalker1 = getent("retreater_talk1", "targetname");
	nRetreatTalker1.animname = "conscript1";
	
	nRetreatTalker2 = getent("retreater_talk2", "targetname");
	nRetreatTalker2.animname = "conscript2";
	
	nRetreatTalker3 = getent("retreater_talk3", "targetname");
	nRetreatTalker3.animname = "conscript3";
	
	level waittill ("finished final intro screen fadein");
	
	aAllies = [];
	aAllies = getaiarray("allies");
	for(i=0; i<aAllies.size; i++)
	{
		//aAllies[i].DrawOnCompass = false;
		
		if((isdefined(aAllies[i].script_commonname) && aAllies[i].script_commonname == "conscript") || (isdefined(aAllies[i].script_noteworthy) && aAllies[i].script_noteworthy == "intro_retreater"))
		{
			aAllies[i].DrawOnCompass = false;
		}
	}
	aAllies = undefined;
	
	thread intro_retreat_run();
	
	//Retreaters panicking, commissars urging on
	
	intro_retreat_speech(nRetreatTalker1, nRetreatTalker2, nRetreatTalker3, nLeadCom, nMainGunCom, nBackfieldCom);
	
	//Commissars open fire
	
	thread intro_commissars_fire_dialog(nLeadCom, nMainGunCom, nBackfieldCom);
	
	wait 1.5;
	
	//Pacify conscripts, then make the retreaters into enemies
	
	aAllies = [];
	aAllies = getaiarray("allies");
	for(i=0; i<aAllies.size; i++)
	{
		if(isdefined(aAllies[i].script_commonname) && aAllies[i].script_commonname == "conscript")
		{
			aAllies[i].pacifist = true;
		}
	}
	
	aRetreaters = getentarray("intro_retreater", "script_noteworthy");
	level.retreatpop = aRetreaters.size;
	
	for(i=0; i<aRetreaters.size; i++)
	{
		aRetreaters[i].maxsightdistsqrd = 1;
		aRetreaters[i].pacifist = true;
		thread intro_retreat_deathwaiter(aRetreaters[i]);
	}
	
	level notify ("stop the intro mortars");
	
	println("running INTRO RETREAT TARGETING");
	
	thread intro_retreat_targeting();

	println("GOING INTO retreatPOP = ", level.retreatpop);

	//MG42 commissar opens fire on the first wave
	
	while(level.retreatpop > 0)
	{
		println("retreatpoploop = ", level.retreatpop);
		wait 0.5;
	}
	
	//Commissars readying second wave
	
	intro_peptalk_speech(nLeadCom, nMainGunCom, nBackfieldCom);
	
	println("OK HERE WE GO!");
	
	startclipper = getent("startclipper", "targetname");
	startclipper delete();
	
	level notify ("start the charge");
	
	//Deploy the troops, begin monitoring population and spawning the replacements
	
	thread redsquare_assault();
	thread redsquare_axis_defense();
	thread redsquare_reinforcements();
	
	//Activate mortar related stuff
	
	thread redsquare_mortarkillzone();
	
	wait 1;
	
	maps\_utility::autosave(1);
	
	level.ambient_track ["outside"] = "ambient_redsquare_charge";
	thread maps\_utility::set_ambient("chargewalla");
}

intro_mortar_squibs()
{
	level endon("stop the intro mortars");
	
	aSquibs = getentarray("squib_mortar", "targetname");
	
	aSquibs = maps\_utility::array_randomize(aSquibs);
	
	while(1)
	{
		for(i=0; i<aSquibs.size; i++)
		{
			//range, max_damage, min_damage, fQuakepower, iQuaketime, iQuakeradius
			aSquibs[i] thread maps\_mortar::activate_mortar(2, 2, 0, 0.15, 0.5, 8000);
			wait 1 + randomfloat(4);
		}
		
		aSquibs = maps\_utility::array_randomize(aSquibs);
	}
}

intro_retreat_speech(nRetreatTalker1, nRetreatTalker2, nRetreatTalker3, nLeadCom, nMainGunCom, nBackfieldCom)
{
	if(isdefined(nRetreatTalker1) && isalive(nRetreatTalker1))
	{
		//Retreater 1 - DIALOG - It's no use! Fall back, comrades! Fall back!
		nRetreatTalker1 thread anim_single_solo (nRetreatTalker1, "itsnouse");
		//waittill_either (nRetreatTalker1, "itsnouse","death");
	}
	
	wait 1.4;
	
	if(isdefined(nRetreatTalker2) && isalive(nRetreatTalker2))
	{
		//Retreater 2 - DIALOG - Retreat! Retreat!
		nRetreatTalker2 thread anim_single_solo (nRetreatTalker2, "retreatretreat");
		//waittill_either (nRetreatTalker2, "retreatretreat","death");
	}
	
	wait 2.4;
	
	if(isdefined(nLeadCom) && isalive(nLeadCom))
	{
		//COMMISSAR1 - DIALOG - Turn around! Keep going forward!
		//nLeadCom thread anim_single_solo (nLeadCom, "turnaround");
		level thread intro_commissar_talkanim(nLeadCom, "turnaround");
		//waittill_either (nLeadCom, "turnaround","death");
	}
	
	wait 1.2;
	
	if(isdefined(nRetreatTalker3) && isalive(nRetreatTalker3))
	{
		//Retreater 3 - DIALOG - We're getting slaughtered up there! Fall back!
		nRetreatTalker3 thread anim_single_solo (nRetreatTalker3, "slaughteredupthere");
		//waittill_either (nRetreatTalker3, "slaughteredupthere","death");
	}
	
	wait 2;
	
	if(isdefined(nBackfieldCom) && isalive(nBackfieldCom))
	{
		//COMMISSAR2 - DIALOG - Pick up your gun and shoot!
		nBackfieldCom thread anim_single_solo (nBackfieldCom, "pickupyourgun");
		//waittill_either (nBackfieldCom, "pickupyourgun","death");
	}

	wait 1.8;
	
	if(isdefined(nMainGunCom) && isalive(nMainGunCom))
	{
		//COMMISSAR2 - DIALOG - No retreat! Not one step back!
		nMainGunCom thread anim_single_solo (nMainGunCom, "noretreat");
		//waittill_either (nMainGunCom, "noretreat","death");
	}
	
	wait 3;
	
	if(isdefined(nMainGunCom) && isalive(nMainGunCom))
	{
		//COMMISSAR2 - DIALOG - No mercy for cowards!
		nMainGunCom thread anim_single_solo (nMainGunCom, "nomercycowards");
		//waittill_either (nMainGunCom, "nomercycowards","death");
	}
	
	wait 1.3;
}

intro_commissar_talkanim(nLeadCom, alias)
{
	nLeadCom notify ("stop idling");
	nLeadCom thread anim_single_solo (nLeadCom, alias);
	nLeadCom waittill (alias);
	nLeadCom notify ("stop idling");
	nLeadCom thread anim_loop_solo (nLeadCom, "idling", undefined, "stop idling");
}

intro_commissars_fire_dialog(nLeadCom, nMainGunCom, nBackfieldCom)
{
	if(isdefined(nLeadCom) && isalive(nLeadCom))
	{
		//COMMISSAR1 - DIALOG - Open fire!
		
		level thread intro_commissar_talkanim(nLeadCom, "openfire");
		//nLeadCom notify ("stop idling");
		//nLeadCom thread anim_single_solo (nLeadCom, "openfire");
		//nLeadCom thread anim_loop_solo (nLeadCom, "idling", undefined, "stop idling");
		//waittill_either (nLeadCom, "openfire","death");
	}
	
	wait 0.7;
	
	if(isdefined(nBackfieldCom) && isalive(nBackfieldCom))
	{
		//COMMISSAR3 - DIALOG - Fire!
		nBackfieldCom thread anim_single_solo (nBackfieldCom, "fire");
		//waittill_either (nBackfieldCom, "fire","death");
	}
	
	wait 1;
	/*
	if(isdefined(nMainGunCom) && isalive(nMainGunCom))
	{
		//COMMISSAR2 - DIALOG - No mercy for deserters!
		nMainGunCom thread anim_single_solo (nMainGunCom, "nomercydeserters");
		//waittill_either (nMainGunCom, "nomercydeserters","death");
	}
	*/
	
	if(isdefined(nLeadCom) && isalive(nLeadCom))
	{
		//COMMISSAR1 - DIALOG - Traitors!
		level thread intro_commissar_talkanim(nLeadCom, "randomtraitor");
		//nLeadCom thread anim_single_solo (nLeadCom, "randomtraitor");
		//waittill_either (nLeadCom, "traitors","death");
	}
	
	wait 1.5;
	
	if(isdefined(nMainGunCom) && isalive(nMainGunCom))
	{
		//COMMISSAR1 - DIALOG - Traitors!
		nMainGunCom thread anim_single_solo (nMainGunCom, "randomtraitor2");
	}
}

intro_peptalk_speech(nLeadCom, nMainGunCom, nBackfieldCom)
{
	level notify ("music1");
	
	wait 4;
	
	nBackfieldCom thread animscripts\shared::LookAtEntity(level.player, 8, "casual");
	
	//COMMISSAR3 - No hesitation comrades! Do not take one step backwards!
	nBackfieldCom thread anim_single_solo (nBackfieldCom, "nohesitation");
	//nBackfieldCom OrientMode("face direction", level.player.origin-nBackfieldCom.origin ); 
	
	level notify ("start the drones");
	
	wait 4;
		
	//COMMISSAR1 - For Mother Russia comrades! Do not turn your back on her!
	
	level thread intro_commissar_talkanim(nLeadCom, "formotherrussia");
	//nLeadCom thread anim_single_solo (nLeadCom, "formotherrussia");
	wait(0.1);	// Otherwise he doesn't realize he's in a scripted animation and his lookat animations don't work.
	nLeadCom animscripts\shared::LookAtAnimations(level.scr_anim["commissar1"]["lookleft_formotherrussia"], level.scr_anim["commissar1"]["lookright_formotherrussia"]);
	nLeadCom thread animscripts\shared::LookAtEntity(level.player, 3, "casual");
	
	wait 5;
	
	nMainGunCom thread animscripts\shared::LookAtEntity(level.player, 4, "alert");
	
	//COMMISSAR2 - Victory or death!!
	nMainGunCom thread anim_single_solo (nMainGunCom, "victoryordeath");
	
	wait 2;
	
	//COMMISSAR1 - (Blows whistle)
	nLeadCom thread anim_single_solo (nLeadCom, "whistle");
}

intro_retreat_deathwaiter(nRetreater)
{
	nRetreater waittill("death");
	level.retreatpop--;
}

intro_retreat_run()
{
	//First wave retreating, sort and assign retreat nodes
	
	aRetreaters = getentarray("intro_retreater", "script_noteworthy");
	aRetreaterNodes = getnodearray("intro_retreat_node", "targetname");
	
	for(i=0; i<aRetreaters.size; i++)
	{
		aRetreaters[i].health = 5;
		aRetreaters[i].hasweapon = false;
		
		if(isdefined(aRetreaters[i].script_namenumber))
		{
			for(j=0; j<aRetreaterNodes.size; j++)
			{
				if(aRetreaters[i].script_namenumber == aRetreaterNodes[j].script_namenumber)
				{
					nRetreatNode = aRetreaterNodes[j];
					aRetreaters[i] allowedstances ("crouch");
					aRetreaters[i] setgoalnode(nRetreatNode);
					aRetreaters[i].goalradius = 8;
					aRetreaters[i].animplaybackrate = 0.8;
					break;
				}
			}
		}
	}
	
	wait 9;
}

intro_retreat_targeting()
{
	nMainGunCom = getent("commissar_main_gunner", "targetname");
	nMainMG42 = getent("commissar_gunner_mg42", "targetname");
	nMainMG42 setmode("manual");
	nMainMG42.convergencetime = 0.1;
	
	aRetreaters = getentarray("intro_retreater", "script_noteworthy");

	println("retreat pop is = ", level.retreatpop);

	while(level.retreatpop > 0)
	{
		for(i=0; i<aRetreaters.size; i++)
		{
			if(isdefined(aRetreaters[i]) && isalive(aRetreaters[i]))
			{
				nDist = length(nMainMG42.origin - aRetreaters[i].origin);
				
				if(!(isdefined(nOldDist)))
				{	
					nOldDist = nDist;
					nClosestGuy = aRetreaters[i];
				}
				
				if(nDist < nOldDist)
				{
					nOldDist = nDist;
					nClosestGuy = aRetreaters[i];
				}
			}	
		}
		
		nOldDist = undefined;

		thread mg42fire(nMainGunCom, nMainMG42, nClosestGuy);
		wait 0.5;
	}
}

//***************************************************

rs_mortar_barrage()
{
	//Activate a barrage for ambience
	
	nRS_MortarTrig = getent("startbarrage", "targetname");
	nRS_MortarTrig waittill ("trigger");
	
	//railyard_style(fRandomtime, iMaxRange, iMinRange, iBlastRadius, iDamageMax, iDamageMin, fQuakepower, iQuaketime, iQuakeradius)
	
	thread maps\_mortar::railyard_style(1, 6000, 100, undefined, undefined, undefined, 0.18, 2, 4250);
}

rs_barrage_control()
{
	level.iStopBarrage = 1;
	wait 6;
	level.iStopBarrage = 0;
	wait 0.5;
	thread maps\_mortar::railyard_style(10, 6000, 100, undefined, undefined, undefined, 0.18, 2, 4250, 1);
	level waittill ("rs_victory");
	level.iStopBarrage = 1;
	wait 2;
	level.iStopBarrage = 0;
	wait 0.5;
	thread maps\_mortar::railyard_style(20, 6000, 100, undefined, undefined, undefined, 0.18, 2, 4250,1);
}

redsquare_reinforcements()
{
	//level endon("rs_victory");
	level endon ("redsquare is under soviet control");
	level.rs_assault_on = 1;

	while(1)
	{
		if(level.redsquare_active == 1)
		{
			wait 3;
			thread redsquare_friendlycollect();
		}
		else
		{
			level waittill("player is near redsquare");
		}
	}
}

redsquare_proxcheck_near()
{
	nRedsquare_proxtrig_near = getent("rs_proxtrig_near", "targetname");
	
	while(1)
	{
		nRedsquare_proxtrig_near waittill("trigger");
		level.redsquare_active = 1;
		level notify ("player is near redsquare");
		println("APPROACHING RED SQUARE");
	}
}

redsquare_proxcheck_near2()
{
	nRedsquare_proxtrig_near = getent("rs_proxtrig_near2", "targetname");
	
	while(1)
	{
		nRedsquare_proxtrig_near waittill("trigger");
		level.redsquare_active = 1;
		level notify ("player is near redsquare");
		println("APPROACHING RED SQUARE");
	}
}

redsquare_proxcheck_far()
{
	nRedsquare_proxtrig_far = getent("rs_proxtrig_far", "targetname");
	
	while(1)
	{
		nRedsquare_proxtrig_far waittill("trigger");
		level.redsquare_active = 0;
		println("LEAVING RED SQUARE");
	}
}

redsquare_proxcheck_far2()
{
	nRedsquare_proxtrig_far = getent("rs_proxtrig_far2", "targetname");
	
	while(1)
	{
		nRedsquare_proxtrig_far waittill("trigger");
		level.redsquare_active = 0;
		println("LEAVING RED SQUARE");
	}
}

redsquare_friendlycollect(nIntro)
{
	level endon ("redsquare is under soviet control");
	
	aSpawners = getspawnerarray();
	
	aRedspawners1 =[];
	aRedspawners2 =[];
	aRedspawners3 =[];
	
	for(i=0; i<aSpawners.size; i++)
	{
		if(isdefined(aSpawners[i].script_noteworthy) && aSpawners[i].script_noteworthy == "rs_charge_spawner1")
		{
			//aRedspawners1 = maps\_utility::add_to_array(aRedspawners1, aSpawners[i]);
			aRedspawners1[aRedspawners1.size] = aSpawners[i];							
		}
		else
		if(isdefined(aSpawners[i].script_noteworthy) && aSpawners[i].script_noteworthy == "rs_charge_spawner2" && !(isdefined(nIntro)))
		{
			//aRedspawners2 = maps\_utility::add_to_array(aRedspawners2, aSpawners[i]);							
			aRedspawners2[aRedspawners2.size] = aSpawners[i];
		}
		else
		if(isdefined(aSpawners[i].script_noteworthy) && aSpawners[i].script_noteworthy == "rs_charge_spawner3" && !(isdefined(nIntro)))
		{
			//aRedspawners3 = maps\_utility::add_to_array(aRedspawners3, aSpawners[i]);							
			aRedspawners3[aRedspawners3.size] = aSpawners[i];
		}
	}
	
	thread redsquare_redspawn(aRedspawners1, 1.3, 4);
	thread redsquare_redspawn(aRedspawners2, 2, 3);
	thread redsquare_redspawn(aRedspawners3, 3, 2.5);
}

redsquare_redspawn(aRedspawners, minGap, randomGapAdd)
{
	//Parameters: array, minTimeGap, randomTimeGapAdd
	
	t = 1;
	u = 2;
	
	for(i=0; i<aRedspawners.size; i++)
	{
		nDestNode = getnode(aRedspawners[i].target, "targetname");
		
		aAllies = getaiarray("allies");
		iAlliedPop = aAllies.size;
		aAllies = undefined;
		
		if(iAlliedPop <= level.rs_alliedpoplimit)
		{
			nConscript = aRedspawners[i] doSpawn();	
			aRedspawners[i].count = 50;	//infinite capacity
			if(isdefined(nConscript))
			{
				nConscript.health = 10;	
				nConscript.accuracy = 0.01;
				nConscript.team = "neutral";
				nConscript.DrawOnCompass = false;
				if(t==u)
				{
					//nConscript.hasWeapon = false;
					u = u+1;
				}
				else
				{
		 			t++;
				}
		
				nConscript.dontavoidplayer = true;
				level thread redsquare_conscript_nav(nConscript, nDestNode);
				wait (minGap + randomfloat(randomGapAdd));
			}
		}
	}
}

redsquare_conscript_nav(nConscript, nDestNode)
{
	nConscript endon ("death");
	level endon ("redsquare is under soviet control");
	
	if(level.rs_victory)
	{
		return;
	}
	
	nConscript.goalradius = 64;
	nConscript waittill ("goal");
	
	while(1)
	{
		if(isdefined(nDestNode.target))
		{
			nNextNode = getnode(nDestNode.target, "targetname");
			nConscript setgoalnode(nNextNode);
			nConscript waittill ("goal");
			nDestNode = nNextNode;
		}
		else
		{
			break;
		}
	}
	
	if(level.rs_assault_on == 1)
	{
		level thread redsquare_backup_assault(nConscript);
	}
}

redsquare_roar_left()
{
	level endon("rs_victory");
	
	
	//for(j=0; j<2; j++)
	//{
		aRoars = [];
		
		for(i=1; i<16; i++)
		{
			aRoars[aRoars.size] = "Redsquare_walla" + i;	
		}
		
		aRoars = maps\_utility::array_randomize(aRoars);
		
		for(i=0; i<aRoars.size; i++)
		{
			thread maps\_utility::playSoundinSpace(aRoars[i], (-261, -1053, 93));
			println("Playing scream: ", aRoars[i]);
			wait (0.15 + randomfloat(1.1));
		}
		
		//wait 3.5;
	//}
}

redsquare_roar_right()
{
	level endon("rs_victory");
	
	//for(j=0; j<2; j++)
	//{
		aRoars = [];
		
		for(i=1; i<16; i++)
		{
			aRoars[aRoars.size] = "Redsquare_walla" + i;	
		}
		
		aRoars = maps\_utility::array_randomize(aRoars);
		
		for(i=0; i<aRoars.size; i++)
		{
			thread maps\_utility::playSoundinSpace(aRoars[i], (2456, -1496, 260));
			println("Playing scream: ", aRoars[i]);
			wait (0.2 + randomfloat(0.8));
		}
		
		//wait 3.5;
	//}
}

redsquare_center_roar(nStarter, walla)
{
	nStarter endon ("death");
	
	if(isalive(nStarter))
	{
		nStarter playsound(walla);
			
	}
}

redsquare_roarcontrol()
{
	wait 6;
	thread redsquare_roar_left();
	thread redsquare_roar_right();
}

redsquare_assault()
{
	//println("REDSQUARE ASSAULT");
	
	aChargeStarts = getnodearray("chargestart_node", "script_noteworthy");
	
	//println("aFriendlies.size = ", aFriendlies.size);
	//println("aChargeStarts.size = ", aChargeStarts.size);
	
	aStarters = getentarray("rs_charge_starter", "script_noteworthy");
	for(i=0; i<aStarters.size; i++)
	{
		aStarters[i].team = "allies";
		aStarters[i].health = 30;
		
		if(i>0 && i<16)
		{
			walla = "Redsquare_walla" + i;
			println("SCREAMING NOW");
			level thread redsquare_center_roar(aStarters[i], walla);
		}
	}
	
	thread redsquare_roarcontrol();
	
	aNeutrals = getaiarray("neutral");
	for(i=0; i<aNeutrals.size; i++)
	{
		if(isdefined(aNeutrals[i].script_commonname) && aNeutrals[i].script_commonname == "conscript")
		{
			aNeutrals[i].team = "allies";
		}
	}
	
	wait 0.05;
	
	aFriendlies = getaiarray("allies");
	
	for(i=0; i<aFriendlies.size; i++)
	{
		aFriendlies[i].interval = 32;
		
		if(isdefined(aFriendlies[i]) && isdefined(aFriendlies[i].script_commonname) && aFriendlies[i].script_commonname == "conscript")
		{
			for(j=0; j<aChargeStarts.size; j++)
			{
				if(aFriendlies[i].script_namenumber == aChargeStarts[j].script_namenumber)
				{
					level thread redsquare_routing(aFriendlies[i], aChargeStarts[j]);
					//println("Match found at ", i);
				}
			}
		}
	}
	
	aChargeStarts = undefined;
	aFriendlies = undefined;
}

redsquare_backup_assault(nConscript)
{
	//println("REDSQUARE ASSAULT");
	
	aChargeStarts = getnodearray("chargestart_node", "script_noteworthy");
	
	for(j=0; j<aChargeStarts.size; j++)
	{
		if(nConscript.script_namenumber == aChargeStarts[j].script_namenumber)
		{
			level thread redsquare_routing(nConscript, aChargeStarts[j]);
			nConscript.team = "allies";
			//println("Match found at ", i);
		}
	}
	
	aChargeStarts = undefined;
}

redsquare_routing(nSoldier, nStartNode)
{
	nSoldier endon("death");
	level endon ("redsquare is under soviet control");
	
	nSoldier.bravery = 1000000;
	nSoldier.goalradius = 80;
	nSoldier.suppressionwait = 0;
	nSoldier setgoalnode(nStartNode);
	nCurrentNode = nStartNode;
	
	while(1)
	{
		nSoldier waittill ("goal");
		
		if(isdefined(nNextNode))
		{
			nCurrentNode = nNextNode;
		}
		
		//Check for a pausenode and test for occupation and assign or not
		/*
		if(isdefined(nCurrentNode) && isdefined(nCurrentNode.script_nodestate))
		{
			strNodeState = nCurrentNode.script_nodestate;
			
			println("nCurrentNode.targetname = ", nCurrentNode.targetname, " script_nodestate = ", nCurrentNode.script_nodestate);
		
			if(isdefined(nCurrentNode.script_noteworthy) && nCurrentNode.script_noteworthy == "pausenode" && isdefined(strNodeState) && strNodeState == "vacant")
			{
				nTest = randomint(level.rs_pausechance);
				if(nTest == 1)
				{
					nCurrentNode.script_nodestate = "occupied";
					wait (level.rs_pausebase + randomfloat(level.rs_pausetime));	//take refuge at the pausenode for a bit
					nCurrentNode.script_nodestate = "vacant";
				}
			}
		}
		*/
		//Move to the next node if there is one, or switch to squad_assault suicide mission
		
		if(isdefined(nCurrentNode) && isdefined(nCurrentNode.target))
		{
			nNextNode = getnode(nCurrentNode.target, "targetname");
			//println(nCurrentNode.target);
			nSoldier setgoalnode(nNextNode);
		}
		else
		{
			if(isdefined(nCurrentNode) && isdefined(nCurrentNode.script_commonname) && nCurrentNode.script_commonname == "terminalnode")
			{
				println("REACHED TERMINAL NODE");
				
				aAsltNodes = getnodearray("assaultnode", "script_noteworthy");
				
				if(isdefined(nCurrentNode.script_assaultnode))
				{	
					for(k=0; k<aAsltNodes.size; k++)
					{
						if(aAsltNodes[k].targetname == nCurrentNode.script_assaultnode)
						{
							level thread redsquare_advance(nSoldier, aAsltNodes[k]);		
						}
					}
				}
			}
			break;
		}
	}
}

redsquare_advance(nSoldier, nNode)
{
	nSoldier endon("death");
	level endon ("redsquare is under soviet control");
	
	println("I'm attacking");
	
	nSoldier setgoalnode(nNode);
	nSoldier.goalradius = nNode.radius;
	
	fClosureRate = 0.85;
	fWaitMin = 0.2;
	fWaitMax = 3;
	
	while(nSoldier.goalradius > 384)
	{
		wait (randomfloatrange(fWaitMin,fWaitMax));
		nSoldier.goalradius = nSoldier.goalradius * fClosureRate;
		nSoldier waittill("goal");	
	}
}

rs_tank_setup()
{
	level.eTankLeft = getent("tank_left", "targetname");
	level.eTankRight = getent("tank_right", "targetname");
	
	level.eTankLeft thread maps\_panzerIV::kill();
	level.eTankRight thread maps\_panzerIV::kill();
	
	//level thread tank_kill(level.eTankLeft);
	//level thread tank_kill(level.eRight);
	
	nLeftTankNode = getVehicleNode("tank_left_start", "targetname");
	nRightTankNode = getVehicleNode("tank_right_start", "targetname");
	
	level.eTankLeft attachPath(nLeftTankNode);
	level.eTankRight attachPath(nRightTankNode);
	
	level.eTankLeft thread maps\_tankgun::mginit();
	level.eTankLeft thread maps\_tankgun::mgoff();
	
	level.eTankRight thread maps\_tankgun::mginit();
	level.eTankRight thread maps\_tankgun::mgoff();
	
	level.eTankRight.health = 1000000;
	level.eTankLeft.health = 1000000;
}

redsquare_axis_defense()
{	
	level endon ("rs_victory");

	wait 2;
	aAxis = getaiarray("neutral");
	for(k=0; k<aAxis.size; k++)
	{
		aAxis[k].team = "axis";
	}

	//Tank MG42s open fire

	level.eTankRight.script_team = "axis";
	level.eTankLeft.script_team = "axis";

	level.eTankRight thread maps\_tankgun::mgon();
	level.eTankLeft thread maps\_tankgun::mgon();

	level.iArmyPause = 1;	//activate
	
	if (getcvar ("scr_redsquare_fast") == "1")
	{
		level.nRosterLimit = 6;	
	}
	else
	{
		level.nRosterLimit = 12;	
	}
	
	while(level.iArmyPause != 0)
	{
		//squad_assault(strSquadName, strType, iAxisAcc, iAlliedAcc, iRosterMax, iInterval, iAxisSuppWait, iAlliesSuppWait, nTeamLimit)
		
		thread squad_assault(level.strAlpha, "spawner", 0.5, undefined, level.nRosterLimit, 64, 0.01, undefined, 1);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strGamma, "spawner", 0.5, undefined, level.nRosterLimit, 64, 0.01, undefined, 1);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strEpsilon, "spawner", 0.5, undefined, level.nRosterLimit, 64, 0.01, undefined, 1);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strBeta, "spawner", 0.5, undefined, level.nRosterLimit, 8, 0.01, undefined, 1);
		wait(level.fSpawnInterval);
		thread squad_assault(level.strDelta, "spawner", 0.5, undefined, level.nRosterLimit, 8, 0.01, undefined, 1);
		wait(level.fSpawnInterval);
	}
}

redsquare_mortarkillzone()
{
	level endon("redsquare is under soviet control");
	zone = getent("rs_mortarkilltrigger", "targetname");
	
	while(1)
	{
		zone waittill("trigger");
		thread redsquare_mortarkillzone_timer();
		thread redsquare_mortarkillzone_areacheck(zone);
		level waittill("reset_killtimer");
		level notify ("reset_areacheck");
	}
}

redsquare_mortarkillzone_timer()
{
	level endon("reset_killtimer");
	level endon("rs_victory");
	
	wait(0.5 + randomfloat(1));
	thread redsquare_mortarkillplayer();
}

redsquare_mortarkillzone_areacheck(zone)
{
	level endon("reset_areacheck");
	level endon("redsquare is under soviet control");
	
	while(1)
	{
		if(!(level.player istouching(zone)))
		{
		 	level notify ("reset_killtimer");
		}
		wait 0.1;
	}
}

redsquare_mortarkillplayer()
{
	level.player playsound ("mortar_incoming1");
	
	origin = (level.player getorigin() + (0,8,2));
	range = 420;
	maxdamage = level.player.maxhealth + 1000;
	mindamage = level.player.maxhealth + 1000;
	
	wait 0.7;

	println("PLAYER IS HIT!!!!!!");

	level.player thread maps\_mortar::mortar_sound();
	playfx (level.mortar, level.player.origin);
	radiusDamage(level.player.origin, range, maxdamage, mindamage);
	playfx (level.eTankShellFX, origin);
	earthquake(0.75, 2, origin, 2250);
}

smartguy_wave()
{
	level endon ("smartguy meets player");
	
	level.nSmartGuy lookat(level.player, 1);
	//level.nSmartGuy OrientMode("face direction", level.player.origin-level.nSmartGuy.origin ); 
	
	while(1)
	{
		
		level.nSmartGuy thread anim_single_solo (level.nSmartGuy, "wave");
		waittill_either (level.nSmartGuy, "wave","death");
		
		wait 2;
	}
}

lookat (ent, timer)
{
	if (!isdefined (timer))
		timer = 10000;
		
	self animscripts\shared::lookatentity(ent, timer, "alert");
}

smartguy_setup()
{	
	thread smartguy_lead_event();
	
	if(isdefined(level.nSmartGuy) && isalive(level.nSmartGuy))
	{	
		level.nSmartGuy thread maps\_utility::magic_bullet_shield();
		level.nSmartGuy.ignoreme = 1;
		level.nSmartGuy.suppressionwait = 0;
		
		nSmartStart = getnode("smartguy_startspot", "targetname");

		level.nSmartGuy setgoalnode(nSmartStart);
		level.nSmartGuy.accuracy = 0.86;
		level.nSmartGuy.goalradius = 72;
		level.nSmartGuy.animname = "smartguy";
		level.nSmartGuy.dontavoidplayer = true;
	}
	
	fDist = length(level.nSmartGuy.origin - level.player.origin);
	
	//Wait for him to get close enough to the player
	
	thread smartguy_wave();
	
	while(fDist > 220)
	{
		fDist = length(level.nSmartGuy.origin - level.player.origin);
		wait 0.1;
	}
	
	level notify ("smartguy meets player");
	
	level.nSmartGuy allowedstances("crouch");
	
	wait 0.8;
	
	level.nSmartGuy animscripts\shared::LookAtEntity(level.player, 8, "alert");
	
	//DIALOG - Sgt. Makarov - Listen, comrade! We're both dead men, whether we stay here, or go back! Let's you and I find a way to flank them!
	
	level.nSmartGuy thread anim_single_solo (level.nSmartGuy, "findwaytoflank");
	
	//level.nSmartGuy OrientMode("face direction", level.player.origin-level.nSmartGuy.origin ); 

	waittill_either (level.nSmartGuy, "findwaytoflank","death");
	
	level notify ("objective2");
	
	badplacenode = getnode("badplace_refnode", "targetname");
	badplace_cylinder("tankbadplace", -1, badplacenode.origin, badplacenode.radius, 512, "allies");
	
	//Soft pause
	
	wait 1.5;
	
	chain = maps\_utility::get_friendly_chain_node ("smartguychain");
	level.player setFriendlyChain(chain);
	
	//Turn off Barney mode
	
	level.nSmartGuy.followmin = -2;
	level.nSmartGuy.followmax = -1;
	level.nSmartGuy.dontavoidplayer = false;
	level.nSmartGuy setgoalentity(level.player);
	level.nSmartGuy allowedstances("crouch", "stand");
	
	//Wait for player to get close enough to notice
	
	nProxCharge = getent("wall_proximity_detector", "targetname");
	fProxDist = length(nProxCharge.origin - level.player.origin);
	
	while(fProxDist > 780)
	{
		fProxDist = length(nProxCharge.origin - level.player.origin);
		wait 0.25;	
	}
	
	thread rs_barrage_control();
	
	//Blow open the access point
	
	array = getentarray("squib_wallprep", "targetname");
	for(i=0; i<array.size; i++)
	{
		array[i] thread activate_mortar_redsquare(512, 40, 10, 0.15, 0.5, 8000);
		wait (0.2 + randomfloat(0.2));
	}
	
	nWallBreakSquib = getent("squib_wallbreaker", "targetname");
	nWallBreakSquib thread activate_mortar_redsquare(512, 40, 10, 0.15, 0.5, 8000, 1);

	level waittill ("walldestruction");
	
	maps\_utility::exploder (1);	//set off any script_brushmodel with a script_exploder of 1
	
	fSmartDist = length(level.nSmartGuy.origin - nProxCharge.origin);
	
	if(fSmartDist < 1464)
	{
		//DIALOG - Sgt. Makarov - Alexei, over there!
		
		level.nSmartGuy animscripts\shared::LookAtEntity(level.player, 5, "alert");
		level.nSmartGuy thread anim_single_solo(level.nSmartGuy, "alexeioverthere");
	}
	
	smartholdnode = getnode("alertwatchnode", "targetname");
	
	level.nSmartGuy setgoalnode(smartholdnode);
	
	aSappers = getentarray("sapper","targetname");
	maps\_spawner::flood_spawn (aSappers);
}

smartguy_lead_event()
{
	nLeadTrigger = getent("smartguy_lead_trigger", "targetname");
	nLeadTrigger waittill ("trigger");
	
	level.nSmartGuy.followmin = 1;
	level.nSmartGuy.followmax = 2;
}

perch_reached()
{
	level endon ("rs_victory");
	
	nPerchTrig = getent("perch_reached", "targetname");
	nPerchTrig waittill("trigger");
	
	nRoostDetectTrigger = getent("roost_detect_trigger", "targetname");
	
	level.ambient_track ["outside"] = "ambient_redsquare_ext";
	
	if(!(level.player istouching(nRoostDetectTrigger)))
	{
		thread maps\_utility::set_ambient("outside");
	}
	
	level notify("stop charging you people");
	
	thread redsquare_chains_off();
	
	nSmartGuyPerch = getnode("smartguy_finaldest", "targetname");
	
	level.nSmartGuy.goalradius = 64;
	level.nSmartGuy setgoalnode(nSmartGuyPerch);
	
	level notify("objective3");
	
	level.nRosterLimit = 14;
	
	level.nSmartGuy waittill ("goal");
	
	nRoostDetectTrigger = getent("roost_detect_trigger", "targetname");
	
	while(!level.officersdead)
	{
		if(level.player istouching(nRoostDetectTrigger) && !level.officersdead)
		{
			//DIALOG - Sgt. Makarov - Take down the officers first! They're calling in reinforcements!
			level.nSmartGuy thread anim_single_solo(level.nSmartGuy, "officersfirst");
			waittill_either (level.nSmartGuy, "officersfirst","death");
		}
		
		wait 40;
	}
}

enemy_officers()
{
	nOfficerTrig = getent("officer_spawntrig", "targetname");
	nOfficerTrig waittill("trigger");
	
	aOfficers = [];
	aOfficers = getentarray("special_officer", "targetname");
	level.officerpop = aOfficers.size;
	println("+++++OFFICER POP is = ", level.officerpop);
	
	thread enemy_officer_deathtracker();
	
	for(i=0; i<aOfficers.size; i++)
	{
		nOfficer = aOfficers[i] dospawn();
		if(isdefined(nOfficer) && isalive(nOfficer))
		{
			//nOfficer.goalradius = 4;
			nOfficer thread maps\_utility::magic_bullet_shield();
			//nOfficer.team = "neutral";	//no one but the player can attack
			level thread enemy_officer_deathwaiter(nOfficer);
			level thread enemy_officer_animate(nOfficer);
		}
	}
}

enemy_officer_animate(nOfficer)
{
	nOfficer endon ("death");
	
	nNode = getnode(nOfficer.target, "targetname");
	guy[0] = nOfficer;
	wait 0.05;
	nOfficer.maxsightdistsqrd = 25;
	nOfficer.pacifist = true;
	nOfficer.bravery = 100000000000;
	nOfficer setgoalnode(nNode);
	nOfficer.goalradius = 64;
	nOfficer waittill("goal");
	println("+++++++++ I GOT TO MY GOAL!");
	
	level thread enemy_officer_damagecheck(nOfficer);
	
	nOfficer.animname = "waving guy";
	
	maps\_anim::anim_loop ( guy, "idle", undefined, undefined, nNode);
}

enemy_officer_damagecheck(nOfficer)
{
	nOfficer.allowdeath = true;
	nOfficer notify ("stop magic bullet shield");		
	nOfficer.health = 15;
}

enemy_officer_deathwaiter(nOfficer)
{
	nOfficer waittill("death");
	level notify ("officer died");
}

enemy_officer_deathtracker()
{
	while(level.officerpop > 0)
	{
		level waittill("officer died");
		level.officerpop--;
	}
	
	level notify("objective1");
	thread redsquare_victory();
	level.officersdead = 1;
	
	level notify("stop enemy reinforcements");
	
	thread enemy_firingline();
}

enemy_firingline()
{
	aLinetroops = [];
	aLinetroops = getentarray("linetroop", "script_noteworthy");
	level.linetroopspop = aLinetroops.size;
	println("+++++LINE TROOP POP is = ", level.linetroopspop);
	
	thread enemy_linetroop_deathtracker();
	
	for(i=0; i<aLinetroops.size; i++)
	{
		if(!(isalive(aLinetroops[i])))
		{
			continue;
		}
		
		level thread enemy_linetroop_deathwaiter(aLinetroops[i]);
		level thread enemy_linetroop_kill(aLinetroops[i]);
	}
}

enemy_linetroop_deathtracker()
{
	while(level.linetroopspop > 0)
	{
		level waittill("linetroop died");
		level.linetroopspop--;
	}
}

enemy_linetroop_deathwaiter(nLineTroop)
{
	nLineTroop waittill("death");
	level notify ("linetroop died");
}

enemy_linetroop_kill(nLineTroop)
{	
	nLineTroop endon ("death");
	
	wait (randomintrange(2,4) + randomfloat(2));
	nLineTroop doDamage (nLineTroop.health + 10050, (0,0,0));
}

redsquare_victory()
{
	level.nSmartGuy endon("death");
	level notify ("rs_victory");	
	
	level.nSmartGuy.goalradius = 8;
	level.nSmartGuy.accuracy = 0.9;
	
	// Let the player approach a bit first, then have smartguy lead back down
	
	nRoostDetectTrigger = getent("roost_detect_trigger", "targetname");
	
	if(level.player istouching(nRoostDetectTrigger))
	{
		dist = length(level.nSmartGuy.origin - level.player.origin);
	
		while(dist > 256)
		{
			dist = length(level.nSmartGuy.origin - level.player.origin);	
			wait 0.05;
		}
		
		thread redsquare_victory_smartguy_behavior();
		
		nSmartDetachTrig = getent("smartguy_goodbye_trigger", "targetname");
		nSmartDetachTrig waittill("trigger");
	}
	else
	{
		thread redsquare_victory_smartguy_behavior();
	}
	
	thread redsquare_line_barrage();
	
	thread redsquare_tank_sequence();
	
	level waittill("tanks are all dead");
	
	level notify ("redsquare is under soviet control");
	
	//The rest here is non-essential stuff that makes Makarov talk if the player is near him, reinforcing the player's objective
	
	orderdist = length(level.nSmartGuy.origin - level.player.origin);
	
	while(orderdist > 512)
	{
		orderdist = length(level.nSmartGuy.origin - level.player.origin);	
		wait 0.05;
	}
	
	level.nSmartGuy animscripts\shared::LookAtEntity(level.player, 100000, "alert");
	
	//DIALOG - Sgt. Makarov - Get word to Major Zubov that we've retaken Red Square. You'll report to him from here on out.
	level.nSmartGuy thread anim_single_solo(level.nSmartGuy, "gotozubov");

	level.nSmartGuy thread animscripts\shared::SetInCombat(false);

	level.nSmartGuy notify ("stop magic bullet shield");
	level.nSmartGuy allowedstances("crouch");	
	
	level.nSmartGuy.team = "allies";
}

redsquare_victory_smartguy_behavior()
{
	level.nSmartGuy setgoalentity(level.player);
		
	chain = maps\_utility::get_friendly_chain_node ("smartguychain");
	level.player setFriendlyChain(chain);
	
	level.nSmartGuy.followmin = -1;
	level.nSmartGuy.followmax = 1;
	level.nSmartGuy.animplaybackrate = 1.1;
	
	level.nSmartGuy.team = "allies";
}

redsquare_line_barrage()
{
	//russian_artillery_blast 
	
	aLineSquibs = getentarray("russian_artillery_blast", "targetname");
	
	for(n=0; n<2; n++)
	{
		for(i=0; i<aLineSquibs.size; i++)
		{
			aLineSquibs[i] thread activate_mortar_redsquare(512, 400, 300, 0.15, 0.5, 8000);
			wait 0.25;
		}
	}
}

redsquare_tank_sequence()
{		
	//russian_artillery_blast_tank1
	//russian_artillery_blast_tank_directhit1
	
	//russian_artillery_blast_tank2
	//russian_artillery_blast_tank_directhit2
	
	level thread redsquare_tank_damage(level.eTankRight, "russian_artillery_blast_tank1", "russian_artillery_blast_tank_directhit1");
	wait 0.2;
	level thread redsquare_tank_damage(level.eTankLeft, "russian_artillery_blast_tank2", "russian_artillery_blast_tank_directhit2");
	
	while(level.tankstatus < 2)
	{
		wait 0.05;
	}
	
	level notify("tanks are all dead");
}

redsquare_tank_damage(eTank, strBlasts, strHit)
{
	aTankBarrageSquibs = getentarray(strBlasts, "targetname");
	nTankHitSquib = getent(strHit, "targetname");
	
	for(i=0; i<aTankBarrageSquibs.size; i++)
	{
		aTankBarrageSquibs[i] thread activate_mortar_redsquare(512, 40, 10, 0.15, 0.5, 8000);
		wait (aTankBarrageSquibs.size / 2.237);
	}
	
	nTankHitSquib thread activate_mortar_redsquare(512, 40, 10, 0.15, 0.5, 8000, undefined, 1);
	
	wait 2.237;
	
	wait 0.25;
	
	playfx ( level.altmortar, nTankHitSquib.origin+(0,0,256));
		
	origin = (eTank getorigin() + (0,8,2));
	range = 200;
	maxdamage = eTank.health;
	mindamage = eTank.health;
	wait 0.05;
		
	radiusDamage(origin, range, maxdamage, mindamage);
	
	level.tankstatus++;
}

tank_kill(eTank)
{
	eTank waittill( "death" );
	
	flameemitter = spawn("script_origin",etank.origin+(0,0,32));
	while(1)
	{
		playfx(level.fireydeath,flameemitter.origin);
		wait (randomfloat (0.15)+.1);
	}
}

redsquare_complete()
{
	nAcrossTrig = getent("redsquare_complete", "targetname");
	nAcrossTrig waittill("trigger");
	
	level notify("objective4");
	
	maps\_utility::autosave(4);
	
	level notify ("music2");
	
	thread church_sniper();
	
	level notify ("turn on bad place");
}

redsquare_chains_off()
{
	maps\_utility::chain_off ("buildingfloor");
	maps\_utility::chain_off ("stairwell1");
	maps\_utility::chain_off ("stairwell2");
	maps\_utility::chain_off ("stairwell3");
	maps\_utility::chain_off ("stairwell4");
	maps\_utility::chain_off ("stairwell5");
	maps\_utility::chain_off ("stairwell6");
}

//=========================== BACK HALF OF RED SQUARE AFTER THE TUNNEL =================================

church_sniper()
{     
        spawners = getentarray ("church_sniper", "targetname");
        for (i=0; i<spawners.size; i++)
		spawners[i] waittill ("spawned",snipers);
	
	level thread sniper_death(snipers);
	level thread sniper_time();
	
	level waittill ("sniper event");

	chain = maps\_utility::get_friendly_chain_node ("100");
	level.player SetFriendlyChain (chain);
}

sniper_death(snipers)
{
	snipers waittill ("death");
	level notify ("sniper event");
}

sniper_time()
{
	wait (17);
	level notify ("sniper event");
}

//=====================

objectives()
{
	objective_add(1, "active", &"REDSQUARE_GET_ACROSS_RED_SQUARE", (level.nSmartguy.origin));
	objective_current(1);
	
	level waittill ("objective2");
	
	objective_add(2, "active", &"REDSQUARE_FIND_A_GOOD_FLANKING", (level.sniperrifle.origin));
	objective_current(2);
	
	level waittill ("objective3");
	objective_state(2, "done");
	
	maps\_utility::autosave(3);
	
	objective_add(3, "active", "", (2776, 2720, 688));
	objective_string(3, &"REDSQUARE_ELIMINATE_THE_OFFICERS", level.officerpop);
	objective_current(3);
	
	level.rs_alliedpoplimit = 14;	//maintain this allied population in Red Square
	
	thread objective_officer_tracker();
	
	level waittill ("objective1");

	objective_add(3, "active", &"REDSQUARE_ELIMINATE_THE_OFFICERS_DONE");
	objective_state(3, "done");
	
	objective_add(1, "active", &"REDSQUARE_GET_ACROSS_RED_SQUARE", (level.acrossredsquare.origin));
	objective_current(1);
	
	level waittill("redsquare is under soviet control");
	
	objective_state(1, "done");
	
	objective_add(4, "active", &"REDSQUARE_RENDEZVOUS_WITH_MAJOR", (level.trainstationmarker.origin));
	objective_current(4);
	
	level waittill("objectives done");
	objective_state(4, "done");
}

objective_officer_tracker()
{	
	while(level.officerpop > 0)
	{
		level waittill ("officer died");
		wait 0.05;
		if(level.officerpop > 0)
		{
			objective_add(3, "active", "", (2776, 2720, 688));
			objective_string(3, &"REDSQUARE_ELIMINATE_THE_OFFICERS", level.officerpop);
			objective_current(3);
		}
	}
}

exitlevel()
{
	nExitTrig = getent("exit_trigger", "targetname");
	nExitTrig waittill("trigger");

	level notify ("objectives done");
	
	//temp delay loop
	/*
	for(i=8; i>0; i--)
	{
		println("Switching to trainstation in ", i, " seconds...");
		wait 1;
	}
	*/
	missionSuccess("trainstation", true);
}

//======================================================================================================================================//
//======================================================================================================================================//

//******************************************************//
//			MG42 UTILITIES			//
//******************************************************//

mg42fire(nGunner, eMG42, nTarget)
{
	level endon ("out of constraints");
	nGunner endon("death");
	nTarget endon("death");
	nTarget.team = "neutral";	
	
	fFirerate = 0.05;

	println("mg42fire called ");
	
	thread mg42_target(nTarget, eMG42, nGunner, nTarget);
	
	while(1)
	{
		if(!(isdefined(nTarget)) || !(isalive(nTarget)))
		{
			break;
		}
		
		i = 0;
		fTime = 0.23 + randomfloat(0.9);	//burst length
	
		//println("STILL SHOOTING");
		
		while(i < fTime)
		{
			eMG42 shootturret();
			wait fFirerate;
			i = i + 0.05;
		}
		
		wait (0.3 + randomfloat(0.3));	//pause between bursts	
	}
}

mg42_target(nTarget, eMG42, nGunner, nTarget)
{
	level endon ("out of constraints");
	nGunner endon("death");
	nTarget endon("death");
	
	while(1)
	{
		org = spawn ("script_origin",(nTarget.origin + (0, 0, 40)));
		eMG42 settargetentity(org);
		wait (eMG42.convergencetime);
		org delete();
	}
}

//******************************************************//
//		INFANTRY COMBAT UTILITIES		//
//******************************************************//

/*******************

Nodes per squad:

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

squad_assault(strSquadName, strType, iAxisAcc, iAlliedAcc, iRosterMax, iInterval, iAxisSuppWait, iAlliesSuppWait, nTeamLimit)
{	
	level endon("stop enemy reinforcements");
	
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
		iAlliesSuppWait = 0.01;		//suppressionwait of spawned allied troops
	}

	//***** Spawner or Preplaced - Create roster for specified squadname
	
	if(strType == "spawner")
	{
		aSpawner = getspawnerarray();	
		
		for(i=0; i<aSpawner.size; i++)
		{	
			//Check and don't spawn troops over the max number of enemies (before victory) or friendlies (at victory) allowed in the level
			//If nTeamLimit is set, only use the number of same team troops, and use iRosterMax as a team population cap
			
			aArmyRoster = getaiarray("axis");
			aFriendRoster = getaiarray("allies");
			
			if(isdefined(nTeamLimit))
			{
				nBodyCount = aArmyRoster.size;
			}
			else
			{
				nBodyCount = aFriendRoster.size + aArmyRoster.size;
			}
			
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
					nSoldier allowedStances ("stand", "crouch");
					nSoldier.maxsightdistsqrd = 100000000000;
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
	
	nSoldier endon ("death");
	
	nSoldier waittill("goal");

	//Send soldier to random entry node if any

	//Format: attack_move_node(nSoldier, fWaitMin, fWaitMax, fClosureRate, nGoalNode, fStartRadius, fEndRadius)

	if(aEntryNodes.size > 0)
	{
		nRndEntryNode = aEntryNodes[randomint(aEntryNodes.size)];			
		if(!isdefined(nRndEntryNode.radius))
		{
			nRndEntryNode.radius = 64;
		}
		if(nSoldier.team == "axis")
		{
			level attack_move_node(nSoldier, 0.5, 1.5, 0.6, nRndEntryNode, undefined, nRndEntryNode.radius);
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
		if(!isdefined(nRndContactNode.radius))
		{
			nRndContactNode.radius = 64;
		}
		if(nSoldier.team == "axis")
		{
			level attack_move_node(nSoldier, 2.4, 3.5, 0.96, nRndContactNode, undefined, nRndContactNode.radius);
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
	if(!isdefined(nCaptureNode.radius))
	{
		nCaptureNode.radius = 64;
	}
	if(nSoldier.team == "axis")
	{
		level attack_move_node(nSoldier, 3.3, 4.5, 0.95, nCaptureNode, undefined, nCaptureNode.radius);
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

//**********************************************//
//		TRAITOR UTILITIES		//
//**********************************************//

traitor_system(nLeadCom, nMainGunCom, nBackfieldCom, nRearGuardCom, nMainMG42, nRearGuardMG42)
{
	level waittill ("start the charge");
	
	nTraitorAreaTrig = getent("traitor_startarea_trigger", "targetname");
	nTraitorMG42aTrig = getent("traitor_mg42a_trigger", "targetname");
	nTraitorMG42bTrig = getent("traitor_mg42b_trigger", "targetname");
	
	//player is loitering, have commissars shout at him

	thread traitor_playercowering(nLeadCom, nMainGunCom, nBackfieldCom, nRearGuardCom, nMainMG42, nRearGuardMG42, nTraitorMG42aTrig, nTraitorMG42bTrig, nTraitorAreaTrig);
	
	thread traitor_loitering(nLeadCom, nMainGunCom, nBackfieldCom, nRearGuardCom, nMainMG42, nRearGuardMG42);
	thread traitor_startareaclear(nTraitorAreaTrig);
	thread traitor_mg42areacheck(nTraitorMG42aTrig);
	thread traitor_mg42areacheck(nTraitorMG42bTrig);
	
	thread traitor_mg42_reset_passive(nMainGunCom);
	thread traitor_mg42_reset_active(nMainGunCom, nTraitorMG42aTrig);
	
	thread traitor_mg42_reset_passive(nRearGuardCom);
	thread traitor_mg42_reset_active(nRearGuardCom, nTraitorMG42bTrig);
	
	while(1)
	{
		level waittill ("player has left the start area");
		
		nTraitorAreaTrig waittill ("trigger");	//Wait for player to reenter the start area
		
		//Commissars shout at and attack the player
		
		println("++++++++++++++TRAITOR YOU ARE A TRAITOR+++++++++++++++");
		thread traitor_attack(nLeadCom, nMainGunCom, nBackfieldCom, nRearGuardCom, nMainMG42, nRearGuardMG42, nTraitorMG42aTrig, nTraitorMG42bTrig);
	}
}

traitor_playercowering(nLeadCom, nMainGunCom, nBackfieldCom, nRearGuardCom, nMainMG42, nRearGuardMG42, nTraitorMG42aTrig, nTraitorMG42bTrig, nTraitorAreaTrig)
{
	level endon ("player has left the start area");
	
	wait 20;
	
	if(level.player istouching(nTraitorAreaTrig))
	{
		println("+++++++++++ LOITERING PERSON IS ATTACKED +++++++++++++");
		thread traitor_attack(nLeadCom, nMainGunCom, nBackfieldCom, nRearGuardCom, nMainMG42, nRearGuardMG42, nTraitorMG42aTrig, nTraitorMG42bTrig);	
	}
}

traitor_attack(nLeadCom, nMainGunCom, nBackfieldCom, nRearGuardCom, nMainMG42, nRearGuardMG42, mg42atrig, mg42btrig)
{	
	//Commissars with normal weapons attack the player
	
	if(isalive(nLeadCom))
	{
		level thread traitor_basicweapon(nLeadCom);
		level thread traitor_stopattack(nLeadCom);
	}
	
	if(isalive(nBackfieldCom))
	{
		level thread traitor_basicweapon(nBackfieldCom);
		level thread traitor_stopattack(nBackfieldCom);
	}
	
	//Commissars on MG42s attack the player
	
	if(isalive(nMainGunCom))
	{
		level thread traitor_mg42_attach(nMainGunCom, mg42atrig, nMainMG42);
		level thread traitor_mg42_detach(nMainGunCom, mg42atrig, nMainMG42);
	}
	
	if(isalive(nRearGuardCom))
	{
		level thread traitor_mg42_attach(nRearGuardCom, mg42btrig, nRearGuardMG42);
		level thread traitor_mg42_detach(nRearGuardCom, mg42btrig, nRearGuardMG42);
	}
}

traitor_mg42_attach(nGunner, mg42trigger, mg42)
{	
	nGunner endon ("death");
	level endon ("player has left the start area");
	
	while(1)
	{
		mg42trigger waittill ("trigger");
		
		//use the mg42, then manual mode, then attack player
		
		mg42 setmode("manual_ai");
		//mg42 setmode("manual");
		if(isalive(nGunner))
		{
			nGunner useturret(mg42);
			println("GETTING ON THE TURRET - ", nGunner.targetname);
		}
		
		mg42user = mg42 getTurretOwner();
		
		while(1)
		{
			if(!isdefined(mg42user))
			{
				mg42user = mg42 getTurretOwner();	
			}
			else
			{
				break;
			}
			wait 2;	//0.05
		}
		
		println("MG42 user is ", mg42user.targetname);
		
		nGunner.team = "neutral";
		mg42 settargetentity(level.player);
		
		i = 0;
		fTime = 0.23 + randomfloat(0.9);	//burst length
	
		//println("STILL SHOOTING");
		
		if(nGunner.targetname == "commissar_main_gunner")
		{
			level.gunon1 = 1;
		}
		
		if(nGunner.targetname == "commissar_backfield_mg42")
		{
			level.gunon2 = 1;
		}
		
		while(i < fTime)
		{
			mg42 shootturret();
			wait 0.05;
			i = i + 0.05;
		}
		
		if(nGunner.targetname == "commissar_main_gunner")
		{
			level.gunon1 = 0;
			level notify ("mg42a is open");
		}
		
		if(nGunner.targetname == "commissar_backfield_mg42")
		{
			level.gunon2 = 0;
			level notify ("mg42b is open");
		}
		
		wait 0.6;
	}	
}

traitor_mg42_detach(nGunner, trigger, mg42)
{
	nGunner endon ("death");
	level endon ("player has left the start area");
	
	while(1)
	{
		level waittill ("player has left the " + trigger.targetname + " area");
		
		if(nGunner.targetname == "commissar_main_gunner" && level.gunon1 == 1)
		{
			level waittill ("mg42a is open");
		}
		
		if(nGunner.targetname == "commissar_backfield_mg42" && level.gunon2 == 1)
		{
			level waittill ("mg42b is open");
		}
		
		nGunner stopuseturret();
		mg42 setmode("manual_ai");
		println("GUNNER STOPS USING TURRET NOW");
		nGunner animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
		nGunner.customtarget = (level.player);	
		
		nGunner.team = "neutral";
		
		wait 6;
	}
}

traitor_mg42_reset_passive(nGunner)
{
	nGunner endon ("death");
	
	while(1)
	{
		level waittill ("player has left the start area");
		nGunner notify ("end_sequence");
		wait 1;
	}
}

traitor_mg42_reset_active(nGunner, trigger)
{
	nGunner endon ("death");
	
	while(1)
	{
		level waittill ("player has entered the " + trigger.targetname + " area");
		nGunner notify ("end_sequence");
		wait 1;
	}
}

traitor_basicweapon(nCommissar)
{
	//Attack player procedure for the commissars not using an MG42
	
	nCommissar endon ("death");
	level endon ("player has left the start area");
	
	nCommissar animcustom (animscripts\scripted\stalingrad_cover_crouch::main);
	nCommissar.customtarget = (level.player);	
	
	while(isalive(level.player))
	{
		nCommissar.team = "neutral";
		wait 4;
		nCommissar.team = "allies";
		wait 1;
	}
}

traitor_stopattack(nCommissar)
{
	//Reverts commissar to non-aggressive mode
	
	nCommissar endon ("death");
	level waittill ("player has left the start area");

	nCommissar notify ("end_sequence");
}

traitor_startareaclear(trigger)
{
	//Monitors player's presence in the start area and notifies absence
	
	while(1)
	{
		if(level.player istouching(trigger))
		{
			//wait 0.05;
			wait 0.5;
		}
		else
		{
			level notify ("player has left the start area");
			//wait 0.05;
			wait 0.5;
		}
	}
}

traitor_mg42areacheck(trigger)
{
	//Monitors player's presence in an MG42 zone trigger
	
	while(1)
	{
		if(level.player istouching(trigger))
		{
			level notify ("player has entered the " + trigger.targetname + " area");
			//wait 0.05;
			wait 0.5;
		}
		else
		{
			level notify ("player has left the " + trigger.targetname + " area");
			//wait 0.05;
			wait 0.5;
		}
	}
}

traitor_loitering(nLeadCom, nMainGunCom, nBackfieldCom, nRearGuardCom, nMainMG42, nRearGuardMG42)
{
	//Terminates when player leaves the start area trigger, after that, reentry is strictly forbidden
	
	level endon ("player has left the start area");
	
	nTraitorAreaTrig = getent("traitor_startarea_trigger", "targetname");
	nTraitorMG42aTrig = getent("traitor_mg42a_trigger", "targetname");
	nTraitorMG42bTrig = getent("traitor_mg42b_trigger", "targetname");
	
	for(i=0; i<2; i++)
	{
		wait 5;
		
		if(level.player istouching(nTraitorAreaTrig))
		{
			if(isalive(nLeadCom))
			{
				//shout at player to move
				nLeadCom thread anim_single_solo (nLeadCom, "comeoncomeon");
			}			
			
			wait 2;
			
			if(isalive(nMainGunCom))
			{
				//shout at player to move
				nMainGunCom thread anim_single_solo (nMainGunCom, "pickupgun2");
			}
			
			wait 2;
			
			if(isalive(nBackFieldCom))
			{
				//shout at player to move
				nBackFieldCom thread anim_single_solo (nBackFieldCom, "movedamnyou");
			}
			
			wait 2;
			
			if(isalive(nRearGuardCom))
			{
				//shout at player to move
				nRearGuardCom thread anim_single_solo (nRearGuardCom, "turn2");
			}
			
			wait 4;
		}
	}
}


//**********************************************//
//		DIALOGUE UTILITIES		//
//**********************************************//

anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
{
	newguy[0] = guy;
	maps\_anim::anim_loop ( newguy, anime, tag, ender, node, tag_entity );
}

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
//		SAVE UTILITIES			//
//**********************************************//

move_with_player()
{
	nHappySaveTrigger = getent("special_savetrigger", "targetname");
	nHappySaveTrigger waittill ("trigger");
	
	//maps\_utility::autosave(2);
	
	level.nSmartGuy setgoalentity(level.player);
}

waittill_either_think (waiter, msg)
{
	self endon ("stop waiting for either");
	println ("^3waiting for ", msg);
	waiter waittill (msg);
	println ("^3got ", msg);
	self notify ("got notify");
}

waittill_either(waiter, msg1, msg2, msg3 )
{
	println ("^3", waiter.animname + " is waiting for ", msg1, " ", msg2, " ", msg3);
	ent = spawnstruct();
	if (isdefined (msg1))
		ent thread waittill_either_think(waiter, msg1);
	if (isdefined (msg2))
		ent thread waittill_either_think(waiter, msg2);
	if (isdefined (msg3))
		ent thread waittill_either_think(waiter, msg3);
		
	ent waittill ("got notify");
	ent notify ("stop waiting for either");
}

//**********************************************//
//	    SOUND AND MUSIC UTILITIES		//
//**********************************************//

music()
{
	level waittill ("music1");
	
	musicplay("redsquare_charge");
	
	wait 100;
	
	//musicplay("redsquare_tense");
	
	//wait 140;
	
	level waittill ("music2");
	
	while(1)
	{
		musicplay("redsquare_dark");
		wait 2;
	}
}

//*************** DIALOG AND NOTES *************//

/*

//look_out_the_window_node - make makarov go here to say his line, unused
//far_building_eraser_trigger - make axis troops in unreachable building easily manipulable or killed, unused 
//hold_redsquare_node - make leftover redsquare friendlies go to guard positions

- cover left at the statue is wrong
- put most of the victor guards nodes along the german line instead

*/

activate_mortar_redsquare (range, max_damage, min_damage, fQuakepower, iQuaketime, iQuakeradius, instant, specialsound)
{
	incoming_sound_redsquare(specialsound);
	
	mortar_boom_redsquare( self.origin, fQuakepower, iQuaketime, iQuakeradius, instant);
	
	radiusDamage ( self.origin, range, max_damage, min_damage);
}

incoming_sound_redsquare(specialsound)
{		
	soundnum = randomint(3) + 1;

	if(isdefined(specialsound))
	{
		self playsound ("bomb_incoming1");
		wait(2.237);
		return;
	}

	if (soundnum == 1)
	{
		self playsound ("mortar_incoming1");
		wait (1.07 - 0.25);
		level notify ("mortar can explode");
	}
	else
	if (soundnum == 2)
	{
		self playsound ("mortar_incoming2");
		wait (0.67 - 0.25);
		level notify ("mortar can explode");
	}
	else
	{
		self playsound ("mortar_incoming3");
		wait (1.55 - 0.25);
		level notify ("mortar can explode");
	}
}

mortar_boom_redsquare (origin, fPower, iTime, iRadius, instant)
{
	if (!isdefined(fPower))
		fPower = 0.15;
	if (!isdefined(iTime))
		iTime = 2;
	if (!isdefined(iRadius))
		iRadius = 850;

	mortar_sound_redsquare();
	playfx ( level.altmortar, origin );
	earthquake(fPower, iTime, origin, iRadius);
	
	if(isdefined(instant))
	{
		level notify ("walldestruction");
	}
}

mortar_sound_redsquare()
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
