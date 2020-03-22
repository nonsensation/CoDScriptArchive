//=====================================================================================================================
// Bastogne2_event2and2
//	
//	CONTAINS EVENTS:
//
//		EVENT2	- assault of farmhouse yard and disabling the artillery
//		EVENT3	- assault of farmhouse and capture of german officer
//
//=====================================================================================================================

//=====================================================================================================================
// * * * EVENT 2 * * * 
//
//	Event 2 encompasses the assault of the farm house, including the initial assault up the right side of the field,
//	up to the taking out of the artillery
//=====================================================================================================================

//=====================================================================================================================
//	event2_init
//
//		Sets up any thing that needs to be set up for event2 and threads all event2 functions
//=====================================================================================================================
event2_init()
{
	level.flags["bomb1_done"] = false;
	
	if(getCvar("scr_debug_event2") == "")		
		setCvar("scr_debug_event2", "1");	
	level.debug["event2"] = getcvarint("scr_debug_event2");
	
	// process the skipto
	level thread event2_debug_skipto();


	println("^3 *************  waiting for event1to2_end ");	
	// wait until maps\bastogne2_event1to2::event1 ends to set up the next event
	level waittill("event1to2_end");
	
	wait (0.1);
	
	level notify("event2_begin");

	level.flags["germans_alerted"] = false;

	// start the friendly chains for the area
//	maps\_utility_gmi::chain_on("80");  // turned this so it does not start till after the flares have gone.
	maps\_utility_gmi::chain_on("90");
	maps\_utility_gmi::chain_on("100");

	println("^3 *************   event1to2_end  chain 100 on ");
	
	// threads

	level thread event2_player_in_field();
//	level thread event2_farmhouse_goes_alert();
	level thread event2_vehicle_init();
	level thread event2_mg42s_init();
//	level thread event2_player_fires_early(); // function that is called from here only.
//	level thread event2_mg42_support_guy_spawn();
	level thread event2_moodys_they_know_we_are_here_speach();
	level thread event2_cleanup();
	level thread event3_bomb_hide();
	level thread event3_garage_spawner();
	level thread event3_courtyard_spawner();
	level thread event3_pak43_death();
	level thread event3_bomber1_think();
	level thread event3_bomber2_think();
	level thread event3_moveto_garage();
	level thread event3_movethrough_garage();
	level thread event3_move_bomb1_planted();
	level thread event3_move_bomb2_planted();
	level thread event3_shutdown_ambient_battle_pak43();
	level thread event3_moody_usenades();
	level thread event3_moody_spike88();
	level thread event3_moody_threats();
	level thread event3_german_second_story();
	level thread event3_clear_outside_forest();
	level thread event3_support_pack43_advance();
	level thread event4_moody_back_of_house();
//	level thread trucks_health();
//	level thread event3_mortars();
	// sets the intenssity of the mortars
}

//=====================================================================================================================
//	event2_cleanup
//
//		Sets up the event if we are skipping to it from the begining
//=====================================================================================================================
event2_debug_skipto()
{
	level endon("event2_end");
	
	if ( getcvar("skipto") == "event2" )
	{
		setcvar("skipto","none");
		wait(0.1);
		
		// make sure the first events are killed
		level notify("event1to2_end");
		level notify("event2_end");
		
		// delete anybody that may remain from the begining of the level
		maps\bastogne2_event1to2::event1_debug_cleanup();

		// move each of the characters to the appropriate starting position
		org = getnode("event2_skipto_player", "targetname");

		// move the player  underground so he can not see the teleports
		level.player setorigin( (0,0,-10000) );

		for(n=0;n<level.blue.size;n++)
		{
			myspot = getnode("event2_skipto_"+(n+1), "targetname");
			level.blue[n] teleport (myspot.origin);
		}
		for(n=0;n<level.red.size;n++)
		{
			myspot = getnode("event2_skipto_" + (n + level.blue.size + 1), "targetname");
			level.red[n] teleport (myspot.origin);
		}

		// let blue group stand
		maps\bastogne2::util_group_allowedstance("blue","stand","crouch","prone");
		
		// we want to move the contact to his final spot here
		contact = getent("event1to2_contact","targetname");
		myspot = getnode("event1to2_contact_setup", "targetname");
     		contact.playpainanim = false;
		contact teleport (myspot.origin);
		contact setgoalnode(myspot);
		// have the guy deploy
		contact.script_dontdeploy = 0;
		
		// move player to their position
		level.player setorigin( org.origin );
	}
}

//=====================================================================================================================
//	event2_cleanup
//
//		Cleans up any thing that needs to be cleaned up for event2
//=====================================================================================================================
event2_cleanup()
{
	level waittill("event2_end");

//	maps\_utility_gmi::chain_off("20");

	// send out the mission success notify so we end the level
//	level notify("mission success");
}

//=====================================================================================================================
//	event2_debug_cleanup
//
//		Cleans up any thing that needs to be cleaned up for event2 if this event is skipped.  Cleans up all 
//		previous events as well
//=====================================================================================================================
event2_debug_cleanup()
{
	// clean up all event1 stuff
	maps\bastogne2_event1to2::event1_debug_cleanup();
		
	// now clean up anything from event2
	level notify("event2_end");
}

//=====================================================================================================================
//	event2_friendly_setup()
//
//		Sets up friendly ai for the second
//=====================================================================================================================
event2_friendly_setup()
{
}

