#using_animtree("generic_human");
main()
{
	maps\kharkov2_anim::Vassili();
	maps\kharkov2_anim::Antonov();
	maps\kharkov2_anim::Miesha();
	maps\kharkov2_anim::Falling_Debris();
	maps\kharkov2_anim::Group2_Commander();
	maps\kharkov2_anim::Drones();
	maps\kharkov2_anim::Backward_Drones();
	maps\kharkov2_anim::Drone_Paths();
	maps\kharkov2_anim::Engineers();
	maps\kharkov2_anim::Train_Crash();
	maps\kharkov2_anim::Anon_Trooper();
	maps\kharkov2_anim::Commissar();
	maps\kharkov2_anim::smart_bomb();
	maps\kharkov2_anim::Flagger();
}

Vassili()
{
	level.scr_anim["vassili"]["vassili_flak"]			= (%c_rs_kharkov2_vassili_flak);
	level.scr_face["vassili"]["vassili_flak"]			= (%f_kharkov2_vassili_flak);
	level.scrsound["vassili"]["vassili_flak"]			= "vassili_flak";

//	level.scr_face["vassili"]["incoming_stuka"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["vassili"]["incoming_stuka"]			= "miesha_bombers";
}

Group2_Commander()
{
	level.scr_anim["group2_commander"]["event8_attack"]		= (%c_rs_kharkov2_comm_attack);
	level.scr_face["group2_commander"]["event8_attack"]		= (%f_kharkov2_comm_attack);
	level.scrsound["group2_commander"]["event8_attack"]		= "comm_attack";
}

