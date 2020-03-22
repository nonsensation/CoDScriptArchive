//=====================================================================================================================
// Bastogne2_event1to2
//	
//	CONTAINS EVENTS:
//
//		EVENT1
//		EVENT1to2
//
//=====================================================================================================================

//=====================================================================================================================
//	event1_friendly_setup()
//
//		Sets up friendly ai for the first event
//=====================================================================================================================
#using_animtree("generic_human");
event1_friendly_setup()
{
	
	//
	//  BLUE GROUP
	//
	
	// your core must not die blue
	names[0] = "Sgt. Moody";
	names[1] = "Pvt. Whitney";
	names[2] = "Pvt. Anderson";

	animnames[0] = "moody";
	animnames[1] = "whitney";
	animnames[2] = "anderson";
	
	blue = getentarray("blue", "groupname");

	//Three members of blue, 0 is Moody, 1 is Whitney, 2 is Anderson
	for(n=0; n<blue.size; n++)
	{
		level.blue[n] = getent("blue_" + n, "targetname");
		level.blue[n] character\_utility::new();

		level.blue[n].name = names[n];
		level.blue[n].animname = animnames[n];

		level.blue[n] [[level.scr_character[animnames[n]]]]();
		level.blue[n].pacifist = 1;
		level.blue[n] thread maps\bastogne2::util_dont_ff_me();

		level.blue[n].goalradius = 96;
		level.blue[n].followmax = 4;
		level.blue[n].followmin = 0;
		
		//Everyone, get down!
		//level.blue[n] allowedStances("crouch");
		
		level.blue[n].bravery = 50;
		level.blue[n].grenadeawareness = 0;
		
		level.blue[n] thread maps\_utility_gmi::magic_bullet_shield();
		
	}

	// set a special variable for moody
	level.moody = level.blue[0];
	level.moody character\_utility::new();
	level.moody character\moody_winter::main();

	level.moody_woundedsequence_health = 280; // og 750
	level.flags["event1_moody_died"] 	= false;
	level.flags["event1_moody_can_die"] 	= true;
	level.flags["pown_start_bmw"] = false;

	level.flags["moody_talking_now"] = false;

	level.flags["moody_resue_countdown"] 	= false;

	
	//level waittill ("speeches over");
	
//	for(n=0; n<blue.size; n++)
//	{
//		level.blue[n] allowedstances ("stand", "crouch", "prone");
////		level.blue[n] allowedStances("stand");
//			for(n=0;n<level.blue.size;n++)
//			{
//				if (isalive(level.blue[n]))
//				{
//					level.blue[n] setgoalentity (level.player);
////					level.blue[n].followmax = 4;
////					level.blue[n].followmin = 0;
//				}
//			}
//	}
//
//	level.blue[0].followmax = 4;
//	level.blue[1].followmax = 2;
//	level.blue[2].followmax = 1;
	
	//level waittill ("walkies go");
	
	//for(n=0; n<blue.size; n++)
	//{
		//level.blue[n] thread walkies();
	//}
	
	//
	//  RED GROUP
	//
	
	red = getentarray("red", "groupname");

	animnames[0] = "red_0";
	animnames[1] = "red_1";

	names[0] = "Pvt. Gordon";
	names[1] = "Pvt. Freeman";
	
	for(n=0; n<red.size; n++)
	{
		//level.red_spawn[n] = getent("red_" + n, "targetname");
		//level.red[n] = level.red_spawn[n] stalingradspawn();
		//level.red[n] waittill ("finished spawning");
		level.red[n] = getent("red_" + n, "targetname");
		level.red[n] character\_utility::new();

		level.red[n].name = names[n];
		level.red[n].animname = animnames[n];

		level.red[n] [[level.scr_character[animnames[n]]]]();
		level.red[n].pacifist = 1;
		level.red[n] thread maps\bastogne2::util_dont_ff_me();

		level.red[n].goalradius = 96;
		level.red[n].followmax = 4;
		level.red[n].followmin = 0;
		
		level.red[n].bravery = 50;

//		level.red[n] thread maps\_friendly_gmi::adopt_player_stance();
		
		//This used to be 600, same as player...I made them a little tougher seeing as they can't exactly
		//pick up health packs...
		level.red[n].health = 1200;
		level.red[n].grenadeawareness = 0;
		level.red[n] allowedStances("stand");
		//level.red[n] thread walkies();
		//wait 0.3;
	}

	//
	//  POWNED
	//
	//level.powned_spawn = getent("powned", "targetname");
	//level.powned = level.powned_spawn stalingradspawn();
	//level.powned waittill ("finished spawning");
	level.powned = getent("powned", "targetname");
	level.powned character\_utility::new();

	level.powned thread maps\bastogne2::friendly_damage_penalty();
	level.powned.animname = "powned";

	level.powned.grenadeawareness = 0;

	level.powned [[level.scr_character[animnames[n]]]]();
	level.powned.pacifist = 1;
	level.powned thread maps\bastogne2::util_dont_ff_me();

	level.powned.goalradius = 96;
	level.powned.followmax = 3;
	
	level.powned.bravery = 50000;

	// this will cause the guy to run really fast.  
	// we want to make sure he arives at the fight before the player
	level.powned.runanimplaybackrate = 1.2;
	
	//level.powned thread maps\_friendly_gmi::adopt_player_stance();
	
	//This used to be 600, same as player...I made them a little tougher seeing as they can't exactly
	//pick up health packs...
	level.powned.health = 1200;
	
	level.powned thread maps\_utility_gmi::magic_bullet_shield();
	
	level.powned allowedStances("stand");
	//level.powned thread walkies();
}

//=====================================================================================================================
// * * * EVENT 1 * * * 
//
//	Event 1 encompasses the begining of the level, the run across the field, team member getting injured, and
//	the rescue while the player defends.  At the end of the event a "event1_end" will get sent out to clean
//	up all event 1 specific functions.
//=====================================================================================================================

//=====================================================================================================================
//	event1_init
//
//		Sets up any thing that needs to be set up for event1 and threads all event1 functions
//=====================================================================================================================
event1_init()
{
	if(getCvar("scr_debug_event1") == "")		
		setCvar("scr_debug_event1", "1");	
	level.debug["event1"] = getcvarint("scr_debug_event1");
	
	level.flags["got_to_wounded"] = false;
	
	maps\_utility_gmi::chain_on("10");

	// threads
	level thread event1_briefing(); // allied briefing at the beggining of the level
	level thread event1_vehicle_init();
	level thread event1_mg42_init();
	level thread event1_owned_sequence();
	level thread event1_rescue();
	level thread event1_main_attack();
	level thread event1_player_kill_handler();
	level thread event1_player_agressive_handler();
	level thread event1_cleanup();
	level thread event1_moody_letsgo();
	level thread event1_clear_forest();
	level thread event1_clear_forest_chain();
	level thread event1_clear_forest_chain_done();
	level thread walkies_off();
	level thread event1_blast();
	level thread event1_walk_and_talk();
	level thread test();
//	level thread bypass_meeting();
	level thread event1_talk_think();
	level thread event1_squad2_setup();
	level thread event1_squad3_setup();
	level thread player_hits_trigger_force();
	level thread event1to2_shutup();
	//level thread event1_fadein_fix();
}

//=====================================================================================================================
//	event1_debug_cleanup
//
//		Cleans up any thing that needs to be cleaned up for event1 if this event is skipped
//=====================================================================================================================
event1_debug_cleanup()
{
	// notify all of the ai cleanups that they need to be killed
	level notify("event1_debug_cleanup");
	
	wait(0.05);
	// make sure the first events are killed
	level notify("event1_end");
	
	// make sure the first chain is off
	maps\_utility_gmi::chain_off("10");

	// delete the vehicle and vehicle guy
	event1_vehicle = getent("event1_vehicle","targetname");
	event1_vehicle_driver = getent("event1_vehicle_driver","targetname");

	if ( isDefined(event1_vehicle) )
		event1_vehicle delete();
	if ( isDefined(event1_vehicle_driver) )
		event1_vehicle_driver delete();
		
	// delete the mg42 and any of its guys
	event1_mg42 = getent("zeta_mg42","targetname");
	user = event1_mg42 getTurretOwner();

//	if ( isDefined(event1_mg42) )
//		event1_mg42 delete();
	if ( isDefined(user) )
		user delete();
		
	// make sure the player is not stuck in one stance
	level.player allowStand(true);
	level.player allowCrouch(false);
	wait(0.1);
	level.player allowCrouch(true);
	level.player allowProne(true);

}

//=====================================================================================================================
//	event1_cleanup
//
//		Cleans up any thing that needs to be cleaned up for event1
//=====================================================================================================================
event1_cleanup()
{
	level waittill("event1_end");

	maps\_utility_gmi::chain_off("10");
	
}

