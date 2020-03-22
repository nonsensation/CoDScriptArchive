//
//Mapname: Foy
//Edited by: Jeremy
//


// Task List // 
//----------
// First day back 12/8
// Setup player with friendly's at the first sniper position
// have friendly look around corner and get shot.. or make his way to cover that's ten feet away
// Sarg then tells player to take out the sniper so they can move froward
// Objectives --
//	Need to setup objectives in the GMI_TRENCHES_OBJECTIVE1 file

// - Have Mortars close in on player if not in a "hidden" or "cover spot" zone.

// figuring out how to make follow lead/follow and then call sound/animation to move group forward
// I understand one tech right now for doing this, yet I don't know how to make them use friendly chains..

// 12/13/03
// just made the morats intensity change when going from haystack to haystack
// added new movement up to 88 -- it's a trigger the player runs through to make squad follow up
// added 88 that can be used by the player
	// need to make it so the player can shoot building
	// need to make it so the player can blow up the 88
	// use a destroyed 88 model and call that one in when the bomb is placed
// added door opening when the squad gets to the 88

//12/15/03
// made 88 usable and does not allow the player to use it once an objective is complete

//12/16/03
// Merge
// when the 88 is destroyed the squad then moves forward and clears out the first court yard
// setup guys to charge through door with player
// setup first house and courtyard that must be cleared
// setup first part of second house that the player must clear  
// setup mg42 ai that attacks the player and sqaud near 88

//12/17/03
// added shutter
// tweaking guys to follow the player while he clears the houses

//12/18/03
// got guys fighting through first house
// built out destroyed brick wall
// fixed fence
// fixed timeing of window shutters opening
// twekaed first courtard battle to have guys attacking from the top windows
// setup tank to blow that can be blown up now.
// setup third house to clear with ai
// setup fourth house to clear -- not done yet
// setup lantern -- need to add effect with it....
// added moving door to second mg42 event

// move on to getting the rest of the guys in...
// setup tank firing on spot now!!!
// setup trigger that opens door for player after he destroys the tanks...
// tank will not stop firing when it is killed, I don't think it's health value is seen from that function.
//  I should setup sniper to spawn of ai  not a trigger once
// todo
// place nodes up to church
// have only two guys follow the player
// set mg42 to god or repsawn mode
// make guys run across the street
// clear out church
// get to street
// sniper attacks
// make sarg run into street.

//12/19/03
// added last event for church mg42 to spawned and kept track of
// made nodes to spotter house
// merge
// tested mg 42 guy spawning, should work now
// need to test event off of his death now...  WORKS NOW
// setup trigger to take mg off god mode so player can shoot em.

//12/22/03
// add battles in spotter house
// add panzerfaust event, make side of tower blow up with it
// add guys in church event
//  make function that splits up guys so two of them follow the player to spotter house and the others wait
// truck driving by event now works... near third courtyard

// 12/23/03
// still having trouble making follow you after first house... friendly chain issue
// triggers work for 42, s

// need to clear church then
// have guys meet up outside of church
// sniper event
// then tank event

//12/29/03
// Make sure church mg42 event works
// check to see why sarg does not move up?

//12/30/03
// church guys counter working, event will not continue untill all guys are cleared out
// setup trigger so player has to search the whole church to clear it
// need to setup ai standing outisde that gets orders when a sniper attacks
		// prevent player from cheesing event...
// setup three tanks that drive up on road while player protects them

//01/02/03

//01/04/03
// NEED TO COMPLETE SNIPER 	event
	// need to make guys tand around 
	// need to make guys scatter with sarg calling player over to corner of house
	// need to make sarge grab cover while avoiding sniper shots

// need to make guys attack tanks rolling up
// made sniper event with serg work
// death of sniper starts tank event
// player can enter the bell tower and start next event

// placed markers for guys to use all the first huts..
// need to places triggers to they can now move forward like the others
// wood doorkick and wood door open

// got ai attacking tanks working...
// fix respawn bug issues with them

// made the tank blow up and roll after so...

//01/07/03
// implemeting of test map is not going well
//		tanks are not exploding and stopping
//		ai is shot at and does not attack tanks

// shermans are good to go...

// to do make tank event end
// group men behind shermans make them walk forward with tank and have forard tank be blown up
// regroup man -- give orders

// go through trees to house
// setup spotter and live in house
// spwan in more guys when tank is blown
// show shermans and jeep coming over hill

// event8
// one tank goes along path
		// need to make it blow up
// need to make other tanks follow then ... stop
// blow fisrt tank up at last node... then have others stop and start allies to flank house...

// make moody use friendly chain near tank to follow behind it...
	// make friends use their paths
	// not using chain but can force him to follow tank now...
		// do same for friends

// setup second tiger so it fires at sherman at base of bridge...

// oops changed one thing and now guys are not charging it's 5:41 in the morning time to go home!

// tasks

// got event7 attackers to stop respawning once tank gets to point

// need to tweak nodes

	// fix truck on add nodes on other side of truck
	// fix guys that come from far away

// need to make sure troopers follow you up to tanks and so on

// need to blow up tank
// 

// yeah MILESTONE
//01/12/03
//

// Need to finish basic events
	//wbs
	// get guys following tanks
	// get last event in with AI there
	// need to get shermans in as shermans
			// is that Dan or me... ask Deny

// need desroyed sherman
// need tags to attach guys to shermans

//01/13/03
// found bug that caused guys to not follow anymore, should work now...

// need antitank tung to be exported with tags and animation just like turret_88
// or have another version of turret_88 that fires parrallel to the ground


// 01/14/03
// got new 88 to work that is one entity must be ready

		// requests
		// code
		// art
			// get particels to bounce... ones used in building exploding

// just placed in destroyed building...
// nned to do haystack to complete event
// mortars not making hay stacks explode -- investigate

// on to finishing the level
// yeah got engine running


// guy turns around at 1024
// nned to spawn in more enemy if when the shit blows up
// make shermans come aross bridge with jeep

// check end level shit...
	// use debug for the last friends shit so they go the right markers at end....

//01/19/03
// 88 is in and complete

//01/21/03
// new paths are done for tanks
// making new sherman tank files

// panzer guys..

// Here we go - into the wild blue yonder!

//01/24/03
// check death counter seemed quirky
// make first panzerfaust guy miss
// setup better locations for the panzer team to attack from easy to see....

		// test each killer
		// get killer on hud

// make tanks roll up and kill sniper spot

// put in colins effects so far for level

// added new effects from colin!
		// 88 building
		// fire in house
		// bell tower
// haystack issue fixed, extra misc model was in there..


//01/26/03

// fire event in and damaging people...

// reworked belltower event
		// guy now dies when building explodes...
		// also setup damage trigger in front of door that kills player if he steps out into road
		// also made it so no friendly ai will go out the door until the belltower is blown.

	// getting latest sherman stuff to work... 
			// make sure model is animated for shit that can move.

	// 
// reworking house to house stuff, is there a way to kill friendly chains behind the player
// setup mg42 nest in hhouse so player can kill guy from above
			// will see if it works

// 88 crash bug fixed, need programming to look at model, thus to make it point to where it was when it was destroyed.

//02/03/03

// guys run from cover to cover now.. at each haystack
// mortars damage the player
// nodes cleaned up near these path ways

// added new objective to kill mg42 guy.. need to setup a do spawn for this guy.. so they objective can be met

// look at objectives after that...
		// setup code to mg42 guy in house can be killed and an objective is then set..
		// waiting for converter.. but then I need to name this guy accordingly and then make him spawn from the right trigger
		// testing right now..


// put in fire code for tanks just need coordinates
			// make them only fire on thier first advance...
				// make them stop after that...
// double check explosion for 88


//02/04/03
// setup begggining so guys stop with with foley at the right place before moving forward
// guys all stop
	// need to add dialogue

// added guys getting blown up in beggining

// made mg42 support guys that only appear when the mg42 best objective is displayed
// autosave in


// anim with sound now -- rememeber you need 5 lines two in level script and three in anim

// placed sound/anim up to sniper event...
		// need to put sniper sound guy getting shot by him..

// added sniper event -- check timing
// need to change timing with steve..

//02/10/04
// tweaked more paths in houses
// three guy only follwo player into them

// model for lamp hides when shot now..
// tanks stop firing when the get closer to town.
// dialogue after blowing up the building is cut off too quickly

// moved trigger so they mg42 starts attackiing the player and his team earlier

// bugs
	// guys in grenade house are coming outside too quickly
	// timing -- all guys should be killed before mg42 near88 occurs

	// all friendlies run away at the same time...
	// spotter does not spawn in if the player can see them.. move points over...

	// Clip for stairs is not low enough... player can get to high still ... fixed

// added new friendly trigger that brings nine guys near church battle... setting max friends to nine to test
// moved spotters so they can't be seen when they spawn in .. testing

//added new spot for ai to run over and get blown up..

// event4b happening to early.. guys go to church to quickly.. fixed , trigger had friendly in it starting it off

// to many friendly cover nodes near...tiger tank,,

// adding grenade throwers...

// added guy blowing up next to mortars

// move friendly trigger after burnhouse closer for friend ai

//cover in area with mortars, two guys are using a spots with no sand bags

// added church vo
// fixed node that moody could not get to continue script 

// added door kicking with correct vo for door 5 and door 6 
// set up objective 8 and 9 should work now...

// new bugs
	// unable to make friendlies regroup with team after the level.maxfriendly thing is set...
		// ask Mike: I wonder if I have to thread the Catchup line... I bet I do...

// fixed mortar crash


//fixed nodes near wall so guys go right to them...

//adjusted trigger at spotter, player was able to get to it too early and have it turn on...

// Fixed bug with player and spotter event..., the trigger was a trigger once.

// talked with colin about haystack, broken right now...

// adjusted courtyard, lowered fence
// no enemy come from behind the house now
// moved event2a trigger next to the 88 so it does not get spawned to early

// tweaked church, nodes, chain, 

// made crouch nodes for beggining guys

// moved up nodes for guys near cows

// 02/12/04
// made new changes to beggining so the player can simply run through the haystack sequence
// tweaked timing of belltower being blown by tank

// 02/18/04
// added last event, polishing now
// made guys in barn go agro when the player gets to close

//03/07/04
// complete monday and tuesdays task list from dan, currently half way through weds
// Just added new tanks with that get blown up at precise times
// adding mortars that land around the tank


//03/08/04
// made almost all triggers work with ai activating them
// changed frinedly chains

// added moving tank
// added ai that it can fire at.. in the opposite building
// fixed fire so there are no longer two effects, now there is one
// made it so guys run through the house of fire ahead of the player
// tweaked timing of gun fire from tiger1 and it's mg42... still no enough heat though

//03/09/04
// fixed 88 progression bug
// battle near tiger tank
// tweaked friendly for entire intro to stop the AI from getting into battle as least as possible
// fixed sound crash per request move "moody suppression sounds" to another
// adjust accuracy of mg42's
// made the guy who gets sniped not a target for the mg42's
// adjust guys in the second story building near the new exit from the fire house
// adjusting timing on the whistle blowing 
// adjust staggering of friendly chians near the tree and patch mesh wall after killing the spotter
// adjusted staggering of friendly chians after the wood fence in the second courtyard
// removed an objective that was not requested to do so
// need to reset values of walking for ai if they appear to off 
// fixed turrets if shermans
// made shermans attack incoming drones 
// use mikes code for panzer guys

//03/10/04
// fixed multiple borken friendly chain nodes in houses, apearently they were adjusted to get the ai out of the doors but the door ways are way to small and still need them
// fixed nodes in doorway, near exit of barn and near 88 tank(broken) plus many other areas
// fixed enemy ai sqaud that comes out of house near bell tower getting blown
// moved roll over to a spot that is after prone, but guys still roll over
// moody is still getting caught up yet does better
// fixed ai in mortar courtyard so they no longer stuck behind new geometry
// added in a new spot that forced moody to his ignoreme value
// placed the first mg42 guy in the left hand side window.  The right side window mg42 will not spawn till the spotter is killed
// objective of getting to town was occuring too early, fixed now.
// added about ten changes with dan task list
// make sure to half guys that are spawned near shed...
// got through all of dans task list
// added three save points that track health
// added exploder for building that sherman can shoot
// no backwards anim for tanks... so tiger tank looks odd going backwards
// added a function that deletes the battle occuring outside of the last house the player goes through.
// first sherman now blows up hole in building wall...	

//03/11/04
// panzer guy spawns in but does a check that is too far away for the tannks
// adjust tank nodes so they stop in front of church.. meaning the back two tanks probably won't fire... ahead.. to tight of an area
	// made some changes need to test further connections down the road?
// takea away some of the guys that spawn in near the shed to many
// adjusted saves so they are numbered correctly in between objectives
// fixed croucher think crash
// need to check on crash that can occur from guys count trigger near 88
// added all enemy ai for ending with one pass on flow and pacing
// add basic blow up spots for kevin to tit out...
// made tiger tank follow and aim at the player once at the bridge

//03/12/04
// task list
	//-- make whole where mg42 guy is killed blow up
	// add kevins new peices for the bridge -- todo
	// add friendly nodes to battle area -- todo
	// check ending with troops coming acorss bridge


// fixed placement of tanks at church with new speed adjustments after words
// changed bursts of tank guns so they are not always on...

//03/13/04
// MADE TRIGGER bigger for guy kicking table over and also placed him in god mode as well
// fixed timing of kick for moody need to test
// removed pause after first tiger tank is destroyed
// fixed guy who spawning in to early in the map...
// adjusted crash right before fire house
// fixed house that sherman blows up
// made guy catch on fire near table
// all moody kicks are timed now

//03/14/04
// fixed fire crash bug 
// added jeep to bridge
// adjusted placement of tnt on 88
// moved guys over right trench
// removed second mg42 in first courtyard
// made collision maps for snow truck, american destroyed jeep and snow kubelwagon
// moved geometry around so player is funneled into the safe trenches
// placed jeep on bridge
// fixed fake sniper...
// adjusted friendly ai in the end because they were not coming over the bridge
// made bell tower event wait till foloy's speech is over
// fixed missing texture on fence that ai and players can run through	
// fixed friendly chain at bridge
// got shermans random fire across bridge
// got friendly AI to come across bridge at end
// shermans fire at window where mg42 guys is
// fixed ai debug crash error in bell tower
// added check for friendly so they are no longer passive once crossing the bridge
// made shermans stop firing when player gets near barn


// 03/15/04
// court yard battle after tiger, need to kill these germans so it's not distracting
// fixed ackward ai after fire house
// kill ai when player enters courtyard with tiger
// colin effects are in 
// removed second lamp
// fixed tiger 2 crash 
// adjusted drones in end to two small five man squads
// fixed comp -- for last objective
// fixed sheman turrets so they face the right direction in the end
// fixed timing issue with player and tank blowing up to early
// added in look at trigger for bell tower event
// sherman should not fire until after foley's line now...


// getting guys ahead of the player getting across the bridge

// adjusted size of trigger in church 
// added sniper rifle in lower room
// moved health to it's sides
// added dead german with rifle new shed


// fixed three crashbugs with jed...

// 03/15/04
// killed chain before 88 , I may need to rename this value because the script_kill_chain only works with a nu
// take a look that
// added efects for bridge explosion
// cleaned up node in house that is no longer used 
// Move benches around in church and adjusted AI 
// resolved sound issue with sherman tanks explosion not being heard
// added mg42 guy in church
// spawn guys early.. should get some voice for them moving around
// fixed player getting off of jeep in bastogne1

// 03/16/04
// fixed tanknode in middle of road but now it runs over a guy

#using_animtree("generic_human");
main()
{
	setCullFog (0, 7000, .5254, .6117, .7215, 0 );

	if(getcvarint("scr_gmi_fast") >= 1)
	{
		level.mortar = loadfx ("fx/explosions/artillery/pak88_snow_low.efx"); // loads the fx file for mortars
		level._effect["mortar"] = loadfx ("fx/explosions/artillery/pak88_snow_low.efx");
	}

	if(getcvarint("scr_gmi_fast") == 0)
	{
		level.mortar = loadfx ("fx/explosions/artillery/pak88_snow.efx"); // loads the fx file for mortars
		level._effect["mortar"] = loadfx ("fx/explosions/artillery/pak88_snow.efx");
	}



	level.mortar = level._effect["mortar"];
	level.mortar_quake = 0.5;	// sets the intenssity of the mortars
	level.atmos["snow"] = loadfx ("fx/atmosphere/snow_light.efx");	// loads the fx file for the rain
//	playfxonplayer(level.atmos["snow"]);	// sets and places the rain fx on the player


//-------------map loads------------//
	maps\_load_gmi::main();	
	maps\_sherman_gmi::main();		
	maps\_panzeriv_gmi::main_camo();
	maps\_tiger_gmi::main_snow();
	maps\tankdrivetown_sound::main();
	maps\_p47_gmi::main();

	//Thread for Panzer Dudes:
	level.panzer_think_thread = maps\foy::Event7_Panzer_Think;
	maps\_bombs_gmi::init();	
	maps\_debug_gmi::main();

	maps\foy_anim::main();
	maps\foy_fx::main();
	maps\_flak_gmi::main();	
	animscripts\lmg_gmi::precache();

	// DUMMIES
	maps\foy_dummies::main();

//======Ambient sounds
	level.ambient_track ["exterior"] = "ambient_foy_ext";
	level.ambient_track ["exterior2"] = "ambient_foy_quiet";
	level.ambient_track ["interior"] = "ambient_foy_int";
	thread maps\_utility_gmi::set_ambient("exterior2");

//======starts precache
	precachemodel("xmodel/vehicle_tank_panzeriv_machinegun"); // For Guns on panzeriv.
	precachemodel("xmodel/vehicle_tank_tiger_camo_d"); // HACK!
	precachemodel("xmodel/turret_flak88_static_antiairlow_d"); // HACK!
	precachemodel("xmodel/turret_flak88_d"); // HACK!
	precachemodel("xmodel/explosivepack"); // HACK!
	precachemodel("xmodel/explosivepack"); // HACK!
	precachemodel("xmodel/head_foley");
	precachemodel("xmodel/c_us_bod_moody_winter");
	precachemodel("xmodel/c_us_helmet_moody_winter");
	precachemodel("xmodel/head_moody");
	precachemodel("xmodel/o_us_misc_whistle");

	precacheShellshock("default_nomusic");

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
	
	// global 
	level.flag["blah"] = 0;
	level.mortar_mindist = 660;
	level.mortar_maxdist = 2000;
	level.mortar_random_delay = 25;
	level.mg42nest_count = 0;
	level.roofsnipers_count = 0;
	level.echurch_guys_count = 0;
	level.house_fire = 0;
	level.shermans_count = 0;
	level.shermans_arrive_count = 0;
	level.event1o_count = 0;
	level.last_guys_near_88_count = 0;
	level.panzerfausts_remaining = 0;
	level.num_of_respawns = 7;

	println("^5start =",getcvar("start"));

	level thread event2_mg42s_init(); // sets up new mg42'for rushing town event.
	level thread fog_changer();
	
// --------------Debug -- makes a lot of work, a lot easier--------------------//	
	// starts player in front of church ready to storm it
	if (getcvar("start") == "storm_church")
	{	
		level thread shermans_firesmoke();
		level thread p47_flyby();
		level thread flyby_street_setup();
		level thread p47_flyby_end();
		level thread fake_sniper_area1();
		level.player giveweapon ("springfield");

		level.flag["kill_fake_sniper1"] = true;
		level.flag["shermans_1_check_yourself"] = true;
		level.player setorigin ((761, -1940, 111));

		level thread setup_event7_tank_trigger();
		wait 1;

		level.moody = getent("moody","targetname");
		level.moody.animname = "moody";
		level.moody.pacifist = true;
	
		level.Anderson = getent("Anderson","targetname");
		level.Anderson.animname = "Anderson";
	
		level.Whitney = getent("Whitney","targetname");
		level.Whitney.animname = "Whitney";


		level.moody = getent("moody", "targetname");
	
		level.moody teleport ((122, -1353, 44));
		level.moody.health = 12000; // Moody gets lots of health

		friends2 = getentarray("friends","groupname");
		for(i=0;i<friends2.size;i++)
		{
			friends2[i] thread maps\_utility_gmi::magic_bullet_shield();
			wait 2;
			friends2[i] teleport  ((-802, -1654, 20));


				for(n=0;n<friends2.size;n++)
				{
					if(isalive(friends2[n]))
					{
						node = getnodearray("cover_12", "targetname");
						friends2[n] setgoalnode(node[n]); // Sets EACH friend to the corresponding node.		
					}
				}
					
		}

		println(" ^3 ************8 tele done ***");

		level thread sequence_church();

		println(" ^3 ************end happening ***");	
		level notify("shermans_end_map"); // sends shermans out of town

				// "Take control of the Church"
				objective_add(9, "active", &"GMI_FOY_OBJECTIVE_9", (969,-1497,145));
				objective_current(9);
				level waittill("objective_9_complete");	
				objective_state(9,"done");
				maps\_utility_gmi::autosave(9);
			
				// "Protect the tanks"
				level waittill("objective_10_complete");
				level.num_of_respawns = 0;	
				objective_state(10,"done");
				maps\_utility_gmi::autosave(10);
			
				// "Follow tanks"
				objective_add(11, "active", &"GMI_FOY_OBJECTIVE_11", (504,4024,62));
				objective_current(11);
				level waittill("objective_11_complete");	
				objective_state(11,"done");
				maps\_utility_gmi::autosave(11);
			
				// "Follow tanks"
				objective_add(12, "active", &"GMI_FOY_OBJECTIVE_15", (-1134,6168,140));
				objective_current(12);
			
				objective_position(12, (-434,6267,204));
				objective_ring(12);

				level waittill("objective_12_complete");	
				objective_state(12,"done");


				objective_add(13, "active", &"GMI_FOY_OBJECTIVE_16", (-649,6502,54));
				objective_current(13);

				level notify("shermans_end_map"); // sends shermans out of town

				level waittill("objective_13_complete");	
				objective_state(13,"done");
		wait 300;
	}

	if (getcvar("start") == "tiger1_shot")
	{	
		level.player setorigin ((-224, -1520, 24));
		eTank = getent("tiger1","targetname");
		eTank thread tiger_init(); 
		eTank thread tank_control();
//		eTank thread tiger_fire_think_mg42();
		level thread tiger_destroyed();

		level thread maps\_bombs_gmi::main(8, &"GMI_FOY_OBJECTIVE_8", "tiger1_bomb");
		objective_current(8);
		level waittill("objective_complete8");	
	}

	if (getcvar("start") == "clear_house")
	{
		level.player setorigin ((-606, -1825, 24));
		wait 3;


		moody = getent("moody", "targetname");
		moody teleport ((-606, -1753, 24));
//		moody.health = 12000; // Foley gets lots of health
//		thread event4a_spawn_church_mg42_guy();

		friends2 = getentarray("friends","groupname");
		for(i=0;i<friends2.size;i++)
		{
			friends2[i] thread maps\_utility_gmi::magic_bullet_shield();
			wait 3;
			friends2[i] teleport  ((-426, -864, 24));
			friends2[i] setgoalentity (level.player); // Set denny's goal to be the player.					friends[i].goalradius =  512; // Goal radius, how far the goal is to him	
			friends2[i].followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
			friends2[i].followmax = 2; // How many pathnodes to be ahead of the goal. // this was two		
		}

	}

	if (getcvar("start") == "mg42")
	{
		level thread event4a_spawn_church_mg42_guy_now();
		level.player setorigin ((-606, -1825, 24));

		wait 3;
//		moody teleport ((-606, -1753, 24));
//		moody.health = 12000; // Foley gets lots of health
		wait 360;
//		level thread event7_tank_pre(); 
	}

	if (getcvar("start") == "robb_t")
	{
		level.player setorigin ((-341, 2541, 57));
		level.player giveweapon ("springfield");
		wait 2;
		level.player freezeControls(false);
		level.flag["kill_fake_sniper1"] = true;


		level.flag["shermans_1_check_yourself"] = true;
		level.player setorigin ((761, -1940, 111));

	
		wait 1;

		level.moody = getent("moody","targetname");
		level.moody.animname = "moody";
	
		level.Anderson = getent("Anderson","targetname");
		level.Anderson.animname = "Anderson";
	
		level.Whitney = getent("Whitney","targetname");
		level.Whitney.animname = "Whitney";


		level.moody = getent("moody", "targetname");
	
		level.moody teleport ((122, -1353, 44));
		level.moody.health = 12000; // Foley gets lots of health

		friends2 = getentarray("friends","groupname");
		for(i=0;i<friends2.size;i++)
		{
			friends2[i] thread maps\_utility_gmi::magic_bullet_shield();
			wait 2;
			friends2[i] teleport  ((-20, -1536, 192));


				for(n=0;n<friends2.size;n++)
				{
					if(isalive(friends2[n]))
					{
						node = getnodearray("cover_12", "targetname");
						friends2[n] setgoalnode(node[n]); // Sets EACH friend to the corresponding node.		
					}
				}
					
		}
	}

	if (getcvar("start") == "sniper")
	{
		level.player setorigin ((-224, -1520, 24));
//		trigger = getent("event5a", "targetname");
//		trigger waittill("trigger");
	
		wait 1;
	
		church_door1 = getent("church_door1", "targetname");
		wait 1;
		church_door1 connectpaths();
		church_door1 rotateyaw(140, 0.3,0,0.3);	

		level thread sniper_event6();	
	}

	if (getcvar("start") == "event7")
	{
		level.player setorigin((-224, -1520, 24));
		wait 1;

		level notify("objective_6_complete");		
		// spawner control so the ai stops respawning and the tanks can continue
		level thread event7a_flood_spawner_setup();
		// objective protect tanks
		iprintlnbold(&"GMI_FOY_OBJECTIVE_7");	
		println("^5 Great shot kid: Here come the shermans get up to the church");

		level thread house_fire();
	
		level thread event7_tank_pre(); 
	}
	
	// debug event 8a -- sherman exiting town
	if (getcvar("start") == "event8")
	{
		level.player setorigin ((1144, -1192, 60));
		wait 1;

//		chain = maps\_utility_gmi::get_friendly_chain_node ("4");
		level.player SetFriendlyChain (chain);	
		maps\_utility_gmi::chain_on ("4");
		level thread event8a_start();

		level.eTiger2 = getent("tiger2","targetname");
		//level.eTiger2 maps\_tiger_gmi::init();
		self.isalive = 1;
		self.health  = 20;
		path = getVehicleNode("tiger2_startnode","targetname");
	
		self attachpath (path);
		self startPath();

		trigger = getent("event8f", "targetname");
		println("^3 event8f trigger on");
		trigger waittill("trigger");

		wait 2;

		level thread last_spotter();
		level.player.threatbias = -2;

		// "Flank the elephant tank"
		level thread maps\_bombs_gmi::main(8, &"GMI_FOY_OBJECTIVE_8", "tiger2_bomb");
		objective_current(8);
		level waittill("objective_complete8");	
		objective_state(8,"done");
		println("^2 ************** event8i is popped to early");
		level notify("event8i_attack");
		level notify("shermans_end_map"); // sends shermans out of town
	}

	if(getcvar("start") == "sherman3")
	{
		level.player setorigin ((965, -1187, 60));	
		thread event7a_shermans();
	}

	if(getcvar("start") == "full_shermans")
	{
		level notify("objective_7_complete");	
		println("^5 full sherman event threaded");
		level thread sherman_setup();	
		wait 1;
		level thread sherman_beg_test();
	}


	if (getcvar("start") == "event8i")
	{
		level.player setorigin ((-224, -1520, 24));
		println("^5 event8i trigger should wait for event8i_attack to occur");
//		level waittill("event8i_attack");
		println("^5 event8i has been triggered to early");
		wait 0.25;
		trigger_event8 = getent("event8_i_begin_ai_attack", "targetname");
		println("^1************TRIGGER EVENT8*********** ",trigger_event8);
		trigger_event8 maps\_utility_gmi::triggerOff();
		wait 0.25;
	}

	if (getcvar("start") == "test_sherm_connect")
	{
		level thread sherman_connect_test();
		level.player setorigin ((927, -1867, 59));
//		level thread event8a_start();
		level thread court1_yard_run(); // test guys running by	

		level thread maps\_bombs_gmi::main(8, &"GMI_FOY_OBJECTIVE_8", "tiger2_bomb");
		objective_current(8);
		level waittill("objective_complete8");	
		objective_state(8,"done");
		println("^2 ************** event8i is popped to early");
		level notify("event8i_attack");
		level notify("shermans_end_map"); // sends shermans out of town
	}

	if (getcvar("start") == "guy_sniped")
	{

			roofsnipers = getentarray ("roofsnipers", "targetname");
			for(i=0;i<roofsnipers.size;i++)
			{
				println(" ^3   *********************** spotter should thread before");
				spawned[i] = roofsnipers[i] dospawn(); // Spawns the ACTUAL AI. And sets the Spawned to = the AI.
				self thread event1m_sniper_death(); // AI runs this thread.
			}
	}

	if (getcvar("start") == "88_guy_death")
	{
		level.player setorigin ((-1063, -3702, 122));
//		level thread blow_up_building();
		trigger = getent ("event2a", "targetname");
		trigger waittill("trigger");
		guy_die = getent("mg42_that_88_blows", "targetname");
		level.guy_die_ai = guy_die dospawn();
	}

	if (getcvar("start") == "flak88_bomb")
	{
		level.player setorigin ((101, -3549, 160));	

		level.moody = getent("moody", "targetname");
		level.moody teleport ((-1429, -3226, 10));

		node_moody = getnode("cover_moody_9", "targetname");
		level.moody setgoalnode(node_moody);
		level.moody waittill("goal");

		wait 1;

		friends2 = getentarray("friends","groupname");
		for(i=0;i<friends2.size;i++)
		{
			friends2[i] teleport  ((-1083, -3026, 40));

				node = getnodearray("cover_9", "targetname");
				friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.
		}



		println("^6 ************ everyone in position!"); 
		level thread maps\_bombs_gmi::main(6, &"GMI_FOY_OBJECTIVE_6", "flak88_use");
		objective_current(6);
		level waittill("objective_complete6");	

//		level.moody thread anim_single_solo(level.moody, "now_destroy_88");
		makeAICrouch (getent ("crouch","targetname"));

		objective_state(6,"done");
		wait 5;
		level notify("88_blown_moody_continue");
		println("^3 ************************* objective complete!");

	}

//----------------script chians, exiting the house before mg42 sequence--------------//
	maps\_utility_gmi::chain_off ("10");
	// turns chain off in church
	maps\_utility_gmi::chain_off ("church_chain");
//	maps\_utility_gmi::chain_off ("after_spotter_killed");
//	maps\_utility_gmi::chain_off ("after_88_killed");
	maps\_utility_gmi::chain_off ("entering_second_house");
	maps\_utility_gmi::chain_on ("chain_before_entering_second_house");
	maps\_utility_gmi::chain_off ("chain_belltower_courtyard");
	maps\_utility_gmi::chain_off (200);
	moody = getent("moody","targetname");
	moody thread maps\_utility_gmi::magic_bullet_shield();

	println("************* Moody move thread started**************");
	level.moody = getent("moody","targetname");
	level.moody.animname = "moody";
	level.moody.ignoreme = true;

	level.Anderson = getent("Anderson","targetname");
	level.Anderson.animname = "Anderson";

	level.Whitney = getent("Whitney","targetname");
	level.Whitney.animname = "Whitney";

// Setup hidden or notsolid objects, might make this it's own function later.
	fence1_d = getent("fence1_d","targetname");
	fence1_d notsolid();
	fence1_d hide();

	fence1 = getent("fence1","targetname");
	fence1 solid();
	

// sets up house that is burns down
	level.eburnhouse = getent("burn_house", "targetname");
	level.eburnhouse show();

	level.eburnhouse_d1 = getent("burnhouse_d1", "targetname");
	level.eburnhouse_d1 hide();

	level.eburnhouse_d2 = getent("burnhouse_d2", "targetname");
	level.eburnhouse_d2 hide();
 
	level.eburnhouse_d3 = getent("burnhouse_d3", "targetname");
	level.eburnhouse_d3 hide();

	bm_bridge = getent("exp_12","script_noteworthy");
	bm_bridge_d = getent("exp_12_d", "script_noteworthy");
	bm_bridge_d.origin = bm_bridge.origin;

	bm_boomhouse = getent("boomhouse", "script_noteworthy");
	bm_boomhouse_d = getent("boomhouse_d", "script_noteworthy");
	bm_boomhouse_d.origin = bm_boomhouse.origin;


	garbage = getentarray("garbage", "targetname");
	for(i=0; i < garbage.size; i++)
	{
		garbage[i] delete();
	}


//*** Flak 88 Init setups	
	eFlak88 = getent("flak_88", "targetname" );
	eFlak88 thread flak88_init();
	eflak88 makeVehicleUnusable();// kunt
//	eFlak88.notusable = 1;

//	eFlak88 hide();// hides this because the player cannot use it yet

// level FLags
// this makes the ai stay close to the player durinf the house clearing
	level.maxfriendlies = 6;
	level.friendlywave_thread = maps\foy::Catch_Up;
	level.flag ["shermans_attack1"] = true;
	level.flag ["shermans_god"] = true;
	level.flag["friends_follow_beggining"] = true;
	level.flag["advance_on_town"] = false;
	level.flag["spotter_killed"] = false;
	level.flag["house_clearing_friends_follow"] = false;
	level.flag["get into position after church"] = false;
	level.flag["88_destroyed"] = false;
	level.flag["guys_off_88"] = false;
	level.flag["tiger1_destroyed"] = false;
	level.flag["church_mg42_killed"] = false;
	level.flag["tanks_protected"] = false;
	level.flag["disable_faust_attack"] = false;
	level.flag["shermans_1_check_yourself"] = true;
	level.flag["kill_fake_sniper1"] = true;
	level.flag["shermans_attack_drone"] = false;
	level.flag["player_crossing_bridge"] = false;
	level.flag["shermans_attack_across_bridge"] = false;
	level.flag["tiger2_attack_player_flag"] = false;
	level.flag["foley_ai_still_talking"] = false;
	level.flag ["riley_get_back_here"] = true;
	level.flag ["moody_talking"] = false; // use when you don't want other vo to over lap..
	level.flag ["moody_talking_take_cover"] = false;


	level.flag ["sherman1_can_die_during_protect_tanks"] = false;

//	level.flag["objective10_tracker_complete"] = false; // for not being completed yet.

	level.flag ["sheman_made_it_into_town"] = false; // use when you don't want other vo to over lap..

// THREADS
	level thread friends();
	level thread foley();


// bombs
	level thread tiger_destroyed();
	level thread moody();
	level thread setup_flak_88_bomb();
	level thread blow_up_building();
	level thread barrel_effect_control();
	level thread setup_event7_tank_trigger();
	level thread spawn_guy_table();
	level thread music();
	level thread haystack1();
	level thread house_fire();
	level thread moody_vo_inside_houses(); 
	level thread court1_yard_run(); // test guys running by	 
	level thread blow_bell_tower_think();
	level thread flyby_street_setup();
	level thread p47_flyby();
	level thread p47_flyby_end();
	level thread block_road();


// Sherman setup
	level thread sherman_setup();
	level thread event1o_sniped_guy();
	level thread objectives();
	level thread start_speech();
	level notify("tank_attack_town");
	level thread fake_sniper_area1();
	level thread mg42_supprress_allied_event();
//	level thread bridge_crossing();
	level thread house1a_count_ai_dead(); // new ai count thing for window, threaded at beggining of map... waits for player to touch
}


