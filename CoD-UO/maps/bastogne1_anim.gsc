#using_animtree("generic_human");
main()
{
	maps\bastogne1_anim::map_table_anim();
	maps\bastogne1_anim::Drone_Paths();
	maps\bastogne1_anim::axis_drones();
	maps\bastogne1_anim::mortar_drones();
	
	level.scrsound["moody"]["Stick_with_me"]			= "Moody_ev01_00a";	
	
	//Map reading in barn
	level.scr_anim["medic1"]["nurse_in"]		= (%c_us_bastogne_medic_nursing_in);
	level.scr_anim["medic1"]["nurse"][0]		= (%c_us_bastogne_medic_nursing);

	//Map reading in barn
	level.scr_anim["officer1"]["map_read1"][0]		= (%c_us_bastogne_readmap_guy1);
	level.scr_anim["officer2"]["map_read2"][0]		= (%c_us_bastogne_readmap_guy2);
 	
 	//Moody intro
	level.scr_face["moody"]["moody_intro"]			= (%f_bastogne1_moody_intro);
 	level.scrsound["moody"]["moody_intro"]			= "moody_intro";
 	level.scr_anim["moody"]["moody_intro_anim"]		= (%c_us_bastogne1_moody_intro);
 	
 	//Ender intro
	level.scr_face["ender"]["ender_skip_patrol"]		= (%f_bastogne1_ender_skip_patrol);
 	level.scrsound["ender"]["ender_skip_patrol"]		= "ender_skip_patrol";
 	level.scr_anim["ender"]["ender_intro_anim"]		= (%c_us_bastogne1_ender_intro);
 	
 	//Moody done sweep
	level.scr_face["moody"]["moody_done_sweep"]		= (%f_bastogne1_moody_done_sweep);
 	level.scrsound["moody"]["moody_done_sweep"]		= "moody_done_sweep";
 	level.scr_anim["moody"]["moody_intro_idle"]		= (%c_us_bastogne1_moody_intro_idle);
 	level.scr_anim["moody"]["moody_jumpin"]			= (%c_us_bastogne_driver_jump_in);		//ender crash and get out

 	//ender kraut patrol
	level.scr_face["ender"]["ender_kraut_patrol"]		= (%f_bastogne1_ender_kraut_patrol);
 	level.scrsound["ender"]["ender_kraut_patrol"]		= "ender_kraut_patrol";
 	
 	//ender hear that
	level.scr_face["ender"]["ender_hear_that"]		= (%f_bastogne1_ender_hear_that);
 	level.scrsound["ender"]["ender_hear_that"]		= "ender_hear_that";
 	
 	//ender cmon
	level.scr_face["ender"]["ender_cmon"]			= (%f_bastogne1_ender_cmon);
 	level.scrsound["ender"]["ender_cmon"]			= "ender_cmon";
 	
 	//Ender go
	level.scr_face["ender"]["ender_go"]			= (%f_bastogne1_ender_go);
 	level.scrsound["ender"]["ender_go"]			= "ender_go";
 	
 	//ender mandown
	level.scr_face["ender"]["ender_mandown"]		= (%f_bastogne1_ender_mandown);
 	level.scrsound["ender"]["ender_mandown"]		= "ender_mandown";
 	
	//Moody get into jeep
	level.scr_face["moody"]["moody_go"]			= (%f_bastogne1_moody_go);
 	level.scrsound["moody"]["moody_go"]			= "moody_go";

	//ender joey
	level.scr_face["ender"]["ender_joey"]			= (%f_bastogne1_ender_joey);
 	level.scrsound["ender"]["ender_joey"]			= "ender_joey";

	//Moody use 50
	level.scr_face["moody"]["moody_use_50"]			= (%f_bastogne1_moody_50cal);
 	level.scrsound["moody"]["moody_use_50"]			= "moody_50cal";

	//ender joey
	level.scr_face["ender"]["ender_ohman"]			= (%f_bastogne1_ender_ohman);
 	level.scrsound["ender"]["ender_ohman"]			= "ender_ohman";

	//Moody watch out
	level.scr_face["moody"]["moody_backto_hq"]		= (%f_bastogne1_moody_backto_hq);
 	level.scrsound["moody"]["moody_backto_hq"]		= "moody_backto_hq";
 	
	//Moody watch out
	level.scr_face["moody"]["moody_watch_out"]		= (%f_bastogne1_moody_watchout);
 	level.scrsound["moody"]["moody_watch_out"]		= "moody_watchout";

	//Moody watch it
	level.scr_face["moody"]["moody_watchit"]		= (%f_bastogne1_moody_watchit);
 	level.scrsound["moody"]["moody_watchit"]		= "moody_watchit";
 	
 	//Moody eyes open
	level.scr_face["moody"]["moody_eyesopen"]		= (%f_bastogne1_moody_eyesopen);
 	level.scrsound["moody"]["moody_eyesopen"]		= "moody_eyesopen";
 	
 	//Moody to the right
	level.scr_face["moody"]["moody_totheright"]		= (%f_bastogne1_moody_totheright);
 	level.scrsound["moody"]["moody_totheright"]		= "moody_totheright";
 	
 	//Moody dead ahead
	level.scr_face["moody"]["moody_deadahead"]		= (%f_bastogne1_moody_deadahead);
 	level.scrsound["moody"]["moody_deadahead"]		= "moody_deadahead";

 	//Moody pass right
	level.scr_face["ender"]["ender_passright"]		= (%f_bastogne1_ender_passright);
 	level.scrsound["ender"]["ender_passright"]		= "ender_passright";
 	
 	//Moody stop yakin
	level.scr_face["moody"]["moody_stopyackin"]		= (%f_bastogne1_moody_stopyackin);
 	level.scrsound["moody"]["moody_stopyackin"]		= "moody_stopyackin";
 	
 	 //Moody pass right
	level.scr_face["ender"]["ender_dontlikethis"]		= (%f_bastogne1_ender_dontlikethis);
 	level.scrsound["ender"]["ender_dontlikethis"]		= "ender_dontlikethis";
 	
 	//Moody whats to like
	level.scr_face["moody"]["moody_whatstolike"]		= (%f_bastogne1_moody_whatstolike);
 	level.scrsound["moody"]["moody_whatstolike"]		= "moody_whatstolike";
 	
 	//Moody to left
	level.scr_face["moody"]["moody_totheleft"]		= (%f_bastogne1_moody_totheleft);
 	level.scrsound["moody"]["moody_totheleft"]		= "moody_totheleft";
 	 	
	//Moody engine stall
	level.scr_face["moody"]["moody_stalled"]		= (%f_bastogne1_moody_stalled);
 	level.scrsound["moody"]["moody_stalled"]		= "moody_stalled";

 	 //Moody pass right
	level.scr_face["ender"]["ender_offtoright"]		= (%f_bastogne1_ender_offtoright);
 	level.scrsound["ender"]["ender_offtoright"]		= "ender_offtoright";

	//Moody almost
	level.scr_face["moody"]["moody_almost"]			= (%f_bastogne1_moody_almost);
 	level.scrsound["moody"]["moody_almost"]			= "moody_almost";

 	 //Moody pass right
	level.scr_face["ender"]["ender_hitit"]			= (%f_bastogne1_ender_hitit);
 	level.scrsound["ender"]["ender_hitit"]			= "ender_hitit";

	//Moody shortcut
	level.scr_face["moody"]["moody_shortcut"]		= (%f_bastogne1_moody_shortcut);
 	level.scrsound["moody"]["moody_shortcut"]		= "moody_shortcut";

	//Moody shortcut
	level.scr_face["ender"]["ender_shortcut2"]		= (%f_bastogne1_moody_shortcut2);
 	level.scrsound["ender"]["ender_shortcut2"]		= "moody_shortcut2";

	//Moody heregoes
	level.scr_face["moody"]["moody_heregoes"]		= (%f_bastogne1_moody_heregoes);
 	level.scrsound["moody"]["moody_heregoes"]		= "moody_heregoes";

	//Moody heregoes
	level.scr_face["moody"]["moody_wherehit"]		= (%f_bastogne1_moody_wherehit);
 	level.scrsound["moody"]["moody_wherehit"]		= "moody_wherehit";

 	 //Moody pass right
	level.scr_face["ender"]["ender_watchout"]		= (%f_bastogne1_ender_watchout);
 	level.scrsound["ender"]["ender_watchout"]		= "ender_watchout";

	//Moody heregoes
	level.scr_face["moody"]["moody_wherehit2"]		= (%f_bastogne1_moody_wherehit2);
 	level.scrsound["moody"]["moody_wherehit2"]		= "moody_wherehit2";

	//Moody heregoes
	level.scr_face["moody"]["moody_oh_baby"]		= (%f_bastogne1_moody_oh_baby);
 	level.scrsound["moody"]["moody_oh_baby"]		= "moody_oh_baby";

	//Moody heregoes
	level.scr_face["moody"]["moody_clear"]			= (%f_bastogne1_moody_clear);
 	level.scrsound["moody"]["moody_clear"]			= "moody_clear";

	//Moody heregoes
	level.scr_face["moody"]["moody_medic"]			= (%f_bastogne1_moody_medic);
 	level.scrsound["moody"]["moody_medic"]			= "moody_medic";

	//Moody & Foley dialog in barn
	level.scr_anim["moody"]["moody_report_anim"]			= (%c_us_bastogne1_moody_barn_report);
	level.scr_face["moody"]["moody_report"]			= (%f_bastogne1_moody_report);
 	level.scrsound["moody"]["moody_report"]			= "moody_report";
 	
 	level.scr_anim["foley"]["foley_foxhole_anim"]		= (%c_us_bastogne1_foley_barn_report);
 	level.scr_face["foley"]["foley_foxhole"]		= (%f_bastogne1_foley_foxhole);
 	level.scrsound["foley"]["foley_foxhole"]		= "foley_foxhole";
 	level.scr_anim["foley"]["foley_foxhole_idle"]		= (%c_us_bastogne1_foley_idle);
 	
 	level.scr_anim["moody"]["nurse_in"]			= (%c_us_bastogne_medic_nursing_in);
 	level.scr_face["moody"]["moody_30cal"]			= (%f_bastogne1_moody_30cal);
 	level.scrsound["moody"]["moody_30cal"]			= "moody_30cal";
 	level.scr_anim["moody"]["moody_30cal_idle"]		= (%c_us_bastogne1_moody_idle);
	
 	// Anderson is all like... lets go biatch.
 	level.scr_face["anderson"]["anderson_riley"]		= (%f_bastogne1_anderson_riley);
 	level.scrsound["anderson"]["anderson_riley"]		= "anderson_riley";
 	
 	 // Anderson is all like... lets go biatch.
 	level.scr_face["medic1"]["medic_youre_ok"]		= (%f_bastogne1_medic_youre_ok);
 	level.scrsound["medic1"]["medic_youre_ok"]		= "medic_youre_ok";
 	
 	// Moody yells at you during first battle... this should randomize between 8 sayings.
	level.scr_face["moody"]["moody_keepfiring"]		= (%f_bastogne1_moody_keepfiring01);
 	level.scrsound["moody"]["moody_keepfiring"]		= "moody_keepfiring";
 	
 	// left flank
 	level.scr_face["moody"]["moody_withme"]			= (%f_bastogne1_moody_withme);
 	level.scrsound["moody"]["moody_withme"]			= "moody_withme";
 	
 	 // center
 	level.scr_face["moody"]["moody_changin"]		= (%f_bastogne1_moody_changin);
 	level.scrsound["moody"]["moody_changin"]		= "moody_changin";
 	
 	// pop smoke
 	level.scr_face["moody"]["moody_pop_smoke"]		= (%f_bastogne1_moody_pop_smoke);
 	level.scrsound["moody"]["moody_pop_smoke"]		= "moody_pop_smoke";

 	// pop smoke
 	level.scr_face["moody"]["moody_slow_down"]		= (%f_bastogne1_moody_slow_down);
 	level.scrsound["moody"]["moody_slow_down"]		= "moody_slow_down";

 	// pop smoke
 	level.scr_face["moody"]["moody_rightflank"]		= (%f_bastogne1_moody_rightflank);
 	level.scrsound["moody"]["moody_rightflank"]		= "moody_rightflank";
 	
 	 // pop smoke
 	level.scr_face["moody"]["moody_line_collapsed"]		= (%f_bastogne1_moody_line_collapsed);
 	level.scrsound["moody"]["moody_line_collapsed"]		= "moody_line_collapsed";
 	
 	// pop smoke
 	level.scr_face["moody"]["moody_tanks"]			= (%f_bastogne1_moody_tanks);
 	level.scrsound["moody"]["moody_tanks"]			= "moody_tanks";
 	
 	// pop smoke
 	level.scr_face["moody"]["moody_bazooka"]		= (%f_bastogne1_moody_bazooka);
 	level.scrsound["moody"]["moody_bazooka"]		= "moody_bazooka";
 	
 	// pop smoke
 	level.scr_face["moody"]["moody_another_panzer"]		= (%f_bastogne1_moody_another_panzer);
 	level.scrsound["moody"]["moody_another_panzer"]		= "moody_another_panzer";
 	
 	// pop smoke
 	level.scr_face["moody"]["moody_oh_god"]			= (%f_bastogne1_moody_oh_god);
 	level.scrsound["moody"]["moody_oh_god"]			= "moody_oh_god";
 	
 	// Random guy hears the incoming Shermans.
	level.scr_face["anonymous"]["trooper_ours"]		= (%f_bastogne1_trooper_ours);
 	level.scrsound["anonymous"]["trooper_ours"]		= "trooper_ours";
 	
 	// pop smoke
 	level.scr_face["anonymous"]["trooper_alright"]		= (%f_bastogne1_trooper_alright);
 	level.scrsound["anonymous"]["trooper_alright"]		= "trooper_alright";
 	
 	// pop smoke
 	level.scr_face["moody"]["moody_tincans"]		= (%f_bastogne1_moody_tincans);
 	level.scrsound["moody"]["moody_tincans"]		= "moody_tincans";
 	
	//Moody heregoes
	level.scr_anim["moody"]["moody_throw"]			= (%stand_grenade_throw);
	
	// Fox hole animations
 	level.scr_anim["foxhole_pointer"]["pointing"][0]			= (%c_us_bastogne_pointing1_loop);
 	level.scr_anim["foxhole_cower1"]["cower1"][0]				= (%c_us_bastogne_cower_a_foxhole_loop);
 	level.scr_anim["foxhole_cower2"]["cower2"][0]				= (%c_us_bastogne_cower_b_foxhole_loop);
	level.scr_anim["foxhole_30cal"]["setup30cal"][0]			= (%c_us_bastogne_setup30cal_foxhole);
	level.scr_anim["foxhole_pointer"]["pointer_death"]			= (%death_explosion_right13);
	level.scr_anim["foxhole_pointer_friend"]["pointer_friend_death"]	= (%death_explosion_back13);
	level.scr_anim["foxhole_pointer"]["pointer_death_idle"]			= (%c_dead_explosion_right13);
	level.scr_anim["foxhole_pointer_friend"]["pointer_friend_death_idle"]	= (%c_dead_explosion_back13);
	// Wall flowers
 	level.scr_anim["wallflower_1"]["stand_idle"]    [0]	= (%c_waiting_stand_idle);
 	level.scr_anim["wallflower_1"]["stand_scratch"]		= (%c_waiting_stand_scratch);
 	level.scr_anim["wallflower_1"]["stand_flinchb"]		= (%c_waiting_stand_flinchB);
 	level.scr_anim["wallflower_1"]["stand_flincha"]		= (%c_waiting_stand_flinchA);
 	level.scr_anim["wallflower_2"]["wall_idle"]     [0]	= (%c_waiting_wall_idle);
 	level.scr_anim["wallflower_2"]["wall_dustoff"]		= (%c_waiting_wall_dustoff);
 	level.scr_anim["wallflower_2"]["wall_inspect"]		= (%c_waiting_wall_inspectgun);
 	level.scr_anim["wallflower_2"]["wall_flinchb"]		= (%c_waiting_wall_flinchB);
 	level.scr_anim["wallflower_2"]["wall_flincha"]		= (%c_waiting_wall_flinchA);
				
	// Anderson waving
	level.scr_anim["anderson"]["comeon_c"]			= (%c_us_bastogne_come_on_C); 
	level.scr_anim["anderson"]["comeon_d"]			= (%c_us_bastogne_come_on_D); 
	level.scr_anim["anderson"]["comeon_idle"][0]		= (%c_us_bastogne_anderson_idle);  
	
//moody_go
	//level.scr_face["moody"]["moody_go"]			= (%f_bastogne1_f_bastogne1_moody_go);

//moody_50cal
	level.scr_face["moody"]["moody_50cal"]			= (%f_bastogne1_moody_50cal);

// pak 43 sequence
// leaner1
	level.scr_anim["leaner1"]["lean_loop"][0]		= (%c_ge_bastogne_leaning1_loop);
	level.scr_anim["leaner1"]["lean_end"]			= (%c_ge_bastogne_leaning1_surprised);

	level.scr_face["leaner1"]["lean_end"]			= (%PegDay_facial_Friend1_01_incoming);

// - Guy lifting #1: 
	level.scr_anim["lifter1"]["guy1_lift_loop"][0]		= (%c_ge_bastogne_lifting1_loop);
	level.scr_anim["lifter1"]["guy1_lift_end"]		= (%c_ge_bastogne_lifting1_surprised);

//- Guy lifting #2: 
	level.scr_anim["lifter2"]["guy2_lift_loop"][0]		= (%c_ge_bastogne_lifting2_loop);
	level.scr_anim["lifter2"]["guy2_lift_end"]		= (%c_ge_bastogne_lifting2_surprised);

//- Guy bed #1:
	level.scr_anim["bed1"]["guy1_bed_loop"][0]		= (%c_ge_bastogne_bed1_loop);
	level.scr_anim["bed1"]["guy1_bed_end"]			= (%c_ge_bastogne_bed1_surprised);

//- Guy waiting #1:
	level.scr_anim["waiting1"]["guy2_wait_loop"][0]		= (%c_ge_bastogne_waiting1_loop);
	level.scr_anim["waiting1"]["guy2_wait_end"]		= (%c_ge_bastogne_waiting1_surprised);

// - Guy with crate #1:
	level.scr_anim["crate1"]["guy2_crate2_loop"][0]		=(%c_ge_bastogne_crate1_loop);  
	level.scr_anim["crate1"]["guy2_crate2_beg"][0]		=(%c_ge_bastogne_crate1_beginning); // lift crate

// guys pushing cars from kursk one used for truck in bastogne
	level.scr_anim["kubelwagonpush"]["pusherleft_loop"][0]	= (%kursk_wagonpush_pusherleft_loop);
	level.scr_anim["kubelwagonpush"]["pusherright_loop"][0]	= (%kursk_wagonpush_pusherright_loop);

// officer loop
	level.scr_anim["officer1"]["officer_loop"][0]		= (%line_officer_stand_idle);

// officer gogogo
	level.scr_anim["officer1"]["mp40_gogogo"][0]		= (%wave_mp40guy_gogo);
	
	//Moody Drive Peugeot
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
			
//-----------------------------------------------------------------------------------------------------
	
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
	level.scr_anim["ender"]["peugeot_attack_event3out"]	= (%c_us_bastogne_passenger_event3_out);		//ender wounded and stopped


	level.scr_anim["ender"]["peugeot_attack_event4_in"]	= (%c_us_bastogne_passenger_event4_in);
	level.scr_anim["ender"]["peugeot_attack_event4_loop"]	= (%c_us_bastogne_passenger_event4_loop);
	level.scr_anim["ender"]["peugeot_attack_event4_out"]	= (%c_us_bastogne_passenger_event4_out);

	level.scr_anim["ender"]["peugeot_idle_calm"]		= (%c_us_bastogne_passenger_idlec);		//calm forward

	level.scr_anim["ender"]["peugeot_tree_hold"]		= (%c_us_bastogne_driver_hold);// moody hold
	level.scr_anim["ender"]["peugeot_tree_duck"]		= (%c_us_bastogne_driver_duck);// moody duck
 
	level.scr_anim["ender"]["peugeot_idle"][0]		= (%c_us_bastogne_passenger_idleA);	//1- aims to back over left shoulder
	level.scr_anim["ender"]["peugeot_idle"][1]		= (%c_us_bastogne_passenger_idleB);	//2 - aims to back over right shoulder
	level.scr_anim["ender"]["peugeot_idle"][2]		= (%c_us_bastogne_passenger_idleC);	//3 - points gun out window to his left

	level.scr_anim["ender"]["peugeot_idle_backleft"]	= (%c_us_bastogne_passenger_idleA);	//1- aims to back over left shoulder
	level.scr_anim["ender"]["peugeot_idle_backright"]	= (%c_us_bastogne_passenger_idleB);	//2 - aims to back over right shoulder
	level.scr_anim["ender"]["peugeot_idle_left"]		= (%c_us_bastogne_passenger_idleC);	//3 - points gun out window to his left
	
	//level.scr_anim["ender"]["peugeot_idle_calm"]		= (%c_us_bastogne_passenger_idlec);		//calm forward
	
	level.scr_anim["passenger"]["passenger_jumpin"]		= (%c_us_bastogne_passenger_climb);		//moody gets in the kubelwagon
	level.scr_anim["passenger"]["passenger_idle"]		= (%c_us_bastogne_passenger_wait);		//moody gets in the kubelwagon
	level.scr_anim["passenger"]["passenger_death"]		= (%death_explosion_right13);
	level.scr_anim["gunner"]["gunner_jumpin"]		= (%c_us_bastogne_gunner_jump_in);		//moody gets in the kubelwagon
	level.scr_anim["gunner"]["gunner_idle"]			= (%c_us_bastogne_gunner_idle);		//moody gets in the kubelwagon
	level.scr_anim["gunner"]["gunner_death"]		= (%death_explosion_back13);	
	level.scr_anim["driver"]["driver_jumpin"]		= (%c_us_bastogne_driver_jump_in);		//ender crash and get out
	level.scr_anim["driver"]["driver_idle"]			= (%c_us_bastogne_driver_wait);		//ender crash and get out
	level.scr_anim["driver"]["driver_death"]		= (%death_explosion_left11);
	
	level.scr_anim["goldberg"]["gold_death"]		= (%death_explosion_back13);
	
	
	level.scr_anim["cheerguy"]["stand_cheer"]		= (%c_cheering_stand2cheer);
	
	level.scr_anim["cheerguy"]["cheer"][0]			= (%c_cheering_A);
	level.scr_anim["cheerguy"]["cheer"][1]			= (%c_cheering_B);
	level.scr_anim["cheerguy"]["cheer"][2]			= (%c_cheering_C);
	level.scr_anim["cheerguy"]["cheer"][3]			= (%c_cheering_D);
	level.scr_anim["cheerguy"]["cheer"][4]			= (%c_cheering_E);
	level.scr_anim["cheerguy"]["cheer"][5]			= (%c_cheering_throwing); 
	level.scr_anim["cheerguy"]["cheer"][6]			= (%c_cheering_idle); 
	level.scr_anim["cheerguy"]["cheer"][7]			= (%c_cheering_idle);
	level.scr_anim["cheerguy"]["cheer"][8]			= (%c_cheering_idle);
	    
	level.scr_anim["cheerguy"]["cheer_throw_loop"]		= (%c_cheering_throwing_loop);
	level.scr_anim["cheerguy"]["cheer_throw_end"]		= (%c_cheering_throwing_end);  
	
	level.scr_anim["moody"]["kubel_crash"]			= %c_us_bastogne_driver_kubel_crash;
	level.scr_anim["ender"]["kubel_crash"]			= %c_us_bastogne_passenger_kubel_crash;  
	
	level.scr_anim["moody"]["moody_30cal_move"]		= %c_us_bastogne1_moody_30cal_move;
	level.scrsound["moody"]["moody_30cal_move"]		= "moody_30cal_move";
	level.scr_face["moody"]["moody_30cal_move"]		= %f_bastogne1_moody_30cal_move;
	level.scr_anim["moody"]["moody_slow_down"]		= %c_us_bastogne1_moody_slow_down;
	level.scr_anim["moody"]["moody_rightflank"]		= %c_us_bastogne1_moody_rightflank;
	
	level.scr_anim["ender"]["ender_speak"]			= %c_us_bastogne1_ender_backto_hq; 
	level.scr_anim["moody"]["moody_speak"]			= %c_us_bastogne1_moody_backto_hq; 
	
	level.scr_anim["ender"]["ender_speakshort"]		= %c_us_bastogne1_ender_short_talk;
	level.scr_anim["moody"]["moody_speakshort"]		= %c_us_bastogne1_moody_short_talk;
	
	level.scr_anim["moody"]["moody_climbin"]		= %c_us_bastogne_moody_climbin;
}	

