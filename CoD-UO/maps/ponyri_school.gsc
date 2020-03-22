main()
{
	level.flags["school_mg_dead"] = false;
//	level.flags["bomb_guy_killable"] = false;
	level.flags["school1_done"] = false;
	level.flags["school2_done"] = false;
	level.flags["school_mg_announced"] = false;

	level.school_voice = 0;

	level waittill ("continue_school_main");

	thread school_mg_superman();
	thread school_mg_clarkkent();
	thread school_approach();
	thread school_sneak_stop();
}

blind()
{
	self.maxsightdistsqrd = 10;	// make him blind
	self.suppressionwait = 0;
	self.pacifist = true;
}

sight()
{
	self.maxsightdistsqrd = 4000000;
	self.suppressionwait = 0;
	self.pacifist = false;
}

school_door_trigger()
{
	spawner = getent ("school_door_guy_spawner", "targetname");
	if(isdefined(spawner))
	{
		guy = spawner dospawn();
		if(isdefined(guy))
		{
			guy.targetname = "school_door_guy";
			guy thread maps\_utility_gmi::magic_bullet_shield();
			
			wait (0.1);
			guy blind();
		}
		else
		{
			door  = getent("schoolhouse_entrance_door_01","targetname");
			door2 = getent("schoolhouse_entrance_door_02","targetname");
			door  rotateto((0,90,0), 0.5, 0, 0.2);
			door2 rotateto((0,-90,0), 0.5, 0, 0.2);
			door  playsound("wood_door_kick");
			door2 waittill("rotatedone");
			door  connectpaths();
			door2 connectpaths();
		}
	}

	// wait for the school MG guy to be announced
	if(level.flags["school_mg_announced"] == false)
		level waittill ("school_mg_announced");

	maps\ponyri_fx::spawnSchoolFX();

	trigger = getent ( "school_door_trigger", "targetname" );
	if(isdefined (trigger) )
	{
		trigger waittill ( "trigger" );
	}

	if(isdefined(guy))
		maps\ponyri_fa::kick_door_in ( guy, "schoolhouse_entrance_door_01", "school_door_node", "schoolhouse_entrance_door_02");
	
	level.player setfriendlychain ( getnode ( "school1_chain", "targetname" ));

	if(isdefined(guy))
	{
		guy.targetname = "friendlywave_guy";
		guy setgoalentity (level.player);
		guy notify ("stop magic bullet shield");
		guy sight();
	}
}

school_sneak_stop()
{
	level endon ( "allow_sneaking" );

	trigger = getent ( "school_sneak", "targetname" );
	if(isdefined (trigger))
	{
		guys = getentarray ( "sneak_stopper", "targetname" );
		if(isdefined ( guys ))
		{
			sneaking = 1;
			sneaker = 0;
			while (sneaking)
			{
				wait ( 0.5 );
				trigger waittill ("trigger");
							
				sneaks = getentarray ( "school_sneak_stopper", "targetname" );
				if(sneaks.size < 2)
				{
					sneaker = randomint ( guys.size );
					
					new_sneak = guys[sneaker] dospawn();
					if(isdefined(new_sneak))
					{
						new_sneak.targetname = "school_sneak_stopper";
						new_sneak thread maps\_pi_utils::run_blindly_to_nodename (guys[sneaker].target, "targetname" );
					}
				}
				else
				{
					wait ( 2 );
				}
			}
		}
		else println( "^5school_sneak_stop: no sneak_stopper guys");
	}
	else println( "^5school_sneak_stop: where's school_sneak?");
}

School_ReplaceApproach(guy)
{
//	println("^2 School_ReplaceApproach: Friendly Wave Guy Spawned!");
	guy.targetname = "friendlywave_guy";
	guy.groupname = "friendlywave_guy";

	wait ( 0.1 );

	guy.goalradius = 128;
	guy.followmin = -3;
	guy.followmax = 1;
	guy setgoalentity (level.player);
}

school_doors()
{
	door = getent("schoolhouse_bigdoor_1","targetname");
	door playsound("wood_door_kick");
	door rotateto((0,-90,0), 0.5, 0, 0.2);
	door2 = getent("schoolhouse_bigdoor_2","targetname");
	door2 rotateto((0,90,0), 0.5, 0, 0.2);

	door waittill("rotatedone");
	door connectpaths();
	door2 connectpaths();
}

school_go_die()
{
	self setgoalnode ( getnode ("school_die_node", "targetname" ));
	self waittill ("goal");
	self dodamage (self.health+50, self.origin);
}

