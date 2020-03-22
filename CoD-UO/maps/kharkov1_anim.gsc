#using_animtree("generic_human");
main()
{
	maps\kharkov1_anim::Vassili();
	maps\kharkov1_anim::Antonov();
	maps\kharkov1_anim::Miesha();
	maps\kharkov1_anim::Bloody_Death();
	maps\kharkov1_anim::Event4_Wall_Explosion();
	maps\kharkov1_anim::Falling_Debris();
	maps\kharkov1_anim::Elefant();
	maps\kharkov1_anim::Event1_BullHorn();
}

Vassili()
{
	// When he kicks the door in event2. After 2nd Target is taken out.
	level.scr_anim["vassili"]["kick_door_1"] 			= (%chateau_kickdoor1);
	level.scr_anim["vassili"]["kick_door_2"] 			= (%chateau_kickdoor2);
}

Antonov()
{
	level.scr_anim["antonov"]["event1_start"]			= (%c_rs_kharkov1_antonov_advance);
	level.scr_face["antonov"]["event1_start"]			= (%f_kharkov1_antonov_advance);
	level.scrsound["antonov"]["event1_start"]			= "antonov_advance";

	level.scr_face["antonov"]["event1_loop1"]			= (%f_kharkov1_antonov_keepfiring01);
	level.scrsound["antonov"]["event1_loop1"]			= "antonov_keepfiring01";

	level.scr_face["antonov"]["event1_loop2"]			= (%f_kharkov1_antonov_keepfiring02);
	level.scrsound["antonov"]["event1_loop2"]			= "antonov_keepfiring02";

	level.scr_face["antonov"]["event1_loop3"]			= (%f_kharkov1_antonov_keepfiring03);
	level.scrsound["antonov"]["event1_loop3"]			= "antonov_keepfiring03";

// NO SOUND MADE FOR IT!
//	level.scr_face["antonov"]["event1_loop4"]			= (%f_kharkov1_antonov_keepfiring04);
//	level.scrsound["antonov"]["event1_loop4"]			= "antonov_keepfiring04";

	level.scr_anim["antonov"]["event1_push_forward"]		= (%c_rs_kharkov1_antonov_advance2);
	level.scr_face["antonov"]["event1_push_forward"]		= (%f_kharkov1_antonov_advance2);
	level.scrsound["antonov"]["event1_push_forward"]		= "antonov_advance2";

	// Anti-Guns! Yuri... Miesha, Over here!
	level.scr_anim["antonov"]["antonov_atguns"]			= (%c_rs_kharkov1_antonov_atguns);
	level.scr_face["antonov"]["antonov_atguns"]			= (%f_kharkov1_antonov_atguns);
	level.scrsound["antonov"]["antonov_atguns"]			= "antonov_atguns";

	level.scr_anim["antonov"]["event2_start"]			= (%c_rs_kharkov1_antonov_spotter);
	level.scr_face["antonov"]["event2_start"]			= (%f_kharkov1_antonov_spotter);
	level.scrsound["antonov"]["event2_start"]			= "antonov_spotter";

	level.scr_anim["antonov"]["antonov_follow"]			= (%c_rs_kharkov1_antonov_follow);
	level.scr_face["antonov"]["antonov_follow"]			= (%f_kharkov1_antonov_follow);
	level.scrsound["antonov"]["antonov_follow"]			= "antonov_follow";

	level.scr_face["antonov"]["event4_start"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["antonov"]["event4_start"]			= "antonov_follow";

	level.scr_face["antonov"]["antonov_square_secured"]		= (%f_kharkov1_antonov_square_secured);
	level.scrsound["antonov"]["antonov_square_secured"]		= "antonov_square_secured";

	level.scr_anim["antonov"]["antonov_check"]			= (%c_rs_kharkov1_antonov_check);
	level.scr_face["antonov"]["antonov_check"]			= (%f_kharkov1_antonov_check);
	level.scrsound["antonov"]["antonov_check"]			= "antonov_check";

	level.scr_face["antonov"]["antonov_windows"]			= (%f_kharkov1_antonov_windows);
	level.scrsound["antonov"]["antonov_windows"]			= "antonov_windows";

	level.scr_face["antonov"]["antonov_ass"]			= (%f_kharkov1_antonov_ass);
	level.scrsound["antonov"]["antonov_ass"]			= "antonov_ass";

	level.scr_face["antonov"]["antonov_howmany"]			= (%f_kharkov1_antonov_howmany);
	level.scrsound["antonov"]["antonov_howmany"]			= "antonov_howmany";

	level.scr_face["antonov"]["antonov_pfaust2"]			= (%f_kharkov1_antonov_pfaust2);
	level.scrsound["antonov"]["antonov_pfaust2"]			= "antonov_pfaust2";

	level.scr_face["antonov"]["antonov_letsmove"]			= (%f_kharkov1_antonov_letsmove);
	level.scrsound["antonov"]["antonov_letsmove"]			= "antonov_letsmove";
}

Miesha()
{
	// Radio Chatting.
	level.scr_face["miesha"]["blah_blah"]				="none";
	level.scr_anim["miesha"]["radio_trans_in"]			=(%c_rs_kharkov1_radioA_in);
	level.scr_anim["miesha"]["radio_trans_out"]			=(%c_rs_kharkov1_radioA_out);
	level.scr_anim["miesha"]["radio_wait"][0]			=(%c_rs_kharkov1_radioA_wait);
	level.scr_anim["miesha"]["radio_trans_to_talk"]			=(%c_rs_kharkov1_radioA_wait2talk);

	// Right away, comrade sgt.
	level.scr_face["miesha"]["miesha_rightaway"]			=(%f_kharkov1_miesha_rightaway);
	level.scrsound["miesha"]["miesha_rightaway"]			="miesha_rightaway";

	level.scr_face["miesha"]["miesha_wait01"]			=(%f_kharkov1_miesha_wait01);
	level.scrsound["miesha"]["miesha_wait01"]			="miesha_wait01";

	level.scr_face["miesha"]["miesha_wait02"]			=(%f_kharkov1_miesha_wait02);
	level.scrsound["miesha"]["miesha_wait02"]			="miesha_wait02";

	level.scr_face["miesha"]["miesha_wait03"]			=(%f_kharkov1_miesha_wait03);
	level.scrsound["miesha"]["miesha_wait03"]			="miesha_wait03";

	level.scr_face["miesha"]["miesha_ready1"]			=(%f_kharkov1_miesha_ready1);
	level.scrsound["miesha"]["miesha_ready1"]			="miesha_ready1";

	level.scr_face["miesha"]["miesha_ready2"]			=(%f_kharkov1_miesha_ready2);
	level.scrsound["miesha"]["miesha_ready2"]			="miesha_ready2";

	// Lets go! (move to the next section)
	level.scr_face["miesha"]["miesha_letsgo"]			=(%f_kharkov1_miesha_letsgo);
	level.scrsound["miesha"]["miesha_letsgo"]			="miesha_letsgo";

	level.scr_anim["miesha"]["radio_talk_1"]			=(%c_rs_kharkov1_miesha_firemission01);
	level.scr_face["miesha"]["radio_talk_1"]			=(%f_kharkov1_miesha_firemission01);
	level.scrsound["miesha"]["radio_talk_1"]			="miesha_firemission01";

	level.scr_anim["miesha"]["radio_talk_2"]			=(%c_rs_kharkov1_miesha_firemission02);
	level.scr_face["miesha"]["radio_talk_2"]			=(%f_kharkov1_miesha_firemission02);
	level.scrsound["miesha"]["radio_talk_2"]			="miesha_firemission02";

	level.scr_anim["miesha"]["radio_talk_3"]			=(%c_rs_kharkov1_miesha_firemission03);
	level.scr_face["miesha"]["radio_talk_3"]			=(%f_kharkov1_miesha_firemission03);
	level.scrsound["miesha"]["radio_talk_3"]			="miesha_firemission03";

	
//////////////// OLD STUFF!
//	level.scr_anim["miesha"]["radio_talk_1"][0]			=(%c_rs_kharkov1_miesha_firemission01);
//	level.scr_face["miesha"]["radio_talk_1"][0]			=(%f_kharkov1_miesha_firemission01);
////	level.scrsound["miesha"]["radio_talk_1"][0]			="miesha_firemission01";

//	level.scr_anim["miesha"]["radio_talk_2"][0]			=(%c_rs_kharkov1_miesha_firemission02);
//	level.scr_face["miesha"]["radio_talk_2"][0]			=(%f_kharkov1_miesha_firemission02);
////	level.scrsound["miesha"]["radio_talk_2"][0]			="miesha_firemission02";

//	level.scr_anim["miesha"]["radio_talk_3"][0]			=(%c_rs_kharkov1_miesha_firemission03);
//	level.scr_face["miesha"]["radio_talk_3"][0]			=(%f_kharkov1_miesha_firemission03);
////	level.scrsound["miesha"]["radio_talk_3"][0]			="miesha_firemission03";

	level.scr_anim["miesha"]["radio_talk_ear_loop"][0]		=(%c_rs_kharkov1_radioA_ear);
	level.scr_anim["miesha"]["radio_talk_ear2stand"]		=(%c_rs_kharkov1_radioA_ear2stand);

	level.scr_face["miesha"]["miesha_third_floor"]			=(%f_kharkov1_miesha_third_floor);
	level.scrsound["miesha"]["miesha_third_floor"]			="miesha_third_floor";

	level.scr_face["miesha"]["miesha_enemy_gun"]			=(%PegDay_facial_Friend1_01_incoming);
	level.scrsound["miesha"]["miesha_enemy_gun"]			="miesha_enemy_gun";

	level.scr_face["miesha"]["miesha_tank"]				=(%f_kharkov1_miesha_tank);
	level.scrsound["miesha"]["miesha_tank"]				="miesha_tank";

	level.scr_face["miesha"]["miesha_tiger"]			=(%f_kharkov1_miesha_tiger);
	level.scrsound["miesha"]["miesha_tiger"]			="miesha_tiger";

	level.scr_anim["miesha"]["miesha_tiger2"]			= (%c_rs_kharkov1_miesha_tiger2);
	level.scr_face["miesha"]["miesha_tiger2"]			=(%f_kharkov1_miesha_tiger2);
	level.scrsound["miesha"]["miesha_tiger2"]			="miesha_tiger2";
}

Bloody_Death()
{
	level.scr_sound ["exaggerated flesh impact"]			= "bullet_mega_flesh"; // Commissar shot by sniper (exaggerated cinematic type impact)
    	level._effect["ground"]						= loadfx ("fx/impacts/small_gravel.efx");
	level._effect["flesh small"]					= loadfx ("fx/impacts/flesh_hit.efx");
	level.scr_dyingguy["effect"][0]					= "ground";
	level.scr_dyingguy["effect"][1]					= "flesh small";
	level.scr_dyingguy["sound"][0]					= level.scr_sound ["exaggerated flesh impact"];
	level.scr_dyingguy["tag"][0] 					= "bip01 l thigh";         																							
	level.scr_dyingguy["tag"][1] 					= "bip01 head";            																							
	level.scr_dyingguy["tag"][2] 					= "bip01 l calf";          																							
	level.scr_dyingguy["tag"][3] 					= "bip01 pelvis";          																							
	level.scr_dyingguy["tag"][4] 					= "tag_breastpocket_right";																							
	level.scr_dyingguy["tag"][5] 					= "bip01 l clavicle";      																							
}

Event4_Wall_Explosion()
{
	level.scr_sound["event4_wall_explosion"]			= "grenade_explode_default";
}

Event1_BullHorn()
{
	level.scr_anim["bullhorn_commissar"]["stand_idle"][0]				= (%Leader_shout_A);
	level.scr_anim["bullhorn_commissar"]["stand_idle"][1]				= (%Leader_shout_B);
	level.scr_anim["bullhorn_commissar"]["stand_idle"][2]				= (%Leader_shout_C);

	level.scr_anim["bullhorn_commissar"]["warning1"]				= (%c_rs_kharkov1_megaphone_nofallback);
	level.scrsound["bullhorn_commissar"]["warning1"]				="commissar2_line47";

	level.scr_anim["bullhorn_commissar"]["warning2"]				= (%c_rs_kharkov1_megaphone_nofallback);
	level.scrsound["bullhorn_commissar"]["warning2"]				="commissar2_line51";

	level.scr_anim["bullhorn_commissar"]["warning3"]				= (%c_rs_kharkov1_megaphone_nofallback);
	level.scrsound["bullhorn_commissar"]["warning3"]				="commissar2_line52";
	
	level.scr_anim["bullhorn_commissar"]["traitor1"]				= (%c_rs_kharkov1_megaphone_traitor);
	level.scrsound["bullhorn_commissar"]["traitor1"]				="commissar1_line26";

	level.scr_anim["bullhorn_commissar"]["traitor2"]				= (%c_rs_kharkov1_megaphone_traitor);
	level.scrsound["bullhorn_commissar"]["traitor2"]				="commissar1_line40";
}

#using_animtree("kharkov1_debris");
Falling_Debris()
{
	level.scr_animtree["kharkov1_debris"]				= (#animtree);

	level.scr_anim["kharkov1_facadeA1"]["reactor"] 			= (%kharkov1_facadeA1);
	level.scr_notetrack["kharkov1_facadeA1"][0]["notetrack"]	= "sound";
//	level.scr_notetrack["kharkov1_facadeA1"][0]["sound"] 		= "big_stone_crash";

	level.scr_anim["kharkov1_facadeA2"]["reactor"] 			= (%kharkov1_facadeA2);
	level.scr_notetrack["kharkov1_facadeA2"][0]["notetrack"]	= "sound";
//	level.scr_notetrack["kharkov1_facadeA2"][0]["sound"] 		= "big_stone_crash";

	level.scr_anim["kharkov1_facadeA3"]["reactor"] 			= (%kharkov1_facadeA3);
	level.scr_notetrack["kharkov1_facadeA3"][0]["notetrack"]	= "sound";
//	level.scr_notetrack["kharkov1_facadeA3"][0]["sound"] 		= "big_stone_crash";

	level.scr_anim["kharkov1_facadeA4"]["reactor"] 			= (%kharkov1_facadeA4);
	level.scr_notetrack["kharkov1_facadeA4"][0]["notetrack"]	= "sound";
//	level.scr_notetrack["kharkov1_facadeA4"][0]["sound"] 		= "big_stone_crash";

	level.scr_anim["kharkov1_facadeC"]["reactor"] 			= (%kharkov1_facadeC);
	level.scr_notetrack["kharkov1_facadeC"][0]["notetrack"]		= "sound";
//	level.scr_notetrack["kharkov1_facadeC"][0]["sound"] 		= "big_stone_crash";

	level.scr_anim["kharkov1_facadeB1"]["reactor"] 			= (%kharkov1_facadeB1);
	level.scr_notetrack["kharkov1_facadeB1"][0]["notetrack"]	= "sound";
//	level.scr_notetrack["kharkov1_facadeB1"][0]["sound"] 		= "big_stone_crash";

	level.scr_anim["kharkov1_facadeB2"]["reactor"] 			= (%kharkov1_facadeB2);
	level.scr_notetrack["kharkov1_facadeB2"][0]["notetrack"]	= "sound";
//	level.scr_notetrack["kharkov1_facadeB2"][0]["sound"] 		= "big_stone_crash";

	level.scr_anim["kharkov1_facadeB3"]["reactor"] 			= (%kharkov1_facadeB3);
	level.scr_notetrack["kharkov1_facadeB3"][0]["notetrack"]	= "sound";
//	level.scr_notetrack["kharkov1_facadeB3"][0]["sound"]		= "big_stone_crash";
}

#using_animtree("Elefant");
Elefant()
{
	level.scr_animtree["elefant"]				= (#animtree);
	level.scr_anim["elefant"]["fire"] 			= (%v_ge_lnd_elefant_fire);	
}