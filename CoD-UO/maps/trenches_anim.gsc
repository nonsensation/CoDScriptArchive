#using_animtree("generic_human");
main()
{
// Vassili Section ===================== //
	// Hah! They're all mouth!
	level.scrsound["truckriders"]["all_mouth"]				= "vass_ev02_01";
	level.scr_face["truckriders"]["all_mouth"]				= (%PegDay_facial_Friend1_01_incoming);
                                                                        	
	//  Stay low, they'll pick your head off like a melon   
	level.scr_anim["truckriders"]["vass_ev03_01"]				= (%c_rs_trenches_vass_ev03_01);
	level.scrsound["truckriders"]["vass_ev03_01"]				= "vass_ev03_01";
	level.scr_face["truckriders"]["vass_ev03_01"]				= (%f_trenches_vass_ev03_01);

	// Incoming!
//	level.scrsound["vassili"]["incoming"]					= "kursk_incoming";
	level.scr_face["vassili"]["incoming"]					= (%PegDay_facial_Friend1_01_incoming);

	// Move it, move, get off the truck
	level.scrsound["vassili"]["vass_offtruck"]				= "vass_offtruck";
	level.scr_face["vassili"]["vass_offtruck"]				= (%f_trenches_vass_offtruck);

	// Get your weapon, and we'll meet you on the other side.
	level.scrsound["vassili"]["get_your_weapon"]				= "vass_ev06_01";
	level.scr_face["vassili"]["get_your_weapon"]				= (%f_trenches_vass_ev06_01);
                                                                        	
	// Get your weapon, and we'll meet you on the other side.       	
	level.scrsound["vassili"]["hurry"]					= "vass_ev08_01";
	level.scr_face["vassili"]["hurry"]					= (%PegDay_facial_Friend1_01_incoming);
                                                                        	
	// They'll attack soon.                                         	
	level.scrsound["vassili"]["attack_soon"]				= "vass_ev09_01";
	level.scr_face["vassili"]["attack_soon"]				= (%f_trenches_vass_ev09_01);
                                                                        	
	// Look out, it's coming down.                                  	
	level.scrsound["vassili"]["stuka_coming_down"]				= "vass_ev10_01";
	level.scr_face["vassili"]["stuka_coming_down"]				= (%PegDay_facial_Friend1_01_incoming);
                                                                        	
	// They'll be using flamethrowers, so keep them at a distance.  	
	level.scrsound["vassili"]["flamethrowers"]				= "vass_ev11_01";
	level.scr_face["vassili"]["flamethrowers"]				= (%f_trenches_vass_ev11_01);
                                                                        	
	// Look over there, incoming tanks!                             	
	level.scrsound["vassili"]["incoming_tanks"]				= "vass_ev12_01";
	level.scr_face["vassili"]["incoming_tanks"]				= (%PegDay_facial_Friend1_01_incoming);

	// Look over there, incoming tanks!                             	
	level.scrsound["vassili"]["vass_overrun"]				= "vass_overrun";
	level.scr_face["vassili"]["vass_overrun"]				= (%PegDay_facial_Friend1_01_incoming);

	// Enemy. Fire!
	level.scrsound["vassili"]["vass_fire"]					= "vass_fire";
	level.scr_face["vassili"]["vass_fire"]					= (%PegDay_facial_Friend1_01_incoming);

	level.scr_anim["commissar"]["getting_flanked"]				= (%c_rs_trenches_antonov_neworders);
	level.scr_face["commissar"]["getting_flanked"]				= (%f_trenches_antonov_neworders);
	level.scrsound["commissar"]["getting_flanked"]				= "antonov_neworders";

	// Right Flank, Keep Firing!                           	
	level.scrsound["commissar"]["antonov_keepfiring01"]			= "antonov_keepfiring01";
	level.scr_face["commissar"]["antonov_keepfiring01"]			= (%PegDay_facial_Friend1_01_incoming);

	// They're still coming, comrads-fire!                        	
	level.scrsound["commissar"]["antonov_keepfiring02"]			= "antonov_keepfiring02";
	level.scr_face["commissar"]["antonov_keepfiring02"]			= (%PegDay_facial_Friend1_01_incoming);

	// Don't let them in
	level.scrsound["commissar"]["antonov_keepfiring03"]			= "antonov_keepfiring03";
	level.scr_face["commissar"]["antonov_keepfiring03"]			= (%PegDay_facial_Friend1_01_incoming);

	// Would you like to stay here with the german tanks.
	level.scrsound["vassili"]["stay_here"]					= "vass_ev16_02";
	level.scr_face["vassili"]["stay_here"]					= (%PegDay_facial_Friend1_01_incoming);
                                                                        	
	// Crouch while on truck                                        	
	level.scr_anim["vassili"]["stand2flinch"]				= (%flinchA_stand2flinch);
	level.scr_anim["vassili"]["flinchloop"][0]				= (%flinchA);
	level.scr_anim["vassili"]["flinch2stand"]				= (%flinchA_2stand);
                                                                        	
	level.scr_anim["vassili"]["stand2flinch_B"]				= (%flinchB_stand2flinch);
	level.scr_anim["vassili"]["flinchloop_B"][0]				= (%flinchB);
	level.scr_anim["vassili"]["flinch2stand_B"]				= (%flinchB_2stand);

	// Good work, let's go, the sgt. is waiting for us.
	level.scrsound["vassili"]["vass_goodwork"]				= "vass_goodwork";
	level.scr_face["vassili"]["vass_goodwork"]				= (%f_trenches_vass_goodwork);

	// They're coming over the hill
	level.scrsound["vassili"]["vass_over_hill"]				= "vass_over_hill";
	level.scr_face["vassili"]["vass_over_hill"]				= (%f_trenches_vass_over_hill);

	// He's pinned, drive them back.
	level.scrsound["vassili"]["vass_pinned"]				= "vass_pinned";
	level.scr_face["vassili"]["vass_pinned"]				= (%f_trenches_vass_pinned);

	// To the Mill
	level.scrsound["vassili"]["vass_mill"]					= "vass_mill";
	level.scr_face["vassili"]["vass_mill"]					= (%f_trenches_vass_mill);

	// Event14 kick door
	level.scr_anim["vassili"]["kick_door_1"] 				= (%chateau_kickdoor1);
	level.scr_anim["vassili"]["kick_door_2"] 				= (%chateau_kickdoor2);

// End Vassili Section ================= //

// Miesha Section ====================== //
	// Artillery, get down.
	level.scrsound["truckriders"]["artillery"]				="miesha_ev05_01";
	level.scr_face["truckriders"]["artillery"]				=(%f_trenches_miesha_ev05_01);
	// They took out the last truck.
	level.scrsound["truckriders"]["blew_up_last_truck"]			="miesha_ev06_01";
	level.scr_face["truckriders"]["blew_up_last_truck"]			=(%PegDay_facial_Friend1_01_incoming);

	// They Make Pretty speeches, but where do they go once the fighting starts
	level.scrsound["truckriders"]["pretty_speeches"]			="miesha_ev02_01";
	level.scr_face["truckriders"]["pretty_speeches"]			=(%PegDay_facial_Friend1_01_incoming);

	// Careful comrade, they have ears too."
	level.scrsound["truckriders"]["they_have_ears"]				="miesha_ev02_02";
	level.scr_face["truckriders"]["they_have_ears"]				=(%PegDay_facial_Friend1_01_incoming);
                                                                        	
	// The front can't possibly be worse than this madness!"        	
	level.scrsound["truckriders"]["this_madness"]				="miesha_ev03_01";
	level.scr_face["truckriders"]["this_madness"]				=(%f_trenches_miesha_ev03_01);

	level.scr_anim["truckridres"]["vass_defeat"]				=(%c_rs_trenches_vass_defeat);
	level.scrsound["truckriders"]["vass_defeat"]				="vass_defeat";
	level.scr_face["truckriders"]["vass_defeat"]				=(%f_trenches_vass_defeat);
                                                                        	
	// Pull yourself together.                                      	
//	level.scr_anim["miesha"]["pull_yourself_together"]			=(%c_rs_trenches_miesha_ev08_01);
//	level.scrsound["miesha"]["pull_yourself_together"]			="miesha_ev08_01";
//	level.scr_face["miesha"]["pull_yourself_together"]			=(%f_trenches_miesha_ev08_01);
                                                                        	
	// Inomcing Stuka!                                              	
	level.scrsound["miesha"]["incoming_stuka"]				="miesha_ev10_01";
	level.scr_face["miesha"]["incoming_stuka"]				=(%PegDay_facial_Friend1_01_incoming);
	level.scr_anim["miesha"]["incoming_stuka"]				=(%c_rs_trenches_miesha_ev10_01);
                                                                        	
	// Yuri, retreive the explosives.                               	
	level.scrsound["miesha"]["retrieve_explosives"]				="miesha_ev14_01";
	level.scr_face["miesha"]["retrieve_explosives"]				=(%PegDay_facial_Friend1_01_incoming);
                                                                        	
	// Why do we have to run back and forth all the time?           	
	level.scrsound["miesha"]["back_and_forth"]				="miesha_ev16_01";
	level.scr_face["miesha"]["back_and_forth"]				=(%PegDay_facial_Friend1_01_incoming);	
                                                                        	
	// Crouch while on truck                                        	
	level.scr_anim["miesha"]["stand2flinch"]				= (%flinchA_stand2flinch);
	level.scr_anim["miesha"]["flinchloop"][0]				= (%flinchA);
	level.scr_anim["miesha"]["flinch2stand"]				= (%flinchA_2stand);
                                                                        	
	level.scr_anim["miesha"]["stand2flinch_B"]				= (%flinchB_stand2flinch);
	level.scr_anim["miesha"]["flinchloop_B"][0]				= (%flinchB);
	level.scr_anim["miesha"]["flinch2stand_B"]				= (%flinchB_2stand);

	// You alright?
	level.scr_anim["miesha"]["miesha_you_alright"]				=(%c_rs_trenches_miesha_you_alright);
	level.scrsound["miesha"]["miesha_you_alright"]				="miesha_you_alright";
	level.scr_face["miesha"]["miesha_you_alright"]				=(%f_trenches_miesha_you_alright);	

	// It's coming around!
	level.scrsound["miesha"]["miesha_comin_round"]				="miesha_comin_round";
	level.scr_face["miesha"]["miesha_comin_round"]				=(%PegDay_facial_Friend1_01_incoming);	

// End Miesha Section ================== //                             	
                                                                        	
// Boris Section ======================= //                             	
	// We're never going to make this.      

//	level.scr_anim["truckriders"]["not_going_to_make_this"]			=(%c_rs_trenches_boris_ev05_01);
//	level.scrsound["truckriders"]["not_going_to_make_this"]			="boris_ev05_01";
//	level.scr_face["truckriders"]["not_going_to_make_this"]			=(%f_trenches_boris_ev05_01);
                                                                        	
	// We're all going to die.                                      	
	level.scrsound["boris"]["were_going_to_die"]				="boris_ev08_01";
	level.scr_face["boris"]["were_going_to_die"]				=(%PegDay_facial_Friend1_01_incoming);
                                                                        	
	// Thank god the shelling is over.                              	
	level.scr_anim["boris"]["thank_god"]					=(%c_rs_trenches_boris_ev09_01);
	level.scrsound["boris"]["thank_god"]					="boris_ev09_01";
	level.scr_face["boris"]["thank_god"]					=(%f_trenches_boris_ev09_01);
                                                                        	
	// Look! The reinforcements are here.                           	
	level.scrsound["boris"]["reinforcements_are_here"]			="boris_ev12_01";
	level.scr_face["boris"]["reinforcements_are_here"]			=(%PegDay_facial_Friend1_01_incoming);	
                                                                        	
	// We're not going to make it.                                  	
	level.scrsound["boris"]["not_going_to_make_it"]				="boris_ev17_01";
	level.scr_face["boris"]["not_going_to_make_it"]				=(%PegDay_facial_Friend1_01_incoming);	
                                                                        	
	// We're not going to make it.                                  	
	level.scrsound["boris"]["no_die"]					="boris_ev18_02";
	level.scr_face["boris"]["no_die"]					=(%PegDay_facial_Friend1_01_incoming);	
                                                                        	
	// We're not going to make it.                                  	
	level.scrsound["boris"]["my_country"]					="boris_ev18_03";
	level.scr_face["boris"]["my_country"]					=(%PegDay_facial_Friend1_01_incoming);	
                                                                        	
	// We're not going to make it.                                  	
	level.scrsound["boris"]["make_you_pay"]					="boris_ev18_04";
	level.scr_face["boris"]["make_you_pay"]					=(%PegDay_facial_Friend1_01_incoming);	
	                                                                	
	// Crouch while on truck                                        	
	level.scr_anim["boris"]["stand2flinch"]					= (%flinchA_stand2flinch);
	level.scr_anim["boris"]["flinchloop"][0]				= (%flinchA);
	level.scr_anim["boris"]["flinch2stand"]					= (%flinchA_2stand);
                                                                        	
	level.scr_anim["boris"]["stand2flinch_B"]				= (%flinchB_stand2flinch);
	level.scr_anim["boris"]["flinchloop_B"][0]				= (%flinchB);
	level.scr_anim["boris"]["flinch2stand_B"]				= (%flinchB_2stand);
// End Boris Section =================== //                             	
                                                                        	
// All of the truckriders... Crouch while on truck                      	
	level.scr_anim["truckriders"]["stand2flinch"]				= (%flinchA_stand2flinch);
	level.scr_anim["truckriders"]["flinchloop"][0]				= (%flinchA);
	level.scr_anim["truckriders"]["flinch2stand"]				= (%flinchA_2stand);
                                                                        	
	level.scr_anim["truckriders"]["stand2flinch_B"]				= (%flinchB_stand2flinch);
	level.scr_anim["truckriders"]["flinchloop_B"][0]			= (%flinchB);
	level.scr_anim["truckriders"]["flinch2stand_B"]				= (%flinchB_2stand);
                                                                        	
// Commissars Section ======================= //                        	
	// Get out of the trucks, and into the trenches.                	
	level.scrsound["commissar"]["get_into_trenches"]			= "comm_ev06_01";
	level.scr_face["commissar"]["get_into_trenches"]			=(%f_trenches_comm_ev06_01);
	level.scr_anim["commissar"]["get_into_trenches"]			=(%c_rs_trenches_comm_ev06_01);
                                                                        	
	// Get your weapons from the bunker.                            	
	level.scrsound["commissar"]["get_weapon_from_bunker"]			= "comm_ev06_02";
	level.scr_face["commissar"]["get_weapon_from_bunker"]			=(%f_trenches_comm_ev06_02);
	level.scr_anim["commissar"]["get_weapon_from_bunker"]			=(%c_rs_trenches_comm_ev06_02);
                                                                        	
	// Commissar waving, in trench                                  	
	level.scr_anim["commissar"]["wave_loop"][0]				= (%line_officerA_stand_twitchB);
	level.scr_anim["commissar"]["wave_loopweight"][0]			= 0.5;
	level.scr_anim["commissar"]["wave_loop"][1]				= (%line_officer_stand_idle);
	level.scr_face["commissar"]["wave_loop"][1]				= (%f_trenches_gs_ant_ev09_01);
	level.scrsound["commissar"]["wave_loop"][1]				="gs_ant_ev09_01";
	level.scr_anim["commissar"]["wave_loopweight"][1]			= 3;
	level.scr_anim["commissar"]["wave_loop"][2]				= (%line_officerA_stand_twitchA);
	level.scr_anim["commissar"]["wave_loopweight"][2]			= 3;
	level.scr_anim["commissar"]["wave_loop"][3]				= (%line_officerA_waveB);
	level.scr_face["commissar"]["wave_loop"][3]				= (%f_trenches_gs_ant_ev09_02);
	level.scrsound["commissar"]["wave_loop"][3]				= "gs_ant_ev09_02";
	level.scr_anim["commissar"]["wave_loopweight"][3]			= 3;
	level.scr_anim["commissar"]["wave_loop"][4]				= (%line_officerA_waveB);
	level.scr_face["commissar"]["wave_loop"][4]				= (%f_trenches_antonov_find_spot);
	level.scrsound["commissar"]["wave_loop"][4]				= "antonov_find_spot";
	level.scr_anim["commissar"]["wave_loopweight"][4]			= 3;
	level.scr_anim["commissar"]["wave_loop"][5]				= (%line_officerA_stand_twitchA);
	level.scr_face["commissar"]["wave_loop"][5]				= (%f_trenches_antonov_move_forward);
	level.scrsound["commissar"]["wave_loop"][5]				= "antonov_move_forward";
	level.scr_anim["commissar"]["wave_loopweight"][5]			= 3;

	level.scr_anim["commissar"]["warning1"]					= (%Leader_shout_B);
	level.scrsound["commissar"]["warning1"]					="commissar2_line47";

	level.scr_anim["commissar"]["warning2"]					= (%Leader_shout_B);
	level.scrsound["commissar"]["warning2"]					="commissar2_line51";

	level.scr_anim["commissar"]["warning3"]					= (%Leader_shout_B);
	level.scrsound["commissar"]["warning3"]					="commissar2_line52";
	
	level.scr_anim["commissar"]["traitor1"]					= (%Leader_shout_B);
	level.scrsound["commissar"]["traitor1"]					="commissar1_line26";

	level.scr_anim["commissar"]["traitor2"]					= (%Leader_shout_B);
	level.scrsound["commissar"]["traitor2"]					="commissar1_line40";

//	level.scr_face["commissar"]["traitor1b"]				= (%Leader_shout_B);
	level.scrsound["commissar"]["traitor1b"]				="commissar1_line26";

//	level.scr_face["commissar"]["traitor2b"]				= (%Leader_shout_B);
	level.scrsound["commissar"]["traitor2b"]				="commissar1_line40";
                                                                        	
	// Right Flank, front line Section=====================         	
                                                                        	
	// Commissar wait for it.                                       	
	level.scr_anim["commissar"]["wait_for_it"]				=(%c_rs_trenches_gs_ant_ev09_03);
	level.scrsound["commissar"]["wait_for_it"]				="gs_ant_ev09_03";
	level.scr_face["commissar"]["wait_for_it"]				=(%f_trenches_gs_ant_ev09_03);

	level.scr_anim["commissar"]["wait_for_it_idle"][0]			=(%c_rs_trenches_gs_ant_ev09_idle);
                                                                        	
	// MachineGuns!!                    
	level.scr_anim["commissar"]["machineguns"]				=(%c_rs_trenches_gs_ant_machineguns);
	level.scrsound["commissar"]["machineguns"]				="machineguns";
	level.scr_face["commissar"]["machineguns"]				=(%f_trenches_machineguns);
                                                                        	
	// MachineGuns Ready!                                           	
	level.scrsound["commissar"]["mg_ready"]					="machineguns_ready";
	level.scr_face["commissar"]["mg_ready"]					=(%PegDay_facial_Friend1_01_incoming);
                                                                        	
	// Fire!                                                        	
	level.scr_anim["commissar"]["fire"]					=(%c_rs_trenches_gs_ant_fire);
	level.scrsound["commissar"]["fire"]					="fire";
	level.scr_face["commissar"]["fire"]					=(%PegDay_facial_Friend1_01_incoming);
                                                                        	
	// Commissar wait for a clear shot before firing!               	
	level.scrsound["commissar"]["clear_shot"]				="gs_ant_ev09_04";
	level.scr_face["commissar"]["clear_shot"]				=(%PegDay_facial_Friend1_01_incoming);

	// END Right Flank, front line Section=================

	// Comrades, the fascists have broken through, reinforce the left flank.
	level.scr_anim["commissar"]["reinforce_left_flank"]			=(%c_rs_trenches_comm_ev11_01);
	level.scrsound["commissar"]["reinforce_left_flank"]			= "comm_ev11_01";
	level.scr_face["commissar"]["reinforce_left_flank"]			=(%f_trenches_comm_ev11_01);

	// Comrades, follow me!
	level.scrsound["commissar"]["follow_me"]				="gs_ant_ev13_01";
	level.scr_face["commissar"]["follow_me"]				=(%PegDay_facial_Friend1_01_incoming);

	// Through Here.                               	
	level.scrsound["commissar"]["antonov_thru_here"]			="antonov_thru_here";
	level.scr_face["commissar"]["antonov_thru_here"]			=(%PegDay_facial_Friend1_01_incoming);

	// Blow up elefant tanks
	level.scr_anim["commissar_event14"]["take_out_elefant_tanks"]		=(%c_rs_trenches_gs_ant_ev14);
	level.scr_notetrack["commissar_event14"][0]["notetrack"]		= "gs_ant_ev14_01";
	level.scr_notetrack["commissar_event14"][0]["dialogue"] 		= "gs_ant_ev14_01";
	level.scr_notetrack["commissar_event14"][0]["facial"]			= (%f_trenches_gs_ant_ev14_01);

	level.scr_notetrack["commissar_event14"][1]["notetrack"]		= "gs_ant_ev14_02";
	level.scr_notetrack["commissar_event14"][1]["dialogue"] 		= "gs_ant_ev14_02";
	level.scr_notetrack["commissar_event14"][1]["facial"]			= (%f_trenches_gs_ant_ev14_02);


//	// Go take out those elefant tanks with your explosives.        	
	level.scrsound["commissar_event14"]["take_out_elefant_tanksb"]			="gs_ant_ev14_01";
	level.scr_face["commissar_event14"]["take_out_elefant_tanksb"]			=(%f_trenches_gs_ant_ev14_01);
//                                                                        	
//	// You men provide covering fire.                               	
//	level.scrsound["commissar"]["provide_cover_fire"]			="gs_ant_ev14_02";
//	level.scr_face["commissar"]["provide_cover_fire"]			=(%f_trenches_gs_ant_ev14_02);

// End Commissars Section =================== //               	         	
                                                                        	
// Train Riders ============================= //                        	
	level.scr_anim["truckriders"]["climb_out_1"]				= (%trenches_train_jumpoff01);
	level.scr_anim["truckriders"]["climb_out_2"]				= (%trenches_train_jumpoff02);
	level.scr_anim["truckriders"]["climb_out_3"]				= (%trenches_train_jumpoff03);
	level.scr_anim["truckriders"]["climb_out_4"]				= (%trenches_train_jumpoff04);
	level.scr_anim["truckriders"]["climb_out_5"]				= (%trenches_train_jumpoff05);
	level.scr_anim["truckriders"]["climb_out_6"]				= (%trenches_train_jumpoff06);
	level.scr_anim["truckriders"]["climb_out_7"]				= (%trenches_train_jumpoff07);
	level.scr_anim["truckriders"]["climb_out_8"]				= (%trenches_train_jumpoff08);
	level.scr_anim["truckriders"]["climb_out_9"]				= (%trenches_train_jumpoff09);
	level.scr_anim["truckriders"]["climb_out_10"]				= (%trenches_train_jumpoff10);
	level.scr_anim["truckriders"]["climb_out_11"]				= (%trenches_train_jumpoff11);
	level.scr_anim["truckriders"]["climb_out_12"]				= (%trenches_train_jumpoff12);
	level.scr_anim["truckriders"]["climb_out_13"]				= (%trenches_train_jumpoff13);
	level.scr_anim["truckriders"]["climb_out_14"]				= (%trenches_train_jumpoff14);
	level.scr_anim["truckriders"]["climb_out_15"]				= (%trenches_train_jumpoff15);
	level.scr_anim["truckriders"]["climb_out_16"]				= (%trenches_train_jumpoff16);
//	level.scr_anim["truckriders"]["climb_out_17"]				= (%trenches_train_jumpoff17);
//	level.scr_anim["truckriders"]["climb_out_18"]				= (%trenches_train_jumpoff18);
//	level.scr_anim["truckriders"]["climb_out_19"]				= (%trenches_train_jumpoff19);
//	level.scr_anim["truckriders"]["climb_out_20"]				= (%trenches_train_jumpoff20);

	level.scr_anim["truckriders"]["run_loop"][0]				= (%c_combatrun_forward_2_skating);
	level.scr_anim["truckriders"]["run_loop"][1]				= (%c_combatrun_forward_1_skating);
	level.scr_anim["truckriders"]["run_loop"][2]				= (%c_combatrun_forward_3_skating);
	level.scr_anim["truckriders"]["run_loop"][3]				= (%c_precombatrun1_skating);
//	level.scr_anim["truckriders"]["run_loop"][4]				= (%sprint1_loop);

	level.scr_anim["truckriders"]["trans_stand"][0]				= (%stand_alert_1);
	level.scr_anim["truckriders"]["trans_stand"][1]				= (%stand_alert_2);
	level.scr_anim["truckriders"]["trans_stand"][2]				= (%stand_alert_3);
                                                                       	
	// START::Truckride section------//                             	
                                                                        	
	// Idle loop                                                    	
	level.scr_anim["truckriders"]["idle_a1"][0]				= (%trenches_truckride_idleA1);
	level.scr_face["truckriders"]["idle_a1"][0]				= (%facial_panic01);
	level.scr_face["truckriders"]["idle_a1"][1]				= (%facial_fear01);
	level.scr_face["truckriders"]["idle_a1"][2]				= (%facial_fear02);
	level.scr_face["truckriders"]["idle_a1"][3]				= (%facial_alert01);
	level.scr_face["truckriders"]["idle_a1"][4]				= (%facial_alert02);
                                                                        	
	level.scr_anim["truckriders"]["idle_a2"][0]				= (%trenches_truckride_idleA2);
	level.scr_face["truckriders"]["idle_a2"][0]				= (%facial_panic01);
	level.scr_face["truckriders"]["idle_a2"][1]				= (%facial_fear01);
	level.scr_face["truckriders"]["idle_a2"][2]				= (%facial_fear02);
	level.scr_face["truckriders"]["idle_a2"][3]				= (%facial_alert01);
	level.scr_face["truckriders"]["idle_a2"][4]				= (%facial_alert02);
                                                                        	
	level.scr_anim["truckriders"]["idle_a3"][0]				= (%trenches_truckride_idleA3);
	level.scr_face["truckriders"]["idle_a3"][0]				= (%facial_panic01);
	level.scr_face["truckriders"]["idle_a3"][1]				= (%facial_fear01);
	level.scr_face["truckriders"]["idle_a3"][2]				= (%facial_fear02);
	level.scr_face["truckriders"]["idle_a3"][3]				= (%facial_alert01);
	level.scr_face["truckriders"]["idle_a3"][4]				= (%facial_alert02);
                                                                        	
	level.scr_anim["truckriders"]["idle_a4"][0]				= (%trenches_truckride_idleA4);
	level.scr_face["truckriders"]["idle_a4"][0]				= (%facial_panic01);
	level.scr_face["truckriders"]["idle_a4"][1]				= (%facial_fear01);
	level.scr_face["truckriders"]["idle_a4"][2]				= (%facial_fear02);
	level.scr_face["truckriders"]["idle_a4"][3]				= (%facial_alert01);
	level.scr_face["truckriders"]["idle_a4"][4]				= (%facial_alert02);
                                                                        	
	level.scr_anim["truckriders"]["idle_a5"][0]				= (%trenches_truckride_idleA5);
	level.scr_face["truckriders"]["idle_a5"][0]				= (%facial_panic01);
	level.scr_face["truckriders"]["idle_a5"][1]				= (%facial_fear01);
	level.scr_face["truckriders"]["idle_a5"][2]				= (%facial_fear02);
	level.scr_face["truckriders"]["idle_a5"][3]				= (%facial_alert01);
	level.scr_face["truckriders"]["idle_a5"][4]				= (%facial_alert02);
                                                                        	
	level.scr_anim["truckriders"]["idle_a6"][0]				= (%trenches_truckride_idleA6);
	level.scr_face["truckriders"]["idle_a6"][0]				= (%facial_panic01);
	level.scr_face["truckriders"]["idle_a6"][1]				= (%facial_fear01);
	level.scr_face["truckriders"]["idle_a6"][2]				= (%facial_fear02);
	level.scr_face["truckriders"]["idle_a6"][3]				= (%facial_alert01);
	level.scr_face["truckriders"]["idle_a6"][4]				= (%facial_alert02);
                                                                        	
	level.scr_anim["truckriders"]["idle_a7"][0]				= (%trenches_truckride_idleA7);
	level.scr_face["truckriders"]["idle_a7"][0]				= (%facial_panic01);
	level.scr_face["truckriders"]["idle_a7"][1]				= (%facial_fear01);
	level.scr_face["truckriders"]["idle_a7"][2]				= (%facial_fear02);
	level.scr_face["truckriders"]["idle_a7"][3]				= (%facial_alert01);
	level.scr_face["truckriders"]["idle_a7"][4]				= (%facial_alert02);
                                                                        	
	level.scr_anim["truckriders"]["idle_a8"][0]				= (%trenches_truckride_idleA8);
	level.scr_face["truckriders"]["idle_a8"][0]				= (%facial_panic01);
	level.scr_face["truckriders"]["idle_a8"][1]				= (%facial_fear01);
	level.scr_face["truckriders"]["idle_a8"][2]				= (%facial_fear02);
	level.scr_face["truckriders"]["idle_a8"][3]				= (%facial_alert01);
	level.scr_face["truckriders"]["idle_a8"][4]				= (%facial_alert02);



                                                                        	
	// Truck Starts moving                                          	
	level.scr_anim["truckriders"]["start_movement_1"]			= (%trenches_truck_start1);
	level.scr_face["truckriders"]["start_movement_1"]			= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["start_movement_2"]			= (%trenches_truck_start2);
	level.scr_face["truckriders"]["start_movement_2"]			= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["start_movement_3"]			= (%trenches_truck_start3);
	level.scr_face["truckriders"]["start_movement_3"]			= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["start_movement_4"]			= (%trenches_truck_start4);
	level.scr_face["truckriders"]["start_movement_4"]			= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["start_movement_5"]			= (%trenches_truck_start5);
	level.scr_face["truckriders"]["start_movement_5"]			= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["start_movement_6"]			= (%trenches_truck_start6);
	level.scr_face["truckriders"]["start_movement_6"]			= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["start_movement_7"]			= (%trenches_truck_start7);
	level.scr_face["truckriders"]["start_movement_7"]			= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["start_movement_8"]			= (%trenches_truck_start8);
	level.scr_face["truckriders"]["start_movement_8"]			= (%facial_fear01);
                                                                        	
	// Point at Stuka                                               	
	level.scr_anim["truckriders"]["stuka_point_1"]				= (%trenches_truck_stuka_reaction1);
	level.scr_face["truckriders"]["stuka_point_1"]				= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["stuka_point_2"]				= (%trenches_truck_stuka_reaction2);
	level.scr_face["truckriders"]["stuka_point_2"]				= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["stuka_point_3"]				= (%trenches_truck_stuka_reaction3);
	level.scr_face["truckriders"]["stuka_point_3"]				= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["stuka_point_4"]				= (%trenches_truck_stuka_reaction4);
	level.scr_face["truckriders"]["stuka_point_4"]				= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["stuka_point_5"]				= (%trenches_truck_stuka_reaction5);
	level.scr_face["truckriders"]["stuka_point_5"]				= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["stuka_point_6"]				= (%trenches_truck_stuka_reaction6);
//	level.scrsound["truckriders"]["stuka_point_6"]				="misc_troop_ev08_01";
//	level.scr_face["truckriders"]["stuka_point_6"]				=(%f_trenches_anon_incoming);
                                                                        	
	level.scr_anim["truckriders"]["stuka_point_7"]				= (%trenches_truck_stuka_reaction7);
	level.scr_face["truckriders"]["stuka_point_7"]				= (%facial_fear01);
                                                                        	
	level.scr_anim["truckriders"]["stuka_point_8"]				= (%trenches_truck_stuka_reaction8);
	level.scr_face["truckriders"]["stuka_point_8"]				= (%facial_fear01);
	                                                                	
	// FLINCH                                                       	
	level.scr_anim["truckriders"]["truck_flinch_1"]				= (%trenches_truck_flinch1);
	level.scr_face["truckriders"]["truck_flinch_1"]				= (%facial_surprise02);
                                                                        	
	level.scr_anim["truckriders"]["truck_flinch_2"]				= (%trenches_truck_flinch2);
	level.scr_face["truckriders"]["truck_flinch_2"]				= (%facial_surprise02);
                                                                        	
	level.scr_anim["truckriders"]["truck_flinch_3"]				= (%trenches_truck_flinch3);
	level.scr_face["truckriders"]["truck_flinch_3"]				= (%facial_surprise02);
                                                                        	
	level.scr_anim["truckriders"]["truck_flinch_4"]				= (%trenches_truck_flinch4);
	level.scr_face["truckriders"]["truck_flinch_4"]				= (%facial_surprise01);
                                                                        	
	level.scr_anim["truckriders"]["truck_flinch_5"]				= (%trenches_truck_flinch5);
	level.scr_face["truckriders"]["truck_flinch_5"]				= (%facial_surprise01);
                                                                        	
	level.scr_anim["truckriders"]["truck_flinch_6"]				= (%trenches_truck_flinch6);
	level.scr_face["truckriders"]["truck_flinch_6"]				= (%facial_surprise02);
                                                                        	
	level.scr_anim["truckriders"]["truck_flinch_7"]				= (%trenches_truck_flinch7);
	level.scr_face["truckriders"]["truck_flinch_7"]				= (%facial_surprise01);
                                                                        	
	level.scr_anim["truckriders"]["truck_flinch_8"]				= (%trenches_truck_flinch8);
	level.scr_face["truckriders"]["truck_flinch_8"]				= (%facial_surprise01);

	// FLINCH During Truckride
	level.scr_anim["truckriders"]["truckride_flinch_1"]			= (%trenches_truckride_flinch1);
	level.scr_face["truckriders"]["truckride_flinch_1"]			= (%facial_surprise01);

	level.scr_anim["truckriders"]["truckride_flinch_2"]			= (%trenches_truckride_flinch2);
	level.scr_face["truckriders"]["truckride_flinch_2"]			= (%facial_surprise01);

	level.scr_anim["truckriders"]["truckride_flinch_3"]			= (%trenches_truckride_flinch3);
	level.scr_face["truckriders"]["truckride_flinch_3"]			= (%facial_surprise01);

	level.scr_anim["truckriders"]["truckride_flinch_4"]			= (%trenches_truckride_flinch4);
	level.scr_face["truckriders"]["truckride_flinch_4"]			= (%facial_surprise02);

	level.scr_anim["truckriders"]["truckride_flinch_5"]			= (%trenches_truckride_flinch5);
	level.scr_face["truckriders"]["truckride_flinch_5"]			= (%facial_surprise02);

	level.scr_anim["truckriders"]["truckride_flinch_6"]			= (%trenches_truckride_flinch6);
	level.scr_face["truckriders"]["truckride_flinch_6"]			= (%facial_surprise01);

	level.scr_anim["truckriders"]["truckride_flinch_7"]			= (%trenches_truckride_flinch7);
	level.scr_face["truckriders"]["truckride_flinch_7"]			= (%facial_surprise02);

	level.scr_anim["truckriders"]["truckride_flinch_8"]			= (%trenches_truckride_flinch8);
	level.scr_face["truckriders"]["truckride_flinch_8"]			= (%facial_surprise02);


	// END::Truckride section--------//

	// "Stukas… Keep your heads down!
	level.scr_anim["truckriders"]["stukas_head_down"]			=(%c_rs_trenches_anon_ev03_01);
	level.scrsound["truckriders"]["stukas_head_down"]			="misc_troop_ev03_01";
	level.scr_face["truckriders"]["stukas_head_down"]			=(%f_trenches_anon_ev03_01);

	// Oh my god… They took out the train!
	level.scr_anim["truckriders"]["train_dead"]				=(%c_rs_trenches_anon_ev03_02);
	level.scrsound["truckriders"]["train_dead"]				="misc_troop_ev03_02";
	level.scr_face["truckriders"]["train_dead"]				=(%f_trenches_anon_ev03_02);

//	level.scrsound["truckriders"]["better_than_us"]				="anon_better";
//	level.scr_face["truckriders"]["better_than_us"]				=(%f_trenches_anon_better);

	// Get us out of here! We're sitting ducks!
//	level.scrsound["truckriders"]["get_us_outta_here"]			="anon_troop_ev03_03";
//	level.scr_face["truckriders"]["get_us_outta_here"]			=(%f_trenches_anon_ev03_03);

	// Get Down!
//	level.scrsound["truckriders"]["get_down"]				="misc_troop_ev05_01";
//	level.scr_face["truckriders"]["get_down"]				=(%f_trenches_misc_troop_ev05_01);

	// Look Oooout!
	level.scrsound["truckriders"]["look_out"]				="misc_troop_ev05_02";
	level.scr_face["truckriders"]["look_out"]				=(%f_trenches_misc_troop_ev05_02);

	// Hang on!
	level.scrsound["truckriders"]["hang_on"]				="misc_troop_ev05_03";
	level.scr_face["truckriders"]["hang_on"]				=(%f_trenches_misc_troop_ev05_03);

	// Get us out of here!
	level.scrsound["truckriders"]["get_us_outta_here2"]			="misc_troop_ev05_04";
	level.scr_face["truckriders"]["get_us_outta_here2"]			=(%PegDay_facial_Friend1_01_incoming);

	// Incoming!
	level.scrsound["truckriders"]["incoming"]				="misc_troop_ev08_01";
	level.scr_face["truckriders"]["incoming"]				=(%f_trenches_anon_incoming);

	// They're coming back!!
	level.scr_anim["truckriders"]["coming_back"]				=(%c_rs_trenches_coming_back);
	level.scrsound["truckriders"]["coming_back"]				="coming_back";
	level.scr_face["truckriders"]["coming_back"]				=(%f_trenches_coming_back);

	// Once we clear this village we'll take up positions in the forward trenches.\
	level.scr_anim["truckriders"]["vass_lastman"]				=(%c_rs_trenches_vass_lastman);
	level.scrsound["truckriders"]["vass_lastman"]				="vass_lastman";
	level.scr_face["truckriders"]["vass_lastman"]				=(%f_trenches_vass_lastman);

	// How much farther do we have to go
//	level.scrsound["truckriders"]["boris_howfar"]				="boris_howfar";
//	level.scr_face["truckriders"]["boris_howfar"]				=(%f_trenches_boris_howfar);

	// Till we get there.
//	level.scr_anim["truckriders"]["vass_tillwe_getthere"]			=(%c_rs_trenches_vass_tillwe_getthere);
//	level.scrsound["truckriders"]["vass_tillwe_getthere"]			="vass_tillwe_getthere";
//	level.scr_face["truckriders"]["vass_tillwe_getthere"]			=(%f_trenches_vass_tillwe_getthere);

// END Train Riders ============================= //

// Climb on Truck =========================== //
	level.scr_anim["truckriders"]["run to truck"]				= (%stand_walk_combat_loop_01);
// END Climb on Truck =========================== //

// START:: Train Commissar ===============================//
	level.scr_anim["train_commissar"]["get_out_of_train"]			=(%line_officerA_stand_twitchB);
//	level.scr_face["train_commissar"]["get_out_of_train"]			=(%PegDay_facial_Friend1_01_incoming);
	level.scrsound["train_commissar"]["get_out_of_train"]			="train_comm";

	level.scr_anim["train_commissar"]["in_trenches"]			=(%line_officerA_waveB);
	level.scr_face["train_commissar"]["in_trenches"]			=(%PegDay_facial_Friend1_01_incoming);
//	level.scrsound["train_commissar"]["in_trenches"]			="gs_ant_ev01_02";

	// TRUCK IS FULL!
	level.scr_anim["train_commissar"]["truck_full"]				=(%c_rs_trenches_gs_ant_ev02_01);
	level.scr_notetrack["train_commissar"][0]["notetrack"]			= "gs_ant_ev02_01";
	level.scr_notetrack["train_commissar"][0]["dialogue"] 			= "gs_ant_ev02_01";
	level.scr_notetrack["train_commissar"][0]["facial"]			= (%f_trenches_gs_ant_ev02_01);

//	level.scr_face["train_commissar"]["truck_full"]				=(%f_trenches_gs_ant_ev02_01);
//	level.scrsound["train_commissar"]["truck_full"]				="gs_ant_ev02_01";
// END:: Train Commissar =================================//

// START:: Mill Commissar ===============================//
	level.scr_face["mill_commissar"]["battle_speech"]			=(%f_trenches_comm_ev17_01);
	level.scrsound["mill_commissar"]["battle_speech"]			="comm_ev17_01";
	level.scr_anim["mill_commissar"]["battle_speech_loop"][0]		=(%trenches_antonov_mill_speech);
	level.scr_anim["mill_commissar"]["open_mill_door"]			=(%trenches_antonov_mill_door);
// END:: Mill Commissar =================================//

// START:: Bloody Death Section ===========================//
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
// END:: Bloody Death Section ===========================//

// START:: Last Commissar ===============================//

	level.scr_anim["last_commissar"]["victory_speech"]			=(%c_rs_trenches_comm_ev19_01_speech);
	level.scr_face["last_commissar"]["victory_speech"]			=(%f_trenches_comm_ev19_01);
	level.scrsound["last_commissar"]["victory_speech"]			="comm_ev19_01";

	// Assemble.
	level.scrsound["last_commissar"]["comm_assemble"]			="comm_assemble";
	level.scr_face["last_commissar"]["comm_assemble"]			=(%PegDay_facial_Friend1_01_incoming);

	level.scr_anim["last_commissar"]["ride_loop"][0]			=(%c_rs_trenches_comm_ev19_01_ride);
	level.scr_anim["last_commissar"]["wait_loop"][0]			=(%c_rs_trenches_comm_ev19_01_wait);
	level.scr_anim["last_commissar"]["stop_trans"]				=(%c_rs_trenches_comm_ev19_01_stop);


// END:: Last Commissar =================================//

// START:: Tankguy ===============================//

	level.scrsound["tankguy"]["pinned_down"]				="pinned_down";
	level.scr_face["tankguy"]["pinned_down"]				=(%PegDay_facial_Friend1_01_incoming);

	level.scrsound["tankguy"]["help_me"]					="help_me";
	level.scr_face["tankguy"]["help_me"]					=(%PegDay_facial_Friend1_01_incoming);

// END:: Tankguy =================================//

//	level.scr_face["bunker_anims"]["ammo_pickup"]				= (%PegDay_facial_Friend1_01_incoming);
	level.scr_anim["bunker_anims"]["ammo_pickup"]				= (%c_rs_trenches_soldier_get_ammo);

	level.scr_anim["bunker_anims"]["ammo_pickup2"][0]				= (%c_rs_trenches_soldier_get_ammo);

	level.scr_anim["bunker_anims"]["idle"][0]				= (%c_waiting_stand_idle);
	level.scr_anim["bunker_anims"]["idleweight"][0]				= 3;
	level.scr_anim["bunker_anims"]["idle"][1]				= (%c_waiting_stand_flinchA);
	level.scr_anim["bunker_anims"]["idleweight"][1]				= 0.75;
	level.scr_anim["bunker_anims"]["idle"][2]				= (%c_waiting_stand_flinchB);
	level.scr_anim["bunker_anims"]["idleweight"][2]				= 0.75;
	level.scr_anim["bunker_anims"]["idle"][3]				= (%c_waiting_stand_scratch);
	level.scr_anim["bunker_anims"]["idleweight"][3]				= 0.5;

	level.scr_anim["bunker_anims"]["wall_idle"][0]				= (%c_waiting_wall_idle);
	level.scr_anim["bunker_anims"]["wall_idleweight"][0]			= 3;
	level.scr_anim["bunker_anims"]["wall_idle"][1]				= (%c_waiting_wall_dustoff);
	level.scr_anim["bunker_anims"]["wall_idleweight"][1]			= 0.5;
	level.scr_anim["bunker_anims"]["wall_idle"][2]				= (%c_waiting_wall_inspectgun);
	level.scr_anim["bunker_anims"]["wall_idleweight"][2]			= 0.5;
	level.scr_anim["bunker_anims"]["wall_idle"][3]				= (%c_waiting_wall_flinchA);
	level.scr_anim["bunker_anims"]["wall_idleweight"][3]			= 0.75;
	level.scr_anim["bunker_anims"]["wall_idle"][4]				= (%c_waiting_wall_flinchB);
	level.scr_anim["bunker_anims"]["wall_idleweight"][4]			= 0.75;

//	maps\trenches_anim::chestguy();
//	maps\trenches_anim::sideguy();
//	maps\trenches_anim::neckguy();
//	maps\trenches_anim::groinguy();
	maps\trenches_anim::bullhorn_commissar();
	maps\trenches_anim::bullhorn_commissar_truck();
	maps\trenches_anim::lineofficer_right();
	maps\trenches_anim::lineofficer_left();
	maps\trenches_anim::german_drones();
	maps\trenches_anim::allied_drones();
	maps\trenches_anim::truck_drones();
	maps\trenches_anim::mill_door();
	maps\trenches_anim::anon_trooper();
	maps\trenches_anim::train_dummy();
}

