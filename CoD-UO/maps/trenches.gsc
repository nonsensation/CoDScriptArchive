//
//Mapname: trenches
//Edited by: Mike
//

// Task List
//----------
//

// -Adjust mill door so it doesn't pop.

// E3 Stuff:
//-----------
//- Adjust the final combat event in trenches.
//- Adjust the end of trenches so triggering the commisar event works better.
//- Polish Tanks, have them shoot at T34s, and more randomness?
//- Do all of Steve's adjustments (doc).

//- No fly overs just before the right flank battle.
//- No fly overs while in bunkers.
//- Fix event6_mortar, so that it plays the incoming sound.
//- Fix Level.Antonov so he doesn't loop quickly.
//- Have MGs open fire when Antonov says FIRE
//- Vassili kick open magic door.

//- Move "look out it's coming down" to just before the explosion of the stuka.
//-Fix guys not jumping into trench, left flank.

// -Do little radius damages when the stuka hits the ground.
// -Antonov "wave_loop" sometimes errors out. Along the way the trenches. Just before shellshock.

// LOW PRIORITY!!!
//----------------
// - Add Boris End scene.
// - Fix navigation when getting out of the train and running to the truck.
// - Fix miesha so he doesn't get stuck on player on right flank.
// - Add fake machinegun fire to left_flank when stuka crash happens, for atmosphere.
// - Add reinforcements, after player flushes out left flank.
// - Animations with Dialog
// - Clip for Stuka.
// - Add ambient animations in Bunker
// - Add radio man.

// MEDIUM PRIORITY!!!
//-------------------
// - Add health/ammo.
// - Camo skin on panzers
// - Tents in distances/house
// - Clean up path angles for all planes.
// - Fix dummies floating in air when they die. (mainly in trucks)
// - Flight paths along truck ride

// HIGH PRIORITY!!!
//-------------------
// - Add sound for fires on truck and stuka.
// - Crashing flight paths in distance
// - ( 3 ) Flame thrower, fireattarget
// - Insert IL2 in a few areas.

// - Couple guys running out to elefant3 to attack. Use the reinforcement guys.
// - Friendly chain setup better in creek. You know what to do. Break it up.
// - Get elefant2 spawners to work.
// - Reinforce trenches battle if needed.
// - Fix Og start, and event6 teleport.
// - Friendlies in creek bed stand when player is close.
// - Fix truckriders tryin got loop 2 anims.
// - Kill Truck4_driver after truck explodes.
// - Voice over for DUCKING part.
// - Fix 2 anim loops error.
// - Get facial animations working.
// - Add rumble to truck ride.

// - Debate about crouching while Artillery (in truck)
// - IF!!, we put the train ride back in, need to do the timing on the sounds for the RANDOM STUKAS.

//Trenches Log
//============

// 11-17-03
// - Waiting for ammo takes too long.
// - Meeting up with friends takes too long.
// - Barrage needs to start sooner and feel smoother.
// - Pause before German Assault is too long.
// - Add stuka sounds.
// - Flamethrower guys should have more health.
// - Add collision for elefant tanks.
// - Add shell shock just after player reaches trenches.
// - Spawn crashing stuka sooner.
// - German Lying prone in craters.
// - Add clip brushes at start.

// 11-18-03
// - Give more Germans Grenades.
// - Add mine fields.
// - Spawn German AI in bunker2.
// - Remove MG42 in trench 2 area.
// - Have MG42 guy get tossed.
// - Tanks firing main guns. // - Have Tanks shoot "fake_mortars" for TEMP.
// - Give low ammo at start, then give lots of ammo when time.
// - Add ai near tanks.
// - Add random flares in sky.
// - Add rumble/camera shack for stuka crash.

// 11-19-03
// - Adjusted AI's sight, maxsightdistsqrd
// - Added camera shake to mg42 nest blown up.

// 11-20-03
// - Add pathnode next to T in first area of trench. (Near trucks, next to the little pile of boxes.)
// - Dialog

// 11-23-03
// - Add mg42 fun!
// - Add autosaves.
// - Objectives
// - Add cover nodes for AI's near tanks.

// 12-22-03
//---------
// - Get all guys in truck1 and truck2.
// - Stuka Drops bombs.

// 12-22-03
//---------
// - Connected the beginning witht he prototype section, still needs cleaning tho.


// 01-05-04
//---------
// - 1st thing to see when coming out of the train are a few fly-bys and bombings

// 01-06-04
//---------
// - Stuka train bomb

// 01-08-04
//---------
// - Added a few debris along the road.
// - Tank Drive By
// - Tank Drive by village
// - Stuka bomb tanks near village
// - Add smok/firee to village/creek/start of map
// - Distant lights around train area.
// - 2 trucks driving back (shelled)
// - Reset Culldist

// 01-08-04
//---------
// - Stuka bomb next to train.

// 01-12-04
//---------
// - Moved train into position, since we are taking out the "riding in the train." for pre-alpha
// - Take out Train ride for now.

// 01-14-04
//---------
// - Add a couple more tanks.
// - Remove a couple enemies. at last battle
// - Collmap for rocks in creek.

// 01-15-04
//---------
// - Add reinforcements. (Tanks)
// - tanks firing at each other.
// - Friends follow player while defending. Zones.
// - Add reinforcements. (troops)

// 01-16-04
//---------
// - Removed turrets on the last 3 t34s of the reinforcements (end of map)
// - Disabled the MG42s on the Panzers after reinforcements arrive.
// - Add guy next to tank. With VO.
// - Define paths for Enemies.
// - Autosaves (event17)
// - Move spawn back a bit for the guys coming over the creekbed wall.
// - Guys retreating.

// 01-17-04
//---------
// - reduce amount of (allies) guys in creek, in battle. Also reduce health and accuracy. Increase axis accuracy a bit.
// - Add dontavoidplayer to all the guys in the mill when in position.
// - Give miesha PPSH at end.
// - End map.
// - Make dummies fly if bomb hits near them.
// - Add Dummies on outter trucks (truck5 and truck6);
// - Fix village dummies, not spawning.
// - Fix smoke stack fx.
// - Anti Aircraft guns in distance
// - Random Flights paths (formation)
// - Truck 5 & 6 move out, then blow up.

// 01-18-04
//---------
// - Flamethrowers in creek.
// - Reduced shellshock damage. Me no likey the shell shock.
// - ( 1 ) Trenches break through line
// - ( 2 ) MG42 Whores, better pathing.
// - Guys running to truck from train, with times.
//tag_01		249
//tag_02		240
//tag_03		235
//tag_04		219
//tag_05		208
//tag_06		212
//tag_07		200
//tag_08		200
//
//
//
//tag_11		260
//tag_12		249
//tag_13		239
//tag_14		231
//tag_15		217
//tag_16		213
//tag_17		209
//tag_18		200
// - Fix Truckriders angles with DOm's fixes.
// - Distinct paths for AI, right flank.
// - Optimize Trench battle. (10 instead of 16)
// - Commissars talking/animating at beginning.
// - Make sure to delete the tanks by the village (tank that drive and get bombed), when coming back.
// - Fix timing for "if" the player hits the endless amount of guys trigger.

// 01-20-04
//---------
// - Ambient track coming out of the train is in place now.
// - Skinned wounded

// 01-21-04
//---------
// - Cheated to get more guys in trenches (12 guys attacking now. 2 always go to the far side)
// - Add cover at end. (logs)
// - Adjusted Mine Field Triggers
// - Fixed Mine Field trigger at exitdoor
// - Cover nodes adjusted
// - Added Initial Creek start battle.
// - New meet up with Antonov objective.
// - Clipped tank in front of elefant tank.
// - Added triggers for elefant troop spawners. Instead all of them spawn in at once.

// 01-22-04
//---------
// - Moved Spawn point to inside of trucks. HOpefully, just temporarily. Use og_start 1 to see what it should be.
// - COmmissar will wait for the player to finish his MG42_FUN for the new objective to be tasked.
// - Delayed the "reinforce the left flank" dialog, so stuka crash doesn't cover it up.
// - Adjusted ambient triggers in village.
// - Took out "We're not going to make it" in mill.
// - Defend village objective is now dependant on the enemy in village count rather than trigger.
// - Fix "GUYS REMAINING" bug for right flank.
// - Fixed Objectives, since the "start" position changed.
// - Changed the end a bit, added a mg42, delayed spawn of first encounter out of the mill.
// - Clip little cover in village.

// 01-23-04
//---------
// - Adjusted nodes for MG42_fun
// - Fix up objectives
// - Added stuka strafing player's truck, killing 1 guy, and damaging the player.
// - Check Voice Overs
// - Fadeup screen, training_datestamp music.
// - Fadeup screen, commissar start talking.

// 01-24-04
//---------
// - Insert new music
// - Insert dialog for Tankguy
// - Fix Bunker commissar, trigger should start them talking.
// - Sounds for HIGH ALT planes.

// 01-25-04
//---------
// - Sounds for Planes flying by.
// - Toggle OFF clip for trenches after player gets outside of trenches. (event14_battle1)
// - MG42 guys do not spawn sometimes.
// - Save game, after defending the trenches does not save 100% Might be related to below bug
// - Add health to the last house in the VILLAGE.
// - Objectives are messed up. After event17
// - End Battle, 2 guys left should trigger the defend event.
// - remove wounded guys walking back. TEMP.
// - Guys should not go prone to elefant1.
// - Antonov say Vassili line, after event17. Objective.
// - Give Germans MP40s in House.
// - Flamethrower dude in creek. Lower goalradius so he gets closer to the edge
// - Panzers at end should try to get away.
// - Cover stand in busted building in village.
// - Trigger elefant 3 spawners sooner.
// - Spawn reinforcements from trench area as soon as tanks are blown up.

// 01-26-04
//---------
// - Zone triggers, for elefant area, just like village.
// - Setup friendlychains better. Sections at a time.

// 04-26-04
//---------
//- Removed Tailgate clip from the Gazaaa collmap.
//- Put monsterclip around rock in terrain.

// 04-27-04
//---------
//- Got rid of every other minefield sign, to reduce overall polys.
//- Deleted a few nodes so that the map is not over the limit anymore... 
//- Close mill_door, have respawners hop over fence.

// 04-28-04
//---------
//- Have Axis take cover on way in, end of level.
//- Not all Germans goto player.

// 04-29-04
//---------
//- Fixed LOD_FX bug... Prevented any fx (that had LOD_FX) to play.
//- Fix Tankguy
//- Once out of the mill delete everyone else that is not in that area.
//- Fixed random smoke coming up.

// 04-29-04
//---------
// -Added a couple delays on cover spots on right flank of trenches.
// -Moved 2 spawners closer to the right flank, and delayed their initialspawn to 7.
//- Have the AXIS spawn in around 2nd tank.
//- Get rid of dontavoidplayer on antonov for left flank, when he comes to find the player.
//- increase Antonov's goalradius when finding the player.
//- Have MG42_fun guys pause at cover spots for 2-3 seconds.
//- Have guys rushing right flank pause at cover spots for 2-3 seconds.
//- When the count for the first wave of the left flank lower, have the remaining go to the player.
//- Disable commissar dialogue (giving ammo) if player is not close enough.
//- When player links to the origin, when he gets ammo, the angles are messed up. (Due to playerlinkto, changed back to linkto)
//- Move flamethrower sound to trigger, just as he exits bunker2.
//- Have anotonov say "follow me" after all enemies are dead. (Included 1/2 second delay).
//- Have particle shoot out, for wing of stuka.
//- Add scream to mg nest getting blown.

#using_animtree("generic_human");
main()
{
	setCullFog (1000, 10000, .32, .36, .40, 0 );
	setculldist(50000);

// Start Preload
	maps\_load_gmi::main();
	maps\trenches_anim::main();
	maps\trenches_anim::stuka_crash();
	maps\trenches_fx::main();
	maps\trenches_dummies::main();
	maps\_truck_gmi::main();
	maps\_panzeriv_gmi::main();
	maps\_panzer_gmi::main(); /// For flak guns.
	maps\_t34_gmi::main();
	maps\_elefant_gmi::main();
	maps\_stuka_gmi::main();
	maps\_music_gmi::main(); // Specifies the musiclength.
	maps\_flame_damage::main();

// DEBUG
	maps\_debug_gmi::main();
// End Preload

// Start Level.stuff
	level.mortar = loadfx ("fx/explosions/artillery/pak88.efx");
	level.mortar_low = loadfx ("fx/explosions/artillery/pak88_low.efx");

	level.stuka_bomb_high = loadfx ("fx/explosions/vehicles/stuka_bomb.efx");
	level.stuka_bomb_low = loadfx("fx/explosions/vehicles/stuka_bomb_low.efx");
	level.stuka_bomb = level.stuka_bomb_high;
	level.mg42_effect = loadfx ("fx/muzzleflashes/mg42hv.efx");
	level.mg42_effect2 = loadfx ("fx/muzzleflashes/mg42hv_nosmoke.efx");
	level.mortar_quake = 0.5;
	level.event1["player_in_truck"] = false;
	level.blow_bunker_counter = 0;
	level.ammo_line_num = 0;
	level.trench_2_counter = 0;
	level.event7["triggered"] = false;
	level.friends_right_line_reached = 4;
	level.player_shell_shock = false;
	level.flag["right flank done"] = false;
	level.objective_5["start"] = true;
	level.mg42_fun = false;
	level.stuka_bomb_qradius = 2048;
	level.event7_shell_shock = false;
	level.event9_barrage = true;
// Rain
//	level.atmosphere_fx = loadfx ("fx/atmosphere/rain_medium.efx");
	level.atmosphere_speed = 0.1;
	level thread maps\_atmosphere::_spawner();

// Set the mortar distances, also which can be changed later.
//	level.mortar_mindist = 460;
//	level.mortar_maxdist = 1500;
//	level.mortar_random_delay = 25;
	level.mortar_mindist = 1024;
	level.mortar_maxdist = 10000;
	level.mortar_random_delay = 15;
// Ambient
	level.ambient_track ["exterior"] = "ambient_trenches_01";
	level.ambient_track ["interior"] = "ambient_trenches_01_int";
	level.ambient_track ["custom"] = "ambient_rain_combat_int";
	level thread maps\_utility_gmi::set_ambient("custom");

	level.flag["event18_victory_counter"] = false;
// End Level.stuff

// To speed things up, remember to set these to 0 before release
	if(getcvar("quick_start") == "")
	{
		setcvar("quick_start","3");
	}
	if(getcvar("quick_truck") == "")
	{
		setcvar("quick_truck","0");
	}
	if(getcvar("quick_event16") == "")
	{
		setcvar("quick_event16","0");
	}
	if(getcvar("quick_wave") == "")
	{
		setcvar("quick_wave","0");
	}
	if(getcvar("quick_end") == "")
	{
		setcvar("quick_end","0");
	}
	if(getcvar("og_start") == "")
	{
		setcvar("og_start","1");
	}
	if(getcvar("quick_event6") == "")
	{
		setcvar("quick_event6","0");
	}
	if(getcvar("no_shellshock") == "")
	{
		setcvar("no_shellshock","0");
	}
	if(getcvar("no_mg42_fun") == "")
	{
		setcvar("no_mg42_fun","0");
	}
                                
//	MikeD: Colored syntax for future prints.
	println("^1 1, Red");    
	println("^2 2, Green");  
	println("^3 3, Yellow"); // Debugging.
	println("^4 4, Blue");   
	println("^5 5, Cyan");   
	println("^6 6, Purple"); // Voice overs.
	println("^7 7, White");  
	println("^8 8, NA");     
	println("^9 9, NA");     
	println("^0 0, Black");
//	End Colored Syntax for prints.
                    
// Start Precache ============================================== //
	precachestring(&"GMI_TRENCHES_REINFORCEMENTS");
	precacheShellshock("default"); // Already in _load, but just incase.
	character\RussianArmy::precache();
	character\RussianArmyWoundedTunic::precache();
	character\RussianArmyDead1::precache();
	character\RussianArmyDead2::precache();
	character\RussianArmyOfficer_shout2::precache();
//	character\RussianArmyOfficer_radio ::precache();
	precacheturret("mg42_tiger_tank");
	precacheModel("xmodel/vehicle_tank_panzeriv_machinegun");

	// See if this fixed Rich's "hit"
	precacheitem("ppsh");

	// Stuka Model
	precachemodel("xmodel/kursk_stuka_path");
	precachemodel("xmodel/v_ge_air_stuka(d)");

	// Elefant Tank
	precachemodel("xmodel/v_ge_lnd_elefant");

	// Ammo Commissar
	precacheModel("xmodel/stalingrad_clips");

	// Mill_door Tag
	precacheModel("xmodel/trenches_mill_door");

	// Explosives
	precacheShader("hudStopwatch");
	precacheShader("hudStopwatchNeedle");

	// Chair in bunker
	precachemodel("xmodel/chair_utility");
	maps\_utility_gmi::precache ("xmodel/explosivepack");
	precacheModel("xmodel/trenches_dummies_scatterA");

	// Wing for stuka crash
	// Hopefully takes out the hitch when the stuka air explosion fx is triggered.
	precachemodel("xmodel/v_ge_air_stuka_wing");
// End Precache ============================================== //

// Set player's ammo really low
	level.player setWeaponSlotAmmo("primary", 0);
	level.player setWeaponSlotAmmo("pistol", 0);
	level.player setWeaponSlotAmmo("grenade", 0);

// Throw away the garbage! Models/temp objects not used in the game.
	garbage = getentarray("garbage","targetname");
	for(i=0;i<garbage.size;i++)
	{
		garbage[i] delete();
	}

// Setup hidden or notsolid objects, might make this it's own function later.
	block_trench_entrance = getent("block_trench_entrance","targetname");
	block_trench_entrance notsolid();

	block_bunker = getent("block_bunker","targetname");
	block_bunker connectpaths();
	block_bunker notsolid();
	block_bunker hide();

	level.mill_clip = getent("mill_clip","targetname");
	level.mill_clip notsolid();

	stuka_clip = getent("stuka_clip","targetname");
	stuka_clip notsolid();

	bunker2_models = getentarray("bunker2_models","targetname");
	for(i=0;i<bunker2_models.size;i++)
	{
		bunker2_models[i] hide();
	}

// Hide models
	stuka = getent("crashing_stuka","targetname");
	stuka hide();
	mg42_nest_damaged = getent("mg42_nest_damaged","targetname");
	mg42_nest_damaged hide();
	mg42_net_damaged = getent("mg42_net_damaged","targetname");
	mg42_net_damaged hide();
	mg42_net_damaged notsolid();

	bomb_tank_plane = getent("bomb_tank_plane","targetname");
	bomb_tank_plane hide();

// Rotate models
	door1 = getent("door1","targetname");
	door1 rotateto((0,-45,0), 1, 0, 0);

	exit_door1 = getent("exit_door1","targetname");
	exit_door1 rotateto((0,-45,0), 1, 0, 0);

	exit_door2 = getent("exit_door2","targetname");
	exit_door2 rotateto((0,60,0), 1, 0, 0);

	exit_door3 = getent("exit_door3","targetname");
	exit_door3 rotateto((0,-45,0), 1, 0, 0);

	event11_trigger = getent("event11","targetname");
	event11_trigger maps\_utility_gmi::triggerOff();


	// --- E3 Section --- //
	if(getcvar("for_e3") == "")
	{
		setcvar("for_e3","0");
	}
	// --- END E3 Section --- //

// THREAD SECTION
	level thread setup_characters();
	level thread Setup_Ambience();
	level thread objectives();
	level thread random_wind();
//	level thread event6();
	level thread event8_spawn_commissar();
	level thread setup_triggers();
	level thread music();
	level thread Setup_Low_Spec();

	if(getcvar("og_start") == "1")
	{
		level thread event1(); // Temporarily taken out, might go back in... 1/21/04
	}
	else
	{
		level thread event1_without_train();
	}

//	level thread draw_name();
//	level thread debug_pathnodes();
	level thread event1_distant_light();
	level thread random_high_alt_formations();

// Tain Mortars at beginning
	train_mortars = getentarray ("train_mortar","targetname");
	for (i=0;i<train_mortars.size;i++)
	{
		train_mortars[i] thread mortars();
	}

// TESTING SECTION
//======================
//level thread event10_stuka_crash();
//level thread event9_dummyB_setup();
//thread event13_destroy_mg42();
//level thread test_total_guys();
//level thread test();
//level thread event8_spawn_commissar();
//thread test_elefant_charge();
//level thread event14_battle1();
//level thread event12_mg42();
//level thread event5_coming_trucks();
//level thread test_dummy();
//level thread test_tailgate();
}

Setup_Low_Spec()
{
	level waittill("finished intro screen");

	println("^3 Low Spec Setup");
	println("^3----------------");

	if(getcvarint("scr_gmi_fast") > 0)
	{
		println("^3level.stuka_bomb = level.stuka_bomb_low");
		level.stuka_bomb = level.stuka_bomb_low;

		println("^3level.mortar = level.mortar_low");
		level.mortar = level.mortar_low;
	}
}

setup_characters()
{
	// Setup friends
	// Vassili
	character\RussianArmyVassili::precache();
	vassili = getent("vassili","targetname");
	vassili.groupname = "friends";
	vassili.goalradius = 32;
	vassili.accuracy = 1.0;
	vassili.animname = "vassili";
	vassili.original_animname = "vassili";
	vassili.bravery = 100;
	vassili.grenadeammo = 5;
	vassili.suppressionwait = 1;
	vassili.maxsightdistsqrd = 9000000; // 3000 units
	level.vassili = vassili;
	vassili character\_utility::new();
	vassili character\RussianArmyVassili::main();
	vassili thread maps\_utility_gmi::magic_bullet_shield();

	// Boris
	character\RussianArmyBoris::precache();
	boris = getent("boris","targetname");
	boris.groupname = "friends";
	boris.goalradius = 32;
	boris.animname = "boris";
	boris.original_animname = "boris";
	boris.accuracy = 0.2;
	boris.bravery = 1;
	boris.maxsightdistsqrd = 9000000; // 3000 units
	level.boris = boris;
	boris character\_utility::new();
	boris character\RussianArmyBoris::main();
	boris thread maps\_utility_gmi::magic_bullet_shield();

	// Miesha
	character\RussianArmyMiesha::precache();
	miesha = getent("miesha","targetname");
	miesha.groupname = "friends";
	miesha.goalradius = 32;
	miesha.animname = "miesha";
	miesha.original_animname = "miesha";
	miesha.accuracy = 0.7;
	miesha.bravery = 50;
	miesha.grenadeammo = 2;
	miesha.maxsightdistsqrd = 9000000; // 3000 units
	level.miesha = miesha;
	miesha character\_utility::new();
	miesha character\RussianArmyMiesha::main();
	miesha thread maps\_utility_gmi::magic_bullet_shield();

	// Setup fake_commissar1, guy with bullhorn at beginning of trench.
	fake_commissar_1 = spawn("script_model",(0,0,0));
	fake_commissar_1.animname = "bullhorn_commissar";
	fake_commissar_1.groupname = "start_trench_commissars";
	fake_commissar_1 setmodel ("xmodel/character_soviet_overcoat");
	fake_commissar_1 UseAnimTree(level.scr_animtree[fake_commissar_1.animname]);
	spawnnode = getnode("fake_commissar_1","targetname");
	fake_commissar_1.origin = spawnnode.origin;
	fake_commissar_1.angles = (spawnnode.angles + (0,45,0));
	fake_commissar_1 [[level.scr_character[fake_commissar_1.animname]]]();
	fake_commissar_1 thread event6_commissar_bullhorn_loop();

	// For Commissar1
	character\RussianArmyAntonov::precache();

	level.friends = [];
	level.friends[0] = vassili;
	level.friends[1] = miesha;
	level.friends[2] = boris;
}

Setup_Ambience()
{
	wait 1;
	if(getcvar("scr_gmi_fast") != "" && getcvarint("scr_gmi_fast") > 0)
	{
		if(getcvarint("scr_gmi_fast") < 2)
		{
//			setcvar("cg_atmosDense",200);
			level.atmosphere_speed = 0.5;
		}
		else
		{
//			setcvar("cg_atmosDense",500);
			level.atmosphere_speed = 0.1;
		}
	}
	else
	{
		level.atmosphere_speed = 0.1;
//		setcvar("cg_atmosDense", 20);
	}
}

setup_triggers()
{
	friendlychains = getentarray("trigger_friendlychain","classname");
	for(i=0;i<friendlychains.size;i++)
	{
		friendlychains[i] thread friendlychain_trigger_think();
	}

	maps\_utility_gmi::chain_off("event11_chain1a");
	maps\_utility_gmi::chain_off("event11_chain2");
	maps\_utility_gmi::chain_off("event12_chain2");

	// Setup instant mortars that are triggered by a brush.
	instant_mortars = getentarray("instant_mortar","groupname");
	for(i=0;i<instant_mortars.size;i++)
	{
		instant_mortars[i] thread instant_mortar_trigger();
	}
	
	level waittill("first mortar hit");

	// Setup the mortars.
	mortars = getentarray ("mortar","targetname");
	for (i=0;i<mortars.size;i++)
	{
		mortars[i] thread mortars();
	}
	level thread random_distant_light();
}

friendlychain_trigger_think()
{
	if(isdefined(self.script_noteworthy))
	{
		if(self.script_noteworthy == "delete")
		{
			self waittill("trigger");
			self maps\_utility_gmi::triggerOff(); // At least it will turn off.
			self delete();
		}
	}
	else
	{
		return;
	}
}

objectives()
{
	// "Get Into Truck"	
	// Commented out until we add original beginning.
	if(getcvarint("og_start") > 0)
	{
		objective_add(1, "active", &"GMI_TRENCHES_OBJECTIVE1", (-17619,-3713,-28));
		objective_current(1);

		level waittill("objective 1 complete");
		objective_state(1,"done");
	}

	// ***NOTE: Starting on Objective 2 for the PROTOTYPE!
	// "Get Ammo from Bunker"
	objective_add(2, "active", &"GMI_TRENCHES_OBJECTIVE2", (32, 88, 16));
	objective_current(2);

	level waittill("objective 2 complete");
	objective_state(2,"done");

	// "Defend Right Flank"
	objective_add(3, "active", &"GMI_TRENCHES_OBJECTIVE3", (1368,-1240,-16));
	objective_current(3);

	level waittill("start objective 4"); // Not using "objective 3 complete", as there is a delay between the 2.

	// "Flush out Left Flank"
	level thread objective4_update();

	level waittill("start objective 5"); // Not using "objective 4 complete", as there is a delay between the 2.

	// "Follow Commissar"
	if(getcvar("quick_event16") == "1")
	{
		objective_add(5, "active", &"GMI_TRENCHES_OBJECTIVE5", (level.player.origin));
		objective_current(5);
	}
	else
	{
		objective_add(5, "active", &"GMI_TRENCHES_OBJECTIVE5", (level.commissar1.origin));
		objective_current(5);

		level thread objective5_linkto_commissar();
	}

	level waittill("objective 5 complete");
	objective_state(5,"done");

	// "Blow up 3 Elefant Tanks (%s remaining)"
//	objective_add(6, "active", &"GMI_TRENCHES_OBJECTIVE6", (0,0,0));

	level waittill("objective 6 complete");
	objective_state(6,"done");

	objective_add(7, "active", &"GMI_TRENCHES_OBJECTIVE7", (-336, -3952, 12));
	objective_current(7);

	level waittill("objective 7 complete");
	objective_state(7,"done");

	// "Head to Village"
	objective_add(8, "active", &"GMI_TRENCHES_OBJECTIVE8", (-9232,-96,192));
	objective_current(8);

	level waittill("objective 8 complete");
	objective_state(8,"done");

	objective_add(9, "active", &"GMI_TRENCHES_OBJECTIVE9", (-7072,224,176));
	objective_current(9);

	level waittill("objective 9 complete");
	objective_state(9,"done");

	objective_add(10, "active", &"GMI_TRENCHES_OBJECTIVE10");
	objective_current(9);
	objective_state(9,"done");

	level waittill("objective 10 complete");
	objective_state(10,"done");

	objective_add(11, "active", &"GMI_TRENCHES_OBJECTIVE11", (-9205,395,196));
	objective_current(11);

	level waittill("objective 11 complete");
	objective_state(11,"done");
}

objective4_update()
{
	level endon("start objective 5");

	num = 0;
	spot[0] = (64,-1024,8);
	spot[1] = (840,-136,-24);
	spot[2] = (840,1464,-16);

	objective_add(4, "active", &"GMI_TRENCHES_OBJECTIVE4", (64,-1024,8));
	objective_current(4);

	while(1)
	{
		while(distance(level.player.origin, spot[num]) > 256)
		{
			wait 0.1;
		}
		num++;

		if(num > 2)
		{
			break;
		}

		objective_position(4, spot[num]);
	}
}

objective5_linkto_commissar()
{
	while(level.objective_5["start"])
	{
		objective_position(5, level.commissar1.origin);
		wait 0.05;
	}
}

event1_train_door_sound()
{
	wait 0.5;
	level.player.start_org playsound ("barn_door_open");
	wait 1;
	level thread maps\_utility_gmi::set_ambient("exterior");
}

event1()
{
	// Setup Trucks
	for(i=1;i<7;i++)
	{
		truck[i] = getent("truck" + i,"targetname");
		if(isdefined(truck[i]))
		{
			truck[i] maps\_truck_gmi::init();
			truck[i].unload = false;
			truck[i] makeVehicleUnusable();
			truck[i].tread_muliplier = 0.5;
			if(truck[i].targetname == "truck4")
			{
				truck[i].no_deathanim = true;
			}
			truck[i].health = 500;
//			if(truck[i].targetname == "truck3" || truck[i].targetname == "truck4" || truck[i].targetname == "truck5" || truck[i].targetname == "truck6")
//			{
				truck[i] thread maps\_truck_gmi::toggle_beddoor();
//			}
		}
	}

	player_traincar = getent("player_traincar","targetname");
	player_traincar.stop_rocking = false;
	train_clip = getent("player_traincar_clip","targetname");

	smoke_stack = spawn("script_origin", (-18590,-2186, 400));
	smoke_stack.targetname = "train";

	locomotive = getent("engine","script_noteworthy");
	level thread event1_locomotive_sound(locomotive);
	smoke_stack linkto(locomotive);
	train_clip thread event1_train_smoke(smoke_stack);
	train_clip linkto(player_traincar);

	level thread event1_attach_guys_to_train();

	level.player setplayerangles((0,0,0));
	level.player setorigin((-18618, -3633, 200));
	level.player.start_org = spawn("script_origin",level.player.origin);
	level.player linkto(level.player.start_org);

	level thread event1_move_player();

	level thread event1_train_sound(); // If we put the train back in, take this out.
	level thread event1_commissar_dialog_loop();
	level thread event1_train_door_sound();

	level waittill("finished intro screen");

	level thread event1_dummies(); // Dummies running EVERYWHERE!
	level thread event1_side_trucks_setup();
	// Change the exterior ambient for when it gets trigger.


//------------------------------------------------------------------------------//
// Taken out for time being... 01/12/04
// Original start position of the train was: (-18579, -9201, whatever it's at)
//------------------------------------------------------------------------------//
//
//	level thread event1_train_sound();
//	level thread event1_train_rock();
//
//	train_dest = getent("train_spot","targetname");
//	if(getcvar("quick_start") == "1")
//	{
//		player_traincar moveto((train_dest.origin), 1, 0, 0);
//	}
//	else
//	{
//		player_traincar moveto((train_dest.origin), 25, 0, 7);
//	}
//
//	level thread event1_stuka_while_in_train();

//	player_traincar waittill("movedone");

//	level.player unlink();

	level notify("detach train riders");

	level thread event1_player_get_in_truck();

	level thread event1_stukas();
}

event1_locomotive_sound(locomotive)
{
	blend = spawn( "sound_blend",(0,0,0) );
	blend.origin = locomotive.origin;

//	level thread maps\_utility_gmi::blend_upanddown_sound(locomotive,99999999,"train_idle_low","train_idle_high");

	blend setSoundBlend("train_idle_low", "train_idle_high", 0);

	level waittill("finished intro screen");

	volume = 0.25;
	time = 3000;
	timer = time + gettime();

	count = 0;
	limit = time/20;
	ratio = (1 - volume) / limit;
	
	while(count < limit)
	{
//		println("Volume: ",volume," Ratio: ",ratio," Count: ",count);
		blend setSoundBlend("train_idle_low", "train_idle_high", volume);
		wait 0.05;
		volume += ratio;
		count++;
	}
	
	level waittill("blow_train");

	blend setSoundBlend("train_idle_low", "train_idle_high", 0);
	wait 1;
	blend delete();
}

event1_move_player()
{
	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowCrouch(false);
	level.player allowProne(false);

	level waittill("finished intro screen");

//	wait 0.5;

	destination = (-18518,-3639,level.player.start_org.origin[2]);
	diff = (((destination[0] - level.player.start_org.origin[0]) / 3), ((destination[1] - level.player.start_org.origin[1]) / 3), ((destination[2] - level.player.start_org.origin[2]) / 3));

	
	// current origin
	origin = level.player.start_org.origin;

	for(i=0;i<3;i++)
	{
		origin = (origin + diff);
		level.player.start_org moveto(origin, 1.5, 0.5, 0.75);
		level.player.start_org waittill("movedone");

		println("MOVE DONE!");
	}

	origin = (-18492,-3640,(origin[2] - 32));
	level.player.start_org moveto(origin, 1, 0.75);
	level.player.start_org waittill("movedone");

	level.player allowLeanLeft(true);
	level.player allowLeanRight(true);
	level.player allowCrouch(true);
	level.player allowProne(true);

	level.player unlink();
}