//=====================================================================================================================
//	event2_player_in_field
//
//		If the player enters the field before the vehicle gets to the farmhouse stir the ants nest sooner
//=====================================================================================================================
event2_player_in_field()
{
	level endon("event2_end");
	level endon("event2_farmhouse_on_alert");
	
	trigger = getent("event2_player_in_field_trigger","targetname");
	
	trigger waittill("trigger");
	
	maps\bastogne2::dprintln("event2","^1Player in field");

	// send out the message to cause the farmhouse to go on alert
	level notify("event2_farmhouse_on_alert");
}


//=====================================================================================================================
//	player_fires_early
//
//		When something happens to alert the farmhouse of the americans then everything gets busy
//=====================================================================================================================
event2_player_fires_early()
{
	level thread event2_player_gets_ahead_of_squad();
	println("^4 *********** waiting for player to fire early ********************");
//	level waittill("player can now fire early function"); // waits for appropriate function to call it
	while (1)
	{
		if(level.player attackButtonPressed())
		{
			println("^3 *********** PLayer fired early ********************");
			println("^3 *********** PLayer fired early ********************");
			println("^3 *********** PLayer fired early ********************");
			println("^3 *********** PLayer fired early ********************");
			level notify ("support_squad_move");
			level notify ("team_wait_on_car"); // player fired his gun early...
			break;
		}
		wait 0.05;

	}
//	iprintlnbold(&"GMI_BASTOGNE2_TEMP_FIRE_EARLY");
}

event2_player_gets_ahead_of_squad()
{
//	while (1)
//	{
//		if (distance (level.player getorigin(), level.blue[0].origin) > 1300)	
//		{
//			println("^3 *********** PLayer tried to sneak ahead ********************");
//			println("^3 *********** PLayer tried to sneak ahead ********************");
//			println("^3 *********** PLayer tried to sneak ahead ********************");
//			println("^3 *********** PLayer tried to sneak ahead ********************");
//			level notify ("support_squad_move");
//			level notify ("team_wait_on_car"); // player fired his gun early...
//			break;
//		}
//		wait 0.05;
//
//	}
}


//=====================================================================================================================
//	event2_farmhouse_goes_alert
//
//		When something happens to alert the farmhouse of the americans then everything gets busy
//=====================================================================================================================
event2_farmhouse_goes_alert() // make sure the player trigger the flare event if he is forward -- just place a trigger break up code...
{
	level endon("event2_end");

	self thread kill_me_when_player_enters_court();
	
	// get the mg42 guys into non fighting mode
	mg42_field_guy = getent("event2_mg42_field_guy","targetname");
	if(isalive(mg42_field_guy))
	{
		mg42_field_guy.pacifist = 1;
	}
	
	mg42_side_guy = getent("event2_mg42_side_guy","targetname");
	
	if(isalive(mg42_side_guy))
	{
		mg42_side_guy.pacifist = 1;
	}

	// wait until notification comes in to go to alert status
	// jeremy added 05/24/05

	println("^2************  waiting for either the player to shoot early or event to progress normaly********");
	println("^2************  waiting for either the player to shoot early or event to progress normaly********");
	println("^2************  waiting for either the player to shoot early or event to progress normaly********");
	println("^2************  waiting for either the player to shoot early or event to progress normaly********");
	println("^2************  waiting for either the player to shoot early or event to progress normaly********");

	level waittill("team_wait_on_car");

	if(level.flag ["farm_alerted_once"] == true) // added jeremy june/03/04 -- so it can only get called twice.
	{
	        return;
	}
	level.flag["farm_alerted_once"] = true;

	wait 2;
	
	level thread event2_launch_flares(); // playsound flare now.
	level thread  maps\_squad_manager::manage_spawners("event2_squad1_a_axis",2,8 ,"event2_squad1_wave_a_end",2, ::event2_squad1_axis_init );


	wait 6;

	// main enemy wave for the second squad to fight -- allies
	level thread  maps\_squad_manager::manage_spawners("event2_squad2_a_axis",3,6,"event2_end_special",2, ::event2_squad2_axis_init);

	// squad2 
	level thread  maps\_squad_manager::manage_spawners("event2_squad2_a",3,6 ,"event2_end",2, ::event2_squad2_init );
	
	// squad1 enemies 
//	level thread  maps\_squad_manager::manage_spawners("event2_squad1_a_axis",2,8 ,"event2_squad1_wave_a_end",2, ::event2_squad1_axis_init );
	level thread event2_squad1_wave_a_ender();
	
	// get the mg42 guys into fighting mode
	if(isalive(mg42_field_guy))
	{
		mg42_field_guy.pacifist = 0;
	}
	if(isalive(mg42_side_guy))
	{
		mg42_side_guy.pacifist = 0;
	}

	level thread event2_friendly_ai_attack();

	level notify ("begin_clear_mg42_nest");


	contact = getent("event1to2_contact","targetname");
//   	wait 14;
//     	contact.ignoreme = false;
}