setup_event7_tank_trigger()
{
	trigger2 = getent("event7a_tanks_roll", "targetname");
	triggers = getentarray("flood_spawner", "targetname");

	for(i=0;i<triggers.size;i++)
	{
		// dead entity is not an object
		if (isdefined(triggers[i]))	//	maybe spot it 
		{
			if(isdefined(triggers[i].script_noteworthy) && triggers[i].script_noteworthy == "bell_tower")
			{
				triggers[i] maps\_utility_gmi::triggerOff();
	
				if (!isdefined(trigger2))
					trigger2 maps\_utility_gmi::triggerOff();
	
				level waittill ("foley_said_speech");
	
				triggers[i] maps\_utility_gmi::triggerOn();
	
				if (!isdefined(trigger2))
					trigger2 maps\_utility_gmi::triggerOn();
			}
		}		
	}
}

event1()
{
	trigger = getent("even1", "targetname");
	trigger waittill("trigger");
}


// this sets up allied characters that work near the player
moody() 
{
	level.moody = getent("moody","targetname");
	level.moody.goalradius = 32;
	level.moody.threatbias = -100;
	level.moody.ignoreme = true;
	level.moody character\_utility::new();
	level.moody character\moody_winter::main();

// Dan - added to help moody (need to reset later)
	level.moody.walkdist = 0;
	level.moody.bravery = 50000;
	level.moody.suppressionwait = 0.5;
	level.moody.dontavoidplayer = 1;
// Dan - end 
}

// this sets up allied characters that work near the player
foley() 
{
	level.foley = getent("foley","targetname");
	level.foley character\_utility::new();
	level.foley character\foley_winter::main();
	level.foley.goalradius = 32;
	level.foley thread maps\_utility_gmi::magic_bullet_shield();
}


// 
foley_talk_move1()
{
//	anim_single (guy, anime, tag, node, tag_entity)		
//	level.foley thread anim_single_solo(level.foley,"open_speech");
	level.foley thread maps\_utility_gmi::magic_bullet_shield();
	efoley_node = getnode("foley_node1", "targetname");
	level.foley setgoalnode(efoley_node);
	level.foley waittill("goal");
		
}

friends()// 
{
	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		friends2[i] thread turn_off_god_after_speech();
		friends2[i].threatbias = -20;
//		friends2[i].pacifist = true;
//		friends2[i].health = 350;
//			if(friends2[i].targetname == "moody") // level.flag ["friends_follow_beggining"] == true && 
//			{
//				println("^6 ***********************  god moody");
//				friends2[i] thread maps\_utility_gmi::magic_bullet_shield();
//			}
//		
//			if(friends2[i].targetname == "Anderson") // level.flag ["friends_follow_beggining"] == true && 
//			{
//				println("^6 ***********************  god Anderson");
//				friends2[i] thread maps\_utility_gmi::magic_bullet_shield();
//			}
//		
//			if(friends2[i].targetname == "Whitney") // level.flag ["friends_follow_beggining"] == true && 
//			{
//				println("^6 ***********************  god Whitney");
//				friends2[i] thread maps\_utility_gmi::magic_bullet_shield();
//			}

	}


	// this should set a health to three of the friends.. so they can die
	friends3 = getentarray("friends","targetname");
	for(i=0;i<friends3.size;i++)
	{
		
		friends3[i].health = 550;
	}
}


turn_off_god_after_speech()
{
		level waittill("attack");
		self notify ("stop magic bullet shield");

			if(self.targetname == "moody") // level.flag ["friends_follow_beggining"] == true && 
			{
				println("^6 ***********************  god moody");
				self thread maps\_utility_gmi::magic_bullet_shield();
			}
		
			if(self.targetname == "Anderson") // level.flag ["friends_follow_beggining"] == true && 
			{
				println("^6 ***********************  god Anderson");
				self thread maps\_utility_gmi::magic_bullet_shield();
			}
		
			if(self.targetname == "Whitney") // level.flag ["friends_follow_beggining"] == true && 
			{
				println("^6 ***********************  god Whitney");
				self thread maps\_utility_gmi::magic_bullet_shield();
			}
}

friends_beg1() // inner left
{
	efriends1 = getentarray("friends_beg1","groupname");

	for(i=0;i<efriends1.size;i++)
	{
		efriends1[i].health = 50000;
//		friends2[i].moveoverride == 1;
		efriends1[i].pacifist = true;

	}

	enode = getnodearray("friends_wait", "targetname");

	for(i=0;i<efriends1.size;i++)
	{
		efriends1[i] setgoalnode(enode[i]);
	}

///////////////////////////////////////////////////////////////////////

	enode = getnode("friends_beg_node1", "targetname");

	efriends1 = getentarray("friends_beg1","groupname");

	for(i=0;i<efriends1.size;i++)
	{
		efriends1[i].health = 50000;
//		friends2[i].moveoverride == 1;
		efriends1[i].pacifist = true;

	}

	level waittill("friends_beg_charge");

	enode = getnode("friends_beg_node1", "targetname");

	for(i=0;i<efriends1.size;i++)
	{
		if(isalive(efriends1[i]))
		{
			efriends1[i].health = 1;
			efriends1[i] setgoalnode(enode);
//			efriends1[i] thread friends_beg1_think();
		}
	}

	for(i=0;i<efriends1.size;i++)
	{
		if(isalive(efriends1[i]))
		{
			efriends1[i] waittill("goal");
		}
	}

	println("^4 *************  efriends beg should run to thier death");
	pop1 = getent("mortar_friends_beg1", "targetname");

	println("Instant Mortar Trigger");
	pop1 instant_mortar();
	thread maps\_utility_gmi::set_ambient("exterior");	
//	org = level.efriends1[i].origin;
//	mortar_hit_explosion (org);

	wait 0.1 + randomfloat(0.6);
	pop1 instant_mortar();	
	wait 0.5 + randomfloat(2);
	pop1 instant_mortar();
	wait 0.5 + randomfloat(2);
	pop1 instant_mortar();
}

friends_beg1_think()
{
	pop1 = getent("mortar_friends_beg1", "targetname");
	self waittill("goal");
	pop1 instant_mortar();	
	wait 0.1 + randomfloat(0.6);
	pop1 instant_mortar();	
}

friends_beg2() // outer right
{
	efriends2 = getentarray("friends_beg2","groupname");

	for(i=0;i<efriends2.size;i++)
	{
		efriends2[i].health = 50000;
//		friends2[i].moveoverride == 1;
		efriends2[i].pacifist = true;

	}

	enode = getnodearray("friends_wait2", "targetname");

	for(i=0;i<efriends2.size;i++)
	{
		efriends2[i] setgoalnode(enode[i]);
	}


	enode = getnode("friends_beg_node2", "targetname");

	efriends2 = getentarray("friends_beg2","groupname");

	for(i=0;i<efriends2.size;i++)
	{
		efriends2[i].health = 50000;
//		friends2[i].moveoverride == 1;
		efriends2[i].pacifist = true;

	}

	level waittill("friends_beg_charge");

	for(i=0;i<efriends2.size;i++)
	{
		efriends2[i] setgoalnode(enode);
	}

	for(i=0;i<efriends2.size;i++)
	{
		efriends2[i].health = 1;
		efriends2[i] waittill("goal");
	}

	println("^4 *************  efriends beg should run to thier death");
	pop1 = getent("mortar_friends_beg2", "targetname");

	println("Instant Mortar Trigger");
	pop1 instant_mortar();	
	wait 0.1 + randomfloat(.3);
	pop1 instant_mortar();	
	wait 0.9 + randomfloat(2);
	pop1 instant_mortar();	
	wait 0.5 + randomfloat(2);
}

// New text objectives are placed
objectives()
{
	// REgroup at shed!
	objective_add(4, "active", &"GMI_FOY_OBJECTIVE_4", (762,-5559,50));
	objective_current(4);
	level waittill("objective_4_complete");	
	objective_state(4,"done");

	// Kill spotter
	objective_add(5, "active", &"GMI_FOY_OBJECTIVE_5", (998,-5340,77));
	objective_current(5);
	level waittill("objective_5_complete");	
	objective_state(5,"done");
	maps\_utility_gmi::autosave(2);

	// "BLow the 88"
	level thread maps\_bombs_gmi::main(6, &"GMI_FOY_OBJECTIVE_6", "flak88_use");
	objective_current(6);
	level waittill("objective_complete6");
	//hold up find some cover
	level.moody thread anim_single_solo(level.moody,"fire_in_the_hole");
	makeAICrouch (getent ("crouch","targetname"));
	objective_state(6,"done");
	maps\_utility_gmi::autosave(3);


	wait 3;
	println("^3 ***************** stuff is blown **********");
	level notify("88_blown_moody_continue");
	println("^3 ************************* objective complete!");

	// "Clear the houses"
	objective_add(7, "active", &"GMI_FOY_OBJECTIVE_7", (-560,-264,45));
	objective_current(7);
	level waittill("objective_7_complete");	
	objective_state(7,"done");

	// tank out the tiger
	level thread maps\_bombs_gmi::main(8, &"GMI_FOY_OBJECTIVE_8", "tiger1_bomb");
	objective_current(8);
	level waittill("objective_complete8");	
		
	level notify("Tiger1_destroyed");
	objective_state(8,"done");

	// "Take control of the Church"
	objective_add(9, "active", &"GMI_FOY_OBJECTIVE_9", (969,-1497,145));
	objective_current(9);
	level waittill("objective_9_complete");	
	objective_state(9,"done");
	maps\_utility_gmi::autosave(9);

	// "Protect the tanks"
//	objective_add(10, "active", &"GMI_FOY_OBJECTIVE_10", (508,-1543,477));
//	objective_current(10);
	level waittill("objective_10_complete");
	level.flag ["shermans_god"] = false;
	level.num_of_respawns = 0;	
	objective_state(10,"done");
	maps\_utility_gmi::autosave(10);

	// "Follow tanks"
	objective_add(11, "active", &"GMI_FOY_OBJECTIVE_11", (504,4024,62));
	objective_current(11);
	level waittill("objective_11_complete");	
	objective_state(11,"done");
	maps\_utility_gmi::autosave(11);

	// "Follow tanks"
	objective_add(12, "active", &"GMI_FOY_OBJECTIVE_15", (-1134,6168,140));
	objective_current(12);
	level waittill("objective_12_complete");	
	objective_state(12,"done");

	maps\_utility_gmi::autosave(13);

	objective_add(13, "active", &"GMI_FOY_OBJECTIVE_16", (-649,6502,54));
	objective_current(13);

//	objective_position(12, (-434,6267,204));
//	objective_ring(12);


//	objective_position(num, level.blue[0].origin);
//	objective_position(undifined, (-434,6267,204));


//	objective_current(13);
//	level waittill("objective_13_complete");



//	// "Flank the antitank in the barn"
//	level thread maps\_bombs_gmi::main(12, &"GMI_FOY_OBJECTIVE_8", "tiger2_bomb");
//	objective_current(12);
//	level waittill("objective_complete12");
//	level thread tiger2_death();	
//	objective_state(12,"done");

	level notify("shermans_end_map"); // sends shermans out of town

	level waittill("objective_13_complete");	
	objective_state(13,"done");

}

// this makes the bomb on the 88 hidden
setup_flak_88_bomb()
{
	println("^2 first flak gun blow up stuff is hidden");

	charge = getent("auto862", "targetname");
	charge hide();

	flak88_use = getent("flak88_use", "targetname");
	flak88_use hide();
	flak88_use maps\_utility_gmi::triggerOff();

	level waittill("show_bomb1");

	eflak88 = getent("flak_88","targetname");

	charge show();
	flak88_use maps\_utility_gmi::triggerOn();
	flak88_use show();



	flak88_use waittill("trigger");  // planting bomb

	eflak88 = getent("flak_88","targetname");
	eflak88 makeVehicleUnusable(); // kunt
//	eflak88.notusable = 1;

}

level_guy_die_ai_death()
{
	self waittill("death");
	println("^3 *************  death one  *************");
	level notify("show_bomb1");
	println("^3 *************  death two  *************");
	// move this two commands over to ensure they happen
	level notify("friends4_now_go_inside_town");
	println("^3 *************  death three  *************");
	level notify("sherman tanks go");
	println("^3 *************  mg42 guys has notified  *************");
}

blow_up_building()
{

	trigger = getent("building1", "targetname");
	trigger waittill("trigger");

	if(isalive(level.guy_die_ai ))
	{
		level.guy_die_ai DoDamage ( level.guy_die_ai.health + 120, level.guy_die_ai.origin );
	}


	wait 0.25;
	emg42 = getent("auto1306", "targetname");
	emg42 notify("stopfiring");
	wait 0.25;
	emg42 delete();
	
	org = getent ("building_fire_high","targetname");
        blend = spawn( "sound_blend", ( 0.0, 0.0, 0.0 ) );
        blend.origin = (-511, -3370, 380);

        for (i=0;i<1;i+=0.01)
        {
                blend setSoundBlend( "building_fire_low", "building_fire_high", i );
                wait (0.04);
        }

//	wait 3;
}

// allied soldiers will take cover behind wood shed -- basic trigger activated by player calling into script
event1m()
{
	wait 3.2;

	level.moody thread event1o_counter();
	println("^2TRIGGER ******** moody at shed");
}

// this creates two snipers and stops the mortars when they've both been killed
event1m_sniper_death()
{
	self.goalradius = 3;	
	println (self.targetname, " ^1is waiting for death!");	// telling it self to print 

	self waittill ("death"); // Waits until the AI is dead.

	println (self.targetname, " ^1is DEAD!!!");	// telling itseld to print when dead

//	level.roofsnipers_count++;
//	if(level.roofsnipers_count == 1) // Checks the death count of roofsnipers.
//	{
		println ("^3 fence blown up, squad move forward");
		level notify("objective_5_complete");	
		level notify("moody_start_cover_7");	// this tells the moody_move_thread to pick up after hes gone to cover6 
		level.flag["advance_on_town"] = false;	// turns mortar kills off
//	}	
}

//=====================================================================================================================
//	event_mg42s_init
//
//		Makes mg 42 accurate at beggining and less accurate after spotter event
//=====================================================================================================================
event2_mg42s_init() // line 1369 of 1to2 gsc is where goldberg says his line this is where you should activate... stealth tracker... 
{
	field_mg42 = getent("auto1301","targetname");
//	field_mg42.script_delay_min = 0.5;
//	field_mg42.script_delay_max = 1.5;
//	field_mg42.script_burst_min = 1;
//	field_mg42.script_burst_max = 3;

	field_mg42.script_accuracy = .2;
	field_mg42 setmode("auto_ai"); // auto, auto_ai, manual
	println("^2 *****************  accuracy field_mg42:   ", field_mg42.script_accuracy );

//	field_mg42 thread event2_mg42_used();
	side_mg42 = getent("auto1113","targetname");
//	side_mg42.script_delay_min = 0.5;
//	side_mg42.script_delay_max = 1.5;
//	side_mg42.script_burst_min = 1;
//	side_mg42.script_burst_max = 3;
	side_mg42.script_accuracy = .2;
	side_mg42 setmode("auto_ai"); // auto, auto_ai, manual

	println("^2 *****************  accuracy side_mg42:   ", side_mg42.script_accuracy );


	level waittill ("objective_5_complete"); // wait for spotter to be killed

	field_mg42.script_accuracy = .1;
	side_mg42.script_accuracy = .1;

	println("^2 *****************  accuracy field_mg42:   ", field_mg42.script_accuracy );	
	println("^2 *****************  accuracy side_mg42:   ", side_mg42.script_accuracy );
//	side_mg42 thread event2_mg42_used();
}



// sniper event 
// guy who comes running from around corner to only get sniped
event1o_sniped_guy()
{

	poor_bastard = getent("poor_bastard", "targetname");
	wait 0.5;
	poor_bastard = poor_bastard dospawn();
	level thread friends4();
	wait 0.5;

	wait 0.1;
	if(isalive(poor_bastard))
	{
//	println("^3 ***************************  :  ", epoor_bastard_ai.targetname, epoor_bastard_ai.health, epoor_bastard_ai.origin);
		poor_bastard.animname = "poor_bastard";
		poor_bastard.threatbias = -50;
		poor_bastard.goalradius = 20;
		poor_bastard.health = 50000;
		poor_bastard.ignoreme = true;
		poor_bastard.walkdist = 0;
		poor_bastard.bravery = 50000;
		poor_bastard.suppressionwait = 0.5;
		poor_bastard.dontavoidplayer = 1;
		poor_bastard.dropweapon = 0;
	}

	level waittill("come_to_death");

	enode = getnode("talk_to_moody1", "targetname");
	wait 0.1;
	poor_bastard setgoalnode(enode);
	poor_bastard waittill("goal");

	poor_bastard thread event1o_counter();

	println("^3************************* poor man waiting for death now...");
	level waittill("moody_at_shed");
	level thread sherman_mortars();

//	anim_single (guy, anime, tag, node, tag_entity)	
	//can't move up pinned down
	poor_bastard thread anim_single_solo(poor_bastard,"assault_is_going_nowhere");
//anim/sound end
	level notify("blow_sherman_5");

	wait 7.8;

	poor_bastard playsound ("head_shot");

	println("^2TRIGGER ******** poor bastard gets shot now!");
	poor_bastard thread maps\foy_dummies::bloody_death(true);

	wait 0.2;

	pop1 = getentarray("mortar_foley", "targetname");
	if(isalive(level.foley))
	{
		level.foley notify ("stop magic bullet shield");
		level.foley.health = 1;
	}

	for(i=0;i<pop1.size;i++)
	{
		println("Instant Mortar Trigger");
		pop1[i] instant_mortar();
	}
	
	level notify("objective_4_complete");
	wait 0.05;

	println("^5 EVENT1M, Were pinned down here, get the spotter");
                                                                                                     

	level.Anderson = getent("Anderson", "targetname");
	wait 0.25;

//	wait 0.5; 
//anim/sound begin
//	anim_single (guy, anime, tag, node, tag_entity)	
	//can't move up pinned down
	level.moody thread anim_single_solo(level.moody,"On_me");
//anim/sound end

	wait 2.2;
//anim/sound begin
//	anim_single (guy, anime, tag, node, tag_entity)	
	//can't move up pinned down
	level.moody thread anim_single_solo(level.moody,"look_for_position");	
	wait 7.9;
	level notify("moody_done_talking");
//anim/sound end


	roofsnipers = getentarray ("roofsnipers", "targetname");                                                  
	for(i=0;i<roofsnipers.size;i++)                                                                          
	{                                                                                                        
		spawned[i] = roofsnipers[i] dospawn(); // Spawns the ACTUAL AI. And sets the Spawned to = the AI.                           
		wait 0.05;                                                                                          
                                                                                                                 
			// If the AI that dies has script_noteworthy "spotter" then stop the mortars.            
			if(isdefined(spawned[i].script_noteworthy) && spawned[i].script_noteworthy == "spotter") 
			{                                                                                        
//				spawned[i].                                                                      
				println("^3 ********************* spotter got info for his spot! *************");
				println("^3 ********************* spotter got info for his spot! *************");
				println("^3 ********************* spotter got info for his spot! *************");
				println("^3 ********************* spotter got info for his spot! *************");
				spawned[i] thread spotter_anim_think();	                                         
				spawned[i] thread event1m_sniper_death(); // AI runs this thread.                
//				node = getnode("spotter_spot", "targetname");                                    
//				spawned[i] setgoalnode(node);                                                    
			}   

			if(isdefined(spawned[i].script_noteworthy) && spawned[i].script_noteworthy == "sniper") 
			{                                                                                                                                
				spawned[i].accuracy = 0.7; // AI runs this thread.   
				spawned[i] thread sniper_death_fall(); // AI runs this thread.                
//				node = getnode("spotter_spot", "targetname");                                    
//				spawned[i] setgoalnode(node);                                                    
			}                                                                                       
                                                                                                                 
	}   
}

sniper_death_fall()
{
	self.health = 5;
     	self.playpainanim = false;		// this should keep the guy from reacting to pain
	self allowedStances ("stand");
}

spotter_anim_think()
{
	wait 6;
	self.animname = "spotter";
	wait 0.05;
	self animscripts\shared::putGunInHand ("none");
//	guy1 thread anim_loop_solo(guy1, "map_read1", "TAG_ORIGIN", "o1 stop anim", table);	
	self.allowdeath = true;
	self thread anim_loop_solo(self,"spot_anim", undefined, "end anim");	
}	

// chruch mortar event
sherman_mortars()
{
	for(i=1;i<8;i++)
	{
		pop[i] = getent("mortar_shermans_" + i, "targetname");
	}

//	for(n=0;n<10;n++)
//	{
//		wait 0.1 + randomfloat(1.6);	
//		num = (randomint(7)+1);
//		pop[num] instant_mortar();		
//	}

	for(n=0;n<5;n++)
	{
//		wait 0.1 + randomfloat(1.6);	
		wait 0.8 + randomfloat(2.3);	

		num = (randomint(7)+1);
		pop[num] instant_mortar();		
	}
}

// makes sure moody and poor have checked in so the script can continue
event1o_counter()
{

	println(" ^6 *******************  event1o_counter **************  count up");
	level.event1o_count++;
	if(level.event1o_count == 2) // Checks the death count of roofsnipers.
	{
		wait 0.25;
		println(" ^6 *******************  event1o_counter **************  count up");
		level notify("moody_at_shed");
	}		
}

/////////////////////////////////////////////////////////////////////
friends4()
{
	println("***************** friends4 setup *****************");
	friends4_array =[];// this defines it as an array
	friends4_group = getentarray("friends4", "groupname");
	println("^2 ************* ", friends4_group.size);
	println("^6**************** friends4 group and array setup!");
	for(i=1;i<(friends4_group.size+1);i++)//		
	{
		friends4_array[i] = getent("friends4_guy_" + i, "targetname");
		println("^6 **************** friends4 made it into for loop!");		
		// MikeD: If you want to force a spawn, use stalingradspawn()
		friends4_array_ai = friends4_array[i] dospawn();

		if(isdefined(friends4_array_ai))
		{
			println("^6 **************** I imade it: ", i);	
			friends4_array_ai thread maps\_utility_gmi::magic_bullet_shield();
			friends4_array_ai.pacifist = true;
	//		friends4_array_ai[i] thread friends4_think(i);
			friends4_array_ai thread friends4_think(i);
		}
	}
}

friends4_think(i)
{	
	node1 = getnode("friends4_spot_" + i, "targetname");
	node2 = getnode("friends4_spot2_" + i, "targetname");
	node3 = getnode("friends4_spot3_" + i, "targetname");
	level waittill("friends4_now_go_haystack");
	level notify("stop punishing player");
	self setgoalnode(node1);
	self waittill("goal");
	wait 10;

	println("^3 ***************** friends4 combat started getting node *****************");
	self setgoalnode(node2);	
	println("^3  ***************** friends4 combat started going to node *****************");
	self waittill("goal");

	level waittill("friends4_now_go_inside_town");
	self setgoalnode(node3);
	self.goalradius = 20;	
	println("^3  ***************** friends4 combat started going to node *****************");
	self waittill("goal");
	self delete();

}
///////////////////////////////////////////////////////////////////

// Instead of using the standard burnville mortars, I modified it so that the mortar distance can be adjusted when wanted.
mortars()
{
	level endon ("stop falling mortars");
	maps\_mortar_gmi::setup_mortar_terrain();
//	ceiling_dust = getentarray("ceiling_dust","targetname");

	while (1)
	{
		if ((distance(level.player getorigin(), self.origin) < level.mortar_maxdist) &&
			(distance(level.player getorigin(), self.origin) > level.mortar_mindist))
		{
//			println("MORTAR DELAY",level.mortar_random_delay);
			wait (3 + randomfloat (level.mortar_random_delay));			
			maps\_mortar_gmi::activate_mortar();
			if(isdefined(level._effect) && isdefined(level._effect["ceiling_dust"]))
			{
				for(i=0;i<ceiling_dust.size;i++)
				{
					if(distance(self.origin, ceiling_dust[i].origin) < 512)
					{
						playfx ( level._effect["ceiling_dust"], ceiling_dust[i].origin );
						ceiling_dust[i] playsound ("dirt_fall");
					}
				}
			}
			wait (level.mortar_random_delay);
		}

		wait (1);
	}
}


// sets up triggers so instant mortars occur around the player
setup_triggers()
{
	// Setup instant mortars that are triggered by a brush.
	instant_mortars = getentarray("instant_mortar","groupname");
	for(i=0;i<instant_mortars.size;i++)
	{
		instant_mortars[i] thread instant_mortar_trigger();
	}
}


haystack1()
{
	trigger = getent("blow_haystack1", "targetname");
//	trigger = getent(self.targetname,"target");
	trigger waittill("trigger");
	pop1 = getent("instant_mortar", "targetname");
	println("Instant Mortar Trigger");
	pop1 instant_mortar();

	// blow haystack 1a
	trigger = getent("blow_haystack1a", "targetname");
	trigger waittill("trigger");

	pop1 = getent("instant_mortar_1a", "targetname");
	println("Instant Mortar Trigger");
	pop1 instant_mortar();


	// here for now, starts next hay attack
	trigger = getent("88_attack_hay", "targetname");
	trigger waittill("trigger");
	maps\_spawner_gmi::kill_spawnerNum(1);


	// MikeD: Wait for player to get to blow_haystack1, then start the haystack dummies.
	level thread dummies_westhill();

	level notify ("88_attack_haystack");
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
		self playsound ("shell_explosion1");
	}
	else if (soundnum == 2)
	{
		self playsound ("shell_explosion2");
	}
	else
	{
		self playsound ("shell_explosion3");
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
		self playsound ("shell_incoming1");
		if(isdefined(self.sound_delay))
		{
			wait (self.sound_delay);
		}
	}
	else
	if (soundnum == 2)
	{
		self playsound ("shell_incoming2");
		if(isdefined(self.sound_delay))
		{
			wait (self.sound_delay);
		}
	}
	else
	{
		self playsound ("shell_incoming3");
		if(isdefined(self.sound_delay))
		{
			wait (self.sound_delay);
		}
	}
}


