//
//Mapname: kharkov2
//Edited by: Mike
//

// Task List:
//-------------

//------
// Mine:
//------

// -Fix bug where there are no troops on the halftracks.
// -Clean up end for Train crash
// #320 @ end
// -Have troops coming out of train firing.
// -Add close up shots of russians fighting Germans at end.
// -Have T34s advance with troops after He111 bombing.

// -Whistle for the train.
// -Have sign fall down at first corner.
// -Balance end battle.
// -Prevent player from cheesing out the end battle by hiding under a train... Have Ai go to nodes 
// on opposite sides of the train and kill player.

// -Have friendly AI come from hole from He111 instead of far wall.

// -Change Engineer spawn point (low priority).

// FROM TASK LIST:
//----------------
// -(RICH):Need to create discreet VO events for Antonov to call out locations of threats. (RICH)
// -Need to know where the engineers are being escorted TO.
// -Add column of drone soldiers and tanks advancing on far side of square.
// -Have bombs fall on drone column if player doesn’t shoot down bombers in time.
// -Add VO event Antonov prompting the player to help out at long range.
// -Antonov prompts player to jump on Flak 88 and take out tanks.

// -The train arrives on the track behind the landing, guns blazing.
// -Cue Patriotic music.
// -German troops retreat.
// -Russian troops pour from the train.

// (POST ALPHA):
// -Add bombed out section along right side building, creating alternate path for player to move forward and flank.

//-------------//
// --- Log --- //
//-------------//

// 04/06/04
//----------
// -Added end of street battle.

// 04/07/04
//----------
// -Added He111's dropping bombs at end of street.
// -Also created generic he111 script (_he111_gmi.gsc)

// 04/08/04
//----------
// -Added building 2 blowing up.
// -Added facades crumbling to ground when he111's bomb.
// -Have player start next to tanks. (Done Already)
// -Orient player’s view to perpendicular to tanks, so he can see them pass them.
// -Have vehicles and infantry round the corner and encounter German infantry and MG positions.

// 04/09/04
//----------
// -Have tanks and infantry advance. (Done Already.)
// -Added tank blowing up first building.

// 04/12/04
//----------
// -Fixed up street
// -Took out guys in corner building, from 3 story building.
// -Added 6 enemy AI to the street, ground level.
// -MG42 guys at end of street now die.
// -Started Event9, which is the square battle.
// -Added friendly reinforcements for both groups. Had to create my own "replenish" system.
// -Delete He111s after they fly by.

// 04/12/04
//----------
// -German tanks randomly "fake" firing.
// -Friendly tanks make way into square.
// -Add objective and star for this objective. Currently "Objective1" is the text.
// -IN order to see the He111s at the beginning, I had to set the fog really far (15000 units),
// When the player triggers the he111s to go by, I then Adjust the fog back down to 8000 units.


// 04/20/04
//---------
// -Insert Objective
// -Add trigger around Antonov's location
// -Make sure Miesha and Antonov is in position before assigning objective.
// -Delay Objective extra time so player can explore the area.
// -Add dialogue for Antonov after player reaches him (objective).
// -Leap frog with Antonov, making it more time consuming and protect Antonov.
// -Trigger around Miesha's location.
// -Add dialogue for Antonov and Miesha. Antonov telling miesha to call in for engineers.
// -Constant respawning of a pair of engineers that want to blow up the trolly cars.
// -Maybe add a 3rd engineer if player is unsuccessful for a period of time.
// -Add german troops that close in on the engineers.
// -Friendlies move away.
// -Get particle effect in place.
// -Add bomb models
// -Possibly use animation for trolly flipping in air
// -Start next Event
// -Put light resistance behind rubble along road.

// 04/22/04
//----------
// -Fixed up all of the path_nodes including Jeds additions so they are not in solids.
// -Adjusted MG42 turrets, since they were using Trenches_Duck. Now they are MG42_BIPOD_Stand
// -Clip curbs.
// -Insert cover points
// -Add german resistance around the cover areas
// -If player gets too far from Antonov, penalize with bullet fire.
// -Add dialogue as Antonov and player reach each cover area.


// 05/17/04
//----------
// -Add clips to block roads.

// 05/19/04
//----------
// -Finish up end of map.
// -Add Sounds for bomber flying by
// -Add drones for victory end
// -Add panzerchreks.

// 05/26/04
//----------
// -Crash paths for the planes.
// -Squadron fly over sounds.
// -Fix angles ramp to miesha so Antonov can path better.
// -Add explo_bldg02 to building1 explosion.
// -Add explo_rock to the square building that blows up.

// 05/27/04
//----------
// -Add health paks to level.
// -Add rumble to building1 and building2 explosion.
// -Need new engineer skin.
// -Need engineer model with cable on his back.
// -Need to make sure the tanks are "ready" to go if triggered prematurely.
// -Add upper and lower beams to transition warehouse.
// -Change MG42 models at to be russian.
// -Add monster clip on top of roof at last battle.
// -Clean up by death after transition.
// -Add rumble to building1 and building2 explosion.
// -Add three possible paths for Stukas

// 06/09/04
//----------
// -Add rumble to wall just before main battle.
// -Adjust Triggers on first street so that the player does not lead. May need to add another friendly chain in the middle of the street.
// -Need to make sure the tanks are "ready" to go if triggered prematurely.
// -Scatter around the tracks fuel tank cars which can only be destroyed with the cannons.
// -Add Squadron flyover sounds
// -Antonov and player can navigate better through debris once in square.

// 06/10/04
//----------
// -Add flak explosions to flak gun (when firing in mid air, not hittin anything.).

// 06/14/04
//----------
// -Added engineer plant_bomb animation.
// -Fixed bug where enemy tanks would shoot around engineer path area.
// -Added fx for water tower, warehouse, trolleys, and little house.

// 06/14/04 through 06/19/04
//----------
// - Added clip-nosight around radio area.
// -Put vehicle clip in for tanks for rubble that falls in the street from Building1 explosion.
// -Add shell flash sounds playing (Steve??)
// -Add Burning tank sounds (Blend up fast after explosion and then blend down as fire goes out.)
// -Add Germans with fixed machine guns in the square.
// -Add threat to Antonov as he moves from cover to cover.  Player MUST neutralize threat or Antonov will get shot.
// -If player compromises their own cover, they should get shot.
// -Need clip rubble/ground areas where the player can get stuck, caught, or otherwise encumbered.
// -Have initial light German resistance on primary platform when player and squad come over wall.
// -Confine player and his squad to main platform, but add three other Russian squads running up to take position on secondary (middle) platform.
// -Have Russians engage German infantry.
// -Have stuka strafe secondary platform, drop bombs - take out ONE of the Russian squads.
// -Enter German tank + infantry - have tanks OWN the other two Russian squads.
// -Player and squad make last stand on main platform.
// -Successive waves of bigger and bigger German attacks - tanks, half tracks, flamethrower guys.
// -Add Germans with deployable machine guns.
// -Add deployable DP-28s for Russians.
// -Add extra scoped Kar98ks around for ammo.
// -Add SVT-40s, Mosin-Nagants, PPShs, Grenades as pickups.
// -Add crashed He111 in back of trainstation. (Level Design).

// 06/20/04
//---------- 
// -Increase accuracy of MGs (done?)
// -Make end harder? Lower friendly AI health (done?)
// -Made Antonov's spot brighter. Obective "Find Antonov" (made hole in building so sky light can cast on him)
// -Made Antonov's spot brighter. Radio area, gave ceiling a bigger hole so more sky light can cast through.
// -Add sniper rifle up on bridge
// -Need threat to player as they fight engineers.
// -Player clipped he111 in back of trainstation.
// Make tanks objective at end.

#using_animtree("generic_human");
main()
{
//	setCullFog (500, 15000, 0.19, 0.20, 0.21, 0 );
	if (getcvarint("scr_gmi_fast") < 2)
	{
		setCullFog (500, 15000, 0.34, 0.36, 0.36, 0 );
	}
	else
	{
		setCullFog (500, 6000, 0.34, 0.36, 0.36, 0 );
	}
	// To compensate for new Sky (me no likey).
//	setCullFog (500, 15000, 0.035, 0.078, 0.078, 0 ); 

	// --- Preload --- //
	maps\_load_gmi::main();
	maps\_flak_gmi::main();	
	maps\_flakvierling_gmi::main();
	maps\_tank_gmi::main();
	maps\_t34_gmi::main();
	maps\_sherman_gmi::main();
	maps\_panzerIV_gmi::main();
	maps\_tiger_gmi::main();
	maps\_halftrack_gmi::precache();
	maps\_stuka_gmi::main();
//	maps\_bmwbike_gmi::main();
	maps\_he111_gmi::main();
	maps\kharkov2_fx::main();
	maps\kharkov2_anim::main();
	maps\kharkov2_dummies::main();

	level.Turret_Missionfail_Tracker = maps\kharkov2::Turret_Missionfail_Tracker;

	// Preacache the LMG guys.
	animscripts\lmg_gmi::precache();

	maps\_debug_gmi::main();

//	setcvar("cg_fov","80");
//	setcvar("timescale","1");

	// Rain
//	level.atmos["rain"] = loadfx ("fx/atmosphere/rain_medium.efx");

	// Ambient sound
	level.ambient_track["exterior"] = "ambient_kharkov_ext";
	level.ambient_track["interior"] = "ambient_kharkov_int";
	level thread maps\_utility_gmi::set_ambient("exterior");
	// Friendly Respawner
	//level.max["allies_group2"] = 3;
	//level.max["allies_group1"] = 4;

	level.last_area = false;

	// For do_line
	level.flag = [];
	level.flag["event11_started"] = false;
	level.flag["stuka_yell1"] = false;
	level.flag["tank_yell1"] = false;
	level.flag["kharkov2_special"] = false;
	level.kharkov2_missionfail_tracker = true;
	level.kharkov2_turret_kills = 0;

	// --- Precaching Stuff --- //
	precachemodel("xmodel/kharkov2_facadeA");
	precachemodel("xmodel/kharkov2_facadeB");

	precachemodel("xmodel/kharkov2_trolly_exp");
	precachemodel("xmodel/kharkov2_warehouse_exp");
	precachemodel("xmodel/kharkov2_little_house");
	precachemodel("xmodel/o_rs_prp_fuelcar_dmg");
	precachemodel("xmodel/kharkov2_traincrash");

	// Miesha's radio.
	precachemodel("xmodel/kharkov1_receiver");
	precacheModel("xmodel/vehicle_tank_panzeriv_machinegun");
	precacheitem("med health");

	// Strings.
	precachestring(&"GMI_KHARKOV2_REINFORCEMENTS");

	precachemodel("xmodel/o_engineer_icon");

	precachemodel("xmodel/stalingrad_megaphone");

	// Throw away the garbage! Models/temp objects not used in the game.
	garbage = getentarray("garbage","targetname");
	for(i=0;i<garbage.size;i++)
	{
		garbage[i] delete();
	}

	// --- Level.Stuff --- //
	// Used for the min/max delay of the distant lights
	level.dist_light_min_delay = 5;
	level.dist_light_max_delay = 15;

	level.temp_dialogue_check = true;

	level.event9_he111_count = 0;

	level.camera_in_use = false;
	level.friendly_threatbias = 0;


	if(getcvar("skipto_event9") == "")
	{
		setcvar("skipto_event9","0");
	}

	if(getcvar("skipto_event10") == "")
	{
		setcvar("skipto_event10","0");
	}

	if(getcvar("quick_end") == "")
	{
		setcvar("quick_end","0");
	}

	if(getcvar("end_timer") == "")
	{
		setcvar("end_timer","0");
	}

	if(getcvar("end_cine") == "")
	{
		setcvar("end_cine","0");
	}

	level thread Setup_Low_Spec();
	level thread Setup_Characters();
	level thread Setup_Turrets();
	level thread Event9_Statue_Setup();
	level thread Setup_Random_Triggers();
	level thread Objectives();
	level thread Ambience_Setup();
	level thread Setup_T34_Go_Triggers();
	level thread Setup_FriendlyWave_Triggers();
	level thread Setup_Falling_Facades();
	level thread Setup_Event9_CarCrush();
	level thread Setup_End_Train();
	level thread Tank_Turret_Trigger_Setup();
	level thread Friendly_Respawner_Setup("allies_group1");
	level thread Friendly_Respawner_Setup("allies_group2");
	level thread Event8_Setup_Tanks();
	level thread Event8();
	level thread Music();
	level thread Setup_Fire_Trigger_Damage();

	level thread maps\_utility_gmi::chain_off("event10_chains");

// 	Testing!
//	level thread Falling_Debris("building1_debris");
//	level thread Event9_Blow_Trolleys();
//	level thread power_move();

//	wait 10;
//	level thread Event9_Blow_Trolleys();
//	anti_air = getent("event9_anti_air","targetname");
//	anti_air maps\_flakvierling_gmi::init(12000);
//	wait 10;
//	level thread Event9_He111();
//	// Setup Anti-Air Gun in square.

//	level thread Test_Dummies();
//	level thread test_classname();

//	level thread vehicle_line();
}

// Sets up low spec stuff
Setup_Low_Spec()
{
	//level waittill("finished intro screen");

	println("^3 Low Spec Setup");
	println("^3----------------");

	if(getcvarint("scr_gmi_fast") > 1)
	{
		level.he111s = false;
		getent("md_124","targetname") delete();
		getent("md_125","targetname") delete();
		getent("md_127","targetname") delete();
		
		level.max["allies_group2"] = 1;
		level.max["allies_group1"] = 1;
		
		// This is bad.
		getent("md_23","target") delete();
		getent("md_30","target") delete();
		getent("md_140","target") delete();
		getent("md_143","target") delete();
		getent("md_1387","target") delete();
		getent("md_1391","target") delete();
		getent("md_1403","target") delete();
		getent("md_1406","target") delete();
		getent("mg42_3_spot","target") delete();
		getent("js_deleteme1","targetname") delete();
		getent("js_deleteme2","targetname") delete();
		getent("js_deleteme3","targetname") delete();
		getent("js_deleteme4","targetname") delete();
		getent("js_deleteme5","targetname") delete();
	
		level.squarespawner1 = 8;
		level.squarespawner2 = 2;
	}
	else
	{
		level.he111s = true;
		level.max["allies_group2"] = 3;
		level.max["allies_group1"] = 4;
		
		level.squarespawner1 = 14;
		level.squarespawner2 = 5;
	}

	if(getcvarint("scr_gmi_fast") > 0)
	{
		println("^3level.mortar = level.mortar_low");
		level.mortar = level.mortar_low;
	}
}

// Sets up the train at the end of the map.
Setup_End_Train()
{
	traincars = getentarray("traincar","targetname");
	level.locomotive = getent("locomotive","targetname");
	for(i=0;i<traincars.size;i++)
	{
		traincars[i] linkto(level.locomotive);
	}

//	smoke_stack = spawn("script_origin", (-2430,10016, 96));
	smoke_stack = spawn("script_origin", (-2550,10016, 96));
	smoke_stack linkto(level.locomotive);
	level.locomotive.smoke_stack = smoke_stack;

	steam_org = spawn("script_origin", (-2444,9950, -130));
	steam_org linkto(level.locomotive);
	level.locomotive.steam_org = steam_org;

	spark_org = (-2444, 9961, -162);
	level.locomotive.sparks = [];
	for(i=0;i<30;i++)
	{
		spark_org = spark_org + ((16 + randomint(256)),0,0);
		spark_ent = spawn("script_origin", spark_org);
		spark_ent linkto(level.locomotive);
		level.locomotive.sparks[level.locomotive.sparks.size] = spark_ent;
	}
	
	level.locomotive.end_pos = level.locomotive.origin;
	wait 1;
	level.locomotive moveto((level.locomotive.origin + (12000,0,0)), 1, 0, 0);

//	level thread End_Train_Smoke();
//	level thread End_Train_Steam();
//	level thread End_Sparks_FX();

	if((getcvarint("sv_cheats") > 0) && (getcvarint("end_cine") == 1))
	{
		level notify("start_end_music");
	//	level thread player_angles();
//		wait 21; // <- Actual delay.
		wait 10;
		level thread End_Cinematic();
	}
}

End_Train_Move()
{
	level.locomotive moveto(level.locomotive.end_pos, 20, 0, 10);
	level.locomotive waittill("movedone");
}

End_Train_Steam()
{
	level endon("camera_4_started");
	while(1)
	{
		num = 30 + randomint(5);
		for(i=0;i<num;i++)
		{
			angles = vectornormalize((level.locomotive.steam_org.origin + (0,-1,0)) - level.locomotive.steam_org.origin);
			playfx (level._effect["train_side_steam"], level.locomotive.steam_org.origin, angles);
			wait 0.2;
		}
		wait (0.1 + randomfloat(0.25));
	}
}

// The train smoke at the end of the level.
End_Train_Smoke()
{
	level endon("camera_4_started");
	while(1)
	{
		num = 30 + randomint(5);
		for(i=0;i<num;i++)
		{
			playfx (level._effect["train_smoke"], level.locomotive.smoke_stack.origin);
			wait 0.1;
		}
		wait (0.1 + randomfloat(0.5));
	}
}

// Just making the turrets levelnames.
Setup_Turrets()
{
	level.anti_air1 = getent("FlakVierling","targetname");
	level.anti_air2 = getent("event9_anti_air","targetname");
	level.flak88 = getent("event11_flak88","targetname");
}

// Sets up all of the friendly characters that will be with
// the player the entire level.
Setup_Characters()
{
	// Precacahe Engineers
	character\RussianArmyEngineer::precache();

	character\RussianArmyOfficer_flagwave::precache();
	character\RussianArmyOfficer_shout2 ::precache();

	// Setup friends
	// Vassili
	character\RussianArmyVassili::precache();
	vassili = getent("vassili","targetname");
	vassili.groupname = "friends";
	vassili.goalradius = 32;
	vassili.accuracy = 1.0;
	vassili.script_uniquename = "friendlychain_ai";
	vassili.animname = "vassili";
	vassili.original_animname = "vassili";
	vassili.bravery = 100;
	vassili.grenadeammo = 5;
	vassili.followmax = 5;
	vassili.suppressionwait = 1;
	vassili.maxsightdistsqrd = 9000000; // 3000 units
	vassili character\_utility::new();
	vassili character\RussianArmyVassili::main();
	vassili thread maps\_utility_gmi::magic_bullet_shield();
	level.vassili = vassili;

//	vassili attach("xmodel/o_engineer_icon","TAG_HELMET");

	// Miesha
	character\RussianArmyMiesha_Radio::precache();
	miesha = getent("miesha","targetname");
	miesha.groupname = "friends";
	miesha.goalradius = 32;
	miesha.animname = "miesha";
	miesha.original_animname = "miesha";
	miesha.script_uniquename = "friendlychain_ai";
	miesha.current_spot = 0;
	miesha.accuracy = 0.7;
	miesha.bravery = 50;
	miesha.grenadeammo = 2;
	miesha.maxsightdistsqrd = 9000000; // 3000 units
	miesha.followmax = 5;
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
	antonov.pacifistwait = 0;
	antonov.takedamage = false;
	antonov.ignoreme = true;
	antonov.name = "Sgt. Antonov";
	antonov.script_uniquename = "friendlychain_ai";
	antonov.maxsightdistsqrd = 3000;
	antonov character\_utility::new();
	antonov character\RussianArmyantonov::main();
	antonov.health = 400;
	antonov thread maps\_utility_gmi::magic_bullet_shield();
	antonov.second_squad_charge = false;
	antonov.goalradius = 32;
	antonov.threatbias = -500;
	level.antonov = antonov;
	level.antonov.assigned_spot = 0;
	level.antonov.current_spot = 0;

	level.friends = getentarray("friends","groupname");

	for(i=0;i<level.friends.size;i++)
	{
		level thread maps\kharkov2::Turret_Missionfail_Tracker(level.friends[i]);
	}

	level thread Turret_Kill_Dec();

	// Group2 Commander
	group2_commander = getent("group2_commander","targetname");
	group2_commander thread maps\_utility_gmi::magic_bullet_shield();
	level.group2_commander = group2_commander;
	level.group2_commander.animname = "group2_commander";

	// Also setup the followmax's for the groups.

	allies = getaiarray("allies");
	for(i=0;i<allies.size;i++)
	{
		if(isalive(allies[i]) && isdefined(allies[i].groupname))
		{
			if(allies[i].groupname == "allies_group1" || allies[i].groupname == "allies_group2")
			{
				allies[i].goalradius = 32;
				allies[i].followmax = 5;
			}
		}
		wait 0.05;
	}
}

// Used for TRIGGERS that spawn in RANDOM amount of AI. May need to take out.
Setup_Random_Triggers()
{
	triggers = getentarray("random_spawner","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread Random_Trigger_Think();
	}
}

// Used for TRIGGERS that spawn in RANDOM amount of AI. May need to take out.
Random_Trigger_Think(manual)
{
	if(!isdefined(manual))
	{
		self waittill("trigger");
	}

	if(!isdefined(self.count) || self.count < 1)
	{
		println("^1(Random_Trigger_Think): No 'count' found for Trigger, not spawning anyone!!");
		return;
	}

	// Get the spawners, and sort them out.
	spawners = getspawnerarray();
	the_spawners = [];
	for(i=0;i<spawners.size;i++)
	{
		if(!isdefined(spawners[i].groupname))
		{
			continue;
		}

		if(spawners[i].groupname == self.groupname)
		{
			the_spawners[the_spawners.size] = spawners[i];
		}
	}

	if(self.count > the_spawners.size)
	{
		self.count = the_spawners.size;
	}

	count = self.count;

	println("^1(Random_Trigger_Think): Self.count: ",self.count);

	if(self.count > the_spawners.size)
	{
		println("^3(Random_Trigger_Think): Spawning in ALL groupname spawners since count > spawner.size");
		for(i=0;i<the_spawners.size;i++)
		{
			the_spawners[i] dospawn();
		}
		return;
	}
	
	spawner_check = [];
	while(count > 0)
	{
		random_num = randomint(the_spawners.size);
		if(spawner_check.size == 0)
		{
			spawned = the_spawners[random_num] dospawn();
			spawner_check[spawner_check.size] = the_spawners[random_num];

			if(isdefined(spawned))
			{
				if(isdefined(self.script_noteworthy))
				{
					if(self.script_noteworthy == "stand_only")
					{
						println("STAND ONLY!");
						spawned allowedstances("stand");
					}
				}
			}
			count--;
		}
		else
		{
			got_one = false;
			while(!got_one)
			{
				random_num = randomint(the_spawners.size);
				println("^3Trying ",random_num);
				for(q=0;q<spawner_check.size;q++)
				{
					if(!got_one)
					{
						println("^3Testing: ", q, " ^3:: ",random_num);
						if(spawner_check[q] != the_spawners[random_num])
						{
							got_one = true;
							continue;
						}
					}
				}
			}

			spawned = the_spawners[random_num] dospawn();
			spawner_check[spawner_check.size] = the_spawners[random_num];

			if(isdefined(spawned))
			{
				if(isdefined(self.script_noteworthy))
				{
					if(self.script_noteworthy == "stand_only")
					{
						println("STAND ONLY!");
						spawned allowedstances("stand");
					}
				}
			}
			count--;
		}
		println("^5Spawned in Number = ", random_num, "^5Count = ",count);
		wait 0.1;
	}

	println("^3Finished Spawning in Random Guys");
}

// Gets all of the trigger_friendlychains, and checks to see if it has a script_noteworthy.
// If so, then that trigger is threaded to FriendlyWave_Trigger_Think()
Setup_FriendlyWave_Triggers()
{
	triggers = getentarray("trigger_friendlychain","classname");

	f_triggers = [];
	for(i=0;i<triggers.size;i++)
	{
		if(isdefined(triggers[i].script_noteworthy))
		{
			triggers[i] thread FriendlyWave_Trigger_Think();
		}
	}
}

// This function tells the 2nd squad where to go.
FriendlyWave_Trigger_Think()
{
	self waittill("trigger");
//	ents = getentarray("allies_group2","groupname");

	node = getnode(self.script_noteworthy,"targetname");
	level.group2_commander setfriendlychain(node);

	if(isdefined(self.script_uniquename) && self.script_uniquename == "antonov")
	{
		level thread Antonov_Movement();
	}
}

// Controls the majority of the Objectives
Objectives()
{
	objective_add(1, "active", &"GMI_KHARKOV2_OBJECTIVE1", (2616, 3560, -65));
	objective_current(1);	

	level waittill("objective 1 complete");
	objective_state(1,"done");
//	level waittill("objective 2 start");

	objective_add(2, "active", &"GMI_KHARKOV2_OBJECTIVE2", (2856, 3392, 10));
	objective_current(2);

	level waittill("objective 2 complete");
	objective_state(2,"done");
	level waittill("objective 3 start");

	objective_add(3, "active", &"GMI_KHARKOV2_OBJECTIVE3", (0, 0, 0));
	objective_current(3);
	level.antonov thread Event9_Star_Tracker();

	level waittill("objective 3 complete");
	objective_state(3,"done");

	objective_add(4, "active", &"GMI_KHARKOV2_OBJECTIVE4");
	objective_current(4);

	level waittill("objective 4 complete");
	objective_state(4,"done");

	node = getnode("event9_antonov_adv_spot","targetname");
	objective_add(5, "active", &"GMI_KHARKOV2_OBJECTIVE5", node.origin);
	objective_current(5);

	level waittill("objective 5 complete");
	objective_state(5,"done");
	level waittill("objective 6 start");

	anti_air = getent("event9_anti_air","targetname");
	objective_add(6, "active", &"GMI_KHARKOV2_OBJECTIVE6", anti_air.origin);
	objective_string(6, &"GMI_KHARKOV2_OBJECTIVE6", level.event9_he111_total);
	objective_current(6);

	level waittill("objective 6 complete");
	objective_state(6,"done");

	level thread objective7_star_updater();

	objective_add(7, "active", &"GMI_KHARKOV2_OBJECTIVE7", (3048, 7988 , 19));
	//objective_add(7, "active", &"GMI_KHARKOV2_OBJECTIVE7", (-704, 9792 , -148));
	objective_current(7);

	level waittill("objective 7 complete");
	objective_state(7,"done");

	objective_add(8, "active", &"GMI_KHARKOV2_OBJECTIVE8");
	objective_string(8, &"GMI_KHARKOV2_OBJECTIVE8", level.event11_tank_count);
	objective_current(8);

	level waittill("objective 8 complete");
	objective_state(8,"done");

	objective_add(9, "active", &"GMI_KHARKOV2_OBJECTIVE9");
	objective_current(9);

	level waittill("objective 9 complete");
	objective_state(9,"done");
}

objective7_star_updater()
{
	getent("md_1175","target") waittill ("trigger");
	objective_position(7, (-704, 9792 , -148));
}

// Assigns Antonov his next position.
// override_num: optional, if you want to force him to go to a certain spot.
// nodamage_player: stops damaging the player if enabled, when the
// player is not close enough to Antonov
Antonov_Movement(override_num, want_return, nodamage_player)
{
	level.antonov notify("assigned_new_node");

	if(isdefined(override_num))
	{
		level.antonov.assigned_spot = override_num;
		node = getnode("antonov_spot" + override_num,"targetname");		
	}
	else
	{
		level.antonov.assigned_spot++;
		node = getnode("antonov_spot" + level.antonov.assigned_spot,"targetname");
	}

	level.antonov.og_suppressionwait = level.antonov.suppressionwait;
	level.antonov.suppressionwait = 0;

	level.antonov setgoalnode(node);
	level.antonov.assigned_node = node;

	if(isdefined(want_return))
	{
		level.antonov Antonov_Reached_Goal(nodamage_player);
		return;
	}
	else
	{
		level.antonov thread Antonov_Reached_Goal(nodamage_player, node);
	}
}