mortar_drones()
{
	level.scr_character["drone_mortar_team"][0] 				= character\Airborne2b_bar_snow::main;
	level.scr_character["drone_mortar_team"][1] 				= character\Airborne2b_carbine_snow::main;
	level.scr_character["drone_mortar_team"][2] 				= character\Airborne2b_garand_snow::main;
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

#using_animtree("willyjeep");
willyjeep_bumpy()
{
	level endon ("ExitVehicle");
	self UseAnimTree(#animtree);
	while (level.flags["bumpy"] == true)
	{
		speed = self getspeedmph();
		if(speed >= 40)
		{
			self setflaggedanimknob("bouncedone",level.scr_anim["willyjeep"]["player_bounce_strong"]);
			self waittillmatch ("bouncedone","end");
		}
		else if(speed >= 10)
		{
			self setflaggedanimknob("bouncedone",level.scr_anim["willyjeep"]["player_bounce_normal"]);
			self waittillmatch ("bouncedone","end");
		}
		else
		{
			wait 1.5;
		}
	}
}

moody_drive_setup()
{
	level.moody linkto(level.jeep, "tag_driver");
	level.moody animscripts\shared::PutGunInHand("none");
}

driver_hardleft(delay, sound)
{
	if (isdefined(delay))
		wait (delay);
	level.moodyanim = 19;

	level notify ("Stop Moody Anim");
	level.jeep thread maps\bastogne1_anim::willyjeep_anims(4);
	level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_hardleft"]);
	if ( (isdefined(sound)) && (sound == "yes") )
		level.player playsound ("dirt_skid");
	
	level.moody waittillmatch ("animdone","end");
	level.moodyanim = 0;
	thread moody_drive_idle();
}

willyjeep_end()
{
	level.moodyanim = 19;
	level.jeep thread maps\bastogne1_anim::willyjeep_anims(13);
	if ( (isdefined(sound)) && (sound == "yes") )
		level.player playsound ("dirt_skid");
	
	//level.moody animscripted("reversecrashdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_crash"]);
	level.moody waittillmatch ("reversecrashdone","end");
	level.moody unlink();
	
	level.moody.goalradius = 8;
	node = getnode("moody_jeep_end","targetname");
	level.moody setgoalnode(node);
	level.moody waittill("goal");
	//level.moody unlink();
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
		thread moody_drive_idle();
}

moody_drive_duck()
{
	level.moodyanim = 19;
	level.jeep thread maps\bastogne1_anim::willyjeep_anims(2);
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_tree_duck"]);
		if ( (isdefined(sound)) && (sound == "yes") )
			level.player playsound ("dirt_skid");
		
		level.moody waittillmatch ("animdone","end");
		level.moodyanim = 0;
		thread moody_drive_idle();
}

moody_drive_fishtail()
{
	level.moodyanim = 19;
	getent ("jeep_fishtailsound","targetname") waittill ("trigger");
	level thread dirt_skid();
		
	getent ("jeep_fishtail","targetname") waittill ("trigger");
		//if ( (isdefined(sound)) && (sound == "yes") )
		//	level.player playsound ("dirt_skid");
		
	level.jeep thread maps\bastogne1_anim::willyjeep_anims(14);
		
	level thread dirt_skid();
		
	level.moody animscripted("reversecrashdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_reverse_crash"]);
		//level.moody unlink();
		//level.moody waittillmatch ("reversecrashdone","end");
		
		//level.moody waittillmatch ("animdone","end");
		//level.moodyanim = 0;
		//thread moody_drive_idle();
}

moody_drive_crash_kubel()
{
	level.moodyanim = 19;
		
	level.jeep thread maps\bastogne1_anim::willyjeep_anims(4);
	level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["kubel_crash"]);
	level.moody waittillmatch ("animdone","end");
		
	level.moodyanim = 0;
	thread moody_drive_idle();
}