// end instant mortar stuff

friends_pacifist_off()
{
	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
			println("^3 **************** pacifist off for friends *************");
			friends2[i].threatbias = 0;
			println("^3 ***************** pacifrist off");
			friends2[i].pacifist = false;
		}
	}	
}

friends_pacifist_on()
{
	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
			friends2[i].threatbias = 0;
			println("^3 ***************** pacifrist off");
			friends2[i].pacifist = true;
		}
	}	
}


friends_move_thread(name)
{
	println(" ^3 friends move function should work now!");
	num = 0; // setting it to start at the third haystack -- for starting events later in the level.
	while(1) // loop forever
	{
		if(num > 0) // TEMPORARY for Getting guys to hide off the bat, remove when num = 0, basically when the player starts from the beginning of the map.
		{
			level waittill("friends move forward"); // Wait until the level "notifies" "friends move forward". After the sgt talks.
		}
		num++;	// increases the num by each time it is called

		nodes = getnodearray("cover_" + num,"targetname"); // Get all of the nodes the specified targetname.
		
		friends = getentarray(name,"groupname"); // Get all of the friends.
		for(i=0;i<friends.size;i++) // Reason why we do this, is cause "friends" is an array... Not just 1 entity.
		{
			if(isalive(friends[i]) && friends[i].targetname != "moody" && level.flag ["house_clearing_friends_follow"] == false) 
			{
				println("Guy ", friends[i].targetname);
				println("Node Name ",nodes[i].targetname);
				friends[i] setgoalnode(nodes[i]); // Sets EACH friend to the corresponding node.
				friends[i].maxsightdistsqrd = 0.01;
				friends[i].accuracy = 0.2;
				friends[i].pacifist = true;
				friends[i].walkdist = 0;
				friends[i].bravery = 50000;
				friends[i].suppressionwait = 0.5;
				friends[i].dontavoidplayer = 1;
				friends[i].ignoreme = true;
					
				if(friends[i].targetname == "Anderson" && level.flag ["friends_follow_beggining"] == true) // level.flag ["friends_follow_beggining"] == true && 
				{
					println("^6 **********   Anderson and Whitney should now follow player3");				
//					friends[i] setgoalentity (level.player); // Set denny's goal to be the player.	
//					friends[i].goalradius =  212; // Goal radius, how far the goal is to him	
//					friends[i].followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
//					friends[i].followmax = 5; // How many pathnodes to be ahead of the goal. // this was two
				}

				if(friends[i].targetname == "Whitney" && level.flag ["friends_follow_beggining"] == true) // level.flag ["friends_follow_beggining"] == true && 
				{
					println("^6 **********   Anderson and Whitney should now follow player3");				
//					friends[i] setgoalentity (level.player); // Set denny's goal to be the player.	
//					friends[i].goalradius =  212; // Goal radius, how far the goal is to him	
//					friends[i].followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
//					friends[i].followmax = 4; // How many pathnodes to be ahead of the goal. // this was two
				}
			}
	
			// when the ai gets to the houses set the goal to the player so they follow him
			else if(isalive(friends[i]) && level.flag ["house_clearing_friends_follow"] == true)
			{
				friends[i].maxsightdistsqrd = 9000;
				friends[i].accuracy = 1;
				println(" Friends should now follow player");
				friends[i] setgoalentity (level.player); // Set denny's goal to be the player.	
				friends[i].goalradius =  512; // Goal radius, how far the goal is to him	
				friends[i].followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
				friends[i].followmax = 2; // How many pathnodes to be ahead of the goal. // this was two
			}
		}
		wait 0.25;
	}
}


/////////////--------------------------///////////

////////////----- NEW PUNISH _____________//////////
timer()
{
	level.timer_trigger = "not_hit";
	trigger = getent ("end_timer", "targetname");
	trigger thread timer_trigger();

	wait (40);
	if (level.timer_trigger != "hit")
		println ("10 SECONDS LEFT");

	wait (5);
	if (level.timer_trigger != "hit")
		println ("5 SECONDS LEFT");

	wait (5);

	if (level.timer_trigger != "hit")
	{
		println ("TOO SLOW, 0 SECONDS LEFT");
		origin = (level.player getorigin() );
		level.player maps\_mortar::incoming_sound();
		radiusDamage ( origin, 400, 10000, 10000);
		playfx ( level.mortar, origin );
		level.player maps\_mortar::mortar_sound();
		earthquake(0.15, 2, origin, 850);
	}
}

timer_trigger()
{
	self waittill ("trigger");
	println ("TIMER OFF");
	level.timer_trigger = "hit";
}

/////////////--------------------------///////////

////////////----- NEW PUNISH _____________//////////


// this is called everytime the player does not remain in the trigger of safety for each position...
punish_player() // moody_regroup rich lines..
//punish_player(trigger)
{
//	dist = distance(this.origin, that.origin);

	level thread new_distance_tracker();

	level endon("stop punishing player");
	println("^4 *********** punish player ready");
//	while (!level.flag["mortars stop"])
//	while(level.flag["advance_on_town"])
	wait 1;
	while(1)
	{
		timer = gettime() + 4000;
		level.player.threatbias = 0;

 		while (distance (level.player getorigin(), level.whitney.origin) > 1000)

//		while (distance (level.player getorigin(), level.squad.origin) > 1000)


//		while (distance (level.player getorigin(), level.moody.origin) > 750)
		{

			level thread get_over_here_riley_750();			

			println("^6 *********** THreat bias is up player more then 750 away from moody*********");
			level.player.threatbias = 100;
// old			while (distance (level.player getorigin(), level.whitney.origin) > 1200)


//			while (distance (level.player getorigin(), level.squad.origin) > 1200)	

			while (distance (level.player getorigin(), level.moody.origin) > 1200)


	//		while (!level.player istouching (trigger))
			{	


			level thread get_over_here_riley_750();	


				if (gettime() > timer)
				{
					println("^6 *********** THreat bias is up part 2, player more then 1900 away from moody *********");	
					origin = (level.player getorigin() );
	//				level.player maps\_mortar::incoming_sound();
					org = level.player.origin;
					playSoundinSpace ("mortar_incoming", org);
					radiusDamage ( origin, 20, 20, 20);
//					radiusDamage ( origin, 400, 10000, 10000);
					playfx ( level.mortar, origin );
					level.player maps\_mortar::mortar_sound();
					earthquake(0.15, 2, origin, 850);
	
	//				org = level.player.origin;
					playSoundinSpace ("mortar_incoming", org);
					wait 0.05;
	//				mortar_hit_explosion (org);

					level thread get_over_here_riley_750();		
				}
	
	//			if(!level.flag["advance_on_town"])
	//			{
	//				break;
	//			}
	
 					while (distance (level.player getorigin(), level.whitney.origin) > 1400)


//					while (distance (level.player getorigin(), level.squad.origin) > 1700)

//					while (distance (level.player getorigin(), level.moody.origin) > 1300)


					//while (distance (level.player getorigin(), level.moody.origin) > 2300)
			//		while (!level.player istouching (trigger))
					{

						level thread get_over_here_riley_750();	

						println("^6 *********** THreat bias is up part 3, player more then 1300 away from moody *********");
						origin = (level.player getorigin() );
		//				level.player maps\_mortar::incoming_sound();
						org = level.player.origin;
						playSoundinSpace ("mortar_incoming", org);
						radiusDamage ( origin, 400, 10000, 10000);
						playfx ( level.mortar, origin );
						level.player maps\_mortar::mortar_sound();
						earthquake(0.15, 2, origin, 850);
						wait 0.05;


							if(isalive(level.player)							) { level.player 
							allowStand(false); 
							level.player 
							allowCrouch(false); 
							level.player 
							allowProne(true);
								
								wait 0.15;
								level.player viewkick(63, level.player.origin);  //Amount should be in the range 0-127, and is normalized "damage".  No damage is done.
								level.player shellshock("default_nomusic", 3);
								
								wait 1.5;
								
								level.player allowStand(true);
								level.player allowCrouch(true);
							}


					}


				wait 1.8 + randomfloat(0.5);
			}
	
	//		if(!level.flag["advance_on_town"])
	//		{
	//			break;
	//		}
			wait 1 + randomfloat(0.5);
		}
		
	wait 0.05;
	}
}

new_distance_tracker()
{
}


// thread each guy.. set variable for each guy when player is close or false
// then function that runs to hurt player 

new_tracker_punish_player()
{
}

player_shellshock()
{
	//main(duration, nMaxDamageBase, nRanDamageBase, nMinDamageBase, nExposed, customShellShock)
	thread maps\_shellshock::main(3, undefined, undefined, undefined, undefined, "default_nomusic");
}

// riley get over here now when he is at the distance of 750 -- this still happens to often
get_over_here_riley_750()
{
	// set flag true
	if(level.flag ["riley_get_back_here"] == true)
	{
		level.flag ["riley_get_back_here"] = false;	// dont repeat yelling at player!!
		level.moody thread anim_single_solo(level.moody,"moody_regroup");
		wait 6;
		level.flag ["riley_get_back_here"] = true;	// now yell at the player again
	}
}



new_movement_control()
{
	println("^3 ******************  New movement control is working now ************");
	println("^3 ******************  trigger 3 waiting ************");
	trigger = getent("event1l_cover3","targetname");
	trigger waittill("trigger");
	level notify("player_hit_trigger_3");
	println("^3 ******************  trigger 3 used ************");
	level thread punish_player();

	trigger = getent("event1l_cover4","targetname");
	trigger waittill("trigger");
	level notify("player_hit_trigger_4");
	println("^3 ******************  trigger 4 used ************");

	trigger = getent("event1l_cover5","targetname");
	trigger waittill("trigger");
	level notify("player_hit_trigger_5");
	println("^3 ******************  trigger 5 used ************");
	// setting this up here because he is pulled out of it again
	level.moody.ignoreme = true;

	trigger = getent("event1l_cover6","targetname");
	trigger waittill("trigger");
	level notify("player_hit_trigger_6");
	println("^3 ******************  trigger 6 used ************");


	level thread event1l_cover_germans_run();
}

// if any enemies are alive at shed..., grab them and em run aways when the player hits this event1l_cover6 trigger
event1l_cover_germans_run()
{
	germans = getentarray("sniper_runaway", "groupname");
	if(isalive(germans))
	{
		for(i=0;i<germans.size;i++)
		{
			germans[i].pacifist = true;
			node = getnodearray("sniper_runaway_cover");
			germans[i] setgoalnode(node[i]);
			germans[i] waittill("goal");	
			germans[i].pacifist = false;
		}
	}
}


// Controls Moody's movement.
moody_move_thread()	// this is the long way of writing this code out.. I will optimise at end of script.. so I know how to condense
{
	// new change
	friends = getaiarray ("allies");
	for (i=0;i<friends.size;i++)
	{
		friends[i] animscripts\shared::SetInCombat();
		friends[i] allowedStances ("stand");
	}

//	level thread new_movement_control();
	moody = getent("moody","targetname");

	level.flag["advance_on_town"] = true;
	node_moody = getnode("cover_moody_1", "targetname");
	moody setgoalnode(node_moody);
	level notify("friends move forward"); // cover4
	level thread foley_talk_move1();
//	moody waittill("goal");
	println("^3****************  :  ", moody.goalradius);


	trigger = getent("event1l_cover2","targetname");
	println("^2TRIGGER IS ON!");
	trigger waittill("trigger");

	level notify("friends_beg_charge");

	maps\_utility_gmi::autosave(1);

	// stops anderson and whit from following player in beggining
	println(" ^6 ************** ander and whit should stop following..");
	level.flag["friends_follow_beggining"] = false;

	// follow foley
	level notify("objective_1_complete");
		
//anim/sound begin
	level.moody = getent("moody","targetname");
	level.moody.animname = "moody";

//	level thread mg42_nest_obj();
	objective_position(2,(-2822, -5846, 214));

	mortars = getentarray("mortar","targetname");
	for(i=0;i<mortars.size;i++)
	{
		mortars[i] thread mortars();
	}

	level thread new_movement_control();
	
	level notify("friends move forward"); // cover4
	wait 0.1;

	level.flag["advance_on_town"] = true;
	node_moody = getnode("cover_moody_2", "targetname");
	moody setgoalnode(node_moody);

	wait 0.5;

	level waittill("player_hit_trigger_3");

	level.crew_88 = getentarray("88_crew", "groupname");
	for(i=0;i<level.crew_88.size;i++)
	{
		level.crew_88[i] thread last_guys_near_88_think();
	}


	for (i=0;i<friends.size;i++)// resets ai stances
	{
		if(isalive(friends[i]))
			friends[i] allowedStances ("crouch", "prone", "stand");
	}

//	anim_single (g-uy, anime, tag, node, tag_entity)	
	// OK_ladies
	level.moody thread anim_single_solo(level.moody,"OK_ladies");
//anim/sound end


//	moody waittill("goal");

	println("^3****************  :  ", moody.goalradius);
	println("^5 Hold it here, wait for the opening, on my lead");


//	level thread punish_player();


//	wait 9;
//	trigger maps\_utility_gmi::triggerOn();
//	println("^2TRIGGER IS ON!");

//	level waittill("player_hit_trigger_3");
//	trigger waittill("trigger");


//	level notify("stop punishing player");
	objective_position(2,(-1546, -6090, 2230));

	level notify("friends move forward"); // cover4

	node_moody = getnode("cover_moody_3", "targetname");
	moody setgoalnode(node_moody);
//	moody waittill("goal");

//	trigger = getent("event1l_cover4","targetname");
//	iprintlnbold(&"GMI_FOY_HAY_WAIT");
	println("^5 Hold it here, wait for the opening, on my lead");

//	level thread punish_player(trigger);
//	wait 9;
//	trigger maps\_utility_gmi::triggerOn();
	println("^2TRIGGER IS ON!");
//	trigger waittill("trigger");
	level waittill("player_hit_trigger_4");

	// half way there
	level.moody thread anim_single_solo(level.moody,"Half_way_there");


	objective_position(2,(-775, -6719, 200));

//	level notify("stop punishing player");


	level notify("friends move forward"); // cover4

	node_moody = getnode("cover_moody_4", "targetname");
	moody setgoalnode(node_moody);

	println("^2TRIGGER IS ON!");
	level waittill("player_hit_trigger_5");

	println("^2TRIGGER ******** poor bastard coming to death now!");
	level notify("come_to_death");

	wait 0.25;
	// assualt on town
	level notify("objective_2_complete");

	println("^2TRIGGER HAS BEEN TRIGGERED!");


//	wait 1;
//	iprintlnbold(&"GMI_FOY_HAY_MOVE");
	println("^5 EVENT1l, OK, keep movin to the next hay stack cover5 go go go !");	
//	wait 1;

//	moody thread print_dialog3d(moody,"MOVE OUT!"); // Fun print stuff.

	// were moving up take out the mg42
//	iprintlnbold(&"GMI_FOY_MG42_1");
	node_moody = getnode("cover_moody_5", "targetname");
	moody setgoalnode(node_moody);
	level notify("friends move forward"); // cover5
//	moody waittill("goal");	
	objective_position(2,level.moody.origin);

	// MikeD: DUMMIES Wait for player to get to EVENT1L_COVER5, then start the haystack dummies.
	level thread dummies_easthill();

	// Get_to_that_shed
	level.moody thread anim_single_solo(level.moody,"Get_the_lead");

	println("^5 Hold it here, wait for the opening, on my lead");	

	println("^2TRIGGER IS ON!");
	level waittill("player_hit_trigger_6");

	println("^2 ******** GET THE LEAD OUT PEOPLE!!");
	level.moody thread anim_single_solo(level.moody,"Get_to_that_shed");


	println("^2TRIGGER HAS BEEN TRIGGERED!");

	level thread dummies_haystack();
	level notify("friends move forward"); // cover6  // this stops the action so it can be started at another point

	node_moody = getnode("cover_moody_6", "targetname");
	moody setgoalnode(node_moody);
	moody waittill("goal");


	// Hold_up
	level.moody thread anim_single_solo(level.moody,"Hold_up");
	level thread event1m();
	level thread friends_pacifist_off();

	level waittill("moody_start_cover_7");	// this tells the moody_move_thread to pick up after hes gone to cover6

	trigger = getent("event1m_cover7","targetname");
	trigger waittill("trigger"); // use a distance check... instead of a trigger here now.

	//Use the 88 on the mg42 nest
	level.moody thread anim_single_solo(level.moody,"good_work_88_now");

	println("^5 Nice shooting kid, now we can move into position on the 88");
	wait 1;
	level notify("stop falling mortars");	// I used to call this from the sniper death but it happened to early
	println("waiting for moody to finish dialogue");
	level.moody waittill ("good_work_88_now");


	println("^5 FENCE IS NOW BLOWN");

	pop2 = getent("instant_mortar_fence", "targetname");
	println("Instant Mortar Trigger");
	pop2 instant_mortar();	
	wait 0.4;

	fence1_d = getent("fence1_d","targetname");
	fence1_d solid();
	fence1_d show();

	fence1 = getent("fence1","targetname");
	fence1 notsolid();
	fence1 hide();

	fence1 connectpaths();

	level notify("friends4_now_go_haystack");
	maps\_utility_gmi::chain_on ("after_spotter_killed");
	wait 1;
	level thread last_guys_near_88();

	level.moody setgoalentity (level.player);
	level.moody.pacifist = false;
	level.moody.goalradius = 512;
	level.moody.followmin = 0; // Follow, how many pathnodes to follow behind the goal.
	level.moody.followmax = 3; // How many pathnodes to be ahead of the goal.
	level.moody.walkdist = 128;
	level.moody.bravery = 50000;
	level.moody.suppressionwait = 1;
	level.moody.dontavoidplayer = 0;
	level.moody.ignoreme = false;

	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
			println(" Friends should now follow player");
			friends2[i] setgoalentity (level.player); // 	
			friends2[i].pacifist = false;
			friends2[i].goalradius =  512; // Goal radius, how far the goal is to him	
			friends2[i].followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
			friends2[i].followmax = 3; // How many pathnodes to be ahead of the goal. // this was two
			friends2[i].walkdist = 128;
			friends2[i].bravery = 50000;
			friends2[i].suppressionwait = 1;
			friends2[i].dontavoidplayer = 0;
			friends2[i].ignoreme = false;
		}
	}

	// this makes tanks move forward
	level notify("sherman tanks go"); // If you put in the while, take this out.
	level.flag ["shermans_attack1"] = false;

	trigger2 = getent ("get_on_mg42", "script_noteworthy");
	println("^3 *************  ", trigger2.script_noteworthy);
	trigger2 waittill ("trigger");
//	maps\_utility_gmi::chain_off ("after_spotter_killed");
	wait 1;

	level.Whitney thread anim_single_solo(level.Whitney,"whitney_top_floor");
	println("^3 ***************  whitney_top_floor **********");

	wait 1;

	level waittill("show_bomb1");

	maps\_utility_gmi::chain_off ("after_spotter_killed");
	// pushing in towards the 88
	node_moody = getnode("cover_moody_9", "targetname");

	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
			node = getnodearray("cover_9", "targetname");
			friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.
		}		
	}  // this crash is oocuring on ai that does not have the paths defined for them of node[i]!!! look into...


	moody setgoalnode(node_moody);

	wait 1.7;
	level notify ("ambient sherman before bell tower"); // this is really not needed...

	println(" ^6 bomb can be placed now!");

//	anim_single (guy, anime, tag, node, tag_entity)	
	//Ok now blow up thie flak incase the Krauts come back
	level.moody thread anim_single_solo(level.moody,"now_destroy_88");
//	anim/sound end


	level waittill("88_blown_moody_continue");
	maps\_utility_gmi::chain_off ("after_88_killed");

//	level thread mg42_supprress_allied_event();

	// knocking the door down
	wait 0.1;
	node_moody = getnode("cover_moody_10", "targetname");
	moody.goalradius = 5; // Goal radius, how far the goal is to him
	moody setgoalnode(node_moody);

	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
//			wait 0.1;
			node = getnodearray("cover_10", "targetname");
			friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.
			friends2[i].pacifist = false;
		}		
	}

	level.moody.goalradius = 5;	

	moody waittill("goal");

// to stop guys from going into open area
//	level notify("friends move forward"); // cover10

	// plant the bomb vo needed hear...

//	if (!flag(obj + "bomb placed"))
//		foley anim_single_queue(foley, msg);

//	bombPlaced = level.flag[obj + "bomb placed"];

//	flag_wait (obj + "bomb placed");

//anim/sound begin

//	node = getnode("kick1_node", "targetname")

	door1 = getent ("door1", "targetname");
	//hold up find some cover
	level.moody thread anim_single_solo(level.moody,"clear_houses");
	wait 8;

	node_moody = getnode("kick1_node", "targetname");
	moody.goalradius = 5; // Goal radius, how far the goal is to him
	moody setgoalnode(node_moody);

	moody waittill("goal");

//	level.moody waittillmatch ("single anim", "clear_houses");


	moody_ang = spawn("script_origin", level.moody.origin);
	moody_ang.angles = (0,180,0);
	
	level.moody thread anim_single_solo(level.moody, "kick_door_2", undefined, moody_ang);

	 // perhaps this is getting called before he finishes his first anim?
//	level.moody thread anim_reach_solo(level.moody, "kick_door_2", undefined, node);
	//hold up find some cover
//	level.moody thread anim_single_solo(level.moody,"kick_door_2");
	
//	anim_reach_solo(guy, anime, tag, node, tag_entity)


//	anim_reach (guy, anime, tag, node, tag_entity)

	level.moody waittillmatch ("single anim", "kick");
	door1 playsound ("wood_door_kick");

	println("^5 EVent3a has been triggered");
	// this makes the door open
	door1 connectpaths();
	door1 rotateyaw(-110, 0.3,0,0.3);
	maps\_utility::chain_off ("middle_88_battle");


	wait 1;
	// this allows the friends to follow the player through the houses
	level.flag["house_clearing_friends_follow"] = true;
	wait 0.25;
	// this leaves friends notify last place at 10 and sets them to follow the player


//	moody waittill("goal");

	trigger = getent("after_88_chain","targetname");
	trigger waittill("trigger");

//	level notify ("ambient1_cleanup");	

//	level thread mg42_supprress_allied_event();

	println(" moody should now follow player");
	moody.followmin = 0; // Follow, how many pathnodes to follow behind the goal.
	moody.followmax = 3; // How many pathnodes to be ahead of the goal.
	moody setgoalentity (level.player);

	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
			println(" Friends should now follow player");
			friends2[i] setgoalentity (level.player);  	
			friends2[i].followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
			friends2[i].followmax = 3; // How many pathnodes to be ahead of the goal. // this was two
			friends2[i].pacifist = false;
		}
	}	

	// extra thread not needed to start tank fire but to tired to change right now.
	eTank = getent("tiger1","targetname");
	eTank thread tiger_init(); 
	eTank thread tank_control();

	wait 1.3;
	println("^6 shutters open now!");
	ehouse1a_shutter1_right = getent("house1a_shutter1_right", "targetname");
	ehouse1a_shutter1_right rotateyaw(160, 0.3,0,0.3);
	wait 0.2;
	ehouse1a_shutter1_left = getent("house1a_shutter1_left", "targetname");
	ehouse1a_shutter1_left rotateyaw(-140, 0.3,0,0.3);
	
	wait 1;
	// second set of windows
	ehouse1a_shutter2_right = getent("house1a_shutter2_right", "targetname");
	ehouse1a_shutter2_right rotateyaw(130, 0.3,0,0.3);
	wait 0.2;
	ehouse1a_shutter2_left = getent("house1a_shutter2_left", "targetname");
	ehouse1a_shutter2_left rotateyaw(-160, 0.3,0,0.3);

	level thread court1_is_ai_dead();


//	trigger = getent("entering_house_delete_friends", "targetname");
//	trigger waittill("trigger");

// now moody does not wait for the player at this point
	level waittill("tank_talk_done_continue");

	maps\_spawner_gmi::kill_spawnerNum(2);

	wait 2;
	level.maxfriendlies = 3;
	level thread all_friends_stay_behind();

//anim/sound begin

//	anim_single (guy, anime, tag, node, tag_entity)	
	//the rest of you stay back!
	level.moody thread anim_single_solo(level.moody,"rendezvous_at_the_church");
//anim/sound end

	maps\_utility_gmi::chain_on ("entering_second_house");
	maps\_utility_gmi::chain_off ("chain_before_entering_second_house");
//	wait 10;


	println("^3 *************** entering_fire_house ready to fire *******************"); 
	println("^3 *************** entering_fire_house ready to fire *******************");
	println("^3 *************** entering_fire_house ready to fire *******************");
	println("^3 *************** entering_fire_house ready to fire *******************");
	println("^3 *************** entering_fire_house ready to fire *******************");
	println("^3 *************** entering_fire_house ready to fire *******************");
	println("^3 *************** entering_fire_house ready to fire *******************");
	println("^3 *************** entering_fire_house ready to fire *******************");
	println("^3 *************** entering_fire_house ready to fire *******************");

	// Entering the fire house
	trigger = getent("entering_fire_house", "targetname");
	trigger waittill("trigger"); // make guys run in front of you

	// Adjust the follow min and max to 4
	level.moody setgoalentity (level.player);
	level.moody.followmin = 0; // Follow, how many pathnodes to follow behind the goal.
	level.moody.followmax = 4; // How many pathnodes to be ahead of the goal.

	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
			println("^3 ******** get ahead of player");
			friends2[i] setgoalentity (level.player);  	
			friends2[i].followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
			friends2[i].followmax = 4; // How many pathnodes to be ahead of the goal. // this was two
			friends2[i].pacifist = false;
		}
	}

	// Entering house 4
	trigger = getent ("after fire house", "targetname");
	println("^4*************  after fire house ready*************");
	trigger waittill("trigger");
	println("^4*************  after fire house used*************");

	// Adjust the follow min and max back to 2
	level.moody setgoalentity (level.player);
	level.moody.followmin = 0; // Follow, how many pathnodes to follow behind the goal.
	level.moody.followmax = 2; // How many pathnodes to be ahead of the goal.

	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
			println(" Friends should now follow player");
			friends2[i] setgoalentity (level.player);  	
//			friends2[i].goalradius =  512; // Goal radius, how far the goal is to him	
			friends2[i].followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
			friends2[i].followmax = 2; // How many pathnodes to be ahead of the goal. // this was two
			friends2[i].pacifist = false;
		}
	}
	

	trigger = getent ("event4_charge_on_tank", "targetname");
	println("^4*************  event4 ready*************");
	trigger waittill("trigger");
	println("^4*************  event4 used*************");
	level thread moody_at_tank(); // VO line called from within this function now.

	level notify ("objective_7_complete");
	level waittill("Tiger1_destroyed");

	level thread save_after_tank();
	println("^5Moody: ^7Great work let's keep it movin!");
	wait 1;
	// turns on trigger so moody can talk to player and let him know to move forward player must destroy tank
	trigger = getent("event4a", "targetname");
	println("^6 Trigger is on");
	trigger waittill("trigger");

	level.maxfriendlies = 4; // cock just turned this off... guy was only getting it
	level.friendlywave_thread = maps\foy::Catch_Up;
	// just placed this in !!!!!

	wait 0.5;
	node = getnode ("kick_door5", "targetname");
	level.moody setgoalnode(node);
	level.moody waittill("goal");
	level thread kill_axis_stop_bell_distraction();

	wait 0.3;
	println("^6 ************ Trigger activated**************");
	println("^5Moody*************: ^7Follow me*****************");
	

	// sets up house5 door so it can be opened... after the tiger has been taken care of.
	ehouse5_door1 = getent("house5_door1", "targetname");
	wait 1;

//	anim_single (guy, anime, tag, node, tag_entity)	
	//hold up find some cover

	// RICH new moody line go go go moody_door_go
	level.moody thread anim_single_solo(level.moody,"moody_door_go");
	level.moody thread anim_single_solo(level.moody,"kick_door_2");
//anim/sound end
	level.moody waittillmatch ("single anim", "kick");
	ehouse5_door1 playsound ("wood_door_kick");
	ehouse5_door1 rotateyaw(140, 0.3,0,0.3);
	ehouse5_door1 connectpaths();
	maps\_utility_gmi::chain_on ("chain_belltower_courtyard");

//	wait 1;

	level notify ("allow_look_to_blow_up_tower");


	maps\_utility_gmi::chain_on ("10");
	wait 1;
	moody.goalradius = 512; // Goal radius, how far the goal is to him
	moody.followmin = 0; // Follow, how many pathnodes to follow behind the goal.
	moody.followmax = 3; // How many pathnodes to be ahead of the goal.
	moody setgoalentity (level.player); // Set denny's goal to be the player.	


	trigger = getent("event4b", "targetname");
	trigger waittill("trigger");

	house = getentarray("house_friends", "groupname"); // these guys need to do something interesting...
	for(n=0;n<house.size;n++)
	{
		if(isalive(house[n]))
		{
			if(isdefined(house[n].script_noteworthy) &&  house[n].script_noteworthy == "house_friend1")
			{
					house[n] thread house_friend_complete1();
					print("^6 ************** house friends", self.script_noteworthy);
			}

			if(isdefined(house[n].script_noteworthy) &&  house[n].script_noteworthy == "house_friend2") 
			{
					house[n] thread house_friend_complete1();
					print("^6 ************** house friends", self.script_noteworthy);
			}

			if(isdefined(house[n].script_noteworthy) &&  house[n].script_noteworthy == "house_friend3") 
			{
			}
		}

		wait 0.05;
	}	

	level thread ambient_battle5();

	println("^2***************** event4b activated *************");

	wait 1.3;

	level thread sequence_church();
}

flyby_street_setup() // makes player trigger fly by in street
{
//	level waittill("objective_complete8");	

	trigger = getent("p47_flyby_street", "targetname");
	trigger waittill("trigger");

	level notify ("flyby go");
}

house_friend_complete1()
{
	wait 6;
	node = getnode("house_friend1", "targetname");
	self setgoalnode(node);
}

house_friend_complete2()
{
	print("^6 ************** house friends", self.script_noteworthy);
	node = getnode("house_friend3a", "targetname");
	self setgoalnode(node);

	wait 4;	
	level thread maps\bastogne2_event1to2::event1_init();
	node = getnode("house_friend3", "targetname");
	self setgoalnode(node);
}

ambient_battle1()
{
	level waittill ("ambient1_cleanup");
	ambient1 = getentarray("ambient_fight1", "groupname");
	for(i=0;i<ambient1.size;i++)
	{
		ambient1[i] delete();
	}
}