//=====================================================================================================================
//	event1_player_kill_handler
//
//		If the player goes rogue during this event then the unleash the killers.
//=====================================================================================================================
event1_player_kill_handler()
{
	level endon("event1_end");
	
	trigger = getent("event1_trigger_kill_player","targetname");
	
	// if this trigger ever goes off terminate the player
	trigger waittill("trigger");
	
	maps\bastogne2::dprintln("event1","^1Terminate player");
		
	level notify("event1_kill_player");
}

//=====================================================================================================================
//	event1_player_agressive_handler
//
//		If the player gets aggressive and moves ahead to far then get agressive back
//=====================================================================================================================
event1_player_agressive_handler()
{
	level endon("event1_end");
	
	trigger = getent("event1_trigger_agressive","targetname");
	
	// if this trigger ever goes off terminate the player
	trigger waittill("trigger");
	
	maps\bastogne2::dprintln("event1","^2Get agressive");
	
	ai = getaiarray ("axis");
	for (i=0;i<ai.size;i++)
	{
		if(isalive(ai[i]))
		{
			ai[i].accuracy = 1.0;
		}
	}
	
	// need to made everyone own the player
	// main enemy waves
	//thread  maps\_squad_manager::manage_spawners("omnikron",2,3,"event1_end",2, ::event1_squad_init_omnikron );
}

//=====================================================================================================================
//	event1_briefing
//
//		Initial cinematic and briefing that starts the level.  After briefing releases the AI for the run
//		across the field.
//=====================================================================================================================
event1_briefing() // meeting
{
	level endon("event1_end");  
	level waittill ("starting final intro screen fadeout");


	if (getcvar("skipto") != "event7" || getcvar("skipto") != "event4" )
	{
		
	//Placeholder text to tell the player the vital information we need to impart to him
	//Let's make sure he *has* to "sit" there and listen...
	level.player allowCrouch(false);
	level.player allowProne(false);

//	level.player setorigin ((4173, -9041, 54));
	lock = spawn("script_origin", level.player.origin);
	level.player linkTo(lock);
	
	ramirez = getent("ramirez","targetname");
	ramirez.name = "Sgt. Ramirez"; 
	ramirez.animname = "ramirez";
	ramirez.dontavoidplayer = true;
	ramirez.grenadeawareness = 0;
	ramirez thread maps\_utility::magic_bullet_shield();
	
	foley = getent("foley","targetname");
	foley.name = "Cpt. Foley"; 
	foley.animname = "foley";
	foley.dontavoidplayer = true;

// does this only work 
	foley character\_utility::new();
	foley character\foley_winter::main();

	foley.grenadeawareness = 0;
	foley thread maps\_utility::magic_bullet_shield();
	
	jones = getent("jones","targetname");
	jones.name = "Sgt. Jones"; 
	jones.animname = "jones";
	jones.dontavoidplayer = true;
	jones.grenadeawareness = 0;
	jones thread maps\_utility::magic_bullet_shield();

//	wait 0.05;
	
	//level.moody thread 	animscripts\shared::lookatentity(foley, 10000000, "casual");
	//jones thread 		animscripts\shared::lookatentity(foley, 10000000, "casual");
	//ramirez thread		animscripts\shared::lookatentity(foley, 10000000, "casual");

	
	table = getent ("table","targetname");
	
	foley thread anim_single_solo(foley, "foley_brief1", undefined, table);
	level.moody thread anim_single_solo(level.moody, "moody_brief1_intro", undefined, table);
	ramirez thread anim_single_solo(ramirez, "ramirez_intro", undefined, table);
	jones thread anim_single_solo(jones, "jones_intro", undefined, table);
	level thread table_map_anim();
	
	foley waittillmatch ("single anim","foley_brief2");
	foley thread anim_single_solo(foley, "foley_brief2", undefined, table);

	level.moody waittillmatch ("single anim","moody_brief1");
	//  paper_slide_desk
	level.moody thread anim_single_solo(level.moody, "moody_brief1", undefined, table);

	level thread paper_slide_sync();

	ramirez waittillmatch ("single anim","ramirez_gotit");
	ramirez thread anim_single_solo(ramirez, "ramirez_gotit", undefined, table);
	level.moody waittillmatch ("single anim","moody_brief2");
	level.moody thread anim_single_solo(level.moody, "moody_brief2", undefined, table);
	foley waittillmatch ("single anim","foley_brief3");
	foley thread anim_single_solo(foley, "foley_brief3", undefined, table);
	level.moody waittillmatch ("single anim","moody_yessir");
	level.moody thread anim_single_solo(level.moody, "moody_yessir", undefined, table);
	ramirez thread anim_single_solo(ramirez, "ramirez_yessir", undefined, table);
	jones thread anim_single_solo(jones, "jones_yessir", undefined, table);
	foley waittillmatch ("single anim","foley_dismissed");
	foley thread anim_single_solo(foley, "foley_dismissed", undefined, table);
	
	level notify ("speeches over"); 
	
	wait 0.3;
	wait 6;
	
	level.player unlink();
	lock delete();
	wait(0.1);
	level.player allowCrouch(true);
	level.player allowProne(true);
	level.player allowStand(true);

	trg = getent("friendlychain_10", "targetname");

	trg waittill("trigger");

	wait(0.05);

	fnode = getnode ("moody_talk1_go", "targetname");

//	level.blue[0] setgoalentity(level.player);
	level.blue[0] setgoalnode(fnode);
	
//	node1 = getnode("red_0_goal","targetname");
//	node2 = getnode("red_1_goal","targetname");


	node1 = getnode("red_0a_goal","targetname");
	node2 = getnode("red_1a_goal","targetname");
	
	level.red[0] setgoalnode(node1,"targetname");
	level.red[1] setgoalnode(node2,"targetname");

	level.red[0] allowedstances("crouch");
	level.red[1] allowedstances("crouch");

	//level.blue[1] setgoalentity(level.player);
	//level.blue[2] setgoalentity(level.player);
	
	level notify ("walkies go");
	
	getent("event1_player_cresting_hill","targetname") waittill ("trigger");

	level notify ("player_at_ridge");

	level.red[0] allowedstances("crouch", "prone", "crouch");
	level.red[1] allowedstances("crouch", "prone", "crouch");


	node1 = getnode("red_0_goal","targetname");
	node2 = getnode("red_1_goal","targetname");
	
	level.red[0] setgoalnode(node1,"targetname");
	level.red[1] setgoalnode(node2,"targetname");

	
	ramirez delete();
	foley delete();
	jones delete();
	}
}

//=====================================================================================================================
//	paper_slide_sync
//		
//=====================================================================================================================
paper_slide_sync()
{
	table = getent ("table","targetname");
	wait 0.5;
	table playsound ("paper_slide_desk");
}

//=====================================================================================================================
//	event1_owned_sequence
//
//		This sets up the stage for the defend in event1.  Your guy "Pvt. Powned" runs up and gets shot 
//		necessitating a rescue.  The player will defend while one of the friendly rescues the private.
//=====================================================================================================================
event1_owned_sequence()
{
	level endon("event1_end");
	
//	trigger = getent("event1_powned_go","targetname");
	
//	trigger waittill("trigger");
	getent("event1_player_cresting_hill","targetname") waittill ("trigger");
	println(" ^3 ************ player moved ahead earlier ************");

	println("^3 player has triggered powned event to occur");	
	maps\bastogne2::dprintln("event1","POWNED GO!");

	wait 1.5;

	level.powned.grenadeawareness = 1;	
	level.powned.goalradius = 2;
	level.powned.ignoreme = true;
	level.powned.pacifist = true;
	level.powned allowedstances("crouch");
	level.powned setgoalnode( getnode("event1_powned_chase_driver","targetname") );
	level.powned waittill ("goal");	

//	wait 20;
	
//	level notify("event1_powned_arrived");

	// wait for either the look at trigger to happen OR a certain amount of time to pass
	level thread maps\bastogne2::util_event( "event1_powned_lookat_trigger", 4, "event1_player_looking_at_powned", "event1_end");

	level waittill("event1_player_looking_at_powned");

	level.flags["pown_start_bmw"] = true;
		
	level notify("event1_powned_arrived"); // this is the set that starts the boomm...

	wait 1;
	level.blue[1] thread anim_single_solo(level.blue[1],"whitney_bobby_hit");
	println("^3 whitney says run for it line now");

//	thread event1_wounded_idle();


	maps\bastogne2::dprintln("event1","^Drop powned");
	
	// powned now should get shot 
	//level.powned waittill("damage");
	level notify("objective_1_complete");

//	wait( 1.7 + randomfloat( 2.9 ) );
	wait 1.3;
	level thread moody_get_back_and_cover_me_now();
	level.moody thread anim_single_solo(level.moody,"moody_runforit");

	println("^3 Moody says run for it line now");
	
	// set up the injury
	level.powned.grenadeawareness = 0;
	level.powned.ignoreme = true;
	level.powned.pacifist = 1;
	level.powned allowedstances("crouch");


	level notify("event1_powned_owned");
	level thread event1_rescue_death_with_wounded();

	wait 3.5;

	wait 2;
	level.blue[1] thread anim_single_solo(level.blue[1],"whitney_keep_firing");
	println("^3 whitney says run for it line now");


	
}

