// BOMBER -- Implemented by Thaddeus Sasser

main()
{
	//model precaching
	precachemodel("xmodel/v_us_air_b-17_l-bomb");
	precachemodel("xmodel/v_us_air_b-17_r-bomb");
	precachemodel("xmodel/v_us_air_b-17_dorsal-turret");
	precachemodel("xmodel/o_br_prp_fireextinguisher_objective");
	precachemodel("xmodel/v_us_air_b-17_bombay_crank_objective");
	precachemodel("xmodel/v_us_air_b-17_fuel_crank_objective");
	precachemodel("xmodel/bomber_end_camera");
	precachemodel("xmodel/bomber_parachute");
	//damaged prop to spin
	precachemodel("xmodel/v_us_air_b-17_prop(d1)");
	//feathered prop model
	precachemodel("xmodel/v_us_air_b-17_prop(d2)");
	//damaged prop model
	precachemodel("xmodel/v_us_air_b-17_prop(d3)");

	//turret precache
	precacheturret("mg_b17_dorsal");

	//hud elem shader precache
	precacheShader("gfx/hud/m_bomber_hud-icon.dds");

	//Jed Added
	level._bomber_range = 17000;	//	how far the turrets on the bomber can see 

	//Setup for Bomber #9, the one that takes a flak hit
	level.b9_hit = false;
	level.b8_contrails_off = false;
	level.b9_contrails_off = false;
	level.b10_contrails_off = false;

	//event controls
	level.flak = false;
	level.inattack = 0;
	level.top_turret_unusable = false;
	level.rwing_fire = false;
	level.lwing_fire = false;
	level.enginefire = [];
	level.enginesonfire = 0;
	level.vo3 = false;
	level.vo3_num = 0;
	level.vo6 = false;
	level.vo6_num = 0;
	level.vo9 = false;
	level.vo9_num = 0;
	level.vo12 = false;					
	//level.vo12_num = 0;					//Not needed
	level.bomber_overall_damagestate = 0;
	level.bomber_wind_shake= 0;
	level.staythere = 0;					//Keeps player in top turret
	level.player_in_dorsal = false;
	level.timer = true;					//setup for timer_utility
	level.ff_warning = false;				//controls "don't tk" vo's
	level.bomb_bay_used = false;
	level.lfiresound = false;
	level.rfiresound = false;
	level.dlp = false;					//controls "there is a vo playing right now"
	level.allow_autosave = true;				//controls when the player is allowed to autosave

	//attack controls
	level.comeflywithme = false;
	level.total_num_kills = 0;
	level.spits_start = false;
	level.spits_end = false;
	level.num_planes_alive = 0;
	level.num_planes_in_attack = [];
	level.num_planes_ended = [];
	level.threshhold = 56; 					//max enemy fighters alive at any given time, it's now 64

	//****************
	//CHEEZ2 ADDITIONS -- This is a difficulty multiplier that is applied if the player is not successful in shooting down planes
	//****************
	level.attack_multiplier = 1;
	level.attack_multiplier_max = 3;
	level.attack_multiplier_timer = 120;
	level.num_planes_must_die = 5;

	level.bomber_speaker = getent("bomber_speaker", "targetname");

	//player bomber target array for enemy fighters
	level.player_target[3][0] = getent("target_rwing", "targetname");
	level.player_target[3][1] = getent("target_rwaist", "targetname");		//fixed
	level.player_target[3][2] = getent("target_rtail", "targetname");
	level.player_target[3][3] = getent("target_rwaist", "targetname");

	level.player_target[6][0] = getent("target_rwing", "targetname");
	level.player_target[6][1] = getent("target_lwing", "targetname");
	level.player_target[6][2] = getent("target_rtail", "targetname");
	level.player_target[6][3] = getent("target_ltail", "targetname");

	level.player_target[9][0] = getent("target_lwing", "targetname");
	level.player_target[9][1] = getent("target_lwaist", "targetname");
	level.player_target[9][2] = getent("target_ltail", "targetname");
	level.player_target[9][3] = getent("target_lwaist", "targetname");

	//Why did I do this?
//	level.player_target[9][0] = getent("target_lwaist", "targetname");
//	level.player_target[9][1] = getent("target_lwaist", "targetname");
//	level.player_target[9][2] = getent("target_lwaist", "targetname");
//	level.player_target[9][3] = getent("target_lwaist", "targetname");

	level.player_target[12][0] = getent("target_rwing", "targetname");
	level.player_target[12][1] = getent("target_lwing", "targetname");
	level.player_target[12][2] = getent("target_rwaist", "targetname");		//fixed
	level.player_target[12][3] = getent("target_lwaist", "targetname");		//fixed

	for(n=0; n<4; n++)
	{
		if(!isdefined(level.player_target[3][n]))
		{
			println("^1NOTDEFINED 3,",n);
		}
		else
		if(!isdefined(level.player_target[6][n]))
		{
			println("^1NOTDEFINED 6,",n);
		}
		else
		if(!isdefined(level.player_target[9][n]))
		{
			println("^1NOTDEFINED 9,",n);
		}
		else
		if(!isdefined(level.player_target[12][n]))
		{
			println("^1NOTDEFINED 12,",n);
		}
	}

	//friendly bomber target arrray for enemy fighters
	level.friendly_target[3][0] = getent("b11", "targetname");
	level.friendly_target[3][1] = getent("b12", "targetname");
	level.friendly_target[6][0] = getent("b6", "targetname");
	level.friendly_target[6][1] = getent("b7", "targetname");
	level.friendly_target[9][0] = getent("b3", "targetname");	
	level.friendly_target[9][1] = getent("b9", "targetname");		
	level.friendly_target[12][0] = getent("b8", "targetname");
	level.friendly_target[12][1] = getent("b10", "targetname");

	//friendly bomber flak target array for random flak hits
	//it would have been classier to set this up in a for loop
	level.flak_target[1] = getent("flak_1", "targetname");
	level.flak_target[2] = getent("flak_2", "targetname");
	level.flak_target[3] = getent("flak_3", "targetname");
	level.flak_target[4] = getent("flak_4", "targetname");
	level.flak_target[5] = getent("flak_5", "targetname");
	level.flak_target[6] = getent("flak_6", "targetname");
	level.flak_target[7] = getent("flak_7", "targetname");
	level.flak_target[8] = getent("flak_8", "targetname");

	//vo controls
	level.done3 = false;	//using these for the voiceovers to change up which one plays
	level.done6 = false;
	level.done9 = false;
	level.done12 = false;

	//sound apex timing for fighter attacks
	level.sound_apex["bf109_attack01"] = 4.5;
	level.sound_apex["bf109_attack02"] = 6.3;
	level.sound_apex["bf109_attack03"] = 3.3;
	level.sound_apex["bf109_attack04"] = 3.0;

	//setcvar("g_gameskill","2");		// THIS IS TEMP %%%DEBUG!!!! REMOVE AT BETA, FORCES SKILL LEVEL TO NORMAL

	// SKILL LEVEL SETTINGS!
	switch ( getcvar("g_gameskill") )
	{
		case "0": level.skill = 1; level.skillname = "Greenhorn"; break;	//greenhorn
		case "1": level.skill = 2; level.skillname = "Normal"; break;		//normal
		case "2": level.skill = 3; level.skillname = "Hardened"; break;		//hardened
		case "3": level.skill = 4; level.skillname = "Veteran"; break;		//veteran
	}
	println("^5Current Skill Level is ", level.skillname);

	//Fixed plane speeds, not being modified by skill level
	level.speed_0 = 160;
	level.speed_90 = 190;
	level.speed_180 = 220;
	level.speed_max = 500;					//maximum speed as fighter approaches edge of map

	//Only variable currently being affected by the level skill
	level.bf109_health = (120 * level.skill) + 121;		//enemy fighter health

	// SKILL LEVEL SETTINGS END

	//functions from other scripts
	maps\_load_gmi::main();
	maps\bomber_dummies::main();
	//maps\_debug_gmi::main();

	//anims
	maps\bomber_anim::main();

	//fx		
	maps\bomber_fx::main();
	maps\_vehiclechase_gmi::main();
	maps\_bf109_gmi::main();

	//map setup
	level thread jiggle_setup();
	level thread spit_setup();
	level thread music();
	level thread friendly_bombers_setup();
	level thread player_bomber_setup();
	level thread strafe_setup();
	level thread fuel_crank_setup();
	level thread hud2_setup();
	level thread landscape(1);
	level thread waist_wind_blend();
	level thread tail_wind_blend();
	level thread rwing_engine_fire_blend();
	level thread lwing_engine_fire_blend();
	level thread friendly_killed_a_bf();

	//player setup
	level.player takeallweapons();
	level thread static_turbulence();
	level thread random_turbulence();
	level thread cheat_teleport();
	level thread hud();
	level thread tailgun_crouch();

	//These set whether or not the player is allowed to lean and / or prone
	//allowLeanLeft(boolean allow);
	//allowLeanRight(boolean allow);
	level.player allowLeanLeft(false);
	level.player allowLeanRight(false);
	level.player allowProne(false);
		
	//SKYBOX / WIND PROBLEM -- PARTICLES DO NOT GET PUSHED OUTSIDE THE SKYBOX -- PARTICLES HAVE WIND "FAKED" ON TO THEM
	//setwind ( (0,180,0), 3000 );

	//ambient sound setup
	level.ambientsound = "ambient_squadron_steady";
	ambientPlay(level.ambientsound);
	
	//garbage cleanup -- these are for collision, they have to be in the map but can be deleted once the map starts
	garbage = getentarray ( "garbage", "targetname");
	for (i=0; i<garbage.size; i++)
	{
		garbage[i] delete();
	}

	wait 0.05;

	//silly quake engine...
	setcvar("cg_hudcompassvisible", "0");
	setcvar("g_speed", "120");
	level thread player_reset_g_speed();

	level thread objective0();
	level thread dorsal_wait_for_player(1);		

	//Gun
	if(  getcvar("username") == "Thad" && getcvar("sv_cheats") == 1 )
	{
		println("^5Leaving the ponygun in place for the pony...");
	}
	else
	{
		gun = getent("ponygun", "targetname");
		gun delete();
	}

	if(getcvarint("sv_cheats") > 0 )
	{	
		if( getcvar("skipto") == "" ) 
		{
			setcvar("skipto", "none");
		}

		if(getcvar("skipto") == "comeflywithme")
		{
			println("^3Fly away!");
			level thread comeflywithme();
			return;
		}
	}

	//Begin the main loop, everything is ready to go...
	level thread control_thread(); 
}

// ***** main controller ***** START
control_thread()
{
	//scheme to pace the whole level
	// flak( density, duration, ramp, flak_event_num )
	//	 0.1 - 1.0, seconds, 0 = none / 1 = up / 2= down, evnum
	//fighter_attacks( total_num_groups, direction_bias, bias_weight, attack_ev_num, group_interval, group_interval_offset )

	level thread start_of_mission();
	level.staythere = 1;
	level waittill ("start of mission done");

	level thread flak1();

	wait 0.5;
	dialogue(93);	

	level waittill ("flak1 done");

	level thread attack1();
	level waittill ("attack1_event_end");

	level thread lull1();
	level waittill("lull1_done");

	wait 4;		//slight pause as spits start to bug out so that the flak doesn't start simultaneously

	level thread flak2();
	level waittill ("flak2_event_done");

	level thread attack2();			
	level waittill ("attack2_event_done");

	level thread flak3();
	level waittill ("flak3_event_done");
}
// ***** end main controller ***** END



//-----------------------
//	JEDS CHANGES

player_sidegun_handler()
{
	while(1)
	{
		owner = self getturretowner();

		if (isdefined(owner) && (owner == level.player))
		{
			if(level.player attackButtonPressed())
			{
				playfxontag(level._effect["bullet_tracer_view"], self, "tag_flash");
//				playfxOnTag ( level._effect["b17_shoot_view"],self, "tag_flash3" );
			}
		}
		wait(0.05);
	}
}

player_tailgun_handler()
{
	lastflash = 0;
	tag = getent("tg_turret", "targetname");
	level.tg_turret = spawnturret("misc_turret", (-511, 0, -44), "mg_b17_rear");
	level.tg_turret linkto(tag,"", (0, 0, 0), (0, 180, 0));
	level.tg_turret setmodel("xmodel/v_us_air_b-17_tail_reticle");
	level.tg_turret setmode("auto_nonai");

	level.tg_turret setcursorhint("HINT_NONE");

	level.use_tg_turret = getent("use_tg_turret", "targetname");
	
	level.use_tg_turret setcursorhint("HINT_NONE");

	level.tg_turret setrightarc(65);
	level.tg_turret setleftarc(65);
	level.tg_turret settoparc(28);
	level.tg_turret setbottomarc(22);

	//	set up the models and turret
	while(1)
	{
		owner = level.tg_turret getturretowner();

		if (isdefined(owner))
		{
			if (owner == level.player)
			{
				if(level.player attackButtonPressed())
				{
					if (lastflash==0)
					{
						playfxontag(level._effect["bullet_tracer_view"], level.tg_turret, "tag_flash3");
						playfxOnTag ( level._effect["b17_shoot_view"],level.tg_turret, "tag_flash3" );
						lastflash = 1;
					}
					else
					{
						playfxontag(level._effect["bullet_tracer_view"], level.tg_turret, "tag_flash2");
						playfxOnTag ( level._effect["b17_shoot_view"], level.tg_turret, "tag_flash2" );
						lastflash = 0;
					}
				}
			}
		}
		wait(0.05);
	}
}


player_dorsal_handler()
{
	lastflash = 0;
	volume = 0.0;


	last_angles = (0,0,0);
	tag = getent("top_turret", "targetname");
	turret = spawnturret("misc_turret", (-511, 0, -44), "mg_b17_dorsal");	//	needs to be changed to player
	turret linkto(tag,"", (0, 0, 0), (0, 0, 0));
	turret setmodel("xmodel/v_us_air_b-17_dorsal-turret");
	turret setmode("auto_nonai");
	level.top_turret = turret;	//this replaces the other level.top_turret definition

	//I'm doing this to cheesily make the hint icon go away on the actual turret icon
	//it gets reset at top_turret_trigger
	level.top_turret maketurretunusable();
	level.top_turret.unusable = true;

	level.top_turret setrightarc(180);
	level.top_turret setleftarc(180);
	level.top_turret settoparc(41);
	level.top_turret setbottomarc(2);

	last_angle = tag.angles;


	while(!level.top_turret_unusable)
	{	
		owner = turret getturretowner();

		if (isdefined(owner))
		{
			if (owner == level.player)
			{
				if(level.player attackButtonPressed())
				{
					if (lastflash==0)
					{
						playfxontag(level._effect["bullet_tracer_view"], turret, "tag_flash3");
						playfxOnTag ( level._effect["b17_shoot_view"],turret, "tag_flash3" );
						lastflash = 1;
					}
					else
					{
						playfxontag(level._effect["bullet_tracer_view"], turret, "tag_flash2");
						playfxOnTag ( level._effect["b17_shoot_view"],turret, "tag_flash2" );
						lastflash = 0;
					}

				}
			}
		}

		//	ok we want to blend here 
		angle = turret gettagangles("tag_flash");
		angle = (angle[0] * 0.0,angle[1] * 1.0,angle[2] * 0.0);

		if (length(angle-last_angle)>1.0)
		{
			if (volume==0.0)
			{
				volume = 1.0;
				tag playloopsound("dorsal_turret_spin");
			}
		}
		else
		{
			if (volume==1.0)
			{
				tag stoploopsound("dorsal_turret_spin");
				tag playsound("dorsal_turret_stop");
				volume = 0.0;
			}
		}
		last_angle = angle;
		
		wait(0.05);
	}
}

find_nearest(point)
{
	things = getentarray("bf","targetname");
	distance = level._bomber_range;
	for(i=0;i<things.size;i++)
	{
		newdistance = distance(things[i].origin,point);
		
		if (newdistance < distance)
		{
			theone = things[i];
			distance = newdistance;
		}
	}
	return theone;
}


// 0 if I'm facing my enemy, 90 if I'm side on, 180 if I'm facing away.
YawBetween(target)
{
	angles = VectorToAngles(target.origin-self.origin);
	yaw = self.angles[1] - angles[1];
	yaw = animscripts\utility::AngleClamp(yaw, "-180 to 180");
	if (yaw<0)
		yaw = -1 * yaw;
	return yaw;
}

friendly_bombers_defend()
{
	waittimer = 3;

	//	if we find i've $%#$ed up with this , we can just re-order the table and we are all set again 
	b17_guns[0] = "tag_nose_right";
	b17_guns[1] = "tag_belly_right";
	b17_guns[2] = "tag_waist_right";
	b17_guns[3] = "tag_tail_right";
	b17_guns[4] = "tag_tail_left";
	b17_guns[5] = "tag_waist_left";
	b17_guns[6] = "tag_belly_left";
	b17_guns[7] = "tag_nose_left";
	
	target = undefined;				//	set our target to none
	mgturret = spawnTurret("misc_turret", ( -511, 0, -44), "b17_dorsal_ai");
	mgturret linkto(self, "tag_turret1", (0, 0, 0), (0, 0, 0));
	mgturret maketurretunusable();	
	mgturret setmode("auto_nonai");
	mgturret setmodel("xmodel/b17_dorsal_ai");
	mgturret setturretaccuracy ( 0.1 );
	mgturret.targetname = "fbt_" + self.targetname;
//	println("TURRET\n",mgturret);	

	self.turret = mgturret;

	while(1)
	{
		wait (0.05);

		//	here we ask do we have a target 
		if (!isdefined(target))	
		{
			//	we don't have a target lets find one
			baddy = find_nearest(self.origin);
			//	any in range ?
			if (isdefined(baddy))
			{
				//	we fire these fake guns regardless
				//	what we want to do is convert the angle between us and the target to a value 0-7
				//	i've added a random wait here because the PARTICLE effect is MADNESS
				if (waittimer == 0)
				{
					side = self YawBetween(baddy)/45;
					playfxontag(level._effect["bullet_tracer"],self,b17_guns[side]);
					waittimer = randomint(3);
				}
				else	
				{
					waittimer--;
				}
				//	end of fake guns

			//	have we ever been picked , nope make a valid picked entry 
				if (!isdefined(baddy.picked))
					baddy.picked = 0;
			//	yup , can we pick it ( is it already picked ) 
				if (baddy.picked == 0)
				{
					target = baddy;
				}
			}
		}

		//	we have a target and is it alive ?

		if (isdefined(target))
		{
			myburstcount = ( randomint ( 30 ) + 5);
		
			target.picked = 1;
			mgturret settargetentity(target);
			
		
			//	SHOOT DAMN YOU SHOOT

			for (n=0; n< myburstcount; n++)			
			{
				waitframe();
				if (isalive(target))
				{
					//line(mgturret.origin,target.origin);
					mgturret ShootTurret();
					playfxOnTag ( level._effect["b17_shoot"], mgturret, "tag_flash2" );
					playfxontag(level._effect["bullet_tracer"], mgturret, "tag_flash");
					playfxontag(level._effect["bullet_tracer"], mgturret, "tag_flash2");
				}
	
			}
					//	aim the gun at his target 
					//	draw a line 
			
					//	here we check if the target has gone out of range , 
					//	if so we clear it's picked field so we can be picked again 

			if(isalive(target))
			{			
				newdistance = distance(mgturret.origin,target.origin);
				if (newdistance > level._bomber_range)
				{
					target.picked = 0;
					target = undefined;
				}
			}
			wait ( randomfloat(1) + 0.25);
		}
	}
}

//	endof jed's rubbish 
//-----------------------



//LANDSCAPE HANDLER
landscape(n)
{
	switch(n)
	{
			//maps\_fx::loopfx( effectname, (x y z), delay_between_shots);
			//loopfx(fxId, fxPos, waittime, fxPos2, fxStart, fxStop, timeout)

		case 1:
			maps\_fx_gmi::loopfx("ground_ocean", (0,0,0), 25.0, undefined, undefined, 100, undefined, undefined, undefined);
			break;

		case 2:
			maps\_fx_gmi::loopfx("ground_coast", (0,0,0), 25.0, undefined, undefined, 200, undefined, undefined, undefined);
			break;

		case 3:
			maps\_fx_gmi::loopfx("ground_fields", (0,0,0), 50.0, undefined, undefined, 300, undefined, undefined, undefined);
			break;

		case 4:
			maps\_fx_gmi::loopfx("ground_city", (0,0,0), 200.0, undefined, undefined, 400, undefined, undefined, undefined);
			break;
	}
}

landscape_trans1()
{
	landscape(2);
	wait 10;
	level notify("stop fx 100");

	wait 6;
	landscape(3);
	level notify("stop fx 200");
}

landscape_trans2()
{
	landscape(4);
	wait 5;
	level notify("stop fx 300");
}

landscape_trans3()
{
	landscape(3);
	wait 5;
	level notify("stop fx 400");
}



// ***** ***** FRIENDLY BOMBERS SETUP ***** ***** START
friendly_bombers_setup()
{
	//set up array of all upper-altitude bombers
	//I should have used this somehow to control their contrails, but I didn't
	//As it is, this is a wasted array
	high_alt = [];
	high_alt[high_alt.size] = getent ("b8", "targetname");
	high_alt[high_alt.size] = getent ("b9", "targetname");
	high_alt[high_alt.size] = getent ("b10", "targetname");
	for (n=0;n<high_alt.size; n++)
	{
		high_alt[n] thread contrails();
	}

	//Finish setup for all friendly bombers
	friendly_bombers = [];
	for (n=2; n<13; n++)
	{
		level.friendly_bombers[n] = getent("b"+n,"targetname");

		level.friendly_bombers[n] settakedamage(1);

		level.friendly_bombers[n].script_maxhealth = 6000;		// Doubled, up from 3000

		level.friendly_bombers[n].script_health = level.friendly_bombers[n].script_maxhealth;

		//Friendly bombers damage state checker
		level.friendly_bombers[n] thread friendly_bombers_damage_check();

//		level.friendly_bombers[n] thread _debugfb();			// Debug stuff for friendly bombers
	}

	//Friendly bombers wait to drop bombs
	for (n=2; n<13; n++)
	{
		level.friendly_bombers[n] thread friendly_drop_bombs();
		level.friendly_bombers[n] thread friendly_bombers_defend();	// JED ADDED
	}
}

_debugfb()
{
	while(1)
	{
		print3d(self.origin + (0, 0, 100), self.script_health, ( 0, 1, 0), 1, 5);
		wait 0.05;
	}
}

//DRONE AMBIENT BATTLES SETUP
#using_animtree("bomber_dummies_path");
dummies_ambient()
{
	level.anim_wait[0] 	= 65;
	level.anim_wait[1] 	= 122;
	level.anim_wait[2] 	= 112;
	level.anim_wait[3] 	= 110;
	level.anim_wait[4] 	= 50; 
	level.anim_wait[5] 	= 113;
	level.anim_wait[6] 	= 115;
	level.anim_wait[7] 	= 97; 
	level.anim_wait[8] 	= 92; 
	level.anim_wait[9] 	= 93; 
	level.anim_wait[10] 	= 109;
	level.anim_wait[11] 	= 95; 
	level.anim_wait[12] 	= 78; 
	level.anim_wait[13] 	= 73;

	//dummies_setup(pos, model, total_tags, angle_offset, loop_time, loop_num, path_anim, anim_wait )
	//level thread maps\bomber_dummies::dummies_setup( (0, 0, 0) , "xmodel/bomber_dummies_ambienta", 1, ( 0, 0, 0) , 1, 1, %bomber_dummies_ambienta, level.anim_wait);

	level thread maps\bomber_dummies::dummies_setup( (0, 0, 0) , "xmodel/bomber_dummies_ambienta", 14, ( 0, 0, 0) , 10, 2, %bomber_dummies_ambienta, 1 );
	
	wait 10;
	level thread maps\bomber_dummies::dummies_setup( (0, 0, 0) , "xmodel/bomber_dummies_ambientb", 14, ( 0, 0, 0) , 8, 3, %bomber_dummies_ambientb, 1 );

	wait 10;	
	level thread maps\bomber_dummies::dummies_setup( (0, 0, 0) , "xmodel/bomber_dummies_ambientc", 14, ( 0, 0, 0) , 5, 4, %bomber_dummies_ambientc, 1 );
}


//Set up all of our bomber crew characters
//PILOT SETUP
pilot_setup()
{
	level.pilot = spawn("script_model", ( 417.5, 21.5, -6) );
	level.pilot.angles = ( 0, 0, 0 );
	level.pilot setmodel ("xmodel/c_br_body_bomber_a");
	level.pilot.animname = "pilot";
	level.pilot UseAnimTree(level.scr_animtree[level.pilot.animname]);
	level.pilot [[level.scr_character["pilot"]]]();

	level.pilot setflaggedanimknobrestart("idleA done", level.scr_anim["pilot"]["pilot_idleA"], 1, 0.5, 1 );
	
	level.pilot waittill("idleA done");
}

//COPILOT SETUP
copilot_setup()
{
	level.copilot = spawn("script_model", ( 417.5, -24.2, -6 ) );
	level.copilot.angles = ( 0, 0, 0 );
	level.copilot setmodel ("xmodel/c_br_body_bomber_a");
	level.copilot.animname = "copilot";
	level.copilot UseAnimTree(level.scr_animtree[level.copilot.animname]);
	level.copilot [[level.scr_character["copilot"]]]();

	level.copilot setflaggedanimknobrestart("idleA done", level.scr_anim["copilot"]["copilot_idleA"], 1, 0.5, 1 );
	
	level.copilot waittill("idleA done");
}

//WIRELESS OP SETUP
wirelessop_setup()
{
	level.wirelessop = spawn("script_model", ( 101, 15, -25.5) );
	level.wirelessop.angles = (0,0,0);
	level.wirelessop setmodel ("xmodel/c_br_body_bomber_a");
	level.wirelessop.animname = "wire";
	level.wirelessop UseAnimTree(level.scr_animtree[level.wirelessop.animname]);
	level.wirelessop [[level.scr_character["wire"]]]();

	level thread wirelessop_motions();
}

wirelessop_idle()
{
	while(1)
	{
		level.wirelessop setflaggedanimknobrestart("anim2 done", level.scr_anim["wire"]["wirelessop_idleB"], 1, 0.5, 1 );

		level.wirelessop waittill("anim2 done");

		n=randomint(3)+3;

		for(i=0; i<n; i++)
		{
			level.wirelessop setflaggedanimknobrestart("anim1 done", level.scr_anim["wire"]["wirelessop_idleA"], 1, 0.5, 1 );
	
			level.wirelessop waittill("anim1 done");
		}

	waitframe();
	}
}

wirelessop_motions()
{
	level.wirelessop setflaggedanimknobrestart("anim done", level.scr_anim["wire"]["wirelessop_motion0"], 1, 0.5, 1 );

	trg = getent("radio_motions_trigger", "targetname");
	
	trg waittill("trigger");

	level.wirelessop setflaggedanimknobrestart("motion1 done", level.scr_anim["wire"]["wirelessop_motion1"], 1, 0.5, 1 );

	trg = getent("radio_motions_trigger2", "targetname");

	trg waittill("trigger");

	level.wirelessop setflaggedanimknobrestart("motion2 done", level.scr_anim["wire"]["wirelessop_motion_trans"], 1, 0.5, 1 );

	level.wirelessop waittill("motion2 done");

	level.wirelessop setflaggedanimknobrestart("motion2 done", level.scr_anim["wire"]["wirelessop_motion2"], 1, 0.5, 1 );
	
	wait 6;

	level thread wirelessop_idle();
}

//TAILGUNNER ANIMS
tailgunner_setup()
{
	level.tgunner = spawn("script_model", ( -529, -1, -46) );
	level.tgunner.angles = (0, 180, 0);
	level.tgunner setmodel ("xmodel/c_br_body_bomber_parachute");
	level.tgunner.animname = "tail";
	level.tgunner UseAnimTree(level.scr_animtree[level.tgunner.animname]);
	level.tgunner [[level.scr_character["tail"]]]();
	level.tgunner_alive = true;

	while(level.tgunner_alive == true)
	{
		for(n=0; n<5; n++)
		{
			level.tgunner setflaggedanimknobrestart("tgunner idle done", level.scr_anim["tail"]["tgunner_idle"], 1, 0.5, 1 );

			if(level.tgunner_alive != true) break;
		
			level.tgunner waittill ("tgunner idle done");
		}
		
		level.tgunner setflaggedanimknobrestart("tgunner idleB done", level.scr_anim["tail"]["tgunner_idleB"], 1, 0.5, 1 );

		if(level.tgunner_alive != true) break;

		level.tgunner waittill("tgunner idleB done");
	}

	blocker = getent("tailgun_blocker", "targetname");
	blocker delete();

	level.use_tg_turret setcursorhint("HINT_ACTIVATE");
	level thread use_tg();

	level.tgunner setflaggedanimknobrestart("tgunner kill done", level.scr_anim["tail"]["tgunner_dead"], 1, 0.5, 1 );
}

use_tg()
{
	while(1)
	{
		level.use_tg_turret waittill("trigger");
		level.tg_turret useby(level.player);
		waitframe();
	}
}

tg_wait_for_player(objnum)
{
	owner = level.tg_turret getturretowner();

	if( ( isdefined(owner) && ( owner == level.player ) ) )
	{
		iwait = false;
		objective_state(objnum, "done");
		objective_current(0);
	}

	iwait = true;

	while(iwait == true)
	{
		owner = level.tg_turret getturretowner();
	
		if( isdefined(owner) )
		{
			if(owner == level.player)
			{
				//Notify tailgun objective that it's done
				objective_state(objnum,"done");				
				iwait = false;
				objective_current(0);
			}
		}
		waitframe();
	}
}

tgunner_gets_strafed()
{
	//get the vehicle nodes
	for(n=1; n<4; n++)
	{
		tg_killer_start[n] = getvehiclenode("tg_killer_" + n, "targetname");

		tg_killer[n] = spawnvehicle( "xmodel/v_ge_air_me-109", "bf-noshoot_"+ (n+3), "BF109", (0,0,0), (0,0,0) );

		tg_killer[n].noregen = true;

		tg_killer[n].loop_num = 1;
		tg_killer[n].health = level.bf109_health;
		tg_killer[n].attachedpath = tg_killer_start[n];
		tg_killer[n].onfire = false;
		tg_killer[n].script_vehiclegroup = 8;
		tg_killer[n].group_num = -1;
		tg_killer[n].plane_num = n;
		tg_killer[n].attackdirection = 6;
		tg_killer[n].p_f = 0;
		tg_killer[n].notatarget = true;

		tg_killer[n] thread maps\_bf109_gmi::init();

		tg_killer[n] thread tg_killer_think(n);
	}
}