// Part of the Antonov_Movement
// Updates his position once he's reached his destination.
Antonov_Reached_Goal(nodamage_player, node)
{
	self endon("assigned_new_node");

	if(isdefined(nodamage_player) && nodamage_player)
	{
//		level notify("Event9_Player_DistTracker");
		self waittill("goal");

		if(isdefined(self.og_suppressionwait))
		{
			self.suppressionwait = self.og_suppressionwait;
		}
		self.current_spot = self.assigned_spot;
//		wait 3;
//		level thread Event9_Player_DistTracker();
	}
	else
	{
		self waittill("goal");

		if(isdefined(node.script_noteworthy))
		{
			if(node.script_noteworthy == "pacifist_off")
			{
				self.pacifist = false;
			}
		}

		if(isdefined(self.og_suppressionwait))
		{
			self.suppressionwait = self.og_suppressionwait;
		}
		self.current_spot = self.assigned_spot;
	}

	if(self.current_spot == "5")
	{
		level.antonov thread anim_loop_solo(level.antonov, "event9_run2_coverloop", undefined, "stop_anim", level.antonov.assigned_node);
	}

}

anti_air_regen()  
{  
     self endon("death");  
     health = self.health;  
     while(1)  
     {  
          self waittill("damage", dmg, attacker);  
          if(attacker == self)  
          {  
               self.health = health;  
          }  
     }  
}

// Starts event8, guys following chains, and tanks begin movement.
Event8()
{
	if(getcvarint("sv_cheats") > 0 && getcvar("skipto_event9") == "1")
	{
		level thread Skipto_Event9();
		return;
	}
	else if(getcvarint("sv_cheats") > 0 && getcvar("skipto_event10") == "1")
	{
		level thread Skipto_Event10();
		return;
	}

	// Setup Building2's debris
	debris = getent("event8_building2_debris","targetname");
	debris hide();
	debris notsolid();
	debris connectpaths();

	event8_group2_chain1 = getnode("event8_group2_chain1","targetname");
	println("event8_group2_chain1 ",event8_group2_chain1);
	level.group2_commander setfriendlychain(event8_group2_chain1);
	wait 2;
	level.antonov thread anim_single_solo(level.antonov, "comm_attack");
//	org = spawn("script_origin",level.player.origin);
//	org playLoopSound("bomber_loop_01_high");

	allies_group2 = getentarray("allies_group2","groupname");
	for(i=0;i<allies_group2.size;i++)
	{
		if(isalive(allies_group2[i]))
		{
			allies_group2[i].goalradius = 32;
			allies_group2[i] setgoalentity(level.group2_commander);
		}
	}
	
	level waittill("finished intro screen");

	getent("texture_loader","targetname") delete();

	event8_chain1 = getnode("event8_chain1","targetname");
	level.player setfriendlychain(event8_chain1);

	other_friendlies = getentarray("allies_group1","groupname");

	all = add_array_to_array(other_friendlies, level.friends);
	for(i=0;i<all.size;i++)
	{
		if(isalive(all[i]))
		{
			all[i].goalradius = 32;
			all[i].script_uniquename = "friendlychain_ai";
			all[i] setgoalentity(level.player);
		}
	}

	level thread Antonov_Movement();
	level thread Event8_Mg42S();
	level thread Event8_He111();
	level thread Event9();
}

Event8_Building1_Dialogue()
{
	//ai_dialogue(getclosest, ent, animname, dialogue, delay, excluders)
	self waittill("hit_target");
	level thread ai_dialogue(true, undefined, "anon_trooper", "gen_lookout", 2);
	level thread ai_dialogue(true, undefined, "anon_trooper", "gen_alright", 5);
}


// Spawns in the mg42 guys that man the MG42s at the end of the street.
// Also kills off any remaining Axis still fighting.
Event8_Mg42S()
{
	trigger = getent("event8_mg42s","script_noteworthy");
	trigger waittill("trigger");

	level thread Clean_Up_By_Death("event8_axis_group1", undefined, 0.1, 0.1, undefined);
	level thread Clean_Up_By_Death("event8_axis_group2", undefined, 0.1, 0.1, undefined);
}

// Triggers the HE111s to bomb the facades, foreshadow
Event8_He111()
{
	if (level.he111s == true)
	{
		// So that the Event8 He111s use the he111_bomb_low fx.
		level.he111_bomb_lod_dist = 1;
		trigger = getent("event8_he111","targetname");

		trigger waittill("trigger");

		he111_nodes = getvehiclenodearray("event8_he111_start","targetname");

		sound_org = getent("event8_he111_sound_origin","targetname");

		num = 0;
		skip = false;
		for(i=0;i<he111_nodes.size;i++)
		{
			num++;
			if(num > 4)
			{
				num = 1;
			}

			if(!skip)
			{
				skip = true;
				the_sound = "squadron_flyover_0" + num + "_short";

				sound_org playsound(the_sound);
			}
			else
			{
				skip = false;
			}

			level thread Vehicle_Spawner("he111", he111_nodes[i], 0, 10000, start_sound, 1, 7);
			wait 0.1;
		}
	}
}

// Setup the T34s
Event8_Setup_Tanks()
{
	tanks = getentarray("event8_tanks","groupname");
	for(i=0;i<tanks.size;i++)
	{
		println("^3Setting up Tank: ",tanks[i].targetname);
		path = getvehiclenode(tanks[i].targetname + "_start","targetname");
		tanks[i].health = 1000;
		// Default = 400, forward radius to see if the tank needs to avoid another tank.
		tanks[i].coneradius = 100;
		tanks[i] maps\_t34_gmi::init();
		tanks[i] thread maps\_tankgun_gmi::mgoff();
		tanks[i].rollingdeath = 1;
		tanks[i].attachedpath = path;
		tanks[i] attachpath(path);
		tanks[i] startpath();
		tanks[i] setspeed (0, 5);
		tanks[i] thread remove_smoke_minspec();
		tanks[i] thread Tank_Health_Regen(100000);
	}

	level waittill("finished intro screen");

	for(i=0;i<tanks.size;i++)
	{
		tanks[i] resumespeed (10);
		tanks[i] thread Tank_Turret_Random_Turning();

		tanks[i] thread Pathnode_Think();
	}
}

// When the t34 gets into position, it blows up building2.
Event8_Blow_Building2()
{
	self waittill("hit_target");
	level thread maps\_utility_gmi::exploder(9);

	// Clean up everything behind us (the enemies)
	level thread Clean_Up_By_Death("event8_axis_group2b", targetname, 3, 3);

	time1 = gettime();

	num = [];

	for(i=0;i<6;i++)
	{
		num[num.size] = 3 + (num.size);
//		num_size = num.size;
//		while(num.size < (num_size + 1))
//		{
//			number = (3 + randomint(6));
//			num = verify_and_add_to_array(num, number);
//		}
	}

	num = maps\_utility_gmi::array_randomize(num);

	wait 0.5;

	level thread maps\_utility_gmi::playSoundinSpace ("glass_building_explode", (1480,2040,8));

	earthquake(0.4, 2, (1480,2040,8), 3000);
	
	// stuff here

	if(getcvarint("scr_gmi_fast") < 2)
	{
		for(i=0;i<num.size;i++)
		{
			level thread maps\_utility_gmi::exploder(num[i]);
			wait (randomfloat(0.15));
		}


		level thread maps\_utility_gmi::exploder(2);
	}
	
	debris = getent("event8_building2_debris","targetname");
	debris show();
	debris solid();
	debris disconnectpaths();

	building2_hurt = getent("building2_hurt","targetname");
	axis = getaiarray("axis");
	for(i=0;i<axis.size;i++)
	{
		if(axis[i] istouching(building2_hurt))
		{
			axis[i] dodamage(axis[i].health + 50, axis[i].origin);
		}
	}

	self waittill("reached_specified_waitnode");
	while(self.speed > 0)
	{
		wait 0.5;
	}

	level thread Event9_Transition();
}

// If CVAR skipto_event9 is 1, then this will simulate everything up to event9.
Skipto_Event9()
{
	level thread Event9();

	tanks = getentarray("event8_tanks","groupname");
	for(i=0;i<tanks.size;i++)
	{
		tanks[i].skipto = 2;
	}

	org = (768, 2080, -156);

	player_node = getnode("event9_chain1","targetname");
	level.player setfriendlychain(player_node);

	allies_group1 = getentarray("allies_group1","groupname");
	allies_group1 = add_array_to_array(allies_group1, level.friends);
	for(i=0;i<allies_group1.size;i++)
	{
		if(issentient(allies_group1[i]))
		{
			allies_group1[i] teleport(org);
			allies_group1[i].script_uniquename = "friendlychain_ai";
			allies_group1[i] setgoalentity(level.player);
	
			org = ((org[0] - 36), org[1], org[2]);
		}
	}

	org = (768, 2520, -134);

	group2_node = getnode("event9_group2_chain1","targetname");
	level.group2_commander setfriendlychain(group2_node);
	level.group2_commander setgoalnode(group2_node);

	allies_group2 = getentarray("allies_group2","groupname");
	for(i=0;i<allies_group2.size;i++)
	{
		if(issentient(allies_group2[i]))
		{
			allies_group2[i] teleport(org);
			allies_group2[i] setgoalentity(level.group2_commander);
	
			org = ((org[0] - 36), org[1], org[2]);
		}
	}

	level.antonov teleport((380,2240,-156));
	level thread Antonov_Movement(3);

	wait 0.5;
	level.player setorigin((-532,2240,-156));
	wait 0.5;
	level.player setorigin((344,2120,-156));
//	level.player setplayerangles((0,30,0));

//	tank1 = getent("event9_tank1","targetname");
//	radiusDamage(tank1.origin, 1024, 5000, 5000);
//	tank2 = getent("event9_tank2","targetname");
//	radiusDamage(tank2.origin, 1024, 5000, 5000);
}

// Starts event9, including respawners, and tanks.
Event9()
{
	trigger = getent("event9_start","targetname");
	trigger waittill("trigger");
	level.max["allies_group2"] = 0; //Group2 goes bye-bye.

	setCullFog (500, 8000, 0.34, 0.36, 0.36, 10 );

	// To compensate for new Sky (me no likey).
//	setCullFog (500, 8000, 0.035, 0.078, 0.078, 0 ); 

	// Setup event9_tank1 and event9_tank2, PanzerIV behind sandbags on left side of square.
	for(i=1;i<3;i++)
	{
		tank = getent("event9_tank" + i,"targetname");
		tank maps\_panzerIV_gmi::init();
	
		fake_targets = getentarray("event9_german_fake_targets","targetname");
		tank Tank_Add_Targets(fake_targets);
		tank thread Tank_Turret_Think(3, 7, true);
		tank thread remove_smoke_minspec();
	}

	level thread maps\_respawner_gmi::random_respawner_setup("event9_axis_group1", undefined, attrib, undefined, undefined, undefined, level.squarespawner1);

	attrib["suppressionwait"] = 0;
//	attrib["threatbias"] = 0;
	level thread maps\_respawner_gmi::random_respawner_setup("event9_allies_group1", undefined, attrib, undefined, undefined, undefined, level.squarespawner2);

	level thread Event9_Blow_Wall1();

	trigger = getent("event9_square","targetname");
	trigger waittill("trigger");

	level notify("stop_music1");
	// Start Tracking Flak gun missionfail stuff.
	

	tank3_start_node = getvehiclenode("event9_tank3_start","targetname");
	level thread Vehicle_Spawner("event9_tank3", tank3_start_node, 0, 1000, start_sound, 1, 0);

	level notify("objective 1 complete");

	// Wait until antonov is in position.
	while(level.antonov.current_spot != 3)
	{
		wait 0.25;
	}

	level thread Event9_Find_Antonov();
}

// Sets up the cars with vehicles clips so they can get ran over.
Setup_Event9_CarCrush()
{
	car = [];
	for(i=1;i<4;i++)
	{
		car[i] = getent("event9_carcrush_" + i,"targetname");

		// v_clip = vehicle_clip
		car[i].v_clip = getent(car[i].target,"targetname");

		if(i>1)
		{
//			car[i] notsolid();
			car[i].v_clip notsolid();
			car[i] hide();
			car[i].v_clip hide();
		}
	}

	trigger = getent("event9_carcrush_trigger","targetname");
	trigger.tank = [];
	num = 0;
	while(1)
	{
		trigger waittill("trigger",tank);

		valid = true;
		for(q=0;q<trigger.tank.size;q++)
		{
			if(trigger.tank[q] == tank)
			{
				valid = false;
			}
		}

		if(!valid)
		{
			continue;
		}

		trigger.tank[trigger.tank.size] = tank;
		num++;
		tank thread Event9_CarCrush(num);

		if(num == 2)
		{
			trigger delete();
			break;
		}
	}
}

// Starts when the tank is in position.
Event9_CarCrush(num)
{
	car = [];
	for(i=1;i<4;i++)
	{
		car[i] = getent("event9_carcrush_" + i,"targetname");
	}

	if(num == 1)
	{
		level thread maps\_utility_gmi::playSoundinSpace ("car_crush_01", car[1].origin);

		playfx(level._effect["carcrush"],car[2].origin);
		car[2] show();
	//	car[2] solid();
		car[2].v_clip show();
		car[2].v_clip solid();
	
		wait 0.05;
		car[1].v_clip delete();
		car[1] delete();
	}
	else
	{
	//	wait 0.5;
		level thread maps\_utility_gmi::playSoundinSpace ("car_crush_02", car[3].origin);	
		// Insert carcrush sound here!
		playfx(level._effect["carcrush"],car[3].origin);
	
		car[3] show();
	//	car[3] solid();
		car[3].v_clip show();
		car[3].v_clip solid();
	
		wait 0.05;
		car[2].v_clip delete();
		car[2] delete();
	}

	// Have the tanks start firing...
	fake_targets = getentarray("event9_allies_fake_targets","targetname");
	self Tank_Add_Targets(fake_targets);
	self thread Tank_Turret_Think(min_delay, max_delay, true);
}

// Tells both groups to move up to the Square.
Event9_Transition()
{
	level notify("T34s_go");

	if(getcvarint("sv_cheats") > 0 && getcvar("skipto_event9") == "1")
	{
		return;
	}

	level thread Event9_Antonov_Transition();

	wait 3;
	player_node = getnode("event9_chain1","targetname");
	level.player setfriendlychain(player_node);

	wait 3;
	group2_node = getnode("event9_group2_chain1","targetname");
	level.group2_commander setfriendlychain(group2_node);
	level.group2_commander setgoalnode(group2_node);

	level.he111_bomb_lod_dist = 4000;
}

Event9_Antonov_Transition()
{
	level.antonov pushPlayer(true);
	node = getnode("antonov_spot2b","targetname");
	level anim_reach_solo(level.antonov, "antonov_flank_right", tag, node, tag_entity);
	level.antonov anim_single_solo(level.antonov, "antonov_flank_right", undefined, node);
	level.antonov pushPlayer(false);
	level thread Antonov_Movement();
}

// This blows up the wall in the building just after the street.
Event9_Blow_Wall1()
{
	trigger = getent("event9_blow_wall1","targetname");
	trigger waittill("trigger");

	tank = getent("event9_tank1","targetname");
	target = getent("event9_building3_target","targetname");
//		    Tank_Fire_Turret(targetent, targetpos, start_delay, shot_delay, offset, validate, fake_fire)
	tank thread Tank_Fire_Turret(target, undefined, undefined, 0, undefined, false, true);

	tank waittill("hit_target");
	earthquake(1, 0.5, (level.player.origin + (0,512,0)), 1024);
	earthquake(0.4, 3, (level.player.origin + (0,512,0)), 1024);
	tank notify("start_random_turret_turning");

	miesha_node = getnode("event9_miesha_spot1","targetname");
	level.miesha setgoalnode(miesha_node);
	level.miesha.pacifist = true;
	level.miesha.pacifistwait = 0;
	level.miesha.ignoreme = true;
	level.miesha settakedamage(0);

	level.group2_commander notify("stop magic bullet shield");

	level.miesha waittill("goal");
	level.miesha.attached = false;
	level thread Event9_Miesha_Radio_Idle();
	level.miesha settakedamage(1);
}

// AFter the player enters square, he is ordered to find antonov.
Event9_Find_Antonov()
{
	trigger = getent("event9_find_antonov","targetname");
	trigger waittill("trigger");

	for(i=1;i<3;i++)
	{
		tank = getent("t34_" + i,"targetname");
		tank notify("stop_health_regen");
	}

	wait 1;

	maps\_utility_gmi::autosave(1);

	level notify("objective 2 complete");

	wait 1;
	level.antonov anim_single_solo(level.antonov,"event9_run1", undefined, level.antonov.assigned_node);

	level notify("objective 3 start");

//	level thread Event9_Player_DistTracker();
	level.antonov thread Event9_Antonov_Cover_Movement();
}

// Handles all of the movement, from the start of the square to Miesha.
Event9_Antonov_Cover_Movement()
{
	level.antonov endon("death");

//	level.player.threatbias = 0;
//	level thread Friendly_ThreatBias(-500);

	// Have everyone move up.
	node = getnode("event9_chain2","targetname");
	level.player setfriendlychain(node);

	// Remove the tank targets around the engineers path.
	targets = getentarray("event9_engineer_tank_targets","groupname");

	for(i=1;i<3;i++)
	{
		tank = getent(("event9_tank" + i),"targetname");
		for(n=0;n<targets.size;n++)
		{
			if(isdefined(tank) && isalive(tank))
			{
//				targets[n] thread do_print3d(undefined, targets[n].origin, "*", (1,0,0), 999999, 2);
				println("^5REMOVING TARGET! ", targets[n].groupname ," Tank: ",tank.targetname);
				tank Tank_Remove_Target(targets[n]);
			}
		}
	}

	// Check to see if Antonov dies.
	level thread Event9_Antonov_Life();
	level.antonov.goalradius = 32;

	level.antonov.oldinterval = level.antonov.interval;
	level.antonov.oldmaxsightdistsqrd = level.antonov.maxsightdistsqrd;
	level.antonov.oldpacifistwait = level.antonov.pacifistwait;
	level.antonov.interval = 0;
	level.antonov.pacifist = 1;
	level.antonov.pacifistwait = 0;
	level.antonov.maxsightdistsqrd = 0;
	level.antonov.dontavoidplayer = true;

	level.antonov Antonov_Movement(undefined, true, true);
	wait 1;
	level Event9_Dist_Check();

	level thread Event9_Blow_T34(1, 1);

	// Have t34_2 take out the far tank.
	t34_2 = getent("t34_2","targetname");
	target = getent("event9_tank2_target","targetname");
	tank1 = getent("event9_tank2","targetname");
	tank1.health = 100;
	t34_2 thread Tank_Fire_Turret(target, undefined, undefined, 3, undefined, false, true, "start_turret_think_random");

	// Guy_Spawner(name, name_type, count, delay, favoriteenemy)
	level thread Guy_Spawner("event9_ant_cover_group1","groupname", count, delay, level.antonov);

	// Manually set the turret to target Antonov.
	// Hack to manually have the MG42 target Antonov. I spawn a script_origin on antonov, then link it to him.
	// Then make the origin the .target of the turret.
	// Normally we just have the MG42 target the specified target.
	org_target = spawn("script_origin",(level.antonov.origin + (0,0,48)));
	org_target linkto(level.antonov);
	turret = getent("mg42_4","targetname");
	turret.target = "ant_org";
	org_target.targetname = "ant_org";
	turret.script_delay_min = 0.1;
	turret.script_delay_max = 0.2;
//	turret.manual_target = org_target;
	turret settargetentity(org_target);
	turret setmode("manual_ai"); // auto, auto_ai, manual


//	level thread ent_line(turret, org_target, (1,1,0), delay);

	wait 2;

	// ---------------- //
	// --- ANT_RUN2 --- //
	// ---------------- //	

	level.antonov.threatbias = 0;
// "Ready, let's move... Go!"
	level.antonov anim_single_solo(level.antonov,"event9_run2", undefined, level.antonov.assigned_node);

	level.antonov notify("stop magic bullet shield");
	level.antonov Antonov_Movement(undefined, true, true);
	//level.antonov.pacifist = false;
	level.antonov.threatbias = -200;
	//level.antonov.maxsightdistsqrd = 90000000;
	level thread Health_Regen(level.antonov, 400, 3, "stop_antonov_regen");

	wait 1;
	level Event9_Dist_Check();

	// Reset the turret.
	turret setmode("auto_ai"); // auto, auto_ai, manual
	turret.target = "blah";
//	turret.manual_target= undefined;
	org_target unlink();
//	org_target delete();
	level thread Event9_Blow_T34(2, 2);

	level thread Guy_Spawner("event9_ant_cover_group2","groupname", undefined, delay, level.antonov);

	wait 2;

	// ---------------- //
	// --- ANT_RUN3 --- //
	// ---------------- //	


	level.antonov notify("stop_anim");
// "Ok, you cover me while I run to that truck over there."
	level.antonov anim_single_solo(level.antonov,("event9_run3"));

	node = getnode("antonov_spot6a","targetname");
	level.antonov setgoalnode(node);
	level.antonov waittill("goal");

	if(distance(level.antonov.origin, level.player.origin) > 384)
	{
		println("^5PLAYER IS FAR AWAY... ANTONOV IS GOING TO COVER!");
		wait 1;
		level.antonov.suppressionwait = 0;
		level.antonov.ignoreme = true;
		level notify("stop_antonov_regen");
		level.antonov thread maps\_utility_gmi::magic_bullet_shield();
		level.antonov anim_single_solo(level.antonov,"event9_run4", undefined, node);
		level.antonov.ignoreme = false;
		level Event9_Dist_Check();
	}

	level.antonov Antonov_Movement(undefined, true, true);

	wait 1;
	level Event9_Dist_Check();

	wait 2;

	// ---------------- //
	// --- ANT_RUN4 --- //
	// ---------------- //	

	//level.antonov.pacifist = true;
	level.antonov.threatbias = -500;
	//level.antonov.maxsightdistsqrd = 3000;
	level notify("stop_antonov_regen");

// "We're almost there. Now we both go. On my signal... GO!!"
	level.antonov anim_single_solo(level.antonov,"event9_run5");

	// Stop the "forced damage" once he says his line.
	level notify("Event9_Player_DistTracker");

	level.antonov Antonov_Movement(undefined, true, true);


	level.antonov.interval = level.antonov.oldinterval;
	level.antonov.maxsightdistsqrd = 3000;
	level.antonov.pacifistwait = level.antonov.oldpacifistwait;
	//level.antonov.pacifist = 0;
	
	level.antonov thread maps\_utility_gmi::magic_bullet_shield();

	trigger = getent("event9_player_check","targetname");
	trigger waittill("trigger");

	maps\_utility_gmi::autosave(2);
	wait 1;

	// Spawns in the T34s
	for(i=1;i<3;i++)
	{
		path = getvehiclenode("event9_t34_" + i +"_start","targetname");
		if(i==1)
		{
			path.name_tank = true;
		}
		level thread Vehicle_Spawner("T34_noturret", path, 0, "regen", start_sound, 1, 0);
	}

	level notify("Stop_Star_Tracker");

	// Make sure the player is not ignored.
	level.player.ignoreme = false;
	// Make the player feel less threatened
	level.player.threatbias = -10;
	level thread Friendly_ThreatBias(0);

	// Turn off MGs on Enemy Tanks
	tank1 = getent("event9_tank1","targetname");
	tank1 thread maps\_tankgun_gmi::mgoff();

	// Not needed since there is none.
	tank3 = getent("event9_tank3","targetname");
	tank3 thread maps\_tankgun_gmi::mgoff();

	level thread Event9_Miesha_Radio();
	level thread Event9_Engineer_Spawn();
}

// Checks to see how far the player is from Antonov.
Event9_Dist_Check(dist)
{
	if(!isdefined(dist))
	{
		dist = 128;
	}

	while(distance(level.antonov.origin, level.player.origin) > dist)
	{
		wait 0.25;
	}

	return;
}

// Regens health for an entity.
Health_Regen(ent, max_health, rate, ender, health_mod)
{
	ent endon("death");

	if(isdefined(ender))
	{
		level endon(ender);
	}

	if(!isdefined(rate))
	{
		rate = 1;
	}

	if(!isdefined(health_mod))
	{
		health_mod = 15;
	}

	while(1)
	{
		if(ent.health < max_health)
		{
			ent.health += health_mod;

			if(ent.health > max_health)
			{
				ent.health = max_health;
			}
		}

		wait rate;
	}
}

// Checks to see if Antonov has died, if so, mission fails.
Event9_Antonov_Life()
{
	level.antonov waittill("death");

	if(level.flag["event11_started"])
	{
		return;
	}

	println("^1MISSION FAILED!!!");
	println("^1MISSION FAILED!!!");
	println("^1MISSION FAILED!!!");
	setCvar("ui_deadquote", "@GMI_KHARKOV2_MISSIONFAIL_ANTONOV");
	missionFailed();
}

// Blows up any event9_t34 upon demand.
Event9_Blow_T34(num, delay)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	target = getent("event9_t34_" + num + "_target","targetname");
	t34 = getent("t34_" + num,"targetname");
	t34 notify("stop_health_regen");
	wait 0.05;
	t34.health = 100;
	level.event9_tank3 thread Tank_Fire_Turret(target , undefined, undefined, 0, undefined, false, true);
}

// Puts the star on Antonov.
Event9_Star_Tracker()
{
	level.antonov endon("death");
	level endon("Stop_Star_Tracker");

	while(1)
	{
		objective_position(3, self.origin);
		wait 0.05;
	}
}

// Checks the player distance from Antonov.
// If the player it too far, we punish him.
Event9_Player_DistTracker()
{
	level.antonov endon("death");
	level endon("Event9_Player_DistTracker");

	if(!isdefined(level.cover_timer))
	{
		level.cover_timer = 0;
	}

	level thread Event9_Cover_Trigger_Setup();

	org[0] = (536, 5904, -156);
	org[1] = (816, 5976, -164);
	org[2] = (1712, 6096, -156);
	org[3] = (3008, 6568, 292);
	org[4] = (2253, 6280, -164);
	org[5] = (104, 4672, -24);

	while(1)
	{
		dist = distance(level.player.origin, level.antonov.origin);

		if(isdefined(level.player.using_cover))
		{
			println("^5level.player getstance(): ", (level.player getstance()));
			println("^5level.player.using_cover: ",level.player.using_cover);
			if(level.player getstance() == level.player.using_cover)
			{
				wait (0.05 + randomfloat(0.5));
				continue;
			}
			else if(level.player.using_cover == "crouch")
			{
				// Checking if the player is prone in a 'crouch' trigger.
				if(level.player getstance() == "prone")
				{
					wait (0.05 + randomfloat(0.5));
					continue;
				}
			}
			else if(level.player.using_cover == "stand")
			{
				// Checking if the player is crouch OR prone in a 'stand' trigger.
				if(level.player getstance() == "crouch" || level.player getstance() == "prone")
				{
					wait (0.05 + randomfloat(0.5));
					continue;
				}
			}

			if(level.player.using_cover == "super_cover")
			{
				level.player.ignoreme = true;
				wait (0.05 + randomfloat(0.5));
				continue;
			}
			else
			{
				level.player.ignoreme = false;
			}

			wait 3; // Lee way to getting hit again..
		}
		else
		{
			level.player.ignoreme = false;
		}

		if(dist > 256)
		{
			if(level.cover_timer > gettime())
			{
				wait 0.25;
				continue;
			}

			num = randomint(org.size);
			dmg = 10 + randomint(20);
			println("^1Damage: ",dmg," ^2Distance: ",dist);
			level.player doDamage ( dmg, org[num]);
		}

		wait (0.5 + randomfloat(2));
	}
}