//=====================================================================================================================
//	moody_talk_control
//
//      This will stop vo's from overlapping
//		
//=====================================================================================================================
moody_talk_control_on()
{
	level.flags["moody_talking_now"] = true;
	wait 3;
	level thread moody_talk_control_off();
}

moody_talk_control_off()
{
	level.flags["moody_talking_now"] = false;
}

//=====================================================================================================================
//	moody_get_back_and_cover_me_now
//
//      lets moody bark at the player for a short time if they get to close.
//		
//=====================================================================================================================
moody_get_back_and_cover_me_now()
{

	level endon ("stop_moody_riley_get_back");
	level endon ("objective_2_complete");
 	// this line cannot take priority over the other lines...

	// do a distance check now... only turn on after moody says his key line.. then turn off when he comes back
	wait 14;
	while(1) // gatta turn when moody gets to the top of the hill
	{
		if (distance (level.player getorigin(), level.blue[0].origin) < 120)	
		{					
				level.blue[0] thread anim_single_solo(level.blue[0],"moody_cover_me"); // moodu cover me file
			break; // continue once the player is close enough to the event.
		}
		wait 1;
	}
}

own_chickenshit_player_think()
{
	println("^1Beginning Chickenshit");
	level endon("end chickenshit");
	old_time = gettime() / 1000;
	while(1)
	{
		new_time = gettime() / 1000;
		if (new_time - old_time > 15)
		{
			level thread own_chickenshit_player();
		}
		if (level.player attackButtonPressed())
		{
			old_time = gettime() / 1000;	
			println("^1Time was: "+(new_time - old_time)+". New time assigned!");
		}
		wait 0.05;
	}
}
own_chickenshit_player()
{	
	level.moody_woundedsequence_health = -10; // og 750	
	println("^1Killing player (didn't fight)");
	level notify("end chickenshit");
}

//=====================================================================================================================
//	event1_wounded_idle
//
//		Puts powned into a wounded idle and keeps him there
//=====================================================================================================================
event1_wounded_idle()
{
	wounded_node = getnode("event1_owned_node","targetname");
	if (isdefined (wounded_node))
	{
		level endon ("event1_stop_wounded_idle");
		while (1)
		{
			level.powned animscripted("animdone", wounded_node.origin, wounded_node.angles, level.scr_anim["powned"]["idle"]);
			level.powned waittillmatch ("animdone", "end");
		}
	}
}

//=====================================================================================================================
//	event1_wounded_idle
//
//		Puts powned into a wounded idle and keeps him there
//=====================================================================================================================
event1_wounded_rescued_idle()
{
	self endon ("death");
	level endon ("event1_stop_wounded_rescued_idle");
	org = self.origin;
	ang = self.angles;
	while (1)
	{
		self animscripted("animdone", org, ang, level.scr_anim["powned"]["idle"]);
		level.powned.allowDeath = 0;
		self waittillmatch ("animdone", "end");
	}
}

//=====================================================================================================================
//	event1_rescue
//
//		This sets up the stage for the rescue in event1.
//=====================================================================================================================
event1_rescue()
{
	level endon("event1_end");
	
	
	// make the player clip that keeps the player away from the point where the wounded guy will be
	// placed after the rescue non solid for now
	clip = getent ("event1_player_not_allowed_clip","targetname");
	if (isdefined (clip))
	{
		clip notsolid();
	}
		
	level waittill("event1_powned_owned");
	
	moody = level.blue[0];
	
	maps\bastogne2::dprintln("event1","starting rescue");
	
	moody notify ("stop magic bullet shield");
	wait 0.05;
	moody.health = 5000000;
	moody thread event1_rescue_pickup();

	level waittill ("event1_rescue_done");
	level notify("objective_2_complete");
	maps\bastogne2::dprintln("event1", "^2Event one done" );
	level notify ("event1_end");
}

//=====================================================================================================================
//	event1_rescue_pickup
//
//		Guy goes out to pickup wounded man
//=====================================================================================================================
event1_rescue_pickup()
{
	self endon ("death");
	self endon ("event1_rescue_putdown");


	level.moody.dontavoidplayer = 1;
	wait 2.4;	
	// put any speech moody will be doing here
	level.moody thread anim_single_solo(level.moody,"moody_wounded");
	
	// start moody going to the pickup spot
	wounded_node_pickup = getnode ("event1_rescue_pickup","targetname");
	wounded_node = getnode("event1_owned_node","targetname");
	
//	level.moody thread animscripts\shared::SetInCombat(false);
	self thread maps\_utility::cant_shoot();
	self.oldbravery = self.bravery;
	self.bravery = 1000000;
	self.ignoreme = true;
	self.goalradius = 2;
	
	self allowedstances("crouch");
	self.desired_anim_pose = "crouch";
	self animscripts\utility::UpdateAnimPose();
	self.anim_movement = "walk";
	self setgoalnode(wounded_node_pickup);
	
	wait 5;
	
	self waittill ("goal");
	self allowedstances("stand","crouch","prone");
	
	level notify ("event1_stop_wounded_idle");
	level.flags["got_to_wounded"] = true;
	
	println("Starting pickup");
	self thread event1_rescue_pickup_wait();
	self animscripted("event1_moody_pickup", wounded_node_pickup.origin, wounded_node_pickup.angles, level.scr_anim["moody"]["pickup"]);
	level.powned animscripted("scriptedanimdone", wounded_node.origin, wounded_node.angles, level.scr_anim["powned"]["pickup"]);
	level.flags["event1_got_wounded"] = true;
	self.ignoreme = false;
	level.flags["event1_rescuer_can_die"] = true;
	self waittillmatch ("event1_moody_pickup", "end");
	self notify ("event1_stop_pickup");


//     	guy[0] = level.foley; 
//     	guy[1] = level.moody; 
//     	println ("^3 Time to reach the goal!"); 
//  	anim_pushPlayer (guy); 


	guys[0] = level.moody;
	maps\_anim_gmi::anim_pushPlayer(guys);	
	self thread event1_rescue_walk_back();

	level.blue[2] thread anim_single_solo(level.blue[2],"anderson_hesgothim");
	wait 6;
	level.blue[1] thread anim_single_solo(level.blue[1],"whitney_comeonsarge");
	//level thread event1_rescue_death_with_wounded();

	level notify ("stop_moody_riley_get_back");

	wait 5;
	wait 3;


	level.blue[0] thread anim_single_solo(level.blue[0],"moody_hangin");
	
	// need to reset moodys goal node here and several other things
	level waittill ("event1_moody_is_done");

	println("^3 Moody you loookin good kid");
	level.moody.threatbias = 0; 
	
	level.moody thread maps\_utility::magic_bullet_shield();
	level.moody.threatbias = -1;
	
	if (level.flags["event1_moody_died"] == false)
	{
//		objective_state(1, "done");
		level.moody.goalradius = 8;
		lastnode = getnode("event1_moody_rescue_done","targetname");
		level.moody allowedstances ("stand", "crouch", "prone");
		level.moody setgoalnode (lastnode);
		if (isdefined (level.moodyoldbravery))
			level.moody.bravery = level.moodyoldbravery;
			
		level.moody waittill ("goal");

		level.moody thread maps\_utility::can_shoot();
		level.moody.ignoreme = false;
	}
	
	maps\bastogne2::dprintln("event1", "^2RESCUE DONE" );
	level notify ("event1_rescue_done");
	level notify("end chickenshit");
	wait 3;
}

//=====================================================================================================================
//	event1_rescue_pickup_wait
//
//		Guy goes out to pickup wounded man
//=====================================================================================================================
event1_rescue_pickup_wait(note)
{
	self endon ("event1_stop_pickup");
	while (1)
	{
		self waittill ("event1_moody_pickup", notetrack);
		if (notetrack == "anim_gunhand = \"none\"")
			self animscripts\shared::PutGunInHand("none");
	}
}

