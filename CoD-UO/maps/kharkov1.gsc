//
//Mapname: kharkov1
//Edited by: Mike
//

// Task List
//----------
//

// -Add a couple more flamethrower dudes.
// -Clip fake debris.
// -Update objective position a little more. Tell the player where to go.
// -Add health.

// -If player goes back, so friends go back to spot 2 (during 1st artillery strike), and then make the friends go 
// back to spot 3, it will error out, trying to play 2 loop animations at once.
// Prevent guys on anti-tanks from killing themselves. Incorporate fake targets.
// -Make alternate tank wall a fake_target
// -Make event3 blow wall2 fake target.
// -Add shadow caster to blown out section of event3.
// -Align some textures.
// -Deathroll for t34s along street.
// -Better spread of tanks along street.

// GMI TASK STUFF
//----------------
// -First Artillery Gun
// --------------------
// -"RICH" -> Write and record VO for Miesha telling the player he's ready for coordinates.
// -"RICH" -> After player takes out artillery, friendly AI should say something as they run down to the street level.  Something as simple as "Let's go!" or "We've got to keep moving!" 
// -"ART" -> Take D-light off tank guns.

// -Second Artillery Gun
// ---------------------
// -"RICH" -> Create additional VO for 2nd artillery encounter, when the player encounters friendlies waiting in the building.  VO should urge the player to action and be on the ambient channel.

// -Third Artillery Gun
// --------------------

// -Street (Tiger Tank)
// --------------------
// -Provide more cover for Germans around Tiger Tank and in street, to avoid them staying in the open when firing.
// -Spread tanks out along street.
// -When driving, have tanks spread out more.

// -Courtyard
// ----------
// -Add gold star and objective to help drive player through the buildings.
// -Add more lights in windows of first courtyard area.

// -Building Clearing
// ------------------
// -Add extra gold star in the middle of this sequence (right where the game is saved and you get the "You three…" orders.
// -Remove fire by first MG42 room.

// -Final Battle
// -------------
// -Add charge marker on tank, so they player can destroy the tank another way.

//-----//
// Log //
//-----//

// 03/04/04
//----------
// -Add datestamp
// -Adjusted MG42 Fire at the first face off... Min/Max delay.

// 03/08/04
//----------
// -Break up buildings for DEMOLITION.
// -Have guys take off right away.
// -Have guys already at the next couple of walls.
// -MG42s start sooner
// -Adjust nodes on the Russian wall; make sure all the nodes are correct.
// -Move tanks further back so they are not idle and then have them move up they will still need to wait at some point until the player moves but this position can be made to feel better.
// -Re-spawn time for the mg-42 guys needs to be longer.
// -Break wall @ 1353 3533 131 to show fire fx.
// -Germans need filter out of the building and take up positions in cover places along a trench and other cover. A few of these guys need to be the new LMG guys.
// -When tanks move and stop they need to take up better positions and the turrets should move randomly to give the feel that they are prepared for combat.

// 03/09/04
//----------
// -Add clips around the side walks. So player does not get caught up on the terrain sidewalks.
// -Monsterclip the first wall.
// -Switch the objectives to 3 Anti-tank positions. (Instead of 5) Add new Anti-tank emplacements.

// 03/12/04
//----------
// -Clean up live guys after player jumps down from blowing up pak43_1.
// -Add in Germans for combat at the first 88 area.
// -Add miesha animations

// 03/14/04
//----------
// -Add weapon_binoculars to each location for now.
// -Disabled "Dropped_Binocular_Think"
// -Clip map for player.

// -Have pak43_1 randomly firing.
// -Fix guys in the building (just after MG42_5, so they are always standing, no cover nodes.
// -Ambient in Skybox (planes, tracers, etc).
// -Have T34s also shoot at the tiger.
// -Update objective so it reads take out anti-tank positions.
// -Spacing on Tank adjustments
// -Have AI climbing over wall go to nodes, rather the the player at the end.
// -Node for sniper in first building should be a conceal_stand
// -Add interior/exterior ambient triggers.

// 03/18/04
//----------
// -Replaced flak88s with Pak43s.
// -Added autosaves
// -Elefant tank fires.
// -Add light/fire behind the elefant tank.
// -Got rid of all binocular pickups
// -Adjusted Miesha's 3rd node (1st target) so he's closer to the wall.
// -Made "event2_binoc" (idnumber 3) larger, so the player can't skip the trigger and not tell your friends to move forward.

// 03/19/04
//----------
// -Reduced the number of Russians with PPSH's at the beginning.
// -Added T34s firing at beginning of the map

// 03/24/04
//----------
// - Fixed trigger so MG42 guy gets on gun, and can continue with the map. (Event4).

// 03/29/04
//----------
// -Fix Objective locations.
// -Added 2 flybys just before the first tiger tank battle.
// -Add sound to blockade booms.
// -Get FX for End of level. Brick wall blowing out.
// -Clip end of map so player cannot go into windows.

// 03/30/04
//----------
// -GLOBAL:  Up world lighting values. (Corky did this)
// -Move the player's start back 128 units.
// -Antonov should have a PPSh and/or a pistol, not a rifle.
// -Artillery (Pak 43) crews are wearing wrong uniform.  Please correct.
// -Make combat in this area more about localized threat - i.e. Germans coming into the area.  Have the MG42s in the distance be present, but not be the focus.
// For Above.... (Moved the 3 ai in the buildings that do not hop on MG42s, and moved them to respawn over the wall.)

// -Replace two MG42s with MG34s.
// -Pvt. Redshirt needs a name. Made a character for him too.
// -Check to make sure the bookcase model in first ruined house does not flicker.  (bug)
// -When Pak 43 is destroyed, kill a Germans surrounding it.
// -Since we scooted the player bag, he no longer starts off crouched.
// -Trigger guys to move to event2 sooner.
// -(Already do) When player reaches first artillery spotting vantage point, have Germans on the other side above the 88 take occasional pot shots at the player.
// -Expand the size of the first window to allow the player to see the artillery strike better.
// -Add more cover for friendlies near where first tank is destroyed.
// -On the way to the next building, add cover for friendlies.
// -Create alternate path after first anti-tank objective (flanking path).
// -Make Pak 43 more visible.
// -Add fake targets to help tanks reorient their turrets after firing.
// For Above... (Adjusted trigger that sets their orientation around the corner just before the street battle)
// -Open slats/increase visibility through fence so that player can see tanks and friendlies.

// 03/31/04
//----------
// -Added FX on all of the falling debris.
// -Have the Elephant tank fire on the T34s to create tension and drive home the urgency of needing to destroy it. (Done already).
// -Increase the lighting of the Elephant tank. (Done already).
// -Have friendly AI in this area engage enemies. (Done Already).
// -Adjusted plane timing a bit... 1 second after start of map, they go.


// 04/01/04
//---------
// -Have tanks pull back to safety once first tank gets hosed. Do a check for player, and all of the tanks (to get into position) for trigger the first tank to blow.
// -When Pak 43 is destroyed, kill all Germans surrounding it. (On all mortar locations)
// -Added an binoc mortar right where the loaders are, so they have no chance of living.
// -Tank now shoot across street, at building. Between 2nd artillery and 3rd artillery.
// -Slow down T34s after 2nd artillery gun is destroyed.
// -When Elefant is destroyed, kill a Germans surrounding it.
// -Added collmap to Modelled debris.
// -Fixed texture alignment issues.
// -Make entrance to building/next area more obvious.  (Make corridor more visible, have other areas smoke- or fire-ridden, add lighted room with table with goodies on it)
// -Provide more cover for friendlies on street near Tiger Tank encounter. (Done Already).
// -Rework friendly chains and cover in second part of map.  Russians don't take enough cover and usually fight in open. (Done ALready)
// -Add Panzerfausts on ground so player can destroy tank. (Done Already)

// 04/02/04
//---------
// -Fixed objective so ARTILLERY hits show the correct number. So now it reports 0 remaining when done with the objective.
// -Fixed guys not dieing when forced to at beginning of map.
// -Add objective "Advance with Tanks"
// -Fixed a bug where if the player rushed out of the 1st artillery building, the friends would not go until the player is way ahead.
// -Had to add a delay to the one tank that is shooting at the building cause it would clip through another tank.
// -Fixed the "precache of lmg" bug. Now using the precahce() from lmg_gmi.gsc.
// -Have Tiger Tank back up. (Decided not to?)
// -Fixed a script_error that would occur if the player rushed out of the 1st artillery house, and triggered the next "fake" friendlychain, which would try to assign Redshirt a node, when he was suppose to die before the player got to that point.
// -Have AI approach entrance and crouch near it.(Already done).
// -Fixed angled wall that was f'd up after we changed the textures a bit. Stupid grid!
// -Decrease the thickness of the MG42 window so the player can look down more.
// -Reduce fires in building, making player's path a sequence of avoiding fire rather than walking through or near it.
// -Add particle effect for tank breaking through wall.
// -Make it so the player does not have to watch the blockade explosions to have the wall explode (inside of building).
// -Make combat between spotter objectives harder. (Added 2 guys on 3rd artillery spotter area.)
// -Fix bug that prevents the t34 from blowing the event4 wall. (Happens when all tanks live).

// 06/27/04 - 06/28/04
//---------------------
// -Add hintstring for the binoculars.
// -Have Antonov move up with group, but trailing.
// -Have door close behind the player and his group when the wall explodes in the building.
// -Add trigger hurts to all of fires that can hurt, radius checks.
// -Fix larged boards sticking out of ground. Make sure they collide, and add clips.
// -Open door for last of friendly reinforcements
// -Fix issue with sounds from falling debris playing at the origin at the world.
// -Add kick sound to kick_door
// -Add three SU 152 artillery guns behind player starting position. Have them firing during the battle. 
// -Consider another stop mechanism for the 3rd artillery spotter position, instead of having the wall below the player blow up.  (When 3rd objective is blown, make blast bigger, shellshock player and knock him to the ground.)
// -Have Russian tanks engage Tiger effectively.
// -Add objective "Assist Antonov with clearing out buildings"
// -Add sounds on fires in houses.


//- fixed script error in first artillery if player returned to antonov
//- added more weapons and health to last battle
//-added some nodes on street so chains connect
//- made antonov go into area after tank blows up wall
//-fixed chain near courtyard so antonov moves closer to area
//-changed path to end of level, added door and adjusted triggers. no longer can go from bottom.



#using_animtree("generic_human");
main()
{
//	setCullFog (500, 15000, 0.26, 0.136, 0.0625, 0 );
	setCullFog (500, 15000, 0.19, 0.20, 0.21, 0 );
//	setCullFog (7500, 8000, 0.19, 0.20, 0.21, 0 );

	// --- Preload --- //
	maps\_load_gmi::main();
	maps\_pak43_gmi::main();
	maps\_elefant_gmi::main();
	maps\kharkov1_fx::main();
	maps\kharkov1_anim::main();
	maps\_t34_gmi::main();
	maps\_tiger_gmi::main();
//	maps\_flame_damage::main();
	// Preacache the LMG guys.
	animscripts\lmg_gmi::precache();

	// --- DEBUG --- //
	maps\_debug_gmi::main();
	level.flag["green"] = false;
	level.flag["yellow"] = false;
	level.flag["red"] = false;
	level.flag["special"] = false;
	level.flag["tiger"] = false;
	// For miesha saying wait for me.
	level.flag["miesha_talking"] = false;
	level.flag["miesha_3rd_floor"] = false;

//	precacheitem("mg34_bipod_prone");
//	precachemodel("xmodel/mg42_bipod");

//	MikeD: Colored syntax for future prints.
	println("^0 1, Black");
	println("^1 1, Red");
	println("^2 2, Green");
	println("^3 3, Yellow"); // Debugging.
	println("^4 4, Blue");
	println("^5 5, Cyan");
	println("^6 6, Purple"); // Voice overs.
	println("^7 7, White");
	println("^8 8, NA");  
	println("^9 9, NA");
//	End Colored Syntax for prints.

	if(getcvar("quick_event1") == "")
	{
		setcvar("quick_event1","0");
	}

	if(getcvar("skipto_event3") == "")
	{
		setcvar("skipto_event3","0");
	}

	if(getcvar("skipto_event4") == "")
	{
		setcvar("skipto_event4","0");
	}

	if(getcvar("no_enemy_1") == "")
	{
		setcvar("no_enemy_1","0");
	}

	if(getcvar("skipto_end") == "")
	{
		setcvar("skipto_end","0");
	}

	if(getcvar("quick_end") == "")
	{
		setcvar("quick_end","0");
	}

	if(getcvar("debug_mg42_spotter") == "")
	{
		setcvar("debug_mg42_spotter", "0");
	}

	// Throw away the garbage! Models/temp objects not used in the game.
	garbage = getentarray("garbage","targetname");
	for(i=0;i<garbage.size;i++)
	{
		garbage[i] delete();
	}

	level.skipto = 0;

	// --- Level.Stuff --- //

	// When a friendly AI spawns in to catch up to squad, he will run this THREAD.
	level.friendlywave_thread = maps\kharkov1::Catch_Up;

	level.panzer_think_thread = maps\kharkov1::Event3_Panzer_Think;
	// Kill player triggers.
	level.mg42_kill_player = false;
	// Limit of respawning friendlies.
	level.maxfriendlies = 9;
	// Enables Temp Dialogue
	level.temp_dialogue_check = true;
	// Ambient
	level.ambient_track["exterior"] = "ambient_kharkov_ext";
	level.ambient_track["interior"] = "ambient_kharkov_int";
	level thread maps\_utility_gmi::set_ambient("exterior");
	// Keeps track of player and friends during event2_binoc section
	level.event2_assigned_spot = 0;
	// Tracks the death of the mg42, when miesha is at spot 7.
//	level.miesha_spot7_count = 0;
//	level.miesha_spot9_count = 0;

	// For the cursorhint, so the player knows where the target is.
	level.binoc_target = false;

	// Used for the min/max delay of the distant lights
	level.dist_light_min_delay = 5;
	level.dist_light_max_delay = 15;

	// Used to determine if the player shot the tank, or if the T34 has to.
	level.event3_t34s_go = false;

	level.objective2_counter = 0;

	// Used to determine if all of the t34s are in position before blowing up t34_1
	level.event2_t34s_in_position = 0;

	level.binoc_cursor_text["use"] = false;
	level.binoc_cursor_text["fire"] = false;
	level.flag["miesha_ready_for_artillery"] = false;
	level.flag["miesha_calling_artillery"] = false;

	level.su152_num = 0;

	// --- Precaching Stuff --- //
	precachemodel("xmodel/vehicle_tank_t34_destroyed");
	precacheModel("xmodel/vehicle_tank_panzeriv_machinegun");
	
	precachemodel("xmodel/kharkov1_facadeA1");
	precachemodel("xmodel/kharkov1_facadeA2");
	precachemodel("xmodel/kharkov1_facadeA3");
	precachemodel("xmodel/kharkov1_facadeA4");
	precachemodel("xmodel/kharkov1_facadeC");
	precachemodel("xmodel/kharkov1_facadeB1");
	precachemodel("xmodel/kharkov1_facadeB2");
	precachemodel("xmodel/kharkov1_facadeB3");

	precachemodel("xmodel/kharkov1_receiver");
	precacheItem("tt33");

	precachemodel("xmodel/stalingrad_megaphone");

	precacheModel("xmodel/ammo_panzerfaust_box2");
	precacheModel("xmodel/weapon_panzerfaust");
	precacheItem("panzerfaust");

	// --- Precache Shaders --- //
	precacheShader("gfx/hud/hud@fire_ready.dds");
	precacheShader("gfx/hud/hud@objective_friendly_chat.dds");

	// --- Disabled Chains --- //
	level thread maps\_utility_gmi::chain_off("event2_chain3");

	level Setup_Characters();
	level thread Disconnect_Certain_Paths();
	level thread Setup_Antonov_Triggers();
	level thread Setup_Event1_MG42s();
	level thread Setup_Su152s();
	level thread Setup_Pak43_Guns();
	level thread Binoc_Trigger_Setup();
	level thread Objectives();
	level thread Event1();
	level thread Event1_Setup_Tanks();
	level thread Start_Crouched();
	level thread MG42_Kill_Player_Setup();
	level thread Random_Distant_Light_Setup();
	level thread Setup_Fire_Trigger_Damage();
//	level thread Dropped_Binocular_Think();
	level thread Setup_Low_Spec();
	level thread Music();

	if(getcvar("skipto_event3") == 1)
	{
		level thread SkipTo_Event3();
	}
	else if(getcvar("skipto_event4") == 1)
	{
		level thread SkipTo_Event4();
	}
	else if(getcvar("skipto_end") == 1)
	{
		level thread skipto_end();
	}

// TESTING!!!
//	level thread Fun_Binocs();
//	level thread tank_turret();
//	for(i=5;i<7;i++)
//	{
//		mg42 = getent("mg42_" + i,"targetname");
//		mg42 thread dist_check();
//	}
//	level thread test_miesha_spot();
//	level thread test_tank_blow_barbed_wire();
//	level thread spawner_target_debug();
//	level thread spawner_check();
//	level thread trace_test();
//	level thread test_miesha_tag();

//	level thread Elefant_Firing();
}

// Hack to get the player to crouch at the beginning of the level.
Start_Crouched()
{
	group2 = getentarray("allies_group2","groupname");
	for(i=0;i<group2.size;i++)
	{
		if(isalive(group2[i]))
		{
			group2[i] allowedstances("crouch");
		}
	}

//	level waittill("finished intro screen");
//	level.player allowStand(false);
//	wait 0.5;
//	level.player allowStand(true);

}

Disconnect_Certain_Paths()
{
	wait 0.5;

	door = getent("event4_door2","targetname");
	door disconnectpaths();
}

// Sets up all of the flak turret
Setup_Pak43_Guns()
{
	// Setup Flaks
	level.pak43_1 = getent("pak43_1","targetname");

	level.pak43_1.health = 1000;
	// Aim the gun so it doesn't clip.
	level.pak43_1 setTurretTargetVec((-2123, -2539, -70));
	level.pak43_1 waittill("turret_on_target");
	level.pak43_1 clearTurretTarget();


	level.pak43_2 = getent("pak43_2","targetname");

	level.pak43_2.health = 1000;
	// Aim the gun so it doesn't clip.
	level.pak43_2 setTurretTargetVec((-2184, -824, -64));
	level.pak43_2 waittill("turret_on_target");
	level.pak43_2 clearTurretTarget();
	level.pak43_2.target_min = (-2176, -550, -120);
	level.pak43_2.target_max = (-1800, -900, -200);
//	level.pak43_2 thread pak43_target_field();

	level.elefant = getent("elefant1","targetname");
	level.elefant maps\_elefant_gmi::init("no_turret");
	level.elefant.health = 100;
}

Setup_Low_Spec()
{
	println("^3 Low Spec Setup");
	println("^3----------------");

	if(getcvarint("scr_gmi_fast") > 0)
	{
		println("^3level.event1_fake_target = level.event1_fake_target_low");
		level.event1_fake_target = level.event1_fake_target_low;

		println("^3level.mortar = level.mortar_low");
		level.mortar = level.mortar_low;

		println("^3level.blockade = level.blockade_low");
		level.blockade = level.blockade_low;

		println("^3Deleting allies_group2 (groupname)");
		guys = getentarray("allies_group2","groupname");
		for(i=0;i<guys.size;i++)
		{
			if(isalive(guys[i]) && issentient(guys[i]))
			{
				guys[i] delete();
			}
		}				
	}
}

// Sets up all of the friendly characters that will be with
// the player the entire level.
Setup_Characters()
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
	vassili character\_utility::new();
	vassili character\RussianArmyvassili::main();
	vassili thread maps\_utility_gmi::magic_bullet_shield();
	level.vassili = vassili;

	// Miesha
	character\RussianArmyMiesha_Radio::precache();
	miesha = getent("miesha","targetname");
	miesha.groupname = "friends";
	miesha.goalradius = 32;
	miesha.animname = "miesha";
	miesha.original_animname = "miesha";
	miesha.current_spot = 0;
	miesha.accuracy = 0.7;
	miesha.bravery = 50;
	miesha.grenadeammo = 2;
	miesha.maxsightdistsqrd = 9000000; // 3000 units
	miesha character\_utility::new();
	miesha character\RussianArmymiesha_radio::main();
	miesha thread maps\_utility_gmi::magic_bullet_shield();
	level.miesha = miesha;

	// Antonov
	character\RussianArmyantonov::precache();
	antonov = getent("antonov","targetname");
	antonov.animname = "antonov";
	antonov.accuracy = 0.05;
	antonov.pacifist = true;
	antonov.ignoreme = true;
	antonov.name = "Sgt. Antonov";
	antonov.maxsightdistsqrd = 3000; // 54.8 units
	antonov character\_utility::new();
	antonov character\RussianArmyantonov::main();
	antonov thread maps\_utility_gmi::magic_bullet_shield();
	antonov.second_squad_charge = false;
	antonov.playing_event1_anim = false;
	level.antonov = antonov;

	// RedShirt
//	character\Vassili::precache();
	redshirt = getent("redshirt","targetname");
	redshirt.groupname = "friends";
	redshirt.goalradius = 32;
	redshirt.accuracy = 1.0;
	redshirt.animname = "redshirt";
	redshirt.original_animname = "redshirt";
	redshirt.bravery = 100;
	redshirt.grenadeammo = 5;
	redshirt.suppressionwait = 1;
	redshirt.name = "Pvt. Zhukov";
	redshirt.maxsightdistsqrd = 9000000; // 3000 units
//	redshirt character\_utility::new();
//	redshirt character\redshirt::main();
	redshirt thread maps\_utility_gmi::magic_bullet_shield();
	level.redshirt = redshirt;

	level.friends = getentarray("friends","groupname");

	commissar = getent("event1_commissar","targetname");
	commissar.dropweapon = false;
	commissar.pacifist = true;
	commissar.pacifistwait = 0;
	commissar.maxsightdistsqrd = 10; // sqr rt of 10 = x units
	commissar.weapon = "tt33";
	wait 1;
	commissar animscripts\shared::PutGunInHand("none");
	commissar attach("xmodel/stalingrad_megaphone", "TAG_WEAPON_RIGHT");
	commissar settakedamage(0);
	commissar.animname = "bullhorn_commissar";
	commissar thread anim_loop_solo(commissar, "stand_idle", undefined, "stop_anim", undefined);
}

