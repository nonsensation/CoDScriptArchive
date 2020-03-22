#using_animtree("generic_human");
main()
{
	// setup for the watertower explosion sequence
	// this is loaded in ponri_fx as "watertower"
//	level._effect["tower_explode"] = loadfx ("fx/explosions/watertower.efx");
	texp = getent( "tower_expl_origin", "targetname" );

	tower = getent( "tower", "targetname" );
	tower_broken = getent( "tower_broken", "targetname" );
	tower_broken_top = getent( "tower_broken_top", "targetname" );
	tower_gib_ladder = getent( "tower_gib_ladder", "targetname" );
	tower_gib_rail1 = getent( "tower_gib_rail1", "targetname" );
	tower_gib_rail2 = getent( "tower_gib_rail2", "targetname" );

	tower_broken hide();
	tower_broken_top hide();
	tower_gib_ladder hide();
	tower_gib_rail1 hide();
	tower_gib_rail2 hide();

	level.flag["mortars stop"] = false;
	level.flags["railwalltrig"] = false;
	level.flags["tower_ger1_done"] = false;
	level.flags["tower_ger2_done"] = false;
	level.flags["tower_ger3_done"] = false;
	level.flags["tower_ger4_done"] = false;

	// mortar precaching
	level.mortar = level._effect["mortar"];
	precacheShellshock("default_nomusic");

	level waittill ( "railwalltrig" );

	level thread tower_ger1();
	wait (0.1);
	level thread tower_ger2();
	wait (0.1);
	level thread tower_ger3();
	wait (0.1);
	level thread tower_ger4();
	wait (0.1);
	level thread watertower4_trigger();
	wait (0.1);
	level thread watertower2();
	wait(0.1);
	level thread wt_team_movement();
}

////////////////////////////////////////////////////////////////
// setup
////////////////////////////////////////////////////////////////

tower_ger1()
{
	maps\_pi_utils::wait_for_group_clear("tower_ger1", 2, "tower_ger1");

	level.flags["tower_ger1_done"] = true;
	level notify ("tower_ger2_start");
}

tower_ger2()
{
	if(level.flags["tower_ger1_done"] == false)
		level waittill ( "tower_ger2_start" );

	spawners = getentarray ( "watertower2", "targetname" );
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			newguy = spawners[x] dospawn();
			if(isdefined(newguy))
			{
				newguy thread maps\_pi_utils::delayed_run_to_target();
			}
		}
	}
	else println("^5 tower_ger2: no guys to spawn");

	maps\_pi_utils::wait_for_group_clear("tower_ger2", 2, "tower_ger2");

	level notify ( "tower_ger3_start" );
	level.flags["tower_ger2_done"] = true;
}

// PGM FIXME - collapse this if the third fight stays gone

tower_ger3()
{
	if(level.flags["tower_ger2_done"] == false)
		level waittill ( "tower_ger3_start" );

	level notify ("tower_ger4_wake");	// just in case
	level notify ("tower_ger3_done");
	level.flags["tower_ger3_done"] = true;

	level.antonov maps\ponyri_rail::anim_single_solo(level.antonov, "antonov_regroup1");

	crumb = getent ( "wt_crumb3", "targetname" );
	objective_position (level.town_obj_num, crumb.origin );
	objective_ring (level.town_obj_num);
}

watertower4_trigger()
{
	trig = getent ("watertower4_trigger", "targetname");
	if(isdefined(trig))
	{
		trig waittill("trigger");

		level notify ("tower_ger4_wake");	// just in case
		wait(0.1);
		level notify ("tower_ger4_start");
	}

	level notify ("stop_rail_fx");
	println("^5 watertower4_trigger: shutting down rail FX");
}