school_approach()
{
	superman_bulletshield = getent ("superman_bulletshield", "targetname");
	superman_bulletshield maps\_utility_gmi::triggerOff();

	// wait for the school MG guy to be announced
	if(level.flags["school_mg_announced"] == false)
		level waittill ("school_mg_announced");

	// watertower area complete, send folks towards the school
	level.player setFriendlyChain(getnode ( "goto_school_chain", "targetname" ));
	
	level thread school_objectives();

	// wait for the player to get close to the school
	trigger = getent ( "school_approach", "targetname" );
	if(isdefined (trigger))
		trigger waittill ( "trigger" );

	level thread maps\ponyri_rail::CleanRailyard();

	// spawn in the first german fight
	spawners = getentarray("school1", "targetname");
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			guy = spawners[x] dospawn();
			if(isdefined(guy))
			{
				guy.targetname = "school1_guy";
				guy thread maps\_pi_utils::delayed_run_to_target();
			}
		}
	}

	// send the immortals to the first back window
	level.antonov setfriendlychain (getnode ( "window2_chain", "targetname" ));
	level.antonov setgoalentity (level.antonov);
	level.vassili setgoalentity (level.antonov);
	level.boris setgoalentity (level.antonov);
	level.miesha setgoalentity (level.antonov);

	// cut the number of redshirts back down to immortals + 2
	redshirts = getentarray ( "friendlywave_guy", "targetname" );
	if(isdefined(redshirts))
	{
		for(x=2;x<redshirts.size;x++)
		{
			redshirts[x] thread school_go_die();
		}
	}

	level thread school1_trigger();
	level thread school2_trigger();
	level thread school3_trigger();
}

school1_trigger()
{
	trig = getent( "school1_trigger", "targetname" );
	if(isdefined(trig))
	{
		trig waittill ( "trigger" );

//		println("^5 school1_trigger: player inside school");
		level notify ("player_inside_school");

		maps\_pi_utils::wait_for_group_clear("school1", 2, "school1_wave");

		spawners = getentarray("school1w", "targetname");
		if(isdefined(spawners))
		{
			for(x=0;x<spawners.size;x++)
			{
				guy = spawners[x] dospawn();
				if(isdefined(guy))
				{
					//println("^5 school1_trigger: new bad guy!");
					guy.targetname = "school1_guy";
					guy thread maps\_pi_utils::delayed_run_to_target();
				}
			}
		}

		level thread school2_fight();
		level thread school2_auto();

		door = getent ("schoolhouse_downstairs_door_01", "targetname");
		door playsound("wood_door_kick");
		door rotateto((0,-130,0), 0.5, 0, 0.2);
		door waittill("rotatedone");
		door connectpaths();

		maps\_pi_utils::wait_for_group_clear("school1", 1, "school1_done");
		level.flags["school1_done"] = true;

		level.antonov setfriendlychain (getnode ( "window3_chain", "targetname" ));
	}
	else println("^5 school1_trigger: where's school1_trigger??");
}

school2_trigger()
{
	trig = getent( "school2_trigger", "targetname" );
	if(isdefined(trig))
	{
		trig waittill ( "trigger" );

		level.antonov setfriendlychain (getnode ( "window3_chain", "targetname" ));
	}
}

school2_auto()
{
	spawners = getentarray("school2_auto", "targetname");
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			guy = spawners[x] dospawn();
			if(isdefined(guy))
			{
				//println("^5 school2_auto: new bad guy!");
				guy.targetname = "school2_auto_guy";
//				guy thread maps\_pi_utils::delayed_run_to_target();
			}
		}

		maps\_pi_utils::wait_for_group_clear("school2_auto", 2, "school2_done");

		wait ( 2 );

		// send antonov and friends on
//		level.antonov setfriendlychain (getnode ("window4_chain", "targetname"));
		level.antonov setfriendlychain (getnode ("school_done_chain", "targetname"));
	}
}

school2_fight()
{
	level thread school3_fight();

	spawners = getentarray("school2", "targetname");
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			guy = spawners[x] dospawn();
			if(isdefined(guy))
			{
				//println("^5 school2: new bad guy!");
				guy.targetname = "school2_guy";
				guy thread maps\_pi_utils::delayed_run_to_target();
			}
		}
	}

	if(level.flags["school1_done"] == false)
		level waittill ("school1_done");

	level.player setfriendlychain ( getnode ("school2_chain", "targetname"));

	maps\_pi_utils::wait_for_group_clear("school2", 2, "school2_done");
	level.flags["school2_done"] = true;

	// move the team on
	level.player setfriendlychain ( getnode ("school3_chain", "targetname"));
}