kill_me_when_player_enters_court()
{
	level notify ("kill_field_mg42");

	if(isalive(self))
	{
		self DoDamage (self.health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
	}
	
}

//==========================================================================
// jeremy added 05/27/05
// MAke voices heard in field as germans yell to each other
//==========================================================================
german_yell(angle1)
{
//	angle1 = (1615,15760,161);
//	angle2 = (1680,16304,161);
//	angle2 = (965,-1518,64);
	german_cart = (1802,4383,133);

	german_88_left = (6505,3186,112);
	german_88_center = (6338,2590,101);
	german_88_center = (5425,3440,85);

	german_yell_1 = spawn("script_origin",(angle1));
	german_yell_2 = spawn("script_origin",(angle1));
	german_yell_3 = spawn("script_origin",(angle1));

	for(i=0;i<20;i++)
	{
		wait (0.1 + randomfloat (0.4));	
		println("^3 ***************  german yells"        + i);
		german_yell_1 playsound("generic_misccombat_german_1");
		wait 2;
		german_yell_2 playsound("generic_misccombat_german_2");
		wait 2;
		german_yell_3 playsound("generic_flankright_german_2");
	}
}

//==========================================================================
// jeremy added 05/26/05
// I force all allies attack now
//==========================================================================
event2_friendly_ai_attack()
{
	ai = getaiarray ("allies");
	for (i=0;i<ai.size;i++)
	{
		ai[i].pacifist = 0;
	}
	
	wait 6;
	maps\_utility_gmi::chain_on("80");  // turned this so it does not start till after the flares have gone.
	wait 0.05;
	level thread maps\bastogne2::util_squad1_follow_player();
}

//=====================================================================================================================
//	event2_squad2_axis_init()
//
//		These are guys who squad2 fights when they advance on the house.
//=====================================================================================================================
event2_squad2_axis_init()
{
	self.goalradius = 128;
	self.bravery = 1;
	
	self allowedstances("crouch","prone");
	self thread maps\bastogne2::debug_cleanup_ai("event2_end", "event2_debug_cleanup");

	self thread maps\_squad_manager::advance();


		
	level waittill ("bomb 2 went off");

	level notify ("event2_end_special");	
	level notify ("event2_end");

//	ai_axis = getentarray("event2_squad2_a_axis", "script_squadname");
////	ai_axis = getaiarray ("axis");
//	for (i=0;i<ai_axis.size;i++)
//	{
//		ai_axis[i] DoDamage ( ai_axis[i].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
//	}
}

//=====================================================================================================================
//	event2_squad2_axis_init()
//
//		These are guys who squad2 fights when they advance on the house.
//=====================================================================================================================
event2_squad1_axis_init()
{
	self.goalradius = 128;
	self.bravery = 1;
	
	self allowedstances("crouch","prone");
	self thread maps\bastogne2::debug_cleanup_ai("event2_end", "event2_debug_cleanup");

	self thread maps\_squad_manager::advance();
}

//=====================================================================================================================
//	event2_squad2_init()
//
//		These are guys who squad2 fights when they advance on the house.
//=====================================================================================================================
event2_squad2_init()
{
	self.goalradius = 128;
	self.bravery = 1;
	self thread maps\bastogne2::friendly_damage_penalty();
	self allowedstances("crouch","prone");
	self thread maps\bastogne2::debug_cleanup_ai("event2_end", "event2_debug_cleanup");

	self thread maps\_squad_manager::advance();

	self thread follow_up_battle();
	self thread delete_squad2();
}

follow_up_battle()
{
	level waittill ("bomb 2 went off");


	if(isalive(self))
	{
//				pink = getentarray("event2_squad2_a", "squadname");				
//				for(n=0; n<pink.size; n++)
//				{
//							guy = pink[n];
////							guy thread maps\_utility_gmi::magic_bullet_shield();
//							guy.targetname = squad2_guy1[i].targetname +"_guy";
//							guy thread pak43_blown_new_spot();
//				}
		self.pacifist = 1;
		fnode = getnode("squad2_pak43_blown_spot1","targetname");
		self setgoalnode(fnode);
	}
}

event4_moody_back_of_house()
{
	level waittill ("bomb 2 went off");
	wait 2.5;
	level.moody thread anim_single_solo(level.moody,"moody_back_of_house");
	println(" ^3 ***********  back of house");
}


pak43_blown_new_spot()
{
	// set up seperate guys 

	if(self.targetname == "squad2_guy1_guy")
	{
		fnode = getnode("squad2_pak43_blown_spot1","targetname");
		self setgoalnode(fnode);
	}


	if(self.targetname == "squad2_guy2_guy")
	{
		fnode = getnode("squad2_pak43_blown_spot1","targetname");
		self setgoalnode(fnode);
	}

	if(self.targetname == "squad2_guy3_guy")
	{
		fnode = getnode("squad2_pak43_blown_spot1","targetname");
		self setgoalnode(fnode);
	}

	if(self.targetname == "squad2_guy4_guy")
	{
		fnode = getnode("squad2_pak43_blown_spot1","targetname");
		self setgoalnode(fnode);
	}

	if(self.targetname == "squad2_guy5_guy")
	{
		fnode = getnode("squad2_pak43_blown_spot1","targetname");
		self setgoalnode(fnode);
	}

	if(self.targetname == "squad2_guy6_guy")
	{
		fnode = getnode("squad2_pak43_blown_spot1","targetname");
		self setgoalnode(fnode);
	}
}

delete_squad2()
{
	level waittill("moody_open_barn_door"); 

	if(isalive(self))
	{
		self delete();
	}
}

//=====================================================================================================================
//	event2_squad1_wave_a_ender()
//
//		When the player hits the ender trigger we stop the group from spawning
//=====================================================================================================================
event2_squad1_wave_a_ender()
{
	level endon("event2_end");
	
	trigger = getent("event2_squad1_wave_a_ender","targetname");
	
	trigger waittill("trigger");
	
	level notify("event2_squad1_wave_a_end");
	level notify("objective_5_complete");
}

//=====================================================================================================================
//	event2_mg42s_init
//
//		Setup the mg42s for this event
//=====================================================================================================================
event2_mg42s_init() // line 1369 of 1to2 gsc is where goldberg says his line this is where you should activate... stealth tracker... 
{
	field_mg42 = getent("event2_mg42_field","targetname");
	field_mg42.script_delay_min = 0.5;
	field_mg42.script_delay_max = 1.5;
	field_mg42.script_burst_min = 1;
	field_mg42.script_burst_max = 3;
	field_mg42 setmode("auto_ai"); // auto, auto_ai, manual

	field_mg42 thread event2_mg42_used();

	side_mg42 = getent("event2_mg42_side","targetname");
	side_mg42.script_delay_min = 0.5;
	side_mg42.script_delay_max = 1.5;
	side_mg42.script_burst_min = 1;
	side_mg42.script_burst_max = 3;
	side_mg42 setmode("auto_ai"); // auto, auto_ai, manual

	side_mg42 thread event2_mg42_used();
}

event2_mg42_support_guy_spawn()	// this is getting called to early, around right after defending moody
{
// you need to do this later,,, around when steve guys comes in...
//	level thread event2_farmhouse_goes_alert();
//	level thread event2_player_fires_early(); // function that is called from here only.
	wait 0.05;
	println("^3 *********** SPAWN support guys ********************");
	println("^3 *********** SPAWN support guys ********************");
	println("^3 *********** SPAWN support guys ********************");
	println("^3 *********** SPAWN support guys ********************");
	println("^3 *********** SPAWN support guys ********************");
	println("^3 *********** SPAWN support guys ********************");
	e2_mg42_support = getentarray("event2_mg42_field_guy_support", "groupname");

	for(i=0;i<(e2_mg42_support.size);i++)//		
	{
		guy = e2_mg42_support[i] stalingradspawn();
		guy waittill ("finished spawning");
		guy.targetname = e2_mg42_support[i].targetname +"_guy";
		println("^3 *********** GUy:  ", self.targetname);
		guy.pacifist = 1;
//		guy allowedstances("stand");
		guy thread event2_mg42_support_guy_spawn_wait();
	}
}

event2_mg42_support_guy_spawn_wait()
{
//	level waittill("team_wait_on_car");
//	level waittill("event2_farmhouse_on_alert");
//	level waittill ("support_squad_move");
	level waittill ("support_squad_move");
	self.pacifist = 0;
	self.ignorme = true;

//	if(self.targetname == "e2_support3_guy")
//	{
//		self.script_flashlight = 1;
//		self.pacifist = 1;
//		wait (4 + randomfloat (6));
//			if(isalive(self))
//			{
//				self.script_flashlight = 0;
//				self.pacifist = 0;
//			}
//	}

//	if(self.targetname == "e2_support1_guy")
//	{
//		self.ignorme = false;
//		self.script_flashlight = 1;
//		self.pacifist = 1;
//		wait (4 + randomfloat (6));
//			if(isalive(self))
//			{
//				self.script_flashlight = 0;
//				self.pacifist = 0;
//			}
//	}



// cock comment out for now need to figure why it happens though!!!!!!!!!

//	if(self.targetname == "e2_support3_guy")
//	{
//		if(isalive(self))
//		{ 
//			self.goalradius = 5;
//			self.pacifist = 1;
//			// need to select a new node for the ai to go to once they are alerted.
//			fnode = getnode("e2_squad_spot1", "targetname");
//			self setgoalnode(fnode);
//			self waittill("goal");
//			self.ignorme = false;
//			self.pacifist = 0;
//		}
//	}
//
//	if(self.targetname == "e2_support4_guy")
//	{
//		if(isalive(self))
//		{ 
//			self.goalradius = 5;
//			self.pacifist = 1;
//			// need to select a new node for the ai to go to once they are alerted.
//			znode = getnode("e2_squad_spot2", "targetname");
//			self setgoalnode(znode);
//			self waittill("goal");
//			self.ignorme = false;
//			self.pacifist = 0;
//		}
//	}	
}

//=====================================================================================================================
//	event1_mg42_used()
//
//		Waits till someone jumps on the mg42
//=====================================================================================================================
event2_mg42_used()
{
//	level endon("event1_end");
	
	while (1)
	{	
		self waittill("turretownerchange");
		
		user = self getTurretOwner();
		if (isdefined (user))
		{
			maps\bastogne2::dprintln("event2","AI using turret");
			
			// set up the new ai guy for using the turret
			self thread event2_mg42_controller(user);
		}
	}
}


//=====================================================================================================================
//	event1_mg42_controller()
//
//		Controls the mg42
//=====================================================================================================================
event2_mg42_controller(user)
{
	self endon("turretownerchange");
	
	// get the manual targets list and set them
	targets = getentarray( "event1_mg42_target", "targetname" );

	self setmode("auto_ai"); // auto, auto_ai, manual
	self.manual_target = undefined;
	user thread maps\_mg42_gmi::burst_fire(self);
}

//=====================================================================================================================
//	event2_launch_flares
//
//		Launches the flares over the field
//=====================================================================================================================
event2_launch_flares()
{
	level endon("event2_end");
	level endon("event2_stop_flares");
 	level thread event2_launch_flares_sound();


	if(getcvar("scr_gmi_fast") != "2")
	{
//		playfx( level._effect["event2_flare"],(7512, 1300, 60) );

		playfx( level._effect["event2_flare"],(6389, 2132, 0) ); // new flare stuff from colin
		println(" ^3 ***********  flares go to the right");
		//wait 18;
	}

	wait 3;
	level.moody thread anim_single_solo(level.moody,"moody_flares");
	level notify("objective_4_complete");
	level.moody  animscripts\point::point(0, true, undefined, undefined);
	wait 4.9;
	level notify ("support_squad_move");
	
//	while (1)
//	{
		// launch flares  (position is somewhere in the middle of the field)
//		playfx( level._effect["event2_flare"],(6900, 1600, 60) );
//	}
}

event2_launch_flares_sound()
{
	
	org2 = spawn ("script_origin", (7843,998,100));
	org1 = spawn ("script_origin", (5447,4206,100));

//	org.origin = (vec[0] + offset, vec[1], vec[2]);
	println(" ^9 ***********  PLAYSOUND OF JEEP 2***********");
	org1 playsound ("mortar_launch");
	wait 1.3;
	org2 playsound ("flare");
	wait 15;
	org2 delete();
}

//=====================================================================================================================
//	event2_squad2_parta
//
//		The preliminary approach by squad2
//=====================================================================================================================
event2_squad2_parta()
{
	level endon("event2_end");
	
	// wait until notification comes in to go to alert status
	level waittill("event2_farmhouse_on_alert");
}

//=====================================================================================================================
//	event2_vehicle_init()
//
//		Sets up the vehicle for event 2.
//=====================================================================================================================
event2_vehicle_init()
{
	level endon("event2_end");
	
	event2_vehicle = getent("event2_vehicle","targetname");
	event2_vehicle_driver = getent("event2_vehicle_driver","targetname");
	event2_vehicle_path = getvehiclenode("event2_vehicle_node","targetname");
	
	// make sure he goes to the node
	event2_vehicle_driver.bravery = 500000;
	event2_vehicle_driver.goalradius = 2;
	event2_vehicle_driver.pacifist = 1;
	event2_vehicle_driver.ignoreme = true;
    	event2_vehicle_driver.pacifistwait = 0; 
     	event2_vehicle_driver.playpainanim = false;		// this should keep the guy from reacting to pain
	event2_vehicle_driver thread maps\_utility_gmi::cant_shoot();
	event2_vehicle_driver thread maps\_utility::magic_bullet_shield();
 
	// wait until notification comes in to go to alert status
//	level waittill("event2_vehicle_go");

	wait (1.0);
	maps\bastogne2::dprintln("event2","^4VEHICLE DRIVER GO!");
	
//	wait 10;

//	wait (5);
	// mount the vehicle
	event2_vehicle thread maps\_bmwbikedriver_gmi::main(event2_vehicle_driver);
	wait(0.25);
	
	// turn on the bmw
	playfxontag( level._effect["event1_bmw_headlight"], event2_vehicle,"tag_light");
	
	wait(0.1);
	
	// now send the vehicle off

//	angle1 = (7512,1248,60); // too close
	angle1 = (7248,1522,60); // too close
	level thread german_yell(angle1);

	event2_vehicle attachpath( event2_vehicle_path );
	event2_vehicle startpath();
	level thread moody_dia_our_boy();

	wait(0.1);	


	// have the horn go off every once in a while
	event2_vehicle thread event2_vehicle_horn();



	// jeremy added 05/24/05 // makes battle start with flares and AI
//	event2_vehicle setWaitNode(getVehicleNode("alex174","targetname"));
//	event2_vehicle waittill ("reached_wait_node");



//	wait 2;

	level notify("team_wait_on_car");	
	
//	event2_vehicle waittill("reached_end_node");
	
	wait (0.5);
	println("Zeh americans are coming!!!!");

	// wake everything up

	level notify("event2_farmhouse_on_alert");

	// unlink the driver
//	event2_vehicle_driver unlink();

//	event2_vehicle thread maps\_bmwbike_gmi::guy_unload(event2_vehicle_driver);

	event2_vehicle waittill("reached_end_node");

	event2_vehicle delete();
	event2_vehicle_driver delete();
}

moody_dia_our_boy()
{
//	wait 5;
	level.moody thread anim_single_solo(level.moody,"moody_theres_our_boy");
	println(" ^3 ***********  there's our boy");
}

//=====================================================================================================================
//	event2_vehicle_horn()
//
//		Plays the horn honking sounds as the driver pulls up
//=====================================================================================================================
event2_vehicle_horn()
{
//	wait (2);

	self playsound ("bike_horn_frantic");	
	println("NEED A HORN SOUND");
	wait (1);
	
	println("NEED A HORN SOUND");
	wait (3);
	self playsound ("bike_horn_frantic");	

	println("NEED A HORN SOUND");
}

//=====================================================================================================================
//	event2_vehicle_horn()
//
//		Plays the horn honking sounds as the driver pulls up
//=====================================================================================================================
event2_moodys_they_know_we_are_here_speach()
{
	level waittill("event2_farmhouse_on_alert");

	wait (2);
	
	println("Damn it! They know we are here!");
	
	wait(1);
	
	println("We need to move now!");
	
	wait(2);
	
	println("Go Go Go!");
	wait(1);
	
}

//=====================================================================================================================
// * * * EVENT 3 * * * 
//
//	Event 3 encompasses the assault of the farm after the blowing up of the artillery to the capture of the german
//	officer
//=====================================================================================================================

//=====================================================================================================================
//	event3_init
//
//		Sets up any thing that needs to be set up for event2 and threads all event2 functions
//=====================================================================================================================
event3_init()
{
	if(getCvar("scr_debug_event3") == "")		
		setCvar("scr_debug_event3", "1");	
	level.debug["event2"] = getcvarint("scr_debug_event3");
}

event3_bomb_hide()
{
	getent("bomb1","targetname") hide();
	getent("bomb2","targetname") hide();
}

event3_bomb1_hide_after_explosion()
{
	getent("bomb1","targetname") hide();
}

event3_bomb2_hide_after_explosion()
{
	getent("bomb2","targetname") hide();
}

event3_garage_spawner()
{
	getent("event3_garage_spawner","targetname") waittill ("trigger");

	// added jeremy 05/26/05-- to have more guys come out of the garage
	level thread  maps\_squad_manager::manage_spawners("event2_garage_axis",1,3,"event2_garage_end",2, ::event2_garage_axis_init);	

	spawns = getentarray("event3_garage_guy","targetname");
	
	for(i=0;i<spawns.size;i++)
	{
		guy = spawns[i] stalingradspawn();
		guy waittill("finished spawning");
		guy.goalradius = 8;
		guy.bravery = 50000;
		guy.targetname = "garage_guy";
	}
	
	while(isalive(getent("garage_guy","targetname")))
	{
		wait 0.25;
	}
	
	level notify("move through garage");
	
}

event2_garage_axis_init()
{
	wait 4;
	level notify ("event2_garage_end");
}

event3_courtyard_spawner()
{
	getent("courtyard_spawn","targetname") waittill ("trigger");
	
	spawns = getentarray("courtyard_spawners","targetname");
	
	for(i=0;i<spawns.size;i++)
	{
		guy = spawns[i] stalingradspawn();
		guy waittill("finished spawning");
		guy.goalradius = 8;
		guy.bravery = 50000;
		if (isdefined(spawns[i].script_noteworthy))
		{
			guy.targetname = spawns[i].script_noteworthy;
		}
	}
	level notify ("event2_garage_end");
	level notify ("courtyard spawns done");
}

event3_pak43_death()
{
	deathsound = "explo_metal_rand";
	deathmodel = "xmodel/v_ge_art_pak43(d)";
	
	flak2 = getent("flak1","targetname");
	flak1 = getent("flak2","targetname");
	
	flak1_goal = getnode("flak1_goal","targetname");
	flak2_goal = getnode("flak2_goal","targetname");
	flak1_cover = getnode("flak1_cover","targetname");
	flak2_cover = getnode("flak2_cover","targetname");
	
	// Planting bomb 1
	
	level waittill ("plant bomb 1");
	level notify ("event2_garage_end");


	level.blue[2] setgoalnode(flak1_goal);
	level.blue[2] waittill ("goal");
	level.moody thread anim_single_solo(level.moody,"fire_in_the_hole");
	
	wait 1;
	getent("bomb1","targetname") show();
	
	level.blue[2] setgoalnode(flak1_cover);
	level.blue[2] waittill ("goal");
	
	wait 2;
	getent("bomb1","targetname") hide();

	
	flak1 setmodel(deathmodel);
	flak1 playsound(deathsound);
	playfx(level._effect["pak43_death"], flak1.origin);
	level notify ("bomb 1 went off");

	// Planting bomb 2
	
	while (level.flags["bomb1_done"] == false)
	{
		wait .25;
	}

	// jeremy added 05/26/05
	// guy in second story of barn with guys...

	level.blue[2] setgoalnode(flak2_goal);
	level.blue[2] waittill ("goal");
	level.moody thread anim_single_solo(level.moody,"fire_in_the_hole");
	
	wait 1;
	getent("bomb2","targetname") show();
	
	level.blue[2] setgoalnode(flak2_cover);
	level.blue[2] waittill ("goal");
	
	wait 2;
	
	flak2 setmodel(deathmodel);
	flak2 playsound(deathsound);
	playfx(level._effect["pak43_death"], flak2.origin);

	getent("bomb2","targetname") hide();
//	getent("bomb2","targetname") hide();

	
	level notify ("bomb 2 went off");
	level notify("objective_6_complete");
}

event3_bomber1_think()
{
	level waittill ("courtyard spawns done");
	bombers = getentarray("bomber_1","targetname");
	
	bomber_flag = false;
	
	while (bomber_flag == false)
	{
		alive_count = 0;
		for (i=0;i<bombers.size;i++)
		{
			if (isalive(bombers[i]))
			{
				alive_count++;
			}
		}
		
		if (alive_count == 0)
		{
			bomber_flag = true;
		}
		wait 0.05;
	}
	level notify ("plant bomb 1");
}

event3_bomber2_think()
{
	level waittill ("courtyard spawns done");
	bombers = getentarray("bomber_2","targetname");
	
	bomber_flag = false;
	while (bomber_flag == false)
	{
		alive_count = 0;
		for (i=0;i<bombers.size;i++)
		{
			if (isalive(bombers[i]))
			{
				alive_count++;
			}
		}
		
		if (alive_count == 0)
		{
			bomber_flag = true;
		}
		wait 0.05;
	}
	level.flags["bomb1_done"] = true;
}

event3_german_second_story()
{
	// jeremy added 05/26/05
	// spawn guy in to attack from window...

	level waittill ("bomb 1 went off");

	e2_mg34_guy = getent("second_story_german", "targetname");
	e2_mg34_ai = e2_mg34_guy dospawn();
	e2_mg34_ai.goalradius = 10;
	e2_mg34_ai.dontdropweapon = 1;
	e2_mg34_ai.ignoreme = true;
	e2_mg34_ai thread kill_barn_guys_if_player_waits();

	// this guy supports mg34 getting set up!
	e2_second_story_guy = getent("second_story_german_2", "targetname");
	e2_second_story_ai_2 = e2_second_story_guy dospawn();
	e2_second_story_ai_2.goalradius = 10;
	e2_second_story_ai_2.ignoreme = true;
	e2_second_story_ai_2 thread kill_barn_guys_if_player_waits();

	wait (0.4 + randomfloat (3));
//	wait 1;

	b_door1 = getent("barn_top_floor_door1", "targetname");
	b_door2 = getent("barn_top_floor_door2", "targetname");

	b_door1 playsound ("wood_door_kick");
	b_door1 rotateyaw(127, 0.3,0,0.3);
//	level.player playsound("wood_door_kick");
	wait 1;
	b_door2 playsound ("wood_door_kick");
	b_door2 rotateyaw(-133, 0.3,0,0.3);

	wait 5; // turn ignoreme off after five seconds, because this is enough time for the player to shoot them.
	if(isalive(e2_mg34_ai))
	{
		e2_mg34_ai.ignoreme = false;
	}

	if(isalive(e2_second_story_ai_2))
	{
		e2_second_story_ai_2.ignoreme = false;
	}
}

kill_barn_guys_if_player_waits()
{
	level waittill ("bomb 2 went off");
	wait 3;
	if(isalive(self))
	{
		self DoDamage ( self.health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );		
	}
}

event3_moveto_garage()
{
	getent("event3_garage_spawner","targetname") waittill ("trigger");
	
	level.blue[0].goalradius = 8;
	level.blue[0] setgoalnode(getnode("garage_blue_1","targetname"));
	
	level.blue[1].goalradius = 8;
	level.blue[1] setgoalnode(getnode("garage_blue_2","targetname"));
	
	level.blue[2].goalradius = 8;
	level.blue[2] setgoalnode(getnode("garage_blue_3","targetname"));
	
	if (isalive(level.red[0]))
	{
		level.red[0].goalradius = 8;
		level.red[0] setgoalnode(getnode("garage_red_3","targetname"));
	}
	
	if (isalive(level.red[1]))
	{
		level.red[1].goalradius = 8;
		level.red[1] setgoalnode(getnode("garage_red_4","targetname"));
	}
}

event3_movethrough_garage()
{
	getent("courtyard_spawn","targetname") waittill ("trigger");
	
	level.blue[0].goalradius = 8;
	level.blue[0] setgoalnode(getnode("garage_blue_5","targetname"));
	
	level.blue[2].goalradius = 8;
	level.blue[2] setgoalnode(getnode("garage_blue_4","targetname"));
	
	if (isalive(level.red[0]))
	{
		level.red[0].goalradius = 70;
		level.red[0] setgoalnode(getnode("courtyard_red_1","targetname"));
	}
	
	if (isalive(level.red[1]))
	{
		level.red[1].goalradius = 8;
		level.red[1] setgoalnode(getnode("garage_blue_1","targetname"));
	}
}

event3_support_pack43_advance()
{
	getent("support_pak43_advance","targetname") waittill ("trigger");
	level notify ("kill_field_mg42");
	
	level.blue[0].goalradius = 8;
	level.blue[0] setgoalnode(getnode("courtyard_red_1","targetname"));
	
	level.blue[1].goalradius = 8;
	level.blue[1] setgoalnode(getnode("garage_blue_4","targetname"));
	
	if (isalive(level.red[0]))
	{
		level.red[0].goalradius = 8;
		level.red[0] setgoalnode(getnode("courtyard_blue_2","targetname"));
	}
	
	if (isalive(level.red[1]))
	{
		level.red[1].goalradius = 8;
		level.red[1] setgoalnode(getnode("courtyard_blue_3","targetname"));
	}

}

event3_move_bomb1_planted() 
{
	level waittill ("bomb 1 went off"); // last change
//	getent("support_pack43_advance","targetname") waittill ("trigger");
	
	level.blue[0].goalradius = 8;
	level.blue[0] setgoalnode(getnode("courtyard_red_1","targetname"));
	
	level.blue[1].goalradius = 8;
	level.blue[1] setgoalnode(getnode("garage_blue_4","targetname"));
	
	if (isalive(level.red[0]))
	{
		level.red[0].goalradius = 8;
		level.red[0] setgoalnode(getnode("courtyard_blue_2","targetname"));
	}
	
	if (isalive(level.red[1]))
	{
		level.red[1].goalradius = 8;
		level.red[1] setgoalnode(getnode("courtyard_blue_3","targetname"));
	}
}

event3_shutdown_ambient_battle_pak43()
{
	getent("shutdown_ambient_battle_pak43","targetname") waittill ("trigger");	

	level notify ("event2_end_special");
}

event3_move_bomb2_planted()
{
	level waittill ("bomb 2 went off");
	
	level.blue[0] setgoalentity (level.player);
	level.blue[1] setgoalentity (level.player);
	level.blue[2] setgoalentity (level.player);
	
	if (isalive(level.red[0]))
	{
		level.red[0] setgoalentity (level.player);
	}
	if (isalive(level.red[1]))
	{
		level.red[1] setgoalentity (level.player);
	}

	level thread start_event4();
}

event3_moody_usenades()
{
	level endon("event2_end");

	level endon ("objective_4_complete");
	
	getent("moody_use_nades","targetname") waittill ("trigger");
//	level notify("objective_4_complete");

	while (1)
	{
		if (distance (level.player getorigin(), level.blue[0].origin) < 600)	
		{
			level.moody thread anim_single_solo(level.moody,"moody_grenades");
			break;
		}
		wait 0.05;
	}	
}

event3_moody_spike88()
{
	level endon("event2_end");
	
	getent("moody_88s","targetname") waittill ("trigger");
	level notify("begin_spike_43");
	level.moody thread anim_single_solo(level.moody,"moody_spike88");
	println(" ^3 ***********  spike the 88's");
}

event3_moody_threats()
{
	level endon("event2_end");
	
	getent("moody_threats","targetname") waittill ("trigger");
	level.moody thread anim_single_solo(level.moody,"moody_threats");
	println(" ^3 ***********  moody threats");
}

anim_single_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
 	maps\_anim_gmi::anim_single (newguy, anime, tag, node, tag_entity);
}