tower_ger4()
{
	level waittill ( "tower_ger4_wake" );

	spawners = getentarray ( "watertower4", "targetname" );
	if(isdefined(spawners))
	{
		for(x=0;x<spawners.size;x++)
		{
			newguy = spawners[x] dospawn();
			if(isdefined(newguy))
			{
				newguy.targetname = "tower_ger4";
				newguy thread maps\_pi_utils::delayed_run_to_target();
				newguy thread maps\_utility_gmi::magic_bullet_shield();
			}
		}
	}

	level waittill ( "tower_ger4_start" );

//	println("^5 tower_ger4: start the fight");
	guys = getentarray("tower_ger4", "targetname");
	if(isdefined(guys))
	{
		for(x=0;x<guys.size;x++)
		{
//			println("^5 tower_ger4: shutting off MBS");
			guys[x] notify ("stop magic bullet shield");
		}
	}

	maps\_pi_utils::wait_for_group_clear("tower_ger4", 2, "tower_ger4");

	guys = getentarray("street_russians", "groupname");
	if(isdefined(guys))
	{
		for(x=0;x<guys.size;x++)
		{
			if(isdefined(guys[x]) && issentient(guys[x]) && isalive(guys[x]))
			{
//				println("^5 tower_ger4: turning street russians back to normal");
				guys[x].targetname = "friendlywave_guy";
				guys[x] setgoalentity ( level.player );
			}
		}
	}

	level.flags["tower_ger4_done"] = true;
	level notify ("tower_ger4_done");
}

wt_team_movement()
{
	level waittill ( "start_wt_team_movement");
	level.player setFriendlyChain(getnode ( "ditch_chain1", "targetname" ));
	
	if(level.flags["tower_ger1_done"] == false)
	{
		level waittill ("tower_ger2_start");
	}

	// dont move up unless the T34 is well on it's way
	trig = getent("trig_ditch2","targetname");
	if(isdefined(trig))
		trig waittill("trigger");

	crumb = getent ( "wt_crumb1", "targetname" );
	objective_position (level.town_obj_num, crumb.origin );
	objective_ring (level.town_obj_num);

	level.player setFriendlyChain(getnode ( "ditch_chain3", "targetname" ));

	if(level.flags["tower_ger2_done"] == false)
	{
		level waittill ("tower_ger3_start");
	}

	level.player setFriendlyChain(getnode ( "tower1_chain", "targetname" ));

	if(level.flags["tower_ger3_done"] == false)
	{
		level waittill ("tower_ger3_done");
	}

	level.player setFriendlyChain(getnode ( "tower4_chain", "targetname" ));

	if(level.flags["tower_ger4_done"] == false)
	{
		level waittill ("tower_ger4_done");
	}

	// PGM FIXME - make the voice carry using the soundalias file
	// announce the school MG gunner and send control over to ponyri_school::school_objectives
	level.vassili maps\ponyri_rail::anim_single_solo(level.vassili, "vassili_headsdown");

	level notify ( "school_mg_announced" );
	level.flags["school_mg_announced"] = true;
}

watertower2()
{
	trig = getent("watertower2_trigger","targetname");
	if(isdefined(trig))
	{
		trig waittill("trigger");

//		println("^5 watertower2: notify");
		level notify ( "watertower2_trigger" );
		level notify ( "tower_ger2_start" );
		level notify ( "tower_ger4_wake" );

		// turn the remaining warmup guys into friendlywave guys
		warmup_guys = getentarray ( "town_warm_guy1", "targetname" );
		if(isdefined(warmup_guys))
		{
			for(x=0;x<warmup_guys.size;x++)
			{
//				println("^5 watertower2: warmup guy joining team");
				warmup_guys[x].targetname = "friendlywave_guy";
				warmup_guys[x] setgoalentity ( level.player );
			}
		}
	}
	else println("^5watertower2: where's watertower2_trigger");
}

////////////////////////////////////////////////////////////////
// controls for the tanks, handed off from ponyri_rail.gsc
////////////////////////////////////////////////////////////////