//=====================================================================================================================
//	event1_rescue_walk_back
//
//		Picked up guy now head back
//=====================================================================================================================
event1_rescue_walk_back()
{
	level.moody endon ("death");
	level.moody endon ("event1_putdown");

	level thread own_chickenshit_player_think();
		
	thread event1_rescue_putdown();
	
	allies = getaiarray ("allies");
	for (i=0;i<allies.size;i++)
	{
		if ( (isdefined (allies[i])) && (isalive (allies[i])) )
			allies[i].threatbias = 0;
	}
	allies = undefined;
	
	level.moody.threatbias = 50000;
	
	offset = (0, 0, 0);
	node = getnode ("event1_rescue_pickup","targetname");
	wounded_node = getnode("event1_owned_node","targetname");
	endtrig = getent ("event1_moody_putdown_trigger","targetname");
	
	position = node.origin;
	last_position = position;
	
	// determine the angles from where moody is to where he is going
	angles = vectortoangles( node.origin - wounded_node.origin  );
	// only care about the yaw
	angles = (0, angles[1], 0);
	
	while ( (!(self istouching (endtrig))) && (isalive (self)) )
	{
		// if the player is in the way then do not move forward
		if ( event1_is_player_blocking_rescue( angles ) )
		{
			// we need a special animation here for them both just standing there
			// but since we do not have that I am going to put moody back to the previous position 
			// and let them loop over that distance
			position = last_position;
			offset = last_offset;
			
			maps\bastogne2::dprintln("event1","^2Player blocking moody.  IDLE ANIMS NEEDED!");		
		}
		
		last_position = position;
		last_offset = offset;
				
		level.moody animscripted("scriptedanimdone", position, angles, level.scr_anim["moody"]["walkback"],"deathplant");
		level.powned animscripted("scriptedanimdone", position, angles, level.scr_anim["powned"]["walkback"],"deathplant");
		
		level.moody.allowDeath = 0;
		
		level.moody waittillmatch ("scriptedanimdone", "end");
		offset += getCycleOriginOffset(angles, level.scr_anim["moody"]["walkback"]);

		// because the animation is from brecourt which walks across level ground until we get new anims
		// we need to make sure he stays on the terrain
		position = node.origin + offset;
		trace = bulletTrace((level.moody.origin + (0,0,200)), (level.moody.origin-(0,0,5000)), false, undefined);
		ground_position = trace["position"];
		
		position = ( position[0], position[1], ground_position[2] );
		angles = ( level.moody.angles[0], angles[1], 0 );
	}
}

//=====================================================================================================================
//	event1_rescue_putdown
//
//		Got back safely now put wounded guy down
//=====================================================================================================================
event1_rescue_putdown()
{
	level.moody endon ("death");
	level.moody endon ("event1_putdown");
	
	endtrig = getent ("event1_moody_putdown_trigger","targetname");
	endnode = getnode ("event1_moody_putdown","targetname");
	
	while (!(self istouching (endtrig)))
		wait .2;
	
	println ("starting putdown");
	level.moody.threadbias = -1;
	
	if (level.flags["event1_moody_died"] == false)
	{
		println("^3 **********  god mode is own for moody WHY!!!!!!!!!!!!!!!*******");
		println("^3 **********  god mode is own for moody WHY!!!!!!!!!!!!!!!*******");
		println("^3 **********  god mode is own for moody WHY!!!!!!!!!!!!!!!*******");

		level.moody.health = 1000000;
		level.moody.health = 300;
		level.moody thread maps\_utility::magic_bullet_shield();
		level.flags["event1_moody_can_die"] = false;
		level.moody thread event1_keep_moody_alive();
		
		// this will block off the area where the wounded guy will be placed after rescue
		level.player thread event1_player_not_allowed();
		
		level.powned.allowDeath = 0;
		level.moody.allowdeath = 0;
		
		level notify ("event1_rescue_wounded_back");
		level.moody notify ("event1_putdown");
		
		// TAKE OUT WHEN ANIMS ARE MADE FOR THIS LEVEL
		// because these are brecourt anims need to modify the end position of the node to look good
		position = ( endnode.origin[0], endnode.origin[1], endnode.origin[2] + 0 );
		
		level.moody animscripted("scriptedanimdone", position, endnode.angles, level.scr_anim["moody"]["putdown"]);
		level.powned animscripted("scriptedanimdone", position, endnode.angles, level.scr_anim["powned"]["putdown"]);

		level.blue[0] thread anim_single_solo(level.blue[0],"moody_lookin_good");		

		level.moody animscripts\shared::DoNoteTracks("scriptedanimdone");
		level notify ("event1_moody_is_done");

		clip = getent ("event1_player_not_allowed_clip","targetname");
		if (isdefined (clip))
			clip notsolid();

		level.powned thread event1_wounded_rescued_idle();
	}
}

//=====================================================================================================================
//	event1_keep_moody_alive
//=====================================================================================================================
event1_keep_moody_alive()
{
	self endon ("stop magic bullet shield");
	while (level.flags["event1_moody_can_die"] == false)
	{
		self waittill ("damage");
		self.health = 9999999;
	}
}

//=====================================================================================================================
//	event1_rescue_death_with_wounded
//
//		Handles rescuer getting killed while carrying wounded guy
//=====================================================================================================================
event1_rescue_death_with_wounded()
{
	println(" ^3 ********event1_rescue_death_with_wounded ***********");


	level endon ("event1_rescue_wounded_back");
	level endon ("event1_rescue_putdown");
	
	dmgtaken = 0;
	
	while (dmgtaken < level.moody_woundedsequence_health)
	{
		level.moody waittill ("damage",damage,attacker);
		level.moody.maxhealth = level.moody.health;
		dmgtaken = (dmgtaken + damage);
		println("^4 moody is taking damage now ********** moody dmg  :", level.moody_woundedsequence_health);
	}
	
//	objective_string(2, &"GMI_BASTOGNE2_FAIL_MOODY");
	setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_BASTOGNE2_MOODY_DIED");
	objective_state(2, "failed");
	
	level.flags["event1_moody_died"] = true;
	level notify ("event1_moody_is_done");
	
	trace = bulletTrace((level.moody.origin + (0,0,25)), (level.moody.origin-(0,0,5000)), false, undefined);
	level.moodyfall_origin = trace["position"];
	level.moodyfall_angles = level.moody.angles;
	
	badplace_cylinder("moody", -1, level.moodyfall_origin, 75, 300, "neutral");

	level thread event1_rescue_rescuer_dodeath_animloop();
	level thread event1_rescue_wounded_dodeath_animloop();
	wait 3;
	missionfailed();
//	setCvar("ui_deadquote", "Random quote or reason you failed goes here.");
}

//=====================================================================================================================
//	event1_rescue_rescuer_dodeath_animloop
//
//		If the rescuer gets killed while carrying wounded then this function will handle the rescuer anims
//=====================================================================================================================
event1_rescue_rescuer_dodeath_animloop()
{	
	level.moody.health = 1000000;
	level.moody.maxhealth = (level.moody.health * 20);
	level.moody endon ("death");//failsafe
	level.moody.allowdeath = 0;
	level.moody animscripted("deathanim", level.moodyfall_origin, level.moodyfall_angles, level.scr_anim["moody"]["death"]);
	level.moody waittillmatch ("deathanim","end");
	level.moodyfall_origin = level.moody.origin;
	level.moodyfall_angles = level.moody.angles;
	while (1)
	{
		level.moody animscripted("deathanimloop", level.moodyfall_origin, level.moodyfall_angles, level.scr_anim["moody"]["deathidle"]);
		level.moody waittillmatch ("deathanimloop","end");
	}
}

//=====================================================================================================================
//	event1_rescue_wounded_dodeath_animloop
//
//		If the rescuer gets killed while carrying wounded then this function will handle the wounded anims
//=====================================================================================================================
event1_rescue_wounded_dodeath_animloop()
{		
	if (level.flags["got_to_wounded"] == false)
	{
		return;
	}
	
	level.powned.health = 1000000;
	level.powned thread maps\_utility::magic_bullet_shield();
	level.powned.maxhealth = (level.powned.health * 20);
	level.powned endon ("death");//failsafe
	level.powned.allowdeath = 0;
	level.powned animscripted("deathanim", level.moodyfall_origin, level.moodyfall_angles, level.scr_anim["powned"]["death"]);
	level.powned waittillmatch ("deathanim","end");
	org = level.moody.origin;
	while (1)
	{
		level.powned animscripted("deathanimloop", org, level.moodyfall_angles, level.scr_anim["powned"]["deathidle"]);
		level.powned waittillmatch ("deathanimloop","end");
	}
}

//=====================================================================================================================
//	event1_player_not_allowed
//
//		The player should not be in the wounded drop off area
//=====================================================================================================================
event1_player_not_allowed()
{
	level endon ("event1_moody_is_done");
	area = getent ("event1_player_not_allowed_trigger","targetname");
	while (1)
	{
		if (self istouching (area))
		{
			clip = getent ("event1_player_not_allowed_clip","targetname");
			movetime = .35;
			dummy = spawn ("script_origin",(level.player.origin));
			self playerlinkto (dummy);
			dummy moveTo((self.origin[0] + 120, self.origin[1], self.origin[2]), movetime, .05, .05);
			wait movetime;
			clip solid();
			self unlink();
			return;
		}
		else
		{
			wait (0.05);
		}
	}
}

//=====================================================================================================================
//	event1_is_player_blocking_rescue
//
//		Returns true if the player is blocking moodys path back to the putdown point
//=====================================================================================================================
event1_is_player_blocking_rescue(angles)
{
	area = getent ("event1_player_blocking_rescue","targetname");
	
	// is the player in the trigger at all?
	if (self istouching (area))
	{
		distance_to_moody = distance (level.player.origin, level.moody.origin );
		
		// now determine if the player is close to moody
		if ( distance_to_moody < 25 )
		{
			forwardvec = anglestoforward((0,angles[1],0));
			normalvec = vectorNormalize(level.player.origin, level.moody.origin );

			// now check to see if the player is infront of moody
			vectordotforward = vectordot(normalvec,forwardvec);

			// if the dot product is positive then the player is in front of moody
			if ( vectordotforward > 0.0 )
			{
				return true;
			}
		}
		
	}
	
	return false;
}