ender_crash_kubel()
{
	level.enderanim = 21;
	level notify ("Stop Ender Anim");
		
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["kubel_crash"]);
	//wait .5;	
	
	//level.enderanim = 0;
	//thread ender_passenger_idle();
}

dirt_skid()
{
	level.player playsound ("dirt_skid");
	wait 1;
	level.player playsound ("dirt_skid");
	//wait 1;
	//level.player playsound ("dirt_skid");
}

driver_hardright(delay, sound)
{
	if (isdefined(delay))
		wait (delay);
	
	level.moodyanim = 19;
	
	
	level notify ("Stop Moody Anim");
	level.jeep thread maps\bastogne1_anim::willyjeep_anims(5);
	level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_hardright"]);
	if ( (isdefined(sound)) && (sound == "yes") )
	{
		level.player playsound ("dirt_skid");
	}
	level.moody waittillmatch ("animdone","end");
	level.moodyanim = 0;
	thread moody_drive_idle();
}

driver_hold(delay, sound)
{
	if (isdefined(delay))
		wait (delay);
		level.moodyanim = 19;
//	{
		level notify ("Stop Moody Anim");
		level.jeep thread maps\bastogne1_anim::willyjeep_anims(2);
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_wound_hold"]);
		if ( (isdefined(sound)) && (sound == "yes") )
		{
			level.player playsound ("dirt_skid");
		}
		level.moody waittillmatch ("animdone","end");
		level.moodyanim = 0;
		thread moody_drive_idle();
//	}
}