school3_trigger()
{
	trig = getent( "school3_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ( "trigger" );

	level notify ("school3_start");
}

school3_respawn_trigger()
{
	trig = getent( "school3_respawn_trigger", "targetname" );
	if(isdefined(trig))
		trig waittill ( "trigger" );

	level notify ("school3_respawn");
}

school3_fight()
{
	level thread school3_respawn_trigger();

	level waittill ("school3_start");

	level thread school4_trigger();

	spawners = getentarray("school3", "targetname");
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			guy = spawners[x] dospawn();
			if(isdefined(guy))
			{
				//println("^5 school3_fight: new bad guy!");
				guy.targetname = "school3_guy";
//				guy thread maps\_pi_utils::delayed_run_to_target();
			}
		}
	}

	level thread maps\_pi_utils::wait_for_group_clear("school3", 2, "school3_respawn");

	level waittill ( "school3_respawn" );

	spawners = getentarray("school3w", "targetname");
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			guy = spawners[x] dospawn();
			if(isdefined(guy))
			{
				//println("^5 school3w: new bad guy!");
				guy.targetname = "school3_guy";
//				guy thread maps\_pi_utils::delayed_run_to_target();
			}
		}
	}

	maps\_pi_utils::wait_for_group_clear("school3", 1, "school3_done");

	level.player setfriendlychain ( getnode ( "school4_chain", "targetname" ));

	// send antonov and friends on
	level.antonov setfriendlychain (getnode ("school_done_chain", "targetname"));

	school_talking();
}

school_talk()
{
	level endon ("school_shutup");

	while (1)
	{
		if(level.school_voice == 0)
		{
			level.school_voice = 1;
			self playsound ("german_jabber1");
			wait(2.2);
		}
		else if(level.school_voice == 1)
		{
			level.school_voice = 2;
			self playsound ("german_jabber2");
			wait(0.7);
		}
		else if(level.school_voice == 2)
		{
			level.school_voice = 3;
			self playsound ("german_jabber3");
			wait(1.5);
		}
		else if(level.school_voice == 3)
		{
			level.school_voice = 4;
			self playsound ("german_jabber4");
			wait(2.5);
		}
		else if(level.school_voice == 4)
		{
			level.school_voice = 5;
			self playsound ("german_jabber5");
			wait(2.8);
		}
		else if(level.school_voice == 5)
		{
			level.school_voice = 6;
			self playsound ("german_jabber6");
			wait(1.9);
		}
		else if(level.school_voice == 6)
		{
			level.school_voice = 0;
			self playsound ("german_jabber7");
			wait(3.6);
		}
	}
}

school_talking()
{
	speaker = getent( "school_speaker1", "targetname" );
	speaker thread school_talk();

	trig = getent ("school_speaker_trigger", "targetname");
	if(isdefined(trig))
		trig waittill ("trigger");

	level notify ("school_shutup");
	wait(0.1);

	speaker = getent( "school_speaker2", "targetname" );
	speaker thread school_talk();

	trig = getent ("school4_trigger", "targetname");
	if(isdefined(trig))
		trig waittill ("trigger");

	level notify ("school_shutup");
	wait(0.1);

	speaker = getent( "school_speaker1", "targetname" );
	speaker thread school_talk();

	trig = getent ("school_mg_stop", "targetname");
	if(isdefined(trig))
		trig waittill ("trigger");

	level notify ("school_shutup");
	wait(0.1);
}

school4_trigger()
{
	trig = getent( "school4_trigger", "targetname" );
	if(isdefined(trig))
	{
		trig waittill ( "trigger" );

		spawners = getentarray("school4", "targetname");
		if(isdefined(spawners))
		{
			for(x=0;x<spawners.size;x++)
			{
				guy = spawners[x] dospawn();
				if(isdefined(guy))
				{
					//println("^5 school4_trigger: new bad guy!");
					guy.targetname = "school4_guy";
					guy thread maps\_pi_utils::delayed_run_to_target();
				}
			}
		}
	}
}	