// Grabs all of the triggers that provide the player with cover from
// the invisible bullets. :)
Event9_Cover_Trigger_Setup()
{
	triggers = getentarray("player_in_cover","targetname");

	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread Event9_Cover_Trigger_Think();
	}
}

// Think function for Event9_Cover_Trigger_Setup
// Waits until it's been triggered, then determines if the player is
// in the correct pose (stand, crouch, prone) before applying the hurt.
Event9_Cover_Trigger_Think()
{
	level thread Event9_Cover_Trigger_Think_Endon();
	level endon("Event9_Player_DistTracker");

	while(1)
	{
		self waittill("trigger");

		while(level.player istouching(self))
		{
			if(isdefined(self.script_noteworthy))
			{
				if(self.script_noteworthy == "crouch" || self.script_noteworthy == "prone" || self.script_noteworthy == "super_cover")
				{
					level.player.using_cover = self.script_noteworthy;
				}
				else
				{
					println("^3(Event9_Cover_Trigger_Think): TRIGGER WITH UNKNOWN SCRIPT_NOTEWORTHY!");
				}
			}
			else
			{
				// Assume it's a stand trigger
				level.player.using_cover = "stand";
			}
			wait 0.25;
		}

		level.cover_timer = gettime() + 3000;

		level.player.using_cover = undefined;
	}
}

// Resets the player.using_cover, once "Event9_Player_DistTracker"
// is notified... 
Event9_Cover_Trigger_Think_Endon()
{
	level waittill("Event9_Player_DistTracker");
	level.player.using_cover = undefined;
	level.player.ignoreme = false;
}


// Tells Miesha to use his Radio and call in for engineers.
Event9_Miesha_Radio()
{
	// Stop the T34s from smoking.
	stopattachedfx(getent("t34_1","targetname"));
	stopattachedfx(getent("t34_2","targetname"));

	level endon("no_more_engineers");

	level notify("objective 3 complete");
	num = 0;
	miesha_call_count = 0;
	cover_engineers = false;
	overall_count = 0;

	if(getcvarint("g_gameskill") >= 2)
	{
		total_count = 3;
	}
	else if(getcvarint("g_gameskill") == 1)
	{
		total_count = 5;
	}
	else if(getcvarint("g_gameskill") <= 0)
	{
		total_count = 9999; // Good luck on failing that.
	}

	while(1)
	{
//		level Event9_Antonov_Order_Miesha(num);
//		level.antonov anim_single_solo(level.antonov,("event9_engineers" + num));
//
//		num++;
//		if(num > 3)
//		{
//			// Yes reset to 1, so that it doesn't use the "radio now" V.O.
//			num = 1;
//		}

		if(miesha_call_count == 0)
		{
			level.antonov anim_single_solo(level.antonov,"ant_radio_now");

			level.miesha anim_single_solo(level.miesha, "miesha_yes_sergeant");
			dialogue = "miesha_need_engineers";
			miesha_call_count++;
		}
		else if(miesha_call_count == 1)
		{
			level.antonov anim_single_solo(level.antonov,"antonov_dammit");
			wait 1;
			level.antonov anim_single_solo(level.antonov,"antonov_miesha");
			
			level.miesha anim_single_solo(level.miesha, "miesha_iknow");
			dialogue = "miesha_doingbest";
			miesha_call_count++;
		}
		else if(miesha_call_count == 2)
		{
			level.antonov anim_single_solo(level.antonov,"antonov_another");
			
			dialogue = "miesha_sendanother";
			miesha_call_count++;
		}
		else
		{
			ant_dialogue = Event9_Antonov_Random_Dialogue();
			println("^6Ant_Dialogue: ",ant_dialogue);
			level.antonov anim_single_solo(level.antonov,ant_dialogue);

			if(ant_dialogue == "antonov_miesha")
			{
				level.miesha anim_single_solo(level.miesha, "miesha_iknow");
			}
			

			dialogue = "miesha_need_engineers";
		}
		// Yes reset to 1, since we don't want 0 to play again.
		if(miesha_call_count > 4)
		{
			miesha_call_count = 1;
		}

		overall_count++;
		if(overall_count > total_count)
		{
			println("^1MISSION FAILED!!!");
			println("^1MISSION FAILED!!!");
			println("^1MISSION FAILED!!!");
			setCvar("ui_deadquote", "@GMI_KHARKOV2_MISSIONFAIL_ENGINEER");			
			missionFailed();
			return;
		}

		println("^6CALLING IN FOR ENGINEERS!");
		level thread Event9_Miesha_Radio_Call(dialogue);
		level.miesha waittill("done_calling_engineer");

		wait 1;

		level notify("respawn_engineers");
	

		if(!cover_engineers)
		{ 
			cover_engineers = true;
			level.antonov anim_single_solo(level.antonov,"ant_cover_engineers");
		}

		level waittill("miesha_radio_engineers");
	}
}

Event9_Antonov_Random_Dialogue()
{
	dialogue[0] = "ant_engineers1";
	dialogue[1] = "ant_engineers2";
	dialogue[2] = "ant_engineers3";
	dialogue[3] = "antonov_another";
	dialogue[4] = "antonov_miesha";

	num = randomint(dialogue.size);
	return dialogue[num];
}

// Taken from Kharkov1, this puts Miesha in his Radio idle animation.
Event9_Miesha_Radio_Idle()
{
	level endon("no_more_engineers");

	level.miesha.og_goalradius = level.miesha.goalradius;
	level.miesha.goalradius = 128;
	level.miesha.ignoreme = true;
	level.miesha.pacifist = true;
	level.miesha.og_dontavoidplayer = level.miesha.dontavoidplayer;
	level.miesha.dontavoidplayer = true;
	level.miesha.hasweapon = false;
	
	level.miesha allowedstances("crouch");

	wait 1;

	level.miesha thread anim_single_solo(level.miesha, "radio_trans_in", undefined, node);
	
	// Spawn in the receiver.
	level.miesha waittillmatch("single anim","attach");

//	left_hand_tag = level.miesha gettagorigin("TAG_WEAPON_LEFT");
//	level.miesha.receiver = spawn("script_model",(left_hand_tag));
//	level.miesha.receiver setmodel("xmodel/kharkov1_receiver");
//	level.miesha.receiver linkto(level.miesha, "TAG_WEAPON_LEFT", (0,0,0), (0,0,0));
	
	if(!level.miesha.attached)
	{
		level.miesha.attached = true;
		level.miesha attach("xmodel/kharkov1_receiver", "TAG_WEAPON_LEFT");
	}

	level.miesha waittill("radio_trans_in");

	// For some reason Miesha does not turn his head. Have programmer investigate.
	// Works fine in test map, but no in kharkov1.
	level.miesha thread anim_loop_solo(level.miesha, "radio_wait", undefined, "stop_anim", node);
	wait 0.1;
	level.miesha thread animscripts\shared::lookatentity(level.antonov, 10000000, "casual");

	return;
}

// Tells miesha to call for more engineers.
Event9_Miesha_Radio_Call(dialogue)
{

	level.miesha thread animscripts\look::finishLookAt();
	level.miesha notify("stop_anim");
	level.miesha anim_single_solo(level.miesha, "radio_trans_to_talk");

	level.miesha thread anim_loop_solo(level.miesha, "radio_talk_1", undefined, "stop_anim", node);

	// Testing, right now the radio_talk is a loop, So to hear the sound without
	// skipping has to be done manually.
//	level.miesha playsound(("miesha_firemission0" + num), "dialogue_done", false);

//	level.miesha playsound(dialogue, "dialogue_done", false);
	level.miesha thread animscripts\face::SaySpecificDialogue(level.scr_face["miesha"][dialogue], dialogue, 1.0, "done_calling_engineer");
	level.miesha waittill("done_calling_engineer");
	wait 4;
	level.miesha notify("stop_anim");
	level.miesha thread anim_single_solo(level.miesha, "radio_trans_out");

	level thread Event9_Miesha_Radio_Idle();
	return;
}

// Spawns in the engineers.
// Also controls the difficulty.
// The longer the player takes to help them across,
// the easier it will get.
Event9_Engineer_Spawn()
{
	if(!isdefined(level.engineer_count))
	{
		level.engineer_count = 2;
	}

	if(!isdefined(level.engineer_alive))
	{
		level.engineer_alive = 0;
	}

	spawners = getentarray("event9_engineers","groupname");

	respawn_counter = 0;
	while(1)
	{
		level waittill("respawn_engineers");

		respawn_counter++;
		level.engineer_counter = respawn_counter;

		if(respawn_counter == 3)
		{
			level.engineer_count = 3;
		}

		num = 0;
		while(level.engineer_alive < level.engineer_count)
		{
			spawners[num].count = 1;

			spawned = spawners[num] dospawn();
			if(isdefined(spawned))
			{
				num++;

				if(num > spawners.size)
				{
					num = 0;
				}

				spawned waittill("finished spawning");

				// Setup the character Model
				spawned character\_utility::new();
				spawned character\RussianArmyEngineer::main();

				level.engineer_alive++;
				spawned.animname = "engineer";
				spawned.targetname = "engineer";
//				spawned.pacifist = true;
//				spawned.pacifistwait = 0;
				spawned.suppressionwait = 0;
				
				spawned.threatbias = (-200 * respawn_counter);

				spawned.health = (140 + (75 * respawn_counter));

				spawned.the_e = true;
				spawned attach("xmodel/o_engineer_icon","TAG_HELMET");

				spawned thread Event9_Engineer_Death_Think();
//				level thread do_print3d(spawned, pos, "E", (0,0,1), 999999, 2);
			}
		}

		level thread Event9_Engineer_Movement();
	}
}

// Keeps track of how many engineers are alive.
Event9_Engineer_Death_Think()
{
	self waittill("death");

	if(isdefined(self.the_e) && self.the_e)
	{
		self detach("xmodel/o_engineer_icon","TAG_HELMET");
	}

	level.engineer_alive--;

	println("^2Engineer Died, level.engineer_alive = ",level.engineer_alive);

	if(level.engineer_alive == 0)
	{
		level thread Clean_Up_By_Death(groupname, "engineer_killer", 3, initial_delay, wait_till);
		level notify("miesha_radio_engineers");
	}
}

// Like Antonov's movement, this controls the movement
// for the engineers.
Event9_Engineer_Movement()
{
	level endon("miesha_radio_engineers");
	level endon("stop_engineer_movement");

	num = 0;
	group_num = 0;
	while(1)
	{
		num++;
		node = getnodearray("event9_engineer_spot" + num, "targetname");

		engineers = getentarray("engineer","targetname");
		for(i=0;i<engineers.size;i++)
		{
			if(!isalive(engineers[i]))
			{
				continue;
			}

			engineers[i].pacifist = true;
			engineers[i].goalradius = 64;
			engineers[i].assigned_spot = num;

			if(!isdefined(engineers[i].current_spot))
			{
				engineers[i].current_spot = 0;
			}

			engineers[i] setgoalnode(node[i]);
			engineers[i] thread Event9_Engineer_Movement_Think();
		}

		if(num < 5)
		{
			group_num = num;
			if(num > 2)
			{
				group_num = num - 1;
			}
			level thread Event9_Engineer_Enemy_Spawner(group_num, 1, num);
		}

		level waittill("engineers_move_up");
		wait 0.1;
	}
}

// Used with Event9_Engineer_Movement()
Event9_Engineer_Movement_Think()
{
	level endon("engineers_move_up");
	level endon("stop_engineer_movement_think");
	self endon("death");
	self waittill("goal");

	self.pacifist = false;
	self.current_spot = self.assigned_spot;
	made_it = false;
	while(1)
	{
		engineers = getentarray("engineer","targetname");
		total_engineers = 0;
		engineers_at_spot = 0;
		for(i=0;i<engineers.size;i++)
		{
			if(isalive(engineers[i]))
			{
				total_engineers++;
	
				if(engineers[i].current_spot == self.current_spot)
				{
					engineers_at_spot++;
				}
			}
		}

		println("^5total_engineers: ",total_engineers, " ^5engineers_at_spot: ", engineers_at_spot);

		if(total_engineers == engineers_at_spot)
		{
			println("^5ENGINEERS ARE READY!!");
			wait 3;

			if(self.current_spot == 5)
			{
				println("^5MADE IT TO DESTINATION, READY TO BLOW IT UP!");
				level notify("stop_engineer_movement_think");
				level notify("no_more_engineers");
				// Tells Miesha to put down the radio.
				level.miesha notify("stop_anim");
				level.miesha.hasweapon = true;
				self Event9_Plant_Bomb();
				level thread Event9_Blow_Trolleys();

				level thread Event9_Engineer_Complete();

				engineers = getentarray("engineer","targetname");
				nodes = getnodearray("event9_engineer_spot6", "targetname");
				for(i=0;i<engineers.size;i++)
				{
					if(isalive(engineers[i]))
					{
						engineers[i] setgoalnode(nodes[i]);
					}
				}
				made_it = true;
			}
			else
			{
				println("^2ENGINEERS_MOVE_UP!!!");
				level notify("engineers_move_up");
			}
			break;
			
		}
		wait 0.5;
	}

	if(made_it)
	{
		level thread Clean_Up_By_Death(groupname, "engineer", 5, 5);
	}
}

Event9_Engineer_Complete()
{
	if(level.engineer_counter == 1)
	{
		level.antonov thread anim_single_solo(level.antonov,"good_shooting");
	}
	else
	{
		level.miesha anim_single_solo(level.miesha,"miesha_finally");
		level.antonov anim_single_solo(level.antonov,"antonov_stop_chatter");
	}
}

// Spawns in the guys to attack the Engineers.
Event9_Engineer_Enemy_Spawner(num, count, spot_num)
{
	spawners = getentarray("event9_eng_enemy_group" + num,"groupname");

	if(!isdefined(spawners) || spawners.size == 0)
	{
		println("^1(Event9_Engineer_Enemy_Spawner): NO SPAWNERS FOUND WITH A ", name_type, " ^1 OF ", name);
		return;
	}

	for(i=0;i<spawners.size;i++)
	{
		// This is to make it a bit easier.
		if(getcvarint("g_gameskill") < 3)
		{
			if(i>0)
			{
				continue;
			}
		}

		// Overrides the Count on the spawner.
		if(isdefined(count))
		{
			spawners[i].count = count;
		}

		// Spawn the AI
		if(isdefined(spawners[i].script_stalingradspawn) && spawners[i].script_stalingradspawn)
		{	
			spawned = spawners[i] stalingradSpawn();
			spawned waittill("finished spawning");
		}
		else
		{
			spawned = spawners[i] dospawn();
			spawned waittill("finished spawning");
		}

		spawned.groupname = "engineer_killer_group" + num;
		spawned.targetname = "engineer_killer";
		spawned thread Event9_Engineer_Enemy_Movement(spot_num);
		spawned thread Event9_Engineer_Enemy_Favorite();
	}
}

// Movement for the engineer killers. 
Event9_Engineer_Enemy_Movement(spot_num)
{
	self endon("death");

//	self.pacifist = 1;
	self.suppressionwait = 0;

	if(spot_num == 4)
	{
		self.goalradius = 128 + randomint(128);		
	}
	else
	{
		self.goalradius = 384 + randomint(128);
	}

	if(spot_num == 4)
	{
		node = getnode("event9_eng_enemy_group3_spot","targetname");
		self setgoalnode(node);
	}
	else
	{
		node = getnodearray("event9_engineer_spot" + spot_num,"targetname");
		self setgoalnode(node[0]);
	}

	self waittill("goal");
	self.pacifist = 0;
	self.suppressionwait = 0.5;
}

// Assigns the Favoriteenemy to the Engineer Killer.
// Since there a multiple engineers, just grab the assign the first guy
// if the first guy dies, assign another guy.
Event9_Engineer_Enemy_Favorite()
{
	self endon("death");

	while(1)
	{
		engineers = getentarray("engineer","targetname");
	
		if(!isdefined(engineers) || engineers.size == 0)
		{
			break;
		}
	
		for(i=0;i<engineers.size;i++)
		{
			if(isalive(engineers[i]))
			{
				self.favoriteenemy = engineers[i];
			}
		}

		self.favoriteenemy waittill("death");
	}
}

// Plays the bomb plant animation for the engineer.
Event9_Plant_Bomb()
{
	self settakedamage(0);
	self.ignoreme = true;
	node = getnode("event9_plant_bomb","targetname");

//	kick_guy[0] = level.vassili;

	self pushPlayer (true);

	anim_reach_solo(self, "plant_bomb", undefined, node);
	self pushPlayer (false);

	level thread anim_single_solo(self, "plant_bomb", undefined, node);

	self waittillmatch ("single anim", "end");
	self settakedamage(1);

	return;
}

// Blows up the trolley cars.
Event9_Blow_Trolleys()
{
	level notify("objective 4 complete");

	level thread Event9_Friendly_Flak_Fire_Fail();

	maps\_utility_gmi::autosave(3);

	level thread Clean_Up_By_Death(groupname, "engineer_killer", 7, initial_delay, wait_till);

	eng_nodes = getnodearray("event9_engineer_spot4","targetname");
	level.miesha setgoalnode(eng_nodes[0]);
	if(isdefined(level.miesha.attached) && level.miesha.attached)
	{
		level.miesha.attached = false;
		level.miesha detach("xmodel/kharkov1_receiver", "TAG_WEAPON_LEFT");
	}

//	level.miesha.receiver delete();
	level.antonov setgoalnode(eng_nodes[1]);

	level thread Axis_Retreat("event9_retreat_point", 0.25, 1);

	for(i=5;i>0;i--)
	{
		println(i);
		wait 1;
	}

	trolley[0] = getent("event9_trolley1_vehicle","targetname");
	trolley_model[0] = getent("event9_trolley1_model","targetname");
	trolley_model_clip[0] = getent("event9_trolley1_model_clip","targetname");

	trolley[1] = getent("event9_trolley2_vehicle","targetname");
	trolley_model[1] = getent("event9_trolley2_model","targetname");
	trolley_model_clip[1] = getent("event9_trolley2_model_clip","targetname");

	targetent = getent("event9_trolley_explosion","targetname");

	getent("barrels_delete1","targetname") delete();
	getent("barrels_delete2","targetname") delete();
	
	org = getent (targetent.target,"targetname");
	org playsound("explo_metal_rand");
	level thread maps\_fx_gmi::OneShotfx(targetent.script_fxid, targetent.origin, 0, org.origin);

	trolley_clip = getent("trolley_clip","targetname");
	trolley_clip delete();

	tag_model = spawn("script_model",(0,0,0));
	tag_model setmodel("xmodel/kharkov2_trolly_exp");
	tag_model hide();

	for(i=0;i<2;i++)
	{
		trolley[i] delete();
	}

	level thread Event9_Trolley_Explosion(tag_model, trolley_model, trolley_model_clip);

	// Setup Anti-Air Gun in square.
	anti_air = getent("event9_anti_air","targetname");
	anti_air maps\_flakvierling_gmi::init(12000);
	anti_air.health = 20000;
	anti_air thread anti_air_regen();

	level thread maps\_respawner_gmi::respawner_stop("event9_axis_group1");
	
	level.amount_of_ai["event9_allies_group1"] = 5;
	level thread Event9_Allies_Advance();

	// Setup Triggers for Event10_Transition.
	trigger1 = getent("event10_respawner","script_noteworthy");
	trigger1 thread maps\_utility_gmi::TriggerOff();
	trigger2 = getent("event10_fight_1","script_noteworthy");
	trigger2 thread maps\_utility_gmi::TriggerOff();
}

// Animates the Trolleys, when they explode.
Event9_Trolley_Explosion(tag_model, trolley_model, trolley_model_clip)
{
	for(i=0;i<trolley_model.size;i++)
	{
		trolley_model_clip[i].origin = trolley_model[i].origin;
		trolley_model_clip[i].angles = trolley_model[i].angles;
		trolley_model_clip[i] linkto(trolley_model[i], "" ,(0,0,0), (0,0,0));
		trolley_model[i] linkto(tag_model, trolley_model[i].script_noteworthy, (0,0,0),( trolley_model[i].angles));
		trolley_model[i] thread Event9_Trolley_Model_Sound();
		level thread Falling_Debris_Damage_Think(trolley_model[i], 300, 300, 100, "trolley_stop_damage");
	}

	tag_model.animname = "trolleys";
	tag_model UseAnimTree(level.scr_animtree["kharkov2_debris"]);
	tag_model animscripted("single anim", tag_model.origin, tag_model.angles, level.scr_anim[tag_model.animname]["reactor"]);
	tag_model waittillmatch("single anim","end");
	level notify("trolley_stop_damage");

	for(i=0;i<trolley_model.size;i++)
	{
		trolley_model[i] unlink();
		trolley_model[i] thread Event9_Trolley_Damage_Think2();
	}

	tag_model delete();
}

Event9_Trolley_Model_Sound()
{
	if (self.targetname == "event9_trolley1_model")
	{
		wait 1.8;
		println("^1Playingsound now #1");
		self playsound("vehicle_impact");
	}
	else if (self.targetname == "event9_trolley2_model")
	{
		wait 1.75;
		println("^2Playingsound now #2");
		self playsound("vehicle_impact");
	}
}

Event9_Trolley_Damage_Think2()
{
	while(distance(level.player.origin, self.origin) < 224)
	{
		radiusDamage (self.origin, 224, 500, 15);
		wait 0.1;
	}
}

// Tells all of the living allies to advance into the square.
Event9_Allies_Advance()
{
	setCullFog (100, 30000, 0.34, 0.36, 0.36, 20 );

	// To compensate for new Sky (me no likey).
//	setCullFog (100, 30000, 0.035, 0.078, 0.078, 0 ); 
	allies = getentarray("event9_allies_group1","groupname");

	relay_node = getnode("event9_spawner_trans14","targetname");
//	spawner_nodes = getnodearray("event9_spawner_trans","targetname");

	allies_num = 0;
	spawner_num = 1;
	for(i=0;i<allies.size;i++)
	{
		if(issentient(allies[i]))
		{
			allies[i] setgoalnode(relay_node);
			allies[i] thread Event9_Allies_Avoid_Tank();
			allies_num++;
		}
		else // Assume it's a spawner
		{
			println("^2allies[i].target = ",allies[i].target);
			allies[i].target = "event9_spawner_trans14";
			spawner_num++;
		}
	}

	level thread Event9_Allies_Advance_Think();

	// Now we get allies_group1 and have them move up.
	node = getnode("event10_chain1","targetname");
	level.player setfriendlychain(node);

	other_friendlies = getentarray("allies_group1","groupname");
	all = add_array_to_array(other_friendlies, level.friends);
	for(i=0;i<all.size;i++)
	{
		if(isalive(all[i]))
		{
			all[i].goalradius = 32;
			all[i].script_uniquename = "friendlychain_ai";
			all[i] setgoalentity(level.player);
		}
	}

	wait 1;

	// Have antonov move.
	ant_node = getnode("event9_antonov_adv_spot0","targetname");
	level.antonov setgoalnode(ant_node);
	level thread Event9_Delay_T34(5);

	level.antonov waittill("goal");

	ant_node = getnode("event9_antonov_adv_spot","targetname");
	level.antonov setgoalnode(ant_node);
	level.antonov waittill("goal");

	dist = distance(level.player.origin, level.antonov.origin);
	while(dist > 512)
	{
		wait 0.5;
		dist = distance(level.player.origin, level.antonov.origin);
	}

	level notify("objective 5 complete");
	wait 1;
	level thread maps\_respawner_gmi::respawner_stop("event9_allies_group1");

	level.antonov anim_single_solo(level.antonov, "ant_get_moving", undefined, ant_node);
	level.player.threatbias = 0;

//	wait 1;

	node = getnode("event9_miesha_bomber_spot","targetname");
	level.miesha anim_reach_solo(level.miesha, "miesha_bombers", undefined, node);
	level.miesha anim_single_solo(level.miesha, "miesha_bombers");


	level thread Event9_He111();

	chain_node = getnode("event10_chain2","targetname");
	level.player setfriendlychain(chain_node);

	cover_nodes = getnodearray("event9_cover_spots","targetname");
	
	allies = getentarray("event9_allies_group1","groupname");

	n = 0;
	for(i=0;i<allies.size;i++)
	{
		if(!issentient(allies[i]))
		{
			continue;
		}

		if(isdefined(allies[i].script_uniquename) && allies[i].script_uniquename == "friendlychain_ai")
		{
			continue;
		}

		if(isdefined(allies[i].targetname) && allies[i].targetname == "antonov")
		{
			continue;
		}

		allies[i] setgoalnode(cover_nodes[n]);
		n++;
	}

	level thread Antonov_Movement();
}

Event9_Allies_Avoid_Tank()
{
	level endon ("objective 6 start");
	self endon("death");
	self endon("goal");
	
	relay_node = getnode("event9_spawner_trans14","targetname");
	t34s = getentarray("event9_t34","targetname");
	t34s_shooters = getentarray("event9_t34_shooter","targetname");
	
	for (i=0;i<t34s_shooters.size;i++)
	{
		t34s[t34s.size] = t34s_shooters[i];
	}
	
	while (1)
	{
		for (i=0;i<t34s.size;i++)
		{	
			if (distance(self.origin,t34s[i].origin) < 256)
			{
				self setgoalpos(self.origin);
				wait 0.5;
				self setgoalnode(relay_node);
			}
		}
	
		wait 0.2;
	}
	
}

Event9_Delay_T34(delay)
{
	wait delay;
	level notify("T34s_go");
}

Event9_Allies_Advance_Think()
{
	trigger = getent("event9_trans_objective","targetname");
	
	num = 1;
	while(num < 16)
	{
		trigger waittill("trigger", guy);

		if(isdefined(guy.event9_advance))
		{
			continue;
		}

		if(isdefined(guy.script_uniquename) && guy.script_uniquename == "friendlychain_ai")
		{
			continue;
		}

		if(isdefined(guy.targetname) && guy.targetname == "antonov")
		{
			continue;
		}

		node = getnode("event9_spawner_trans" + num, "targetname");

		guy.event9_advance = true;
		guy.goalradius = 32;
		guy setgoalnode(node);

		num++;
	}
}

