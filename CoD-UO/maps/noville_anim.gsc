#using_animtree("generic_human");
main()
{
	
	//template
//	level.scr_anim["ingram"]["ingram_comedown"]			= (%c_rs_kharkov1_radioA_ear2stand);
//	level.scr_face["ingram"]["ingram_comedown"]			= (%f_trainbridge_ingram_comedown);
//	level.scrsound["ingram"]["ingram_comedown"]			= "ingram_comedown";

	level.scr_anim["foley"]["stand2flinch"]				= (%flinchA_stand2flinch);
	level.scr_anim["foley"]["flinchloop"]				= (%flinchA);
	
	//foley
	maps\noville_anim::foley();

	//Anderson
	maps\noville_anim::anderson();

	//Whitney
	maps\noville_anim::whitney();

	//drones
	maps\noville_anim::axis_drones();
	maps\noville_anim::Drone_Paths();

} 


foley()
{
	//on the tank
	level.scr_anim["foley"]["foley_brief"]				= (%c_us_noville_foley_brief);

	level.scr_notetrack["foley"][0]["notetrack"]              	="foley_brief1"; 
     	level.scr_notetrack["foley"][0]["dialogue"]                	="foley_brief1"; 
     	level.scr_notetrack["foley"][0]["facial"]                	=(%f_noville_foley_brief1);

	level.scr_notetrack["foley"][1]["notetrack"]              	="foley_brief2"; 
     	level.scr_notetrack["foley"][1]["dialogue"]                	="foley_brief2"; 
     	level.scr_notetrack["foley"][1]["facial"]                	=(%f_noville_foley_brief2);

	level.scr_notetrack["foley"][2]["notetrack"]              	="foley_brief3"; 
     	level.scr_notetrack["foley"][2]["dialogue"]                	="foley_brief3"; 
     	level.scr_notetrack["foley"][2]["facial"]                	=(%f_noville_foley_brief3);

	level.scr_notetrack["foley"][3]["notetrack"]              	="foley_letsgo"; 
     	level.scr_notetrack["foley"][3]["dialogue"]                	="foley_letsgo"; 
     	level.scr_notetrack["foley"][3]["facial"]                	=(%f_noville_foley_letsgo);


	level.scr_face["foley"]["foley_zeroed"]				= (%f_noville_foley_zeroed);
	level.scrsound["foley"]["foley_zeroed"]				= "foley_zeroed";

//	level.scr_anim["foley"]["foley_next_building"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_next_building"]			= (%f_noville_foley_next_buidling);
	level.scrsound["foley"]["foley_next_building"]			= "foley_next_building";

//	level.scr_anim["foley"]["foley_fall_back"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_fall_back"]			= (%f_noville_foley_fall_back);
	level.scrsound["foley"]["foley_fall_back"]			= "foley_fall_back";

//	level.scr_anim["foley"]["foley_keep_advancing"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_keep_advancing"]			= (%f_noville_foley_keep_advancing);
	level.scrsound["foley"]["foley_keep_advancing"]			= "foley_keep_advancing";

//	level.scr_anim["foley"]["foley_up_street"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_up_street"]			= (%f_noville_foley_up_street);
	level.scrsound["foley"]["foley_up_street"]			= "foley_up_street";

//	level.scr_anim["foley"]["foley_drive_em_back"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_drive_em_back"]			= (%f_noville_foley_drive_em_back);
	level.scrsound["foley"]["foley_drive_em_back"]			= "foley_drive_em_back";

	level.scr_face["foley"]["foley_cp"]				= (%f_noville_foley_cp);
	level.scrsound["foley"]["foley_cp"]				= "foley_cp";

//	level.scr_anim["foley"]["foley_celebrate_later"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_celebrate_later"]		= (%f_noville_foley_celebrate_later);
	level.scrsound["foley"]["foley_celebrate_later"]		= "foley_celebrate_later";

	level.scr_anim["foley"]["foley_sonofa"]				= (%c_us_noville_foley_sonofa);
	level.scr_face["foley"]["foley_sonofa"]				= (%f_noville_foley_sonofa
);
	level.scrsound["foley"]["foley_sonofa"]				= "foley_sonofa";

//	level.scr_anim["foley"]["foley_cover_third"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_cover_third"]			= (%f_noville_foley_cover_third);
	level.scrsound["foley"]["foley_cover_third"]			= "foley_cover_third";

//	level.scr_anim["foley"]["foley_get_back_here"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_get_back_here"]			= (%f_noville_foley_get_back_here);
	level.scrsound["foley"]["foley_get_back_here"]			= "foley_get_back_here";

//	level.scr_anim["foley"]["foley_hold_chateau"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_hold_chateau"]			= (%f_noville_foley_hold_chateau);
	level.scrsound["foley"]["foley_hold_chateau"]			= "foley_hold_chateau";
	
//	level.scr_anim["foley"]["foley_flyboys]				= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_flyboys"]			= (%f_noville_foley_flyboys);
	level.scrsound["foley"]["foley_flyboys"]			= "foley_flyboys";

	level.scr_anim["foley"]["foley_goodjob"]			= (%c_us_noville_foley_goodjob);
	level.scr_face["foley"]["foley_goodjob"]			= (%f_noville_foley_goodjob);
	level.scrsound["foley"]["foley_goodjob"]			= "foley_goodjob";

//directional

//	level.scr_anim["foley"]["foley_dang_nailed]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_dang_nailed"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["foley"]["foley_dang_nailed"]			= "foley_dang_nailed";

//	level.scr_anim["foley"]["foley_panzer_west]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_panzer_west"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["foley"]["foley_panzer_west"]			= "foley_panzer_west";

//	level.scr_anim["foley"]["foley_germans_porch]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_germans_porch"]			= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["foley"]["foley_germans_porch"]			= "foley_germans_porch";

//	level.scr_anim["foley"]["foley_germans_in_house]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["foley"]["foley_germans_in_house"]		= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["foley"]["foley_germans_in_house"]		= "foley_germans_in_house";

}