tg_killer_think(n)
{
	self endon ("death");

	path = self.attachedpath;

	self attachPath( path );

	self.mytarget = level.tg_turret;

	self thread maps\_vehiclechase_gmi::enemy_vehicle_paths();

	self startPath();
}

//LEFT WAIST GUNNER
lwgunner_setup()
{
	level.lwgunner = spawn("script_model", level.lwg_turret.origin );
	level.lwgunner.angles = (0, 90, 0);
	level.lwgunner setmodel ("xmodel/c_br_body_bomber_parachute");
	level.lwgunner.animname = "lwaist";
	level.lwgunner UseAnimTree(level.scr_animtree[level.lwgunner.animname]);
	level.lwgunner [[level.scr_character["lwaist"]]]();
	level.lwgunner.idle = true;
	level.lwgunner.alive = true;
	
	level.lwg_turret setrightarc(30);
	level.lwg_turret setleftarc(20);
	level.lwg_turret settoparc(25);
	level.lwg_turret setbottomarc(25);

	level.lwg_turret setcursorhint("HINT_NONE");
//	level.lwg_turret sethintstring(&"GMI_SCRIPT_USE_LWG");
	level.lwg_turret maketurretunusable();
	level.lwg_turret hide();

	level.lwg_fake = spawn("script_model", level.lwg_turret.origin );
	level.lwg_fake.angles = level.lwg_turret.angles;
	level.lwg_fake setmodel ("xmodel/w_us_mac_50cal_nopod");
	level.lwg_fake.animname = "lwg_turret";
	level.lwg_fake UseAnimTree(level.scr_animtree[level.lwg_fake.animname]);

	level.lwgunner setflaggedanimknobrestart("anim1 done", level.scr_anim["lwaist"]["lwgunner_idle"], 1, 0.5, 1 );

	level.lwg_fake setflaggedanimknobrestart("anim done", level.scr_anim["lwg_turret"]["lwg_idle"], 1, 0.5, 1 );

	level thread lwgunner_wait_for_death();
}

lwgunner_motions()
{
	level thread lwgunner_motions_trigger();
	
	level.lwgunner.idle = 0;

	if( (level.player_passed == 0) && (level.player_in_dorsal == false) ) 
	{
		level.lwgunner setflaggedanimknobrestart("motion done", level.scr_anim["lwaist"]["lwgunner_motion"], 1, 0.5, 1);
		level.lwgunner waittill("motion done");
	}	
	level.lwgunner.idle = 1;

	level thread lwgunner_and_gun_idle();
}

lwgunner_motions_trigger()
{
	level.player_passed = 0;

	trg = getent("motions_trigger", "targetname");

	trg waittill("trigger");

	level.player_passed = 1;
}

lwgunner_flak()
{
	if(level.lwgunner.alive == false) return;

	level.lwgunner endon("death");

	level.lwgunner setflaggedanimknobrestart("anim done", level.scr_anim["lwaist"]["lwgunner_flak1_in"], 1, 0.5, 1);
	level.lwgunner waittill("anim done");

	while(level.flak == true)
	{
		level.lwgunner setflaggedanimknobrestart("anim done", level.scr_anim["lwaist"]["lwgunner_flak1_loop"], 1, 0.5, 1);
		level.lwgunner waittill("anim done");
	}

	level.lwgunner setflaggedanimknobrestart("anim done", level.scr_anim["lwaist"]["lwgunner_flak1_out"], 1, 0.5, 1);
	level.lwgunner waittill("anim done");

	if ( (level.lwgunner.idle == true) && (level.lwgunner.alive == true) )
	{
		level thread lwgunner_and_gun_idle();
	}
}

lwgunner_and_gun_idle()
{
	while( (level.lwgunner.idle == true) && (level.lwgunner.alive == true) )
	{
		n = randomint( 2 ) + 1;
		for( i = 0; i < n; i++)
		{
			level.lwgunner setflaggedanimknobrestart("anim1 done", level.scr_anim["lwaist"]["lwgunner_idle"], 1, 0.5, 1 );

			level.lwg_fake setflaggedanimknobrestart("anim done", level.scr_anim["lwg_turret"]["lwg_idle"], 1, 0.5, 1 );

			if(level.lwgunner.alive == false) break;
	
			level.lwgunner waittill("anim1 done");
		}

		level.lwgunner setflaggedanimknobrestart("anim2 done", level.scr_anim["lwaist"]["lwgunner_idleB"], 1, 1, 1 );

		level.lwg_fake setflaggedanimknobrestart("anim done", level.scr_anim["lwg_turret"]["lwg_idleB"], 1, 0.5, 1 );

		if(level.lwgunner.alive == false) break;
	
		level.lwgunner waittill("anim2 done");
	}
	if ( (level.lwgunner.idle == false) && (level.lwgunner.alive == true) ) 
	{
		level thread lwgunner_and_gun_fire();
		return;
	}
}

lwgunner_and_gun_fire()
{
	if(level.lwgunner.alive == false)
	{
		println("^3LWGUNNER IS DEAD, ABORTING LWGUNNER_AND_GUN_FIRE");
		return;
	}

	while( (level.lwgunner.idle == false) && ( level.lwgunner.alive == true ) )
	{
		if(level.lwgunner.idle == true || level.lwgunner.alive == false ) break;

		level.lwgunner thread lwg_firing(1);
		level.lwgunner thread lwg_fire_sound(1);

		level.lwgunner setflaggedanimknobrestart("anim done", level.scr_anim["lwaist"]["lwgunner_fireA"], 1, 0.5, 1 );

		level.lwg_fake setflaggedanimknobrestart("anim3 done", level.scr_anim["lwg_turret"]["lwg_fireA"], 1, 0.5, 1 );

		if(level.lwgunner.idle == true || level.lwgunner.alive == false ) break;

		level.lwg_fake waittill("anim3 done");

		if(level.lwgunner.idle == true || level.lwgunner.alive == false ) break;

		level.lwgunner thread lwg_firing(2);
		level.lwgunner thread lwg_fire_sound(2);

		level.lwgunner setflaggedanimknobrestart("anim done", level.scr_anim["lwaist"]["lwgunner_fireB"], 1, 0.5, 1 );

		level.lwg_fake setflaggedanimknobrestart("anim4 done", level.scr_anim["lwg_turret"]["lwg_fireB"], 1, 0.5, 1 );

		if(level.lwgunner.idle == true || level.lwgunner.alive == false ) break;

		level.lwg_fake waittill("anim4 done");
	}
	if ( (level.lwgunner.idle == true) && (level.lwgunner.alive == true) ) 
	{
		level thread lwgunner_and_gun_idle();
	}
}

lwgunner_wait_for_death()
{
	while(level.lwgunner.alive == true)
	{
		wait 0.05;
	}
	println("^3LWGUNNER JUST DIED!");
	level.lwgunner stopanimscripted();
}

lwg_firing(num)
{
	switch(num)
	{
		case 1:	
			wait 1;
			for(n=0; n<77; n++)
			{
				playfxontag (level._effect["waist_tracer"], level.lwg_fake, "tag_flash");
				wait 0.05;
				if(level.lwgunner.alive == false) break;
				if(level.inattack == 0) break;
			}
			break;

		case 2:
			wait 0.666;
			for(n=0; n< 350 ; n++)
			{
				playfxontag (level._effect["waist_tracer"], level.lwg_fake, "tag_flash");
				wait 0.05;
				if(level.lwgunner.alive == false) break;
				if(level.inattack == 0) break;
			}
			break;
	}
}

lwg_fire_sound(num)
{
	if(level.inattack == 0) 
	{
		println("^3RETURNING OUT OF LEFT FIRE SOUND DUE TO NOT INATTACK");
		return;
	}

	if(level.lwgunner.alive == false)
	{
		println("^3RETURNING OUT OF LEFT FIRE SOUND DUE TO GUNNER DEAD");
		return;
	}

	if(level.lfiresound) return;

	level.lfiresound = true;

	switch(num)
	{
		case 1:
			println("^3lwg - 1, wait - 1");
			self waittillmatch("single anim", "weap_50cal_waist_anim");

			println("^1lwg firesound1 playing...!!!!!!!!!!!!!!");
			level.lwgunner playsound("weap_50cal_waist_anim");

			println("^3lwg - 1, wait - 2");
			self waittillmatch("single anim", "weap_50cal_waist_anim");

			println("^1lwg firesound1 playing...!!!!!!!!!!!!!!");
			level.lwgunner playsound("weap_50cal_waist_anim");
		
			level.lfiresound = false;
			break;
	
		case 2:
			println("^3lwg - 2, wait - 1");
			self waittillmatch("single anim", "weap_50cal_waist_anim");

			println("^1lwg firesound2 playing...");
			level.lwgunner playsound("weap_50cal_waist_anim");

			level.lfiresound = false;
			break;
	}
}

lwgunner_death()
{
	level.lwgunner.alive = false;

	level.lwg_turret show();

	level.lwg_turret maketurretusable();

	level.lwg_turret thread player_sidegun_handler();

	level.lwg_fake hide();

	blocker = getent("lwg_blocker", "targetname");

	blocker delete();

	level.lwgunner setflaggedanimknobrestart("anim5 done", level.scr_anim["lwaist"]["lwgunner_death"], 1, 0.5, 1 );

	level.lwgunner waittill ("anim5 done");

	level.lwgunner stopanimscripted();

//	level.lwgunner setanimknobrestart("anim done", level.scr_anim["lwaist"]["lwgunner_dead"], 1, 0.01, 100 );
	level.lwgunner setanimknobrestart(level.scr_anim["lwaist"]["lwgunner_dead"], 1, 0.01, 100 );

	level.use_lwg_turret setcursorhint("HINT_ACTIVATE");

	level thread use_lwg();
}

use_lwg()
{
	level.use_lwg_turret sethintstring(&"GMI_CGAME_USE50CAL");
	level.use_lwg_turret waittill("trigger");

	level.lwg_turret useby(level.player);

	waitframe();

	level thread use_lwg();
}


//RIGHT WAIST GUNNER
rwgunner_setup()
{
	level.rwgunner = spawn("script_model", level.rwg_turret.origin );
	level.rwgunner.angles = (0, -90, 0);
	level.rwgunner setmodel ("xmodel/c_br_body_bomber_parachute");
	level.rwgunner.animname = "rwaist";
	level.rwgunner UseAnimTree(level.scr_animtree[level.rwgunner.animname]);
	level.rwgunner [[level.scr_character["rwaist"]]]();
	level.rwgunner.idle = true;
	level.rwgunner.alive = true;
	
	level.rwg_turret setrightarc(20);
	level.rwg_turret setleftarc(30);
	level.rwg_turret settoparc(25);
	level.rwg_turret setbottomarc(25);

	level.rwg_turret setcursorhint("HINT_NONE");
	level.rwg_turret maketurretunusable();
	level.rwg_turret thread player_sidegun_handler();
	level.rwg_turret hide();

	level.rwg_fake = spawn("script_model", level.rwg_turret.origin );
	level.rwg_fake.angles = level.rwg_turret.angles;
	level.rwg_fake setmodel ("xmodel/w_us_mac_50cal_nopod");
	level.rwg_fake.animname = "rwg_turret";
	level.rwg_fake UseAnimTree(level.scr_animtree[level.rwg_fake.animname]);

	level thread rwgunner_and_gun_idle();
}

tailgun_crouch()
{
	trg = getent("crouchtrigger", "targetname");
	trg waittill("trigger");

	while( level.player istouching(trg))
	{
		level.player allowCrouch(true);
		level.player allowStand(false);
		wait 0.05;
	}
	level.player allowCrouch(false);	
	level.player allowStand(true);
	wait 0.05;
	level.player allowCrouch(true);	

	level thread tailgun_crouch();
}

rwgunner_flak()
{
	//level.rwgunner endon("death");
	rand = randomint(2) + 1;
	switch(rand)
	{
		case 1:	
			level.rwgunner setflaggedanimknobrestart("flakanim1 done", level.scr_anim["rwaist"]["rwgunner_flak1"], 1, 0.5, 1);
		
			level.rwg_fake setflaggedanimknobrestart("flakanim1g done", level.scr_anim["rwg_turret"]["rwg_flak1"], 1, 0.5, 1);
		
			level.rwgunner waittill("flakanim1 done");
		
			level thread rwgunner_and_gun_idle();
		
			break;

		case 2:
			level.rwgunner setflaggedanimknobrestart("flakanim2 done", level.scr_anim["rwaist"]["rwgunner_flak2"], 1, 0.5, 1);
		
			level.rwg_fake setflaggedanimknobrestart("flakanim2g done", level.scr_anim["rwg_turret"]["rwg_flak2"], 1, 0.5, 1);
		
			level.rwgunner waittill("flakanim2 done");
		
			level thread rwgunner_and_gun_idle();
		
			break;
	}			
}

rwgunner_and_gun_idle()
{
	while( (level.rwgunner.idle == true) && (level.rwgunner.alive == true) )
	{
		n2=randomint(5)+3;

		for(i=0; i<n2; i++)
		{
			if(level.rwgunner.idle != true) break;

			level.rwgunner setflaggedanimknobrestart("anim1 done", level.scr_anim["rwaist"]["rwgunner_idle"], 1, 0.1, 1 );

			level.rwg_fake setflaggedanimknobrestart("anim done", level.scr_anim["rwg_turret"]["rwg_idle"], 1, 0.1, 1 );
	
			level.rwgunner waittill("anim1 done");
		}

		level.rwgunner setflaggedanimknobrestart("anim2 done", level.scr_anim["rwaist"]["rwgunner_idleB"], 1, 1, 1 );

		level.rwg_fake setflaggedanimknobrestart("anim done", level.scr_anim["rwg_turret"]["rwg_idleB"], 1, 0.5, 1 );

		if(level.rwgunner.idle != true) break;

		level.rwgunner waittill("anim2 done");
	}
	if((level.rwgunner.idle == false) && (level.rwgunner.alive == true) ) 
	{
		thread rwgunner_and_gun_fire();
		return;
	}
}

rwgunner_and_gun_fire()
{
	if(level.rwgunner.alive == false)
	{
		return;
	}
	while(level.rwgunner.idle == false)
	{
		if(level.rwgunner.idle == true) break;

		level.rwgunner setflaggedanimknobrestart("anim done", level.scr_anim["rwaist"]["rwgunner_fireB"], 1, 0.1, 1 );

		level.rwg_fake setflaggedanimknobrestart("anim3 done", level.scr_anim["rwg_turret"]["rwg_fireB"], 1, 0.1, 1 );

		if(level.rwgunner.idle == true) break;

		level thread rwg_firing(1);
		level.rwgunner thread rwg_fire_sound(1);

		level.rwg_fake waittill("anim3 done");

		if(level.rwgunner.idle == true) break;

		level.rwgunner setflaggedanimknobrestart("anim done", level.scr_anim["rwaist"]["rwgunner_fireA"], 1, 0.5, 1 );

		level.rwg_fake setflaggedanimknobrestart("anim4 done", level.scr_anim["rwg_turret"]["rwg_fireA"], 1, 0.5, 1 );

		if(level.rwgunner.idle == true) break;

		level thread rwg_firing(2);
		level.rwgunner thread rwg_fire_sound(2);

		level.rwg_fake waittill("anim4 done");
	}
	level thread rwgunner_and_gun_idle();
}

rwg_firing(num)
{
	switch(num)
	{
		case 1:
			wait 0.666;
			for(n=0; n< 350 ; n++)
			{
				if(level.inattack == 0) break;
				playfxontag (level._effect["waist_tracer"], level.rwg_fake, "tag_flash");
				wait 0.05;
				if(level.inattack == 0) return;
			}
			break;

		case 2:	
			wait 1;
			for(n=0; n<77; n++)
			{
				if(level.inattack == 0) break;
				playfxontag (level._effect["waist_tracer"], level.rwg_fake, "tag_flash");
				wait 0.05;
				if(level.inattack == 0) return;
			}
			break;
	}
}

rwg_fire_sound(num)
{
	if(level.inattack == 0) 
	{
		println("^3RETURNING OUT OF RIGHT FIRE SOUND DUE TO NOT INATTACK");
		return;
	}

	if(level.rfiresound) return;

	level.rfiresound = true;

	switch(num)
	{
		case 1:
			println("^3rwg - 1, wait - 1");
			self waittillmatch("anim done", "weap_50cal_waist_anim");

			println("^5rwg firesound1 playing...");
			level.rwgunner playsound("weap_50cal_waist_anim");

			println("^3rwg - 1, wait - 2");
			self waittillmatch("anim done", "weap_50cal_waist_anim");

			println("^5rwg firesound1 playing...");
			level.rwgunner playsound("weap_50cal_waist_anim");
		
			level.rfiresound = false;
			break;
	
		case 2:
			println("^3rwg - 2, wait - 1");
			self waittillmatch("anim done", "weap_50cal_waist_anim");

			println("^5rwg firesound2 playing...");
			level.rwgunner playsound("weap_50cal_waist_anim");

			level.rfiresound = false;
			break;
	}

}

rwgunner_death()
{
	level.rwgunner.alive = false;

	blocker = getent("rwg_blocker", "targetname");
	blocker delete();

	level.rwg_fake hide();
	level.rwg_turret show();
	level.rwg_turret maketurretusable();

	level thread harry_call_out();

	level.rwgunner setflaggedanimknobrestart("anim5 done", level.scr_anim["rwaist"]["rwgunner_death"], 1, 0.5, 1 );

	level.rwgunner waittill ("anim5 done");

	level.rwgunner setflaggedanimknobrestart("never", level.scr_anim["rwaist"]["rwgunner_dead"], 1, 0.5, 1 );
}

rwg_wait_for_player(objnum)
{
	iwait = true;
	while(iwait)
	{
		owner = level.rwg_turret getturretowner();
		
		if(isdefined(owner))
		{		
			if(owner == level.player)
			{
				iwait = false;
				level notify("objective 3 done");
			}
		}
		waitframe();
	}
}

harry_call_out()		//This is for when the first waist gunner gets shot
{
	wait 1;
	dialogue(20);
	level thread dialogue(29);
}	

gun_nanny(nanny)
{
	if(nanny == 1)
	{
		owner = level.tg_turret getturretowner();
		if( ( isdefined(owner) && (owner == level.player) ) ) 
		{
			return;
		}
	}
	else
	if(nanny == 2)
	{
		owner = level.top_turret getturretowner();
		if( ( isdefined(owner) && (owner == level.player) ) )
		{
			return;
		}
	}

	//Set the counter variable for mission fail
	numtimes = 0;

	//if the player isn't on the gun yet, nag him
	switch(nanny)
	{
		case 1: 		//TAILGUN
			notongun = true;

			while(notongun == true)
			{
				for(n=0; n<60; n++)
				{
					owner = level.tg_turret getturretowner();
					if( ( isdefined(owner) && (owner == level.player) ) ) 
					{
						notongun = false;
						break;
					}
	
					wait 0.5;
				}

				//Check one last time and return out of the switch if the player is on the gun
				owner = level.tg_turret getturretowner();
				if( ( isdefined(owner) && (owner == level.player) ) ) 
				{
					notongun = false;
					return;
				}

				numtimes++;

				if(numtimes>3)
				{
					setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
					missionFailed();
				}

				level thread dialogue(32);
			}
			break;

		case 2:			//DORSAL TURRET
			notongun = true;

			while(notongun == true)
			{
				for(n=0; n<60; n++)
				{
					owner = level.top_turret getturretowner();
					if( ( isdefined(owner) && (owner == level.player) ) ) 
					{
						notongun = false;
						break;
					}
					
					wait 0.5;
				}

				owner = level.top_turret getturretowner();
				if( ( isdefined(owner) && (owner == level.player) ) ) 
				{
					notongun = false;
					return;
				}

				numtimes++;

				if(numtimes>3)
				{
					setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
					missionFailed();
				}

				level thread dialogue(1);
			}
			break;
	}
}

player_reset_g_speed()
{
	//Wow, this is cheesy but it works:  Reset the player's g_speed to 120 so that savegames don't screw this up
	while(1)
	{
		wait 0.5;
		setCvar("g_speed", "120");
	}
}



// ***** ***** PLAYER BOMBER SETUP ***** ***** START
player_bomber_setup()
{
	//This section sets up the player's bomber and a bunch of entities in the map, as well as defining
	//the majority of the arrays used for control and so on

	//Grab speakers for navigator and bombardier
	level.navigator = getent("speaker_navigator", "targetname");
	level.navigator.animname = "nav";

	level.bombardier = getent("speaker_bombardier", "targetname");
	level.bombardier.animname = "bomb";

	//Set up waist turrets
	level.rwg_turret = getent( "rwg_turret", "targetname" );
	level.lwg_turret = getent( "lwg_turret", "targetname" );

	//fire extinguisher
	level.fireextinguisher = getent( "fireextinguisher", "targetname");

	//use rwg turret
	level.use_lwg_turret = getent( "use_lwg_turret", "targetname");
	level.use_lwg_turret setcursorhint("HINT_NONE");

	//thread setup for crew members
	level thread tailgunner_setup();
	level thread lwgunner_setup();
	level thread rwgunner_setup();
	level thread wirelessop_setup();
	level thread copilot_setup();
	level thread pilot_setup();
	level thread player_dorsal_handler();
	level thread player_tailgun_handler();

	//set up the level.talk_wait array to time the dialogue with the animations
	level.talk_wait = [];
//	level.talk_wait["pilot_a00_01"]		= 3.7;
	level.talk_wait["pilot_a01_01"]		= 3.3;
	level.talk_wait["pilot_a02_01"]		= 2.1;
//	level.talk_wait["pilot_a02_02"]		= 1.0;
	level.talk_wait["pilot_a02_03"]		= 5.3;
	level.talk_wait["pilot_b01_01"]		= 3.6;
	level.talk_wait["pilot_b01_02"]		= 2.1;
	level.talk_wait["pilot_b01_03"] 	= 2.2;
	level.talk_wait["pilot_b01_04"]		= 4.9;
	level.talk_wait["pilot_b01_05"]		= 8.2;
	level.talk_wait["pilot_b01_06"]		= 5.2;
	level.talk_wait["pilot_b01_07"]		= 3;
	level.talk_wait["pilot_c01_01"]		= 4.3;
//	level.talk_wait["pilot_c01_02"] 	= 4.0;
	level.talk_wait["pilot_d01_01"]		= 6.1;
	level.talk_wait["pilot_d01_02"]		= 2.1;
	level.talk_wait["pilot_d01_03"]		= 2.3;
	level.talk_wait["pilot_d01_04"]		= 1.5;
	level.talk_wait["pilot_d01_05"]		= 2.2;
//	level.talk_wait["pilot_e01_01"]		= 2.5;
//	level.talk_wait["pilot_e01_02"]		= 2.0;
	level.talk_wait["pilot_e02_01"]		= 2.0;
	level.talk_wait["pilot_f01_01"]		= 6.9;
	level.talk_wait["pilot_g01_01"]		= 2;
	level.talk_wait["pilot_g01_02"]		= 2;
	level.talk_wait["pilot_g01_03"]		= 2;
	level.talk_wait["pilot_g01_04"]		= 2.1;
	level.talk_wait["pilot_g02_01"]		= 7.9;
	level.talk_wait["pilot_g02_02"]		= 4.5;
	level.talk_wait["pilot_g03_01"]		= 2.5;
	level.talk_wait["pilot_g04_01"]		= 1.3;
	level.talk_wait["pilot_h01_01"]		= 1.6;
	level.talk_wait["pilot_h01_02"]		= 3.0;
	level.talk_wait["pilot_h01_03"]		= 2.9;
	level.talk_wait["pilot_h02_01"]		= 4.7;
	level.talk_wait["pilot_h03_01"]		= 3;

//	level.talk_wait["copilot_a02_01"]	= 2;
	level.talk_wait["copilot_a02_02"]	= 1.5;
	level.talk_wait["copilot_b01_01"]	= 2.3;
	level.talk_wait["copilot_b01_02"]	= 2.3;

	level.talk_wait["bomb_h01_01"] 		= 0.8;
	level.talk_wait["bomb_h02_01"]		= 6.2;

	level.talk_wait["nav_a00_01"]		= 6.8;
	level.talk_wait["nav_b01_01"]		= 2.2;
	level.talk_wait["nav_h01_01"]		= 2.3;

	level.talk_wait["tail_b01_01"]		= 6.6;
	level.talk_wait["tail_b01_02"]		= 2.0;

	level.talk_wait["wire_a02_01"]		= 4.1;
	level.talk_wait["wire_d01_01"]		= 6.2;

	level.talk_wait["spit_c01_01"]		= 6.1;
	level.talk_wait["spit_c01_02"]		= 5.1;

	level.talk_wait["lwaist_b01_01"]	= 3.2;

//========================== New VO Stuff

	level.talk_wait["bertie_radio_panic"]	= 2.0;
	level.talk_wait["spit_c01_01"]		= 6.1;
	level.talk_wait["spit_co1_02"]		= 5.1;
	level.talk_wait["lwaist_dorsal"]	= 5.4;
	level.talk_wait["lwaist_ok"]		= 1.7;
	level.talk_wait["pilot_status"]		= 2.0;
	level.talk_wait["pilot_a00_01"]		= 3.9;
	level.talk_wait["pilot_dorsal"]		= 3.6;
	level.talk_wait["pilot_soundoff"]	= 6.5;
	level.talk_wait["pilot_a02_02"]		= 2.5;
	level.talk_wait["pilot_goto_tail"]	= 2.5;
	level.talk_wait["pilot_e01_02"]		= 2.3;
	level.talk_wait["pilot_end_wave1"]	= 4.2;
	level.talk_wait["pilot_c01_02"]		= 2.3;
	level.talk_wait["pilot_spits_gone"]	= 3.5;
	level.talk_wait["pilot_e01_01"]		= 2.2;
	level.talk_wait["pilot_goto_dorsal"]	= 5.4;
	level.talk_wait["pilot_rwaist_death"]	= 4.9;
	level.talk_wait["pilot_how_far"]	= 2.1;
	level.talk_wait["pilot_ball_status"]	= 2.2;
	level.talk_wait["pilot_useguns_1"]	= 5.1;
	level.talk_wait["pilot_tail_now"]	= 2.7;
	level.talk_wait["pilot_useguns_2"]	= 4.7;
	level.talk_wait["good_shot"]		= 1.8;
	level.talk_wait["rwaist_ok"]		= 1.7;
	level.talk_wait["rwaist_tail_dead"]	= 3.8;
	level.talk_wait["rwaist_death"]		= 4.1;
	level.talk_wait["tail_ok"]		= 2.5;
	level.talk_wait["copilot_a02_01"]	= 3.0;
	level.talk_wait["copilot_radop_dead"]	= 3.6;
	level.talk_wait["ball_bomber_down"]	= 2.8;
	level.talk_wait["ball_fighters_6"]	= 2.8;
	level.talk_wait["ball_ok"]		= 2.9;
	level.talk_wait["pilot_understood"]	= 1.5;
	level.talk_wait["wire_death"]		= 1.2;
	level.talk_wait["misc_flak"]		= 1.0;
	level.talk_wait["nav_one_minute"]	= 2.3;
	level.talk_wait["pilot_friendly"]	= 2.0;
	level.talk_wait["bomb_direct_hit"]	= 2.0;


	//Even newer...
	level.talk_wait["copilot_blownoff"]	= 3.6;
	level.talk_wait["pilot_hang_on"]	= 1.3;
	level.talk_wait["copilot_wanted_more"]	= 2.2;
	level.talk_wait["pilot_descending"]	= 7.7;
	level.talk_wait["copilot_holland"]	= 1.7;
	level.talk_wait["ball_dutchgirl"]	= 3.5;
	level.talk_wait["tail_aye"]		= 1.4;
	level.talk_wait["lwaist_sparks_dead"]	= 3.6;
	level.talk_wait["copilot_lost_good_man"]= 2.7;
	level.talk_wait["pilot_e01_03"]		= 3.9;
	level.talk_wait["rwaist_danny_gone"]	= 1.9;
	level.talk_wait["pilot_carryon"]	= 3.9;
	level.talk_wait["pilot_cant_help"]	= 2.1;
	level.talk_wait["ball_blimey"]		= 3.3;
	level.talk_wait["rwaist_luftwaffe"]	= 1.8;
	level.talk_wait["ball_send_back"]	= 1.8;
	level.talk_wait["pilot_move_it"]	= 1.4;
	level.talk_wait["pilot_goodshow"]	= 2.6;
	//

//========================= End new vo

	level thread props();
	//waist gun wind
	maps\_fx_gmi::loopSound("bomber_wind01", (-182, 92, 27));
	maps\_fx_gmi::loopSound("bomber_wind01", (-128, -103, 27));
	//top turret wind
	maps\_fx_gmi::loopSound("bomber_wind02", (333, 0, 250));
	//tail gun wind
	maps\_fx_gmi::loopSound("bomber_wind02", (-669, 0, -7));

	//initialize bomber damage states
	level.model_array= [];
	level.model_array[level.model_array.size] = getent("rwing", "targetname");		//0		
	level.model_array[level.model_array.size] = getent("lwing", "targetname");		//1
	level.model_array[level.model_array.size] = getent("rwaist", "targetname");		//2
	level.model_array[level.model_array.size] = getent("lwaist", "targetname");		//3
	level.model_array[level.model_array.size] = getent("rtail", "targetname");		//4
	level.model_array[level.model_array.size] = getent("ltail", "targetname");		//5
	level.model_array[level.model_array.size] = getent("rwing_d1", "targetname");		//6
	level.model_array[level.model_array.size] = getent("rwing_d2", "targetname");		//7
	level.model_array[level.model_array.size] = getent("lwing_d1", "targetname");		//8
	level.model_array[level.model_array.size] = getent("lwing_d2", "targetname");		//9
	level.model_array[level.model_array.size] = getent("rwaist_d1", "targetname");		//10
	level.model_array[level.model_array.size] = getent("rwaist_d2", "targetname");		//11
	level.model_array[level.model_array.size] = getent("lwaist_d1", "targetname");		//12
	level.model_array[level.model_array.size] = getent("lwaist_d2", "targetname");		//13
	level.model_array[level.model_array.size] = getent("rtail_d1", "targetname");		//14
	level.model_array[level.model_array.size] = getent("rtail_d2", "targetname");		//15
	level.model_array[level.model_array.size] = getent("ltail_d1", "targetname");		//16
	level.model_array[level.model_array.size] = getent("ltail_d2", "targetname");		//17
	level.model_array[level.model_array.size] = getent("radio", "targetname");		//18
	level.model_array[level.model_array.size] = getent("radio_d", "targetname");		//19 
	level.model_array[level.model_array.size] = getent("tail_ending", "targetname");	//20 
	level.model_array[level.model_array.size] = getent("waist_ending", "targetname");	//21 
	level.model_array[level.model_array.size] = getent("tail_top", "targetname");		//22 
	level.model_array[level.model_array.size] = getent("tail_end", "targetname");		//23

	//set up coordinates for the break sounds
	level.model_array[10].coord = (-132, -65, 20);
	level.model_array[11].coord = (-132, -65, 20);
	level.model_array[12].coord = (-185, 52, 20);
	level.model_array[13].coord = (-185, 52, 20);
	level.model_array[14].coord = (-315, -46, 0);
	level.model_array[15].coord = (-315, -46, 0);
	level.model_array[16].coord = (-325, 50, 0);
	level.model_array[17].coord = (-325, 50, 0);

	for(n=6; n<18; n++)
	{
		level.model_array[n] hideme();

		if (!isdefined(level.model_array[n]))
		{
			_error(n, "NOT DEFINED!!!");
		}
	}

	level.model_array[19] hideme();
	level.model_array[20] hideme();
	level.model_array[21] hideme();

	level.parts_array = [];
	level.parts_array[level.parts_array.size] = getent("rwing_damage", "targetname");
	level.parts_array[level.parts_array.size] = getent("lwing_damage", "targetname");
	level.parts_array[level.parts_array.size] = getent("rwg_damage", "targetname");
	level.parts_array[level.parts_array.size] = getent("lwg_damage", "targetname");
	level.parts_array[level.parts_array.size] = getent("rtail_damage", "targetname");
	level.parts_array[level.parts_array.size] = getent("ltail_damage", "targetname");

	for(n=0; n<level.parts_array.size; n++)
	{
		//Health for the damage triggers	
		if(n==0 || n==1) 
		{	
			level.parts_array[n].basehealth = 6000;					//I made the wings a little stronger
		}
		else
		{
			level.parts_array[n].basehealth = 3000;	
		}
		
		level.parts_array[n].threshhold1 = (level.parts_array[n].basehealth * 0.66);	//Level for damage state 1
		level.parts_array[n].threshhold2 = (level.parts_array[n].basehealth * 0.33);	//Level for damage state 2
		level.parts_array[n].dmgstate = 0;						//Damage state tracker
		level.parts_array[n].accdmg = 0;

		level thread player_bomber_damage_check(level.parts_array[n]);
	}

	//Flag the wings to be invulnerable until after attack1
	level.parts_array[0] settakedamage(0);
	level.parts_array[1] settakedamage(0);

	level thread bombbay_doors();				//This is to attach the bombbay doors to the bombbay for later opening
	level thread bomb_bay_crank();

	level thread ballturret();				//Start up the random "looking about" movements for the ball turret
}