event1_without_train()
{
	trigger = getent("use_truck","targetname");
	trigger delete();

	ambientplay("ambient_trenches_01",1);
	for(i=1;i<7;i++)
	{
		truck[i] = getent("truck" + i,"targetname");
		if(isdefined(truck[i]))
		{
			truck[i] maps\_truck_gmi::init();
			truck[i].unload = false;
			truck[i] makeVehicleUnusable();
			truck[i].tread_muliplier = 0.05;
			if(truck[i].targetname == "truck4")
			{
				truck[i].no_deathanim = true;
			}
			truck[i].health = 500;
			if(truck[i].targetname == "truck3" || truck[i].targetname == "truck4" || truck[i].targetname == "truck5" || truck[i].targetname == "truck6")
			{
				truck[i] thread maps\_truck_gmi::toggle_beddoor();
			}
		}
	}

	smoke_stack = spawn("script_origin", (-18590,-2186, 400));
	smoke_stack.targetname = "train";
	train_clip = getent("player_traincar_clip","targetname");
	train_clip thread event1_train_smoke(smoke_stack);

	truck1 = getent("truck1","targetname");
	truck2 = getent("truck2","targetname");
	truck3 = getent("truck3","targetname");
	truck4 = getent("truck4","targetname");
	truck5 = getent("truck5","targetname");
	truck6 = getent("truck6","targetname");

	pos1 = truck1 gettagorigin("tag_climbnode");
	pos1_forward = anglestoforward(truck1.angles);
	pos1_vec = maps\_utility_gmi::vectorScale (pos1_forward, -100);
	pos2 = (truck1 gettagorigin("tag_player") + ((pos1_vec) + (0,0,-12)));

	level.player setorigin(pos2);
	//level.player playerlinkto(truck1,"tag_player",(1,1,1));
	level.player linkto(truck1,"tag_player"); // Using linkto instead cause, when I link the player again, it rotates his angles.
////////
	friends = getentarray("friends","groupname");
	truck1_riders = getentarray("truck1_rider","targetname");
	truck2_riders = getentarray("truck2_rider","targetname");
	both_riders = add_array_to_array(truck1_riders,truck2_riders);

	extra_riders = getentarray("train_rider","targetname");
	for(i=0;i<extra_riders.size;i++)
	{
		extra_riders[i] delete();
	}

	// Set up truck drivers
	drivers = getentarray("truck_driver","groupname");
	for(i=0;i<drivers.size;i++)
	{
		truck = getent(("truck" + drivers[i].script_vehiclegroup),"targetname");

		if(isdefined(truck))
		{
			if(truck.targetname == "truck3")
			{
				drivers[i].health = 50; // So he dies when his truck explodes.
			}
			drivers[i].targetname = (truck.targetname + "_rider");
			driver[0] = drivers[i]; // Since it has to be an array.
			truck thread maps\_truck_gmi::handle_attached_guys(driver);
		}
	}

	truck2.ready_to_go = true;

	all_riders = add_array_to_array(both_riders, friends);

	for(i=0;i<all_riders.size;i++)
	{
		all_riders[i] thread event1_trucklink_without_train();			
	}

	level thread event1_commissar_dialog_loop(true);

	level waittill("finished intro screen");

//	level notify("objective 1 complete");

	if(getcvar("quick_event16") == "1")
	{
		for(i=0;i<all_riders.size;i++)
		{
			self.flinch = false;
			self endon("stop flinching");
		}
		level.player unlink();
		truck1 notify("unload");
		level.event16_quick = true;
		wait 2;
		level thread event16_quick();
		return;
	}
	else if(getcvar("quick_event6") == "1")
	{
		level.player unlink();
		truck1 notify("unload");
		truck2 notify("unload");
		wait 3;
		level thread event6_quick();
		return;
	}

	for(i=0;i<all_riders.size;i++)
	{
		all_riders[i].flinch = true;
		if(all_riders[i].targetname == "truck1_rider")
		{
			all_riders[i] thread truck_flinch(truck1);
		}
		else if(all_riders[i].targetname == "truck2_rider")
		{
			all_riders[i] thread truck_flinch(truck2);
		}
		else if(all_riders[i].groupname == "friends")
		{
			all_riders[i] thread truck_flinch(truck1);
		}
	}

	level thread event1_dummies(true); // Dummies running EVERYWHERE!
	level thread event1_side_trucks_setup();
	wait 2;
	level thread event1_stukas(true);
//////////////

	wait 9;

//	train_commissar = getent("commissar_train","targetname");
//	train_commissar setgoalnode(getnode("train_commissar_spot","targetname"));

	//level thread event1_truck_rider_shout("get_down");

	wait 1;

	level notify("stop_random_stukas");

//	wait 3;

	level thread event1_commissar_close_truckdoor(true);
	wait 3;

//	level thread event1_truck_rider_shout("get_us_outta_here");

	fake_commissar = getent("truck_commissar","targetname");
	fake_commissar.loop = false;
	fake_commissar thread maps\trenches_dummies::extra_dummy_think_death();

//	println("^6Commissar: Truck is full, go. ",train_commissar.animname);
//	train_commissar thread anim_single_solo(train_commissar,"truck_full");

	level waittill("trucks_go");

	truck2_path = getvehiclenode("truck2_start","targetname");
	truck2 attachpath(truck2_path);
	truck2 startpath();
	truck2.health = 50000; // So it doesn't die on Accident
	level thread truck_call_anim("truck2_rider",truck2, "start_moving");

	wait 1;

	truck1_path = getvehiclenode("truck1_start","targetname");
	truck1 attachPath(truck1_path);
	truck1 startpath();
	truck1.health = 50000; // So it doesn't die on Accident
//		     truck_anim(groupname, truck, msg, random)
	level thread truck_call_anim("truck1_rider",truck1, "start_moving");

	level thread event3_dummies_1();
	level thread event3_stuka_dive();

	truck3 thread maps\_truck_gmi::toggle_beddoor();
	wait 0.5;

	truck3_path = getvehiclenode("truck3_start","targetname");
	truck3 attachPath(truck3_path);
	truck3 startpath();

	truck3 thread event1_truck_death();

	truck4 thread maps\_truck_gmi::toggle_beddoor();
	wait 1.5;

	truck4_path = getvehiclenode("truck4_start","targetname");
	truck4 attachPath(truck4_path);
	truck4 startpath();
	truck4.health = 50000; // So it doesn't die on Accident
	// Debug stuff...
//	truck1 thread draw_speed(); //Testing
//	truck1 thread drive_timer(truck1);

	level thread event3_tanks_1();
	level thread event1_cleanup();
	level thread event3_prisoner_dummies();
	level thread event3_village_dummies();

	truck1_riders = getentarray("truck1_rider","targetname");
	println("^6Truck1 Rider: Stukas! Keep your heads down!");
	for(i=0;i<truck1_riders.size;i++)
	{
		if(truck1_riders[i].exittag == "tag_guy04")
		{
			stuka_shouter = truck1_riders[i]; // So it's close to the player.
			level.stuka_shouter = stuka_shouter;
		}

		if(truck1_riders[i].exittag == "tag_guy05")
		{
			stuka_shouter2 = truck1_riders[i]; // So it's close to the player.
			level.stuka_shouter2 = stuka_shouter2;
		}
	}
	stuka_shouter.animname = "truckriders";
	stuka_shouter2.animname = "truckriders";

//	stuka_shouter thread anim_single_solo(stuka_shouter,"stukas_head_down");
	wait 2;
//	println("^6Vassili: Stay low, they'll pick your head off like a melon");
//	level.vassili thread anim_single_solo(level.vassili,"head_melon");

	wait 2;
	level thread truck_call_anim("truck1_rider", (getent("truck1","targetname")), "stuka_point");
	wait 3;
	println("^6Truck1 Rider: Oh my god They took out the train!");
	level thread truck_call_anim("truck1_rider", (getent("truck1","targetname")), "train_dead", random, "tag_guy07");
	level thread event1_blow_train();
	wait 2;
	println("^6Truck1 Rider2: Better than hitting us.");
//	stuka_shouter2 thread anim_single_solo(stuka_shouter2,"better_than_us");
	wait 3;
//	println("^6Truck1 Rider: Get us out of here! We're sitting ducks!");
//	stuka_shouter thread anim_single_solo(stuka_shouter,"get_us_outta_here");

	wait 3;
	println("^6Miesha: The front can't possibly be worse than this madness!");
	level.miesha thread anim_single_solo(level.miesha,"this_madness");

	wait 4;
	println("^6Vassili: Steady comrades…defeat your fear, the enemy will be easy");
	level thread truck_call_anim("truck1_rider", (getent("truck1","targetname")), "vass_defeat", random, "tag_guy02");
//	level.vassili thread anim_single_solo(level.vassili,"vass_defeat");
}

event1_trucklink_without_train()
{
	truck1 = getent("truck1","targetname");
	truck2 = getent("truck2","targetname");

	if(self.targetname == "truck1_rider")
	{
		if(!isdefined(level.truck1_count))
		{
			level.truck1_count = 0;
		}
		else
		{
			level.truck1_count++;
		}
		self.climb_tag = (8 - level.truck1_count);

		org = truck1 gettagorigin("Tag_Guy0" + self.climb_tag);
		self teleport(org);

		self.animname = "truckriders";
		truck1 thread maps\_truck_gmi::handle_climbed_guys(self, (0,0,0));
	}
	else if(isdefined(self.groupname) && self.groupname == "friends")
	{
		if(isdefined(self.groupname) && self.groupname == "friends")
		{
	 		if(self.targetname == "vassili")
			{
				self.climb_tag = 2;
			}
			else if(self.targetname == "boris")
			{
				self.climb_tag = 1;
			}
			else if(self.targetname == "miesha")
			{
				self.climb_tag = 3;
			}

//			tag_org = truck1 gettagorigin("tag_guy0" + self.climb_tag);
//			mover = spawn("script_origin",(self.origin));
//			self linkto(mover);
//			mover moveto(tag_org,3,0,0);
//			mover waittill("movedone");
//	
//			self unlink();
//			mover delete();

			org = truck1 gettagorigin("Tag_Guy0" + self.climb_tag);
			self teleport(org);

			self.animname = "truckriders";
			truck1 thread maps\_truck_gmi::handle_climbed_guys(self, (0,0,0));		
		}
	}
	else if(self.targetname == "truck2_rider")
	{
		if(!isdefined(level.truck2_count))
		{
			level.truck2_count = 0;
		}
		else
		{
			level.truck2_count++;
		}
		self.climb_tag = (8 - level.truck2_count);

		org = truck2 gettagorigin("Tag_Guy0" + self.climb_tag);
		self teleport(org);

		self.animname = "truckriders";
		truck2 thread maps\_truck_gmi::handle_climbed_guys(self, (0,0,0));
	}
}

event1_distant_light()
{
	pos[0] = (-13656,-1040,376);
	pos[1] = (-12592,-3104,248);
	pos[2] = (-21056,2624,248);
	pos[3] = (-21952,-1280,642);
	pos[4] = (-21952,-7424,624);
	pos[5] = (-13384,-8616,416);
	pos[6] = (-5008,-13024,424);
	pos[7] = (-10872,-13024,568);
	pos[8] = (-7936,-13024,600);
	pos[9] = (-5120,-7592,784);
	pos[10] = (-5136,-3976,800);
	pos[11] = (-5056,5120,464);
	pos[12] = (-5248,11032,448);
	pos[13] = (-928,10048,288);
	pos[14] = (-994,-6488,350);

	for(i=0;i<pos.size;i++)
	{
		pos_org[i] = spawn("script_origin",(pos[i]));
		pos_org[i] thread random_distant_light_think(event1);
	}

	level waittill("stop event1 distant lights");

	for(i=0;i<pos_org.size;i++)
	{
		pos_org[i] delete();
	}
}

event1_train_sound()
{
	spot = spawn("script_origin", (level.player.origin));

//	spot playsound ("ambient_train_stop_short");
	
	traincar = getent("player_traincar","targetname");
	if(isdefined(traincar)) // Used to prevent from erroring out when quick_event16 is enabled.
	{
		traincar.stop_rocking = true;
	}
//	wait 3.2;
//	ambientPlay("ambient_rain_combat_int",1);
} 

event1_train_rock()
{
	traincar = getent("player_traincar","targetname");
	first_time = false;

	original_angles = traincar.angles;

	while(!traincar.stop_rocking)
	{
		roll = 0.1 + randomfloat(0.5);
		yaw = randomfloat(0.5);
//		angles = (0, (original_angles[1] + randomfloat(1)),(0.5 + randomfloat(1)));
		time = 0.25 + randomfloat(0.5);
		time_in_half = time/3;

		if(!first_time)
		{
			first_time = true;
			traincar rotateto((0,(original_angles[1] + yaw),roll), (time / 2),(time_in_half / 2),(time_in_half / 2));
			traincar waittill("rotatedone");
		}

		traincar rotateto((0,(original_angles[1] + (yaw * -2)),(roll * -2)), (time * 2),(time_in_half * 2),(time_in_half * 2));
		traincar waittill("rotatedone");

		traincar rotateto((0,(original_angles[1] + (yaw * 2)),(roll * 2)), (time * 2),(time_in_half * 2),(time_in_half * 2));
		traincar waittill("rotatedone");
	}

	traincar rotateto((original_angles),7,2,4);
}

event1_train_smoke (ent)
{
	self endon ("death");

	while (1)
	{
		num = 5 + randomint(5);
		for(i=0;i<num;i++)
		{
			playfx ( level._effect["train_smoke"], ent.origin );
			wait 0.3;
		}
		wait (1 + randomfloat(2));
	}
}

event1_attach_guys_to_train()
{
//	level thread tag_names();

	level.truck1_counter = 0; // Used to determine the last guy.
	player_traincar = getent("player_traincar","targetname");

	friends = getentarray("friends","groupname");
	for(i=0;i<friends.size;i++)
	{
		if(friends[i].targetname == "boris")
		{
//			friends[i] linkto(player_traincar,"tag_guy05",(0,0,0),(0,0,0));
			friends[i].train_tag = "tag_guy05";
		}

		if(friends[i].targetname == "vassili")
		{
//			friends[i] linkto(player_traincar,"tag_guy09",(0,0,0),(0,0,0));
			friends[i].train_tag = "tag_guy09";
		}

		if(friends[i].targetname == "miesha")
		{
//			friends[i] linkto(player_traincar,"tag_guy06",(0,0,0),(0,0,0));
			friends[i].train_tag = "tag_guy06";	
		}
	}

	truck1_riders = getentarray("truck1_rider","targetname");
	truck2_riders = getentarray("truck2_rider","targetname");
	train_riders = add_array_to_array(truck1_riders,truck2_riders);

	// Get rid of unwanted train_riders
	extra_riders = getentarray("train_rider","targetname");
	for(i=0;i<extra_riders.size;i++)
	{
		extra_riders[i] delete();
	}	

	num = 0;
	for(i=0;i<train_riders.size;i++)
	{
		num++;
		if(num == 5)
		{
			num+=2;
		}

		if(num == 9)
		{
			num++;
		}

		if(num < 10)
		{
//			train_riders[i] linkto(player_traincar,("tag_guy0" + num),(0,0,0),(0,0,0));
			train_riders[i].train_tag = ("tag_guy0" + num);
		}
		else
		{
//			train_riders[i] linkto(player_traincar,("TAG_GUY" + num),(0,0,0),(0,0,0));
			train_riders[i].train_tag = ("tag_guy" + num);
		}
		train_riders[i].goalradius = 64;
	}

	// Set up truck drivers
	drivers = getentarray("truck_driver","groupname");
	for(i=0;i<drivers.size;i++)
	{
		truck = getent(("truck" + drivers[i].script_vehiclegroup),"targetname");

		if(isdefined(truck))
		{
			if(truck.targetname == "truck3")
			{
				drivers[i].health = 50; // So he dies when his truck explodes.
			}
			drivers[i].targetname = (truck.targetname + "_rider");
			driver[0] = drivers[i]; // Since it has to be an array.
			truck thread maps\_truck_gmi::handle_attached_guys(driver);
		}
	}

	truck2 = getent("truck2","targetname");
	truck2.ready_to_go = false;

	tag_dummy = spawn("script_model",(-17441, -3642, -60));
	tag_dummy setmodel("xmodel/trenches_opening_dummies");
	tag_dummy UseAnimTree(level.scr_animtree["train_dummy"]);

	// Put everbody, in relative position.
	train_riders = add_array_to_array(train_riders,friends);
	println("train_riders.size ",train_riders.size);
	for(i=0;i<train_riders.size;i++)
	{
		train_riders[i] thread event1_setup_train_riders(tag_dummy);
	}

	level waittill("finished final intro screen fadein");

	for(i=1;i<17;i++)
	{
		train_rider = undefined;
		if(i<10)
		{
			tag = ("tag_guy0" + i);
		}
		else
		{
			tag = ("tag_guy" + i);
		}
		
		for(q=0;q<train_riders.size;q++)
		{
//			println("Train Rider Info: ",train_riders[q].targetname, " TAG: ", train_riders[q].train_tag);
			if(train_riders[q].train_tag == tag)
			{
				train_rider = train_riders[q];
			}
		}

		train_rider unlink();

//		println("^2Train_rider ",train_rider," ",train_rider.train_tag," ",train_rider.interval);
		train_rider thread event1_exit_train(tag_dummy, i);
	}
	
	wait 0.5;
	
	level notify ("tag_dummy_go");

//	tag_dummy setFlaggedAnimKnobRestart("animdone", level.scr_anim["train_dummy"]["start"]);
	tag_dummy animscripted("the_anim", tag_dummy.origin, tag_dummy.angles, level.scr_anim["train_dummy"]["start"]);
//	tag_dummy waittill("animdone");
}

event1_setup_train_riders(tag_dummy)
{
	org = spawn("script_origin",self.origin);

	self linkto(org,"",(0,0,0),(0,0,0));
	wait 0.2;
	org.angles = tag_dummy gettagangles(self.train_tag);
	org.origin = tag_dummy gettagorigin(self.train_tag);
	wait 0.2;
	self unlink();
	org delete();
}

tag_names()
{
	wait 1;

	while(1)
	{
		allies = getaiarray("allies");

		for(i=0;i<allies.size;i++)
		{
			if(isalive(allies[i]))
			{
				if(isdefined(allies[i].train_tag))
				{
					print3d((allies[i].origin + (0,0,72)), allies[i].train_tag, (1,1,1), 0.25);
				}
			}
		}
		wait 0.06;
	}
}

event1_exit_train(tag_dummy, num)
{
	self.animname = "truckriders";
	self linkto(tag_dummy,self.train_tag, (0,0,0),(0,0,0));

//	println("TAG_ANGLES = ",tag_angles);
//	println("self.angles = ",self.angles);
//	self.angles = tag_angles;

	self thread event1_exit_train_notetrack(tag_dummy);

	level waittill("tag_dummy_go");

	if(self.train_tag != "tag_guy01" && self.train_tag != "tag_guy02" && self.train_tag != "tag_guy11" && self.train_tag != "tag_guy10" && self.train_tag != "tag_guy15")
	{
		self anim_single_solo(self,("climb_out_" + num),self.train_tag,undefined,tag_dummy);
	}
}

event1_exit_train_notetrack(tag_dummy)
{
	go = true;
	while(go)
	{
		tag_dummy waittill("the_anim", notetrack);

//		println("NOTETRACK FOUND = ", notetrack);
		if(notetrack == (self.train_tag + "_run"))
		{
//			println("START RUNNING!");
			self thread event1_exit_train_runloop(tag_dummy);
		}
		else if(notetrack == (self.train_tag + "_unlink"))
		{
			println(self.train_tag, " UNLINK!");
			self notify("stop_running");

			if(self.targetname == "truck2_rider")
			{
				self thread event1_truck2_climb();
				go = false;
			}
			else
			{
				self thread event1_truck1_climb();
				go = false;
			}
		}
	}
}

event1_exit_train_runloop(tag_dummy)
{
	self endon("stop_running");
	while(1)
	{
		num = randomint(level.scr_anim[self.animname]["run_loop"].size);

		angles = tag_dummy gettagangles(self.train_tag);
		origin = tag_dummy gettagorigin(self.train_tag);
	
		self animscripted("animdone", origin, angles, level.scr_anim[self.animname]["run_loop"][num]);
		self animscripts\shared::DoNoteTracks("animdone");
	}
}

event1_commissar_dialog_loop(without_train)
{
	train_commissar = getent("commissar_train","targetname");
	train_commissar.animname = "train_commissar";
	train_commissar.dontavoidplayer = true;
	train_commissar settakedamage(0);

	if(!isdefined(without_train))
	{
		level thread event1_train_comm(train_commissar);
	}

	// Setup fake_commissar1, guy with bullhorn at beginning of trench.
	fake_commissar = spawn("script_model",(-17594,-3628,11));
	fake_commissar.animname = "truck_commissar";
	fake_commissar.groupname = "start_truck_commissars";
	fake_commissar.targetname = "truck_commissar";
	fake_commissar setmodel ("xmodel/character_soviet_overcoat");
	fake_commissar UseAnimTree(level.scr_animtree[fake_commissar.animname]);
	if(getcvarint("og_start") < 1)
	{
		fake_commissar.angles = (0,20,0);
	}
	else
	{
		fake_commissar.angles = (2,270,-10);	
	}
	fake_commissar [[level.scr_character[fake_commissar.animname]]]();
	fake_commissar thread anim_loop_solo(fake_commissar, "idle", undefined, "stop anim");
	fake_commissar.loop = true;

	if(!isdefined(without_train))
	{
		trigger = getent("event1_start_stukas","targetname");
		trigger waittill("trigger");
		train_commissar notify("stop anim");
	
		train_commissar thread anim_single_solo(train_commissar,"in_trenches");
		wait 3;
	}

	fake_commissar endon("death");
//	while (guy[0].loop)
//	{
		wait 0.25;
println("LOOPING!");
		fake_commissar notify("stop anim");
		println("^1 ------- COMMISSAR BEFORE");
		fake_commissar thread anim_single_solo (fake_commissar, "comm_ev01_01", undefined);
		fake_commissar waittill("animscript facedone");
		println("^1 ------- COMMISSAR AFTER");
		fake_commissar thread anim_loop_solo(fake_commissar, "idle", undefined, "stop anim");
//		wait 13.5;
//	}
//	guy[0] notify("stop anim");
//	guy[0] thread anim_loop(guy, "idle", undefined, "stop anim", node);
}

event1_train_comm(train_commissar)
{
	train_commissar endon("death");
	level endon ("getting in truck");
	level waittill("finished intro screen");

	while(1)
	{
		while(distance(level.player.origin, train_commissar.origin) > 180)
		{
			wait 0.5;
		}
		train_commissar anim_single_solo(train_commissar,"get_out_of_train");
		wait 1 + randomfloat(2);
	}
}

event1_stuka_while_in_train()
{
	if(getcvar("quick_start") != 1)
	{
		for(i=1;i<3;i++)
		{
			path = getvehiclenode("train_stuka_bomb_path" + i,"targetname");

			stuka = spawnvehicle("xmodel/vehicle_plane_stuka","train_stuka","Stuka",path.origin,path.angles);
			stuka.health = 1000;
			stuka.script_noteworthy = "noturrets";
			stuka maps\_stuka_gmi::init(4);
			stuka notify("wheelsup");
			stuka notify("takeoff");
	
			stuka.attachedpath = path;
			if(i==2)
			{
				wait 10;
			}
			stuka attachPath(path);
			stuka startpath();
			stuka playsound("bf109_attack01");
			level thread stuka_bombing_think(stuka, 1, 0, 0, 0);
		}
	}

	level waittill("detach train riders");

	println("^5************STUKA RUN IN TRAIN************");
	// Do the bomb run right in front of the trucks.
	paths = getvehiclenodearray("event1_random_stuka_path","targetname");
	for(i=0;i<paths.size;i++)
	{
		if(isdefined(paths[i].script_noteworthy) && paths[i].script_noteworthy == "while_in_train")
		{
			stuka = spawnvehicle("xmodel/vehicle_plane_stuka","event1_random_stuka","Stuka",paths[i].origin,paths[i].angles);
			stuka.health = 1000;
			stuka.script_noteworthy = "noturrets";
			stuka maps\_stuka_gmi::init(4);
			stuka notify("wheelsup");
			stuka notify("takeoff");
	
			stuka.attachedpath = paths[i];
			stuka attachPath(paths[i]);
			stuka startpath();
			stuka playsound("bf109_attack01");
			level thread stuka_bombing_think(stuka, 1, 0, 0, 0);
		}
	}
}

event1_stukas(without_train)
{
	if(!isdefined(without_train))
	{
		trigger = getent("event1_start_stukas","targetname");
		trigger waittill("trigger");
	}

	ambientplay("ambient_trenches_01",1);

// Bug, if the player shoots the truck while the planes are flying in, he will destroy it... FIX ME!
	truck6 = getent("truck6","targetname");
	truck6.health = 10;
	truck5 = getent("truck5","targetname");
	truck5.health = 10;

	level thread event1_stuka_formation();
	level thread event1_random_stukas();
	level thread event1_side_trucks_go();


	for(i=1;i<3;i++)
	{
		path = getvehiclenode("event1_stuka_path" + i,"targetname");

		stuka = spawnvehicle("xmodel/vehicle_plane_stuka","event1_stuka","Stuka",path.origin,path.angles);
		stuka.health = 1000;		
		stuka maps\_stuka_gmi::init(4);
		stuka notify("wheelsup");
		stuka notify("takeoff");

		stuka.attachedpath = path;
		stuka attachPath(path);
		stuka startpath();
		level thread stuka_bombing_think(stuka);
	
		if(i == 1)
		{
			sound_delay = 4.75;
			delay = 3.7;
		}
		else
		{
			sound_delay = 1;
			delay = 11.3;
		}

	
		stuka thread event1_stuka_bomb_think(delay, 0.25, 512);
	}


}

event1_stuka_bomb_think(delay, delay2, range)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	if(!isdefined(range))
	{
		range = 256;
	}
	
//                                   drop_bombs(amount, delay, delay_trace, damage_range, max_damage, min_damage, trace_dist)
	if(self.attachedpath.targetname == "event1_stuka_path1")
	{
		self thread maps\_stuka_gmi::drop_bombs(undefined, delay2, 1.25, range, 1000, 0, 100);
	}
	else
	{
		wait 0.1;
		self thread maps\_stuka_gmi::drop_bombs(undefined, delay2, 1, range, 1000, 0, 100);
	}
}

event1_stuka_sound(sound_delay, plane_id)
{
	self endon("death");
	wait sound_delay;
	if(plane_id == 1)
	{
		random_num = randomint(2);
		if(random_num == 0)
		{
			self playsound("stuka_flyby_01");
		}
		else
		{
			self playsound("stuka_flyby_03");
		}
	}
	else
	{
		self playsound("stuka_flyby_02");
	}
}