// Spawns in the 3 waves of He111s. Also sets up the anti_air gun
// Also figures out the time to give the player to get to the
// anti_air gun.
Event9_He111()
{
// TEMP!
//	level notify("objective 1 complete");
//	wait 0.25;
//	level notify("objective 2 start");
//	wait 0.25;
//	level notify("objective 2 complete");
//	wait 0.25;
//	level notify("objective 3 start");
//	wait 0.25;
//	level notify("objective 3 complete");
//	wait 0.25;
//	level notify("objective 4 complete");

	// Keep the player on the flak once they've used it.
	level thread Event9_Keep_Player_on_Flak();

	waves = 3;
	num = 3; // # of planes per wave.
	level.event9_he111_total = num * waves;

	level notify("objective 6 start");

	node = getnode("event9_vassili_flak_spot","targetname");
	level.vassili anim_reach_solo(level.vassili, "vassili_flak", undefined, node);
	level.vassili anim_single_solo(level.vassili,"vassili_flak");
	
	anti_air = getent("event9_anti_air","targetname");
	dist = distance(level.player.origin, anti_air.origin);

	// Sly way of getting the approximate time for the player to get to the anti_air
	// Checks the distance between the player and the anti-air gun.
	// Then divides the distance by the player speed, but a bit slower, 125. 
	// Which is the new time.

	timer = (int)(dist/125);
	for(i=timer;i>0;i--)
	{
		println("^2Timer = ",i);
		wait 1;
	}


	he111_nodes = getvehiclenodearray("event9_he111_start","targetname");
	random_num = -1;
	level.event9_he111_wave = 0;

	sound_list = [];
	sound_list[0] = "bomber_loop_01";
	sound_list[1] = "bomber_loop_02";
	sound_list[2] = "bomber_loop_03";

	delay = 4;
	inc_delay = (float)delay/(float)waves;

	for(n=0;n<waves;n++)
	{
//		if(n > 0)
//		{
//			num++;
//		}

		if(n == 1)
		{
			if (isalive(level.player))
			{
				level.antonov thread anim_single_solo(level.antonov, "antonov_yes");
			}
		}

		level.event9_he111_wave++;
		for(i=0;i<num;i++)
		{
			old_num[i] = random_num;

			while(1)
			{
				random_num = randomint(he111_nodes.size);
				
				valid = true;
				for(q=0;q<old_num.size;q++)
				{
					if(old_num[q] == random_num)
					{
						valid = false;
					}
				}

				if(valid)
				{
					break;
				}

				wait 0.05;
			}

			start_sound = undefined;
			if(i == 0 || i == 2 || i == 4)
			{
				start_sound = sound_list[randomint(sound_list.size)];
			}

			if(n == 0 && i == 0)
			{
				for(q=0;q<he111_nodes.size;q++)
				{
					if(isdefined(he111_nodes[q].script_noteworthy) && he111_nodes[q].script_noteworthy == "first_bomber")
					{
						node = he111_nodes[q];
					}
				}
				level thread Vehicle_Spawner("event9_he111", node, 0, 3000, start_sound, 1, 0, ("he111_wave" + level.event9_he111_wave + "_leader"));
				level thread Event9_Bomb_Statue();
			}
			else if(i == (num - 1))
			{
				println("^1I = ",i," ^1event9_he111_tracker");
//					     Vehicle_Spawner(type,                    start_node,          delay, health, start_sound, vehicle_num, spawn_delay, squad_name)
				level thread Vehicle_Spawner("event9_he111_tracker", he111_nodes[random_num], 0, 2000, start_sound, 1, 0, ("he111_wave" + level.event9_he111_wave + "_tracker"));
			}
			else
			{
				println("^1I = ",i," ^2event9_he111");
				if(i == 0)
				{
					level thread Vehicle_Spawner("event9_he111", he111_nodes[random_num], 0, 2000, start_sound, 1, 0, ("he111_wave" + level.event9_he111_wave + "_leader"));
				}
				else
				{
					level thread Vehicle_Spawner("event9_he111", he111_nodes[random_num], 0, 2000, start_sound, 1, 0);
				}
				
			}
			
			wait delay;
//			wait (1 + randomfloat(0.5));
		}
		delay -= inc_delay;

		level thread Event9_He111_Rumble();

		for(i=15;i>0;i--)
		{
			println(i);
			wait 1;
		}
	}
}

// This controls the Rumble sound for when the planes get
// near the player.
Event9_He111_Rumble()
{
	lead_plane = getent("he111_wave" + level.event9_he111_wave + "_leader","targetname");
	end_plane = getent("he111_wave" + level.event9_he111_wave + "_tracker_origin","targetname");

	rumble_sound_high = "bomber_rumble_high";
	rumble_sound_low = "bomber_rumble_low";

	sound_blend = spawn("sound_blend",(0,0,0));

	blend_amount = 0.1;
	
	while(isalive(lead_plane))
	{
//		line(lead_plane.origin, end_plane.origin, (1,1,0));
		array = [];
		for(i=0;i<3;i++)
		{
			array[i] = (lead_plane.origin[i] - end_plane.origin[i]) / 2;
			array[i] = lead_plane.origin[i] - array[i];
		}
		half_way = (array[0], array[1], array[2]);
		dest_origin = (half_way[0], level.player.origin[1], level.player.origin[2]);

		sound_blend.origin = dest_origin;
		
		dist = distance(sound_blend.origin, level.player.origin);

		if(dist < 10000)
		{
			if(dist < 1000)
			{
				quake = 0.20;
			}
			else
			{
				quake = (0.20 / (dist * 0.001));
			}
//			println("Quake = ",quake);
			earthquake(quake, 0.5, level.player.origin, 1024);
		}

		if(dist < 4000)
		{
			blend_amount = 1;
		}
		else
		{
			blend_amount = 4000/dist;
		}
//		println("Blend Amount = ",blend_amount);
		sound_blend setSoundBlend(rumble_sound_low, rumble_sound_high, blend_amount);

//		line(level.player.origin, sound_blend.origin, (1,1,1));
		wait 0.25;
	}

	while(blend_amount > 0)
	{
		sound_blend setSoundBlend(rumble_sound_low, rumble_sound_high, blend_amount);
		blend_amount -= 0.01;
		wait 0.1;
	}
	sound_blend setSoundBlend(rumble_sound_low, rumble_sound_high, 0);
	wait 1;
	sound_blend delete();
}

// The He111s controlled Sound.
// Since I can't play a loop sound off a vehicle,
// I must hack it in with a script_origin dangling below each 
// plane. :)
Event9_He111_Sound(plane, sound)
{
	sound_high = sound + "_high";

	org = spawn("script_origin", (plane.origin[0],plane.origin[1],(plane.origin[2] - 256)));
	org linkto(plane);
	org playLoopSound(sound_high);
	plane.org_sound = org;
	plane.org_sound.sound = sound_high;
	
//	org setSoundBlend(sound_low, sound_high, 1);

	plane waittill("reached_end_node");
	org unlink();

//	org setSoundBlend(sound_high, sound_low, 1);

	org stopLoopSound();
	org delete();
}

//
Event9_Bomb_Sound()
{
	if(!isdefined(level.event9_he111_check))
	{
		level.event9_he111_check = 1;
	}

	if(level.event9_he111_wave == level.event9_he111_check)
	{
		level.event9_he111_check++;
		org = spawn("script_origin",level.player.origin);
		org playsound("bombs_away_01");

		// added 2nd wave sounds - SG
		wait 4;
		org playsound("bombs_away_01a", "sounddone");
		// - SG

		org waittill("sounddone");
		org delete();
	}
}

// Instead of adding code, I just play the FX manually when the play gets hit.
Event9_He111_Damage_Think()
{
	self endon("death");

	while(1)
	{
		anti_air = getent("event9_anti_air","targetname");
	
		self waittill("damage", dmg, attacker, dir, point, mod);
//		dist = distance(self.origin,level.player.origin);
//		println("^2He111 Damaged! Dist: ",dist);
		if(attacker != anti_air)
		{
			self.health += dmg;
			continue;
		}

		playfx ( level._effect["he111_impact"], point );
	}
}

// Checks to see if the anti_air gun shot down the plane.
// If so, then chalk one up for the player.
Event9_He111_Death_Think()
{
	anti_air = getent("event9_anti_air","targetname");

	self waittill("death", attacker);
	println("^2He111 Down! By: ", attacker.targetname);

	if(attacker != level.player && attacker != anti_air)
	{
		return;
	}

	println("^2He111 Confirmed!");
	level.event9_he111_count++;

	level.event9_he111_total--;
	objective_string(6, &"GMI_KHARKOV2_OBJECTIVE6", level.event9_he111_total);

//	if(level.event9_he111_count == 6)
//	{
//		println("START NEXT EVENT!!!");
//	}
}

// The last He111 that spawns in out of the wave runs this function.
// If the X pos is greater than the player's X pos, he will die,
// Unless the player kills the right amount of planes during that
// wave.
Event9_He111_Pos_Tracker(plane)
{
	org = spawn("script_origin",plane.origin);

	org.targetname = "he111_wave" + level.event9_he111_wave + "_tracker_origin";

	speed = 75 * 17.6; // Adjust this if differs from editor.
	time = 39296 / speed;

	org moveto((plane.origin + (39296, 0, 0)), time, 0, 0);
	event9_he111_wave = level.event9_he111_wave;
//	level thread do_print3d(self, pos, "*", (1,0,0), 5000, 10);
	while(org.origin[0] < level.player.origin[0])
	{
//		println("^5self.origin[0]: ",self.origin[0]," ^5level.player.origin[0]: ", level.player.origin[0]);
//		dist = distance(self.origin,level.player.origin);
//		println("^5Plane Dist: ",dist);
		wait 0.25;
	}

	println("^5event9_he111_wave = ",event9_he111_wave, " ^5level.event9_he111_count = ", level.event9_he111_count);
	if(event9_he111_wave == 1)
	{
		if(level.event9_he111_count < 3)
		{
			level thread Event9_Bomb_player();
		}
	}
	else if(event9_he111_wave == 2)	
	{
		if(level.event9_he111_count < 3)
		{
			level thread Event9_Bomb_player();			
		}
	}
	else if(event9_he111_wave == 3)
	{
		if(level.event9_he111_count < 3)
		{
			level thread Event9_Bomb_player();			
		}
		else
		{
			level thread Event10_Transition();
		}
	}

	level.event9_he111_count = 0;
}

// Kill the player by a fake bomb.
Event9_Bomb_player()
{
	println("^1BOMB THE PLAYER!!!");
	anti_air = getent("event9_anti_air","targetname");
	forward = anglestoforward(level.player.angles);
	vec = level.player.origin + maps\_utility_gmi::vectorScale(forward, 256);
	
	org = spawn("script_origin",vec);
	println("Org = ",org.origin);
//	org thread do_print3d(org, pos, "*", (1,0,0), 5000, 2);
	playfx ( level.he111_bomb, org.origin );
	earthquake(0.5, 2, org.origin, 1024);
	radiusDamage (org.origin, 1024, (anti_air.health + 1000), anti_air.health);
	level.player dodamage((level.player.health + 5000), org.origin);
}

Event9_Statue_Setup()
{
	precachemodel("xmodel/o_rs_prp_leninstatue_arm"); //tag_arm
	precachemodel("xmodel/o_rs_prp_leninstatue_head"); // tag_head
	precachemodel("xmodel/o_rs_prp_leninstatue_torso"); // tag_torso
	precachemodel("xmodel/o_rs_prp_leninstatue_legs"); // tag_legs
	precachemodel("xmodel/kharkov2_lenin_statue");

	level.event9_statue = getent("lenin_statue","targetname");
	level.event9_statue_pieces = [];
	
	pieces = [];
	pieces[0] = "arm";
	pieces[1] = "head";
	pieces[2] = "torso";
	pieces[3] = "legs";

	wait 0.5;
	for(i=0;i<4;i++)
	{
		level.event9_statue_pieces[i] = spawn("script_model",(0,0,0));
		level.event9_statue_pieces[i].use_model = ("xmodel/o_rs_prp_leninstatue_" + pieces[i]);
		level.event9_statue_pieces[i].use_tag = ("tag_" + pieces[i]);
	}

	//TESTING
//	for(i=15;i>0;i--)
//	{
//		println(i);
//		wait 1;
//	}

//	level thread Event9_Bomb_Statue();
}

Event9_Bomb_Statue()
{
	wait 17;

	org = spawn("script_model",(1668, 4860, -96));
	org setmodel("xmodel/kharkov2_lenin_statue");
	org hide();

	for(i=0;i<4;i++)
	{
		tag_origin = org gettagorigin(level.event9_statue_pieces[i].use_tag);
		level.event9_statue_pieces[i].origin = tag_origin;
		level.event9_statue_pieces[i] setmodel(level.event9_statue_pieces[i].use_model);
		level.event9_statue_pieces[i] linkto(org, level.event9_statue_pieces[i].use_tag, (0,0,0),(0,0,0));
	}

	level.event9_statue hide();
	org playsound("stuka_bomb");
	playfx(level.stuka_bomb,(1700, 4975, -68));
	org.animname = "kharkov2_lenin_statue";
	org UseAnimTree(level.scr_animtree["kharkov2_debris"]);
	org animscripted("single anim", org.origin, org.angles, level.scr_anim[org.animname]["reactor"]);
	org waittillmatch("single anim","end");
	
	/*for(i=0;i<4;i++)
	{
		if (i != 3)
		{
			level.event9_statue_pieces[i] delete();
		}
	}*/
}

Event9_After_Bomb()
{

	for (i=0;i<400;i++)
	{
		self.origin = self.origin - (0,0,0.5);
	}
	self delete();
}

Event9_Keep_Player_on_Flak()
{
	flak = getent("event9_anti_air","targetname");
	
	while (1)
	{
		flak_owner = flak getvehicleowner();
		if (isdefined (flak_owner))
		{
			if (flak_owner == level.player)
			{
				break;
			}
		}
		wait 0.05;
	}
	
	level.player allowuse(false);
	level waittill ("bomber event completed");
	level.player allowuse(true);
}

Event9_Friendly_Flak_Fire_Fail()
{
	t34s = getentarray("event9_t34","targetname");
	t34s_shooters = getentarray("event9_t34_shooter","targetname");
	
	for (i=0;i<t34s_shooters.size;i++)
	{
		t34s[t34s.size] = t34s_shooters[i];
	}
	
	for (i=0;i<t34s.size;i++)
	{
		t34s[i] thread Event9_Friendly_Flak_Fire_Fail_Think();
	}
}

Event9_Friendly_Flak_Fire_Fail_Think()
{
	self endon ("death");
	flak = getent ("event9_anti_air","targetname");
	
	while (1)
	{
		self waittill("damage", dmg, attacker, dir, point, mod);
		if (attacker == flak || attacker == level.player)
		{
			break;
		}
	}
	
	setCvar("ui_deadquote", "@SCRIPT_MISSIONFAIL_KILLTEAM_RUSSIAN");
	missionFailed();
}

// Tells all of the living Axis to run away to the nearest Exit.
Axis_Retreat(targetname, min_delay, max_delay)
{
	axis = getaiarray("axis");
	nodes = getnodearray(targetname,"targetname");

	for(i=0;i<axis.size;i++)
	{
		if(!isalive(axis[i]))
		{
			continue;
		}

		closest_node = undefined;
		dist1 = undefined;

		if(isdefined(axis[i].script_noteworthy))
		{
			if(axis[i].script_noteworthy == "kill_me")
			{
				println("^1(Axis_Retreat): Bloody Death Called!");
				axis[i] thread Bloody_Death(true);
				continue;
			}
			else
			{
				closest_node = getnode(axis[i].script_noteworthy,"targetname");
			}
		}
		else
		{
			for(n=0;n<nodes.size;n++)
			{
				if(!isdefined(dist1))
				{
					dist1 = distance(nodes[n].origin,axis[i].origin);
				}
	
				if(isdefined(closest_node))
				{
					dist2 = distance(nodes[n].origin,axis[i].origin);
					if(dist2 < dist1)
					{
						closest_node = nodes[n];
						dist1 = dist2;
					}
				}
				else
				{
					closest_node = nodes[n];
				}
			}
		}

//		axis[i] thread do_line(axis[i].origin, closest_node.origin, (1,1,0), ("blah" + i));
		axis[i].goalradius = 4;
		axis[i].pacifist = true;
		axis[i].pacifistwait = 0;
		axis[i].suppressionwait = 0;
		axis[i] setgoalnode(closest_node);
		axis[i] thread Axis_Retreat_Think();

		if(isdefined(min_delay) && isdefined(max_delay))
		{
			wait (min_delay + randomfloat(max_delay));
		}
		else
		{
			wait (randomfloat(3));
		}
	}

	
}

// Once the AI has reached his retreat point, he deletes.
Axis_Retreat_Think()
{
	self waittill("goal");
	self delete();
}

// Has all of the allies move forward.
Event10_Transition()
{
	level notify ("bomber event completed");
	level notify("objective 6 complete");
	maps\_utility_gmi::autosave(4);

	allies = getentarray("event9_allies_group1","groupname");
	for(i=0;i<allies.size;i++)
	{
		if(!issentient(allies[i]))
		{
			continue;
		}

		if(isdefined(allies[i].script_uniquename) && allies[i].script_uniquename == "friendlychain_ai")
		{
			continue;
		}

		if(isdefined(allies[i].targetname) && allies[i].targetname == "antonov")
		{
			continue;
		}

		allies[i] thread Event10_Street_Run();
	}

	level.antonov thread anim_single_solo(level.antonov,"antonov_keep_moving");
	wait 1;
	level thread Friendly_ThreatBias(-50);

	trigger1 = getent("event10_respawner","script_noteworthy");
	trigger1 thread maps\_utility_gmi::TriggerOn();
	trigger2 = getent("event10_fight_1","script_noteworthy");
	trigger2 thread maps\_utility_gmi::TriggerOn();
	level thread maps\_utility_gmi::chain_on("event10_chains");

	tank = getent("event9_t34_shooter","targetname");
	targetent = getent("event10_wall1","targetname");
	tank thread Tank_Fire_Turret(targetent, targetpos, start_delay, 5, offset, validate, true);

	level thread Event11_Setup();

	trigger2 waittill("trigger");
	level thread Antonov_Movement();

	trigger3 = getent("event10_axis_check","script_noteworthy");
	trigger3 waittill("trigger");

	level.antonov thread anim_single_solo(level.antonov,"heads_up");

	level thread Event10_Chain_Check();

	wait 0.5;

	axis = getentarray("event10_axis_trans","groupname");

	axis_ai = [];
	for(i=0;i<axis.size;i++)
	{
		if(isalive(axis[i]) && issentient(axis[i]))
		{
			axis_ai[axis_ai.size] = axis[i];
		}
	}

	level.event10_count = axis_ai.size;
	for(i=0;i<axis_ai.size;i++)
	{
		axis_ai[i] thread Event10_Axis_Check();
	}
}

Event10_Street_Run()
{
	node = getnode("event9_kill_spot","targetname");
	self.goalradius = 16;
	self setgoalnode(node);
	self waittill("goal");
	self delete();
}

// If the specified trigger is hit while fighting the AI
// on the balconies, this will prevent the AI from going to
// the Chain given after all of the AI (on the balconies) are dead.
Event10_Chain_Check()
{
	trigger = getent("event11_chain0_check","targetname");
	trigger waittill("trigger");

	level.event10_count = -1;

	// Starts the initial waves of guys, so the Russians don't look like
	// statues before the player jumps out of the factory.
	level thread Event11_Initial_Wave();
}

Event10_Axis_Check()
{
	self waittill("death");

	level.event10_count--;

	if(level.event10_count == 0)
	{
		node = getnode("event11_chain0","targetname");
		level.player setfriendlychain(node);
	}
}

// If cvar "skipto_event10" is set to 1, then teleport
// all of the friends to event10_transition area, and proceed.
Skipto_Event10()
{
	level.max["allies_group2"] = 0; //Group2 go bye-bye.
	org = (3048, 7988, 64);

	player_node = getnode("md_814","targetname");
	level.player setfriendlychain(player_node);

	allies_group1 = getentarray("allies_group1","groupname");
	allies_group1 = add_array_to_array(allies_group1, level.friends);
	for(i=0;i<allies_group1.size;i++)
	{
		if(issentient(allies_group1[i]))
		{
			allies_group1[i] teleport(org);
			allies_group1[i].script_uniquename = "friendlychain_ai";
			allies_group1[i] setgoalentity(level.player);
	
			org = ((org[0] - 36), org[1], org[2]);
		}
	}

	group2_node = getnode("event9_group2_chain1","targetname");
//	level.group2_commander setfriendlychain(group2_node);
//	level.group2_commander setgoalnode(group2_node);
	level.group2_commander delete();

	allies_group2 = getentarray("allies_group2","groupname");
	for(i=0;i<allies_group2.size;i++)
	{
		if(issentient(allies_group2[i]))
		{
			allies_group2[i] delete();
		}
	}

	level.antonov teleport((3048, 8000, 64));

	level.player setorigin((-664,2240,-156));
	wait 0.1;
	level.player setorigin((2960, 7604, 25));
//	level.player setplayerangles((0,90,0));

	level thread Event10_Chain_Check();
	wait 0.5;
	axis = getentarray("event10_axis_trans","groupname");

	axis_ai = [];
	for(i=0;i<axis.size;i++)
	{
		if(isalive(axis[i]) && issentient(axis[i]))
		{
			axis_ai[axis_ai.size] = axis[i];
		}
	}

	level.event10_count = axis_ai.size;
	for(i=0;i<axis_ai.size;i++)
	{
		axis_ai[i] thread Event10_Axis_Check();
	}

	level thread maps\_utility_gmi::chain_on("event10_chains");

	wait 5;
	level thread maps\_utility_gmi::exploder(10);
	level thread Event11_Setup();
//	tank1 = getent("event9_tank1","targetname");
//	radiusDamage(tank1.origin, 1024, 5000, 5000);
//	tank2 = getent("event9_tank2","targetname");
//	radiusDamage(tank2.origin, 1024, 5000, 5000);

	level thread Friendly_ThreatBias(-50);

	wait 0.25;
	level notify("stop_music1");
	wait 0.25;

	level notify("objective 1 complete");
	wait 0.25;
	level notify("objective 2 start");
	wait 0.25;
	level notify("objective 2 complete");
	wait 0.25;
	level notify("objective 3 start");
	wait 0.25;
	level notify("objective 3 complete");
	wait 0.25;
	level notify("objective 4 complete");
	wait 0.25;
	level notify("objective 5 complete");
	wait 0.25;
	level.event9_he111_total = "16";
	level notify("objective 6 start");
	wait 0.25;
	level notify("objective 6 complete");


	level thread Event11_Explosive_Targets();
	level thread Event11_WaterTower_Bottom_Think();
	level thread Event11_WaterTower_Top_Think();
	level thread Event11_FuelCars();

	wait 5;
	level notify("start_music2");
	wait 0.25;
}

// End of Map Setup.
Event11_Setup()
{
	level thread maps\_utility_gmi::chain_off("event11_chain1");

	// Adjust loadouts for friendly units.
	level.vassili.grenadeAmmo = 5;
	level.miesha.grenadeAmmo = 5;

	level thread Event11_Commissar();

	// Start Raining.
//	level thread Event11_Rain();
//	level thread maps\_event_manager::_loop();	//	reset all the shit and start the loops

	trigger = getent("event11_stuka_flyby","targetname");
	trigger waittill("trigger");

	level thread Event11_Commissar_Talk();

	maps\_utility_gmi::autosave(5);

	level thread Clean_Up_By_Death("event10_axis_trans", undefined, 5, initial_delay, wait_till);

	// Send out a lone fly stuka for a intro flyby.
	level thread Event11_Stuka_Spawner(undefined, undefined, "flyby");

	// Spawn in the friendly line up
	// Note: Took out, since these guys only spawn once and get blown up. Same
	// groupname incase I need to get them.
//	level thread maps\_respawner_gmi::respawner_setup("event11_allies_group1", undefined, attrib, undefined, undefined, undefined);

	// Setup the flak gun.
	flakv = getent("FlakVierling","targetname");
	flakv maps\_flakvierling_gmi::init(8000);
	level.flakv = flakv;
	//level.flakv thread anti_air_regen();
	wait 0.1;
	level thread Health_Regen(flakv, 2000, 0.25, "stop_flakvierling_regen", 50);
	flakv thread Event11_Turret_Think();

	flak_gun = getent("event11_flak88","targetname");
	flak_gun thread Event11_Turret_Think();
	level thread Health_Regen(flak_gun, 2000, 0.25, "stop_flak88_regen", 50);

	level thread Event11_Start();
	level waittill("event11_start");

	// Bomb the platform.
	level notify("End_Event11_Initial_Wave");

	level thread Event11_FuelCars();
	level thread Event11_Explosive_Targets();
	level thread Event11_WaterTower_Bottom_Think();
	level thread Event11_WaterTower_Top_Think();

	// Total enemy tanks in the end.
	level.event11_tank_count = 5;

	level notify("objective 7 complete");
	level thread Antonov_Movement();

	// Stop the Allies from respawning and delete all of the living AI.
	level thread maps\_respawner_gmi::respawner_stop("event9_allies_group1");
	event9_allies_group1 = getentarray("event9_allies_group1","groupname");
	for(i=0;i<event9_allies_group1.size;i++)
	{
		if(issentient(event9_allies_group1[i]) && isalive(event9_allies_group1[i]))
		{
			event9_allies_group1[i] delete();
		}
	}

	level thread Event11_Zone_Trigger_Setup();
	level thread Event11_Stukas();

	// Start the waves.
	level thread Event11_Wave_Manager();
}

Event11_Commissar()
{
	spawner = getent("event11_commissar1","targetname");
	spawned = spawner dospawn();

	if(isdefined(spawned))
	{
		spawned waittill("finished spawning");
		spawned.ignoreme = true;
		spawned settakedamage(0);
		spawned.pacifist = true;
		spawned.pacifiswait = 0;
		spawned.goalradius = 4;
		spawned.animname = "commissar";

		spawned.talk_node = getnode(spawner.target,"targetname");

		level.event11_commissar1 = spawned;
	}
}

Event11_Commissar_Talk()
{
	level.event11_commissar1 anim_single_solo(level.event11_commissar1, "comm_station", undefined, level.event11_commissar1.talk_node);
	wait 4;
	level.event11_commissar1 anim_single_solo(level.event11_commissar1, "comm_avenge", undefined, level.event11_commissar1.talk_node);
	level notify("start_music2");

	node = getnode("event11_commissar1_spot2","targetname");
	level.event11_commissar1 settakedamage(1);
	level.event11_commissar1.pacifist = false;
	level.event11_commissar1.ignoreme = false;
	level.event11_commissar1 setgoalnode(node);
}
Event11_Start()
{
	level thread Event11_Start_Timed();

	trigger = getent("event11_start","targetname");
	trigger waittill("trigger");

	level notify("event11_start");
}

Event11_Start_Timed()
{
	timer = (20 * 1000) + gettime(); // 20 seconds

	while(timer > gettime())
	{
		wait 0.25;
	}

	level notify("event11_start");	
}

Event11_FuelCars()
{
	triggers = getentarray("fuelcar_trigger","targetname");

	println("Total Fuelcar Triggers = ",triggers.size);
	for(i=0;i<triggers.size;i++)
	{
		level thread Event11_FuelCars_Think(triggers[i]);
	}
}

Event11_FuelCars_Think(trigger)
{
	trigger endon("death");

	fuelcar = getent(trigger.target,"targetname");
	flak_gun = getent("event11_flak88","targetname");

	while(1)
	{
		trigger waittill("trigger", dmg, attacker, dir, point, mod);
		println("FuelCar Took Damage");

		playfx(level.stuka_bomb,fuelcar.origin);
		fuelcar setmodel("xmodel/o_rs_prp_fuelcar_dmg");
		radiusDamage (fuelcar.origin, 1024, 400, 1);
		earthquake(0.7, 0.5, fuelcar.origin, 2048);
		if(getcvarint("scr_gmi_fast") > 1)
		{
			maps\_fx_gmi::LoopFx("distant_fire2_sound", (fuelcar.origin), 0.6, undefined, undefined, undefined, undefined, "same", 2000);
		}
		else
		{
			maps\_fx_gmi::LoopFx("distant_fire2_smoke_sound", (fuelcar.origin), 0.3, undefined, undefined, undefined, undefined, "same", 2000);
		}

		break;
	}

	trigger delete();
}

Event11_Rain()
{
	wait 15;
	num = 500;

//	playfxonplayer(level.atmos["rain"]);
	wait 0.1;
//	setcvar("cg_atmosDense",num);

	while(num > 50)
	{
		wait 0.5;
		num -= 5;
		println(num);
//		setcvar("cg_atmosDense",num);
	}
//	setcvar("cg_atmosDense","50");
}