anon_trooper()
{
	// DOWN!!!
	level.scrsound["anon_trooper"]["anon_down"]					="anon_down";
	level.scr_face["anon_trooper"]["anon_down"]					=(%f_trenches_anon_down);

	// Incoming Panzer Tank!!!
	level.scrsound["anon_trooper"]["anon_inc_panzer"]				="anon_inc_panzer";
	level.scr_face["anon_trooper"]["anon_inc_panzer"]				=(%PegDay_facial_Friend1_01_incoming);

	// (Mg42 FUN) They're coming! Drive them back!
	level.scrsound["anon_trooper"]["anon_driveback"]				="anon_driveback";
	level.scr_face["anon_trooper"]["anon_driveback"]				=(%PegDay_facial_Friend1_01_incoming);

	// Our tanks-Are here!
	level.scrsound["anon_trooper"]["anon_tankshere"]				="anon_tankshere";
	level.scr_face["anon_trooper"]["anon_tankshere"]				=(%PegDay_facial_Friend1_01_incoming);
}

// MikeD: Taken from Stalingrad, should change later.
#using_animtree("trenches_bullhorn_commissar");
bullhorn_commissar()
{
	level.scr_animtree["bullhorn_commissar"] = #animtree;
	level.scr_anim["bullhorn_commissar"]["idle"][0]				= (%c_rs_trenches_comm_idle);
	level.scr_anim["bullhorn_commissar"]["idle"][1]				= (%c_rs_trenches_comm_idle_twitch);
	level.scr_anim["bullhorn_commissar"]["idle"][2]				= (%c_rs_trenches_comm_idle_twitch);

	level.scr_anim["bullhorn_commissar"]["megaphone_talk1"]			= (%c_rs_trenches_comm_ev06_01);
	level.scr_face_hack["bullhorn_commissar"]["megaphone_talk1"]		= (%f_trenches_comm_ev06_01);
	// Since we can only have 1 notetrack, we hack it in the level.gsc

	level.scr_anim["bullhorn_commissar"]["megaphone_talk2"]			= (%c_rs_trenches_comm_ev06_02);
	level.scr_face_hack["bullhorn_commissar"]["megaphone_talk2"]		= (%f_trenches_comm_ev06_02);
	// Since we can only have 1 notetrack, we hack it in the level.gsc

	level.scr_anim["bullhorn_commissar"]["megaphone_talk3"]			= (%c_rs_trenches_comm_ev06_03);
	level.scr_face_hack["bullhorn_commissar"]["megaphone_talk3"]		= (%f_trenches_comm_ev06_03);
	// Since we can only have 1 notetrack, we hack it in the level.gsc

	level.scr_anim["bullhorn_commissar"]["megaphone_talk4"]			= (%c_rs_trenches_comm_ev06_04);
	level.scr_face_hack["bullhorn_commissar"]["megaphone_talk4"]		= (%f_trenches_comm_ev06_04);
	// Since we can only have 1 notetrack, we hack it in the level.gsc


//	level.scr_anim["bullhorn_commissar"]["megaphone_talk1"]			= (%megaphonecommissar_fullbody42);
//	level.scr_face["bullhorn_commissar"]["megaphone_talk1"]			= (%facial_megaphonecommissar_line_42);
//	level.scrsound["bullhorn_commissar"]["megaphone_talk1"]			= "comm_ev06_01";

//	level.scr_anim["bullhorn_commissar"]["megaphone_talk2"]			= (%megaphonecommissar_fullbody42);
//	level.scr_face["bullhorn_commissar"]["megaphone_talk2"]			= (%facial_megaphonecommissar_line_42);
//	level.scrsound["bullhorn_commissar"]["megaphone_talk2"]			= "comm_ev06_02";
//
//	level.scr_anim["bullhorn_commissar"]["megaphone_talk3"]			= (%megaphonecommissar_fullbody42);
//	level.scr_face["bullhorn_commissar"]["megaphone_talk3"]			= (%f_trenches_comm_ev06_03);
//	level.scrsound["bullhorn_commissar"]["megaphone_talk3"]			= "comm_ev06_03";
//
//	level.scr_anim["bullhorn_commissar"]["megaphone_talk4"]			= (%megaphonecommissar_fullbody42);
//	level.scr_face["bullhorn_commissar"]["megaphone_talk4"]			= (%f_trenches_comm_ev06_04);
//	level.scrsound["bullhorn_commissar"]["megaphone_talk4"]			= "comm_ev06_04";

	level.scr_character["bullhorn_commissar"] = character\RussianArmyOfficer_shout2 ::main;
}