Setup_Su152s()
{
	level.su152 = getentarray("event1_su152s","groupname");

	for(i=0;i<level.su152.size;i++)
	{
		level.su152[i].health = 1000000;
	}
}

Setup_Event1_MG42s()
{
	level.mg42_spotter = spawn("script_origin",(-1344,-7424, -100));

	if(getcvar("debug_mg42_spotter") == 1)
	{
		level.mg42_spotter thread Debug_MG42_Spotter();
	}

	gunners = getentarray("event1_allies_mg42_gunner","groupname");

	for(i=0;i<gunners.size;i++)
	{
		if(isai(gunners[i]))
		{
			gunners[i] thread maps\_utility_gmi::magic_bullet_shield();
			gunners[i].team = "neutral";
		}
	}

	level thread Event1_MG42s_Think();
}

Debug_MG42_Spotter()
{
	while(1)
	{
		line((2000, level.mg42_spotter.origin[1], level.mg42_spotter.origin[2]), (-3000, level.mg42_spotter.origin[1], level.mg42_spotter.origin[2]), (1,0,0));
		wait 0.06;	
	}
}

// Sets up the Binoc Triggers so we can blow up the mg42s/flakguns.
Binoc_Trigger_Setup()
{
	level thread Binoc_Cursor_Init_Timer();

	triggers = getentarray("binoc_trigger","targetname");

	level.objective2_total = triggers.size;
	for(i=0;i<triggers.size;i++)
	{
		if(isdefined(triggers[i].target))
		{
			targets = getentarray(triggers[i].target,"targetname");

			mortars = [];

			for(q=0;q<targets.size;q++)
			{
				if(targets[q].classname == "trigger_multiple")
				{
					player_trigger = targets[q];
				}
				else if(targets[q].classname == "script_origin")
				{
					mortars[mortars.size] = targets[q];
				}
			}

			triggers[i] thread Binoc_Trigger_Think(player_trigger, mortars);
		}
		else
		{
			println("^3(Setup_Binoc_Triggers) Warning!! No Targets for 'binoc_trigger'");
		}

		// TESTING!
//		triggers[i] thread test_debris(mortars);		

		println("");
		println("^5Binoc Trigger");
		println("^5------------------------------------");
		println("^5Binoc Trigger.script_idnumber: ", triggers[i].script_idnumber);
		println("^5Total Player Triggers: ", player_trigger," ^5Should ONLY be 'entity'");
		println("^5Total Mortars: ", mortars.size);
		println("^5------------------------------------");
	}

	println("");
	println("^5Total Binoc Triggers = ", triggers.size);
}

Music()
{
	level waittill("objective 2 complete");
	println("^3MusicPlay: kharkov1_start");
	musicplay("kharkov1_start");

	level waittill ("objective 4 start");
	musicStop(5);

	level waittill ("objective 5 start");

	println("^3MusicPlay: Kharkov1_buildings");
	musicplay("Kharkov1_buildings");
	level thread Music_Delay(62, "start_end_music");

	level waittill("start_end_music");
	musicStop(3);

	println("^3MusicPlay: Kharkov1_battle");
	musicplay("Kharkov1_battle");

	level waittill ("end_music");
	musicStop(5);
}

Music_Delay(time, ender)
{
	level endon(ender);
	wait time;
	musicStop(3);
}

// Controls the majority of the Objectives
Objectives()
{
	// "Assault Town"
	level thread Objective_1_Think();

	level waittill("objective 2 start");

	objective_add(2, "active", &"GMI_KHARKOV1_OBJECTIVE2", (-1584, -2528, -66));
	objective_current(2);

	level waittill("objective 2 complete");
	objective_state(2,"done");

	// "Take out defensive Positions"
	level thread Objective_3_Think();

	level waittill("objective 3 complete");
//	objective_state(3,"done");

	level waittill("objective 4 start");
	// Advance with tanks.
	objective_add(4, "active", &"GMI_KHARKOV1_OBJECTIVE4", (2152, 128, -152));
	objective_current(4);

	level waittill("objective 4 complete");
	objective_state(4,"done");
//	objective_state(1, "done");
//	objective_current(1);
	level notify("update_objective_1");

	// Clear out the building with Antonov.
	level waittill("objective 5 start");
	objective_state(1,"done");
	level thread Objective_5_Think();

	level waittill("objective 6 start");
	objective_state(5,"done");
	// Clear out the building.
	level thread Objective_6_Think();

	level waittill("objective 6 complete");

	// Take out the last tiger tank.
	objective_add(7, "active", &"GMI_KHARKOV1_OBJECTIVE7", (-2858, 5824, 80));
	objective_current(7);

	level waittill("objective 7 complete");
	objective_state(7,"done");
	objective_current(6);

//	level waittill("objective 1 complete");
//	objective_state(1,"done");

	level waittill("level complete");
	objective_state(6,"done");
}

// Updates the position of objective 1, "Assault Town"
Objective_1_Think()
{
	level endon("objective 1 complete");
	level endon("objective 5 start");

	position = [];
	position[1] = (-984, -4888, -120);
	position[2] = (-2224, -648, 124);
	position[3] = (-512, 2432, -74);
//	position[4] = (892, 4864, 16);
	position[4] = (1552, 3376, 56);	//moved from (1398, 3222, -26)
	position[5] = (776, 3350, 47);
	position[6] = (892, 4864, 16);
	position[7] = (-71, 4651, 208);
	position[8] = (-666, 4015, 208);

	position[9] = (-2176, 5824, 37);
  
	current_pos = 1;
	level.objective1_pos = current_pos;

	level thread objective1_print();

	objective_add(1, "active", &"GMI_KHARKOV1_OBJECTIVE1", position[current_pos]);
	objective_current(1);

	while(1)
	{
		if((current_pos > 3 && current_pos < 6))
		{
			while(distance(level.player.origin, position[current_pos]) > 256)
			{
				wait 0.25;
			}
		}
		else
		{
			level waittill("update_objective_1");
		}

		current_pos++;
		level.objective1_pos = current_pos;
		println("^5************************************************************OBJECTIVE CURRENT POS = ",current_pos);
		objective_current(1);
		objective_position(1, position[current_pos]);
		objective_ring(1);
	}
}

objective1_print()
{
	while(1)
	{
		println("^5level.objective1_pos: ",level.objective1_pos);
		wait 0.5;
	}
}

// Updates the position of objective 3, which moves from one defensive position to the next.
Objective_3_Think()
{
	defensive_targets = getentarray("binoc_trigger","targetname");
	target_num = defensive_targets.size;

	position = [];
	position[1] = (-1744, -2136, 64);
	position[2] = (-872, -1088, 176);
	position[3] = (600, -1728, 128);
	
	current_pos = 1;

	objective_add(3, "active", &"GMI_KHARKOV1_OBJECTIVE3", position[current_pos]);
	objective_string(3, &"GMI_KHARKOV1_OBJECTIVE3", target_num);
	objective_current(3);

	while(target_num > 0)
	{
		level waittill("update_objective_3");
		target_num--;
		current_pos++;

		if(isdefined(position[current_pos]))
		{
			objective_position(3, position[current_pos]);
		}
		objective_string(3, &"GMI_KHARKOV1_OBJECTIVE3", target_num);
	}

	objective_state(3, "done");
//	objective_current(1);
}

Objective_5_Think()
{
	level endon("objective 5 complete");

	position = [];
	position[1] = (-71, 4651, 208);
	position[2] = (-666, 4015, 208);

//	position[9] = (-2176, 5824, 37);
  
	current_pos = 1;
	level.objective1_pos = current_pos;

//	level thread objective1_print();

	objective_add(5, "active", &"GMI_KHARKOV1_OBJECTIVE5", position[current_pos]);
	objective_current(5);

	while(1)
	{
		if((current_pos > 0 && current_pos < 2))
		{
			while(distance(level.player.origin, position[current_pos]) > 256)
			{
				wait 0.25;
			}
		}
		else
		{
			level waittill("update_objective_5");
		}
		current_pos++;
		level.objective1_pos = current_pos;
		println("^5************************************************************OBJECTIVE CURRENT POS = ",current_pos);
		objective_current(5);
		objective_position(5, position[current_pos]);
		objective_ring(5);
	}
}
Objective_6_Think()
{
	level endon("objective 6 complete");

	position = [];
	position[1] = (-304, 2828, 208);
	position[2] = (-881, 4132, 208);
	position[3] = (-1450, 4154, 208);
	position[4] = (-2176, 5824, 37);


  
	current_pos = 1;
	level.objective1_pos = current_pos;

	level thread objective1_print();

	objective_add(6, "active", &"GMI_KHARKOV1_OBJECTIVE6", (-304, 2828, 234));
	objective_current(6);

	while(1)
	{
		if((current_pos > 1 && current_pos < 4))
		{
			while(distance(level.player.origin, position[current_pos]) > 256)
			{
				wait 0.25;
			}
		}
		else
		{
			level waittill("update_objective_6");
		}
		current_pos++;
		level.objective1_pos = current_pos;
		println("^5************************************************************OBJECTIVE CURRENT POS = ",current_pos);
		objective_current(6);
		objective_position(6, position[current_pos]);
		objective_ring(6);
	}
}

// If the player drops the binoculars, make an icon for them. (compass).
Dropped_Binocular_Think()
{
	tracker = false;
	while(1)
	{
		while(level.player hasWeapon("binoculars"))
		{
			objective_delete(15);
			tracker = false;
			wait 0.5;
		}

		if(!tracker)
		{
			tracker = true;
			binocs = getent("weapon_binoculars","classname");
			println("Weapon: ",binocs," location: ",binocs.origin);
			println("========================================");
			println("");

//			objective_add(15, "current", &"GMI_KHARKOV1_OBJECTIVE3", binocs.origin, "gfx/hud/hud@objective_friendly_chat.dds");
		}

		binocs = getent("weapon_binoculars","classname");
		if(isdefined(binocs))
		{
			print3d((binocs.origin + (0,0,100)), "!",(1,0,0), 5, 3);
		}

		wait 0.06;
	}
}

Event1_MG42s_Think()
{
	level endon("stop_event1_mg42s");

	mg42s = getentarray("event1_mg42s","groupname");

	commissar = getent("event1_commissar","targetname");

	warning[0] = "warning1";
	warning[1] = "warning2";
	warning[2] = "warning3";

	traitor_line[0] = "traitor1";
	traitor_line[1] = "traitor2";

	traitor = false;
	level.traitor_warning = false;
	while(1)
	{
		if(level.player.origin[1] < level.mg42_spotter.origin[1] && isalive(level.player))
		{
			if(!level.traitor_warning)
			{
				println("^5Traitor Warning: TRUE");
				level.traitor_warning = true;
				level thread Event1_MG42s_Timer();

				num = randomint(warning.size);
				
				commissar anim_single_solo(commissar, warning[num], undefined, undefined);
				if(level.player.origin[1] < level.mg42_spotter.origin[1] && isalive(level.player))
				{
					continue;
				}
			}

			if(!traitor)
			{
				num = randomint(traitor_line.size);
				traitor = true;
				commissar thread anim_single_solo(commissar, traitor_line[num], undefined, undefined);
			}

			for(i=0;i<mg42s.size;i++)
			{
				mg42s[i] setmode("manual_ai");
				mg42s[i] settargetentity(level.player);
				wait (0.25 + randomfloat(0.5));
			}
		}
		else
		{
			traitor = false;
			for(i=0;i<mg42s.size;i++)
			{
				mg42s[i] cleartargetentity();
				mg42s[i] setmode("auto_ai");
//				wait 0.25;
				mg42s[i] notify("turretstatechange");
			}
		}

		wait 0.5;
	}
}

Event1_MG42s_Testing()
{
	mg42s = getent("misc_mg42","classname");

	for(i=0;i<mg42s.size;i++)
	{
		mg42s[i] thread MG42_debug();
	}
}

MG42_debug()
{
	while(1)
	{
		target = self getturrettarget();
		line(self.origin, target.origin, (1,0,0));
		wait 0.06;
	}
}

Event1_MG42s_Timer()
{
	wait 10;
	level.traitor_warning = false;
	println("^5Traitor Warning: FALSE");
}

Event1_MG42s_Spotter_Move(the_y, time)
{
	level.mg42_spotter moveto((level.mg42_spotter.origin[0], the_y, level.mg42_spotter.origin[2]), time, 0, 0);
}

// Starts the assault on the Village.
Event1()
{
	level waittill ("starting final intro screen fadeout");

//	wait 1;

//	level.antonov thread Temp_Dialogue((&"GMI_KHARKOV1_TEMP_ANTONOV_EVERYONE_CHARGE"), 3);
	level.antonov thread anim_single_solo(level.antonov, "event1_start");

	level waittill("finished intro screen");

	if(getcvar("skipto_event3") == "1")
	{
		return;
	}
	if(getcvar("skipto_event4") == "1")
	{
		return;
	}
	if(getcvar("skipto_end") == "1")
	{
		return;
	}

	event1_chain1 = getnode("event1_chain1","targetname");

	// Start Friendlychain
	level.player setfriendlychain(event1_chain1);

	friends = getentarray("friends","groupname");
	other_friendlies = getentarray("allies_group1","groupname");

	all = add_array_to_array(other_friendlies, friends);
	for(i=0;i<all.size;i++)
	{
		all[i].goalradius = 32;
		all[i] setgoalentity(level.player);
	}

	level thread Event1_Group2_MoveUp(2, "crouch", true);

	trigger = getent("event1_takecover","targetname");
	trigger waittill("trigger");

	level thread Event1_Antonov_Loop();

	println("^6TAKE COVER!!");

	attrib["goalradius"] = 32;
	
	if(getcvar("no_enemy_1") != "1")
	{
		// Spawn Enemies in the buildings, with MG42s.
		level thread maps\_respawner_gmi::respawner_setup("event1_axis_group1", undefined, attrib, undefined, undefined);
	
		// SPawn guys that come to attack the player.
		attrib["goalradius"] = 256;
		level thread maps\_respawner_gmi::respawner_setup("event1_axis_group1b", undefined, attrib, undefined, undefined);
	}

	if(getcvar("quick_event1") == "1")
	{
		tanks = getentarray("event1_tanks","groupname");
		for(i=0;i<tanks.size;i++)
		{
			tanks[i] setspeed(300, 10000);
		}
		delay = 1;
	}
	else
	{
		delay = 30;
	}
	
	level thread Event1_MG42s_Spotter_Move(-5800, 30);
		//   Plane_Spawner(type, start_node, delay, health, start_sound, plane_num, spawn_delay)
	level thread Plane_Spawner("bf109", "bf109_1_start", 1, undefined, true);
	level thread Plane_Spawner("bf109", "bf109_2_start", (1 + 0.25), undefined, true);

	wait delay;

	if(getcvar("quick_event1") == "1")
	{
		if(isdefined(tanks))
		{
			for(i=0;i<tanks.size;i++)
			{
				tanks[i] resumespeed (10000000000);
			}
		}
	}

	// Tells Antonov to stop looping, so he can say his line.
//	level.antonov notify("event1_stop_loop");
//	level.antonov thread Temp_Dialogue((&"GMI_KHARKOV1_TEMP_ANTONOV_2ND_SQUAD_CHARGE"), 3);

	// Tells the second squad to charge, and get blown away.
	level thread Event1_Group2_MoveUp(3, "stand");
	level notify("T34s go");
}

// Tells Group2 of friendly AI to moveup
// Num: Integer, what number on the node to go to.
// Stance: "crouch" or "stand" or "prone" also "all" or "not_prone"
Event1_Group2_MoveUp(num, stance, pacifist)
{
	group2_nodes = getnodearray("group2_spot" + num,"targetname");
	println("^5Group2 Nodes ",group2_nodes.size);

	group2 = getentarray("allies_group2","groupname");
	println("^5Group2 ",group2.size);
	for(i=0;i<group2.size;i++)
	{
		if(isalive(group2[i]))
		{
			// Enable Pacifist, so the 2nd squad does not fire and slow down the game.
			if(isdefined(pacifist))
			{
				group2[i].original_pacifist = group2[i].pacifist;
				group2[i].pacifist = pacifist;
			}
			else
			{
				group2[i] notify("stop_pacifist_think");
				group2[i].pacifist = 0;
			}

			group2[i].goalradius = 32;

			if(isdefined(stance))
			{
				if(stance == "all")
				{
					group2[i] allowedstances("crouch", "prone", "stand");
				}
				else if(stance == "not_prone")
				{
					group2[i] allowedstances("crouch", "stand");
				}
				else
				{
					group2[i] allowedstances(stance);
				}
			}

			group2[i] setgoalnode(group2_nodes[i]);

			
			if(isdefined(pacifist))
			{
				group2[i] thread Event1_Pacifist_Think();
			}

			if(num == 3)
			{
				group2[i] thread AI_Bloody_Death_Think();
			}
		}
	}
}

// Tells the AI when to turn on their pacifist.
Event1_Pacifist_Think()
{
	self endon("stop_pacifist_think");
	self waittill("goal");
	self.pacifist = 0;
}

// Commissar (Antonov) running back and forth telling the troops to keep firing
Event1_Antonov_Loop()
{
	level.antonov endon("event1_stop_loop");
	wait 5;

	dialogue[0] = 1;
	dialogue[1] = 2;
	dialogue[2] = 3;
	// No sound for 4.
//	dialogue[3] = 4;

	nodes = getnodearray("event1_commissar_loop","targetname");
	count = 100;
	while(1)
	{
		for(i=0;i<nodes.size;i++)
		{
			println("^5COUNT IS: ",count);
			if(count > (dialogue.size - 1))
			{
				dialogue = maps\_utility_gmi::array_randomize(dialogue);
				for(q=0;q<dialogue.size;q++)
				{
					println("^5DIALOGUE[" + q + "] = ", dialogue[q]);
				}
				count = 0;
			}

			level.antonov.goalradius = 32;
			level.antonov setgoalnode(nodes[i]);
			level.antonov waittill("goal");
			level.antonov allowedstances("crouch");
			wait 1;
			level.antonov.playing_event1_anim = true;
			println("^3count: ",count);
			println("^5event1_loop: ",("event1_loop" + dialogue[count]));

			level.antonov animscripts\point::point(level.antonov.angles[1], orientate_to_player, ("event1_loop" + dialogue[count]), vec);

//			level.antonov anim_single_solo(level.antonov, ("event1_loop" + dialogue[count]));
			level.antonov.playing_event1_anim = false;
			count++;
			wait 1;
		}
		wait 1;
	}
}

// Event1 Tanks shoot at the mg42s at the beginning of the map.
Event1_Tanks_Shoot_At_MG42s()
{
	t34_1 = getent("t34_1","targetname");
	t34_2 = getent("t34_2","targetname");

	t34_1 notify("stop_random_turret_turning");
	t34_2 notify("stop_random_turret_turning");

	level notify("stop_event1_tank_fire");

	targets = getentarray("event1_tank_target","targetname");
	for(i=0;i<targets.size;i++)
	{
		targets[i] delete();
	}

	level thread maps\_respawner_gmi::respawner_stop("event1_axis_group1");
	level thread maps\_respawner_gmi::respawner_stop("event1_axis_group1b");

	// Have the 3 tanks that don't shoot at the MG42, do random turning.
	t34s = getentarray("event1_tanks","groupname");
	for(i=0;i<t34s.size;i++)
	{
		if(t34s[i].targetname != "t34_1" && t34s[i].targetname != "t34_2")
		{
			t34s[i] thread Tank_Turret_Random_Turning();
		}
	}

	for(i=1;i<5;i++)
	{
		level thread Event1_Tank_Targets_Think(i);
		if(i==1 || i==3)
		{
			target = getent("mg42_" + i,"targetname");
			start_delay = (1 + randomfloat(3));
			shot_delay = 2;

			t34_1 thread Tank_Fire_Turret(undefined, (target.origin - (0,0,16)), start_delay, shot_delay);
			t34_1 waittill("turret_fire_done");
		}
		else if(i==2 || i==4)
		{
			target = getent("mg42_" + i,"targetname");
			start_delay = (1 + randomfloat(3));
			shot_delay = 0.5;

			if(i== 4)
			{
				// All axis is dead, move up.
				level thread Event2();
			}

			t34_2 thread Tank_Fire_Turret(undefined, (target.origin - (0,0,16)), start_delay, shot_delay);
			t34_2 waittill("turret_fire_done");
		}
	}

	// Deletes the death trigger.
	level thread MG42_Kill_Player_Delete("event1");

	level thread Clean_Up_By_Death("event1_axis_group1", undefined, 1, 2);
	level thread Clean_Up_By_Death("event1_axis_group1b", undefined, 1, 2);

}

// When a script_exploder is blown up, this function will 
// delete the mg42s along with it.
Event1_Tank_Targets_Think(num)
{
	level waittill("killexplodertriggers" + num);
	println("^3(Event1_Tank_Targets_Think) Num: ",num);
	axis_group1 = getentarray("event1_axis_group1_ai","targetname");
	for(i=0;i<axis_group1.size;i++)
	{
		if(isalive(axis_group1[i]) && isdefined(axis_group1[i].script_mg42))
		{
			if(axis_group1[i].script_mg42 == num)
			{
				// Kills the Guy on the turret before the MG42 errors out
				// with animation or whatever other errors.
				axis_group1[i] dodamage(axis_group1[i].health + 50, axis_group1[i].origin);
			}
		}
	}

	mg42 = getent("mg42_" + num,"targetname");
	wait 0.1;
	mg42 delete();
}