Antonov()
{
	level.scr_anim["antonov"]["comm_attack"]			= (%c_rs_kharkov2_comm_attack);
	level.scr_face["antonov"]["comm_attack"]			= (%f_kharkov2_comm_attack);
	level.scrsound["antonov"]["comm_attack"]			= "comm_attack";

	level.scr_anim["antonov"]["antonov_flank_right"]		= (%c_rs_kharkov2_antonov_flank_right);
	level.scr_face["antonov"]["antonov_flank_right"]		= (%f_kharkov2_antonov_flank_right);
	level.scrsound["antonov"]["antonov_flank_right"]		= "antonov_flank_right";

	// This section is for when Antonov and the player run from cover to cover.
	level.scr_anim["antonov"]["event9_run1"]			= (%c_rs_kharkov2_ant_run1);
	level.scr_face["antonov"]["event9_run1"]			= (%f_kharkov2_ant_run1);
	level.scrsound["antonov"]["event9_run1"]			= "ant_run1";

//	level.scr_anim["antonov"]["event9_run2"]			= (%c_rs_kharkov2_ant_run2);
	level.scr_face["antonov"]["event9_run2"]			= (%f_kharkov2_ant_run2);
	level.scrsound["antonov"]["event9_run2"]			= "ant_run2";

	level.scr_anim["antonov"]["event9_run2_coverloop"][0]		= (%cornerb_crouch_alert_idle_right);
	level.scr_anim["antonov"]["event9_run2_coverloopweight"][0]	= 2.0;
	level.scr_anim["antonov"]["event9_run2_coverloop"][1]		= (%cornerb_crouch_alert_look_right);
	level.scr_anim["antonov"]["event9_run2_coverloopweight"][1]	= 1.0;
                                                                                                               
	level.scr_anim["antonov"]["event9_run3"]		 	= (%c_rs_kharkov2_ant_run3);           
	level.scr_face["antonov"]["event9_run3"]		 	= (%f_kharkov2_ant_run3);              
	level.scrsound["antonov"]["event9_run3"]		 	= "ant_run3";                          
                                                                                                             
	level.scr_anim["antonov"]["event9_run4"]		 	= (%c_rs_kharkov2_ant_run4);           
	level.scr_face["antonov"]["event9_run4"]		 	= (%f_kharkov2_ant_run4);
	level.scrsound["antonov"]["event9_run4"]		 	= "ant_run4";
                                                           
	level.scr_face["antonov"]["event9_run5"]		 	= (%f_kharkov2_ant_run5);
	level.scrsound["antonov"]["event9_run5"]		 	= "ant_run5";
                                                           
//	level.scr_face["antonov"]["event9_run5"]		 	= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["antonov"]["event9_run5"]		 	= "ant_run5";
                                                           
	level.scr_anim["antonov"]["ant_radio_now"]		 	= (%c_rs_kharkov2_ant_radio_now);
	level.scr_face["antonov"]["ant_radio_now"]		 	= (%f_kharkov2_ant_radio_now);
	level.scrsound["antonov"]["ant_radio_now"]		 	= "ant_radio_now";
                                                           
	level.scr_face["antonov"]["ant_engineers1"]		 	= (%f_kharkov2_ant_engineers1);
	level.scrsound["antonov"]["ant_engineers1"]		 	= "ant_engineers1";
                                                           
	level.scr_face["antonov"]["ant_engineers2"]		 	= (%f_kharkov2_ant_engineers2
);
	level.scrsound["antonov"]["ant_engineers2"]		 	= "ant_engineers2";
                                                           
	level.scr_face["antonov"]["ant_engineers3"]		 	= (%f_kharkov2_ant_engineers3);
	level.scrsound["antonov"]["ant_engineers3"]		 	= "ant_engineers3";
                                                           
	level.scr_anim["antonov"]["ant_cover_engineers"]	 	= (%c_rs_kharkov2_ant_cover_engineers);
	level.scr_face["antonov"]["ant_cover_engineers"]	 	= (%f_kharkov2_ant_cover_engineers);
	level.scrsound["antonov"]["ant_cover_engineers"]	 	= "ant_cover_engineers";
                                                           
	level.scr_face["antonov"]["good_shooting"]		 	= (%f_kharkov2_good_shooting);
	level.scrsound["antonov"]["good_shooting"]		 	= "good_shooting";
                                                           
	level.scr_face["antonov"]["antonov_stop_chatter"]	 	= (%f_kharkov2_antonov_stop_chatter);
	level.scrsound["antonov"]["antonov_stop_chatter"]	 	= "antonov_stop_chatter";
                                                           
	level.scr_face["antonov"]["antonov_dammit"]		 	= (%f_kharkov2_antonov_dammit);
	level.scrsound["antonov"]["antonov_dammit"]		 	= "antonov_dammit";
                                                           
	level.scr_face["antonov"]["antonov_another"]		 	= (%f_kharkov2_antonov_another);
	level.scrsound["antonov"]["antonov_another"]		 	= "antonov_another";
                                                           
	level.scr_face["antonov"]["antonov_miesha"]		 	= (%f_kharkov2_antonov_miesha);
	level.scrsound["antonov"]["antonov_miesha"]		 	= "antonov_miesha";
                                                           
	level.scr_face["antonov"]["antonov_yes"]		 	= (%f_kharkov2_antonov_yes);
	level.scrsound["antonov"]["antonov_yes"]		 	= "antonov_yes";
                                                           
	// After the engineers make it.                    
//	level.scr_face["antonov"]["event9_good_shooting"]	 	= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["antonov"]["event9_good_shooting"]	 	= "ant_good_shooting";
                                                           
	level.scr_anim["antonov"]["ant_get_moving"]		 	= (%c_rs_kharkov2_ant_get_moving);
	level.scr_face["antonov"]["ant_get_moving"]		 	= (%f_kharkov2_antonov_get_moving);
	level.scrsound["antonov"]["ant_get_moving"]		 	= "ant_get_moving";
                                                           
	level.scr_face["antonov"]["antonov_keep_moving2"]	 	= (%f_kharkov2_antonov_keep_moving2);
	level.scrsound["antonov"]["antonov_keep_moving2"]	 	= "antonov_keep_moving2";
                                                           
	level.scr_face["antonov"]["heads_up"]			 	= (%f_kharkov2_heads_up);
	level.scrsound["antonov"]["heads_up"]			 	= "heads_up";
                                                           
	// After event9_he111                              
//	level.scr_face["antonov"]["event10_trans"]		 	= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["antonov"]["event10_trans"]		 	= "ant_get_moving";
}                                                          
                                                           