dorsal_wait_for_player(objnum)
{
	trg = getent("mount_turret", "targetname");

	trg waittill("trigger");

	if(level.top_turret.unusable == true) 
	{
		println("^3Top turret is not usable!");
		return;
	}

	level.player_in_dorsal = true;

	level.top_turret useby(level.player);

	level.top_turret maketurretusable();

	level thread top_turret_hurtme();

	if(objnum==1) level thread keep_player_in_turret();
	
	//Tell the objective to mark itself off, it's completed
	objective_state(objnum,"done");
	objective_current(0);

	while(!level.top_turret_unusable)
	{
		trg waittill ("trigger");

		waitframe();

		level.top_turret useby (level.player);
	}
}

top_turret_hurtme()
{
	while( level.inattack == 0 ) wait 1;

	while(level.inattack != 0)
	{
		trg = getent( "top_turret_hurtme", "targetname" );
	
		trg waittill( "damage", dmg );

		owner = level.top_turret getturretowner();
	
		cv = level.player.health;
		
		cv -= dmg;
		
		if(cv > 1)
		{
			println("^2Player took damage while on top turret");
			level.player.health = cv;
		}

		waitframe();
	}
	level thread top_turret_hurtme();
}

keep_player_in_turret()
{
	if(level.staythere != 1) return;

	level.player allowuse(false);

	level waittill("allow player to exit dorsal turret");	

	level.player allowuse(true);
}


//Set animation support for your guys in your plane
//anim_single_solo (guy, anime, tag, node, tag_entity)
//anim_loop_solo ( guy, anime, tag, ender, node, tag_entity )
pilot_talking()
{
	//FORMAT FOR USE:
	//	level.pilot thread pilot_talking();
	//	play dialogue here...
	//	wait for dialogue time...
	//	level.pilot notify ("stop pilot talk");

//	level.pilot notify ("stop pilot idle");
//
//	level.pilot anim_single_solo(level.pilot, "pilot_talk_in", undefined, undefined, undefined);
//
//	level.pilot thread anim_loop_solo(level.pilot, "pilot_talk_loop", undefined, "stop pilot talk", undefined, undefined);
//
//	level.pilot waittill("stop pilot talk");
//
//	level.pilot anim_single_solo(level.pilot, "pilot_talk_out", undefined, undefined, undefined);
//
//	level.pilot thread anim_loop_solo(level.pilot, "pilot_idle", undefined, "stop pilot idle", undefined, undefined);
}


/*
OBJECTIVES:
1.  Get Into Dorsal Turret
2.  Get To The Tail Gun
3.  Turn Off 3:00 Engine
4.  Man The Tail Gun
5.  Man The Dorsal Turret
6.  Man The Tail Gun
7.  Open Bomb Bay
8.  Put Out Fire In Tail
9. (optional) Turn Off 9:00 Engine
*/

objective0()
{
			// "Protect the Bomber"
	objective_add( 0, "active", &"GMI_BOMBER_OBJECTIVE0" );
	level thread objective1();
}

objective1()		// "Get Into Dorsal Turret"	

{
	level thread player_bomber_invulnerable();

	objectivemarker = getent("mount_turret", "targetname");

	level.current_icon_objective = 4;

	objective_add( 1, "active", &"GMI_BOMBER_OBJECTIVE1",objectivemarker.origin );
	objective_current(1);
}

objective2()		// "Get To Tail Gun"
{
	level thread player_bomber_invulnerable();

	objectivemarker = level.lwg_turret;

	level.current_icon_objective = 7;

	objective_add(2, "active", &"GMI_BOMBER_OBJECTIVE2", objectivemarker.origin);
	objective_current(2);

	level thread tg_wait_for_player(2);		//Sets up turret to wait for player

	level thread gun_nanny(1);
}

//objective3()
//{
//		//this is the engine fire event, it's located in the rwing_enginefire event
//}

objective4()		//Man The Tail Gun, Part II
{
	level thread player_bomber_invulnerable();

	objectivemarker = level.tg_turret;

	level.current_icon_objective = 7;

	objective_add(4, "active", &"GMI_BOMBER_OBJECTIVE4", objectivemarker.origin);
	objective_current(4);

	level thread tg_wait_for_player(4);

	level thread gun_nanny(1);
}

objective5()		//Man the Dorsal Turret, Part II
{
	level thread player_bomber_invulnerable();

	objectivemarker = level.top_turret;

	level.current_icon_objective = 4;

	objective_add(5, "active", &"GMI_BOMBER_OBJECTIVE5", objectivemarker.origin);
	objective_current(5);

	level thread dorsal_wait_for_player(5);

	level thread gun_nanny(2);		//ok so 2 is dorsal, and 1 is tailgun....i dunno
}

objective6()		//Man The Tail Gun, Part III
{
	level thread player_bomber_invulnerable();

	objectivemarker = level.tg_turret;
	
	level.current_icon_objective = 7;


	objective_add(6, "active", &"GMI_BOMBER_OBJECTIVE6", objectivemarker.origin);
	objective_current(6);

	level thread tg_wait_for_player(6);

	level thread gun_nanny(1);
}

objective7()		//Open The Bomb Bay Doors
{
	level thread player_bomber_invulnerable();

	objectivemarker = level.bomb_bay_crank;

	level.current_icon_objective = 1;

	objective_add(7,"active", &"GMI_BOMBER_OBJECTIVE7", objectivemarker.origin);
	objective_current(7);
}

objective8()		//Put Out The Fire In The Tail
{
	level thread player_bomber_invulnerable();

	objectivemarker = level.fireextinguisher;

	level.current_icon_objective = 0;

	objective_add(8,"active", &"GMI_BOMBER_OBJECTIVE8", objectivemarker.origin);
	objective_current(8);

	level waittill("objective 8 complete");
	objective_state(8,"done");
}

//objective9()
//{
//	//this is the optional engine fire event.  It's located in the lwing_enginefire event
//}
// ***** ***** PLAYER BOMBER SETUP ***** ***** END



// *****
// ***** ***** PLAYER BOMBER DAMAGE SECTION ***** ***** START
// *****
get_fighter_targets()
{
	//check for default variables that need to be set up on the entity for this to work properly
	if (!isdefined(self.p_f))
	{
		_error("FIGHTER DOES NOT HAVE P_F DEFINED");
		return;
	}

	if (!isdefined(self.attack_ev_num))
	{
		_error("FIGHTER DOES NOT HAVE ATTACK EVENT NUMBER DEFINED!");
		//println(self.group_num, self.plane_num);
		return;
	}

	//if we already have a valid target and it's alive, return 
	if	(	isdefined(self.mytarget) &&
			!isalive(self.mytarget)
		)
	{
		_error("TARGET DEFINED BUT NOT ALIVE");
		return;
	}

	//ok so we don't have a target defined that's alive
	self.mytarget = undefined;

	rand_target = randomint(4);

	self.rand_target = rand_target;

	self.mytarget = level.player_target[self.attackdirection][rand_target];
	
	if (!isdefined(self.mytarget))
	{
		_error("SELF.MYTARGET IS UNDEFINED INSIDE GET_FIGHTER_TARGETS");

		println("AD ", self.attackdirection);
		println("RT ", self.rand_target);
		println("PF ", self.p_f);
		println("HL ", self.hi_lo);
		println("AEV/GN/PN: ", self.attack_ev_num, "/", self.group_num, "/", self.plane_num);
		println(level.player_target[self.attackdirection][rand_target]);
		_debug(" ");

		return;
	}
}

player_bomber_damage_check(partname)
{
	//Set up checks to determine when bomber parts get damaged
	level thread player_bomber_killed_check();
	accdmg = 0;

	thispart = getent(partname.targetname, "targetname");  //grab the damage trigger

	if(!isdefined(thispart))
	{
		_error("part not defined");
	}

	while ( 1 )
	{
		thispart endon ("death");

		thispart waittill ("damage", dmg, who);

//		thispart.health -= dmg;			//YOU CANNOT DO THIS!!! Code sets the trigger_damage MAX HEALTH to 32000
							//Therefore I've created a script variable to track the damage, accdmg
		thispart.myattacker = who;

		//***********************************************************
		//HERE IS WHERE CHEEZ2 DAMAGE MULTIPLIER COMES INTO EFFECT!!!
		if(level.attack_multiplier>1)
		{
			println("^1ATTACKER DAMAGE INCREASED FROM ",dmg," TO ",(dmg*level.attack_multiplier));
		}
		else
		{	
			println("^3NORMAL DAMAGE OF ",dmg," POINTS");
		}
		dmg = (dmg * level.attack_multiplier);
		//***********************************************************

		thispart.accdmg += dmg;
		
		if (thispart.myattacker == level.player)
		{
			//remonstrate the player for shooting his own plane
			println("^3Hey!  Don't shoot your OWN plane!");
		}

		switch (thispart.dmgstate)
		{
			case 0: mythreshhold = thispart.threshhold1; break;

			case 1: mythreshhold = thispart.threshhold2; break;

			case 2: mythreshhold = 0; break;
		}

		if ( thispart.accdmg >= (thispart.basehealth - mythreshhold) )
		{
			switch (thispart.targetname)
			{
//*****
				case "rwing_damage":  
				
				if (thispart.dmgstate == 2)		
				{
					//What does this do?  Nothing, right now.  The wing is already red, and already counted towards
					//the player's mission fail; it sets this part to a new damage state that has no conditions
					//We could optionally elect to have a new damage state here but the design doesn't call for it

					thispart.dmgstate = 3;

					level.damagestate[2] = 2;	//Notice, this is already at the maximum

					break;
				}
				else
				if (thispart.dmgstate == 1)
				{
					//swap it for 2
					level.model_array[6] hideme();
					level.model_array[7] showme();

					level.bomber_overall_damagestate += 1;	//add one to damage state for death tracking

					thispart.dmgstate = 2;			//set this part to 2, this is totally redundant

					level.damagestate[2] = 2;		//set this to the maximum

					break;
				}
				else
				if (thispart.dmgstate == 0) 			//This is the first hit on this wing
				{
					level thread rwing_engine_fire();	//Start engine fire

					level thread ambient_switch1();		//Change ambient noise to more shake

					//swap it for 1
					level.model_array[0] hideme();		//hideme rwing_d0
					level.model_array[6] showme();		//Show rwing_d1
					println("^5DAMAGE STATE 1 FOR RWING");

					thispart.dmgstate = 1;			//Why am I tracking the damage state of this part twice?

					level.damagestate[2] = 1;		//Set this part to yellow

					break;
				}
			
				break;

//*****
				case "lwing_damage": 

				if (thispart.dmgstate == 2)		
				{
					thispart.dmgstate = 3;

					level.damagestate[3] = 2;

					break;
				}
				else
				if (thispart.dmgstate == 1)				
				{
					//swap it for 2
					level.model_array[8] hideme();
					level.model_array[9] showme();

					level.bomber_overall_damagestate += 1;		//add one to damage state for death tracking

					thispart.dmgstate = 2;

					level.damagestate[3] = 2;

					break;
				}
				else
				if (thispart.dmgstate == 0)				//thread that engine fire here
				{
					level thread lwing_engine_fire();

					level thread ambient_switch1();

					//swap it for 1
					level.model_array[1] hideme();
					level.model_array[8] showme();

					thispart.dmgstate = 1;

					level.damagestate[3] = 1;

					break;
				}
				break;

//*****
				case "rwg_damage":

				if (thispart.dmgstate == 2)
				{				
					break;
				}
				else
				if (thispart.dmgstate == 1)
				{
					//swap it for 2
					level.model_array[10] hideme();
					level.model_array[11] showme();

					coord = spawn("script_origin", level.model_array[11].coord);				

					coord playsound("metal_break");

					thispart.dmgstate = 2;

					level.damagestate[4] = 2;

					level.bomber_overall_damagestate += 1;		//add one to damage state for death tracking

					level notify ("waist_damage_2");

					break;
				}
				else
				if (thispart.dmgstate == 0)
				{
					//swap it for 1
					level.model_array[2] hideme();
					level.model_array[10] showme();

					coord = spawn("script_origin", level.model_array[10].coord);				

					coord playsound("metal_break");

					thispart.dmgstate = 1;

					level.damagestate[4] = 1;

					level notify ("waist_damage_1");

					break;
				}
//*****
				case "lwg_damage": 

				if (thispart.dmgstate == 2)
				{
					break;
				}
				else
				if (thispart.dmgstate == 1)
				{
					//swap it for 2
					level.model_array[12] hideme();
					level.model_array[13] showme();

					coord = spawn("script_origin", level.model_array[13].coord);				

					coord playsound("metal_break");

					thispart.dmgstate = 2;

					level.damagestate[5] = 2;

					level.bomber_overall_damagestate += 1;		//add one to damage state for death tracking

					level notify ("waist_damage_2");

					break;
				}
				else
				if (thispart.dmgstate == 0)
				{
					//swap it for 1
					level.model_array[3] hideme();
					level.model_array[12] showme();

					coord = spawn("script_origin", level.model_array[12].coord);				

					coord playsound("metal_break");

					thispart.dmgstate = 1;

					level.damagestate[5] = 1;

					level notify ("waist_damage_1");

					break;
				}
				break;
//*****
				case "rtail_damage":

				if (thispart.dmgstate == 2)
				{
					break;
				}
				else
				if (thispart.dmgstate == 1)
				{
					//swap it for 2
					level.model_array[14] hideme();
					level.model_array[15] showme();
	
					coord = spawn("script_origin", level.model_array[15].coord);				

					coord playsound("metal_break");

					thispart.dmgstate = 2;

					level.damagestate[6] = 2;

					level.bomber_overall_damagestate += 1;		//add one to damage state for death tracking

					level notify ("tail_damage_2");

					break;
				}
				else
				if (thispart.dmgstate == 0)
				{
					//swap it for 1
					level.model_array[4] hideme();
					level.model_array[14] showme();

					coord = spawn("script_origin", level.model_array[14].coord);				

					coord playsound("metal_break");

					thispart.dmgstate = 1;

					level.damagestate[6] = 1;

					level notify ("tail_damage_1");

					break;
				}

//*****
				case "ltail_damage":

				if (thispart.dmgstate == 2)
				{
					break;
				}
				else
				if (thispart.dmgstate == 1)
				{
					//swap it for 2
					level.model_array[16] hideme();
					level.model_array[17] showme();
	
					coord = spawn("script_origin", level.model_array[17].coord);				

					coord playsound("metal_break");

					thispart.dmgstate = 2;
	
					level.damagestate[7] = 2;

					level.bomber_overall_damagestate += 1;		//add one to damage state for death tracking

					level notify ("tail_damage_2");

					break;
				}
				else
				if (thispart.dmgstate == 0)
				{
					//swap it for 1
					level.model_array[5] hideme();
					level.model_array[16] showme();

					coord = spawn("script_origin", level.model_array[16].coord);				

					coord playsound("metal_break");

					thispart.dmgstate = 1;

					level.damagestate[7] = 1;

					level notify ("tail_damage_1");

					break;
				}
			}
		}

	waitframe();
	}
}

player_bomber_invulnerable()
{
//	println("^5parts invulnerable");
	for(n=0; n< (level.parts_array.size); n++)
	{
		if(n!=0 && n!=1)
		{
			level.parts_array[n] settakedamage(0);
		}
	}

	wait 8;

//	println("^2parts vulnerable");
	for(n=0; n< (level.parts_array.size); n++)
	{
		if(n!=0 && n!=1)
		{
			level.parts_array[n] settakedamage(1);
		}
	}
}

ambient_switch1()
{
	if(level.ambientsound == "ambient_squadron_steady")
	{
		level.ambientsound = "ambient_damage_01";
		ambientPlay(level.ambientsound);
	}
}

ambient_switch2()
{
	if(level.ambientsound == "ambient_damage_01")
	{
		level.ambientsound = "ambient_bomber_destroyed";
		ambientPlay(level.ambientsound);
	}
}

waist_wind_blend()
{
	level waittill("waist_damage_1");

	//this is called when damage1 occurs to either of the offending parties

	blend = spawn( "sound_blend", ( 0.0, 0.0, 0.0 ) );

	// Must force the origin, since spawning in @ origin doesn't seem to take
	blend.origin = ( -184, 0, 20 );

	level thread specific_turbulence(4);

	for (i=0;i<0.65;i+=0.01)
	{
		blend setSoundBlend( "waist_damage_low", "waist_damage_high", i );
		wait (0.01);
	}

	level waittill("waist_damage_2");

	for (i=0.65;i<1;i+=0.01)
	{
		blend setSoundBlend( "waist_damage_low", "waist_damage_high", i );
		wait (0.01);
	}
}

tail_wind_blend()
{
	level waittill("tail_damage_1");

	//this is triggered by either tailpiece taking damage1

	blend = spawn( "sound_blend", (0,0,0) );

	blend.origin = ( -440,0, 0 );

	level thread specific_turbulence(5);

	for (i=0;i<0.65;i+=0.01)
	{
		blend setSoundBlend( "tail_damage_low", "tail_damage_high", i );
		wait (0.01);
	}

	level waittill("tail_damage_2");

	for (i=0.65;i<1;i+=0.01)
	{
		blend setSoundBlend( "tail_damage_low", "tail_damage_high", i );
		wait (0.01);
	}
}

lwing_engine_fire_blend()
{
	level waittill("lwing_engine_fire_1");
	
	blend = spawn ("sound_blend", (0,0,0));

	thisloc = getent("lwing_e_in", "targetname");

	blend.origin = thisloc.origin;

	level thread specific_turbulence(2);

	for (i=0;i<1;i+=0.01)
	{
		blend setSoundBlend( "engine_fire_low", "engine_fire_high", i );
		wait (0.005);
	}

	level waittill("lwing_engine_fire_2");

	for (i=1;i>0;i-=0.01)
	{
		blend setSoundBlend( "engine_fire_high", "engine_fire_low", i );
		wait (0.03);
	}
}

rwing_engine_fire_blend()
{
	level waittill("rwing_engine_fire_1");
	
	blend = spawn ("sound_blend", (0,0,0));

	thisloc = getent("rwing_e_in", "targetname");

	blend.origin = thisloc.origin;

	level thread specific_turbulence(2);

	for (i=0;i<1;i+=0.01)
	{
		blend setSoundBlend( "engine_fire_low", "engine_fire_high", i );
		wait (0.005);
	}

	level waittill("rwing_engine_fire_2");

	for (i=1;i>0;i-=0.01)
	{
		blend setSoundBlend( "engine_fire_high", "engine_fire_low", i );
		wait (0.03);
	}
}

player_bomber_killed_check()
{
	while( 1 )
	{
		if(level.bomber_overall_damagestate > 5)
		{
			level thread player_mission_failed();
			break;
		}

		if((level.bomber_overall_damagestate > 2) && (level.bomber_wind_shake == 0))
		{
			shakespeaker = spawn("script_origin", (0,0,0) );
			shakespeaker playloopsound("damage_shake_high");
			
			level.bomber_wind_shake = 1;
			println("BOMBER WIND SHAKE 1");
			
		}

		if( (level.bomber_overall_damagestate > 4) && (level.bomber_wind_shake == 1))
		{
			level thread ambient_switch2();
			level.bomber_wind_shake = 2;
			println("BOMBER WIND SHAKE 2");
			level thread dialogue(44);
		}

		waitframe();
	}
}

rwing_engine_fire()
{
	if (level.rwing_fire == true)
	{
		_error("RWING ENGINE ALREADY ON FIRE!");
		return;
	}

	level.rwing_fire = true;				//tracking for damage state
	level.rwing_onfire = true;				//tracking for wing on fire state

	level thread engine_fire_timer(1);

	rwing_e1 = getent("rwing_e_in", "targetname");		//inboard engine
	rwing_e2 = getent("rwing_e_out", "targetname");		//outboard engine

	rand_pick = ( randomint(2) + 1 );

	level thread prop_dead( (rand_pick + 2) );
	
	if ( rand_pick != 2)		//note to self: make sure to do some kind of level.rwing_fire check for some reason or other...
	{			
		level thread rwing_engine2_objective();

		//play hit effect, sound
		//rwing_e1 playsound("wing_hit_01");
		rwing_e1 playsound("wing_hit_02");

		maps\_fx_gmi::loopfx("bomber_enginefire1", rwing_e1.origin, 0.15, rwing_e1.origin + (-100, 0, 0), undefined, 1, undefined, undefined, undefined);

		wait 1;

		level thread engine_fire_vo(2);

		level notify ("stop fx 1");
		maps\_fx_gmi::loopfx("bomber_enginefire2", rwing_e1.origin, 0.15, rwing_e1.origin + (-100, 0, 0), undefined, 2, undefined, undefined, undefined);

		wait 2;

		level notify ("stop fx 2");
		//            loopfx(fxId,                 fxPos,           waittime, fxPos2,                    fxStart,   fxStop, timeout, low_fxId, lod_dist)
		maps\_fx_gmi::loopfx("bomber_enginesmoke", rwing_e1.origin, 0.15, rwing_e1.origin + (-100, 0, 0), undefined, 3, undefined, undefined, undefined);

		level waittill("start r_smoke");

		level notify ("stop fx 3");

		maps\_fx_gmi::loopfx("bomber_enginesmoke_end", rwing_e1.origin, 0.15, rwing_e1.origin + (-100, 0, 0), undefined, 9, undefined, undefined, undefined);
	}
	else
	{
		level thread rwing_engine1_objective();

		//play hit effect, sound
		//rwing_e2 playsound("wing_hit_01");
		rwing_e2 playsound("wing_hit_02");

		maps\_fx_gmi::loopfx("bomber_enginefire1", rwing_e2.origin, 0.15, rwing_e2.origin + (-100, 0, 0), undefined, 4, undefined, undefined, undefined);

		wait 1;

		level thread engine_fire_vo(1);

		level notify ("stop fx 4");
		maps\_fx_gmi::loopfx("bomber_enginefire2", rwing_e2.origin, 0.15, rwing_e2.origin + (-100, 0, 0), undefined, 5, undefined, undefined, undefined);

		wait 2;

		level notify ("stop fx 5");
		maps\_fx_gmi::loopfx("bomber_enginesmoke", rwing_e2.origin, 0.15, rwing_e2.origin + (-100, 0, 0), undefined, 6, undefined, undefined, undefined);

		level waittill("start r_smoke");

		level notify ("stop fx 6");

		maps\_fx_gmi::loopfx("bomber_enginesmoke_end", rwing_e2.origin, 0.15, rwing_e2.origin + (-100, 0, 0), undefined, 10, undefined, undefined, undefined);
	}
}

rwing_engine1_objective()
{
		org = level.fuel_crank[1].origin;

		// "Put Out Engine Fire in #1"
		level.current_icon_objective = 2;

		level thread player_bomber_invulnerable();

		objective_add(3, "active", &"GMI_BOMBER_OBJECTIVE3_E1", org );
		objective_current(3);

		println("^1ENGINE1 WAITTILL");

		level waittill ("engine1 extinguished");

		println("^1ENGINE1 EXT");

		objective_state(3,"done");
		objective_current(0);

		level.rwing_onfire = false;
	
		level notify("start r_smoke");
}

rwing_engine2_objective()
{
		org = level.fuel_crank[2].origin;

		// "Put Out Engine Fire in #1"
		level.current_icon_objective = 2;

		level thread player_bomber_invulnerable();

		objective_add(3, "active", &"GMI_BOMBER_OBJECTIVE3_E2", org );
		objective_current(3);

		println("^1ENGINE2 WAITTILL");

		level waittill ("engine2 extinguished");

		println("^1ENGINE2 EXT");

		objective_state(3,"done");
		objective_current(0);

		level.rwing_onfire = false;
	
		level notify("start r_smoke");
}


lwing_engine_fire()
{
	if (level.lwing_fire == true)
	{
		_error("LWING ENGINE ALREADY ON FIRE!");
		return;
	}

	//inboard engine
	level.lwing_fire = true;		//if true, means this wing was on fire at some point
	level.lwing_onfire = true;		//tracking for wing on fire state

	level thread engine_fire_timer(2);

	lwing_e1 = getent("lwing_e_in", "targetname");		//inboard engine
	lwing_e2 = getent("lwing_e_out", "targetname");		//outboard engine

	rand_pick = ( randomint(2) + 1 );

	level thread prop_dead(rand_pick);
	
	if ( rand_pick != 2)		
	{
		level thread lwing_engine3_objective();
		//play hit effect, sound

		//lwing_e1 playsound("wing_hit_02");		//this quit working for whatever reason
		lwing_e1 playsound("wing_hit_02");

		//playfx(level._effect["me109_dis"], self.origin, angles)
		//playfx(level._effect["bomber_enginefire1"], lwing_e1.origin, (0, 90, 0) );
		//loopfx(fxId, fxPos, waittime, fxPos2, fxStart, fxStop, timeout, low_fxId, lod_dist)
		maps\_fx_gmi::loopfx("bomber_enginefire1", lwing_e1.origin, 0.15, lwing_e1.origin + (-100, 0, 0), undefined, 1, undefined, undefined, undefined);

		wait 1;

		level thread engine_fire_vo(3);

		level notify ("stop fx 1");
		maps\_fx_gmi::loopfx("bomber_enginefire2", lwing_e1.origin, 0.15, lwing_e1.origin + (-100, 0, 0), undefined, 2, undefined, undefined, undefined);

		wait 5;

		level notify ("stop fx 2");
		maps\_fx_gmi::loopfx("bomber_enginesmoke", lwing_e1.origin, 0.15, lwing_e1.origin + (-100, 0, 0), undefined, 3, undefined, undefined, undefined);

		level waittill("start l_smoke");

		level notify ("stop fx 3");

		maps\_fx_gmi::loopfx("bomber_enginesmoke_end", lwing_e1.origin, 0.15, lwing_e1.origin + (-100, 0, 0), undefined, 11, undefined, undefined, undefined);
	}
	else
	{
		level thread lwing_engine4_objective();

		//play hit effect, sound
		//lwing_e2 playsound("wing_hit_02");		//same as above
		lwing_e2 playsound("wing_hit_02");

		maps\_fx_gmi::loopfx("bomber_enginefire1", lwing_e2.origin, 0.15, lwing_e2.origin + (-100, 0, 0), undefined, 4, undefined, undefined, undefined);

		wait 1;

		level thread engine_fire_vo(4);

		level notify ("stop fx 4");

		maps\_fx_gmi::loopfx("bomber_enginefire2", lwing_e2.origin, 0.15, lwing_e2.origin + (-100, 0, 0), undefined, 5, undefined, undefined, undefined);

		wait 5;

		level notify ("stop fx 5");

		maps\_fx_gmi::loopfx("bomber_enginesmoke", lwing_e2.origin, 0.15, lwing_e2.origin + (-100, 0, 0), undefined, 6, undefined, undefined, undefined);

		level waittill("start l_smoke");

		level notify ("stop fx 6");

		maps\_fx_gmi::loopfx("bomber_enginesmoke_end", lwing_e2.origin, 0.15, lwing_e2.origin + (-100, 0, 0), undefined, 12, undefined, undefined, undefined);
	}
}

lwing_engine3_objective()
{
		org = level.fuel_crank[3].origin;

		// "Put Out Engine Fire in #3"
		level.current_icon_objective = 3;

		level thread player_bomber_invulnerable();

		objective_add(3, "active", &"GMI_BOMBER_OBJECTIVE9_E3", org );
		objective_current(3);

		level waittill ("engine3 extinguished");

		objective_state(3,"done");
		objective_current(0);

		level.lwing_fire = false;
		level.lwing_onfire = false;

		level notify("start l_smoke");
}