moody_bastogne1_reverse2forward() // used when backing up away from the stationary pack 43's
{
	level.moodyanim = 19;
	level notify ("Stop ender Anims");
	
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
	thread moody_drive_idle();
}

moody_peugeot_wait()
{
	level endon ("ExitVehicle");

	if (getcvar("start") != "jesse_start")
	{

	level.moody linkto(level.jeep, "tag_driver");
	level.moody animscripts\shared::PutGunInHand("none");

	rand_anim = ( randomint(3) + 1 );
	while (level.flags["PlayerInjeep"] == false || level.flags["ender_in_jeep"] == false)
	{
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_wait"]);
		level.moody waittillmatch ("animdone","end");


		rand_switch = randomint(2) + 1;
		switch(rand_switch)
		{
			case 1: level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_wait"]);
//				wait 0.1;
//				level.moody thread animscripts\shared::lookatentity(level.player, 10000000, "casual");
				level.moody waittillmatch ("animdone","end");
				break;
			case 2: level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_wave"]);
//				wait 0.1;
//				level.moody thread animscripts\shared::lookatentity(level.player, 10000000, "casual");
				level.moody waittillmatch ("animdone","end");
				break;
		}
	}
	}
}

moody_drive_idle()
{
	level endon ("ExitVehicle");
	level endon ("Stop Moody Anim");
	while (level.moodyanim == 0)
	{
		rand = (randomint(3));
		
		level.jeep thread maps\bastogne1_anim::willyjeep_anims(rand);
		level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["peugeot_idle"][rand]);
		level.moody waittill ("animdone");		
	}
}