ambient_battle5()
{
	ambient5 = getentarray("ambient_fight5", "groupname");
	for(i=0;i<ambient5.size;i++)
	{
		if(isalive(ambient5[i]))
			ambient5[i] delete();
	}
}

// Autosave as you enter building after destroying the tank.
save_after_tank()
{
	trigger = getent("save_after_tank", "targetname");
	trigger waittill("trigger");
	maps\_utility_gmi::autosave(7); //tiger
}

mg42_supprress_allied_event()
{
	println("^8***************** friends5 setup *****************");
	friends5_array =[];// this defines it as an array
	friends5_group = getentarray("court1_first_mg42_guys", "groupname");
		
	println("^2 ************* ", friends5_group.size);
	println("^3**************** friends5 group and array setup!");
	for(i=1;i<(friends5_group.size+1);i++)		
	{
		friends5_array[i] = getent("friends5_guy_" + i, "targetname");
		println("^6 **************** friends5 made it into for loop!");		
		// MikeD: If you want to force a spawn, use stalingradspawn()
		friends5_array_ai = friends5_array[i] dospawn();
		friends5_array_ai thread Friendly_damage_penalty();

		if(isdefined(friends5_array_ai))
		{
			println("^6 **************** I imade it: ", i);	
			friends5_array_ai thread maps\_utility_gmi::magic_bullet_shield();
			friends5_array_ai.pacifist = true;
			friends5_array_ai.accuracy = 0.1;
			friends5_array_ai.goalradius = 10;
	//		friends4_array_ai[i] thread friends4_think(i);
			friends5_array_ai thread friends5_think(i);
		}
	}

	level waittill("show_bomb1");
	wait 2;
	guy_german_suppression = getent("court1_first_mg42_german", "targetname");
	level.court_guy_mg42_ai = guy_german_suppression dospawn();
	level.court_guy_mg42_ai.health = 15;	
	// Killing the guys show the bomb on the 88 now!
	level.court_guy_mg42_ai thread mg42_supprress_allied_event_death_wait();
}

friendly_damage_penalty()
{	
	self waittill ("damage", dmg, who);
	
	if (who == level.player)
	{
		setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
		missionfailed();
	}
}

moody_vo_inside_houses()
{
	getent("moody_talk_clear_house","targetname") waittill ("trigger");
	wait 4;
	level.moody thread anim_single_solo(level.moody,"moody_dont_stop");
	wait 10;
	level.moody thread anim_single_solo(level.moody,"moody_clear_rooms");		
}

kill_axis_stop_bell_distraction()
{
	ai = getaiarray ("axis");
	for (i=0;i<ai.size;i++)
	{
		ai[i] DoDamage ( ai[i].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
	}

	ambient6 = getentarray("ambient_fight2", "groupname");	
	for(i=0;i<ambient6.size;i++)
	{
		if(isalive(ambient6[i]))
		{
			ambient6[i] delete();
			wait 1;
		}
	}

	level thread event4a_spawn_church_mg42_guy_now();
}

mg42_supprress_allied_event_death_wait()
{
	self thread maps\_utility_gmi::make_player_feel_important();
	println("^6 **************** mg42 waiting for death *************");
	self waittill("death");
	println("^6 **************** mg42 death occured*************");
	level notify("court1_first_mg42_killed");
}

friends5_think(i)
{	
	node1 = getnode("friends5_spot_" + i, "targetname");
	println("^6 **************** friends5 waiting to move up *************");
	level waittill("court1_first_mg42_killed");
	self setgoalnode(node1);
	self waittill("goal");
	self delete();
}

//////////////// new event

house1a_count_ai_dead() // subjective tweak, make guys move forward when ai is dead even though friend chain is in front of door to courtyard
{ 
		println(" ^3 ************** house1a ai stuff begin *******");
		trigger = getent ("house1a_start_check","script_noteworthy");
		trigger waittill ("trigger");

		wait 1;
		transTrigger = getent ("house1a_are_ai_dead","targetname");
		maps\_utility_gmi::living_ai_wait (transTrigger, "axis");
		println ("^6 ai died");
		chain = maps\_utility::get_friendly_chain_node ("100");
		level.player SetFriendlyChain (chain);	
		maps\_utility::chain_off ("1");
}


// when all ai is dead move forward
court1_is_ai_dead()
{
  //      while(level.player istouching(trigger) && isalive(level.player))
//	{
		trigger = getent ("court1_start_check","script_noteworthy");
		trigger waittill ("trigger");

		// in courtyard
		wait 1;
		transTrigger = getent ("court1_are_ai_dead","targetname");
		maps\_utility_gmi::living_ai_wait (transTrigger, "axis");
		println ("^4 ai died");
	//	maps\_utility::chain_on ("23"); after courtyard
		chain = maps\_utility::get_friendly_chain_node ("101");
		level.player SetFriendlyChain (chain);	
		maps\_utility::chain_off ("100");
//	} 
}

moody_at_tank()
{
	node = getnode ("moody_tank_charge", "targetname");
	level.moody setgoalnode(node);
	level.moody waittill("goal");
	println("^3 *********  moody is at tank now and looking out of the window*******");

	wait 1;
	//OK here is the plan
	level.moody thread anim_single_solo(level.moody,"charge_on_tank");
}


sequence_church()
{
	level.moody = getent("moody","targetname");
	level.moody.animname = "moody";

	level.Anderson = getent("Anderson","targetname");
	level.Anderson.animname = "Anderson";

	level.Whitney = getent("Whitney","targetname");
	level.Whitney.animname = "Whitney";
	println("^3 Moody: OK lets get across the street now");	
	node_moody = getnode("cover_moody_13", "targetname");

	trigger_church_allies = getent ("teleport_troops","targetname");
	trigger_church_allies maps\_utility_gmi::triggerOff(); // must turn this trigger off so it does not mess with the event's future

//	friends_fodder = getentarray("friends", "targetname");
//
//	level thread friendly_position( friends2 );
//	level thread friendly_position( friends_fodder );

	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
			node = getnodearray("cover_12", "targetname");
			friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.		
		}
	}
	level thread church_german_sounds();

	level.moody setgoalnode(node_moody);
	level.moody waittill("goal");
	level thread church_german_sounds();

	trigger = getent("event5a", "targetname");
	trigger maps\_utility_gmi::triggerOff();
	level thread church_german_sounds();
	//OK here is the plan
	level.moody thread anim_single_solo(level.moody,"prep_church");
	wait 3.5;

	level thread church_german_sounds();

	// makes squad wait for the player in front of the church

	trigger maps\_utility_gmi::triggerOn();
	println("^6 ********************** event 5a ****************** is armed");
	trigger waittill("trigger");
	println("^6 ********************** event 5a ****************** is triggered");
	// guys follow up to here

	node_moody = getnode("cover_moody_14", "targetname");
	level.moody setgoalnode(node_moody);

	// remember to look at
	level.moody.goalradius = 20;
	level.moody waittill("goal");

	level.german_mg42_setup playsound("foley_mg34_deploy");

	wait .6;
	level thread event5a_counter();	
	//Ready 1 2 3 go go go
	level thread anderson_follow_moody_church_entry(); 
	level.moody thread anim_single_solo(level.moody,"1_2_3_go_go_go");
	level thread church_german_sounds();
	wait 1.6;


//	level thread clear_church();
	church_door1 = getent("church_door1", "targetname");
	//hold up find some cover
	level.moody thread anim_single_solo(level.moody,"kick_door_2");

	level.moody waittillmatch ("single anim", "kick");
	church_door1 playsound ("wood_door_kick");
	church_door1 connectpaths();
	church_door1 rotateyaw(140, 0.3,0,0.3);	

	// need to turn on friendly chain but this area is to tight for to many AI going through it...

	level.moody allowedStances ("stand");
	node_moody = getnode("moody_cover_after_door_kick", "targetname");
	level.moody setgoalnode(node_moody);
	level.moody.ignoreme = true;
	level.moody.pacifist = true;
	level.moody.goalradius = 32;

	wait 3.5;

	level.moody allowedStances ("stand", "crouch", "prone");
	level.moody.ignoreme = false;
	level.moody.pacifist = false;

	level.moody allowedStances ("stand", "crouch", "prone");
	level.anderson.ignoreme = false;
	level.anderson.pacifist = false;

//	wait 1.3;

	maps\_utility_gmi::chain_on ("church_chain");
	friends2 = getentarray("friends","groupname");	// team is reset to player upon church door opening..
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
			println(" Friends should now follow player");
			friends2[i] setgoalentity (level.player); // Set denny's goal to be the player.	
			friends2[i].goalradius =  512; // Goal radius, how far the goal is to him	
			friends2[i].followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
			friends2[i].followmax = 2; // How many pathnodes to be ahead of the goal. // this was two
		}
	}


	
	level waittill("church is now cleared");

	wait 0.1;
	//player must come out here then counter attack starts

	node_moody = getnode("cover_moody_15", "targetname");
	level.moody setgoalnode(node_moody);
	level.moody.goalradius = 32;
//	level.moody waittill("goal");

	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
			println("^3 *****************  friends should run to cover 13 ************ ");
			node = getnodearray("cover_13", "targetname");
			friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.
			friends2[i].goalradius = 32;	
			friends2[i].pacifist = true;
		}	
	}


	level thread foley_church(); // jeremy one
	level waittill ("foley_said_speech");
	level notify("objective_9_complete");

	wait 1.2;

	//Stick_with_me
	level.moody thread anim_single_solo(level.moody,"Get_up_in_the_bell_tower");
	wait 4.7;

	// turns first sniper off
	trigger = getent("last_room_check", "targetname");
	trigger waittill("trigger");


	level.flag["kill_fake_sniper1"] = false;

	// sets guys to get into position in street
	level.friendlywave_thread = maps\foy::Catch_Up_after_church;

	level thread event7_tank_pre();

	//respawner_setup(groupname, grouped, attributes, num_of_respawns, wait_till, last_goal)
	attrib["goalradius"] = 32;
	

								//   (groupname, objective_num, string, num_of_guys, ender)
	level.num_of_respawns = 7;
	level thread maps\_respawner_gmi::respawner_setup("panzerfaust1", "special", attrib, level.num_of_respawns);
	level thread maps\_respawner_gmi::respawner_objective_tracker("panzerfaust1", 10, (&"GMI_FOY_OBJECTIVE_10"), level.num_of_respawns);

	objective_position(10, (480,-1498,464));
	objective_ring(10);

	// (480,-1504,264)
//	level thread Event10_time_Manager(); commented out
	println(" *********** passed chruch event ************* ");
//	level waittill 


	// need to make guys teleport out of here when the player heads upstairs
	// teleport_troops

	level thread sequence_shermans(); // player is getting to here before the pre wait is hit
	trigger_church_allies maps\_utility_gmi::triggerOn(); // must turn this trigger off so it does not mess with the event's future
//	trigger_church_allies thread trigger_church_allies_think();
	trigger_church_allies waittill ("trigger");
	

//	getent("teleport_troops","targetname") waittill ("trigger");
	

	fnode = getnode("auto2074", "targetname");

	if(isalive(level.esupport_ai))
	{
		level.esupport_ai setgoalnode(fnode);
	}

	println("  ************************  fnode ", level.anderson.targetname);

	node_moody = getnode("cover_moody_16", "targetname");
	level.moody setgoalnode(node_moody);
	wait 0.25;

	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
			println("^3 *****************  friends should run to cover 14  ************ ");
			node = getnodearray("cover_14", "targetname");
			friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.
		}		
	}
	println("^3 Everyone is in position!");

//	wait 8;
	level.Anderson.dontavoidplayer = 1;
	anode = getnode("block_church2", "targetname");
	level.Anderson setgoalnode(anode);

//	level thread sequence_shermans();
}

fog_changer() 
{
	// when the player gets up into the belltower

	level waittill("objective_9_complete");	// player is told to get into 
//	setCullFog (0, 7000, .5254, .6117, .7215, 0 );
	setCullFog (0, 5000, .5254, .6117, .7215, 0 );

//	setCullFog (0, 6000, .68, .73, .85, 10 );

	// at bridge
}

anderson_follow_moody_church_entry()
{
	level.moody allowedStances ("stand");
	wait .2;
	node_anderson = getnode("anderson_cover_after_door_kick", "targetname");
	level.anderson setgoalnode(node_anderson);
	level.anderson.ignoreme = true;
	level.anderson.pacifist = true;
	level.anderson.goalradius = 32;
}

//----------------------- count down/up with remaing panmzerfausts to kill--------------//


//=============================================================
//
//This makes the shermsn move after they have arrived in town.
//
//=============================================================
sequence_shermans() 
{
	level waittill("Shermans_safe_in_town");
	level notify ("trigger_church_allies_turn_off");
	level.Anderson.dontavoidplayer = 1;
	level.whitney.dontavoidplayer = 1;
	level.foley_ai.dontavoidplayer = 1;
	level.moody.dontavoidplayer = 1;
	level thread foley_ai_say_get_down_here();

	level.flag ["moody_talking_take_cover"] = true;

//	wait 1.3;
//	level.foley_ai thread anim_single_solo(level.foley_ai,"riley_get_down_here");
	level.flag["kill_fake_sniper1"] = false;

	node_moody = getnode("cover_moody_21", "targetname");
	level.moody setgoalnode(node_moody);
	level.moody waittill("goal");

	level.foley_ai.pacifist = true;
	level.foley_ai.ignoreme = true;

	wait 2;

	if(isalive(level.esupport_ai))
	{
		level.esupport_ai.dontavoidplayer = 0;
	}

	friends2 = getentarray("friends","groupname");
	for(i=0;i<friends2.size;i++)
	{
		if(isalive(friends2[i]))
		{
			node = getnodearray("cover_15", "targetname");
			friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.		
		}
	}

	znode = getnode("auto2121", "targetname");
	level.foley_ai setgoalnode(znode);


	// makes moody wait for player
	trigger = getent("sherman_2nd_advance_wait_player", "targetname");
	trigger waittill("trigger");

	level.foley_ai thread anim_single_solo(level.foley_ai,"foley_stay_with");

		level thread bridge_spawners_wait();


		level notify("shermans_leave_town"); // starts remaining two tanks on thier paths

		println(" ^7 wait for the tanks to get ahead and then follow");
		wait 3;

		node_moody = getnode("cover_moody_22", "targetname");
		level.moody setgoalnode(node_moody);

		znode = getnode("auto2357", "targetname");
		level.foley_ai setgoalnode(znode);

		friends2 = getentarray("friends","groupname");
		for(i=0;i<friends2.size;i++)
		{
			if(isalive(friends2[i]))
			{
				node = getnodearray("cover_16", "targetname");
				friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.		
			}
		}

		level.foley_ai waittill("goal");

		// bug -- player can activate tank blowing up before moody says his line.
		level.foley_ai thread anim_single_solo(level.foley_ai,"foley_take_cover");
		wait 2;
		level.flag ["moody_talking_take_cover"] = false;

//		level.moody waittill("goal");
		level waittill("sherman_1_dead_continue");



//		level waittill("event8_tank1_blown");

		wait 0.5;

		node_moody = getnode("cover_moody_22", "targetname");
		level.moody setgoalnode(node_moody);
		level.moody.pacifist = true;
		level.moody.ignoreme = true;
//		level.moody waittill("goal");
		level notify("objective_11_complete");	

		znode = getnode("auto2535", "targetname");
		level.foley_ai setgoalnode(znode);
	

		friends2 = getentarray("friends","groupname");
		for(i=0;i<friends2.size;i++)
		{
			if(isalive(friends2[i]))
			{
				node = getnodearray("cover_17", "targetname");
				friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.
				friends2[i].pacifist = true;	
				friends2[i].ignoreme = true;	
			}
		}


//		wait 3;

		// this trigger waits for player to orderes to flank house
//		trigger = getent("event8_tank_blown", "targetname");
//		trigger waittill("trigger");

		level.flag["foley_ai_still_talking"] = true;
		level thread continue_event_when_player_leaves_foley_speech();
		// need to set flag to true while talking then off after words
		//	anim_single (guy, anime, tag, node, tag_entity)	


		// RICH foley needs to say take cover here before tank explodes.. right before house... foley_take_cover
		// RICH Foley when player gets down to the bottom of the bell tower foley_stay_with

		//Stick_with_me
		level.foley_ai thread anim_single_solo(level.foley_ai,"dammit_take_charge");
		wait 7.2;

		level.flag["foley_ai_still_talking"] = false;

		level.moody thread anim_single_solo(level.moody,"moody_gotit");
		println("^5   *********** moody_gotit  *******");



		// RICH Foley when player gets down to the bottom of the bell tower moody_gotit // asy after foley's ord

		wait 1;
//		level notify ("sherman3_smoke");
		maps\_utility_gmi::chain_on (200);

		wait 0.25;

		maps\_utility_gmi::chain_on (200);

		level.moody.goalradius = 50; // Goal radius, how far the goal is to him
		level.moody.followmin = 0; // Follow, how many pathnodes to follow behind the goal.
		level.moody.followmax = 3; // How many pathnodes to be ahead of the goal.
		level.moody.pacifist = true;
		level.moody setgoalentity (level.player); // Set denny's goal to be the player.
	
		friends2 = getentarray("friends","groupname");
		for(i=0;i<friends2.size;i++)
		{
			if(isalive(friends2[i]))
			{
				println(" Friends should now follow player");
				friends2[i] setgoalentity (level.player);  	
				friends2[i].goalradius =  50; // Goal radius, how far the goal is to him	
				friends2[i].followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
				friends2[i].followmax = 2; // How many pathnodes to be ahead of the goal. // this was two
				friends2[i].pacifist = true;
			}
		}

		// Has redshirts give covering fire
		friends3 = getentarray("friends","targetname");
		for(i=0;i<friends3.size;i++)
		{
			if(isalive(friends3[i]))
			{
				node = getnodearray("last_cover", "targetname");
				friends3[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.
				friends3[i].pacifist = false;	
				friends3[i].ignoreme = false;
			}	
		}

		znode = getnode("foley_last_cover", "targetname");
		level.foley_ai setgoalnode(znode);
		
		level thread foley_friends_end();	

		level.flag["player_crossing_bridge"] = true;	
		level.flag["shermans_attack_across_bridge"] = true;
		level.flag["tiger2_attack_player_flag"] = true;
		level notify("attack_bridge_now");
		// need to make shermans stop firing when player crosses bridge
		
		level.maxfriendlies = 9;
		level.friendlywave_thread = maps\foy::Catch_Up3;

		level thread bridge_crossing();

		trigger = getent("player_across_bridge", "targetname");
		trigger waittill("trigger"); 

		level.moody setgoalentity (level.player);  	
		level.moody.goalradius = 512; // Goal radius, how far the goal is to him
		level.moody.followmin = 0; // Follow, how many pathnodes to follow behind the goal.
		level.moody.followmax = 2; // How many pathnodes to be ahead of the goal.
		level.moody.pacifist = false;
	
		friends2 = getentarray("friends","groupname");
		for(i=0;i<friends2.size;i++)
		{
			if(isalive(friends2[i]))
			{
				println(" Friends should now follow player");
				friends2[i] setgoalentity (level.player);  	
				friends2[i].goalradius =  512; // Goal radius, how far the goal is to him	
				friends2[i].followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
				friends2[i].followmax = 3; // How many pathnodes to be ahead of the goal. // this was two
				friends2[i].pacifist = false;
			}
		}

		trigger = getent("player_at_farm", "targetname");
		trigger waittill("trigger");

		level.flag["tiger2_attack_player_flag"] = false;

		level.flag["shermans_attack_across_bridge"] = false;
}

foley_ai_say_get_down_here()
{
//	znode = getnode("riley_get_down_here", "targetname");
	znode = getnode("auto2121", "targetname");
	level.foley_ai setgoalnode(znode);
	level.foley_ai waittill("goal");
//	wait 1.3;
	level.foley_ai thread anim_single_solo(level.foley_ai,"riley_get_down_here");
}

continue_event_when_player_leaves_foley_speech()
{
//	level.flag["foley_ai_still_talking"] = true;
	while(level.flag ["foley_ai_still_talking"] == true)
	{
		if (distance (level.player getorigin(), level.foley_ai.origin) > 1300)	
		{
			level notify ("sherman3_smoke");
		}
		wait 1;
	}

	level notify ("sherman3_smoke");
}

shermans_firesmoke()
{
	smoketarget = getent ("smokerround","targetname");
	smokeorigin = getent (smoketarget.target,"targetname");

	smoketarget2 = getent ("smokerround2","targetname");
	smokeorigin2 = getent (smoketarget.target,"targetname");
	// need to make sherman fire smoke when he is down there
	
	level thread smokeround_start(smokeorigin, smokeorigin2);
}

fire_smoke()
{
	smoketarget = getent ("smokerround","targetname");
	level waittill ("sherman3_smoke");
	self setTurretTargetEnt( smoketarget, (0, 0, 0) );
//	self waittill ("turret_on_vistarget");
	wait 3;
	self thread maps\_sherman_gmi::fire();
	self clearTurretTarget();
	level thread shermans_firesmoke();
}

smokeround_start(smoketarget, smoketarget2)
{
	level thread smokeround_stop();
	level endon ("Stop Smokeround");
		maps\_fx_gmi::OneShotFx("tanksmokeshot", smoketarget.origin, 0.1);
		maps\_fx_gmi::OneShotFx("tanksmokeshot", smoketarget2.origin, 0.1);
}

smokeround_stop()
{
//	getent ("stopsmoke","targetname") waittill ("trigger");
//	level notify ("Stop Smokeround");
}

bridge_spawners_wait()
{
	trigger1 = getent("right_side_trigger", "script_noteworthy");
	trigger2 = getent("center", "script_noteworthy");
	trigger1 maps\_utility_gmi::triggerOff();
	trigger2 maps\_utility_gmi::triggerOff();

	level waittill ("sherman3_smoke");
//	level waittill("sherman_1_dead_continue");
	trigger1 maps\_utility_gmi::triggerOn();
	trigger2 maps\_utility_gmi::triggerOn();
}

sequence_end_action()
{
//		trigger = getent("event8f", "targetname");
		println("^3 event8f trigger on");
		println("^6 ******** event8f armed*********");
//		trigger waittill("trigger");
		println("^6 ******** event8f triggered*********");


		level.ebarn_dudes = getentarray("barn_guys", "groupname");
		for(i=0;i<level.ebarn_dudes.size;i++)
		{
			println("^3 ******************* barn guys are spawning **********");
			level.ebarn_dudes_ai[i] = level.ebarn_dudes[i] dospawn();
			wait 0.25;
			level.ebarn_dudes_ai[i].pacifist = true;
		}

		level thread barn_guys_agro_wait();

//		level.moody waittill("goal");	
		// spotter should wait till last second
		level thread last_spotter();
		level.player.threatbias = -2000;

		trigger = getent("friends_follow_barn", "targetname");
		println("^6 ******** friends follow barn armed*********");
		trigger waittill("trigger");
		println("^6 ******** friends follow barn triggered*********");

		level.moody.followmin = 0; // Follow, how many pathnodes to follow behind the goal.
		level.moody.followmax = 3; // How many pathnodes to be ahead of the goal.
		level.moody.pacifist = true;

		level.anderson.followmin = 0; // Follow, how many pathnodes to follow behind the goal.
		level.anderson.followmax = 2; // How many pathnodes to be ahead of the goal.
		level.anderson.pacifist = true;

		level.Whitney.followmin = 0; // Follow, how many pathnodes to follow behind the goal.
		level.Whitney.followmax = 2; // How many pathnodes to be ahead of the goal.
		level.Whitney.pacifist = true;


//		println("^3 OK that house ahead must be it sneak in and will be right behind you when you blow up that hidden tank");

		trigger = getent("last_save_point", "targetname");
		trigger waittill("trigger");

		//	anim_single (guy, anime, tag, node, tag_entity)	
			//Stick_with_me
			level.moody thread anim_single_solo(level.moody,"barn");
			wait 4.7;
		//anim/sound end
}

// foley and remaining friends come over the bridge
foley_friends_end()
{
		level waittill("shermans_end_map");
		friends3 = getentarray("friends","targetname");
		for(i=0;i<friends3.size;i++)
		{
			if(isalive(friends3[i]))
			{
				println("^5 **************** last friendlies cross the bridgge now!***********");
				node = getnodearray("last_speech", "targetname");
				friends3[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.
				friends3[i].pacifist = false;	
			}	
		}

		// you need to grab the other guys here...

		znode = getnode("foley_last_speech", "targetname");
		level.foley_ai setgoalnode(znode);

		wait 1;

		level thread last_friends(); // these are guys that come out and run down the street

		rnode = getnode("anderson_end", "targetname");
		level.anderson setgoalnode(rnode);

		rnode = getnode("moody_end", "targetname");
		level.moody setgoalnode(rnode);

//		snode = getnode("Whitney_end", "targetname");		
//		level.Whitney setgoalnode(snode);


		level.foley_ai waittill("goal");
		println("^3 **************** END SPEECH *****************");

		while(1)
		{
			if(distance (level.player getorigin(), level.foley_ai.origin) < 200)
//			if(distance (level.player.origin, foley_ai.origin) > 200)
			{
				ent = spawn("script_origin", level.player.origin);
				
				level.player linkTo(ent);

				//	anim_single (guy, anime, tag, node, tag_entity)	
					//Stick_with_me
					level.foley_ai thread anim_single_solo(level.foley_ai,"hell_of_a_job");
					level notify("objective_13_complete");
					wait 4.7;
				//anim/sound end
					break;
			}
			
			wait 0.05;
		}

		level thread axis_do_damage();

		wait 7;

		missionSuccess("noville", true);
		
}


last_friends()
{

		wait 5;		

		friends5 = getentarray("last_friends1", "targetname");
		for(i=0;i<friends5.size;i++)
		{
	
			friends5_ai[i] = friends5[i] dospawn();
			friends5_ai[i] thread last_friends_move();
		
//			if(isalive(friends5[i]))
//			{	
//				wait 0.25;		
//				node = getnode("friends1_hold", "targetname");
//				friends5_ai[i] setgoalnode(node);
//			}
		}

		wait 12;


		friends6 = getentarray("last_friends2", "targetname");
		for(i=0;i<friends6.size;i++)
		{

			friends6_ai[i] = friends6[i] dospawn();
			friends6_ai[i] thread last_friends2_move();
//			wait 0.25;	
//
//			if(isalive(friends6[i]))
//			{
//	
//				node = getnode("friends2_hold", "targetname");
//				friends6_ai[i] setgoalnode(node);
//			}
		}
}

last_friends_move()
{
	if(isalive(self))
	{
			wait 0.25;		
			node = getnode("friends1_hold", "targetname");
			self setgoalnode(node);	
	}
}

last_friends2_move()
{
	if(isalive(self))
	{
			wait 0.25;		
			node = getnode("friends2_hold", "targetname");
			self setgoalnode(node);
	}
}

barn_guys_agro_wait()
{
		trigger = getent("barn_guys_agro", "targetname");
		trigger waittill("trigger");

		for(i=0;i<level.ebarn_dudes_ai.size;i++)
		{
			if(isalive(level.ebarn_dudes_ai[i]))
			{
				println("^3 *******************  barn guys are agro now *********");
				level.ebarn_dudes_ai[i].pacifist = false;
				wait (0.1 + randomfloat(0.4));
				level.whitney.pacifist = false;
				level.moody.pacifist = false;
				level.anderson.pacifist = false;
			}
		}
}


friendly_position( thisgroup )
{
	for(i=0;i<thisgroup.size;i++)
	{
		if(isalive(thisgroup[i]))
		{
			node = getnodearray("cover_12", "targetname");
			thisgroup[i] setgoalnode(node[i]);
		}	
	} 
}

start_speech()
{
	level.foley = getent("foley","targetname");
	level.foley.animname = "foley";
	level thread no_sir_response();


	friends = getaiarray ("allies");
	for (i=0;i<friends.size;i++)
	{
		friends[i] setgoalpos (friends[i].origin);


//		if (isdefined(spawners[i].script_noteworthy))
//		{
//			level.guy.targetname = spawners[i].script_noteworthy; //squad2_1 and so on up to three
//		}

		if (randomint (2) == 0)
		{
			friends[i] allowedStances ("crouch");
		}
	}

//START DIALOGUE###############################################

	level.foley allowedStances ("stand");


	dummy = spawn ("script_origin",(level.player.origin));

	level.player playerlinkto (dummy);
	level.player freezeControls(true);

//	trigger = getent("start_speech", "targetname");
//	trigger waittill("trigger");

	wait 0.5;

	println(" ^5 ****************** Hey the speech should start now!!!");
	level.foley thread anim_single_solo(level.foley,"open_speech");	
	// note add rest of squad saying no sir blah... in between RICH.

	// make the black screen last a little bit longer.
	level waittill ("finished intro screen");
	
	wait 16.5;

//	level.foley throwGrenade();

	level thread begin_assualt(); // does the off set whistle for all guys charging..

//	level thread friends_move_thread("friends");

}

no_sir_response() // because there names are alreayd defined I may have to fake em in and then rename them afterwards
{
	// need to have moody, whitney, anderson say the sir shit as well...

//	level.Anderson thread anim_single_solo(level.Anderson,"whistle_watch");
//	level.Whitney thread anim_single_solo(level.foley,"whistle_watch");
	wait 19.3;
	level.moody thread anim_single_solo(level.moody,"moody_nosir");

//	level.moody thread anim_single_solo(level.moody,"trooper1_nosir");

	// trooper five works
	// trooper four works
	// trooper three not working
	// trooper two works

	wait 0.1;
	level.Whitney thread anim_single_solo(level.Whitney,"trooper5_nosir");
//	level.Whitney thread anim_single_solo(level.Whitney,"trooper5_nosir");

	wait 0.2;
	level.Anderson thread anim_single_solo(level.Anderson,"trooper1_nosir"); // needs to be three
                                                                      
	// go over no sir shit with RICH
//	if(self.targetname == "squad2_guy_2_guy")
//	{
//	}
}

begin_assualt()
{
//	anim_single (guy, anime, tag, node, tag_entity)	
	//hold up find some cover
//	level.foley thread anim_single_solo(level.foley,"whistle_watch");
	//anim/sound end
//	wait 0.7;
//	level.foley thread anim_single_solo(level.foley,"whistle_watch_loop");
	wait 1.4;
	level.foley thread anim_single_solo(level.foley,"open_speecha");	
//	anim_single (guy, anime, tag, node, tag_entity)		

	wait 3.2;

//anim/sound begin
	level notify("attack");
	level thread dummies_opening();

//	wait 3;

//anim/sound begin

//	anim_single (guy, anime, tag, node, tag_entity)	
	//hold up find some cover
	level.foley thread anim_single_solo(level.foley,"whistle_blow");
//anim/sound end
	wait 0.8;
	level.foley attach("xmodel/o_us_misc_whistle", "tag_weapon_left");
	wait 0.6;

//	wait 1.4; // adjust so timing of whistle is on

	angle1 = (0,0,0); 
     	vec1 = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(angle1),8000);
	angle2 = (0,-45,0); 
     	vec2 = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(angle2),4000);
	angle3 = (0,45,0); 
     	vec3 = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(angle3),8000);
	distant_whistle_1 = spawn("script_origin",(vec1));
	distant_whistle_2 = spawn("script_origin",(vec2));
	distant_whistle_3 = spawn("script_origin",(vec3));

	distant_whistle_2 playsound("distant_whistle_02");

	wait 1;

	level.player unlink(dummy);
	level.player freezeControls(false);


	level thread friends_move_thread("friends");
	level thread moody_move_thread();

