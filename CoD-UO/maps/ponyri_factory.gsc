main()
{
	level.mortar = loadfx ("fx/explosions/artillery/pak88.efx");

	level._effect["ceiling_dust"]	= loadfx ("fx/map_trenches/ceiling_dust.efx");

	level.flags["tank1_dead"] = true;
	level.flags["tank2_dead"] = true;
	level.flags["tank1_planted"] = false;
	level.flags["tank2_planted"] = false;
	level.flags["mg42_1_dead"] = true;
	level.flags["fa_bbq_trigger"] = false;

	level.flags["inside_basement"] = false;
	level.flags["window_germans"] = false;
	level.flags["fact_pf_started"] = false;
	level.flags["fact_floor_movein"] = false;
	level.flags["panzer2_dead"] = false;
	level.flags["ramp_ger2_started"] = false;
	level.flags["catwalk_stairs_trigger"] = false;
	level.flags["do_factory_pf"] = false;
	level.die_count = 0;

	door = getent ("fact_doors_open", "targetname");
	door maps\_utility_gmi::triggerOff();

	level thread factory_shortcut_hack();
	level thread yard_setup_trigger();
	wait ( 0.1 );

	panzer2_placeholder = getent ("factory_shooting_panzer", "targetname");
	panzer2_placeholder hide();

	ec_trigger = getent ( "ec_speech_trigger", "targetname" );
	ec_trigger maps\_utility_gmi::triggerOff();
}

factory_shortcut_hack()
{
	level endon ("stop_factory_hack");

	trig = getent("factory_shortcut_trigger","targetname");
	if(isdefined(trig))
	{
		trig waittill ("trigger");

		level notify ("allow_sneaking" );
		maps\_utility_gmi::exploder(5);		// break open the wall
		maps\_utility_gmi::exploder(6);		// break open the wall
		maps\_utility_gmi::exploder(7);		// break open the wall

		trig2 = getent ("approach7_trigger", "targetname");
		if(isdefined(trig2))
			trig2 maps\_utility_gmi::triggerOff();

		level.player setfriendlychain ( getnode ( "fapp_chain4", "targetname" ) );

		level.antonov setgoalentity(level.player);
		level.vassili setgoalentity(level.player);
		level.boris setgoalentity(level.player);
		level.miesha setgoalentity(level.player);

		objective_add (level.town_obj_num, "active", &"PI_PONYRI_OBJECTIVE2");
		objective_string(level.town_obj_num, &"PI_PONYRI_OBJECTIVE2");
		objective_state (level.town_obj_num, "done");

		objective_add (level.rail_obj_num, "active", &"PI_PONYRI_OBJECTIVE1");
		objective_state (level.rail_obj_num, "done");

		objective_add(level.school_obj_num, "active", &"PI_PONYRI_OBJECTIVE3A");
		objective_state (level.school_obj_num, "done");

		objective_add(level.fapp_obj_num, "active", &"PI_PONYRI_OBJECTIVE4");
		objective_state (level.fapp_obj_num, "done");

		objective_add(level.factory_obj_num, "active", &"PI_PONYRI_OBJECTIVE5A" );

		yard_fight_start();
	}
}

spawn_window_germans(mbs)
{
	spawners = getentarray ("fact_window_spawners","targetname");
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			guy = spawners[x] dospawn();
			if(isdefined(guy))
			{
				level.flags["window_germans"] = true;
				guy.targetname = "fact_window";
				guy.groupname = "fact_window_germans";
				if(mbs == true)
					guy thread maps\_utility_gmi::magic_bullet_shield();
			}
		}
	}
//	println("^4 spawn_window_germans - POOF!");

}

kill_window_germans()
{
	guys = getentarray ( "fact_window", "targetname" );
	if(isdefined(guys))
	{
		for(x=0;x<guys.size;x++)
		{
			guys[x] delete();
		}
	}

//	println("^4 kill_window_germans - BANG!");
	level.flags["window_germans"] = false;
}

factory_replace(guy)
{
//	println("^6 factory_replace - new guy");
	guy.targetname = "friendlywave_guy";
	guy.groupname = "friendlywave_guy";

	wait (0.1);

	guy.goalradius = 128;
	guy.followmin = -3;
	guy.followmax = 1;
	guy.maxsightdistsqrd = 3000000;

	if(level.flags["fact_floor_movein"] == false)
		guy setgoalentity ( level.player );
	else
	{
		if(randomint(2) < 1)
		{
			guy setgoalentity ( level.antonov );
		}
		else
		{
			guy setgoalentity ( level.vassili );
		}
	}
}