school_objectives()
{
	level.player setfriendlychain (getnode ( "goto_school_chain", "targetname" ));

	// for friendly_wave
	level.maxfriendlies = 6;
	level.friendlywave_thread = maps\ponyri_school::School_ReplaceApproach;

	// point the player to the school entrance
	entry = getent ( "school_entrance", "targetname" );
	objective_add(level.school_obj_num, "active", &"PI_PONYRI_OBJECTIVE3A", entry.origin);
	objective_current(level.school_obj_num);
	objective_ring(level.school_obj_num);
	
	// wait until the player goes inside
	level waittill ("player_inside_school");
	
	// point the player to the machinegun nest
	spot = getent ( "school_mg_obj_spot", "targetname" );
	objective_string(level.school_obj_num, &"PI_PONYRI_OBJECTIVE3B");
	objective_position (level.school_obj_num, spot.origin );
	objective_current(level.school_obj_num);
	objective_ring(level.school_obj_num);

	// wait until the machinegun nest is taken out
	level waittill ( "school_mg_dead" );

	// set up the factory approach
	level notify ( "setup_factory_approach" );

	// send the player outside and regroup
	spot = getent ( "fapp_breadcrumb0", "targetname" );
	objective_string(level.school_obj_num, &"PI_PONYRI_OBJECTIVE3C");
	objective_position (level.school_obj_num, spot.origin );
	objective_current(level.school_obj_num);
	objective_ring(level.school_obj_num);

	doorspot = getnode ( "antonov_school_kick", "targetname" );
	if(isdefined (doorspot))
	{
		maps\ponyri_fa::kick_door_in ( level.antonov, "schoolhouse_bigdoor_2", "school_exit_kick_spot", "schoolhouse_bigdoor_1");
	}

//	level.antonov playsound ("antonov_regroup1");
	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_regroup1");

	level.antonov setgoalentity (level.player);
	level.boris setgoalentity (level.player);
	level.miesha setgoalentity (level.player);
	level.vassili setgoalentity (level.player);

	// put everyone back on the friendlychain
	redshirts = getentarray ( "friendlywave_guy", "targetname" );
	if(isdefined (redshirts))
	{
		for(x=0;x<redshirts.size;x++)
		{
			redshirts[x] setgoalentity (level.player);
		}
	}

	// control passed over to ponyri_fa::
}

school_mg_superman()
{
	level endon ( "stop_superman" );

	trigger = getent ( "school_mg", "targetname" );
	if(isdefined (trigger) )
	{
		trigger waittill ( "trigger" );
	
		//println("^5 school_mg_superman: starting church dummy fight");
		level thread maps\ponyri_dummies::church_dummy_fight();

		level thread school_door_trigger();

		mg = getent ( "school_mg_guy_spawner", "targetname" );
		if(isdefined (mg))
		{
			superman = 1;
			while(superman)
			{
				guy = mg dospawn();
				if(isdefined (guy) )
				{
					//println("^5school_mg_superman: superman spawned");
					guy.targetname = "school_mg_guy";
					guy waittill ( "death" );
					//println("^5school_mg_superman: superman killed");
				}
				else println("^5school_mg_superman: superman spawn failed");
				wait ( 3 + randomfloat ( 3 ) );
			}
		}
		else println ("^5school_mg_superman: something weird happened 2");
	}
	else println ("^5school_mg_superman: something weird happened 1");
}

school_mg_clarkkent()
{
	trigger = getent( "school_mg_stop", "targetname" );
	if(isdefined (trigger) )
	{
		trigger waittill ( "trigger" );

		superman_bulletshield = getent ("superman_bulletshield", "targetname");
		superman_bulletshield maps\_utility_gmi::triggerOn();

		level notify ( "stop_superman" );	// shut off the MG42 respawner
		level notify ( "allow_sneaking" );	// shut off the sneak stop trigger

		maps\_pi_utils::KillEntArray("school_sneak_stopper","targetname"); 

		guy = getent ( "school_mg_guy", "targetname" );
		if(isdefined (guy))
			guy waittill ( "death" );

		level notify ( "school_mg_dead" );

		superman_bulletshield maps\_utility_gmi::triggerOff();

		wait (0.1);

		maps\_utility_gmi::exploder(5);		// break open the wall

		wait (0.1);

		maps\ponyri_fx::spawnFappFX();
	}
	else println ("^5school_mg_clarkkent: something weird happened 1");
}

DeleteEntArray(value, key)
{
	group = getentarray ( value, key );
	if(isdefined(group))
	{
		for(x=0;x<group.size;x++)
		{
			if(isdefined(group[x]))
			{
				group[x] delete();
//				println("^2cleanup: deleted "+key+"  "+value+"");
			}
		}
	}
}

CleanSchool()
{
	DeleteEntArray("school_enemy", "groupname");
	wait(0.1);
	DeleteEntArray("school_sneak_stopper", "targetname");
	wait(0.1);
	DeleteEntArray("school_mg_guy", "targetname");
	wait(0.1);

	tank = getent ( "t34_2", "targetname" );
	if(isdefined (tank) )
	{
		stopattachedfx(tank);
		//println("^6CleanSchool: deleting tank");
		tank delete();
	}
	wait(0.1);
	tank = getent ( "t34_3", "targetname" );
	if(isdefined (tank) )
	{
		stopattachedfx(tank);
		//println("^6CleanSchool: deleting tank");
		tank delete();
	}

}