t34_3_town_shooting()
{
	level endon ("railwalltrig");

	wait ( 2 );
	shooting = true;
	while(shooting)
	{
		targ = getent ( "t34_3a", "targetname");
		self setTurretTargetEnt( targ, (0,0,0) );
		self waittill( "turret_on_vistarget" );
		wait ( 1 );
		self FireTurret();
		wait ( 2 );

		targ = getent ( "t34_3b", "targetname");
		self setTurretTargetEnt( targ, (0,0,0) );
		self waittill( "turret_on_vistarget" );
		wait ( 1 );
		self FireTurret();
		wait ( 2 );

		targ = getent ( "t34_3c", "targetname");
		self setTurretTargetEnt( targ, (0,0,0) );
		self waittill( "turret_on_vistarget" );
		wait ( 1 );
		self FireTurret();
		wait ( 2 );
	}
}

RailWallBreakthrough()
{
	tspeed = 8;
	taccel = 8;

	t34_2 = getent ( "t34_2", "targetname" );
	t34_3 = getent ( "t34_3", "targetname" );

	watertowertarget = getent("watertower_target", "targetname");

	if(level.flags["t34_shoot_rail_wall"] == false)
		level waittill ("t34_shoot_rail_wall");

	t34_2 thread t34_2_wallbreakthrough();

	t34_3 setspeed(tspeed, taccel); // test speeds

	t34_3 setwaitnode(getvehiclenode("dkramer234","targetname"));
	wait (1);
	t34_3 setTurretTargetEnt( getent ( "walltarget", "targetname" ), ( 0, 0, 0 ) );
	t34_3 waittill("reached_wait_node");
	t34_3 setspeed(0, taccel);

	t34_3 FireTurret();
	wait(.1);
	thread maps\_utility_gmi::exploder(101);

	level notify("wall_broken");


	level waittill("t34_2_through");
	t34_3 setspeed (tspeed, taccel);
	t34_3 clearTurretTarget();


	// now we're waiting for _2 to reach the bridge and pause
	// so we need to wait on a condition here

	level waittill("t34_2_holding");
	t34_3 setspeed(0, taccel);

	level waittill("t34_2_destroyed");
	t34_3 setspeed (tspeed, taccel);


	// START THE MORTARS!
	getent ("mortar attack1","targetname") thread mortar_thread();
	wait (1);
	getent ("mortar attack2","targetname") thread mortar_thread();
	wait (1);
	getent ("mortar attack3","targetname") thread mortar_thread();

	wait (1);

	maps\ponyri_fx::spawnPostRailFX();


	// 252 254
	t34_3 setwaitnode(getvehiclenode("dkramer252","targetname"));
	t34_3 waittill("reached_wait_node");
	t34_3 setTurretTargetEnt( getent ( "jfaulken_blast2", "targetname" ), ( 0, 0, 0 ) );
	t34_3 waittill( "turret_on_vistarget" );
	t34_3 FireTurret();

	t34_3 setwaitnode(getvehiclenode("dkramer254","targetname"));
	t34_3 waittill("reached_wait_node");
	t34_3 setTurretTargetEnt( getent ( "jfaulken_blast1", "targetname" ), ( 0, 0, 0 ) );
	t34_3 waittill( "turret_on_vistarget" );
	t34_3 FireTurret();



	// the other two tanks are dead by this point
	t34_3 waittill("reached_end_node");
	t34_3 setTurretTargetEnt( watertowertarget, ( 0, 0, 0 ) );
	t34_3 waittill( "turret_on_vistarget" );

	level thread tower_timeout();
	level thread tower_wait();

	level waittill ("shoot_tower");

	t34_3 FireTurret();

	// blow up the water tower
	texp = getent( "tower_expl_origin", "targetname" );

	tower = getent( "tower", "targetname" );
	tower_broken = getent( "tower_broken", "targetname" );
	tower_broken_top = getent( "tower_broken_top", "targetname" );
	tower_gib_ladder = getent( "tower_gib_ladder", "targetname" );
	tower_gib_rail1 = getent( "tower_gib_rail1", "targetname" );
	tower_gib_rail2 = getent( "tower_gib_rail2", "targetname" );

	playfx(level._effect["watertower"], texp.origin );
	earthquake( 0.25, 2.0, texp.origin, 5000 );

	tower hide();
	tower_broken show();
	tower_broken_top show();
	tower_gib_ladder show();
	tower_gib_rail1 show();
	tower_gib_rail2 show();

	tower_broken_top rotateTo( (-2, 0, -9), 6, 2, 4 );

	tower_gib_ladder rotateVelocity( (0, 60, 600), 3 );
	tower_gib_ladder moveGravity( (350, 730, 500), 3 );
	tower_gib_rail1 rotateVelocity( (0, 400, 0), 3 );
	tower_gib_rail1 moveGravity( (-50, 650, 0), 3 );
	tower_gib_rail2 rotateVelocity( (0, 850, -20), 3 );
	tower_gib_rail2 moveGravity( (-650, -450, 100), 3 );


	// make the tower guys vulnerable
//	explosion_spot = getent( "wt_explosion_thrower", "targetname");

	watertower_guys = getentarray ( "wt_spotters", "groupname" );
	if(isdefined (watertower_guys))
	{
		for(x=0;x<watertower_guys.size;x++)
		{
			if(isdefined(watertower_guys[x]) && isalive(watertower_guys[x]) && issentient(watertower_guys[x]))
			{
				watertower_guys[x] notify ("stop magic bullet shield");
				watertower_guys[x].allowDeath = true;
				watertower_guys[x] DoDamage ( watertower_guys[x].health + 50, (0,0,0) );
			}
		}
	}

	// now that the spotters are dead, kill the mortar fire
	level notify ("mortars stop");
	level.flag["mortars stop"] = true;

	// the delay for the last mortar after watertower explody
	wait (1);

	// EXPLOSION!
	playSoundinSpace ("mortar_incoming", t34_3.origin);
	mortar_hit_explosion ( t34_3.origin );
	t34_3 notify("death", undefined);
}