// Setup the T34s
Event1_Setup_Tanks()
{
	if(getcvar("skipto_end") == "1")
	{
		return;
	}

	tanks = getentarray("event1_tanks","groupname");
	for(i=0;i<tanks.size;i++)
	{
		println("^3Setting up Tank: ",tanks[i].targetname);
		path = getvehiclenode(tanks[i].targetname + "_start","targetname");
		tanks[i].health = 500;
		// Default = 400, forward radius to see if the tank needs to avoid another tank.
		tanks[i].coneradius = 100;
		tanks[i] maps\_t34_gmi::init();
		tanks[i] thread maps\_tankgun_gmi::mgoff();

		tanks[i].attachedpath = path;
		tanks[i] attachpath(path);
		tanks[i] startpath();
		tanks[i] setspeed (0, 5);
	}

	wait 5;

	for(i=0;i<tanks.size;i++)
	{
		tanks[i] resumespeed (10);
		tanks[i] thread Tank_Turret_Random_Turning();
		tanks[i] thread Event1_Random_Tank_Fire();

		tanks[i] thread Event1_Tank_Think();

		if(tanks[i].targetname != "t34_1")
		{
			tanks[i] thread Tank_Health_Regen(5000);
		}
	}
}

// Thinking for th T34s, mainly for moving up.
Event1_Tank_Think()
{
	self endon("death");
	self endon("stop_tank_think");

	if(!isdefined(self.attachedpath))
	{
		println("^1NO '.ATTACHEDPATH' FOUND FOR TANK, ",self.targetname);
		return;
	}
	pathstart = self.attachedpath;

	pathpoint = pathstart;
	arraycount = 0;

	// Puts the pathpoints in order, from start to finish.
	while(isdefined (pathpoint))
	{
		pathpoints[arraycount] = pathpoint;
		arraycount++;
		if(isdefined(pathpoint.target))
		{
			pathpoint = getvehiclenode(pathpoint.target, "targetname");

		}
		else
		{
			break;
		}
	}

	pathpoint = pathstart;

	// Checks to see if there is a script_noteworthy on each node for the tank.
	for(i=0;i<pathpoints.size;i++)
	{
		if(isdefined(pathpoints[i].script_noteworthy))
		{
			self setWaitNode(pathpoints[i]);
			self waittill ("reached_wait_node");
			if(level.skipto > 0)
			{
				if(!isdefined(self.skipto))
				{
					self.skipto = level.skipto;

					if(level.skipto == 5)
					{
						if(self.targetname == "t34_5")
						{
							self.skipto = 6;
						}
					}
				}
			}

			if(isdefined(self.skipto) && self.skipto > 0)
			{
//				println(self.targetname," Skip!!!! Skipto = ", self.skipto);
				self.skipto--;
				continue;
			}
			else if(isdefined(self.skipto) && self.skipto == 0)
			{
//				println(self.targetname," Reduce Speed!!!!");
				self resumespeed (10000000000);
				wait 0.1;
			}

			if(pathpoints[i].script_noteworthy == "waitnode")
			{
				self setspeed (0, 5);
				println(self.targetname," ^5Reached WAIT Node");
				self notify("reached_specified_waitnode");
				self disconnectpaths();
				level waittill("T34s go"); // If you put in the while, take this out.
				// If you want to control each one individually, 
				//you'd insert a while here.
//				while(1)
//				{
//					level waittill("sherman tanks go");
//					if(self.can_go)
//					{
//						break;
//					}
//				}
				println("^3T34s Go!");

				if(isdefined(pathpoints[i].script_delay))
				{
					wait pathpoints[i].script_delay;
				}

				self resumespeed (10000);
				self connectpaths();
			}
			else if(pathpoints[i].script_noteworthy == "blow_t34_1")
			{
				level.event2_t34s_in_position++;

				self setspeed (0, 5);
				println(self.targetname," ^5Reached WAIT Node");
				self notify("reached_specified_waitnode");
				self disconnectpaths();
				level waittill("T34s go"); // If you put in the while, take this out.

				println("^3T34s Go!");
				self resumespeed (10000);
				self connectpaths();

			}
			else if(pathpoints[i].script_noteworthy == "event3_start_panzer_defend")
			{
				level thread Event3_Panzer_Defend();
			}
			else if(pathpoints[i].script_noteworthy == "event1_fire")
			{
				// Level threads this as the function calls the tanks.
				level thread Event1_Tanks_Shoot_At_MG42s();
			}
			else if(pathpoints[i].script_noteworthy == "t34s_go")
			{
				// Level threads this as the function calls the tanks.
				level notify("T34s go");
			}
			else if(pathpoints[i].script_noteworthy == "event2_t34_3_fire")
			{

				self setspeed (0, 5);
				println(self.targetname," ^5Reached WAIT Node");
				self notify("reached_specified_waitnode");
				self disconnectpaths();

				self thread Tank_Turret_Think(undefined,undefined,true);
				targets = getentarray("event2_t34_3_targets","targetname");
				self thread Tank_Add_Targets(targets);

				level waittill("T34s go"); // If you put in the while, take this out.

				self notify("stop_turret_think");
				self.enemy_targets = []; // Reset target list.
				level thread Tank_Reset_Turret(self);
				self notify("start_random_turret_turning");
				println("^3T34s Go!");

				if(isdefined(pathpoints[i].script_delay))
				{
					wait pathpoints[i].script_delay;
				}
				self resumespeed (10000);
				self connectpaths();
			}
			else if(pathpoints[i].script_noteworthy == "event3_avoid_check")
			{
				self thread Event3_Avoid_Check(pathpoints[i]);
			}
			else if(pathpoints[i].script_noteworthy == "event3_t34_4_go")
			{
				level notify("T34_4_go");
			}
			else if(pathpoints[i].script_noteworthy == "event3_blow_wall2")
			{
				self thread Event3_Blow_Wall2();
			}
			else if(pathpoints[i].script_noteworthy == "event3_kill_tiger")
			{
				self thread Event3_Kill_Tiger();
			}

		}
	}
}

Event1_Random_Tank_Fire()
{
	level endon("stop_event1_tank_fire");
	wait 5 + randomfloat(5);

	self notify("stop_random_turret_turning");

	if(!isdefined(level.event1_tank_targets))
	{
		targets = getentarray("event1_tank_target","targetname");
		fake_targets = getentarray("event1_fake_tank_target","targetname");

		level.event1_tank_targets = add_array_to_array(targets, fake_targets);
	}

//	turret_fx = loadfx ("fx/muzzleflashes/turretfire.efx");

	while(1)
	{
		// Choose target
		random_num = randomint(level.event1_tank_targets.size);

		wait (3 + randomfloat(3));

		if(level.event1_tank_targets[random_num].targetname == "event1_tank_target")
		{
			println("^5Real Target");
			self Tank_Fire_Turret(level.event1_tank_targets[random_num], undefined, 0, 2, undefined, true);
		}
		else
		{
			self setTurretTargetVec((level.event1_tank_targets[random_num].origin[0], level.event1_tank_targets[random_num].origin[1], self.origin[2]));
			self waittill("turret_on_target");

			wait randomfloat(2);

			self clearTurretTarget();

			println("^5Fake Target");
			playfxontag(level.event1_turret_fx, self, "tag_flash");
			self playsound("t34_fire");
			self thread Event1_Random_Fake_Targets(level.event1_tank_targets[random_num]);
	
			forward_angles = anglestoforward(self.angles);
			vec = self.origin + maps\_utility_gmi::vectorScale(forward_angles, 100);
			self joltBody (vec, 1, 0, 0);
		}
	}
}

Event1_Random_Fake_Targets(target)
{
//	target_fx = loadfx ("fx/weapon/explosions/rocket_dirt.efx");
	dist = distance(self.origin, target.origin);
	
	delay = dist / 7500;

	wait delay;
	soundnum = randomint(3) + 1;

	if(soundnum == 1)
	{
		target playsound ("mortar_explosion1");
	}
	else if (soundnum == 2)
	{
		target playsound ("mortar_explosion2");
	}
	else
	{
		target playsound ("mortar_explosion3");
	}

	playfx ( level.event1_fake_target, target.origin );
	earthquake(0.15, 2, target.origin, 850);
	radiusDamage (target.origin, 512, 400,  1);
}

// Event2, tank gets blown up, and player blows up flak gun.
Event2()
{
	level thread Event2_Commissar_Delete();
//	level thread Event2_pak43_2_Think();
	level thread Event2_Fight_Loop();

	node = getnode("event1_antonov_get_ready","targetname");

	while(level.antonov.playing_event1_anim)
	{
		wait 0.1;
	}

	level.antonov notify("event1_stop_loop");

	level.antonov allowedstances("stand");
	level.antonov setgoalnode(node);
	level.antonov waittill("goal");
	wait 1;
	level.antonov anim_single_solo(level.antonov, "event1_push_forward", undefined, node);	
	level.antonov allowedstances("stand","crouch","prone");

	// Stop Antonov from looping.
//	level.antonov notify("event1_stop_loop");

	// Updates the Star Locator in the compass.
	level notify("update_objective_1");

//	level notify("T34s go");
	level thread Tank_Reset_Turret(getent("t34_1","targetname"));
	level thread Tank_Reset_Turret(getent("t34_2","targetname"), 0.5, "turret_fire_done");

	level thread Event2_Blow_Up_T34_1();

	for(i=0;i<level.friends.size;i++)
	{
		// Set their sight to 2000.
		level.friends[i].maxsightdistsqrd = 4000000;
	}

	level.ai_sight = 4000000;

	all_allies = getaiarray("allies");
	for(i=0;i<all_allies.size;i++)
	{
		if(isdefined(all_allies[i].groupname) && all_allies[i].groupname == "friends")
		{
			continue;
		}

		all_allies[i].maxsightdistsqrd = 4000000;
	}


	println("^2GO GO GO!!! EVENT2!!");
	event2_chain1 = getnode("event2_chain1","targetname");
	level.player setfriendlychain(event2_chain1);

	level.antonov.pacifist = true;
	level.antonov.pacifistwait = 0;
	level.antonov thread Anotonov_Movement(2, "all");
	PRINTLN("^3ANTONOV SHOULD BE GOING TO # 2");

	maps\_utility_gmi::chain_delete("event1_chain2"); // Turn off the TRIGGER_FRIENDLY chain in event1.

	level thread Event2_Blow_Wall();
}

Event2_Commissar_Delete()
{
	level notify("stop_event1_mg42s");

	mg42s = getentarray("event1_mg42s","groupname");

	gunners = getentarray("event1_allies_mg42_gunner","groupname");
	for(i=0;i<mg42s.size;i++)
	{
		for(f=0;f<mg42s.size;f++)
		{
			gunners[i] stopuseturret(mg42s[f]);
		}
	}

	commissar = getent("event1_commissar","targetname");
	commissar notify("stop_anim");
	guys = verify_and_add_to_array(gunners, commissar);

	for(i=0;i<guys.size;i++)
	{
		if(isalive(guys[i]))
		{
			guys[i] thread Event2_Commissar_Delete_Think();
		}
	}
}

Event2_Commissar_Delete_Think()
{
	node = getnode("event1_comm_death","targetname");
	self setgoalnode(node);
	self.goalradius = 4;
	self waittill("goal");

	self delete();
}

Event2_Fight_Loop()
{
//	trigger = getent("event2_group_trigger","targetname");
//	trigger waittill("trigger");

	attrib["goalradius"] = 32;

	// Mg42 guys.
	level thread maps\_respawner_gmi::respawner_setup("event1_axis_group2", undefined, attrib, undefined, undefined);
	level thread maps\_respawner_gmi::respawner_setup("event1_axis_group2b", undefined, attrib, undefined, undefined);

	// Allies coming over the wall.
	level thread maps\_respawner_gmi::respawner_setup("event2_allies_group1", undefined, attrib, undefined, undefined);	

	// Axis on top of facadeA
	level thread maps\_respawner_gmi::respawner_setup("event2_axis_group1b", undefined, attrib, undefined, undefined);

	level waittill("stop_event2_fight_loop");

	level thread maps\_respawner_gmi::respawner_stop("event2_allies_group1");	
	level thread Clean_Up_By_Death("event2_allies_group1", undefined, 1, 3);

	level thread maps\_respawner_gmi::respawner_stop("event2_axis_group1b");
	level thread Clean_Up_By_Death("event2_axis_group1b", undefined, 1, 3);
}

Event2_Blow_Wall()
{
	trigger = getent("event2_blow_wall","targetname");
	trigger waittill("trigger");

	for(i=2;i<6;i++)
	{
		tank = getent("t34_" + i ,"targetname");
		path = getvehiclenode(tank.targetname + "_start2","targetname");
		// Default = 400, forward radius to see if the tank needs to avoid another tank.
//		tank.coneradius = 100;

		tank.attachedpath = path;
		tank attachpath(path);
		tank notify("stop_tank_think");

		tank setspeed (0, 5);
	}

	dmg_trigger = getent("event2_blow_wall1_trigger","targetname");
	dmg_trigger maps\_utility_gmi::triggerOn();

	level.pak43_2 maps\_pak43_gmi::init(true);
	// Have Pak43_1 randomly fire
	level.pak43_2 thread maps\_pak43_gmi::pak43_random_fire(4, 2, "pak43_2_targets", undefined, true, true);

	t34_2 = getent("t34_2","targetname");
	target = getent("event2_blow_wall_target","targetname");

	t34_2 Tank_Fire_Turret(target, undefined, 0, 2);
	level thread Tank_Reset_Turret(t34_2, 1);


	for(i=2;i<6;i++)
	{
		tank = getent("t34_" + i ,"targetname");
		tank thread Event1_Tank_Think();
		tank resumespeed (10000);
	}


	println("^5SHOULD BE HERE!!!!!!!!!!!!!!!!!!! LAST!! ");
	event2_chain3 = getnode("event2_chain3","targetname");
	level.player setfriendlychain(event2_chain3);

	level thread Event2_Building_Battle();
}

Event2_Building_Battle()
{
	trigger = getent("event2_building_battle","targetname");
	trigger waittill("trigger");

	level thread Event2_End_Building_Battle();

	attrib["goalradius"] = 4;
	attrib["suppressionwait"] = 0.2;
	level thread maps\_respawner_gmi::respawner_setup("event2_axis_group2", undefined, attrib);
	level thread maps\_respawner_gmi::respawner_setup("event2_axis_group3", undefined, attrib);
}

Event2_End_Building_Battle()
{
	trigger = getent("event2_mg42_player_check","targetname");
	trigger waittill("trigger");

	level thread maps\_respawner_gmi::respawner_stop("event2_axis_group2");
}

// Blows up T34_1 and tells the guys to takecover.
Event2_Blow_Up_T34_1()
{
	level.pak43_1 thread maps\_pak43_gmi::init(true);

	tank = getent("t34_1","targetname");
	tank waittill("reached_end_node");
	tank disconnectpaths();

	trigger = getent("t34_1_check","targetname");
	trigger waittill("trigger");

	while(level.event2_t34s_in_position != 4)
	{
		wait 0.25;
	}

	level.pak43_1 setTurretTargetEnt(tank, (0, 0, 50));
	level.pak43_1 waittill("turret_on_target");
	level.pak43_1 notify("fire_turret");
	wait (randomfloat(3));
	radiusDamage (tank.origin, 512, tank.health + 100,  1);

	wait 0.5;
	
//	level.antonov thread Temp_Dialogue(&"GMI_KHARKOV1_TEMP_ANTONOV_EVENT2_TAKE_COVER", 3);

	level thread maps\_utility_gmi::chain_delete("event2_chain2");
	wait 0.25;
	node = getnode("event2_takecover","targetname");
	level.player setfriendlychain(node);

	level notify("objective 2 start");
	// anim_single_solo (guy, anime, tag, node, tag_entity, delay)

	node = getnode("event2_antonov_atguns","targetname");
//	level.antonov anim_reach_solo(level.antonov, "antonov_atguns", undefined, node);
	level.antonov allowedstances("stand");
	level.antonov.og_goalradius = level.antonov.goalradius;
	level.antonov.ignoreme = 1;
	level.antonov.goalradius = 0;

	level.antonov setgoalnode(node);
	level.antonov waittill("goal");
	println("^6Antonov: Anti-Guns! Yuri... Miesha, Over here!");
	level.antonov anim_single_solo(level.antonov, "antonov_atguns", undefined, node, undefined);
	level.antonov.goalradius = level.antonov.og_goalradius;
	level.antonov allowedstances("stand","crouch","prone");
	level.antonov thread Anotonov_Movement(3);
	PRINTLN("^3ANTONOV SHOULD BE GOING TO # 3");

	level thread Event2_Friends_Movment_Manual(0, undefined, true);

	level thread Event2_Take_Out_FlakGun();

	dmg_trigger = getent("event2_blow_wall1_trigger","targetname");
	dmg_trigger maps\_utility_gmi::triggerOff();
	
	// Have Pak43_1 randomly fire
	level.pak43_1 thread maps\_pak43_gmi::pak43_random_fire(4, 2, "pak43_1_targets", undefined, true);

	wait 0.5;
	level notify("T34s go");
}

// Dialogue telling the player to take out the flakgun
Event2_Take_Out_FlakGun()
{
	level waittill("antonov_reached_spot3");
	level.antonov pushPlayer(false); // Use as a "per instance" right now.
	wait 2;

	trigger = getent("event2_check_player","targetname");
	trigger waittill("trigger");

	level thread Event2_Friends_Movement_Setup();

//	level.antonov thread Temp_Dialogue(&"GMI_KHARKOV1_TEMP_ANTONOV_BINOC_EVENT1", 5);
	level.antonov anim_single_solo(level.antonov, "event2_start", undefined, level.antonov.assigned_node, undefined);

//	wait 3;

	if(!level.binoc_cursor_text["use"])
	{
		level thread Binoc_Cursor_Text("use");
	}

	level notify("objective 2 complete");

	maps\_utility_gmi::autosave(1);

	level.event2_assigned_spot = 0;

	level thread Event2_Friends_Movment_Manual(1);

	println("^6Miesha: Right away, comrade sgt.");
	level.miesha thread anim_single_solo(level.miesha, "miesha_rightaway");
}

// Setsup MG42_cover, and tells Friends to moveup.
Event2_Transition_To_Spot7()
{
	level thread MG42_Cover();

	// Either the player hits a trigger, or it automatically happens
	// after the specified wait.
	level thread Event2_Transition_Trigger();
	level thread Event2_Transition_Wait();

	level waittill("event2_transition_go");

	event2_axis_group1 = getentarray("event2_axis_group1","groupname");
	for(i=0;i<event2_axis_group1.size;i++)
	{
		spawned = event2_axis_group1[i] dospawn();
	}

	door = getent("event2_door1","targetname");
	door playsound("wood_door_kick");
	door rotateto((0,-122,0), 0.4, 0.1, 0.1);
	door waittill("rotatedone");
	door connectpaths();

	while(level.flag["miesha_calling_artillery"])
	{
		wait 0.1;
	}

	level.flag["miesha_ready_for_artillery"] = false;

	level.miesha thread anim_single_solo(level.miesha, "miesha_letsgo");

	level thread Event2_Friends_Movment_Manual(4, 3);
}

Event2_Transition_Wait()
{
	wait 13;
	level notify("event2_transition_go");
}

Event2_Transition_Trigger()
{
	trigger = getent("event2_trans_trigger","targetname");
	trigger waittill("trigger");

	level notify("event2_transition_go");
}

// When moving through the building... Binocular Section.
Event2_Friends_Movement_Setup()
{
	triggers = getentarray("event2_binoc","targetname");

	for(i=0;i<level.friends.size;i++)
	{
		level.friends[i].original_goalradius = level.friends[i].goalradius;
	}

	println("");
	println("^2-------------------------------------------------------------");
	println("");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread Event2_Friends_Movement_Trigger_Think();

		// Hide specific triggers.
		if(isdefined(triggers[i].groupname) && triggers[i].groupname != "event2_area1")
		{
			triggers[i] maps\_utility_gmi::triggerOff();
		}

		// Below is for debug.
		println("^2EVENT2_BINOC TRIGGER FOUND");
		println("^2--------------------------");
		println("");

		if(isdefined(triggers[i].script_idnumber))
		{
			println("^2script_idnumber = ", triggers[i].script_idnumber);
			println("");

			name[0] = "miesha";
			name[1] = "vassili";
			name[2] = "redshirt";
			for(q=0;q<name.size;q++)
			{
				node = getnode(name[q] + "_spot" + triggers[i].script_idnumber,"targetname");
				if(isdefined(node))
				{
					println("^2" + name[q] + "_spot" + triggers[i].script_idnumber + " Node Found");
				}
				else
				{
					println("^1Missing! Node: ", "^1" + name[q] + "_spot" + triggers[i].script_idnumber);
				}
			}
		}
		else
		{
			println("^1Missing script_idnumber");
		}

		if(isdefined(triggers[i].groupname))
		{
			println("");
			println("^2GroupName = ", triggers[i].groupname);
		}
		else
		{
			println("");
			println("^3Groupname Not Found.");
		}

		println("^2--------------------------");
	}
	println("^2-------------------------------------------------------------");
	println("");

	//fix bug if player goes back- turn off these trigs once miesha reaches spot
	level waittill("miesha_at_spot");
	for(i=0;i<triggers.size;i++)
	{
		// Hide specific triggers.
		if(isdefined(triggers[i].groupname) && triggers[i].groupname == "event2_area1")
		{
			triggers[i] maps\_utility_gmi::triggerOff();
		}
	}
	println("^3 event2_area1 TRIGGERS ARE OFF!!!");

}

// Think function for the triggers... Once the player walks through it, it
// assigns the friends special variables and the corresponding node.
Event2_Friends_Movement_Trigger_Think()
{
	level endon("binoc_section_cleared");
	while(1)
	{
		self waittill("trigger");

		if(isdefined(self.script_delay))
		{
			wait self.script_delay;
		}

		level.event2_assigned_spot = self.script_idnumber;

		if(!level.flag["miesha_3rd_floor"] && self.script_idnumber == 7)
		{
			level.flag["miesha_3rd_floor"] = true;
			level.miesha thread anim_single_solo(level.miesha, "miesha_third_floor");
		}

		nodes = getnodearray("trigger.target","targetname");
		for(i=0;i<level.friends.size;i++)
		{
			if(isalive(level.friends[i]))
			{
				// Special settings.
				if(isdefined(self.script_noteworthy))
				{
					if(self.script_noteworthy == "pacifist_on")
					{
						level.friends[i].pacifist = true;
					}
					else if(self.script_noteworthy == "pacifist_off")
					{
						level.friends[i].pacifist = false;
					}
				}

				level.friends[i].assigned_spot = self.script_idnumber;

				if(level.friends[i].targetname == "redshirt" && level.friends[i].assigned_spot > 5)
				{
					if(isalive(level.friends[i]))
					{
						level.friends[i].assigned_spot = 5;
					}
					else
					{
						continue;
					}
				}
		
				node = getnode(level.friends[i].targetname + "_spot" + level.friends[i].assigned_spot,"targetname");
	
				println(level.friends[i].targetname," ^5Set Goal Node ",level.friends[i].assigned_spot);
		
				level.friends[i] notify("new spot");
				level.friends[i].goalradius = 32;
				level.friends[i] setgoalnode(node);
	
				if(isdefined(node.script_noteworthy) && node.script_noteworthy == "redshirt_die")
				{
					msg = "redshirt_die";
				}
		
				level.friends[i] thread Event2_Friends_Movement_Think(msg);
			}
		}

		// Waiting here until a different trigger is triggered.
		while(level.event2_assigned_spot == self.script_idnumber)
		{
			wait 0.5;
		}
	}
}