#using_animtree("trenches_bullhorn_commissar");
bullhorn_commissar_truck()
{
	level.scr_animtree["truck_commissar"] = #animtree;
	level.scr_anim["truck_commissar"]["idle"][0]				= (%c_rs_trenches_comm_idle);
	level.scr_anim["truck_commissar"]["idle"][1]				= (%c_rs_trenches_comm_idle_twitch);
	level.scr_anim["truck_commissar"]["idle"][2]				= (%c_rs_trenches_comm_idle_twitch);

	// When the truck_commissar talks.
	level.scr_notetrack["truck_commissar"][0]["notetrack"]			= "comm_ev01_01";
	level.scr_notetrack["truck_commissar"][0]["dialogue"] 			= "comm_ev01_01";
	level.scr_notetrack["truck_commissar"][0]["facial"]			= (%f_trenches_comm_ev01_01);

	level.scr_anim["truck_commissar"]["comm_ev01_01"]			= (%c_rs_trenches_comm_ev01_01);
//	level.scr_face["truck_commissar"]["comm_ev01_01"]			= (%f_trenches_comm_ev01_01);
//	level.scrsound["truck_commissar"]["comm_ev01_01"]			= "comm_ev01_01";

	level.scr_anim["truck_commissar"]["death"][0]				= (%death_explosion_back13);
	level.scr_anim["truck_commissar"]["death"][1]				= (%death_explosion_forward13);     
	level.scr_anim["truck_commissar"]["death"][2]				= (%death_explosion_left11);  
	level.scr_anim["truck_commissar"]["death"][3]				= (%death_explosion_right13);        
	level.scr_anim["truck_commissar"]["death"][4]				= (%death_explosion_up10);  


	level.scr_character["truck_commissar"] = character\RussianArmyOfficer_shout2 ::main;
}

