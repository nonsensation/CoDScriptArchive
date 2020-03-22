#using_animtree("generic_human");
main()
{
	Ender();
	Tank_Ambush();
	tank();
	TreeBursts();
	willyjeep_load_anims();
}

Ender()
{
// JEEP SECTION --------------//
	//ender Passenget Peugeot
	level.scr_anim["ender"]["peugeot_jumpin"]		= (%c_us_bastogne_passenger_climb);		//moody gets in the kubelwagon
	level.scr_anim["ender"]["peugeot_wait"]			= (%c_us_bastogne_passenger_wait);		//moody gets in the kubelwagon
	level.scr_anim["ender"]["peugeot_letsgo"]		= (%c_us_bastogne_passenger_letsgo);		//ender crash and get out

	// shot and wounded
	level.scr_anim["ender"]["peugeot_shot"] 		= (%c_us_bastogne_passenger_shot);		//ender gets shot
	level.scr_anim["ender"]["peugeot_wounda"]		= (%c_us_bastogne_passenger_woundedA);		//ender wounded and driving
	level.scr_anim["ender"]["peugeot_woundb"]		= (%c_us_bastogne_passenger_woundedB);		//ender wounded and stopped

	level.scr_anim["ender"]["peugeot_tree_crash"]		= (%c_us_bastogne_passenger_crash);		//ender wounded and stopped

	// attacking at events
	level.scr_anim["ender"]["peugeot_attack_event1"]	= (%c_us_bastogne_passenger_event1);		//ender wounded and stopped
	level.scr_anim["ender"]["peugeot_attack_event2"]	= (%c_us_bastogne_passenger_event2);		//ender wounded and stopped
	level.scr_anim["ender"]["peugeot_attack_event3in"]	= (%c_us_bastogne_passenger_event3_in);		//ender wounded and stopped
	level.scr_anim["ender"]["peugeot_attack_event3_loop"]	= (%c_us_bastogne_passenger_event3_loop);		//ender wounded and stopped

	level.scr_anim["ender"]["peugeot_attack_event4_in"]	= (%c_us_bastogne_passenger_event4_in);
	level.scr_anim["ender"]["peugeot_attack_event4_loop"]	= (%c_us_bastogne_passenger_event4_loop);
	level.scr_anim["ender"]["peugeot_attack_event4_out"]	= (%c_us_bastogne_passenger_event4_out);

	level.scr_anim["ender"]["peugeot_idle_calm"]		= (%c_us_bastogne_passenger_idlec);		//calm forward

	level.scr_anim["ender"]["peugeot_tree_hold"]		= (%c_us_bastogne_driver_hold);// moody hold
	level.scr_anim["ender"]["peugeot_tree_duck"]		= (%c_us_bastogne_driver_duck);// moody duck
 
	level.scr_anim["ender"]["peugeot_idle_idleA"]		= (%c_us_bastogne_passenger_idleA);	//1- aims to back over left shoulder
	level.scr_anim["ender"]["peugeot_idle_idleB"]		= (%c_us_bastogne_passenger_idleB);	//2 - aims to back over right shoulder
	level.scr_anim["ender"]["peugeot_idle_idleC"]		= (%c_us_bastogne_passenger_idleC);	//3 - points gun out window to his left

	level.scr_anim["ender"]["peugeot_idle_backleft"]	= (%c_us_bastogne_passenger_idleA);	//1- aims to back over left shoulder
	level.scr_anim["ender"]["peugeot_idle_backright"]	= (%c_us_bastogne_passenger_idleB);	//2 - aims to back over right shoulder
	level.scr_anim["ender"]["peugeot_idle_left"]		= (%c_us_bastogne_passenger_idleC);
	
	level.scr_anim["moody"]["peugeot_hardleft"]		= (%c_us_bastogne_driver_turnL);	//moody makes a hard left turn
	level.scr_anim["moody"]["peugeot_hardright"]		= (%c_us_bastogne_driver_turnR);	//moody makes a hard right turn
	level.scr_anim["moody"]["peugeot_idle"][0]		= (%c_us_bastogne_driver_idleA);	//moody driving animation A
	level.scr_anim["moody"]["peugeot_idle"][1]		= (%c_us_bastogne_driver_idleB);	//moody driving animation B
	level.scr_anim["moody"]["peugeot_idle"][2]		= (%c_us_bastogne_driver_idleC);	//moody driving animation C
	level.scr_anim["moody"]["peugeot_reverse_start"]	= (%c_us_bastogne_driver_back_in);	//moody start car in reverse
	level.scr_anim["moody"]["peugeot_reverse_loop"]		= (%c_us_bastogne_driver_back_loop);	//moody driving reverse
	level.scr_anim["moody"]["peugeot_reverse_forward"]	= (%c_us_bastogne_driver_back_out);	//moody puts car back into forward
	level.scr_anim["moody"]["peugeot_reverse_crash"]	= (%c_us_bastogne_driver_jump_off);	//moody crash and get out
	//level.scr_anim["moody"]["peugeot_reverse_crash"]	= (%peugeot_moody_reverse_crash);	//moody crash and get out
	//level.scr_anim["moody"]["peugeot_reverse_start"]	= (%peugeot_moody_reverse_start);	//moody start car in reverse
	//level.scr_anim["moody"]["peugeot_reverse_loop"]	= (%peugeot_moody_reverse_loop);	//moody driving reverse
	//level.scr_anim["moody"]["peugeot_reverse_forward"]	= (%peugeot_moody_reverse_forward);	//moody puts car back into forward
	
	

	level.scr_anim["moody"]["peugeot_wave"]			= (%c_us_bastogne_driver_wave);		//moody puts car back into forward
	level.scr_anim["moody"]["peugeot_wait"]			= (%c_us_bastogne_driver_wait);		//moody crash and get out
	level.scr_anim["moody"]["peugeot_tree_crash"]		= (%c_us_bastogne_driver_crash);	// moody tree crash
	level.scr_anim["moody"]["peugeot_wound_hold"]		= (%c_us_bastogne_driver_hold);		// moody hold
	level.scr_anim["moody"]["peugeot_tree_duck"]		= (%c_us_bastogne_driver_duck);		// moody duck
	
// END JEEP SECTION --------------//


	// Switch to Bazooka
	level.scr_anim["ender"]["force_reload"]			= (%reload_crouch_rifle);
	level.scr_anim["ender"]["reload_bazooka"]		= (%c_prj_bazooka_reload);
	
}