ender_passenger_idle()
{
	level endon ("ExitVehicle");
	level endon ("Stop Ender Anim");
	//level.ender linkto(level.jeep, "tag_passenger");
	while (level.enderanim == 0)
	{
		rand = (randomint(3));
		
		level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle"][rand]);
		level.ender waittill ("animdone");		
	}
}

ender_attack1()
{
	level.enderanim = 21;
	level notify ("Stop Ender Anim");
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event1"]);
	level.ender waittillmatch ("animdone","end");
	
	level.enderanim = 0;
	thread ender_passenger_idle();
}

ender_attack2()
{
	level.enderanim = 21;
	level notify ("Stop Ender Anim");	
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event2"]);
	level.ender waittillmatch ("animdone","end");
	
	level.enderanim = 0;
	thread ender_passenger_idle();
}

ender_attack3()
{
	level.enderanim = 21;
	level notify ("Stop Ender Anim");	
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event3in"]);
	level.ender waittillmatch ("animdone","end");	

	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event3_loop"]);
	level.ender waittillmatch ("animdone","end");
	
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event3out"]);
	level.ender waittillmatch ("animdone","end");
	
	level.enderanim = 0;
	thread ender_passenger_idle();
}

ender_crash()
{
	level.enderanim = 21;
	level notify ("Stop Ender Anim");	
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_tree_crash"]);
	level.ender waittillmatch ("animdone","end");

	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_in"]);
	level.ender waittillmatch ("animdone","end");	

	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
	level.ender waittillmatch ("animdone","end");
				
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
	level.ender waittillmatch ("animdone","end");
				
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
	level.ender waittillmatch ("animdone","end");
				
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
	level.ender waittillmatch ("animdone","end");
				
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_out"]);
	level.ender waittillmatch ("animdone","end");
	
	level.enderanim = 0;
	thread ender_passenger_idle();
}