#using_animtree("trenches_stuka");
stuka_crash()
{
	level.scr_animtree["stuka_crash"] = #animtree;
	level.scr_anim["stuka_crash"]["path"]					= (%kursk_stuka_crash);
}

// Wave his hand to the left.
#using_animtree("trenches_bunkerguy1");
lineofficer_left()
{	
	level.scr_animtree["lineofficer_left"] = #animtree;
	level.scr_anim["lineofficer_left"]["idle"][0]				= (%line_officerA_stand_twitchB);
	level.scr_anim["lineofficer_left"]["idleweight"][0]			= 0.5;
	level.scr_anim["lineofficer_left"]["idle"][1]				= (%line_officer_stand_idle);
	level.scr_face["lineofficer_left"]["idle"][1]				= (%f_trenches_comm_ev07_01);
	level.scrsound["lineofficer_left"]["idle"][1]				= "comm_ev07_01";
	level.scr_anim["lineofficer_left"]["idleweight"][1]			= 2;
	level.scr_anim["lineofficer_left"]["idle"][2]				= (%line_officerA_stand_twitchA);
	level.scr_face["lineofficer_left"]["idle"][2]				= (%f_trenches_comm_ev07_03);
	level.scrsound["lineofficer_left"]["idle"][2]				= "comm_ev07_03";
	level.scr_anim["lineofficer_left"]["idleweight"][2]			= 2;
	level.scr_anim["lineofficer_left"]["idle"][3]				= (%line_officerA_waveB);
	level.scr_face["lineofficer_left"]["idle"][3]				= (%f_trenches_comm_ev07_02);
	level.scrsound["lineofficer_left"]["idle"][3]				= "comm_ev07_02";
	level.scr_anim["lineofficer_left"]["idleweight"][3]			= 2;
	level.scr_anim["lineofficer_left"]["walk"]				= (%leaderwalk_cocky_idle);
	level.scr_anim["lineofficer_left"]["fire"]				= (%line_officerA_shoot);

	level.scr_character["lineofficer_left"] = character\RussianArmyOfficer ::main;

// RADIO MAN SECTION
	level.scr_character["radio_man"] = character\RussianArmyOfficer ::main;
	level.scr_animtree["radio_man"] = #animtree;
	level.scr_anim["radio_man"]["radio_loop"]				= (%c_rs_trenches_radio_operator_idle);

}