Event2_Miesha_Radio_Idle()
{
	level.miesha.og_goalradius = level.miesha.goalradius;
	level.miesha.goalradius = 128;
	level.miesha.ignoreme = true;
	level.miesha.pacifist = true;
	level.miesha.og_dontavoidplayer = level.miesha.dontavoidplayer;
	level.miesha.dontavoidplayer = true;

	node = getnode("miesha_spot" + level.miesha.assigned_spot,"targetname");

	level.miesha anim_reach_solo(level.miesha, "radio_trans_in", undefined, node);

	level notify("miesha_at_spot");
	println("^3MIESHA AT SPOT!!!");


	level.miesha allowedstances("crouch");

	wait 1;

	level.miesha thread anim_single_solo(level.miesha, "radio_trans_in", undefined, node);
	
	// Spawn in the receiver.
	level.miesha waittillmatch("single anim","attach");

	left_hand_tag = level.miesha gettagorigin("TAG_WEAPON_LEFT");
	level.miesha.receiver = spawn("script_model",(left_hand_tag));
	level.miesha.receiver setmodel("xmodel/kharkov1_receiver");
	level.miesha.receiver linkto(level.miesha, "TAG_WEAPON_LEFT", (0,0,0), (0,0,0));

	level.miesha waittill("radio_trans_in");

	// For some reason Miesha does not turn his head. Have programmer investigate.
	// Works fine in test map, but no in kharkov1.
	level.miesha thread anim_loop_solo(level.miesha, "radio_wait", undefined, "stop_anim", node);
	wait 0.1;
	level.miesha thread animscripts\shared::lookatentity(level.player, 10000000, "casual");

	return;
}

// Movement think for friends. With special cases
Event2_Friends_Movement_Think(msg)
{
	// Endon, incase the player gets to a trigger before they got to their destination.
	self endon("new spot");

	self waittill("goal");

	if(self.targetname == "miesha")
	{
		level.flag["miesha_ready_for_artillery"] = true;		

		if(self.assigned_spot == 3 || self.assigned_spot == 7 || self.assigned_spot == 9)
		{
			// Say specific dialog, "Enemy Gun... Down there!"
			if(self.assigned_spot == 7)
			{
//				level.miesha anim_single_solo(level.miesha, "miesha_enemy_gun");
			}

			// Say specific dialog, "Enemy Tank... Down there!"
			if(self.assigned_spot == 9)
			{
				level.miesha anim_single_solo(level.miesha, "miesha_tank");
			}

			self Event2_Miesha_Radio_Idle();

			if(!isdefined(level.miesha_ready_dialogue) || level.miesha_ready_dialogue > 2)
			{
				level.miesha_ready_dialogue = 1;
			}

			// If talking already, waittill done.
			while(level.flag["miesha_talking"])
			{
				wait 0.5;
			}

			level.miesha anim_single_solo(level.miesha, ("miesha_ready" + level.miesha_ready_dialogue));

			level.miesha_ready_dialogue++;
		}
	}

	self notify("reached_spot" + self.assigned_spot);
	self.current_spot = self.assigned_spot;

	self.goalradius = self.original_goalradius;
	println(self.targetname," ^3Reached Spot ",self.current_spot);

	if(isdefined(msg))
	{
		if(msg == "redshirt_die")
		{
			if(self.targetname == "redshirt")
			{
				level.friends = maps\_utility_gmi::subtract_from_array(level.friends, self);
				println("New size of Friends ",level.friends.size);
				self thread Bloody_Death(true);
			}
		}
	}
}

// Manually move the guys forward.
Event2_Friends_Movment_Manual(spot_num, delay, get_there_quick)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	// Only need to check one of the guys, since they all get set at the same time.
	// This if is to prevent them going back to 4, if the player rushes, and hits the trigger to send them to 5.
	// Assigned_spot 7 is set through a binoc_trigger.
	println("^3Event2_Return_To_Antonov check, level.miesha.assigned_spot = ",level.miesha.assigned_spot);
	if(isdefined(level.miesha.assigned_spot) && level.miesha.assigned_spot == 5 && spot_num < 7)
	{
		return;
	}

	if(spot_num == 10)
	{
		level thread Event3();
	}
	
	for(i=0;i<level.friends.size;i++)
	{
		if(isdefined(get_there_quick) && get_there_quick)
		{
			level.friends[i] settakedamage(0);
			level.friends[i].pacifist = true;
			level.friends[i].pacifistwait = 0;
		}
		else
		{
			level.friends[i] settakedamage(1);
			level.friends[i].pacifist = false;
			level.friends[i].pacifistwait = 0.25;
		}

		level.friends[i].assigned_spot = spot_num;
	
		node = getnode(level.friends[i].targetname + "_spot" + level.friends[i].assigned_spot,"targetname");
		println(level.friends[i].targetname," ^5Set Goal Node ",level.friends[i].assigned_spot);
	
		level.friends[i] setgoalnode(node);
	}
}

// Turns on all of the "groupnamed" triggers.
Event2_Binoc_TriggerOn(groupname)
{
	triggers = getentarray("event2_binoc","targetname");
	for(i=0;i<triggers.size;i++)
	{
		if(isdefined(triggers[i].groupname) && triggers[i].groupname == groupname)
		{
			triggers[i] maps\_utility_gmi::TriggerOn();
		}
	}
}

// Deletes all of the "groupnamed" triggers.
Event2_Binoc_TriggerDelete(groupname)
{
	triggers = getentarray("event2_binoc","targetname");
	for(i=0;i<triggers.size;i++)
	{
		if(isdefined(triggers[i].groupname) && triggers[i].groupname == groupname)
		{
			triggers[i] delete();
		}
	}
}

// Dialogue for checkpoint, plus spawns in some enemy in far building.
Event2_Transition_To_Spot9()
{
	maps\_utility_gmi::autosave(2);
	level thread Event2_Friends_Movment_Manual(8);

	level thread Event2_Radio_Transmision("antonov_goodjob", 8);

	level Event2_Kick_Door();

	level thread Event2_Friends_Movment_Manual(9);

	level thread Elefant_Firing();

	event2_chain4 = getnode("event2_chain4","targetname");
	level.player setfriendlychain(event2_chain4);
	
//	level waittill("antonov_reached_spot4");
//	wait 2;
//	trigger = getent("event2_checkpoint","targetname");
//	trigger waittill("trigger");
//
//	level.antonov thread Temp_Dialogue(&"GMI_KHARKOV1_TEMP_ANTONOV_EVENT2_CHECKPOINT", 3);
//
//	attrib["goalradius"] = 4;
//	level thread maps\_respawner_gmi::respawner_setup("event2_axis_group2", undefined, attrib);
//	level thread maps\_respawner_gmi::respawner_setup("event2_axis_group3", undefined, attrib);
//
//	wait 3;
//
//	event2_chain4 = getnode("event2_chain4","targetname");
//	level.player setfriendlychain(event2_chain4);
//
//	// Set friends goal to be the player.
//	for(i=0;i<level.friends.size;i++)
//	{
//		level.friends[i] setgoalentity(level.player);
//	}
//
//	wait 10;
//
//	level thread maps\_respawner_gmi::respawner_stop("event2_axis_group2");
//
//	level.num_alive = 0;
//	event2_axis_group2_ai = getentarray("event2_axis_group2_ai","targetname");
//	for(i=0;i<event2_axis_group2_ai.size;i++)
//	{
//		event2_axis_group2_ai[i].suppressionwait = 0;
//	}
//
//	while(event2_axis_group2_ai.size > 0)
//	{
//		event2_axis_group2_ai = getentarray("event2_axis_group2_ai","targetname");
//		println("^5(Event2_Axis_Group2_Death_Think) Guys Remaining: ",event2_axis_group2_ai.size);
//
//		wait 0.5;
//	}
//
//	println("MOVE ON");
//
//	event2_chain5 = getnode("event2_chain5","targetname");
//	level.player setfriendlychain(event2_chain5);
//
//	level thread Anotonov_Movement(5);
//	level waittill("antonov_reached_spot4");
//
//	trigger2 = getent("event2_mg42_4_check","targetname");
//	trigger2 waittill("trigger");	
//
//	level.antonov thread Temp_Dialogue(&"GMI_KHARKOV1_TEMP_ANTONOV_EVENT2_FINISH_BINOC", 3);
//	wait 3;
}

Event2_Radio_Transmision(alias, delay)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	// This is a radio transmission from Antonov, through miesha.
	level.miesha playsound(alias);
}


// Vassili kicks the door down.
Event2_Kick_Door()
{
	level.vassili waittill("goal");
	node = getnode("event2_kick_node","targetname");

	kick_guy[0] = level.vassili;

	println("Kick Guy = ", kick_guy, " size ", kick_guy.size);

	trigger = getent("event2_kick_door_trigger","targetname");
	trigger waittill("trigger");

	event2_spot9_guys = getentarray("event2_spot9_guys","targetname");
	for(i=0;i<event2_spot9_guys.size;i++)
	{
		spawned = event2_spot9_guys[i] dospawn();
	}

	maps\_anim_gmi::anim_pushPlayer(kick_guy);

	kick_anim[0] = "kick_door_1";
	kick_anim[1] = "kick_door_2";

	num = randomint(2);

	anim_reach(kick_guy, kick_anim[num], undefined, node);
	level maps\_anim_gmi::anim_dontPushPlayer(kick_guy);

	level thread anim_single(kick_guy, kick_anim[num], undefined, node);

	kick_guy[0] waittillmatch ("single anim", "kick");

	door = getent("event2_door2","targetname");
	door playsound("wood_door_kick");
	door moveto((-698,-1144,-195), 0.5, 0, 0.2);
	door rotateto((78,13,0), 0.5, 0, 0.2);

	door waittill("rotatedone");
	door connectpaths();

	wait 3;

	return;
}


// If cvar SKIPTO_EVENT3 == 1, then run this function.
SkipTo_Event3()
{
	wait 0.1;
	// Kill allies_group2
	allies_group2 = getentarray("allies_group2","groupname");
	for(i=0;i<allies_group2.size;i++)
	{
		allies_group2[i] delete();
	}

	// Take Redshirt out of the level.friends array.
	level.friends = maps\_utility_gmi::subtract_from_array(level.friends, level.redshirt);
	println("New size of Friends ",level.friends.size);

	// Kill Redshirt
	level.redshirt delete();

	// Set the friendlychain
	event2_chain5 = getnode("event2_chain5","targetname");
	level.player setfriendlychain(event2_chain5);

	// Move the player so he triggers the friendly_wave trigger
	level.player setorigin((-1368, -5976, -138));
	wait 0.5;
	// Move the player so he cannot see the guys teleport.
	level.player setorigin((-1664, -2240, 35));
	wait 0.1;

	// Teleport squad
	allies_group1 = getentarray("allies_group1","groupname");
	org = (-640, -960, -120);
	for(i=0;i<allies_group1.size;i++)
	{
		allies_group1[i] teleport(org);
		allies_group1[i] setgoalentity(level.player);

		org = ((org[0] - 36), org[1], org[2]);
	}

	// Teleport friends
	org = (256, -1704, 26);
	for(i=0;i<level.friends.size;i++)
	{
		println("Friends targetname : ",level.friends[i].targetname, " org ", org);
		level.friends[i] teleport(org);
		org = ((org[0] - 48), org[1], org[2]);
	}

	wait 0.1;

	// Teleport Player To new spot.
	level.player setorigin((136, -1640, 23));

	level.skipto = 1;
	// Move the tanks forward.
//	level notify("T34s go");
	for(i=1;i<6;i++)
	{
		tank = getent("t34_" + i,"targetname");
		tank setspeed(0, 10000);
	}

	level.miesha.assigned_spot = 9;
	level.miesha.current_spot = 9;

	wait 1;
	for(i=1;i<6;i++)
	{
		tank = getent("t34_" + i,"targetname");
		if(i!=1)
		{
			tank notify("stop_tank_think");
			tank attachpath(getvehiclenode("t34_" + i + "_start2","targetname"));
			tank.attachedpath = getvehiclenode("t34_" + i + "_start2","targetname");
			tank thread Event1_Tank_Think();
		}
		tank setspeed(100, 10000);

		if(tank.targetname == "t34_1")
		{
			tank waittill("reached_end_node");
		}
		else
		{
			tank waittill("reached_specified_waitnode");
		}

		println(tank.targetname, "^2 is in position");
	}

	level thread maps\_utility_gmi::exploder(5);

	level thread Event2_Friends_Movment_Manual(10);
	// Called from withing 	level thread Event2_Friends_Movment_Manual(10);
	level notify("stop_event1_tank_fire");

	// Update the objectives:
	level notify("update_objective_1");
	wait 0.25;
	level notify("objective 2 start");
	wait 0.25;
	level notify("objective 2 complete");
	wait 0.25;
	level notify("update_objective_3");
	wait 0.25;
	level notify("update_objective_3");
	wait 0.25;
	level notify("update_objective_3");
	wait 0.25;
	level notify("objective 3 complete");
	wait 0.25;
	level notify("update_objective_1");
}

// Sets everything up for event3, the panzerdudes.
Event3()
{
	level thread maps\_respawner_gmi::respawner_stop("event2_axis_group2");
	level thread Clean_Up_By_Death("event2_axis_group2", undefined, 1);
	// This is a radio transmission from Antonov, through miesha.
	level thread Event2_Radio_Transmision("antonov_rejoin", 6);

	trigger = getent("event3_start","targetname");
	trigger waittill("trigger");

	level notify("objective 4 start");

	// Disable the "blow_wall" trigger_damages
	for(i=1;i<3;i++)
	{
		trigger = getent("event3_blow_wall" + i + "_trigger","targetname");
		trigger maps\_utility_gmi::triggeroff();
	}

	level thread Event3_Tiger_Tank();

	t34_2 = getent("t34_2","targetname");

//	t34_2 setTurretTargetVec((552, -744, -117));
	target = getent("event3_blow_gate_target","targetname");
	t34_2 thread Tank_Fire_Turret(target, targetpos, start_delay, shot_delay, offset, validate, true);
	t34_2 waittill("hit_target");
//	t34_2 waittill("turret_on_target");
//	t34_2 FireTurret();

	event1_tanks = getentarray("event1_tanks","groupname");
	for(i=0;i<event1_tanks.size;i++)
	{
		if(isalive(event1_tanks[i]))
		{
			if(event1_tanks[i].targetname != "t34_5")
			{
				event1_tanks[i] notify("stop_health_regen");
			}
		}
	}

	level thread Tank_Reset_Turret(t34_2, 1);

	// Wait until the fence is taken out.
//	level waittill("killexplodertriggers6");

	level thread Anotonov_Movement(6);
	PRINTLN("^3ANTONOV SHOULD BE GOING TO #6");

	event3_chain1 = getnode("event3_chain1","targetname");
	level.player setfriendlychain(event3_chain1);

	for(i=0;i<level.friends.size;i++)
	{
		level.friends[i] setgoalentity(level.player);
	}

	level notify("T34s go");

	flyby_trigger = getent("event3_bf109_flyby1","targetname");
	flyby_trigger waittill("trigger");
//		     Plane_Spawner(type, start_node, delay, health, start_sound, plane_num, spawn_delay)
	level thread Plane_Spawner("bf109", "bf109_3_start", 0, undefined, true, 2, 2);
}

// Spawns in the panzerdudes.
Event3_Panzer_Defend()
{
	println("^5Start Event3_Panzer_Defend");

	attrib["goalradius"] = 4;
	attrib["pacifist"] = true;
	level thread maps\_respawner_gmi::respawner_setup("event3_panzer_group", undefined, attrib, 1, undefined);
}

// Sets up the tiger tank.
Event3_Tiger_Tank()
{
	trigger = getent("event3_tiger1_trigger","targetname");
	trigger waittill("trigger");

	level.miesha thread anim_single_solo(level.miesha, "miesha_tiger");

	tiger_tank = getent("event3_tiger1","targetname");

	// Accuracy is based on, the higher the number, the less accurate.
	tiger_tank.script_accuracy = 100;
	tiger_tank.rollingdeath = 1;
	// Set triggeredthink so that it waits before using the generic (_tank_gmi)
	// script for using the main turret... Instead, I'm using Tank_Turret_Think();
	tiger_tank.triggeredthink = true;

	tiger_tank maps\_tiger_gmi::init();
	tiger_tank.health = 1500;
	tiger_tank thread Tank_Turret_Think();

	tiger_node = getvehiclenode("event3_tiger1_start","targetname");
	tiger_tank attachpath(tiger_node);
	tiger_tank startpath();

	level thread Event3_T34s_Fire();

	tiger_tank thread test_tiger_kill_button();

	level thread Event3_Tiger_Death(tiger_tank);
	level thread Event3_Tiger_Death2(tiger_tank);

	wait 1;

//	level.antonov thread Temp_Dialogue(&"GMI_KHARKOV1_TEMP_ANTONOV_EVENT3_TIGER_TANK", 3);

	wait 3;

	// Add the T34s to the queue of the tiger tank.
	targets = getentarray("event1_tanks","groupname");
	tiger_tank Tank_Add_Targets(targets);

	tiger_tank waittill("reached_end_node");
	tiger_tank notify("deathrolloff");
	tiger_tank.rollingdeath = undefined;

	// Wait 15 seconds before going.
	wait 15;
	level.event3_t34s_go = true;
	level notify("T34s go");
}

// Makes the t34s fire at the Tiger tank, of course, missing.
Event3_T34s_Fire()
{
	wait 3;
	t34s = [];
	t34s[0] = getent("t34_2","targetname");
	t34s[1] = getent("t34_3","targetname");
//	t34s[2] = getent("t34_4","targetname");

	targets = getentarray("event3_t34_targets","targetname");

	for(i=0;i<t34s.size;i++)
	{
		t34s[i] Tank_Add_Targets(targets);
		t34s[i] thread Tank_Turret_Think(3, 7, true, "T34s go");
		println(t34s[i].targetname, "^5STARTED FIRING!");
	}
}

// Waits for the tank to come to a complete stop
// and is dead before telling the t34s to move up.
Event3_Tiger_Death(tiger_tank)
{
	tiger_tank waittill("deadstop");

//	wait 2;
	if(!level.event3_t34s_go)
	{
		level notify("T34s go");
	}
	wait 2;

	event3_chain3 = getnode("event3_chain3","targetname");

	level thread Anotonov_Movement(8);
	PRINTLN("^3ANTONOV SHOULD BE GOING TO # 8");

	level.player setfriendlychain(event3_chain3);
}

// Panzer Think.
Event3_Panzer_Think()
{
	self endon("death");
	self waittill("goal");

//	wait 1;

	println("^5Event3_Panzer_Think START!");

	// Find closest living tank
	tanks = getentarray("event1_tanks","groupname");
	for(i=0;i<tanks.size;i++)
	{
		if(!isalive(tanks[i]))
		{
			continue;
		}

		if(!isdefined(dist1))
		{
			dist1 = distance(tanks[i].origin, self.origin);
		}

		if(isdefined(closest_tank))
		{
			dist2 = distance(tanks[i].origin, self.origin);
			if(dist2 < dist1)
			{
				closest_tank = tanks[i];
				dist1 = dist2;
			}
		}
		else
		{
			closest_tank = tanks[i];
		}
	}

	println("Dist1 = ",dist1);

	if(dist1 > 3000)
	{
		println("Tank Target is too far away, return!");
		self.pacifist = false;
		return;
	}

	if(isdefined(closest_tank))
	{
		// Check to see if it's moving
		start = closest_tank.origin;
		wait 0.05;
		end = closest_tank.origin;

		println("Start: ",start," End: ",end);	
		if(start != end)
		{
			println("Object is Moving! Start: ",start," End: ",end);

//			level thread do_line(self.origin, closest_tank.origin, (0,1,0), "green");
			
			forward = vectornormalize(end - start);

			speed = (distance(start,end) / 0.05);
			println("Speed is: ",speed);
			// Compensate for aiming. 0.5 seconds.

			temp_angles = closest_tank.origin + maps\_utility_gmi::vectorScale(forward, 5000);
//			level thread do_line(closest_tank.origin, temp_angles, (1,1,1), "special");

			// Lead speed * 1.5, to compensate for the time it takes to aim.
			temp_lead = closest_tank.origin + maps\_utility_gmi::vectorScale(forward, (speed * 1.5));

//			level thread do_line(self.origin, temp_lead, (1,1,0), "yellow");

			projectile_lead = (distance(temp_lead,closest_tank.origin) / 2800);

			// Lead projectile_lead, to compensate for the panzerfaust speed.
			lead_pos = temp_lead + maps\_utility_gmi::vectorScale(forward, (speed * projectile_lead));
//			level thread do_line(self.origin, lead_pos, (1,0,0), "red");
		}

		println("^3FIRE AT TARGET!");
		self.pacifist = true;
		if(isdefined(lead_pos))
		{
			println("Leading!");
		//		    FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop)
			self FireAtTarget((lead_pos + (0,0,64)), 1.5, undefined, undefined, undefined, true);
		}
		else
		{
		//		    FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop)
//			level thread do_line(self.origin, closest_tank.origin, (1,0,0), "red");
			self FireAtTarget((closest_tank.origin + (0,0,64)), 1.5, undefined, undefined, undefined, true);
		}

		self.pacifist = false;
		println("^3End FIRE AT TARGET!");
	}
	else
	{
		println("^1No more tanks to shoot at!!! Game Over???");
	}
}