//=====================================================================================================================
//	event1_update_objective
//
//		Keeps the objective icon with the rescuer
//=====================================================================================================================
event1_update_objective()
{
	level endon ("event1_end");
	while (1)
	{
		objective_position(1,self.origin);
		wait 0.05;
	}
}

//=====================================================================================================================
//	event1_main_attack
//
//		This sets up the stage for the defend in event1.  Your guy "Pvt. Powned" runs up and gets shot 
//		necessitating a rescue.  The player will defend while one of the friendly rescues the private.
//=====================================================================================================================
event1_main_attack()
{
	level endon("event1_end");
	
	getent("event1_powned_go","targetname") waittill ("trigger");
	
	// release the main ai attacks

	// everyone else waits until powned gets to his spot
	level waittill("event1_powned_arrived");

	// mg42 guys
	//thread  maps\_squad_manager::manage_spawners("js_zeta",1,1,"event1_end",12, ::event1_squad_init_zeta );	
	level thread event1_mg42_spawners();


	// main enemy waves
	thread  maps\_squad_manager::manage_spawners("js_alpha",1,3,"event1_end",4, ::event1_squad_init_alpha);
	thread  maps\_squad_manager::manage_spawners("js_beta",1,4,"event1_end",4, ::event1_squad_init_beta);
}

//=====================================================================================================================
//	event1_vehicle_init()
//
//		Sets up the vehicle for event 1.
//=====================================================================================================================
event1_vehicle_init()
{
	event1_vehicle = getent("event1_vehicle","targetname");
	event1_vehicle_driver = getent("event1_vehicle_driver","targetname");
	event1_vehicle_mount_node = getnode("event1_vehicle_mount_node","targetname");
	event1_vehicle_path = getvehiclenode("event1_vehicle_path","targetname");
	event1_cresting_hill_trigger = getent("event1_player_cresting_hill","targetname");
	
	// make sure he goes to the node
	event1_vehicle_driver.bravery = 500000;
	event1_vehicle_driver.goalradius = 2;
	event1_vehicle_driver.pacifist = 1;
	event1_vehicle_driver.ignoreme = true;
    	event1_vehicle_driver.pacifistwait = 0; 
     	event1_vehicle_driver.playpainanim = false;		// this should keep the guy from reacting to pain
	event1_vehicle_driver thread maps\_utility_gmi::cant_shoot();
	event1_vehicle_driver thread maps\_utility::magic_bullet_shield();
 
	level endon("event1_end");
	event1_cresting_hill_trigger waittill("trigger");
	maps\bastogne2::dprintln("event1","^4VEHICLE DRIVER GO!");
	
	// run to the vehicle
	event1_vehicle_driver setgoalnode(event1_vehicle_mount_node);
	event1_vehicle_driver waittill("goal");
	
	// mount the vehicle
	event1_vehicle thread maps\_bmwbikedriver_gmi::main(event1_vehicle_driver);
	wait(0.25);
	
	// turn on the bmw
	playfxontag( level._effect["event1_bmw_headlight"], event1_vehicle,"tag_light");
	
	wait(1);
	// now send the vehicle off
	event1_vehicle attachpath( event1_vehicle_path );

//	level waittill("event1_powned_arrived");

	while(1)
	{
		if(level.flags["pown_start_bmw"] == true)
		{
			level.flags["pown_start_bmw"] = true;
			break;
		}
		wait 0.05;
	}
//	level waittill("event1_powned_owned");
 //	wait 1;

	event1_vehicle startpath();

	event1_vehicle waittill("reached_end_node");
	
	// go ahead and delete them
	stopattachedfx(event1_vehicle);
	
	// make sure the fx has time to delete
	wait(0.05);
	
	event1_vehicle_driver delete();
	event1_vehicle delete();
}

//=====================================================================================================================
//	event1_mg42_init()
//
//		Sets up the mg42 for event 1.
//=====================================================================================================================
event1_mg42_init()
{
	level.event1_mg42 = getent("zeta_mg42","targetname");
	// setting the turret range just short of the ridge line where all of the AI sit
	level.event1_mg42 setturretrange( 2200 );

//	level.event1_mg42 settargetentity(level.player);
	
	// wait until the first AI gets on the turret
	level.event1_mg42 waittill("turretownerchange");
	user = level.event1_mg42 getTurretOwner();

	// attack powned
	level.event1_mg42 thread event1_mg42_drop_powned(user);
	
	level waittill("event1_powned_owned");

	level.event1_mg42.script_accuracy = 0.5;
	level.event1_mg42.script_delay_min = 0.5;
	level.event1_mg42.script_delay_max = 1.5;
	level.event1_mg42.script_burst_min = 1;
	level.event1_mg42.script_burst_max = 3;
//	level.event1_mg42 notify ("stopfiring");
	level.event1_mg42 setmode("auto_ai"); // auto, auto_ai, manual
	
	if (isdefined (targ_org))
		targ_org delete();

	println("starting regular turret");
	// now the that the owned sequence has happend go to a more general firing functionality
	level.event1_mg42 thread event1_mg42_controller(user);
	level.event1_mg42 thread event1_mg42_used();
}

//=====================================================================================================================
//	event1_mg42_drop_powned()
//
//		starts the mg42 firing at powned.  This starts firing at a point between the turret and powned and then
//		tracks up until it hits him.
//=====================================================================================================================
event1_mg42_drop_powned(user)
{
	level endon("event1_powned_owned");
	
	// this guy will ignore pain until powned is down
	user.ignoreme = true;
    	user.pacifistwait = 0; 
     	user.playpainanim = false;		// this should keep the guy from reacting to pain
	user.health = 300;
	
	level waittill("event1_player_looking_at_powned");
	
	// do the sequence where we own powned
	
	// start the mg42 firing at a spot about quarter way between the gun and powned
	// then have the fire move twards powned
	endpoint = (level.powned.origin[0],level.powned.origin[1],level.powned.origin[2] + 30);
	startpoint = (endpoint - level.event1_mg42.origin);
	startpoint = level.event1_mg42.origin + ( startpoint[0] * 0.25, startpoint[1] * 0.25,startpoint[2] * 0.25 );

	direction = vectornormalize( endpoint - startpoint );
	dist = length( startpoint, endpoint );
	
	// make the target origin for the turret to fire at
	level.event1_mg42 setmode("manual_ai"); // auto, auto_ai, manual
	targ_org = spawn ("script_model", startpoint);
	level.event1_mg42 settargetentity(targ_org);
	user thread maps\_mg42::mg42_firing(level.event1_mg42);
	level.event1_mg42 notify ("startfiring");
	
	targ_org moveto(endpoint, 4, 0,0 );

	// event is done so set the user variables back
	user.ignoreme = false;
     	user.playpainanim = true;		// this should keep the guy from reacting to pain
}

//=====================================================================================================================
//	event1_mg42_used()
//
//		Waits till someone jumps on the mg42
//=====================================================================================================================
event1_mg42_used()
{
//	level endon("event1_end");
	
	while (1)
	{	
		self waittill("turretownerchange");
		
		user = self getTurretOwner();
		if (isdefined (user))
		{
			maps\bastogne2::dprintln("event1","AI using turret");
			
			// set up the new ai guy for using the turret
			self thread event1_mg42_controller(user);
		}
	}
}

//=====================================================================================================================
//	event1_mg42_controller()
//
//		Controls the mg42
//=====================================================================================================================
event1_mg42_controller(user)
{
	self endon("turretownerchange");
	
	// get the manual targets list and set them
	targets = getentarray( "event1_mg42_target", "targetname" );
//	random_index = randomint( targets.size );
//	self settargetentity(targets[random_index]);
//	self.manual_target = targets[random_index];
//	level.event1_mg42 notify ("startfiring");

	self setmode("auto_ai"); // auto, auto_ai, manual
	self.manual_target = undefined;
//	user thread maps\_mg42_gmi::burst_fire(self);
	
	// just loop over and over an pick a new target every once in a while
	for (;;)
	{
		random_index = randomint( targets.size );
		self settargetentity(targets[random_index]);
//		self startfiring();
		
		maps\bastogne2::dprintln("event1","new target " + targets[random_index].origin );
		// wait some amount of time before picking another target
		wait( 1 + randomfloat( 4 ) );
	}
	
}

//=====================================================================================================================
//	event1_squad_init_alpha()
//
//		Alpha squad is the squad which comes from behind the mg42 (zeta) squad.
//=====================================================================================================================
event1_squad_init_zeta()
{
	self.goalradius = 30;
	self.bravery = 1000;
	self.accuracy = 1;
	
	self thread maps\bastogne2::debug_cleanup_ai("event1_end", "event1_debug_cleanup");

	self thread event1_squad_kill_player();

	//self thread maps\_squad_manager::advance();
	wait 27;
	if(isalive(self))
	{
		self setgoalentity(level.player);
	}
}