yard_fight_start()
{
	spawn_window_germans(true);

	wait(0.1);

	spawners = getentarray ("yard_rus1","targetname");
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			guy = spawners[x] dospawn();
			if(isdefined(guy))
			{
				guy.targetname = "yard_russian_guy";
				guy thread maps\_utility_gmi::magic_bullet_shield();
			}
		}
	}

	wait(0.1);

	spawners = getentarray ("ramp_ger1","targetname");
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			guy = spawners[x] dospawn();
			if(isdefined(guy))
			{
				guy.targetname = "ramp_ger1_guy";
				guy thread maps\_pi_utils::delayed_run_to_target();
			}
		}
	}

	trigger = getent ( "yard_fight_start", "targetname" );
	if(isdefined(trigger))
		trigger waittill ("trigger");

	//println("^4 yard_fight_start : setting friendlywave settings!");
	level.maxfriendlies = 7;
	level.friendlywave_thread = maps\ponyri_factory::factory_replace;

	// disconnect the immmortals from your team, send them to the yard fight
	level.antonov setfriendlychain( getnode ("fact_yard_chain", "targetname"));
	level.antonov setgoalentity(level.antonov);
	level.boris setgoalentity(level.antonov);
	level.vassili setgoalentity(level.antonov);
	level.miesha setgoalentity(level.antonov);

	//println("^4 yard_fight_start: waiting for first ramp germans to die");
	maps\_pi_utils::wait_for_group_clear("ramp_germans", 2, "go_for_basement");

	// send guys up to the sandbags to keep fighting
	//println("^4 yard_fight_start: moving guys up to the sandbags");
	level.player setfriendlychain ( getnode ("rus_ramp_chain", "targetname"));
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_basement");
//	level.antonov playsound("antonov_basement");

	spot = getent ("basement_door_location", "targetname");
	objective_string(level.factory_obj_num, &"PI_PONYRI_OBJECTIVE5A" );
	objective_position (level.factory_obj_num, spot.origin );
	objective_current(level.factory_obj_num);
	objective_ring(level.factory_obj_num);

	level.antonov setfriendlychain ( getnode ("fact_window_fight_chain", "targetname"));

	if(level.flags["ramp_ger2_started"] == false)
		level waittill ( "ramp_ger2_started" );

	maps\ponyri_fx::spawnFactoryFX();

	maps\_pi_utils::wait_for_group_clear("ramp_germans", 2, "go_for_basement");

	//println("^4 yard_fight_start: sending redshirts up to basement door");
	level.player setfriendlychain ( getnode ("fact_basement_chain", "targetname"));

	//println("^4 yard_fight_start: ok... pestering player about the basement");
	if(level.flags["inside_basement"] == false)
		pester_player_about_basement();
}

pester_player_about_basement()
{
	level endon ( "inside_basement" );

	wait ( 5 );

	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_basement");
//	level.antonov playsound("antonov_basement");

	wait(20);
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_basement2");
//	level.antonov playsound("antonov_basement2");

	wait(20);
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_basement2");
//	level.antonov playsound("antonov_basement2");
}

// =============================
// =============================
//  Factory Building
// =============================
// =============================

factory_basement()
{
	level endon("factory_window_clear");

	// wait for the player to enter
	trigger = getent ( "inside_basement", "targetname" );
	if(isdefined (trigger))
	{
		trigger waittill ( "trigger" );

		catwalks = getent ( "catwalks", "targetname");
		objective_string(level.factory_obj_num, &"PI_PONYRI_OBJECTIVE5B");
		objective_position (level.factory_obj_num, catwalks.origin );
		objective_current(level.factory_obj_num);
		objective_ring(level.factory_obj_num);

		level.player setfriendlychain ( getnode ("factory_basement_chain", "targetname"));

		CleanApproach();

		level notify ( "inside_basement" );
		level.flags["inside_basement"] = true;
	}
	else println ( "^5factory_door_kick: could not find inside_basement" );

	watching = true;
	while (watching)
	{
		trigger waittill ("trigger");
		if(level.flags["window_germans"] == false)
			spawn_window_germans(true);
		wait (1);
	}
}

redlight_room()
{
	trig = getent ( "redlight_room_exit_trigger", "targetname" );
	if(isdefined(trig))
		trig maps\_utility_gmi::triggerOff();

	maps\ponyri_rail::wait_for_group_clear("fact2", 1, "redlight_room_clear");

	trig = getent ( "redlight_room_exit_trigger", "targetname" );
	if(isdefined(trig))
		trig maps\_utility_gmi::triggerOn();

	level.player setfriendlychain ( getnode ("factory_redlight_exit_chain", "targetname"));

	crumb = getent("factory_breadcrumb1", "targetname");
	objective_position (level.factory_obj_num, crumb.origin );
	objective_ring(level.factory_obj_num);

	if(isdefined(trig))
		trig waittill ("trigger");
	else
		wait(3);

	level.player setfriendlychain ( getnode ( "fact_stair1_chain", "targetname"));
}