Tank_Ambush()
{
	level.scr_animtree["gun guy"] = #animtree;
	level.scr_animtree["grenade guy"] = #animtree;

	// Shooting into the tank
	level._effect["pistol"] = loadfx ("fx/muzzleflashes/standardflashworld.efx");

	level.scr_anim["gun guy"]["run"]			= (%tigertank_runup_gunguy);
	level.scr_anim["gun guy"]["idle"][0]		= (%tigertank_waitloop_gunguy);
	level.scr_anim["grenade guy"]["run"]		= (%tigertank_runup_grenadeguy);

	level.scr_anim["gun guy"]["attack"]			= (%tigertank_hatchopencloseandrun_gunguy);
	level.scr_anim["grenade guy"]["attack"]		= (%tigertank_hatchopencloseandrun_grenadeguy);
	level.scr_notetrack["gun guy"][0]["notetrack"]	= "fire";
	level.scr_notetrack["gun guy"][0]["effect"]		= "pistol";
	level.scr_notetrack["gun guy"][0]["sound"]		= "weap_thompson_fire";
	level.scr_notetrack["gun guy"][0]["selftag"]	= "tag_flash";

	level.scr_notetrack["grenade guy"][0]["notetrack"]		= "grenade attach";
	level.scr_notetrack["grenade guy"][0]["attach model"]	= "xmodel/weapon_MK2FragGrenade";
	level.scr_notetrack["grenade guy"][0]["selftag"]	= "tag_weapon_right";
	
	precacheModel("xmodel/weapon_mk2fraggrenade");  //head for script dieing models
	level.scr_notetrack["grenade guy"][1]["notetrack"]		= "grenade throw";
	level.scr_notetrack["grenade guy"][1]["detach model"]	= "xmodel/weapon_mk2fraggrenade";
	level.scr_notetrack["grenade guy"][1]["selftag"]	= "tag_weapon_right";
	
	level.scr_anim["ender"]["landing 1"]		= (%airborne_landing_firm);
	level.scr_anim["ender"]["landing 2"]		= (%airborne_landing_credits);
	level.scr_anim["ender"]["idle"]		= (%tigertank_waitloop_gunguy);
}

#using_animtree("panzerIV");
tank()
{
	level.scr_animtree["tank"] = #animtree;
	level.scr_anim["tank"]["attack"]			= (%tigertank_hatchopencloseandrun_hatch);
	level.scr_anim["tank"]["root"] = %root;
	// Dawnville_tank_hatch

	level.scr_notetrack["tank"][0]["notetrack"]	= "\"sound\"";
	level.scr_notetrack["tank"][0]["sound"]		= "dawnville_tank_hatch";
}

#using_animtree("tree_burst_anim");
TreeBursts()
{
	level.scr_animtree["treeburst"] 		= #animtree;
	level.scr_anim["treeburst"]["a_a"] 		=(%treeburst_winter_firhighbranch_a);
	level.scr_anim["treeburst"]["a_b"] 		=(%treeburst_winter_firhighbranch_b);
	level.scr_anim["treeburst"]["a_c"] 		=(%treeburst_winter_firhighbranch_c);
	level.scr_anim["treeburst"]["b_a"] 		=(%treeburst_winter_firhighbranch_b_a);
	level.scr_anim["treeburst"]["b_b"] 		=(%treeburst_winter_firhighbranch_b_b);
	level.scr_anim["treeburst"]["b_c"] 		=(%treeburst_winter_firhighbranch_b_c);
}