Event11_Zone_Trigger_Setup()
{
	wait 5;
	level.last_area = true;
	level.end_group = [];
	level.end_group[level.end_group.size] = level.vassili;
	level.end_group[level.end_group.size] = level.miesha;

	triggers = getentarray("event11_zones","targetname");
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread Event11_Zone_Trigger_Think();
	}
}

Event11_Zone_Trigger_Think()
{
	level endon("End_The_Level");

	while(1)
	{
		self waittill("trigger");
		level.last_area_trigger = self;

		nodes = getnodearray(level.last_area_trigger.target,"targetname");
		nodes = maps\_utility_gmi::array_randomize(nodes);

		for(i=0;i<level.end_group.size;i++)
		{
			level.end_group[i] setgoalnode(nodes[i]);
		}

		while(level.player istouching(self))
		{
			wait 0.5;
		}
	}
}

Event11_Wave_Manager()
{
	level waittill("event11_start_waves");

	if(getcvar("quick_end") == "1")
	{
		level.reinforcment_time = 0.5; // Minutes
	}
	else
	{
		level.reinforcment_time = 2; // Minutes
	}

	level.flag["event11_started"] = true;
	// Divide up the wave times.
	level.wave_notify_time = (level.reinforcment_time * 60)/2;

	level thread Event11_ThreatBias_Controller();

	// Displays the reinforcement timer.
	level thread Event11_Wave1();
	wait level.wave_notify_time;
	level thread Event11_Wave2();
	wait level.wave_notify_time;
	level thread Event11_Wave3();

	level waittill("objective 8 complete");
	level thread Event11_Wave4();

	wait 5;
	level thread Event11_Reinforcement_Timer();
}

Event11_Initial_Wave()
{
	println("^2INITIAL WAVE STARTED!!!");

	allies = getentarray("event11_allies_group1","groupname");
	for(i=0;i<allies.size;i++)
	{
		if(isai(allies[i]) && isalive(allies[i]))
		{
			allies[i] thread maps\_utility_gmi::magic_bullet_shield();
		}
	}

	level thread Event11_Group_Spawners("event11_axis_group1", 15, 30);
	level thread Event11_Group_Spawners("event11_axis_group2", 10, 20, 15);

	attributes["suppressionwait"] = 0.5;
	attributes["bravery"] = 5000;
	level thread maps\_respawner_gmi::random_respawner_setup("event11_axis_individual", true, attributes, num_of_respawns, wait_till, "kharkov2_special", 3);

	level waittill("End_Event11_Initial_Wave");
//	level thread maps\_respawner_gmi::respawner_stop("event11_allies_group1");
	level Chain_On("event11_chain1", 5);

	println("^6Vassili: Incoming STUKA!!!");

	level thread Event11_Stuka_Spawner(undefined, undefined,"bomb_platform");
	level notify("start_stuka_runs");

	wait 7;

	for(i=0;i<allies.size;i++)
	{
		if(isai(allies[i]) && isalive(allies[i]))
		{
			allies[i] notify("stop magic bullet shield");
			allies[i].health = 10;

			allies[i] thread Bloody_Death(true, 10);
		}
	}

	level notify("event11_start_waves");
}

Event11_SpawnThink()
{
	self waittill("goal");

	if(isdefined(self.sm_goalnode))
	{
		if(isdefined(self.sm_goalnode.script_delay))
		{
			wait self.sm_goalnode.script_delay;
		}
		else
		{
			wait 5;
		}
	}
	self.goalradius = 128;
	self.script_uniquename = "friendlychain_ai";
	self setgoalentity(level.player);
}

Event11_Wave1()
{
	println("^2WAVE 1 STARTED!!!");
//	self endon("wave2");
//	maps\_event_manager::_add(0,maps\_squad_manager::manage_spawners,"w2_mp40",3,3,"wave2",1,::Event11_SpawnThink);
//	maps\_event_manager::_add(0,maps\_squad_manager::manage_spawners,"w2_kar98k",3,3,"wave2",2,::Event11_SpawnThink);
//	maps\_event_manager::_add(0,maps\_squad_manager::manage_spawners,"w2_gewehr",3,3,"wave2",3,::Event11_SpawnThink);
//	maps\_event_manager::_add(5,::Event11_Tank_Spawner,"panzeriv_wave2_1","panzeriv");
////	maps\_event_manager::_add((8 + randomint(5)),::Event11_Tank_Spawner,"panzeriv_wave2_2","panzeriv");
////	maps\_event_manager::_add(8,::event_stuka,"Stuka2_start","wave2",0);
//	maps\_event_manager::_add(20,maps\_squad_manager::manage_spawners,"w2_mg34",1,2,"wave2",60);
//	maps\_event_manager::_add(30,::Event11_Halftrack_Spawner,"halftrack_wave2");
//	maps\_event_manager::_add(level.wave_notify_time,maps\_event_manager::_notify,level,"wave2");

	level.max["allies_group1"] = 2;
	level thread maps\_respawner_gmi::respawner_setup("event11_allies_group2", undefined, attrib, undefined, undefined, undefined);

	level thread Event11_Tank_Spawner("panzeriv_wave2_1","panzeriv_end", 5);
	level thread Event11_Halftrack_Spawner("halftrack_wave2", 30);

	level.amount_of_ai["event11_axis_individual"] = 5;
	//           Event11_Modder(name,                       name_type, starting_health, accuracy, suppressionwait, node_delay)
	level thread Event11_Modder("event11_axis_individual", "groupname", 150, 0.5, 0.25, 0.5);

	level waittill("End_Event11_Wave2");
}

Chain_On(name, delay)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	level thread maps\_utility_gmi::chain_on(name);
}

Event11_Wave2()
{
	println("^2WAVE 3 STARTED!!!");
//	self endon("wave3");
//	maps\_event_manager::_add(0,maps\_squad_manager::manage_spawners,"w3_mp40",4,4,"wave3",1,::Event11_SpawnThink);
//	maps\_event_manager::_add(0,maps\_squad_manager::manage_spawners,"w3_kar98k",4,4,"wave3",2,::Event11_SpawnThink);
//	maps\_event_manager::_add(0,maps\_squad_manager::manage_spawners,"w3_flamethrower",1,2,"wave3",3,::Event11_SpawnThink);
////	maps\_event_manager::_add(5,::Event11_Tank_Spawner,"panzeriv_wave3","panzeriv");
//	maps\_event_manager::_add(5,::Event11_Halftrack_Spawner,"halftrack_wave3");
//	maps\_event_manager::_add((10 + randomint(3)),::Event11_Tank_Spawner,"tiger_wave3","tiger");
//	maps\_event_manager::_add(20,maps\_squad_manager::manage_spawners,"w3_mg34",1,4,"wave3",70);
//	maps\_event_manager::_add(level.wave_notify_time,maps\_event_manager::_notify,level,"wave3");

	level notify("stop_flakvierling_regen");
	level.Stuka_Delay = 30;
	level.max["allies_group1"] = 0;
	level thread Event11_Halftrack_Spawner("halftrack_wave3", 5);
	level thread Event11_Tank_Spawner("tiger_wave3","tiger_end", (10 + randomint(5)));
	level thread Event11_Tank_Spawner("panzeriv_wave2_2","panzeriv_end", (20 + randomint(10)));

	level thread Event11_Modder("event11_allies_group2", "groupname", 100, 0.1);

	level.amount_of_ai["event11_axis_individual"] = 7;
	level thread Event11_Modder("event11_axis_individual", "groupname", 175, 0.9, 0, 0.5);
	level thread Event11_Modder("event11_axis_group1", "groupname", 175, 0.9, 0.25, 0.5);
	level thread Event11_Modder("event11_axis_group2", "groupname", 175, 0.9, 0.25, 0.5);
	level thread Event11_Modder("event11_axis_group3", "groupname", 175, 0.9, 0.25, 0.5);
	level thread Event11_Modder("event11_axis_group4", "groupname", 175, 0.9, 0.25, 0.5);

	level waittill("End_Event11_Wave3");
	println("^1WAVE 3 ENDED!!!");
}

Event11_Wave3()
{
	println("^2WAVE 3 STARTED!!!");
//	self endon("wave4");
//	maps\_event_manager::_add(0,maps\_squad_manager::manage_spawners,"w4_mp40",4,4,"wave4",1,::Event11_SpawnThink);
//	maps\_event_manager::_add(0,maps\_squad_manager::manage_spawners,"w4_kar98k",4,4,"wave4",2,::Event11_SpawnThink);
//	maps\_event_manager::_add(0,maps\_squad_manager::manage_spawners,"w4_gewehr",4,4,"wave4",3,::Event11_SpawnThink);
//	maps\_event_manager::_add(0,::Event11_Halftrack_Spawner,"halftrack1_wave4");
//	maps\_event_manager::_add(5,::Event11_Tank_Spawner,"panzeriv1_wave4","panzeriv");
////	maps\_event_manager::_add((10 + randomint(3)),::Event11_Tank_Spawner,"panzeriv2_wave4","panzeriv");
//	maps\_event_manager::_add((15 + randomint(3)),::Event11_Tank_Spawner,"tiger_wave4","tiger");
////	maps\_event_manager::_add(4,::event_stuka,"Stuka1_start","wave4",0);
////	maps\_event_manager::_add(17,::event_stuka,"Stuka2_start","wave4",0);
//	maps\_event_manager::_add(level.wave_notify_time,maps\_event_manager::_notify,level,"wave4");

	level.Stuka_Delay = 25;

	level.amount_of_ai["event11_axis_individual"] = 10;
	flak_gun = getent("event11_flak88","targetname");
	level notify("stop_flak88_regen");

	level thread Event11_Tank_Spawner("panzeriv1_wave4","panzeriv_end", 5);
	level thread Event11_Tank_Spawner("tiger_wave4","tiger_end", 20);

	level thread Event11_Group_Spawners("event11_axis_group3", 10, 20, 30);

	level waittill("Event11_Axis_Retreat");
	level.amount_of_ai["event11_axis_individual"] = 0;
	level thread Axis_Retreat("event11_retreat_node", 0, 3);
}

Event11_Wave4()
{
	level thread Event11_No_Hiding();

	level notify("kharkov2_special");
	level.flag["kharkov2_special"] = true;

	if(getcvarint("scr_gmi_fast") < 2)
	{
		level.amount_of_ai["event11_axis_individual"] = 20;
	}
	else
	{
		level.amount_of_ai["event11_axis_individual"] = 10;
	}
	
	println("^2WAVE 4 STARTED!!!");
	level thread Event11_Halftrack_Spawner("halftrack1_wave4");
	level thread Event11_Group_Spawners("event11_axis_group4", 10, 20, 15);
	level thread Event11_Group_Spawners("event11_axis_group5", 5, 10, 60);
	level thread Event11_Wave4b();

	level waittill("End_The_Level");
	level thread maps\_respawner_gmi::respawner_stop("event11_allies_group2");
	level thread maps\_respawner_gmi::respawner_stop("event11_axis_individual");
	level thread Event11_Reinforcements();
	level notify("stop_stuka_runs");
	wait 5;
	level notify("objective 9 complete");
	level thread End_Cinematic();
}

Event11_Wave4b()
{
	wait 60;
	level thread Event11_Modder("event11_axis_group4", "groupname", 175, 0.9, 0.25, 0.5);
	level thread Event11_Modder("event11_axis_group5", "groupname", 175, 0.9, 0.25, 0.5);
}

Event11_ThreatBias_Controller()
{
	level endon("End_The_Level");

	old_health = level.player.maxhealth;

	min_threatbias = -100;

	while(1)
	{
		if(level.player.health < level.player.maxhealth)
		{
			div = (float)level.player.health / (float)level.player.maxhealth;
			println("DIV = ", div);
			bias = min_threatbias + ((min_threatbias * -1) * div);
			level.player.threatbias = bias;	
		}

		println("^5(Event11_ThreatBias_Controller): Player's threatbias: ",level.player.threatbias);
		wait 1;
	}
}

// If player is on the turret, have AI miss for 20 seconds.
Event11_Turret_Think()
{
	level thread Event11_Turret_DeathThink(self);
	self endon("death");

	while(1)
	{
		self waittill("player_on_vehicle");
		println("^5Player is on TURRET: ",self.targetname);
		level.player.ignoreme = true;
		level thread Event11_Player_Ignore_Timer(self);
		level.player.on_turret = self.targetname;

		self waittill("player_off_vehicle");
		println("^5Player is off TURRET: ",self.targetname);
		level.player.ignoreme = false;
		level.player.on_turret = "none";
	}
}

Event11_Player_Ignore_Timer(turret)
{
	turret endon("death");
	turret endon("player_off_vehicle");
	wait 20;
	println("^5Player's IGNORE wore off");
	level.player.ignoreme = false;
}

Event11_Turret_DeathThink(turret)
{
	my_targetname = turret.targetname;
	turret waittill("death");

	if(isdefined(level.player.on_turret) && level.player.on_turret == my_targetname && level.player.ignoreme)
	{
		level.player.ignoreme = false;
	}
}

Event11_No_Hiding()
{
	triggers = getentarray("event11_traincar_hiding","targetname");
	maps\_utility_gmi::array_thread(triggers, ::Event11_No_Hiding_Think);
}

Event11_No_Hiding_Think()
{
	while(1)
	{
		self waittill("trigger");

		println("^5(Event11_No_Hiding_Think): WARNING! YOU ARE TRYING TO HIDE UNDER A TRAINCAR!");

		wait 3; // Small delay... Invisible warning persay...

		if(level.player istouching(self))
		{
			println("^5(Event11_No_Hiding_Think): YOU ARE ABOUT TO GET OWNED!");
			attrib["ignoreme"] = true;
			attrib["bravery"] = 5000;
			attrib["favoriteenemy"] = level.player;
			attrib["allowedstances"] = "crouch prone";
			level thread maps\_respawner_gmi::respawner_setup(self.script_noteworthy, undefined, attrib, undefined, undefined, undefined);
		}
		else
		{
			continue;
		}

		while(level.player istouching(self))
		{
			wait 0.5;
		}

		level thread maps\_respawner_gmi::respawner_stop(self.script_noteworthy);

		ai = getentarray(self.script_noteworthy + "_ai","targetname");
//		maps\_utility_gmi::array_thread(triggers, ::Bloody_Death, true);

		for(i=0;i<ai.size;i++)
		{
			ai[i] thread Bloody_Death(true);
			wait randomfloat(3);
		}
	}
}

Event11_Group_Spawners(groupname, spawn_delay_min, spawn_delay_max, initial_delay)
{
	level endon("End_The_Level");

	all = getspawnerarray();

	// Used so it keeps track of all groupnames and we can modify it later.
	if(!isdefined(level.group_names))
	{
		level.group_names = [];
	}

	level.group_names[level.group_names.size] = groupname;

	respawners = [];
	for(i=0;i<all.size;i++)
	{
		if(isdefined(all[i].groupname) && all[i].groupname == groupname)
		{
			respawners[respawners.size] = all[i];
		}
	}

	level.spawn_delay_min[groupname] = spawn_delay_min;
	level.spawn_delay_max[groupname] = spawn_delay_max;

	if(isdefined(initial_delay))
	{
		wait initial_delay;
	}

	while(1)
	{
		for(i=0;i<respawners.size;i++)
		{
			level thread Event11_Guy_Spawn(respawners[i]);
		}

		level waittill(groupname + "_respawn");

		delay = randomFloatRange(level.spawn_delay_min[groupname], level.spawn_delay_max[groupname]);
		wait delay;
	}
}

Event11_Guy_Spawn(respawner)
{
	respawner.count = 1;

	// Spawn the AI
	if(isdefined(respawner.script_stalingradspawn) && respawner.script_stalingradspawn)
	{	
		spawned = respawner stalingradSpawn();
	}
	else
	{
		spawned = respawner dospawn();
	}
//	respawner waittill("spawned");

	if(isdefined(spawned))
	{
		spawned waittill("finished spawning");
		spawned thread Event11_Axis_Death(respawner.groupname);

		if(isdefined(respawner.target))
		{
			nodes = getnodearray(respawner.target,"targetname");
			if(nodes.size > 0)
			{
				num = randomint(nodes.size);
				spawned thread maps\_respawner_gmi::respawner_follow_nodes(nodes[num], "kharkov2_special");
			}
		}
	}
}

Event11_Axis_Death(groupname)
{
	self waittill("death");
	
	axis = getaiarray("axis");

	group_count = 0;
	for(i=0;i<axis.size;i++)
	{
		if(isdefined(axis[i].groupname) && axis[i].groupname == groupname)
		{
 			if(isalive(axis[i]))
			{
				group_count++;
			}
		}
	}

	if(group_count == 0)
	{
		level notify(groupname + "_respawn");
	}
}

Event11_Modify_Spawn_Delay(min_delay, max_delay)
{
	for(i=0;i<level.group_names.size;i++)
	{
		level.spawn_delay_min[level.group_names[i]] = min_delay;
		level.spawn_delay_max[level.group_names[i]] = max_delay;
	}
}

Event11_Explosive_Targets()
{
	trigger_dmgs = getentarray("event11_explosive_target","targetname");

	println("^3(Event11_Explosive_Targets): trigger_dmgs.size: ",trigger_dmgs.size);

	for(i=0;i<trigger_dmgs.size;i++)
	{
		trigger_dmgs[i] thread Event11_Explosive_Trigger_Think();
	}
}

Event11_Explosive_Trigger_Think()
{
	flak_gun = getent("event11_flak88","targetname");

	while(1)
	{
		self waittill("damage", dmg, attacker, dir, point, mod);
		println("^5DAMAGED by: ",attacker.targetname);

		if(attacker != flak_gun)
		{
			continue;
		}
		println("Doing Animation");
		level thread Falling_Debris(self.target, self.script_animname, origin);
		break;
	}
}

Event11_WaterTower_Bottom_Think()
{
	trigger = getent("watertower_bottom_trigger","targetname");
	trigger endon("death");

	bottom = getent("watertower_bottom","targetname");
	bottom.animname = "kharkov2_watertower_exp";
	bottom UseAnimTree(level.scr_animtree["kharkov2_debris"]);

	flak_gun = getent("event11_flak88","targetname");

	println("^5BOTTOM THINKING!");
	while(1)
	{
		trigger waittill("damage", dmg, attacker, dir, point, mod);
		println("^5DAMAGED by: ",attacker.targetname);

		if(attacker != flak_gun)
		{
			continue;
		}

		level.bottom_tower_fall = true;

		clip = getent("water_tower_bottom_clip","targetname");
		tag_origin = flak_gun gettagorigin("tag_flash");
		tag_angles = flak_gun gettagangles("tag_flash");
		forward = anglestoforward(tag_angles);

		dist = distance(tag_origin, clip.origin);

		far_pos = tag_origin + maps\_utility_gmi::vectorScale(forward, dist);

		playfx(level._effect["watertower_base"],far_pos);

		bottom animscripted("single anim", bottom.origin, bottom.angles, level.scr_anim[bottom.animname]["reactor"]);
		break;
	}

	clip = getent("water_tower_bottom_clip","targetname");
	clip delete();
	clip_top = getent("water_tower_top_clip","targetname");
	if(isdefined(clip_top))
	{
		clip_top delete();
	}

	trigger2 = getent("watertower_top_trigger","targetname");
	if(isdefined(trigger2))
	{
		trigger2 delete();
	}


	trigger delete();
}

Event11_WaterTower_Top_Think()
{
	trigger = getent("watertower_top_trigger","targetname");
	trigger endon("death");

	flak_gun = getent("event11_flak88","targetname");
	level.bottom_tower_fall = false;

	bottom = getent("watertower_bottom","targetname");

	top = getent("watertower_top","targetname");
	top linkto(bottom, "tag_top",(0,0,0),(top.angles));

	top_d = getent("watertower_top_d","targetname");
	top_d linkto(bottom, "tag_top",(0,0,0),(top.angles));
	top_d hide();	

	println("^5TOP THINKING!");
	while(1)
	{
		trigger waittill("damage", dmg, attacker, dir, point, mod);
		println("^5DAMAGED by: ",attacker.targetname);

		if(attacker != flak_gun)
		{
			continue;
		}

		if(level.bottom_tower_fall)
		{
			break;
		}

		top delete();
		top_d show();

		playfx(level._effect["watertower_top"],top_d.origin);
		break;
	}
	trigger delete();
}

// Changes attributes on the actual spawners themselves.
// Node_delay multiplies the current node_delay (if defined) by the value given.
Event11_Modder(name, name_type, starting_health, accuracy, suppressionwait, node_delay, bravery)
{
	if(!isdefined(name))
	{
		println("^1(Event11_Modder): NAME IS UNDEFINED!!");
		return;
	}

	if(!isdefined(name_type))
	{
		println("^1(Event11_Modder): NAME_TYPE IS UNDEFINED!!");
		return;
	}

	spawners = getentarray(name, name_type);	

	for(i=0;i<spawners.size;i++)
	{
		if(issentient(spawners[i]))
		{
			continue;
		}

		if(isdefined(starting_health))
		{
			spawners[i].script_startinghealth = starting_health;
		}
		else if(isdefined(accuracy))
		{
			spawners[i].script_accuracy = accuracy;
		}
		if(isdefined(suppressionwait))
		{
			spawners[i].script_suppression = suppressionwait;
		}

		nodes = getnodearray(spawners[i].target, "targetname");

		for(n=0;n<nodes.size;n++)
		{
			if(isdefined(nodes[n].target))
			{
				nodes_1 = getnodearray(nodes[n].target, "targetname");
				for(q=0;q<nodes_1.size;q++)
				{
					if(isdefined(nodes_1[q].target))
					{
						nodes_2 = getnodearray(nodes_1[q].target, "targetname");
						for(t=0;t<nodes_2.size;t++)
						{
							if(isdefined(nodes_2[t].script_delay) && isdefined(node_delay))
							{
								nodes_2[t].script_delay = nodes_2[t].script_delay * node_delay;
							}
						}
					}
	
					if(isdefined(nodes_1[q].script_delay) && isdefined(node_delay))
					{
						nodes_1[q].script_delay = nodes_1[q].script_delay * node_delay;
					}
				}
			}

			if(isdefined(nodes[n].script_delay) && isdefined(node_delay))
			{
				nodes[n].script_delay = nodes[n].script_delay * node_delay;
			}
		}
	}
}

Event11_Stukas()
{
	triggers = getentarray("event11_stuka_zone","targetname");

	level endon("stop_stuka_runs");
	level waittill("start_stuka_runs");

	wait 35;

	level.Stuka_Delay = 35;
	while(1)
	{
		trigger = undefined;

		// Pick a random EVENT11_STUKA_ZONE trigger.
		for(i=0;i<triggers.size;i++)
		{
			if(level.player istouching(triggers[i]))
			{
				trigger = triggers[i];
			}
		}

		// If the player is not touching a trigger,
		// use the main_stukas trigger.
		if(!isdefined(trigger))
		{
			trigger = getent("main_stukas","script_noteworthy");	
		}

		// Pick a random Start_node.
		v_nodes = getvehiclenodearray(trigger.target,"targetname");

		random_num = randomint(v_nodes.size);
		level thread Event11_Stuka_Spawner(v_nodes[random_num]);
		

		wait (level.Stuka_Delay + (randomfloat(5)));
	}
}

// Instead of adding code, I just play the FX manually when the play gets hit.
Event11_Stuka_Damage_Think(health)
{
	level thread Event_Stuka_Death_Think(self);

	self endon("death");
	anti_air = getent("FlakVierling","targetname");
	flak_gun = getent("event11_flak88","targetname");

	while(1)
	{
		self waittill("damage", dmg, attacker, dir, point, mod);
//		dist = distance(self.origin,level.player.origin);
//		println("^2He111 Damaged! Dist: ",dist);
		if(attacker != anti_air || attacker != flak_gun)
		{
			self.health = health;
			continue;
		}

		playfx ( level._effect["he111_impact"], point );
	}
}

Event_Stuka_Death_Think(stuka)
{
	stuka endon("reached_end_node");
	stuka waittill("death");

println("^1STUKA DEAD!!!");

	wait 0.3 + randomfloat(0.3);
	
	forward = anglestoforward(stuka.angles);
	
	playfx(level._effect["stuka_death"], stuka.origin, forward);

	stuka delete();
}

Event11_Stuka_Spawner(v_node, delay, special_node)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	if(isdefined(special_node))
	{
		v_node = getvehiclenode(special_node,"targetname");
	}

	if(isdefined(v_node.script_sound))
	{
		start_sound = v_node.script_sound;
	}

	Vehicle_Spawner("stuka", v_node, delay, 500, start_sound, vehicle_num, spawn_delay, name);
}

Event11_Yell(type, delay)
{
	if(!isdefined(delay))
	{
		wait 2 + randomfloat(3);
	}

	excluders = maps\_utility_gmi::add_to_array ( level.friends, level.antonov );

	if(isdefined(type))
	{
		if(type == "tank")
		{
			dialogue[0] = "gen_tank";
			dialogue[1] = "gen_tanks";
		}
		else if(type == "halftrack")
		{
			dialogue[0] = "gen_halftrack";
		}
		else if(type == "stuka")
		{
			dialogue[0] = "gen_stuka1";
			dialogue[1] = "gen_stuka2";
		}
		else
		{
			println("^1TYPE WAS NOT FOUND!");
			return;
		}
	}

	level thread ai_dialogue(true, ent, "anon_trooper", dialogue[randomint(dialogue.size)], delay, excluders);

	if(type == "stuka" && !level.flag["stuka_yell1"])
	{
		level.flag["stuka_yell1"] = true;
		// Original delay used to be 2.7 (where 0.5 is now).

		if(!isdefined(delay))
		{
			delay = 1;
		}

		//level thread ai_dialogue(true, ent, "anon_trooper", "gen_flak", delay, excluders);
	}

	if(type == "tank" && !level.flag["tank_yell1"])
	{
		level.flag["tank_yell1"] = true;

		if(!isdefined(delay))
		{
			delay = 1;
		}

		level thread ai_dialogue(true, ent, "anon_trooper", "gen_88", delay, excluders);
	}

}

//	add the halftrack to the map ( from the event system ) 
// Spawns in the halftracks at the end of the map.
Event11_Halftrack_Spawner(name, delay)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	if(!isdefined(name))
	{
		println("^1(Event11_Halftrack_Spawner): NAME IS NOT SPECIFIED!!!!");
		return;
	}

	println("^5(Event11_Halftrack_Spawner) Name: ",name);
	start_node = getvehiclenode(name + "_start","targetname");
	Vehicle_Spawner("halftrack", start_node, delay, 1000, start_sound, vehicle_num, spawn_delay, name);
	level thread Event11_Yell("halftrack", 5);
}

//	add a panzer 
//	if name2 is defined we will wait till this tank is dead then spawn another with name2
//	and if tanktype == 0 its a panzer
//	else if tanktype == 1 its a tiger

Event11_Tank_Spawner(name,type, delay)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	if(!isdefined(type))
	{
		println("^1(Event11_Tank_Spawner): TYPE IS NOT SPECIFIED!!!!");
		return;
	}

	if(!isdefined(name))
	{
		println("^1(Event11_Tank_Spawner): NAME IS NOT SPECIFIED!!!!");
		return;
	}

	println("^5(Event11_Tank_Spawner) Name: ",name);
	println("^5(Event11_Tank_Spawner) Type: ",type);
	start_node = getvehiclenode(name + "_start","targetname");
	
	println("^3Start_node = ",start_node);
	Vehicle_Spawner(type, start_node, delay, 1000, start_sound, vehicle_num, spawn_delay, name);
	level thread Event11_Yell("tank", 5);
}