//=====================================================================================================================
//	event1_squad_init_alpha()
//
//		Alpha squad is the squad which comes from behind the mg42 (zeta) squad.
//=====================================================================================================================
event1_squad_init_alpha()
{
	self.goalradius = 8;
	self.accuracy = 1;
	//self.bravery = 100;
	
	self thread maps\bastogne2::debug_cleanup_ai("event1_end", "event1_debug_cleanup");
	self thread event1_squad_kill_player();

	//self thread maps\_squad_manager::advance();
}

//=====================================================================================================================
//	event1_squad_init_beta()
//
//		Alpha squad is the squad which comes from behind the mg42 (zeta) squad.
//=====================================================================================================================
event1_squad_init_beta()
{
	self.goalradius = 8;
	self.accuracy = 1;
	//self.bravery = 100;
	
	self thread maps\bastogne2::debug_cleanup_ai("event1_end", "event1_debug_cleanup");
	self thread event1_squad_kill_player();

	//self thread maps\_squad_manager::advance();
}

//=====================================================================================================================
//	event1_squad_init_omnikron()
//
//		Omnikron squad is the squad is the agressive squad
//=====================================================================================================================
event1_squad_init_omnikron()
{
	self.goalradius = 128;
	self.bravery = 1000;
	
	self.favoriteenemy = level.player;
	
	self thread maps\bastogne2::debug_cleanup_ai("event1_end", "event1_debug_cleanup");
	self thread event1_squad_kill_player();

	self thread maps\_squad_manager::advance();
}

//=====================================================================================================================
//	event1_squad_kill_player()
//
//		Set the squad to kill the player immediatly.  This will be called if we want the player dead.
//=====================================================================================================================
event1_squad_kill_player()
{
	level endon("event1_end");
	
	level waittill("event1_kill_player");
	
	self.favoriteenemy = level.player;
}

//=====================================================================================================================
// * * * EVENT 1to2 * * * 
//
//	Event 1to2 encompasses the mopping the remaining event1 guys, following the motorcycle track, and then the
//	meeting before event2
//=====================================================================================================================

//=====================================================================================================================
//	event1to2_init
//
//		Sets up any thing that needs to be set up for event1 and threads all event1 functions
//=====================================================================================================================
event1to2_init()
{
	if(getCvar("scr_debug_event1to2") == "")		
		setCvar("scr_debug_event1to2", "1");	
	level.debug["event1to2"] = getcvarint("scr_debug_event1to2");
	
	// wait until event1 ends to set up the next event
	level waittill("objective_3_complete");

	// this is where you want to shut guys up from...
	
	// start the friendly chains for the area
	maps\_utility_gmi::chain_on("15");
	maps\_utility_gmi::chain_on("20");
	maps\_utility_gmi::chain_on("30");
	maps\_utility_gmi::chain_on("40");
	maps\_utility_gmi::chain_on("50");
	maps\_utility_gmi::chain_on("60");
	maps\_utility_gmi::chain_off("70");
	
	// threads
	level thread event1to2_cleanup_event1_area();
	level thread event1to2_meeting();
	level thread event1to2_advance_to_farmhouse();
	level thread event1to2_contact_parting();
	level thread event1to2_cleanup();

	wait 9;

	level.moody thread anim_single_solo(level.moody,"moody_keep_moving_forward");
	wait 3.6;
	level notify ("keep_moving_forward_done");
	println("^3 keep moving forward");
}

//=====================================================================================================================
//	event1to2_shutup
//
//		Cleans up any thing that needs to be cleaned up for event1to2
//=====================================================================================================================
event1to2_shutup()
{
	level waittill ("objective_3_complete");

	blue = getentarray("blue", "groupname");
	red = getentarray("red", "groupname");

	// have each of the guys move up to the contact setup position
	for(n=0;n<level.blue.size;n++)
	{
		if (!isAlive(level.blue[n]) )
			continue;
		level.blue[n] thread maps\bastogne2::friendly_turn_gen_talk_off("begin_clear_mg42_nest");
	}
	for(n=0;n<level.red.size;n++)
	{
		if (!isAlive(level.red[n]) )
			continue;

		level.red[n] thread maps\bastogne2::friendly_turn_gen_talk_off("begin_clear_mg42_nest");
	}
}

//=====================================================================================================================
//	event1to2_cleanup
//
//		Cleans up any thing that needs to be cleaned up for event1to2
//=====================================================================================================================
event1to2_cleanup()
{
	level waittill("event1to2_end");

	maps\_utility_gmi::chain_off("15");
	maps\_utility_gmi::chain_off("20");
	maps\_utility_gmi::chain_off("30");
	maps\_utility_gmi::chain_off("40");
	maps\_utility_gmi::chain_off("50");
	maps\_utility_gmi::chain_off("60");
	maps\_utility_gmi::chain_off("70");
}

//=====================================================================================================================
//	event1to2_cleanup_event1_area
//
//		Start the AI guys advancing and have them clean up the remaining guys
//=====================================================================================================================
event1to2_cleanup_event1_area()
{
	maps\bastogne2::util_squad1_follow_player();
}

//=====================================================================================================================
//	event1to2_meeting
//
//		When the player gets to the meeting trigger all of the ai guys advance and congregate at the meeting point
//=====================================================================================================================
#using_animtree("generic_human");
event1to2_meeting()
{
	level endon("event1to2_end");
	level endon("player_runs_away_from_event"); // bypass dialogue when the player continues forward
	
	trigger = getent("event1to2_meeting_trigger","targetname");
	
	trigger waittill("trigger");

	wait 2;
	level.blue[2] thread anim_single_solo(level.blue[2],"anderson_sarge");
	wait 1.1;
	level.blue[0] thread anim_single_solo(level.blue[0],"moody_not_now");
	wait 0.6;
	
	// have all the guys go to their spots
	if ( isAlive(level.blue[0]) )
		level.blue[0] thread event1to2_meeting_ai("event1to2_meet_spot_1");
	if ( isAlive(level.blue[1]) )
		level.blue[1] thread event1to2_meeting_ai("event1to2_meet_spot_2");
	if ( isAlive(level.blue[2]) )
		level.blue[2] thread event1to2_meeting_ai("event1to2_meet_spot_3");
	
	if ( isAlive(level.red[0]) )
		level.red[0] thread event1to2_meeting_ai("event1to2_meet_spot_4");
	if ( isAlive(level.red[1]) )
		level.red[1] thread event1to2_meeting_ai("event1to2_meet_spot_5");

	level.blue[0] waittill("goal");

	// moody should do an anim and stop the men
	
	wait 0.5;	
	
	maps\bastogne2::util_group_allowedstance("blue","crouch","prone");
	maps\bastogne2::util_group_allowedstance("red","crouch","prone");
	
	// foliage rustling noises
	level.moody thread anim_single_solo(level.moody,"moody_hold");
	contact = getent("event1to2_contact","targetname");
	contact allowedstances("stand");
//  COCK remember to move the mortar away from where goldberg is.. that's what is knocking him off.
     	contact.playpainanim = false;	
     	contact.ignoreme = true;	
	contact.animname = "gunner_30cal";
	wait 1;
	contact playsound("movement_foliage");
	wait 1;
	contact playsound("movement_foliage");
	
	// this is where they are going to put in the fix to push the map forward	
	
	// password sequence
	wait 2;
	level.moody thread anim_single_solo(level.moody,"moody_lucky");
	wait 1;
	contact thread anim_single_solo(contact,"gunner_30cal_strike");
	println("^3 **************  was here and he can kiss my ass ***********");


	// guy runs out of the trees
	node = getnode( "event1to2_contact_meeting_node","targetname");
	contact setgoalnode( node );
	contact.goalradius = 2;
	
	contact waittill("goal");
	
	// moody and contact talk
//	wait 4;

	level.scr_anim["gunner_30cal"]["gunner_30cal_dugin"]		= (%c_us_bastogne2_gunner_30cal_dugin);

	level.scr_notetrack["gunner_30cal"][0]["notetrack"]		= "gunner_30cal_dugin";
	level.scr_notetrack["gunner_30cal"][0]["dialogue"]		= "gunner_30cal_dugin";
	level.scr_notetrack["gunner_30cal"][0]["facial"]		= (%f_bastogne2_gunner_30cal_dugin);

	contact thread anim_single_solo(contact,"gunner_30cal_dugin");
//	wait 6.5;
	level.scr_anim["moody"]["moody_terrific"]		= (%c_us_bastogne2_moody_terrific);

	level.scr_notetrack["moody"][0]["notetrack"]		= "moody_terrific";
	level.scr_notetrack["moody"][0]["dialogue"]		= "moody_terrific";
	level.scr_notetrack["moody"][0]["facial"]		= (%f_bastogne2_moody_terrific);

//	wait 0.05;
//	contact thread anim_single_solo(level.moody,"moody_terrific");
	level.moody thread anim_single_solo(level.moody,"moody_terrific");
	wait 12.5;

	contact thread anim_loop_solo(contact,"sit_idle", undefined, "end anim");
	
	// meeting is over
	level notify("event1to2_meeting_done");
}

