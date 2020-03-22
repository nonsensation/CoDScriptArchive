#using_animtree("generic_human");

main()
{
	
	
	level.scr_anim["waving guy"]["idle"][0] = (%wave_mp40guy_comeon);
	level.scr_anim["waving guy"]["idleweight"][0]	= 2;
	
	level.scr_anim["waving guy"]["idle"][1] = (%wave_mp40guy_flank);
	level.scr_anim["waving guy"]["idleweight"][1]	= 0.4;
	
	level.scr_anim["waving guy"]["idle"][2] = (%wave_mp40guy_go);
	level.scr_anim["waving guy"]["idleweight"][2]	= 0.9;
	
	level.scr_anim["waving guy"]["idle"][3] = (%wave_mp40guy_gogo);
	level.scr_anim["waving guy"]["idleweight"][3]	= 0.6;
	
	level.scr_anim["waving guy"]["idle"][4] = (%wave_mp40guy_what);
	level.scr_anim["waving guy"]["idleweight"][4]	= 0.2;
	
	largegroup();
	tank();
}

dialog()
{
	//*-1a. All right guys, get set to move, on my command!	
	//level.scr_anim["foley"]["intro"]				= (%fullbody_foley1);
	//level.scr_face["foley"]["intro"]				= (%facial_foley1);
	//level.scrsound["foley"]["intro"]				= ("burnville_foley_1a");
	
	//1. Listen, comrade! We're both dead men, whether we stay here, or go back! Let's you and I find a way to flank them!
	level.scrsound["smartguy"]["findwaytoflank"]		= "redsquare_clever1";
	level.scr_anim["smartguy"]["findwaytoflank"]		= (%Redsquare_Clever_01_listencomrade);
	level.scr_face["smartguy"]["findwaytoflank"]		= (%Redsquare_facial_Clever_01_listencomrade);
	
	//2. Alexei, over there!
	level.scrsound["smartguy"]["alexeioverthere"]		= "redsquare_clever2";
	level.scr_face["smartguy"]["alexeioverthere"]		= (%Redsquare_facial_Clever_02_alexeioverthere);
	
	//3. Take down the officers first! They're calling in reinforcements!
	level.scrsound["smartguy"]["officersfirst"]		= "redsquare_clever3";
	level.scr_face["smartguy"]["officersfirst"]		= (%Redsquare_facial_Clever_03_takedownofficers);
	
	//4. Get word to Major Zubov that we've retaken Red Square. You'll report to him from here on out.
	level.scrsound["smartguy"]["gotozubov"]			= "redsquare_clever4";
	level.scr_face["smartguy"]["gotozubov"]			= (%Redsquare_facial_Clever_04_getwordtomajor);
	
	//Extra anim
	//level.scr_anim["smartguy"]["wave"]			= (%fullbody_foley_wave);
	level.scr_anim["smartguy"]["wave"]			= %dawn_foley_waving_followme;
	
	//*** COMMISSARS at INTRO
	
	//5. Turn around! Keep going forward!
	level.scrsound["commissar1"]["turnaround"]		= "redsquare_commissar1_01";
	level.scr_face["commissar1"]["turnaround"]		= (%Redsquare_facial_Comm1_01_turnaround);
	level.scr_anim["commissar1"]["turnaround"]		= (%Leader_pistolwave);
	//level.scr_anim["commissar1"]["turnaround"]		= (%Leader_shout_A);
	//level.scr_anim["commissar1"]["turnaround"]		= (%Leader_shout_C);
	//level.scr_anim["commissar1"]["turnaround"]		= (%Leader_shout_B);
	//level.scr_anim["commissar1"]["turnaround"]		= (%Leader_pistolpoint);
	
	level.scrsound["commissar4"]["turn2"]		= "redsquare_commissar1_01";
	level.scr_face["commissar4"]["turn2"]		= (%Redsquare_facial_Comm1_01_turnaround);
	
	//6. No retreat! Not one step back!
	level.scrsound["commissar2"]["noretreat"]		= "redsquare_commissar2_02";
	level.scr_face["commissar2"]["noretreat"]		= (%Redsquare_facial_Comm2_02_noretreat);
	
	//7. No mercy for cowards!
	level.scrsound["commissar2"]["nomercycowards"]		= "redsquare_commissar2_03";
	level.scr_face["commissar2"]["nomercycowards"]		= (%Redsquare_facial_Comm2_05_nomercy);
	
	//12. Pick up your gun and shoot!
	level.scrsound["commissar3"]["pickupyourgun"]		= "redsquare_commissar3_08";
	level.scr_anim["commissar3"]["pickupyourgun"]		= (%line_officerA_wave);
	level.scr_face["commissar3"]["pickupyourgun"]		= (%stalingrad_Commissar1_facial_86_pickupyourgun);
	
	level.scrsound["commissar2"]["pickupgun2"]		= "redsquare_commissar3_08";
	level.scr_face["commissar2"]["pickupgun2"]		= (%stalingrad_Commissar1_facial_86_pickupyourgun);
	
	//*** COMMISSARS FIRING
	
	//8. Open fire!
	level.scrsound["commissar1"]["openfire"]		= "redsquare_commissar1_04";
	level.scr_anim["commissar1"]["openfire"]		= (%Leader_pistolpoint);
	
	//9. No mercy for deserters!
	level.scrsound["commissar2"]["nomercydeserters"]	= "redsquare_commissar2_05";
	level.scr_face["commissar2"]["nomercydeserters"]	= (%Redsquare_facial_Comm2_05_nomercy);
	level.scr_anim["commissar2"]["nomercydeserters"]	= (%Leader_pistolwave);
	
	//10. FIRE!
	level.scrsound["commissar3"]["fire"]			= "redsquare_commissar1_06";
	level.scr_face["commissar3"]["fire"]			= (%Redsquare_facial_Comm4c_fire);
	level.scr_anim["commissar3"]["fire"]			= (%line_officerA_wave);
	
	//11. Traitors!
	level.scrsound["commissar1"]["traitors"]		= "redsquare_commissar1_07";
	level.scr_face["commissar1"]["traitors"]		= (%Redsquare_facial_Comm1_07_traitors);
	level.scr_anim["commissar1"]["traitors"]		= (%Leader_shout_A);
	
	//*** COMMISSARS PEP TALK
	
	//13. No hesitation comrades! Do not take one step backwards!
	level.scrsound["commissar3"]["nohesitation"]		= "redsquare_commissar3_09";
	level.scr_face["commissar3"]["nohesitation"]		= (%stalingrad_Commissar2_facial_52_nohesitation);
	
	//14. Come on, come on, come on!
	level.scrsound["commissar1"]["comeoncomeon"]		= "redsquare_commissar1_10";
	
	//15. For Mother Russia comrades! Do not turn your back on her!
	level.scr_anim["commissar1"]["lookleft_formotherrussia"]	= (%stand_aim_look_left_90);
	level.scr_anim["commissar1"]["lookright_formotherrussia"]	= (%stand_aim_look_right_90);
	level.scrsound["commissar1"]["formotherrussia"]		= "redsquare_commissar1_11";
	level.scr_anim["commissar1"]["formotherrussia"]		= (%Redsquare_opening_formotherrussia);
	level.scr_face["commissar1"]["formotherrussia"]		= (%stalingrad_Commissar4_facial_50_forMotherRussia);
	
	level.scr_anim["commissar1"]["idling"][0]		= (%scripted_pistol_idle);
	
	//16. Victory or death!!
	level.scrsound["commissar2"]["victoryordeath"]		= "redsquare_commissar2_12";
	level.scr_face["commissar2"]["victoryordeath"]		= (%stalingrad_Commissar4_facial_9_victoryordeath);
	
	//16a. (Whistle sound)
	level.scrsound["commissar1"]["whistle"]			= "redsquare_whistle";
	level.scr_anim["commissar1"]["whistle"]			= (%Leader_whistleblow);
	
	//*** TRAITOR DIALOG
	
	//17. Stop those traitors!
	level.scrsound["commissar1"]["randomtraitor"]		= "redsquare_comm_defend";
	
	//18. Traitor!
	level.scrsound["commissar2"]["randomtraitor"]		= "redsquare_comm_defend";
	
	//19. Traitor! Traitor!
	level.scrsound["commissar3"]["randomtraitor"]		= "redsquare_comm_defend";
	
	//20. Kill him! Death to traitors!
	level.scrsound["commissar4"]["randomtraitor"]		= "redsquare_comm_defend";
	
	//21. Move damn you, move! Don't fall back!
	level.scr_anim["commissar3"]["movedamnyou"]		= (%commissar2_line_51_fullbody);
	level.scr_face["commissar3"]["movedamnyou"]		= (%facial_commissar2_line_51);
	level.scrsound["commissar3"]["movedamnyou"]		= ("commissar2_line51");
	
	/*
	
	//21. Do not retreat! Cowards and traitors will be shot!!
	level.scrsound["commissar1"]["donotretreat"]		= "redsquare_comm_defend";
	
	//22. Fire!!
	level.scrsound["commissar2"]["fireexcl"]		= "redsquare_comm_defend";
	
	//23. Kill the deserters! Open fire!
	level.scrsound["commissar1"]["killdeserters"]		= "redsquare_comm_defend";
	
	*/
	
	//*** CONSCRIPTS AT INTRO
	
	//24. It's no use! Fall back, comrades! Fall back!
	level.scrsound["conscript1"]["itsnouse"]		= "redsquare_conscript_intro1";
	level.scr_face["conscript1"]["itsnouse"]		= (%Redsquare_facial_Consc1_01_itsnouse);
	
	//25. Retreat! Retreat!
	level.scrsound["conscript2"]["retreatretreat"]		= "redsquare_conscript_intro2";
	level.scr_face["conscript2"]["retreatretreat"]		= (%Redsquare_facial_Consc2_02_retreatretreat);
	
	//26. We're getting slaughtered up there! Fall back!
	level.scrsound["conscript3"]["slaughteredupthere"]	= "redsquare_conscript_intro3";	
	level.scr_face["conscript3"]["slaughteredupthere"]	= (%Redsquare_facial_Consc1_03_slaughtered);
	
	//*** VLADIMIR THE FRIENDLY RUSSIAN GREETER
	
	//27. Hey Alexei!
	level.scrsound["vladimir"]["heyalexei"]			= "generic_greetplayerloud_russian_6";
	level.scr_face["vladimir"]["heyalexei"]			= (%Redsquare_facial_Clever_02_alexeioverthere);
}

#using_animtree("animation_rig_largegroup20");

largegroup()
{
	level.large_group["right"] = %redsquare_largegroup_rightside;
	level.large_group["left"] = %redsquare_largegroup_leftside;
}

#using_animtree("panzerIV");
tank()
{
	level.scr_animtree["tank"] = #animtree;
	level.scr_anim["tank"]["attack"]			= (%tigertank_hatchopencloseandrun_hatch);
	level.scr_anim["tank"]["root"] = %root;
}