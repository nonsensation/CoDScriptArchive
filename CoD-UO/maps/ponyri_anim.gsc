

main()
{
	// generic_human
	Antonov();
	Ending_Commissar();

	//ponyri_dummies
	Rail_Panzerfaust_Guy();
}

#using_animtree("generic_human");
Antonov()
{
	level.scr_anim["antonov"]["introspeech2"]		= (%antonov_introspeech_p);
	level.scrsound["antonov"]["introspeech2"]		= "antonov_introspeech2";
	level.scr_face["antonov"]["introspeech2"]		= %antonov_speech1_2_f_p;

	// pre mortar speech
	level.scr_anim["antonov"]["town_briefing"]			= (%antonov_speech2_p);
	level.scrsound["antonov"]["town_briefing"]			= "antonov_speech2";
	level.scr_face["antonov"]["town_briefing"]			= %antonov_speech2_f_p;

	// When he kicks the door in the railstation
	level.scr_anim["antonov"]["kick_door_1"] 			= (%chateau_kickdoor1);
	level.scr_anim["antonov"]["kick_door_2"] 			= (%chateau_kickdoor2);

//	level.scr_face[""][""]			= (%anon_almostthere_f_p);
//	level.scr_face[""][""]			= (%anon_catwalk_f_p);
//	level.scr_face[""][""]			= (%anon_goodshot_f_p);
//	level.scr_face[""][""]			= (%anon_sergeant_f_p);
//	level.scr_face[""][""]			= (%anon_thrudoors_f_p);
	level.scr_face["redshirt"]["anon_tooquiet1"]			= (%anon_tooquiet1_f_p);
	level.scrsound["redshirt"]["anon_tooquiet1"]			= "anon_tooquiet1";
	level.scr_face["redshirt"]["anon_tooquiet2"]			= (%anon_tooquiet2_f_p);
	level.scrsound["redshirt"]["anon_tooquiet2"]			= "anon_tooquiet2";
	level.scr_face["redshirt"]["anon_tooquiet3"]			= (%anon_tooquiet3_f_p);
	level.scrsound["redshirt"]["anon_tooquiet3"]			= "anon_tooquiet3";
	level.scr_face["redshirt"]["anon_tooquiet4"]			= (%anon_tooquiet4_f_p);
	level.scrsound["redshirt"]["anon_tooquiet4"]			= "anon_tooquiet4";

	level.scr_face["antonov"]["antonov_assault"]		= (%antonov_assault_f_p);
	level.scrsound["antonov"]["antonov_assault"]		= "antonov_assault";
	level.scr_face["antonov"]["antonov_basement2"]		= (%antonov_basment2_f_p);
	level.scrsound["antonov"]["antonov_basement2"]		= "antonov_basement2";
	level.scr_face["antonov"]["antonov_basement"]		= (%antonov_basment_f_p);
//	level.scr_anim["antonov"]["antonov_basement"]		= (%antonov_basment_p);
	level.scrsound["antonov"]["antonov_basement"]		= "antonov_basement";
//	level.scr_face["antonov"][""]		= (%antonov_explosives2_f_p);
//	level.scr_face["antonov"][""]		= (%antonov_explosives_f_p);
//	level.scr_face["antonov"][""]		= (%antonov_getback_f_p);
//	level.scr_face["antonov"][""]		= (%antonov_grenades_f_p);
	level.scr_face["antonov"]["antonov_intostation"]	= (%antonov_intostation_f_p);
	level.scrsound["antonov"]["antonov_intostation"]	= "antonov_intostation";
	level.scr_anim["antonov"]["antonov_intostation"]	= (%antonov_intostation_p);
	level.scr_face["antonov"]["antonov_outflank"]		= (%antonov_outflank_f_p);
	level.scrsound["antonov"]["antonov_outflank"]		= "antonov_outflank";
//	level.scr_face["antonov"]["antonov_panzer_move"]	= (%antonov_panzer_move_f_p);
//	level.scrsound["antonov"]["antonov_panzer_move"]	= "antonov_panzer_move";
	level.scr_face["antonov"]["antonov_killtank1"]		= (%antonov_killtank1_f_p);		// FIXME - uncomment
	level.scrsound["antonov"]["antonov_killtank1"]		= "antonov_killtank1";
	level.scr_face["antonov"]["antonov_killtank2"]		= (%antonov_killtank2_f_p);		// FIXME - uncomment
	level.scrsound["antonov"]["antonov_killtank2"]		= "antonov_killtank2";
	level.scr_face["antonov"]["antonov_pfaust2"]		= (%antonov_pfaust2_f_p);
	level.scrsound["antonov"]["antonov_pfaust2"]		= "antonov_pfaust2";
	level.scr_face["antonov"]["antonov_pfaust"]			= (%antonov_pfaust_f_p);
	level.scrsound["antonov"]["antonov_pfaust"]			= "antonov_pfaust";
	level.scr_face["antonov"]["antonov_railsnipers"]	= (%antonov_railsnipers2_f_p);
	level.scrsound["antonov"]["antonov_railsnipers"]	= "antonov_railsnipers";
	level.scr_face["antonov"]["antonov_regroup1"]		= (%antonov_regroup1_f_p);
	level.scrsound["antonov"]["antonov_regroup1"]		= "antonov_regroup1";
	level.scr_face["antonov"]["antonov_regroup2"]		= (%antonov_regroup2_f_p);
	level.scrsound["antonov"]["antonov_regroup2"]		= "antonov_regroup2";
	level.scr_face["antonov"]["antonov_secure"]			= (%antonov_secure_f_p);
	level.scrsound["antonov"]["antonov_secure"]			= "antonov_secure";
//	level.scr_face["antonov"][""]		= (%antonov_speech3_f_p);
	level.scr_face["antonov"]["antonov_stopmg"]			= (%antonov_stopmg_f_p);
	level.scrsound["antonov"]["antonov_stopmg"]			= "antonov_stopmg";
	level.scr_face["antonov"]["antonov_stopmg2"]		= (%antonov_stopmg2_f_p);		// FIXME - uncomment
	level.scrsound["antonov"]["antonov_stopmg2"]		= "antonov_stopmg2";
	level.scr_face["antonov"]["antonov_tankcover"]		= (%antonov_tankscover_f_p);
	level.scrsound["antonov"]["antonov_tankcover"]		= "antonov_tankcover";
//	level.scr_face["antonov"][""]		= (%antonov_watch_back_f_p);

	// boris (or whoever) planting the bomb on the panzer
	level.scr_anim["antonov"]["plants_bomb_panzer_p"] 	= (%plants_bomb_panzer_p);
	level.scr_anim["boris"]["plants_bomb_panzer_p"] 	= (%plants_bomb_panzer_p);

//	level.scr_face["boris"][""]		= (%boris_medic_f_p);
//	level.scr_face["boris"][""]		= (%boris_takecover_f_p);
//	level.scr_face["miesha"][""]		= (%miesha_knocking_f_p);
	
	level.scr_face["vassili"]["vassili_headsdown"]		= (%vassili_headsdown_f_p);
	level.scrsound["vassili"]["vassili_headsdown"]		= "vassili_headsdown";
//	level.scr_face["vassili"][""]		= (%vassili_takecover1_f_p);
//	level.scr_face["vassili"][""]		= (%vassili_takecover2_f_p);
//	level.scr_face["vassili"][""]		= (%vassili_takecover4_f_p);
}