lwing_engine4_objective()
{
		org = level.fuel_crank[4].origin;

		// "Put Out Engine Fire in #4"
		level.current_icon_objective = 4;

		level thread player_bomber_invulnerable();

		objective_add(3, "active", &"GMI_BOMBER_OBJECTIVE9_E4", org );
		objective_current(3);

		level waittill ("engine4 extinguished");

		objective_state(3,"done");
		objective_current(0);

		level.lwing_fire = false;
		level.lwing_onfire = false;

		level notify("start l_smoke");
}

engine_fire_vo(num)
{
	println("^1enginefire dialogue, engine hit");

	switch(num)
	{
		case 1: level thread dialogue(36); level.enginefire[1] = 1; break;

		case 2: level thread dialogue(37); level.enginefire[2] = 1; break;
	
		case 3: level thread dialogue(38); level.enginefire[3] = 1; break;

		case 4: level thread dialogue(39); level.enginefire[4] = 1; break;
	}

	if(level.enginesonfire == 0)
	{
		wait 2;
		level thread dialogue(40);
		level.enginesonfire = 1;
		level thread fuel_crank_activate(num);
	}
	else
	{
		wait 2;
		level thread dialogue(41);
		level.enginesonfire = 2;
		level thread fuel_crank_activate(num);
	}	
}

engine_fire_timer(num)
{
	wait 20;

	if(num == 2)
	{
		thisvar = level.lwing_onfire;
	}
	else
	{	
		thisvar = level.rwing_onfire;
	}
	
	if(thisvar == true )
	{
		iprintlnbold(&"GMI_BOMBER_ABOUT_TO_DIE");

		dodmg = ( level.parts_array[0].basehealth * 0.35 );

		level.parts_array[0] dodamage( dodmg, level.parts_array[0].origin);
	}

	wait 20;

	if(num == 2)
	{
		thisvar = level.lwing_onfire;
	}
	else
	{	
		thisvar = level.rwing_onfire;
	}

	if(thisvar == true )
	{
		level thread player_mission_failed();
	}
}

fuel_crank_setup()
{
	fuel_crank = [];
	//set up all of the wheel triggers
	for(i=1; i<5; i++)
	{
		level.fuel_crank[i] = getent("fuel_crank_" + i, "targetname");
		level.use_crank[i] = getent("use_crank_" + i, "targetname");
		//println("Defined: ", level.use_crank[i].targetname);

		//level.use_crank[i] maps\_utility_gmi::TriggerOff();
		level.use_crank[i] setcursorhint("HINT_NONE");

		//this is for the flashing objective wheels
		ang = level.fuel_crank[i].angles;
		org = level.fuel_crank[i].origin;
		level.fuel_flash[i] = spawn("script_model", org );
		level.fuel_flash[i] setmodel("xmodel/v_us_air_b-17_fuel_crank_objective");
		level.fuel_flash[i].angles = ang;
		level.fuel_flash[i] hideme();
	}
}

fuel_crank_activate(num)
{
	i = num;

	println("^1FUEL CRANK ACTIVATE HIT: ",num);

	level.use_crank[i] setcursorhint("HINT_ACTIVATE");

	level.use_crank[i] sethintstring(&"GMI_SCRIPT_HINTSTR_FUEL_WHEEL");

	level.fuel_crank[i] thread hideme();

	println("^3fuel_crank hidden...");

	for(n=0;n<10;n++)
	{
		level.fuel_flash[i] thread showme();
		wait 0.05;
	}

	println("^3fuel_flash shown...");

	level.use_crank[i] waittill ("trigger");

	level.use_crank[i] setcursorhint("HINT_NONE");
	
	level.fuel_flash[i] playsound("valve_wheel_turn");

	level.fuel_flash[i] rotateTo( level.fuel_crank[i].angles + (180,0,0), 3, 0.25, 1.75 );

	//level.fuel_flash[i] waittill ("rotatedone");
	wait 3;
	
	level.fuel_flash[i] stoploopsound("valve_wheel_turn");

	level.fuel_flash[i] hideme();

	level.fuel_crank[i] showme();

	println("engine " + i + " extinguished");

	level notify ("engine" + i + " extinguished");		//sets fire state to "extinguished"

	if(i<3) level.rwing_fire = 2;
}

wireless_hit()
{
	trg = getent("waist_gunners_die", "targetname");

	trg waittill("trigger");

	level.damagestate[1] = 2;

	level thread specific_turbulence(5);

	//radio room gets hit by flak here
	exp_loc = getent("radio_exp", "targetname");

	level.wirelessop notify ("stop wirelessop idle");

	//swap models
	level.model_array[18] hideme();
	level.model_array[19] showme();

	level thread wireless_wounded();

	//play sound at loc
	exp_loc playsound("flak_hit_01");

	//radiusDamage(level.player.origin, range, maxdamage, mindamage);
	//offset = (0,-60,0);		This is an offset so the explosion damages the player and not the wing

	maxdamage = level.player.health * (0.9);
	mindamage = level.player.health * (0.25);
	radiusDamage (exp_loc.origin + (0,-60,0), 120, maxdamage, mindamage);

	//play hit at loc
	playfx(level._effect["flak_hit_int"], exp_loc.origin );
		
//=================================================SG
	org = getent ("bomber_wind03_high","targetname");
	blend = spawn( "sound_blend", ( 0.0, 0.0, 0.0 ) );
	//println("Blend origin : ",blend.origin);

	// Must force the origin, since spawning in @ origin doesn't seem to take
	blend.origin = (35, 65, 18);


	for (i=0;i<1;i+=0.01)
	{
		blend setSoundBlend( "bomber_wind03_low", "bomber_wind03_high", i );
		wait (0.01);
	}
//==================================================SG

	wait 0.5;
	
	dialogue(78);

	//------------
	//Dialogue cut
	//------------
	//wait 0.25;
	//dialogue(79);
	//wait 0.3;
	//dialogue(99);
	//wait 0.45;
	//dialogue(100);
	//------------
}

wireless_wounded()
{
	//start his death anim
	level.wirelessop setflaggedanimknobrestart("death done", level.scr_anim["wire"]["wirelessop_death"], 1, 0.5, 1 );

	level.wirelessop waittill("death done");
	
	level.wirelessop_wounded = true;

	level thread wireless_hamlet();

	level.wirelessop setflaggedanimknobrestart("wounded done", level.scr_anim["wire"]["wirelessop_wounded"], 1, 0.5, 1 );

	level.wirelessop waittill("wirelessop die");

	level.wirelessop setflaggedanimknobrestart("dead done", level.scr_anim["wire"]["wirelessop_dead"], 1, 0.5, 1 );
}

// ***** ***** PLAYER BOMBER DAMAGE SECTION ***** ***** END

wireless_hamlet()
{
	trg = getent("wireless_hamlet", "targetname");

	trg waittill("trigger");

	if(level.wirelessop_wounded == true) 
	{
		level.wirelessop_wounded = false;
		level.wirelessop notify("wirelessop die");
	}
}


//Contrail section, this handles the contrails on the upper level bombers
contrails()
{
	while_except_name = self.targetname;

	while_except = false;

	while (!while_except)
	{
		if ( (level.b8_contrails_off) && (while_except_name == "b8") )
		{
			while_except = true;
		}
		else
		if ( (level.b9_contrails_off) && (while_except_name == "b9") )
		{
			while_except = true;
		}
		else
		if ( (level.b10_contrails_off) && (while_except_name == "b10") )
		{
			while_except = true;
		}
		else
		{
			while_except = false;
		}

		playfxontag(level._effect["contrail_bomber"], self, "tag_engine_1");
		playfxontag(level._effect["contrail_bomber"], self, "tag_engine_2");
		playfxontag(level._effect["contrail_bomber"], self, "tag_engine_3");
		playfxontag(level._effect["contrail_bomber"], self, "tag_engine_4");
		wait 1;
	}
}



// *** This section contains all the "random" movement of the friendly planes
// as well as the player bomber prop motion
props()
{
	prop = [];
	prop[prop.size] = getent("prop_1", "targetname");
	prop[prop.size] = getent("prop_2", "targetname");
	prop[prop.size] = getent("prop_3", "targetname");
	prop[prop.size] = getent("prop_4", "targetname");

	lwing = getent("left_wing", "targetname");
	rwing = getent("right_wing", "targetname");

	for (n=0; n<prop.size; n++)
	{
		prop[n] thread prop_spin();
	}
}

prop_spin()
{
	//add random offset to the prop
	roll_offset = randomint(180);
	self rotateTo ( ((self.angles[0]), (self.angles[1]), (self.angles[2] + roll_offset)), 0.01, 0, 0 );
	self waittill ("rotatedone");
		
	while(1)
	{
		self rotateTo ( ((self.angles[0]), (self.angles[1]), (self.angles[2] + 180)), 0.03, 0, 0 );
		self waittill ("rotatedone");
	}
}

prop_dead(propnum)
{
	//this is called on the prop that dies with a switch of "propnum"
	switch(propnum)
	{
		case 1: 
			thisprop = getent("prop_2", "targetname");
			break;
		
		case 2:
			thisprop = getent("prop_1", "targetname");
			break;

		case 3:
			thisprop = getent("prop_3", "targetname");
			break;
		
		case 4:
			thisprop = getent("prop_4", "targetname");
			break;
	}

	org = thisprop.origin + (10,0,0);
	newprop = spawn("script_model", org);

	//Here I'm going to let the script pick what happens to the prop
	//It's either destroyed, or the pilot feathers it

	randnum = randomint(2)+1;	
	switch(randnum)
	{
		case 1:
			newprop setmodel("xmodel/v_us_air_b-17_prop(d1)");
			thisprop hideme();

			curP = newprop.angles[0];
			curY = newprop.angles[1];
			curR = newprop.angles[2];

			interval = 360;

			for(n=0;n<60;n++)
			{
				interval -= 6;

				if(interval<0) interval = 0;

				curR = curR + interval;

				//If we are past a complete rotation reset the value
				if(curR > 360) curR -= 360;

				newprop rotateto( (curP, curY, curR),0.05);
				newprop waittill("rotatedone");
			}

			//set the prop model to the damaged one
			newprop setmodel("xmodel/v_us_air_b-17_prop(d3)");
			newprop.origin = newprop.origin + (-10,0,0);
			break;

		case 2:
			newprop setmodel("xmodel/v_us_air_b-17_prop(d1)");
			thisprop hideme();

			curP = newprop.angles[0];
			curY = newprop.angles[1];
			curR = newprop.angles[2];

			interval = 360;

			for(n=0;n<60;n++)
			{
				interval -= 6;

				if(interval<0) interval = 0;

				curR = curR + interval;

				//If we are past a complete rotation reset the value
				if(curR > 360) curR -= 360;

				newprop rotateto( (curP, curY, curR),0.05);
				newprop waittill("rotatedone");
			}

			//set the prop model to the feathered one
			newprop setmodel("xmodel/v_us_air_b-17_prop(d2)");
			newprop.origin = newprop.origin + (-10,0,0);
			break;
	}
}

jiggle_setup()
{
	friendlies = getentarray ( "friendly", "groupname" );
	for (i=0; i<friendlies.size; i++)
	{
		friendlies[i] thread jiggle_loop();
		friendlies[i] thread roll_loop();
	}
}

spit_setup()		//static spit array
{
	level.spits[1] = getent("spitfire_1", "targetname");
	level.spits[2] = getent("spitfire_2", "targetname");
	level.spits[3] = getent("spitfire_3", "targetname");
	level.spits[4] = getent("spitfire_4", "targetname");

	for (i=1; i<5; i++)
	{
		level.spits[i].targetname = "fakespit"+i;
		level.spits[i].n = i;
		level.spits[i] thread spit_jiggle_loop(i);
		level.spits[i] thread spit_roll_loop();
	}

	level.spits[1] playloopsound("fighter_steady01");
	level.spits[3] playloopsound("fighter_steady02");
}	

jiggle_loop()
{
	self endon("bomber is dying");

	oldorigin = self.origin;

	self.oldorg = oldorigin;
	
	loop_except_name = self.targetname;
	
	loop_except = false;

	while ( !loop_except )
	{	
		//sets up the random "jiggle" movements
		num = (1+randomint(2));
		for (i=0; i<num; i++)
		{
			if ( (level.b9_hit) && (loop_except_name == "b9") )
			{
				loop_except = true;
			}
			else
			{
				loop_except = false;
			}
	
			move_x = (128 - randomfloat(512));
			move_y = (64 - randomfloat(128));
			move_z = (32 - randomfloat(256));
			rand_time = (3+randomfloat(4));

			//***moveTo(vec position, float time, <float acceleration_time>, <float deceleration_time>);
			self moveTo ( (self.origin + (move_x, move_y, move_z) ), (rand_time), 1, 1 );
			self waittill ( "movedone" );
		}

		self moveTo ( oldorigin, (rand_time), 1, 1 );
		self waittill ("movedone");
	}
}

spit_jiggle_loop(plane_num)
{
	self.plane_num = plane_num;

	oldorg = self.origin;
	self.oldorg = oldorg;
	
	loop_except_name = self.targetname;
	
	loop_except = false;

	while ( !loop_except )
	{	
		//sets up the random "jiggle" movements
		num = (1+randomint(2));
		for (i=0; i<num; i++)
		{
			move_x = (128 - randomfloat(513));
			move_y = (64 - randomfloat(129));
			move_z = (40 - randomfloat(81));
			rand_time = (3.05+randomfloat(1));

			//***moveTo(vec position, float time, <float acceleration_time>, <float deceleration_time>);
			self moveTo ( (self.origin + (move_x, move_y, move_z) ), (rand_time), 1.5, 0.5 );
			self waittill ( "movedone" );
		}

		self moveTo ( oldorg, (rand_time), 1, 1 );
		self waittill ("movedone");

		if(level.spits_start == true)
		{
			loop_except = true;
		}
	}
	//send em home to their origin, cuz they are attacking

	myReturnString = "dogfight_spit_" + plane_num;

	myReturnSpot = getvehiclenode(myReturnString, "targetname");

	self moveto( myReturnSpot.origin, 2, 0, 1 );

	wait 2;

	level notify ("spits ready");
}

roll_loop()
{
	self endon("bomber is dying");

	oldangles = self.angles;

	self.oldang = oldangles;

	loop_except_name = self.targetname;
	
	loop_except = false;	

	while ( !loop_except )
	{	
		//provides a random rotation to the planes, independent of the random movement
		//***rotateTo(vec orent, float time, <float acceleration_time>, <float deceleration_time>);

		if ( (level.b9_hit) && (loop_except_name == "b9") )
		{
			loop_except = true;
			self thread b9_hit();
		}
		else
		{
			loop_except = false;
		}
	
		pitch = ( 4 - randomfloat( 8 ) );
		yaw = ( 2 - randomfloat( 4 ) );
		roll = ( 7 - randomfloat( 15 ) );
		rand_time = ( 2 + randomfloat( 3 ) );
		roll_wait = ( randomfloat( 0.5 ) + 0.5 );

		self rotateTo ( ((self.angles[0] + pitch), (self.angles[1] + yaw), (self.angles[2] + roll)), (rand_time), 1, 0.5 );

		self waittill ("rotatedone");
		
		wait roll_wait;

		self rotateTo ( ((self.angles[0] - pitch), (self.angles[1] - yaw), (self.angles[2] - roll)), (rand_time), 0.5, 1 );

		self waittill ("rotatedone");
	}
}

spit_roll_loop()
{
	oldang = self.angles;

	self.oldang = oldang;

	loop_except_name = self.targetname;
	loop_except = false;	

	while ( !loop_except )
	{	
		//provides a random rotation to the planes, independent of the random movement
		//***rotateTo(vec orent, float time, <float acceleration_time>, <float deceleration_time>);
	
		pitch = ( 5 - randomfloat( 10 ) );
		yaw = ( 2 - randomfloat( 4 ) );
		roll = ( 15 - randomfloat( 31 ) );
		rand_time = ( 1 + randomfloat( 0.5 ) );
		roll_wait = ( randomfloat( 0.5 ) + 0.05 );
		
		self rotateTo ( ((self.angles[0] + pitch), (self.angles[1] + yaw), (self.angles[2] + roll)), (rand_time), 0.25, 0.5 );

		self waittill ("rotatedone");
		
		wait roll_wait;

		self rotateTo ( ((self.angles[0] - pitch), (self.angles[1] - yaw), (self.angles[2] - roll)), (rand_time), 0.5, 0.25 );

		self waittill ("rotatedone");

		if(level.spits_start == true)
		{
			loop_except = true;
		}
	}
	//rotate em to 0
	self rotateto ((0,0,0),1,0,0);
}

damaged_jiggle_loop()
{
	oldorigin = self.origin;
	
	counter = 0;	
	while ( counter < 2 )
	{	
		//sets up the random "jiggle" movements
		num = (1+randomint(2));
		for (i=0; i<num; i++)
		{
			move_x = (48 - randomfloat(97));
			move_y = (24 - randomfloat(49));
			move_z = (12 - randomfloat(25));
			rand_time = 0.5;
			//***moveTo(vec position, float time, <float acceleration_time>, <float deceleration_time>);
			self moveTo ( (self.origin + (move_x, move_y, move_z) ), (rand_time), 0.1, 0.2 );
			self waittill ( "movedone" );
		}
		self moveTo ( oldorigin, (rand_time), 0.2, 0.1 );
		self waittill ("movedone");
		counter++;
	}
}

damaged_roll_loop()
{
	oldorigin = self.origin;

	counter = 0;
	while ( counter < 3)
	{	
		pitch = ( 8 - randomfloat( 17 ) );
		yaw = ( 4 - randomfloat( 9 ) );
		roll = ( 14 - randomfloat( 29 ) );
		rand_time = 0.5;
		
		self rotateTo ( ((self.angles[0] + pitch), (self.angles[1] + yaw), (self.angles[2] + roll)), (rand_time), 0.45, 0);
		self waittill ("rotatedone");
		self rotateTo ( ((self.angles[0] - pitch), (self.angles[1] - yaw), (self.angles[2] - roll)), (rand_time), 0.45, 0);
		self waittill ("rotatedone");
		counter++;
	}
}

random_turbulence()
{
	level endon("stop turbulence");

	while(1)
	{
		rand_wait = randomfloat(12);
		wait rand_wait;

		eqtype = (randomint(5)+1);

		player = getent("player", "classname");
		source = player.origin;

		switch(eqtype)
		{
			case 1:	scale = 0.05;
				duration = 2;
				radius = 200;
				earthquake(scale, duration, source, radius);
				break;

			case 2:	scale = 0.10;
				duration = 1.5;
				radius = 300;
				earthquake(scale, duration, source, radius);
				break;

                        case 3: scale = 0.15;
                                duration = 1.25;
                                radius = 400;
                                medium1 = spawn("script_origin", (0,0,0));
                                medium1 playsound ("medium_shake");
                                earthquake(scale, duration, source, radius);
                                break;

                       case 4: scale = 0.20;
                                duration = 0.5;
                                radius = 500;
                                medium1 = spawn("script_origin", (0,0,0));
                                medium1 playsound ("medium_shake");
                                earthquake(scale, duration, source, radius);
                                break;

                        case 5: scale = 0.5;
                                duration = 0.8;
                                radius = 600;
                                big1 = spawn("script_origin", (0,0,0));	
                                big1 playsound ("big_shake");
                                earthquake(scale, duration, source, radius);
                                break;
		}
	}
}

specific_turbulence(num)
{
	level endon("stop turbulence");

	player = getent("player", "classname");
	source = player.origin;

	switch(num)
	{
		case 1:	scale = 0.05;
			duration = 2;
			radius = 200;
			earthquake(scale, duration, source, radius);
			break;

		case 2:	scale = 0.10;
			duration = 1.5;
			radius = 300;
			earthquake(scale, duration, source, radius);
			break;

                case 3: scale = 0.15;
                        duration = 1.25;
                        radius = 400;
                        medium1 = spawn("script_origin", (0,0,0));
                        medium1 playsound ("medium_shake");
                        earthquake(scale, duration, source, radius);
                        break;

               case 4: scale = 0.20;
                        duration = 0.5;
                        radius = 500;
                        medium1 = spawn("script_origin", (0,0,0));
                        medium1 playsound ("medium_shake");
                        earthquake(scale, duration, source, radius);
                        break;

                case 5: scale = 0.75;
                        duration = 1.25;
                        radius = 2000;
                        big1 = spawn("script_origin", (0,0,0));	
                        big1 playsound ("big_shake");
                        earthquake(scale, duration, source, radius);
                        break;
	}
}


static_turbulence()
{
	level endon("stop turbulence");

	player = getent("player", "classname");
	source = player.origin;

	while(1)
	{

		if(level.bomber_wind_shake == 0)
		{
			scale = 0.1;
			dur = 0.25;
	
			duration = ((randomfloat(1) * dur) + 0.05);
	
			radius = 1000;
			earthquake(scale, duration, source, radius);
			wait duration;
		}
		else
		if(level.bomber_wind_shake == 1)
		{
			scale = 0.15;
			dur = 0.5;
	
			duration = ((randomfloat(1) * dur) + 0.05);
	
			radius = 1000;
			earthquake(scale, duration, source, radius);
			wait duration;
		}
		else
		if(level.bomber_wind_shake == 2)
		{
			scale = 0.2;
			dur = 0.75;
	
			duration = ((randomfloat(1) * dur) + 0.05);
	
			radius = 1500;
			earthquake(scale, duration, source, radius);
			wait duration;
		}
	}
}
// *** random movement setup end ***



// *** Begin START_OF_MISSION ***
// *** Here is where we can put the initial conversation bits and stuff, before FLAK1 happens *** text is placeholder obviously
start_of_mission()
{
	println("^5start_of_mission");

	level waittill("finished intro screen");

	//Make the top turret usable	
	level.top_turret.unusable = false;

	//Initial dialogue of pilot and navigator
	dialogue(66);						//"Navigator, what's our position and status?"
	wait 0.25;
	dialogue(2);						//"Skippah!  We're blah blah blah"
	wait 0.5;

	//Unlikely, but check to see if the player is in his turret
	owner = level.top_turret getTurretOwner();
	if(isdefined(owner) && (owner == level.player))
	{
		level.player_in_dorsal = true;
	}
	else
	{
		level.player_in_dorsal = false;
	
		//Lwgunner motions and says line
		level thread lwgunner_motions();
		level.ring.ping = 5;				//Special bomber goodness!!! courtesy of Mr. Angry
		dialogue(64);					//"Doyle, you'd better get up..."
	}

	wait 0.5;
	if(level.player_in_dorsal == false) 
	{	
		dialogue(1);			//First pilot reminder
		level.ring.ping = 5;

		wait 15;
	
		numtimes = 0;

		while(!level.player_in_dorsal)
		{
			level.ring.ping = 5;	
			
			level thread dialogue(60);				//Assorted pilot reminders

			for(n=0; n<30; n++)
			{
				owner = level.top_turret getTurretOwner();
				if(isdefined(owner) && (owner == level.player))
				{
					level.player_in_dorsal = true;
					break;
				}
				wait 0.5;
			}

			numtimes++;

			if( (numtimes>2)  && (level.player_in_dorsal == false) )
			{
				setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
				missionFailed();
			}
		}
	}
	
	if(level.dlp == 1)
	{
		//Don't continue until the line is done
		wait 0.05;
	}

	dialogue(68);

	wait 0.5;
	
	dialogue(69);

	wait 0.5;

	dialogue(70);

	wait 0.5;

	dialogue(71);

	wait 0.15;
	
	dialogue(92);

	wait 0.25;

	level thread dialogue(72);

	wait 0.25;

	level notify ("start of mission done");

}
//*** End START_OF_MISSION ***



// ***** START FLAK FUNCTION *****
flak( density, duration, ramp, flak_ev_num )
{
//	_debug("FLAK STARTED", flak_ev_num);
	//this flag lets the level know that flak is going on
	level.flak = true;
	level.random_flak = true;
	level.inflak = flak_ev_num;

	//Decrease the flak by 50% on low-end machines
	s_fast = getcvar("scr_gmi_fast");
	if(s_fast == "2") 
	{
		println("^1Low optimal settings detected!  Flak intensity halved!");
		density = (density *0.5);
	}

	level thread flak_shakes_plane();

	level thread lwgunner_flak();

	//flak_blend helps flesh out the ambient sounds during the flak events
	thread flak_blend();

	//flak_event_num = the number of this flak period
	//duration = total time for flak period
	//density controls the thickness of the flak field, limits 0.1 - 1.0, lower values are lesser density
	//ramp,  0 = flat, 1 = increase, 2 = decrease
	
	//This array holds the ramp period timing and the flak interval timing
	rampstep_perduration[0][0] = 0.25;
	rampstep_perduration[0][1] = 0.25;
	rampstep_perduration[0][2] = 0.25;
	rampstep_perduration[0][3] = 0.25;
	
	rampstep_perduration[1][0] = 0.4;			
	rampstep_perduration[1][1] = 0.3;			
	rampstep_perduration[1][2] = 0.2;
	rampstep_perduration[1][3] = 0.1;

	rampstep_perduration[2][0] = 0.1;
	rampstep_perduration[2][1] = 0.2;
	rampstep_perduration[2][2] = 0.3;
	rampstep_perduration[2][3] = 0.4;

	if(ramp>2 || ramp < 0)
	{
		ramp = 0;
		_error("Ramp forced to 0, out of range!");
	}

	if(density<0.1)
	{
		density = 0.1;
	}
	else
	if(density > 1)
	{
		density = 1;
	}
	density = (1.1 - density);

	flak_perwait = (1 * density);
	
	for (ramp_step = 0; ramp_step < 4; ramp_step++)
	{
		//total time in the flak period, there are 4 total in each ramp
		//for ramp 0 they are all equal
		flak_period = ( duration * rampstep_perduration[ramp][ramp_step] );
		
		//time between each flak burst
		flak_spacing = ( ( flak_perwait * 4 ) * rampstep_perduration[ramp][ramp_step] );
	
		if (flak_spacing < 0.05) flak_spacing = 0.05;
		
		upper_bound_flak_period = ( flak_period / flak_spacing );

		for (flak_period_timer = 0; flak_period_timer < upper_bound_flak_period; flak_period_timer++)
		{
			if(flak_ev_num != 3)
			{
				maps\_fx_gmi::OneShotfx("flak_field", (0, 0, 0), 0.0);
				wait flak_spacing;
			}
			else
			{
				maps\_fx_gmi::OneShotfx("flak_many", (0, 0, 0), 0.0);
				wait flak_spacing;
			}		
		}
	}

	level notify ("blend_down");    // stops sound

//	_debug("FLAK OVER", flak_ev_num);
	level.flak = false;
	level.inflak = 0;
	level.random_flak = false;
	level notify ("flak_done");
}
// ***** END FLAK FUNCTION *****



flak_shakes_plane()
{
	wait 1;

	//initial wait so that every call to this doesn't start off with a flak hit ;)
	rand_Wait = (randomfloat(9) +0.05);
	wait rand_wait;


	while( level.random_flak == true)
	{
		//pick a target out of the random array
		rand_target = ( randomint(8) + 1 );
		if(level.inflak != 3)
		{
			level.flak_target[rand_target] playsound("flak_burst");
		}
		else
		{
			level.flak_target[rand_target] playsound("flak_burst_many");
		}

		//play hit at loc
		playfx(level._effect["flak_hit_near"], level.flak_target[rand_target].origin );
		level thread specific_turbulence(5);
		level thread rwgunner_flak();

		//These random VOs that used to play when flak shakes the plane have been cut

		//wait 0.75;
		//level thread dialogue(61);

		//wait 0-21 seconds
		rand_Wait = (randomint(20) + 5);
		wait rand_wait;
	}
}

// *** Begin FLAK1 ***
flak1()
{
	//Watch out for flak!	

	if(level.allow_autosave == true)
	{
		//Autosave Point #1
		maps\_utility_gmi::autosave(1);
	}

	// flak( density, duration, ramp, flak_event_num )
	//	 0.1 - 1.0, seconds, 0 = none / 1 = up / 2= down, evnum
	level thread flak( 0.4, 18, 1, 1 );
	level waittill ("flak_done");

	wait 2;

	dialogue(3);

	wait 1;
	
	level thread flak( 0.6, 18, 1, 1);

	wait 1.5;

	level thread dialogue(94);

	wait 1.5;

	//Notify b9 that flak just hit it
	level.b9_hit = true;
	
	level waittill("b9_hit");	

	wait 3;

	dialogue(5);

	wait 8;

	level thread landscape_trans1();

	wait 3;

	dialogue(95);

	for(n=0;n<level.friendly_bombers.size;n++)
	{
		if(isdefined(level.friendly_bombers[n]))
		{
			level.friendly_bombers[n] thread friendly_bombers_descending();
		}
	}

	for(n=1;n<level.spits.size+1;n++)
	{
		if(isdefined(level.spits[n]))
		{
			println("^3spits descending: ", n);
			level.spits[n] thread friendly_spits_descending();
		}
	}

	
	wait 3;

	dialogue(9);

	wait 0.25;

	dialogue(96);

	wait 0.5;

	dialogue(97);

	wait 0.35;
	
	dialogue(98);

	wait 0.75;

	level thread dialogue(10);		//to play next line so that it cuts this one off...

	level notify ("flak1 done");

	wait 4.15;

	level thread dialogue(11);

	wait 2.5;

	level notify("action_started");
}

friendly_bombers_descending()
{
	oldang = self.angles;
	oldorg = self.origin;

	wait randomfloat(2)+0.05;
	self rotateTo( (self.angles) + (5,0,0), 3, 2, 0);
	self moveTo( (self.origin) + (0,0,-1000), 8, 3, 2);
	self waittill("movedone");
	wait randomfloat(2)+0.05;
	self moveTo( (self.oldorg), 12, 10, 2);
	wait 2;
	self rotateTo( (self.oldang), 4,3,0);
}

friendly_spits_descending()
{
	oldang = self.angles;
	oldorg = self.origin;

	wait randomfloat(1) + 0.05;
	self rotateTo( (self.angles) + (5,0,0), 4, 1, 0);
	self moveTo( (self.origin) + (0,0,-1000), 4, 1, 1);
	self waittill("movedone");
	wait randomfloat(2)+0.05;
	self rotateTo( (self.oldang), 2,1,0);
	self moveTo( (self.oldorg), 6, 3, 1);
	wait 1;
}