Miesha()                                                   
{                                                          
	// Radio Chatting.                                 
	level.scr_face["miesha"]["blah_blah"]				="none";
	level.scr_anim["miesha"]["radio_trans_in"]			=(%c_rs_kharkov1_radioA_in);
	level.scr_anim["miesha"]["radio_trans_out"]			=(%c_rs_kharkov1_radioA_out);
	level.scr_anim["miesha"]["radio_wait"][0]			=(%c_rs_kharkov1_radioA_wait);
	level.scr_anim["miesha"]["radio_trans_to_talk"]			=(%c_rs_kharkov1_radioA_wait2talk);
                                                           
	level.scr_face["miesha"]["miesha_yes_sergeant"]			=(%f_kharkov2_miesha_yes_sergeant);
	level.scrsound["miesha"]["miesha_yes_sergeant"]			="miesha_yes_sergeant";
                                                           
	level.scr_anim["miesha"]["miesha_need_engineers"]		=(%c_rs_kharkov2_miesha_need_engineers);
	level.scr_face["miesha"]["miesha_need_engineers"]		=(%f_kharkov2_miesha_need_engineers);
	level.scrsound["miesha"]["miesha_need_engineers"]		="miesha_need_engineers";
                                                           
	level.scr_anim["miesha"]["miesha_sendanother"]			=(%c_rs_kharkov2_miesha_sendanother);
	level.scr_face["miesha"]["miesha_sendanother"]			=(%f_kharkov2_miesha_sendanother);
	level.scrsound["miesha"]["miesha_sendanother"]			="miesha_sendanother";
                                                           
	level.scr_anim["miesha"]["miesha_iknow"]			=(%c_rs_kharkov2_miesha_iknow);
	level.scr_face["miesha"]["miesha_iknow"]			=(%f_kharkov2_miesha_iknow);
	level.scrsound["miesha"]["miesha_iknow"]			="miesha_iknow";
                                                           
	level.scr_anim["miesha"]["miesha_doingbest"]			=(%c_rs_kharkov2_miesha_doingbest);
	level.scr_face["miesha"]["miesha_doingbest"]			=(%f_kharkov2_miesha_doingbest);
	level.scrsound["miesha"]["miesha_doingbest"]			="miesha_doingbest";
                                                           
	level.scr_face["miesha"]["miesha_finally"]			=(%f_kharkov2_miesha_finally);
	level.scrsound["miesha"]["miesha_finally"]			="miesha_finally";
                                                           
	level.scr_anim["miesha"]["radio_talk_1"][0]			=(%c_rs_kharkov1_radioA_talk);
//	level.scrsound["miesha"]["radio_talk_1"][0]			="miesha_firemission01";
                                                           
	level.scr_anim["miesha"]["radio_talk_2"][0]			=(%c_rs_kharkov1_radioA_talk);
//	level.scrsound["miesha"]["radio_talk_2"][0]			="miesha_firemission02";
                                                           
	level.scr_anim["miesha"]["radio_talk_3"][0]			=(%c_rs_kharkov1_radioA_talk);
//	level.scrsound["miesha"]["radio_talk_3"][0]			="miesha_firemission03";
                                                           
	level.scr_anim["miesha"]["radio_talk_ear_loop"][0]		=(%c_rs_kharkov1_radioA_ear);
	level.scr_anim["miesha"]["radio_talk_ear2stand"]		=(%c_rs_kharkov1_radioA_ear2stand);

	level.scr_anim["miesha"]["miesha_bombers"]			= (%c_rs_kharkov2_miesha_bombers);                                                           
	level.scr_face["miesha"]["miesha_bombers"]			= (%f_kharkov2_miesha_bombers);
	level.scrsound["miesha"]["miesha_bombers"]			= "miesha_bombers";
}                                                          
                                                           
Engineers()                                                
{                                                          
	level.scr_anim["engineer"]["plant_bomb"]			=(%c_rs_kharkov2_plant_bomb);
}                                                          
                                                           
Anon_Trooper()                                             
{                                                          
//	level.scr_face["anon_trooper"]["gen_lookout"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anon_trooper"]["gen_lookout"]			= "gen_lookout";
                                                                
//	level.scr_face["anon_trooper"]["gen_alright"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anon_trooper"]["gen_alright"]			= "gen_alright";
                                                                
//	level.scr_face["anon_trooper"]["gen_stuka1"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anon_trooper"]["gen_stuka1"]			= "gen_stuka1";
                                                                
//	level.scr_face["anon_trooper"]["gen_stuka2"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anon_trooper"]["gen_stuka2"]			= "gen_stuka2";
                                                                
//	level.scr_face["anon_trooper"]["gen_flak"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anon_trooper"]["gen_flak"]			= "gen_flak";
                                                                
//	level.scr_face["anon_trooper"]["gen_tank"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anon_trooper"]["gen_tank"]			= "gen_tank";
                                                                
//	level.scr_face["anon_trooper"]["gen_tanks"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anon_trooper"]["gen_tanks"]			= "gen_tanks";
                                                                
//	level.scr_face["anon_trooper"]["gen_88"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anon_trooper"]["gen_88"]			= "gen_88";
}                                                               
                                                                