Event3_Tiger_Death2(tiger)
{
	tiger waittill("death");
	objective_position(4, (1820, 1802, -76));
	objective_ring(4);
}

// When in position, this is called to see if any of the tanks ahead are dead.
Event3_Avoid_Check(current_node)
{
	println("^5(Event3_T34_5_Avoid_Check) Start");
	self setspeed (0, 5);
	println(self.targetname," ^5Reached 'EVENT3 AVOID CHECK' WAIT Node");
	self disconnectpaths();

	level waittill("T34s go"); // If you put in the while, take this out.

	t34_2 = getent("t34_2","targetname");
	t34_3 = getent("t34_3","targetname");
	if(isalive(t34_2) && (isalive(t34_3)))
	{
		self resumespeed (10000);
		self connectpaths();
		return;
	}

	if(self.targetname == "t34_5")
	{
		self Event3_Blow_Wall1();
	
		start_avoid_node = getvehiclenode(current_node.target,"targetname");
		end_avoid_node = getvehiclenode("t34_5_alt_path1","targetname");
	}
	else
	{
		start_avoid_node = getvehiclenode(current_node.target,"targetname");
		end_avoid_node = getvehiclenode("t34_4_alt_path1","targetname");

		level waittill("T34_4_go");
	}

	self setswitchnode(start_avoid_node, end_avoid_node);
	println("^5(Event3_T34_4_Avoid_Check) Switch");

	// Since we're switching paths, have Tank think about the knew path.
	self.attachedpath = end_avoid_node;
	self notify("stop_tank_think");
	self thread Event1_Tank_Think();
		
	self resumespeed (10000);
	self connectpaths();
}

// Tells T34_5 to blow up the wall for the alternate path.
Event3_Blow_Wall1()
{
	target = getent("event3_blow_wall1_target","targetname");

	// Turn on the trigger, since it was disabled in event3()
//	trigger = getent("event3_blow_wall1_trigger","targetname");
//	trigger maps\_utility_gmi::triggerOn();

	// Tank_Fire_Turret(targetent, targetpos, start_delay, shot_delay, offset, validate, fake_fire)
	self thread Tank_Fire_Turret(target, undefined, 1, 1, undefined, undefined, true);
//	self waittill("turret_fire_done");
	self waittill("hit_target");

	wait 1;
	level thread Tank_Reset_Turret(self);
	wait 1;

	return;
}

Event3_Kill_Tiger()
{
	tiger = getent("event3_tiger1","targetname");

	if(!isalive(tiger))
	{
		return;
	}

	tiger.health = 1;
	self Tank_Fire_Turret(tiger, undefined, undefined, 1, undefined, undefined);
}

// Tells T34_5 to blow up wall2 so the squad can advance to event4
Event3_Blow_Wall2()
{
	self setspeed (0, 5);
	println(self.targetname," ^5Reached Event3_T34_5_Blow_Wall2 Node");
	self disconnectpaths();

	target = getent("event3_blow_wall2_target","targetname");

	// Turn on the trigger, since it was disabled in event3()
	trigger = getent("event3_blow_wall2_trigger","targetname");
	trigger maps\_utility_gmi::triggerOn();

	//Tank_Fire_Turret(targetent, targetpos, start_delay, shot_delay, end_notify)
	self thread Tank_Fire_Turret(target, undefined, 1, 1, end_notify);
	self waittill("turret_fire_done");

	level.antonov thread anim_single_solo(level.antonov, "antonov_follow", undefined, undefined, undefined, 2);
	println("antonov is here ", level.antonov.origin);
	
	level thread Tank_Reset_Turret(self, 1);

	maps\_utility_gmi::autosave(3);
	level thread Event4();
}

// If cvar SKIPTO_EVENT4 == 1, then run this function.
SkipTo_Event4()
{
	wait 0.1;
	// Kill allies_group2
	allies_group2 = getentarray("allies_group2","groupname");
	for(i=0;i<allies_group2.size;i++)
	{
		allies_group2[i] delete();
	}

	// Take Redshirt out of the level.friends array.
	level.friends = maps\_utility_gmi::subtract_from_array(level.friends, level.redshirt);
	println("New size of Friends ",level.friends.size);

	// Kill Redshirt
	level.redshirt delete();

	// Set the friendlychain
	event4_chain1 = getnode("event4_chain1","targetname");
	level.player setfriendlychain(event4_chain1);

	level thread Anotonov_Movement(8);
	PRINTLN("^3ANTONOV SHOULD BE GOING TO # 8");

	// Move the player so he triggers the friendly_wave trigger
	level.player setorigin((984, -1600, -160));
	wait 0.5;
	// Move the player so he cannot see the guys teleport.
	level.player setorigin((-1664, -2240, 35));
	wait 0.1;

	// Teleport squad
	allies_group1 = getentarray("allies_group1","groupname");
	org = (2328, 1224, -122);
	for(i=0;i<allies_group1.size;i++)
	{
		allies_group1[i] teleport(org);
		allies_group1[i] setgoalentity(level.player);

		org = ((org[0] - 36), org[1], org[2]);
	}

	// Teleport friends
	org = (1573, 2099, -15);
	for(i=0;i<level.friends.size;i++)
	{
		println("Friends targetname : ",level.friends[i].targetname, " org ", org);
		level.friends[i] teleport(org);
		org = ((org[0] - 48), org[1], org[2]);
		level.friends[i] setgoalentity(level.player);
	}

	org = ((org[0] - 48), org[1], org[2]);
	level.antonov teleport(org);

	wait 0.1;

	// Teleport Player To new spot.
	level.player setorigin((1675, 1455, -115));

	level.skipto = 6;
	// Move the tanks forward.
//	level notify("T34s go");


	tiger_tank = getent("event3_tiger1","targetname");

	// Accuracy is based on, the higher the number, the less accurate.
	tiger_tank.script_accuracy = 100;
	tiger_tank.rollingdeath = 1;
	// Set triggeredthink so that it waits before using the generic (_tank_gmi)
	// script for using the main turret... Instead, I'm using Tank_Turret_Think();
	tiger_tank.triggeredthink = true;

	tiger_tank thread maps\_tiger_gmi::init();
	tiger_tank thread Tank_Turret_Think();


	tiger_node = getvehiclenode("event3_tiger1_start","targetname");
	tiger_tank attachpath(tiger_node);
	tiger_tank startpath();
	wait 0.1;
	radiusDamage (tiger_tank.origin, 512, tiger_tank.health + 100,  1);

	for(i=1;i<6;i++)
	{
		tank = getent("t34_" + i,"targetname");
		tank setspeed(0, 10000);
	}

	level thread maps\_utility_gmi::exploder(8);

	// Update the objectives:
	level notify("update_objective_1");
	wait 0.25;
	level notify("objective 2 start");
	wait 0.25;
	level notify("objective 2 complete");
	wait 0.25;
	level notify("update_objective_3");
	wait 0.25;
	level notify("update_objective_3");
	wait 0.25;
	level notify("update_objective_3");
	wait 0.25;
	objective_state(3, "done");
	objective_current(1);
	wait 0.25;
	level notify("objective 3 complete");
	wait 0.25;
	level notify("objective 4 start");
	wait 0.25;
	level notify("update_objective_1");
	wait 0.25;
//	level notify("objective 4 complete");

	level thread Event4();

	for(i=1;i<6;i++)
	{
		tank = getent("t34_" + i,"targetname");
		tank setspeed(100, 10000);

		if(tank.targetname == "t34_1")
		{
			tank waittill("reached_end_node");
		}
		else
		{
			tank waittill("reached_specified_waitnode");
		}

		println(tank.targetname, "^2 is in position");
	}
}

// If cvar SKIPTO_END == 1, then run this function.
SkipTo_End()
{
	wait 0.1;
	// Kill allies_group2
	allies_group2 = getentarray("allies_group2","groupname");
	for(i=0;i<allies_group2.size;i++)
	{
		allies_group2[i] delete();
	}

	// Take Redshirt out of the level.friends array.
	level.friends = maps\_utility_gmi::subtract_from_array(level.friends, level.redshirt);
	println("New size of Friends ",level.friends.size);

	// Kill Redshirt
	level.redshirt delete();

	// Set the friendlychain
	event4_chain1 = getnode("event4_chain1","targetname");
	level.player setfriendlychain(event4_chain1);

	// Move the player so he triggers the friendly_wave trigger
	level.player setorigin((-1712, 4760, 282));
	wait 0.25;

	// Teleport squad
	allies_group1 = getentarray("allies_group1","groupname");
	org = (-1232, 5080, 232);
	for(i=0;i<allies_group1.size;i++)
	{
		allies_group1[i] teleport(org);
		allies_group1[i] setgoalentity(level.player);

		org = ((org[0] - 36), org[1], org[2]);
	}

	// Teleport friends
	org = (-1312, 4920, 232);
	for(i=0;i<level.friends.size;i++)
	{
		println("Friends targetname : ",level.friends[i].targetname, " org ", org);
		level.friends[i] teleport(org);
		org = ((org[0] - 48), org[1], org[2]);
		level.friends[i] setgoalentity(level.player);
	}

	wait 0.1;

	// Teleport Player To new spot.
	level.player setorigin((-1712, 4504, 282));

	level thread Event4_Last_Battle();

	// Update the objectives:
	level notify("update_objective_1");
	wait 0.25;
	level notify("objective 2 start");
	wait 0.25;
	level notify("objective 2 complete");
	wait 0.25;
	level notify("update_objective_3");
	wait 0.25;
	level notify("update_objective_3");
	wait 0.25;
	level notify("update_objective_3");
	wait 0.25;
	objective_state(3, "done");
	objective_current(1);
	wait 0.25;
	level notify("objective 3 start");
	wait 0.25;
	level notify("update_objective_1");
	wait 0.25;
	level notify("update_objective_1");
	wait 0.25;
	level notify("update_objective_1");
	wait 0.25;
	level notify("objective 4 start");
	wait 0.25;
	level notify("objective 5 start");
	wait 0.25;
	objective_state(4, "done");
	objective_current(1);
}

// Sets up a new friendlychain, also deletes some previous ones.
Event4()
{
	level notify("objective 4 complete");
	event4_chain1 = getnode("event4_chain1","targetname");
	level.player setfriendlychain(event4_chain1);
	
	//make antonov lead way
	node = getnode("md_377", "targetname");
	level.antonov setgoalnode(node);
	println("^3antonov should lead way!!!");

	trigger = getent("event4_courtyard1_trigger","script_noteworthy");
	trigger waittill("trigger");
	level thread Event4_Courtyard1_Tracker();

	level thread maps\_utility_gmi::chain_delete("event4_chain2");
	level thread maps\_utility_gmi::chain_delete("event4_chain3");

	killspawner_trigger = getent("event4_wall_explosion_killspawner","targetname");
	killspawner_trigger thread maps\_utility_gmi::triggerOff();

	level thread maps\_utility_gmi::chain_off("event4_chain7");
	level thread Event4_Enter_Building();
	level thread Event4_Clear_Out();
	level thread Event4_panzers();
}

Event4_Enter_Building()
{
	trigger = getent("event4_enter_building","targetname");
	trigger waittill("trigger");

	level notify("objective 5 start");

	maps\_utility_gmi::autosave(4);	
}

// Dialogue For Antonov, telling the player and 2 others to clear out the rest of the building.
Event4_Clear_Out()
{
	trigger = getent("event4_clear_out","targetname");
	trigger waittill("trigger");
	trigger delete();

	// Stops FX, and Sound for FX.
	level notify ("stop fx event4");
//	level.antonov thread Temp_Dialogue(&"GMI_KHARKOV1_TEMP_ANTONOV_EVENT4_CLEAR_OUT", 3);

	level thread Event4_Close_Door();
	level thread Event4_Mg42_Tracker();

	nodes = getnodearray("event4_mg42_2_spots","targetname");
	for(i=0;i<level.friends.size;i++)
	{
		level.friends[i] setgoalnode(nodes[i]);
	}

	level.antonov thread anim_single_solo(level.antonov, "antonov_check");

	level notify("objective 6 start");
//	level notify("update_objective_1");
}

//infinite panzerfausts
Event4_panzers()
{
	playerWeapon[0] = level.player getweaponslotweapon("primary");
	playerWeapon[1] = level.player getweaponslotweapon("primaryb");
	if ((playerWeapon[0] == "panzerfaust") || (playerWeapon[1] == "panzerfaust"))
	{
		println("^3 player has panzerfaust!!!");
	}
	else		
	{
//		objective_string(5, &"DAWNVILLE_OBJ1");
//		objective_position(5, getent ("panzerfaust","targetname").origin);
		println("^3 infinite panzerfaust on!!!");
		panzers = getentarray("infinite panzerfaust","targetname");
		for(i=0; i < panzers.size; i++)
		{
			panzers[i] notify ("infinite panzerfaust objective on");
		}
//	getent ("infinite panzerfaust","targetname") notify ("infinite panzerfaust objective on");

	}
}


Event4_Close_Door()
{
	trigger = getent("event4_mg42_in_building_spawner","script_noteworthy");
	trigger waittill("trigger");

	level.maxfriendlies = 0;

	allies = getaiarray("allies");

	org = (-800,3992,236);
	counter = 0;

	trigger = getent("event4_friends_check","targetname");
	for(i=0;i<allies.size;i++)
	{
		new_org = org;
		old_counter = counter;
		if(isdefined(allies[i].groupname))
		{
			if(allies[i].groupname == "allies_group1" || allies[i].groupname == "reinforcements")
			{
				allies[i] teleport(new_org);
				counter++;
			}
		}
		
		if(isdefined(allies[i].targetname))
		{
			if(allies[i].targetname == "vassili")
			{
				println("^1In Vassili IF STATEMENT");
				if(!(allies[i] istouching(trigger)))
				{
					println("^1Teleport Vassili");
					allies[i] teleport(new_org);
					counter++;
				}
			}
			else if(allies[i].targetname == "antonov")
			{
				allies[i] teleport(new_org);
				counter++;				
			}
			else if(allies[i].targetname == "miesha")
			{
				println("^1In Miesha IF STATEMENT");
				if(!(allies[i] istouching(trigger)))
				{
					println("^1Teleport Miesha");
					allies[i] teleport(new_org);
					counter++;
				}
			}
		}

		if(counter > old_counter)
		{
			if(counter == 4 || counter == 9)
			{
				org = org + (0,40,0);
			}

			new_org = org + ((40*counter), 0, 0);
		}
	}
	println("^5Shifting ALLIES: ",counter);

	door = getent("event4_door1","targetname");
	door rotateto((0,90,0), 0.1, 0,0);
	door disconnectpaths();
}

Event4_Mg42_Tracker()
{
	thespawner = getent("event4_mg42_2","targetname");

	spawned = thespawner dospawn();
	spawned waittill ("finished spawning");

	spawned.og_health = spawned.health;
	spawned.health = 50000000;

	level thread Event4_Blow_Blockade(spawned);

	while(1)
	{
		spawned waittill("damage", dmg, attacker);
		println("Dmg = ",dmg);
		if(attacker != level.player)
		{
			spawned.health = 50000000;
		}
		else
		{
			spawned.health = spawned.og_health;
			
			println("Health Before DMG : ",spawned.health);
			dmg = dmg / 4; // For some reason, dodamage multiplies the damage given by 4.
			spawned dodamage(dmg, level.player.origin);
			println("Health After DMG : ",spawned.health);
			println("I got Damaged! ", dmg," Attacker: ", attacker.groupname, " ", attacker.targetname, " ", attacker.origin);
			level notify("update_objective_6");
			break;
		}
	}

	nosight_brush = getent("event4_mg42_nosight","targetname");
	nosight_brush delete();
}

// Waits until all axis are dead, then tells enables a friendlychain.
Event4_Courtyard1_Tracker()
{
	level thread maps\_utility_gmi::chain_off("event4_chain4");
	wait 0.1; // Small delay, incase someone didn't fully spawn in.

	touchable_trigger = getent("courtyard1_axis_death_check","targetname");
	maps\_utility_gmi::living_ai_wait (touchable_trigger, "axis");
	level thread maps\_utility_gmi::chain_on("event4_chain4");

	level.antonov thread anim_single_solo(level.antonov, "antonov_square_secured");
}

// Blows the blockade, on the runners are in position.
Event4_Blow_Blockade(mg42_guy)
{
//	trigger = getent("event4_blow_blockade","targetname");
//	trigger waittill("trigger");

	mg42_guy waittill("death");

	level thread Event4_Wall_Explosion();

//	objective_state(5, "done");

	runners_spawn = getentarray("event4_runners","targetname");

	level.blockade_counter = 0;
	for(i=0;i<runners_spawn.size;i++)
	{
		runner = runners_spawn[i] dospawn();
		runner waittill ("finished spawning");
		runner thread Event4_Blockade_Runner_Tracker();
	}
	level waittill("blow_blockade");

	blockade_points = getentarray("blockade","targetname");

	for(i=0;i<blockade_points.size;i++)
	{
		blockade_points[i] thread Event4_Blockade_Boom(blockade_points[i].origin);
		wait (0.5 + randomfloat(3));
	}

	event4_blockade_guys = getentarray("event4_blockade_guys","groupname");
	for(i=0;i<event4_blockade_guys.size;i++)
	{
		if(issentient(event4_blockade_guys[i]) && isalive(event4_blockade_guys[i]))
		{
			event4_blockade_guys[i] thread Event4_Run_Down_Street();
		}
	}

	level notify("T34s go");
}

// Waits for 1 runner to get into position, then adds 1 to level.blockade_counter.
// once blockade_counter is 2, then we blow the blockade.
Event4_Blockade_Runner_Tracker(trigger)
{
	self waittill("goal");
	level.blockade_counter++;

println("^3Event4_Blockade_Runner_Tracker ", level.blockade_counter);
	if(level.blockade_counter == 2)
	{
		level notify("blow_blockade");
	}
}

Event4_Run_Down_Street()
{
	self.goalradius = 128;

	node = getnode("even4_corner_spot","targetname");
	self setgoalnode(node);
	self waittill("goal");

	self delete();
}

// The explosions for the blockades
Event4_Blockade_Boom(origin, fPower, iTime, iRadius)
{
	if(isdefined(level.mortar_quake))
	{
		fpower = level.mortar_quake;
	}
	else
	{ 
		if(!isdefined(fPower))
		{
			fPower = 0.5;
		}
	}

	if (!isdefined(iTime))
	{
		iTime = 2;
	}
	if (!isdefined(iRadius))
	{
		iRadius = 2000;
	}

	soundnum = (randomint(3) + 1);
	if (soundnum == 1)
	{
		self playsound ("shell_explosion1");
	}
	else
	if (soundnum == 2)
	{
		self playsound ("shell_explosion2");
	}
	else
	{
		self playsound ("shell_explosion3");
	}

	playfx ( level.blockade, origin );
	earthquake(fPower, iTime, origin, iRadius);

	if(isdefined(self.script_exploder))
	{
		self thread maps\_utility_gmi::exploder(self.script_exploder);
	}
}

Event4_Wall_Explosion()
{
//	trigger = getent("event4_blow_blockade","targetname");
//	trigger waittill("trigger");

	level thread maps\_utility_gmi::chain_on("event4_chain7");
	wait 2;
	level thread maps\_utility_gmi::exploder(9);
	for(i=0;i<level.friends.size;i++)
	{
		level.friends[i] setgoalentity(level.player);
	}

	event4_chain6 = getnode("event4_chain6","targetname");

	level.player setfriendlychain(event4_chain6);

	println("^5Wall Exploded!");

	spawners = getentarray("event4_wall_explosion_spawners","groupname");
	
	level thread maps\_spawner_gmi::flood_spawn (spawners);

	killspawner_trigger = getent("event4_wall_explosion_killspawner","targetname");
	killspawner_trigger maps\_utility_gmi::triggerOn();

	level thread Event4_Last_Battle();

	trigger = getent("event4_start_reinforcements","targetname");
	trigger waittill("trigger");

	door = getent("event4_door2","targetname");
	door rotateto((0,90,0),0.5,0,0);
	door waittill("rotatedone");
	door connectpaths();
	level.maxfriendlies = 9;
}

Event4_Last_Battle()
{
	trigger = getent("event4_start_last_battle","targetname");
	trigger waittill("trigger");

	level.antonov thread anim_single_solo(level.antonov, "antonov_windows");
	level.antonov.pacifist = false;
	level.antonov.suppressionwait = 3;

	maps\_utility_gmi::autosave(5);

	level notify("start_end_music");
	level thread Event4_Last_Battle_Respawners();
	level thread Event4_End_Of_Last_Battle();

	level waittill("event4_bring_in_mgs");

	attrib["goalradius"] = 4;
	level thread maps\_respawner_gmi::respawner_setup("event4_last_battle_mgs", undefined, attrib, undefined, undefined);

	level waittill("event4_bring_in_tank");

	level thread maps\_utility_gmi::exploder(10);
	level thread Event4_Tank();

	level.miesha allowedstances("crouch");
}

Event4_Last_Battle_Respawners()
{
	level endon("end_last_battle");

	level.last_battle_max_enemies = 5;
	level.last_battle_enemy_ai = 0;
	level.last_battle_enemy_counter = 0; // Used to count how many AI the player has shot. (so he has to kill some AI).

	spawners = getentarray("event4_end_battle_spawners","groupname");
	while(1)
	{
		while(level.last_battle_enemy_ai != level.last_battle_max_enemies)
		{
			num = randomint(spawners.size);

			if(isdefined(spawners[num].script_noteworthy))
			{
				if(spawners[num].script_noteworthy == "special")
				{
					if(spawners[num].count < 1)
					{
						wait 0.1;
						continue;
					}
				}
			}
			else
			{
				spawners[num].count = 1;
			}

			spawned = spawners[num] dospawn();
			if(isdefined(spawned))
			{
				level.last_battle_enemy_ai++;
				spawned thread Event4_Last_Battle_Death_Tracker(spawners[num]);
			}

			wait 0.1;
		}

		wait 0.5;
	}
}