// Wave his hand to the right.
#using_animtree("trenches_ammoguy");
lineofficer_right()
{	
	level.scr_animtree["lineofficer_right"] = #animtree;
	level.scr_anim["lineofficer_right"]["idle"][0]				= (%c_rs_trenches_sergeant_idleA);
	level.scr_anim["lineofficer_right"]["idle"][1]				= (%c_rs_trenches_sergeant_idleB);
	level.scr_anim["lineofficer_right"]["idle"][2]				= (%c_rs_trenches_sergeant_idle_twitch);
//	level.scr_anim["lineofficer_right"]["idleweight"][2]			= 0.5;
//	level.scr_anim["lineofficer_right"]["idle"][3]				= (%line_officerA_wave);
//	level.scr_anim["lineofficer_right"]["idleweight"][3]			= 1;
//	level.scr_anim["lineofficer_right"]["walk"]				= (%leaderwalk_cocky_idle);
//	level.scr_anim["lineofficer_right"]["fire"]				= (%line_officerA_shoot);
                                                                        	
	level.scr_face["lineofficer_right"]["idle"][0]				= (%facial_alert02);
	level.scr_face["lineofficer_right"]["idle"][1]				= (%facial_alert01);
	level.scr_face["lineofficer_right"]["idle"][2]				= (%facial_alert01);
//	level.scr_face["lineofficer_right"]["idle"][3]				= (%facial_alert02);
                                                                        	
	// Line officer, "Random Lines"                                 	
	level.scrsound["lineofficer_right"]["fight_bravely"]			="gs_bunker_ev07_01";
	level.scr_face["lineofficer_right"]["fight_bravely"]			=(%f_trenches_gs_bunker_ev07_01);
	level.scr_anim["lineofficer_right"]["fight_bravely"]			=(%c_rs_trenches_sergeant_give_ammo);

	level.scrsound["lineofficer_right"]["proud"]				="gs_bunker_ev07_02";
	level.scr_face["lineofficer_right"]["proud"]				=(%f_trenches_gs_bunker_ev07_02);
	level.scr_anim["lineofficer_right"]["proud"]				=(%c_rs_trenches_sergeant_give_ammo);

	level.scrsound["lineofficer_right"]["everyshot_count"]			="gs_bunker_ev07_03";
	level.scr_face["lineofficer_right"]["everyshot_count"]			=(%f_trenches_gs_bunker_ev07_03);
	level.scr_anim["lineofficer_right"]["everyshot_count"]			=(%c_rs_trenches_sergeant_give_ammo);

	level.scrsound["lineofficer_right"]["fascious"]				="gs_bunker_ev07_04";
	level.scr_anim["lineofficer_right"]["fascious"]				=(%c_rs_trenches_sergeant_give_ammo);

	level.scr_notetrack["lineofficer_right"][0]["notetrack"]		= "attach";
	level.scr_notetrack["lineofficer_right"][0]["selftag"]			= "TAG_WEAPON_RIGHT";
	level.scr_notetrack["lineofficer_right"][0]["attach model"]		= "xmodel/stalingrad_clips";

	level.scr_notetrack["lineofficer_right"][1]["notetrack"]		= "detach";
	level.scr_notetrack["lineofficer_right"][1]["selftag"]			= "TAG_WEAPON_RIGHT";
	level.scr_notetrack["lineofficer_right"][1]["detach model"]		= "xmodel/stalingrad_clips";

//c_rs_trenches_sergeant_idleA
//c_rs_trenches_sergeant_idleB
//c_rs_trenches_sergeant_idle_twitch
//c_rs_trenches_sergeant_give_ammo
                                                                        	
	level.scr_character["lineofficer_right"] 				= character\RussianArmyOfficer_ammogiver ::main;
}