ender_attack4()
{
	level.enderanim = 21;
	level notify ("Stop Ender Anim");
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_in"]);
	level.ender waittillmatch ("animdone","end");	

	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
	level.ender waittillmatch ("animdone","end");
				
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
	level.ender waittillmatch ("animdone","end");
				
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
	level.ender waittillmatch ("animdone","end");
				
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_out"]);
	level.ender waittillmatch ("animdone","end");
	
	level.enderanim = 0;
	thread ender_passenger_idle();
}

ender_duck()
{
	level.enderanim = 21;
	level notify ("Stop Ender Anim");
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_tree_duck"]);
	level.ender waittillmatch ("animdone","end");
	
	level.enderanim = 0;
	thread ender_passenger_idle();
}

ender_speak()
{
	level.enderanim = 21;
	level notify ("Stop Ender Anim");
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["ender_speak"]);
	level.ender waittillmatch ("animdone","end");
	
	level.enderanim = 0;
	thread ender_passenger_idle();
}

ender_speakshort()
{
	level.enderanim = 21;
	level notify ("Stop Ender Anim");
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["ender_speakshort"]);
	level.ender waittillmatch ("animdone","end");
	
	level.enderanim = 0;
	thread ender_passenger_idle();
}

moody_speak()
{
	level.moodyanim = 19;
	level.jeep thread maps\bastogne1_anim::willyjeep_anims(2);
	level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["moody_speak"]);
	level.moody waittillmatch ("animdone","end");
	level.moodyanim = 0;
	thread moody_drive_idle();
}


moody_speakshort()
{
	level.moodyanim = 19;
	level.jeep thread maps\bastogne1_anim::willyjeep_anims(2);
	level.moody animscripted("animdone", (level.jeep gettagOrigin ("tag_driver")), (level.jeep gettagAngles ("tag_driver")), level.scr_anim["moody"]["moody_speakshort"]);	
	level.moody waittillmatch ("animdone","end");
	level.moodyanim = 0;
	thread moody_drive_idle();
}