Event4_Last_Battle_Death_Tracker(spawner)
{
	self waittill("death",attacker);
	level.last_battle_enemy_ai--;

	if(isdefined(spawner.script_noteworthy))
	{
		if(spawner.script_noteworthy == "special")
		{
			spawner.count++;
		}
	}

	if(attacker == level.player)
	{
		// After the 15th kill, Check the tank's health before continuing.
		if(level.last_battle_max_enemies > 14)
		{
			if(isalive(level.event4_tiger))
			{
				return;
			}
		}

		level.last_battle_enemy_counter++;

		if(getcvar("quick_end") == "1")
		{
			if(level.last_battle_enemy_counter == 1)
			{
				println("^2***EVENT4_BRING_IN_MGS***");
				println("^2***EVENT4_BRING_IN_MGS***");
				println("^2***EVENT4_BRING_IN_MGS***");
				level notify("event4_bring_in_mgs");
				level.last_battle_max_enemies = 9;

				level.antonov thread anim_single_solo(level.antonov, "antonov_ass");
			}
			else if(level.last_battle_enemy_counter == 2)
			{
				println("^2***EVENT4_BRING_IN_TANK***");
				println("^2***EVENT4_BRING_IN_TANK***");
				println("^2***EVENT4_BRING_IN_TANK***");
				level notify("event4_bring_in_tank");
				level.last_battle_max_enemies = 15;
			}
			else if(level.last_battle_enemy_counter == 5)
			{
//				level notify("end_last_battle");
			}			
		}
		else
		{
			if(level.last_battle_enemy_counter == 5)
			{
				println("^2***EVENT4_BRING_IN_MGS***");
				println("^2***EVENT4_BRING_IN_MGS***");
				println("^2***EVENT4_BRING_IN_MGS***");
				level notify("event4_bring_in_mgs");
				level.last_battle_max_enemies = 9;

				level.antonov thread anim_single_solo(level.antonov, "antonov_ass");
			}
			else if(level.last_battle_enemy_counter == 10)
			{
				println("^2***EVENT4_BRING_IN_TANK***");
				println("^2***EVENT4_BRING_IN_TANK***");
				println("^2***EVENT4_BRING_IN_TANK***");
				level notify("event4_bring_in_tank");
				level.last_battle_max_enemies = 15;
			}
			else if(level.last_battle_enemy_counter == 20)
			{
//				level notify("end_last_battle");
			}
		}
	}
}

Event4_End_Of_Last_Battle()
{
	level waittill("end_last_battle");

	level thread maps\_respawner_gmi::respawner_stop("event1_axis_group2");

	troops = getentarray("event4_end_battle_spawners","groupname");
	mgs = getentarray("event4_last_battle_mgs","groupname");

	temp_all = add_array_to_array(troops, mgs);
	
	all = [];
	for(i=0;i<temp_all.size;i++)
	{
		if(issentient(temp_all[i]))
		{
			all[all.size] = temp_all[i];
		}
	}
	
	level.end_count = all.size;

	for(i=0;i<all.size;i++)
	{
		 level thread Event4_End_Of_Last_Battle_Counter(all[i]);
	}
}

Event4_End_Of_Last_Battle_Counter(ai)
{
	ai waittill("death");
	level.end_count--;

	level thread maps\_respawner_gmi::respawner_stop("event4_last_battle_mgs");

	println("^2Guys Remaining: ", level.end_count);

	if(level.end_count == 6)
	{
		spawners = getentarray("event4_allies_group1","groupname");
		for(i=0;i<spawners.size;i++)
		{
			spawners[i] dospawn();
		}
	}

	if(level.end_count < 1)
	{
		level thread Event4_End_Mission();
	}
}

Event4_End_Mission()
{
	node = getnode("event4_antonov_last_spot","targetname");
	println("^1Node = ",node);

	level.antonov setgoalnode(node);
	level.antonov waittill("goal");
	level notify("level complete");
	wait 1;
	level notify("end_music");
	level.antonov anim_single_solo(level.antonov, "antonov_letsmove", undefined, node);	
	wait 1;
	missionSuccess("kharkov2", true);
}

Event4_Tank()
{
	tiger_tank = getent("event4_tiger1","targetname");
	// Accuracy is based on, the higher the number, the less accurate.
	tiger_tank.script_accuracy = 100;
	//raise health so tank reaches end_node
	tiger_tank.health = 10000;	
	// Set triggeredthink so that it waits before using the generic (_tank_gmi)
	// script for using the main turret... Instead, I'm using Tank_Turret_Think();
	tiger_tank.triggeredthink = true;

	tiger_tank thread maps\_tiger_gmi::init();
	tiger_tank thread Tank_Turret_Think(undefined, undefined, true);

	tiger_node = getvehiclenode("event4_tiger1_start","targetname");
	tiger_tank attachpath(tiger_node);
	tiger_tank startpath();

	level thread Event4_Tank_Dialogue();

	level notify("objective 6 complete");

	tiger_tank waittill("reached_end_node");

	//return health back to normal
	tiger_tank.health = 1500;

	orgs = getentarray("event4_tiger_target","targetname");

	tiger_tank Tank_Add_Targets(orgs);
	tiger_tank Tank_Add_Targets(level.friends);
	player[0] = level.player;
	tiger_tank Tank_Add_Targets(player);

	level.event4_tiger = tiger_tank;

	tiger_tank waittill("death");

	level notify("objective 7 complete");
	level notify("end_last_battle");
}



Event4_Tank_Dialogue()
{
	wait 0.5;
	level.miesha anim_single_solo(level.miesha, "miesha_tiger2");
	wait 1;
	level.antonov anim_single_solo(level.antonov, "antonov_pfaust2");

	wait 3;
	level.antonov thread anim_single_solo(level.antonov, "antonov_howmany");
}

Plane_Spawner(type, start_node, delay, health, start_sound, plane_num, spawn_delay)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	if(!isdefined(plane_num))
	{
		plane_num = 1;
	}

	if(!isdefined(spawn_delay))
	{
		spawn_delay = 2;
	}

	path = getvehiclenode(start_node,"targetname");

	for(i=0;i<plane_num;i++)
	{
		if(isdefined(type))
		{
			if(type == "bf109")
			{
				plane = spawnvehicle("xmodel/v_ge_air_me-109","BF109","BF109",path.origin,path.angles);			
				// If we want to blow up a plane, insert INIT() here!
			}
		}
		else
		{
			println("^1Tried to spawn a vehicle, without specifying the type");
			return;
		}
	
		if(!isdefined(health))
		{
			health = 500;
		}
	
		println("^3" + type + " on it's Way, along path: " + path.targetname);
		plane.health = health;
		plane notify("wheelsup");
		plane notify("takeoff");
	
		plane.attachedpath = path;
		plane attachPath(path);
		plane startpath();

		if(isdefined(start_sound))
		{
			if(isdefined(path.script_noteworthy))
			{
				plane playsound(path.script_noteworthy);
			}
			else
			{
				plane playsound("bf109_attack01");
			}
		}
	
		plane thread Plane_Think();

		wait spawn_delay;
	}
}