Event11_Reinforcement_Timer()
{
	level.event11_time = level.reinforcment_time * 60; // 2 minutes.

	hud_timer = false;
	hud_timer2 = false;
	while(level.event11_time > 0)
	{
		wait 1;
	
		level.event11_time-= 1;
		if(level.event11_time < 121 && !hud_timer) // Old check, but keep incase we change this event again.
		{
			hud_timer = true;
			// Setup the HUD display of the timer.
			level.hudTimerIndex = 20;
			level.last_battle_timer = newHudElem();
			level.last_battle_timer.alignX = "left";
			level.last_battle_timer.alignY = "middle";
			level.last_battle_timer.x = 460;
			level.last_battle_timer.y = 100;
			level.last_battle_timer.label = &"GMI_KHARKOV2_REINFORCEMENTS";
			level.last_battle_timer setTimer(level.event11_time);
		}

		if(getcvar("end_timer") == "1" && !hud_timer2) // Old debug, but keep incase we change this event again.
		{
			hud_timer2 = true;
			// Setup the HUD display of the timer.
			level.last_battle_timer2 = newHudElem();
			level.last_battle_timer2.alignX = "right";
			level.last_battle_timer2.alignY = "middle";
			level.last_battle_timer2.x = 570;
			level.last_battle_timer2.y = 240;
//			level.last_battle_timer2.label = &"GMI_KHARKOV2_REINFORCEMENTS";
			level.last_battle_timer2 setTimer(level.event11_time);
		}

		if(level.event11_time < 10)
		{
			level notify("Event11_Axis_Retreat");
		}
//		println("TIMER: ",time_seconds);

		if(level.event11_time < 6)
		{		
			level notify("start_end_music");
		}
	}

	if(isdefined(level.last_battle_timer))
	{
		level.last_battle_timer destroy();
	}

	if(isdefined(level.last_battle_timer2))
	{
		level.last_battle_timer2 destroy();
	}

	level notify("End_The_Level");
}

Event11_Reinforcements()
{
//	v_nodes = getvehiclenodearray("event11_t34_1","targetname");
//	for(i=0;i<v_nodes.size;i++)
//	{
//		if(isdefined(v_nodes[i].script_delay))
//		{
//			delay = v_nodes[i].script_delay;
//		}
//		Vehicle_Spawner("T34", v_nodes[i], delay, "regen", start_sound, vehicle_num, spawn_delay, name);
//	}
}

End_Cinematic()
{

	level End_Cleanup();
	level End_Screen_Setup();
	level thread End_Fadein(level.black_screen, 2);
	
	/*scriptorg = getent("end_dead_tank","targetname");
	vehicle = spawnvehicle("xmodel/vehicle_tank_panzeriv","teh_tank","PanzerIV",scriptorg.origin,scriptorg.angles);
	vehicle thread maps\_panzerIV_gmi::init();
	radiusdamage(vehicle.origin, 10, vehicle.health+100, vehicle.health+10);*/
	
	level.player settakedamage(0);

	wait 2;
	level thread End_Train_Move();
	level.locomotive thread End_Train_Crash();
	level thread End_Train_Smoke();
	level thread End_Train_Steam();
	level thread End_Dummies();
	wait 1;
	level thread End_Fadein(level.borders[0], 0.1);
	level thread End_Fadein(level.borders[1], 0.1);

	level notify ("stop fx stop fuel fire");

//	camera = Camera_Spawner(camera, (90.5, 9600, 196), (0, 0, 0), (-1000, 9600, 196), (0,180,0), 13);

	Add_Camera((90.5, -96, 196), (5, 180, 0), "locomotive", (0,180,0), 4.5);

// NICKS	Add_Camera((1200, 10014, -168), (-10, 0, 0), (1200, 10014, 300), (10,0,0), 9.6, undefined, "ramp", 0.5);
//	Add_Camera((1200, 9500, 100), (15, 45, 0), (1200, 9500, 100), (15,45,0), 5.5);
	Add_Camera((1274, 9791, 102), (15, 14, 0), (1274, 9791, 102), (15,14,0), 3.5);
//	Add_Camera((-350, 10000, 150), (30, 90, 0), (-350, 9400, 500), (15,90,0), 25, 110);
	Add_Camera((-350, 9800, -150), (0, 90, 0), (-350, 9700, 500), (15,90,0), 20); // START DIALOGUE
	Add_Camera((707, 10082, -33), (0, 149, 0), (707, 10082, -33), (0,149,0), 5);
	Add_Camera((-547, 12188, -94), (0, -105, 0), (-547, 12188, -94), (0,-105,0), 7);
	Add_Camera((735, 10714, -40), (5, 87, 0), (954, 10713, -49), (5,90,0), 7);

	Add_Camera((-350, 9700, 500), (30, 90, 0), (-350, 9000, 600), (10,90,0), 17);

	println("^5Cameras SETUP! Total Cameras: ",level.cam_org.count);
	level.player.ignoreme = 1;
	level thread End_Sequence1();
	level thread End_Sequence2();
	level thread End_Sequence3();
	level thread End_Sequence4();
	level thread End_Sequence5();
	level thread End_Sequence6();
	level thread End_Sequence7();

//	setCullFog (100, 30000, 0.34, 0.36, 0.36, 20);
	// To compensate for new Sky (me no likey).
	setCullFog (500, 15000, 0.035, 0.078, 0.078, 0 );

//	level End_Cleanup();
	level Camera_Think();

	level waittill("Really_End_The_Level");
	println("^2MISSION SUCCESS!");
	println("^2MISSION SUCCESS!");
	println("^2MISSION SUCCESS!");
	
	if(isalive(level.player))
	{
		println("end game");
		setcvar("g_lastsavegame", "");
		setcvar("beat_the_game", "I_sure_did");

		setcvar("game_completed", "yup_yup");
		missionSuccess("credits", false);
	}
}

End_Cleanup()
{
	axis = getaiarray("axis");
	for(i=0;i<axis.size;i++)
	{
		axis[i] delete();
	}

	allies = getaiarray("allies");
	for(i=0;i<allies.size;i++)
	{
		allies[i] delete();
	}

	vehicles = getentarray("script_vehicle","classname");
	for(i=0;i<vehicles.size;i++)
	{
		if(vehicles[i].model == "xmodel/vehicle_tank_t34")
		{
			continue;
		}

		vehicles[i] thread End_Vehicle_Delete();
	}

	corpses = getentarray("script_vehicle_corpse","classname");
	for(i=0;i<corpses.size;i++)
	{
		corpses[i] thread End_Vehicle_Delete();
	}

	// Incase the user is on a MG42, delete it so he gets kicked off of it.
	mg42s = getentarray("misc_mg42","classname");
	for(i=0;i<mg42s.size;i++)
	{
		owner = mg42s[i] getturretowner();

		if(isdefined(owner))
		{
			if(owner == level.player)
			{
				println("^5 PLAYER IS ON THIS TURRET!");
				println("^5Mg42s[i].health ", mg42s[i].health);
				mg42s[i] delete();
			}
		}
	}

	// Incase the user is on a flak gun or flakvierling...
	// If he was, the end "cameras" would be messed up (looking at a weird angle).
	if (isalive(level.flak88))
	{
		flak_owner = level.flak88 getvehicleowner();
	}
	if(isdefined(flak_owner) && flak_owner == level.player)
	{

		level.flak88 useBy(level.player);
	}
	
	if (isalive(level.anti_air1))
	{
		anti_air1_owner = level.anti_air1 getvehicleowner();
	}
	
	if(isdefined(anti_air1_owner) && anti_air1_owner == level.player)
	{
		level.anti_air1 useBy(level.player);
	}
}

End_Vehicle_Delete()
{
	wait 3;
	if (isdefined(self))
	{
		stopattachedfx(self);
		wait 0.1;
		self delete();
	}
}

End_Screen_Setup()
{
	height = 50;
	border[0] = newHudElem();
	border[1] = newHudElem();
	for (i=0;i<border.size;i++)
	{
		border[i].x = 0;
		border[i].y = 0;
		border[i] setShader("black", 640, height);
		border[i].alpha = 0;
	}

	border[0].y = 480-height;
	black_screen = newHudElem();
	black_screen.x = 0;
	black_screen.y = 0;
//	black_screen.color = (0,0,0);
	println("Black_Screen.color = ",black_screen.color);
	black_screen setShader("black", 640, 480);
	black_screen.alpha = 0;

	level.borders = border;
	level.black_screen = black_screen;
}

End_Fadeout(elem, time, delay)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	if(!isdefined(time))
	{
		time = 2;
	}

	elem fadeOverTime (time);
	elem.alpha = 0;
}

End_Fadein(elem, time, delay, msg)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	if(!isdefined(time))
	{
		time = 2;
	}

	elem fadeOverTime (time);
	elem.alpha = 1;
}

End_Fades()
{
	while(1)
	{
		println("level.borders[0].alpha = ",level.borders[0].alpha);
		println("level.borders[1].alpha = ",level.borders[1].alpha);
		println("level.black_sreen.alpha = ",level.black_screen.alpha);
		wait 0.05;
	}
}

End_Sequence1()
{
	level waittill("camera_1_started");
	level thread End_Sound_Fx("cs_finale01");
	level thread End_Wind_Fx();
}

End_Wind_Fx()
{
	level endon("camera_2_started");
	while(1)
	{
		playfx(level._effect["train_side_wind"], (level.cam_org.origin + (-512, 0, 0)));
		wait 0.1;
	}
}

End_Sequence2()
{
	level waittill("camera_2_started");
	level thread End_Sound_Fx("cs_finale02");
}

End_Sequence3()
{
	level waittill("camera_3_started");
	level thread End_Sound_Fx("cs_finale03");
	level thread End_Sparks_FX();

//	level.cam_org playsound("comm_greatday");

//	axis = getentarray("end_axis_group1","targetname");
//	for(i=0;i<axis.size;i++)
//	{
//		axis[i].count = 1;
//		spawned = axis[i] stalingradspawn();
//
//		if(isdefined(spawned))
//		{
//			spawned thread End_Retreat();
//		}
//	}

	level thread maps\kharkov2_dummies::dummies_setup((0,0,0), "xmodel/kharkov2_dummies_germans", 30, (0,180,0), 7, 2, "kharkov2_dummies_germans", true, "end_backward_dummies", anim_wait, true, gun_fire_notify, 0, no_random_wait);	

	start_node = getvehiclenode("event11_t34_3","targetname");
	level thread Vehicle_Spawner("T34_noturret", start_node, delay, "regen", start_sound, vehicle_num, spawn_delay, name);

	wait 4;
	level thread End_Sequence3_Train_Guys(getent("end_commissar","targetname"));
	level thread End_Sequence3_Train_Guys(getent("end_flag_carrier","targetname"));
}

End_Sparks_FX()
{
	for(i=0;i<level.locomotive.sparks.size;i++)
	{
		level.locomotive.sparks[i] thread End_Sparks_FX_Think();
	}
}

End_Sparks_FX_Think()
{
	level endon("camera_4_started");
	while(1)
	{
		//num = 5 + randomint(15);
		num = 20;
		for(i=0;i<num;i++)
		{
			angles = vectornormalize((self.origin + (1,-0.3,0.5)) - self.origin);
			playfx(level._effect["train_sparks"], self.origin, angles);
			wait 0.1;
		}
		//wait 0.1 + randomfloat(0.2);
	}	
}

End_Sequence3_Train_Guys(the_spawner)
{
	guy = the_spawner stalingradspawn();

	maps\_spawner_gmi::waitframe();
	if(maps\_utility_gmi::spawn_failed(guy))
	{
		println(the_spawner.targetname, " ^1Did NOT spawn!");
		return;
	}

	guy.pacifist = true;
	guy.pacifistwait = 0;
	guy.maxsightdistsqrd = 0;
	guy settakedamage(0);
	guy.goalradius = 0;

	node = getnode(the_spawner.target,"targetname");

	if(the_spawner.targetname == "end_commissar")
	{
		guy animscripts\shared::PutGunInHand("none");
		guy attach("xmodel/stalingrad_megaphone", "TAG_WEAPON_RIGHT");
		guy.animname = "commissar";
		guy waittill("goal");
		guy thread anim_single_solo(guy, "comm_greatday", undefined, node);
	}
	else
	{
		guy character\_utility::new();
		guy character\RussianArmyOfficer_flagwave::main();
		guy.animname = "flagwaver";
//		guy attach ("xmodel/stalingrad_flag", "tag_weapon_Right");
		guy.walk_noncombatanim		= level.scr_anim["flagwaver"]["run"];
		guy.walk_noncombatanim2	= level.scr_anim["flagwaver"]["run"];
		guy.run_noncombatanim		= level.scr_anim["flagwaver"]["run"];
		guy.run_combatanim		= level.scr_anim["flagwaver"]["run"];
		guy.walk_combatanim		= level.scr_anim["flagwaver"]["run"];

		guy waittill("goal");
		guy thread anim_loop_solo(guy, "wave", undefined, undefined, node);
	}
}

End_Sequence4()
{
	level waittill("camera_4_started");
	level thread End_Sound_Fx("cs_finale04");
}

End_Sequence5()
{
	level waittill("camera_5_started");
	level thread End_Sound_Fx("cs_finale05");

	level notify("kill_train_dummies");
	level thread maps\kharkov2_dummies::dummies_setup((0,0,0), "xmodel/kharkov2_dummies_trainstation", 96, (0,180,0), 7, 2, "kharkov2_dummies_2nd_wave", true, "end_dummies", anim_wait, true, gun_fire_notify, 0, no_random_wait);

	start_node = getvehiclenode("event11_t34_4","targetname");
	level thread Vehicle_Spawner("T34_noturret", start_node, delay, "regen", start_sound, vehicle_num, spawn_delay, name);

	axis = getent("end_sequence_4_axis", "groupname");
	spawned_axis = axis stalingradspawn();

	allies = getent("end_sequence_4_allies", "groupname");
	spawned_allies = allies stalingradspawn();

	if(isdefined(spawned_allies) && isdefined(spawned_axis))
	{
		spawned_allies.favoriteenemy = spawned_axis;

		while(isalive(spawned_axis))
		{
			wait 0.1;
		}

//		if(getcvarint("g_gameskill") < 3)
//		{	
			spawned_allies.accuracy = 5; // SUPER ACCURATE
//		}
		spawned_allies setgoalnode(getnode("end_sequence_5_node","targetname"));
		spawned_allies.goalradius = 32;
		spawned_allies waittill("goal");
		spawned_allies delete();
	}
}

End_Sequence6()
{
	level waittill("camera_6_started");
	
	level Guy_Spawner("cine_spawn", "groupname");
	
	level thread End_Sound_Fx("cs_finale06");

	level Guy_Spawner("end_sequence_6", "groupname");
}

End_Sequence7()
{
	level waittill("camera_7_started");
	wait 6.5;

	for(i=1;i<4;i++)
	{
		path = getvehiclenode(("end_il2_path" + i),"targetname");

		if(isdefined(path.script_sound))
		{
			start_sound = path.script_sound;
		}

		level thread Vehicle_Spawner("il2", path, 0, 10000, "bf109_attack04", 1);
		wait 1.25;
	}
}

End_Sound_Fx(sound)
{
	org = spawn("script_origin", level.cam_org.origin);
	org linkto(level.cam_org);
	org playsound(sound, "sounddone");

	org waittill("sounddone");
	wait 2;
	org delete();
}

End_Retreat()
{
	self waittill("goal");
	self delete();
}

End_Slow_Mo()
{
//	wait 5.5; // Delay for camera switch.

	ratio = (1 - 0.2) / 10;
	num = 1;
	while(getcvarfloat("timescale") > 0.2)
	{
		num-= 0.08;
		setcvar("timescale",num);
		wait 0.05;
	}
	setcvar("timescale","0.2");

	wait 0.5;
	num = 0.2;
	while(getcvarfloat("timescale") < 1)
	{
		num+= 0.08;
		setcvar("timescale",num);
		wait 0.05;
	}
}

End_Train_Crash()
{
	while(1)
	{
		if(self.origin[0] < 3524)
		{
			break;
		}
		wait 0.05;
	}

//	level thread End_Slow_mo();

	debris = getentarray("train_crash","groupname");

	org = spawn("script_model", (0,0,0));
	org.animname = "end_train";

	println("^2org.animname: ",org.animname);
	println("^2debris.size: ",debris.size);
	// Setup the fake origin.
	org setmodel(("xmodel/kharkov2_traincrash"));
	org UseAnimTree(level.scr_animtree["end_train"]);

	playfx(level._effect["train_impact"], (2400, 10013, -114));

	// Link the debris to the tags on the script_model.
	for(i=0;i<debris.size;i++)
	{	
		// Check to see if it's an effect.
		if(debris[i].classname == "script_origin")
		{
			if(isdefined(debris[i].script_fxid))
			{
				if(isdefined(debris[i].target))
				{
					fx_target = getent(debris[i].target,"targetname");
					level thread maps\_fx_gmi::OneShotfx(debris[i].script_fxid, debris[i].origin, 0, fx_target.origin);
				}
				else
				{
					playfx(level._effect[debris[i].script_fxid], debris[i].origin);
				}
			}

			continue;
		}

		if(!isdefined(debris[i].script_noteworthy))
		{
			println("^1Script_Noteworthy is needed for Falling_Debris @ (" + self.origin + ")");
			continue;
		}
		else
		{
			if(debris[i].script_noteworthy == "delete")
			{
				debris[i] delete();
			}
			else
			{
				println("debris[i].script_noteworthy: ",debris[i].script_noteworthy);
				debris[i] linkto(org, debris[i].script_noteworthy,(0,0,0),(0,0,0));
				if(isdefined(debris[i].model) && debris[i].model == "xmodel/wood_largebeam")
				{
					debris[i] thread End_Debris_FX("debris_trail_15", 0.05, org);
				}
//				org thread do_line_tag(debris[i].script_noteworthy, org);
			}
		}
	}

	// Play the animation.
//	org setFlaggedAnimKnobRestart("animdone", level.scr_anim[self.animname]["reactor"]);

	// Play the hit sound on the player's camer org.
	org animscripted("single anim", org.origin, org.angles, level.scr_anim[org.animname]["reactor"]);
//	org thread maps\_anim_gmi::notetrack_wait(org, "single anim", undefined, "reactor");
	org waittillmatch("single anim","end");
	org notify("stop_fx");

	wait 0.1;
	org delete();	
}

End_Debris_FX(fx_name, delay, org)
{
//	org thread End_Debris_FX_Think(org, tag);
//	debris thread Falling_Debris_Sound(org, tag);

	wait randomfloat(3);

	if(!isdefined(delay))
	{
		delay = 0.1;
	}

	org endon("stop_fx");
	while(1)
	{
		playfx(level._effect[fx_name], self.origin);
//		playfxontag(level._effect["debris_trail_25"], org, tag);
		wait delay;
	}
}

End_Debris_FX_Think(org, tag)
{
	org waittillmatch("single anim", tag + "_fx");
	org notify(tag + "_stopfx");
	println("END!!! = ",tag);
}

End_Dummies()
{
	level.locomotive waittill("movedone");
	level thread maps\kharkov2_dummies::dummies_setup((0,0,0), "xmodel/kharkov2_dummies_trainstation", 96, (0,180,0), undefined, undefined, "end_dummy_path", true, "end_dummies", anim_wait, true, gun_fire_notify, 0, no_random_wait, "kill_train_dummies");
}

Test_Dummies()
{
//	wait 5;
	//                          dummies_setup(pos, model, total_tags, angle_offset, loop_time, loop_num, path_anim, weap, anim_name, anim_wait, random_move_forward, gun_fire_notify, mortar_amount, no_random_wait)
	level thread maps\kharkov2_dummies::dummies_setup((0,0,0), "xmodel/kharkov2_dummies_trainstation", 96, (0,180,0), 30, loop_num, "end_dummy_path", true, "end_dummies", anim_wait, true, gun_fire_notify, 0, no_random_wait);
}

Add_Camera(start_pos, angles, end_pos, end_angles, time, fov, shake, start_delay)
{
	if(!isdefined(level.cam_org))
	{
		level.cam_org = spawn ("script_origin", (0,0,0));
		level.cam_org.count = 0;

		level.cam_org.start_pos = [];
		level.cam_org.start_angle = [];

		level.cam_org.end_pos = [];
		level.cam_org.end_angles = [];

		level.cam_org.move_time = [];
		level.cam_org.fov = [];

		level.cam_org.special_fade = [];
		level.cam_org.start_delay = [];
		level.cam_org.shake = [];
	}

	level.cam_org.count++;
	level.cam_org.start_pos[level.cam_org.count] = start_pos;
	level.cam_org.start_angle[level.cam_org.count] = angles;

	if(isdefined(end_pos))
	{
		level.cam_org.end_pos[level.cam_org.count] = end_pos;
	}

	if(isdefined(end_angles))
	{
		level.cam_org.end_angles[level.cam_org.count] = end_angles;
	}

	if(!isdefined(time))
	{
		level.cam_org.move_time[level.cam_org.count] = 3;
	}
	else
	{
		level.cam_org.move_time[level.cam_org.count] = time;
	}

	if(!isdefined(fov))
	{
		level.cam_org.fov[level.cam_org.count] = 80;
	}
	else
	{
		level.cam_org.fov[level.cam_org.count] = fov;
	}

	if(isdefined(shake))
	{
		level.cam_org.shake[level.cam_org.count] = shake;
	}

	if(isdefined(start_delay))
	{
		level.cam_org.start_delay[level.cam_org.count] = start_delay;
	}
}

//"Cameras" is an array.
Camera_Think()
{
//	level thread player_angles();
	setcvar("cg_fov", "80");

	setcvar("cg_hudcompassvisible", "0");
//	setcvar("cg_drawgun", "0");

	level.player takeallweapons();

	level.player setorigin((797,9207,-112));
	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowProne(false);
	wait 0.5;
	level.player allowcrouch(false);
	wait 0.5;
	level.player freezeControls(true);
	wait 0.25;
	level.player setplayerangles((0,0,0));
	wait 0.25;

	if(!level.camera_in_use)
	{
		level.camera_in_use = true;
		level.cam_org.origin = (level.player.origin + (0,0,60)); // 60 seems to be the camera height.
		level.cam_org.angles = (0,0,0);
		wait 0.1;
		level.player playerlinkto(level.cam_org,"",(1,1,1));
		wait 0.1;
		level.player setplayerangles((0,0,0));
		wait 1;
	}

	level thread test_cam();
	println("PLAYER STANCE = ", level.player getstance());

	for(i=1;i<(level.cam_org.count + 1);i++)
	{
//		println("I = ",i);
//		level thread Cam_Line();
		level notify("camera_" + i + "_started");

		if(i==1)
		{
			level thread End_FadeOut(level.black_screen, 1);
		}
		else
		{
			level thread End_FadeOut(level.black_screen, 0.1);
		}

		level.cam_org.angles = level.cam_org.start_angle[i];
		level.cam_org.origin = level.cam_org.start_pos[i];
//		level.player setplayerangles(level.cam_org.angles);

//		println("^5level.player.angles = ", level.player.angles, " ^5tag_angles = ",level.cam_org.angles);
//		level thread Camera_Angles_Think(level.cam_org);

		level thread End_FadeOut(level.black_screen, 0.25, 0.5);

		if(isdefined(level.cam_org.start_delay[i]))
		{
			wait level.cam_org.start_delay[i];
		}

//		setcvar("cg_fov",level.cam_org.fov[i]);
		if(isdefined(level.cam_org.fov))
		{
			level thread Camera_fov(level.cam_org.fov[i]);
			accel = true;
		}

		if(isdefined(level.cam_org.end_pos[i]))
		{
			if(level.cam_org.end_pos[i] == "locomotive")
			{
				level thread Camera_Shake(level.cam_org.move_time[i]);
				level.cam_org.origin = ((level.locomotive.origin[0] + level.cam_org.start_pos[i][0]), (level.locomotive.origin[1] + level.cam_org.start_pos[i][1]), (level.locomotive.origin[2] + level.cam_org.start_pos[i][2]));
				level.cam_org linkto(level.locomotive);
			}
			else
			{
				if(isdefined(accel))
				{
					level.cam_org moveto(level.cam_org.end_pos[i], level.cam_org.move_time[i], 1, 0);					
				}
				else
				{
					level.cam_org moveto(level.cam_org.end_pos[i], level.cam_org.move_time[i], 0, 0);
				}
			}
		}

		if(isdefined(level.cam_org.shake[i]))
		{
			level thread Camera_Shake(level.cam_org.shake[i]);
		}

		if(isdefined(level.cam_org.end_angles[i]))
		{
			level.cam_org rotateto(level.cam_org.end_angles[i], level.cam_org.move_time[i], 0, 0);
		}

		wait (level.cam_org.move_time[i] - 0.2);

		if(i != level.cam_org.count)
		{
			level thread End_Fadein(level.black_screen, 0.1);
		}

		wait 0.2;

		if(level.cam_org.end_pos[i] == "locomotive")
		{
			level.cam_org unlink();			
		}
	}

	level.camera_in_use = false;
	//level.player freezeControls(false);

	level.cam_org.angles = level.cam_org.angles;

	level thread End_Fadein(level.black_screen, 2);
	
	wait 3;
		
	setcvar("cg_hudcompassvisible", "1");
	setcvar("cg_drawStatus", "1");
	setcvar("cg_draw2d", "1");
	setcvar("cg_fov", "80");
	setcvar("cg_drawgun", "1");
		
	return;

//	wait 15;
//	level.player unlink();
}

test_cam()
{
	while(1)
	{
		level.cam_org rotateto((level.cam_org.angles + (0,90,0)), 0.5, 0,0);
		level.cam_org waittill("rotatedone");
	}
}

Camera_fov(fov, time)
{
	level notify("end_camera_fov");
	level endon("end_camera_fov");

	currentfov = getcvarfloat("cg_fov");
	time = 5;

	if(currentfov == fov)
	{
		return;
	}

	ratio = ((time * 1000) / 20);
	
	if(currentfov > fov)
	{
		num = (currentfov - fov) / ratio;
		while(currentfov > fov)
		{
			currentfov -= num;
			setcvar("cg_fov",currentfov);
			wait 0.05;
		}
	}
	else
	{
		num = (fov - currentfov) / ratio;
		while(currentfov < fov)
		{
			currentfov += num;
			setcvar("cg_fov",currentfov);
			wait 0.05;
		}
	}
}

Camera_Shake(time)
{
	if(time == "ramp")
	{
		wait 3;
		time = 6;
	}

	timer = gettime() + (time * 1000);
	println("^2Camera Shake Timer: ",timer);
	while(timer > gettime())
	{
		println("^2Camera Shake Timer: ",timer);
		m = randomfloat(0.12);
		//earthquake(scale, duration, source, radius);
		earthquake(m, 0.5, level.player.origin, 1000);
		wait 0.25;
	}
}

// This semi fixes the camera not aligning correct... Cheap hack.
Camera_Angles_Think(camera)
{
	level endon("stop_camera_angles_think");
	while(1)
	{
		tag_angles = camera.angles;
		level.player setplayerangles(tag_angles);
		wait 0.1;
	}
}

Cam_Line()
{
	while(1)
	{
		pos1 = level.cam_org.origin;
		tag_angles = level.cam_org.angles;
		forward = anglestoforward(tag_angles);
		pos2 = pos1 + maps\_utility_gmi::vectorScale(forward, 1000);
		line(pos1, pos2, (1,1,1));
		wait 0.06;
	}
}

