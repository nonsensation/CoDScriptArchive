#using_animtree("generic_human");
main()
{
	character\ally_british_ingram::precache();   
	character\Resistance_Bucky::precache();   
	character\Resistance_Dom::precache();   
	character\Resistance_Fat::precache();   
	character\Resistance_Moe::precache();   
	character\Resistance_Old::precache();   
	character\Resistance_Tom::precache();   


	level.scr_anim["generic"]["kick door 1"] 				= %chateau_kickdoor1;
	level.scr_anim["generic"]["kick door 2"] 				= %chateau_kickdoor2;
	
    	level.scr_anim["truckriders"]["jumpin"]              			= (%germantruck_guyC_climbin);
    	level.scr_anim["truckriders"]["death"]                  		= (%death_stand_dropinplace);
  
    	level.scr_anim["truck_driver"]["idle_loop"]				= (%germantruck_driver_sitidle_loop);
	level.scr_anim["truck_driver"]["drive_loop"]				= (%germantruck_driver_drive_loop);
 	level.scr_anim["truck_driver"]["jumpin_fast"]				= (%trainbridge_truckdriver_climbin_fast);
	level.scr_anim["truck_driver"]["jumpin_slow"]				= (%trainbridge_truckdriver_climbin_slow);
	
	level.scr_anim["panzer_dude"]["aim"]					= (%panzerfaust_crouchaim_straight);
	level.scr_anim["panzer_dude"]["aim_low"]				= (%panzerfaust_crouchaim_down);
	
	level.scr_anim[0]["getoutanim"] 					= %germantruck_driver_climbout;
	level.scr_anim[1]["getoutanim"]  					= %germantruck_guy1_jumpout;
	level.scr_anim[2]["getoutanim"]  					= %germantruck_guy2_jumpout;
	level.scr_anim[3]["getoutanim"]  					= %germantruck_guy3_jumpout;
	level.scr_anim[4]["getoutanim"]  					= %germantruck_guy4_jumpout;
	level.scr_anim[5]["getoutanim"]  					= %germantruck_guy5_jumpout;
	level.scr_anim[6]["getoutanim"]  					= %germantruck_guy6_jumpout;
	level.scr_anim[7]["getoutanim"]  					= %germantruck_guy7_jumpout;
	level.scr_anim[8]["getoutanim"]  					= %germantruck_guy8_jumpout;
	
	level.scr_anim[0]["exittag"]  						= "tag_driver";
	level.scr_anim[1]["exittag"]  						= "tag_guy01";
	level.scr_anim[2]["exittag"]  						= "tag_guy02";
	level.scr_anim[3]["exittag"]  						= "tag_guy03";
	level.scr_anim[4]["exittag"]  						= "tag_guy04";
	level.scr_anim[5]["exittag"]  						= "tag_guy05";
	level.scr_anim[6]["exittag"]  						= "tag_guy06";
	level.scr_anim[7]["exittag"]  						= "tag_guy07";
	level.scr_anim[8]["exittag"]  						= "tag_guy08";

	level.scr_anim[0]["delay"]  						= 0; 	//driver
	level.scr_anim[1]["delay"]  						= 0; 	//tag1
	level.scr_anim[2]["delay"]  						= .2; 	//tag2
	level.scr_anim[3]["delay"]  						= .3;	//tag3
	level.scr_anim[4]["delay"]  						= 0;	//tag4
	level.scr_anim[5]["delay"]  						= .4;	//tag5
	level.scr_anim[6]["delay"]  						= .2;	//tag6
	level.scr_anim[7]["delay"]  						= .5;	//tag7
	level.scr_anim[8]["delay"]  						= .8;	//tag8
	
//	level.scr_anim["truck_idle"]["truckidle"]  				= (%c_br_sicily1_idletruck_guy6);

	level.scr_anim[0]["truckidle"]  					= (%c_br_sicily1_idletruck_guy1);
	level.scr_anim[1]["truckidle"]  					= (%c_br_sicily1_idletruck_guy1);
	level.scr_anim[2]["truckidle"]  					= (%c_br_sicily1_idletruck_guy1);
	level.scr_anim[3]["truckidle"]  					= (%c_br_sicily1_idletruck_guy5);
	level.scr_anim[4]["truckidle"]  					= (%c_br_sicily1_idletruck_guy1);
	level.scr_anim[5]["truckidle"]  					= (%c_br_sicily1_idletruck_guy4);
	level.scr_anim[6]["truckidle"]  					= (%c_br_sicily1_idletruck_guy5);
	level.scr_anim[7]["truckidle"]  					= (%c_br_sicily1_idletruck_guy4);
	level.scr_anim[8]["truckidle"]  					= (%c_br_sicily1_idletruck_guy4);

	level.scr_anim["pisser"]["casual turn"]					= (%pisser_casualturn);
	level.scr_anim["pisser"]["flinch turn"]					= (%pisser_flinchturn);
	level.scr_anim["pisser"]["idle"]					= (%pisser_pissidle);
	level.scr_anim["pisser"]["shakeout"]					= (%pisser_shakeout);

	level.scr_anim["pisser"]["pissing"]					= (%c_ge_trainbridge_pisser);
	level.scr_notetrack["pisser"][0]["notetrack"]              		="patrol1_alert"; 
     	level.scr_notetrack["pisser"][0]["dialogue"]                		="patrol1_alert"; 

   	thread loadtruckanim();
	thread Falling_Debris();
	thread detonator();
	maps\trainbridge_anim::ingram();
	thread parachute();
}