closest_guy_speaks( soundname )
{
	guys = getentarray ( "friendlywave_guy", "targetname" );
	if(isdefined(guys) && (guys.size > 0))
	{
		closestDist = distance ( guys[0].origin, level.player.origin );
		closestEnt = 0;
		for(x=0;x<guys.size;x++)
		{
			dist = distance ( guys[x].origin, level.player.origin );
			if(dist < closestDist)
				closestEnt = x;
		}

//		println("^5 closest_guy_speaks: guy at " + guys[closestEnt].origin + " says something");
		guys[closestEnt].animname = "redshirt";
		guys[closestEnt] maps\ponyri_rail::anim_single_solo(guys[closestEnt], soundname);
//		guys[closestEnt] playsound (soundname);
	}
	else println("^5 closest_guy_speaks: nobody around to say the line???");
}

yard_setup_trigger()
{
//println("^5 watching for yard_setup_trigger");

	trig = getent("yard_setup_trigger","targetname");
	if(isdefined(trig))
		trig waittill ("trigger");

	level.player setfriendlychain ( getnode("fact_yard_chain", "targetname"));

	fact_ramp_trigger();
}

fact_ramp_trigger()
{
//println("^5 watching for fact_ramp_trigger");

	trig = getent ( "fact_ramp_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");
	else println("^5 fact_ramp_trigger: fact_ramp_trigger trigger missing?");

	spawners = getentarray ("ramp_ger2","targetname");
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			guy = spawners[x] dospawn();
			if(isdefined(guy))
			{
				guy.targetname = "ramp_ger2_guy";
				guy thread maps\_pi_utils::delayed_run_to_target();
			}
		}
	}

	door = getent("factory_basement_door","targetname");
	door playsound("wood_door_kick");
	door rotateto((0,-90,0), 0.5, 0, 0.2);
	door waittill("rotatedone");
	door connectpaths();

	level notify ( "ramp_ger2_started" );
	level.flags["ramp_ger2_started"] = true;

	level thread factory_basement();
	room1_trigger();
}

room1_trigger()
{
//println("^5 watching for room1_trigger");

	trig = getent ( "room1_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");
	else println("^5 room1_trigger - missing??");

	level.player setfriendlychain ( getnode ( "factory_basement_chain", "targetname" ));

	level thread room2_trigger();
	room2a_trigger();
}

room2_trigger()
{
//println("^5 threaded room2_trigger");

	level endon("factory_window_clear");

	trig = getent ( "room2_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");
	else println("^5 room2_trigger - missing??");

	level thread redlight_room();

	level.player setfriendlychain ( getnode ( "factory_boiler_chain", "targetname"));

	level thread closest_guy_speaks ("anon_tooquiet3"); // quickly! move! move!

	if(level.flags["window_germans"] == true)
		kill_window_germans();

	watching = true;
	while(watching)
	{
		trig waittill ("trigger");
		if(level.flags["window_germans"] == true)
			kill_window_germans();
		wait (1);
	}
}

room2a_trigger()
{
//println("^5 watching for room2a_trigger");

	trig = getent ( "room2a_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");
	else println("^5 room2a_trigger - missing??");

	level.player setfriendlychain ( getnode ( "room2_chain", "targetname"));

	room3_trigger();
}

room3_trigger()
{
//println("^5 watching for room3_trigger");

	trig = getent ( "room3_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");

	maps\ponyri_weather::stopWeather();

	grenade_run_trigger();
}

grenade_run_trigger()
{
//println("^5 watching for grenade_run_trigger");

	spoken = false;

	trig = getent ( "grenade_run_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");

	level.player setfriendlychain ( getnode ( "fact_floor2_chain", "targetname"));

	crumb = getent("factory_breadcrumb2", "targetname");
	objective_position (level.factory_obj_num, crumb.origin );
	objective_ring(level.factory_obj_num);

	// make the magic grenade guy(s) run to the far corner room so second floor is deserted
//	println("^5 room3_trigger: looking for grenade guy(s)");
	ents = getentarray ( "fact3", "groupname" );
	if(isdefined(ents))
	{
		for(x=0;x<ents.size;x++)
		{
			if(issentient(ents[x]) && isalive(ents[x]))
			{
				if(spoken == false)
				{
					ents[x] playsound ("german_jabber1");
					spoken = true;
				}
//				println("^5 grenade_run_trigger: sending dude to the corner room");
				ents[x] thread maps\_pi_utils::run_blindly_to_nodename ("fact2_corner_room", "targetname", 10 );
			}
		}
	}

	fact_floor2_trigger();
}

fact_floor2_trigger()
{
//println("^5 watching for fact_floor2_trigger");

	trig = getent ("fact_floor2_trigger", "targetname");
	if(isdefined(trig))
		trig waittill ("trigger");
	else println("^5 fact_floor2_trigger - missing??");

	level thread closest_guy_speaks ("anon_tooquiet1"); // too quiet, we've taken them by surprise

	fact_shake1_trigger();
}