anderson()
{
	//on tank
	level.scr_anim["anderson"]["trooper1_dinner"]			= (%c_us_noville_anderson_brief);

	level.scr_notetrack["anderson"][0]["notetrack"]              	= "trooper1_dinner"; 
     	level.scr_notetrack["anderson"][0]["dialogue"]                	= "trooper1_dinner"; 
     	level.scr_notetrack["anderson"][0]["facial"]                	= (%f_noville_trooper1_dinner);

//	level.scr_anim["anderson"]["anderson_champagne"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["anderson"]["anderson_champagne"]		= (%f_noville_anderson_champagne);
	level.scrsound["anderson"]["anderson_champagne"]		= "anderson_champagne";

//	level.scr_anim["anderson"]["anderson_third_squad"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["anderson"]["anderson_third_squad"]		= (%f_noville_anderson_third_squad);
	level.scrsound["anderson"]["anderson_third_squad"]		= "anderson_third_squad";

//	level.scr_anim["anderson"]["anderson_theirs_ours"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["anderson"]["anderson_theirs_ours"]		= (%f_noville_anderson_theirs_ours);
	level.scrsound["anderson"]["anderson_theirs_ours"]		= "anderson_theirs_ours";

//	level.scr_anim["anderson"]["anderson_alright"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["anderson"]["anderson_alright"]			= (%f_noville_anderson_alright);
	level.scrsound["anderson"]["anderson_alright"]			= "anderson_alright";



//bomb
//	level.scr_notetrack["anderson"][0]["notetrack"]			= "dialogue";
//	level.scr_notetrack["anderson"][0]["facial"]			= %Chateau_facial_Moody_081_mg42onleft;
//	level.scr_notetrack["anderson"][0]["dialogue"]			= "chateau_moody_didntseeme";
//	level.scr_notetrack["anderson"][0]["anime"]			= "intro";
//
//	level.scr_notetrack["anderson"][1]["notetrack"]		= "dialogue";
//	level.scr_notetrack["anderson"][1]["facial"]			= %Chateau_facial_Moody_082_bighouse;
//	level.scr_notetrack["anderson"][1]["dialogue"]			= "chateau_moody_inbighouse";
//	level.scr_notetrack["anderson"][1]["anime"]			= "intro";
//
//	level.scr_anim["anderson"]["bomb"]				= (%levelchateau_bombplacement_right);
//
//	level.scr_notetrack["anderson"][2]["notetrack"]		= "plant bombs = \"left\"";
//	level.scr_notetrack["anderson"][2]["create model"]		= "xmodel/explosivepack";
//	level.scr_notetrack["anderson"][2]["detach model"]		= "xmodel/explosivepack";
//	level.scr_notetrack["anderson"][2]["selftag"]			= "tag_weapon_left";
//	level.scr_notetrack["anderson"][2]["anime"]			= "bomb";
//
//	level.scr_notetrack["anderson"][3]["notetrack"]		= "plant bombs = \"right\"";
//	level.scr_notetrack["anderson"][3]["create model"]		= "xmodel/explosivepack";
//	level.scr_notetrack["anderson"][3]["detach model"]		= "xmodel/explosivepack";
//	level.scr_notetrack["anderson"][3]["selftag"]			= "tag_weapon_right";
//	level.scr_notetrack["anderson"][3]["anime"]			= "bomb";
//	
//	level.scr_notetrack["anderson"][4]["notetrack"]		= "attach bomb = \"left\"";
//	level.scr_notetrack["anderson"][4]["attach model"]		= "xmodel/explosivepack";
//	level.scr_notetrack["anderson"][4]["selftag"]			= "tag_weapon_left";
//	level.scr_notetrack["anderson"][4]["anime"]			= "bomb";
//	
//	level.scr_notetrack["anderson"][5]["notetrack"]		= "attach bomb = \"right\"";
//	level.scr_notetrack["anderson"][5]["attach model"]		= "xmodel/explosivepack";
//	level.scr_notetrack["anderson"][5]["selftag"]			= "tag_weapon_right";
//	level.scr_notetrack["anderson"][5]["anime"]			= "bomb";
//	
//	level.scr_notetrack["anderson"][6]["notetrack"]		= "detach bomb = \"left\"";
//	level.scr_notetrack["anderson"][6]["detach model"]		= "xmodel/explosivepack";
//	level.scr_notetrack["anderson"][6]["selftag"]			= "tag_weapon_left";
//	level.scr_notetrack["anderson"][6]["anime"]			= "bomb";
//	
//	level.scr_notetrack["anderson"][7]["notetrack"]		= "detach bomb = \"right\"";
//	level.scr_notetrack["anderson"][7]["detach model"]		= "xmodel/explosivepack";
//	level.scr_notetrack["anderson"][7]["selftag"]			= "tag_weapon_right";
//	level.scr_notetrack["anderson"][7]["anime"]			= "bomb";
//
//	level.scr_notetrack["anderson"][8]["notetrack"]		= "explode";
//	level.scr_notetrack["anderson"][8]["delete model"]		= 1;
//	level.scr_notetrack["anderson"][8]["exploder"]			= 1;	// exploder number
//	level.scr_notetrack["anderson"][8]["anime"]			= "bomb";

//directional

//	level.scr_anim["anderson"]["anderson_panzer_north"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["anderson"]["anderson_panzer_north"]		= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anderson"]["anderson_panzer_north"]		= "anderson_panzer_north";

//	level.scr_anim["anderson"]["anderson_halftrack_north"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["anderson"]["anderson_halftrack_north"]		= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anderson"]["anderson_halftrack_north"]		= "anderson_halftrack_north";

//	level.scr_anim["anderson"]["anderson_germans_in_house"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["anderson"]["anderson_germans_in_house"]		= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anderson"]["anderson_germans_in_house"]		= "anderson_germans_in_house";

//	level.scr_anim["anderson"]["anderson_germans_north_kitchen"]	= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["anderson"]["anderson_germans_north_kitchen"]	= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anderson"]["anderson_germans_north_kitchen"]	= "anderson_germans_north_kitchen";

//	level.scr_anim["anderson"]["anderson_germans_north"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["anderson"]["anderson_germans_north"]		= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anderson"]["anderson_germans_north"]		= "anderson_germans_north";
}

