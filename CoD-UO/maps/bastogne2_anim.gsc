//sicily1_anim

#using_animtree("generic_human");
main()
{
//	character\moody::precache();   
	character\Airborne1b_carbine_snow::precache();   
	character\Airborne1b_garand_snow::precache();   
	character\Airborne1b_thompson_snow::precache();   

	maps\bastogne2_anim::moody();
	maps\bastogne2_anim::anderson();
	maps\bastogne2_anim::whitney();

	maps\bastogne2_anim::red();

	maps\bastogne2_anim::powned();
	maps\bastogne2_anim::contact();
	maps\bastogne2_anim::foley();
	maps\bastogne2_anim::others();

	maps\bastogne2_anim::neckguy();
	maps\bastogne2_anim::wallb();
	maps\bastogne2_anim::laying();
	
	maps\bastogne2_anim::map_table_anim();
	
}

//#using_animtree("bastogne2_anim");

moody()
{
	level.scr_character["moody"] 					= character\Airborne1b_carbine_snow::main;
	level.scr_animtree["moody"]					= #animtree;

	//Moody With Wounded Guy Animations
	level.scr_anim["moody"]["kickdoor"]		= (%chateau_kickdoor1);
	level.scr_anim["moody"]["getout"]		= (%step_up_low_wall);
	level.scr_anim["moody"]["pickup"]		= (%brecourt_moody_moodypickupwoundedman);
	level.scr_anim["moody"]["walkback"]		= (%brecourt_moody_moodypluswoundedman_walk);

	level.scr_anim["moody"]["putdown"]		= (%c_us_bastogne2_moody_putdownwoundedman);
//	level.scr_anim["moody"]["putdown"]		= (%brecourt_moody_moodyputsdownwoundedman);
	level.scr_anim["moody"]["death"]		= (%brecourt_moody_moodywoundedmandeath);
	level.scr_anim["moody"]["death2"]		= (%brecourt_moody_moodywoundedmandeath);
	level.scr_anim["moody"]["deathidle"]		= (%brecourt_moody_moodywoundedmandeath_idle);
	level.scr_anim["moody"]["deathidle2"]		= (%brecourt_moody_moodywoundedmandeath_idle);
	
	
	level.scr_anim["moody"]["moody_brief1_intro"]		= (%c_us_bastogne2_moody_tent);
//	level.scr_face["moody"]["moody_brief1_intro"]		= (%f_bastogne2_moody_brief1);
	
	level.scr_face["moody"]["moody_brief1"]			= (%f_bastogne2_moody_brief1);
 	level.scrsound["moody"]["moody_brief1"]			= "moody_brief1";
 	
 	level.scr_face["moody"]["moody_brief2"]			= (%f_bastogne2_moody_brief2);
 	level.scrsound["moody"]["moody_brief2"]			= "moody_brief2";
 	
 	level.scr_face["moody"]["moody_yessir"]			= (%f_bastogne2_moody_yessir);
 	level.scrsound["moody"]["moody_yessir"]			= "moody_yessir";
 	
 	level.scr_face["moody"]["moody_runforit"]		= (%f_bastogne2_moody_runforit);
 	level.scrsound["moody"]["moody_runforit"]		= "moody_runforit";
	level.scr_anim["moody"]["moody_runforit"]		= (%c_us_bastogne2_moody_runforit);

 	
 	level.scr_face["moody"]["moody_wounded"]		= (%f_bastogne2_moody_wounded);
 	level.scrsound["moody"]["moody_wounded"]		= "moody_wounded";


	level.scr_anim["moody"]["open_mill_door"]		=(%trenches_antonov_mill_door);
 	
 	level.scr_face["moody"]["moody_surprise"]		= (%f_bastogne2_moody_surprise);
 	level.scrsound["moody"]["moody_surprise"]		= "moody_surprise";
 
 	level.scr_face["moody"]["moody_get_moving"]		= (%PegDay_facial_Friend1_01_incoming);
 	level.scrsound["moody"]["moody_get_moving"]		= "moody_get_moving";

 	level.scr_face["moody"]["moody_hangin"]			= (%f_bastogne2_moody_hangin);
 	level.scrsound["moody"]["moody_hangin"]			= "moody_hangin";

	level.scr_face["moody"]["moody_lookin_good"]		= (%f_bastogne2_moody_lookin_good);
 	level.scrsound["moody"]["moody_lookin_good"]		= "moody_lookin_good";

	level.scr_face["moody"]["moody_keep_moving_forward"]	= (%f_bastogne2_moody_keep_moving_forward);
 	level.scrsound["moody"]["moody_keep_moving_forward"]	= "moody_keep_moving_forward";


	level.scr_face["moody"]["moody_not_now"]		= (%f_bastogne2_moody_not_now);
 	level.scrsound["moody"]["moody_not_now"]		= "moody_not_now";

 	level.scr_face["moody"]["moody_hold"]			= (%f_bastogne2_moody_hold);
 	level.scrsound["moody"]["moody_hold"]			= "moody_hold";


 	level.scrsound["moody"]["moody_cover_me"]		= "moody_cover_me";
 	
 	level.scr_face["moody"]["moody_lucky"]			= (%f_bastogne2_moody_lucky);
 	level.scrsound["moody"]["moody_lucky"]			= "moody_lucky";
 	
// 	level.scr_face["moody"]["moody_terrific"]		= (%PegDay_facial_Friend1_01_incoming);
// 	level.scrsound["moody"]["moody_terrific"]		= "moody_terrific";

 	level.scr_face["moody"]["moody_theres_our_boy"]		= (%PegDay_facial_Friend1_01_incoming);
 	level.scrsound["moody"]["moody_theres_our_boy"]		= "moody_theres_our_boy";

 	level.scr_face["moody"]["moody_flares"]			= (%f_bastogne2_moody_flares);
 	level.scrsound["moody"]["moody_flares"]			= "moody_flares";
 	
 	level.scr_face["moody"]["moody_grenades"]		= (%f_bastogne2_moody_grenades);
 	level.scrsound["moody"]["moody_grenades"]		= "moody_grenades";
 	
 	level.scr_face["moody"]["moody_spike88"]		= (%f_bastogne2_moody_spike88);
 	level.scrsound["moody"]["moody_spike88"]		= "moody_spike88";

 	
 	level.scr_face["moody"]["moody_threats"]		= (%PegDay_facial_Friend1_01_incoming);
 	level.scrsound["moody"]["moody_threats"]		= "moody_threats";


//	level.scr_anim["koppel"]["moody_back_of_house"]	= 	(%c_us_bastogne2_koppel_interrogation);
//
//	level.scr_notetrack["koppel"][0]["notetrack"]		= "moody_back_of_house";
//	level.scr_notetrack["koppel"][0]["dialogue"]		= "moody_back_of_house";


 	level.scr_face["moody"]["moody_back_of_house"]		= (%f_bastogne2_moody_back_of_house);
 	level.scrsound["moody"]["moody_back_of_house"]		= "moody_back_of_house";

 	level.scr_face["moody"]["moody_crossfire"]		= (%f_bastogne2_moody_crossfire);
 	level.scrsound["moody"]["moody_crossfire"]		= "moody_crossfire";
 	
 	level.scr_face["moody"]["moody_clear_down"]		= (%f_bastogne2_moody_clear_down);
 	level.scrsound["moody"]["moody_clear_down"]		= "moody_clear_down";
 	
 //	level.scr_face["moody"]["moody_translate"]		= (%f_bastogne2_moody_translate);
 //	level.scrsound["moody"]["moody_translate"]		= "moody_spike88";
 	
// 	level.scr_face["moody"]["moody_missing_patrol"]		= (%f_bastogne2_moody_missing_patrol);
// 	level.scrsound["moody"]["moody_missing_patrol"]		= "moody_missing_patrol";
 	
// 	level.scr_face["moody"]["moody_ask_again"]		= (%f_bastogne2_moody_ask_again);
// 	level.scrsound["moody"]["moody_ask_again"]		= "moody_ask_again";
// 	
// 	level.scr_face["moody"]["moody_more_like_it"]		= (%f_bastogne2_moody_more_like_it);
// 	level.scrsound["moody"]["moody_more_like_it"]		= "moody_more_like_it";
 	
 	level.scr_face["moody"]["moody_shutup"]			= (%f_bastogne2_moody_shutup);
 	level.scrsound["moody"]["moody_shutup"]			= "moody_shutup";

 	level.scr_face["moody"]["moody_goto_barn"]		= (%f_bastogne2_moody_goto_barn);
 	level.scrsound["moody"]["moody_goto_barn"]		= "moody_goto_barn";

 	level.scr_face["moody"]["moody_along_ridge"]		= (%f_bastogne2_moody_along_ridge);
 	level.scrsound["moody"]["moody_along_ridge"]		= "moody_along_ridge";

 	level.scr_face["moody"]["moody_heavy_fire"]		= (%f_bastogne2_moody_heavy_fire);
 	level.scrsound["moody"]["moody_heavy_fire"]		= "moody_heavy_fire";

 	level.scr_face["moody"]["moody_thats_ramirez"]		= (%f_bastogne2_moody_that_ramirez);
 	level.scrsound["moody"]["moody_thats_ramirez"]		= "moody_thats_ramirez";
	
 	level.scr_face["moody"]["moody_crossroad"]		= (%f_bastogne2_moody_crossroad);
 	level.scrsound["moody"]["moody_crossroad"]		= "moody_crossroad";
 	
 	level.scr_face["moody"]["moody_silence_mg42"]		= (%f_bastogne2_moody_silence_mg42);
 	level.scrsound["moody"]["moody_silence_mg42"]		= "moody_silence_mg42";
	level.scr_anim["moody"]["moody_silence_mg42"]		= (%c_us_bastogne2_moody_silence_mg42);

 	
 	level.scr_face["moody"]["moody_goto_ambush"]		= (%f_bastogne2_moody_goto_ambush);
 	level.scrsound["moody"]["moody_goto_ambush"]		= "moody_goto_ambush";
	level.scr_anim["moody"]["moody_goto_ambush"]		= (%c_us_bastogne2_moody_goto_ambush);
 	
 	level.scr_face["moody"]["moody_hit_dirt"]		= (%f_bastogne2_moody_hit_dirt);
 	level.scrsound["moody"]["moody_hit_dirt"]		= "moody_hit_dirt";
 	
 	level.scr_face["moody"]["moody_mg34"]			= (%f_bastogne2_moody_mg34);
 	level.scrsound["moody"]["moody_mg34"]			= "moody_mg34";
 	
 	level.scr_face["moody"]["moody_scrap_panzer"]		= (%f_bastogne2_moody_scrap_panzer);
 	level.scrsound["moody"]["moody_scrap_panzer"]		= "moody_scrap_panzer";
 	
 	level.scr_face["moody"]["moody_helluva_fight"]		= (%f_bastogne2_moody_helluva_fight);
 	level.scrsound["moody"]["moody_helluva_fight"]		= "moody_helluva_fight";
 	
 	level.scr_face["moody"]["moody_letsgo"]			= (%f_bastogne2_moody_letsgo);
 	level.scrsound["moody"]["moody_letsgo"]			= "moody_letsgo";
 	
 	level.scr_face["moody"]["moody_shaddup"]		= (%f_bastogne2_moody_shaddup);
 	level.scrsound["moody"]["moody_shaddup"]		= "moody_shaddup";
 	
 	level.scr_anim["moody"]["moody_melee1"]			= (%melee_right2right_1);

	//Moody heregoes
	level.scr_anim["moody"]["moody_melee2"]			= (%melee_left2left_1);

// Fire in the hole
	level.scrsound["moody"]["fire_in_the_hole"]			= "fire_in_the_hole";
	level.scr_face["moody"]["fire_in_the_hole"]			= (%PegDay_facial_Friend1_01_incoming);
}