fact_shake1_trigger()
{
//println("^5 watching for fact_shake1_trigger");

	trig = getent( "fact_shake1_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");
	else println("^5 fact_shake1_trigger - missing??");

	dust = getentarray ( "fact_dust1", "targetname" );
	if(isdefined(dust))
	{
		if(getcvarint("scr_gmi_fast") < 1)
		{
			for(x=0;x<dust.size;x++)
			{
				playfx ( level._effect["ceiling_dust"], dust[x].origin );
				dust[x] playsound ("dirt_fall");
			}
		}
		else if(getcvarint("scr_gmi_fast") == 1)
		{
			for(x=0;x<dust.size;x+=2)
			{
				playfx ( level._effect["ceiling_dust"], dust[x].origin );
				dust[x] playsound ("dirt_fall");
			}
		}
		else if(getcvarint("scr_gmi_fast") > 1)
		{
			for(x=0;x<dust.size;x+=3)
			{
				playfx ( level._effect["ceiling_dust"], dust[x].origin );
				dust[x] playsound ("dirt_fall");
			}
		}
	}
	boom = getent ("fact_boom1", "targetname");
	if(isdefined(boom))
		boom instant_mortar_boom(boom.origin, 0.15, 2, 950);

	room5a_trigger();
}

room5a_trigger()
{
//println("^5 watching for room5a_trigger");

	spoken = false;

	// once player is in the back corner, make dudes run upstairs
	trig = getent( "room5a_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");

	ents = getentarray ( "fact3", "groupname" );
	if(isdefined(ents))
	{
		for(x=0;x<ents.size;x++)
		{
			if(issentient(ents[x]) && isalive(ents[x]))
			{
				if(spoken == false)
				{
					ents[x] playsound ("german_jabber3");
					spoken = true;
				}
				ents[x] thread maps\_pi_utils::run_blindly_to_nodename ( "fact3_corner_room", "targetname",  10 );
			}
		}
	}

	level thread radio_room_speakers();

	factory_breadcrumb3_trigger();
}

factory_breadcrumb3_trigger()
{
//println("^5 watching for factory_breadcrumb3_trigger");

	// once player is in the back corner, make dudes run upstairs
	trig = getent( "factory_breadcrumb3_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");
	else println("^5 factory_breadcrumb2_trigger - missing??");

	crumb = getent("factory_breadcrumb3", "targetname");
	objective_position (level.factory_obj_num, crumb.origin );
	objective_ring(level.factory_obj_num);

	room6a_trigger();	
}

room6a_trigger()
{
//println("^5 watching for room6a_trigger");

	// once player is in the back corner, make dudes run upstairs
	trig = getent( "room6a_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");

	spawn_window_germans(false);
	level thread closest_guy_speaks ("anon_tooquiet2"); // let's hurry to the factory floor!

	level.player setfriendlychain ( getnode ( "fact_radio_rm_chain", "targetname"));

	level notify ( "radio_room_shutup" );

	level thread fact_shake2_trigger();

	level thread maps\_pi_utils::wait_for_group_clear("radio_room_guys", 1, "radio_room_done");

	level waittill("radio_room_done");

	level.player setfriendlychain ( getnode ( "fact_to_catwalk_chain", "targetname" ));
}

fact_shake2_trigger()
{
//println("^5 watching for fact_shake2_trigger");

	trig = getent( "fact_shake2_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");
	else println("^5 fact_shake2_trigger - missing??");

	ents = getentarray("fact_window_germans","groupname");
	if(isdefined(ents))
	{
		for(x=0;x<ents.size;x++)
		{
			ents[x] notify ("stop magic bullet shield");
		}
	}

	dust = getentarray ( "fact_dust2", "targetname" );
	if(isdefined(dust))
	{
		if(getcvarint("scr_gmi_fast") < 1)
		{
			for(x=0;x<dust.size;x++)
			{
				playfx ( level._effect["ceiling_dust"], dust[x].origin );
				dust[x] playsound ("dirt_fall");
			}
		}
		else if(getcvarint("scr_gmi_fast") == 1)
		{
			for(x=0;x<dust.size;x+=2)
			{
				playfx ( level._effect["ceiling_dust"], dust[x].origin );
				dust[x] playsound ("dirt_fall");
			}
		}
		else if(getcvarint("scr_gmi_fast") > 1)
		{
			for(x=0;x<dust.size;x+=3)
			{
				playfx ( level._effect["ceiling_dust"], dust[x].origin );
				dust[x] playsound ("dirt_fall");
			}
		}
	}
	boom = getent ("fact_boom2", "targetname");
	if(isdefined(boom))
		boom instant_mortar_boom(boom.origin, 0.15, 2, 1250);

	assembly_room();
}