#using_animtree("trenches_dummies");
german_drones()
{
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
	                                                                	
	level.scr_character["drone"][0] 					= character\fallschirmjager_soldier ::main;
	level.scr_character["drone"][1] 					= character\fallschirmjager_soldier_MP40b ::main;
	level.scr_character["drone"][2] 					= character\fallschirmjager_soldier_K98a ::main;
                                                                        	
	level.scr_anim["drone"]["run"][0]					= (%sprint1_loop);
	level.scr_anim["drone"]["run"][1]					= (%stand_shoot_run_forward);
	level.scr_anim["drone"]["run"][2]					= (%crouchrun_loop_forward_1);
                                                                        	
	level.scr_anim["drone"]["death"][0]					= (%death_run_forward_crumple);
	level.scr_anim["drone"]["death"][1]					= (%crouchrun_death_drop);
	level.scr_anim["drone"]["death"][2]					= (%crouchrun_death_crumple);
	level.scr_anim["drone"]["death"][3]					= (%death_run_onfront);
	level.scr_anim["drone"]["death"][4]					= (%death_run_onleft);
}

#using_animtree("trenches_dummies");
allied_drones()
{
// START::Event1 Dummies Section ------------//
	level.scr_character["event1_dummies"][0] 				= character\RussianArmy ::main;
	level.scr_character["event1_dummies"][1] 				= character\RussianArmy2 ::main;
	level.scr_character["event1_dummies"][2] 				= character\RussianArmyMosin1 ::main;
	
	level.scr_anim["event1_dummies"]["move_forward"][0]			= (%sprint1_loop);
	level.scr_anim["event1_dummies"]["move_forward"][1]			= (%stand_shoot_run_forward);
	level.scr_anim["event1_dummies"]["move_forward"][2]			= (%crouchrun_loop_forward_1);

	level.scr_anim["event1_dummies"]["death"][0]				= (%death_explosion_back13);
	level.scr_anim["event1_dummies"]["death"][1]				= (%death_explosion_forward13);     
	level.scr_anim["event1_dummies"]["death"][2]				= (%death_explosion_left11);  
	level.scr_anim["event1_dummies"]["death"][3]				= (%death_explosion_right13);        
	level.scr_anim["event1_dummies"]["death"][4]				= (%death_explosion_up10);         

// END::Event1 Dummies Section ------------//

// START::Event1 Dummies2 Section ------------//
	level.scr_character["event1_dummies2"][0] 				= character\RussianArmy ::main;
	level.scr_character["event1_dummies2"][1] 				= character\RussianArmy2 ::main;
	level.scr_character["event1_dummies2"][2] 				= character\RussianArmyMosin1 ::main;
	
	level.scr_anim["event1_dummies2"]["move_forward"][0]			= (%sprint1_loop);
	level.scr_anim["event1_dummies2"]["move_forward"][1]			= (%stand_shoot_run_forward);
	level.scr_anim["event1_dummies2"]["move_forward"][2]			= (%crouchrun_loop_forward_1);

// END::Event1 Dummies2 Section ------------//

// START::Event2 Dummies Section ------------//
	level.scr_character["event2_dummies"][0] 				= character\RussianArmy ::main;
	level.scr_character["event2_dummies"][1] 				= character\RussianArmy2 ::main;
	level.scr_character["event2_dummies"][2] 				= character\RussianArmyMosin1 ::main;
	
	level.scr_anim["event2_dummies"]["move_forward"][0]			= (%sprint1_loop);
	level.scr_anim["event2_dummies"]["move_forward"][1]			= (%stand_shoot_run_forward);
	level.scr_anim["event2_dummies"]["move_forward"][2]			= (%crouchrun_loop_forward_1);

// END::Event2 Dummies Section ------------//

// START::Event2 Dummies Section ------------//
	level.scr_character["event4_wounded"][0] 				= character\RussianArmyWoundedTunic ::main;
	level.scr_character["event4_wounded"][1] 				= character\RussianArmyDead2 ::main;
	level.scr_character["event4_wounded"][2] 				= character\RussianArmyDead1 ::main;

	level.scr_anim["event4_wounded"]["move_forward"][0]			= (%soldierwalk_dazed_idle);
	level.scr_anim["event4_wounded"]["move_forward"][1]			= (%soldierwalk_dazed_twitch);
	level.scr_anim["event4_wounded"]["move_forward"][2]			= (%soldierwalk_dazed_idle);
	level.scr_anim["event4_wounded"]["move_forward"][3]			= (%soldierwalk_dazed_twitch);
	level.scr_anim["event4_wounded"]["move_forward"][4]			= (%soldierwalk_dazed_idle);
	level.scr_anim["event4_wounded"]["move_forward"][5]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][6]			= (%patrolwalk_bounce);
	level.scr_anim["event4_wounded"]["move_forward"][7]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][8]			= (%patrolwalk_swagger);
	level.scr_anim["event4_wounded"]["move_forward"][9]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][10]			= (%soldierwalk_dazed_idle);
	level.scr_anim["event4_wounded"]["move_forward"][11]			= (%patrolwalk_tired);
	level.scr_anim["event4_wounded"]["move_forward"][12]			= (%soldierwalk_dazed_twitch);
	level.scr_anim["event4_wounded"]["move_forward"][13]			= (%patrolwalk_bounce);
	level.scr_anim["event4_wounded"]["move_forward"][14]			= (%soldierwalk_dazed_idle);
	level.scr_anim["event4_wounded"]["move_forward"][15]			= (%soldierwalk_dazed_twitch);
	level.scr_anim["event4_wounded"]["move_forward"][16]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][17]			= (%soldierwalk_dazed_idle);
	level.scr_anim["event4_wounded"]["move_forward"][18]			= (%patrolwalk_swagger);
	level.scr_anim["event4_wounded"]["move_forward"][19]			= (%patrolwalk_tired);
	level.scr_anim["event4_wounded"]["move_forward"][20]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][21]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][22]			= (%patrolwalk_bounce);
	level.scr_anim["event4_wounded"]["move_forward"][23]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][24]			= (%soldierwalk_dazed_idle);
	level.scr_anim["event4_wounded"]["move_forward"][25]			= (%soldierwalk_dazed_twitch);
	level.scr_anim["event4_wounded"]["move_forward"][26]			= (%soldierwalk_dazed_idle);
	level.scr_anim["event4_wounded"]["move_forward"][27]			= (%soldierwalk_dazed_twitch);
	level.scr_anim["event4_wounded"]["move_forward"][28]			= (%soldierwalk_dazed_idle);
	level.scr_anim["event4_wounded"]["move_forward"][29]			= (%patrolwalk_swagger);
	level.scr_anim["event4_wounded"]["move_forward"][30]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][31]			= (%patrolwalk_tired);
	level.scr_anim["event4_wounded"]["move_forward"][32]			= (%patrolwalk_bounce);
	level.scr_anim["event4_wounded"]["move_forward"][33]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][34]			= (%patrolwalk_swagger);
	level.scr_anim["event4_wounded"]["move_forward"][35]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][36]			= (%patrolwalk_tired);
	level.scr_anim["event4_wounded"]["move_forward"][37]			= (%patrolwalk_bounce);
	level.scr_anim["event4_wounded"]["move_forward"][38]			= (%patrolwalk_swagger);
	level.scr_anim["event4_wounded"]["move_forward"][39]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][40]			= (%patrolwalk_tired);
	level.scr_anim["event4_wounded"]["move_forward"][41]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][42]			= (%patrolwalk_bounce);
	level.scr_anim["event4_wounded"]["move_forward"][43]			= (%patrolwalk_swagger);
	level.scr_anim["event4_wounded"]["move_forward"][44]			= (%c_limpA);
	level.scr_anim["event4_wounded"]["move_forward"][45]			= (%patrolwalk_bounce);
	level.scr_anim["event4_wounded"]["move_forward"][46]			= (%c_limpA);   
	level.scr_anim["event4_wounded"]["move_forward"][47]			= (%c_limpA);    