#using_animtree("trenches_truck_dummies");
event1_side_trucks_setup()
{
	for(q=5;q<7;q++)
	{
		truck = getent("truck" + q,"targetname");

		for(i=1;i<9;i++)
		{
			if (i < 10)
			{
				tag_num = ("tag_guy0" + i);
			}
			else
			{
				tag_num = ("tag_guy" + i);
			}
	
	//println("^5DUMMY ",anim_name," Spawned! Num: ", i);
			tag_org = truck gettagorigin(tag_num);
			dummy = spawn ("script_model",(tag_org));
			if(!isdefined(level.dummy_count))
			{
				level.dummy_count = 0;
			}
			level.dummy_count++;
			dummy.tag = tag_num;
			dummy.targetname = "dummy";
			dummy.num = i;
			dummy.died = false;
			dummy.animname = "event1_truck_dummies";
			dummy UseAnimTree(#animtree);
	
			random_weapon = randomint(2);
			if(random_weapon == 0)
			{
				dummy attach("xmodel/weapon_ppsh", "tag_weapon_right");
			}
			else
			{
				dummy attach("xmodel/weapon_mosinnagant", "tag_weapon_right");				
			}
	
			dummy [[random(level.scr_character[dummy.animname])]]();
	
			dummy linkto(truck);
			
			dummy.move_index = randomint (level.scr_anim[dummy.animname]["idle"].size);
			dummy.move_anim = level.scr_anim[dummy.animname]["idle"][dummy.move_index];
			dummy thread maps\trenches_dummies::dummy_animloop(true, "idle");
			dummy thread maps\trenches_dummies::special_truck_dummy_death();
		}
	}
}
#using_animtree("generic_human");
event1_side_trucks_go()
{
	truck6 = getent("truck6","targetname");
	truck5 = getent("truck5","targetname");

	truck5 thread maps\_truck_gmi::toggle_beddoor();
	truck5 attachpath(getvehiclenode("truck5_start","targetname"));
	truck5 startpath();
	truck5 maps\_truck_gmi::init();
	truck5.health = 10;
	truck5 thread event1_truck_death();

	wait 7;
	truck6 thread maps\_truck_gmi::toggle_beddoor();
	wait 1;
	truck6 attachpath(getvehiclenode("truck6_start","targetname"));
	truck6 startpath();
	truck6 maps\_truck_gmi::init();
	truck6.health = 10;
	truck6 thread event1_truck_death();
}

event1_truck_death()
{
	self waittill("death");
	self playsound("mass_scream");
}

#using_animtree("trenches_dummies_path");
event1_dummies(without_train)
{
	if(!isdefined(without_train))
	{
		trigger = getent("event1_dummy_bombing","targetname");
		trigger waittill("trigger");
	}

	anim_wait = [];

	for(i=0;i<20;i++)
	{
		if(i<12)
		{
			anim_wait[i] = 50;
		}
		else
		{
			anim_wait[i] = 40;
		}
	}

	level thread maps\trenches_dummies::dummies_setup((-14832, -2224, 135), "xmodel/trenches_dummies_scatterA", 20, (0,0,0), undefined, undefined, %trenches_dummies_scatterA, false, "event1_dummies", anim_wait, true);

	anim_wait_2 = [];
	anim_wait_2[0] = 14;
	anim_wait_2[1] = 22;
	anim_wait_2[2] = 22;
	anim_wait_2[3] = 28;
	anim_wait_2[4] = 28;
	anim_wait_2[5] = 33;
	anim_wait_2[6] = 33;
	anim_wait_2[7] = 36;
	anim_wait_2[8] = 49;
	anim_wait_2[9] = 49;
	
	level thread maps\trenches_dummies::dummies_setup((-16697, -2698, -41), "xmodel/trenches_dummies_house2trainA", 10, (0,0,0), undefined, undefined, %trenches_dummies_house2trainA, true, "event1_dummies2", anim_wait_2, true);

	level thread event1_dummy_bomb_path();

	wait 0.25;
	anim_wait = [];
	anim_wait[0] = 20;

	level thread maps\trenches_dummies::dummies_setup((-17441, -3642, -60), "xmodel/trenches_dummies_truckA", 9, (0,180,0), undefined, undefined, %trenches_dummies_truckA, true, "event1_truck_dummies", anim_wait, false, "truckA_blow");

	if(!isdefined(without_train))
	{
		wait 5;
	}
	else
	{
		wait 1;
	}
	level thread maps\trenches_dummies::dummies_setup((-17441, -3642, -60), "xmodel/trenches_dummies_truckB", 9, (0,180,0), undefined, undefined, %trenches_dummies_truckB, true, "event1_truck_dummies", anim_wait, false, "truckB_blow");
}

// First bomber that bombs the guys on the ground in the far distance (first stuka you see).
event1_dummy_bomb_path()
{
	path = getvehiclenode("event1_dummy_bomb_path","targetname");

	wait 0.25;
	stuka = spawnvehicle("xmodel/vehicle_plane_stuka","dummy_bomber","Stuka",path.origin,path.angles);
	stuka.health = 10000;		
	stuka maps\_stuka_gmi::init(4);
	stuka notify("wheelsup");
	stuka notify("takeoff");
	stuka.attachedpath = path;
	stuka attachpath(path);
	stuka startpath();

	random_num = randomint(2);
	if(random_num == 0)
	{
		stuka playsound("stuka_flyby_01");
	}
	else
	{
		stuka playsound("stuka_flyby_03");
	}

	wait 2.75;
	println("***********************DROPPING BOMBS!");
	stuka thread maps\_stuka_gmi::drop_bombs(undefined, 0.15, 1, 768, 0, 0);
}

#using_animtree("generic_human");

event1_stuka_formation()
{
	wait 10;
	paths = getvehiclenodearray("event1_stuka_formation","targetname");
	for(i=0;i<paths.size;i++)
	{
		stuka = spawnvehicle("xmodel/vehicle_plane_stuka",("event1_stuka_formation_" + i),"Stuka",paths[i].origin,paths[i].angles);
		stuka.health = 50000;
		stuka.script_noteworthy = "noturrets";
		stuka maps\_stuka_gmi::init(4);
		stuka notify("wheelsup");
		stuka notify("takeoff");

		stuka attachPath(paths[i]);
		stuka startpath();

	}
	wait 3;
	stuka playsound("squadron_flyover_01");
}

event1_random_stukas()
{
	level endon("stop_random_stukas");
	wait 15;
	level.event1_random_stuka_deaths = 0;

	tracker = 0;

	paths = getvehiclenodearray("event1_random_stuka_path","targetname");

	while(!level.event1["player_in_truck"])
	{
		paths = maps\_utility_gmi::array_randomize(paths);

		for(i=0;i<paths.size;i++)
		{
			stuka = spawnvehicle("xmodel/vehicle_plane_stuka",("event1_random_stuka"),"Stuka",paths[i].origin,paths[i].angles);
			stuka.health = 50000;
			stuka maps\_stuka_gmi::init(4);
	
			stuka notify("wheelsup");
			stuka notify("takeoff");
	
			stuka.attachedpath = paths[i];
			stuka attachPath(paths[i]);
			stuka startpath();
			
			level thread stuka_bombing_think(stuka, 1, 257, 200, 0);
			level thread event1_stuka_track(stuka);
	
			level waittill("random_stukas_go");
		}
	}
}

stuka_sound()
{
	self endon("death");

	if(isdefined(self.attachedpath.script_delay))
	{
		wait self.attachedpath.script_delay;
	}

	if(isdefined(self.attachedpath.script_sound))
	{
		self playsound(self.attachedpath.script_sound);
	}
	else
	{
		self playsound("bf109_attack01");
	}
}

// Was using vehiclechase, but for some reason, the plane must also have crash paths.. PFFT! Riiight! :P
stuka_bombing_think(stuka, trace_delay, damage_radius, max_damage, min_damage)
{
	level endon("stop_random_stukas");
	stuka endon("death");

	if(!isdefined(stuka.attachedpath))
	{
		println("^1NO '.ATTACHEDPATH' FOUND FOR STUKA, ",stuka.targetname);
		return;
	}
	pathstart = stuka.attachedpath;

	stuka thread stuka_sound();

	pathpoint = pathstart;
	arraycount = 0;
	while(isdefined (pathpoint))
	{
		pathpoints[arraycount] = pathpoint;
		arraycount++;
		if(isdefined (pathpoint.target))
		{
			pathpoint = getvehiclenode(pathpoint.target, "targetname");

		}
		else
		{
			break;
		}
	}

	pathpoint = pathstart;
	random_num = 0;
	for(i=0;i<pathpoints.size;i++)
	{
		if(isdefined(pathpoints[i].script_noteworthy))
		{
			stuka setWaitNode(pathpoints[i]);
			stuka waittill ("reached_wait_node");

			if (pathpoints[i].script_noteworthy == "start_firing")
			{

				stuka thread maps\_stuka_gmi::shoot_guns();

			}
			else if (pathpoints[i].script_noteworthy == "start_firing_notarget")
			{
				stuka thread maps\_stuka_gmi::shoot_guns(true);
			}
			else if (pathpoints[i].script_noteworthy == "start_fake_firing")
			{
				if(isdefined(stuka.event4_truck_strafe) && stuka.event4_truck_strafe)
				{
					stuka thread event4_truck1_strafe();
				}

				stuka thread fake_plane_fire();
			}
			else if (pathpoints[i].script_noteworthy == "start_firing_short_sound")
			{

				random_num = randomint(2);
				if(random_num == 0)
				{
					stuka playsound("stuka_attack_02");
				}
				else
				{
					stuka playsound("stuka_attack_01");
				}
			}
			else if (pathpoints[i].script_noteworthy == "stop_firing")
			{
				stuka notify ("stop mg42s");
			}
			else if (pathpoints[i].script_noteworthy == "drop_bombs")
			{
				if(isdefined(pathpoints[i].script_delay))
				{
					wait pathpoints[i].script_delay;
				}

				if(level.event1["player_in_truck"]) // Prevent any bombs being dropped after the player is on the truck.
				{
					continue;
				}

				if(isdefined(stuka.targetname) && stuka.targetname == "event4_vill_stuka")
				{
					for(i=0;i<3;i++)
					{
						tank = getent("event3_vill_tank_" + i,"targetname");
						if(tank.health > 0)
						{
							tank.health = 1;
						}
					}
				}
				stuka thread maps\_stuka_gmi::drop_bombs(undefined, undefined, 1, damage_radius, max_damage, min_damage);
			}
			else if (pathpoints[i].script_noteworthy == "drop_1_bomb")
			{
				if(isdefined(pathpoints[i].script_delay))
				{
					wait pathpoints[i].script_delay;
				}

				stuka thread maps\_stuka_gmi::drop_bombs(1, undefined, 1, damage_radius, max_damage, min_damage);
			}
		}
	}
}

event1_stuka_track(stuka)
{
	stuka waittill("reached_end_node");
	
	level.event1_random_stuka_deaths++;
	println("STUKA COUNT ",level.event1_random_stuka_deaths);
//	if(level.event1_random_stuka_deaths == 3)
//	{
//		wait (1 + randomfloat(3));
		level.event1_random_stuka_deaths = 0;
		level notify("random_stukas_go");
		println("Random Stukas GO!");
//	}
}

event1_truck1_climb()
{
	self.climb_tag = self event1_assign_climb_tag();
//	self thread climb_tag_names();

	truck1 = getent("truck1","targetname");
	truck1_riders = getentarray("truck1_rider","targetname");

//	println("Truck1_riders BEFORE ",truck1_riders.size);
	for(i=0;i<truck1_riders.size;i++)
	{
		if(isdefined(truck1_riders[i].script_noteworthy) && truck1_riders[i].script_noteworthy == "driver")
		{
//			println("^1DRIVER FOUND!");
			truck1_driver = truck1_riders[i];
		}
	}
	truck1_riders = maps\_utility_gmi::subtract_from_array(truck1_riders, truck1_driver);

	friends = getentarray("friends","groupname");
	truck1_riders = add_array_to_array(truck1_riders,friends);

	if(self.train_tag == "tag_guy04")
	{
		level waittill("wait_for_4");
	}
	else if(self.train_tag == "tag_guy07")
	{
		level notify("wait_for_4");
	}

	self thread maps\_truck_gmi::climb_in_truck(delay, truck1, offset);
	self waittillmatch ("climb_in","end");

	if(!isdefined(level.truck1_count))
	{
		level.truck1_count = 0;
	}
	else
	{
		level.truck1_count++;
	}

	if(level.truck1_count == 4) // Not using 7, cause it will be alright if the player hops on while vassili is hopping on.
	{
		level notify("player get in truck");
	}
}

event1_truck2_climb()
{
	// Give everyone the correct "climb" tags, using their train_tag as a check.

	self.climb_tag = self event1_assign_climb_tag();
//	self thread climb_tag_names();

	truck2 = getent("truck2","targetname");
	truck2_riders = getentarray("truck2_rider","targetname");

	for(i=0;i<truck2_riders.size;i++)
	{
		if(isdefined(truck2_riders[i].script_noteworthy) && truck2_riders[i].script_noteworthy == "driver")
		{
//			println("^1DRIVER FOUND!");
			truck2_driver = truck2_riders[i];
		}
	}
	truck2_riders = maps\_utility_gmi::subtract_from_array(truck2_riders, truck2_driver);

	if(self.train_tag == "tag_guy15")
	{
		level waittill("wait_for_4");
	}
	else if(self.train_tag == "tag_guy12")
	{
		level notify("wait_for_4");
	}

	self thread maps\_truck_gmi::climb_in_truck(delay, truck2, offset);
	self waittillmatch ("climb_in","end");

	if(!isdefined(level.truck2_count))
	{
		level.truck2_count = 0;
	}
	else
	{
		level.truck2_count++;
	}

//	println("Truck2_count ",level.truck2_count);
	if(level.truck2_count == 7)
	{
		truck2 thread maps\_truck_gmi::toggle_beddoor();
		truck2.ready_to_go = true;
		truck2 notify("ready to go");
	}
}

event1_assign_climb_tag()
{
	if(self.train_tag == "tag_guy10" || self.train_tag == "tag_guy01")
	{
		num = 8;
	}
	else if(self.train_tag == "tag_guy11" || self.train_tag == "tag_guy02")
	{
		num = 7;
	}
	else if(self.train_tag == "tag_guy12" || self.train_tag == "tag_guy07")
	{
		num = 4;
	}
	else if(self.train_tag == "tag_guy13" || self.train_tag == "tag_guy06")
	{
		num = 3;
	}
	else if(self.train_tag == "tag_guy14" || self.train_tag == "tag_guy03")
	{
		num = 5;
	}
	else if(self.train_tag == "tag_guy15" || self.train_tag == "tag_guy04")
	{
		num = 6;
	}
	else if(self.train_tag == "tag_guy16" || self.train_tag == "tag_guy05")
	{
		num = 1;
	}
	else if(self.train_tag == "tag_guy08" || self.train_tag == "tag_guy09")
	{
		num = 2;
	}

	return num;
}

climb_tag_names()
{
	while(1)
	{
		print3d((self.origin + (0,0,72)), self.climb_tag, (1,1,1), 0.25);
		wait 0.06;
	}
}

event1_player_get_in_truck()
{
	trigger = getent("use_truck","targetname");
 	trigger maps\_utility_gmi::triggerOff();

	level waittill("player get in truck");

	trigger maps\_utility_gmi::triggerOn();
	trigger waittill("trigger");
	trigger delete();

	train_crap = getentarray("train_crap","targetname");
	for(i=0;i<train_crap.size;i++)
	{
		train_crap[i] delete();
	}

	level thread event1_truck_rider_dialogue();

	truck1 = getent("truck1","targetname");
	truck2 = getent("truck2","targetname");
	truck3 = getent("truck3","targetname");
	truck4 = getent("truck4","targetname");
	truck5 = getent("truck5","targetname");
	truck6 = getent("truck6","targetname");

	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowProne(false);

	player_origin = spawn("script_origin", (level.player.origin));
	level.player linkto(player_origin);

	if(distance(level.player.origin, (-17653,-3720,-36)) > 16)
	{
		player_origin moveto((-17653,-3720,-36), 1, 0.75);
		player_origin waittill("movedone");
	}

	pos1 = truck1 gettagorigin("tag_climbnode");
	pos1_forward = anglestoforward(truck1.angles);

	destination = pos1;
	diff = (((destination[0] - player_origin.origin[0]) / 2), ((destination[1] - player_origin.origin[1]) / 2), ((destination[2] - player_origin.origin[2]) / 2));

	// current origin
	origin = player_origin.origin;
	for(i=0;i<2;i++)
	{
		origin = (origin + diff);
		player_origin moveto(origin, 1.5, 0.75, 0.4);
		player_origin waittill("movedone");
		println("MOVE DONE!");
	}

	pos1_vec = maps\_utility_gmi::vectorScale (pos1_forward, -100);
	pos2 = (truck1 gettagorigin("tag_player") + ((pos1_vec) + (0,0,6)));

	level.player_in_truck = true;

	player_origin moveto(pos2, 0.75, 0.2, 0.5);
	player_origin waittill("movedone");	

	level notify("objective 1 complete");
	
	level.player unlink();
	level.player linkto(truck1);
	player_origin delete();

	wait 2.5;

	level waittill("trucks_go");

	fake_commissar = getent("truck_commissar","targetname");
	fake_commissar.loop = false;
	fake_commissar thread maps\trenches_dummies::extra_dummy_think_death();

	wait 1;

	truck2_path = getvehiclenode("truck2_start","targetname");
	truck2 attachpath(truck2_path);
	truck2 startpath();
	truck2.health = 50000; // So it doesn't die on Accident

	wait 1;

	truck1_path = getvehiclenode("truck1_start","targetname");
	truck1 attachPath(truck1_path);
	truck1 startpath();
	truck1.health = 50000; // So it doesn't die on Accident
	level thread event3_dummies_1();
	level thread event3_stuka_dive();

	truck3 thread maps\_truck_gmi::toggle_beddoor();
	wait 0.5;

	truck3_path = getvehiclenode("truck3_start","targetname");
	truck3 attachPath(truck3_path);
	truck3 startpath();
	truck3 thread event1_truck_death();

	truck4 thread maps\_truck_gmi::toggle_beddoor();
	wait 1.5;

	truck4_path = getvehiclenode("truck4_start","targetname");
	truck4 attachPath(truck4_path);
	truck4 startpath();
	truck4.health = 50000; // So it doesn't die on Accident
	// Debug stuff...
//	truck1 thread draw_speed(); //Testing
//	truck1 thread drive_timer(truck1);

	level thread event3_tanks_1();
	level thread event1_cleanup();
	level thread event3_prisoner_dummies();
	level thread event3_village_dummies();

	truck1_riders = getentarray("truck1_rider","targetname");
	println("^6Truck1 Rider: Stukas! Keep your heads down!");
	for(i=0;i<truck1_riders.size;i++)
	{
		if(truck1_riders[i].exittag == "tag_guy04")
		{
			stuka_shouter = truck1_riders[i]; // So it's close to the player.
			level.stuka_shouter = stuka_shouter;
		}

		if(truck1_riders[i].exittag == "tag_guy05")
		{
			stuka_shouter2 = truck1_riders[i]; // So it's close to the player.
			level.stuka_shouter2 = stuka_shouter2;
		}
	}
	stuka_shouter.animname = "truckriders";
	stuka_shouter2.animname = "truckriders";

	wait 4;
	level thread truck_call_anim("truck1_rider", (getent("truck1","targetname")), "stuka_point");
	wait 3;
	println("^6Truck1 Rider: Oh my god They took out the train!");
	level thread truck_call_anim("truck1_rider", (getent("truck1","targetname")), "train_dead", random, "tag_guy07");
	level thread event1_blow_train();
	
	wait 2;
	println("^6Truck1 Rider2: Better than hitting us.");
//	stuka_shouter2 thread anim_single_solo(stuka_shouter2,"better_than_us");

	wait 6;
	println("^6Miesha: The front can't possibly be worse than this madness!");
	level.miesha thread anim_single_solo(level.miesha,"this_madness");

	wait 4;
	println("^6Vassili: Steady comrades…defeat your fear, the enemy will be easy");
	level.vassili thread anim_single_solo(level.vassili,"vass_defeat");
}

event1_truck_rider_dialogue()
{
	//level thread event1_truck_rider_shout("get_down");
	wait 1;

	level notify("stop_random_stukas");

	level thread event1_commissar_close_truckdoor();
	wait 3;

//	level thread event1_truck_rider_shout("get_us_outta_here");
}

event1_commissar_close_truckdoor(without_train)
{
	truck1 = getent("truck1","targetname");
	train_commissar = getent("commissar_train","targetname");
//	train_commissar setgoalnode(getnode("train_commissar_spot","targetname"));
	train_commissar.goalradius = 0;
	tag_origin = truck1 gettagorigin("TAG_CLIMB08");
	train_commissar setgoalpos(tag_origin);
	train_commissar waittill("goal");

	println("^6Commissar: Truck is full, go. ",train_commissar.animname);
	
	level notify ("getting in truck");
	
	train_commissar thread anim_single_solo(train_commissar,"truck_full", "TAG_CLIMB08", undefined, truck1);

	// Mini notetrack finder
	while(1)
	{
		train_commissar waittill("single anim",notetrack);

		if(isdefined(notetrack))
		{
			if(notetrack == "bang")
			{
				println("^6*BANG*");
			}
			
			if(notetrack == "door_close")
			{
				if(!isdefined(without_train))
				{
					truck1 thread maps\_truck_gmi::toggle_beddoor();
					println("^6*DOORCLOSE*");
				}
			}
			
			if(notetrack == "end")
			{
				println("^6*END*");
				break;
			}
		}
		println("^6*IN LOOP*");
	}

	level notify("trucks_go");
}

event1_truck_rider_shout(sound, ent)
{
	if(!isdefined(ent))
	{
		truck1_riders = getentarray("truck1_rider","targetname");
		for(i=0;i<truck1_riders.size;i++)
		{
			if(!isdefined(truck1_riders[i].exittag)) // Assume climb_tag is defined.
			{
				println("truck1_riders[i].climb_tag ", truck1_riders[i].climb_tag);
				if(truck1_riders[i].climb_tag == "4")
				{
					stuka_shouter = truck1_riders[i]; // So it's close to the player.
					level.stuka_shouter = stuka_shouter;
				}
			}
			else
			{
				if(truck1_riders[i].exittag == "tag_guy04")
				{
					stuka_shouter = truck1_riders[i]; // So it's close to the player.
					level.stuka_shouter = stuka_shouter;
				}
			}
		}
	}
	else
	{
		stuka_shouter = ent;
	}

	stuka_shouter.animname = "truckriders";

	stuka_shouter thread anim_single_solo(stuka_shouter,sound);
}

event1_cleanup()
{
	trigger = getent("event1_cleanup","targetname");
	trigger waittill("trigger");

	level thread event4_wounded_dummies();
	level thread event4_village_tanks();
	level thread event5_coming_trucks();

	level notify("stop falling mortars");
	// Stop fx at the beginning of the map.
//	level.mortar_mindist = 460;
//	level.mortar_maxdist = 1500;
//	level.mortar_random_delay = 25;
	level.mortar_mindist = 512;
	level.mortar_maxdist = 5000;
	level.mortar_random_delay = 15;

	// Optimizing.
	if(getcvarint("scr_gmi_fast") != 2)
	{
		creek_allies = getentarray("event3_creek_allies","groupname");
		for(i=0;i<creek_allies.size;i++)
		{
			spawned = creek_allies[i] stalingradspawn(); // CHEATER! Aww yeah!
			if(isdefined(spawned))
			{
				node = getnode(creek_allies[i].target,"targetname");
				spawned thread follow_nodes(node, true);
			}
		}
	}

	// Reset all of the trucks healths.
	for(i=1;i<7;i++)
	{
		truck[i] = getent("truck" + i,"targetname");
		if(truck[i].health <= 0)
		{
			if(isalive(truck[i]))
			{
				truck[i].health = 500;
			}
		}
	}

	// Switch to the cheap stuka bomb explosions.
	level.stuka_bomb = level.stuka_bomb_low;

	// STUKA Village fly-by
	paths = getvehiclenodearray("village_stuka_path1","targetname");
	for(i=0;i<paths.size;i++)
	{
		stuka = spawnvehicle("xmodel/vehicle_plane_stuka",("stuka_" + i),"Stuka",paths[i].origin,paths[i].angles);
		stuka.health = 10000;		
		stuka maps\_stuka_gmi::init(4);
		stuka notify("wheelsup");
		stuka notify("takeoff");

		stuka.attachedpath = paths[i];
		stuka attachPath(paths[i]);
		stuka startpath();
		stuka playsound("bf109_attack01");
		level thread stuka_bombing_think(stuka, 1, 0, 0, 0);
	}

	level notify("stop fx event1");

	println("^3EVENT1 CLEANED UP!");

	player_traincar = getent("player_traincar","targetname");
	player_traincar delete();
	train_clip = getent("player_traincar_clip","targetname");
	train_clip delete();

	truck_commissars = getentarray("start_truck_commissars","groupname");
	train_commissars = getentarray("start_train_commissars","groupname");
	all = add_array_to_array(truck_commissars,train_commissars);

	train_riders = getentarray("train_rider","targetname");
	all = add_array_to_array(all,train_riders);

	train = getentarray("train","targetname");
	all = add_array_to_array(all,train);

	truck5_riders = getentarray("truck5_rider","targetname");
	all = add_array_to_array(all,truck5_riders);

	truck6_riders = getentarray("truck6_rider","targetname");
	all = add_array_to_array(all,truck6_riders);

	for(i=0;i<all.size;i++)
	{
		all[i] delete();
	}

	wait 2;
	truck1 = getent("truck1","targetname");
	level thread truck_call_anim("truck1_rider", truck1, "coming_back", random, "tag_guy05");
//	level thread event1_truck_rider_shout("coming_back");

	wait 8;
	level thread truck_call_anim("vassili", truck1, "vass_lastman", random, "tag_guy02");
//	level thread event1_truck_rider_shout("vass_lastman", level.vassili);	
}

event1_blow_train()
{
	level notify("blow_train");
	all = getentarray("train","targetname");
	all[all.size] = getent("player_traincar","targetname");

	all = maps\_utility_gmi::array_randomize(all);
	for(i=0;i<all.size;i++)
	{
		if(isdefined(all[i].script_noteworthy))
		{
			if(all[i].script_noteworthy == "cars" || all[i].script_noteworthy == "engine")
			{
				all[i] thread event1_toss_train_car();
			}
			wait 0.1;
		}
	}
}

event1_toss_train_car()
{
//	fx = loadfx( "fx/explosions/vehicles/t34_complete.efx" );
//	playfx( fx, self.origin);

	angles = ((10 - randomfloat(20)),(90 - randomfloat(90)),(70 - randomfloat(140)));
	self movegravity(((0 - randomfloat(100)),(100 - randomfloat(100)),500),1.25);
	self rotateto(angles, 2, 0.5, 0.5);
}

fake_plane_fire()
{
	self endon("stop mg42s");
	lnext = 0;
	rnext = 0;

	while (1)
	{
		ang = anglesToForward (self.angles + (0,0,-45));
		ang = maps\_utility_gmi::vectorScale(ang, 5000);

		lnext--;
		if (lnext <= 0)
		{
			lnext = randomint (5);

			playfxOnTag ( level.mg42_effect, self, "tag_gunLeft" );
			playfxOnTag ( level.mg42_effect2, self, "tag_gunLeft" );

			org = self gettagorigin("tag_gunLeft");
			bulletTracer(org, org + ang);
		}

		rnext--;
		if (rnext <= 0)
		{
			rnext = randomint (5);

			playfxOnTag ( level.mg42_effect, self, "tag_gunRight" );
			playfxOnTag ( level.mg42_effect2, self, "tag_gunRight" );
//			self playsound ("airplane_guns");

			org = self gettagorigin("tag_gunRight");
			bulletTracer(org, org + ang);
		}

		wait (0.05);
	}
}

drive_timer(truck1)
{
	time = 0;
	while(!truck1.unload)
	{
		println("Time of Drive: ",time);
		wait 1;
		time++;
	}
}

#using_animtree("trenches_dummies_path");
event3_dummies_1()
{
	anim_wait = [];
	anim_wait[0] = 30;
	level thread maps\trenches_dummies::dummies_setup((-6818, -5933, 216), "xmodel/trenches_dummies_wood2houseA", 2, (0,0,0), "random", 15, %trenches_dummies_wood2houseA, true, "event2_dummies", anim_wait, true);

	wait 10;
	anim_wait[0] = 15;
	level thread maps\trenches_dummies::dummies_setup((-5969, -6368, 216), "xmodel/trenches_dummies_backhouseA", 2, (0,0,0), "random", 9, %trenches_dummies_backhouseA, false, "event2_dummies", anim_wait, true);
}

event3_village_dummies()
{
	trigger = getent("event3_village_dummies","targetname");
	trigger waittill("trigger");
	trigger delete();

	anim_wait = [];
	anim_wait[0] = 40;

	level thread maps\trenches_dummies::dummies_setup((-16697, -2698, -41), "xmodel/trenches_dummies_house2trainA", 10, (0,0,0), undefined, undefined, %trenches_dummies_house2trainA, true, "event1_dummies2", anim_wait_2, true);
	level thread maps\trenches_dummies::dummies_setup((-8568, -208, 312), "xmodel/trenches_dummies_villageA", 32, (0,180,0), undefined, undefined, %trenches_dummies_villageA, true, "event3_village_dummies", anim_wait, true);
}

event3_prisoner_dummies()
{
//	trigger = getent("event3_prisoner_dummies","targetname");
//	trigger waittill("trigger");
//	trigger delete();

	anim_wait = [];
	anim_wait[0] = 40;

	level thread maps\trenches_dummies::dummies_setup((-10064.5, -6703.5, -16), "xmodel/trenches_dummies_prisonerA", 7, (0,180,0), undefined, undefined, %trenches_dummies_prisonerA, true, "event3_prisoner_dummies", anim_wait, false);
}

#using_animtree("generic_human");
event3_stuka_dive()
{
	for(i=1;i<4;i++)
	{
		println("^2Stuka",i," Spawned");
		path = getvehiclenode("stuka_divepath_" + i,"targetname");

		stuka = spawnvehicle("xmodel/vehicle_plane_stuka",("dive_stuka_" + i),"Stuka",path.origin,path.angles);
		stuka.health = 10000;		
		stuka maps\_stuka_gmi::init(4);
		stuka notify("wheelsup");
		stuka notify("takeoff");

		if(i == 2)
		{
			stuka thread event3_drop_bomb(path);
		}
		else
		{
			stuka attachPath(path);
			stuka startpath();
			stuka thread event3_drop_bomb();
		}

		if(i != 1)
		{
			wait (0.5 + randomfloat(0.25));
		}
				
		random_num = randomint(2);
		if(random_num == 0)
		{
			wait 2;
			stuka  playsound("trenches_flyover01");
		}
		else
		{
			wait 2;
			stuka  playsound("trenches_flyover01");
		}
	}
}

event3_drop_bomb(path)
{
	println(self.targetname);
	if(self.targetname == "dive_stuka_2")
	{
		println("Path ",path.targetname);
		wait 5.3;
		self attachPath(path);
		self startpath();
		self playsound("bf109_attack01");
		wait 4;
		random_num = randomint(2);
		if(random_num == 0)
		{
			self playsound("stuka_flyby_01");
		}
		else
		{
			self playsound("stuka_flyby_03");
		}
		wait 0.7;
		self thread maps\_stuka_gmi::drop_bombs(1, undefined, 1, 200, 1000, 500);
		wait 2;
		self thread maps\_stuka_gmi::drop_bombs(undefined,undefined, 1, 128, 700, 0);
	}
	else
	{
		wait 6.5;
		random_num = randomint(2);
		if(random_num == 0)
		{
			self playsound("stuka_flyby_01");
		}
		else
		{
			self playsound("stuka_flyby_03");
		}
		wait 0.5;
		if(self.targetname == "dive_stuka_1")
		{

			self thread maps\_stuka_gmi::drop_bombs(undefined, undefined, 1, 0);
		}
		else
		{
			self thread maps\_stuka_gmi::drop_bombs(undefined, undefined, 1, 384);
		}
	}
}

event3_tanks_1()
{
	trigger = getent("event3_tanks","targetname");
	trigger waittill("trigger");

	paths = getvehiclenodearray("event3_tank_path","targetname");

	for(i=0;i<paths.size;i++)
	{
		tank = spawnvehicle("xmodel/v_rs_lnd_t34",("event3_tank_" + i),"T34",paths[i].origin,paths[i].angles);
		tank.health = 500;
		tank maps\_t34_gmi::init();
		if(isdefined(paths[i].script_noteworthy))
		{
//			println("^3TANK GETS SCRIPT_NOTEWORTHY");
			tank.script_noteworthy = paths[i].script_noteworthy;
		}
//		paths[i] debug_ent(true);
//		tank debug_ent(true);
		tank thread event3_tanks_1_think(paths[i]);
	}
}

event3_tanks_1_think(path)
{
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "no_wait")
	{
//		println("^3TANK NO WAIT");
		wait 3;
	}
	else
	{
		wait 5 + randomfloat(10);
	}
	self attachpath(path);
	self startpath();

	self waittill("reached_end_node");
	if(isdefined(self.mgturret))
	{
		self.mgturret delete();
	}
	self delete();
}

#using_animtree("trenches_dummies_path");
event4_wounded_dummies()
{
	trigger = getent("event4_wounded_b","targetname");
	trigger waittill("trigger");
	anim_wait = [];
	anim_wait[0] = 30;
//	level thread maps\trenches_dummies::dummies_setup((-1926, 8252, -34), "xmodel/trenches_dummies_woundedB", 48, (0,0,0), undefined, undefined, %trenches_dummies_woundedB, false, "event4_wounded", anim_wait, false);

	level thread maps\trenches_dummies::dummies_setup((-6532, 433, 142), "xmodel/trenches_dummies_villagetreeline", 15, (0,0,0), undefined, undefined, %trenches_dummies_villagetreeline, false, "event1_dummies2", anim_wait, false);

	trigger = getent("event4_wounded_a","targetname");
	trigger waittill("trigger");
	anim_wait[0] = 30;
	level thread maps\trenches_dummies::dummies_setup((-1926, 8252, -34), "xmodel/trenches_dummies_woundedA", 48, (0,0,0), undefined, undefined, %trenches_dummies_woundedA, false, "event4_wounded", anim_wait, false);

	level thread maps\trenches_dummies::dummies_setup((-1926, 8252, -34), "xmodel/trenches_dummies_roadcrossA", 25, (0,0,0), undefined, undefined, %trenches_dummies_roadcrossA, true, "event1_dummies2", anim_wait, false);
}

#using_animtree("generic_human");
event4_village_tanks()
{
	vill_tank_paths = getvehiclenodearray("event3_vill_tank_path","targetname");
	for(i=0;i<vill_tank_paths.size;i++)
	{
		tank = spawnvehicle("xmodel/v_rs_lnd_t34",("event3_vill_tank_" + i),"T34",vill_tank_paths[i].origin,vill_tank_paths[i].angles);
		tank.health = 500;
		tank maps\_t34_gmi::init("no_turret");
		tank.groupname = "village_tanks";

		tank attachpath(vill_tank_paths[i]);
		tank startpath();

		if(isdefined(vill_tank_paths[i].script_noteworthy) && vill_tank_paths[i].script_noteworthy == "leader")
		{
			tank thread event4_tank_think();
		}
	}
}

event4_tank_think()
{
//println("^3Tank thinking!");
	self setwaitnode(getvehiclenode("auto4002","targetname"));
	self waittill("reached_wait_node");
//println("^3Tank reached node!");

	level thread event4_stuka_dialog();

	paths = getvehiclenodearray("event4_vill_stuka_bomb_path","targetname");
	for(i=0;i<paths.size;i++)
	{
//		println("^3In FOR loop");
		stuka = spawnvehicle("xmodel/vehicle_plane_stuka",("event4_vill_stuka"),"Stuka",paths[i].origin,paths[i].angles);
		if(isdefined(paths[i].script_noteworthy) && paths[i].script_noteworthy == "event4_truck_strafe")
		{
			stuka.event4_truck_strafe = true;
		}
		stuka.health = 1000;
		stuka maps\_stuka_gmi::init(4);

		stuka notify("wheelsup");
		stuka notify("takeoff");

		stuka.attachedpath = paths[i];
		stuka attachPath(paths[i]);
		stuka startpath();
		level thread stuka_bombing_think(stuka, 1, 257, 1000, 0);
	}
}

event4_stuka_dialog()
{
	wait 3;
	truck1 = getent("truck1","targetname");
	level thread truck_call_anim("truck1_rider", truck1, "stukas_head_down", random, "tag_guy08");
	
	/*friends = getentarray("friends","groupname");
	for(i=0;i<level.friends.size;i++)
	{
		truck = getent("truck1","targetname");
		wait (randomfloat (0.2));
		friends[i] thread event6_truckflinch(truck);
	}

	truckriders = getentarray("truck1" + "_rider","targetname");
	// Animate ducking
	for(i=0;i<truckriders.size;i++)
	{
		truck = getent("truck1","targetname");
		if(truckriders[i].exittag == "tag_driver")
		{
			continue;
		}
		truckriders[i].animname = "truckriders";
		wait (randomfloat (0.2));
		truckriders[i] thread event6_truckflinch(truck);
	}
	
	truck2_riders = getentarray("truck2" + "_rider","targetname");
	// Animate ducking
	for(i=0;i<truck2_riders.size;i++)
	{
		truck2_riders[i].dropweapon = false;
		truck = getent("truck2","targetname");
		if(truck2_riders[i].exittag == "tag_driver")
		{
			continue;
		}
		truck2_riders[i].animname = "truckriders";
		wait (randomfloat (0.2));
		truck2_riders[i] thread event6_truckflinch(truck);
	}
	
//	level.stuka_shouter thread anim_single_solo(level.stuka_shouter,"stukas_head_down");
	wait 6;
//	println("^6Vassili: Stay low, they'll pick your head off like a melon");
	level thread truck_call_anim("vassili", truck1, "vass_ev03_01", random, "tag_guy02");
//	level.vassili thread anim_single_solo(level.vassili,"vass_ev03_01");

	friends = getentarray("friends","groupname");
	for(i=0;i<friends.size;i++)
	{
		truck = getent("truck1","targetname");
		wait (randomfloat (0.2));
		friends[i] notify("stop anim"); // Stops the "truck bobbing"
		friends[i] notify("stop flinching");
		
		friends[i] thread maps\_anim_gmi::anim_loop_solo(friends[i], ("idle" + friends[i].climb_tag), friends[i].exittag, "stop anim", undefined, truck);
	}

	truckriders = getentarray("truck1" + "_rider","targetname");
	// Animate ducking
	for(i=0;i<truckriders.size;i++)
	{
		truck = getent("truck1","targetname");
		if(truckriders[i].exittag == "tag_driver")
		{
			continue;
		}
		truckriders[i].animname = "truckriders";
		wait (randomfloat (0.2));
		truckriders[i] notify("stop anim"); // Stops the "truck bobbing"
		truckriders[i] notify("stop flinching");
		
		truckriders[i] thread maps\_anim_gmi::anim_loop_solo(truckriders[i], ("idle" + truckriders[i].climb_tag), truckriders[i].exittag, "stop anim", undefined, truck);
	}

	truck2_riders = getentarray("truck2" + "_rider","targetname");
	// Animate ducking
	for(i=0;i<truck2_riders.size;i++)
	{
		truck2_riders[i].dropweapon = false;
		truck = getent("truck2","targetname");
		if(truck2_riders[i].exittag == "tag_driver")
		{
			continue;
		}
		truck2_riders[i].animname = "truckriders";
		wait (randomfloat (0.2));
		truck2_riders[i] notify("stop anim"); // Stops the "truck bobbing"
		truck2_riders[i] notify("stop flinching");
		truck2_riders[i] thread maps\_anim_gmi::anim_loop_solo(truck2_riders[i], ("idle" + truck2_riders[i].climb_tag), truck2_riders[i].exittag, "stop anim", undefined, truck);
	}*/
	
	wait 8;
	println("^6BORIS: How much farther do we have to go.");
//	level.boris thread anim_single_solo(level.boris,"boris_howfar");
	wait 3;	

	println("^6vassili: Till we get there.");
//	level thread truck_call_anim("vassili", truck1, "vass_tillwe_getthere", random, "tag_guy02");
//	level.vassili thread anim_single_solo(level.vassili,"vass_tillwe_getthere");
}

event4_truck1_strafe()
{
	// Stuka Strafe, killing 1 guy, and possibly injuring the player.
	truck1_riders = getentarray("truck1_rider","targetname");
	for(i=0;i<truck1_riders.size;i++)
	{
		if(truck1_riders[i].exittag == "tag_guy06")
		{
			level thread event4_shoot_truck1_rider(truck1_riders[i]);
			level thread event4_shoot_player(self);
		}
		else
		{
			truck1_riders[i].flinch = true;
			truck1_riders[i] notify("truck flinch");
		}
	}
}

event4_shoot_player(stuka)
{
	wait 1;
	for(i=0;i<15;i++)
	{
		if (level.player getstance() == "stand")
		{
			// Piece of cacapoopoochips.
			if(getcvar("username") == "robb")
			{
				level.player DoDamage ( 30, (stuka.origin) );
			}
			else
			{
				level.player DoDamage ( 10, (stuka.origin) );
			}
		}
		wait randomfloat(0.1);
	}
}