Ending_Commissar()
{
	// factory end speech
	level.scr_anim["commissar"]["fact_ending"]			= (%commissar_ending_p);
	level.scrsound["commissar"]["fact_ending"]			= "COMMISSAR_ENDING";
	level.scr_face["commissar"]["fact_ending"]			= %comm_ending_f_p;
}

#using_animtree("ponyri_dummies");
Rail_Panzerfaust_Guy()
{
	level.scr_character["german"][0] 					= character\wehrmacht_soldier::main;
	level.scr_character["russian"][0] 					= character\RussianArmy::main;

	// general
	level.scr_anim["dummy"]["run"][0]					= (%sprint1_loop);
	level.scr_anim["dummy"]["run"][1]					= (%stand_shoot_run_forward);
	level.scr_anim["dummy"]["run"][2]					= (%crouchrun_loop_forward_1);

	level.scr_anim["dummy"]["death"][0]					= (%death_run_forward_crumple);
	level.scr_anim["dummy"]["death"][1]					= (%crouchrun_death_drop);
	level.scr_anim["dummy"]["death"][2]					= (%crouchrun_death_crumple);
	level.scr_anim["dummy"]["death"][3]					= (%death_run_onfront);
	level.scr_anim["dummy"]["death"][4]					= (%death_run_onleft);
	level.scr_anim["dummy"]["death"][5]					= (%death_explosion_back13);

	// panzerfaust guy
	level.scr_anim["dummy"]["pfstand2crouch"][0]		= (%panzerfaust_standidle2crouchaim);


}