whitney()
{
	level.scr_anim["whitney"]["whitney_sonofa"]			= (%c_us_noville_whitney_sonofa);
	level.scr_face["whitney"]["whitney_sonofa"]			= (%f_noville_whitney_sonofa);
	level.scrsound["whitney"]["whitney_sonofa"]			= "whitney_sonofa";

//	level.scr_anim["whitney"]["whitney_incoming_air"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["whitney"]["whitney_incoming_air"]		= (%f_noville_whitney_incoming_air);
	level.scrsound["whitney"]["whitney_incoming_air"]		= "whitney_incoming_air";

//	level.scr_anim["whitney"]["whitney_p47s"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["whitney"]["whitney_p47s"]			= (%f_noville_whitney_p47s);
	level.scrsound["whitney"]["whitney_p47s"]			= "whitney_p47s";

//	level.scr_anim["whitney"]["whitney_anyway"]			= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["whitney"]["whitney_anyway"]			= (%f_noville_whitney_anyway);
	level.scrsound["whitney"]["whitney_anyway"]			= "whitney_anyway";

//	level.scr_anim["whitney"]["whitney_dang_nailed"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["whitney"]["whitney_dang_nailed"]		= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["whitney"]["whitney_dang_nailed"]		= "whitney_dang_nailed";

//directional

//	level.scr_anim["whitney"]["whitney_panzer_south"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["whitney"]["whitney_panzer_south"]		= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["whitney"]["whitney_panzer_south"]		= "whitney_panzer_south";

//	level.scr_anim["whitney"]["whitney_halftrack_south"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["whitney"]["whitney_halftrack_south"]		= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["whitney"]["whitney_halftrack_south"]		= "whitney_halftrack_south";

//	level.scr_anim["whitney"]["whitney_germans_in_house"]		= (%c_rs_kharkov1_radioA_ear2stand);
	level.scr_face["whitney"]["whitney_germans_in_house"]		= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["whitney"]["whitney_germans_in_house"]		= "whitney_germans_in_house";

}


#using_animtree("noville_dummies");
axis_drones()
{
	level.scr_animtree["axis_drone"] 					= #animtree;
	level.scr_character["axis_drone"][0] 					= character\German_wehrmact_snow ::main;
	
	level.scr_anim["axis_drone"]["move_forward"][0]				= (%sprint1_loop);
	level.scr_anim["axis_drone"]["move_forward"][1]				= (%stand_shoot_run_forward);
	level.scr_anim["axis_drone"]["move_forward"][2]				= (%crouchrun_loop_forward_1);
	
	
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

#using_animtree("noville_dummies");
Drone_Paths()
{
	level.scr_animtree["field_dummy_path1"] 			= #animtree;
	level.drone_path_anim["field_dummy_path1"] 			= (%noville_dummies);	
}