ingram()
{
	level.scr_character["ingram"] 					= character\ally_british_ingram::main;


	// TEMPLATE //

//	level.scr_anim["miesha"]["miesha_bombers"]			= (%c_rs_kharkov1_radioA_ear2stand);
//	level.scr_face["miesha"]["miesha_bombers"]			= (%f_trainbridge_miesha_bombers);
//	level.scrsound["miesha"]["miesha_bombers"]			= "miesha_bombers";
	

//	level.scr_anim["ingram"]["ingram_comedown"]			= (%c_rs_kharkov1_radioA_ear2stand);
//	level.scr_face["ingram"]["ingram_comedown"]			= (%f_trainbridge_ingram_comedown);
//	level.scrsound["ingram"]["ingram_comedown"]			= "ingram_comedown";
//
////	level.scr_anim["ingram"]["ingram_intro"]			= (%c_br_trainbridge_ingram_intro);
//	level.scr_face["ingram"]["ingram_intro"]			= (%f_trainbridge_ingram_intro);
//	level.scrsound["ingram"]["ingram_intro"]			= "ingram_intro";

	level.scr_anim["ingram"]["ingram_intro"]               		=(%c_br_trainbridge_ingram_intro); 

	level.scr_notetrack["ingram"][0]["notetrack"]              	="ingram_comedown"; 
     	level.scr_notetrack["ingram"][0]["dialogue"]                	="ingram_comedown"; 
     	level.scr_notetrack["ingram"][0]["facial"]                	=(%f_trainbridge_ingram_comedown); 

	level.scr_notetrack["ingram"][1]["notetrack"]              	="ingram_intro"; 
     	level.scr_notetrack["ingram"][1]["dialogue"]                	="ingram_intro"; 
     	level.scr_notetrack["ingram"][1]["facial"]                	=(%f_trainbridge_ingram_intro); 

	level.scr_notetrack["ingram"][2]["notetrack"]              	="ingram_quiet"; 
     	level.scr_notetrack["ingram"][2]["dialogue"]                	="ingram_quiet"; 
     	level.scr_notetrack["ingram"][2]["facial"]                	=(%f_trainbridge_ingram_quiet);



//	level.scr_anim["ingram"]["ingram_quiet"]			= (%c_rs_kharkov1_radioA_ear2stand);
//	level.scr_face["ingram"]["ingram_quiet"]			= (%f_trainbridge_ingram_quiet);
//	level.scrsound["ingram"]["ingram_quiet"]			= "ingram_quiet";

//	level.scr_anim["ingram"]["ingram_careful"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_careful"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_careful"]			= "ingram_careful";

//	level.scr_anim["ingram"]["ingram_shh"]				= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_shh"]				= (%f_trainbridge_ingram_ssh);
	level.scrsound["ingram"]["ingram_shh"]				= "ingram_shh";

	level.scr_anim["ingram"]["ingram_find_cover"]			= (%c_br_trainbridge_ingram_find_cover);
	level.scr_face["ingram"]["ingram_find_cover"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_find_cover"]			= "ingram_find_cover";

//	level.scr_anim["ingram"]["ingram_goto_forest"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_goto_forest"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_goto_forest"]			= "ingram_goto_forest";

//	level.scr_anim["ingram"]["ingram_getto_barn"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_getto_barn"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_getto_barn"]			= "ingram_getto_barn";

//	level.scr_face["ingram"]["ingram_clear_house"]			= (%f_trainbridge_ingram_clear_house);
//	level.scrsound["ingram"]["ingram_clear_house"]			= "ingram_clear_house";

//	level.scr_anim["ingram"]["ingram_close_as_can"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_close_as_can"]			= (%f_trainbridge_ingram_close_as_can);
	level.scrsound["ingram"]["ingram_close_as_can"]			= "ingram_close_as_can";

//	level.scr_anim["ingram"]["ingram_mg34"]				= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_mg34"]				= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_mg34"]				= "ingram_mg34";

//	level.scr_anim["ingram"]["ingram_barn"]				= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_barn"]				= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_barn"]				= "ingram_barn";

	level.scr_anim["ingram"]["ingram_over_here"]			= (%c_waiting_stand_idle);
	level.scr_face["ingram"]["ingram_over_here"]			= (%f_trainbridge_ingram_over_here);
	level.scrsound["ingram"]["ingram_over_here"]			= "ingram_over_here";

//	level.scr_anim["ingram"]["ingram_real_war"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_real_war"]			= (%f_trainbridge_ingram_real_war);
	level.scrsound["ingram"]["ingram_real_war"]			= "ingram_real_war";

//	level.scr_anim["ingram"]["ingram_across"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_across"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_across"]			= "ingram_across";

//	level.scr_anim["ingram"]["ingram_spreadout"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_spreadout"]			= (%f_trainbridge_ingram_spreadout);
	level.scrsound["ingram"]["ingram_spreadout"]			= "ingram_spreadout";

	level.scr_anim["ingram"]["ingram_depot"]			= (%c_br_trainbridge_ingram_depot);
	level.scr_face["ingram"]["ingram_depot"]			= (%f_trainbridge_ingram_depot);
	level.scrsound["ingram"]["ingram_depot"]			= "ingram_depot";

//	level.scr_anim["ingram"]["ingram_bunker"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_bunker"]			= (%f_trainbridge_ingram_bunker);
	level.scrsound["ingram"]["ingram_bunker"]			= "ingram_bunker";

////	level.scr_anim["ingram"]["ingram_grab_charges"]			= (%c_rs_kharkov1_radioA_ear2stand);
//	level.scr_face["ingram"]["ingram_grab_charges"]			= (%f_trainbridge_ingram_grab_charges);
//	level.scrsound["ingram"]["ingram_grab_charges"]			= "ingram_grab_charges";
//
////	level.scr_anim["ingram"]["ingram_grab_charges2"]		= (%c_rs_kharkov1_radioA_ear2stand);
//	level.scr_face["ingram"]["ingram_grab_charges2"]		= (%f_trainbridge_ingram_grab_charges2);
//	level.scrsound["ingram"]["ingram_grab_charges2"]		= "ingram_grab_charges2";


//	level.scr_anim["ingram"]["ingram_herecomes_train"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_herecomes_train"]		= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_herecomes_train"]		= "ingram_herecomes_train";

//	level.scr_anim["ingram"]["ingram_blow"]				= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_blow"]				= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_blow"]				= "ingram_blow";

//	level.scr_anim["ingram"]["ingram_doyle_hurry"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_doyle_hurry"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_doyle_hurry"]			= "ingram_doyle_hurry";

//	level.scr_anim["ingram"]["ingram_them_planted"]			= (%c_br_trainbridge_ingram_them_planted);
	level.scr_face["ingram"]["ingram_them_planted"]			= (%f_trainbridge_ingram_them_planted);
	level.scrsound["ingram"]["ingram_them_planted"]			= "ingram_them_planted";

	level.scr_anim["ingram"]["ingram_detonate1"]			= (%c_br_trainbridge_ingram_detonate1);
	level.scr_face["ingram"]["ingram_detonate1"]			= (%f_trainbridge_ingram_detonate1);
	level.scrsound["ingram"]["ingram_detonate1"]			= "ingram_detonate1";

	level.scr_anim["ingram"]["ingram_wait_wait"]			= (%c_br_trainbridge_ingram_wait_wait);
	level.scr_face["ingram"]["ingram_wait_wait"]			= (%f_trainbridge_ingram_wait_wait);
	level.scrsound["ingram"]["ingram_wait_wait"]			= "ingram_wait_wait";

	level.scr_anim["ingram"]["ingram_daft"]				= (%c_br_trainbridge_ingram_daft);
	level.scr_face["ingram"]["ingram_daft"]				= (%f_trainbridge_ingram_daft);
	level.scrsound["ingram"]["ingram_daft"]				= "ingram_daft";

	level.scr_anim["ingram"]["ingram_detonate2"]			= (%c_br_trainbridge_ingram_detonate2);
	level.scr_face["ingram"]["ingram_detonate2"]			= (%f_trainbridge_ingram_detonate2);
	level.scrsound["ingram"]["ingram_detonate2"]			= "ingram_detonate2";

//	level.scr_anim["ingram"]["ingram_woke_up"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_woke_up"]			= (%f_trainbridge_ingram_woke_up);
	level.scrsound["ingram"]["ingram_woke_up"]			= "ingram_woke_up";

//	level.scr_anim["ingram"]["ingram_thru_forest"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_thru_forest"]			= (%f_trainbridge_ingram_thru_forest);
	level.scrsound["ingram"]["ingram_thru_forest"]			= "ingram_thru_forest";

//	level.scr_anim["ingram"]["ingram_surprise"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_surprise"]			= (%f_trainbridge_ingram_surprise);
	level.scrsound["ingram"]["ingram_surprise"]			= "ingram_surprise";

//	level.scr_anim["ingram"]["ingram_lets_move"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_lets_move"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_lets_move"]			= "ingram_lets_move";

//	level.scr_anim["ingram"]["ingram_keep_quiet"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_keep_quiet"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_keep_quiet"]			= "ingram_keep_quiet";

//	level.scr_anim["ingram"]["ingram_back_behind"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_back_behind"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_back_behind"]			= "ingram_back_behind";

//	level.scr_anim["ingram"]["ingram_alright_go2"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_alright_go2"]			= (%f_trainbridge_ingram_alright_go2);
	level.scrsound["ingram"]["ingram_alright_go2"]			= "ingram_alright_go2";

//	level.scr_anim["ingram"]["ingram_there_she_is"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_there_she_is"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_there_she_is"]			= "ingram_there_she_is";

//	level.scr_anim["ingram"]["ingram_letsgo"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_letsgo"]			= (%f_trainbridge_ingram_letsgo);
	level.scrsound["ingram"]["ingram_letsgo"]			= "ingram_letsgo";

//	level.scr_anim["ingram"]["ingram_everybody_in"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_everybody_in"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["ingram"]["ingram_everybody_in"]			= "ingram_everybody_in";

//	level.scr_anim["ingram"]["ingram_jeeves"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_jeeves"]			= (%f_trainbridge_ingram_jeeves);
	level.scrsound["ingram"]["ingram_jeeves"]			= "ingram_jeeves";

//	level.scr_anim["ingram"]["ingram_pullover"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_pullover"]			= (%f_trainbridge_ingram_pullover);
	level.scrsound["ingram"]["ingram_pullover"]			= "ingram_pullover";

//	level.scr_anim["ingram"]["ingram_theyre_gone"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_theyre_gone"]			= (%f_trainbridge_ingram_theyre_gone);
	level.scrsound["ingram"]["ingram_theyre_gone"]			= "ingram_theyre_gone";

//	level.scr_anim["ingram"]["ingram_steponit"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_steponit"]			= (%f_trainbridge_ingram_steponit);
	level.scrsound["ingram"]["ingram_steponit"]			= "ingram_steponit";

//	level.scr_anim["ingram"]["ingram_england"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["ingram"]["ingram_england"]			= (%f_trainbridge_ingram_england);
	level.scrsound["ingram"]["ingram_england"]			= "ingram_england";

	level.scr_anim["ingram"]["kick door 1"] 			= %chateau_kickdoor1;

	level.scr_anim["ingram"]["ingram_looking"] 			= %c_br_trainbridge_ingram_looking;

	level.scr_anim["ingram"]["ingram_waiting"] 			= %c_br_trainbridge_ingram_waitidle;
}


#using_animtree("germantruck");
loadtruckanim()
{
	level.scr_anim["germantruck"]["truckflip"]			= (%trainbridge_truck_flip);
	level.scr_anim["germantruck"]["closedoor_startpose"]		= (%germantruck_truck_closedoor_startpose);
	level.scr_anim["germantruck"]["closedoor_fast"]			= (%trainbridge_truck_climbin_fast);
	level.scr_anim["germantruck"]["closedoor_slow"]			= (%trainbridge_truck_climbin_slow);
}


#using_animtree("trainbridge_debris");
Falling_Debris()
{
	level.scr_animtree["bridge_collapse"]				= (#animtree);

	level.scr_anim["bridge_collapse"]["reactor"] 			= (%trainbridge_bridgedummies);
	level.scr_anim["bridge_hang"]["reactor"] 			= (%trainbridge_bridgedummies_hang);


//	level.scr_notetrack["kharkov2_facadeA"][0]["notetrack"]		= "sound";
//	level.scr_notetrack["kharkov2_facadeA"][0]["sound"] 		= "big_stone_crash";
//
//	level.scr_anim["kharkov2_facadeB"]["reactor"] 			= (%kharkov2_facadeB);
//	level.scr_notetrack["kharkov2_facadeB"][0]["notetrack"]		= "sound";
//	level.scr_notetrack["kharkov2_facadeB"][0]["sound"] 		= "big_stone_crash";
//
}

#using_animtree("trainbridge_detonator");
Detonator()
{
	level.scr_animtree["detonator"]					= (#animtree);
	level.scr_anim["detonator"]["plunger"] 				= (%o_br_prp_detonator);
}

#using_animtree("trainbridge_parachute");
parachute()
{
	level.scr_animtree["trainbridge_parachute"]			= (#animtree);
	level.scr_anim["parachute"]["sway"] 				= (%trainbridge_parachute_sway);
	level.scr_notetrack["parachute"][0]["notetrack"]               	="sound"; 
     	level.scr_notetrack["parachute"][0]["sound"]       	  	="swing_in_tree"; 
}



//inside_anim.gsc 
//{      
//     level.scr_anim["ingram"]["ingram_intro"]               =(%c_body_anim); 
// 
// 
//     // To make Ingram talk when there is a notetrack of "ingram_into" 
//     // [1] is equal to "ingram_intro" within the notetracks (being the 2nd one) within the trainbridge_ingram_intro.xanim_export 
//     level.scr_notetrack["ingram"][1]["notetrack"]               ="ingram_intro"; 
//     level.scr_notetrack["ingram"][1]["dialogue"]                ="soundalias" 
//     level.scr_notetrack["ingram"][1]["facial"]                =%(f_facial_anim); 
// 
//     // 1 body anim, 2 facial anims, with 2 sounds 
//     level.scr_anim["ingram"]["grab_charges"]               =(%c_body_anim); 
// 
//     level.scr_notetrack["ingram"][0]["notetrack"]               ="ingram_grab_charges"; 
//     level.scr_notetrack["ingram"][0]["dialogue"]                ="soundalias"; 
//     level.scr_notetrack["ingram"][0]["facial"]                =(%f_facial_anim);      
// 
//     level.scr_notetrack["ingram"][1]["notetrack"]               ="ingram_grab_charges2"; 
//     level.scr_notetrack["ingram"][1]["dialogue"]                ="soundalias" 
//     level.scr_notetrack["ingram"][1]["facial"]                =(%f_facial_anim);      
//} 
// 
//inside_level.gsc 
//{ 
//     ingram_intro() 
//     { 
//          level.ingram anim_single_solo(level.ingram, "ingram_intro"); 
//     } 
//      
//     ingram_intro() 
//     { 
//          level.ingram anim_single_solo(level.ingram, "grab_charges"); 
//     } 
//}