/*ender_passenger_idle()
{	
	level endon ("ExitVehicle");
	level.ender linkto(level.jeep, "tag_passenger");
	//lastanim = (0);
	//lastanim = level.enderanim;
	while (1)
	{	
		println ("^1in ender anim while **** ", level.enderanim);
		
		//lastanim = level.enderanim;
		switch (level.enderanim)
		{
			case 0:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle_idleA"]);
				println ("^3in ender anim case 0");
				break;
			case 1:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle_idleB"]);
				break;
			case 2:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle_idleC"]);
				break;
			case 3:
//			// ATTACKING EVENT1	
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event1"]);
				println ("^3in ender anim case 3");

				//level.ender thread anim_single_solo(level.ender,"peugeot_attack_event1", "tag_passenger", undefined, level.jeep);
				//level.ender waittillmatch ("animdone","end");
				//level.ender waittillmatch ("single anim","end");
				//thread play_rand_anim(0,undefined,undefined);
				break;

			case 4:
//			// ATTACKING EVENT2	
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event2"]);
				//level.ender waittillmatch ("animdone","end");
				//thread play_rand_anim(1,undefined,undefined);
				break;
			case 5:
//			// ATTACKING convoy attack1 and 2
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event3in"]);
				level.ender waittillmatch ("animdone","end");	

				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event3_loop"]);
				//level.ender waittillmatch ("animdone","end");
				//thread play_rand_anim(2,undefined,undefined);
				break;
			case 6:
			// crash into tree
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_tree_crash"]);
				level.ender waittillmatch ("animdone","end");
//				level.ender animscripts\shared::PutGunInHand("right");
				level thread maps\bastogne1_anim::play_rand_anim(8,undefined,undefined);	// drive by
				//level.ender waittillmatch ("animdone","end");
				//thread play_rand_anim(2,undefined,undefined);
				break;
			case 7:
			// duck
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_tree_duck"]);
				//level.ender waittillmatch ("animdone","end");
//				level.ender animscripts\shared::PutGunInHand("right");
				//thread play_rand_anim(0,undefined,undefined);
				break;
			case 8:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_in"]);
				level.ender waittillmatch ("animdone","end");	

				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_out"]);
				//level.ender waittillmatch ("animdone","end");
				
				//thread play_rand_anim(0,undefined,undefined);
				break;
			case 9:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_in"]);
				level.ender waittillmatch ("animdone","end");	

				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_loop"]);
				level.ender waittillmatch ("animdone","end");
				
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_attack_event4_out"]);
				//level.ender waittillmatch ("animdone","end");
				
				//thread play_rand_anim(0,undefined,undefined);
				break;
		}
		level.ender waittillmatch ("animdone","end");
		println ("^2in ender anim ended ****", level.enderanim);
		//thread play_rand_anim(0,undefined,undefined);
		level.enderanim = 0;
	}
}*/

/*ender_passenger_idle2()
{	
	level endon ("ExitVehicle");
	level.ender linkto(level.jeep, "tag_passenger");
	level.ender animscripts\shared::PutGunInHand("none");
	level.ender animscripts\shared::PutGunInHand("left");
	lastanim = (0);
	while (1)
	{
		if (level.enderanim != lastanim)
			thread ender_anim_intrans();
			
		lastanim = level.enderanim;
		switch (level.enderanim)
		{
			case 0:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle_calm"]);
				level.ender animscripts\shared::PutGunInHand("left");
				break;
			case 1:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle_backleft"]);
				level.ender animscripts\shared::PutGunInHand("right");
				break;
			case 2:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle_backright"]);
				level.ender animscripts\shared::PutGunInHand("left");
				break;
			case 3:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle_left"]);
				level.ender animscripts\shared::PutGunInHand("right");
				break;
			case 4:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle_right"]);
				level.ender animscripts\shared::PutGunInHand("left");
				break;
			case 5:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_transition_L2R"]);
				level.ender animscripts\shared::PutGunInHand("left");
				break;
			case 6:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_transition_R2L"]);
				level.ender animscripts\shared::PutGunInHand("right");
				break;
			case 7:
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_idle_back"]);
				level.ender animscripts\shared::PutGunInHand("left");
				break;
			case 8:	//reverse start
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_reverse_start"]);
				level.ender animscripts\shared::PutGunInHand("left");
				thread play_rand_anim(9,undefined,undefined);
				break;
			case 9: //reverse loop
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_reverse_loop"]);
				break;
			case 10://reverse to forward
				level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_reverse_forward"]);
				thread play_rand_anim(0,undefined,undefined);
				break;
		}
		level.ender waittillmatch ("animdone","end");
	}
}*/

play_rand_anim( anim1, anim2, anim3)
{
	println ("^1ENTERING RAND ANIM FUNC",level.enderanim);
	level notify ("NewenderAnim");
	level endon ("NewenderAnim");
	level endon ("PeugeotCrash");
	
	if (isdefined (anim1))
		diffanims[0] = (anim1);
	if (isdefined (anim2))
		diffanims[1] = (anim2);
	if (isdefined (anim3))
		diffanims[2] = (anim3);
	
	if (diffanims.size > 1)
	{
		while (1)
		{
			rand = (randomint(diffanims.size));
			level.enderanim = (diffanims[rand]);
			level.ender waittill ("animdone");
		}
	}
	else
	{
		level.enderanim = diffanims[0];
	}
}


// getting into truck
ender_peugeot()
{
	level endon ("ExitVehicle");
	level.ender linkto(level.jeep, "tag_passenger");
	
	
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_jumpin"]);
	
	level.ender waittillmatch ("animdone","end");
	
	level.flags["ender_in_jeep"] = true;
	level.ender notify ("end jeep damage penalty");

	rand_anim = ( randomint(3) + 1 );
	while (level.flags["PlayerInjeep"] == false)
	{
		level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_wait"]);
		level.ender waittillmatch ("animdone","end");


		rand_switch = randomint(3) + 1;
		switch(rand_switch)
		{
			case 1: level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_letsgo"]);
				level.ender waittillmatch ("animdone","end");
				break;
			case 2: level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_wait"]);
				level.ender waittillmatch ("animdone","end");
				break;
			case 3: level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_wait"]);
				level.ender waittillmatch ("animdone","end");
				break;
		}
	}
}

ender_shot_and_wounded() // works call at pack 43 event
{
	level endon("objective_3_complete");
	level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_shot"]);
	level.ender waittillmatch ("animdone","end");
	level.ender animscripts\shared::PutGunInHand("none");

	rand_anim = ( randomint(1) + 1 );
	while (level.flags["PlayerInjeep"] == true)
	{
		rand_switch = randomint(1) + 1;
		switch(rand_switch)
		{
			case 1: level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_wounda"]);
				level.ender waittillmatch ("animdone","end");
				break;
		}
	}


	while (level.flags["PlayerInjeep"] == false)
	{
		rand_switch = randomint(1) + 1;
		switch(rand_switch)
		{
			case 1: level.ender animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger")), level.scr_anim["ender"]["peugeot_woundb"]);
				level.ender waittillmatch ("animdone","end");
				break;
		}
	}
}