event4_shoot_truck1_rider(truckguy)
{
	truckguy.flinch = false;
	wait 0.5;
	println("^3I AM GOING TO DIE!!!");
	for(q=0;q<4;q++)
	{
		truckguy thread event9_bloody_death();
		if(q == 3)
		{
			truckguy DoDamage ( truckguy.health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
		}
		else
		{
			truckguy DoDamage ( 30, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
		}
		wait 0.25;
	}
}

event5_coming_trucks()
{
	trigger = getent("event5_coming_trucks","targetname");
	trigger waittill("trigger");
//	level thread event1_truck_rider_shout("hang_on");
	level thread event6();

	tank_paths = getvehiclenodearray("event5_tank_path1","targetname");
	for(i=0;i<tank_paths.size;i++)
	{
		tank = spawnvehicle("xmodel/v_rs_lnd_t34",("event5_tank"),"T34",tank_paths[i].origin,tank_paths[i].angles);
		tank.health = 500;
		tank maps\_t34_gmi::init();

		tank attachpath(tank_paths[i]);
		tank startpath();
		tank thread event5_death_think();
	}	

	paths = getvehiclenodearray("event5_truck_path1","targetname");
	driver_spawner = getentarray("event5_truck_driver","targetname");

	println("^DRIVER SPAWNERS ",driver_spawner.size);
	println("^2TRUCK PATHS ",paths.size);

	vehicle_group = 7;

	for(i=0;i<paths.size;i++)
	{
		truck = spawnvehicle("xmodel/v_rs_lnd_gazaaa",("coming_truck"),"RussianGazaaa",paths[i].origin,paths[i].angles);
		truck.health = 500;
		truck maps\_truck_gmi::init();
		truck.script_vehiclegroup = vehicle_group;
		vehicle_group++;

		if(isdefined(truck))
		{
			println("^2TRUCK SPAWNED IN!!!");
		}

		truck thread maps\_truck_gmi::attach_guys(true);

//		driver[0] = driver_spawner[i] dospawn();

//		truck thread maps\_truck_gmi::handle_attached_guys(driver);

		truck attachpath(paths[i]);
		truck startpath();
		truck thread event5_death_think(true);
	}
}

event5_death_think(driver)
{
	self waittill("reached_end_node");
	if(isdefined(self.mgturret))
	{
		self.mgturret delete();
	}
	if(isdefined(driver))
	{
		self.driver delete();
	}
	self delete();
}

event6()
{
	setculldist(15000); // Reset cull distance

	for(i=1;i<7;i++)
	{
		truck[i] = getent("truck" + i,"targetname");
		if(!isdefined(truck[i]) || truck[i].health <= 0)
		{
			continue;
		}
		truck[i].unload = false;
		truck[i] makeVehicleUnusable();
		truck[i].health = 500;

		if(!isdefined(truck[i]) && truck[i].health > 0)
		{
			continue;
		}

		// If Truck4, do not unload. Instead, do the mortar hit.
		if(truck[i].targetname == "truck4")
		{
			truck[i].health = 500; // Reset so it will blow up.
			truck[i] thread event6_truck4_mortar();
			continue;
		}
		truck[i] thread event6_unload_truck();
	}

	trigger = getent("event6_incoming","targetname");
	trigger waittill("trigger");

	village_tanks = getentarray("village_tanks","groupname");
	for(i=0;i<village_tanks.size;i++)
	{
		if(isdefined(village_tanks[i].mgturret))
		{
			village_tanks[i].mgturret delete();
		}

		stopattachedfx(village_tanks[i]);
		wait 0.1;
		village_tanks[i] delete();
	}

	level thread event6_fly_by();
	level thread event6_blow_trucks();

	event6_mortar = getent("event6_mortar","targetname");
	println("^2PLAYING SHELL INCOMING!!!");
	println("^2PLAYING SHELL INCOMING!!!");
	println("^2PLAYING SHELL INCOMING!!!");
	event6_mortar playsound ("mortar_incoming3");
	event6_mortar.sound_delay = 0.5; // Sound delay.
	event6_mortar thread instant_mortar(0);
	level notify("first mortar hit");
	level thread event6_artillery_warning();

	// Stops certain fx near village.
	level notify("stop fx village");

	friends = getentarray("friends","groupname");
	for(i=0;i<friends.size;i++)
	{
		truck = getent("truck1","targetname");
		wait (randomfloat (0.2));
		friends[i] thread event6_truckflinch(truck);
	}

	truckriders = getentarray("truck1" + "_rider","targetname");
	// Animate ducking
	for(i=0;i<truckriders.size;i++)
	{
		truck = getent("truck1","targetname");
		if(truckriders[i].exittag == "tag_driver")
		{
			continue;
		}
		truckriders[i].animname = "truckriders";
		wait (randomfloat (0.2));
		truckriders[i] thread event6_truckflinch(truck);
	}
	truck2_riders = getentarray("truck2" + "_rider","targetname");
	// Animate ducking
	for(i=0;i<truck2_riders.size;i++)
	{
		truck2_riders[i].dropweapon = false;
		truck = getent("truck2","targetname");
		if(truck2_riders[i].exittag == "tag_driver")
		{
			continue;
		}
		truck2_riders[i].animname = "truckriders";
		wait (randomfloat (0.2));
		truck2_riders[i] thread event6_truckflinch(truck);
	}

	lineofficers = getentarray("lineofficer","targetname");
	for(i=0;i<lineofficers.size;i++)
	{
		lineofficers[i] thread event7_bunker_commissar();
	}

	wait 3;
	println("^6BORIS: NOT GOING TO MAKE THIS");
	truck1 = getent("truck1","targetname");
	level.boris = getent("boris","targetname");
//	level thread truck_call_anim("boris", getent("truck1","targetname"), "not_going_to_make_this", random, "tag_guy01");
//	level.boris thread anim_single_solo(level.boris, "not_going_to_make_this");

	wait 1.5;
	level.miesha.animname = "miesha";
//	level thread truck_call_anim("miesha", getent("truck1","targetname"), "pull_yourself_together", random, "tag_guy03");
//	level.miesha thread anim_single_solo(level.miesha, "pull_yourself_together");
	wait 5;
	level.stuka_shouter thread anim_single_solo(level.stuka_shouter,"look_out");
	wait 5;
	//level.stuka_shouter thread anim_single_solo(level.stuka_shouter,"get_down");
}

event6_artillery_warning()
{
//	trigger = getent("event6","targetname");
//	trigger waittill("trigger");

	org = getent("initial_distant_light","targetname");
	org thread random_distant_light_think(undefined, 1, 3);

	wait 0.25;
	println("^6Miesha: Artillery, Get down! ",level.miesha.animname);
	miesha = getent("miesha","targetname");
//	miesha thread anim_single_solo(miesha,"artillery");
	miesha anim_single_solo(miesha,"artillery");

	wait 0.5;
	level.stuka_shouter thread anim_single_solo(level.stuka_shouter,"hang_on");
}

event6_quick()
{
	level.mortar_mindist = 128;
	level.mortar_maxdist = 1500;
	level.mortar_random_delay = 25;
	level notify("first mortar hit");

	level.miesha.animname = level.miesha.original_animname;
	level.vassili.animname = level.vassili.original_animname;
	level.boris.animname = level.boris.original_animname;

	player_traincar = getent("player_traincar","targetname");
	player_traincar delete();
	train_clip = getent("player_traincar_clip","targetname");
	train_clip delete();

	truck_commissars = getentarray("start_truck_commissars","groupname");
	train_commissars = getentarray("start_train_commissars","groupname");
	all = add_array_to_array(truck_commissars,train_commissars);

	train_riders = getentarray("train_rider","targetname");
	all = add_array_to_array(all,train_riders);

	train = getentarray("train","targetname");
	all = add_array_to_array(all,train);

	truck5_riders = getentarray("truck5_rider","targetname");
	all = add_array_to_array(all,truck5_riders);

	truck6_riders = getentarray("truck6_rider","targetname");
	all = add_array_to_array(all,truck6_riders);

	truck_drivers = getentarray("truck_driver","groupname");
//	all = add_array_to_array(all,truck_drivers);

	println("ALL SIZE ",all.size);
	for(i=0;i<all.size;i++)
	{
		println("Delete: ",all[i].targetname);
		all[i] delete();
	}

//////////////
	setculldist(15000); // Reset cull distance

	for(i=1;i<7;i++)
	{
		truck[i] = getent("truck" + i,"targetname");
	}

	level thread event6_fly_by();
	level thread event6_blow_trucks();

	// Stops certain fx near village.
	level notify("stop fx village");

	lineofficers = getentarray("lineofficer","targetname");
	for(i=0;i<lineofficers.size;i++)
	{
		lineofficers[i] thread event7_bunker_commissar();
	}
///////////////
	truck1_pos = (-368, 2032, 0);
	truck2_pos = (-384, 1856, 0);

	pos = (-520,2256,40);

	truck1_riders = getentarray("truck1_rider","targetname");
	truck2_riders = getentarray("truck2_rider","targetname");

	level.player setorigin((-251,402,-40));
	wait 0.25;
	for(i=0;i<truck1_riders.size;i++)
	{
		truck1_riders[i].flinch = false;
		truck1_riders[i] teleport(truck1_pos - ((48*i),0,24));
	}
	for(i=0;i<truck2_riders.size;i++)
	{
		truck2_riders[i].flinch = false;
		truck2_riders[i] teleport(truck2_pos - ((48*i),0,24));
	}
	level.vassili teleport(truck1_pos + (0,48,0));
	level.boris teleport(truck1_pos + (-32,48,0));
	level.miesha teleport(truck1_pos + (-64,48,0));

	for(i=0;i<truck1_riders.size;i++)
	{
		if(truck1_riders[i].exittag == "tag_guy06")
		{
			truck1_riders[i] DoDamage ( truck1_riders[i].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
		}
	}

	wait 1;
	level.player setorigin(pos);
/////////////

	truck1_riders = getentarray("truck1_rider", "targetname");
	for(i=0;i<truck1_riders.size;i++)
	{
		if(i == 2 || i == 4 || i == 6 || i == 8)
		{
			truck1_riders[i] thread event6_unload_sound();
		}
		truck1_riders[i].node_num = (i + 1);
		truck1_riders[i] thread event7_get_to_bunker();
	}

	wait 1.0;
	level.vassili.animname = "vassili";
	level.vassili thread anim_single_solo(level.vassili,"get_your_weapon");
	level.vassili thread event7_get_to_bunker(getnode("vassili_right_line_node1","targetname"));

	level.boris.animname = "boris";
	level.boris thread event7_get_to_bunker(getnode("boris_right_line_node1","targetname"));

	level.miesha.animname = "miesha";
	level.miesha thread event7_get_to_bunker(getnode("miesha_right_line_node1","targetname"));
//		wait 2;

	maps\_utility_gmi::autosave(1);

	level.player unlink(); // Unlink the player
	level notify("unload truck1");
	level.player allowLeanLeft(true); // Enable lean left.
	level.player allowLeanRight(true); // Enable lean right.
	level.player allowProne(true); // Enable prone
	level.mortar_mindist = 128;
	level.mortar_maxdist = 1500;
	level.mortar_random_delay = 25;

	level thread event6_trench_mortar();
	level thread event7();

	truck2_riders = getentarray("truck2_rider","targetname");
	nodes = getnodearray("truck2_rider_bunker1_spot","targetname");
	wait 4;
	for(i=0;i<truck2_riders.size;i++)
	{
		truck2_riders[i] setgoalnode(nodes[i]);
		truck2_riders[i].og_goalradius = self.goalradius;
		truck2_riders[i].goalradius = 0;

		if(isdefined(nodes[i].script_noteworthy) && nodes[i].script_noteworthy == "wall")
		{
			truck2_riders[i] thread event7_bunker_anim(nodes[i], "wall");
		}
		else
		{
			truck2_riders[i] thread event7_bunker_anim(nodes[i]);
		}
	}
}

event6_fly_by()
{
	wait 13;
	path = getvehiclenode("stuka_flyby","targetname");
	plane = spawnvehicle("xmodel/v_rs_air_il2","plane","stuka",path.origin,path.angles);
	plane.health = 100000000;
	plane maps\_stuka_gmi::init();
	plane notify("wheelsup");
	plane notify("takeoff");
	
	plane attachPath(path);
	plane startpath();
	wait 3;
	plane playsound("trenches_flyover01");
}

event6_truckflinch(truck)
{
	self notify("stop anim"); // Stops the "truck bobbing"
	self notify("stop flinching");
	self.flinch = false;
	random_num = randomint(2);
	self.crouch_flinch = true;
	if(random_num == 0)
	{
		self thread anim_single_solo(self, "stand2flinch", undefined, undefined, undefined);
		delay = getanimlength(%flinchA_stand2flinch);
		wait (delay - 0.2);
		self thread anim_loop_solo(self, "flinchloop", undefined, "stop anim", undefined, undefined);
	}
	else
	{
		self thread anim_single_solo(self, "stand2flinch_B", undefined, undefined, undefined);
		delay = getanimlength(%flinchB_stand2flinch);
		wait (delay - 0.2);
		self thread anim_loop_solo(self, "flinchloop_B", undefined, "stop anim", undefined, undefined);
	}
}

event6_trench_mortar()
{
	truckriders = getentarray("truck2_rider","targetname");
	wait 5;
	num = 3;
//println("^5 NUM ",num);
//	mortar = spawn("script_origin", (truckriders[num].origin));
	
	for(q=0;q<truckriders.size;q++)
	{
		if(truckriders[q].exittag == "tag_guy01")
		{
			mortar = spawn("script_origin", (truckriders[q].origin));
		}
	}
	
	for(q=0;q<truckriders.size;q++)
	{	
		if(distance(mortar.origin, truckriders[q].origin) < 1024)
		{
			if(isalive(truckriders[q]))
			{
				old_health = truckriders[q].health;
				truckriders[q].health = (5);
			}
		}
	}
	mortar.sound_delay = (randomfloat(1));
	mortar instant_mortar(512);
}

// Unload each truck.
event6_unload_truck()
{
	wait 2;
//	println(self.targetname," ",self.speed);
	self waittill("reached_end_node");
	self disconnectpaths();
	self notify("unload"); // _truck.gsc uses for this.

	self.unload = true; // To stop looking at player.
	println(self.targetname," ",self.origin);
	println(self.targetname," ",self.angles);

	// Special condition for when the player's truck reaches the end.
	if(self.targetname == "truck1")
	{
		truck1_riders = getentarray("truck1_rider", "targetname");
		for(i=0;i<truck1_riders.size;i++)
		{
			if(i == 2 || i == 4 || i == 6 || i == 8)
			{
				truck1_riders[i] thread event6_unload_sound();
			}
			truck1_riders[i].node_num = (i + 1);
			truck1_riders[i] thread event7_get_to_bunker();
		}

		wait 1.0;

		level.vassili.animname = "vassili";
		level.vassili thread anim_single_solo(level.vassili,"get_your_weapon");
		level.vassili thread event7_get_to_bunker(getnode("vassili_right_line_node1","targetname"));
	
		level.boris.animname = "boris";
		level.boris thread event7_get_to_bunker(getnode("boris_right_line_node1","targetname"));
	
		level.miesha.animname = "miesha";
		level.miesha thread event7_get_to_bunker(getnode("miesha_right_line_node1","targetname"));
//		wait 2;

		maps\_utility_gmi::autosave(1);

		level.player unlink(); // Unlink the player
		level notify("unload truck1");
		level.player allowLeanLeft(true); // Enable lean left.
		level.player allowLeanRight(true); // Enable lean right.
		level.player allowProne(true); // Enable prone
		level.mortar_mindist = 128;
		level.mortar_maxdist = 1500;
		level.mortar_random_delay = 25;

		wait 1;
		if(!self.beddoor_open)
		{
//			self thread maps\_truck_gmi::toggle_beddoor();
		}
	}

	if(self.targetname == "truck2")
	{
		truck2_riders = getentarray("truck2_rider","targetname");
		nodes = getnodearray("truck2_rider_bunker1_spot","targetname");
		num = 0;
		for(i=0;i<truck2_riders.size;i++)
		{
			if(!isai(truck2_riders[i]) || !isalive(truck2_riders[i]))
			{
				continue;
			}

			truck2_riders[i] setgoalnode(nodes[num]);
			truck2_riders[i].og_goalradius = truck2_riders[i].goalradius;
			truck2_riders[i].goalradius = 0;

			if(isdefined(nodes[num].script_noteworthy) && nodes[num].script_noteworthy == "wall")
			{
				truck2_riders[i] thread event7_bunker_anim(nodes[num], "wall");
			}
			else
			{
				truck2_riders[i] thread event7_bunker_anim(nodes[num]);
			}
			num++;
		}
		level thread event6_trench_mortar();
		level thread event7();
	}
}

event6_unload_dialogue()
{
	level.vassili.animname = "vassili";
	println("^6Vassili: MOve it, Move! Off the truck");
	level.vassili anim_single_solo(level.vassili,"vass_offtruck");
	println("^6Vassili: Get your weapon");
	level.vassili anim_single_solo(level.vassili,"get_your_weapon");
}

event6_unload_sound()
{
	wait (randomfloat(2));
	self playsound("foley_scramble");
	wait (randomfloat(2));
	self playsound("foley_land");
}

event6_commissar_bullhorn_loop()
{
	self thread anim_loop_solo(self, "idle", undefined, "stop anim", node);
	level waittill("unload truck1");
	wait 4;
	self endon("death");
//	guy[0] = self;
	while (!level.event7["triggered"])
	{
//		guy[0] notify("stop anim");
//		anim_single (guy, "fullbody43", undefined, node);
//		guy[0] thread anim_loop(guy, "idle", undefined, "stop anim", node);
//		wait (randomfloat(2));
//		guy[0] notify ("stop anim");
//		anim_single (guy, "fullbody44", undefined, node);
//		guy[0] thread anim_loop(guy, "idle", undefined, "stop anim", node);
//		wait (randomfloat(1) + 0.5);
//		guy[0] notify ("stop anim");

		self notify("stop anim");
		println("^6megaphone_talk1");

		level.scr_notetrack["bullhorn_commissar"][0]["notetrack"]		= "comm_ev06_01";
		level.scr_notetrack["bullhorn_commissar"][0]["dialogue"] 		= "comm_ev06_01";
		level.scr_notetrack["bullhorn_commissar"][0]["facial"]			= level.scr_face_hack["bullhorn_commissar"]["megaphone_talk1"];

		self anim_single_solo(self, "megaphone_talk1",undefined,node);
		self thread anim_loop_solo(self, "idle", undefined, "stop anim", node);
		wait (1 + (randomfloat(2)));

		if(level.event7["triggered"])
		{
			break;
		}

		self notify("stop anim");
		println("^6megaphone_talk2");

		level.scr_notetrack["bullhorn_commissar"][0]["notetrack"]		= "comm_ev06_02";
		level.scr_notetrack["bullhorn_commissar"][0]["dialogue"] 		= "comm_ev06_02";
		level.scr_notetrack["bullhorn_commissar"][0]["facial"]			= level.scr_face_hack["bullhorn_commissar"]["megaphone_talk2"];

		self anim_single_solo(self, "megaphone_talk2",undefined,node);
		self thread anim_loop_solo(self, "idle", undefined, "stop anim", node);
		wait (1 + (randomfloat(2)));

		if(level.event7["triggered"])
		{
			break;
		}

		self notify("stop anim");
		println("^6megaphone_talk3");

		level.scr_notetrack["bullhorn_commissar"][0]["notetrack"]		= "comm_ev06_03";
		level.scr_notetrack["bullhorn_commissar"][0]["dialogue"] 		= "comm_ev06_03";
		level.scr_notetrack["bullhorn_commissar"][0]["facial"]			= level.scr_face_hack["bullhorn_commissar"]["megaphone_talk3"];

		self anim_single_solo(self, "megaphone_talk3",undefined,node);
		self thread anim_loop_solo(self, "idle", undefined, "stop anim", node);
		wait (1 + (randomfloat(2)));

		if(level.event7["triggered"])
		{
			break;
		}

		self notify("stop anim");
		println("^6megaphone_talk4");
	
		level.scr_notetrack["bullhorn_commissar"][0]["notetrack"]		= "comm_ev06_04";
		level.scr_notetrack["bullhorn_commissar"][0]["dialogue"] 		= "comm_ev06_04";
		level.scr_notetrack["bullhorn_commissar"][0]["facial"]			= level.scr_face_hack["bullhorn_commissar"]["megaphone_talk4"];

		self anim_single_solo(self, "megaphone_talk4",undefined,node);
		self thread anim_loop_solo(self, "idle", undefined, "stop anim", node);
		wait (1 + (randomfloat(2)));

		if(level.event7["triggered"])
		{
			break;
		}

	}
	self notify("stop anim");
	self thread anim_loop_solo(self, "idle", undefined, "stop anim", node);
}

// Blow up the 2 remaing trucks when the trigger is touched.
event6_blow_trucks()
{
	trigger = getent("event6_blow_trucks","targetname");
	trigger waittill("trigger");
	level notify("stop event1 distant lights");

	for(i=1;i<3;i++)
	{
		truck = getent("truck" + i,"targetname");
		mortar = getent("truck" + i + "_mortar","targetname");
		wait (1 + randomfloat (2));
		if(truck.health > 0)
		{
			truck.health = 1;
			mortar thread instant_mortar();		
		}
	}

	trigger delete();
}

// Have AI constantly look at player while riding on truck, until truck is unloading.
event6_look_at_player(truck)
{
	if(self.exittag == "tag_driver")
	{
		return;
	}

	while(truck.unload == false)
	{
		self.player_angles = vectorToAngles(level.player.origin - self.origin);

		num = (1 + randomint(3));

		if(num == 1)
		{
			the_anim = %stand_alert_1;
		}

		if(num == 2)
		{
			the_anim = %stand_alert_2;
		}

		if(num == 3)
		{
			the_anim = %stand_alert_3;
		}

		self animscripted("animdone", self.origin, self.player_angles, the_anim);
		self waittillmatch ("animdone", "end");
	}
}

// Used for when truck4 reaches it's "EXPLODE NODE"
event6_truck4_mortar()
{
	self setwaitnode(getvehiclenode("auto2076","targetname")); // MERGE NOTE, check here when merging.
	self waittill("reached_wait_node");
	self.health = 1;
	println("^3Reached NODE, EXPLODE!");

	// Activate truck4 mortars.
	truck4_mortar = getentarray ("truck4_mortar","targetname");
	for(i=0;i<truck4_mortar.size;i++)
	{
		if(i==0)
		{
			println("^6SCREEEEEEEEEEEEEEEEEEEEEEEAAAAAAAAAAAAAAAAAAAAAAAAAAAM!");
	        	truck4_mortar[i] playsound("mass_scream");
		}
		truck4_mortar[i] instant_mortar(64);
	}

	self waittill("reached_end_node");
	println("Truck4",self.origin);
	println("Truck4",self.angles);
	self disconnectpaths();
	block_trench_entrance = getent("block_trench_entrance","targetname");
	block_trench_entrance solid();

//	wait 0.5;
//	level.miesha thread anim_single_solo(level.miesha,"blew_up_last_truck");
}

event7()
{
	// FOR E3!
	if(getcvar("for_e3") == "1")
	{
		level thread maps\_e3_demo_gmi::player_move_check("e3russian", 60);
	}

	trigger = getent("event7","targetname");
	trigger waittill("trigger");
	println("^2EVENT 7 START");
	level.event7["triggered"] = true;
	level notify("leftofficer loop");
	level thread event7_ammo_pickup();

	level thread event7_radio_man();
}

event7_radio_man()
{
	radio_man = spawn ("script_model",(-315,377,3));
	org = spawn("script_origin",(0,0,0));
	org.angles = (0,270,0);
//	level thread debug_line(radio_man);

	radio_man.origin = radio_man.origin + (0,0,-9);
	radio_man.angles = radio_man.angles;
	radio_man.animname = "radio_man";
	radio_man.targetname = "bunker1_garbage";
	radio_man [[level.scr_character[radio_man.animname]]]();
	radio_man detach("xmodel/weapon_luger", "TAG_WEAPON_RIGHT");

	chair = spawn("script_model",(-288,388,-39));
	chair setmodel("xmodel/chair_utility");
	chair.angles = (0,167,0);

	radio_man UseAnimTree(level.scr_animtree[radio_man.animname]);
//	radio_man thread anim_loop_solo(radio_man, "radio_loop", undefined, "stop anim", org);
	while(1)
	{
		radio_man setFlaggedAnimKnobRestart("animdone", level.scr_anim[radio_man.animname]["radio_loop"], 1, 0.1, 1);
		radio_man waittill("animdone");
	}
}

debug_line(ent)
{
	while(1)
	{
		line(ent.origin, level.player.origin,(1,1,1));
		wait 0.06;
	}
}

event7_bunker_commissar()
{
	spawned = spawn ("script_model",(0,0,0));

	spawned.origin = self.origin + (0,0,-9);
	spawned.angles = self.angles;
	spawned.targetname = "bunker1_garbage";
	spawned.animname = self.script_noteworthy;
	spawned.groupname = "lineofficer";
	spawned.script_noteworthy = self.script_noteworthy;
	println(self.script_noteworthy, " ^3Spawned!");

	spawned UseAnimTree(level.scr_animtree[spawned.animname]);

	if (isdefined (level.scr_character[spawned.animname]))
	{
		spawned [[level.scr_character[spawned.animname]]]();
	}
	else
	{
		spawned setmodel ("xmodel/character_soviet_overcoat");
	}

	if(self.script_noteworthy == "lineofficer_left")
	{
		level waittill("leftofficer loop");
	}
	else
	{
		spawned detach("xmodel/stalingrad_clips", "TAG_WEAPON_RIGHT");
	}

	spawned thread anim_loop_solo(spawned, "idle", undefined, "stop anim");

	level waittill("player got ammo");
	spawned notify("stop anim");
}

event7_get_to_bunker(friend_node)
{
//	self thread event7_ammo_spot_debug();

	self thread event7_player_got_ammo_check(friend_node);
	level endon("player got ammo");

	if(self.targetname == "truck1_rider")
	{
		old_health = self.health;
		self.accuracy = 0.1; // Dumb down their accuracy for the trench war.
		self.health = 1000000; // So they don't die while getting to the bunker.
	}

	node = getnode("truck1_unload_node", "targetname");
	self.goalradius = 128;
	self setgoalnode (node);
	self waittill("goal");
	level.event8b_counter = 0;

	if(self.targetname == "truck1_rider")
	{
	//	self.health = old_health; // Some have over 2000 health! So f' that!
		self.health = 100; // Bring them back to the real-world.
	}

	pre_ammo_node = getnode("pre_ammo_spot","targetname");
	self setgoalnode (pre_ammo_node);
	self.goalradius = 0;
	self waittill("goal");
	self.ammo_line_num = level.ammo_line_num;
	level.ammo_line_num--;

	if(level.ammo_line_num > -3)
	{
		level.ammo_line_special = level.ammo_line_num;
	}

	self event7_get_ammo();
}

event7_give_ammo(dialog, other_ai)
{
	self endon("death");
	self notify("stop anim");

	if(isdefined(other_ai))
	{
		println("^5OTHER_AI.origin: ",other_ai.origin);
		other_ai thread anim_single_solo(other_ai, "ammo_pickup");
	}

	self anim_single_solo(self, dialog);
	level notify("event7_next_in_line");
	self thread anim_loop_solo(self, "idle", undefined, "stop anim");
}

event7_get_ammo()
{
	level endon("player got ammo");
	while(self.ammo_line_num != 0 )
	{
		node = getnode("ammo_spot" + self.ammo_line_num,"targetname");
		self setgoalnode(node);

		if(self.ammo_line_num < -2)
		{
//			self setgoalpos(node.origin);
			self.og_goalradius = self.goalradius;
			self.goalradius = 0;

			if(isdefined(node.script_noteworthy) && node.script_noteworthy == "wall")
			{
				self thread event7_bunker_anim(node, "wall");
			}
			else
			{
				self thread event7_bunker_anim(node);
			}

			return;
		}

		self waittill("move up");
		self.ammo_line_num++;
	}

	lineofficers = getentarray("lineofficer","groupname");
	for(i=0;i<lineofficers.size;i++)
	{
		if(lineofficers[i].script_noteworthy == "lineofficer_right")
		{
			lineofficer = lineofficers[i];
		}
	}

	random_num = randomint(3);

	if(isdefined(lineofficer.ammo_line))
	{
		if(random_num == lineofficer.ammo_line)
		{
			if(random_num == 2)
			{
				random_num--;
			}
			else
			{
				random_num++;
			}
		}
	}

	if(random_num == 0)
	{
		lineofficer.ammo_line = 0;
		dialog = "fight_bravely";
	}
	else if(random_num == 1)
	{
		lineofficer.ammo_line = 1;
		dialog = "proud";
	}
	else if(random_num == 2)
	{
		lineofficer.ammo_line = 2;
		dialog = "everyshot_count";
	}

	node = getnode("ammo_spot" + self.ammo_line_num,"targetname");
	self.dontavoidplayer = true;

	self.og_animname = self.animname;
	self.animname = "bunker_anims";

	self thread ammo_cock_blocker();

	self anim_reach_solo(self, "ammo_pickup", undefined, node);


	lineofficers = getentarray("lineofficer","groupname");
	for(i=0;i<lineofficers.size;i++)
	{
		if(lineofficers[i].script_noteworthy == "lineofficer_right")
		{
			lineofficer = lineofficers[i];
		}
	}

//	println("^2Print ", level.scrsound[lineofficer.animname]);
	while(distance(level.player.origin, lineofficer.origin) > 768)
	{
		wait 0.5;
	}

	lineofficer thread event7_give_ammo(dialog, self);
	level waittill("event7_next_in_line");

	self.ammo_line_num++;
//	level.ammo_line_num++;
	level.ammo_line_special++;

	truckriders = getentarray("truck1_rider","targetname");
	friends = getentarray("friends","groupname");
	for(i=0;i<friends.size;i++)
	{
		truckriders = maps\_utility_gmi::add_to_array(truckriders,friends[i]);
	}

	for(i=0;i<truckriders.size;i++)
	{
		truckriders[i] notify("move up");
	}

	self.animname = self.og_animname;

	while(1)
	{
		node = getnode("ammo_spot" + self.ammo_line_num,"targetname");
		self setgoalnode(node);
		self.animname = self.og_animname;
		// SO that the line never gets longer than 4.
		self waittill("move up");
		self.ammo_line_num++;
	}
}

ammo_cock_blocker()
{
	blocker = getent ("ammo_cock_blocker","targetname");
	
	if (!isdefined(blocker.oldorg))
	{
		blocker.oldorg = blocker.origin;
	}
	
	wait 0.05;
	self waittill ("goal");
	blocker.origin = self.origin;
	println ("^1 Got to waittill");
	self waittillmatch ("single anim","end");
	println ("^1 Got past waittill");
	blocker.origin = blocker.oldorg;	
}

event7_bunker_anim(node, msg)
{
	level endon("player got ammo");

	self endon("death");
	self waittill("goal");

	self.og_animname = self.animname;
	self.animname = "bunker_anims";

	if(isdefined(msg))
	{
		if(msg == "wall")
		{
println("^3Playing WALL anim");
			level thread anim_loop_solo(self, "wall_idle", undefined, "player got ammo", node);
		}
	}
	else
	{
		println("^5Self.targetname = ",self.targetname);
		level thread anim_loop_solo(self, "idle", undefined, "player got ammo", node);
//		self thread anim_loop_solo(self, "ammo_pickup2", undefined, "stop anim", node);
	}
}

event7_ammo_spot_debug()
{
	level endon("player got ammo");
	self endon("death");
	while(1)
	{
		if(isdefined(self.ammo_line_num))
		{
			print3d((self.origin + (0,0,100)), self.ammo_line_num, (1,1,1), 2);
		}
		else
		{
			print3d((self.origin + (0,0,100)), "--", (1,1,1), 2);
		}
		wait 0.06;
	}
}

// Check to see if the player got the ammo
event7_player_got_ammo_check(friend_node)
{
	level waittill("player got ammo");

	if(isdefined(self.og_animname))
	{
		self.animname = self.og_animname;
	}
	println("GO GO GO!");

	if(self.targetname == "miesha")
	{
		level endon("player shell shocked");
		self.bunker_count = false;
		self.event7_count = false;
	}

	self.dontavoidplayer = false;

	if(isdefined(friend_node))
	{
		node1 = getnode("after_bunker_path","targetname");
		self setgoalnode(node1);
		self waittill("goal");

		if(self.targetname == "miesha")
		{
			self.bunker_count = true;
		}

		level thread event8_blow_bunker_counter();

		if(self.targetname == "vassili")
		{
			self.goalradius = 512;
			self.made_goal = false;
//			self thread event8_vassili_chat();
		}

		node2 = friend_node;
		self setgoalnode(node2);
		if(self.targetname == "boris")
		{
			self thread event9_cover_crouch("idle_3", node2);
		}
		else if(self.targetname == "miesha")
		{
			//self thread event9_cover_crouch(undefined, node2);
			println("This could be breaking miesha");
		}
		else
		{
			self thread event9_cover_crouch(undefined, node2);
		}
		self waittill("goal");

		if(self.targetname == "miesha")
		{
			self.event7_count = true;
		}

		println(self.targetname," ^3Reached Goal");
		level thread event7_counter();

		if(self.targetname == "vassili")
		{
			self.made_goal = true;
			level.commissar1 notify("stop anim");
			level.commissar1.goalradius = 128;
			level.commissar1 setgoalnode(getnode("commissar1_spot1","targetname"));
		}
//		if(self.targetname == "boris")
//		{
//			level.boris thread anim_single_solo(level.boris,"were_going_to_die");
//			wait 0.75;
//			level.miesha thread anim_single_solo(level.miesha, "pull_yourself_together");
//		}
		self.goalradius = 512;
	}
	else
	{
		node1 = getnode("after_bunker_path","targetname");
		self setgoalnode(node1);
		self waittill("goal");
		level thread event8_blow_bunker_counter();

		name_of_node = ("right_line_node" + self.node_num);
		self.goalradius = 128;
		node2 = getnode(name_of_node, "targetname");
		self thread event9_cover_crouch(undefined, node2);
		self setgoalnode(node2);
		self waittill("goal");
		self.goalradius = 512;
	}
}

event7_counter()
{
	level.friends_right_line_reached--;
	if (level.friends_right_line_reached == 0)
	{
		println("Doing EVENT9");
		level thread event9();
	}
}

event7_ammo_pickup()
{
	trigger = getent("event7_ammo_pickup","targetname");
	trigger waittill("trigger");

	org = spawn("script_origin",level.player.origin);
	org.angles = level.player.angles;
	println("^2ORG ANGLES: ",org.angles);
	println("^2PLAYER BEFORE ANGLES: ",level.player.angles);
	level.player linkto(org);
	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowProne(false);
	level.player allowCrouch(false);

	lineofficers = getentarray("lineofficer","groupname");
	for(i=0;i<lineofficers.size;i++)
	{
		if(lineofficers[i].script_noteworthy == "lineofficer_right")
		{
			lineofficer = lineofficers[i];
		}
	}

	// Temp, change this so it uses an "array" from the trenches_anim, rather than specifying it.
	random_num = randomint(3);

	if(isdefined(lineofficer.ammo_line))
	{
		if(random_num == lineofficer.ammo_line)
		{
			if(random_num == 2)
			{
				random_num--;
			}
			else
			{
				random_num++;
			}
		}
	}

	if(random_num == 0)
	{
		lineofficer.ammo_line = 0;
		dialog = "fight_bravely";
	}
	else if(random_num == 1)
	{
		lineofficer.ammo_line = 1;
		dialog = "proud";
	}
	else if(random_num == 2)
	{
		lineofficer.ammo_line = 2;
		dialog = "everyshot_count";
	}
//	else  if(random_num == 3)
//	{
//		lineofficer.ammo_line = 3;
//		dialog = "fascious";
//	}

//	println("^2Print ", level.scrsound[lineofficer.animname]);
	lineofficer thread event7_give_ammo(dialog);
	level waittill("event7_next_in_line");

	level.player setWeaponSlotAmmo("primary", 60);
	level.player setWeaponSlotAmmo("pistol", 30);
	level.player giveWeapon("RGD-33russianfrag");
	level.player setWeaponSlotAmmo("grenade", 3);
	wait 0.2;

	level.player unlink();
	println("^2PLAYER AFTER ANGLES: ",level.player.angles);
	org delete();
	level.player allowLeanLeft(true);
	level.player allowLeanRight(true);
	level.player allowProne(true);
	level.player allowCrouch(true);

	level notify("player got ammo");
	level notify("objective 2 complete");

	level thread event8_shell_shock_player();

	trigger = getent("event13_vassili_talk","targetname");
	trigger waittill("trigger");
	println("^6Anon: Down!!!");

	//anon_troop_dialogue(getclosest, trooper, dialogue)
	excluders[0] = level.antonov;
	level thread anon_troop_dialogue(true, undefined, "anon_down", undefined, excluders);
}

event8_spawn_commissar()
{
	trigger = getent("event8_spawn_commissar","targetname");
	trigger waittill("trigger");
	spawner1 = getent("commissar1_spawner","targetname");
	spawner2 = getent("commissar2_spawner","targetname");

	commissar1 = spawner1 dospawn();
	commissar2 = spawner2 dospawn();

	if(isdefined(commissar1))
	{
		println("^5COMMMISSAR1");
		spawner1.count = 0;
		level.commissar1 = commissar1;
		commissar1.targetname = "commissar1";
		commissar1.animname = "commissar";
		commissar1.groupname = "friends";
		commissar1.dontavoidplayer = true;
		commissar1.accuracy = 0.05;
		commissar1.pacifist = true;
		commissar1.ignoreme = true;
		commissar1.name = "Sgt. Antonov";
		commissar1.maxsightdistsqrd = 3000; // 3000 units
		commissar1 character\_utility::new();
		commissar1 character\RussianArmyAntonov::main();
		commissar1 thread maps\_utility_gmi::magic_bullet_shield();
		level.antonov = commissar1;
	
		level thread event8_antonov_dialog();
	}

	if(isdefined(commissar2))
	{
		level.commissar2 = commissar2;
		commissar2.targetname = "commissar2";
		spawner2.count = 0;
		commissar2.ignoreme = true;
		commissar2.pacifist = true;
		commissar2 thread maps\_utility_gmi::magic_bullet_shield();
		commissar2.dontavoidplayer = true;
	}
}

event8_antonov_dialog()
{
	trigger = getent("event8_blow_bunker","targetname");
	trigger waittill("trigger");

	println("^3ANTONOV START DIALOGUE!!!");
	level.antonov thread anim_loop_solo(level.antonov, "wave_loop", undefined, "stop anim");
}


event8_blow_bunker_counter()
{
	level.blow_bunker_counter++;
	trigger = getent("event8_blow_bunker","targetname");

	truck1_riders = getentarray("truck1_rider","targetname");
	friends = getentarray("friends","groupname");
	commissar1 = getent("commissar1","targetname");
	if(isdefined(commissar1))
	{
		friends = maps\_utility_gmi::subtract_from_array(friends, commissar1);
	}

	for(i=0;i<friends.size;i++)
	{
		truck1_riders = maps\_utility_gmi::add_to_array(truck1_riders,friends[i]);
	}

	// Get the total amount of LIVING Truck1 Riders.
	total_guy_count = 0;
	for(i=0;i<truck1_riders.size;i++)
	{
		if(isalive(truck1_riders[i]))
		{
			total_guy_count++;
		}
	}

	println(level.blow_bunker_counter," Have made it out of the BUNKER! Out of: ", total_guy_count);

	if(level.blow_bunker_counter == total_guy_count)
	{
		println("WAITING FOR TRIGGER!");
		trigger waittill("trigger");
		level thread event8_blow_bunker();
		wait 0.05;
		trigger delete();
	}
}

event8_blow_bunker()
{
	self_respawner_setup("mg42_group1", undefined, undefined, undefined, undefined, undefined, 9000000);
//	self_respawner_setup("mg42_group1_b", undefined, undefined, undefined, undefined, undefined, 9000000);
	self_respawner_setup("mg42_group2", undefined, undefined, undefined, undefined, undefined, 9000000);
	self_respawner_setup("mg42_group3", undefined, undefined, undefined, undefined, undefined, 9000000);

	bunker_exit_fx = getent("bunker_exit_fx", "targetname");
	bunker_exit_fx_target = getent(bunker_exit_fx.target, "targetname");
	angles = vectornormalize (bunker_exit_fx_target.origin - bunker_exit_fx.origin);
	bunker_exit_fx playsound("mass_scream");
	wait 0.2;
	playfx(level._effect["bunker_exit_dust"], bunker_exit_fx.origin, angles);
	bunker_exit_fx playsound("bunker_cavein");

	bunker_mortar1 = getent("bunker_mortar_1", "targetname");
	bunker_mortar1 thread instant_mortar();


	wait 0.1;
	block_bunker = getent("block_bunker","targetname");
	block_bunker solid();
	block_bunker show();
	block_bunker disconnectpaths();

	// Delete commissars
	commissars = getentarray("start_trench_commissars", "groupname");
	for(i=0;i<commissars.size;i++)
	{
		commissars[i] delete();
	}

	// Delete bunker1_garbage
	bunker1_garbage = getentarray("bunker1_garbage", "targetname");
	for(i=0;i<bunker1_garbage.size;i++)
	{
		bunker1_garbage[i] delete();
	}

	truckriders = getentarray("truck2_rider","targetname");
	for(i=0;i<truckriders.size;i++)
	{
		truckriders[i] delete();
	}

	bunker_exit_fx playsound("explode_bunker");
	bunker_mortars = getentarray("bunker_mortar", "targetname");
	for(i=0;i<bunker_mortars.size;i++)
	{
		wait (0.5 + randomfloat(2));
		playfx(level._effect["bunker_explosion"], bunker_mortars[i].origin);
	}
}

//event8_vassili_chat()
//{
//	vassili_talked = false;
//	while(!self.made_goal && !vassili_talked)
//	{
//		if(distance(level.vassili.origin, level.player.origin) < 256)
//		{
//			vassili_talked = true;
//			level.vassili thread anim_single_solo(level.vassili,"hurry");
//		}
//		wait 0.25;
//	}
//}

event8_shell_shock_player()
{
	trigger = getent("event8_shell_shock","targetname");
	trigger waittill("trigger");
	level thread event8_miesha_shellshock();
	level thread event7_counter();
	angle = (0,0,0);
	player_z = level.player.angles[1];
	if(player_z < 90 && player_z > -90)
	{
		pos = (1256,-1008,0);
	}
	else
	{
		pos = (1000,-992,0);
	}
//     	vec = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(level.player.angles),200);
	mortar = spawn("script_origin",pos);

	if(getcvar("no_shellshock") == "1")
	{
		level.event7_shell_shock = false;
		return;
	}

	level.event7_shell_shock = true;
	//mortar instant_mortar(256, 1,0); // Really low damage.
	playfx (level.mortar,level.player.origin);
	level notify("player shell shocked");
	//maps\_shellshock_gmi::main(8, 5, 10);
	
	if(isalive(level.player))
	{
		level.player allowStand(false);
		level.player allowCrouch(false);
		level.player allowProne(true);
		
		wait 0.15;
		level.player viewkick(127, level.player.origin);  //Amount should be in the range 0-127, and is normalized "damage".  No damage is done.
		level.player shellshock("default", 8);
		wait 1.5;
		
		level.player allowStand(true);
		level.player allowCrouch(true);
	}
	
	level.player_shell_shock = true;
	wait 6;
	level.event7_shell_shock = false;
	wait 2;
	level.player_shell_shock = false;

//		line(level.player.origin, vec); // Draw a line, very handy.
}

event8_miesha_shellshock()
{
	level waittill("player shell shocked");

	level.miesha.animname = "miesha";	
	// Teleport Miesha

	no_teleport = false;
	player_sees_miesha = false;
	player_z = level.player.angles[1];
	if(player_z < 90 && player_z > -90)
	{
		position = 2;
		pos = (976, -976, (level.player.origin[2] + 16));

		if(level.miesha.origin[0] > level.player.origin[0] && level.miesha.origin[1] < -900)
		{
			no_teleport = true;
		}
	}
	else
	{
		position = 1;
		pos = (1248, -1016, (level.player.origin[2] + 16));

		if(level.miesha.origin[0] < level.player.origin[0] && level.miesha.origin[1] < -900)
		{
			player_sees_miesha = true;
		}
	}
	
//	level.miesha teleport(pos);
//	level.miesha.origin = pos;

	// Incase the player goes through really quickly.
	if(!level.miesha.bunker_count)
	{
		level thread event8_blow_bunker_counter();
	}

	if(player_sees_miesha)
	{
		println("^1Player can POTENTIALLY see Miesha! (aborting...)");

		level.miesha.goalradius = 512;
	
		if(!level.miesha.event7_count)
		{
			println("^5EVENT7 COUNTER!");
			level thread event7_counter();
		}

		return;		
	}

	if(!no_teleport)
	{
		org = spawn("script_origin",level.miesha.origin);
		level.miesha linkto(org);
		wait 0.1;
		org.origin = pos;
		wait 0.1;
		level.miesha unlink();
	}

	// Check to make sure Miesha has been infact teleported.

	wait 0.1;

	println("^3Miesha's position: ",level.miesha.origin);

	if(distance(level.miesha.origin, level.player.origin) > 256)
	{
		println("^1Miesha did not teleport!");
		if(!no_teleport)
		{
			level.miesha.goalradius = 512;
		
			if(!level.miesha.event7_count)
			{
				println("^5EVENT7 COUNTER!");
				level thread event7_counter();
			}

			return;
		}
	}

	println("^2Miesha has been teleported!");

	// Have Miesha get into position
	node = getnode("event8_miesha_spot" + position,"targetname");
	level.miesha allowedstances("stand");
	level.miesha.og_goalradius = level.miesha.goalradius;
	level.miesha.goalradius = 0;
	level.miesha setgoalnode(node);
	level.miesha waittill("goal");

	level.miesha.goalradius = 96;
	level.miesha setgoalpos(level.player.origin);
	level.miesha waittill("goal");

	println("^3Miesha made it to Goal");

//	level.miesha animscripts\shared::LookAtEntity(level.player, 3, "alert", eyesOnly, interruptOthers);
	while(level.event7_shell_shock)
	{
		level.miesha setgoalpos(level.player.origin);
		wait 0.5;
	}

	level.miesha setgoalpos(level.player.origin);
	level.miesha waittill("goal");

	angles = vectorToAngles(level.player.origin - level.miesha.origin);

	println("^5level.player.angles: ",level.player.angles);
	println("^5angles: ",angles);

//	level.miesha OrientMode("face angle", angles[1]);

	time = 1000 + gettime();
	while(time > gettime())
	{
		println("^3Miesha is orientating...");
		level.miesha OrientMode("face point", level.player.origin); 
		wait 0.05;
	}

	if(!isdefined(org))
	{
		org = spawn("script_origin",level.miesha.origin);
	}

	wait 1;

	org.angles = level.miesha.angles;
	org.origin = level.miesha.origin;
	println("^6Miesha, 'miesha_you_alright'");
	//Have Miesha look at player, and once player is out of shell shock, play dialogue.	
	org anim_single_solo(level.miesha,"miesha_you_alright");

	wait 1;
	org delete();

	//  Have miesha run to destination.
	node = getnode("miesha_right_line_node1","targetname");
	level.miesha setgoalnode(node);
	level.miesha allowedstances("stand","crouch","prone");

	level.miesha waittill("goal");
//	level.miesha.goalradius = 512;
	level.miesha thread event9_cover_crouch(undefined, node);

	if(!level.miesha.event7_count)
	{
		println("^5EVENT7 COUNTER!");
		level thread event7_counter();
	}
}

event9()
{
	level.mortar_mindist = 128;
	level.mortar_maxdist = 2048;
	vassili = getent("vassili","targetname");
	boris = getent("boris","targetname");
	miesha = getent("miesha","targetname");

	while(level.player_shell_shock)
	{
		println("Waiting...");
		wait 0.5;
	}

	for(i=level.mortar_random_delay;i>0;i--)
	{
		println(level.mortar_random_delay);
		level.mortar_random_delay = i;
		wait 0.1;
	}

//	setCullFog (0, 256, .32, .36, .40, 15 ); // For smokey feel

	spot_barrage = spawn("script_origin",(level.player.origin + (0,0,64)));
	spot_barrage playsound ("distant_barrage_long");
	println("Commissar: Head Down!!!");

	frontline = getentarray("truck1_rider","targetname");
	friends = getentarray("friends","groupname");
	for(i=0;i<friends.size;i++)
	{
		frontline = maps\_utility_gmi::add_to_array(frontline,friends[i]);
	}
	
	for(i=0;i<frontline.size;i++)
	{
		wait (randomfloat(0.2));
		frontline[i] allowedStances ("crouch");
	}

	wait 8;
	level thread event9_ambient_transition();
	wait 7;

	level notify("stop falling mortars");

	maps\_utility_gmi::autosave(2);
	
	level thread event9_boris_vassili_dialog();
	level thread Event9_Frontline_Stand(frontline);

	level waittill("start_event9_battle");

	level event9_distant_whistle();

	attrib["maxsightdistsqrd"] = 5000000; // Float
	attrib["bravery"] = 2000; // Float
	attrib["goalradius"] = 64;
	attrib["suppressionwait"] = 0.5; // Float
	attrib["health"] = 125; // Float
	attrib["accuracy"] = 0.5; // Float
//				   	  respawner_setup(groupname, grouped, attributes, num_of_respawns, wait_till, last_goal)
	level thread maps\_respawner_gmi::respawner_setup("right_flank_1", undefined, attrib, undefined, undefined, level.player);

	// Reduce friendly health
	truckriders = getentarray("truck1_rider","targetname");
	for(i=0;i<truckriders.size;i++)
	{
		if(issentient(truckriders[i]) && isalive(truckriders[i]) && truckriders[i].health > 50)
		{
			truckriders[i].health = truckriders[i].health * 0.3;
		}
	}

	wait 1;

	level thread event9_dummyA_setup();
	level thread event9_dummyB_setup();

	if(getcvar("quick_wave") == "1")
	{
		level.rf_time_length = 10;
	}
	else
	{
//		level.rf_time_length = 120;
//		level.rf_time_length = 60; // For 010904 milestone.
		level.rf_time_length = 90; // For 011804 milestone. MIkeD Recommended.
	}

	commissars[0] = level.antonov;
	commissars[1] = filterAI("allies", "right_flank_commissars", "groupname")[0];
	commissars[1].animname = "commissar";
	level thread player_retreat(1000, "x", commissars, "right flank done");

	vo_divider = level.rf_time_length / 4; // Divided by four, is referring to the number of dialogues in event9_antonov_battle_dialogue()
	vo_time = level.rf_time_length - vo_divider;
	println("^5VO_TIME = ",vo_time);

	level thread event9_antonov_battle_dialogue();

	level thread event9_panzer();
	for(i=level.rf_time_length;i>0;i--)
	{
		if(i < vo_time)
		{
			level notify("event9_ant_battle_dialogue");
			vo_time = (vo_time - vo_divider) + 1;
			println("^5NEW VO_TIME = ",vo_time);
		}

		println(i);
		wait 1;
	}

	wait 4;

//	respawners = getentarray("right_flank_1","groupname");
//	for(i=0;i<respawners.size;i++)
//	{
//		if(respawners[i].classname == "script_origin")
//		{
//			respawners[i] notify("stop respawning");
//		}
//	}

	level thread maps\_respawner_gmi::respawner_stop("right_flank_1");

	right_flank_guys = getentarray("right_flank_1_ai","targetname");
	stuka_crashing = false;
	while(right_flank_guys.size > 0)
	{
		println("Event9: Guys Remaining: ",right_flank_guys.size);
		right_flank_guys = getentarray("right_flank_1_ai","targetname");
		if(right_flank_guys.size <= 5 && !stuka_crashing)
		{
			level.flag["right flank done"] = true;
			level notify("right flank done");
			stuka_crashing = true;
			level thread event10_stuka_crash();
		}
		wait 0.5;
	}

	level notify("player_retreat_reset");
	// Objective 3 Complete...
	objective_state(3,"done");

//	wait 3;
}

Event9_Frontline_Stand(frontline)
{
	for(i=0;i<frontline.size;i++)
	{
		if(isalive(frontline[i]))
		{
			wait (randomfloat(1));
			frontline[i] allowedStances ("stand", "crouch");
		}
	}
}

// Returns an array with the filtered exceptions
filterAI(team, filter_name, filter_type)
{
	if(isdefined(team))
	{
		ai = getaiarray(team);
	}
	else
	{
		ai = getaiarray();
	}

	if(!isdefined(filter_type))
	{
		return;
	}

	if(!isdefined(filter_name))
	{
		return;
	}

	new_ai = [];
	for(i=0;i<ai.size;i++)
	{
		if(filter_type == "groupname")
		{
			if(isdefined(ai[i].groupname))
			{
				if(ai[i].groupname == filter_name)
				{
					new_ai[new_ai.size] = ai[i];
				}
			}
		}
		else if(filter_type == "targetname")
		{
			if(isdefined(ai[i].targetname))
			{
				if(ai[i].targetname == filter_name)
				{
					new_ai[new_ai.size] = ai[i];
				}
			}
		}
		else if(filter_type == "script_noteworthy")
		{
			if(isdefined(ai[i].script_noteworthy))
			{
				if(ai[i].script_noteworthy == filter_name)
				{
					new_ai[new_ai.size] = ai[i];
				}
			}
		}
		else if(filter_type == "script_uniquename")
		{
			if(isdefined(ai[i].script_uniquename))
			{
				if(ai[i].script_uniquename == filter_name)
				{
					new_ai[new_ai.size] = ai[i];
				}
			}
		}
	}

	println("^3(filterAI): new_ai.size = ",new_ai.size);
	return new_ai;
}

event9_antonov_battle_dialogue()
{
	dialogue = [];
	guy = [];
	dialogue[1] = "antonov_keepfiring01";
	guy[1] = level.antonov;
	dialogue[2] = "antonov_keepfiring02";
	guy[2] = level.antonov;
	dialogue[3] = "vass_overrun";
	guy[3] = level.vassili;
	dialogue[4] = "antonov_keepfiring03";
	guy[4] = level.antonov;

	num = 1;

	while(num < 4)
	{
		level waittill("event9_ant_battle_dialogue");
		println("^5Antonov is saying: ",dialogue[num]);
		level thread anim_single_solo(guy[num], dialogue[num]);
		num++;
	}
}

event9_distant_whistle()
{
	level notify ("STOP IT NOW");
	angle1 = (0,30,0); 
     	vec1 = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(angle1),8000);
	angle2 = (0,20,0); 
     	vec2 = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(angle2),6000);
	angle3 = (0,-45,0); 
     	vec3 = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(angle3),8500);
	distant_whistle_1 = spawn("script_origin",(vec1));
	distant_whistle_2 = spawn("script_origin",(vec2));
	distant_whistle_3 = spawn("script_origin",(vec3));

	distant_whistle_1 playsound("distant_whistle_01");
	wait 1.25;
	distant_whistle_3 playsound("distant_whistle_03");
	wait 2;
	distant_whistle_2 playsound("distant_whistle_02");
}