//=====================================================================================================================
//	bypass_meeting
//
//		Controls each ai guy and handles him during the meeting
//=====================================================================================================================

bypass_meeting() // player running by event
{
	trigger = getent("event1to2_meeting_trigger","targetname");	
	trigger waittill("trigger");

	wait 4;
	while(1)
	{


			if (distance (level.player getorigin(), level.blue[0].origin) > 1000)	
			{
				level notify("player_runs_away_from_event"); // bypass dialogue when the player continues forward								
				level notify("event1to2_meeting_done");	
				break;
			}
			wait 0.05;

	}
}

//=====================================================================================================================
//	event1to2_meeting_ai
//
//		Controls each ai guy and handles him during the meeting
//=====================================================================================================================
event1to2_meeting_ai( spot )
{
	oldgoalradius = self.goalradius;
	self.goalradius = 2;
	
	// go to the spot
	self setgoalnode( getnode(spot,"targetname") );
	self waittill("goal");
	
	self allowedstances("crouch");
	
	// wait until the meeting done
	level waittill("event1to2_meeting_done");
	
	// restore the old parameters
	self.goalradius = oldgoalradius;
	self allowedstances("stand", "crouch", "prone");
}

//=====================================================================================================================
//	event1to2_advance_to_farmhouse
//
//		After the meeting is over the men start moving to the farmhouse
//=====================================================================================================================
event1to2_advance_to_farmhouse()
{
	level endon("event1to2_end");
	
	// wait until the meeting is concluded 
	level waittill("event1to2_meeting_done");

	// get all of the ai on the friendly chains
	maps\bastogne2::util_squad1_follow_player();

	// turn on the friendly chain
	maps\_utility_gmi::chain_on("70");


	fence = getent ("goldberg_fence", "targetname");
	fnode = getnode("open_goldberg_fence", "targetname");
	level.blue[0] setgoalnode(fnode);
	level.blue[0] waittill("goal");	// getst into position
	wait 1;
	level.moody thread anim_single_solo(level.moody,"kickdoor");
	level.moody waittillmatch ("single anim", "kick");
	fence playsound ("gate_open_fast");
	fence connectpaths();
//	fence rotateroll(-93, 0.3,0,0.3);
	fence rotateyaw(-93, 0.3,0,0.3);
	level.moody setgoalentity(level.player);


	level thread maps\bastogne2_event2and3::event2_mg42_support_guy_spawn();
	level thread maps\bastogne2_event2and3::event2_farmhouse_goes_alert();
	level thread maps\bastogne2_event2and3::event3_mortars();
	

	// have the contact join our party for a bit
	contact = getent("event1to2_contact","targetname");
	contact notify("end anim");
	contact allowedstances("crouch", "prone", "stand");
	contact setgoalentity(level.player);
	contact.goalradius = 256;
	// jeremy add 05/24/05
	level thread event2_friendly_ai_setup(); // makes everyone pacifist until I need to pull them out.
}

//=====================================================================================================================
//	event1to2_contact_parting
//
//		After reaching the edge of the field the contact will peel off to the left but the players squad will 
//		head to the right
//=====================================================================================================================
event1to2_contact_parting()
{
	level endon("event1to2_end");
	
	trigger = getent("event1to2_event_end","targetname");

	println("^3 ************** event1to2_contact_parting *******************");
		
	trigger waittill("trigger");

	level thread player_gets_to_spot_first();
//	level notify("player can now fire early function");
	level thread maps\bastogne2_event2and3::event2_player_fires_early(); // function that is called from here only.

	// jeremy add 05/24/05
	blue = getentarray("blue", "groupname");

	// have each of the guys move up to the contact setup position
	for(n=0;n<level.blue.size;n++)
	{
		if (!isAlive(level.blue[n]) )
			continue;
			
		myspot = getnode("event2_skipto_"+(n+1), "targetname");
		level.blue[n] setgoalnode (myspot);
	}
	for(n=0;n<level.red.size;n++)
	{
		if (!isAlive(level.red[n]) )
			continue;

		myspot = getnode("event2_skipto_" + (n + level.blue.size + 1), "targetname");
		level.red[n] teleport (myspot.origin);
	}

	// have the contact move to his position
	contact = getent("event1to2_contact","targetname");
	contact setgoalnode(getnode("event2_skipto_6", "targetname"));

	// when moody gets to the goal point then have him halt the squad
//	level.moody waittill("goal");
	
	// moody should do an anim and stop the men
	
	wait 0.5;	
	
	maps\bastogne2::util_group_allowedstance("blue","crouch","prone");
	maps\bastogne2::util_group_allowedstance("red","crouch","prone");
	
///	iprintlnbold("Hillfinger you deploy here.");
//	wait 2;
	
	
	contact setgoalnode( getnode("event1to2_contact_setup", "targetname"));
	contact.goalradius = 2;
     	contact.playpainanim = false;
	
	// have the guy deploy
	contact.script_dontdeploy = 0;

	// send out the notify to end this event and begin the next
	level notify("event1to2_end");
	level thread event1_team_follow();
	contact endon ("stop magic bullet shield");
}

event1_moody_letsgo() // talking down the paths...
{
	level endon("event1to2_end");
	getent("moody_letsgo","targetname") waittill ("trigger");
//	level.moody thread anim_single_solo(level.moody,"moody_get_moving");
	//level notify("objective_3_complete");
}

event1_team_follow()
{
	level waittill("flares_over");

	for(n=0;n<level.blue.size;n++)
	{
		if (isalive(level.blue[n]))
		{
			level.blue[n] setgoalentity (level.player);
		}
	}
	
	for(n=0;n<level.blue.size;n++)
	{
		if (isalive(level.red[n]))
		{
			level.red[n] setgoalentity (level.player);
		}
	}
}

//==========================================================================
// I force all allies to not fire because they were in to many places...
//==========================================================================
event2_friendly_ai_setup()
{
	ai = getaiarray ("allies");
	for (i=0;i<ai.size;i++)
	{
		ai[i].pacifist = 1;
	}
}

//=====================================================================================================================
//	event1to2_friendly_setup()
//
//		Sets up friendly ai for the first event
//=====================================================================================================================
event1to2_friendly_setup()
{
	//
	//  contact
	//
	contact = getent("event1to2_contact", "targetname");
	contact character\_utility::new();

	contact.name = "Pvt. Goldberg";
//	contact thread maps\bastogne2::util_dont_ff_me();
	contact.animname = "contact";

	contact [[level.scr_character[contact.animname]]]();
	contact.pacifist = 1;
	contact thread maps\bastogne2::util_dont_ff_me();
	contact.dontdropweapon = 1;	

	// turns god mode on so if the player starts the event early (flare-fire early), then he stays alive untill his node is reached.
	contact thread maps\_utility_gmi::magic_bullet_shield(); // for Nick
//	contact thread maps\bastogne2::friendly_damage_penalty();
	contact.goalradius = 2;
	contact.followmax = 3;
	
	contact.bravery = 500;
	contact allowedstances("crouch");
}

event1_clear_forest_chain()
{
	level waittill("event1_end");
	
	level.moody setgoalentity (level.player);	


	if ( isAlive(level.red[0]) )
		level.red[0] setgoalentity (level.player);
	if ( isAlive(level.red[1]) )
		level.red[1] setgoalentity (level.player);
	
	chain = maps\_utility::get_friendly_chain_node ("15");
	level.player SetFriendlyChain (chain);	
}

event1_clear_forest_chain_done()
{
	level waittill("objectve_3_completed");
	
	chain = maps\_utility::get_friendly_chain_node ("20");
	level.player SetFriendlyChain (chain);	


	level.moody setgoalentity (level.player);
	level.moody.followmin = 4; 
	level.moody.followmax = 0;

}

event1_clear_forest()
{
	level waittill ("event1_end");
	ai1 = maps\_squad_manager::alive_array("js_beta");
	ai2 = maps\_squad_manager::alive_array("js_alpha");
	//ai3 = maps\_squad_manager::alive_array("js_zeta");
	ai3 = getentarray("duder","targetname");
	
	alive_flag = 0;

	while (alive_flag == false)
	{
		alive_count = 0;
		for (i=0;i<ai1.size;i++)
		{
			if (isalive(ai1[i]))
			{
				alive_count++;
			}
		}
		
		for (i=0;i<ai2.size;i++)
		{
			if (isalive(ai2[i]))
			{
				alive_count++;
			}
		}
		
		for (i=0;i<ai3.size;i++)
		{
			if (isalive(ai3[i]))
			{
				alive_count++;
			}
		}
		
		if (alive_count == 0)
		{
			alive_flag = true;
		}
		wait 0.05;
	}
	wait 2;
	level.moody thread anim_single_solo(level.moody,"moody_surprise");
	level notify ("objective_3_complete");
}