#using_animtree("willyjeep");
willyjeep_load_anims()
{
	level.scr_animtree["willyjeep"] = #animtree;
	//whillyjeep steering wheel to match Moodys driving anims
	//level.scr_anim["willyjeep"]["wheel_idle"][0]		= (%bastogne_jeep_idleA);
	level.scr_anim["willyjeep"]["wheel_idle"][0]		= (%bastogne_jeep_idleA);
	level.scr_anim["willyjeep"]["wheel_idle"][1]		= (%bastogne_jeep_idleB);
	level.scr_anim["willyjeep"]["wheel_idle"][2]		= (%bastogne_jeep_idleC);
	level.scr_anim["willyjeep"]["wheel_hardleft"]		= (%bastogne_jeep_turnL);
	level.scr_anim["willyjeep"]["wheel_hardright"]		= (%bastogne_jeep_turnR);
	level.scr_anim["willyjeep"]["idle_stopped"]		= (%bastogne_jeep_idle_stopped);

	//whillyjeep player anims
	level.scr_anim["willyjeep"]["player_bounce_normal"]	= (%peugeot_player_bounce_normal);
	level.scr_anim["willyjeep"]["player_bounce_strong"]	= (%peugeot_player_bounce_strong);

	level.scr_anim["willyjeep"]["reverse_start"]		= (%bastogne_jeep_back_in);
	level.scr_anim["willyjeep"]["reverse_loop"]		= (%bastogne_jeep_back_loop);
	level.scr_anim["willyjeep"]["reverse_forward"]		= (%bastogne_jeep_back_out);
	//level.scr_anim["willyjeep"]["reverse_crash"]		= (%peugeot_car_reverse_crash);
	level.scr_anim["willyjeep"]["tree_crash"]		= (%bastogne_jeep_crash);
	level.scr_anim["willyjeep"]["fishtail"]			= (%bastogne_jeep_fishtail);
}

#using_animtree("willyjeep");
willyjeep_anims(num)
{
	//level endon ("ExitVehicle");
	self UseAnimTree(#animtree);
	
	switch (num)
	{
		case 0: self setanimknobrestart(,level.scr_anim["willyjeep"]["wheel_idle"][num]);break;
		case 1: self setanimknobrestart(,level.scr_anim["willyjeep"]["wheel_idle"][num]);break;
		case 2: self setanimknobrestart(,level.scr_anim["willyjeep"]["wheel_idle"][num]);break;
		case 4: self setanimknobrestart(level.scr_anim["willyjeep"]["wheel_hardleft"]);break;
		case 5: self setanimknobrestart(level.scr_anim["willyjeep"]["wheel_hardright"]);break;
		case 6: self setanimknobrestart(level.scr_anim["willyjeep"]["reverse_start"]);break;
		case 7: self setanimknobrestart(level.scr_anim["willyjeep"]["reverse_loop"]);break;
		case 8: self setanimknobrestart(level.scr_anim["willyjeep"]["reverse_forward"]);break;
		case 9: self setanimknobrestart(level.scr_anim["willyjeep"]["reverse_crash"]);break;
		case 12: self setanimknobrestart(level.scr_anim["willyjeep"]["tree_crash"]);break;
		case 13: self setanimknobrestart(level.scr_anim["willyjeep"]["idle_stopped"]);break;
		case 14: self setanimknobrestart(level.scr_anim["willyjeep"]["fishtail"]);break;
	}
}

moody_drive_tree_crash()
{
	level.moodyanim = 19;
		level.jeep thread maps\bastogne1_anim::willyjeep_anims(12);
		
		//level thread maps\bastogne1_anim::play_rand_anim(6,undefined,undefined);	// convoy attack2

		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_tree_crash"]);
		//if ( (isdefined(sound)) && (sound == "yes") )
		level.jeep playsound ("stop_skid");
		
		level.moody waittillmatch ("animdone","end");
		//level.moodyanim = 0;
		
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_start"]);
		level.jeep thread maps\bastogne1_anim::willyjeep_anims(6);
		level.moody waittillmatch ("animdone","end");
		
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_loop"]);
		level.jeep thread maps\bastogne1_anim::willyjeep_anims(7);
		level.moody waittill ("animdone");
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_loop"]);
		level.jeep thread maps\bastogne1_anim::willyjeep_anims(7);
		level.moody waittill ("animdone");
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_loop"]);
		level.jeep thread maps\bastogne1_anim::willyjeep_anims(7);
		level.moody waittill ("animdone");
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_loop"]);
		level.jeep thread maps\bastogne1_anim::willyjeep_anims(7);
		level.moody waittill ("animdone");
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_loop"]);
		level.jeep thread maps\bastogne1_anim::willyjeep_anims(7);
		level.moody waittill ("animdone");
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_loop"]);
		level.jeep thread maps\bastogne1_anim::willyjeep_anims(7);
		level.moody waittill ("animdone");
		
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_forward"]);
		level.jeep thread maps\bastogne1_anim::willyjeep_anims(8);
		level.moody waittill("animdone");
		
		level.moodyanim = 0;
		//thread moody_drive_idle();
}