// If the player passes the "pos" along the "axis", then the "ai_array" will attack him.
player_retreat(pos, axis, ai_array, ender)
{
	if(isdefined(ender))
	{
		level endon(ender);
	}

	if(ai_array.size < 1)
	{
		return;
	}

	if(axis == "x")
	{
		use_origin = 0;
	}
	else if(axis == "y")
	{
		use_origin = 1;
	}
	else if(axis == "z")
	{
		use_origin = 2;
	}

	warning[0] = "warning1";
	warning[1] = "warning2";
	warning[2] = "warning3";

	traitor_line[0] = "traitor1";
	traitor_line[1] = "traitor2";

	traitor = false;
	level.traitor_warning = false;

//	level thread retreat_debug(pos, axis);
	level thread player_retreat_reset(ai_array);
	while(1)
	{
		println("^5(player_retreat): Checking for Player!");
		if(level.player.origin[use_origin] < pos && isalive(level.player))
		{
			if(!level.traitor_warning)
			{
				println("^5Traitor Warning: TRUE");
				level.traitor_warning = true;

				num = randomint(warning.size);

				talker = maps\_utility_gmi::getClosest(level.player.origin, ai_array);

				if(isdefined(level.scrsound[talker.animname][warning[num]]))
				{
					talker anim_single_solo(talker, warning[num], undefined, undefined);
				}

				continue;
			}

			if(!traitor)
			{
				println("^1TRAITOR! TRAITOR! TRAITOR! TRAITOR! TRAITOR!");
				num = randomint(traitor_line.size);
				traitor = true;

				talker = maps\_utility_gmi::getClosest(level.player.origin, ai_array);

				if(isdefined(level.scrsound[talker.animname][traitor_line[num]]))
				{
					talker thread anim_single_solo(talker, traitor_line[num], undefined, undefined);
				}

				for(i=0;i<ai_array.size;i++)
				{
					ai_array[i] thread player_retreat_charge(ender);			
				}
			}
		}
		else
		{
			println("^5player_is_not_a_traitor");
			traitor = false;
			level notify("player_is_not_a_traitor");
		}

		wait 0.5;
	}
}

retreat_debug(pos, axis)
{
	if(axis == "x")
	{
		start_pos = (pos,10000,(level.player.origin[2] + 64));
		end_pos = (pos,-10000,(level.player.origin[2] + 64));
	}
	else if(axis == "y")
	{
		start_pos = (10000,pos,(level.player.origin[2] + 64));
		end_pos = (-10000,pos,(level.player.origin[2] + 64));
	}
	else if(axis == "z")
	{
		start_pos = (10000,10000,pos);
		end_pos = (-10000,-10000,pos);
	}

	while(1)
	{
		line(start_pos, end_pos, (1,0,0));
		wait 0.06;	
	}
}

// Charge the player and gun him down!
player_retreat_charge(ender)
{
	if(isdefined(ender))
	{
		level endon(ender);
	}

	self thread player_retreat_return(ender);
	self thread player_retreat_talk(ender);
	self.find_player = true;
	self.original_team = self.team;
	while(1)
	{
		if(self.find_player)
		{
			println(self.targetname," Find Player");
			self.original_pacifist = self.pacifist;
			self.pacifist = 0;
			self.goalradius = 128 + randomint(128);
			self setgoalpos(level.player.origin);
			self thread player_retreat_shoot(ender);
		}
		wait 0.1;
	}
}

player_retreat_shoot(ender)
{
	self.find_player = false;

	if(isdefined(ender))
	{
		level endon(ender);
	}

	if(!isdefined(level.player.attached_origin))
	{
		level.player.attached_origin = spawn("script_origin",(level.player.origin + (0,0,64)));

		level.player.attached_origin linkto(level.player);
	}

	self waittill ("goal");
	println("^1FIREATTARGET!");
	self.original_ignoreme = self.ignoreme;
	self.ignoreme = true;
	self.team = "axis";
	self.favoriteenemy = level.player;
	wait (3 + randomfloat(1));

	self.team = "allies";
	self.find_player = true;
}

player_retreat_talk(ender)
{
	if(isdefined(ender))
	{
		level endon(ender);
	}

	traitor_line[0] = "traitor1b";
	traitor_line[1] = "traitor2b";

	wait 5 + randomfloat(10);
	while(1)
	{
		num = randomint(traitor_line.size);

		if(isdefined(level.scrsound[self.animname][traitor_line[num]]))
		{
			self thread anim_single_solo(self, traitor_line[num], undefined, undefined);
		}
		wait 5 + randomint(10);
	}
}

player_retreat_return(ender)
{
	if(isdefined(ender))
	{
		level endon(ender);
	}

	self.original_spot = self.origin;
	level waittill("player_is_not_a_traitor");

	if(isdefined(level.player.attached_origin))
	{
		level.player.attached_origin delete();
	}

	if(isdefined(self.original_team))
	{
		self.team = self.original_team;
	}

	self.goalradius = 64;

	if(isdefined(self.original_pacifist))
	{
		self.pacifist = self.original_pacifist;
	}

	if(isdefined(self.original_ignoreme))
	{
		self.ignoreme = self.original_ignoreme;
	}

	self.favoriteenemy = maps\_utility_gmi::getclosestAI(self.origin, "axis");
	self setgoalpos(self.original_spot);
}

player_retreat_reset(ai_array)
{
	level waittill("player_retreat_reset");

	if(isdefined(level.player.attached_origin))
	{
		level.player.attached_origin delete();
	}

	for(i=0;i<ai_array.size;i++)
	{
		if(isdefined(ai_array[i].original_team))
		{
			ai_array[i].team = ai_array[i].original_team;
		}
	
		ai_array[i].goalradius = 64;
	
		if(isdefined(ai_array[i].original_pacifist))
		{
			ai_array[i].pacifist = ai_array[i].original_pacifist;
		}
	
		if(isdefined(ai_array[i].original_ignoreme))
		{
			ai_array[i].ignoreme = ai_array[i].original_ignoreme;
		}
	}
}

event9_boris_anim()
{
	node = getnode("boris_right_line_node1","targetname");
	level.boris notify("stop_event9_cover_crouch");
	level.boris anim_single_solo(level.boris,"thank_god");

	level.boris thread event9_cover_crouch("idle_3",node);
}


event9_cover_crouch(forced_anim, node)
{
	self endon("death");

	self.goalradius = 0;
	self waittill("goal");

	self allowedstances("crouch");
	self.dontavoidplayer = true;
	wait 1;
	self endon("stop_event9_cover_crouch");

	println("^5(event9_cover_crouch) START: ", self.targetname);
	self notify("killanimscript");

	idle_1[0] = (%hideLowWall_1);
	idle_1[1] = (%hideLowWall_2);

	idle_2[0] = (%hideLowWallb_idle1);
	idle_2[1] = (%hideLowWallb_twitch1);

	idle_3[0] = (%hideLowWallc_idle1);
	idle_3[1] = (%hideLowWallc_twitch1);
	idle_3[2] = (%hideLowWallc_twitch2);

	if(isdefined(forced_anim))
	{
		if(forced_anim == "idle_1")
		{
			the_anim = idle_1;
		}
		else if(forced_anim == "idle_2")
		{
			the_anim = idle_2;
		}
		else if(forced_anim == "idle_3")
		{
			the_anim = idle_3;
		}
	}
	else
	{
		random_num = 1 + randomint(3);

		if(random_num == 1)
		{
			the_anim = idle_1;
		}
		else if(random_num == 2)
		{
			the_anim = idle_2;
		}
		else if(random_num == 3)
		{
			the_anim = idle_3;
		}
	}

	choice = randomint(the_anim.size);
	playbackRate = 0.9 + randomfloat(0.2);

	self.pacifist = true;
	self.pacifistwait = 0;
	self setFlaggedAnimKnobAllRestart("animdone", the_anim[choice], %body, 1, .5, playbackRate);
	self animscripts\shared::DoNoteTracks("animdone");

	while(level.event9_barrage)
	{
		choice = randomint(the_anim.size);
		playbackRate = 0.9 + randomfloat(0.2);
	
		self setFlaggedAnimKnobAllRestart("animdone", the_anim[choice], %body, 1, .1, playbackRate);
		self animscripts\shared::DoNoteTracks("animdone");
	}

	time = (randomfloat(1) * 1000) + gettime();

	while(time > gettime())
	{
		choice = randomint(the_anim.size);
		playbackRate = 0.9 + randomfloat(0.2);
	
		self setFlaggedAnimKnobAllRestart("animdone", the_anim[choice], %body, 1, .1, playbackRate);
		self animscripts\shared::DoNoteTracks("animdone");
	}

	playbackRate = 0.9 + randomfloat(0.2);
	self setFlaggedAnimKnobAllRestart("animdone", %crouch2stand, %body, 1, 0.5, playbackRate);
	self animscripts\shared::DoNoteTracks("animdone");

	self allowedstances("stand","crouch","prone");

	self.pacifist = false;
	self.dontavoidplayer = false;
	self.pacifistwait = 2;
	self setgoalnode(node);
	self waittill("goal");
	self.goalradius = 512;
}

event9_boris_vassili_dialog()
{
	mg42s = [];
	for(i=0;i<3;i++)
	{
		mg42s[i] = getent("mg42_" + (i + 1),"targetname");
		mg42s[i] setmode("manual");
	}

	wait 2.25;
	
	level thread event9_boris_anim();
	wait 3;
	level.vassili anim_single_solo(level.vassili, "attack_soon");
	level notify("start_event9_battle");

	wait 1;
	level.commissar1 anim_single_solo(level.commissar1, "wait_for_it");
//	level.commissar1 anim_loop_solo(level.commissar1, "wait_for_it_idle", undefined, "stop_anim");
//	wait 0.5;
//	wait 1;
	level.commissar1 notify("stop_anim");
	level.commissar1 anim_single_solo(level.commissar1, "machineguns");
	
	mg_guy = getent("mg42_group1_ai","targetname");
	mg_guy.animname = level.commissar1.animname;
	mg_guy anim_single_solo(mg_guy, "mg_ready");
	wait 1;
	level.commissar1 anim_single_solo(level.commissar1, "fire");

	// To ensure they fire after Antonov says "FIRE"
	for(i=0;i<mg42s.size;i++)
	{
		mg42s[i] setmode("auto_ai");
	}
	level.event9_barrage = false;

	wait 1;
	level notify("start right flank start");
}

event9_commissar1_spot1()
{
	commissar1 = level.commissar1;
	commissar1 notify("stop anim");
	commissar1.goalradius = 128;
	commissar1 setgoalnode(getnode("commissar1_spot1","targetname"));
}