// END::Event2 Dummies Section ------------//

// START::Event3 Village Section ------------//
	level.scr_character["event3_village_dummies"][0] 			= character\RussianArmy ::main;
	level.scr_character["event3_village_dummies"][1] 			= character\RussianArmy2 ::main;
	level.scr_character["event3_village_dummies"][2] 			= character\RussianArmyMosin1 ::main;

	level.scr_anim["event3_village_dummies"]["move_forward"][0]		= (%sprint1_loop);
	level.scr_anim["event3_village_dummies"]["move_forward"][1]		= (%combatrun_forward_1);
	level.scr_anim["event3_village_dummies"]["move_forward"][2]		= (%combatrun_forward_2);
	level.scr_anim["event3_village_dummies"]["move_forward"][3]		= (%crouchrun_loop_forward_1);
// END::Event3 Village Dummies Section ------------//

// START::Event3 Prisoner Section ------------//
	level.scr_character["event3_prisoner_dummies"][0] 			= character\RussianArmy ::main;
	level.scr_character["event3_prisoner_dummies"][1] 			= character\RussianArmy2 ::main;
	level.scr_character["event3_prisoner_dummies"][2] 			= character\RussianArmyMosin1 ::main;

	level.scr_anim["event3_prisoner_dummies"]["move_forward"][0]		= (%c_prisoner_walk_A);
	level.scr_anim["event3_prisoner_dummies"]["move_forward"][1]		= (%c_prisoner_walk_B);
	level.scr_anim["event3_prisoner_dummies"]["move_forward"][2]		= (%stand_walk_combat_loop_01);
	level.scr_anim["event3_prisoner_dummies"]["move_forward"][3]		= (%c_prisoner_walk_B);
	level.scr_anim["event3_prisoner_dummies"]["move_forward"][4]		= (%c_prisoner_walk_A);
	level.scr_anim["event3_prisoner_dummies"]["move_forward"][5]		= (%c_prisoner_walk_B);
	level.scr_anim["event3_prisoner_dummies"]["move_forward"][6]		= (%stand_walk_combat_loop_02);