Plane_Think()
{
	level endon("stop_random_stukas");
	self endon("death");

	if(!isdefined(self.attachedpath))
	{
		println("^1NO '.ATTACHEDPATH' FOUND FOR STUKA, ",self.targetname);
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
	random_num = 0;
	for(i=0;i<pathpoints.size;i++)
	{
		if(isdefined(pathpoints[i].script_noteworthy))
		{
			self setWaitNode(pathpoints[i]);
			self waittill ("reached_wait_node");

			if (pathpoints[i].script_noteworthy == "flyby_sound")
			{
				if(isdefined(pathpoints[i].script_delay))
				{
					wait pathpoints[i].script_delay;
				}
				println("^5Plane flyby_sound");
			}
		}
	}

	self waittill("reached_end_node");
	self delete();
}

Random_Distant_Light_Setup()
{
	orgs = getentarray("distant_light","targetname");
	for(i=0;i<orgs.size;i++)
	{
		orgs[i] thread Random_Distant_Light_Think();
	}
}

Random_Distant_Light_Think()
{
	level endon("stop_distant_lights");

	while(1)
	{
		range = level.dist_light_max_delay - level.dist_light_min_delay;
		wait level.dist_light_min_delay + randomfloat(range);

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

		playfx(level._effect["distant_light"],self.origin);
	}
}

// Movement for Antonov
Anotonov_Movement(num, stance, trigger)
{
	// Trigger Friendlychains
	if(isdefined(trigger))
	{
		trigger waittill("trigger");
		num = trigger.script_idnumber;
		if(isdefined(trigger.script_noteworthy))
		{
			stance = trigger.script_noteworthy;
		}

		if(isdefined(trigger.script_delay))
		{
			wait trigger.script_delay;
		}

		println("^3Anotonov_Movement:Trigger, script_idnumber = ",trigger.script_idnumber);
	}

	node = getnode("antonov_spot" + num,"targetname");
	println("^3ANTONOV GOING TO SPOT ", NUM);

	level.antonov.goalradius = 32;

	if(isdefined(stance))
	{
		if(stance == "all")
		{
			level.antonov allowedstances("crouch", "prone", "stand");
		}
		else if(stance == "not_prone")
		{
			level.antonov allowedstances("crouch", "stand");
		}
		else
		{
			level.antonov allowedstances(stance);
		}
	}

	println("^3Anotonov_Movement: num = ",num);

	if(num == 3)
	{
		level.antonov.pacifist = true;
		level.antonov.pacifistwait = 0;
		level.antonov settakedamage(0);
	}

	level.antonov.assigned_node = node;

	if(num == 3)
	{
		level thread anim_reach_solo(level.antonov, "event2_start", tag, node, tag_entity);
		level.antonov.player_push = true;
		level.antonov pushPlayer(true);
	}
	else
	{
		level.antonov setgoalnode(node);
	}

	level.antonov waittill("goal");
	PRINTLN("^3 ANTONOV IS AT GOAL!!!");

	if(isdefined(level.antonov.player_push) && level.antonov.player_push)
	{
		level.antonov pushPlayer(false);
		level.antonov.player_push = false;
	}

	level notify("antonov_reached_spot" + num);
	PRINTLN("^3 ANTONOV IS AT SPOT", NUM);
	

	if(num == 3)
	{
		level.antonov.pacifist = false;
		level.antonov.pacifistwait = 0.5;
		level.antonov settakedamage(1);
	}
}

// certain friendlychain triggers have script_idnumbers which 
// will tell Antonov where to go.
Setup_Antonov_Triggers()
{
	triggers = getentarray("trigger_friendlychain","classname");
	for(i=0;i<triggers.size;i++)
	{
		if(isdefined(triggers[i].script_idnumber))
		{
			level thread Anotonov_Movement(undefined, undefined, triggers[i]);
		}
	}
}

// Deletes the trigger that threads the above function.
MG42_Kill_Player_Delete(event)
{
	triggers = getentarray("mg42_kill_player","targetname");
	for(i=0;i<triggers.size;i++)
	{
		if(isdefined(triggers[i].script_noteworthy))
		{
			if(triggers[i].script_noteworthy == event)
			{
				found_it = true;
				triggers[i] delete();
			}
		}
		else
		{
			println("(MG42_Kill_Player_Delete) Found a MG42_Kill_Player Trigger without script_noteworthy");
		}
	}

	if(!isdefined(found_it))
	{
		println("^2Warning: (MG42_Kill_Player_Delete) Could not find the trigger to delete. Looking for script_noteworthy: ", event);
	}
}

// When a friendly AI spawns in to catch up to squad, he will run this THREAD.
Catch_Up(guy)
{
	guy endon("death");

	if(isdefined(level.ai_sight))
	{
		guy.maxsightdistsqrd = level.ai_sight;
	}
	else
	{
		guy.maxsightdistsqrd = 36000000;
	}
	
	guy.groupname = "allies_group1";
	guy.health = 50;
	guy.goalradius = 32;
	guy setgoalentity (level.player);
}

// Fake dieing.
Bloody_Death(die)
{
	self endon("death");

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

	if(isdefined(die))
	{
		self dodamage(self.health + 50, self.origin);
	}
}

AI_Bloody_Death_Think()
{
	self endon("death");
	self waittill("goal");
	self thread Bloody_Death(true);
}

// Adds targets to the tanks enemy_targets list.
Tank_Add_Targets(targets)
{
	if(!isdefined(targets))
	{
		println("^1(Tank_Add_Targets) Invalid Target");
	}

	println("Targets size ",targets.size);
	for(i=0;i<targets.size;i++)
	{
		if(!isdefined(targets[i]))
		{
			println("^1(Tank_Add_Targets) Invalid Target(2) | i = ", i);
		}
		self.enemy_targets = verify_and_add_to_array(self.enemy_targets, targets[i]);
	}
}

// Removes a target from the tanks enemy_targets list.
Tank_Remove_Target(target)
{
//	println("^4(Tank_Remove_Target) Before ",self.enemy_targets.size);

	self.enemy_targets = maps\_utility_gmi::array_remove(self.enemy_targets, target);

//	println("^4(Tank_Remove_Target) After ",self.enemy_targets.size);
}

// Finds the closest living enemy tank and fires at it.
Tank_Turret_Think(min_delay, max_delay, random_target, level_ender)
{
	self endon("death");
	self endon("stop_turret_think");

	if(!isalive(self))
	{
		return;
	}

	if(isdefined(level_ender))
	{
		level endon(level_ender);
	}

	// Settings:
	println(self.targetname, " ^5Tank_Turret_Think Settings: Min_Delay: ", min_delay, " ^5Max_Delay: ", max_delay, " ^5Random_Target: ", random_target);

	while(1)
	{
		if(isdefined(random_target))
		{
			if(isdefined(self.enemy_targets))
			{
				random_num = randomint(self.enemy_targets.size);
				target = self.enemy_targets[random_num];
			}
		}
		else
		{
			target = Tank_Get_Closest_Target();
		}

		if(isdefined(target))
		{
			if(isdefined(target.targetname))
			{
				println(self.targetname, " ^5 IS TARGETTING (targetname): ",target.targetname);
			}

			if(isdefined(self.script_accuracy))
			{
				dist = distance(self.origin, target.origin);
				distacc = self.script_accuracy * (dist / 5000);
				randx = randomint(distacc * 0.85) + (distacc * 0.15);
				randy = randomint(distacc * 0.85) + (distacc * 0.15);
				randz = randomint(distacc * 0.85) + (distacc * 0.15);
				accuracy = (randx, randy, randz);
			}
			else
			{
				if(isdefined(target.classname) && target.classname == "script_origin")
				{
					accuracy = (0,0,0);
				}
				else
				{
					accuracy = (0,0,64);
				}
			}

			if(isdefined(target.script_noteworthy))
			{
				if(target.script_noteworthy == "fake_target")
				{
					println(self.targetname, " ^5TARGET IS A FAKE_TARGET!!!");
						  //Tank_Fire_Turret(targetent, targetpos, start_delay, shot_delay, offset, validate, fake_fire, random_turning)
					self thread Tank_Fire_Turret(target, undefined, randomfloat(2), randomfloat(2), accuracy, false, true);
				}
				else
				{
					self thread Tank_Fire_Turret(target, undefined, randomfloat(2), randomfloat(2), accuracy, true);
				}
			}
			else
			{
				self thread Tank_Fire_Turret(target, undefined, randomfloat(2), randomfloat(2), accuracy, true);
			}

			self waittill("turret_fire_done");
		}

		if(!isdefined(min_delay))
		{
			min_delay = 0.25;
		}

		if(!isdefined(max_delay))
		{
			max_delay = 3;
		}

		delay_range = max_delay - min_delay;
		delay = min_delay + randomfloat(delay_range);

//		println("^5(Tank_Turret_Think) Restarting in " + delay + " seconds...");

		wait delay;
	}
}

// This gets the closest living self.enemy_targets to the tank.
// Also validates the closest enemy before firing.
Tank_Get_Closest_Target()
{
	self endon("death");

	valid_target = false;

	not_valid_tanks = [];

	// Find closest living enemy tank
//	println("^5(Tank_Get_Closest_Target) Start");
	while(!valid_target)
	{
		if(isdefined(self.enemy_targets))
		{
			println("^5self.enemy_targets.size = ",self.enemy_targets.size);
		}

		if(!isdefined(self.enemy_targets) || self.enemy_targets.size == 0)
		{
//			println("^3(Tank_Get_Closest_Target) No Assigned Targets for Tank: ",self.targetname);
			wait 1;
			return undefined;
		}

//		if(isdefined(self.enemy_targets.size))
//		{
//			println("^5(Tank_Get_Closest_Target) self.enemy_targets.size", self.enemy_targets.size);
//		}

		dist1 = undefined;
		closest_tank = undefined;

		for(i=0;i<self.enemy_targets.size;i++)
		{
			not_valid = false;
			failsafe_check = false;

			if(!isalive(self.enemy_targets[i]))
			{
				println("^3(Tank_Get_Closest_Target) Tank  (" + i + ") is dead");
				self Tank_Remove_Target(self.enemy_targets[i]);
				continue;
			}

			// Check to see if the tank previously failed a valid check
			for(q=0;q<not_valid_tanks.size;q++)
			{
				if(not_valid_tanks[q] == self.enemy_targets[i])
				{
					not_valid = true;
				}
			}

			if(not_valid)
			{
				println("^3(Tank_Get_Closest_Target) Not at Valid Target  (" + i + ")");
				continue;
			}

//			println("^3(Tank_Get_Closest_Target) Check Closest for Tank (" + i + ")"); 
			if(!isdefined(dist1))
			{
				dist1 = distance(self.enemy_targets[i].origin, self.origin);
			}
	
			if(isdefined(closest_tank))
			{
				dist2 = distance(self.enemy_targets[i].origin, self.origin);
				if(dist2 < dist1)
				{
					closest_tank = self.enemy_targets[i];
					dist1 = dist2;
				}
			}
			else
			{
				closest_tank = self.enemy_targets[i];
			}
		}

		if(isdefined(closest_tank))
		{
			// Testing...
//			for(i=0;i<self.enemy_targets.size;i++)
//			{
//				if(closest_tank == self.enemy_targets[i])
//				{
//					println("^2(Tank_Get_Closest_Target) Closest Tank (" + i + ")");
//				}
//			}

			// Testing, see which one is the closest tank
			valid_target = self Tank_Validate_Target(closest_tank, "tag_turret", (0,0,64));
	
			if(!valid_target)
			{
//				println("Not valid size ",not_valid_tanks.size);
				if(not_valid_tanks.size == 0)
				{
					println("^6Added to Not Valid Tanks (" + not_valid_tanks.size + ")");
					not_valid_tanks[not_valid_tanks.size] = closest_tank;
				}
				else
				{
//				println("Not valid size 2 ",not_valid_tanks.size);
					for(i=0;i<not_valid_tanks.size;i++)
					{
						if(not_valid_tanks[i] != closest_tank && !failsafe_check)
						{
							// Added so it doesn't go twice for some reason.
							failsafe_check = true;
//							println("^6Added to Not Valid Tanks (" + not_valid_tanks.size + ")");
							not_valid_tanks[not_valid_tanks.size] = closest_tank;
						}
					}
				}
			}

//			if(isdefined(not_valid_tanks))
//			{
//				println("^6(Valid Check) not_valid_tanks.size: ",not_valid_tanks.size," ^6self.enemty_targets.size: ",self.enemy_targets.size);
//			}

			if(not_valid_tanks.size >= self.enemy_targets.size)
			{
				println("^1(Tank_Get_Closest_Target) No Valid Targets for Tank: ",self.targetname);
				return;
			}
		}

		if(valid_target)
		{	
			break;
		}
		wait 0.1;
	}

	return closest_tank;
}

// Validates the Target for the tank firing. Does a trace and returns a boolean for
// verification.
Tank_Validate_Target(target, tag, offset)
{
	self endon("death");

	if(!isalive(target))
	{
		return false;
	}

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

// This function fires the turret on the tank
// Self = The tank
// TargetEnt = Target the turret at the ENT
// TargetPos = Target the turret at the POS
// Start_Delay = Delay before tracking the target.
// Shot_Delay = Delay after tracking the target, before shooting the turret.
// End_Notify = Notifies the entity when it's done, if not specified, 
// then: "turret_fire_done" will be notified
Tank_Fire_Turret(targetent, targetpos, start_delay, shot_delay, offset, validate, fake_fire)
{
	self endon("death");
	self notify("stop_random_turret_turning");

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

	println("^5(Tank_Fire_Turret): Waittill: turret_on_target");
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
	if(isdefined(validate) && validate)
	{
		valid = self Tank_Validate_Target(targetent, "tag_flash", (0,0,64));
		if(!valid)
		{
			self notify("turret_fire_done");
			return;
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
		println("^5(Tank_Fire_Turret): FAKE FIRE: TRUE");
		playfxontag(level.fake_turret_fx, self, "tag_flash");
		self playsound("t34_fire");
		println("^5(Tank_Fire_Turret): FAKE FIRE: 1");

		forward_angles = anglestoforward(self.angles);
		vec = self.origin + maps\_utility_gmi::vectorScale(forward_angles, 100);
		self joltBody (vec, 1, 0, 0);

		println("^5(Tank_Fire_Turret): FAKE FIRE: 2");

		self notify("turret_fire_done");

		dist = distance(self.origin, targetent.origin);
		wait (dist * .0001);
		self notify("hit_target");

		println("^5(Tank_Fire_Turret): FAKE FIRE: 3");

		if(isdefined(targetent))
		{
			println("^5(Tank_Fire_Turret): FAKE FIRE: TRUE");

			if(isdefined(targetent.script_exploder))
			{
				level thread maps\_utility_gmi::exploder(targetent.script_exploder);
			}
			
			if(isdefined(targetent.script_fxid))
			{
				if(targetent.script_fxid == "nofx")
				{
					return;
				}

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
						else if(targets[i].classname == "trigger_multiple")
						{
							if(isdefined(targets[i].script_noteworthy))
							{
								if(targets[i].script_noteworthy == "kill")
								{
									targets[i] thread Kill_Touching_Trigger();
								}
							}
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
			
				playfx ( level.mortar, targetent.origin );
				earthquake(0.15, 2, targetent.origin, 850);
				radiusDamage (targetent.origin, 512, 400,  1);
			}
		}
	}
}

// Resets the Tank's Turret
Tank_Reset_Turret(tank, delay, wait_till)
{
	if(isdefined(wait_till))
	{
		tank waittill(wait_till);
	}

	if(isdefined(delay))
	{
		wait delay;
	}

	tag = tank gettagorigin("tag_turret");
	forward_angles = anglestoforward(tank.angles);
	vec = tank.origin + maps\_utility_gmi::vectorScale(forward_angles, 1000);

	temp_org = spawn("script_origin",(vec + (0,0,64)));
	temp_org linkto(tank);
	
//	tank setTurretTargetVec(vec,(0,0,0));
	tank setTurretTargetEnt(temp_org,(0,0,0));
	tank waittill("turret_on_target");
	tank clearTurretTarget();
	temp_org delete();
}

// Regens the Health on a tank... Forever.
Tank_Health_Regen(max_health)
{
	self endon("stop_health_regen");

	self.old_health = self.health;
	self thread Tank_Health_Reset();

	if(!isdefined(max_health))
	{
		max_health = 1000;
	}

	while(1)
	{
		self.health = max_health;
		self waittill("damage");
	}
}

Tank_Health_Reset()
{
	self waittill("stop_health_regen");

	self.health = self.old_health;
}

// Tank turrets Random looking around
Tank_Turret_Random_Turning()
{
	self endon("death");
	self endon("stop_random_turret_turning");

	self.random_turret_think = true;

	// Yaw depending on world angles, not self.angles.
	self.min_yaw = 45;
	self.max_yaw = 135;
	self.use_self_angles = false;

//	self thread test_tank_turret();

	random_yaw = 0;

	while(1)
	{
		if(self.random_turret_think)
		{
			range = self.max_yaw - self.min_yaw;

			if(range < 0)
			{
				range = range * -1;
				random_yaw = self.min_yaw + randomint(range);
				random_yaw = random_yaw * -1;
			}
			else
			{
				random_yaw = self.min_yaw + randomint(range);
			}

			random_z = randomint(100);

			if(self.use_self_angles)
			{
				forward_angles = anglestoforward(self.angles + (0, random_yaw, 0));
			}
			else
			{
				forward_angles = anglestoforward((0, random_yaw, 0));
			}
			vec = self.origin + maps\_utility_gmi::vectorScale(forward_angles,2000);

			if((vec[2] + random_z) < self.origin[2])
			{
				println(self.targetname, " ^3reseting vec[2]");
				vec = (vec[0], vec[1], (self.origin[2] + 64));
			}

			self.fake_target = (vec + (0, 0, random_z));

			self setTurretTargetVec(self.fake_target,(0,0,0));
			self waittill("turret_on_target");
			self clearTurretTarget();			
		}

		wait (1 + randomfloat(10));
	}
}

// Toggle their random turning on/off
Tank_Turret_Random_Turning_Think()
{
	self endon("death");
	self thread Tank_Turret_Random_Turning();

	while(1)
	{
		self waittill("stop_random_turret_turning");
		self.random_turret_think = false;

		self waittill("start_random_turret_turning");
		self.random_turret_think = true;
		self thread Tank_Turret_Random_Turning();
	}
}

// Triggers that change the direction of the random turning.
// Using script_followmin/script_followmax for min/max yaw angles.
// Using script_idnumber for number of tanks, before stopping.
Tank_Turret_Trigger_Setup()
{
	triggers = getentarray("turret_angle_change","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread Tank_Turret_Trigger_Think();
	}
}

Tank_Turret_Trigger_Think()
{
	while(self.script_idnumber > 0)
	{
		self waittill("trigger",tank);
		tank.min_yaw = self.script_followmin;
		tank.max_yaw = self.script_followmax;

		if(isdefined(self.script_noteworthy) && self.script_noteworthy == "selfangles")
		{
			tank.use_self_angles = true;
		}
		else
		{
			tank.use_self_angles = false;
		}

		self.script_idnumber--;
	}
}

// Any AI touching the trigger will die.
Kill_Touching_Trigger()
{
	all_ai = getaiarray();
	for(i=0;i<all_ai.size;i++)
	{
		if(all_ai[i] istouching(self))
		{
			all_ai[i] dodamage((all_ai[i].health + 50), all_ai[i].origin);
		}
	}
}

// Sets up the mg42_kill_player triggers so they hurt the player.
MG42_Kill_Player_Setup()
{
	triggers = getentarray("mg42_kill_player","targetname");
	println("MG42 Kill Player Triggers size ", triggers.size);
	for(i=0;i<triggers.size;i++)
	{
		if(isdefined(triggers[i].script_noteworthy))
		{
			triggers[i] thread MG42_Kill_Player_Think();
		}
		else
		{
			println("^3Warning: MG42 Kill Player trigger without script_noteworthy!");
			println("^3Warning: MG42 Kill Player trigger without script_noteworthy!");
			println("^3Warning: MG42 Kill Player trigger without script_noteworthy!");
		}
	}
}

// Think function for the mg42_kill_player triggers.
MG42_Kill_Player_Think()
{
	self endon("death");

	if(self.script_noteworthy == "event1")
	{
		level endon("no_mg42_kill_player_event1");

		mg[0] = getent("mg42_1","targetname");
		mg[1] = getent("mg42_2","targetname");
		mg[2] = getent("mg42_3","targetname");
		mg[3] = getent("mg42_4","targetname");

		max_dist = 1000;
		dmg_multiplier = 0.2;
	}
	else if(self.script_noteworthy == "event2")
	{
		mg[0] = getent("mg42_5","targetname");
		mg[1] = getent("mg42_6","targetname");

		dmg_multiplier = 0.2;
		max_dist = 700;
	}

	for(i=0;i<mg.size;i++)
	{
		org[i] = mg[i].origin;
	}

	if(isdefined(self.target))
	{
		target = getent(self.target,"targetname");

		if(target.classname == "script_origin")
		{
			dist_org = target.origin;
		}
	}
	else
	{
		println("^3Warning: MG42 Kill Player trigger without TARGET!");
		println("^3Warning: MG42 Kill Player trigger without TARGET!");
		println("^3Warning: MG42 Kill Player trigger without TARGET!");
		return;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "event1")
	{
		mg42s[0] = getent("mg42_1","targetname");
		mg42s[1] = getent("mg42_2","targetname");
		mg42s[2] = getent("mg42_3","targetname");
		mg42s[3] = getent("mg42_4","targetname");

		ai_filter[0] = "event1_axis_group1"; // groupname
		ai_filter[1] = "event1_axis_group1b"; // groupname
		checker = false;
	}

	while(1)
	{
		self waittill("trigger");

		while(level.player istouching(self) && isalive(level.player))
		{
//			dist = distance(level.player.origin, dist_org);
 			// For now only need to check the Y axis. Much better than check raw distance,
			// as distance is a radius... Need to check the linear Y.
			dist = level.player.origin[1] - dist_org[1];
			dmg = dist * dmg_multiplier;

			if(isdefined(self.script_noteworthy) && self.script_noteworthy == "event1")
			{
				if(!checker)
				{
					checker = true;
					for(i=0;i<mg42s.size;i++)
					{
						if(isalive(mg42s[i]))
						{
							mg42s[i] setmode("manual_ai");
							mg42s[i] settargetentity(level.player);
						}
					}
	
					axis = getaiarray("axis");
					for(i=0;i<axis.size;i++)
					{
						if(isalive(axis[i]))
						{
							axis[i].favoriteenemy = level.player;
						}
					}
				}
			}

			num = randomint(mg.size);
			if(dist < max_dist)
			{
				println("^2Damage: ",dmg," ^2Distance: ",dist);
				level.player doDamage ( dmg, org[num]);
			}
			else
			{
				println("^2Kill The PLayer!");
				// Kill the player.
				level.player doDamage ( (level.player.health + 50), org[num]);
			}

			wait (0.1 + randomfloat(0.75));
		}

		if(isdefined(self.script_noteworthy) && self.script_noteworthy == "event1")
		{
			if(checker)
			{
				checker = false;
				for(i=0;i<mg42s.size;i++)
				{
					if(isalive(mg42s[i]))
					{
						mg42s[i] cleartargetentity();
						mg42s[i] setmode("auto_ai");
						mg42s[i] notify("turretstatechange");
					}
				}
			}
		}
	}
}

// Cover triggers from MG42 gun fire.
// Took from Burnville.
MG42_Cover()
{
	cover_triggers = getentarray("mg42_cover","targetname");
	for(i=0;i<cover_triggers.size;i++)
	{
		cover_triggers[i] thread MG42_Cover_Trigger();
	}

	while(1)
	{
		wait 0.5;
		if(isdefined(level.player_covertrigger))
		{
			if((level.player getstance() == "crouch") || (level.player getstance() == "prone"))
			{
				println("Player COVER!");
				level.player.ignoreme = true;
			}
			else
			{	
				level.player.ignoreme = false;
			}
			continue;
		}
	}
}

MG42_Cover_Trigger()
{
	while (1)
	{
		level.player_covertrigger = undefined;

		self waittill ("trigger");

		while (level.player istouching (self))
		{
			level.player_covertrigger = self;
			wait 0.5;
		}
	}
}

// Waittill triggered before blowing up.
Binoc_Trigger_Think(player_trigger, mortars)
{
	self thread Binoc_Trigger_Catch_Attack_Button(level.player, player_trigger, mortars);

	self.binoc_trigger_time = GetTime();

	while(1)
	{
		self waittill("trigger",other);

		// Abort if the player is not the one looking at the trigger.
		if (other != level.player)
		{
			continue;
		}

		// Abort if the player is not using the binoculars
		currentweapon = level.player getCurrentWeapon();
		if(currentweapon != "binoculars")
		{
			continue;
		}

		// Abort if the player is not touching the player_Trigger
		if(isdefined(player_trigger))
		{
			if(!(level.player istouching(player_trigger)))
			{
				continue;
			}
		}
		
		// Abort if the player is not in ADS mode.	
		if(!(level.player isads()))
		{
			continue;
		}

		level.binoc_trigger_time = GetTime();

		self.binoc_target_enabled = true;

		if (!level.binoc_target)
		{
			self thread Binoc_Trigger_Target_On();
		}
	}
}


// Turns on the cursor hint, if the player is aiming at the sight.
Binoc_Trigger_Target_On()
{
	level.binoc_target = true;

	if(!isdefined(level.binoc_cursorhint))
	{
		self thread Binoc_Cursor_Hint();
	}

	while (1)
	{
		if (level.binoc_trigger_time < GetTime() - 0.05)
		{
			self.binoc_target_enabled = false;
			level.binoc_target = false;
			break;
		}
		wait 0.05;
	}
}

// Think function for binoc triggers. Waits for the player to hit his attackbutton.
// BUG: Need to not have this think 0.1 seconds throughout the entire level.
Binoc_Trigger_Catch_Attack_Button(player, player_trigger, mortars)
{
	level.event2_fired = false;
//	println("You are aiming at it.");
	while (1)
	{
		if(!level.binoc_target)
		{
			wait 0.1;
			continue;
		}

		if(!(level.player attackButtonPressed()))
		{
			wait 0.1;
			continue;
		}

		if (!isdefined(self.binoc_target_enabled) || !self.binoc_target_enabled)
		{
			wait 0.1;
			continue;
		}

		// if we get to here, then the player is firing at the binoc target

		// if a player_trigger exists, make sure the player is touching it
		
		if(!isdefined(player_trigger) || (level.player istouching(player_trigger)))
		{
			println("Triggered! Within Trigger");

			if(level.miesha.current_spot == 3 && level.miesha.assigned_spot == 3)
			{
				if(self.script_idnumber == 1)
				{
					level notify("update_objective_3");
					level notify("stop_event2_fight_loop");
	
					level thread Event2_Binoc_TriggerOn("event2_area2");
					level thread Event2_Binoc_TriggerDelete("event2_area1");
					level thread MG42_Kill_Player_Delete("event2");

					level thread Event2_Transition_To_Spot7();
					level.miesha Binoc_Miesha_Radio_Call(self.script_idnumber);
					break;
				}
			}
			else if(level.miesha.current_spot == 7 && level.miesha.assigned_spot == 7)
			{
				level notify("update_objective_3");
				if(self.script_idnumber == 2)
				{
					level thread maps\_respawner_gmi::respawner_stop("event1_axis_group2");
					level thread maps\_respawner_gmi::respawner_stop("event1_axis_group2b");

						   //Clean_Up_By_Death(groupname, targetname, delay, initial_delay, wait_till)
					level thread Clean_Up_By_Death("event1_axis_group2", undefined, 1, undefined, "binoc_mortars_done");
					level thread Clean_Up_By_Death("event1_axis_group2b", undefined, 1, undefined, "binoc_mortars_done");

					level thread Event2_Binoc_TriggerDelete("event2_area2");

					level.miesha Binoc_Miesha_Radio_Call(self.script_idnumber);

					level thread Event2_Transition_To_Spot9();
					level.antonov thread Anotonov_Movement(4, "all");
					PRINTLN("^3ANTONOV SHOULD BE GOING TO #4");
					

					event2_chain4 = getnode("event2_chain4","targetname");
					level.player setfriendlychain(event2_chain4);
			
					level notify("T34s go");
					break;
				}
			}
			else if(level.miesha.current_spot == 9 && level.miesha.assigned_spot == 9)
			{
				if(self.script_idnumber == 3)
				{
					level notify("update_objective_3");
					level thread maps\_respawner_gmi::respawner_stop("event2_axis_group3");
					level thread Clean_Up_By_Death("event2_axis_group3", undefined, 1, undefined, "binoc_mortars_done");
					level.miesha Binoc_Miesha_Radio_Call(self.script_idnumber);
					level thread Event2_Friends_Movment_Manual(10, 7);
					break;
				}
			}
			else
			{
				level thread Binoc_Miesha_Wait_Dialogue();
//				println("Miesha is NOT in position");
			}
		}
		wait 0.1;
	}

	if(isdefined(mortars))
	{
		// Have it go through all of the mortars twice, a real pounding.
		for(q=0;q<1;q++)
		{
			println("^3Firing Mortars!");
			for(i=0;i<mortars.size;i++)
			{
				wait (randomfloat(1));
				mortars[i] thread Binoc_Mortar();
			}
		}
	}
	else
	{
		println("^3(Setup_Binoc_Triggers) Warning!! No Mortars for 'binoc_trigger'");
	}

	level.objective2_counter++;

	if(level.objective2_counter == level.objective2_total)
	{
		level notify("objective 3 complete");
		level notify("update_objective_1");
	}

	level notify("binoc_mortars_done");
}

Binoc_Miesha_Wait_Dialogue()
{
	if(level.flag["miesha_talking"])
	{
		return;
	}

	if(level.flag["miesha_ready_for_artillery"])
	{
		return;
	}

	if(!isdefined(level.miesha_wait_dialogue) || level.miesha_wait_dialogue > 3)
	{
		level.miesha_wait_dialogue = 1;
	}

	level.flag["miesha_talking"] = true;
	level.miesha anim_single_solo(level.miesha, ("miesha_wait0" + level.miesha_wait_dialogue));
	level.flag["miesha_talking"] = false;

	level.miesha_wait_dialogue++;
}

// Initial timer so that the crosshair does not pop up prematurely
Binoc_Cursor_Init_Timer()
{
	while(1)
	{
		if(level.player isads())
		{
			if(!level.binoc_init_timer)
			{
				wait 0.6;	
				level.binoc_init_timer = true;
			}
		}
		else
		{
			level.binoc_init_timer = false;			
		}
		wait 0.05;
	}
}

// Faked in Cursor hint.
Binoc_Cursor_Hint()
{
	self endon("kill_binoc_cursor_think");

	level.binoc_hud_icon = "gfx/hud/hud@fire_ready.dds";

	while(1)
	{
		if(!(level.player isads()))
		{
			break;
		}

		if(!level.binoc_init_timer)
		{
			wait 0.05;
			continue;
		}

		if(level.binoc_target)
		{
			if(!isdefined(level.binoc_cursorhint))
			{
				if(!level.binoc_cursor_text["fire"])
				{
					level thread Binoc_Cursor_Text("fire");
				}
				println("START BINOC!");
				level.binoc_cursorhint = newHudElem();
				level.binoc_cursorhint.alignX = "center";
				level.binoc_cursorhint.alignY = "middle";
			
				level.binoc_cursorhint.fontscale = "1";
				level.binoc_cursorhint.alpha = 1;
			
				level.binoc_cursorhint.x = 320;
				level.binoc_cursorhint.y = 240;
				level.binoc_cursorhint.color = (1, 0, 0);
			
				level.binoc_cursorhint setShader(level.binoc_hud_icon, 96, 96);
			}
			else
			{
				if(isdefined(level.binoc_cursorhint))
				{
					level.binoc_cursorhint.alpha = 1;
				}				
			}
		}
		else
		{
			if(isdefined(level.binoc_cursorhint))
			{
				level.binoc_cursorhint.alpha = 0;
			}
		}

		wait 0.05;
	}
	println("END BINOC!");

	if(isdefined(level.binoc_cursorhint))
	{
		level.binoc_cursorhint destroy();
	}
}

Binoc_Cursor_Text(msg)
{
	if(msg == "fire")
	{
		level.binoc_cursor_text["fire"] = true;
		level thread maps\_utility::keyHintPrint(&"GMI_SCRIPT_HINT_BINOC_FIRE", getKeyBinding("+attack"));
	}
	else if(msg == "use")
	{
		level.binoc_cursor_text["use"] = true;
		iprintlnbold(&"GMI_SCRIPT_HINT_BINOC_USE");
	}
}

// Miesha calls in a barage
Binoc_Miesha_Radio_Call(num)
{
	Dialogue = [];
	Dialogue[1] = (&"GMI_KHARKOV1_TEMP_MIESHA_RADIO_1");
	Delay[1] = 6.35;

	Dialogue[2] = (&"GMI_KHARKOV1_TEMP_MIESHA_RADIO_2");
	Delay[2] = 7.77;

	Dialogue[3] = (&"GMI_KHARKOV1_TEMP_MIESHA_RADIO_3");
	Delay[3] = 7.43;

	node = getnode("miesha_spot" + self.assigned_spot,"targetname");

	level.flag["miesha_calling_artillery"] = true;

	level.miesha thread animscripts\look::finishLookAt();
	level.miesha notify("stop_anim");
	level.miesha anim_single_solo(level.miesha, "radio_trans_to_talk", undefined, node);

	level.miesha anim_single_solo(level.miesha, ("radio_talk_" + num), undefined, node);

//	level.miesha thread anim_loop_solo(level.miesha, ("radio_talk_" + num), undefined, "stop_anim", node);

	// Testing, right now the radio_talk is a loop, So to hear the sound without
	// skipping has to be done manually.

//	level.miesha playsound(("miesha_firemission0" + num), "dialogue_done", false);

//	level.miesha waittill("dialogue_done");

	level.flag["miesha_calling_artillery"] = false;

//	level.miesha notify("stop_anim");
	level.miesha thread anim_single_solo(level.miesha, "radio_trans_out", undefined, node);

	level.miesha thread Binoc_Miesha_Radio_Ear_Anim();

	return;
}

Binoc_Miesha_Radio_Ear_Anim()
{
	level.miesha waittillmatch("single anim","detach");
	level.miesha.receiver delete();

	level.miesha waittill("radio_trans_out");

	level.miesha thread anim_loop_solo(level.miesha, "radio_talk_ear_loop", undefined, "stop_anim", node);
	wait 4;
	level.miesha notify("stop_anim");

	level.miesha thread anim_single_solo(level.miesha, "radio_talk_ear2stand");

	level.miesha waittill("radio_talk_ear2stand");

	level.miesha allowedstances("crouch", "prone", "stand");

	level.miesha.dontavoidplayer = level.miesha.og_dontavoidplayer;
	level.miesha.goalradius = level.miesha.og_goalradius;
	level.miesha.ignoreme = false;
	level.miesha.pacifist = false;

	level.flag["miesha_ready_for_artillery"] = false;
}

// The fake mortars for the binoc section.
Binoc_Mortar(range, max_damage, min_damage, fQuakepower, iQuaketime, iQuakeradius)
{
	Binoc_Incoming_Sound();

	level notify ("mortar");
	self notify ("mortar");

	if (!isdefined (range))
	{
		range = 300;
	}
	if (!isdefined (max_damage))
	{
		max_damage = 800;
	}
	if (!isdefined (min_damage))
	{
		min_damage = 25;
	}

	radiusDamage ( self.origin, range, max_damage, min_damage);

	Binoc_Mortar_Boom( self.origin, fQuakepower, iQuaketime, iQuakeradius );
}

// Fake mortar explosions.
Binoc_Mortar_Boom (origin, fPower, iTime, iRadius)
{
	if(isdefined(level.mortar_quake))
	{
		fpower = level.mortar_quake;
	}
	else
	{ 
		if(!isdefined(fPower))
		{
			fPower = 0.3;
		}
	}

	if (!isdefined(iTime))
	{
		iTime = 2;
	}
	if (!isdefined(iRadius))
	{
		iRadius = 2000;
	}

	Binoc_Mortar_Sound();
	playfx ( level.mortar, origin );
	earthquake(fPower, iTime, origin, iRadius);

	if(isdefined(self.script_exploder))
	{
		self thread maps\_utility_gmi::exploder(self.script_exploder);

		// Damage player if too close to explosion
		if(self.script_exploder == 5)
		{
			if(distance(level.player.origin, self.origin) < 300)
			{
				level maps\_shellshock_gmi::main(8, 100, 15, 15);
			}
			else
			{
				radiusDamage(self.origin, 1024, 100, 1);
			}
		}

		// Stop the exploder function of triggers.
		level endon ("killexplodertridgers" + self.script_exploder);
		self.script_exploder = undefined;
	}

	if(isdefined(self.target))
	{
		if(isdefined(self.used_targets) && self.used_targets)
		{
			return;
		}

		if(isdefined(self.script_sound))
		{
			self playsound(self.script_sound);
		}

		self thread Binoc_Mortar_Falling_Debris();
	
	}
}

// Links slabs of walls/debris to tags on a model and animates it (reactor-steez).
Binoc_Mortar_Falling_Debris()
{
	self.used_targets = true;

	targets = getentarray(self.target,"targetname");

	// Get the anim name.
	for(i=0;i<targets.size;i++)
	{
		if(!isdefined(self.animname))
		{
			if(isdefined(targets[i].script_animname))
			{
				self.animname = targets[i].script_animname;
			}
		}
	}

	// Setup the fake origin.
	org = spawn("script_model", (0,0,0));
	org setmodel(("xmodel/" + self.animname));
	org.animname = self.animname;
	org UseAnimTree(level.scr_animtree["kharkov1_debris"]);

	// Link the targets to the org.
	for(i=0;i<targets.size;i++)
	{	
		if(!isdefined(targets[i].script_noteworthy))
		{
			println("^1Script_Noteworthy is needed for Falling_Debris @ (" + self.origin + ")");
			continue;
		}
		else
		{
			targets[i] linkto(org, targets[i].script_noteworthy,(0,0,0),(0,0,0));
			org thread Binoc_Debris_FX(org, targets[i].script_noteworthy, targets[i]);
//			playfxontag(level._effect["debris_trail_50"], org, targets[i].script_noteworthy);
		}
	}

	// Play the animation.
//	org setFlaggedAnimKnobRestart("animdone", level.scr_anim[self.animname]["reactor"]);
	org animscripted("single anim", org.origin, org.angles, level.scr_anim[org.animname]["reactor"]);
	org thread maps\_anim_gmi::notetrack_wait(org, "single anim", tag_entity, "reactor");

	org waittillmatch("single anim","end");
	org notify("stop_looping_fx");

	wait 0.1;

	// Unlink the Objects.
	for(i=0;i<targets.size;i++)
	{
		targets[i] unlink();
	}

	org delete();
}

Binoc_Debris_FX(org, tag, debris)
{
	debris thread Binoc_Debris_Sound(org, tag);
	org endon("stop_looping_fx");

	while(1)
	{
		playfxontag(level._effect["debris_trail_100"], org, tag);
		if(getcvarint("scr_gmi_fast") < 1)
		{
			wait 0.3;
		}
		else if(getcvarint("scr_gmi_fast") == 1)
		{
			wait 0.6;
		}
		else if(getcvarint("scr_gmi_fast") > 1)
		{
			return;
		}
	}
}

Binoc_Debris_Sound(org, tag)
{
	org endon("death");
	while(1)
	{
		org waittillmatch("single anim",tag + "_sound");
		println("SOUND (",tag,")");
		self playsound("big_stone_crash");
	}
}

// Fake mortar sounds.
Binoc_Mortar_Sound()
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

	if(isdefined(level.ambient) && level.ambient == "interior")
	{
		if (soundnum == 1)
		{
			self playsound ("shell_explosion_muffled1");
		}
		else
		if (soundnum == 2)
		{
			self playsound ("shell_explosion_muffled2");
		}
		else
		{
			self playsound ("shell_explosion_muffled3");
		}
	}
	else
	{
		if (soundnum == 1)
		{
			self playsound ("shell_explosion1");
		}
		else
		if (soundnum == 2)
		{
			self playsound ("shell_explosion2");
		}
		else
		{
			self playsound ("shell_explosion3");
		}
	}
}

// Fake mortars incoming sounds.
Binoc_Incoming_Sound(soundnum)
{
	level Binoc_Su152_Fire();

	if (!isdefined (soundnum))
	{
		soundnum = randomint(3) + 1;
	}

	if(isdefined(level.ambient) && level.ambient == "interior")
	{
		if (soundnum == 1)
		{
			self playsound ("shell_incoming_muffled1");
			wait 1 + randomfloat(3);
		}
		else
		if (soundnum == 2)
		{
			self playsound ("shell_incoming_muffled2");
			wait 1 + randomfloat(3);
		}
		else
		{
			self playsound ("shell_incoming_muffled3");
			wait 1 + randomfloat(3);
		}
	}
	else
	{
		if (soundnum == 1)
		{
			self playsound ("shell_incoming");
			wait 1 + randomfloat(3);
		}
		else
		if (soundnum == 2)
		{
			self playsound ("shell_incoming");
			wait 1 + randomfloat(3);
		}
		else
		{
			self playsound ("shell_incoming");
			wait 1 + randomfloat(3);
		}
	}
}

Binoc_Su152_Fire()
{
	level.su152_num++;

	if(level.su152_num > (level.su152.size - 1))
	{
		level.su152_num = 0;
	}

	the_su152 = level.su152[level.su152_num];

	playfxontag(level.fake_turret_fx, the_su152, "tag_flash");

	if(distance(level.player.origin, the_su152.origin) < 3500)
	{
		playfx(level._effect["distant_light"], (the_su152.origin + (0,0,1024)));
		the_su152 playsound("shell_flash");
	}
	else
	{
		the_su152 playsound("t34_fire");
	}

	forward_angles = anglestoforward(the_su152.angles);
	vec = the_su152.origin + maps\_utility_gmi::vectorScale(forward_angles, 100);
	the_su152 joltBody (vec, 1, 0, 0);

	the_su152 notify("turret_fire_done");
}

// Temp dialogue, until we get actual sounds.
Temp_Dialogue(text, timer, size)
{
	if(!level.temp_dialogue_check)
	{
		return;
	}

	if(isdefined(level.temp_dialogue))
	{
		level notify("new_temp_dialogue");
		level.temp_dialogue destroy();
	}


	level.temp_dialogue = newHudElem();
	level.temp_dialogue.alignX = "center";
	level.temp_dialogue.alignY = "middle";

	if(isdefined(size))
	{
		level.temp_dialogue.fontscale = size;
	}
	else
	{
		level.temp_dialogue.fontscale = "1";
	}

	level.temp_dialogue.x = 320;
	level.temp_dialogue.y = 360;

	if(isdefined(text))
	{
		level.temp_dialogue setText(text);
	}
	else
	{
		level.temp_dialogue setText(&"GMI_KHARKOV1_TEMP_MISSING");
	}

	if(!isdefined(timer))
	{
		timer = 3;
	}

	end_time = gettime() + (timer * 1000);

	level endon("new_temp_dialogue");
	
	while(gettime() < end_time)
	{
		wait 0.1;
	}

	level.temp_dialogue destroy();
}

Clean_Up_By_Death(groupname, targetname, delay, initial_delay, wait_till)
{
	if(isdefined(initial_delay))
	{
		wait initial_delay;
	}
	else if(isdefined(wait_till))
	{
		level waittill(wait_till);
	}

	if(isdefined(groupname))
	{
		type = "groupname";
		guys = getentarray(groupname,"groupname");
	}
	else if(isdefined(targetname))
	{
		type = "targetname";
		guys = getentarray(targetname,"targetname");
	}

	if(!isdefined(guys) || guys.size == 0)
	{
		if(type == "groupname")
		{
			println("^1(Clean_Up_By_Death): WARNING!!! No Targetname or Groupname found for '" + groupname + "'");
		}
		else
		{
			println("^1(Clean_Up_By_Death): WARNING!!! No Targetname or Groupname found for '" + targetname + "'");
		}
		return;
	}

	if(type == "groupname")
	{
		println("^3(Clean_Up_By_Death): Kill guys with Groupname: '" + groupname + "'");
	}
	else
	{
		println("^3(Clean_Up_By_Death): Kill guys with Targetname: '" + targetname + "'");
	}

	if(!isdefined(delay))
	{
		delay = 3;
	}

	println("^3(Clean_Up_By_Death): Guys.size: '" + guys.size + "'");
	for(i=0;i<guys.size;i++)
	{
		println("^3(Clean_Up_By_Death): ",i);
		if(isalive(guys[i]) && isai(guys[i]))
		{
//			level thread do_print3d(guys[i], undefined, "+", (1,0,0), 3);
			guys[i] dodamage((guys[i].health + 50), (guys[i].origin));
		}

		wait randomfloat(delay);
	}
}

Elefant_Firing()
{
	level.elefant endon("death");
	level.elefant.turret_targets = getentarray("elefant_target","targetname");
	level.elefant useanimtree(level.scr_animtree["elefant"]);

	while(1)
	{
		wait (4 + randomfloat(3));
//		level.elefant notify("turret_fire");
		playfxontag(level.elefant_turret, level.elefant, "tag_flash");
		level.elefant playsound("panzerIV_fire");
		level thread Elefant_Targets();


		forward_angles = anglestoforward(level.elefant.angles);
		vec = level.elefant.origin + maps\_utility_gmi::vectorScale(forward_angles, 100);
		level.elefant joltBody (vec, 1, 0, 0);
		level.elefant setanimknobrestart(level.scr_anim["elefant"]["fire"]);
	}
}

Elefant_Targets()
{
	wait (0.1 + randomfloat(0.25));
	random_num = randomint(level.elefant.turret_targets.size);

	org = level.elefant.turret_targets[random_num];
	soundnum = randomint(3) + 1;

	if(soundnum == 1)
	{
		org playsound ("mortar_explosion1");
	}
	else if (soundnum == 2)
	{
		org playsound ("mortar_explosion2")	;
	}
	else
	{
		org playsound ("mortar_explosion3");
	}

	playfx ( level.mortar, org.origin );
	earthquake(0.15, 2, org.origin, 850);
}

// Quick call to the fireattarget in combat_gmi
FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop)
{
	self animscripts\combat_gmi::FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop);
}

Setup_Fire_Trigger_Damage()
{
	level.player_on_fire = false;
//	triggers = getentarray("fire_hurt_trigger","targetname");
//	for(i=0;i<triggers.size;i++)
//	{
//		triggers[i] thread Fire_Trigger_Think();
//	}

	org[0] = (900, 3829, 95);
	radius[0] = 100;
	ender[0] = "stop_fire_think1";

	org[1] = (250, 4531, 100);
	radius[1] = 100;
	ender[1] = "stop_fire_think1";

	org[2] = (-586, 4760, 215);
	radius[2] = 72;
	ender[2] = "stop_fire_think1";

	org[3] = (-446, 4380, 215);
	radius[3] = 56;
	ender[3] = "stop_fire_think1";

	org[4] = (-652, 4178, 215);
	radius[4] = 48;
	ender[4] = undefined;

	org[5] = (-720, 3193, 210);
	radius[5] = 56;
	ender[5] = undefined;

	org[6] = (-879, 3963, 215);
	radius[6] = 56;
	ender[6] = undefined;

	org[7] = (-2240, 3966, 215);
	radius[7] = 72;
	ender[7] = undefined;

	org[8] = (-1380, 4045, 74);
	radius[8] = 72;
	ender[8] = undefined;

	org[9] = (-1713, 4525, 215);
	radius[9] = 72;
	ender[9] = undefined;

	org[10] = (-2056, 4632, 215);
	radius[10] = 72;
	ender[10] = undefined;

	org[11] = (-1735, 4915, 35);
	radius[11] = 72;
	ender[11] = undefined;

	org[12] = (-1191, 4844, 35);
	radius[12] = 72;
	ender[12] = undefined;

	org[13] = (-1445, 5150, 35);
	radius[13] = 72;
	ender[13] = undefined;

	org[14] = (-1488, 5377, 40);
	radius[14] = 64;
	ender[14] = undefined;

	org[15] = (-1621, 5987, 50);
	radius[15] = 48;
	ender[15] = undefined;

	org[16] = (-960, 3854, 215);
	radius[16] = 56;
	ender[16] = undefined;

	org[17] = (-124, 3343, 108);
	radius[17] = 56;
	ender[17] = undefined;

	org[18] = (-983, -1171, -98);
	radius[18] = 56;
	ender[18] = undefined;


	for(i=0;i<org.size;i++)
	{
		level thread Fire_Think(org[i], radius[i], ender[i]);
	}
}

Fire_Think(org, radius, ender)
{
	if(isdefined(ender))
	{
		level endon(ender);
	}

//	level thread Fire_Debug(org);
	while(1)
	{
		while(distance(level.player.origin, org) < 1024)
		{
			while(distance(level.player.origin, org) < radius)
			{
				level.player_touching_fire = true;
				if(!level.player_on_fire)
				{
					level thread Fire_Trigger_FX(org);
				}
				wait 0.5;
			}
			level.player_touching_fire = false;			
			wait 0.25;
		}

		wait 1;
	}
}

Fire_Debug(org)
{
	while(1)
	{
		dist = distance(org, level.player.origin);
		line(org, level.player.origin,(0,0,1));
		print3d((org + (0,0,32)), dist, (1,1,1), 5, 3);
		wait 0.06;
	}
}

Fire_Trigger_FX(org)
{
	level.player_on_fire = true;
	while(level.player_touching_fire)
	{
		random_x = (-18 + randomfloat(36));
		random_y = (-18 + randomfloat(36));
		random_z = randomfloat(56);
		playfx(level.flame_particle, (level.player.origin + (random_x, random_y, random_z)));

		chance = randomint(15);
		if(chance < 12)
		{	
			println(chance);
			dmg = 10 + randomint(10);
			level.player dodamage(dmg, org);
		}

		wait 0.1;
	}

	end_time = gettime() + 1000;

	decay = 0.1;

	while(gettime() < end_time)
	{
		random_x = (-18 + randomfloat(36));
		random_y = (-18 + randomfloat(36));
		random_z = (16 + randomfloat(56));
		playfx(level.flame_particle, (level.player.origin + (random_x, random_y, random_z)));

		chance = randomint(3);
		if(chance == 1)
		{	
			dmg = 5 + randomint(5);
			level.player dodamage(dmg, org);
		}
		
		wait decay;
		decay += 0.1;
	}
	level.player_on_fire = false;
}

// ======================================================== //
//              None Event Related Section                  //
// ======================================================== //

// Adds the 2 given arrays together and returns them into 1 array
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

// Animation Calls
anim_loop ( guy, anime, tag, ender, node, tag_entity )
{
	maps\_anim_gmi::anim_loop ( guy, anime, tag, ender, node, tag_entity );
}

anim_single (guy, anime, tag, node, tag_entity)
{
	maps\_anim_gmi::anim_single (guy, anime, tag, node, tag_entity);
}

anim_single_solo (guy, anime, tag, node, tag_entity, delay)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	newguy[0] = guy;
	maps\_anim_gmi::anim_single (newguy, anime, tag, node, tag_entity);
}

anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_loop (newguy, anime, tag, ender, node, tag_entity );
}

anim_reach (guy, anime, tag, node, tag_entity)
{
	maps\_anim_gmi::anim_reach(guy, anime, tag, node, tag_entity);
}

anim_reach_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_reach(newguy, anime, tag, node, tag_entity);
}

verify_and_add_to_array(array,ent)
{
	doadd = 1;
	if(isdefined(array))
	{
		for(i=0;i<array.size;i++)
		{
			if(array[i] == ent)
			{
				doadd = 0;
			}
		}
	}

	if(doadd == 1)
	{
		array = maps\_utility_gmi::add_to_array (array, ent);
	}
	return array;
}

// Random array, needed for the fake deaths.
random (array)
{
	return array [randomint (array.size)];
}

// Plays a sound on a tag.
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

// Deletes the entity once dead. For PlaySoundOnTag
delete_on_death (ent)
{
	ent endon ("death");
	self waittill ("death");
	if (isdefined (ent))
	{
		ent delete();
	}
}

// --- TESTING Section --- //

dist_check()
{
	while(1)
	{
		line(self.origin, level.player.origin, (1,1,1));

		dist = distance(self.origin, level.player.origin);

		print3d((self.origin + (0,0,100)), dist,(1,1,1), 5, 3);

		wait 0.06;
	}
}

tank_turret()
{
	tank = getent("t34_1","targetname");
	while(1)
	{
		tag = tank gettagorigin("tag_turret");

		forward_angles = anglestoforward(tank.angles);

     		vec = tank.origin + maps\_utility_gmi::vectorScale(forward_angles,500);

		line((vec + (0,0,72)), tag,(1,1,1));
		wait 0.06;
	}
}

test_tank_turret()
{
	while(1)
	{
		if(isdefined(self.fake_target))
		{
			tag = self gettagorigin("tag_turret");
			line((self.fake_target), tag,(1,1,1));
		}
		wait 0.06;
	}
}

// Testing Trigger Damages
test_trig_dmg()
{
	triggers = getentarray("trigger_damage","classname");
	while(1)
	{
		for(i=0;i<triggers.size;i++)
		{
			
		}
	}
}

test_miesha_spot()
{
	while(1)
	{
		if(isdefined(level.miesha.current_spot))
		{
			print3d((level.miesha.origin + (0,0,100)), level.miesha.current_spot,(1,1,1), 1, 1);

			if(isdefined(level.miesha.assigned_spot))
			{
				print3d((level.miesha.origin + (0,0,150)), level.miesha.assigned_spot,(1,1,1), 1, 1);				
			}

			wait 0.06;
		}
	}
}

test_tank_blow_barbed_wire()
{
	tank = getent("t34_2","targetname");
	for(i=0;i<3;i++)
	{
		tank waittill("reached_specified_waitnode");
		wait 0.5;
		println("GO!");
		level notify("T34s go");
	}

	tank waittill("reached_specified_waitnode");
	wait 2;
	tank setTurretTargetVec((552, -744, -117));
	tank waittill("turret_on_target");
	wait 2;
	tank FireTurret();

	trigger = getent("barbed_wire1","targetname");
	trigger waittill("trigger");

	println("I have been hit captain!!!!");
	println("I have been hit captain!!!!");
	println("I have been hit captain!!!!");
	println("I have been hit captain!!!!");
}

spawner_target_debug()
{
	spawners = getspawnerarray();

	while(1)
	{
		for(i=0;i<spawners.size;i++)
		{
			if(isdefined(spawners[i].target))
			{
				target = getnodearray(spawners[i].target,"targetname");

//				if(target.size > 1)
//				{
//					spawners = maps\_utility_gmi::subtract_from_array(spawners, spawners[i]);
//				}
				for(q=0;q<target.size;q++)
				{
					if(isdefined(target[q]))
					{
						line(spawners[i].origin, target[q].origin,(0,1,0));
					}
				}
			}
		}
		wait 0.06;
	}
}

MG42_TEST()
{
	while(1)
	{
		if(isdefined(self.manual_target))
		{
			print3d((self.origin + (0,0,100)), "PLAYER!",(1,1,1), 5, 3);
		}
		else
		{
			print3d((self.origin + (0,0,100)), "undefined",(1,1,1), 5, 3);
		}

		wait 0.06;
	}
}

do_line(pos1, pos2, color, msg)
{
	if(!isdefined(level.flag[msg]))
	{
		level.flag[msg] = false;
	}

	if(level.flag[msg])
	{
		level notify(msg + "_done");
		wait 0.05;
	}
	level endon(msg + "_done");

	level.flag[msg] = true;

	if(!isdefined(color))
	{
		color = (1, 1, 1);
	}

	while(1)
	{
		line(pos1, pos2, color);
		wait 0.06;
	}
}

do_print3d(ent, pos, msg, color, delay, size)
{
	if(!isdefined(ent) && !isdefined(pos))
	{
		return;
	}

	if(!isdefined(msg))
	{
		string = "STRING";
	}

	if(!isdefined(color))
	{
		color = (1,1,1);
	}

	if(!isdefined(delay))
	{
		delay = 1;
	}

	if(!isdefined(size))
	{
		size = 1.5;
	}

	timer = delay * 1000;
	end_time = gettime() + timer;

	while(gettime() < end_time)
	{
		if(isdefined(ent))
		{
			print3d((ent.origin + (0,0,100)), msg, color, 1, size);
		}
		else if(isdefined(pos))
		{
			print3d(pos, msg, color, 5, size);
		}

		wait 0.06;
	}
}

test_tiger_kill_button()
{
	setcvar("tiger_kill_button", "0");
	while(1)
	{
		if(getcvar("tiger_kill_button") == 1)	
		{
			if(isalive(self))
			{
				radiusDamage (self.origin, 512, self.health + 100,  1);
			}
			setcvar("tiger_kill_button", "0");
		}
		wait 0.5;
	}
}

trace_test()
{
//	wait 2;
	the_origin = (level.player.origin + (0,0,128));
	while(1)
	{
		trace_result = bulletTrace(the_origin, level.player.origin, false, undefined);
		line(the_origin, trace_result["position"], (1,1,1));
		println("Trace Result Entity: ",trace_result["entity"]);
		wait 0.06;
	}
}

test_miesha_tag()
{
	while(1)
	{
		org = level.miesha gettagorigin("tag_weapon_right");
		line(level.miesha.origin, org, (1,1,0));
		wait 0.06;
	}
}

//Total random, not being used though.
pak43_target_field()
{
	for(i=20;i>0;i--)
	{
		wait 1;
		println(i);
	}
	num = 0;
	tag_org = self gettagorigin("tag_turret");
	random_num = [];

	range[0] = self.target_max[0] - self.target_min[0];
	range[1] = self.target_max[1] - self.target_min[1];
	range[2] = self.target_max[2] - self.target_min[2];

	while(1)
	{
		num++;
		println("Number of Lines: ",num);

		for(q=0;q<range.size;q++)
		{
			if(range[q] < 0)
			{
				random_num[q] = range[q] * -1;
				random_num[q] = (randomint(random_num[q])) * -1;
			}
			else
			{
				random_num[q] = range[q];
				random_num[q] = randomint(random_num[q]);
			}
		}

		target = ((self.target_min[0] + random_num[0]), (self.target_min[1] + random_num[1]), (self.target_min[2] + random_num[2]));

		println("Target: ",target);
		self thread do_line(target, tag_org, (1,1,0), ("test " + num));
		wait 0.25;
	}
}

test_debris(mortars)
{
	self waittill("trigger");

	if(isdefined(mortars))
	{
		// Have it go through all of the mortars twice, a real pounding.
		for(q=0;q<1;q++)
		{
			println("^3Firing Mortars!");
			for(i=0;i<mortars.size;i++)
			{
				wait (randomfloat(1));
				mortars[i] thread Binoc_Mortar();
			}
		}
	}
	else
	{
		println("^3(Setup_Binoc_Triggers) Warning!! No Mortars for 'binoc_trigger'");
	}
}