anderson()
{
	level.scr_character["anderson"] 				= character\Airborne1b_carbine_snow::main;
	level.scr_animtree["anderson"]					= #animtree;
}

whitney()
{
	level.scr_character["whitney"] 					= character\Airborne1b_garand_snow::main;
	level.scr_animtree["whitney"]					= #animtree;
}

// red group anims
red()
{
	level.scr_character["red_0"] 					= character\Airborne1b_garand_snow::main;
	level.scr_animtree["red_0"]					= #animtree;
	level.scr_character["red_1"] 					= character\Airborne1b_thompson_snow::main;
	level.scr_animtree["red_1"]					= #animtree;
}

// guy who gets owned at the start of the level by the mg42
powned()
{
	level.scr_character["powned"] 					= character\Airborne1b_thompson_snow::main;
	level.scr_animtree["powned"]					= #animtree;

	//Wounded Guy Animations
	level.scr_anim["powned"]["idle"] 		= (%brecourt_woundedman_idle);
	level.scr_anim["powned"]["pickup"]		= (%brecourt_man_moodypickupwoundedman);
	level.scr_anim["powned"]["walkback"]		= (%brecourt_man_moodypluswoundedman_walk);


	level.scr_anim["powned"]["putdown"]		= (%c_us_bastogne2_moan_moodyputdownwoundedman);
//	level.scr_anim["powned"]["putdown"]		= (%brecourt_man_moodyputsdownwoundedman);
	level.scr_anim["powned"]["death"]		= (%brecourt_man_moodywoundedmandeath);
	level.scr_anim["powned"]["deathidle"]		= (%brecourt_man_moodywoundedmandeath_idle);
}