Commissar()                                                     
{                                                               
	level.scr_anim["commissar"]["comm_station"]			= (%c_rs_kharkov2_comm_station);
	level.scr_face["commissar"]["comm_station"]			= (%f_kharkov2_comm_station);
	level.scrsound["commissar"]["comm_station"]			= "comm_station";
                                                                
//	level.scr_face["commissar"]["comm_avenge"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["commissar"]["comm_avenge"]			= "comm_avenge";
                                                                	
	// 35.9 seconds long                                    	
	level.scr_anim["commissar"]["comm_greatday"]			= (%c_rs_kharkov2_comm_greatday);
	level.scr_face["commissar"]["comm_greatday"]			= (%f_kharkov2_comm_greatday);
	level.scrsound["commissar"]["comm_greatday"]			= "comm_greatday";
}          

Flagger()
{
	level.scr_anim["flagwaver"]["run"]				= (%flagwaver_interiorrun);
	level.scr_anim["flagwaver"]["wave"][0]				= (%stalingrad_flagwaver_idle);
}                                                
                                                           
#using_animtree("kharkov2_debris");                        
Falling_Debris()                                           
{                                                          
	level.scr_animtree["kharkov2_debris"]				= (#animtree);
                                                                        
	level.scr_anim["kharkov2_facadeA"]["reactor"] 			= (%kharkov2_facadeA);
	level.scr_notetrack["kharkov2_facadeA"][0]["notetrack"]		= "sound";
	level.scr_notetrack["kharkov2_facadeA"][0]["sound"] 		= "big_stone_crash";
                                                                        
	level.scr_anim["kharkov2_facadeB"]["reactor"] 			= (%kharkov2_facadeB);
	level.scr_notetrack["kharkov2_facadeB"][0]["notetrack"]		= "sound";
	level.scr_notetrack["kharkov2_facadeB"][0]["sound"] 		= "big_stone_crash";
                                                                        
	level.scr_anim["trolleys"]["reactor"] 				= (%kharkov2_trolly_exp);
                                                                        
	level.scr_anim["kharkov2_warehouse_exp"]["reactor"] 		= (%kharkov2_warehouse_exp);
	level.scr_notetrack["kharkov2_warehouse_exp"][0]["notetrack"]	= "sound";
	level.scr_notetrack["kharkov2_warehouse_exp"][0]["sound"] 	= "big_stone_crash";
                                                                        
	level.scr_anim["kharkov2_lenin_statue"]["reactor"] 		= (%kharkov2_lenin_statue);
                                                                        
	level.scr_anim["kharkov2_little_house"]["reactor"] 		= (%kharkov2_little_house);
	level.scr_notetrack["kharkov2_little_house"][0]["notetrack"]	= "sound";
	level.scr_notetrack["kharkov2_little_house"][0]["sound"] 	= "big_stone_crash";
                                                                        
	level.scr_anim["kharkov2_watertower_exp"]["reactor"] 		= (%kharkov2_watertower_exp);
}                                                          
                                                           
#using_animtree("kharkov2_dummies_motion");                       
Drones()                                                   
{                                                          
// START::END Dummies Section ------------//               
	level.scr_animtree["end_dummies"] 				= #animtree;
	level.scr_character["end_dummies"][0] 				= character\RussianArmy ::main;
	level.scr_character["end_dummies"][1] 				= character\RussianArmy2 ::main;
	level.scr_character["end_dummies"][2] 				= character\RussianArmyMosin1 ::main;
	                                                   
	level.scr_sound ["exaggerated flesh impact"] 			= "bullet_mega_flesh"; // Commissar shot by sniper (exaggerated cinematic type impact)
    	level._effect["ground"]						= loadfx ("fx/impacts/small_gravel.efx");
	level._effect["flesh small"]					= loadfx ("fx/impacts/flesh_hit.efx");
	level.scr_dyingguy["effect"][0] 				= "ground";
	level.scr_dyingguy["effect"][1] 				= "flesh small";
	level.scr_dyingguy["sound"][0] 					= level.scr_sound ["exaggerated flesh impact"];
	level.scr_dyingguy["tag"][0] 					= "bip01 l thigh";         																							
	level.scr_dyingguy["tag"][1] 					= "bip01 head";            																							
	level.scr_dyingguy["tag"][2] 					= "bip01 l calf";          																							
	level.scr_dyingguy["tag"][3] 					= "bip01 pelvis";          																							
	level.scr_dyingguy["tag"][4] 					= "tag_breastpocket_right";																							
	level.scr_dyingguy["tag"][5] 					= "bip01 l clavicle";      																							
                                                                     	
	level.scr_anim["end_dummies"]["move_forward"][0]		= (%sprint1_loop);
	level.scr_anim["end_dummies"]["move_forward"][1]		= (%stand_shoot_run_forward);
	level.scr_anim["end_dummies"]["move_forward"][2]		= (%crouchrun_loop_forward_1);
                                                                     	
	level.scr_anim["end_dummies"]["death"][0]			= (%death_run_forward_crumple);
	level.scr_anim["end_dummies"]["death"][1]			= (%crouchrun_death_drop);
	level.scr_anim["end_dummies"]["death"][2]			= (%crouchrun_death_crumple);
	level.scr_anim["end_dummies"]["death"][3]			= (%death_run_onfront);
	level.scr_anim["end_dummies"]["death"][4]			= (%death_run_onleft);
                                                           
// END::End Dummies Section ------------//                 
}                                                          

// Mainly Germans.
#using_animtree("kharkov2_dummies_motion");                       
Backward_Drones()
{                                                          
//	character\waffenSS_soldier_mp44a::precache();
//	character\waffenSS_soldier_mp40b::precache();
	character\wehrmacht_soldier_mp44c::precache();
// START::END Dummies Section ------------//               
	level.scr_animtree["end_backward_dummies"] 				= #animtree;
//	level.scr_character["end_backward_dummies"][0] 				= character\waffenSS_soldier_mp44a::main;
//	level.scr_character["end_backward_dummies"][1] 				= character\waffenSS_soldier_mp40b::main;
	level.scr_character["end_backward_dummies"][0] 				= character\wehrmacht_soldier_mp44c::main;
	                                                   
	level.scr_anim["end_backward_dummies"]["move_forward"][0]		= (%combatrun_back);
	level.scr_anim["end_backward_dummies"]["move_forward"][1]		= (%c_backward_run_look_behind);
	level.scr_anim["end_backward_dummies"]["move_forward"][2]		= (%crouchrun_loop_back);
	level.scr_anim["end_backward_dummies"]["move_forward"][3]		= (%c_backward_crouch_walk_look_behind);
                                                                     	
	level.scr_anim["end_backward_dummies"]["death"][0]			= (%death_run_forward_crumple);
	level.scr_anim["end_backward_dummies"]["death"][1]			= (%crouchrun_death_drop);
	level.scr_anim["end_backward_dummies"]["death"][2]			= (%crouchrun_death_crumple);
	level.scr_anim["end_backward_dummies"]["death"][3]			= (%death_run_onfront);
	level.scr_anim["end_backward_dummies"]["death"][4]			= (%death_run_onleft);
                                                           
// END::End Dummies Section ------------//                 
}                                  
                                                           
#using_animtree("kharkov2_dummies");                       
smart_bomb()                                               
{                                                          
	level.scr_animtree["smart_bomb"] 				= #animtree;
                                                              	
	level.scr_anim["smart_bomb"]["doit"]				=(%panzerfaust_crouchshoot_down);
	level.scr_anim["smart_bomb"]["trans"]				=(%panzerfaust_standidle2crouchaim);
}                                                             	
                                                              	
#using_animtree("kharkov2_dummies");                          	
Drone_Paths()                                                 	
{                                                             	
	level.scr_animtree["end_dummy_path"] 				= #animtree;
	level.drone_path_anim["end_dummy_path"] 			= (%kharkov2_dummies_trainstation);

	level.scr_animtree["kharkov2_dummies_2nd_wave"] 		= #animtree;
	level.drone_path_anim["kharkov2_dummies_2nd_wave"] 		= (%kharkov2_dummies_2nd_wave);

	level.scr_animtree["kharkov2_dummies_germans"] 			= #animtree;
	level.drone_path_anim["kharkov2_dummies_germans"] 		= (%kharkov2_dummies_germans);
}
                                                              	
#using_animtree("kharkov2_traincrash");                       	
Train_Crash()                                                 	
{                                                             	
	level.scr_animtree["end_train"] 				= #animtree;
	level.scr_anim["end_train"]["reactor"]				=(%kharkov2_traincrash);
}                                                             	