ender_dropgunnote()
{
	while (1)
	{
		self waittill ("enderjumpin", notetrack);
		if (notetrack == "drop gun")
		{
			self animscripts\shared::PutGunInHand("none");
			return;
		}
	}
}

moody_fireonnote()
{
	self endon ("StopNotes");
	while (1)
	{
		self waittill ("moodygetin", notetrack);
		if (notetrack == "fire")
			self shoot();
	}
}

ender_shoot(delay, length)
{
	level notify ("Stop Shooting");
	level endon ("Stop Shooting");
	if (delay > 0)
		wait (delay);
	
	thread ender_shoot_timer(length);
	while (1)
	{
		if (level.flags["PlayerInjeep"] == true)
			level.ender shoot();
		wait (0.0857);
	}
}

new_ender_shoot()
{
	while (1)
	{
		self waittill ("animdone",notetrack);
		
		if (isdefined(notetrack) && notetrack == "fire_start")
		{
			self thread new_ender_shoot_loop();
		}
		
		else if (isdefined(notetrack) && notetrack == "fire_stop")
		{
			level notify ("stop ender fire");
		}
	}
}

new_ender_shoot_loop()
{
	level endon ("stop ender fire");
	while (1)
	{
		self shoot();
		wait (0.0857);
	}
}

ender_shoot_timer(time)
{
	level endon ("Stop Shooting");
	wait (time);
	level notify ("Stop Shooting");
}

ender_anim_intrans()
{
	level.flags["enderTrans"] = true;
	wait (0.3);
	level.flags["enderTrans"] = false;
}

medics_in_barn_anim()
{
	med1_org = level.jeep gettagOrigin ("tag_origin");
	med1_org = med1_org+(0,0,0);
	
	level.medic1 animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger") + (0,0,0)), level.scr_anim["medic1"]["nurse_in"]);
	level.medic1 waittillmatch ("animdone","end");
	while(1)
	{
		level.medic1 animscripted("animdone", (level.jeep gettagOrigin ("tag_passenger")), (level.jeep gettagAngles ("tag_passenger") + (0,0,0)), level.scr_anim["medic1"]["nurse"][0]);
		level.medic1 waittillmatch ("animdone","end");
	}
}

#using_animtree("bastogne_map");
map_table_anim()
{	
	level.scr_animtree["map"]					= #animtree;
	level.scr_anim["map"]["map_anim"][0]				= (%bastogne_map);
}

#using_animtree("kubelwagon_kubel_path");
kubelwagon_load_anims()
{
	level.scr_animtree["kubelwagon"] 		= #animtree;
	level.scr_anim["kubelwagon"]["crash"]		= (%bastogne_kubelwagen_crash);
}

#using_animtree("bastogne1_dummies");
axis_drones()
{
	level.scr_animtree["axis_drone"] 				= #animtree;
	level.scr_character["axis_drone"][0] 				= character\German_wehrmact_snow ::main;

	level.scr_anim["axis_drone"]["move_forward"][0]			= (%sprint1_loop);
	level.scr_anim["axis_drone"]["move_forward"][1]			= (%stand_shoot_run_forward);
	level.scr_anim["axis_drone"]["move_forward"][2]			= (%crouchrun_loop_forward_1);
	
	
	level.scr_sound ["exaggerated flesh impact"] 				= "bullet_mega_flesh"; // Commissar shot by sniper (exaggerated cinematic type impact)
    	level._effect["ground"]							= loadfx ("fx/impacts/small_gravel.efx");
	level._effect["flesh small"]						= loadfx ("fx/impacts/flesh_hit.efx");
	level.scr_dyingguy["effect"][0] 					= "ground";
	level.scr_dyingguy["effect"][1] 					= "flesh small";
	level.scr_dyingguy["sound"][0] 						= level.scr_sound ["exaggerated flesh impact"];
	level.scr_dyingguy["tag"][0] 						= "bip01 l thigh";         																							
	level.scr_dyingguy["tag"][1] 						= "bip01 head";            																							
	level.scr_dyingguy["tag"][2] 						= "bip01 l calf";          																							
	level.scr_dyingguy["tag"][3] 						= "bip01 pelvis";          																							
	level.scr_dyingguy["tag"][4] 						= "tag_breastpocket_right";																							
	level.scr_dyingguy["tag"][5] 						= "bip01 l clavicle";    

	level.scr_anim["axis_drone"]["death"][0]				= (%death_run_forward_crumple);
	level.scr_anim["axis_drone"]["death"][1]				= (%crouchrun_death_drop);
	level.scr_anim["axis_drone"]["death"][2]				= (%crouchrun_death_crumple);
	level.scr_anim["axis_drone"]["death"][3]				= (%death_run_onfront);
	level.scr_anim["axis_drone"]["death"][4]				= (%death_run_onleft);
	// Explosion Deaths
	level.scr_anim["axis_drone"]["exp_death"][0]				= (%death_explosion_back13);
	level.scr_anim["axis_drone"]["exp_death"][1]				= (%death_explosion_forward13);     
	level.scr_anim["axis_drone"]["exp_death"][2]				= (%death_explosion_left11);  
	level.scr_anim["axis_drone"]["exp_death"][3]				= (%death_explosion_right13);        
	level.scr_anim["axis_drone"]["exp_death"][4]				= (%death_explosion_up10);
}

#using_animtree("bastogne1_dummies");
Drone_Paths()
{
	level.scr_animtree["field_dummy_path1"] 			= #animtree;
	level.drone_path_anim["field_dummy_path1"] 			= (%bastogne1_field_dummies1);
	level.scr_animtree["field_dummy_path2"] 			= #animtree;
	level.drone_path_anim["field_dummy_path2"]			= (%bastogne1_field_dummies2);
	level.scr_animtree["field_dummy_path3"] 			= #animtree;
	level.drone_path_anim["field_dummy_path3"]			= (%bastogne1_field_dummies3);
}

anim_single_solo (guy, anime, tag, node, tag_entity)
{
	newguy[0] = guy;
	maps\_anim_gmi::anim_single (newguy, anime, tag, node, tag_entity);
}