tower_wait()
{
	trig = getent ( "tower_look", "targetname" );
	trig waittill ( "trigger" );
	level notify("shoot_tower");
}

tower_timeout()
{
	wait(30);
	level notify("shoot_tower");
}

t34_2_wallbreakthrough()
{
	tspeed = 8;
	taccel = 8;

	self setspeed (tspeed,2);

	// pause while t34_3 blows the wall open
	self setwaitnode(getvehiclenode("dkramer242","targetname"));
	self waittill("reached_wait_node");
	self setspeed(0, taccel);

	level waittill("wall_broken");

	self setspeed(tspeed, taccel);
	self clearTurretTarget();

	// drive up into the wall opening
	self setwaitnode (getvehiclenode("dkramer246", "targetname"));
	self setspeed(tspeed, taccel); // test speeds
	self waittill("reached_wait_node");
	self setspeed(0, taccel);

	self thread t34_3_town_shooting();

	if(level.flags["railwalltrig"] == false)
		level waittill ( "railwalltrig" );

	self setspeed(tspeed, taccel);
	self clearTurretTarget();

	// remove the player clip brush
	wall = getent ("rail_wall_playerclip", "targetname");
	wall maps\_utility_gmi::triggerOff();

	self setwaitnode(getvehiclenode("dkramer246","targetname"));
	self waittill("reached_wait_node");

	level notify("t34_2_through");

	// have boris and miesha re-acquire the player's friendlychain
	level.boris setgoalentity ( level.player );
	level.miesha setgoalentity ( level.player );
//	println("^5t34_2_wallbreakthrough: don't worry, we're coming!");

	// self setTurretTargetEnt( getent ( "rail_handoff_target", "targetname" ), ( 0, 0, 0 ) );

	// right here is where everyone needs to pause...
	// boris comments on how quiet it is
	// then incoming mortar
	// so we need to hold _3 when we reach this point

//	self waittill("reached_end_node");
	self setwaitnode(getvehiclenode("dkramer249","targetname"));
	self waittill("reached_wait_node");

	// advance the troops once
//	level.player setfriendlychain(getnode("jfaulken56","targetname"));

	level notify("t34_2_holding");

	// fire one 'warning' shot in front of the lead tank
/* OLD
	warningshot = getent("warning_shot", "targetname");
	playSoundinSpace ("mortar_incoming", warningshot.origin);
	mortar_hit_explosion ( warningshot.origin );
*/	
// NEW
	warningshot = getent("warning_shot", "targetname");
	warningshot playsound ("mortar_incoming");
	warningshot mortar_hit_explosion_ent ();

	// kill the lead tank
	playSoundinSpace ("mortar_incoming", self.origin);
	mortar_hit_explosion ( self.origin );
	self notify("death", undefined);

	level notify("t34_2_destroyed"); // this makes _3 panic and take off
}