contact()
{
	level.scr_character["contact"] 					= character\Airborne1b_garand_snow::main;
	level.scr_animtree["contact"]					= #animtree;
}

foley()
{
	level.scr_anim["foley"]["foley_brief1"]			= (%c_us_bastogne2_foley_tent);
	level.scr_face["foley"]["foley_brief1"]			= (%f_bastogne2_foley_brief1);
 	level.scrsound["foley"]["foley_brief1"]			= "foley_brief1";

 	level.scrsound["foley"]["paper_slide_desk"]		= "paper_slide_desk";
 	
 	level.scr_face["foley"]["foley_brief2"]			= (%f_bastogne2_foley_brief2);
 	level.scrsound["foley"]["foley_brief2"]			= "foley_brief2";
 	
 	level.scr_face["foley"]["foley_brief3"]			= (%f_bastogne2_foley_brief3);
 	level.scrsound["foley"]["foley_brief3"]			= "foley_brief3";
 	
 // 	level.scr_face["foley"]["foley_brief4"]			= (%f_bastogne2_foley_brief4);
 	level.scrsound["foley"]["foley_brief4"]			= "foley_brief4";
 
 // 	level.scr_face["foley"]["foley_brief5"]			= (%f_bastogne2_foley_brief5);
 	level.scrsound["foley"]["foley_brief5"]			= "foley_brief5";
 	
 	level.scr_face["foley"]["foley_dismissed"]		= (%f_bastogne2_foley_dismissed);
 	level.scrsound["foley"]["foley_dismissed"]		= "foley_dismissed";
 	
 	level.scr_face["foley"]["foley_digin"]			= (%f_bastogne2_foley_digin);
 	level.scrsound["foley"]["foley_digin"]			= "foley_digin";
}