// commented per steve fix
//	anim_single (guy, anime, tag, node, tag_entity)	
	// Stick_with_me
	level.moody thread anim_single_solo(level.moody,"Stick_with_me");
//anim/sound end

	wait 1.2;

	level thread friends_beg1();
	level thread friends_beg2();

//	angle1 = (0,0,0); 
//     	vec1 = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(angle1),8000);
//	angle2 = (0,-45,0); 
//     	vec2 = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(angle2),4000);
//	angle3 = (0,45,0); 
//     	vec3 = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(angle3),8000);
//	distant_whistle_1 = spawn("script_origin",(vec1));
//	distant_whistle_2 = spawn("script_origin",(vec2));
//	distant_whistle_3 = spawn("script_origin",(vec3));
//
//	distant_whistle_2 playsound("distant_whistle_02");

	wait 1.8;
	distant_whistle_3 playsound("distant_whistle_03");
	level notify("foley_whistle_done");


	wait 3;
	level.foley detach("xmodel/o_us_misc_whistle", "tag_weapon_left");
	distant_whistle_1 playsound("distant_whistle_01");
	level thread west_hill_loop();
}

west_hill_loop()
{
	level thread dummies_westhill();
	wait 20;
	level thread dummies_westhill();
}

mg34_attackers()
{
	mg34_attackers = getent("mg34_attackers", "targetname");
	println(" ^6 ***********************  :  ", self.targetname, self.health);
	mg34_attackers_ai = mg34_attackers();

	etarget = getent("flak_eye", "targetname");
//	poop = getent ("auto2566", "targetname");
}

mg42_nest_obj()
{
	println("^3 EVENT4a, Were pinned down here kill that mg42");
	ehouse_mg42_guy2 = getent("house_mg42_guy2", "targetname");
	println(" ^6 ***********************  :  ", self.targetname, self.health);
	ehouse_mg42_ai2 = ehouse_mg42_guy2 dospawn();
	ehouse_mg42_ai2.accuracy = 0.2;
//	ehouse_mg42_ai2 thread mg42_nest_obj_death();


	level waittill("second_mg42_nest_spawned");


	ehouse_mg42_guy1 = getent("house_mg42_guy1", "targetname");
	wait 0.1;
	println(" ^6 ***********************  :  ", self.targetname, self.health);
	ehouse_mg42_ai1 = ehouse_mg42_guy1 dospawn();
}

// court yardf1 run by guys -- ryan helped with this bit of code...
// jeremy settin up courtyard guys
court1_yard_run()  // ambient guys running by
{ 
     println("^5germans court1 ready! "); 
     trigger = getent("germans_court1", "targetname");
     trigger waittill("trigger");
     level notify("tiger1_move_back"); 

     level thread moody_talk_tank();
	
     println("^5germans run by court1 "); 
	

       run_node = getnode("node_run_by_court1", "targetname"); 
 //    run_node = getnode("auto1883", "targetname"); 
 
     ecourt1_run_guys = getentarray ("court1_run_guys", "targetname"); 
     for(i=0;i<ecourt1_run_guys.size;i++) 
     { 
        println(ecourt1_run_guys[i].classname, " ^3num ", i); 
        spawned = ecourt1_run_guys[i] dospawn(); // Spawns the ACTUAL AI. And sets thSpawned to = the AI. 
	if(isdefined(spawned))
	{
	        println("^2 echurch guys should thread event5as next event"); 
		spawned.pacifist = false;
	        spawned thread ecourt1_run_thread(run_node); 
	}
     } 
} 

moody_talk_tank()
{
	println("^3 ************  talk tank activated **********");
	node = getnode("moody_tank_talk", "targetname");
	level.moody setgoalnode(node);
	level.moody.pacifist = true;
	level.moody waittill("goal");

	wait 2.1;
	//anim/sound begin
	
	//	anim_single (guy, anime, tag, node, tag_entity)	
		//hold up find some cover
		level.moody thread anim_single_solo(level.moody,"moody_talk_tank");
	//anim/sound end

	wait 4.9;	

	println(" Friends should now follow player");
	level.moody.pacifist = false;
	level.moody setgoalentity (level.player); // Set denny's goal to be the player.	
	level.moody.goalradius =  512; // Goal radius, how far the goal is to him	
	level.moody.followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
	level.moody.followmax = 2; // How many pathnodes to be ahead of the goal. // this was two

	level notify("tank_talk_done_continue");
}
 
ecourt1_run_thread( run_node ) 
{
	wait 0.1; // So the guys will set their goalradius. They may skip this line cause they're not really alive or whatever.
	self.goalradius = 30;
	println("^3 *********** goalradius: ", self.goalradius);
	self endon("death");     // make sure this function is killed if self dies 
 	
//	wait 2;
	self setgoalnode(run_node); 
	self waittill("goal"); 

	println("^3****************  :  ", self.goalradius);

	println("^3****************  :  ", self.goalradius);
//	self waittill("touch");
//	self waittill("movedone");  
// 	wait 5;

	self delete(); 
}

church_german_sounds()
{
//	angle1 = (1720,-1426,64);
	angle1 = (1105,-1497,276);
//	angle1 = (955,-1528,112);
	angle2 = (965,-1518,64);
	angle3 = (202,-1540,64);

//     	vec1 = maps\_utility_gmi::vectorScale(anglestoforward(angle1),0);
//     	vec2 = maps\_utility_gmi::vectorScale(anglestoforward(angle1),0);
//     	vec3 = maps\_utility_gmi::vectorScale(anglestoforward(angle1),0);
 
//     	vec1 = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(angle1),10);
//	angle2 = (1720,-1426,216); 
//     	vec2 = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(angle2),10);
//	angle3 = (1720,-1426,216); 
//     	vec3 = level.player.origin + maps\_utility_gmi::vectorScale(anglestoforward(angle3),10);
	level.german_mg42_setup = spawn("script_origin",(angle1));
	german_yell_1 = spawn("script_origin",(angle1));
	german_yell_2 = spawn("script_origin",(angle1));
	german_yell_3 = spawn("script_origin",(angle1));

//	german_yell_1 = spawn("script_origin",(vec1));
//	german_yell_2 = spawn("script_origin",(vec2));
//	german_yell_3 = spawn("script_origin",(vec3));

//	german_yells = 

//	for(n=0;n<10;n++)
//	{
//		wait 0.1 + randomfloat(3);	
//		num = (randomint(3)+1);
//		pop[num] instant_mortar();		
//	}

	german_yell_1 playsound("generic_misccombat_german_1");
	wait 3;
	german_yell_2 playsound("generic_misccombat_german_2");
	wait 2;
	german_yell_3 playsound("generic_flankright_german_2");
}

// this event clears the church
clear_church()
{
	church_door1 = getent("church_door1", "targetname");
	wait 1;
	church_door1 connectpaths();
	church_door1 rotateyaw(140, 0.3,0,0.3);	
//	maps\_utility_gmi::chain_on ("church_chain");
}

//church counter
event5a_counter()
{
	println("^5 CLear the CHURCH GO!!!!");

	echurch_guys = getentarray ("church_guys", "targetname");
	for(i=0;i<echurch_guys.size;i++)
	{
		println(echurch_guys[i].classname, " ^3num ", i);
		spawned = echurch_guys[i] dospawn(); // Spawns the ACTUAL AI. And sets the Spawned to = the AI.
		println("^2 echurch guys should thread event5as next event");

		// failsafe, if you need...
		if(isdefined(spawned))
		{
			spawned thread event5a_continue_if_all_ai_dead(); // AI runs this thread.
			spawned thread event5a_pacifist_germans();		
		}
	}
}

event5a_pacifist_germans()	// new stuff for church so it's easier to get into..
{
	self.pacifist = true;
	wait 4;
	if(isalive(self))
	{
		self.pacifist = false;
	}
}

event5a_continue_if_all_ai_dead()
{
	println("^3 counter should work for event5a");
	self waittill ("death"); // Waits until the AI is dead.

	level.echurch_guys_count++;
	println(self.targetname," ^1is DEAD!!! Count is: ", level.echurch_guys_count);	// telling itseld to print when dead	
//	Println will print this = blah is dead!!! Count is: 1

	if(level.echurch_guys_count == 10) // Checks the death count of roofsnipers.
	{
		println ("^3 church guys cleared");

//		level notify ("church is now cleared");

		// added to make sure that the player is hanging out inside the room.
		level thread event5a_wait_to_clear_last_room(); 
	}	
}

event5a_wait_to_clear_last_room()  // just enabled this again  -- make this trigger smaller and tighter in the church,...
{
	trigger = getent("last_room_check", "targetname");
	// turn trigger on on top floor once all the ai is dead that the player must check before the enabling the sniper event
	trigger waittill("trigger");
	println("^2 last church room checked now ");


	
//	level thread friends_move_thread("friends");

	level notify ("church is now cleared");
}

// this displays text above the ai -- for fun -- Mike showed me how to do this
print_dialog3d(who,text,duration)
{
	if(!isdefined(duration))
	{
		duration = 3;
	}
	time = 0;
	while(time < duration)
	{
		print3d((who.origin + (0,0,100)), text,(1,1,1), 2, 1);
		wait 0.075;
		time = 0.1 + time;
	}
}

//==============================
//
// flak gun
//
//==============================

flak88_explosion()
{

	thread maps\_bombs_gmi::init();

	// this sets objective, text that is seen on screen, object that is being destroyed // to the maps dir
	thread maps\_bombs_gmi::main(2, &"foy_OBJ_flak88", "flak88_use");	
	level waittill ("objective_complete1");
	eflak88 = getent("flak_88","targetname");
//	eflak88 makeVehicleUnusable(); // kunt
//	eflak88.notusable = 1;

	wait 7.2;
	level notify("flak_88_blown");	// goes back to moody move thread
}

//**********************************************//
//		FLAK GUN UTILITIES		//
//**********************************************//
flak88_init()
{
	self.ismoving = true;
	self thread maps\_flak_gmi::flak88_playerinit();
	self thread flak88_life();
	self thread flak88_shoot();
	self thread flak88_track_target();
	self thread flak88_target_hay();
	self thread flak88_stop_moving();
	self thread flakk88_allow_use_once_mg42_is_spawned();
	println("^3 hey the flak has init now!");
}

flak88_stop_moving()
{
	// need to stop it where it stands
	self waittill("stop_moving");	
	self.ismoving = false;
	etarget = getent("flak_eye", "targetname");
	self setTurretTargetEnt(etarget, (0, 0, 0));	
	etarget moveTo((-1402, -4476, 100), 0.01, 0, 0);
}

flakk88_allow_use_once_mg42_is_spawned()
{
	level waittill ("go_moody_talk_take_out_mg42"); 
	println("^6 ********************  go_moody_talk_take_out_mg42 make 88 useable        :       ");

	
	self makeVehicleusable();
//	self.notusable = 0;
}

flak88_life()
{
	self.isalive = 1;
	self.health  = 1000;
}