//this is to cause bomber B9 to take a hit and fall back, engine flaming
b9_hit()
{
	self endon("death");

	level notify("b9_hit");

	println("^3B9 is invulnerable to player fire");
	self settakedamage(0);

	self thread b9_flame_on();

	self playsound("bomber_hit_01");

	level thread dialogue(73);

	wait 0.5;
	
	//***moveTo(vec position, float time, <float acceleration_time>, <float deceleration_time>);
	self moveTo ( ( 6000, 1250, 600 ), 15, 5, 3 );

	b9change[0] = 10;
	b9change[1] = 0;
	b9change[2] = -65;

	self rotateTo ( ( self.angles[0] + 20, self.angles[1], self.angles[2] - 65 ), 10, 5, 0 );

	self playsound("bomber_die_01");

	wait 7.8;
	
	self rotateTo ( ( self.angles[0] - 15, self.angles[1] + 2, self.angles[2] + 70 ), 8, 3, 0 );

	wait 1.0;

	maps\_fx_gmi::OneShotFX("crewbail", (6000, 1250, 600), 5.0);

	wait 5.0;

	playfx(level._effect["b17_rwing"], self.origin );

	explode_sound = spawn("script_origin",(0,0,0));
	explode_sound linkto (self,"tag_engine_2",(0,0,0),(0,0,0));
	explode_sound playsound("bomber_explode_01");

	//wait 1;

	level thread dialogue(7);

	if(isdefined(self.turret))
	{
		self.turret delete();
	}

	self delete();
}

b9_flame_on()
{	
	self endon("death");

	playfxontag(level._effect["b17engine_exp"], self, "tag_engine_3");
	wait 0.25;
	
	level.b9_contrails_off = true;

	for (n=0; n<30; n++)
	{
		//Note:  I reversed the flame effects, so that Bertie smokes first, then catches on fire
		if (n<18)
		{
			playfxontag(level._effect["bomber_enginesmoke"], self, "tag_engine_3");
		}
		else
		{	
			playfxontag(level._effect["b17flame2"], self, "tag_engine_3");
		}
		wait 0.25;
	}

	while(1)
	{
		playfxontag(level._effect["b17flame1"], self, "tag_engine_3");
		wait 0.3;
	}
}

flak_blend()
{
        org = getent ("distant_flak_loop_high","targetname");
        blend = spawn( "sound_blend", ( 0.0, 0.0, 0.0 ) );

        for (i=0;i<1;i+=0.01)
        {
                blend setSoundBlend( "distant_flak_loop_low", "distant_flak_loop_high", i );
                wait (0.01);
        }
        level waittill ("blend_down");
        for (i=1;i>0;i-=0.01)
        {
                blend setSoundBlend( "distant_flak_loop_low", "distant_flak_loop_high", i );
                wait (0.01);
        }
}

// *** End FLAK1 ***



// ***** ***** ATTACK 1 ***** *****
attack1()
{
	//Bandits, 11 o'clock!	

	if(level.allow_autosave == true)
	{
		//Autosave Point #2
		maps\_utility_gmi::autosave(2);
	}
	
	//************************************************************
	//Thread the difficulty ramping function known as Cheez2 HERE!
	thread cheez2(1);
	//************************************************************

	//fighter_attacks( total_num_groups, direction_bias, attack_ev_num )

	level.spits_start = true;

	level thread dogfight();

	wait 6;

	level.inattack = 1;

	level.lwgunner.idle = false;	//Tells waist gunners to start firing anims
	level.rwgunner.idle = false;	

	wait 9;

	level thread fighter_attacks( 2, 12, 1 );					//ATTACK EVENT NUMBER * 1 *

	wait 5;

	level thread dialogue(110);
	println("^5Fire away!");

	wait 30;

	level thread fighter_attacks( 2, 6, 2 );					//ATTACK EVENT NUMBER * 2 *

	wait 11;

	level thread dialogue(14);				//Another lot on our six

	wait 32;

	level thread fighter_attacks( 1, 12, 3 );					//ATTACK EVENT NUMBER * 3 *

	level thread cheez1(1);

	wait 25;

	level thread fighter_attacks( 1, 3, 4 );					//ATTACK EVENT NUMBER * 4 *

	wait 21;

	level thread tgunner_gets_strafed();

	wait 12;	

	level thread cheez1(2);
	level thread fighter_attacks( 4, 6, 5 );					//ATTACK EVENT NUMBER * 5 *

	wait 1;

	level thread dialogue(17);				//Too many! Too many...

	level.tgunner_alive = false;

	wait 7;

	dialogue(74);						//Angus is down...

	wait 1;

	level thread objective2();					//Get to the tail gun objective
	level notify("allow player to exit dorsal turret");		//Unlocks player from turret
	level.staythere = 0;						//ensures lock doesn't repeat

	level thread dialogue(75);					//Doyle! Get on that tail gun!

	level thread maps\_utility::keyHintPrint(&"GMI_SCRIPT_USE_TO_EXIT_TURRET", getKeyBinding("+activate"));

	level waittill ("attack5_done");

	level.lwgunner.idle = true;
	level.rwgunner.idle = true;

	dialogue(76);

	wait 3.5;

	_debug("ATTACK1_EVENT_END");

	level notify ("action_done");					//stop the music

	level.inattack = 0;
			
	level notify ("attack1_event_end");

	level notify("cheez1_done");
}

b2_hit()
{
	self endon("death");

	println("^3B2 is invulnerable to player fire");
	self settakedamage(0);

	fakePathStart = getvehiclenode("fakePathStart", "targetname");
	
	newloc = fakePathStart.origin;
	newang = fakePathStart.angles;	

	fakebf = spawnvehicle( "xmodel/v_ge_air_me-109", "fakebf", "BF109", newloc, newang );

	fakebf.noregen = false;
	fakebf.onfire = false;
	fakebf.script_vehiclegroup = 7;
	fakebf.group_num = 0;
	fakebf.plane_num = 0;
	fakebf.loop_num = 1;
	fakebf.attackdirection = 0;
	fakebf.targetname = "fakebf";
	fakebf.mytarget = getent("b2", "targetname");

	fakebf thread maps\_bf109_gmi::init();

	path = fakePathStart;
	fakebf.attachedpath = path;

	fakebf attachpath(path);

	fakebf thread maps\_vehiclechase_gmi::enemy_vehicle_paths();

	fakebf startpath();

	wait 20;
	
	self thread b2_flame_on();

	level thread b2_dialogue();

	waitframe();

	self playsound("bomber_hit_01");

	//***moveTo(vec position, float time, <float acceleration_time>, <float deceleration_time>);
	self moveTo ( ( -1024, 32, -1000 ), 12, 7, 0 );

	waitframe();

	self rotateTo ( ( self.angles[0] + 15, self.angles[1], self.angles[2] + 65 ), 8, 2, 0 );

	waitframe();

	self playsound("bomber_die_02");

	wait 7.8;
	
	self rotateTo ( ( self.angles[0] - 15, self.angles[1] + 2, self.angles[2] + 25 ), 8, 3, 3 );

	self waittill ( "movedone" );

	playfx(level._effect["b17_rwing"], self.origin );

	explode_sound = spawn("script_origin",(0,0,0));
	explode_sound linkto (self,"tag_engine_2",(0,0,0),(0,0,0));
	explode_sound playsound("bomber_explode_01");

//============================================================
        player = getent("player", "classname");
        source = player.origin;
        scale = 0.7;
        duration = 1;
        radius = 600;
        big1 = spawn("script_origin", (0,0,0));         
        big1 playsound ("super_shake");
        earthquake(scale, duration, source, radius);
//============================================================

	if(isdefined(self.turret))
	{
		self.turret delete();
	}

	self delete();

	fakebf delete();
}

b2_flame_on()
{	
	self endon ("death");

	playfxontag(level._effect["b17engine_exp"], self, "tag_engine_4");
	playfxontag(level._effect["b17engine_exp"], self, "tag_engine_3");
	wait 0.25;

	for (n=0; n<74; n++)
	{
		if (n<20)
		{
			playfxontag(level._effect["b17flame1"], self, "tag_engine_3");
			playfxontag(level._effect["b17flame1"], self, "tag_engine_4");
		}
	
		playfxontag(level._effect["b17flame2"], self, "tag_engine_3");
		playfxontag(level._effect["b17flame2"], self, "tag_engine_4");
		wait 0.25;
	}

	waitframe();

	playfxontag(level._effect["b17flame1"], self, "tag_engine_3");
	self playsound ("explo_metal_rand");
	wait 1;
	playfxontag(level._effect["b17engine_exp"], self, "tag_engine_4");
	self playsound ("explo_metal_rand");
}

b2_dialogue()
{
	wait 1.5;
	dialogue(80);
}

dogfight()
{
	//make sure the spits return to their original starting position
	level waittill ("spits ready");

	//start the enemy fighters first, then wait for it...
	for(n=1; n<4; n++)		//Grabs up the three attacking bf paths for the dogfight script
	{
		bf_dogfight_start[n] = getvehiclenode("dogfight_bf_" + n, "targetname");
		level.bf_dogfight[n] = spawnvehicle( "xmodel/v_ge_air_me-109", "bf-noshoot_"+n, "BF109", (0,0,0), (0,0,0) );

		level.bf_dogfight[n].noregen = true;
		level.bf_dogfight[n].loop_num = 1;
		level.bf_dogfight[n].health = level.bf109_health + 50;
		level.bf_dogfight[n].attachedpath = bf_dogfight_start[n];
		level.bf_dogfight[n].onfire = false;
		level.bf_dogfight[n].script_vehiclegroup = 8;
		level.bf_dogfight[n].group_num = -1;
		level.bf_dogfight[n].plane_num = n;
		level.bf_dogfight[n].attackdirection = 12;
		level.bf_dogfight[n].p_f = 5;

		level.bf_dogfight[n] thread maps\_bf109_gmi::init();
		level.bf_dogfight[n] thread bf_dogfight_think(n);
	}

	level.spit = [];

	for(n=1; n<5; n++)		//Grabs up the four attacking spit paths 
	{
		spit_dogfight_start[n] = getvehiclenode("dogfight_spit_"+n, "targetname");
	}
	
//	_debug("starting friendly fighters");

	wait 3;

	for(n=1; n<5; n++)
	{
		level.spit[n] = spawnvehicle( "xmodel/v_br_air_spitfire", "spit"+n, "BF109", (0,0,0), (0, 0, 0) );
		level.spit[n].noregen = true;

		if(n==1 || n ==3)
		{
			level.spit[n].noregen = false;		//exception for spits 1 & 3
		}

		level.spit[n].n = n;
		level.spit[n].script_vehiclegroup = 9;
		level.spit[n].loop_num = 3;
		level.spit[n].health = 300;
		level.spit[n].attachedpath = spit_dogfight_start[n];
		level.spit[n].onfire = false;
		level.spit[n].group_num = -2;
		level.spit[n].plane_num = n;
		level.spit[n].attackdirection = -1;
		level.spit[n].p_f = 5;
		level.spit[n].targetname = "spit"+n;

		level.spit[n] thread maps\_bf109_gmi::init();
			
		level.spit[n] thread spit_think(n);
	}


	wait 2.0;

	level notify ("bf_dogfight_go");

}

spit_think(n)
{
	level.spit[n] endon ("death");

	path = level.spit[n].attachedpath;

	level.spit[n] attachPath( path );
	
	level.spit[n] thread maps\_vehiclechase_gmi::enemy_vehicle_paths();

	switch(n)
	{
		case 1: level.spit[n].mytarget = getent("bf-noshoot_2", "targetname"); break;

		case 2: level.spit[n].mytarget = getent("bf-noshoot_2", "targetname"); break;

		case 3: level.spit[n].mytarget = getent("bf-noshoot_3", "targetname"); break;

 		case 4: level.spit[n].mytarget = getent("bf-noshoot_3", "targetname"); break;
	}

	level.spit[n] thread spits_go_home();

	level.spit[n] startPath();

	//hideme script_model spits
	for (i=1; i<5; i++)
	{
		if(i==1) level.spitS[i] stoploopsound("fighter_steady01");
		if(i==3) level.spitS[i] stoploopsound("fighter_steady02");
		level.spitS[i] hideme();
		waitframe();
	}

	if(n==1)level.spit[n] playsound("spit_intercept01");
	if(n==3)level.spit[n] playsound("spit_intercept02");

	level.spit[n] thread spitfire_drawname(n);

	level.spit[n] thread spits_check_your_targets(n);
}	

spits_go_home()
{
	self waittill("spits go home");
	n = self.n;
	self delete();

	level.spits[n] showme();

	wait 0.05;

	if(n==1)println("spit1 should be home");

	if(n == 1) 
	{
		level.spits_end = true;
		println("spit1 home - ", self.n);
		level.spits[n] playloopsound("fighter_steady01");
	}

	if(n==3) 
	{
		level.spits_end = true;
		println("spit3 home - ",self.n);
		level.spits[n] playloopsound("fighter_steady02");
	}

	level.spits[n] thread spit_roll_loop();
	level.spits[n] thread spit_jiggle_loop();
}

spits_check_your_targets(n)
{
	gotcha = false;

	while(1)
	{
		if (!isalive(self.mytarget) && !gotcha )
		{
			switch(n)
			{
				case 1: self.mytarget = getent("bf-noshoot_1", "targetname"); gotcha = true; break;
	
				case 2: self.mytarget = getent("bf-noshoot_1", "targetname"); gotcha = true; break;
	
				case 3: self.mytarget = getent("bf-noshoot_2", "targetname"); gotcha = true; break;
	
				case 4: self.mytarget = getent("bf-noshoot_2", "targetname"); gotcha = true; break;
			}
		}
		else
		{
			switch(n)
			{
				case 1: self.mytarget = getent("bf_noshoot_2", "targetname"); gotcha = false; break;
			
				case 2: self.mytarget = getent("bf-noshoot_2", "targetname"); gotcha = false; break;

				case 3: self.mytarget = getent("bf_noshoot_3", "targetname"); gotcha = false; break;
			
				case 4: self.mytarget = getent("bf-noshoot_3", "targetname"); gotcha = false; break;
			}
		}
		waitframe();
	}
}

bf_dogfight_think(n)
{
//	_debug(level.bf_dogfight[n].targetname);

	level.bf_dogfight[n] endon ("death");

	path = level.bf_dogfight[n].attachedpath;

	level.bf_dogfight[n] attachPath( path );

	level.bf_dogfight[n].mytarget = getent("b2", "targetname");

	level.bf_dogfight[n] thread maps\_vehiclechase_gmi::enemy_vehicle_paths();

	level waittill ("bf_dogfight_go");

	level.bf_dogfight[n] startPath();

	level.bf_dogfight[n] waittill ("reached_end_node");
}

//This used to handle the drawing of the friendly icons above the spits, it's been removed by request	
spitfire_drawname(n)
{
//	self endon ("death");
//
//
//	while (1)
//	{
//	//	print3d(vec origin, string, vec rgb = (1, 1, 1), float a = 1, float scale = 1);
//	//	Prints text inside the world at a given coordinate.
//	//	·	print3d (friendly1.origin + (0,0,75), friendly1.health);
//	//	·	print3d(self.origin, self.classname);
//
//		if(self.drawme == true)
//		{
//			print3d(self.origin + (0, 0, 100), "o", ( 0, 0, 1), 1, 5);
//			print3d(self.origin + (6, 0, 106), "o", ( 1, 1, 1), 1, 4);
//			print3d(self.origin + (12, 0, 112), "o", ( 1, 0, 0), 1, 3);
//		}
//		
//		wait 0.065;
//	}
}

//check_spit_dist_occasionally()
//{
//	self endon ("death");
//
//	while (1)
//	{
//		dist = distance(self.origin, level.player.origin);
//		if (dist > 30000 )
//		{
//			self.drawme = false;
//		}
//		else
//		{
//			self.drawme = true;
//		}
//		wait 1;
//	}
//}

// *** END ATTACK1 ***



// *** Begin LULL1 ***
lull1()
{
	wait 1;

	dialogue(22);

	wait 0.5;

	dialogue(23);

	wait 0.5;

	level thread dialogue(24);

	wait 4;
	
	//Spits Leave!
	for(n=1; n<5; n++)
	{
		if(!isdefined(level.spits[n].n))
		{
			level.spits[n] = n;
		}

		level.spits[n] thread spits_leave();
	}

	if(isdefined(level.spits[3]))
	{
		level.spits[3] playsound("spit_flyover01");
	}

	wait 1;

	dialogue(25);
	
	wait 2;

	level thread dialogue(77);

	level notify ("lull1_done");

	wait 28;
	
	for(n=1; n<5; n++)
	{
		if(n==1) level.spits[n] stoploopsound("fighter_steady01");
		if(n==3) level.spits[n] stoploopsound("fighter_steady02");

		level.spits[n] delete();
	}
}

spits_leave()
{
	

	self moveto((self.origin), 0.05,0,0);

	wait 0.1;

	//rotateTo(vec orent, float time, <float acceleration_time>, <float deceleration_time>);
	self rotateTo( (self.angles) + ( -20, 0, -50 ), 4, 2, 0 );

	if(self.n != 2 && self.n != 4)
	{
		//moveTo(vec position, float time, <float acceleration_time>, <float deceleration_time>);
		self moveTo ( (self.origin) + ( -160000, 160000, -20000 ), 30, 25, 0 );
	}
	else
	{
		//moveTo(vec position, float time, <float acceleration_time>, <float deceleration_time>);
		self moveTo ( (self.origin) + ( -120000, 160000, -20000 ), 30, 25, 0 );
	}	

	wait 4;

	println("^3spitsleave angles 2");

	//rotateTo(vec orent, float time, <float acceleration_time>, <float deceleration_time>);
	self rotateTo( (self.angles) + (20,90,-5) , 6, 3, 2 );
}
//*** End LULL1 ***



// *** Begin FLAK2 ***
flak2()
{
	//Flak	

	if(level.allow_autosave == true)
	{
		//Autosave Point #3
		maps\_utility_gmi::autosave(3);
	}

	level thread lwgunner_flak();
	level thread rwgunner_flak();

	//Flag the wings to be vulnerable now
	level.parts_array[0] settakedamage(1);
	level.parts_array[1] settakedamage(1);

	// flak( density, duration, ramp, flak_event_num )
	//	 0.1 - 1.0, seconds, 0 = none / 1 = up / 2= down, evnum
	level thread flak( 0.7, 18, 1, 2 );

	wait 4;

	level thread dialogue(61);
	wait 13;

	//Thread engine flaming hit here
	level thread wing_go_boom();
	//The Wireless operator gets it when the trigger is hit
	level thread wireless_hit();

	wait 3;

	level.wirelessop_wounded = false;

	wait 4;

	flak( 0.7, 12, 2, 2 );

	level notify ("flak2_event_done");
}

wing_go_boom()
{
	x = (0.35 * level.parts_array[0].basehealth);
	println("The wing just got exploded for ",x," points of damage!");
	level.parts_array[0] dodamage(x, level.parts_array[0].origin);
}
// *** End FLAK2 ***



// ***** ATTACK2 ***** START
attack2()
{
	//The Whole Bloody Luftwaffe	
	
	if(level.allow_autosave == true)
	{
		//Autosave Point #4
		maps\_utility_gmi::autosave(4);
	}

	_debug("ATTACK 2 START");

	level thread dummies_ambient();

	level thread vo_reset();

	wait 2;

	dialogue(101);

	while(level.flak == true)
	{
		wait 0.05;
	}

	level.inattack = 2;

	level.lwgunner.idle = false;
	level.rwgunner.idle = false;

	println("^5STATUS CHECK:  lwgunner.alive = ", level.lwgunner.alive,"  ^5: lwgunner.idle = ", level.lwgunner.idle);

	_debug("AEN 6");

	//************************************************************
	//Thread the difficulty ramping function known as Cheez2 HERE!
	thread cheez2(2);
	//************************************************************

	level thread fighter_attacks( 1, 6, 6 );					//ATTACK EVENT NUMBER * 6 *

	wait 3;

	level notify ("action_started");

	//They're everywhere! 4ef
	dialogue(84);
	
	wait 0.15;
	
	dialogue(105);

	wait 1.5;

	dialogue(106);
	
	wait 0.5;

	dialogue(107);

	wait 0.5;
	
	//dialogue(85);

	wait 1.5;

	level thread objective4();

	wait 2;

	wait 15;	

	_debug("AEN 7");

	level thread fighter_attacks( 2, 6, 7 );					//ATTACK EVENT NUMBER * 7 *

	wait 2;

	owner = level.tg_turret getturretowner();
	if( !isdefined(owner) )
	{
		level thread dialogue(87);	//Get on that tail gun NOW
	}
	
	wait 3;

	owner = level.tg_turret getturretowner();
	if( !isdefined(owner) )
	{
		level thread dialogue(108);	//Move it!  Move!
	}

	wait 5;

	b2 = getent("b2", "targetname");
	b2 thread b2_hit();

	wait 20;

	level thread cheez1(3);

	//fighter_attacks( total_num_groups, direction_bias, attack_ev_num )
	level thread fighter_attacks(3, 6, 8 );						//ATTACK EVENT NUMBER * 8 *

	wait 50;

	_debug("AEN 8");

	level thread fighter_attacks( 1, 12, 9 );					//ATTACK EVENT NUMBER * 9 *

	level thread objective5();		//Get back on the dorsal turret!

	level thread dialogue(81);

	wait 3.25;

	level thread lwgunner_gets_strafed();	//Left Waist gunner gets strafed

	wait 7;

	_debug("AEN 9");

	level thread fighter_attacks( 1, 9, 10 );					//ATTACK EVENT NUMBER * 10 *

	wait 20;

	level thread fighter_attacks( 1, 3, 11 );					//ATTACK EVENT NUMBER * 11 *

	wait 17;

	_debug("AEN 10");

	level thread fighter_attacks( 1, 12, 12 );					//ATTACK EVENT NUMBER * 12 *

	wait 4;

	level thread dialogue(85);		//Go anywhere

	wait 11;

	_debug("AEN 11");

	level thread fighter_attacks( 6, 0 , 13 );					//ATTACK EVENT NUMBER * 13 *

	wait 40;

	_debug("AEN 12");

	level thread fighter_attacks( 4, 6 , 14 );					//ATTACK EVENT NUMBER * 14 *

	wait 9;

	owner = level.tg_turret getturretowner();
	if( !isdefined(owner) )
	{
		level thread dialogue(87);	//Get on that tail gun NOW
	}
	level thread objective6();

	wait 3;

	owner = level.tg_turret getturretowner();
	if( !isdefined(owner) )
	{
		level thread dialogue(108);	//Move it!  Move!
	}

	wait 15;

	//thread a trio to shoot down these bad boys, use a copy of the one you need to create for TG death event
	level thread b4_b5_collide();

	while(level.dlp == true)
	{
		wait 0.05;
	}
	wait 0.5;
	level thread dialogue(43);

	level waittill("attack14_done");

	level thread dialogue(88);

	level.num_planes_alive = 0;
	level.num_planes_ended[15] = 0;
	level.num_planes_in_attack[15] = 0;

	level thread cheez1(4);
	level thread fighter_attacks( 5, 0, 15 );					//ATTACK EVENT NUMBER * 15 *

	//level waittill("attack13_done");

	wait 85;

	dialogue(89);
	
	wait 1;

	//dialogue(63);			//one minute to target

	wait 0.5;
	
	level thread dialogue(45);		//nav_h01_01
	
	wait 40;
	
	level thread landscape_trans2();

	wait 20;

	_debug("ATTACK2_EVENT_DONE");

	level notify("attack2_event_done");

	level notify ("action_done");
	
	level notify("cheez2_done");

	level.inattack = 0;
	level.rwgunner_idle = true;
	level.lwgunner_idle = true;
}

// ***** ATTACK2 ***** END



b4_b5_collide()
{
	b4 = getent("b4", "targetname");
	b5 = getent("b5", "targetname");

	b4 endon("death");
	b5 endon("death");

	println("^3B4 and B5 are set to take no damage!");
	b4 settakedamage(0);
	b5 settakedamage(0);


	//tell our boy to play hit, start listing and then move to right
	//some weird bug here that prevents b4 from playing the sound
            b5 playsound("bomber_hit_01");
					
	wait 0.25;

	b5 playsound("bomber_die_03");

	playfxontag(level._effect["b17engine_exp"], b4, "tag_engine_1");
	playfxontag(level._effect["b17engine_exp"], b4, "tag_engine_2");

	b4 thread b4_smoke();

	b4 rotateto( ( 0, 0, 57), 5, 3, 0 );
	b4 moveto ( ( -5511, -4253, 89), 5, 2, 0 );

	wait 4;

	b4 hide();
	b5 hide();

	explode_sound1 = spawn("script_origin",(0,0,0));
	explode_sound2 = spawn("script_origin",(0,0,0));

	explode_sound1 linkto (b4,"tag_engine_2",(0,0,0),(0,0,0));
	explode_sound2 linkto (b5,"tag_engine_2",(0,0,0),(0,0,0));

	explode_sound1 playsound("bomber_explode_01");
	playfx(level._effect["b17_rwing"], b4.origin );

	wait 0.25;	

	explode_sound2 playsound("bomber_explode_02");
	playfx(level._effect["b17_dis"], b5.origin );

	if(isdefined(b4.turret))
	{
		b4.turret delete();
	}

	if(isdefined(b5.turret))
	{
		b5.turret delete();
	}

	b4 delete();
	b5 delete();
}

b4_smoke()
{
	self endon("death");

	b4 = getent("b4", "targetname");

	for (n=0; n<90; n++)
	{
		if (n<30)
		{
			playfxontag(level._effect["b17flame1"], self, "tag_engine_1");
			playfxontag(level._effect["b17flame1"], self, "tag_engine_2");
		}
		else
		{
			playfxontag(level._effect["b17flame2"], self, "tag_engine_1");
			playfxontag(level._effect["b17flame2"], self, "tag_engine_2");
		
		}
		waitframe();
	}
	while(isalive(b4))
	{
		playfxontag(level._effect["bomber_enginesmoke"], self, "tag_engine_1");
		playfxontag(level._effect["bomber_enginesmoke"], self, "tag_engine_2");
		waitframe();
	}
}
// *** End ATTACK3 ***



// *** Begin FLAK3 ***
flak3()
{
	//Bombing Run	
	if(level.allow_autosave == true)
	{
		//Autosave Point #5
		maps\_utility_gmi::autosave(5);
	}

	//Some kind of dialogue about approaching the target, opening the bomb bay etc.

	// flak( density, duration, ramp, flak_event_num )
	//	 0.1 - 1.0, seconds, 0 = none / 1 = up / 2= down, evnum
	level thread flak( 1, 72, 1, 3 );

	wait 17;

	level thread dialogue(61);

	level.top_turret maketurretunusable();
	level.top_turret.unusable = true;

	trg = getent("mount_turret", "targetname");
	trg hideme();

	level thread bombing_run();

	level waittill ("flak_done");
		
	level notify ("flak3_event_done");
}
// *** End FLAK4 ***



// *** Begin END_OF_MISSION ***
end_of_mission()
{
	level thread landscape_trans3();

	//play flak hit in tail
	level.flak_tail1 = getent("flak_tail1", "targetname");
	level.flak_tail2 = getent("flak_tail2", "targetname");

	playfx(level._effect["flak_hit_int"], level.flak_tail1.origin );
	level thread specific_turbulence(1);

	wait 2;

	playfx(level._effect["flak_hit_int"], level.flak_tail2.origin );
	level thread specific_turbulence(1);

	wait 0.6;

	playfx(level._effect["flak_hit_int"], level.flak_tail1.origin );
	level thread specific_turbulence(2);

	level.model_array[4] hideme();
	level.model_array[14] hideme();
	level.model_array[15] showme();

	maps\_fx_gmi::loopfx("tail_fire", level.flak_tail1.origin, 0.15, undefined, undefined, 88, undefined, undefined, undefined);

	wait 0.75;

	playfx(level._effect["flak_hit_int"], level.flak_tail1.origin );
	level thread specific_turbulence(3);

	wait 0.55;

	playfx(level._effect["flak_hit_int"], level.flak_tail2.origin );
	level thread specific_turbulence(4);

	wait 0.25;

	level.model_array[5] hideme();
	level.model_array[16] hideme();
	level.model_array[17] showme();

	playfx(level._effect["flak_hit_int"], level.flak_tail1.origin );
	level thread specific_turbulence(5);

	maps\_fx_gmi::loopfx("tail_fire", level.flak_tail2.origin, 0.15, undefined, undefined, 89, undefined, undefined, undefined);

	//tell player to put out fire
	level thread dialogue(35);

	level thread objective8();

	//fire extinguisher
	level.fireextinguisher = getent( "fireextinguisher", "targetname");
	org = level.fireextinguisher.origin;
	ang = level.fireextinguisher.angles;
	level.fireextinguisher_flash = spawn( "script_model", org );
	level.fireextinguisher_flash setmodel("xmodel/o_br_prp_fireextinguisher_objective");
	level.fireextinguisher_flash.angles = ang;
	level.fireextinguisher hideme();

	level.lwg_turret maketurretunusable();

	//The big death scene
	level thread fly_away_new();
}
// *** End END_OF_MISSION ***



// ***** ***** RANDOM ATTACK FUNCTION ***** *****   This spawns planes on randomly selected paths, according to the parameters
//							we pass into it, it is used for all of the attack waves

		//total_num_groups 	= the total number of waves that attack, total planes will be random from this
		//direction_bias 	= the preferred direction to spawn planes on
		//attack_ev_num 	= to track what attack we are in