others()
{


	level.scr_anim["denny"]["denny_interrogation"]		= (%c_us_bastogne2_denny_interrogation);

	level.scr_face["anderson"]["anderson_what"]		= (%f_bastogne2_anderson_what);
	level.scrsound["anderson"]["anderson_what"]		= "anderson_what";

	level.scr_face["anderson"]["anderson_hesgothim"]	= (%PegDay_facial_Friend1_01_incoming);
	level.scrsound["anderson"]["anderson_hesgothim"]	= "anderson_hesgothim";

	level.scr_face["anderson"]["anderson_sarge"]		= (%f_bastogne2_anderson_sarge);
	level.scrsound["anderson"]["anderson_sarge"]		= "anderson_sarge";
	 
	level.scr_face["whitney"]["whitney_ohman"]		= (%f_bastogne2_whitney_ohman);
	level.scrsound["whitney"]["whitney_ohman"]		= "whitney_ohman";
	
	level.scr_face["whitney"]["whitney_freezin"]		= (%f_bastogne2_whitney_freezin);
	level.scrsound["whitney"]["whitney_freezin"]		= "whitney_freezin";

	level.scr_face["whitney"]["whitney_bobby_hit"]		= (%f_bastogne2_whitney_bobby_hit);
	level.scrsound["whitney"]["whitney_bobby_hit"]		= "whitney_bobby_hit";

	level.scr_face["whitney"]["whitney_keep_firing"]	= (%f_bastogne2_whitney_keepfiring);
	level.scrsound["whitney"]["whitney_keep_firing"]	= "whitney_keepfiring";

	level.scr_face["whitney"]["whitney_comeonsarge"]	= (%f_bastogne2_whitney_comeonsarge);
	level.scrsound["whitney"]["whitney_comeonsarge"]	= "whitney_comeonsarge";

	level.scr_face["whitney"]["whitney_convoy"]		= (%f_bastogne2_whitney_convoy);
	level.scrsound["whitney"]["whitney_convoy"]		= "whitney_convoy";
 	level.scr_anim["whitney"]["whitney_convoy"]		= (%c_us_bastogne2_whitney_convoy); 

	
	level.scr_anim["jones"]["jones_intro"]			= (%c_us_bastogne2_jones_tent);
	level.scr_face["jones"]["jones_yessir"]			= (%f_bastogne2_jones_yessir);
 	level.scrsound["jones"]["jones_yessir"]			= "jones_yessir";
 	
 	level.scr_anim["ramirez"]["ramirez_intro"]		= (%c_us_bastogne2_ramirez_tent);


 	level.scr_face["ramirez"]["ramirez_gotit"]		= (%f_bastogne2_ramirez_gotit);
 	level.scrsound["ramirez"]["ramirez_gotit"]		= "ramirez_gotit";

 	level.scr_face["ramirez"]["ramirez_yessir"]		= (%f_bastogne2_ramirez_yessir);
 	level.scrsound["ramirez"]["ramirez_yessir"]		= "ramirez_yessir";

 	
 	level.scr_face["gunner_30cal"]["gunner_30cal_strike"]	= (%f_bastogne2_gunner_30cal_strike);
 	level.scrsound["gunner_30cal"]["gunner_30cal_strike"]	= "gunner_30cal_strike";
 	
 //	level.scr_face["gunner_30cal"]["gunner_30cal_dugin"]	= (%f_bastogne2_gunner_30cal_dugin);
 //	level.scrsound["gunner_30cal"]["gunner_30cal_dugin"]	= "gunner_30cal_dugin";
 	
 	level.scr_face["gunner_30cal"]["gunner_30cal_dugin2"]	= (%PegDay_facial_Friend1_01_incoming);
 	level.scrsound["gunner_30cal"]["gunner_30cal_dugin2"]	= "gunner_30cal_dugin2";


	level.scr_anim["gunner_30cal"]["sit_idle"][0]		= (%c_us_bastogne2_goldberg_crouch_idle);

 	level.scr_face["trooper"]["trooper_officer"]		= (%f_bastogne2_trooper_officer);
	level.scr_anim["trooper"]["trooper_officer"]		= (%c_us_bastogne2_trooper_officer);
 	level.scrsound["trooper"]["trooper_officer"]		= "trooper_officer";


	
// KOppel anim/notetrack fun


// 	level.scr_face["koppel"]["koppel_translate"]		= (%f_bastogne2_koppel_translate);
// 	level.scrsound["koppel"]["koppel_translate"]		= "koppel_translate";
// 	
// 	level.scr_face["koppel"]["koppel_translate_patrol"]	= (%f_bastogne2_koppel_translate_patrol);
// 	level.scrsound["koppel"]["koppel_translate_patrol"]	= "koppel_translate_patrol";
// 	
// 	level.scr_face["koppel"]["koppel_no_luck"]		= (%f_bastogne2_koppel_no_luck);
// 	level.scrsound["koppel"]["koppel_no_luck"]		= "koppel_no_luck";
// 	
// 	level.scr_face["koppel"]["koppel_are_you_sure"]		= (%f_bastogne2_koppel_are_you_sure);
// 	level.scrsound["koppel"]["koppel_are_you_sure"]		= "koppel_are_you_sure";
// 	
// 	level.scr_face["koppel"]["koppel_show_us"]		= (%f_bastogne2_koppel_where_our_men);
// 	level.scrsound["koppel"]["koppel_show_us"]		= "koppel_show_us";









// german officer///
 
//	level.scr_anim["g_officer"]["gofficer_interrogation"]	= (%c_us_bastogne2_gofficer_interrogation);


 //	level.scr_face["g_officer"]["gofficer_know_nothing"]	= (%f_bastogne2_gofficer_know_nothing);
 //	level.scrsound["g_officer"]["gofficer_know_nothing"]	= "gofficer_know_nothing";

//	level.scr_notetrack["g_officer"][0]["notetrack"]	= "gofficer_know_nothing";
//	level.scr_notetrack["g_officer"][0]["dialogue"]		= "gofficer_know_nothing";
//	level.scr_notetrack["g_officer"][0]["facial"]		= (%f_bastogne2_gofficer_know_nothing);

//	level.scr_notetrack["g_officer"][1]["notetrack"]		= "gofficer_cooperate";
//	level.scr_notetrack["g_officer"][1]["dialogue"]		= "gofficer_cooperate";
//	level.scr_notetrack["g_officer"][1]["facial"]		= (%f_bastogne2_gofficer_cooperate);



 //	level.scr_face["g_officer"]["gofficer_alarm"]		= (%f_bastogne2_gofficer_alarm);
//	level.scr_anim["g_officer"]["gofficer_alarm"]		= (%c_us_bastogne2_gofficer_alarm);
 //	level.scrsound["g_officer"]["gofficer_alarm"]		= "gofficer_alarm";


	level.scr_anim["medic"]["medic_wall"]			= (%c_medic_wall_interact);

	level.scr_anim["medic"]["medic_run"]			= (%c_medic_wall_run);

	level.scr_anim["medic"]["medic_wall_idle"][0]        	= (%c_medic_wall_idle);
	


	level.scr_anim["g_officer"]["gofficer_dead"]		= (%c_us_bastogne2_gofficer_dead);

	level.scr_anim["g_officer"]["stand_idle"][0]		= (%c_prisoner_idle_A);


	level.scr_anim["g_officer"]["walk_idle"][0]		= (%c_prisoner_walk_c);

 	level.scr_face["tanker"]["tanker_nicework"]		= (%f_bastogne2_tanker_nicework);
 	level.scrsound["tanker"]["tanker_nicework"]		= "tanker_nicework";
}