player_angles()
{
	time = 3000 + gettime();

	num = 360;
	while(1)
	{
		if(isdefined(level.cam_org))
		{
			println("^5level.player.angles = ",level.player.angles, " ^5level.cam_org.angles = ",level.cam_org.angles);
		}
		else
		{
			println("^5level.player.angles = ",level.player.angles);
		}
	
		wait 0.05;

//		if(time < gettime())
//		{
//			println("UPDATED!");
////			level.player.angles += (0,45,0);
//			num += 45;
//			angles = (0,num,0);
//			level.player setplayerangles(angles);
//			time += 3000;
//		}
	}
}

Turret_Missionfail_Tracker(ai)
{
	level endon ("mission failed");
	
	if ((!isSentient (ai)) || (!isalive (ai)))
	{
		return;
	}
		
	if (ai.team == "axis")
	{
		ai waittill ("death",other);

		if (isdefined (other))
		{
			if(Missionfail_Check_Other(other))
			{
				level.killedaxis++;
			}
		}
	}
	else if (ai.team == "allies")
	{
		thread Turret_Killfriends_Damage_Think(ai);

		ai waittill ("death",other);

		if (isdefined (other))
		{
			if(Missionfail_Check_Other(other))
			{
				println("^1--- TURRET IS KILLING FRIENDS! --- ^3level.kharkov2_turret_kills: ",level.kharkov2_turret_kills);

				if ( (isdefined(ai)) && (isdefined (ai.failWhenKilled)) && (ai.failWhenKilled == false) )
				{
					return;
				}
				else// If the player was the one who killed the friendly
				{
					// If the player kills more than 3 AI, then fail him!
					if(level.kharkov2_turret_kills > 3)
					{
						thread maps\_spawner_gmi::killfriends_missionfail();
					}
					else
					{
						level.kharkov2_turret_kills++;
						level.ffpoints = 0;
						level.killedaxis = 0;
					}
				}
			}
		}	
	}
}

Turret_Kill_Dec()
{
	while(1)
	{
		if(level.kharkov2_turret_kills > 0)
		{
			level.kharkov2_turret_kills--;
		}
		wait 15;
	}
}

Turret_Killfriends_Damage_Think(ai)
{
	level endon("End_The_Level");
	level endon ("mission failed");
	ai endon ("death");
//	println("AI TARGETNAME : ",ai.targetname);

	if ((isdefined (ai)) && (isalive (ai)))
	{
		while (1)
		{
			ai waittill ("damage",damage,attacker);

			if (!Missionfail_Check_Other(attacker))
			{
				continue;
			}
			
			if ((!isdefined (damage)) || (!isdefined (attacker)) )
			{
				continue;
			}
			
			if ((isdefined (ai.failWhenKilled)) && (ai.failWhenKilled == false) )
			{
				continue;
			}
			else
			{
				level.ffpoints = (level.ffpoints + (damage * 0.5));
				println("^1--- TURRET IS DAMAGING FRIENDS! --- ^3(level.ffpoints): ",level.ffpoints);
				
				if ( (level.ffpoints >= 600) && (level.killedaxis < 4) )
				{
					thread maps\_spawner_gmi::killfriends_missionfail();
					return;
				}
				else if ( (level.ffpoints >= 600) && (level.killedaxis >= 4) )
				{
					level.ffpoints = 0;
					level.killedaxis = 0;
				}
			}
		}
	}
}

Missionfail_Check_Other(other)
{
	if(other == level.anti_air1 || other == level.anti_air2 || other == level.flak88)
	{
		return true;
	}
	else
	{
		return false;
	}
}

// Able to spawn any vehicle.
Vehicle_Spawner(type, start_node, delay, health, start_sound, vehicle_num, spawn_delay, squad_name)
{
	if(isdefined(delay))
	{
		println("(Vehicle Spawner): Delaying...");
		wait delay;
	}

	if(!isdefined(vehicle_num))
	{
		vehicle_num = 1;
	}

	if(!isdefined(spawn_delay))
	{
		spawn_delay = 2;
	}

//	path = getvehiclenode(start_node,"targetname");
	path = start_node;

	println("(Vehicle_Spawner) Type: ",type);
	println("(Vehicle_Spawner) Start_Node: ",start_node);
	println("(Vehicle_Spawner) Health: ",health);
	println("(Vehicle_Spawner) Squad_Name: ",squad_name);

	for(i=0;i<vehicle_num;i++)
	{
		if(isdefined(type))
		{
			if(type == "he111")
			{
				vehicle = spawnvehicle("xmodel/v_ge_air_he111","He111","C47",path.origin,path.angles);
				vehicle thread maps\_he111_gmi::init(health);
//				vehicle.bomb_sound_every = 3;

				if(getcvarint("scr_gmi_fast") < 1)
				{
					vehicle.bomb_fx_every = 2;
				}
				if(getcvarint("scr_gmi_fast") == 1)
				{
					vehicle.bomb_fx_every = 3;
				}
				else if(getcvarint("scr_gmi_fast") > 1)
				{
					vehicle.bomb_fx_every = 4;
				}
			}
			else if(type == "event9_he111")
			{
				vehicle = spawnvehicle("xmodel/v_ge_air_he111","He111","C47",level.player.origin,path.angles);
				vehicle thread maps\_he111_gmi::init(health);
				vehicle thread Event9_He111_Damage_Think();
				vehicle thread Event9_He111_Death_Think();
				no_endon = true;
				vehicle.inflight = true;
				if(isdefined(squad_name))
				{
					vehicle.targetname = squad_name;
				}

				vehicle thread Plane_Crash_Sound();
			}
			else if(type == "event9_he111_tracker")
			{
				vehicle = spawnvehicle("xmodel/v_ge_air_he111","He111","C47",path.origin,path.angles);
				vehicle thread maps\_he111_gmi::init(health);
				vehicle thread Event9_He111_Damage_Think();
				vehicle thread Event9_He111_Death_Think();
				level thread Event9_He111_Pos_Tracker(vehicle);
				vehicle.inflight = true;
				no_endon = true;
				if(isdefined(squad_name))
				{
					vehicle.targetname = squad_name;
				}

				vehicle thread Plane_Crash_Sound();
			}
			else if(type == "event9_tank3")
			{
				vehicle = spawnvehicle("xmodel/vehicle_tank_panzeriv","event9_tank3","PanzerIV",path.origin,path.angles);
				vehicle thread maps\_panzerIV_gmi::init();
				level.event9_tank3 = vehicle;
				vehicle.health = health;
				vehicle thread Tank_Health_Regen(100000);
			}
			else if(type == "T34")
			{
				vehicle = spawnvehicle("xmodel/vehicle_tank_t34","event9_t34","T34",path.origin,path.angles);
				vehicle thread maps\_t34_gmi::init();

				if(health == "regen")
				{
					vehicle.health = 1000;
					vehicle thread Tank_Health_Regen(100000);
				}
				else
				{
					vehicle.health = health;
				}

				if(isdefined(path.name_tank) && path.name_tank)
				{
					vehicle.targetname = "event9_t34_shooter";
				}
			}
			else if(type == "T34_noturret")
			{
				vehicle = spawnvehicle("xmodel/vehicle_tank_t34","event9_t34","T34",path.origin,path.angles);
				vehicle thread maps\_t34_gmi::init("no_turret");

				if(health == "regen")
				{
					vehicle.health = 1000;
					vehicle thread Tank_Health_Regen(100000);
				}
				else
				{
					vehicle.health = health;
				}

				if(isdefined(path.name_tank) && path.name_tank)
				{
					vehicle.targetname = "event9_t34_shooter";
				}
			}
			else if(type == "T34_noturret")
			{
				vehicle = spawnvehicle("xmodel/vehicle_tank_t34","event9_t34","T34",path.origin,path.angles);
				vehicle thread maps\_t34_gmi::init("no_turret");

				if(health == "regen")
				{
					vehicle.health = 1000;
					vehicle thread Tank_Health_Regen(100000);
				}
				else
				{
					vehicle.health = health;
				}

				if(isdefined(path.name_tank) && path.name_tank)
				{
					vehicle.targetname = "event9_t34_shooter";
				}
			}
			else if(type == "panzeriv")
			{
				vehicle = spawnvehicle("xmodel/vehicle_tank_panzeriv","panzeriv","PanzerIV",path.origin,path.angles);
				vehicle thread maps\_panzerIV_gmi::init();
				vehicle thread Tank_Death_Think();
			}
			else if(type == "panzeriv_end")
			{
				vehicle = spawnvehicle("xmodel/vehicle_tank_panzeriv","panzeriv","PanzerIV",path.origin,path.angles);
				vehicle thread maps\_panzerIV_gmi::init();
				vehicle thread Tank_Death_Think();
			}
			else if(type == "halftrack")
			{
				vehicle = spawnvehicle("xmodel/v_ge_lnd_halftrack","halftrack","halftrack",path.origin,path.angles);
				if(isdefined(squad_name))
				{
					vehicle.script_squadname = squad_name;
				}
				vehicle thread maps\_halftrack_gmi::init("reached_end_node");
				vehicle thread HalfTrack_Death_Think();
			}
			else if(type == "tiger")
			{
				vehicle = spawnvehicle("xmodel/vehicle_tank_tiger","tiger","tiger",path.origin,path.angles);
				vehicle thread maps\_tiger_gmi::init();
				vehicle thread Tank_Death_Think();
			}
			else if(type == "tiger_end")
			{
				vehicle = spawnvehicle("xmodel/vehicle_tank_tiger","tiger","tiger",path.origin,path.angles);
				vehicle thread maps\_tiger_gmi::init();
				vehicle thread Tank_Death_Think();
			}
			else if(type == "stuka")
			{
				vehicle = spawnvehicle("xmodel/vehicle_plane_stuka","Stuka","Stuka",path.origin,path.angles);
				vehicle.script_noteworthy = "noturrets";
				vehicle maps\_stuka_gmi::init(4, health);
				vehicle thread Event11_Stuka_Damage_Think(health);

				if(path.targetname != "flyby")
				{
					level thread Event11_Yell("stuka", 1);
				}
			}
			else if(type == "il2")
			{
				vehicle = spawnvehicle("xmodel/v_rs_air_il2","Il2","Stuka",path.origin,path.angles);
				vehicle.script_noteworthy = "noturrets";
				vehicle maps\_stuka_gmi::init(undefined, health);
			}
		}
		else
		{
			println("^1Tried to spawn a vehicle, without specifying the type");
			return;
		}

//		level thread do_print3d(vehicle, pos, "health", (1,1,1), 10000, 3);

		println("^3" + type + " on it's Way, along path: " + path.targetname);

		vehicle notify("wheelsup");
		vehicle notify("takeoff");

		vehicle.attachedpath = path;
		vehicle attachPath(path);
		vehicle startpath();

		if(isdefined(start_sound))
		{
			if(isdefined(path.script_delay))
			{
				sound_delay = path.script_delay;
			}
			vehicle thread Vehicle_Sound(start_sound, sound_delay);
		}

		vehicle thread Pathnode_Think(no_endon);

		wait spawn_delay;
	}

	if(type == "event9_he111")
	{	 
		vehicle waittill("reached_end_node");
		if(isalive(vehicle))
		{
			vehicle delete();
		}
	}

	if(type == "panzeriv_end" || type == "tiger_end")
	{
		wait 0.1;
		vehicle thread maps\_tankgun_gmi::mgoff();
	}
}

Vehicle_Sound(sound, delay)
{
	self endon("death");
	if(isdefined(delay))
	{
		wait delay;
	}

	if(sound == "bomber_loop_01" || sound == "bomber_loop_02" || sound == "bomber_loop_03")
	{
		level thread Event9_He111_Sound(self, sound);
	}
	else
	{
		println("^2Playing Sound: ",sound);
		self playsound(sound);
	}
}

// Used for all vehicles in the level...
// When a vehicle gets to a specific node, it will do what we want. I.E. Fire, animate, etc.
Pathnode_Think(no_endon)
{
	if(!isdefined(no_endon) || !no_endon)
	{
		self endon("death");
	}

	self endon("stop_tank_think");

	if(!isdefined(self.attachedpath))
	{
		println("^1NO '.ATTACHEDPATH' FOUND FOR TANK, ",self.targetname);
		return;
	}

	self thread EndNode_Think();

	pathstart = self.attachedpath;

	pathpoint = pathstart;

	// Find all of the crash_paths.
	crash_paths = getvehiclenodearray("crash_path", "targetname");

//println("^5Crash_paths.size ", crash_paths.size);
	while(isdefined (pathpoint))
	{
		shorterdist = 128;
		for(i=0;i<crash_paths.size;i++)
		{
			length = distance(crash_paths[i].origin,pathpoint.origin);
//println("^6Length = ",length);
			if(length < shorterdist)
			{
				theone = crash_paths[i];
				shorterdist = length;
			}
		}
		if(isdefined(theone))
		{
//println("^5Theone is specified!");
			pathpoint.crash_path_target = theone;
			theone = undefined;
		}
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

	// Checks to see if there is a script_noteworthy on each node for the tank.
	for(i=0;i<pathpoints.size;i++)
	{
		if(isdefined(pathpoints[i].crash_path_target))
		{
			switchnode = pathpoints[i].crash_path_target;
			if(isdefined (switchnode))
			{
				self setWaitNode(pathpoints[i]);
				self.crashing_path = switchnode;
//				self thread draw_crash_path();
				self waittill ("reached_wait_node");

				waited = true;  //do multiple things on one node
				if(self.health <= 0 || (isdefined(switchnode.script_noteworthy) && switchnode.script_noteworthy == "forcedcrash"))
				{
println("^5Plane Crashing!");
//					if((!isdefined (switchnode.derailed)) || (isdefined(switchnode.script_noteworthy) && switchnode.script_noteworthy == "planecrash"))
//					{
						self notify ("crashpath");
//						switchnode.derailed = 1;
						self setSwitchNode (pathpoints[i],switchnode);
						self thread SwitchNode_Think(switchnode);
						return; // since it switch paths, stop threading this function. 
//					}
				}
			}
		}

		if(isdefined(pathpoints[i].script_noteworthy))
		{
			self setWaitNode(pathpoints[i]);
			self waittill ("reached_wait_node");

			if(isdefined(self.skipto) && self.skipto > 0)
			{
				self.skipto--;
				continue;
			}
//			else if(isdefined(self.skipto) && self.skipto == 0)
//			{
//				self resumespeed (10000000000);
//				wait 0.1;
//			}

			if(pathpoints[i].script_noteworthy == "tank_waitnode")
			{
				self setspeed (0, 5);
				println(self.targetname," ^5Reached WAIT Node");
				self notify("reached_specified_waitnode");
				self disconnectpaths();
				level waittill("T34s_go"); // If you put in the while, take this out.

				println("^2T34s Go!");
				self resumespeed (10);
				self connectpaths();
			}
			else if(pathpoints[i].script_noteworthy == "mg_on")
			{
				self thread maps\_tankgun_gmi::mgon();
			}
			else if(pathpoints[i].script_noteworthy == "mg_off")
			{
				self thread maps\_tankgun_gmi::mgoff();				
			}
			else if(pathpoints[i].script_noteworthy == "event8_group2_chain2_cover")
			{
				self setspeed (0, 5);
				println(self.targetname," ^5Reached WAIT Node");
				self notify("reached_specified_waitnode");
				self disconnectpaths();

//				while(self.speed > 0)
//				{
//					wait 0.05;
//				}
//
//				println("Tank: ",self.targetname);
//				println("Tank Origin: ",self.origin);
//				println("Tank Angles: ",self.angles);
//				println("");

				while(self.speed > 0)
				{
					wait 0.25;
				}

				if(isalive(level.group2_commander))
				{
					level.group2_commander setfriendlychain(getnode(pathpoints[i].script_noteworthy,"targetname"));
				}

				level waittill("T34s_go"); // If you put in the while, take this out.

				println("^2T34s Go!");
				self resumespeed (10);
				self connectpaths();
			}
			else if(pathpoints[i].script_noteworthy == "drop_bombs")
			{
				//drop_bombs(amount, delay, delay_trace, damage_range, max_damage, min_damage)
				println("DROP BOMBS!!!");
				self thread maps\_he111_gmi::drop_bombs();
			}
			else if(pathpoints[i].script_noteworthy == "event8_drop_bombs")
			{
				//drop_bombs(amount, delay, delay_trace, damage_range, max_damage, min_damage)
				println("DROP BOMBS!!!");
				self.bomb_sound_number = 3; // So not every bomb makes an explosion sound.
				self thread maps\_he111_gmi::drop_bombs(undefined, undefined, 3);
			}
			else if(pathpoints[i].script_noteworthy == "event8_building2")
			{
				target = getent(pathpoints[i].script_noteworthy + "_target","targetname");
				target.rumble = true;
//					    Tank_Fire_Turret(targetent, targetpos, start_delay, shot_delay, offset, validate, fake_fire)
				self thread Tank_Fire_Turret(target, undefined, undefined, 0, undefined, false, true, true);
				self thread Event8_Blow_Building2();
			}
			else if(pathpoints[i].script_noteworthy == "event8_building1")
			{
				self setspeed (0, 5);
				println(self.targetname," ^5Reached WAIT Node");
				self notify("reached_specified_waitnode");
				self disconnectpaths();

				if(getcvarint("sv_cheats") > 0 && getcvar("skipto_event9") != 1 && getcvar("skipto_event10") != 1)
				{
					trigger = getent("event8_blow_building1_check","targetname");
					trigger waittill("trigger");
				}

				target = getent(pathpoints[i].script_noteworthy + "_target","targetname");
				target.rumble = true;
//					    Tank_Fire_Turret(targetent, targetpos, start_delay, shot_delay, offset, validate, fake_fire)
				self thread Tank_Fire_Turret(target, undefined, undefined, 0, undefined, false, true, true);

				self thread Event8_Building1_Dialogue();

				level waittill("T34s_go"); // If you put in the while, take this out.
				println("^2T34s Go!");
				self resumespeed (10);
				self connectpaths();
			}
			else if(pathpoints[i].script_noteworthy == "event9_carcrush")
			{
				level thread Event9_CarCrush();
			}
			else if(pathpoints[i].script_noteworthy == "event9_tank1" || pathpoints[i].script_noteworthy == "event9_tank3")
			{
				tank = getent(pathpoints[i].script_noteworthy, "targetname");
				if(pathpoints[i].script_noteworthy == "event9_tank3")
				{
					tank notify("stop_health_regen");
				}
				wait 0.1;
				tank.health = 100;
				target = getent(pathpoints[i].script_noteworthy + "_target", "targetname");
				self thread Tank_Fire_Turret(target, undefined, undefined, 3, undefined, false, true, true);
			}
			else if(pathpoints[i].script_noteworthy == "event9_drop_bombs")
			{
				if(self.health <= 0)
				{
					continue;
				}
				//drop_bombs(amount, delay, delay_trace, damage_range, max_damage, min_damage)
				println("DROP BOMBS!!!");
//				wait (randomfloat(2));
				self thread maps\_he111_gmi::drop_bombs(undefined, 1.5, 1, 768);

				self thread Event9_Bomb_Sound();
			}
			else if(pathpoints[i].script_noteworthy == "event9_reset")
			{
				// Resets the tanks gun and puts them in god mode.
				self thread Tank_Health_Regen(100000);
				self thread Tank_Reset_Turret(self);
			}
			else if(pathpoints[i].script_noteworthy == "stuka_drop_bombs")
			{
				println("DROP BOMBS!!!");
				if(isdefined(pathpoints[i].script_delay))
				{
					wait (pathpoints[i].script_delay);
				}
				// drop_bombs(amount, delay, delay_trace, damage_range, max_damage, min_damage, trace_dist)
				self thread maps\_stuka_gmi::drop_bombs(undefined, 0.5, 0.5, 768);
			}
			else if(pathpoints[i].script_noteworthy == "stuka_drop_bombs_fast")
			{
				println("DROP BOMBS!!!");
				if(isdefined(pathpoints[i].script_delay))
				{
					wait (pathpoints[i].script_delay);
				}
				// drop_bombs(amount, delay, delay_trace, damage_range, max_damage, min_damage, trace_dist)
				self thread maps\_stuka_gmi::drop_bombs(undefined, 0.25, 0.25, 1024);
			}
			else if(pathpoints[i].script_noteworthy == "event11_axis_tank_fire")
			{
				fake_targets = getentarray("event11_axis_tank_target","targetname");
				self Tank_Add_Targets(fake_targets);
				target[0] = level.player;
				self Tank_Add_Targets(target);
				self thread Tank_Turret_Think(3, 7, true);
			}
			else if(pathpoints[i].script_noteworthy == "event11_allies_tank_fire")
			{
				fake_targets = getentarray("event11_allies_tank_target","targetname");
				self Tank_Add_Targets(fake_targets);
				self thread Tank_Turret_Think(3, 7, true);
			}
			else if(pathpoints[i].script_noteworthy == "event11_t34_reset")
			{
				// Resets the tanks gun and puts them in god mode.
				self endon("stop_turret_think");
				self thread Tank_Reset_Turret(self);
			}
		}
	}
}

EndNode_Think()
{
	self waittill("reached_end_node");
	self disconnectpaths();
	println("REACHED END NODE: ",self.origin," ",self.angles);

	if(self.targetname == "t34_1" || self.targetname == "t34_2")
	{
		println(self.targetname," ^1DEATHROLLOFF!!!!");
		self notify("deathrolloff");
		self.rollingdeath = undefined;
	}

	if(self.targetname == "event9_tank3")
	{
		fake_targets = getentarray("event9_german_fake_targets","targetname");

		the_targets = [];
		println("fake_targets.size Before ",fake_targets.size);
		for(i=0;i<fake_targets.size;i++)
		{
			if(isdefined(fake_targets[i].groupname) && fake_targets[i].groupname != "event9_engineer_tank_targets")
			{
				the_targets[the_targets.size] = fake_targets[i];
			}
			else if(!isdefined(fake_targets[i].groupname))
			{
				the_targets[the_targets.size] = fake_targets[i];
			}
		}
		println("fake_targets.size After ",the_targets.size);
		self Tank_Add_Targets(the_targets);
		self thread Tank_Turret_Think(3, 7, true);


		// TESTING!
//		level thread testing_tanks();
	}

	if(isdefined(self.crash_sound))
	{
		self stopLoopSound(self.crash_sound);
	}	
}

SwitchNode_Think(start_node)
{
	pathpoint = start_node;
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

	// Checks to see if there is a script_noteworthy on each node for the tank.
	for(i=0;i<pathpoints.size;i++)
	{
		if(isdefined(pathpoints[i].script_noteworthy))
		{
			self setWaitNode(pathpoints[i]);
			self waittill ("reached_wait_node");

			if(pathpoints[i].script_noteworthy == "plane_delete")
			{
				self notify("reached_end_node");
			}
			else if(pathpoints[i].script_noteworthy == "plane_explode")
			{
				self.crashfx = loadfx ("fx/explosions/vehicles/he111_bomb.efx");
				self notify("reached_end_node");
			}
		}
	}

	if(isdefined(self.crash_sound))
	{
		self stopLoopSound(self.crash_sound);
	}
}

Plane_Crash_Sound()
{
	self waittill("death");

	random_sound = randomint(2);
	if(random_sound == 0)
	{
		if(isdefined(self.org_sound))
		{
//			blend = spawn( "sound_blend",self.org_sound.origin);
//			blend linkto(self);
			self.org_sound playsound("bomber_die_01");
			self.crash_sound = "bomber_die_01";
			wait 2;
			self.org_sound stoploopsound(self.org_sound.sound);

//			for(i=0.1;i<1.1;i+=0.1)
//			{
//				blend setSoundBlend(self.org_sound.sound, "bomber_die_01", i);
//				wait 0.5;
//			}
		}
		else
		{
			self playsound("bomber_die_01");
			self.crash_sound = "bomber_die_01";
		}
	}
	else
	{
		if(isdefined(self.org_sound))
		{
//			blend = spawn( "sound_blend",self.org_sound.origin);
//			blend linkto(self);
			self.org_sound playsound("bomber_die_02");
			wait 2;
			self.org_sound stoploopsound(self.org_sound.sound);
			self.crash_sound = "bomber_die_01";

//			for(i=0.1;i<1.1;i+=0.1)
//			{
//				blend setSoundBlend(self.org_sound.sound, "bomber_die_02", i);
//				wait 0.5;
//			}
		}
		else
		{
			self playsound("bomber_die_02");
			self.crash_sound = "bomber_die_01";
		}
	}
}

HalfTrack_Death_Think()
{
	self waittill("death");
	wait 30;
	self connectpaths();
	wait 0.25;
	if(isdefined(self.mgturret))
	{
		self.mgturret delete();
	}
	stopattachedfx(self);
	wait 0.5;
	self delete();
}

// Use for event11
Tank_Death_Think()
{
	if(level.flag["event11_started"])
	{
		self waittill("death");
		level.event11_tank_count--;
		objective_string(8, &"GMI_KHARKOV2_OBJECTIVE8", level.event11_tank_count);
		if(level.event11_tank_count == 0)
		{
			level notify("objective 8 complete");
		}

	}
}

// Grabs all of distant lights and has them run the think function.
Ambience_Setup()
{
	if (getcvarint("scr_gmi_fast") < 1)
	{
		orgs = getentarray("distant_light","targetname");
		for(i=0;i<orgs.size;i++)
		{
			orgs[i] thread Random_Distant_Light_Think();
			wait 0.05;
		}

		tracers = getentarray("anti_air_tracers","targetname");
		for(i=0;i<tracers.size;i++)
		{
			if(isdefined(tracers[i].script_noteworthy))
			{
				maps\_fx_gmi::gunfireLoopfx("antiair_tracers", tracers[i].origin, 3, 7, 7, 13, 2, 3, tracers[i].script_noteworthy);
			}
			else
			{
				maps\_fx_gmi::gunfireLoopfx("antiair_tracers", tracers[i].origin, 3, 7, 7, 13, 2, 3, "stop_anti_air_fx");
			}
		}

		sound_orgs = getentarray("sound_origin","targetname");
		for(i=0;i<sound_orgs.size;i++)
		{
			sound_orgs[i] thread Looping_Sound_Ambience();
		}
	}
	else
	{
		return;
	}
}

Looping_Sound_Ambience()
{
	if(!isdefined(self.script_sound))
	{
		println("^1(Looping_Sound_Ambience): Sound Origin without a .script_sound (aborting...)");
		return;
	}

	self playLoopSound ( self.script_sound );
}

// Think function for distant_light script_origins.
// Randomly plays the lights in the sky.
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
//		self playsound("shell_flash");
	}
}

//----------------------//
// --- Tank Section --- //
//----------------------//