radio_room_speakers()
{
	level endon ("radio_room_shutup");

	speakers = getentarray ("factory_radio_room_spot", "targetname");
	if(isdefined(speakers))
	{
		while (1)
		{
			speakers[0] playsound ("german_jabber1");
			wait(2.2);
			speakers[1] playsound ("german_jabber2");
			wait(0.7);
			speakers[2] playsound ("german_jabber3");
			wait(1.5);
			speakers[3] playsound ("german_jabber4");
			wait(2.5);
			speakers[0] playsound ("german_jabber5");
			wait(2.8);
			speakers[1] playsound ("german_jabber6");
			wait(1.9);
			speakers[2] playsound ("german_jabber7");
			wait(3.6);
		}
	}
}

instant_mortar_sound()
{
	if (!isdefined (level.mortar_last_sound))
		level.mortar_last_sound = -1;

	soundnum = 0;
	while (soundnum == level.mortar_last_sound)
	{
		soundnum = randomint(3) + 1;
	}

	level.mortar_last_sound	= soundnum;

	if (soundnum == 1)
		self playsound ("mortar_explosion1");
	else if (soundnum == 2)
		self playsound ("mortar_explosion2");
	else
		self playsound ("mortar_explosion3");
}

instant_mortar_boom (origin, fPower, iTime, iRadius)
{
	instant_mortar_sound();
	playfx ( level.mortar, origin );
	earthquake(fPower, iTime, origin, iRadius);
}

// =============================
// =============================
//  Assembly Room
// =============================
// =============================

end_speech_trigger()
{
	trigger = getent ( "ec_speech_trigger", "targetname" );
	trigger maps\_utility_gmi::triggerOn();
	trigger waittill ( "trigger" );

	wait ( 2 );

	level notify ( "start_end_speech" );
}

end_speech_timer()
{
	wait ( 10 );
	level notify ( "start_end_speech" );
}

end_speech()
{
	// more guys for the speech!
	level.maxfriendlies = 10;

	// spawn in the ending commissar
	ec_spawn = getent ( "ending_commissar", "targetname" );
	ec = ec_spawn dospawn();
	while (!isdefined(ec))
	{
		wait(1);
		ec = ec_spawn dospawn();
	}

	if(isdefined(ec))
	{
		// just for good measure
		ec thread maps\_utility_gmi::magic_bullet_shield();
		ec.goalradius = 256;

		// send the folks to go hear the good word
		ec setfriendlychain (getnode("ec_chain", "targetname"));
		level.antonov setgoalentity ( ec );
		level.boris setgoalentity ( ec );
		level.miesha setgoalentity ( ec );
		level.vassili setgoalentity ( ec );

		level.antonov setfriendlychain ( getnode("ec_chain", "targetname") );
		level.vassili setfriendlychain ( getnode("ec_chain", "targetname") );
		cc3 = getentarray ( "friendlywave_guy", "targetname" );
		if(isdefined(cc3))
		{
			for(x=0;x<cc3.size;x++)
			{
				cc3[x] setgoalentity ( ec );
			}
		}

		// move him to the center of the factory floor
		ec_spot = getnode ( "ec_spot", "targetname" );
		if(isdefined(ec_spot))
		{
			ec setgoalnode ( ec_spot );
			ec waittill ( "goal" );

			level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_regroup1");

			// ring the objective
			objective_string(level.factory_obj_num, &"PI_PONYRI_OBJECTIVE5E");
			objective_position (level.factory_obj_num, ec_spot.origin );
			objective_current(level.factory_obj_num);
			objective_ring(level.factory_obj_num);

			level thread end_speech_timer();
			level thread end_speech_trigger();

			level waittill ( "start_end_speech" );
//			println("^5 end_speech: starting speech");

			ec.animname = "commissar";
			ec thread maps\ponyri_rail::anim_single_solo(ec,"fact_ending");
			wait (10);		// PGM FIXME - duration??
		}
		else println("^5end_speech: where's ec_spot?");
	}
	else
		println("^5end_speech: where's my commissar?");
}

panzer_lookat(targname)
{
	targ = getent ( targname, "targetname");
	self setTurretTargetEnt ( targ, (0,0,0) );
	self waittill( "turret_on_vistarget" );
}

panzer2_think()
{
	self endon ("death");

	self startpath();

	self.health = self.health * 3;

	self waittill ( "reached_end_node" );

	node = getvehiclenode ( "panzer2_path2", "targetname" );

	thinking = true;

	while(thinking)
	{

		wait ( 2 );
		self panzer_lookat("fstarg1");
		wait ( 2 );
		self panzer_lookat("fstarg2");
		wait ( 2 );
		self panzer_lookat("fstarg3");
		wait ( 3 );
		self FireTurret();
		thread maps\_utility_gmi::exploder(4);	// exploding box

		wait ( 5 );
		self panzer_lookat("fstarg4");
		wait ( 3 );
		self panzer_lookat("fstarg2");
		wait ( 3 );
		self panzer_lookat("fstarg5");
		wait ( 3 );
		self FireTurret();
		wait(0.2);
		thread maps\_utility_gmi::exploder(3);	// wall segment

		wait ( 3 );
		self panzer_lookat("fstarg1");
		wait ( 3 );
		self panzer_lookat("fstarg6");
		wait ( 3 );
		self panzer_lookat("fstarg7");
		wait ( 3 );
		self FireTurret();
		wait(0.2);
	}
}