// END::Event3 Prisoner Dummies Section ------------//
}

#using_animtree("trenches_truck_dummies");
truck_drones()
{
// START::Event1 Truck Dummies Section ------------//
	level.scr_character["event1_truck_dummies"][0] 				= character\RussianArmy ::main;
	level.scr_character["event1_truck_dummies"][1] 				= character\RussianArmy2 ::main;
	level.scr_character["event1_truck_dummies"][2] 				= character\RussianArmyMosin1 ::main;

	level.scr_anim["event1_truck_dummies"]["move_forward"][0]		= (%sprint1_loop);
	level.scr_anim["event1_truck_dummies"]["move_forward"][1]		= (%stand_shoot_run_forward);
	level.scr_anim["event1_truck_dummies"]["move_forward"][2]		= (%crouchrun_loop_forward_1);

	level.scr_anim["event1_truck_dummies"]["death"][0]			= (%c_death_explosion_back13_down56units);
	level.scr_anim["event1_truck_dummies"]["death"][1]			= (%c_death_explosion_forward13_down56units);     
	level.scr_anim["event1_truck_dummies"]["death"][2]			= (%c_death_explosion_left11_down56units);  
	level.scr_anim["event1_truck_dummies"]["death"][3]			= (%c_death_explosion_right13_down56units);        
	level.scr_anim["event1_truck_dummies"]["death"][4]			= (%c_death_explosion_up10_down56units);  

	level.scr_anim["event1_truck_dummies"]["idle"][0]			= (%stand_alert_1);
	level.scr_anim["event1_truck_dummies"]["idle"][1]			= (%stand_alert_2);
	level.scr_anim["event1_truck_dummies"]["idle"][2]			= (%stand_alert_3);

	level.scr_anim["event1_truck_dummies"]["climb"][0]			=(%c_br_sicily1_climbtruck_guy1);
	level.scr_anim["event1_truck_dummies"]["climb"][1]			=(%trenches_climbingontruck2);
	level.scr_anim["event1_truck_dummies"]["climb"][2]			=(%trenches_climbingontruck3);
	level.scr_anim["event1_truck_dummies"]["climb"][3]			=(%c_br_sicily1_climbtruck_guy4);
	level.scr_anim["event1_truck_dummies"]["climb"][4]			=(%c_br_sicily1_climbtruck_guy5);
	level.scr_anim["event1_truck_dummies"]["climb"][5]			=(%c_br_sicily1_climbtruck_guy6);
	level.scr_anim["event1_truck_dummies"]["climb"][6]			=(%trenches_climbingontruck7);
	level.scr_anim["event1_truck_dummies"]["climb"][7]			=(%trenches_climbingontruck8);

	level.scr_anim["event1_truck_dummies"]["sicily1_idle1"]			= (%c_br_sicily1_idletruck_guy1);
	level.scr_anim["event1_truck_dummies"]["sicily1_idle4"]			= (%c_br_sicily1_idletruck_guy4);
	level.scr_anim["event1_truck_dummies"]["sicily1_idle5"]			= (%c_br_sicily1_idletruck_guy5);
	level.scr_anim["event1_truck_dummies"]["sicily1_idle6"]			= (%c_br_sicily1_idletruck_guy6);
// END::Event3 Truck Dummies Section ------------//
}

#using_animtree("trenches_mill_door");
mill_door()
{
		level.scr_animtree["mill_door"] 				= #animtree;
		level.scr_anim["mill_door"]["open_mill_door"]			=(%trenches_mill_door);
}

#using_animtree("trenches_dummies");
train_dummy()
{
		level.scr_animtree["train_dummy"] 			= #animtree;
		level.scr_anim["train_dummy"]["start"]			=(%trenches_opening_dummies);
}