fighter_attacks( total_num_groups, direction_bias, attack_ev_num )
{
	if (level.flak == true)
	{
		_error("TRYING TO START FIGHTER GROUP WHILE FLAK IS GOING!");
		return;
	}

	//check all our parameters here and make sure they are in the correct ranges
	if( total_num_groups < 1)
	{
		total_num_groups = 1;
	}
	else 
	if ( total_num_groups > 99)
	{
		total_num_groups = 99;
	}
	
	if( isdefined( direction_bias ) )
	{
		if	( 	( direction_bias !=0 ) &&
				( direction_bias != 3 ) &&
				( direction_bias != 6 ) &&
				( direction_bias != 9 ) &&
				( direction_bias != 12 )	
			)
		{ 
			direction_bias = 0;
		}
	}
	else
	{
		direction_bias = 0;
	}

	//initialize attack state tracker variables
	level.num_planes_ended[attack_ev_num] = 0;
	level.num_planes_in_attack[attack_ev_num] = 0;
	
	//level thread how_many(attack_ev_num);

	//Set up arrays for all of plane vital statistics, use a for loop the size of the array	
	for ( group_num = 1;  group_num < ( total_num_groups + 1 ); group_num++)
	{
		//pick our group type, which determines how many planes are in the group
		grouptypenum = ( randomint(6) + 1 );	//case 1 to 6

		switch (grouptypenum)
		{
			case 1: level.fighter_array[attack_ev_num][group_num]["grouptype"] = 1;
				level.fighter_array[attack_ev_num][group_num]["groupsize"] = 4;
				break;
		
			case 2: level.fighter_array[attack_ev_num][group_num]["grouptype"] = 2;
				level.fighter_array[attack_ev_num][group_num]["groupsize"] = 5;
				break;

			case 3: level.fighter_array[attack_ev_num][group_num]["grouptype"] = 3;
				level.fighter_array[attack_ev_num][group_num]["groupsize"] = 6;
				break;

			case 4: level.fighter_array[attack_ev_num][group_num]["grouptype"] = 4;
				level.fighter_array[attack_ev_num][group_num]["groupsize"] = 7;
				break;

			case 5: level.fighter_array[attack_ev_num][group_num]["grouptype"] = 5;
				level.fighter_array[attack_ev_num][group_num]["groupsize"] = 8;
				break;

			case 6: level.fighter_array[attack_ev_num][group_num]["grouptype"] = 6;
				level.fighter_array[attack_ev_num][group_num]["groupsize"] = 9;
				break;
		}
	
		num_planes = level.fighter_array[attack_ev_num][group_num]["groupsize"];

		level.num_planes_in_attack[attack_ev_num] += num_planes;

		//set up the attack direction for this group, checking for direction bias					
		if ( direction_bias != 0)
		{
			rand_ad = direction_bias;
		}
		else
		{
			rand = ( randomint(3) + 1 );
			switch (rand)
			{
				case 1: 
					rand_ad = 3; 
					break;

				case 2: 
					rand_ad = 6; 
					break;

				case 3: 
					rand_ad = 9; 
					break;

				case 4: 
					rand_ad = 12; 
					if (attack_ev_num > 3)	//exclude attacks after attack ev 3 from the 12 o'clock
					rand_ad = 6;
					break;
			}
		}

		level.fighter_array[attack_ev_num][group_num]["attack_direction"] = rand_ad;
	}

	//outer for loop to step through each group one by one
	for ( group_num = 1; group_num < ( total_num_groups + 1 ); group_num++ )
	{
		//store the size of the group into a local variable, to control the inner loop
		thisgroupsize = level.fighter_array[attack_ev_num][group_num]["groupsize"];

		level.fighter_array[attack_ev_num][group_num]["group_announced"] = false;

		level thread wait_for_attack_end(attack_ev_num);

		//inner for loop to step through each plane in a group one by one
		for ( plane_num = 1; plane_num < ( thisgroupsize + 1 ); plane_num++)
		{
			myad = level.fighter_array[attack_ev_num][group_num]["attack_direction"];

			//each ad has 10 player attack paths, with 10 friendly attack paths, 5 hi 5 lo both sets
			hi_lo = ( randomint(2) + 1 );
			if(hi_lo == 2) 
			{
				hi_lo = 1;
				hi_lo_str = "hi";
			}
			else
			{
				hi_lo = 0;
				hi_lo_str = "lo";
			}

			//player friendly switch, most often on the player but sometimes on your friendlies
			p_f = ( randomint(2) + 1 );
			if(p_f == 2) 
			{
				p_f = 1;
			}
			else 
			{
				p_f = 0;
			}

			//pick random path
			rand_pathnum = ( randomint( 10 ) + 1 );

			mypath = "direction_" + myad + "_" + hi_lo_str + "_" + rand_pathnum;

			println(mypath);
			ePathStart = getvehiclenode(mypath, "targetname");
	
			if(!isdefined(ePathStart))
			{
				_error("PATH NOT DEFINED PROPERLY AT FIGHTER ARRAY CREATION");
				println("^3ATTACK / GROUP / PLANE ID: ",attack_ev_num,"/",group_num,"/", plane_num);
				return;
			}

			spawnLoc = ePathStart.origin;
			spawnAng = ePathStart.angles;

			//spawn the vehicle, hideme it and set its attributes, attach it to the path
			bf = spawnVehicle( "xmodel/v_ge_air_me-109", "bf", "BF109", spawnLoc, spawnAng);

			bf hideme();

			bf.attachedpath = ePathStart;	

			bf.noregen = true;				//sets for _bf109

			bf.health = level.bf109_health;

			bf.onfire = false;				//also for _bf109

			bf.script_vehiclegroup = 1;		//sets fighters into vg 1 

			bf.group_num = group_num;

			bf.plane_num = plane_num;

			bf.attackdirection = level.fighter_array[attack_ev_num][group_num]["attack_direction"];

			bf.attack_ev_num = attack_ev_num;

			bf.targetname = "bf";

			bf.groupsize = level.fighter_array[attack_ev_num][group_num]["groupsize"];

			bf.grouptype = level.fighter_array[attack_ev_num][group_num]["grouptype"];

			bf.p_f = p_f;

			bf.hi_lo = hi_lo;

			bf.loop_num = 1;

			//bf thread _debugbf();

			bf thread fighter_spawn(attack_ev_num, group_num, plane_num);
			
			rand_wait = ( randomfloat ( 3 ) + 1 );

			wait rand_wait;
		}

		//wait a random amount of time until the next group is spawned
		//case 0 is a test case that spawns 1-2 seconds apart
		switch(level.inattack)
		{
			case 0: wait_time1 = 1; wait_time2 = 1;
	
			case 1:	wait_time1 = 8; wait_time2 = 7;
	
			case 2: wait_time1 = 6; wait_time2 = 6;
	
			case 3: wait_time1 = 4; wait_time2 = 5;
		}

	rand_wait = (randomfloat ( wait_time1 ) + wait_time2 );
	wait rand_wait;
	}
}

fighter_spawn(attack_ev_num, group_num, plane_num)
{
	//before we spawn this plane, check to see if we have room for it -- if not, wait there until we do
	check_for_spawn_room(attack_ev_num, group_num);

	rand_wait = ( randomfloat( 9 ) + 1 );

	wait rand_wait;

	//THREAD VO ANNOUNCE HERE!
	if(level.fighter_array[attack_ev_num][group_num]["group_announced"] == false)
	{
		thisad = level.fighter_array[attack_ev_num][group_num]["attack_direction"];
		_debug("VO ANNOUNCE ", thisad);
		level thread vo(thisad);
		level.fighter_array[attack_ev_num][group_num]["group_announced"] = true;
	}

	self showme();

	self endon ("death");

	path = self.attachedpath;

	self thread maps\_bf109_gmi::init();

	self attachpath( path );

	self thread maps\_vehiclechase_gmi::enemy_vehicle_paths();

	self startPath();

	self thread maps\_bf109_gmi::flyby_setup();

	level thread wait_for_attack_end(attack_ev_num);
}

check_for_spawn_room(attack_ev_num, group_num)		
{
	level.num_planes_alive++;
	//if we don't have room for the new plane, wait here until we do
	if ( (level.num_planes_alive) >= level.threshhold )
	{
		_debug("^3WAITING FOR NEXT FIGHTER GROUP");

		level waittill ("spawn_fighters");
	}
}

wait_for_attack_end(attack_ev_num)
{
	while ( 1 )
	{
		if(level.num_planes_ended[attack_ev_num] == level.num_planes_in_attack[attack_ev_num])
		{
			level notify ("attack" + attack_ev_num + "_done");

			//added to reset these values, cancelling loop condition
			level.num_planes_in_attack[attack_ev_num] = 0;
			level.num_planes_ended[attack_ev_num] = 0;

			if(level.num_planes_alive==0)
			{
				level notify ("not_under_attack");
			}
		break;
		}
	waitframe();
	}
}

//***** ***** RANDOM ATTACK FUNCTION ***** ***** END


//VOICEOVERS FIGHTER CALL OUT FUNCTION
//this function is passed a variable that represents the attack direction of the group
//only every other group on a direction gets announced, i.e. the first, the third, the fifth, etc.

		//list of vo lines
		//dialogue #:	

		//		29		get on right waist gun
		//		30		fighters at 3 o'clock
		//		42		more bandits 3 o'clock
		//		52		bogies_at_3
		//		53		me_3

		//		32		get on that tail gun
		//		33		bandits on our 6 o'clock
		// 		54		fighters_on_6
		//		55		more_bandits_6

		//		28		get on left waist gun
		//		31		more 109's at 9 o'clock
		//		56		bandits_9
		//		57		more_bandits_9

		//		58		mess_12

vo(num)			
{
	player_in_turret = false;

	wait 6;

	switch (num)
	{
		case 3:	
			if(level.vo3 == false)
			{
				//announce
				switch (level.vo3_num)
				{
					case 0:	//First time this vo's been played
						//WAIT FOR ANY LINE PLAYING TO STOP!
						while(level.dlp == true)
						{
							wait 0.05;
						}
						level thread dialogue(30);
						
						owner = level.rwg_turret getturretowner();
//						if(isdefined(owner))
//						{
//							if(owner == level.player)
//							{
//								player_in_turret = true;
//							}
//							else
//							{
//								player_in_turret = false;
//							}
//						}
//
//						if( ( player_in_turret == 0 ) && (level.inattack != 1) )
//						{
//							wait 1;
//							level thread dialogue(29);
//						}
						//level.vo3_num++;
						break;
		
					case 1: //second time this vo's been played
						//WAIT FOR ANY LINE PLAYING TO STOP!
						while(level.dlp == true)
						{
							wait 0.05;
						}
						level thread dialogue(42);
						level.vo3_num++;
						break;
	
					case 2:	//WAIT FOR ANY LINE PLAYING TO STOP!
						while(level.dlp == true)
						{
							wait 0.05;
						}
						level thread dialogue(52);
						level.vo3_num++;
						break;
		
					case 3:	//WAIT FOR ANY LINE PLAYING TO STOP!
						while(level.dlp == true)
						{
							wait 0.05;
						}
						level thread dialogue(53);
						level.vo3_num = 0;
						break;
				}
				//level.vo3 = true;
			}
			else
			{
				level.vo3 = false;
			}				

			break;
		
		case 6:
			if(level.vo6 == false)
			{

				//announce
				switch (level.vo6_num)
				{
					case 0:	//First time this vo's been played
						//Skip this if there's a line playing
						if(level.dlp == true)
						{
							return;
						}

						level.dlp = 1;
						level thread dialogue(33);
						wait 2;
						level.dlp = 0;

						level.vo6_num++;
						break;
		
					case 1: //second time this vo's been played
						//Skip this if there's a line playing
						if(level.dlp == true)
						{
							return;
						}

						level.dlp = 1;
						level thread dialogue(55);
						wait 2;
						level.dlp = 0;

						level.vo6_num++;
						break;
	
					case 2:	
						//Skip this if there's a line playing
						if(level.dlp == true)
						{
							return;
						}

						level.dlp = 1;
						level thread dialogue(54);
						wait 2;
						level.dlp = 0;

						level.vo6_num = 0;
						break;
				}
				level.vo6 = true;
			}
			else
			{
				level.vo6 = false;
			}
			
			break;

		case 9:
			if(level.vo9 == false)		
			{
				//announce
				switch (level.vo9_num)
				{
					case 0:	//First time this vo's been played
						//WAIT FOR ANY LINE PLAYING TO STOP!
						while(level.dlp == true)
						{
							wait 0.05;
						}

						level thread dialogue(56);
//
//						owner = level.lwg_turret getturretowner();
//
//						if(isdefined(owner))
//						{
//							if(owner == level.player)
//							{
//								player_in_turret = true;
//							}
//							else
//							{
//								player_in_turret = false;
//							}
//						}
//
//						if( ( !player_in_turret ) && (level.inattack > 2 ) )
//						{
//							wait 1;
//							level thread dialogue(28);
//						}

						//level.vo9_num++;
						break;
		
					case 1: //second time this vo's been played
						//WAIT FOR ANY LINE PLAYING TO STOP!
						while(level.dlp == true)
						{
							wait 0.05;
						}

						level thread dialogue(31);
						level.vo9_num++;
						break;
	
					case 2:	
						//WAIT FOR ANY LINE PLAYING TO STOP!
						while(level.dlp == true)
						{
							wait 0.05;
						}

						level thread dialogue(57);
						level.vo9_num = 0;
						break;
				}
				//level.vo9 = true;
			}
			else
			{
				level.vo9 = false;
			}
			
			break;

		case 12:
			if(level.vo12 == false)
			{
				//announce
				//WAIT FOR ANY LINE PLAYING TO STOP!
				while(level.dlp == true)
				{
					wait 0.05;
				}
				level thread dialogue(58);
			}
			else
			{
				level.vo12 = false;
			}

			break;
	}
}


vo_reset()		//I've eliminated this feature, it didn't work as well as I had hoped
{		
	level.vo3 = false;
	level.vo6 = false;
	level.vo9 = false;
	level.vo12 = false;
}


//****Utililities
waitframe()
{
	maps\_spawner_gmi::waitframe();
}

//animation support setup
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

//player fail / success
player_mission_success()
{
	setcvar("cg_hudcompassvisible", "1");
	setcvar("g_speed", "190");

	missionsuccess("trainbridge", false);
}

player_mission_failed()
{
	if(isdefined(level.pmf)) return;
	level.pmf = 1;
	iprintlnbold(&"GMI_BOMBER_YOU_DIED");
	setcvar("cg_hudcompassvisible", "1");
	setcvar("g_speed", "190");
	setCvar("ui_deadquote", "@GMI_BOMBER_YOUR_HEAD_ASPLODE");
	missionfailed();
}



// ***** MUSIC ***** START
music()
{
	//musicplay("bomber_stealth");
	level waittill ("action_started");
	musicStop();
	musicplay("bomber_frantic");
	level waittill("action_done");
	musicStop();
	//musicplay("bomber_stealth");
	level thread music();
}
// ***** MUSIC ***** END



// ***** BALL TURRET GUNNER ***** START
//	fixed the sounds on spinning ( jed ) 
//	changed sound aliases to ball_turret... (steveg)
ballturret()
{
	level.bt = getent("ballturret", "targetname");

	level.bt thread ballturret_lookalive();

	while( 1 )
	{
		//pick random direction to spin
		rotatedirection = randomint(2);
		switch(rotatedirection)
		{
			case 0:		//ball turret rotates at a speed of 180 degrees every 3 seconds
					// ==0.0167 seconds per degree
					// Ball turret accelerates in 1/4 of the total time, and decelerates a little faster
					rotateangles = (randomint(170))+10;
					rotatetime = (rotateangles) * 0.0167;
					acceltime = rotatetime / 4;
					deceltime = rotatetime / 5;

					level.bt playloopsound("ball_turret_spin");

					level.bt rotateTo( ( (level.bt.angles[0]), (level.bt.angles[1] + rotateangles), (level.bt.angles[2]) ), rotatetime, acceltime, deceltime);
					wait rotatetime;

					level.bt stoploopsound("ball_turret_spin");
					level.bt playsound("ball_turret_stop");

					//Spend a random amount of time facing this direction
					randomwait = randomint(5);
					if(randomwait > 3) randomwait = 0;
					
					wait randomwait;
					break;
					
			case 1:
					rotateangles = (randomint(170))+10;
					rotatetime = (rotateangles) * 0.0167;
					acceltime = rotatetime / 4;
					deceltime = rotatetime / 5;

					level.bt playloopsound("ball_turret_spin");
												//     v
					level.bt rotateTo( ( (level.bt.angles[0]), (level.bt.angles[1] - rotateangles), (level.bt.angles[2]) ), rotatetime, acceltime, deceltime);
					wait rotatetime;

					level.bt stoploopsound("ball_turret_spin");
					level.bt playsound("ball_turret_stop");

					//Spend a random amount of time facing this direction
					randomwait = randomint(5);
					if(randomwait > 3) randomwait = 0;
					
					wait randomwait;
					break;
		}
		wait 0.05;
	}
}
		
ballturret_lookalive()
{
	//This jiggery-pokery mumbo-jumbo makes the ball turret wait awhile into the first attack to start firing
	while(level.inattack == 0)
	{
		wait 1;
	}

	if(!isdefined(firstfire))
	{
		wait 10;
		firstfire = false;
	}

	while( 1 )
	{
		//If the plane is not under attack, the ball turret fire sounds don't play
		wait (randomfloat(3) + 5 );
		if(level.inattack != 0)
		{
			for(n=0;n<(randomint(10)+5);n++)
			{
				self playsound("weap_50_ball_fire");
				wait 0.11;
			}
	
			chance = randomint(3) + 1;

			if(chance == 1)
			{
				for(n=0;n<(randomint(10) + 20);n++)
				{
					self playsound("weap_50_ball_fire");
					wait 0.11;
				}
			}
		}
	}
}

// ***** BALL TURRET GUNNER ***** END



// ***** PLAYER'S BOMB BAY  ***** START
bombbay_doors()
{
	ldoor = getent("bombbay_ldoor", "targetname");
	rdoor = getent("bombbay_rdoor", "targetname");
	bombbay = getent("bombbay", "targetname");

	ldoor2 = getent("bombbay_ldoor_hidden", "targetname");
	rdoor2 = getent("bombbay_rdoor_hidden", "targetname");

	level.bomb_bay_crank = getent("bomb_bay_crank", "targetname");
	level.use_bay_crank = getent("use_bay_crank", "targetname");
	level.use_bay_crank setcursorhint("HINT_NONE");

	ldoor2 hideme();
	rdoor2 hideme();

	ldoor linkto(bombbay, "tag_bombay_l-door", (0,0,0), (0,0,0));
	rdoor linkto(bombbay, "tag_bombay_r-door", (0,0,0), (0,0,0));

	level waittill("open_bomb_bay");

	ldoor hideme();
	rdoor hideme();

	ldoor2 showme();
	rdoor2 showme();

	//rotateTo(vec orent, float time, <float acceleration_time>, <float deceleration_time>);
	//This rotates the entity to a specific (pitch, yaw, roll) orientation.
	//·	mover rotateTo(ang, 10, 1, 1);
	
	thread wind_thread();

 	ldoor2 rotateTo ( ( 0, 0, 90 ), 20, 2, 2 );
 	rdoor2 rotateTo ( ( 0, 0, -90 ), 20, 2, 2 );

//	level waittill("bombs_drop");
	wait 17;

	level thread dialogue(50);

	wait 5.5;

	//set up array of all 8 bombs
	for (n=1; n<5; n++)
	{
		level.lbombs[n] = getent("lbomb_" + n, "targetname");
		level.rbombs[n] = getent("rbomb_" + n, "targetname");
	}

	for (n=4; n>0; n--)
	{
		//drop em pairs at a time, staggered
		
		//moveTo(vec position, float time, <float acceleration_time>, <float deceleration_time>);
		//This moves the entity to a specific location in space.
		//·	mover moveTo(pos, 10, 1, 1);

		lcurpos = level.lbombs[n].origin;
		rcurpos = level.rbombs[n].origin;

		if(!isdefined(lcurpos))
		{
			_error("level.lbombs[n].origin is undefined");
				return;
		}

		if(!isdefined(rcurpos))
		{
			_error("level.rbombs[n].origin is undefined");
				return;
		}

		//two stages of movement, I don't want em to wiggle or fall back until they get out of the bomb bay

		//moveGravity(vector velocity, float time);
		//This moves the entity with gravity affecting it. It starts the move with the specified velocity, and moves for the specified amount of time.
		//·	mover moveGravity(vel, 3);

		level.lbombs[n] playsound("bomb_release");
		level thread lbombs_fall(n);
	
		wait 0.3;

		level.rbombs[n] playsound("bomb_release");
		level thread rbombs_fall(n);

		wait 0.3;
	}

	//Bomb bay doors will never close now
//        level notify ("wind_down");   // For fading back down
//
// 	ldoor2 rotateTo ( ( 0, 0, 0 ), 20, 2, 2 );
// 	rdoor2 rotateTo ( ( 0, 0, 0 ), 20, 2, 2 );
}

lbombs_fall(n)
{
	level.lbombs[n] moveGravity((0, 0, 0), 8);
	wait 0.4;
	level.lbombs[n] playsound("bomb_whistle");
	level.lbombs[n] thread bomb_wiggle();

	wait 8;
	level.lbombs[n] delete();
}

rbombs_fall(n)
{
	level.rbombs[n] moveGravity((0, 0, 0), 8);
	wait 0.4;
	level.rbombs[n] playsound("bomb_whistle");
	level.rbombs[n] thread bomb_wiggle();

	wait 8;
	level.rbombs[n] delete();
}
	

bomb_wiggle()
{
	self endon("death");

	original_angles = self.angles;
	while(1)
	{
		roll = 20 + randomfloat(30);
		yaw = 6 + randomfloat(3);
		time = 0.25 + randomfloat(0.25);
		time_in_half = time/3;

		self bomb_pitch(time);
		self rotateto((self.pitch,(original_angles[1] + (yaw * -2)),(roll * -2)), (time * 2),(time_in_half * 2),(time_in_half * 2));
		self waittill("rotatedone");

		self bomb_pitch(time);
		self rotateto((self.pitch,(original_angles[1] + (yaw * 2)),(roll * 2)), (time * 2),(time_in_half * 2),(time_in_half * 2));
		self waittill("rotatedone");
	}
}

bomb_pitch(time_of_rotation)
{
	self endon("death");

	if(!isdefined(self.pitch))
	{
		original_pitch = self.angles;
		self.pitch = original_pitch[0];
	}

	if(self.pitch < 80)
	{
		self.pitch = (self.pitch - (40 * time_of_rotation));
		if(self.pitch > 80)
		{
			self.pitch = 80;
		}
	}
	return;
}

wind_thread()
{
         blend = spawn( "sound_blend", ( 0, 0, 0 ) );
	blend.origin = (184, 0, -50);
         for (i=0;i<1;i+=0.01)
         {
                 blend setSoundBlend( "bombay_wind_low", "bombay_wind_high", i );
                 wait (0.11);
         }
         level waittill ("wind_down");
         for (i=1;i>0;i-=0.01)
         {
                 blend setSoundBlend( "bombay_wind_low", "bombay_wind_high", i );
                 wait (0.11);
         }
}

bomb_bay_crank()
{
	//this is for the flashing objective crank
	level.bomb_bay_flash = spawn("script_model",(level.bomb_bay_crank.origin) );
	level.bomb_bay_flash.angles = level.bomb_bay_crank.angles;
	level.bomb_bay_flash setmodel("xmodel/v_us_air_b-17_bombay_crank_objective");
	level.bomb_bay_flash hideme();

	level waittill ("use_bomb_bay");

	level.bomb_bay_crank hideme();

	level.bomb_bay_flash showme();

	level.use_bay_crank setcursorhint("HINT_ACTIVATE");

	level.use_bay_crank waittill("trigger");

	level.bomb_bay_used = true;

	level notify("open_bomb_bay");

	level.use_bay_crank setcursorhint("HINT_NONE");
	
	locker = spawn("script_origin", (0,0,0));

	locker.origin = level.player.origin;

	level.player linkto(locker);

	oldang = level.bomb_bay_flash.angles;

	level.bomb_bay_flash playloopsound("crank_rotate");

	for(n=0;n<180; n++)
	{
		level.bomb_bay_flash rotateTo( (oldang - (0,0,60) ), 0.05, 0, 0);
		level.bomb_bay_flash waittill ("rotatedone");
		oldang -= (0,0,60);
	}

	level.bomb_bay_flash stoploopsound("crank_rotate");

	level.bomb_bay_flash hideme();

	level.bomb_bay_crank showme();

	objective_state(7,"done");
	objective_current(0);

	wait 1;

	level notify ("friendlies drop bombs");

	wait 12;

	dialogue(91);

	wait 1;

	level thread dialogue(109);

	level thread end_of_mission();

	wait 2;

	level.player unlink();
}
// ***** PLAYER'S BOMB BAY ***** END



// ***** ***** FRIENDLY BOMBER SECTION ***** *****
friendly_bombers_damage_check()			
{
	while( 1 )
	{
		self waittill("damage", dmg, who);

		if(self.script_health < 1) 
		{
			println("^5Friendly bomber has less than 1 health, returning");
			self thread friendly_bombers_damage_check();
			return;
		}

		println("^5Friendly bomber damaged:  ", dmg, " ",who);

		if( (who == level.player) && (level.ff_warning == false) )
		{
			level thread ff();
			level.ff_warning = true;
		}

		if(self.targetname == "b9" || self.targetname == "b2" || self.targetname == "b4" || self.targetname == "b5")
		{
			println("^1Friendly bomber on ignore list took damage, ignored ", dmg, " ^1points from ", who);
			self thread friendly_bombers_damage_check();
			return;
		}

		self.script_health -= dmg;

		println("^5Friendly bomber took damage, damaged ", dmg, " ^5points from ", who);
		println(self.targetname," ^5has ",self.script_health," ^5remaining");
	
		if( (self.script_health < (0.50 * self.script_maxhealth)) && !(isdefined(self.smoking) && self.smoking != true) )
		{
			self thread friendly_bomber_smoking();
		}

		if(self.script_health < 1)
		{
			self thread friendly_bomber_dies(who);
		}
	}
}

friendly_bomber_smoking()
{
	self endon ("death");

	if(self.targetname == "b7" || self.targetname == "b6" || self.targetname == "b2" || self.targetname == "b3")
	{
		rand = randomint(2)+1;
		mytag = "tag_engine_" + rand;
	}
	else
	{
		rand = randomint(2)+3;
		mytag = "tag_engine_" + rand;
	}
	self.mytag = mytag;

	if( (isdefined(self.smoking)) && (self.smoking == true) ) return;

	self.smoking = true;

	self playsound("bomber_hit");
	playfxontag(level._effect["b17engine_exp"], self, self.mytag);
	wait 0.25;

	if(self.targetname == "b8") level.b8_contrails_off = true;
	if(self.targetname == "b10") level.b10_contrails_off = true;

	while(1)
	{
		playfxontag(level._effect["bomber_enginesmoke"], self, self.mytag);
		wait 0.3;
	}	
}

friendly_bomber_dies(who)
{
	self endon("death");

	self notify("bomber is dying");

	if(!isdefined(who))
	{
		_error("^1FRIENDLY BOMBER FAILED TO GET ATTACKER 'WHO'");
		return;
	}

	if( (who == level.player)  )
	{
		level.allow_autosave = false;
		println("^1AUTOSAVE DISABLED!!");
	}

	if( isdefined(self.targetname) && (self.targetname == "b9" || self.targetname == "b2" || self.targetname == "b4" || self.targetname == "b5") )
	{
		println("Friendly bomber is aborting death");
		return;
	}

	self playsound("bomber_hit");

	playfxontag(level._effect["b17engine_exp"], self, self.mytag);

	wait 0.25;

	self thread friendly_bomber_onfire();

	self playsound("bomber_die_friendly");

	self moveto((self.origin + (-30000,0,-15000)),8,6,0);

	wait 0.05;

	//Either a) dive nose or b) roll wing towards fire, or hell c) both
	choose = randomint(3);
	switch(choose)
	{
		case 0:		//Nose dive, rate should be 80 degrees in 6 seconds
				angles1 = randomint(20) + 70;
				angles2 = 0;
				rate = 0.075;
				thistime = rate * angles1;
				acceltime = thistime / 4;
				deceltime = thistime / 2;
				break;

		case 1:		//Wing roll towards affected wing, 80 degrees in 6 seconds
				switch(self.mytag)
				{
					case "tag_engine_1":
					case "tag_engine_2":
								angles1 = 0;
								angles2 = randomint(50)+120;
								rate = 0.0375;
								thistime = rate * angles2;
								acceltime = thistime / 4;
								deceltime = thistime / 2;
								break;
				
					case "tag_engine_3":	
					case "tag_engine_4":
								angles1 = 0;
								angles2 = randomint(50)+120;
								rate = 0.0375;
								thistime = rate * angles2;
								acceltime = thistime / 4;
								deceltime = thistime / 2;
								//Reverses the roll direction
								angles2 = angles2 * (0-1);
								break;
				}
				break;

		case 2:		//Pitch nose down and roll also!
				switch(self.mytag)
				{
					case "tag_engine_1":
					case "tag_engine_2":
								angles1 = randomint(20) + 70;
								angles2 = randomint(50)+120;
								rate = 0.075;
								thistime = rate * angles2;
								acceltime = thistime / 4;
								deceltime = thistime / 2;
								break;
				
					case "tag_engine_3":	
					case "tag_engine_4":
								angles1 = randomint(20) + 70;
								angles2 = randomint(50)+120;
								rate = 0.075;
								thistime = rate * angles2;
								acceltime = thistime / 4;
								deceltime = thistime / 2;
								//Reverses the roll direction
								angles2 = angles2 * (0-1);
								break;
				}
				break;

	}

	//***pitch ***yaw ***roll :: PYR
	self rotateto( (self.angles[0]+angles1, self.angles[1], self.angles[2]+angles2) , thistime, acceltime, deceltime);

	doescrewbail = randomint(2);
	if(doescrewbail == 1)
	{
		crewbailtime = randomint(4) + 1;
		wait crewbailtime;
		maps\_fx_gmi::OneShotFX("crewbail", self.origin + (0,0,-100), 0);
	}

	if( (who == level.player) && ( getcvar("username") != "Thad" ) && ( getcvar("username") != "Mike" )  )
	{
		//Note:  Mike and I can't fail this mission from friendly fire hehe

		setCvar("ui_deadquote", "@SCRIPT_MISSIONFAIL_KILLTEAM_BRITISH");

		missionfailed();
	}

	deathlife = randomint(5)+5;
	played = false;
	for(n=0;n<deathlife;n++)
	{
		//secondary explosions
		//these only occur if the plane is alive >10 seconds and the 50% chance is met -- haha looks cool
		wait 1;
		chance = randomint(3);
		if(chance == 1 && played == false)
		{	
			//secondary explosions can reoccur if rechance is hit
			self playsound("bomber_hit");
			playfxontag(level._effect["b17engine_exp"], self, self.mytag);
			played = true;
			rechance = randomint(2);
			if(rechance==1) 
			{
				played = false;

				//chance to catch second engine on fire!
				secondchance = randomint(2);
				if( secondchance == 1 && !isdefined(self.newfire) )
				{
					switch(self.mytag)
					{
						case "tag_engine_1":	
									self.newfire = "tag_engine_2";
									break;
						case "tag_engine_2":	
									self.newfire = "tag_engine_1";
									break;
						case "tag_engine_3":	
									self.newfire = "tag_engine_4";
									break;
						case "tag_engine_4":	
									self.newfire = "tag_engine_3";
									break;
					}
					//Additional engine on same wing catches on fire
					self playsound("bomber_hit");
					playfxontag(level._effect["b17engine_exp"], self, self.newfire);
					level thread friendly_bomber_secondary_onfire();
				}
			}
		}
	}
	self playsound("bomber_explode_02");
	wait 0.05;
	self hide();
	playfx(level._effect["b17_dis"], self.origin );

	if(isdefined(self.turret)) self.turret delete();
	self delete();
}