// Tank turrets Random looking around
Tank_Turret_Random_Turning()
{
	self endon("death");
	self endon("stop_random_turret_turning");

	self.random_turret_think = true;

	// Yaw depending on world angles, not self.angles.
	if(!isdefined(self.min_yaw))
	{
		self.min_yaw = 45;
	}

	if(!isdefined(self.max_yaw))
	{
		self.max_yaw = 135;
	}

	if(!isdefined(self.use_self_angles))
	{
		self.use_self_angles = false;
	}

	self thread Tank_Turret_Random_Turning_Think();

	random_yaw = 0;

	while(1)
	{
//		println("^5self.min_yaw: ",self.min_yaw);
//		println("^5self.max_yaw: ",self.max_yaw);

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

	while(1)
	{
		self waittill("stop_random_turret_turning");
		self.random_turret_think = false;

		self waittill("start_random_turret_turning");
		self.random_turret_think = true;
		self thread Tank_Turret_Random_Turning();
	}
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
	if(target.size > 0)
	{
//		println("^4(Tank_Remove_Target) Before ",self.enemy_targets.size);
		self.enemy_targets = maps\_utility_gmi::array_remove(self.enemy_targets, target);
//		println("^4(Tank_Remove_Target) After ",self.enemy_targets.size);
	}
}

// Finds the closest living enemy tank and fires at it.
Tank_Turret_Think(min_delay, max_delay, random_target)
{
	self endon("death");
	self endon("stop_turret_think");

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

		if(isdefined(self.is_firing) && self.is_firing)
		{
			wait 0.25;
			continue;
		}

		if(isdefined(target))
		{
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
				accuracy = (0,0,64);
			}

			if(isdefined(target.script_noteworthy))
			{
				if(target.script_noteworthy == "fake_target")
				{
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
//		if(isdefined(self.enemy_targets))
//		{
//			println("self.enemy_targets.size = ",self.enemy_targets.size);
//		}

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
//				println("^3(Tank_Get_Closest_Target) Tank  (" + i + ") is dead");
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
	if(isdefined(validate) && (validate))
	{
		valid = self Tank_Validate_Target(targetent, "tag_flash", (0,0,64));
		if(!valid)
		{
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
		playfxontag(level.fake_turret_fx, self, "tag_flash");
		self playsound("t34_fire");

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
				//if (getcvarint("scr_gmi_fast") < 2)
				//{
					level thread maps\_utility_gmi::exploder(targetent.script_exploder);
				//}
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

				if (getcvarint("scr_gmi_fast") < 2)
				{
					level thread maps\_fx_gmi::OneShotfx(targetent.script_fxid, targetent.origin, targetent.script_delay, org);
				}
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

				
				if (getcvarint("scr_gmi_fast") >= 2)
				{
					playfx (level.mortar_low, targetent.origin);
				}
				else
				{
					playfx (level.mortar, targetent.origin);
				}
				earthquake(0.15, 2, targetent.origin, 850);
				radiusDamage (targetent.origin, 512, 400,  1);
			}

			if(isdefined(targetent.script_noteworthy) && targetent.script_noteworthy != "fake_target")
			{
				level thread Falling_Debris(targetent.script_noteworthy);
			}
		}
	}

	self.is_firing = false;

	if(isdefined(random_turning))
	{
		if(random_turning == "start_turret_think_random")
		{
			self thread Tank_Turret_Think(min_delay, max_delay, true);
		}
		else if(random_turning == true)
		{
			wait 2;
			if(!isdefined(self.min_yaw))
			{
				self thread Tank_Turret_Random_Turning();
			}
			else
			{
				self notify("start_random_turret_turning");
			}
		}
	}
}

// Resets the Tank's Turret
Tank_Reset_Turret(tank, delay)
{
	tank notify("stop_random_turret_turning");

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

// Resets the tanks health back to the health it spawn in with.
Tank_Health_Reset(health)
{
	self waittill("stop_health_regen");
	self.health = self.old_health;
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

//		println("^3tank.min_yaw: ",tank.min_yaw);
//		println("^3tank.max_yaw: ",tank.max_yaw);

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

// Certain triggers will tell the tanks to move forward.
Setup_T34_Go_Triggers()
{
	triggers = getentarray("t34_go","groupname");
	println("^5(Setup_T34_Go_Triggers): Triggers.size = ",triggers.size);
	wait 0.5;
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread T34_Go_Trigger_Think();
	}
}

// Think function for each T34_Go_Trigger
T34_Go_Trigger_Think()
{
	self waittill("trigger");
	println("^3(T34_Go_Trigger_Think): t34s go!!!");
	// May need to add a check to make sure all tanks have stopped moving.

	level notify("T34s_go");
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

//--------------------------//
// --- End Tank Section --- //
//--------------------------//


Setup_Fire_Trigger_Damage()
{
	level.player_on_fire = false;
//	triggers = getentarray("fire_hurt_trigger","targetname");
//	for(i=0;i<triggers.size;i++)
//	{
//		triggers[i] thread Fire_Trigger_Think();
//	}

	org[0] = (-609, 1606, -89);
	radius[0] = 100;
	ender[0] = "stop_fx_think1";

	org[1] = (-1800, 325, 90);
	radius[1] = 100;
	ender[1] = undefined;

	org[2] = (369, 8189, -98);
	radius[2] = 200;
	ender[2] = undefined;

	org[3] = (3598, 8473, 54);
	radius[3] = 100;
	ender[3] = undefined;

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

Music()
{
	if((getcvarint("sv_cheats") > 0) && (getcvarint("end_cine") == 1))
	{
		level waittill("start_end_music");
		println("^3MusicPlay: kharkov2_victory");
		musicplay("kharkov2_victory");
		level thread print_timer(97);
		wait 97;
		println("REALLY END THE LEVEL!");
		level notify("Really_End_The_Level");
		musicstop();
		return;
	}
	musicplay("kharkov2_start");
	level waittill("stop_music1");
	musicstop(5);

	level waittill("start_music2");
	musicplay("kharkov2_battle");
	level thread print_timer(117);
	wait 117;
	musicstop(3);

	level waittill("start_end_music");
	println("^3MusicPlay: kharkov2_victory");
	musicplay("kharkov2_victory");
	wait 97;
	level notify("Really_End_The_Level");
	musicstop();
}

print_timer(count)
{
	while(count > 0)
	{
		wait 1;
		count--;
		println("^2Print Timer: ",count);
	}
}

Setup_Falling_Facades()
{
	dmg_triggers = getentarray("falling_facade","targetname");

	println("^5(Setup_Falling_Facades): dmg_triggers.size = ",dmg_triggers.size);

	for(i=0;i<dmg_triggers.size;i++)
	{
		dmg_triggers[i] thread Falling_Facades_Think();
	}
}

Falling_Facades_Think()
{
	self thread Falling_Facades_Dmg_Think();
	self waittill("fall_down");
	println("Facade took Damage!!!!");
	
	facade = getent(self.target,"targetname");

//	facade moveGravity ((0,0,0), 8);
	facade moveto((facade.origin[0], facade.origin[1], (facade.origin[2] - 5000)), 8, 7, 0);

	if(isdefined(facade.script_noteworthy))
	{
		if(facade.script_noteworthy == "roll")
		{
			facade rotateto(((30 - randomint(30)), (45 - randomint(45)), 0), 3, 2, 0);
		}
		else if(facade.script_noteworthy == "pitch")
		{
			facade rotateto((0, (45 - randomint(45)), (15 - randomint(15))), 3, 2, 0);
		}
		else
		{
			facade rotateto(((30 - randomint(30)), (45 - randomint(45)), (30 - randomint(30))), 3, 2, 0);
		}
	}
	else
	{
		facade rotateto((0, (45 - randomint(45)), (15 - randomint(15))), 5, 4, 0);	
	}

	wait 11;
	facade delete();
	self delete();
}

Falling_Facades_Dmg_Think()
{
	overall = 0;
	while(1)
	{
		
		self waittill("damage", dmg);
		overall += dmg;
		println("^1 I AM DAMAGED! ",dmg,"^2 Total damage: ",overall, "^2 COunt = ",self.count);
		if(overall >= self.count)
		{
			break;
		}
	}

	self notify("fall_down");
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
//			guys[i] dodamage((guys[i].health + 50), (guys[i].origin));
			guys[i] thread Bloody_Death(true);
		}

		wait randomfloat(delay);
	}
}


// Sets up the "friendly_respawner" triggers, and each one is threaded into "Friendly_Respawner_Trigger"
Friendly_Respawner_Setup(groupname)
{
	// Grab all of the current LIVING AI (just after map is loaded)
	// And have each AI thread "Friendly_Respawner_Death_Think"
	group = getentarray(groupname,"groupname");
	for(i=0;i<group.size;i++)
	{
		if(issentient(group[i]))
		{
			group[i] thread Friendly_Respawner_Death_Think();
		}
	}

	// Have the level thread the TOGGLE feature
	level thread Friendy_Respawner_Toggle(groupname);

	// Have the level thread the actual think thread.
	level thread Friendly_Respawner_Think(groupname);

	triggers = getentarray(groupname + "_friendly_respawner","targetname");
	println("^2Friendly_Respawner_Setup TRIGGERS (" + groupname + "^2): ",triggers.size);
	for(i=0;i<triggers.size;i++)
	{
		triggers[i] thread Friendly_Respawner_Trigger(groupname);
	}
}

// Each "friendly_respawner" trigger threads this.
// Once triggered, it sets the trigger up for respawning in the targeted guys.
Friendly_Respawner_Trigger(groupname)
{
	// Set spawner count to 0, so they don't spawn in, when the player walks through the trigger.
	spawners = getentarray(self.target,"targetname");
	for(i=0;i<spawners.size;i++)
	{
		spawners[i].count = 0;
	}

	self waittill("trigger");

	// Set the trigger being used to spawn in guys. (look in "Friendly_Respawner_Think")
	level.friendly_respawner_trigger[groupname] = self;
}

// This is the main THINK function for respawning the FRIENDLY AI.
// Waits for one of the guys (squad2) to die, then keeps spawning in
// friendly AI until the amount of "squad2 guys" (<- guy_count) is equal to level.friendlies.
// Each guy spawned in, will run 2 threads, one to keep track of their DEATH, and other to 
// tell them where to go.
Friendly_Respawner_Think(groupname)
{
	level endon(groupname + "_stop_friendly_respawner");
	while(1)
	{
		// Waits until one of the "squad2 guys" are dead.
		level waittill(groupname + "_friendly_killed");

		// Make sure there is a trigger specified for spawning in guys.
		if(isdefined(level.friendly_respawner_trigger[groupname]))
		{
			spawners = getentarray(level.friendly_respawner_trigger[groupname].target,"targetname");

			// Get the count of squad2 living AI.
			guy_count = Friend_Respawner_AI_Counter(groupname);

			// Loop until guy_count is equal to level.friends.
			while(guy_count < level.max[groupname])
			{
				wait 1 + randomfloat(3);

				random_num = randomint(spawners.size);

				spawners[random_num].count = 1;

				// Spawn the AI.
				spawned = spawners[random_num] dospawn();

				spawners[random_num].count = 0;

				// Run a few threads after spawned in.
				if(isdefined(spawned))
				{
					// Took get_name from flood_spawner.
					spawned maps\_names_gmi::get_name();

					// Tells them where to go.
					spawned thread Friendly_Respawner_Catch_UP();

					// Death tracker.
					spawned thread Friendly_Respawner_Death_Think();
				}

				// Check the guy_count 1 last time before looping.
				guy_count = Friend_Respawner_AI_Counter(groupname);
			}
		}
	}
}

// Counts up the total amount of living AI, and returns the value.
Friend_Respawner_AI_Counter(groupname)
{
	all_ents = getentarray(groupname,"groupname");

	group = [];

	for(i=0;i<all_ents.size;i++)
	{
		if(isalive(all_ents[i]))
		{
			group[group.size] = all_ents[i];
		}
	}

	return group.size;
}

// Tells the AI where to go, which is the player.
Friendly_Respawner_Catch_UP()
{
	self endon("death");

	self.health = 100;
	self.goalradius = 32;
	self.followmax = 5;
	self.threatbias = level.friendly_threatbias;

	if(self.groupname == "allies_group1")
	{
//		if(level.last_area)
//		{
//			if(level.end_group.size < 4)
//			{
//				level.end_group[level.end_group.size] = self;
//			}
//		}
		self.script_uniquename = "friendlychain_ai";
		self setgoalentity (level.player);
	}
	else if(self.groupname == "allies_group2")
	{
		self setgoalentity (level.group2_commander);
	}
}

// Each squad2 guy threads this, once 1 dies, it sends out the notify.
Friendly_Respawner_Death_Think()
{
	self waittill("death");
	level notify(self.groupname + "_friendly_killed");
	if(level.last_area)
	{
		level.end_group = maps\_utility_gmi::array_remove(level.end_group, self);
	}
}

// Toggles on/off the friendly_respawner.
Friendy_Respawner_Toggle(groupname)
{
	while(1)
	{
		level waittill(groupname + "_stop_friendly_respawner");
		level waittill(groupname + "_start_friendly_respawner");
		level thread Friendly_Respawner_Think();
	}
}

Friendly_ThreatBias(num)
{
	allies = getaiarray("allies");
	for(i=0;i<allies.size;i++)
	{
		if(isai(allies[i]) && isalive(allies[i]))
		{
			allies[i].threatbias = num;
		}
	}	

	level.friendly_threatbias = num;
}

Falling_Debris(targetname, animname, origin)
{
	debris = getentarray(targetname,"targetname");

	if(isdefined(origin))
	{
		org = spawn("script_model", origin);
	}
	else
	{
		org = spawn("script_model", (0,0,0));
	}

	if(isdefined(animname))
	{
		org.animname = animname;
	}
	else
	{
		// Get the anim name.
		for(i=0;i<debris.size;i++)
		{
			if(!isdefined(org.animname))
			{
				if(isdefined(debris[i].script_animname))
				{
					org.animname = debris[i].script_animname;
				}
			}
		}
	}

	println("^2org.animname: ",org.animname);
	println("^2debris.size: ",debris.size);
	// Setup the fake origin.
	org setmodel(("xmodel/" + org.animname));
	org UseAnimTree(level.scr_animtree["kharkov2_debris"]);

	// Link the debris to the tags on the script_model.
	for(i=0;i<debris.size;i++)
	{	
		// Check to see if it's an effect.
		if(debris[i].classname == "script_origin")
		{
			if(isdefined(debris[i].script_fxid))
			{
				if(isdefined(debris[i].target))
				{
					if (getcvarint("scr_gmi_fast") < 2)
					{
						fx_target = getent(debris[i].target,"targetname");
						level thread maps\_fx_gmi::OneShotfx(debris[i].script_fxid, debris[i].origin, 0, fx_target.origin);
					}
				}
				else
				{
					if (getcvarint("scr_gmi_fast") < 2)
					{
						playfx(level._effect[debris[i].script_fxid], debris[i].origin);
					}
				}
			}

			continue;
		}

		if(!isdefined(debris[i].script_noteworthy))
		{
			println("^1Script_Noteworthy is needed for Falling_Debris @ (" + self.origin + ")");
			continue;
		}
		else
		{
			if(debris[i].script_noteworthy == "delete")
			{
				debris[i] delete();
			}
			else
			{
				println("debris[i].script_noteworthy: ",debris[i].script_noteworthy);
				debris[i] linkto(org, debris[i].script_noteworthy,(0,0,0),(0,0,0));
				debris[i] notsolid();
				level thread Falling_Debris_Damage_Think(debris[i], 128, max_damage, min_damage, ender, org);
				org thread Falling_Debris_FX(org, debris[i].script_noteworthy, debris[i]);
//				org thread do_line_tag(debris[i].script_noteworthy, org);
			}
		}
	}

	// Play the animation.
//	org setFlaggedAnimKnobRestart("animdone", level.scr_anim[self.animname]["reactor"]);
	org animscripted("single anim", org.origin, org.angles, level.scr_anim[org.animname]["reactor"]);
	org thread maps\_anim_gmi::notetrack_wait(org, "single anim", undefined, "reactor");
	org waittillmatch("single anim","end");

	wait 0.1;

	// Unlink the Objects.
	for(i=0;i<debris.size;i++)
	{
		if(isdefined(debris[i]))
		{
			debris[i] unlink();
			debris[i] thread Debris_Solid_Think();
		}
	}

	org delete();
}

do_line_tag(tag_name, ent)
{
	while(1)
	{
		tag_origin = ent gettagorigin(tag_name);
		line(level.player.origin, tag_origin, (1,1,0));
		wait 0.06;
	}
}

Debris_Solid_Think()
{
	while(1)
	{
		if(distance(level.player.origin, self.origin) > 256)
		{
			break;
		}
		wait 0.5;
	}

	self solid();
}

Falling_Debris_Sound(org, tag)
{
	org endon("death");
	while(1)
	{
		org waittillmatch("single anim",tag + "_sound");
		println("SOUND (",tag,")");
		self playsound("big_stone_crash");
	}
}

Falling_Debris_FX(org, tag, debris)
{
	org thread Falling_Debris_FX_Think(org, tag);
	debris thread Falling_Debris_Sound(org, tag);
	
	org endon(tag + "_stopfx");
	while(1)
	{
		if (getcvarint("scr_gmi_fast") >= 2)
		{
			wait 0.5;
		}
		else if (getcvarint("scr_gmi_fast") == 1)
		{
			playfxontag(level._effect["debris_trail_50"], org, tag);
			wait 0.5;
		}
		else if (getcvarint("scr_gmi_fast") < 1)
		{
			playfxontag(level._effect["debris_trail_50"], org, tag);
			wait 0.25;
		}
	}
}

Falling_Debris_Damage_Think(ent, radius, max_damage, min_damage, ender, ent_ender)
{
	if(isdefined(ender))
	{
		level endon(ender);
	}
	else if(isdefined(ent_ender)) // Special for Falling_Debris at beginning.
	{
		ent_ender endon(ent.script_noteworthy + "_stopfx");
	}

	if(!isdefined(radius))
	{
		radius = 300;
	}

	if(!isdefined(max_damage))
	{
		max_damage = 300;
	}

	if(!isdefined(min_damage))
	{
		min_damage = 100;
	}	

	while(1)
	{
		radiusDamage (ent.origin, radius, max_damage, min_damage);
		wait 0.1;
	}
}

Falling_Debris_FX_Think(org, tag)
{
	org waittillmatch("single anim", tag + "_fx");
	org notify(tag + "_stopfx");
	println("END!!! = ",tag);
}

// Spawns Guys in without having to type it in each time.
Guy_Spawner(name, name_type, count, delay, favoriteenemy)
{
	if(!isdefined(name))
	{
		println("^1(Guy_Spawner): NAME IS UNDEFINED!!");
		return;
	}

	if(!isdefined(name))
	{
		println("^1(Guy_Spawner): NAME_TYPE IS UNDEFINED!!");
		return;
	}

	if(isdefined(delay))
	{
		wait delay;
	}

	spawners = getentarray(name, name_type);

	if(!isdefined(spawners) || spawners.size == 0)
	{
		println("^1(Guy_Spawner): NO SPAWNERS FOUND WITH A ", name_type, " ^1 OF ", name);
		return;
	}

	for(i=0;i<spawners.size;i++)
	{
		if(issentient(spawners[i]))
		{
			continue;
		}

		// Overrides the Count on the spawner.
		if(isdefined(count))
		{
			spawners[i].count = count;
		}

		// Spawn the AI
		if(isdefined(spawners[i].script_stalingradspawn) && spawners[i].script_stalingradspawn)
		{	
			spawned = spawners[i] stalingradSpawn();
			spawned waittill("finished spawning");
		}
		else
		{
			spawned = spawners[i] dospawn();
			spawned waittill("finished spawning");
		}

		if(isdefined(spawned))
		{
			if(isdefined(favoriteenemy))
			{		
				spawned.favoriteenemy = favoriteenemy;
			}
		}
	}

	if(isdefined(spawned.groupname))
	{
		if(spawned.groupname == "event9_ant_cover_group1")
		{
			spawned settakedamage(0);
			tank = getent("t34_1","targetname");
			while(isalive(tank))
			{
				wait 0.25;
			}
			spawned settakedamage(1);
		}
	}
}

ai_dialogue(getclosest, ent, animname, dialogue, delay, excluders)
{
	if(isdefined(delay))
	{
		wait delay;
	}	

	if(isdefined(getclosest) && getclosest)
	{
		if(isdefined(level.ai_talking) && level.ai_talking.size > 0)
		{
			ent = maps\_utility_gmi::getClosestAI(level.player.origin, "allies", level.ai_talking);
		}
		else
		{
			ent = maps\_utility_gmi::getClosestAI(level.player.origin, "allies", excluders);
		}

		if(!isdefined(level.ai_talking))
		{
			level.ai_talking = [];
		}

		level.ai_talking[level.ai_talking.size] = ent;
	}

	if(!isdefined(ent))
	{
		println("^1(ai_dialogue):ENT IS NOT DEFINED, ABORTING!");
		return;
	}

	if(isdefined(animname))
	{
		ent.og_animname = ent.animname;
		ent.animname = animname;
	}

	ent endon("death");

	println("^6 AI_DAILOGUE: ",dialogue);
	level anim_single_solo(ent,dialogue);

	level.ai_talking = maps\_utility_gmi::array_remove (level.ai_talking, ent);
	ent.animname = ent.og_animname;
}

GetClosestNode(org)
{
	if(!isdefined(org))
	{
		org = level.player.origin;
	}

	nodes = getallnodes();

	if (nodes.size == 0)
	{
		return undefined;
	}

	return maps\_utility_gmi::getClosest (org, nodes);
}

//------------------------------------//
// --- None Event Related Section --- //
//------------------------------------//

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

// Fake dieing.
Bloody_Death(die, delay)
{
	println("^1(Bloody_Death): Has been called. Die =: ", die);

	if(isdefined(delay))
	{
		wait randomfloat(delay);
	}

	self endon("death");

	tag_array = level.scr_dyingguy["tag"];
	tag_array = maps\_utility_gmi::array_randomize(tag_array);
	tag_index = 0;

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
		println("^1(Bloody_Death): KILLING NOW!");
		self dodamage(self.health + 50, self.origin);
	}
}

AI_Bloody_Death_Think()
{
	self endon("death");
	self waittill("goal");
	self thread Bloody_Death(true);
}

do_line(pos1, pos2, color, msg, delay)
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

	if(isdefined(delay))
	{
		delay = delay * 1000;

		while(delay > gettime())
		{
			line(pos1, pos2, color);
			wait 0.06;
		}
	}
	else
	{
		while(1)
		{
			line(pos1, pos2, color);
			wait 0.06;
		}
	}
}

do_print3d(ent, pos, msg, color, delay, size)
{
	if(!isdefined(ent) && !isdefined(pos))
	{
		return;
	}

	if(isdefined(ent))
	{
		ent endon("death");
	}

	if(!isdefined(msg))
	{
		string = "STRING";
	}

	if(msg == "health")
	{
		health = true;
	}
	else
	{
		health = false;
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
		if(health)
		{
			msg = ent.health;
		}

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

ent_line(ent1, ent2, color, delay)
{
	if(!isdefined(color))
	{
		color = (1, 1, 1);
	}

	if(isdefined(delay))
	{
		delay = delay * 1000;

		while(delay > gettime())
		{
			if(!isdefined(ent1) || !isdefined(ent2))
			{
				break;
			}
			line(ent1.origin, ent2.origin, color);
			wait 0.06;
		}
	}
	else
	{
		while(1)
		{
			if(!isdefined(ent1) || !isdefined(ent2))
			{
				break;
			}
			line(ent1.origin, ent2.origin, color);
			wait 0.06;
		}
	}
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
	level.temp_dialogue.y = 220;

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

power_move()
{
	if(getcvar("smart_bomb") == "")
	{
		setcvar("smart_bomb", "0");
	}
	while(1)
	{
		if(getcvar("smart_bomb") == "1")
		{
			dummy = spawn("script_model",level.player.origin);
			dummy [[level.scr_character["end_dummies"][0]]]();
			dummy.angles = level.player.angles;

			dummy UseAnimTree(level.scr_animtree["smart_bomb"]);
			dummy setflaggedanimknobrestart("animdone",level.scr_anim["smart_bomb"]["trans"]);
			dummy attach("xmodel/weapon_panzerfaust","TAG_WEAPON_RIGHT");

			setcvar("smart_bomb", "0");
			setcvar("timescale","0.2");
			setcvar("cg_thirdperson","1");
			setcvar("cg_thirdpersonrange","300");

			level.player freezecontrols(true);
			wait 0.1;
			org = spawn("script_origin",level.player.origin);
			org.angles = level.player.angles;
			level.player setplayerangles((0,0,0));
			wait 0.1;
			level.player playerlinkto(org,"",(1,1,1));

			level thread power_spin(org);

			println("^1POWER MOVE!!!");


			level thread power_flame(dummy, 0.25);
			dummy waittill("animdone");
			dummy setflaggedanimknobrestart("animdone",level.scr_anim["smart_bomb"]["doit"]);
			wait 0.25;

//			playfxonTag ( the_fx, dummy, "TAG_ORIGIN" );
			level thread power_fx(dummy);

			level.player playsound("explo_metal_rand");
			radiusDamage((level.player.origin + (0,0,96)), 1024, 5000, 1);

			wait 1;

			dummy detach("xmodel/weapon_panzerfaust","TAG_WEAPON_RIGHT");
			stopattachedfx(dummy);
			wait 0.1;

			level notify("end_smartbomb");
			level.player unlink();
			org delete();
			dummy delete();
			level.player freezecontrols(false);				
			setcvar("timescale","1");
			setcvar("cg_thirdperson","0");
			setcvar("cg_thirdpersonrange","300");
		}

		wait 0.5;
	}
}

power_fx(dummy)
{
	time = 500 + gettime();

	z_axis = 0;
	rate = 5;

	while(time > gettime())
	{
		playfx(level.smart_bomb, (dummy.origin + (0,0,z_axis)));

		if(z_axis > 32)
		{
			rate = -5;
		}
		else
		{
			rate = 5;
		}
		z_axis += rate;

//		wait (randomfloat(0.25));
		wait 0.1;
	}
}
power_spin(org)
{
	level endon("end_smartbomb");

	while(1)
	{
		org rotateto(((0,org.angles[1],0) + (0,90,0)), 0.15,0,0);
//		org waittill("rotatedone");
		wait 0.1;
	}
}

power_flame(guy, delay)
{
	if(isdefined(delay))
	{
		wait delay;
	}

	level endon("end_smartbomb");

	tags = [];
	tags[tags.size] = "Bip01 Neck";
	tags[tags.size] = "Bip01 L UpperArm";
	tags[tags.size] = "Bip01 L Forearm";
	tags[tags.size] = "Bip01 L Hand";
	tags[tags.size] = "Bip01 R UpperArm";
	tags[tags.size] = "Bip01 R Forearm";
	tags[tags.size] = "Bip01 R Hand";
	tags[tags.size] = "Bip01 L Thigh";
	tags[tags.size] = "Bip01 L Calf";
	tags[tags.size] = "Bip01 R Thigh";
	tags[tags.size] = "Bip01 R Calf";

	while(1)
	{
		a = randomint(tags.size);
		playfxOnTag ( level.smart_bomb_fire ,guy, tags[a] );
		wait(0.05);
	}
}

testing_tanks()
{
	for(i=1;i<4;i++)
	{
		tank = getent(("event9_tank" + i),"targetname");
		if(i==1)
		{
			color = (1,1,0);
		}
		else if(i==2)
		{
			color = (0,1,1);
		}
		else
		{
			color = (1,1,1);
		}
		tank thread do_line_target(color);
	}
}

do_line_target(color)
{
	self endon("death");
	while(1)
	{
		for(i=0;i<self.enemy_targets.size;i++)
		{
			line(self.origin,self.enemy_targets[i].origin, color);
		}
		wait 0.06;
	}
}

test_mg42()
{
	mg42 = getent("mg42_1","targetname");

	while(1)
	{
		print3d((mg42.origin + (0,0,100)), mg42.accuracy, (1,1,1), 1, 2);
		wait 0.06;
	}
}

vehicle_line()
{
	while(1)
	{
		vehicles = getentarray("script_vehicle","classname");
		for(i=0;i<vehicles.size;i++)
		{
			line(vehicles[i].origin, level.player.origin, (1,1,1));
		}

		wait 0.06;
	}
}

remove_smoke_minspec()
{
	if (getcvarint("scr_gmi_fast") > 1)
	{
		self waittill ("death");
		wait 12;
		stopattachedfx(self);
	}
}