catwalk_stairs_trigger()
{
	trig = getent("catwalk_stairs_trigger", "targetname");
	if(isdefined(trig))
		trig waittill ("trigger");

	level notify ( "factory_window_clear" );

	level.flags["catwalk_stairs_trigger"] = true;
	level notify ( "catwalk_stairs_trigger" );
}

second_german_floor_wave()
{
	level endon ( "panzer2_dead" );

	while(level.flags["panzer2_dead"] == false)
	{
//		println("^5 second_german_floor_wave: new wave!");
		spawners = getentarray ( "fact_floor_ger2", "targetname" );
		if(isdefined(spawners))
		{
			for(x=0;x<spawners.size;x++)
			{
				guy = spawners[x] dospawn();
				if(isdefined(guy))
				{
					guy.groupname = "assemblyroom_germans";
					guy thread maps\_pi_utils::delayed_run_to_target();
				}
			}
		}

//		level waittill ("fact_floor_respawn2");
		maps\_pi_utils::wait_for_group_clear("assemblyroom_germans", 4, "fact_floor_respawn2");
	}
}

fact_go_die()
{
	level.die_count++;

	wait ( 0.2 );

	self thread maps\_pi_utils::run_blindly_to_nodename ( "die_spot", "targetname", 10 );

	self waittill("death");

	level.die_count--;
	if(level.die_count < 2)
	{
		level.flags["do_factory_pf"] = true;
		level notify ("do_factory_pf");
//		println("^5 fact_go_die: enough death! kill the MG42!");
	}
}

watch_factory_mg_team()
{
	maps\_pi_utils::wait_for_group_clear("assembly_mg", 2, "do_factory_pf");
//	println("^4 watch_factory_mg_team: whoa! someone's killing the MG! start the PF!");

	level.flags["do_factory_pf"] = true;
	level notify("do_factory_pf");
}

factory_pf_guy()
{
	if(level.flags["do_factory_pf"] == false)
		level waittill ("do_factory_pf");

	if(level.flags["fact_pf_started"] == false)
	{
//		println("^4 factory_pf_guy: started PF guy");
		level.flags["fact_pf_started"] = true;
		level thread maps\ponyri_dummies::factory_pf_guy();
	}
}

catwalk_room()
{
	trig = getent ("catwalk1_trigger", "targetname");
	if(isdefined(trig))
	{
		trig waittill ("trigger");

		spawners = getentarray ( "catwalk_room_guys", "targetname" );
		if(isdefined(spawners))
		{
			for(x=0;x<spawners.size;x++)
			{
				guy = spawners[x] dospawn();
				if(isdefined(guy))
				{
//					println("^5 catwalk_room: new bad guy!");
					guy.targetname = "fact_stair_guy";
				}
			}

			door = getent("factory_catwalk_door_01","targetname");
			door playsound("wood_door_kick");
			door rotateto((0,-90,0), 0.5, 0, 0.2);
			door waittill("rotatedone");
			door connectpaths();
		}
	}
	else println("^5 catwalk1_trigger - missing??");
}

pester_player_about_pf()
{
	wait ( 3 );

	level endon ("panzer2_dead");
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_pfaust");

	wait ( 15 );
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_pfaust2");
	objective_ring(level.factory_obj_num);

	wait ( 15 );
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_pfaust2");
	objective_ring(level.factory_obj_num);
}

catwalk_speech_trigger()
{
	// wait til player is approaching assembly room
	start_trigger = getent ( "catwalk_speech_trigger", "targetname" );
	if(isdefined(start_trigger))
	{
		start_trigger waittill ( "trigger" );
		level thread closest_guy_speaks ("anon_tooquiet4"); // while our forces keep them occupied, we'll slaughter them from within

		level.player setfriendlychain ( getnode ( "fact_catwalk_prechain", "targetname"));
	}
	else println("^5 catwalk_speech_trigger - missing??");
}