#using_animtree("trenches_dummies_path");
event9_dummyA_setup()
{
	println("^2ENEMY DUMMIES A GO!!!");
	node = getent("dummies_path_A","targetname");

	if(getcvar("dummy_test") == "1")
	{
		for(i=10;i>0;i--)
		{
			if(i == 7)
			{
				level.player unlink();
				fake_thing = spawn("script_origin",(level.player.origin));
				level.player linkto(fake_thing);
				fake_thing.origin = (node.origin + (0,256,128));
			}
			println("Countdown ",i);
			wait 1;
		}
	}

	for(i=0;i<2;i++)
	{	
		dummies_path = spawn ("script_model",(0,0,0));
		dummies_path.origin = (node.origin + (0,0,24));
		dummies_path setmodel ("xmodel/kursk_dummies_path_A");
		println(dummies_path.classname, " ", dummies_path.model);
		dummies_path.num = 0;
		dummies_path.angles = (0,180,0);
		dummies_path hide();
		dummies_path UseAnimTree(#animtree);
		level thread event9_dummy_path_think(dummies_path);
		wait 20;
	}
}

event9_dummyB_setup()
{
	println("^2ENEMY DUMMIES B GO!!!");
	node = getent("dummies_path_A","targetname");

	if(getcvar("dummy_test") == "1")
	{
		for(i=10;i>0;i--)
		{
			if(i == 7)
			{
				level.player unlink();
				fake_thing = spawn("script_origin",(level.player.origin));
				level.player linkto(fake_thing);
				fake_thing.origin = (node.origin + (5700,-3000,512));
			}
			println("Countdown ",i);
			wait 1;
		}
	}

	for(i=0;i<2;i++)
	{	
		dummies_path = spawn ("script_model",(0,0,0));
		dummies_path.origin = (node.origin + (0,0,24));
		dummies_path setmodel ("xmodel/kursk_dummies_path_B");
		println(dummies_path.classname, " ", dummies_path.model);
		dummies_path.num = 0;
		dummies_path.angles = (0,180,0);
		dummies_path hide();
		dummies_path UseAnimTree(#animtree);
		level thread event9_dummy_path_think(dummies_path);
		wait 20;
	}
}

event9_dummy_path_think(dummies_path)
{
	while(level.flag["right flank done"] == false)
	{
		if(dummies_path.model == "xmodel/kursk_dummies_path_B")
		{
			dummies_path setFlaggedAnimKnobRestart("animdone", %kursk_dummies_path_B);
		}
		else
		{	
			dummies_path setFlaggedAnimKnobRestart("animdone", %kursk_dummies_path_A);
		}

		count = 20;
		if(getcvarint("scr_gmi_fast") > 0)
		{
			if(getcvarint("scr_gmi_fast") < 2)
			{
				count = 10;
			}
			else
			{
				return;
			}
		}

		for (i=0;i<count;i++)
		{
			if (i < 10)
			{
				tag_num = ("tag_guy0" + i);
			}
			else
			{
				tag_num = ("tag_guy" + i);
			}
	
			dummy = spawn ("script_model",(1,2,3));
			dummies_path.num++;
			dummy.targetname = "dummy";
			dummy.tag = tag_num;
			dummy.num = i;
			dummy.animname = "drone";

			random_weapon = randomint(2);
			if(random_weapon == 0)
			{
				dummy attach("xmodel/weapon_kAr98", "tag_weapon_right");
			}
			else
			{
				dummy attach("xmodel/weapon_MP40", "tag_weapon_right");				
			}

			dummy thread event9_dummy_think(dummies_path);
		}
	
		while(dummies_path.num > 0)
		{
			wait 1.0;
		}
	}
}

#using_animtree("trenches_dummies");
event9_dummy_think(dummies_path)
{
	self.run_index = randomint (level.scr_anim[self.animname]["run"].size);
	self.move_anim = level.scr_anim[self.animname]["run"][self.run_index];

	self UseAnimTree(#animtree);
	self [[random(level.scr_character[self.animname])]]();
	self.origin = dummies_path gettagorigin (self.tag);
//	self.stopline = -250;
	self linkto (dummies_path, self.tag, (0,0,0), (0,0,0));

	self.died = false;
	self thread event9_dummy_animloop();
//	self waittill ("finished animating");

	if(self.num < 10)
	{
		wait (25 + randomfloat (5));
	}
	else if(self.num > 10)
	{
		wait (25 + randomfloat (10));
	}

	self unlink();

	deathanim = random (level.scr_anim[self.animname]["death"]);

	self animscripted("death anim", self.origin, self.angles, deathanim, "deathplant");
	self.died = true;
	self event9_bloody_death();

	wait 4;
	self movez (-100, 3, 2, 1);
	wait 3;
	self delete();
	dummies_path.num--;
}

event9_dummy_animloop()
{
	wait randomfloat(3);
	while (self.died == false)
	{
		if(!isdefined(num))
		{
			num = 0;
		}

		self setFlaggedAnimKnob("animdone", self.move_anim);
		self waittillmatch ("animdone", "end");
		num++;

		if(num == 5)
		{
			self.run_index = randomint (level.scr_anim[self.animname]["run"].size);
			self.move_anim = level.scr_anim[self.animname]["run"][self.run_index];
			num = 0;
		}
	}
}

event9_bloody_death()
{

	tag_array = level.scr_dyingguy["tag"];
	tag_array = maps\_utility_gmi::array_randomize(tag_array);
	tag_index = 0;
	waiter = false;

	for (i=0;i<3 + randomint (5);i++)
	{
		playfxOnTag ( level._effect [random (level.scr_dyingguy["effect"])], self, level.scr_dyingguy["tag"][tag_index] );
		thread playSoundOnTag(random (level.scr_dyingguy["sound"]), level.scr_dyingguy["tag"][tag_index]);

		tag_index++;
		if (tag_index >= tag_array.size)
		{
			tag_array = maps\_utility_gmi::array_randomize(tag_array);
			tag_index = 0;
		}
	}
}

event9_ambient_transition()
{
	println("^2Ambient 2");
	ambientPlay("ambient_trenches_02",1);
	
	// SWITCH BACK TO 01 FIRST
	wait 32.5;
	println("^2Ambient 1");
	ambientPlay("ambient_trenches_01",1);
	
	// THEN SWITCH TO 03
	wait 8;
	println("^2Ambient 3");
	ambientPlay("ambient_trenches_03",1);
}

event9_panzer()
{
	wait 10;
	tank = getent("panzer_1","targetname");
	tank thread maps\_panzerIV_gmi::init();
	tank maps\_tankgun_gmi::mgoff();
	plane = getent("bomb_tank_plane","targetname");
	plane show();
	plane.health = 100000000;
	plane maps\_stuka_gmi::init();
	plane notify("wheelsup");
	plane notify("takeoff");


	tank.health = 1000;
	tank attachPath( getvehiclenode ("panzer_1_start","targetname"));
	tank setwaitnode(getvehiclenode("auto2124","targetname")); // MERGE NOTE, check here when merging.
 	tank startPath();
	tank waittill("reached_wait_node");

	// anon_troop_dialogue(getclosest, trooper, dialogue, delay)
	level thread anon_troop_dialogue(true, trooper, "anon_inc_panzer", 3);
	
	target[1] = (1564,-1251,8);
	target[2] = (1432,-832,8);
	target[3] = (896,-1408,90);
	target[4] = (1080,-1792,96);
	target[5] = (1600,-1984,8);
	old_num = -1;
	for(i=0;i<7;i++)
	{
		num = (randomint(5) + 1);
		if(i == 0)
		{
			num = 1;
		}

		if(i == 1)
		{
			mg42_group3 = getentarray("mg42_group3","groupname");
			for(i=0;i<mg42_group3.size;i++)
			{
				if(mg42_group3[i].classname == "script_origin")
				{
					mg42_group3[i] notify("stop respawning");
				}
			}
			tank setTurretTargetVec((1126, -2305, 49));
			tank waittill("turret_on_target");
			wait 2;
			tank FireTurret();
			wait (1 + randomfloat(1));
		}

		if(num == old_num)
		{
			if(num == 1)
			{
				num++;
			}
			else
			{
				num--;
			}
		}
		old_num = num;
		println("Tank is firing at: TARGET",num);
		tank setTurretTargetVec(target[num]);
		tank waittill("turret_on_target");
		wait (2 + randomfloat(1));
		tank FireTurret();
		wait (1 + randomfloat(2));
	}

	tank waittill("reached_end_node");
	tank disconnectpaths();
	mg42 = getentarray("mg42_group2","groupname");
	for(i=0;i<mg42.size;i++)
	{
		if(mg42[i].classname == "script_origin")
		{
			mg42[i] notify("stop respawning");
		}
	}

	tank setTurretTargetVec(( 1116, -814, 28 ) );
	tank waittill("turret_on_target");
	wait 1;
	tank FireTurret();
	tank setTurretTargetEnt(level.player,( 0, 0, 50 ) );

	plane attachPath( getvehiclenode ("bomb_tank_path","targetname"));
	plane startpath();
	plane setwaitnode(getvehiclenode("auto2165","targetname")); // MERGE NOTE, check here when merging.
	plane.rightturret settargetentity(tank);
	plane.leftturret settargetentity(tank);
	wait 1;
	plane playsound("trenches_flyover02");
	plane waittill("reached_wait_node");
	radiusDamage (tank.origin, 512, tank.health + 100,  1); // mystery numbers!
	plane waittill("reached_end_node");
}

#using_animtree ("kursk_stuka");
event10_stuka_crash()
{
	wait 0.1;
	setCullFog (1000, 20000, .32, .36, .40, 5 );
//	wait 6;

	stuka = getent("crashing_stuka","targetname");
	stuka UseAnimTree(#animtree);
	stuka.impact = 0;

	stuka_path = spawn("script_model",(1570,-560,37));
	stuka_path setmodel("xmodel/kursk_stuka_path");
	stuka_path UseAnimTree(#animtree);

	stuka.origin = stuka_path gettagorigin ("tag_stuka");
	println("^3Stuka Crashing");
	stuka show();

	stuka thread event10_stuka_smoking();
	stuka linkTo(stuka_path, "tag_stuka", (0,0,0), (0,0,0));
	stuka_path setanim(%kursk_stuka_crash);

	wait 3;
	ambientPlay("ambient_trenches_01",1);
	stuka playsound("big_stuka_crash01");

	// Hacky way to force angles:
	org = spawn("script_origin",level.miesha.origin);
	org.angles = (0,-10,0);
	level.miesha thread anim_single_solo(level.miesha, "incoming_stuka", undefined, org);

	wait 2;
	setCullFog (1000, 10000, .32, .36, .40, 10 );
	wait 4;
	level.miesha thread anim_single_solo(level.miesha, "miesha_comin_round");

	wait 4.333;
	level.vassili thread anim_single_solo(level.vassili, "stuka_coming_down");

	wait 1;
	println("^1PLAYFX");
	
	vec = anglestoforward(stuka.angles);
	vec = maps\_utility_gmi::vectorMultiply(vec,100);
	playfx (level._effect["stuka_air_explosion"],stuka.origin,vec);
//	playfxOnTag (level._effect["stuka_air_explosion"], stuka, "tag_origin");

	level.event10_stuka_dmg = true;
	level thread event10_stuka_damage(stuka);

	stuka setmodel("xmodel/v_ge_air_stuka(d)");

	stuka playsound("big_stuka_crash02");
	wait 1.833;
	earthquake(0.5, 3, stuka.origin, 4000);
	stuka setflaggedanim("single anim", %kursk_stuka_explosion);
	stuka.impact = 1;

	playfxOnTag (level._effect["stuka_hitground"], stuka, "tag_origin");

	stuka waittillmatch("single anim","end");
	level.event10_stuka_dmg = false;
	level thread event11();

	level thread event10_stuka_clip();

	stuka thread maps\_utility_gmi::blend_upanddown_sound(stuka, 10,"planefire_low","planefire_high");

	wait 1;
	println("Stuka Origin ",stuka.origin, " ", stuka.angles);
}

event10_stuka_damage(stuka)
{
	while(level.event10_stuka_dmg)
	{
		radiusDamage (stuka.origin, 200, 100, 10);
		wait 0.25;
	}
}

event10_stuka_clip()
{
	stuka_clip = getent("stuka_clip","targetname");

	while(distance(stuka_clip.origin, level.player.origin) < 192)
	{
		wait 0.25;
	}

	stuka_clip solid();
}

event10_stuka_smoking()
{
	while(1)
	{
		playfxOnTag (level._effect["stuka_engine_fire"], self, "tag_engine_right");
		playfxOnTag (level._effect["stuka_engine_fire"], self, "tag_origin");
		wait 0.05;
		if(self.impact == 1)
		{
			return;
		}
	}
}

#using_animtree ("generic_human");
event11()
{
	println("^1 --- event11(): start");
	commissar1 = getent("commissar1","targetname");
//	door_commissar_spawner = getent("door_commissar","targetname");
//	door_commissar = door_commissar_spawner dospawn();
//	door_commissar.goalradius = 0;
//	door_commissar.accuracy = 0.01;
//	door_commissar.bravery = 0;
//	door_commissar.bravery = 20;	

	commissar1.goalradius = 128;
	commissar1.dontavoidplayer = true;
	commissar1 waittill("goal");
	commissar1 allowedstances("stand");

	wait 2;

	println("^6Commissar: The left flank is overran! You guys, get over there and protect it!");
	level.commissar1 anim_single_solo(level.commissar1, "reinforce_left_flank");
//	level.commissar1 thread point(90, false, undefined, undefined, 1);

//	wait 4;
//	level.commissar1 waittill("reinforce_left_flank");

	level notify("start objective 4");

	println("^1 --- event11(): autosave start");
	maps\_utility_gmi::autosave(3);
	println("^1 --- event11(): autosave end");

	commissar1 setgoalnode(getnode("commissar1_spot2","targetname"));

	level.player setfriendlychain(getnode("event11_chain","targetname"));

	println("^1 --- event11(): chain_on 'event11_chain1a'");
	maps\_utility_gmi::chain_on("event11_chain1a");
	println("^1 --- event11(): chain_on 'event11_chain2'");
	maps\_utility_gmi::chain_on("event11_chain2");

	level.boris.followmax = 1;
	level.boris.goalradius = 64;
	level.boris.followmin = 0;
	level.boris.suppressionwait = 5;
	level.boris setgoalentity (level.player);

	level.miesha.followmax = 2;
	level.miesha.goalradius = 64;
	level.miesha.followmin = 0;
	level.miesha.suppressionwait = 3;
	level.miesha setgoalentity (level.player);

	level.vassili.followmax = 3;
	level.vassili.goalradius = 64;
	level.vassili.followmin = 1;
	level.vassili.suppressionwait = 4;
	level.vassili setgoalentity (level.player);

	println("^1 --- event11(): 'event11' waittill 'trigger'");
	trigger = getent("event11","targetname");
	trigger maps\_utility_gmi::triggerOn();
	trigger waittill("trigger");

// No longer needed here, but use it for village, later.
//	maps\_utility_gmi::array_thread(getentarray( "injured", "targetname" ), ::event11_injured_guys_think);

	door = getent("door1","targetname");
	door rotateto((0,45,0), 2,1,0);
	door connectpaths();

	println("^1 --- event11(): level thread event12()");
	level thread event12();

	wait 3;
	println("^6Vassili: Enemy! Fire!");
	level.vassili thread anim_single_solo(level.vassili, "vass_fire");
}

point(point_direction, orientate_to_player, dialogue, vec, delay)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	self animscripts\point::point(point_direction, orientate_to_player, dialogue, vec);
}

event11_goto_left_flank(node1,node2)
{
	self.goalradius = 16;
	self setgoalnode(node1);
	self waittill("goal");
	
	self setgoalnode(node2);
}

event11_injured_guys_think()
{
	num = randomint(4);
	if(num == 0)
	{
		name_of_anim = "groinguy";
	}

	if(num == 1)
	{
		name_of_anim = "chestguy";
	}

	if(num == 2)
	{
		name_of_anim = "sideguy";
	}

	if(num == 3)
	{
		name_of_anim = "neckguy";
	}

	org = self.origin;
	if(name_of_anim == "groinguy")
	{
		angles = (self.angles + (0,180,0));
	}
	else
	{
		angles = self.angles;
	}

	spawn = spawn ("script_model",(0,0,0));
	spawn.origin = (org);
	spawn.angles = (angles);
	spawn.animname = name_of_anim;

	spawn [[level.scr_character[spawn.animname]]]();

	spawn UseAnimTree(level.scr_animtree[spawn.animname]);

	if (isdefined (level.scr_anim[spawn.animname]["death"]))
	{
		spawn animscripted("scriptedanimdone", org, angles, level.scr_anim[spawn.animname]["death"]);
		return;
	}

	guy[0] = spawn;
	thread anim_loop(guy, "idle", undefined, undefined, self);
//	while (1)
//	{
//		spawn playsound ("stalingrad_wounded_guys");
//		wait (4 + randomfloat(25));
//	}
}

event12_death_counter()
{
	println("^1 --- event12_death_counter(): start");
	level.trench_2_counter++;
	self waittill("death");
	level.trench_2_counter--;
}

event12_mg42()
{
	println("^1 --- event12_mg42(): start");
	level endon("cancel_mg42_fun");
	trigger = getent("event12_mg42","targetname");
	trigger waittill("trigger");

//	             self_respawner_setup(groupname, group, wait_till, starting_health, accuracy, num_of_respawns, sightdist)
	println("EVENT12_MG42 TRIGGER!");
//	level thread self_respawner_setup("mg42_fun", undefined, undefined, undefined, undefined, undefined, 1638400, 50000);

	attrib["maxsightdistsqrd"] = 5000000; // Float
	attrib["bravery"] = 2000; // Float
	attrib["goalradius"] = 64;
	attrib["suppressionwait"] = 0.5; // Float
	attrib["health"] = 25; // Float
	attrib["accuracy"] = 0.1; // Float
	level thread maps\_respawner_gmi::respawner_setup("mg42_fun", undefined, attrib, undefined, undefined, level.player);

	// anon_troop_dialogue(getclosest, trooper, dialogue, delay)
	level thread anon_troop_dialogue(true, trooper, "anon_driveback", 2);

	level.mg42_fun = true;

	mg42_node = getnode("event12_mg42_spot","targetname");
	level.vassili thread man_mg42(mg42_node);

	if(getcvar("no_mg42_fun") == "1")
	{
		wait 3;
	}
	else
	{
		wait 30;
	}

	level thread maps\_respawner_gmi::respawner_stop("mg42_fun");
	level.mg42_fun = false;
	level notify("mg42_fun_done");
}


man_mg42(mg42_node)
{
	self endon("stop_man_mg42");

	// This tells the AI to stay on the MG42.
	while(1)
	{
		self.used_an_mg42 = undefined;
		self maps\_spawner_gmi::go_to_node(mg42_node);
		self waittill("damage");
		println("^5Vassili Knocked off!");
		wait 2;
	}
}

dismount_mg42()
{
	mg42 = getent("md_18","targetname");

	owner = mg42 getturretowner();

	if(isdefined(owner) && owner == level.vassili)
	{
		println("^5VASSILI GET OFF THE TURRET!");
		level.vassili stopuseturret(mg42);
	}
}

event12()
{
	println("^1 --- event12(): start");
	println("^1 --- event12(): 'event12_left_flank' waittill 'trigger'");
	trigger = getent("event12_left_flank","targetname");
	trigger waittill("trigger");

	println("^1 --- event12(): level thread event12_flamethrower()");
	level thread event12_flamethrower();

	level.antonov setgoalnode(getnode("commissar1_spot3","targetname"));

	spawners = getentarray("left_flank_1","groupname");
	for(i=0;i<spawners.size;i++)
	{
		spawned[i] = spawners[i] dospawn();
		if(isdefined(spawned[i]))
		{
			spawned[i].groupname = "left_flank_1";
			println(spawned[i].targetname," has spawned. ", spawned[i].classname);
	
			if(spawners[i].classname == "actor_axis_wehrmacht_soldier_flamethrower")
			{
				spawned[i].bravery = 0;
				spawned[i].dropweapon = true;
	
				if(isdefined(spawners[i].script_noteworthy) && spawners[i].script_noteworthy == "flamethrower_1")
				{
					flamethrower_1 = spawned[i];
					spawned[i].targetname = "axis_flamethrower_1";
					flamethrower_1.goalradius = 32;
					spawned[i] settakedamage(0);
					flamethrower_1.ignoreme = false;
				}
			}
	
			if(spawned[i].team == "allies")
			{
				if(isdefined(spawners[i].script_health))
				{
					spawned[i].health = spawners[i].script_health;
				}
				else
				{
					spawned[i].health = 150;
				}
				spawned[i].accuracy = 0.005;
			}
	
			if(isdefined(spawners[i].script_noteworthy))
			{
				if(spawners[i].script_noteworthy == "prone")
				{
					spawned[i] allowedstances("crouch","prone","stand");
				}
	
				if(spawners[i].script_noteworthy == "crouch")
				{
					spawned[i] allowedstances("crouch","prone");
				}
			}	
	
			if(spawned[i].team == "axis")
			{
				if(isdefined(spawned[i].targetname) && spawned[i].targetname == "axis_flamethrower_1")
				{
					continue;
				}

				spawned[i].groupname = "left_flank_1_axis";
				spawned[i] thread event12_death_counter();
			}
		}
	}

	truckriders = getentarray("truck1_rider","targetname");
	for(i=0;i<truckriders.size;i++)
	{
		truckriders[i] delete();
	}

	mg42_group1 = getentarray("mg42_group1","groupname");
	for(i=0;i<mg42_group1.size;i++)
	{
		if(mg42_group1[i].classname == "script_origin")
		{
			mg42_group1[i] notify("stop respawning");
		}
	}

	mg42_group1_b = getentarray("mg42_group1_b","groupname");
	for(i=0;i<mg42_group1_b.size;i++)
	{
		if(mg42_group1_b[i].classname == "script_origin")
		{
			mg42_group1_b[i] notify("stop respawning");
		}
	}

	mg42_group1_ai = getent("mg42_group1_ai","targetname");
	if(isdefined(mg42_group1_ai) && isalive(mg42_group1_ai))
	{
		mg42_group1_ai delete();
	}

	mg42_group1_b_ai = getent("mg42_group1_b_ai","targetname");
	if(isdefined(mg42_group1_b_ai) && isalive(mg42_group1_b_ai))
	{
		mg42_group1_b_ai delete();
	}

	mg42_group2_ai = getent("mg42_group2_ai","targetname");
	if(isdefined(mg42_group2_ai) && isalive(mg42_group2_ai))
	{
		mg42_group2_ai delete();
	}

	mg42_group3_ai = getent("mg42_group3_ai","targetname");
	if(isdefined(mg42_group3_ai) && isalive(mg42_group3_ai))
	{
		mg42_group3_ai delete();
	}

	right_flank_2 = false;
	right_flank_2b = false;
	while(level.trench_2_counter > 0)
	{
		println("Event12: Guys Remaining: ",level.trench_2_counter);
		if(level.trench_2_counter <= 5 && !right_flank_2)
		{
			right_flank_2 = true;
			level thread self_respawner_setup("right_flank_2", undefined, undefined, 10, 0.05, undefined, 9000000);
			level thread self_respawner_setup("right_flank_2_allies", undefined, undefined, 10, undefined, undefined, 9000000);
			spawners = getentarray("mg42_group1_c","groupname");
			for(q=0;q<spawners.size;q++)
			{
				spawned[q] = spawners[q] dospawn();
				spawned[q].health = 10000000;
			}
		}

		if(level.trench_2_counter <= 3 && !right_flank_2b)
		{
			right_flank_2b = true;
			left_flank_1 = getentarray("left_flank_1_axis","groupname");
			for(i=0;i<left_flank_1.size;i++)
			{
				if(issentient(left_flank_1[i]) && isalive(left_flank_1[i]))
				{
					left_flank_1[i].goalradius = 128;
					left_flank_1[i] setgoalentity(level.player);
				}
			}
		}

		wait 0.5;
	}

	println("^1 --- event12(): level thread event12_mg42()");
	level thread event12_mg42();

	println("^1 --- event12(): trigger delete()");
	trigger delete();

	commissar1 = getent("commissar1","targetname");

	commissar1.got_to_player = false;
	commissar1.dontavoidplayer = false;
	commissar1 thread event12_find_player();
	commissar1.goalradius = 128;

	println("^1 --- event12(): commissar1 waittill 'goal'");
	commissar1 waittill("goal");

	mg42_fun_guys = getentarray("mg42_fun_ai","targetname");

	println("^1 --- event12(): if(level.mg42_fun) level.mg42_fun = ", level.mg42_fun);
	if(level.mg42_fun)
	{
		level.mg42_fun_ai_count = 0;
		level waittill("mg42_fun_done");
		mg42_fun_guys = getentarray("mg42_fun_ai","targetname");

		while(mg42_fun_guys.size > 0)
		{
			println("MG42 FUN: Guys Remaining: ", mg42_fun_guys.size);
			mg42_fun_guys = getentarray("mg42_fun_ai","targetname");
			wait 0.5;
		}		
	}
	else
	{
		println("^1Cancel MG42 FUN!");
		level notify("cancel_mg42_fun");
	}
//	setCullFog (1000, 5000, .32, .36, .40, 30 );
	level.vassili notify("stop_man_mg42");
	level thread dismount_mg42();

	objective_state(4,"done");
	maps\_utility_gmi::chain_off("event11_chain4");

	wait 2;
	commissar1.got_to_player = true;
	println("^6Commissar: Come on Comrades, follow me!");
	wait 0.5;

//	level.antonov thread anim_single_solo(level.antonov, "follow_me");
	level.antonov thread point(180, false, "follow_me");
// TODO: WE NEED REINFORCEMENTS HERE!!

//	level thread event13_vassili_talk();

	wait 2;

	println("^1 --- event12(): level.objective_5['start'] = true");
	level.objective_5["start"] = true;
	level notify("start objective 5");

	println("^1 --- event12(): maps\_utility_gmi::autosave(4) START");
	maps\_utility_gmi::autosave(4);
	println("^1 --- event12(): maps\_utility_gmi::autosave(4) END");

	level.vassili.followmax = 3;
	level.vassili.followmin = 1;

	println("^1 --- event12(): level thread event13()");
	level thread event13();

//	tank_paths = getvehiclenodearray("elefant_start","targetname");
	bomb_trigger = getentarray("plant_tank_bomb_use","targetname");
//	println("^3TANKS ",tank_paths.size);

	for(i=1;i<4;i++)
	{
		n = i-1;
		tank_path = getvehiclenode("elefant" + i + "_start","targetname");
		bomb[i] = getent(bomb_trigger[n].target,"targetname");
		//      spawnVehicle(<model>, <targetname>, <vehicletype>, <vec_origin>, <vec_angles>);
		tank = spawnVehicle( "xmodel/v_ge_lnd_elefant", ("elefant" + i), "Elefant", (9216,-4416,128), (0,0,0) );
		tank.script_team = "axis";
		bomb_trigger[n].used = 0; // For the hack...
		bomb_trigger[n] thread event12_elefant_trigger_hack(bomb[i]);
		bomb[i] linkto(tank);
		tank thread event12_elefant_charge(tank_path);
		tank.vehicletype = "Elefant";
		tank thread event12_fake_firing();
	}

	bunker_trigger = getent("event12_flamethrower","targetname");
	bunker_trigger waittill("trigger");
	org = getent("bunker2_mortar","targetname");
	wait (1 + randomfloat(1));
	org instant_mortar();
}

event12_flamethrower()
{
	println("^1 --- event12_flamethrower(): start");
	trigger = getent("event12_flamethrower","targetname");
	trigger waittill("trigger");
	level.vassili thread anim_single_solo(level.vassili,"flamethrowers");

	wait 0.1;

	ents = getentarray("flamethrower_target","script_noteworthy");
	
	for(i=0;i<ents.size;i++)
	{
		if(issentient(ents[i]))
		{
			flamethrower_target = ents[i];
			flamethrower_target settakedamage(false);
		}
	}

	flamethrower_1 = getent("axis_flamethrower_1","targetname");

	if(!isalive(flamethrower_1))
	{
		return;
	}

	wait 2;
//	flamethrower_1 settakedamage(false);

	println("Flamethrower_1 ",flamethrower_1);
	println("Flamethrower_target ",flamethrower_target);

	if(isdefined(flamethrower_target) && isalive(flamethrower_target))
	{
		flamethrower_1.favoriteenemy = flamethrower_target;
		flamethrower_target settakedamage(true);
	}
	flamethrower_1 settakedamage(true);
}

#using_animtree( "Elefant" );
event12_fake_firing()
{
	self endon("death");
	println("^1 --- event12_fake_firing(): start");
	while(1)
	{
		wait (4 + randomint(3));

		if(self.health <= 0)
		{
			return;
		}
//		self FireTurret();
//		self setAnimKnobRestart( %v_ge_lnd_elefant_fire );
		if(self.targetname == "elefant1")
		{
			targets = getentarray("elefant1_mortar","targetname");
			num = randomint(targets.size);
//			targets[num].sound_delay = (0.5 + randomint(2));
//			targets[num] instant_mortar();
			self thread Tank_Fire_Turret(targets[num], targetpos, start_delay, shot_delay, offset, validate, true, random_turning);
		}
		if(self.targetname == "elefant2")
		{
			targets = getentarray("elefant2_mortar","targetname");
			num = randomint(targets.size);
//			targets[num].sound_delay = (0.5 + randomint(2));
//			targets[num] instant_mortar();
			self thread Tank_Fire_Turret(targets[num], targetpos, start_delay, shot_delay, offset, validate, true, random_turning);
		}
		if(self.targetname == "elefant3")
		{
			targets = getentarray("elefant3_mortar","targetname");
			num = randomint(targets.size);
//			targets[num].sound_delay = (0.5 + randomint(2));
//			targets[num] instant_mortar();
			self thread Tank_Fire_Turret(targets[num], targetpos, start_delay, shot_delay, offset, validate, true, random_turning);
		}
	}
}

#using_animtree( "generic_human" );
event12_elefant_charge(path)
{
	println("^1 --- event12_elefant_charge(): start");
	self thread maps\_elefant_gmi::init("no_turret");
	self attachPath( path );
	self startPath();
	self waittill ("reached_end_node");
	println("Elefant Tank ", self.origin, " ",self.angles);
	self disconnectpaths();
	level thread event12_elefant_death_think(self);

}

event12_elefant_death_think(tank)
{
	println("^1 --- event12_elefant_death_think(): start");
	level endon("objective 6 complete");

	while(1)
	{
		level waittill ("plant_tank_bomb_use planted");

		trigger1 = undefined;
		for(i=1;i<3;i++)
		{
			trigger = getent("event16_chain" + i + "_trigger","targetname");

			if(level.player istouching(trigger))
			{
				trigger1 = trigger;
				trigger2 = getent("event16_chain" + (i+1) + "_trigger","targetname");				
			}
		}

		if(!isdefined(trigger1))
		{
			continue;
		}

		trigger1 maps\_utility_gmi::triggerOff();
		node = getnode(trigger2.target,"targetname");
		level.player setfriendlychain(node);
	
		wait 12;
		trigger1 maps\_utility_gmi::triggerOn();
	}
}

event12_elefant_trigger_hack(bomb)
{
	println("^1 --- event12_elefant_trigger_hack(): start");
	while(self.used != 1)
	{
		self.origin = bomb.origin;
		wait 0.5;
	}
}

event12_find_player()
{
	println("^1 --- event12_find_player(): start");
	while(!self.got_to_player)
	{
		println("Commissar1.got_to_player ",self.got_to_player);
		self setgoalpos(level.player.origin);
		wait 0.5;
	}
}

//event13_vassili_talk()
//{
//	trigger = getent("event13_vassili_talk","targetname");
//	trigger waittill("trigger");
//
//	level.vassili thread anim_single_solo(level.vassili, "incoming_tanks");
//}


event13()
{
	println("^1 --- event13(): start");
	level.vassili.followmax = 3;
	level.vassili.followmin = 1;

	level.boris.followmax = 0;
	level.boris.followmin = -1;

	level.miesha.followmax = 1;
	level.miesha.followmin = 0;

	level.antonov.followmax = 4;
	level.antonov.followmin = 2;

	level.player setfriendlychain(getnode("event13_chain","targetname"));

	maps\_utility_gmi::chain_on("event12_chain2");

	friends = getentarray("friends","groupname");
	for(i=0;i<friends.size;i++)
	{
		friends[i] setgoalentity(level.player);
	}

//	println("EVENT13 SHOULD HAVE STARTED!");

//	println("^1 --- event13(): EVENT13 SHOULD HAVE STARTED!");
	
	println("^1 --- event13(): thread event13_destroy_mg42()");
	level thread event13_destroy_mg42();
	println("^1 --- event13(): thread event13_speech()");
	level thread event13_speech();
}

event13_destroy_mg42()
{
	println("^1 --- event13_destroy_mg42(): start");
	trigger = getent("event13_destroy_mg42","targetname");
	trigger waittill("trigger");

	mortar = getent("mg42_mortar_hit","targetname");
	allies_guy = getaiarray("allies");
	for(q=0;q<allies_guy.size;q++)
	{
		if(distance(mortar.origin, allies_guy[q].origin) < 512)
		{
			if(isalive(allies_guy[q]))
			{
				old_health = allies_guy[q].health;
				allies_guy[q].health = (5);
			}
		}
	}
	println("^1 --- event13_destroy_mg42(): mortar instant_mortar()");
	mortar instant_mortar();

	wait 0.1;
	mg42 = getent("mg42_1","targetname");
	mg42 delete();

	mg42_nest_damaged = getent("mg42_nest_damaged","targetname");
	mg42_nest_damaged show();

	mg42_net_damaged = getent("mg42_net_damaged","targetname");
	mg42_net_damaged show();
	mg42_net_damaged solid();

	mg42_net = getent("mg42_net","targetname");
	mg42_net delete();

	mg42_nest = getent("mg42_nest","targetname");
	mg42_nest delete();

	org = getent("mg42_nest_fx","targetname");
	org playsound("mass_scream");
	org_target = getent(org.target,"targetname");
	angles = vectornormalize (org_target.origin - org.origin);
	playfx(level._effect["blow_mg42_nest"], org.origin, angles);
	earthquake(0.3, 1, org.origin, 4000);
}

event13_speech()
{
	println("^1 --- event13_speech(): start");
	trigger = getent("event13_positions","targetname");
	trigger waittill("trigger");

	println("^1 --- event13_speech(): 'event13_actual_speech' triggered");

	// Through here!
	level.antonov thread anim_single_solo(level.antonov, "antonov_thru_here");

	friends = getentarray("friends","groupname");
	commissar1 = getent("commissar1","targetname");

	println("^1 --- event13_speech(): subtract_from_array(friends, commissar1): BEFORE friends.size: ", friends.size);
	friends = maps\_utility_gmi::subtract_from_array(friends, commissar1);
	println("^1 --- event13_speech(): subtract_from_array(friends, commissar1): AFTER friends.size: ", friends.size);

	friends_spot = getnodearray("event13_spot","targetname");
	for(i=0;i<friends.size;i++)
	{
		friends[i] setgoalnode(friends_spot[i]);
	}

//	commissar1 setgoalnode(getnode("commissar1_spot4","targetname"));
//	commissar1 waittill("goal");

	node = getnode("commissar1_spot4","targetname");
	commissar1.animname = "commissar_event14";
	commissar1 anim_reach_solo(commissar1, "take_out_elefant_tanks", undefined, node);
	commissar1.event14_node = node;
	commissar1.animname = "commissar";

	commissar1.dontavoidplayer = true;
	commissar1 allowedstances("crouch");

	println("^1 --- event13_speech(): 'event13_actual_speech' waittill 'trigger'");
	trigger = getent("event13_actual_speech","targetname");
	trigger waittill("trigger");

	println("^1 --- event13_speech(): 'event13_actual_speech' triggered");

	level thread event14();
}

event14()
{
	level event14_antonov_dialogue();

	level.objective_5["start"] = false;
	level notify("objective 5 complete");

	level thread event16();

	level Event14_Kick_Door();

	level.vassili.followmax = 3;
	level.vassili.followmin = 1;
	level.vassili.suppressionwait = 0.5;

	level.boris.followmax = 0;
	level.boris.followmin = -1;
	level.boris.suppressionwait = 0.5;

	level.miesha.followmax = 1;
	level.miesha.followmin = 0;
	level.miesha.suppressionwait = 0.5;

	level.player setfriendlychain(getnode("event14_chain","targetname"));
	friends = getentarray("friends","groupname");
	for(i=0;i<friends.size;i++)
	{
		if(friends[i].targetname == "commissar1")
		{
			continue;
		}
		friends[i] setgoalentity(level.player);
	}

	level thread event14_battle1();

	// If player forgot what to do, repeat the line till trigger is hit.
	level thread event14_antonov_dialogue_loop();

	trigger = getent("event14_player_check","targetname");
	trigger waittill("trigger");
	level.event14_antonov_loop = false;

	wait 3;
	//Cheap teleport.
	org = spawn("script_origin",level.commissar1.origin);
	level.commissar1 linkto(org);
	org.origin = (128, -1538, 24);
	wait 0.1;
	level.commissar1 unlink();
	
	level.commissar1 setgoalnode(getnode("commissar1_spot5","targetname"));
}

event14_antonov_dialogue()
{
	level.antonov.og_animname = level.antonov.animname;
	level.antonov.animname = "commissar_event14";
	level.antonov anim_single_solo(level.antonov,"take_out_elefant_tanks", undefined, level.antonov.event14_node);
	level.antonov.animname = level.antonov.og_animname;
	level.event14_antonov_loop = true;
}

event14_antonov_dialogue_loop()
{
	wait 13;

	while(level.event14_antonov_loop)
	{
		level.antonov.og_animname = level.antonov.animname;
		level.antonov.animname = "commissar_event14";
		level.antonov anim_single_solo(level.antonov,"take_out_elefant_tanksb", undefined, level.antonov.event14_node);
		level.antonov.animname = level.antonov.og_animname;
		wait 17;
	}
}

event14_battle1()
{
	trigger = getent("event14_battle1","targetname");
	trigger waittill("trigger");

	trench_clips = getent("right_flank_clip","targetname");
	trench_clips delete();

	level thread maps\_respawner_gmi::respawner_stop("right_flank_2");

// Made triggers for these instead!
//	for(i=1;i<4;i++)
//	{
//		spawners = getentarray("elefant" + i + "_spawner","targetname");
//		for(q=0;q<spawners.size;q++)
//		{
//			guy = spawners[q] dospawn();
//			guy.bravery = 0;
//			guy.accuracy = (0.2 + randomfloat(1));
//		}
//	}
}

Event14_Kick_Door()
{
	node = getnode("event14_kick_node","targetname");

	kick_guy = [];
	kick_guy[0] = level.vassili;

	println("^5Kick_guy = ",kick_guy);
	println("^5Kick_guy[0].targetname = ",kick_guy[0].targetname);

	maps\_anim_gmi::anim_pushPlayer(kick_guy);

	kick_anim[0] = "kick_door_1";
	kick_anim[1] = "kick_door_2";

	num = randomint(2);

	anim_reach(kick_guy, kick_anim[num], undefined, node);
	level maps\_anim_gmi::anim_dontPushPlayer(kick_guy);

	level thread anim_single(kick_guy, kick_anim[num], undefined, node);

	kick_guy[0] waittillmatch ("single anim", "kick");

	door = getent("exit_door1","targetname");
	door playsound("wood_door_kick");
	door rotateto((0,45,0), 0.4, 0, 0.2);

	door waittill("rotatedone");
	door connectpaths();

	return;
}

event16_quick()
{
	// Reset their animnames, cause of "truckriders"
	level.miesha.animname = level.miesha.original_animname;
	level.vassili.animname = level.vassili.original_animname;
	level.boris.animname = level.boris.original_animname;

	level.player setWeaponSlotAmmo("primary", 60);
	level.player setWeaponSlotAmmo("pistol", 30);
	level.player giveWeapon("RGD-33russianfrag");
	level.player setWeaponSlotAmmo("grenade", 3);

	player_traincar = getent("player_traincar","targetname");
	player_traincar delete();
	train_clip = getent("player_traincar_clip","targetname");
	train_clip delete();

	truck_commissars = getentarray("start_truck_commissars","groupname");
	train_commissars = getentarray("start_train_commissars","groupname");
	all = add_array_to_array(truck_commissars,train_commissars);

	train_riders = getentarray("train_rider","targetname");
	all = add_array_to_array(all,train_riders);

	train = getentarray("train","targetname");
	all = add_array_to_array(all,train);

	truck5_riders = getentarray("truck5_rider","targetname");
	all = add_array_to_array(all,truck5_riders);

	truck6_riders = getentarray("truck6_rider","targetname");
	all = add_array_to_array(all,truck6_riders);

	truck2_riders = getentarray("truck2_rider","targetname");
	all = add_array_to_array(all,truck2_riders);

	truck_drivers = getentarray("truck_driver","groupname");
	all = add_array_to_array(all,truck_drivers);

	truck1_riders = getentarray("truck1_rider","targetname");
	all = add_array_to_array(all,truck1_riders);

	for(i=0;i<all.size;i++)
	{
		if(isalive(all[i]))
		{
			all[i] delete();
		}
	}

	pos = (-768,-4176,-16);

	level.player setorigin(pos + (-120,10000,0));
	wait 0.25;
	level.vassili teleport(pos);
	level.miesha teleport(pos + (-48,0,0));
	level.boris teleport(pos + (-72,0,0));
	wait 0.25;
	level.player setorigin(pos + (-120,0,0));

	exit_door2 = getent("exit_door2","targetname");
	exit_door2 rotateto((exit_door2.angles + (0,-90,0)), 1, 0, 0);
	exit_door2 connectpaths();

	exit_door3 = getent("exit_door3","targetname");
	exit_door3 rotateto((exit_door3.angles + (0,-80,0)), 1, 0, 0);
	exit_door3 connectpaths();

	level.vassili.followmax = 4;
	level.vassili.followmin = 2;

	level.boris.followmax = 1;
	level.boris.followmin = 0;

	level.miesha.followmax = 3;
	level.miesha.followmin = 1;

	spawner1 = getent("commissar1_spawner","targetname");
	commissar1 = spawner1 dospawn();

	if(isdefined(commissar1))
	{
		spawner1.count = 0;
		level.commissar1 = commissar1;
		commissar1.targetname = "commissar1";
		commissar1.animname = "commissar";
		commissar1.groupname = "friends";
		commissar1.dontavoidplayer = true;
		commissar1.accuracy = 0.05;
		commissar1.pacifist = true;
		commissar1.ignoreme = true;
		commissar1.name = "Sgt. Antonov";
		commissar1.maxsightdistsqrd = 3000; // 3000 units
		commissar1 character\_utility::new();
		commissar1 character\RussianArmyAntonov::main();
		commissar1 thread maps\_utility_gmi::magic_bullet_shield();
		level.antonov = commissar1;
	}

	level.player setfriendlychain(getnode("event16_chain","targetname"));
	level.antonov setgoalnode(getnode("commissar1_spot6a","targetname"));
	level thread event16_antonov_movement();

	friends = getentarray("friends","groupname");
	for(i=0;i<friends.size;i++)
	{
		if(friends[i].targetname == "commissar1")
		{
			continue;
		}
		friends[i] setgoalentity(level.player);
	}

	maps\_utility_gmi::autosave(5);
	level thread event16_run_to_village();

	// Converted dialog from level.vassili to level.commissar1.
	level.commissar1 thread anim_single_solo(level.commissar1,"getting_flanked");

	reinforcements = getentarray("reinforcements_allies_1","groupname");
	for(i=0;i<reinforcements.size;i++)
	{
		spawned = reinforcements[i] stalingradspawn();
		if(isdefined(spawned))
		{
			spawned.followmax = i + 3;
			spawned.followmin = i + 2;
			spawned.health = 2;
			spawned.accuracy = 0.1;
			spawned.groupname = "reinforcements_allies_1_ai";
			spawned.goalradius = 64;
			spawned setgoalentity(level.player);	
		}
	}

	wait 5.2;
//	level.miesha thread anim_single_solo(level.miesha,"back_and_forth");
	wait 3.25;
//	level.vassili thread anim_single_solo(level.vassili,"stay_here");

	level.vassili.goalradius = 64;
	level.boris.goalradius = 64;
	level.miesha.goalradius = 64;

	level.vassili setgoalentity(level.player);
	level.miesha setgoalentity(level.player);
	level.boris setgoalentity(level.player);

	level notify("objective 1 complete");
	wait 0.25;
	level notify("objective 2 complete");
	wait 0.25;

	level notify("start objective 4"); // No using "objective 3 complete", as there is a delay between the 2.
	wait 0.25;
	level notify("start objective 5"); // No using "objective 4 complete", as there is a delay between the 2.
	wait 0.25;
	level notify("objective 5 complete");
	wait 0.25;
	level notify("objective 6 complete");
	wait 0.25;
	level notify("objective 7 complete");
//	wait 0.25;
//	level notify("objective 8 complete");

//	wait 5;
//	level thread event18_reinforcements();
}

event16()
{
	println("^1 --- event16():");
	level bombs(6, &"GMI_TRENCHES_OBJECTIVE6", "plant_tank_bomb_use");
	level notify("objective 6 complete");

	level.vassili thread anim_single_solo(level.vassili, "vass_goodwork");

	println("TANKS ARE TAKEN OUT!");

	exit_door2 = getent("exit_door2","targetname");
	exit_door2 rotateto((exit_door2.angles + (0,-90,0)), 1, 0, 0);
	exit_door2 connectpaths();

	exit_door3 = getent("exit_door3","targetname");
	exit_door3 rotateto((exit_door3.angles + (0,-80,0)), 1, 0, 0);
	exit_door3 connectpaths();

	friends = getentarray("friends","groupname");

	wait 3;
	commissar_node = getnode("event16_commissar","targetname");
	friend_nodes = getnodearray("event16_friends_spot","targetname");
	relay_node = getnode("event16_friend_relay","targetname");
	node_num = 0;
	level.objective7_count = 0;

	for(i=1;i<4;i++)
	{
		trigger = getent("event16_chain" + i + "_trigger","targetname");
		trigger delete();
	}

	level.player setfriendlychain(getnode("event16_chain","targetname"));
	level.antonov setgoalnode(getnode("commissar1_spot6a","targetname"));

	reinforcements = getentarray("reinforcements_allies_1","groupname");
	for(i=0;i<reinforcements.size;i++)
	{
		println("^5reinforcements_allies_1 spawned in!!!!");
		spawned = reinforcements[i] stalingradspawn();
		if(isdefined(spawned))
		{
			spawned.followmax = i + 3;
			spawned.followmin = i + 2;
			spawned.health = 2;
			spawned.accuracy = 0.1;
			spawned.groupname = "reinforcements_allies_1_ai";
			spawned.goalradius = 64;
			spawned setgoalentity(level.player);	
		}
	}
println("^5friends are assigned nodes!!!!");	
	for(i=0;i<friends.size;i++)
	{
		if(friends[i].targetname == "commissar1")
		{
			friends[i] setgoalnode(commissar_node);
		}
		else
		{
			friends[i] setgoalnode(relay_node);
			node = friend_nodes[node_num];
			friends[i] thread event16_friend_count(node);
			node_num++;
		}
	}
println("^5Waiting for friends to reach their nodes!!!!");
	level waittill("objective_7_speech");
println("^5friends reached their nodes!!!!");

	trigger_2 = getent("event16_player_trigger","targetname");
	trigger_2 waittill("trigger");

	level notify("objective 7 complete");
	maps\_utility_gmi::autosave(5);

println("^5run to village!!!!");
	level thread event16_run_to_village();

	// Converted dialog from level.vassili to level.commissar1.
	level.commissar1 thread anim_single_solo(level.commissar1,"getting_flanked");
	wait 7.2;

	level thread event16_antonov_movement();

	level.vassili.suppressionwait = 5;
	level.vassili.goalradius = 64;
	level.boris.suppressionwait = 5;
	level.boris.goalradius = 64;
	level.miesha.suppressionwait= 4;
	level.miesha.goalradius = 64;

	level.vassili setgoalentity(level.player);
	level.miesha setgoalentity(level.player);
	level.boris setgoalentity(level.player);
}

event16_antonov_movement()
{
	triggers = getentarray("trigger_friendlychain","classname");
	for(i=0;i<triggers.size;i++)
	{
		if(isdefined(triggers[i].script_noteworthy))
		{
			triggers[i] thread event16_antonov_movement_think();
		}
	}
}

event16_antonov_movement_think()
{
	if(self.script_noteworthy == "delete")
	{
		return;
	}

	while(1)
	{
		self waittill("trigger");
		node = getnode(self.script_noteworthy, "targetname");
		level.antonov.goalradius = 32;
		level.antonov setgoalnode(node);

		while(level.player istouching(self))
		{
			wait 0.5;
		}
	}
}

event16_friend_count(node)
{
	self waittill("goal");
	self setgoalnode(node);
	self waittill("goal");
	level.objective7_count++;
	if(level.objective7_count == 3)
	{
		level notify("objective_7_speech");
	}
}

event16_run_to_village()
{

	trigger0 = getent("event16_creek_start","targetname");
	trigger0 waittill("trigger");
	
	creek_axis_0 = getentarray("creek_axis_0","groupname");
	for(i=0;i<creek_axis_0.size;i++)
	{
		spawned = creek_axis_0[i] stalingradspawn(); // Forces spawn, even if player can see him.
	}

	level thread event16_spawn_mill_guys();

//	extra_guys = getentarray("right_flank_2_allies_ai","targetname");
//	for(i=0;i<extra_guys.size;i++)
//	{
//		extra_guys[i] setgoalentity(level.player);
//	}

	trigger1 = getent("event16_run_to_village1","targetname");
	trigger1 waittill("trigger");

	println("^6DIALOG: AMBUSH!!!!");

	level.vassili thread anim_single_solo(level.vassili, "vass_over_hill");

	creek_axis_1 = getentarray("creek_axis_1","groupname");
	for(i=0;i<creek_axis_1.size;i++)
	{
		spawned = creek_axis_1[i] stalingradspawn(); // Forces spawn, even if player can see him.
		if(isdefined(spawned) && isdefined(creek_axis_1[i].script_noteworthy) && creek_axis_1[i].script_noteworthy == "flamethrower")
		{
			spawned.goalradius = 32;
			spawned thread event16_flamethrower_tracker();
		}
	}

	trigger2 = getent("event16_tankguy","targetname");
	trigger2 waittill("trigger");
	
	creek_allies_1 = getentarray("creek_allies_1","groupname");
	for(i=0;i<creek_allies_1.size;i++)
	{
		if(isdefined(creek_allies_1[i].script_noteworthy) && creek_allies_1[i].script_noteworthy == "tankguy")
		{
			if(issentient(creek_allies_1[i]) && isalive(creek_allies_1[i]))
			{
//				tankguy = creek_allies_1[i];
//				tankguy.pacifist = false;
//				tankguy.ignoreme = false;
//				tankguy.animname = "tankguy";
//				tankguy anim_single_solo(tankguy,"help_me");
//				tankguy anim_single_solo(tankguy,"pinned_down");
			}
		}
	}

	// He's pinned down, drive them back!
	println("^6Vassili:He's pinned down, drive them back!");
	level.vassili thread anim_single_solo(level.vassili, "vass_pinned");

	level thread event17();

	trigger3 = getent("event16_tankguy_go","targetname");
	trigger3 waittill("trigger");

	tankguy_node = getnode("tankguy_node","targetname");
	if(isdefined(tankguy) && isalive(tankguy)) // Hopefully he's not dead.
	{
		tankguy setgoalnode(tankguy_node);
	}
}

event16_flamethrower_tracker()
{
	self endon("death");
	wait 10;
	self.ignoreme = false;	
}

event16_spawn_mill_guys()
{
	trigger = getent("spawn_mill_guys","targetname");
	trigger waittill("trigger");

	level.vassili thread animscripts\point::point(pos, false, "vass_mill", (-9152, -308, 160));
	level notify("event17 stop music");
	trigger delete();

	// Change Interior ambient for house
	level.ambient_track ["interior"] = "ambient_rain_combat_int";

	spawners = getentarray("mill_allies","groupname");
	for(i=0;i<spawners.size;i++)
	{
		spawned = spawners[i] dospawn();
		if(isdefined(spawners[i].script_noteworthy) && spawners[i].script_noteworthy == "commissar")
		{
			spawned.groupname = "mill_allies_commissar";
			spawned.pacifist = true;
			spawned.weapon = "luger";
			spawned.script_moveoverride = true;
			spawned.goalradius = 0;
			spawned settakedamage(false);
		}
		else
		{
			spawned.groupname = "mill_allies_ai";
			spawned.goalradius = 0;
		}
		if(isdefined(spawned))
		{
			spawned.dontavoidplayer = true;
		}
	}
}

event17()
{
	trigger1 = getent("event17_setup","targetname");
	trigger1 waittill("trigger");

	node = getnode("commissar1_spot13","targetname");
	level.antonov setgoalnode(node);

	level thread event17_area_check();

	maps\_utility_gmi::autosave(6);

	reinforcements = getentarray("reinforcements_allies_1_ai","groupname");
	friends = getentarray("friends","groupname");
	commissar1 = getent("commissar1","targetname");
	friends = maps\_utility_gmi::subtract_from_array(friends, commissar1);

	allies_group = add_array_to_array(reinforcements,friends);

	node = getnode("mill_spot_1","targetname");
	for(i=0;i<allies_group.size;i++)
	{
		if(issentient(allies_group[i]) && isalive(allies_group[i]))
		{
			allies_group[i] setgoalnode(node);
			allies_group[i] thread event17_mill_order();
		}
	}

	level thread event17_antonov_think();

	trigger2 = getent("event17_speech","targetname");
	trigger2 waittill("trigger");

	// Delete the guys in the creek
	creek_allies_1 = getentarray("creek_allies_1","groupname");
	for(i=0;i<creek_allies_1.size;i++)
	{
		creek_allies_1[i] delete();
	}

	level notify("objective 8 complete");

	village_friend_triggers = getentarray("village_friends_moveup","targetname");
	for(i=0;i<village_friend_triggers.size;i++)
	{
		village_friend_triggers[i] thread event17_friends_triggers();
	}

	level thread event17_friends_moveup(friends);

	// Give miesha the ppsh, so that it's easier for the player. May want to have him pick it up off a crate or somethin.
println("^2MIESHA NOW HAS PPSH!");
	level.miesha.weapon = "ppsh";

//	wait 3;

	mill_commissar_array = getentarray("mill_allies_commissar","groupname");

	for(i=0;i<mill_commissar_array.size;i++)
	{
		if(issentient(mill_commissar_array[i]) && isalive(mill_commissar_array[i]))
		{
			mill_commissar = mill_commissar_array[i];
		}
	}

	mill_commissar.animname = "mill_commissar";
	mill_commissar thread anim_single_solo(mill_commissar,"battle_speech");

	mill_commissar thread anim_loop_solo(mill_commissar, "battle_speech_loop", undefined,"stop_loop");
	wait 10.5;

	mill_door = getent("mill_door","targetname");
	mill_door.og_origin = mill_door.origin;

	mill_door_tag = spawn("script_model",mill_door.origin);
	mill_door_tag.origin = (-9178,-48,mill_door.origin[2]);
	mill_door_tag.angles = (0,-90,0);
	mill_door_tag setmodel("xmodel/trenches_mill_door");
	mill_door_tag.animname = "mill_door";
	mill_door_tag UseAnimTree(level.scr_animtree[mill_door_tag.animname]);

	mill_commissar notify("stop_loop");
	mill_commissar thread anim_single_solo(mill_commissar,"open_mill_door");

	mill_door linkto(mill_door_tag, "tag_door",(0,0,0), (0,180,0));
	mill_door_tag thread anim_single_solo(mill_door_tag,"open_mill_door");

//	mill_door moveto((mill_door.origin + (0,-96,0)),3,1,1);

	mill_door playsound ("barn_door_open");
//	mill_door waittill("movedone");
	mill_door_tag waittill("open_mill_door");
	mill_door connectpaths();
	mill_door thread mill_door_think();

	enemies = getentarray("village_axis_group1","groupname");
	for(i=0;i<enemies.size;i++)
	{
		if(issentient(enemies[i]))
		{
//			enemies[i] thread animscripts\combat_gmi::fireattarget((mill_commissar.origin + (0,0,64)),2);
		}
	}

	level notify("friends moveup");
	mill_commissar settakedamage(true);


	mill_group_nodes = getnodearray("mill_group_spot","targetname");
	mill_group = getentarray("mill_allies_ai","groupname");
	for(i=0;i<mill_group.size;i++)
	{
		if(issentient(mill_group[i]) && isalive(mill_group[i]))
		{
			mill_group[i] setgoalnode(mill_group_nodes[i]);
			mill_group[i].script_moveoverride = 1;
			mill_group[i].dontavoidplayer = false;
			//mill_group[i] thread event17_interval_setter();
		}
	}

	reinforcements_allies_1_mill_spot = getnodearray("reinforcements_allies_1_mill_spot","targetname");
	reinforcements_allies_1 = getentarray("reinforcements_allies_1_ai","groupname");
	for(i=0;i<reinforcements_allies_1.size;i++)
	{
		if(isSentient(reinforcements_allies_1[i]))
		{
			reinforcements_allies_1[i] setgoalnode(reinforcements_allies_1_mill_spot[i]);
			reinforcements_allies_1[i].script_moveoverride = 1;
			reinforcements_allies_1[i].dontavoidplayer = false;
			//reinforcements_allies_1[i] thread event17_interval_setter();
		}
	}

	mill_comm_node = getnode("commissar3_spot","targetname");
	if(isalive(mill_commissar))
	{
		mill_commissar setgoalnode(mill_comm_node);
		mill_commissar.script_moveoverride = 1;
	}

	// Sets inteval so guys can make it through door smoothly.
	allies = getaiarray("allies");
	for (i=0;i<allies.size;i++)
	{
		if (isalive(allies[i]))
		{
			allies[i] thread event17_interval_setter();
		}
	}

	level thread event18();

	wait 3;

	// Spawn in first group of enemies.
	axis_group1 = getentarray("village_axis_group1","groupname");
	for(i=0;i<axis_group1.size;i++)
	{
		spawned = axis_group1[i] dospawn();
	}
}

event17_interval_setter()
{
	self endon ("death");
	
	self.oldinterval = self.interval;
	self.interval = 0;
	wait 10;
	
	if (isalive(self))
	{
		self.interval = self.oldinterval;
	}
}

event17_antonov_think()
{
	trigger = getent("event17_speech","targetname");
	trigger waittill("trigger");

	level.mill_clip solid();
	node = getnode("commissar1_spot14","targetname");
	level.antonov.dontavoidplayer = true;
	level.antonov.goalradius = 0;
	level.antonov setgoalnode(node);
}

mill_door_think()
{
	trigger = getent("event17_close_mill_door","targetname");
	trigger waittill("trigger");

	self moveto((self.og_origin),3,1,1);
	self playsound ("barn_door_open");
	self disconnectpaths();
}

// Cleans up any buddies left behind, as the player exits the mill.
event17_area_check()
{
	trigger = getent("event17_mill_exit","targetname");
	trigger waittill("trigger");

	area_trigger = getent("event17_area_check","targetname");

	all_ai = getaiarray();

	for(i=0;i<all_ai.size;i++)
	{
		if(isalive(all_ai[i]))
		{
			if(all_ai[i] istouching(area_trigger))
			{
				continue;
			}
			else
			{
				all_ai[i] delete();
			}
		}
	}
}

// As the allies go through the mill_entrance, they pile in the mill in a orderly fashion.
event17_mill_order()
{
	trigger = getent("event17_mill_entrance","targetname");
	if(!isdefined(trigger.guy_counter))
	{
		trigger.guy_counter = 0;
	}

	while(1)
	{
		trigger waittill("trigger",guy);

		if(guy == self)
		{
			trigger.guy_counter++;
			node = getnode("mill_spot_" + trigger.guy_counter,"targetname");
			guy setgoalnode(node);
			break;
		}
	}
}

event17_friends_triggers()
{
	self waittill("trigger");
	level notify("friends moveup");
	self delete();
}

event17_friends_moveup(friends)
{
	num = 0;
	while(1)
	{
		level waittill("friends moveup");
		num++;
println("FRIENDS MOVE UP! NUM IS: ",num);
//		friends = getentarray("friends","groupname");
		nodes = getnodearray("village_friends_spot" + num,"targetname");
		for(i=0;i<friends.size;i++)
		{
			if(!isalive(friends[i]))
			{
				continue;
			}

			friends[i].dontavoidplayer = false;
			friends[i].goalradius = 64;
			friends[i] setgoalnode(nodes[i]);
		}
		if(num == 3)
		{
			reinforcements_allies_1_last_spot = getnodearray("reinforcements_allies_1_last_spot","targetname");
			reinforcements_allies_1 = getentarray("reinforcements_allies_1_ai","groupname");
			for(i=0;i<reinforcements_allies_1.size;i++)
			{
				if(isSentient(reinforcements_allies_1[i]))
				{
					reinforcements_allies_1[i] setgoalnode(reinforcements_allies_1_last_spot[i]);
					reinforcements_allies_1[i].script_moveoverride = 1;
				}
			}			
		}

		if(num == 4)
		{
			break;
		}
	}

	level thread event18_zone_setup();
}

event18() // Last Stand
{
	trigger = getent("event17_last_house","targetname");
	trigger waittill("trigger");

	wait 0.5;
	
	axis = getaiarray("axis");

	village_axis_group1 = getentarray("village_axis_group1","groupname");
	village_axis_group2 = getentarray("village_axis_group2","groupname");
	village_axis_group3 = getentarray("village_axis_group3","groupname");
	village_axis_group4 = getentarray("village_axis_group4","groupname");

	all_groups = add_array_to_array(village_axis_group1,village_axis_group2);
	all_groups = add_array_to_array(all_groups,village_axis_group3);
	all_groups = add_array_to_array(all_groups,village_axis_group4);

	final_guys = [];
	for(i=0;i<all_groups.size;i++)
	{
		if(issentient(all_groups[i]) && isalive(all_groups[i]))
		{
			final_guys = maps\_utility_gmi::add_to_array(final_guys,all_groups[i]);
		}
	}

	level.event18_ai_count = final_guys.size;

	// Was > 0, but sometimes the last enemy would be hard to find.
	while(level.event18_ai_count > 2)
	{
		println("Event18: Guys Remaining: ", level.event18_ai_count);
		final_guys = [];
		for(i=0;i<all_groups.size;i++)
		{
			if(issentient(all_groups[i]) && isalive(all_groups[i]))
			{
				final_guys = maps\_utility_gmi::add_to_array(final_guys,all_groups[i]);
			}
		}
		level.event18_ai_count = final_guys.size;
		wait 0.5;
	}

	level notify("objective 9 complete");

	level thread maps\_respawner_gmi::respawner_setup("last_battle_group",undefined, undefined, undefined, undefined, (level.player));
	level thread maps\_respawner_gmi::respawner_setup("last_battle_allies");

	path = getvehiclenode("last_battle_tank1","targetname");
	tank = spawnvehicle("xmodel/vehicle_tank_panzeriv","last_battle_tank1","panzeriv",path.origin,path.angles);
	tank thread maps\_panzerIV_gmi::init();
	tank.attachedpath = path;
	tank attachpath(path);
	tank startpath();
	tank thread event18_tank_think();
	tank thread event18_random_tank_targets();

	level thread event18_reinforcement_timer();
}

event18_zone_setup()
{
	wait 5;
	lower_house_zone = getent("lower_house_zone","targetname");
	lower_house_zone thread event18_zone_think();

	upper_house_zone = getent("upper_house_zone","targetname");
	upper_house_zone thread event18_zone_think();

	outside_zone_1 = getent("outside_zone_1","targetname");
	outside_zone_1 thread event18_zone_think();

	outside_zone_2 = getent("outside_zone_2","targetname");
	outside_zone_2 thread event18_zone_think();

	outside_zone_3 = getent("outside_zone_3","targetname");
	outside_zone_3 thread event18_zone_think();

	small_house_zone = getent("small_house_zone","targetname");
	small_house_zone thread event18_zone_think();

	mill_zone = getent("mill_zone","targetname");
	mill_zone thread event18_zone_think();
}

event18_zone_think()
{
	level endon("end_last_battle");

	friends = getentarray("friends","groupname");
	commissar1 = getent("commissar1","targetname");
	if(isdefined(commissar1))
	{
		friends = maps\_utility_gmi::subtract_from_array(friends, commissar1);
	}

	while(1)
	{
		self waittill("trigger");
		if(self.targetname == "lower_house_zone")
		{
			nodes = getnodearray("village_friends_spot4","targetname");
			for(i=0;i<friends.size;i++)
			{
				friends[i] setgoalnode(nodes[i]);
			}
		}
		else if(self.targetname == "upper_house_zone")
		{
			nodes = getnodearray("upper_house_spot1","targetname");
			for(i=0;i<friends.size;i++)
			{
				friends[i] setgoalnode(nodes[i]);
			}
		}
		else if(self.targetname == "outside_zone_1")
		{
			nodes = getnodearray("reinforcements_allies_1_last_spot","targetname");
			for(i=0;i<friends.size;i++)
			{
				friends[i] setgoalnode(nodes[i]);
			}
		}
		else if(self.targetname == "outside_zone_2")
		{
			nodes = getnodearray("outside_2_spots","targetname");
			for(i=0;i<friends.size;i++)
			{
				friends[i] setgoalnode(nodes[i]);
			}
		}
		else if(self.targetname == "outside_zone_3")
		{
			nodes = getnodearray("outside_3_spots","targetname");
			for(i=0;i<friends.size;i++)
			{
				friends[i] setgoalnode(nodes[i]);
			}
		}
		else if(self.targetname == "small_house_zone")
		{
			nodes = getnodearray("small_house_spots","targetname");
			specialnode = getnode("shared_small_house_spot","targetname");
			nodes = maps\_utility_gmi::add_to_array(nodes,specialnode);
			for(i=0;i<friends.size;i++)
			{
				friends[i] setgoalnode(nodes[i]);
			}

		}
		else if(self.targetname == "mill_zone")
		{
			nodes = getnodearray("village_friends_spot1","targetname");
			for(i=0;i<friends.size;i++)
			{
				friends[i] setgoalnode(nodes[i]);
			}
		}

		while(level.player istouching(self))
		{
			wait 0.25;
		}
	}
}

event18_reinforcements()
{
	// SPawn in the guys that will be attached to the tank.
	spawners = getentarray("event18_tank_riders","targetname");

	tank_riders = [];
	for(i=0;i<spawners.size;i++)
	{
		spawned = spawners[i] stalingradspawn();
		spawned waittill("finished spawning");
		if(isdefined(spawned))
		{
			if(isdefined(spawned.groupname) && spawned.groupname == "last_commissar")
			{
				continue;
			}
			tank_riders[tank_riders.size] = spawned;
		}
	}

	for(i=1;i<6;i++)
	{
		path = getvehiclenode(("event18_reinforcements_tank" + i),"targetname");
		tank = spawnvehicle("xmodel/v_rs_lnd_t34",("event18_tank" + i),"T34",path.origin,path.angles);
		if(i<3)
		{
			tank maps\_t34_gmi::init();
		}
		else
		{
			tank maps\_t34_gmi::init("no_turret");
		}

		if(i==5)
		{
			println("^5 TESTING!!! TANK 5!");
			tank5 = tank;
			level thread maps\_t34_gmi::attach_guys(tank, tank_riders, offset);
		}

		tank.num = i;
		tank.attachedpath = path;
		tank.health = 100000000;
		tank attachpath(path);
		tank startpath();
		tank thread event18_tank_think();
	}


	wait 10;

//	truck_path = getvehiclenode("truck_reinforcement","targetname");
//	truck = spawnvehicle("xmodel/v_rs_lnd_gazaaa","truck_reinforcement","RussianGazaaa",truck_path.origin,truck_path.angles);
//	truck.health = 500;
//	truck maps\_truck_gmi::init();
//	truck.script_vehiclegroup = 16;
//	truck thread maps\_truck_gmi::attach_guys();
//	truck attachpath(truck_path);
//	truck startpath();

	wait 1;

	allies = getaiarray("allies");
	for(i=0;i<allies.size;i++)
	{
		if(!isalive(allies[i]))
		{
			continue;
		}

		if(isdefined(allies[i].script_vehiclegroup) && allies[i].script_vehiclegroup == 16)
		{
			allies[i] allowedstances("stand");
			allies[i].pacifist = 1;
			allies[i].pacifistwait = 0;
		}
	}	

	commissar = getentarray("last_commissar","groupname");
	for(i=0;i<commissar.size;i++)
	{
		if(issentient(commissar[i]))
		{
			commissar[i] allowedstances("stand");
			commissar[i].pacifist = 1;
			commissar[i].pacifistwait = 0;
			commissar[i] animscripts\shared::PutGunInHand("none");
			commissar[i] thread maps\_utility_gmi::magic_bullet_shield();
			commissar[i].goalradius = 0;
			commissar[i] thread event18_commissar_think();
			the_commissar = commissar[i];
			level.last_commissar = commissar[i];
		}
	}

//	truck waittill("reached_end_node");
	tank5 waittill("reached_end_node");

//	println("^2Last tank5 Angles: ",truck.angles);
//	println("^2Last tank5 Origin: ",truck.origin);
//	truck notify("unload");
//	truck disconnectpaths();

	tank5 notify("unload");
	tank5 disconnectpaths();

	for(i=0;i<allies.size;i++)
	{
		if(!isalive(allies[i]))
		{
			continue;
		}

		if(isdefined(allies[i].script_vehiclegroup) && allies[i].script_vehiclegroup == 16)
		{
			allies[i] allowedstances("stand","crouch","prone");
			allies[i].pacifist = 0;
			allies[i].pacifistwait = 1;
		}
	}	

//	wait 4;
//	the_commissar.animname = "last_commissar";
//	the_commissar thread anim_single_solo(the_commissar,"comm_assemble");
}

event18_commissar_think()
{
	level thread event18_commissar_counter();

	self.animname = "last_commissar";
	self settakedamage(false);
	self.pacifist = true;
	self.pacifistwait = 0;
	self.dontavoidplayer = true;

	tank = getent("event18_tank5","targetname");
	self linkto(tank,"tag_origin",(0,0,0),(0,0,0));
	wait 0.1;
	self thread anim_loop_solo(self, "ride_loop", "tag_origin", "stop_anim", undefined, tank);
	tank waittill("reached_end_node");
	level notify("objective 10 complete");

	wait 4;
	self notify("stop_anim");
	self anim_single_solo(self, "stop_trans", "tag_origin", undefined, tank);
	self thread anim_loop_solo(self, "wait_loop", "tag_origin", "stop_anim", undefined, tank);

//	self thread anim_single_solo(self, "comm_assemble", "tag_origin", undefined, tank);

	self animscripts\face::SaySpecificDialogue(level.scr_face[self.animname]["comm_assemble"], level.scrsound[self.animname]["comm_assemble"], 1.0);

	if(!level.flag["event18_victory_counter"])
	{
		level waittill("begin_victory_speech");
	}

	trigger = getent("event18_victory_speech","targetname");
	trigger waittill("trigger");
	level notify("objective 11 complete");

	self notify("stop_anim");
	self thread anim_single_solo(self, "victory_speech", "tag_origin", undefined, tank);

	wait 23;

	if(isalive(level.player))
	{
//		missionSuccess("gamefinished", false);
		missionSuccess("ponyri", false);
	}
}

event18_commissar_counter()
{
	both = [];
	allies = getaiarray("allies");

	for(i=0;i<allies.size;i++)
	{
		if(!isalive(allies[i]))
		{
			continue;
		}

		if(isdefined(allies[i].groupname))
		{
			if(allies[i].groupname == "friends" || allies[i].groupname == "last_battle_allies")
			{
				if(allies[i] == level.antonov)
				{
					continue;
				}
				both[both.size] = allies[i];
			}
		}
	}

	level.event18_victory_counter = 0;
	last_nodes = getnodearray("event18_last_spot","targetname");
	for(i=0;i<both.size;i++)
	{
		both[i] thread maps\_utility_gmi::magic_bullet_shield();
		both[i] setgoalnode(last_nodes[i]);
		both[i].maxsightdistsqrd = 3000; // Set sight really low so they don't fire while waiting.
		both[i].goalradius = 32;

		if(isdefined(both[i].targetname))
		{
			if(both[i].targetname == "vassili" || both[i].targetname == "miesha" || both[i].targetname == "boris")
			{
				both[i] thread event18_victory_line_up(3);
			}
		}
	}

	level.antonov setgoalnode(getnode("commissar1_spot15","targetname"));
}

event18_victory_line_up(amount)
{
	self waittill("goal");
	level.event18_victory_counter++;

	println("Level Event18 Counter: ",level.event18_victory_counter," Amount needed: ",amount);

	if(level.event18_victory_counter == amount)
	{
		level notify("begin_victory_speech");
		level.flag["event18_victory_counter"] = true;
	}
}

event18_tank_think()
{
	self endon("death");

	if(!isdefined(self.attachedpath))
	{
		println("^1NO '.ATTACHEDPATH' FOUND FOR TANK, ",self.targetname);
		return;
	}
	pathstart = self.attachedpath;

	pathpoint = pathstart;
	arraycount = 0;
	while(isdefined (pathpoint))
	{
		pathpoints[arraycount] = pathpoint;
		arraycount++;
		if(isdefined (pathpoint.target))
		{
			pathpoint = getvehiclenode(pathpoint.target, "targetname");

		}
		else
		{
			break;
		}
	}

	pathpoint = pathstart;
	for(i=0;i<pathpoints.size;i++)
	{
		if(isdefined(pathpoints[i].script_noteworthy))
		{
			self setWaitNode(pathpoints[i]);
			self waittill ("reached_wait_node");

			if (pathpoints[i].script_noteworthy == "start_firing")
			{
				if(self.num == 1 || self.num == 5)
				{
					self maps\_tank_gmi::queadd(getent("last_battle_tank1","targetname"));
					self maps\_tank_gmi::queadd(getent("last_battle_tank2","targetname"));
					self maps\_tank_gmi::queadd(getent("last_battle_tank3","targetname"));
				}
				else if(self.num == 3)
				{
					self maps\_tank_gmi::queadd(getent("last_battle_tank2","targetname"));
					self maps\_tank_gmi::queadd(getent("last_battle_tank1","targetname"));
					self maps\_tank_gmi::queadd(getent("last_battle_tank3","targetname"));
				}
				else
				{
					self maps\_tank_gmi::queadd(getent("last_battle_tank3","targetname"));
					self maps\_tank_gmi::queadd(getent("last_battle_tank2","targetname"));
					self maps\_tank_gmi::queadd(getent("last_battle_tank1","targetname"));
				}

				axis_ai = getentarray("last_battle_group","targetname");
				for(q=0;q<axis_ai.size;q++)
				{
					if(issentient(axis_ai[q]))
					{
						self maps\_tank_gmi::queadd(axis_ai[q]);
					}
				}
			}

			if (pathpoints[i].script_noteworthy == "retreat_point")
			{
				// Second parameter, 10000, is accel (like rate it will accel at) in speed, not time.
				self setspeed (0, 10000); 
				level waittill("event18 tanks retreat");
				self resumespeed (10000);
			}
		}
	}
}

event18_reinforcement_timer()
{
	if(getcvar("quick_end") == 1)
	{
		time = 1;
	}
	else
	{
		time = 2; // Minutes
	}
	
	// Setup the HUD display of the timer.
	level.hudTimerIndex = 20;
	level.last_battle_timer = newHudElem();
	level.last_battle_timer.alignX = "left";
	level.last_battle_timer.alignY = "middle";
	level.last_battle_timer.x = 460;
	level.last_battle_timer.y = 100;
	level.last_battle_timer.label = &"GMI_TRENCHES_REINFORCEMENTS";
	level.last_battle_timer setTimer(time*60);
	
	time_seconds = time*60;
	boris_time = time_seconds * 0.75;

	enemy_tanks_time = time_seconds * 0.5;
	enemy_tanks_check = false;

	boris_num = 0;
	while(time_seconds > 0)
	{
		wait 1;
		time_seconds--;
		if(time_seconds < enemy_tanks_time && !enemy_tanks_check)
		{
			enemy_tanks_check = true;
			println("^1ENEMY TANKS!");
			println("^1ENEMY TANKS!");
			println("^1ENEMY TANKS!");
			println("^1ENEMY TANKS!");
			level thread event18_enemy_tanks();
		}

		if(time_seconds == 30) // Reinforcements
		{
			println("^1REINFORCMENTS!!!");
			println("^1REINFORCMENTS!!!");
			println("^1REINFORCMENTS!!!");
			println("^1REINFORCMENTS!!!");
			level thread event18_reinforcements();
		}

		if(time_seconds == 15)
		{
			level notify("event18 music");
		}
//		println("TIMER: ",time_seconds);
	}

	level thread anon_troop_dialogue(true, trooper, "anon_tankshere", delay);
	
	level thread event18_end_last_battle();

	level.last_battle_timer destroy();

	respawners = getentarray("last_battle_group","groupname");
	for(i=0;i<respawners.size;i++)
	{
		respawners[i] notify("stop respawning");
	}

	level notify("event18 tanks retreat");

	for(i=1;i<4;i++)
	{
		tank = getent(("last_battle_tank" + i),"targetname");
		tank thread maps\_tankgun_gmi::mgoff();
	}

	println("^6Boris: Reinforcements are here! YIPPIE!");
//	level.boris thread anim_single_solo(level.boris,"reinforcements_are_here");
	
}

event18_end_last_battle()
{
	level notify("end_last_battle");

	wait 10;

	node = getnode("event18_retreat_node","targetname");
	axis = getentarray("last_battle_group","groupname");
	for(i=0;i<axis.size;i++)
	{
		if(issentient(axis[i]))
		{
			axis[i].goalradius = 32;
			axis[i].pacifist = 1;
			axis[i].pacifistwait = 0;
			axis[i] setgoalnode(node);
			axis[i] thread event18_retreat_think();
			wait (1 + randomfloat(1));
		}
	}
}

event18_retreat_think()
{
	self endon("death");
	self waittill("goal");
	self delete();
}

event18_enemy_tanks()
{
	for(i=2;i<4;i++)
	{
		path = getvehiclenode(("last_battle_tank" + i),"targetname");
		tank = spawnvehicle("xmodel/vehicle_tank_panzeriv",("last_battle_tank" + i),"panzeriv",path.origin,path.angles);
		tank thread maps\_panzerIV_gmi::init();
		tank.blow_bridge = false;
		tank.attachedpath = path;
		tank attachpath(path);
		tank startpath();
		tank thread event18_tank_think();
		tank thread event18_random_tank_targets();
		wait (2 + randomint(3));
	}
}

event18_random_tank_targets()
{
	self endon ("death");

	while(1)
	{
		if(self.targetname == "last_battle_tank1")
		{
			target_pos[0] = (level.player.origin + (0,0,64));
			target_pos[1] = (-7488, -320, 128);
			target_pos[2] = (-7104, 576, 136);
			target_pos[3] = (-8360, 344, 164);
			target_pos[4] = (-6944, 736, 136);
		}
		else if(self.targetname == "last_battle_tank2")
		{
			target_pos[0] = (level.player.origin + (0,0,64));
			target_pos[1] = (-8648, 552, 144);
			target_pos[2] = (-8042, -282, 102);
		}
		else if(self.targetname == "last_battle_tank3")
		{
			target_pos[0] = (level.player.origin + (0,0,64));
			target_pos[1] = (-9328, 24, 192);
			target_pos[2] = (-8927, -112, 106);
			target_pos[3] = (-9103, 320, 124);
		}

		allies = getaiarray("allies");
		for(i=0;i<allies.size;i++)
		{
			if(isalive(allies[i]))
			{
				target_pos[target_pos.size] = allies[i].origin + (0,0,64);
			}
		}

		fired = false;
	
		while(!fired)
		{
			random_num = randomint(target_pos.size);
			
//			dist = distance(self.origin + (0,0,128), random_targ);

			trace_result = bulletTrace((self.origin + (0,0,128)), target_pos[random_num], true, undefined);
//			dist2 = distance(self.origin + (0,0,128), trace_result["position"]);

			if(distance(target_pos[random_num], trace_result["position"]) < 256)
			{
				self setTurretTargetVec(target_pos[random_num]);
				self waittill("turret_on_target");
				wait 2;
				self FireTurret();
				fired = true;
			}
			wait 0.25;
		}

		wait (5 + randomfloat(7));
	}
}

// ======================================================== //
//              None Event Related Section                  //
// ======================================================== //

add_array_to_array(array1, array2)
{
	if(!isdefined(array1) || !isdefined(array2))
	{
		println("^3(ADD_ARRAY_TO_ARRAY)WARNING! WARNING!, ONE OF THE ARRAYS ARE NOT DEFINED");
		return;
	}

	array = array1;

	for(i=0;i<array2.size;i++)
	{
		array[array.size] = array2[i];
	}
	return array;
}

random_wind()
{
	level endon ("random wind off");

	if(!isdefined(check))
	{
		level thread random_wind_think();
		check = true;
	}

	old_angles = (0,0,0);
	while(1)
	{
		angles = ((-10 + randomint(20)),(-180 + randomint(180)),(-10 + randomint(20)));
		strength = (50 + randomint(30));

		difference = (angles[1] - old_angles[1]);
		loop_angles = angles;

		if(difference < 0)
		{
			for(i=0;i>difference;i--)
			{
				angles = (loop_angles[0], (old_angles[1] + i), loop_angles[2]);
				setwind(angles, strength);			
				wait 0.25;
			}
		}
		else
		{
			for(i=0;i<difference;i++)
			{
				angles = (loop_angles[0], (old_angles[1] + i), loop_angles[2]);
				setwind(angles, strength);			
				wait 0.25;
			}
		}

		old_angles = angles;
		wait (7 + randomfloat(15));
	}
}

random_wind_think()
{
	while(1)
	{
		level waittill("random wind off");
		println("^3Wind OFF");

		level waittill("random wind on");
		println("^3Wind ON");
		level thread random_wind();
	}
	
}

random_distant_light()
{
	pos[0] = (5376,4040,296);
	pos[1] = (5368,2896,424);
	pos[2] = (6912,2104,480);
	pos[3] = (8448,1344,608);
	pos[4] = (9208,576,568);
	pos[5] = (9992,-184,552);
	pos[6] = (9976,-960,592);
	pos[7] = (9216,1344,568);
	pos[8] = (8168,1540,568);
	pos[9] = (6672,1992,568);

	for(i=0;i<pos.size;i++)
	{
		pos_org = spawn("script_origin",(pos[i]));
		pos_org thread random_distant_light_think();
	}
}

random_distant_light_think(event1, delay, count)
{
	if(isdefined(event1))
	{
		level endon ("stop event1 distant lights");
	}
	else
	{
		level endon ("stop falling mortars");
	}

	while(1)
	{
		if(isdefined(delay))
		{
			wait (0.25 + randomfloat(delay));
		}
		else
		{
			wait randomfloat(level.mortar_random_delay);
		}

		chance = 3;
		chance_num = randomint(chance);
		if(chance_num == 0)
		{
			dist = distance(self.origin, level.player.origin);
			if(dist < 10000)
			{
				self playsound("shell_flash");
			}
		}

		playfx(level._effect["distant_artillery"],self.origin);

		if(isdefined(count))
		{
			count--;
			if(count == 0)
			{
				break;
			}
		}

	}
}

#using_animtree ("stuka");
random_high_alt_formations()
{
	alt = 6000;
	boundary[0] = -32000; // East
	boundary[1] = 20000; // West
	boundary[2] = 20000; // North
	boundary[3] = -20000; // South

//Time = Distance / Speed
//
//Distance = Time * Speed
//
//Speed = Distance / Time

	level.high_alt_groups = 3;
	if(getcvar("lot_o_planes") == "1")
	{
		delay_time = 0.05; //BIRDS, The movie SETTING
	}
	else
	{
		if(getcvarint("scr_gmi_fast") > 0)
		{
			if(getcvarint("scr_gmi_fast") < 2)
			{
				level.high_alt_groups = 2;
				delay_time = 22;
			}
			else
			{
				level.high_alt_groups = 1;
				delay_time = 30;
			}
		}
		else
		{
			delay_time  = 15;
		}
	}

	wait (delay_time + randomfloat(10));

//	level.high_alt_groups = 100; // Birds, The movie Setting.
	lots_of_planes = false;
	while(1)
	{
		switch(randomint(4))
		{
			case 0: x_start = -32000;
				x_end = 20000;
				y_start = (randomint(40000) - 20000);
				y_end = (randomint(40000) - 20000);
				break;
	
			case 1: x_start = 20000;
				x_end = -32000;
				y_start = (randomint(40000) - 20000);
				y_end = (randomint(40000) - 20000);
				break;
	
			case 2: x_start = (randomint(52000) - 32000);
				x_end = (randomint(52000) - 32000);
				y_start = 20000;
				y_end = -20000;
				break;
	
			case 3: x_start = (randomint(52000) - 32000);
				x_end = (randomint(52000) - 32000);
				y_start = -20000;
				y_end = 20000;
				break;
		}

		if(getcvar("lot_o_planes") == "1")
		{
			alt = 1000 + (randomint(8000));
			speed = (1000  + randomint(1750));
		}
		else
		{
			alt = 4000 + (randomint(5000));
			speed = (2000  + randomint(750));
		}
	
		startpos = (x_start,y_start,alt);
		endpos = (x_end, y_end, alt);
	
		dist = distance(startpos,endpos);
	
//		println("^5Random Plane Start Pos: ",startpos);
//		println("^5Random Plane End Pos: ",endpos);
	
//		plane = spawn("script_model", startpos);
		// Fixes the sound. Guess the plane had to in the player's pvs to play.
		plane = spawn("script_model", level.player.origin); 
		time = (dist / speed);
		plane thread high_alt_plane_sound(time);
		plane moveto(startpos,0.25,0,0);
		plane waittill("movedone");
		plane setmodel("xmodel/vehicle_plane_stuka");
		plane UseAnimTree(#animtree);
		plane setanim(%stuka_pose);

		r_mult = 1;
		l_mult = 1;

		num_of_planes = (1 + randomint(4));
		for(i=0;i<num_of_planes;i++)
		{
			if(!isdefined(side))
			{
				side = "right";
			}

			if(side == "right")
			{
				side = "left";
				spawn_pos = (startpos + (((-320*r_mult) + (-100 + randomint(100))),((696*r_mult) + (-100 + randomint(100))),0));
				r_mult++;
			}
			else
			{
				side = "right";
				spawn_pos = (startpos + (((-320*l_mult) + (-100 + randomint(100))),((-696*l_mult) + (-100 + randomint(100))),0));
				l_mult++;
			}

//			if(i==0)
//			{
//				spawn_pos = (startpos + (-552,696,0));
//			}
//			else if(i==1)
//			{
//				spawn_pos = (startpos + (-320,-952,0));
//			}
//			else if(i==2)
//			{
//				spawn_pos = (startpos + (-1096,1256,0));
//			}
//			else if(i==3)
//			{
//				spawn_pos = (startpos + (-768,-1648,0));
//			}
			plane.group[i] = spawn("script_model", spawn_pos);
			plane.group[i] setmodel("xmodel/vehicle_plane_stuka");
			plane.group[i] UseAnimTree(#animtree);
			plane.group[i] setanim(%stuka_pose);
			plane.group[i] linkto(plane);
		}
//		wait 0.05;
		plane.angles = vectortoangles (endpos - startpos);
		plane moveto(endpos, time, 0, 0);
		plane thread high_alt_plane_think(startpos,endpos,time);


		level.high_alt_groups--;
		println("HIGH ALT GROUPS : ",level.high_alt_groups);


		if(getcvar("lot_o_planes") == "1")
		{
			if(!lots_of_planes)
			{
				lots_of_planes = true;
				level.high_alt_groups = 100;
			}
			wait 0.05; //BIRDS, The movie SETTING
		}
		else
		{
			lots_of_planes = false;
			wait (delay_time + randomint(10));
		}

		while(level.high_alt_groups <= 0)
		{
			wait 1;
		}
	}
}

high_alt_plane_sound(time)
{
	self endon("death");

	sound[0] = "squadron_flyover_01"; // 30.998; // squadron_flyover01.wav
	sound[1] = "squadron_flyover_02"; // 26.860; // squadron_flyover02.wav
	sound[2] = "squadron_flyover_03"; // 25.031; // squadron_flyover03.wav
	sound[3] = "squadron_flyover_04"; // 26.860; // squadron_flyover04.wav

	sound_short[0] = "squadron_flyover_01_short"; // 24.868; // squadron_flyover01_short.wav
	sound_short[1] = "squadron_flyover_02_short"; // 18.668; // squadron_flyover02_short.wav
	sound_short[2] = "squadron_flyover_03_short"; // 16.811; // squadron_flyover03_short.wav
	sound_short[3] = "squadron_flyover_04_short"; // 19.342; // squadron_flyover04_short.wav

	num = randomint(4);
	if(time > 20.5)
	{
//		println("^3Playing HIGHT ALT SOUND (LONG) Num = ", num ," Sound ",sound[num]);
		self playsound(sound[num]);		
	}
	else
	{
//		println("^3Playing HIGHT ALT SOUND (SHORT) Num = ", num);
		self playsound(sound_short[num]);
	}
}

high_alt_plane_think(startpos,endpos,time)
{
	self waittill("movedone");
	if(isdefined(self.group))
	{
		for(i=0;i<self.group.size;i++)
		{
			self.group[i] delete();
		}
	}
	level.high_alt_groups++;
	self delete();

}

#using_animtree ("generic_human");
test()
{
	friends = getentarray("friends","groupname");
	println("^3=============================");
	println("^3FRIENDS PROFILE/SETTINGS");
	println("^3=============================");
	for(i=0;i<friends.size;i++)
	{
		println("");
		println("^5Start ",friends[i].targetname,"^5 profile");
		println(friends[i].targetname," accuracy ", friends[i].accuracy);
		println(friends[i].targetname," accuracystationarymod ", friends[i].accuracystationarymod);
		println(friends[i].targetname," lookforward ", friends[i].lookforward);
		println(friends[i].targetname," lookright ", friends[i].lookright);
		println(friends[i].targetname," lookup ", friends[i].lookup);
		println(friends[i].targetname," fovcosine ", friends[i].fovcosine);
		println(friends[i].targetname," maxsightdistsqrd ", friends[i].maxsightdistsqrd);
		println(friends[i].targetname," visibilitythreshold ", friends[i].visibilitythreshold);
		println(friends[i].targetname," defaultsightlatency ", friends[i].defaultsightlatency);
		println(friends[i].targetname," followmin ", friends[i].followmin);
		println(friends[i].targetname," followmax ", friends[i].followmax);
		println(friends[i].targetname," chainfallback ", friends[i].chainfallback);
		println(friends[i].targetname," interval ", friends[i].interval);
		println(friends[i].targetname," personalspace ", friends[i].personalspace);
		println(friends[i].targetname," damagetaken ", friends[i].damagetaken);
		println(friends[i].targetname," damagedir ", friends[i].damagedir);
		println(friends[i].targetname," damageyaw ", friends[i].damageyaw);
		println(friends[i].targetname," damagelocation ", friends[i].damagelocation);
		println(friends[i].targetname," proneok ", friends[i].proneok);
		println(friends[i].targetname," walkdist ", friends[i].walkdist);
		println(friends[i].targetname," desiredangle ", friends[i].desiredangle);
		println(friends[i].targetname," bravery ", friends[i].bravery);
		println(friends[i].targetname," pacifist ", friends[i].pacifist);
		println(friends[i].targetname," pacifistwait ", friends[i].pacifistwait);
		println(friends[i].targetname," suppressionwait ", friends[i].suppressionwait);
		println(friends[i].targetname," name ", friends[i].name);
		println(friends[i].targetname," weapon ", friends[i].weapon);
		println(friends[i].targetname," dontavoidplayer ", friends[i].dontavoidplayer);
		println(friends[i].targetname," grenadeawareness ", friends[i].grenadeawareness);
		println(friends[i].targetname," grenade ", friends[i].grenade);
		println(friends[i].targetname," grenadeweapon ", friends[i].grenadeweapon);
		println(friends[i].targetname," grenadeammo ", friends[i].grenadeammo);
		println(friends[i].targetname," favoriteenemy ", friends[i].favoriteenemy);
		println(friends[i].targetname," allowdeath ", friends[i].allowdeath);
		println(friends[i].targetname," useable ", friends[i].useable);
		println(friends[i].targetname," goalradiusonly ", friends[i].goalradiusonly);
		println(friends[i].targetname," dropweapon ", friends[i].dropweapon);
		println(friends[i].targetname," drawoncompass ", friends[i].drawoncompass);
		println(friends[i].targetname," scriptstate ", friends[i].scriptstate);
		println(friends[i].targetname," lastscriptstate ", friends[i].lastscriptstate);
		println(friends[i].targetname," statechangereason ", friends[i].statechangereason);
		println(friends[i].targetname," groundtype ", friends[i].groundtype);
		println(friends[i].targetname," anim_pose ", friends[i].anim_pose);
		println("^5End ",friends[i].targetname,"^5 Profile");
	}
	println("^3==============================");
}

// **********START INSTANT MORTAR SECTION********** Probably should incorporate this into _mortar.gsc
instant_mortar (range, max_damage, min_damage, fQuakepower, iQuaketime, iQuakeradius)
{
	ceiling_dust = getentarray("ceiling_dust","targetname");
	for(i=0;i<ceiling_dust.size;i++)
	{
		if(distance(self.origin, ceiling_dust[i].origin) < 512)
		{
			playfx ( level._effect["ceiling_dust"], ceiling_dust[i].origin );
			ceiling_dust[i] playsound ("dirt_fall");
		}
	}
	instant_incoming_sound();

	level notify ("mortar");
	self notify ("mortar");

	if (!isdefined (range))
	{
		range = 256;
	}
	if (!isdefined (max_damage))
	{
		max_damage = 400;
	}
	if (!isdefined (min_damage))
	{
		min_damage = 25;
	}

	radiusDamage ( self.origin, range, max_damage, min_damage);

	if(isdefined(level.dummy_count) && level.dummy_count > 1 && range != 0)
	{
		dummies = getentarray("dummy","targetname");
		for(i=0;i<dummies.size;i++)
		{
			if(range <= 256)
			{
				range = 512;
			}
			if(distance(self.origin,dummies[i].origin) < (range * 1.5))
			{
				dummies[i] notify("explosion death");
			}
		}
	}

	if ((isdefined(self.has_terrain) && self.has_terrain == true) && (isdefined (self.terrain)))
	{
		for (i=0;i<self.terrain.size;i++)
		{
			if (isdefined (self.terrain[i]))
				self.terrain[i] delete();
		}
	}
	
	if (isdefined (self.hidden_terrain) )
	{
		self.hidden_terrain show();
	}
	self.has_terrain = false;
	
	instant_mortar_boom( self.origin, fQuakepower, iQuaketime, iQuakeradius );
}

instant_mortar_trigger()
{
	trigger = getent(self.targetname,"target");
	trigger waittill("trigger");
	println("Instant Mortar Trigger");
	self instant_mortar();
}

instant_mortar_boom (origin, fPower, iTime, iRadius)
{
	if(isdefined(level.mortar_quake))
	{
		fpower = level.mortar_quake;
	}
	else
	{ 
		if(!isdefined(fPower))
		{
			fPower = 0.15;
		}
	}

	if (!isdefined(iTime))
	{
		iTime = 2;
	}
	if (!isdefined(iRadius))
	{
		iRadius = 850;
	}

	instant_mortar_sound();
	playfx ( level.mortar, origin );
	earthquake(fPower, iTime, origin, iRadius);
}

instant_mortar_sound()
{
	if (!isdefined (level.mortar_last_sound))
	{
		level.mortar_last_sound = -1;
	}

	soundnum = 0;
	while (soundnum == level.mortar_last_sound)
	{
		soundnum = randomint(3) + 1;
	}

	level.mortar_last_sound	= soundnum;

	if (soundnum == 1)
	{
		self playsound ("mortar_explosion1");
	}
	else if (soundnum == 2)
	{
		self playsound ("mortar_explosion2");
	}
	else
	{
		self playsound ("mortar_explosion3");
	}
}

instant_incoming_sound(soundnum)
{
	if (!isdefined (soundnum))
	{
		soundnum = randomint(3) + 1;
	}

	if (soundnum == 1)
	{
		self playsound ("mortar_incoming1");
		if(isdefined(self.sound_delay))
		{
			wait (self.sound_delay);
		}
	}
	else
	if (soundnum == 2)
	{
		self playsound ("mortar_incoming2");
		if(isdefined(self.sound_delay))
		{
			wait (self.sound_delay);
		}
	}
	else
	{
		self playsound ("mortar_incoming3");
		if(isdefined(self.sound_delay))
		{
			wait (self.sound_delay);
		}
	}
}
// **********END INSTANT MORTAR SECTION**********

respawner_trigger(trigger)
{
	trigger endon("stop respawning");

	respawner = getentarray(trigger.groupname,"groupname");
	
	if(isdefined(trigger.script_noteworthy) && trigger.script_noteworthy == "group")
	{
		trigger.spawn_num = (respawner.size - 1);
	}

	trigger waittill("trigger");

	if(isdefined(trigger.script_waittill))
	{
		trigger waittill(trigger.script_waittill);
	}

	for(i=0;i<respawner.size;i++)
	{
		if(respawner[i].classname == "trigger_multiple")
		{
			continue;
		}
		respawner[i] thread respawner_think(trigger);
	}
}

respawner_think(trigger)
{
	trigger endon("stop respawning");

	count = self.count;
	trigger.dead_num = 0;
	while( self.count > 0 )
	{
		if(isdefined(self.script_delay))
		{
			wait self.script_delay;
		}
		else
		{
			wait 2;
		}
		spawned = self dospawn();

		if(isdefined(spawned))
		{
			self.count = 0;
			println(self.targetname," has spawned. ", self.classname);
			spawned waittill ("death");
			if(!isdefined(trigger.script_noteworthy))
			{
				self.count = count;
			}

			if(self.count == 0 && trigger.script_noteworthy == "group")
			{
				trigger.dead_num++;
				if(trigger.dead_num == trigger.spawn_num)
				{
					trigger notify("group_dead");
				}
				else
				{
					trigger waittill("group_dead");
				}
				trigger.dead_num = 0;
				self.count = count;
			}
			println(self.targetname," has spawned.");
		}


	}
}

self_respawner_setup(groupname, group, wait_till, starting_health, accuracy, num_of_respawns, sightdist, bravery)
{
	respawn_manager = spawn("script_origin",(0,0,0));
	respawner = getentarray(groupname,"groupname");
	respawn_manager.groupname = groupname;

	respawn_manager endon("stop respawning");
	
	if(isdefined(group))
	{
		respawn_manager.script_noteworthy = group;
		respawn_manager.spawn_num = (respawner.size);
		println(respawn_manager.script_noteworthy);
		println("^3GROUP SIZE IS ",respawn_manager.spawn_num);
	}

	if(isdefined(wait_till))
	{
		level waittill(wait_till);
	}

	println("^3Number of Respawners :",respawner.size);
	for(i=0;i<respawner.size;i++)
	{
		respawner[i] thread self_respawner_think(respawn_manager, starting_health, accuracy, num_of_respawns, sightdist, bravery);
	}
}

self_respawner_think(respawn_manager, starting_health, accuracy, num_of_respawns, sightdist, bravery)
{
	respawn_manager endon("stop respawning");

	count = self.count;
	respawn_manager.dead_num = 0;
	respawn_manager.guys_alive = 0;
	if(isdefined(num_of_respawns))
	{
		println("^3NUMBER OF SPAWNS 1 ",num_of_respawns);
		respawn_manager.num_of_respawns = num_of_respawns;
	}

	while( self.count > 0 )
	{
		if(isdefined(self.script_delay))
		{
			wait (self.script_delay + randomfloat(self.script_delay));
		}
		else
		{
			wait (randomfloat (2));
		}

		spawned = self dospawn();
		wait 0.05;

		if(isdefined(spawned))
		{
			respawn_manager.guys_alive++;
			self.count--;
			if(isdefined(sightdist))
			{
				spawned.maxsightdistsqrd = sightdist;
			}
			if(isdefined(respawn_manager.num_of_respawns))
			{
println("^3Number of respawns: ",respawn_manager.num_of_respawns);
				respawn_manager.num_of_respawns--;
				if(respawn_manager.num_of_respawns <= 0)
				{
					respawn_manager notify("stop respawning");
				}
			}

			if(isdefined(accuracy))
			{
				spawned.accuracy = accuracy;
			}

			if(isdefined(self.script_accuracy))
			{
				spawned.accuracy = self.script_accuracy;
			}

			if(isdefined(bravery))
			{
				spawned.bravery = bravery;
			}

			if(self.groupname == "mg42_fun") // Hack for MG42 Fun. Temp, since this is getting re-written.
			{
				spawned.goalradius = 32;
				spawned.favoritenemy = level.player;
				spawned setgoalentity(level.player);
			}

println("Bravery ",spawned.bravery);
println("GoalRadius ",spawned.goalradius);

			if(isdefined(starting_health))
			{
				spawned.health = starting_health;
			}
			spawned.targetname = (self.groupname + "_ai");

			if(isdefined(self.target) && self.groupname != "mg42_fun")
			{
				nodes = getnodearray(self.target,"targetname");
				if(nodes.size > 1)
				{
					num = randomint(nodes.size);
					spawned.goalradius = 32;
					spawned thread follow_nodes(nodes[num]);
				}
			}
println(spawned.targetname," has spawned. ", spawned.classname, " ", spawned.groupname);			
			spawned waittill ("death");
			respawn_manager.guys_alive--;

			if(isdefined(respawn_manager.spawn_num) && self.count == 0)
			{
				println("GROUPED");
				respawn_manager.dead_num++;
				if(respawn_manager.dead_num == respawn_manager.spawn_num)
				{
					respawn_manager notify("group_dead");
				}
				else
				{
					respawn_manager waittill("group_dead");
				}
				respawn_manager.dead_num = 0;
				self.count = count;
			}
			else
			{
				println("NOT GROUPED");
				self.count = count;
			}
		}
	}
}

follow_nodes(node, del)
{
	while (isdefined (node))
	{
		self setgoalnode (node);
		self waittill ("goal");
		if(isdefined(node.target))
		{
			node = getnode (node.target,"targetname");
		}
		else
		{
			break;
		}
	}

	if(isdefined(del))
	{
		self delete();
	}
}

truck_call_anim(target_name, truck, msg, random, tag_name)
{

println("^6(truck_call_anim): MSG: ",msg);
	if(isdefined(target_name))
	{
		if(!isdefined(tag_name))
		{
			truckriders = getentarray(target_name,"targetname");
			for(i=0;i<truckriders.size;i++)
			{
				if(isdefined(truckriders[i].groupname) && truckriders[i].groupname == "truck_driver")
				{
					truckriders = maps\_utility_gmi::subtract_from_array(truckriders, truckriders[i]);
				}
			}
		}
		else
		{
			truckriders = getentarray(target_name,"targetname");
			for(i=0;i<truckriders.size;i++)
			{
				println("truckriders[i].exittag", truckriders[i].exittag);
				if(isdefined(truckriders[i].exittag) && truckriders[i].exittag == tag_name)
				{
					tag_guy = truckriders[i];
				}
			}
//			println("TAG_GUY.targetname = ",tag_guy.targetname);
		}
	}


	if(truck.targetname == "truck1")
	{
		friends = getentarray("friends","groupname");
		truckriders = add_array_to_array(truckriders,friends);
	}

	if(isdefined(tag_guy))
	{
		tag_guy thread truck_anim(msg, random, truck);
	}
	else
	{
		for(i=0;i<truckriders.size;i++)
		{
			truckriders[i] thread truck_anim(msg, random, truck);
		}
	}
}

truck_flinch(truck, override)
{
	self endon("death");
	self endon("stop flinching");

	if(!isdefined(self.special_anim))
	{
		self.special_anim = false;
	}

	if(isdefined(override))
	{
		self.flinch = true;
		self notify("stop_anim");
	}

	while(1)
	{
		self waittill("truck flinch");
//		println("TRYING TO FLINCH! : ", self.flinch);
		if(self.flinch && truck.speed <= 0)
		{
//		println("FLINCH! SUCCESSFUL");
			wait randomfloat(0.5);
			self.flinch = false;
			self notify("stop anim");
//			println("^5FLINCH!");
			self anim_single_solo(self, ("truck_flinch_" + self.climb_tag), self.exittag, undefined, truck);
			if(!self.special_anim) // Prevents 2 anim loops going at one time.
			{
//				println("^5IDLE LOOP");
				self thread maps\_anim_gmi::anim_loop_solo(self, ("idle" + self.climb_tag), self.exittag, "stop anim", undefined, truck);
				wait 1;
				self.flinch = true;
			}
		}
		else if(self.flinch && truck.speed > 0)
		{
//		println("FLINCH! SUCCESSFUL");
			wait randomfloat(0.5);
			self.flinch = false;
			self notify("stop anim");
//			println("^5FLINCH!");
			self anim_single_solo(self, ("truckride_flinch_" + self.climb_tag), self.exittag, undefined, truck);
			if(!self.special_anim) // Prevents 2 anim loops going at one time.
			{
//				println("^5IDLE LOOP");
				self thread maps\_anim_gmi::anim_loop_solo(self, ("idle" + self.climb_tag), self.exittag, "stop anim", undefined, truck);
				wait 1;
				self.flinch = true;
			}	
		}
	}
}

truck_anim(msg, random, truck)
{
	level endon ("STOP IT NOW");
	if(!isdefined(self.special_anim))
	{
		self.special_anim = false;
	}

	if(isdefined(msg))
	{
		if(msg == "start_moving")
		{
			self.flinch = false;
			self.special_anim = true;
			if(isdefined(random))
			{
				wait randomfloat(random);
			}
			self notify("stop anim");
//			println("^3START MOVEMENT");
			self anim_single_solo(self, ("start_movement_" + self.climb_tag), self.exittag, undefined, truck);
		}
		else if(msg == "stuka_point")
		{
			if(self.exittag == "tag_guy07")
			{
				return;
			}
			self.flinch = false;
			self.special_anim = true;
			self notify("stop anim");
//			println("^3STUKA POINT!");
			self anim_single_solo(self, ("stuka_point_" + self.climb_tag), self.exittag, undefined, truck);
		}
		else
		{
			self.flinch = false;
			self.special_anim = true;
			self notify("stop anim");
//			println("^3STUKA POINT!");
			self anim_single_solo(self, (msg), self.exittag, undefined, truck);
		}
	}
//	println("^3IDLE LOOP");

	if(truck.speed > 0)
	{
		if(isdefined(self.crouch_flinch) && self.crouch_flinch)
		{
			// To support talking with any animation, then going back to the flinched/crouched animation.
			self thread event6_truckflinch(truck);
		}
		else
		{
			self thread maps\_anim_gmi::anim_loop_solo(self, ("idle_a" + self.climb_tag), self.exittag, "stop anim", undefined, truck);
		}
	}
	else
	{
		self thread maps\_anim_gmi::anim_loop_solo(self, ("idle" + self.climb_tag), self.exittag, "stop anim", undefined, truck);
	}
	wait 1;
	self.special_anim = false;
	self.flinch = true;
}

anon_troop_dialogue(getclosest, trooper, dialogue, delay, excluders)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	excluders = getentarray("friends","groupname");

	if(isdefined(getclosest) && getclosest)
	{
		trooper = maps\_utility_gmi::getClosestAI(level.player.origin, "allies", excluders);		
	}

	if(!isdefined(trooper))
	{
		println("^1TROOPER IS NOT DEFINED, ABORTING!");
		return;
	}

	trooper.og_animname = trooper.animname;
	trooper.animname = "anon_trooper";
	level anim_single_solo(trooper,dialogue);
	trooper.animname = trooper.og_animname;
}

// Animation Calls
anim_loop ( guy, anime, tag, ender, node, tag_entity )
{
	maps\_anim_gmi::anim_loop ( guy, anime, tag, ender, node, tag_entity );
}

anim_single (guy, anime, tag, node, tag_entity)
{
	maps\_anim_gmi::anim_single (guy, anime, tag, node, tag_entity);
}

anim_single_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_single (newguy, anime, tag, node, tag_entity);
}

anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_loop ( newguy, anime, tag, ender, node, tag_entity );
}

anim_reach (guy, anime, tag, node, tag_entity)
{
	maps\_anim_gmi::anim_reach (guy, anime, tag, node, tag_entity);
}

anim_reach_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_reach (newguy, anime, tag, node, tag_entity);
}

// Instead of using the standard burnville mortars, I modified it so that the mortar distance can be adjusted when wanted.
mortars()
{
	level endon ("stop falling mortars");
	maps\_mortar_gmi::setup_mortar_terrain();
	ceiling_dust = getentarray("ceiling_dust","targetname");

	truckriders = [];
	truck1_riders = getentarray("truck1_rider","targetname");
	truckriders = add_array_to_array(truckriders,truck1_riders);

	truck2_riders = getentarray("truck2_rider","targetname");
	truckriders = add_array_to_array(truckriders,truck2_riders);

	friends = getentarray("friends","groupname");
	truckriders = add_array_to_array(truckriders,friends);


	while (1)
	{
		if ((distance(level.player getorigin(), self.origin) < level.mortar_maxdist) &&
			(distance(level.player getorigin(), self.origin) > level.mortar_mindist))
		{
//			println("MORTAR DELAY",level.mortar_random_delay);
			wait (1 + randomfloat (level.mortar_random_delay));
			maps\_mortar_gmi::activate_mortar(range, max_damage, min_damage, fQuakepower, iQuaketime, iQuakeradius);
			for(i=0;i<ceiling_dust.size;i++)
			{
				if(distance(self.origin, ceiling_dust[i].origin) < 512)
				{
					playfx ( level._effect["ceiling_dust"], ceiling_dust[i].origin );
					ceiling_dust[i] playsound ("dirt_fall");
				}
			}
			for(i=0;i<truckriders.size;i++)
			{
				if(isalive(truckriders[i]) && distance(self.origin, truckriders[i].origin) < 3000)
				{
					truckriders[i] notify("truck flinch");
				}				
			}
			wait (level.mortar_random_delay);
		}

		wait (1);
	}
}

// Random Arrays
random (array)
{
	return array [randomint (array.size)];
}

playSoundOnTag (alias, tag)
{
	if ((isSentient (self)) && (!isalive (self)))
		return;

	org = spawn ("script_origin",(0,0,0));
	thread delete_on_death (org);
	if (isdefined (tag))
		org linkto (self, tag, (0,0,0), (0,0,0));
	else
	{
		org.origin = self.origin;
		org.angles = self.angles;
		org linkto (self);
	}

	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}

delete_on_death (ent)
{
	ent endon ("death");
	self waittill ("death");
	if (isdefined (ent))
		ent delete();
}

// Explosive Stuff
bombs(objective_number, objective_text, array_targetname, activate_notify)
{
	bombs = getentarray (array_targetname, "targetname");
	println (array_targetname, " bombs.size: ", bombs.size);
	level.timersused = 0;
	for (i=0;i<bombs.size;i++)
	{
		bombs[i].bomb = getent(bombs[i].target, "targetname");
		bombs[i].used = 0;
		bombs[i] thread bomb_think(activate_notify, array_targetname);
	}

	if (bombs.size != 0)
	{
		remaining_bombs = bombs.size;
		closest = bomb_get_closest (bombs);
		if (isdefined (closest))
		{
			println("^2Remaining Bombs ",remaining_bombs);
			println("^2Closest ",closest);
			println("^2Objective_number ",objective_number);
			println("^2objective_text ",objective_text);
			objective_add(objective_number, "active", objective_text, (closest.bomb.origin));
			objective_current(objective_number);
			objective_string(objective_number, objective_text, remaining_bombs);
		}

		while (remaining_bombs > 0)
		{
			level waittill (array_targetname + " planted");

			remaining_bombs --;
			objective_string(objective_number, objective_text, remaining_bombs);

			closest = bomb_get_closest (bombs);
			if (isdefined (closest))
			{
				objective_position(objective_number, (closest.bomb.origin));
				objective_ring(objective_number);
			}
			else
			{
				println("^1OBJECTIVE DONE??");
				objective_state(objective_number, "done");
				temp = ("objective_complete" + objective_number);
				//println (temp);
				level notify (temp);
			}
		}
	}

	return;
}

bomb_get_closest(array)
{
	range = 500000000;
	for (i=0;i<array.size;i++)
	{
		if (!array[i].used)
		{
			newrange = distance (level.player getorigin(), array[i].origin);
			if (newrange < range)
			{
				range = newrange;
				ent = i;
			}
		}
	}
	if (isdefined (ent) )
		return array[ent];
	else
		return;
}

bomb_think (activate_notify, array_targetname)
{

//	println ("waittill trigger");

	self setHintString (&"SCRIPT_HINTSTR_PLANTEXPLOSIVES");

	if (isdefined (activate_notify))
	{
		self maps\_utility_gmi::triggerOff();
		self.bomb hide();

		level waittill (activate_notify);

		self.bomb show();
		self maps\_utility_gmi::triggerOn();
	}
	self waittill("trigger");
	//println ("triggered");

	self.used = 1;
	//iprintlnbold (&"SCRIPT_EXPLOSIVESPLANTED");
	self.bomb setModel("xmodel/explosivepack");
	level notify (array_targetname + " planted");
	if (isdefined (self.target))
	{
		level notify (self.target + " planted");
	}

	self maps\_utility_gmi::triggerOff();
	
	self.bomb playsound ("explo_plant_no_tick");
	
	if (isdefined (self.script_noteworthy))
		self waittill (self.script_noteworthy);
	else
	{
		self.bomb playloopsound ("bomb_tick");
		if (isdefined (level.bombstopwatch))
			level.bombstopwatch destroy();
		level.bombstopwatch = newHudElem();
		level.bombstopwatch.x = 36;
		level.bombstopwatch.y = 240;
		level.bombstopwatch.alignX = "center";
		level.bombstopwatch.alignY = "middle";
		level.bombstopwatch setClock(10, 60, "hudStopwatch", 64, 64); // count down for 10 of 60 seconds, size is 64x64
		level.timersused++;
		wait 10;
		self.bomb stoploopsound ("bomb_tick");
		level.timersused--;
		if (level.timersused < 1)
		{
			if (isdefined (level.bombstopwatch))
				level.bombstopwatch destroy();
		}
	}

	//origin, range, max damage, min damage
	radiusDamage (self.bomb.origin, 350, 3000, 1);

	earthquake(0.25, 3, self.bomb.origin, 1050);

	//NOTIFY THE SCRIPT
	level notify (array_targetname + " exploded");
	if (isdefined (self.target))
	{
		level notify (self.target + " exploded");
		level notify (self.target);
	}

	wait (.5);

	self.bomb hide();
}

print_dialog3d(who,text,duration, color)
{
	if(!isdefined(duration))
	{
		duration = 3;
	}
	time = 0;

	if(!isdefined(color))
	{
		color = (1,1,1);
	}
	while(time < duration)
	{
		println("TESTING!");
		print3d((who.origin + (0,0,100)), text,color, 5, 1);
		wait 0.1;
		time = 0.1 + time;
	}
}

music()
{
	if(getcvarint("og_start") < 1)
	{
		println("^3MusicPlay: trenches_datestamp");
		musicplay("trenches_datestamp");
		wait 8;
		musicstop(3);
		wait 4;
	}
	println("^3MusicPlay: trenches_a");
	musicplay("trenches_a");

	level waittill ("player shell shocked");
	musicStop(5);

	level waittill("start right flank start");
//	musicplay("trenches_b_loop_low"); // Cannot crossfade, this is useless.
	wait 3;
	musicstop();
//	println("^3MusicPlay: trenches_b_loop");
//	musicplay("trenches_b_loop");

	level waittill("start objective 4");
	musicStop(3);
	wait 3.25;
	println("^3MusicPlay: trenches_a_loop");
	musicplay("trenches_a_loop");

	level waittill("event17 stop music");
	musicStop(10);

	level waittill("event18 music");

	println("^3MusicPlay: trenches_victory");
	musicplay("trenches_victory");
	wait level.musiclength["stalingrad_victory"];
	musicStop();
}

draw_speed()
{
	while(1)
	{
		print3d((self.origin + (0,0,200)), self.speed,(1,1,1), 5, 1);
		wait 0.075;
	}
}

draw_name()
{
	while(1)
	{
//		ai = getaiarray("axis");
//		for(i=0;i<ai.size;i++)
//		{
//			if(isalive(ai[i]))
//				print3d((ai[i].origin + (0,0,100)), ai[i].goalradius, (1,1,0), 5, 1);
//		}
//		wait 0.075;

//		mg42s = getentarray("misc_mg42","classname");
//		for(i=0;i<mg42s.size;i++)
//		{
//			if(isdefined(mg42s[i].accuracy))
//			{
//				print3d((mg42s[i].origin + (0,0,100)), mg42s[i].accuracy, (1,1,0), 5, 1);				
//			}
//		}
//		wait 0.075;
	}
}

debug_ent(define_it)
{
	name[0] = "TargetName";
	name[1] = "GroupName";
	name[2] = "script_noteworthy";

	field[0] = self.targetname;
	field[1] = self.groupname;
	field[2] = self.script_noteworthy;


	println("");
	println("^5//----------------------------------------------//");
	println("^5//--------------START ENT FIELDS----------------//");
	println("");
	for(i=0;i<field.size;i++)
	{
		if(isdefined(define_it))
		{
			if(isdefined(field[i]))
			{
				println(name[i]," = ", field[i]);
			}
		}
		else
		{
			println(name[i]," = ", field[i]);
		}
	}
	println("");
	println("^5//---------------END ENT FIELDS-----------------//");
	println("^5//----------------------------------------------//");
	println("");
}

debug_pathnodes()
{
	all = [];
	level waittill("finished intro screen");
	node_balcony = getnodearray("Balcony","type");
	if(isdefined(node_balcony) && node_balcony.size > 0)
	{
		all = add_array_to_array(all,node_balcony);
	}

	println("^2Node_Balcony Count: ",node_balcony.size," ^2*******************************");

	node_concealment_crouch = getnodearray("Conceal Crouch","type");
	if(isdefined(node_concealment_crouch) && node_concealment_crouch.size > 0)
	{
		all = add_array_to_array(all,node_concealment_crouch);
	}

	println("^2node_Concealment_Crouch Count: ",node_concealment_crouch.size," ^2*******************************");

	node_concealment_prone = getnodearray("Conceal Prone","type");
	if(isdefined(node_concealment_prone) && node_concealment_prone.size > 0)
	{
		all = add_array_to_array(all,node_concealment_prone);
	}

	println("^2node_concealment_prone Count: ",node_concealment_prone.size," ^2*******************************");

	node_concealment_stand = getnodearray("Conceal Stand","type");
	if(isdefined(node_concealment_stand) && node_concealment_stand.size > 0)
	{
		all = add_array_to_array(all,node_concealment_stand);
	}

	println("^2node_concealment_stand Count: ",node_concealment_stand.size," ^2*******************************");

	node_cover_crouch = getnodearray("Cover Crouch","type");
	if(isdefined(node_cover_crouch) && node_cover_crouch.size > 0)
	{
		all = add_array_to_array(all,node_cover_crouch);
	}

	println("^2node_cover_crouch Count: ",node_cover_crouch.size," ^2*******************************");

	node_cover_left = getnodearray("Cover Left","type");
	if(isdefined(node_cover_left) && node_cover_left.size > 0)
	{
		all = add_array_to_array(all,node_cover_left);
	}

	println("^2node_cover_left Count: ",node_cover_left.size," ^2*******************************");

	node_cover_prone = getnodearray("Cover Prone","type");
	if(isdefined(node_cover_prone) && node_cover_prone.size > 0)
	{
		all = add_array_to_array(all,node_cover_prone);
	}

	println("^2node_cover_prone Count: ",node_cover_prone.size," ^2*******************************");

	node_cover_right = getnodearray("Cover Right","type");
	if(isdefined(node_cover_right) && node_cover_right.size > 0)
	{
		all = add_array_to_array(all,node_cover_right);
	}

	println("^2node_cover_right Count: ",node_cover_right.size," ^2*******************************");

	node_cover_stand = getnodearray("Cover Stand","type");
	if(isdefined(node_cover_stand) && node_cover_stand.size > 0)
	{
		all = add_array_to_array(all,node_cover_stand);
	}

	println("^2node_cover_stand Count: ",node_cover_stand.size," ^2*******************************");

	node_wide_left = getnodearray("Wide Left","type");
	if(isdefined(node_wide_left) && node_wide_left.size > 0)
	{
		all = add_array_to_array(all,node_wide_left);
	}

	println("^2node_wide_left Count: ",node_wide_left.size," ^2*******************************");

	node_wide_right = getnodearray("Wide Right","type");
	if(isdefined(node_wide_right) && node_wide_right.size > 0)
	{
		all = add_array_to_array(all,node_wide_right);
	}

	println("^2node_wide_right Count: ",node_wide_right.size," ^2*******************************");

	node_negotiation_begin = getnodearray("Begin","type");
	if(isdefined(node_negotiation_begin) && node_negotiation_begin.size > 0)
	{
		all = add_array_to_array(all,node_negotiation_begin);
	}

	println("^2node_negotiation_begin Count: ",node_negotiation_begin.size," ^2*******************************");

	node_negotiation_end = getnodearray("End","type");
	if(isdefined(node_negotiation_end) && node_negotiation_end.size > 0)
	{
		all = add_array_to_array(all,node_negotiation_end);
	}

	println("^2node_negotiation_end Count: ",node_negotiation_end.size," ^2*******************************");

	node_pathnode = getnodearray("Path","type");
	if(isdefined(node_pathnode) && node_pathnode.size > 0)
	{
		all = add_array_to_array(all,node_pathnode);
	}

	println("^2node_pathnode Count: ",node_pathnode.size," ^2*******************************");

	node_reacquire = getnodearray("Reacquire","type");
	if(isdefined(node_reacquire) && node_reacquire.size > 0)
	{
		all = add_array_to_array(all,node_reacquire);
	}

	println("^2node_reacquire Count: ",node_reacquire.size," ^2*******************************");

	node_scripted = getnodearray("Scripted","type");
	if(isdefined(node_scripted) && node_scripted.size > 0)
	{
		all = add_array_to_array(all,node_scripted);
	}

	println("^2node_scripted Count: ",node_scripted.size," ^2*******************************");

	node_stack = getnodearray("Stack","type");
	if(isdefined(node_stack) && node_stack.size > 0)
	{
		all = add_array_to_array(all,node_stack);
	}

	println("^2node_stack Count: ",node_stack.size," ^2*******************************");

	println("^2TOTAL AMOUNT OF PATHNODES: ",all.size," ^2*******************************");
}


// This function fires the turret on the tank
// Self = The tank
// TargetEnt = Target the turret at the ENT
// TargetPos = Target the turret at the POS
// Start_Delay = Delay before tracking the target.
// Shot_Delay = Delay after tracking the target, before shooting the turret.
// End_Notify = Notifies the entity when it's done, if not specified, 
// then: "turret_fire_done" will be notified
Tank_Fire_Turret(targetent, targetpos, start_delay, shot_delay, offset, validate, fake_fire, random_turning)
{
	self notify("stop_firing");
	self endon("death");
	self notify("stop_random_turret_turning");
	self endon("stop_firing");

	self.is_firing = true;

	if(isdefined(start_delay))
	{
		wait start_delay;
	}

	if(isdefined(targetent))
	{
		if(!isdefined(offset))
		{
			offset = (0,0,0);
		}

//		self thread do_line(self.origin, targetent.origin, (1,1,0), self.targetname);
		self setTurretTargetEnt(targetent, offset);
	}
	else if(isdefined(targetpos))
	{
		self setTurretTargetVec(targetpos);
	}
	else
	{
		println("^1***(Tank_Fire_Turret) NO TARGET SPECIFIED!***");
		return;
	}

	self waittill("turret_on_target");

	if(isdefined(shot_delay))
	{
		wait shot_delay;
	}
	else
	{
		wait 0.5;
	}

	// Validate the target, one last time.
	// Only for Entities.

	if(self.vehicletype != "Elefant")
	{
		if(isdefined(validate) && (validate))
		{
			valid = self Tank_Validate_Target(targetent, "tag_flash", (0,0,64));
			if(!valid)
			{
				return;
			}
		}
	}

	if(!isdefined(fake_fire) || (!fake_fire))
	{
		self notify("turret_fire");
//		self FireTurret();

		self notify("turret_fire_done");
	}
	else
	{
		playfxontag(level.fake_turret_fx, self, "tag_flash");

		if(self.vehicletype == "Elefant")
		{
			self playsound("panzerIV_fire");
			earthquake(0.75, 0.5, self.origin, 1050);
		}
		else
		{
			self playsound("t34_fire");
		}

		forward_angles = anglestoforward(self.angles);
		vec = self.origin + maps\_utility_gmi::vectorScale(forward_angles, 100);
		self joltBody (vec, 1, 0, 0);

		self notify("turret_fire_done");

		dist = distance(self.origin, targetent.origin);
		wait (dist * .0001);
		self notify("hit_target");

		if(isdefined(targetent))
		{
			if(isdefined(targetent.script_exploder))
			{
				level thread maps\_utility_gmi::exploder(targetent.script_exploder);
			}
			
			if(isdefined(targetent.script_fxid))
			{
				if(!isdefined(targetent.script_delay))
				{
					targetent.script_delay = 0; 
				}

				if (isdefined (targetent.target))
				{
					targets = getentarray(targetent.target,"targetname");
					for(i=0;i<targets.size;i++)
					{
						if(targets[i].classname == "script_origin")
						{
							org = targets[i].origin;
						}
					}
				}

				if(isdefined(targetent.script_sound))
				{
					targetent playsound(targetent.script_sound);
				}

				// Mainly used for the building explosions.
				if(isdefined(targetent.rumble))
				{
					earthquake(0.75, 0.5, targetent.origin, 3000);
				}

				level thread maps\_fx_gmi::OneShotfx(targetent.script_fxid, targetent.origin, targetent.script_delay, org);
			}
			else
			{
				soundnum = randomint(3) + 1;

				if(soundnum == 1)
				{
					targetent playsound ("mortar_explosion1");
				}
				else if (soundnum == 2)
				{
					targetent playsound ("mortar_explosion2");
				}
				else
				{
					targetent playsound ("mortar_explosion3");
				}
			
				if(getcvarint("scr_gmi_fast") > 0)
				{
						playfx (level.mortar_low, targetent.origin);
						println("^1PLaying Low Mortar FX");
				}
				else
				{
						playfx (level.mortar, targetent.origin);
				}
				earthquake(0.15, 2, targetent.origin, 850);
				radiusDamage (targetent.origin, 512, 400,  1);
			}
		}
	}

	self.is_firing = false;
}

// Validates the Target for the tank firing. Does a trace and returns a boolean for
// verification.
Tank_Validate_Target(target, tag, offset)
{
	self endon("death");

	if(isdefined(tag))
	{
		turret_origin = self gettagorigin(tag);
	}
	else
	{
		turret_origin = self gettagorigin("tag_turret");
	}

	if(isdefined(offset))
	{
		target_pos = (target.origin + offset);
	}
	else
	{
		target_pos = target.origin;
	}
	
	trace_result = bulletTrace(turret_origin, target_pos, false, self);

//	level thread do_line(turret_origin, trace_result["position"], (1,1,0), "tiger");

	if(distance(trace_result["position"],target.origin) < 150)
	{
		return true;
	}
	else
	{
		return false;
	}
}


//////////////////////////////////
// FOR TESTING, DOM AND COLIN!!!//
//////////////////////////////////
#using_animtree("trenches_dummies_path");
test_dummy()
{
	for(i=10;i>0;i--)
	{
		println(i);
		wait 1;
	}

	blah = spawn("script_origin",(level.player.origin));
	blah playsound("mass_scream");

//	anim_wait = [];
//	anim_wait[0] = 20;
//
//	level thread maps\trenches_dummies::dummies_setup((-17441, -3642, -60), "xmodel/trenches_dummies_truckA", 9, (0,180,0), undefined, undefined, %trenches_dummies_truckA, true, "event1_truck_dummies", anim_wait, false, "truckA_blow");
//	wait 0.5;
//	level thread maps\trenches_dummies::dummies_setup((-17441, -3642, -60), "xmodel/trenches_dummies_truckB", 9, (0,180,0), undefined, undefined, %trenches_dummies_truckB, true, "event1_truck_dummies", anim_wait, false, "truckB_blow");
}

test_tailgate()
{
	truck1 = getent("truck1","targetname");
	while(1)
	{
		truck1 thread maps\_truck_gmi::toggle_beddoor();
		wait 10;
	}
}