event3_clear_outside_forest()
{
	level waittill ("bomb 2 went off");
	ai1 = maps\_squad_manager::alive_array("event2_squad2_a_axis");
//	ai2 = maps\_squad_manager::alive_array("");
//	ai3 = maps\_squad_manager::alive_array("");
	
	alive_flag = 0;

//	while (alive_flag == false)
//	{
		alive_count = 0;
		for (i=0;i<ai1.size;i++)
		{
			if (isalive(ai1[i]))
			{
				ai1[i] DoDamage ( ai1[i].health + 50, (randomint(5000)-2500,randomint(5000)-2500,randomint(5000)-2500) );
//				alive_count++;
			}
		}
		
//		for (i=0;i<ai2.size;i++)
//		{
//			if (isalive(ai2[i]))
//			{
//				alive_count++;
//			}
//		}
		
//		for (i=0;i<ai3.size;i++)
//		{
//			if (isalive(ai3[i]))
//			{
//				alive_count++;
//			}
//		}
		
//		if (alive_count == 0)
//		{
//			alive_flag = true;
//		}
//		wait 0.05;
//	}
//	level notify ("objective_3_complete");
}

//====================================================================================
//
//	evetn2_mortars
//  	These mortars falll on the players head in the area where the flares go off.event2_mortars()
//
//====================================================================================
event3_mortars()
{
	println("^3 *********** mortars ready **************");
	level waittill("support_squad_move");
	for(i=1;i<4;i++)
	{
		println("^3 *********** mortars ready two **************");
		pop[i] = getent("instant_mortar" + i, "targetname");
	}

	wait 2 + randomfloat(2.3);	

//	while(level.flag ["kill_fake_sniper1"] == true)
		println("^3 *********** mortars ready three **************");

	if(getcvar("scr_gmi_fast") != "2")
	{
		// loop this 
			for(n=0;n<5;n++)
			{
				wait 0.1 + randomfloat(1.6);	
				num = (randomint(3)+1);
				pop[num] instant_mortar();		
			}	
	}
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

// added jeremy -- 05/18/05
start_event4()
{
	level thread maps\bastogne2_event4::main_normal_progression();
}

trucks_health()
{
	println("^ 3 truck setup **********");
	ht1 = getent ("cy_truck1","targetname");
	ht1 disconnectpaths();
	ht1 maps\_truck_gmi::init();
	ht1 thread truck_death_damage();
	ht1.health = 650;

	path = getVehicleNode(ht1.target,"targetname");
	ht1 attachpath (path);

	ht2 = getent ("cy_truck2","targetname");
	ht2 maps\_truck_gmi::init();
	ht2 thread truck_death_damage();
	ht2 disconnectpaths();
	ht2.health = 650;

	path = getVehicleNode(ht2.target,"targetname");
	ht2 attachpath (path);

	ht3 = getent ("cy_truck3","targetname");
	ht3 disconnectpaths();
	ht3 thread truck_death_damage();
	ht3 maps\_truck_gmi::init();
	ht3.health = 650;

	path = getVehicleNode(ht3.target,"targetname");
	ht3 attachpath (path);
}

truck_death_damage()
{
//	while(1)
//	{
//		radiusDamage(self.origin,270, 80, 80);
//		wait 1;
//	}


	self waittill("death");
//	radiusDamage ( self.origin, range, max_damage, min_damage);
	radiusDamage(self.origin,270, 80, 80);
}