assembly_room()
{
	// wait til player is approaching assembly room
	start_trigger = getent ( "assembly1_trigger", "targetname" );
	if(isdefined(start_trigger))
		start_trigger waittill ( "trigger" );

	level notify ("radio_room_done");

	panzer2_placeholder = getent ("factory_shooting_panzer", "targetname");
	panzer2 = maps\ponyri_fa::vehicle_spawn(panzer2_placeholder);

	panzer2_path = getvehiclenode ( panzer2.target, "targetname" );
	panzer2 show();
	panzer2 attachpath (panzer2_path);

	level thread catwalk_speech_trigger();
	level thread catwalk_room();

	stairguys = [];
	spawners = getentarray ( "factory_stair_spawners", "targetname" );
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			guy = spawners[x] dospawn();
			if(isdefined(guy))
			{
				wait (0.1);
				guy.pacifist = true;
				guy.maxsightdistsqrd = 10;
				guy.targetname = "fact_stair_guy";
				stairguys[stairguys.size] = guy;
			}
		}
	}

	// set up the guys running up the stairs to reinforce the window guys
	level thread catwalk_stairs_trigger();

	// ring the objective downstairs
	ec_spot = getnode ( "ec_spot", "targetname" );
	objective_string(level.factory_obj_num, &"PI_PONYRI_OBJECTIVE5D");
	objective_position (level.factory_obj_num, ec_spot.origin );
	objective_current(level.factory_obj_num);
	objective_ring(level.factory_obj_num);

	// then wait for the window guys to die out
	maps\ponyri_rail::wait_for_group_clear("fact_window_germans", 2, "factory_window_clear");

	// bring the team out onto the catwalk
	level.player setfriendlychain( getnode ("catwalk_chain", "targetname") );

//	println("^5 assembly_room: immortals to the green room");
	level.antonov thread maps\_pi_utils::run_blindly_to_nodename ( "fact_room_cover1", "targetname", 10 );
	level.boris thread maps\_pi_utils::run_blindly_to_nodename ( "fact_room_cover2", "targetname", 10 );
	wait(0.05);
	level.miesha thread maps\_pi_utils::run_blindly_to_nodename ( "fact_room_cover3", "targetname", 10 );
	level.vassili thread maps\_pi_utils::run_blindly_to_nodename ( "fact_room_cover4", "targetname", 10 );
	wait(0.05);

//	println("^5 assembly_room: yard russians to staging");
	guys = getentarray ( "yard_russian_guy", "targetname" );
	if(isdefined(guys))
	{
		for(x=0;x<guys.size;x++)
		{
			if(isdefined(guys[x]) && issentient(guys[x]) && isalive(guys[x]))
			{
				guys[x] thread maps\_pi_utils::run_blindly_to_nodename ( "fact_room_staging", "targetname", 10 );
				guys[x] notify ("stop magic bullet shield");
			}
		}
	}
	wait (0.05);

	for(x=0;x<stairguys.size;x++)
	{
//		println("^5 assembly_room: sending a dude up the stairs");
		stairguys[x] thread maps\_pi_utils::run_blindly_to_nodename ( "catwalk_stairs_top", "targetname", 300000 );
	}

	door1 = getent ("fact_doors_closed", "targetname");
	door1 maps\_utility_gmi::triggerOff();
	door1 connectpaths();
	door2 = getent ("fact_doors_open", "targetname");
	door2 maps\_utility_gmi::triggerOn();

	explosion_speaker = getent ( "explosion_speaker", "targetname" );

	if (level.flags["catwalk_stairs_trigger"] == false)
		level waittill ("catwalk_stairs_trigger");

	// send your friends to the stairs
	level.player setfriendlychain ( getnode ( "fact_catwalk_end_chain", "targetname" ));

	// make sure the player's heading downstairs
	trig = getent( "catwalk_stairs_bottom_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ("trigger");

	// send your friends downstairs
	level.player setfriendlychain ( getnode ( "fact_floor_chain", "targetname" ));

	wait ( 1 );

	// blow the door
	thread maps\_utility_gmi::exploder(1);
	explosion_speaker playsound ( "factory_explosion" );

//	wait (0.1);
	thread maps\_utility_gmi::exploder(2);

	wait ( 0.1 );

	// thin the herd a bit
	level.maxfriendlies = 6;

	// bring some guys up to the sandbags
	spawners = getentarray ( "fact_floor_ger1", "targetname" );
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			guy = spawners[x] dospawn();
			if(isdefined(guy))
			{
				guy.groupname = "assemblyroom_germans";
//				guy thread floor_ger1_death();
				guy thread maps\_pi_utils::delayed_run_to_target();
			}
		}
	}

	wait ( 0.1 );

	level thread factory_pf_guy();
	level thread watch_factory_mg_team();

	// send some russians to their deaths
//	println("^5 assembly_room: run for it guys!!");
	guys = getentarray ( "yard_russian_guy", "targetname" );
	if(isdefined(guys))
	{
		for(x=0;x<guys.size;x++)
		{
			if(isdefined(guys[x]) && issentient(guys[x]) && isalive(guys[x]))
			{
				guys[x].health = 50;
				guys[x] notify ("stop magic bullet shield");	// just in case
				guys[x] thread fact_go_die();
			}
		}
	}