/*
wounded guy - neck
attach neckguy to the tag_origin in the stretcher xmodel.
*/
#using_animtree("generic_human"); // need to add anim to generic_human file so this can be called...
neckguy()
{	
	level.scr_animtree["neckguy"] = #animtree;
	level.scr_anim["neckguy"]["idle"][0]					= (%c_wounded_wallA_idle);
	level.scr_face["neckguy"]["idle"][0]					= (%facial_pain);
	level.scr_anim["neckguy"]["idleweight"][0]				= 1.0;
	level.scr_anim["neckguy"]["idle"][1]					= (%c_wounded_wallA_twitch);
	level.scr_face["neckguy"]["idle"][1]					= (%facial_yell);
	level.scr_anim["neckguy"]["idleweight"][1]				= 1.0;

//	level.scr_character["neckguy"] = character\RussianArmyWoundedTunic ::main;
}

/*
wounded guy - neckguy2
attach neckguy to the tag_origin in the stretcher xmodel.
*/
#using_animtree("generic_human"); // need to add anim to generic_human file so this can be called...
wallb()
{	
	level.scr_animtree["wallb"] = #animtree;
	level.scr_anim["wallb"]["idle"][0]					= (%c_wounded_wallB_idle);
	level.scr_face["wallb"]["idle"][0]					= (%facial_pain);
	level.scr_anim["wallb"]["idleweight"][0]				= 1.0;
	level.scr_anim["wallb"]["idle"][1]					= (%c_wounded_wallB_interact);
	level.scr_face["wallb"]["idle"][1]					= (%facial_yell);
	level.scr_anim["wallb"]["idleweight"][1]				= 1.0;

//	level.scr_character["neckguy"] = character\RussianArmyWoundedTunic ::main;
}

/*
wounded guy - laying
attach neckguy to the tag_origin in the stretcher xmodel.
*/
#using_animtree("generic_human"); // need to add anim to generic_human file so this can be called...
laying()
{	
	level.scr_animtree["laying"] = #animtree;
	level.scr_anim["laying"]["idle"][0]					= (%c_wounded_layingA_idle);
	level.scr_face["laying"]["idle"][0]					= (%facial_pain);
	level.scr_anim["laying"]["idleweight"][0]				= 1.0;
	level.scr_anim["laying"]["idle"][1]					= (%c_wounded_layingA_idle);
	level.scr_face["laying"]["idle"][1]					= (%facial_yell);
	level.scr_anim["laying"]["idleweight"][1]				= 1.0;

//	level.scr_character["neckguy"] = character\RussianArmyWoundedTunic ::main;
}

#using_animtree("bastogne2_map");
map_table_anim()
{	
	level.scr_animtree["map"]					= #animtree;
	level.scr_anim["map"]["map_anim"]				= (%bastogne2_map);
}