walkies()
{
	self allowedstances("stand");
	self.pacifist = 1;
	self.goalradius = 0;
	self.walkdist = 9999;
	patrolwalk[0] = %patrolwalk_bounce;
	patrolwalk[1] = %patrolwalk_tired;
	patrolwalk[2] = %patrolwalk_swagger;
	//self.walk_noncombatanim_old = self.walk_noncombatanim;
	//self.walk_noncombatanim2_old = self.walk_noncombatanim2;
	self.walk_noncombatanim = maps\_utility_gmi::random(patrolwalk);
	self.walk_noncombatanim2 = maps\_utility_gmi::random(patrolwalk);
	//self animscriptedloop("scripted_animdone", self.origin, self.angles, self.walk_noncombatanim);
}	

walkies_off()
{
	getent("event1_player_cresting_hill","targetname") waittill ("trigger");
	
	guys = getaiarray("allies");
	
	for (i=0;i<guys.size;i++)
	{
		if (isalive(guys[i]))
		{ 
			guys[i].pacifist = false;
			guys[i] allowedstances("stand","crouch","prone");
			guys[i].walk_noncombatanim = guys[i].walk_noncombatanim_old;
			guys[i].walk_noncombatanim2 = guys[i].walk_noncombatanim2_old;
			guys[i].walkdist = 0;
			guys[i].goalradius = 8;
		}
	}
}

anim_single_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
 	maps\_anim_gmi::anim_single (newguy, anime, tag, node, tag_entity);
}

table_map_anim()
{
	map = getent("map", "targetname");
	map.animname = "map";
	map UseAnimTree(level.scr_animtree[map.animname]);
	
	table = getent ("table","targetname");
	map thread anim_single_solo(map, "map_anim", undefined, table);
}

event1_fadein_fix()
{
	level.blackoutelem = newHudElem();
	level.blackoutelem setShader("black", 640, 480);
	
	println("It goes black!");
	
	level.blackoutelem.alpha = 1;

	wait 2;
	
	level.blackoutelem fadeOverTime(1.5); 
	level.blackoutelem.alpha = 0;
}

event1_blast()
{
	level waittill("event1_powned_arrived");
	blast = getent ("blast_powned","targetname");
	thread event1_wounded_idle(); // has to move this here to make sure they guy got hurt and was in the right spot after smoke
	blast playSound ("shell_explosion1");
	playfx (level._effect["blast_powned"], blast.origin);
	playfx (level._effect["blast_powned2"], blast.origin);
}

player_hits_trigger_force()
{
	getent("force_powned","targetname") waittill ("trigger");
	level notify("event1_powned_arrived");
}

event1_walk_and_talk() // got guys working just need to get moody working now..
{
	trig1 = getent("walky_talky_start","targetname");
	trig2 = getent("walky_talky_go","targetname");

	while(!(level.player istouching(trig1)))
//	while(!(level.blue[0] istouching(trig1)))
	{
		wait 0.05;
	}


	level.powned setgoalnode( getnode("event1_powned_chase_driver","targetname") );


//	// make this ai go to one node that waits for the player to get closer before making the event start	
//	level.powned setgoalentity(level.player);
//	level.powned.followmax = 4;


	while(!(level.player istouching(trig2)))
//	while(!(level.blue[0] istouching(trig2)))
	{
		wait 0.05;
	}

	// lines go here
	
	
	level.blue[0] setgoalentity(level.player);	
	level.blue[1] setgoalentity(level.player);
	level.blue[2] setgoalentity(level.player);



//	getent("event1_powned_go","targetname") waittill ("trigger");

// calls it to early
	getent("event1_player_cresting_hill","targetname") waittill ("trigger"); // this makes ai run to position
	level.powned allowedstances("stand");

	println(" ^6 ***** player has passed through event1_powned_go*********");
	println(" ^6 ***** player has passed through event1_powned_go*********");
	println(" ^6 ***** player has passed through event1_powned_go*********");
	println(" ^6 ***** player has passed through event1_powned_go*********");
	println(" ^6 ***** player has passed through event1_powned_go*********");
	println(" ^6 ***** player has passed through event1_powned_go*********");

	node = getnode("powned_goal","targetname");
	level.powned setgoalnode(node,"targetname");
}

event1_talk_think() // start this in the right place... make the player start this conversation..
{
//	level waittill ("speeches over");
	getent("walky_talky_start","targetname") waittill ("trigger");

//	wait 3;
//	animnames[0] = "moody";
//	animnames[1] = "whitney";
//	animnames[2] = "anderson";
	wait 3;

	level.blue[1] thread anim_single_solo(level.blue[1],"whitney_ohman");
	wait 2;
	level.blue[2] thread anim_single_solo(level.blue[2],"anderson_what");
	wait 2;
	level.blue[1] thread anim_single_solo(level.blue[1],"whitney_freezin");
	wait 3;
//	level.blue[0] thread anim_single_solo(level.blue[0],"moody_lookin_good");
	level.blue[0] thread anim_single_solo(level.blue[0],"moody_shaddup");
}

event1_mg42_spawners()
{
	level endon ("event1_end");
	
	spawn1 = getent("event1_mg42_1","targetname");
	spawn2 = getent("event1_mg42_2","targetname");
	
	guy = spawn1 stalingradspawn();
	guy waittill ("finished spawning");
	guy.bravery = 50000;
	guy allowedstances("stand");
	guy.targetname = "duder";
	
	guy waittill("death");
	
	wait 10;
	guy = spawn2 stalingradspawn();
	guy waittill ("finished spawning");
	guy.bravery = 50000;
	guy allowedstances("stand");
	guy.targetname = "duder";
	
	guy waittill("death");
	
	wait 15;
	guy = spawn1 stalingradspawn();
	guy waittill ("finished spawning");
	guy.bravery = 50000;
	guy allowedstances("stand");
	guy.targetname = "duder";
}


// jl this is just a test to see if the trigger is making into the editor
test()
{
//	getent("poop","targetname") waittill ("trigger");
}

//=====================================================================================================================
//	event1_beg_squads()
//
//		
//=====================================================================================================================
event1_beg_squads()
{
}


event1_squad2_setup()	// guys near truck
{
	level waittill ("speeches over"); 
	wait 4;
//	allies2_array =[];// this defines it as an array
	allies_group = getentarray("beg_squad2", "groupname");

	for(i=0;i<(allies_group.size);i++)//		
	{
//		allies2_array[i] = getent("beg_squad2_" + i, "targetname");
		allies2_array_ai[i] = allies_group[i] stalingradspawn();
		allies2_array_ai[i] waittill ("finished spawning");
		allies2_array_ai[i].pacifist = true;
		allies2_array_ai[i].accuracy = 0;
		allies2_array_ai[i] allowedstances("crouch");
		allies2_array_ai[i] thread e2_node(i);
	}
}

e2_node(i)
{
	getent("walky_talky_go","targetname") waittill ("trigger");

	if(isalive(self))
	{	
		wait (0.2 + randomfloat (0.9));		
		node = getnode("event1_squad2_guy_node_" + i, "targetname");
		self setgoalnode(node);
		self waittill("goal");
		self.pacifist = false;


		wait (3.3 + randomfloat (7.3));
	//	level waittill ("beg_sqauds_move_up");

		node = getnode("event1_squad2_guy_node2_delete", "targetname");
		self setgoalnode(node);
		self waittill("goal");
	}

	if(isalive(self))
	{
		wait 15;
		self delete();
	}
}

event1_squad3_setup()	// guys near truck
{
	level waittill ("speeches over"); 
	wait 4;
//	allies3_array =[];// this defines it as an array
	allies3_group = getentarray("beg_squad3", "groupname");

	for(i=0;i<(allies3_group.size);i++)//		
	{
//		allies3_array[i] = getent("beg_squad3_" + i, "targetname");
		allies3_array_ai[i] = allies3_group[i] stalingradspawn();
		allies3_array_ai[i] waittill ("finished spawning");
		allies3_array_ai[i].pacifist = true;
		allies3_array_ai[i].accuracy = 0;
		allies3_array_ai[i] allowedstances("crouch");
		allies3_array_ai[i] thread e3_node(i);
	}
}

e3_node(i)
{
	getent("walky_talky_go","targetname") waittill ("trigger");

	if(isalive(self))
	{	
		wait (0.2 + randomfloat (0.9));		
		node = getnode("event1_squad3_guy_node_" + i, "targetname");
		self setgoalnode(node);
		self waittill("goal");
		self.pacifist = false;

		wait (3.3 + randomfloat (5.3));	
//		level waittill ("beg_sqauds_move_up");

		node = getnode("event1_squad3_guy_node2_delete", "targetname");
		self setgoalnode(node);
		self waittill("goal");
	}

	if(isalive(self))
	{
		wait 15;
		self delete();
	}
}

player_gets_to_spot_first() // new addon
{
	getent("start_flare_event_player","targetname") waittill ("trigger");
	level waittill("team_wait_on_car");
}

anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_loop ( newguy, anime, tag, ender, node, tag_entity );
}