friendly_bomber_onfire()
{	
	self endon("death");

	smoketime = randomint(300) + 150;
	for (n=0; n<600; n++)
	{
		if (n<smoketime)
		{
			playfxontag(level._effect["b17flame1"], self, self.mytag);
		}
		else
		{	
			playfxontag(level._effect["b17flame2"], self, self.mytag);
		}
		wait 0.05;
	}
}

friendly_bomber_secondary_onfire()
{
	self endon("death");

	if(!isdefined(self.newfire)) return;
	
	smoketime = randomint(300) + 150;
	for (n=0;n<600;n++)
	{
		if (n<smoketime)
		{
			playfxontag(level._effect["b17flame1"], self, self.newfire);
		}
		else
		{
			playfxontag(level._effect["b17flame2"], self, self.newfire);
		}
		wait 0.05;
	}
}

friendly_drop_bombs()
{
	//get coordinates to drop the bombs FROM
	level waittill("friendlies drop bombs");

	rand_wait = randomfloat(4)+1;
	wait rand_wait;

	for (n=0; n<4; n++)
	{
		rorg = self.origin;
		lorg = rorg + (0,128,0);
		lb = spawn("script_model", lorg);
		rb = spawn("script_model", rorg);
	
		lb setmodel ("xmodel/v_us_air_b-17_l-bomb");
		rb setmodel ("xmodel/v_us_air_b-17_r-bomb");

		lb.angles = (lb.angles[0], lb.angles[1] + 180, lb.angles[2]);
		rb.angles = (rb.angles[0], rb.angles[1] + 180, rb.angles[2]);

		lb thread bombs_fall();
		wait 0.3;
		rb thread bombs_fall();
		wait 0.3;
	}

	wait 8;
	maps\_fx_gmi::loopfx("distant_bombs", (0,0,0), 0.5, undefined, undefined, 999, undefined, undefined, undefined);
}

bombs_fall()
{
		self moveGravity((0, 0, 0), 8);
		wait 0.3;
		self thread bomb_wiggle();
		wait 8;
		self delete();
}

bombing_run()
{
	//dialogue(45);		//Yeah, it would be nice to have the nav chime in here but screw it
	wait 1.5;	
	dialogue(46);
	wait 0.5;
	dialogue(47);
	wait 2;
	level thread objective7();
	level thread dialogue(49);
	level notify ("use_bomb_bay");

	reps = 0;

	while(level.bomb_bay_used == false)
	{
		reps++;
		wait 20;
		if(reps>2)
		{
			//This is a temporary deadquote, need a new one for "you disobeyed orders"
			setCvar("ui_deadquote", "@GMI_SCRIPT_MISSIONFAIL_INSUBORDINATION");
			missionFailed();
			return;
		}
		if(level.bomb_bay_used == false)
		{
			level thread dialogue(49);
		}
	}
}

tail_blows_away()
{
	//hideme normal pieces
	level.model_array[4] hideme();
	level.model_array[5] hideme();
	level.model_array[14] hideme();
	level.model_array[15] hideme();
	level.model_array[16] hideme();
	level.model_array[17] hideme();
	level.model_array[22] hideme();
	level.model_array[23] hideme();

	level.model_array[21] showme();
	
	level.model_array[21] playsound("tail_section_explode");

	maps\_fx_gmi::OneShotfx("tail_event", ( 0, 0, 0 ), 0.0 );
}

//fly_away()
//{
//	//Turn off the lwg
//	level.lwg_turret maketurretunusable();
//
//	//go player go
//	level.side = "none";
//	level.fakeride = spawnVehicle( "xmodel/v_ge_air_me-109", "fakeride", "BF109", (-1000,-1000,-1000),(0,0,0));
//	level.fakeride hideme();
//
//	path1 = getvehiclenode("fly_start_right", "targetname");
//	path2 = getvehiclenode("fly_start_left", "targetname");
//
//	level.lefttrig = getent("fly_right", "targetname");
//	level.righttrig = getent("fly_left", "targetname");
//
//	level thread lefttrig_wait();
//	level thread righttrig_wait();
//
//	level waittill ("fly_away");
//
//	level thread dialogue(51);
//
//	level thread tail_blows_away();
//
//	level.fireextinguisher_flash hideme();
//
//	level notify("stop fx 88");
//	level notify("stop fx 89");
//
//	level.tg_turret hideme();
//
//	level.tgunner setflaggedanimknobrestart("never", level.scr_anim["tail"]["tgunner_flying"], 1, 0, 1 );
//
//	if (level.side == "right")
//	{
//		path = path1;
//	}
//	else
//	{
//		path = path2;
//	}
//
//	level.fakeride attachpath(path);
//
//	level.player linkTo(level.fakeride, "tag_origin", (0,0,0),(0,0,0));
//
//	level.fakeride startpath();
//
//	level.player freezecontrols(true);
//
//	wait 3.8;
//
//	level thread player_mission_success();
//}

lefttrig_wait()
{
	level.lefttrig waittill("trigger");
	level.side = "left";
	level notify ("fly_away");
	println("LEFT TRIGGER");
	return;
}

righttrig_wait()
{
	level.righttrig waittill("trigger");
	level.side = "right";
	level notify ("fly_away");
	println("RIGHT TRIGGER");
	return;
}

//Sigh, this event has been cut
//Top turret is strafed out
//top_turret_die()
//{
//	//top_turret_attacker
//	fakePathStart = getvehiclenode("top_turret_attacker", "targetname");
//	
//	newloc = fakePathStart.origin;
//	newang = fakePathStart.angles;	
//
//	fakebf = spawnvehicle( "xmodel/v_ge_air_me-109", "fakebf", "BF109", newloc, newang );
//
//	fakebf.noregen = false;
//	fakebf.onfire = false;
//	fakebf.script_vehiclegroup = 7;
//	fakebf.group_num = 0;
//	fakebf.plane_num = 0;
//	fakebf.attackdirection = 0;
//	fakebf.loop_num = 1;
//	fakebf.targetname = "fakebf";
//	fakebf.mytarget = getent("target_topturret", "targetname");
//
//	fakebf thread maps\_bf109_gmi::init();
//
//	path = fakePathStart;
//	fakebf.attachedpath = path;
//
//	fakebf attachpath(path);
//
//	fakebf thread maps\_vehiclechase_gmi::enemy_vehicle_paths();
//
//	fakebf startpath();
//
//	wait 13.5;
//
//	level.damagestate[0] = 2;
//
//	speaker = getent("target_topturret", "targetname");
//
//	for(n=0; n<8; n++)
//	{
//		pct = randomfloat(1); 	
//
//		if(pct > 0.7)
//		{
//			level.player playSound("bullet_mega_flesh");
//			level.player dodamage(60,level.player.origin);
//		}
//		else 
//		{
//			level.player playsound("bullet_large_metal");
//			playfx(level._effect["bullet_hit"], level.top_turret.origin);
//		}
//
//		if(n==5) 
//		{
//			level thread dialogue(19);		//turret buggered event
//			level thread copilot_b01_06_anim();
//		}
//
//
//		wait (randomfloat(0.2) + 0.075);
//	}
//
//	level.top_turret maketurretunusable();
//
//	level.top_turret_unusable = true;
//
////	New patch SP commands that I'm delighted to use
////	setrightarc - for setting turret parameters in game
////	setleftarc- for setting turret parameters in game
////	settoparc- for setting turret parameters in game
////	setbottomarc- for setting turret parameters in game
//	level.top_turret setrightarc(0);
//	level.top_turret setleftarc(0);
//	level.top_turret settoparc(0);
//	level.top_turret setbottomarc(0);
//
//	mount_trigger = getent("mount_turret", "targetname");
//	mount_trigger delete();
//
//	maps\_fx_gmi::loopfx("turret_sparking", level.top_turret.origin, 0.15, undefined, undefined, 10, undefined, undefined, undefined);
//
//	level notify("objective 1 complete");
//
//}

/*
copilot_b01_06_anim()
{
	level.copilot notify("idleA done");
	level.copilot setflaggedanimknobrestart("animY done", level.scr_anim["copilot"]["copilot_b01_06"], 1, 1, 1 );
	level.copilot waittill("animY done");
	level.copilot setflaggedanimknobrestart("idleA done", level.scr_anim["copilot"]["copilot_idleA"], 1, 0.5, 1 );
}
*/

strafe_setup()
{
	// put all of the right side bullet holes into an array mostly for size of array info
	level.bh = getentarray("bullet_hole", "groupname");

	level.bhr = [];
	level.bhr_tag = [];
	level.bhl = [];
	level.bhl_tag = [];

	// org = tag_entity gettagOrigin (tag);
	// angles = tag_entity gettagAngles (tag);


	// This loop grabs up all of the tags on the waist section for the bulletholes
	// and stuffs em into an array, if the bullet pierces the fuselage the opposing tag's grabbed too	
	for (n=0; n<level.bh.size; n++)
	{
		m=n+1;
		level.bhr[n] = getent("bh"+m+"a", "targetname");
		level.bhr[n].through = false;

		if(!isdefined(level.bhr[n])) _error(n,"NOT DEFINED");

		if(m<10)
		{
			level.bhr_tag_org[n] = level.model_array[2] getTagOrigin("tag_bh0" + m + "a");
			level.bhr_tag_angles[n] = level.model_array[2] getTagAngles("tag_bh0" + m + "a");
			level.bhr_tag_name[n] = "tag_bh0" + m + "a";

			if( (isdefined(level.bhr[n].script_noteworthy)) && (level.bhr[n].script_noteworthy == "through") )
			{
				level.bhl_tag_org[n] = level.model_array[3] getTagOrigin("tag_bh0" + m + "b");
				level.bhl_tag_angles[n] = level.model_array[3] getTagAngles("tag_bh0" + m + "b");
				
				level.bhl_tag_name[n] = "tag_bh0" + m + "b";
			}
		}
		else	
		{			
			level.bhr_tag_org[n] = level.model_array[2] getTagOrigin("tag_bh" + m + "a");
			level.bhr_tag_angles[n] = level.model_array[2] getTagAngles("tag_bh" + m + "a");
			level.bhr_tag_name[n] = "tag_bh" + m + "a";

			if( (isdefined(level.bhr[n].script_noteworthy)) && (level.bhr[n].script_noteworthy == "through") )
			{
				level.bhl_tag_org[n] = level.model_array[3] getTagOrigin("tag_bh" + m + "b");
				level.bhl_tag_angles[n] = level.model_array[3] getTagAngles("tag_bh" + m + "b");

				level.bhl_tag_name[n] = "tag_bh" + m + "b";
			}
		}

		//Set all of the through holes into an array by targetname
		if( (isdefined(level.bhr[n].script_noteworthy)) && (level.bhr[n].script_noteworthy == "through") )
		{
			level.bhl[n] = getent("bh"+ m +"b", "targetname");
			level.bhr[n].through = true;
		}
	}
}

rwgunner_gets_strafed()
{
	wgtrig = getent("waist_gunners_die", "targetname");

	wgtrig waittill ("trigger");

	//this plays only the LAST HALF of the effects here, to kill level.rwgunner
	//create speakers for sound effects, hideme bullet hole cover (and opposite if it pierces)
	for(n=13; n<level.bh.size; n++)
	{
		//play sound & effect
		loc = getent("speaker_bomber", "targetname");
		loc playsound("bullet_small_metal");

		//show hole
		level.bhr[n] hideme();

		//check for exit hole
		if(level.bhr[n].through)
		{
			level.bhl[n] hideme();
		}

		playfxontag(level._effect["bullet_tracer"], level.model_array[2], level.bhr_tag_name[n]);
		playfxontag(level._effect["bullet_hit"], level.model_array[2], level.bhr_tag_name[n]);
	
		if (level.bhr[n].through)
		{
			playfxontag(level._effect["bullet_hit"], level.model_array[3], level.bhl_tag_name[n]);
		}
				
		//wait short time
		waitframe();

		//check for random longer wait
		rand_check = randomfloat(1);

		if(rand_check > 0.55)
		{
			wait 0.25;
		}
		else
		{
			wait 0.1;
		}

		//step loop
		if(n==13)
		{
			//rwgunner killed here
//			println("rwgunner died");
			level thread rwgunner_death();
		}
	}
}

lwgunner_gets_strafed()
{
	level thread dialogue(82);

	wait 1.75;

	level thread lwg_killer();

	wait 1.45;

	level thread lwgunner_death();

	level.parts_array[0] settakedamage(1);

	//this plays only the LAST HALF of the effects here, to kill level.rwgunner
	//create speakers for sound effects, hideme bullet hole cover (and opposite if it pierces)
	for(n=0; n<(level.bh.size - 13); n++)
	{
		//play sound & effect
		loc = getent("speaker_bomber", "targetname");
		loc playsound("bullet_small_metal");

		//show hole
		level.bhr[n] hideme();

		//check for exit hole
		if(level.bhr[n].through)
		{
			level.bhl[n] hideme();
		}

		//playfxontag(level._effect["bullet_tracer"], level.model_array[2], level.bhr_tag_name[n]);
		playfxontag(level._effect["bullet_hit"], level.model_array[2], level.bhr_tag_name[n]);
	
		if (level.bhr[n].through)
		{
			//playfxontag(level._effect["bullet_hit"], level.model_array[3], level.bhl_tag_name[n]);
			playfxontag(level._effect["bullet_tracer"], level.model_array[3], level.bhl_tag_name[n]);
		}
				
		//wait short time
		waitframe();

		//check for random longer wait
		rand_check = randomfloat(1);

		if(rand_check > 0.55)
		{
			wait 0.15;
		}
		else
		{
			wait 0.05;
		}
	}

	wait 1.5;

	dialogue(83);

	wait 4;

	dialogue(102);

	level thread lwg_death_prox_check();

	wait 3;

	dialogue(103);
}

lwg_death_prox_check()
{
	for(n=0;n<40;n++)
	{
		wait 0.05;
		dist = distance(level.player.origin, level.lwg_fake.origin);
		if(dist<60)
		{
			if(level.top_turret getturretowner() != level.player)
			{
				level thread dialogue(104);
			}
			break;
		}
	}
}

lwg_killer()
{
	//for loop here
	for(n=1; n<3; n++)
	{
		spawnpoint[n] = getvehiclenode("wg_killer_" + n, "targetname");

		wg_killer[n] = spawnvehicle( "xmodel/v_ge_air_me-109", "fakebf", "BF109", (0,0,0), (0,0,0) );
		wg_killer[n].noregen = true;
		wg_killer[n].loop_num = 1;
		wg_killer[n].health = level.bf109_health;
		wg_killer[n].attachedpath = spawnpoint[n];
		wg_killer[n].onfire = false;
		wg_killer[n].group_num = -1;
		wg_killer[n].plane_num = 0; //n
		wg_killer[n].attackdirection = 9;
		wg_killer[n].p_f = 0;
		wg_killer[n].script_vehiclegroup = 8;
	
		wg_killer[n] thread wg_killer_think();
	}
}

wg_killer_think()
{
	self endon ("death");

	path = self.attachedpath;

	self attachPath( path );

	self.mytarget = level.lwgunner;

	self thread maps\_vehiclechase_gmi::enemy_vehicle_paths();

	self startPath();

	self waittill("reached_end_node");
	
	self delete();
}


// *****
// ***** ***** PLAYER BOMBER DAMAGE SECTION ***** ***** END
// *****
hud()	//controls kill counter icons
{
	// Limits of rows (y) and columns (x)
	rows = 8;
	columns = 8;

	// Size of each of the icons
	icon_x_size = 16;
	icon_y_size = 16;

	// Start position
	start_x = 504;
	start_y = 328;
	
	// Counters used to keep track.
	internal_counter = 0; // Counts the amount of kills.
	icon_counter = 0; // Counts the amount of icons.
	row_counter = 1; // 1, since 0 - 5 would be 6.
	x_mod = 0; // Shifts the icons over. X modifier.

	// Constantly check to see if there is a new kill
	while(1)
	{
		// If internal_counter is not equal to level.plane_kills then keep adding icons until they are equal.
		// This is pretty cool, and I'm happy I thought of it... Even if you were to kill 2 planes practically
		// at the same time, it will loop until they match up.
		while(internal_counter != level.total_num_kills)
		{
			// If the limit of columns are reached, shift the start_y, so 
			// the next row is underneath.
			if(icon_counter == columns)
			{
				row_counter++;
				start_y = start_y + icon_y_size;
				icon_counter = 0;
				x_mod = 0;

				level thread dialogue(90);
			}

			// Setup the hudelements. Each icon is it's own hud elemement.
			level.kill_counter_hud[internal_counter] = newHudElem();
			level.kill_counter_hud[internal_counter].alignX = "center";
			level.kill_counter_hud[internal_counter].alignY = "middle";
			level.kill_counter_hud[internal_counter].fontscale = "1.5";
			level.kill_counter_hud[internal_counter].x = (start_x + (x_mod * icon_x_size));
			level.kill_counter_hud[internal_counter].y = start_y;
			level.kill_counter_hud[internal_counter] setShader("gfx/hud/m_bomber_hud-icon.dds", icon_x_size, icon_y_size);
			level.kill_counter_hud[internal_counter].alpha = 0.5;

			//Jed suggested fix for "rotated crosses"
			level.kill_counter_hud[internal_counter].angle = 0;

			x_mod++;
			icon_counter++;	
			internal_counter++;

			// Check the limits. If limit is reached, break out.
			if(row_counter == rows && icon_counter == columns)
			{
				println("^3No more space for ICONS! Row Limit is: ",rows," ^3Counter is: ", internal_counter);
				break;
			}

			wait 0.05;
		}

		// DOUBLE Check the limits. If limit is reached, break out.
		if(row_counter == rows && icon_counter == columns)
		{
			break;
		}
		wait 0.5;
	}

// If you want to delete the above, thread this commented section
// in a new function so it kills all of the hud elements.

//	for(i=0;i<internal_counter;i++)
//	{
//		level.kill_counter_hud[i] destroy();
//	}
}

hud2_setup()
{
	//initializes damageicon states
	//0	cockpit / dorsal turret
	//1	radio room
	//2	right wing 
	//3	left wing
	//4	right waist
	//5	left waist
	//6	right tail
	//7	left tail

	level.damageicon = [];
	
	for(n=0; n<8; n++)
	{
		level.damageicon[n] = [];
	}

	level.damageicon[0] = "gfx/hud/hudadd@cockpit_0.dds";
	level.damageicon[1] = "gfx/hud/hudadd@radio_0.dds";
	level.damageicon[2] = "gfx/hud/hudadd@rwing_0.dds";
	level.damageicon[3] = "gfx/hud/hudadd@lwing_0.dds";
	level.damageicon[4] = "gfx/hud/hudadd@rwaist_0.dds";
	level.damageicon[5] = "gfx/hud/hudadd@lwaist_0.dds";
	level.damageicon[6] = "gfx/hud/hudadd@rtail_0.dds";
	level.damageicon[7] = "gfx/hud/hudadd@ltail_0.dds";

	//	set up the markers for the objectives on the plane 

	level.icons[0]["shader"] = "gfx/hud/objective.dds";
	level.icons[0]["origin"] = (125,185,16);

	level.icons[1]["shader"] = "gfx/hud/objective.dds";
	level.icons[1]["origin"] = (128,98,16);

	level.icons[2]["shader"] = "gfx/hud/objective.dds";
	level.icons[2]["origin"] = (135,120,16);

	level.icons[3]["shader"] = "gfx/hud/objective.dds";
	level.icons[3]["origin"] = (120,120,16);

	level.icons[4]["shader"] = "gfx/hud/objective.dds";
	level.icons[4]["origin"] = (128,94,16);

	level.icons[5]["shader"] = "gfx/hud/objective.dds";
	level.icons[5]["origin"] = (124,150,16);

	level.icons[6]["shader"] = "gfx/hud/objective.dds";
	level.icons[6]["origin"] = (132,140,16);

	level.icons[7]["shader"] = "gfx/hud/objective.dds";
	level.icons[7]["origin"] = (128,200,16);

	//	if we add more markers IT IS VITAL THAT WE UPDATE HUD2 to match the number below 

	level.icons[8]["shader"] = "gfx/hud/hudadd@clock.dds";
	level.icons[8]["origin"] = (128,128,128);

	level.ring = newHudElem();
	precacheShader("hudObjectiveRing");

	level.ring setShader("hudObjectiveRing",32,32);
	level.ring.alignX = "center";
	level.ring.alignY = "middle";
	level.ring.x = 66;
	level.ring.y = 390;
	level.ring.color = (1,1,1);
	level.ring.alpha = 0;
	level.ring.bright = 0;
	level.ring.ping = 0;

	for(n=0; n<8; n++)
	{
		level.damagestate[n] = 0;
		level.currentstate[n] = -1;
		precacheShader(level.damageicon[n]);
	}

	for(n=0; n<level.icons.size; n++)
	{
//		println("precacheShader(",level.icons[n]["shader"],");");
		precacheShader(level.icons[n]["shader"]);
	}

	level waittill("finished intro screen");

	for(n=0; n<level.icons.size; n++)
	{
		level.display_icons[n] = newHudElem();
		level.display_icons[n] setShader(level.icons[n]["shader"],level.icons[n]["origin"][2],level.icons[n]["origin"][2]);
		level.display_icons[n].alignX = "center";
		level.display_icons[n].alignY = "middle";
		level.display_icons[n].x = ((level.icons[n]["origin"][0]-128)/2)+66;
		level.display_icons[n].y = ((level.icons[n]["origin"][1]-128)/2)+390;
		level.display_icons[n].color = (0,0,0);
		level.display_icons[n].alpha = 0;
		level.display_icons[n].bright = 0;
		level.display_icons[n].angle = 0;

		println("display_icons[",n,"] = ",level.icons[n]["shader"]);
	}
	
	level thread hud2();
}

lerp(a,b,percent)
{
	return((a[0] * (1.0 - percent)) + (b[0] * percent),
	       (a[1] * (1.0 - percent)) + (b[1] * percent),
	       (a[2] * (1.0 - percent)) + (b[2] * percent));
}

hud2()		//controls bomber damage map on screen
{	
	org_x = 66;
	org_y = 390;
	if (!isdefined(level.current_icon_objective))
	{	
		level.current_icon_objective = 4;
	}

	if (!isdefined(level.last_icon_objective))
	{
		level.last_icon_objective = 0;
	}

	level.fadedown = 1.0;
	level.display_icon = [];

	langle = (0,0,0);

	//while loop to continously update the damage icons
	while(1)
	{
		if (level.last_icon_objective!=level.current_icon_objective)
		{
			level.ring.ping = 5;
			level.last_icon_objective = level.current_icon_objective;
		}
		player = getent("player","classname");
		angle = player.angles[1];

		level.display_icons[8].bright = 1;	//	force the clock to full bright
		level.display_icons[8].angle = angle;

		if (getcvar("cg_hudcompassvisible")!="0")
			setcvar("cg_hudcompassvisible", "0");

		for(n=0; n<level.icons.size; n++)
		{
			if (n != level.current_icon_objective)
			{
				level.display_icons[n].color = (level.display_icons[n].bright,level.display_icons[n].bright,level.display_icons[n].bright);
				level.display_icons[n].alpha = level.display_icons[n].bright;
				if (level.display_icons[n].bright > 0)
				{
					level.display_icons[n].bright = level.display_icons[n].bright - 0.025;
				}
				else
					level.display_icons[n].bright = 0;
			}
			else
			{
				//	 oh the PAIN 

				tangle = (((level.icons[n]["origin"][0]-128)/2) , ((level.icons[n]["origin"][1]-128)/2) , 0);
				tlen = length(tangle);
				tangle = vectornormalize(tangle);
				tangle = vectortoangles(tangle);
//				println(" ",tangle);						
				tangle = (tangle[0] , tangle[1] + angle,tangle[2]);
				tangle = anglestoforward(tangle);
				tangle = maps\_utility_gmi::vectorMultiply(tangle,tlen);
//				println("-",tangle);						
				
				//	end of PAIN 

				level.display_icons[n].x = tangle[0] + 66;
				level.display_icons[n].y = tangle[1] + 390;

				level.ring.x = level.display_icons[n].x;
				level.ring.y = level.display_icons[n].y;
				level.display_icons[n].color = (1,1,1);
				level.display_icons[n].alpha = 1;
				level.display_icons[n].bright = 1;
			}
			if (level.ring.ping!=0)
			{
				scale = 16+((1.0-level.fadedown)*16.0);
				level.ring scaleovertime(0.05,scale,scale);
				level.ring.alpha = level.fadedown;
			}
			else
			{
				level.ring.alpha = 0;
			}
		}


		for(partnum=0; partnum<8; partnum++)
		{
			if(level.damagestate[partnum] > 2) continue;


/*	
			if(level.damagestate[partnum] == level.currentstate[partnum])
			{
				continue;
			}
*/
			level.currentstate[partnum] = level.damagestate[partnum];
	
			if(isdefined(level.display_icon[partnum]))
			{
				level.display_icon[partnum] destroy();
			}
	
			level.display_icon[partnum] = newHudElem();
			//println("made new hud element");

			level.display_icon[partnum].alignX = "center";
			level.display_icon[partnum].alignY = "middle";

			level.display_icon[partnum].x = org_x;
			level.display_icon[partnum].y = org_y;

//			thisicon = level.damageicon[partnum][level.currentstate[partnum]];
			thisicon = level.damageicon[partnum];

			blinky = 1.0;				//Ahh, those Brits and their crazy sense of humor...
			
			if (partnum == 2) 
				if (level.rwing_fire == true) 
					blinky = level.fadedown;

			if (partnum == 3) 
			{
				if (level.lwing_fire == true) 
					blinky = level.fadedown;
			}			
			switch(level.currentstate[partnum])
			{
				case	0:	level.display_icon[partnum].color = (0,blinky,0);
						break;
				case	1:	level.display_icon[partnum].color = (blinky,blinky,0);
						break;
				case	2:	level.display_icon[partnum].color = (blinky,0,0);
						break;
			}
			

			level.display_icon[partnum].angle = angle;
			level.display_icon[partnum].alpha = 0.75;
			level.display_icon[partnum] setShader(thisicon, 128, 128);
			
//			waitframe();	whats the point of this 
		}



	level.fadedown = level.fadedown - 0.05;
	if (level.fadedown < 0.0)
	{
		level.fadedown = 1;
		if (level.ring.ping!=0)
			level.ring.ping--;
	}

	waitframe();
	}
	level.last_icon_objective = -1;
}


friendly_killed_a_bf()
{
	while(1)
	{
		level waittill("bf died");

		randpct = randomfloat(1);
		if(randpct > 0.8)		//1 in 5
		{
			randdlg = randomint(3)+1;
	
			switch(randdlg)
			{
				case 1:
						if(level.dlp == false)
						{
							level.dlp = true;
							dialogue(113);
						}
						level.dlp = false;
						break;
	
				case 2:
						if(level.dlp == false)
						{
							level.dlp = true;
							dialogue(114);
						}
						level.dlp = false;
						break;
	
				case 3:
						if(level.dlp == false)
						{
							level.dlp = true;
							dialogue(115);
						}
						level.dlp = false;
						break;
			}
		}
	}
	wait 0.05;
}			


//*******************************************************
_debug(arg1, arg2)
{
	if (!isdefined(arg2))
	{
		println("^5*************** ");
		println("^5*************** ", arg1);
		println("^5*************** ");
	}
	else
	{
		println("^5*************** ");
		println("^4*************** ", arg1, " " , arg2);
		println("^5*************** ");
	}
}

_error(arg1,arg2)
{
	if (!isdefined(arg2))
	{
		println("^1*****************");
		println("^1ERROR ERROR ERROR ", arg1);
		println("^1*****************");
	}
	else
	{
		println("^1*****************");
		println("^3ERROR ERROR ERROR ", arg1, " " , arg2);
		println("^1*****************");
	}
}

_debugbf()		//enemy fighters 3d debug
{
	self endon ("death");

	while (1)
	{
	//	print3d(vec origin, string, vec rgb = (1, 1, 1), float a = 1, float scale = 1);
	//	Prints text inside the world at a given coordinate.
	//	·	print3d (friendly1.origin + (0,0,75), friendly1.health);
	//	·	print3d(self.origin, self.classname);

//		//this debugs the plane's path speed		
//		myspeedmph = self getspeedmph();
//	
//		switch (self.attackdirection)
//		{
//			case 12: mygoalspeed = level.speed_180; break;
//			case 3: mygoalspeed = level.speed_90; break;
//			case 6: mygoalspeed = level.speed_0; break;
//			case 9: mygoalspeed = level.speed_90; break;
//		}
//
//		print3d(self.origin + (0,0,100), self.plane_num, (0,0,1), 1, 4);
//		if (myspeedmph <= mygoalspeed)
//		{
//			print3d(self.origin, myspeedmph, (0,1,0), 1, 10);
//		}
//		else
//		{
//			print3d(self.origin, myspeedmph, (1,0,0), 1, 10);
//		}

	if(isdefined(self.mytarget))
	{
		print3d(self.origin, self.mytarget.targetname, (0,1,0), 1, 10);
	}
	else
	{
		print3d(self.origin, "NO TARGET", (1,0,0), 1, 10);
	}
	waitframe();
	}
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
how_many(attack_ev_num)
{
	while( 1 )
	{
		_debug("^5Total # of planes in attack: ",	level.num_planes_in_attack[attack_ev_num]);
		println("^5Planes ended: ",level.num_planes_ended[attack_ev_num]);
		println("^5AEN: ", attack_ev_num);
		wait 1;

		if(level.num_planes_ended[attack_ev_num] >= level.num_planes_in_attack[attack_ev_num])
		{
			return;
		}
	}
}

timer_utility()
{
	starttime = gettime();

	while(level.timer == true)
	{
		endtime = gettime();
	
		elapsedtime = endtime - starttime;
	
		println("Elapsed Time: ", elapsedtime);
	
		waitframe();
	}
}

//DIALOGUE CONTROLLER
dialogue(linenum)
{
	switch (linenum)
	{
		case 1:	//get in turret
			thisevent = "_a00_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_A00_01");
			break;
	
		case 2: //soon over coast
			thisevent = "_a00_01";
			thisspeaker = level.navigator;
			thisspeaker.speakername = level.navigator.animname;
//			iprintlnbold(&"GMI_BOMBER_NAVIGATOR_A00_01");
			break;

		case 3: //expecting more
			thisevent = "_a01_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_A01_01");
			break;
		
		case 4: // damn spoke too soon
			//thisevent = "_a02_01";

			thisevent = "cut";///////////////

			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_A02_01");
			break;

		case 5: //"B for Bertie" just took a hit she's out of control!
			thisevent = "_a02_01";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
//			iprintlnbold(&"GMI_BOMBER_COPILOT_A02_01");
			break;

		case 6: //come on...bail out
			thisevent = "_a02_01";
			thisspeaker = level.wirelessop;
			thisspeaker.speakername = level.wirelessop.animname;
//			iprintlnbold(&"GMI_BOMBER_WIRELESSOP_A02_01");
			break;

		case 7: // bloody hell
			thisevent = "_a02_02";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
//			iprintlnbold(&"GMI_BOMBER_COPILOT_A02_02");
			break;

		case 8: //look out for fighters
			thisevent = "_a02_02";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_A02_02");
			break;

		case 9: //coming over coast
			thisevent = "_b01_01";
			thisspeaker = level.navigator;
			thisspeaker.speakername = level.navigator.animname;
//			iprintlnbold(&"GMI_BOMBER_NAVIGATOR_B01_01");
			break;

		case 10: //coming up on target
			thisevent = "_b01_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_B01_01");
			break;

		case 11: //me's 11 o'clock high
			thisevent = "_b01_01";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