flak88_kill()
{
	println("^6 ******************** hey the 88 death is using the funtion in the level script");
	self.deathmodel = "xmodel/turret_flak88_d";
	self.deathfx    = loadfx( "fx/explosions/explosion1.efx" );
	self.deathsound = "explo_metal_rand";

	maps\_utility_gmi::precache( self.deathmodel );

	self waittill( "death", attacker );
	println(" ^3 flakk88 should die now");
//	level notify("objective_2_complete");
	self.isalive = 0;
	
	self setmodel( self.deathmodel );
	self playsound( self.deathsound );
	self clearTurretTarget();
	
	playfx( self.deathfx, self.origin );
	earthquake( 0.25, 3, self.origin, 1050 );
	self makeVehicleUnusable(); //kunt
//	self.notusable = 1;
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

// used to shoot shit
flak88_track_target()
{
		self.ismoving = true;
		while(self.isalive == 1 && self.ismoving)
		{
			etarget = getent("flak_eye", "targetname");
			// moveTo(vec position, float time, <float acceleration_time>, <float deceleration_time>);
			// (pos, 10, 1, 1);
			etarget moveTo((-1080, -5312, 48), 3, 1, 1);
			wait 0.25;
			self setTurretTargetEnt(etarget, (0, 0, 0));
			wait 5;
			etarget moveTo((-1188, -4400, 48), 3, 1, 1);
			wait 0.25;
			self setTurretTargetEnt(etarget, (0, 0, 0));
			wait 5;
			etarget moveTo((-960, -4832, 48), 3, 1, 1);
			wait 0.25;
			self setTurretTargetEnt(etarget, (0, 0, 0));	
		}
}

flak88_target_hay()
{
		level waittill("88_attack_haystack");
		if(self.ismoving)
		{
			println("^7 ********* flak shoot at hay now please");
			etarget = getent("flak_eye", "targetname");
			self setTurretTargetEnt(etarget, (0, 0, 0));	
			etarget moveTo((-1402, -4476, 100), 0.01, 0, 0);
	//		wait 0.25;
	//		wait 4;
			eflak88 = getent("flak_88", "targetname");
	//		eflak88 waittill("turret_on_vistarget");
			eflak88 waittill("turret_on_target");
			eflak88 fireturret();
	//		wait 1;	
			pop1 = getent("instant_mortar2", "targetname");
			println("Instant Mortar Trigger");
			pop1 instant_mortar();	
		}
}

//**********************************************//
//		Tank UTILITIES		//
//**********************************************//

#using_animtree( "panzerIV" ); // tank located in the courtard
tiger_init()
{
	self maps\_tiger_gmi::init();
	self useAnimTree( #animtree );
	self.isalive = 1;
	self.health  = 1000;
	path = getVehicleNode("tiger1_vehicle_node","targetname");
	self attachpath (path);
	self thread tiger1_wait();
	self thread tiger_destroyed();
	self thread force_mg42_off();	
}

tiger1_wait()
{
	level waittill("tiger1_move_back");
	self startPath();
}

tiger_destroyed()
{
	self waittill("death");
	self.health  = 0;
	self.isalive = 0;
	self maps\_tankgun_gmi::mgoff();
}

tank_control()
{
	self thread FireTank();	
}

force_mg42_off()
{
	level waittill("objective_complete8");
	self maps\_tankgun_gmi::mgoff();
}

FireTank()	// need to ask mike about the event ending except for the wait...
{
	self endon("death");
	//Pick a target for the main gun	
	eDummyTarget = getent("dummytarget","targetname");
	self setTurretTargetEnt(eDummyTarget, (0,-430,100));

	while(self.isalive ==  1)
	{
		if(self.health <= 550)
			return;
		println("^7 self is activated", self.health);

		wait (4 + randomfloat (4));
		{
			if(isalive(self))
			{
//				self maps\_tankgun_gmi::mgon();

				if(self.health <= 550)
					return;

				wait(2 + randomfloat (2));	
//				self maps\_tankgun_gmi::mgoff();
			}	
		}
		wait (2 + randomfloat(10));
		if(self.health <= 550)
			return;

		self thread panzerIV_fire();

		if(self.health <= 550)
			return;
		wait (2 + randomfloat (4));
		{
			if(isalive(self))
			{
//				self maps\_tankgun_gmi::mgon();

				if(self.health <= 550)
					return;

				wait(2 + randomfloat (1));	
//				self maps\_tankgun_gmi::mgoff();	
			}
		}
		if(self.health <= 550)
			return;
	}
}

tiger_fire_think_mg42()
{
//	self endon ("death");
//	while(self.isalive ==  1)
//	{
//		wait (2 + randomfloat (5));
//		if(self.isalive ==  1)
//		{
//			self maps\_tankgun_gmi::mgon();
//		}
//
//		wait(1 + randomfloat (2));	
//		self maps\_tankgun_gmi::mgoff();	
//	}
}

tiger_fire_think_mg42_kill()
{	
}

panzerIV_fire()
{
//	if( self.isalive != 1 )
//		return;
	// fire the turret
	self FireTurret();		
	// play the fire animation
	self setAnimKnobRestart( %PanzerIV_fire );
}

event4a_spawn_church_mg42_guy_now() 
{
	println("^3 EVENT4a, Were pinned down here kill that mg42");

	echurch_mg42_guy = getent("church_mg42_guy", "targetname");
	echurch_mg42_ai = echurch_mg42_guy dospawn();
//	echurch_mg42_ai.health = 5000;
	echurch_mg42_ai.ignoreme = true;
//	echurch_mg42_ai thread maps\_utility_gmi::magic_bullet_shield();
	echurch_mg42_ai thread event4a_spawn_church_mg42_guy_death();
	
	println("^6mg-guy ",echurch_mg42_guy.targetname);
//	wait 7;	
	trigger = getent("blow_tower_now", "targetname");
	trigger waittill("trigger");
	// talks to mikes event for tanks/ need to swap tank when player goes into church...
	level notify("blow_bell_tower");
}

blow_bell_tower_think() // bell_tower
{
	trigger = getent("look_at_bell_tower", "targetname");

 	trigger maps\_utility_gmi::triggeroff();


	level waittill ("allow_look_to_blow_up_tower");

 	trigger maps\_utility_gmi::triggeron();

	trigger waittill("trigger");
	wait 1;
	level notify("blow_bell_tower");
}

event4a_spawn_church_mg42_guy_death() // it looks like the bell tower can be blown two ways right...
{
	println("^6mg-guy ",self);
	
	// this makes it so the player must get to the spot that will allow the player to kill the mg42 nest	

	trigger = getent("mg42_nest_damage","targetname");
//	trigger waittill("damage");
	trigger waittill("damage", dmg, who);

	println(" ^4  dmg trigger waiting for tank to shoot it");
	println("dmg: ", dmg, "who: ", who);
	level.sherman_2 = getent ("sherman_2", "targetname");
	if(who==level.sherman_2)
	{
		println("^3************************ level.sherman_2 is in THE FUNCTION *************************");
//		self.health = 1;
//		self notify ("stop magic bullet shield");

//		wait 0.9;
//		turret = self GetTurret();
//		turret notify ("death");
//		turret notify ("killanimscript");


		
		
//		self notify ("killanimscript");
		if(isalive(self))
		{
			self DoDamage ( self.health + 100, self.origin );
		}
//		self DoDamage ( self.health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );	

//		wait 0.25;
		level notify("blow_bell_tower");
		// just put this in
	
		level notify("objective_4_complete");	
		println("^8************************ EVENT4a, Mg42 guy killed by trigger damage*************************");

//		ehouse6_door1 = getent("house6_door1", "targetname");	
//		ehouse6_door1 connectpaths();
	}
}

btower_mg42_kill() // new function to ensure the mg42 deleting
{
	println (self.targetname, " ^1is mg 42 church DEAD!!!");	// telling itseld to print when dead
	
	// continues script after the mg 42 nest has been killed
	level notify("church_mg42_dead"); //bell_tower
	wait 0.25;		
	mg42 = getent("auto1757","targetname");
	mg42 notify("stopfiring");
	wait 0.25;
	mg42 delete();
}

// truck Drive by which occurs in the courtyard before the mg42 belltower event
german_truck (trigger)
{

	println("^6 ready to fire");

	trigger waittill ("trigger");

	println("^2 TRuck is activated now");

	truck = getent (trigger.target,"targetname");	// this uses the name of the target assigned by entity that targets it.

	driver = getent (truck.target,"targetname");


	truck maps\_truck_gmi::init();
	truck maps\_truck_gmi::attach_guys(undefined,driver);
	path = getVehicleNode(truck.target,"targetname");

	truck attachpath (path);
	truck startPath();
	node = path;
	while (1)
	{
		node = getvehiclenode (node.target,"targetname");
		truck setWaitNode (node);
		truck waittill ("reached_wait_node");
		if (isdefined (node.script_noteworthy))
			break;
	}

	truck notify ("unload");
	truck stopEngineSound();
	truck waittill ("reached_end_node");
	truck disconnectpaths();
	wait (2);
}

etank1_cover()
{
	while(1)
	{
		if(self.health <= 100)
		{
			dst_switchnode_1 = getVehicleNode( "tank1_c1", "targetname" );
		
			src_switchnode   = getVehicleNode( "t1", "targetname" );
		
			self setSpeed(5, 2);	
			self setSwitchNode( src_switchnode, dst_switchnode_1 );

	
			println("^1 Hey get back on that path tanky!");

			dst_switchnode_2 = getVehicleNode( "auto19", "targetname" );
		
			src_switchnode_2 = getVehicleNode( "auto63", "targetname" );

			self resumeSpeed(2);	
			self setSwitchNode( src_switchnode_2, dst_switchnode_2 );
		}
	}
}

tank_control2()
{
	//Set up first course change node

	eTurnNode1 = getVehicleNode("auto56","targetname");
	self setWaitNode(eTurnNode1);
	wait 10;
	self startPath();
	self waittill("reached_wait_node");
	
}

draw_name()
{
	ai = getaiarray("axis");
	while(1)
	{
		for(i=0;i<ai.size;i++)
		{
			if(isalive(ai[i]) && isdefined(ai[i].targetname))
			{
	//			print3d(vec origin, string, vec rgb = (1, 1, 1), float a = 1, float scale = 1);
				print3d((ai[i].origin + (0,0,100)), ai[i].targetname, (1,1,1), 5, 1);
			}
			else if(isalive(ai[i]))
			{
				print3d((ai[i].origin + (0,0,100)), "UNDEFINED", (1,1,1), 5, 1);
			}
		}
		wait 0.075;
	}
}

draw_health()
{
	while(1)
	{
		if(isdefined(self.health))
		{
			print3d((self.origin + (0,0,100)), self.health, (1,1,1), 5, 1);
		}

		wait 0.075;
	}
}

// debug for tanks and moody moving forward for event8
event8a_start()
{
		moody = getent("moody","targetname");
		moody teleport ((247, -1172, 20));
		wait 0.25;

		friends2 = getentarray("friends","groupname");
		for(i=0;i<friends2.size;i++)
		{
			friends2[i] thread maps\_utility_gmi::magic_bullet_shield();
			wait 3;
			friends2[i] teleport  ((296, -1358, 20));
			node = getnodearray("cover_15", "targetname");
			friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.		
		}
		println("^3 Everyone is in position!");

		// sets up sniper event
		node_moody = getnode("cover_moody_21", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");

		// makes moody wait for player
		trigger = getent("sherman_2nd_advance_wait_player", "targetname");
		trigger waittill("trigger");

		// this starts up a sherman down the main path...

		level notify("shermans_leave_town"); // starts remaining two tanks on thier path

		println(" ^7 wait for the tanks to get ahead and then follow");
		wait 15;

		node_moody = getnode("auto2344", "targetname");
		moody setgoalnode(node_moody);

		friends2 = getentarray("friends","groupname");
		for(i=0;i<friends2.size;i++)
		{
			if(isalive(friends2[i]))
			{		
				node = getnodearray("cover_16", "targetname");
				friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.	
			}	
		}

		moody waittill("goal");

		wait 6;

		node_moody = getnode("cover_moody_22", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");	

		friends2 = getentarray("friends","groupname");
		for(i=0;i<friends2.size;i++)
		{
			if(isalive(friends2[i]))
			{	
				node = getnodearray("cover_17", "targetname");
				friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.		
			}
		}


		// this trigger waits for player to orderes to flank house
		trigger = getent("event8_tank_blown", "targetname");
		trigger waittill("trigger");

		println("^3 Holy cow we gatta flank that tank on the other side of the building follow me");

		wait 3;
		// crosses river with this node
		node_moody = getnode("cover_moody_23", "targetname");
		moody setgoalnode(node_moody);

		friends2 = getentarray("friends","groupname");
		for(i=0;i<friends2.size;i++)
		{
			if(isalive(friends2[i]))
			{	
				node = getnodearray("cover_18", "targetname");
				friends2[i] setgoalnode(node[i]); // Sets EACH friend to the corresponding node.		
			}
		}

		trigger = getent("event8f", "targetname");
		println("^3 event8f trigger on");
		trigger waittill("trigger");

		moody waittill("goal");	
		// spotter should wait till last second
		level thread last_spotter();
		level.player.threatbias = -2000;

		println("^3 OK that house ahead must be it sneak in and will be right behind you when you blow up that hidden tank");
}

#using_animtree("generic_human");
last_spotter()
{

	//sniper = getent ("event6a_sniper", "targetname");
	//esniper = sniper dospawn(); // Spawns the ACTUAL AI. And sets the Spawned to = the AI.

	spotter = getent ("event8f_spotter", "targetname");
	println("^3 *************** ", spotter.targetname);
	espotter = spotter dospawn(); // Spawns the ACTUAL AI. And sets the Spawned to = the AI.
	if(isdefined(espotter))
	{
		wait 0.5;
		println("^3 *************** I AM ALIVE!!! ESPOTTER!");	
		espotter.pacifist = true;
		espotter.goalRadius = 0;
	}
	eDummyTarget = getent("tiger2","targetname");
	wait 0.25;

	println("^7 spotter should wait till player gets real close now!");	
}

// Tell everyone to get into position outside of church after clearing it
sniper_event6()
{

		moody = getent("moody","targetname");
		moody teleport ((-912, -1664, 24));
		wait 0.25;

		moody.maxsightdistsqrd = 0.25; // 3000 units
		moody.suppressionwait = 0;
		moody.pacifist = true;

		node_moody = getnode("cover_moody_15", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");

		println("^7 Great work guys you've done a great job here today... sniper..."); 
		wait 3;
		println("^3 eventa6 sniper attack on");
		trigger = getent("event6_sniper_attack", "targetname");
		trigger waittill("trigger");
		println("^3 eventa6 sniper attack used");
		
		wait 1;	

		sniper = getent ("event6a_sniper", "targetname");
		esniper = sniper dospawn(); // Spawns the ACTUAL AI. And sets the Spawned to = the AI.
		esniper thread event6_sniper_death();

		node_moody = getnode("cover_moody_16", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");
		level thread friends_move_thread("friends");

		println("^3 moody run for cover trigger on");
		trigger  = getent("event6a_ready_to_shoot", "targetname");
		trigger waittill("trigger");
		println("^3 moody run for cover trigger used");

		wait 1;

		println("^2 OK I'm going to head to into the street, shoot the sniper and don't miss!");

		wait 2;

		// running as sniper shoots at him
		node_moody = getnode("cover_moody_17", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");
		println("^3 moody made it to cover_moody_17");	
		wait 4;

		node_moody = getnode("cover_moody_18", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");
		println("^3 moody made it to cover_moody_18");
		wait 4;

		node_moody = getnode("cover_moody_19", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");
		println("^3 moody made it to cover_moody_19");
		wait 4;

		node_moody = getnode("cover_moody_20", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");
		println("^3 moody made it to cover_moody_20");
		wait 4;

		node_moody = getnode("cover_moody_12", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");
		println("^3 moody made it to cover_moody_12");
		wait 4;


		// conmtinue debug -- once shermans are safe please move onto event8
		level waittill("Shermans_safe_in_town");
	
		wait 3;
		println("^6 OK the shermans are safe shut down the normal attack");

		node_moody = getnode("cover_moody_21", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");

		// makes moody wait for player
		trigger = getent("sherman_2nd_advance_wait_player", "targetname");
		trigger waittill("trigger");

		println("^3 debug : OK moody get into position with tank");

		// this starts up a sherman down the main path...
		level thread event8a_shermans();

		println(" ^7 wait for the tanks to get ahead and then follow");
		wait 15;

		node_moody = getnode("auto2344", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");	

		node_moody = getnode("cover_moody_22", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");	

		// this trigger waits for player to orderes to flank house
		trigger = getent("event8_tank_blown", "targetname");
		trigger waittill("trigger");

		node_moody = getnode("cover_moody_22", "targetname");
		moody setgoalnode(node_moody);
		moody waittill("goal");	

		// objective flank tank
		iprintlnbold(&"GMI_FOY_OBJECTIVE_7");
		println("^3 Holy cow we gatta flank that tank on the other side of the building follow me");

		wait 3;

		node_moody = getnode("cover_moody_23", "targetname");
		moody setgoalnode(node_moody);


		// crosses river with this node
		moody waittill("goal");	

		println("^3 OK that house ahead must be it sneak in and will be right behind you when you blow up that hidden tank");
}

event6_sniper_death()
{
	println (self.targetname, " ^1is waiting for death!");	// telling it self to print 
	println("^5 sherman event should occur now");
	
	self waittill ("death"); // Waits until the AI is dead.

	wait 0.25;

	level notify("objective_6_complete");	

	// spawner control so the ai stops respawning and the tanks can continue
	level thread event7a_flood_spawner_setup();

	// objective protect tanks
	iprintlnbold(&"GMI_FOY_OBJECTIVE_7");

	println (self.targetname, " ^1is DEAD!!!");	// telling itseld to print when dead

	println("^5 Great shot kid: Here come the shermans get up to the church");

	level thread event7_tank_pre();
}

event7_tank_pre()
{
	wait 0.1;

	level thread event7a_flood_spawner_setup();

	// starts shermans on thier path towards the player
	level thread event7a_shermans();

	// MikeD: DUMMIES Wait for player to get to blow_haystack1, then start the haystack dummies.
	level thread dummies_lasthill();

}

event7a_flood_spawner_setup()
{
	level waittill("Shermans_safe_in_town");

	println("^3 *************** spawners should now shut down !!!");
	spawners = getentarray("event7_attackers","groupname");

	// Disable all of the spawners, during the bell tower fight.
	for(i=0;i<spawners.size;i++)
	{
		println("^1Spawner disabled!");
		spawners[i] notify("disable");
		level.flag["disable_faust_attack"] = true;
	}
}      

//-----------------------------------------------------//
//						       //
//	This section is used for the rolling shermans  //
//	Quite a bit of hacking... esp, the AI!	       //
//-----------------------------------------------------//
#using_animtree("generic_human");
ai_attack_tank1()
{
	while(1)
	{
		for(i=1;i>0;i--)
		{
			println(i);
			wait 1;
		}
	
		wait 0.25;
		tank_attacker = getentarray("panzerfaust1", "groupname");
		esherman_2 = getent("sherman_1","targetname");
		esherman_2 = getent("sherman_2","targetname");
		esherman_3 = getent("sherman_3","targetname");
	
		// you need a for loop to grab the spawner info first the seconf guy
		for(i=0; i<tank_attacker.size; i++)
		{
			if(isalive(esherman_2) )
			{
				if(isai(tank_attacker[i]) && isalive(tank_attacker[i]))
					{
						tank_attacker[i].drawoncompass = true;
						tank_attacker[i] thread attacker1();	
						println("^3 made it attack node");
						attack_node = getnode("attacker1_spot" ,"targetname"); // Get all of the nodes the specified targetname.
						tank_attacker[i].pacifist = true;
						tank_attacker[i].pacifistwait = 9999999;
						tank_attacker[i] setgoalnode(attack_node); 
						tank_attacker[i] waittill("goal");
						tank_attacker[i] animscripts\combat_gmi::fireattarget((0,0,50), 1, forceShoot, completeLastShot, esherman_2, true);
						tank_attacker[i].pacifist = false;
						tank_attacker[i] endon("death");
					}
			}

			if(isalive(sherman_3) && !isalive(sherman_2) )	// sherman 2 must be dead and three alive
			{
				if(isai(tank_attacker[i]) && isalive(tank_attacker[i]))
					{
						tank_attacker[i].goalradius = 0;
						tank_attacker[i].drawoncompass = true;
						tank_attacker[i] thread attacker1();	
						println("^3 made it attack node");
						attack_node = getnode("attacker1_spot" ,"targetname"); // Get all of the nodes the specified targetname.
						tank_attacker[i].pacifist = true;
						tank_attacker[i].pacifistwait = 9999999;
						tank_attacker[i] setgoalnode(attack_node); 
						tank_attacker[i] waittill("goal");

						esherman_3 = getent("sherman_3","targetname");

						tank_attacker[i] animscripts\combat_gmi::fireattarget((0,0,74), 1, forceShoot, completeLastShot, esherman_3, true);
						tank_attacker[i].pacifist = false;
						tank_attacker[i] endon("death");		
					}
			}
		}
		wait 10;
	}
}
attacker1()
{
	self waittill ("death");
	println(" ^3 attacker1 makes it to his death");
	self.drawoncompass = false;
	if(level.flag["disable_faust_attack"])
	{
			return;
	}

	level thread ai_attack_tank1();
}

#using_animtree("generic_human");
ai_attack_tank2()
{
	while(1)
	{
		for(i=1;i>0;i--)
		{
			println(i);
			wait 1;
		}
	
		wait 0.25;

		tank_attacker2 = getentarray("panzerfaust2", "groupname");
	
		// you need a for loop to grab the spawner info first the second guy
		for(i=0; i<tank_attacker2.size; i++)
		{
			if(!isalive(sherman_2) )
			{
				if(isai(tank_attacker2[i]) && isalive(tank_attacker2[i]))
					{
						tank_attacker2[i].drawoncompass = true;	
						tank_attacker2[i].goalradius = 0;
						tank_attacker2[i] thread attacker2();
						println("^3 made it attack node");
						attack_node = getnode("attacker2_spot" ,"targetname"); // Get all of the nodes the specified targetname.
						tank_attacker2[i].pacifist = true;
						tank_attacker2[i].pacifistwait = 9999999;
						tank_attacker2[i] setgoalnode(attack_node); 
						tank_attacker2[i] waittill("goal");	
						esherman_2 = getent("sherman_2","targetname");

						tank_attacker2[i] animscripts\combat_gmi::fireattarget((0,0,74), 1, forceShoot, completeLastShot, esherman_2, true);
						tank_attacker2[i].pacifist = false;
						tank_attacker2[i] endon("death");	
					}
			}

			if(!isalive(sherman_3) )
			{
				if(isai(tank_attacker2[i]) && isalive(tank_attacker2[i]))
					{
						tank_attacker2[i].drawoncompass = true;	
						tank_attacker2[i].goalradius = 0;
						tank_attacker2[i] thread attacker2();
						println("^3 made it attack node");
						attack_node = getnode("attacker2_spot" ,"targetname"); // Get all of the nodes the specified targetname.
						tank_attacker2[i].pacifist = true;
						tank_attacker2[i].pacifistwait = 9999999;
						tank_attacker2[i] setgoalnode(attack_node); 
						tank_attacker2[i] waittill("goal");
						esherman_3 = getent("sherman_2","targetname");
						tank_attacker2[i] animscripts\combat_gmi::fireattarget((0,0,74), 1, forceShoot, completeLastShot, esherman_3, true);
						tank_attacker2[i].pacifist = false;
						tank_attacker2[i] endon("death");
					}
			}
		}
		
		wait 10;
	}
}

attacker2()
{
	self waittill ("death");
	println(" ^3 attacker1 makes it to his death");
	self.drawoncompass = false;
//	wait 2;
	level thread ai_attack_tank2();
	
}    

//====================================================================
//
//  SHERMANS setup to go through the town			 
//
//====================================================================
#using_animtree("generic_human");
event7a_shermans()
{	
	level.flag["shermans_attack_drone"] = true;

	eshermans_array =[];// this defines it as an array
	eshermans_group = getentarray("shermans", "groupname");
	println("^6**************** event7a group and array setup!");

	for(i=1;i<(eshermans_group.size+1);i++)//	thad addon	
	{
		println("^6**************** event7a made it into for loop!");		
		eshermans_array[i] = getent("sherman_" + i, "targetname");

		eshermans_array[i].addVehicleToCompass = true;
//		eshermans_array[i].drawoncompass = true;
		
		println("^3", eshermans_array[i], eshermans_array[i].targetname);	

		if(eshermans_array[i].targetname == "sherman_1")
		{

			println("^3****************** array setup for shermans four");
			println("^3************** SHERMAN_1 GOT HIS INFO", eshermans_array[i].health, eshermans_array[i].targetname);
			eshermans_array[i].health = 500000;
			eTank1StartNode = getVehicleNode("startnode1_tank1_town1","targetname");
			eshermans_array[i].isalive = 1;
//			eshermans_array[i] thread maps\_sherman_gmi::init();
			eshermans_array[i] thread maps\_sherman_gmi::init_noattack();
			target[1] = (854, 3197, 185);
			eshermans_array[i] setTurretTargetVec(target[1]);
			eshermans_array[i] thread sherman_1_drive_town();
			eshermans_array[i] thread sherman_mg42_attack();
//			eshermans_array[i] thread shermans_attack_drones();
			eshermans_array[i] thread kill_fire();	
			eshermans_array[i].addVehicleToCompass = true;
		}

		else if(eshermans_array[i].targetname == "sherman_2")
		{
			wait 0.15;
			println("^3************** SHERMAN_2 GOT HIS INFO", eshermans_array[i].health, eshermans_array[i].targetname);
			eshermans_array[i].health = 500000;
			eshermans_array[i].isalive = 1;	
//			eshermans_array[i] thread maps\_sherman_gmi::init();
			eshermans_array[i] thread maps\_sherman_gmi::init_noattack();
			target[1] = (854, 3197, 185);
			eshermans_array[i] setTurretTargetVec(target[1]);
			eshermans_array[i] thread sherman_2_drive_town();
			eshermans_array[i] thread sherman_mg42_attack();
			eshermans_array[i] thread sherman_blow_house_down_street(); // blow up house...
//			eshermans_array[i] thread shermans_attack_down_street();
			eshermans_array[i] thread sherman_mg42_attack_bridge();
//			eshermans_array[i] thread shermans_attack_drones();
			eshermans_array[i] thread shermans_attack_across_bridge();
			eshermans_array[i] thread kill_fire();	
			eshermans_array[i] thread sherman_death_counter();
			eshermans_array[i].addVehicleToCompass = true;
		}

		else if(eshermans_array[i].targetname == "sherman_3")
		{
			wait 0.15;
			println("^3************** SHERMAN_3 GOT HIS INFO", eshermans_array[i].health, eshermans_array[i].targetname);
			eshermans_array[i].health = 500000;
			eshermans_array[i].isalive = 1;
//			eshermans_array[i] thread maps\_sherman_gmi::init();
			eshermans_array[i] thread maps\_sherman_gmi::init_noattack();
			println("^2 tank 3 should be heading towards to last node for event7");
			target[1] = (854, 3197, 185);
			eshermans_array[i] setTurretTargetVec(target[1]);
			eshermans_array[i] thread sherman_3_drive_town();
			eshermans_array[i] thread sherman_mg42_attack();
			eshermans_array[i] thread sherman_mg42_attack_bridge();
//			eshermans_array[i] thread shermans_attack_drones();
			eshermans_array[i] thread shermans_attack_across_bridge();
			eshermans_array[i] thread kill_fire();
			eshermans_array[i] thread sherman_death_counter();
			eshermans_array[i].addVehicleToCompass = true;
		}

		else if(eshermans_array[i].targetname == "sherman_4")
		{
			wait 0.15;
			println("^3************** SHERMAN_4 GOT HIS INFO", eshermans_array[i].health, eshermans_array[i].targetname);
			eshermans_array[i].health = 50000;
			eshermans_array[i].isalive = 1;
			eshermans_array[i] thread maps\_sherman_gmi::init();
			target[1] = (854, 3197, 185);
			eshermans_array[i] setTurretTargetVec(target[1]);
			eshermans_array[i] thread sherman_mg42_attack();
			eshermans_array[i] thread sherman_4_drive_town();
			eshermans_array[i].addVehicleToCompass = true;
		}
		eshermans_array[i] thread sherman_1_death_wait();
		eshermans_array[i] thread sherman_1_death_wait_protect_tanks();
	}
}

kill_fire()
{
	self waittill("death");
	level thread tank_turn_fire_off(self);	// this will wait till they die to turn off lights
}

tank_turn_fire_off(vehicle)
{
//	self waittill("death");
//	wait 5;
	stopattachedfx(vehicle);
}


//============================
//
//	commented out to test panzer guys
//
//============================
sherman_mg42_attack()	// slowing down attacks of turret guns because they are to fast right now.
{
	//Pick a target for the main gun
//	println("^3************** SHERMAN_2 GOT HIS INFO", self.health, self.targetname);	
//	while(self.isalive == 1)
//	{
//		self endon("Shermans_safe_in_town");
//		self endon("death");
//		println("^7 self is activated", self.health);
//			wait (4 + randomfloat (4));
//			{
//				self endon("death");
//				self maps\_tankgun_gmi::mgon();
//				wait(2 + randomfloat (6));	
//				self maps\_tankgun_gmi::mgoff();	
//			}
//	}
}

sherman_mg42_attack_bridge()	// slowing down attacks of turret guns because they are to fast right now.
{
	//Pick a target for the main gun
	println("^3************** SHERMAN_ GOT HIS INFO", self.health, self.targetname);	
	self endon ("death");
	
	level waittill("attack_bridge_now");

	while(self.isalive == 1)
	{
			wait (8 + randomfloat (4));
			{
				if(isalive(self))
				{
// this was occuring because the turrets were turned off
//					self maps\_tankgun_gmi::mgon();
//					wait(8 + randomfloat (6));	
//					self maps\_tankgun_gmi::mgoff();	
				}
			}
	}
}
	
// this loop runs untill the first sherman is destroyed
sherman_1_death_wait()
{
	if( self.targetname == "sherman_1") // this is not workin
	{
		println("^6 ************** sherman_1 waits for death now**************");
		self waittill("death");

			if(level.flag ["sherman1_can_die_during_protect_tanks"] == false)
			{
				level notify("sherman_1_dead_continue");
				println("^6 ************** sherman_1  death worked! for bridge******************");
				println("^6 ************** SHerman_1 dead all guys get into position now******************");
			}
	}
}

sherman_1_death_wait_protect_tanks() 
{
	// need a new variable for this tank blowing up before the bridge
	if( self.targetname == "sherman_1")
	{
		self waittill("death");

			if(level.flag ["sherman1_can_die_during_protect_tanks"] == true)
			{
				println("^6 ************** sherman_1  death worked! for all tanks dying******************");
				//objective_string(10, &"GMI_FOY_PROTECT_TANKS");
				setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_FOY_PROTECT_TANKS");
				objective_state(10, "failed");
				missionfailed();
			}
	}
}

//==============================================================================================================
//
// Sherman offset paths for moving through town
// these are the events that control sending the tanks through the town
//
//==============================================================================================================
sherman_1_drive_town(sherman_1)
{
		//wait 45;
		wait 55;
 

//		self.health  = 50000; // new health that allows this tank to be blown up as it drives down the street
		level.flag ["sherman1_can_die_during_protect_tanks"] = true;		
		println(" ^ 2******************	sherman1_can_die_during_protect_tanks true ****************");	

		path = getVehicleNode("tiger2_startnode","targetname");
	
		self attachpath (path);
		self startPath();

		self thread sherman_1_drive_town_health_thinker(); //new tracker


		print("^6 ************** tank1 starts path must wait");
		eTank1StartNode = getVehicleNode("startnode1_tank1_town1","targetname");	
		self attachPath(eTank1StartNode);

		self startPath();
		self setspeed(5,2);
		println("^3 ***********", self.speed, eTank1startNode);
		print("^6 ************** tank1 starts path");println("^3 ***********", self.speed, eTank2StartNode);

		// stops in front of church now
		ewaitnode = getvehiclenode("s1_wait1", "targetname");
		self setWaitNode(ewaitnode);
		self waittill ("reached_wait_node");
		self setspeed (0, 10000);

		/// new today !!! jerey added COCK
		level.flag ["sheman_made_it_into_town"] = true; // use when you don't want other vo to over lap..
		level thread shermans_made_it();

		level.flag ["sherman1_can_die_during_protect_tanks"] = false;
		println(" ^ 2******************	sherman1_can_die_during_protect_tanks FALSE FALSE ****************");


		level waittill("shermans_leave_town");

		target[1] = (-568, 9368, 185);
		self setTurretTargetVec(target[1]);

		self resumespeed (10000);
		ewaitnode = getvehiclenode("auto2313", "targetname");
		self setWaitNode(ewaitnode);
		self waittill ("reached_wait_node");
		self setspeed (0, 10000);

		self thread sherman_1_player_distance_check();
		wait 0.05;
		level waittill("player_close_to_sherman");

		self resumespeed (10000);
		ewaitnode = getvehiclenode("auto2314", "targetname");
		self setWaitNode(ewaitnode);
		self waittill ("reached_wait_node");
		self setspeed (0, 10000);


		println("^6 ********** sherman_1 reached his wait node!");
//		wait 20;
		self.health = 10;
		println("^6 ********** sherman_1 health set", self.health);
		// once the tanks are safe the serg will trigger this tanks to move forward
//		level waittill("event8a_go ");
		self resumespeed (10000);


		println("^6 **************** SHerman_1 should continue till the end of the map now!");
		self waittill("reached_end_node");
//		wait 2;
		
		// sets up and exe tiger two event

		level.eTiger2 = getent("tiger2","targetname");
		level.eTiger2 maps\_tiger_gmi::init();
		level.eTiger2 thread tiger2_fire_think();
		level.eTiger2 thread tiger2_death();
		self.isalive = 1;
		level.eTiger2 thread tank_tiger_control2();
}

sherman_1_drive_town_health_thinker() // only works during the drive through town
{
	self endon ("death");
	wait 2;
	while(level.flag ["sherman1_can_die_during_protect_tanks"] == true)
	{
		// both tanks are dead set health low here, check death counter
		if(level.shermans_count == 2)
		{
			println("sherman1 health ", self.targetname, self.health);
			self.health = 30;
			wait 5;
		}		
		wait 0.05;
//		self.health = 50000;
	}

}

sherman_1_player_distance_check()
{
	while(1)
	{
		// se new flag here that says moody is done talking.
		if(level.flag ["moody_talking_take_cover"] == false)
		{

			while (distance (level.player getorigin(), self.origin) < 1500)
			{
				println("^6 **************** player close enough for event to continue***********");
				println("^6 **************** player close enough for event to continue***********");
				println("^6 **************** player close enough for event to continue***********");
				println("^6 **************** player close enough for event to continue***********");
				level notify("player_close_to_sherman");
				level thread kill_allies_in_town();//enable
				wait 0.05;
			}
		}
		wait 1;
	}
}

kill_allies_in_town()
{
	println("^3 ******************** clean up house friends, foley friends and ambient fight 2 ***********");
	println("^3 ******************** clean up house friends, foley friends and ambient fight 2 ***********");
	println("^3 ******************** clean up house friends, foley friends and ambient fight 2 ***********");
	println("^3 ******************** clean up house friends, foley friends and ambient fight 2 ***********");
	ambient6 = getentarray("ambient_fight2", "groupname");

	if(isalive(level.esupport_ai))
	{
		level.esupport_ai delete();	
	}


	ambient6 = getentarray("ambient_fight2", "groupname");	
	for(i=0;i<ambient6.size;i++)
	{
		if(isalive(ambient6[i]))
		{
			ambient6[i] delete();
			wait 1;
		}
	}

	house = getentarray("house_friends", "groupname"); // these guys need to do something interesting...
	for(n=0;n<house.size;n++)
	{
		if(isalive(house[n]))
		{
			house[n] delete();
			wait 1;
		}
	}
}

//========================================
//
// This is a new path that sherman two will jump on the the tiger is destroyed
//
//========================================
sherman_2_drive_bell_setup()
{
//		level waittill ("Tiger1_destroyed");

		if(self.targetname == "sherman_2")
		{
			level waittill("objective_complete8");	
	
			eTank2StartNode = getVehicleNode("sherman2_setup_bell","targetname");	
			self attachPath(eTank2StartNode);
	
			self startPath();
			self setspeed(4,4);
		}
}

sherman_2_drive_town()
{
		//wait 27; old wait with old version



		eTank2StartNode = getVehicleNode("startnode2_remade","targetname");	
		self attachPath(eTank2StartNode);
	
		self startPath();
		self setspeed(5,2);
		println("^3 ***********", self.speed, eTank2StartNode);
		print("^6 ************** tank2 starts path");

		// heading out of town

		ewaitnode = getvehiclenode("startnode2_g", "targetname");
		self setWaitNode(ewaitnode);
		self waittill ("reached_wait_node");
		self setspeed (0, 10000);

		level thread sherman_arrive_counter();



		level waittill("shermans_leave_town");
//		self.health = 30;
		wait 3;
		target[1] = (-568, 9368, 185);
		self setTurretTargetVec(target[1]);


		println("^6 ********** sherman_2 reached his wait node!");
		println("^6 ********** sherman_2 health what is this guys health", self.health);
		self resumespeed (10000);


		println("^6 **************** SHerman_2 should continue", self.speed);

		ewaitnode = getvehiclenode("auto2462", "targetname");
		self setWaitNode(ewaitnode);
		self waittill ("reached_wait_node");
		self setspeed (0, 10000);

		// once the tank is blown send shermans across river
		level waittill("shermans_end_map"); // starts remaining two tanks on thier paths
		target[1] = (402, 7781, 231);
		self setTurretTargetVec(target[1]);
		wait 5;
		self resumespeed (10000);
}

sherman_3_drive_town()
{
		println("^3 ******************* Tank 3 should now wait 60 sec and then thread event7a_end when he's done moving");
		println("^3 ******************* Tank 3 should now wait 60 sec and then thread event7a_end when he's done moving");
		println("^3 ******************* Tank 3 should now wait 60 sec and then thread event7a_end when he's done moving");
		println("^3 ******************* Tank 3 should now wait 60 sec and then thread event7a_end when he's done moving");
		println("^3 ******************* Tank 3 should now wait 60 sec and then thread event7a_end when he's done moving");
		println("^3 ******************* Tank 3 should now wait 60 sec and then thread event7a_end when he's done moving");
		println("^3 ******************* Tank 3 should now wait 60 sec and then thread event7a_end when he's done moving");
		println("^3 ******************* Tank 3 should now wait 60 sec and then thread event7a_end when he's done moving");
		println("^3 ******************* Tank 3 should now wait 60 sec and then thread event7a_end when he's done moving");

		wait 27; // this is the old wait for sherman two old being used for sherman three
	
		//wait 45; 




		eTank3StartNode = getVehicleNode("startnode3","targetname");	
		self attachPath(eTank3StartNode);

		self startPath();
		self setspeed(5,2);
		println("^3 ***********", self.speed, eTank3StartNode);
		print("^6 ************** tank3 starts path");
		wait 0.25;

		self thread fire_smoke();
		self thread event7a_end();

		ewaitnode = getvehiclenode("jl222", "targetname");
		self setWaitNode(ewaitnode);
		self waittill ("reached_wait_node");
		self setspeed (0, 10000);
		self.health = 30;

		level thread sherman_arrive_counter();

		level waittill("shermans_leave_town");
		wait 2;
		target[1] = (-568, 9368, 185);
		self setTurretTargetVec(target[1]);

		println("^6 ********** sherman_2 reached his wait node!");
		wait 2;
		println("^6 ********** sherman_2 health set", self.health);
		self resumespeed (10000);

		ewaitnode = getvehiclenode("auto2473", "targetname");
		self setWaitNode(ewaitnode);
		self waittill ("reached_wait_node");
		self setspeed (0, 10000);

		// once the tank is blown send shermans across river
		level waittill("shermans_end_map"); // starts remaining two tanks on thier paths
		target[1] = (402, 7781, 231);
		self setTurretTargetVec(target[1]);
		wait 5;
		self resumespeed (10000);
}

sherman_4_drive_town()
{
//	wait 47;
	wait 76;
	eTank4StartNode = getVehicleNode("startnode1_tank4_block_town1","targetname");
	println("SELF = ",self);
	println("eTank4StartNode = ",eTank4StartNode);
	self attachPath(eTank4StartNode);

	println("^3************** SHERMAN_4 GOT HIS INFO", self.health, self.targetname);

	self startPath();
	self setspeed(5,2);
	self.isalive = 1;
	self resumespeed (10000);
}

sherman_death_counter()
{
	println (self.targetname, " ^1 waiting for sherman to die");	// telling itseld to print when dead

	self waittill("death");


	println (self.targetname, " ^1 sherman tanks is dead!");	// telling itseld to print when dead


	level.shermans_count++;
	if(level.shermans_count == 2) // Checks the death count of roofsnipers.
	{
		level notify ("sherman1_and_2_are_dead_allow_sherman1_death");
		// send message from here to allow the tanks health to be low enough to be destroyed...
		println ("^3 All tanks have been destroyed end mission");
//		missionfailed();
	}
}

sherman_arrive_counter()
{
	level.shermans_arrive_count++;
	if(level.shermans_arrive_count == 2) // Checks the death count of roofsnipers.
	{
		println("^3 **********************  sherman arrived count up******************");
		println("^3 **********************  sherman arrived count continue******************");
	}
}

// This needs to be called before the new guys spawn in!
sherman_attack_bell_tower()
{
		edummytarget = getent("event7_tankshoot1", "targetname");
		edummytarget moveTo((367, -1711, 428 ), 0.01, 0, 0);	// this hits bell tower!	
		println("^3 ************** ", self.targetname);
		self setTurretTargetent(edummytarget, ( 0, 0, 0 ) );

		// Wait till we are told to blow the tower
		level waittill("blow_bell_tower");
		self fireturret();
		level thread whitney_thank_11th(); 
		level thread btower_mg42_kill();
	
		// Reset the shermans gun after blowing up the tower
		wait 5;
		target_pos[0] = (56, -1056, 183);
		self setTurretTargetVec(target_pos[0]);

		// Remove the mg42 in the tower
//		wait 3;		
//		mg42 = getent("auto1757","targetname");
//		mg42 delete();
}

whitney_thank_11th() 
{
	wait 2;
	//thank you 11th armor
	level.moody thread anim_single_solo(level.moody,"11th_thank_you");
}


sherman_attack_house2() // not used
{
		edummytarget = getent("event7_tankshoot1", "targetname");
		wait 20;
		self setTurretTargetent(edummytarget, ( -300, 200, 50 ) );
		self fireturret(); 
		wait 10;
		self setTurretTargetent(edummytarget, ( 0, 200, 50 ) );
		self fireturret(); 
		wait 10;
		self setTurretTargetent(edummytarget, ( -300, 200, 50 ) );
		self fireturret(); 
		wait 10;
}

sherman_attack_house3()// not used
{
		edummytarget = getent("event7_tankshoot1", "targetname");
		wait 30;
		self setTurretTargetent(edummytarget, ( 0, 0, 50 ) );
		self fireturret(); 
		wait 10;
		self setTurretTargetent(edummytarget, ( 300, 0, 50 ) );
		self fireturret(); 
		wait 10;
		self setTurretTargetent(edummytarget, ( -300, 0, 50 ) );
		self fireturret(); 
		wait 10;
}


sherman_attack_hills() // not called you can remove this function
{
	edummytargets = getentarray("sherman_target_" + num,"targetname");

	target[1] = (1672,2952,16);
	target[2] = (2472,2928,-16);
	target[3] = (2880,2520,-36);
	target[4] = (2472,2928,-16);

//	edummytargets = getentarray("sherman_target_" ,"targetname");
	for(i=0;i<edummytargets.size;i++)
	{
		edummytargets[i] thread mortars();

		println("Tank is firing at: TARGET",num);
		tank setTurretTargetVec(target[num]);
		tank waittill("turret_on_target");
		wait (2 + randomfloat(1));
		tank FireTurret();
		wait (1 + randomfloat(2));
	}

// mikes random shit

	for(i=0;i<7;i++)
	{
		num = (randomint(5) + 1);
		if(i == 0)
		{
			num = 1;
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
// mikes random shit
}

event7a_end()	// when tank gets to his end node...
{
	println("^3 event7a_end");
	println(" ^4 *********************TANK 3 script wait tell tank3 reaches last node ");
	println(" ^4 *********************TANK 3 script wait tell tank3 reaches last node ");
	println(" ^4 *********************TANK 3 script wait tell tank3 reaches last node ");	
	self waittill("reached_wait_node");
	
	println(" ^6 *********************TANK 3 has reached it's end node!!! ");
	println(" ^6 *********************TANK 3 has reached it's end node!!! ");
	println(" ^6 *********************TANK 3 has reached it's end node!!! ");
	wait 3;


// jeremy latest change with new stuff...!!!!! important to make event work the old way!!! COCK
//	level.flag ["sheman_made_it_into_town"] = true; // use when you don't want other vo to over lap..
//	level thread shermans_made_it();//	testing alt ending for player who does not kill enough in certain time











//	level thread shermans_made_it_part2();

	// get down here soldiers and group up with tanks
//	iprintlnbold(&"GMI_FOY_TANKS");

	// this continues the moody thread after defending the tanks
	// need to shut off spawners

}



shermans_made_it() // last shit for foy...
{
	wait 2;
	while(1)
	{
//		println("  level.num  :     ", level.num_of_respawns);
		if(level.flag ["sheman_made_it_into_town"] && level.flag["objective10_tracker_complete"])
		{
	//		level waittill("objective_10_complete");
			level thread axis_do_damage();
			// check panzer and tanks... only if both are true does the action stop
			level notify("objective_10_complete");	
			maps\_spawner_gmi::kill_spawnerNum(5);
			level.flag["shermans_attack_drone"] = false;
			level notify("Shermans_safe_in_town");
	
			if(isalive(level.esupport_ai))
			{
				level.esupport_ai.dontavoidplayer = 0;
			}
			break;
		}

		else if(!level.flag ["objective10_tracker_complete"]) // for not being completed yet.)
		{
			setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_FOY_KILL_SHREKS"); // SHREKS
			objective_state(10, "failed");
//			wait 3;
			missionfailed();
			break;
		}	
		wait 0.05;
	}
}

shermans_made_it_part2() // new timing issue to solve player not killing enemies during the event!
{	
		wait 6;
		if(level.flag ["sheman_made_it_into_town"] == true && 	level.num_of_respawns <= 0)
		{
	//		level waittill("objective_10_complete");
			level thread axis_do_damage();
			// check panzer and tanks... only if both are true does the action stop
			level notify("objective_10_complete");	
			maps\_spawner_gmi::kill_spawnerNum(5);
			level.flag["shermans_attack_drone"] = false;
			level notify("Shermans_safe_in_town");
	
			if(isalive(level.esupport_ai))
			{
				level.esupport_ai.dontavoidplayer = 0;
			}
		}

		if(level.num_of_respawns >= 1)
		{
//			objective_string(10, &"GMI_BASTOGNE2_FAIL_MOODY");
			setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_FOY_KILL_SHREKS"); // SHREKS
			objective_state(10, "failed");
			wait 3;
			missionfailed();
		}
}

event8a_shermans()
{
//	level thread event7a_flood_spawner_setup();


	eTank1 = getent("sherman_1","targetname");

	etank1.health = 1000;

	eTank1StartNode = getVehicleNode("event8_node1","targetname");
	eTank1 attachPath(eTank1StartNode);
	println(" tank1 should start event8 now: ", etank1.targetname, etank1.origin);
	wait 15;
	etank1 startPath();

	eTank2 = getent("sherman_2","targetname");
	etank2.health = 10;


//	etank1 addVehicleToCompass();
	eTank2StartNode = getVehicleNode("event8_node2","targetname");
	eTank2 attachPath(eTank2StartNode);
	println(" tank1 should start event8 now: ", etank1.targetname, etank1.origin);

	// sets up commander
//	eofficer2 = getent("officer2", "targetname" );
//	dofficer2 = eofficer2 dospawn(); // Spawns the ACTUAL AI. And sets the Spawned to = the AI.

//	eofficer2 linkto(etank2, "tag_detach", (0, 0, -50), (0, 100, 0) );
	// end commander
	wait 25;

	etank2 startPath();

	eTank3 = getent("sherman_3","targetname");
	etank3.health = 10;


//	etank1 addVehicleToCompass();
	eTank3StartNode = getVehicleNode("event8_node3","targetname");
	eTank3 attachPath(eTank3StartNode);
	println(" tank1 should start event8 now: ", etank1.targetname, etank1.origin);

	// sets up commander
//	eofficer = commander3 dospawn(); // Spawns the ACTUAL AI. And sets the Spawned to = the AI.
//	eofficer3 = getent("officer3", "targetname" );

//	eofficer3 linkto(etank3, "tag_detach", (0, 0, -50), (0, 100, 0) );
	// end commander

	wait 5;
	etank3 startPath();


	// end setup tanks on paths

	etank1 waittill("reached_end_node");
	wait 2;
//	level.eTiger2 thread tank_tiger_control2();
//	level.eTiger2 thread tiger2_fire_think();
//	level.eTiger2 thread tiger2_death();
	

	println("^3 OK hidden tiger should attack this tank now blowing it up!!!");
}

#using_animtree( "panzerIV" );
tank_tiger_control2()
{
		esherman_1 = getent("sherman_1", "targetname");
		esherman_1.health = 1;
		wait 1;
// need to test health of the sherman, although it gets set to 0 it still does not blow up...
		println("^6   health of sherman is set to  : ",  esherman_1.health);
		self setTurretTargetEnt(esherman_1, (0, 0, 104) );	
		self waittill("turret_on_target");
		self fireturret();
		self setAnimKnobRestart( %PanzerIV_fire );
		wait 1;
		self fireturret();
		wait 3;
		self fireturret();
}

tiger2_fire_think()
{
	level waittill ("tiger2_attack_player");
	self endon("death");
	println("^3 *********** not waiting for player to hit trigger***************");
//	level waittill("player_on_bridge");
	target[1] = (404, 4427, 113);
	self setTurretTargetVec(target[1]);

	while(isalive(self))
	{
		while(level.flag ["tiger2_attack_player_flag"] == true)
	//	while(isalive(self) && level.flag ["tiger2_attack_player_flag"] == true)
		{
			self setTurretTargetEnt(level.player, (0, 0, 20) );											
			self thread maps\_tiger_gmi::fire();		
			//self waittill("turret_on_target");
			//self fireturret();
			wait 3.4 + randomfloat(10);	
		}
		wait 0.1;
		if(isalive(self))
		{
			self clearTurretTarget();
		}
	}
}

// used for tiger2
tiger2_death()
{
	println("^3 ********* tiger two waiting for death:  ",  self.targetname);
	self waittill("death");
	self.isalive = 0;
//	self maps\_tankgun_gmi::mgoff();
	level.flag["shermans_attack_across_bridge"] = false;
	println("^3 ********* tiger two dead:  ",  self.targetname);
	level notify("objective_12_complete");
	level thread moody_regroup_lines();

	ai = getaiarray ("axis");
	for (i=0;i<ai.size;i++)
	{
		ai[i] DoDamage ( ai[i].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
	}	
}

moody_regroup_lines()
{
		wait 3;
		level.moody thread anim_single_solo(level.moody,"moody_ev09_02");

		wait 8;
		level notify ("flyby go end");
} 

lookat (ent, timer)
{
	if (!isdefined (timer))
		timer = 10000;
		
	self animscripts\shared::lookatentity(ent, timer, "alert");
}  

 
house_fire()
{
	// turn off effect at barrel
	level notify("barrel_effect_off");

	// possible bugs... ai getting killed in fire maybe to much
		// solution one set timing of fire to be one more room behind the player...
	// setup trigger hurts

//	elamp1 = getent("lamp1", "targetname");

//	if(!isdefined(elamp1))
//	{
//		println(" ^3 *************  error");
//	}

	etrigger_hurt_array =[];// this defines it as an array
	etrigger_hurt_group = getentarray("fire_pain", "groupname");

	for(b=1;b<(etrigger_hurt_group.size+1);b++)//	thad addon	
	{

		etrigger_hurt_array[b] = getent("trigger_fire_hurt_" + b, "targetname");
		etrigger_hurt_array[b] maps\_utility_gmi::triggeroff();
	}



	trigger = getent("start_fire", "targetname");
	trigger waittill("trigger");


	// RICH anderson new line anderson_joint_on_fire
	level notify("start_table_anim");

//	wait 0.25;
	level waittill("fire_continue");

//	elamp1 hide();

	trigger_fire = getentarray("increase_fire_trigger", "targetname");

	for(i=0;i<trigger_fire.size;i++)
	{
		trigger_fire[i] thread house_fire_trigger();
	}

	ehouse_fire_ent = getent ("house_fire_ent", "targetname");

//	playfx(level._effect["bell_tower_exp"], ehouse_fire_ent.origin);

//	playfx(level._effect["lamp_fall"], ehouse_fire_ent.origin);
	wait 2;
	level thread house_fire01();

	println("^3 fire pain test", etrigger_hurt_array[1].targetname);
	etrigger_hurt_array[1] maps\_utility_gmi::triggeron();

//		      loopfx(fxId, fxPos, waittime, fxPos2, fxStart, fxStop, timeout, low_fxId, lod_dist)
	maps\_fx_gmi::loopfx("bldgfire_stage1a", (ehouse_fire_ent.origin), .3, undefined, undefined, "bldgfire_stage1a");
	level waittill("increase_fire");
	level notify ("bldgfire_stage1a");
	println("^3 fire pain test", etrigger_hurt_array[2].targetname);
	etrigger_hurt_array[2] maps\_utility_gmi::triggeron();

//	maps\_fx_gmi::loopfx("bldgfire_stage1a", (ehouse_fire_ent.origin), .3, undefined, undefined, "bldgfire_stage1a",fxStop);
	maps\_fx_gmi::loopfx("bldgfire_stage1b", (ehouse_fire_ent.origin), .3, undefined, undefined, "bldgfire_stage1b");
	level thread house_fire02();
	level waittill("increase_fire");
	level notify ("bldgfire_stage1b");

	level thread anderson_fire_talk();


	println("^3 fire pain test", etrigger_hurt_array[3].targetname);
	etrigger_hurt_array[3] maps\_utility_gmi::triggeron();

//	maps\_fx_gmi::loopfx("bldgfire_stage1b", (ehouse_fire_ent.origin), .3, undefined, undefined, "bldgfire_stage1b",fxStop);
	maps\_fx_gmi::loopfx("bldgfire_stage1c", (ehouse_fire_ent.origin), .3, undefined, undefined, "bldgfire_stage1c");
	level thread house_fire03();
	level waittill("increase_fire");
	level notify ("bldgfire_stage1c");



	println("^3 fire pain test", etrigger_hurt_array[4].targetname);
	etrigger_hurt_array[4] maps\_utility_gmi::triggeron();


	println("^6**************** house swap1", level.eburnhouse_d1.targetname);
//	maps\_fx_gmi::loopfx("bldgfire_stage1c", (ehouse_fire_ent.origin), .3, undefined, undefined, "bldgfire_stage1c",fxStop);
	maps\_fx_gmi::loopfx("bldgfire_stage1d", (ehouse_fire_ent.origin), .3, undefined, undefined, "bldgfire_stage1d");
	level thread house_fire04();
	level waittill("increase_fire");
	level notify ("bldgfire_stage1d");
//	println("^6**************** house swap1"); 
	level.eburnhouse hide();
	level.eburnhouse_d1 show();


	println("^6**************** house swap2", level.eburnhouse_d2.targetname);
//	maps\_fx_gmi::loopfx("bldgfire_stage1d", (ehouse_fire_ent.origin), .3, undefined, undefined, "bldgfire_stage1d",fxStop);
	maps\_fx_gmi::loopfx("bldgfire_stage2", (ehouse_fire_ent.origin), .6, undefined, undefined, "bldgfire_stage2");
	level thread house_fire05();
	level waittill("increase_fire");
	level notify ("bldgfire_stage2");
	level.eburnhouse_d1 hide();
	level.eburnhouse_d2 show();


	println("^6**************** house swap3", level.eburnhouse_d3.targetname);
//	maps\_fx_gmi::loopfx("bldgfire_stage2", (ehouse_fire_ent.origin), .6, undefined, undefined, "bldgfire_stage2",fxStop);
	maps\_fx_gmi::loopfx("bldgfire_stage3", (ehouse_fire_ent.origin), .6, undefined, undefined, "bldgfire_stage3");
//	level thread house_fire05();
	level waittill("increase_fire");
	level notify ("bldgfire_stage3");
	level.eburnhouse_d2 hide();
	level.eburnhouse_d3 show();

	level notify ("house_fire06");
//	maps\_fx_gmi::loopfx("bldgfire_stage3", (ehouse_fire_ent.origin), .6, undefined, undefined, "bldgfire_stage3",fxStop);
	maps\_fx_gmi::loopfx("bldgfire_stage4", (ehouse_fire_ent.origin), 1, undefined, undefined, "bldgfire_stage4");


//	useBy(entity activator);
//	Makes the entity be used (aka. triggered) by the entity passed in as the activtor.


//	eburnhouse = getent("burnhouse", "targetname");
//	eburnhouse hide();

//	eburnhouse_d1 = getent("burnhouse_d2", "targetname");
//	eburnhouse_d1 hide();

//	eburnhouse_d2 = getent("burnhouse_d3", "targetname");
//	eburnhouse_d2 hide();

}     

anderson_fire_talk()
{
	level.Anderson thread anim_single_solo(level.Anderson, "Anderson_joint_on_fire");
	println("^4 ************ Anderson_joint_on_fire ************");     
}                       

house_fire_trigger()
{
	self waittill("trigger");
	level notify("increase_fire");	
} 

// -------------------begin house fire functions

house_fire01()
{
	println("^3 ******************housefire 1 - lantern falls");
	org = getent ("house_fire01_high","targetname");
	blend = spawn( "sound_blend", ( 0.0, 0.0, 0.0 ) );
//	println("Blend origin : ",blend.origin);

// Must force the origin, since spawning in @ origin doesn't seem to take
	blend.origin = (-1609, -419, 60);


	for (i=0;i<1;i+=0.01)
	{
		blend setSoundBlend( "housefire01_low", "housefire01_high", i );
		wait (0.02);
	}
}

house_fire02()
{
	println("housefire 2 - first room covered");
	org = getent ("house_fire01_high","targetname");
	blend = spawn( "sound_blend", ( 0.0, 0.0, 0.0 ) );
//	println("Blend origin : ",blend.origin);

// Must force the origin, since spawning in @ origin doesn't seem to take
	blend.origin = (-1729, -419, 60);


	for (i=0;i<1;i+=0.01)
	{
		blend setSoundBlend( "housefire02_low", "housefire02_high", i );
		wait (0.02);
	}
}

house_fire03()
{
	println("housefire 3 - spreads to second room");
	org = getent ("house_fire01_high","targetname");
	blend = spawn( "sound_blend", ( 0.0, 0.0, 0.0 ) );
//	println("Blend origin : ",blend.origin);

// Must force the origin, since spawning in @ origin doesn't seem to take
	blend.origin = (-1675, -76, 60);


	for (i=0;i<1;i+=0.01)
	{
		blend setSoundBlend( "housefire03_low", "housefire03_high", i );
		wait (0.02);
	}
}

house_fire04()
{
	println("housefire 4 - entire first floor");
	org = getent ("house_fire01_high","targetname");
	blend = spawn( "sound_blend", ( 0.0, 0.0, 0.0 ) );
//	println("Blend origin : ",blend.origin);

// Must force the origin, since spawning in @ origin doesn't seem to take
	blend.origin = (-1448, -123, 60);


	for (i=0;i<1;i+=0.01)
	{
		blend setSoundBlend( "housefire04_low", "housefire04_high", i );
		wait (0.02);
	}
}

house_fire05()
{
	println("housefire 5 - house half comsumed");
	org = getent ("house_fire01_high","targetname");
	blend = spawn( "sound_blend", ( 0.0, 0.0, 0.0 ) );
//	println("Blend origin : ",blend.origin);

// Must force the origin, since spawning in @ origin doesn't seem to take
	blend.origin = (-1570, -95, 60);


	for (i=0;i<0.5;i+=0.01)
	{
		blend setSoundBlend( "housefire05_low", "housefire05_high", i );
		wait (0.04);
	}
	level waittill ("house_fire06");
	println("housefire 6 - house completely comsumed");
	collapse = spawn("script_origin", (-1570, -95, 60));
	collapse playsound("house_collapse");
	wait 0.5;
	for (i=0.5;i<1;i+=0.01)
	{
		blend setSoundBlend( "housefire05_low", "housefire05_high", i );
		wait (0.05);
	}
}

//----------------------------- end fire sound functions

practice_function()
{

	// for loop that goes through seven times and than coutns down five seconds nested

	levev.count = 0;
	for(i=0;i<7;i++)
	{

		for(n=0;n>5;n--)
		{
			wait 1;	
		}
	}
}


//moody_anim_trigger()
//{
//	trigger waittill ("trigger");
//	if (flag("blocker mg42s cleared"))
//		return;
//		
//	level endon ("blocker mg42s cleared");
//	
//	node = getnode (trigger.target,"targetname");
//	trigger delete();
//
//	moody = getent ("foley","targetname");
//	level thread foley_stopIdling(foley);
//	guy[0] = foley;
//
//	anim_reach (guy, "wave", undefined, node);
//	moody animscripts\shared::putguninhand("left");
//
//	while (1)
//	{
//		moody thread anim_loop ( guy, "idle", undefined, "stop idle", node);
//		
//		while (distance (level.player getorigin(), foley.origin) > 200)
//			wait (0.15);
//			
//		moody lookat(level.player, 2);
//		
//		moody notify ("stop idle");		
//		anim_single (guy, "wave", undefined, node);
//		moody thread anim_loop ( guy, "idle", undefined, "stop idle", node);
//		wait (0.35); // 1.5
//		
//		if (distance (level.player getorigin(), moody.origin) < 210)
//		{
//			moody notify ("stop idle");		
//			moody lookat(level.player, 2);
//			anim_single (guy, "flank mg42s", undefined, node);
//			moody thread anim_loop ( guy, "idle", undefined, "stop idle", node);
//		}
//
//		while (distance (level.player getorigin(), moody.origin) < 210)
//		{
//			if (randomint (20) == 0)
//				moody lookat(level.player, 2);
//			
//			wait (0.15);
//		}
//	
//		while (distance (level.player getorigin(), moody.origin) > 200)
//		{
//			if (randomint (20) == 0)
//				moody lookat(level.player, 2);
//			wait (0.15);
//		}
//
//		moody lookat(level.player, 3);
//		
//		moody notify ("stop idle");		
//		anim_single (guy, "check church", undefined, node);
//	}
//}

// MikeD:-----START :: DUMMIES Section ----------//
#using_animtree("foy_dummies_path");
dummies_opening()
{
	triggers = getentarray("flak1_2","targetname");

	for(i=0;i<triggers.size;i++)
	{
		if(isdefined(triggers[i].script_turret) && triggers[i].script_turret == 1)
		{
			trigger = triggers[i];
		}
	}

	wait 0.05;
//	trigger waittill("trigger");



	println("^5 ********OPENING DUMMIES GO!*******");

	anim_wait = [];
	anim_wait[0] = 16.667;
	anim_wait[01] = 17.966;
	anim_wait[02] = 17.2;
	anim_wait[03] = 18;
	anim_wait[04] = 18.2;
	anim_wait[05] = 18.766;
	anim_wait[06] = 23;
	anim_wait[07] = 20.5;
	anim_wait[08] = 20.7; 
	anim_wait[09] = 19.5; 
	anim_wait[10] = 19.733;
	anim_wait[11] = 20.667;
	anim_wait[12] = 20.9;
	anim_wait[13] = 21.1;
	anim_wait[14] = 22.5;
	anim_wait[15] = 22.7;
	anim_wait[16] = 23.8;
	anim_wait[17] = 22.7;
	anim_wait[18] = 23;

	level thread maps\foy_dummies::dummies_setup((-3040,-7956,200), "xmodel/foy_dummies_opening", 19, (0,0,0), 5, 3, %foy_dummies_opening, true, "allied_drone", anim_wait, true, "stop opening fire", 2);


	wait 15;

	level thread maps\foy_dummies::dummies_setup((-3040,-7956,200), "xmodel/foy_dummies_opening", 19, (0,0,0), 5, 3, %foy_dummies_opening, true, "allied_drone", anim_wait, true, "stop opening fire", 2);

	level thread maps\foy_dummies::fake_bullet_tracers("opening", undefined, "stop opening fire", 12);
}

#using_animtree("foy_dummies_path");
dummies_haystack()
{
	println("^5 ********HAYSTACK DUMMIES GO!*******");

	anim_wait = [];
	anim_wait[0] = 17;
	anim_wait[1] = 17;
	anim_wait[2] = 18;
	anim_wait[3] = 18;
	anim_wait[4] = 17;
	anim_wait[5] = 17;
	anim_wait[6] = 17;
	anim_wait[7] = 17;

	level thread maps\foy_dummies::dummies_setup((3008, -7616, 31), "xmodel/foy_dummies_haystack", 8, (0,0,0), undefined, undefined, %foy_dummies_haystack, true, "allied_drone", anim_wait, true, undefined, 2);
}

#using_animtree("foy_dummies_path");
dummies_easthill()
{
	println("^5 ********EASTHILL DUMMIES GO!*******");

	anim_wait = [];
	anim_wait[0] = 47;
	anim_wait[1] = 48;
	anim_wait[2] = 50;
	anim_wait[3] = 56;
	anim_wait[4] = 42;
	anim_wait[5] = 44;
	anim_wait[6] = 47;
	anim_wait[7] = 50;
	anim_wait[8] = 53;
	anim_wait[9] = 42;
	anim_wait[10] = 45;
	anim_wait[11] = 48;
	anim_wait[12] = 52;
	anim_wait[13] = 40;
	anim_wait[14] = 43;
	anim_wait[15] = 46;
	anim_wait[16] = 49;
                          
	level thread maps\foy_dummies::dummies_setup((3008, -7616, 31), "xmodel/foy_dummies_easthill", 17, (0,0,0), 5, 3, %foy_dummies_easthill, true, "allied_drone", anim_wait, true, undefined, 2);
}

#using_animtree("foy_dummies_path");
dummies_westhill()
{
	println("^5 ********WESTHILL DUMMIES GO!*******");

	anim_wait = [];
	anim_wait[0] = 29;
	anim_wait[1] = 29;
	anim_wait[2] = 30;
	anim_wait[3] = 33;
	anim_wait[4] = 32;
	anim_wait[5] = 24;
	anim_wait[6] = 24;
	anim_wait[7] = 25;
	anim_wait[8] = 24;
	anim_wait[9] = 26;
	anim_wait[10] = 26;
	anim_wait[11] = 27;
	anim_wait[12] = 27;
	anim_wait[13] = 30;
	anim_wait[14] = 30;
	anim_wait[15] = 30;
	anim_wait[16] = 31;
	anim_wait[17] = 32;
// dummies_setup(pos, model, total_tags, angle_offset, loop_time, loop_num, path_anim, weap, anim_name, anim_wait, random_move_forward, gun_fire_notify, mortar_amount);
	level thread maps\foy_dummies::dummies_setup((-5016, -3872, 117), "xmodel/foy_dummies_westhill", 9, (0,0,0), 5, 2, %foy_dummies_westhill, true, "allied_drone", anim_wait, true, undefined, 0, true);
}

#using_animtree("foy_dummies_path");
dummies_lasthill()
{

	wait 5;

	println("^5 ********LASTHILL DUMMIES GO!*******");

	anim_wait = [];
	anim_wait[0] = 27;
	anim_wait[1] = 27;
	anim_wait[2] = 28;
	anim_wait[3] = 28;
	anim_wait[4] = 28;
	anim_wait[5] = 28;
	anim_wait[6] = 28;
	anim_wait[7] = 29;
	anim_wait[8] = 29;
	anim_wait[9] = 30;
	anim_wait[10] = 30; 
	anim_wait[11] = 31;
	anim_wait[12] = 27; 
	anim_wait[13] = 27;
	anim_wait[14] = 28;
	anim_wait[15] = 28; 
	anim_wait[16] = 29;
	anim_wait[17] = 29;
	anim_wait[18] = 28;
	anim_wait[19] = 29;
	anim_wait[20] = 29;
	anim_wait[21] = 30;
	anim_wait[22] = 31;
												    //23				
//					dummies_setup(pos, model, total_tags, angle_offset, loop_time, loop_num, path_anim, weap, anim_name, anim_wait, random_move_forward, gun_fire_notify, mortar_amount, no_random_wait)
	level thread maps\foy_dummies::dummies_setup((2496, 832, 6), "xmodel/foy_dummies_lasthill", 10, (0,0,0), 2, 1, %foy_dummies_lasthill, true, "axis_drone", anim_wait, true, undefined, 0);
}

// MikeD:-----END :: DUMMIES Section ----------//

// MikeD:-----START :: Sherman Section ----------//
// Sherman Setup, and starts them moving.
sherman_setup()
{
	trigger = getent("blow_haystack1","targetname");
	trigger waittill("trigger");
//	level thread dummies_opening();

//anim/sound begin

//	anim_single (guy, anime, tag, node, tag_entity)	
	//Ready 1 2 3 go go go 
	level thread sprint_hint();
	level.moody thread anim_single_solo(level.moody,"go_go_go");
	wait 3;
//anim/sound end	

	sherman_tanks = getentarray("shermans","groupname");
	// Setups up each tank. 4, cause we know there are only 4 sherman tanks.
	for(i=0;i<6;i++)
	{
		sherman_tanks[i].isalive = 1;
		sherman_tanks[i].health = 50000;
		println("^6 ************* jeremy look here  health :", sherman_tanks[i].health, sherman_tanks[i].targetname);
		// Default = 400, forward radius to see if the tank needs to avoid another tank.
		sherman_tanks[i].coneradius = 100;

		sherman_tanks[i] thread maps\_sherman_gmi::init();
		sherman_tanks[i] thread maps\_tankgun_gmi::mgoff(); // Turn OFF MG.
		println("^5Sherman name: ",sherman_tanks[i].targetname);
		startnode = getvehiclenode(sherman_tanks[i].targetname + "_start","targetname");

		sherman_tanks[i] thread kill_shermans_with_sniper(); // new thread just put in

		// Used for sherman_think()
		sherman_tanks[i].attachedpath = startnode;

		sherman_tanks[i] thread sherman_think();
		sherman_tanks[i] thread maps\_treads_gmi::main();
		sherman_tanks[i] thread first_shermans_fake_attack(); // test
		sherman_tanks[i] thread shermans_attack_down_street_before_bell_tower(); // more ambient overkill once again!
		sherman_tanks[i] thread sherman1_and_2_health_regen();

		sherman_tanks[i] thread sherman_2_drive_bell_setup(); // COCK this is new and places the sherman2 in street for blow up tower event.

		sherman_tanks[i] attachpath(startnode);
		sherman_tanks[i] startpath();
	}
}

sherman1_and_2_health_regen()
{
//	if(self.targetname == "sherman_1")
//	{
//		self thread friendly_damage_penalty();	
//	}
//	else if(self.targetname == "sherman_2")
//	{
//		self thread friendly_damage_penalty();
//	}

//	self endon ("death");
//	while(level.flag ["shermans_attack1"] == true)
	while(level.flag ["shermans_god"] == true)
	{
		if(self.targetname == "sherman_1")
		{
			self.health = 50000;
		}
		else if(self.targetname == "sherman_2")
		{
			self.health = 50000;
		}
		wait 0.01;
	}
}


// Goes through all of the vehicle nodes that he will travel, put them in order from start
// to finish, and check to see if they have a script_noteworthy. To do a special thing.
// Right now, it's just waiting. But we can have start_firing or stop_firing, or whatever/
sherman_think()
{
	self endon("no_longer_needed");
	self endon("death");

	if(!isdefined(self.attachedpath))
	{
		println("^1NO '.ATTACHEDPATH' FOUND FOR TANK, ",self.targetname);
		println("^1NO '.ATTACHEDPATH' FOUND FOR TANK, ",self.targetname);
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

	// Checks to see if there is a script_noteworthy on each node for the tank.
	for(i=0;i<pathpoints.size;i++)
	{
		if(isdefined(pathpoints[i].script_noteworthy))
		{
			self setWaitNode(pathpoints[i]);
			self waittill ("reached_wait_node");

			if(pathpoints[i].script_noteworthy == "waitnode")
			{
				self setspeed (0, 10000);
				println(self.targetname," ^5Reached WAIT Node");
				level waittill("sherman tanks go"); // If you put in the while, take this out.
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
				self resumespeed (10000);
			}

			else if(pathpoints[i].script_noteworthy == "waitnode_attack_bell_tower")
			{
				
				target[1] = (-568, 9368, 185);
				self setTurretTargetVec(target[1]);
				self setspeed (0, 10000);
				println(self.targetname," ^6 Reached KILL wait node");
				//self thread sherman_attack_bell_tower(); // blows bell towers...
//				wait 3;
				println(self.targetname," ^6 Reached bell tower wait");
//				wait 4;
				level waittill("blow_bell_tower");
				level notify("no_longer_needed"); // calls back into the funciton ending
//				wait 3;
				println("^6 *************** first set of shermans no longer needed");	
//				level thread kill_first_shermans();
//				wait 5;
//				level thread event7a_shermans(); // jeremy now
				// make sure you set it up so this gets called from bell tower event now...
			}
		}
	}
}

// MikeD:-----END :: Sherman Section ----------//


kill_first_shermans()
{
	wait 5;
	sherman_tanks = getentarray("shermans","groupname");
	for(i=0;i<4;i++)
	{
		sherman_tanks[i] delete();
	}	
}

first_shermans_fake_attack()	// setup battle 
{
//	level endon("stop_tank_Attack"); // need to still setup
//	level waittill("tank_attack_town"); // done
	self endon ("death");
	println("^6 **************************shermans attack now !!!");
	println("^6 **************************shermans attack now !!!");
	println("^6 **************************shermans attack now !!!");
	println("^6 **************************shermans attack now !!!");
	wait 6;
	while(level.flag ["shermans_attack1"] == true)
	{
		if(self.targetname == "sherman_1")
		{
			target_pos[0] = (760, -2720, 228);
			target_pos[1] = (1656, -1672, 228);
			target_pos[2] = (1360, -2360, 228);
			target_pos[3] = (440, -3144, 228);
			target_pos[4] = (2408, -1256, 228);
			target_pos[5] = (-7104, 576, 236);
			target_pos[6] = (-8360, 344, 264);
			target_pos[7] = (-6944, 736, 236);
		}
		else if(self.targetname == "sherman_2")
		{
			target_pos[0] = (760, -2720, 228);
			target_pos[1] = (1656, -1672, 228);
			target_pos[2] = (1360, -2360, 228);
			target_pos[3] = (440, -3144, 228);
			target_pos[4] = (2408, -1256, 228);
			target_pos[4] = (-8648, 552, 244);
			target_pos[5] = (-8042, -282, 202);
		}
		else
		{
			target_pos[0] = (760, -2720, 228);
			target_pos[1] = (1656, -1672, 228);
			target_pos[2] = (1360, -2360, 228);
			target_pos[3] = (440, -3144, 228);
			target_pos[4] = (2408, -1256, 228);
			target_pos[5] = (-8927, -112, 206);
			target_pos[6] = (-9103, 320, 224);
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

		wait (3 + randomfloat(13));
	}


	target_pos[0] = (56, -1056, 183);
	self setTurretTargetVec(target_pos[0]);
}

shermans_attack_down_street_before_bell_tower()	// setup battle 
{
	println("^3 ******************* sherman one and two waiting for notify so they can attack down the street before the bell tower explodes**");
	level waittill ("ambient sherman before bell tower"); // this is really not needed...
	wait 15;
//	target_pos[0] = (938, 298, 300);
	target_pos[0] = (1000, 688, 300);
	if(self.targetname == "sherman_1")
	{
		for(i=0;i<5;i++)
		{
			println("^3 ******************* sherman one ambient fire now**");
			self setTurretTargetVec(target_pos[0]);
			self waittill("turret_on_target");
			wait (4 + randomfloat (3));
			self FireTurret();
		}
//		self thread sherman_attack_bell_tower(); // blows bell towers...
	}
	else if(self.targetname == "sherman_2")
	{
		wait 7;
		for(i=0;i<5;i++)
		{
			println("^3 ******************* sherman two ambient fire now**");
			self setTurretTargetVec(target_pos[0]);
			self waittill("turret_on_target");
			wait (6 + randomfloat (3));
			self FireTurret();
		}

		self thread sherman_attack_bell_tower(); // blows bell towers...
	}
//	else
//	{
//		self setTurretTargetVec(118, 43, 205);
//	}
}

sherman_blow_house_down_street()	// this has sherman1 attack down the street and blow up the house.
{
	target_pos[0] = (84, 432, 183);
	if(self.targetname == "sherman_2")
	{
		self setTurretTargetVec(target_pos[0]);
		self waittill("turret_on_target");
		wait 3;
		self FireTurret();
		self waittill("turret_on_target");
		wait 3;
		self FireTurret();
	}
}

shermans_attack_drones()	// setup battle 
{
	wait 10;
//	level waittill("tanks_attack_drones_now");
	self endon ("death");


	while(level.flag ["shermans_attack_drone"] == true)
	{
		if(self.targetname == "sherman_1")
		{
//			target_pos[0] = (1201, 1929, 188);
//			target_pos[1] = (1201, 1929, 188);
//			target_pos[2] = (1551, 2076, 168);
		}
		else if(self.targetname == "sherman_2")
		{
			target_pos[0] = (1201, 1929, 188);
			target_pos[1] = (1201, 1929, 188);
			target_pos[2] = (1551, 2076, 168);
		}
		else
		{
			target_pos[0] = (1201, 1929, 188);
			target_pos[1] = (1201, 1929, 188);
			target_pos[2] = (1551, 2076, 168);
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

		wait (3 + randomfloat(13));
	}

}

shermans_attack_across_bridge()	// setup battle 
{
	level waittill("attack_bridge_now");

	while(level.flag ["shermans_attack_across_bridge"] == true)
	{
		if(self.targetname == "sherman_2")
		{
			target_pos[0] = (-795, 5950, -19);
			target_pos[1] = (-12, 5855, 100);
			target_pos[2] = (-572, 7074, 370);

		}
		else if(self.targetname == "sherman_3")
		{
			target_pos[0] = (-795, 5950, -19);
			target_pos[1] = (-12, 5855, 100);
			target_pos[2] = (-572, 7074, 370);
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

		wait (5 + randomfloat(13));
	}

}

kill_shermans_with_sniper()
{
	level waittill("blow_sherman_5");
	
	sherman_tanks = getentarray("shermans","groupname");
	for(i=0;i<6;i++)
	{
		if(self.targetname == "sherman_5")
		{
			self.health = 1;
			wait 0.05;
			pop1 = getent("sherman_5", "targetname");
			pop1 instant_mortar();			
		}

		level waittill("moody_done_talking");

		if(self.targetname == "sherman_6")
		{
			self.health = 1;
			wait 0.05;
			pop1 = getent("sherman_6", "targetname");
			pop1 instant_mortar();	
		}
	}	
}

// runs through all threads for shermans from beggining
sherman_beg_test()
{
	println("^6 ********** shermsn go @!!!!");
	level notify("sherman tanks go");
	wait 60;
	level notify("sherman tanks go");
	wait 60;
	level notify("sherman tanks go");
	wait 60;
	level notify("sherman tanks go");
	wait 60;
	level notify("sherman tanks go");
	wait 60;
	level notify("sherman tanks go");
	wait 60;	
}

sherman_connect_test()
{
	
//	sherman_1 = getent

	eshermans_array =[];// this defines it as an array
	eshermans_group = getentarray("shermans", "groupname");
	println("^6**************** event7a group and array setup!");

	for(i=1;i<(eshermans_group.size+1);i++)//	thad addon	
	{
		println("^6**************** event7a made it into for loop!");		
		eshermans_array[i] = getent("sherman_" + i, "targetname");
//		println("^3********** name of sherman
		
		println("^3", eshermans_array[i], eshermans_array[i].targetname);	
//		return;		

		if(eshermans_array[i].targetname == "sherman_1")
		{
			eshermans_array[i] thread draw_health();
			eshermans_array[i] thread sherman_1_drive_town();
			eshermans_array[i].health = 10; 
		 	eshermans_array[i] thread maps\_treads_gmi::main();
			println("^3************** SHERMAN_1 GOT HIS INFO", eshermans_array[i].health, eshermans_array[i].targetname);
//			println("^3****************** array setup for shermans four");
//			println("^3************** SHERMAN_1 GOT HIS INFO", eshermans_array[i].health, eshermans_array[i].targetname);
//			eshermans_array[i].health = 1000;
//			eTank1StartNode = getVehicleNode("startnode1_tank1_town1","targetname");
//			//eshermans_array[i] attachPath(eTank1StartNode);
//			//eshermans_array[i] startPath();
//			eshermans_array[i].isalive = 1;
//			eshermans_array[i] thread sherman_1_drive_town();
		}

		else if(eshermans_array[i].targetname == "sherman_2")
		{
//			wait 0.25;
//			println("^3************** SHERMAN_2 GOT HIS INFO", eshermans_array[i].health, eshermans_array[i].targetname);
			eshermans_array[i].health = 30;
			eshermans_array[i].isalive = 1;	
			eshermans_array[i] thread sherman_2_drive_town();
		 	eshermans_array[i] thread maps\_treads_gmi::main();	
		}

		else if(eshermans_array[i].targetname == "sherman_3")
		{
//			wait 0.25;
//			println("^3************** SHERMAN_3 GOT HIS INFO", eshermans_array[i].health, eshermans_array[i].targetname);
			eshermans_array[i].health = 30;
			eshermans_array[i].isalive = 1;
		 	eshermans_array[i] thread maps\_treads_gmi::main();
//			println("^2 tank 3 should be heading towards to last node for event7");
			eshermans_array[i] thread sherman_3_drive_town();
		}

		eshermans_array[i] maps\_sherman_gmi::init();
	}
}

mortar_hit_explosion ( vec )
{
	playfx ( level._effect["mortar"], vec );
	thread playSoundinSpace ("mortar_explosion", vec);
	earthquake(0.3, 3, vec, 850); // scale duration source radius
	do_mortar_deaths (getaiarray(), vec);
	radiusDamage (vec, 300, 300, 0);
}

playSoundinSpace (alias, origin)
{
	org = spawn ("script_origin",(0,0,1));
	org.origin = origin;
	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}

#using_animtree("generic_human");
do_mortar_deaths (ai, org)
{
	for (i=0;i<ai.size;i++)
	{
		if (isdefined (ai[i].magic_bullet_shield))
			continue;

		dist = distance (ai[i].origin, org);
		if (dist < 190)
		{
			ai[i].allowDeath = true;
			ai[i].deathAnim = ai[i] getExplodeDeath("generic", org, dist);
			ai[i] DoDamage ( ai[i].health + 50, (0,0,0) );
			println ("Killing an AI");
			continue;
		}

//		if (isdefined (ai[i].getting_up))
//			continue;

//		if (dist < 300)
//			ai[i] thread getup(ai[i] getKnockDown(org), org);
	}
}

getExplodeDeath(msg, org, dist)
{
	if (isdefined (org))
	{
		if (dist < 50)
			return level.scr_anim[msg]["explode death up"];

		ang = vectornormalize ( self.origin - org );
		ang = vectorToAngles (ang);
		ang = ang[1];
		ang -= self.angles[1];
		if (ang <= -180)
			ang += 360;
		else
		if (ang > 180)
			ang -= 360;

		if ((ang >= 45) && (ang <= 135))
			return level.scr_anim[msg]["explode death forward"];
		if ((ang >= -135) && (ang <= -45))
			return level.scr_anim[msg]["explode death back"];
		if ((ang <= 45) && (ang >= -45))
			return level.scr_anim[msg]["explode death right"];

		return level.scr_anim[msg]["explode death left"];
	}

	randdeath = randomint(5);
	if (randdeath == 0)
		return level.scr_anim[msg]["explode death up"];
	else
	if (randdeath == 1)
		return level.scr_anim[msg]["explode death back"];
	else
	if (randdeath == 2)
		return level.scr_anim[msg]["explode death forward"];
	else
	if (randdeath == 3)
		return level.scr_anim[msg]["explode death left"];

	return level.scr_anim[msg]["explode death right"];
}

// Animation Calls -- brought over from Trenches
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
	maps\_anim_gmi::anim_reach (newguy, anime, tag, node, tag_entity);
}

anim_reach_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_reach (newguy, anime, tag, node, tag_entity);
}

#using_animtree("generic_human");
makeAICrouch ( trigger )
{
	wait 2;
	println("^3 *********************   croucher1");
	ai = getaiarray ("allies");
	crouchers = [];
	for (i=0;i<ai.size;i++)
	{
	println("^3 *********************   makeAICrouch trigger fired");
	println("^3 *********************   makeAICrouch trigger fired");
	println("^3 *********************   makeAICrouch trigger fired");	


		if (isalive(ai[i]))
		{	
//		if (ai[i] istouching (trigger))
//		{
//			println("^3 *********************   The ai is touching the trigger and should crouch now ****************");
//			crouchers[crouchers.size] = ai[i];
			ai[i] thread croucherThink();
			wait 0.1 + randomfloat(0.3);
		}
	}

		
//	maps\_utility_gmi::array_thread( crouchers, ::croucherThink);
}

croucherThink ()
{
	println("^3 *********************   croucherthink thread fired *********************");
	println("^3 *********************   croucherthink thread fired *********************");
	println("^3 *********************   croucherthink thread fired *********************");
	self endon ("death");

	if (randomint(100) < 50)
	{
		crouch2hide = %grenadehide_crouch2left;
		hideloop =  %grenadehide_left;
		self.anim_grenadeCowerSide = "left";
	}
	else
	{
		crouch2hide = %grenadehide_crouch2right;
		hideloop =  %grenadehide_right;
		self.anim_grenadeCowerSide = "right";
	}
	
	if (self.anim_pose == "crouch")
		self setFlaggedAnimKnoballRestart("hideanim",crouch2hide, %body, 1, .1, 1);
	else
	if (self.anim_pose == "stand")
	{
		self setFlaggedAnimKnoballRestart("hideanim",crouch2hide, %body, 1, .4, 1);
		self.anim_pose = "crouch";
	}
	else
		return;
			
	self.anim_movement = "stop";
	
	animscripts\shared::DoNoteTracks("hideanim");
	self setAnimKnoballRestart(hideloop, %body, 1, .1, 1);
}


// used with guys that catch up
Catch_Up(guy)
{
	guy endon("death");
	
//	println("^5 ************ friendly support follows player now ********************", level.maxfriendlies.size);
	println("^5 ************ friendly support follows player now ********************");
	guy.targetname = ("friends");
	guy.groupname = ("friends");
	guy.health = 100;
	guy.goalradius = 32;
	guy setgoalentity (level.player);
}

Catch_Up3(guy)
{
	guy endon("death");
	
//	println("^5 ************ friendly support follows player now ********************", level.maxfriendlies.size);
	println("^5 ************ friendly support follows player across the bridge now... ********************");
	guy.targetname = ("friends_end");
	guy.groupname = ("friends");
	guy.followmin = 0; // Follow, how many paths nodes ahead of the player to be, until told to move up.
	guy.followmax = 5; // How many pathnodes to be ahead of the goal. // this was two	
	guy.health = 30;
	guy.goalradius = 32;
	guy setgoalentity (level.player);
}

Catch_Up_after_church(guy)
{
	guy endon("death");
	
//	println("^5 ************ friendly support follows player now ********************", level.maxfriendlies.size);
	println("^5 ************ friendly support follows player now ********************");
	guy.dontavoidplayer = 1;
	guy.grenadeawareness = 0;
	guy.groupname = ("friends");
	guy.health = 100;
	guy.goalradius = 32;
	guy setgoalentity (level.player);
//	node = getnodearray("cover_14", "targetname");
	node = getnode("friendly_protect_tank", "targetname");
	guy setgoalnode(node); // Sets EACH friend to the corresponding node.
}

friendly_wave()
{
	trigger = getentarray("friendly_wave", "targetname");
	for (i=0;i<trigger.size;i++)
	{
			trigger[i] maps\_utility_gmi::triggerOff();	
	}
}

all_friends_stay_behind()
{
 	ai = getaiarray("allies");
 	for(i=0;i<ai.size;i++)	
	{
		println("^3 ******** the rest of you wait here1");
		if(isdefined(ai[i].targetname) && ai[i].targetname == "friends")
		{
		println("^3 ******** the rest of you wait here2");
			println("^3 ******** the rest of you wait here");
			node = getnode("friends_run_delete", "targetname");
			ai[i] setgoalnode(node);
			wait 0.1;
			ai[i].goalradius = 32;
			ai[i] thread friends_behind1();
		}
	}
}

friends_behind1()
{
	self waittill("goal");
	self delete();
}


clean1()  // clears all of the ai on the line...
{
 	ai = getaiarray("allies");
 	for(i=0;i<ai.size;i++)
	{
		if(!isdefined(ai[i].groupname) || ai[i].groupname != "friends" && ai[i].groupname != "moody")
		{
			ai[i] delete();
		}
	}
}

// foley runs into the church
foley_church()
{
	efoley = getent("foley2", "targetname");;

	level.foley_ai = efoley stalingradspawn();
	level.foley_ai.dontavoidplayer = 1;
	level.foley_ai.pacifist = true;
	level.foley_ai.ignoreme = true;

	level.foley_ai character\_utility::new();
	level.foley_ai character\foley_winter::main();

	esupport = getent("foley_support", "targetname");;
	level.esupport_ai = esupport stalingradspawn();
	level.esupport_ai.dontavoidplayer = 1;
	level.esupport_ai thread maps\_utility_gmi::magic_bullet_shield();
	wait 0.25;
	fnode = getnode("block_church2", "targetname");
	level.esupport_ai setgoalnode(fnode);


//	leve.foley_ai.groupname = "friends"();
//	println("^3 ***************************  :  ", epoor_bastard_ai.targetname, epoor_bastard_ai.health, epoor_bastard_ai.origin);
	level.foley_ai thread maps\_utility_gmi::magic_bullet_shield();
	level.foley_ai.animname = "foley_ai";
	level.foley_ai.goalradius = 20;
	enode = getnode("foley_speech1", "targetname");
	wait 0.1;
	level.foley_ai setgoalnode(enode);
	level.foley_ai waittill("goal");

	wait 2;
//anim/sound begin

//	anim_single (guy, anime, tag, node, tag_entity)	
	//Stick_with_me
	level.foley_ai thread anim_single_solo(level.foley_ai,"11th_armor_is_moving");
	wait 5.2;
//anim/sound end


	println("^3 everyone meet up here");
	println("^3 ******** mortar attacks **********");


	level thread church_mortars();
	mortars = getentarray("mortar","targetname");

	wait 1.7;

	level notify ("foley_said_speech");

	znode = getnode("foley_after_speech", "targetname");
	level.foley_ai setgoalnode(znode);

//	wait 2;
//	enode = getnode("cover_12", "targetname");
//	wait 0.1;
//	foley_ai setgoalnode(enode);
}

// chruch mortar event
church_mortars()
{
	for(i=1;i<4;i++)
	{
		pop[i] = getent("church_mortar" + i, "targetname");
	}

	// clean up for ambient_fight5 from inside of the church
	level thread ambient_battle5();

	level thread moody_vo_loop();	// start moody voice over loop


	pop[2] instant_mortar();
//	num = randomint(org.size);
//	num = randomint(4);

	while(level.flag ["kill_fake_sniper1"] == true)
	{
		// loop this 
		//for(n=0;n<6;n++)
		//{
			wait 0.1 + randomfloat(1.6);	
			num = (randomint(3)+1);
			pop[num] instant_mortar();		
		//}
	}
}

moody_vo_loop()
{
	while(1)
	{
		wait 18 + randomfloat(8);	
		if(level.flag ["kill_fake_sniper1"] == true)
		{
		//	anim_single (guy, anime, tag, node, tag_entity)	
			//Stick_with_me
			level.moody thread anim_single_solo(level.moody,"Get_up_in_the_bell_tower");
			wait 4.7;
		//anim/sound end
		}
	}
}

//#using_animtree("foy_table_lamp_anim");
table_lamp_event()
{
	etable = getent("table_lamp", "targetname");
	etable.animname = "table_kick";


	etable UseAnimTree(level.scr_animtree[etable.animname]);
//	while(1)
//	{
		println(" ^3  here it comes baby");	
		etable thread table_crash_sounds();
		etable anim_single_solo(etable, "table_anim");
		println("^5Table Animate : ", level.scr_anim[etable.animname]["table_anim"]);
//	}
}

table_crash_sounds()
{
	wait 0.3;
	self playsound ("table_crash");
	wait 1.6;
	self playsound ("lantern_crash");
}

barrel_effect_control()
{
	maps\_fx_gmi::loopfx("barreloil_fire", (-1112, -2400, 0), 0.15, undifined, undifined, 1, undifined, undifined, undifined);
//	maps\_fx_gmi::loopfx("barreloil_fire", (-1432, -2656, 0), 0.15, undifined, undifined, 1, undifined, undifined, undifined);
		    //loopfx(fxId, fxPos, waittime, fxPos2, fxStart, fxStop, timeout, low_fxId, lod_dist)
//	maps\_fx_gmi::loopfx("bomber_enginefire1", rwing_e1.origin, 0.15, rwing_e1.origin + (-100, 0, 0), undefined, 1, undefined, undefined, undefined);


	level waittill("barrel_effect_off");

	level notify ("stop fx1");
}

spawn_guy_table()
{

	trigger = getent("spawn_kick_table", "targetname");
	trigger waittill("trigger");

	println("^3 ********************  Table guy spawned in ************");
	eguy = getent("guy_kick_table", "targetname");
	eguy_ai = eguy dospawn();
	eguy_ai.grenadeawareness = 0;
	eguy_ai waittill ("finished spawning");
	eguy_ai thread maps\_utility_gmi::magic_bullet_shield();
	wait 0.25;
	eguy_ai.animname = "guy_table";
//	eguy_ai thread maps\_utility_gmi::magic_bullet_shield();
	eguy_ai.pacifist = true;

	level waittill("start_table_anim");

//	anim_single (guy, anime, tag, node, tag_entity)	
	//can't move up pinned down
	eguy_ai thread anim_single_solo(eguy_ai,"knock_over");
//anim/sound end
//	wait 1;

	level thread table_lamp_event();

	wait 2;
//	eguy_ai thread maps\_utility_gmi::stop_magic_bullet_shield(10);
	wait 0.05;
// had to take out -- talk to jed about getting it to work
//	eguy_ai maps\_flame_damage::CatchOnFire();

	level notify("fire_continue");

	wait 4;
	eguy_ai notify ("stop magic bullet shield");
}

// tank reset turret
Reset_Tank_Turret(tank)
{
	tag = tank gettagorigin("tag_turret");
	forward_angles = anglestoforward(tank.angles);
	vec = tank.origin + maps\_utility_gmi::vectorScale(forward_angles,2000);

	tank setTurretTargetVec(vec,(0,0,0));
	tank waittill("turret_on_target");
	tank clearTurretTarget();
}


// fake sniper1
// fake sniper2
// sniper triggers that keep player back
// Sniper should thread this. 
fake_sniper_area1()
{
	efake_sniper1 = getent("fake_sniper1", "targetname");
//	fake_sniper1 maps\_utility_gmi::triggerOn();
	level thread Fake_Sniper_Think1(); 
	wait 0.05;
//	level thread Fake_Sniper_Think2(); 
//	fake_sniper1 maps\_utility_gmi::triggerOff();
}

fake_sniper_area2()
{
//	efake_sniper2 = getent("fake_sniper2", "targetname");
	fake_sniper2 maps\_utility_gmi::triggerOff();
}

Fake_Sniper_Think1() 
{ 
     self endon("death"); 
 
     // Trigger the player must be in to be shot at. 
     trigger = getent("fake_sniper1","targetname"); 
     while(1) 
     { 
        trigger waittill("trigger"); 

    	if(level.flag["kill_fake_sniper1"] == false)
	{
		println("^3 ***********8 fake sniper has been turned off************");
		trigger maps\_utility_gmi::triggerOff();	
	}
 
          // Later, you should have an FX play by the players feet, as if a shot  
          // just barely missed him. Warning shot if you will. 
 
          while(level.player istouching(trigger) && isalive(level.player)) 
          { 
		thread playSoundinSpace ("weap_kar98k_fire", level.player.origin);
		wait .3;
               // Location of sniper guy... You could put, sniper.origin. 
               org = (0,0,0);  
               // Player starts off with 600 health... yes, 600 
               dmg = 600; 
 
               // TODO: Insert playsound here, from the sniper guy of a  
               // sniper rifle being fired. 
 
               level.player doDamage ( dmg, org); 
 
               // Approximate reload time. 
               wait (2 + randomfloat(2)); 
          }
     } 
}

Fake_Sniper_Think2() 
{ 
     self endon("death"); 
 
     // Trigger the player must be in to be shot at. 
     trigger = getent("jl126","targetname"); 
     while(1) 
     { 
          trigger waittill("trigger"); 
 
          // Later, you should have an FX play by the players feet, as if a shot  
          // just barely missed him. Warning shot if you will. 
 
          while(level.player istouching(trigger) && isalive(level.player)) 
          { 
               // Location of sniper guy... You could put, sniper.origin. 
               org = (0,0,0);  
               // Player starts off with 600 health... yes, 600 
               dmg = 320; 
 
               // TODO: Insert playsound here, from the sniper guy of a  
               // sniper rifle being fired. 
 
               level.player doDamage ( dmg, org); 
 
               // Approximate reload time. 
               wait (4 + randomfloat(2)); 
          } 
     } 

	
}

music()
{
	musicPlay("datestamp");
	
//	level waittill ("bunker music start");
//	musicPlay("pf_stealth");
}

sprint_hint()
{
	print("^3******************   Sprint ******************");
//	return;
	binding = getKeyBinding("+sprint");
	if(binding["count"])
	{
		maps\_utility_gmi::keyHintPrint(&"GMI_SCRIPT_HINT_SPRINT", binding);  
		return;
	}
}

last_guys_near_88()
{
	trigger = getent("spawn_guys_near_88", "targetname");
	trigger waittill("trigger");
	level thread moody_talk_take_out_mg42();

	println("^3 ************  last 88 guys spawning in **************");

	wait 0.05;

	germans = getentarray("guys_near_88", "groupname");
	for(i=0;i<germans.size;i++)
	{
//		if(isalive(germans[i]))
//		{
			println("^3************** count");
			germans_ai[i] = germans[i] stalingradspawn();
			germans_ai[i] thread last_guys_near_88_think();
//		}
		wait 0.05;
	}	
}

last_guys_near_88_think()
{
	self waittill ("death");
	level.last_guys_near_88_count++;
//	println("^3**************** level.last_guys_near_88_count",level.last_guys_near_88_count.size);
	if(level.last_guys_near_88_count == 7) // Checks the death count of roofsnipers.
	{
		maps\_utility::chain_off ("middle_88_battle");
//		maps\_utility_gmi::chain_on ("after_88_killed");	
		chain = maps\_utility::get_friendly_chain_node ("after_88_killed");
		level.player SetFriendlyChain (chain);		

		guy_die = getent("mg42_that_88_blows", "targetname");

		level.guy_die_ai = guy_die stalingradspawn();
		level.guy_die_ai.health = 300;	
		level.guy_die_ai.grenadeawareness = 0;
	
		// Killing the guys show the bomb on the 88 now!
		level.guy_die_ai thread level_guy_die_ai_death();
		// mg42 starts firing then he says this line.
		// please turn gun on other side of fence to mg34/...

		level notify ("go_moody_talk_take_out_mg42");
	}
}

moody_talk_take_out_mg42()
{
		level waittill("go_moody_talk_take_out_mg42");
		wait 2.3;                                                                                                                                                 
		println("^3**************** GUYS MOVE FORWARD BECUASE THE LAST GUY YOU NE");
		// Moody yells to take out the 42 with the 88          
		if(isalive(level.guy_die_ai))
		{               
			level.moody thread anim_single_solo(level.moody,"take_out_mg42_with_88");
		}
}

// Panzer Think.
Event7_Panzer_Think()
{
	self endon("death");

     	self.playpainanim = 0; 
    	self.pacifist = true; 
     	self.pacifistwait = 0; 
	self.playpainanim = false; 

	self.ignoreme = true;
	self.suppressionwait = 0.5;


	self waittill("goal");


//     	self thread maps\_utility::magic_bullet_shield(); 

//	wait 1;

	println("^5Event3_PanzerSHRIEK_Think START!");

	// Find closest living tank
	tanks = getentarray("shermans","groupname");

	tank1 = getent("sherman_1","targetname"); // sherman one is the old way
//	tank1 = getent("sherman_2","targetname"); 
	tanks = maps\_utility_gmi::subtract_from_array(tanks, tank1);

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

	if(dist1 > 1800) // range
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

		println("^3START =========== FIRE AT TARGET!");
		self.pacifist = true;
		if(isdefined(lead_pos))
		{
			println("Leading! and then fire", closest_tank.targetname);
		//	FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop)
			self FireAtTarget((lead_pos + (0,0,64)), 1.5, undefined, undefined, undefined, true);
			
		}
		else
		{
			println("not leading fire right away!!!", closest_tank.targetname);
		//	FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop)
//			level thread do_line(self.origin, closest_tank.origin, (1,0,0), "red");
			self FireAtTarget((closest_tank.origin + (0,0,64)), 1.5, undefined, undefined, undefined, true);
		}

		self thread Event7_Panzer_Think_pacifist_on_off();
		self.pacifist = false;
		println("^3End ==============FIRE AT TARGET!");
	}
	else
	{
		println("^1No more tanks to shoot at!!! Game Over??");
	}
}

Event7_Panzer_Think_pacifist_on_off()
{
	self endon("death");

	while(1)
	{
		wait (2 + randomfloat(3));
		if(isalive(self))
		{
			println("^2 ********************* Event7_Panzer_Think_pacifist_on_ ******************");
			println("^2 ********************* Event7_Panzer_Think_pacifist_on_ ******************");
			println("^2 ********************* Event7_Panzer_Think_pacifist_on_ ******************");
			println("^2 ********************* Event7_Panzer_Think_pacifist_on_ ******************");
			println("^2 ********************* Event7_Panzer_Think_pacifist_on_ ******************");
			self.pacifist = true;
		}

		wait (2 + randomfloat(7));
		if(isalive(self))
		{
			println("^2 ********************* Event7_Panzer_Think_pacifist_on_ ******************");
			println("^2 ********************* Event7_Panzer_Think_pacifist_on_ ******************");
			println("^2 ********************* Event7_Panzer_Think_pacifist_on_ ******************");
			println("^2 ********************* Event7_Panzer_Think_pacifist_on_ ******************");
			println("^2 ********************* Event7_Panzer_Think_pacifist_on_ ******************");
			self.pacifist = false;
		}
	}
}

//===================================================================
//
// This is debug so I can trace bullets/missles etc... 
//
//===================================================================
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

//=====================================================================================================
//
// This is code that Ryan wrote (which does not exist in og cod) to make an AI fire at an exact target.
//
//=====================================================================================================
FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop)
{
	self animscripts\combat_gmi::FireAtTarget(targetPos, duration, forceShoot, completeLastShot, posOverrideEntity, waitForStop);
}

// end bridge crossing

// Bridge crossing owning function
bridge_crossing()
{
	// Initalize the bridge crossing trigger brush
	trigger = getent("prone_or_pay", "targetname");

	while(1)
	{
		// Wait for player to touch the brush
		trigger waittill("trigger");
		level notify ("tiger2_attack_player");	

		// Brush covers all the bridge
		while(level.player istouching(trigger))
		{
			if (level.player getstance() != "prone" )
			{				
					level.player.threatbias = 20000; // makes everyone "love" the player
			}
			else
			{
					level.player.threatbias = 0; // back to normal
			}

			// Now check all the AI friends and force them to crouch/prone while the player is on the bridge
			// Rebuild array every time since guys might die and add new spawns
			level.end_friends = getentarray("friends","groupname");
			level.moody allowedStances ("crouch", "prone");

			for (i=0;i<level.end_friends.size;i++)
			{
				if(isalive(level.end_friends[i]))
					level.end_friends[i] allowedStances ("crouch", "prone");

			}
			wait 2;
		}

		level.player.threatbias = 0;
		wait 0.05;
	}
}

// need to add axis do damage for end tiger ai and also make it so they don't spawn in if the tiger is already dead..
// I bet the player can get through windows and bypass triggers causing clear house event not to update
axis_do_damage()
{
		ai = getaiarray ("axis");
		for (i=0;i<ai.size;i++)
		{
//			wait (0.1 + randomfloat (1.3));	 
//			if(isalive(ai[i]))
//			{
				ai[i] DoDamage ( ai[i].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );	
//
//			}
		}
}

last_event_germans()
{
//	trig = getent("last_germans_only_tank_alive");
//
//
//	While(1)
//	{
//		if(isalive(self))
//		{
//			trig maps\_utility_gmi::triggerOn();
//			wait 1;
//		}
//
//		if(!isalive(self))
//		{
//			trig maps\_utility_gmi::triggerOff();
//		}
//	}
}

p47_flyby() // road
{
	level waittill ("flyby go");
////	bomb_count = 0;
//	path = getvehiclenode("p47_path1","targetname");
//	
//	p47 = spawnvehicle("xmodel/v_us_air_p47","p471","BF109",(0,0,0),(0,0,0));
//	p47.health = 10000000;
//	p47.script_noteworthy = "noturrets";
////	p47 maps\_p47_gmi::init(bomb_count);
//	p47.attachedpath = path;
//	p47 attachPath(path);
//	p47 startpath();
//	p47 playsound("p47_attack");
//	wait 5;
	
	path = getvehiclenode("p47_path2","targetname");
	p47 = spawnvehicle("xmodel/v_us_air_p47","p472","BF109",(0,0,0),(0,0,0));
	p47.health = 10000000;
	p47.script_noteworthy = "noturrets";
//	p47 maps\_p47_gmi::init(bomb_count);
	p47.attachedpath = path;
	p47 attachPath(path);
	p47 startpath();
	p47 playsound("p47_attack");
	p47 waittill("reached_end_node");
	p47 delete();
	
}

p47_flyby_end() // cowbell
{
	level waittill ("flyby go end");
//	bomb_count = 0;
	// test  fly by...

//	wait 4;

//	level.player setorigin ((-714, 6534, 120));

	path = getvehiclenode("p47_path3","targetname");	
	p47 = spawnvehicle("xmodel/v_us_air_p47","p471","BF109",(0,0,0),(0,0,0));
	p47.health = 10000000;
	p47.script_noteworthy = "noturrets";
//	p47 maps\_p47_gmi::init(bomb_count);
	p47.attachedpath = path;
	p47 attachPath(path);
	p47 startpath();
	p47 playsound("p47_attack");
	wait 6;
	
	path = getvehiclenode("p47_path4","targetname");
	p47 = spawnvehicle("xmodel/v_us_air_p47","p472","BF109",(0,0,0),(0,0,0));
	p47.health = 10000000;
	p47.script_noteworthy = "noturrets";
//	p47 maps\_p47_gmi::init(bomb_count);
	p47.attachedpath = path;
	p47 attachPath(path);
	p47 startpath();
	p47 playsound("p47_attack");
	wait 6;

	path = getvehiclenode("jl339","targetname");
	p47 = spawnvehicle("xmodel/v_us_air_p47","p473","BF109",(0,0,0),(0,0,0));
	p47.health = 10000000;
	p47.script_noteworthy = "noturrets";
//	p47 maps\_p47_gmi::init(bomb_count);
	p47.attachedpath = path;
	p47 attachPath(path);
	p47 startpath();
	p47 playsound("p47_attack");
	p47 waittill("reached_end_node");

//	wait 20;
//	level thread p47_flyby_end();
}

Event10_time_Manager()
{
	level.reinforcment_time = 1.5; // Minutes
	// Divide up the wave times.
	level thread Event10_Reinforcement_Timer();
}

Event10_Reinforcement_Timer()
{
	level.event10_time = level.reinforcment_time * 60; // 2 minutes.

	hud_timer = false;
	hud_timer2 = false;
	while(level.event10_time > 0)
	{
		wait 1;
	
		level.event10_time-= 1;
		if(!isdefined(level.last_battle_timer)) // Old check, but keep incase we change this event again.
		{
			hud_timer = true;
			// Setup the HUD display of the timer.
			level.hudTimerIndex = 20;
			level.last_battle_timer = newHudElem();
			level.last_battle_timer.alignX = "left";
			level.last_battle_timer.alignY = "middle";
			level.last_battle_timer.x = 460;
			level.last_battle_timer.y = 100;
//			level.last_battle_timer.label = &"GMI_KHARKOV2_REINFORCEMENTS";
			level.last_battle_timer setTimer(level.event10_time);
		}

//		if(getcvar("end_timer") == "1" && !hud_timer2) // Old debug, but keep incase we change this event again.
//		{
//			hud_timer2 = true;
//			// Setup the HUD display of the timer.
//			level.last_battle_timer2 = newHudElem();
//			level.last_battle_timer2.alignX = "right";
//			level.last_battle_timer2.alignY = "middle";
//			level.last_battle_timer2.x = 570;
//			level.last_battle_timer2.y = 240;
////			level.last_battle_timer2.label = &"GMI_KHARKOV2_REINFORCEMENTS";
//			level.last_battle_timer2 setTimer(level.event11_time);
//		}

		if(level.event10_time < 14)
		{		
//			level notify("start_end_music");
		}

		if(level.event10_time < 10)
		{
//			level notify("Event11_Axis_Retreat");
		}
//		println("TIMER: ",time_seconds);
	}

	 level.last_battle_timer destroy();
}


//=========================================
//
// This will hide the mg42 model
//
//=========================================
end_farm_boom()
{
//	trigger = getent("mg42_nest_damage","targetname");  // I need a name for this trigger
//	trigger waittill("damage");
//	trigger waittill("damage", dmg, who);	

//	mg42 = getent ("jl232","targetname");
//	mg42 notify("stopfiring");
//	wait 0.25;
//	mg42 delete();
}

block_road()
{

//	block = spawn("script_model",(-24, -2148 -32), (0, 0, 0));	
//	block setmodel("xmodel/hedgehog_lp");
}