////////////////////////
/////////////////////////

mortar_hit_explosion ( vec )
{
	playfx ( level._effect["mortar"], vec );
	thread playSoundinSpace ("mortar_explosion", vec);
	earthquake(0.3, 3, vec, 850); // scale duration source radius
	do_mortar_deaths (getaiarray(), vec);

	// radiusDamage ( origin, range, max_damage, min_damage);
	radiusDamage (vec, 150, 30, 0);
	
	dist = distance ( level.player.origin, vec );
	if(dist < 32)
	{
		thread maps\_shellshock_gmi::main(4, 1, 1, 1, undefined, "default_nomusic");
	}
}

mortar_hit_explosion_ent ( )
{
	impact_point = self.origin + (0,0,-60);
	playfx ( level._effect["mortar"], impact_point );
	self playsound ("mortar_explosion");
	earthquake(0.3, 3, self.origin, 850); // scale duration source radius
	do_mortar_deaths (getaiarray(), impact_point);

	// radiusDamage ( origin, range, max_damage, min_damage);
	radiusDamage (self.origin, 150, 30, 0);
	
	dist = distance ( level.player.origin, self.origin );
	if(dist < 32)
	{
		thread maps\_shellshock_gmi::main(4, 1, 1, 1, undefined, "default_nomusic");
	}
}

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
			ai[i] DoDamage ( ai[i].health + 50, (0,0,0) );
			continue;
		}
	}
}

////////////////////////////////////
////////////////////////////////////

mortar_thread ()
{
//	thread mortar_stopper();

	waits[0] = 0;
	waits[1] = 1.1;
	waits[2] = 0.2;
	waits[3] = 1.5;
	waits[4] = 1.2;
	waits[5] = 0.9;
	waits[6] = 0.5;
	waits[7] = 0.8;
	waits[8] = 1.2;
	waits[9] = 1.5;
	waits[10]= 0.7;

	index = 0;
	starter = self;
	ent = self;

	while (!level.flag["mortars stop"])
	{
		wait (waits[index] + 1);
		index++;
		if (index >= waits.size)
			index = 0;

/* OLD
		impact_point = ent.origin + (0,0,-60);
		playSoundinSpace ("mortar_incoming", impact_point);
		mortar_hit_explosion ( impact_point );
*/
// NEW 
		ent playsound ("mortar_incoming");
		ent mortar_hit_explosion_ent ();

		if (isdefined (ent.target))
			ent = getent (ent.target,"targetname");
		else
			ent = starter;
	}
}

playSoundinSpace (alias, origin)
{
	org = spawn ("script_origin",(0,0,1));
	org.origin = origin;
	org playsound (alias, "sounddone");
	org waittill ("sounddone");
	org delete();
}