//			iprintlnbold(&"GMI_BOMBER_COPILOT_B01_01");
			break;

		case 12: //try not to hit spits
			thisevent = "_b01_02";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_B01_02");
			break;

		case 13: //more 109's at 10 o'clock
			thisevent = "_b01_03";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_B01_03");
			break;

		case 14: //they're on our six, they're...
			thisevent = "_b01_01";
			thisspeaker = level.tgunner;
			thisspeaker.speakername = level.tgunner.animname;
//			iprintlnbold(&"GMI_BOMBER_TGUNNER_B01_01");
			break;

		case 15: //good show doyle
			thisevent = "_b01_04";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_B01_04");
			break;

		case 16: //poor bastard
			//thisevent = "_b01_05";

			thisevent = "cut";///////////////

			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_B01_05");
			break;

		case 17: //another lot on our 6 o'clock
			thisevent = "_b01_02";
			thisspeaker = level.tgunner;
			thisspeaker.speakername = level.tgunner.animname;
//			iprintlnbold(&"GMI_BOMBER_TGUNNER_B01_02");
			break;

		case 18: //think they knew we're coming
			//thisevent = "_b01_02";

			thisevent = "cut";///////////////

			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
//			iprintlnbold(&"GMI_BOMBER_COPILOT_B01_02");
			break;

		case 19: //turret buggered
			thisevent = "_b01_06";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_B01_06");
			break;

		case 20: //harry's been hit
			thisevent = "_b01_01";
			thisspeaker = level.lwgunner;
			thisspeaker.speakername = level.lwgunner.animname;
//			iprintlnbold(&"GMI_BOMBER_LWGUNNER_B01_01");
			break;

		case 21: //man that waist gun
			thisevent = "_b01_07";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_B01_07");
			break;

		case 22: //this is bulldog leader
			thisevent = "_c01_01";
			thisspeaker = level.spits[1];
			thisspeaker.speakername = "spit";
//			iprintlnbold(&"GMI_BOMBER_SPIT1_C01_01");
			break;

		case 23: //this is a for andy
			thisevent = "_c01_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_C01_01");
			break;
	
		case 24: //this is as far as we can go
			thisevent = "_c01_02";
			thisspeaker = level.spits[1];
			thisspeaker.speakername = "spit";
//			iprintlnbold(&"GMI_BOMBER_SPIT1_C01_02");
			break;
	
		case 25: //roger
			thisevent = "_c01_02";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_C01_02");
			break;

		case 26: //grab the first aid kit
			thisevent = "_d01_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_D01_01");
			break;

		case 27: //hit pretty badly
			thisevent = "_d01_01";
			thisspeaker = level.wirelessop;
			thisspeaker.speakername = level.wirelessop.animname;
//			iprintlnbold(&"GMI_BOMBER_WIRELESSOP_D01_01");
			break;

		case 28: //get on left waist
			thisevent = "_d01_02";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_D01_02");
			break;

		case 29: //get on right waist gun
			thisevent = "_d01_03";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_D01_03");
			break;

		case 30: //fighters at 3 o'clock
			thisevent = "_d01_03";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_D01_04");
			break;

		case 31: //more 109s at 9 o'clock
			//thisevent = "_d01_05";

			thisevent = "cut";///////////////

			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_D01_05");
			break;
	
		case 32: //get on that tail gun
			thisevent = "_e01_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_E01_01");
			break;
	
		case 33: //bandits on our 6 o'clock
			thisevent = "_e01_02a";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_E01_02");
			break;

		case 34: //more bandits 6 o'clock
			thisevent = "_e02_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_E02_01");
			break;
	
		case 35: //fire in aft compartment
			thisevent = "_f01_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_F01_01");
			break;

		case 36: //fire in #1 engine
			thisevent = "_g01_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_G01_01");
			break;

		case 37: //fire in #2 engine
			thisevent = "_g01_02";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_G01_02");
			break;

		case 38: //fire in #3 engine
			thisevent = "_g01_03";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_G01_03");
			break;

		case 39: //fire in #4 engine
			thisevent = "_g01_04";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_G01_04");
			break;

		case 40: //can't shut off fuel
			thisevent = "_g02_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_G02_01");
			break;

		case 41: //lost another engine
			thisevent = "_g02_02";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_G02_02");
			break;

		case 42: //more bandits 3 o'clock
			//thisevent = "_g03_01";

			thisevent = "cut";///////////////

			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_G03_01");
			break;

		case 43: //this is madness
			thisevent = "_g04_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_G04_01");
			break;

		case 44: //come on hold together
			thisevent = "_h01_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_H01_01");
			break;

		case 45: //approaching target now
			thisevent = "_h01_01";
			thisspeaker = level.navigator;
			thisspeaker.speakername = level.navigator.animname;
//			iprintlnbold(&"GMI_BOMBER_NAVIGATOR_H01_01");
			break;

		case 46: //pilot to bombardier
			thisevent = "_h01_02";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_H01_02");
			break;

		case 47: //roger
			thisevent = "_h01_01";
			thisspeaker = level.bombardier;
			thisspeaker.speakername = level.bombardier.animname;
//			iprintlnbold(&"GMI_BOMBER_BOMB_H01_01");
			break;

		case 48: //pull arming pins
			thisevent = "_h01_03";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_H01_03");
			break;

		case 49: //bomb bay doors are jammed
			thisevent = "_h02_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_H02_01");
			break;

		case 50: //left, left steady...
			thisevent = "_h02_01";
			thisspeaker = level.bombardier;
			thisspeaker.speakername = level.bombardier.animname;
//			iprintlnbold(&"GMI_BOMBER_BOMB_H02_01");
			break;

		case 51: //we've been hit
			thisevent = "_h03_01";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_H03_01");
			break;
	
		//special cases for some reason...
		case 52: //bogies_at_3
			thisevent = "bogies_at_3";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
//			iprintlnbold(&"GMI_BOMBER_BOGIES_AT_3");
			break;

		case 53: //me_3
			thisevent = "me_3";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
//			iprintlnbold(&"GMI_BOMBER_ME_3");
			break;
		
		case 54: //fighters_on_6
			thisevent = "fighters_on_6";
			thisspeaker = level.rwgunner;
			thisspeaker.speakername = level.rwgunner.animname;
//			iprintlnbold(&"GMI_BOMBER_FIGHTERS_ON_6");
			break;
	
		case 55: //more_bandits_6
			thisevent = "more_bandits_6";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
//			iprintlnbold(&"GMI_BOMBER_MORE_BANDITS_6");
			break;
	
		case 56: //bandits_9
			thisevent = "bandits_9";
			thisspeaker = level.rwgunner;
			thisspeaker.speakername = level.rwgunner.animname;
//			iprintlnbold(&"GMI_BOMBER_BANDITS_9");
			break;

		case 57: //more_bandits_9
			thisevent = "more_bandits_9";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
//			iprintlnbold(&"GMI_BOMBER_MORE_BANDITS_9");
			break;

		case 58: //mess_12
			thisevent = "mess_12";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
//			iprintlnbold(&"GMI_BOMBER_MESS_12");
			break;

		case 59: //crimey
			thisevent = "crimey";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
//			iprintlnbold(&"GMI_BOMBER_CRIMEY");
			break;

		case 60: //doyle get in turret random lines
			thisevent = "_dorsal";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_DORSAL");
			break;

		case 61: //nearby flak hit random lines
			thisevent = "misc_flak";
			thisspeaker = level.player;
			thisspeaker.speakername = "";
//			iprintlnbold(&"GMI_BOMBER_MISC_FLAK");
			break;

		case 62: //friendly fire warning random lines
			thisevent = "_friendly";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_FRIENDLY");
			break;

		case 63: //one minute to target
			//thisevent = "_one_minute";

			thisevent = "cut";///////////////

			thisspeaker = level.navigator;
			thisspeaker.speakername = level.navigator.animname;
//			iprintlnbold(&"GMI_BOMBER_NAV_ONE_MINUTE");
			break;

		case 64: //doyle, you heard the pilot, get up to your post
			thisevent = "_dorsal";
			thisspeaker = level.lwgunner;
			thisspeaker.speakername = level.lwgunner.animname;
//			iprintlnbold(&"GMI_BOMBER_LWAIST_DORSAL");
			break;

		case 65: //understood
			thisevent = "_understood";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
//			iprintlnbold(&"GMI_BOMBER_PILOT_UNDERSTOOD");
			break;

		case 66: //Navigator what's our status
			thisevent = "_status";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 67: //Doyle, you'd better get up to the dorsal turret, you know how the Skipper gets
			thisevent = "_dorsal";
			thisspeaker = level.lwgunner;
			thisspeaker.speakername = level.lwgunner.animname;
			break;

		case 68: //Splendid, now that our dorsal has finally decided....
			thisevent = "_soundoff";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 69:  //Left waist, ok
			thisevent = "_ok";
			thisspeaker = level.lwgunner;
			thisspeaker.speakername = level.lwgunner.animname;
			break;

		case 70: //Right waist ready
			thisevent = "_ok";
			thisspeaker = level.rwgunner;
			thisspeaker.speakername = level.rwgunner.animname;
			break;

		case 71: //Ball turret...bloody uncomfortable
			thisevent = "_ok";
			thisspeaker = level.bt;
			thisspeaker.speakername = "ball";
			break;

		case 72: //Tail gunner...sounding off
			thisevent = "_ok";
			thisspeaker = level.tgunner;
			thisspeaker.speakername = "tail";
			break;

		case 73: //Radio track for Bertie
			thisevent = "_radio_panic";
			thisspeaker = level.player;
			thisspeaker.speakername = "bertie";
			break;

		case 74: //Angus is down!  We need somebody on the tail gun!
			thisevent = "_tail_dead";
			thisspeaker = level.rwgunner;
			thisspeaker.speakername = level.rwgunner.animname;
			break;

		case 75: //Doyle!  Get back there and take over the tail gun position!
			thisevent = "_goto_tail";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 76: //I think that's the last of them for now...
			thisevent = "_end_wave1";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 77: //Well there goes our fighter escort.  We're...
			thisevent = "_spits_gone";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 78: //Arrrgh
			//thisevent = "_death";

			thisevent = "cut";///////////////

			thisspeaker = level.wirelessop;
			thisspeaker.speakername = level.wirelessop.animname;
			break;

		case 79: //What the hell was that?  Are you ok Sparks?
			thisevent = "_radop_dead";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
			break;

		case 80: //They've hit another bomber, F for Freddie...she's going down
			thisevent = "_bomber_down";
			thisspeaker = level.bt;
			thisspeaker.speakername = "ball";
			break;

		case 81: //Bogeys at 12 o'clock!  Doyle we need you back...
			thisevent = "_goto_dorsal";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 82: //Come on you jerry bastard...just a little closer....
			thisevent = "_death";
			thisspeaker = level.lwgunner;
			thisspeaker.speakername = level.lwgunner.animname;
			break;

		case 83: //Right waist, right waist?  Are you ok?
			thisevent = "_lwaist_death";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;	
	
		case 84: //Ball turret, what's your status?
			thisevent = "_ball_status";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;
		
		case 85: //Doyle, use whatever guns you need!  Just keep those....
			thisevent = "_useguns_1";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 86: //6 o'clock! 6 o'clock!  Coming in fast!
			thisevent = "_fighters_6";
			thisspeaker = level.bt;
			thisspeaker.speakername = "ball";
			break;

		case 87: //Doye, get back on that tail gun! NOW!
			thisevent ="_tail_now";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 88: //Doyle, they're coming from everywhere!  Use whatever...
			thisevent = "_useguns_2";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 89: //Navigator, how much farther?
			thisevent = "_how_far";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 90: //Miscellanous "attaboy"s
			thisevent = "good_shot";
			thisspeaker = level.player;
			thisspeaker.speakername = "";
			break;

		case 91: //Direct hit! You sank my battleship!
			thisevent = "_direct_hit";
			thisspeaker = level.bombardier;
			thisspeaker.speakername = "bomb";
			break;

		case 92: //Cross-legged
			thisevent = "_blownoff";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
			break;

		case 93: //Hang on
			thisevent = "_hang_on";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 94: //You wanted more?
			thisevent = "_wanted_more";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
			break;

		case 95: //We have one aircraft down...
			thisevent = "_descending";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;
	
		case 96: //There she is...Holland
			thisevent = "_holland";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
			break;

		case 97: //Never been there...
			thisevent = "_dutchgirl";
			thisspeaker = level.bt;
			thisspeaker.speakername = "ball";
			break;

		case 98: //Aye, how was she?
			thisevent = "_aye";
			thisspeaker = level.tgunner;
			thisspeaker.speakername = "tail";
			break;

		case 99: //Sparks is dead, sir
			thisevent = "_sparks_dead";
			thisspeaker = level.lwgunner;
			thisspeaker.speakername = level.lwgunner.animname;
			break;

		case 100: //We've lost a good man
			thisevent = "_lost_good_man";
			thisspeaker = level.copilot;
			thisspeaker.speakername = level.copilot.animname;
			break;

		case 101: // e01_03
			thisevent = "_e01_03";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 102: //Danny's gone, skipper.
			thisevent = "_danny_gone";
			thisspeaker = level.rwgunner;
			thisspeaker.speakername = level.rwgunner.animname;
			break;
		
		case 103: //Carry on.  That boy was only 19 years old...
			thisevent = "_carryon";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 104: //Keep moving, Doyle, you can't help him
			thisevent = "_cant_help";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 105: //
			thisevent = "_blimey";
			thisspeaker = level.bt;
			thisspeaker.speakername = "ball";
			break;

		case 106: //They've sent the whole bloody Luftwaffe!
			thisevent = "_luftwaffe";
			thisspeaker = level.rwgunner;
			thisspeaker.speakername = level.rwgunner.animname;
			break;
		
		case 107: //Well, let's send em back!
			thisevent = "_send_back";
			thisspeaker = level.bt;
			thisspeaker.speakername = "ball";
			break;
		
		case 108: //Move it! Move!
			thisevent = "_move_it";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 109: //
			thisevent = "_goodshow";
			thisspeaker = level.pilot;
			thisspeaker.speakername = level.pilot.animname;
			break;

		case 110: //
			thisevent = "fire_away";
			thisspeaker = level.pilot;
			thisspeaker.speakername = "";
			break;
		
		case 111: //
			thisevent = "damn";
			thisspeaker = level.pilot;
			thisspeaker.speakername = "";
			break;

		case 112: //
			thisevent = "bloody_hell";
			thisspeaker = level.pilot;
			thisspeaker.speakername = "";
			break;
		
		case 113: //
			thisevent = "there_fritz";
			thisspeaker = level.pilot;
			thisspeaker.speakername = "";
			break;

		case 114: //
			thisevent = "got_him";
			thisspeaker = level.pilot;
			thisspeaker.speakername = "";
			break;

		case 115: //
			thisevent = "bloody_kraut";
			thisspeaker = level.pilot;
			thisspeaker.speakername = "";
			break;
	}

	if(thisevent == "cut") return;

	if( (linenum < 52) || (linenum > 59) )
	{

		thiswaitname = thisspeaker.speakername + thisevent;
		if(!isdefined(level.talk_wait[thiswaitname]))
		{
			println("level.talk_wait[thiswaitname] undefined for ", thisspeaker.speakername, thisevent);
		}
	
		//set up the event-specific animation flags
		level.anim_array = [];
		level.anim_array["copilot_b01_06"]	= true;
		level.anim_array["pilot_b01_06"]	= true;
	
		//does this character have an animation defined for this event
		//if he does play it, if not check the next step
		thatstr = thisspeaker.speakername;
		thisstr = thatstr + thisevent;
	
		if(isdefined(level.anim_array[thisstr])) 
		{
			//this character and event have a defined animation, so play them
			thisspeaker setflaggedanimknobrestart("animX done", level.scr_anim[thatstr][thisstr], 1, 1, 1 );
			if(thatstr == level.pilot.animname)
			{
				println("^3playsound method 1");
				level.dlp = 1;
				thisspeaker playsound(thisstr);
				level.dlp = 0;
			}
			thisspeaker waittill ("animX done");
			thisspeaker clearanim(level.scr_anim[thatstr][thisstr], 0.05 );
		}
		else
		{
//			//ok, so if this guy is the pilot
//			if( thisspeaker == level.pilot )
//			{
//				//play the talk in anim on him
//				level.pilot setflaggedanimknobrestart("talk in done", level.scr_anim["pilot"]["pilot_talk_in"],1,1,1);
//				level.pilot waittill ("talk in done");
//	
//				level.pilot setflaggedanimknobrestart("talk loop done", level.scr_anim["pilot"]["pilot_talk_loop"],1,1,1);
//				level.dlp = 1;
//				level.pilot playsound(thisstr);
//				thiswait = level.talk_wait[thiswaitname];
//				wait thiswait;
//				level.dlp = 0;
//	
//				level.pilot setflaggedanimknobrestart("talk out done", level.scr_anim["pilot"]["pilot_talk_out"],1,1,1);
//				level.pilot waittill ("talk out done");
//
//				level.pilot setflaggedanimknobrestart("idleA done", level.scr_anim["pilot"]["pilot_idleA"], 1, 0.5, 1 );
//				level.pilot waittill("idleA done");
//			}
//			else
//			{
				//This is where the majority of the VOs are played from...
				//Note that "level.dlp" tracks the wait timer for the dialogue line, to return when it's done
				//and also to prevent lines from "stepping on" one another (with any luck)
				thatstr = thisspeaker.speakername;
				thisstr = thatstr + thisevent;
				println("^3playsound method 2");
				thisspeaker playsound(thisstr);
	
	
				if(!isdefined(level.talk_wait[thiswaitname]))
				{
					println("level.talk_wait[thiswaitname] undefined for ", thisspeaker.speakername, thisevent);
				}
				else
				{
					level.dlp = 1;
					thiswait = level.talk_wait[thiswaitname];
					wait thiswait;
					level.dlp = 0;
				}
//			}
		}
	}
	else
	if ( (linenum >51) && (linenum < 60) )
	{
		println("^3playsound method 3");
		thisspeaker playsound(thisevent);
	}
	else
	{
		if(thisspeaker.speakername == "")
		{
			level.dlp = 1;
			println("^3playsound method 4");
			level.player playsound(thisevent);
			level.dlp = 0;

		}
		else
		{
			thatstr = thisspeaker.speakername;
			thisstr = thatstr + thisevent;
			println("^3playsound method 5");
			thisspeaker playsound(thisstr);
		}
	}
}

ff()
{
	if(level.allow_autosave == true) 
	{
		level.allow_autosave = false;
		local_no_autosave = true;
	}

	if(level.dlp == true)
	{
		wait 0.05;
	}

	level thread dialogue(62);

	wait 5;

	level.ff_warning = false;

	if(isdefined(local_no_autosave))
	{
		level.allow_autosave = true;
	}
}

ff_death()
{
	level thread dialogue(16);
}

comeflywithme()
{
	_debug("come fly with me");

	level thread fighter_attacks( 50, 0, 1 );					// Fake Att 1


	while(1)
	{
		level waittill("setspeed", ent);

		ent thread myfighterdied();

		level.player linkto(ent,"TAG_ORIGIN",(-50,0,10),(0,180,0), (1,1,1));

		cond = true;
		while(cond == true)
		{
			level waittill("setspeed_max", who);

			if(who==ent) cond = false;

			wait 0.05;
		}

		level.player unlink();
	}
}

myfighterdied()
{
	while(self.health > 0)
	{
		wait 0.05;
	}

	level notify("setspeed_max", self);
	level.player unlink();

	playerstart = getent("player_start", "targetname");
	level.player setorigin ( playerstart.origin , (0,0,0) );
}

cheat_teleport()
{
	cheat_tp = getent("cheat_teleport", "targetname");
	cheat_tp waittill ("trigger");
	playerstart = getent("player_start", "targetname");
	level.player setorigin ( playerstart.origin , (0,0,0) );

	level thread cheat_teleport();
}

//CHEEZ1 APPENDED
cheez1(numkills)
{
	if(level.total_num_kills < numkills)
	{
		//Get least damaged section
		testpart = 3;

		for(n=2;n<level.parts_array.size;n++)
		{
			if(level.parts_array[n].dmgstate < level.parts_array[testpart].dmgstate)
			{
				testpart = n;
			}
		}

		//Wings commented out because they are IN GOD MODE 
		switch(testpart)
		{
			//case 0:	//rwing_damage
				//thistarget = "target_rwing";
				//break;

			//case 1: //lwing_damage
				//thistarget = "target_lwing";
				//break;

			case 2:	//rwg_damage
				thistarget = "target_rwaist";
				break;

			case 3: //lwg_damage
				thistarget = "target_lwaist";
				break;

			case 4: //rtail_damage
				thistarget = "target_rtail";
				break;

			case 5:	//ltail_damage
				thistarget = "target_ltail";
				break;
		}			

		println("DAMAGE ",thistarget);

		org =(getent(thistarget, "targetname")).origin;

		//radiusDamage(level.player.origin, range, maxdamage, mindamage);
		radiusDamage (org, 50, 900, 900);

//		playfx(level._effect["flak_hit_int"], org );
	}
}


//CHEEZ2 APPENDED
cheez2(thischeez)
{
	//The Newest Addition to the Bomber Ride!!!
	//YOU MUST BE THIS TALL TO RIDE THIS ATTRACTION -----------------------------
	
	//function is threaded at the start of each fighter_attacks()
	
	//current_sample = each kill is added into this only for that sample, it's reset between waves
	
	//level variable tracks how much damage the planes do to the triggers
	
	//THESE VARIABLES ARE PRESET IN THE LEVEL SETUP
	//=============================================
	//This variable controls how much damage the enemy planes are doing to you when they hit
	//level.attack_multiplier = 1;
	//This variable controls the maximum damage multiplier for the increased difficulty planes
	//level.attack_multiplier_max = 3;
	//This variable controls how many seconds must elapse between checks
	//level.attack_multiplier_timer = 120;
	//This controls how many planes must die within a 2 minute period
	//level.num_planes_must_die = 5;
	
	//This gets redefined anyway, this is redundant
	current_sample = 0;

	//Controls the while loop		
	level.sample = true;

	println("^5Cheez2 is ENABLED! gogogo!");

	level thread cheez2_wait_for_attack_end(thischeez);
	
	while(level.sample)
	{
		start_sample = level.total_num_kills;
		println("^3start_sample = ", start_sample);

		//Wait 2 minutes
		println("^3waiting ",level.attack_multiplier_timer," seconds");
		wait (level.attack_multiplier_timer);
	
		//Tally kills during this period
		current_sample = level.total_num_kills - start_sample;
		println("^3current_sample = ",current_sample);
		println("^3num_planes_must_die = ",level.num_planes_must_die);
	
		//If # of kills does not exceed this level variable, ramp up the difficulty if it's not at max
		if(current_sample < level.num_planes_must_die)
		{
			if(level.attack_multiplier_max > level.attack_multiplier)
			{
				println("^1*****************ATTACK MULTIPLIER INCREASED!!!!*************************");
				println("^5Was ", level.attack_multiplier,"^5, is now ", (level.attack_multiplier+1));
				level.attack_multiplier++;
			}
			else
			{
				println("^3*****************ATTACK MULTIPLIER REMAINS AT ^1MAXIMUM^3***************************");
			}
		}
	
		//If # of kills exactly meets this level variable, leave the difficulty the same
		if(current_sample == level.num_planes_must_die)
		{
			println("^3****************ATTACK MULTIPLIER REMAINS THE SAME, GOAL MET BUT NOT EXCEEDED*********************");
		}
	
		//If # of kills DOES exceed this level variable, ramp DOWN the difficulty if it's not at min
		if(current_sample > level.num_planes_must_die)
		{
			if(level.attack_multiplier > 1)
			{
				println("^1*****************ATTACK MULTIPLIER DECREASED!!!!*************************");
				println("^5Was ", level.attack_multiplier,"^5, is now ", (level.attack_multiplier-1));
				level.attack_multiplier--;
			}
			else
			{
				println("^3*****************ATTACK MULTIPLIER REMAINS AT ^2MINIMUM^3***************************");
			}

		}
	}
}

cheez2_wait_for_attack_end(thischeez)
{
	level.attack_multiplier = 1;

	println("^5waiting for cheez"+thischeez+"_done");
	level waittill("cheez"+thischeez+"_done");
	println("^5cheez"+thischeez+"^5_done");
	println("^3********************ATTACK MULTIPLIER IS BEING RESET BETWEEN ATTACK WAVES***********************");

	//Stop the difficulty while loop
	level.sample = false;
}

//Jesse Added
fly_away_new()
{
	level.top_turret maketurretunusable();
	level.lwg_turret maketurretunusable();
	level.lwg_turret hideme();
	level.lwg_fake show();
	level.lwg_turret delete();
	level.use_lwg_turret delete();

	level.side = "none";
	
	//level thread Cam_Line(camera_path_org);
	//level thread player_angles(camera_path_org);	
	//level thread Cam_Line2(camera_path);
	
	level.lefttrig = getent("fly_right", "targetname");
	level.righttrig = getent("fly_left", "targetname");

	level thread lefttrig_wait();
	level thread righttrig_wait();

	level waittill ("fly_away");

	level notify("stop turbulence");

	println("^6FLY AWAY: ", level.side);

	level thread dialogue(51);

	level thread tail_blows_away();

	level.fireextinguisher_flash hideme();

	level notify("stop fx 88");
	level notify("stop fx 89");

	level.tg_turret hideme();

	level.tgunner setflaggedanimknobrestart("never", level.scr_anim["tail"]["tgunner_flying"], 1, 0, 1 );
	
	level.player freezecontrols(true);
	
	camera_path = spawn ("script_model",(level.player.origin));
	camera_path setmodel("xmodel/bomber_end_camera");
	camera_path hide();
	camera_path UseAnimTree(level.scr_animtree["bomber_end_camera"]);

	camera_path_org = spawn("script_origin",(level.player.origin));
	camera_path.angles = (0,180,0);
	camera_path_org linkTo(camera_path, "TAG_CAMERA", (0,0,-60),(0,0,0));
	
	level.player setplayerangles((camera_path_org.angles + (0,180,0))) ;
	level.player playerlinkto(camera_path_org,"",(1,1,1));
	
	camera_path setflaggedanimknobrestart("never", level.scr_anim["bomber_end_camera"]["plane_eject"], 1, 0, 1 );

	level.ambientsound = "ambient_bail_out";
	ambientPlay(level.ambientsound);
	
	level notify ("stop fx distant bombing");
		
	level.player playsound ("free_fall");
	
	camera_path thread notetrack_wait();
	
	level waittill ("deploy bitch");
	level.player playsound ("chute_deploy");
	
	parachute = spawn ("script_model",(camera_path_org.origin));
	parachute setmodel("xmodel/bomber_parachute");
	parachute UseAnimTree(level.scr_animtree["bomber_end_camera"]);
	parachute setflaggedanimknobrestart("never", level.scr_anim["parachute"]["parachute_deploy"], 1, 0, 1 );
	parachute thread parachute_idle();
	parachute linkTo(camera_path, "TAG_CHUTE", (0,0,0),(0,0,0));
	
	level waittill ("control given");
	level.player freezecontrols(false);

	wait 4;

	level thread player_mission_success();
}

notetrack_wait()
{
	while (1)
	{
		self waittill ("never", notetrack);
		if (isdefined(notetrack))
		{
			if (notetrack == "deploy_sound")
			{
				level notify ("deploy bitch");
			}
			if (notetrack == "free_control")
			{
				level notify ("control given");
			}
		}
	}
}

parachute_idle()
{
	self waittill ("never");
	while (1)
	{
		self setflaggedanimknobrestart("always", level.scr_anim["parachute"]["parachute_deployed"], 1, 0, 1 );
		self waittill ("always");
	}
}

Cam_Line(camera_path_org)
{
	while(1)
	{
		pos1 = camera_path_org.origin;
		tag_angles = camera_path_org.angles;
		forward = anglestoforward(tag_angles);
		pos2 = pos1 + maps\_utility_gmi::vectorScale(forward, 1000);
		line(pos1, pos2, (1,1,1));
		wait 0.06;
	}
}

Cam_Line2(camera_path_org)
{
	while(1)
	{
		org1 = camera_path_org.origin;
		org2 = camera_path_org gettagorigin("TAG_CAMERA"); 
		print3d (org1, "*", (1,0,0), 1, 3);
		print3d (org2, "*", (0,1,1), 1, 3);
		wait 0.06;
	}
}

player_angles(camera_path_org)
{
	time = 3000 + gettime();

	num = 360;
	while(1)
	{
		if(isdefined(camera_path_org))
		{
			println("^5level.player.angles = ",level.player.angles, " ^5level.cam_org.angles = ",camera_path_org.angles);
		}
		else
		{
			println("^5level.player.angles = ",level.player.angles);
		}
	
		wait 0.05;
	}
}


  ///////////////////////////
 // *** NEW UTILITIES *** //
///////////////////////////
hideme()
{
	//Only hide it once
	if(isdefined(self.hidden))
	{
		if(self.hidden == true) 
		{
			println("^1entity is already hidden!");
			return;
		}
	}

	self hide();
	self maps\_utility_gmi::triggeroff();
	self.hidden = true;
}

showme()
{
	//Only show it once
	if(isdefined(self.hidden))
	{
		if(self.hidden == false) 
		{
			println("^1entity is already showing!");
			return;
		}
	}
	
	self show();
	self maps\_utility_gmi::triggeron();
	self.hidden = false;
}