//	println("^4 waiting for the panzerfaust explosion");
	level waittill ( "fact_pf_boom" );
//	println("^4 assembly_room: killing MG gunners!");
	maps\_pi_utils::KillEntArray("assembly_mg","groupname");

	// put the non-dead russians on the teamchain
	guys = getentarray ( "yard_russian_guy", "targetname" );
	if(isdefined(guys))
	{
		for(x=0;x<guys.size;x++)
		{
			if(isdefined(guys[x]) && issentient(guys[x]) && isalive(guys[x]))
			{
				guys[x].targetname = "friendlywave_guy";
				guys[x] setgoalentity (level.antonov);
			}
		}
	}

	// move the immortals up
	level.antonov setfriendlychain ( getnode ("fact_rus_chain1", "targetname" ));
	level.miesha setgoalentity (level.antonov);
	level.antonov setgoalentity (level.antonov);

	level.vassili setfriendlychain ( getnode ("fact_rus_chain2", "targetname" ));
	level.boris setgoalentity (level.vassili);
	level.vassili setgoalentity (level.vassili);

	level.flags["fact_floor_movein"] = true;

//	if(level.flags["fact_floor_respawn"] == false)
//		level waittill ( "fact_floor_respawn" );
	maps\_pi_utils::wait_for_group_clear("assemblyroom_germans", 4, "fact_floor_respawn");

	// fire up the second panzer
	panzer2 maps\_panzerIV_gmi::init();
	panzer2 thread panzer2_think();

	// bring some germans up to the sandbags
	level thread second_german_floor_wave();

	level thread pester_player_about_pf();

	// give the player a new objective - get the PF and kill the tank
	factory_pf = getent ( "factory_pf", "targetname" );
	objective_string(level.factory_obj_num, &"PI_PONYRI_OBJECTIVE5C");
	objective_position (level.factory_obj_num, factory_pf.origin );
	objective_current(level.factory_obj_num);
	objective_ring(level.factory_obj_num);

	// wait until the player kills panzer2
	if(isdefined(panzer2))
	{
		if(isalive(panzer2))
			panzer2 waittill ( "death" );
		else
			println("^5 assembly_room: panzer is already dead!");
	}
	else
		println("^5 assembly_room: panzer is already undefined!");
	level notify ("panzer2_dead");
	level.flags["panzer2_dead"] = true;

	// let's move guys in
	level.antonov setfriendlychain ( getnode ("assembly_rus_movein_east", "targetname" ));
	level.vassili setfriendlychain ( getnode ("assembly_rus_movein_west", "targetname" ));

	objective_string(level.factory_obj_num, &"PI_PONYRI_OBJECTIVE5D");
	objective_current(level.factory_obj_num);

	maps\_pi_utils::wait_for_group_clear("assemblyroom_germans", 1, "go_for_basement");

	maps\_pi_utils::KillEntArray("assembly_mg","groupname");

	end_speech();

	wait ( 5 );

	missionSuccess ("kursk", false);
}

// ================================
// ================================
//	Cleanup Utils
// ================================
// ================================

CleanApproach()
{
	println("^5 CleanApproach: shutting down fapp FX");
	level notify ("stop_fapp_fx");

	maps\_pi_utils::DeleteEntArray ( "fapp1", "groupname" );
	wait(0.1);
	maps\_pi_utils::DeleteEntArray ( "fapp2", "groupname" );
	wait(0.1);
	maps\_pi_utils::DeleteEntArray ( "fapp3", "groupname" );
	wait(0.1);
	maps\_pi_utils::DeleteEntArray ( "fapp4", "groupname" );
	wait(0.1);
	maps\_pi_utils::DeleteEntArray ( "fapp5", "groupname" );
	wait(0.1);
	maps\_pi_utils::DeleteEntArray ( "fapp6", "groupname" );
	wait(0.1);
	maps\_pi_utils::DeleteEntArray ( "fapp7", "groupname" );
	wait(0.1);
	maps\_pi_utils::DeleteEntArray ( "fapp8", "groupname" );
	wait(0.1);
	maps\_pi_utils::DeleteEntArray ( "fapp9", "groupname" );
}

CleanFactoryOffices()
{
	trigger = getent ( "factory_floor", "targetname" );
	if( isdefined (trigger) )
	{
		trigger waittill ( "trigger" );

		maps\_pi_utils::KillEntArray ( "fact1", "groupname" );
		wait(1);
		maps\_pi_utils::KillEntArray ( "fact2", "groupname" );
		wait(1);
		maps\_pi_utils::KillEntArray ( "fact3", "groupname" );
		wait(1);
		maps\_pi_utils::KillEntArray ( "fact4", "groupname" );
	}
	else println("^5CleanFactoryOffices: wheres factory_floor?");
}